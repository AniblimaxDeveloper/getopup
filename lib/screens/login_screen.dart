import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/app_state.dart';
import 'root_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  String _mode = 'main';

  Future<void> _googleLogin() async {
    final controller = TextEditingController();
    final email = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login dengan Google'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mode demo. Untuk Google Sign-In asli, ikuti panduan setup.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Google',
                hintText: 'nama@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              final url = Uri.parse(
                  'https://firebase.google.com/docs/auth/android/google-signin');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            child: const Text('Setup Guide'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
    if (email == null || email.isEmpty) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    await AppState.instance.loginWithGoogleMock(email);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RootScreen()),
      (route) => false,
    );
  }

  Future<void> _guestLogin() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login sebagai Tamu'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nama Anda',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    await AppState.instance.loginAsGuest(name);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RootScreen()),
      (route) => false,
    );
  }

  Future<void> _pinLogin() async {
    if (!AppState.instance.hasPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada PIN. Gunakan Tamu atau Google.')),
      );
      return;
    }
    final controller = TextEditingController();
    final pin = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Masukkan PIN'),
        content: TextField(
          controller: controller,
          autofocus: true,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 12),
          decoration: const InputDecoration(
            counterText: '',
            hintText: '••••',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Buka'),
          ),
        ],
      ),
    );
    if (pin == null) return;
    if (!AppState.instance.verifyPin(pin)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN salah')),
      );
      return;
    }
    AppState.instance.login();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RootScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.sports_esports,
                        size: 72, color: Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 24),
                  const Text('GeTopUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      )),
                  const SizedBox(height: 8),
                  const Text('85+ Game · Top Up Tercepat',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Masuk ke Akun',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _loading ? null : _googleLogin,
                          icon: const Icon(Icons.g_mobiledata, size: 28),
                          label: const Text('Login dengan Google'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _loading ? null : _pinLogin,
                          icon: const Icon(Icons.lock_outline),
                          label: const Text('Login dengan PIN'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF1565C0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: _loading ? null : _guestLogin,
                          icon: const Icon(Icons.person_outline),
                          label: const Text('Lanjut sebagai Tamu'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Dengan masuk, Anda setuju dengan Syarat & Ketentuan GeTopUp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('© 2024 getopup.com',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6), fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
