Return-Path: <linux-btrfs+bounces-10965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A00A10356
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 10:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCFB1615D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120628EC81;
	Tue, 14 Jan 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OmVz2Eiz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OmVz2Eiz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75580240229
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848382; cv=none; b=ibQVHWwNaLCvtldqa6RZ+1R6Pu6ysz1G6aMrbwu8Z+eHReZJMAYGW7T7iKQs2YHUcA6+n+WY+OKPHAUXv1fPaImXsDH/2hH+3BBeiI5RlMeImY16hziayQMCz+znSpHwQPfh96Tnk7ecWdI8NwOPaZUqHaWmrgiUN+0Foj1GnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848382; c=relaxed/simple;
	bh=1FuB5ZQFEis93+umkATt40zPhbImRwixo7o9BEps4Tc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvQhRRmDcoJA+GYDdWyPS3uXzG8z9vum1eDvvZPFo7taYCfs2bOoJ3p7BU69PZ3Gq2Mm6+ICP6zy5JZ3yLDdJ3fu4agIdXFjFoXI+89KWPNOWaervH5FF+l6qkruBBKzecaGKSDRqHqwjiuJgHvZmviyxa4Ahnp2NVCJWuKqEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OmVz2Eiz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OmVz2Eiz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB6D01F441
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ26LVDyb9Y3Btq6jYapHc5hBl///FrdN82qIU7E1rY=;
	b=OmVz2EizQEdWo49qXGV8Q1lEnf+T1PIBJSX/G3tN7k5+wVLpvJD+GnbfnDEh5pOnPJjN/X
	l8sx+XlMlhl8QEP/cOOfOix/QVjFpnlvVOuIMohcSX47tfP+mqz8H3dsecTEyXmLvuJp0C
	/OaYgzChEpyeMarD9PdfBzIjQl4nvVc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ26LVDyb9Y3Btq6jYapHc5hBl///FrdN82qIU7E1rY=;
	b=OmVz2EizQEdWo49qXGV8Q1lEnf+T1PIBJSX/G3tN7k5+wVLpvJD+GnbfnDEh5pOnPJjN/X
	l8sx+XlMlhl8QEP/cOOfOix/QVjFpnlvVOuIMohcSX47tfP+mqz8H3dsecTEyXmLvuJp0C
	/OaYgzChEpyeMarD9PdfBzIjQl4nvVc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBAA0139CB
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DwcJ/kzhmeMAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: avoid deadlock when reading a partial uptodate folio
Date: Tue, 14 Jan 2025 20:22:28 +1030
Message-ID: <1d230d53e92c4f4a7ea4ce036f226b8daa16e5ae.1736848277.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <cover.1736848277.git.wqu@suse.com>
References: <cover.1736848277.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
This is for a deadlock only possible after the out-of-tree patch
"btrfs: allow buffered write to skip full page if it's block aligned".

For now it's impossible to hit the deadlock, the reason will be
explained in [CAUSE] section.

If the block size (sector size) is smaller than page size, and we allow
btrfs to avoid reading the full page because the buffered write range is
block aligned, we can hit a hang with generic/095 runs:

  __switch_to+0xf8/0x168
  __schedule+0x328/0x8a8
  schedule+0x54/0x140
  io_schedule+0x44/0x68
  folio_wait_bit_common+0x198/0x3f8
  __folio_lock+0x24/0x40
  extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
  btrfs_writepages+0x94/0x158 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  __filemap_fdatawrite_range+0x6c/0xa8
  filemap_fdatawrite_range+0x1c/0x30
  btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
  btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
  __get_extent_map+0xa0/0x220 [btrfs]
  btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
  btrfs_read_folio+0x50/0xa0 [btrfs]
  filemap_read_folio+0x54/0x110
  filemap_update_page+0x2e0/0x3b8
  filemap_get_pages+0x228/0x4d8
  filemap_read+0x11c/0x3b8
  btrfs_file_read_iter+0x74/0x90 [btrfs]
  new_sync_read+0xd0/0x1d0
  vfs_read+0x1a0/0x1f0

There is also the minimal fio reproducer extracted from that test case
to reproduce the deadlock:

  [global]
  bs=8k
  iodepth=1
  randrepeat=1
  size=256k
  directory=$mnt
  numjobs=1
  [job1]
  ioengine=sync
  bs=512
  direct=1
  rw=randread
  filename=file1
  [job2]
  ioengine=libaio
  rw=randwrite
  direct=1
  filename=file1
  [job3]
  ioengine=posixaio
  rw=randwrite
  filename=file1

[CAUSE]
The above call trace shows that, during the folio read a writeback is
triggered on the same folio, from the read path.
And since during btrfs_do_readpage(), the folio is locked, the writeback
will never be able to lock the folio, thus it is waiting on itself thus
causing the deadlock.

