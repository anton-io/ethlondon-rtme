import { expect } from "chai";
import { ethers } from "hardhat";
import { RMTE } from "../typechain-types";

describe("RMTE", function () {
  // We define a fixture to reuse the same setup in every test.

  let RMTE: RMTE;
  before(async () => {
    const [owner] = await ethers.getSigners();
    const RMTEFactory = await ethers.getContractFactory("RMTE");
    RMTE = (await RMTEFactory.deploy(owner.address)) as RMTE;
    await RMTE.deployed();
  });

  describe("Deployment", function () {
    it("Should have the right message on deploy", async function () {
      expect(await RMTE.greeting()).to.equal("Building Unstoppable Apps!!!");
    });

    it("Should allow setting a new message", async function () {
      const newGreeting = "Learn Scaffold-ETH 2! :)";

      await RMTE.setGreeting(newGreeting);
      expect(await RMTE.greeting()).to.equal(newGreeting);
    });
  });
});
