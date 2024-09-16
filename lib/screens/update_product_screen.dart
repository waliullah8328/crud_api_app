import 'dart:convert';

import 'package:crud_api_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProduct extends StatefulWidget {

  const UpdateProduct({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  bool _inProgress = false;






  @override
  Widget build(BuildContext context) {
    final TextEditingController _productNameController = TextEditingController(text: widget.product.productName??"");
    final TextEditingController _unitPriceController = TextEditingController(text: widget.product.unitPrice??"");
    final TextEditingController _totalPriceController = TextEditingController(text: widget.product.totalPrice??"");
    final TextEditingController _productImageController = TextEditingController(text: widget.product.productImage??"");
    final TextEditingController _productCodeController = TextEditingController(text: widget.product.productCode??"");
    final TextEditingController _productQuantityController = TextEditingController(text: widget.product.quantity??"");
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



    return Scaffold(
      appBar: AppBar(title: Text("Update Product"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
        
                  controller: _productNameController,
                  decoration: InputDecoration(
                      hintText: "Name",
                      labelText: "Product Name"
                  ),
                ),
                TextFormField(
        
                  controller: _unitPriceController,
                  decoration: InputDecoration(
                      hintText: "Unit Price",
                      labelText: "Product Unit Price"
                  ),
                ),
                TextFormField(
        
                  controller: _totalPriceController,
                  decoration: InputDecoration(
                      hintText: "Total Price",
                      labelText: "Total Price"
                  ),
                ),
                TextFormField(
        
                  controller: _productImageController,
                  decoration: InputDecoration(
                      hintText: "Image",
                      labelText: "Product Image"
                  ),
                ),
                TextFormField(
        
                  controller: _productCodeController,
                  decoration: InputDecoration(
                      hintText: "Code",
                      labelText: "Product Code"
                  ),
                ),
                TextFormField(
        
                  controller: _productQuantityController,
                  decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Product Quantity"
                  ),
                ),
                const SizedBox(height: 30,),
                _inProgress?const Center(child: CircularProgressIndicator()):ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromWidth(double.maxFinite),
                    ),
                    onPressed: (){
                      UpdateProduct(
                          image: _productImageController.text,
                          productCode: _productCodeController.text,
                          productName: _productNameController.text,
                          Qty: _productQuantityController.text,
                          totalPrice: _totalPriceController.text,
                          unitPrice: _unitPriceController.text,
                        id: widget.product.id
                      );
                    }, child: const Text("Update Product"))
        
              ],
            ),
          ),
        ),
      ),
    );


  }

  Future<void> UpdateProduct(
      {
    required String image,
    required String productCode,
    required String productName,
    required String Qty,
    required String totalPrice,
    required String unitPrice,
        required id,
  })async{
    _inProgress = true;
    setState(() {

    });
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/UpdateProduct/"+id);
    Map<String,dynamic> responseBody =  {
      "Img": image,
      "ProductCode": productCode,
      "ProductName": productName,
      "Qty": Qty,
      "TotalPrice": totalPrice,
      "UnitPrice": unitPrice
    };

    Response response = await post(uri,body: jsonEncode(responseBody),headers: {
      "Content-Type": "application/json",
    });
    debugPrint(response.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());
    if(response.statusCode == 200){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Updated")));

    }
    _inProgress = false;
    setState(() {

    });



  }





  void onTapAddProductButton(){

  }
}
