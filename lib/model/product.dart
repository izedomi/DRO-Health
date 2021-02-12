import 'package:flutter/material.dart';

class Product {
    
    String id;
    String productId;
    String title1;
    String title2;
    int price;
    String type;
    String image;
    String distributor;
    String packSize;
    String constituents;
    String dispensedIn;
  


    Product({
      @required this.id,
      @required this.title1,
      @required this.title2,
      @required this.price,
      @required this.image,
      @required this.type,
      this.productId = "NA",
      this.distributor = "NA",
      this.packSize = "NA",
      this.constituents = "NA",
      this.dispensedIn = "NA"
    });

}