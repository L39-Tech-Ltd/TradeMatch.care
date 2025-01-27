import 'package:flutter/material.dart';
import 'package:tradematch/themes/themes.dart';
import 'package:tradematch/widget/widgets.dart' as widgets;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: forestBackground),
          widgets.CustomScrollWidget(
            sections: [
              LoginRegisterSection(),

              // Filler
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(163, 255, 222, 195),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(163, 195, 246, 255),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(162, 255, 219, 195),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(162, 255, 195, 240),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(162, 254, 255, 195),
              ),
            ],
          ),

          widgets.CustomDrawer(),
        ],
      ),
    );
  }
}

class LoginRegisterSection extends StatefulWidget {
  const LoginRegisterSection({super.key});

  @override
  State<LoginRegisterSection> createState() => _LoginRegisterSectionState();
}

class _LoginRegisterSectionState extends State<LoginRegisterSection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _changeTab(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget tabButton(String title, int tabIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: () => _changeTab(tabIndex),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 99, 131, 81),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          minimumSize: const Size(100, 50),
        ),
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(164, 222, 255, 195),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 150, right: 100),
                        height: 500,
                        width: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Header
                            Container(
                              color: const Color.fromARGB(146, 99, 150, 93),
                              height: 300,
                              width: 600,
                              child: Center(
                                child: Text(
                                  'MAKE A CONNECTION',
                                  style: TextStyle(
                                    fontSize: 60,
                                    letterSpacing: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // SubHeader
                            Container(
                              color: const Color.fromARGB(146, 99, 150, 93),
                              height: 100,
                              width: 600,
                              child: Center(
                                child: Text(
                                  'FIND A TRADERS OR CARE HOME TO WORK',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Login / Register Tab Controller
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                tabButton('LOGIN', 0),
                                tabButton('SIGN UP', 1),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(225, 222, 255, 195),
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    onPageChanged: (index) {
                      _tabController.index = index;
                    },
                    children: [LoginTab(), RegisterTab()],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 0,
            left: 750,
            child: SizedBox(
              child: Text('TRADEMATCH .CARE', style: TextStyle(fontSize: 60)),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final DatabaseService db = DatabaseService();
  bool _remember = false;

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    // final response = await db.login(username, password);

    // if (response['success']) {
    //   SnackBarUtils.showSnackBar(context, successLoginMessage);
    //   context.go('/home2');
    // } else {
    //   SnackBarUtils.showSnackBar(context, response['message']);
    // }

    _usernameController.clear();
    _passwordController.clear();
  }

  Widget inputField(controller, icon, label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Focus(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Italiana',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 97, 3),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: const Color.fromARGB(160, 184, 184, 184),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 71, 99, 72),
          ),
        ),
        inputField(_usernameController, Icons.people, 'Username'),
        inputField(_passwordController, Icons.lock, 'Password'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _remember,
                  onChanged: (value) {
                    setState(() {
                      _remember = value!;
                    });
                  },
                  activeColor: Colors.lightGreen,
                ),
                const Text(
                  'Remember Me',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _login();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 99, 131, 81),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(100, 50),
            ),
            child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterTab extends StatefulWidget {
  const RegisterTab({super.key});
  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final DatabaseService db = DatabaseService();

  Future<void> _signup() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final email = _emailController.text.trim();
    // final response = await db.register(username, password, email);

    // if (response['success']) {
    //   SnackBarUtils.showSnackBar(context, successRegisterMessage);
    // } else {
    //   SnackBarUtils.showSnackBar(context, response['message']);
    // }

    _usernameController.clear();
    _passwordController.clear();
    _emailController.clear();
  }

  Widget inputField(controller, icon, label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Focus(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Italiana',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 97, 3),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: const Color.fromARGB(160, 184, 184, 184),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CREATE NEW ACCOUNT',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 71, 99, 72),
          ),
        ),
        inputField(_usernameController, Icons.people, 'Username'),
        inputField(_passwordController, Icons.lock, 'Password'),
        inputField(_emailController, Icons.email, 'Email'),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 50),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _signup();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 99, 131, 81),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(100, 50),
            ),
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
