Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C492F415E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jan 2021 02:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAMBvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 20:51:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:43846 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbhAMBvl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 20:51:41 -0500
IronPort-SDR: rkMewAuXocA64YbwoKJhmTekKQLr3zlzDigRC4tmxbCXrgjz6SbcXGwvpSY/roWNQi+8yntsR/
 7G4pJMgBJaMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165222036"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="yaml'?scan'208";a="165222036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:50:49 -0800
IronPort-SDR: rDZqY3cHAhOdpWIKVJj5bv9r6mzdPXz940SfOKYsnSfwYVwocM1PEvg4nvbRjiTDU5SHLL5Gqy
 VbX17mt8hj3g==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="yaml'?scan'208";a="353263925"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:50:44 -0800
Date:   Wed, 13 Jan 2021 10:06:07 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        linux-btrfs@vger.kernel.org
Subject: [btrfs]  53c5e5a1d8:  fsmark.files_per_sec -14.4% regression
Message-ID: <20210113020607.GA7528@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -14.4% regression of fsmark.files_per_sec due to commit:


commit: 53c5e5a1d87e3341d06a00746c772dc7eff6a65b ("btrfs: simplify the logic in need_preemptive_flushing")
https://github.com/kdave/btrfs-devel.git for-next-20210104


in testcase: fsmark
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_48G
	fs: btrfs
	filesize: 4M
	test_size: 24G
	sync_method: fsyncBeforeClose
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
test-url: https://sourceforge.net/projects/fsmark/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | fio-basic: fio.write_iops -59.9% regression                            |
| test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory            |
| test parameters  | bs=4k                                                                  |
|                  | cpufreq_governor=performance                                           |
|                  | disk=1SSD                                                              |
|                  | fs=btrfs                                                               |
|                  | ioengine=sync                                                          |
|                  | nr_task=8                                                              |
|                  | runtime=300s                                                           |
|                  | rw=write                                                               |
|                  | test_size=256g                                                         |
|                  | ucode=0x4003003                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -3.5% regression                               |
| test machine     | 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | disk=1BRD_48G                                                          |
|                  | fs=btrfs                                                               |
|                  | load=4                                                                 |
|                  | test=creat-clo                                                         |
|                  | ucode=0x700001e                                                        |
+------------------+------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/btrfs/1x/x86_64-rhel-8.3/1t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap2/24G/fsmark/0x5003003

commit: 
  5b964115b5 ("btrfs: rework btrfs_calc_reclaim_metadata_size")
  53c5e5a1d8 ("btrfs: simplify the logic in need_preemptive_flushing")

