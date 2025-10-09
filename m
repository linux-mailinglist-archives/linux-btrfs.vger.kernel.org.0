Return-Path: <linux-btrfs+bounces-17597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF991BCA3D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEB8A4EEC68
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7E2264BA;
	Thu,  9 Oct 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPSP66ON"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BC2236EB
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028573; cv=none; b=bhrfnNtizpGD7PvvxFFPKdjGejQubFcw8gRetVyAP7+EqfDJZJD268G3Pn+AGJAMw9khDei59QFja1gvxdvohHwZnc7DLsBuXy5tm0Y1Eh0SC6CVceg/tmomgAv41PlN4wS/NQVLqaQ8y0H16dcu7vidbwOWQ+ODioiaIOV72QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028573; c=relaxed/simple;
	bh=gWApE3lnkKhd1XLBkdmg6oOEHLCxR46hbBx/6BZg0Ks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CvPkyZ3eNdhrcNZLZWMTaibkJ/sc9RcxkD6AtN1eVlQg60P2Pz0KYHhwVEZ7fiyd0sZ3WFzLCMJbhZGBsqOAmBnTqA6VhZOdjkwhfKmD7JUAwGalvPYFuBEHMkBJY2altQrq/edwsV3AaRd42oSPfBxo8Jv6KmKYS2wR65fOkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPSP66ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F43C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760028572;
	bh=gWApE3lnkKhd1XLBkdmg6oOEHLCxR46hbBx/6BZg0Ks=;
	h=From:To:Subject:Date:From;
	b=rPSP66ONKvn5upS4RlDhZLcTbCxdyfR9uZb9z1C5x7tHFvsTofNpyeTudk8+hiH1S
	 7xoJSgqi/Kuuu0Q3LQPdrWUKsey+756wPz0eGqoNjqllJR0O2Y94vbVGlFYexoA3eS
	 6OZH4ewIzCTpndq853mND3ikdmCirvzTfh6KgfLS+EH9osZksZwWfERz9JGNR/2MXk
	 S3kSizj8UXJ5fZlPU+7EnRYLvViT9/uEyTq8dntZTybGOL+mFnv622LrSg3UW3ukD8
	 xfCjAoaLKJN8j4Mm169RpYdNyVMI3QX9CbCAAlysXvIpai/upxbJlqGfdO6Vfeu3gR
	 QSTVqwsGAPW6Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: stop checking for csums past i_size
Date: Thu,  9 Oct 2025 17:49:27 +0100
Message-ID: <6e3df8da61ea11e45809208e3795452c5291f467.1760028487.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While running test case btrfs/192 from fstests on a kernel with support for
large folios (needs CONFIG_BTRFS_EXPERIMENTAL=y kernel configuration at the
moment) I ended up getting very sporadic btrfs check failures reporting
that csum items were missing. Looking into the issue it turned out that we
end up looking for csum items of a file extent item with a range that spans
beyond the i_size of a file and we don't have any, because the kernel's
writeback code skips submitting bios for ranges beyond eof.

Example output when this happens:

  $ btrfs check /dev/sdc
  Opening filesystem to check...
  Checking filesystem on /dev/sdc
  UUID: 69642c61-5efb-4367-aa31-cdfd4067f713
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  [3/8] checking extents
  [4/8] checking free space tree
  [5/8] checking fs roots
  root 5 inode 332 errors 1000, some csum missing
  ERROR: errors found in fs roots
  (...)

Looking at a tree dump of the fs tree (root 5) for inode 332 we have:

   $ btrfs inspect-internal dump-tree -t 5 /dev/sdc
   (...)
        item 28 key (332 INODE_ITEM 0) itemoff 2006 itemsize 160
                generation 17 transid 19 size 610969 nbytes 86016
                block group 0 mode 100666 links 1 uid 0 gid 0 rdev 0
                sequence 11 flags 0x0(none)
                atime 1759851068.391327881 (2025-10-07 16:31:08)
                ctime 1759851068.410098267 (2025-10-07 16:31:08)
                mtime 1759851068.410098267 (2025-10-07 16:31:08)
                otime 1759851068.391327881 (2025-10-07 16:31:08)
        item 29 key (332 INODE_REF 340) itemoff 1993 itemsize 13
                index 2 namelen 3 name: f1f
        item 30 key (332 EXTENT_DATA 589824) itemoff 1940 itemsize 53
                generation 19 type 1 (regular)
                extent data disk byte 21745664 nr 65536
                extent data offset 0 nr 65536 ram 65536
                extent compression 0 (none)
   (...)

