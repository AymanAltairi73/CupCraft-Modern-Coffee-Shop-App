import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/PaymentCard.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF543A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/mastercard.png'),
              const SizedBox(height: 40),
              _buildCardHolderNameField(),
              const SizedBox(height: 20),
              _buildCardNumberField(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildExpiryDateField()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildCVVField()),
                ],
              ),
              const SizedBox(height: 20),
              _buildSaveCardCheckbox(),
              const SizedBox(height: 40),
              _buildAddCardButton(),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildCardHolderNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Holder name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
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
        const Text(
          'Card Number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '8763 2736 9873 0329',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
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
        const Text(
          'Expiry',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '28/22',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
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
        const Text(
          'CVV',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '000',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
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
        Checkbox(
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
        const Text(
          'Save Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'ADD CARD',
          style: TextStyle(
            color: Color(0xFF543A20),
            fontSize: 16,
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