import '../models/game.dart';

final List<Game> games = [
  Game(
    id: 'mlbb', name: 'Mobile Legends', publisher: 'Moonton',
    category: 'MOBA', emoji: '🏆',
    denominations: [
      Denom('5 Diamonds', 1500),
      Denom('12 Diamonds', 3500),
      Denom('19 Diamonds', 5500),
      Denom('36 Diamonds', 10000),
      Denom('74 Diamonds', 20000, tag: 'HOT'),
      Denom('86 Diamonds', 22000),
      Denom('172 Diamonds', 43000),
      Denom('257 Diamonds', 65000),
      Denom('706 Diamonds', 178000),
      Denom('Weekly Diamond Pass', 28000, tag: 'PROMO'),
      Denom('Twilight Pass', 149000),
    ],
  ),
  Game(
    id: 'ff', name: 'Free Fire', publisher: 'Garena',
    category: 'Battle Royale', emoji: '🔥',
    denominations: [
      Denom('5 Diamonds', 1000),
      Denom('70 Diamonds', 10000, tag: 'HOT'),
      Denom('140 Diamonds', 20000),
      Denom('355 Diamonds', 50000),
      Denom('720 Diamonds', 100000),
      Denom('Weekly Membership', 27000),
      Denom('Monthly Membership', 79000),
    ],
  ),
  Game(
    id: 'pubg', name: 'PUBG Mobile', publisher: 'Tencent',
    category: 'Battle Royale', emoji: '🎯',
    denominations: [
      Denom('60 UC', 15000, tag: 'HOT'),
      Denom('325 UC', 75000),
      Denom('660 UC', 150000),
      Denom('1800 UC', 400000),
      Denom('3850 UC', 800000),
      Denom('Royal Pass A1', 149000),
    ],
  ),
  Game(
    id: 'genshin', name: 'Genshin Impact', publisher: 'HoYoverse',
    category: 'RPG', emoji: '⚔️',
    denominations: [
      Denom('60 Genesis', 16000),
      Denom('300 Genesis', 79000, tag: 'HOT'),
      Denom('980 Genesis', 249000),
      Denom('1980 Genesis', 479000),
      Denom('3280 Genesis', 799000),
      Denom('Blessing of Welkin', 79000),
    ],
  ),
  Game(
    id: 'valorant', name: 'Valorant', publisher: 'Riot Games',
    category: 'FPS', emoji: '🎮',
    denominations: [
      Denom('125 VP', 15000, tag: 'HOT'),
      Denom('420 VP', 50000),
      Denom('700 VP', 80000),
      Denom('1375 VP', 150000),
      Denom('2400 VP', 250000),
    ],
  ),
  Game(
    id: 'codm', name: 'Call of Duty Mobile', publisher: 'Activision',
    category: 'FPS', emoji: '💥',
    denominations: [
      Denom('80 CP', 15000),
      Denom('420 CP', 75000, tag: 'HOT'),
      Denom('880 CP', 150000),
      Denom('2400 CP', 400000),
      Denom('Battle Pass', 220000),
    ],
  ),
  Game(
    id: 'hok', name: 'Honor of Kings', publisher: 'Tencent',
    category: 'MOBA', emoji: '👑',
    denominations: [
      Denom('16 Tokens', 5000),
      Denom('80 Tokens', 22000, tag: 'HOT'),
      Denom('240 Tokens', 65000),
      Denom('400 Tokens', 105000),
      Denom('800 Tokens', 200000),
    ],
  ),
  Game(
    id: 'hsr', name: 'Honkai Star Rail', publisher: 'HoYoverse',
    category: 'RPG', emoji: '🚀',
    denominations: [
      Denom('60 Oneiric', 16000),
      Denom('330 Oneiric', 79000, tag: 'HOT'),
      Denom('1090 Oneiric', 249000),
      Denom('2240 Oneiric', 479000),
      Denom('Express Supply Pass', 79000),
    ],
  ),
  Game(
    id: 'coc', name: 'Clash of Clans', publisher: 'Supercell',
    category: 'Strategi', emoji: '⚔️',
    denominations: [
      Denom('80 Gems', 15000),
      Denom('500 Gems', 75000, tag: 'HOT'),
      Denom('1200 Gems', 150000),
      Denom('2500 Gems', 300000),
      Denom('Gold Pass', 79000),
    ],
  ),
  Game(
    id: 'cr', name: 'Clash Royale', publisher: 'Supercell',
    category: 'Strategi', emoji: '🃏',
    denominations: [
      Denom('80 Gems', 15000),
      Denom('500 Gems', 75000, tag: 'HOT'),
      Denom('1200 Gems', 150000),
      Denom('Diamond Pass', 79000),
    ],
  ),
  Game(
    id: 'roblox', name: 'Roblox', publisher: 'Roblox Corp',
    category: 'Casual', emoji: '🧱',
    denominations: [
      Denom('80 Robux', 15000, tag: 'HOT'),
      Denom('400 Robux', 75000),
      Denom('800 Robux', 150000),
      Denom('1700 Robux', 300000),
    ],
  ),
  Game(
    id: 'steam', name: 'Steam Wallet', publisher: 'Valve',
    category: 'Voucher', emoji: '🎁',
    denominations: [
      Denom('Steam Rp 12.000', 15000),
      Denom('Steam Rp 45.000', 48000, tag: 'HOT'),
      Denom('Steam Rp 60.000', 63000),
      Denom('Steam Rp 90.000', 93000),
      Denom('Steam Rp 120.000', 123000),
    ],
  ),
  Game(
    id: 'gplay', name: 'Google Play', publisher: 'Google',
    category: 'Voucher', emoji: '▶️',
    denominations: [
      Denom('Google Play Rp 20.000', 22000),
      Denom('Google Play Rp 50.000', 52000, tag: 'HOT'),
      Denom('Google Play Rp 100.000', 102000),
      Denom('Google Play Rp 150.000', 152000),
    ],
  ),
  Game(
    id: 'psn', name: 'PlayStation', publisher: 'Sony',
    category: 'Voucher', emoji: '🎮',
    denominations: [
      Denom('PSN $10', 165000, tag: 'HOT'),
      Denom('PSN $20', 320000),
      Denom('PSN $50', 780000),
    ],
  ),
];

final List<String> categories = [
  'Semua', 'MOBA', 'FPS', 'Battle Royale', 'RPG', 'Strategi', 'Casual', 'Voucher'
];