The root cause is a little complex, assume the system is 64K page sized,
with 4K sector size:

1) The folio has its range [48K, 64K) marked dirty by buffered write

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- sector Uptodate|Dirty

2) Writeback finished for [48K, 64K), but ordered extent not yet finished

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- sector Uptodate
					        extent map PINNED
						OE still here

3) The folio is released from page cache
   This can be triggered by direct IO through the following call chain:

   iomap_dio_rw()
   \- kiocb_invalidate_pages()
    \- filemap_invalidate_pages()
     \- invalidate_inode_pages2_range()
      \- invalidate_complete_folio2()
       \- filemap_release_folio()
        \- btrfs_release_folio()
	 \- __btrfs_release_folio()
	  \- try_release_extent_mapping()

   Since there is no extent state with EXTENT_LOCKED flag in the folio
   range, btrfs allows the folio to be released.
   Now there is no folio->private to record which block is uptodate.
   But extent map and OE are still here.

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- extent map PINNED
						OE still here

4) Buffered write dirtied range [0, 16K)
   Since it's sector aligned, btrfs didn't read the full folio from disk.

   0          16K         32K          48K         64K
   |//////////|                        |///////////|
       \- sector Uptodate|Dirty              \- extent map PINNED
						OE still here

5) Read on the folio is triggered
   For the range [0, 16K), since it's already uptodate, btrfs skips this
   range.
   For the range [16K, 48K), btrfs submit the read.

   The problem comes to the range [48K, 64K), the following call chain
   happens:

   btrfs_do_readpage()
   \- __get_extent_map()
    \- btrfs_lock_and_flush_ordered_range()
     \- btrfs_start_ordered_extent()
      \- filemap_fdatawrite_range()
       \- btrfs_writepages()
        \- extent_write_cache_pages()
	 \- folio_lock()

   Since the folio indeed has dirty blocks in range [0, 16K), the range
   will be written back.

   But the folio is already locked by the folio read path, the writeback
   will never be able to lock the folio, thus lead to the deadlock.

This sequence can only happen if all the following conditions are met:

- The block size is smaller than page size.
  Or we won't have mixed dirty blocks in the same folio we're reading.

- We allow the buffered write to skip the folio read if it's block
  aligned.
  This is done by the incoming patch
  "btrfs: allow buffered write to skip full page if it's block aligned".

  The ultimate goal of that patch is to reduce unnecessary read for block
  size < page size cases, and to pass generic/563.

  Otherwise the folio will be read from the disk during buffered write,
  before marking it dirty.
  Thus will not trigger the deadlock.

[FIX]
Break the step 5) of the above case.

By passing an optional @locked_folio into btrfs_start_ordered_extent()
and btrfs_lock_and_flush_ordered_range().
If we got such locked folio skip the writeback for ranges of that folio.

Here we also do extra asserts to make sure the target
range is already not dirty, or the ordered extent we wait will never be
able to finish, since part of the ordered extent is never submitted.

