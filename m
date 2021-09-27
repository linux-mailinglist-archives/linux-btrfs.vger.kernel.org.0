Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5041A3F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 01:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhI0XxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 19:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI0XxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 19:53:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FDC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 16:51:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g41so84500072lfv.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 16:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcIL5O34dnKsj7RUeFZ/DVCmSW3L8oU8Bh6qa+SpEzY=;
        b=pMd1DW8Z0at0ZUtcUJeWqpNEy0aOd/0NqeMywiiR0cYzhO1gHjEoj7FrTI3tj9HQTb
         PZcwJ0DpTfhEfnXOi1VWiHHlsAdzceK9W+9k1EI06bN91y/BiPhEUWEjtubY8mPhGRj0
         8p87SeyrKugy66iql18SzySW3/HV5IbQaFbF2Msmvmli2WrA+VT9f771iKwl5deKbt8y
         KbmfcxOwhdZbG8pH5rkegw+hWpTTy4d+X8+6dzmfLc5+4JiSafredhSI7NAXtrUMu9oD
         P//wp/qhV2tjq7W8M/o2njiAr1wafApYCw7WHIrweA2YIAGPfnzSDVT8rHow9uqoIi5Z
         zLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcIL5O34dnKsj7RUeFZ/DVCmSW3L8oU8Bh6qa+SpEzY=;
        b=HiZY+eaXmarAQ6KEajX8NRWhjeLakRzwq0o+glXef8dUfs/I5qNVA786O6QBCRLo3/
         XfSoeFAjzA3NwTgTdxi/yhbkakm/2lerp1q18RF2u5NbiTwBGLqEUxvKl2r6jcbLOW3A
         iIFG+K8v6yuMSTbsSK1mcXBoN1N1juPzmKKjb200UgbDRiGj9vrRg9a/cICJ26JeCAPb
         w+B+xDqJbRJDobNLUtsq+a7Dibjwt8QU02Z8nXINiViixFpRfaBF35WwAbY9r10JIWw7
         x8m2bQPWXP62AwGog1V5TG/Ldw36NEar2iSJB3nFXGqkIrwQfb510yImn72da/2eCKig
         T/OA==
X-Gm-Message-State: AOAM530jO6owKT3Wp+3z2BrL4Ijj1Shshv6jyhItGO2yCgS3X0UNlyke
        iqWw7+LEaYa/0gP744OeRXgycIwR86UrPn64wQA=
X-Google-Smtp-Source: ABdhPJy0Yxgmft5Qn8gk8bIGP6S6K9/MzgaJ/KfKHA2aj8EmndcIjDIoIgORH0LJpczzuDfatO5eGM9ocHUUAd4pnfA=
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr2412978lfb.223.1632786681828;
 Mon, 27 Sep 2021 16:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
 <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com> <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com> <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com> <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com> <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com> <5464e996-a01a-3a42-a195-36d052122659@opensource.wdc.com>
In-Reply-To: <5464e996-a01a-3a42-a195-36d052122659@opensource.wdc.com>
From:   Sven Oehme <oehmes@gmail.com>
Date:   Mon, 27 Sep 2021 17:51:10 -0600
Message-ID: <CALssuR1T_4hCW46kHR1fJjJV05eMY1iXCPfugi2m7-WH20k4pw@mail.gmail.com>
Subject: Re: Host managed SMR drive issue
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Please let me know if you need more infos or have a patch for me to try.

thx. Sven

