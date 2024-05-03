Return-Path: <linux-btrfs+bounces-4722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A88BABDA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78945283DD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B2152DE0;
	Fri,  3 May 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c7L0GBMi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c7L0GBMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957A2D047
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736996; cv=none; b=KZkJGCfV2xgGOH+YJAGPlHgzNa+ggK66NesBQjClrGblnwzFoJGwtYd5GUoKWwsgX0rQQM58yePg++CkSbxRk4MtC8Z2s2HxkSWcVBPefV4O9/ZeskYKfeFhgYcAnbmk5og/64Z0xhQYrCIg7ScRwT2xNO66nP+ovRGaKUQIVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736996; c=relaxed/simple;
	bh=SVcEq84a0lCXL7qTWHFO1vbTc2JPtILKWe4WtQVk37M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMGfQwtEtqy28/fOE5peVGP5VLIM0Rd8g0sZ08wr/M1h/qVD8KyLnKDaKUYEiK/s+ZyUPZ+ib9N0X5/GAtcEUDEGH0Cg9lYXIIkuE+DjdLiRzH8q6IIsjq0sqX3Y/y8j8x7iGSpJjjC3Y94TKh+qVAx6EGXilInIcf7vMbhC4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c7L0GBMi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c7L0GBMi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C46B338D0;
	Fri,  3 May 2024 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714736992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tkcNdC1xqiPu4LdNUJK23Fi06oHS3N2V2OS0BtXEwik=;
	b=c7L0GBMipl+NJAkEeId/+ub3lMNMCwXdc1ztxQI/atg/Z5dyhr/W2cQpqNd/ktxmIdayXa
	E73ULFgS0UIKpP886zpg487IHWuKC7tnqvDJtXpBwGlbzUZlaD11oBy+CjbSwxGGq+bnNa
	rzVJhGn48hvWeyX4dTIjWGL12Fre7Fo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714736992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tkcNdC1xqiPu4LdNUJK23Fi06oHS3N2V2OS0BtXEwik=;
	b=c7L0GBMipl+NJAkEeId/+ub3lMNMCwXdc1ztxQI/atg/Z5dyhr/W2cQpqNd/ktxmIdayXa
	E73ULFgS0UIKpP886zpg487IHWuKC7tnqvDJtXpBwGlbzUZlaD11oBy+CjbSwxGGq+bnNa
	rzVJhGn48hvWeyX4dTIjWGL12Fre7Fo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 263E2139CB;
	Fri,  3 May 2024 11:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bNdRCWDPNGagYAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 03 May 2024 11:49:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: enhance compression error messages
Date: Fri,  3 May 2024 13:42:30 +0200
Message-ID: <20240503114230.9871-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Add more verbose and specific messages to all main error points in
compression code for all algorithms. Currently there's no way to know
which inode is affected or where in the data errors happened.

The messages follow a common format:

- what happened
- error code if relevant
- root and inode
- additional data like offsets or lengths

There's no helper for the messages as they differ in some details and
that would be cumbersome to generalize to a single function. As all the
errors are "almost never happens" there are the unlikely annotations
done as compression is hot path.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/lzo.c  | 43 ++++++++++++++++++++---------
 fs/btrfs/zlib.c | 60 ++++++++++++++++++++++++++++++----------
 fs/btrfs/zstd.c | 73 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 131 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 1c396ac167aa..d2e8a9117d22 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -258,8 +258,8 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 				       workspace->cbuf, &out_len,
 				       workspace->mem);
 		kunmap_local(data_in);
-		if (ret < 0) {
-			pr_debug("BTRFS: lzo in loop returned %d\n", ret);
+		if (unlikely(ret < 0)) {
+			/* lzo1x_1_compress never fails. */
 			ret = -EIO;
 			goto out;
 		}
@@ -354,11 +354,14 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	 * and all sectors should be used.
 	 * If this happens, it means the compressed extent is corrupted.
 	 */
-	if (len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
-	    round_up(len_in, sectorsize) < cb->compressed_len) {
+	if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
+		     round_up(len_in, sectorsize) < cb->compressed_len)) {
+		struct btrfs_inode *inode = cb->bbio.inode;
+
 		btrfs_err(fs_info,
-			"invalid lzo header, lzo len %u compressed len %u",
-			len_in, cb->compressed_len);
+"lzo header invalid, root %llu inode %llu offset %llu lzo len %u compressed len %u",
+			  inode->root->root_key.objectid, btrfs_ino(inode),
+			  cb->start, len_in, cb->compressed_len);
 		return -EUCLEAN;
 	}
 
@@ -383,13 +386,17 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
 
