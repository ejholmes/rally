require 'spec_helper'

class FakeService
  class << self
    def name
      'fake'
    end
  end

  def provision
    :provisioned
  end
end

describe Rally::Evaluator do
  let(:options) { {} }
  subject(:evaluator) { described_class.new(options) }

  before do
    Rally.stub services: [FakeService]
  end

  describe '#eval' do
    it 'evals some code' do
      expect(evaluator.eval { fake.provision }).to be :provisioned
    end

    context 'when locals are provided' do
      let(:options) { { locals: { foobar: 'dashboard' } } }

      it 'allows makes the locals available' do
        expect(evaluator.eval { foobar }).to eq 'dashboard'
      end
    end
  end
end
