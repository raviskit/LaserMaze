require 'spec_helper'

describe 'App' do

  def basic_setup(input_file_name)
    @input = @input = __dir__+"/input_files/#{input_file_name}.txt"
    @output = __dir__+'/output_files/output.txt'
    LaserMaze::App.new(@input, @output).run
    @output_file = File.readlines(@output)
  end

  context 'without loop' do
    before(:all) do
      basic_setup('input1')
    end

    it 'yields a file having two lines' do
      expect(@output_file.length).to be(2)
    end

    it 'determines and outputs correct number of squares traversed by beam' do
      expect(@output_file[0]).to eq("2\n")
    end

    it 'determines and outputs correct final coordinate of beam' do
      expect(@output_file[1]).to eq("7 0\n")
    end
  end

  context 'positioned next to and facing a wall' do
    before(:all) do
      basic_setup('input2')
    end

    it 'yields a file having two lines' do
      expect(@output_file.length).to be(2)
    end

    it 'determines and outputs correct number of squares traversed by beam' do
      expect(@output_file[0]).to eq("0\n")
    end

    it 'determines and outputs correct final coordinate of beam' do
      expect(@output_file[1]).to eq("654 999\n")
    end
  end

  context '1x1 maze' do
    before(:all) do
      basic_setup('input3')
    end

    it 'yields a file having two lines' do
      expect(@output_file.length).to be(2)
    end

    it 'determines and outputs correct number of squares traversed by beam' do
      expect(@output_file[0]).to eq("0\n")
    end

    it 'determines and outputs correct final coordinate of beam' do
      expect(@output_file[1]).to eq("0 0\n")
    end
  end

  context 'with loop' do
    before(:all) do
      basic_setup('input4')
    end

    it 'returns a single line response' do
      expect(@output_file.length).to be(1)
    end

    it 'return -1' do
      expect(@output_file[0]).to eq("-1\n")
    end
  end
end