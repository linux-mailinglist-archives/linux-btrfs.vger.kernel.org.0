Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BDD6271
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfJNMWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731968AbfJNMWe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9A86BE88;
        Mon, 14 Oct 2019 12:22:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43E19DA7E3; Mon, 14 Oct 2019 14:22:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/15] btrfs: compression: inline put_workspace
Date:   Mon, 14 Oct 2019 14:22:45 +0200
Message-Id: <243ec8e3ed32c12e7dca0bdafb9934f74ee1b5b6.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to get_workspace, majority of the callbacks is trivial, we don't
gain anything by the indirection, so replace them by a switch function.
Trivial callback implementations use the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 24 +++++++++++++++---------
 fs/btrfs/compression.h |  2 --
 fs/btrfs/lzo.c         |  6 ------
 fs/btrfs/zlib.c        |  6 ------
 fs/btrfs/zstd.c        |  1 -
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index de9b06574f42..9b9638557e19 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -39,7 +39,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 struct list_head *zlib_alloc_workspace(unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
 struct list_head *zlib_get_workspace(unsigned int level);
-void zlib_put_workspace(struct list_head *ws);
 
 int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
@@ -50,7 +49,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 		size_t destlen);
 struct list_head *lzo_alloc_workspace(unsigned int level);
 void lzo_free_workspace(struct list_head *ws);
-void lzo_put_workspace(struct list_head *ws);
 
 int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
@@ -873,11 +871,6 @@ struct heuristic_ws {
 
 static struct workspace_manager heuristic_wsm;
 
-static void heuristic_put_workspace(struct list_head *ws)
-{
-	btrfs_put_workspace(&heuristic_wsm, ws);
-}
-
 static void free_heuristic_ws(struct list_head *ws)
 {
 	struct heuristic_ws *workspace;
@@ -919,7 +912,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.put_workspace = heuristic_put_workspace,
 	.alloc_workspace = alloc_heuristic_ws,
 	.free_workspace = free_heuristic_ws,
 };
@@ -1112,7 +1104,21 @@ void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws)
 
 static void put_workspace(int type, struct list_head *ws)
 {
-	return btrfs_compress_op[type]->put_workspace(ws);
+	struct workspace_manager *wsm;
+
+	wsm = btrfs_compress_op[type]->workspace_manager;
+	switch (type) {
+	case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(wsm, ws);
+	case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(wsm, ws);
+	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(wsm, ws);
+	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(ws);
+	default:
+		/*
+		 * This can't happen, the type is validated several times
+		 * before we get here.
+		 */
+		BUG();
+	}
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index df7274c1a5d8..b8ed97fc6db4 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -125,8 +125,6 @@ struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
 
 struct btrfs_compress_op {
-	void (*put_workspace)(struct list_head *ws);
-
 	struct list_head *(*alloc_workspace)(unsigned int level);
 
 	void (*free_workspace)(struct list_head *workspace);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 821e5c137971..bbf917c5ff2d 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -63,11 +63,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-void lzo_put_workspace(struct list_head *ws)
-{
-	btrfs_put_workspace(&wsm, ws);
-}
-
 void lzo_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -489,7 +484,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.put_workspace		= lzo_put_workspace,
 	.alloc_workspace	= lzo_alloc_workspace,
 	.free_workspace		= lzo_free_workspace,
 	.max_level		= 1,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 7caa468efe94..610765640c8e 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -39,11 +39,6 @@ struct list_head *zlib_get_workspace(unsigned int level)
 	return ws;
 }
 
-void zlib_put_workspace(struct list_head *ws)
-{
-	btrfs_put_workspace(&wsm, ws);
-}
-
 void zlib_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -405,7 +400,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.put_workspace		= zlib_put_workspace,
 	.alloc_workspace	= zlib_alloc_workspace,
 	.free_workspace		= zlib_free_workspace,
 	.max_level		= 9,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c9fe0e2bd107..a346f1187fae 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -708,7 +708,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.put_workspace = zstd_put_workspace,
 	.alloc_workspace = zstd_alloc_workspace,
 	.free_workspace = zstd_free_workspace,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
-- 
2.23.0

