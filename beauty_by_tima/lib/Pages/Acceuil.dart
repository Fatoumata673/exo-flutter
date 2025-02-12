import 'package:beauty_by_tima/Login.dart';
import 'package:beauty_by_tima/Models/produit.dart';
import 'package:beauty_by_tima/Pages/detail.dart';
import 'package:beauty_by_tima/Pages/pannier.dart';
import 'package:beauty_by_tima/Providers/pannier_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Bride Court',
      price: 10000,
      category: 'Coiffure Africaine',
      imageUrl: 'assets/images/lgtof.jpg',
      description: 'Coiffure avec Rajout',
    ),
    Product(
      id: '2',
      name: 'Bride Long',
      price: 15000,
      category: 'Coiffure Africaine',
      imageUrl: 'assets/images/bride long.jpg',
      description: 'Coiffure avec Rajout',
    ),
    Product(
      id: '3',
      name: 'Nate Collé',
      price: 4000,
      category: 'Coiffure Africaine',
      imageUrl: 'assets/images/nate.jpg',
      description: 'Coiffure sans Rajout',
    ),
    Product(
      id: '4',
      name: 'Bride Bouclé',
      price: 15000,
      category: 'Coiffure Africaine',
      imageUrl: 'assets/images/bride bouclé.jpg',
      description: 'Coiffure avec Rajout',
    ),
    Product(
      id: '5',
      name: 'Locks',
      price: 20000,
      category: 'Coiffure Americaine',
      imageUrl: 'assets/images/locks.jpg',
      description: 'Coiffure avec Rajout',
    ),
    Product(
      id: '6',
      name: 'ZigZag',
      price: 6000,
      category: 'Coiffure Africaine',
      imageUrl: 'assets/images/zigzag.jpg',
      description: 'Coiffure avec Rajout',
    ),
  ];

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beauty By Tima',
          style: GoogleFonts.lobster(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFFF40BC),
        centerTitle: true,
        actions: [
          Badge(
            label: Consumer<CartProvider>(
              builder: (context, cart, child) => Text('${cart.items.length}'),
            ),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              ),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Rechercher un model...',
              onChanged: filterProducts,
              leading: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            filteredProducts = products;
          });
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) =>
              _buildProductCard(filteredProducts[index]),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetails(product: product),
        ),
      ),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  product.imageUrl,
                  height: 225,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.lobster(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.price.toStringAsFixed(0)} F',
                    style: GoogleFonts.lobster(
                      fontSize: 16,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.add_event,
                          progress: _controller,
                        ),
                        onPressed: () {
                          context.read<CartProvider>().addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} ajouté au panier'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            product.isFavorite = !product.isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 210,
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF40BC), Color(0xFFFFFFFF)],
              ),
            ),
            accountName: Text('Tima',
                style: GoogleFonts.lobster(color: Colors.black, fontSize: 20)),
            accountEmail: Text('tima@gmail.com',
                style:
                    GoogleFonts.lobster(color: Colors.black45, fontSize: 17)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/images/lgtof.jpg',
                    height: 100, width: 100, fit: BoxFit.cover),
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Acceuil', () => Navigator.pop(context)),
          _buildDrawerItem(Icons.shopping_cart, 'Panier', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }),
          _buildDrawerItem(Icons.logout, 'Déconnexion', () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login()));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent, size: 25),
      title: Text(title, style: GoogleFonts.lobster(color: Colors.black)),
      onTap: onTap,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
