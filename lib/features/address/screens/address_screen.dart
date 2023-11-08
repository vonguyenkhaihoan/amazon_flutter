import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/common/widgets/custom_textfield.dart';
import 'package:amazon_flutter/config/payment_configurations.dart';
import 'package:amazon_flutter/constains/global_variables.dart';
import 'package:amazon_flutter/constains/utils.dart';
import 'package:amazon_flutter/features/address/services/address_services.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  //địa chỉ được sửa dụng
  String addressToBeUsed = "";
  //san pham thanh toan
  // List<PaymentItem> paymentItems = [];
  //address services
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  //ket qua apple
  void onApplePayResult(res) {}
  //ket qua apple
  void onGooglePayResult(res) {}

  //
  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    // kiem tra bieu mau co trong nếu một trông các cái là sai nghĩa là trống hết
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR', Colors.red[300]!);
    }
    print(addressToBeUsed);
    // addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  @override
  Widget build(BuildContext context) {
    //lay dia chi da có san
    var address = context.watch<UserProvider>().user.address;

    //
    return Scaffold(
      //app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              //nhap dia chi mun nhan hang
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              /*//applepay
              ApplePayButton(
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultApplePay),
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                margin: const EdgeInsets.only(top: 15),
                height: 50,
              ),

              const SizedBox(height: 10),

              GooglePayButton(
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50,
                // style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),*/

              //button check out
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Buy',
                  onTap: () => payPressed(address),
                  color: Colors.yellow[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
