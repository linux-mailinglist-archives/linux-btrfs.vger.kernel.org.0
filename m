Return-Path: <linux-btrfs+bounces-9011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A59A5202
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 04:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A23B283B6C
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96333EC;
	Sun, 20 Oct 2024 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WXfhZf6C";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WXfhZf6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954B376
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729392247; cv=none; b=garInBWprEdsm0cUZBjG38dNX7T16OCTe/73o6P8YNrhltUnHj6zWh4q8DxsbJ7Vjn7GKWymR3RXtOEshxKMGrnMlTT9ps/OAg6L9ZTGTouxemwnGxh5CsTQiFLMJfYcUbeXZ7Vd/tZ2fLnhQ8O30aGfvAQYsf6B/mXjovImex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729392247; c=relaxed/simple;
	bh=DqkzZBbVXags6Ax3iGHX/TMwvlKAhjk89ZdxHW2hpx4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UdUXf5xzjGE2Vc42lfqdBGm1cDd3P7VsLOkHc+V/nU22ZqebBhdABk4nJspYoKdqtZNwWOGqhK4rjgO/+QVyn0q+eVmc+0zCS4UfmjSC+NhyoPHUV21J09v8yyIUmGTzTuNt7hvLOwjmbFGLAlrz51WNPkg2LXGkYOqWJ/jlObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WXfhZf6C; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WXfhZf6C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 328CA21C25
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 02:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729392236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HLICNaS0yW0uzBX1GQxBCyrrt8jVVFcnwAwgMHquL/Y=;
	b=WXfhZf6CIE3/ann1UNDRgZFTj4KVJVyekWdiBDq5I8cHu6PVsJexSkS+SSimRkt6S8R1dF
	XpZv215VHmpFQOp9Xb7UT5suHWjyw4Wwl7RaIzxZs3rLxD5MDUwlQFrBuGvhdqxEBimmis
	kLwvmfM7jBqOSvM2A+UJiDw46WoVz4E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WXfhZf6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729392236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HLICNaS0yW0uzBX1GQxBCyrrt8jVVFcnwAwgMHquL/Y=;
	b=WXfhZf6CIE3/ann1UNDRgZFTj4KVJVyekWdiBDq5I8cHu6PVsJexSkS+SSimRkt6S8R1dF
	XpZv215VHmpFQOp9Xb7UT5suHWjyw4Wwl7RaIzxZs3rLxD5MDUwlQFrBuGvhdqxEBimmis
	kLwvmfM7jBqOSvM2A+UJiDw46WoVz4E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64ED2136DC
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 02:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7mPCWtuFGcJPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 02:43:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid deadlock when reading a partial uptodate folio
Date: Sun, 20 Oct 2024 13:13:37 +1030
Message-ID: <68342f70406107c376dc8e3b1a6cd67a7e9a6b3e.1729392197.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 328CA21C25
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
If the sector size is smaller than page size, and we allow btrfs to
avoid reading the full page as long as the buffered write range is
sector aligned, we can hit a hang with generic/095 runs:

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

[CAUSE]
The above call trace shows that, during the folio read a writeback is
triggered on the same folio.
And since during btrfs_do_readpage(), the folio is locked, the writeback
will never be able to get the folio, thus it is waiting on itself thus
causing the deadlock.

The root cause is a little complex, the system is 64K page sized, with
4K sector size:

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

3) Direct IO tries to drop the folio
   Since there is no locked extent map, btrfs allows the folio to be
   released. Now no sector in the folio has uptodate flag.
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
   For the range [0, 16), since it's already uptodate, btrfs skip this
   range.
   For the range [16K, 48K), btrfs submit the read from disk.

   The problem comes to the range [48K, 64K), the following call chain
   happens:

   btrfs_do_readpage()
   \- __get_extent_map()
    \- btrfs_lock_and_flush_ordered_range()
     \- btrfs_start_ordered_extent()
      \- filemap_fdatawrite_range()

   Since the folio indeed has dirty sectors in range [0, 16K), the range
   will be written back.

   But the folio is already locked by the folio read, the writeback
   will never be able to lock the folio, thus lead to the deadlock.

This sequence can only happen if all the following conditions are met:

- The sector size is smaller than page size
  Or we won't have mixed dirty blocks in the same folio we're reading.

- We allow the buffered write to skip the folio read if it's sector
  aligned
  This is the incoming new optimization for sector size < page size to
  pass generic/563.

  Or the folio will be fully read from the disk, before marking it
  dirty.
  Thus will not trigger the deadlock.

