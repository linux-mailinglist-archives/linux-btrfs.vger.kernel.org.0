Return-Path: <linux-btrfs+bounces-11723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A1A41251
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0A01892AAB
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D711FC0E3;
	Sun, 23 Feb 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tnk2KOvX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tnk2KOvX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6E2054FD
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354414; cv=none; b=H5PVdPQLptFhguD9TeALKgjdW/I4d21TDzewpY8VD4nVHRU1fzGAPsoVt2wqyue2V0SzDkOusqdrtz52SF5cJCzWYU0V7jdu9quxfVmF3GW8IEUgvOZnAvGOh1M1k4WqSvz04yeMaMDKNrcVBTWo8+wbJFVGsMYHgxcsyZvDvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354414; c=relaxed/simple;
	bh=nXIVy55cwJFuS9Fxni81Rby/hoUQxMgWxpNQrCM9BF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjqLoD9ohK3ByEFE2KPjcuCq2bPSODeNXXudyabhQ8gAbzRzrnyP3MfZ2mgDYMT28+6ZRu55jGSIakcZqflc5BOjUg48DvNfNQkdyFIfI++a3KeuA8wfxb4krd4LCtTlzGlWoradvC7ZA3BzLl7cLfOenif/vEWDiO+5fBrIH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tnk2KOvX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tnk2KOvX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 285F81F385
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxun1I+xww0GQUB5Klak+BBzxb2RUkEzrieBl7nOLgw=;
	b=tnk2KOvXnZMR3M15/HiINPQO8dI8E7lR9yHp7q0+StwXP7pLZMP4Wsv99wI7Xd3VTI5Se6
	RW6tyTaLkaWgJ3ffKhKFvIbwaPs/JyUihZ7IbQnh/KI6RcP7AAj0AwdBBOD011qCdHBwjj
	k6a+hNY/QrlMLtSIFPxsBxnAvJylono=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxun1I+xww0GQUB5Klak+BBzxb2RUkEzrieBl7nOLgw=;
	b=tnk2KOvXnZMR3M15/HiINPQO8dI8E7lR9yHp7q0+StwXP7pLZMP4Wsv99wI7Xd3VTI5Se6
	RW6tyTaLkaWgJ3ffKhKFvIbwaPs/JyUihZ7IbQnh/KI6RcP7AAj0AwdBBOD011qCdHBwjj
	k6a+hNY/QrlMLtSIFPxsBxnAvJylono=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AE9313A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Fn/BmSzu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock helper
Date: Mon, 24 Feb 2025 10:16:18 +1030
Message-ID: <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently we're using btrfs_lock_and_flush_ordered_range() for both
btrfs_read_folio() and btrfs_readahead(), but it has one critical
problem for future subpage enhancements:

- It will call btrfs_start_ordered_extent() to writeback the involved
  folios

  But remember we're calling btrfs_lock_and_flush_ordered_range() at
  read paths, meaning the folio is already locked by read path.

  If we really trigger writeback, this will lead to a deadlock and
  writeback can not hold the folio lock.

  Such dead lock is prevented by the fact that btrfs always keeps a
  dirty folio also uptodate, by either dirtying all blocks of the folio,
  or read the folio before dirtying.

  But it's not the common behavior, as XFS/EXT4 both allow the folio to
  be dirty but not uptodate, by allowing buffered write to dirty a full
  block without reading the full folio.

Instead of blindly calling btrfs_start_ordered_extent(), introduce a
newer helper, which is smarter in the following ways:

- Only wait and flush the ordered extent if
  * The folio doesn't even have private set
  * Part of the blocks of the ordered extent is not uptodate

  This can happen by:
  * Folio writeback finished, then get invalidated. But OE not yet
    finished
  * Direct IO

  We have to wait for the ordered extent, as it may contain
  to-be-inserted data checksum.
  Without waiting, our read can fail due to the missing csum.

  But either way, the OE should not need any extra flush inside the
  locked folio range.

