Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4554A37EF99
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhELXOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbhELXI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 19:08:58 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BCC06134A
        for <linux-btrfs@vger.kernel.org>; Wed, 12 May 2021 16:02:48 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4F3B1C009; Thu, 13 May 2021 01:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620860552; bh=qxZ1C/C/C9bIerWgZU8HqaqnuW3gVCC9vkza07JadR4=;
        h=Date:From:To:Subject:From;
        b=HpenF5uRtYIwJkd8d7vD8D1FPqTX4Qv03tu+nGIJWaOshEndRyvOyCv4w6wvWRxp0
         yFCpxPHHR+vugatQZ/Pe981XIz0IPO/qe/HBLSJPhDejXQR1ILjHLajrrS8CzkuATh
         hjyhd6Kf+mhni4EGi/LMwAlU1dEsAxpZaZOTd/UJdp5FEM/k7fvupfjWneIHOhiS5q
         me2TQJ08mYDQGbuL7aHA/wJS0AVW0Wl1a2Esjxom1+6X6bkoTrpHPVjLZ2OTmuqAQc
         yCVMMlnImzmmrwded6PIIZJQUP/CfaTs0NFsuOYpZ3RNrhquqbvo1bj6nFz2T+qM/K
         vrvxnhBLnpWxA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A5C67C009
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 01:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620860551; bh=qxZ1C/C/C9bIerWgZU8HqaqnuW3gVCC9vkza07JadR4=;
        h=Date:From:To:Subject:From;
        b=aqclYXgMJVBhzZcUd6FTO2Mt8qMsz10KvY0ACc9xXcmYtklhNVZ5y5krBK7co0wDN
         /xZNHihtHnPbdF39NYHr5VRnEIoZhdniOGwYK/gNZKbchC0lgiVwWDAcDs9aIEz4Im
         gnG3H5eL+QqPfq4YhqvvUX1zjppqmVltsFhbd1J7ak8c+5IEukMu+JfguDUiLxcYXV
         IHjghedxQPpRhoc9dxKDl2Mk65RWbeb6zzaa3ypC7FDFMObEMwl5uMZFQ/FtjHKNHt
         ud4FX3TGcAG5g6bIvBEw13jooBMJ0KugDKcfBjkyqBIi9IW73u1Y4NFKm5SSlOjRax
         jRoGHS8N4NpQw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b73372ab
        for <linux-btrfs@vger.kernel.org>;
        Wed, 12 May 2021 23:02:27 +0000 (UTC)
Date:   Thu, 13 May 2021 08:02:12 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs degraded raid1 gone read-only
Message-ID: <YJxedBNzfHqEYI1l@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this looks a bit like the warning on the wiki[1], but since that falls
under old kernels it's probably slightly different.

[1] https://btrfs.wiki.kernel.org/index.php/Gotchas#raid1_volumes_only_mountable_once_RW_if_degraded


Kernel 5.11.16-300.fc34.x86_64

How to get there (didn't try to reproduce yet, I'll keep the broken
device around a few days if requested to get more traces just in case
but it looks reproductible):
 - two disks in raid1 profile
 - at some point I was lacking slotting space, took one disk out and
mounted just the other. I didn't take any special care so it was most
likely mounted rw, but I didn't write any data on it as I expected to
put the drives back together later.
 - put the disks back together, time passed and tons of data was
written...
 - this time I had to "sacrifice" a disk to a silly appliance which
wouldn't let me ssh into it without formatting a disk first, so I backed
up data as well as I could, did a full scrub and picked a disk of the
two to feed the monster.
The whole volume was also brought down during the operation (no
hotplug), so I didn't take any special care in separating the disks
e.g. didn't do anything like btrfs device remove...

That's done and I'd like to add the disk back to the raid1, but the
original volume can no longer be mounted read-write, so all disk
operations fail saying the volume is read-only.



