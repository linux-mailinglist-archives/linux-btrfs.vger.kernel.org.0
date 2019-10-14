Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043D3D6263
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfJNMWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfJNMWS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D4BABDA4;
        Mon, 14 Oct 2019 12:22:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F283FDA7E3; Mon, 14 Oct 2019 14:22:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/15] btrfs: compression: attach workspace manager to the ops
Date:   Mon, 14 Oct 2019 14:22:28 +0200
Message-Id: <cf0b8745c5aada29f9431a66777f1af5bb4d382f.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a lot of indirection when the generic code calls into
algo-specific callbacks to reach the private workspace manager structure
and back to the generic code.

To simplify that, export the workspace manager for heuristic, LZO and
ZLIB, while ZSTD is going to use it's own manager.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 1 +
 fs/btrfs/compression.h | 1 +
 fs/btrfs/lzo.c         | 1 +
 fs/btrfs/zlib.c        | 1 +
 fs/btrfs/zstd.c        | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 87bac8f73a99..e650125b1d2b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -920,6 +920,7 @@ static struct list_head *alloc_heuristic_ws(unsigned int level)
 }
 
 const struct btrfs_compress_op btrfs_heuristic_compress = {
+	.workspace_manager = &heuristic_wsm,
 	.init_workspace_manager = heuristic_init_workspace_manager,
 	.cleanup_workspace_manager = heuristic_cleanup_workspace_manager,
 	.get_workspace = heuristic_get_workspace,
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 7db14d3166b5..7091eae063e5 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -140,6 +140,7 @@ struct btrfs_compress_op {
 
 	void (*free_workspace)(struct list_head *workspace);
 
+	struct workspace_manager *workspace_manager;
 	/* Maximum level supported by the compression algorithm */
 	unsigned int max_level;
 	unsigned int default_level;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 9417944ec829..aff105cc80e7 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -503,6 +503,7 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 }
 
 const struct btrfs_compress_op btrfs_lzo_compress = {
+	.workspace_manager	= &wsm,
 	.init_workspace_manager	= lzo_init_workspace_manager,
 	.cleanup_workspace_manager = lzo_cleanup_workspace_manager,
 	.get_workspace		= lzo_get_workspace,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8bb6f19ab369..a5e8f0207473 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -414,6 +414,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 }
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
+	.workspace_manager	= &wsm,
 	.init_workspace_manager	= zlib_init_workspace_manager,
 	.cleanup_workspace_manager = zlib_cleanup_workspace_manager,
 	.get_workspace		= zlib_get_workspace,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 5f17c741d167..4791e89e43e3 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -707,6 +707,8 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 }
 
 const struct btrfs_compress_op btrfs_zstd_compress = {
+	/* ZSTD uses own workspace manager */
+	.workspace_manager = NULL,
 	.init_workspace_manager = zstd_init_workspace_manager,
 	.cleanup_workspace_manager = zstd_cleanup_workspace_manager,
 	.get_workspace = zstd_get_workspace,
-- 
2.23.0

