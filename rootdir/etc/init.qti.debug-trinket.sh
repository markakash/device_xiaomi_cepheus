#!/vendor/bin/sh
# Copyright (c) 2019, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

enable_trinket_tracing_events()
{
    # timer
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_entry/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_cancel/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_init/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_start/enable
    #enble FTRACE for softirq events
    echo 1 > /sys/kernel/debug/tracing/events/irq/enable
    #enble FTRACE for Workqueue events
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/enable
    # schedular
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_pi_setprio/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_isolate/enable
    #cpu frequency
    echo 1 > /sys/kernel/debug/tracing/events/power/cpu_frequency/enable
    # clock
    echo 1 > /sys/kernel/debug/tracing/events/power/clock_set_rate/enable
    echo 1 > /sys/kernel/debug/tracing/events/power/clock_enable/enable
    echo 1 > /sys/kernel/debug/tracing/events/power/clock_disable/enable
    echo 1 > /sys/kernel/debug/tracing/events/power/cpu_frequency/enable
    # regulator
    echo 1 > /sys/kernel/debug/tracing/events/regulator/enable
    # power
    echo 1 > /sys/kernel/debug/tracing/events/msm_low_power/enable
    #SCM Tracing enabling
    echo 1 > /sys/kernel/debug/tracing/events/scm/enable

    echo 1 > /sys/kernel/debug/tracing/tracing_on
}

# function to enable ftrace events
enable_trinket_ftrace_event_tracing()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/debug/tracing/events ]
    then
        return
    fi
    echo 0x4096 > /sys/kernel/debug/tracing/buffer_size_kb
    enable_trinket_tracing_events
}

# function to enable ftrace event transfer to CoreSight STM
enable_trinket_stm_events()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi
    # bail out if coresight isn't present
    if [ ! -d /sys/bus/coresight ]
    then
        return
    fi
    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/debug/tracing/events ]
    then
        return
    fi

    echo $etr_size > /sys/bus/coresight/devices/coresight-tmc-etr/mem_size
    echo sg > /sys/bus/coresight/devices/coresight-tmc-etr/mem_type
    echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/$sinkenable
    echo 1 > /sys/bus/coresight/devices/coresight-stm/$srcenable
    echo 1 > /sys/kernel/debug/tracing/tracing_on
    echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
    enable_trinket_tracing_events
}

