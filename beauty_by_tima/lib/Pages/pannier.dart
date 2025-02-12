import 'package:beauty_by_tima/Pages/reservation.dart';
import 'package:beauty_by_tima/Providers/pannier_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier', style: GoogleFonts.lobster()),
        backgroundColor: const Color(0xFFFF40BC),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Text(
                'Votre panier est vide',
                style: GoogleFonts.lobster(fontSize: 20),
              ),
            );
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final product = cart.items[index];
              return Dismissible(
                key: Key(product.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  cart.removeFromCart(product);
                },
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading:
                        Image.asset(product.imageUrl, width: 50, height: 50),
                    title: Text(product.name, style: GoogleFonts.lobster()),
                    subtitle: Text(
                      '${product.price.toStringAsFixed(0)} F',
                      style: GoogleFonts.lobster(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cart.decreaseQuantity(product),
                        ),
                        Text('${product.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cart.increaseQuantity(product),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${cart.totalAmount.toStringAsFixed(0)} F',
                    style: GoogleFonts.lobster(fontSize: 20),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            // Implement checkout logic
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirmation',
                                    style: GoogleFonts.lobster()),
                                content: Text(
                                  'Voulez-vous confirmer votre reservation?',
                                  style: GoogleFonts.lobster(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Annuler',
                                        style: GoogleFonts.lobster()),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Reservation();
                                        }));
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const Reservation();
                                          }));
                                        },
                                        child: Text('Confirmer',
                                            style: GoogleFonts.lobster()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                    child: Text('Reserver', style: GoogleFonts.lobster()),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
