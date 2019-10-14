Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9465FD6275
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfJNMWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730375AbfJNMWo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28240BE8E;
        Mon, 14 Oct 2019 12:22:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA700DA7E3; Mon, 14 Oct 2019 14:22:54 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 14/15] btrfs: compression: inline free_workspace
Date:   Mon, 14 Oct 2019 14:22:54 +0200
Message-Id: <72c6b766cb35dbbc7087528a13522e8d7c7e5a89.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace indirect calls to free_workspace by switch and calls to the
specific callbacks. This is mainly to get rid of the indirection due to
spectre vulnerability mitigations.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 21 ++++++++++++++++++---
 fs/btrfs/compression.h |  2 --
 fs/btrfs/lzo.c         |  1 -
 fs/btrfs/zlib.c        |  1 -
 fs/btrfs/zstd.c        |  1 -
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2a77c91c194b..b2342f99b093 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -912,7 +912,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.free_workspace = free_heuristic_ws,
 };
 
 static const struct btrfs_compress_op * const btrfs_compress_op[] = {
@@ -939,6 +938,22 @@ static struct list_head *alloc_workspace(int type, unsigned int level)
 	}
 }
 
+static void free_workspace(int type, struct list_head *ws)
+{
+	switch (type) {
+	case BTRFS_COMPRESS_NONE: return free_heuristic_ws(ws);
+	case BTRFS_COMPRESS_ZLIB: return zlib_free_workspace(ws);
+	case BTRFS_COMPRESS_LZO:  return lzo_free_workspace(ws);
+	case BTRFS_COMPRESS_ZSTD: return zstd_free_workspace(ws);
+	default:
+		/*
+		 * This can't happen, the type is validated several times
+		 * before we get here.
+		 */
+		BUG();
+	}
+}
+
 static void btrfs_init_workspace_manager(int type)
 {
 	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
@@ -976,7 +991,7 @@ static void btrfs_cleanup_workspace_manager(int type)
 	while (!list_empty(&wsman->idle_ws)) {
 		ws = wsman->idle_ws.next;
 		list_del(ws);
-		wsman->ops->free_workspace(ws);
+		free_workspace(type, ws);
 		atomic_dec(&wsman->total_ws);
 	}
 }
@@ -1111,7 +1126,7 @@ void btrfs_put_workspace(int type, struct list_head *ws)
 	}
 	spin_unlock(ws_lock);
 
-	wsm->ops->free_workspace(ws);
+	free_workspace(type, ws);
 	atomic_dec(total_ws);
 wake:
 	cond_wake_up(ws_wait);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 664b029cd5e4..14057498dcbb 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -124,8 +124,6 @@ struct list_head *btrfs_get_workspace(int type, unsigned int level);
 void btrfs_put_workspace(int type, struct list_head *ws);
 
 struct btrfs_compress_op {
-	void (*free_workspace)(struct list_head *workspace);
-
 	struct workspace_manager *workspace_manager;
 	/* Maximum level supported by the compression algorithm */
 	unsigned int max_level;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 39b2cf80f77c..aa9cd11f4b78 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -484,7 +484,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.free_workspace		= lzo_free_workspace,
 	.max_level		= 1,
 	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c5dfab3ab082..a6c90a003c12 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -400,7 +400,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.free_workspace		= zlib_free_workspace,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
 };
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 9413f741c2f6..9a4871636c6c 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -708,7 +708,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.free_workspace = zstd_free_workspace,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.23.0

