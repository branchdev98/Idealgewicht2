// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:vtm/Config/Constants.dart';
//
// class InApp extends StatefulWidget {
//   static String route = "InApp";
//
//   @override
//   _InAppState createState() => _InAppState();
// }
//
// class _InAppState extends State<InApp> {
//
//
//
//
//   StreamSubscription<List<PurchaseDetails>> _subscription;
//
//   @override
//   void initState() {
//     final Stream purchaseUpdates =
//         InAppPurchaseConnection.instance.purchaseUpdatedStream;
//     _subscription = purchaseUpdates.listen((purchases) {
//     });
//
//     CheckForInApp();
//     super.initState();
//   }
//
//   CheckForInApp() async {
//
//     print("Calling");
//
//     final bool available = await InAppPurchaseConnection.instance.isAvailable();
//     if (!available) {
//       // The store cannot be reached or accessed. Update the UI accordingly.
//       print("Unavailable");
//
//     }
//
//     // Set literals require Dart 2.2. Alternatively, use `Set<String> _kIds = <String>['product1', 'product2'].toSet()`.
//     const Set<String> _kIds = {'SchmerzMonatsabo', 'SchmerzJahresabo','test01'};
//     final ProductDetailsResponse response = await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
//     if (response.notFoundIDs.isNotEmpty) {
//       print(response.productDetails.length);
//     }
//     List<ProductDetails> products = response.productDetails;
//
//     print("Products Lengdth"+products.length.toString());
//
//   }
//
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//     CheckForInApp();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.blue,
//       title: Text("Subscription"),centerTitle: true,),
//       body: ListView(
//         children: [
//
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Image.asset("assets/images/oneMonth.jpeg",width: 75,),
//                 SizedBox(width: 20,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(subscriptionOneMonthTitle,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
//                       SizedBox(height: 5,),
//                       Text(subscriptionOneMonthDesc)
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//                 Text("€2.99",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),),
//               ],
//             ),
//           ),
//           Divider(height: 0,thickness: 1,),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Image.asset("assets/images/oneYear.jpeg",width: 75,),
//                 SizedBox(width: 20,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(subscriptionOneyearTitle,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
//                       SizedBox(height: 5,),
//                       Text(subscriptionOneYearDesc),
//
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//                 Text("€8.99",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),),
//               ],
//             ),
//           )
//
//         ],
//       )
//     );
//   }
// }
