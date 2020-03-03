Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83174176FD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCCHPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgCCHPT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64D4AB016
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/19] btrfs: Move alloc_backref_node() to backref.c
Date:   Tue,  3 Mar 2020 15:13:57 +0800
Message-Id: <20200303071409.57982-8-wqu@suse.com>
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
 fs/btrfs/backref.c    | 20 ++++++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 20 --------------------
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8fc1d520695e..b6183cb7c60b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2460,3 +2460,23 @@ void backref_cache_init(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->pending_edge);
 	INIT_LIST_HEAD(&cache->useless_node);
 }
+
+struct backref_node *alloc_backref_node(struct backref_cache *cache,
+					u64 bytenr, int level)
+{
+	struct backref_node *node;
+
+	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
+	node = kzalloc(sizeof(*node), GFP_NOFS);
+	if (node) {
+		INIT_LIST_HEAD(&node->list);
+		INIT_LIST_HEAD(&node->upper);
+		INIT_LIST_HEAD(&node->lower);
+		RB_CLEAR_NODE(&node->rb_node);
+		cache->nr_nodes++;
+
+		node->level = level;
+		node->bytenr = bytenr;
+	}
+	return node;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 65e886fb2008..b7aad5f116ae 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -292,4 +292,6 @@ struct backref_cache {
 
 void backref_cache_init(struct btrfs_fs_info *fs_info,
 			struct backref_cache *cache, int is_reloc);
+struct backref_node *alloc_backref_node(struct backref_cache *cache,
+					u64 bytenr, int level);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ec2946f95ae..f97ff88dba21 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -215,26 +215,6 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static struct backref_node *alloc_backref_node(struct backref_cache *cache,
-						u64 bytenr, int level)
-{
-	struct backref_node *node;
-
-	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
-	node = kzalloc(sizeof(*node), GFP_NOFS);
-	if (node) {
-		INIT_LIST_HEAD(&node->list);
-		INIT_LIST_HEAD(&node->upper);
-		INIT_LIST_HEAD(&node->lower);
-		RB_CLEAR_NODE(&node->rb_node);
-		cache->nr_nodes++;
-
-		node->level = level;
-		node->bytenr = bytenr;
-	}
-	return node;
-}
-
 static void free_backref_node(struct backref_cache *cache,
 			      struct backref_node *node)
 {
-- 
2.25.1

