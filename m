Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1D4B4543
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 10:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiBNJL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 04:11:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiBNJL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 04:11:28 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA55FF1A;
        Mon, 14 Feb 2022 01:11:20 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebfe.dynamic.kabel-deutschland.de [95.90.235.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD0D361EA1935;
        Mon, 14 Feb 2022 10:11:18 +0100 (CET)
Message-ID: <404c5f3b-24c1-c442-9132-82d3212bf7f1@molgen.mpg.de>
Date:   Mon, 14 Feb 2022 10:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: I/O errors only during shutdown and free space cache failures
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Linux folks,


On an IBM S822LC with Ubuntu 21.10, only when shutting down the system 
there are I/O errors hanging the system. I was able to capture some 
messages from the end:

```
[XXXXXXXXXXXX3] I/O error, dev sda, sector 1198060800 op 0x1:(WRITE) 
flags 0x100000 phys_seg 1 prio class 0
[223109.260842] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 3, rd 
0, flush 0, corrupt 0, gen 0
[223109.260878] sd 0:0:0:0: [sda] tag#15 timing out command, waited 180s
[223109.261026] I/O error, dev sda, sector 1198829952 op 0x1:(WRITE) 
flags 0x104000 phys_seg 20 prio class 0
[223109.360562] sd 0:0:0:0: [sda] tag#28 timing out command, waited 180s
[223109.360615] I/O error, dev sda, sector 1198835072 op 0x1:(WRITE) 
flags 0x100000 phys_seg 17 prio class 0
[223109.360757] sd 0:0:0:0: [sda] tag#29 timing out command, waited 180s
[223109.360778] I/O error, dev sda, sector 1198832512 op 0x1:(WRITE) 
flags 0x104000 phys_seg 20 prio class 0
[223109.360798] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 4, rd 
0, flush 0, corrupt 0, gen 0
[223179.108402] INFO: task kworker/0:2:651024 blocked for more than 120 
seconds.
[223179.108481]       Not tainted 5.17.0-rc3+ #1
[223179.108580] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[223179.109311] INFO: task kworker/u321:7:652803 blocked for more than 
120 seconds.
[223179.109357]       Not tainted 5.17.0-rc3+ #1
[223179.109370] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[223289.259960] sd 0:0:0:0: [sda] tag#24 timing out command, waited 180s
[223289.260169] I/O error, dev sda, sector 1197961728 op 0x0:(READ) 
flags 0x0 phys_seg 1 prio class 0
[223289.260192] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 4, rd 
1, flush 0, corrupt 0, gen 0
[223289.363952] sd 0:0:0:0: [sda] tag#13 timing out command, waited 180s
[223289.363958] sd 0:0:0:0: [sda] tag#16 timing out command, waited 180s
[223289.364152] I/O error, dev sda, sector 1064447232 op 0x1:(WRITE) 
flags 0x4800 phys_seg 20 prio class 0
[223289.364176] I/O error, dev sda, sector 1198837504 op 0x1:(WRITE) 
flags 0x100000 phys_seg 7 prio class 0
[223289.364182] sd 0:0:0:0: [sda] tag#14 timing out command, waited 180s
[223289.364198] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 5, rd 
1, flush 0, corrupt 0, gen 0
[223289.364364] I/O error, dev sda, sector 1064444672 op 0x1:(WRITE) 
flags 0x4800 phys_seg 20 prio class 0
[223289.364377] sd 0:0:0:0: [sda] tag#17 timing out command, waited 180s
[223289.364388] sd 0:0:0:0: [sda] tag#15 timing out command, 
[228549.050771442,5] IPMI: Soft shutdown requested
waited 180s
[223289.364417] I/O error, dev sda, sector 1198838528 op 0x1:(WRITE) 
flags 0x100000 phys_seg 2 prio class 0
[223289.364421] I/O error, dev sda, sector 1064452352 op 0x1:(WRITE) 
flags 0x800 phys_seg 4 prio class 0
[223289.364438] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 6, rd 
1, flush 0, corrupt 0, gen 0
[223289.364466] sd 0:0:0:0: [sda] tag#19 timing out command, waited 180s
[223289.364498] I/O error, dev sda, sector 1064449792 op 0x1:(WRITE) 
flags 0x4800 phys_seg 20 prio class 0
[223289.364520] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 7, rd 
1, flush 0, corrupt 0, gen 0
[223299.944147] INFO: task kworker/0:2:651024 blocked for more than 241 
seconds.
[223299.944197]       Not tainted 5.17.0-rc3+ #1
[223299.944327] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[223299.945059] INFO: task kworker/u321:7:652803 blocked for more than 
241 seconds.
[223299.945105]       Not tainted 5.17.0-rc3+ #1
[223299.945117] "echo 0 > /proc/sys/kernel/hun[228630.461459920,5] OPAL: 
Shutdown request type 0x0...
g_task_timeout_secs" disables this message.
[223303.591904] sd 1:0:0:0: [sdb] tag#23 timing out command, waited 360s
[223303.592090] I/O error, dev sdb, sector 0 op 0x1:(WRITE) flags 0x800 
phys_seg 0 prio class 0
[223420.771542] INFO: task kworker/35:2:1077 blocked for more than 120 
seconds.
[223420.771680]       Not tainted 5.17.0-rc3+ #1
[223420.771722] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[223469.263372] sd 0:0:0:0: [sda] tag#31 timing out command, waited 180s
[223469.263480] I/O error, dev sda, sector 1197961728 op 0x0:(READ) 
flags 0x0 phys_seg 1 prio class 0
[223469.263600] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 7, rd 
2, flush 0, corrupt 0, gen 0
[223469.367343] sd 0:0:0:0: [sda] tag#17 timing out command, waited 180s
[223469.367346] sd 0:0:0:0: [sda] tag#19 timing out command, waited 180s
[223469.367358] sd 0:0:0:0: [sda] tag#15 timing out command, waited 180s
[223469.367382] I/O error, dev sda, sector 1198836992 op 0x1:(WRITE) 
flags 0x800 phys_seg 1 prio class 0
[223469.367390] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 8, rd 
2, flush 0, corrupt 0, gen 0
[223469.367401] I/O error, dev sda, sector 1198839168 op 0x1:(WRITE) 
flags 0x100000 phys_seg 1 prio class 0
[223469.367406] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 9, rd 
2, flush 0, corrupt 0, gen 0
[223469.367433] sd 0:0:0:0: [sda] tag#18 timing out command, waited 180s
[223469.367442] I/O error, dev sda, sector 1198839424 op 0x1:(WRITE) 
flags 0x100000 phys_seg 6 prio class 0
[223469.367445] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 10, 
rd 2, flush 0, corrupt 0, gen 0
[223469.367585] sd 0:0:0:0: [sda] tag#16 timing out command, waited 180s
[223469.367637] I/O error, dev sda, sector 480640 op 0x1:(WRITE) flags 
0x1800 phys_seg 1 prio class 0
[223469.367670] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 11, 
rd 2, flush 0, corrupt 0, gen 0
[223469.367690] I/O error, dev sda, sector 1198834816 op 0x1:(WRITE) 
flags 0x800 phys_seg 1 prio class 0
[223469.367798] sd 0:0:0:0: [sda] tag#20 timing out command, waited 180s
[223469.367845] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 12, 
rd 2, flush 0, corrupt 0, gen 0
[223469.367888] sd 0:0:0:0: [sda] tag#21 timing out command, waited 180s
[223469.367929] I/O error, dev sda, sector 2577792 op 0x1:(WRITE) flags 
0x1800 phys_seg 1 prio class 0
[223469.367949] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 13, 
rd 2, flush 0, corrupt 0, gen 0
[223469.367949] I/O error, dev sda, sector 1198838272 op 0x1:(WRITE) 
flags 0x800 phys_seg 1 prio class 0
[223469.367989] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 14, 
rd 2, flush 0, corrupt 0, gen 0
[223469.368018] sd 0:0:0:0: [sda] tag#22 timing out command, waited 180s
[223469.368046] I/O error, dev sda, sector 1198831360 op 0x1:(WRITE) 
flags 0x800 phys_seg 1 prio class 0
[223469.368069] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 15, 
rd 2, flush 0, corrupt 0, gen 0
[223469.368105] sd 0:0:0:0: [sda] tag#23 timing out command, waited 180s
[223469.368132] I/O error, dev sda, sector 1198060800 op 0x1:(WRITE) 
flags 0x800 phys_seg 1 prio class 0
[223469.368156] BTRFS error (device sda2): bdev /dev/sda2 errs: wr 16, 
rd 2, flush 0, corrupt 0, gen 0
[223469.380930] reboot: Power down
```

I had to power down the system manually. There are no messages when 
booting (and mounting) the HDD, which is the system drive.

Checking the partition, checking the free space cache returns some failures:

```
$ btrfs version
btrfs-progs v5.10.1
$ sudo btrfs check --readonly --force /dev/sda2
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sda2
UUID: 2c3dd738-785a-469b-843e-9f0ba8b47b0d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 29360128
btrfs: space cache generation (4119788) does not match inode (4119775)
failed to load free space cache for block group 741448089600
btrfs: space cache generation (4119786) does not match inode (4119782)
failed to load free space cache for block group 751111766016
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 795135180800
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 796208922624
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 803725115392
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 804798857216
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 808020082688
btrfs: space cache generation (4119788) does not match inode (4119782)
failed to load free space cache for block group 811241308160
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 604326461440 bytes used, no error found
total csum bytes: 35109100
total tree bytes: 7996112896
total fs tree bytes: 7701987328
total extent tree bytes: 231276544
btree space waste bytes: 1615676149
file data blocks allocated: 818525175808
  referenced 724324974592
```

Is that related? Is there a way to fix the system partition during 
runtime? (Otherwise I’d need to boot some live system or take the drive 
out.)


Kind regards,

Paul


PS: No idea, if useful:

```
$ sudo btrfs filesystem usage /
Overall:
     Device size:		 931.50GiB
     Device allocated:		 565.02GiB
     Device unallocated:		 366.48GiB
     Device missing:		     0.00B
     Used:			 560.86GiB
     Free (estimated):		 368.39GiB	(min: 185.15GiB)
     Free (statfs, df):		 368.39GiB
     Data ratio:			      1.00
     Metadata ratio:		      2.00
     Global reserve:		 275.81MiB	(used: 0.00B)
     Multiple profiles:		        no

Data,single: Size:548.01GiB, Used:546.10GiB (99.65%)
    /dev/sda2	 548.01GiB

Metadata,DUP: Size:8.50GiB, Used:7.38GiB (86.86%)
    /dev/sda2	  17.00GiB

System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
    /dev/sda2	  16.00MiB

Unallocated:
    /dev/sda2	 366.48GiB
$ sudo btrfs filesystem df /
Data, single: total=548.01GiB, used=546.10GiB
System, DUP: total=8.00MiB, used=64.00KiB
Metadata, DUP: total=8.50GiB, used=7.38GiB
GlobalReserve, single: total=275.81MiB, used=0.00B
```
