Return-Path: <linux-btrfs+bounces-22213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PSrUF9PAp2ldjgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22213-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 06:19:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3F1FAD74
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 06:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFB330859F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244AA3264F4;
	Wed,  4 Mar 2026 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DM+bZFmY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DM+bZFmY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6323368BD
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601546; cv=none; b=mS633NWD6oo0erjNwj5V+VyeWpTA4u5qsdYMqadbdM1IWxtMW5K+6so172Kq45oSST5cygsl552MIea9zhpZzUTVw/bKLzuBJN8+J0ez6ATSdorQ6Tb0/FzTpnC3iC1178bAhky3Pd8hBaA7+dTjNqbvS2bjUVp00cXVphO+zuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601546; c=relaxed/simple;
	bh=sS7IooesauSYnzSnR2MEgpt4XXugSFp2QkgtJbrcOdg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h6+wFWpb+RpEubLuGWUTKQRxy2qKg9ZvqdyNkOel/8snJlOfdgf7PM8Bwuk20ZDBtcJkxxtfHoi8jeP2+LdJtS9CQivVe/6CUPeLtDeA4KPonmaUkQoqralk8d2QMlFrKwap0CYoFmsKojZxZjc9vFPrG/XtVbroMGn6wTsuXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DM+bZFmY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DM+bZFmY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ABC95BD8C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 05:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772601542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8/PYH3vz3rRA+eZ45C8nAUQlSediZs11CftAOfiSuJA=;
	b=DM+bZFmYrEdkwZSboU25OqTGcTnjA6bZ43tKKJSXPpzcaqLXzlYpIexYaZdoIA0l83WKOn
	dQf4QkvRJBUvRayeqVHeyM21YSYY2DuduDie2L0+d91/tZMJxh/VvlWSatiB74Q13qQ17F
	O5KfBm7EjFdtjk/ORzLXug6YDuEXMeI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772601542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8/PYH3vz3rRA+eZ45C8nAUQlSediZs11CftAOfiSuJA=;
	b=DM+bZFmYrEdkwZSboU25OqTGcTnjA6bZ43tKKJSXPpzcaqLXzlYpIexYaZdoIA0l83WKOn
	dQf4QkvRJBUvRayeqVHeyM21YSYY2DuduDie2L0+d91/tZMJxh/VvlWSatiB74Q13qQ17F
	O5KfBm7EjFdtjk/ORzLXug6YDuEXMeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D560A3EA69
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 05:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6QuTJcXAp2m5SgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 05:19:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5] btrfs: extract inlined creation into a dedicated delalloc helper
Date: Wed,  4 Mar 2026 15:48:44 +1030
Message-ID: <c47f725a3f9677216b031a6ae4530647e5b471f5.1772601410.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: B5D3F1FAD74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22213-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

Currently we call cow_file_range_inline() in different situations, from
regular cow_file_range() to compress_file_range().

This is because inline extent creation has different conditions based on
whether it's a compressed one or not.

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
run_delalloc_inline(), which allows single block compression, but
other call sites should always reject single block compression.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v5:
- Fix a bug if there is not enougn metadata space
  If the metadata space is not enough to insert the inlined extent, the
  old code will fallback to regular COW/NOCOW path, but the new code
  will treat it as successfully insert.

- Add comments about the return value of __cow_file_range_inline()
  Which follows the new run_delalloc_inline().

- Cleanup compressed bio structure early
  So that we do not need extra cleanup later.

v4:
- Reorder with the patch "btrfs: do compressed bio size roundup and zeroing in one go"
  That patch is a pure cleanup, should not depend on this intrusive
  patch.

- Remove the comment of ret > 0 case of cow_file_range()
  As that function can no longer create inlined extent.

v3:
- Fix a grammar error in the commit message

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
 fs/btrfs/inode.c | 220 +++++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 89ab33c5b940..c1abeb72069c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -74,7 +74,6 @@
 #include "delayed-inode.h"
 
 #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
