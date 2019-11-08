Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A84F5A8E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfKHWGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 17:06:55 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49006 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKHWGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:06:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4E4C6608325B
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Nov 2019 23:06:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6sZJrtmQMZsL for <linux-btrfs@vger.kernel.org>;
        Fri,  8 Nov 2019 23:06:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C02726083279
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Nov 2019 23:06:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QrXieDp6QhNY for <linux-btrfs@vger.kernel.org>;
        Fri,  8 Nov 2019 23:06:51 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 7EBF2608325B
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Nov 2019 23:06:51 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Decoding "unable to fixup (regular)" errors
Date:   Fri, 08 Nov 2019 23:06:50 +0100
Message-ID: <2590197.gOHgNE8CYM@blindfold>
In-Reply-To: <1591390.YpsIS3gr9g@blindfold>
References: <1591390.YpsIS3gr9g@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Dienstag, 5. November 2019, 23:03:01 CET schrieb Richard Weinberger:
> [10860370.764595] BTRFS error (device md1): unable to fixup (regular) error at logical 593483341824 on dev /dev/md1
> [10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2292, gen 0
> [10860395.237267] BTRFS error (device md1): unable to fixup (regular) error at logical 595304841216 on dev /dev/md1
> [10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2293, gen 0
> [10860395.506560] BTRFS error (device md1): unable to fixup (regular) error at logical 595326820352 on dev /dev/md1
> [10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2294, gen 0
> [10860395.512061] BTRFS error (device md1): unable to fixup (regular) error at logical 595327647744 on dev /dev/md1
> [10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2295, gen 0
> [10860395.664959] BTRFS error (device md1): unable to fixup (regular) error at logical 595344850944 on dev /dev/md1
> [10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2296, gen 0
> [10860395.677736] BTRFS error (device md1): unable to fixup (regular) error at logical 595346452480 on dev /dev/md1
> [10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2297, gen 0
> [10860395.771523] BTRFS error (device md1): unable to fixup (regular) error at logical 595357601792 on dev /dev/md1
> [10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2298, gen 0
> [10860395.790455] BTRFS error (device md1): unable to fixup (regular) error at logical 595359870976 on dev /dev/md1
> [10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2299, gen 0
> [10860395.807381] BTRFS error (device md1): unable to fixup (regular) error at logical 595361865728 on dev /dev/md1
> [10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2300, gen 0
> [10860395.919513] BTRFS error (device md1): unable to fixup (regular) error at logical 595372343296 on dev /dev/md1
> [10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2301, gen 0
> [10860395.994574] BTRFS error (device md1): unable to fixup (regular) error at logical 595384438784 on dev /dev/md1

> For obvious reasons the "BTRFS error (device md1): unable to fixup (regular) error" lines made me nervous
> and I would like to understand better what is going on.
> The system has ECC memory with md1 being a RAID1 which passes all health checks.
> 
> I tried to find the inodes behind the erroneous addresses without success.
> e.g.
> $ btrfs inspect-internal logical-resolve -v -P 593483341824 /
> ioctl ret=0, total_size=4096, bytes_left=4080, bytes_missing=0, cnt=0, missed=0
> $ echo $?
> 1
> 
> My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super recent but AFAICT btrfs should be sane
> there. :-)
> 
> What could cause the errors and how to dig further?

I was able to reproduce this on vanilla v5.4-rc6.

Instrumenting btrfs revealed that all erroneous blocks are data blocks (BTRFS_EXTENT_FLAG_DATA)
and only have ->checksum_error set.
Both expected and computed checksums are non-zero.

To me it seems like all these blocks are orphaned data, while extent_from_logical() finds and extent
for the affected logical addresses, none of the extents belong to an inode.
This explains also why "btrfs inspect-internal logical-resolve" is unable to point me to an
inode. And why scrub_print_warning("checksum error", sblock_to_check) does not log anything.
The function returns early if no inode can be found for a data block...

This is something to worry about?

Why does the scrubbing mechanism check orphaned blocks?

Thanks,
//richard


