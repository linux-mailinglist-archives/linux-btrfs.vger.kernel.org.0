Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491B041A32C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhI0Wip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhI0Wio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 18:38:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC3C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 15:37:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so84181469lfu.5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsEm5vknfQT+EpFnQ+VZFv7DC9MbXD5+U0S5Xl8uWbk=;
        b=MYAy8ii6pLIubIQR31+KaAUE2xLjX6NsEAGHHXGxkjVBFIL/R1bcW+KLQ6t6uWUrg4
         dvT6BI9QBNSpZ8LWg+Jc4KRAYDOo2ZCN0tGU0AWIDiTAOeoaJbHvxweEpkscpFlkCBbl
         DECv+nfKcRbK+B/1Uvg4VeyyeYqM6rutpIgRIiHjIYYDTkGeqbJB9+FQJtSFHqjJBOvB
         p55s4hl+CK4ZQ743KeZVlIRyKaS07vtGO4aJEHOmYsc+wcY5QGFw15EibeqpLcLoizJZ
         0O+puOl7w8GMZtSB7JSpBrlbl0gnfAL/UiwJnwOzduufH8Q6sR1lmF39LM896aaGVKDE
         q+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsEm5vknfQT+EpFnQ+VZFv7DC9MbXD5+U0S5Xl8uWbk=;
        b=VDEkaa+MP20MGioikYFENF2z7Hzg9qGM5rQGNfubMgu+93r+U3R/vXk5y/vn67CJeE
         1ka0M5zr3aQD6r3AIUi000ec0cOI9fD616POeqC9zuw0/2xN4q/30uT4Txjg+FVSXLg0
         ctA1okTa6shbQhWmpj/y0UxfmBzpQC1/x8rDowRxk87iFdFsKUVCXzmhbfUowgsXvZ5S
         nE8GNH1u3RsW0Txtrni7tf2WCLVbrl6aHMtAa4YA0IdKFAnAKOyBA/EflYd/veb0N5FK
         V3W2xeYyEk4YUGrxjSBMANA1HhBFFlT/T4ZNf3v6vcDxathIXmi4J0d/8lOf8NL1RABN
         cT8Q==
X-Gm-Message-State: AOAM532UpwjIOrji8NH9BtB61KPoKDY+wBUHqCZFF0kPWuC501PEMkLc
        wFR4cP+eF0pbvqeWDM4D/fdebc2BECkCdwqP2B/Ek1cbx+mzqg==
X-Google-Smtp-Source: ABdhPJxTVTODnbl9arLgPcWHRD8NGrR7pIPtokL5S2puNUbyPdRGtpbHZLaVy2Of4IEi31EKNuuwSo6Zq6MLWu1robk=
X-Received: by 2002:a19:740a:: with SMTP id v10mr2082525lfe.566.1632782224043;
 Mon, 27 Sep 2021 15:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
 <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com> <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
In-Reply-To: <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
From:   Sven Oehme <oehmes@gmail.com>
Date:   Mon, 27 Sep 2021 16:36:53 -0600
Message-ID: <CALssuR2-k5RE_PZhygRtKk9DR5NnwjNzqdb6yr2UAGouSPsbnQ@mail.gmail.com>
Subject: Re: Host managed SMR drive issue
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

i tried to repeat the test with FW19, same result :

