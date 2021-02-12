import 'package:DRHealth/model/bag_item.dart';
import 'package:DRHealth/model/product.dart';
import 'package:flutter/cupertino.dart';

class BagStore extends ChangeNotifier{


  List<BagItem> _bagItems = List<BagItem>();



  List<BagItem> get getBagItems => _bagItems;

  int get getBagItemsLength => _bagItems.length;
    
  addProductToBag(Product product, int qty){
    
      //check if product is already in bag
      bool productAlreadyExists = false;
      // print(qty);
      // print("bag items: " + getBagItemsLength.toString());
      // print("xxx: " + getBagItems[0].qty.toString());
      // print("xxx: " + getBagItems[0].product.title1.toString());
      // return;
      //check if product is already in bag
      if(_bagItems.length > 0){
          _bagItems.forEach((bagItem) {
              if(bagItem.product == product){
                bagItem.qty = bagItem.qty + qty;
                productAlreadyExists = true;
              }
          });
      }
    
      if(!productAlreadyExists){
         _bagItems.add(BagItem(product: product, qty: qty));   
      }

      print("bag items: " + getBagItemsLength.toString());
      getTotalBagItemsCount();

      notifyListeners();

  }

  int getTotalBagItemsCount(){

      int count = 0;

      if(_bagItems.length > 0){
        _bagItems.forEach((bagItem) {
          print("leave me: " + bagItem.qty.toString());
          count += bagItem.qty;
        });
      }

      print("bag items count: " + count.toString());
      return count;
  }

  double getTotalBagItemsCost(){
     
     double cost = 0;

     if(_bagItems.length > 0){
        _bagItems.forEach((bagItem) {
          print("leave me: " + bagItem.qty.toString());
          cost += bagItem.qty * bagItem.product.price;
        });
      }

      return cost;

  }

  deleteProductFromBag(BagItem bagItem){

      int index = _bagItems.indexOf(bagItem);
      
      //bagItem not found
      if(index < 0) return;

      _bagItems.removeAt(index);

      notifyListeners();
  }

  updateProductQtyInBag(BagItem bagItem, {@required bool isAdding}){

      if(isAdding){
        bagItem.qty = bagItem.qty + 1;
      }
      else{
        if(bagItem.qty > 1){
          bagItem.qty = bagItem.qty - 1;
        }
      }
      
      notifyListeners();
  }

  emptyBag(){
    _bagItems.clear();
    notifyListeners();
  }
  
}