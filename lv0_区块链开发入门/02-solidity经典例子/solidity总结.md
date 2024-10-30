## solidity 总结

### 值类型(value type)

**答:**

- 布尔类型

  ```
  bool
  ```

- 整型

  ```
    int
    int8-int256 //（8的倍数）
    unit
    uint8-uint256//（8的倍数）
  ```

* 静态浮点型

  ```
    fixedM*N
    ufixedM*N
  ```

- 地址类型
  ```
    address
  ```

* 静态字节数组

  ```
    bytes1
    bytes2
    bytes3
    ...
    bytes32
  ```

- 枚举类型型

  ```
    enum
  ```

* 自定义值类型

  ```
    // 通过 type C is V 来定义新的「自定义值类型」。
    // 其中 C 是新定义的类型，而 V 则必须是Solidity的原生类型。例如，下面的例子中定义了两种新类型：
    type Weight is uint128;
    type Price  is uint128;
  ```

- 字面值

  ```
    // 地址字面值
    address addr = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990;

    // 有理数和整数字面值
    // 十进制整数：例如123
    uint256 d1 = 123;     // d1=123
    // 十进制小数：例如.1，1.2等；但是不能是1. 因为其限制小数点后面必须至少跟一个数字
    uint256 d2 = .1+1.9;  // d2=2
    // 十六进制整数：例如0xff
    uint256 h = 0xff;     // h=255
    // 科学记数法：例如2e10,  -2e10,  2e-10,  2.5e1
    int256 s1 = 2e10;     // s1=20000000000
    int256 s2 = -2e10;    // s2=-20000000000
    // 有理数和整数字面值可以是任意精度
    uint256 p = (2**800 + 1) - 2**800;

    // 字符串字面值
    tring memory s1 = "This is a string";
    // 双引号
    string memory s2 = 'This is a string'; // 单引号

    // Unicode字面值
    string memory a = unicode"Hello \u0041 😃";

  ```

---

### 引用类型(reference type)

**答:**

- 数组（堆类型相同的变量集合）

  - 固定长度数组：T[k]

    ```
      // 声明静态数组
      uint[3] memory nftMem;
      uint[3] storage nftStorage;

      //静态数组的大小必须要能够在编译期间确定
      uint size = 2;
      uint[size][size] memory array; // 非法，size 是变量，不能用来指定数组大小
    ```

  - 动态数组：T[]
    ```
      // 声明动态数组
      uint[] memory nftMem;
      uint[] storage nftStorage;
    ```
  - 特殊数组：bytes、string

    ```
      // bytes与string的互相转换
      // bytes(str)： 显式地将string转换成bytes
      bytes memory bstr = new bytes(10);
      string memory message = string(bstr); // 使用string()函数转换

      // string(myBytes)： 显式地将bytes转换成string
      string memory message = "hello world";
      bytes memory bstr = bytes(message); //使用 bytes()函数转换
    ```

  - 静态数组和动态数组是不同的类型

    ```
      // 静态数组和动态数组之间不能相互赋值
      // 不能把静态数组赋值给动态数组：
      uint[2] memory staticArr = [uint(1), 2];
      uint[] memory dynamicArr = staticArr; // 编译错误，静态数组和动态数组是不同的类型

      // 也不能把动态数组赋值给静态数组：
      uint[] memory dynamicArr = new uint[](2);
      uint[2] memory staticArr = dynamicArr; // 编译错误，静态数组和动态数组是不同的类型
    ```

- 结构体（堆类型相同的变量集合）

  ```
    // 定义结构体类型
    struct Book {
      string title; // 书名
      uint price;   // 价格
    }

    // 声明结构体类型变量
    Book memory book;

    // 结构体的初始化, 以键值的形式，指定每个成员的初始值
    Book memory book1 = Book(
      {
          title: "my book title",
          price: 25
      }
    );
  ```

- 映射类型（堆类型相同的变量集合）
