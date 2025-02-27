Return-Path: <linux-btrfs+bounces-11889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D95A4758F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155E617074E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB542153C5;
	Thu, 27 Feb 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jis0o1eL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jis0o1eL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC71FF618
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635719; cv=none; b=kTpOf9bh+Yp+m8PK7ZC0ptsIFruO0qB2BC7XrbyLbtjrKDrv/98EChG28LlNeU4mBg9hOcOP0dj0GTfp5+Af/QgC9RbqXQrpwkpJqlrRKCUWK1T0Ry8YDVf/KfMgpCtgbyFRBvUiS6aCxSBw0NAlO87RKGdKlw2iCvYWbenQJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635719; c=relaxed/simple;
	bh=28YIbmxsrAMJekkvFvPt/E4gj3ax+loGYHb0ImyWgw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYoFdpaUsx+ScvwSC4smq1gQkg5fD1l/OQyCliZaD9jfIMFNO6ftSAHyQX1iQRGXEtCWyU9HLO/+7GSWcxULmDf5juhI9MaVYqc3ST73EFX1Iynt4NkpctQ/MFjOj6M8V5XFqr0oxETIdL2xQ4ai+L4NIE0oj6appY8lT8W8f9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jis0o1eL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jis0o1eL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0418321170
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEpv/wpNtiTbSONlcawb4wRiFTx0lc1uiFZCrb23oQ=;
	b=Jis0o1eL7q8onOs8dkRdWMRAi5YLXWGoOq8shpmo6o0wP9wRFm6YD/fvMRMPJcYeFU8uUr
	rvoo4u2Tsy9i2mtiPTA6wDOuDpuCRrVbznkKWNfoikJDTW6cfTFwebjzxI8Wh/urmucVmM
	V/2uqNBLz9YEeoDvXqAPn5g4ogv0R2Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Jis0o1eL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEpv/wpNtiTbSONlcawb4wRiFTx0lc1uiFZCrb23oQ=;
	b=Jis0o1eL7q8onOs8dkRdWMRAi5YLXWGoOq8shpmo6o0wP9wRFm6YD/fvMRMPJcYeFU8uUr
	rvoo4u2Tsy9i2mtiPTA6wDOuDpuCRrVbznkKWNfoikJDTW6cfTFwebjzxI8Wh/urmucVmM
	V/2uqNBLz9YEeoDvXqAPn5g4ogv0R2Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DC271376A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4M93AD7+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/8] btrfs: introduce a read path dedicated extent lock helper
Date: Thu, 27 Feb 2025 16:24:42 +1030
Message-ID: <23403ec45842cb921d15de83e446a9168bca9495.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0418321170
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently we're using btrfs_lock_and_flush_ordered_range() for both
btrfs_read_folio() and btrfs_readahead(), but it has one critical
problem for future subpage optimizations:

- It will call btrfs_start_ordered_extent() to writeback the involved
  folios

  But remember we're calling btrfs_lock_and_flush_ordered_range() at
  read paths, meaning the folio is already locked by read path.

  If we really trigger writeback for those already locked folios, this
  will lead to a deadlock and writeback can not get the folio lock.

  Such dead lock is prevented by the fact that btrfs always keeps a
  dirty folio also uptodate, by either dirtying all blocks of the folio,
  or read the whole folio before dirtying.

To prepare for the incoming patch which allows btrfs to skip full folio
read if the buffered write is block aligned, we have to start by solving
the possible deadlock first.

Instead of blindly calling btrfs_start_ordered_extent(), introduce a
newer helper, which is smarter in the following ways:

- Only wait and flush the ordered extent if
  * The folio doesn't even have private set
  * Part of the blocks of the ordered extent are not uptodate

  This can happen by:
  * The folio writeback finished, then get invalidated.
    There are a lot of reason that a folio can get invalidated,
    from memory pressure to direct IO (which invalidates all folios
    of the range).
    But OE not yet finished

  We have to wait for the ordered extent, as the OE may contain
  to-be-inserted data checksum.
  Without waiting, our read can fail due to the missing csum.

  But either way, the OE should not need any extra flush inside the
  locked folio range.

- Skip the ordered extent completely if
  * All the blocks are dirty
    This happens when OE creation is caused by a folio writeback whose
    file offset is before our folio.

    E.g. 16K page size and 4K block size

    0      8K      16K      24K     32K
    |//////////////||///////|       |

    The writeback of folio 0 created an OE for range [0, 24K), but since
    folio 16K is not fully uptodate, a read is triggered for folio 16K.

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

 0     4K      8K     12K      16K      20K      24K     28K      32K
 |/////////////////////////////||////////////////|       |        |
 |<-------------------- OE 2 ------------------->|       |< OE 1 >|

 The folio has been written back before, thus we have an OE at
 [28K, 32K).
 Although the OE 1 finished its IO, the OE is not yet removed from IO
 tree.
 The folio got invalidated after writeback completed and before the
 ordered extent finished.

 And [16K, 24K) range is dirty and uptodate, caused by a block aligned
 buffered write (and future enhancements allowing btrfs to skip full
 folio read for such case).
 But writeback for folio 0 has began, thus it generated OE 2, covering
 range [0, 24K).

 Since the full folio 16K is not uptodate, if we want to read the folio,
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
 fs/btrfs/extent_io.c    | 187 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ordered-data.c |  23 +++--
 fs/btrfs/ordered-data.h |   8 +-
 3 files changed, 210 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..3968ecbb727d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1081,6 +1081,189 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	return 0;
 }
 