5b964115b57bfe55 53c5e5a1d87e3341d06a00746c7 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4            1%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4            1%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    239.48           -14.4%     205.05        fsmark.files_per_sec
     27.49           +15.7%      31.79        fsmark.time.elapsed_time
     27.49           +15.7%      31.79        fsmark.time.elapsed_time.max
     26.81           +15.9%      31.08        fsmark.time.system_time
      0.21 �  3%      -0.0        0.18        mpstat.cpu.all.usr%
      1922 � 11%     +23.6%       2377 �  7%  sched_debug.cpu.avg_idle.min
    836321           -12.2%     734615        vmstat.io.bo
      1840 �  9%     -25.0%       1379 � 17%  meminfo.Writeback
   1813949 �  2%     -12.0%    1595838        meminfo.max_used_kB
      2706 � 48%    +221.4%       8700 � 71%  softirqs.NET_RX
   1101600           +10.6%    1218682        softirqs.SCHED
   6106677 � 99%     -99.8%      14876 � 35%  numa-numastat.node2.local_node
   6193240 � 98%     -98.4%     101442 �  5%  numa-numastat.node2.numa_hit
    346322 � 75%     -81.2%      64945 � 57%  numa-numastat.node3.other_node
 4.651e+09 � 23%     +29.3%  6.013e+09        cpuidle.C1E.time
  10275557 � 15%     +24.2%   12766663        cpuidle.C1E.usage
     37470 �  5%     +34.0%      50206 � 24%  cpuidle.POLL.time
      9995           +36.8%      13675 �  9%  cpuidle.POLL.usage
    486.00 �170%    +117.8%       1058 � 91%  numa-meminfo.node0.Dirty
   3199694 �158%     +97.8%    6328688 � 94%  numa-meminfo.node0.FilePages
   2886568 �173%    +107.5%    5989331 � 98%  numa-meminfo.node0.Inactive(file)
   5952654 � 96%     -98.3%      99890 � 49%  numa-meminfo.node2.Inactive
  13431706 � 92%     -93.0%     936825 � 12%  numa-meminfo.node2.MemUsed
     65018 � 45%    +153.4%     164769 � 58%  numa-meminfo.node3.AnonPages
     65783 � 44%    +156.2%     168505 � 57%  numa-meminfo.node3.Inactive(anon)
      6776 �  5%     +23.7%       8383 � 14%  numa-meminfo.node3.KernelStack
      1129 � 62%    +387.2%       5504 � 68%  numa-meminfo.node3.PageTables
    107132 �  3%      -5.8%     100954 �  2%  proc-vmstat.nr_anon_pages
    109883 �  3%      -5.7%     103640 �  2%  proc-vmstat.nr_inactive_anon
    425.25 � 16%     -21.4%     334.25 � 13%  proc-vmstat.nr_writeback
    109883 �  3%      -5.7%     103640 �  2%  proc-vmstat.nr_zone_inactive_anon
    593623 �  3%     +16.5%     691600 �  8%  proc-vmstat.numa_foreign
    593623 �  3%     +16.5%     691600 �  8%  proc-vmstat.numa_miss
    853428 �  2%     +11.5%     951407 �  5%  proc-vmstat.numa_other
    150853 �  5%      +9.8%     165681 �  2%  proc-vmstat.pgfault
      7385 �  2%     +13.0%       8347        proc-vmstat.pgreuse
    796087 �157%     +98.2%    1577690 � 94%  numa-vmstat.node0.nr_file_pages
    717788 �173%    +108.0%    1492825 � 98%  numa-vmstat.node0.nr_inactive_file
      2259 � 24%     -20.2%       1803 �  6%  numa-vmstat.node0.nr_mapped
    717788 �173%    +108.0%    1492819 � 98%  numa-vmstat.node0.nr_zone_inactive_file
     15938 � 26%     -21.1%      12572 � 21%  numa-vmstat.node1.nr_slab_unreclaimable
     16329 � 44%    +150.8%      40954 � 58%  numa-vmstat.node3.nr_anon_pages
     16522 � 44%    +152.7%      41751 � 58%  numa-vmstat.node3.nr_inactive_anon
      6772 �  5%     +23.7%       8374 � 14%  numa-vmstat.node3.nr_kernel_stack
    280.75 � 63%    +388.2%       1370 � 68%  numa-vmstat.node3.nr_page_table_pages
     16521 � 44%    +152.7%      41751 � 58%  numa-vmstat.node3.nr_zone_inactive_anon
    499113 �  5%    +689.0%    3938239 � 84%  numa-vmstat.node3.numa_hit
    384758 � 12%    +892.7%    3819327 � 86%  numa-vmstat.node3.numa_local
     11.83 �  2%     -11.7%      10.44        perf-stat.i.MPKI
 1.272e+09            +3.3%  1.314e+09        perf-stat.i.branch-instructions
      1.78            -0.2        1.54        perf-stat.i.branch-miss-rate%
  27489113 �  3%     -10.0%   24734118        perf-stat.i.branch-misses
  69581732 �  2%      -7.2%   64558270        perf-stat.i.cache-references
      2.57 �  2%      -9.6%       2.32        perf-stat.i.cpi
 1.598e+10 �  2%      -7.1%  1.484e+10        perf-stat.i.cpu-cycles
    251.20            -2.8%     244.05        perf-stat.i.cpu-migrations
 7.777e+08            -5.2%  7.369e+08        perf-stat.i.dTLB-stores
     56.13 �  2%      -1.5       54.62        perf-stat.i.iTLB-load-miss-rate%
   5000319 �  4%      -4.6%    4768521        perf-stat.i.iTLB-load-misses
   3899306            +1.6%    3960144        perf-stat.i.iTLB-loads
      1311 �  3%      +6.6%       1397        perf-stat.i.instructions-per-iTLB-miss
      0.41            +9.7%       0.44        perf-stat.i.ipc
      7.20 �  3%     -13.5%       6.22 �  5%  perf-stat.i.major-faults
      0.08 �  2%      -7.1%       0.08        perf-stat.i.metric.GHz
   1297657 �  3%      -5.6%    1224413 �  2%  perf-stat.i.node-load-misses
     10.63            -8.9%       9.69        perf-stat.overall.MPKI
      2.16 �  2%      -0.3        1.88        perf-stat.overall.branch-miss-rate%
      2.44            -8.8%       2.22        perf-stat.overall.cpi
     56.15 �  2%      -1.5       54.63        perf-stat.overall.iTLB-load-miss-rate%
      1313 �  3%      +6.4%       1397        perf-stat.overall.instructions-per-iTLB-miss
      0.41            +9.6%       0.45        perf-stat.overall.ipc
 1.226e+09            +3.5%  1.269e+09        perf-stat.ps.branch-instructions
  26520603 �  2%     -10.1%   23847387        perf-stat.ps.branch-misses
  67153636 �  2%      -6.9%   62502238        perf-stat.ps.cache-references
 1.541e+10 �  2%      -6.8%  1.435e+10        perf-stat.ps.cpu-cycles
    242.48            -2.7%     235.91        perf-stat.ps.cpu-migrations
 7.492e+08            -4.9%  7.123e+08        perf-stat.ps.dTLB-stores
   4819104 �  4%      -4.2%    4617865        perf-stat.ps.iTLB-load-misses
   3758462            +2.0%    3835078        perf-stat.ps.iTLB-loads
 6.317e+09            +2.1%  6.452e+09        perf-stat.ps.instructions
      7.02 �  3%     -14.5%       6.00        perf-stat.ps.major-faults
 1.807e+11           +16.6%  2.108e+11        perf-stat.total.instructions
      0.86 �  6%      -0.1        0.75 � 13%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.82 �  6%      -0.1        0.71 � 13%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.79 �  6%      +0.1        0.86 �  2%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.9        0.85 � 15%  perf-profile.calltrace.cycles-pp.cpumask_next.__percpu_counter_sum.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
      5.52 � 10%      +1.9        7.38 � 13%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      5.50 � 10%      +1.9        7.36 � 12%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
      5.60 � 10%      +1.9        7.47 � 13%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.58 � 10%      +1.9        7.45 � 13%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.41 �  8%      +2.0        9.40 �  8%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.1        2.12 � 12%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      0.00            +2.2        2.17 � 12%  perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      0.00            +2.2        2.17 � 12%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +2.2        2.23 � 12%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.88 �  7%      -0.1        0.77 � 14%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.52 � 14%      -0.1        0.41 � 15%  perf-profile.children.cycles-pp.end_page_writeback
      0.46 � 13%      -0.1        0.35 � 14%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.24 �  8%      -0.0        0.19 �  9%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.24 �  8%      -0.0        0.19 �  9%  perf-profile.children.cycles-pp.clear_extent_bit
      0.16 �  5%      -0.0        0.13 �  9%  perf-profile.children.cycles-pp.alloc_extent_state
      0.14 �  6%      +0.0        0.18 � 21%  perf-profile.children.cycles-pp.__schedule
      0.31 �  6%      +0.0        0.35 �  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.04 � 59%      +0.1        0.10 � 17%  perf-profile.children.cycles-pp.alloc_tree_block_no_bg_flush
      0.04 � 60%      +0.1        0.10 � 17%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      0.21 �  4%      +0.1        0.28        perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.18 � 10%      +0.1        0.26 � 15%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.12 � 19%      +0.1        0.20 � 16%  perf-profile.children.cycles-pp.__btrfs_cow_block
      0.12 � 19%      +0.1        0.20 � 15%  perf-profile.children.cycles-pp.btrfs_cow_block
      0.83 �  3%      +0.1        0.93 �  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.14 � 17%  perf-profile.children.cycles-pp.find_next_bit
      0.12 � 16%      +0.6        0.67 � 15%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +1.0        0.99 � 15%  perf-profile.children.cycles-pp.cpumask_next
      5.52 � 10%      +1.9        7.38 � 13%  perf-profile.children.cycles-pp.btrfs_file_write_iter
      5.50 � 10%      +1.9        7.36 � 13%  perf-profile.children.cycles-pp.btrfs_buffered_write
      7.49 �  8%      +2.0        9.48 �  8%  perf-profile.children.cycles-pp.ksys_write
      7.42 �  8%      +2.0        9.41 �  8%  perf-profile.children.cycles-pp.new_sync_write
      7.46 �  8%      +2.0        9.46 �  8%  perf-profile.children.cycles-pp.vfs_write
      0.11 � 12%      +2.1        2.23 � 12%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.06 � 11%      +2.2        2.25 � 12%  perf-profile.children.cycles-pp.__reserve_bytes
      0.00            +2.2        2.19 � 12%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.03 �100%      +2.2        2.24 � 12%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.21 �  4%      +0.1        0.28        perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.83 �  3%      +0.1        0.92 �  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.14 � 17%  perf-profile.self.cycles-pp.find_next_bit
      0.00            +0.3        0.30 � 15%  perf-profile.self.cycles-pp.cpumask_next
      0.11 � 14%      +0.5        0.66 � 16%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +1.2        1.17 � 10%  perf-profile.self.cycles-pp.__percpu_counter_sum
      2506 � 18%     -29.0%       1779 � 19%  interrupts.CPU0.CAL:Function_call_interrupts
     57908           +15.2%      66697        interrupts.CPU0.LOC:Local_timer_interrupts
     58115           +14.8%      66696        interrupts.CPU1.LOC:Local_timer_interrupts
     58148           +14.7%      66677        interrupts.CPU10.LOC:Local_timer_interrupts
     58110           +14.7%      66638        interrupts.CPU100.LOC:Local_timer_interrupts
     58085           +14.7%      66623        interrupts.CPU101.LOC:Local_timer_interrupts
     58066           +14.8%      66634        interrupts.CPU102.LOC:Local_timer_interrupts
     57776           +15.4%      66656        interrupts.CPU103.LOC:Local_timer_interrupts
     58053           +14.8%      66625        interrupts.CPU104.LOC:Local_timer_interrupts
     58042           +14.5%      66472        interrupts.CPU105.LOC:Local_timer_interrupts
     58036           +14.8%      66631        interrupts.CPU106.LOC:Local_timer_interrupts
     58034           +14.8%      66597        interrupts.CPU107.LOC:Local_timer_interrupts
     57578 �  2%     +15.7%      66607        interrupts.CPU108.LOC:Local_timer_interrupts
     58018           +14.8%      66613        interrupts.CPU109.LOC:Local_timer_interrupts
     58074           +14.7%      66640        interrupts.CPU11.LOC:Local_timer_interrupts
     58051           +14.7%      66592        interrupts.CPU110.LOC:Local_timer_interrupts
     58069           +14.8%      66653        interrupts.CPU111.LOC:Local_timer_interrupts
     58050           +14.8%      66617        interrupts.CPU112.LOC:Local_timer_interrupts
     58054           +14.8%      66638        interrupts.CPU113.LOC:Local_timer_interrupts
     58097           +14.7%      66635        interrupts.CPU114.LOC:Local_timer_interrupts
     58048           +14.7%      66602        interrupts.CPU115.LOC:Local_timer_interrupts
    232.50 � 20%     -31.2%     160.00 � 34%  interrupts.CPU115.NMI:Non-maskable_interrupts
    232.50 � 20%     -31.2%     160.00 � 34%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
     58068           +14.7%      66620        interrupts.CPU116.LOC:Local_timer_interrupts
     58073           +14.7%      66606        interrupts.CPU117.LOC:Local_timer_interrupts
     58073           +14.7%      66601        interrupts.CPU118.LOC:Local_timer_interrupts
     57930           +15.0%      66637        interrupts.CPU119.LOC:Local_timer_interrupts
    226.25 � 21%     -42.4%     130.25 � 14%  interrupts.CPU119.NMI:Non-maskable_interrupts
    226.25 � 21%     -42.4%     130.25 � 14%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
     58108           +14.8%      66699        interrupts.CPU12.LOC:Local_timer_interrupts
     58024           +14.8%      66604        interrupts.CPU120.LOC:Local_timer_interrupts
     58007           +14.5%      66430        interrupts.CPU121.LOC:Local_timer_interrupts
     58028           +14.8%      66625        interrupts.CPU122.LOC:Local_timer_interrupts
     58032           +14.7%      66585        interrupts.CPU123.LOC:Local_timer_interrupts
     58036           +14.8%      66606        interrupts.CPU124.LOC:Local_timer_interrupts
     58033           +14.8%      66615        interrupts.CPU125.LOC:Local_timer_interrupts
     58024           +14.8%      66627        interrupts.CPU126.LOC:Local_timer_interrupts
     58015           +14.8%      66593        interrupts.CPU127.LOC:Local_timer_interrupts
     58011           +14.8%      66598        interrupts.CPU128.LOC:Local_timer_interrupts
     58016           +14.8%      66594        interrupts.CPU129.LOC:Local_timer_interrupts
     58089           +14.9%      66753        interrupts.CPU13.LOC:Local_timer_interrupts
     58005           +14.8%      66591        interrupts.CPU130.LOC:Local_timer_interrupts
     58016           +14.8%      66623        interrupts.CPU131.LOC:Local_timer_interrupts
     57791           +15.3%      66640        interrupts.CPU132.LOC:Local_timer_interrupts
     58027           +14.7%      66578        interrupts.CPU133.LOC:Local_timer_interrupts
     58043           +14.7%      66594        interrupts.CPU134.LOC:Local_timer_interrupts
     58005           +14.8%      66600        interrupts.CPU135.LOC:Local_timer_interrupts
     58003           +14.8%      66594        interrupts.CPU136.LOC:Local_timer_interrupts
     58019           +14.8%      66590        interrupts.CPU137.LOC:Local_timer_interrupts
     58044           +14.7%      66588        interrupts.CPU138.LOC:Local_timer_interrupts
     58036           +14.7%      66575        interrupts.CPU139.LOC:Local_timer_interrupts
     58111           +14.7%      66629        interrupts.CPU14.LOC:Local_timer_interrupts
     58032           +14.7%      66581        interrupts.CPU140.LOC:Local_timer_interrupts
     58026           +14.8%      66593        interrupts.CPU141.LOC:Local_timer_interrupts
     58003           +14.8%      66605        interrupts.CPU142.LOC:Local_timer_interrupts
     57998           +14.9%      66617        interrupts.CPU143.LOC:Local_timer_interrupts
     57886           +15.0%      66570        interrupts.CPU144.LOC:Local_timer_interrupts
    918.25 � 88%     -85.3%     135.25 � 10%  interrupts.CPU144.NMI:Non-maskable_interrupts
    918.25 � 88%     -85.3%     135.25 � 10%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
     58017           +14.8%      66607        interrupts.CPU145.LOC:Local_timer_interrupts
     58017           +14.8%      66597        interrupts.CPU146.LOC:Local_timer_interrupts
     58016           +14.8%      66583        interrupts.CPU147.LOC:Local_timer_interrupts
     57938           +14.9%      66573        interrupts.CPU148.LOC:Local_timer_interrupts
     58031           +14.8%      66600        interrupts.CPU149.LOC:Local_timer_interrupts
     58103           +14.7%      66639        interrupts.CPU15.LOC:Local_timer_interrupts
     58004           +14.8%      66581        interrupts.CPU150.LOC:Local_timer_interrupts
     58000           +14.7%      66527        interrupts.CPU151.LOC:Local_timer_interrupts
     57945           +14.9%      66586        interrupts.CPU152.LOC:Local_timer_interrupts
     58027           +14.7%      66574        interrupts.CPU153.LOC:Local_timer_interrupts
     58036           +14.7%      66567        interrupts.CPU154.LOC:Local_timer_interrupts
     58031           +14.8%      66597        interrupts.CPU155.LOC:Local_timer_interrupts
     58012           +14.8%      66582        interrupts.CPU156.LOC:Local_timer_interrupts
     58009           +14.8%      66599        interrupts.CPU157.LOC:Local_timer_interrupts
     58069           +14.7%      66584        interrupts.CPU158.LOC:Local_timer_interrupts
     57997           +14.8%      66596        interrupts.CPU159.LOC:Local_timer_interrupts
     58081           +14.7%      66633        interrupts.CPU16.LOC:Local_timer_interrupts
     58014           +14.8%      66583        interrupts.CPU160.LOC:Local_timer_interrupts
     58016           +14.9%      66633        interrupts.CPU161.LOC:Local_timer_interrupts
     57998           +14.8%      66579        interrupts.CPU162.LOC:Local_timer_interrupts
     58019           +14.7%      66563        interrupts.CPU163.LOC:Local_timer_interrupts
     57996           +14.8%      66558        interrupts.CPU164.LOC:Local_timer_interrupts
     58019           +14.7%      66570        interrupts.CPU165.LOC:Local_timer_interrupts
     58041           +14.7%      66581        interrupts.CPU166.LOC:Local_timer_interrupts
     57854           +15.1%      66600        interrupts.CPU167.LOC:Local_timer_interrupts
     57991           +14.8%      66594        interrupts.CPU168.LOC:Local_timer_interrupts
     58009           +14.8%      66610        interrupts.CPU169.LOC:Local_timer_interrupts
     58089           +14.7%      66643        interrupts.CPU17.LOC:Local_timer_interrupts
     58035           +14.8%      66595        interrupts.CPU170.LOC:Local_timer_interrupts
     57732           +15.4%      66622        interrupts.CPU171.LOC:Local_timer_interrupts
     58030           +14.8%      66599        interrupts.CPU172.LOC:Local_timer_interrupts
     58019           +13.7%      65945        interrupts.CPU173.LOC:Local_timer_interrupts
    180.00 � 26%    +225.0%     585.00 � 56%  interrupts.CPU173.NMI:Non-maskable_interrupts
    180.00 � 26%    +225.0%     585.00 � 56%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
     58013           +14.5%      66447        interrupts.CPU174.LOC:Local_timer_interrupts
     58015           +14.8%      66594        interrupts.CPU175.LOC:Local_timer_interrupts
     58014           +14.8%      66592        interrupts.CPU176.LOC:Local_timer_interrupts
     58033           +14.7%      66588        interrupts.CPU177.LOC:Local_timer_interrupts
     57906           +15.0%      66602        interrupts.CPU178.LOC:Local_timer_interrupts
     58020           +14.8%      66636        interrupts.CPU179.LOC:Local_timer_interrupts
     58075           +14.8%      66648        interrupts.CPU18.LOC:Local_timer_interrupts
     58017           +14.8%      66587        interrupts.CPU180.LOC:Local_timer_interrupts
     58019           +14.8%      66622        interrupts.CPU181.LOC:Local_timer_interrupts
     58042           +14.7%      66586        interrupts.CPU182.LOC:Local_timer_interrupts
     58006           +14.8%      66582        interrupts.CPU183.LOC:Local_timer_interrupts
     57993           +14.8%      66583        interrupts.CPU184.LOC:Local_timer_interrupts
     58008           +14.8%      66583        interrupts.CPU185.LOC:Local_timer_interrupts
     58018           +14.8%      66592        interrupts.CPU186.LOC:Local_timer_interrupts
     57998           +14.7%      66524        interrupts.CPU187.LOC:Local_timer_interrupts
     58005           +14.8%      66581        interrupts.CPU188.LOC:Local_timer_interrupts
     58010           +14.6%      66507        interrupts.CPU189.LOC:Local_timer_interrupts
     58109           +14.7%      66660        interrupts.CPU19.LOC:Local_timer_interrupts
     58006           +14.8%      66580        interrupts.CPU190.LOC:Local_timer_interrupts
     58048           +14.7%      66595        interrupts.CPU191.LOC:Local_timer_interrupts
     57029 �  3%     +16.1%      66183 �  2%  interrupts.CPU2.LOC:Local_timer_interrupts
     58085           +14.7%      66645        interrupts.CPU20.LOC:Local_timer_interrupts
     58075           +14.8%      66680        interrupts.CPU21.LOC:Local_timer_interrupts
     58095           +14.7%      66656        interrupts.CPU22.LOC:Local_timer_interrupts
     58050           +14.8%      66636        interrupts.CPU23.LOC:Local_timer_interrupts
     58056           +14.8%      66641        interrupts.CPU24.LOC:Local_timer_interrupts
     58014           +14.9%      66641        interrupts.CPU25.LOC:Local_timer_interrupts
     58088           +14.7%      66646        interrupts.CPU26.LOC:Local_timer_interrupts
      1797 �  8%     +33.5%       2400 � 35%  interrupts.CPU27.CAL:Function_call_interrupts
     58030           +13.1%      65636 �  2%  interrupts.CPU27.LOC:Local_timer_interrupts
     58061           +14.7%      66620        interrupts.CPU28.LOC:Local_timer_interrupts
     58048           +14.8%      66621        interrupts.CPU29.LOC:Local_timer_interrupts
     58023           +14.8%      66631        interrupts.CPU3.LOC:Local_timer_interrupts
     58074           +14.7%      66614        interrupts.CPU30.LOC:Local_timer_interrupts
     58100           +14.7%      66620        interrupts.CPU31.LOC:Local_timer_interrupts
     58061           +14.7%      66615        interrupts.CPU32.LOC:Local_timer_interrupts
     58096           +14.2%      66368        interrupts.CPU33.LOC:Local_timer_interrupts
     58066           +14.7%      66616        interrupts.CPU34.LOC:Local_timer_interrupts
     58066           +14.7%      66626        interrupts.CPU35.LOC:Local_timer_interrupts
     58025           +14.7%      66580        interrupts.CPU36.LOC:Local_timer_interrupts
     58036           +14.8%      66616        interrupts.CPU37.LOC:Local_timer_interrupts
     58072           +14.7%      66612        interrupts.CPU38.LOC:Local_timer_interrupts
     58052           +14.7%      66610        interrupts.CPU39.LOC:Local_timer_interrupts
     58094           +14.8%      66666        interrupts.CPU4.LOC:Local_timer_interrupts
     58063           +14.7%      66614        interrupts.CPU40.LOC:Local_timer_interrupts
     58052           +14.8%      66627        interrupts.CPU41.LOC:Local_timer_interrupts
     58035           +14.8%      66616        interrupts.CPU42.LOC:Local_timer_interrupts
     58048           +14.8%      66636        interrupts.CPU43.LOC:Local_timer_interrupts
     58080           +14.7%      66631        interrupts.CPU44.LOC:Local_timer_interrupts
     58050           +14.8%      66625        interrupts.CPU45.LOC:Local_timer_interrupts
     58060           +14.7%      66621        interrupts.CPU46.LOC:Local_timer_interrupts
     58072           +14.7%      66631        interrupts.CPU47.LOC:Local_timer_interrupts
     58005           +14.6%      66448        interrupts.CPU48.LOC:Local_timer_interrupts
     58069           +14.7%      66614        interrupts.CPU49.LOC:Local_timer_interrupts
     58103           +14.7%      66625        interrupts.CPU5.LOC:Local_timer_interrupts
     58049           +14.8%      66613        interrupts.CPU50.LOC:Local_timer_interrupts
     58056           +14.7%      66615        interrupts.CPU51.LOC:Local_timer_interrupts
     57464 �  2%     +15.9%      66581        interrupts.CPU52.LOC:Local_timer_interrupts
     58050           +14.7%      66598        interrupts.CPU53.LOC:Local_timer_interrupts
     58046           +14.7%      66584        interrupts.CPU54.LOC:Local_timer_interrupts
     58080           +14.0%      66219        interrupts.CPU55.LOC:Local_timer_interrupts
     57786           +15.2%      66582        interrupts.CPU56.LOC:Local_timer_interrupts
     58058           +14.7%      66596        interrupts.CPU57.LOC:Local_timer_interrupts
     58066           +14.5%      66482        interrupts.CPU58.LOC:Local_timer_interrupts
     58044           +14.7%      66581        interrupts.CPU59.LOC:Local_timer_interrupts
     58093           +14.7%      66625        interrupts.CPU6.LOC:Local_timer_interrupts
     58038           +14.8%      66609        interrupts.CPU60.LOC:Local_timer_interrupts
     58033           +14.7%      66590        interrupts.CPU61.LOC:Local_timer_interrupts
     58015           +14.8%      66605        interrupts.CPU62.LOC:Local_timer_interrupts
     58081           +14.7%      66604        interrupts.CPU63.LOC:Local_timer_interrupts
     58048           +14.8%      66634        interrupts.CPU64.LOC:Local_timer_interrupts
     58025           +14.4%      66400        interrupts.CPU65.LOC:Local_timer_interrupts
     58043           +14.7%      66597        interrupts.CPU66.LOC:Local_timer_interrupts
     58050           +14.7%      66585        interrupts.CPU67.LOC:Local_timer_interrupts
     58083           +14.6%      66573        interrupts.CPU68.LOC:Local_timer_interrupts
     58043           +14.7%      66601        interrupts.CPU69.LOC:Local_timer_interrupts
     58012           +14.9%      66639        interrupts.CPU7.LOC:Local_timer_interrupts
     58046           +14.7%      66580        interrupts.CPU70.LOC:Local_timer_interrupts
     58040           +14.8%      66619        interrupts.CPU71.LOC:Local_timer_interrupts
     57810           +15.1%      66538        interrupts.CPU72.LOC:Local_timer_interrupts
     58076           +14.7%      66616        interrupts.CPU73.LOC:Local_timer_interrupts
     58033           +14.8%      66636        interrupts.CPU74.LOC:Local_timer_interrupts
     57667           +15.5%      66598        interrupts.CPU75.LOC:Local_timer_interrupts
     58034           +14.8%      66622        interrupts.CPU76.LOC:Local_timer_interrupts
     58045           +14.7%      66568        interrupts.CPU77.LOC:Local_timer_interrupts
    176.50 � 25%    +328.0%     755.50 � 91%  interrupts.CPU77.NMI:Non-maskable_interrupts
    176.50 � 25%    +328.0%     755.50 � 91%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     58031           +13.8%      66059        interrupts.CPU78.LOC:Local_timer_interrupts
     58026           +14.8%      66603        interrupts.CPU79.LOC:Local_timer_interrupts
     58056           +14.7%      66597        interrupts.CPU8.LOC:Local_timer_interrupts
     58027           +14.3%      66306        interrupts.CPU80.LOC:Local_timer_interrupts
     58030           +14.7%      66538        interrupts.CPU81.LOC:Local_timer_interrupts
     57995           +14.9%      66616        interrupts.CPU82.LOC:Local_timer_interrupts
     58047           +14.7%      66558        interrupts.CPU83.LOC:Local_timer_interrupts
     58036           +14.8%      66608        interrupts.CPU84.LOC:Local_timer_interrupts
     58038           +14.8%      66607        interrupts.CPU85.LOC:Local_timer_interrupts
     58032           +14.8%      66609        interrupts.CPU86.LOC:Local_timer_interrupts
     57907           +15.1%      66632        interrupts.CPU87.LOC:Local_timer_interrupts
     58018           +14.8%      66621        interrupts.CPU88.LOC:Local_timer_interrupts
     58029           +14.5%      66471        interrupts.CPU89.LOC:Local_timer_interrupts
     58101           +14.6%      66596        interrupts.CPU9.LOC:Local_timer_interrupts
     58065           +14.7%      66609        interrupts.CPU90.LOC:Local_timer_interrupts
     58050           +14.5%      66495        interrupts.CPU91.LOC:Local_timer_interrupts
     58057           +14.7%      66612        interrupts.CPU92.LOC:Local_timer_interrupts
     58026           +14.8%      66612        interrupts.CPU93.LOC:Local_timer_interrupts
     58044           +14.8%      66610        interrupts.CPU94.LOC:Local_timer_interrupts
     58046           +14.8%      66615        interrupts.CPU95.LOC:Local_timer_interrupts
     58050           +14.8%      66616        interrupts.CPU96.LOC:Local_timer_interrupts
     58071           +14.6%      66547        interrupts.CPU97.LOC:Local_timer_interrupts
     57871           +15.1%      66606        interrupts.CPU98.LOC:Local_timer_interrupts
     58066           +14.8%      66642        interrupts.CPU99.LOC:Local_timer_interrupts
  11139415           +14.8%   12784101        interrupts.LOC:Local_timer_interrupts


                                                                                
                               fsmark.files_per_sec                             
                                                                                
  250 +---------------------------------------------------------------------+   
  245 |-+                                        +              +           |   
      |    +  +   +++.    .+    .++      +     ++ +    +.    .+ :+ .++  +.  |   
  240 |++.+ :+ + +    ++++  ++++   +++.++ ++.++    ++++  ++++  +  +   ++  ++|   
  235 |-+   +   +                                                           |   
      |                                                                     |   
  230 |-+                                                                   |   
  225 |-+                                                                   |   
  220 |-+                                                                   |   
      |                                                                     |   
  215 |-+                                                                   |   
  210 |-+  OO   O      O                                                    |   
      |OO O  OO  OOOO O  O O  OO  OOOO OOOOO O O                            |   
  205 |-+               O   OO   O            O OO                          |   
  200 +---------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap1: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/ucode:
  4k/gcc-9/performance/1SSD/btrfs/sync/x86_64-rhel-8.3/8/debian-10.4-x86_64-20200603.cgz/300s/write/lkp-csl-2ap1/256g/fio-basic/0x4003003

commit: 
  5b964115b5 ("btrfs: rework btrfs_calc_reclaim_metadata_size")
  53c5e5a1d8 ("btrfs: simplify the logic in need_preemptive_flushing")