[Mon Sep 27 15:41:22 2021] INFO: task btrfs-transacti:4206 blocked for
more than 604 seconds.
[Mon Sep 27 15:41:22 2021]       Not tainted 5.14-test #1
[Mon Sep 27 15:41:22 2021] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mon Sep 27 15:41:22 2021] task:btrfs-transacti state:D stack:    0
pid: 4206 ppid:     2 flags:0x00004000
[Mon Sep 27 15:41:22 2021] Call Trace:
[Mon Sep 27 15:41:22 2021]  __schedule+0x2fa/0x910
[Mon Sep 27 15:41:22 2021]  schedule+0x4f/0xc0
[Mon Sep 27 15:41:22 2021]  io_schedule+0x46/0x70
[Mon Sep 27 15:41:22 2021]  blk_mq_get_tag+0x11b/0x270
[Mon Sep 27 15:41:22 2021]  ? wait_woken+0x80/0x80
[Mon Sep 27 15:41:22 2021]  __blk_mq_alloc_request+0xec/0x120
[Mon Sep 27 15:41:22 2021]  blk_mq_submit_bio+0x12f/0x580
[Mon Sep 27 15:41:22 2021]  submit_bio_noacct+0x42a/0x4f0
[Mon Sep 27 15:41:22 2021]  submit_bio+0x4f/0x1b0
[Mon Sep 27 15:41:22 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
[Mon Sep 27 15:41:22 2021]  btrfs_submit_metadata_bio+0x10f/0x170 [btrfs]
[Mon Sep 27 15:41:22 2021]  submit_one_bio+0x67/0x80 [btrfs]
[Mon Sep 27 15:41:22 2021]  btree_write_cache_pages+0x6e8/0x770 [btrfs]
[Mon Sep 27 15:41:22 2021]  btree_writepages+0x5f/0x70 [btrfs]
[Mon Sep 27 15:41:22 2021]  do_writepages+0x38/0xc0
[Mon Sep 27 15:41:22 2021]  __filemap_fdatawrite_range+0xcc/0x110
[Mon Sep 27 15:41:22 2021]  filemap_fdatawrite_range+0x13/0x20
[Mon Sep 27 15:41:22 2021]  btrfs_write_marked_extents+0x66/0x140 [btrfs]
[Mon Sep 27 15:41:22 2021]  btrfs_write_and_wait_transaction+0x49/0xd0 [btrfs]
[Mon Sep 27 15:41:22 2021]  btrfs_commit_transaction+0x6b0/0xaa0 [btrfs]
[Mon Sep 27 15:41:22 2021]  ? start_transaction+0xcf/0x5a0 [btrfs]
[Mon Sep 27 15:41:22 2021]  transaction_kthread+0x138/0x1b0 [btrfs]
[Mon Sep 27 15:41:22 2021]  kthread+0x12f/0x150
[Mon Sep 27 15:41:22 2021]  ?
btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
[Mon Sep 27 15:41:22 2021]  ? __kthread_bind_mask+0x70/0x70
[Mon Sep 27 15:41:22 2021]  ret_from_fork+0x22/0x30

if you tell me what information to collect, I am happy to do so,.

Sven

On Mon, Sep 27, 2021 at 11:28 AM Sven Oehme <oehmes@gmail.com> wrote:
>
> Hi,
>
> I also have an  Adaptec HBA 1100-4i at FW level 4.11 (latest) , which
> according to https://ask.adaptec.com/app/answers/detail/a_id/17472 is
> supported but see the exact same hangs after a few minutes ...
>
> what i see in dmesg is :
>
> [Mon Sep 27 11:20:03 2021] INFO: task kworker/u102:6:190092 blocked
> for more than 120 seconds.
> [Mon Sep 27 11:20:03 2021]       Not tainted 5.14-test #1
> [Mon Sep 27 11:20:03 2021] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mon Sep 27 11:20:03 2021] task:kworker/u102:6  state:D stack:    0
> pid:190092 ppid:     2 flags:0x00004000
> [Mon Sep 27 11:20:03 2021] Workqueue: btrfs-worker-high
> btrfs_work_helper [btrfs]
> [Mon Sep 27 11:20:03 2021] Call Trace:
> [Mon Sep 27 11:20:03 2021]  __schedule+0x2fa/0x910
> [Mon Sep 27 11:20:03 2021]  schedule+0x4f/0xc0
> [Mon Sep 27 11:20:03 2021]  io_schedule+0x46/0x70
> [Mon Sep 27 11:20:03 2021]  blk_mq_get_tag+0x11b/0x270
> [Mon Sep 27 11:20:03 2021]  ? wait_woken+0x80/0x80
> [Mon Sep 27 11:20:03 2021]  __blk_mq_alloc_request+0xec/0x120
> [Mon Sep 27 11:20:03 2021]  blk_mq_submit_bio+0x12f/0x580
> [Mon Sep 27 11:20:03 2021]  submit_bio_noacct+0x42a/0x4f0
> [Mon Sep 27 11:20:03 2021]  submit_bio+0x4f/0x1b0
> [Mon Sep 27 11:20:03 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
> [Mon Sep 27 11:20:03 2021]  run_one_async_done+0x3b/0x70 [btrfs]
> [Mon Sep 27 11:20:03 2021]  btrfs_work_helper+0x132/0x2e0 [btrfs]
> [Mon Sep 27 11:20:03 2021]  process_one_work+0x220/0x3c0
> [Mon Sep 27 11:20:03 2021]  worker_thread+0x53/0x420
> [Mon Sep 27 11:20:03 2021]  kthread+0x12f/0x150
> [Mon Sep 27 11:20:03 2021]  ? process_one_work+0x3c0/0x3c0
> [Mon Sep 27 11:20:03 2021]  ? __kthread_bind_mask+0x70/0x70
> [Mon Sep 27 11:20:03 2021]  ret_from_fork+0x22/0x30
>
> i will also downgrade the LSI adapter to FW 19, but i think this is
> unrelated to the FW as i can see this with 2 completely different
> HBA's and 2 completely different drives.
>
> Sven
>
> Sven
>
>
> On Sun, Sep 26, 2021 at 5:19 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 2021/09/25 3:25, Sven Oehme wrote:
> > > Hi,
> > >
> > > i am running into issues with Host Managed SMR drive testing. when i
> > > try to copy or move a file to the btrfs filesystem it just hangs. i
> > > tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14.6 but the
> > > issue still persists.
> > >
> > > here is the setup :
> > >
> > > I am using btrfs-progs-v5.14.1
> > > device is a  Host Managed WDC  20TB SMR drive with firmware level C421
> > > its connected via a HBA 9400-8i Tri-Mode Storage Adapter , latest 20.0 FW
> >
> > Beware of the Broadcom FW rev 20. We found problems with it: very slow zone
> > command scheduling leading to command timeout is some cases. FW 19 does not seem
> > to have this issue. But that is likely not the cause of the problem here.
> >
> > Is there anything of interest in dmesg ? Any IO errors ?
> >
> > Naohiro, Johannes,
> >
> > Any idea ?
> >
> >
> >
> > > I am using the /dev/sd device direct  , no lvm or device mapper or
> > > anything else in between
> > >
> > > after a few seconds, sometimes minutes data rate to the drive drops to
> > > 0 and 1 or 2 cores on my system show 100% IO wait time, but no longer
> > > make any progress
> > >
> > > the process in question has the following stack :
> > >
> > > [ 2168.589160] task:mv              state:D stack:    0 pid: 3814
> > > ppid:  3679 flags:0x00004000
> > > [ 2168.589162] Call Trace:
> > > [ 2168.589163]  __schedule+0x2fa/0x910
> > > [ 2168.589166]  schedule+0x4f/0xc0
> > > [ 2168.589168]  schedule_timeout+0x8a/0x140
> > > [ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
> > > [ 2168.589173]  io_schedule_timeout+0x51/0x80
> > > [ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
> > > [ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
> > > [ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
> > > [ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
> > > [ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
> > > [ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
> > > [ 2168.589262]  new_sync_write+0x114/0x1a0
> > > [ 2168.589265]  vfs_write+0x1c5/0x260
> > > [ 2168.589267]  ksys_write+0x67/0xe0
> > > [ 2168.589270]  __x64_sys_write+0x1a/0x20
> > > [ 2168.589272]  do_syscall_64+0x40/0xb0
> > > [ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [ 2168.589277] RIP: 0033:0x7ffff7e91c27
> > > [ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000001
> > > [ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7e91c27
> > > [ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 RDI: 0000000000000004
> > > [ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R09: 0000000000000000
> > > [ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000004
> > > [ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R15: 0000000000020000
> > >
> > > and shows up under runnable tasks :
> > >
> > > [ 2168.593562] runnable tasks:
> > > [ 2168.593562]  S            task   PID         tree-key  switches
> > > prio     wait-time             sum-exec        sum-sleep
> > > [ 2168.593563] -------------------------------------------------------------------------------------------------------------
> > > [ 2168.593565]  S        cpuhp/13    92     88923.802487        19
> > > 120         0.000000         0.292061         0.000000 2 0 /
> > > [ 2168.593571]  S  idle_inject/13    93       -11.997255         3
> > > 49         0.000000         0.005480         0.000000 2 0 /
> > > [ 2168.593577]  S    migration/13    94       814.287531       551
> > > 0         0.000000      1015.550514         0.000000 2 0 /
> > > [ 2168.593582]  S    ksoftirqd/13    95     88762.317130        44
> > > 120         0.000000         1.940252         0.000000 2 0 /
> > > [ 2168.593588]  I    kworker/13:0    96        -9.031157         5
> > > 120         0.000000         0.017423         0.000000 2 0 /
> > > [ 2168.593593]  I   kworker/13:0H    97      3570.961886         5
> > > 100         0.000000         0.034345         0.000000 2 0 /
> > > [ 2168.593603]  I    kworker/13:1   400    101650.731913       578
> > > 120         0.000000        10.110898         0.000000 2 0 /
> > > [ 2168.593611]  I   kworker/13:1H  1015    101649.600698        65
> > > 100         0.000000         1.443300         0.000000 2 0 /
> > > [ 2168.593618]  S           loop3  1994     99133.655903        70
> > > 100         0.000000         1.137468         0.000000 2 0 /
> > > [ 2168.593625]  S           snapd  3161        15.296181       166
> > > 120         0.000000        90.296991         0.000000 2 0
> > > /system.slice/snapd.service
> > > [ 2168.593631]  S           snapd  3198        10.047573        49
> > > 120         0.000000         5.646247         0.000000 2 0
> > > /system.slice/snapd.service
> > > [ 2168.593639]  S            java  2446       970.743682       301
> > > 120         0.000000       101.648659         0.000000 2 0
> > > /system.slice/stor_tomcat.service
> > > [ 2168.593645]  S C1 CompilerThre  2573      1033.157689      3636
> > > 120         0.000000       615.256247         0.000000 2 0
> > > /system.slice/stor_tomcat.service
> > > [ 2168.593654]  D              mv  3814      2263.816953    186734
> > > 120         0.000000     30087.917319         0.000000 2 0 /user.slice
> > >
> > > any idea what is going on and how to fix this ?
> >
> >
> >
> > >
> > > thx.
> > >
> >
> >
> > --
> > Damien Le Moal
> > Western Digital Research
