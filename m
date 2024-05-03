Return-Path: <linux-btrfs+bounces-4709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C68BA6D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E1A1C21FED
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C00139D0A;
	Fri,  3 May 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VUb/+U+1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VUb/+U+1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1F1C6BD
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716144; cv=none; b=TROODNpMtYtXuY5txcBigsgZA6gtpqXTrQIQtS/hNjTeFUPIJ2SWSWR8epeH/aXQ1Gd9tAgPOl3m1ZbDp8C7vocbKQZpAl1fOh5pzV7nLOZUAdCdNIKnf9aAZFKwEMMsQk0AVgfqXcYhGzkuZnkZTFo30r1LVr1veYvzM5o0NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716144; c=relaxed/simple;
	bh=xKgdgHYgmczWjC2zagfuv37RN7lsMln1Vy0p7m6IQcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc3TaZ38w8uZBAEoo34Q3fCKMpd1Ws2nknM8YhHCuUDDg+H2qbu9t0d+89NaCTFNFPgrrbxwUU6jTRVUx9sFXjksaHgRKRHtNLMUb2CN+H2Y5aQnYvk61o4gtNG7LVFX53v4yS5WJXIFJPVoC3sJLCE7cO/TvEO4NXORkyZxJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VUb/+U+1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VUb/+U+1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF691FDC4
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yP4u6E5IRXTUSqRt7rDP1yBh+iqis3Dbt8eI6IZVHRk=;
	b=VUb/+U+1KlIyDIIs9o1gKUeUm0GjniI0S+g1o2bTuWtuwz8f2Ubduko2IveYfoZiW2aB+N
	uYAY/AY9go28zWaUaSw0WRQj0hdj7oMDpxVB8g3oGvDzYqWqYzzpHRJgwVqNSy9tlIXINw
	xyT2dYfjo3GRAMG0SYvlVSEec/H1bsE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="VUb/+U+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yP4u6E5IRXTUSqRt7rDP1yBh+iqis3Dbt8eI6IZVHRk=;
	b=VUb/+U+1KlIyDIIs9o1gKUeUm0GjniI0S+g1o2bTuWtuwz8f2Ubduko2IveYfoZiW2aB+N
	uYAY/AY9go28zWaUaSw0WRQj0hdj7oMDpxVB8g3oGvDzYqWqYzzpHRJgwVqNSy9tlIXINw
	xyT2dYfjo3GRAMG0SYvlVSEec/H1bsE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9529713991
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MOlFFOx9NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 06:02:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/11] btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent
Date: Fri,  3 May 2024 15:31:44 +0930
Message-ID: <a61f241459cdfccfe338ec6bb5e883047c4457b6.1714707707.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6CF691FDC4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]

All parameters after @filepos of btrfs_alloc_ordered_extent() can be
replaced with btrfs_file_extent structure.

This patch would do the cleanup, meanwhile some points to note:

- Move btrfs_file_extent structure to ordered-data.h
  The structure is needed by both btrfs_alloc_ordered_extent() and
  can_nocow_extent(), but since btrfs_inode.h would include
  ordered-data.h, so we need to move the structure to ordered-data.h.

- Move the special handling of NOCOW/PREALLOC into
  btrfs_alloc_ordered_extent()
  Previously we have two call sites intentionally forging the numbers,
  but now with accurate btrfs_file_extent results, it's better to move
  the special handling into btrfs_alloc_ordered_extent(), so callers can
  just pass the accurate file_extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h  | 17 -----------
 fs/btrfs/inode.c        | 64 +++++++----------------------------------
 fs/btrfs/ordered-data.c | 36 +++++++++++++++++++----
 fs/btrfs/ordered-data.h | 22 ++++++++++++--
 4 files changed, 59 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bea343615ad1..6622485389dc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -443,23 +443,6 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
-
-/*
- * A more access-friendly representation of btrfs_file_extent_item.
- *
- * Unused members are excluded.
- */
-struct btrfs_file_extent {
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-
-	u64 num_bytes;
-	u64 ram_bytes;
-	u64 offset;
-
-	u8 compression;
-};
-
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 89f284ae26a4..eec5ecb917d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1220,14 +1220,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
-				       async_extent->ram_size,	/* num_bytes */
-				       async_extent->ram_size,	/* ram_bytes */
-				       ins.objectid,		/* disk_bytenr */
-				       ins.offset,		/* disk_num_bytes */
-				       0,			/* offset */
-				       1 << BTRFS_ORDERED_COMPRESSED,
-				       async_extent->compress_type);
+	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
+				       1 << BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1463,10 +1457,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, start, ram_size,
-					ram_size, ins.objectid, cur_alloc_size,
-					0, 1 << BTRFS_ORDERED_REGULAR,
-					BTRFS_COMPRESS_NONE);
+		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
+						     1 << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
 			unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
