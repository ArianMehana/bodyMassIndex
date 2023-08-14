import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

enum Gender{
  MALE,
  FEMALE,
  NONE
}

class _MyAppState extends State<MyApp> {

  int heightValue = 125;
  int weightValue = 75;
  int ageValue = 25;

  Gender genderValue = Gender.NONE;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            GestureDetector(
              onTap:(){
                this.setState(() {
                  genderValue = Gender.MALE;

                });
              } ,
                child: GenderPage(genderTitle: "Male", genderIcon: Icons.male,genderColor: genderValue == Gender.MALE? Colors.deepPurple : Colors.lightBlue,)),
              GestureDetector(
                onTap: (){
                  this.setState(() {
                    genderValue = Gender.FEMALE;
                  });
                },
                  child: GenderPage(genderTitle: "Female", genderIcon: Icons.female,genderColor: genderValue == Gender.FEMALE? Colors.deepPurple : Colors.lightBlue)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             heightPage(changedHeightValue: (value){
               heightValue = value;
             },),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weightPage(changedWeightValue: (value){
                weightValue = value;
              },),
              agePage(ageValue: (value){
                ageValue = value;
              },
              )
            ],
          ),
          GestureDetector(
            onTap: (){
              BMIHelp bmi = BMIHelp(weightValue: weightValue, heightValue: heightValue);
              print("Calculate BMI");
              print(bmi.getBMIValue());
              print(bmi.getResult());
              print(bmi.getDescription());

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ResultPage(bmiValue: bmi.getBMIValue(), bmiResult: bmi.getResult(), bmiDescription: bmi.getDescription());
              }));
            },
            child: Container(
              child: Center(
                child: Text("CALCULATE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60
                ),),
              ),
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  String bmiValue="";
  String bmiResult = "";
  String bmiDescription = "";
  ResultPage({
    required this.bmiValue,
    required this.bmiResult,
    required this.bmiDescription
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Results"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(this.bmiValue, style: TextStyle(
            fontSize: 35.0,
            color: Colors.green
          ),),
          Text(this.bmiResult,style: TextStyle(
            fontSize: 35.0,
            color: Colors.green
          ),),
          Text(this.bmiDescription, style: TextStyle(
            fontSize: 35.0,
            color: Colors.green
          ),)
        ],
      ),
    );
  }
}



class BMIHelp{
  int weightValue = 0;
  int heightValue = 0;
  double _bmi = 0.0;
  BMIHelp({required this.weightValue, required this.heightValue}){
    _bmi = weightValue / pow(heightValue/100, 2);
  }

  String getBMIValue(){
    return _bmi.toStringAsFixed(2);
  }

  String getResult(){
    if(_bmi < 25){
      return "Normal";
    }
    else if(_bmi >= 30)
      {
        return "Obese";
      }
    else
      return "Overweight";
  }

  String getDescription(){
    if (_bmi < 25){
      return "Excellent, your body is within normal measurements";
    }
    else if(_bmi >=30){
      return "You need to hit the gym and cut back in calories ASAP!";
    }
    else
      return "You need some exercuse, going to gym or walking/running on a daily basis";
  }
}

class GenderPage extends StatelessWidget {

  String genderTitle = "";
  late IconData genderIcon;
  Color genderColor;

  GenderPage({required this.genderTitle, required this.genderIcon, required this.genderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(
          color: genderColor,
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(genderIcon, size: 45.0,color: Colors.white,),
          SizedBox(height: 10,),
          Text("$genderTitle",style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
          ),)
        ],
      ),
    );
  }
}

class heightPage extends StatefulWidget {

  final Function(int value) changedHeightValue;

  heightPage({required this.changedHeightValue});


  @override
  State<heightPage> createState() => _heightPageState();
}

class _heightPageState extends State<heightPage> {


  double height_value = 125.0;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(12.0)
      ),
      width: 380,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Height",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                height_value.round().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold
              ),),
              Text("cm",style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,

              ),)
            ],
          ),
          Slider(
            value: height_value,
            label: height_value.round().toString(),
            divisions: 120,
            onChanged: (value){
            this.setState(() {
              height_value = value;
            });
            widget.changedHeightValue(height_value.toInt());
          },
            activeColor: Colors.white,
            inactiveColor: Colors.black26,
            min: 100,
            max: 220,
          )
        ],
      ),
    );
  }
}

class weightPage extends StatefulWidget {
    final Function(int value) changedWeightValue;
    weightPage({required this.changedWeightValue});


  @override
  State<weightPage> createState() => _weightPageState();
}

class _weightPageState extends State<weightPage> {

  int weight = 75;

  changeWeightValue(int newValue){
    if((newValue == -1 && weight > 50) || (newValue == 1 && weight <200) ) {
      weight = weight + newValue;
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 175,
      height: 175,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("WEIGHT",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
          Text("$weight kg",style: TextStyle(
              fontSize: 35.0,
              color: Colors.white
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),onPressed: (
                  ){
                this.setState(() {
                  changeWeightValue(/**/1);
                });
                widget.changedWeightValue(weight);
              }, child: Text("+",
                style: TextStyle(
                    fontSize: 25.0
                ),)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),onPressed: (){
                    this.setState(() {
                      changeWeightValue(-1);
                    });
                    widget.changedWeightValue(weight);
              }, child: Text("-",
                style: TextStyle(
                    fontSize: 25.0
                ),)),

            ],
          )
        ],
      ),
    );
  }
}

class agePage extends StatefulWidget {

  final Function(int value) ageValue;

  agePage({required this.ageValue});


  @override
  State<agePage> createState() => _agePageState();
}

class _agePageState extends State<agePage> {

  int age = 25;

  changeAgeValue(int ageValue){
    if((ageValue == -1 && age > 18) || (ageValue == 1 && age <65) ) {
      age = age + ageValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 175,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("AGE",
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          Text("$age",style: TextStyle(
              fontSize: 35.0,
              color: Colors.white
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),onPressed: (
                  ){
                this.setState(() {
                  changeAgeValue(1);
                });
                widget.ageValue(age);
              }, child: Text("+",
                style: TextStyle(
                    fontSize: 25.0
                ),)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),onPressed: (){
                this.setState(() {
                  changeAgeValue(-1);
                });
                widget.ageValue(age);
              }, child: Text("-",
                style: TextStyle(
                    fontSize: 25.0
                ),)),
            ],
          )
        ],
      ),
    );
  }
}




