Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04039176FCF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCCHPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:56794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgCCHPR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD2D8AC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/19] btrfs: Move backref_cache_init() to backref.c
Date:   Tue,  3 Mar 2020 15:13:56 +0800
Message-Id: <20200303071409.57982-7-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
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
index 01674be3beaa..8fc1d520695e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2444,3 +2444,19 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 							    path->slots[0]);
 	return 0;
 }
+
+void backref_cache_init(struct btrfs_fs_info *fs_info,
+			struct backref_cache *cache, int is_reloc)
+{
+	int i;
+	cache->rb_root = RB_ROOT;
+	cache->fs_info = fs_info;
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
+		INIT_LIST_HEAD(&cache->pending[i]);
+	INIT_LIST_HEAD(&cache->changed);
+	INIT_LIST_HEAD(&cache->detached);
+	INIT_LIST_HEAD(&cache->leaves);
+	cache->is_reloc = is_reloc;
+	INIT_LIST_HEAD(&cache->pending_edge);
+	INIT_LIST_HEAD(&cache->useless_node);
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index e1438425cf59..65e886fb2008 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -290,4 +290,6 @@ struct backref_cache {
 	struct btrfs_fs_info *fs_info;
 };
 
+void backref_cache_init(struct btrfs_fs_info *fs_info,
+			struct backref_cache *cache, int is_reloc);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0fb9ceb2665e..4ec2946f95ae 100644
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
-	cache->fs_info = fs_info;
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		INIT_LIST_HEAD(&cache->pending[i]);
-	INIT_LIST_HEAD(&cache->changed);
-	INIT_LIST_HEAD(&cache->detached);
-	INIT_LIST_HEAD(&cache->leaves);
-	cache->is_reloc = is_reloc;
-	INIT_LIST_HEAD(&cache->pending_edge);
-	INIT_LIST_HEAD(&cache->useless_node);
-}
-
 static void backref_cache_cleanup(struct backref_cache *cache)
 {
 	struct backref_node *node;
-- 
2.25.1