@@ -2192,20 +2184,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		/*
-		 * Check btrfs_create_dio_extent() for why we intentionally pass
-		 * incorrect value for NOCOW/PREALLOC OEs.
-		 */
 		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
-				nocow_args.file_extent.num_bytes,
-				nocow_args.file_extent.num_bytes,
-				nocow_args.file_extent.disk_bytenr +
-				nocow_args.file_extent.offset,
-				nocow_args.file_extent.num_bytes, 0,
+				&nocow_args.file_extent,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
-				: (1 << BTRFS_ORDERED_NOCOW),
-				BTRFS_COMPRESS_NONE);
+				: (1 << BTRFS_ORDERED_NOCOW));
 		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
@@ -7020,33 +7003,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 			goto out;
 	}
 
-	/*
-	 * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
-	 * but it doesn't cause problem at least for now.
-	 *
-	 * For regular writes, we would have file_extent->offset as 0,
-	 * thus we really only need disk_bytenr, every other length
-	 * (disk_num_bytes/ram_bytes) would match @len and fe->num_bytes.
-	 * The current numbers are totally fine.
-	 *
-	 * For NOCOW, we don't really care about the numbers except @file_pos
-	 * and @num_bytes, as we won't insert a file extent item at all.
-	 *
-	 * For PREALLOC, we do not use ordered extent's member, but
-	 * btrfs_mark_extent_written() would handle everything.
-	 *
-	 * So here we intentionally go with pseudo numbers for the NOCOW/PREALLOC
-	 * OEs, or btrfs_extract_ordered_extent() would need a completely new
-	 * routine to handle NOCOW/PREALLOC splits, meanwhile result nothing
-	 * different.
-	 */
-	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
-					     file_extent->disk_bytenr +
-					     file_extent->offset,
-					     len, 0,
+	ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
 					     (1 << type) |
-					     (1 << BTRFS_ORDERED_DIRECT),
-					     BTRFS_COMPRESS_NONE);
+					     (1 << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
 			free_extent_map(em);
@@ -10377,12 +10336,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start, num_bytes, ram_bytes,
-				       ins.objectid, ins.offset,
-				       encoded->unencoded_offset,
+	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 				       (1 << BTRFS_ORDERED_ENCODED) |
-				       (1 << BTRFS_ORDERED_COMPRESSED),
-				       compression);
+				       (1 << BTRFS_ORDERED_COMPRESSED));
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c5bdd674f55c..371a85250d6a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -263,17 +263,41 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  */
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type)
+			struct btrfs_file_extent *file_extent,
+			unsigned long flags)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
-	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
-				     disk_bytenr, disk_num_bytes, offset, flags,
-				     compress_type);
+	/*
+	 * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
+	 * but it doesn't cause problem at least for now.
+	 *
+	 * For NOCOW, we don't really care about the numbers except @file_pos
+	 * and @num_bytes, as we won't insert a file extent item at all.
+	 *
+	 * For PREALLOC, we do not use ordered extent's member, but
+	 * btrfs_mark_extent_written() would handle everything.
+	 *
+	 * So here we intentionally go with pseudo numbers for the NOCOW/PREALLOC
+	 * OEs, or btrfs_extract_ordered_extent() would need a completely new
+	 * routine to handle NOCOW/PREALLOC splits, meanwhile result nothing
+	 * different.
+	 */
+	if (flags & ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC)))
+		entry = alloc_ordered_extent(inode, file_offset,
+				file_extent->num_bytes, file_extent->num_bytes,
+				file_extent->disk_bytenr + file_extent->offset,
+				file_extent->num_bytes, 0, flags,
+				file_extent->compression);
+	else
+		entry = alloc_ordered_extent(inode, file_offset,
+				file_extent->num_bytes, file_extent->ram_bytes,
+				file_extent->disk_bytenr,
+				file_extent->disk_num_bytes,
+				file_extent->offset, flags,
+				file_extent->compression);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
 	return entry;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b6f6c6b91732..5bbec06fbc8d 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -171,11 +171,27 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+
+/*
+ * A more access-friendly representation of btrfs_file_extent_item.
+ *
+ * Unused members are excluded.
+ */
+struct btrfs_file_extent {
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+
+	u64 num_bytes;
+	u64 ram_bytes;
+	u64 offset;
+
+	u8 compression;
+};
+
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type);
+			struct btrfs_file_extent *file_extent,
+			unsigned long flags);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.45.0


