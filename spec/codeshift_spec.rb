RSpec.describe Codeshift do
  it "has a version number" do
    expect(Codeshift::VERSION).not_to be nil
  end

  it "does apply the transform" do
    input = File.read('./spec/fixtures/input.rb')
    transform = File.read('./spec/fixtures/transform.rb')
    output = File.read('./spec/fixtures/output.rb')
    result = Codeshift::Transformer.new(input, transform).transform
    expect(result).to eq(output)
  end
end