#BIMC Register
config_trinket_dcc_bimc()
{
    #BIMC_M_APP_MPORT
    echo 0x4488100 1 > $DCC_PATH/config
    echo 0x4488400 2 > $DCC_PATH/config
    echo 0x4488410 1 > $DCC_PATH/config
    echo 0x4488420 2 > $DCC_PATH/config
    echo 0x4488430 2 > $DCC_PATH/config

    #BIMC_M_GPU_MPORT
    echo 0x448c100 1 > $DCC_PATH/config
    echo 0x448c400 2 > $DCC_PATH/config
    echo 0x448c410 1 > $DCC_PATH/config
    echo 0x448c420 2 > $DCC_PATH/config
    echo 0x448c430 2 > $DCC_PATH/config

    #BIMC_M_MMSS_RT_MPORT
    echo 0x4490100 1 > $DCC_PATH/config
    echo 0x4490400 2 > $DCC_PATH/config
    echo 0x4490410 1 > $DCC_PATH/config
    echo 0x4490420 2 > $DCC_PATH/config
    echo 0x4490430 2 > $DCC_PATH/config

    #BIMC_M_MMSS_NRT_MPORT
    echo 0x4494100 1 > $DCC_PATH/config
    echo 0x4494400 2 > $DCC_PATH/config
    echo 0x4494410 1 > $DCC_PATH/config
    echo 0x4494420 2 > $DCC_PATH/config
    echo 0x4494430 2 > $DCC_PATH/config

    #BIMC_M_TCU_MPORT
    echo 0x449810c 1 > $DCC_PATH/config
    echo 0x4498400 2 > $DCC_PATH/config
    echo 0x4498410 1 > $DCC_PATH/config
    echo 0x4498420 2 > $DCC_PATH/config
    echo 0x4498430 2 > $DCC_PATH/config

    #BIMC_M_MDSP_MPORT
    echo 0x449c100 1 > $DCC_PATH/config
    echo 0x449c400 2 > $DCC_PATH/config
    echo 0x449c410 1 > $DCC_PATH/config
    echo 0x449c420 2 > $DCC_PATH/config
    echo 0x449c430 2 > $DCC_PATH/config

    #BIMC_M_SYS_MPORT
    echo 0x44a0100 1 > $DCC_PATH/config
    echo 0x44a0400 2 > $DCC_PATH/config
    echo 0x44a0410 1 > $DCC_PATH/config
    echo 0x44a0420 2 > $DCC_PATH/config
    echo 0x44a0430 2 > $DCC_PATH/config

    #BIMC_S_DDR0
    echo 0x44b0560 1 > $DCC_PATH/config
    echo 0x44b05a0 1 > $DCC_PATH/config
    echo 0x44b1800 1 > $DCC_PATH/config
    echo 0x44b408c 1 > $DCC_PATH/config
    echo 0x44b409c 1 > $DCC_PATH/config
    echo 0x44b0520 1 > $DCC_PATH/config
    echo 0x44b5070 2 > $DCC_PATH/config

    # BIMC_S_SYS_SWAY
    echo 0x44bc220 1 > $DCC_PATH/config
    echo 0x44bc400 7 > $DCC_PATH/config
    echo 0x44bc420 9 > $DCC_PATH/config

    echo 0x44bd800 1 > $DCC_PATH/config
    echo 0x44c5800 1 > $DCC_PATH/config
    echo 0x4480040 2 > $DCC_PATH/config
    echo 0x4480810 2 > $DCC_PATH/config
    echo 0x44b0a40 1 > $DCC_PATH/config

    #CH0_DDRCC
    echo 0x4506044 1 > $DCC_PATH/config
    echo 0x45061dc 1 > $DCC_PATH/config
    echo 0x45061ec 1 > $DCC_PATH/config
    echo 0x4506028 2 > $DCC_PATH/config
    echo 0x4506094 1 > $DCC_PATH/config
    echo 0x4506608 1 > $DCC_PATH/config

    #CCC_MCCC_CH0
    echo 0x447d02c 4 > $DCC_PATH/config
    echo 0x447d040 1 > $DCC_PATH/config

    #CH0_CA0_DDRPHY
    echo 0x450002c 2 > $DCC_PATH/config
    echo 0x4500094 1 > $DCC_PATH/config
    echo 0x450009c 1 > $DCC_PATH/config
    echo 0x45000c4 2 > $DCC_PATH/config
    echo 0x45003dc 1 > $DCC_PATH/config
    echo 0x45005d8 1 > $DCC_PATH/config

    #CH0_CA1_DDRPHY
    echo 0x450102c 2 > $DCC_PATH/config
    echo 0x4501094 1 > $DCC_PATH/config
    echo 0x450109c 1 > $DCC_PATH/config
    echo 0x45010c4 2 > $DCC_PATH/config
    echo 0x45013dc 1 > $DCC_PATH/config
    echo 0x45015d8 1 > $DCC_PATH/config

    #CH0_DQ0_DDRPHY
    echo 0x450202c 2 > $DCC_PATH/config
    echo 0x4502094 1 > $DCC_PATH/config
    echo 0x450209c 1 > $DCC_PATH/config
    echo 0x45020c4 2 > $DCC_PATH/config
    echo 0x45023dc 1 > $DCC_PATH/config
    echo 0x45025d8 1 > $DCC_PATH/config

    #CH0_DQ1_DDRPHY
    echo 0x450302c 2 > $DCC_PATH/config
    echo 0x4503094 1 > $DCC_PATH/config
    echo 0x450309c 1 > $DCC_PATH/config
    echo 0x45030c4 2 > $DCC_PATH/config
    echo 0x45033dc 1 > $DCC_PATH/config
    echo 0x45035d8 1 > $DCC_PATH/config

    #CH0_DQ2_DDRPHY
    echo 0x450402c 2 > $DCC_PATH/config
    echo 0x4504094 1 > $DCC_PATH/config
    echo 0x450409c 1 > $DCC_PATH/config
    echo 0x45040c8 2 > $DCC_PATH/config
    echo 0x45043dc 1 > $DCC_PATH/config
    echo 0x45045d8 1 > $DCC_PATH/config

    #CH0_DQ3_DDRPHY
    echo 0x450502c 2 > $DCC_PATH/config
    echo 0x4505094 1 > $DCC_PATH/config
    echo 0x450509c 1 > $DCC_PATH/config
    echo 0x45050c4 2 > $DCC_PATH/config
    echo 0x45053dc 1 > $DCC_PATH/config
    echo 0x45055d8 1 > $DCC_PATH/config

}

