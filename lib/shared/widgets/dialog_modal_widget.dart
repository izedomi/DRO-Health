
import 'package:flutter/material.dart';

class AddToBagDialog extends StatelessWidget {

  final String title;
  final String action;
  AddToBagDialog(this.title, this.action);

  @override
  Widget build(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildAlert(context),
      );
  }


  _buildAlert(BuildContext context){
     return Stack(
       children: [
           Container(
             height: 400,
             width: 250,
             child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(),                   
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                       padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                       decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Successful", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0),
                            Text(title,
                            style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.0),
                            action == "ADD_TO_BAG" ? GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/bag_screen'),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  color: Theme.of(context).accentColor,
                                  width: double.infinity,
                                  child: Text("View Bag", style: TextStyle(color: Colors.white),),
                                ),
                            ):Container(),
                            SizedBox(height: 8.0),
                            GestureDetector(
                                onTap: (){
                                  if(action == "CHECKOUT"){
                                      Navigator.pushNamed(context, '/products_screen');
                                  }
                                  else{
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  color: Theme.of(context).accentColor,
                                  width: double.infinity,
                                  child: Text("Done", style: TextStyle(color: Colors.white),),
                                ),
                            ),
                           
                          ],
                        ),
                    ),                   
                  ),
                ],
              )
           ),
           Positioned(
              top: 400 / 2.4,
              left: 250 / 3,
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(width: 5, color: Colors.white),
                      boxShadow: [
                        BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                      ]
                  ),
                  child: Icon(Icons.done_outlined, color: Colors.white, size: 45,),
              ),               
           )
       ],
     );
  }

}
