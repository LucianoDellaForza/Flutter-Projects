void main() {
  var deck = new Deck();
  deck.shuffle();
  // deck.printShuffledCards();
  var allDiamondCards = deck.cardsWithSuit("Diamond");
  for (var card in allDiamondCards) {
    print('${card.rank}:${card.suit}');
  }
  print(deck.deal(6));
}

class Deck {
  late List<Card> cards = <Card>[];

  Deck() {
    var ranks = [
      'Ace',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Jack',
      'Queen',
      'King'
    ];
    var suits = ['Diamonds', 'Hearts', 'Clubs', 'Spades'];

    for (var suit in suits) {
      for (var rank in ranks) {
        cards.add(Card(suit: suit, rank: rank));
      }
    }
  }

  void printCards() {
    for (var card in cards) {
      print('${card.rank}:${card.suit}');
    }
  }

  void printShuffledCards() {
    for (var card in cards) {
      print('${card.rank}:${card.suit}');
    }
  }

  void shuffle() {
    cards.shuffle();
  }

  List<Card> cardsWithSuit(String suit) {
    return cards.where((element) => element.suit == suit).toList();
  }

  List<Card> deal(int handSize) {
    var hand = cards.sublist(0, handSize);
    cards = cards.sublist(handSize, cards.length);

    return hand;
  }

  void removeCard(Card card) {
    cards.removeWhere(
        (element) => element.suit == card.suit && element.rank == card.rank);
  }
}

class Card {
  String suit;
  String rank;

  Card({required this.suit, required this.rank});

  @override
  String toString() {
    return "$rank of $suit";
  }
}
