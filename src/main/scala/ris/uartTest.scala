package ris
import chisel3._
import chisel3.util._

class uartTx extends Module{
    val io = IO(new Bundle{
        val txd = Output(UInt(1.W))
    })
    withReset((!reset.asBool).asAsyncReset){
        io.txd := clock.asBool
    }
}

// object HelloUartTx extends App{
//     emitVerilog(new uartTx())
// }