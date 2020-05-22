defmodule Cards do
  @moduledoc """
  Provides mothods for creating and handling a deck of cards.
  """

  @doc"""
  Returns a list of string representing a list of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Dimands"]

    for suit <- suits, value <- values do
      "#{value} #{suit}"
    end
  end

  @doc"""
  Devides a deck into a hand and remainds of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exit"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determins if a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
