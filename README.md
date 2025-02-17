# 📞 Contact Form App  

A beautiful and user-friendly Flutter contact form application with elegant onboarding screens and seamless integration with WordPress Formidable Forms.

![rahaftwal-form-flutter](https://github.com/user-attachments/assets/31a106f5-2477-4b7a-ab0c-228fc018cea1)

---

## 🌟 Features  
- 🚀 **Elegant Onboarding Flow** – Interactive welcome screens introducing users to the app.  
- 📝 **Comprehensive Contact Form** – Includes personal details, email, gender, age, contact preferences, and message field.  
- 🔗 **WordPress Integration** – Uses Formidable Forms API for seamless form submissions.  
- 🔒 **Secure API Communication** – Implements Basic Authentication for data security.  
- 📊 **Session Management** – Saves onboarding progress using SharedPreferences.  
- 🎨 **Modern UI & UX** – Smooth animations, gradient themes, and a beautiful user interface.  

---


### 📌 Prerequisites  
Ensure you have the following installed:  
- ✅ Flutter SDK  
- ✅ Dart SDK  
- ✅ Android Studio / VS Code  

### 📦 Required Dependencies  
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
  shared_preferences: ^2.3.1
```


## 💻 Usage  

### 🔹 Onboarding Screens  
The app starts with beautifully designed onboarding screens, shown only on the first launch.

### 🔹 Contact Form  
Users can enter:  
✔ First and Last Name  
✔ Gender Selection  
✔ Email Input  
✔ Best Time to Contact  
✔ Date of Birth Picker  
✔ Age Input  
✔ Message Field  

Upon submission, the form data is sent securely to a WordPress backend using the Formidable Forms API.

---

## 📁 Project Structure  
```yaml
lib/
├── main.dart          # Main application file
├── onboarding.dart    # Onboarding screen logic
├── contact_form.dart  # Contact form UI and validation
└── functions.dart     # API integration functions
```

---

## 🔗 API Integration  
This app integrates with WordPress Formidable Forms API for form submissions. It uses **Basic Authentication** for secure communication.  

---

## 🛠 Technologies Used  
- **Flutter & Dart** – For building the mobile application  
- **Formidable Forms API** – For form submission handling  
- **Shared Preferences** – For storing onboarding progress  

---

## 🏆 Skills You Gain  
✔ Flutter Development  
✔ API Integration  
✔ Mobile UI/UX Design  
✔ WordPress Plugin Integration  
✔ Secure Data Handling  

---


## 🤝 Contributing  
Want to contribute? Feel free to submit a pull request! 🚀  

Designed and developed by **Rahaf Twal**