- Skip the ordered extent completely if
  * All the blocks are dirty
    This happens when OE creation is caused by previous folio.
    The writeback will never happen (we're holding the folio lock for
    read), nor will the OE finish.

    Thus we must skip the range.

  * All the blocks are uptodate
    This happens when the writeback finished, but OE not yet finished.

    Since the blocks are already uptodate, we can skip the OE range.

The newer helper, lock_extents_for_read() will do a loop for the target
range by:

1) Lock the full range

2) If there is no ordered extent in the remaining range, exit

3) If there is an ordered extent that we can skip
   Skip to the end of the OE, and continue checking
   We do not trigger writeback nor wait for the OE.

4) If there is an ordered extent that we can not skip
   Unlock the whole extent range and start the ordered extent.

And also update btrfs_start_ordered_extent() to add two more parameters:
@nowriteback_start and @nowriteback_len, to prevent triggering flush for
a certain range.

This will allow us to handle the following case properly in the future:

 16K page size, 4K btrfs block size:

 16K           20K             24K              28K            32K
 |/////////////////////////////|                |              |
 |<----------- OE 2----------->|                |<--- OE 1 --->|

 The folio has been written back before, thus we have an OE at
 [28K, 32K).
 Although the OE 1 finished its IO, the OE is not yet removed from IO
 tree.
 Later the folio got invalidated, but OE still exists.

 And [16K, 24K) range is dirty and uptodate, caused by a block aligned
 buffered write (and future enhancements allowing btrfs to skip full
 folio read for such case).

 Furthermore, OE 2 is created covering range [16K, 24K) by the writeback
 of previous folio.

 Since the full folio is not uptodate, if we want to read the folio,
 the existing btrfs_lock_and_flush_ordered_range() will dead lock, by:

 btrfs_read_folio()
 | Folio 16K is already locked
 |- btrfs_lock_and_flush_ordered_range()
    |- btrfs_start_ordered_extent() for range [16K, 24K)
       |- filemap_fdatawrite_range() for range [16K, 24K)
          |- extent_write_cache_pages()
	     folio_lock() on folio 16K, deadlock.

 But now we will have the following sequence:

 btrfs_read_folio()
 | Folio 16K is already locked
 |- lock_extents_for_read()
    |- can_skip_ordered_extent() for range [16K, 24K)
    |  Returned true, the range [16K, 24K) will be skipped.
    |- can_skip_ordered_extent() for range [28K, 32K)
    |  Returned false.
    |- btrfs_start_ordered_extent() for range [28K, 32K) with
       [16K, 32K) as no writeback range
       No writeback for folio 16K will be triggered.

 And there will be no more possible deadlock on the same folio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c       |   2 +-
 fs/btrfs/direct-io.c    |   2 +-
 fs/btrfs/extent_io.c    | 183 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/file.c         |   4 +-
 fs/btrfs/inode.c        |   4 +-
 fs/btrfs/ordered-data.c |  29 +++++--
 fs/btrfs/ordered-data.h |   3 +-
 7 files changed, 210 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 18f0704263f3..4b89094da3de 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 			break;
 
 		folio_unlock(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 		folio_lock(folio);
 		/*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index e8548de319e7..fb6df17fb55c 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 */
 			if (writing ||
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
-				btrfs_start_ordered_extent(ordered);
+				btrfs_start_ordered_extent(ordered, 0, 0);
 			else
 				ret = nowait ? -EAGAIN : -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..a6ffee6f6fd9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1081,6 +1081,185 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	return 0;
 }
 
+/*
+ * Check if we can skip waiting the @ordered extent covering the block
+ * at file pos @cur.
+ *
+ * Return true if we can skip to @next_ret. The caller needs to check
+ * the @next_ret value to make sure if covers the full range, before
+ * skipping the OE.
+ *
+ * Return false if we must wait for the ordered extent.
+ *
+ * @cur:	The start file offset that we have locked folio for read.
+ * @next_ret:	If we return true, this indiciates the next check start
+ *		range.
+ */
+static bool can_skip_one_ordered_range(struct btrfs_inode *binode,
+				       struct btrfs_ordered_extent *ordered,
+				       u64 cur, u64 *next_ret)
+{
+	const struct btrfs_fs_info *fs_info = binode->root->fs_info;
+	struct folio *folio;
+	const u32 blocksize = fs_info->sectorsize;
+	u64 range_len;
+	bool ret;
+
+	folio = filemap_get_folio(binode->vfs_inode.i_mapping,
+				  cur >> PAGE_SHIFT);
+
+	/*
+	 * We should have locked the folio(s) for range [start, end], thus
+	 * there must be a folio and it must be locked.
+	 */
+	ASSERT(!IS_ERR(folio));
+	ASSERT(folio_test_locked(folio));
+
+	/*
+	 * We several cases for the folio and OE combination:
+	 *
+	 * 0) Folio has no private flag
+	 *    The OE has all its IO done but not yet finished, and folio got
+	 *    invalidated. Or direct IO.
+	 *
+	 * Have to wait for the OE to finish, as it may contain the
+	 * to-be-inserted data checksum.
+	 * Without the data checksum inserted into csum tree, read
+	 * will just fail with missing csum.
+	 */
+	if (!folio_test_private(folio)) {
+		ret = false;
+		goto out;
+	}
+	range_len = min(folio_pos(folio) + folio_size(folio),
+			ordered->file_offset + ordered->num_bytes) - cur;
+
+	/*
+	 * 1) The first block is DIRTY.
+	 *
+	 * This means the OE is created by some folio before us, but writeback
+	 * has not started.
+	 * We can and must skip the whole OE, because it will never start until
+	 * we finished our folio read and unlocked the folio.
+	 */
+	if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
+		ret = true;
+		/*
+		 * At least inside the folio, all the remaining blocks should
+		 * also be dirty.
+		 */
+		ASSERT(btrfs_folio_test_dirty(fs_info, folio, cur, range_len));
+		*next_ret = ordered->file_offset + ordered->num_bytes;
+		goto out;
+	}
+
+	/*
+	 * 2) The first block is uptodate.
+	 *
+	 * At least the first block can be skipped, but we are still
+	 * not full sure. E.g. if the OE has some other folios in
+	 * the range that can not be skipped.
+	 * So we return true and update @next_ret to the OE/folio boundary.
+	 */
+	if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
+		u64 range_len = min(folio_pos(folio) + folio_size(folio),
+				    ordered->file_offset + ordered->num_bytes) - cur;
+
+		/*
+		 * The whole range to the OE end or folio boundary should also
+		 * be uptodate.
+		 */
+		ASSERT(btrfs_folio_test_uptodate(fs_info, folio, cur, range_len));
+		ret = true;
+		*next_ret = cur + range_len;
+		goto out;
+	}
+
+	/*
+	 * 3) The first block is not uptodate.
+	 *
+	 * This means the folio is invalidated after the OE finished, or direct IO.
+	 * Very much the same as case 1), just with private flag set.
+	 */
+	ret = false;
+out:
+	folio_put(folio);
+	return ret;
+}
+
+static bool can_skip_ordered_extent(struct btrfs_inode *binode,
+				    struct btrfs_ordered_extent *ordered,
+				    u64 start, u64 end)
+{
+	u64 range_end = min(end, ordered->file_offset + ordered->num_bytes - 1);
+	u64 range_start = max(start, ordered->file_offset);
+	u64 cur = range_start;
+
+	while (cur < range_end) {
+		bool can_skip;
+		u64 next_start;
+
+		can_skip = can_skip_one_ordered_range(binode, ordered, cur,
+						      &next_start);
+		if (!can_skip)
+			return false;
+		cur = next_start;
+	}
+	return true;
+}
+
+/*
+ * To make sure we get a stable view of extent maps for the involved range.
+ * This is for folio read paths (read and readahead), thus involved range
+ * should have all the folios locked.
+ */
+static void lock_extents_for_read(struct btrfs_inode *binode, u64 start, u64 end,
+				  struct extent_state **cached_state)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 cur_pos;
+
+	/* Caller must provide a valid @cached_state. */
+	ASSERT(cached_state);
+
+	/*
+	 * The range must at least be page aligned, as all read paths
+	 * are folio based.
+	 */
+	ASSERT(IS_ALIGNED(start, PAGE_SIZE) && IS_ALIGNED(end + 1, PAGE_SIZE));
+
+again:
+	lock_extent(&binode->io_tree, start, end, cached_state);
+	cur_pos = start;
+	while (cur_pos < end) {
+		ordered = btrfs_lookup_ordered_range(binode, cur_pos,
+						     end - cur_pos + 1);
+		/*
+		 * No ordered extents in the range, and we hold the
+		 * extent lock, no one can modify the extent maps
+		 * in the range, we're safe to return.
+		 */
+		if (!ordered)
+			break;
+
+		/* Check if we can skip waiting for the whole OE. */
+		if (can_skip_ordered_extent(binode, ordered, start, end)) {
+			cur_pos = min(ordered->file_offset + ordered->num_bytes,
+				      end + 1);
+			btrfs_put_ordered_extent(ordered);
+			continue;
+		}
+
+		/* Now wait for the OE to finish. */
+		unlock_extent(&binode->io_tree, start, end,
+			      cached_state);
+		btrfs_start_ordered_extent(ordered, start, end + 1 - start);
+		btrfs_put_ordered_extent(ordered);
+		/* We have unlocked the whole range, restart from the beginning. */
+		goto again;
+	}
+}
+
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct btrfs_inode *inode = folio_to_inode(folio);
@@ -1091,7 +1270,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	struct extent_map *em_cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
@@ -2380,7 +2559,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e87d4a37c929..00c68b7b2206 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -941,7 +941,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 				      cached_state);
 			folio_unlock(folio);
 			folio_put(folio);
