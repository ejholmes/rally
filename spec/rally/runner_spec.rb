require 'spec_helper'

class FakeProvider
  class << self
    def name
      'fake'
    end
  end

  def provision
    :provisioned
  end
end

describe Rally::Runner do
  let(:options) { {} }
  subject(:runner) { described_class.new(options) }

  before do
    Rally.stub providers: [FakeProvider]
  end

  describe '#eval' do
    context 'when given a block' do
      it 'evals the code' do
        expect(runner.eval { fake.provision }).to be :provisioned
      end
    end

    context 'when given a string' do
      it 'evals the code' do
        expect(runner.eval('fake.provision')).to be :provisioned
      end
    end

    context 'when locals are provided' do
      let(:options) { { locals: { foobar: 'dashboard' } } }

      it 'allows makes the locals available' do
        expect(runner.eval { foobar }).to eq 'dashboard'
      end
    end
  end
end
