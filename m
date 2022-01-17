Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4249084D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiAQMId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 07:08:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiAQMIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 07:08:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 262C0B80EFF;
        Mon, 17 Jan 2022 12:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E4C36AE7;
        Mon, 17 Jan 2022 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642421308;
        bh=m/thzz7dffDRRxvxA7QJJU8XAV8sK/Se8JzF9VLlqRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2qdIb4fx6kivNrJt2xTrQIGkPLeYsuoa/8WRCeHbiKGn6kJxsoOCHV8jdlEBWLUm
         7NO5GWRhhd3LULQKeTEwQFAJlU/mHnfJ6XDk3iMuGN1miJnljXzI4euyv4Fhc5LVV8
         dbzYp1P974aJHPConPOwYDdXQg30aUCvnieUs0WBX0QM/+wmd0ZFQSWgrs7AhN5W3O
         0h+c9ViMOmbXy9i4srwMQqakHp57nuDjdnrJr2+qgQhUdpPOm9Ts1Iarqh7bbSUkkt
         OPzm53i3ch6/pFaiSuU96/xxUiHLpVz6OIdVT8UD713hpB/4pFFLkkSqq8MaobUcLd
         uz6p+uAx7CHaQ==
Date:   Mon, 17 Jan 2022 12:08:25 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs]  1a61b300c0:  fsmark.files_per_sec -69.3% regression
Message-ID: <YeVcOXAsCcA7ijoX@debian9.Home>
References: <20220117082426.GE32491@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117082426.GE32491@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 04:24:26PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -69.3% regression of fsmark.files_per_sec due to commit:
> 
> 
> commit: 1a61b300c09b1d034534372349e8f9d3aba6c392 ("btrfs: fix log tree cleanup after a transaction abort")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

A bit surprising but it does make sense.

The problem is that after this change we have to keep track of log tree extent buffers in memory, in an
io tree, not just until their writeback finishes, but until the transaction is committed. So there's an
extra memory usage because of that.

As that patch is not yet on Linus' tree, I'll send an alternative approach to address the issue it
fixes.

Thanks.