So far only the call site inside __get_extent_map() is passing the new
parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c       |  2 +-
 fs/btrfs/direct-io.c    |  2 +-
 fs/btrfs/extent_io.c    |  3 +-
 fs/btrfs/file.c         |  8 ++---
 fs/btrfs/inode.c        |  6 ++--
 fs/btrfs/ordered-data.c | 67 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/ordered-data.h |  8 +++--
 7 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae953948..db51a2dc5338 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 			break;
 
 		folio_unlock(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		folio_lock(folio);
 		/*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 8567af46e16f..c99ceabcd792 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 */
 			if (writing ||
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
-				btrfs_start_ordered_extent(ordered);
+				btrfs_start_ordered_extent(ordered, NULL);
 			else
 				ret = nowait ? -EAGAIN : -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da7e8734ee57..c0ac742a04b8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -915,7 +915,8 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 		*em_cached = NULL;
 	}
 
-	btrfs_lock_and_flush_ordered_range(inode, start, start + len - 1, &cached_state);
+	btrfs_lock_and_flush_ordered_range(inode, folio,
+					   start, start + len - 1, &cached_state);
 	em = btrfs_get_extent(inode, folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36f51c311bb1..176815585ba5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -943,7 +943,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 				      cached_state);
 			folio_unlock(folio);
 			folio_put(folio);
-			btrfs_start_ordered_extent(ordered);
+			btrfs_start_ordered_extent(ordered, NULL);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
@@ -1011,8 +1011,8 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			return -EAGAIN;
 		}
 	} else {
-		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend,
-						   &cached_state);
+		btrfs_lock_and_flush_ordered_range(inode, NULL, lockstart,
+						   lockend, &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			       NULL, nowait);
@@ -1847,7 +1847,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e8b08412d35..5b3fdba10245 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2831,7 +2831,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
 		folio_unlock(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4885,7 +4885,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		folio_unlock(folio);
 		folio_put(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -5020,7 +5020,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	if (size <= hole_start)
 		return 0;
 
-	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
+	btrfs_lock_and_flush_ordered_range(inode, NULL, hole_start, block_end - 1,
 					   &cached_state);
 	cur_offset = hole_start;
 	while (1) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 30eceaf829a7..be8eef282da0 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 
 	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
-	btrfs_start_ordered_extent(ordered);
+	btrfs_start_ordered_extent(ordered, NULL);
 	complete(&ordered->completion);
 }
 
@@ -845,12 +845,14 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
  * Wait on page writeback for all the pages in the extent and the IO completion
  * code to insert metadata into the btree corresponding to the extent.
  */
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
+				struct folio *locked_folio)
 {
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
 	struct btrfs_inode *inode = entry->inode;
 	bool freespace_inode;
+	bool skip_writeback = false;
 
 	trace_btrfs_ordered_extent_start(inode, entry);
 
@@ -860,13 +862,59 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
 	 */
 	freespace_inode = btrfs_is_free_space_inode(inode);
 
+	/*
+	 * The locked folio covers the ordered extent range and the full
+	 * folio is dirty.
+	 * We can not trigger writeback on it, as we will try to lock
+	 * the same folio we already hold.
+	 *
+	 * This only happens for sector size < page size case, and even
+	 * that happens we're still safe because this can only happen
+	 * when the range is submitted and finished, but OE is not yet
+	 * finished.
+	 */
+	if (locked_folio) {
+		const u64 skip_start = max_t(u64, folio_pos(locked_folio), start);
+		const u64 skip_end = min_t(u64,
+				folio_pos(locked_folio) + folio_size(locked_folio),
+				end + 1) - 1;
+
+		ASSERT(folio_test_locked(locked_folio));
+
+		/* The folio should intersect with the OE range. */
+		ASSERT(folio_pos(locked_folio) <= end ||
+		       folio_pos(locked_folio) + folio_size(locked_folio) > start);
+
+		/*
+		 * The range must not be dirty.
+		 *
+		 * Since we will skip writeback for the folio, if the involved range
+		 * is dirty the range will never be submitted, thus the ordered
+		 * extent we are going to wait will never finish, cause another deadlock.
+		 */
+		btrfs_folio_assert_not_dirty(inode->root->fs_info, locked_folio,
+					     skip_start, skip_end  + 1 - skip_start);
+		skip_writeback = true;
+	}
 	/*
 	 * pages in the range can be dirty, clean or writeback.  We
 	 * start IO on any dirty ones so the wait doesn't stall waiting
 	 * for the flusher thread to find them
 	 */
-	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
-		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
+	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
+		if (!skip_writeback) {
+			filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
+		} else {
+			/* Need to skip the locked folio range. */
+			if (start < folio_pos(locked_folio))
+				filemap_fdatawrite_range(inode->vfs_inode.i_mapping,
+						start, folio_pos(locked_folio) - 1);
+			if (end + 1 > folio_pos(locked_folio) + folio_size(locked_folio))
+				filemap_fdatawrite_range(inode->vfs_inode.i_mapping,
+						folio_pos(locked_folio) + folio_size(locked_folio),
+						end);
+		}
+	}
 
 	if (!freespace_inode)
 		btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent);
@@ -921,7 +969,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		end = ordered->file_offset;
 		/*
 		 * If the ordered extent had an error save the error but don't
@@ -1141,6 +1189,8 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
  * @inode:        Inode whose ordered tree is to be searched
  * @start:        Beginning of range to flush
  * @end:          Last byte of range to lock
+ * @locked_folio: If passed, will not start writeback of this folio, to avoid
+ *		  locking the same folio already locked by the caller.
  * @cached_state: If passed, will return the extent state responsible for the
  *                locked range. It's the caller's responsibility to free the
  *                cached state.
@@ -1148,8 +1198,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
  * Always return with the given range locked, ensuring after it's called no
  * order extent can be pending.
  */
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
-					u64 end,
+void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
+					struct folio *locked_folio,
+					u64 start, u64 end,
 					struct extent_state **cached_state)
 {
 	struct btrfs_ordered_extent *ordered;
@@ -1174,7 +1225,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 			break;
 		}
 		unlock_extent(&inode->io_tree, start, end, cachedp);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, locked_folio);
 		btrfs_put_ordered_extent(ordered);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4e152736d06c..a4bb24572c73 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -191,7 +191,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
+				struct folio *locked_folio);
 int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
@@ -207,8 +208,9 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const struct btrfs_block_group *bg);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const struct btrfs_block_group *bg);
-void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
-					u64 end,
+void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
+					struct folio *locked_folio,
+					u64 start, u64 end,
 					struct extent_state **cached_state);
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
-- 
2.48.0


