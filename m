Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4193488B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYF63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 01:58:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:59737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCYF6Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 01:58:16 -0400
IronPort-SDR: Xb9MWmAeS3KGpFydybDdEPa+KYyZdhAatnA0Wx0r+VMGZHJ1QfdTUUeCqhgjCYp4DEB2/7dde7
 woXnHDeK6gwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="210985281"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="yaml'?scan'208";a="210985281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 22:58:14 -0700
IronPort-SDR: fCfIyalku0QI4V8G0BMciAqRn+SW2F4Iw45OF+L7mjHnI+dK5Xxj6jFDCO6pAMRfawxfY6TV0q
 20j2cziaxuHQ==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="yaml'?scan'208";a="415829457"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 22:58:09 -0700
Date:   Thu, 25 Mar 2021 13:56:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [btrfs]  b05645404a:  fsmark.files_per_sec 81.3% improvement
Message-ID: <20210325055609.GA13061@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d500e1b1337e9b36e6dc7ade4e9fad36931c44f4.1616593448.git.josef@toxicpanda.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 81.3% improvement of fsmark.files_per_sec due to commit:


commit: b05645404a7d4f798a5101542726d41cef4f08a0 ("[PATCH] btrfs: use percpu_read_positive instead of sum_positive for need_preempt")
url: https://github.com/0day-ci/linux/commits/Josef-Bacik/btrfs-use-percpu_read_positive-instead-of-sum_positive-for-need_preempt/20210324-214635
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next

in testcase: fsmark
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	iterations: 1x
	nr_threads: 64t
	disk: 1BRD_48G
	fs: btrfs
	filesize: 4M
	test_size: 24G
	sync_method: NoSync
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
test-url: https://sourceforge.net/projects/fsmark/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 107.0% improvement                            |
| test machine     | 88 threads Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | disk=4BRD_12G                                                         |
|                  | fs=btrfs                                                              |
|                  | load=500                                                              |
|                  | md=RAID1                                                              |
|                  | test=disk_rr                                                          |
|                  | ucode=0x5003006                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 113.7% improvement                            |
| test machine     | 88 threads Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | disk=4BRD_12G                                                         |
|                  | fs=btrfs                                                              |
|                  | load=1500                                                             |
|                  | md=RAID0                                                              |
|                  | test=disk_cp                                                          |
|                  | ucode=0x5003006                                                       |
+------------------+-----------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/btrfs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/NoSync/lkp-csl-2ap2/24G/fsmark/0x5003006

commit: 
  c7f9865055 ("Merge branch 'for-next-next-v5.12-20210322' into for-next-20210322")
  b05645404a ("btrfs: use percpu_read_positive instead of sum_positive for need_preempt")

