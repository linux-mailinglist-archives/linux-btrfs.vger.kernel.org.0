Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983761F9DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKGQcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiKGQcZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 11:32:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A3423E9C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 08:30:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD76621A0D;
        Mon,  7 Nov 2022 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667838642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=znag8JopIyeAmWuZl/hcl5llGMT1SL4SbLH5ldW2ezI=;
        b=ChiQh4YF6NTOI7iLc1J8natP1CAMnfkebkJIDHhOemUWlhfGcJlbWRO4TiZJIO1w+Xa8Zb
        jbQIeJbvO+A/gwMtjYvH+zRLTgJeJa86EVDEWCxcQ7p0PReC+jVp36E41eHQVDbb//WjS7
        ukPBDTyEdmL33FMTHYDbQz60yErAyjk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B46242C142;
        Mon,  7 Nov 2022 16:30:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E7F2DA70D; Mon,  7 Nov 2022 17:30:22 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: constify input buffer parameter in compression code
Date:   Mon,  7 Nov 2022 17:30:21 +0100
Message-Id: <20221107163021.7361-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The input buffers passed down to compression must never be changed,
switch type to u8 as it's a raw byte buffer and use const.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 4 ++--
 fs/btrfs/compression.h | 8 ++++----
 fs/btrfs/lzo.c         | 2 +-
 fs/btrfs/zlib.c        | 2 +-
 fs/btrfs/zstd.c        | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a58aab446b1f..ef07aeab2e85 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -119,7 +119,7 @@ static int compression_decompress_bio(struct list_head *ws,
 }
 
 static int compression_decompress(int type, struct list_head *ws,
-               unsigned char *data_in, struct page *dest_page,
+               const u8 *data_in, struct page *dest_page,
                unsigned long start_byte, size_t srclen, size_t destlen)
 {
 	switch (type) {
@@ -1230,7 +1230,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
  * single page, and we want to read a single page out of it.
  * start_byte tells us the offset into the compressed data we're interested in
  */
-int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
+int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 		     unsigned long start_byte, size_t srclen, size_t destlen)
 {
 	struct list_head *workspace;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index b961462399ae..6209d40a1e08 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -86,7 +86,7 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 			 unsigned long *out_pages,
 			 unsigned long *total_in,
 			 unsigned long *total_out);
-int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
+int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 		     unsigned long start_byte, size_t srclen, size_t destlen);
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
@@ -150,7 +150,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
 struct list_head *zlib_alloc_workspace(unsigned int level);
@@ -161,7 +161,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
 struct list_head *lzo_alloc_workspace(unsigned int level);
@@ -171,7 +171,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
-int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index e7b1ceffcd33..d5e78cbc8fbc 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -427,7 +427,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen)
 {
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c5275cb23837..01a13de11832 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -355,7 +355,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen)
 {
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4575b3703e74..e34f1ab99d56 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -616,7 +616,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	return ret;
 }
 
-int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen)
 {
-- 
2.37.3

