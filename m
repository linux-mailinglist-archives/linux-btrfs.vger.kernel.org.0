Return-Path: <linux-btrfs+bounces-21697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DZV9DnTmk2nm9gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21697-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 04:54:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911D148A39
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 04:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8C6B3002D37
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171BA1D5CD1;
	Tue, 17 Feb 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kd9AvAEc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k9FRvTis"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE760C8E6
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771300462; cv=none; b=avBxQ5lhKZkUXAvPus6h7xAzIiv2s6iF47POtLDUS43QBq/lCpqlpLOh0j/y6HY6eI0lDpBDdUInkZ2XRgZb7RwWw+70A0+gjfk1rDm20uh5kNyBv4J97e2R8klWB4eiwHlOWQca89Ld4rO/Dq8v9WgFN/8xNKcdakSkbHXKIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771300462; c=relaxed/simple;
	bh=pAW4QFXE+K8bodBxS7pmwpTMseRbSVzt7Xz+sFXlvYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WyZtNaphOo2djlLaR0cKxEloj0D/XLz8JV5CPw0mWVNRxiX8Ey+xkP9ye/QMe8i8Dr/gHDwoUyjiSRi3symauC4Joi/0ZgGgTOx3xtktGSWvdjXeM5BDslWg74BCUMtGyT+zUHsBvVqFxRtoM7Tk2bqnt3McpZjk2fBYn3jqkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kd9AvAEc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k9FRvTis; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD37C3E77E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771300459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IkYdi0N52YNMCHbkLaVDYdsxfMyoTWb3u4v/g+lwuZA=;
	b=kd9AvAEc4fW6EJLBW3I87P7D2UoC1blHfa2rsbSng2L/iGuFD/W8pSQeiyR1i/aLDh51aG
	NN/nYLTVUOG14r9ySYRcyPtRPcnoIQBGUYpAJiSJFMR5oQf6l0PqJR3gucll9p/BtJEsO4
	SYGK8+U+5eP2UhP4YKl2gm2ufFKJW0Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771300457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IkYdi0N52YNMCHbkLaVDYdsxfMyoTWb3u4v/g+lwuZA=;
	b=k9FRvTiszOp+WP6bbnCXffmZEKrB7uNqDr4ag9Gh0RMmvDmtxIQWd2ISPsp+tLZNQu2cGp
	Ar/GpQ9IboAg0F49aaGuaaqC30ZIDo0mQ79VPbGeoKG2mnbXkiwToZr0G9r4X/QBo8GfVj
	pT9XupKbF0lsXdYD/HM5JLMFLNDaOiE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE3C73EA65
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pJPcBGfmk2mQSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:54:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: extract inlined creation into a dedicated delalloc helper
Date: Tue, 17 Feb 2026 14:23:55 +1030
Message-ID: <d1ffaf74c5cc632f5dce56161d218ccd5f005433.1771300316.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21697-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 4911D148A39
X-Rspamd-Action: no action

Currently we call cow_file_range_inline() in different situations, from
regular cow_file_range() to compress_file_range().

This is inline creation is a little complex as the conditions are
different based on if the inline extent can be compressed.

But on the other hand, inline extent creation shouldn't be so
distributed, we can just have a dedicated branch in
btrfs_run_delalloc_range().

It will become more obvious for compressed inline cases, it makes no
sense to go through all the complex async extent mechanism just to
inline a single block.

So here we introduce a dedicated run_delalloc_inline() helper, and
remove all inline related handling from cow_file_range() and
compress_file_range().

There is a special update to inode_need_compress(), that a new
@check_inline parameter is introduced.
This is to allow inline specific checks to be done inside
run_delalloc_inline(), which requires single block compression, but
other call sites should always reject single block compression.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a bug exposed in btrfs/344
  Where the inode_need_compress() check allows single block to be
  compressed.
  Update inode_need_compress() to accept a new @check_inline parameter,
  so that only inode_need_compress() in run_delalloc_inline() will allow
  single block to be compressed, meanwhile all other call sites will
  reject single block compression.

- Fix a leak of extent_state
---
 fs/btrfs/inode.c | 200 ++++++++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4523b689711d..baf400847ce8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -74,7 +74,6 @@
 #include "delayed-inode.h"
 
 #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
-#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -703,55 +702,6 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	return ret;
 }
 
