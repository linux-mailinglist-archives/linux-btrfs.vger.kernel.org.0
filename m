Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2B18F2B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCWKZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A292ADF1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/40] btrfs: Rename backref_cache_init() to btrfs_backref_cache_init() and move it to backref.c
Date:   Mon, 23 Mar 2020 18:23:54 +0800
Message-Id: <20200323102416.112862-19-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 17 +++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 18 +-----------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index aee06eff3a04..3a54226b22da 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2467,3 +2467,20 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 						path->slots[0]);
 	return 0;
 }
+
+void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
+			      struct btrfs_backref_cache *cache, int is_reloc)
+{
+	int i;
+
+	cache->rb_root = RB_ROOT;
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
+		INIT_LIST_HEAD(&cache->pending[i]);
+	INIT_LIST_HEAD(&cache->changed);
+	INIT_LIST_HEAD(&cache->detached);
+	INIT_LIST_HEAD(&cache->leaves);
+	INIT_LIST_HEAD(&cache->pending_edge);
+	INIT_LIST_HEAD(&cache->useless_node);
+	cache->fs_info = fs_info;
+	cache->is_reloc = is_reloc;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 4908f47ed84d..39b1532413aa 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -268,4 +268,6 @@ struct btrfs_backref_cache {
 	unsigned int is_reloc;
 };
 
+void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
+			      struct btrfs_backref_cache *cache, int is_reloc);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6c7e409662a4..b7536deb6d5e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -185,22 +185,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_init(struct btrfs_fs_info *fs_info,
-			       struct btrfs_backref_cache *cache, int is_reloc)
-{
-	int i;
-	cache->rb_root = RB_ROOT;
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		INIT_LIST_HEAD(&cache->pending[i]);
-	INIT_LIST_HEAD(&cache->changed);
-	INIT_LIST_HEAD(&cache->detached);
-	INIT_LIST_HEAD(&cache->leaves);
-	INIT_LIST_HEAD(&cache->pending_edge);
-	INIT_LIST_HEAD(&cache->useless_node);
-	cache->fs_info = fs_info;
-	cache->is_reloc = is_reloc;
-}
-
 static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
 {
 	struct btrfs_backref_node *node;
@@ -4356,7 +4340,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
-	backref_cache_init(fs_info, &rc->backref_cache, 1);
+	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
 	mapping_tree_init(&rc->reloc_root_tree);
 	extent_io_tree_init(fs_info, &rc->processed_blocks,
 			    IO_TREE_RELOC_BLOCKS, NULL);
-- 
2.25.2