We can see that the file extent item for file offset 589824 has a length of
64K and its number of bytes is 64K. Looking at the inode item we see that
its i_size is 610969 bytes which falls within the range of that file extent
item [589824, 655360[.

Looking into the csum tree:

  $ btrfs inspect-internal dump-tree /dev/sdc
  (...)
        item 15 key (EXTENT_CSUM EXTENT_CSUM 21565440) itemoff 991 itemsize 200
                range start 21565440 end 21770240 length 204800
           item 16 key (EXTENT_CSUM EXTENT_CSUM 1104576512) itemoff 983 itemsize 8
                range start 1104576512 end 1104584704 length 8192
  (..)

We see that the csum item number 15 covers the first 24K of the file extent
item - it ends at offset 21770240 and the extent's disk_bytenr is 21745664,
so we have:

   21770240 - 21745664 = 24K

We see that the next csum item (number 16) is completely outside the range,
so the remaining 40K of the extent doesn't have csum items in the tree.

If we round up the i_size to the sector size, we get:

   round_up(610969, 4096) = 614400

If we subtract from that the file offset for the extent item we get:

   614400 - 589824 = 24K

So the missing 40K corresponds to the end of the file extent item's range
minus the rounded up i_size:

   655360 - 614400 = 40K

Normally we don't expect a file extent item to span over the rounded up
i_size of an inode, since when truncating, doing hole punching and other
operations that trim a file extent item, the number of bytes is adjusted.

There is however a short time window where the kernel can end up,
temporarily,persisting an inode with an i_size that falls in the middle of
the last file extent item and the file extent item was not yet trimmed (its
number of bytes reduced so that it doesn't cross i_size rounded up by the
sector size).

The steps (in the kernel) that lead to such scenario are the following:

 1) We have inode I as an empty file, no allocated extents, i_size is 0;

 2) A buffered write is done for file range [589824, 655360[ (length of
    64K) and the i_size is updated to 655360. Note that we got a single
    large folio for the range (64K);

 3) A truncate operation starts that reduces the inode's i_size down to
    610969 bytes. The truncate sets the inode's new i_size at
    btrfs_setsize() by calling truncate_setsize() and before calling
    btrfs_truncate();

 4) At btrfs_truncate() we trigger writeback for the range starting at
    610304 (which is the new i_size rounded down to the sector size) and
    ending at (u64)-1;

 5) During the writeback, at extent_write_cache_pages(), we get from the
    call to filemap_get_folios_tag(), the 64K folio that starts at file
    offset 589824 since it contains the start offset of the writeback
    range (610304);

 6) At writepage_delalloc() we find the whole range of the folio is dirty
    and therefore we run delalloc for that 64K range ([589824, 655360[),
    reserving a 64K extent, creating an ordered extent, etc;

 7) At extent_writepage_io() we submit IO only for subrange [589824, 614400[
    because the inode's i_size is 610969 bytes (rounded up by sector size
    is 614400). There, in the while loop we intentionally skip IO beyond
    i_size to avoid any unnecessay work and just call
    btrfs_mark_ordered_io_finished() for the range [614400, 655360[ (which
    has a 40K length);

 8) Once the IO finishes we finish the ordered extent by ending up at
    btrfs_finish_one_ordered(), join transaction N, insert a file extent
    item in the inode's subvolume tree for file offset 589824 with a number
    of bytes of 64K, and update the inode's delayed inode item or directly
    the inode item with a call to btrfs_update_inode_fallback(), which
    results in storing the new i_size of 610969 bytes;

 9) Transaction N is committed either by the transaction kthread or some
    other task committed it (in response to a sync or fsync for example).

    At this point we have inode I persisted with an i_size of 610969 bytes
    and file extent item that starts at file offset 589824 and has a number
    of bytes of 64K, ending at an offset of 655360 which is beyond the
    i_size rounded up to the sector size (614400).

    --> So after a crash or power failure here, the btrfs check program
        reports that error about missing checksum items for this inode, as
	it tries to lookup for checksums covering the whole range of the
	extent;

10) Only after transaction N is commited that at btrfs_truncate() the call
    to btrfs_start_transaction() starts a new transaction, N + 1, instead
    of joining transaction N. And it's with transaction N + 1 that it calls
    btrfs_truncate_inode_items() which updates the file extent item at file
    offset 589824 to reduce its number of bytes from 64K down to 24K, so
    that the file extent item's range ends at the i_size rounded up to the
    sector size - 614400 bytes.

So fix this by skipping the search of csum items beyond the sector that
contains a file's i_size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 check/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/check/main.c b/check/main.c
index 49a6ad25..f4a135c1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1774,6 +1774,19 @@ static int process_file_extent(struct btrfs_root *root,
 		else
 			disk_bytenr += extent_offset;
 
+		/*
+		 * A truncate, reducing a file's size, can temporarily leave an
+		 * inode with the new i_size falling somewhere in the middle of
+		 * the last file extent item without having any csum items for
+		 * blocks past the new i_size (rounded up to the i_size). This
+		 * happens when the new i_size falls in the middle of a delalloc
+		 * range and that file range does not have yet any allocated
+		 * extents. So make sure we don't search for csum items beyond
+		 * the i_size.
+		 */
+		if (key->offset + num_bytes > rec->isize)
+			num_bytes = round_up(rec->isize, gfs_info->sectorsize) - key->offset;
+
 		ret = count_csum_range(disk_bytenr, num_bytes, &found);
 		if (ret < 0)
 			return ret;
-- 
2.47.2