> 
> in testcase: fsmark
> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	iterations: 8
> 	disk: 1SSD
> 	nr_threads: 4
> 	fs: btrfs
> 	filesize: 8K
> 	test_size: 24G
> 	sync_method: fsyncBeforeClose
> 	nr_directories: 16d
> 	nr_files_per_directory: 256fpd
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
> test-url: https://sourceforge.net/projects/fsmark/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | fsmark: fsmark.files_per_sec -79.6% regression                                      |
> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | disk=1SSD                                                                           |
> |                  | filesize=9B                                                                         |
> |                  | fs=btrfs                                                                            |
> |                  | iterations=8                                                                        |
> |                  | nr_directories=16d                                                                  |
> |                  | nr_files_per_directory=256fpd                                                       |
> |                  | nr_threads=4                                                                        |
> |                  | sync_method=fsyncBeforeClose                                                        |
> |                  | test_size=16G                                                                       |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
>   gcc-9/performance/1SSD/8K/btrfs/8/x86_64-rhel-8.3/16d/256fpd/4/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap4/24G/fsmark/0x5003006
> 
> commit: 
>   dd503c2d5d ("btrfs: remove write and wait of struct walk_control")
>   1a61b300c0 ("btrfs: fix log tree cleanup after a transaction abort")
> 
> dd503c2d5db4f864 1a61b300c09b1d034534372349e 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    1693267           +27.7%    2162171        fsmark.app_overhead
>      10798           -69.3%       3316        fsmark.files_per_sec
>     309.11          +214.5%     972.20        fsmark.time.elapsed_time
>     309.11          +214.5%     972.20        fsmark.time.elapsed_time.max
>  3.284e+08            -5.2%  3.112e+08        fsmark.time.file_system_outputs
>       1441 �  4%    +149.9%       3601 �  5%  fsmark.time.involuntary_context_switches
>     186.17           +35.1%     251.50        fsmark.time.percent_of_cpu_this_job_got
>     565.65          +330.6%       2435        fsmark.time.system_time
>   16705992           +10.4%   18445401        fsmark.time.voluntary_context_switches
>       2.68 � 10%     +21.2%       3.25 � 12%  iostat.cpu.system
>   59912963          +189.9%  1.737e+08 � 18%  turbostat.IRQ
>  5.763e+10          +211.5%  1.795e+11        cpuidle..time
>  1.422e+08          +161.1%  3.715e+08 � 13%  cpuidle..usage
>     360.08          +183.3%       1020        uptime.boot
>      66292          +184.3%     188463        uptime.idle
>       0.15 �  2%      -0.1        0.03 �  4%  mpstat.cpu.all.iowait%
>       1.01 �  2%      +0.3        1.34        mpstat.cpu.all.sys%
>       0.04 �  6%      -0.0        0.02 �  2%  mpstat.cpu.all.usr%
>       7453 �  8%     -17.1%       6179 �  4%  numa-vmstat.node1.nr_kernel_stack
>       1708 � 31%     -62.7%     636.83 �109%  numa-vmstat.node3.nr_mapped
>       7873 � 16%     -47.9%       4100 � 27%  numa-vmstat.node3.nr_shmem
>     550115           -69.6%     167016        vmstat.io.bo
>     132793           -64.2%      47581        vmstat.system.cs
>     415010           -10.3%     372330 � 13%  vmstat.system.in
>       7453 �  8%     -17.1%       6178 �  4%  numa-meminfo.node1.KernelStack
>       2842 � 97%     -77.4%     642.00 �202%  numa-meminfo.node2.Mapped
>       6989 � 40%     -64.6%       2475 �113%  numa-meminfo.node3.Mapped
>      30481 � 17%     -46.7%      16242 � 28%  numa-meminfo.node3.Shmem
>      35959 �110%   +1474.0%     565979 � 31%  numa-numastat.node1.local_node
>     111652 � 27%    +484.9%     653045 � 27%  numa-numastat.node1.numa_hit
>     223279 � 20%     +82.7%     407926 � 20%  numa-numastat.node3.local_node
>     310312 � 15%     +59.5%     494965 � 16%  numa-numastat.node3.numa_hit
>    6974599 �  2%     -27.2%    5074968 �  4%  meminfo.Active
>      12971 �  2%     +64.3%      21312 �  5%  meminfo.Active(anon)
>    6961627 �  2%     -27.4%    5053654 �  4%  meminfo.Active(file)
>      31060           -10.4%      27841        meminfo.KernelStack
>      41619           -11.3%      36929        meminfo.Mapped
>       3246 �  2%     +63.7%       5315 �  5%  proc-vmstat.nr_active_anon
>    1740701 �  2%     -27.4%    1263351 �  4%  proc-vmstat.nr_active_file
>      76345            -3.1%      73949        proc-vmstat.nr_anon_pages
>   41235116            -5.2%   39106395        proc-vmstat.nr_dirtied
>      43614            +3.7%      45222        proc-vmstat.nr_dirty
>    5617766            -7.5%    5199209        proc-vmstat.nr_file_pages
>   42179045            +1.1%   42663739        proc-vmstat.nr_free_pages
>      84985            -6.7%      79262        proc-vmstat.nr_inactive_anon
>    3223721            +1.9%    3283642        proc-vmstat.nr_inactive_file
>      31071           -10.4%      27834        proc-vmstat.nr_kernel_stack
>      10853           -12.6%       9483        proc-vmstat.nr_mapped
>       1067            -6.2%       1001        proc-vmstat.nr_page_table_pages
>      11852            -9.3%      10748 �  3%  proc-vmstat.nr_shmem
>     841480            +2.3%     860894        proc-vmstat.nr_slab_reclaimable
>     356995            -1.5%     351806        proc-vmstat.nr_slab_unreclaimable
>   41233733            -5.2%   39103309        proc-vmstat.nr_written
>       3246 �  2%     +63.7%       5315 �  5%  proc-vmstat.nr_zone_active_anon
>    1740701 �  2%     -27.4%    1263351 �  4%  proc-vmstat.nr_zone_active_file
>      84985            -6.7%      79262        proc-vmstat.nr_zone_inactive_anon
>    3223721            +1.9%    3283642        proc-vmstat.nr_zone_inactive_file
>      43649            +3.6%      45237        proc-vmstat.nr_zone_write_pending
>   10743944           +11.0%   11920715        proc-vmstat.numa_hit
>   10486008           +11.2%   11660052        proc-vmstat.numa_local
>     256213 �  4%     +30.9%     335278 �  4%  proc-vmstat.numa_pte_updates
>    1427645 �  3%     -23.9%    1085954 �  9%  proc-vmstat.pgactivate
>   10759480           +11.1%   11959093        proc-vmstat.pgalloc_normal
>    1493167          +163.2%    3930462        proc-vmstat.pgfault
>   10721038 �  2%     +11.8%   11989241        proc-vmstat.pgfree
>  1.717e+08            -5.2%  1.628e+08        proc-vmstat.pgpgout
>      80248          +176.9%     222186 �  2%  proc-vmstat.pgreuse
>      10.92 � 41%    +251.5%      38.40 � 28%  perf-stat.i.MPKI
>  1.686e+09           -25.0%  1.264e+09 �  2%  perf-stat.i.branch-instructions
>       1.02 � 51%      +1.1        2.15 � 44%  perf-stat.i.branch-miss-rate%
>      11.78 � 18%      -8.4        3.34 � 10%  perf-stat.i.cache-miss-rate%
>    8696874 � 16%     -40.1%    5206070 � 34%  perf-stat.i.cache-misses
>   93006209 � 40%    +113.7%  1.988e+08 � 27%  perf-stat.i.cache-references
>     133991           -64.4%      47669        perf-stat.i.context-switches
>       1.61 � 10%     +77.9%       2.86 � 12%  perf-stat.i.cpi
>     207.27            -4.3%     198.27        perf-stat.i.cpu-migrations
>       1734 �  6%    +116.5%       3755 � 31%  perf-stat.i.cycles-between-cache-misses
>   2.27e+09           -36.4%  1.444e+09 �  2%  perf-stat.i.dTLB-loads
>  1.079e+09           -51.3%   5.25e+08 �  3%  perf-stat.i.dTLB-stores
>    2773451 �  3%     -36.8%    1752389 �  7%  perf-stat.i.iTLB-load-misses
>    6627866 �  6%     -45.5%    3612274 � 21%  perf-stat.i.iTLB-loads
>  8.541e+09           -36.0%  5.466e+09 �  2%  perf-stat.i.instructions
>       0.63 �  8%     -41.7%       0.37 � 12%  perf-stat.i.ipc
>       1.25           -67.0%       0.41 �  7%  perf-stat.i.major-faults
>      26.22           -33.4%      17.47 �  3%  perf-stat.i.metric.M/sec
>       4353           -11.6%       3849        perf-stat.i.minor-faults
>      28.34 � 13%     +20.4       48.76 �  3%  perf-stat.i.node-load-miss-rate%
>    1784907           -68.1%     569781        perf-stat.i.node-loads
>      17.67 � 27%     +14.5       32.19 � 10%  perf-stat.i.node-store-miss-rate%
>    1006231 �  3%     -64.7%     355642 �  6%  perf-stat.i.node-stores
>       4355           -11.6%       3849        perf-stat.i.page-faults
>      10.89 � 40%    +235.4%      36.51 � 28%  perf-stat.overall.MPKI
>       1.03 � 49%      +1.1        2.12 � 44%  perf-stat.overall.branch-miss-rate%
>       9.93 � 14%      -7.4        2.56 �  8%  perf-stat.overall.cache-miss-rate%
>       1.59 �  9%     +73.4%       2.76 � 12%  perf-stat.overall.cpi
>       1579 �  5%    +100.2%       3162 � 24%  perf-stat.overall.cycles-between-cache-misses
>       0.63 �  8%     -41.9%       0.37 � 12%  perf-stat.overall.ipc
>      24.89 � 13%     +21.3       46.16 �  8%  perf-stat.overall.node-load-miss-rate%
>      17.64 � 25%     +13.7       31.38 � 15%  perf-stat.overall.node-store-miss-rate%
>  1.681e+09           -24.9%  1.263e+09 �  2%  perf-stat.ps.branch-instructions
>    8670511 � 16%     -40.0%    5200670 � 34%  perf-stat.ps.cache-misses
>   92696590 � 40%    +114.2%  1.986e+08 � 27%  perf-stat.ps.cache-references
>     133536           -64.3%      47605        perf-stat.ps.context-switches
>     206.59            -4.1%     198.06        perf-stat.ps.cpu-migrations
>  2.262e+09           -36.2%  1.443e+09 �  2%  perf-stat.ps.dTLB-loads
>  1.075e+09           -51.2%  5.244e+08 �  3%  perf-stat.ps.dTLB-stores
>    2764305 �  3%     -36.7%    1750404 �  7%  perf-stat.ps.iTLB-load-misses
>    6605641 �  6%     -45.4%    3608091 � 21%  perf-stat.ps.iTLB-loads
>  8.513e+09           -35.9%   5.46e+09 �  2%  perf-stat.ps.instructions
>       1.25           -67.0%       0.41 �  7%  perf-stat.ps.major-faults
>       4337           -11.4%       3844        perf-stat.ps.minor-faults
>    1779749           -68.0%     569282        perf-stat.ps.node-loads
>    1003217 �  3%     -64.6%     355265 �  6%  perf-stat.ps.node-stores
>       4338           -11.4%       3844        perf-stat.ps.page-faults
>   2.64e+12          +101.3%  5.315e+12 �  2%  perf-stat.total.instructions
>      47976 � 15%    +257.9%     171687 � 19%  softirqs.CPU0.RCU
>      47168          +180.0%     132067 �  4%  softirqs.CPU0.SCHED
>      51434 � 22%    +275.5%     193128 � 21%  softirqs.CPU1.RCU
>      43547 � 15%    +239.0%     147607 � 22%  softirqs.CPU1.SCHED
>      53628 � 22%    +260.3%     193225 � 12%  softirqs.CPU10.RCU
>      46209 �  7%    +240.8%     157488 � 16%  softirqs.CPU10.SCHED
>      41543 � 19%    +270.4%     153875 � 18%  softirqs.CPU100.RCU
>      41317          +198.7%     123436 �  2%  softirqs.CPU100.SCHED
>      42175 � 18%    +264.2%     153611 � 18%  softirqs.CPU101.RCU
>      41592 �  2%    +191.0%     121049 �  3%  softirqs.CPU101.SCHED
>      43980 � 19%    +249.1%     153528 � 16%  softirqs.CPU102.RCU
>      41317 �  2%    +202.6%     125009        softirqs.CPU102.SCHED
>      41478 � 19%    +265.9%     151785 � 18%  softirqs.CPU103.RCU
>      40483 �  3%    +201.7%     122122 �  2%  softirqs.CPU103.SCHED
>      40685 � 18%    +254.6%     144288 � 16%  softirqs.CPU104.RCU
>      40294 �  3%    +189.8%     116773 �  4%  softirqs.CPU104.SCHED
>      42983 � 18%    +250.3%     150574 � 19%  softirqs.CPU105.RCU
>      41556          +191.9%     121290 �  7%  softirqs.CPU105.SCHED
>      43022 � 17%    +257.3%     153739 � 19%  softirqs.CPU106.RCU
>      37758 � 25%    +216.4%     119467 �  6%  softirqs.CPU106.SCHED
>      42788 � 21%    +258.1%     153241 � 15%  softirqs.CPU107.RCU
>      41843 �  2%    +183.8%     118749 �  7%  softirqs.CPU107.SCHED
>      42845 � 15%    +267.4%     157401 � 18%  softirqs.CPU108.RCU
>      42237          +187.3%     121351 �  4%  softirqs.CPU108.SCHED
>      42293 � 17%    +236.1%     142135 � 16%  softirqs.CPU109.RCU
>      41362 �  2%    +200.8%     124425 �  3%  softirqs.CPU109.SCHED
>      48453 � 12%    +261.6%     175223 � 19%  softirqs.CPU11.RCU
>      48735 � 18%    +183.4%     138131 � 13%  softirqs.CPU11.SCHED
>      40644 � 20%    +253.7%     143757 � 17%  softirqs.CPU110.RCU
>      41110 �  3%    +190.2%     119302 �  4%  softirqs.CPU110.SCHED
>      41486 � 18%    +261.4%     149920 � 16%  softirqs.CPU111.RCU
>      41832 �  2%    +191.0%     121750 �  3%  softirqs.CPU111.SCHED
>      39377 � 18%    +226.7%     128641 � 18%  softirqs.CPU112.RCU
>      40013 �  8%    +204.3%     121773 �  3%  softirqs.CPU112.SCHED
>      49821 � 27%    +202.9%     150883 � 14%  softirqs.CPU113.RCU
>      44545 � 12%    +210.8%     138439 �  9%  softirqs.CPU113.SCHED
>      41024 � 21%    +232.3%     136334 � 18%  softirqs.CPU114.RCU
>      42679 �  2%    +174.9%     117341 �  6%  softirqs.CPU114.SCHED
>      51244 � 29%    +196.3%     151833 � 13%  softirqs.CPU115.RCU
>      45818 �  8%    +208.4%     141320 � 10%  softirqs.CPU115.SCHED
>      48095 � 14%    +196.4%     142558 � 20%  softirqs.CPU116.RCU
>      44696 �  5%    +190.3%     129754 � 18%  softirqs.CPU116.SCHED
>      43739 � 18%    +212.5%     136681 � 18%  softirqs.CPU117.RCU
>      43118 �  3%    +183.4%     122201 �  4%  softirqs.CPU117.SCHED
>      47700 � 26%    +218.8%     152070 � 25%  softirqs.CPU118.RCU
>      44380 �  6%    +187.7%     127669 � 27%  softirqs.CPU118.SCHED
>      47016 � 16%    +203.3%     142611 � 18%  softirqs.CPU119.RCU
>      41382 � 19%    +179.5%     115658 � 18%  softirqs.CPU119.SCHED
>      44608 � 18%    +279.6%     169333 � 17%  softirqs.CPU12.RCU
>      43775 �  2%    +193.5%     128499 �  2%  softirqs.CPU12.SCHED
>      44136 � 17%    +223.6%     142847 � 16%  softirqs.CPU120.RCU
>      43181          +198.7%     128978        softirqs.CPU120.SCHED
>      39889 � 20%    +211.9%     124411 � 17%  softirqs.CPU121.RCU
>      39687 � 18%    +225.4%     129141        softirqs.CPU121.SCHED
>      40695 � 19%    +205.1%     124161 � 14%  softirqs.CPU122.RCU
>      42719          +201.9%     128991        softirqs.CPU122.SCHED
>      42156 � 17%    +234.7%     141093 � 13%  softirqs.CPU123.RCU
>      40098 � 16%    +222.4%     129267        softirqs.CPU123.SCHED
>      42220 � 18%    +239.9%     143519 � 14%  softirqs.CPU124.RCU
>      43005          +199.6%     128831        softirqs.CPU124.SCHED
>      42387 � 18%    +241.0%     144536 � 13%  softirqs.CPU125.RCU
>      42942          +199.7%     128688        softirqs.CPU125.SCHED
>      41968 � 17%    +238.0%     141872 � 14%  softirqs.CPU126.RCU
>      43047          +199.2%     128796        softirqs.CPU126.SCHED
>      40429 � 18%    +229.9%     133370 � 15%  softirqs.CPU127.RCU
>      42890          +200.5%     128904        softirqs.CPU127.SCHED
>      48217 � 16%    +244.5%     166100 � 13%  softirqs.CPU128.RCU
>      42893          +199.7%     128534        softirqs.CPU128.SCHED
>      48941 � 17%    +262.6%     177454 � 15%  softirqs.CPU129.RCU
>      42940          +176.2%     118609 � 18%  softirqs.CPU129.SCHED
>      55036 � 23%    +233.4%     183509 � 10%  softirqs.CPU13.RCU
>      52316 � 21%    +207.1%     160681 � 14%  softirqs.CPU13.SCHED
>      48310 � 16%    +253.7%     170891 � 13%  softirqs.CPU130.RCU
>      42924          +199.8%     128689        softirqs.CPU130.SCHED
>      50605 � 18%    +261.4%     182894 � 15%  softirqs.CPU131.RCU
>      42946          +199.8%     128751        softirqs.CPU131.SCHED
>      50618 � 17%    +257.9%     181155 � 14%  softirqs.CPU132.RCU
>      42950          +199.9%     128823        softirqs.CPU132.SCHED
>      47107 � 16%    +228.9%     154953 � 14%  softirqs.CPU133.RCU
>      42859          +199.7%     128457        softirqs.CPU133.SCHED
>      47255 � 16%    +253.5%     167059 � 13%  softirqs.CPU134.RCU
>      42869          +199.9%     128578        softirqs.CPU134.SCHED
>      48997 � 17%    +263.0%     177884 � 16%  softirqs.CPU135.RCU
>      43088          +198.5%     128617        softirqs.CPU135.SCHED
>      48290 � 17%    +231.1%     159866 � 12%  softirqs.CPU136.RCU
>      42871          +199.7%     128486        softirqs.CPU136.SCHED
>      50797 � 18%    +253.8%     179726 � 15%  softirqs.CPU137.RCU
>      42855          +200.4%     128740        softirqs.CPU137.SCHED
>      50699 � 17%    +250.8%     177866 � 19%  softirqs.CPU138.RCU
>      42914          +199.5%     128513        softirqs.CPU138.SCHED
>      50423 � 17%    +245.4%     174159 � 15%  softirqs.CPU139.RCU
>      42979          +199.6%     128778        softirqs.CPU139.SCHED
>      52819 � 20%    +219.3%     168636 � 18%  softirqs.CPU14.RCU
>      43159 � 13%    +209.6%     133628 � 16%  softirqs.CPU14.SCHED
>      46894 � 16%    +278.5%     177496 � 16%  softirqs.CPU140.RCU
>      43124          +198.4%     128690        softirqs.CPU140.SCHED
>      49658 � 17%    +245.7%     171649 � 12%  softirqs.CPU141.RCU
>      43089          +197.8%     128335        softirqs.CPU141.SCHED
>      46164 � 29%    +291.6%     180797 � 15%  softirqs.CPU142.RCU
>      42946          +200.1%     128881        softirqs.CPU142.SCHED
>      49975 � 17%    +233.4%     166629 � 20%  softirqs.CPU143.RCU
>      43226          +197.7%     128696        softirqs.CPU143.SCHED
>      47691 � 16%    +254.9%     169272 � 16%  softirqs.CPU144.RCU
>      39846 � 18%    +219.0%     127096 �  3%  softirqs.CPU144.SCHED
>      47014 � 16%    +237.7%     158783 �  9%  softirqs.CPU145.RCU
>      42817          +196.6%     127008 �  2%  softirqs.CPU145.SCHED
>      44737 � 18%    +238.4%     151384 � 13%  softirqs.CPU146.RCU
>      42881          +196.0%     126941 �  3%  softirqs.CPU146.SCHED
>      48710 � 18%    +263.8%     177218 � 15%  softirqs.CPU147.RCU
>      42869          +198.1%     127792 �  2%  softirqs.CPU147.SCHED
>      48313 � 19%    +266.6%     177140 � 17%  softirqs.CPU148.RCU
>      42667          +197.8%     127064 �  2%  softirqs.CPU148.SCHED
>      48745 � 19%    +267.5%     179137 � 17%  softirqs.CPU149.RCU
>      42779          +191.5%     124719 �  5%  softirqs.CPU149.SCHED
>      55797 � 22%    +202.4%     168757 � 25%  softirqs.CPU15.RCU
>      47221 � 11%    +185.3%     134730 � 17%  softirqs.CPU15.SCHED
>      49276 � 18%    +263.5%     179135 � 16%  softirqs.CPU150.RCU
>      42737          +198.9%     127761 �  2%  softirqs.CPU150.SCHED
>      48546 � 19%    +257.1%     173353 � 14%  softirqs.CPU151.RCU
>      42744          +197.7%     127256 �  2%  softirqs.CPU151.SCHED
>      47510 � 19%    +268.4%     175050 � 17%  softirqs.CPU152.RCU
>      43159          +195.2%     127387 �  2%  softirqs.CPU152.SCHED
>      47736 � 17%    +254.1%     169020 � 14%  softirqs.CPU153.RCU
>      42572          +198.8%     127216 �  2%  softirqs.CPU153.SCHED
>      49147 � 18%    +260.8%     177322 � 15%  softirqs.CPU154.RCU
>      42684          +192.1%     124671 �  6%  softirqs.CPU154.SCHED
>      49797 � 19%    +259.2%     178865 � 16%  softirqs.CPU155.RCU
>      42812          +191.2%     124665 �  4%  softirqs.CPU155.SCHED
>      45522 � 16%    +257.2%     162586 � 14%  softirqs.CPU156.RCU
>      42444 �  2%    +198.5%     126691 �  2%  softirqs.CPU156.SCHED
>      45992 � 17%    +253.9%     162770 � 14%  softirqs.CPU157.RCU
>      42499          +198.1%     126676 �  3%  softirqs.CPU157.SCHED
>      48781 � 19%    +259.2%     175202 � 17%  softirqs.CPU158.RCU
>      42565          +199.9%     127672 �  2%  softirqs.CPU158.SCHED
>      43221 � 13%    +282.9%     165496 � 15%  softirqs.CPU159.RCU
>      42456          +199.7%     127247 �  2%  softirqs.CPU159.SCHED
>      43889 � 15%    +217.8%     139494 � 20%  softirqs.CPU16.RCU
>      43807 �  4%    +189.4%     126785 �  4%  softirqs.CPU16.SCHED
>      46851 � 18%    +223.7%     151649 � 20%  softirqs.CPU160.RCU
>      42661          +198.0%     127128 �  3%  softirqs.CPU160.SCHED
>      48331 � 17%    +229.3%     159146 � 19%  softirqs.CPU161.RCU
>      43157          +194.8%     127235 �  2%  softirqs.CPU161.SCHED
>      43141 � 20%    +214.8%     135819 � 22%  softirqs.CPU162.RCU
>      42300 �  2%    +199.3%     126619 �  3%  softirqs.CPU162.SCHED
>      46485 � 17%    +234.6%     155555 � 18%  softirqs.CPU163.RCU
>      42606          +196.8%     126464 �  3%  softirqs.CPU163.SCHED
>      50580 � 17%    +217.2%     160421 � 15%  softirqs.CPU164.RCU
>      43720 �  5%    +208.9%     135065 � 11%  softirqs.CPU164.SCHED
>      46832 � 16%    +227.4%     153312 � 18%  softirqs.CPU165.RCU
>      43201          +194.5%     127249 �  2%  softirqs.CPU165.SCHED
>      48015 � 16%    +239.6%     163069 � 18%  softirqs.CPU166.RCU
>      42996          +196.3%     127414 �  2%  softirqs.CPU166.SCHED
>      49610 � 17%    +217.9%     157708 � 16%  softirqs.CPU167.RCU
>      42104 �  6%    +181.6%     118568 � 14%  softirqs.CPU167.SCHED
>      45412 � 18%    +242.1%     155368 � 15%  softirqs.CPU168.RCU
>      37913 � 28%    +235.9%     127357 �  2%  softirqs.CPU168.SCHED
>      42364 � 17%    +237.9%     143165 � 16%  softirqs.CPU169.RCU
>      42947          +196.9%     127511 �  2%  softirqs.CPU169.SCHED
>      41809 � 16%    +226.8%     136639 � 18%  softirqs.CPU17.RCU
>      43062 �  2%    +184.6%     122557 �  3%  softirqs.CPU17.SCHED
>      41355 � 18%    +235.0%     138528 � 17%  softirqs.CPU170.RCU
>      42981          +195.6%     127038 �  2%  softirqs.CPU170.SCHED
>      44314 � 17%    +254.2%     156976 � 15%  softirqs.CPU171.RCU
>      42797          +198.4%     127690 �  2%  softirqs.CPU171.SCHED
>      42907 � 18%    +255.1%     152357 � 15%  softirqs.CPU172.RCU
>      42782          +197.2%     127138 �  2%  softirqs.CPU172.SCHED
>      44525 � 17%    +249.4%     155577 � 16%  softirqs.CPU173.RCU
>      42965          +196.8%     127535 �  2%  softirqs.CPU173.SCHED
>      44451 � 17%    +253.6%     157160 � 16%  softirqs.CPU174.RCU
>      39726 � 17%    +202.8%     120305 � 12%  softirqs.CPU174.SCHED
>      43013 � 17%    +243.7%     147830 � 15%  softirqs.CPU175.RCU
>      42875          +196.2%     127007 �  2%  softirqs.CPU175.SCHED
>      48247 � 17%    +265.0%     176099 � 13%  softirqs.CPU176.RCU
>      42918          +196.9%     127435 �  2%  softirqs.CPU176.SCHED
>      47684 � 16%    +259.4%     171352 � 13%  softirqs.CPU177.RCU
>      42930          +197.0%     127486 �  2%  softirqs.CPU177.SCHED
>      48461 � 17%    +270.9%     179734 � 14%  softirqs.CPU178.RCU
>      42903          +197.0%     127416 �  2%  softirqs.CPU178.SCHED
>      49351 � 18%    +258.6%     176969 � 15%  softirqs.CPU179.RCU
>      42835          +198.0%     127641 �  2%  softirqs.CPU179.SCHED
>      42112 � 18%    +232.2%     139876 � 18%  softirqs.CPU18.RCU
>      41917 �  6%    +188.8%     121070 �  6%  softirqs.CPU18.SCHED
>      46700 � 15%    +256.6%     166553 � 15%  softirqs.CPU180.RCU
>      42770          +197.1%     127081 �  2%  softirqs.CPU180.SCHED
>      46319 � 16%    +251.4%     162763 � 13%  softirqs.CPU181.RCU
>      42811          +196.3%     126870 �  2%  softirqs.CPU181.SCHED
>      49048 � 17%    +269.2%     181069 � 15%  softirqs.CPU182.RCU
>      42901          +197.1%     127479 �  2%  softirqs.CPU182.SCHED
>      46991 � 15%    +243.9%     161593 � 13%  softirqs.CPU183.RCU
>      42758          +197.2%     127081 �  2%  softirqs.CPU183.SCHED
>      48663 � 16%    +259.0%     174707 � 13%  softirqs.CPU184.RCU
>      42692          +198.8%     127565 �  2%  softirqs.CPU184.SCHED
>      49390 � 17%    +261.0%     178275 � 14%  softirqs.CPU185.RCU
>      42892          +197.0%     127411 �  2%  softirqs.CPU185.SCHED
>      40647 � 24%    +281.6%     155111 � 16%  softirqs.CPU186.RCU
>      43084          +194.4%     126861 �  2%  softirqs.CPU186.SCHED
>      49093 � 15%    +270.0%     181656 � 15%  softirqs.CPU187.RCU
>      42737          +197.7%     127220 �  2%  softirqs.CPU187.SCHED
>      48869 � 18%    +273.1%     182329 � 16%  softirqs.CPU188.RCU
>      42782          +197.7%     127359 �  2%  softirqs.CPU188.SCHED
>      46694 � 16%    +266.7%     171220 � 14%  softirqs.CPU189.RCU
>      42509          +199.1%     127150 �  2%  softirqs.CPU189.SCHED
>      40050 � 19%    +240.9%     136513 � 18%  softirqs.CPU19.RCU
>      39309 � 17%    +209.7%     121760 �  6%  softirqs.CPU19.SCHED
>      48637 � 17%    +272.5%     181180 � 16%  softirqs.CPU190.RCU
>      42877 �  2%    +206.4%     131354 �  7%  softirqs.CPU190.SCHED
>      47627 � 15%    +254.5%     168848 � 13%  softirqs.CPU191.RCU
>      28001 � 23%    +240.7%      95412 � 29%  softirqs.CPU191.SCHED
>      54426 � 18%    +221.3%     174885 � 23%  softirqs.CPU2.RCU
>      44916 �  6%    +187.0%     128892 � 25%  softirqs.CPU2.SCHED
>      40331 � 19%    +231.5%     133709 � 17%  softirqs.CPU20.RCU
>      39401 � 17%    +221.4%     126625 �  5%  softirqs.CPU20.SCHED
>      39891 � 19%    +243.9%     137191 � 19%  softirqs.CPU21.RCU
>      39521 � 17%    +236.4%     132930 � 17%  softirqs.CPU22.RCU
>      42309          +189.2%     122370 �  5%  softirqs.CPU22.SCHED
>      39369 � 19%    +243.9%     135409 � 18%  softirqs.CPU23.RCU
>      41982          +197.6%     124944        softirqs.CPU23.SCHED
>      43827 � 17%    +230.4%     144800 � 17%  softirqs.CPU24.RCU
>      43392          +175.1%     119368 � 19%  softirqs.CPU24.SCHED
>      39340 � 18%    +215.8%     124243 � 20%  softirqs.CPU25.RCU
>      42674          +201.6%     128703        softirqs.CPU25.SCHED
>      41063 � 17%    +220.5%     131589 � 16%  softirqs.CPU26.RCU
>      44950 � 10%    +190.5%     130563 �  3%  softirqs.CPU26.SCHED
>      42200 � 17%    +245.9%     145986 � 14%  softirqs.CPU27.RCU
>      43888 �  3%    +197.5%     130586 �  3%  softirqs.CPU27.SCHED
>      42448 � 18%    +239.8%     144233 � 14%  softirqs.CPU28.RCU
>      42899          +201.1%     129177        softirqs.CPU28.SCHED
>      40082 � 18%    +264.6%     146157 � 13%  softirqs.CPU29.RCU
>      53587 � 20%    +141.1%     129212        softirqs.CPU29.SCHED
>      45978 � 24%    +264.0%     167357 � 22%  softirqs.CPU3.RCU
>      42350 �  4%    +194.7%     124827 �  2%  softirqs.CPU3.SCHED
>      42308 � 17%    +238.6%     143261 � 14%  softirqs.CPU30.RCU
>      44139 �  4%    +190.6%     128281        softirqs.CPU30.SCHED
>      39958 � 21%    +241.3%     136377 � 15%  softirqs.CPU31.RCU
>      61474 � 32%    +109.1%     128561        softirqs.CPU31.SCHED
>      50434 � 15%    +237.7%     170309 � 11%  softirqs.CPU32.RCU
>      43540 �  3%    +196.0%     128860        softirqs.CPU32.SCHED
>      50391 � 16%    +251.2%     176949 � 15%  softirqs.CPU33.RCU
>      45705 � 13%    +181.7%     128738        softirqs.CPU33.SCHED
>      49965 � 15%    +253.6%     176666 � 13%  softirqs.CPU34.RCU
>      42883          +199.7%     128527        softirqs.CPU34.SCHED
>      51875 � 17%    +259.2%     186362 � 13%  softirqs.CPU35.RCU
>      43448 �  2%    +195.8%     128522        softirqs.CPU35.SCHED
>      52075 � 15%    +254.3%     184529 � 13%  softirqs.CPU36.RCU
>      42919          +199.6%     128584        softirqs.CPU36.SCHED
>      48685 � 16%    +229.1%     160202 � 14%  softirqs.CPU37.RCU
>      42690          +200.9%     128461        softirqs.CPU37.SCHED
>      49203 � 16%    +249.0%     171741 � 13%  softirqs.CPU38.RCU
>      42846          +182.4%     120982 � 17%  softirqs.CPU38.SCHED
>      50971 � 16%    +253.9%     180392 � 16%  softirqs.CPU39.RCU
>      42890          +200.2%     128754        softirqs.CPU39.SCHED
>      50852 � 20%    +276.7%     191550 � 14%  softirqs.CPU4.RCU
>      44115 �  6%    +253.5%     155969 � 16%  softirqs.CPU4.SCHED
>      49870 � 15%    +226.2%     162692 � 13%  softirqs.CPU40.RCU
>      42850          +205.4%     130844 �  4%  softirqs.CPU40.SCHED
>      11.83 � 17%  +42850.7%       5082 �222%  softirqs.CPU40.TIMER
>      51256 � 16%    +258.7%     183849 � 15%  softirqs.CPU41.RCU
>      46670 � 17%    +175.6%     128620        softirqs.CPU41.SCHED
>      52995 � 13%    +243.3%     181911 � 17%  softirqs.CPU42.RCU
>      42980          +198.9%     128479        softirqs.CPU42.SCHED
>      52444 � 16%    +240.5%     178580 � 15%  softirqs.CPU43.RCU
>      43010          +197.9%     128145        softirqs.CPU43.SCHED
>      50509 � 15%    +261.1%     182399 � 15%  softirqs.CPU44.RCU
>      43255 �  2%    +198.5%     129135        softirqs.CPU44.SCHED
>      51524 � 16%    +241.7%     176076 � 12%  softirqs.CPU45.RCU
>      43126          +197.9%     128493        softirqs.CPU45.SCHED
>      52276 � 17%    +250.2%     183055 � 13%  softirqs.CPU46.RCU
>      42954          +199.6%     128692        softirqs.CPU46.SCHED
>      52168 � 16%    +228.4%     171301 � 20%  softirqs.CPU47.RCU
>      42939          +200.2%     128907        softirqs.CPU47.SCHED
>      53681 � 15%    +231.6%     178016 � 14%  softirqs.CPU48.RCU
>      43740 �  2%    +191.9%     127684 �  2%  softirqs.CPU48.SCHED
>      49552 � 16%    +237.7%     167333 �  8%  softirqs.CPU49.RCU
>      42962          +196.1%     127208 �  2%  softirqs.CPU49.SCHED
>      49029 � 14%    +255.8%     174467 � 18%  softirqs.CPU5.RCU
>      43874 �  4%    +199.9%     131564 �  5%  softirqs.CPU5.SCHED
>      50757 � 21%    +215.7%     160254 � 14%  softirqs.CPU50.RCU
>      44004 �  5%    +193.6%     129191 �  3%  softirqs.CPU50.SCHED
>      51333 � 16%    +264.0%     186847 � 13%  softirqs.CPU51.RCU
>      43064          +173.7%     117859 � 18%  softirqs.CPU51.SCHED
>      51372 � 16%    +259.9%     184905 � 15%  softirqs.CPU52.RCU
>      42624          +199.8%     127808 �  2%  softirqs.CPU52.SCHED
>      52646 � 16%    +268.1%     193772 � 12%  softirqs.CPU53.RCU
>      43279 �  2%    +214.7%     136197 � 13%  softirqs.CPU53.SCHED
>      51606 � 16%    +261.5%     186539 � 14%  softirqs.CPU54.RCU
>      42691          +198.2%     127300 �  2%  softirqs.CPU54.SCHED
>      50188 � 15%    +252.5%     176918 � 13%  softirqs.CPU55.RCU
>      39940 � 16%    +220.0%     127793        softirqs.CPU55.SCHED
>      50110 � 16%    +279.9%     190347 � 12%  softirqs.CPU56.RCU
>      43453 �  2%    +218.5%     138402 � 16%  softirqs.CPU56.SCHED
>      49678 � 15%    +260.7%     179197 � 11%  softirqs.CPU57.RCU
>      42419          +204.0%     128955 �  2%  softirqs.CPU57.SCHED
>      51036 � 17%    +264.3%     185947 � 13%  softirqs.CPU58.RCU
>      42674          +200.9%     128427        softirqs.CPU58.SCHED
>      52214 � 18%    +268.3%     192302 � 11%  softirqs.CPU59.RCU
>      42919          +215.3%     135304 � 11%  softirqs.CPU59.SCHED
>      45835 � 20%    +246.6%     158888 � 15%  softirqs.CPU6.RCU
>      42428          +200.5%     127488 �  2%  softirqs.CPU6.SCHED
>      47933 � 15%    +255.5%     170407 � 13%  softirqs.CPU60.RCU
>      42799          +202.9%     129618 �  4%  softirqs.CPU60.SCHED
>      49088 � 16%    +246.0%     169846 � 11%  softirqs.CPU61.RCU
>      43356 �  2%    +193.9%     127410 �  2%  softirqs.CPU61.SCHED
>      53333 � 18%    +254.6%     189122 � 11%  softirqs.CPU62.RCU
>      43861 �  4%    +209.8%     135861 � 12%  softirqs.CPU62.SCHED
>      53241 � 22%    +236.8%     179298 � 13%  softirqs.CPU63.RCU
>      44674 �  8%    +205.8%     136632 � 14%  softirqs.CPU63.SCHED
>      49905 � 14%    +215.5%     157474 � 18%  softirqs.CPU64.RCU
>      43368 �  2%    +198.3%     129382 �  2%  softirqs.CPU64.SCHED
>      48982 � 16%    +226.6%     160001 � 18%  softirqs.CPU65.RCU
>      43072          +197.4%     128104        softirqs.CPU65.SCHED
>      45954 � 20%    +196.8%     136398 � 22%  softirqs.CPU66.RCU
>      42649          +199.1%     127549 �  2%  softirqs.CPU66.SCHED
>      47346 � 17%    +231.5%     156959 � 14%  softirqs.CPU67.RCU
>      42757          +197.7%     127294 �  2%  softirqs.CPU67.SCHED
>      21.00 � 78%  +35142.1%       7400 �221%  softirqs.CPU67.TIMER
>      48696 � 17%    +234.0%     162652 � 22%  softirqs.CPU68.RCU
>      42961          +196.8%     127499 �  2%  softirqs.CPU68.SCHED
>      46723 � 19%    +241.6%     159592 � 14%  softirqs.CPU69.RCU
>      42165 �  2%    +208.5%     130068 �  5%  softirqs.CPU69.SCHED
>      46511 � 12%    +311.3%     191298 � 11%  softirqs.CPU7.RCU
>      42704 �  2%    +267.8%     157047 � 15%  softirqs.CPU7.SCHED
>      48338 � 18%    +244.8%     166664 � 17%  softirqs.CPU70.RCU
>      42794          +198.1%     127548 �  2%  softirqs.CPU70.SCHED
>      46911 � 19%    +238.4%     158759 � 18%  softirqs.CPU71.RCU
>      43148          +195.7%     127600 �  2%  softirqs.CPU71.SCHED
>      47114 � 16%    +241.6%     160935 � 15%  softirqs.CPU72.RCU
>      42568          +191.3%     123982 �  6%  softirqs.CPU72.SCHED
>      44503 � 17%    +240.8%     151658 � 15%  softirqs.CPU73.RCU
>      42500          +184.6%     120955 � 16%  softirqs.CPU73.SCHED
>      43480 � 19%    +230.4%     143673 � 18%  softirqs.CPU74.RCU
>      42477          +183.4%     120389 � 11%  softirqs.CPU74.SCHED
>      45923 � 17%    +246.7%     159220 � 14%  softirqs.CPU75.RCU
>      42440          +199.4%     127053 �  2%  softirqs.CPU75.SCHED
>      45853 � 19%    +242.4%     156991 � 15%  softirqs.CPU76.RCU
>      42526          +201.0%     127994 �  3%  softirqs.CPU76.SCHED
>      45711 � 17%    +246.0%     158164 � 16%  softirqs.CPU77.RCU
>      42384          +199.7%     127037 �  2%  softirqs.CPU77.SCHED
>      45632 � 16%    +245.0%     157419 � 14%  softirqs.CPU78.RCU
>      42568          +197.3%     126542 �  2%  softirqs.CPU78.SCHED
>      45016 � 17%    +236.6%     151502 � 14%  softirqs.CPU79.RCU
>      42256          +199.1%     126390 �  2%  softirqs.CPU79.SCHED
>      45137 � 11%    +272.8%     168281 � 19%  softirqs.CPU8.RCU
>      44416 �  9%    +209.3%     137371 � 16%  softirqs.CPU8.SCHED
>      49887 � 17%    +265.9%     182560 � 13%  softirqs.CPU80.RCU
>      42640          +195.7%     126093 �  2%  softirqs.CPU80.SCHED
>      47646 � 15%    +262.9%     172885 � 13%  softirqs.CPU81.RCU
>      42582          +196.8%     126400 �  2%  softirqs.CPU81.SCHED
>      49622 � 18%    +270.0%     183592 � 14%  softirqs.CPU82.RCU
>      42458          +198.6%     126761 �  2%  softirqs.CPU82.SCHED
>      49861 � 17%    +258.5%     178732 � 14%  softirqs.CPU83.RCU
>      42577          +198.4%     127038 �  2%  softirqs.CPU83.SCHED
>      47320 � 15%    +253.2%     167129 � 13%  softirqs.CPU84.RCU
>      42307          +198.2%     126152 �  2%  softirqs.CPU84.SCHED
>      47744 � 15%    +250.8%     167497 � 12%  softirqs.CPU85.RCU
>      42189          +199.4%     126299 �  3%  softirqs.CPU85.SCHED
>      48849 � 19%    +275.9%     183609 � 14%  softirqs.CPU86.RCU
>      42347          +199.8%     126939 �  2%  softirqs.CPU86.SCHED
>      47686 � 16%    +242.0%     163098 � 13%  softirqs.CPU87.RCU
>      42395          +199.0%     126761 �  2%  softirqs.CPU87.SCHED
>      48776 � 16%    +259.3%     175253 � 13%  softirqs.CPU88.RCU
>      42344          +182.2%     119513 � 12%  softirqs.CPU88.SCHED
>      50336 � 17%    +258.6%     180495 � 13%  softirqs.CPU89.RCU
>      42601          +197.1%     126559 �  2%  softirqs.CPU89.SCHED
>      44394 � 14%    +259.4%     159563 � 18%  softirqs.CPU9.RCU
>      42487          +199.3%     127156 �  3%  softirqs.CPU9.SCHED
>      46308 � 19%    +242.4%     158563 � 16%  softirqs.CPU90.RCU
>      42469          +197.7%     126423 �  2%  softirqs.CPU90.SCHED
>      50144 � 16%    +268.2%     184632 � 15%  softirqs.CPU91.RCU
>      42500          +197.7%     126505 �  2%  softirqs.CPU91.SCHED
>      50364 � 17%    +264.4%     183530 � 15%  softirqs.CPU92.RCU
>      42544          +197.9%     126755 �  2%  softirqs.CPU92.SCHED
>      47189 � 17%    +268.9%     174087 � 13%  softirqs.CPU93.RCU
>      42182          +200.0%     126554 �  2%  softirqs.CPU93.SCHED
>      50818 � 18%    +263.4%     184692 � 15%  softirqs.CPU94.RCU
>      42768          +196.9%     126978 �  2%  softirqs.CPU94.SCHED
>      49496 � 15%    +247.3%     171917 � 11%  softirqs.CPU95.RCU
>      22401 � 11%    +270.9%      83076 � 46%  softirqs.CPU95.SCHED
>      42634 � 18%    +266.4%     156208 � 19%  softirqs.CPU96.RCU
>      41316 � 17%    +269.4%     152640 � 18%  softirqs.CPU97.RCU
>      41578 �  3%    +195.2%     122722 �  2%  softirqs.CPU97.SCHED
>      41991 � 20%    +266.1%     153710 � 17%  softirqs.CPU98.RCU
>      40589 �  5%    +197.9%     120925 �  3%  softirqs.CPU98.SCHED
>      43012 � 18%    +254.8%     152628 � 18%  softirqs.CPU99.RCU
>      42041 �  2%    +191.2%     122444 �  2%  softirqs.CPU99.SCHED
>      18511 � 46%    +211.2%      57608 � 27%  softirqs.NET_RX
>    9023846 � 15%    +248.2%   31418582 � 12%  softirqs.RCU
>    8211849          +197.7%   24442961        softirqs.SCHED
>      60379 �  2%    +163.2%     158940 �  3%  softirqs.TIMER
>       6.22 �  4%      -4.2        2.04 � 22%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents
>      62.31 �  2%      -4.2       58.15 �  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      62.31 �  2%      -4.2       58.15 �  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      62.27 �  2%      -4.2       58.11 �  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       4.96 �  5%      -4.0        1.01 � 41%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>      62.50 �  2%      -3.8       58.74 �  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      56.59 �  2%      -3.8       52.83 �  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       5.68 �  4%      -3.6        2.04 � 22%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       5.68 �  4%      -3.6        2.04 � 22%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
>       5.67 �  4%      -3.6        2.04 � 22%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
>       5.10 �  9%      -3.4        1.73 � 24%  perf-profile.calltrace.cycles-pp.submit_one_bio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range
>       5.09 �  9%      -3.4        1.72 � 24%  perf-profile.calltrace.cycles-pp.btrfs_submit_metadata_bio.submit_one_bio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
>       4.90 �  9%      -3.3        1.63 � 24%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_metadata_bio.submit_one_bio.btree_write_cache_pages.do_writepages
>       4.88 �  9%      -3.2        1.63 � 24%  perf-profile.calltrace.cycles-pp.csum_one_extent_buffer.btree_csum_one_bio.btrfs_submit_metadata_bio.submit_one_bio.btree_write_cache_pages
>       2.94 �  4%      -1.9        1.08 � 28%  perf-profile.calltrace.cycles-pp.check_leaf.csum_one_extent_buffer.btree_csum_one_bio.btrfs_submit_metadata_bio.submit_one_bio
>       3.21 �  3%      -1.7        1.52 � 25%  perf-profile.calltrace.cycles-pp.open64
>       3.20 �  3%      -1.7        1.52 � 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       3.19 �  3%      -1.7        1.51 � 25%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       3.19 �  3%      -1.7        1.52 � 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       3.18 �  3%      -1.7        1.51 � 25%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       3.14 �  3%      -1.6        1.49 � 25%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.13 �  3%      -1.6        1.49 � 25%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
>       2.62 � 12%      -1.5        1.08 � 28%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>       2.72 � 11%      -1.3        1.40 � 44%  perf-profile.calltrace.cycles-pp.ret_from_fork
>       2.72 � 11%      -1.3        1.40 � 44%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>       2.24 � 12%      -1.3        0.92 � 30%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>       1.96 � 11%      -1.3        0.69 � 54%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
>       2.37 �  3%      -1.2        1.16 � 26%  perf-profile.calltrace.cycles-pp.btrfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
>       1.58 �  6%      -1.1        0.44 � 74%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       1.59 �  9%      -1.1        0.45 � 73%  perf-profile.calltrace.cycles-pp.btrfs_finish_ordered_io.btrfs_work_helper.process_one_work.worker_thread.kthread
>       2.94 �  4%      -1.0        1.92 �  8%  perf-profile.calltrace.cycles-pp.copy_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       1.30 �  2%      -1.0        0.32 �102%  perf-profile.calltrace.cycles-pp.btrfs_get_32.check_leaf.csum_one_extent_buffer.btree_csum_one_bio.btrfs_submit_metadata_bio
>       1.30 �  7%      -1.0        0.34 �100%  perf-profile.calltrace.cycles-pp.write
>       1.29 �  7%      -1.0        0.33 �100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       1.29 �  7%      -1.0        0.33 �100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.28 �  7%      -1.0        0.33 �100%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.27 �  7%      -0.9        0.33 �100%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.25 �  7%      -0.9        0.32 �101%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.59 �  6%      -0.9        0.68 � 24%  perf-profile.calltrace.cycles-pp.btrfs_wait_ordered_range.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       1.20 �  6%      -0.9        0.30 �100%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>       1.19 �  6%      -0.9        0.30 �100%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
>       1.55 �  5%      -0.9        0.69 � 16%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       1.53 �  5%      -0.8        0.68 � 15%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>       0.89 �  6%      -0.6        0.33 �101%  perf-profile.calltrace.cycles-pp.btrfs_new_inode.btrfs_create.path_openat.do_filp_open.do_sys_openat2
>       1.93 �  2%      -0.5        1.43 �  6%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_csums.copy_items.btrfs_log_inode.btrfs_log_inode_parent
>       1.93 �  2%      -0.5        1.43 �  6%  perf-profile.calltrace.cycles-pp.log_csums.copy_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
>       1.27 �  3%      -0.2        1.05 �  3%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items.btrfs_log_inode
>       1.26 �  3%      -0.2        1.05 �  3%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items
>       1.49 �  9%      +0.2        1.72 �  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       6.84 �  3%      +1.3        8.16 �  5%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
>       0.36 � 71%      +1.4        1.78 � 20%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items
>       5.75 �  4%      +1.5        7.27 �  4%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.00            +1.6        1.56 � 22%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block
>       0.00            +1.6        1.57 � 22%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block
>       0.00            +1.6        1.61 � 22%  perf-profile.calltrace.cycles-pp.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot
>       0.00            +2.1        2.08 � 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__clear_extent_bit.clear_extent_bit.delete_tree_block
>       0.00            +2.1        2.09 � 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__clear_extent_bit.clear_extent_bit.delete_tree_block.__btrfs_cow_block
>       0.00            +2.1        2.12 � 10%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.delete_tree_block.__btrfs_cow_block.btrfs_cow_block
>       0.00            +2.1        2.12 � 10%  perf-profile.calltrace.cycles-pp.clear_extent_bit.delete_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot
>       1.10 �  6%      +2.2        3.26 � 12%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       0.00            +2.2        2.18 � 10%  perf-profile.calltrace.cycles-pp.delete_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items
>       1.78 �  3%      +2.6        4.36 � 11%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode
>       1.77 �  3%      +2.6        4.36 � 11%  perf-profile.calltrace.cycles-pp.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items
>       0.71 �  4%      +2.8        3.49 � 19%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       2.89 �  3%      +2.8        5.72 �  7%  perf-profile.calltrace.cycles-pp.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
>       2.89 �  3%      +2.8        5.72 �  7%  perf-profile.calltrace.cycles-pp.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       2.83 �  3%      +2.8        5.68 �  7%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent
>       0.00            +4.0        3.95 � 17%  perf-profile.calltrace.cycles-pp.rb_next.find_first_extent_bit_state.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents
>       0.00            +4.0        4.04 � 14%  perf-profile.calltrace.cycles-pp.rb_next.find_first_extent_bit_state.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log
>       0.68 �  6%      +4.6        5.31 � 14%  perf-profile.calltrace.cycles-pp.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.68 �  7%      +4.6        5.31 � 14%  perf-profile.calltrace.cycles-pp.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       1.83 �  5%      +4.9        6.76 � 15%  perf-profile.calltrace.cycles-pp.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
>       0.00            +5.2        5.16 � 15%  perf-profile.calltrace.cycles-pp.find_first_extent_bit_state.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log
>       0.00            +5.2        5.18 � 15%  perf-profile.calltrace.cycles-pp.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file
>       0.00            +5.2        5.18 � 13%  perf-profile.calltrace.cycles-pp.find_first_extent_bit_state.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
>       0.00            +5.2        5.20 � 13%  perf-profile.calltrace.cycles-pp.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>      12.75 �  3%      +5.5       18.25 �  9%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       8.80 �  3%      +6.2       15.01 �  8%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       8.79 �  3%      +6.2       15.00 �  8%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync
>      26.42 �  3%      +8.4       34.83 �  7%  perf-profile.calltrace.cycles-pp.fsync
>      26.33 �  3%      +8.5       34.79 �  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
>      26.32 �  3%      +8.5       34.78 �  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      26.30 �  3%      +8.5       34.77 �  7%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      26.29 �  3%      +8.5       34.76 �  7%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      26.30 �  3%      +8.5       34.77 �  7%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>       7.77 �  4%      -5.1        2.72 � 24%  perf-profile.children.cycles-pp.do_writepages
>       7.76 �  4%      -5.0        2.72 � 24%  perf-profile.children.cycles-pp.filemap_fdatawrite_range
>       7.75 �  4%      -5.0        2.71 � 23%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
>      62.31 �  2%      -4.2       58.15 �  2%  perf-profile.children.cycles-pp.start_secondary
>       6.22 �  4%      -4.1        2.15 � 25%  perf-profile.children.cycles-pp.btree_write_cache_pages
>       5.00 �  5%      -4.0        1.03 � 41%  perf-profile.children.cycles-pp.poll_idle
>      62.50 �  2%      -3.8       58.73 �  2%  perf-profile.children.cycles-pp.do_idle
>      62.50 �  2%      -3.8       58.74 �  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      62.50 �  2%      -3.8       58.74 �  2%  perf-profile.children.cycles-pp.cpu_startup_entry
>       5.65 �  4%      -3.7        1.97 � 26%  perf-profile.children.cycles-pp.submit_one_bio
>       5.33 �  5%      -3.5        1.83 � 27%  perf-profile.children.cycles-pp.btrfs_submit_metadata_bio
>       5.14 �  5%      -3.4        1.74 � 27%  perf-profile.children.cycles-pp.btree_csum_one_bio
>       5.12 �  5%      -3.4        1.73 � 27%  perf-profile.children.cycles-pp.csum_one_extent_buffer
>       6.04 �  4%      -3.1        2.96 � 19%  perf-profile.children.cycles-pp.perf_tp_event
>       5.72 �  4%      -3.0        2.72 � 18%  perf-profile.children.cycles-pp.__schedule
>       5.88 �  4%      -3.0        2.89 � 19%  perf-profile.children.cycles-pp.perf_swevent_overflow
>       5.86 �  3%      -3.0        2.88 � 19%  perf-profile.children.cycles-pp.__perf_event_overflow
>       5.84 �  3%      -3.0        2.87 � 19%  perf-profile.children.cycles-pp.perf_event_output_forward
>       5.05 �  3%      -2.5        2.52 � 19%  perf-profile.children.cycles-pp.perf_prepare_sample
>       4.79 �  3%      -2.4        2.41 � 19%  perf-profile.children.cycles-pp.perf_callchain
>       4.78 �  3%      -2.4        2.40 � 19%  perf-profile.children.cycles-pp.get_perf_callchain
>       3.42 �  3%      -2.2        1.18 � 32%  perf-profile.children.cycles-pp.check_leaf
>       4.18 �  3%      -2.2        2.02 � 19%  perf-profile.children.cycles-pp.schedule
>       3.92 �  3%      -1.9        1.97 � 18%  perf-profile.children.cycles-pp.perf_callchain_kernel
>       3.21 �  3%      -1.7        1.52 � 24%  perf-profile.children.cycles-pp.open64
>       3.22 �  3%      -1.7        1.57 � 24%  perf-profile.children.cycles-pp.do_sys_open
>       3.22 �  3%      -1.6        1.57 � 24%  perf-profile.children.cycles-pp.do_sys_openat2
>       3.17 �  3%      -1.6        1.54 � 24%  perf-profile.children.cycles-pp.do_filp_open
>       3.16 �  3%      -1.6        1.54 � 24%  perf-profile.children.cycles-pp.path_openat
>       2.50 �  9%      -1.6        0.93 � 24%  perf-profile.children.cycles-pp.asm_common_interrupt
>       2.49 �  9%      -1.6        0.92 � 25%  perf-profile.children.cycles-pp.common_interrupt
>       2.62 � 12%      -1.5        1.08 � 28%  perf-profile.children.cycles-pp.worker_thread
>       2.42 �  9%      -1.5        0.90 � 25%  perf-profile.children.cycles-pp.__common_interrupt
>       2.42 �  9%      -1.5        0.90 � 25%  perf-profile.children.cycles-pp.handle_edge_irq
>       2.40 �  9%      -1.5        0.88 � 25%  perf-profile.children.cycles-pp.handle_irq_event
>       2.39 �  9%      -1.5        0.88 � 25%  perf-profile.children.cycles-pp.handle_irq_event_percpu
>       2.36 �  9%      -1.5        0.87 � 25%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
>       3.01 �  3%      -1.5        1.52 � 19%  perf-profile.children.cycles-pp.unwind_next_frame
>       2.35 �  9%      -1.5        0.87 � 25%  perf-profile.children.cycles-pp.nvme_irq
>       2.61 �  6%      -1.4        1.19 � 24%  perf-profile.children.cycles-pp.try_to_wake_up
>       2.22 �  9%      -1.4        0.82 � 25%  perf-profile.children.cycles-pp.blk_mq_end_request_batch
>       2.14 � 10%      -1.4        0.79 � 24%  perf-profile.children.cycles-pp.blk_update_request
>       2.60 �  8%      -1.3        1.27 � 27%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
>       2.73 � 11%      -1.3        1.40 � 44%  perf-profile.children.cycles-pp.ret_from_fork
>       2.72 � 11%      -1.3        1.40 � 44%  perf-profile.children.cycles-pp.kthread
>       2.24 � 12%      -1.3        0.92 � 30%  perf-profile.children.cycles-pp.process_one_work
>       2.34 �  4%      -1.3        1.05 � 20%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>       2.37 �  3%      -1.2        1.16 � 26%  perf-profile.children.cycles-pp.btrfs_create
>       1.96 � 11%      -1.2        0.77 � 33%  perf-profile.children.cycles-pp.btrfs_work_helper
>       1.86 � 10%      -1.2        0.68 � 24%  perf-profile.children.cycles-pp.btrfs_end_bio
>       1.72 �  6%      -1.2        0.54 � 19%  perf-profile.children.cycles-pp.read_extent_buffer
>       1.86 �  4%      -1.1        0.72 � 23%  perf-profile.children.cycles-pp.folio_wait_bit
>       1.73 �  2%      -1.1        0.62 � 36%  perf-profile.children.cycles-pp.btrfs_get_32
>       1.67 �  6%      -1.1        0.55 � 25%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
>       1.67 �  6%      -1.1        0.56 � 25%  perf-profile.children.cycles-pp.filemap_fdatawait_range
>       1.80 �  4%      -1.1        0.69 � 22%  perf-profile.children.cycles-pp.io_schedule
>       2.12 �  4%      -1.1        1.03 � 19%  perf-profile.children.cycles-pp.dequeue_task_fair
>       1.72 �  9%      -1.1        0.65 � 22%  perf-profile.children.cycles-pp.__wake_up_common
>       2.09 �  4%      -1.1        1.02 � 19%  perf-profile.children.cycles-pp.dequeue_entity
>       1.39 � 21%      -1.0        0.34 �113%  perf-profile.children.cycles-pp.btrfs_commit_transaction
>       2.95 �  4%      -1.0        1.92 �  8%  perf-profile.children.cycles-pp.copy_items
>       1.55 �  6%      -1.0        0.53 � 25%  perf-profile.children.cycles-pp.folio_wait_writeback
>       1.59 �  9%      -1.0        0.60 � 22%  perf-profile.children.cycles-pp.btrfs_finish_ordered_io
>       1.58 �  6%      -1.0        0.60 � 21%  perf-profile.children.cycles-pp.start_ordered_ops
>       1.85 �  6%      -1.0        0.87 � 24%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       1.52 �  6%      -1.0        0.56 � 20%  perf-profile.children.cycles-pp.extent_writepages
>       1.52 �  6%      -1.0        0.56 � 21%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
>       1.69 �  7%      -0.9        0.76 � 25%  perf-profile.children.cycles-pp.ksys_write
>       2.08 �  4%      -0.9        1.16 � 15%  perf-profile.children.cycles-pp.update_curr
>       1.68 �  7%      -0.9        0.76 � 26%  perf-profile.children.cycles-pp.vfs_write
>       1.59 �  6%      -0.9        0.68 � 24%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
>       1.66 �  7%      -0.9        0.74 � 26%  perf-profile.children.cycles-pp.new_sync_write
>       1.95 �  4%      -0.9        1.09 � 15%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>       1.55 �  5%      -0.9        0.70 � 17%  perf-profile.children.cycles-pp.schedule_idle
>       1.22 �  7%      -0.9        0.36 � 18%  perf-profile.children.cycles-pp.btrfs_check_node
>       1.27 � 11%      -0.8        0.43 � 22%  perf-profile.children.cycles-pp.folio_end_writeback
>       1.18 �  2%      -0.8        0.40 � 22%  perf-profile.children.cycles-pp.copy_extent_buffer_full
>       1.19 �  9%      -0.8        0.41 � 18%  perf-profile.children.cycles-pp.extent_write_cache_pages
>       1.18 �  2%      -0.8        0.40 � 22%  perf-profile.children.cycles-pp.copy_page
>       1.30 �  7%      -0.8        0.54 � 25%  perf-profile.children.cycles-pp.write
>       1.20 �  6%      -0.7        0.49 � 25%  perf-profile.children.cycles-pp.btrfs_file_write_iter
>       1.11 � 10%      -0.7        0.40 � 22%  perf-profile.children.cycles-pp.read_block_for_search
>       1.19 �  6%      -0.7        0.49 � 25%  perf-profile.children.cycles-pp.btrfs_buffered_write
>       1.09 � 11%      -0.7        0.39 � 24%  perf-profile.children.cycles-pp.folio_wake_bit
>       1.01 � 10%      -0.7        0.34 � 22%  perf-profile.children.cycles-pp.__extent_writepage
>       1.04 � 11%      -0.7        0.38 � 24%  perf-profile.children.cycles-pp.wake_page_function
>       2.15 �  3%      -0.6        1.50 �  6%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
>       1.00 �  6%      -0.6        0.36 � 25%  perf-profile.children.cycles-pp.btrfs_add_link
>       1.15 �  7%      -0.6        0.52 � 18%  perf-profile.children.cycles-pp.__unwind_start
>       0.96 �  6%      -0.6        0.33 � 19%  perf-profile.children.cycles-pp.find_extent_buffer
>       0.96 �  6%      -0.6        0.34 � 24%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
>       1.12 � 11%      -0.6        0.50 � 22%  perf-profile.children.cycles-pp.end_bio_extent_writepage
>       1.26 �  2%      -0.6        0.68 � 17%  perf-profile.children.cycles-pp.__orc_find
>       0.79 � 11%      -0.6        0.23 � 22%  perf-profile.children.cycles-pp.writepage_delalloc
>       0.80 �  8%      -0.5        0.26 � 26%  perf-profile.children.cycles-pp.insert_with_overflow
>       0.73 �  7%      -0.5        0.20 � 24%  perf-profile.children.cycles-pp.btrfs_reserve_extent
>       0.66 � 12%      -0.5        0.15 � 33%  perf-profile.children.cycles-pp.end_bio_extent_buffer_writepage
>       0.69 � 11%      -0.5        0.19 � 25%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
>       1.93 �  2%      -0.5        1.43 �  6%  perf-profile.children.cycles-pp.log_csums
>       0.68 � 10%      -0.5        0.18 � 25%  perf-profile.children.cycles-pp.cow_file_range
>       0.77 �  6%      -0.5        0.28 � 20%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
>       0.67 �  7%      -0.5        0.18 � 24%  perf-profile.children.cycles-pp.find_free_extent
>       1.02 �  5%      -0.5        0.55 � 18%  perf-profile.children.cycles-pp.orc_find
>       0.56 �  8%      -0.4        0.12 �119%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
>       0.66 �  6%      -0.4        0.23 � 37%  perf-profile.children.cycles-pp.setup_items_for_insert
>       0.71 � 11%      -0.4        0.28 � 20%  perf-profile.children.cycles-pp.insert_reserved_file_extent
>       0.70 �  8%      -0.4        0.28 � 23%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.66 �  5%      -0.4        0.26 � 21%  perf-profile.children.cycles-pp.generic_bin_search
>       0.67 �  6%      -0.4        0.26 � 21%  perf-profile.children.cycles-pp.btrfs_lookup_match_dir
>       0.79 �  3%      -0.4        0.39 � 25%  perf-profile.children.cycles-pp.perf_callchain_user
>       0.62 �  7%      -0.4        0.23 � 24%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
>       0.66 �  9%      -0.4        0.26 � 23%  perf-profile.children.cycles-pp.autoremove_wake_function
>       0.62 �  4%      -0.4        0.22 � 20%  perf-profile.children.cycles-pp.write_one_eb
>       0.42 � 18%      -0.4        0.03 �103%  perf-profile.children.cycles-pp.__irqentry_text_start
>       0.58 �  5%      -0.4        0.19 � 28%  perf-profile.children.cycles-pp.check_setget_bounds
>       0.75 �  4%      -0.4        0.37 � 25%  perf-profile.children.cycles-pp.__get_user_nocheck_8
>       1.12 �  6%      -0.4        0.76 � 20%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
>       0.66 �  4%      -0.3        0.31 � 18%  perf-profile.children.cycles-pp.btrfs_update_root
>       0.63 �  8%      -0.3        0.28 � 21%  perf-profile.children.cycles-pp.perf_output_sample
>       0.89 �  6%      -0.3        0.55 � 23%  perf-profile.children.cycles-pp.btrfs_new_inode
>       0.78 �  5%      -0.3        0.44 � 35%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
>       0.55 �  6%      -0.3        0.21 � 22%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
>       0.80 �  8%      -0.3        0.48 � 21%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.51 �  6%      -0.3        0.20 � 27%  perf-profile.children.cycles-pp.folio_mark_dirty
>       0.49 �  6%      -0.3        0.18 � 26%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
>       1.40 �  3%      -0.3        1.09 �  3%  perf-profile.children.cycles-pp.btrfs_lookup_csum
>       0.61 �  8%      -0.3        0.31 � 16%  perf-profile.children.cycles-pp.unwind_get_return_address
>       0.47 � 10%      -0.3        0.16 � 23%  perf-profile.children.cycles-pp.btrfs_get_64
>       0.48 �  7%      -0.3        0.18 � 25%  perf-profile.children.cycles-pp.filemap_dirty_folio
>       0.69 �  3%      -0.3        0.39 � 18%  perf-profile.children.cycles-pp.asm_exc_page_fault
>       0.42 �  9%      -0.3        0.12 � 25%  perf-profile.children.cycles-pp.down_read
>       0.47 � 10%      -0.3        0.18 � 25%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
>       0.48 �  5%      -0.3        0.19 � 24%  perf-profile.children.cycles-pp.btrfs_mark_buffer_dirty
>       0.46 � 12%      -0.3        0.18 � 23%  perf-profile.children.cycles-pp.csum_tree_block
>       0.53 �  6%      -0.3        0.25 � 20%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.45 �  5%      -0.3        0.18 � 27%  perf-profile.children.cycles-pp.btrfs_start_ordered_extent
>       0.56 �  8%      -0.3        0.29 � 19%  perf-profile.children.cycles-pp.__kernel_text_address
>       0.44 �  5%      -0.3        0.18 � 24%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
>       0.46 � 22%      -0.3        0.20 � 27%  perf-profile.children.cycles-pp.pagecache_get_page
>       0.54 �  5%      -0.3        0.28 � 26%  perf-profile.children.cycles-pp.btrfs_release_path
>       0.45 � 23%      -0.3        0.19 � 27%  perf-profile.children.cycles-pp.__filemap_get_folio
>       0.42 � 21%      -0.3        0.16 � 16%  perf-profile.children.cycles-pp.alloc_extent_buffer
>       0.43 � 13%      -0.3        0.18 � 22%  perf-profile.children.cycles-pp.btrfs_drop_extents
>       0.44 �  5%      -0.3        0.19 � 27%  perf-profile.children.cycles-pp.queue_work_on
>       0.44 �  5%      -0.2        0.19 � 27%  perf-profile.children.cycles-pp.__queue_work
>       0.42 �  7%      -0.2        0.18 � 21%  perf-profile.children.cycles-pp.perf_output_copy
>       0.42 �  8%      -0.2        0.18 � 27%  perf-profile.children.cycles-pp.end_extent_writepage
>       0.49 �  9%      -0.2        0.26 � 18%  perf-profile.children.cycles-pp.kernel_text_address
>       0.42 �  8%      -0.2        0.18 � 27%  perf-profile.children.cycles-pp.btrfs_mark_ordered_io_finished
>       0.38 � 11%      -0.2        0.15 � 23%  perf-profile.children.cycles-pp.__radix_tree_lookup
>       0.91 �  8%      -0.2        0.68 � 20%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>       0.41 �  9%      -0.2        0.18 � 21%  perf-profile.children.cycles-pp.memcpy_erms
>       0.34 � 13%      -0.2        0.11 � 24%  perf-profile.children.cycles-pp.__folio_end_writeback
>       0.42 � 10%      -0.2        0.19 �  7%  perf-profile.children.cycles-pp.split_leaf
>       0.32 � 10%      -0.2        0.10 � 13%  perf-profile.children.cycles-pp.btrfs_free_tree_block
>       0.32 �  7%      -0.2        0.11 � 37%  perf-profile.children.cycles-pp.btrfs_dirty_pages
>       0.34 �  6%      -0.2        0.14 � 28%  perf-profile.children.cycles-pp.btrfs_lookup
>       0.50 �  6%      -0.2        0.29 � 19%  perf-profile.children.cycles-pp.write_all_supers
>       0.34 �  6%      -0.2        0.14 � 28%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
>       0.37 � 11%      -0.2        0.17 � 27%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
>       0.31 �  7%      -0.2        0.12 � 21%  perf-profile.children.cycles-pp.btrfs_check_ref_name_override
>       0.35 �  9%      -0.2        0.16 � 29%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.36 � 11%      -0.2        0.16 � 28%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       0.36 � 11%      -0.2        0.16 � 26%  perf-profile.children.cycles-pp.copyin
>       0.36 � 11%      -0.2        0.18 � 18%  perf-profile.children.cycles-pp.btrfs_map_bio
>       0.22 � 13%      -0.2        0.04 �106%  perf-profile.children.cycles-pp.check_dir_item
>       0.41 �  9%      -0.2        0.23 � 40%  perf-profile.children.cycles-pp.__libc_write
>       0.30 � 17%      -0.2        0.12 � 29%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
>       0.22 �  7%      -0.2        0.04 �100%  perf-profile.children.cycles-pp.btrfs_lookup_csums_range
>       0.41 �  9%      -0.2        0.23 � 40%  perf-profile.children.cycles-pp.generic_file_write_iter
>       0.41 �  9%      -0.2        0.23 � 40%  perf-profile.children.cycles-pp.__generic_file_write_iter
>       0.41 �  9%      -0.2        0.23 � 40%  perf-profile.children.cycles-pp.generic_perform_write
>       0.33 �  9%      -0.2        0.16 � 30%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.32 � 10%      -0.2        0.15 � 17%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.31 � 11%      -0.2        0.14 � 24%  perf-profile.children.cycles-pp.btrfs_submit_data_bio
>       0.29 �  7%      -0.2        0.12 � 32%  perf-profile.children.cycles-pp.prepare_pages
>       0.28 � 10%      -0.2        0.10 � 23%  perf-profile.children.cycles-pp.__folio_mark_dirty
>       0.38 � 12%      -0.2        0.21 � 20%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
>       0.25 �  5%      -0.2        0.08 � 23%  perf-profile.children.cycles-pp.__folio_start_writeback
>       0.26 � 12%      -0.2        0.09 � 30%  perf-profile.children.cycles-pp.check_extent_data_item
>       0.30 �  6%      -0.2        0.14 � 31%  perf-profile.children.cycles-pp.btrfs_update_inode
>       0.22 � 21%      -0.2        0.06 � 16%  perf-profile.children.cycles-pp.memmove
>       0.32 � 18%      -0.2        0.16 � 18%  perf-profile.children.cycles-pp.__module_address
>       0.25 �  7%      -0.2        0.10 � 15%  perf-profile.children.cycles-pp.pin_down_extent
>       0.22 � 16%      -0.2        0.07 � 12%  perf-profile.children.cycles-pp.__reserve_bytes
>       0.22 �  8%      -0.2        0.07 � 58%  perf-profile.children.cycles-pp.btrfs_set_token_32
>       0.30 �  7%      -0.1        0.16 � 24%  perf-profile.children.cycles-pp.btrfs_search_forward
>       0.26 �  6%      -0.1        0.12 � 32%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
>       0.22 � 18%      -0.1        0.08 � 14%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
>       0.29 � 11%      -0.1        0.14 � 25%  perf-profile.children.cycles-pp.submit_bio_noacct
>       0.20 � 12%      -0.1        0.06 � 26%  perf-profile.children.cycles-pp.push_leaf_right
>       0.20 � 31%      -0.1        0.06 � 49%  perf-profile.children.cycles-pp.filemap_add_folio
>       0.26 � 11%      -0.1        0.12 � 28%  perf-profile.children.cycles-pp.enqueue_entity
>       0.18 � 23%      -0.1        0.04 � 71%  perf-profile.children.cycles-pp.mark_extent_buffer_accessed
>       0.23 � 13%      -0.1        0.09 � 26%  perf-profile.children.cycles-pp.btrfs_end_super_write
>       0.28 � 10%      -0.1        0.14 � 25%  perf-profile.children.cycles-pp.blk_mq_submit_bio
>       0.19 � 12%      -0.1        0.05 � 51%  perf-profile.children.cycles-pp.memcpy_extent_buffer
>       0.17 � 12%      -0.1        0.04 �101%  perf-profile.children.cycles-pp.btrfs_get_token_32
>       0.19 � 30%      -0.1        0.05 � 49%  perf-profile.children.cycles-pp.__filemap_add_folio
>       0.19 � 14%      -0.1        0.06 � 51%  perf-profile.children.cycles-pp.btrfs_root_node
>       0.29 � 13%      -0.1        0.16 � 33%  perf-profile.children.cycles-pp.finish_task_switch
>       0.24 � 14%      -0.1        0.11 � 22%  perf-profile.children.cycles-pp.btrfs_write_check
>       0.22 �  5%      -0.1        0.10 � 15%  perf-profile.children.cycles-pp.stack_access_ok
>       0.21 �  7%      -0.1        0.09 � 24%  perf-profile.children.cycles-pp.start_transaction
>       0.17 �  2%      -0.1        0.05 � 73%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
>       0.16 � 27%      -0.1        0.04 �101%  perf-profile.children.cycles-pp.btrfs_lookup_inode
>       0.16 � 20%      -0.1        0.03 �103%  perf-profile.children.cycles-pp.block_group_cache_tree_search
>       0.20 � 16%      -0.1        0.08 � 21%  perf-profile.children.cycles-pp.xas_load
>       0.30 � 12%      -0.1        0.17 � 22%  perf-profile.children.cycles-pp.find_next_csum_offset
>       0.22 � 12%      -0.1        0.10 � 21%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
>       0.22 � 14%      -0.1        0.10 � 21%  perf-profile.children.cycles-pp.file_remove_privs
>       0.19 � 10%      -0.1        0.07 � 28%  perf-profile.children.cycles-pp.btrfs_copy_from_user
>       0.24 �  9%      -0.1        0.12 � 33%  perf-profile.children.cycles-pp.__poll
>       0.24 �  9%      -0.1        0.12 � 33%  perf-profile.children.cycles-pp.__x64_sys_poll
>       0.24 �  9%      -0.1        0.12 � 33%  perf-profile.children.cycles-pp.do_sys_poll
>       0.20 � 11%      -0.1        0.09 � 32%  perf-profile.children.cycles-pp.free_extent_buffer
>       0.21 � 13%      -0.1        0.09 � 21%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
>       0.14 � 11%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.find_get_pages_range_tag
>       0.24 � 20%      -0.1        0.13 � 18%  perf-profile.children.cycles-pp.is_module_text_address
>       0.21 � 13%      -0.1        0.10 � 22%  perf-profile.children.cycles-pp.security_inode_need_killpriv
>       0.15 � 19%      -0.1        0.03 � 70%  perf-profile.children.cycles-pp.__push_leaf_right
>       0.18 �  5%      -0.1        0.07 � 46%  perf-profile.children.cycles-pp.down_write
>       0.14 � 17%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.read_tree_block
>       0.20 � 13%      -0.1        0.09 � 20%  perf-profile.children.cycles-pp.__vfs_getxattr
>       0.20 � 10%      -0.1        0.09 � 14%  perf-profile.children.cycles-pp.submit_extent_page
>       0.15 � 12%      -0.1        0.04 � 72%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
>       0.16 � 12%      -0.1        0.04 � 75%  perf-profile.children.cycles-pp.nvme_queue_rq
>       0.14 � 19%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.btrfs_read_node_slot
>       0.22 � 21%      -0.1        0.11 � 15%  perf-profile.children.cycles-pp.__module_text_address
>       0.16 � 13%      -0.1        0.05 � 74%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
>       0.16 � 13%      -0.1        0.05 � 74%  perf-profile.children.cycles-pp.blk_flush_plug
>       0.16 � 12%      -0.1        0.06 � 51%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
>       0.23 �  8%      -0.1        0.12 � 44%  perf-profile.children.cycles-pp.btrfs_free_path
>       0.17 � 17%      -0.1        0.07 � 53%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>       0.23 �  9%      -0.1        0.13 � 27%  perf-profile.children.cycles-pp.update_load_avg
>       0.20 � 13%      -0.1        0.10 � 26%  perf-profile.children.cycles-pp.__extent_writepage_io
>       0.21 �  7%      -0.1        0.10 � 19%  perf-profile.children.cycles-pp.mkdir
>       0.15 � 13%      -0.1        0.05 � 75%  perf-profile.children.cycles-pp.blk_mq_request_issue_directly
>       0.13 �  7%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.inode_tree_add
>       0.17 �  4%      -0.1        0.07 � 17%  perf-profile.children.cycles-pp.__might_resched
>       0.18 � 13%      -0.1        0.08 � 21%  perf-profile.children.cycles-pp.btrfs_getxattr
>       0.14 �  9%      -0.1        0.04 � 71%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
>       0.14 � 15%      -0.1        0.04 � 72%  perf-profile.children.cycles-pp.alloc_extent_state
>       0.16 � 10%      -0.1        0.07 � 25%  perf-profile.children.cycles-pp.blk_finish_plug
>       0.12 � 10%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.__crc32c_pcl_intel_finup
>       0.12 � 27%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
>       0.15 � 13%      -0.1        0.06 � 46%  perf-profile.children.cycles-pp.__perf_event_header__init_id
>       0.19 �  6%      -0.1        0.10 � 19%  perf-profile.children.cycles-pp.__x64_sys_mkdir
>       0.13 � 17%      -0.1        0.04 � 75%  perf-profile.children.cycles-pp.find_free_extent_clustered
>       0.16 �  3%      -0.1        0.08 � 17%  perf-profile.children.cycles-pp.insert_state
>       0.12 �  9%      -0.1        0.03 �103%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
>       0.18 � 14%      -0.1        0.09 � 11%  perf-profile.children.cycles-pp.__close
>       0.11 � 31%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.__raw_callee_save___native_queued_spin_unlock
>       0.12 �  8%      -0.1        0.03 �105%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
>       0.19 �  8%      -0.1        0.10 � 21%  perf-profile.children.cycles-pp.mutex_lock
>       0.18 �  7%      -0.1        0.10 � 19%  perf-profile.children.cycles-pp.release_extent_buffer
>       0.15 � 13%      -0.1        0.07 � 20%  perf-profile.children.cycles-pp.___slab_alloc
>       0.14 � 17%      -0.1        0.06 � 16%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.15 � 14%      -0.1        0.07 � 23%  perf-profile.children.cycles-pp.__slab_alloc
>       0.15 � 14%      -0.1        0.07 � 18%  perf-profile.children.cycles-pp.btrfs_lookup_xattr
>       0.11 �  5%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.14 �  4%      -0.1        0.06 � 25%  perf-profile.children.cycles-pp.set_next_entity
>       0.13 �  7%      -0.1        0.05 � 47%  perf-profile.children.cycles-pp.memzero_extent_buffer
>       0.11 � 15%      -0.1        0.03 �102%  perf-profile.children.cycles-pp.get_page_from_freelist
>       0.16 �  8%      -0.1        0.08 � 17%  perf-profile.children.cycles-pp.do_mkdirat
>       0.16 � 10%      -0.1        0.09 �  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.12 � 23%      -0.1        0.04 � 72%  perf-profile.children.cycles-pp.btrfs_alloc_from_cluster
>       0.19 �  7%      -0.1        0.11 � 30%  perf-profile.children.cycles-pp.__etree_search
>       0.12 � 12%      -0.1        0.04 �101%  perf-profile.children.cycles-pp.new_inode
>       0.13 � 18%      -0.1        0.06 � 18%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       0.14 � 10%      -0.1        0.07 � 26%  perf-profile.children.cycles-pp.kmem_cache_free
>       0.14 � 19%      -0.1        0.06 � 23%  perf-profile.children.cycles-pp.__alloc_pages
>       0.15 � 10%      -0.1        0.08 � 12%  perf-profile.children.cycles-pp.filename_create
>       0.10 � 11%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.dput
>       0.26 �  9%      -0.1        0.19 � 11%  perf-profile.children.cycles-pp.exc_page_fault
>       0.10 �  7%      -0.1        0.02 � 99%  perf-profile.children.cycles-pp.mutex_unlock
>       0.10 �  8%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.allocate_slab
>       0.11 � 15%      -0.1        0.04 � 73%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
>       0.15 �  9%      -0.1        0.08 � 39%  perf-profile.children.cycles-pp.perf_poll
>       0.10 � 10%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.btrfs_alloc_reserved_file_extent
>       0.15 � 11%      -0.1        0.08 �  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.10 �  8%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.__cond_resched
>       0.12 � 11%      -0.1        0.05 � 45%  perf-profile.children.cycles-pp.__vsprintf_chk
>       0.20 � 13%      -0.1        0.13 � 16%  perf-profile.children.cycles-pp.unlock_up
>       0.14 � 14%      -0.1        0.07 � 21%  perf-profile.children.cycles-pp.write_dev_supers
>       0.12 �  9%      -0.1        0.05 � 47%  perf-profile.children.cycles-pp.filename_parentat
>       0.10 � 10%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
>       0.10 � 12%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.shmem_getpage_gfp
>       0.10 � 12%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.shmem_write_begin
>       0.11 � 15%      -0.1        0.05 � 76%  perf-profile.children.cycles-pp.new_inode_pseudo
>       0.11 �  9%      -0.1        0.05 � 47%  perf-profile.children.cycles-pp.path_parentat
>       0.10 � 17%      -0.1        0.04 � 71%  perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.09 � 13%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.clear_state_bit
>       0.23 �  5%      -0.1        0.17 � 14%  perf-profile.children.cycles-pp.btrfs_log_all_xattrs
>       0.10 � 13%      -0.1        0.05 � 75%  perf-profile.children.cycles-pp.alloc_inode
>       0.08 � 17%      -0.1        0.02 � 99%  perf-profile.children.cycles-pp.vfprintf
>       0.09 � 15%      -0.1        0.04 � 75%  perf-profile.children.cycles-pp.up_write
>       0.12 � 14%      -0.1        0.06 �  7%  perf-profile.children.cycles-pp.task_work_run
>       0.10 � 11%      -0.0        0.06 � 13%  perf-profile.children.cycles-pp.__fput
>       0.08 � 13%      -0.0        0.04 � 71%  perf-profile.children.cycles-pp.do_open
>       0.11 � 22%      -0.0        0.07 � 11%  perf-profile.children.cycles-pp.push_leaf_left
>       0.14 � 10%      -0.0        0.11 � 10%  perf-profile.children.cycles-pp.link_path_walk
>       0.18 �  9%      +0.1        0.24 �  9%  perf-profile.children.cycles-pp.task_tick_fair
>       0.95 � 14%      +0.3        1.24 � 12%  perf-profile.children.cycles-pp.scheduler_tick
>       0.62 �  6%      +0.4        1.02 � 16%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       6.31 �  4%      +1.1        7.38 �  3%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
>       6.84 �  3%      +1.3        8.16 �  5%  perf-profile.children.cycles-pp.btrfs_log_inode
>       0.95 � 11%      +1.4        2.30 � 18%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
>       0.50 �  6%      +1.6        2.11 � 20%  perf-profile.children.cycles-pp.set_extent_bit
>       0.21 �  9%      +2.1        2.28 � 10%  perf-profile.children.cycles-pp.__clear_extent_bit
>       0.16 �  5%      +2.1        2.26 � 11%  perf-profile.children.cycles-pp.clear_extent_bit
>       3.14 �  3%      +2.2        5.30 �  9%  perf-profile.children.cycles-pp.btrfs_cow_block
>       3.12 �  3%      +2.2        5.29 �  9%  perf-profile.children.cycles-pp.__btrfs_cow_block
>       0.00            +2.3        2.32 � 10%  perf-profile.children.cycles-pp.delete_tree_block
>       3.43 �  3%      +2.5        5.93 � 13%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>       2.89 �  3%      +2.8        5.72 �  7%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
>       2.89 �  3%      +2.8        5.72 �  7%  perf-profile.children.cycles-pp.truncate_inode_items
>       2.35 �  4%      +3.3        5.64 � 17%  perf-profile.children.cycles-pp.osq_lock
>       1.58 �  6%      +3.3        4.90 � 11%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.30 � 16%      +3.9        4.20 � 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.68 �  6%      +4.6        5.31 � 14%  perf-profile.children.cycles-pp.btrfs_wait_tree_log_extents
>       0.68 �  6%      +4.6        5.31 � 14%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
>      12.75 �  3%      +5.5       18.25 �  9%  perf-profile.children.cycles-pp.btrfs_sync_log
>      32.39 �  3%      +5.6       38.03 �  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      32.38 �  3%      +5.6       38.02 �  5%  perf-profile.children.cycles-pp.do_syscall_64
>       5.70 �  3%      +5.7       11.38 � 15%  perf-profile.children.cycles-pp.__mutex_lock
>       8.80 �  3%      +6.2       15.01 �  8%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
>       8.79 �  3%      +6.2       15.00 �  8%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
>       0.12 � 32%      +8.2        8.32 � 16%  perf-profile.children.cycles-pp.rb_next
>      26.42 �  3%      +8.4       34.83 �  7%  perf-profile.children.cycles-pp.fsync
>      26.30 �  3%      +8.5       34.76 �  7%  perf-profile.children.cycles-pp.btrfs_sync_file
>      26.30 �  3%      +8.5       34.77 �  7%  perf-profile.children.cycles-pp.__x64_sys_fsync
>      26.30 �  3%      +8.5       34.77 �  7%  perf-profile.children.cycles-pp.do_fsync
>       0.09 � 10%     +10.3       10.39 � 14%  perf-profile.children.cycles-pp.find_first_extent_bit
>       0.02 �142%     +10.4       10.38 � 14%  perf-profile.children.cycles-pp.find_first_extent_bit_state
>       4.06 �  5%      -3.3        0.78 � 41%  perf-profile.self.cycles-pp.poll_idle
>       1.64 �  5%      -1.1        0.52 � 22%  perf-profile.self.cycles-pp.read_extent_buffer
>       1.32 �  2%      -0.9        0.45 � 32%  perf-profile.self.cycles-pp.btrfs_get_32
>       1.15 �  3%      -0.8        0.39 � 22%  perf-profile.self.cycles-pp.copy_page
>       1.36 �  4%      -0.6        0.71 � 18%  perf-profile.self.cycles-pp._raw_spin_lock
>       1.26 �  2%      -0.6        0.68 � 17%  perf-profile.self.cycles-pp.__orc_find
>       1.00 �  9%      -0.5        0.47 � 23%  perf-profile.self.cycles-pp.unwind_next_frame
>       0.63 �  5%      -0.4        0.22 � 25%  perf-profile.self.cycles-pp.check_leaf
>       0.58 �  8%      -0.4        0.21 � 23%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
>       0.52 �  4%      -0.3        0.17 � 28%  perf-profile.self.cycles-pp.check_setget_bounds
>       0.40 �  9%      -0.3        0.14 � 19%  perf-profile.self.cycles-pp.find_extent_buffer_nolock
>       0.68 �  9%      -0.3        0.43 � 23%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.35 � 10%      -0.2        0.10 � 27%  perf-profile.self.cycles-pp.down_read
>       0.42 �  6%      -0.2        0.20 � 27%  perf-profile.self.cycles-pp.__get_user_nocheck_8
>       0.40 �  9%      -0.2        0.17 � 24%  perf-profile.self.cycles-pp.memcpy_erms
>       0.37 � 11%      -0.2        0.15 � 23%  perf-profile.self.cycles-pp.__radix_tree_lookup
>       0.34 �  6%      -0.2        0.13 � 26%  perf-profile.self.cycles-pp.btrfs_get_64
>       0.35 � 11%      -0.2        0.16 � 28%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>       0.29 �  8%      -0.2        0.12 � 22%  perf-profile.self.cycles-pp.generic_bin_search
>       0.28 �  8%      -0.2        0.11 � 18%  perf-profile.self.cycles-pp.__schedule
>       0.35 �  9%      -0.2        0.19 � 16%  perf-profile.self.cycles-pp.orc_find
>       0.31 � 19%      -0.2        0.16 � 17%  perf-profile.self.cycles-pp.__module_address
>       0.21 � 11%      -0.2        0.06 � 18%  perf-profile.self.cycles-pp.memmove
>       0.25 �  8%      -0.1        0.11 � 29%  perf-profile.self.cycles-pp.btrfs_search_slot
>       0.16 �  6%      -0.1        0.04 �101%  perf-profile.self.cycles-pp.__btrfs_cow_block
>       0.16 � 15%      -0.1        0.04 � 77%  perf-profile.self.cycles-pp.btrfs_set_token_32
>       0.21 �  4%      -0.1        0.09 � 16%  perf-profile.self.cycles-pp.stack_access_ok
>       0.18 �  7%      -0.1        0.06 � 52%  perf-profile.self.cycles-pp.btrfs_root_node
>       0.14 �  9%      -0.1        0.03 �101%  perf-profile.self.cycles-pp.btrfs_get_token_32
>       0.21 �  5%      -0.1        0.11 � 20%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.20 �  8%      -0.1        0.10 � 23%  perf-profile.self.cycles-pp.perf_callchain_kernel
>       0.17 �  5%      -0.1        0.07 � 18%  perf-profile.self.cycles-pp.__might_resched
>       0.16 � 17%      -0.1        0.07 � 21%  perf-profile.self.cycles-pp.xas_load
>       0.14 �  8%      -0.1        0.06 � 46%  perf-profile.self.cycles-pp.down_write
>       0.14 �  5%      -0.1        0.05 � 45%  perf-profile.self.cycles-pp.perf_output_copy
>       0.12 �  6%      -0.1        0.04 �101%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.12 �  8%      -0.1        0.04 � 72%  perf-profile.self.cycles-pp.memzero_extent_buffer
>       0.10 �  7%      -0.1        0.03 �100%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.10 �  7%      -0.1        0.02 � 99%  perf-profile.self.cycles-pp.inode_tree_add
>       0.10 � 13%      -0.1        0.03 �100%  perf-profile.self.cycles-pp.kernel_text_address
>       0.17 �  8%      -0.1        0.10 � 27%  perf-profile.self.cycles-pp.__etree_search
>       0.14 �  6%      -0.1        0.08 � 24%  perf-profile.self.cycles-pp.mutex_lock
>       0.09 � 15%      -0.1        0.03 �103%  perf-profile.self.cycles-pp.up_write
>       0.08 � 13%      -0.1        0.03 �100%  perf-profile.self.cycles-pp.free_extent_buffer
>       0.07 � 15%      -0.0        0.04 � 72%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.06 � 32%      +0.0        0.11 � 39%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
>       0.14 � 18%      +0.1        0.20 � 15%  perf-profile.self.cycles-pp.irqtime_account_irq
>       0.58 �  7%      +0.4        0.99 � 16%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       0.00            +2.1        2.09 � 12%  perf-profile.self.cycles-pp.find_first_extent_bit_state
>       3.38 �  3%      +2.5        5.86 � 13%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>       2.31 �  4%      +3.3        5.59 � 17%  perf-profile.self.cycles-pp.osq_lock
>       0.30 � 15%      +3.8        4.08 � 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.11 � 32%      +7.9        8.04 � 16%  perf-profile.self.cycles-pp.rb_next
> 
> 
> ***************************************************************************************************
> lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
>   gcc-9/performance/1SSD/9B/btrfs/8/x86_64-rhel-8.3/16d/256fpd/4/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap4/16G/fsmark/0x5003006
> 
> commit: 
>   dd503c2d5d ("btrfs: remove write and wait of struct walk_control")
>   1a61b300c0 ("btrfs: fix log tree cleanup after a transaction abort")
> 
> dd503c2d5db4f864 1a61b300c09b1d034534372349e 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    2244545           +22.9%    2758277        fsmark.app_overhead
>      13249 �  2%     -79.6%       2697        fsmark.files_per_sec
>     336.80 �  2%    +368.8%       1578        fsmark.time.elapsed_time
>     336.80 �  2%    +368.8%       1578        fsmark.time.elapsed_time.max
>   2.97e+08 �  2%      +3.5%  3.073e+08        fsmark.time.file_system_outputs
>       1518 � 14%    +276.6%       5717 �  2%  fsmark.time.involuntary_context_switches
>     150.83           +58.9%     239.67        fsmark.time.percent_of_cpu_this_job_got
>     495.22 �  4%    +661.6%       3771        fsmark.time.system_time
>   10447820           -10.8%    9322318        fsmark.time.voluntary_context_switches
>   6.28e+10 �  2%    +365.7%  2.924e+11        cpuidle..time
>  1.269e+08 � 20%    +302.3%  5.104e+08 � 20%  cpuidle..usage
>   57547330 � 22%    +335.0%  2.504e+08 � 25%  turbostat.IRQ
>      84.94 �  2%    -100.0%       0.00        turbostat.PkgWatt
>     386.64 �  2%    +321.7%       1630        uptime.boot
>      71228 �  2%    +324.3%     302205        uptime.idle
>       0.15 �  4%      -0.1        0.02 �  3%  mpstat.cpu.all.iowait%
>       0.82 �  5%      +0.5        1.27        mpstat.cpu.all.sys%
>       0.04            -0.0        0.02 �  4%  mpstat.cpu.all.usr%
>     106253 � 69%   +1076.7%    1250289 � 52%  numa-numastat.node1.local_node
>     190300 � 39%    +602.7%    1337292 � 49%  numa-numastat.node1.numa_hit
>     216240 � 82%    +747.8%    1833203 �136%  numa-numastat.node3.local_node
>     294059 � 53%    +547.5%    1903933 �129%  numa-numastat.node3.numa_hit
>     411999           -77.6%      92286        vmstat.io.bo
>   26486798           -28.0%   19073084        vmstat.memory.cache
>       1.00          +100.0%       2.00        vmstat.procs.r
>      67089 �  2%     -78.0%      14778        vmstat.system.cs
>       9672 �  7%     -15.3%       8190 � 13%  numa-meminfo.node0.KernelStack
>       7037 �  5%     -11.6%       6221 �  7%  numa-meminfo.node1.KernelStack
>       2525 �152%     -98.5%      38.17 � 15%  numa-meminfo.node2.Mapped
>       8280 � 32%   +9252.2%     774412 �219%  numa-meminfo.node3.Active
>       7168 �  8%    +106.4%      14799 � 35%  numa-meminfo.node3.Active(anon)
>      18538 � 46%   +2914.9%     558907 �209%  numa-meminfo.node3.KReclaimable
>      18538 � 46%   +2914.9%     558907 �209%  numa-meminfo.node3.SReclaimable
>       9679 �  8%     -15.4%       8187 � 13%  numa-vmstat.node0.nr_kernel_stack
>       7039 �  5%     -11.6%       6222 �  7%  numa-vmstat.node1.nr_kernel_stack
>       1796 �  8%    +106.0%       3700 � 35%  numa-vmstat.node3.nr_active_anon
>       4640 � 46%   +2912.0%     139768 �209%  numa-vmstat.node3.nr_slab_reclaimable
>       1796 �  8%    +106.0%       3700 � 35%  numa-vmstat.node3.nr_zone_active_anon
>     534483 � 15%    +223.9%    1731211 �107%  numa-vmstat.node3.numa_hit
>     430615 � 22%    +280.3%    1637437 �116%  numa-vmstat.node3.numa_local
>   11415411 �  2%     -60.8%    4476212 �  3%  meminfo.Active
>      12176 �  3%    +123.3%      27193 �  2%  meminfo.Active(anon)
>   11403234 �  2%     -61.0%    4449019 �  3%  meminfo.Active(file)
>   23361738           -32.3%   15805338        meminfo.Cached
>     272329           -14.2%     233545        meminfo.Dirty
>      30627           -11.2%      27204        meminfo.KernelStack
>   29731200           -26.5%   21846541        meminfo.Memused
>      37689 �  2%     +26.7%      47741        meminfo.Shmem
>   30540485           -27.9%   22026958        meminfo.max_used_kB
>       3038 �  3%    +123.7%       6797 �  2%  proc-vmstat.nr_active_anon
>    2850306 �  2%     -61.0%    1112326 �  3%  proc-vmstat.nr_active_file
>      79182            -3.2%      76623        proc-vmstat.nr_anon_pages
>   37250006 �  2%      +3.7%   38642606        proc-vmstat.nr_dirtied
>      68085           -14.2%      58414        proc-vmstat.nr_dirty
>    5839686           -32.3%    3951870        proc-vmstat.nr_file_pages
>   41996583            +4.7%   43966332        proc-vmstat.nr_free_pages
>      85461            -4.5%      81650        proc-vmstat.nr_inactive_anon
>    2338534            -6.5%    2186147        proc-vmstat.nr_inactive_file
>      30634           -11.2%      27203        proc-vmstat.nr_kernel_stack
>      10032            -7.9%       9243        proc-vmstat.nr_mapped
>       1062            -6.9%     989.17        proc-vmstat.nr_page_table_pages
>       9335           +27.8%      11928        proc-vmstat.nr_shmem
>     800757            +2.3%     819391        proc-vmstat.nr_slab_reclaimable
>     369020            -4.6%     352061        proc-vmstat.nr_slab_unreclaimable
>   37248723 �  2%      +3.7%   38639214        proc-vmstat.nr_written
>       3038 �  3%    +123.7%       6797 �  2%  proc-vmstat.nr_zone_active_anon
>    2850306 �  2%     -61.0%    1112326 �  3%  proc-vmstat.nr_zone_active_file
>      85461            -4.5%      81650        proc-vmstat.nr_zone_inactive_anon
>    2338534            -6.5%    2186147        proc-vmstat.nr_zone_inactive_file
>      68163           -14.2%      58457        proc-vmstat.nr_zone_write_pending
>   10406307            +5.5%   10978428        proc-vmstat.numa_hit
>   10147588            +5.6%   10719407        proc-vmstat.numa_local
>     318544 �  7%     +25.8%     400574 �  4%  proc-vmstat.numa_pte_updates
>    2820943 �  4%     -61.3%    1091827 �  8%  proc-vmstat.pgactivate
>   10418164            +6.0%   11038540        proc-vmstat.pgalloc_normal
>    1576108          +290.3%    6151439        proc-vmstat.pgfault
>  1.402e+08 �  2%      +4.1%   1.46e+08        proc-vmstat.pgpgout
>      86238          +305.7%     349864        proc-vmstat.pgreuse
>      18.60 � 50%    +137.4%      44.17 � 31%  perf-stat.i.MPKI
>  1.227e+09 �  2%     -13.9%  1.056e+09 �  3%  perf-stat.i.branch-instructions
>      12.58 � 46%      -9.6        2.96 �  7%  perf-stat.i.cache-miss-rate%
>   10514212 � 10%     -58.0%    4416388 � 36%  perf-stat.i.cache-misses
>      67622 �  2%     -78.1%      14779        perf-stat.i.context-switches
>       1.97 � 13%     +66.7%       3.28 � 12%  perf-stat.i.cpi
>     202.44            -4.1%     194.22        perf-stat.i.cpu-migrations
>       1259 �  6%    +227.7%       4126 � 35%  perf-stat.i.cycles-between-cache-misses
>   1.66e+09 �  2%     -30.5%  1.153e+09 �  3%  perf-stat.i.dTLB-loads
>  8.328e+08 �  2%     -54.2%  3.818e+08 �  5%  perf-stat.i.dTLB-stores
>    2445823 �  6%     -38.7%    1499909 �  9%  perf-stat.i.iTLB-load-misses
>  6.241e+09 �  2%     -30.4%  4.344e+09 �  4%  perf-stat.i.instructions
>       0.52 � 13%     -38.9%       0.32 � 12%  perf-stat.i.ipc
>       1.16 �  2%     -76.8%       0.27 � 13%  perf-stat.i.major-faults
>      19.38 �  2%     -27.4%      14.07        perf-stat.i.metric.M/sec
>       4223           -11.2%       3751        perf-stat.i.minor-faults
>      34.13 � 25%     +18.0       52.09 �  9%  perf-stat.i.node-load-miss-rate%
>    1032812 � 50%     -61.0%     403177 � 20%  perf-stat.i.node-load-misses
>    1813182 �  7%     -75.5%     443843 �  7%  perf-stat.i.node-loads
>     379204 � 57%     -63.8%     137132 � 13%  perf-stat.i.node-store-misses
>     842872 � 14%     -72.9%     228776 �  8%  perf-stat.i.node-stores
>       4224           -11.2%       3751        perf-stat.i.page-faults
>      18.27 � 49%    +133.0%      42.55 � 31%  perf-stat.overall.MPKI
>      11.65 � 43%      -9.3        2.36 �  8%  perf-stat.overall.cache-miss-rate%
>       1.94 � 13%     +65.0%       3.20 � 12%  perf-stat.overall.cpi
>       1149 �  7%    +203.0%       3483 � 28%  perf-stat.overall.cycles-between-cache-misses
>       0.53 � 13%     -39.5%       0.32 � 12%  perf-stat.overall.ipc
>  1.224e+09 �  2%     -13.7%  1.056e+09 �  3%  perf-stat.ps.branch-instructions
>   10484718 � 10%     -57.9%    4413301 � 36%  perf-stat.ps.cache-misses
>      67413 �  2%     -78.1%      14762        perf-stat.ps.context-switches
>     201.83            -3.8%     194.11        perf-stat.ps.cpu-migrations
>  1.655e+09 �  2%     -30.4%  1.152e+09 �  3%  perf-stat.ps.dTLB-loads
>  8.303e+08 �  2%     -54.1%  3.815e+08 �  5%  perf-stat.ps.dTLB-stores
>    2438383 �  6%     -38.5%    1498800 �  9%  perf-stat.ps.iTLB-load-misses
>  6.222e+09 �  2%     -30.2%  4.341e+09 �  4%  perf-stat.ps.instructions
>       1.16 �  2%     -76.7%       0.27 � 13%  perf-stat.ps.major-faults
>       4207           -10.9%       3748        perf-stat.ps.minor-faults
>    1029887 � 50%     -60.9%     402840 � 20%  perf-stat.ps.node-load-misses
>    1808344 �  7%     -75.5%     443539 �  7%  perf-stat.ps.node-loads
>     378187 � 57%     -63.8%     137029 � 13%  perf-stat.ps.node-store-misses
>     840484 � 14%     -72.8%     228574 �  8%  perf-stat.ps.node-stores
>       4208           -10.9%       3748        perf-stat.ps.page-faults
>  2.104e+12 �  4%    +226.3%  6.866e+12 �  4%  perf-stat.total.instructions
>      64.88 �  4%     -11.1       53.82 �  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      64.38 �  4%     -10.8       53.60 �  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      64.38 �  4%     -10.8       53.60 �  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      64.34 �  4%     -10.8       53.57 �  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      58.96 �  5%      -9.0       49.92 �  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      58.20 �  5%      -8.9       49.28 �  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       5.66 � 10%      -4.9        0.72 � 10%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents
>      39.59 �  9%      -4.7       34.85 �  8%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>       5.39 �  9%      -4.7        0.72 �  9%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       5.39 �  9%      -4.7        0.72 �  9%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
>       5.37 �  9%      -4.7        0.72 �  9%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
>       4.40 �  9%      -4.1        0.29 �100%  perf-profile.calltrace.cycles-pp.btrfs_submit_metadata_bio.submit_one_bio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
>       4.40 �  9%      -4.0        0.37 � 71%  perf-profile.calltrace.cycles-pp.submit_one_bio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.filemap_fdatawrite_range
>       4.61 � 11%      -3.9        0.66 � 12%  perf-profile.calltrace.cycles-pp.open64
>       4.59 � 11%      -3.9        0.66 � 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       4.59 � 10%      -3.9        0.66 � 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       4.58 � 10%      -3.9        0.66 � 11%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       4.57 � 10%      -3.9        0.66 � 11%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       4.50 � 10%      -3.9        0.65 � 11%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.49 � 10%      -3.8        0.65 � 11%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
>       3.40 � 10%      -3.1        0.26 �100%  perf-profile.calltrace.cycles-pp.btrfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
>       1.38 � 19%      -1.1        0.26 �100%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
>       1.38 � 19%      -1.1        0.26 �100%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
>       1.49 � 17%      -0.9        0.62 �  3%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
>       1.49 � 17%      -0.9        0.62 �  3%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.calltrace.cycles-pp.__libc_start_main
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
>       0.79 � 19%      +1.3        2.10 � 30%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items
>       3.29 �  7%      +1.6        4.86 � 19%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.wait_log_commit.btrfs_sync_log.btrfs_sync_file
>       0.00            +2.0        1.97 � 30%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block
>       0.00            +2.0        1.98 � 30%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block
>       0.00            +2.0        2.00 � 30%  perf-profile.calltrace.cycles-pp.set_extent_bit.btrfs_alloc_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot
>       5.49 �  9%      +3.0        8.47 �  7%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       5.48 �  9%      +3.0        8.51 �  6%  perf-profile.calltrace.cycles-pp.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.00            +3.1        3.14 � 36%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       4.22 �  8%      +4.1        8.35 �  6%  perf-profile.calltrace.cycles-pp.__mutex_lock.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
>       5.13 � 13%      +4.5        9.62 � 20%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
>       0.00            +4.6        4.58 � 20%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       2.58 � 12%      +4.6        7.20 �  5%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode
>       2.57 � 12%      +4.6        7.20 �  5%  perf-profile.calltrace.cycles-pp.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items
>       0.00            +4.8        4.82 � 15%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__clear_extent_bit.clear_extent_bit.delete_tree_block
>       0.00            +4.8        4.82 � 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__clear_extent_bit.clear_extent_bit.delete_tree_block.__btrfs_cow_block
>       0.00            +4.8        4.84 � 15%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.delete_tree_block.__btrfs_cow_block.btrfs_cow_block
>       0.00            +4.8        4.84 � 15%  perf-profile.calltrace.cycles-pp.clear_extent_bit.delete_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot
>       0.00            +4.9        4.88 � 14%  perf-profile.calltrace.cycles-pp.delete_tree_block.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_truncate_inode_items
>       0.00            +6.0        5.97 �  7%  perf-profile.calltrace.cycles-pp.rb_next.find_first_extent_bit_state.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log
>       3.28 � 13%      +6.0        9.32 � 20%  perf-profile.calltrace.cycles-pp.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>       3.28 � 13%      +6.0        9.32 � 20%  perf-profile.calltrace.cycles-pp.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
>       0.00            +6.1        6.08 �  6%  perf-profile.calltrace.cycles-pp.rb_next.find_first_extent_bit_state.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents
>       3.22 � 13%      +6.1        9.32 � 20%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_truncate_inode_items.truncate_inode_items.btrfs_log_inode.btrfs_log_inode_parent
>       0.88 �  6%      +7.1        7.97 �  6%  perf-profile.calltrace.cycles-pp.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
>       0.86 �  6%      +7.1        7.97 �  6%  perf-profile.calltrace.cycles-pp.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       0.50 � 45%      +7.2        7.73 �  6%  perf-profile.calltrace.cycles-pp.__mutex_lock.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
>       0.00            +7.7        7.71 �  7%  perf-profile.calltrace.cycles-pp.find_first_extent_bit_state.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
>       0.00            +7.7        7.73 �  7%  perf-profile.calltrace.cycles-pp.find_first_extent_bit.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
>       0.00            +7.9        7.89 �  6%  perf-profile.calltrace.cycles-pp.find_first_extent_bit_state.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log
>       0.00            +7.9        7.91 �  6%  perf-profile.calltrace.cycles-pp.find_first_extent_bit.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file
>      14.56 �  8%     +10.9       25.48 �  6%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       5.85 � 12%     +11.5       17.36 � 10%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
>       5.84 � 13%     +11.5       17.36 � 10%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync
>      23.60 �  9%     +19.6       43.17 �  5%  perf-profile.calltrace.cycles-pp.fsync
>      23.49 �  9%     +19.7       43.15 �  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
>      23.48 �  9%     +19.7       43.15 �  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      23.46 �  9%     +19.7       43.14 �  5%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      23.46 �  9%     +19.7       43.14 �  5%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>      23.45 �  9%     +19.7       43.14 �  5%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      64.88 �  4%     -11.1       53.82 �  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      64.88 �  4%     -11.1       53.82 �  4%  perf-profile.children.cycles-pp.cpu_startup_entry
>      64.87 �  4%     -11.1       53.82 �  4%  perf-profile.children.cycles-pp.do_idle
>      64.38 �  4%     -10.8       53.60 �  4%  perf-profile.children.cycles-pp.start_secondary
>      59.43 �  5%      -9.3       50.13 �  5%  perf-profile.children.cycles-pp.cpuidle_enter
>      59.40 �  5%      -9.3       50.11 �  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       7.94 �  9%      -7.0        0.99 �  9%  perf-profile.children.cycles-pp.filemap_fdatawrite_range
>       7.94 �  9%      -7.0        0.99 �  9%  perf-profile.children.cycles-pp.do_writepages
>       7.92 �  9%      -6.9        0.98 �  9%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
>       5.66 � 10%      -4.9        0.72 � 10%  perf-profile.children.cycles-pp.btree_write_cache_pages
>       4.61 � 11%      -3.9        0.66 � 12%  perf-profile.children.cycles-pp.open64
>       4.65 � 10%      -3.9        0.73 � 10%  perf-profile.children.cycles-pp.do_sys_open
>       4.64 � 10%      -3.9        0.73 � 10%  perf-profile.children.cycles-pp.do_sys_openat2
>       4.41 �  9%      -3.9        0.53 � 10%  perf-profile.children.cycles-pp.submit_one_bio
>       4.40 �  9%      -3.9        0.53 � 11%  perf-profile.children.cycles-pp.btrfs_submit_metadata_bio
>       4.57 � 10%      -3.9        0.72 � 10%  perf-profile.children.cycles-pp.do_filp_open
>       4.57 � 10%      -3.9        0.72 � 10%  perf-profile.children.cycles-pp.path_openat
>       4.12 �  9%      -3.6        0.47 � 11%  perf-profile.children.cycles-pp.btree_csum_one_bio
>       4.10 �  9%      -3.6        0.47 � 12%  perf-profile.children.cycles-pp.csum_one_extent_buffer
>       3.33 � 45%      -3.1        0.20 � 34%  perf-profile.children.cycles-pp.poll_idle
>       3.76 �  7%      -3.1        0.68 � 10%  perf-profile.children.cycles-pp.__schedule
>       3.90 �  8%      -3.0        0.87 � 12%  perf-profile.children.cycles-pp.perf_tp_event
>       3.80 �  8%      -3.0        0.85 � 11%  perf-profile.children.cycles-pp.perf_swevent_overflow
>       3.80 �  8%      -3.0        0.85 � 11%  perf-profile.children.cycles-pp.__perf_event_overflow
>       3.78 �  8%      -2.9        0.84 � 11%  perf-profile.children.cycles-pp.perf_event_output_forward
>       3.40 � 10%      -2.9        0.46 � 15%  perf-profile.children.cycles-pp.btrfs_create
>       3.30 �  9%      -2.5        0.76 � 12%  perf-profile.children.cycles-pp.perf_prepare_sample
>       3.13 �  9%      -2.4        0.71 � 12%  perf-profile.children.cycles-pp.perf_callchain
>       3.12 �  9%      -2.4        0.71 � 11%  perf-profile.children.cycles-pp.get_perf_callchain
>       2.83 �  8%      -2.3        0.48 � 10%  perf-profile.children.cycles-pp.schedule
>       2.38 �  9%      -2.0        0.34 � 18%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
>       2.27 � 12%      -2.0        0.27 � 12%  perf-profile.children.cycles-pp.start_ordered_ops
>       2.26 � 11%      -2.0        0.26 � 12%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
>       2.25 � 11%      -2.0        0.26 � 11%  perf-profile.children.cycles-pp.extent_writepages
>       2.22 � 11%      -2.0        0.26 � 11%  perf-profile.children.cycles-pp.extent_write_cache_pages
>       2.44 �  9%      -1.9        0.58 � 11%  perf-profile.children.cycles-pp.perf_callchain_kernel
>       2.02 � 12%      -1.8        0.22 � 12%  perf-profile.children.cycles-pp.__extent_writepage
>       2.00 � 12%      -1.8        0.22 � 12%  perf-profile.children.cycles-pp.writepage_delalloc
>       1.95 �  7%      -1.7        0.24 � 11%  perf-profile.children.cycles-pp.read_extent_buffer
>       1.92 � 12%      -1.7        0.21 � 14%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
>       1.90 � 12%      -1.7        0.20 � 16%  perf-profile.children.cycles-pp.cow_file_range
>       1.89 � 10%      -1.7        0.23 � 10%  perf-profile.children.cycles-pp.btrfs_check_node
>       2.01 � 10%      -1.6        0.37 � 15%  perf-profile.children.cycles-pp.ksys_write
>       1.99 � 10%      -1.6        0.36 � 14%  perf-profile.children.cycles-pp.vfs_write
>       1.95 �  9%      -1.6        0.36 � 13%  perf-profile.children.cycles-pp.new_sync_write
>       1.67 � 18%      -1.5        0.16 � 16%  perf-profile.children.cycles-pp.check_leaf
>       1.78 � 10%      -1.5        0.29 � 18%  perf-profile.children.cycles-pp.write
>       1.59 � 13%      -1.4        0.16 � 15%  perf-profile.children.cycles-pp.cow_file_range_inline
>       1.86 �  9%      -1.4        0.44 �  7%  perf-profile.children.cycles-pp.unwind_next_frame
>       1.62 � 11%      -1.4        0.24 � 14%  perf-profile.children.cycles-pp.btrfs_file_write_iter
>       1.61 � 11%      -1.4        0.24 � 14%  perf-profile.children.cycles-pp.btrfs_buffered_write
>       1.51 �  9%      -1.3        0.17 � 19%  perf-profile.children.cycles-pp.btrfs_add_link
>       1.45 �  9%      -1.3        0.16 � 18%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
>       1.54 �  8%      -1.3        0.26 � 12%  perf-profile.children.cycles-pp.try_to_wake_up
>       1.48 �  7%      -1.3        0.22 � 11%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>       1.49 � 11%      -1.2        0.25 � 12%  perf-profile.children.cycles-pp.dequeue_task_fair
>       1.41 � 11%      -1.2        0.17 � 14%  perf-profile.children.cycles-pp.copy_extent_buffer_full
>       1.41 � 11%      -1.2        0.18 � 12%  perf-profile.children.cycles-pp.copy_page
>       1.46 � 11%      -1.2        0.25 � 12%  perf-profile.children.cycles-pp.dequeue_entity
>       1.36 � 11%      -1.2        0.18 � 20%  perf-profile.children.cycles-pp.asm_common_interrupt
>       1.34 � 11%      -1.2        0.18 � 20%  perf-profile.children.cycles-pp.common_interrupt
>       1.29 � 11%      -1.1        0.17 � 17%  perf-profile.children.cycles-pp.__common_interrupt
>       1.28 � 12%      -1.1        0.17 � 18%  perf-profile.children.cycles-pp.handle_edge_irq
>       1.25 � 14%      -1.1        0.14 � 17%  perf-profile.children.cycles-pp.read_block_for_search
>       1.26 � 11%      -1.1        0.16 � 16%  perf-profile.children.cycles-pp.handle_irq_event
>       1.26 � 11%      -1.1        0.16 � 18%  perf-profile.children.cycles-pp.handle_irq_event_percpu
>       1.24 � 11%      -1.1        0.16 � 16%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
>       1.24 � 12%      -1.1        0.16 � 17%  perf-profile.children.cycles-pp.nvme_irq
>       1.17 �  8%      -1.0        0.13 � 23%  perf-profile.children.cycles-pp.insert_with_overflow
>       1.16 �  8%      -1.0        0.16 � 15%  perf-profile.children.cycles-pp.__wake_up_common
>       1.18 �  9%      -1.0        0.18 � 25%  perf-profile.children.cycles-pp.btrfs_new_inode
>       1.12 �  7%      -1.0        0.13 �  8%  perf-profile.children.cycles-pp.folio_wait_bit
>       1.12 � 11%      -1.0        0.14 � 19%  perf-profile.children.cycles-pp.blk_mq_end_request_batch
>       1.50 � 10%      -1.0        0.53 � 15%  perf-profile.children.cycles-pp.update_curr
>       1.09 � 11%      -1.0        0.12 � 19%  perf-profile.children.cycles-pp.find_extent_buffer
>       1.07 �  7%      -1.0        0.12 � 11%  perf-profile.children.cycles-pp.io_schedule
>       1.07 � 12%      -0.9        0.12 � 18%  perf-profile.children.cycles-pp.blk_update_request
>       1.41 � 11%      -0.9        0.50 � 16%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>       1.08 �  8%      -0.9        0.17 � 13%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       1.00 � 13%      -0.9        0.10 � 13%  perf-profile.children.cycles-pp.btrfs_drop_extents
>       1.38 � 19%      -0.9        0.50 �  4%  perf-profile.children.cycles-pp.record__finish_output
>       1.38 � 19%      -0.9        0.50 �  4%  perf-profile.children.cycles-pp.perf_session__process_events
>       1.49 � 17%      -0.9        0.62 �  3%  perf-profile.children.cycles-pp.cmd_record
>       1.49 � 17%      -0.9        0.62 �  3%  perf-profile.children.cycles-pp.cmd_sched
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.children.cycles-pp.__libc_start_main
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.children.cycles-pp.main
>       1.53 � 19%      -0.9        0.67 �  5%  perf-profile.children.cycles-pp.run_builtin
>       1.15 � 10%      -0.8        0.32 � 16%  perf-profile.children.cycles-pp.kthread
>       0.96 � 14%      -0.8        0.13 � 19%  perf-profile.children.cycles-pp.btrfs_lookup_match_dir
>       1.15 � 10%      -0.8        0.32 � 16%  perf-profile.children.cycles-pp.ret_from_fork
>       1.00 �  7%      -0.8        0.17 � 15%  perf-profile.children.cycles-pp.btrfs_update_root
>       0.98 � 11%      -0.8        0.18 � 21%  perf-profile.children.cycles-pp.worker_thread
>       0.94 � 11%      -0.8        0.18 � 21%  perf-profile.children.cycles-pp.process_one_work
>       0.85 � 11%      -0.7        0.10 � 20%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
>       0.94 �  8%      -0.7        0.19 �  8%  perf-profile.children.cycles-pp.schedule_idle
>       0.83 � 17%      -0.7        0.09 � 24%  perf-profile.children.cycles-pp.btrfs_get_32
>       0.85 � 11%      -0.7        0.13 � 22%  perf-profile.children.cycles-pp.write_one_eb
>       1.19 � 17%      -0.7        0.47 �  3%  perf-profile.children.cycles-pp.process_simple
>       0.74 � 13%      -0.7        0.04 � 71%  perf-profile.children.cycles-pp.btrfs_end_bio
>       0.72 � 12%      -0.7        0.06 � 50%  perf-profile.children.cycles-pp.btrfs_work_helper
>       0.70 � 13%      -0.7        0.04 � 72%  perf-profile.children.cycles-pp.folio_end_writeback
>       0.77 � 15%      -0.7        0.10 � 18%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
>       0.72 � 12%      -0.7        0.06 � 50%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
>       0.70 � 12%      -0.7        0.04 � 72%  perf-profile.children.cycles-pp.end_bio_extent_buffer_writepage
>       0.72 � 11%      -0.6        0.10 � 20%  perf-profile.children.cycles-pp.generic_bin_search
>       0.69 �  9%      -0.6        0.09 � 30%  perf-profile.children.cycles-pp.setup_items_for_insert
>       0.79 �  9%      -0.6        0.20 � 10%  perf-profile.children.cycles-pp.__orc_find
>       0.62 � 16%      -0.6        0.04 � 72%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
>       0.67 � 14%      -0.6        0.09 � 16%  perf-profile.children.cycles-pp.prepare_pages
>       0.75 � 10%      -0.6        0.18 � 13%  perf-profile.children.cycles-pp.write_all_supers
>       0.64 � 10%      -0.6        0.09 � 12%  perf-profile.children.cycles-pp.folio_mark_dirty
>       0.69 � 12%      -0.5        0.16 � 21%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
>       0.62 � 10%      -0.5        0.08 � 13%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
>       0.66 � 12%      -0.5        0.13 � 21%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.63 � 10%      -0.5        0.10 � 22%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.78 � 20%      -0.5        0.26 �  9%  perf-profile.children.cycles-pp.__ordered_events__flush
>       0.77 � 20%      -0.5        0.25 �  9%  perf-profile.children.cycles-pp.perf_session__process_user_event
>       0.58 �  9%      -0.5        0.07 � 15%  perf-profile.children.cycles-pp.folio_wake_bit
>       0.67 � 10%      -0.5        0.16 �  9%  perf-profile.children.cycles-pp.__unwind_start
>       0.60 �  9%      -0.5        0.08 � 13%  perf-profile.children.cycles-pp.filemap_dirty_folio
>       0.60 � 10%      -0.5        0.10 � 24%  perf-profile.children.cycles-pp.split_leaf
>       0.58 � 10%      -0.5        0.09 � 23%  perf-profile.children.cycles-pp.autoremove_wake_function
>       0.56 �  9%      -0.5        0.07 � 14%  perf-profile.children.cycles-pp.wake_page_function
>       0.62 �  9%      -0.5        0.12 � 20%  perf-profile.children.cycles-pp.perf_callchain_user
>       0.56 � 11%      -0.5        0.08 � 21%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
>       0.76 � 20%      -0.5        0.28 �  8%  perf-profile.children.cycles-pp.perf_session__deliver_event
>       0.55 �  8%      -0.5        0.07 � 14%  perf-profile.children.cycles-pp.btrfs_release_path
>       0.53 � 17%      -0.5        0.05 � 48%  perf-profile.children.cycles-pp.btrfs_get_64
>       0.64 � 12%      -0.5        0.16 �  7%  perf-profile.children.cycles-pp.orc_find
>       0.82 � 11%      -0.5        0.34 � 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.55 � 10%      -0.5        0.08 � 17%  perf-profile.children.cycles-pp.btrfs_mark_buffer_dirty
>       0.58 �  9%      -0.5        0.12 � 17%  perf-profile.children.cycles-pp.__get_user_nocheck_8
>       0.52 � 28%      -0.4        0.08 � 22%  perf-profile.children.cycles-pp.alloc_extent_buffer
>       0.51 � 11%      -0.4        0.07 � 14%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
>       0.50 �  9%      -0.4        0.07 � 21%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
>       0.50 �  9%      -0.4        0.07 � 14%  perf-profile.children.cycles-pp.csum_tree_block
>       0.46 � 11%      -0.4        0.05 � 46%  perf-profile.children.cycles-pp.__radix_tree_lookup
>       0.57 � 11%      -0.4        0.16 � 19%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
>       0.48 � 17%      -0.4        0.07 � 16%  perf-profile.children.cycles-pp.btrfs_lookup
>       0.48 � 17%      -0.4        0.07 � 16%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
>       0.55 � 16%      -0.4        0.15 � 21%  perf-profile.children.cycles-pp.copy_items
>       0.44 � 15%      -0.4        0.05 � 46%  perf-profile.children.cycles-pp.prepare_uptodate_page
>       0.43 � 16%      -0.4        0.05 � 47%  perf-profile.children.cycles-pp.btrfs_readpage
>       0.50 � 12%      -0.4        0.12 � 27%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>       0.44 � 33%      -0.4        0.06 � 51%  perf-profile.children.cycles-pp.pagecache_get_page
>       0.40 � 16%      -0.4        0.03 �100%  perf-profile.children.cycles-pp.check_setget_bounds
>       0.43 � 34%      -0.4        0.06 � 51%  perf-profile.children.cycles-pp.__filemap_get_folio
>       0.41 � 14%      -0.4        0.04 � 73%  perf-profile.children.cycles-pp.btrfs_update_inode
>       0.41 � 13%      -0.4        0.05 � 47%  perf-profile.children.cycles-pp.btrfs_check_ref_name_override
>       0.55 �  7%      -0.3        0.20 � 12%  perf-profile.children.cycles-pp.asm_exc_page_fault
>       0.35 � 13%      -0.3        0.03 �101%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
>       0.38 �  9%      -0.3        0.06 �  7%  perf-profile.children.cycles-pp.perf_output_sample
>       0.37 � 15%      -0.3        0.05 � 47%  perf-profile.children.cycles-pp.btrfs_write_check
>       0.41 � 12%      -0.3        0.09 � 22%  perf-profile.children.cycles-pp.unwind_get_return_address
>       0.34 � 10%      -0.3        0.03 �100%  perf-profile.children.cycles-pp.btrfs_dirty_pages
>       0.36 � 15%      -0.3        0.05 � 51%  perf-profile.children.cycles-pp.btrfs_reserve_extent
>       0.34 � 16%      -0.3        0.04 � 73%  perf-profile.children.cycles-pp.file_remove_privs
>       0.35 � 10%      -0.3        0.06 � 52%  perf-profile.children.cycles-pp.btrfs_free_tree_block
>       0.33 � 16%      -0.3        0.04 � 73%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
>       0.33 � 11%      -0.3        0.04 � 71%  perf-profile.children.cycles-pp.__folio_mark_dirty
>       0.38 � 13%      -0.3        0.08 � 20%  perf-profile.children.cycles-pp.__kernel_text_address
>       0.31 � 15%      -0.3        0.04 � 73%  perf-profile.children.cycles-pp.find_free_extent
>       0.33 � 11%      -0.3        0.07 � 21%  perf-profile.children.cycles-pp.kernel_text_address
>       0.31 � 11%      -0.2        0.07 � 47%  perf-profile.children.cycles-pp.rwsem_wake
>       0.29 �  5%      -0.2        0.05 � 45%  perf-profile.children.cycles-pp.mkdir
>       0.28 � 17%      -0.2        0.05 � 74%  perf-profile.children.cycles-pp.btrfs_map_bio
>       0.31 �  6%      -0.2        0.08 � 24%  perf-profile.children.cycles-pp.wake_up_q
>       0.26 �  7%      -0.2        0.04 � 71%  perf-profile.children.cycles-pp.__x64_sys_mkdir
>       0.24 � 13%      -0.2        0.02 � 99%  perf-profile.children.cycles-pp.perf_output_copy
>       0.28 � 14%      -0.2        0.06 � 14%  perf-profile.children.cycles-pp.btrfs_end_super_write
>       0.25 � 13%      -0.2        0.04 � 71%  perf-profile.children.cycles-pp.memcpy_erms
>       0.25 � 14%      -0.2        0.04 � 72%  perf-profile.children.cycles-pp.mutex_lock
>       0.26 � 18%      -0.2        0.06 � 49%  perf-profile.children.cycles-pp.submit_bio_noacct
>       0.23 � 13%      -0.2        0.03 �100%  perf-profile.children.cycles-pp.down_read
>       0.26 � 16%      -0.2        0.06 � 47%  perf-profile.children.cycles-pp.blk_mq_submit_bio
>       0.27 �  8%      -0.2        0.08 � 20%  perf-profile.children.cycles-pp.__close
>       0.22 � 21%      -0.2        0.03 � 70%  perf-profile.children.cycles-pp.__might_resched
>       0.24 �  8%      -0.2        0.05 � 46%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.21 �  6%      -0.2        0.02 � 99%  perf-profile.children.cycles-pp.do_mkdirat
>       0.27 � 10%      -0.2        0.08 � 13%  perf-profile.children.cycles-pp.__libc_write
>       0.26 � 10%      -0.2        0.08 � 17%  perf-profile.children.cycles-pp.generic_file_write_iter
>       0.26 � 10%      -0.2        0.08 � 17%  perf-profile.children.cycles-pp.__generic_file_write_iter
>       0.26 � 10%      -0.2        0.08 � 17%  perf-profile.children.cycles-pp.generic_perform_write
>       0.26 �  8%      -0.2        0.08 � 20%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.21 � 13%      -0.2        0.04 � 73%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.21 � 19%      -0.2        0.04 � 72%  perf-profile.children.cycles-pp.write_dev_supers
>       0.26 � 12%      -0.2        0.08 � 19%  perf-profile.children.cycles-pp.unlock_up
>       0.24 �  5%      -0.2        0.07 � 18%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.20 �  3%      -0.1        0.06 � 46%  perf-profile.children.cycles-pp.task_work_run
>       0.19 � 12%      -0.1        0.05 � 71%  perf-profile.children.cycles-pp.__etree_search
>       0.22 � 70%      -0.1        0.08 � 24%  perf-profile.children.cycles-pp._find_next_bit
>       0.22 �  5%      -0.1        0.08 �  5%  perf-profile.children.cycles-pp.link_path_walk
>       0.35 �  9%      -0.1        0.22 �  7%  perf-profile.children.cycles-pp.machines__deliver_event
>       0.16 � 17%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.push_leaf_left
>       0.17 �  4%      -0.1        0.04 � 71%  perf-profile.children.cycles-pp.__fput
>       0.27 � 18%      -0.1        0.16 � 13%  perf-profile.children.cycles-pp.ordered_events__queue
>       0.15 �  7%      -0.1        0.05 � 47%  perf-profile.children.cycles-pp.update_load_avg
>       0.13 � 22%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.do_sys_poll
>       0.13 � 22%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.__x64_sys_poll
>       0.13 � 22%      -0.1        0.03 �100%  perf-profile.children.cycles-pp.__poll
>       0.24 � 10%      -0.1        0.13 � 12%  perf-profile.children.cycles-pp.exc_page_fault
>       0.25 � 18%      -0.1        0.15 � 13%  perf-profile.children.cycles-pp.queue_event
>       0.14 � 33%      -0.1        0.04 � 73%  perf-profile.children.cycles-pp.finish_task_switch
>       0.21 �  7%      -0.1        0.12 �  8%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
>       0.14 � 15%      -0.1        0.07 � 14%  perf-profile.children.cycles-pp.newidle_balance
>       0.14 �  6%      -0.1        0.08 � 10%  perf-profile.children.cycles-pp.walk_component
>       0.11 �  9%      -0.0        0.07 � 17%  perf-profile.children.cycles-pp.idle_cpu
>       0.14 �  8%      -0.0        0.11 �  5%  perf-profile.children.cycles-pp.thread__find_map
>       0.07 � 11%      -0.0        0.04 � 45%  perf-profile.children.cycles-pp.user_path_at_empty
>       0.11 �  9%      -0.0        0.08 �  8%  perf-profile.children.cycles-pp.handle_mm_fault
>       0.10 � 11%      -0.0        0.08 � 10%  perf-profile.children.cycles-pp.__handle_mm_fault
>       0.17 � 15%      +0.2        0.33 � 18%  perf-profile.children.cycles-pp.task_tick_fair
>       1.13 � 18%      +1.1        2.20 � 29%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
>       0.75 � 12%      +1.4        2.13 � 30%  perf-profile.children.cycles-pp.set_extent_bit
>       0.18 � 27%      +1.7        1.90 �102%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       5.79 � 10%      +2.7        8.47 �  7%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
>       5.48 �  9%      +3.0        8.51 �  6%  perf-profile.children.cycles-pp.wait_log_commit
>       3.61 � 11%      +3.8        7.38 �  5%  perf-profile.children.cycles-pp.btrfs_cow_block
>       3.60 � 11%      +3.8        7.38 �  5%  perf-profile.children.cycles-pp.__btrfs_cow_block
>       3.61 �  6%      +4.4        8.01 �  5%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>       5.14 � 13%      +4.5        9.62 � 20%  perf-profile.children.cycles-pp.btrfs_log_inode
>       0.26 � 16%      +4.6        4.88 � 14%  perf-profile.children.cycles-pp.__clear_extent_bit
>       0.07 � 29%      +4.8        4.85 � 15%  perf-profile.children.cycles-pp.clear_extent_bit
>       0.00            +4.9        4.91 � 14%  perf-profile.children.cycles-pp.delete_tree_block
>       1.83 �  9%      +5.5        7.34 �  5%  perf-profile.children.cycles-pp._raw_spin_lock
>       3.28 � 13%      +6.0        9.32 � 20%  perf-profile.children.cycles-pp.truncate_inode_items
>       3.28 � 13%      +6.0        9.32 � 20%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
>       0.34 � 15%      +6.6        6.92 �  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       1.33 � 17%      +6.8        8.08 �  7%  perf-profile.children.cycles-pp.osq_lock
>       0.88 �  6%      +7.1        7.97 �  6%  perf-profile.children.cycles-pp.btrfs_wait_tree_log_extents
>       0.86 �  6%      +7.1        7.97 �  6%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
>      14.57 �  8%     +10.9       25.48 �  6%  perf-profile.children.cycles-pp.btrfs_sync_log
>       4.93 �  8%     +11.2       16.09 �  6%  perf-profile.children.cycles-pp.__mutex_lock
>       5.85 � 12%     +11.5       17.36 � 10%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
>       5.84 � 13%     +11.5       17.36 � 10%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
>       0.18 � 31%     +12.2       12.40 �  6%  perf-profile.children.cycles-pp.rb_next
>      31.52 �  9%     +13.5       45.01 �  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      31.50 �  9%     +13.5       45.01 �  5%  perf-profile.children.cycles-pp.do_syscall_64
>       0.11 � 34%     +15.5       15.64 �  6%  perf-profile.children.cycles-pp.find_first_extent_bit
>       0.02 �149%     +15.6       15.64 �  6%  perf-profile.children.cycles-pp.find_first_extent_bit_state
>      23.60 �  9%     +19.6       43.17 �  5%  perf-profile.children.cycles-pp.fsync
>      23.46 �  9%     +19.7       43.14 �  5%  perf-profile.children.cycles-pp.__x64_sys_fsync
>      23.46 �  9%     +19.7       43.14 �  5%  perf-profile.children.cycles-pp.do_fsync
>      23.45 �  9%     +19.7       43.14 �  5%  perf-profile.children.cycles-pp.btrfs_sync_file
>       2.92 � 48%      -2.7        0.17 � 32%  perf-profile.self.cycles-pp.poll_idle
>       1.90 �  8%      -1.7        0.23 � 10%  perf-profile.self.cycles-pp.read_extent_buffer
>       1.38 � 10%      -1.2        0.18 � 12%  perf-profile.self.cycles-pp.copy_page
>       1.61 �  9%      -1.2        0.44 � 10%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.79 �  9%      -0.6        0.20 � 10%  perf-profile.self.cycles-pp.__orc_find
>       0.65 � 17%      -0.6        0.07 � 48%  perf-profile.self.cycles-pp.btrfs_get_32
>       0.62 � 12%      -0.5        0.14 � 15%  perf-profile.self.cycles-pp.unwind_next_frame
>       0.52 � 11%      -0.5        0.06 � 48%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
>       0.45 � 14%      -0.4        0.05 � 46%  perf-profile.self.cycles-pp.__radix_tree_lookup
>       0.42 � 16%      -0.4        0.04 � 45%  perf-profile.self.cycles-pp.find_extent_buffer_nolock
>       0.66 �  9%      -0.4        0.30 � 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.33 � 13%      -0.3        0.02 � 99%  perf-profile.self.cycles-pp.check_setget_bounds
>       0.34 �  9%      -0.3        0.04 � 73%  perf-profile.self.cycles-pp.generic_bin_search
>       0.32 � 18%      -0.3        0.04 � 71%  perf-profile.self.cycles-pp.btrfs_search_slot
>       0.31 �  8%      -0.3        0.04 � 71%  perf-profile.self.cycles-pp.__get_user_nocheck_8
>       0.26 � 13%      -0.2        0.05 � 45%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.24 � 12%      -0.2        0.04 � 71%  perf-profile.self.cycles-pp.memcpy_erms
>       0.20 �  8%      -0.2        0.03 � 70%  perf-profile.self.cycles-pp.__might_resched
>       0.22 � 12%      -0.2        0.06 � 11%  perf-profile.self.cycles-pp.orc_find
>       0.18 �  9%      -0.1        0.04 � 71%  perf-profile.self.cycles-pp.__etree_search
>       0.21 � 69%      -0.1        0.08 � 24%  perf-profile.self.cycles-pp._find_next_bit
>       0.24 � 18%      -0.1        0.15 � 13%  perf-profile.self.cycles-pp.queue_event
>       0.10 � 10%      -0.0        0.07 � 16%  perf-profile.self.cycles-pp.idle_cpu
>       0.16 � 30%      +1.7        1.88 �102%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       0.00            +3.3        3.29 � 10%  perf-profile.self.cycles-pp.find_first_extent_bit_state
>       3.56 �  7%      +4.4        7.93 �  5%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>       0.34 � 15%      +6.4        6.77 �  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       1.31 � 17%      +6.7        7.98 �  7%  perf-profile.self.cycles-pp.osq_lock
>       0.16 � 24%     +11.9       12.04 �  6%  perf-profile.self.cycles-pp.rb_next
>      63652 �  4%    +342.1%     281400 � 22%  softirqs.CPU0.RCU
>      49340 �  3%    +323.7%     209037 �  4%  softirqs.CPU0.SCHED
>      77569 � 22%    +301.1%     311142 � 16%  softirqs.CPU1.RCU
>      51305 �  5%    +440.7%     277414 � 12%  softirqs.CPU1.SCHED
>      63598 �  7%    +393.4%     313821 � 12%  softirqs.CPU10.RCU
>      46668 �  3%    +442.9%     253366 � 12%  softirqs.CPU10.SCHED
>      56913 �  8%    +372.7%     269022 � 24%  softirqs.CPU100.RCU
>      44647 �  4%    +342.7%     197632 �  4%  softirqs.CPU100.SCHED
>      54306 �  5%    +428.0%     286713 � 24%  softirqs.CPU101.RCU
>      43536 �  5%    +352.3%     196901 �  3%  softirqs.CPU101.SCHED
>      57307 �  5%    +403.7%     288668 � 24%  softirqs.CPU102.RCU
>      44116 �  5%    +344.9%     196272 �  3%  softirqs.CPU102.SCHED
>      55926 �  5%    +396.2%     277483 � 24%  softirqs.CPU103.RCU
>      43612 �  5%    +344.3%     193773 �  3%  softirqs.CPU103.SCHED
>      52019 � 12%    +409.4%     264966 � 25%  softirqs.CPU104.RCU
>      37370 � 24%    +406.0%     189092 �  4%  softirqs.CPU104.SCHED
>      58110 �  5%    +399.9%     290468 � 23%  softirqs.CPU105.RCU
>      43964 �  5%    +350.1%     197899 �  4%  softirqs.CPU105.SCHED
>      57196 �  4%    +389.7%     280102 � 24%  softirqs.CPU106.RCU
>      43755 �  5%    +350.2%     196999 �  3%  softirqs.CPU106.SCHED
>      57359 �  5%    +401.5%     287675 � 24%  softirqs.CPU107.RCU
>      43586 �  5%    +348.2%     195346 �  4%  softirqs.CPU107.SCHED
>      58033 �  5%    +394.4%     286918 � 23%  softirqs.CPU108.RCU
>      43774 �  4%    +348.7%     196415 �  3%  softirqs.CPU108.SCHED
>      55569 �  9%    +396.6%     275947 � 24%  softirqs.CPU109.RCU
>      40526 � 16%    +379.0%     194101 �  3%  softirqs.CPU109.SCHED
>      63823 � 12%    +356.7%     291484 � 21%  softirqs.CPU11.RCU
>      46707 �  7%    +339.0%     205048 �  4%  softirqs.CPU11.SCHED
>      55191 �  4%    +376.4%     262942 � 18%  softirqs.CPU110.RCU
>      42677 �  5%    +346.8%     190674 �  4%  softirqs.CPU110.SCHED
>      57155 �  6%    +390.3%     280242 � 21%  softirqs.CPU111.RCU
>      43508 �  5%    +346.8%     194411 �  3%  softirqs.CPU111.SCHED
>      48597 �  5%    +408.8%     247256 � 24%  softirqs.CPU112.RCU
>      43644 �  5%    +306.3%     177304 � 19%  softirqs.CPU112.SCHED
>      57125 � 24%    +395.7%     283157 � 16%  softirqs.CPU113.RCU
>      46364 �  8%    +424.7%     243265 � 13%  softirqs.CPU113.SCHED
>      51740 �  7%    +404.6%     261059 � 22%  softirqs.CPU114.RCU
>      42019 � 18%    +374.5%     199368 �  3%  softirqs.CPU114.SCHED
>      58832 � 23%    +385.0%     285311 � 13%  softirqs.CPU115.RCU
>      46274 �  9%    +479.9%     268326 � 11%  softirqs.CPU115.SCHED
>      54480 �  7%    +377.9%     260376 � 20%  softirqs.CPU116.RCU
>      45349 �  5%    +350.6%     204338 �  3%  softirqs.CPU116.SCHED
>      53106 � 10%    +369.5%     249325 � 20%  softirqs.CPU117.RCU
>      44834 �  2%    +346.3%     200104 �  3%  softirqs.CPU117.SCHED
>      69617 � 19%    +310.4%     285713 � 13%  softirqs.CPU118.RCU
>      49272 �  4%    +427.5%     259921 � 10%  softirqs.CPU118.SCHED
>      56984 �  4%    +356.1%     259910 � 20%  softirqs.CPU119.RCU
>      44993 �  5%    +356.8%     205534 �  3%  softirqs.CPU119.SCHED
>       3971 � 82%    +570.9%      26643 � 33%  softirqs.CPU12.NET_RX
>      60932 �  6%    +379.2%     291960 � 20%  softirqs.CPU12.RCU
>      45366 �  4%    +350.9%     204570 �  4%  softirqs.CPU12.SCHED
>      52992 � 10%    +348.7%     237785 � 16%  softirqs.CPU120.RCU
>      42449 � 18%    +377.7%     202781 �  4%  softirqs.CPU120.SCHED
>      47849 � 10%    +365.3%     222632 � 12%  softirqs.CPU121.RCU
>      45212 �  3%    +338.1%     198056 �  9%  softirqs.CPU121.SCHED
>      49431 � 10%    +365.1%     229896 � 12%  softirqs.CPU122.RCU
>      45367 �  4%    +352.7%     205373 �  2%  softirqs.CPU122.SCHED
>      53860 � 12%    +336.8%     235268 � 14%  softirqs.CPU123.RCU
>      42520 � 15%    +385.5%     206453 �  2%  softirqs.CPU123.SCHED
>      53023 � 12%    +354.0%     240730 � 13%  softirqs.CPU124.RCU
>      45270 �  3%    +355.2%     206090 �  2%  softirqs.CPU124.SCHED
>      53843 � 12%    +323.7%     228115 � 10%  softirqs.CPU125.RCU
>      45383 �  3%    +354.5%     206269 �  2%  softirqs.CPU125.SCHED
>      50612 � 10%    +354.2%     229899 � 14%  softirqs.CPU126.RCU
>      43458 � 11%    +373.3%     205690 �  2%  softirqs.CPU126.SCHED
>      47811 � 10%    +354.5%     217312 � 15%  softirqs.CPU127.RCU
>      45393 �  3%    +350.9%     204676 �  2%  softirqs.CPU127.SCHED
>      60930 � 11%    +344.5%     270847 � 15%  softirqs.CPU128.RCU
>      44984 �  4%    +355.5%     204927 �  2%  softirqs.CPU128.SCHED
>      63281 � 16%    +319.1%     265212 � 17%  softirqs.CPU129.RCU
>      44936 �  3%    +357.9%     205778 �  2%  softirqs.CPU129.SCHED
>       2554 �126%    +781.9%      22525 � 79%  softirqs.CPU13.NET_RX
>      59587 �  8%    +411.2%     304622 � 15%  softirqs.CPU13.RCU
>      44708 �  6%    +430.8%     237330 � 17%  softirqs.CPU13.SCHED
>      61517 � 11%    +357.2%     281242 � 11%  softirqs.CPU130.RCU
>      44925 �  3%    +356.9%     205246 �  2%  softirqs.CPU130.SCHED
>      65236 � 16%    +349.5%     293206 � 12%  softirqs.CPU131.RCU
>      45403 �  3%    +352.8%     205592 �  2%  softirqs.CPU131.SCHED
>      62192 � 14%    +375.4%     295674 � 13%  softirqs.CPU132.RCU
>      42904 � 14%    +378.8%     205413 �  2%  softirqs.CPU132.SCHED
>      58253 �  6%    +364.4%     270520 � 13%  softirqs.CPU133.RCU
>      45293 �  2%    +351.7%     204596 �  2%  softirqs.CPU133.SCHED
>      61163 � 10%    +351.1%     275886 �  8%  softirqs.CPU134.RCU
>      45033 �  3%    +354.5%     204692 �  2%  softirqs.CPU134.SCHED
>      64743 � 17%    +338.5%     283887 �  9%  softirqs.CPU135.RCU
>      45320 �  3%    +354.4%     205955 �  2%  softirqs.CPU135.SCHED
>      59767 � 10%    +362.4%     276383 � 11%  softirqs.CPU136.RCU
>      45304 �  3%    +352.6%     205044 �  2%  softirqs.CPU136.SCHED
>      66245 � 16%    +347.1%     296169 � 11%  softirqs.CPU137.RCU
>      45400 �  3%    +346.8%     202857 �  4%  softirqs.CPU137.SCHED
>      12.67 � 15%  +28681.6%       3645 �222%  softirqs.CPU137.TIMER
>      63311 � 19%    +356.8%     289197 � 14%  softirqs.CPU138.RCU
>      45374 �  3%    +353.9%     205954 �  2%  softirqs.CPU138.SCHED
>      65646 � 15%    +327.8%     280826 � 12%  softirqs.CPU139.RCU
>      45240 �  3%    +340.2%     199168 �  2%  softirqs.CPU139.SCHED
>      16.00 � 25%  +56830.2%       9108 �215%  softirqs.CPU139.TIMER
>      60185 �  6%    +371.6%     283832 � 24%  softirqs.CPU14.RCU
>      41827 � 17%    +379.4%     200505 �  2%  softirqs.CPU14.SCHED
>      65300 � 18%    +342.3%     288816 � 12%  softirqs.CPU140.RCU
>      45340 �  3%    +353.8%     205747 �  2%  softirqs.CPU140.SCHED
>      62410 � 13%    +350.8%     281343 � 10%  softirqs.CPU141.RCU
>      45172 �  4%    +354.8%     205421 �  2%  softirqs.CPU141.SCHED
>      66114 � 16%    +345.3%     294423 � 12%  softirqs.CPU142.RCU
>      44910 �  5%    +357.8%     205590 �  2%  softirqs.CPU142.SCHED
>      59908 � 26%    +365.1%     278631 � 16%  softirqs.CPU143.RCU
>      45322 �  3%    +354.2%     205841 �  2%  softirqs.CPU143.SCHED
>      58563 � 17%    +355.5%     266765 � 19%  softirqs.CPU144.RCU
>      45398 �  3%    +269.3%     167665 � 32%  softirqs.CPU144.SCHED
>      57117 � 14%    +353.1%     258821 � 16%  softirqs.CPU145.RCU
>      44873 �  3%    +359.9%     206370 �  2%  softirqs.CPU145.SCHED
>      53695 � 12%    +379.9%     257672 � 15%  softirqs.CPU146.RCU
>      45108 �  3%    +356.0%     205710 �  2%  softirqs.CPU146.SCHED
>      60494 � 19%    +362.9%     280037 � 11%  softirqs.CPU147.RCU
>      45342 �  2%    +355.8%     206659        softirqs.CPU147.SCHED
>      61708 � 17%    +355.0%     280785 � 12%  softirqs.CPU148.RCU
>      44963 �  2%    +325.1%     191135 � 17%  softirqs.CPU148.SCHED
>      62685 � 19%    +354.7%     285033 � 12%  softirqs.CPU149.RCU
>      44887 �  2%    +359.8%     206389        softirqs.CPU149.SCHED
>      60025 �  9%    +374.5%     284843 � 22%  softirqs.CPU15.RCU
>      46873 � 12%    +305.0%     189826 � 15%  softirqs.CPU15.SCHED
>      63745 � 17%    +341.1%     281196 � 13%  softirqs.CPU150.RCU
>      45400 �  3%    +354.2%     206227 �  2%  softirqs.CPU150.SCHED
>      59142 � 17%    +391.8%     290854 � 13%  softirqs.CPU151.RCU
>      45063 �  3%    +356.8%     205846 �  2%  softirqs.CPU151.SCHED
>      62173 � 19%    +368.5%     291301 � 12%  softirqs.CPU152.RCU
>      44941 �  3%    +359.9%     206698        softirqs.CPU152.SCHED
>      60823 � 14%    +362.7%     281461 � 14%  softirqs.CPU153.RCU
>      45298 �  3%    +354.9%     206063 �  2%  softirqs.CPU153.SCHED
>      63059 � 18%    +374.1%     298987 � 12%  softirqs.CPU154.RCU
>      44578 �  2%    +362.7%     206273 �  2%  softirqs.CPU154.SCHED
>      63445 � 19%    +372.1%     299518 � 11%  softirqs.CPU155.RCU
>      45381 �  3%    +355.2%     206577        softirqs.CPU155.SCHED
>      56287 � 13%    +384.0%     272439 � 15%  softirqs.CPU156.RCU
>      44609 �  3%    +360.3%     205323 �  2%  softirqs.CPU156.SCHED
>      58413 � 13%    +368.8%     273828 � 14%  softirqs.CPU157.RCU
>      44570 �  3%    +360.9%     205442 �  2%  softirqs.CPU157.SCHED
>      62362 � 18%    +356.1%     284451 � 12%  softirqs.CPU158.RCU
>      44831 �  2%    +360.7%     206536        softirqs.CPU158.SCHED
>      58942 � 12%    +362.7%     272740 � 18%  softirqs.CPU159.RCU
>      44870 �  2%    +358.8%     205858 �  2%  softirqs.CPU159.SCHED
>      52648 �  7%    +370.0%     247431 � 19%  softirqs.CPU16.RCU
>      45545 �  4%    +303.5%     183786 � 18%  softirqs.CPU16.SCHED
>      54794 � 18%    +404.5%     276449 �  9%  softirqs.CPU160.RCU
>      45248 �  3%    +356.2%     206408        softirqs.CPU160.SCHED
>      56431 � 17%    +402.2%     283391 �  9%  softirqs.CPU161.RCU
>      45258 �  3%    +356.5%     206609        softirqs.CPU161.SCHED
>      50149 � 16%    +394.1%     247814 � 18%  softirqs.CPU162.RCU
>      44263 �  3%    +363.7%     205261 �  2%  softirqs.CPU162.SCHED
>      56212 � 17%    +385.9%     273156 �  9%  softirqs.CPU163.RCU
>      44865 �  3%    +359.1%     205966 �  2%  softirqs.CPU163.SCHED
>      56988 � 22%    +399.2%     284493 �  9%  softirqs.CPU164.RCU
>      45379 �  2%    +355.2%     206584        softirqs.CPU164.SCHED
>      54719 � 15%    +390.0%     268124 � 13%  softirqs.CPU165.RCU
>      44588 �  3%    +361.1%     205613 �  2%  softirqs.CPU165.SCHED
>      58206 � 18%    +373.3%     275474 � 18%  softirqs.CPU166.RCU
>      44633 �  3%    +362.5%     206428        softirqs.CPU166.SCHED
>      57704 � 17%    +395.9%     286158 � 10%  softirqs.CPU167.RCU
>      45202 �  2%    +356.6%     206389 �  2%  softirqs.CPU167.SCHED
>      55062 � 14%    +354.5%     250266 � 17%  softirqs.CPU168.RCU
>      42774 � 17%    +348.3%     191774 � 18%  softirqs.CPU168.SCHED
>      51581 � 16%    +352.2%     233273 � 12%  softirqs.CPU169.RCU
>      45634 �  3%    +357.5%     208756        softirqs.CPU169.SCHED
>     109.33 �150%   +2088.3%       2392 �157%  softirqs.CPU169.TIMER
>      51076 �  8%    +400.3%     255559 � 22%  softirqs.CPU17.RCU
>      43946 �  8%    +355.4%     200130 �  3%  softirqs.CPU17.SCHED
>      49451 � 11%    +385.0%     239833 � 13%  softirqs.CPU170.RCU
>      45525 �  3%    +357.1%     208092        softirqs.CPU170.SCHED
>      57199 � 17%    +349.3%     257006 �  9%  softirqs.CPU171.RCU
>      45644 �  3%    +355.7%     208002        softirqs.CPU171.SCHED
>      17.67 � 42%  +36935.8%       6543 �219%  softirqs.CPU171.TIMER
>      55843 � 18%    +347.9%     250126 �  8%  softirqs.CPU172.RCU
>      45312 �  4%    +358.8%     207902        softirqs.CPU172.SCHED
>      56791 � 17%    +357.4%     259792 �  8%  softirqs.CPU173.RCU
>      45497 �  3%    +356.9%     207893        softirqs.CPU173.SCHED
>      56186 � 17%    +357.9%     257270 �  9%  softirqs.CPU174.RCU
>      45426 �  3%    +357.6%     207862        softirqs.CPU174.SCHED
>      54313 � 14%    +354.2%     246718 �  8%  softirqs.CPU175.RCU
>      45485 �  3%    +356.4%     207576        softirqs.CPU175.SCHED
>      57429 � 18%    +392.5%     282841 � 17%  softirqs.CPU176.RCU
>      45934 �  3%    +352.6%     207919        softirqs.CPU176.SCHED
>      57061 � 13%    +377.7%     272553 � 14%  softirqs.CPU177.RCU
>      45238 �  4%    +359.9%     208050        softirqs.CPU177.SCHED
>      59204 � 16%    +390.7%     290508 � 11%  softirqs.CPU178.RCU
>      44756 �  4%    +364.7%     207983        softirqs.CPU178.SCHED
>      61089 � 16%    +381.9%     294400 � 12%  softirqs.CPU179.RCU
>      45622 �  3%    +356.1%     208097        softirqs.CPU179.SCHED
>      53248 �  7%    +389.6%     260710 � 20%  softirqs.CPU18.RCU
>      42303 � 15%    +380.1%     203100 �  3%  softirqs.CPU18.SCHED
>      56495 � 11%    +381.1%     271819 � 12%  softirqs.CPU180.RCU
>      45165 �  4%    +324.4%     191661 � 18%  softirqs.CPU180.SCHED
>      56109 � 12%    +374.0%     265983 � 12%  softirqs.CPU181.RCU
>      45113 �  3%    +360.7%     207829        softirqs.CPU181.SCHED
>      61889 � 16%    +361.8%     285815 �  9%  softirqs.CPU182.RCU
>      45606 �  3%    +356.1%     208024        softirqs.CPU182.SCHED
>      57114 � 11%    +389.6%     279620 � 16%  softirqs.CPU183.RCU
>      45233 �  4%    +344.6%     201088 �  7%  softirqs.CPU183.SCHED
>      61548 � 15%    +375.1%     292441 � 12%  softirqs.CPU184.RCU
>      45836 �  2%    +360.2%     210937 �  3%  softirqs.CPU184.SCHED
>      63265 � 17%    +376.7%     301557 � 13%  softirqs.CPU185.RCU
>      45427 �  3%    +387.2%     221324 � 14%  softirqs.CPU185.SCHED
>      55427 �  8%    +393.6%     273596 � 19%  softirqs.CPU186.RCU
>      45019 �  5%    +371.4%     212211 �  4%  softirqs.CPU186.SCHED
>      61836 � 16%    +375.6%     294062 � 18%  softirqs.CPU187.RCU
>      45495 �  4%    +389.6%     222739 � 14%  softirqs.CPU187.SCHED
>      63091 � 18%    +363.7%     292538 � 17%  softirqs.CPU188.RCU
>      45246 �  3%    +369.7%     212530 �  4%  softirqs.CPU188.SCHED
>      60039 � 14%    +365.2%     279312 � 15%  softirqs.CPU189.RCU
>      45293 �  3%    +372.8%     214132 �  6%  softirqs.CPU189.SCHED
>      49889 �  7%    +395.7%     247286 � 23%  softirqs.CPU19.RCU
>      44310 �  4%    +356.3%     202195        softirqs.CPU19.SCHED
>      61474 � 17%    +369.3%     288500 � 23%  softirqs.CPU190.RCU
>      45783 �  3%    +395.9%     227022 � 18%  softirqs.CPU190.SCHED
>      56580 � 15%    +392.8%     278821 � 13%  softirqs.CPU191.RCU
>      38811 � 25%    +284.3%     149137 � 26%  softirqs.CPU191.SCHED
>      68047 �  9%    +304.3%     275101 � 22%  softirqs.CPU2.RCU
>      45157 � 18%    +355.3%     205616 �  4%  softirqs.CPU2.SCHED
>      51325 �  2%    +392.8%     252926 � 22%  softirqs.CPU20.RCU
>      44653 �  4%    +347.1%     199634 �  3%  softirqs.CPU20.SCHED
>      50340 �  7%    +386.5%     244919 � 20%  softirqs.CPU21.RCU
>      41791 � 16%    +371.4%     197016 �  3%  softirqs.CPU21.SCHED
>      51067 �  8%    +390.5%     250469 � 22%  softirqs.CPU22.RCU
>      42769 � 14%    +366.6%     199543 �  3%  softirqs.CPU22.SCHED
>      51188 �  6%    +387.8%     249670 � 24%  softirqs.CPU23.RCU
>      44890 �  3%    +345.1%     199786 �  3%  softirqs.CPU23.SCHED
>      52297 � 10%    +357.2%     239089 � 16%  softirqs.CPU24.RCU
>      46179 �  2%    +348.4%     207072 �  3%  softirqs.CPU24.SCHED
>      47969 � 10%    +360.0%     220664 � 14%  softirqs.CPU25.RCU
>      45420 �  3%    +351.8%     205216 �  2%  softirqs.CPU25.SCHED
>      82.33 �127%   +6649.8%       5557 �137%  softirqs.CPU25.TIMER
>      49379 � 10%    +358.5%     226384 � 14%  softirqs.CPU26.RCU
>      45515 �  3%    +357.8%     208350 �  4%  softirqs.CPU26.SCHED
>      20.50 � 97%  +33919.5%       6974 �139%  softirqs.CPU26.TIMER
>      55152 � 11%    +329.1%     236637 � 14%  softirqs.CPU27.RCU
>      45778 �  3%    +349.3%     205684 �  2%  softirqs.CPU27.SCHED
>      54946 � 12%    +337.3%     240300 � 13%  softirqs.CPU28.RCU
>      42795 � 11%    +383.6%     206975 �  2%  softirqs.CPU28.SCHED
>      55072 � 13%    +317.2%     229748 � 10%  softirqs.CPU29.RCU
>      46681 �  5%    +341.5%     206110        softirqs.CPU29.SCHED
>      64262 �  6%    +353.4%     291339 � 21%  softirqs.CPU3.RCU
>      45244 �  3%    +352.0%     204498 �  4%  softirqs.CPU3.SCHED
>      52963 � 10%    +330.5%     228029 � 14%  softirqs.CPU30.RCU
>      44973 �  3%    +364.7%     209004 �  5%  softirqs.CPU30.SCHED
>      47012 � 15%    +360.5%     216483 � 15%  softirqs.CPU31.RCU
>      48839 � 12%    +320.1%     205164 �  3%  softirqs.CPU31.SCHED
>      62062 �  9%    +344.0%     275539 � 14%  softirqs.CPU32.RCU
>      44656 �  3%    +359.3%     205125 �  2%  softirqs.CPU32.SCHED
>      64600 � 14%    +318.1%     270075 � 17%  softirqs.CPU33.RCU
>      44995 �  3%    +356.5%     205428 �  2%  softirqs.CPU33.SCHED
>      62063 � 11%    +358.6%     284614 � 11%  softirqs.CPU34.RCU
>      46874 �  6%    +336.9%     204784 �  2%  softirqs.CPU34.SCHED
>      64581 � 13%    +353.8%     293098 � 11%  softirqs.CPU35.RCU
>      46826 �  7%    +342.6%     207236 �  3%  softirqs.CPU35.SCHED
>      62382 � 14%    +378.1%     298226 � 11%  softirqs.CPU36.RCU
>      49083 � 16%    +319.3%     205786 �  2%  softirqs.CPU36.SCHED
>      58767 �  6%    +359.5%     270030 � 12%  softirqs.CPU37.RCU
>      45319 �  3%    +350.7%     204245 �  2%  softirqs.CPU37.SCHED
>      61252 �  9%    +353.6%     277816 � 10%  softirqs.CPU38.RCU
>      45140 �  3%    +352.4%     204200 �  2%  softirqs.CPU38.SCHED
>      64814 � 14%    +345.4%     288672 �  8%  softirqs.CPU39.RCU
>      45445 �  3%    +352.5%     205627 �  2%  softirqs.CPU39.SCHED
>      72447 � 15%    +322.2%     305901 � 18%  softirqs.CPU4.RCU
>      48515 �  3%    +438.5%     261238 � 11%  softirqs.CPU4.SCHED
>      60628 �  8%    +360.2%     278994 � 10%  softirqs.CPU40.RCU
>      44990 �  3%    +358.8%     206425 �  3%  softirqs.CPU40.SCHED
>      66477 � 14%    +356.4%     303430 � 11%  softirqs.CPU41.RCU
>      45648 �  3%    +354.4%     207413 �  3%  softirqs.CPU41.SCHED
>      67773 � 17%    +326.5%     289049 � 19%  softirqs.CPU42.RCU
>      42284 � 15%    +386.9%     205884        softirqs.CPU42.SCHED
>      66206 � 14%    +336.1%     288703 � 13%  softirqs.CPU43.RCU
>      45434 �  3%    +351.9%     205307 �  2%  softirqs.CPU43.SCHED
>      11.67 � 25%  +46575.7%       5445 �194%  softirqs.CPU43.TIMER
>      66411 � 16%    +344.1%     294945 � 11%  softirqs.CPU44.RCU
>      45627 �  2%    +351.2%     205878        softirqs.CPU44.SCHED
>      63997 � 12%    +352.1%     289319 � 10%  softirqs.CPU45.RCU
>      45702 �  3%    +349.2%     205309 �  2%  softirqs.CPU45.SCHED
>      66475 � 16%    +354.3%     302004 � 11%  softirqs.CPU46.RCU
>      45399 �  4%    +353.2%     205728 �  2%  softirqs.CPU46.SCHED
>      64940 � 13%    +338.2%     284588 � 15%  softirqs.CPU47.RCU
>      45948 �  3%    +347.1%     205433 �  2%  softirqs.CPU47.SCHED
>      60645 � 17%    +359.7%     278803 � 20%  softirqs.CPU48.RCU
>      45368 �  2%    +353.2%     205613 �  2%  softirqs.CPU48.SCHED
>      59256 � 12%    +360.7%     272994 � 16%  softirqs.CPU49.RCU
>      45210 �  3%    +354.9%     205646 �  2%  softirqs.CPU49.SCHED
>      68114 � 14%    +327.1%     290884 � 20%  softirqs.CPU5.RCU
>      56403 � 51%    +245.9%     195106 � 17%  softirqs.CPU5.SCHED
>      57773 �  9%    +361.9%     266846 � 16%  softirqs.CPU50.RCU
>      42648 � 16%    +381.4%     205329 �  2%  softirqs.CPU50.SCHED
>      63894 � 16%    +354.5%     290411 � 12%  softirqs.CPU51.RCU
>      45821 �  4%    +345.1%     203948 �  3%  softirqs.CPU51.SCHED
>      62871 � 17%    +357.0%     287303 � 12%  softirqs.CPU52.RCU
>      45508 �  2%    +352.9%     206120        softirqs.CPU52.SCHED
>      67967 � 15%    +324.9%     288781 � 12%  softirqs.CPU53.RCU
>      47032 � 10%    +303.8%     189894 � 19%  softirqs.CPU53.SCHED
>      65244 � 15%    +333.5%     282855 � 12%  softirqs.CPU54.RCU
>      45663 �  3%    +347.0%     204113 �  3%  softirqs.CPU54.SCHED
>      59563 � 16%    +390.3%     292045 � 13%  softirqs.CPU55.RCU
>      45424 �  3%    +352.5%     205550 �  2%  softirqs.CPU55.SCHED
>      68697 � 16%    +336.1%     299594 � 11%  softirqs.CPU56.RCU
>      47117 � 11%    +337.2%     206013        softirqs.CPU56.SCHED
>      62397 � 12%    +363.5%     289229 � 14%  softirqs.CPU57.RCU
>      42533 � 12%    +344.9%     189219 � 18%  softirqs.CPU57.SCHED
>      64451 � 16%    +376.4%     307026 � 11%  softirqs.CPU58.RCU
>      45128 �  4%    +354.9%     205272        softirqs.CPU58.SCHED
>      67900 � 14%    +353.2%     307718 � 10%  softirqs.CPU59.RCU
>      46343 �  8%    +345.0%     206239        softirqs.CPU59.SCHED
>      63234 �  6%    +356.1%     288392 � 22%  softirqs.CPU6.RCU
>      44442 �  7%    +359.3%     204137 �  4%  softirqs.CPU6.SCHED
>      59115 �  9%    +378.5%     282874 � 16%  softirqs.CPU60.RCU
>      45396 �  3%    +352.0%     205203 �  2%  softirqs.CPU60.SCHED
>      59494 �  9%    +368.0%     278421 � 14%  softirqs.CPU61.RCU
>      45655 �  3%    +349.7%     205298 �  2%  softirqs.CPU61.SCHED
>      65960 � 14%    +341.6%     291281 � 11%  softirqs.CPU62.RCU
>      46434 �  6%    +344.1%     206206        softirqs.CPU62.SCHED
>      61572 � 10%    +339.5%     270610 � 20%  softirqs.CPU63.RCU
>      40841 � 19%    +403.7%     205723 �  2%  softirqs.CPU63.SCHED
>      64.83 �124%   +8867.4%       5813 �162%  softirqs.CPU63.TIMER
>      55899 � 17%    +402.1%     280642 � 10%  softirqs.CPU64.RCU
>      45271 �  3%    +354.9%     205920 �  2%  softirqs.CPU64.SCHED
>      56599 � 19%    +404.9%     285780 �  9%  softirqs.CPU65.RCU
>      45115 �  3%    +357.2%     206261        softirqs.CPU65.SCHED
>      50803 � 16%    +402.1%     255070 � 20%  softirqs.CPU66.RCU
>      45109 �  2%    +355.2%     205323 �  2%  softirqs.CPU66.SCHED
>      57587 � 17%    +387.2%     280551 � 11%  softirqs.CPU67.RCU
>      44830 �  2%    +359.2%     205864 �  2%  softirqs.CPU67.SCHED
>      58698 � 20%    +392.8%     289238 �  9%  softirqs.CPU68.RCU
>      45091 �  3%    +357.3%     206205        softirqs.CPU68.SCHED
>      55763 � 16%    +391.3%     273967 � 13%  softirqs.CPU69.RCU
>      45122 �  2%    +356.5%     205996 �  2%  softirqs.CPU69.SCHED
>      67476 � 16%    +369.9%     317099 � 15%  softirqs.CPU7.RCU
>      46833 �  5%    +389.0%     229008 � 27%  softirqs.CPU7.SCHED
>      58868 � 17%    +376.5%     280531 � 17%  softirqs.CPU70.RCU
>      45317 �  2%    +354.2%     205815        softirqs.CPU70.SCHED
>      58439 � 18%    +395.2%     289404 � 10%  softirqs.CPU71.RCU
>      44994 �  3%    +358.1%     206131 �  2%  softirqs.CPU71.SCHED
>      56194 � 14%    +369.1%     263625 � 15%  softirqs.CPU72.RCU
>      45606 �  2%    +365.5%     212316 �  4%  softirqs.CPU72.SCHED
>      53492 � 15%    +384.8%     259308 � 18%  softirqs.CPU73.RCU
>      42384 � 18%    +431.9%     225421 � 17%  softirqs.CPU73.SCHED
>      50421 � 11%    +406.3%     255290 � 15%  softirqs.CPU74.RCU
>      45056 �  3%    +365.8%     209866 �  3%  softirqs.CPU74.SCHED
>      58777 � 18%    +365.5%     273592 �  8%  softirqs.CPU75.RCU
>      41914 � 18%    +399.4%     209311 �  2%  softirqs.CPU75.SCHED
>      57403 � 17%    +370.0%     269822 � 10%  softirqs.CPU76.RCU
>      45059 �  3%    +385.7%     218874 � 13%  softirqs.CPU76.SCHED
>      58353 � 16%    +361.4%     269221 �  8%  softirqs.CPU77.RCU
>      45602 �  2%    +355.4%     207662 �  2%  softirqs.CPU77.SCHED
>      57557 � 17%    +361.9%     265888 �  8%  softirqs.CPU78.RCU
>      45130 �  3%    +360.3%     207718        softirqs.CPU78.SCHED
>      55270 � 15%    +382.6%     266740 � 13%  softirqs.CPU79.RCU
>      45451 �  3%    +375.0%     215880 �  9%  softirqs.CPU79.SCHED
>      63442 � 14%    +344.3%     281856 � 23%  softirqs.CPU8.RCU
>      45979 �  9%    +338.6%     201664 �  7%  softirqs.CPU8.SCHED
>      60531 � 15%    +351.2%     273091 � 13%  softirqs.CPU80.RCU
>      45469 �  2%    +356.2%     207450        softirqs.CPU80.SCHED
>      57455 � 14%    +380.5%     276047 � 14%  softirqs.CPU81.RCU
>      45116 �  2%    +359.3%     207237        softirqs.CPU81.SCHED
>      61087 � 16%    +395.8%     302853 � 14%  softirqs.CPU82.RCU
>      45382 �  2%    +369.5%     213085 �  5%  softirqs.CPU82.SCHED
>      62548 � 16%    +387.7%     305020 � 13%  softirqs.CPU83.RCU
>      45310 �  2%    +356.8%     206982        softirqs.CPU83.SCHED
>      57140 � 11%    +384.5%     276871 � 12%  softirqs.CPU84.RCU
>      45086 �  3%    +360.7%     207726        softirqs.CPU84.SCHED
>      57323 � 12%    +380.8%     275640 � 13%  softirqs.CPU85.RCU
>      44947 �  3%    +367.6%     210170 �  3%  softirqs.CPU85.SCHED
>      61528 � 23%    +379.2%     294822 �  9%  softirqs.CPU86.RCU
>      44995 �  3%    +359.1%     206572        softirqs.CPU86.SCHED
>      57346 � 11%    +389.3%     280586 � 16%  softirqs.CPU87.RCU
>      45045 �  3%    +365.4%     209654 �  3%  softirqs.CPU87.SCHED
>      62158 � 16%    +363.4%     288048 � 10%  softirqs.CPU88.RCU
>      45696 �  3%    +353.3%     207149        softirqs.CPU88.SCHED
>      63807 � 17%    +362.8%     295316 � 10%  softirqs.CPU89.RCU
>      44745 �  3%    +362.3%     206843        softirqs.CPU89.SCHED
>      60946 �  9%    +379.3%     292107 � 21%  softirqs.CPU9.RCU
>      45163 �  6%    +319.5%     189443 � 16%  softirqs.CPU9.SCHED
>      56147 �  9%    +389.5%     274854 � 18%  softirqs.CPU90.RCU
>      45042 �  3%    +358.9%     206712        softirqs.CPU90.SCHED
>      63372 � 16%    +352.6%     286837 � 12%  softirqs.CPU91.RCU
>      44906 �  3%    +361.6%     207303        softirqs.CPU91.SCHED
>      63607 � 17%    +366.1%     296504 � 15%  softirqs.CPU92.RCU
>      45203 �  3%    +358.6%     207307        softirqs.CPU92.SCHED
>      60249 � 14%    +363.4%     279200 � 14%  softirqs.CPU93.RCU
>      45105 �  4%    +359.6%     207292        softirqs.CPU93.SCHED
>      63877 � 16%    +341.6%     282102 � 18%  softirqs.CPU94.RCU
>      45311 �  3%    +320.0%     190313 � 18%  softirqs.CPU94.SCHED
>      59543 � 15%    +376.4%     283663 � 14%  softirqs.CPU95.RCU
>      23940 � 15%    +553.1%     156351 � 36%  softirqs.CPU95.SCHED
>      58260 �  8%    +356.8%     266158 � 27%  softirqs.CPU96.RCU
>      41169 � 11%    +363.7%     190900 �  5%  softirqs.CPU96.SCHED
>      54490 � 11%    +388.3%     266082 � 24%  softirqs.CPU97.RCU
>      44509 �  5%    +344.1%     197655 �  3%  softirqs.CPU97.SCHED
>      58098 � 10%    +367.1%     271353 � 24%  softirqs.CPU98.RCU
>      43164 �  6%    +315.5%     179359 � 16%  softirqs.CPU98.SCHED
>      58008 �  9%    +391.1%     284903 � 24%  softirqs.CPU99.RCU
>      44783 �  5%    +332.6%     193736 �  3%  softirqs.CPU99.SCHED
>      20297 � 52%    +243.9%      69801 � 33%  softirqs.NET_RX
>   11324902 � 10%    +366.3%   52803478 � 11%  softirqs.RCU
>    8624664 �  3%    +357.9%   39489702        softirqs.SCHED
>      64250 �  2%    +284.5%     247050 �  5%  softirqs.TIMER
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 5.16.0-rc8 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23502
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_IRQ_MSI_IOMMU=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_CONTEXT_TRACKING=y
> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> CONFIG_BPF_JIT_DEFAULT_ON=y
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> # CONFIG_BPF_PRELOAD is not set
> # CONFIG_BPF_LSM is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_PREEMPT_DYNAMIC is not set
> # CONFIG_SCHED_CORE is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # end of RCU Subsystem
> 
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> CONFIG_RT_GROUP_SCHED=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_X2APIC=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=y
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_CLUSTER=y
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> CONFIG_X86_MCE_INJECT=m
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=m
> CONFIG_PERF_EVENTS_INTEL_RAPL=m
> CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=y
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_I8K=m
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> # CONFIG_AMD_MEM_ENCRYPT is not set
> CONFIG_NUMA=y
> # CONFIG_AMD_NUMA is not set
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NUMA_EMU=y
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=m
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_X86_SGX is not set
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_MIXED=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> CONFIG_ACPI_EC_DEBUGFS=m
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_TAD=m
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_PLATFORM_PROFILE=m
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=m
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=y
> CONFIG_ACPI_NFIT=m
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_HMAT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> CONFIG_ACPI_APEI_EINJ=m
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_WATCHDOG=y
> CONFIG_ACPI_EXTLOG=m
> CONFIG_ACPI_ADXL=y
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_PMIC_OPREGION=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_ACPI_PRMT=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> CONFIG_X86_ACPI_CPUFREQ=m
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=m
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=m
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=m
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_HAVE_KVM_PM_NOTIFIER=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=m
> CONFIG_KVM_INTEL=m
> # CONFIG_KVM_AMD is not set
> # CONFIG_KVM_XEN is not set
> CONFIG_KVM_MMU_AUDIT=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=y
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha256"
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=m
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_DEV_THROTTLING=y
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_MQ=y
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=y
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> CONFIG_BLOCK_HOLDER_DEPRECATED=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> CONFIG_BFQ_GROUP_IOSCHED=y
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_MHP_MEMMAP_ON_MEMORY=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=m
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_CLEANCACHE=y
> CONFIG_FRONTSWAP=y
> # CONFIG_CMA is not set
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ZONE_DMA=y
> CONFIG_ZONE_DMA32=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_DEV_PAGEMAP_OPS=y
> CONFIG_DEVICE_PRIVATE=y
> CONFIG_VMAP_PFN=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_SECRETMEM=y
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=m
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> CONFIG_UNIX_DIAG=m
> CONFIG_TLS=m
> CONFIG_TLS_DEVICE=y
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_OFFLOAD=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> CONFIG_XFRM_SUB_POLICY=y
> CONFIG_XFRM_MIGRATE=y
> CONFIG_XFRM_STATISTICS=y
> CONFIG_XFRM_AH=m
> CONFIG_XFRM_ESP=m
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_KEY=m
> CONFIG_NET_KEY_MIGRATE=y
> CONFIG_XDP_SOCKETS=y
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE_DEMUX=m
> CONFIG_NET_IP_TUNNEL=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> CONFIG_NET_IPVTI=m
> CONFIG_NET_UDP_TUNNEL=m
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_ESP_OFFLOAD=m
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_DIAG=m
> CONFIG_INET_TCP_DIAG=m
> CONFIG_INET_UDP_DIAG=m
> CONFIG_INET_RAW_DIAG=m
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> CONFIG_TCP_CONG_BIC=m
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_TCP_CONG_WESTWOOD=m
> CONFIG_TCP_CONG_HTCP=m
> CONFIG_TCP_CONG_HSTCP=m
> CONFIG_TCP_CONG_HYBLA=m
> CONFIG_TCP_CONG_VEGAS=m
> CONFIG_TCP_CONG_NV=m
> CONFIG_TCP_CONG_SCALABLE=m
> CONFIG_TCP_CONG_LP=m
> CONFIG_TCP_CONG_VENO=m
> CONFIG_TCP_CONG_YEAH=m
> CONFIG_TCP_CONG_ILLINOIS=m
> CONFIG_TCP_CONG_DCTCP=m
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=m
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> CONFIG_IPV6_OPTIMISTIC_DAD=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_ESP_OFFLOAD=m
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_MIP6=m
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=m
> CONFIG_INET6_TUNNEL=m
> CONFIG_IPV6_VTI=m
> CONFIG_IPV6_SIT=m
> CONFIG_IPV6_SIT_6RD=y
> CONFIG_IPV6_NDISC_NODETYPE=y
> CONFIG_IPV6_TUNNEL=m
> CONFIG_IPV6_GRE=m
> CONFIG_IPV6_MULTIPLE_TABLES=y
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=y
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=m
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_EGRESS=y
> CONFIG_NETFILTER_SKIP_EGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NETFILTER_NETLINK_OSF=m
> CONFIG_NF_CONNTRACK=m
> CONFIG_NF_LOG_SYSLOG=m
> CONFIG_NETFILTER_CONNCOUNT=m
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> CONFIG_NF_CONNTRACK_ZONES=y
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CONNTRACK_TIMEOUT=y
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> CONFIG_NF_CONNTRACK_LABELS=y
> CONFIG_NF_CT_PROTO_DCCP=y
> CONFIG_NF_CT_PROTO_GRE=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> CONFIG_NF_CONNTRACK_AMANDA=m
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_H323=m
> CONFIG_NF_CONNTRACK_IRC=m
> CONFIG_NF_CONNTRACK_BROADCAST=m
> CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> CONFIG_NF_CONNTRACK_SNMP=m
> CONFIG_NF_CONNTRACK_PPTP=m
> CONFIG_NF_CONNTRACK_SANE=m
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CONNTRACK_TFTP=m
> CONFIG_NF_CT_NETLINK=m
> CONFIG_NF_CT_NETLINK_TIMEOUT=m
> CONFIG_NF_CT_NETLINK_HELPER=m
> CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_AMANDA=m
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_SIP=m
> CONFIG_NF_NAT_TFTP=m
> CONFIG_NF_NAT_REDIRECT=y
> CONFIG_NF_NAT_MASQUERADE=y
> CONFIG_NETFILTER_SYNPROXY=m
> CONFIG_NF_TABLES=m
> CONFIG_NF_TABLES_INET=y
> CONFIG_NF_TABLES_NETDEV=y
> CONFIG_NFT_NUMGEN=m
> CONFIG_NFT_CT=m
> CONFIG_NFT_COUNTER=m
> CONFIG_NFT_CONNLIMIT=m
> CONFIG_NFT_LOG=m
> CONFIG_NFT_LIMIT=m
> CONFIG_NFT_MASQ=m
> CONFIG_NFT_REDIR=m
> CONFIG_NFT_NAT=m
> # CONFIG_NFT_TUNNEL is not set
> CONFIG_NFT_OBJREF=m
> CONFIG_NFT_QUEUE=m
> CONFIG_NFT_QUOTA=m
> CONFIG_NFT_REJECT=m
> CONFIG_NFT_REJECT_INET=m
> CONFIG_NFT_COMPAT=m
> CONFIG_NFT_HASH=m
> CONFIG_NFT_FIB=m
> CONFIG_NFT_FIB_INET=m
> # CONFIG_NFT_XFRM is not set
> CONFIG_NFT_SOCKET=m
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> CONFIG_NF_DUP_NETDEV=m
> CONFIG_NFT_DUP_NETDEV=m
> CONFIG_NFT_FWD_NETDEV=m
> CONFIG_NFT_FIB_NETDEV=m
> # CONFIG_NFT_REJECT_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=y
> CONFIG_NETFILTER_XTABLES_COMPAT=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
> CONFIG_NETFILTER_XT_CONNMARK=m
> CONFIG_NETFILTER_XT_SET=m
> 
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=m
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> CONFIG_NETFILTER_XT_TARGET_CT=m
> CONFIG_NETFILTER_XT_TARGET_DSCP=m
> CONFIG_NETFILTER_XT_TARGET_HL=m
> CONFIG_NETFILTER_XT_TARGET_HMARK=m
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=m
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_NAT=m
> CONFIG_NETFILTER_XT_TARGET_NETMAP=m
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
> CONFIG_NETFILTER_XT_TARGET_RATEEST=m
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> CONFIG_NETFILTER_XT_TARGET_TEE=m
> CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> CONFIG_NETFILTER_XT_TARGET_TRACE=m
> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> CONFIG_NETFILTER_XT_MATCH_BPF=m
> CONFIG_NETFILTER_XT_MATCH_CGROUP=m
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> CONFIG_NETFILTER_XT_MATCH_CPU=m
> CONFIG_NETFILTER_XT_MATCH_DCCP=m
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
> CONFIG_NETFILTER_XT_MATCH_DSCP=m
> CONFIG_NETFILTER_XT_MATCH_ECN=m
> CONFIG_NETFILTER_XT_MATCH_ESP=m
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_HELPER=m
> CONFIG_NETFILTER_XT_MATCH_HL=m
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> CONFIG_NETFILTER_XT_MATCH_IPVS=m
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> CONFIG_NETFILTER_XT_MATCH_MAC=m
> CONFIG_NETFILTER_XT_MATCH_MARK=m
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=m
> CONFIG_NETFILTER_XT_MATCH_OWNER=m
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> CONFIG_NETFILTER_XT_MATCH_RATEEST=m
> CONFIG_NETFILTER_XT_MATCH_REALM=m
> CONFIG_NETFILTER_XT_MATCH_RECENT=m
> CONFIG_NETFILTER_XT_MATCH_SCTP=m
> CONFIG_NETFILTER_XT_MATCH_SOCKET=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> CONFIG_NETFILTER_XT_MATCH_STRING=m
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=m
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=m
> CONFIG_IP_SET_BITMAP_IPMAC=m
> CONFIG_IP_SET_BITMAP_PORT=m
> CONFIG_IP_SET_HASH_IP=m
> CONFIG_IP_SET_HASH_IPMARK=m
> CONFIG_IP_SET_HASH_IPPORT=m
> CONFIG_IP_SET_HASH_IPPORTIP=m
> CONFIG_IP_SET_HASH_IPPORTNET=m
> CONFIG_IP_SET_HASH_IPMAC=m
> CONFIG_IP_SET_HASH_MAC=m
> CONFIG_IP_SET_HASH_NETPORTNET=m
> CONFIG_IP_SET_HASH_NET=m
> CONFIG_IP_SET_HASH_NETNET=m
> CONFIG_IP_SET_HASH_NETPORT=m
> CONFIG_IP_SET_HASH_NETIFACE=m
> CONFIG_IP_SET_LIST_SET=m
> CONFIG_IP_VS=m
> CONFIG_IP_VS_IPV6=y
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
> CONFIG_IP_VS_PROTO_SCTP=y
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_FO=m
> CONFIG_IP_VS_OVF=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> # CONFIG_IP_VS_TWOS is not set
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=m
> CONFIG_IP_VS_NFCT=y
> CONFIG_IP_VS_PE_SIP=m
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=m
> CONFIG_NF_SOCKET_IPV4=m
> CONFIG_NF_TPROXY_IPV4=m
> CONFIG_NF_TABLES_IPV4=y
> CONFIG_NFT_REJECT_IPV4=m
> CONFIG_NFT_DUP_IPV4=m
> CONFIG_NFT_FIB_IPV4=m
> CONFIG_NF_TABLES_ARP=y
> CONFIG_NF_DUP_IPV4=m
> CONFIG_NF_LOG_ARP=m
> CONFIG_NF_LOG_IPV4=m
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_NF_NAT_SNMP_BASIC=m
> CONFIG_NF_NAT_PPTP=m
> CONFIG_NF_NAT_H323=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_AH=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_RPFILTER=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_SYNPROXY=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_TTL=m
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_SECURITY=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=m
> CONFIG_NF_TPROXY_IPV6=m
> CONFIG_NF_TABLES_IPV6=y
> CONFIG_NFT_REJECT_IPV6=m
> CONFIG_NFT_DUP_IPV6=m
> CONFIG_NFT_FIB_IPV6=m
> CONFIG_NF_DUP_IPV6=m
> CONFIG_NF_REJECT_IPV6=m
> CONFIG_NF_LOG_IPV6=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_AH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_MH=m
> CONFIG_IP6_NF_MATCH_RPFILTER=m
> CONFIG_IP6_NF_MATCH_RT=m
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> CONFIG_IP6_NF_TARGET_SYNPROXY=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_RAW=m
> CONFIG_IP6_NF_SECURITY=m
> CONFIG_IP6_NF_NAT=m
> CONFIG_IP6_NF_TARGET_MASQUERADE=m
> CONFIG_IP6_NF_TARGET_NPT=m
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=m
> CONFIG_NF_TABLES_BRIDGE=m
> # CONFIG_NFT_BRIDGE_META is not set
> CONFIG_NFT_BRIDGE_REJECT=m
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES=m
> CONFIG_BRIDGE_EBT_BROUTE=m
> CONFIG_BRIDGE_EBT_T_FILTER=m
> CONFIG_BRIDGE_EBT_T_NAT=m
> CONFIG_BRIDGE_EBT_802_3=m
> CONFIG_BRIDGE_EBT_AMONG=m
> CONFIG_BRIDGE_EBT_ARP=m
> CONFIG_BRIDGE_EBT_IP=m
> CONFIG_BRIDGE_EBT_IP6=m
> CONFIG_BRIDGE_EBT_LIMIT=m
> CONFIG_BRIDGE_EBT_MARK=m
> CONFIG_BRIDGE_EBT_PKTTYPE=m
> CONFIG_BRIDGE_EBT_STP=m
> CONFIG_BRIDGE_EBT_VLAN=m
> CONFIG_BRIDGE_EBT_ARPREPLY=m
> CONFIG_BRIDGE_EBT_DNAT=m
> CONFIG_BRIDGE_EBT_MARK_T=m
> CONFIG_BRIDGE_EBT_REDIRECT=m
> CONFIG_BRIDGE_EBT_SNAT=m
> CONFIG_BRIDGE_EBT_LOG=m
> CONFIG_BRIDGE_EBT_NFLOG=m
> # CONFIG_BPFILTER is not set
> CONFIG_IP_DCCP=y
> CONFIG_INET_DCCP_DIAG=m
> 
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=y
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=y
> # end of DCCP CCIDs Configuration
> 
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> # end of DCCP Kernel Hacking
> 
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> CONFIG_SCTP_COOKIE_HMAC_SHA1=y
> CONFIG_INET_SCTP_DIAG=m
> # CONFIG_RDS is not set
> CONFIG_TIPC=m
> CONFIG_TIPC_MEDIA_UDP=y
> CONFIG_TIPC_CRYPTO=y
> CONFIG_TIPC_DIAG=m
> CONFIG_ATM=m
> CONFIG_ATM_CLIP=m
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=m
> # CONFIG_ATM_MPOA is not set
> CONFIG_ATM_BR2684=m
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=m
> CONFIG_L2TP_DEBUGFS=m
> CONFIG_L2TP_V3=y
> CONFIG_L2TP_IP=m
> CONFIG_L2TP_ETH=m
> CONFIG_STP=m
> CONFIG_GARP=m
> CONFIG_MRP=m
> CONFIG_BRIDGE=m
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_BRIDGE_VLAN_FILTERING=y
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=m
> CONFIG_VLAN_8021Q_GVRP=y
> CONFIG_VLAN_8021Q_MVRP=y
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> CONFIG_6LOWPAN=m
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> CONFIG_IEEE802154=m
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=m
> CONFIG_IEEE802154_6LOWPAN=m
> CONFIG_MAC802154=m
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_ATM=m
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_MULTIQ=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFB=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> CONFIG_NET_SCH_NETEM=m
> CONFIG_NET_SCH_DRR=m
> CONFIG_NET_SCH_MQPRIO=m
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=m
> CONFIG_NET_SCH_QFQ=m
> CONFIG_NET_SCH_CODEL=m
> CONFIG_NET_SCH_FQ_CODEL=y
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=m
> CONFIG_NET_SCH_HHF=m
> CONFIG_NET_SCH_PIE=m
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_SCH_PLUG=m
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=y
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_CODEL is not set
> CONFIG_DEFAULT_FQ_CODEL=y
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH="fq_codel"
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=m
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> CONFIG_NET_CLS_FLOW=m
> CONFIG_NET_CLS_CGROUP=y
> CONFIG_NET_CLS_BPF=m
> CONFIG_NET_CLS_FLOWER=m
> CONFIG_NET_CLS_MATCHALL=m
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=m
> CONFIG_NET_EMATCH_NBYTE=m
> CONFIG_NET_EMATCH_U32=m
> CONFIG_NET_EMATCH_META=m
> CONFIG_NET_EMATCH_TEXT=m
> # CONFIG_NET_EMATCH_CANID is not set
> CONFIG_NET_EMATCH_IPSET=m
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=m
> CONFIG_NET_ACT_GACT=m
> CONFIG_GACT_PROB=y
> CONFIG_NET_ACT_MIRRED=m
> CONFIG_NET_ACT_SAMPLE=m
> # CONFIG_NET_ACT_IPT is not set
> CONFIG_NET_ACT_NAT=m
> CONFIG_NET_ACT_PEDIT=m
> CONFIG_NET_ACT_SIMP=m
> CONFIG_NET_ACT_SKBEDIT=m
> CONFIG_NET_ACT_CSUM=m
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=m
> CONFIG_NET_ACT_BPF=m
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=m
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=m
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=m
> CONFIG_OPENVSWITCH_GRE=m
> CONFIG_VSOCKETS=m
> CONFIG_VSOCKETS_DIAG=m
> CONFIG_VSOCKETS_LOOPBACK=m
> CONFIG_VMWARE_VMCI_VSOCKETS=m
> CONFIG_VIRTIO_VSOCKETS=m
> CONFIG_VIRTIO_VSOCKETS_COMMON=m
> CONFIG_HYPERV_VSOCKETS=m
> CONFIG_NETLINK_DIAG=m
> CONFIG_MPLS=y
> CONFIG_NET_MPLS_GSO=y
> CONFIG_MPLS_ROUTING=m
> CONFIG_MPLS_IPTUNNEL=m
> CONFIG_NET_NSH=y
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=y
> CONFIG_NET_L3_MASTER_DEV=y
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=m
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=m
> CONFIG_CAN_RAW=m
> CONFIG_CAN_BCM=m
> CONFIG_CAN_GW=m
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
> 
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=m
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_SLCAN=m
> CONFIG_CAN_DEV=m
> CONFIG_CAN_CALC_BITTIMING=y
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_C_CAN=m
> CONFIG_CAN_C_CAN_PLATFORM=m
> CONFIG_CAN_C_CAN_PCI=m
> CONFIG_CAN_CC770=m
> # CONFIG_CAN_CC770_ISA is not set
> CONFIG_CAN_CC770_PLATFORM=m
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=m
> CONFIG_CAN_EMS_PCI=m
> # CONFIG_CAN_F81601 is not set
> CONFIG_CAN_KVASER_PCI=m
> CONFIG_CAN_PEAK_PCI=m
> CONFIG_CAN_PEAK_PCIEC=y
> CONFIG_CAN_PLX_PCI=m
> # CONFIG_CAN_SJA1000_ISA is not set
> CONFIG_CAN_SJA1000_PLATFORM=m
> CONFIG_CAN_SOFTING=m
> 
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
> 
> #
> # CAN USB interfaces
> #
> # CONFIG_CAN_8DEV_USB is not set
> # CONFIG_CAN_EMS_USB is not set
> # CONFIG_CAN_ESD_USB2 is not set
> # CONFIG_CAN_ETAS_ES58X is not set
> # CONFIG_CAN_GS_USB is not set
> # CONFIG_CAN_KVASER_USB is not set
> # CONFIG_CAN_MCBA_USB is not set
> # CONFIG_CAN_PEAK_USB is not set
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
> 
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
> 
> CONFIG_BT=m
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=m
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=m
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=m
> CONFIG_BT_HS=y
> CONFIG_BT_LE=y
> # CONFIG_BT_6LOWPAN is not set
> # CONFIG_BT_LEDS is not set
> # CONFIG_BT_MSFTEXT is not set
> # CONFIG_BT_AOSPEXT is not set
> CONFIG_BT_DEBUGFS=y
> # CONFIG_BT_SELFTEST is not set
> 
> #
> # Bluetooth device drivers
> #
> # CONFIG_BT_HCIBTUSB is not set
> # CONFIG_BT_HCIBTSDIO is not set
> CONFIG_BT_HCIUART=m
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIUART_ATH3K=y
> # CONFIG_BT_HCIUART_INTEL is not set
> # CONFIG_BT_HCIUART_AG6XX is not set
> # CONFIG_BT_HCIBCM203X is not set
> # CONFIG_BT_HCIBPA10X is not set
> # CONFIG_BT_HCIBFUSB is not set
> CONFIG_BT_HCIVHCI=m
> CONFIG_BT_MRVL=m
> # CONFIG_BT_MRVL_SDIO is not set
> # CONFIG_BT_MTKSDIO is not set
> # CONFIG_BT_VIRTIO is not set
> # end of Bluetooth device drivers
> 
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> CONFIG_CFG80211=m
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> CONFIG_CFG80211_DEFAULT_PS=y
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=y
> # CONFIG_CFG80211_WEXT is not set
> CONFIG_MAC80211=m
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> # CONFIG_MAC80211_MESH is not set
> CONFIG_MAC80211_LEDS=y
> CONFIG_MAC80211_DEBUGFS=y
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=m
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=m
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=m
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_SOCK_VALIDATE_XMIT=y
> CONFIG_NET_SELFTESTS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_FAILOVER=m
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=m
> CONFIG_PCIE_ECRC=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=m
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=y
> CONFIG_PCI_HYPERV=m
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> CONFIG_VMD=y
> CONFIG_PCI_HYPERV_INTERFACE=m
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=m
> CONFIG_REGMAP_SPI=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=m
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT is not set
> CONFIG_FW_CFG_SYSFS=y
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=y
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_APPLE_PROPERTIES=y
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> CONFIG_EFI_DEV_PATH_PARSER=y
> CONFIG_EFI_EARLYCON=y
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_SERIAL=m
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_AX88796 is not set
> CONFIG_PARPORT_1284=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=m
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=m
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=m
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=16384
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=m
> CONFIG_BLK_DEV_RBD=m
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=m
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_TIFM_CORE=m
> CONFIG_TIFM_7XX1=m
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=m
> CONFIG_SGI_XP=m
> CONFIG_HP_ILO=m
> CONFIG_SGI_GRU=m
> # CONFIG_SGI_GRU_DEBUG is not set
> CONFIG_APDS9802ALS=m
> CONFIG_ISL29003=m
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=m
> CONFIG_SENSORS_BH1770=m
> CONFIG_SENSORS_APDS990X=m
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=m
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=m
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=m
> CONFIG_EEPROM_MAX6875=m
> CONFIG_EEPROM_93CX6=m
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=m
> CONFIG_ALTERA_STAPL=m
> CONFIG_INTEL_MEI=m
> CONFIG_INTEL_MEI_ME=m
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> # CONFIG_INTEL_MEI_PXP is not set
> CONFIG_VMWARE_VMCI=m
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=m
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=m
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=m
> CONFIG_SCSI_ENCLOSURE=m
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> CONFIG_SCSI_ISCSI_ATTRS=m
> CONFIG_SCSI_SAS_ATTRS=m
> CONFIG_SCSI_SAS_LIBSAS=m
> CONFIG_SCSI_SAS_ATA=y
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_MPT3SAS=m
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_UFS_HWMON is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> CONFIG_HYPERV_STORAGE=m
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=m
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> CONFIG_SCSI_DEBUG=m
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> # CONFIG_SCSI_VIRTIO is not set
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=y
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> # end of SCSI device support
> 
> CONFIG_ATA=m
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=m
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=m
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=m
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_MD_FAULTY=m
> CONFIG_MD_CLUSTER=m
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_DEBUG=y
> CONFIG_DM_BUFIO=m
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=m
> CONFIG_DM_PERSISTENT_DATA=m
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=m
> CONFIG_DM_SNAPSHOT=m
> CONFIG_DM_THIN_PROVISIONING=m
> CONFIG_DM_CACHE=m
> CONFIG_DM_CACHE_SMQ=m
> CONFIG_DM_WRITECACHE=m
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=m
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=m
> CONFIG_DM_LOG_USERSPACE=m
> CONFIG_DM_RAID=m
> CONFIG_DM_ZERO=m
> CONFIG_DM_MULTIPATH=m
> CONFIG_DM_MULTIPATH_QL=m
> CONFIG_DM_MULTIPATH_ST=m
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=m
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=y
> CONFIG_DM_FLAKEY=m
> CONFIG_DM_VERITY=m
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=m
> CONFIG_DM_LOG_WRITES=m
> CONFIG_DM_INTEGRITY=m
> CONFIG_DM_AUDIT=y
> CONFIG_TARGET_CORE=m
> CONFIG_TCM_IBLOCK=m
> CONFIG_TCM_FILEIO=m
> CONFIG_TCM_PSCSI=m
> CONFIG_TCM_USER2=m
> CONFIG_LOOPBACK_TARGET=m
> CONFIG_ISCSI_TARGET=m
> # CONFIG_SBP_TARGET is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=m
> CONFIG_FIREWIRE_OHCI=m
> CONFIG_FIREWIRE_SBP2=m
> CONFIG_FIREWIRE_NET=m
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_AMT is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=m
> CONFIG_NETCONSOLE_DYNAMIC=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_TUN=m
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_VSOCKMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=y
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=y
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> # CONFIG_IXGBE_DCB is not set
> CONFIG_IXGBE_IPSEC=y
> # CONFIG_IXGBEVF is not set
> CONFIG_I40E=y
> # CONFIG_I40E_DCB is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> CONFIG_IGC=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_MICROSOFT_MANA is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> CONFIG_R8169=y
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> # CONFIG_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> # CONFIG_LED_TRIGGER_PHY is not set
> CONFIG_FIXED_PHY=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=y
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=y
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_FWNODE_MDIO=y
> CONFIG_ACPI_MDIO=y
> CONFIG_MDIO_DEVRES=y
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_THUNDER is not set
> 
> #
> # MDIO Multiplexers
> #
> 
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> CONFIG_USB_RTL8152=y
> # CONFIG_USB_LAN78XX is not set
> CONFIG_USB_USBNET=y
> CONFIG_USB_NET_AX8817X=y
> CONFIG_USB_NET_AX88179_178A=y
> # CONFIG_USB_NET_CDCETHER is not set
> # CONFIG_USB_NET_CDC_EEM is not set
> # CONFIG_USB_NET_CDC_NCM is not set
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> # CONFIG_USB_NET_DM9601 is not set
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> # CONFIG_USB_NET_SMSC75XX is not set
> # CONFIG_USB_NET_SMSC95XX is not set
> # CONFIG_USB_NET_GL620A is not set
> # CONFIG_USB_NET_NET1080 is not set
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_MCS7830 is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> # CONFIG_USB_NET_ZAURUS is not set
> # CONFIG_USB_NET_CX82310_ETH is not set
> # CONFIG_USB_NET_KALMIA is not set
> # CONFIG_USB_NET_QMI_WWAN is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_NET_INT51X1 is not set
> # CONFIG_USB_IPHETH is not set
> # CONFIG_USB_SIERRA_NET is not set
> # CONFIG_USB_NET_CH9200 is not set
> # CONFIG_USB_NET_AQC111 is not set
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> # CONFIG_ADM8211 is not set
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_ATH9K is not set
> # CONFIG_ATH9K_HTC is not set
> # CONFIG_CARL9170 is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> # CONFIG_ATH11K is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> # CONFIG_ATMEL is not set
> # CONFIG_AT76C50X_USB is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> # CONFIG_BRCMSMAC is not set
> # CONFIG_BRCMFMAC is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> # CONFIG_AIRO is not set
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> # CONFIG_IWLWIFI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_HERMES is not set
> # CONFIG_P54_COMMON is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> # CONFIG_MWIFIEX is not set
> # CONFIG_MWL8K is not set
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> # CONFIG_RT2X00 is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_RTL8180 is not set
> # CONFIG_RTL8187 is not set
> CONFIG_RTL_CARDS=m
> # CONFIG_RTL8192CE is not set
> # CONFIG_RTL8192SE is not set
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> # CONFIG_RTL8192CU is not set
> # CONFIG_RTL8XXXU is not set
> # CONFIG_RTW88 is not set
> # CONFIG_RTW89 is not set
> CONFIG_WLAN_VENDOR_RSI=y
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_ST=y
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=y
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> # CONFIG_USB_ZD1201 is not set
> # CONFIG_ZD1211RW is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_QTNFMAC_PCIE is not set
> # CONFIG_MAC80211_HWSIM is not set
> # CONFIG_USB_NET_RNDIS_WLAN is not set
> # CONFIG_VIRT_WIFI is not set
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=m
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ATUSB is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_HYPERV_NET is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=m
> CONFIG_INPUT_SPARSEKMAP=m
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> CONFIG_MOUSE_PS2_VMMOUSE=y
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=m
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> CONFIG_MOUSE_CYAPA=m
> CONFIG_MOUSE_ELAN_I2C=m
> CONFIG_MOUSE_ELAN_I2C_I2C=y
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_VSXXXAA=m
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=m
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> CONFIG_RMI4_CORE=m
> CONFIG_RMI4_I2C=m
> CONFIG_RMI4_SPI=m
> CONFIG_RMI4_SMB=m
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=m
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F3A is not set
> # CONFIG_RMI4_F54 is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=m
> CONFIG_SERIO_ALTERA_PS2=m
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=m
> CONFIG_HYPERV_KEYBOARD=m
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=64
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=m
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=m
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK_GT=m
> CONFIG_N_HDLC=m
> CONFIG_N_GSM=m
> CONFIG_NOZOMI=m
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=y
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=m
> CONFIG_VIRTIO_CONSOLE=m
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_PANIC_STRING=y
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> CONFIG_IPMI_SSIF=m
> CONFIG_IPMI_WATCHDOG=m
> CONFIG_IPMI_POWEROFF=m
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> CONFIG_HW_RANDOM_INTEL=m
> CONFIG_HW_RANDOM_AMD=m
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=m
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=y
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=m
> CONFIG_UV_MMTIMER=m
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=m
> CONFIG_TCG_TIS_I2C_INFINEON=m
> CONFIG_TCG_TIS_I2C_NUVOTON=m
> CONFIG_TCG_NSC=m
> CONFIG_TCG_ATMEL=m
> CONFIG_TCG_INFINEON=m
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=m
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # CONFIG_RANDOM_TRUST_CPU is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> CONFIG_I2C_AMD756=m
> CONFIG_I2C_AMD756_S4882=m
> CONFIG_I2C_AMD8111=m
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=y
> CONFIG_I2C_ISCH=m
> CONFIG_I2C_ISMT=m
> CONFIG_I2C_PIIX4=m
> CONFIG_I2C_NFORCE2=m
> CONFIG_I2C_NFORCE2_S4985=m
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=m
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=m
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=m
> CONFIG_I2C_SIMTEC=m
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=m
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=m
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> # CONFIG_SPI_MEM is not set
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=m
> CONFIG_PPS_CLIENT_PARPORT=m
> CONFIG_PPS_CLIENT_GPIO=m
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=m
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> CONFIG_PINCTRL_AMD=m
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> 
> #
> # Intel pinctrl drivers
> #
> CONFIG_PINCTRL_BAYTRAIL=y
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_ALDERLAKE is not set
> CONFIG_PINCTRL_BROXTON=m
> CONFIG_PINCTRL_CANNONLAKE=m
> CONFIG_PINCTRL_CEDARFORK=m
> CONFIG_PINCTRL_DENVERTON=m
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=m
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=m
> CONFIG_PINCTRL_SUNRISEPOINT=m
> # CONFIG_PINCTRL_TIGERLAKE is not set
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_GENERIC=m
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_AMDPT=m
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_ICH=m
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # end of Virtual GPIO drivers
> 
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=m
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=m
> CONFIG_SENSORS_ABITUGURU3=m
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=m
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1029=m
> CONFIG_SENSORS_ADM1031=m
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=m
> CONFIG_SENSORS_ADT7X10=m
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=m
> CONFIG_SENSORS_ADT7411=m
> CONFIG_SENSORS_ADT7462=m
> CONFIG_SENSORS_ADT7470=m
> CONFIG_SENSORS_ADT7475=m
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=m
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=m
> CONFIG_SENSORS_K10TEMP=m
> CONFIG_SENSORS_FAM15H_POWER=m
> CONFIG_SENSORS_APPLESMC=m
> CONFIG_SENSORS_ASB100=m
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=m
> CONFIG_SENSORS_DS1621=m
> CONFIG_SENSORS_DELL_SMM=m
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> CONFIG_SENSORS_F71882FG=m
> CONFIG_SENSORS_F75375S=m
> CONFIG_SENSORS_FSCHMD=m
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GL518SM=m
> CONFIG_SENSORS_GL520SM=m
> CONFIG_SENSORS_G760A=m
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=m
> CONFIG_SENSORS_IBMPEX=m
> CONFIG_SENSORS_I5500=m
> CONFIG_SENSORS_CORETEMP=m
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_JC42=m
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=m
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=m
> CONFIG_SENSORS_LTC4215=m
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=m
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=m
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=m
> CONFIG_SENSORS_MAX1619=m
> CONFIG_SENSORS_MAX1668=m
> CONFIG_SENSORS_MAX197=m
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=m
> CONFIG_SENSORS_MAX6642=m
> CONFIG_SENSORS_MAX6650=m
> CONFIG_SENSORS_MAX6697=m
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=m
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=m
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=m
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=m
> CONFIG_SENSORS_LM95234=m
> CONFIG_SENSORS_LM95241=m
> CONFIG_SENSORS_LM95245=m
> CONFIG_SENSORS_PC87360=m
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=m
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=m
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> CONFIG_SENSORS_PMBUS=m
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=m
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=m
> CONFIG_SENSORS_LTC2978=m
> # CONFIG_SENSORS_LTC3815 is not set
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=m
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> CONFIG_SENSORS_MAX34440=m
> CONFIG_SENSORS_MAX8688=m
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=m
> CONFIG_SENSORS_UCD9200=m
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=m
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=m
> CONFIG_SENSORS_SHT21=m
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> CONFIG_SENSORS_EMC1403=m
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=m
> CONFIG_SENSORS_SMSC47M1=m
> CONFIG_SENSORS_SMSC47M192=m
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_SCH56XX_COMMON=m
> CONFIG_SENSORS_SCH5627=m
> CONFIG_SENSORS_SCH5636=m
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=m
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=m
> CONFIG_SENSORS_INA2XX=m
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=m
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=m
> CONFIG_SENSORS_TMP421=m
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_VT1211=m
> CONFIG_SENSORS_VT8231=m
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83791D=m
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83793=m
> CONFIG_SENSORS_W83795=m
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=m
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> CONFIG_SENSORS_ATK0110=m
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=m
> CONFIG_X86_THERMAL_VECTOR=y
> CONFIG_X86_PKG_TEMP_THERMAL=m
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_PCH_THERMAL=m
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
> 
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> CONFIG_WDAT_WDT=m
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=m
> CONFIG_ALIM7101_WDT=m
> # CONFIG_EBC_C384_WDT is not set
> CONFIG_F71808E_WDT=m
> CONFIG_SP5100_TCO=m
> CONFIG_SBC_FITPC2_WATCHDOG=m
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=m
> CONFIG_IBMASR=m
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=y
> CONFIG_IE6XX_WDT=m
> CONFIG_ITCO_WDT=y
> CONFIG_ITCO_VENDOR_SUPPORT=y
> CONFIG_IT8712F_WDT=m
> CONFIG_IT87_WDT=m
> CONFIG_HP_WATCHDOG=m
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=m
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=m
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=m
> CONFIG_W83627HF_WDT=m
> CONFIG_W83877F_WDT=m
> CONFIG_W83977F_WDT=m
> CONFIG_MACHZ_WDT=m
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=m
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=m
> CONFIG_WDTPCI=m
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=m
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_INTEL_PMT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=m
> CONFIG_MFD_SM501_GPIO=y
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=m
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=m
> CONFIG_RC_MAP=m
> CONFIG_LIRC=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_NEC_DECODER=m
> CONFIG_IR_RC5_DECODER=m
> CONFIG_IR_RC6_DECODER=m
> CONFIG_IR_JVC_DECODER=m
> CONFIG_IR_SONY_DECODER=m
> CONFIG_IR_SANYO_DECODER=m
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_MCE_KBD_DECODER=m
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_IR_IMON_DECODER=m
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_RC_DEVICES=y
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_IR_ENE=m
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_MCEUSB is not set
> CONFIG_IR_ITE_CIR=m
> CONFIG_IR_FINTEK=m
> CONFIG_IR_NUVOTON=m
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_STREAMZAP is not set
> CONFIG_IR_WINBOND_CIR=m
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_RC_LOOPBACK is not set
> CONFIG_IR_SERIAL=m
> CONFIG_IR_SERIAL_TRANSMITTER=y
> # CONFIG_RC_XBOX_DVD is not set
> # CONFIG_IR_TOY is not set
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_PULSE8_CEC is not set
> # CONFIG_USB_RAINSHADOW_CEC is not set
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=m
> # CONFIG_MEDIA_SUPPORT_FILTER is not set
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> CONFIG_MEDIA_SDR_SUPPORT=y
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> CONFIG_MEDIA_TEST_SUPPORT=y
> # end of Media device types
> 
> #
> # Media core support
> #
> CONFIG_VIDEO_DEV=m
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=m
> # end of Media core support
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=m
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> CONFIG_RADIO_ADAPTERS=y
> # CONFIG_RADIO_SI470X is not set
> # CONFIG_RADIO_SI4713 is not set
> # CONFIG_USB_MR800 is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_SHARK is not set
> # CONFIG_RADIO_SHARK2 is not set
> # CONFIG_USB_KEENE is not set
> # CONFIG_USB_RAREMONO is not set
> # CONFIG_USB_MA901 is not set
> # CONFIG_RADIO_TEA5764 is not set
> # CONFIG_RADIO_SAA7706H is not set
> # CONFIG_RADIO_TEF6862 is not set
> # CONFIG_RADIO_WL1273 is not set
> CONFIG_VIDEOBUF2_CORE=m
> CONFIG_VIDEOBUF2_V4L2=m
> CONFIG_VIDEOBUF2_MEMOPS=m
> CONFIG_VIDEOBUF2_VMALLOC=m
> # CONFIG_V4L_PLATFORM_DRIVERS is not set
> # CONFIG_V4L_MEM2MEM_DRIVERS is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
> # CONFIG_SDR_PLATFORM_DRIVERS is not set
> 
> #
> # MMC/SDIO DVB adapters
> #
> # CONFIG_SMS_SDIO_DRV is not set
> # CONFIG_V4L_TEST_DRIVERS is not set
> # CONFIG_DVB_TEST_DRIVERS is not set
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> # CONFIG_DVB_FIREDTV is not set
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> CONFIG_VIDEO_IR_I2C=m
> 
> #
> # Audio decoders, processors and mixers
> #
> # CONFIG_VIDEO_TVAUDIO is not set
> # CONFIG_VIDEO_TDA7432 is not set
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_MSP3400 is not set
> # CONFIG_VIDEO_CS3308 is not set
> # CONFIG_VIDEO_CS5345 is not set
> # CONFIG_VIDEO_CS53L32A is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_UDA1342 is not set
> # CONFIG_VIDEO_WM8775 is not set
> # CONFIG_VIDEO_WM8739 is not set
> # CONFIG_VIDEO_VP27SMPX is not set
> # CONFIG_VIDEO_SONY_BTF_MPX is not set
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> # CONFIG_VIDEO_SAA6588 is not set
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV7604 is not set
> # CONFIG_VIDEO_ADV7842 is not set
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> # CONFIG_VIDEO_KS0127 is not set
> # CONFIG_VIDEO_ML86V7667 is not set
> # CONFIG_VIDEO_SAA7110 is not set
> # CONFIG_VIDEO_SAA711X is not set
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TVP514X is not set
> # CONFIG_VIDEO_TVP5150 is not set
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> # CONFIG_VIDEO_TW9903 is not set
> # CONFIG_VIDEO_TW9906 is not set
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
> 
> #
> # Video and audio decoders
> #
> # CONFIG_VIDEO_SAA717X is not set
> # CONFIG_VIDEO_CX25840 is not set
> # end of Video decoders
> 
> #
> # Video encoders
> #
> # CONFIG_VIDEO_SAA7127 is not set
> # CONFIG_VIDEO_SAA7185 is not set
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> # CONFIG_VIDEO_ADV7343 is not set
> # CONFIG_VIDEO_ADV7393 is not set
> # CONFIG_VIDEO_ADV7511 is not set
> # CONFIG_VIDEO_AD9389B is not set
> # CONFIG_VIDEO_AK881X is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> # CONFIG_VIDEO_UPD64031A is not set
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> # CONFIG_SDR_MAX2175 is not set
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_THS7303 is not set
> # CONFIG_VIDEO_M52790 is not set
> # CONFIG_VIDEO_I2C is not set
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # end of Miscellaneous helper chips
> 
> #
> # Camera sensor devices
> #
> # CONFIG_VIDEO_HI556 is not set
> # CONFIG_VIDEO_HI846 is not set
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> # CONFIG_VIDEO_IMX290 is not set
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX355 is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV2640 is not set
> # CONFIG_VIDEO_OV2659 is not set
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> # CONFIG_VIDEO_OV5647 is not set
> # CONFIG_VIDEO_OV5648 is not set
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> # CONFIG_VIDEO_OV5695 is not set
> # CONFIG_VIDEO_OV7251 is not set
> # CONFIG_VIDEO_OV772X is not set
> # CONFIG_VIDEO_OV7640 is not set
> # CONFIG_VIDEO_OV7670 is not set
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> # CONFIG_VIDEO_OV9734 is not set
> # CONFIG_VIDEO_OV13858 is not set
> # CONFIG_VIDEO_OV13B10 is not set
> # CONFIG_VIDEO_VS6624 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> # CONFIG_VIDEO_MT9M032 is not set
> # CONFIG_VIDEO_MT9M111 is not set
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T001 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> # CONFIG_VIDEO_MT9V011 is not set
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> # CONFIG_VIDEO_SR030PC30 is not set
> # CONFIG_VIDEO_NOON010PC30 is not set
> # CONFIG_VIDEO_M5MOLS is not set
> # CONFIG_VIDEO_RDACM20 is not set
> # CONFIG_VIDEO_RDACM21 is not set
> # CONFIG_VIDEO_RJ54N1 is not set
> # CONFIG_VIDEO_S5K6AA is not set
> # CONFIG_VIDEO_S5K6A3 is not set
> # CONFIG_VIDEO_S5K4ECGX is not set
> # CONFIG_VIDEO_S5K5BAF is not set
> # CONFIG_VIDEO_CCS is not set
> # CONFIG_VIDEO_ET8EK8 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
> 
> #
> # SPI helper chips
> #
> # CONFIG_VIDEO_GS1662 is not set
> # end of SPI helper chips
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=m
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=m
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=m
> CONFIG_MEDIA_TUNER_TDA18250=m
> CONFIG_MEDIA_TUNER_TDA8290=m
> CONFIG_MEDIA_TUNER_TDA827X=m
> CONFIG_MEDIA_TUNER_TDA18271=m
> CONFIG_MEDIA_TUNER_TDA9887=m
> CONFIG_MEDIA_TUNER_TEA5761=m
> CONFIG_MEDIA_TUNER_TEA5767=m
> CONFIG_MEDIA_TUNER_MSI001=m
> CONFIG_MEDIA_TUNER_MT20XX=m
> CONFIG_MEDIA_TUNER_MT2060=m
> CONFIG_MEDIA_TUNER_MT2063=m
> CONFIG_MEDIA_TUNER_MT2266=m
> CONFIG_MEDIA_TUNER_MT2131=m
> CONFIG_MEDIA_TUNER_QT1010=m
> CONFIG_MEDIA_TUNER_XC2028=m
> CONFIG_MEDIA_TUNER_XC5000=m
> CONFIG_MEDIA_TUNER_XC4000=m
> CONFIG_MEDIA_TUNER_MXL5005S=m
> CONFIG_MEDIA_TUNER_MXL5007T=m
> CONFIG_MEDIA_TUNER_MC44S803=m
> CONFIG_MEDIA_TUNER_MAX2165=m
> CONFIG_MEDIA_TUNER_TDA18218=m
> CONFIG_MEDIA_TUNER_FC0011=m
> CONFIG_MEDIA_TUNER_FC0012=m
> CONFIG_MEDIA_TUNER_FC0013=m
> CONFIG_MEDIA_TUNER_TDA18212=m
> CONFIG_MEDIA_TUNER_E4000=m
> CONFIG_MEDIA_TUNER_FC2580=m
> CONFIG_MEDIA_TUNER_M88RS6000T=m
> CONFIG_MEDIA_TUNER_TUA9001=m
> CONFIG_MEDIA_TUNER_SI2157=m
> CONFIG_MEDIA_TUNER_IT913X=m
> CONFIG_MEDIA_TUNER_R820T=m
> CONFIG_MEDIA_TUNER_MXL301RF=m
> CONFIG_MEDIA_TUNER_QM1D1C0042=m
> CONFIG_MEDIA_TUNER_QM1D1B0004=m
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_STB0899=m
> CONFIG_DVB_STB6100=m
> CONFIG_DVB_STV090x=m
> CONFIG_DVB_STV0910=m
> CONFIG_DVB_STV6110x=m
> CONFIG_DVB_STV6111=m
> CONFIG_DVB_MXL5XX=m
> CONFIG_DVB_M88DS3103=m
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=m
> CONFIG_DVB_TDA18271C2DD=m
> CONFIG_DVB_SI2165=m
> CONFIG_DVB_MN88472=m
> CONFIG_DVB_MN88473=m
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=m
> CONFIG_DVB_CX24123=m
> CONFIG_DVB_MT312=m
> CONFIG_DVB_ZL10036=m
> CONFIG_DVB_ZL10039=m
> CONFIG_DVB_S5H1420=m
> CONFIG_DVB_STV0288=m
> CONFIG_DVB_STB6000=m
> CONFIG_DVB_STV0299=m
> CONFIG_DVB_STV6110=m
> CONFIG_DVB_STV0900=m
> CONFIG_DVB_TDA8083=m
> CONFIG_DVB_TDA10086=m
> CONFIG_DVB_TDA8261=m
> CONFIG_DVB_VES1X93=m
> CONFIG_DVB_TUNER_ITD1000=m
> CONFIG_DVB_TUNER_CX24113=m
> CONFIG_DVB_TDA826X=m
> CONFIG_DVB_TUA6100=m
> CONFIG_DVB_CX24116=m
> CONFIG_DVB_CX24117=m
> CONFIG_DVB_CX24120=m
> CONFIG_DVB_SI21XX=m
> CONFIG_DVB_TS2020=m
> CONFIG_DVB_DS3000=m
> CONFIG_DVB_MB86A16=m
> CONFIG_DVB_TDA10071=m
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP887X=m
> CONFIG_DVB_CX22700=m
> CONFIG_DVB_CX22702=m
> CONFIG_DVB_S5H1432=m
> CONFIG_DVB_DRXD=m
> CONFIG_DVB_L64781=m
> CONFIG_DVB_TDA1004X=m
> CONFIG_DVB_NXT6000=m
> CONFIG_DVB_MT352=m
> CONFIG_DVB_ZL10353=m
> CONFIG_DVB_DIB3000MB=m
> CONFIG_DVB_DIB3000MC=m
> CONFIG_DVB_DIB7000M=m
> CONFIG_DVB_DIB7000P=m
> CONFIG_DVB_DIB9000=m
> CONFIG_DVB_TDA10048=m
> CONFIG_DVB_AF9013=m
> CONFIG_DVB_EC100=m
> CONFIG_DVB_STV0367=m
> CONFIG_DVB_CXD2820R=m
> CONFIG_DVB_CXD2841ER=m
> CONFIG_DVB_RTL2830=m
> CONFIG_DVB_RTL2832=m
> CONFIG_DVB_RTL2832_SDR=m
> CONFIG_DVB_SI2168=m
> CONFIG_DVB_ZD1301_DEMOD=m
> CONFIG_DVB_CXD2880=m
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=m
> CONFIG_DVB_TDA10021=m
> CONFIG_DVB_TDA10023=m
> CONFIG_DVB_STV0297=m
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=m
> CONFIG_DVB_OR51211=m
> CONFIG_DVB_OR51132=m
> CONFIG_DVB_BCM3510=m
> CONFIG_DVB_LGDT330X=m
> CONFIG_DVB_LGDT3305=m
> CONFIG_DVB_LGDT3306A=m
> CONFIG_DVB_LG2160=m
> CONFIG_DVB_S5H1409=m
> CONFIG_DVB_AU8522=m
> CONFIG_DVB_AU8522_DTV=m
> CONFIG_DVB_AU8522_V4L=m
> CONFIG_DVB_S5H1411=m
> CONFIG_DVB_MXL692=m
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=m
> CONFIG_DVB_DIB8000=m
> CONFIG_DVB_MB86A20S=m
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=m
> CONFIG_DVB_MN88443X=m
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=m
> CONFIG_DVB_TUNER_DIB0070=m
> CONFIG_DVB_TUNER_DIB0090=m
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=m
> CONFIG_DVB_LNBH25=m
> CONFIG_DVB_LNBH29=m
> CONFIG_DVB_LNBP21=m
> CONFIG_DVB_LNBP22=m
> CONFIG_DVB_ISL6405=m
> CONFIG_DVB_ISL6421=m
> CONFIG_DVB_ISL6423=m
> CONFIG_DVB_A8293=m
> CONFIG_DVB_LGS8GL5=m
> CONFIG_DVB_LGS8GXX=m
> CONFIG_DVB_ATBM8830=m
> CONFIG_DVB_TDA665x=m
> CONFIG_DVB_IX2505V=m
> CONFIG_DVB_M88RS2000=m
> CONFIG_DVB_AF9033=m
> CONFIG_DVB_HORUS3A=m
> CONFIG_DVB_ASCOT2E=m
> CONFIG_DVB_HELENE=m
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=m
> CONFIG_DVB_SP2=m
> # end of Customise DVB Frontends
> 
> #
> # Tools to develop new frontends
> #
> # CONFIG_DVB_DUMMY_FE is not set
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=m
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=64
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=m
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_VRAM_HELPER=m
> CONFIG_DRM_TTM_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=m
> CONFIG_DRM_I2C_SIL164=m
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=m
> CONFIG_DRM_I915_FORCE_PROBE=""
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> CONFIG_DRM_I915_GVT=y
> # CONFIG_DRM_I915_GVT_KVMGT is not set
> CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
> CONFIG_DRM_I915_STOP_TIMEOUT=100
> CONFIG_DRM_I915_TIMESLICE_DURATION=1
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=m
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=m
> CONFIG_DRM_MGAG200=m
> CONFIG_DRM_QXL=m
> CONFIG_DRM_VIRTIO_GPU=m
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_BOCHS=m
> CONFIG_DRM_CIRRUS_QEMU=m
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_HYPERV is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> CONFIG_FB_DEFERRED_IO=y
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_HYPERV=m
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=m
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=m
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=m
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=m
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> CONFIG_UHID=m
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=m
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=m
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=m
> # CONFIG_HID_APPLEIR is not set
> CONFIG_HID_ASUS=m
> CONFIG_HID_AUREAL=m
> CONFIG_HID_BELKIN=m
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=m
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=m
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=m
> CONFIG_HID_DRAGONRISE=m
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=m
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=m
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=m
> CONFIG_HID_GFRM=m
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> CONFIG_HID_KEYTOUCH=m
> CONFIG_HID_KYE=m
> # CONFIG_HID_UCLOGIC is not set
> CONFIG_HID_WALTOP=m
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=m
> CONFIG_HID_ICADE=m
> CONFIG_HID_ITE=m
> CONFIG_HID_JABRA=m
> CONFIG_HID_TWINHAN=m
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=m
> CONFIG_HID_LED=m
> CONFIG_HID_LENOVO=m
> CONFIG_HID_LOGITECH=m
> CONFIG_HID_LOGITECH_DJ=m
> CONFIG_HID_LOGITECH_HIDPP=m
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=m
> CONFIG_HID_MONTEREY=m
> CONFIG_HID_MULTITOUCH=m
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=m
> # CONFIG_HID_NTRIG is not set
> CONFIG_HID_ORTEK=m
> CONFIG_HID_PANTHERLORD=m
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=m
> CONFIG_HID_PICOLCD=m
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> CONFIG_HID_PICOLCD_LCD=y
> CONFIG_HID_PICOLCD_LEDS=y
> CONFIG_HID_PICOLCD_CIR=y
> CONFIG_HID_PLANTRONICS=m
> CONFIG_HID_PRIMAX=m
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> CONFIG_HID_SAITEK=m
> CONFIG_HID_SAMSUNG=m
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SONY is not set
> CONFIG_HID_SPEEDLINK=m
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=m
> CONFIG_HID_SUNPLUS=m
> CONFIG_HID_RMI=m
> CONFIG_HID_GREENASIA=m
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=m
> CONFIG_HID_SMARTJOYPLUS=m
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=m
> CONFIG_HID_TOPSEED=m
> CONFIG_HID_THINGM=m
> CONFIG_HID_THRUSTMASTER=m
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> CONFIG_HID_WIIMOTE=m
> CONFIG_HID_XINMO=m
> CONFIG_HID_ZEROPLUS=m
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=m
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> CONFIG_HID_ALPS=m
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=m
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> CONFIG_USB_MON=y
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=y
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_REALTEK is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> # CONFIG_USB_UAS is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> # CONFIG_USB_SERIAL_AIRCABLE is not set
> # CONFIG_USB_SERIAL_ARK3116 is not set
> # CONFIG_USB_SERIAL_BELKIN is not set
> # CONFIG_USB_SERIAL_CH341 is not set
> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_CP210X is not set
> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> # CONFIG_USB_SERIAL_IPW is not set
> # CONFIG_USB_SERIAL_IUU is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> # CONFIG_USB_SERIAL_METRO is not set
> # CONFIG_USB_SERIAL_MOS7720 is not set
> # CONFIG_USB_SERIAL_MOS7840 is not set
> # CONFIG_USB_SERIAL_MXUPORT is not set
> # CONFIG_USB_SERIAL_NAVMAN is not set
> # CONFIG_USB_SERIAL_PL2303 is not set
> # CONFIG_USB_SERIAL_OTI6858 is not set
> # CONFIG_USB_SERIAL_QCAUX is not set
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> # CONFIG_USB_SERIAL_SYMBOL is not set
> # CONFIG_USB_SERIAL_TI is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_OPTION is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> # CONFIG_USB_SERIAL_OPTICON is not set
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> # CONFIG_USB_SERIAL_SSU100 is not set
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=m
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> # CONFIG_USB_ATM is not set
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=y
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_TYPEC_UCSI=y
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=y
> # CONFIG_TYPEC_TPS6598X is not set
> # CONFIG_TYPEC_STUSB160X is not set
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=m
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=m
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=m
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PCI=m
> CONFIG_MMC_RICOH_MMC=y
> CONFIG_MMC_SDHCI_ACPI=m
> CONFIG_MMC_SDHCI_PLTFM=m
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_REALTEK_PCI is not set
> CONFIG_MMC_CQHCI=m
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=m
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> CONFIG_LEDS_CLEVO_MAIL=m
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=m
> CONFIG_LEDS_LT3593=m
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=m
> CONFIG_LEDS_MLXCPLD=m
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=m
> CONFIG_LEDS_TRIGGER_ONESHOT=m
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=m
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=m
> CONFIG_LEDS_TRIGGER_CAMERA=m
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> CONFIG_LEDS_TRIGGER_AUDIO=m
> # CONFIG_LEDS_TRIGGER_TTY is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=m
> CONFIG_EDAC_GHES=y
> CONFIG_EDAC_AMD64=m
> CONFIG_EDAC_E752X=m
> CONFIG_EDAC_I82975X=m
> CONFIG_EDAC_I3000=m
> CONFIG_EDAC_I3200=m
> CONFIG_EDAC_IE31200=m
> CONFIG_EDAC_X38=m
> CONFIG_EDAC_I5400=m
> CONFIG_EDAC_I7CORE=m
> CONFIG_EDAC_I5000=m
> CONFIG_EDAC_I5100=m
> CONFIG_EDAC_I7300=m
> CONFIG_EDAC_SBRIDGE=m
> CONFIG_EDAC_SKX=m
> # CONFIG_EDAC_I10NM is not set
> CONFIG_EDAC_PND2=m
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=m
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=m
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=m
> CONFIG_RTC_DRV_MAX6900=m
> CONFIG_RTC_DRV_RS5C372=m
> CONFIG_RTC_DRV_ISL1208=m
> CONFIG_RTC_DRV_ISL12022=m
> CONFIG_RTC_DRV_X1205=m
> CONFIG_RTC_DRV_PCF8523=m
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=m
> CONFIG_RTC_DRV_PCF8583=m
> CONFIG_RTC_DRV_M41T80=m
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=m
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=m
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=m
> CONFIG_RTC_DRV_RX8025=m
> CONFIG_RTC_DRV_EM3027=m
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=m
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=m
> CONFIG_RTC_DRV_DS3232_HWMON=y
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=m
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=m
> CONFIG_RTC_DRV_DS1511=m
> CONFIG_RTC_DRV_DS1553=m
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=m
> CONFIG_RTC_DRV_DS2404=m
> CONFIG_RTC_DRV_STK17TA8=m
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=m
> CONFIG_RTC_DRV_M48T59=m
> CONFIG_RTC_DRV_MSM6242=m
> CONFIG_RTC_DRV_BQ4802=m
> CONFIG_RTC_DRV_RP5C01=m
> CONFIG_RTC_DRV_V3020=m
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=m
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IOATDMA=m
> # CONFIG_PLX_DMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=m
> CONFIG_DW_DMAC_PCI=y
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=y
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=m
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
> 
> CONFIG_DCA=m
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=m
> CONFIG_UIO_CIF=m
> CONFIG_UIO_PDRV_GENIRQ=m
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=m
> CONFIG_UIO_SERCOS3=m
> CONFIG_UIO_PCI_GENERIC=m
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_HV_GENERIC=m
> CONFIG_VFIO=m
> CONFIG_VFIO_IOMMU_TYPE1=m
> CONFIG_VFIO_VIRQFD=m
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_PCI_CORE=m
> CONFIG_VFIO_PCI_MMAP=y
> CONFIG_VFIO_PCI_INTX=y
> CONFIG_VFIO_PCI=m
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> CONFIG_VFIO_MDEV=m
> CONFIG_IRQ_BYPASS_MANAGER=m
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI_LIB=y
> CONFIG_VIRTIO_PCI_LIB_LEGACY=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=m
> CONFIG_VIRTIO_MEM=m
> CONFIG_VIRTIO_INPUT=m
> # CONFIG_VIRTIO_MMIO is not set
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=m
> CONFIG_VHOST=m
> CONFIG_VHOST_MENU=y
> CONFIG_VHOST_NET=m
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST_VSOCK=m
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=m
> CONFIG_HYPERV_TIMER=y
> CONFIG_HYPERV_UTILS=m
> CONFIG_HYPERV_BALLOON=m
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=m
> CONFIG_WMI_BMOF=m
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> CONFIG_MXM_WMI=m
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> CONFIG_ACERHDF=m
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ACER_WMI=m
> # CONFIG_AMD_PMC is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=m
> CONFIG_ASUS_LAPTOP=m
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ASUS_WMI=m
> CONFIG_ASUS_NB_WMI=m
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=m
> CONFIG_EEEPC_WMI=m
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=m
> CONFIG_FUJITSU_LAPTOP=m
> CONFIG_FUJITSU_TABLET=m
> # CONFIG_GPD_POCKET_FAN is not set
> CONFIG_HP_ACCEL=m
> # CONFIG_WIRELESS_HOTKEY is not set
> CONFIG_HP_WMI=m
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=m
> CONFIG_SENSORS_HDAPS=m
> CONFIG_THINKPAD_ACPI=m
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=y
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=m
> 
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
> 
> CONFIG_INTEL_WMI=y
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=m
> CONFIG_INTEL_HID_EVENT=m
> CONFIG_INTEL_VBTN=m
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=m
> # CONFIG_INTEL_ISHTP_ECLITE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=m
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TURBO_MAX_3=y
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> CONFIG_MSI_LAPTOP=m
> CONFIG_MSI_WMI=m
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=m
> CONFIG_SAMSUNG_Q10=m
> CONFIG_TOSHIBA_BT_RFKILL=m
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=m
> CONFIG_COMPAL_LAPTOP=m
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=m
> CONFIG_SONY_LAPTOP=m
> CONFIG_SONYPI_COMPAT=y
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=m
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=m
> CONFIG_INTEL_IPS=m
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=m
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOASID=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> # CONFIG_INTEL_IOMMU_SVM is not set
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
> CONFIG_IRQ_REMAP=y
> CONFIG_HYPERV_IOMMU=y
> # CONFIG_VIRTIO_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> CONFIG_NTB=m
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> # CONFIG_NTB_IDT is not set
> # CONFIG_NTB_INTEL is not set
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> # CONFIG_NTB_PINGPONG is not set
> # CONFIG_NTB_TOOL is not set
> # CONFIG_NTB_PERF is not set
> # CONFIG_NTB_TRANSPORT is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LPSS=m
> CONFIG_PWM_LPSS_PCI=m
> CONFIG_PWM_LPSS_PLATFORM=m
> # CONFIG_PWM_PCA9685 is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> 
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=m
> CONFIG_INTEL_RAPL=m
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_DTPM is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_RAS_CEC is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=m
> CONFIG_BLK_DEV_PMEM=m
> CONFIG_ND_BLK=m
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=m
> CONFIG_BTT=y
> CONFIG_ND_PFN=m
> CONFIG_NVDIMM_PFN=y
> CONFIG_NVDIMM_DAX=y
> CONFIG_NVDIMM_KEYS=y
> CONFIG_DAX_DRIVER=y
> CONFIG_DAX=y
> CONFIG_DEV_DAX=m
> CONFIG_DEV_DAX_PMEM=m
> CONFIG_DEV_DAX_KMEM=m
> CONFIG_DEV_DAX_PMEM_COMPAT=m
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=m
> # CONFIG_STM_PROTO_BASIC is not set
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=m
> CONFIG_STM_SOURCE_CONSOLE=m
> CONFIG_STM_SOURCE_HEARTBEAT=m
> CONFIG_STM_SOURCE_FTRACE=m
> CONFIG_INTEL_TH=m
> CONFIG_INTEL_TH_PCI=m
> CONFIG_INTEL_TH_ACPI=m
> CONFIG_INTEL_TH_GTH=m
> CONFIG_INTEL_TH_STH=m
> CONFIG_INTEL_TH_MSU=m
> CONFIG_INTEL_TH_PTI=m
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=m
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=m
> CONFIG_XFS_SUPPORT_V4=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_XFS_RT=y
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_DEBUG=y
> CONFIG_XFS_ASSERT_FATAL=y
> CONFIG_GFS2_FS=m
> CONFIG_GFS2_FS_LOCKING_DLM=y
> CONFIG_OCFS2_FS=m
> CONFIG_OCFS2_FS_O2CB=m
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
> CONFIG_OCFS2_FS_STATS=y
> CONFIG_OCFS2_DEBUG_MASKLOG=y
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=m
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> CONFIG_F2FS_FS_POSIX_ACL=y
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=y
> CONFIG_FS_DAX=y
> CONFIG_FS_DAX_PMD=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> CONFIG_CUSE=m
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=m
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=m
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=m
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=m
> # CONFIG_CACHEFILES_DEBUG is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=m
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=m
> CONFIG_CRAMFS_BLOCKDEV=y
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=m
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=m
> CONFIG_PNFS_BLOCK=m
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=y
> CONFIG_ROOT_NFS=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DEBUG=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_PNFS=y
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=y
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=y
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=y
> CONFIG_NFS_COMMON=y
> CONFIG_NFS_V4_2_SSC_HELPER=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> CONFIG_SUNRPC_DEBUG=y
> CONFIG_CEPH_FS=m
> # CONFIG_CEPH_FSCACHE is not set
> CONFIG_CEPH_FS_POSIX_ACL=y
> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> CONFIG_CIFS_UPCALL=y
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=y
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=m
> CONFIG_NLS_CODEPAGE_852=m
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=m
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_MAC_ROMAN=m
> CONFIG_NLS_MAC_CELTIC=m
> CONFIG_NLS_MAC_CENTEURO=m
> CONFIG_NLS_MAC_CROATIAN=m
> CONFIG_NLS_MAC_CYRILLIC=m
> CONFIG_NLS_MAC_GAELIC=m
> CONFIG_NLS_MAC_GREEK=m
> CONFIG_NLS_MAC_ICELAND=m
> CONFIG_NLS_MAC_INUIT=m
> CONFIG_NLS_MAC_ROMANIAN=m
> CONFIG_NLS_MAC_TURKISH=m
> CONFIG_NLS_UTF8=m
> CONFIG_DLM=m
> CONFIG_DLM_DEBUG=y
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITY_WRITABLE_HOOKS=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_PATH=y
> CONFIG_INTEL_TXT=y
> CONFIG_LSM_MMAP_MIN_ADDR=65535
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=y
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH="sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=y
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> # CONFIG_IMA_APPRAISE_MODSIG is not set
> CONFIG_IMA_TRUSTED_KEYRING=y
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=m
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=m
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=m
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=m
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=m
> CONFIG_CRYPTO_ECC=m
> CONFIG_CRYPTO_ECDH=m
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=m
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> CONFIG_CRYPTO_OFB=m
> CONFIG_CRYPTO_PCBC=m
> CONFIG_CRYPTO_XTS=m
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ESSIV=m
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=m
> CONFIG_CRYPTO_VMAC=m
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=m
> CONFIG_CRYPTO_CRC32=m
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> CONFIG_CRYPTO_XXHASH=m
> CONFIG_CRYPTO_BLAKE2B=m
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=m
> CONFIG_CRYPTO_POLY1305_X86_64=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_RMD160=m
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=m
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=m
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_BLOWFISH_X86_64=m
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAMELLIA_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
> CONFIG_CRYPTO_CAST_COMMON=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_CAST6_AVX_X86_64=m
> CONFIG_CRYPTO_DES=m
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_FCRYPT=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_CHACHA20_X86_64=m
> CONFIG_CRYPTO_SEED=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> CONFIG_CRYPTO_SM4=m
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=m
> CONFIG_CRYPTO_TWOFISH_X86_64=m
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> CONFIG_CRYPTO_USER_API_RNG=y
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=m
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=m
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_LIB_SM4=m
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=m
> CONFIG_CRYPTO_DEV_PADLOCK_AES=m
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=m
> CONFIG_CRYPTO_DEV_SP_CCP=y
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
> CONFIG_CRYPTO_DEV_SP_PSP=y
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_QAT=m
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
> CONFIG_CRYPTO_DEV_QAT_C3XXX=m
> CONFIG_CRYPTO_DEV_QAT_C62X=m
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
> CONFIG_CRYPTO_DEV_QAT_C62XVF=m
> CONFIG_CRYPTO_DEV_NITROX=m
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_RAID6_PQ_BENCHMARK=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_CORDIC=m
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=m
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=m
> CONFIG_CRC8=m
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=m
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=m
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=m
> CONFIG_TEXTSEARCH_BM=m
> CONFIG_TEXTSEARCH_FSM=m
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> CONFIG_ASN1_ENCODER=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=y
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_FUNCTION_PROFILER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_CC=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=m
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_X86_DECODER_SELFTEST=y
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> CONFIG_TEST_BPF=m
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='fsmark'
> 	export testcase='fsmark'
> 	export category='benchmark'
> 	export iterations=8
> 	export nr_threads=4
> 	export job_origin='fsmark-1ssd-nvme-small.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='validate'
> 	export testbox='lkp-csl-2ap4'
> 	export tbox_group='lkp-csl-2ap4'
> 	export kconfig='x86_64-rhel-8.3'
> 	export submit_id='61e15820f05c2c6d34a8c32f'
> 	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/fsmark-performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-1a61b300c09-20220114-27956-1t9w6di-3.yaml'
> 	export id='30760960528f87554d426b02ae9c6f134e7f1946'
> 	export queuer_version='/lkp-src'
> 	export model='Cascade Lake'
> 	export nr_node=4
> 	export nr_cpu=192
> 	export memory='192G'
> 	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
> 	export rootfs_partition='LABEL=LKP-ROOTFS'
> 	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
> 	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
> 	export need_kconfig='BLK_DEV_SD
> SCSI
> {"BLOCK"=>"y"}
> SATA_AHCI
> SATA_AHCI_PLATFORM
> ATA
> {"PCI"=>"y"}
> BTRFS_FS
> NFSD'
> 	export commit='1a61b300c09b1d034534372349e8f9d3aba6c392'
> 	export need_kconfig_hw='{"IGB"=>"y"}
> BLK_DEV_NVME'
> 	export ucode='0x5003006'
> 	export enqueue_time='2022-01-14 19:01:52 +0800'
> 	export _id='61e15820f05c2c6d34a8c32f'
> 	export _rt='/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392'
> 	export user='lkp'
> 	export compiler='gcc-9'
> 	export LKP_SERVER='internal-lkp-server'
> 	export head_commit='23d9943864d9bb4a4476d4237ff603021281b74a'
> 	export base_commit='c9e6606c7fe92b50a02ce51dda82586ebdf99b48'
> 	export branch='linux-next/master'
> 	export rootfs='debian-10.4-x86_64-20200603.cgz'
> 	export result_root='/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/3'
> 	export scheduler_version='/lkp/lkp/.src-20220114-102716'
> 	export arch='x86_64'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
> 	export bootloader_append='root=/dev/ram0
> RESULT_ROOT=/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/3
> BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/vmlinuz-5.16.0-rc8-00117-g1a61b300c09b
> branch=linux-next/master
> job=/lkp/jobs/scheduled/lkp-csl-2ap4/fsmark-performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-1a61b300c09-20220114-27956-1t9w6di-3.yaml
> user=lkp
> ARCH=x86_64
> kconfig=x86_64-rhel-8.3
> commit=1a61b300c09b1d034534372349e8f9d3aba6c392
> acpi_rsdp=0x67f44014
> max_uptime=2100
> LKP_SERVER=internal-lkp-server
> nokaslr
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-698ee57-1_20220112.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-362f533a2a10-1_20220113.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
> 	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export last_kernel='5.16.0-rc8-06580-g23d9943864d9'
> 	export repeat_to=6
> 	export schedule_notify_address=
> 	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/vmlinuz-5.16.0-rc8-00117-g1a61b300c09b'
> 	export dequeue_time='2022-01-14 19:29:13 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/fsmark-performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-1a61b300c09-20220114-27956-1t9w6di-3.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_setup nr_ssd=1 $LKP_SRC/setup/disk
> 
> 	run_setup fs='btrfs' $LKP_SRC/setup/fs
> 
> 	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper uptime
> 	run_monitor $LKP_SRC/monitors/wrapper iostat
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper proc-stat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper slabinfo
> 	run_monitor $LKP_SRC/monitors/wrapper interrupts
> 	run_monitor $LKP_SRC/monitors/wrapper lock_stat
> 	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
> 	run_monitor $LKP_SRC/monitors/wrapper softirqs
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
> 	run_monitor $LKP_SRC/monitors/wrapper diskstats
> 	run_monitor $LKP_SRC/monitors/wrapper nfsstat
> 	run_monitor $LKP_SRC/monitors/wrapper cpuidle
> 	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
> 	run_monitor $LKP_SRC/monitors/wrapper turbostat
> 	run_monitor $LKP_SRC/monitors/wrapper sched_debug
> 	run_monitor $LKP_SRC/monitors/wrapper perf-stat
> 	run_monitor $LKP_SRC/monitors/wrapper mpstat
> 	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test filesize='8K' test_size='24G' sync_method='fsyncBeforeClose' nr_directories='16d' nr_files_per_directory='256fpd' $LKP_SRC/tests/wrapper fsmark
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env filesize='8K' test_size='24G' sync_method='fsyncBeforeClose' nr_directories='16d' nr_files_per_directory='256fpd' $LKP_SRC/stats/wrapper fsmark
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper uptime
> 	$LKP_SRC/stats/wrapper iostat
> 	$LKP_SRC/stats/wrapper vmstat
> 	$LKP_SRC/stats/wrapper numa-numastat
> 	$LKP_SRC/stats/wrapper numa-vmstat
> 	$LKP_SRC/stats/wrapper numa-meminfo
> 	$LKP_SRC/stats/wrapper proc-vmstat
> 	$LKP_SRC/stats/wrapper meminfo
> 	$LKP_SRC/stats/wrapper slabinfo
> 	$LKP_SRC/stats/wrapper interrupts
> 	$LKP_SRC/stats/wrapper lock_stat
> 	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
> 	$LKP_SRC/stats/wrapper softirqs
> 	$LKP_SRC/stats/wrapper diskstats
> 	$LKP_SRC/stats/wrapper nfsstat
> 	$LKP_SRC/stats/wrapper cpuidle
> 	$LKP_SRC/stats/wrapper turbostat
> 	$LKP_SRC/stats/wrapper sched_debug
> 	$LKP_SRC/stats/wrapper perf-stat
> 	$LKP_SRC/stats/wrapper mpstat
> 	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile
> 
> 	$LKP_SRC/stats/wrapper time fsmark.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"

