import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormLogic extends StatefulWidget {
  const FormLogic({super.key});

  @override
  State<FormLogic> createState() => _FormLogicState();
}

class _FormLogicState extends State<FormLogic> {
  String request = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isPasswordVisible = false;

  void _update() {
    setState(() {});
  }

  @override
  void initState() {
    _email.addListener(_update);
    _password.addListener(_update);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonActive = _email.text.isNotEmpty && _password.text.isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xff121212),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),

                  /// ---------------- Email ----------------
                  TextFormField(
                    controller: _email,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.endsWith("@gmail.com")) {
                        return 'Enter a valid Gmail';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white70,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ---------------- Password ----------------
                  TextFormField(
                    controller: _password,
                    maxLength: 9,
                    obscureText: !_isPasswordVisible,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 9) {
                        return 'Password must be 9 digits';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white54),

                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white70,
                      ),

                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        }),
                        child: Icon(
                          _isPasswordVisible
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_fill,
                          color: Colors.white70,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// ---------------- Login Button ----------------
                  GestureDetector(
                    onTap: () {
                      if (!isButtonActive) return;

                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          request = "Request Sent ✓";
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isButtonActive
                            ? Colors.blueAccent
                            : Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),

                  /// ---------------- Response ----------------
                  Text(
                    "Request : $request",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  /// ---------------- Live Controllers Preview ----------------
                  Text(
                    "Email : ${_email.text}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Password : ${_password.text}",
                    style: const TextStyle(color: Colors.white70),
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
