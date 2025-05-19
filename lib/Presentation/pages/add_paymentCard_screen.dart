import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utility/navigation_helper.dart';
import '../../data/model/PaymentCard.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _paymentCard = PaymentCard();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationHelper.navigateToPage(context, 0);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF543A20),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white, size: 24.r),
            onPressed: () => NavigationHelper.navigateToPage(context, 0),
            iconSize: 24.r,
            padding: EdgeInsets.all(8.r),
            constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
          ),
          title: Text(
            'Add card',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/mastercard.png',
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 40.h),
                _buildCardHolderNameField(),
                SizedBox(height: 20.h),
                _buildCardNumberField(),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(child: _buildExpiryDateField()),
                    SizedBox(width: 20.w),
                    Expanded(child: _buildCVVField()),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildSaveCardCheckbox(),
                SizedBox(height: 40.h),
                _buildAddCardButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHolderNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Holder name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)), // 0.5 * 255 = 128
            filled: true,
            fillColor: Colors.white.withAlpha(26), // 0.1 * 255 = 26
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card holder name';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _paymentCard.cardHolderName = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: '8763 2736 9873 0329',
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)), // 0.5 * 255 = 128
            filled: true,
            fillColor: Colors.white.withAlpha(26), // 0.1 * 255 = 26
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            _CardNumberFormatter(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            }
            if (value.replaceAll(' ', '').length != 16) {
              return 'Please enter valid card number';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _paymentCard.cardNumber = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildExpiryDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: '28/22',
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)), // 0.5 * 255 = 128
            filled: true,
            fillColor: Colors.white.withAlpha(26), // 0.1 * 255 = 26
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
            _ExpiryDateFormatter(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter expiry date';
            }
            if (value.length != 5) {
              return 'Please enter valid expiry date';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _paymentCard.expiryDate = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCVVField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CVV',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: '000',
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)), // 0.5 * 255 = 128
            filled: true,
            fillColor: Colors.white.withAlpha(26), // 0.1 * 255 = 26
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CVV';
            }
            if (value.length != 3) {
              return 'Please enter valid CVV';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _paymentCard.cvv = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSaveCardCheckbox() {
    return Row(
      children: [
        Transform.scale(
          scale: 1.2.r,
          child: Checkbox(
            value: _paymentCard.saveCard,
            onChanged: (value) {
              setState(() {
                _paymentCard.saveCard = value ?? false;
              });
            },
            fillColor: WidgetStateProperty.resolveWith(
              (states) => const Color(0xFFCE9760),
            ),
          ),
        ),
        Text(
          'Save Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAddCardButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Handle card addition
            if (_paymentCard.isValid()) {
              // Process the card
              Navigator.pop(context, _paymentCard);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCE9760),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: Text(
          'ADD CARD',
          style: TextStyle(
            color: const Color(0xFF543A20),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    return TextEditingValue(
      text: PaymentCard.formatCardNumber(newValue.text),
      selection: TextSelection.collapsed(
        offset: PaymentCard.formatCardNumber(newValue.text).length,
      ),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    return TextEditingValue(
      text: PaymentCard.formatExpiryDate(newValue.text),
      selection: TextSelection.collapsed(
        offset: PaymentCard.formatExpiryDate(newValue.text).length,
      ),
    );
  }
}
