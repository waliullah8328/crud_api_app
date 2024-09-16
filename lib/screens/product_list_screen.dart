

import 'dart:convert';

import 'package:crud_api_app/screens/add_new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../widgets/product_list_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {

  List<Product> productList = [];

  bool _inProgress = false;

  @override
  void initState() {
    getProductList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          IconButton(onPressed: (){
            getProductList();
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _inProgress? const Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductItems(product: productList[index],);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16,);
          },




        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewProduct(),));
          },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> getProductList() async {

    _inProgress = true;
    setState(() {

    });
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/ReadProduct");
    Response response = await get(uri);

    debugPrint(response.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());
    
    if(response.statusCode == 200){
      productList.clear();
      Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      for(var item in jsonResponse["data"]){
        Product product = Product(
            id: item["_id"],
            productName: item["ProductName"]??"",
            productCode: item["ProductCode"]??"",
            productImage: item["Img"]??"",
            unitPrice: item["UnitPrice"]??"",
            quantity: item["Qty"]??"",
            totalPrice:item["TotalPrice"]??"",
            createdAt: item["CreatedDate"]);
        productList.add(product);
      }

    }
    _inProgress = false;
    setState(() {

    });

   
  }
}


