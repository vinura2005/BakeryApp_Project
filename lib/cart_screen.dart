import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _cartItems()),
            _cartSummary(),
          ],
        ),
      ),
    );
  }

  Widget _cartItems() {
    return ListView.builder(
      itemCount: _cartList.length,
      itemBuilder: (context, index) {
        return _cartItem(
          _cartList[index]['imagePath']!,
          _cartList[index]['name']!,
          _cartList[index]['price']!,
        );
      },
    );
  }

  Widget _cartItem(String image, String name, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$$price",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _cartSummary() {
    double total =
        _cartList.fold(0, (sum, item) => sum + double.parse(item['price']!));
    return Column(
      children: [
        Divider(color: Colors.white.withOpacity(0.3)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

const List<Map<String, String>> _cartList = [
  {
    'name': 'Chocolate Heaven Cake',
    'imagePath': "images/donut item.png",
    'price': '12.99',
  },
  {
    'name': 'Vanilla Dream Delight',
    'imagePath': "images/bread_3-.png",
    'price': '10.99',
  },
  {
    'name': 'Nutty Pistachio Cake',
    'imagePath': "images/cake 1.png",
    'price': '14.99',
  },
  {
    'name': 'Nutty Pistachio Cake',
    'imagePath': "images/cookie 2.png",
    'price': '14.99',
  },
  {
    'name': 'Nutty Pistachio Cake',
    'imagePath': "images/cake 2.png",
    'price': '14.99',
  },
];
