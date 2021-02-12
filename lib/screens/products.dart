
import 'package:DRHealth/controllers/data_store.dart';
import 'package:DRHealth/data/proucts.dart';
import 'package:DRHealth/model/product.dart';
import 'package:DRHealth/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class ProductsScreen extends StatefulWidget {

  final BagStore bagStore;
  ProductsScreen({this.bagStore});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {


  String selectedAction;
  List<Product> altProductList = new List<Product>();
  List<Product> sortList = new List<Product>();
  final numberFormat = new NumberFormat("#,##0", "en_US");
  

    
  @override
  void initState() {
      super.initState();
     
      products.forEach((element) {
        altProductList.add(element);
        sortList.add(element);
      });
  
  }


  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row( 
                  children: [
                      IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pushNamed(context, '/onboarding')),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth / 3.5),
                        child: Text("${altProductList.length} item(s)"),
                      ), 
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionIcons(FontAwesomeIcons.sortAmountDownAlt, "SORT"),
                  SizedBox(width: 24),
                  _buildActionIcons(FontAwesomeIcons.filter, "FILTER"),
                  SizedBox(width: 24),
                  _buildActionIcons(FontAwesomeIcons.search, "SEARCH"),
                ]
              ),
              selectedAction == "SEARCH" ? SizedBox(height: 16.0) : SizedBox(),
              selectedAction == "SEARCH" ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:3.0, horizontal: 12),
                  focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  labelText: "Search",
                  prefix: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                  child: Icon(FontAwesomeIcons.search)),
                  suffixIcon: GestureDetector(
                      onTap: () => resetProductList(),
                      child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                      child: Icon(FontAwesomeIcons.times)
                    ),
                  ),
              ),
              onChanged: (value) => filterProviders(value))
              ): SizedBox(),
              SizedBox(height: 16.0),
              Expanded(
                    child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
                    children:
                        List.generate(altProductList.length, (index) {
                        Product product = altProductList[index];
                        return _buildGridView(product);
                    })),
              )
            ],
          ),
        ),
        bottomSheet: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/bag_screen'),
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
            ),  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                    Text("Bag", style: TextStyle(color: Colors.white),)
                  ],
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
          
          ),
        )
        
    );
  }

  

  filterProviders(query){
        print(query);
        if(query.trim().length == 0){
            altProductList.clear();
            setState(() {
              products.forEach((element) {
                altProductList.add(element);
                //sortList.add(element);
              });
            });
        }
        else{

          var ls = products.where((product){
            return product.title1.toLowerCase().contains(query.toLowerCase()) || product.title1.toLowerCase().contains(query.toLowerCase()) ;
          }).toList();
          setState(() {
            altProductList = ls;
          });
        }

  }
  
  sortProduct(){

  }

  resetProductList(){
      selectedAction = null;
      altProductList.clear();
      setState((){
        products.forEach((element) {
          altProductList.add(element);
        });
      });
  }

  Widget _buildActionIcons(IconData icon, String action){

    return  GestureDetector(
        onTap: () {
          if(action == "SORT"){
            altProductList.sort((a, b) => a.title1.compareTo(b.title1));
          }
          setState(() => selectedAction = action);
        },
        child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            //BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
          ]
        ),
        child: Icon(icon, size: 16.0, color: Colors.grey)
      ),
    );
  }

  Widget _buildGridView(Product product) {
    return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailScreen(product:product, bagStore: widget.bagStore)),
        ),
        child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8, bottom: 2),
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            //alignment: Alignment.center,
            //width: 150.0,
            //height: 700.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                      color: Colors.black12)
                ],
            ),
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 80,
                  ),
                    ),
                ),
                SizedBox(height: 8),
                Text(
                  product.title1,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0
                    ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  product.title2,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0
                    ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  product.type,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0
                    ),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 5),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                    height: 20,
                    width: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        //BoxShadow(blurRadius: 6.0, color: Colors.black12, offset: Offset(-1,2))
                      ]
                    ),
                    child: Text(
                      '₦'+ numberFormat.format(double.parse(product.price.toString())), 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 10)
                    )
                  ),
                ),  
              ],
            )),
    );
  }

}