-#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -622,6 +621,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
  *
  * If being used directly, you must have already checked we're allowed to cow
  * the range by getting true from can_cow_file_range_inline().
+ *
+ * Return 0 if the inlined extent is created successfully.
+ * Return <0 for critical error, and should be considered as an writeback error.
+ * Return >0 if can not create an inlined extent (mostly due to lack of meta space).
  */
 static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 					    u64 size, size_t compressed_size,
@@ -703,55 +706,6 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
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
@@ -797,7 +751,7 @@ static int add_async_extent(struct async_chunk *cow, u64 start, u64 ram_size,
  * options, defragmentation, properties or heuristics.
  */
 static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
-				      u64 end)
+				      u64 end, bool check_inline)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
@@ -812,8 +766,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
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
@@ -928,7 +883,6 @@ static void compress_file_range(struct btrfs_work *work)
 		container_of(work, struct async_chunk, work);
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	struct compressed_bio *cb = NULL;
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
@@ -1000,7 +954,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 * been flagged as NOCOMPRESS.  This flag can change at any time if we
 	 * discover bad compression ratios.
 	 */
-	if (!inode_need_compress(inode, start, end))
+	if (!inode_need_compress(inode, start, end, false))
 		goto cleanup_and_bail_uncompressed;
 
 	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
@@ -1021,35 +975,6 @@ static void compress_file_range(struct btrfs_work *work)
 	total_compressed = cb->bbio.bio.bi_iter.bi_size;
 	total_in = cur_len;
 
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
-	 * If a single block at file offset 0 cannot be inlined, fall back to
-	 * regular writes without marking the file incompressible.
-	 */
-	if (start == 0 && end <= blocksize)
-		goto cleanup_and_bail_uncompressed;
-
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
 	 * block size boundary so the allocator does sane things.
@@ -1427,11 +1352,6 @@ static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
  *
  * When this function fails, it unlocks all folios except @locked_folio.
  *
- * When this function successfully creates an inline extent, it returns 1 and
- * unlocks all folios including locked_folio and starts I/O on them.
- * (In reality inline extents are limited to a single block, so locked_folio is
- * the only folio handled anyway).
- *
  * When this function succeed and creates a normal extent, the folio locking
  * status depends on the passed in flags:
  *
@@ -1475,25 +1395,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
@@ -1571,7 +1472,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	}
 	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
-done:
 	if (done_offset)
 		*done_offset = end;
 	return ret;
@@ -1874,7 +1774,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * a locked folio, which can race with writeback.
 	 */
 	ret = cow_file_range(inode, locked_folio, start, end, NULL,
-			     COW_FILE_RANGE_NO_INLINE | COW_FILE_RANGE_KEEP_LOCKED);
+			     COW_FILE_RANGE_KEEP_LOCKED);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -2425,6 +2325,91 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
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
+	if (cb) {
+		ret = __cow_file_range_inline(inode, i_size, compressed_size, compress_type,
+					      bio_first_folio_all(&cb->bbio.bio), false);
+		cleanup_compressed_bio(cb);
+		cb = NULL;
+	} else {
+		ret = __cow_file_range_inline(inode, i_size, 0, BTRFS_COMPRESS_NONE,
+					      NULL, false);
+	}
+	/*
+	 * We failed to insert inline extent due to lack of meta space.
+	 * Just unlock the extent io range and fallback to regular COW/NOCOW path.
+	 */
+	if (ret > 0) {
+		btrfs_unlock_extent(&inode->io_tree, 0, blocksize - 1, &cached);
+		return ret;
+	}
+
+	/*
+	 * In the successful case (ret == 0 here), btrfs_run_delalloc_range()
+	 * will return 1.
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
+	return ret;
+}
+
 /*
  * Function to process delayed allocation (create CoW) for ranges which are
  * being touched for the first time.
@@ -2441,11 +2426,26 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
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
2.53.0


