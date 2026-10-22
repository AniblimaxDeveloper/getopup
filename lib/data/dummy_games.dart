import '../models/game.dart';

final List<Game> games = [
  Game(id: 'mlbb', name: 'Mobile Legends', emoji: '🏆', denominations: [
    Denom('86 Diamonds', 22000),
    Denom('172 Diamonds', 43000),
    Denom('257 Diamonds', 65000),
    Denom('706 Diamonds', 178000),
  ]),
  Game(id: 'ff', name: 'Free Fire', emoji: '🔥', denominations: [
    Denom('70 Diamonds', 10000),
    Denom('140 Diamonds', 20000),
    Denom('355 Diamonds', 50000),
    Denom('720 Diamonds', 100000),
  ]),
  Game(id: 'pubg', name: 'PUBG Mobile', emoji: '🎯', denominations: [
    Denom('60 UC', 15000),
    Denom('325 UC', 75000),
    Denom('660 UC', 150000),
    Denom('1800 UC', 400000),
  ]),
  Game(id: 'genshin', name: 'Genshin Impact', emoji: '⚔️', denominations: [
    Denom('60 Genesis', 16000),
    Denom('300 Genesis', 79000),
    Denom('980 Genesis', 249000),
    Denom('1980 Genesis', 479000),
  ]),
  Game(id: 'valorant', name: 'Valorant', emoji: '🎮', denominations: [
    Denom('125 VP', 15000),
    Denom('420 VP', 50000),
    Denom('700 VP', 80000),
    Denom('1375 VP', 150000),
  ]),
  Game(id: 'codm', name: 'Call of Duty Mobile', emoji: '💥', denominations: [
    Denom('80 CP', 15000),
    Denom('420 CP', 75000),
    Denom('880 CP', 150000),
    Denom('2400 CP', 400000),
  ]),
];
