Return-Path: <linux-btrfs+bounces-11388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E39A31C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 03:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C958166499
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1611D7E42;
	Wed, 12 Feb 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pNO7Skez";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pNO7Skez"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADC1D47AD
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328796; cv=none; b=moAUH8IRcwfou1pwqS7dzIxsjwlT3SL35OhfIO8/rD5kmB+rf5IDgmZb5/w1vc8zBF7THK2hVgB4dJyEL60Q3JoVFDPT5SsWE0gWua2i3+dNQzujb5fodpVhlmLjTzXsWsFDYPKr2LlMsnRvqqq7ur5qaI0AhaV64hNnyzQRk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328796; c=relaxed/simple;
	bh=m+gIEC5Uh3tUVvCnvc5bMVPRYK8Np5OZR2dUx6m2pCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC2/W1dQpuGsZ5m25k4v1qPcJ/P1YfKXWNsBn//iArYoDRcpGyWQ2gcFD5VywLKJazuR99qYIiUpcbwF8wAqcvgBA5FXiHRXSb9e17v4jLJFNqxeNxiyn4L4Y7s5ayAh2QE2AXpUk1VnoFPuOz+D5Ra+qGGhX1fV8YkVwHOQq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pNO7Skez; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pNO7Skez; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1266C33877
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqFYHx6g2cgnNWERtaxZ7uKYWq8lKKuGWr2HyqTsbV4=;
	b=pNO7SkezPq9ZkHBU+pcK4gKoA39kb7hbCgrfLxXCpNlRprCKnM7oEiR9+hk4JjliEi656g
	6F+au3cIkoy8Is0bWY82DIJ5ovy7Zult32Koi0qLuHtd12WyMD94s2k3eHkkotAi9S323G
	UkK7VRTnMxbd+dE4bI34wtgpIjfQ3Uc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pNO7Skez
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqFYHx6g2cgnNWERtaxZ7uKYWq8lKKuGWr2HyqTsbV4=;
	b=pNO7SkezPq9ZkHBU+pcK4gKoA39kb7hbCgrfLxXCpNlRprCKnM7oEiR9+hk4JjliEi656g
	6F+au3cIkoy8Is0bWY82DIJ5ovy7Zult32Koi0qLuHtd12WyMD94s2k3eHkkotAi9S323G
	UkK7VRTnMxbd+dE4bI34wtgpIjfQ3Uc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B63C13874
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePd9AxYNrGc/UAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: introduce a read path dedicated extent lock helper
Date: Wed, 12 Feb 2025 13:22:45 +1030
Message-ID: <1b6921a745547f352f5b7e266ef28e864f2ce056.1739328504.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739328504.git.wqu@suse.com>
References: <cover.1739328504.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1266C33877
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
  dirty folio also uptodate.

  But it's not the common behavior, as XFS/EXT4 both allow the folio to
  be dirty without keeping the full folio uptodate.

  They allow block aligned buffered writes to keep only the involved
  blocks to be dirty inside the folio, without reading the full folio.

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
  Without waiting, our read will fail with missing csum.

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
 Although the OE 1 finished its io, the OE is not yet removed from IO
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
index 968dae953948..d1330c138054 100644
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
index b5190a010205..c98db5058967 100644
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
index 91b20dccef73..819d51c3ed57 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1075,6 +1075,185 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
@@ -1085,7 +1264,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	struct extent_map *em_cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
@@ -2375,7 +2554,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 579706fab9b4..81e6cb599585 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -942,7 +942,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 				      cached_state);
 			folio_unlock(folio);
 			folio_put(folio);
-			btrfs_start_ordered_extent(ordered);
+			btrfs_start_ordered_extent(ordered, 0, 0);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
 		}
@@ -1846,7 +1846,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered);
+		btrfs_start_ordered_extent(ordered, 0, 0);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 32895aabf0ff..eaf53408254d 100644
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
@@ -4876,7 +4876,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
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
index 4e152736d06c..d7cf69647434 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -191,7 +191,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
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