config_trinket_dcc_gpu()
{
    #GCC
    echo 0x141102C > $DCC_PATH/config
    echo 0x1436004 > $DCC_PATH/config
    echo 0x1471154 > $DCC_PATH/config
    echo 0x141050C > $DCC_PATH/config
    echo 0x143600C > $DCC_PATH/config
    echo 0x1436018 > $DCC_PATH/config
    echo 0x1480220 > $DCC_PATH/config
    echo 0x147C000 > $DCC_PATH/config
    echo 0x147D000 > $DCC_PATH/config
    echo 0x14800A0 > $DCC_PATH/config
    echo 0x1480164 > $DCC_PATH/config
    echo 0x14801E4 > $DCC_PATH/config
    echo 0x1436048 > $DCC_PATH/config
    echo 0x1436040 > $DCC_PATH/config

    #GPUCC
    echo 0x5991004 > $DCC_PATH/config
    echo 0x599100c > $DCC_PATH/config
    echo 0x5991010 > $DCC_PATH/config
    echo 0x5991014 > $DCC_PATH/config
    echo 0x5991054 > $DCC_PATH/config
    echo 0x5991060 > $DCC_PATH/config
    echo 0x599106c > $DCC_PATH/config
    echo 0x5991070 > $DCC_PATH/config
    echo 0x5991074 > $DCC_PATH/config
    echo 0x5991078 > $DCC_PATH/config
    echo 0x599107c > $DCC_PATH/config
    echo 0x599108c > $DCC_PATH/config
    echo 0x5991098 > $DCC_PATH/config
    echo 0x599109c > $DCC_PATH/config
    echo 0x5991540 > $DCC_PATH/config
    echo 0x5995000 > $DCC_PATH/config
    echo 0x5995004 > $DCC_PATH/config
}

config_trinket_dcc_gcc_mm()
{
    echo 0x01480140 > $DCC_PATH/config
    echo 0x01481140 > $DCC_PATH/config
    echo 0x0148014C > $DCC_PATH/config
    echo 0x0148114C > $DCC_PATH/config
    echo 0x01415004 > $DCC_PATH/config
    echo 0x01416004 > $DCC_PATH/config
    echo 0x0146B00C > $DCC_PATH/config
    echo 0x0146B010 > $DCC_PATH/config

    echo 0x0147700C > $DCC_PATH/config
    echo 0x01477008 > $DCC_PATH/config
    echo 0x0146B01C > $DCC_PATH/config
    echo 0x0141F02C > $DCC_PATH/config
    echo 0x01439014 > $DCC_PATH/config
    echo 0x0143900C > $DCC_PATH/config
    echo 0x01439004 > $DCC_PATH/config
    echo 0x01439000 > $DCC_PATH/config
    echo 0x01439008 > $DCC_PATH/config
    echo 0x01415010 > $DCC_PATH/config
    echo 0x01416010 > $DCC_PATH/config
    echo 0x0142A00C > $DCC_PATH/config
}

