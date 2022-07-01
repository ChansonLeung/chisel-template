module uartTx(
  input   clock,
  input   reset,
  output  io_txd
);
  assign io_txd = clock; // @[uartTest.scala 10:25]
endmodule
