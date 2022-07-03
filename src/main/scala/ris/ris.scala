package ris

import chisel3._
import chisel3.util._
import os.stat
import os.read

class ris_controller(freq:Int) extends Module{
    val io = IO(new Bundle {
        val data_channel = Flipped(Decoupled(UInt(256.W)))
        val out_data = Output(UInt(32.W))
        val out_clk = Output(UInt(1.W))
        val out_le = Output(UInt(1.W))
    })

    def risedge(v:Bool) =  v & !RegNext(v)

    withReset((!reset.asBool).asAsyncReset){
        val out_data = RegInit(0x55AA55AA.U);    io.out_data := out_data
        val ready = RegInit(true.B);    io.data_channel.ready := ready

        //shift data variable
        val data_reg = RegInit(0.U(256.W))
        val shift_cnt = Counter(9)

        val clk_cnt = Counter(50_000_000/freq)
        val shift_clk = clk_cnt.value === 0.U
        clk_cnt.inc()

        when(shift_clk){
            shift_cnt.inc()
            when(shift_cnt.value <= 7.U){
                //set data
                for(i<-0 until 32){
                    out_data := data_reg(i*8)
                }
                //shift bits
                data_reg := data_reg >> 1.U
            }.elsewhen(shift_cnt.value === 8.U){
                data_reg := io.data_channel.bits
            }
        }

        //generate clock signal
        when(shift_cnt.value <= 8.U & shift_cnt.value >=1.U){
            io.out_clk := (clk_cnt.value -1.U > (clk_cnt.n/2).U)
        }.otherwise{
            io.out_clk := 0.U
        }
        when(shift_cnt.value === 0.U){
            io.out_le := (clk_cnt.value -1.U  > (clk_cnt.n/2).U)
        }.otherwise{
            io.out_le := 0.U
        }



        // //state machine
        // val idle::sending::Nil = Enum(2)
        // val state = RegInit(idle)
        // switch(state){
        //     is(idle){
        //         //idle
        //         {
        //             out_data:=0.U
        //             out_clk :=0.U
        //             // out_le := 1.U
        //         }
        //         //idle to sending
        //         val last_valid = RegNext(io.data_channel.valid)
        //         val valid_change = last_valid =/= io.data_channel.valid
        //         when(ready & valid_change){
        //             state := sending
        //             //init data reg & shift counter
        //             data_reg := io.data_channel.bits
        //             shift_cnt.reset()

        //             //lock data channel
        //             ready := 0.U
        //         }
        //     }
        //     is(sending){
        //         //sending
        //         {
        //             out_clk := clock.asBool
        //             when(clock.asBool){
        //                 //set data
        //                 for(i<-0 until 32){
        //                     out_data := data_reg(i*8)
        //                 }
        //                 //shift bits
        //                 data_reg := data_reg >> 8.U
        //                 shift_cnt.inc()
        //             }
        //         }

        //         //sending to idle
        //         when(shift_cnt.value === (shift_cnt.n -1).U){
        //             state := idle
        //             //unlock data channel
        //             ready := 1.U
        //         }
        //     }
        // }
    }
}

object Hello extends App{
    emitVerilog(new ris_controller(100_000))
}