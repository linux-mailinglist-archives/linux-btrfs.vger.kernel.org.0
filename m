Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5F7AF3A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjIZTB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjIZTBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 15:01:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD2C192
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:01:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B5BC433C8;
        Tue, 26 Sep 2023 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695754900;
        bh=Y43Mt7SVzeEKObqNSF72Ed83BN/6HYzWMSD2oQXapMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPCTxbThstPfyA0NhI4ySWrDHI0WTxTrbM3csmZ+xdDEOdsDKC/x/cptMk1UC9j/D
         rezldnVfo+ywCkO+nXivjui7F8ftV/7XoRXuktWB14Ols1aLklXeKObZgT8z2hNt4f
         0O+zZCYIlBOon5OYRp+W29C+tCpqQyv3aBbmte5+C8c/0socCufiJ/Lo0Rwgq/JC6Q
         4KvKoSgkA3gt3tB2AV+MCxUihWMqLge7/Kj+nEzjqJbG+yk7CYE7RiDZX+JPvtTQfZ
         yC3eaCHKGVKk9xfK41N0hBVOzrC8yNWJweUGg02H5d262UzssflYqvAscBxtb8H7hE
         bIGaTh3CCaIuQ==
Date:   Tue, 26 Sep 2023 20:01:35 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Filipe Manana <fdmanana@suse.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]
 6c9131ed0d: stress-ng.sync-file.ops_per_sec -44.2% regression
Message-ID: <ZRMqjzDP/G+MKL5R@debian0.Home>
References: <202309261552.a03eeb4c-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202309261552.a03eeb4c-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 03:34:59PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -44.2% regression of stress-ng.sync-file.ops_per_sec on:
> 
> 
> commit: 6c9131ed0d644324adeeaccd2feeef8d04950b2d ("btrfs: always reserve space for delayed refs when starting transaction")
> https://github.com/kdave/btrfs-devel.git dev/guilherme/temp-fsid-v4

David, can you remove this patch from misc-next/for-next in the meanwhile?

Starting to reserve space in advance for delayed refs is causing the slowdown,
and I can reproduce it with the stress-ng test reported below.

By avoiding refilling the delayed block reserve I can recover about 60% of the
lost performance, but that increases the chance in extreme scenarios of exhausting
the global reserve and reaching a dead end -ENOSPC while committing transactions.
It has happened rarely, both upstream and on SLE kernels.

At the moment I don't see how to keep both the upfront reservation of space for
delayed refs and the refill of the delayed refs reserve without the performance
impact on a test like that stress-ng test.

Thanks.


