import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
 //numbers should be changed dynamically
 String number1 = ""; // 0-9
 String operand = ""; // + - / 
 String number2 = ""; // 0-9

  @override
  Widget build(BuildContext context) {

    //set the screen size according to ui
    final screenSize= MediaQuery.of(context).size;

    //buid the ui by creating a scafold
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
             //output
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),

              //check if empty and displaysomething
              child:  Text("$number1 $operand $number2 ".isEmpty?"0" : "$number1 $operand $number2",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              
              
              ),
            ),
          ),
        ),
        
        //buttons
        Wrap(
              //from each button value mapped, create new widget or method(buildButton)
          children: Btn.buttonvalues

          //wrap the build button in sizebox widget widget
          .map((value) => SizedBox(

            //make the 0 button to take 2 spaces, by checking condition with ?

            width:value==Btn.n0?screenSize.width/2: (screenSize.width /4),
            height: screenSize.width/5,
            child: buildButton(value)),
          )
          .toList(),


        )




        ]
        
           ),
      )
    );
  }



 //create build button method/function and return widget
  Widget buildButton(value){
    
    //wrap each button with center widget
    //wrap the button with inkwell to be tapable
    //wrap inkwell with material widget for styling
    //wrap the material widget with padding to make buttons separate
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
       //make click behavior within button
        //group certain buttons to have own color

      

        color: getBtnColor(value), //calls the getBtnColor function
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100)),
        child: InkWell(

       
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(value,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
        ),
      ),
    );



  }

        //#########################################################
   //receive the string value
   //configure the ontap function (onBtnTap)
  
// show something when tapped
void onBtnTap(String value) {
  // lets check if the delete button is clicked
  if(value==Btn.del){

    //create delete function
    delete();
    return;
  }
    //check if tapped button is Btn.clr
    if(value == Btn.clr){
      //create function clearAll
      clearAll();
      return;

    }

     //check if tapped button is Btn.% or per
    if(value == Btn.per){
      //create function convertToPercentage
      convertToPercentage();
      return;

    }

    if(value == Btn.calculate){
      //create function calculate
      calculate();
      return;
    }

   appendValue(value);
}

//#######################################
//calculate the result

void calculate(){

  if(number1.isEmpty)
  return;
  if(operand.isEmpty)
  return;
  if(number2.isEmpty)
  return;

//create three variables
 
final double num1 = double.parse(number1);
final double num2 = double.parse(number2);

var result = 0.0;

switch(operand){

case Btn.addition:
result = num1 + num2;
break;

case Btn.subtract:
result = num1 - num2;
break;

case Btn.multiply:
result = num2 * num1;
break;

case Btn.divide:
result = num2 / num1;
break;
default:

}

setState(() {
  number1 = "$result";

//check if number1 ends with .0, modifify.....it will make whole number
  if(number1.endsWith(".0")){
    number1 = number1.substring(0, number1.length -2);
  }
 //reset in readiness for another operation or equation
  operand = "";
  number2 = "";
});

}

//######################################

//#######################
//function that clears all output
void clearAll(){
  setState(() {
    number1 = "";
    operand = "";
    number2 = "";
  });
}

//#######################
//function that converts output to
void convertToPercentage(){
  //check if number1 operand number2 are not empty
  //ex:47588+9840
  if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty)
  {
    //calculate before conversion
    //TODO
    // final res = number1 operand number2;
    // number1 = res;
      calculate();
  }
  if(operand.isNotEmpty)
  {
    // cannot be converted
    return;

  }

  //get our number, which is number 1
  //chage the number to double
  final number = double.parse(number1);

  setState(() {
    number1 = "${(number/100)}";
    //reset the operand, and number2
    operand = "";
    number2 = "";
  });
}
//###################
//delete one from the end
void delete(){
 //check if number 2 is empty, if not delete
 //example : 4567 => 456
 if(number2.isNotEmpty){
  number2=number2.substring(0,number2.length - 1);

 } else if(operand.isNotEmpty){
  operand = "";
 }
 
 //check if number 1 is empty, if not delete
 //example : 4567 => 456
 else if(number1.isNotEmpty){
  number1=number1.substring(0,number1.length - 1);

 }


 //then set new state
 setState(() {
   
 });


}

//######################################
// appends value to the end
void appendValue(String value){

// number1 operand number2
    // 12         +     869

    //first check if the number is not a number

    //if operand and not "."
  if(value!=Btn.dot && int.tryParse(value)==null){
    //operand pressed
      if(operand.isNotEmpty&&number2.isNotEmpty){

        //ToDO calculate the equation before assigning new operand
        calculate();

      }
            operand = value;
    } 
    // assign value to number1 variable
    else if(number1.isEmpty || operand.isEmpty){
          //check if value is "."
          // ex: number1 = "1.2"
      if(value==Btn.dot && number1.contains(Btn.dot)) return;
      if(value==Btn.dot && (number1.isEmpty || number1==Btn.n0)) {
        //number1 = "" | "0"

        //change to 0.
        value = "0.";
      }
        //then assign the value
        number1 += value;
    }

    else if(number2.isEmpty || operand.isNotEmpty){

      if(value==Btn.dot && number2.contains(Btn.dot)) return;
      if(value==Btn.dot && (number2.isEmpty || number2==Btn.n0)) {
        //number2 = "" | "0"

        //change to 0.
        value = "0.";
      }
        //then assign the value
        number2 += value;
    }
  setState(() {
   
  });
  




}

  //create function that returns color of button value
  Color getBtnColor(value){

    return  [Btn.del,Btn.clr].contains(value)?Colors.blueGrey
        :   //check condition with .contains? and else(:)
        [Btn.per,
        Btn.multiply,
        Btn.addition,
        Btn.subtract,
        Btn.divide,
        Btn.calculate,
      
        ].contains(value)?Colors.orange: Colors.black87; 
  }
  

}