-		if (seg_len > WORKSPACE_CBUF_LENGTH) {
+		if (unlikely(seg_len > WORKSPACE_CBUF_LENGTH)) {
+			struct btrfs_inode *inode = cb->bbio.inode;
+
 			/*
 			 * seg_len shouldn't be larger than we have allocated
 			 * for workspace->cbuf
 			 */
-			btrfs_err(fs_info, "unexpectedly large lzo segment len %u",
-					seg_len);
+			btrfs_err(fs_info,
+			"lzo segment too big, root %llu inode %llu offset %llu len %u",
+				  inode->root->root_key.objectid, btrfs_ino(inode),
+				  cb->start, seg_len);
 			return -EIO;
 		}
 
@@ -399,8 +406,13 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		/* Decompress the data */
 		ret = lzo1x_decompress_safe(workspace->cbuf, seg_len,
 					    workspace->buf, &out_len);
-		if (ret != LZO_E_OK) {
-			btrfs_err(fs_info, "failed to decompress");
+		if (unlikely(ret != LZO_E_OK)) {
+			struct btrfs_inode *inode = cb->bbio.inode;
+
+			btrfs_err(fs_info,
+		"lzo decompression failed, error %d root %llu inode %llu offset %llu",
+				  ret, inode->root->root_key.objectid,
+				  btrfs_ino(inode), cb->start);
 			return -EIO;
 		}
 
@@ -454,8 +466,13 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 
 	out_len = sectorsize;
 	ret = lzo1x_decompress_safe(data_in, in_len, workspace->buf, &out_len);
-	if (ret != LZO_E_OK) {
-		pr_warn("BTRFS: decompress failed!\n");
+	if (unlikely(ret != LZO_E_OK)) {
+		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+
+		btrfs_err(fs_info,
+		"lzo decompression failed, error %d root %llu inode %llu offset %llu",
+			  ret, inode->root->root_key.objectid,
+			  btrfs_ino(inode), page_offset(dest_page));
 		ret = -EIO;
 		goto out;
 	}
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d9e5c88a0f85..d7e5f681bc32 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/refcount.h>
 #include "compression.h"
+#include "btrfs_inode.h"
 
 /* workspace buffer size for s390 zlib hardware support */
 #define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
@@ -112,8 +113,14 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	*total_out = 0;
 	*total_in = 0;
 
-	if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
-		pr_warn("BTRFS: deflateInit failed\n");
+	ret = zlib_deflateInit(&workspace->strm, workspace->level);
+	if (unlikely(ret != Z_OK)) {
+		struct btrfs_inode *inode = BTRFS_I(mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
+			  ret, inode->root->root_key.objectid, btrfs_ino(inode),
+			  start);
 		ret = -EIO;
 		goto out;
 	}
@@ -182,9 +189,13 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 		}
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
-		if (ret != Z_OK) {
-			pr_debug("BTRFS: deflate in loop returned %d\n",
-			       ret);
+		if (unlikely(ret != Z_OK)) {
+			struct btrfs_inode *inode = BTRFS_I(mapping->host);
+
+			btrfs_warn(inode->root->fs_info,
+		"zlib compression failed, error %d root %llu inode %llu offset %llu",
+				   ret, inode->root->root_key.objectid, btrfs_ino(inode),
+				   start);
 			zlib_deflateEnd(&workspace->strm);
 			ret = -EIO;
 			goto out;
@@ -307,9 +318,15 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		workspace->strm.avail_in -= 2;
 	}
 
-	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
-		pr_warn("BTRFS: inflateInit failed\n");
+	ret = zlib_inflateInit2(&workspace->strm, wbits);
+	if (unlikely(ret != Z_OK)) {
+		struct btrfs_inode *inode = cb->bbio.inode;
+
 		kunmap_local(data_in);
+		btrfs_err(inode->root->fs_info,
+	"zlib decompression init failed, error %d root %llu inode %llu offset %llu",
+			  ret, inode->root->root_key.objectid, btrfs_ino(inode),
+			  cb->start);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -348,10 +365,15 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
 		}
 	}
-	if (ret != Z_STREAM_END)
+	if (unlikely(ret != Z_STREAM_END)) {
+		btrfs_err(cb->bbio.inode->root->fs_info,
+		"zlib decompression failed, error %d root %llu inode %llu offset %llu",
+			  ret, cb->bbio.inode->root->root_key.objectid,
+			  btrfs_ino(cb->bbio.inode), cb->start);
 		ret = -EIO;
-	else
+	} else {
 		ret = 0;
+	}
 done:
 	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
@@ -386,8 +408,14 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		workspace->strm.avail_in -= 2;
 	}
 
-	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
-		pr_warn("BTRFS: inflateInit failed\n");
+	ret = zlib_inflateInit2(&workspace->strm, wbits);
+	if (unlikely(ret != Z_OK)) {
+		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+		"zlib decompression init failed, error %d root %llu inode %llu offset %llu",
+			  ret, inode->root->root_key.objectid, btrfs_ino(inode),
+			  page_offset(dest_page));
 		return -EIO;
 	}
 
@@ -403,9 +431,13 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
 
 out:
