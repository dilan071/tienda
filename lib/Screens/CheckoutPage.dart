import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _cardHolder = '';
  String _expiry = '';
  String _cvv = '';
  int _selectedOption = 0; 

  void _submitPayment() {
    if (_selectedOption == 1 && !_formKey.currentState!.validate()) {
      return; 
    }

    if (_selectedOption == 1) {
      _formKey.currentState!.save();
      print('Número de tarjeta: $_cardNumber');
      print('Nombre: $_cardHolder');
      print('Expira: $_expiry');
      print('CVV: $_cvv');
    }

    // aui simulamos el proceso de pago y vaciar carrito
    Provider.of<CartProvider>(context, listen: false).clearCart();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Pago exitoso'),
        content: Text('¡Gracias por tu compra!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                ..pop() 
                ..pop(); 
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Método de pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: _selectedOption,
                    onChanged: (v) => setState(() => _selectedOption = v!),
                  ),
                  Text('Usar tarjeta guardada'),
                  Radio<int>(
                    value: 1,
                    groupValue: _selectedOption,
                    onChanged: (v) => setState(() => _selectedOption = v!),
                  ),
                  Text('Nueva tarjeta'),
                ],
              ),
              const SizedBox(height: 10),
              if (_selectedOption == 1) ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Número de tarjeta'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.length < 16 ? 'Número inválido' : null,
                  onSaved: (v) => _cardNumber = v ?? '',
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Nombre en la tarjeta'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Campo requerido' : null,
                  onSaved: (v) => _cardHolder = v ?? '',
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'MM/AA'),
                        validator: (v) =>
                            v == null || v.length != 5 ? 'Inválido' : null,
                        onSaved: (v) => _expiry = v ?? '',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'CVV'),
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.length != 3 ? 'Inválido' : null,
                        onSaved: (v) => _cvv = v ?? '',
                      ),
                    ),
                  ],
                ),
              ] else ...[
                ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.grey[700]),
                  title: Text('**** **** **** 1234'),
                  subtitle: Text('Visa (Guardada)'),
                ),
              ],
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: _submitPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Pagar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
