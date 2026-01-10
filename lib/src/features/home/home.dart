import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appAssets.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/features/home/car_details.dart';
import 'package:login_signin_screens/src/model/cars_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CarsModel> car = [
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'Grey',
      model: 2018,
      photo: car1,
      sold: false,
    ),
    CarsModel(
      name: 'Civic',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car2,
      sold: false,
    ),
    CarsModel(
      name: 'Supra',
      brand: "Toyota",
      color: 'Mate Grey',
      model: 2018,
      photo: car3,
      sold: true,
    ),
    CarsModel(
      name: 'Camry',
      brand: "Toyota",
      color: 'Yellow',
      model: 2018,
      photo: car4,
      sold: false,
    ),
    CarsModel(
      name: 'Corolla',
      brand: "Toyota",
      color: 'White',
      model: 2018,
      photo: car5,
      sold: true,
    ),
    CarsModel(
      name: 'Mehran',
      brand: "Suzuki",
      color: 'Black',
      model: 2018,
      photo: car6,
      sold: true,
    ),
    CarsModel(
      name: 'BMW',
      brand: "BMW",
      color: 'White',
      model: 2018,
      photo: car7,
      sold: false,
    ),
    CarsModel(
      name: 'M3',
      brand: "BMW",
      color: 'Red',
      model: 2018,
      photo: car8,
      sold: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 2,
          ),
          itemCount: car.length,
          itemBuilder: (BuildContext context, int index) {
            CarsModel myCars = car[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetails(car: myCars),
                  ),
                );
              },
              child: Container(
                height: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lightOrangeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(myCars.photo),
                      ),
                      Text(
                        myCars.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        myCars.brand,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        myCars.color,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(myCars.model.toString()),
                      Icon(
                        myCars.sold ? Icons.check : Icons.close,
                        color: myCars.sold ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
