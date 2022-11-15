Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67196298DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 13:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKOMaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 07:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKOMaJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 07:30:09 -0500
X-Greylist: delayed 182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 04:30:07 PST
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB491C92D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 04:30:07 -0800 (PST)
Received: from selket.spencercollyer.plus.com ([80.189.102.133])
        by smtp with ESMTP
        id uv1roSAZywyIMuv1so9NR1; Tue, 15 Nov 2022 12:27:04
 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1668515224; bh=tk4dZdJhbG2CbJ9ma8bzk7B2YUSVDl33SdSjoFbsHPo=;
        h=Date:From:To:Subject;
        b=aa+mgHi4dqtTaBYHi5xinau1b61115DlmKO3zrl4YMUkSa7eouFPPLUNtGKM+sbyb
         0wlKUDONWiT/cGep0uXYAC3m1yx4xz77pvDl7nT+OmSjhdxEb3Uwr9hIPtjz6uWGdk
         pbg6Iy5QEHld1+CCaYyOW3guXxYFuUHdt5sXVaIh+Ltfph/6946OxvoVuwc+SNZXmx
         ZmhjId1lryucwse6qy97VIdslSBlsAmybQJzzkbIisZPQTu7IUe+XCsJI/lQSda6SQ
         hyrqq0DbM7qQQs5qo1DtwJ5OzYUJMz/UZzc5SvtPl62q/kqgiDBiywl5I8Sl4Y0OXZ
         8PQt+x6Sru74A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=R88QpPdX c=1 sm=1 tr=0 ts=63738598
 a=t3eprasJVEmiovQRZ0k/8A==:117 a=t3eprasJVEmiovQRZ0k/8A==:17
 a=kj9zAlcOel0A:10 a=9xFQ1JgjjksA:10 a=1cuSFYkUW8jDwQSUR6QA:9 a=CjuIK1q_8ugA:10
Received: from selket (localhost.localdomain [127.0.0.1])
        by selket.spencercollyer.plus.com (Postfix) with ESMTP id DAC3E80062
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:27:02 +0000 (GMT)
Date:   Tue, 15 Nov 2022 12:27:02 +0000
From:   Spencer Collyer <spencer@spencercollyer.plus.com>
To:     linux-btrfs@vger.kernel.org
Subject: Change BTRFS filesystem back to R/W from R/O
Message-ID: <20221115122702.4ca83887@selket>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFiSGG1fqqsSvDdu29g3Hf45cNgEPrKYp5a6lo0juyJWQgTSJZgYbysulEyd7wh/kIzebqkeotpRw92RgmKsx7d1eH+xcyIVeHY+bPL+4a413LvCLjMY
 VKy7i0RcptNUA8DN6G7lVM8F1CmnpMP/ikpbjFt3jp1PNi9J2kcHJbaPP7RKH9NzuCVA1dJFhf2mFm5MYbsmQqeZ1ZmmVLahQXsUJBEPAP8jjWnStW1GM0TV
 0MEOq+Sy9mXSHpozKw83Ww==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've hit a problem with a BTRFS filesystem I have on my main machine. It's gone into read-only mode, I suspect because it ran out of disk space (it's got v little space left).

(I've put the info that is requested on the mailing list page at the end of this message.)

Ironically I was going to shift a large chunk of data off this filesystem onto an external backup disk but hadn't gotten around to doing it.

Digging around on the web I've seen suggestions involving unmounting the filesystem, remounting it R/W, removing any unwanted data, then continuing the rebalance. They generally seem to want to add another disk temporarily as well.

I don't really want to go to the trouble of temporarily adding a secondary disk only to then remove it again. As I was already planning on moving a bunch of old data off to external backup, I'm wondering if the following would be safe to do:

1) Unmount the filesystem.
2) Remount it as R/W
3) Move data to the external disk
4) Resume the rebalance operation (is this required?)

Does that look reasonable? Is there likely to be any problem with moving files off the filesystem when the rebalance operation failed?

Thanks for you attention,

Spencer

Command output:

uname -a:
Linux selket 6.0.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 29 Oct 2022 14:08:39 +0000 x86_64 GNU/Linux

btrfs --version:
btrfs-progs v6.0

btrfs fi show: (empty output)

