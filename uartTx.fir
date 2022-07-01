circuit uartTx :
  module uartTx :
    input clock : Clock
    input reset : UInt<1>
    output io : { txd : UInt<1>}

    node _T = bits(reset, 0, 0) @[uartTest.scala 9:23]
    node _T_1 = eq(_T, UInt<1>("h0")) @[uartTest.scala 9:16]
    node _T_2 = asAsyncReset(_T_1) @[uartTest.scala 9:31]
    node _io_txd_T = asUInt(clock) @[uartTest.scala 10:25]
    node _io_txd_T_1 = bits(_io_txd_T, 0, 0) @[uartTest.scala 10:25]
    io.txd <= _io_txd_T_1 @[uartTest.scala 10:16]

