class Transaction {
  late String id;
  late String title;
  late double price;
  late double fixedValue;
  late int stack;
  late DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.price,
      required this.fixedValue,
      required this.stack,
      required this.date});
}
