RSpec.describe MustBeOrdered do
  it "has a version number" do
    expect(MustBeOrdered::VERSION).not_to be nil
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
