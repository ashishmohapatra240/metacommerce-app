import 'package:metamall/common/widgets/loader.dart';
import 'package:metamall/features/account/widgets/single_product.dart';
import 'package:metamall/features/admin/screens/add_product_screen.dart';
import 'package:metamall/features/admin/services/admin_services.dart';
import 'package:metamall/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      GlobalVariables.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Admin Panel',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final productData = products![index];
                  print(productData);
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(image: productData.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: Icon(Icons.delete_outline, color: GlobalVariables.greyBackgroundCOlor,),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateToAddProduct();
                },
                tooltip: 'Add a Product',
                child: const Icon(Icons.add, color: Colors.white,),
                backgroundColor: GlobalVariables.secondaryColor,
              ),
             
            ),
          );
  }
}