-static noinline int cow_file_range_inline(struct btrfs_inode *inode,
-					  struct folio *locked_folio,
-					  u64 offset, u64 end,
-					  size_t compressed_size,
-					  int compress_type,
-					  struct folio *compressed_folio,
-					  bool update_i_size)
-{
-	struct extent_state *cached = NULL;
-	unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
-	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
-	int ret;
-
-	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
-		return 1;
-
-	btrfs_lock_extent(&inode->io_tree, offset, end, &cached);
-	ret = __cow_file_range_inline(inode, size, compressed_size,
-				      compress_type, compressed_folio,
-				      update_i_size);
-	if (ret > 0) {
-		btrfs_unlock_extent(&inode->io_tree, offset, end, &cached);
-		return ret;
-	}
-
-	/*
-	 * In the successful case (ret == 0 here), cow_file_range will return 1.
-	 *
-	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
-	 * is treated as a short circuited success and does not unlock the folio,
-	 * so we must do it here.
-	 *
-	 * In the failure case, the locked_folio does get unlocked by
-	 * btrfs_folio_end_all_writers, which asserts that it is still locked
-	 * at that point, so we must *not* unlock it here.
-	 *
-	 * The other two callsites in compress_file_range do not have a
-	 * locked_folio, so they are not relevant to this logic.
-	 */
-	if (ret == 0)
-		locked_folio = NULL;
-
-	extent_clear_unlock_delalloc(inode, offset, end, locked_folio, &cached,
-				     clear_flags, PAGE_UNLOCK |
-				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
-	return ret;
-}
-
 struct async_extent {
 	u64 start;
 	u64 ram_size;
@@ -797,7 +747,7 @@ static int add_async_extent(struct async_chunk *cow, u64 start, u64 ram_size,
  * options, defragmentation, properties or heuristics.
  */
 static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
-				      u64 end)
+				      u64 end, bool check_inline)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
@@ -812,8 +762,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	 * and will always fallback to regular write later.
 	 */
 	if (end + 1 - start <= fs_info->sectorsize &&
-	    (start > 0 || end + 1 < inode->disk_i_size))
+	    (!check_inline || (start > 0 || end + 1 < inode->disk_i_size)))
 		return 0;
+
 	/* Defrag ioctl takes precedence over mount options and properties. */
 	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
 		return 0;
@@ -936,7 +887,6 @@ static void compress_file_range(struct btrfs_work *work)
 		container_of(work, struct async_chunk, work);
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	struct compressed_bio *cb = NULL;
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	u64 blocksize = fs_info->sectorsize;
@@ -1010,7 +960,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 * been flagged as NOCOMPRESS.  This flag can change at any time if we
 	 * discover bad compression ratios.
 	 */
-	if (!inode_need_compress(inode, start, end))
+	if (!inode_need_compress(inode, start, end, false))
 		goto cleanup_and_bail_uncompressed;
 
 	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
@@ -1039,35 +989,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (loff)
 		zero_last_folio(cb);
 
-	/*
-	 * Try to create an inline extent.
-	 *
-	 * If we didn't compress the entire range, try to create an uncompressed
-	 * inline extent, else a compressed one.
-	 *
-	 * Check cow_file_range() for why we don't even try to create inline
-	 * extent for the subpage case.
-	 */
-	if (total_in < actual_end)
-		ret = cow_file_range_inline(inode, NULL, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false);
-	else
-		ret = cow_file_range_inline(inode, NULL, start, end, total_compressed,
-					    compress_type,
-					    bio_first_folio_all(&cb->bbio.bio), false);
-	if (ret <= 0) {
-		cleanup_compressed_bio(cb);
-		if (ret < 0)
-			mapping_set_error(mapping, -EIO);
-		return;
-	}
-	/*
-	 * If a single block at file offset 0 can not be inlined, fallback
-	 * to regular writes without marking the file incompressible.
-	 */
-	if (start == 0 && end <= blocksize)
-		goto cleanup_and_bail_uncompressed;
-
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
 	 * block size boundary so the allocator does sane things.
@@ -1492,25 +1413,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	ASSERT(num_bytes <= btrfs_super_total_bytes(fs_info->super_copy));
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
-
-	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {
-		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false);
-		if (ret <= 0) {
-			/*
-			 * We succeeded, return 1 so the caller knows we're done
-			 * with this page and already handled the IO.
-			 *
-			 * If there was an error then cow_file_range_inline() has
-			 * already done the cleanup.
-			 */
-			if (ret == 0)
-				ret = 1;
-			goto done;
-		}
-	}
-
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
 
 	/*
@@ -1588,7 +1490,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	}
 	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
-done:
 	if (done_offset)
 		*done_offset = end;
 	return ret;
@@ -1891,7 +1792,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * a locked folio, which can race with writeback.
 	 */
 	ret = cow_file_range(inode, locked_folio, start, end, NULL,
-			     COW_FILE_RANGE_NO_INLINE | COW_FILE_RANGE_KEEP_LOCKED);
+			     COW_FILE_RANGE_KEEP_LOCKED);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -2442,6 +2343,80 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
 	return false;
 }
 