> ---
> :#! jobs/fsmark-1ssd-nvme-small.yaml:
> suite: fsmark
> testcase: fsmark
> category: benchmark
> iterations: 8
> disk: 1SSD
> nr_threads: 4
> fs: btrfs
> fsmark:
>   filesize: 8K
>   test_size: 24G
>   sync_method: fsyncBeforeClose
>   nr_directories: 16d
>   nr_files_per_directory: 256fpd
> job_origin: fsmark-1ssd-nvme-small.yaml
> :#! queue options:
> queue_cmdline_keys:
> - branch
> - commit
> queue: bisect
> testbox: lkp-csl-2ap4
> tbox_group: lkp-csl-2ap4
> kconfig: x86_64-rhel-8.3
> submit_id: 61e1081df05c2c5b1b205913
> job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/fsmark-performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-1a61b300c09-20220114-23323-bwklhd-2.yaml"
> id: a33a2eac220eacd1d900b8174d5b09d4b19de90d
> queuer_version: "/lkp-src"
> :#! hosts/lkp-csl-2ap4:
> model: Cascade Lake
> nr_node: 4
> nr_cpu: 192
> memory: 192G
> ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1"
> rootfs_partition: LABEL=LKP-ROOTFS
> kernel_cmdline_hw: acpi_rsdp=0x67f44014
> brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
> :#! include/category/benchmark:
> kmsg:
> boot-time:
> uptime:
> iostat:
> heartbeat:
> vmstat:
> numa-numastat:
> numa-vmstat:
> numa-meminfo:
> proc-vmstat:
> proc-stat:
> meminfo:
> slabinfo:
> interrupts:
> lock_stat:
> perf-sched:
>   lite_mode: 1
> softirqs:
> bdi_dev_mapping:
> diskstats:
> nfsstat:
> cpuidle:
> cpufreq-stats:
> turbostat:
> sched_debug:
> perf-stat:
> mpstat:
> perf-profile:
>   debug_mode: 0
> :#! include/category/ALL:
> cpufreq_governor: performance
> :#! include/disk/nr_ssd:
> need_kconfig:
> - BLK_DEV_SD
> - SCSI
> - BLOCK: y
> - SATA_AHCI
> - SATA_AHCI_PLATFORM
> - ATA
> - PCI: y
> - BTRFS_FS
> - NFSD
> :#! include/fs/OTHERS:
> :#! include/queue/cyclic:
> commit: 1a61b300c09b1d034534372349e8f9d3aba6c392
> :#! include/testbox/lkp-csl-2ap4:
> need_kconfig_hw:
> - IGB: y
> - BLK_DEV_NVME
> ucode: '0x5003006'
> :#! include/fsmark:
> enqueue_time: 2022-01-14 13:20:29.435699947 +08:00
> _id: 61e10d96f05c2c5b1b205915
> _rt: "/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392"
> :#! schedule options:
> user: lkp
> compiler: gcc-9
> LKP_SERVER: internal-lkp-server
> head_commit: 23d9943864d9bb4a4476d4237ff603021281b74a
> base_commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
> branch: linux-devel/devel-hourly-20220110-012702
> rootfs: debian-10.4-x86_64-20200603.cgz
> result_root: "/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/0"
> scheduler_version: "/lkp/lkp/.src-20220114-102716"
> arch: x86_64
> max_uptime: 2100
> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
> bootloader_append:
> - root=/dev/ram0
> - RESULT_ROOT=/result/fsmark/performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/0
> - BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/vmlinuz-5.16.0-rc8-00117-g1a61b300c09b
> - branch=linux-devel/devel-hourly-20220110-012702
> - job=/lkp/jobs/scheduled/lkp-csl-2ap4/fsmark-performance-1SSD-8K-btrfs-8-16d-256fpd-4-fsyncBeforeClose-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-1a61b300c09-20220114-23323-bwklhd-2.yaml
> - user=lkp
> - ARCH=x86_64
> - kconfig=x86_64-rhel-8.3
> - commit=1a61b300c09b1d034534372349e8f9d3aba6c392
> - acpi_rsdp=0x67f44014
> - max_uptime=2100
> - LKP_SERVER=internal-lkp-server
> - nokaslr
> - selinux=0
> - debug
> - apic=debug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=100
> - net.ifnames=0
> - printk.devkmsg=on
> - panic=-1
> - softlockup_panic=1
> - nmi_watchdog=panic
> - oops=panic
> - load_ramdisk=2
> - prompt_ramdisk=0
> - drbd.minor_count=8
> - systemd.log_level=err
> - ignore_loglevel
> - console=tty0
> - earlyprintk=ttyS0,115200
> - console=ttyS0,115200
> - vga=normal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/modules.cgz"
> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-698ee57-1_20220112.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-362f533a2a10-1_20220113.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
> :#! /cephfs/db/releases/20220110210807/lkp-src/include/site/inn:
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> :#! runtime status:
> last_kernel: 5.16.0-wt-ath-08762-g8113de0a1f5c
> repeat_to: 3
> schedule_notify_address:
> :#! user overrides:
> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/1a61b300c09b1d034534372349e8f9d3aba6c392/vmlinuz-5.16.0-rc8-00117-g1a61b300c09b"
> dequeue_time: 2022-01-14 15:49:26.429322873 +08:00
> :#! /cephfs/db/releases/20220114102343/lkp-src/include/site/inn:
> job_state: finished
> loadavg: 3.07 3.75 2.67 1/1365 39754
> start_time: '1642146658'
> end_time: '1642147619'
> version: "/lkp/lkp/.src-20220114-102801:cf13e694:4c8d5b395"

> dmsetup remove_all
> wipefs -a --force /dev/nvme1n1p1
> mkfs -t btrfs /dev/nvme1n1p1
> mkdir -p /fs/nvme1n1p1
> mount -t btrfs /dev/nvme1n1p1 /fs/nvme1n1p1
> 
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
> 	online_file="$cpu_dir"/online
> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
> 
> 	file="$cpu_dir"/cpufreq/scaling_governor
> 	[ -f "$file" ] && echo "performance" > "$file"
> done
> 
> fs_mark -d /fs/nvme1n1p1/1 -d /fs/nvme1n1p1/2 -d /fs/nvme1n1p1/3 -d /fs/nvme1n1p1/4 -D 16 -N 256 -n 98304 -L 8 -S 1 -s 8192

