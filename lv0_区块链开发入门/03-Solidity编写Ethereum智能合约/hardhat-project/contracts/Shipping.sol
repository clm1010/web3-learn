// SPDX-License-Identifier: MIT

pragma solidity >=0.4.25 <0.9.0;

contract Shipping {
    // 预先定义的运输值以枚举形式列出
    enum ShippingStatus {
        Pending, //待处理状态
        Shipped, //已发货状态
        Delivered //已送达状态
    }
    // 将枚举 ShippingStatus 保存在变量 status 中
    ShippingStatus private status;
    // 包裹已送达时启动的事件
    event LogNewAlert(string description);

    // 初始化合约状态（程序启动后将枚举设置为 “待处理状态”）
    constructor() {
        status = ShippingStatus.Pending;
    }

    // 更改为已发货状态方法
    function Shipped() public {
        status = ShippingStatus.Shipped;
        emit LogNewAlert(unicode"您的包裹已发货");
    }

    // 更改为已送达状态方法
    function Delivered() public {
        status = ShippingStatus.Delivered;
        emit LogNewAlert(unicode"您的包裹已送达");
    }

    // 获取运输状态的函数
    function getStatus(
        ShippingStatus _status
    ) internal pure returns (string memory statusText) {
        // 检查当前状态并返回正确的名称
        if (ShippingStatus.Pending == _status) return "Pending";
        if (ShippingStatus.Shipped == _status) return "Shipped";
        if (ShippingStatus.Delivered == _status) return "Delivered";
    }

    // 获取已发货的状态
    function Status() public view returns (string memory) {
        ShippingStatus _status = status;
        return getStatus(_status);
    }
}