config_trinket_dcc_lpm()
{
    #APCS_ALIAS0_SAW4
    echo 0xf189000 > $DCC_PATH/config
    echo 0xf18900c > $DCC_PATH/config
    echo 0xf189c0c > $DCC_PATH/config
    echo 0xf189c10 > $DCC_PATH/config
    echo 0xf189c20 > $DCC_PATH/config
    #APCS_ALIAS1_SAW4
    echo 0xf199000 > $DCC_PATH/config
    echo 0xf19900c > $DCC_PATH/config
    echo 0xf199c0c > $DCC_PATH/config
    echo 0xf199c10 > $DCC_PATH/config
    echo 0xf199c20 > $DCC_PATH/config
    #APCS_ALIAS2_SAW4
    echo 0xf1a9000 > $DCC_PATH/config
    echo 0xf1a900c > $DCC_PATH/config
    echo 0xf1a9c0c > $DCC_PATH/config
    echo 0xf1a9c10 > $DCC_PATH/config
    echo 0xf1a9c20 > $DCC_PATH/config
    #APCS_ALIAS3_SAW4
    echo 0xf1b9000 > $DCC_PATH/config
    echo 0xf1b900c > $DCC_PATH/config
    echo 0xf1b9c0c > $DCC_PATH/config
    echo 0xf1b9c10 > $DCC_PATH/config
    echo 0xf1b9c18 > $DCC_PATH/config
    #APCS_ALIAS4_SAW4
    echo 0xf089000 > $DCC_PATH/config
    echo 0xf08900c > $DCC_PATH/config
    echo 0xf089c0c > $DCC_PATH/config
    echo 0xf089c10 > $DCC_PATH/config
    echo 0xf089c20 > $DCC_PATH/config
    #APCS_ALIAS5_SAW4
    echo 0xf099000 > $DCC_PATH/config
    echo 0xf09900c > $DCC_PATH/config
    echo 0xf099c0c > $DCC_PATH/config
    echo 0xf099c10 > $DCC_PATH/config
    echo 0xf099c20 > $DCC_PATH/config
    #APCS_ALIAS6_SAW4
    echo 0xf0a9000 > $DCC_PATH/config
    echo 0xf0a900c > $DCC_PATH/config
    echo 0xf0a9c0c > $DCC_PATH/config
    echo 0xf0a9c10 > $DCC_PATH/config
    echo 0xf0a9c20 > $DCC_PATH/config
    #APCS_ALIAS7_SAW4
    echo 0xf0b9000 > $DCC_PATH/config
    echo 0xf0b900c > $DCC_PATH/config
    echo 0xf0b9c0c > $DCC_PATH/config
    echo 0xf0a9c10 > $DCC_PATH/config
    echo 0xf0b9c20 > $DCC_PATH/config

    #APCLUS0_L2_SAW4
    echo 0xf112000 > $DCC_PATH/config
    echo 0xf11200c > $DCC_PATH/config
    echo 0xf112c0c > $DCC_PATH/config
    echo 0xf112c10 > $DCC_PATH/config
    echo 0xf112c20 > $DCC_PATH/config

    #APCLUS1_L2_SAW4
    echo 0xf012000 > $DCC_PATH/config
    echo 0xf01200c > $DCC_PATH/config
    echo 0xf012c0c > $DCC_PATH/config
    echo 0xf012c10 > $DCC_PATH/config
    echo 0xf112c20 > $DCC_PATH/config

    #CCI_SAW4
    echo 0xf1d2000 > $DCC_PATH/config
    echo 0xf1d200c > $DCC_PATH/config
    echo 0xf1d2c0c > $DCC_PATH/config
    echo 0xf1d2c10 > $DCC_PATH/config
    echo 0xf1d2c20 > $DCC_PATH/config

    #APCS_ALIAS1_L2
    echo 0xf011014 > $DCC_PATH/config
    echo 0xf011018 > $DCC_PATH/config
    echo 0xf011218 > $DCC_PATH/config
    echo 0xf011234 > $DCC_PATH/config
    echo 0xf011220 > $DCC_PATH/config
    echo 0xf011264 > $DCC_PATH/config
    echo 0xf011290 > $DCC_PATH/config

    #APCS_ALIAS0_L2
    echo 0xf111014 > $DCC_PATH/config
    echo 0xf111018 > $DCC_PATH/config
    echo 0xf111218 > $DCC_PATH/config
    echo 0xf111234 > $DCC_PATH/config
    echo 0xf111264 > $DCC_PATH/config
    echo 0xf111290 > $DCC_PATH/config

    #Curr Frequency
    echo 0x0F521700 > $DCC_PATH/config
    echo 0x0F523700 > $DCC_PATH/config

    #PIMEM
    echo 0x01B6007C > $DCC_PATH/config
}

