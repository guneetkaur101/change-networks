// import 'package:flutter/material.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _UnderConstructionPage(title: 'LoginPage');
//   }
// }
//   class _UnderConstructionPage extends StatelessWidget {
//   final String title;
//   const _UnderConstructionPage({required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//   return Center(
//   child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   Icon(
//   Icons.construction,
//   size: 64,
//   color: const Color.fromARGB(255, 72, 72, 72),
//   ),
//   SizedBox(height: 16),
//   Text(
//   '$title under construction',
//   style: Theme.of(context).textTheme.headlineSmall,
//   ),
//   SizedBox(height: 8),
//   Text(
//   'We are working hard to bring this page to you soon!',
//   style: Theme.of(context).textTheme.bodyMedium,
//   ),
//   ElevatedButton(
//   onPressed: () {
//   Navigator.pop(context, true); // return success
//   },
//   child: const Text("Login Now"),
//   ),
//   ],
//   ),
//   );
//   }
//   }
//
//
//

//different signup and login
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import 'dart:ui';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const AuthSwitcher();
//   }
// }
//
// class AuthSwitcher extends StatefulWidget {
//   const AuthSwitcher({super.key});
//
//   @override
//   State<AuthSwitcher> createState() => _AuthSwitcherState();
// }
//
// class _AuthSwitcherState extends State<AuthSwitcher> {
//   bool isLogin = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Container(
//       decoration: BoxDecoration(
//       gradient: LinearGradient(
//       colors: [Colors.blue.shade100, Colors.white],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     ),
//     ),
//       child:Center(
//       child: Container(
//         width: 500,
//         decoration: BoxDecoration(
//           color: const Color(0xFF0D1B2A),
//
//           borderRadius: BorderRadius.circular(24),
//         ),
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Toggle Button
//             Container(
//               width:200,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               padding: const EdgeInsets.all(4),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () => setState(() => isLogin = false),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: !isLogin ? Colors.white : Colors.black,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Signup',
//                             style: TextStyle(
//                               color: !isLogin ? Colors.black : Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () => setState(() => isLogin = true),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: isLogin ? Colors.white : Colors.black,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: isLogin ? Colors.black : Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             isLogin ? LoginForm(
//               onLoginSuccess: () {
//                 setState(() {
//                   isLogin = false; // or true if you want to switch view
//                 });
//
//                 // Optional: show a snackbar or redirect
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Login Successful!")),
//                 );
//               },
//             ): const SignupForm(),
//           ],
//         ),
//       ),
//     ),
//       )
//     );
//   }
// }
// class SignupForm extends StatelessWidget {
//   const SignupForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'First name',
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: 'Last name',
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           TextFormField(
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.email),
//               hintText: 'Enter your email',
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 12),
//           TextFormField(
//             decoration: const InputDecoration(
//               prefixIcon: Text('🇸🇪', style: TextStyle(fontSize: 20)),
//               hintText: '7658439243',
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.phone,
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: const Text('Create an account'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class LoginForm extends StatefulWidget {
//   final VoidCallback onLoginSuccess;
//   const LoginForm({super.key, required this.onLoginSuccess});
//
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   void _handleLogin() {
//     if (_formKey.currentState!.validate()) {
//       // Handle login logic here
//       String email = _emailController.text.trim();
//       String password = _passwordController.text;
//       print("Login with: $email, $password");
//       // Add your authentication code here
//     }
//   }
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       Provider.of<AuthProvider>(context, listen: false).login();
//       widget.onLoginSuccess();
//     }
//   }
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 400,
//         child: Card(
//           elevation: 6,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Welcome Back!', style: Theme.of(context).textTheme.headlineSmall),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) =>
//                     value == null || value.isEmpty ? 'Please enter your email' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: const OutlineInputBorder(),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                     validator: (value) =>
//                     value == null || value.isEmpty ? 'Please enter your password' : null,
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       // onPressed: _handleLogin,
//                       onPressed:_submit,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text('Login'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }

//image with white color
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const AuthSwitcher();
//   }
// }
//
// class AuthSwitcher extends StatefulWidget {
//   const AuthSwitcher({super.key});
//
//   @override
//   State<AuthSwitcher> createState() => _AuthSwitcherState();
// }
//
// class _AuthSwitcherState extends State<AuthSwitcher> {
//   bool isLogin = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           // gradient: LinearGradient(
//           //   colors: [Colors.blue.shade100, Colors.white],
//           //   begin: Alignment.topLeft,
//           //   end: Alignment.bottomRight,
//           // ),
//           // color: const Color(0xFF0D1B2A),
//           image: DecorationImage(
//             image: AssetImage('assets/icons/bg2.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//
//         child: Center(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(24),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//               child: Container(
//                 width: 500,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.25),
//                       Colors.white.withOpacity(0.05),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.3),
//                     width: 1.5,
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Toggle Button
//                     Container(
//                       width: 200,
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       padding: const EdgeInsets.all(4),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () => setState(() => isLogin = false),
//                               child: Container(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 12),
//                                 decoration: BoxDecoration(
//                                   color: !isLogin
//                                       ? Colors.white
//                                       : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Signup',
//                                     style: TextStyle(
//                                       color: !isLogin
//                                           ? Colors.black
//                                           : Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () => setState(() => isLogin = true),
//                               child: Container(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 12),
//                                 decoration: BoxDecoration(
//                                   color: isLogin
//                                       ? Colors.white
//                                       : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       color: isLogin
//                                           ? Colors.black
//                                           : Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     isLogin
//                         ? LoginForm(
//                       onLoginSuccess: () {
//                         setState(() {
//                           isLogin = false;
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("Login Successful!")),
//                         );
//                       },
//                     )
//                         : const SignupForm(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SignupForm extends StatefulWidget {
//   const SignupForm({super.key});
//
//   @override
//   State<SignupForm> createState() => _SignupFormState();
// }
//
// class _SignupFormState extends State<SignupForm> {
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Sign Up to your account to continue',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//          // Full Name
//           TextFormField(
//             decoration: const InputDecoration(
//               labelText: 'Full Name',
//               prefixIcon: Icon(Icons.person,color: Colors.white),
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//             style: const TextStyle(color: Colors.white),
//           ),
//
//           const SizedBox(height: 16),
//
//         // Email
//     TextFormField(
//     decoration: const InputDecoration(
//     labelText: 'Email',
//       prefixIcon: Icon(Icons.email,color: Colors.white),
//     labelStyle: TextStyle(color: Colors.white),
//     enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//     focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//     ),
//     style: const TextStyle(color: Colors.white),
//     ),
//
//     const SizedBox(height: 16),
//
// // Password
//     TextFormField(
//       obscureText: _obscurePassword,
//     decoration: InputDecoration(
//     labelText: 'Password',
//     labelStyle: const TextStyle(color: Colors.white),
//       prefixIcon: const Icon(Icons.security_sharp,color:Colors.white),
//     enabledBorder: const OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//     focusedBorder: const OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//       suffixIcon: IconButton(
//         icon: Icon(
//           _obscurePassword
//               ? Icons.visibility_off
//               : Icons.visibility,
//           color: Colors.white,
//
//         ),
//         onPressed: () {
//           setState(() {
//             _obscurePassword = !_obscurePassword;
//           });
//         },
//       ),
//     ),
//     style: const TextStyle(color: Colors.white),
//     ),
//
//     const SizedBox(height: 16),
//
// // Confirm Password
//     TextFormField(
//       obscureText: _obscureConfirmPassword,
//     decoration: InputDecoration(
//     labelText: 'Confirm Password',
//       prefixIcon: const Icon(Icons.password,color:Colors.white),
//     labelStyle: const TextStyle(color: Colors.white),
//     enabledBorder: const OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//     focusedBorder: const OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white),
//     ),
//       suffixIcon: IconButton(
//         icon: Icon(
//           _obscureConfirmPassword
//               ? Icons.visibility_off
//               : Icons.visibility,
//           color: Colors.white, // <-- icon color
//
//         ),
//         onPressed: () {
//           setState(() {
//             _obscureConfirmPassword = !_obscureConfirmPassword;
//           });
//         },
//       ),
//     ),
//     style: const TextStyle(color: Colors.white),
//     ),
//
//     const SizedBox(height: 24),
//
// // Send OTP Button
//     SizedBox(
//     width: double.infinity,
//     child: ElevatedButton(
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.white, // white button
//     foregroundColor: Colors.black, // black text
//     padding: const EdgeInsets.symmetric(vertical: 16),
//     ),
//     child: const Text('Send OTP'),
//     ),
//     ),
//
//         ],
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   final VoidCallback onLoginSuccess;
//   const LoginForm({super.key, required this.onLoginSuccess});
//
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       Provider.of<AuthProvider>(context, listen: false).login();
//       widget.onLoginSuccess();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 400,
//         child: Card(
//           color: Colors.transparent,
//           elevation: 0,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('Welcome Back!',
//                       // style: Theme.of(context).textTheme.headlineSmall,),
//     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//     color: Colors.white, // <-- White text
//     fontWeight: FontWeight.bold,),),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       labelStyle: TextStyle(color: Colors.white),
//                       // border: OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your email'
//                         : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       labelStyle: const TextStyle(color: Colors.white),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       // border: const OutlineInputBorder(),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: Colors.white, // <-- icon color
//
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your password'
//                         : null,
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _submit,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white, // <-- white button
//                           foregroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text('Login'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//gradient effect with black color
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthSwitcher();
  }
}

