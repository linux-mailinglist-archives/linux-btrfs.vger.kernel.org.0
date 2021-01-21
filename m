Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9892E2FF926
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 00:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbhAUX4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 18:56:44 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58909 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbhAUX4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 18:56:42 -0500
X-Originating-IP: 87.154.216.30
Received: from [192.168.3.4] (p579ad81e.dip0.t-ipconnect.de [87.154.216.30])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BD74320007
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jan 2021 23:55:58 +0000 (UTC)
Subject: Re: Access Beyond End of Device & Input/Output Errors
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
From:   chainofflowers <chainofflowers@neuromante.net>
To:     linux-btrfs@vger.kernel.org
Message-ID: <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
Date:   Fri, 22 Jan 2021 00:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
Content-Type: multipart/mixed;
 boundary="------------00F2E4D12BF3D52C4D44026D"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------00F2E4D12BF3D52C4D44026D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Qu,

it happened again. This time on my /home partition.
I rebooted from an external disk and ran btrfs check without first going
through btrfs scrub, and this is the output, no errors:

------------------------------------------
[manjaro oc]# btrfs check /dev/mapper/OMO
Opening filesystem to check…
Checking filesystem on /dev/mapper/OMO
UUID: 9362ac9d-c280-451d-9c8a-c09798e1c887
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 137523740672 bytes used, no error found
total csum bytes: 113842816
total tree bytes: 1740537856
total fs tree bytes: 1444249600
total extent tree bytes: 143835136
btree space waste bytes: 325744995
file data blocks allocated: 210346024960
 referenced 172314374144
------------------------------------------

Then, I rebooted from my internal disk, everything went well. I ran
btrfs scrub and also got no errors.

I have dumped the messages from journalctl, and the debug ones related
to btrfs were only the ones from btrfs_trim_block_group - so, the issue
is related to free space extents I guess?

I have attached the logs.
You can see that the last line:

------------------------------------------
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg
start=26864517120 start=26864517120 end=27938258944 minlen=512
------------------------------------------

does not have a second matching line with "ret=0", because the kernel
stopped storing messages in the log. So, I guess the issue occurred
while btrfs_trim_block_group was working on 26864517120..27938258944.

Unfortunately I did not dump the output of dmesg directly in that
moment, so all I could get is what was available in the journal after
the reboot.

In the log you can also see that some time before BTRFS detected that
the space cache for dm-3 needed to be rebuilt:
------------------------------------------
Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): block group
82699091968 has wrong amount of free space
Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): failed to
load free space cache for block group 82699091968, rebuilding it now
------------------------------------------

Any hint about what I could do now?

Thanks! :-)



(c)

--------------00F2E4D12BF3D52C4D44026D
Content-Type: text/x-log; charset=UTF-8;
 name="btrfs_trim.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="btrfs_trim.log"