config_trinket_dcc_noc()
{
    #SNOC
    echo 0x1880100 > $DCC_PATH/config
    echo 0x1880108 > $DCC_PATH/config
    echo 0x1880110 > $DCC_PATH/config
    echo 0x1880120 8 > $DCC_PATH/config

    echo 0x1880300 8 > $DCC_PATH/config
    echo 0x1880500 > $DCC_PATH/config
    echo 0x1880700 2 > $DCC_PATH/config
    echo 0x1880900 > $DCC_PATH/config
    echo 0x1880B00 2 > $DCC_PATH/config
    echo 0x1880D00 > $DCC_PATH/config
    echo 0x1881100 > $DCC_PATH/config
    echo 0x18E0100 > $DCC_PATH/config

    #CNOC
    echo 0x1900000 > $DCC_PATH/config
    echo 0x1900010 > $DCC_PATH/config
    echo 0x1900020 8  > $DCC_PATH/config

    echo 0x1900300 5 > $DCC_PATH/config
    echo 0x1900500 > $DCC_PATH/config
    echo 0x1900900 > $DCC_PATH/config
    echo 0x1900B00 > $DCC_PATH/config
    echo 0x1900D00 > $DCC_PATH/config
    echo 0x1908100 > $DCC_PATH/config
    echo 0x1908104 > $DCC_PATH/config

    #BIMC
    echo 0x44B0120 5 > $DCC_PATH/config
    echo 0x44B0100 > $DCC_PATH/config
    echo 0x44B0020 > $DCC_PATH/config

    echo 0x44C4000 > $DCC_PATH/config
    echo 0x44C4020 > $DCC_PATH/config
    echo 0x44C4030 > $DCC_PATH/config
    echo 0x44C4400 > $DCC_PATH/config
    echo 0x44C4410 > $DCC_PATH/config
    echo 0x44C4420 > $DCC_PATH/config
    echo 0x44C410C > $DCC_PATH/config
    echo 0x44C4100 > $DCC_PATH/config
}

