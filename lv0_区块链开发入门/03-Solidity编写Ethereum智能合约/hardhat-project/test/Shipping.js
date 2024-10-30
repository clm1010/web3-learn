const { expect } = require("chai");
const hre = require("hardhat");
describe("Shipping", function () {
  let shippingContract;
  before(async () => {
    // ⽣成合约实例并且复⽤ 
    shippingContract = await hre.ethers.deployContract("Shipping", []);
  }); it("应返回状态 Pending", async function () {
    // assert值是正确的
    expect(await shippingContract.Status()).to.equal("Pending");
  }); it("应返回状态 Shipped", async () => {
    // 调用 Shipped() 函数
    await shippingContract.Shipped();
    // 检查状态是否为已发货
    expect(await shippingContract.Status()).to.equal("Shipped");
  });
  it("应该返回正确的事件描述", async () => {
    // 调用 Delivered() 函数 ,检查事件描述是否正确
    await expect(shippingContract.Delivered()) // 验证事件是否被触发 
      .to.emit(shippingContract, "LogNewAlert") // 验证事件的参数是否符合预期 
      .withArgs("您的包裹已送达");
  });
}); 