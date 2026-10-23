import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../data/games_all.dart';
import '../data/banners.dart';
import '../models/game.dart';
import '../services/app_state.dart';
import 'game_detail_screen.dart';
import 'saldo_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _category = 'Semua';

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final filtered = _category == 'Semua'
            ? games
            : games.where((g) => g.category == _category).toList();

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _glassHeader(state, rupiah)),
                SliverToBoxAdapter(child: _bannerCarousel()),
                SliverToBoxAdapter(child: _quickActions()),
                SliverToBoxAdapter(child: _popularSection(rupiah)),
                SliverToBoxAdapter(child: _categories()),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.72,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _GameCard(game: filtered[i])
                          .animate()
                          .fadeIn(delay: (i * 40).ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0),
                      childCount: filtered.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _glassHeader(AppState state, NumberFormat rupiah) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF0D47A1).withOpacity(0.9),
                const Color(0xFF42A5F5).withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.sports_esports,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 8),
                  const Text('GeTopUp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SearchScreen())),
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Saldo Saya',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(rupiah.format(state.balance),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        Text('Hai, ${state.userName}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SaldoScreen())),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Isi Saldo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1565C0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _bannerCarousel() {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.92),
        itemCount: promoBanners.length,
        itemBuilder: (context, i) {
          final b = promoBanners[i];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: b.colors),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(b.tag,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 6),
                      Text(b.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(b.subtitle,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    b.gameIconUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        const Icon(Icons.gamepad, color: Colors.white54, size: 60),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (i * 100).ms);
        },
      ),
    );
  }

  Widget _quickActions() {
    final actions = [
      ('Isi Saldo', Icons.account_balance_wallet, const Color(0xFF1565C0),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SaldoScreen()))),
      ('Cari Game', Icons.search, const Color(0xFF2E7D32),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SearchScreen()))),
      ('Voucher', Icons.local_offer, const Color(0xFFEF6C00), () {}),
      ('Bantuan', Icons.help_outline, const Color(0xFF6A1B9A), () {}),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((a) {
          return Expanded(
            child: InkWell(
              onTap: a.$4,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: a.$3.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(a.$2, color: a.$3, size: 24),
                    ),
                    const SizedBox(height: 6),
                    Text(a.$1,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _popularSection(NumberFormat rupiah) {
    final popular = allPopular.take(8).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.red, size: 20),
              SizedBox(width: 6),
              Text('Game Populer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: popular.length,
            itemBuilder: (context, i) {
              final g = popular[i];
              return Container(
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GameDetailScreen(game: g)),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1565C0).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image.network(
                              g.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => Center(
                                child: Text(g.emoji,
                                    style: const TextStyle(fontSize: 28)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(g.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          Text(rupiah.format(g.cheapest),
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF1565C0),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _categories() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: categories.map((c) {
          final active = c == _category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(c),
              selected: active,
              onSelected: (_) => setState(() => _category = c),
              selectedColor: const Color(0xFF1565C0),
              labelStyle: TextStyle(
                color: active ? Colors.white : null,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final Game game;
  const _GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    final rupiah =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                    ),
                    child: Image.network(
                      game.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => Center(
                        child: Text(game.emoji,
                            style: const TextStyle(fontSize: 40)),
                      ),
                    ),
                  ),
                  if (game.isPopular)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('HOT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 10, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${game.rating}',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade700)),
                      ],
                    ),
                    const Spacer(),
                    Text(rupiah.format(game.cheapest),
                        style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF1565C0),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