class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // color: const Color(0xFF0D1B2A),
          // image: DecorationImage(
          //   image: AssetImage('assets/icons/bg2.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),

        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.25),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle Button
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isLogin = false),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: !isLogin
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
                                      color: !isLogin
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isLogin = true),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isLogin
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: isLogin
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    isLogin
                        ? LoginForm(
                      onLoginSuccess: () {
                        setState(() {
                          isLogin = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Login Successful!")),
                        );
                      },
                    )
                        : const SignupForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign Up to your account to continue',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Full Name
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person,color: Colors.black),
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),

          const SizedBox(height: 16),

          // Email
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email,color: Colors.black),
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),

          const SizedBox(height: 16),

// Password
          TextFormField(
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.security_sharp,color:Colors.black),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black,

                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),

          const SizedBox(height: 16),

// Confirm Password
          TextFormField(
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.password,color:Colors.black),
              labelStyle: const TextStyle(color: Colors.black),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black, // <-- icon color

                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),

          const SizedBox(height: 24),

// Send OTP Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // white button
                foregroundColor: Colors.black, // black text
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Send OTP'),
            ),
          ),

        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  const LoginForm({super.key, required this.onLoginSuccess});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;



  void _submit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false).login();
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome Back!',
                    // style: Theme.of(context).textTheme.headlineSmall,),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black, // <-- White text
                      fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      // border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your email'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,

                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      // border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black, // <-- icon color

                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your password'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // <-- white button
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
