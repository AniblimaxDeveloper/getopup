import '../models/game.dart';

Game _g(String id, String n, String pub, String cat, String emoji, String dom,
        bool pop, double rating, List<Denom> denoms) =>
    Game(id: id, name: n, publisher: pub, category: cat, emoji: emoji,
        domain: dom, isPopular: pop, rating: rating, denominations: denoms);

Denom _d(String l, int p, {String? tag, int? orig}) =>
    Denom(l, p, tag: tag, originalPrice: orig);

final List<Game> games = [
  _g('mlbb', 'Mobile Legends', 'Moonton', 'MOBA', '🏆', 'mobilelegends.com', true, 4.8, [
    _d('5 Diamonds', 1500), _d('12 Diamonds', 3500), _d('19 Diamonds', 5500),
    _d('36 Diamonds', 10000), _d('74 Diamonds', 20000, tag: 'HOT', orig: 22000),
    _d('86 Diamonds', 22000), _d('172 Diamonds', 43000), _d('257 Diamonds', 65000),
    _d('706 Diamonds', 178000), _d('2195 Diamonds', 535000),
    _d('Weekly Diamond Pass', 28000, tag: 'PROMO', orig: 35000),
    _d('Twilight Pass', 149000),
  ]),
  _g('lol', 'League of Legends', 'Riot', 'MOBA', '⚔️', 'leagueoflegends.com', true, 4.7, [
    _d('575 RP', 75000), _d('650 RP', 80000), _d('1380 RP', 165000),
    _d('2800 RP', 330000), _d('5000 RP', 590000), _d('7200 RP', 845000),
  ]),
  _g('wildrift', 'Wild Rift', 'Riot', 'MOBA', '🌟', 'wildrift.leagueoflegends.com', true, 4.6, [
    _d('425 Wild Cores', 45000), _d('1000 Wild Cores', 105000),
    _d('2250 Wild Cores', 225000), _d('4000 Wild Cores', 395000),
    _d('8000 Wild Cores', 780000),
  ]),
  _g('aov', 'Arena of Valor', 'Garena', 'MOBA', '🛡️', 'arenaofvalor.com', false, 4.3, [
    _d('40 Vouchers', 10000), _d('150 Vouchers', 35000), _d('400 Vouchers', 90000),
    _d('800 Vouchers', 175000), _d('2000 Vouchers', 430000),
  ]),
  _g('hok', 'Honor of Kings', 'Tencent', 'MOBA', '👑', 'honorofkings.com', true, 4.7, [
    _d('16 Tokens', 5000), _d('80 Tokens', 22000, tag: 'HOT'),
    _d('240 Tokens', 65000), _d('400 Tokens', 105000),
    _d('800 Tokens', 200000), _d('2000 Tokens', 490000),
  ]),
  _g('smite', 'SMITE', 'Hi-Rez', 'MOBA', '🔨', 'smitegame.com', false, 4.0, [
    _d('400 Gems', 70000), _d('800 Gems', 140000), _d('1500 Gems', 250000),
    _d('2500 Gems', 400000), _d('3500 Gems', 550000),
  ]),
  _g('dota2', 'Dota 2', 'Valve', 'MOBA', '🗡️', 'dota2.com', false, 4.5, [
    _d('Dota Plus 1 Bulan', 60000), _d('Battle Pass Basic', 140000),
    _d('Battle Pass Plus', 340000), _d('Treasure Bundle', 180000),
  ]),
  _g('ff', 'Free Fire', 'Garena', 'Battle Royale', '🔥', 'ff.garena.com', true, 4.7, [
    _d('5 Diamonds', 1000), _d('70 Diamonds', 10000, tag: 'HOT'),
    _d('140 Diamonds', 20000), _d('355 Diamonds', 50000),
    _d('720 Diamonds', 100000), _d('1450 Diamonds', 200000),
    _d('Weekly Membership', 27000), _d('Monthly Membership', 79000),
  ]),
  _g('ffmax', 'Free Fire MAX', 'Garena', 'Battle Royale', '💎', 'ff.garena.com', true, 4.6, [
    _d('70 Diamonds', 10000), _d('140 Diamonds', 20000),
    _d('355 Diamonds', 50000), _d('720 Diamonds', 100000),
    _d('1450 Diamonds', 200000),
  ]),
  _g('pubgm', 'PUBG Mobile', 'Tencent', 'Battle Royale', '🎯', 'pubgmobile.com', true, 4.6, [
    _d('60 UC', 15000, tag: 'HOT'), _d('325 UC', 75000),
    _d('660 UC', 150000), _d('1800 UC', 400000),
    _d('3850 UC', 800000), _d('8100 UC', 1500000),
    _d('Royal Pass A1', 149000),
  ]),
  _g('pubgpc', 'PUBG PC', 'Krafton', 'Battle Royale', '🪂', 'pubg.com', false, 4.4, [
    _d('500 G-Coin', 75000), _d('1000 G-Coin', 145000),
    _d('2500 G-Coin', 350000), _d('5000 G-Coin', 680000),
  ]),
  _g('fortnite', 'Fortnite', 'Epic Games', 'Battle Royale', '🏗️', 'fortnite.com', false, 4.5, [
    _d('1000 V-Bucks', 145000), _d('2800 V-Bucks', 350000),
    _d('5000 V-Bucks', 590000), _d('13500 V-Bucks', 1490000),
  ]),
  _g('apex', 'Apex Legends', 'EA', 'Battle Royale', '🚀', 'ea.com', false, 4.4, [
    _d('1000 Apex Coins', 145000), _d('2150 Apex Coins', 285000),
    _d('4350 Apex Coins', 545000), _d('6700 Apex Coins', 795000),
  ]),
  _g('codm', 'COD Mobile', 'Activision', 'Battle Royale', '💥', 'callofduty.com', true, 4.7, [
    _d('80 CP', 15000), _d('420 CP', 75000, tag: 'HOT'),
    _d('880 CP', 150000), _d('2400 CP', 400000),
    _d('5000 CP', 800000), _d('Battle Pass', 220000),
  ]),
  _g('warzone', 'Warzone', 'Activision', 'Battle Royale', '🎖️', 'callofduty.com', false, 4.3, [
    _d('1000 CP', 145000), _d('2400 CP', 335000), _d('5000 CP', 680000),
    _d('10000 CP', 1290000),
  ]),
  _g('undawn', 'Undawn', 'Garena', 'Battle Royale', '🧟', 'undawn.garena.com', false, 3.8, [
    _d('60 Credits', 15000), _d('300 Credits', 70000),
    _d('980 Credits', 220000), _d('1980 Credits', 430000),
  ]),
  _g('ros', 'Rules of Survival', 'NetEase', 'Battle Royale', '🎮', 'ros.netease.com', false, 3.9, [
    _d('60 Diamonds', 15000), _d('300 Diamonds', 70000),
    _d('980 Diamonds', 220000), _d('1980 Diamonds', 430000),
  ]),
  _g('genshin', 'Genshin Impact', 'HoYoverse', 'RPG', '⚔️', 'genshin.hoyoverse.com', true, 4.8, [
    _d('60 Genesis', 16000), _d('300 Genesis', 79000, tag: 'HOT'),
    _d('980 Genesis', 249000), _d('1980 Genesis', 479000),
    _d('3280 Genesis', 799000), _d('6480 Genesis', 1490000),
    _d('Blessing of Welkin', 79000),
  ]),
  _g('hsr', 'Honkai Star Rail', 'HoYoverse', 'RPG', '🚀', 'hsr.hoyoverse.com', true, 4.7, [
    _d('60 Oneiric', 16000), _d('330 Oneiric', 79000, tag: 'HOT'),
    _d('1090 Oneiric', 249000), _d('2240 Oneiric', 479000),
    _d('3440 Oneiric', 799000), _d('Express Supply Pass', 79000),
  ]),
  _g('hi3', 'Honkai Impact 3rd', 'HoYoverse', 'RPG', '✨', 'honkaiimpact3.hoyoverse.com', false, 4.5, [
    _d('60 Crystals', 16000), _d('300 Crystals', 79000),
    _d('980 Crystals', 249000), _d('1980 Crystals', 479000),
    _d('3280 Crystals', 799000),
  ]),
  _g('zzz', 'Zenless Zone Zero', 'HoYoverse', 'RPG', '🌀', 'zenless.hoyoverse.com', true, 4.7, [
    _d('60 Monochromes', 16000), _d('300 Monochromes', 79000, tag: 'HOT'),
    _d('980 Monochromes', 249000), _d('1980 Monochromes', 479000),
    _d('3280 Monochromes', 799000), _d('Inter-Knot Membership', 79000),
  ]),
  _g('wuwa', 'Wuthering Waves', 'Kuro Games', 'RPG', '🌊', 'wutheringwaves.kurogames.com', true, 4.6, [
    _d('60 Lunites', 16000), _d('300 Lunites', 79000, tag: 'HOT'),
    _d('980 Lunites', 249000), _d('1980 Lunites', 479000),
    _d('3280 Lunites', 799000), _d('Lunite Subscription', 79000),
  ]),
  _g('tof', 'Tower of Fantasy', 'Perfect World', 'RPG', '🗼', 'toweroffantasy.com', false, 4.0, [
    _d('60 Dark Crystals', 16000), _d('300 Dark Crystals', 79000),
    _d('980 Dark Crystals', 249000), _d('1980 Dark Crystals', 479000),
    _d('Monthly Card', 79000),
  ]),
  _g('pgr', 'Punishing Gray Raven', 'Kuro Games', 'RPG', '⚡', 'pgr.kurogame.net', false, 4.4, [
    _d('60 RC', 16000), _d('300 RC', 79000), _d('980 RC', 249000),
    _d('1980 RC', 479000), _d('3280 RC', 799000),
  ]),
  _g('nikke', 'NIKKE', 'Tencent', 'RPG', '🔫', 'nikke-en.com', true, 4.6, [
    _d('60 Gems', 16000), _d('300 Gems', 79000, tag: 'HOT'),
    _d('980 Gems', 249000), _d('1980 Gems', 479000),
    _d('3280 Gems', 799000), _d('Monthly Pass', 79000),
  ]),
  _g('ba', 'Blue Archive', 'Nexon', 'RPG', '📚', 'bluearchive.nexon.com', false, 4.5, [
    _d('60 Pyroxene', 16000), _d('300 Pyroxene', 79000),
    _d('980 Pyroxene', 249000), _d('1980 Pyroxene', 479000),
    _d('Monthly Pass', 79000),
  ]),
  _g('ak', 'Arknights', 'Yostar', 'RPG', '🐰', 'arknights.global', false, 4.6, [
    _d('60 Originite', 16000), _d('300 Originite', 79000),
    _d('980 Originite', 249000), _d('Monthly Card', 79000),
  ]),
  _g('fgo', 'Fate Grand Order', 'Aniplex', 'RPG', '🔮', 'fate-go.us', false, 4.5, [
    _d('1 Saint Quartz', 6000), _d('6 Saint Quartz', 35000),
    _d('30 Saint Quartz', 165000), _d('86 Saint Quartz', 470000),
    _d('167 Saint Quartz', 900000),
  ]),
  _g('azur', 'Azur Lane', 'Yostar', 'RPG', '⚓', 'azurlane.yo-star.com', false, 4.2, [
    _d('60 Diamonds', 16000), _d('300 Diamonds', 79000),
    _d('980 Diamonds', 249000), _d('1980 Diamonds', 479000),
  ]),
  _g('dragonraja', 'Dragon Raja', 'Archosaur', 'RPG', '🐉', 'dragonraja.com', false, 3.9, [
    _d('60 Coupons', 15000), _d('300 Coupons', 72000),
    _d('1000 Coupons', 235000), _d('2000 Coupons', 460000),
  ]),
  _g('sevenk', 'Seven Knights', 'Netmarble', 'RPG', '⚔️', 'sevenknights.net', false, 3.8, [
    _d('30 Rubies', 16000), _d('150 Rubies', 79000),
    _d('500 Rubies', 249000), _d('1000 Rubies', 479000),
  ]),
  _g('afk', 'AFK Arena', 'Lilith', 'RPG', '🏰', 'afkarena.lilith.com', false, 4.4, [
    _d('60 Diamonds', 16000), _d('300 Diamonds', 79000),
    _d('980 Diamonds', 249000), _d('1980 Diamonds', 479000),
    _d('Regal Rewards', 79000),
  ]),
  _g('rok', 'Rise of Kingdoms', 'Lilith', 'Strategi', '🏛️', 'rokgame.lilith.com', false, 4.3, [
    _d('220 Gems', 15000), _d('1200 Gems', 75000),
    _d('2500 Gems', 150000), _d('6500 Gems', 375000),
    _d('Gem Monthly Card', 79000),
  ]),
  _g('coc', 'Clash of Clans', 'Supercell', 'Strategi', '⚔️', 'supercell.com', true, 4.6, [
    _d('80 Gems', 15000), _d('500 Gems', 75000, tag: 'HOT'),
    _d('1200 Gems', 150000), _d('2500 Gems', 300000),
    _d('6500 Gems', 750000), _d('Gold Pass', 79000),
  ]),
  _g('cr', 'Clash Royale', 'Supercell', 'Strategi', '🃏', 'supercell.com', false, 4.4, [
    _d('80 Gems', 15000), _d('500 Gems', 75000),
    _d('1200 Gems', 150000), _d('Diamond Pass', 79000),
  ]),
  _g('lords', 'Lords Mobile', 'IGG', 'Strategi', '👑', 'lordmobile.igg.com', false, 4.0, [
    _d('60 Gems', 15000), _d('300 Gems', 75000),
    _d('980 Gems', 235000), _d('1980 Gems', 460000),
    _d('3250 Gems', 750000),
  ]),
  _g('sos', 'State of Survival', 'FunPlus', 'Strategi', '🧟', 'stateofsurvival.funplus.com', false, 4.2, [
    _d('100 Biocaps', 15000), _d('500 Biocaps', 75000),
    _d('1500 Biocaps', 220000), _d('3000 Biocaps', 435000),
    _d('Monthly Card', 79000),
  ]),
  _g('evony', 'Evony', 'Top Games', 'Strategi', '🏰', 'evony.com', false, 3.9, [
    _d('100 Gems', 15000), _d('550 Gems', 75000),
    _d('1500 Gems', 220000), _d('3000 Gems', 435000),
  ]),
  _g('mladv', 'ML Adventure', 'Moonton', 'RPG', '📖', 'mladventure.moonton.com', false, 4.0, [
    _d('60 Diamonds', 15000), _d('300 Diamonds', 75000),
    _d('980 Diamonds', 220000), _d('1980 Diamonds', 435000),
  ]),
  _g('bs', 'Brawl Stars', 'Supercell', 'Casual', '⭐', 'supercell.com', true, 4.7, [
    _d('30 Gems', 15000), _d('80 Gems', 39000, tag: 'HOT'),
    _d('170 Gems', 79000), _d('360 Gems', 150000),
    _d('950 Gems', 390000), _d('Brawl Pass', 79000),
  ]),
  _g('hayday', 'Hay Day', 'Supercell', 'Casual', '🌾', 'supercell.com', false, 4.2, [
    _d('60 Diamonds', 15000), _d('300 Diamonds', 75000),
    _d('1200 Diamonds', 235000), _d('Farm Pass', 79000),
  ]),
  _g('roblox', 'Roblox', 'Roblox Corp', 'Casual', '🧱', 'roblox.com', true, 4.5, [
    _d('80 Robux', 15000), _d('400 Robux', 75000, tag: 'HOT'),
    _d('800 Robux', 150000), _d('1700 Robux', 300000),
    _d('4500 Robux', 750000), _d('10000 Robux', 1490000),
  ]),
  _g('minecraft', 'Minecraft', 'Mojang', 'Casual', '⛏️', 'minecraft.net', false, 4.7, [
    _d('Minecraft Java', 300000), _d('Minecraft Bedrock', 250000),
    _d('Minecoins 320', 45000), _d('Minecoins 1020', 135000),
    _d('Minecoins 1720', 220000), _d('Minecoins 3500', 450000),
  ]),
  _g('amongus', 'Among Us', 'Innersloth', 'Casual', '👽', 'innersloth.com', false, 4.3, [
    _d('Among Us (Full Game)', 35000), _d('50 Stars', 40000),
    _d('110 Stars', 80000), _d('300 Stars', 200000),
  ]),
  _g('stumble', 'Stumble Guys', 'Scopely', 'Casual', '🤸', 'stumbleguys.com', false, 4.4, [
    _d('80 Gems', 15000), _d('450 Gems', 75000),
    _d('1000 Gems', 150000), _d('Stumble Pass', 79000),
  ]),
  _g('subway', 'Subway Surfers', 'SYBO', 'Casual', '🚇', 'sybogames.com', false, 4.3, [
    _d('20 Keys', 15000), _d('80 Keys', 55000),
    _d('200 Keys', 130000), _d('Season Hunt Pass', 79000),
  ]),
  _g('candy', 'Candy Crush', 'King', 'Casual', '🍬', 'candycrush.com', false, 4.5, [
    _d('10 Gold Bars', 15000), _d('50 Gold Bars', 75000),
    _d('100 Gold Bars', 145000), _d('Event Pass', 79000),
  ]),
  _g('pool', '8 Ball Pool', 'Miniclip', 'Casual', '🎱', 'miniclip.com', false, 4.2, [
    _d('125 Cash', 15000), _d('500 Cash', 55000),
    _d('1500 Cash', 145000), _d('Pool Pass', 79000),
  ]),
  _g('pogo', 'Pokemon GO', 'Niantic', 'Casual', '🐾', 'pokemongolive.com', true, 4.5, [
    _d('100 Pokecoins', 15000), _d('550 Pokecoins', 75000),
    _d('1200 Pokecoins', 145000), _d('2500 Pokecoins', 300000),
    _d('5200 Pokecoins', 590000),
  ]),
  _g('unite', 'Pokemon Unite', 'Tencent', 'MOBA', '⚡', 'unite.pokemon.com', false, 4.0, [
    _d('245 Aeos Gems', 45000), _d('500 Aeos Gems', 90000),
    _d('1000 Aeos Gems', 175000), _d('Unite Battle Pass', 79000),
  ]),
  _g('steam', 'Steam Wallet', 'Valve', 'Voucher', '🎮', 'store.steampowered.com', true, 4.9, [
    _d('Steam Rp 12.000', 15000), _d('Steam Rp 45.000', 48000),
    _d('Steam Rp 60.000', 63000), _d('Steam Rp 90.000', 93000),
    _d('Steam Rp 120.000', 123000), _d('Steam Rp 250.000', 253000),
    _d('Steam Rp 400.000', 403000),
  ]),
  _g('gplay', 'Google Play', 'Google', 'Voucher', '▶️', 'play.google.com', true, 4.8, [
    _d('Google Play Rp 20.000', 22000), _d('Google Play Rp 50.000', 52000),
    _d('Google Play Rp 100.000', 102000), _d('Google Play Rp 150.000', 152000),
    _d('Google Play Rp 200.000', 202000), _d('Google Play Rp 500.000', 502000),
  ]),
  _g('itunes', 'iTunes / Apple', 'Apple', 'Voucher', '🍎', 'apple.com', false, 4.7, [
    _d('iTunes Rp 50.000', 52000), _d('iTunes Rp 100.000', 102000),
    _d('iTunes Rp 200.000', 202000), _d('iTunes Rp 500.000', 502000),
  ]),
  _g('psn', 'PlayStation', 'Sony', 'Voucher', '🎮', 'playstation.com', true, 4.7, [
    _d('PSN \$10', 165000), _d('PSN \$20', 320000),
    _d('PSN \$50', 780000), _d('PSN \$100', 1500000),
    _d('PS Plus 1 Bulan', 130000), _d('PS Plus 1 Tahun', 800000),
  ]),
  _g('xbox', 'Xbox', 'Microsoft', 'Voucher', '🎮', 'xbox.com', false, 4.5, [
    _d('Xbox Rp 50.000', 52000), _d('Xbox Rp 100.000', 102000),
    _d('Xbox Rp 250.000', 253000), _d('Xbox Game Pass', 149000),
  ]),
  _g('nintendo', 'Nintendo eShop', 'Nintendo', 'Voucher', '🎮', 'nintendo.com', false, 4.6, [
    _d('eShop \$10', 165000), _d('eShop \$20', 320000),
    _d('eShop \$35', 545000), _d('eShop \$50', 780000),
    _d('Nintendo Online', 65000),
  ]),
  _g('discord', 'Discord Nitro', 'Discord', 'Voucher', '💬', 'discord.com', false, 4.4, [
    _d('Nitro Basic 1 Bulan', 45000), _d('Nitro Full 1 Bulan', 145000),
    _d('Nitro Full 3 Bulan', 435000), _d('Nitro Full 1 Tahun', 1490000),
  ]),
  _g('spotify', 'Spotify Premium', 'Spotify', 'Voucher', '🎵', 'spotify.com', true, 4.6, [
    _d('Premium 1 Bulan', 55000), _d('Premium 3 Bulan', 155000),
    _d('Premium 6 Bulan', 295000), _d('Premium 12 Bulan', 550000),
  ]),
  _g('netflix', 'Netflix', 'Netflix', 'Voucher', '🎬', 'netflix.com', false, 4.3, [
    _d('Netflix Basic 1 Bulan', 54000), _d('Netflix Standard 1 Bulan', 120000),
    _d('Netflix Premium 1 Bulan', 186000), _d('Netflix Premium 3 Bulan', 558000),
  ]),
];

final List<String> categories = [
  'Semua', 'MOBA', 'Battle Royale', 'FPS', 'RPG', 'Strategi', 'Casual', 'Voucher',
];

List<Game> get popularGames => games.where((g) => g.isPopular).toList();

List<Game> searchGames(String q) {
  if (q.isEmpty) return games;
  final s = q.toLowerCase();
  return games.where((g) =>
    g.name.toLowerCase().contains(s) || g.publisher.toLowerCase().contains(s)
  ).toList();
}