c7f98650557ad6d6 b05645404a7d4f798a510154272 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    772.92 ±  2%     +81.3%       1401 ±  6%  fsmark.files_per_sec
     20.48 ±  3%     -19.9%      16.40        fsmark.time.elapsed_time
     20.48 ±  3%     -19.9%      16.40        fsmark.time.elapsed_time.max
      1498 ±  4%     -60.7%     588.33 ± 10%  fsmark.time.involuntary_context_switches
     13476            -5.9%      12681        fsmark.time.minor_page_faults
      2429           -57.9%       1022 ±  5%  fsmark.time.percent_of_cpu_this_job_got
    497.25 ±  2%     -66.3%     167.57 ±  5%  fsmark.time.system_time
     13492 ±  4%      -6.2%      12649 ±  5%  softirqs.TIMER
     86.28            +7.1%      92.38        iostat.cpu.idle
     12.98 ±  2%     -47.2%       6.85 ±  5%  iostat.cpu.system
      5800 ±  4%     +11.8%       6485 ±  6%  slabinfo.btrfs_inode.active_objs
      5879 ±  4%     +12.5%       6615 ±  6%  slabinfo.btrfs_inode.num_objs
      2995 ±  9%     +17.2%       3512 ±  5%  slabinfo.mnt_cache.active_objs
      0.14 ±  8%      +0.1        0.21 ± 29%  mpstat.cpu.all.iowait%
      0.75 ±  7%      +0.2        0.92 ± 12%  mpstat.cpu.all.irq%
      0.07 ±  6%      +0.0        0.08 ±  5%  mpstat.cpu.all.soft%
      8.97            -4.7        4.29 ±  4%  mpstat.cpu.all.sys%
     85.83            +7.0%      91.83        vmstat.cpu.id
   1066200 ±  3%     +20.3%    1282422 ±  2%  vmstat.io.bo
     23.00 ±  3%     -48.6%      11.83 ± 14%  vmstat.procs.r
    411303           -14.5%     351834 ±  8%  vmstat.system.in
     15011 ±  7%     -30.7%      10407 ± 22%  numa-meminfo.node0.Mapped
     16876 ± 28%     -42.7%       9673 ± 29%  numa-meminfo.node1.Mapped
     13352 ± 23%     -29.4%       9426 ± 22%  numa-meminfo.node2.Mapped
     29020 ± 13%     -75.1%       7213 ± 73%  numa-meminfo.node3.Active
     28619 ± 13%     -83.7%       4664 ± 20%  numa-meminfo.node3.Active(anon)
     56563 ± 19%     -73.3%      15125 ± 42%  numa-meminfo.node3.Shmem
      3806 ±  7%     -30.9%       2630 ± 21%  numa-vmstat.node0.nr_mapped
      4290 ± 28%     -42.5%       2465 ± 28%  numa-vmstat.node1.nr_mapped
      3409 ± 24%     -29.5%       2405 ± 20%  numa-vmstat.node2.nr_mapped
      7070 ± 12%     -83.8%       1143 ± 22%  numa-vmstat.node3.nr_active_anon
      4536 ± 31%     -38.6%       2786 ± 32%  numa-vmstat.node3.nr_mapped
     14131 ± 19%     -73.4%       3765 ± 42%  numa-vmstat.node3.nr_shmem
      7070 ± 12%     -83.8%       1143 ± 22%  numa-vmstat.node3.nr_zone_active_anon
     43727 ± 11%     -50.5%      21642 ±  3%  meminfo.Active
     31549 ± 14%     -74.8%       7942 ±  4%  meminfo.Active(anon)
     12177 ±  2%     +12.5%      13700 ±  4%  meminfo.Active(file)
  18246287           +10.5%   20155126        meminfo.Cached
  17500161           +11.3%   19482329        meminfo.Inactive
  17123573           +11.4%   19072615        meminfo.Inactive(file)
     62486 ±  3%     -35.8%      40140        meminfo.Mapped
      8523 ± 27%     +42.7%      12159 ±  5%  meminfo.PageTables
     71378 ±  8%     -57.7%      30225 ±  3%  meminfo.Shmem
  33861393           +10.5%   37431930        meminfo.max_used_kB
      7889 ± 14%     -74.8%       1986 ±  4%  proc-vmstat.nr_active_anon
      3052 ±  2%     +12.2%       3426 ±  4%  proc-vmstat.nr_active_file
     84293 ± 12%     +15.1%      97055        proc-vmstat.nr_anon_pages
   4556803           +10.5%    5033951        proc-vmstat.nr_file_pages
  41427904            -2.0%   40611038        proc-vmstat.nr_free_pages
   4276143           +11.4%    4763316        proc-vmstat.nr_inactive_file
     15778 ±  3%     -35.5%      10177        proc-vmstat.nr_mapped
      2129 ± 27%     +42.9%       3043 ±  5%  proc-vmstat.nr_page_table_pages
     17854 ±  8%     -57.7%       7560 ±  3%  proc-vmstat.nr_shmem
     48278            +3.9%      50179        proc-vmstat.nr_slab_reclaimable
      7889 ± 14%     -74.8%       1986 ±  4%  proc-vmstat.nr_zone_active_anon
      3052 ±  2%     +12.2%       3426 ±  4%  proc-vmstat.nr_zone_active_file
   4276142           +11.4%    4763316        proc-vmstat.nr_zone_inactive_file
   2037723 ±  2%     +12.1%    2284109 ±  2%  proc-vmstat.nr_zone_write_pending
    139922 ±197%   +1054.6%    1615504 ±  5%  proc-vmstat.numa_foreign
  12979689 ±  2%     -11.6%   11478988        proc-vmstat.numa_hit
  12719975 ±  2%     -11.8%   11219287        proc-vmstat.numa_local
    139922 ±197%   +1054.6%    1615504 ±  5%  proc-vmstat.numa_miss
    399637 ± 69%    +369.2%    1875204 ±  4%  proc-vmstat.numa_other
     18580 ±  7%     -70.9%       5401 ±  9%  proc-vmstat.pgactivate
    158490 ±  2%     -22.0%     123599 ±  5%  proc-vmstat.pgfault
      6843 ±  2%     -14.6%       5844 ±  3%  proc-vmstat.pgreuse
 3.754e+09           -25.9%  2.782e+09        perf-stat.i.branch-instructions
  61481618 ±  4%     +23.6%   76009582 ±  3%  perf-stat.i.cache-misses
      3.88 ±  2%     -30.1%       2.71        perf-stat.i.cpi
 8.975e+10 ±  2%     -46.9%  4.764e+10 ±  3%  perf-stat.i.cpu-cycles
    263.36 ±  2%     +17.6%     309.83 ±  5%  perf-stat.i.cpu-migrations
      2215 ±  6%     -71.0%     641.83 ±  5%  perf-stat.i.cycles-between-cache-misses
 4.103e+09 ±  3%     -21.3%   3.23e+09 ±  5%  perf-stat.i.dTLB-loads
  1.11e+09 ±  2%      +6.0%  1.176e+09        perf-stat.i.dTLB-stores
 1.731e+10           -22.0%  1.351e+10        perf-stat.i.instructions
      3891 ±  3%     -12.0%       3425 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.35 ±  5%     +26.3%       0.44 ±  2%  perf-stat.i.ipc
      9.19 ±  5%     +25.6%      11.54 ±  5%  perf-stat.i.major-faults
      0.47 ±  2%     -46.8%       0.25 ±  3%  perf-stat.i.metric.GHz
     47.46 ±  2%     -19.1%      38.37 ±  3%  perf-stat.i.metric.M/sec
   2469496 ± 22%     +74.8%    4317727 ±  6%  perf-stat.i.node-store-misses
      6.10 ±  9%     +65.7%      10.10 ± 17%  perf-stat.overall.MPKI
      1.63 ±  4%      +0.6        2.26 ±  7%  perf-stat.overall.branch-miss-rate%
      5.25           -31.4%       3.60 ±  2%  perf-stat.overall.cpi
      1498 ±  3%     -57.1%     642.82 ±  2%  perf-stat.overall.cycles-between-cache-misses
      4315 ±  3%     -17.5%       3562 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.19           +45.7%       0.28 ±  2%  perf-stat.overall.ipc
     47.90 ± 20%     +11.1       58.98 ±  5%  perf-stat.overall.node-store-miss-rate%
 3.645e+09           -26.5%  2.679e+09        perf-stat.ps.branch-instructions
  58885581 ±  3%     +23.8%   72904004 ±  3%  perf-stat.ps.cache-misses
    182839            -1.1%     180765        perf-stat.ps.cpu-clock
 8.815e+10 ±  2%     -46.8%  4.685e+10 ±  3%  perf-stat.ps.cpu-cycles
    254.30 ±  2%     +16.5%     296.37 ±  6%  perf-stat.ps.cpu-migrations
 3.982e+09 ±  3%     -21.8%  3.116e+09 ±  5%  perf-stat.ps.dTLB-loads
 1.679e+10           -22.6%    1.3e+10        perf-stat.ps.instructions
      9.44 ±  5%     +19.2%      11.26 ±  3%  perf-stat.ps.major-faults
   2420180 ± 23%     +78.4%    4317335 ±  6%  perf-stat.ps.node-store-misses
    182839            -1.1%     180765        perf-stat.ps.task-clock
  3.58e+11           -36.7%  2.268e+11 ±  3%  perf-stat.total.instructions
    256302 ± 13%     -26.7%     187783 ±  4%  interrupts.CAL:Function_call_interrupts
     43792 ±  3%     -27.6%      31704 ± 20%  interrupts.CPU0.LOC:Local_timer_interrupts
      3519 ± 20%     -78.3%     765.00 ± 83%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3519 ± 20%     -78.3%     765.00 ± 83%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    920.17 ±  3%     +21.8%       1120 ± 18%  interrupts.CPU1.CAL:Function_call_interrupts
     43739 ±  3%     -27.6%      31654 ± 20%  interrupts.CPU1.LOC:Local_timer_interrupts
     43644 ±  2%     -27.7%      31576 ± 20%  interrupts.CPU10.LOC:Local_timer_interrupts
      4569 ± 15%     -89.4%     485.83 ± 64%  interrupts.CPU10.NMI:Non-maskable_interrupts
      4569 ± 15%     -89.4%     485.83 ± 64%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     43636 ±  3%     -27.6%      31576 ± 20%  interrupts.CPU100.LOC:Local_timer_interrupts
      3481 ± 27%     -85.2%     515.33 ± 67%  interrupts.CPU100.NMI:Non-maskable_interrupts
      3481 ± 27%     -85.2%     515.33 ± 67%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     43632 ±  3%     -27.6%      31591 ± 20%  interrupts.CPU101.LOC:Local_timer_interrupts
      3154 ± 18%     -84.0%     503.33 ± 55%  interrupts.CPU101.NMI:Non-maskable_interrupts
      3154 ± 18%     -84.0%     503.33 ± 55%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
     43604 ±  3%     -27.5%      31591 ± 20%  interrupts.CPU102.LOC:Local_timer_interrupts
      3530 ± 34%     -87.4%     445.17 ± 79%  interrupts.CPU102.NMI:Non-maskable_interrupts
      3530 ± 34%     -87.4%     445.17 ± 79%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
     43545 ±  2%     -27.6%      31539 ± 20%  interrupts.CPU103.LOC:Local_timer_interrupts
      4095 ± 31%     -85.9%     576.83 ±105%  interrupts.CPU103.NMI:Non-maskable_interrupts
      4095 ± 31%     -85.9%     576.83 ±105%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
     43626 ±  3%     -27.6%      31583 ± 20%  interrupts.CPU104.LOC:Local_timer_interrupts
      3270 ± 58%     -84.5%     505.83 ± 64%  interrupts.CPU104.NMI:Non-maskable_interrupts
      3270 ± 58%     -84.5%     505.83 ± 64%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
     43622 ±  3%     -27.6%      31580 ± 20%  interrupts.CPU105.LOC:Local_timer_interrupts
      3645 ± 56%     -83.5%     600.83 ± 69%  interrupts.CPU105.NMI:Non-maskable_interrupts
      3645 ± 56%     -83.5%     600.83 ± 69%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
     43660 ±  3%     -27.7%      31570 ± 20%  interrupts.CPU106.LOC:Local_timer_interrupts
      3480 ± 29%     -84.9%     525.33 ± 68%  interrupts.CPU106.NMI:Non-maskable_interrupts
      3480 ± 29%     -84.9%     525.33 ± 68%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
     43650 ±  3%     -27.6%      31606 ± 20%  interrupts.CPU107.LOC:Local_timer_interrupts
     43610 ±  3%     -27.5%      31602 ± 20%  interrupts.CPU108.LOC:Local_timer_interrupts
     43603 ±  3%     -27.6%      31562 ± 20%  interrupts.CPU109.LOC:Local_timer_interrupts
     43686 ±  3%     -27.5%      31654 ± 20%  interrupts.CPU11.LOC:Local_timer_interrupts
     43671 ±  3%     -27.8%      31524 ± 20%  interrupts.CPU110.LOC:Local_timer_interrupts
     43637 ±  3%     -27.7%      31546 ± 20%  interrupts.CPU111.LOC:Local_timer_interrupts
     43583 ±  3%     -27.5%      31598 ± 20%  interrupts.CPU112.LOC:Local_timer_interrupts
     43613 ±  3%     -27.7%      31528 ± 20%  interrupts.CPU113.LOC:Local_timer_interrupts
     43612 ±  3%     -27.6%      31564 ± 20%  interrupts.CPU114.LOC:Local_timer_interrupts
     43620 ±  3%     -27.7%      31554 ± 20%  interrupts.CPU115.LOC:Local_timer_interrupts
     43622 ±  3%     -27.6%      31562 ± 20%  interrupts.CPU116.LOC:Local_timer_interrupts
     43632 ±  3%     -27.7%      31553 ± 20%  interrupts.CPU117.LOC:Local_timer_interrupts
     43618 ±  3%     -27.5%      31615 ± 20%  interrupts.CPU118.LOC:Local_timer_interrupts
      2937 ± 57%     -84.2%     464.00 ± 69%  interrupts.CPU118.NMI:Non-maskable_interrupts
      2937 ± 57%     -84.2%     464.00 ± 69%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
     43618 ±  3%     -27.6%      31579 ± 20%  interrupts.CPU119.LOC:Local_timer_interrupts
     43673 ±  3%     -27.5%      31650 ± 20%  interrupts.CPU12.LOC:Local_timer_interrupts
     43570 ±  3%     -23.5%      33319 ± 15%  interrupts.CPU120.LOC:Local_timer_interrupts
      4198 ± 24%     -89.0%     462.17 ± 45%  interrupts.CPU120.NMI:Non-maskable_interrupts
      4198 ± 24%     -89.0%     462.17 ± 45%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
     43668 ±  3%     -23.6%      33342 ± 15%  interrupts.CPU121.LOC:Local_timer_interrupts
      3492 ± 39%     -88.2%     411.33 ± 56%  interrupts.CPU121.NMI:Non-maskable_interrupts
      3492 ± 39%     -88.2%     411.33 ± 56%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
     43662 ±  3%     -23.9%      33239 ± 16%  interrupts.CPU122.LOC:Local_timer_interrupts
      4093 ± 28%     -72.6%       1122 ±128%  interrupts.CPU122.NMI:Non-maskable_interrupts
      4093 ± 28%     -72.6%       1122 ±128%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
     43656 ±  3%     -23.7%      33330 ± 15%  interrupts.CPU123.LOC:Local_timer_interrupts
     43639 ±  3%     -23.7%      33288 ± 15%  interrupts.CPU124.LOC:Local_timer_interrupts
     43668 ±  3%     -23.7%      33312 ± 16%  interrupts.CPU125.LOC:Local_timer_interrupts
     43658 ±  3%     -23.6%      33366 ± 15%  interrupts.CPU126.LOC:Local_timer_interrupts
     43606 ±  3%     -23.6%      33296 ± 15%  interrupts.CPU127.LOC:Local_timer_interrupts
     43644 ±  3%     -23.6%      33341 ± 15%  interrupts.CPU128.LOC:Local_timer_interrupts
     43645 ±  3%     -23.7%      33310 ± 16%  interrupts.CPU129.LOC:Local_timer_interrupts
     43550 ±  3%     -27.4%      31631 ± 20%  interrupts.CPU13.LOC:Local_timer_interrupts
     43652 ±  3%     -23.7%      33300 ± 16%  interrupts.CPU130.LOC:Local_timer_interrupts
     43646 ±  3%     -23.7%      33307 ± 16%  interrupts.CPU131.LOC:Local_timer_interrupts
     43651 ±  3%     -23.5%      33379 ± 15%  interrupts.CPU132.LOC:Local_timer_interrupts
     43673 ±  3%     -23.7%      33322 ± 15%  interrupts.CPU133.LOC:Local_timer_interrupts
     43654 ±  3%     -23.6%      33365 ± 15%  interrupts.CPU134.LOC:Local_timer_interrupts
     43656 ±  3%     -23.6%      33370 ± 15%  interrupts.CPU135.LOC:Local_timer_interrupts
     43638 ±  3%     -23.5%      33365 ± 15%  interrupts.CPU136.LOC:Local_timer_interrupts
     43627 ±  3%     -23.5%      33367 ± 15%  interrupts.CPU137.LOC:Local_timer_interrupts
     43640 ±  3%     -23.7%      33302 ± 16%  interrupts.CPU138.LOC:Local_timer_interrupts
     43634 ±  3%     -23.7%      33308 ± 16%  interrupts.CPU139.LOC:Local_timer_interrupts
     43677 ±  3%     -27.6%      31602 ± 20%  interrupts.CPU14.LOC:Local_timer_interrupts
     43644 ±  3%     -23.7%      33313 ± 16%  interrupts.CPU140.LOC:Local_timer_interrupts
     43638 ±  3%     -23.7%      33301 ± 16%  interrupts.CPU141.LOC:Local_timer_interrupts
     43675 ±  3%     -23.6%      33363 ± 15%  interrupts.CPU142.LOC:Local_timer_interrupts
     43629 ±  3%     -23.5%      33366 ± 15%  interrupts.CPU143.LOC:Local_timer_interrupts
     43664 ±  3%     -23.0%      33610 ± 15%  interrupts.CPU144.LOC:Local_timer_interrupts
      3550 ± 33%     -83.9%     569.83 ± 48%  interrupts.CPU144.NMI:Non-maskable_interrupts
      3550 ± 33%     -83.9%     569.83 ± 48%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
     43651 ±  3%     -22.8%      33684 ± 14%  interrupts.CPU145.LOC:Local_timer_interrupts
     43632 ±  3%     -22.8%      33688 ± 14%  interrupts.CPU146.LOC:Local_timer_interrupts
      1980 ± 55%     -83.5%     326.50 ± 27%  interrupts.CPU146.NMI:Non-maskable_interrupts
      1980 ± 55%     -83.5%     326.50 ± 27%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
     43655 ±  2%     -23.1%      33591 ± 15%  interrupts.CPU147.LOC:Local_timer_interrupts
     43655 ±  3%     -23.0%      33625 ± 15%  interrupts.CPU148.LOC:Local_timer_interrupts
     43654 ±  3%     -22.9%      33639 ± 15%  interrupts.CPU149.LOC:Local_timer_interrupts
     43670 ±  3%     -27.6%      31633 ± 20%  interrupts.CPU15.LOC:Local_timer_interrupts
      2671 ± 66%     -79.2%     556.50 ± 89%  interrupts.CPU15.NMI:Non-maskable_interrupts
      2671 ± 66%     -79.2%     556.50 ± 89%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     43647 ±  3%     -23.0%      33629 ± 15%  interrupts.CPU150.LOC:Local_timer_interrupts
      2026 ± 69%     -83.3%     338.50 ± 43%  interrupts.CPU150.NMI:Non-maskable_interrupts
      2026 ± 69%     -83.3%     338.50 ± 43%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     43636 ±  3%     -23.0%      33608 ± 15%  interrupts.CPU151.LOC:Local_timer_interrupts
     43624 ±  3%     -22.9%      33620 ± 15%  interrupts.CPU152.LOC:Local_timer_interrupts
     43640 ±  3%     -22.9%      33632 ± 15%  interrupts.CPU153.LOC:Local_timer_interrupts
     43625 ±  2%     -22.8%      33676 ± 14%  interrupts.CPU154.LOC:Local_timer_interrupts
     43634 ±  3%     -22.8%      33673 ± 15%  interrupts.CPU155.LOC:Local_timer_interrupts
     43650 ±  3%     -22.9%      33674 ± 15%  interrupts.CPU156.LOC:Local_timer_interrupts
     43636 ±  2%     -22.8%      33703 ± 14%  interrupts.CPU157.LOC:Local_timer_interrupts
     43643 ±  3%     -22.9%      33634 ± 15%  interrupts.CPU158.LOC:Local_timer_interrupts
     43635 ±  3%     -22.9%      33653 ± 15%  interrupts.CPU159.LOC:Local_timer_interrupts
     43657 ±  3%     -27.5%      31642 ± 20%  interrupts.CPU16.LOC:Local_timer_interrupts
     43619 ±  3%     -22.9%      33638 ± 15%  interrupts.CPU160.LOC:Local_timer_interrupts
     43626 ±  3%     -22.8%      33681 ± 14%  interrupts.CPU161.LOC:Local_timer_interrupts
     43637 ±  3%     -23.0%      33618 ± 15%  interrupts.CPU162.LOC:Local_timer_interrupts
     43661 ±  2%     -22.8%      33702 ± 15%  interrupts.CPU163.LOC:Local_timer_interrupts
     43633 ±  3%     -22.9%      33622 ± 15%  interrupts.CPU164.LOC:Local_timer_interrupts
     43644 ±  3%     -23.0%      33619 ± 15%  interrupts.CPU165.LOC:Local_timer_interrupts
     43656 ±  3%     -23.0%      33616 ± 15%  interrupts.CPU166.LOC:Local_timer_interrupts
     43631 ±  3%     -23.0%      33610 ± 15%  interrupts.CPU167.LOC:Local_timer_interrupts
     43654 ±  3%     -18.5%      35595 ±  2%  interrupts.CPU168.LOC:Local_timer_interrupts
     43646 ±  3%     -18.4%      35606 ±  2%  interrupts.CPU169.LOC:Local_timer_interrupts
     43490 ±  2%     -27.4%      31557 ± 20%  interrupts.CPU17.LOC:Local_timer_interrupts
     43658 ±  3%     -18.5%      35598 ±  2%  interrupts.CPU170.LOC:Local_timer_interrupts
      3681 ± 32%     -89.5%     386.50 ± 95%  interrupts.CPU170.NMI:Non-maskable_interrupts
      3681 ± 32%     -89.5%     386.50 ± 95%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
     43634 ±  3%     -18.4%      35614 ±  2%  interrupts.CPU171.LOC:Local_timer_interrupts
     43637 ±  3%     -18.5%      35555 ±  2%  interrupts.CPU172.LOC:Local_timer_interrupts
     43614 ±  3%     -18.4%      35603 ±  2%  interrupts.CPU173.LOC:Local_timer_interrupts
     43628 ±  3%     -18.4%      35598 ±  2%  interrupts.CPU174.LOC:Local_timer_interrupts
     43625 ±  3%     -18.4%      35579 ±  2%  interrupts.CPU175.LOC:Local_timer_interrupts
     43634 ±  3%     -18.4%      35616 ±  2%  interrupts.CPU176.LOC:Local_timer_interrupts
     43630 ±  3%     -18.4%      35613 ±  2%  interrupts.CPU177.LOC:Local_timer_interrupts
     43626 ±  3%     -18.4%      35598 ±  2%  interrupts.CPU178.LOC:Local_timer_interrupts
     43577 ±  3%     -18.2%      35624 ±  2%  interrupts.CPU179.LOC:Local_timer_interrupts
     43698 ±  3%     -27.6%      31622 ± 20%  interrupts.CPU18.LOC:Local_timer_interrupts
      3408 ± 48%     -83.6%     560.17 ± 78%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3408 ± 48%     -83.6%     560.17 ± 78%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     43627 ±  3%     -18.4%      35600 ±  2%  interrupts.CPU180.LOC:Local_timer_interrupts
     43624 ±  3%     -18.4%      35593 ±  2%  interrupts.CPU181.LOC:Local_timer_interrupts
     43622 ±  3%     -18.4%      35609 ±  2%  interrupts.CPU182.LOC:Local_timer_interrupts
     43635 ±  3%     -18.4%      35597 ±  2%  interrupts.CPU183.LOC:Local_timer_interrupts
     43621 ±  3%     -18.4%      35586 ±  2%  interrupts.CPU184.LOC:Local_timer_interrupts
     43617 ±  3%     -18.4%      35590 ±  2%  interrupts.CPU185.LOC:Local_timer_interrupts
     43623 ±  3%     -18.4%      35604 ±  2%  interrupts.CPU186.LOC:Local_timer_interrupts
     43627 ±  3%     -18.5%      35566 ±  2%  interrupts.CPU187.LOC:Local_timer_interrupts
     43625 ±  3%     -18.4%      35598 ±  2%  interrupts.CPU188.LOC:Local_timer_interrupts
      1273 ± 88%     -76.3%     302.00 ± 59%  interrupts.CPU188.NMI:Non-maskable_interrupts
      1273 ± 88%     -76.3%     302.00 ± 59%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
     43630 ±  3%     -18.4%      35591 ±  2%  interrupts.CPU189.LOC:Local_timer_interrupts
     43624 ±  3%     -27.5%      31641 ± 20%  interrupts.CPU19.LOC:Local_timer_interrupts
     43628 ±  3%     -18.5%      35565 ±  2%  interrupts.CPU190.LOC:Local_timer_interrupts
     43625 ±  3%     -18.4%      35613 ±  2%  interrupts.CPU191.LOC:Local_timer_interrupts
     43678 ±  3%     -27.5%      31672 ± 20%  interrupts.CPU2.LOC:Local_timer_interrupts
     43709 ±  3%     -27.7%      31619 ± 20%  interrupts.CPU20.LOC:Local_timer_interrupts
     43685 ±  3%     -27.7%      31589 ± 20%  interrupts.CPU21.LOC:Local_timer_interrupts
     43680 ±  3%     -27.5%      31678 ± 20%  interrupts.CPU22.LOC:Local_timer_interrupts
      2808 ± 47%     -82.2%     498.83 ± 66%  interrupts.CPU22.NMI:Non-maskable_interrupts
      2808 ± 47%     -82.2%     498.83 ± 66%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     43681 ±  3%     -27.6%      31618 ± 20%  interrupts.CPU23.LOC:Local_timer_interrupts
     43614 ±  3%     -23.6%      33304 ± 16%  interrupts.CPU24.LOC:Local_timer_interrupts
      3276 ± 27%     -80.0%     654.00 ± 69%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3276 ± 27%     -80.0%     654.00 ± 69%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     43680 ±  3%     -23.6%      33363 ± 16%  interrupts.CPU25.LOC:Local_timer_interrupts
      2407 ± 23%     -84.5%     372.17 ± 71%  interrupts.CPU25.NMI:Non-maskable_interrupts
      2407 ± 23%     -84.5%     372.17 ± 71%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     43699 ±  3%     -23.7%      33324 ± 16%  interrupts.CPU26.LOC:Local_timer_interrupts
     43671 ±  3%     -23.6%      33353 ± 16%  interrupts.CPU27.LOC:Local_timer_interrupts
     43687 ±  3%     -23.7%      33338 ± 15%  interrupts.CPU28.LOC:Local_timer_interrupts
     43715 ±  3%     -23.7%      33368 ± 15%  interrupts.CPU29.LOC:Local_timer_interrupts
     43703 ±  3%     -27.6%      31659 ± 20%  interrupts.CPU3.LOC:Local_timer_interrupts
      4683 ± 30%     -88.9%     518.33 ± 30%  interrupts.CPU3.NMI:Non-maskable_interrupts
      4683 ± 30%     -88.9%     518.33 ± 30%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     43683 ±  3%     -23.5%      33419 ± 15%  interrupts.CPU30.LOC:Local_timer_interrupts
     43681 ±  3%     -23.6%      33371 ± 15%  interrupts.CPU31.LOC:Local_timer_interrupts
     43694 ±  3%     -23.6%      33391 ± 15%  interrupts.CPU32.LOC:Local_timer_interrupts
     43692 ±  3%     -23.7%      33323 ± 15%  interrupts.CPU33.LOC:Local_timer_interrupts
     43687 ±  3%     -23.7%      33352 ± 15%  interrupts.CPU34.LOC:Local_timer_interrupts
     43705 ±  3%     -23.7%      33360 ± 16%  interrupts.CPU35.LOC:Local_timer_interrupts
     43687 ±  3%     -23.5%      33417 ± 15%  interrupts.CPU36.LOC:Local_timer_interrupts
     43694 ±  3%     -23.6%      33379 ± 15%  interrupts.CPU37.LOC:Local_timer_interrupts
     43691 ±  3%     -23.5%      33412 ± 15%  interrupts.CPU38.LOC:Local_timer_interrupts
     43686 ±  3%     -23.5%      33426 ± 15%  interrupts.CPU39.LOC:Local_timer_interrupts
     43626 ±  3%     -27.5%      31626 ± 20%  interrupts.CPU4.LOC:Local_timer_interrupts
      4936 ± 14%     -87.0%     640.67 ± 56%  interrupts.CPU4.NMI:Non-maskable_interrupts
      4936 ± 14%     -87.0%     640.67 ± 56%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     43670 ±  3%     -23.5%      33413 ± 15%  interrupts.CPU40.LOC:Local_timer_interrupts
     43703 ±  3%     -23.5%      33415 ± 15%  interrupts.CPU41.LOC:Local_timer_interrupts
     43705 ±  3%     -23.7%      33351 ± 16%  interrupts.CPU42.LOC:Local_timer_interrupts
     43724 ±  3%     -23.8%      33330 ± 16%  interrupts.CPU43.LOC:Local_timer_interrupts
     43718 ±  2%     -23.7%      33366 ± 16%  interrupts.CPU44.LOC:Local_timer_interrupts
     43705 ±  3%     -23.7%      33336 ± 16%  interrupts.CPU45.LOC:Local_timer_interrupts
     43687 ±  3%     -23.5%      33442 ± 15%  interrupts.CPU46.LOC:Local_timer_interrupts
     43701 ±  3%     -23.5%      33444 ± 15%  interrupts.CPU47.LOC:Local_timer_interrupts
     43681 ±  3%     -23.0%      33628 ± 15%  interrupts.CPU48.LOC:Local_timer_interrupts
      3757 ± 23%     -71.0%       1091 ± 59%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3757 ± 23%     -71.0%       1091 ± 59%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     43691 ±  3%     -23.1%      33611 ± 14%  interrupts.CPU49.LOC:Local_timer_interrupts
     43701 ±  3%     -27.5%      31689 ± 20%  interrupts.CPU5.LOC:Local_timer_interrupts
      5126 ±  3%     -89.6%     535.33 ± 56%  interrupts.CPU5.NMI:Non-maskable_interrupts
      5126 ±  3%     -89.6%     535.33 ± 56%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     43691 ±  3%     -22.8%      33715 ± 14%  interrupts.CPU50.LOC:Local_timer_interrupts
      3171 ± 56%     -85.7%     454.83 ± 43%  interrupts.CPU50.NMI:Non-maskable_interrupts
      3171 ± 56%     -85.7%     454.83 ± 43%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     43681 ±  3%     -22.9%      33659 ± 15%  interrupts.CPU51.LOC:Local_timer_interrupts
     43710 ±  3%     -23.0%      33667 ± 15%  interrupts.CPU52.LOC:Local_timer_interrupts
     43700 ±  3%     -23.0%      33661 ± 15%  interrupts.CPU53.LOC:Local_timer_interrupts
      1977 ± 56%     -79.0%     415.33 ± 53%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1977 ± 56%     -79.0%     415.33 ± 53%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     43697 ±  3%     -23.0%      33657 ± 15%  interrupts.CPU54.LOC:Local_timer_interrupts
      2978 ± 51%     -89.3%     319.50 ± 80%  interrupts.CPU54.NMI:Non-maskable_interrupts
      2978 ± 51%     -89.3%     319.50 ± 80%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     43679 ±  3%     -22.9%      33686 ± 15%  interrupts.CPU55.LOC:Local_timer_interrupts
     43667 ±  3%     -22.9%      33659 ± 15%  interrupts.CPU56.LOC:Local_timer_interrupts
     43698 ±  3%     -22.9%      33683 ± 14%  interrupts.CPU57.LOC:Local_timer_interrupts
     43698 ±  3%     -22.9%      33701 ± 14%  interrupts.CPU58.LOC:Local_timer_interrupts
      3686 ± 47%     -88.3%     431.33 ± 50%  interrupts.CPU58.NMI:Non-maskable_interrupts
      3686 ± 47%     -88.3%     431.33 ± 50%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     43679 ±  3%     -22.8%      33706 ± 14%  interrupts.CPU59.LOC:Local_timer_interrupts
     43688 ±  3%     -27.5%      31662 ± 20%  interrupts.CPU6.LOC:Local_timer_interrupts
      4053 ± 30%     -88.1%     483.33 ± 61%  interrupts.CPU6.NMI:Non-maskable_interrupts
      4053 ± 30%     -88.1%     483.33 ± 61%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     43668 ±  3%     -22.8%      33710 ± 14%  interrupts.CPU60.LOC:Local_timer_interrupts
     43678 ±  3%     -22.7%      33751 ± 14%  interrupts.CPU61.LOC:Local_timer_interrupts
     43656 ±  3%     -22.8%      33691 ± 15%  interrupts.CPU62.LOC:Local_timer_interrupts
     43683 ±  3%     -22.9%      33672 ± 15%  interrupts.CPU63.LOC:Local_timer_interrupts
     43647 ±  3%     -22.8%      33675 ± 15%  interrupts.CPU64.LOC:Local_timer_interrupts
     43666 ±  3%     -22.8%      33722 ± 14%  interrupts.CPU65.LOC:Local_timer_interrupts
     43658 ±  3%     -22.8%      33697 ± 15%  interrupts.CPU66.LOC:Local_timer_interrupts
     43658 ±  3%     -22.8%      33695 ± 14%  interrupts.CPU67.LOC:Local_timer_interrupts
     43697 ±  3%     -23.0%      33668 ± 15%  interrupts.CPU68.LOC:Local_timer_interrupts
     43677 ±  3%     -22.9%      33660 ± 15%  interrupts.CPU69.LOC:Local_timer_interrupts
     43711 ±  3%     -27.7%      31604 ± 20%  interrupts.CPU7.LOC:Local_timer_interrupts
      4583 ± 19%     -84.9%     691.33 ±100%  interrupts.CPU7.NMI:Non-maskable_interrupts
      4583 ± 19%     -84.9%     691.33 ±100%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     43704 ±  3%     -23.2%      33580 ± 15%  interrupts.CPU70.LOC:Local_timer_interrupts
     43675 ±  3%     -23.0%      33621 ± 15%  interrupts.CPU71.LOC:Local_timer_interrupts
     43661 ±  3%     -18.6%      35555 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      3963 ± 27%     -64.6%       1401 ± 86%  interrupts.CPU72.NMI:Non-maskable_interrupts
      3963 ± 27%     -64.6%       1401 ± 86%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     43677 ±  3%     -18.6%      35551        interrupts.CPU73.LOC:Local_timer_interrupts
     43678 ±  3%     -18.4%      35647 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      2995 ± 25%     -89.0%     328.50 ± 63%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2995 ± 25%     -89.0%     328.50 ± 63%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     43685 ±  3%     -18.4%      35647 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
     43680 ±  3%     -18.5%      35617 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
     43673 ±  3%     -18.4%      35634 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
     43689 ±  3%     -18.4%      35645 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
     43689 ±  3%     -18.5%      35620 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
     43620 ±  3%     -27.4%      31658 ± 20%  interrupts.CPU8.LOC:Local_timer_interrupts
      4343 ± 43%     -89.0%     479.50 ± 62%  interrupts.CPU8.NMI:Non-maskable_interrupts
      4343 ± 43%     -89.0%     479.50 ± 62%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     43675 ±  3%     -18.5%      35607 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
     43662 ±  3%     -18.4%      35630 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
     43674 ±  3%     -18.4%      35624 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
     43650 ±  3%     -18.4%      35610 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
     43650 ±  3%     -18.4%      35632 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
     43664 ±  3%     -18.4%      35630 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
     43651 ±  3%     -18.4%      35616 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
     43655 ±  3%     -18.4%      35607 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
     43689 ±  3%     -18.4%      35649 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
      2419 ± 83%     -92.0%     193.83 ± 85%  interrupts.CPU88.NMI:Non-maskable_interrupts
      2419 ± 83%     -92.0%     193.83 ± 85%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     43663 ±  3%     -18.4%      35624 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
     43717 ±  3%     -27.6%      31645 ± 20%  interrupts.CPU9.LOC:Local_timer_interrupts
      3902 ± 40%     -86.0%     546.17 ± 61%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3902 ± 40%     -86.0%     546.17 ± 61%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     43673 ±  3%     -18.4%      35621 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
     43665 ±  3%     -18.4%      35610 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
      2203 ± 95%     -89.4%     233.83 ± 55%  interrupts.CPU91.NMI:Non-maskable_interrupts
      2203 ± 95%     -89.4%     233.83 ± 55%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     43627 ±  3%     -18.4%      35600 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
     43679 ±  3%     -18.4%      35635 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
     43700 ±  3%     -18.5%      35626 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
     43687 ±  3%     -18.4%      35651 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
     43581 ±  2%     -27.6%      31565 ± 20%  interrupts.CPU96.LOC:Local_timer_interrupts
      4566 ± 19%     -81.7%     835.33 ±106%  interrupts.CPU96.NMI:Non-maskable_interrupts
      4566 ± 19%     -81.7%     835.33 ±106%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
     43615 ±  3%     -27.6%      31566 ± 20%  interrupts.CPU97.LOC:Local_timer_interrupts
     43588 ±  3%     -27.3%      31677 ± 20%  interrupts.CPU98.LOC:Local_timer_interrupts
      2551 ± 45%     -62.9%     946.00 ±104%  interrupts.CPU98.NMI:Non-maskable_interrupts
      2551 ± 45%     -62.9%     946.00 ±104%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     43651 ±  3%     -27.5%      31637 ± 20%  interrupts.CPU99.LOC:Local_timer_interrupts
      4410 ± 43%     -87.9%     532.83 ± 48%  interrupts.CPU99.NMI:Non-maskable_interrupts
      4410 ± 43%     -87.9%     532.83 ± 48%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
   8381969 ±  3%     -23.1%    6442917 ± 10%  interrupts.LOC:Local_timer_interrupts
    498959 ± 10%     -79.5%     102272 ± 13%  interrupts.NMI:Non-maskable_interrupts
    498959 ± 10%     -79.5%     102272 ± 13%  interrupts.PMI:Performance_monitoring_interrupts
     60.34 ± 10%     -29.5       30.82 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
     60.36 ± 10%     -29.5       30.88 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     60.36 ± 10%     -29.5       30.89 ± 10%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.39 ± 10%     -29.5       30.92 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.38 ± 10%     -29.5       30.91 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.84 ± 10%     -27.3       33.51 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.86 ± 10%     -27.3       33.53 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     27.65 ± 11%     -19.4        8.26 ± 18%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
     27.70 ± 11%     -19.4        8.30 ± 18%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
     27.74 ± 11%     -19.2        8.52 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     27.75 ± 11%     -19.2        8.52 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     31.00 ± 10%     -10.7       20.26 ±  8%  perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
     31.01 ± 10%     -10.7       20.27 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     31.06 ± 10%     -10.7       20.36 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     30.08 ± 10%     -10.6       19.51 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     30.14 ± 10%     -10.5       19.61 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      0.00            +0.8        0.81 ± 18%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.82 ± 18%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.9        0.85 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_end_bio.brd_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio
      0.00            +0.9        0.94 ± 20%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.0        0.97 ± 30%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.0        1.03 ± 33%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.0        1.04 ± 16%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.2        1.19 ± 29%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.2        1.25 ± 24%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work
      0.00            +1.2        1.25 ± 24%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn
      0.00            +1.3        1.25 ± 25%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.3        1.25 ± 25%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
      0.00            +1.3        1.25 ± 25%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work.worker_thread
      0.00            +1.3        1.25 ± 22%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.10 ±223%      +1.5        1.60 ± 18%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_single_inode.start_delalloc_inodes.btrfs_start_delalloc_roots.flush_space
      0.10 ±223%      +1.5        1.60 ± 18%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_single_inode.start_delalloc_inodes.btrfs_start_delalloc_roots
      0.10 ±223%      +1.5        1.60 ± 18%  perf-profile.calltrace.cycles-pp.start_delalloc_inodes.btrfs_start_delalloc_roots.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      0.10 ±223%      +1.5        1.60 ± 18%  perf-profile.calltrace.cycles-pp.writeback_single_inode.start_delalloc_inodes.btrfs_start_delalloc_roots.flush_space.btrfs_preempt_reclaim_metadata_space
      0.10 ±223%      +1.5        1.61 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_start_delalloc_roots.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      0.10 ±223%      +1.5        1.63 ± 18%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread
      0.10 ±223%      +1.5        1.63 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.8        1.77 ± 29%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.1        2.09 ± 13%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.tlb_flush_mmu
      0.00            +2.1        2.09 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu
      0.00            +2.1        2.09 ± 13%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu.exit_mmap
      0.00            +2.2        2.17 ± 14%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput
      0.00            +2.2        2.17 ± 14%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.do_exit.do_group_exit
      0.00            +2.2        2.17 ± 14%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.do_exit
      0.00            +2.4        2.36 ± 13%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +2.4        2.36 ± 13%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +2.4        2.38 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.4        2.38 ± 13%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.4        2.38 ± 13%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ±141%      +3.2        3.39 ± 21%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.22 ±141%      +3.2        3.44 ± 21%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.24 ±142%      +4.0        4.24 ± 27%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.83 ± 23%      +5.2        6.05 ± 15%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
     34.32 ± 19%      +6.2       40.50 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      1.10 ± 15%      +6.7        7.81 ± 23%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_submit_bio.submit_bio_noacct.submit_bio.btrfs_map_bio
      1.65 ± 13%      +7.9        9.57 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
     34.63 ± 19%      +8.5       43.17 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.15 ± 20%     +10.4       11.59 ± 24%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      2.46 ± 10%     +11.1       13.51 ± 11%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      2.47 ± 10%     +11.1       13.58 ± 11%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      2.47 ± 10%     +11.2       13.63 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork
      2.47 ± 10%     +11.2       13.63 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     35.19 ± 18%     +12.8       47.94 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.19 ± 18%     +12.8       47.95 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.19 ± 18%     +12.8       47.95 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     35.61 ± 18%     +12.8       48.40 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     60.36 ± 10%     -29.5       30.88 ± 10%  perf-profile.children.cycles-pp.btrfs_file_write_iter
     60.34 ± 10%     -29.5       30.87 ± 10%  perf-profile.children.cycles-pp.btrfs_buffered_write
     60.44 ± 10%     -29.2       31.26 ± 10%  perf-profile.children.cycles-pp.new_sync_write
     60.46 ± 10%     -29.2       31.29 ± 10%  perf-profile.children.cycles-pp.ksys_write
     60.46 ± 10%     -29.2       31.29 ± 10%  perf-profile.children.cycles-pp.vfs_write
     58.58 ± 10%     -28.0       30.60 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     59.06 ± 10%     -27.4       31.61 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
     60.95 ± 10%     -26.9       34.04 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
     60.98 ± 10%     -26.9       34.09 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     28.23 ± 11%     -19.5        8.73 ± 17%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
     27.78 ± 11%     -19.2        8.54 ± 17%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
     31.13 ± 10%     -10.8       20.35 ±  8%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     31.17 ± 10%     -10.7       20.43 ±  8%  perf-profile.children.cycles-pp.__reserve_bytes
     31.06 ± 10%     -10.7       20.36 ±  8%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.74 ±  7%      -0.3        0.42 ± 17%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.32 ± 26%      -0.3        0.05 ± 78%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      0.35 ± 24%      -0.2        0.13 ± 48%  perf-profile.children.cycles-pp.__btrfs_commit_inode_delayed_items
      0.23 ± 24%      -0.1        0.09 ± 47%  perf-profile.children.cycles-pp.btrfs_delayed_inode_release_metadata
      0.24 ± 23%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.25 ± 10%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.btrfs_create
      0.24 ±  4%      -0.1        0.13 ± 15%  perf-profile.children.cycles-pp.cpumask_next
      0.26 ± 10%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.do_filp_open
      0.26 ± 10%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.path_openat
      0.26 ± 10%      -0.1        0.16 ± 14%  perf-profile.children.cycles-pp.do_sys_open
      0.26 ± 10%      -0.1        0.16 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.sys_imageblit
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.03 ± 99%      +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.bit_putcs
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.lf
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.__btrfs_run_delayed_items
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.radix_tree_insert
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.btrfs_find_delalloc_range
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.btrfs_dec_test_ordered_pending
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.10 ± 43%  perf-profile.children.cycles-pp.account_process_tick
      0.08 ±  9%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.11 ± 36%  perf-profile.children.cycles-pp.crc_40
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.printk
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.__radix_tree_preload
      0.05 ± 46%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.02 ±141%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.12 ± 42%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.43 ± 10%      +0.1        0.56 ± 15%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.13 ± 22%  perf-profile.children.cycles-pp.__wake_up_common
      0.05 ± 47%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.07 ± 10%      +0.1        0.22 ± 54%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.1        0.15 ± 36%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.02 ±141%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.16 ± 45%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.00            +0.2        0.16 ± 10%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.02 ±141%      +0.2        0.18 ± 14%  perf-profile.children.cycles-pp.find_get_pages_contig
      0.00            +0.2        0.16 ± 13%  perf-profile.children.cycles-pp.btrfs_writepage_endio_finish_ordered
      0.00            +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.01 ±223%      +0.2        0.18 ± 19%  perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±223%      +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      0.01 ±223%      +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.cow_file_range
      0.00            +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.schedule
      0.08 ± 20%      +0.2        0.28 ±  8%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.2        0.20 ± 28%  perf-profile.children.cycles-pp.btrfs_try_granting_tickets
      0.00            +0.2        0.20 ± 16%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.2        0.21 ± 16%  perf-profile.children.cycles-pp.sched_clock
      0.02 ±141%      +0.2        0.23 ± 36%  perf-profile.children.cycles-pp.crc_41
      0.02 ±141%      +0.2        0.24 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.2        0.23 ± 16%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.06 ± 13%      +0.2        0.29 ± 16%  perf-profile.children.cycles-pp.io_serial_in
      0.02 ±141%      +0.2        0.26 ± 14%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.2        0.24 ± 15%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.05 ±  8%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.06 ± 21%      +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.08 ± 12%      +0.3        0.33 ± 28%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.01 ±223%      +0.3        0.27 ± 24%  perf-profile.children.cycles-pp.__schedule
      0.06 ± 14%      +0.3        0.33 ± 19%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.09 ± 18%      +0.3        0.36 ± 15%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.07 ± 13%      +0.3        0.36 ± 19%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.04 ± 73%      +0.3        0.33 ± 55%  perf-profile.children.cycles-pp._raw_read_lock
      0.07 ± 12%      +0.3        0.36 ± 20%  perf-profile.children.cycles-pp.uart_console_write
      0.07 ± 14%      +0.3        0.36 ± 15%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.07 ± 14%      +0.3        0.36 ± 15%  perf-profile.children.cycles-pp.devkmsg_emit
      0.07 ± 15%      +0.3        0.37 ± 17%  perf-profile.children.cycles-pp.memcpy_toio
      0.02 ±141%      +0.3        0.32 ± 27%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.07 ± 13%      +0.3        0.37 ± 15%  perf-profile.children.cycles-pp.write
      0.03 ±100%      +0.3        0.33 ± 16%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±142%      +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.load_balance
      0.10 ± 15%      +0.3        0.41 ± 13%  perf-profile.children.cycles-pp.__process_pages_contig
      0.08 ± 14%      +0.3        0.39 ± 19%  perf-profile.children.cycles-pp.serial8250_console_write
      0.04 ± 72%      +0.3        0.37 ± 29%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.06 ± 17%      +0.3        0.40 ± 26%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ± 11%      +0.4        0.46 ± 13%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.09 ± 12%      +0.4        0.47 ± 16%  perf-profile.children.cycles-pp.console_unlock
      0.09 ± 12%      +0.4        0.47 ± 16%  perf-profile.children.cycles-pp.vprintk_emit
      0.09 ± 22%      +0.4        0.48 ± 27%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.19 ± 13%      +0.4        0.60 ± 28%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ± 19%      +0.4        0.51 ±  9%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.10 ± 32%      +0.4        0.54 ± 14%  perf-profile.children.cycles-pp.clear_page_erms
      0.14 ± 16%      +0.4        0.57 ± 13%  perf-profile.children.cycles-pp.writepage_delalloc
      0.06 ± 52%      +0.4        0.51 ± 34%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.11 ± 34%      +0.5        0.59 ± 12%  perf-profile.children.cycles-pp.prep_new_page
      0.10 ± 22%      +0.5        0.59 ± 10%  perf-profile.children.cycles-pp.end_page_writeback
      0.10 ± 27%      +0.6        0.66 ± 28%  perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
      0.09 ± 23%      +0.6        0.66 ± 22%  perf-profile.children.cycles-pp.rebalance_domains
      0.12 ± 30%      +0.6        0.73 ± 40%  perf-profile.children.cycles-pp.submit_extent_page
      0.11 ± 20%      +0.7        0.82 ± 18%  perf-profile.children.cycles-pp.tick_irq_enter
      0.14 ± 21%      +0.7        0.85 ± 11%  perf-profile.children.cycles-pp.btrfs_end_bio
      0.11 ± 21%      +0.7        0.83 ± 18%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.11 ± 28%      +0.7        0.83 ± 28%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.23 ± 25%      +0.7        0.95 ± 10%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.26 ± 24%      +0.8        1.05 ± 10%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.13 ± 28%      +0.8        0.95 ± 27%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.32 ± 20%      +0.8        1.14 ± 27%  perf-profile.children.cycles-pp.update_process_times
      0.27 ± 25%      +0.8        1.12 ± 13%  perf-profile.children.cycles-pp.clockevents_program_event
      0.14 ± 27%      +0.8        0.99 ± 20%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.32 ± 20%      +0.9        1.20 ± 29%  perf-profile.children.cycles-pp.tick_sched_handle
      0.36 ± 21%      +1.0        1.38 ± 26%  perf-profile.children.cycles-pp.tick_sched_timer
      0.17 ± 28%      +1.1        1.25 ± 25%  perf-profile.children.cycles-pp.wb_workfn
      0.17 ± 28%      +1.1        1.25 ± 25%  perf-profile.children.cycles-pp.wb_writeback
      0.17 ± 28%      +1.1        1.25 ± 25%  perf-profile.children.cycles-pp.writeback_sb_inodes
      0.20 ± 24%      +1.1        1.32 ± 22%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.46 ± 15%      +1.2        1.63 ± 18%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      0.46 ± 15%      +1.2        1.68 ± 16%  perf-profile.children.cycles-pp.writeback_single_inode
      0.46 ± 15%      +1.2        1.68 ± 16%  perf-profile.children.cycles-pp.start_delalloc_inodes
      0.33 ± 16%      +1.3        1.67 ± 22%  perf-profile.children.cycles-pp.__extent_writepage_io
      0.46 ± 15%      +1.4        1.82 ± 17%  perf-profile.children.cycles-pp.btrfs_start_delalloc_roots
      0.50 ± 13%      +1.5        1.97 ± 16%  perf-profile.children.cycles-pp.flush_space
      0.46 ± 21%      +1.5        2.00 ± 26%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.39 ± 26%      +1.6        1.98 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.49 ± 15%      +1.9        2.36 ± 18%  perf-profile.children.cycles-pp.__extent_writepage
      0.13 ±115%      +2.0        2.10 ± 13%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.13 ±114%      +2.0        2.18 ± 14%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.13 ±114%      +2.0        2.18 ± 14%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.14 ±112%      +2.1        2.23 ± 14%  perf-profile.children.cycles-pp.release_pages
      0.15 ±109%      +2.2        2.37 ± 13%  perf-profile.children.cycles-pp.mmput
      0.15 ±109%      +2.2        2.37 ± 13%  perf-profile.children.cycles-pp.exit_mmap
      0.15 ±109%      +2.2        2.38 ± 13%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.15 ±109%      +2.2        2.38 ± 13%  perf-profile.children.cycles-pp.do_group_exit
      0.15 ±109%      +2.2        2.38 ± 13%  perf-profile.children.cycles-pp.do_exit
      0.24 ± 56%      +2.2        2.49 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.62 ± 14%      +2.3        2.91 ± 18%  perf-profile.children.cycles-pp.extent_write_cache_pages
      0.63 ± 14%      +2.3        2.93 ± 18%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.63 ± 14%      +2.3        2.93 ± 18%  perf-profile.children.cycles-pp.do_writepages
      0.84 ± 22%      +2.9        3.73 ± 19%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.85 ± 21%      +2.9        3.77 ± 19%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.49 ± 33%      +3.8        4.27 ± 27%  perf-profile.children.cycles-pp.menu_select
      1.24 ± 21%      +5.2        6.46 ± 14%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.11 ± 15%      +7.3        8.45 ± 12%  perf-profile.children.cycles-pp.brd_do_bvec
      1.59 ± 18%      +7.7        9.33 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.65 ± 13%      +7.9        9.57 ± 12%  perf-profile.children.cycles-pp.btrfs_work_helper
      1.25 ± 15%      +8.1        9.32 ± 12%  perf-profile.children.cycles-pp.brd_submit_bio
      1.25 ± 15%      +8.1        9.32 ± 12%  perf-profile.children.cycles-pp.submit_bio
      1.25 ± 15%      +8.1        9.32 ± 12%  perf-profile.children.cycles-pp.submit_bio_noacct
      1.25 ± 15%      +8.1        9.32 ± 12%  perf-profile.children.cycles-pp.btrfs_map_bio
     35.05 ± 19%      +8.5       43.58 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     35.05 ± 19%      +8.5       43.59 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      2.46 ± 10%     +11.1       13.51 ± 11%  perf-profile.children.cycles-pp.process_one_work
      2.47 ± 10%     +11.1       13.58 ± 11%  perf-profile.children.cycles-pp.worker_thread
      2.47 ± 10%     +11.2       13.63 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
      2.47 ± 10%     +11.2       13.63 ± 11%  perf-profile.children.cycles-pp.kthread
     35.19 ± 18%     +12.8       47.95 ±  4%  perf-profile.children.cycles-pp.start_secondary
     35.61 ± 18%     +12.8       48.39 ±  4%  perf-profile.children.cycles-pp.do_idle
     35.61 ± 18%     +12.8       48.40 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.61 ± 18%     +12.8       48.40 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     58.21 ± 10%     -27.9       30.36 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.47 ±  8%      -0.2        0.26 ± 18%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.03 ± 99%      +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.sys_imageblit
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.extent_write_cache_pages
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.btrfs_csum_one_bio
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__extent_writepage_io
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.radix_tree_insert
      0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.07 ± 33%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.pagecache_get_page
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.__radix_tree_preload
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__extent_writepage
      0.00            +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
      0.00            +0.1        0.10 ± 41%  perf-profile.self.cycles-pp.account_process_tick
      0.00            +0.1        0.10 ± 29%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.10 ± 21%  perf-profile.self.cycles-pp.end_bio_extent_writepage
      0.03 ±100%      +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.12 ± 35%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.do_idle
      0.06 ± 11%      +0.1        0.20 ± 58%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.14 ± 21%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.02 ±141%      +0.1        0.16 ± 12%  perf-profile.self.cycles-pp.__process_pages_contig
      0.01 ±223%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.00            +0.2        0.15 ± 46%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.00            +0.2        0.16 ± 16%  perf-profile.self.cycles-pp.find_get_pages_contig
      0.02 ±149%      +0.2        0.18 ± 36%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.2        0.17 ± 13%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.18 ± 30%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.2        0.19 ± 16%  perf-profile.self.cycles-pp.native_sched_clock
      0.02 ±141%      +0.2        0.23 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.05 ± 50%      +0.2        0.28 ± 20%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 13%      +0.2        0.29 ± 16%  perf-profile.self.cycles-pp.io_serial_in
      0.05 ±  8%      +0.2        0.30 ± 10%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.11 ± 13%      +0.3        0.38 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.03 ±102%      +0.3        0.33 ± 54%  perf-profile.self.cycles-pp._raw_read_lock
      0.07 ± 12%      +0.3        0.37 ± 17%  perf-profile.self.cycles-pp.memcpy_toio
      0.07 ± 25%      +0.3        0.39 ± 32%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.04 ± 72%      +0.3        0.37 ± 29%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.06 ± 17%      +0.3        0.40 ± 26%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 32%      +0.4        0.53 ± 14%  perf-profile.self.cycles-pp.clear_page_erms
      0.06 ± 52%      +0.4        0.50 ± 34%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.37 ± 26%      +1.4        1.78 ± 18%  perf-profile.self.cycles-pp.ktime_get
      0.59 ±  6%      +2.5        3.07 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
      0.35 ± 39%      +2.9        3.22 ± 31%  perf-profile.self.cycles-pp.menu_select
      0.57 ± 11%      +3.9        4.46 ± 11%  perf-profile.self.cycles-pp.brd_do_bvec
      0.60 ± 27%      +4.6        5.18 ± 37%  perf-profile.self.cycles-pp.cpuidle_enter_state


                                                                                
                              fsmark.time.system_time                           
                                                                                
  550 +---------------------------------------------------------------------+   
      |.+     .+                           .+     +. .+.    .+            +.|   
  500 |-++.+.+  +.+.++.+.++.+.+.++.+.++.+.+  +.+.+  +   ++.+  +.+.++.+.+.+  |   
  450 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  350 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      | O    O    O  O O O  O   O  O  O   O                                 |   
  150 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fsmark.time.percent_of_cpu_this_job_got                   
                                                                                
  2800 +--------------------------------------------------------------------+   
  2600 |-+     ::  +                              ::        : :             |   
       |.+    : : + +. .+.+   .++. .++. .+ .+.    : :.+.    : :       .+. +.|   
  2400 |-++.+.+  +    +    +.+    +    +  +   ++.+  +   ++.+   ++.+.++   +  |   
  2200 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1800 |-+                                                                  |   
  1600 |-+                                                                  |   
       |                                                                    |   
  1400 |-+                                                                  |   
  1200 |-+                                                                  |   
       | O    O    O  O O    O  O      O  O                                 |   
  1000 |-+O O  O O  O     OO   O  O OO   O  O                               |   
   800 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fsmark.time.involuntary_context_switches                   
                                                                                
  2000 +--------------------------------------------------------------------+   
       |                                                                    |   
  1800 |-+                           +      +         +                     |   
  1600 |++:       .+                 ::    + +       + +         .+.        |   
       |  +. .++.+  +.+.+.++.+.++.+.+ : .++   + .+.++   + .+.+. +   ++. .+ .|   
  1400 |-+  +                          +       +         +     +       +  + |   
       |                                                                    |   
  1200 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-O    O    O    O  O O    O  O O    O                               |   
       |  O O  O O  O O   O    OO   O    OO                                 |   
   400 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               fsmark.files_per_sec                             
                                                                                
  1700 +--------------------------------------------------------------------+   
  1600 |-O         O                                                        |   
       |  O    O    O           O         O                                 |   
  1500 |-+    O       O O    O         O                                    |   
  1400 |-+  O                  O         O                                  |   
       |         O         O      O  O      O                               |   
  1300 |-+                O         O                                       |   
  1200 |-+                                                                  |   
  1100 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   900 |-+                                                                  |   
       |                                                                    |   
   800 |.++.+.+ .+.++.+.+.++.+.++.+.++.+.++.+.++.+. +.+.++.+. .++.+.++.+.++.|   
   700 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/btrfs/x86_64-rhel-8.3/500/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rr/aim7/0x5003006

