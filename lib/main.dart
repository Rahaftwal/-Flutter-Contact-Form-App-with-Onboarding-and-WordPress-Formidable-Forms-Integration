import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import functions for handling API requests or other utilities
import 'functions.dart';

void main() async {
  // Ensure that Flutter has initialized the widget binding before proceeding
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve an instance of SharedPreferences for persisting user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Check if the user has seen the onboarding screens
  bool? seenOnboarding = prefs.getBool('seenOnboarding');

  // Run the app and pass the onboarding state to the MyApp widget
  runApp(MyApp(seenOnboarding: seenOnboarding ?? false));
}

class MyApp extends StatelessWidget {
  // A boolean to determine if onboarding screens have been seen
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact me',
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the primary theme color to green
      ),
      // Choose the initial screen based on the onboarding state
      home: seenOnboarding ? const Homepage() : const OnboardingScreen(),
    );
  }
}
// This class represents the OnboardingScreen widget, which is a StatefulWidget.
class OnboardingScreen extends StatefulWidget {
  // Constructor for the OnboardingScreen class. The 'super.key' is passed to the parent class.
  const OnboardingScreen({super.key});

  @override
  // Creates the mutable state for this widget, represented by _OnboardingScreenState.
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Welcome!",
      "message": "We're delighted to have you here",
      "image": "assets/welcome.png",
      "gradient": [Color(0xFF2196F3), Color(0xFF1976D2)],  // Blue gradient
      "secondaryColor": Color(0xFFBBDEFB),
    },
    {
      "title": "Get in Touch",
      "message": "We're ready to answer all your questions",
      "image": "assets/contact.png",
      "gradient": [Color(0xFF4CAF50), Color(0xFF388E3C)],  // Green gradient
      "secondaryColor": Color(0xFFC8E6C9),
    },
    {
      "title": "Share Your Ideas",
      "message": "Let's collaborate and bring your thoughts to life",
      "image": "assets/ideas.png",
      "gradient": [Color(0xFFFF9800), Color(0xFFF57C00)],  // Orange gradient
      "secondaryColor": Color(0xFFFFE0B2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _onboardingData[index]["gradient"],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.1),
                      // Animated Image Container
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: _onboardingData[index]["secondaryColor"].withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                _onboardingData[index]["image"]!,
                                height: screenSize.height * 0.3,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                      
                      Spacer(),
                      // Animated Text Container
                      Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              _onboardingData[index]["title"]!,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: _onboardingData[index]["gradient"][1],
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15),
                            Text(
                              _onboardingData[index]["message"]!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            // Page Indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _onboardingData.length,
                                (i) => AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: _currentPage == i ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == i 
                                        ? _onboardingData[index]["gradient"][1]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // Navigation Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentPage == _onboardingData.length - 1) {
                                    // Navigate to Homepage
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => const Homepage()),
                                    );
                                  } else {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _onboardingData[index]["gradient"][1],
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  _currentPage == _onboardingData.length - 1 
                                      ? 'Get Started'
                                      : 'Next',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// This class represents the Homepage widget, which is a StatefulWidget.

class Homepage extends StatefulWidget {
  // Constructor for the Homepage class. The 'super.key' is passed to the parent class.
  const Homepage({super.key});

  @override
  // Creates the mutable state for this widget, represented by _HomepageState.
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  String? Gender;
  String? bestTimeToContact;
  final List<String> items = ['male', 'female'];
  DateTime? selectedDate;
  final DateTime firstDate = DateTime(1900);
  final DateTime lastDate = DateTime.now();
  
  // Controllers
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final numberController = TextEditingController();

  // Custom color scheme for the entire form
  final List<Color> gradientColors = [
    Color(0xFF6C63FF),  // Primary Purple
    Color(0xFF4CAF50),  // Fresh Green
    Color(0xFFFF5252),  // Coral Red
    Color(0xFF00BCD4),  // Turquoise Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientColors[0], gradientColors[1]],
            ),
          ),
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF5F5F5)],
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildSection(
                  title: 'Personal Information',
                  icon: Icons.person,
                  color: gradientColors[0],
                  children: [
                    _buildTextField(
                      controller: firstnameController,
                      label: 'First Name',
                      icon: Icons.person_outline,
                      color: gradientColors[0],
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: lastnameController,
                      label: 'Last Name',
                      icon: Icons.person_outline,
                      color: gradientColors[0],
                    ),
                    SizedBox(height: 15),
                    _buildDropdownField(
                      value: Gender,
                      items: items,
                      label: 'Gender',
                      icon: Icons.people_outline,
                      color: gradientColors[0],
                      onChanged: (value) => setState(() => Gender = value),
                    ),
                  ],
                ),

                _buildSection(
                  title: 'Contact Details',
                  icon: Icons.contact_mail,
                  color: gradientColors[1],
                  children: [
                    _buildTextField(
                      controller: emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      color: gradientColors[1],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15),
                    _buildTimeSelectionCard(),
                  ],
                ),

                _buildSection(
                  title: 'Date & Age',
                  icon: Icons.calendar_today,
                  color: gradientColors[2],
                  children: [
                    _buildAnimatedDateField(
                      label: 'Date of Birth',
                      value: selectedDate,
                      color: gradientColors[2],
                      onTap: () => _selectDate(context),
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: numberController,
                      label: 'Your Age',
                      icon: Icons.numbers,
                      color: gradientColors[2],
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),

                _buildSection(
                  title: 'Your Message',
                  icon: Icons.message,
                  color: gradientColors[3],
                  children: [
                    _buildTextField(
                      controller: messageController,
                      label: 'Message',
                      icon: Icons.message_outlined,
                      color: gradientColors[3],
                      maxLines: 4,
                    ),
                  ],
                ),

                SizedBox(height: 30),
                _buildSubmitButton(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build a section with custom styling and gradient header
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    // Section container with bottom margin
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient header with icon and title
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Content container with shadow and rounded corners
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  // Custom text field with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    // Return styled TextFormField with custom decoration
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        prefixIcon: Icon(icon, color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color),
        ),
        filled: true,
        fillColor: color.withOpacity(0.05),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required Color color,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        prefixIcon: Icon(icon, color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color),
        ),
        filled: true,
        fillColor: color.withOpacity(0.05),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Animated date picker field with custom formatting
  Widget _buildAnimatedDateField({
    required String label,
    required DateTime? value,
    required Color color,
    required Function() onTap,
  }) {
    // Add scale animation to the date field
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: _buildDateField(
            label: label,
            value: selectedDate,
            color: color,
            onTap: onTap,
          ),
        );
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required Color color,
    required Function() onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color),
          prefixIcon: Icon(Icons.calendar_today, color: color),
          suffixIcon: Icon(Icons.arrow_drop_down, color: color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: value != null 
              ? _formatDate(value)
              : 'Select Date',
          hintStyle: TextStyle(
            color: value != null ? Colors.black87 : Colors.grey[400],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Custom time selection card with radio buttons
  Widget _buildTimeSelectionCard() {
    // Create a column with time options
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for time selection
        Text(
          'Best Time To Contact:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: gradientColors[1],
          ),
        ),
        // Generate radio buttons for each time option
        ...['Morning', 'Afternoon', 'Evening'].map((time) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: bestTimeToContact == time 
                  ? gradientColors[1].withOpacity(0.1)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: bestTimeToContact == time 
                    ? gradientColors[1]
                    : Colors.grey[300]!,
              ),
            ),
            child: RadioListTile<String>(
              title: Text(
                time,
                style: TextStyle(
                  color: bestTimeToContact == time 
                      ? gradientColors[1]
                      : Colors.grey[700],
                ),
              ),
              value: time,
              groupValue: bestTimeToContact,
              onChanged: (value) => setState(() => bestTimeToContact = value),
              activeColor: gradientColors[1],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Create instance with configuration
          final api = ApiFunctions(
            apiUrl: 'YOUR_API_URL_HERE',
            username: 'YOUR_USERNAME_HERE',
            password: 'YOUR_PASSWORD_HERE',
          );

          api.contactmeform(
            firstName: firstnameController.text,
            lastName: lastnameController.text,
            gender: Gender ?? '',
            dateOfBirth: selectedDate != null ? '${selectedDate!.toLocal()}'.split(' ')[0] : '',
            yourAge: numberController.text,
            email: emailController.text,
            bestTimeToContact: bestTimeToContact ?? '',
            message: messageController.text,
          ).then((success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(success ? 'Form submitted successfully' : 'Failed to submit form'),
                backgroundColor: success ? Colors.green : Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gradientColors[0],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: gradientColors[0].withOpacity(0.5),
        ),
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: gradientColors[2],
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: gradientColors[2],
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: Container(
            child: child,
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
