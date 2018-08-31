RSpec.describe MustBeOrdered do
  it "has a version number" do
    expect(MustBeOrdered::VERSION).not_to be nil
  end

  describe '.enabled' do
    before do
      Item.must_be_ordered
    end

    context 'when enabled is not set' do
      it 'not to raise error when not ordered' do
        expect{ Item.all.to_a }.not_to raise_error
      end
      it 'not to raise error when ordered' do
        expect{ Item.order('id').to_a }.not_to raise_error
      end
    end

    context 'when enabled is set to true' do
      before do
        MustBeOrdered.enabled = true
      end
      it 'raise error when not ordered' do
        expect{ Item.all.to_a }.to raise_error MustBeOrdered::OrderNotApplied
      end
      it 'not to raise error when ordered' do
        expect{ Item.order('id').to_a }.not_to raise_error
      end
    end
  end

  describe 'Exception' do
    before do
      Item.must_be_ordered
    end
    it "order無しでExceptionが発生すること" do
      expect{ Item.all.to_a }.to raise_error MustBeOrdered::OrderNotApplied
    end
  end
end
