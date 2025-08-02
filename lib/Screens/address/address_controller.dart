import 'package:ecommerceapp/Screens/address/address_model.dart';
import 'package:ecommerceapp/Screens/address/address_services.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  var addressList = <AddressModel>[].obs;
  var isLoading = false.obs;
  final AddressServices addressServices = AddressServices();

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  void fetchAddresses() async {
    try {
      isLoading.value = true;
      var addresses = await addressServices.getAddress();
      addressList.assignAll(addresses);
    } catch (e) {
      print("Error fetching addresses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addAddress(AddressModel newAddress) {
    addressList.add(newAddress);
    addressList.refresh();
  }

  void deleteAddress(int id) {
    addressList.removeWhere((address) => address.id == id);
    update(); // if you're using GetBuilder, otherwise use RxList
  }
}
