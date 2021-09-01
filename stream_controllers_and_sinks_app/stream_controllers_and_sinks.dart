import 'dart:async';

void main() {
  final controller = new StreamController();

  final order = new Order('banana');

  //Baker
  final baker =
      new StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(new Cake());
    } else {
      sink.addError('I cant bake that type!');
    }
  });

  controller.sink.add(order); // Order taker
  controller.stream
      .map((order) => order.type) // Order inspector
      .transform(baker) // Baker
      .listen((cake) => print('Here is your cake $cake'), // Pickup office
          onError: (error) => print(error));
}

class Cake {}

class Order {
  String type;
  Order(this.type);
}
