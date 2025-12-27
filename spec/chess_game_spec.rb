# frozen-string-literal: true

require_relative '../lib/chess_game'

describe ChessGame do
  subject(:game) { described_class.new }
  let(:board) { game.instance_variable_get(:@board) }

  describe '#initialize' do
    it 'creates a new board' do
      board = game.instance_variable_get(:@board)
      expect(board).to be_kind_of(ChessBoard)
    end
  end

  describe '#play_round' do
    after(:example) do
      game.play_round
    end

    context 'when a2 a3 is received' do
      before do
        allow(game).to receive(:gets).and_return('a2 a3')
      end

      it 'gets valid_input once' do
        expect(game).to receive(:gets).once
      end
      it 'is valid input and runs' do
        expect(board).to receive(:move).with([0, 1], [0, 2]).once
      end
    end

    context 'when c2 c3 is received' do
      before(:example) do
        allow(game).to receive(:gets).and_return('c2 c3')
      end

      it 'gets valid_input once' do
        expect(game).to receive(:gets).once
      end

      it 'is valid and runs' do
        expect(board).to receive(:move).with([2, 1], [2, 2]).once
      end
    end

    context 'when "aa aa" is inputted' do
      before do
        allow(game).to receive(:gets).and_return('aa aa', 'a2 a3')
      end
      it 'is invalid and puts error msg' do
        error_msg = 'Invalid input. Input starting position and end position. (ex. "a2 a4")'
        expect(game).to receive(:puts).exactly(3).times
        expect(game).to receive(:puts).with(error_msg).once
      end
    end

    context 'when "hello" then "h2 h4" is inputted' do
      before(:example) do
        allow(game).to receive(:gets).and_return('hello', 'h2 h4')
      end

      it 'gets input once' do
        expect(game).to receive(:gets).twice
      end
      it 'is valid and runs' do
        expect(board).to receive(:move).with([7, 1], [7, 3]).once
      end
    end

    context 'when input is the same ("c2 c2")' do
      before(:example) do
        allow(game).to receive(:gets).and_return('c2 c2', 'c2 c3')
      end

      it 'gets input twice' do
        expect(game).to receive(:gets).exactly(2).times
      end

      it 'is invalid' do
        expect(board).to receive(:move).with([2, 1], [2, 2])
      end
    end

    context 'when trying to move a different color piece' do
      before(:example) do
        allow(game).to receive(:gets).and_return('a7 a6', 'c2 c3')
      end

      it 'loops twice' do
        expect(game).to receive(:gets).exactly(2).times
      end
      it 'moves' do
        expect(board).to receive(:move).with([0, 6], [0, 5]).once
      end
    end
  end
end
