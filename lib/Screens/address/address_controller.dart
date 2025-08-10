import 'package:ecommerceapp/Screens/address/address_model.dart';
import 'package:ecommerceapp/Screens/address/address_services.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  var addressList = <AddressModel>[].obs;
  var isLoading = false.obs;
  final AddressServices addressServices = AddressServices();

  // 🆕 Selected address store
  var selectedAddress = Rxn<AddressModel>();

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

      // 🆕 Agar address list khaali nahi hai to pehla address select
      if (addresses.isNotEmpty) {
        selectedAddress.value = addresses.first;
      } else {
        selectedAddress.value = null;
      }
    } catch (e) {
      print("Error fetching addresses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addAddress(AddressModel newAddress) {
    addressList.add(newAddress);
    addressList.refresh();
    selectedAddress.value = newAddress; // 🆕 naya add hote hi select
  }

  void deleteAddress(int id) {
    addressList.removeWhere((address) => address.id == id);

    // 🆕 Delete hone ke baad selected address update
    if (addressList.isNotEmpty) {
      selectedAddress.value = addressList.first;
    } else {
      selectedAddress.value = null;
    }
  }

  // 🆕 User manually address select kare
  void selectAddress(AddressModel address) {
    selectedAddress.value = address;
  }
}
