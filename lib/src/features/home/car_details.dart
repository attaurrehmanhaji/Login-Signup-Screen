import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/model/cars_model.dart';

class CarDetails extends StatelessWidget {
  final CarsModel car;
  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: car.sold ? Colors.green[100] : Colors.red[100],
      body: Container(
        padding: const EdgeInsets.all(10),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 60, backgroundImage: AssetImage(car.photo)),
              Text(car.name),
              Text(car.brand),
              Text(car.color),
              Text(car.model.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
