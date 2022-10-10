package ris

import chisel3._
import chisel3.util._
import os.stat
import os.read

class ris_controller(freq:Int) extends Module{
    val io = IO(new Bundle {
        // ris output
        val out_data = Output(UInt(32.W))
        val out_clk = Output(UInt(1.W))
        val out_le = Output(UInt(1.W))

        // control register
        val table_divider = Input(UInt(32.W))
        val flip_divider = Input(UInt(32.W))
        val table_cycle_num = Input(UInt(32.W))

        //fifo
        val fifo_tableid = Flipped(Decoupled(UInt(32.W)))
        val fifo_phase = Flipped(Decoupled(UInt(32.W)))

        //bram
        val bram_addr = Output(UInt(8.W))
        val bram_data = Input(UInt(256.W))
        val bram_en = Output(UInt(1.W))
    })

    def risedge(v:Bool) =  v & !RegNext(v)

    withReset((!reset.asBool).asAsyncReset){
        val out_data = RegInit(0.U);    io.out_data := out_data

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
                out_data := VecInit((0 until 32).map(i=>data_reg(8*i))).asUInt
                //shift bits
                data_reg := data_reg >> 1.U
            }.elsewhen(shift_cnt.value === 8.U){
                data_reg := io.bram_data
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
    }
}

object Hello extends App{
    emitVerilog(new ris_controller(100_000))
}