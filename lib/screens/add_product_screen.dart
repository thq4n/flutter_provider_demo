import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_provider_demo/models/product.dart';
import 'package:flutter_provider_demo/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _icTitle = TextEditingController();
  final _icPrice = TextEditingController();

  Color? _selectedColor;
  Color? _pickerColor;

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () => {
          productsProvider.add(
            Product(
              title: _icTitle.text,
              price: int.tryParse(_icPrice.text) ?? 0,
              color: _selectedColor ?? Colors.white,
            ),
          ),
          Navigator.of(context).pop()
        },
      ),
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      controller: _icTitle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        label: Text('Price'),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _icPrice,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: _selectedColor ?? Colors.white,
                        onColorChanged: (color) => setState(() {
                          _pickerColor = color;
                        }),
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          setState(() => _selectedColor = _pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedColor ?? Colors.white,
                    border: Border.all(width: 2, color: Colors.black45),
                  ),
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