> 
> testcase: stress-ng
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
> parameters:
> 
> 	nr_threads: 10%
> 	disk: 1SSD
> 	testtime: 60s
> 	fs: btrfs
> 	class: filesystem
> 	test: sync-file
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------------+
> | testcase: change | fio-basic: fio.write_iops -11.2% regression                                               |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
> | test parameters  | bs=4k                                                                                     |
> |                  | cpufreq_governor=performance                                                              |
> |                  | disk=1HDD                                                                                 |
> |                  | fs=btrfs                                                                                  |
> |                  | ioengine=ftruncate                                                                        |
> |                  | nr_task=100%                                                                              |
> |                  | runtime=300s                                                                              |
> |                  | rw=write                                                                                  |
> |                  | test_size=128G                                                                            |
> +------------------+-------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309261552.a03eeb4c-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230926/202309261552.a03eeb4c-oliver.sang@intel.com
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/sync-file/stress-ng/60s
> 
> commit: 
>   d80879b7d6 ("btrfs: stop doing excessive space reservation for csum deletion")
>   6c9131ed0d ("btrfs: always reserve space for delayed refs when starting transaction")
> 
> d80879b7d6aff432 6c9131ed0d644324adeeaccd2fe 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      10499 ± 10%     -18.6%       8544 ±  3%  meminfo.Active(file)
>      91.01            +1.6%      92.44        iostat.cpu.idle
>       0.13 ±  4%    +742.3%       1.12 ± 12%  iostat.cpu.iowait
>       4.19           -16.5%       3.49        iostat.cpu.system
>       4.67           -36.9%       2.94 ±  4%  iostat.cpu.user
>     135390 ±  3%     +46.3%     198023 ±  3%  vmstat.io.bo
>       3.00           -33.3%       2.00        vmstat.procs.r
>      36293           +17.3%      42567 ±  2%  vmstat.system.cs
>      52794            +2.8%      54279        vmstat.system.in
>       0.13 ±  4%      +1.0        1.15 ± 12%  mpstat.cpu.all.iowait%
>       0.72 ±  2%      +0.3        0.99 ±  4%  mpstat.cpu.all.irq%
>       0.03 ±  7%      +0.0        0.04 ±  7%  mpstat.cpu.all.soft%
>       3.50            -1.0        2.51 ±  2%  mpstat.cpu.all.sys%
>       4.78            -1.8        3.00 ±  4%  mpstat.cpu.all.usr%
>      20683           -44.2%      11546 ±  5%  stress-ng.sync-file.ops
>     344.72           -44.2%     192.43 ±  5%  stress-ng.sync-file.ops_per_sec
>      71365 ±  3%    +502.5%     429994 ±  8%  stress-ng.time.file_system_outputs
>     273.50           -42.5%     157.33 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
>      72.33           -41.6%      42.21 ±  4%  stress-ng.time.system_time
>      97.83           -43.0%      55.78 ±  4%  stress-ng.time.user_time
>      54130 ±  2%     +45.3%      78669 ±  6%  stress-ng.time.voluntary_context_switches
>     359.83           -31.2%     247.50 ±  2%  turbostat.Avg_MHz
>       9.56            -2.4        7.20        turbostat.Busy%
>       3764            -8.7%       3436        turbostat.Bzy_MHz
>    1083169           +21.5%    1316512 ±  2%  turbostat.C1E
>       4.48            +2.8        7.24 ±  6%  turbostat.C1E%
>       0.11           +30.3%       0.14 ±  3%  turbostat.IPC
>      45335 ±  8%    +122.2%     100745 ±  8%  turbostat.POLL
>       0.02            +0.0        0.06 ± 11%  turbostat.POLL%
>      84.17           -12.5%      73.64        turbostat.PkgWatt
>      11555           -47.0%       6125 ± 33%  sched_debug.cfs_rq:/.avg_vruntime.avg
>     105327 ±  6%     -52.8%      49736 ± 38%  sched_debug.cfs_rq:/.avg_vruntime.max
>      22835 ±  3%     -55.8%      10104 ± 38%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>      11555           -47.0%       6125 ± 33%  sched_debug.cfs_rq:/.min_vruntime.avg
>     105327 ±  6%     -52.8%      49736 ± 38%  sched_debug.cfs_rq:/.min_vruntime.max
>      22836 ±  3%     -55.8%      10104 ± 38%  sched_debug.cfs_rq:/.min_vruntime.stddev
>      79.98 ± 15%     -28.8%      56.92 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     832.17           -21.1%     656.67 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     215.60 ±  5%     -29.5%     151.99 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     222796 ± 14%     -46.0%     120393 ± 45%  sched_debug.cpu.nr_switches.max
>      43389 ±  9%     -40.3%      25896 ± 50%  sched_debug.cpu.nr_switches.stddev
>       2624 ± 10%     -18.7%       2133 ±  3%  proc-vmstat.nr_active_file
>    2228941 ±  3%     +43.9%    3208058 ±  3%  proc-vmstat.nr_dirtied
>      10236            +2.7%      10513        proc-vmstat.nr_mapped
>    2228950 ±  3%     +43.9%    3208079 ±  3%  proc-vmstat.nr_written
>       2624 ± 10%     -18.7%       2133 ±  3%  proc-vmstat.nr_zone_active_file
>    1791181 ±  2%     +30.5%    2337777 ±  4%  proc-vmstat.numa_hit
>    1788181 ±  2%     +31.0%    2342800 ±  4%  proc-vmstat.numa_local
>     442749 ±  2%     +53.9%     681290 ± 10%  proc-vmstat.pgactivate
>    1814457 ±  2%     +30.6%    2369210 ±  4%  proc-vmstat.pgalloc_normal
>     209992            +2.7%     215559        proc-vmstat.pgfault
>    1767669 ±  2%     +31.2%    2319090 ±  4%  proc-vmstat.pgfree
>    8933836 ±  3%     +45.9%   13035524 ±  3%  proc-vmstat.pgpgout
>       0.00 ± 58%    +236.4%       0.01 ± 74%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
>       0.00 ± 44%    +400.0%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>       0.00 ± 50%    +160.0%       0.01 ± 36%  perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.__btrfs_wait_cache_io.btrfs_start_dirty_block_groups
>       0.00           +58.3%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.00          +116.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
>       0.00 ±156%    +353.8%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
>       0.00 ± 83%    +188.9%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
>       0.00           +44.4%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00 ±  9%     +34.8%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.wait_current_trans.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
>       0.00 ± 12%     +50.0%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.wait_current_trans.start_transaction.btrfs_truncate.btrfs_setsize.isra
>       0.01 ± 64%    +259.2%       0.03 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_commit_transaction
>       0.01 ± 38%    +102.6%       0.01 ±  8%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.00 ± 10%    +542.9%       0.03 ± 63%  perf-sched.sch_delay.max.ms.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>       0.01 ± 51%    +256.6%       0.05 ± 42%  perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.__btrfs_wait_cache_io.btrfs_start_dirty_block_groups
>       0.02 ± 39%    +244.2%       0.06 ±  9%  perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.__btrfs_wait_cache_io.btrfs_write_dirty_block_groups
>       0.01 ± 36%     +66.7%       0.02 ± 33%  perf-sched.sch_delay.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delayed_refs_rsv_refill
>       0.03 ± 27%     +95.0%       0.06 ± 22%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
>       0.01 ± 10%    +268.8%       0.05 ± 13%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
>       0.01 ± 10%     +66.1%       0.02 ± 19%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.00 ±156%   +1407.7%       0.03 ± 25%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
>       0.02 ± 16%    +190.0%       0.05 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
>       0.01 ± 24%    +120.6%       0.01 ±  6%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.01 ± 13%    +112.7%       0.02 ± 18%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.01 ± 43%    +233.3%       0.04 ± 12%  perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
>       0.01 ± 57%    +189.2%       0.03 ± 28%  perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_truncate.btrfs_setsize.isra
>       2.55 ± 31%     -35.1%       1.66 ± 42%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      91749           +16.3%     106682 ±  6%  perf-sched.total_wait_and_delay.count.ms
>       0.11 ±  7%    +673.4%       0.88 ± 33%  perf-sched.wait_and_delay.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
>       0.07 ±  7%     +56.4%       0.11 ± 37%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
>     304.58            -8.8%     277.73 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       6.63 ± 14%     -29.9%       4.65 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     563.39 ±  5%     -22.5%     436.67 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       2886 ± 13%    +245.8%       9982 ± 23%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
>     622.83 ± 10%     +72.0%       1071 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     316.33 ±  6%     +48.7%     470.33 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       6577 ±  8%     +14.1%       7504 ± 10%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.12 ± 36%    +346.4%       0.55 ± 42%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.11 ±  6%    +703.4%       0.87 ± 33%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_metadata_bytes.start_transaction
>       0.07 ±  7%     +55.7%       0.11 ± 37%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
>     304.58            -8.8%     277.73 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.01 ± 62%   +1181.8%       0.19 ±192%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
>       6.63 ± 14%     -29.9%       4.64 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     562.83 ±  6%     -22.4%     436.66 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.23 ± 45%    +222.6%       0.74 ± 36%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
>       0.10 ± 29%   +1271.7%       1.32 ± 26%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_sync_file.__x64_sys_fdatasync
>       0.17 ±121%    +755.1%       1.42 ± 43%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_truncate.btrfs_setsize.isra
>       1.52 ± 18%    +820.9%      14.02 ±127%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       1.19 ± 69%    +608.9%       8.46 ± 80%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_commit_transaction
>       0.15 ±203%   +4798.4%       7.11 ± 64%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
>       0.07 ±  5%  +40103.4%      27.27 ±158%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
>       4.89 ±125%    +179.1%      13.66 ± 40%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
>       0.30 ± 35%   +2013.1%       6.40 ± 41%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_sync_file.__x64_sys_fdatasync
>       4.37 ±124%    +172.7%      11.91 ± 51%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_truncate.btrfs_setsize.isra
>       0.11 ± 10%     +33.0%       0.14 ±  3%  perf-stat.i.MPKI
>  8.058e+08           -15.9%  6.778e+08        perf-stat.i.branch-instructions
>       1.74            +0.1        1.82        perf-stat.i.branch-miss-rate%
>   17570571            -7.7%   16220035 ±  2%  perf-stat.i.branch-misses
>       6.91 ±  4%      -0.7        6.19 ±  4%  perf-stat.i.cache-miss-rate%
>     707872 ±  3%     +11.4%     788836        perf-stat.i.cache-misses
>    6021967 ±  2%     +37.0%    8247385 ±  2%  perf-stat.i.cache-references
>      37785           +17.4%      44340        perf-stat.i.context-switches
>       3.13           -17.2%       2.59        perf-stat.i.cpi
>  1.257e+10           -32.6%   8.47e+09 ±  3%  perf-stat.i.cpu-cycles
>      68.81 ±  2%     +23.9%      85.27 ±  3%  perf-stat.i.cpu-migrations
>      88843 ±  4%     -52.0%      42678 ±  8%  perf-stat.i.cycles-between-cache-misses
>       0.45            -0.1        0.32 ±  3%  perf-stat.i.dTLB-load-miss-rate%
>    4584350           -43.1%    2608740 ±  4%  perf-stat.i.dTLB-load-misses
>  1.105e+09           -16.0%  9.279e+08        perf-stat.i.dTLB-loads
>  6.732e+08           -22.3%  5.232e+08 ±  2%  perf-stat.i.dTLB-stores
>      78.39            -9.3       69.11        perf-stat.i.iTLB-load-miss-rate%
>    4906270 ±  2%     -45.2%    2687083 ±  5%  perf-stat.i.iTLB-load-misses
>    1221451 ±  4%     -10.3%    1095174 ±  2%  perf-stat.i.iTLB-loads
>  4.415e+09           -16.6%   3.68e+09        perf-stat.i.instructions
>       0.36           +19.4%       0.43        perf-stat.i.ipc
>       0.35           -32.6%       0.24 ±  3%  perf-stat.i.metric.GHz
>     205.37 ±  2%     +29.2%     265.27 ±  2%  perf-stat.i.metric.K/sec
>      71.75           -17.6%      59.11        perf-stat.i.metric.M/sec
>       1910            +4.1%       1989        perf-stat.i.minor-faults
>      65257 ±  6%     +52.0%      99201        perf-stat.i.node-stores
>       1910            +4.1%       1989        perf-stat.i.page-faults
>       0.16 ±  2%     +33.7%       0.21        perf-stat.overall.MPKI
>       2.18            +0.2        2.39        perf-stat.overall.branch-miss-rate%
>      11.75 ±  3%      -2.2        9.57 ±  3%  perf-stat.overall.cache-miss-rate%
>       2.85           -19.2%       2.30        perf-stat.overall.cpi
>      17782 ±  3%     -39.6%      10745 ±  2%  perf-stat.overall.cycles-between-cache-misses
>       0.41            -0.1        0.28 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
>       0.00 ±  3%      +0.0        0.00 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
>      80.06            -9.1       71.01        perf-stat.overall.iTLB-load-miss-rate%
>     900.18 ±  2%     +52.4%       1372 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
>       0.35           +23.7%       0.43        perf-stat.overall.ipc
>   7.93e+08           -15.9%  6.671e+08        perf-stat.ps.branch-instructions
>   17290247            -7.6%   15967777 ±  2%  perf-stat.ps.branch-misses
>     696216 ±  3%     +11.4%     775874        perf-stat.ps.cache-misses
>    5925900 ±  2%     +37.0%    8117167 ±  2%  perf-stat.ps.cache-references
>      37185           +17.3%      43634        perf-stat.ps.context-switches
>  1.237e+10           -32.6%  8.337e+09 ±  3%  perf-stat.ps.cpu-cycles
>      67.72 ±  2%     +23.9%      83.91 ±  3%  perf-stat.ps.cpu-migrations
>    4512549           -43.1%    2567904 ±  4%  perf-stat.ps.dTLB-load-misses
>  1.088e+09           -16.0%  9.133e+08        perf-stat.ps.dTLB-loads
>  6.626e+08           -22.3%  5.149e+08 ±  2%  perf-stat.ps.dTLB-stores
>    4829299 ±  2%     -45.2%    2645024 ±  5%  perf-stat.ps.iTLB-load-misses
>    1202224 ±  4%     -10.3%    1077818 ±  2%  perf-stat.ps.iTLB-loads
>  4.345e+09           -16.6%  3.622e+09        perf-stat.ps.instructions
>       1878            +4.2%       1956        perf-stat.ps.minor-faults
>      64207 ±  6%     +52.0%      97622        perf-stat.ps.node-stores
>       1878            +4.2%       1957        perf-stat.ps.page-faults
>  2.763e+11           -16.8%  2.298e+11        perf-stat.total.instructions
>      66.48 ±  4%     -10.1       56.36        perf-profile.calltrace.cycles-pp.sync_file_range
>      36.12 ±  4%      -5.5       30.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sync_file_range
>      25.64 ±  4%      -3.9       21.72 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync_file_range
>      18.86 ±  5%      -2.9       15.91        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sync_file_range
>      16.66 ±  5%      -2.7       13.94 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync_file_range
>       9.10 ±  5%      -1.2        7.89 ±  2%  perf-profile.calltrace.cycles-pp.__entry_text_start.sync_file_range
>       7.30 ±  4%      -0.9        6.36 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_sync_file_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync_file_range
>       3.20 ±  5%      -0.5        2.73 ±  4%  perf-profile.calltrace.cycles-pp.sync_file_range.__x64_sys_sync_file_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync_file_range
>       2.64 ±  6%      -0.3        2.32 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.sync_file_range
>       1.07 ±  8%      -0.2        0.91 ±  5%  perf-profile.calltrace.cycles-pp.file_fdatawait_range.sync_file_range.__x64_sys_sync_file_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.96 ±  9%      -0.1        0.83 ±  6%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_fdatawait_range.sync_file_range.__x64_sys_sync_file_range.do_syscall_64
>       0.75 ±  7%      -0.1        0.65 ±  7%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_fdatawait_range.__x64_sys_sync_file_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.57 ±  6%      +0.2        0.81 ±  9%  perf-profile.calltrace.cycles-pp.clock_nanosleep
>       0.62 ± 10%      +0.5        1.13 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>       0.62 ±  9%      +0.5        1.14 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>       0.68 ±  9%      +0.6        1.27 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       0.00            +0.6        0.62 ± 16%  perf-profile.calltrace.cycles-pp.__btrfs_write_out_cache.btrfs_write_out_cache.btrfs_write_dirty_block_groups.commit_cowonly_roots.btrfs_commit_transaction
>       0.00            +0.6        0.62 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_write_out_cache.btrfs_write_dirty_block_groups.commit_cowonly_roots.btrfs_commit_transaction.flush_space
>       0.38 ± 70%      +0.6        1.01 ± 10%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>       0.00            +0.7        0.66 ± 12%  perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
>       0.00            +0.7        0.70 ± 16%  perf-profile.calltrace.cycles-pp.truncate_pagecache.btrfs_truncate_free_space_cache.cache_save_setup.btrfs_start_dirty_block_groups.btrfs_commit_transaction
>       0.00            +0.7        0.70 ± 16%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.truncate_pagecache.btrfs_truncate_free_space_cache.cache_save_setup.btrfs_start_dirty_block_groups
>       0.00            +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
>       0.00            +0.8        0.77 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_truncate_free_space_cache.cache_save_setup.btrfs_start_dirty_block_groups.btrfs_commit_transaction.flush_space
>       1.01 ±  8%      +0.8        1.79 ±  9%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.00            +0.8        0.78 ±  9%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
>       0.00            +0.8        0.82 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_write_dirty_block_groups.commit_cowonly_roots.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_fdatawrite_range.__btrfs_write_out_cache.btrfs_write_out_cache.btrfs_start_dirty_block_groups
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.__btrfs_write_out_cache.btrfs_write_out_cache
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.__btrfs_write_out_cache
>       0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_fdatawrite_range.__btrfs_write_out_cache.btrfs_write_out_cache.btrfs_start_dirty_block_groups.btrfs_commit_transaction
>       0.00            +0.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.00            +0.8        0.83 ± 15%  perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
>       0.00            +0.8        0.84 ± 16%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
>       0.00            +0.8        0.84 ± 16%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
>       0.00            +0.8        0.84 ± 16%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space
>       0.00            +0.8        0.84 ± 16%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
>       0.19 ±142%      +0.8        1.04 ± 14%  perf-profile.calltrace.cycles-pp.cache_save_setup.btrfs_start_dirty_block_groups.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
>       0.00            +0.8        0.85 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
>       0.00            +0.9        0.90 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>       1.28 ±  8%      +1.0        2.27 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       1.29 ±  8%      +1.0        2.30 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       0.79 ± 46%      +1.2        1.98 ± 15%  perf-profile.calltrace.cycles-pp.__btrfs_write_out_cache.btrfs_write_out_cache.btrfs_start_dirty_block_groups.btrfs_commit_transaction.flush_space
>       0.80 ± 46%      +1.2        2.01 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_write_out_cache.btrfs_start_dirty_block_groups.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
>       0.00            +1.2        1.23 ± 14%  perf-profile.calltrace.cycles-pp.commit_cowonly_roots.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>       1.72 ± 11%      +1.2        2.96 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       1.88 ± 11%      +1.4        3.24 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       1.09 ± 37%      +1.5        2.60 ± 25%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       1.44 ± 23%      +2.0        3.45 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_start_dirty_block_groups.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>       1.82 ± 23%      +4.0        5.82 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
>       2.06 ± 24%      +4.3        6.34 ± 14%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread
>       2.06 ± 24%      +4.3        6.36 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
>       2.10 ± 24%      +4.4        6.46 ± 14%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       2.12 ± 23%      +4.4        6.53 ± 14%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       2.15 ± 23%      +4.4        6.57 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>       2.15 ± 23%      +4.4        6.57 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>       2.15 ± 23%      +4.4        6.57 ± 14%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>      27.62 ± 11%      +4.5       32.16        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>      27.45 ± 11%      +4.9       32.33        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>      27.79 ± 11%      +5.2       32.98        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      28.51 ± 10%      +5.4       33.86        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      28.04 ± 11%      +5.4       33.44        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      28.05 ± 11%      +5.4       33.47        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      28.05 ± 11%      +5.4       33.47        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      69.96 ±  4%     -10.6       59.40        perf-profile.children.cycles-pp.sync_file_range
>      37.42 ±  4%      -5.2       32.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      26.79 ±  4%      -3.7       23.14        perf-profile.children.cycles-pp.do_syscall_64
>      19.14 ±  5%      -2.9       16.20        perf-profile.children.cycles-pp.syscall_return_via_sysret
>      16.85 ±  5%      -2.7       14.15 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       9.00 ±  5%      -1.2        7.83 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
>       7.31 ±  4%      -0.9        6.38 ±  3%  perf-profile.children.cycles-pp.__x64_sys_sync_file_range
>       1.91 ±  7%      -0.3        1.64 ±  4%  perf-profile.children.cycles-pp.file_fdatawait_range
>       1.42 ±  6%      -0.2        1.17 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       1.65 ±  5%      -0.2        1.45 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       1.49 ±  4%      -0.2        1.32 ±  6%  perf-profile.children.cycles-pp.file_check_and_advance_wb_err
>       0.62 ±  5%      -0.1        0.52 ±  8%  perf-profile.children.cycles-pp.stress_sync_file
>       0.30 ± 11%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.stress_mwc32
>       0.08 ± 21%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
>       0.10 ± 12%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.btrfs_truncate
>       0.12 ± 11%      +0.0        0.16 ± 13%  perf-profile.children.cycles-pp.do_sys_ftruncate
>       0.06 ± 47%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.run_rebalance_domains
>       0.14 ± 12%      +0.0        0.18 ± 15%  perf-profile.children.cycles-pp.hrtimer_wakeup
>       0.09 ± 16%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
>       0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
>       0.11 ± 13%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.do_truncate
>       0.11 ± 12%      +0.0        0.16 ± 11%  perf-profile.children.cycles-pp.btrfs_setattr
>       0.02 ±141%      +0.0        0.07 ± 15%  perf-profile.children.cycles-pp.tick_sched_do_timer
>       0.11 ± 12%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.notify_change
>       0.05 ± 47%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.07 ± 14%      +0.0        0.12 ± 18%  perf-profile.children.cycles-pp.sched_clock
>       0.02 ±142%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_core
>       0.06 ± 11%      +0.1        0.11 ± 27%  perf-profile.children.cycles-pp.tick_nohz_next_event
>       0.01 ±223%      +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.btrfs_get_extent
>       0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_pending
>       0.02 ±141%      +0.1        0.07 ± 27%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>       0.12 ± 11%      +0.1        0.18 ± 12%  perf-profile.children.cycles-pp.ftruncate64
>       0.08 ± 19%      +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.start_transaction
>       0.08 ± 18%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.08 ± 11%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.perf_pmu_nop_void
>       0.10 ± 16%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.03 ±100%      +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.folio_add_lru
>       0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.extent_buffer_write_end_io
>       0.07 ± 12%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
>       0.08 ± 16%      +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.native_sched_clock
>       0.11 ± 13%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.activate_task
>       0.11 ± 30%      +0.1        0.17 ± 20%  perf-profile.children.cycles-pp.rebalance_domains
>       0.00            +0.1        0.06 ± 28%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>       0.01 ±223%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__alloc_pages
>       0.05 ± 72%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.01 ±223%      +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.btrfs_work_helper
>       0.05 ± 77%      +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>       0.02 ±142%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.folio_alloc
>       0.08 ± 18%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.dequeue_entity
>       0.05 ± 46%      +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.arch_scale_freq_tick
>       0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.lock_delalloc_pages
>       0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.nvme_queue_rq
>       0.01 ±223%      +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.__mod_node_page_state
>       0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.__blk_mq_issue_directly
>       0.01 ±223%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.__mod_lruvec_state
>       0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.blk_mq_try_issue_directly
>       0.12 ± 11%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.09 ± 11%      +0.1        0.17 ± 17%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.05 ± 74%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.run_delalloc_nocow
>       0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.folio_wait_bit_common
>       0.05 ± 74%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
>       0.09 ± 29%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.find_busiest_group
>       0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.folio_wait_writeback
>       0.01 ±223%      +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.try_release_extent_mapping
>       0.02 ±141%      +0.1        0.09 ± 34%  perf-profile.children.cycles-pp.btrfs_lookup_inode
>       0.01 ±223%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.xas_load
>       0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.nvme_prep_rq
>       0.06 ± 51%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.alloc_extent_state
>       0.01 ±223%      +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.clear_state_bit
>       0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__wake_up_common
>       0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.check_extent_data_item
>       0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.folio_account_dirtied
>       0.12 ±  8%      +0.1        0.20 ± 16%  perf-profile.children.cycles-pp.schedule_idle
>       0.07 ± 53%      +0.1        0.16 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.newidle_balance
>       0.03 ±100%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.lock_extent
>       0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.filemap_get_entry
>       0.12 ± 13%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.read_tsc
>       0.03 ±101%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.find_lock_delalloc_range
>       0.02 ±141%      +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.14 ± 18%      +0.1        0.23 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
>       0.05 ± 47%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.__set_extent_bit
>       0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.write_one_eb
>       0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.lookup_inline_extent_backref
>       0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.lookup_extent_backref
>       0.00            +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.memmove_extent_buffer
>       0.01 ±223%      +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.clear_page_erms
>       0.12 ± 30%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.load_balance
>       0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.folio_mark_accessed
>       0.04 ±104%      +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
>       0.09 ± 10%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.btrfs_get_64
>       0.01 ±223%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       0.27 ±  9%      +0.1        0.37 ± 14%  perf-profile.children.cycles-pp.hrtimer_nanosleep
>       0.25 ±  8%      +0.1        0.34 ± 15%  perf-profile.children.cycles-pp.do_nanosleep
>       0.10 ± 14%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.12 ± 14%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>       0.08 ± 35%      +0.1        0.18 ± 25%  perf-profile.children.cycles-pp.alloc_reserved_file_extent
>       0.06 ± 47%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.__folio_mark_dirty
>       0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.01 ±223%      +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.xas_store
>       0.02 ±142%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
>       0.04 ± 75%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.28 ±  9%      +0.1        0.38 ± 13%  perf-profile.children.cycles-pp.common_nsleep
>       0.03 ±101%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.submit_one_bio
>       0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__memmove
>       0.07 ± 18%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.__folio_batch_release
>       0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.check_block_group_item
>       0.12 ± 24%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.17 ± 14%      +0.1        0.28 ± 10%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>       0.08 ± 16%      +0.1        0.19 ± 17%  perf-profile.children.cycles-pp.release_pages
>       0.00            +0.1        0.11 ± 36%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
>       0.02 ±141%      +0.1        0.13 ± 21%  perf-profile.children.cycles-pp.filemap_fdatawait_range
>       0.07 ± 52%      +0.1        0.18 ± 33%  perf-profile.children.cycles-pp.__filemap_add_folio
>       0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.write_all_supers
>       0.16 ± 13%      +0.1        0.28 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
>       0.03 ±102%      +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.btrfs_update_inode_item
>       0.06 ± 51%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>       0.07 ± 17%      +0.1        0.19 ± 16%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
>       0.29 ±  7%      +0.1        0.41 ± 13%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
>       0.18 ± 13%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
>       0.21 ± 20%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.intel_idle_irq
>       0.08 ± 29%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.submit_extent_page
>       0.00            +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.read_extent_buffer
>       0.03 ±100%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.__btrfs_wait_cache_io
>       0.03 ±102%      +0.1        0.17 ± 10%  perf-profile.children.cycles-pp.blk_mq_submit_bio
>       0.11 ± 28%      +0.1        0.26 ± 17%  perf-profile.children.cycles-pp.writepage_delalloc
>       0.03 ±102%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
>       0.25 ± 22%      +0.1        0.40 ± 10%  perf-profile.children.cycles-pp.__do_softirq
>       0.09 ± 22%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.filemap_dirty_folio
>       0.10 ± 24%      +0.2        0.26 ± 13%  perf-profile.children.cycles-pp.btrfs_dirty_pages
>       0.12 ± 22%      +0.2        0.28 ± 15%  perf-profile.children.cycles-pp.__clear_extent_bit
>       0.12 ± 30%      +0.2        0.28 ± 25%  perf-profile.children.cycles-pp.filemap_add_folio
>       0.20 ± 31%      +0.2        0.36 ± 15%  perf-profile.children.cycles-pp.ktime_get
>       0.10 ± 24%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.__folio_end_writeback
>       0.08 ± 22%      +0.2        0.24 ± 16%  perf-profile.children.cycles-pp.__folio_start_writeback
>       0.31 ± 21%      +0.2        0.48 ±  7%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.02 ±142%      +0.2        0.20 ± 20%  perf-profile.children.cycles-pp.__write_extent_buffer
>       0.17 ± 10%      +0.2        0.35 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.10 ± 25%      +0.2        0.28 ± 17%  perf-profile.children.cycles-pp.btrfs_set_range_writeback
>       0.22 ±  8%      +0.2        0.42 ± 10%  perf-profile.children.cycles-pp.schedule
>       0.00            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.btrfs_get_32
>       0.01 ±223%      +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.btrfs_cow_block
>       0.01 ±223%      +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.__btrfs_cow_block
>       0.15 ± 23%      +0.2        0.38 ± 16%  perf-profile.children.cycles-pp.crc_pcl
>       0.13 ± 23%      +0.2        0.36 ±  7%  perf-profile.children.cycles-pp.folio_end_writeback
>       0.19 ± 27%      +0.2        0.42 ± 15%  perf-profile.children.cycles-pp.run_delayed_data_ref
>       0.26 ± 10%      +0.2        0.51 ±  8%  perf-profile.children.cycles-pp.menu_select
>       0.57 ±  6%      +0.2        0.82 ±  9%  perf-profile.children.cycles-pp.clock_nanosleep
>       0.16 ± 26%      +0.2        0.41 ± 18%  perf-profile.children.cycles-pp.btrfs_search_slot
>       0.18 ± 23%      +0.2        0.43 ± 20%  perf-profile.children.cycles-pp.btrfs_invalidate_folio
>       0.21 ± 30%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.end_bio_extent_writepage
>       0.21 ± 30%      +0.3        0.46 ±  8%  perf-profile.children.cycles-pp.__btrfs_bio_end_io
>       0.19 ± 21%      +0.3        0.44 ± 20%  perf-profile.children.cycles-pp.truncate_cleanup_folio
>       0.04 ± 71%      +0.3        0.29 ± 20%  perf-profile.children.cycles-pp.btrfs_set_token_32
>       0.17 ± 24%      +0.3        0.43 ± 17%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
>       0.20 ± 24%      +0.3        0.48 ± 15%  perf-profile.children.cycles-pp.crc32c
>       0.00            +0.3        0.28 ± 15%  perf-profile.children.cycles-pp.alloc_reserved_tree_block
>       0.33 ±  6%      +0.3        0.61 ± 11%  perf-profile.children.cycles-pp.__schedule
>       0.03 ±106%      +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.btrfs_get_token_32
>       0.22 ± 25%      +0.3        0.52 ± 15%  perf-profile.children.cycles-pp.io_ctl_set_crc
>       0.24 ± 28%      +0.3        0.58 ± 19%  perf-profile.children.cycles-pp.io_ctl_prepare_pages
>       0.22 ± 29%      +0.3        0.56 ± 19%  perf-profile.children.cycles-pp.__filemap_get_folio
>       0.22 ± 28%      +0.3        0.57 ±  9%  perf-profile.children.cycles-pp.blk_mq_end_request_batch
>       0.01 ±223%      +0.4        0.36 ± 16%  perf-profile.children.cycles-pp.check_leaf_item
>       0.00            +0.4        0.36 ± 24%  perf-profile.children.cycles-pp.run_delayed_tree_ref
>       0.22 ± 28%      +0.4        0.58 ± 19%  perf-profile.children.cycles-pp.pagecache_get_page
>       0.26 ± 20%      +0.4        0.62 ± 10%  perf-profile.children.cycles-pp.__extent_writepage_io
>       0.12 ± 25%      +0.4        0.49 ± 14%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
>       0.09 ± 28%      +0.4        0.46 ± 15%  perf-profile.children.cycles-pp.setup_items_for_insert
>       0.08 ± 19%      +0.4        0.46 ± 17%  perf-profile.children.cycles-pp.btrfs_del_items
>       0.50 ±  9%      +0.4        0.88 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
>       0.51 ±  9%      +0.4        0.89 ±  9%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.23 ± 30%      +0.4        0.62 ±  9%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
>       0.23 ± 30%      +0.4        0.62 ±  9%  perf-profile.children.cycles-pp.nvme_irq
>       0.23 ± 30%      +0.4        0.63 ± 10%  perf-profile.children.cycles-pp.handle_irq_event
>       0.23 ± 30%      +0.4        0.64 ± 10%  perf-profile.children.cycles-pp.handle_edge_irq
>       0.23 ± 30%      +0.4        0.64 ± 10%  perf-profile.children.cycles-pp.__common_interrupt
>       0.24 ± 29%      +0.4        0.66 ± 11%  perf-profile.children.cycles-pp.common_interrupt
>       0.24 ± 29%      +0.4        0.66 ± 10%  perf-profile.children.cycles-pp.asm_common_interrupt
>       0.32 ± 22%      +0.4        0.75 ± 17%  perf-profile.children.cycles-pp.truncate_pagecache
>       0.31 ± 22%      +0.4        0.75 ± 17%  perf-profile.children.cycles-pp.truncate_inode_pages_range
>       0.12 ± 23%      +0.5        0.59 ± 17%  perf-profile.children.cycles-pp.__btrfs_free_extent
>       0.34 ± 22%      +0.5        0.82 ± 16%  perf-profile.children.cycles-pp.btrfs_truncate_free_space_cache
>       0.68 ±  9%      +0.5        1.18 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
>       0.39 ± 25%      +0.5        0.91 ± 11%  perf-profile.children.cycles-pp.__extent_writepage
>       0.78 ±  9%      +0.5        1.33 ±  7%  perf-profile.children.cycles-pp.update_process_times
>       0.79 ±  8%      +0.6        1.34 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.26 ± 31%      +0.6        0.82 ± 14%  perf-profile.children.cycles-pp.btrfs_write_dirty_block_groups
>       0.51 ± 23%      +0.6        1.11 ± 14%  perf-profile.children.cycles-pp.cache_save_setup
>       0.87 ±  7%      +0.6        1.50 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.02 ±144%      +0.6        0.65 ± 17%  perf-profile.children.cycles-pp.__btrfs_check_leaf
>       0.02 ±144%      +0.6        0.65 ± 17%  perf-profile.children.cycles-pp.btrfs_check_leaf
>       0.47 ± 25%      +0.6        1.11 ± 13%  perf-profile.children.cycles-pp.extent_writepages
>       0.47 ± 25%      +0.6        1.11 ± 13%  perf-profile.children.cycles-pp.extent_write_cache_pages
>       0.47 ± 24%      +0.6        1.12 ± 13%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
>       0.03 ±105%      +0.7        0.71 ± 16%  perf-profile.children.cycles-pp.btree_csum_one_bio
>       0.15 ± 38%      +0.7        0.86 ±  9%  perf-profile.children.cycles-pp.poll_idle
>       0.10 ± 30%      +0.8        0.87 ± 15%  perf-profile.children.cycles-pp.btrfs_submit_chunk
>       0.10 ± 30%      +0.8        0.87 ± 15%  perf-profile.children.cycles-pp.btrfs_submit_bio
>       0.04 ± 74%      +0.8        0.83 ± 15%  perf-profile.children.cycles-pp.submit_eb_page
>       0.05 ± 73%      +0.8        0.84 ± 16%  perf-profile.children.cycles-pp.btree_write_cache_pages
>       0.05 ± 73%      +0.8        0.85 ± 16%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
>       1.26 ±  8%      +0.8        2.09 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.24 ± 27%      +0.8        1.09 ± 16%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
>       0.06 ± 49%      +0.8        0.90 ± 16%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
>       0.28 ± 27%      +0.9        1.14 ± 16%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
>       0.28 ± 27%      +0.9        1.14 ± 17%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
>       0.30 ± 28%      +0.9        1.23 ± 14%  perf-profile.children.cycles-pp.commit_cowonly_roots
>       1.55 ±  9%      +1.1        2.62 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       1.57 ±  9%      +1.1        2.64 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       2.06 ± 11%      +1.3        3.38 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       1.14 ± 14%      +1.4        2.50 ±  9%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
>       0.75 ± 22%      +1.4        2.13 ± 12%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
>       0.52 ± 24%      +1.4        1.96 ± 14%  perf-profile.children.cycles-pp.do_writepages
>       2.33 ± 11%      +1.5        3.78 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       1.11 ± 37%      +1.5        2.62 ± 25%  perf-profile.children.cycles-pp.intel_idle
>       1.09 ± 24%      +1.5        2.63 ± 14%  perf-profile.children.cycles-pp.__btrfs_write_out_cache
>       1.09 ± 24%      +1.5        2.64 ± 14%  perf-profile.children.cycles-pp.btrfs_write_out_cache
>       1.44 ± 23%      +2.0        3.45 ± 14%  perf-profile.children.cycles-pp.btrfs_start_dirty_block_groups
>       1.82 ± 23%      +4.0        5.82 ± 13%  perf-profile.children.cycles-pp.btrfs_commit_transaction
>       2.06 ± 24%      +4.3        6.35 ± 14%  perf-profile.children.cycles-pp.flush_space
>       2.06 ± 24%      +4.3        6.36 ± 14%  perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
>       2.10 ± 24%      +4.4        6.46 ± 14%  perf-profile.children.cycles-pp.process_one_work
>       2.12 ± 23%      +4.4        6.53 ± 14%  perf-profile.children.cycles-pp.worker_thread
>       2.16 ± 23%      +4.4        6.57 ± 14%  perf-profile.children.cycles-pp.ret_from_fork_asm
>       2.16 ± 23%      +4.4        6.57 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
>       2.15 ± 23%      +4.4        6.57 ± 14%  perf-profile.children.cycles-pp.kthread
>      27.90 ± 11%      +4.8       32.69        perf-profile.children.cycles-pp.cpuidle_enter_state
>      27.90 ± 11%      +4.8       32.70        perf-profile.children.cycles-pp.cpuidle_enter
>      28.26 ± 11%      +5.1       33.39        perf-profile.children.cycles-pp.cpuidle_idle_call
>      28.51 ± 10%      +5.4       33.86        perf-profile.children.cycles-pp.do_idle
>      28.51 ± 10%      +5.4       33.86        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      28.51 ± 10%      +5.4       33.86        perf-profile.children.cycles-pp.cpu_startup_entry
>      28.05 ± 11%      +5.4       33.47        perf-profile.children.cycles-pp.start_secondary
>      19.11 ±  5%      -2.9       16.17        perf-profile.self.cycles-pp.syscall_return_via_sysret
>      16.30 ±  5%      -2.6       13.68 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>      10.84 ±  5%      -1.6        9.21        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       7.86 ±  5%      -1.1        6.80 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
>       2.12 ±  6%      -0.3        1.82 ±  6%  perf-profile.self.cycles-pp.sync_file_range
>       1.23 ±  6%      -0.2        1.02 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       1.42 ±  4%      -0.2        1.25 ±  5%  perf-profile.self.cycles-pp.file_check_and_advance_wb_err
>       1.06 ±  6%      -0.1        0.91 ±  5%  perf-profile.self.cycles-pp.__x64_sys_sync_file_range
>       1.05 ±  5%      -0.1        0.92 ±  6%  perf-profile.self.cycles-pp.__filemap_fdatawait_range
>       0.65 ±  7%      -0.1        0.56 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.08 ± 10%      +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.perf_pmu_nop_void
>       0.01 ±223%      +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__hrtimer_run_queues
>       0.01 ±223%      +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.__schedule
>       0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
>       0.02 ±142%      +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.08 ± 17%      +0.1        0.14 ± 19%  perf-profile.self.cycles-pp.native_sched_clock
>       0.02 ±141%      +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
>       0.05 ± 46%      +0.1        0.12 ± 26%  perf-profile.self.cycles-pp.arch_scale_freq_tick
>       0.01 ±223%      +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.cpuidle_idle_call
>       0.00            +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.__mod_node_page_state
>       0.02 ±141%      +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.crc32c
>       0.00            +0.1        0.08 ± 23%  perf-profile.self.cycles-pp.__folio_end_writeback
>       0.06 ± 21%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.btrfs_del_items
>       0.01 ±223%      +0.1        0.09 ± 22%  perf-profile.self.cycles-pp.release_pages
>       0.01 ±223%      +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.14 ± 18%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
>       0.11 ± 16%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.read_tsc
>       0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.__write_extent_buffer
>       0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.btrfs_get_64
>       0.00            +0.1        0.09 ± 31%  perf-profile.self.cycles-pp.__btrfs_check_leaf
>       0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.clear_page_erms
>       0.00            +0.1        0.10 ± 30%  perf-profile.self.cycles-pp.setup_items_for_insert
>       0.00            +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.__memmove
>       0.11 ± 26%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.17 ± 14%      +0.1        0.28 ± 10%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>       0.12 ± 12%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.menu_select
>       0.00            +0.1        0.13 ± 13%  perf-profile.self.cycles-pp.read_extent_buffer
>       0.16 ± 10%      +0.2        0.33 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.22 ± 18%      +0.2        0.42 ±  3%  perf-profile.self.cycles-pp.cpuidle_enter_state
>       0.28 ± 10%      +0.2        0.48 ± 10%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
>       0.00            +0.2        0.21 ± 21%  perf-profile.self.cycles-pp.btrfs_get_32
>       0.15 ± 25%      +0.2        0.37 ± 18%  perf-profile.self.cycles-pp.crc_pcl
>       0.02 ±142%      +0.3        0.27 ± 20%  perf-profile.self.cycles-pp.btrfs_set_token_32
>       0.02 ±146%      +0.3        0.30 ± 12%  perf-profile.self.cycles-pp.btrfs_get_token_32
>       0.14 ± 38%      +0.7        0.84 ±  8%  perf-profile.self.cycles-pp.poll_idle
>       1.11 ± 37%      +1.5        2.62 ± 25%  perf-profile.self.cycles-pp.intel_idle
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> =========================================================================================
> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
>   4k/gcc-12/performance/1HDD/btrfs/ftruncate/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic
> 
> commit: 
>   d80879b7d6 ("btrfs: stop doing excessive space reservation for csum deletion")
>   6c9131ed0d ("btrfs: always reserve space for delayed refs when starting transaction")
> 
> d80879b7d6aff432 6c9131ed0d644324adeeaccd2fe 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      15.04 ± 12%     -40.5%       8.94 ± 10%  iostat.cpu.idle
>      84.23 ±  2%      +7.4%      90.44        iostat.cpu.system
>      13923 ±  7%     +31.9%      18370 ±  3%  sched_debug.cpu.avg_idle.min
>       4.15 ± 22%     +30.7%       5.42 ±  6%  sched_debug.cpu.clock.stddev
>      15545 ± 26%    +242.2%      53197 ±  9%  meminfo.Active(anon)
>     740596 ±  2%     -15.8%     623416 ±  3%  meminfo.Dirty
>      58563 ±  8%     +64.9%      96555 ±  5%  meminfo.Shmem
>      13.16 ± 15%      -6.0        7.14 ± 13%  mpstat.cpu.all.idle%
>       0.13 ± 27%      -0.1        0.07 ± 12%  mpstat.cpu.all.iowait%
>       0.02            -0.0        0.02 ±  5%  mpstat.cpu.all.soft%
>       0.58 ±  3%      -0.1        0.53 ±  2%  mpstat.cpu.all.usr%
>      13.52 ± 17%      -6.0        7.56 ± 12%  turbostat.C1%
>      13.02 ± 17%     -44.1%       7.28 ± 12%  turbostat.CPU%c1
>      60.83 ±  2%      +9.6%      66.67 ±  3%  turbostat.PkgTmp
>     337.21            +1.3%     341.42        turbostat.PkgWatt
>      14.50 ± 11%     -42.5%       8.33 ± 13%  vmstat.cpu.id
>      31509 ±  7%     +21.3%      38218 ±  2%  vmstat.io.bo
>     217220 ± 17%     -44.1%     121500 ± 17%  vmstat.system.cs
>     170878 ± 11%     -27.9%     123239 ±  8%  vmstat.system.in
>     370058           -15.7%     312135 ±  3%  numa-meminfo.node0.Dirty
>     932599 ± 38%    +136.7%    2207627 ± 53%  numa-meminfo.node0.FilePages
>     261078 ±138%    +486.3%    1530767 ± 78%  numa-meminfo.node0.Unevictable
>       6689 ± 92%    +329.1%      28703 ± 57%  numa-meminfo.node1.Active(anon)
>      26989 ±115%    +110.9%      56922 ± 55%  numa-meminfo.node1.AnonHugePages
>     369834 ±  2%     -15.7%     311910 ±  3%  numa-meminfo.node1.Dirty
>      92513           -15.6%      78039 ±  3%  numa-vmstat.node0.nr_dirty
>     233224 ± 38%    +136.8%     552294 ± 53%  numa-vmstat.node0.nr_file_pages
>      65269 ±138%    +486.3%     382691 ± 78%  numa-vmstat.node0.nr_unevictable
>     166993 ±  9%     +40.9%     235292 ±  4%  numa-vmstat.node0.nr_written
>      65269 ±138%    +486.3%     382691 ± 78%  numa-vmstat.node0.nr_zone_unevictable
>      92521           -15.6%      78049 ±  3%  numa-vmstat.node0.nr_zone_write_pending
>       1775 ± 90%    +307.7%       7236 ± 54%  numa-vmstat.node1.nr_active_anon
>      92461 ±  2%     -15.6%      78020 ±  3%  numa-vmstat.node1.nr_dirty
>     167011 ±  9%     +40.6%     234771 ±  4%  numa-vmstat.node1.nr_written
>       1775 ± 90%    +307.7%       7236 ± 54%  numa-vmstat.node1.nr_zone_active_anon
>      92467 ±  2%     -15.6%      78027 ±  3%  numa-vmstat.node1.nr_zone_write_pending
>       0.94 ± 18%      -0.5        0.46 ± 26%  fio.latency_100us%
>       0.15 ± 16%      -0.0        0.10 ± 12%  fio.latency_10us%
>      93.34            +2.9       96.23        fio.latency_250us%
>      85.21           +12.6%      95.98        fio.time.elapsed_time
>      85.21           +12.6%      95.98        fio.time.elapsed_time.max
>      47779 ±  2%     +30.7%      62438 ±  2%  fio.time.involuntary_context_switches
>       5565 ±  2%      +6.9%       5947        fio.time.percent_of_cpu_this_job_got
>       4720           +20.5%       5686        fio.time.system_time
>       1544           -11.2%       1370        fio.write_bw_MBps
>     391850 ±  4%     -19.7%     314709 ±  4%  fio.write_clat_99%_us
>     160205           +13.1%     181223        fio.write_clat_mean_us
>     395291           -11.2%     350824        fio.write_iops
>       4058 ± 24%    +224.3%      13163 ± 10%  proc-vmstat.nr_active_anon
>     185226 ±  2%     -15.8%     156031 ±  3%  proc-vmstat.nr_dirty
>      14662 ±  8%     +63.9%      24028 ±  5%  proc-vmstat.nr_shmem
>     335451 ±  9%     +39.2%     466844 ±  4%  proc-vmstat.nr_written
>       4058 ± 24%    +224.3%      13163 ± 10%  proc-vmstat.nr_zone_active_anon
>     185238 ±  2%     -15.8%     156047 ±  3%  proc-vmstat.nr_zone_write_pending
>    1731801            +0.9%    1747722        proc-vmstat.numa_hit
>    1665401            +1.0%    1681395        proc-vmstat.numa_local
>     393334            +5.6%     415532        proc-vmstat.pgfault
>     349710            +5.5%     368993        proc-vmstat.pgfree
>    2681920 ±  9%     +39.2%    3733194 ±  4%  proc-vmstat.pgpgout
>      13786 ±  2%      +8.0%      14893 ±  2%  proc-vmstat.pgreuse
>     816128 ±  5%      +9.2%     891136 ±  3%  proc-vmstat.unevictable_pgs_scanned
>       7.33 ±118%      -5.5        1.85 ±223%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       3.86 ± 73%      -1.1        2.78 ±141%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       3.86 ± 73%      -1.1        2.78 ±141%  perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.get_signal
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
>       6.14 ±113%      -4.3        1.85 ±223%  perf-profile.children.cycles-pp._compound_head
>       3.86 ± 73%      -2.5        1.39 ±223%  perf-profile.children.cycles-pp.tlb_finish_mmu
>       3.86 ± 73%      -1.1        2.78 ±141%  perf-profile.children.cycles-pp.put_files_struct
>       3.86 ± 73%      -1.1        2.78 ±141%  perf-profile.children.cycles-pp.filp_close
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.children.cycles-pp.__fput
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.children.cycles-pp.task_work_run
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.children.cycles-pp.perf_release
>       3.86 ± 73%      +0.5        4.36 ±149%  perf-profile.children.cycles-pp.perf_event_release_kernel
>       4.95 ±121%      -3.1        1.85 ±223%  perf-profile.self.cycles-pp._compound_head
>       3.55 ±104%      -1.4        2.18 ±149%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.03 ± 73%     -96.9%       0.00 ± 57%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_drop_extents.maybe_insert_hole.btrfs_cont_expand
>       0.00 ±152%    +433.3%       0.00 ± 41%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
>       0.05 ±  8%     +21.9%       0.06 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       3.25 ± 28%     -99.6%       0.01 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_drop_extents.maybe_insert_hole.btrfs_cont_expand
>       0.90 ± 65%     -81.0%       0.17 ± 96%  perf-sched.wait_and_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_drop_extents.maybe_insert_hole.btrfs_cont_expand
>       0.36 ± 41%     -55.4%       0.16 ± 49%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
>     335.83 ± 25%     -83.9%      54.00 ± 73%  perf-sched.wait_and_delay.count.__cond_resched.btrfs_alloc_path.btrfs_drop_extents.maybe_insert_hole.btrfs_cont_expand
>     625.17 ± 14%     +87.2%       1170 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
>     674.33 ± 14%     +77.6%       1197 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_dirty_inode.btrfs_setattr
>     232.33 ± 23%     -76.9%      53.67 ± 73%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_dirty_inode
>     375.00 ± 24%     -76.8%      87.17 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_setsize
>     889.33 ± 38%     +48.6%       1321 ±  4%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>       1318 ± 25%     +31.6%       1735 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       6.20 ± 35%     -70.6%       1.83 ± 93%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_dirty_inode
>       7.65 ±  6%     -47.8%       4.00 ± 43%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_setsize
>     657.21 ± 88%     -76.7%     153.27 ± 27%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>       0.86 ± 65%     -64.1%       0.31 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_drop_extents.maybe_insert_hole.btrfs_cont_expand
>       0.28 ± 93%     -89.1%       0.03 ±145%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
>       0.01 ±136%   +5431.2%       0.74 ±118%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_truncate.do_sys_ftruncate.do_syscall_64
>       0.36 ± 42%     -56.5%       0.15 ± 50%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
>       0.51 ± 23%     -95.1%       0.02 ±169%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
>       0.95 ±145%     -90.1%       0.09 ±158%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
>       5.34 ± 25%     -56.9%       2.30 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
>       0.02 ±123%   +5763.7%       1.00 ±134%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_truncate.do_sys_ftruncate.do_syscall_64
>       5.92 ± 21%     +31.5%       7.78 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_dirty_inode.btrfs_setattr
>       7.50 ±  6%     -46.7%       4.00 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_setsize
>     656.70 ± 87%     -77.0%     151.28 ± 28%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>       2.69 ± 32%     -98.2%       0.05 ±147%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
>       3.16 ±  3%     -11.0%       2.81 ±  2%  perf-stat.i.MPKI
>       0.41 ±  4%      -0.1        0.34 ±  4%  perf-stat.i.branch-miss-rate%
>   23832019 ±  2%     -14.2%   20447460 ±  4%  perf-stat.i.branch-misses
>      39.99            -1.0       39.00        perf-stat.i.cache-miss-rate%
>   91853184 ±  3%     -12.0%   80862154        perf-stat.i.cache-misses
>  2.304e+08 ±  2%      -9.3%  2.091e+08        perf-stat.i.cache-references
>     229178 ± 17%     -44.5%     127108 ± 17%  perf-stat.i.context-switches
>       6.84            +9.1%       7.46        perf-stat.i.cpi
>  2.028e+11 ±  2%      +6.3%  2.156e+11        perf-stat.i.cpu-cycles
>       2455 ±  9%     -26.0%       1816 ±  7%  perf-stat.i.cpu-migrations
>       2190 ±  4%     +22.4%       2679 ±  2%  perf-stat.i.cycles-between-cache-misses
>   2.41e+09            -9.6%  2.178e+09        perf-stat.i.dTLB-stores
>       0.16 ±  2%      -9.2%       0.14        perf-stat.i.ipc
>       3.17 ±  2%      +6.3%       3.37        perf-stat.i.metric.GHz
>     596.33           -13.7%     514.82        perf-stat.i.metric.K/sec
>     254.22            -2.5%     247.79        perf-stat.i.metric.M/sec
>       3354            -4.9%       3190        perf-stat.i.minor-faults
>   20345926           -12.1%   17889584        perf-stat.i.node-load-misses
>     670929 ±  3%      -8.4%     614724 ±  4%  perf-stat.i.node-loads
>      78.76            +1.8       80.53        perf-stat.i.node-store-miss-rate%
>   13307645           -13.5%   11505149 ±  2%  perf-stat.i.node-store-misses
>    3521965 ±  2%     -20.2%    2810680 ±  2%  perf-stat.i.node-stores
>       3354            -4.9%       3191        perf-stat.i.page-faults
>       3.14 ±  3%     -10.5%       2.81 ±  2%  perf-stat.overall.MPKI
>       0.38 ±  3%      -0.1        0.33 ±  3%  perf-stat.overall.branch-miss-rate%
>      39.88            -1.2       38.69        perf-stat.overall.cache-miss-rate%
>       6.94            +8.0%       7.50        perf-stat.overall.cpi
>       2212 ±  3%     +20.6%       2669 ±  2%  perf-stat.overall.cycles-between-cache-misses
>       0.00 ±  5%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
>       0.14            -7.4%       0.13        perf-stat.overall.ipc
>      79.10            +1.3       80.38        perf-stat.overall.node-store-miss-rate%
>      74346           +10.8%      82392        perf-stat.overall.path-length
>   23499855 ±  2%     -14.1%   20194868 ±  3%  perf-stat.ps.branch-misses
>   90797306 ±  3%     -11.9%   80007324        perf-stat.ps.cache-misses
>  2.277e+08 ±  2%      -9.2%  2.068e+08        perf-stat.ps.cache-references
>     223550 ± 16%     -44.4%     124400 ± 17%  perf-stat.ps.context-switches
>  2.007e+11 ±  2%      +6.4%  2.135e+11        perf-stat.ps.cpu-cycles
>       2398 ±  9%     -25.8%       1779 ±  7%  perf-stat.ps.cpu-migrations
>  2.381e+09            -9.5%  2.154e+09        perf-stat.ps.dTLB-stores
>       3317            -4.7%       3162        perf-stat.ps.minor-faults
>   20103614           -12.0%   17697322        perf-stat.ps.node-load-misses
>     663246 ±  3%      -8.3%     608333 ±  4%  perf-stat.ps.node-loads
>   13156513           -13.5%   11384162 ±  2%  perf-stat.ps.node-store-misses
>    3475107 ±  2%     -20.1%    2778120 ±  2%  perf-stat.ps.node-stores
>       3317            -4.7%       3162        perf-stat.ps.page-faults
>  2.495e+12           +10.8%  2.765e+12        perf-stat.total.instructions
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
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
