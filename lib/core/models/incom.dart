import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Incom {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String category;

  @HiveField(2)
  String title;

  @HiveField(3)
  int amount;

  Incom({
    required this.id,
    required this.category,
    required this.title,
    required this.amount,
  });
}

class IncomAdap extends TypeAdapter<Incom> {
  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, Incom obj) {
    writer.write(obj.id);
    writer.write(obj.category);
    writer.write(obj.title);
    writer.write(obj.amount);
  }

  @override
  Incom read(BinaryReader reader) => Incom(
      id: reader.read(),
      category: reader.read(),
      title: reader.read(),
      amount: reader.read());
}
