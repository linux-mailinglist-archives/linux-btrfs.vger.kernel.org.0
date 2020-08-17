Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65756246614
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHQMMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQMMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD542AD60;
        Mon, 17 Aug 2020 12:13:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E516DA6EF; Mon, 17 Aug 2020 14:11:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: compression: move declarations to header
Date:   Mon, 17 Aug 2020 14:11:35 +0200
Message-Id: <4fb8395b357f79dac65fc8bc83a5a82c8f67098a.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
References: <cover.1597666167.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The declarations of compression algorithm callbacks are defined in the
.c file as they're used from there. Compiler warns that there are no
declarations for public functions when compiling lzo.c/zlib.c/zstd.c.
Fix that by moving the declarations to the header as it's the common
place for all of them.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 35 -----------------------------------
 fs/btrfs/compression.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1ab56a734e70..eeface30facd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -29,41 +29,6 @@
 #include "extent_io.h"
 #include "extent_map.h"
 
-int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
-		unsigned long *total_in, unsigned long *total_out);
-int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int zlib_decompress(struct list_head *ws, unsigned char *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
-		size_t destlen);
-struct list_head *zlib_alloc_workspace(unsigned int level);
-void zlib_free_workspace(struct list_head *ws);
-struct list_head *zlib_get_workspace(unsigned int level);
-
-int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
-		unsigned long *total_in, unsigned long *total_out);
-int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int lzo_decompress(struct list_head *ws, unsigned char *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
-		size_t destlen);
-struct list_head *lzo_alloc_workspace(unsigned int level);
-void lzo_free_workspace(struct list_head *ws);
-
-int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
-		unsigned long *total_in, unsigned long *total_out);
-int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int zstd_decompress(struct list_head *ws, unsigned char *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
-		size_t destlen);
-void zstd_init_workspace_manager(void);
-void zstd_cleanup_workspace_manager(void);
-struct list_head *zstd_alloc_workspace(unsigned int level);
-void zstd_free_workspace(struct list_head *ws);
-struct list_head *zstd_get_workspace(unsigned int level);
-void zstd_put_workspace(struct list_head *ws);
-
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
 const char* btrfs_compress_type2str(enum btrfs_compression_type type)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 9f3dbe372631..8001b700ea3a 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -144,4 +144,39 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
 int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
 
+int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+struct list_head *zlib_alloc_workspace(unsigned int level);
+void zlib_free_workspace(struct list_head *ws);
+struct list_head *zlib_get_workspace(unsigned int level);
+
+int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+struct list_head *lzo_alloc_workspace(unsigned int level);
+void lzo_free_workspace(struct list_head *ws);
+
+int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+void zstd_init_workspace_manager(void);
+void zstd_cleanup_workspace_manager(void);
+struct list_head *zstd_alloc_workspace(unsigned int level);
+void zstd_free_workspace(struct list_head *ws);
+struct list_head *zstd_get_workspace(unsigned int level);
+void zstd_put_workspace(struct list_head *ws);
+
 #endif
-- 
2.25.0