commit: 
  c7f9865055 ("Merge branch 'for-next-next-v5.12-20210322' into for-next-20210322")
  b05645404a ("btrfs: use percpu_read_positive instead of sum_positive for need_preempt")

c7f98650557ad6d6 b05645404a7d4f798a510154272 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          6:6         -100%            :6     stderr.Events_enabled
          6:6         -100%            :6     stderr.[perf_record:Captured_and_wrote#MB/tmp/lkp/perf-sched.data(#samples)]
          6:6         -100%            :6     stderr.[perf_record:Woken_up#times_to_write_data]
         %stddev     %change         %stddev
             \          |                \  
     15548          +107.0%      32185 ±  2%  aim7.jobs-per-min
    193.00           -51.6%      93.33 ±  2%  aim7.time.elapsed_time
    193.00           -51.6%      93.33 ±  2%  aim7.time.elapsed_time.max
    174198           -35.2%     112815 ±  2%  aim7.time.involuntary_context_switches
     81624 ±  3%     -36.5%      51812 ±  2%  aim7.time.minor_page_faults
     13856           -56.6%       6008 ±  3%  aim7.time.system_time
  10448899           -29.7%    7341283 ±  2%  aim7.time.voluntary_context_switches
     18.37           +49.3%      27.42        iostat.cpu.idle
     81.33           -11.2%      72.19        iostat.cpu.system
    224.05           -44.7%     123.84 ±  2%  uptime.boot
      5270           -16.9%       4380        uptime.idle
     24.31            +9.1       33.42        mpstat.cpu.all.idle%
     74.38            -9.2       65.19        mpstat.cpu.all.sys%
      0.22 ±  3%      +0.1        0.28 ±  2%  mpstat.cpu.all.usr%
    571087 ± 17%     -26.7%     418804 ±  5%  cpuidle.C1.usage
  15012015 ±  3%     -26.8%   10996028 ±  2%  cpuidle.C1E.usage
   1055167 ±  2%     -26.8%     772806 ±  3%  cpuidle.POLL.time
     60974 ±  2%     -26.8%      44635 ±  4%  cpuidle.POLL.usage
     17.67 ±  2%     +51.9%      26.83        vmstat.cpu.id
     80.83           -11.3%      71.67        vmstat.cpu.sy
   1909813           -22.9%    1471862        vmstat.memory.cache
     73.00            -9.8%      65.83 ±  2%  vmstat.procs.r
    106101           +43.4%     152173        vmstat.system.cs
    182951            +2.6%     187642        vmstat.system.in
    710995           -54.8%     321420 ±  2%  meminfo.Active
    439282           -83.5%      72638 ±  7%  meminfo.Active(anon)
    140872           -34.9%      91660 ±  3%  meminfo.AnonHugePages
   1813344           -24.0%    1378644        meminfo.Cached
   1201138           -33.3%     800708        meminfo.Committed_AS
    317951           -13.5%     274969        meminfo.Inactive
    313855           -13.2%     272572        meminfo.Inactive(anon)
     80930 ±  3%     -52.5%      38431        meminfo.Mapped
    497961           -82.4%      87458 ±  6%  meminfo.Shmem
   4682023           -11.5%    4145089        meminfo.max_used_kB
      5688           -15.1%       4826        slabinfo.btrfs_extent_map.active_objs
      5688           -15.1%       4826        slabinfo.btrfs_extent_map.num_objs
      1231 ±  5%     -52.5%     584.67 ±  3%  slabinfo.btrfs_ordered_extent.active_objs
      1231 ±  5%     -52.5%     584.67 ±  3%  slabinfo.btrfs_ordered_extent.num_objs
      5083 ±  8%     -19.1%       4111 ±  5%  slabinfo.dmaengine-unmap-16.active_objs
      5351 ±  7%     -19.4%       4312 ±  5%  slabinfo.dmaengine-unmap-16.num_objs
      9657 ±  4%     -13.4%       8361        slabinfo.kmalloc-192.active_objs
      9760 ±  4%     -13.6%       8437        slabinfo.kmalloc-192.num_objs
      2593 ±  6%     -35.4%       1676 ±  9%  slabinfo.mnt_cache.active_objs
      2593 ±  6%     -35.4%       1676 ±  9%  slabinfo.mnt_cache.num_objs
    295276 ± 21%     -57.7%     124991        numa-meminfo.node0.Active
    158740 ± 39%     -99.2%       1259 ± 22%  numa-meminfo.node0.Active(anon)
    136535            -9.4%     123731        numa-meminfo.node0.Active(file)
    842394 ±  7%     -22.7%     651509 ±  2%  numa-meminfo.node0.FilePages
     37693 ± 17%     -51.1%      18443 ± 14%  numa-meminfo.node0.Mapped
    182753 ± 41%     -96.6%       6131 ± 63%  numa-meminfo.node0.Shmem
    414398 ± 15%     -52.6%     196351 ±  2%  numa-meminfo.node1.Active
    279282 ± 23%     -74.4%      71378 ±  7%  numa-meminfo.node1.Active(anon)
    970726 ±  6%     -25.0%     727585 ±  2%  numa-meminfo.node1.FilePages
     42677 ± 13%     -53.0%      20047 ± 13%  numa-meminfo.node1.Mapped
    314466 ± 24%     -74.1%      81328 ±  8%  numa-meminfo.node1.Shmem
     40018 ± 39%     -99.2%     314.33 ± 22%  numa-vmstat.node0.nr_active_anon
     34093            -9.8%      30740        numa-vmstat.node0.nr_active_file
    210579 ±  7%     -22.7%     162714 ±  2%  numa-vmstat.node0.nr_file_pages
      9227 ± 17%     -49.3%       4681 ± 14%  numa-vmstat.node0.nr_mapped
     45721 ± 41%     -96.6%       1532 ± 63%  numa-vmstat.node0.nr_shmem
    120345 ±  2%     -53.1%      56424 ±  6%  numa-vmstat.node0.nr_written
     40018 ± 39%     -99.2%     314.33 ± 22%  numa-vmstat.node0.nr_zone_active_anon
     34093            -9.8%      30741        numa-vmstat.node0.nr_zone_active_file
     70240 ± 23%     -74.6%      17819 ±  7%  numa-vmstat.node1.nr_active_anon
    242636 ±  6%     -25.1%     181799 ±  2%  numa-vmstat.node1.nr_file_pages
     10378 ± 12%     -51.0%       5085 ± 13%  numa-vmstat.node1.nr_mapped
     78609 ± 24%     -74.2%      20311 ±  8%  numa-vmstat.node1.nr_shmem
    118513 ±  2%     -52.1%      56781 ±  5%  numa-vmstat.node1.nr_written
     70240 ± 23%     -74.6%      17819 ±  7%  numa-vmstat.node1.nr_zone_active_anon
    109515           -83.4%      18159 ±  7%  proc-vmstat.nr_active_anon
     67794            -8.3%      62138        proc-vmstat.nr_active_file
     64949            -7.1%      60339        proc-vmstat.nr_dirty
    453192           -23.9%     344764        proc-vmstat.nr_file_pages
     78652           -13.4%      68148        proc-vmstat.nr_inactive_anon
     20211 ±  3%     -51.8%       9736        proc-vmstat.nr_mapped
    124347           -82.4%      21864 ±  6%  proc-vmstat.nr_shmem
     24466            -2.7%      23815        proc-vmstat.nr_slab_reclaimable
     50242            -1.4%      49542        proc-vmstat.nr_slab_unreclaimable
    462420 ±  4%     -51.0%     226415 ±  2%  proc-vmstat.nr_written
    109515           -83.4%      18159 ±  7%  proc-vmstat.nr_zone_active_anon
     67794            -8.3%      62138        proc-vmstat.nr_zone_active_file
     78652           -13.4%      68148        proc-vmstat.nr_zone_inactive_anon
     65291            -7.8%      60166        proc-vmstat.nr_zone_write_pending
    101624 ±  3%     -76.6%      23779 ±  7%  proc-vmstat.numa_hint_faults
     60430 ±  5%     -77.0%      13877 ± 11%  proc-vmstat.numa_hint_faults_local
  14273415            -3.6%   13758755        proc-vmstat.numa_hit
  14193391            -3.6%   13679149        proc-vmstat.numa_local
    227156 ±  3%     -85.2%      33562 ± 31%  proc-vmstat.numa_pte_updates
   1068032           -18.0%     875773        proc-vmstat.pgactivate
  14358158            -3.5%   13860529        proc-vmstat.pgalloc_normal
    841444           -55.8%     372312 ±  2%  proc-vmstat.pgfault
  13727518            -2.5%   13387344        proc-vmstat.pgfree
   1849820 ±  4%     -51.0%     905782 ±  2%  proc-vmstat.pgpgout
     39779           -48.8%      20349 ±  4%  proc-vmstat.pgreuse
     11040           -24.6%       8322 ± 13%  sched_debug.cfs_rq:/.load.avg
    512.77 ±  7%    +104.1%       1046 ±  3%  sched_debug.cfs_rq:/.load_avg.avg
   4806750           -73.0%    1296299        sched_debug.cfs_rq:/.min_vruntime.avg
   4854228           -72.8%    1321095        sched_debug.cfs_rq:/.min_vruntime.max
   4747891           -73.5%    1259238        sched_debug.cfs_rq:/.min_vruntime.min
     18714 ± 10%     -52.4%       8913 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.67           -33.0%       0.45 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
    168.79 ± 70%    +197.4%     502.00 ±  2%  sched_debug.cfs_rq:/.removed.load_avg.max
     30.24 ± 79%    +130.0%      69.55 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    704.19 ±  2%     -26.4%     518.04 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
     73537 ± 32%     -70.1%      21975 ± 52%  sched_debug.cfs_rq:/.spread0.max
     18677 ± 10%     -52.3%       8912 ±  5%  sched_debug.cfs_rq:/.spread0.stddev
    668.49 ±  2%     -24.9%     502.17 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    414.58 ±  3%     -51.3%     201.97 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1172 ±  9%     -21.0%     926.17 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.max
    258.30 ±  5%     -22.7%     199.56 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    321414 ±  7%     +33.4%     428860 ±  3%  sched_debug.cpu.avg_idle.avg
     68486 ± 13%     -36.8%      43308 ± 26%  sched_debug.cpu.avg_idle.min
    138350 ± 12%     +28.2%     177406 ±  5%  sched_debug.cpu.avg_idle.stddev
    119684           -50.3%      59429        sched_debug.cpu.clock.avg
    119691           -50.3%      59435        sched_debug.cpu.clock.max
    119677           -50.3%      59423        sched_debug.cpu.clock.min
    118579           -50.3%      58963        sched_debug.cpu.clock_task.avg
    118749           -50.2%      59107        sched_debug.cpu.clock_task.max
    114013           -52.6%      54060        sched_debug.cpu.clock_task.min
      1993 ±  2%     -35.4%       1288 ±  7%  sched_debug.cpu.curr->pid.avg
      5254           -30.5%       3654        sched_debug.cpu.curr->pid.max
      0.71           -35.0%       0.46 ± 11%  sched_debug.cpu.nr_running.avg
    107662           -52.7%      50874        sched_debug.cpu.nr_switches.avg
    115358           -49.1%      58774 ±  3%  sched_debug.cpu.nr_switches.max
    103924           -53.2%      48680        sched_debug.cpu.nr_switches.min
      3.52           -30.0%       2.46 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
    151.33 ± 24%     -57.3%      64.67 ± 21%  sched_debug.cpu.nr_uninterruptible.max
   -127.92           -69.5%     -39.00        sched_debug.cpu.nr_uninterruptible.min
     52.00 ± 20%     -64.5%      18.45 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
    119678           -50.3%      59423        sched_debug.cpu_clk
    119183           -50.6%      58929        sched_debug.ktime
    120037           -50.2%      59782        sched_debug.sched_clk
      3.76 ± 15%     +59.9%       6.01 ±  3%  perf-stat.i.MPKI
 5.206e+09            -4.7%   4.96e+09        perf-stat.i.branch-instructions
      0.47 ± 16%      +0.2        0.69 ±  2%  perf-stat.i.branch-miss-rate%
  16598608           +37.9%   22883509        perf-stat.i.branch-misses
     28.27 ±  2%      +5.2       33.46 ±  2%  perf-stat.i.cache-miss-rate%
  20791020 ±  4%    +114.3%   44548524 ±  4%  perf-stat.i.cache-misses
  72201557 ±  2%     +73.5%  1.253e+08 ±  3%  perf-stat.i.cache-references
    107567           +44.9%     155823        perf-stat.i.context-switches
      8.90           -12.2%       7.81        perf-stat.i.cpi
 2.021e+11           -11.0%  1.799e+11        perf-stat.i.cpu-cycles
      7433            -3.5%       7171        perf-stat.i.cpu-migrations
      9562 ±  4%     -58.7%       3946 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.02 ± 45%      -0.0        0.01 ±  6%  perf-stat.i.dTLB-load-miss-rate%
    782637 ±  6%     -39.3%     474699 ±  6%  perf-stat.i.dTLB-load-misses
 5.517e+09            +2.1%  5.632e+09        perf-stat.i.dTLB-loads
      0.01 ± 27%      -0.0        0.01 ±  6%  perf-stat.i.dTLB-store-miss-rate%
 8.614e+08           +58.0%  1.361e+09 ±  2%  perf-stat.i.dTLB-stores
   4345427 ±  3%     +53.9%    6685606 ±  3%  perf-stat.i.iTLB-load-misses
   5637752           +48.2%    8353439        perf-stat.i.iTLB-loads
 2.206e+10            -2.2%  2.158e+10        perf-stat.i.instructions
      5042 ±  3%     -36.5%       3203 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.13 ±  2%     +29.9%       0.17        perf-stat.i.ipc
      1.82 ±  9%     +21.0%       2.20 ±  7%  perf-stat.i.major-faults
      2.30           -11.0%       2.04        perf-stat.i.metric.GHz
      0.82           +11.3%       0.91 ±  3%  perf-stat.i.metric.K/sec
    132.65            +3.7%     137.57        perf-stat.i.metric.M/sec
      4198           -12.2%       3687        perf-stat.i.minor-faults
     77.37            -2.7       74.70        perf-stat.i.node-load-miss-rate%
   6107340 ±  3%     +68.2%   10273753 ±  3%  perf-stat.i.node-load-misses
   1833666          +100.9%    3684331        perf-stat.i.node-loads
   2874440           +65.9%    4769915        perf-stat.i.node-store-misses
    307384 ± 10%     +31.7%     404871 ± 10%  perf-stat.i.node-stores
      4199           -12.2%       3689        perf-stat.i.page-faults
      3.27 ±  2%     +77.4%       5.81 ±  3%  perf-stat.overall.MPKI
      0.32            +0.1        0.46        perf-stat.overall.branch-miss-rate%
     28.78 ±  2%      +6.8       35.53        perf-stat.overall.cache-miss-rate%
      9.16            -9.0%       8.34        perf-stat.overall.cpi
      9738 ±  4%     -58.4%       4047 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  5%      -0.0        0.01 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  6%      -0.0        0.00 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
      5083 ±  3%     -36.4%       3231 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.11            +9.9%       0.12        perf-stat.overall.ipc
     76.90            -3.3       73.57        perf-stat.overall.node-load-miss-rate%
     90.34            +1.8       92.18        perf-stat.overall.node-store-miss-rate%
  5.18e+09            -5.2%  4.911e+09        perf-stat.ps.branch-instructions
  16510853           +37.1%   22639489        perf-stat.ps.branch-misses
  20685594 ±  4%    +113.2%   44101505 ±  5%  perf-stat.ps.cache-misses
  71845731 ±  2%     +72.7%   1.24e+08 ±  3%  perf-stat.ps.cache-references
    107019           +44.2%     154295        perf-stat.ps.context-switches
 2.011e+11           -11.4%  1.781e+11        perf-stat.ps.cpu-cycles
      7395            -4.0%       7100        perf-stat.ps.cpu-migrations
    782079 ±  5%     -39.4%     473995 ±  7%  perf-stat.ps.dTLB-load-misses
  5.49e+09            +1.6%  5.577e+09        perf-stat.ps.dTLB-loads
  8.57e+08           +57.2%  1.347e+09 ±  2%  perf-stat.ps.dTLB-stores
   4323353 ±  3%     +53.1%    6619050 ±  3%  perf-stat.ps.iTLB-load-misses
   5608632           +47.4%    8269582        perf-stat.ps.iTLB-loads
 2.195e+10            -2.7%  2.136e+10        perf-stat.ps.instructions
      1.80 ±  9%     +20.1%       2.17 ±  7%  perf-stat.ps.major-faults
      4174           -12.8%       3640        perf-stat.ps.minor-faults
   6076545 ±  3%     +67.4%   10171596 ±  4%  perf-stat.ps.node-load-misses
   1824968          +100.0%    3649244        perf-stat.ps.node-loads
   2859915           +65.1%    4722382        perf-stat.ps.node-store-misses
    305689 ± 10%     +31.1%     400785 ± 10%  perf-stat.ps.node-stores
      4176           -12.8%       3643        perf-stat.ps.page-faults
 4.261e+12           -52.7%  2.014e+12 ±  2%  perf-stat.total.instructions
     36352 ±  5%     -46.3%      19508 ±  9%  softirqs.CPU0.RCU
     42967           -51.3%      20929 ±  5%  softirqs.CPU0.SCHED
     34736 ±  2%     -56.8%      15020 ±  4%  softirqs.CPU1.RCU
     41518           -53.6%      19261 ±  7%  softirqs.CPU1.SCHED
     34341           -56.3%      14996 ±  5%  softirqs.CPU10.RCU
     40405           -55.6%      17932 ±  3%  softirqs.CPU10.SCHED
     35263 ±  4%     -58.4%      14656 ±  4%  softirqs.CPU11.RCU
     40510           -56.1%      17796 ±  3%  softirqs.CPU11.SCHED
     34665           -57.5%      14717 ±  3%  softirqs.CPU12.RCU
     40385           -55.5%      17979 ±  3%  softirqs.CPU12.SCHED
     34282           -57.1%      14699 ±  3%  softirqs.CPU13.RCU
     40526           -55.7%      17947 ±  3%  softirqs.CPU13.SCHED
     34103           -57.3%      14554 ±  3%  softirqs.CPU14.RCU
     40766           -56.1%      17880 ±  3%  softirqs.CPU14.SCHED
     35243           -58.0%      14801 ±  3%  softirqs.CPU15.RCU
     40522           -55.9%      17882 ±  4%  softirqs.CPU15.SCHED
     35489           -58.0%      14901 ±  3%  softirqs.CPU16.RCU
     40557           -56.1%      17791 ±  4%  softirqs.CPU16.SCHED
     35342           -58.1%      14815 ±  4%  softirqs.CPU17.RCU
     40488           -56.2%      17739 ±  4%  softirqs.CPU17.SCHED
     36161 ±  4%     -59.0%      14837 ±  3%  softirqs.CPU18.RCU
     40288           -55.7%      17857 ±  4%  softirqs.CPU18.SCHED
     35583           -57.4%      15147 ±  7%  softirqs.CPU19.RCU
     40366           -55.8%      17837 ±  3%  softirqs.CPU19.SCHED
     34352           -55.9%      15156 ±  6%  softirqs.CPU2.RCU
     40570           -55.4%      18092 ±  3%  softirqs.CPU2.SCHED
     35526           -58.4%      14771 ±  4%  softirqs.CPU20.RCU
     40628           -56.4%      17724 ±  4%  softirqs.CPU20.SCHED
     35464           -57.9%      14927 ±  3%  softirqs.CPU21.RCU
     40533           -56.7%      17556 ±  3%  softirqs.CPU21.SCHED
     34423           -57.5%      14622 ±  3%  softirqs.CPU22.RCU
     40682           -55.4%      18132 ±  4%  softirqs.CPU22.SCHED
     34713           -55.1%      15580 ±  9%  softirqs.CPU23.RCU
     40782           -55.1%      18291 ±  3%  softirqs.CPU23.SCHED
     34548           -57.5%      14673 ±  3%  softirqs.CPU24.RCU
     40543           -55.4%      18102 ±  4%  softirqs.CPU24.SCHED
     34618           -57.9%      14568 ±  3%  softirqs.CPU25.RCU
     40543           -55.6%      18002 ±  3%  softirqs.CPU25.SCHED
     34856           -57.9%      14672 ±  3%  softirqs.CPU26.RCU
     40591           -55.6%      18002 ±  3%  softirqs.CPU26.SCHED
     34623           -57.6%      14686 ±  3%  softirqs.CPU27.RCU
     40493           -55.6%      17978 ±  3%  softirqs.CPU27.SCHED
     34379           -57.9%      14468 ±  3%  softirqs.CPU28.RCU
     40461           -55.7%      17939 ±  4%  softirqs.CPU28.SCHED
     34189           -57.7%      14451 ±  3%  softirqs.CPU29.RCU
     40527           -55.8%      17919 ±  4%  softirqs.CPU29.SCHED
     34470           -56.9%      14840 ±  3%  softirqs.CPU3.RCU
     40451           -55.3%      18082 ±  5%  softirqs.CPU3.SCHED
     35292 ±  2%     -58.0%      14838 ±  3%  softirqs.CPU30.RCU
     40433           -55.5%      17977 ±  3%  softirqs.CPU30.SCHED
     34927           -57.8%      14746 ±  3%  softirqs.CPU31.RCU
     40426           -56.0%      17800 ±  4%  softirqs.CPU31.SCHED
     35035           -58.1%      14679 ±  3%  softirqs.CPU32.RCU
     40474           -55.8%      17892 ±  4%  softirqs.CPU32.SCHED
     35279           -57.6%      14945 ±  3%  softirqs.CPU33.RCU
     40584           -55.8%      17919 ±  3%  softirqs.CPU33.SCHED
     35210           -57.1%      15118 ±  4%  softirqs.CPU34.RCU
     40492           -55.8%      17883 ±  4%  softirqs.CPU34.SCHED
     35099           -57.0%      15085 ±  4%  softirqs.CPU35.RCU
     40531           -55.8%      17908 ±  3%  softirqs.CPU35.SCHED
     35044           -57.6%      14874 ±  6%  softirqs.CPU36.RCU
     40496           -55.6%      17962 ±  4%  softirqs.CPU36.SCHED
     34808           -57.5%      14799 ±  3%  softirqs.CPU37.RCU
     40473           -55.7%      17937 ±  3%  softirqs.CPU37.SCHED
     35276 ±  5%     -58.5%      14642 ±  3%  softirqs.CPU38.RCU
     40543           -56.0%      17853 ±  3%  softirqs.CPU38.SCHED
     35310           -57.8%      14889 ±  3%  softirqs.CPU39.RCU
     40505           -56.0%      17817 ±  4%  softirqs.CPU39.SCHED
     34322           -57.6%      14558 ±  5%  softirqs.CPU4.RCU
     40579           -55.8%      17953 ±  4%  softirqs.CPU4.SCHED
     35231           -58.5%      14613 ±  4%  softirqs.CPU40.RCU
     40334           -55.4%      17980 ±  4%  softirqs.CPU40.SCHED
     35043           -57.4%      14935 ±  3%  softirqs.CPU41.RCU
     40438           -55.5%      17985 ±  3%  softirqs.CPU41.SCHED
     35094           -58.1%      14698 ±  3%  softirqs.CPU42.RCU
     40472           -55.6%      17951 ±  3%  softirqs.CPU42.SCHED
     35165           -58.0%      14758 ±  3%  softirqs.CPU43.RCU
     39888 ±  2%     -58.3%      16619 ±  8%  softirqs.CPU43.SCHED
     28525           -57.3%      12172 ±  5%  softirqs.CPU44.RCU
     40586           -56.1%      17819 ±  3%  softirqs.CPU44.SCHED
     34218 ±  3%     -56.8%      14787 ±  4%  softirqs.CPU45.RCU
     40709           -55.3%      18193 ±  4%  softirqs.CPU45.SCHED
     34895           -57.8%      14727 ±  3%  softirqs.CPU46.RCU
     40496           -56.5%      17631 ±  3%  softirqs.CPU46.SCHED
     35199           -57.9%      14805 ±  3%  softirqs.CPU47.RCU
     40681           -56.7%      17599 ±  5%  softirqs.CPU47.SCHED
     35438           -58.1%      14861 ±  3%  softirqs.CPU48.RCU
     40747           -55.9%      17980 ±  3%  softirqs.CPU48.SCHED
     35472           -58.2%      14814 ±  3%  softirqs.CPU49.RCU
     40842           -56.1%      17924 ±  3%  softirqs.CPU49.SCHED
     34732           -57.8%      14660 ±  4%  softirqs.CPU5.RCU
     40963 ±  2%     -56.4%      17843 ±  3%  softirqs.CPU5.SCHED
     34835           -58.1%      14599 ±  2%  softirqs.CPU50.RCU
     41133           -56.2%      18012 ±  4%  softirqs.CPU50.SCHED
     34889           -57.9%      14686 ±  3%  softirqs.CPU51.RCU
     40666           -55.7%      18030 ±  4%  softirqs.CPU51.SCHED
     34968           -57.2%      14971 ±  3%  softirqs.CPU52.RCU
     40801           -55.5%      18157 ±  4%  softirqs.CPU52.SCHED
     35297           -57.9%      14877 ±  2%  softirqs.CPU53.RCU
     40787           -55.7%      18074 ±  4%  softirqs.CPU53.SCHED
     35399           -57.8%      14956 ±  3%  softirqs.CPU54.RCU
     40871           -55.6%      18134 ±  4%  softirqs.CPU54.SCHED
     35270           -58.4%      14671 ±  3%  softirqs.CPU55.RCU
     40778           -55.4%      18180 ±  5%  softirqs.CPU55.SCHED
     35050           -57.9%      14742 ±  3%  softirqs.CPU56.RCU
     40828           -56.0%      17979 ±  4%  softirqs.CPU56.SCHED
     35210           -58.0%      14796 ±  4%  softirqs.CPU57.RCU
     40677           -56.1%      17840 ±  5%  softirqs.CPU57.SCHED
     35052           -57.4%      14915 ±  3%  softirqs.CPU58.RCU
     40800           -55.8%      18026 ±  4%  softirqs.CPU58.SCHED
     34725 ±  4%     -56.5%      15089 ±  3%  softirqs.CPU59.RCU
     40666           -55.6%      18036 ±  3%  softirqs.CPU59.SCHED
     34600           -57.2%      14808 ±  4%  softirqs.CPU6.RCU
     40873           -56.2%      17910 ±  3%  softirqs.CPU6.SCHED
     35273           -58.0%      14825 ±  4%  softirqs.CPU60.RCU
     41080           -56.2%      17985 ±  4%  softirqs.CPU60.SCHED
     34965           -58.3%      14585 ±  7%  softirqs.CPU61.RCU
     40419           -55.3%      18063 ±  7%  softirqs.CPU61.SCHED
     34949           -58.0%      14664 ±  3%  softirqs.CPU62.RCU
     40949           -55.7%      18137 ±  4%  softirqs.CPU62.SCHED
     34942           -57.8%      14741 ±  3%  softirqs.CPU63.RCU
     40634           -55.8%      17941 ±  4%  softirqs.CPU63.SCHED
     35028           -57.3%      14947 ±  3%  softirqs.CPU64.RCU
     40945           -55.6%      18186 ±  3%  softirqs.CPU64.SCHED
     34971           -58.4%      14557 ±  6%  softirqs.CPU65.RCU
     40874           -56.0%      17972 ±  4%  softirqs.CPU65.SCHED
     35008           -57.7%      14804 ±  3%  softirqs.CPU66.RCU
     40879           -55.3%      18253 ±  3%  softirqs.CPU66.SCHED
     34913           -57.8%      14722 ±  3%  softirqs.CPU67.RCU
     40661           -55.8%      17970 ±  4%  softirqs.CPU67.SCHED
     34892           -57.9%      14672 ±  3%  softirqs.CPU68.RCU
     40598           -55.6%      18030 ±  4%  softirqs.CPU68.SCHED
     34730           -57.0%      14918 ±  5%  softirqs.CPU69.RCU
     40694           -55.3%      18174 ±  4%  softirqs.CPU69.SCHED
     34421           -57.7%      14546 ±  3%  softirqs.CPU7.RCU
     40462           -55.8%      17876 ±  4%  softirqs.CPU7.SCHED
     35640 ±  4%     -58.8%      14682 ±  3%  softirqs.CPU70.RCU
     40678           -55.5%      18115 ±  3%  softirqs.CPU70.SCHED
     34990           -57.5%      14866 ±  4%  softirqs.CPU71.RCU
     40823           -55.6%      18140 ±  4%  softirqs.CPU71.SCHED
     34839           -57.6%      14765 ±  4%  softirqs.CPU72.RCU
     40840           -56.0%      17968 ±  3%  softirqs.CPU72.SCHED
     34720           -57.8%      14664 ±  3%  softirqs.CPU73.RCU
     40551           -55.7%      17964 ±  2%  softirqs.CPU73.SCHED
     34886           -58.1%      14633 ±  3%  softirqs.CPU74.RCU
     40853           -55.7%      18100 ±  4%  softirqs.CPU74.SCHED
     32649           -57.8%      13788 ±  3%  softirqs.CPU75.RCU
     40767           -55.7%      18068 ±  3%  softirqs.CPU75.SCHED
     32899           -57.6%      13961 ±  4%  softirqs.CPU76.RCU
     40878           -55.6%      18160 ±  3%  softirqs.CPU76.SCHED
     33186           -58.0%      13936 ±  3%  softirqs.CPU77.RCU
     40817           -55.9%      18000 ±  4%  softirqs.CPU77.SCHED
     33005           -57.7%      13959 ±  4%  softirqs.CPU78.RCU
     40723           -55.5%      18112 ±  4%  softirqs.CPU78.SCHED
     33221           -58.2%      13870 ±  4%  softirqs.CPU79.RCU
     40512           -55.5%      18028 ±  4%  softirqs.CPU79.SCHED
     33923 ±  3%     -56.3%      14837 ±  4%  softirqs.CPU8.RCU
     40441           -55.5%      17976 ±  4%  softirqs.CPU8.SCHED
     32889           -57.8%      13882 ±  5%  softirqs.CPU80.RCU
     40637           -55.5%      18086 ±  4%  softirqs.CPU80.SCHED
     32799           -58.3%      13687 ±  4%  softirqs.CPU81.RCU
     40633           -55.5%      18098 ±  4%  softirqs.CPU81.SCHED
     32414           -57.5%      13782 ±  4%  softirqs.CPU82.RCU
     40809           -55.5%      18172 ±  3%  softirqs.CPU82.SCHED
     33040           -57.8%      13946 ±  3%  softirqs.CPU83.RCU
     40831           -55.9%      18017 ±  3%  softirqs.CPU83.SCHED
     33054           -57.8%      13945 ±  3%  softirqs.CPU84.RCU
     40802           -55.7%      18056 ±  3%  softirqs.CPU84.SCHED
     32940           -57.5%      13996 ±  5%  softirqs.CPU85.RCU
     40782           -55.6%      18119 ±  3%  softirqs.CPU85.SCHED
     32810           -57.6%      13923 ±  4%  softirqs.CPU86.RCU
     40671           -55.3%      18165 ±  4%  softirqs.CPU86.SCHED
     33166           -57.2%      14185 ±  3%  softirqs.CPU87.RCU
     40148           -55.5%      17876 ±  3%  softirqs.CPU87.SCHED
     34623           -57.0%      14885 ±  6%  softirqs.CPU9.RCU
     40923           -56.7%      17703 ±  5%  softirqs.CPU9.SCHED
   3043473           -57.5%    1292407 ±  3%  softirqs.RCU
   3579054           -55.7%    1585021 ±  3%  softirqs.SCHED
     35254           -43.4%      19966 ±  2%  softirqs.TIMER
     35.56            -2.9       32.67        perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
     35.56            -2.9       32.68        perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     35.67            -2.7       32.93        perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     34.55            -2.5       32.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     34.61            -2.5       32.16        perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
     92.70            -2.0       90.71        perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
     92.73            -2.0       90.77        perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     92.74            -1.9       90.79        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.78            -1.9       90.87        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.80            -1.9       90.90        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.81            -1.9       90.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.83            -1.9       90.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     92.87            -1.8       91.02        perf-profile.calltrace.cycles-pp.write
     31.81            -1.1       30.72        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
     31.89            -1.0       30.91        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
     31.91            -1.0       30.95        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     31.92            -0.9       30.97        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     23.56            +0.2       23.77        perf-profile.calltrace.cycles-pp.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages
     23.57            +0.2       23.78        perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write
     23.60            +0.3       23.85        perf-profile.calltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
     23.60            +0.3       23.85        perf-profile.calltrace.cycles-pp.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.43 ± 44%      +0.4        0.86 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages
      0.43 ± 44%      +0.4        0.87 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write
      0.63 ±  2%      +0.5        1.08 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
      0.76 ±  2%      +0.6        1.31 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.prepare_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     24.41            +0.9       25.28        perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      5.58 ±  2%      +0.9        6.46 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.68 ±  2%      +0.9        6.61 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      5.68 ±  2%      +0.9        6.62 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.84            +1.0        6.86 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.84            +1.0        6.86 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.84            +1.0        6.86 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      5.90            +1.0        6.92 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     90.38            -3.6       86.80        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     90.71            -3.0       87.70        perf-profile.children.cycles-pp._raw_spin_lock
     35.71            -2.9       32.80        perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     35.78            -2.8       33.00        perf-profile.children.cycles-pp.__reserve_bytes
     35.67            -2.7       32.93        perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
     92.71            -2.0       90.72        perf-profile.children.cycles-pp.btrfs_buffered_write
     92.73            -2.0       90.77        perf-profile.children.cycles-pp.btrfs_file_write_iter
     92.75            -1.9       90.80        perf-profile.children.cycles-pp.new_sync_write
     92.79            -1.9       90.88        perf-profile.children.cycles-pp.vfs_write
     92.81            -1.9       90.91        perf-profile.children.cycles-pp.ksys_write
     92.88            -1.8       91.04        perf-profile.children.cycles-pp.write
     93.49            -1.3       92.23        perf-profile.children.cycles-pp.do_syscall_64
     93.86            -1.1       92.72        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.61            -0.9       54.68        perf-profile.children.cycles-pp.btrfs_block_rsv_release
     55.36            -0.9       54.45        perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.83            -0.6        0.20 ±  3%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.07 ± 11%      -0.0        0.03 ± 99%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.evict_refill_and_join
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.btrfs_block_rsv_refill
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.btrfs_commit_inode_delayed_inode
      0.10 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.07 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.set_state_bits
      0.07 ± 11%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.update_cfs_group
      0.08 ±  4%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.33 ±  2%      +0.0        0.36 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.11 ±  6%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.btrfs_create
      0.03 ± 70%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.03 ± 99%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.08 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.08 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      0.18 ±  3%      +0.0        0.23 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.05        perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.0        0.05        perf-profile.children.cycles-pp.release_pages
      0.00            +0.0        0.05        perf-profile.children.cycles-pp.update_curr
      0.10 ±  6%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.btrfs_calculate_inode_block_rsv_size
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      0.06 ±  6%      +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.06 ± 11%      +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.09 ±  7%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.schedule
      0.05            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.llseek
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.copyin
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.dequeue_entity
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.lock_extent_bits
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.05            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.05 ±  7%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.copyout
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__entry_text_start
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.find_extent_buffer_nospinlock
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.dequeue_task_fair
      0.11 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.btrfs_release_path
      0.01 ±223%      +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.01 ±223%      +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.generic_bin_search
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_get_pages
      0.04 ± 45%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.btrfs_transaction_in_commit
      0.13 ±  3%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.06 ±  6%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.01 ±223%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.memset_erms
      0.33 ±  2%      +0.1        0.41 ±  4%  perf-profile.children.cycles-pp.btrfs_evict_inode
      0.33 ±  2%      +0.1        0.41 ±  4%  perf-profile.children.cycles-pp.evict
      0.34 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__close
      0.34 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.33 ±  2%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.find_extent_buffer
      0.08 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.33 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.dput
      0.33 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__fput
      0.04 ± 45%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.btrfs_drop_pages
      0.08 ±  4%      +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.07 ±  5%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.alloc_extent_state
      0.35            +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.08 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.read_block_for_search
      0.36 ±  2%      +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07 ±  7%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.btrfs_get_alloc_profile
      0.10 ±  3%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.btrfs_do_readpage
      0.29 ±  2%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.08 ±  5%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.calc_available_free_space
      0.32 ±  2%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.32            +0.1        0.46 ±  5%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.12 ±  3%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.btrfs_readpage
      0.13 ±  4%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.prepare_uptodate_page
      0.09 ±  9%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.15 ±  5%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      0.08 ±  4%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.btrfs_can_overcommit
      0.23 ±  6%      +0.2        0.39 ± 10%  perf-profile.children.cycles-pp.creat64
      0.13 ±  2%      +0.2        0.29 ±  5%  perf-profile.children.cycles-pp.filemap_read
      0.23 ±  5%      +0.2        0.39 ±  9%  perf-profile.children.cycles-pp.do_filp_open
      0.23 ±  5%      +0.2        0.39 ±  9%  perf-profile.children.cycles-pp.path_openat
      0.23 ±  5%      +0.2        0.39 ±  9%  perf-profile.children.cycles-pp.do_sys_open
      0.23 ±  5%      +0.2        0.39 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
      0.10 ±  8%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.09 ±  8%      +0.2        0.26 ±  7%  perf-profile.children.cycles-pp.btrfs_free_reserved_data_space_noquota
      0.14 ±  5%      +0.2        0.31 ±  5%  perf-profile.children.cycles-pp.new_sync_read
      0.22 ±  3%      +0.2        0.41 ±  4%  perf-profile.children.cycles-pp.set_extent_bit
      0.17 ±  3%      +0.2        0.36 ±  4%  perf-profile.children.cycles-pp.vfs_read
      0.17 ±  4%      +0.2        0.37 ±  4%  perf-profile.children.cycles-pp.ksys_read
     23.59            +0.2       23.82        perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
      0.20 ±  2%      +0.2        0.46 ±  4%  perf-profile.children.cycles-pp.read
      0.23 ±  8%      +0.3        0.49 ± 14%  perf-profile.children.cycles-pp.unlink
      0.23 ±  7%      +0.3        0.49 ± 14%  perf-profile.children.cycles-pp.do_unlinkat
     23.63            +0.3       23.89        perf-profile.children.cycles-pp.clear_extent_bit
     23.64            +0.3       23.90        perf-profile.children.cycles-pp.clear_state_bit
      0.28 ±  3%      +0.3        0.59 ±  3%  perf-profile.children.cycles-pp.prepare_pages
      0.13 ± 15%      +0.3        0.44 ± 20%  perf-profile.children.cycles-pp.osq_lock
     23.70            +0.3       24.04        perf-profile.children.cycles-pp.__clear_extent_bit
      0.52 ±  2%      +0.3        0.87 ±  3%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.25 ±  9%      +0.4        0.63 ± 16%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.58 ±  2%      +0.4        0.96 ±  3%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.63 ±  2%      +0.5        1.09 ±  2%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.76 ±  2%      +0.6        1.31 ±  2%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
     24.41            +0.9       25.28        perf-profile.children.cycles-pp.btrfs_dirty_pages
      5.64            +0.9        6.52 ±  2%  perf-profile.children.cycles-pp.intel_idle
      5.75            +0.9        6.68 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.75            +0.9        6.68 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      5.84            +1.0        6.86 ±  2%  perf-profile.children.cycles-pp.start_secondary
      5.90            +1.0        6.92 ±  2%  perf-profile.children.cycles-pp.do_idle
      5.90            +1.0        6.92 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      5.90            +1.0        6.92 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     89.82            -3.6       86.23        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.07 ± 11%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.0        0.05        perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.0        0.05        perf-profile.self.cycles-pp.find_extent_buffer_nospinlock
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.05            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.btrfs_block_rsv_release
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.generic_bin_search
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.btrfs_get_alloc_profile
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.btrfs_free_reserved_data_space_noquota
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.memset_erms
      0.05            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.need_preemptive_reclaim
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.btrfs_can_overcommit
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.set_extent_bit
      0.08            +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.03 ± 99%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.btrfs_drop_pages
      0.01 ±223%      +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.__reserve_bytes
      0.13 ± 16%      +0.3        0.44 ± 20%  perf-profile.self.cycles-pp.osq_lock
      0.50            +0.6        1.10        perf-profile.self.cycles-pp._raw_spin_lock
      5.64            +0.9        6.52 ±  2%  perf-profile.self.cycles-pp.intel_idle
      0.00       +3.8e+104%     379.17 ±160%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
    389.67           -51.2%     190.00 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
    272565           -31.7%     186157        interrupts.CAL:Function_call_interrupts
    389686           -51.3%     189607 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      1469 ±  2%     -40.1%     879.50 ±  6%  interrupts.CPU0.RES:Rescheduling_interrupts
     53.17 ± 35%    +108.5%     110.83 ± 25%  interrupts.CPU0.TLB:TLB_shootdowns
    389.67           -51.2%     190.00 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    389738           -51.3%     189648 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      1058 ±  6%     -31.6%     723.33 ±  8%  interrupts.CPU1.RES:Rescheduling_interrupts
      3021 ±  2%     -31.9%       2057 ±  3%  interrupts.CPU10.CAL:Function_call_interrupts
    389637           -51.3%     189675 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
    977.83 ±  3%     -29.6%     688.67 ±  4%  interrupts.CPU10.RES:Rescheduling_interrupts
      3086 ±  7%     -34.9%       2010 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
    389698           -51.3%     189700 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      1017 ±  4%     -33.7%     674.50 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
      3071 ±  3%     -33.2%       2050        interrupts.CPU12.CAL:Function_call_interrupts
    389700           -51.3%     189669 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
    998.67 ±  6%     -30.8%     691.33 ±  6%  interrupts.CPU12.RES:Rescheduling_interrupts
      2959 ±  3%     -30.5%       2056 ±  4%  interrupts.CPU13.CAL:Function_call_interrupts
    389701           -51.3%     189669 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      1002 ±  3%     -32.3%     678.50 ±  5%  interrupts.CPU13.RES:Rescheduling_interrupts
      3391 ± 30%     -41.9%       1968 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
    389711           -51.3%     189700 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      1018 ±  6%     -34.2%     670.67 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
      2952 ±  2%     -31.0%       2035 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
    389712           -51.3%     189703 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
    993.17 ±  4%     -31.2%     683.67 ±  5%  interrupts.CPU15.RES:Rescheduling_interrupts
      3030 ±  3%     -33.3%       2021 ±  5%  interrupts.CPU16.CAL:Function_call_interrupts
    389697           -51.3%     189655 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
      1052 ±  3%     -35.0%     684.17 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
      2998 ±  3%     -33.3%       1998 ±  5%  interrupts.CPU17.CAL:Function_call_interrupts
    389725           -51.3%     189674 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
      1013 ±  6%     -31.8%     690.83 ±  5%  interrupts.CPU17.RES:Rescheduling_interrupts
      2904 ±  4%     -32.1%       1972 ±  3%  interrupts.CPU18.CAL:Function_call_interrupts
    389656           -51.3%     189669 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
      1017 ±  7%     -33.2%     679.17 ±  3%  interrupts.CPU18.RES:Rescheduling_interrupts
      3011 ±  6%     -33.1%       2016 ±  6%  interrupts.CPU19.CAL:Function_call_interrupts
    389600           -51.3%     189642 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
    996.50 ±  4%     -32.8%     669.83 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
      3268 ±  4%     -35.1%       2120        interrupts.CPU2.CAL:Function_call_interrupts
    389707           -51.3%     189717 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      1051 ±  4%     -35.3%     680.33 ±  6%  interrupts.CPU2.RES:Rescheduling_interrupts
      2918 ±  3%     -30.2%       2037 ±  4%  interrupts.CPU20.CAL:Function_call_interrupts
    389700           -51.3%     189672 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
    990.17 ±  4%     -32.4%     669.83 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
      2989 ±  2%     -31.7%       2040 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
    389707           -51.4%     189589 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
      1011 ±  4%     -33.2%     675.33 ±  7%  interrupts.CPU21.RES:Rescheduling_interrupts
      3792           -34.9%       2470 ±  3%  interrupts.CPU22.CAL:Function_call_interrupts
    389599           -51.3%     189889 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
      1113 ±  4%     -30.9%     769.50 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
      3498 ±  3%     -35.7%       2249 ±  3%  interrupts.CPU23.CAL:Function_call_interrupts
    389704           -51.3%     189738 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
      1053 ±  2%     -30.2%     734.67 ±  8%  interrupts.CPU23.RES:Rescheduling_interrupts
      3266 ±  2%     -33.9%       2160 ±  4%  interrupts.CPU24.CAL:Function_call_interrupts
    389619           -51.3%     189732 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      1035 ±  3%     -32.7%     696.17 ±  8%  interrupts.CPU24.RES:Rescheduling_interrupts
      3270 ±  3%     -34.7%       2134 ±  4%  interrupts.CPU25.CAL:Function_call_interrupts
    389661           -51.3%     189725 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      1017 ±  3%     -28.7%     725.33 ±  3%  interrupts.CPU25.RES:Rescheduling_interrupts
      3359 ±  4%     -36.2%       2144 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
    389658           -51.3%     189726 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
    984.67 ±  3%     -26.8%     720.50 ±  4%  interrupts.CPU26.RES:Rescheduling_interrupts
      3264 ±  3%     -32.7%       2196 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
    389613           -51.3%     189722 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      1024 ±  2%     -31.5%     701.83 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
      3197 ±  4%     -31.1%       2203 ±  4%  interrupts.CPU28.CAL:Function_call_interrupts
    389552           -51.3%     189887 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      1002 ±  6%     -28.5%     716.50 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
      3285 ±  2%     -34.0%       2168        interrupts.CPU29.CAL:Function_call_interrupts
    389655           -51.3%     189838 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      1005 ±  4%     -29.2%     712.00 ±  8%  interrupts.CPU29.RES:Rescheduling_interrupts
    389647           -51.3%     189699 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      1056 ±  4%     -34.7%     689.67 ±  7%  interrupts.CPU3.RES:Rescheduling_interrupts
      3184 ±  4%     -31.9%       2168 ±  4%  interrupts.CPU30.CAL:Function_call_interrupts
    389649           -51.3%     189657 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
    994.00 ±  5%     -32.1%     675.33 ±  8%  interrupts.CPU30.RES:Rescheduling_interrupts
      3123 ±  2%     -32.8%       2100 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
    389654           -51.3%     189698 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
    962.50 ±  6%     -29.9%     674.67 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
      3142 ±  2%     -31.5%       2150 ±  4%  interrupts.CPU32.CAL:Function_call_interrupts
    389639           -51.3%     189659 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      1000           -30.9%     691.67 ±  6%  interrupts.CPU32.RES:Rescheduling_interrupts
      3133 ±  4%     -32.4%       2117 ±  4%  interrupts.CPU33.CAL:Function_call_interrupts
    389792           -51.3%     189694 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      1024 ±  4%     -33.1%     685.17 ±  8%  interrupts.CPU33.RES:Rescheduling_interrupts
      3073 ±  3%     -30.1%       2148 ±  3%  interrupts.CPU34.CAL:Function_call_interrupts
    389642           -51.3%     189694 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      1011 ±  6%     -29.2%     716.17 ±  3%  interrupts.CPU34.RES:Rescheduling_interrupts
      2998 ±  3%     -30.7%       2076 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
    389643           -51.3%     189728 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
    989.00 ±  5%     -30.9%     683.33 ±  3%  interrupts.CPU35.RES:Rescheduling_interrupts
      3027 ±  2%     -31.9%       2062 ±  6%  interrupts.CPU36.CAL:Function_call_interrupts
    389641           -51.3%     189707 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
    990.33 ±  4%     -29.3%     700.00 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
      3098 ±  3%     -31.8%       2112 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
    389625           -51.3%     189696 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
    994.83 ±  4%     -30.1%     695.00 ±  7%  interrupts.CPU37.RES:Rescheduling_interrupts
      3134 ±  2%     -32.6%       2113 ±  4%  interrupts.CPU38.CAL:Function_call_interrupts
    389648           -51.3%     189865 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
    993.33 ±  3%     -27.7%     717.83 ±  9%  interrupts.CPU38.RES:Rescheduling_interrupts
      3117 ±  4%     -31.7%       2129 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
    389658           -51.3%     189644 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
    998.67 ±  8%     -26.9%     730.17 ±  7%  interrupts.CPU39.RES:Rescheduling_interrupts
      3484 ± 20%     -41.0%       2054 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
    389702           -51.3%     189678 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      1013 ±  3%     -32.5%     684.67 ±  6%  interrupts.CPU4.RES:Rescheduling_interrupts
      2994 ±  3%     -28.9%       2129 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
    389655           -51.3%     189700 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
    980.00 ±  6%     -27.0%     715.17 ±  8%  interrupts.CPU40.RES:Rescheduling_interrupts
      3065 ±  2%     -30.9%       2116 ±  3%  interrupts.CPU41.CAL:Function_call_interrupts
    389582           -51.3%     189703 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
    971.50 ±  4%     -28.7%     692.50 ±  6%  interrupts.CPU41.RES:Rescheduling_interrupts
      3086 ±  3%     -32.5%       2083 ±  4%  interrupts.CPU42.CAL:Function_call_interrupts
    389619           -51.3%     189692 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
    983.50 ±  3%     -29.3%     695.00 ±  6%  interrupts.CPU42.RES:Rescheduling_interrupts
      3134 ±  3%     -32.2%       2124 ±  2%  interrupts.CPU43.CAL:Function_call_interrupts
    389666           -51.3%     189839 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
    971.33 ±  6%     -29.0%     689.67 ±  9%  interrupts.CPU43.RES:Rescheduling_interrupts
      3028 ±  5%     -33.7%       2008 ±  4%  interrupts.CPU44.CAL:Function_call_interrupts
    389579           -51.3%     189616 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
    959.83 ±  6%     -28.7%     684.83 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
      3022 ±  3%     -33.0%       2023 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
    389675           -51.3%     189605 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
    977.83 ±  5%     -34.1%     644.00 ±  8%  interrupts.CPU45.RES:Rescheduling_interrupts
      2927 ±  5%     -33.1%       1959 ±  4%  interrupts.CPU46.CAL:Function_call_interrupts
    389668           -51.3%     189695 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
    967.00 ±  7%     -31.4%     663.17 ±  4%  interrupts.CPU46.RES:Rescheduling_interrupts
      2923 ±  2%     -32.0%       1986 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
    389663           -51.3%     189696 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
    968.67 ±  6%     -31.7%     661.33 ±  3%  interrupts.CPU47.RES:Rescheduling_interrupts
      2872           -30.4%       1998 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
    389689           -51.3%     189719 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
    953.00 ±  2%     -28.9%     677.50 ±  5%  interrupts.CPU48.RES:Rescheduling_interrupts
      2960 ±  2%     -32.2%       2007 ±  5%  interrupts.CPU49.CAL:Function_call_interrupts
    389609           -51.3%     189621 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
      7235           -36.4%       4602 ± 35%  interrupts.CPU49.NMI:Non-maskable_interrupts
      7235           -36.4%       4602 ± 35%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    959.00 ±  5%     -30.3%     668.33 ±  7%  interrupts.CPU49.RES:Rescheduling_interrupts
      3979 ± 29%     -49.5%       2010 ±  5%  interrupts.CPU5.CAL:Function_call_interrupts
    389716           -51.4%     189569 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      1033 ±  7%     -33.2%     690.50 ±  5%  interrupts.CPU5.RES:Rescheduling_interrupts
      2920 ±  3%     -30.6%       2028 ±  3%  interrupts.CPU50.CAL:Function_call_interrupts
    389690           -51.3%     189684 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
      1007 ±  2%     -31.0%     694.83 ±  8%  interrupts.CPU50.RES:Rescheduling_interrupts
      2940 ±  3%     -32.4%       1987 ±  3%  interrupts.CPU51.CAL:Function_call_interrupts
    389703           -51.3%     189667 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
    997.17 ±  8%     -35.0%     647.67 ±  5%  interrupts.CPU51.RES:Rescheduling_interrupts
      2867           -30.2%       2001 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
    389719           -51.3%     189710 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
    959.17 ±  4%     -31.3%     658.83 ±  6%  interrupts.CPU52.RES:Rescheduling_interrupts
      2914           -31.9%       1984 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
    389695           -51.3%     189691 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
    949.67 ±  4%     -30.0%     665.00 ±  5%  interrupts.CPU53.RES:Rescheduling_interrupts
      2913 ±  2%     -30.0%       2039 ±  3%  interrupts.CPU54.CAL:Function_call_interrupts
    389710           -51.3%     189685 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
    995.83 ±  5%     -29.4%     703.17 ±  8%  interrupts.CPU54.RES:Rescheduling_interrupts
      2957 ±  2%     -32.3%       2001 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
    389715           -51.3%     189737 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
    963.17 ±  8%     -27.5%     698.50 ±  9%  interrupts.CPU55.RES:Rescheduling_interrupts
      3009           -34.2%       1980        interrupts.CPU56.CAL:Function_call_interrupts
    389717           -51.3%     189692 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
    973.67 ±  7%     -31.5%     666.67 ±  6%  interrupts.CPU56.RES:Rescheduling_interrupts
      2884 ±  3%     -31.1%       1986 ±  3%  interrupts.CPU57.CAL:Function_call_interrupts
    389717           -51.3%     189740 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
    984.17 ±  3%     -29.2%     697.17 ±  8%  interrupts.CPU57.RES:Rescheduling_interrupts
      2941           -32.1%       1997 ±  2%  interrupts.CPU58.CAL:Function_call_interrupts
    389726           -51.3%     189734 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
    984.67 ±  7%     -30.5%     684.50 ± 10%  interrupts.CPU58.RES:Rescheduling_interrupts
      2935 ±  2%     -30.6%       2037 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
    389715           -51.3%     189651 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
    948.00 ±  4%     -29.9%     664.83 ± 11%  interrupts.CPU59.RES:Rescheduling_interrupts
      3685 ± 34%     -44.1%       2062 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
    389726           -51.3%     189737 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      1036 ±  7%     -31.9%     706.17 ±  3%  interrupts.CPU6.RES:Rescheduling_interrupts
      3011 ±  4%     -34.0%       1986 ±  2%  interrupts.CPU60.CAL:Function_call_interrupts
    389727           -51.3%     189682 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
    936.00 ±  4%     -27.7%     676.33 ± 10%  interrupts.CPU60.RES:Rescheduling_interrupts
      3011 ±  2%     -34.7%       1965 ±  7%  interrupts.CPU61.CAL:Function_call_interrupts
    389832           -51.3%     189716 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
    963.33 ±  4%     -29.7%     677.67 ±  7%  interrupts.CPU61.RES:Rescheduling_interrupts
      2905 ±  3%     -32.4%       1965 ±  2%  interrupts.CPU62.CAL:Function_call_interrupts
    389716           -51.3%     189700 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
    967.83 ±  6%     -31.5%     663.33 ±  7%  interrupts.CPU62.RES:Rescheduling_interrupts
      2950 ±  3%     -34.5%       1933 ±  5%  interrupts.CPU63.CAL:Function_call_interrupts
    389707           -51.3%     189719 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
    988.67 ±  6%     -30.9%     683.50 ± 10%  interrupts.CPU63.RES:Rescheduling_interrupts
      2961 ±  3%     -33.8%       1959 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
    389672           -51.3%     189733 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
    980.00 ±  7%     -30.4%     682.17 ±  8%  interrupts.CPU64.RES:Rescheduling_interrupts
      0.00       +3.8e+104%     378.67 ±160%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      2920 ±  2%     -33.0%       1957 ±  4%  interrupts.CPU65.CAL:Function_call_interrupts
    389705           -51.3%     189723 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
    937.33 ±  7%     -26.0%     693.83 ±  7%  interrupts.CPU65.RES:Rescheduling_interrupts
      3334 ±  2%     -32.6%       2246 ±  4%  interrupts.CPU66.CAL:Function_call_interrupts
    389800           -51.3%     189678 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
    979.83 ±  6%     -22.0%     764.00 ± 11%  interrupts.CPU66.RES:Rescheduling_interrupts
      3038 ±  3%     -28.8%       2162 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
    389672           -51.3%     189694 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
    972.33 ±  5%     -25.7%     722.83 ±  9%  interrupts.CPU67.RES:Rescheduling_interrupts
      2900 ±  2%     -29.2%       2054 ±  6%  interrupts.CPU68.CAL:Function_call_interrupts
    389582           -51.3%     189716 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      1016 ±  5%     -29.8%     712.83 ±  9%  interrupts.CPU68.RES:Rescheduling_interrupts
     30.17 ±116%     -74.0%       7.83 ± 18%  interrupts.CPU68.TLB:TLB_shootdowns
      3060 ±  3%     -30.6%       2123 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
    389667           -51.3%     189712 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
      1031 ±  4%     -30.7%     714.50 ±  7%  interrupts.CPU69.RES:Rescheduling_interrupts
    389716           -51.3%     189838 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      1010 ±  4%     -31.6%     690.50 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
      3120 ±  5%     -30.9%       2155 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
    389683           -51.3%     189731 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
    970.17 ±  6%     -22.9%     748.17 ±  9%  interrupts.CPU70.RES:Rescheduling_interrupts
      3111 ±  2%     -34.4%       2042 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
    389542           -51.3%     189720 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
      1022 ±  7%     -29.5%     720.83 ± 14%  interrupts.CPU71.RES:Rescheduling_interrupts
      3075 ±  2%     -30.1%       2150 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
    389675           -51.3%     189715 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
    969.67 ±  4%     -29.4%     684.67 ±  5%  interrupts.CPU72.RES:Rescheduling_interrupts
      3209 ± 10%     -32.2%       2176 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
    389673           -51.3%     189708 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
      1041 ±  5%     -32.2%     706.83 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
      3018 ±  2%     -30.3%       2104 ±  4%  interrupts.CPU74.CAL:Function_call_interrupts
    389660           -51.3%     189684 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      1000 ±  5%     -29.3%     707.00 ±  7%  interrupts.CPU74.RES:Rescheduling_interrupts
      2986 ±  3%     -29.0%       2120 ±  5%  interrupts.CPU75.CAL:Function_call_interrupts
    389667           -51.3%     189725 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
    993.50 ±  4%     -30.1%     694.00 ±  8%  interrupts.CPU75.RES:Rescheduling_interrupts
      3076 ±  3%     -34.4%       2017 ±  3%  interrupts.CPU76.CAL:Function_call_interrupts
    389759           -51.3%     189690 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
    991.67 ±  6%     -27.2%     721.50 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
      3061           -32.0%       2082 ±  2%  interrupts.CPU77.CAL:Function_call_interrupts
    389679           -51.3%     189713 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
    999.33 ±  4%     -31.7%     682.50 ±  7%  interrupts.CPU77.RES:Rescheduling_interrupts
      3036 ±  4%     -30.3%       2116 ±  2%  interrupts.CPU78.CAL:Function_call_interrupts
    389651           -51.3%     189732 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
    990.17 ±  5%     -31.9%     674.00 ±  6%  interrupts.CPU78.RES:Rescheduling_interrupts
      2992 ±  2%     -29.7%       2103 ±  4%  interrupts.CPU79.CAL:Function_call_interrupts
    389599           -51.3%     189704 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
    967.83 ±  6%     -29.6%     681.50 ±  4%  interrupts.CPU79.RES:Rescheduling_interrupts
      2944 ±  3%     -32.8%       1977 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
    389888           -51.3%     189744 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
    983.00 ±  5%     -31.4%     674.33 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
      3038 ±  4%     -30.0%       2127 ±  5%  interrupts.CPU80.CAL:Function_call_interrupts
    389662           -51.3%     189731 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
    976.67 ±  4%     -30.6%     677.83 ±  8%  interrupts.CPU80.RES:Rescheduling_interrupts
      3029 ±  3%     -31.7%       2068 ±  3%  interrupts.CPU81.CAL:Function_call_interrupts
    389634           -51.3%     189705 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
    983.83 ±  7%     -30.2%     687.17 ±  3%  interrupts.CPU81.RES:Rescheduling_interrupts
      3082 ±  5%     -32.4%       2083 ±  4%  interrupts.CPU82.CAL:Function_call_interrupts
    389666           -51.3%     189716 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
      1006 ±  6%     -28.5%     718.83 ±  4%  interrupts.CPU82.RES:Rescheduling_interrupts
      3003           -28.8%       2136 ±  5%  interrupts.CPU83.CAL:Function_call_interrupts
    389666           -51.3%     189720 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
    957.83 ±  2%     -28.2%     687.83 ±  5%  interrupts.CPU83.RES:Rescheduling_interrupts
      2904 ±  2%     -28.7%       2070 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
    389679           -51.3%     189728 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
    982.83 ±  5%     -30.1%     686.67 ±  4%  interrupts.CPU84.RES:Rescheduling_interrupts
      2959 ±  4%     -28.6%       2113 ±  4%  interrupts.CPU85.CAL:Function_call_interrupts
    389644           -51.3%     189675 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
    977.50 ±  7%     -27.5%     708.67 ±  5%  interrupts.CPU85.RES:Rescheduling_interrupts
      2956           -29.4%       2088 ±  5%  interrupts.CPU86.CAL:Function_call_interrupts
    389675           -51.3%     189672 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
    988.33 ±  6%     -28.4%     707.33 ±  6%  interrupts.CPU86.RES:Rescheduling_interrupts
      3031 ±  3%     -28.1%       2178 ±  5%  interrupts.CPU87.CAL:Function_call_interrupts
    389660           -51.3%     189720 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
      1071 ±  6%     -29.5%     754.67 ±  3%  interrupts.CPU87.RES:Rescheduling_interrupts
      3027 ±  3%     -31.4%       2076 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
    389879           -51.4%     189628 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
    973.00 ±  4%     -31.3%     668.50 ±  6%  interrupts.CPU9.RES:Rescheduling_interrupts
    527.17           -69.0%     163.33 ±  6%  interrupts.IWI:IRQ_work_interrupts
  34291805           -51.3%   16693957 ±  2%  interrupts.LOC:Local_timer_interrupts
     88088           -30.5%      61203 ±  3%  interrupts.RES:Rescheduling_interrupts
      1329 ± 11%     -24.4%       1004 ±  8%  interrupts.TLB:TLB_shootdowns
      0.02 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
      0.02 ± 98%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.cleaner_kthread.kthread.ret_from_fork
      0.03 ± 31%     -98.2%       0.00 ±223%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±126%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.07 ± 75%     -91.3%       0.01 ± 33%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01          -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.__process_pages_contig.lock_delalloc_pages
      0.01 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.extent_write_cache_pages.extent_writepages
      0.07 ±165%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.pagecache_get_page.prepare_pages
      0.01 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.extent_write_cache_pages
      0.00 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.prepare_pages
      0.00 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.wait_on_page_bit.write_all_supers.btrfs_commit_transaction
      0.01 ± 95%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.md_write_start.raid1_make_request.md_handle_request.md_submit_bio
      0.03 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
      0.11 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      0.01 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      0.21 ±155%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
      0.09 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.09 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      0.10 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
      0.04 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node
      0.15 ±142%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.btrfs_inode_lock.btrfs_buffered_write
      0.05 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      0.02 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.23 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      0.04 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit
      0.07 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      0.01 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
      0.05 ±162%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      0.07 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_unlink
      0.07 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      0.09 ±112%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_commit_inode_delayed_inode
      0.17 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      0.12 ±205%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_insert_delayed_dir_index
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode
      0.01 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode
      0.10 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      0.07 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.32 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.25 ±206%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      0.10 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.01 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.raid1_write_request.raid1_make_request.md_handle_request.md_submit_bio
      0.02 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.07 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
      0.05 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.04 ±  4%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.01 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_xattr
      0.01 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      0.09 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.03 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      0.10 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 69%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.01 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
      0.11 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_release_delayed_node
      0.22 ± 67%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      0.13 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      0.14 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
      0.02 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      0.03 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.11 ±174%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.md_thread.kthread.ret_from_fork
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.02 ±  5%     -69.4%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.03 ± 86%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      0.07 ±118%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.03 ± 10%   +1667.7%       0.57 ± 38%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.10 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.22 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
      0.04 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.cleaner_kthread.kthread.ret_from_fork
      0.64 ±210%     -98.5%       0.01 ± 46%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.11 ± 25%     -99.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      9.81 ± 26%     -97.7%       0.23 ±217%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.79 ±107%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      9.61 ± 40%     -99.9%       0.01 ± 25%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.__lock_page.__process_pages_contig.lock_delalloc_pages
      0.01 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.__lock_page.extent_write_cache_pages.extent_writepages
      0.23 ±155%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.__lock_page.pagecache_get_page.prepare_pages
      0.09 ±194%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.extent_write_cache_pages
      0.01 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.prepare_pages
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.write_all_supers.btrfs_commit_transaction
      0.04 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.md_write_start.raid1_make_request.md_handle_request.md_submit_bio
      0.05 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
     10.25 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      0.01 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      0.91 ±160%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
     12.69 ±  3%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.59 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      0.99 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
      0.10 ±110%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node
      0.24 ±143%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.btrfs_inode_lock.btrfs_buffered_write
      2.07 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      0.15 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
     12.46 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      0.64 ± 75%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit
     11.18 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      0.01 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
      0.39 ±197%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      0.37 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_unlink
      1.17 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      2.65 ±134%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_commit_inode_delayed_inode
      2.26 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      0.47 ±216%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_insert_delayed_dir_index
      0.01 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode
      0.01 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode
     12.80          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      2.94 ±141%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      8.48 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1.21 ±210%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      0.12 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      8.16 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      1.67 ±164%    -100.0%       0.00        perf-sched.sch_delay.max.ms.raid1_write_request.raid1_make_request.md_handle_request.md_submit_bio
      0.12 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      4.73 ± 53%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
    413.28 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
     12.69          -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.03 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_xattr
      0.05 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
    217.96 ±210%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.13 ±  2%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
     11.18 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    198.46 ±209%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.16 ± 84%     -99.2%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.13 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
      2.30 ±172%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_release_delayed_node
      4.55 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      4.66 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      6.39 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
      0.54 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      0.19 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.57 ±196%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.md_thread.kthread.ret_from_fork
      6.32 ± 67%     -89.3%       0.67 ±221%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.50 ± 33%     -93.4%       0.03 ± 87%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.21 ±132%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      4.39 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      4.77 ± 68%     -42.2%       2.76        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
    599.58 ± 97%     -98.9%       6.36 ± 71%  perf-sched.total_sch_delay.max.ms
     10.70           -98.4%       0.17 ± 16%  perf-sched.total_wait_and_delay.average.ms
    558281           -99.9%     281.00 ± 21%  perf-sched.total_wait_and_delay.count.ms
      8534 ±  6%     -99.9%       9.36 ± 54%  perf-sched.total_wait_and_delay.max.ms
     10.65           -98.7%       0.14 ± 13%  perf-sched.total_wait_time.average.ms
      8534 ±  6%     -99.9%       8.33 ± 59%  perf-sched.total_wait_time.max.ms
    891.34 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    180.32 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
    737.60 ±  8%    -100.0%       0.00 ±223%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    279.88           -99.9%       0.38 ±110%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     19.04 ± 39%    -100.0%       0.01 ±223%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    313.17 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    281.69 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
    105.77 ± 26%     -99.8%       0.18 ±110%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     31.57 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
     26.05 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     47.72 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
     47.55 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
     20.76 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
     29.01 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
     44.28 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      4.21          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1.21 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
     93.67 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
     33.12 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
    117.98          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    210.83 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    175.84 ± 85%     -98.8%       2.03 ± 50%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     52.13 ±  3%    -100.0%       0.00 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.82          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    897.35 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.md_thread.kthread.ret_from_fork
    536.93 ±  3%    -100.0%       0.01 ±  9%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    313.52 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
    377.83 ±  2%     -99.8%       0.79 ± 40%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     20.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     87.33 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
     12.33 ±  8%     -98.6%       0.17 ±223%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    245.33           -97.7%       5.67 ± 34%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    250.00           -99.8%       0.50 ±152%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.00 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2.00          -100.0%       0.00        perf-sched.wait_and_delay.count.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
      1609 ± 30%     -95.5%      72.50 ± 73%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
    536.67 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      2991 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     75.50 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
    422.83 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      1632 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      2189          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
    204.17 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    455323          -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
     65656 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
     10399          -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
     39.17 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      2163          -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1763 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    326.17           -99.9%       0.17 ±223%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     40.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      6.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.md_thread.kthread.ret_from_fork
      1771           -95.0%      88.33        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     19.17 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      2144 ±  3%     -99.7%       6.50 ± 73%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.86          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    342.26 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
      1000          -100.0%       0.00 ±223%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1951 ± 35%     -99.9%       2.17 ±115%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1002          -100.0%       0.01 ±223%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1087 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    338.09 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
      1187 ± 30%     -99.9%       0.87 ±119%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1291          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      1311          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      1176 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      1281          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      1301          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      1296          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      1252 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      4103 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1297          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      1321          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
    181.27 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      1311          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1319          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    446.66 ± 19%     -98.2%       8.02 ± 56%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1500 ± 18%    -100.0%       0.00 ±223%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    505.07          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5335 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.md_thread.kthread.ret_from_fork
      8534 ±  6%    -100.0%       0.03 ± 87%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    333.17 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      1632 ± 83%     -99.7%       5.28 ±106%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    891.32 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    180.31 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
    275.67 ±184%    -100.0%       0.00        perf-sched.wait_time.avg.ms.cleaner_kthread.kthread.ret_from_fork
    737.57 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    279.78           -99.9%       0.35 ±111%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     19.02 ± 39%    -100.0%       0.01 ±223%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    313.15 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     12.58 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.__lock_page.__process_pages_contig.lock_delalloc_pages
    129.40 ±102%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.__lock_page.extent_write_cache_pages.extent_writepages
      0.41 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.__lock_page.pagecache_get_page.prepare_pages
     20.52 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.extent_write_cache_pages
      0.41 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.prepare_pages
      0.02 ± 92%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.write_all_supers.btrfs_commit_transaction
      0.02 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.md_write_start.raid1_make_request.md_handle_request.md_submit_bio
    281.66 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
    105.63 ± 26%     -99.9%       0.11 ±136%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     31.46 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      1.44 ±107%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      0.62 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
     25.96 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.56 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      0.52 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
      0.12 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node
      0.51 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.btrfs_inode_lock.btrfs_buffered_write
      0.01 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
     47.67 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
    140.54 ± 75%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
    247.53 ±117%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
     47.32 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
     24.82 ± 99%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit
     20.68 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      0.47 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
    384.46 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
    237.37 ± 95%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_unlink
     67.63 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      0.07 ± 85%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.md_write_start.raid1_make_request.md_handle_request
     53.34 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_commit_inode_delayed_inode
     21.59 ±139%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      1.31 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_insert_delayed_dir_index
     10.66 ±212%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode
      1.12 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode
     28.90 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
     21.74 ±108%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.06 ± 80%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
     76.84 ±143%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.btrfs_evict_inode.evict
     39.64 ±221%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      9.06 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     44.18 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.00 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      0.15 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.raid1_write_request.raid1_make_request.md_handle_request.md_submit_bio
      2.98 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.64 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
      4.16          -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1.17 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
     25.00 ±212%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_xattr
      0.78 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
     93.58 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
     33.09 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
    117.89          -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    210.49 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    175.79 ± 85%     -99.2%       1.42 ± 31%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     52.13 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.81 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
     11.66 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_release_delayed_node
     26.32 ±110%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
     37.15 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
     31.23 ± 68%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
     16.32 ±219%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
    478.80          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.80 ±174%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    897.24 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.md_thread.kthread.ret_from_fork
      3.58           -17.4%       2.96 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
    536.91 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    313.49 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      0.03 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    377.80 ±  2%     -99.9%       0.21 ±223%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    999.79          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    342.25 ± 21%    -100.0%       0.00        perf-sched.wait_time.max.ms.btrfs_start_ordered_extent.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
      2071 ±140%    -100.0%       0.00        perf-sched.wait_time.max.ms.cleaner_kthread.kthread.ret_from_fork
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1951 ± 35%     -99.9%       2.17 ±116%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1002          -100.0%       0.01 ±223%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1087 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1241 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.43 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.__lock_page.__process_pages_contig.lock_delalloc_pages
      2560 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.__lock_page.extent_write_cache_pages.extent_writepages
      0.68 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.__lock_page.pagecache_get_page.prepare_pages
    297.29 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.extent_write_cache_pages
      4.07 ± 76%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.prepare_pages
      0.04 ±107%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.write_all_supers.btrfs_commit_transaction
      0.06 ± 81%    -100.0%       0.00        perf-sched.wait_time.max.ms.md_write_start.raid1_make_request.md_handle_request.md_submit_bio
    338.06 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.percpu_ref_switch_to_atomic_sync.set_in_sync.md_check_recovery.raid1d
      1025          -100.0%       0.40 ± 83%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1289          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      1.80 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      1.46 ± 88%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
      1311          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      1.35 ± 31%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      2.87 ± 94%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
      0.23 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node
      0.80 ± 84%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.btrfs_inode_lock.btrfs_buffered_write
      0.02 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      1176 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      1051 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
    778.82 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
      1277          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
    535.12 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit
      1298          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      1.04 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
      1025 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
    746.26 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_unlink
    999.60 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      0.07 ± 85%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.md_write_start.raid1_make_request.md_handle_request
    946.43 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_commit_inode_delayed_inode
    381.48 ±141%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      1.93 ± 40%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_insert_delayed_dir_index
    192.48 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode
      1.41 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode
      1292          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
    775.35 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      2.68 ± 86%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    391.34 ±141%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.btrfs_evict_inode.evict
    196.99 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1001          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1251 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.00 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      1.79 ±150%    -100.0%       0.00        perf-sched.wait_time.max.ms.raid1_write_request.raid1_make_request.md_handle_request.md_submit_bio
      5.08          -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      8.38 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
      4102 ± 63%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1294          -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
    193.72 ±219%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_xattr
      2.52 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      1320          -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
    181.20 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      1311          -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1317          -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    446.58 ± 19%     -98.8%       5.28 ± 58%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1500 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     15.94 ±199%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
    195.75 ±220%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_release_delayed_node
    615.31 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      1251 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      1035 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
    193.40 ±221%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
    505.03          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.80 ±174%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      5335 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.md_thread.kthread.ret_from_fork
     11.82 ± 23%     -59.2%       4.82 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      8534 ±  6%    -100.0%       0.01 ±223%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    333.02 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_extent_bit.constprop.0.lock_extent_bits.lock_and_cleanup_extent_if_need
      1.12 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1632 ± 83%     -99.8%       2.98 ±223%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork



***************************************************************************************************
lkp-csl-2sp9: 88 threads Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/btrfs/x86_64-rhel-8.3/1500/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_cp/aim7/0x5003006

commit: 
  c7f9865055 ("Merge branch 'for-next-next-v5.12-20210322' into for-next-20210322")
  b05645404a ("btrfs: use percpu_read_positive instead of sum_positive for need_preempt")

c7f98650557ad6d6 b05645404a7d4f798a510154272 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     16285          +113.7%      34796 ±  3%  aim7.jobs-per-min
    552.75           -53.1%     259.01 ±  3%  aim7.time.elapsed_time
    552.75           -53.1%     259.01 ±  3%  aim7.time.elapsed_time.max
    520304           -28.8%     370507        aim7.time.involuntary_context_switches
      2848            -3.1%       2758 ±  2%  aim7.time.maximum_resident_set_size
    248273           -37.7%     154710 ±  3%  aim7.time.minor_page_faults
     41029           -56.3%      17943 ±  3%  aim7.time.system_time
     27.02 ±  2%     -14.1%      23.22        aim7.time.user_time
  31743847           -21.0%   25076617        aim7.time.voluntary_context_switches
     14.79           +39.8%      20.67        iostat.cpu.idle
     85.10            -7.0%      79.12        iostat.cpu.system
    583.27           -50.4%     289.46 ±  2%  uptime.boot
      9501           -27.8%       6858        uptime.idle
     17.17            +8.9       26.09 ±  2%  mpstat.cpu.all.idle%
      0.00 ±  2%      -0.0        0.00 ±  3%  mpstat.cpu.all.iowait%
     81.71            -9.0       72.66        mpstat.cpu.all.sys%
      0.12            +0.1        0.24 ±  3%  mpstat.cpu.all.usr%
   1401839            -9.6%    1267856        cpuidle.C1.usage
 6.961e+09           -39.0%  4.246e+09 ± 10%  cpuidle.C1E.time
  41563072           -25.2%   31075590 ±  2%  cpuidle.C1E.usage
   2682235           -16.6%    2236199 ±  2%  cpuidle.POLL.time
    146958           -15.1%     124815 ±  9%  cpuidle.POLL.usage
    175335           -13.2%     152187 ±  2%  meminfo.AnonHugePages
     11.00         +4969.7%     557.67 ± 76%  meminfo.Buffers
    318887           +16.9%     372654        meminfo.Inactive
    317370           +15.4%     366112        meminfo.Inactive(anon)
      1516          +331.3%       6541 ± 48%  meminfo.Inactive(file)
     47973           +82.5%      87547        meminfo.Mapped
     14.00           +45.2%      20.33 ±  2%  vmstat.cpu.id
     85.00            -7.5%      78.67        vmstat.cpu.sy
      3379           -18.9%       2741 ± 11%  vmstat.io.bo
     11.00         +4969.7%     557.67 ± 76%  vmstat.memory.buff
     78.50           -10.8%      70.00        vmstat.procs.r
    111871           +69.0%     189111        vmstat.system.cs
    180399            +1.4%     182933        vmstat.system.in
    115374 ± 26%     -52.9%      54361 ± 92%  numa-meminfo.node0.AnonHugePages
    799.00 ± 12%    +569.5%       5349 ± 58%  numa-meminfo.node0.Inactive(file)
     19699           +95.5%      38510 ±  7%  numa-meminfo.node0.Mapped
   1486609 ±  5%     +20.9%    1796861 ±  4%  numa-meminfo.node0.MemUsed
    595737 ±  4%     -12.0%     524528 ± 14%  numa-meminfo.node1.Active
    568562 ±  4%     -12.4%     497794 ± 15%  numa-meminfo.node1.Active(anon)
     28097           +73.7%      48812 ±  3%  numa-meminfo.node1.Mapped
   1966696 ±  3%     -10.2%    1766350 ±  4%  numa-meminfo.node1.MemUsed
    123006 ± 27%     -30.1%      86000 ±  2%  numa-meminfo.node1.SUnreclaim
    175288 ± 19%     -20.5%     139278        numa-meminfo.node1.Slab
    556.00           -26.6%     408.33 ±  8%  slabinfo.biovec-max.active_objs
    587.50           -25.7%     436.67 ±  6%  slabinfo.biovec-max.num_objs
      1636           -36.4%       1040 ±  9%  slabinfo.btrfs_ordered_extent.active_objs
      1636           -36.4%       1040 ±  9%  slabinfo.btrfs_ordered_extent.num_objs
      2522 ±  7%     -14.9%       2145 ±  7%  slabinfo.dmaengine-unmap-16.active_objs
      2522 ±  7%     -14.9%       2145 ±  7%  slabinfo.dmaengine-unmap-16.num_objs
      2792           -18.1%       2286 ± 11%  slabinfo.mnt_cache.active_objs
      2792           -18.1%       2286 ± 11%  slabinfo.mnt_cache.num_objs
     15095           -14.5%      12900        slabinfo.vmap_area.active_objs
     15096           -14.5%      12907        slabinfo.vmap_area.num_objs
    199.00 ± 12%    +572.7%       1338 ± 58%  numa-vmstat.node0.nr_inactive_file
      4891           +93.5%       9466 ±  7%  numa-vmstat.node0.nr_mapped
    114639           -64.0%      41294 ± 18%  numa-vmstat.node0.nr_written
    199.00 ± 12%    +572.7%       1338 ± 58%  numa-vmstat.node0.nr_zone_inactive_file
     45459 ± 24%    +188.3%     131047 ± 27%  numa-vmstat.node0.numa_other
    142309 ±  4%     -12.4%     124712 ± 15%  numa-vmstat.node1.nr_active_anon
      6921           +72.9%      11970 ±  2%  numa-vmstat.node1.nr_mapped
     30745 ± 27%     -30.1%      21499 ±  2%  numa-vmstat.node1.nr_slab_unreclaimable
    114162 ±  2%     -63.8%      41311 ± 16%  numa-vmstat.node1.nr_written
    142309 ±  4%     -12.4%     124712 ± 15%  numa-vmstat.node1.nr_zone_active_anon
    187575 ±  5%     -46.0%     101230 ± 36%  numa-vmstat.node1.numa_other
    198026            -2.6%     192793        proc-vmstat.nr_active_anon
     13652            +2.1%      13945        proc-vmstat.nr_active_file
     12110            +2.7%      12441        proc-vmstat.nr_dirty
     79375           +15.6%      91740        proc-vmstat.nr_inactive_anon
    379.00          +331.1%       1634 ± 48%  proc-vmstat.nr_inactive_file
     38542            +1.1%      38985        proc-vmstat.nr_kernel_stack
     12005           +83.0%      21974        proc-vmstat.nr_mapped
    205077            +3.2%     211577        proc-vmstat.nr_shmem
     58554            -1.1%      57921        proc-vmstat.nr_slab_unreclaimable
    469248           -61.7%     179938 ± 13%  proc-vmstat.nr_written
    198026            -2.6%     192793        proc-vmstat.nr_zone_active_anon
     13652            +2.1%      13945        proc-vmstat.nr_zone_active_file
     79375           +15.6%      91740        proc-vmstat.nr_zone_inactive_anon
    379.00          +331.1%       1634 ± 48%  proc-vmstat.nr_zone_inactive_file
     11799            -1.2%      11659        proc-vmstat.nr_zone_write_pending
    218845           -33.3%     146043        proc-vmstat.numa_hint_faults
    144367 ±  2%     -39.4%      87504 ±  5%  proc-vmstat.numa_hint_faults_local
  40345161            -1.2%   39849274        proc-vmstat.numa_hit
  40264107            -1.2%   39769269        proc-vmstat.numa_local
     81054            -1.3%      80005        proc-vmstat.numa_other
     46245 ± 32%     -42.6%      26534 ± 26%  proc-vmstat.numa_pages_migrated
    351957 ±  4%     -19.6%     283113 ±  4%  proc-vmstat.numa_pte_updates
   2735158            +2.8%    2810452        proc-vmstat.pgactivate
  40502971            -1.3%   39984533        proc-vmstat.pgalloc_normal
   2010628           -43.8%    1129490        proc-vmstat.pgfault
  40193886            -1.5%   39585361        proc-vmstat.pgfree
     46245 ± 32%     -42.6%      26534 ± 26%  proc-vmstat.pgmigrate_success
   1877112           -61.7%     719720 ± 13%  proc-vmstat.pgpgout
    109115           -51.0%      53499 ±  3%  proc-vmstat.pgreuse
    233.62 ±  7%    +105.6%     480.40 ± 11%  sched_debug.cfs_rq:/.load_avg.avg
     16913 ±  8%     +93.9%      32794 ±  8%  sched_debug.cfs_rq:/.load_avg.max
      1904 ±  8%     +97.8%       3765 ±  8%  sched_debug.cfs_rq:/.load_avg.stddev
  15493048           -62.3%    5837041        sched_debug.cfs_rq:/.min_vruntime.avg
  15622073           -62.0%    5929696        sched_debug.cfs_rq:/.min_vruntime.max
  15142850           -62.0%    5757245        sched_debug.cfs_rq:/.min_vruntime.min
     74849 ±  7%     -57.7%      31657 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.77           -10.7%       0.69 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
     99.30           +98.9%     197.53        sched_debug.cfs_rq:/.removed.load_avg.max
     14.86 ± 23%    +108.3%      30.95 ± 21%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     42.80 ±  3%     +62.6%      69.60 ± 33%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     42.80 ±  3%     +62.6%      69.60 ± 33%  sched_debug.cfs_rq:/.removed.util_avg.max
    786.85           -12.4%     689.59        sched_debug.cfs_rq:/.runnable_avg.avg
      1913 ±  3%     -12.3%       1677 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    318422 ±  7%     -86.0%      44714 ± 54%  sched_debug.cfs_rq:/.spread0.avg
    447250 ±  3%     -69.3%     137476 ± 24%  sched_debug.cfs_rq:/.spread0.max
     74712 ±  7%     -57.6%      31686 ±  4%  sched_debug.cfs_rq:/.spread0.stddev
    725.50            -9.4%     657.50 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    483.47 ±  2%     -24.5%     365.00 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1308 ±  2%      -8.2%       1201 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
    289.45           -14.6%     247.21        sched_debug.cfs_rq:/.util_est_enqueued.stddev
     93579 ±  7%     -25.5%      69682 ±  4%  sched_debug.cpu.avg_idle.min
    299640           -50.1%     149462        sched_debug.cpu.clock.avg
    299655           -50.1%     149477        sched_debug.cpu.clock.max
    299624           -50.1%     149446        sched_debug.cpu.clock.min
    296705           -50.1%     148010        sched_debug.cpu.clock_task.avg
    296925           -50.1%     148200        sched_debug.cpu.clock_task.max
    292304           -51.1%     142968        sched_debug.cpu.clock_task.min
      2804           -15.9%       2357 ±  4%  sched_debug.cpu.curr->pid.avg
     10705           -37.9%       6652 ±  4%  sched_debug.cpu.curr->pid.max
      1576 ±  3%     -14.3%       1350 ±  9%  sched_debug.cpu.curr->pid.stddev
      3073 ± 58%    +304.2%      12422 ± 26%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.84           -14.2%       0.72 ±  4%  sched_debug.cpu.nr_running.avg
    340648           -25.4%     254284        sched_debug.cpu.nr_switches.avg
    353484           -25.5%     263402        sched_debug.cpu.nr_switches.max
    336135           -26.2%     248055        sched_debug.cpu.nr_switches.min
    520.55 ±  7%     -55.0%     234.40 ±  9%  sched_debug.cpu.nr_uninterruptible.max
   -337.35           -70.4%    -100.00        sched_debug.cpu.nr_uninterruptible.min
    142.17           -62.8%      52.88 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
    299624           -50.1%     149446        sched_debug.cpu_clk
    299130           -50.2%     148951        sched_debug.ktime
    299984           -50.1%     149805        sched_debug.sched_clk
      3.24          +102.1%       6.54 ±  9%  perf-stat.i.MPKI
      0.33            +0.2        0.58 ± 13%  perf-stat.i.branch-miss-rate%
  15596599           +50.6%   23492055 ±  3%  perf-stat.i.branch-misses
     23.99            +6.3       30.27 ±  3%  perf-stat.i.cache-miss-rate%
  17143469          +154.2%   43578703 ±  7%  perf-stat.i.cache-misses
  71149237           +98.4%  1.412e+08 ±  4%  perf-stat.i.cache-references
    112366           +69.8%     190852        perf-stat.i.context-switches
      9.19            -9.9%       8.28        perf-stat.i.cpi
 2.093e+11            -6.5%  1.956e+11        perf-stat.i.cpu-cycles
     12086           -63.2%       4450 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  5%      +0.0        0.02 ± 44%  perf-stat.i.dTLB-load-miss-rate%
    533605 ±  5%     +76.5%     941571 ± 11%  perf-stat.i.dTLB-load-misses
 5.634e+09            +7.1%  6.034e+09        perf-stat.i.dTLB-loads
     64242 ±  2%     +34.7%      86540 ±  6%  perf-stat.i.dTLB-store-misses
 8.412e+08           +70.1%  1.431e+09 ±  2%  perf-stat.i.dTLB-stores
     40.11 ±  2%      -1.1       39.05        perf-stat.i.iTLB-load-miss-rate%
   4051220 ±  2%     +61.3%    6532783        perf-stat.i.iTLB-load-misses
   6046856           +69.8%   10269969 ±  2%  perf-stat.i.iTLB-loads
 2.252e+10            +2.8%  2.315e+10        perf-stat.i.instructions
      5529 ±  2%     -36.3%       3523        perf-stat.i.instructions-per-iTLB-miss
      0.12           +17.3%       0.14        perf-stat.i.ipc
      1.25          +141.4%       3.01 ± 37%  perf-stat.i.major-faults
      2.38            -6.5%       2.22        perf-stat.i.metric.GHz
      0.86            +5.9%       0.92        perf-stat.i.metric.K/sec
    135.02            +9.1%     147.36        perf-stat.i.metric.M/sec
      3547           +18.9%       4218        perf-stat.i.minor-faults
     91.25            -1.1       90.17        perf-stat.i.node-load-miss-rate%
   5662762           +86.5%   10559629 ±  2%  perf-stat.i.node-load-misses
    539972          +108.4%    1125049 ±  2%  perf-stat.i.node-loads
     91.47            -1.1       90.37        perf-stat.i.node-store-miss-rate%
   2868624           +77.5%    5090913 ±  2%  perf-stat.i.node-store-misses
    265081           +92.2%     509509 ±  2%  perf-stat.i.node-stores
      3548           +19.0%       4221        perf-stat.i.page-faults
      3.16           +93.1%       6.10 ±  5%  perf-stat.overall.MPKI
      0.29            +0.1        0.44 ±  2%  perf-stat.overall.branch-miss-rate%
     24.09            +6.7       30.84 ±  2%  perf-stat.overall.cache-miss-rate%
      9.29            -9.0%       8.45        perf-stat.overall.cpi
     12208           -63.0%       4511 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  5%      +0.0        0.02 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  2%      -0.0        0.01 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     40.12 ±  2%      -1.2       38.89        perf-stat.overall.iTLB-load-miss-rate%
      5562 ±  2%     -36.3%       3543        perf-stat.overall.instructions-per-iTLB-miss
      0.11            +9.9%       0.12        perf-stat.overall.ipc
     91.29            -0.9       90.37        perf-stat.overall.node-load-miss-rate%
  15567024           +50.3%   23398024 ±  3%  perf-stat.ps.branch-misses
  17112764          +153.7%   43409527 ±  7%  perf-stat.ps.cache-misses
  71027425           +98.0%  1.406e+08 ±  4%  perf-stat.ps.cache-references
    112169           +69.5%     190116        perf-stat.ps.context-switches
 2.089e+11            -6.7%  1.949e+11        perf-stat.ps.cpu-cycles
      9822            -0.7%       9757        perf-stat.ps.cpu-migrations
    533953 ±  5%     +76.0%     939956 ± 12%  perf-stat.ps.dTLB-load-misses
 5.624e+09            +6.9%  6.011e+09        perf-stat.ps.dTLB-loads
     64163 ±  2%     +34.5%      86291 ±  6%  perf-stat.ps.dTLB-store-misses
 8.397e+08           +69.7%  1.425e+09 ±  2%  perf-stat.ps.dTLB-stores
   4044012 ±  2%     +60.9%    6507724        perf-stat.ps.iTLB-load-misses
   6036161           +69.5%   10230248 ±  2%  perf-stat.ps.iTLB-loads
 2.248e+10            +2.6%  2.306e+10        perf-stat.ps.instructions
      1.24          +140.9%       2.99 ± 37%  perf-stat.ps.major-faults
      3540           +18.6%       4200        perf-stat.ps.minor-faults
   5652724           +86.1%   10519046 ±  2%  perf-stat.ps.node-load-misses
    539172          +107.9%    1121070 ±  2%  perf-stat.ps.node-loads
   2863578           +77.1%    5071382 ±  2%  perf-stat.ps.node-store-misses
    264637           +91.8%     507604 ±  2%  perf-stat.ps.node-stores
      3542           +18.7%       4203        perf-stat.ps.page-faults
 1.244e+13           -51.8%  5.991e+12 ±  2%  perf-stat.total.instructions
      0.03 ±  8%     -40.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.42 ± 99%     -99.8%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 46%     -51.1%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.06 ± 87%     -89.2%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01           -37.5%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.08           -35.8%       0.05 ±  2%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.01 ± 21%    +143.5%       0.03 ± 53%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      0.23 ± 19%     -81.4%       0.04 ± 84%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
      0.02 ± 63%     -71.4%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.15 ±  7%     -49.7%       0.07 ± 58%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      0.08 ± 73%     -80.7%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      0.07 ± 18%     -66.9%       0.02 ± 56%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      0.01 ± 11%     -33.3%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode
      1.27 ± 93%     -96.5%       0.04 ± 24%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      0.11 ±  5%     -65.7%       0.04 ± 46%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.01 ±  9%     -51.5%       0.00 ± 70%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      0.24 ± 98%     -99.6%       0.00 ±141%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.03           -64.1%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.08 ± 10%     -53.0%       0.04 ± 16%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
      0.07           -66.2%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.08 ±  5%     -77.5%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.27 ± 82%     -76.0%       0.06 ± 74%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.34 ± 98%     -99.1%       0.00 ±141%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
      0.10 ±  8%     -35.9%       0.07 ± 13%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.01 ± 16%     +88.9%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.01 ± 91%     -68.0%       0.00 ±141%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.05 ± 28%     -57.2%       0.02 ± 31%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_release_delayed_node
      0.05 ± 62%     -43.2%       0.03 ± 70%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      0.09 ± 64%     -80.5%       0.02 ± 24%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      0.04           -23.7%       0.03 ± 14%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
      0.02 ±  8%     -44.8%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      0.03           -47.2%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.25 ± 61%     -99.9%       0.00 ± 72%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      0.02 ±  6%     -44.2%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ±  3%     -39.4%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.04 ±  5%     -53.3%       0.02 ±  9%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.10           -44.5%       0.06 ± 19%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.44 ± 98%     -99.8%       0.01 ±  3%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ± 56%     -62.3%       0.01 ± 33%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.97 ± 42%     -60.9%       0.38 ± 21%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±  9%   +1790.9%       0.10 ±125%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
      0.03 ± 59%    +614.0%       0.25 ± 65%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      0.00 ±100%    +193.3%       0.01 ± 25%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_tree_ref.btrfs_free_tree_block
      0.01 ±  9%    +100.0%       0.02 ± 48%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
      0.65 ± 97%     -98.7%       0.01 ± 39%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.btrfs_wq_run_delayed_node.isra
      4.54 ±  3%     -67.5%       1.48 ± 59%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.04 ±  2%     -15.2%       0.04 ±  8%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.01 ±  9%     -51.5%       0.00 ± 70%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      0.24 ± 98%     -99.6%       0.00 ±141%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.16 ± 21%     -77.8%       0.03 ± 16%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.34 ± 98%     -99.1%       0.00 ±141%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
      0.11 ± 30%     -66.4%       0.04 ± 22%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      0.01 ± 33%     +77.8%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      4.12 ± 97%     -55.8%       1.82 ±139%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2.63 ± 86%     -83.7%       0.43 ±105%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      0.12 ± 14%     -60.5%       0.05 ±  9%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.25 ± 61%     -99.9%       0.00 ± 72%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      8.36 ± 54%     -57.5%       3.55 ±127%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      5.55 ± 43%     -49.1%       2.82 ±  2%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.08           -68.2%       0.02 ±  3%  perf-sched.total_sch_delay.average.ms
      4885 ±  4%     -54.9%       2204 ±  5%  perf-sched.total_sch_delay.max.ms
     16.98           -15.5%      14.35        perf-sched.total_wait_and_delay.average.ms
    568532           +63.2%     927754        perf-sched.total_wait_and_delay.count.ms
     16.91           -15.2%      14.33        perf-sched.total_wait_time.average.ms
    114.56 ±  8%     -25.9%      84.90 ± 23%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    141.37 ± 10%     -44.1%      79.00 ±  5%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
     93.54 ±  8%     -39.9%      56.20 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
    674.11 ± 24%     -59.0%     276.11 ± 33%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
    193.05 ±  4%     -49.1%      98.23 ± 45%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
     79.28 ± 16%     -32.3%      53.71 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      1833 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
    104.83 ±  5%     -49.1%      53.33 ± 22%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      1096           -41.7%     638.78 ±  7%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    524.92 ±  4%     -37.6%     327.66 ±  6%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     49.11 ±  7%     -28.3%      35.19 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    526.54 ± 12%     -14.7%     449.33 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    561.00 ±  3%     +21.2%     680.00 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      2915           +20.1%       3501 ±  2%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     18.00 ±  5%     +68.5%      30.33 ± 21%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
     17.50 ±100%    +357.1%      80.00 ± 12%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
    445.00 ±  7%     +40.1%     623.67 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      1538           +28.8%       1981 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      3.00 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      2146           +22.2%       2622 ±  2%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
    498366           +64.1%     817888        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
     36568 ±  3%     +57.9%      57723 ±  4%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
     10327 ±  2%    +107.1%      21383 ±  4%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      1104          +157.1%       2840 ±  7%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2612           +81.0%       4728        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     36.50 ± 31%     -37.9%      22.67 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    337.00 ±  2%     +39.2%     469.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     50.00 ± 18%    +140.0%     120.00 ± 15%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
     24.00 ±100%    +480.6%     139.33 ± 13%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_insert_delayed_dir_index
      4981           -52.5%       2365 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      4988 ±  2%     -52.1%       2390 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      4888           -51.9%       2352 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      4894           -51.3%       2381 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      4892           -51.1%       2393 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      4866          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      5000 ±  2%     -52.3%       2384 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      4987 ±  2%     -52.0%       2394 ±  4%  perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      5008 ±  2%     -51.9%       2407 ±  4%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      4997 ±  2%     -51.7%       2411 ±  4%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4994 ±  2%     -51.7%       2410 ±  4%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1329 ± 24%     -19.2%       1074 ±  9%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      4778           -50.5%       2364 ±  3%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
    585.29 ± 99%     -82.9%     100.01 ±140%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.09 ± 69%  +11996.6%      11.43 ± 76%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    114.55 ±  8%     -25.9%      84.89 ± 23%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    141.27 ± 10%     -44.1%      78.93 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      0.38 ± 26%     -35.0%       0.25 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.btrfs_buffered_write.btrfs_file_write_iter
     93.46 ±  8%     -39.9%      56.14 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.47 ± 27%     -50.9%       0.23 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.btrfs_evict_inode.evict.__dentry_kill
      0.54 ±  6%     -51.6%       0.26 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot
    674.08 ± 24%     -59.1%     275.91 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
    192.91 ±  4%     -49.1%      98.16 ± 45%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
     81.50 ± 99%     -99.4%       0.45 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit
     79.22 ± 16%     -32.3%      53.66 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      0.57 ±  4%     -54.6%       0.26 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode
      1833 ± 34%    -100.0%       0.20 ± 12%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      0.86           -68.7%       0.27 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      0.58 ± 45%     -53.7%       0.27 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.btrfs_wq_run_delayed_node.isra
      0.01 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_async_run_delayed_root
      0.83 ± 12%     -67.8%       0.27 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
    103.56 ±  6%     -48.5%      53.29 ± 22%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      0.43 ±  8%     -61.1%       0.17 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.42 ±  2%     -32.8%       0.28 ± 18%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.btrfs_evict_inode.evict
      0.21 ± 41%     -67.1%       0.07 ± 72%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      0.53 ± 91%     -94.0%       0.03 ±141%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
      1096           -41.7%     638.64 ±  7%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    524.81 ±  4%     -37.6%     327.59 ±  6%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     49.10 ±  7%     -28.3%      35.19 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.73 ±  4%     -69.7%       0.22 ± 13%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
      0.99 ± 19%   +6129.1%      61.67 ± 50%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      6.19 ± 40%     -86.8%       0.82 ±134%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      0.02 ± 29%     -62.2%       0.01 ± 23%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
    526.50 ± 12%     -14.7%     449.31 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      2339 ± 99%     -65.9%     798.57 ±141%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.28 ±  2%    +283.5%       4.90 ± 50%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      7.20 ± 82%  +31915.5%       2304 ±  3%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      4981           -52.5%       2365 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pagecache_get_page.prepare_pages
      4988 ±  2%     -52.1%       2390 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.82 ± 41%     -58.4%       0.34 ± 19%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.btrfs_evict_inode.evict.__dentry_kill
      4888           -51.9%       2352 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      4894           -51.5%       2375 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent
      4892           -51.1%       2392 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_extent_state.set_extent_bit
      4866          -100.0%       0.45 ± 30%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create
      4.84 ± 41%     -77.2%       1.10 ± 17%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join
      1.29 ± 39%     -67.0%       0.43 ± 28%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.btrfs_wq_run_delayed_node.isra
      0.01 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_async_run_delayed_root
      3.36 ±  2%     -33.3%       2.24 ± 28%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__btrfs_release_delayed_node.btrfs_evict_inode
      4980 ±  2%     -52.1%       2384 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.prepare_pages.btrfs_buffered_write
      0.49 ±  4%     -50.2%       0.24 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      2.51 ± 56%     -55.9%       1.11 ± 30%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.21 ± 41%     -67.1%       0.07 ± 72%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion_io.write_all_supers.btrfs_commit_transaction
      9.29 ± 36%  +16791.5%       1570 ± 70%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_next_old_leaf.btrfs_get_extent
      4987 ±  2%     -52.0%       2394 ±  4%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_file_extent
      5002 ±  2%     -51.9%       2407 ±  4%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.53 ± 91%     -94.0%       0.03 ±141%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
      4995 ±  2%     -51.7%       2411 ±  4%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4994 ±  2%     -51.7%       2410 ±  4%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1329 ± 24%     -19.2%       1074 ±  9%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.60 ± 16%     -59.4%       0.65 ±  2%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__btrfs_commit_inode_delayed_items
      2.64 ± 10%  +87739.7%       2318 ±  2%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delayed_update_inode
      4778           -50.5%       2364 ±  3%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.btrfs_delete_delayed_dir_index
      6.19 ± 40%     -86.8%       0.82 ±134%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     29.94 ± 23%     -72.2%       8.32 ±  5%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.03 ± 52%     -73.3%       0.01 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      1.06 ±  2%     -31.2%       0.73 ± 14%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    107283           -54.2%      49119 ±  5%  softirqs.CPU0.RCU
    123038           -52.5%      58499 ±  5%  softirqs.CPU0.SCHED
    106229           -56.2%      46527 ±  3%  softirqs.CPU1.RCU
    121276           -53.7%      56132 ±  4%  softirqs.CPU1.SCHED
    107177           -56.6%      46506 ±  3%  softirqs.CPU10.RCU
    120325           -54.0%      55299 ±  4%  softirqs.CPU10.SCHED
    106243           -56.1%      46627 ±  3%  softirqs.CPU11.RCU
    120180           -54.0%      55261 ±  4%  softirqs.CPU11.SCHED
    105922           -55.9%      46762 ±  3%  softirqs.CPU12.RCU
    119754           -53.9%      55180 ±  5%  softirqs.CPU12.SCHED
    107598 ±  3%     -56.8%      46446 ±  4%  softirqs.CPU13.RCU
    119881           -53.8%      55354 ±  4%  softirqs.CPU13.SCHED
    104724           -56.1%      45956 ±  4%  softirqs.CPU14.RCU
    119963           -53.8%      55419 ±  4%  softirqs.CPU14.SCHED
     13165 ± 99%     -99.9%      19.33 ±141%  softirqs.CPU15.NET_RX
    110092 ±  2%     -56.5%      47849 ±  3%  softirqs.CPU15.RCU
    121368           -54.4%      55288 ±  4%  softirqs.CPU15.SCHED
    109057           -56.0%      48036 ±  3%  softirqs.CPU16.RCU
    119921           -53.9%      55242 ±  4%  softirqs.CPU16.SCHED
    108655           -56.1%      47694 ±  3%  softirqs.CPU17.RCU
    120088           -54.2%      54944 ±  4%  softirqs.CPU17.SCHED
    108627           -56.2%      47559 ±  3%  softirqs.CPU18.RCU
    120120           -54.1%      55191 ±  4%  softirqs.CPU18.SCHED
    108694           -56.2%      47643 ±  4%  softirqs.CPU19.RCU
    119665           -54.0%      55052 ±  4%  softirqs.CPU19.SCHED
    105228           -56.0%      46263 ±  4%  softirqs.CPU2.RCU
    120219           -54.2%      55106 ±  4%  softirqs.CPU2.SCHED
    109275 ±  2%     -56.2%      47868 ±  4%  softirqs.CPU20.RCU
    119900           -54.0%      55176 ±  4%  softirqs.CPU20.SCHED
    109136 ±  2%     -56.1%      47909 ±  3%  softirqs.CPU21.RCU
    120163           -54.2%      55070 ±  4%  softirqs.CPU21.SCHED
    107108           -56.8%      46311 ±  3%  softirqs.CPU22.RCU
    119637           -53.9%      55119 ±  4%  softirqs.CPU22.SCHED
    106706           -56.4%      46544 ±  4%  softirqs.CPU23.RCU
    119600           -54.3%      54676 ±  4%  softirqs.CPU23.SCHED
    107694           -57.0%      46350 ±  3%  softirqs.CPU24.RCU
    119850           -54.6%      54418 ±  4%  softirqs.CPU24.SCHED
    107315           -55.4%      47908 ±  7%  softirqs.CPU25.RCU
    118923           -53.9%      54841 ±  4%  softirqs.CPU25.SCHED
    108053           -56.9%      46519 ±  3%  softirqs.CPU26.RCU
    119759           -54.2%      54805 ±  4%  softirqs.CPU26.SCHED
    105856 ±  3%     -55.9%      46728 ±  3%  softirqs.CPU27.RCU
    119025           -54.0%      54777 ±  4%  softirqs.CPU27.SCHED
    106841           -55.9%      47100 ±  4%  softirqs.CPU28.RCU
    119686           -54.3%      54753 ±  4%  softirqs.CPU28.SCHED
    107379           -56.7%      46452 ±  3%  softirqs.CPU29.RCU
    119565           -54.3%      54655 ±  4%  softirqs.CPU29.SCHED
    104900           -55.9%      46297 ±  3%  softirqs.CPU3.RCU
    120437           -53.8%      55668 ±  4%  softirqs.CPU3.SCHED
    108473           -56.5%      47207 ±  3%  softirqs.CPU30.RCU
    119461           -54.3%      54577 ±  4%  softirqs.CPU30.SCHED
    108219           -56.3%      47238 ±  2%  softirqs.CPU31.RCU
    119467           -54.5%      54344 ±  4%  softirqs.CPU31.SCHED
    108174           -56.5%      47060 ±  3%  softirqs.CPU32.RCU
    119171           -54.2%      54580 ±  4%  softirqs.CPU32.SCHED
    108989           -56.5%      47414 ±  3%  softirqs.CPU33.RCU
    119492           -54.2%      54684 ±  4%  softirqs.CPU33.SCHED
    109593           -56.6%      47517 ±  3%  softirqs.CPU34.RCU
    119557           -54.3%      54637 ±  4%  softirqs.CPU34.SCHED
    109114           -56.8%      47180 ±  3%  softirqs.CPU35.RCU
    119393           -54.3%      54575 ±  4%  softirqs.CPU35.SCHED
    108622           -56.5%      47220 ±  3%  softirqs.CPU36.RCU
    119178           -54.2%      54591 ±  4%  softirqs.CPU36.SCHED
    108119           -56.1%      47515 ±  2%  softirqs.CPU37.RCU
    119127           -54.4%      54348 ±  5%  softirqs.CPU37.SCHED
    108161           -56.1%      47483 ±  2%  softirqs.CPU38.RCU
    119551           -53.9%      55124 ±  4%  softirqs.CPU38.SCHED
    109273           -56.4%      47687 ±  4%  softirqs.CPU39.RCU
    119821           -54.5%      54555 ±  5%  softirqs.CPU39.SCHED
    105305           -56.1%      46206 ±  4%  softirqs.CPU4.RCU
    121018           -54.1%      55573 ±  4%  softirqs.CPU4.SCHED
    108697           -55.9%      47907 ±  6%  softirqs.CPU40.RCU
    119389           -54.3%      54603 ±  4%  softirqs.CPU40.SCHED
    108910           -56.7%      47119 ±  4%  softirqs.CPU41.RCU
    119659           -54.6%      54306 ±  4%  softirqs.CPU41.SCHED
    108514           -56.3%      47391 ±  4%  softirqs.CPU42.RCU
    119576           -54.4%      54554 ±  4%  softirqs.CPU42.SCHED
    108577           -56.6%      47126 ±  3%  softirqs.CPU43.RCU
    118894           -56.4%      51831 ±  8%  softirqs.CPU43.SCHED
     88868           -56.5%      38691 ±  4%  softirqs.CPU44.RCU
    120752           -54.3%      55160 ±  5%  softirqs.CPU44.SCHED
    106923           -56.0%      47014 ±  4%  softirqs.CPU45.RCU
    120825           -54.0%      55585 ±  6%  softirqs.CPU45.SCHED
    107751           -56.4%      46977 ±  4%  softirqs.CPU46.RCU
    121017           -54.4%      55189 ±  4%  softirqs.CPU46.SCHED
    107963           -56.2%      47340 ±  4%  softirqs.CPU47.RCU
    120833           -54.2%      55299 ±  4%  softirqs.CPU47.SCHED
    108484           -57.6%      46008 ±  7%  softirqs.CPU48.RCU
    120891           -54.5%      55050 ±  4%  softirqs.CPU48.SCHED
    109175           -56.5%      47494 ±  3%  softirqs.CPU49.RCU
    120940           -54.0%      55592 ±  4%  softirqs.CPU49.SCHED
    106299           -56.4%      46372 ±  3%  softirqs.CPU5.RCU
    120011           -53.8%      55469 ±  4%  softirqs.CPU5.SCHED
    107216           -57.9%      45130 ±  2%  softirqs.CPU50.RCU
    121129           -54.2%      55450 ±  4%  softirqs.CPU50.SCHED
    107412           -56.4%      46880 ±  4%  softirqs.CPU51.RCU
    120929           -54.1%      55465 ±  4%  softirqs.CPU51.SCHED
    108272           -56.0%      47594 ±  3%  softirqs.CPU52.RCU
    120446           -53.9%      55567 ±  4%  softirqs.CPU52.SCHED
    108623           -56.5%      47260 ±  4%  softirqs.CPU53.RCU
    120955           -54.1%      55515 ±  4%  softirqs.CPU53.SCHED
    108836           -56.0%      47879 ±  4%  softirqs.CPU54.RCU
    120778           -53.9%      55701 ±  4%  softirqs.CPU54.SCHED
    108007           -56.3%      47238 ±  4%  softirqs.CPU55.RCU
    120627           -53.9%      55623 ±  4%  softirqs.CPU55.SCHED
    107653           -56.2%      47164 ±  4%  softirqs.CPU56.RCU
    120659           -53.9%      55621 ±  4%  softirqs.CPU56.SCHED
    107933           -56.0%      47527 ±  4%  softirqs.CPU57.RCU
    120762           -54.1%      55446 ±  4%  softirqs.CPU57.SCHED
    108125           -56.0%      47568 ±  3%  softirqs.CPU58.RCU
    120535           -54.0%      55498 ±  4%  softirqs.CPU58.SCHED
    108829           -56.3%      47530 ±  3%  softirqs.CPU59.RCU
    121270           -54.2%      55509 ±  4%  softirqs.CPU59.SCHED
    106000           -56.5%      46088 ±  3%  softirqs.CPU6.RCU
    119847           -54.4%      54633 ±  3%  softirqs.CPU6.SCHED
    107363           -56.1%      47104 ±  4%  softirqs.CPU60.RCU
    120843           -54.0%      55566 ±  5%  softirqs.CPU60.SCHED
    108012 ±  2%     -56.3%      47240 ±  3%  softirqs.CPU61.RCU
    120808           -54.2%      55356 ±  4%  softirqs.CPU61.SCHED
    106838           -56.0%      47022 ±  4%  softirqs.CPU62.RCU
    120300           -54.1%      55247 ±  5%  softirqs.CPU62.SCHED
    107342           -56.0%      47190 ±  4%  softirqs.CPU63.RCU
    120788           -53.9%      55644 ±  4%  softirqs.CPU63.SCHED
    107881           -56.1%      47337 ±  3%  softirqs.CPU64.RCU
    121028           -54.0%      55673 ±  4%  softirqs.CPU64.SCHED
    107307           -55.7%      47538 ±  4%  softirqs.CPU65.RCU
    120641           -53.7%      55862 ±  5%  softirqs.CPU65.SCHED
    108427           -56.6%      47067 ±  3%  softirqs.CPU66.RCU
    120737           -54.0%      55558 ±  5%  softirqs.CPU66.SCHED
    108761           -56.7%      47042 ±  3%  softirqs.CPU67.RCU
    120486           -54.4%      54998 ±  4%  softirqs.CPU67.SCHED
    108340           -56.6%      46971 ±  3%  softirqs.CPU68.RCU
    119966           -54.1%      55094 ±  4%  softirqs.CPU68.SCHED
    105786 ±  2%     -55.6%      46941 ±  3%  softirqs.CPU69.RCU
    119274           -53.9%      55013 ±  4%  softirqs.CPU69.SCHED
    105814           -56.2%      46294 ±  4%  softirqs.CPU7.RCU
    119938           -54.0%      55193 ±  4%  softirqs.CPU7.SCHED
    108249           -56.3%      47287 ±  3%  softirqs.CPU70.RCU
    120305           -54.2%      55127 ±  4%  softirqs.CPU70.SCHED
    108283 ±  2%     -56.6%      47012 ±  3%  softirqs.CPU71.RCU
    120102           -54.1%      55115 ±  4%  softirqs.CPU71.SCHED
    108083           -56.6%      46867 ±  2%  softirqs.CPU72.RCU
    120687           -54.4%      55004 ±  4%  softirqs.CPU72.SCHED
    108571           -56.9%      46832 ±  3%  softirqs.CPU73.RCU
    119711           -54.0%      55074 ±  4%  softirqs.CPU73.SCHED
    108342           -56.4%      47186 ±  4%  softirqs.CPU74.RCU
    120266           -54.3%      54912 ±  5%  softirqs.CPU74.SCHED
    101741           -55.9%      44831 ±  5%  softirqs.CPU75.RCU
    120582           -54.5%      54847 ±  4%  softirqs.CPU75.SCHED
    102192           -56.7%      44234 ±  3%  softirqs.CPU76.RCU
    120687           -54.2%      55255 ±  4%  softirqs.CPU76.SCHED
    103098           -56.8%      44552 ±  3%  softirqs.CPU77.RCU
    120282           -54.3%      54930 ±  5%  softirqs.CPU77.SCHED
    103319           -56.6%      44805 ±  3%  softirqs.CPU78.RCU
    120464           -54.3%      55005 ±  4%  softirqs.CPU78.SCHED
    102562           -56.8%      44331 ±  3%  softirqs.CPU79.RCU
    120155           -54.3%      54865 ±  4%  softirqs.CPU79.SCHED
    105994           -56.1%      46557 ±  3%  softirqs.CPU8.RCU
    120135           -53.8%      55524 ±  4%  softirqs.CPU8.SCHED
    102347           -56.7%      44269 ±  3%  softirqs.CPU80.RCU
    120382           -54.3%      55051 ±  4%  softirqs.CPU80.SCHED
    101523           -56.6%      44071 ±  3%  softirqs.CPU81.RCU
    120089           -54.2%      54997 ±  4%  softirqs.CPU81.SCHED
    101555           -56.8%      43890 ±  3%  softirqs.CPU82.RCU
    120524           -54.5%      54834 ±  4%  softirqs.CPU82.SCHED
    103267           -56.5%      44885 ±  4%  softirqs.CPU83.RCU
    120294           -54.4%      54882 ±  5%  softirqs.CPU83.SCHED
    102294           -56.4%      44649 ±  4%  softirqs.CPU84.RCU
    120353           -54.3%      54980 ±  4%  softirqs.CPU84.SCHED
    102272           -56.5%      44449 ±  3%  softirqs.CPU85.RCU
    120315           -54.4%      54839 ±  4%  softirqs.CPU85.SCHED
    101908           -56.5%      44361 ±  3%  softirqs.CPU86.RCU
    120066           -54.1%      55114 ±  4%  softirqs.CPU86.SCHED
    102327           -56.5%      44561 ±  2%  softirqs.CPU87.RCU
    119800           -54.5%      54511 ±  5%  softirqs.CPU87.SCHED
    106050           -56.4%      46240 ±  4%  softirqs.CPU9.RCU
    119947           -53.9%      55245 ±  5%  softirqs.CPU9.SCHED
   9390787           -56.3%    4099662 ±  3%  softirqs.RCU
  10578301           -54.2%    4849540 ±  4%  softirqs.SCHED
     90158           -50.1%      45018 ±  2%  softirqs.TIMER
     35.63            -3.0       32.68        perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
     35.63            -3.0       32.68        perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     35.74            -2.8       32.94        perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     34.60            -2.6       31.97        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     34.66            -2.5       32.15        perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
     92.33            -2.2       90.09        perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
     92.36            -2.2       90.15        perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     92.36            -2.2       90.17        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.41            -2.2       90.25        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.42            -2.2       90.27        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.42            -2.1       90.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.44            -2.1       90.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     92.50            -2.1       90.40        perf-profile.calltrace.cycles-pp.write
     23.87            -0.8       23.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent
     23.91            -0.7       23.20        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit
     23.93            -0.7       23.24        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit
     23.93            -0.7       23.25        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.clear_extent_bit
     30.94            -0.6       30.30        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
     24.07            -0.5       23.54        perf-profile.calltrace.cycles-pp.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages
     24.07            -0.5       23.55        perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write
     31.01            -0.5       30.49        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
     31.03            -0.5       30.55        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     24.10            -0.5       23.62        perf-profile.calltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
     24.10            -0.5       23.62        perf-profile.calltrace.cycles-pp.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     31.04            -0.5       30.57        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.55            +0.5        1.06 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.5        0.53 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.read
      0.00            +0.6        0.59 ±  5%  perf-profile.calltrace.cycles-pp.prepare_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.68            +0.6        1.29 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +0.9        0.86 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages
      0.00            +0.9        0.86 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_set_extent_delalloc.btrfs_dirty_pages.btrfs_buffered_write
      5.83            +1.3        7.14 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.94            +1.4        7.29 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      5.95            +1.4        7.30 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.11            +1.5        7.58 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.11            +1.5        7.58 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.11            +1.5        7.58 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      6.16            +1.5        7.66 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     90.00            -3.9       86.12        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     90.36            -3.3       87.02        perf-profile.children.cycles-pp._raw_spin_lock
     35.77            -3.0       32.81        perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     35.85            -2.9       32.99        perf-profile.children.cycles-pp.__reserve_bytes
     35.74            -2.8       32.94        perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
     92.33            -2.2       90.09        perf-profile.children.cycles-pp.btrfs_buffered_write
     92.36            -2.2       90.15        perf-profile.children.cycles-pp.btrfs_file_write_iter
     92.38            -2.2       90.18        perf-profile.children.cycles-pp.new_sync_write
     92.41            -2.2       90.26        perf-profile.children.cycles-pp.vfs_write
     92.42            -2.1       90.28        perf-profile.children.cycles-pp.ksys_write
     92.50            -2.1       90.42        perf-profile.children.cycles-pp.write
     93.32            -1.7       91.61        perf-profile.children.cycles-pp.do_syscall_64
     93.65            -1.6       92.05        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.21            -1.1       54.06        perf-profile.children.cycles-pp.btrfs_block_rsv_release
     55.00            -1.1       53.86        perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.86            -0.7        0.21 ±  2%  perf-profile.children.cycles-pp.need_preemptive_reclaim
     24.11            -0.5       23.59        perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
     24.15            -0.5       23.68        perf-profile.children.cycles-pp.clear_state_bit
     24.13            -0.5       23.66        perf-profile.children.cycles-pp.clear_extent_bit
     24.21            -0.4       23.82        perf-profile.children.cycles-pp.__clear_extent_bit
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.btrfs_block_rsv_refill
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.btrfs_trans_release_metadata
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.btrfs_unlink_inode
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
      0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.__softirqentry_text_start
      0.09            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_cfs_group
      0.14            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.vfs_unlink
      0.14            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.btrfs_unlink
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__btrfs_commit_inode_delayed_items
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.kthread
      0.14            +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.12            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.btrfs_create
      0.05            +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.menu_select
      0.07 ±  7%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.clockevents_program_event
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.10 ±  5%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.ktime_get
      0.34            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.unlink
      0.34            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.05            +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.03 ±100%      +0.0        0.07        perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_load
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.enqueue_entity
      0.10            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      0.10            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.62            +0.1        0.68 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.06            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.06            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.unlock_up
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.find_extent_buffer_nospinlock
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.generic_bin_search
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.btrfs_calculate_inode_block_rsv_size
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.06            +0.1        0.12        perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.copyin
      0.03 ±100%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.copyout
      0.67            +0.1        0.73 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.06 ±  9%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.lock_extent_bits
      0.06 ±  9%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.find_extent_buffer
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.dequeue_entity
      0.10 ±  5%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.schedule
      0.05            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.btrfs_transaction_in_commit
      0.11            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.dequeue_task_fair
      0.10            +0.1        0.18        perf-profile.children.cycles-pp.btrfs_release_path
      0.30            +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.evict
      0.30            +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.btrfs_evict_inode
      0.06 ±  9%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.read_block_for_search
      0.30            +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.30            +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.__fput
      0.30            +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.dput
      0.30            +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.21 ±  4%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.osq_lock
      0.05            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.btrfs_drop_pages
      0.30            +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__close
      0.32            +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.14 ±  3%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.08 ±  6%      +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.08 ±  5%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.32            +0.1        0.42        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07            +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.alloc_extent_state
      0.07            +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.btrfs_get_alloc_profile
      0.09 ± 11%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.filemap_get_pages
      0.16 ±  6%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.11 ±  4%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.btrfs_do_readpage
      0.09            +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.calc_available_free_space
      0.38 ±  2%      +0.1        0.51 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.08 ±  5%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.12 ±  4%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.btrfs_readpage
      0.13            +0.1        0.27 ±  7%  perf-profile.children.cycles-pp.prepare_uptodate_page
      0.29 ±  5%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      0.29 ±  5%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.path_openat
      0.28 ±  3%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.creat64
      0.29 ±  5%      +0.1        0.43 ±  5%  perf-profile.children.cycles-pp.do_sys_open
      0.29 ±  5%      +0.1        0.43 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
      0.08            +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.btrfs_free_reserved_data_space_noquota
      0.08 ±  5%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.btrfs_can_overcommit
      0.10 ±  5%      +0.1        0.24 ± 13%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.15            +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.pagecache_get_page
      0.18 ±  5%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.filemap_read
      0.28            +0.2        0.47 ±  3%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.20 ±  4%      +0.2        0.40        perf-profile.children.cycles-pp.new_sync_read
      0.21 ±  2%      +0.2        0.42 ±  7%  perf-profile.children.cycles-pp.set_extent_bit
      0.30            +0.2        0.53 ±  3%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.32            +0.2        0.54 ±  4%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.23 ±  4%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.25 ±  4%      +0.2        0.49        perf-profile.children.cycles-pp.ksys_read
      0.30 ±  5%      +0.3        0.59        perf-profile.children.cycles-pp.read
      0.29            +0.3        0.59 ±  5%  perf-profile.children.cycles-pp.prepare_pages
      0.45 ±  3%      +0.4        0.86 ±  5%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.53 ±  2%      +0.5        0.98 ±  5%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.55            +0.5        1.06 ±  5%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.68            +0.6        1.29 ±  5%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      5.89            +1.3        7.22 ±  4%  perf-profile.children.cycles-pp.intel_idle
      6.00            +1.4        7.38 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      6.00            +1.4        7.38 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      6.11            +1.5        7.58 ±  3%  perf-profile.children.cycles-pp.start_secondary
      6.16            +1.5        7.66 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      6.16            +1.5        7.66 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.16            +1.5        7.66 ±  4%  perf-profile.children.cycles-pp.do_idle
     89.45            -3.9       85.55        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.14            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.update_cfs_group
      0.08 ±  5%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.btrfs_file_write_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.filemap_read
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_load_avg
      0.06            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.05            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.btrfs_block_rsv_release
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.btrfs_free_reserved_data_space_noquota
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.btrfs_get_alloc_profile
      0.05            +0.1        0.13        perf-profile.self.cycles-pp.need_preemptive_reclaim
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.set_extent_bit
      0.21 ±  4%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.osq_lock
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.btrfs_can_overcommit
      0.08 ±  6%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.03 ±100%      +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.btrfs_drop_pages
      0.00            +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.__reserve_bytes
      0.51            +0.6        1.14 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      5.89            +1.3        7.22 ±  4%  perf-profile.self.cycles-pp.intel_idle
     80.00 ± 97%     -90.0%       8.00 ±132%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
     24750 ± 99%     -99.9%      34.67 ±141%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
    294.50 ± 99%     -99.7%       1.00 ±141%  interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      1109           -53.0%     521.33 ±  3%  interrupts.9:IO-APIC.9-fasteoi.acpi
   1231165           -42.6%     707118 ±  2%  interrupts.CAL:Function_call_interrupts
     16001           -39.8%       9636 ± 24%  interrupts.CPU0.CAL:Function_call_interrupts
   1108659           -53.0%     521116 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
      4427           -31.8%       3020 ±  2%  interrupts.CPU0.RES:Rescheduling_interrupts
    317.50 ± 24%     -37.4%     198.67 ± 31%  interrupts.CPU0.TLB:TLB_shootdowns
      1109           -53.0%     521.33 ±  3%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
     15699 ±  2%     -43.8%       8818        interrupts.CPU1.CAL:Function_call_interrupts
   1108673           -53.0%     521125 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
      5359 ± 32%     -13.0%       4663 ± 36%  interrupts.CPU1.NMI:Non-maskable_interrupts
      5359 ± 32%     -13.0%       4663 ± 36%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3031 ±  3%     -19.3%       2446 ±  2%  interrupts.CPU1.RES:Rescheduling_interrupts
     13966           -44.4%       7763 ±  3%  interrupts.CPU10.CAL:Function_call_interrupts
   1108679           -53.0%     521093 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
      5363 ± 33%     -13.4%       4647 ± 35%  interrupts.CPU10.NMI:Non-maskable_interrupts
      5363 ± 33%     -13.4%       4647 ± 35%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      2949           -19.3%       2381 ±  4%  interrupts.CPU10.RES:Rescheduling_interrupts
     14078           -42.6%       8085 ±  3%  interrupts.CPU11.CAL:Function_call_interrupts
   1108644           -53.0%     521100 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
      5380 ± 32%     -13.6%       4646 ± 35%  interrupts.CPU11.NMI:Non-maskable_interrupts
      5380 ± 32%     -13.6%       4646 ± 35%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
      2921           -17.5%       2410 ±  3%  interrupts.CPU11.RES:Rescheduling_interrupts
     14041           -42.7%       8050 ±  5%  interrupts.CPU12.CAL:Function_call_interrupts
   1108616           -53.0%     520930 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
      2936 ±  2%     -15.9%       2470        interrupts.CPU12.RES:Rescheduling_interrupts
     13336           -41.3%       7828 ±  3%  interrupts.CPU13.CAL:Function_call_interrupts
   1108646           -53.0%     521115 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
      2905 ±  3%     -15.0%       2470 ±  2%  interrupts.CPU13.RES:Rescheduling_interrupts
     79.50 ± 98%     -90.4%       7.67 ±141%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
     13522           -41.5%       7904        interrupts.CPU14.CAL:Function_call_interrupts
   1108633           -53.0%     521055 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
      2955 ±  4%     -19.3%       2383 ±  2%  interrupts.CPU14.RES:Rescheduling_interrupts
     24750 ± 99%     -99.9%      34.67 ±141%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
     13556           -41.1%       7979 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
   1108698           -53.0%     521051 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
      3040           -20.8%       2409        interrupts.CPU15.RES:Rescheduling_interrupts
     13716           -40.0%       8236 ±  5%  interrupts.CPU16.CAL:Function_call_interrupts
   1108654           -53.0%     521079 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
      2987 ±  3%     -19.2%       2415 ±  3%  interrupts.CPU16.RES:Rescheduling_interrupts
     13859           -42.7%       7946 ±  4%  interrupts.CPU17.CAL:Function_call_interrupts
   1108635           -53.0%     521077 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
      3018           -16.6%       2516        interrupts.CPU17.RES:Rescheduling_interrupts
     13352           -42.2%       7712 ±  3%  interrupts.CPU18.CAL:Function_call_interrupts
   1108638           -53.0%     521187 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
      2977 ±  2%     -20.2%       2377        interrupts.CPU18.RES:Rescheduling_interrupts
     13656           -41.9%       7938 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
   1108639           -53.0%     521293 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
      2938 ±  2%     -18.8%       2385        interrupts.CPU19.RES:Rescheduling_interrupts
     14489           -44.4%       8061 ±  2%  interrupts.CPU2.CAL:Function_call_interrupts
   1108649           -53.0%     521110 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
      2992           -18.8%       2430 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
     13752           -42.5%       7910 ±  3%  interrupts.CPU20.CAL:Function_call_interrupts
   1108632           -53.0%     521077 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
      2911           -18.2%       2382        interrupts.CPU20.RES:Rescheduling_interrupts
     14081           -43.4%       7968 ±  2%  interrupts.CPU21.CAL:Function_call_interrupts
   1108611           -53.0%     521066 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
      3021 ±  2%     -18.1%       2474 ±  5%  interrupts.CPU21.RES:Rescheduling_interrupts
     17183 ±  2%     -45.1%       9431 ±  3%  interrupts.CPU22.CAL:Function_call_interrupts
   1108628           -53.0%     520825 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
      3296           -23.2%       2530 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
    250.50 ± 32%     +53.0%     383.33 ±  6%  interrupts.CPU22.TLB:TLB_shootdowns
     15251           -44.7%       8436        interrupts.CPU23.CAL:Function_call_interrupts
   1108630           -53.0%     521181 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
      2974           -20.2%       2374 ±  2%  interrupts.CPU23.RES:Rescheduling_interrupts
     14674           -44.1%       8208        interrupts.CPU24.CAL:Function_call_interrupts
   1108665           -53.0%     521055 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
      3065           -24.8%       2304        interrupts.CPU24.RES:Rescheduling_interrupts
     14290 ±  2%     -42.4%       8236        interrupts.CPU25.CAL:Function_call_interrupts
   1108413           -53.0%     521264 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
      2916 ±  2%     -20.1%       2330 ±  2%  interrupts.CPU25.RES:Rescheduling_interrupts
     14584           -44.4%       8103 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
   1108667           -53.0%     521033 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
      2973           -20.5%       2363 ±  5%  interrupts.CPU26.RES:Rescheduling_interrupts
     14588           -43.5%       8249 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
   1108639           -53.0%     521085 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
      2941           -19.1%       2379 ±  4%  interrupts.CPU27.RES:Rescheduling_interrupts
     14470           -43.9%       8117 ±  4%  interrupts.CPU28.CAL:Function_call_interrupts
   1108636           -53.0%     521079 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
      2928           -18.8%       2378 ±  5%  interrupts.CPU28.RES:Rescheduling_interrupts
     14546 ±  2%     -44.0%       8139 ±  5%  interrupts.CPU29.CAL:Function_call_interrupts
   1108684           -53.0%     521020 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
      2871           -17.9%       2356 ±  3%  interrupts.CPU29.RES:Rescheduling_interrupts
     14966 ±  7%     -45.2%       8196 ±  2%  interrupts.CPU3.CAL:Function_call_interrupts
   1108614           -53.0%     521089 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
      3007           -18.2%       2460 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
     14311           -43.1%       8138 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
   1108670           -53.0%     520991 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
      2869           -18.7%       2332 ±  3%  interrupts.CPU30.RES:Rescheduling_interrupts
     13828           -41.8%       8047        interrupts.CPU31.CAL:Function_call_interrupts
   1108685           -53.0%     520956 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
      2952 ±  2%     -21.9%       2306        interrupts.CPU31.RES:Rescheduling_interrupts
     14477           -44.5%       8041 ±  3%  interrupts.CPU32.CAL:Function_call_interrupts
   1108742           -53.0%     521067 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
      2982 ±  3%     -23.3%       2286 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
     14218           -43.7%       8003 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
   1108853           -53.0%     521049 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
      2923           -19.5%       2353        interrupts.CPU33.RES:Rescheduling_interrupts
     13863           -42.8%       7924 ±  2%  interrupts.CPU34.CAL:Function_call_interrupts
   1108644           -53.0%     521055 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
      2980           -20.9%       2358 ±  3%  interrupts.CPU34.RES:Rescheduling_interrupts
     13971           -43.5%       7891 ±  5%  interrupts.CPU35.CAL:Function_call_interrupts
   1108616           -53.0%     520998 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
      2871           -19.7%       2304 ±  5%  interrupts.CPU35.RES:Rescheduling_interrupts
     13772           -41.0%       8129 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
   1108638           -53.0%     521055 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
      2925 ±  2%     -19.5%       2355 ±  3%  interrupts.CPU36.RES:Rescheduling_interrupts
     14102 ±  2%     -43.6%       7948 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
   1108629           -53.0%     521051 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
      2927           -20.8%       2319 ±  2%  interrupts.CPU37.RES:Rescheduling_interrupts
     14539           -45.3%       7952 ±  3%  interrupts.CPU38.CAL:Function_call_interrupts
   1108611           -53.0%     521056 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
      3590           +93.2%       6938        interrupts.CPU38.NMI:Non-maskable_interrupts
      3590           +93.2%       6938        interrupts.CPU38.PMI:Performance_monitoring_interrupts
      2892           -19.3%       2334 ±  3%  interrupts.CPU38.RES:Rescheduling_interrupts
     14181 ±  2%     -43.6%       8003 ±  4%  interrupts.CPU39.CAL:Function_call_interrupts
   1108659           -53.0%     521064 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
      2949 ±  3%     -20.2%       2353 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
     16276 ±  2%     -51.3%       7929 ±  4%  interrupts.CPU4.CAL:Function_call_interrupts
   1108671           -53.0%     521099 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
      3034           -17.2%       2512        interrupts.CPU4.RES:Rescheduling_interrupts
     13964           -43.8%       7853 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
   1108668           -53.0%     521064 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
      2863 ±  2%     -20.9%       2265 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
     14061 ±  2%     -43.7%       7914 ±  3%  interrupts.CPU41.CAL:Function_call_interrupts
   1108658           -53.0%     520980 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
      2864 ±  2%     -19.9%       2294 ±  2%  interrupts.CPU41.RES:Rescheduling_interrupts
     13826           -42.2%       7988 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
   1108646           -53.0%     521063 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
      2838           -21.5%       2227 ±  4%  interrupts.CPU42.RES:Rescheduling_interrupts
     14120 ±  2%     -42.6%       8109        interrupts.CPU43.CAL:Function_call_interrupts
   1108631           -53.0%     521029 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
      2923 ±  2%     -19.7%       2347 ±  3%  interrupts.CPU43.RES:Rescheduling_interrupts
     13743           -40.8%       8137 ±  3%  interrupts.CPU44.CAL:Function_call_interrupts
   1108642           -53.0%     521081 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
      2874           -15.0%       2443 ±  2%  interrupts.CPU44.RES:Rescheduling_interrupts
     13657           -41.1%       8049 ±  2%  interrupts.CPU45.CAL:Function_call_interrupts
   1108420           -53.0%     521082 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
      2713 ±  3%      -9.9%       2443 ±  4%  interrupts.CPU45.RES:Rescheduling_interrupts
     13140           -41.2%       7720 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
   1108626           -53.0%     521055 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
      2742           -14.9%       2334        interrupts.CPU46.RES:Rescheduling_interrupts
     13211 ±  3%     -41.3%       7752 ±  3%  interrupts.CPU47.CAL:Function_call_interrupts
   1108314           -53.0%     521103 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
      2883           -15.4%       2438 ±  2%  interrupts.CPU47.RES:Rescheduling_interrupts
     13322           -41.8%       7750 ±  2%  interrupts.CPU48.CAL:Function_call_interrupts
   1108636           -53.0%     520907 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
      2790 ±  2%     -16.4%       2332 ±  5%  interrupts.CPU48.RES:Rescheduling_interrupts
     13610           -42.0%       7894 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
   1108661           -53.0%     521073 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
      2790           -14.6%       2383 ±  4%  interrupts.CPU49.RES:Rescheduling_interrupts
     14282           -44.1%       7989 ±  3%  interrupts.CPU5.CAL:Function_call_interrupts
   1108651           -53.0%     520967 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
      2909 ±  5%     -16.4%       2432        interrupts.CPU5.RES:Rescheduling_interrupts
     13845           -42.8%       7919 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
   1108650           -53.0%     521035 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
      2906           -16.9%       2416 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
     13355           -41.9%       7764 ±  5%  interrupts.CPU51.CAL:Function_call_interrupts
   1108668           -53.0%     521065 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
      2827 ±  3%     -17.0%       2345 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
     13345           -40.8%       7906 ±  3%  interrupts.CPU52.CAL:Function_call_interrupts
   1108605           -53.0%     521099 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
      3586           +94.6%       6978        interrupts.CPU52.NMI:Non-maskable_interrupts
      3586           +94.6%       6978        interrupts.CPU52.PMI:Performance_monitoring_interrupts
      2850 ±  3%     -14.5%       2437 ±  3%  interrupts.CPU52.RES:Rescheduling_interrupts
     13467           -40.0%       8082 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
   1108630           -53.0%     521063 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
      2777           -13.3%       2409        interrupts.CPU53.RES:Rescheduling_interrupts
     13781           -42.8%       7886 ±  2%  interrupts.CPU54.CAL:Function_call_interrupts
   1108673           -53.0%     521117 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
      2977           -20.0%       2382 ±  2%  interrupts.CPU54.RES:Rescheduling_interrupts
     13661           -42.4%       7869 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
   1108666           -53.0%     521088 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
      2835           -16.4%       2370 ±  3%  interrupts.CPU55.RES:Rescheduling_interrupts
     13800           -41.8%       8031 ±  4%  interrupts.CPU56.CAL:Function_call_interrupts
   1108623           -53.0%     521103 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
      2833 ±  2%     -18.5%       2308        interrupts.CPU56.RES:Rescheduling_interrupts
     13203           -41.6%       7714 ±  3%  interrupts.CPU57.CAL:Function_call_interrupts
   1108656           -53.0%     521085 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
      2802           -15.6%       2365 ±  4%  interrupts.CPU57.RES:Rescheduling_interrupts
     13311           -41.8%       7742 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
   1108660           -53.0%     521028 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
      2804           -15.4%       2372 ±  2%  interrupts.CPU58.RES:Rescheduling_interrupts
     13515           -41.9%       7857 ±  2%  interrupts.CPU59.CAL:Function_call_interrupts
   1108662           -53.0%     521065 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
      2770 ±  3%     -13.4%       2399        interrupts.CPU59.RES:Rescheduling_interrupts
     14281           -43.8%       8029 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
   1108554           -53.0%     521076 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
      7172           -35.1%       4658 ± 35%  interrupts.CPU6.NMI:Non-maskable_interrupts
      7172           -35.1%       4658 ± 35%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      3005 ±  3%     -20.4%       2391 ±  5%  interrupts.CPU6.RES:Rescheduling_interrupts
     13525           -40.7%       8020 ±  4%  interrupts.CPU60.CAL:Function_call_interrupts
   1108647           -53.0%     521098 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
      2767           -14.2%       2373 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
     13617           -40.7%       8075 ±  5%  interrupts.CPU61.CAL:Function_call_interrupts
   1108657           -53.0%     521096 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
      2798 ±  2%     -17.0%       2321 ±  2%  interrupts.CPU61.RES:Rescheduling_interrupts
     13453           -41.5%       7864 ±  5%  interrupts.CPU62.CAL:Function_call_interrupts
   1108647           -53.0%     521030 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
      2980 ±  2%     -19.9%       2385        interrupts.CPU62.RES:Rescheduling_interrupts
     13235           -40.6%       7867 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
   1108636           -53.0%     521121 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
      2973 ±  5%     -18.4%       2424 ±  4%  interrupts.CPU63.RES:Rescheduling_interrupts
     13254           -38.9%       8093 ±  4%  interrupts.CPU64.CAL:Function_call_interrupts
   1108672           -53.0%     521083 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
      2939 ±  5%     -17.9%       2412        interrupts.CPU64.RES:Rescheduling_interrupts
     13534           -41.1%       7974 ±  6%  interrupts.CPU65.CAL:Function_call_interrupts
   1108632           -53.0%     521101 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
      2924 ±  2%     -18.3%       2388 ±  2%  interrupts.CPU65.RES:Rescheduling_interrupts
     15806 ±  3%     -44.7%       8734 ±  4%  interrupts.CPU66.CAL:Function_call_interrupts
   1108632           -53.0%     520997 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
      2860           -19.1%       2314 ±  5%  interrupts.CPU66.RES:Rescheduling_interrupts
     13911           -43.0%       7924 ±  4%  interrupts.CPU67.CAL:Function_call_interrupts
   1108646           -53.0%     521053 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
      2859 ±  2%     -17.4%       2362 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
     13367           -41.1%       7872 ±  3%  interrupts.CPU68.CAL:Function_call_interrupts
   1108668           -53.0%     521070 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
      2828           -22.9%       2181 ±  2%  interrupts.CPU68.RES:Rescheduling_interrupts
     13467 ±  2%     -41.8%       7836 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
   1108501           -53.0%     521075 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
      2831 ±  2%     -20.2%       2258 ±  5%  interrupts.CPU69.RES:Rescheduling_interrupts
     13744           -41.8%       8001 ±  4%  interrupts.CPU7.CAL:Function_call_interrupts
   1108572           -53.0%     521089 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
      7166           -34.9%       4663 ± 35%  interrupts.CPU7.NMI:Non-maskable_interrupts
      7166           -34.9%       4663 ± 35%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      2968 ±  3%     -18.4%       2423 ±  2%  interrupts.CPU7.RES:Rescheduling_interrupts
     13763 ±  2%     -42.4%       7926        interrupts.CPU70.CAL:Function_call_interrupts
   1108649           -53.0%     521089 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
      2711           -16.4%       2266 ±  4%  interrupts.CPU70.RES:Rescheduling_interrupts
     14086           -44.5%       7816 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
   1108680           -53.0%     521069 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
      2863 ±  2%     -20.5%       2277 ±  4%  interrupts.CPU71.RES:Rescheduling_interrupts
     14075 ±  2%     -43.3%       7986        interrupts.CPU72.CAL:Function_call_interrupts
   1108679           -53.0%     521059 ±  3%  interrupts.CPU72.LOC:Local_timer_interrupts
      2674           -15.1%       2271 ±  2%  interrupts.CPU72.RES:Rescheduling_interrupts
     14242           -42.2%       8237        interrupts.CPU73.CAL:Function_call_interrupts
   1108674           -53.0%     520900 ±  3%  interrupts.CPU73.LOC:Local_timer_interrupts
      2840           -20.0%       2272 ±  5%  interrupts.CPU73.RES:Rescheduling_interrupts
     14027 ±  2%     -43.3%       7958 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
   1108649           -53.0%     521075 ±  3%  interrupts.CPU74.LOC:Local_timer_interrupts
      2805 ±  2%     -19.3%       2264 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
     13440 ±  3%     -41.6%       7848 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
   1108650           -53.0%     521044 ±  3%  interrupts.CPU75.LOC:Local_timer_interrupts
      5379 ± 32%     -13.9%       4631 ± 35%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5379 ± 32%     -13.9%       4631 ± 35%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      2744 ±  3%     -18.2%       2245 ±  4%  interrupts.CPU75.RES:Rescheduling_interrupts
     14170           -44.3%       7895 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
   1108320           -53.0%     521083 ±  3%  interrupts.CPU76.LOC:Local_timer_interrupts
      2727 ±  2%     -17.9%       2238 ±  3%  interrupts.CPU76.RES:Rescheduling_interrupts
     14023           -42.2%       8105        interrupts.CPU77.CAL:Function_call_interrupts
   1108643           -53.0%     521108 ±  3%  interrupts.CPU77.LOC:Local_timer_interrupts
      2746 ±  3%     -19.7%       2205 ±  4%  interrupts.CPU77.RES:Rescheduling_interrupts
     13939 ±  2%     -42.5%       8012 ±  2%  interrupts.CPU78.CAL:Function_call_interrupts
   1109176           -53.0%     521093 ±  3%  interrupts.CPU78.LOC:Local_timer_interrupts
      2712 ±  2%     -17.0%       2250 ±  2%  interrupts.CPU78.RES:Rescheduling_interrupts
     13414           -41.6%       7829 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
   1108704           -53.0%     521054 ±  3%  interrupts.CPU79.LOC:Local_timer_interrupts
      2704           -17.6%       2227 ±  5%  interrupts.CPU79.RES:Rescheduling_interrupts
     13708           -36.3%       8733 ± 13%  interrupts.CPU8.CAL:Function_call_interrupts
   1108596           -53.0%     521105 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
      7155           -35.1%       4642 ± 35%  interrupts.CPU8.NMI:Non-maskable_interrupts
      7155           -35.1%       4642 ± 35%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      3055 ±  5%     -20.0%       2444 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
     13838 ±  2%     -43.8%       7771 ±  2%  interrupts.CPU80.CAL:Function_call_interrupts
   1108672           -53.0%     521056 ±  3%  interrupts.CPU80.LOC:Local_timer_interrupts
      2738 ±  2%     -19.8%       2196 ±  4%  interrupts.CPU80.RES:Rescheduling_interrupts
     13759           -43.7%       7746 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
   1108649           -53.0%     521072 ±  3%  interrupts.CPU81.LOC:Local_timer_interrupts
      2700           -21.0%       2134 ±  2%  interrupts.CPU81.RES:Rescheduling_interrupts
     13991           -41.6%       8165 ±  3%  interrupts.CPU82.CAL:Function_call_interrupts
   1108591           -53.0%     521065 ±  3%  interrupts.CPU82.LOC:Local_timer_interrupts
      2659           -16.5%       2220 ±  3%  interrupts.CPU82.RES:Rescheduling_interrupts
     13889           -43.5%       7854        interrupts.CPU83.CAL:Function_call_interrupts
   1108657           -53.0%     521060 ±  3%  interrupts.CPU83.LOC:Local_timer_interrupts
      2702 ±  2%     -17.1%       2241 ±  4%  interrupts.CPU83.RES:Rescheduling_interrupts
     13540           -42.0%       7849 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
   1108690           -53.0%     521090 ±  3%  interrupts.CPU84.LOC:Local_timer_interrupts
      2901           -16.6%       2419 ±  3%  interrupts.CPU84.RES:Rescheduling_interrupts
     13632 ±  2%     -42.4%       7856        interrupts.CPU85.CAL:Function_call_interrupts
   1108611           -53.0%     521005 ±  3%  interrupts.CPU85.LOC:Local_timer_interrupts
      2970 ±  2%     -19.7%       2384        interrupts.CPU85.RES:Rescheduling_interrupts
     13613           -41.9%       7913 ±  2%  interrupts.CPU86.CAL:Function_call_interrupts
   1108642           -53.0%     521071 ±  3%  interrupts.CPU86.LOC:Local_timer_interrupts
      2902 ±  2%     -20.1%       2319 ±  5%  interrupts.CPU86.RES:Rescheduling_interrupts
     13768           -39.4%       8338 ±  8%  interrupts.CPU87.CAL:Function_call_interrupts
   1108666           -53.0%     521177 ±  3%  interrupts.CPU87.LOC:Local_timer_interrupts
      3227 ±  2%     -22.0%       2516 ±  5%  interrupts.CPU87.RES:Rescheduling_interrupts
     13620 ±  2%     -40.6%       8084 ±  3%  interrupts.CPU9.CAL:Function_call_interrupts
   1108680           -53.0%     521088 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
      5365 ± 33%     -13.3%       4651 ± 35%  interrupts.CPU9.NMI:Non-maskable_interrupts
      5365 ± 33%     -13.3%       4651 ± 35%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      2933 ±  2%     -16.7%       2444 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
    524.00 ±  3%     +38.2%     724.00        interrupts.IWI:IRQ_work_interrupts
  97560509           -53.0%   45853982 ±  3%  interrupts.LOC:Local_timer_interrupts
    255919           -18.7%     208088        interrupts.RES:Rescheduling_interrupts
      3600           -18.7%       2928 ±  6%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc4-00119-gb05645404a7d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
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
CONFIG_KCMP=y
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
# CONFIG_ACPI_FPDT is not set
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
CONFIG_ACPI_PLATFORM_PROFILE=m
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
# CONFIG_KVM_XEN is not set
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
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
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
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
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
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

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
# CONFIG_IP_VS_TWOS is not set

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
CONFIG_SOCK_RX_QUEUE_MAPPING=y
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

# CONFIG_CXL_BUS is not set
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
# CONFIG_BCM_VK is not set
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
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
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
# CONFIG_XILINX_EMACLITE is not set
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
# CONFIG_MT7921E is not set
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
# CONFIG_NULL_TTY is not set
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
# CONFIG_TCG_TIS_I2C_CR50 is not set
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
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
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
# CONFIG_SENSORS_AHT10 is not set
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
# CONFIG_SENSORS_TPS23861 is not set
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
CONFIG_X86_THERMAL_VECTOR=y
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
# CONFIG_VIDEO_OV5648 is not set
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
# CONFIG_VIDEO_OV8865 is not set
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
# CONFIG_VIDEO_RDACM21 is not set
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
CONFIG_DVB_MXL692=m

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
# CONFIG_HID_PLAYSTATION is not set
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
# CONFIG_I2C_HID_ACPI is not set
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
# CONFIG_USB_CDNS_SUPPORT is not set
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
# CONFIG_USB_SERIAL_XR is not set
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
# Flash and Torch LED drivers
#

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
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
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
# CONFIG_INTEL_LDMA is not set

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
# CONFIG_DMABUF_DEBUG is not set
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
CONFIG_VIRTIO_PCI_LIB=y
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
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
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
# CONFIG_SURFACE_HOTPLUG is not set
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
# CONFIG_XILINX_VCU is not set
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
CONFIG_IOMMU_IO_PGTABLE=y
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
# CONFIG_NTB_EPF is not set
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
# CONFIG_DTPM is not set
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
# CONFIG_NVMEM_RMEM is not set

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
CONFIG_NFS_V4_2_SSC_HELPER=y
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
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_GDB_SCRIPTS is not set
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
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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

# CONFIG_DEBUG_IRQFLAGS is not set
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
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
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
CONFIG_FTRACE_MCOUNT_USE_CC=y
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

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fsmark'
	export testcase='fsmark'
	export category='benchmark'
	export iterations=1
	export nr_threads=64
	export need_memory='50G'
	export job_origin='fsmark-generic-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap2'
	export tbox_group='lkp-csl-2ap2'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='605bb22f2e15ea113851403d'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-b0564540-20210325-4408-1ybrqjx-5.yaml'
	export id='3b53a354b9689003613b8b21be40cdb1683764a0'
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
	export commit='b05645404a7d4f798a5101542726d41cef4f08a0'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-03-25 05:42:07 +0800'
	export _id='605bb2352e15ea113851403f'
	export _rt='/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='4411088cc2e471d64b27cfbd6f06afc7f3ffd9e9'
	export base_commit='0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b'
	export branch='linux-review/Josef-Bacik/btrfs-use-percpu_read_positive-instead-of-sum_positive-for-need_preempt/20210324-214635'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/3'
	export scheduler_version='/lkp/lkp/.src-20210324-190616'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-b0564540-20210325-4408-1ybrqjx-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Josef-Bacik/btrfs-use-percpu_read_positive-instead-of-sum_positive-for-need_preempt/20210324-214635
commit=b05645404a7d4f798a5101542726d41cef4f08a0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/vmlinuz-5.12.0-rc4-00119-gb05645404a7d
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-3.3-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc4'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/vmlinuz-5.12.0-rc4-00119-gb05645404a7d'
	export dequeue_time='2021-03-25 05:49:06 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-b0564540-20210325-4408-1ybrqjx-5.cgz'

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
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
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

	run_test filesize='4M' test_size='24G' sync_method='NoSync' $LKP_SRC/tests/wrapper fsmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=1 $LKP_SRC/stats/wrapper perf-profile
	env filesize='4M' test_size='24G' sync_method='NoSync' $LKP_SRC/stats/wrapper fsmark
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
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
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

--WIyZ46R2i8wDzkSu
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
nr_threads: 64t
disk: 1BRD_48G
need_memory: 50G
fs: btrfs
fs2: 
fsmark:
  filesize: 4M
  test_size: 24G
  sync_method: NoSync
job_origin: fsmark-generic-1brd.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap2
tbox_group: lkp-csl-2ap2
kconfig: x86_64-rhel-8.3
submit_id: 605ba1d32e15ea07cc3cbfe4
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-b0564540-20210325-1996-mt578h-1.yaml"
id: 6bf550efbb90417f5862b6e6e971b0a0e5398c4b
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
  lite_mode: 1
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
commit: b05645404a7d4f798a5101542726d41cef4f08a0

#! include/testbox/lkp-csl-2ap2
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003006'

#! include/fs/OTHERS
enqueue_time: 2021-03-25 04:32:20.148081708 +08:00
_id: 605ba1d92e15ea07cc3cbfe5
_rt: "/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 4411088cc2e471d64b27cfbd6f06afc7f3ffd9e9
base_commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
branch: linux-devel/devel-hourly-20210324-213913
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/1"
scheduler_version: "/lkp/lkp/.src-20210324-190616"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-b0564540-20210325-1996-mt578h-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210324-213913
- commit=b05645404a7d4f798a5101542726d41cef4f08a0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/vmlinuz-5.12.0-rc4-00119-gb05645404a7d
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-btrfs-1x-64t-NoSync-24G-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/1
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-3.3-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210324-190616/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc4-00119-gb05645404a7d
repeat_to: 3

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/b05645404a7d4f798a5101542726d41cef4f08a0/vmlinuz-5.12.0-rc4-00119-gb05645404a7d"
dequeue_time: 2021-03-25 04:38:44.296718719 +08:00
job_state: finished
loadavg: 6.81 1.83 0.62 2/1606 4378
start_time: '1616618378'
end_time: '1616618395'
version: "/lkp/lkp/.src-20210324-190650:68136ae1:ff8840914"

--WIyZ46R2i8wDzkSu
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

fs_mark -d /fs/ram0/1 -d /fs/ram0/2 -d /fs/ram0/3 -d /fs/ram0/4 -d /fs/ram0/5 -d /fs/ram0/6 -d /fs/ram0/7 -d /fs/ram0/8 -d /fs/ram0/9 -d /fs/ram0/10 -d /fs/ram0/11 -d /fs/ram0/12 -d /fs/ram0/13 -d /fs/ram0/14 -d /fs/ram0/15 -d /fs/ram0/16 -d /fs/ram0/17 -d /fs/ram0/18 -d /fs/ram0/19 -d /fs/ram0/20 -d /fs/ram0/21 -d /fs/ram0/22 -d /fs/ram0/23 -d /fs/ram0/24 -d /fs/ram0/25 -d /fs/ram0/26 -d /fs/ram0/27 -d /fs/ram0/28 -d /fs/ram0/29 -d /fs/ram0/30 -d /fs/ram0/31 -d /fs/ram0/32 -d /fs/ram0/33 -d /fs/ram0/34 -d /fs/ram0/35 -d /fs/ram0/36 -d /fs/ram0/37 -d /fs/ram0/38 -d /fs/ram0/39 -d /fs/ram0/40 -d /fs/ram0/41 -d /fs/ram0/42 -d /fs/ram0/43 -d /fs/ram0/44 -d /fs/ram0/45 -d /fs/ram0/46 -d /fs/ram0/47 -d /fs/ram0/48 -d /fs/ram0/49 -d /fs/ram0/50 -d /fs/ram0/51 -d /fs/ram0/52 -d /fs/ram0/53 -d /fs/ram0/54 -d /fs/ram0/55 -d /fs/ram0/56 -d /fs/ram0/57 -d /fs/ram0/58 -d /fs/ram0/59 -d /fs/ram0/60 -d /fs/ram0/61 -d /fs/ram0/62 -d /fs/ram0/63 -d /fs/ram0/64 -n 96 -L 1 -S 0 -s 4194304

--WIyZ46R2i8wDzkSu--