-	if (unlikely(to_copy != destlen)) {
-		pr_warn_ratelimited("BTRFS: inflate failed, decompressed=%lu expected=%zu\n",
-					to_copy, destlen);
+	if (unlikely(ret != Z_OK || to_copy != destlen)) {
+		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+"zlib decompression failed, error %d root %llu inode %llu offset %llu decompressed %lu expected %zu",
+			  ret, inode->root->root_key.objectid, btrfs_ino(inode),
+			  page_offset(dest_page), to_copy, destlen);
 		ret = -EIO;
 	} else {
 		ret = 0;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 2b232b82c3a8..68ab483d7fd9 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -19,6 +19,7 @@
 #include <linux/zstd.h>
 #include "misc.h"
 #include "fs.h"
+#include "btrfs_inode.h"
 #include "compression.h"
 #include "super.h"
 
@@ -399,8 +400,13 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	/* Initialize the stream */
 	stream = zstd_init_cstream(&params, len, workspace->mem,
 			workspace->size);
-	if (!stream) {
-		pr_warn("BTRFS: zstd_init_cstream failed\n");
+	if (unlikely(!stream)) {
+		struct btrfs_inode *inode = BTRFS_I(mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
+			  workspace->req_level, inode->root->root_key.objectid,
+			  btrfs_ino(inode), start);
 		ret = -EIO;
 		goto out;
 	}
@@ -429,9 +435,14 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
-		if (zstd_is_error(ret2)) {
-			pr_debug("BTRFS: zstd_compress_stream returned %d\n",
-					zstd_get_error_code(ret2));
+		if (unlikely(zstd_is_error(ret2))) {
+			struct btrfs_inode *inode = BTRFS_I(mapping->host);
+
+			btrfs_warn(inode->root->fs_info,
+"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
+				   workspace->req_level, zstd_get_error_code(ret2),
+				   inode->root->root_key.objectid, btrfs_ino(inode),
+				   start);
 			ret = -EIO;
 			goto out;
 		}
@@ -497,9 +508,14 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 		size_t ret2;
 
 		ret2 = zstd_end_stream(stream, &workspace->out_buf);
-		if (zstd_is_error(ret2)) {
-			pr_debug("BTRFS: zstd_end_stream returned %d\n",
-					zstd_get_error_code(ret2));
+		if (unlikely(zstd_is_error(ret2))) {
+			struct btrfs_inode *inode = BTRFS_I(mapping->host);
+
+			btrfs_err(inode->root->fs_info,
+"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
+				  workspace->req_level, zstd_get_error_code(ret2),
+				  inode->root->root_key.objectid, btrfs_ino(inode),
+				  start);
 			ret = -EIO;
 			goto out;
 		}
@@ -561,8 +577,13 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
-	if (!stream) {
-		pr_debug("BTRFS: zstd_init_dstream failed\n");
+	if (unlikely(!stream)) {
+		struct btrfs_inode *inode = cb->bbio.inode;
+
+		btrfs_err(inode->root->fs_info,
+		"zstd decompression init failed, root %llu inode %llu offset %llu",
+			  inode->root->root_key.objectid, btrfs_ino(inode),
+			  cb->start);
 		ret = -EIO;
 		goto done;
 	}
@@ -580,9 +601,14 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		ret2 = zstd_decompress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
-		if (zstd_is_error(ret2)) {
-			pr_debug("BTRFS: zstd_decompress_stream returned %d\n",
-					zstd_get_error_code(ret2));
+		if (unlikely(zstd_is_error(ret2))) {
+			struct btrfs_inode *inode = cb->bbio.inode;
+
+			btrfs_err(inode->root->fs_info,
+		"zstd decompression failed, error %d root %llu inode %llu offset %llu",
+				  zstd_get_error_code(ret2),
+				  inode->root->root_key.objectid, btrfs_ino(inode),
+				  cb->start);
 			ret = -EIO;
 			goto done;
 		}
@@ -637,8 +663,14 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 
 	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
-	if (!stream) {
-		pr_warn("BTRFS: zstd_init_dstream failed\n");
+	if (unlikely(!stream)) {
+		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+		"zstd decompression init failed, root %llu inode %llu offset %llu",
+			  inode->root->root_key.objectid, btrfs_ino(inode),
+			  page_offset(dest_page));
+		ret = -EIO;
 		goto finish;
 	}
 
@@ -655,9 +687,14 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 	 * one call should end the decompression.
 	 */
 	ret = zstd_decompress_stream(stream, &workspace->out_buf, &workspace->in_buf);
-	if (zstd_is_error(ret)) {
-		pr_warn_ratelimited("BTRFS: zstd_decompress_stream return %d\n",
-				    zstd_get_error_code(ret));
+	if (unlikely(zstd_is_error(ret))) {
+		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+
+		btrfs_err(inode->root->fs_info,
+		"zstd decompression failed, error %d root %llu inode %llu offset %llu",
+			  zstd_get_error_code(ret),
+			  inode->root->root_key.objectid, btrfs_ino(inode),
+			  page_offset(dest_page));
 		goto finish;
 	}
 	to_copy = workspace->out_buf.pos;
-- 
2.44.0


