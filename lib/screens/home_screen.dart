import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = ["الكل", "رجال", "نساء", "ألعاب"];
  final List<Map<String, String>> products = [
    {"name": "مبخر كهربائي", "price": "708 DA", "image": "assets/images/item1.png"},
    {"name": "T-shirt", "price": "946 DA", "image": "assets/images/item2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("DZ SHOPPING"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("English", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الرصيد
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.account_balance_wallet, color: Colors.red),
                  SizedBox(width: 5),
                  Text("الرصيد"),
                ]),
                Text("DA 0"),
              ],
            ),
          ),

          // التصنيفات
          Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 70,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: Center(child: Text(categories[index])),
                );
              },
            ),
          ),

          // المنتجات
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(products[index]["image"]!, width: 50),
                  title: Text(products[index]["name"]!),
                  subtitle: Text(products[index]["price"]!),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
