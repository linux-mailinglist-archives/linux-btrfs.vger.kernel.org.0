Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973ADD6273
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJNMWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731987AbfJNMWj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53A16BE8B;
        Mon, 14 Oct 2019 12:22:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7C01DA7E3; Mon, 14 Oct 2019 14:22:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 12/15] btrfs: compression: inline alloc_workspace
Date:   Mon, 14 Oct 2019 14:22:49 +0200
Message-Id: <bf7c46e37cfbf4ceafeee95e2e6c15a67755f4b9.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace indirect calls to alloc_workspace by switch and calls to the
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
index ffc94e15d86e..4a8dab961f88 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -912,7 +912,6 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
 	.workspace_manager = &heuristic_wsm,
-	.alloc_workspace = alloc_heuristic_ws,
 	.free_workspace = free_heuristic_ws,
 };
 
@@ -924,6 +923,22 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	&btrfs_zstd_compress,
 };
 
+static struct list_head *alloc_workspace(int type, unsigned int level)
+{
+	switch (type) {
+	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(level);
+	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(level);
+	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(level);
+	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(level);
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
@@ -941,7 +956,7 @@ static void btrfs_init_workspace_manager(int type)
 	 * Preallocate one workspace for each compression type so we can
 	 * guarantee forward progress in the worst case
 	 */
-	workspace = wsm->ops->alloc_workspace(0);
+	workspace = alloc_workspace(type, 0);
 	if (IS_ERR(workspace)) {
 		pr_warn(
 	"BTRFS: cannot preallocate compression workspace, will try later\n");
@@ -1020,7 +1035,7 @@ struct list_head *btrfs_get_workspace(int type, unsigned int level)
 	 * context of btrfs_compress_bio/btrfs_compress_pages
 	 */
 	nofs_flag = memalloc_nofs_save();
-	workspace = wsm->ops->alloc_workspace(level);
+	workspace = alloc_workspace(type, level);
 	memalloc_nofs_restore(nofs_flag);
 
 	if (IS_ERR(workspace)) {
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index accb1d61df87..8336c2ef6b5a 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -124,8 +124,6 @@ struct list_head *btrfs_get_workspace(int type, unsigned int level);
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
 
 struct btrfs_compress_op {
-	struct list_head *(*alloc_workspace)(unsigned int level);
-
 	void (*free_workspace)(struct list_head *workspace);
 
 	struct workspace_manager *workspace_manager;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index bbf917c5ff2d..39b2cf80f77c 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -484,7 +484,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.workspace_manager	= &wsm,
-	.alloc_workspace	= lzo_alloc_workspace,
 	.free_workspace		= lzo_free_workspace,
 	.max_level		= 1,
 	.default_level		= 1,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 5679a2e41a52..c5dfab3ab082 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -400,7 +400,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
-	.alloc_workspace	= zlib_alloc_workspace,
 	.free_workspace		= zlib_free_workspace,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index a346f1187fae..9413f741c2f6 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -708,7 +708,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
-	.alloc_workspace = zstd_alloc_workspace,
 	.free_workspace = zstd_free_workspace,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
-- 
2.23.0

