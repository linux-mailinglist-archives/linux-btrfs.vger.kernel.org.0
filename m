Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75485F2A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 08:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGDGLc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 02:11:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfGDGLc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 02:11:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C50FBAF55
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2019 06:11:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2.1 10/10] btrfs-progs: image: Reduce memory usage for chunk tree search
Date:   Thu,  4 Jul 2019 14:11:03 +0800
Message-Id: <20190704061103.20096-11-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704061103.20096-1-wqu@suse.com>
References: <20190704061103.20096-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like original restore_worker, search_for_chunk_blocks() will also
use a lot of memory for restoring large uncompressed extent or
compressed extent with data dump.

Reduce the memory usage by:
- Use fixed buffer size for uncompressed extent
  Now we will use fixed 512K as buffer size for reading uncompressed
  extent.

  Now chunk tree search will read out 512K data at most, then search
  chunk trees in the buffer.

  Reduce the memory usage from as large as item size, to fixed 512K.

- Use inflate() for compressed extent
  For compressed extent, we need two buffers, one for compressed data,
  and one for uncompressed data.
  For compressed data, we will use the item size as buffer size, since
  compressed extent should be small enough.
  For uncompressed data, we use 512K as buffer size.

  Now chunk tree search will fill the first 512K, then search chunk
  trees blocks in the uncompressed 512K buffer, then loop until the
  compressed data is exhausted.

  Reduce the memory usage from as large as 256M * 2 to 512K + compressed
  extent size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 159 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 33 deletions(-)

diff --git a/image/main.c b/image/main.c
index 9ac921659c8b..32767eed100b 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1959,6 +1959,126 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 	return ret;
 }
 
+static int search_chunk_uncompressed(struct mdrestore_struct *mdres,
+				     struct meta_cluster_item *item,
+				     u64 current_cluster)
+{
+	u32 item_size = le32_to_cpu(item->size);
+	u64 item_bytenr = le64_to_cpu(item->bytenr);
+	int bufsize = SZ_512K;
+	int read_size;
+	u32 offset = 0;
+	u8 *buffer;
+	int ret = 0;
+
+	ASSERT(mdres->compress_method == COMPRESS_NONE);
+	buffer = malloc(bufsize);
+	if (!buffer)
+		return -ENOMEM;
+
+	while (offset < item_size) {
+		read_size = min_t(u32, bufsize, item_size - offset);
+		ret = fread(buffer, read_size, 1, mdres->in);
+		if (ret != 1) {
+			error("read error: %m");
+			ret = -EIO;
+			goto out;
+		}
+		ret = read_chunk_block(mdres, buffer, item_bytenr, read_size,
+					current_cluster);
+		if (ret < 0) {
+			error(
+	"failed to search tree blocks in item bytenr %llu size %u",
+				item_bytenr, item_size);
+			goto out;
+		}
+		offset += read_size;
+	}
+out:
+	free(buffer);
+	return ret;
+}
+
+static int search_chunk_compressed(struct mdrestore_struct *mdres,
+				   struct meta_cluster_item *item,
+				   u64 current_cluster)
+{
+	z_stream strm;
+	u32 item_size = le32_to_cpu(item->size);
+	u64 item_bytenr = le64_to_cpu(item->bytenr);
+	int bufsize = SZ_512K;
+	int read_size;
+	u8 *out_buf = NULL;	/* uncompressed data */
+	u8 *in_buf = NULL;	/* compressed data */
+	bool end = false;
+	int ret;
+
+	ASSERT(mdres->compress_method != COMPRESS_NONE);
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	strm.avail_out = 0;
+	strm.next_out = Z_NULL;
+	ret = inflateInit(&strm);
+	if (ret != Z_OK) {
+		error("failed to initialize decompress parameters: %d", ret);
+		return ret;
+	}
+
+	out_buf = malloc(bufsize);
+	in_buf = malloc(item_size);
+	if (!in_buf || !out_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = fread(in_buf, item_size, 1, mdres->in);
+	if (ret != 1) {
+		error("read error: %m");
+		ret = -EIO;
+		goto out;
+	}
+	strm.avail_in = item_size;
+	strm.next_in = in_buf;
+	while (!end) {
+		if (strm.avail_out == 0) {
+			strm.avail_out = bufsize;
+			strm.next_out = out_buf;
+		}
+		ret = inflate(&strm, Z_NO_FLUSH);
+		switch (ret) {
+		case Z_NEED_DICT:
+			ret = Z_DATA_ERROR; /* fallthrough */
+			__attribute__ ((fallthrough));
+		case Z_DATA_ERROR:
+		case Z_MEM_ERROR:
+			goto out;
+		}
+		if (ret == Z_STREAM_END) {
+			ret = 0;
+			end = true;
+		}
+		read_size = bufsize - strm.avail_out;
+
+		ret = read_chunk_block(mdres, out_buf, item_bytenr, read_size,
+					current_cluster);
+		if (ret < 0) {
+			error(
+	"failed to search tree blocks in item bytenr %llu size %u",
+				item_bytenr, item_size);
+			goto out;
+		}
+	}
+
+out:
+	free(in_buf);
+	free(out_buf);
+	inflateEnd(&strm);
+	return ret;
+}
+
 /*
  * This function will try to find all chunk items in the dump image.
  *
@@ -2044,8 +2164,6 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 
 		/* Search items for tree blocks in sys chunks */
 		for (i = 0; i < nritems; i++) {
-			size_t size;
-
 			item = &cluster->items[i];
 			bufsize = le32_to_cpu(item->size);
 			item_bytenr = le64_to_cpu(item->bytenr);
@@ -2070,41 +2188,16 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 			}
 
 			if (mdres->compress_method == COMPRESS_ZLIB) {
-				ret = fread(tmp, bufsize, 1, mdres->in);
-				if (ret != 1) {
-					error("read error: %m");
-					ret = -EIO;
-					goto out;
-				}
-
-				size = max_size;
-				ret = uncompress(buffer,
-						 (unsigned long *)&size, tmp,
-						 bufsize);
-				if (ret != Z_OK) {
-					error("decompression failed with %d",
-							ret);
-					ret = -EIO;
-					goto out;
-				}
+				ret = search_chunk_compressed(mdres, item,
+						current_cluster);
 			} else {
-				ret = fread(buffer, bufsize, 1, mdres->in);
-				if (ret != 1) {
-					error("read error: %m");
-					ret = -EIO;
-					goto out;
-				}
-				size = bufsize;
+				ret = search_chunk_uncompressed(mdres, item,
+						current_cluster);
 			}
-			ret = 0;
-
-			ret = read_chunk_block(mdres, buffer,
-					       item_bytenr, size,
-					       current_cluster);
 			if (ret < 0) {
 				error(
-	"failed to search tree blocks in item bytenr %llu size %lu",
-					item_bytenr, size);
+	"failed to search tree blocks in item bytenr %llu size %u",
+					item_bytenr, bufsize);
 				goto out;
 			}
 			bytenr += bufsize;
-- 
2.22.0

