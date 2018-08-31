RSpec.describe MustBeOrdered do
  it "has a version number" do
    expect(MustBeOrdered::VERSION).not_to be nil
  end

  describe '.enabled' do
    before do
      MustBeOrdered.raise = true
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
        MustBeOrdered.raise = true
      end
      it 'raise error when not ordered' do
        expect{ Item.all.to_a }.to raise_error MustBeOrdered::OrderNotApplied
      end
      it 'not to raise error when ordered' do
        expect{ Item.order('id').to_a }.not_to raise_error
      end
    end
  end

  describe '.raise' do
    before do
      MustBeOrdered.enabled = true
      Item.must_be_ordered
    end
    context 'raiseオプション指定されている' do
      before { MustBeOrdered.raise = true }
      it 'allでExceptionが発生すること' do
        expect{ Item.all.to_a }.to raise_error MustBeOrdered::OrderNotApplied
      end
      it 'selectでExceptionが発生すること' do
        expect{ Item.select('id').to_a }.to raise_error MustBeOrdered::OrderNotApplied
      end
      it 'select + orderでExceptionが発生しないこと' do
        expect{ Item.select('id').order("id").to_a }.not_to raise_error
      end
    end
    context 'raiseオプション指定されていない' do
      before { MustBeOrdered.raise = false }
      it "order無しでExceptionが発生しないこと" do
        expect{ Item.all.to_a }.not_to raise_error
      end
      it do
        expect{ Item.select('id').to_a }.not_to raise_error
      end
    end
  end

  # TODO: DELETE ME
  it 'sandbox' do
    MustBeOrdered.enabled = true
    MustBeOrdered.must_be_ordered_logger = true
    Item.must_be_ordered
    Item.all.to_a
  end
end
