var OceanToken=artifacts.require ("../contracts/OceanToken.sol");

module.exports = function(deployer) {
      deployer.deploy(OceanToken , 100 , 50);
}