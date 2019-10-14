Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B659BD6267
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfJNMW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731938AbfJNMW1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC33BBE7D;
        Mon, 14 Oct 2019 12:22:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 448D7DA7E3; Mon, 14 Oct 2019 14:22:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/15] btrfs: compression: inline cleanup_workspace_manager
Date:   Mon, 14 Oct 2019 14:22:38 +0200
Message-Id: <6bb1515ce5b9446a7fb6b8a818f49f1307dcbe3d.1571054758.git.dsterba@suse.com>
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
cleanup manager callback. When that becomes trivial it is replaced by
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
index 6c4dc62b9ab0..34921a120829 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -53,6 +53,7 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		struct page *dest_page, unsigned long start_byte, size_t srclen,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
+void zstd_cleanup_workspace_manager(void);
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -861,11 +862,6 @@ struct heuristic_ws {
 
 static struct workspace_manager heuristic_wsm;
 
-static void heuristic_cleanup_workspace_manager(void)
-{
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_NONE);
-}
-
 static struct list_head *heuristic_get_workspace(unsigned int level)
 {
 	return btrfs_get_workspace(&heuristic_wsm, level);
@@ -917,7 +913,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.cleanup_workspace_manager = heuristic_cleanup_workspace_manager,
 	.get_workspace = heuristic_get_workspace,
 	.put_workspace = heuristic_put_workspace,
 	.alloc_workspace = alloc_heuristic_ws,
@@ -960,7 +955,7 @@ static void btrfs_init_workspace_manager(int type)
 	}
 }
 
-void btrfs_cleanup_workspace_manager(int type)
+static void btrfs_cleanup_workspace_manager(int type)
 {
 	struct workspace_manager *wsman;
 	struct list_head *ws;
@@ -1199,10 +1194,10 @@ void __init btrfs_init_compress(void)
 
 void __cold btrfs_exit_compress(void)
 {
-	int i;
-
-	for (i = 0; i < BTRFS_NR_WORKSPACE_MANAGERS; i++)
-		btrfs_compress_op[i]->cleanup_workspace_manager();
+	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_NONE);
+	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_ZLIB);
+	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_LZO);
+	zstd_cleanup_workspace_manager();
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 0deaa8e03836..cf667e599b70 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -123,11 +123,8 @@ struct workspace_manager {
 struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 				      unsigned int level);
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
-void btrfs_cleanup_workspace_manager(int type);
 
 struct btrfs_compress_op {
-	void (*cleanup_workspace_manager)(void);
-
 	struct list_head *(*get_workspace)(unsigned int level);
 
 	void (*put_workspace)(struct list_head *ws);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 6aa602040506..6f4619e76c11 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -63,11 +63,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static void lzo_cleanup_workspace_manager(void)
-{
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_LZO);
-}
-
 static struct list_head *lzo_get_workspace(unsigned int level)
 {
 	return btrfs_get_workspace(&wsm, level);
@@ -499,7 +494,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.cleanup_workspace_manager = lzo_cleanup_workspace_manager,
 	.get_workspace		= lzo_get_workspace,
 	.put_workspace		= lzo_put_workspace,
 	.alloc_workspace	= lzo_alloc_workspace,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 7319e9f3d484..03c632c7deac 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -29,11 +29,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-static void zlib_cleanup_workspace_manager(void)
-{
-	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_ZLIB);
-}
-
 static struct list_head *zlib_get_workspace(unsigned int level)
 {
 	struct list_head *ws = btrfs_get_workspace(&wsm, level);
@@ -410,7 +405,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.cleanup_workspace_manager = zlib_cleanup_workspace_manager,
 	.get_workspace		= zlib_get_workspace,
 	.put_workspace		= zlib_put_workspace,
 	.alloc_workspace	= zlib_alloc_workspace,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 8e7a804b05ee..f575ce77ea3d 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -194,7 +194,7 @@ void zstd_init_workspace_manager(void)
 	}
 }
 
-static void zstd_cleanup_workspace_manager(void)
+void zstd_cleanup_workspace_manager(void)
 {
 	struct workspace *workspace;
 	int i;
@@ -709,7 +709,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.cleanup_workspace_manager = zstd_cleanup_workspace_manager,
 	.get_workspace = zstd_get_workspace,
 	.put_workspace = zstd_put_workspace,
 	.alloc_workspace = zstd_alloc_workspace,
-- 
2.23.0

