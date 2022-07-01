package ris

import chisel3._
import chisel3.util._
import os.stat
import os.read

class ris_controller extends Module{
    val io = IO(new Bundle {
        // val data_channel = Flipped(Decoupled(UInt(256.W)))
        val valid = Input(UInt(1.W))
        // val out_data = Output(UInt(32.W))
        val out_clk = Output(UInt(1.W))
        val out_le = Output(UInt(1.W))
    })

    withReset((!reset.asBool).asAsyncReset){
        // io.out_data := 0x55AA55AA.U
        io.out_le := io.valid
        // io.out_le := 1.U

        val out_clk = RegInit(0.U)
        io.out_clk := out_clk 
        val cnt = Counter(50_000_000)
        cnt.inc()
        when(cnt.value === 0.U){
            out_clk := ~out_clk
        }
    }




    // withReset((!reset.asBool).asAsyncReset){
    //     val out_data = RegInit(0.U)
    //     val out_clk = RegInit(1.U)
    //     val out_le = RegInit(0.U)
    //     val ready = RegInit(true.B)
    //     io.out_data := out_data
    //     io.out_clk := out_clk
    //     io.out_le := out_le
    //     io.data_channel.ready := ready

    //     out_le := io.data_channel.valid

    //     //shift data variable
    //     val data_reg = RegInit(0.U(256.W))
    //     val shift_cnt = Counter(8)

    //     //state machine
    //     val idle::sending::Nil = Enum(2)
    //     val state = RegInit(idle)
    //     switch(state){
    //         is(idle){
    //             //idle
    //             {
    //                 out_data:=1.U
    //                 out_clk :=1.U
    //                 // out_le := 1.U
    //             }
    //             //idle to sending
    //             when(ready & io.data_channel.valid){
    //                 state := sending
    //                 //init data reg & shift counter
    //                 data_reg := io.data_channel.bits
    //                 shift_cnt.reset()

    //                 //lock data channel
    //                 ready := 0.U

    //             }
    //         }
    //         is(sending){
    //             //sending
    //             {
    //                 out_clk := clock.asBool
    //                 when(clock.asBool){
    //                     //set data
    //                     for(i<-0 until 32){
    //                         out_data := data_reg(i*8)
    //                     }
    //                     //shift bits
    //                     data_reg := data_reg >> 8.U
    //                     shift_cnt.inc()
    //                 }
    //             }

    //             //sending to idle
    //             when(shift_cnt.value === (shift_cnt.n -1).U){
    //                 state := idle
    //                 //unlock data channel
    //                 ready := 1.U
    //             }
    //         }
    //     }
    // }
}

object Hello extends App{
    emitVerilog(new ris_controller)
}