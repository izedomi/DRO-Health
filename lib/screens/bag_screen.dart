
import 'package:DRHealth/controllers/data_store.dart';
import 'package:DRHealth/model/bag_item.dart';
import 'package:DRHealth/shared/helpers/dialog_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BagScreen extends StatefulWidget {

  final BagStore bagStore;
  BagScreen({this.bagStore});
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {

  List<BagItem> temp = new List<BagItem>();
  final numberFormat = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
          body: Stack(
             children: [
              Container(
                width: deviceWidth,
                height: deviceHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: deviceWidth / 3.5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                                      Text("Bag", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)
                                  ),  
                                  child: Text(widget.bagStore.getTotalBagItemsCount().toString(), style: TextStyle(color: Colors.black),),
                                )
                              ],
                            ),
                          ],
                        )
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 46),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: Text(
                          widget.bagStore.getBagItemsLength < 1 ? "No product in your bag" 
                          : "Tap on an item for add, remove and delete option", 
                          style: TextStyle(
                            color: widget.bagStore.getBagItemsLength < 1 ? Colors.red : Colors.black, 
                            fontSize: widget.bagStore.getBagItemsLength < 1 ? 14 : 10
                          )
                        ),
                      ),
                      //SizedBox(height: 16),
                      Container(
                            height: deviceHeight,
                            child: ListView.builder(
                            itemCount: widget.bagStore.getBagItemsLength,
                            itemBuilder: (BuildContext context, int index){

                              BagItem bagItem = widget.bagStore.getBagItems[index];
                              return buildBagItemRow(bagItem, index);
                            },
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              widget.bagStore.getBagItemsLength > 0 ? Positioned(
                bottom: 65,
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    //crossAxisAlignment: CrossAxisAlignment.s,
                    children: [
                      Text("Total", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text(
                        '₦'+numberFormat.format(double.parse(widget.bagStore.getTotalBagItemsCost().toString())), 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                      )
                    ],
                  ),
                ),
              ): Container(),
             widget.bagStore.getBagItemsLength > 0 ?  Positioned(
                bottom: 5,
                left: (deviceWidth - 250) / 2.5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      widget.bagStore.emptyBag();
                      showDialogModal(context: context, msg: "Checkout Completed", action: "CHECKOUT");
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 250,
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Checkout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                        ]
                      
                      )
                  ),
                    ),
                    ),
                ),
              ):Container()
            ]
          )
    );
  }


  Widget buildBagItemRow(BagItem bagItem, int index){
   
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              if(temp.contains(bagItem)){
                
                setState(() {
                  temp.remove(bagItem);
                });
              }
              else{
                setState(() {
                     temp.add(bagItem);
                });
             
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                    margin: EdgeInsets.only(right: 6),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset("assets/images/luxA.jpg", fit: BoxFit.cover)
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${bagItem.qty.toString()}X", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bagItem.product.title1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),),
                      Text(bagItem.product.type, style: TextStyle(color: Colors.white, fontSize: 12),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2, 
                  child: Text(
                    "₦"+numberFormat.format(double.parse((bagItem.qty * bagItem.product.price).toString())), 
                    textAlign: TextAlign.end, 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)
                  )
              ],
          ),
            ),
        ),
        temp.contains(bagItem) ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.delete), 
              onPressed: () => widget.bagStore.deleteProductFromBag(bagItem), 
              color: Colors.white
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () => widget.bagStore.updateProductQtyInBag(bagItem, isAdding:false),
                    child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Icon(Icons.remove),
                  
                  ),
                ),
                SizedBox(width: 8,),
                Text(bagItem.qty.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => widget.bagStore.updateProductQtyInBag(bagItem, isAdding:true),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            )

          ],
            ),
        ): Container()
      ],
    );
  }

  








}