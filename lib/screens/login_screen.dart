import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/app_state.dart';
import '../services/auth_service.dart';
import 'root_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  String? _error;

  Future<void> _googleLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final credential = await AuthService.signInWithGoogle();
      final user = credential.user;
      if (user != null) {
        await AppState.instance.syncFirebaseUser(
          uid: user.uid,
          name: user.displayName ?? 'Player',
          email: user.email ?? '',
          photoUrl: user.photoURL,
        );
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const RootScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? 'Login gagal');
    } catch (e) {
      setState(() => _error = 'Terjadi kesalahan: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.sports_esports,
                        size: 72, color: Color(0xFF1565C0)),
                  ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 24),
                  const Text('GeTopUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      )),
                  const SizedBox(height: 8),
                  const Text('85+ Game · Login Aman dengan Google',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
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
                        const SizedBox(height: 8),
                        const Text(
                          'Gunakan akun Google Anda untuk menyimpan saldo & riwayat secara aman',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _loading ? null : _googleLogin,
                          icon: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2))
                              : const Icon(Icons.g_mobiledata, size: 28),
                          label: Text(_loading
                              ? 'Memproses...'
                              : 'Login dengan Google'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(_error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12)),
                        ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
