import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryButtons(),
              const SizedBox(height: 20),
              _foodGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryButtons() {
    final categories = ['Cake', 'Sandwich', 'Cookie', 'Bread'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories
          .map((category) => ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Text(category),
              ))
          .toList(),
    );
  }

  Widget _foodGrid(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          final product = _productList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: _foodItem(product['imagePath']!, product['name']!,
                product['price']!, product['weight']!),
          );
        },
      ),
    );
  }

  Widget _foodItem(String image, String name, String price, String weight) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            "\$$price - $weight",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Add', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(product['imagePath']!, height: 200),
            const SizedBox(height: 10),
            Text(
              product['name']!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Price: \$${product['price']}",
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              "Weight: ${product['weight']}",
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              child: const Text("Add to Cart", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

const List<Map<String, String>> _productList = [
  {
    'name': 'Chocolate Heaven Cake',
    'imagePath': 'images/cake 1.png',
    'price': '12.99',
    'weight': '500g'
  },
  {
    'name': 'Vanilla Dream Delight',
    'imagePath': 'images/cake 2.png',
    'price': '10.99',
    'weight': '450g'
  },
  {
    'name': 'Nutty Pistachio Cake',
    'imagePath': 'images/cake 3.png',
    'price': '14.99',
    'weight': '500g'
  },
  {
    'name': 'Rich Coffee Mocha Cake',
    'imagePath': 'images/cake 4.png',
    'price': '13.99',
    'weight': '480g'
  },
  {
    'name': 'Red Velvet Bliss Cake',
    'imagePath': 'images/cake 5.png',
    'price': '15.99',
    'weight': '500g'
  },
  {
    'name': 'Floral Fantasy Cake',
    'imagePath': 'images/cookie 3.png',
    'price': '11.99',
    'weight': '450g'
  },
];
