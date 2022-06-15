import 'package:flutter/material.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.onRemove, this.valueAlteration,
      {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final void Function(String, double, double) valueAlteration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'A lista está vazia.',
                      style: TextStyle(fontSize: 50, color: Colors.black12),
                    ),
                  ),
                  Icon(
                    Icons.view_list_sharp,
                    size: 80,
                    color: Colors.black12,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  child: ExpansionTile(
                    expandedAlignment: Alignment.center,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    textColor: Colors.red,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        child: ListTile(
                          title: Text(
                            'Valor inicial: ${tr.fixedValue.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () => onRemove(tr.id),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                    leading: SizedBox(
                      //maxRadius: 25,
                      //backgroundColor: Colors.white,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            'R\$ ${tr.price.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                double code = 1;
                                valueAlteration(tr.id, code, tr.fixedValue);
                              },
                              icon:
                                  const Icon(Icons.do_not_disturb_on_outlined),
                              color: Colors.green,
                            ),
                            Text(
                              tr.stack.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                double code = 0;
                                valueAlteration(tr.id, code, tr.fixedValue);
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