-			btrfs_start_ordered_extent(ordered);
+			btrfs_start_ordered_extent(ordered, 0, 0);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
@@ -1855,7 +1855,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0efe9f005149..e99cb5109967 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2821,7 +2821,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
 		folio_unlock(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
@@ -4873,7 +4873,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		unlock_extent(io_tree, block_start, block_end, &cached_state);
 		folio_unlock(folio);
 		folio_put(folio);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4aca7475fd82..6075a6fa4817 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 
 	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
-	btrfs_start_ordered_extent(ordered);
+	btrfs_start_ordered_extent(ordered, 0, 0);
 	complete(&ordered->completion);
 }
 
@@ -842,10 +842,12 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 /*
  * Start IO and wait for a given ordered extent to finish.
  *
- * Wait on page writeback for all the pages in the extent and the IO completion
- * code to insert metadata into the btree corresponding to the extent.
+ * Wait on page writeback for all the pages in the extent but not in
+ * [@nowriteback_start, @nowriteback_start + @nowriteback_len) and the
+ * IO completion code to insert metadata into the btree corresponding to the extent.
  */
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
+				u64 nowriteback_start, u32 nowriteback_len)
 {
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
@@ -865,8 +867,19 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
 	 * start IO on any dirty ones so the wait doesn't stall waiting
 	 * for the flusher thread to find them
 	 */
-	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
-		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
+	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
+		if (!nowriteback_len) {
+			filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
+		} else {
+			if (start < nowriteback_start)
+				filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start,
+						nowriteback_start - 1);
+			if (nowriteback_start + nowriteback_len < end)
+				filemap_fdatawrite_range(inode->vfs_inode.i_mapping,
+						nowriteback_start + nowriteback_len,
+						end);
+		}
+	}
 
 	if (!freespace_inode)
 		btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent);
@@ -921,7 +934,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len)
 			btrfs_put_ordered_extent(ordered);
 			break;
 		}
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		end = ordered->file_offset;
 		/*
 		 * If the ordered extent had an error save the error but don't
@@ -1174,7 +1187,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 			break;
 		}
 		unlock_extent(&inode->io_tree, start, end, cachedp);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index be36083297a7..5e17f03d43c9 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -192,7 +192,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
+void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
+				u64 nowriteback_start, u32 nowriteback_len);
 int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
-- 
2.48.1


