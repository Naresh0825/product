import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product/commons/exporter.dart';
import 'package:product/provider/products_provider.dart';
import 'package:product/widget/loading.dart';
import 'package:product/widget/search_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<GetStockListProvider>().getProductList();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GetStockListProvider readGetStockListProvider =
        context.read<GetStockListProvider>();
    return Scaffold(
      body: SafeArea(
        child:
            Consumer<GetStockListProvider>(builder: (context, product, child) {
          return product.getProductListModel.products == null
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: const Center(child: LoadingBox()),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppHeight.h14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorManager.blue,
                            ColorManager.blueBright,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: AppRadius.r4,
                            offset: const Offset(0.0, 1.0),
                            color: ColorManager.grey,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppRadius.r10),
                          bottomRight: Radius.circular(AppRadius.r10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Navigator.of(context, rootNavigator: true).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const HomeScreen(),
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: ColorManager.white,
                                ),
                              ),
                              Text(
                                'Products',
                                style: getBoldStyle(
                                  fontSize: FontSize.s20,
                                  color: ColorManager.white,
                                ),
                              ),
                              SizedBox(
                                width: AppWidth.w40,
                              ),
                            ],
                          ),
                          SearchWidget(
                            searchTextEditingController: searchController,
                            onChanged: (value) {
                              product.searchProduct(value);
                            },
                            onPressed: () {
                              searchController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                              product.searchProduct('');
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: searchController.text.isEmpty
                            ? product.getProductListModel.products!.length
                            : product.searchProductList.length,
                        itemBuilder: (context, index) {
                          var productData = searchController.text.isEmpty
                              ? product.getProductListModel.products!
                              : product.searchProductList;
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(productData[index].title.toString()),
                              subtitle:
                                  Text('Ratings: ${productData[index].rating}'),
                              trailing: Text('Rs. ${productData[index].price}'),
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                );
        }),
      ),
    );
  }
}
