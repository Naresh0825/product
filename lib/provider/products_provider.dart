import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product/commons/exporter.dart';
import 'package:product/model/product_model.dart';
import 'package:http/http.dart' as http;

class GetStockListProvider extends ChangeNotifier {
  ProductModel getProductListModel = ProductModel();
  List<Product> searchProductList = [];

  Future<ProductModel> getProductList() async {
    var client = http.Client();
    var url = Uri.parse(Strings.ip);
    try {
      var response = await client.get(url);

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        getProductListModel = ProductModel.fromJson(jsonData);

        notifyListeners();
      }
    } catch (e) {
      log(e.toString(), name: 'getProductList Error');
    }
    notifyListeners();
    return getProductListModel;
  }

  searchProduct(String value) {
    searchProductList = getProductListModel.products!
        .where((product) => product.title!.toLowerCase().contains(
              value.toLowerCase(),
            ))
        .toList();

    notifyListeners();
  }
}
