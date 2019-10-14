Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0FD6262
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfJNMWQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfJNMWQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DDBCBE4A;
        Mon, 14 Oct 2019 12:22:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D72DDA7E3; Mon, 14 Oct 2019 14:22:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/15] btrfs: switch compression callbacks to direct calls
Date:   Mon, 14 Oct 2019 14:22:26 +0200
Message-Id: <e8b9ace10f2df3e902158fa8f2ed2976993a759b.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The indirect calls bring some overhead due to spectre vulnerability
mitigations. The number of cases is small and below the threshold
(10-20) where indirect call would be better.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 77 +++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/compression.h | 17 ----------
 fs/btrfs/lzo.c         |  3 --
 fs/btrfs/zlib.c        |  3 --
 fs/btrfs/zstd.c        |  3 --
 5 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8611a8b3321a..87bac8f73a99 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -86,6 +86,70 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
 	return false;
 }
 
+static int compression_compress_pages(int type, struct list_head *ws,
+               struct address_space *mapping, u64 start, struct page **pages,
+               unsigned long *out_pages, unsigned long *total_in,
+               unsigned long *total_out)
+{
+	switch (type) {
+	case BTRFS_COMPRESS_ZLIB:
+		return zlib_compress_pages(ws, mapping, start, pages,
+				out_pages, total_in, total_out);
+	case BTRFS_COMPRESS_LZO:
+		return lzo_compress_pages(ws, mapping, start, pages,
+				out_pages, total_in, total_out);
+	case BTRFS_COMPRESS_ZSTD:
+		return zstd_compress_pages(ws, mapping, start, pages,
+				out_pages, total_in, total_out);
+	case BTRFS_COMPRESS_NONE:
+	default:
+		/*
+		 * This can't happen, the type is validated several times
+		 * before we get here. As a sane fallback, return what the
+		 * callers will understand as 'no compression happened'.
+		 */
+		return -E2BIG;
+	}
+}
+
+static int compression_decompress_bio(int type, struct list_head *ws,
+		struct compressed_bio *cb)
+{
+	switch (type) {
+	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
+	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
+	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
+	case BTRFS_COMPRESS_NONE:
+	default:
+		/*
+		 * This can't happen, the type is validated several times
+		 * before we get here.
+		 */
+		BUG();
+	}
+}
+
+static int compression_decompress(int type, struct list_head *ws,
+               unsigned char *data_in, struct page *dest_page,
+               unsigned long start_byte, size_t srclen, size_t destlen)
+{
+	switch (type) {
+	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_page,
+						start_byte, srclen, destlen);
+	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
+						start_byte, srclen, destlen);
+	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_page,
+						start_byte, srclen, destlen);
+	case BTRFS_COMPRESS_NONE:
+	default:
+		/*
+		 * This can't happen, the type is validated several times
+		 * before we get here.
+		 */
+		BUG();
+	}
+}
+
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
 static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
@@ -1074,10 +1138,8 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 
 	level = btrfs_compress_set_level(type, level);
 	workspace = get_workspace(type, level);
-	ret = btrfs_compress_op[type]->compress_pages(workspace, mapping,
-						      start, pages,
-						      out_pages,
-						      total_in, total_out);
+	ret = compression_compress_pages(type, workspace, mapping, start, pages,
+					 out_pages, total_in, total_out);
 	put_workspace(type, workspace);
 	return ret;
 }
@@ -1103,7 +1165,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 	int type = cb->compress_type;
 
 	workspace = get_workspace(type, 0);
-	ret = btrfs_compress_op[type]->decompress_bio(workspace, cb);
+	ret = compression_decompress_bio(type, workspace, cb);
 	put_workspace(type, workspace);
 
 	return ret;
@@ -1121,9 +1183,8 @@ int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
 	int ret;
 
 	workspace = get_workspace(type, 0);
-	ret = btrfs_compress_op[type]->decompress(workspace, data_in,
-						  dest_page, start_byte,
-						  srclen, destlen);
+	ret = compression_decompress(type, workspace, data_in, dest_page,
+				     start_byte, srclen, destlen);
 	put_workspace(type, workspace);
 
 	return ret;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 52dce1176f89..7db14d3166b5 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -140,23 +140,6 @@ struct btrfs_compress_op {
 
 	void (*free_workspace)(struct list_head *workspace);
 
-	int (*compress_pages)(struct list_head *workspace,
-			      struct address_space *mapping,
-			      u64 start,
-			      struct page **pages,
-			      unsigned long *out_pages,
-			      unsigned long *total_in,
-			      unsigned long *total_out);
-
-	int (*decompress_bio)(struct list_head *workspace,
-				struct compressed_bio *cb);
-
-	int (*decompress)(struct list_head *workspace,
-			  unsigned char *data_in,
-			  struct page *dest_page,
-			  unsigned long start_byte,
-			  size_t srclen, size_t destlen);
-
 	/* Maximum level supported by the compression algorithm */
 	unsigned int max_level;
 	unsigned int default_level;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 04a6815ea9cb..9417944ec829 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -509,9 +509,6 @@ const struct btrfs_compress_op btrfs_lzo_compress = {
 	.put_workspace		= lzo_put_workspace,
 	.alloc_workspace	= lzo_alloc_workspace,
 	.free_workspace		= lzo_free_workspace,
-	.compress_pages		= lzo_compress_pages,
-	.decompress_bio		= lzo_decompress_bio,
-	.decompress		= lzo_decompress,
 	.max_level		= 1,
 	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 4091f94ba378..8bb6f19ab369 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -420,9 +420,6 @@ const struct btrfs_compress_op btrfs_zlib_compress = {
 	.put_workspace		= zlib_put_workspace,
 	.alloc_workspace	= zlib_alloc_workspace,
 	.free_workspace		= zlib_free_workspace,
-	.compress_pages		= zlib_compress_pages,
-	.decompress_bio		= zlib_decompress_bio,
-	.decompress		= zlib_decompress,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
 };
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index b3728220c329..5f17c741d167 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -713,9 +713,6 @@ const struct btrfs_compress_op btrfs_zstd_compress = {
 	.put_workspace = zstd_put_workspace,
 	.alloc_workspace = zstd_alloc_workspace,
 	.free_workspace = zstd_free_workspace,
-	.compress_pages = zstd_compress_pages,
-	.decompress_bio = zstd_decompress_bio,
-	.decompress = zstd_decompress,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.23.0

