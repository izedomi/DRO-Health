
import 'package:DRHealth/controllers/data_store.dart';
import 'package:DRHealth/model/product.dart';
import 'package:DRHealth/shared/helpers/dialog_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class ProductDetailScreen extends StatefulWidget {

  final Product product;
  final BagStore bagStore;
  ProductDetailScreen({this.product, this.bagStore});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

   Color droGreen = Color(0xff0CB8B6);
   int qty = 1;
   final numberFormat = new NumberFormat("#,##0", "en_US");

  void increaseQty(){
    setState(() => qty = qty + 1);
  }

  void decreaseQty(){
    if(qty == 1) return;
    setState(() => qty = qty - 1);
  }

  @override
  Widget build(BuildContext context) {
     
     double deviceWidth = MediaQuery.of(context).size.width;
     double deviceHeight = MediaQuery.of(context).size.height;
     Color droGreen = Color(0xff0CB8B6);

     return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 18, right: 18, bottom: 8.0),
          child: Stack(
              children:[
                Container(
                height: deviceHeight,
                width: deviceWidth,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.black87,),
                                onPressed: () => Navigator.pop(context)
                              ),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, '/bag_screen'),
                                  child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      //BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                                    ]
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18.0),
                                      SizedBox(width: 1.0),
                                      Text(widget.bagStore.getTotalBagItemsCount().toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                       //Text('', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                    ]
                                  
                                  )
                                ),
                              )
                            ]
                          ),
                          Container(
                            height: 180,
                            width: 120,
                            child: ClipRRect(
                               borderRadius: BorderRadius.circular(6),
                                child: Image(
                                image: AssetImage(widget.product.image),
                                fit: BoxFit.cover
                              ),
                            )
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.title1, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(widget.product.type, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 12)),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500],
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        //BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                                      ]
                                    ),
                                  ),
                                  SizedBox(width: 18.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("SOLD BY", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text(widget.product.distributor, style: TextStyle(color: droGreen, fontWeight: FontWeight.bold, fontSize: 12))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(width: 1, color: Colors.grey[300])
                                        ),      
                                        child: Row(
                                          children: [
                                              GestureDetector(
                                                onTap: (){decreaseQty();},
                                                child: Icon(Icons.remove)
                                              ),
                                              SizedBox(width: 20),
                                              Text(qty.toString()),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: (){increaseQty();},
                                                child: Icon(Icons.add)
                                              )
                                          ]
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(qty == 1 ? "Pack" : "Packs", style: TextStyle(color: Colors.grey[500], fontSize: 12))
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: WidgetSpan(
                                        child: Transform.translate(
                                            offset: const Offset(2, -4),
                                            child: Text(
                                              '₦',
                                              //superscript is usually smaller in size
                                              textScaleFactor: 0.6,
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                     
                                      Text(
                                        numberFormat.format(double.parse((qty * widget.product.price).toString())), 
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                                      ),
                                      
                                    ],
                                  ),
                                  
                                ],
                              ),
                              SizedBox(height: 30),
                              Text("PRODUCT DETAILS", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: buildX(Icons.fullscreen_outlined, "PACK SIZE", widget.product.packSize)
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: buildX(Icons.center_focus_weak, "PRODUCT ID", widget.product.productId),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),
                              buildX(Icons.nfc_outlined, "CONSTITUENTS", widget.product.constituents),
                              SizedBox(height: 14),
                              buildX(Icons.inventory, "DISPENSED IN", widget.product.dispensedIn),
                            ],
                          ),
                          SizedBox(height: 36),
                          Text("${qty.toString()} ${widget.product.title1} selected", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold) ),
                      ],
                    ),
                  ),
                ),  
                Positioned(
                  bottom: 0,
                  left: (deviceWidth - 250) / 2.5,
                  child:  GestureDetector(
                      onTap: (){
                          widget.bagStore.addProductToBag(widget.product, qty);
                          showDialogModal(
                            context: context,
                            msg: "${widget.product.title1} has been added to your bag",
                            action: "ADD_TO_BAG"
                          );
                      },
                      child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 250,
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          //BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20.0),
                          SizedBox(width: 12.0),
                          Text("Add To Bag", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12))
                        ]
                      
                      )
                    ),
                  )
                )         
              ] 
          ),
        )   
    );
  }

  Widget buildX(IconData icon, String title, String subTitle){
    return  Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 10)),
            Text(subTitle, style: TextStyle(color: droGreen, fontWeight: FontWeight.bold, fontSize: 10))
          ],
        )
      ],
    );
  }
  
  
  
}