import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/model/cars_model.dart';

class CarDetails extends StatelessWidget {
  final CarsModel car;
  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(car.name),
        backgroundColor: car.sold ? Colors.green[100] : Colors.red[100],
      ),
      backgroundColor: car.sold ? Colors.green[100] : Colors.red[100],
      body: Container(
        padding: const EdgeInsets.all(10),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 60, backgroundImage: AssetImage(car.photo)),
              SizedBox(height: 20),
              Text(car.name, style: textStyle),
              Text(car.brand, style: textStyle),
              Text(car.color, style: textStyle),
              Text(car.model.toString(), style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle textStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
