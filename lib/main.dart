import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final navigatorKey = GlobalKey<NavigatorState>();
  //resolves materiallocalizations on showing alert/dialog from AppBar
  void showAbout() {
    final context = navigatorKey.currentState.overlay.context;
    
    showDialog(context: context, builder: (x) => AboutWidget());
  }

  void showConversion() {
    final context = navigatorKey.currentState.overlay.context;
    String text;
    
    showDialog(context: context, builder: (x) => ConversionWidget());
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text("BMI Calculator")]),
            
              leading:
                IconButton(
                    tooltip: 'About',
                    icon: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    onPressed: (){showAbout();},
                ),
                actions: [
                    IconButton(
                    tooltip: 'About',
                    icon: const Icon(
                      Icons.launch,
                      color: Colors.white,
                    ),
                    onPressed: (){showConversion();},
                ),
                ],  
                     /* =>  showDialog(
                          context: context,
                          builder: (BuildContext context) =>AboutWidget()
                            
                          )*/
                    
              
            ),
            body: BMICalculatorScreen()
            )
            
          );
  }
}
class ConversionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController ftTextController=TextEditingController();
    TextEditingController cmTextController=TextEditingController();

          return Dialog(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
                
                child: Container(
                  height: 300,
                  child: Center(
                    child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               
                                Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text( 'Feet to Centimeters',
                                  style:
                                      Theme.of(context).textTheme.headline5)
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(children: [
                                    Expanded(child: TextField(
                                       controller: ftTextController,
                                       
                                      onChanged: (text){
                                      // cmTextController.text=text;
                                      cmTextController.text=(double.parse(text)*30.48).toString();
                                                                          },
                                       
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                        hintText: 'feet',  
                                        
                                        focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple)))
                                    )
                                    ),
                                    SizedBox(width:20),
                                    Expanded(child: TextField(
                                        controller: cmTextController,
                                        textAlign: TextAlign.center,
                                        
                                        decoration: InputDecoration(
                                        hintText: 'centimeter',  
                                        focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple)))
                                    )
                                    ),
               
                                  ],)  
                                ),
                                 Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(children: [
                                    Expanded(child: RaisedButton(
                                       elevation: 0.9,
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,cmTextController.text);
                                },
                                color: Colors.purple,)),
                                SizedBox(width:20),
                                Expanded(child: RaisedButton(
                                       elevation: 0.9,
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.purple,))
                                  ],)
                                  )
                              ],
                              )
                          )
                    ),
                  )
                ),
          );
  }

 

}
class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                              title: Text(
                                'Marverick Pointers Inc.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal),
                              ),
                              contentPadding: const EdgeInsets.all(6.0),
                              content: Text(
                                'Version 1.0.0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic),
                              ),
                              actions: [
                                FlatButton(
                                  color: Colors.purple,
                                  
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                
                              ],
                            );
  }
  
}
class BMICalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: BMICalculator(),
          ),
        ),
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  double formProgress = 0;
  double height = 0;
  double weight = 0;
  double bmi = 0;
  String name;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  bool good = true;
  String idealWeight(double height) {
    double range1, range2;
    height = height / 100;
    range1 = 18.5 * height * height;
    range2 = 24.9 * height * height;
    return 'Your Normal Weight range is ' +
        range1.toStringAsPrecision(2) +
        'kg to ' +
        range2.toStringAsPrecision(2) +
        'kg';
  }

  String dialogSuggestionContent(String name, String bmi) {
    double vbmi = double.parse(bmi);
    if (vbmi < 16.0) {
      good = false;
      return name + ' you are Severely Underweight. Take care of your health.';
    } else if (vbmi >= 16.0 && vbmi <= 18.4) {
      good = false;
      return name +
          ' you are Underweight. You need to work a bit more on yourself.';
    } else if (vbmi >= 18.5 && vbmi <= 24.9) {
      good = true;
      return name + ' you are Normal. Keep up the good work.';
    } else if (vbmi >= 25.0 && vbmi <= 29.9) {
      good = false;
      return name + ' you are Overweight. Need to take some steps.';
    } else if (vbmi >= 30.0 && vbmi <= 34.9) {
      good = false;
      return name + ' you are Moderately Obese. You are in health risk zone.';
    } else if (vbmi >= 35.0 && vbmi <= 39.9) {
      good = false;
      return name +
          ' you are Severely Obese. You need to seriously take your health.';
    } else {
      good = false;
      return name +
          ' you are  Morbidly Obese. It is now or Never. May God be with you.';
    }
  }

  createBmiDialog(
      BuildContext context, double bmi, String name, double height) {
    TextEditingController bmiTextController = TextEditingController();
    TextEditingController suggestTextController = TextEditingController();
    TextEditingController idealTextController = TextEditingController();
    TextEditingController idealBMITextController = TextEditingController();

    bmiTextController.text = bmi.toStringAsFixed(2);
    String finalName = " ";
    for (String i in name.split(" "))
      finalName = finalName + " " + capitalize(i);
    idealTextController.text = idealWeight(height);
    idealBMITextController.text =
        'Your Ideal BMI should be in the range of 18.5 to 24.9.';
    suggestTextController.text =
        dialogSuggestionContent(finalName, bmi.toStringAsFixed(2));
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                height: 540,
                child: Center(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Image.asset(
                                  good
                                      ? 'assests/images/thumbs-up-xxl.png'
                                      : 'assests/images/thumbs-down-xxl.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center)),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(finalName + ' Your BMI',
                                  style:
                                      Theme.of(context).textTheme.headline5)),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: TextField(
                                controller: bmiTextController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple))),
                                enabled: false,
                              )),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: AutoSizeText(
                                suggestTextController.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: AutoSizeText(
                                idealTextController.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: AutoSizeText(
                                idealBMITextController.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(
                              width: 320.0,
                              child: RaisedButton(
                                elevation: 0.9,
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  heightTextController.clear();
                                  nameTextController.clear();
                                  weightTextController.clear();
                                  Navigator.of(context).pop();
                                },
                                color: Colors.purple,
                              ))
                        ]),
                  ),
                ))));
      },
    );
  }

  double calculateBmi(double height, double weight) {
    double mheight = (height / 100);
    return double.parse((weight / (mheight * mheight)).toStringAsPrecision(2));
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,

      body: Center(
          child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(
                          value: formProgress,
                          backgroundColor: Colors.purple),
                      Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Image.asset('assests/images/bmi.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                              alignment: Alignment.center)),
                      Text('Provide Your Information',
                          style: Theme.of(context).textTheme.headline5),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameTextController,
                          decoration: InputDecoration(
                              hintText: 'Your Name',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: heightTextController,
                          decoration: InputDecoration(
                              hintText: 'Height in cm',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          validator: (value) {
                            if (value.isEmpty || double.parse(value).isNaN) {
                              return 'Please enter valid height';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: weightTextController,
                          decoration: InputDecoration(
                              hintText: 'Weight in kg',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          validator: (value) {
                            if (value.isEmpty || double.parse(value).isNaN) {
                              return 'Please enter valid weight';
                            }
                            return null;
                          },
                        ),
                      ),
                      MaterialButton(
                        color: Colors.purple,
                        textColor: Colors.white,
                        elevation: 0.5,
                        minWidth: 320.0,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            height = double.parse(
                                heightTextController.text.toString());
                            weight = double.parse(
                                weightTextController.text.toString());
                            name = nameTextController.text.toString();
                            //height = 3.28 * height;
                            bmi = calculateBmi(height, weight);

                            createBmiDialog(context, bmi, name, height);
                          }
                        },
                        child: Text('Result'),
                      ),
                    ],
                  )))),
    );
  }
}
// #enddocregion MyApp
