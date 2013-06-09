# -*- coding: Windows-31J -*-

require '../lib/brounie/dice.rb'

class DiceRoll
	attr_reader :said, :fix, :dice
end

describe DiceRoll do
	context '解釈できない文字列には nilを返す' do
		it '数字やダイス表現が含まれない文字列' do
			DiceRoll::parse('こんにちは。').should== nil
		end
		
		it '数字だけが含まれる文字列' do
			DiceRoll::parse('5+5-10').should== nil
		end
	end
	
	context 'D6 x n のダイスロールができる' do
		before do
			srand(0)
		end
		
		it 'ダイスロールだけの文字列' do
			d=DiceRoll::parse('2D+4')
			d.should be_a_kind_of(DiceRoll)
			d.roll.should =~ /4\+\[6\]\[5\]/
			d.roll.should =~ /2D\+4/
		end
		
		it '文字列中にダイスロールが混じっているケース' do
			d=DiceRoll::parse('通常で2d、マスタリーで1d、武器の攻撃力が11でスキルで+4です')
			d.should be_a_kind_of(DiceRoll)
			d.roll.should =~ /15\+\[6\]\[5\]\[1\]/
			d.roll.should =~ /通常で2d、マスタリーで1d、武器の攻撃力が11でスキルで\+4です/
		end
	end
	
	context 'D66 のダイスロールができる' do
		before do
			srand(0)
		end
		
		it 'D66だけ' do
			d=DiceRoll::parse('D66')
			d.should be_a_kind_of(DiceRoll)
			d.roll.should =~ /\[56\]/
			d.roll.should =~ /D66/
		end
	end
end
