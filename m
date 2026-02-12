Return-Path: <linux-btrfs+bounces-21641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHehAfiZjWnU5AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21641-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:14:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E912BCAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7255A30333DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF02DC781;
	Thu, 12 Feb 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCcTEQxF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fCcTEQxF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFD347C6
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887664; cv=none; b=M/Pe3IenbDpZyzf/aribnUslbr+uG2efsfDfxpwUR+ufOPvItawro9f15uVpX6Xle7ApSLuHbtBmCkkO2mA7z5sAUvZLgk1RN+Im35F7TREY3ekNfNicWE9vSU9k0urPiYLJNJaA6O6i7//KsQ18IiuvIPY57wsDQ4kEh10XuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887664; c=relaxed/simple;
	bh=SBx3ZgQW90ebEdCcqBDxaPgcKghoYtdb0tpcH3bTcIQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P+bfQrDo6YlvesE/6WZc4IAFa3zKHYEYVCg2TxJfXE39k3HxJydY+btnXykmZMAAzBsC8oIzHkr6uS1ZRIviF9pnO8MsNN8Z5ZRDemJjizhc//cYLQAVJZBPis+1IQFFUwnqEw2phNGjj48vfi5lIfvk/86tOMAJxq3WxrBoY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCcTEQxF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fCcTEQxF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 839793E6D5
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770887660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kpUKeW7W/G6lNvC2ye8e/OAnUkAGX5tahKxARznzLRc=;
	b=fCcTEQxFHj/JBNQiWpcGAtHAVZIPZ2V+RbvPYx4EHJ6ZLwXvj8lvIoVYKIi7+vOM3L8Lbk
	t+43/7zVBjZusw+mpLu3C8MU7D36c5iPiMhhcsmhJAagPN+gFTkRzwUd/XgN67fFeCek/N
	i6Lkr4K+vcdEWz409eupwfiIl/21+aU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fCcTEQxF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770887660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kpUKeW7W/G6lNvC2ye8e/OAnUkAGX5tahKxARznzLRc=;
	b=fCcTEQxFHj/JBNQiWpcGAtHAVZIPZ2V+RbvPYx4EHJ6ZLwXvj8lvIoVYKIi7+vOM3L8Lbk
	t+43/7zVBjZusw+mpLu3C8MU7D36c5iPiMhhcsmhJAagPN+gFTkRzwUd/XgN67fFeCek/N
	i6Lkr4K+vcdEWz409eupwfiIl/21+aU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 798683EA62
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kXZeCuuZjWmxdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:14:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove folio parameter from ordered io related functions
Date: Thu, 12 Feb 2026 19:43:56 +1030
Message-ID: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21641-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 658E912BCAA
X-Rspamd-Action: no action

Both functions btrfs_finish_ordered_extent() and
btrfs_mark_ordered_io_finished() are accepting an optional folio
parameter.

That @folio is passed into can_finish_ordered_extent(), which later will
test and clear the ordered flag for the involved range.

However I do not think there is any other call site that can clear
ordered flags of an page cache folio and can affect
can_finish_ordered_extent().

There are limited *_clear_ordered() callers out of
can_finish_ordered_extent() function:

- btrfs_migrate_folio()
  This is completely unrelated, it's just migrating the ordered flag to
  the new folio.

- btrfs_cleanup_ordered_extents()
  We manually clean the ordered flags of all involved folios, then call
  btrfs_mark_ordered_io_finished() without a @folio parameter.
  So it doesn't need and didn't pass a @folio parameter in the first
  place.

- btrfs_writepage_fixup_worker()
  This function is going to be removed soon, and we should not hit that
  function anymore.

- btrfs_invalidate_folio()
  This is the real call site we need to bother.

  If we already have a bio running, btrfs_finish_ordered_extent() in
  end_bbio_data_write() will be executed first, as
  btrfs_invalidate_folio() will wait for the writeback to finish.

  Thus if there is a running bio, it will not see the range has
  ordered flags, and just skip to the next range.

  If there is no bio running, meaning the ordered extent is created but
  the folio is not yet submitted.

  In that case btrfs_invalidate_folio() will manually clear the folio
  ordered range, but then manually finish the ordered extent with
  btrfs_dec_test_ordered_pending() without bothering the folio ordered
  flags.

  Meaning if the OE range with folio ordered flags will be finished
  manually without the need to call can_finish_ordered_extent().