5b964115b57bfe55 53c5e5a1d87e3341d06a00746c7 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4          100%           4:4     stderr.Events_enabled
           :4          100%           4:4     stderr.[perf_record:Captured_and_wrote#MB/tmp/lkp/perf-sched.data(#samples)]
           :4          100%           4:4     stderr.[perf_record:Woken_up#times_to_write_data]
         %stddev     %change         %stddev
             \          |                \  
      0.01            +1.1        1.12 �  8%  fio.latency_100us%
     62.86 �  3%     -62.7        0.12 �132%  fio.latency_10us%
     19.90 � 15%     -19.8        0.12 �149%  fio.latency_20us%
      0.01            -0.0        0.00        fio.latency_2us%
     16.87 � 14%     -16.9        0.01        fio.latency_4us%
      0.03 �  2%      -0.0        0.00        fio.latency_50ms%
      0.33 � 13%     +98.3       98.64        fio.latency_50us%
    127.41          +137.0%     301.96        fio.time.elapsed_time
    127.41          +137.0%     301.96        fio.time.elapsed_time.max
 5.369e+08            -4.1%  5.151e+08        fio.time.file_system_outputs
      1594 �  6%    +293.4%       6274 �  3%  fio.time.involuntary_context_switches
    420.75 �  3%     +89.9%     799.00        fio.time.percent_of_cpu_this_job_got
    480.22 �  4%    +390.9%       2357        fio.time.system_time
     36993           -13.3%      32063        fio.time.voluntary_context_switches
  67108864            -4.1%   64389238        fio.workload
      2090           -59.9%     838.40        fio.write_bw_MBps
     11616 �  3%    +263.6%      42240        fio.write_clat_90%_us
     13248 �  3%    +239.1%      44928        fio.write_clat_95%_us
     17408 �  2%    +189.7%      50432        fio.write_clat_99%_us
     14517          +154.7%      36975        fio.write_clat_mean_us
    388357           -98.6%       5502 �  9%  fio.write_clat_stddev
    535275           -59.9%     214629        fio.write_iops
  39055446 � 26%     +79.5%   70092416 � 32%  cpuidle.C1E.usage
    248292 �  3%     +40.8%     349605 � 19%  cpuidle.POLL.usage
      2.26 �  2%     -92.8%       0.16 �  3%  iostat.cpu.iowait
      3.70 �  2%     +39.6%       5.16        iostat.cpu.system
    176.92           +99.6%     353.08        uptime.boot
     31486          +102.3%      63696        uptime.idle
      2.29 �  2%      -2.1        0.16 �  3%  mpstat.cpu.all.iowait%
      1.12 �  2%      -0.3        0.84 �  8%  mpstat.cpu.all.irq%
      0.09 �  3%      -0.0        0.07        mpstat.cpu.all.soft%
      2.53 �  3%      +1.7        4.27        mpstat.cpu.all.sys%
      0.28            -0.2        0.13 �  2%  mpstat.cpu.all.usr%
     93.00            +1.1%      94.00        vmstat.cpu.id
   1837418           -57.0%     789462 �  2%  vmstat.io.bo
 1.293e+08           -10.7%  1.155e+08 �  3%  vmstat.memory.cache
  65719106           +22.0%   80155172 �  5%  vmstat.memory.free
      4.25 � 10%    -100.0%       0.00        vmstat.procs.b
      5.50 �  9%     +50.0%       8.25 �  5%  vmstat.procs.r
     50381 �  2%     -73.0%      13588        vmstat.system.cs
   8058918 � 89%    +181.2%   22659297 �  5%  numa-numastat.node0.local_node
   8122514 � 88%    +179.8%   22724178 �  5%  numa-numastat.node0.numa_hit
   8081647 � 67%     -99.7%      23653 �173%  numa-numastat.node0.numa_miss
   8145258 � 67%     -98.9%      88543 � 72%  numa-numastat.node0.other_node
   6489935 � 95%     -96.4%     232918 � 76%  numa-numastat.node1.numa_foreign
  12996328 � 70%    -100.0%       0.00        numa-numastat.node2.numa_foreign
   6677566 � 15%     +71.1%   11424129 � 28%  numa-numastat.node3.local_node
   3818447 � 87%     -97.1%     108841 �173%  numa-numastat.node3.numa_foreign
   6737072 � 15%     +70.6%   11495370 � 28%  numa-numastat.node3.numa_hit
  10218977 � 29%    -100.0%       0.00        numa-numastat.node3.numa_miss
  10278486 � 29%     -99.3%      71246 � 21%  numa-numastat.node3.other_node
    117151           +62.7%     190593 �  4%  meminfo.Active
      5415         +1142.0%      67255 �  8%  meminfo.Active(anon)
    133307 �  2%     +32.2%     176190        meminfo.AnonHugePages
 1.284e+08           -10.5%  1.149e+08 �  3%  meminfo.Cached
    133470 � 17%     +31.5%     175470 � 10%  meminfo.CmaFree
 1.276e+08           -10.6%   1.14e+08 �  3%  meminfo.Inactive
 1.261e+08           -10.7%  1.126e+08 �  3%  meminfo.Inactive(file)
  66215274           +21.3%   80314069 �  5%  meminfo.MemFree
 1.315e+08           -10.7%  1.174e+08 �  3%  meminfo.Memused
    309160           -11.6%     273349        meminfo.SUnreclaim
    722723            -8.7%     659694        meminfo.Slab
  19767477 �  2%     -86.3%    2702733 �  4%  meminfo.Writeback
   1522111           -59.9%     610959 �  3%  meminfo.max_used_kB
      6716 � 51%    +593.0%      46543 � 17%  numa-meminfo.node0.Active
      4579 � 93%    +880.8%      44916 � 18%  numa-meminfo.node0.Active(file)
   2632191 � 17%     +39.0%    3658947 �  9%  numa-meminfo.node0.Dirty
  29868469 � 23%     +30.9%   39092332 �  4%  numa-meminfo.node0.FilePages
  29706221 � 23%     +30.8%   38862897 �  4%  numa-meminfo.node0.Inactive
  29324351 � 25%     +31.3%   38502867 �  3%  numa-meminfo.node0.Inactive(file)
  18493244 � 37%     -49.2%    9395979 � 19%  numa-meminfo.node0.MemFree
  30661618 � 22%     +29.7%   39758883 �  4%  numa-meminfo.node0.MemUsed
   4820384 � 13%     -80.9%     922511 � 11%  numa-meminfo.node0.Writeback
      7716 �  7%     -11.8%       6808 �  8%  numa-meminfo.node1.KernelStack
   4733390 � 14%     -84.5%     733265 � 12%  numa-meminfo.node1.Writeback
   3085152 �  8%     -28.5%    2205686 � 23%  numa-meminfo.node2.Dirty
  36156759 �  9%     -28.6%   25803094 � 19%  numa-meminfo.node2.FilePages
  35933307 �  9%     -28.7%   25615675 � 19%  numa-meminfo.node2.Inactive
  35585652 �  9%     -29.9%   24928486 � 21%  numa-meminfo.node2.Inactive(file)
  12572134 � 28%     +83.4%   23052389 � 21%  numa-meminfo.node2.MemFree
  36962324 �  9%     -28.4%   26482069 � 19%  numa-meminfo.node2.MemUsed
   5324212 �  4%     -89.0%     584306 � 26%  numa-meminfo.node2.Writeback
    945.50 � 92%   +6446.5%      61897 �  8%  numa-meminfo.node3.Active(anon)
   2861051 � 10%     -37.8%    1778186 � 30%  numa-meminfo.node3.Dirty
  32510001 � 15%     -34.6%   21269226 � 26%  numa-meminfo.node3.FilePages
  32349393 � 16%     -35.0%   21023730 � 27%  numa-meminfo.node3.Inactive
  31940087 � 15%     -35.3%   20657807 � 28%  numa-meminfo.node3.Inactive(file)
  16148531 � 32%     +71.1%   27626525 � 20%  numa-meminfo.node3.MemFree
  33343003 � 15%     -34.4%   21865009 � 26%  numa-meminfo.node3.MemUsed
   4867117 � 12%     -90.6%     457350 � 27%  numa-meminfo.node3.Writeback
      1272 �  2%     -52.9%     598.75 �  4%  slabinfo.biovec-max.active_objs
      1361           -49.1%     693.50 �  3%  slabinfo.biovec-max.num_objs
      8179            +9.3%       8943 �  3%  slabinfo.btrfs_extent_buffer.num_objs
      1605 �  4%      +6.6%       1712 �  5%  slabinfo.btrfs_ordered_extent.active_objs
      1605 �  4%      +6.6%       1712 �  5%  slabinfo.btrfs_ordered_extent.num_objs
      2117 �  5%     +23.1%       2607 �  3%  slabinfo.buffer_head.active_objs
      2157 �  5%     +20.9%       2608 �  3%  slabinfo.buffer_head.num_objs
      5316 � 11%    +103.5%      10821 �  7%  slabinfo.dmaengine-unmap-16.active_objs
    127.50 � 10%    +103.3%     259.25 �  7%  slabinfo.dmaengine-unmap-16.active_slabs
      5385 � 10%    +102.5%      10906 �  7%  slabinfo.dmaengine-unmap-16.num_objs
    127.50 � 10%    +103.3%     259.25 �  7%  slabinfo.dmaengine-unmap-16.num_slabs
      8840 � 11%     +22.0%      10780 �  8%  slabinfo.fsnotify_mark_connector.active_objs
      8929 � 11%     +21.7%      10865 �  7%  slabinfo.fsnotify_mark_connector.num_objs
      5642 �  3%      -7.6%       5214 �  2%  slabinfo.kmalloc-rcl-64.active_objs
      5642 �  3%      -7.6%       5214 �  2%  slabinfo.kmalloc-rcl-64.num_objs
      2207 �  3%     -21.4%       1735 �  3%  slabinfo.mnt_cache.active_objs
      2291 �  2%     -20.2%       1828 �  3%  slabinfo.mnt_cache.num_objs
    983.00 � 11%     +14.4%       1124 �  5%  slabinfo.proc_inode_cache.active_slabs
     11805 � 11%     +14.4%      13504 �  5%  slabinfo.proc_inode_cache.num_objs
    983.00 � 11%     +14.4%       1124 �  5%  slabinfo.proc_inode_cache.num_slabs
    588271            -9.0%     535256 �  2%  slabinfo.radix_tree_node.active_objs
     42019            -9.0%      38232 �  2%  slabinfo.radix_tree_node.active_slabs
    588272            -9.0%     535256 �  2%  slabinfo.radix_tree_node.num_objs
     42019            -9.0%      38232 �  2%  slabinfo.radix_tree_node.num_slabs
      3437 �  3%     +16.0%       3986        slabinfo.trace_event_file.active_objs
      3444 �  3%     +16.1%       3999        slabinfo.trace_event_file.num_objs
     21837           +25.3%      27365        slabinfo.vmap_area.active_objs
     21863           +25.4%      27407        slabinfo.vmap_area.num_objs
    676874 � 43%    +122.4%    1505328 � 39%  proc-vmstat.compact_free_scanned
    661.00 � 10%     +83.2%       1211 � 26%  proc-vmstat.kswapd_high_wmark_hit_quickly
    216.50 � 55%    +880.4%       2122 � 65%  proc-vmstat.kswapd_low_wmark_hit_quickly
      1352         +1138.6%      16751 �  8%  proc-vmstat.nr_active_anon
     27860           +10.5%      30795 �  2%  proc-vmstat.nr_active_file
  67188751            -4.1%   64460748        proc-vmstat.nr_dirtied
   2830874 �  2%      -8.6%    2588405        proc-vmstat.nr_dirty
  32053250           -10.4%   28710117 �  3%  proc-vmstat.nr_file_pages
     33479 � 17%     +31.1%      43876 � 10%  proc-vmstat.nr_free_cma
  16593949           +21.1%   20098175 �  5%  proc-vmstat.nr_free_pages
  31485171           -10.7%   28118905 �  3%  proc-vmstat.nr_inactive_file
    283883            +1.6%     288335        proc-vmstat.nr_mapped
    279467            +7.2%     299680        proc-vmstat.nr_shmem
    103212            -6.5%      96498        proc-vmstat.nr_slab_reclaimable
     77257           -11.5%      68335        proc-vmstat.nr_slab_unreclaimable
   4936950 �  2%     -86.4%     673846 �  4%  proc-vmstat.nr_writeback
      1352         +1138.6%      16751 �  8%  proc-vmstat.nr_zone_active_anon
     27873           +10.5%      30800 �  2%  proc-vmstat.nr_zone_active_file
  31485279           -10.7%   28118952 �  3%  proc-vmstat.nr_zone_inactive_file
   7768354           -58.0%    3262485        proc-vmstat.nr_zone_write_pending
  29916365 �  9%     -70.7%    8750752 � 50%  proc-vmstat.numa_foreign
  38401814 �  7%     +49.2%   57291640 �  6%  proc-vmstat.numa_hit
  38140485 �  7%     +49.5%   57031158 �  6%  proc-vmstat.numa_local
  29916365 �  9%     -70.7%    8750752 � 50%  proc-vmstat.numa_miss
  30177694 �  9%     -70.1%    9011234 � 48%  proc-vmstat.numa_other
    955.00 � 16%    +269.9%       3532 � 33%  proc-vmstat.pageoutrun
     13359          +322.7%      56468 �  8%  proc-vmstat.pgactivate
  68321287            -3.5%   65940158        proc-vmstat.pgalloc_normal
   1085032           +61.4%    1750813        proc-vmstat.pgfault
     28022          +131.2%      64789        proc-vmstat.pgreuse
     27637 � 82%    +244.0%      95087 � 21%  sched_debug.cfs_rq:/.load.avg
    628606 � 13%     +36.0%     854981        sched_debug.cfs_rq:/.load.max
    107249 � 45%    +124.2%     240458 � 10%  sched_debug.cfs_rq:/.load.stddev
     86480 �  7%     +19.2%     103104 �  5%  sched_debug.cfs_rq:/.min_vruntime.avg
    113366 �  2%     +78.5%     202336 �  3%  sched_debug.cfs_rq:/.min_vruntime.max
      7058 �  7%    +232.3%      23457 � 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.05 � 42%    +109.5%       0.11 � 19%  sched_debug.cfs_rq:/.nr_running.avg
      0.21 � 20%     +38.2%       0.28 �  7%  sched_debug.cfs_rq:/.nr_running.stddev
     79.54 �  7%     +41.7%     112.71 � 16%  sched_debug.cfs_rq:/.runnable_avg.avg
    834.79 �  3%     +22.7%       1024        sched_debug.cfs_rq:/.runnable_avg.max
    160.25 �  4%     +69.1%     270.95 �  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
     36862 � 34%    +197.7%     109730 �  9%  sched_debug.cfs_rq:/.spread0.max
      7074 �  7%    +231.6%      23457 � 11%  sched_debug.cfs_rq:/.spread0.stddev
     79.49 �  7%     +41.7%     112.67 � 16%  sched_debug.cfs_rq:/.util_avg.avg
    834.58 �  4%     +22.7%       1024        sched_debug.cfs_rq:/.util_avg.max
    160.21 �  4%     +69.1%     270.90 �  8%  sched_debug.cfs_rq:/.util_avg.stddev
     13.27 � 53%    +520.7%      82.36 � 23%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    682.00 � 11%     +50.3%       1025        sched_debug.cfs_rq:/.util_est_enqueued.max
     74.42 � 17%    +225.1%     241.91 � 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   2970391 � 34%     -52.6%    1408456 �  6%  sched_debug.cpu.avg_idle.max
     35686 � 14%    +188.3%     102883 � 26%  sched_debug.cpu.avg_idle.min
    282434 � 23%     -50.1%     140876 �  6%  sched_debug.cpu.avg_idle.stddev
     93684 � 14%     +90.0%     178021 �  6%  sched_debug.cpu.clock.avg
     93701 � 14%     +90.0%     178034 �  6%  sched_debug.cpu.clock.max
     93667 � 14%     +90.0%     178007 �  6%  sched_debug.cpu.clock.min
      9.76 �  6%     -23.1%       7.50 �  5%  sched_debug.cpu.clock.stddev
     93008 � 14%     +90.1%     176795 �  6%  sched_debug.cpu.clock_task.avg
     93308 � 14%     +89.8%     177069 �  6%  sched_debug.cpu.clock_task.max
     84353 � 16%    +100.2%     168853 �  7%  sched_debug.cpu.clock_task.min
    121.07 � 24%     +79.9%     217.78 �  2%  sched_debug.cpu.curr->pid.avg
      5219 �  9%     +49.6%       7806 �  5%  sched_debug.cpu.curr->pid.max
    674.76 � 12%     +45.6%     982.71 �  2%  sched_debug.cpu.curr->pid.stddev
   1485195 � 34%     -52.2%     710548 �  8%  sched_debug.cpu.max_idle_balance_cost.max
     89431 � 54%     -70.3%      26578 � 21%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.03 � 25%     +53.8%       0.05 �  3%  sched_debug.cpu.nr_running.avg
      0.18 � 13%     +26.8%       0.22        sched_debug.cpu.nr_running.stddev
    824.12 � 13%     +36.8%       1126 � 12%  sched_debug.cpu.nr_switches.min
      0.02 � 22%     -88.0%       0.00 � 25%  sched_debug.cpu.nr_uninterruptible.avg
     93667 � 14%     +90.0%     178008 �  6%  sched_debug.cpu_clk
     92796 � 14%     +90.9%     177135 �  6%  sched_debug.ktime
     94042 � 14%     +89.7%     178380 �  6%  sched_debug.sched_clk
      1145 � 92%    +880.4%      11230 � 18%  numa-vmstat.node0.nr_active_file
   8172691 � 31%     +55.7%   12720947 �  9%  numa-vmstat.node0.nr_dirtied
    655987 � 17%     +39.5%     914941 �  9%  numa-vmstat.node0.nr_dirty
   7465216 � 23%     +30.9%    9772897 �  4%  numa-vmstat.node0.nr_file_pages
   4625156 � 37%     -49.2%    2349212 � 19%  numa-vmstat.node0.nr_free_pages
   7328653 � 25%     +31.3%    9625646 �  3%  numa-vmstat.node0.nr_inactive_file
   1206608 � 13%     -80.9%     230245 � 10%  numa-vmstat.node0.nr_writeback
   6309984 � 36%     +83.5%   11575697 �  9%  numa-vmstat.node0.nr_written
      1148 � 92%    +878.0%      11232 � 18%  numa-vmstat.node0.nr_zone_active_file
   7328667 � 25%     +31.3%    9625676 �  3%  numa-vmstat.node0.nr_zone_inactive_file
   1862745 � 14%     -38.5%    1145274 �  9%  numa-vmstat.node0.nr_zone_write_pending
   4611857 � 95%    +192.1%   13471453 �  8%  numa-vmstat.node0.numa_hit
   4514907 � 97%    +196.2%   13371363 �  8%  numa-vmstat.node0.numa_local
   4280076 � 69%    -100.0%       1088 �173%  numa-vmstat.node0.numa_miss
   4377034 � 68%     -97.7%     101182 � 60%  numa-vmstat.node0.numa_other
      7710 �  7%     -11.8%       6799 �  9%  numa-vmstat.node1.nr_kernel_stack
   1184420 � 14%     -84.5%     183552 � 12%  numa-vmstat.node1.nr_writeback
   1870949 � 14%     -54.0%     861047 �  8%  numa-vmstat.node1.nr_zone_write_pending
   3181676 �125%     -97.3%      84818 �125%  numa-vmstat.node1.numa_foreign
  10400753 � 13%     -37.3%    6523007 � 23%  numa-vmstat.node2.nr_dirtied
    769495 �  8%     -28.3%     551406 � 23%  numa-vmstat.node2.nr_dirty
   9042967 �  9%     -28.7%    6451632 � 19%  numa-vmstat.node2.nr_file_pages
   3139286 � 27%     +83.6%    5762258 � 22%  numa-vmstat.node2.nr_free_pages
   8899645 �  9%     -30.0%    6232951 � 21%  numa-vmstat.node2.nr_inactive_file
   1332398 �  4%     -89.0%     146368 � 26%  numa-vmstat.node2.nr_writeback
   8899674 �  9%     -30.0%    6232954 � 21%  numa-vmstat.node2.nr_zone_inactive_file
   2102021 �  5%     -66.8%     697822 � 24%  numa-vmstat.node2.nr_zone_write_pending
   7084511 � 73%    -100.0%       0.00        numa-vmstat.node2.numa_foreign
    236.25 � 92%   +6461.2%      15500 �  8%  numa-vmstat.node3.nr_active_anon
   8919994 � 20%     -40.8%    5283319 � 31%  numa-vmstat.node3.nr_dirtied
    715123 � 10%     -37.8%     444600 � 30%  numa-vmstat.node3.nr_dirty
   8132346 � 15%     -34.6%    5317735 � 26%  numa-vmstat.node3.nr_file_pages
     33475 � 17%     +31.0%      43866 � 10%  numa-vmstat.node3.nr_free_cma
   4032260 � 32%     +71.3%    6906250 � 20%  numa-vmstat.node3.nr_free_pages
   7990046 � 15%     -35.4%    5165114 � 28%  numa-vmstat.node3.nr_inactive_file
   1215444 � 12%     -90.6%     114335 � 27%  numa-vmstat.node3.nr_writeback
    236.25 � 92%   +6461.2%      15500 �  8%  numa-vmstat.node3.nr_zone_active_anon
   7990067 � 15%     -35.4%    5165114 � 28%  numa-vmstat.node3.nr_zone_inactive_file
   1930722 � 10%     -71.0%     558966 � 29%  numa-vmstat.node3.nr_zone_write_pending
   1901104 � 90%     -99.7%       5165 �173%  numa-vmstat.node3.numa_foreign
   4150742 � 14%     +45.5%    6039465 � 26%  numa-vmstat.node3.numa_hit
   4016578 � 15%     +46.4%    5878550 � 27%  numa-vmstat.node3.numa_local
   5594513 � 41%    -100.0%       0.00        numa-vmstat.node3.numa_miss
   5728682 � 40%     -97.2%     160916 �  8%  numa-vmstat.node3.numa_other
     11.78 �  3%     -40.4%       7.02 �  6%  perf-stat.i.MPKI
 2.286e+09            -4.8%  2.177e+09        perf-stat.i.branch-instructions
      0.65            -0.2        0.49        perf-stat.i.branch-miss-rate%
  15863136 �  2%     -30.8%   10985192 �  2%  perf-stat.i.branch-misses
  87495643 �  4%     -47.7%   45751362 �  7%  perf-stat.i.cache-misses
 1.392e+08 �  3%     -45.8%   75512046 �  7%  perf-stat.i.cache-references
     51205 �  2%     -73.5%      13590        perf-stat.i.context-switches
      2.65           +64.0%       4.34        perf-stat.i.cpi
 3.067e+10 �  2%     +43.6%  4.404e+10        perf-stat.i.cpu-cycles
    455.07 �  5%    +169.3%       1225 �  9%  perf-stat.i.cycles-between-cache-misses
    273457 � 65%     -67.1%      89970 � 17%  perf-stat.i.dTLB-load-misses
 3.329e+09           -22.9%  2.566e+09        perf-stat.i.dTLB-loads
     64168 � 37%     -52.7%      30346 �  7%  perf-stat.i.dTLB-store-misses
 1.672e+09           -41.6%  9.756e+08        perf-stat.i.dTLB-stores
     61.66 �  2%      -8.9       52.72        perf-stat.i.iTLB-load-miss-rate%
   7608055 �  6%     -29.7%    5350529        perf-stat.i.iTLB-load-misses
   4712088            +1.8%    4794810        perf-stat.i.iTLB-loads
 1.164e+10           -10.9%  1.036e+10        perf-stat.i.instructions
      1532 �  6%     +26.0%       1931        perf-stat.i.instructions-per-iTLB-miss
      0.39           -39.4%       0.24        perf-stat.i.ipc
      2212           -57.9%     930.49        perf-stat.i.major-faults
      0.16 �  2%     +44.1%       0.23        perf-stat.i.metric.GHz
      0.83 � 18%     -38.0%       0.52 � 16%  perf-stat.i.metric.K/sec
     38.83           -22.1%      30.26        perf-stat.i.metric.M/sec
      3836            -0.9%       3801        perf-stat.i.minor-faults
  13804926 �  4%     -40.0%    8289551 �  3%  perf-stat.i.node-load-misses
   1907846 �  9%     -44.5%    1058077 �  7%  perf-stat.i.node-loads
   4552731 �  6%     -34.0%    3003065 �  4%  perf-stat.i.node-store-misses
    287448 � 48%     -42.0%     166584 � 14%  perf-stat.i.node-stores
      6049           -21.8%       4731        perf-stat.i.page-faults
     11.96 �  3%     -39.1%       7.28 �  6%  perf-stat.overall.MPKI
      0.70            -0.2        0.51        perf-stat.overall.branch-miss-rate%
      2.63           +61.4%       4.25        perf-stat.overall.cpi
    351.94 �  5%    +174.9%     967.33 �  7%  perf-stat.overall.cycles-between-cache-misses
     61.70 �  2%      -9.0       52.74        perf-stat.overall.iTLB-load-miss-rate%
      1537 �  6%     +26.1%       1937        perf-stat.overall.instructions-per-iTLB-miss
      0.38           -38.0%       0.24        perf-stat.overall.ipc
     22102          +119.7%      48551        perf-stat.overall.path-length
 2.268e+09            -4.4%   2.17e+09        perf-stat.ps.branch-instructions
  15776375 �  2%     -30.4%   10975709 �  2%  perf-stat.ps.branch-misses
  86567030 �  4%     -47.3%   45589562 �  7%  perf-stat.ps.cache-misses
 1.381e+08 �  3%     -45.5%   75270910 �  7%  perf-stat.ps.cache-references
     50561 �  2%     -73.2%      13544        perf-stat.ps.context-switches
  3.04e+10 �  2%     +44.3%  4.387e+10        perf-stat.ps.cpu-cycles
 3.302e+09           -22.6%  2.557e+09        perf-stat.ps.dTLB-loads
     63958 � 37%     -52.3%      30512 �  7%  perf-stat.ps.dTLB-store-misses
 1.658e+09           -41.4%  9.723e+08        perf-stat.ps.dTLB-stores
   7542975 �  6%     -29.3%    5331814        perf-stat.ps.iTLB-load-misses
   4669996            +2.3%    4777284        perf-stat.ps.iTLB-loads
 1.155e+10           -10.6%  1.033e+10        perf-stat.ps.instructions
      2191           -57.5%     931.32        perf-stat.ps.major-faults
  13652567 �  4%     -39.5%    8255968 �  3%  perf-stat.ps.node-load-misses
   1887494 �  9%     -44.1%    1054935 �  7%  perf-stat.ps.node-loads
   4506248 �  6%     -33.7%    2989856 �  4%  perf-stat.ps.node-store-misses
    286096 � 48%     -41.9%     166311 � 14%  perf-stat.ps.node-stores
      6008           -21.4%       4723        perf-stat.ps.page-faults
 1.483e+12          +110.8%  3.126e+12        perf-stat.total.instructions
      0.01 � 53%     -87.5%       0.00 �173%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00 � 23%     -66.7%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5.36 � 62%     -99.9%       0.01 � 10%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.07 � 39%     -91.8%       0.01 � 26%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.11 � 33%     -85.0%       0.02 � 22%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.01 � 17%    +162.1%       0.02 � 12%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.05 � 54%     -87.5%       0.01 � 28%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      1.42 � 60%    +230.1%       4.68 � 19%  perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.06 � 17%     -73.2%       0.02 � 11%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 �173%   +2066.7%       0.02 � 15%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
     22.77 � 59%     -99.9%       0.01 � 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 �173%   +1150.0%       0.01 � 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     20.53 � 34%     -85.8%       2.90 � 83%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      2.30          +197.5%       6.84 � 10%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.02 � 27%     -81.2%       0.00        perf-sched.total_sch_delay.average.ms
     27.75 � 20%     -74.1%       7.19 � 16%  perf-sched.total_sch_delay.max.ms
      0.32 � 18%   +7823.9%      25.73 � 13%  perf-sched.total_wait_and_delay.average.ms
      3635 �  4%   +2913.9%     109554 � 17%  perf-sched.total_wait_and_delay.count.ms
    158.86 �  5%   +5057.9%       8194 �  6%  perf-sched.total_wait_and_delay.max.ms
      0.31 � 19%   +8233.6%      25.73 � 13%  perf-sched.total_wait_time.average.ms
    158.85 �  5%   +5058.2%       8194 �  6%  perf-sched.total_wait_time.max.ms
      0.51 �173%  +44191.4%     226.99 �  2%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    158.86 �  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.07 �  2%     +45.3%       0.10 � 19%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.04 �  6%  +1.2e+05%      46.19        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.02 � 14%  +21001.2%       4.38        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
      6.88 � 59%   +8627.8%     600.56 � 56%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.86 �  5%     +13.4%       4.38        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1.25 � 26%  +60259.2%     756.75        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      7.66 � 11%   +2755.3%     218.84 � 10%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      1.50 �173%  +20216.7%     304.75        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.00          -100.0%       0.00        perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2255 �  2%   +4082.4%      94312 � 19%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    660.75 � 17%    +428.1%       3489        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
    312.50 � 17%    +575.9%       2112        perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
      3.25 � 59%    +376.9%      15.50 � 65%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     41.00 �  3%   +5462.8%       2280        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    314.75 � 17%    +694.1%       2499        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     29.50 � 56%   +7337.3%       2194 �  9%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      2.83 �173%  +1.3e+05%       3654 � 31%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    158.86 �  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      3.27 � 46%  +27193.5%     892.91 � 76%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.11 � 29%  +9.2e+05%       1018        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5.50 �  3%  +18112.0%       1000        perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
     22.75 � 59%  +28414.4%       6485 � 53%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     51.79 �114%   +3718.9%       1977 � 32%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     75.64 � 19%   +8319.0%       6368 � 16%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.53 �166%  +42910.9%     226.99 �  2%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    158.85 �  5%     -99.9%       0.13 �173%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.07 �  2%     +48.9%       0.10 � 20%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.04 �  8%  +1.3e+05%      46.19        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.02 � 14%  +21001.2%       4.38        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
      1.57 � 88%  +38243.4%     600.55 � 56%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.85 �  5%     +13.5%       4.37        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1.18 � 28%  +63976.9%     756.75        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      7.55 � 12%   +2796.8%     218.82 � 10%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      2.90 �167%  +1.3e+05%       3654 � 31%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    158.85 �  5%     -99.7%       0.46 �173%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2.79 � 57%  +31839.1%     892.54 � 76%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.11 � 32%  +9.6e+05%       1018        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5.50 �  3%  +18111.8%       1000        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
      6.38 � 88%    +1e+05%       6485 � 53%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     42.79 �150%   +4522.0%       1977 � 32%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     75.61 � 19%   +8322.7%       6368 � 16%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     23273 �  5%     +79.4%      41758 �  8%  softirqs.CPU0.SCHED
     19224 �  3%    +102.6%      38950        softirqs.CPU1.SCHED
     17936 �  3%    +117.1%      38939 �  3%  softirqs.CPU10.SCHED
     17462 �  4%    +113.1%      37218 �  6%  softirqs.CPU100.SCHED
      9336 � 24%     -56.9%       4027 �  3%  softirqs.CPU101.RCU
     16134 � 17%    +114.7%      34644 � 19%  softirqs.CPU102.SCHED
     18025 �  2%     +89.8%      34220 � 19%  softirqs.CPU103.SCHED
     17976 �  3%    +114.2%      38508        softirqs.CPU104.SCHED
     17940 �  3%    +110.4%      37752 �  3%  softirqs.CPU105.SCHED
     17976 �  3%    +112.8%      38259        softirqs.CPU106.SCHED
     17892 �  5%    +105.6%      36785 �  5%  softirqs.CPU107.SCHED
     17998 �  3%     +93.0%      34732 � 18%  softirqs.CPU108.SCHED
     17812 �  4%    +104.9%      36492 �  5%  softirqs.CPU109.SCHED
    509.25 �129%   +2290.8%      12175 � 77%  softirqs.CPU11.NET_RX
     17542 �  3%     +97.5%      34636 � 19%  softirqs.CPU11.SCHED
     17930 �  3%    +107.5%      37206 �  4%  softirqs.CPU110.SCHED
     16041 � 15%    +131.7%      37174 �  7%  softirqs.CPU111.SCHED
     17512 �  7%     +85.2%      32425 � 19%  softirqs.CPU112.SCHED
     17732 �  4%    +101.9%      35800 � 14%  softirqs.CPU113.SCHED
     17731 �  5%     +99.1%      35301 � 17%  softirqs.CPU114.SCHED
     18034 �  2%     +73.3%      31260 � 22%  softirqs.CPU115.SCHED
     18000 �  2%     +71.9%      30947 � 23%  softirqs.CPU116.SCHED
     18037 �  2%     +71.8%      30995 � 25%  softirqs.CPU117.SCHED
     17819 �  4%    +115.9%      38469        softirqs.CPU118.SCHED
     18069 �  2%    +106.0%      37229 �  5%  softirqs.CPU119.SCHED
     16670 �  4%     +63.4%      27233 � 16%  softirqs.CPU120.SCHED
     17658 �  3%    +101.2%      35533 � 16%  softirqs.CPU122.SCHED
     16398 � 16%    +136.4%      38771        softirqs.CPU123.SCHED
     17833 �  3%    +117.8%      38834        softirqs.CPU124.SCHED
     17981 �  2%    +116.6%      38948        softirqs.CPU125.SCHED
     17859 �  2%    +134.7%      41917 � 12%  softirqs.CPU126.SCHED
     17735 �  3%    +115.3%      38177        softirqs.CPU127.SCHED
     17671 �  3%    +117.7%      38463        softirqs.CPU128.SCHED
     17888 �  2%     +89.5%      33904 � 19%  softirqs.CPU129.SCHED
     17864 �  2%    +115.3%      38462        softirqs.CPU130.SCHED
     17937 �  2%    +116.3%      38796        softirqs.CPU131.SCHED
     17823 �  2%    +116.6%      38613        softirqs.CPU132.SCHED
     17817 �  2%    +115.6%      38423        softirqs.CPU133.SCHED
     17467 �  6%    +120.5%      38521        softirqs.CPU134.SCHED
     17443 �  5%     +90.5%      33227 � 20%  softirqs.CPU135.SCHED
     17409 �  5%    +119.3%      38180        softirqs.CPU136.SCHED
     17427 �  6%    +122.5%      38779        softirqs.CPU137.SCHED
     17994          +115.9%      38853        softirqs.CPU138.SCHED
     18000 �  2%    +112.9%      38319        softirqs.CPU139.SCHED
     17685 �  3%     +96.7%      34793 � 20%  softirqs.CPU140.SCHED
     17559 �  4%    +120.8%      38767        softirqs.CPU141.SCHED
     17880 �  2%    +117.1%      38810        softirqs.CPU142.SCHED
     18018 �  2%    +114.8%      38700        softirqs.CPU143.SCHED
     15816 � 13%     +52.0%      24042 � 16%  softirqs.CPU144.SCHED
     17373 �  4%    +120.4%      38293        softirqs.CPU145.SCHED
     17900          +117.5%      38927        softirqs.CPU146.SCHED
     15928 � 18%    +145.0%      39017        softirqs.CPU147.SCHED
     15242 � 18%    +154.5%      38791        softirqs.CPU148.SCHED
     17218 �  4%    +125.7%      38866        softirqs.CPU149.SCHED
     17388 �  6%    +106.6%      35926 �  9%  softirqs.CPU15.SCHED
     17972 �  2%    +115.0%      38643        softirqs.CPU150.SCHED
     16587 �  8%    +132.9%      38637        softirqs.CPU151.SCHED
     17468 �  2%    +121.6%      38703        softirqs.CPU152.SCHED
     17060 �  7%    +127.6%      38826        softirqs.CPU153.SCHED
     17641 �  2%    +119.1%      38646        softirqs.CPU154.SCHED
     17892           +78.1%      31866 � 23%  softirqs.CPU155.SCHED
     17924          +115.9%      38701        softirqs.CPU156.SCHED
     17856          +115.9%      38551        softirqs.CPU157.SCHED
     17950          +114.0%      38405        softirqs.CPU158.SCHED
     17923          +113.7%      38302        softirqs.CPU159.SCHED
     17541 �  2%     +98.6%      34837 � 20%  softirqs.CPU160.SCHED
     17833          +116.4%      38583        softirqs.CPU161.SCHED
     14192 � 29%    +173.0%      38749        softirqs.CPU162.SCHED
     17193 �  3%    +122.9%      38327        softirqs.CPU163.SCHED
     16821 �  9%    +131.5%      38948        softirqs.CPU164.SCHED
     16698 �  8%    +133.0%      38903        softirqs.CPU165.SCHED
     16020 � 12%    +138.9%      38264 �  2%  softirqs.CPU166.SCHED
     16919 �  8%    +130.1%      38934        softirqs.CPU167.SCHED
     16632 �  2%     +32.4%      22019 � 17%  softirqs.CPU168.SCHED
     17823 �  2%    +116.6%      38604 �  2%  softirqs.CPU169.SCHED
     17983          +119.0%      39386        softirqs.CPU170.SCHED
     17669          +122.6%      39324        softirqs.CPU171.SCHED
     17927          +116.3%      38781        softirqs.CPU172.SCHED
     18141          +116.2%      39216        softirqs.CPU173.SCHED
     17888          +118.6%      39099        softirqs.CPU174.SCHED
     18076          +116.9%      39214        softirqs.CPU175.SCHED
     17994          +115.3%      38746        softirqs.CPU176.SCHED
     17615 �  3%    +121.8%      39065        softirqs.CPU177.SCHED
     17871 �  2%    +119.4%      39203        softirqs.CPU178.SCHED
     16330 � 19%    +138.6%      38966        softirqs.CPU179.SCHED
     16932 � 10%     +73.9%      29442 � 31%  softirqs.CPU18.SCHED
     17972          +109.4%      37633 �  6%  softirqs.CPU180.SCHED
     17896          +114.7%      38419        softirqs.CPU181.SCHED
     18036          +116.6%      39073        softirqs.CPU182.SCHED
     17883 �  2%    +118.8%      39123        softirqs.CPU183.SCHED
      6988 � 28%     -49.0%       3563 �  6%  softirqs.CPU184.RCU
     18068          +118.3%      39452        softirqs.CPU184.SCHED
     18037          +116.9%      39131        softirqs.CPU185.SCHED
     18445 �  2%    +111.6%      39021        softirqs.CPU186.SCHED
     17861 �  2%    +119.1%      39126        softirqs.CPU187.SCHED
     18094          +116.5%      39179        softirqs.CPU188.SCHED
     18041          +116.1%      38988        softirqs.CPU189.SCHED
     17981          +118.7%      39332        softirqs.CPU190.SCHED
     18050          +115.7%      38940        softirqs.CPU191.SCHED
     17923 �  3%    +113.4%      38253        softirqs.CPU2.SCHED
     17588 �  3%     +89.1%      33267 � 24%  softirqs.CPU20.SCHED
     17894 �  2%     +88.0%      33642 � 21%  softirqs.CPU21.SCHED
     17032 � 10%    +122.3%      37859        softirqs.CPU22.SCHED
     15841 � 19%    +138.4%      37766        softirqs.CPU23.SCHED
     15987 �  4%     +38.6%      22162 � 22%  softirqs.CPU24.SCHED
     17548 �  4%     +93.9%      34034 � 19%  softirqs.CPU25.SCHED
     17581 �  3%    +111.1%      37114 �  4%  softirqs.CPU26.SCHED
     17571 �  3%    +116.2%      37995        softirqs.CPU27.SCHED
     17797 �  2%    +113.3%      37968        softirqs.CPU28.SCHED
     17877          +113.8%      38215        softirqs.CPU29.SCHED
     17757 �  2%     +95.3%      34689 � 17%  softirqs.CPU3.SCHED
     17713 �  3%     +92.0%      34004 � 20%  softirqs.CPU30.SCHED
     16785 �  6%    +126.0%      37939        softirqs.CPU31.SCHED
     17665 �  3%    +113.8%      37762        softirqs.CPU32.SCHED
     17874 �  2%    +112.8%      38032        softirqs.CPU33.SCHED
     17826 �  2%    +111.6%      37717        softirqs.CPU34.SCHED
     17848          +112.7%      37964        softirqs.CPU35.SCHED
     17898          +111.8%      37914        softirqs.CPU36.SCHED
     18035 �  2%    +109.2%      37733        softirqs.CPU37.SCHED
     17727 �  2%    +113.0%      37751        softirqs.CPU38.SCHED
     17779 �  2%    +106.8%      36770 �  5%  softirqs.CPU39.SCHED
     16919 �  6%    +123.6%      37824        softirqs.CPU4.SCHED
     17784 �  4%    +110.5%      37430        softirqs.CPU40.SCHED
     17540 �  4%    +116.5%      37977        softirqs.CPU41.SCHED
     17772 �  2%    +113.9%      38021        softirqs.CPU42.SCHED
     17473 �  4%    +114.7%      37515        softirqs.CPU43.SCHED
     17717 �  2%    +115.0%      38090        softirqs.CPU44.SCHED
     17551 �  5%    +116.2%      37950        softirqs.CPU45.SCHED
     17784          +113.6%      37995        softirqs.CPU46.SCHED
     17887 �  2%    +112.5%      38019        softirqs.CPU47.SCHED
     17224 �  2%     +97.3%      33983 � 16%  softirqs.CPU49.SCHED
     17391           +94.1%      33758 � 20%  softirqs.CPU5.SCHED
     17685          +120.2%      38937 �  3%  softirqs.CPU50.SCHED
      8016 � 27%     -46.0%       4329 �  2%  softirqs.CPU51.RCU
     17841          +113.4%      38072        softirqs.CPU51.SCHED
     17600 �  3%    +116.9%      38171        softirqs.CPU52.SCHED
     17239 �  2%    +121.2%      38137        softirqs.CPU53.SCHED
     17822          +113.4%      38030        softirqs.CPU54.SCHED
     17055 �  5%    +121.8%      37830        softirqs.CPU55.SCHED
     17653 �  2%    +115.4%      38022        softirqs.CPU56.SCHED
     17894          +112.4%      38004        softirqs.CPU57.SCHED
     17582 �  3%    +115.4%      37869        softirqs.CPU58.SCHED
     17678           +84.8%      32662 � 17%  softirqs.CPU59.SCHED
     17560 �  4%     +90.6%      33468 � 20%  softirqs.CPU6.SCHED
     17824          +112.4%      37864        softirqs.CPU60.SCHED
     17914          +115.9%      38674 �  3%  softirqs.CPU61.SCHED
     17675          +113.5%      37735        softirqs.CPU62.SCHED
     17695          +113.5%      37774        softirqs.CPU63.SCHED
     17783          +114.3%      38110        softirqs.CPU64.SCHED
     17911          +112.9%      38129        softirqs.CPU65.SCHED
     17941          +112.6%      38136        softirqs.CPU66.SCHED
     17838          +110.9%      37629        softirqs.CPU67.SCHED
     17747          +115.4%      38234        softirqs.CPU68.SCHED
     17318 �  3%    +120.1%      38109        softirqs.CPU69.SCHED
     17585          +104.6%      35981 � 10%  softirqs.CPU70.SCHED
     17432 �  2%    +117.9%      37991        softirqs.CPU71.SCHED
     14703 �  5%     +50.7%      22151 � 12%  softirqs.CPU72.SCHED
     17016 �  4%     +97.0%      33521 � 24%  softirqs.CPU73.SCHED
     17008 �  6%    +125.7%      38384        softirqs.CPU74.SCHED
     17574 �  2%    +119.6%      38600        softirqs.CPU75.SCHED
     17676 �  3%    +115.6%      38107        softirqs.CPU76.SCHED
     17819          +115.6%      38416        softirqs.CPU77.SCHED
     17807          +114.1%      38120        softirqs.CPU78.SCHED
     17659          +116.9%      38296        softirqs.CPU79.SCHED
     17796 �  2%    +113.1%      37930        softirqs.CPU8.SCHED
     15987 � 18%    +137.9%      38037        softirqs.CPU80.SCHED
     17684 �  2%    +116.2%      38237        softirqs.CPU81.SCHED
     17850          +115.5%      38466        softirqs.CPU82.SCHED
     17789          +115.0%      38252        softirqs.CPU83.SCHED
     17743          +113.3%      37843        softirqs.CPU85.SCHED
     17804          +115.6%      38388        softirqs.CPU86.SCHED
     17931          +114.2%      38416        softirqs.CPU87.SCHED
     17271 �  4%    +121.8%      38309        softirqs.CPU88.SCHED
     17798          +115.9%      38423        softirqs.CPU89.SCHED
     17862          +113.5%      38140        softirqs.CPU90.SCHED
     17849          +119.2%      39127 �  4%  softirqs.CPU91.SCHED
     17846          +115.3%      38424        softirqs.CPU92.SCHED
     17699          +116.5%      38316        softirqs.CPU93.SCHED
     17868          +115.6%      38524        softirqs.CPU94.SCHED
     18023 �  2%    +112.8%      38355        softirqs.CPU97.SCHED
     16630 � 15%    +134.1%      38934        softirqs.CPU98.SCHED
     18017 �  3%    +115.8%      38889        softirqs.CPU99.SCHED
      6591 � 56%    +299.9%      26359 � 47%  softirqs.NET_RX
   1256534 �  8%     -37.6%     783562        softirqs.RCU
   3375418          +108.0%    7022041        softirqs.SCHED
     44803 �  3%     +32.1%      59178        softirqs.TIMER
    775.00 �142%   +2464.5%      19875 � 92%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
    258.50          +134.8%     607.00        interrupts.9:IO-APIC.9-fasteoi.acpi
    257240          +135.8%     606454        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00         +2e+105%       1951 �146%  interrupts.CPU0.NMI:Non-maskable_interrupts
      0.00         +2e+105%       1951 �146%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    258.50          +134.8%     607.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    257926          +136.8%     610646        interrupts.CPU1.LOC:Local_timer_interrupts
      0.50 �100%  +64450.0%     322.75 � 32%  interrupts.CPU1.NMI:Non-maskable_interrupts
      0.50 �100%  +64450.0%     322.75 � 32%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    258039          +135.1%     606641        interrupts.CPU10.LOC:Local_timer_interrupts
    258014          +136.7%     610642        interrupts.CPU100.LOC:Local_timer_interrupts
    257987          +135.0%     606348        interrupts.CPU101.LOC:Local_timer_interrupts
    257966          +135.0%     606229        interrupts.CPU102.LOC:Local_timer_interrupts
    257652          +135.0%     605468        interrupts.CPU103.LOC:Local_timer_interrupts
    257994          +134.7%     605530        interrupts.CPU104.LOC:Local_timer_interrupts
    257551          +135.4%     606204        interrupts.CPU105.LOC:Local_timer_interrupts
    257967          +135.2%     606681        interrupts.CPU106.LOC:Local_timer_interrupts
    257986          +135.1%     606441        interrupts.CPU107.LOC:Local_timer_interrupts
    257993          +134.7%     605584        interrupts.CPU108.LOC:Local_timer_interrupts
    257977          +135.1%     606448        interrupts.CPU109.LOC:Local_timer_interrupts
    775.00 �142%   +2464.5%      19875 � 92%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
    258008          +135.1%     606672        interrupts.CPU11.LOC:Local_timer_interrupts
    257964          +135.1%     606566        interrupts.CPU110.LOC:Local_timer_interrupts
    257917          +135.0%     606175        interrupts.CPU111.LOC:Local_timer_interrupts
    257983          +135.2%     606679        interrupts.CPU112.LOC:Local_timer_interrupts
      9.00 �134%    +597.2%      62.75 � 88%  interrupts.CPU112.RES:Rescheduling_interrupts
    257969          +134.9%     606062        interrupts.CPU113.LOC:Local_timer_interrupts
      7.00 �111%    +553.6%      45.75 � 99%  interrupts.CPU113.RES:Rescheduling_interrupts
    258017          +135.0%     606228        interrupts.CPU114.LOC:Local_timer_interrupts
      7.50 �150%    +753.3%      64.00 � 76%  interrupts.CPU114.RES:Rescheduling_interrupts
    258012          +135.1%     606643        interrupts.CPU115.LOC:Local_timer_interrupts
      1.25 � 87%   +6020.0%      76.50 � 82%  interrupts.CPU115.RES:Rescheduling_interrupts
    258004          +134.9%     606081        interrupts.CPU116.LOC:Local_timer_interrupts
      1.00 �100%   +8200.0%      83.00 � 70%  interrupts.CPU116.RES:Rescheduling_interrupts
    258008          +135.1%     606547        interrupts.CPU117.LOC:Local_timer_interrupts
      1.50 �173%  +1.6e+05%       2394 �146%  interrupts.CPU117.NMI:Non-maskable_interrupts
      1.50 �173%  +1.6e+05%       2394 �146%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
      1.25 � 87%   +4300.0%      55.00 �116%  interrupts.CPU117.RES:Rescheduling_interrupts
    257990          +135.7%     608177        interrupts.CPU118.LOC:Local_timer_interrupts
    258010          +135.1%     606654        interrupts.CPU119.LOC:Local_timer_interrupts
    258067          +135.0%     606502        interrupts.CPU12.LOC:Local_timer_interrupts
    257434          +135.3%     605760        interrupts.CPU120.LOC:Local_timer_interrupts
    258027          +134.6%     605384        interrupts.CPU121.LOC:Local_timer_interrupts
    255276          +137.2%     605433        interrupts.CPU122.LOC:Local_timer_interrupts
    256928          +135.3%     604514        interrupts.CPU123.LOC:Local_timer_interrupts
    257505          +135.2%     605681        interrupts.CPU124.LOC:Local_timer_interrupts
    257792          +134.9%     605545        interrupts.CPU125.LOC:Local_timer_interrupts
    256996          +135.6%     605474        interrupts.CPU126.LOC:Local_timer_interrupts
    257022          +135.6%     605654        interrupts.CPU127.LOC:Local_timer_interrupts
    258006          +134.8%     605780        interrupts.CPU128.LOC:Local_timer_interrupts
    257568          +135.2%     605783        interrupts.CPU129.LOC:Local_timer_interrupts
    258047          +135.1%     606566        interrupts.CPU13.LOC:Local_timer_interrupts
     31.75 �165%    +392.9%     156.50 � 65%  interrupts.CPU13.RES:Rescheduling_interrupts
    257934          +134.9%     605825        interrupts.CPU130.LOC:Local_timer_interrupts
    257688          +135.1%     605785        interrupts.CPU131.LOC:Local_timer_interrupts
    257934          +134.9%     605802        interrupts.CPU132.LOC:Local_timer_interrupts
    258031          +134.8%     605766        interrupts.CPU133.LOC:Local_timer_interrupts
    257182          +135.6%     605817        interrupts.CPU134.LOC:Local_timer_interrupts
      0.50 �173%  +55750.0%     279.25 �  8%  interrupts.CPU134.NMI:Non-maskable_interrupts
      0.50 �173%  +55750.0%     279.25 �  8%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    256554          +136.0%     605423        interrupts.CPU135.LOC:Local_timer_interrupts
    256889          +135.6%     605342        interrupts.CPU136.LOC:Local_timer_interrupts
    257503          +135.2%     605773        interrupts.CPU137.LOC:Local_timer_interrupts
    257142          +135.6%     605805        interrupts.CPU138.LOC:Local_timer_interrupts
      0.25 �173%    +1e+05%     261.00 � 25%  interrupts.CPU138.NMI:Non-maskable_interrupts
      0.25 �173%    +1e+05%     261.00 � 25%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      1951 � 13%     +44.1%       2812 � 28%  interrupts.CPU139.CAL:Function_call_interrupts
    257098          +135.6%     605636        interrupts.CPU139.LOC:Local_timer_interrupts
    257999          +135.1%     606552        interrupts.CPU14.LOC:Local_timer_interrupts
    257879          +135.0%     605887        interrupts.CPU140.LOC:Local_timer_interrupts
      0.25 �173%    +1e+05%     262.50 � 25%  interrupts.CPU140.NMI:Non-maskable_interrupts
      0.25 �173%    +1e+05%     262.50 � 25%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    257988          +134.8%     605783        interrupts.CPU141.LOC:Local_timer_interrupts
      0.25 �173%  +1.8e+05%     457.75 � 59%  interrupts.CPU141.NMI:Non-maskable_interrupts
      0.25 �173%  +1.8e+05%     457.75 � 59%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    256928          +135.8%     605788        interrupts.CPU142.LOC:Local_timer_interrupts
    257551          +135.0%     605360        interrupts.CPU143.LOC:Local_timer_interrupts
    258028          +134.8%     605867        interrupts.CPU144.LOC:Local_timer_interrupts
    258006          +134.7%     605541        interrupts.CPU145.LOC:Local_timer_interrupts
    258024          +134.8%     605783        interrupts.CPU146.LOC:Local_timer_interrupts
    257614          +135.0%     605470        interrupts.CPU147.LOC:Local_timer_interrupts
    257820          +134.9%     605659        interrupts.CPU148.LOC:Local_timer_interrupts
    257485          +135.3%     605741        interrupts.CPU149.LOC:Local_timer_interrupts
    258573          +134.6%     606547        interrupts.CPU15.LOC:Local_timer_interrupts
    257711          +134.8%     605001        interrupts.CPU150.LOC:Local_timer_interrupts
    257968          +134.4%     604801        interrupts.CPU151.LOC:Local_timer_interrupts
    258008          +134.6%     605227        interrupts.CPU152.LOC:Local_timer_interrupts
    340.25 � 55%     -95.3%      16.00 � 74%  interrupts.CPU152.RES:Rescheduling_interrupts
    258013          +135.3%     607224        interrupts.CPU153.LOC:Local_timer_interrupts
    257749          +135.6%     607168        interrupts.CPU154.LOC:Local_timer_interrupts
    258017          +134.8%     605925        interrupts.CPU155.LOC:Local_timer_interrupts
      3.25 �102%   +2130.8%      72.50 � 93%  interrupts.CPU155.RES:Rescheduling_interrupts
    257962          +136.2%     609340        interrupts.CPU156.LOC:Local_timer_interrupts
    257730          +135.1%     605840        interrupts.CPU157.LOC:Local_timer_interrupts
    257296          +135.3%     605306        interrupts.CPU158.LOC:Local_timer_interrupts
    257269          +135.4%     605609        interrupts.CPU159.LOC:Local_timer_interrupts
    258025          +135.0%     606370        interrupts.CPU16.LOC:Local_timer_interrupts
      1842 �  6%     +17.6%       2166 �  6%  interrupts.CPU160.CAL:Function_call_interrupts
    257442          +135.3%     605884        interrupts.CPU160.LOC:Local_timer_interrupts
    257136          +135.6%     605841        interrupts.CPU161.LOC:Local_timer_interrupts
    257820          +135.0%     605922        interrupts.CPU162.LOC:Local_timer_interrupts
     95.25 � 80%     -89.2%      10.25 � 68%  interrupts.CPU162.RES:Rescheduling_interrupts
    257981          +134.9%     605945        interrupts.CPU163.LOC:Local_timer_interrupts
      0.50 �173%  +51000.0%     255.50 � 24%  interrupts.CPU163.NMI:Non-maskable_interrupts
      0.50 �173%  +51000.0%     255.50 � 24%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      1934 � 13%     +23.0%       2378 �  8%  interrupts.CPU164.CAL:Function_call_interrupts
    257995          +134.9%     605908        interrupts.CPU164.LOC:Local_timer_interrupts
    257989          +134.9%     605899        interrupts.CPU165.LOC:Local_timer_interrupts
    257990          +134.7%     605509        interrupts.CPU166.LOC:Local_timer_interrupts
    257814          +134.8%     605385        interrupts.CPU167.LOC:Local_timer_interrupts
    257441          +135.4%     605963        interrupts.CPU168.LOC:Local_timer_interrupts
     20.00 � 30%    +732.5%     166.50 � 29%  interrupts.CPU168.RES:Rescheduling_interrupts
    257218          +135.7%     606154        interrupts.CPU169.LOC:Local_timer_interrupts
      0.50 �173%  +1.2e+05%     597.50 � 80%  interrupts.CPU169.NMI:Non-maskable_interrupts
      0.50 �173%  +1.2e+05%     597.50 � 80%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    258040          +135.0%     606392        interrupts.CPU17.LOC:Local_timer_interrupts
    257869          +135.1%     606194        interrupts.CPU170.LOC:Local_timer_interrupts
    257719          +135.2%     606164        interrupts.CPU171.LOC:Local_timer_interrupts
      1.50 �173%  +18966.7%     286.00 � 25%  interrupts.CPU171.NMI:Non-maskable_interrupts
      1.50 �173%  +18966.7%     286.00 � 25%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    257274          +135.6%     606183        interrupts.CPU172.LOC:Local_timer_interrupts
      0.00       +3.1e+104%     306.50 � 30%  interrupts.CPU172.NMI:Non-maskable_interrupts
      0.00       +3.1e+104%     306.50 � 30%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    256796          +136.0%     606108        interrupts.CPU173.LOC:Local_timer_interrupts
      0.50 �100%  +57050.0%     285.75 � 25%  interrupts.CPU173.NMI:Non-maskable_interrupts
      0.50 �100%  +57050.0%     285.75 � 25%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    255382          +137.3%     606147        interrupts.CPU174.LOC:Local_timer_interrupts
    256716          +135.9%     605483        interrupts.CPU175.LOC:Local_timer_interrupts
      0.50 �100%  +48500.0%     243.00 � 34%  interrupts.CPU175.NMI:Non-maskable_interrupts
      0.50 �100%  +48500.0%     243.00 � 34%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    257752          +135.1%     605873        interrupts.CPU176.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     304.25 � 30%  interrupts.CPU176.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     304.25 � 30%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    257997          +135.0%     606185        interrupts.CPU177.LOC:Local_timer_interrupts
    257592          +135.2%     605961        interrupts.CPU178.LOC:Local_timer_interrupts
    257711          +135.2%     606176        interrupts.CPU179.LOC:Local_timer_interrupts
      1.50 �173%  +18883.3%     284.75 � 24%  interrupts.CPU179.NMI:Non-maskable_interrupts
      1.50 �173%  +18883.3%     284.75 � 24%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    260122 �  2%    +135.2%     611875        interrupts.CPU18.LOC:Local_timer_interrupts
    257975          +135.0%     606231        interrupts.CPU180.LOC:Local_timer_interrupts
    257985          +135.0%     606187        interrupts.CPU181.LOC:Local_timer_interrupts
      0.25 �173%    +1e+05%     261.00 � 42%  interrupts.CPU181.NMI:Non-maskable_interrupts
      0.25 �173%    +1e+05%     261.00 � 42%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
    257981          +134.9%     605957        interrupts.CPU182.LOC:Local_timer_interrupts
    258014          +134.9%     606058        interrupts.CPU183.LOC:Local_timer_interrupts
    258003          +134.9%     606132        interrupts.CPU184.LOC:Local_timer_interrupts
    257628          +135.3%     606131        interrupts.CPU185.LOC:Local_timer_interrupts
    256870          +135.9%     605987        interrupts.CPU186.LOC:Local_timer_interrupts
    257549          +135.2%     605680        interrupts.CPU187.LOC:Local_timer_interrupts
    257981          +135.0%     606175        interrupts.CPU188.LOC:Local_timer_interrupts
      1.25 �173%  +22280.0%     279.75 � 25%  interrupts.CPU188.NMI:Non-maskable_interrupts
      1.25 �173%  +22280.0%     279.75 � 25%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    257956          +135.0%     606126        interrupts.CPU189.LOC:Local_timer_interrupts
      0.75 �173%  +41700.0%     313.50 � 34%  interrupts.CPU189.NMI:Non-maskable_interrupts
      0.75 �173%  +41700.0%     313.50 � 34%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    258147          +135.2%     607115        interrupts.CPU19.LOC:Local_timer_interrupts
      1.00 �122%  +10250.0%     103.50 � 86%  interrupts.CPU19.RES:Rescheduling_interrupts
     87.75 � 47%     -63.5%      32.00 � 88%  interrupts.CPU19.TLB:TLB_shootdowns
    256298          +136.5%     606167        interrupts.CPU190.LOC:Local_timer_interrupts
    257838          +135.1%     606204        interrupts.CPU191.LOC:Local_timer_interrupts
      2.25 � 72%  +13733.3%     311.25 � 26%  interrupts.CPU191.NMI:Non-maskable_interrupts
      2.25 � 72%  +13733.3%     311.25 � 26%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    257840          +135.3%     606664        interrupts.CPU2.LOC:Local_timer_interrupts
    258010          +135.1%     606461        interrupts.CPU20.LOC:Local_timer_interrupts
     97.25 � 31%     -70.2%      29.00 �109%  interrupts.CPU20.TLB:TLB_shootdowns
    258033          +134.7%     605617        interrupts.CPU21.LOC:Local_timer_interrupts
    258053          +135.2%     607010        interrupts.CPU22.LOC:Local_timer_interrupts
    258009          +135.1%     606487        interrupts.CPU23.LOC:Local_timer_interrupts
    259088          +133.8%     605797        interrupts.CPU24.LOC:Local_timer_interrupts
     29.00 � 42%    +427.6%     153.00 � 32%  interrupts.CPU24.RES:Rescheduling_interrupts
    258265          +134.6%     605784        interrupts.CPU25.LOC:Local_timer_interrupts
    258019          +134.8%     605798        interrupts.CPU26.LOC:Local_timer_interrupts
    258509          +134.3%     605788        interrupts.CPU27.LOC:Local_timer_interrupts
      0.25 �173%  +1.7e+05%     427.00 � 73%  interrupts.CPU27.NMI:Non-maskable_interrupts
      0.25 �173%  +1.7e+05%     427.00 � 73%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    258270          +134.6%     605794        interrupts.CPU28.LOC:Local_timer_interrupts
    258015          +134.8%     605812        interrupts.CPU29.LOC:Local_timer_interrupts
      0.25 �173%    +1e+05%     259.25 � 23%  interrupts.CPU29.NMI:Non-maskable_interrupts
      0.25 �173%    +1e+05%     259.25 � 23%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    258002          +135.0%     606425        interrupts.CPU3.LOC:Local_timer_interrupts
    258053          +134.8%     605796        interrupts.CPU30.LOC:Local_timer_interrupts
      0.25 �173%  +73500.0%     184.00 � 32%  interrupts.CPU30.NMI:Non-maskable_interrupts
      0.25 �173%  +73500.0%     184.00 � 32%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    258163          +134.7%     605804        interrupts.CPU31.LOC:Local_timer_interrupts
    258086          +134.7%     605795        interrupts.CPU32.LOC:Local_timer_interrupts
    258056          +134.7%     605784        interrupts.CPU33.LOC:Local_timer_interrupts
    258071          +134.7%     605817        interrupts.CPU34.LOC:Local_timer_interrupts
    258062          +134.8%     605813        interrupts.CPU35.LOC:Local_timer_interrupts
    258033          +134.8%     605820        interrupts.CPU36.LOC:Local_timer_interrupts
    258047          +134.8%     605794        interrupts.CPU37.LOC:Local_timer_interrupts
    258035          +134.8%     605828        interrupts.CPU38.LOC:Local_timer_interrupts
      0.25 �173%  +1.8e+05%     443.25 � 57%  interrupts.CPU38.NMI:Non-maskable_interrupts
      0.25 �173%  +1.8e+05%     443.25 � 57%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    258037          +134.8%     605808        interrupts.CPU39.LOC:Local_timer_interrupts
      0.25 �173%  +1.8e+05%     448.50 � 77%  interrupts.CPU39.NMI:Non-maskable_interrupts
      0.25 �173%  +1.8e+05%     448.50 � 77%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    257903          +135.1%     606264        interrupts.CPU4.LOC:Local_timer_interrupts
      0.25 �173%    +1e+05%     257.75 � 24%  interrupts.CPU4.NMI:Non-maskable_interrupts
      0.25 �173%    +1e+05%     257.75 � 24%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    257882          +134.9%     605785        interrupts.CPU40.LOC:Local_timer_interrupts
      0.25 �173%  +2.3e+05%     574.25 � 99%  interrupts.CPU40.NMI:Non-maskable_interrupts
      0.25 �173%  +2.3e+05%     574.25 � 99%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    257998          +134.6%     605337        interrupts.CPU41.LOC:Local_timer_interrupts
     48.75 � 83%     -86.2%       6.75 �109%  interrupts.CPU41.RES:Rescheduling_interrupts
    258079          +134.7%     605611        interrupts.CPU42.LOC:Local_timer_interrupts
      0.50 �173%  +52250.0%     261.75 � 25%  interrupts.CPU42.NMI:Non-maskable_interrupts
      0.50 �173%  +52250.0%     261.75 � 25%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    257555          +135.2%     605682        interrupts.CPU43.LOC:Local_timer_interrupts
    258011          +134.8%     605819        interrupts.CPU44.LOC:Local_timer_interrupts
    110.00 � 58%     -96.1%       4.25 � 56%  interrupts.CPU44.RES:Rescheduling_interrupts
    258046          +134.7%     605702        interrupts.CPU45.LOC:Local_timer_interrupts
    101.00 � 89%     -97.3%       2.75 �110%  interrupts.CPU45.RES:Rescheduling_interrupts
    258036          +134.8%     605870        interrupts.CPU46.LOC:Local_timer_interrupts
    258037          +134.7%     605737        interrupts.CPU47.LOC:Local_timer_interrupts
    257967          +134.9%     605917        interrupts.CPU48.LOC:Local_timer_interrupts
    257674          +135.2%     605935        interrupts.CPU49.LOC:Local_timer_interrupts
    258062          +135.1%     606595        interrupts.CPU5.LOC:Local_timer_interrupts
    258045          +134.9%     606025        interrupts.CPU50.LOC:Local_timer_interrupts
    258020          +134.8%     605923        interrupts.CPU51.LOC:Local_timer_interrupts
    257886          +135.0%     605918        interrupts.CPU52.LOC:Local_timer_interrupts
    258018          +134.8%     605948        interrupts.CPU53.LOC:Local_timer_interrupts
    258032          +134.8%     605884        interrupts.CPU54.LOC:Local_timer_interrupts
     55.25 � 76%     -95.5%       2.50 � 60%  interrupts.CPU54.RES:Rescheduling_interrupts
    257864          +135.0%     605919        interrupts.CPU55.LOC:Local_timer_interrupts
    258008          +134.8%     605925        interrupts.CPU56.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     299.25 �  4%  interrupts.CPU56.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     299.25 �  4%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    258009          +134.9%     605943        interrupts.CPU57.LOC:Local_timer_interrupts
    257781          +135.1%     606003        interrupts.CPU58.LOC:Local_timer_interrupts
    258019          +134.8%     605916        interrupts.CPU59.LOC:Local_timer_interrupts
    257973          +135.1%     606373        interrupts.CPU6.LOC:Local_timer_interrupts
    258077          +134.8%     605916        interrupts.CPU60.LOC:Local_timer_interrupts
    257983          +134.8%     605737        interrupts.CPU61.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     293.00 �  3%  interrupts.CPU61.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     293.00 �  3%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    260661 �  2%    +132.5%     605907        interrupts.CPU62.LOC:Local_timer_interrupts
    258162          +134.7%     605888        interrupts.CPU63.LOC:Local_timer_interrupts
    258056          +134.8%     605938        interrupts.CPU64.LOC:Local_timer_interrupts
    257625          +135.2%     605921        interrupts.CPU65.LOC:Local_timer_interrupts
      2005 �  9%     +51.1%       3030 � 44%  interrupts.CPU66.CAL:Function_call_interrupts
    257972          +134.9%     605902        interrupts.CPU66.LOC:Local_timer_interrupts
    257840          +135.0%     605920        interrupts.CPU67.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     291.25 �  2%  interrupts.CPU67.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     291.25 �  2%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    255873          +136.8%     605914        interrupts.CPU68.LOC:Local_timer_interrupts
    257918          +134.9%     605936        interrupts.CPU69.LOC:Local_timer_interrupts
    257750          +135.5%     607125        interrupts.CPU7.LOC:Local_timer_interrupts
    258004          +134.8%     605804        interrupts.CPU70.LOC:Local_timer_interrupts
      1865 � 11%     +16.2%       2167 �  7%  interrupts.CPU71.CAL:Function_call_interrupts
    260658 �  2%    +132.5%     605957        interrupts.CPU71.LOC:Local_timer_interrupts
    257805          +135.0%     605950        interrupts.CPU72.LOC:Local_timer_interrupts
    258043          +134.9%     606168        interrupts.CPU73.LOC:Local_timer_interrupts
      0.25 �173%  +9.2e+05%       2310 �153%  interrupts.CPU73.NMI:Non-maskable_interrupts
      0.25 �173%  +9.2e+05%       2310 �153%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    258016          +134.9%     606153        interrupts.CPU74.LOC:Local_timer_interrupts
    258012          +135.0%     606224        interrupts.CPU75.LOC:Local_timer_interrupts
    258034          +134.9%     606203        interrupts.CPU76.LOC:Local_timer_interrupts
    257998          +135.0%     606202        interrupts.CPU77.LOC:Local_timer_interrupts
      0.25 �173%  +1.1e+05%     286.75 � 26%  interrupts.CPU77.NMI:Non-maskable_interrupts
      0.25 �173%  +1.1e+05%     286.75 � 26%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    257982          +135.0%     606209        interrupts.CPU78.LOC:Local_timer_interrupts
    258005          +135.0%     606194        interrupts.CPU79.LOC:Local_timer_interrupts
    258005          +135.1%     606517        interrupts.CPU8.LOC:Local_timer_interrupts
    257963          +135.0%     606187        interrupts.CPU80.LOC:Local_timer_interrupts
    258018          +134.9%     606189        interrupts.CPU81.LOC:Local_timer_interrupts
    258015          +135.0%     606248        interrupts.CPU82.LOC:Local_timer_interrupts
    258001          +135.0%     606206        interrupts.CPU83.LOC:Local_timer_interrupts
    258067          +134.9%     606176        interrupts.CPU84.LOC:Local_timer_interrupts
    258026          +134.9%     606002        interrupts.CPU85.LOC:Local_timer_interrupts
      1941 � 12%     +51.5%       2940 � 24%  interrupts.CPU86.CAL:Function_call_interrupts
    258049          +134.9%     606232        interrupts.CPU86.LOC:Local_timer_interrupts
    258021          +134.9%     606195        interrupts.CPU87.LOC:Local_timer_interrupts
    258025          +134.9%     606192        interrupts.CPU88.LOC:Local_timer_interrupts
    258019          +135.0%     606238        interrupts.CPU89.LOC:Local_timer_interrupts
    257891          +135.2%     606490        interrupts.CPU9.LOC:Local_timer_interrupts
    258039          +134.9%     606176        interrupts.CPU90.LOC:Local_timer_interrupts
    257929          +135.0%     606125        interrupts.CPU91.LOC:Local_timer_interrupts
    258045          +134.9%     606114        interrupts.CPU92.LOC:Local_timer_interrupts
    256784          +136.0%     606132        interrupts.CPU93.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     307.50 � 32%  interrupts.CPU93.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     307.50 � 32%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    255472          +137.3%     606111        interrupts.CPU94.LOC:Local_timer_interrupts
    257726          +135.1%     606036        interrupts.CPU95.LOC:Local_timer_interrupts
      0.25 �173%  +1.2e+05%     305.25 � 28%  interrupts.CPU95.NMI:Non-maskable_interrupts
      0.25 �173%  +1.2e+05%     305.25 � 28%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    257710          +135.1%     605816        interrupts.CPU96.LOC:Local_timer_interrupts
     18.25 � 62%    +352.1%      82.50 �104%  interrupts.CPU96.RES:Rescheduling_interrupts
    257967          +135.2%     606640        interrupts.CPU97.LOC:Local_timer_interrupts
      0.50 �100%  +60400.0%     302.50 � 19%  interrupts.CPU97.NMI:Non-maskable_interrupts
      0.50 �100%  +60400.0%     302.50 � 19%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    257967          +135.1%     606427        interrupts.CPU98.LOC:Local_timer_interrupts
    258011          +135.0%     606237        interrupts.CPU99.LOC:Local_timer_interrupts
  49504415          +135.1%  1.164e+08        interrupts.LOC:Local_timer_interrupts
      0.00       +1.9e+104%     192.00        interrupts.MCP:Machine_check_polls
     17.50 � 24%  +8.5e+05%     148487 �  7%  interrupts.NMI:Non-maskable_interrupts
     17.50 � 24%  +8.5e+05%     148487 �  7%  interrupts.PMI:Performance_monitoring_interrupts
     10597 � 10%     -46.8%       5641 �  2%  interrupts.RES:Rescheduling_interrupts
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     15.60 � 87%     -15.6        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
     13.10 �116%     -13.1        0.00        perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     10.41 � 93%     -10.4        0.00        perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.new_sync_read.vfs_read.ksys_read
     10.41 � 93%     -10.4        0.00        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.41 � 93%     -10.4        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     10.09 �143%     -10.1        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      9.02 �118%      -9.0        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.02 �118%      -9.0        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.00 �139%      -9.0        0.00        perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      9.00 �139%      -9.0        0.00        perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      7.15 � 68%      -7.1        0.00        perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.new_sync_read.vfs_read
      6.82 �130%      -6.8        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release
      6.82 �130%      -6.8        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput
      6.82 �130%      -6.8        0.00        perf-profile.calltrace.cycles-pp.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput.task_work_run
      6.39 �127%      -6.4        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      6.39 �127%      -6.4        0.00        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.34 �109%      -6.3        0.00        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.34 �109%      -6.3        0.00        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      4.10 �100%      -4.1        0.00        perf-profile.calltrace.cycles-pp.__libc_start_main
      4.10 �100%      -4.1        0.00        perf-profile.calltrace.cycles-pp.main.__libc_start_main
      4.10 �100%      -4.1        0.00        perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      4.10 �100%      -4.1        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      3.89 �107%      -3.9        0.00        perf-profile.calltrace.cycles-pp.read
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newlstat.do_syscall_64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.vfs_statx
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newlstat
      0.00            +0.6        0.55 �  4%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.6        0.62 �  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.6        0.63 �  6%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.7        0.71 � 11%  perf-profile.calltrace.cycles-pp._find_next_bit.cpumask_next.__percpu_counter_sum.__reserve_bytes.btrfs_reserve_metadata_bytes
      0.00            +0.7        0.73 � 13%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +0.7        0.74 �  5%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.79 �  6%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.79 �  5%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.8        0.81 � 11%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.8        0.85 � 12%  perf-profile.calltrace.cycles-pp.pagecache_get_page.prepare_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +0.9        0.87 � 12%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.9        0.87 � 12%  perf-profile.calltrace.cycles-pp.prepare_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.00            +0.9        0.88 �  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.9        0.93 � 18%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.btrfs_copy_from_user.btrfs_buffered_write
      0.00            +0.9        0.94 � 18%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.btrfs_copy_from_user.btrfs_buffered_write.btrfs_file_write_iter
      0.00            +0.9        0.95 � 18%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.btrfs_copy_from_user.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +1.0        0.98 � 17%  perf-profile.calltrace.cycles-pp.btrfs_copy_from_user.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.00            +1.0        1.05 � 10%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.1        1.07 � 32%  perf-profile.calltrace.cycles-pp.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
      0.00            +1.2        1.15 � 11%  perf-profile.calltrace.cycles-pp.cpumask_next.__percpu_counter_sum.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
      0.00            +1.2        1.22 �  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.3        1.29 � 13%  perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.00            +1.6        1.61 � 32%  perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.__writeback_single_inode
      0.00            +2.1        2.05 � 32%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work.worker_thread
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn
      0.00            +2.1        2.06 � 32%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      0.00            +2.2        2.25 � 28%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +2.2        2.25 � 28%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +2.3        2.34 � 28%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +2.3        2.34 � 28%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +2.8        2.81 �  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.83 �  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.8        2.84 �  7%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +4.0        4.00 � 13%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      1.09 �173%      +4.1        5.15 �  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      1.09 �173%      +8.1        9.19 �  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00           +11.6       11.61 �  5%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +14.8       14.81 � 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
      0.00           +15.1       15.06 � 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      0.00           +17.0       17.02 � 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
      0.00           +17.2       17.20 � 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
      0.00           +17.3       17.31 � 12%  perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00           +17.3       17.34 � 12%  perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.00           +19.6       19.56 � 11%  perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      0.00           +19.6       19.56 � 11%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00           +19.9       19.86 � 11%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     15.69 � 61%     +26.3       42.00 � 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +41.7       41.71 � 12%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00           +41.8       41.82 � 12%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00           +41.8       41.84 � 12%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +41.9       41.93 � 12%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +42.0       41.96 � 12%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.48 � 62%     -19.5        0.00        perf-profile.children.cycles-pp.do_group_exit
     19.48 � 62%     -19.5        0.00        perf-profile.children.cycles-pp.do_exit
     16.98 � 75%     -17.0        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     16.98 � 75%     -17.0        0.00        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     15.60 � 87%     -15.6        0.00        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     15.60 � 87%     -15.6        0.00        perf-profile.children.cycles-pp.get_signal
     14.48 �102%     -14.5        0.00        perf-profile.children.cycles-pp.task_work_run
     12.91 � 81%     -12.9        0.00        perf-profile.children.cycles-pp.ksys_read
     12.91 � 81%     -12.9        0.00        perf-profile.children.cycles-pp.vfs_read
     12.91 � 81%     -12.9        0.00        perf-profile.children.cycles-pp.seq_read_iter
     11.47 �123%     -11.5        0.00        perf-profile.children.cycles-pp.__fput
     10.41 � 93%     -10.4        0.00        perf-profile.children.cycles-pp.new_sync_read
     10.41 � 93%     -10.4        0.00        perf-profile.children.cycles-pp.proc_reg_read_iter
      9.00 �139%      -9.0        0.00        perf-profile.children.cycles-pp.perf_release
      9.00 �139%      -9.0        0.00        perf-profile.children.cycles-pp.perf_event_release_kernel
      7.15 � 68%      -7.1        0.00        perf-profile.children.cycles-pp.show_interrupts
      6.82 �130%      -6.8        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      6.82 �130%      -6.8        0.00        perf-profile.children.cycles-pp.event_function_call
      6.82 �130%      -6.8        0.00        perf-profile.children.cycles-pp.perf_remove_from_context
      6.39 �127%      -6.4        0.00        perf-profile.children.cycles-pp.schedule_idle
      6.34 �109%      -6.3        0.00        perf-profile.children.cycles-pp.do_sys_open
      6.34 �109%      -6.3        0.00        perf-profile.children.cycles-pp.do_sys_openat2
      6.34 �109%      -6.3        0.00        perf-profile.children.cycles-pp.do_filp_open
      6.34 �109%      -6.3        0.00        perf-profile.children.cycles-pp.path_openat
      4.70 �103%      -4.7        0.00        perf-profile.children.cycles-pp.lookup_fast
      4.70 �103%      -4.7        0.00        perf-profile.children.cycles-pp.walk_component
      4.10 �100%      -4.1        0.00        perf-profile.children.cycles-pp.__libc_start_main
      4.10 �100%      -4.1        0.00        perf-profile.children.cycles-pp.main
      4.10 �100%      -4.1        0.00        perf-profile.children.cycles-pp.run_builtin
      4.10 �100%      -4.1        0.00        perf-profile.children.cycles-pp.cmd_record
      3.89 �107%      -3.9        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.89 �107%      -3.9        0.00        perf-profile.children.cycles-pp.mmput
      3.89 �107%      -3.9        0.00        perf-profile.children.cycles-pp.exit_mmap
      3.89 �107%      -3.9        0.00        perf-profile.children.cycles-pp.pick_next_task_fair
      3.89 �107%      -3.9        0.00        perf-profile.children.cycles-pp.read
      3.56 �104%      -3.6        0.00        perf-profile.children.cycles-pp.seq_printf
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.__do_sys_newlstat
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.__d_lookup
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.filename_lookup
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.path_lookupat
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.__lxstat64
      3.31 �102%      -3.3        0.00        perf-profile.children.cycles-pp.vfs_statx
      0.00            +0.1        0.05 �  9%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.00            +0.1        0.06 � 14%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.06 � 11%  perf-profile.children.cycles-pp.btrfs_write_check
      0.00            +0.1        0.06 � 11%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.1        0.06 � 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 � 13%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.07 � 17%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.1        0.07 � 21%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.1        0.07 � 12%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.07 � 10%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.08 � 10%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.08 � 13%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.09 � 17%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.09 �  5%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.09 � 26%  perf-profile.children.cycles-pp.crc_24
      0.00            +0.1        0.09 �  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.09 � 23%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.1        0.09 �  7%  perf-profile.children.cycles-pp.btrfs_transaction_in_commit
      0.00            +0.1        0.09 � 20%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.09 � 13%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.10 � 23%  perf-profile.children.cycles-pp.crc_32
      0.00            +0.1        0.10 � 23%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.10 � 24%  perf-profile.children.cycles-pp.kernel_fpu_begin
      0.00            +0.1        0.10 �  7%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.10 � 28%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.00            +0.1        0.10 � 15%  perf-profile.children.cycles-pp.account_process_tick
      0.00            +0.1        0.10 � 28%  perf-profile.children.cycles-pp.run_one_async_done
      0.00            +0.1        0.10 � 28%  perf-profile.children.cycles-pp.btrfs_map_bio
      0.00            +0.1        0.10 � 28%  perf-profile.children.cycles-pp.submit_bio
      0.00            +0.1        0.10 � 28%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.00            +0.1        0.11 � 25%  perf-profile.children.cycles-pp.node_dirty_ok
      0.00            +0.1        0.11 � 33%  perf-profile.children.cycles-pp.crc_41
      0.00            +0.1        0.11 � 23%  perf-profile.children.cycles-pp.__crc32c_pcl_intel_finup
      0.00            +0.1        0.11 � 11%  perf-profile.children.cycles-pp.clear_state_bit
      0.00            +0.1        0.12 � 13%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.12 � 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.12 � 14%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.00            +0.1        0.12 � 15%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.1        0.12 � 34%  perf-profile.children.cycles-pp.btrfs_find_delalloc_range
      0.00            +0.1        0.12 � 17%  perf-profile.children.cycles-pp.account_page_dirtied
      0.00            +0.1        0.12 � 12%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.13 � 29%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.1        0.13 � 35%  perf-profile.children.cycles-pp.crc_96
      0.00            +0.1        0.13 � 31%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      0.00            +0.1        0.13 � 31%  perf-profile.children.cycles-pp.run_delalloc_nocow
      0.00            +0.1        0.13 � 31%  perf-profile.children.cycles-pp.find_get_pages_contig
      0.00            +0.1        0.14 �  6%  perf-profile.children.cycles-pp.lock_extent_bits
      0.00            +0.1        0.14 � 11%  perf-profile.children.cycles-pp.lru_cache_add
      0.00            +0.1        0.14 � 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.14 � 15%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.00            +0.2        0.15 � 35%  perf-profile.children.cycles-pp.lock_delalloc_pages
      0.00            +0.2        0.15 � 11%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.2        0.15 � 32%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.00            +0.2        0.15 �  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.2        0.16 � 17%  perf-profile.children.cycles-pp.btrfs_drop_pages
      0.00            +0.2        0.16 � 14%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.2        0.16 � 23%  perf-profile.children.cycles-pp.crc_72
      0.00            +0.2        0.16 �  6%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.2        0.16 � 11%  perf-profile.children.cycles-pp.find_next_bit
      0.00            +0.2        0.17 �  8%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.2        0.17 � 13%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.00            +0.2        0.18 � 10%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.2        0.19 � 18%  perf-profile.children.cycles-pp.btrfs_get_alloc_profile
      0.00            +0.2        0.21 � 29%  perf-profile.children.cycles-pp.btrfs_get_io_geometry
      0.00            +0.2        0.21 � 17%  perf-profile.children.cycles-pp.calc_available_free_space
      0.00            +0.2        0.22 � 29%  perf-profile.children.cycles-pp.btrfs_bio_fits_in_stripe
      0.00            +0.2        0.23 � 20%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.00            +0.2        0.23 �  6%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.2        0.23 � 11%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.00            +0.2        0.25 � 29%  perf-profile.children.cycles-pp.crc_42
      0.00            +0.3        0.26 � 13%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.3        0.27 � 25%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.3        0.27 � 29%  perf-profile.children.cycles-pp.submit_extent_page
      0.00            +0.3        0.28 � 33%  perf-profile.children.cycles-pp.__process_pages_contig
      0.00            +0.3        0.29 � 32%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.00            +0.3        0.29 � 22%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.3        0.30 � 35%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.00            +0.3        0.30 � 37%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.00            +0.3        0.31 � 24%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.3        0.32 � 14%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.3        0.33 �  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.3        0.33 � 38%  perf-profile.children.cycles-pp.end_page_writeback
      0.00            +0.3        0.34 �  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.4        0.36 � 13%  perf-profile.children.cycles-pp.btrfs_set_delalloc_extent
      0.00            +0.4        0.37 � 18%  perf-profile.children.cycles-pp.alloc_extent_state
      0.00            +0.4        0.37 � 13%  perf-profile.children.cycles-pp.set_state_bits
      0.00            +0.4        0.37 � 11%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.00            +0.4        0.38 � 11%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.4        0.38 � 10%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.4        0.41 �  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.4        0.42 � 35%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.00            +0.4        0.42 � 26%  perf-profile.children.cycles-pp.crc_128
      0.00            +0.4        0.42 � 10%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.00            +0.4        0.43 � 32%  perf-profile.children.cycles-pp.writepage_delalloc
      0.00            +0.4        0.43 � 16%  perf-profile.children.cycles-pp.clear_extent_bit
      0.00            +0.4        0.43 � 11%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.5        0.50 � 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.5        0.51 � 14%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      0.00            +0.5        0.52 � 13%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.5        0.53 � 10%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.5        0.53 � 35%  perf-profile.children.cycles-pp.btrfs_set_range_writeback
      0.00            +0.6        0.55 � 11%  perf-profile.children.cycles-pp.set_extent_bit
      0.00            +0.6        0.55 �  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.6        0.62 � 12%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +0.7        0.66 �117%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.7        0.69 �  6%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.7        0.70 �  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.7        0.73 � 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.8        0.79 �  5%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.8        0.80 �  5%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.8        0.81 � 11%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.9        0.87 � 12%  perf-profile.children.cycles-pp.prepare_pages
      0.00            +0.9        0.93 � 11%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.9        0.94 � 18%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.9        0.95 � 18%  perf-profile.children.cycles-pp.copyin
      0.00            +1.0        0.96 � 18%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.00            +1.0        0.96 �  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +1.0        0.98 � 17%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.00            +1.1        1.08 � 32%  perf-profile.children.cycles-pp.__extent_writepage_io
      0.00            +1.1        1.09 � 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +1.3        1.29 � 13%  perf-profile.children.cycles-pp.btrfs_dirty_pages
      0.00            +1.3        1.33 �  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +1.6        1.62 � 32%  perf-profile.children.cycles-pp.__extent_writepage
      0.00            +2.1        2.05 � 32%  perf-profile.children.cycles-pp.extent_write_cache_pages
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.wb_workfn
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.wb_writeback
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.writeback_sb_inodes
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.extent_writepages
      0.00            +2.1        2.06 � 32%  perf-profile.children.cycles-pp.do_writepages
      0.00            +2.2        2.25 � 28%  perf-profile.children.cycles-pp.process_one_work
      0.00            +2.2        2.25 � 28%  perf-profile.children.cycles-pp.worker_thread
      0.00            +2.3        2.29 � 10%  perf-profile.children.cycles-pp.ktime_get
      0.00            +2.3        2.34 � 28%  perf-profile.children.cycles-pp.kthread
      0.00            +2.3        2.34 � 28%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +3.0        2.97 �  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +3.0        3.01 �  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +4.0        4.02 � 13%  perf-profile.children.cycles-pp.__percpu_counter_sum
      1.09 �173%      +4.3        5.36 �  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00           +11.7       11.67 �  5%  perf-profile.children.cycles-pp.menu_select
      0.00           +17.3       17.33 � 12%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.00           +17.3       17.34 � 12%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.00           +19.6       19.56 � 11%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.00           +19.9       19.85 � 11%  perf-profile.children.cycles-pp.__reserve_bytes
      0.00           +19.9       19.86 � 11%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.00           +32.0       31.95 � 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00           +33.4       33.40 � 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00           +41.7       41.73 � 12%  perf-profile.children.cycles-pp.btrfs_buffered_write
      0.00           +41.8       41.82 � 12%  perf-profile.children.cycles-pp.btrfs_file_write_iter
      0.00           +41.9       41.85 � 12%  perf-profile.children.cycles-pp.new_sync_write
      0.00           +41.9       41.95 � 12%  perf-profile.children.cycles-pp.vfs_write
      0.00           +42.0       41.98 � 12%  perf-profile.children.cycles-pp.ksys_write
      6.82 �130%      -6.8        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      4.67 �100%      -4.7        0.00        perf-profile.self.cycles-pp.show_interrupts
      3.31 �102%      -3.3        0.00        perf-profile.self.cycles-pp.__d_lookup
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.dec_zone_page_state
      0.00            +0.1        0.05 �  8%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.06 � 15%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 � 14%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.07 � 17%  perf-profile.self.cycles-pp.free_extent_state
      0.00            +0.1        0.07 �  7%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.07 � 13%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.07 � 10%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.07 � 19%  perf-profile.self.cycles-pp.btrfs_get_alloc_profile
      0.00            +0.1        0.08 � 10%  perf-profile.self.cycles-pp.btrfs_dirty_pages
      0.00            +0.1        0.08 � 10%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.08 � 23%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.00            +0.1        0.08 � 26%  perf-profile.self.cycles-pp.btrfs_get_extent
      0.00            +0.1        0.08 � 15%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.08 � 15%  perf-profile.self.cycles-pp.btrfs_reserve_data_bytes
      0.00            +0.1        0.08 � 21%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.08 � 10%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.08 �  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.08 � 26%  perf-profile.self.cycles-pp.crc_24
      0.00            +0.1        0.09 � 17%  perf-profile.self.cycles-pp.btrfs_file_write_iter
      0.00            +0.1        0.09 � 14%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.09 � 20%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.10 � 28%  perf-profile.self.cycles-pp.crc_32
      0.00            +0.1        0.10 � 23%  perf-profile.self.cycles-pp.kernel_fpu_begin
      0.00            +0.1        0.10 � 28%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
      0.00            +0.1        0.10 � 17%  perf-profile.self.cycles-pp.btrfs_set_delalloc_extent
      0.00            +0.1        0.10 � 15%  perf-profile.self.cycles-pp.account_process_tick
      0.00            +0.1        0.11 � 32%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.00            +0.1        0.11 � 11%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.11 � 32%  perf-profile.self.cycles-pp.__process_pages_contig
      0.00            +0.1        0.12 � 19%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.00            +0.1        0.12 � 21%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.13 � 29%  perf-profile.self.cycles-pp._raw_read_lock
      0.00            +0.1        0.13 � 35%  perf-profile.self.cycles-pp.crc_96
      0.00            +0.1        0.14 �  8%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.14 � 15%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.00            +0.1        0.14 � 18%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.1        0.14 � 15%  perf-profile.self.cycles-pp.btrfs_drop_pages
      0.00            +0.2        0.15 �  8%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.2        0.16 � 23%  perf-profile.self.cycles-pp.crc_72
      0.00            +0.2        0.16 � 11%  perf-profile.self.cycles-pp.find_next_bit
      0.00            +0.2        0.17 �  8%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.2        0.25 � 28%  perf-profile.self.cycles-pp.crc_42
      0.00            +0.3        0.26 � 17%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.3        0.27 � 26%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.3        0.30 �  8%  perf-profile.self.cycles-pp.__reserve_bytes
      0.00            +0.3        0.34 �  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.4        0.38 � 13%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.4        0.38 � 10%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.4        0.41 � 12%  perf-profile.self.cycles-pp.cpumask_next
      0.00            +0.4        0.42 � 27%  perf-profile.self.cycles-pp.crc_128
      0.00            +0.5        0.47 � 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.5        0.52 � 13%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +0.9        0.94 � 18%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +1.5        1.47 � 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +2.2        2.17 � 10%  perf-profile.self.cycles-pp.ktime_get
      0.00            +2.5        2.47 � 15%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.00            +7.5        7.47 �  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00           +10.8       10.81 �  5%  perf-profile.self.cycles-pp.menu_select
      0.00           +31.8       31.83 � 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-cpl-4sp1: 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/btrfs/x86_64-rhel-8.3/4/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/creat-clo/aim7/0x700001e

commit: 
  5b964115b5 ("btrfs: rework btrfs_calc_reclaim_metadata_size")
  53c5e5a1d8 ("btrfs: simplify the logic in need_preemptive_flushing")

5b964115b57bfe55 53c5e5a1d87e3341d06a00746c7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2188            -3.5%       2112        aim7.jobs-per-min
     10.99            +3.7%      11.40        aim7.time.elapsed_time
     10.99            +3.7%      11.40        aim7.time.elapsed_time.max
      2735 �  3%      +3.9%       2841        aim7.time.maximum_resident_set_size
    240926 �  5%     -99.1%       2250 �  3%  aim7.time.voluntary_context_switches
      1.99           +10.9%       2.20 � 12%  iostat.cpu.system
      0.61 �  2%      +0.0        0.66 �  4%  mpstat.cpu.all.sys%
    220726 � 23%     +69.2%     373544 � 16%  softirqs.RCU
     37875 �  4%     -89.6%       3955 �  2%  vmstat.system.cs
    249812 �  8%     -88.5%      28754 � 11%  cpuidle.POLL.time
    196378 �  6%     -96.4%       6990 �  3%  cpuidle.POLL.usage
      5390 �  9%     +21.0%       6521 �  9%  numa-meminfo.node1.KernelStack
     70376 � 17%     -20.5%      55945 � 12%  numa-meminfo.node3.SUnreclaim
      5412 �  8%     +20.4%       6514 �  9%  numa-vmstat.node1.nr_kernel_stack
     17593 � 17%     -20.5%      13987 � 12%  numa-vmstat.node3.nr_slab_unreclaimable
     13523 �  6%     -77.7%       3022 �  3%  perf-stat.i.context-switches
     12463 �  7%     -77.7%       2783 �  3%  perf-stat.ps.context-switches
    716.75            +5.0%     752.25 �  3%  proc-vmstat.nr_active_file
    716.75            +5.0%     752.25 �  3%  proc-vmstat.nr_zone_active_file
     21939 � 44%     -75.9%       5285 � 29%  sched_debug.cfs_rq:/.load_avg.max
      2732 � 25%     -51.6%       1323 � 12%  sched_debug.cfs_rq:/.load_avg.stddev
      6380 � 74%    +209.7%      19761 � 28%  sched_debug.cfs_rq:/.spread0.max
    160664 �  4%     -14.1%     137974 �  7%  interrupts.CAL:Function_call_interrupts
      1054 � 24%     +42.9%       1506 � 25%  interrupts.CPU1.CAL:Function_call_interrupts
    911.50           +12.3%       1023 �  6%  interrupts.CPU104.CAL:Function_call_interrupts
      1795 � 29%     -43.4%       1016 � 10%  interrupts.CPU2.CAL:Function_call_interrupts
    776.50 � 10%     -58.9%     319.50 � 34%  interrupts.RES:Rescheduling_interrupts
      0.01 � 89%    +365.1%       0.05 � 41%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.02 �109%    +354.5%       0.08 � 10%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.01 � 23%  +11226.9%       0.74 �171%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.03 � 65%   +3965.6%       1.27 �163%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.81 � 25%     -28.8%       0.58 � 15%  perf-sched.total_wait_time.average.ms
      1681 �  3%      -8.0%       1547 �  8%  slabinfo.files_cache.active_objs
      1681 �  3%      -8.0%       1547 �  8%  slabinfo.files_cache.num_objs
      3846 �  9%     -16.7%       3203 �  5%  slabinfo.fsnotify_mark_connector.active_objs
      3846 �  9%     -16.7%       3203 �  5%  slabinfo.fsnotify_mark_connector.num_objs
      1903 �  4%     -19.5%       1532 � 13%  slabinfo.khugepaged_mm_slot.active_objs
      1903 �  4%     -19.5%       1532 � 13%  slabinfo.khugepaged_mm_slot.num_objs
     10.00 �122%      -8.6        1.35 �173%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.25 �103%      -5.6        0.68 �173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      6.25 �103%      -5.6        0.68 �173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.25 �103%      -5.6        0.68 �173%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.25 �103%      -5.6        0.68 �173%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.25 �103%      -5.6        0.68 �173%  perf-profile.calltrace.cycles-pp.read
      5.00 �100%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
      5.00 �100%      -5.0        0.00        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      5.00 �100%      -5.0        0.00        perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
      3.59 �106%      -1.1        2.50 �173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      3.59 �106%      -1.1        2.50 �173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      3.59 �106%      -1.1        2.50 �173%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      3.59 �106%      -1.1        2.50 �173%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      3.59 �106%      -1.1        2.50 �173%  perf-profile.calltrace.cycles-pp.__open64_nocancel
     11.25 �110%      -9.2        2.03 �173%  perf-profile.children.cycles-pp.ksys_read
     11.25 �110%      -9.2        2.03 �173%  perf-profile.children.cycles-pp.vfs_read
     10.00 �122%      -8.6        1.35 �173%  perf-profile.children.cycles-pp.new_sync_read
      6.25 �103%      -5.6        0.68 �173%  perf-profile.children.cycles-pp.read
      5.00 �100%      -5.0        0.00        perf-profile.children.cycles-pp.pipe_read
      5.00 �100%      -4.3        0.68 �173%  perf-profile.children.cycles-pp.schedule
      5.00 �100%      -3.6        1.35 �173%  perf-profile.children.cycles-pp.__schedule
      3.59 �106%      -1.1        2.50 �173%  perf-profile.children.cycles-pp.__open64_nocancel





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc2-00040-g53c5e5a1d87e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fsmark'
	export testcase='fsmark'
	export category='benchmark'
	export iterations=1
	export nr_threads=1
	export need_memory='50G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/fsmark-generic-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap2'
	export tbox_group='lkp-csl-2ap2'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5ffcbce6955bd923014f3b4f'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-20210112-8961-sb9d6j-3.yaml'
	export id='d60d1393beb040d259b2d8bb5f615884e63ee54e'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export nr_ssd_partitions=1
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_NFSD
CONFIG_BTRFS_FS'
	export commit='53c5e5a1d87e3341d06a00746c772dc7eff6a65b'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003003'
	export enqueue_time='2021-01-12 05:02:30 +0800'
	export _id='5ffcbceb955bd923014f3b50'
	export _rt='/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='24550f4accf5ebe477580a00b0c5ea5a5be3525d'
	export base_commit='e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62'
	export branch='kdave-btrfs-devel/for-next-20210104'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/3'
	export scheduler_version='/lkp/lkp/.src-20210111-194730'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-20210112-8961-sb9d6j-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=kdave-btrfs-devel/for-next-20210104
commit=53c5e5a1d87e3341d06a00746c772dc7eff6a65b
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/vmlinuz-5.11.0-rc2-00040-g53c5e5a1d87e
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-3.3-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.11.0-rc2'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/vmlinuz-5.11.0-rc2-00040-g53c5e5a1d87e'
	export dequeue_time='2021-01-12 05:08:09 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-20210112-8961-sb9d6j-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='btrfs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=1 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test filesize='4M' test_size='24G' sync_method='fsyncBeforeClose' $LKP_SRC/tests/wrapper fsmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper fsmark
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat

	$LKP_SRC/stats/wrapper time fsmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/fsmark-generic-1brd.yaml
suite: fsmark
testcase: fsmark
category: benchmark
perf-profile:
  delay: 1
iterations: 1x
nr_threads: 1t
disk: 1BRD_48G
need_memory: 50G
fs: btrfs
fs2: 
fsmark:
  filesize: 4M
  test_size: 24G
  sync_method: fsyncBeforeClose
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/fsmark-generic-1brd.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap2
tbox_group: lkp-csl-2ap2
kconfig: x86_64-rhel-8.3
submit_id: 5ffc9458955bd91cfacf663f
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-20210112-7418-16gbvxg-0.yaml"
id: b52d912be08ea6b45fc55ceedce79d7bed8acb90
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap2
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
nr_ssd_partitions: 1
hdd_partitions: 
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4"
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

#! include/category/benchmark
kmsg: 
boot-time: 
uptime: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
perf-sched: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
sched_debug: 
perf-stat: 
mpstat: 

#! include/category/ALL
cpufreq_governor: performance

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_NFSD
- CONFIG_BTRFS_FS

#! include/fsmark

#! include/queue/cyclic
commit: 53c5e5a1d87e3341d06a00746c772dc7eff6a65b

#! include/testbox/lkp-csl-2ap2
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003003'

#! include/fs/OTHERS
enqueue_time: 2021-01-12 02:09:28.454800611 +08:00
_id: 5ffc9458955bd91cfacf663f
_rt: "/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 24550f4accf5ebe477580a00b0c5ea5a5be3525d
base_commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
branch: linux-devel/devel-hourly-2021011021
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/0"
scheduler_version: "/lkp/lkp/.src-20210111-194730"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-20210112-7418-16gbvxg-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2021011021
- commit=53c5e5a1d87e3341d06a00746c772dc7eff6a65b
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/vmlinuz-5.11.0-rc2-00040-g53c5e5a1d87e
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-1t-fsyncBeforeClose-24G-ucode=0x5003003-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-3.3-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210111-194730/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-rc2-02388-gb6bf783a8884
repeat_to: 2

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/53c5e5a1d87e3341d06a00746c772dc7eff6a65b/vmlinuz-5.11.0-rc2-00040-g53c5e5a1d87e"
dequeue_time: 2021-01-12 02:10:56.419511201 +08:00
job_state: finished
loadavg: 1.10 0.36 0.13 1/1606 4744
start_time: '1610388916'
end_time: '1610388948'
version: "/lkp/lkp/.src-20210111-194801:cdcccd07-dirty:6b61e8c92"

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t btrfs /dev/ram0
mkdir -p /fs/ram0
mount -t btrfs /dev/ram0 /fs/ram0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

fs_mark -d /fs/ram0/1 -n 6144 -L 1 -S 1 -s 4194304

--UlVJffcvxoiEqYs2--
