Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6D193AEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCZIeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgCZIeA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5806BACAE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:33:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/39] btrfs: Rename backref_cache_init() to btrfs_backref_cache_init() and move it to backref.c
Date:   Thu, 26 Mar 2020 16:32:55 +0800
Message-Id: <20200326083316.48847-19-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
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
index a1044f093f6c..997f609c97f8 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2463,3 +2463,20 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
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
index f3eae9e9f84b..25a0b1a5ce32 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -272,4 +272,6 @@ struct btrfs_backref_cache {
 	unsigned int is_reloc;
 };
 
+void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
+			      struct btrfs_backref_cache *cache, int is_reloc);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d62537792ac0..1fa7c4a67f3d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -178,22 +178,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
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
@@ -4215,7 +4199,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
-	backref_cache_init(fs_info, &rc->backref_cache, 1);
+	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
 	mapping_tree_init(&rc->reloc_root_tree);
 	extent_io_tree_init(fs_info, &rc->processed_blocks,
 			    IO_TREE_RELOC_BLOCKS, NULL);
-- 
2.26.0

