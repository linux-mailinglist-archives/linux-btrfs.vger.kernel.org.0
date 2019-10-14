Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD1D6261
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfJNMWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:37274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfJNMWO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABA26BD9F;
        Mon, 14 Oct 2019 12:22:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 525DADA7E3; Mon, 14 Oct 2019 14:22:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/15] btrfs: export compression and decompression callbacks
Date:   Mon, 14 Oct 2019 14:22:24 +0200
Message-Id: <e928baa6cf6b708cdf7170b52b0162268f33c750.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Export compress_pages, decompress_bio and decompress callbacks for all
compression algos. The indirect calls will be replaced by a switch.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 24 ++++++++++++++++++++++++
 fs/btrfs/lzo.c         | 19 +++++++------------
 fs/btrfs/zlib.c        | 19 +++++++------------
 fs/btrfs/zstd.c        | 19 +++++++------------
 4 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 93deaf0cc2b8..8611a8b3321a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -29,6 +29,30 @@
 #include "extent_io.h"
 #include "extent_map.h"
 
+int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+
+int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+
+int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
 const char* btrfs_compress_type2str(enum btrfs_compression_type type)
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index acad4174f68d..04a6815ea9cb 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -131,13 +131,9 @@ static inline size_t read_compress_length(const char *buf)
 	return le32_to_cpu(dlen);
 }
 
-static int lzo_compress_pages(struct list_head *ws,
-			      struct address_space *mapping,
-			      u64 start,
-			      struct page **pages,
-			      unsigned long *out_pages,
-			      unsigned long *total_in,
-			      unsigned long *total_out)
+int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0;
@@ -303,7 +299,7 @@ static int lzo_compress_pages(struct list_head *ws,
 	return ret;
 }
 
-static int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
+int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0, ret2;
@@ -444,10 +440,9 @@ static int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-static int lzo_decompress(struct list_head *ws, unsigned char *data_in,
-			  struct page *dest_page,
-			  unsigned long start_byte,
-			  size_t srclen, size_t destlen)
+int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	size_t in_len;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index df1aace5df50..4091f94ba378 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -88,13 +88,9 @@ static struct list_head *zlib_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-static int zlib_compress_pages(struct list_head *ws,
-			       struct address_space *mapping,
-			       u64 start,
-			       struct page **pages,
-			       unsigned long *out_pages,
-			       unsigned long *total_in,
-			       unsigned long *total_out)
+int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
@@ -228,7 +224,7 @@ static int zlib_compress_pages(struct list_head *ws,
 	return ret;
 }
 
-static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
+int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0, ret2;
@@ -319,10 +315,9 @@ static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
-			   struct page *dest_page,
-			   unsigned long start_byte,
-			   size_t srclen, size_t destlen)
+int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 764d47b107e5..b3728220c329 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -367,13 +367,9 @@ static struct list_head *zstd_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-static int zstd_compress_pages(struct list_head *ws,
-		struct address_space *mapping,
-		u64 start,
-		struct page **pages,
-		unsigned long *out_pages,
-		unsigned long *total_in,
-		unsigned long *total_out)
+int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	ZSTD_CStream *stream;
@@ -548,7 +544,7 @@ static int zstd_compress_pages(struct list_head *ws,
 	return ret;
 }
 
-static int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
+int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct page **pages_in = cb->compressed_pages;
@@ -626,10 +622,9 @@ static int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-static int zstd_decompress(struct list_head *ws, unsigned char *data_in,
-		struct page *dest_page,
-		unsigned long start_byte,
-		size_t srclen, size_t destlen)
+int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	ZSTD_DStream *stream;
-- 
2.23.0

