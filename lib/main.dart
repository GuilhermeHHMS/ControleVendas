import 'dart:math';
import 'package:controle_app/components/text_forms.dart';
import 'package:flutter/material.dart';
import './components/text_forms.dart';
import 'components/transaction.dart';
import 'components/transaction_list.dart';

main() => runApp(const ControleApp());

class ControleApp extends StatelessWidget {
  const ControleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final scaffoldState = GlobalKey<ScaffoldState>();

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addItem(String title, double value) {
    final item = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      price: 0,
      fixedValue: value,
      date: DateTime.now(),
      stack: 0,
    );
    setState(() {
      _transactions.add(item);
      _transactions.sort((a, b) => a.title.compareTo(b.title));
    });

    Navigator.of(context).pop();
  }

  void _removeItem(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _itemAlt(String id, double code, double fixedValue) {
    setState(() {
      for (var tr in _transactions) {
        if (code == 0) {
          if (id == tr.id) {
            tr.price += fixedValue;
            tr.stack++;
          }
        } else {
          if (id == tr.id) {
            tr.price -= fixedValue;
            tr.stack--;
          }
        }
      }
    });
  }

  void _modalTextForm(BuildContext context) {
    scaffoldState.currentState!;
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TextForm(_addItem);
        });
  }

  @override
  Widget build(BuildContext context) {
    double sum = _transactions.fold(0, (prev, tr) => prev + tr.price);

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(33),
        ),
        title: const Text('Controle de Vendas'),
      ),
      body: Stack(
        children: [
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .63,
                          child: TransactionList(
                              _transactions, _removeItem, _itemAlt),
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.values.first,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total das vendas: ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$${sum.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(200),
              ),
              height: 100,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(15.2),
                child: IconButton(
                  iconSize: 30,
                  onPressed: () => _modalTextForm(context),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      //floatingActionButton: FloatingActionButton(
      //elevation: 0,
      //onPressed: () => _modalTextForm(context),
      //child: const Icon(Icons.add),
      // backgroundColor: Colors.green,
      //),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
