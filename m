Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40358D6270
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfJNMWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731968AbfJNMWc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C9CFBE87;
        Mon, 14 Oct 2019 12:22:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2B4DDA7E3; Mon, 14 Oct 2019 14:22:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/15] btrfs: compression: inline get_workspace
Date:   Mon, 14 Oct 2019 14:22:42 +0200
Message-Id: <ca037fd2c7f6c336e8fa0ca364faf17bf5b51a61.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Majority of the callbacks is trivial, we don't gain anything by the
indirection, so replace them by a switch function.

ZLIB needs to adjust level in the callback and ZSTD workspace management
is complex, the rest is call to the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 23 +++++++++++++++--------
 fs/btrfs/compression.h |  2 --
 fs/btrfs/lzo.c         |  6 ------
 fs/btrfs/zlib.c        |  1 -
 fs/btrfs/zstd.c        |  1 -
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f707db4a9a53..de9b06574f42 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -50,7 +50,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 		size_t destlen);
 struct list_head *lzo_alloc_workspace(unsigned int level);
 void lzo_free_workspace(struct list_head *ws);
-struct list_head *lzo_get_workspace(unsigned int level);
 void lzo_put_workspace(struct list_head *ws);
 
 int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
@@ -874,11 +873,6 @@ struct heuristic_ws {
 
 static struct workspace_manager heuristic_wsm;
 
-static struct list_head *heuristic_get_workspace(unsigned int level)
-{
-	return btrfs_get_workspace(&heuristic_wsm, level);
-}
-
 static void heuristic_put_workspace(struct list_head *ws)
 {
 	btrfs_put_workspace(&heuristic_wsm, ws);
@@ -925,7 +919,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.get_workspace = heuristic_get_workspace,
 	.put_workspace = heuristic_put_workspace,
 	.alloc_workspace = alloc_heuristic_ws,
 	.free_workspace = free_heuristic_ws,
@@ -1067,7 +1060,21 @@ struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 
 static struct list_head *get_workspace(int type, int level)
 {
-	return btrfs_compress_op[type]->get_workspace(level);
+	struct workspace_manager *wsm;
+
+	wsm = btrfs_compress_op[type]->workspace_manager;
+	switch (type) {
+	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(wsm, level);
+	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(level);
+	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(wsm, level);
+	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(level);
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
index cf667e599b70..df7274c1a5d8 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -125,8 +125,6 @@ struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
 
 struct btrfs_compress_op {
-	struct list_head *(*get_workspace)(unsigned int level);
-
 	void (*put_workspace)(struct list_head *ws);
 
 	struct list_head *(*alloc_workspace)(unsigned int level);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 18018619c019..821e5c137971 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -63,11 +63,6 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
-struct list_head *lzo_get_workspace(unsigned int level)
-{
-	return btrfs_get_workspace(&wsm, level);
-}
-
 void lzo_put_workspace(struct list_head *ws)
 {
 	btrfs_put_workspace(&wsm, ws);
@@ -494,7 +489,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.get_workspace		= lzo_get_workspace,
 	.put_workspace		= lzo_put_workspace,
 	.alloc_workspace	= lzo_alloc_workspace,
 	.free_workspace		= lzo_free_workspace,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index f2a56e999e5f..7caa468efe94 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -405,7 +405,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.get_workspace		= zlib_get_workspace,
 	.put_workspace		= zlib_put_workspace,
 	.alloc_workspace	= zlib_alloc_workspace,
 	.free_workspace		= zlib_free_workspace,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 2caf08e06e2f..c9fe0e2bd107 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -708,7 +708,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.get_workspace = zstd_get_workspace,
 	.put_workspace = zstd_put_workspace,
 	.alloc_workspace = zstd_alloc_workspace,
 	.free_workspace = zstd_free_workspace,
-- 
2.23.0

