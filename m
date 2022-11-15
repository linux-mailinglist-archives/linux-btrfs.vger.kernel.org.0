Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEC629917
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiKOMmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 07:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiKOMmF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 07:42:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFEB27179
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 04:42:02 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QJJ-1ovkbg1xjx-001PaG; Tue, 15
 Nov 2022 13:41:58 +0100
Message-ID: <7be0584d-5596-189a-353a-63e4b21c3b5e@gmx.com>
Date:   Tue, 15 Nov 2022 20:41:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Spencer Collyer <spencer@spencercollyer.plus.com>,
        linux-btrfs@vger.kernel.org
References: <20221115122702.4ca83887@selket>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Change BTRFS filesystem back to R/W from R/O
In-Reply-To: <20221115122702.4ca83887@selket>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s1oCGDGcQPQ5a7i7WS+yiypNOvJTByiKWCrFIoHKa5esy6LoGZ2
 jbZxjFiyYHqahgEUwJ1lmCwta2rVxP4OlkkP9+HZZmgTEwD85YPZkO04GJkKpdf+wkma+Yv
 6b+fw/8mbjAn7GVSrhLAfFfoD5rGM5vIproyuNTRgkWMxITZXzKNYAj6rYG6693EVpxboZt
 JIIOFvkKZl/A9XfaaC6Pg==
UI-OutboundReport: notjunk:1;M01:P0:wH+VSCHDYn4=;STOoBXegI676bRCROu+ydlZ+H2T
 qj4lJJEueQn9L8w76Scf8fL9L552FV/aqgl8ut+1NMKMMgexeD1u5E2ewC2BM4Vf8XN8f3tpf
 +3cQtfjHlU732QNmfYZOIDTw9Odqn9R5eX4Bh8kt+ZQ9bvK4GBjS3ZcFoJcAmkvnuHE/UhfXu
 nG4agWhqZiv2eL0olDhPyr/yfoNIGY+Vf3R/TZMFr4j0+RLHBg93E2s9OjJmBjiH2/9wLebns
 nkS8DjTJyjiU/XhPuB7LCcloxy5SepIPPL2c09RtA3Lp+DZu3kjOcDg7CILkZFW6dvcTwi0wX
 kg4ylKsuUvmZNjsCo9uRC0WHTghbm2rIXGhzPEJ/fM8qcUHFv77iAQwv2gVRLZutAitdKZT5r
 /RvcjYEW/TA7copMvDJ1JUh73XEwqd1S1phoc8879Wj1JZ8DLOCkaM/hATANvTAAYS+LORzUQ
 vQ9lYvIEf8BOxoGwa98N86ojM1WmPa8+ahDbb6VokQctiuFUZmo898Qq+NWzMQuDok8d6o2Dd
 K/nqA2EIU5aJsYsdcAZefXIuVc0rhpYJKxlCdTllK0wMyN/kzwZ4O67LUXB7npmavTo+jd43+
 pRvt4GEtkg4iamsyVo97zRoFrkrvnywip5JdKc5eUANaCUuv8mZ91b/tj7f4h7ipfZzwaPKwn
 ZbrFPwl/LO6RI64DQwxuIZxrCH3732c3k6yAwOccFaSGmNtJq8zsSj5XNtX2bkoADoy1cuz/j
 tqYWgxPnnkuZOJB8Kpd91+HV51OrlwSd3lhW6q7jh2Ch87ZVnRZQL7+x9uTYZmcbUrbd7jTDz
 /SQX61caVHQimwbPQ8smisaDnbCB9lJeRrfNex5PfzDLorGLYQdKMw2smT57gg+lHhrMSGFOk
 lTb1cKDSoX1VakJbbBmD1q14PTEkeO7j+21fxtAeQucE4du1P+ljg0zIYpassjWe08Mmv+a4x
 lgVYzEtznMhihE5Dmb0I932tlpk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 20:27, Spencer Collyer wrote:
> Hi,
> 
> I've hit a problem with a BTRFS filesystem I have on my main machine. It's gone into read-only mode, I suspect because it ran out of disk space (it's got v little space left).
> 
> (I've put the info that is requested on the mailing list page at the end of this message.)
> 
> Ironically I was going to shift a large chunk of data off this filesystem onto an external backup disk but hadn't gotten around to doing it.
> 
> Digging around on the web I've seen suggestions involving unmounting the filesystem, remounting it R/W, removing any unwanted data, then continuing the rebalance. They generally seem to want to add another disk temporarily as well.
> 
> I don't really want to go to the trouble of temporarily adding a secondary disk only to then remove it again. As I was already planning on moving a bunch of old data off to external backup, I'm wondering if the following would be safe to do:
> 
> 1) Unmount the filesystem.
> 2) Remount it as R/W
> 3) Move data to the external disk
> 4) Resume the rebalance operation (is this required?)

I don't think balance can even start.

> 
> Does that look reasonable? Is there likely to be any problem with moving files off the filesystem when the rebalance operation failed?

Moving files doesn't seem to cause the problem.

> 
> Thanks for you attention,
> 
> Spencer
> 
> Command output:
> 
> uname -a:
> Linux selket 6.0.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 29 Oct 2022 14:08:39 +0000 x86_64 GNU/Linux
> 
> btrfs --version:
> btrfs-progs v6.0
> 
> btrfs fi show: (empty output)
> 
> btrfs fi df /data
> Data, RAID0: total=10.87TiB, used=10.86TiB
> System, single: total=4.00MiB, used=0.00B
> System, RAID1: total=8.00MiB, used=784.00KiB
> Metadata, single: total=8.00MiB, used=0.00B
> Metadata, RAID1: total=23.00GiB, used=21.39GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> WARNING:    Metadata: single, raid1
> WARNING:    System: single, raid1

