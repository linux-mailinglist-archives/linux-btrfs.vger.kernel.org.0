Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63E187AEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgCQIMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:42620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQIMX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D098BADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 17/39] btrfs: Move backref_cache_init() to backref.c
Date:   Tue, 17 Mar 2020 16:11:03 +0800
Message-Id: <20200317081125.36289-18-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 16 ++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 16 ----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 45cd8d998e40..2f1a60760342 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2468,3 +2468,19 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 						path->slots[0]);
 	return 0;
 }
+
+void backref_cache_init(struct btrfs_fs_info *fs_info,
+			struct backref_cache *cache, int is_reloc)
+{
+	int i;
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
index f119fc7022ab..7c81fed555d7 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -269,4 +269,6 @@ struct backref_cache {
 	unsigned int is_reloc;
 };
 
+void backref_cache_init(struct btrfs_fs_info *fs_info,
+			struct backref_cache *cache, int is_reloc);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 41723b0fc512..2e54251b9129 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -185,22 +185,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_init(struct btrfs_fs_info *fs_info,
-			       struct backref_cache *cache, int is_reloc)
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
 static void backref_cache_cleanup(struct backref_cache *cache)
 {
 	struct backref_node *node;
-- 
2.25.1

