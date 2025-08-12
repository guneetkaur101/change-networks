
//proper working ui bublles
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

// Brand palette (kept blue-ish and vibrant)
const List<Color> changeNetworkColors = [
  Color(0xFF2C3E50), // Dark blue
  Color(0xFF3498DB), // Blue
  Color(0xFF6EC5FF), // Light blue
  Color(0xFF1ABC9C), // Teal accent
];

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthSwitcher();
  }
}

/// AuthSwitcher wraps left animated side + right auth form
class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({Key? key}) : super(key: key);

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> with TickerProviderStateMixin {
  bool isLogin = true;

  // Background gradient animation
  late final AnimationController _bgController;
  late final Animation<Color?> _bgColor1;
  late final Animation<Color?> _bgColor2;

  // animated text rotation
  final List<String> animatedTexts = [
    "Excellence",
    "Innovation",
    "Growth",
    "Scale",
    "Speed",
  ];
  int _currentTextIndex = 0;
  Timer? _rotatorTimer;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat(reverse: true);

    _bgColor1 = ColorTween(begin: changeNetworkColors[0], end: changeNetworkColors[2]).animate(_bgController);
    _bgColor2 = ColorTween(begin: changeNetworkColors[1], end: changeNetworkColors[3]).animate(_bgController);

    // rotate animated text every 3 seconds
    _rotatorTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % animatedTexts.length;
      });
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _rotatorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _bgColor1.value ?? changeNetworkColors[0],
                  _bgColor2.value ?? changeNetworkColors[1],
                ],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 880;
                  return Stack(
                    children: [
                      // Bubbles layer (full-screen)
                      Positioned.fill(child: BubbleBackground()),

                      // Main content row
                      Row(
                        children: [
                          // Left animated column (now only static + dynamic text)
                          if (!isNarrow)
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 36.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'CHANGE Networks',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 62,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Your Global IT Partner for ',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 20,
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 600),
                                          transitionBuilder: (child, anim) {
                                            return FadeTransition(
                                              opacity: anim,
                                              child: SlideTransition(
                                                position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
                                                    .animate(anim),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            animatedTexts[_currentTextIndex],
                                            key: ValueKey(animatedTexts[_currentTextIndex]),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),


                                  ],
                                ),
                              ),
                            ),

                          // Right: auth form
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: Container(
                                    width: isNarrow ? min(constraints.maxWidth * 0.9, 420) : 520,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.14),
                                          Colors.white.withOpacity(0.06),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        )
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // toggle
                                          Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.55),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => setState(() => isLogin = false),
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      decoration: BoxDecoration(
                                                        color: !isLogin ? Colors.white : Colors.transparent,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Signup',
                                                          style: TextStyle(
                                                            color: !isLogin ? Colors.black : Colors.white,
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
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      decoration: BoxDecoration(
                                                        color: isLogin ? Colors.white : Colors.transparent,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Login',
                                                          style: TextStyle(
                                                            color: isLogin ? Colors.black : Colors.white,
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
                                          const SizedBox(height: 20),
                                          // selected form
                                          isLogin
                                              ? LoginForm(onLoginSuccess: () {
                                            setState(() => isLogin = false);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Login Successful')),
                                            );
                                          })
                                              : const SignupForm(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// === BubbleBackground: unchanged ===
class BubbleBackground extends StatefulWidget {
  const BubbleBackground({super.key});

  @override
  State<BubbleBackground> createState() => _BubbleBackgroundState();
}

class _BubbleBackgroundState extends State<BubbleBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _rnd = Random();
  final List<_BubbleSpec> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    for (int i = 0; i < 14; i++) {
      _bubbles.add(_BubbleSpec(
        startX: _rnd.nextDouble(),
        startY: _rnd.nextDouble(),
        size: 40.0 + _rnd.nextDouble() * 120.0,
        speedFactor: 0.2 + _rnd.nextDouble() * 1.2,
        imagePath: i % 2 == 0 ? 'assets/icons/changelogo.png': 'assets/icons/cisco.jpg',
        rotation: _rnd.nextDouble() * pi * 2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;

      return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          return Stack(
            children: _bubbles.map((b) {
              final travel = height + b.size;
              final raw = (b.startY * travel) - (t * b.speedFactor * travel);
              double ypos = raw % travel;
              if (ypos < -b.size) ypos += travel;
              final left = (b.startX * (width - b.size)).clamp(0.0, max(0.0, width - b.size));
              final driftX = sin((t * 2 * pi) + b.startX * 10) * 10;
              final top = ypos - b.size / 2;

              return Positioned(
                left: (left + driftX).clamp(0.0, max(0.0, width - b.size)),
                top: top,
                child: Opacity(
                  opacity: 0.08 + (0.5 * (1 - (b.size / 160))),
                  child: Transform.rotate(
                    angle: b.rotation * (0.2 * sin(t * 2 * pi + b.startX * 5)),
                    child: SizedBox(
                      width: b.size,
                      height: b.size,
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(b.imagePath, fit: BoxFit.cover),
                              Center(
                                // child: Text(
                                //   style: TextStyle(
                                //     color: Colors.white.withOpacity(0.12 + (b.size / 300)),
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: b.size / 4,
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    });
  }
}

class _BubbleSpec {
  final double startX;
  final double startY;
  final double size;
  final double speedFactor;
  final String imagePath;
  final double rotation;
  _BubbleSpec({
    required this.startX,
    required this.startY,
    required this.size,
    required this.speedFactor,
    required this.imagePath,
    required this.rotation,
  });
}

/// SignupForm
class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Widget _buildTextField(String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isMain) {
    return TextFormField(
      obscureText: isMain ? _obscurePassword : _obscureConfirmPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        suffixIcon: IconButton(
          icon: Icon((isMain ? _obscurePassword : _obscureConfirmPassword) ? Icons.visibility_off : Icons.visibility),
          color: Colors.white,
          onPressed: () {
            setState(() {
              if (isMain) _obscurePassword = !_obscurePassword;
              else _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign Up to your account to continue',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
        ),
          const SizedBox(height: 12),
          _buildTextField('Full Name', Icons.person),
          const SizedBox(height: 12),
          _buildTextField('Email', Icons.email),
          const SizedBox(height: 12),
          _buildPasswordField('Password', true),
          const SizedBox(height: 12),
          _buildPasswordField('Confirm Password', false),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // white button
                  foregroundColor: Colors.black, // black text
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Send OTP+'),
            ),
          ),
        ],
      ),
    );
  }
}

/// LoginForm
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Welcome Back!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
           color: Colors.white
      ),),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
            ),
            style: const TextStyle(color: Colors.white),
            // keyboardType: TextInputType.emailAddress,
            validator: (v) => v == null || v.isEmpty ? 'Please enter email' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.white),
                       enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                       ),
                       focusedBorder: const OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.white),
                       ),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility,color: Colors.white,),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (v) => v == null || v.isEmpty ? 'Please enter password' : null,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