config_trinket_dcc_qdsp()
{
    echo 0xB3B0208 > $DCC_PATH/config
    echo 0xB3B0228 > $DCC_PATH/config
    echo 0xB3B0248 > $DCC_PATH/config
    echo 0xB3B0268 > $DCC_PATH/config
    echo 0xB3B0288 > $DCC_PATH/config
    echo 0xB3B02A8 > $DCC_PATH/config
    echo 0xB3B020C > $DCC_PATH/config
    echo 0xB3B022C > $DCC_PATH/config
    echo 0xB3B024C > $DCC_PATH/config
    echo 0xB3B026C > $DCC_PATH/config
    echo 0xB3B028C > $DCC_PATH/config
    echo 0xB3B02AC > $DCC_PATH/config
    echo 0xB3B0210 > $DCC_PATH/config
    echo 0xB3B0230 > $DCC_PATH/config
    echo 0xB3B0250 > $DCC_PATH/config
    echo 0xB3B0270 > $DCC_PATH/config
    echo 0xB3B0290 > $DCC_PATH/config
    echo 0xB3B02B0 > $DCC_PATH/config
    echo 0xB3B0400 > $DCC_PATH/config
    echo 0xB3B0404 > $DCC_PATH/config
    echo 0xB3B0408 > $DCC_PATH/config
    echo 0xB3B0010 > $DCC_PATH/config
    echo 0xB302028 > $DCC_PATH/config

    #LPASS Register
    echo 0xABB0208 > $DCC_PATH/config
    echo 0xABB0228 > $DCC_PATH/config
    echo 0xABB0248 > $DCC_PATH/config
    echo 0xABB0268 > $DCC_PATH/config
    echo 0xABB0288 > $DCC_PATH/config
    echo 0xABB02A8 > $DCC_PATH/config
    echo 0xABB020C > $DCC_PATH/config
    echo 0xABB022C > $DCC_PATH/config
    echo 0xABB024C > $DCC_PATH/config
    echo 0xABB026C > $DCC_PATH/config
    echo 0xABB028C > $DCC_PATH/config
    echo 0xABB02AC > $DCC_PATH/config
    echo 0xABB0210 > $DCC_PATH/config
    echo 0xABB0230 > $DCC_PATH/config
    echo 0xABB0250 > $DCC_PATH/config
    echo 0xABB0270 > $DCC_PATH/config
    echo 0xABB0290 > $DCC_PATH/config
    echo 0xABB02B0 > $DCC_PATH/config
    echo 0xABB0400 > $DCC_PATH/config
    echo 0xABB0404 > $DCC_PATH/config
    echo 0xABB0408 > $DCC_PATH/config
    echo 0xABB0010 > $DCC_PATH/config
    echo 0xAB02028 > $DCC_PATH/config

    #Modem
    echo 0x6130208 > $DCC_PATH/config
    echo 0x6130228 > $DCC_PATH/config
    echo 0x6130248 > $DCC_PATH/config
    echo 0x6130268 > $DCC_PATH/config
    echo 0x6130288 > $DCC_PATH/config
    echo 0x61302A8 > $DCC_PATH/config
    echo 0x613020C > $DCC_PATH/config
    echo 0x613022C > $DCC_PATH/config
    echo 0x613024C > $DCC_PATH/config
    echo 0x613026C > $DCC_PATH/config
    echo 0x613028C > $DCC_PATH/config
    echo 0x61302AC > $DCC_PATH/config
    echo 0x6130210 > $DCC_PATH/config
    echo 0x6130230 > $DCC_PATH/config
    echo 0x6130250 > $DCC_PATH/config
    echo 0x6130270 > $DCC_PATH/config
    echo 0x6130290 > $DCC_PATH/config
    echo 0x61302B0 > $DCC_PATH/config
    echo 0x6130400 > $DCC_PATH/config
    echo 0x6130404 > $DCC_PATH/config
    echo 0x6130408 > $DCC_PATH/config
    echo 0x6130010 > $DCC_PATH/config
    echo 0x6082028 > $DCC_PATH/config
}

config_trinket_dcc_misc()
{
    echo 0xF017000 > $DCC_PATH/config
    echo 0xF01700C > $DCC_PATH/config
    echo 0xF017010 > $DCC_PATH/config
    echo 0xF017014 > $DCC_PATH/config
    echo 0xF017018 > $DCC_PATH/config
    echo 0xF017020 > $DCC_PATH/config
}

# Function to send ASYNC package in TPDA
dcc_async_package()
{
    echo 0x08004FB0 0xc5acce55 > $DCC_PATH/config_write
    echo 0x0800408c 0xff > $DCC_PATH/config_write
    echo 0x08004FB0 0x0 > $DCC_PATH/config_write
}

# Function trinket DCC configuration
enable_trinket_dcc_config()
{
    DCC_PATH="/sys/bus/platform/devices/1be2000.dcc_v2"
    soc_version=`cat /sys/devices/soc0/revision`
    soc_version=${soc_version/./}

    if [ ! -d $DCC_PATH ]; then
        echo "DCC does not exist on this build."
        return
    fi

    echo 0 > $DCC_PATH/enable
    echo 2 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    echo 1 > $DCC_PATH/config_reset
    config_trinket_dcc_bimc
    config_trinket_dcc_gpu
    config_trinket_dcc_lpm
    config_trinket_dcc_noc
    config_trinket_dcc_qdsp
    config_trinket_dcc_misc

    #configure sink for LL3 as atb
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-dcc/enable_source
    echo 3 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo atb > $DCC_PATH/data_sink
    dcc_async_package
    config_trinket_dcc_gcc_mm
    echo  1 > $DCC_PATH/enable
}