In fact, you have around 12 MiB space taken by SINGLE chunks.

Thus you can go with something like "btrfs balance start -musage=0 
-susage=0 <mnt>" to free up some space.

But that's only recommended when you have moved some data first (aka, 
deleted some data).
Or I guess you may ran out of space again.


Another thing not really shown in your report is "btrfs fi usage <mnt>".

There is a known bug especially for multi-device profiles like RAID1 
that, if one device ran out of space, while the other device still has 
some space left, btrfs will wrongly assume it still has enough space.

I believe that's exactly the reason why you hit the ENOSPC at such a 
critical path. Other than hitting ENOSPC reserving space before doing 
the real work.

> 
> I'm using systemd, so rather than dmesg the following is output from 'journalctl -b', looking for the first BTRFS error:
> Nov 15 09:09:35 selket kernel: ------------[ cut here ]------------
> Nov 15 09:09:35 selket kernel: BTRFS: Transaction aborted (error -28)
> Nov 15 09:09:35 selket kernel: BTRFS: error (device dm-1: state A) in btrfs_finish_ordered_io:3315: errno=-28 No space left

This function is responsible to insert the file extent items and 
checksum items.

Hitting ENOSPC here mostly means the above RAID1 situation where btrfs 
wrongly assume it can continue by over-committing its metadata space.

Considering you have some metadata space left, I believe you can free 
enough space by deleting files (aka, moving it to other filesystems)

Thanks,
Qu

> Nov 15 09:09:35 selket kernel: BTRFS info (device dm-1: state EA): forced readonly
> Nov 15 09:09:35 selket kernel: WARNING: CPU: 6 PID: 81435 at fs/btrfs/inode.c:3315 btrfs_finish_ordered_io+0x894/0x960 [btrfs]
> Nov 15 09:09:35 selket kernel: Modules linked in: btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr iTCO_wdt intel_pmc_bxt eeepc_wmi asus_wmi iTCO_vendor_support>
> Nov 15 09:09:35 selket kernel:  usbhid crc32c_intel sr_mod xhci_pci cdrom xhci_pci_renesas
> Nov 15 09:09:35 selket kernel: CPU: 6 PID: 81435 Comm: kworker/u32:16 Not tainted 6.0.6-arch1-1 #1 a46cc4b882cfc11c3bbb09d6a0fab3dcad53b5c2
> Nov 15 09:09:35 selket kernel: Hardware name: ASUS All Series/X99-E WS, BIOS 1003 03/04/2015
> Nov 15 09:09:35 selket kernel: Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> Nov 15 09:09:35 selket kernel: RIP: 0010:btrfs_finish_ordered_io+0x894/0x960 [btrfs]
> Nov 15 09:09:35 selket kernel: Code: 49 8b 46 50 48 05 28 0a 00 00 f0 48 0f ba 28 03 72 1a 83 fd fb 74 30 83 fd e2 74 2b 89 ee 48 c7 c7 e8 9f 48 c1 e8 ac ec 5d e6 <0f> 0b >
> Nov 15 09:09:35 selket kernel: RSP: 0018:ffff99624757fd68 EFLAGS: 00010286
> Nov 15 09:09:35 selket kernel: RAX: 0000000000000000 RBX: ffff8c532a95a940 RCX: 0000000000000027
> Nov 15 09:09:35 selket kernel: RDX: ffff8c57ffba1668 RSI: 0000000000000001 RDI: ffff8c57ffba1660
> Nov 15 09:09:35 selket kernel: RBP: 00000000ffffffe4 R08: 0000000000000000 R09: ffff99624757fbf0
> Nov 15 09:09:35 selket kernel: R10: 0000000000000003 R11: ffffffffa8acb508 R12: 0000000024906000
> Nov 15 09:09:35 selket kernel: R13: ffff8c490501b000 R14: ffff8c49088fee38 R15: ffff8c532a27b4e0
> Nov 15 09:09:35 selket kernel: FS:  0000000000000000(0000) GS:ffff8c57ffb80000(0000) knlGS:0000000000000000
> Nov 15 09:09:35 selket kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov 15 09:09:35 selket kernel: CR2: 00007ff124cfd000 CR3: 0000000173610001 CR4: 00000000001706e0
> Nov 15 09:09:35 selket kernel: Call Trace:
> Nov 15 09:09:35 selket kernel:  <TASK>
> Nov 15 09:09:35 selket kernel:  btrfs_work_helper+0xe8/0x380 [btrfs bea3ab37602bd115354fd14d10316f0d593c6d2f]
> Nov 15 09:09:35 selket kernel:  process_one_work+0x1c7/0x380
> Nov 15 09:09:35 selket kernel:  worker_thread+0x51/0x390
> Nov 15 09:09:35 selket kernel:  ? rescuer_thread+0x3b0/0x3b0
> Nov 15 09:09:35 selket kernel:  kthread+0xde/0x110
> Nov 15 09:09:35 selket kernel:  ? kthread_complete_and_exit+0x20/0x20
> Nov 15 09:09:35 selket kernel:  ret_from_fork+0x22/0x30
> Nov 15 09:09:35 selket kernel:  </TASK>
> Nov 15 09:09:35 selket kernel: ---[ end trace 0000000000000000 ]---