This means all can_finish_ordered_extent() call sites should get a range
that has folio ordered flag set, thus the old "return false" branch
should never be triggered.

Now we can:

- Remove the @folio parameter from involved functions
  * btrfs_mark_ordered_io_finished()
  * btrfs_finish_ordered_extent()

  For call sites passing a @folio into those functions, let them
  manually clear the ordered flag of involved folios.

- Move btrfs_finish_ordered_extent() out of the loop in
  end_bbio_data_write()

  We only need to call btrfs_finish_ordered_extent() once per bbio,
  not per folio.

- Add an ASSERT() to make sure all folio ranges have ordered flags
  It's only for end_bbio_data_write().

  And we already have enough safe nets to catch over-accounting of ordered
  extents.

Signed-off-by: Qu Wenruo <wqu@suse.com>

But I still appreciate any extra eyes on the call site analyze.
---
 fs/btrfs/compression.c  |  2 +-
 fs/btrfs/direct-io.c    |  9 ++++-----
 fs/btrfs/extent_io.c    | 23 ++++++++++++++---------
 fs/btrfs/inode.c        |  6 ++++--
 fs/btrfs/ordered-data.c | 29 +++++------------------------
 fs/btrfs/ordered-data.h |  6 ++----
 6 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1e7174ad32e2..1938d33ab57a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -292,7 +292,7 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	struct folio_iter fi;
 
-	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
+	btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->len,
 				    cb->bbio.bio.bi_status == BLK_STS_OK);
 
 	if (cb->writeback)
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 9a63200d7a53..837306254f73 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -625,7 +625,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write)
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+			btrfs_finish_ordered_extent(dio_data->ordered,
 						    pos, length, false);
 		else
 			btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
@@ -657,9 +657,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
-					    !bio->bi_status);
+		btrfs_finish_ordered_extent(bbio->ordered, dip->file_offset,
+					    dip->bytes, !bio->bi_status);
 	} else {
 		btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
 					dip->file_offset + dip->bytes - 1, NULL);
@@ -735,7 +734,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+			btrfs_finish_ordered_extent(dio_data->ordered,
 						    file_offset, dip->bytes,
 						    !ret);
 			bio->bi_status = errno_to_blk_status(ret);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 11faecb66109..8914eda1c28f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -521,6 +521,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
 	const u32 sectorsize = fs_info->sectorsize;
+	u32 bio_size = 0;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, bio) {
@@ -528,6 +529,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		u64 start = folio_pos(folio) + fi.offset;
 		u32 len = fi.length;
 
+		bio_size += len;
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
@@ -538,13 +540,15 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		"incomplete page write with offset %zu and length %zu",
 				   fi.offset, fi.length);
 
-		btrfs_finish_ordered_extent(bbio->ordered, folio, start, len,
-					    !error);
 		if (error)
 			mapping_set_error(folio->mapping, error);
+
+		ASSERT(btrfs_folio_test_ordered(fs_info, folio, start, len));
+		btrfs_folio_clear_ordered(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
 
+	btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, bio_size, !error);
 	bio_put(bio);
 }
 
@@ -1577,7 +1581,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
 			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
-			btrfs_mark_ordered_io_finished(inode, folio, start, len, false);
+			btrfs_folio_clear_ordered(fs_info, folio, start, len);
+			btrfs_mark_ordered_io_finished(inode, start, len, false);
 		}
 		return ret;
 	}
