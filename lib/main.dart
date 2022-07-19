import 'dart:math';
import 'package:controle_app/components/text_forms.dart';
import 'package:controle_app/screens/graph_screen.dart';
import 'package:flutter/material.dart';
import './components/text_forms.dart';
import 'components/transaction.dart';
import 'components/transaction_list.dart';

main() => runApp(const ControleApp());

class ControleApp extends StatelessWidget {
  const ControleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(225, 224, 220, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.red,
          secondary: Colors.green,
          brightness: Brightness.light,
        ),
        fontFamily: 'OpenSans',
      ),
      home: const MyHomePage(),
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
    final Transaction item = Transaction(
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

  void _graphScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const GraphScreen(
          key: null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sum = _transactions.fold(0, (prev, tr) => prev + tr.price);
    double widthContainerBar = MediaQuery.of(context).size.width * 0.65;
    double heightContainerBar = 120;

    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 242, 254, 236),
      key: scaffoldState,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        title: const Text(
          'Controle de Vendas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .80,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .75,
                        child: TransactionList(
                            _transactions, _removeItem, _itemAlt),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _graphScreen(context),
              child: Container(
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(200),
                ),
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Transform.scale(
                    scale: 1.3,
                    child: const Icon(
                      Icons.poll_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _modalTextForm(context),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(200),
                ),
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Transform.scale(
                    scale: 1.3,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            start:
                MediaQuery.of(context).size.width * 0.5 - widthContainerBar / 2,
            bottom: -42,
            child: Container(
              child: Column(
                children: [
                  const Text(
                    'Total das vendas: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'R\$${sum.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              width: widthContainerBar,
              height: heightContainerBar,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
