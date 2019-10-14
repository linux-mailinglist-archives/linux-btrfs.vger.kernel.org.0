Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4DD6265
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfJNMWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfJNMWY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3192DBE62;
        Mon, 14 Oct 2019 12:22:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9CC41DA7E3; Mon, 14 Oct 2019 14:22:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/15] btrfs: compression: inline init_workspace_manager
Date:   Mon, 14 Oct 2019 14:22:33 +0200
Message-Id: <c4ca57b3b973f647d9632a07f76f305b4e3733a3.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace loop calling to all algos with a list of direct calls to the
init manager callback. When that becomes trivial it is replaced by
direct call to the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 17 ++++++-----------
 fs/btrfs/compression.h |  3 ---
 fs/btrfs/lzo.c         |  6 ------
 fs/btrfs/zlib.c        |  6 ------
 fs/btrfs/zstd.c        |  3 +--
 5 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6adc7f6857d7..61b9cf095ee5 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -52,6 +52,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
+void zstd_init_workspace_manager(void);
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -860,11 +861,6 @@ struct heuristic_ws {
 
 static struct workspace_manager heuristic_wsm;
 
-static void heuristic_init_workspace_manager(void)
-{
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
-}
-
 static void heuristic_cleanup_workspace_manager(void)
 {
 	btrfs_cleanup_workspace_manager(&heuristic_wsm);
@@ -921,7 +917,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.init_workspace_manager = heuristic_init_workspace_manager,
 	.cleanup_workspace_manager = heuristic_cleanup_workspace_manager,
 	.get_workspace = heuristic_get_workspace,
 	.put_workspace = heuristic_put_workspace,
@@ -937,7 +932,7 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	&btrfs_zstd_compress,
 };
 
-void btrfs_init_workspace_manager(int type)
+static void btrfs_init_workspace_manager(int type)
 {
 	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
 	struct workspace_manager *wsm = ops->workspace_manager;
@@ -1194,10 +1189,10 @@ int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
 
 void __init btrfs_init_compress(void)
 {
-	int i;
-
-	for (i = 0; i < BTRFS_NR_WORKSPACE_MANAGERS; i++)
-		btrfs_compress_op[i]->init_workspace_manager();
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
+	zstd_init_workspace_manager();
 }
 
 void __cold btrfs_exit_compress(void)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 10f82e791769..12a46139c389 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -120,15 +120,12 @@ struct workspace_manager {
 	wait_queue_head_t ws_wait;
 };
 
-void btrfs_init_workspace_manager(int type);
 struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 				      unsigned int level);
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
 void btrfs_cleanup_workspace_manager(struct workspace_manager *wsm);
 
 struct btrfs_compress_op {
-	void (*init_workspace_manager)(void);
-
 	void (*cleanup_workspace_manager)(void);
 
 	struct list_head *(*get_workspace)(unsigned int level);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 5b8470041bf6..a55079477edf 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -63,11 +63,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static void lzo_init_workspace_manager(void)
-{
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
-}
-
 static void lzo_cleanup_workspace_manager(void)
 {
 	btrfs_cleanup_workspace_manager(&wsm);
@@ -504,7 +499,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.init_workspace_manager	= lzo_init_workspace_manager,
 	.cleanup_workspace_manager = lzo_cleanup_workspace_manager,
 	.get_workspace		= lzo_get_workspace,
 	.put_workspace		= lzo_put_workspace,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index be964128dba3..39f1d0f1b286 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -29,11 +29,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static void zlib_init_workspace_manager(void)
-{
-	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
-}
-
 static void zlib_cleanup_workspace_manager(void)
 {
 	btrfs_cleanup_workspace_manager(&wsm);
@@ -415,7 +410,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.init_workspace_manager	= zlib_init_workspace_manager,
 	.cleanup_workspace_manager = zlib_cleanup_workspace_manager,
 	.get_workspace		= zlib_get_workspace,
 	.put_workspace		= zlib_put_workspace,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4791e89e43e3..8e7a804b05ee 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -168,7 +168,7 @@ static void zstd_calc_ws_mem_sizes(void)
 	}
 }
 
-static void zstd_init_workspace_manager(void)
+void zstd_init_workspace_manager(void)
 {
 	struct list_head *ws;
 	int i;
@@ -709,7 +709,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.init_workspace_manager = zstd_init_workspace_manager,
 	.cleanup_workspace_manager = zstd_cleanup_workspace_manager,
 	.get_workspace = zstd_get_workspace,
 	.put_workspace = zstd_put_workspace,
-- 
2.23.0