+/*
+ * Return 0 if an inlined extent is created successfully.
+ * Return <0 if critical error happened.
+ * Return >0 if an inline extent can not be created.
+ */
+static int run_delalloc_inline(struct btrfs_inode *inode, struct folio *locked_folio)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct compressed_bio *cb = NULL;
+	struct extent_state *cached = NULL;
+	const u64 i_size = i_size_read(&inode->vfs_inode);
+	const u32 blocksize = fs_info->sectorsize;
+	int compress_type = fs_info->compress_type;
+	int compress_level = fs_info->compress_level;
+	u32 compressed_size = 0;
+	int ret;
+
+	ASSERT(folio_pos(locked_folio) == 0);
+
+	if (btrfs_inode_can_compress(inode) &&
+	    inode_need_compress(inode, 0, blocksize, true)) {
+		if (inode->defrag_compress > 0 &&
+		    inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
+			compress_type = inode->defrag_compress;
+			compress_level = inode->defrag_compress_level;
+		} else if (inode->prop_compress) {
+			compress_type = inode->prop_compress;
+		}
+		cb = btrfs_compress_bio(inode, 0, blocksize, compress_type, compress_level, 0);
+		if (IS_ERR(cb)) {
+			cb = NULL;
+			/* Just fall back to non-compressed case. */
+		} else {
+			compressed_size = cb->bbio.bio.bi_iter.bi_size;
+		}
+	}
+	if (!can_cow_file_range_inline(inode, 0, i_size, compressed_size)) {
+		if (cb)
+			cleanup_compressed_bio(cb);
+		return 1;
+	}
+
+	btrfs_lock_extent(&inode->io_tree, 0, blocksize - 1, &cached);
+	if (cb)
+		ret = __cow_file_range_inline(inode, i_size, compressed_size, compress_type,
+					      bio_first_folio_all(&cb->bbio.bio), false);
+	else
+		ret = __cow_file_range_inline(inode, i_size, 0, BTRFS_COMPRESS_NONE,
+					      NULL, false);
+	/*
+	 * In the successful case (ret == 0 here), run_delalloc_inline() will return 1.
+	 *
+	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
+	 * is treated as a short circuited success and does not unlock the folio,
+	 * so we must do it here.
+	 *
+	 * For failure case, the @locked_folio does get unlocked by
+	 * btrfs_folio_end_lock_bitmap(), so we must *not* unlock it here.
+	 *
+	 * So if ret == 0, we let extent_clear_unlock_delalloc() to unlock the
+	 * folio by passing NULL as @locked_folio.
+	 * Otherwise pass @locked_folio as usual.
+	 */
+	if (ret == 0)
+		locked_folio = NULL;
+	extent_clear_unlock_delalloc(inode, 0, blocksize - 1, locked_folio, &cached,
+				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
+				     EXTENT_DO_ACCOUNTING | EXTENT_LOCKED,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
+	if (cb)
+		cleanup_compressed_bio(cb);
+	return ret;
+}
+
 /*
  * Function to process delayed allocation (create CoW) for ranges which are
  * being touched for the first time.
@@ -2458,11 +2433,26 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	ASSERT(!(end <= folio_pos(locked_folio) ||
 		 start >= folio_next_pos(locked_folio)));
 
+	if (start == 0 && end + 1 <= inode->root->fs_info->sectorsize &&
+	    end + 1 >= inode->disk_i_size) {
+		int ret;
+
+		ret = run_delalloc_inline(inode, locked_folio);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return 1;
+		/*
+		 * Continue regular handling if we can not create an
+		 * inlined extent.
+		 */
+	}
+
 	if (should_nocow(inode, start, end))
 		return run_delalloc_nocow(inode, locked_folio, start, end);
 
 	if (btrfs_inode_can_compress(inode) &&
-	    inode_need_compress(inode, start, end) &&
+	    inode_need_compress(inode, start, end, false) &&
 	    run_delalloc_compressed(inode, locked_folio, start, end, wbc))
 		return 1;
 
-- 
2.52.0


