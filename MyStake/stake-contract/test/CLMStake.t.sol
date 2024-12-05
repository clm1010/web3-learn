// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import {Test, console2} from "forge-std/Test.sol";

import {CLMStake} from "../contracts/CLMStake.sol";
// CLM is ERC20 contract
import {CLM} from "../contracts/shared/MockCLM.sol";

contract CLMStakeTest is Test {
    CLMStake CLMStake;
    CLM CLM;

    fallback() external payable {}

    receive() external payable {}

    function setUp() public {
        CLM = new CLM();
        CLMStake = new CLMStake();
        CLMStake.initialize(CLM, 100, 100000000, 3000000000000000000);
    }

    function test_AddPool() public {
        // Add nativeCurrency pool
        address _stTokenAddress = address(0x0);
        uint256 _poolWeight = 100;
        uint256 _minDepositAmount = 100;
        uint256 _withdrawLockedBlocks = 100;
        bool _withUpdate = true;

        CLMStake.addPool(
            _stTokenAddress,
            _poolWeight,
            _minDepositAmount,
            _withdrawLockedBlocks,
            _withUpdate
        );

        (
            address stTokenAddress,
            uint256 poolWeight,
            uint256 lastRewardBlock,
            uint256 accCLMPerShare,
            uint256 stTokenAmount,
            uint256 minDepositAmount,
            uint256 withdrawLockedBlocks
        ) = CLMStake.pool(0);
        assertEq(stTokenAddress, _stTokenAddress);
        assertEq(poolWeight, _poolWeight);
        assertEq(minDepositAmount, _minDepositAmount);
        assertEq(withdrawLockedBlocks, _withdrawLockedBlocks);
        assertEq(stTokenAmount, 0);
        assertEq(lastRewardBlock, 100);
        assertEq(accCLMPerShare, 0);
    }

    function test_massUpdatePools() public {
        test_AddPool();
        CLMStake.massUpdatePools();
        (
            address stTokenAddress,
            uint256 poolWeight,
            uint256 lastRewardBlock,
            uint256 accCLMPerShare,
            uint256 stTokenAmount,
            uint256 minDepositAmount,
            uint256 withdrawLockedBlocks
        ) = CLMStake.pool(0);
        assertEq(minDepositAmount, 100);
        assertEq(withdrawLockedBlocks, 100);
        assertEq(lastRewardBlock, 100);

        vm.roll(1000);
        CLMStake.massUpdatePools();
        (
            stTokenAddress,
            poolWeight,
            lastRewardBlock,
            accCLMPerShare,
            stTokenAmount,
            minDepositAmount,
            withdrawLockedBlocks
        ) = CLMStake.pool(0);
        assertEq(minDepositAmount, 100);
        assertEq(withdrawLockedBlocks, 100);
        assertEq(lastRewardBlock, 1000);
    }

    function test_SetPoolWeight() public {
        test_AddPool();
        uint256 preTotalPoolWeight = CLMStake.totalPoolWeight();

        CLMStake.setPoolWeight(0, 200, false);
        (
            address stTokenAddress,
            uint256 poolWeight,
            uint256 lastRewardBlock,
            uint256 accCLMPerShare,
            uint256 stTokenAmount,
            uint256 minDepositAmount,
            uint256 withdrawLockedBlocks
        ) = CLMStake.pool(0);
        uint256 totalPoolWeight = CLMStake.totalPoolWeight();
        uint256 expectedTotalPoolWeight = preTotalPoolWeight - 100 + 200;
        assertEq(poolWeight, 200);
        assertEq(totalPoolWeight, expectedTotalPoolWeight);
    }

    function test_DepositnativeCurrency() public {
        test_AddPool();
        (
            address stTokenAddress,
            uint256 poolWeight,
            uint256 lastRewardBlock,
            uint256 accCLMPerShare,
            uint256 stTokenAmount,
            uint256 minDepositAmount,
            uint256 withdrawLockedBlocks
        ) = CLMStake.pool(0);
        uint256 prePoolStTokenAmount = stTokenAmount;

        (uint256 stAmount, uint256 finishedCLM, uint256 pendingCLM) = CLMStake
            .user(0, address(this));
        uint256 preStAmount = stAmount;
        uint256 preFinishedCLM = finishedCLM;
        uint256 prePendingCLM = pendingCLM;

        // First deposit
        address(CLMStake).call{value: 100}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );
        (
            stTokenAddress,
            poolWeight,
            lastRewardBlock,
            accCLMPerShare,
            stTokenAmount,
            minDepositAmount,
            withdrawLockedBlocks
        ) = CLMStake.pool(0);

        (stAmount, finishedCLM, pendingCLM) = CLMStake.user(0, address(this));

        uint256 expectedStAmount = preStAmount + 100;
        uint256 expectedFinishedCLM = preFinishedCLM;
        uint256 expectedTotoalStTokenAmount = prePoolStTokenAmount + 100;

        assertEq(stAmount, expectedStAmount);
        assertEq(finishedCLM, expectedFinishedCLM);
        assertEq(stTokenAmount, expectedTotoalStTokenAmount);

        // more deposit
        address(CLMStake).call{value: 200 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        vm.roll(2000000);
        CLMStake.unstake(0, 100);
        address(CLMStake).call{value: 300 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        vm.roll(3000000);
        CLMStake.unstake(0, 100);
        address(CLMStake).call{value: 400 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        vm.roll(4000000);
        CLMStake.unstake(0, 100);
        address(CLMStake).call{value: 500 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        vm.roll(5000000);
        CLMStake.unstake(0, 100);
        address(CLMStake).call{value: 600 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        vm.roll(6000000);
        CLMStake.unstake(0, 100);
        address(CLMStake).call{value: 700 ether}(
            abi.encodeWithSignature("depositnativeCurrency()")
        );

        CLMStake.withdraw(0);
    }

    function test_Unstake() public {
        test_DepositnativeCurrency();

        vm.roll(1000);
        CLMStake.unstake(0, 100);

        (uint256 stAmount, uint256 finishedCLM, uint256 pendingCLM) = CLMStake
            .user(0, address(this));
        assertEq(stAmount, 0);
        assertEq(finishedCLM, 0);
        assertGt(pendingCLM, 0);

        (
            address stTokenAddress,
            uint256 poolWeight,
            uint256 lastRewardBlock,
            uint256 accCLMPerShare,
            uint256 stTokenAmount,
            uint256 minDepositAmount,
            uint256 withdrawLockedBlocks
        ) = CLMStake.pool(0);

        uint256 expectStTokenAmount = 0;
        assertEq(stTokenAmount, expectStTokenAmount);
    }

    function test_Withdraw() public {
        test_Unstake();
        uint256 preContractBalance = address(CLMStake).balance;
        uint256 preUserBalance = address(this).balance;

        vm.roll(10000);
        CLMStake.withdraw(0);

        uint256 postContractBalance = address(CLMStake).balance;
        uint256 postUserBalance = address(this).balance;
        assertLt(postContractBalance, preContractBalance);
        assertGt(postUserBalance, preUserBalance);
    }

    function test_ClaimAfterDeposit() public {
        test_DepositnativeCurrency();
        CLM.transfer(address(CLMStake), 100000000000);
        uint256 preUserCLMBalance = CLM.balanceOf(address(this));

        vm.roll(10000);
        CLMStake.claim(0);

        uint256 postUserCLMBalance = CLM.balanceOf(address(this));
        assertGt(postUserCLMBalance, preUserCLMBalance);
    }

    function test_ClaimAfterUnstake() public {
        test_Unstake();
        CLM.transfer(address(CLMStake), 100000000000);
        uint256 preUserCLMBalance = CLM.balanceOf(address(this));

        vm.roll(10000);
        CLMStake.claim(0);

        uint256 postUserCLMBalance = CLM.balanceOf(address(this));
        assertGt(postUserCLMBalance, preUserCLMBalance);
    }

    function test_ClaimAfterWithdraw() public {
        test_Withdraw();
        CLM.transfer(address(CLMStake), 100000000000);
        uint256 preUserCLMBalance = CLM.balanceOf(address(this));

        vm.roll(10000);
        CLMStake.claim(0);

        uint256 postUserCLMBalance = CLM.balanceOf(address(this));
        assertGt(postUserCLMBalance, preUserCLMBalance);
    }

    function addPool(uint256 index, address stTokenAddress) public {
        address _stTokenAddress = stTokenAddress;
        uint256 _poolWeight = 100;
        uint256 _minDepositAmount = 100;
        uint256 _withdrawLockedBlocks = 100;
        bool _withUpdate = true;

        CLMStake.addPool(
            _stTokenAddress,
            _poolWeight,
            _minDepositAmount,
            _withdrawLockedBlocks,
            _withUpdate
        );
    }
}