Jan 21 19:25:47 <***> kernel: Linux version 5.10.7-4-MANJARO-BTRFS-DEBUG (chainofflowers@luna) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Mon Jan 18 02:47:41 CET 2021
Jan 21 19:25:47 <***> kernel: usb usb1: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG ehci_hcd
Jan 21 19:25:47 <***> kernel: usb usb2: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG ehci_hcd
Jan 21 19:25:47 <***> kernel: usb usb3: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb4: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb5: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb6: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb7: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb8: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG uhci_hcd
Jan 21 19:25:47 <***> kernel: usb usb9: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: usb usb10: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: usb usb11: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: usb usb12: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: usb usb13: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: usb usb14: Manufacturer: Linux 5.10.7-4-MANJARO-BTRFS-DEBUG xhci-hcd
Jan 21 19:25:47 <***> kernel: Btrfs loaded, crc32c=crc32c-intel
Jan 21 19:25:47 <***> kernel: BTRFS: device label SYS devid 1 transid 320418 /dev/dm-0 scanned by systemd-udevd (212)
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): disk space caching is enabled
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): has skinny extents
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): enabling ssd optimizations
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): disk space caching is enabled
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): has skinny extents
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): enabling ssd optimizations
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): use zstd compression, level 3
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): enabling auto defrag
Jan 21 19:25:47 <***> kernel: BTRFS info (device dm-0): disk space caching is enabled
Jan 21 19:25:49 <***> kernel: BTRFS info (device dm-0): devid 1 device path /dev/mapper/SYS changed to /dev/dm-0 scanned by systemd-udevd (432)
Jan 21 19:25:49 <***> kernel: BTRFS info (device dm-0): devid 1 device path /dev/dm-0 changed to /dev/mapper/SYS scanned by systemd-udevd (432)
Jan 21 19:25:51 <***> kernel: BTRFS: device label SCRATCH devid 1 transid 36967 /dev/dm-2 scanned by systemd-udevd (427)
Jan 21 19:25:51 <***> kernel: BTRFS: device label HOME devid 1 transid 4316351 /dev/dm-3 scanned by systemd-udevd (427)
Jan 21 19:25:51 <***> kernel: BTRFS info (device dm-3): use zstd compression, level 3
Jan 21 19:25:51 <***> kernel: BTRFS info (device dm-3): enabling ssd optimizations
Jan 21 19:25:51 <***> kernel: BTRFS info (device dm-3): enabling auto defrag
Jan 21 19:25:51 <***> kernel: BTRFS info (device dm-3): disk space caching is enabled
Jan 21 19:25:51 <***> kernel: BTRFS info (device dm-3): has skinny extents
Jan 21 19:25:53 <***> kernel: BTRFS: device label USER devid 1 transid 8387 /dev/dm-5 scanned by systemd-udevd (427)
Jan 21 19:25:55 <***> kernel: BTRFS: device label USER devid 2 transid 8387 /dev/dm-6 scanned by systemd-udevd (427)
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): use zstd compression, level 3
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): enabling ssd optimizations
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): enabling auto defrag
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): disk space caching is enabled
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): has skinny extents
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): devid 1 device path /dev/mapper/user1 changed to /dev/dm-5 scanned by systemd-udevd (440)
Jan 21 19:25:55 <***> kernel: BTRFS info (device dm-5): devid 1 device path /dev/dm-5 changed to /dev/mapper/user1 scanned by systemd-udevd (440)
Jan 21 19:25:57 <***> kernel: BTRFS: device label SCRATCH devid 2 transid 36967 /dev/dm-7 scanned by systemd-udevd (427)
Jan 21 19:26:00 <***> kernel: BTRFS info (device dm-2): use no compression
Jan 21 19:26:00 <***> kernel: BTRFS info (device dm-2): enabling ssd optimizations
Jan 21 19:26:00 <***> kernel: BTRFS info (device dm-2): setting nodatacow, compression disabled
Jan 21 19:26:00 <***> kernel: BTRFS info (device dm-2): disk space caching is enabled
Jan 21 19:26:00 <***> kernel: BTRFS info (device dm-2): has skinny extents
Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): block group 82699091968 has wrong amount of free space
Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): failed to load free space cache for block group 82699091968, rebuilding it now
Jan 21 22:00:23 <***> kernel: BTRFS: device label BACKUP devid 1 transid 407 /dev/dm-8 scanned by systemd-udevd (26929)
Jan 21 22:00:23 <***> kernel: BTRFS info (device dm-8): use zstd compression, level 3
Jan 21 22:00:23 <***> kernel: BTRFS info (device dm-8): enabling auto defrag
Jan 21 22:00:23 <***> kernel: BTRFS info (device dm-8): disk space caching is enabled
Jan 21 22:00:23 <***> kernel: BTRFS info (device dm-8): has skinny extents
Jan 21 23:56:48 <***> kernel: btrfs_trim_block_group: enter bg start=4194304 start=4194304 end=12582912 minlen=512
Jan 21 23:56:48 <***> kernel: btrfs_trim_block_group: enter bg start=4194304 ret=0
Jan 21 23:56:48 <***> kernel: btrfs_trim_block_group: enter bg start=12582912 start=12582912 end=20971520 minlen=512
Jan 21 23:56:48 <***> kernel: btrfs_trim_block_group: enter bg start=12582912 ret=0
Jan 21 23:56:48 <***> kernel: btrfs_trim_block_group: enter bg start=20971520 start=20971520 end=1094713344 minlen=512
Jan 21 23:56:54 <***> kernel: btrfs_trim_block_group: enter bg start=20971520 ret=0
Jan 21 23:56:54 <***> kernel: btrfs_trim_block_group: enter bg start=1094713344 start=1094713344 end=2168455168 minlen=512
Jan 21 23:56:55 <***> kernel: btrfs_trim_block_group: enter bg start=1094713344 ret=0
Jan 21 23:56:55 <***> kernel: btrfs_trim_block_group: enter bg start=3242196992 start=3242196992 end=4315938816 minlen=512
Jan 21 23:56:58 <***> kernel: btrfs_trim_block_group: enter bg start=3242196992 ret=0
Jan 21 23:56:58 <***> kernel: btrfs_trim_block_group: enter bg start=4315938816 start=4315938816 end=5389680640 minlen=512
Jan 21 23:57:02 <***> kernel: btrfs_trim_block_group: enter bg start=4315938816 ret=0
Jan 21 23:57:02 <***> kernel: btrfs_trim_block_group: enter bg start=5389680640 start=5389680640 end=6463422464 minlen=512
Jan 21 23:57:08 <***> kernel: btrfs_trim_block_group: enter bg start=5389680640 ret=0
Jan 21 23:57:08 <***> kernel: btrfs_trim_block_group: enter bg start=6463422464 start=6463422464 end=7537164288 minlen=512
Jan 21 23:57:12 <***> kernel: btrfs_trim_block_group: enter bg start=6463422464 ret=0
Jan 21 23:57:12 <***> kernel: btrfs_trim_block_group: enter bg start=7537164288 start=7537164288 end=8610906112 minlen=512
Jan 21 23:57:15 <***> kernel: btrfs_trim_block_group: enter bg start=7537164288 ret=0
Jan 21 23:57:15 <***> kernel: btrfs_trim_block_group: enter bg start=8610906112 start=8610906112 end=9684647936 minlen=512
Jan 21 23:57:18 <***> kernel: btrfs_trim_block_group: enter bg start=8610906112 ret=0
Jan 21 23:57:18 <***> kernel: btrfs_trim_block_group: enter bg start=9684647936 start=9684647936 end=10758389760 minlen=512
Jan 21 23:57:21 <***> kernel: btrfs_trim_block_group: enter bg start=9684647936 ret=0
Jan 21 23:57:21 <***> kernel: btrfs_trim_block_group: enter bg start=10758389760 start=10758389760 end=11832131584 minlen=512
Jan 21 23:57:23 <***> kernel: btrfs_trim_block_group: enter bg start=10758389760 ret=0
Jan 21 23:57:23 <***> kernel: btrfs_trim_block_group: enter bg start=11832131584 start=11832131584 end=12905873408 minlen=512
Jan 21 23:57:23 <***> kernel: btrfs_trim_block_group: enter bg start=11832131584 ret=0
Jan 21 23:57:23 <***> kernel: btrfs_trim_block_group: enter bg start=12905873408 start=12905873408 end=13979615232 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=12905873408 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=13979615232 start=13979615232 end=15053357056 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=13979615232 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=15053357056 start=15053357056 end=16127098880 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=15053357056 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=16127098880 start=16127098880 end=17200840704 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=16127098880 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=17200840704 start=17200840704 end=18274582528 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=17200840704 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=18274582528 start=18274582528 end=19348324352 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=18274582528 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=19348324352 start=19348324352 end=20422066176 minlen=512
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=19348324352 ret=0
Jan 21 23:57:24 <***> kernel: btrfs_trim_block_group: enter bg start=20422066176 start=20422066176 end=21495808000 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=20422066176 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=21495808000 start=21495808000 end=22569549824 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=21495808000 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=22569549824 start=22569549824 end=23643291648 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=22569549824 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=23643291648 start=23643291648 end=24717033472 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=23643291648 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=24717033472 start=24717033472 end=25790775296 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=24717033472 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=25790775296 start=25790775296 end=26864517120 minlen=512
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=25790775296 ret=0
Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg start=26864517120 start=26864517120 end=27938258944 minlen=512

--------------00F2E4D12BF3D52C4D44026D--
