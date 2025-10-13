Return-Path: <linux-btrfs+bounces-17699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98DBD2E71
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 517824F1458
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9426D4EB;
	Mon, 13 Oct 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDxy633e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B826CE37
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357137; cv=none; b=N3Wm15dqNhjmQAUHP8bXFwAsxNl4Lojs440Jf4X6GUzNgvXoY7FYMtyrIfYs+6cKkszqOl8ljVPWDVVI5PABBfuEJiuLXToBxDoikFAQcBgh4v4b3p1b9GF/NCjHHz9uFFndKccMFGBsH8tYdpLcAA9DXtO3SoZOBZ/aie8E4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357137; c=relaxed/simple;
	bh=S47qZah71JEVZM9VwD6mH0rRq10/QmCO0aWyoIagSbY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsyOw4eD+CbnPzm/e+Z34j6s7NbxBodGddYKXwdocIHXoNA/2wBuzi0QSusroRyfGYBnwpKGDgmg9UmaH0iTU8phERMcKMupGs7DTEjuQFePoLGsoLsFyn3DlkXNxKCdx2VmZLPBtoVrG3yuaNO+jSRfPyIeP1gDTzmckxdA2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDxy633e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1DCC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357137;
	bh=S47qZah71JEVZM9VwD6mH0rRq10/QmCO0aWyoIagSbY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MDxy633enIDGUTeq0ekBcJzlQR/7jAf2qbG1jqfkT9Xn34NW2xpE0Jtmt1qTyTJ6V
	 f+3fJTJoNRNejwZYRXbJtSV6BSeIzfTFAq2ja7xXh9tDxa3+yVa6TlUQXdqtO7w65i
	 lrK1uVJMTeSOXFkxQ9SJoBWVQMHv2rI3o/ikX1tqwWVjvrPmAih6uEKKQHOztL0gQ0
	 k+CwmOwdHbqHkol5H2ieYJwaZ01UaGAq1M0QhlASfyj60lzYexb6U9fkHWWSFlHpPe
	 VHXFLGbPc8Gb/Npovckvt4NGRK0M0QL9Lm2xYTq+CBGdYBmz3Iex6i90+f1bDB7jcR
	 ABTmIZqhwQ42Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: truncate ordered extent when skipping writeback past i_size
Date: Mon, 13 Oct 2025 13:05:26 +0100
Message-ID: <f3a857b481cdfda08d13e1eba5db53d17c5e774d.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While running test case btrfs/192 from fstests with support for large
folios (needs CONFIG_BTRFS_EXPERIMENTAL=y) I ended up getting very sporadic
btrfs check failures reporting that csum items were missing. Looking into
the issue it turned out that btrfs check searches for csum items of a file
extent item with a range that spans beyond the i_size of a file and we
don't have any, because the kernel's writeback code skips submitting bios
for ranges beyond eof. It's not expected however to find a file extent item
that crosses the rounded up (by the sector size) i_size value, but there is
a short time window where we can end up with a transaction commit leaving
this small inconsistency between the i_size and the last file extent item.

Example btrfs check output when this happens:

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

10) Only after transaction N is committed that at btrfs_truncate() the
    call to btrfs_start_transaction() starts a new transaction, N + 1,
    instead of joining transaction N. And it's with transaction N + 1 that
    it calls btrfs_truncate_inode_items() which updates the file extent
    item at file offset 589824 to reduce its number of bytes from 64K down
    to 24K, so that the file extent item's range ends at the i_size
    rounded up to the sector size (614400 bytes).

Fix this by truncating the ordered extent at extent_writepage_io() when we
skip writeback because the current offset in the folio is beyond i_size.
This ensures we don't ever persist a file extent item with a number of
bytes beyond the rounded up (by sector size) value of the i_size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c    | 21 +++++++++++++++++++--
 fs/btrfs/ordered-data.c |  5 +++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3a8681566fc5..67706c1efa88 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1691,13 +1691,13 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	bool submitted_io = false;
 	int found_error = 0;
 	const u64 folio_start = folio_pos(folio);
+	const u64 folio_end = folio_start + folio_size(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	u64 cur;
 	int bit;
 	int ret = 0;
 
-	ASSERT(start >= folio_start &&
-	       start + len <= folio_start + folio_size(folio));
+	ASSERT(start >= folio_start && start + len <= folio_end);
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret == -EAGAIN) {
@@ -1724,6 +1724,23 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
+			struct btrfs_ordered_extent *ordered;
+			unsigned long flags;
+
+			ordered = btrfs_lookup_first_ordered_range(inode, cur,
+								   folio_end - cur);
+			/*
+			 * We have just run delalloc before getting here, so
+			 * there must be an ordered extent.
+			 */
+			ASSERT(ordered != NULL);
+			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+			ordered->truncated_len = min(ordered->truncated_len,
+						     cur - ordered->file_offset);
+			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+			btrfs_put_ordered_extent(ordered);
+
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
 						       start + len - cur, true);
 			/*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2829f20d7bb5..8a8aa6ed405b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1098,8 +1098,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	struct rb_node *prev;
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
+	unsigned long flags;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
 	node = inode->ordered_tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
@@ -1154,7 +1155,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
 	}
 
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 	return entry;
 }
 
-- 
2.47.2


