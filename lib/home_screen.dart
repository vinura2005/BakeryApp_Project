import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/food_item.dart';
import 'services/food_service.dart';
import 'providers/cart_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'images/b3.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bake With Love',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        'Welcome to Crave Bake, your go-to destination for freshly baked treats that bring joy to every bite!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Order Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _categoryItem(Icons.cake, "Cake"),
                _categoryItem(Icons.fastfood, "Sandwich"),
                _categoryItem(Icons.cookie, "Cookies"),
                _categoryItem(Icons.bakery_dining, "Bread"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Our Foods",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          _horizontalFoodList(),
          const SizedBox(height: 20),
          _bestSeller(),
        ],
      ),
    );
  }

  Widget _categoryItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _horizontalFoodList() {
    final popularItems = FoodService.getPopularItems().take(3).toList();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: popularItems.length,
        itemBuilder: (context, index) {
          final item = popularItems[index];
          return _foodItem(item);
        },
      ),
    );
  }

  Widget _foodItem(FoodItem item) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Container(
          width: 150,
          margin: const EdgeInsets.only(right: 15),
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
                child: Image.asset(item.imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 5),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "\$${item.price.toStringAsFixed(2)} - ${item.weight}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: cart.isInCart(item.id)
                    ? null
                    : () {
                        cart.addToCart(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} added to cart!'),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        cart.isInCart(item.id) ? Colors.green : Colors.red,
                    foregroundColor: Colors.white),
                child: Text(
                  cart.isInCart(item.id) ? 'In Cart' : 'Add',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bestSeller() {
    final bestSeller = FoodService.getBestSellerItem();

    if (bestSeller == null) {
      return const SizedBox.shrink();
    }

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Best Sell",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                "Food in this week",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                  border: cart.isInCart(bestSeller.id)
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$${bestSeller.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  if (cart.isInCart(bestSeller.id)) ...[
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${cart.getQuantity(bestSeller.id)} in cart',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: index < bestSeller.rating.floor()
                                        ? Colors.orange
                                        : Colors.grey,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                bestSeller.description,
                                style: const TextStyle(color: Colors.white),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            bestSeller.imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    if (cart.isInCart(bestSeller.id))
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                cart.removeFromCart(bestSeller.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${bestSeller.name} removed from cart'),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Remove'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              final quantity = cart.getQuantity(bestSeller.id);
                              if (quantity > 1) {
                                cart.updateQuantity(
                                    bestSeller.id, quantity - 1);
                              } else {
                                cart.removeFromCart(bestSeller.id);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              cart.addToCart(bestSeller);
                            },
                          ),
                        ],
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            cart.addToCart(bestSeller);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('${bestSeller.name} added to cart!'),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