On Mon, Sep 27, 2021 at 5:38 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2021/09/28 8:36, Sven Oehme wrote:
> > I should add that the copy process starts and runs for a while, but
> > then stalls. The last 2 times I started over from scratch it stalls at
> > around 200 GB, so ~ 1-2 files into the copy process.
>
> OK. So it looks like the problem starts when btrfs starts using the sequential
> write only zones. We will try to recreate this.
>
> >
> > Sven
> >
> > On Mon, Sep 27, 2021 at 5:34 PM Sven Oehme <oehmes@gmail.com> wrote:
> >>
> >> the workload is as simple as one can imagine :
> >>
> >> scp -rp /space/01/ /space/20/
> >> where space/01 is a ext4 filesystem with several >100gb files in it,
> >> /space/20 is the btrfs destination
> >>
> >> its single threaded , nothing special
> >>
> >> Sven
> >>
> >> On Mon, Sep 27, 2021 at 5:31 PM Damien Le Moal
> >> <damien.lemoal@opensource.wdc.com> wrote:
> >>>
> >>> On 2021/09/28 8:17, Sven Oehme wrote:
> >>>> yes i do :
> >>>>
> >>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/queued
> >>>> 3760
> >>>
> >>> Can you give more information on the workload ? How can we recreate this ?
> >>>
> >>>>
> >>>> On Mon, Sep 27, 2021 at 5:01 PM Damien Le Moal
> >>>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>>
> >>>>> On 2021/09/28 7:56, Sven Oehme wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> i tried above  :
> >>>>>>
> >>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
> >>>>>>        0        89
> >>>>>>        1        1462
> >>>>>>        2        1
> >>>>>>        4        574
> >>>>>>        8        0
> >>>>>>       16        0
> >>>>>>       32+       0
> >>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch
> >>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
> >>>>>>        0        89
> >>>>>>        1        1462
> >>>>>>        2        1
> >>>>>>        4        574
> >>>>>>        8        0
> >>>>>>       16        0
> >>>>>>       32+       0
> >>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch_busy
> >>>>>> 0
> >>>>>
> >>>>> Do you have the queued count too ? If there is a difference with dispatch, it
> >>>>> would mean that some IOs are stuck in the stack.
> >>>>>
> >>>>>>
> >>>>>> echo 1 > /sys/kernel/debug/block/sdr/hctx0/run
> >>>>>>
> >>>>>> doesn't make any progress, still no i/o to the drive
> >>>>>>
> >>>>>> Sven
> >>>>>>
> >>>>>>
> >>>>>> On Mon, Sep 27, 2021 at 4:48 PM Damien Le Moal
> >>>>>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>>>>
> >>>>>>> On 2021/09/28 7:38, Sven Oehme wrote:
> >>>>>>>> i tried to repeat the test with FW19, same result :
> >>>>>>>
> >>>>>>> The problem is likely not rooted with the HBA fw version.
> >>>>>>> How do you create the problem ? Is it an fio script you are running ?
> >>>>>>>
> >>>>>>>>
> >>>>>>>> [Mon Sep 27 15:41:22 2021] INFO: task btrfs-transacti:4206 blocked for
> >>>>>>>> more than 604 seconds.
> >>>>>>>> [Mon Sep 27 15:41:22 2021]       Not tainted 5.14-test #1
> >>>>>>>> [Mon Sep 27 15:41:22 2021] "echo 0 >
> >>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>>>>> [Mon Sep 27 15:41:22 2021] task:btrfs-transacti state:D stack:    0
> >>>>>>>> pid: 4206 ppid:     2 flags:0x00004000
> >>>>>>>> [Mon Sep 27 15:41:22 2021] Call Trace:
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  __schedule+0x2fa/0x910
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  schedule+0x4f/0xc0
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  io_schedule+0x46/0x70
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_get_tag+0x11b/0x270
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  ? wait_woken+0x80/0x80
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  __blk_mq_alloc_request+0xec/0x120
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_submit_bio+0x12f/0x580
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_bio_noacct+0x42a/0x4f0
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_bio+0x4f/0x1b0
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_submit_metadata_bio+0x10f/0x170 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_one_bio+0x67/0x80 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btree_write_cache_pages+0x6e8/0x770 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btree_writepages+0x5f/0x70 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  do_writepages+0x38/0xc0
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  __filemap_fdatawrite_range+0xcc/0x110
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  filemap_fdatawrite_range+0x13/0x20
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_marked_extents+0x66/0x140 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_and_wait_transaction+0x49/0xd0 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_commit_transaction+0x6b0/0xaa0 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  ? start_transaction+0xcf/0x5a0 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  transaction_kthread+0x138/0x1b0 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  kthread+0x12f/0x150
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  ?
> >>>>>>>> btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  ? __kthread_bind_mask+0x70/0x70
> >>>>>>>> [Mon Sep 27 15:41:22 2021]  ret_from_fork+0x22/0x30
> >>>>>>>>
> >>>>>>>> if you tell me what information to collect, I am happy to do so,.
> >>>>>>>
> >>>>>>> The stack seems to point to a "hang" in the block layer so btrfs side waits forever.
> >>>>>>>
> >>>>>>> When you get the hang, can you check the queued and dispatch counters in
> >>>>>>> /sys/kernel/debug/block/<your disk>/hctx0 ?
> >>>>>>>
> >>>>>>> Once you have the numbers, try:
> >>>>>>>
> >>>>>>> echo 1 > /sys/kernel/debug/block/<your disk>/hctx0/run
> >>>>>>>
> >>>>>>> to see if the drive gets unstuck.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Sven
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Mon, Sep 27, 2021 at 11:28 AM Sven Oehme <oehmes@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> I also have an  Adaptec HBA 1100-4i at FW level 4.11 (latest) , which
> >>>>>>>>> according to https://ask.adaptec.com/app/answers/detail/a_id/17472 is
> >>>>>>>>> supported but see the exact same hangs after a few minutes ...
> >>>>>>>>>
> >>>>>>>>> what i see in dmesg is :
> >>>>>>>>>
> >>>>>>>>> [Mon Sep 27 11:20:03 2021] INFO: task kworker/u102:6:190092 blocked
> >>>>>>>>> for more than 120 seconds.
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]       Not tainted 5.14-test #1
> >>>>>>>>> [Mon Sep 27 11:20:03 2021] "echo 0 >
> >>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>>>>>> [Mon Sep 27 11:20:03 2021] task:kworker/u102:6  state:D stack:    0
> >>>>>>>>> pid:190092 ppid:     2 flags:0x00004000
> >>>>>>>>> [Mon Sep 27 11:20:03 2021] Workqueue: btrfs-worker-high
> >>>>>>>>> btrfs_work_helper [btrfs]
> >>>>>>>>> [Mon Sep 27 11:20:03 2021] Call Trace:
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  __schedule+0x2fa/0x910
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  schedule+0x4f/0xc0
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  io_schedule+0x46/0x70
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_get_tag+0x11b/0x270
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? wait_woken+0x80/0x80
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  __blk_mq_alloc_request+0xec/0x120
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_submit_bio+0x12f/0x580
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio_noacct+0x42a/0x4f0
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio+0x4f/0x1b0
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  run_one_async_done+0x3b/0x70 [btrfs]
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_work_helper+0x132/0x2e0 [btrfs]
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  process_one_work+0x220/0x3c0
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  worker_thread+0x53/0x420
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  kthread+0x12f/0x150
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? process_one_work+0x3c0/0x3c0
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? __kthread_bind_mask+0x70/0x70
> >>>>>>>>> [Mon Sep 27 11:20:03 2021]  ret_from_fork+0x22/0x30
> >>>>>>>>>
> >>>>>>>>> i will also downgrade the LSI adapter to FW 19, but i think this is
> >>>>>>>>> unrelated to the FW as i can see this with 2 completely different
> >>>>>>>>> HBA's and 2 completely different drives.
> >>>>>>>>>
> >>>>>>>>> Sven
> >>>>>>>>>
> >>>>>>>>> Sven
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On Sun, Sep 26, 2021 at 5:19 PM Damien Le Moal
> >>>>>>>>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2021/09/25 3:25, Sven Oehme wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> i am running into issues with Host Managed SMR drive testing. when i
> >>>>>>>>>>> try to copy or move a file to the btrfs filesystem it just hangs. i
> >>>>>>>>>>> tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14.6 but the
> >>>>>>>>>>> issue still persists.
> >>>>>>>>>>>
> >>>>>>>>>>> here is the setup :
> >>>>>>>>>>>
> >>>>>>>>>>> I am using btrfs-progs-v5.14.1
> >>>>>>>>>>> device is a  Host Managed WDC  20TB SMR drive with firmware level C421
> >>>>>>>>>>> its connected via a HBA 9400-8i Tri-Mode Storage Adapter , latest 20.0 FW
> >>>>>>>>>>
> >>>>>>>>>> Beware of the Broadcom FW rev 20. We found problems with it: very slow zone
> >>>>>>>>>> command scheduling leading to command timeout is some cases. FW 19 does not seem
> >>>>>>>>>> to have this issue. But that is likely not the cause of the problem here.
> >>>>>>>>>>
> >>>>>>>>>> Is there anything of interest in dmesg ? Any IO errors ?
> >>>>>>>>>>
> >>>>>>>>>> Naohiro, Johannes,
> >>>>>>>>>>
> >>>>>>>>>> Any idea ?
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> I am using the /dev/sd device direct  , no lvm or device mapper or
> >>>>>>>>>>> anything else in between
> >>>>>>>>>>>
> >>>>>>>>>>> after a few seconds, sometimes minutes data rate to the drive drops to
> >>>>>>>>>>> 0 and 1 or 2 cores on my system show 100% IO wait time, but no longer
> >>>>>>>>>>> make any progress
> >>>>>>>>>>>
> >>>>>>>>>>> the process in question has the following stack :
> >>>>>>>>>>>
> >>>>>>>>>>> [ 2168.589160] task:mv              state:D stack:    0 pid: 3814
> >>>>>>>>>>> ppid:  3679 flags:0x00004000
> >>>>>>>>>>> [ 2168.589162] Call Trace:
> >>>>>>>>>>> [ 2168.589163]  __schedule+0x2fa/0x910
> >>>>>>>>>>> [ 2168.589166]  schedule+0x4f/0xc0
> >>>>>>>>>>> [ 2168.589168]  schedule_timeout+0x8a/0x140
> >>>>>>>>>>> [ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
> >>>>>>>>>>> [ 2168.589173]  io_schedule_timeout+0x51/0x80
> >>>>>>>>>>> [ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
> >>>>>>>>>>> [ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
> >>>>>>>>>>> [ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
> >>>>>>>>>>> [ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
> >>>>>>>>>>> [ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
> >>>>>>>>>>> [ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
> >>>>>>>>>>> [ 2168.589262]  new_sync_write+0x114/0x1a0
> >>>>>>>>>>> [ 2168.589265]  vfs_write+0x1c5/0x260
> >>>>>>>>>>> [ 2168.589267]  ksys_write+0x67/0xe0
> >>>>>>>>>>> [ 2168.589270]  __x64_sys_write+0x1a/0x20
> >>>>>>>>>>> [ 2168.589272]  do_syscall_64+0x40/0xb0
> >>>>>>>>>>> [ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>>>>>>> [ 2168.589277] RIP: 0033:0x7ffff7e91c27
> >>>>>>>>>>> [ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 ORIG_RAX:
> >>>>>>>>>>> 0000000000000001
> >>>>>>>>>>> [ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7e91c27
> >>>>>>>>>>> [ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 RDI: 0000000000000004
> >>>>>>>>>>> [ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R09: 0000000000000000
> >>>>>>>>>>> [ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000004
> >>>>>>>>>>> [ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R15: 0000000000020000
> >>>>>>>>>>>
> >>>>>>>>>>> and shows up under runnable tasks :
> >>>>>>>>>>>
> >>>>>>>>>>> [ 2168.593562] runnable tasks:
> >>>>>>>>>>> [ 2168.593562]  S            task   PID         tree-key  switches
> >>>>>>>>>>> prio     wait-time             sum-exec        sum-sleep
> >>>>>>>>>>> [ 2168.593563] -------------------------------------------------------------------------------------------------------------
> >>>>>>>>>>> [ 2168.593565]  S        cpuhp/13    92     88923.802487        19
> >>>>>>>>>>> 120         0.000000         0.292061         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593571]  S  idle_inject/13    93       -11.997255         3
> >>>>>>>>>>> 49         0.000000         0.005480         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593577]  S    migration/13    94       814.287531       551
> >>>>>>>>>>> 0         0.000000      1015.550514         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593582]  S    ksoftirqd/13    95     88762.317130        44
> >>>>>>>>>>> 120         0.000000         1.940252         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593588]  I    kworker/13:0    96        -9.031157         5
> >>>>>>>>>>> 120         0.000000         0.017423         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593593]  I   kworker/13:0H    97      3570.961886         5
> >>>>>>>>>>> 100         0.000000         0.034345         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593603]  I    kworker/13:1   400    101650.731913       578
> >>>>>>>>>>> 120         0.000000        10.110898         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593611]  I   kworker/13:1H  1015    101649.600698        65
> >>>>>>>>>>> 100         0.000000         1.443300         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593618]  S           loop3  1994     99133.655903        70
> >>>>>>>>>>> 100         0.000000         1.137468         0.000000 2 0 /
> >>>>>>>>>>> [ 2168.593625]  S           snapd  3161        15.296181       166
> >>>>>>>>>>> 120         0.000000        90.296991         0.000000 2 0
> >>>>>>>>>>> /system.slice/snapd.service
> >>>>>>>>>>> [ 2168.593631]  S           snapd  3198        10.047573        49
> >>>>>>>>>>> 120         0.000000         5.646247         0.000000 2 0
> >>>>>>>>>>> /system.slice/snapd.service
> >>>>>>>>>>> [ 2168.593639]  S            java  2446       970.743682       301
> >>>>>>>>>>> 120         0.000000       101.648659         0.000000 2 0
> >>>>>>>>>>> /system.slice/stor_tomcat.service
> >>>>>>>>>>> [ 2168.593645]  S C1 CompilerThre  2573      1033.157689      3636
> >>>>>>>>>>> 120         0.000000       615.256247         0.000000 2 0
> >>>>>>>>>>> /system.slice/stor_tomcat.service
> >>>>>>>>>>> [ 2168.593654]  D              mv  3814      2263.816953    186734
> >>>>>>>>>>> 120         0.000000     30087.917319         0.000000 2 0 /user.slice
> >>>>>>>>>>>
> >>>>>>>>>>> any idea what is going on and how to fix this ?
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> thx.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>> Damien Le Moal
> >>>>>>>>>> Western Digital Research
> >>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> Damien Le Moal
> >>>>>>> Western Digital Research
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Damien Le Moal
> >>>>> Western Digital Research
> >>>
> >>>
> >>> --
> >>> Damien Le Moal
> >>> Western Digital Research
>
>
> --
> Damien Le Moal
> Western Digital Research
