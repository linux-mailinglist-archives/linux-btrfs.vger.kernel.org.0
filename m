Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165655A96E8
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiIAMaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIAM3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 08:29:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836C386;
        Thu,  1 Sep 2022 05:29:44 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oTjKI-0006cC-AN; Thu, 01 Sep 2022 14:29:42 +0200
Message-ID: <c4a244e0-1be3-9be9-a56f-6dfb0c5c5d88@leemhuis.info>
Date:   Thu, 1 Sep 2022 14:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220830030032.GA2884@inn2.lkp.intel.com>
 <eb352106-5a3c-63fe-2409-494cf0a31bfc@intel.com>
 <4b5d1c96-44c5-e8bb-01d8-9f9c72621d0d@intel.com>
 <CAL3q7H78qPSp4O=ZrCCNFwX+6L4gZgn-A5q3VydvhTfkVDEUDQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [LKP] [btrfs] ca6dee6b79:
 fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec -8.4% regression #forregzbot
In-Reply-To: <CAL3q7H78qPSp4O=ZrCCNFwX+6L4gZgn-A5q3VydvhTfkVDEUDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662035384;e9a49214;
X-HE-SMSGID: 1oTjKI-0006cC-AN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 30.08.22 12:21, Filipe Manana wrote:
> On Tue, Aug 30, 2022 at 7:58 AM Yujie Liu <yujie.liu@intel.com> wrote:
>>
>> We noticed that this case was reported when the patch was in linux-next.
>> Thanks for your comment that it is an expected result due to heavy rename.
>>
>> https://lore.kernel.org/all/Ysb4T7Z8hKgdvPRk@xsang-OptiPlex-9020/
>>
>> This report is due to the patch being merged into mainline, if it is still
>> the same case, please ignore this duplicate report. Sorry for the inconvenience.
> 
> Yes, it's the same.

In that case:

#regzbot invalid: kinda expected, as explained in
https://lore.kernel.org/all/Ysb4T7Z8hKgdvPRk@xsang-OptiPlex-9020/