@@ -1653,6 +1658,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 		 * ordered extent.
 		 */
 		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_clear_ordered(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
 
@@ -1660,8 +1666,8 @@ static int submit_one_sector(struct btrfs_inode *inode,
 		 * Since there is no bio submitted to finish the ordered
 		 * extent, we have to manually finish this sector.
 		 */
-		btrfs_mark_ordered_io_finished(inode, folio, filepos,
-					       fs_info->sectorsize, false);
+		btrfs_mark_ordered_io_finished(inode, filepos, fs_info->sectorsize,
+					       false);
 		return PTR_ERR(em);
 	}
 
@@ -1773,8 +1779,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			spin_unlock(&inode->ordered_tree_lock);
 			btrfs_put_ordered_extent(ordered);
 
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       fs_info->sectorsize, true);
+			btrfs_folio_clear_ordered(fs_info, folio, cur, fs_info->sectorsize);
+			btrfs_mark_ordered_io_finished(inode, cur, fs_info->sectorsize, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -2649,8 +2655,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (IS_ERR(folio)) {
 			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 			cur_len = cur_end + 1 - cur;
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       cur, cur_len, false);
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), cur, cur_len, false);
 			mapping_set_error(mapping, PTR_ERR(folio));
 			cur = cur_end;
 			continue;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3af087c81724..b6b386e06529 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -424,7 +424,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		folio_put(folio);
 	}
 
-	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes, false);
+	return btrfs_mark_ordered_io_finished(inode, offset, bytes, false);
 }
 
 static int btrfs_dirty_inode(struct btrfs_inode *inode);
@@ -2945,7 +2945,9 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(folio->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, folio, page_start,
+		btrfs_folio_clear_ordered(fs_info, folio, page_start,
+					  folio_size(folio));
+		btrfs_mark_ordered_io_finished(inode, page_start,
 					       folio_size(folio), !ret);
 		folio_clear_dirty_for_io(folio);
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e47c3a3a619a..8405d07b49cd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -348,30 +348,13 @@ static void finish_ordered_fn(struct btrfs_work *work)
 }
 
 static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				      struct folio *folio, u64 file_offset,
-				      u64 len, bool uptodate)
+				      u64 file_offset, u64 len, bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	lockdep_assert_held(&inode->ordered_tree_lock);
 
-	if (folio) {
-		ASSERT(folio->mapping);
-		ASSERT(folio_pos(folio) <= file_offset);
-		ASSERT(file_offset + len <= folio_next_pos(folio));
-
-		/*
-		 * Ordered flag indicates whether we still have
-		 * pending io unfinished for the ordered extent.
-		 *
-		 * If it's not set, we need to skip to next range.
-		 */
-		if (!btrfs_folio_test_ordered(fs_info, folio, file_offset, len))
-			return false;
-		btrfs_folio_clear_ordered(fs_info, folio, file_offset, len);
-	}
-
 	/* Now we're fine to update the accounting. */
 	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
 		btrfs_crit(fs_info,
@@ -413,8 +396,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 }
 
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct folio *folio, u64 file_offset, u64 len,
-				 bool uptodate)
+				 u64 file_offset, u64 len, bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
 	bool ret;
@@ -422,7 +404,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
 	spin_lock(&inode->ordered_tree_lock);
-	ret = can_finish_ordered_extent(ordered, folio, file_offset, len,
+	ret = can_finish_ordered_extent(ordered, file_offset, len,
 					uptodate);
 	spin_unlock(&inode->ordered_tree_lock);
 
@@ -475,8 +457,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
  * extent(s) covering it.
  */
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				    struct folio *folio, u64 file_offset,
-				    u64 num_bytes, bool uptodate)
+				    u64 file_offset, u64 num_bytes, bool uptodate)
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
@@ -536,7 +517,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		len = this_end - cur;
 		ASSERT(len < U32_MAX);
 
-		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
+		if (can_finish_ordered_extent(entry, cur, len, uptodate)) {
 			spin_unlock(&inode->ordered_tree_lock);
 			btrfs_queue_ordered_fn(entry);
 			spin_lock(&inode->ordered_tree_lock);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 86e69de9e9ff..cd74c5ecfd67 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -163,11 +163,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct folio *folio, u64 file_offset, u64 len,
-				 bool uptodate);
+				 u64 file_offset, u64 len, bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				    struct folio *folio, u64 file_offset,
-				    u64 num_bytes, bool uptodate);
+				    u64 file_offset, u64 num_bytes, bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
-- 
2.52.0


