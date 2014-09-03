require 'code_maker'

describe CodeMaker do
  it 'should be' do
    expect(CodeMaker.new).to be
  end

  it 'should allow me to set the code for testing' do
    expect(CodeMaker.new('rrrr').code).to eq 'rrrr'
  end

  it 'should have a code of 4 colors' do
    code = CodeMaker.new.code

    expect(code.is_a?(String)).to eq(true)
    expect(code.length).to eq(4)
  end

  it 'should generate code with legal colors' do
    code = CodeMaker.new.code

    expect(code.chars - ['r', 'g', 'b', 'y']).to be_empty
  end

  it 'should seem to generate a random code' do
    lots_of_codes = (1..100).collect do
      CodeMaker.new.code
    end

    lots_of_codes.uniq.length.should >= 60
  end

  describe '#correct?' do
    it 'should return true' do
      sut = CodeMaker.new('rrrr')
      expect(sut.correct?('RRRR')).to eq(true)
    end

    it 'should return false' do
      sut = CodeMaker.new('rrrr')
      expect(sut.correct?('RRRB')).to eq(false)
    end
  end

  describe '#score' do
    describe 'correct locations count' do
      it 'should return 4 when all the right colors are in the right place' do
        sut = CodeMaker.new('rrrr')
        expect(sut.score('rrrr').first).to eq 4
      end

      it 'should return 4 even when guess is not lowercase' do
        sut = CodeMaker.new('rrrr')
        expect(sut.score('RRRR').first).to eq 4
      end

      it 'should return 1 when 1 color is in the right place' do
        sut = CodeMaker.new('rrrr')
        expect(sut.score('rbbb').first).to eq 1
      end

      it 'should return 0 when no colors are in the right place' do
        sut = CodeMaker.new('rrrr')
        expect(sut.score('bbbb').first).to eq 0
      end
    end

    describe 'correct colors count' do
      it 'should work perfectly under the right conditions' do
        sut = CodeMaker.new('rrrr')
        expect(sut.score('bbbb').last).to eq 0
      end

      it 'should return 1 when 1 color is not in the right place' do
        sut = CodeMaker.new('rbbb')
        expect(sut.score('bggg').last).to eq 1
      end

      it 'should return 2 when 2 colors match but are not in the right place' do
        sut = CodeMaker.new('rrgg')
        expect(sut.score('yyrr').last).to eq 2
      end

      it 'should return 2 when 2 colors match and are in the right place' do
        sut = CodeMaker.new('rrgg')
        expect(sut.score('rryy').last).to eq 0
      end
    end

    it 'should return 2 and 2 when two are in the right location and 2 are the right colors' do
      sut = CodeMaker.new('rgby')
      expect(sut.score('rgyb')).to eq [2, 2]
    end

    it 'should return 1 and 1 when there are duplicates in the guess' do
      sut = CodeMaker.new('rrbb')
      expect(sut.score('rgrr')).to eq [1, 1]
    end

    context 'uppercase' do
      it 'should return 2 and 2 when two are in the right location and 2 are the right colors' do
        sut = CodeMaker.new('rgby')
        expect(sut.score('RGYB')).to eq [2, 2]
      end
    end
  end
end