>> On 8/30/2022 11:17, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -8.4% regression of fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec due to commit:
>>>
>>>
>>> commit: ca6dee6b7946794fa340a7290ca399a50b61705f ("btrfs: balance btree dirty pages and delayed items after a rename")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: fxmark
>>> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
>>> with following parameters:
>>>
>>>      disk: 1SSD
>>>      media: ssd
>>>      test: MWRM
>>>      fstype: btrfs
>>>      directio: bufferedio
>>>      cpufreq_governor: performance
>>>      ucode: 0xd000363
>>>
>>> test-description: FxMark is a filesystem benchmark that test multicore scalability.
>>> test-url: https://github.com/sslab-gatech/fxmark
>>>
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
>>>    gcc-11/performance/bufferedio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWRM/fxmark/0xd000363
>>>
>>> commit:
>>>    b8bea09a45 ("btrfs: add trace event for submitted RAID56 bio")
>>>    ca6dee6b79 ("btrfs: balance btree dirty pages and delayed items after a rename")
>>>
>>> b8bea09a456fc31a ca6dee6b7946794fa340a7290ca
>>> ---------------- ---------------------------
>>>           %stddev     %change         %stddev
>>>               \          |                \
>>>     1821853           -13.9%    1568247 ±  3%  fxmark.ssd_btrfs_MWRM_36_bufferedio.works
>>>       36436           -13.9%      31362 ±  3%  fxmark.ssd_btrfs_MWRM_36_bufferedio.works/sec
>>>     1675102           -14.0%    1439994 ±  7%  fxmark.ssd_btrfs_MWRM_54_bufferedio.works
>>>       33497           -14.0%      28796 ±  7%  fxmark.ssd_btrfs_MWRM_54_bufferedio.works/sec
>>>     1572332            -8.4%    1440600 ±  6%  fxmark.ssd_btrfs_MWRM_72_bufferedio.works
>>>       31445            -8.4%      28809 ±  6%  fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec
>>>      356010           +80.0%     640832        fxmark.time.involuntary_context_switches
>>>       68.50           -24.1%      52.00        fxmark.time.percent_of_cpu_this_job_got
>>>      630.47           -24.0%     479.23        fxmark.time.system_time
>>>   1.335e+10           +49.8%      2e+10        cpuidle..time
>>>        1045 ±  4%     +11.8%       1168        uptime.idle
>>>       31.54           +50.2%      47.37        iostat.cpu.idle
>>>       64.16           -24.7%      48.29        iostat.cpu.system
>>>       31.17           +50.3%      46.83        vmstat.cpu.id
>>>       12.83 ±  5%     -55.8%       5.67 ±  8%  vmstat.procs.r
>>>       32.13           +15.8       47.95        mpstat.cpu.all.idle%
>>>        0.47 ±  7%      +0.1        0.53 ±  3%  mpstat.cpu.all.iowait%
>>>       63.37           -16.1       47.31        mpstat.cpu.all.sys%
>>>       10.04 ±  3%     +13.5%      11.39 ±  3%  perf-stat.i.metric.K/sec
>>>      869.81 ± 10%     -16.2%     728.74 ± 15%  perf-stat.i.node-loads
>>>      871.23 ± 10%     -16.2%     730.49 ± 15%  perf-stat.ps.node-loads
>>>        3004 ±  8%     -52.1%       1440 ±  6%  numa-meminfo.node0.Active(anon)
>>>     1218568           -10.8%    1086453        numa-meminfo.node0.Inactive
>>>      351812 ±  3%     -29.0%     249640 ± 12%  numa-meminfo.node0.Inactive(anon)
>>>      120150           -79.3%      24861 ±  3%  numa-meminfo.node0.Shmem
>>>        3489 ±  8%     -45.0%       1919 ±  2%  meminfo.Active(anon)
>>>      492107           -19.0%     398809        meminfo.Committed_AS
>>>      382253           -24.6%     288151        meminfo.Inactive(anon)
>>>      124727           -76.8%      28886 ±  2%  meminfo.Shmem
>>>        2050 ±  4%     -10.5%       1834 ±  5%  meminfo.Writeback
>>>      750.83 ±  8%     -52.1%     360.00 ±  6%  numa-vmstat.node0.nr_active_anon
>>>       87951 ±  3%     -29.0%      62408 ± 12%  numa-vmstat.node0.nr_inactive_anon
>>>       30038           -79.3%       6216 ±  3%  numa-vmstat.node0.nr_shmem
>>>      750.83 ±  8%     -52.1%     360.00 ±  6%  numa-vmstat.node0.nr_zone_active_anon
>>>       87951 ±  3%     -29.0%      62408 ± 12%  numa-vmstat.node0.nr_zone_inactive_anon
>>>     7554028 ±  3%     -71.2%    2174126 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
>>>     7640393 ±  3%     -70.5%    2254050 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
>>>     7291209 ±  3%     -73.6%    1926973 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
>>>      873.62 ±  7%     -19.2%     705.68 ± 10%  sched_debug.cfs_rq:/.runnable_avg.avg
>>>      790.32 ±  7%     -21.4%     621.34 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
>>>      747.11 ±  3%     -22.7%     577.37 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
>>>      670.92 ±  5%     -25.2%     501.70 ±  2%  sched_debug.cfs_rq:/.util_avg.min
>>>      409.44 ±  9%     -35.1%     265.80 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>>      789.44 ±  3%     -20.1%     630.53 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.max
>>>        0.00 ± 13%     -67.3%       0.00 ± 22%  sched_debug.cpu.next_balance.stddev
>>>      872.67 ±  8%     -45.0%     479.83 ±  2%  proc-vmstat.nr_active_anon
>>>     1801345            -1.7%    1771330        proc-vmstat.nr_file_pages
>>>       95550           -24.6%      72037        proc-vmstat.nr_inactive_anon
>>>        8752            -3.7%       8426        proc-vmstat.nr_mapped
>>>       31169           -76.8%       7221 ±  2%  proc-vmstat.nr_shmem
>>>      872.67 ±  8%     -45.0%     479.83 ±  2%  proc-vmstat.nr_zone_active_anon
>>>       95550           -24.6%      72037        proc-vmstat.nr_zone_inactive_anon
>>>        9553 ± 10%     -16.8%       7950 ±  3%  proc-vmstat.numa_hint_faults
>>>    18886391            -3.6%   18207624        proc-vmstat.numa_hit
>>>    18770999            -3.6%   18091363        proc-vmstat.numa_local
>>>     7398756            -4.0%    7105675        proc-vmstat.pgactivate
>>>    18885154            -3.6%   18206666        proc-vmstat.pgalloc_normal
>>>     7248262            -4.3%    6933915 ±  2%  proc-vmstat.pgdeactivate
>>>    18894473            -3.4%   18243898        proc-vmstat.pgfree
>>>     7829962            -3.0%    7596447 ±  2%  proc-vmstat.pgrotated
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>          sudo bin/lkp run generated-yaml-file
>>>
>>>          # if come across any failure that blocks the test,
>>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
>>>
>>> #regzbot introduced: ca6dee6b79
>>>
>>>
>>>
>>> _______________________________________________
>>> LKP mailing list -- lkp@lists.01.org
>>> To unsubscribe send an email to lkp-leave@lists.01.org
> 
> 
