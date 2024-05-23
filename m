Return-Path: <linux-btrfs+bounces-5235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8C8CCB9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F402836D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F313B5A0;
	Thu, 23 May 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DVk0/0cH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DVk0/0cH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4C38DF2
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440649; cv=none; b=SE5ol0HFDRf9iY2UaD5N6acBXrJ0v8Sl2W6o/dQ7/1/OizldXzB8R69YMEIJZw1j/PTwDixbu9CIYBdm++vKcUKa8rJEj97Z9sjordDX9YPpnfcFGY438AQ1fZUaf7td8OSzbHIYJt6wAxz3EwYrSY0ayGw/bznXSHkrmt/vw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440649; c=relaxed/simple;
	bh=qSrpWMHTBKRWEEqWNeTojnlObbiN6YQ1wOr+caMaUzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6OwLqNOyNbefZaIY3ubJ/qlDlT5c40XYtJOjJOO8bpxh97bYuOItdunOoGSm4ISwKmLw7CzrHRI4HA3I8iLx9OhbqzlF1HcT3f60lNDRVcqybel1MkPw1Wf96RSsuwzznncFyI47Ik7bkgQdTkOmcsMr9ftavUT4RCxCLAAyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DVk0/0cH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DVk0/0cH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFEB61FE8F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gm4g29wWnlNV5iYUgpi3swjfXv8sdcj9Symk/9xhaY=;
	b=DVk0/0cHNFwWnOsXRrlt8LGJ3JnhcnWmmLT62lc/cyiUmbLW18ep5jZQcWjCQ/fjoDpZ15
	JIJVj11axmvTLLGD+wbtXlTZOIv2pq2cnb+4r+9xmu7FtPFp3KFZSYKmLt9qRG+ohs4JQY
	WjsumbjI/AmZsC9ij0429F4kzUT7RII=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gm4g29wWnlNV5iYUgpi3swjfXv8sdcj9Symk/9xhaY=;
	b=DVk0/0cHNFwWnOsXRrlt8LGJ3JnhcnWmmLT62lc/cyiUmbLW18ep5jZQcWjCQ/fjoDpZ15
	JIJVj11axmvTLLGD+wbtXlTZOIv2pq2cnb+4r+9xmu7FtPFp3KFZSYKmLt9qRG+ohs4JQY
	WjsumbjI/AmZsC9ij0429F4kzUT7RII=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE5F13A6B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KI7kGUTOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 09/11] btrfs: cleanup duplicated parameters related to btrfs_alloc_ordered_extent
Date: Thu, 23 May 2024 14:33:28 +0930
Message-ID: <48c8d44318239d9b8ba7fe4906901529f1a5a2f5.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

All parameters after @filepos of btrfs_alloc_ordered_extent() can be
replaced with btrfs_file_extent structure.

This patch does the cleanup, meanwhile some points to note:

- Move btrfs_file_extent structure to ordered-data.h
  The structure is needed by both btrfs_alloc_ordered_extent() and
  can_nocow_extent(), but since btrfs_inode.h includes
  ordered-data.h, so we need to move the structure to ordered-data.h.

- Move the special handling of NOCOW/PREALLOC into
  btrfs_alloc_ordered_extent()
  This is to allow btrfs_split_ordered_extent() to properly split them
  for DIO.
  For now just move the handling into btrfs_alloc_ordered_extent() to
  simplify the callers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h  | 14 -----------
 fs/btrfs/inode.c        | 56 ++++++++---------------------------------
 fs/btrfs/ordered-data.c | 34 ++++++++++++++++++++-----
 fs/btrfs/ordered-data.h | 19 +++++++++++---
 4 files changed, 54 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index dbc85efdf68a..97ce56a60672 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -514,20 +514,6 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
-
-/*
- * This represents details about the target file extent item of a write
- * operation.
- */
-struct btrfs_file_extent {
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-	u64 num_bytes;
-	u64 ram_bytes;
-	u64 offset;
-	u8 compression;
-};
-
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 445c19d96d10..35f03149b777 100644
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
@@ -2191,15 +2183,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
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
@@ -7054,29 +7041,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 			goto out;
 	}
 
-	/*
-	 * For regular writes, file_extent->offset is always 0,
-	 * thus we really only need file_extent->disk_bytenr, every other length
-	 * (disk_num_bytes/ram_bytes) should match @len and
-	 * file_extent->num_bytes.
-	 *
-	 * For NOCOW, we don't really care about the numbers except
-	 * @start and @len, as we won't insert a file extent
-	 * item at all.
-	 *
-	 * For PREALLOC, we do not use ordered extent members, but
-	 * btrfs_mark_extent_written() handles everything.
-	 *
-	 * So here we always passing 0 as offset for the ordered extent,
-	 * or btrfs_split_ordered_extent() can not handle it correctly.
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
@@ -10396,12 +10363,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
index d446d89c2c34..5c2fb0a7c5c8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -264,17 +264,39 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
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
+	 * For regular writes, we just use the members in @file_extent.
+	 *
+	 * For NOCOW, we don't really care about the numbers except
+	 * @start and file_extent->num_bytes, as we won't insert a file extent
+	 * item at all.
+	 *
+	 * For PREALLOC, we do not use ordered extent members, but
+	 * btrfs_mark_extent_written() handles everything.
+	 *
+	 * So here we always passing 0 as offset for NOCOW/PREALLOC ordered
+	 * extents, or btrfs_split_ordered_extent() can not handle it correctly.
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
index 2ec329e2f0f3..31e65f2f4990 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -171,11 +171,24 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+
+/*
+ * This represents details about the target file extent item of a write
+ * operation.
+ */
+struct btrfs_file_extent {
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+	u64 num_bytes;
+	u64 ram_bytes;
+	u64 offset;
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
2.45.1


