module ris_controller(
  input          clock,
  input          reset,
  output         io_data_channel_ready,
  input          io_data_channel_valid,
  input  [255:0] io_data_channel_bits,
  input          io_valid,
  output [31:0]  io_out_data,
  output         io_out_clk,
  output         io_out_le
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [255:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  _T_2 = ~reset; // @[ris.scala 34:31]
  reg  out_data; // @[ris.scala 35:31]
  reg  out_clk; // @[ris.scala 36:30]
  reg  out_le; // @[ris.scala 37:29]
  reg  ready; // @[ris.scala 38:28]
  reg [255:0] data_reg; // @[ris.scala 47:31]
  reg [2:0] value; // @[Counter.scala 62:40]
  reg  state; // @[ris.scala 52:28]
  wire  _GEN_0 = ready & io_data_channel_valid | state; // @[ris.scala 62:52 63:27 52:28]
  wire [255:0] _data_reg_T = {{8'd0}, data_reg[255:8]}; // @[ris.scala 83:46]
  wire  wrap = value == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value + 3'h1; // @[Counter.scala 78:24]
  wire  _GEN_4 = clock ? data_reg[248] : out_data; // @[ris.scala 35:31 77:39 80:38]
  wire  _GEN_8 = wrap | ready; // @[ris.scala 89:61 92:27 38:28]
  wire  _GEN_9 = state ? clock : out_clk; // @[ris.scala 53:22 76:29 36:30]
  wire  _GEN_10 = state ? _GEN_4 : out_data; // @[ris.scala 53:22 35:31]
  assign io_data_channel_ready = ready; // @[ris.scala 42:31]
  assign io_out_data = {{31'd0}, out_data}; // @[ris.scala 39:21]
  assign io_out_clk = out_clk; // @[ris.scala 40:20]
  assign io_out_le = out_le; // @[ris.scala 41:19]
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      out_data <= 1'h0; // @[ris.scala 57:29]
    end else begin
      out_data <= ~state | _GEN_10;
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      out_clk <= 1'h1; // @[ris.scala 58:29]
    end else begin
      out_clk <= ~state | _GEN_9;
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 37:29]
      out_le <= 1'h0; // @[ris.scala 37:29]
    end else begin
      out_le <= io_data_channel_valid; // @[ris.scala 44:16]
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      ready <= 1'h1; // @[ris.scala 62:52 69:27 38:28]
    end else if (~state) begin // @[ris.scala 53:22]
      if (ready & io_data_channel_valid) begin
        ready <= 1'h0;
      end
    end else if (state) begin // @[ris.scala 38:28]
      ready <= _GEN_8;
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      data_reg <= 256'h0; // @[ris.scala 62:52 65:30 47:31]
    end else if (~state) begin // @[ris.scala 53:22]
      if (ready & io_data_channel_valid) begin // @[ris.scala 77:39]
        data_reg <= io_data_channel_bits; // @[ris.scala 83:34]
      end
    end else if (state) begin // @[ris.scala 47:31]
      if (clock) begin
        data_reg <= _data_reg_T;
      end
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      value <= 3'h0; // @[ris.scala 62:52 Counter.scala 99:11 62:40]
    end else if (~state) begin // @[ris.scala 53:22]
      if (ready & io_data_channel_valid) begin // @[ris.scala 77:39]
        value <= 3'h0; // @[Counter.scala 78:15]
      end
    end else if (state) begin // @[Counter.scala 62:40]
      if (clock) begin
        value <= _value_T_1;
      end
    end
  end
  always @(posedge clock or posedge _T_2) begin
    if (_T_2) begin // @[ris.scala 53:22]
      state <= 1'h0;
    end else if (~state) begin // @[ris.scala 53:22]
      state <= _GEN_0; // @[ris.scala 89:61 90:27 52:28]
    end else if (state) begin // @[ris.scala 52:28]
      if (wrap) begin
        state <= 1'h0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_data = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  out_clk = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  out_le = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  ready = _RAND_3[0:0];
  _RAND_4 = {8{`RANDOM}};
  data_reg = _RAND_4[255:0];
  _RAND_5 = {1{`RANDOM}};
  value = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  state = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  if (_T_2) begin
    out_data = 1'h0;
  end
  if (_T_2) begin
    out_clk = 1'h1;
  end
  if (_T_2) begin
    out_le = 1'h0;
  end
  if (_T_2) begin
    ready = 1'h1;
  end
  if (_T_2) begin
    data_reg = 256'h0;
  end
  if (_T_2) begin
    value = 3'h0;
  end
  if (_T_2) begin
    state = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
