Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F043F08F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfKEWDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 17:03:06 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:52320 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfKEWDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Nov 2019 17:03:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 578266083247
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 23:03:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ON6PJ56oWrvG for <linux-btrfs@vger.kernel.org>;
        Tue,  5 Nov 2019 23:03:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D41B5608325B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 23:03:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8XNJKpu26M6z for <linux-btrfs@vger.kernel.org>;
        Tue,  5 Nov 2019 23:03:02 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A5B3D6083247
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 23:03:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-btrfs@vger.kernel.org
Subject: Decoding "unable to fixup (regular)" errors
Date:   Tue, 05 Nov 2019 23:03:01 +0100
Message-ID: <1591390.YpsIS3gr9g@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

One of my build servers logged the following:

[10511433.614135] BTRFS info (device md1): relocating block group 2931997933568 flags data
[10511441.887812] BTRFS info (device md1): found 135 extents
[10511466.539198] BTRFS info (device md1): found 135 extents
[10511472.805969] BTRFS info (device md1): found 1 extents
[10511480.786194] BTRFS info (device md1): relocating block group 2933071675392 flags data
[10511487.314283] BTRFS info (device md1): found 117 extents
[10511498.483226] BTRFS info (device md1): found 117 extents
[10511506.708389] BTRFS info (device md1): relocating block group 2930890637312 flags system|dup
[10511508.386025] BTRFS info (device md1): found 5 extents
[10511511.382986] BTRFS info (device md1): relocating block group 2935219159040 flags system|dup
[10511512.565190] BTRFS info (device md1): found 5 extents
[10511519.032713] BTRFS info (device md1): relocating block group 2935252713472 flags system|dup
[10511520.586222] BTRFS info (device md1): found 5 extents
[10511523.107052] BTRFS info (device md1): relocating block group 2935286267904 flags system|dup
[10511524.392271] BTRFS info (device md1): found 5 extents
[10511527.381846] BTRFS info (device md1): relocating block group 2935319822336 flags system|dup
[10511528.766564] BTRFS info (device md1): found 5 extents
[10857025.725121] BTRFS info (device md1): relocating block group 2934145417216 flags data
[10857057.071228] BTRFS info (device md1): found 1275 extents
[10857073.721609] BTRFS info (device md1): found 1231 extents
[10857086.237500] BTRFS info (device md1): relocating block group 2935386931200 flags data
[10857095.182532] BTRFS info (device md1): found 151 extents
[10857125.204024] BTRFS info (device md1): found 151 extents
[10857133.473086] BTRFS info (device md1): relocating block group 2935353376768 flags system|dup
[10857135.063924] BTRFS info (device md1): found 5 extents
[10857138.066852] BTRFS info (device md1): relocating block group 2937534414848 flags system|dup
[10857139.542984] BTRFS info (device md1): found 5 extents
[10857142.083035] BTRFS info (device md1): relocating block group 2937567969280 flags system|dup
[10857143.664667] BTRFS info (device md1): found 5 extents
[10857145.971518] BTRFS info (device md1): relocating block group 2937601523712 flags system|dup
[10857146.924543] BTRFS info (device md1): found 5 extents
[10857150.289957] BTRFS info (device md1): relocating block group 2937635078144 flags system|dup
[10857152.173086] BTRFS info (device md1): found 5 extents
[10860370.725465] scrub_handle_errored_block: 71 callbacks suppressed
[10860370.764356] btrfs_dev_stat_print_on_error: 71 callbacks suppressed
[10860370.764359] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2291, gen 0
[10860370.764593] scrub_handle_errored_block: 71 callbacks suppressed
[10860370.764595] BTRFS error (device md1): unable to fixup (regular) error at logical 593483341824 on dev /dev/md1
[10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2292, gen 0
[10860395.237267] BTRFS error (device md1): unable to fixup (regular) error at logical 595304841216 on dev /dev/md1
[10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2293, gen 0
[10860395.506560] BTRFS error (device md1): unable to fixup (regular) error at logical 595326820352 on dev /dev/md1
[10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2294, gen 0
[10860395.512061] BTRFS error (device md1): unable to fixup (regular) error at logical 595327647744 on dev /dev/md1
[10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2295, gen 0
[10860395.664959] BTRFS error (device md1): unable to fixup (regular) error at logical 595344850944 on dev /dev/md1
[10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2296, gen 0
[10860395.677736] BTRFS error (device md1): unable to fixup (regular) error at logical 595346452480 on dev /dev/md1
[10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2297, gen 0
[10860395.771523] BTRFS error (device md1): unable to fixup (regular) error at logical 595357601792 on dev /dev/md1
[10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2298, gen 0
[10860395.790455] BTRFS error (device md1): unable to fixup (regular) error at logical 595359870976 on dev /dev/md1
[10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2299, gen 0
[10860395.807381] BTRFS error (device md1): unable to fixup (regular) error at logical 595361865728 on dev /dev/md1
[10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2300, gen 0
[10860395.919513] BTRFS error (device md1): unable to fixup (regular) error at logical 595372343296 on dev /dev/md1
[10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2301, gen 0
[10860395.994574] BTRFS error (device md1): unable to fixup (regular) error at logical 595384438784 on dev /dev/md1
[11033396.165434] md: data-check of RAID array md0
[11033396.273818] md: data-check of RAID array md2
[11033396.282822] md: delaying data-check of md1 until md0 has finished (they share one or more physical units)
[11033406.609033] md: md0: data-check done.
[11033406.623027] md: data-check of RAID array md1
[11035858.847538] md: md2: data-check done.
[11043788.746468] md: md1: data-check done.

For obvious reasons the "BTRFS error (device md1): unable to fixup (regular) error" lines made me nervous
and I would like to understand better what is going on.
The system has ECC memory with md1 being a RAID1 which passes all health checks.

I tried to find the inodes behind the erroneous addresses without success.
e.g.
$ btrfs inspect-internal logical-resolve -v -P 593483341824 /
ioctl ret=0, total_size=4096, bytes_left=4080, bytes_missing=0, cnt=0, missed=0
$ echo $?
1

My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super recent but AFAICT btrfs should be sane
there. :-)

What could cause the errors and how to dig further?

Thanks,
//richard