enable_trinket_stm_hw_events()
{
    chmod 777 /vendor/bin/testapp_diag_senddata
    echo 33 0x0 > /sys/bus/coresight/devices/coresight-tpdm-swao-0/cmb_msr
    echo 48 0x0 > /sys/bus/coresight/devices/coresight-tpdm-swao-0/cmb_msr
    echo 0x0 > /sys/bus/coresight/devices/coresight-tpdm-swao-0/mcmb_lanes_select
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-swao-0/cmb_trig_ts
    echo 0 >  /sys/bus/coresight/devices/coresight-tpdm-swao-0/enable_source
    echo 1 > /sys/bus/coresight/devices/coresight-cti-swao_cti0/reset
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/reset
    echo 0x0 0x0 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x0 0x0 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2 0x2 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2 0x2 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x3 0x3 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x3 0x3 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x4 0x4 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x4 0x4 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x5 0x5 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x5 0x5 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x6 0x6 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x6 0x6 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x7 0x7 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x7 0x7 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x8 0x8 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x8 0x8 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x9 0x9 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x9 0x9 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xa 0xa 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xa 0xa 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xb 0xb 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xb 0xb 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc 0xc 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc 0xc 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xd 0xd 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xd 0xd 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xe 0xe 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xe 0xe 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xf 0xf 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xf 0xf 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x10 0x10 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x10 0x10 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x12 0x12 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x12 0x12 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x14 0x14 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x14 0x14 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x15 0x15 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x15 0x15 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x17 0x17 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x17 0x17 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x19 0x19 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x19 0x19 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1a 0x1a 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1a 0x1a 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1b 0x1b 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1b 0x1b 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1d 0x1d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1d 0x1d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1e 0x1e 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1e 0x1e 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1f 0x1f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1f 0x1f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x20 0x20 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x20 0x20 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x21 0x21 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x21 0x21 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x22 0x22 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x22 0x22 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x23 0x23 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x23 0x23 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x24 0x24 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x24 0x24 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x25 0x25 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x25 0x25 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x26 0x26 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x26 0x26 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x27 0x27 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x27 0x27 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x28 0x28 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x28 0x28 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x29 0x29 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x29 0x29 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2a 0x2a 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2a 0x2a 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2b 0x2b 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2b 0x2b 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2c 0x2c 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2c 0x2c 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2d 0x2d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2d 0x2d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2e 0x2e 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2e 0x2e 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2f 0x2f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2f 0x2f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x30 0x30 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x30 0x30 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x31 0x31 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x31 0x31 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x32 0x32 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x32 0x32 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x33 0x33 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x33 0x33 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x35 0x35 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x35 0x35 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x36 0x36 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x36 0x36 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x38 0x38 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x38 0x38 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x39 0x39 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x39 0x39 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x3a 0x3a 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x3a 0x3a 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x3b 0x3b 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x3b 0x3b 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x3c 0x3c 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x3c 0x3c 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0 0x10010000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 1 0x01100100  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 2 0x70700000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 3 0x10000070  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 4 0x01100100  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 5 0x11101010  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 6 0x00000040  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 7 0x00040000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_ts
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_type
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_trig_ts
    echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_datasets
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_source
}

enable_trinket_debug()
{
    echo "trinket debug"
    srcenable="enable_source"
    sinkenable="enable_sink"
    echo "Enabling STM events on trinket."
    enable_trinket_stm_events
    echo "Enabling HW  events on trinket."
    enable_trinket_stm_hw_events
    if [ "$ftrace_disable" != "Yes" ]; then
        enable_trinket_ftrace_event_tracing
    fi
    enable_trinket_dcc_config
}
