// SPDX-License-Identifier: UNLICENSED
pragma solidity 
const { expect } = require("chai");

describe("SimpleStorage Contract", function () {
    let SimpleStorage;
    let simpleStorage;
    let owner;

    // Deploy the contract before running tests
    before(async function () {
        [owner] = await ethers.getSigners();
        SimpleStorage = await ethers.getContractFactory("SimpleStorage");
        simpleStorage = await SimpleStorage.deploy();
        await simpleStorage.deployed();
    });

    it("Should deploy successfully", async function () {
        expect(simpleStorage.address).to.properAddress;
    });

    it("Should initially return 0", async function () {
        const storedValue = await simpleStorage.get();
        expect(storedValue).to.equal(0);
    });

    it("Should update the stored value when set is called", async function () {
        const newValue = 42;

        // Call the set function
        const tx = await simpleStorage.set(newValue);
        await tx.wait();

        // Verify the stored value
        const storedValue = await simpleStorage.get();
        expect(storedValue).to.equal(newValue);
    });

    it("Should allow updating the value multiple times", async function () {
        const values = [10, 20, 30];

        for (const value of values) {
            const tx = await simpleStorage.set(value);
            await tx.wait();

            const storedValue = await simpleStorage.get();
            expect(storedValue).to.equal(value);
        }
    });
});
