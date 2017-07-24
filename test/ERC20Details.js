const ERC20Details = artifacts.require('./helpers/ERC20Details.sol');

contract('ERC20Details', function () {

  const name = 'My Detailed Token';
  const symbol = 'MDT';
  const decimals = 20;

  before(async function () {
    this.token = await ERC20Details.new(name, symbol, decimals);
  });

  it('should have proper name', async function () {
    await this.token.name().then(_name => {
      assert.equal(name, _name);
    });
  });

  it('should have proper symbol', async function () {
    await this.token.symbol().then(_symbol => {
      assert.equal(symbol, _symbol);
    });
  });

  it('should have proper decimals', async function () {
    await this.token.decimals().then(_decimals => {
      assert.equal(decimals, _decimals);
    });
  });

});