+/*
+ * Check if we can skip waiting the @ordered extent covering the block
+ * at @fileoff.
+ *
+ * @fileoff:	Both input and output.
+ *		Input as the file offset where the check should start at.
+ *		Output as where the next check should start at,
+ *		if the function returns true.
+ *
+ * Return true if we can skip to @fileoff. The caller needs to check
+ * the new @fileoff value to make sure it covers the full range, before
+ * skipping the full OE.
+ *
+ * Return false if we must wait for the ordered extent.
+ */
+static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
+				       struct btrfs_ordered_extent *ordered,
+				       u64 *fileoff)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct folio *folio;
+	const u32 blocksize = fs_info->sectorsize;
+	u64 cur = *fileoff;
+	bool ret;
+
+	folio = filemap_get_folio(inode->vfs_inode.i_mapping,
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
+	 * 1) Folio has no private flag
+	 *    The OE has all its IO done but not yet finished, and folio got
+	 *    invalidated.
+	 *
+	 * Have to wait for the OE to finish, as it may contain the
+	 * to-be-inserted data checksum.
+	 * Without the data checksum inserted into the csum tree, read
+	 * will just fail with missing csum.
+	 */
+	if (!folio_test_private(folio)) {
+		ret = false;
+		goto out;
+	}
+
+	/*
+	 * 2) The first block is DIRTY.
+	 *
+	 * This means the OE is created by some other folios whose file pos is
+	 * before us. And since we are holding the folio lock, the writeback of
+	 * this folio can not start.
+	 *
+	 * We must skip the whole OE, because it will never start until
+	 * we finished our folio read and unlocked the folio.
+	 */
+	if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
+		u64 range_len = min(folio_pos(folio) + folio_size(folio),
+				    ordered->file_offset + ordered->num_bytes) - cur;
+
+		ret = true;
+		/*
+		 * At least inside the folio, all the remaining blocks should
+		 * also be dirty.
+		 */
+		ASSERT(btrfs_folio_test_dirty(fs_info, folio, cur, range_len));
+		*fileoff = ordered->file_offset + ordered->num_bytes;
+		goto out;
+	}
+
+	/*
+	 * 3) The first block is uptodate.
+	 *
+	 * At least the first block can be skipped, but we are still
+	 * not fully sure. E.g. if the OE has some other folios in
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
+		*fileoff = cur + range_len;
+		goto out;
+	}
+
+	/*
+	 * 4) The first block is not uptodate.
+	 *
+	 * This means the folio is invalidated after the writeback is finished,
+	 * but by some other operations (e.g. block aligned buffered write) the
+	 * folio is inserted into filemap.
+	 * Very much the same as case 1).
+	 */
+	ret = false;
+out:
+	folio_put(folio);
+	return ret;
+}
+
+static bool can_skip_ordered_extent(struct btrfs_inode *inode,
+				    struct btrfs_ordered_extent *ordered,
+				    u64 start, u64 end)
+{
+	const u64 range_end = min(end, ordered->file_offset + ordered->num_bytes - 1);
+	u64 cur = max(start, ordered->file_offset);
+
+	while (cur < range_end) {
+		bool can_skip;
+
+		can_skip = can_skip_one_ordered_range(inode, ordered, &cur);
+		if (!can_skip)
+			return false;
+	}
+	return true;
+}
+
+/*
+ * To make sure we get a stable view of extent maps for the involved range.
+ * This is for folio read paths (read and readahead), thus involved range
+ * should have all the folios locked.
+ */
+static void lock_extents_for_read(struct btrfs_inode *inode, u64 start, u64 end,
+				  struct extent_state **cached_state)
+{
+	u64 cur_pos;
+
+	/* Caller must provide a valid @cached_state. */
+	ASSERT(cached_state);
+
+	/*
+	 * The range must at least be page aligned, as all read paths
+	 * are folio based.
+	 */
+	ASSERT(IS_ALIGNED(start, PAGE_SIZE));
+	ASSERT(IS_ALIGNED(end + 1, PAGE_SIZE));
+
+again:
+	lock_extent(&inode->io_tree, start, end, cached_state);
+	cur_pos = start;
+	while (cur_pos < end) {
+		struct btrfs_ordered_extent *ordered;
+
+		ordered = btrfs_lookup_ordered_range(inode, cur_pos,
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
+		if (can_skip_ordered_extent(inode, ordered, start, end)) {
+			cur_pos = min(ordered->file_offset + ordered->num_bytes,
+				      end + 1);
+			btrfs_put_ordered_extent(ordered);
+			continue;
+		}
+
+		/* Now wait for the OE to finish. */
+		unlock_extent(&inode->io_tree, start, end,
+			      cached_state);
+		btrfs_start_ordered_extent_nowriteback(ordered, start, end + 1 - start);
+		btrfs_put_ordered_extent(ordered);
+		/* We have unlocked the whole range, restart from the beginning. */
+		goto again;
+	}
+}
+
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct btrfs_inode *inode = folio_to_inode(folio);
@@ -1091,7 +1274,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	struct extent_map *em_cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
@@ -2380,7 +2563,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+	lock_extents_for_read(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4aca7475fd82..fd33217e4b27 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
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
+void btrfs_start_ordered_extent_nowriteback(struct btrfs_ordered_extent *entry,
+					    u64 nowriteback_start, u32 nowriteback_len)
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
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index be36083297a7..1e6b0b182b29 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -192,7 +192,13 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
-void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
+void btrfs_start_ordered_extent_nowriteback(struct btrfs_ordered_extent *entry,
+				u64 nowriteback_start, u32 nowriteback_len);
+static inline void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
+{
+	return btrfs_start_ordered_extent_nowriteback(entry, 0, 0);
+}
+
 int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
-- 
2.48.1


