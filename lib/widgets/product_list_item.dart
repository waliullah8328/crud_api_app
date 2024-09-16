import 'package:crud_api_app/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../screens/product_list_screen.dart';

class ProductItems extends StatefulWidget {

  final Product product;
  const ProductItems({
    super.key, required this.product,
  });

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  bool _loading = false;

  deleteItem(id)async{
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete !"),
            content: Text("Once delete, you can't get it back"),
            actions: [
              OutlinedButton(onPressed: () async {
                debugPrint(id.toString());
                Navigator.pop(context);
                setState(() {
                  _loading = true;

                });

                await productDeleteRequest(id);
                // await getProductList();
              }, child: Text("Yes")),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("No")),
            ],
          );
        },
    );

  }

  goToUpdatePage(context,productItem){
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct( product:productItem,),));

  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white,
      title:  Text(widget.product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Product code: ${widget.product.productCode}"),
           Text("Price: \$ ${widget.product.unitPrice}"),
           Text("Quantity: ${widget.product.quantity}"),
           Text("Total Price:  \$ ${widget.product.totalPrice}"),
          const Divider(),
          ButtonBar(
            children: [
              TextButton.icon(onPressed: (){


                goToUpdatePage(context,widget.product);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProduct(),));
              }, label: const Text("Edit"),icon: const Icon(Icons.edit),),
              TextButton.icon(onPressed: (){
                deleteItem(widget.product.id.toString());
              }, label: const Text("Delete",style: TextStyle(color: Colors.red),),icon: const Icon(Icons.delete,color: Colors.red,),),
            ],
          ),
        ],
      ),


    );
  }

  Future<bool> productDeleteRequest (id)async{
    var url = Uri.parse("http://164.68.107.70:6060/api/v1/DeleteProduct/"+id);

    var response = await http.get(url,headers: {"Content-Type": "application/json",});

    if(response.statusCode == 200 ){
      debugPrint("Successfully deleted");
      return true;
    }
    else{
      debugPrint("Some thing went wrong");
      return false;

    }


  }
}