btrfs fi df /data
Data, RAID0: total=10.87TiB, used=10.86TiB
System, single: total=4.00MiB, used=0.00B
System, RAID1: total=8.00MiB, used=784.00KiB
Metadata, single: total=8.00MiB, used=0.00B
Metadata, RAID1: total=23.00GiB, used=21.39GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
WARNING:    Metadata: single, raid1
WARNING:    System: single, raid1

I'm using systemd, so rather than dmesg the following is output from 'journalctl -b', looking for the first BTRFS error:
Nov 15 09:09:35 selket kernel: ------------[ cut here ]------------
Nov 15 09:09:35 selket kernel: BTRFS: Transaction aborted (error -28)
Nov 15 09:09:35 selket kernel: BTRFS: error (device dm-1: state A) in btrfs_finish_ordered_io:3315: errno=-28 No space left
Nov 15 09:09:35 selket kernel: BTRFS info (device dm-1: state EA): forced readonly
Nov 15 09:09:35 selket kernel: WARNING: CPU: 6 PID: 81435 at fs/btrfs/inode.c:3315 btrfs_finish_ordered_io+0x894/0x960 [btrfs]
Nov 15 09:09:35 selket kernel: Modules linked in: btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr iTCO_wdt intel_pmc_bxt eeepc_wmi asus_wmi iTCO_vendor_support>
Nov 15 09:09:35 selket kernel:  usbhid crc32c_intel sr_mod xhci_pci cdrom xhci_pci_renesas
Nov 15 09:09:35 selket kernel: CPU: 6 PID: 81435 Comm: kworker/u32:16 Not tainted 6.0.6-arch1-1 #1 a46cc4b882cfc11c3bbb09d6a0fab3dcad53b5c2
Nov 15 09:09:35 selket kernel: Hardware name: ASUS All Series/X99-E WS, BIOS 1003 03/04/2015
Nov 15 09:09:35 selket kernel: Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
Nov 15 09:09:35 selket kernel: RIP: 0010:btrfs_finish_ordered_io+0x894/0x960 [btrfs]
Nov 15 09:09:35 selket kernel: Code: 49 8b 46 50 48 05 28 0a 00 00 f0 48 0f ba 28 03 72 1a 83 fd fb 74 30 83 fd e2 74 2b 89 ee 48 c7 c7 e8 9f 48 c1 e8 ac ec 5d e6 <0f> 0b >
Nov 15 09:09:35 selket kernel: RSP: 0018:ffff99624757fd68 EFLAGS: 00010286
Nov 15 09:09:35 selket kernel: RAX: 0000000000000000 RBX: ffff8c532a95a940 RCX: 0000000000000027
Nov 15 09:09:35 selket kernel: RDX: ffff8c57ffba1668 RSI: 0000000000000001 RDI: ffff8c57ffba1660
Nov 15 09:09:35 selket kernel: RBP: 00000000ffffffe4 R08: 0000000000000000 R09: ffff99624757fbf0
Nov 15 09:09:35 selket kernel: R10: 0000000000000003 R11: ffffffffa8acb508 R12: 0000000024906000
Nov 15 09:09:35 selket kernel: R13: ffff8c490501b000 R14: ffff8c49088fee38 R15: ffff8c532a27b4e0
Nov 15 09:09:35 selket kernel: FS:  0000000000000000(0000) GS:ffff8c57ffb80000(0000) knlGS:0000000000000000
Nov 15 09:09:35 selket kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 15 09:09:35 selket kernel: CR2: 00007ff124cfd000 CR3: 0000000173610001 CR4: 00000000001706e0
Nov 15 09:09:35 selket kernel: Call Trace:
Nov 15 09:09:35 selket kernel:  <TASK>
Nov 15 09:09:35 selket kernel:  btrfs_work_helper+0xe8/0x380 [btrfs bea3ab37602bd115354fd14d10316f0d593c6d2f]
Nov 15 09:09:35 selket kernel:  process_one_work+0x1c7/0x380
Nov 15 09:09:35 selket kernel:  worker_thread+0x51/0x390
Nov 15 09:09:35 selket kernel:  ? rescuer_thread+0x3b0/0x3b0
Nov 15 09:09:35 selket kernel:  kthread+0xde/0x110
Nov 15 09:09:35 selket kernel:  ? kthread_complete_and_exit+0x20/0x20
Nov 15 09:09:35 selket kernel:  ret_from_fork+0x22/0x30
Nov 15 09:09:35 selket kernel:  </TASK>
Nov 15 09:09:35 selket kernel: ---[ end trace 0000000000000000 ]---
