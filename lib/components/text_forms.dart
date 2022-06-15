import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  const TextForm(this.onSubmit, {Key? key}) : super(key: key);

  final void Function(String, double) onSubmit;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final titleControler = TextEditingController();

  final priceControler = TextEditingController();

  _submited() {
    final title = titleControler.text;
    final price = double.tryParse(priceControler.text) ?? 0.0;
    widget.onSubmit(title, price);
    if (title.isEmpty || price < 0) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleControler,
              decoration: const InputDecoration(
                focusColor: Colors.green,
                labelText: 'Nome do produto:',
                labelStyle: TextStyle(color: Colors.green),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.green,
                )),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            TextField(
              controller: priceControler,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submited(),
              decoration: const InputDecoration(
                labelText: 'Preço do produto (R\$):',
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    final title = titleControler.text;
                    final price = double.tryParse(priceControler.text) ?? 0.0;
                    widget.onSubmit(title, price);
                  },
                  label: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