dmesg, first mounting with -o degraded,ro
[ 3324.135037] BTRFS: device fsid c3f4826a-6936-445d-8bae-98233ddda48f devid 1 transid 22031 /dev/dm-1 scanned by systemd-udevd (4812)
[ 3340.207257] BTRFS info (device dm-1): allowing degraded mounts
[ 3340.207273] BTRFS info (device dm-1): using free space tree
[ 3340.207278] BTRFS info (device dm-1): has skinny extents
[ 3340.208125] BTRFS warning (device dm-1): devid 2 uuid 0bab0bad-2cd2-42f4-96e8-8dff89d44552 is missing
[ 3340.218286] BTRFS warning (device dm-1): devid 2 uuid 0bab0bad-2cd2-42f4-96e8-8dff89d44552 is missing
[ 3340.516655] BTRFS info (device dm-1): bdev /dev/mapper/data1 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1799

then mount -o remount,rw failing:
[ 3512.420569] BTRFS info (device dm-1): allowing degraded mounts
[ 3512.420615] BTRFS info (device dm-1): using free space tree
[ 3512.421180] BTRFS warning (device dm-1): chunk 3475900465152 missing 1 devices, max tolerance is 0 for writable mount
[ 3512.421189] BTRFS warning (device dm-1): too many missing devices, writable remount is not allowed
[ 3512.421206] BTRFS info (device dm-1): allowing degraded mounts
[ 3512.421218] BTRFS info (device dm-1): using free space tree


and `btrfs ins dump-tree -t chunk /dev/mapper/data1` does show that
chunk is indeed missing, from what I can see only these two are
(num_stripes 1):
	item 109 key (FIRST_CHUNK_TREE CHUNK_ITEM 3475900465152) itemoff 3995 itemsize 80
		length 1073741824 owner 2 stripe_len 65536 type METADATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 2 offset 1752381259776
			dev_uuid 0bab0bad-2cd2-42f4-96e8-8dff89d44552
	item 110 key (FIRST_CHUNK_TREE CHUNK_ITEM 3476974206976) itemoff 3915 itemsize 80
		length 33554432 owner 2 stripe_len 65536 type SYSTEM
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 2 offset 1271311368192
			dev_uuid 0bab0bad-2cd2-42f4-96e8-8dff89d44552

This can also be confirmed with btrfs fi df which prints a warning:
Data, RAID1: total=2.81TiB, used=2.81TiB
System, RAID1: total=32.00MiB, used=416.00KiB
System, single: total=32.00MiB, used=0.00B
Metadata, RAID1: total=4.00GiB, used=3.61GiB
Metadata, single: total=1.00GiB, used=0.00B
GlobalReserve, single: total=512.00MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Metadata: single, raid1
WARNING:   System: single, raid1



So my guess is that when I mounted the other disk a while ago, these two
chunks got created to accomodate e.g. atime updates or whatever it is
that it wanted to accomodate.

Later when I remounted both arrays I didn't notice there were single
extents in the pool, and scrub only checks that each extent is coherent
so didn't reveal any problem. Data later written with two disks
correctly got written as raid1, so in practice there is no problem with
any of the data and as far as I can see all files are readable and
intact.

If I had never put the disks back together or if when they were together
I had cleanly removed the disk first I suspect things would have worked
fine and the rebalance to single would have copied whatever there was to
copy from there just fine... But that doesn't really help me now!

As it mounts read-only fine I just created a new btrfs device and copied
data from it overnight, but while this was possible for me I think it's
worth addressing.




So, two questions:
 - first for my culture, is there a way to tell btrfs to ignore/remove
these chunks? "trust me there's no data I care about in there"? At which
point rw mount would probably work again.
I don't think anything automated can be done at this point.

 - for other people (read: future me), if like me they don't check btrfs
fi df output, would it make sense to be a bit more verbose about the
mixed profile and suggest running a rebalance?
Things were really working well when I put the two disks back together
so I think most people wouldn't notice it either, but I'm not sure what
to suggest... For all I know there could already have been warnings in
dmesg when I put the two disks back together before my check.


Thanks,
-- 
Dominique
