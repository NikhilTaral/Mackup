import 'package:fast/product.dart';
import 'package:fast/remote_services.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<Product> cartList = <Product>[].obs; 

  get cartItems => cartList; 

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.assignAll(products);
      }
    } finally {
      isLoading(false);
    }
  }

  void addToCart(Product product) {
    if (!cartList.contains(product)) {
      cartList.add(product);
    }
  }
}
