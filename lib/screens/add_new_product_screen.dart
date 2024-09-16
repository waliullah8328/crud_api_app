import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _productImageController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _productQuantityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Product"),),
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter product name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _unitPriceController,
                  decoration: InputDecoration(
                      hintText: "Unit Price",
                      labelText: "Product Unit Price"
                  ),validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter product unit price";
                  }
                  return null;
                },
                ),
                TextFormField(
                  controller: _totalPriceController,
                  decoration: InputDecoration(
                      hintText: "Total Price",
                      labelText: "Total Price"
                  ),validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter product total price";
                  }
                  return null;
                },
                ),
                TextFormField(
                  controller: _productImageController,
                  decoration: InputDecoration(
                      hintText: "Image",
                      labelText: "Product Image"
                  ),validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter product image";
                  }
                  return null;
                },
                ),
                TextFormField(
                  controller: _productCodeController,
                  decoration: InputDecoration(
                      hintText: "Code",
                      labelText: "Product Code"
                  ),validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter product code";
                  }
                  return null;
                },
                ),
                TextFormField(
                  controller: _productQuantityController,
                  decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Product Quantity"
                  ),validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter product quantity";
                  }
                  return null;
                },
                ),
                const SizedBox(height: 30,),
                _inProgress? const Center(child: CircularProgressIndicator()) :ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromWidth(double.maxFinite),
                    ),
                    onPressed: onTapAddProductButton, child: const Text("Add Product"))

              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapAddProductButton(){
    if(_formKey.currentState!.validate()){

      addNewProduct();


    }

  }

  Future<void> addNewProduct()async{
    _inProgress = true;
    setState(() {

    });
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/CreateProduct");
    Map<String,dynamic> responseBody =  {
      "Img": _productImageController.text,
      "ProductCode": _productCodeController.text,
      "ProductName": _productNameController.text,
      "Qty": _productQuantityController.text,
      "TotalPrice": _totalPriceController.text,
      "UnitPrice": _unitPriceController.text
    };

    Response response = await post(uri,body: jsonEncode(responseBody),headers: {
      "Content-Type": "application/json",
    });
    debugPrint(response.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());
    if(response.statusCode == 200){
      _clearTexFiled();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New Product Added")));

    }
    _inProgress = false;
    setState(() {

    });



  }

  void _clearTexFiled(){
    _productNameController.clear();
    _unitPriceController.clear();
    _totalPriceController.clear();
    _productImageController.clear();
    _productCodeController.clear();
    _productQuantityController.clear();

  }


  @override
  void dispose() {
    _productNameController.dispose();
    _unitPriceController.dispose();
    _totalPriceController.dispose();
    _productImageController.dispose();
    _productCodeController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }
}
