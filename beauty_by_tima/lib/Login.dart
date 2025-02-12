import 'package:beauty_by_tima/Pages/Acceuil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF40BC),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo, nom et bienvenue
            Column(
              children: [
                //Logo
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.pink,
                    backgroundImage: AssetImage(
                      'assets/images/afro.jpg',
                    ),
                  ),
                ),

                //Nom de l'appli
                Text(
                  'Tima beauty',
                  style: GoogleFonts.lobster(
                    fontSize: 40,
                  ),
                ),

                //Text de bienvenu
                Text(
                  'Bienvenu chez Tima beauty, votre atelier coiffure',
                  style: GoogleFonts.lobster(),
                ),
              ],
            ),

            //Espace vide
            const SizedBox(
              height: 20,
            ),

            //Formulaire de connexion
            Column(
              children: [
                //Formulaire de Saisie d'email
                _buildChampsDeSaisie(email, 'Email', Icons.email, null, false),

                //espace vide
                const SizedBox(
                  height: 16,
                ),

                //Formulaire de Saisie de mot de passe
                _buildChampsDeSaisie(
                    password,
                    'Password',
                    Icons.key,
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        isVisible == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    isVisible),

                //espace vide
                const SizedBox(
                  height: 20,
                ),

                //Button pour se connecter
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 1.8,
                  height: 45,
                  color: Colors.white,
                  splashColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  onPressed: () {
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Acceuil(),
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text('Tout les champs sont obligatoires !'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Se connecter',
                    style: GoogleFonts.lobster(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Construire le champs de saisie principale
  _buildChampsDeSaisie(TextEditingController controller, String hintText,
      IconData prefixIcon, Widget? suffixIcon, bool isVisible) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink),
            borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
        hintStyle: GoogleFonts.lobster(),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.pinkAccent,
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: isVisible,
    );
  }
}
