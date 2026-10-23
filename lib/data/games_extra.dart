import '../models/game.dart';

Game _g(String id, String n, String pub, String cat, String emoji, String dom,
        bool pop, double rating, List<Denom> denoms) =>
    Game(id: id, name: n, publisher: pub, category: cat, emoji: emoji,
        domain: dom, isPopular: pop, rating: rating, denominations: denoms);

Denom _d(String l, int p, {String? tag, int? orig}) =>
    Denom(l, p, tag: tag, originalPrice: orig);

final List<Game> extraGames = [
  _g('ragnarok', 'Ragnarok X', 'Gravity', 'MMORPG', '⚔️', 'ragnarokx.com', false, 4.4, [
    _d('60 Kafra', 16000), _d('300 Kafra', 79000), _d('980 Kafra', 249000),
  ]),
  _g('dragonraja', 'Dragon Raja', 'Archosaur', 'MMORPG', '🐉', 'dragonraja.com', false, 4.1, [
    _d('60 Coupons', 15000), _d('300 Coupons', 72000), _d('1000 Coupons', 235000),
  ]),
  _g('lightofthel', 'Light of Thel', 'Neowiz', 'MMORPG', '✨', 'lightofthel.com', false, 4.0, [
    _d('100 Gems', 15000), _d('500 Gems', 72000), _d('1500 Gems', 220000),
  ]),
  _g('deltaforce', 'Delta Force', 'TiMi', 'FPS', '🎯', 'deltaforce.garena.com', false, 4.3, [
    _d('100 Coins', 15000), _d('500 Coins', 72000), _d('1500 Coins', 220000),
  ]),
  _g('duetnight', 'Duet Night Abyss', 'Pan Studio', 'RPG', '🌙', 'duetnightabyss.com', false, 4.2, [
    _d('60 Crystals', 16000), _d('300 Crystals', 79000), _d('980 Crystals', 249000),
  ]),
  _g('ete', 'E.T.E Chronicle', 'E.T.E', 'RPG', '💫', 'ete.game', false, 4.0, [
    _d('60 Gems', 16000), _d('300 Gems', 79000), _d('980 Gems', 249000),
  ]),
  _g('haikyu', 'Haikyu Fly High', 'Garena', 'Sports', '🏐', 'haikyu.garena.com', false, 4.4, [
    _d('60 Diamonds', 15000), _d('300 Diamonds', 72000), _d('980 Diamonds', 220000),
  ]),
  _g('heartopia', 'Heartopia', 'XD', 'Casual', '💖', 'heartopia.com', false, 4.1, [
    _d('60 Diamonds', 15000), _d('300 Diamonds', 72000), _d('980 Diamonds', 220000),
  ]),
  _g('magicchess', 'Magic Chess Go Go', 'Moonton', 'Strategy', '♟️', 'magicchess.moonton.com', false, 4.3, [
    _d('50 Diamonds', 10000), _d('150 Diamonds', 30000), _d('500 Diamonds', 100000),
  ]),
  _g('modernwarships', 'Modern Warships', 'Artstorm', 'Strategy', '🚢', 'modernwarships.com', false, 4.2, [
    _d('100 Gold', 15000), _d('500 Gold', 72000), _d('1500 Gold', 220000),
  ]),
  _g('persona5', 'Persona 5 Phantom X', 'Sega', 'RPG', '🎭', 'persona5x.com', false, 4.6, [
    _d('60 Gems', 16000), _d('300 Gems', 79000), _d('980 Gems', 249000),
  ]),
  _g('ragnaroket', 'Ragnarok Endless Trails', 'Gravity', 'MMORPG', '🗡️', 'ragnaroket.com', false, 4.0, [
    _d('60 Kafra', 16000), _d('300 Kafra', 79000), _d('980 Kafra', 249000),
  ]),
  _g('division', 'The Division Resurgence', 'Ubisoft', 'Shooter', '🎯', 'thedivision.com', false, 4.3, [
    _d('100 Credits', 15000), _d('500 Credits', 72000), _d('1500 Credits', 220000),
  ]),
  _g('umamusume', 'Umamusume Pretty Derby', 'Cygames', 'Sports', '🐎', 'umamusume.com', false, 4.5, [
    _d('60 Jewels', 16000), _d('300 Jewels', 79000), _d('980 Jewels', 249000),
  ]),
  _g('wherewinds', 'Where Winds Meet', 'NetEase', 'RPG', '🌬️', 'wherewindsmeet.com', false, 4.4, [
    _d('60 Echo', 16000), _d('300 Echo', 79000), _d('980 Echo', 249000),
  ]),
  _g('inkvasion', 'Inkvasion', 'Inkvasion', 'Casual', '🖌️', 'inkvasion.com', false, 4.0, [
    _d('60 Gems', 15000), _d('300 Gems', 72000), _d('980 Gems', 220000),
  ]),
  _g('ragnaroklv', 'Ragnarok Landverse', 'Gravity', 'MMORPG', '🌍', 'ragnaroklv.com', false, 4.1, [
    _d('60 Kafra', 16000), _d('300 Kafra', 79000), _d('980 Kafra', 249000),
  ]),
  _g('ragnarokidle', 'Ragnarok Idle Adventure', 'Gravity', 'Idle', '💤', 'ragnarokidle.com', false, 4.0, [
    _d('60 Kafra', 16000), _d('300 Kafra', 79000), _d('980 Kafra', 249000),
  ]),
  _g('sevendeadly', 'Seven Deadly Sins Origin', 'Netmarble', 'RPG', '😈', '7dsorigin.com', false, 4.3, [
    _d('60 Diamonds', 16000), _d('300 Diamonds', 79000), _d('980 Diamonds', 249000),
  ]),
  _g('ugphone', 'UGPhone', 'UGPhone', 'Utility', '📱', 'ugphone.com', false, 4.0, [
    _d('100 Credits', 15000), _d('500 Credits', 72000), _d('1500 Credits', 220000),
  ]),
  _g('xclash', 'X-Clash', 'X-Clash', 'Strategy', '⚔️', 'xclash.com', false, 4.1, [
    _d('60 Gems', 15000), _d('300 Gems', 72000), _d('980 Gems', 220000),
  ]),
  _g('arenabreakout', 'Arena Breakout', 'Tencent', 'Shooter', '🔫', 'arenabreakout.com', false, 4.2, [
    _d('60 CP', 15000), _d('300 CP', 72000), _d('980 CP', 220000),
  ]),
  _g('ageofmagic', 'Age of Magic', 'Playkot', 'RPG', '🔮', 'ageofmagic.com', false, 4.0, [
    _d('60 Crystals', 16000), _d('300 Crystals', 79000), _d('980 Crystals', 249000),
  ]),
  _g('airplanechefs', 'Airplane Chefs', 'Nordcurrent', 'Casual', '✈️', 'airplanechefs.com', false, 4.1, [
    _d('60 Gems', 15000), _d('300 Gems', 72000), _d('980 Gems', 220000),
  ]),
  _g('banishers', 'Banishers', 'Focus', 'Action', '🕯️', 'banishers.com', false, 4.2, [
    _d('60 Credits', 15000), _d('300 Credits', 72000), _d('980 Credits', 220000),
  ]),
  _g('blockmango', 'Blockman Go', 'Blockman', 'Sandbox', '🧱', 'blockmango.com', false, 4.3, [
    _d('60 Gems', 15000), _d('300 Gems', 72000), _d('980 Gems', 220000),
  ]),
  _g('binance', 'Binance Gift Card', 'Binance', 'Voucher', '🪙', 'binance.com', false, 4.5, [
    _d('USDT 10', 165000), _d('USDT 20', 320000), _d('USDT 50', 780000),
  ]),
  _g('btth', 'Battle Through the Heavens', 'Tencent', 'RPG', '🔥', 'btth.com', false, 4.1, [
    _d('60 Douqi', 16000), _d('300 Douqi', 79000), _d('980 Douqi', 249000),
  ]),
  _g('blueprotocol', 'Blue Protocol', 'Bandai', 'MMORPG', '💠', 'blueprotocol.com', false, 4.4, [
    _d('60 Rose Orb', 16000), _d('300 Rose Orb', 79000), _d('980 Rose Orb', 249000),
  ]),
  _g('blackshot', 'BlackShot', 'Vertigo', 'FPS', '🎯', 'blackshot.com', false, 4.0, [
    _d('100 GP', 15000), _d('500 GP', 72000), _d('1500 GP', 220000),
  ]),
];
