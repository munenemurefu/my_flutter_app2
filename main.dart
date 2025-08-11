
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MatatuGoApp());
}

class MatatuGoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatatuGo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// -------------------- LOGIN PAGE --------------------
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == 'admin' &&
        _passwordController.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("MatatuGo Login",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  _gradientButton("Login", _login),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gradientButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// -------------------- HOME PAGE --------------------
class HomePage extends StatelessWidget {
  final String playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.example.matatugo";
  final String appShareText =
      "Check out the MatatuGo app for Bungoma routes! Download here: https://play.google.com/store/apps/details?id=com.example.matatugo";
  final String emailAddress = "mailto:musanyicharlie@gmail.com?subject=MatatuGo%20App%20Feedback";

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch \$url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gradientButton(context, "MatatuGo", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoutesPage()),
              );
            }),
            _gradientButton(context, "Rate Us", () {
              _launchUrl(playStoreUrl);
            }),
            _gradientButton(context, "Send Email", () {
              _launchUrl(emailAddress);
            }),
            _gradientButton(context, "Share", () {
              _launchUrl("https://wa.me/?text=\${Uri.encodeComponent(appShareText)}");
            }),
          ],
        ),
      ),
    );
  }

  Widget _gradientButton(
      BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// -------------------- ROUTES PAGE --------------------
class RoutesPage extends StatelessWidget {
  final List<Map<String, dynamic>> routes = [
    {
      "title": "Bungoma to Kanduyi",
      "fare": "30 Ksh",
      "tip": "Avoid 7–8 AM & 5–7 PM",
      "maps": "Bungoma to Kanduyi"
    },
    {
      "title": "Bungoma to Kibabii",
      "fare": "60 Ksh",
      "tip": "Busiest during school sessions",
      "maps": "Bungoma to Kibabii"
    },
    {
      "title": "Bungoma to Musikoma",
      "fare": "40 Ksh",
      "tip": "Light traffic most of the day",
      "maps": "Bungoma to Musikoma"
    },
    {
      "title": "Bungoma to Sikata",
      "fare": "50 Ksh",
      "tip": "Afternoons are less crowded",
      "maps": "Bungoma to Sikata"
    },
    {
      "title": "Bungoma to Webuye",
      "fare": "100 Ksh",
      "tip": "Mid-morning is best",
      "maps": "Bungoma to Webuye"
    },
    {
      "title": "Bungoma to Chwele",
      "fare": "100 Ksh",
      "tip": "Avoid market days",
      "maps": "Bungoma to Chwele"
    },
  ];

  Future<void> _openMap(String query) async {
    final encoded = Uri.encodeComponent(query);
    final url = "https://www.google.com/maps/dir/?api=1&destination=\$encoded";
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not open \$url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      appBar: AppBar(
        title: Text("MatatuGo - Bungoma Routes"),
        backgroundColor: Colors.teal[900],
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              title: Text(routes[index]["title"],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                ListTile(title: Text("Fare: \${routes[index]["fare"]}")),
                ListTile(title: Text("Tip: \${routes[index]["tip"]}")),
                TextButton.icon(
                  onPressed: () => _openMap(routes[index]["maps"]),
                  icon: Icon(Icons.map, color: Colors.teal),
                  label: Text("View on Google Maps"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