[FIX]
- Only lookup for the extent map of the next sector to read
  To avoid touching ranges that can be skipped by per-sector uptodate
  flag.

- Break the step 5) of the above case
  By passing an optional @locked_folio into btrfs_start_ordered_extent()
  and btrfs_lock_and_flush_ordered_range().
  If we got such locked folio, do extra asserts to make sure the target
  range is already not dirty, then skip writeback for ranges of that
  folio.

  So far only the call site inside __get_extent_map() is passing the new
  parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
RFC->v1:
- Go with extra @locked_folio parameter for btrfs_start_ordered_extent()
  This is more straightforward compared to skipping folio releasing.
  This also solves some painful slowdown of other test cases.
---
 fs/btrfs/defrag.c       |  2 +-
 fs/btrfs/direct-io.c    |  2 +-
 fs/btrfs/extent_io.c    |  5 +--
 fs/btrfs/file.c         |  8 ++---
 fs/btrfs/inode.c        |  6 ++--
 fs/btrfs/ordered-data.c | 69 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/ordered-data.h |  8 +++--
 7 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 1644470b9df7..2467990d6ac7 100644
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
index a7c3e221378d..2fb02aa19be0 100644
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
index 7680dd94fddf..765ec965b882 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -922,7 +922,8 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 		*em_cached = NULL;
 	}
 
-	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start + len - 1, &cached_state);
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), folio, start,
+					   start + len - 1, &cached_state);
 	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
@@ -986,7 +987,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, blocksize);
 			continue;
 		}
-		em = __get_extent_map(inode, folio, cur, end - cur + 1,
+		em = __get_extent_map(inode, folio, cur, blocksize,
 				      em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 676eddc9daaf..7521fbefa9fd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -987,7 +987,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 				      cached_state);
 			folio_unlock(folio);
 			folio_put(folio);
-			btrfs_start_ordered_extent(ordered);
+			btrfs_start_ordered_extent(ordered, NULL);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
@@ -1055,8 +1055,8 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			return -EAGAIN;
 		}
 	} else {
-		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend,
-						   &cached_state);
+		btrfs_lock_and_flush_ordered_range(inode, NULL, lockstart,
+						   lockend, &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			       NULL, nowait, false);
@@ -1895,7 +1895,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a21701571cbb..56bd33cf864b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2773,7 +2773,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
 		folio_unlock(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4783,7 +4783,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		folio_unlock(folio);
 		folio_put(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4918,7 +4918,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	if (size <= hole_start)
 		return 0;
 
-	btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end - 1,
+	btrfs_lock_and_flush_ordered_range(inode, NULL, hole_start, block_end - 1,
 					   &cached_state);
 	cur_offset = hole_start;
 	while (1) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2104d60c2161..29434fab8a06 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 
 	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
-	btrfs_start_ordered_extent(ordered);
+	btrfs_start_ordered_extent(ordered, NULL);
 	complete(&ordered->completion);
 }
 
@@ -845,12 +845,16 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
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
+	u64 skip_start;
+	u64 skip_end;
 	bool freespace_inode;
+	bool skip_writeback = false;
 
 	trace_btrfs_ordered_extent_start(inode, entry);
 
@@ -860,13 +864,59 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
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
+		skip_start = max_t(u64, folio_pos(locked_folio), start);
+		skip_end = min_t(u64,
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
+		 * The range must not be dirty.  The range can be submitted (writeback)
+		 * or submitted and finished, then the whole folio released (no flag).
+		 *
+		 * If the folio range is dirty, we will deadlock since the OE will never
+		 * be able to finish.
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
+		if (!skip_writeback)
+			filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
+		else {
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
@@ -921,7 +971,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, NULL);
 		end = ordered->file_offset;
 		/*
 		 * If the ordered extent had an error save the error but don't
@@ -1141,6 +1191,8 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
  * @inode:        Inode whose ordered tree is to be searched
  * @start:        Beginning of range to flush
  * @end:          Last byte of range to lock
+ * @locked_folio: If passed, will not start writeback to avoid locking the same
+ *		  folio already locked by the caller.
  * @cached_state: If passed, will return the extent state responsible for the
  *                locked range. It's the caller's responsibility to free the
  *                cached state.
@@ -1148,8 +1200,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
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
@@ -1174,7 +1227,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
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
2.47.0


