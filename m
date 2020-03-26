Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD6193AF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCZIeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgCZIeE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BD74AC69
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 20/39] btrfs: Rename alloc_backref_edge() to btrfs_backref_alloc_edge() and move it backref.c
Date:   Thu, 26 Mar 2020 16:32:57 +0800
Message-Id: <20200326083316.48847-21-wqu@suse.com>
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
 fs/btrfs/backref.c    | 11 +++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 17 +++--------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 079de971f302..9475b6ccc7eb 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2500,3 +2500,14 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 	node->bytenr = bytenr;
 	return node;
 }
+
+struct btrfs_backref_edge *btrfs_backref_alloc_edge(
+		struct btrfs_backref_cache *cache)
+{
+	struct btrfs_backref_edge *edge;
+
+	edge = kzalloc(sizeof(*edge), GFP_NOFS);
+	if (edge)
+		cache->nr_edges++;
+	return edge;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 54364fbec65b..f04b366144ad 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -276,4 +276,6 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 			      struct btrfs_backref_cache *cache, int is_reloc);
 struct btrfs_backref_node *btrfs_backref_alloc_node(
 		struct btrfs_backref_cache *cache, u64 bytenr, int level);
+struct btrfs_backref_edge *btrfs_backref_alloc_edge(
+		struct btrfs_backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4f22e9bd8e3c..87bc0b20cbfd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -218,17 +218,6 @@ static void free_backref_node(struct btrfs_backref_cache *cache,
 	}
 }
 
-static struct btrfs_backref_edge *alloc_backref_edge(
-		struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_edge *edge;
-
-	edge = kzalloc(sizeof(*edge), GFP_NOFS);
-	if (edge)
-		cache->nr_edges++;
-	return edge;
-}
-
 #define		LINK_LOWER	(1 << 0)
 #define		LINK_UPPER	(1 << 1)
 static void link_backref_edge(struct btrfs_backref_edge *edge,
@@ -581,7 +570,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		return 0;
 	}
 
-	edge = alloc_backref_edge(cache);
+	edge = btrfs_backref_alloc_edge(cache);
 	if (!edge)
 		return -ENOMEM;
 
@@ -699,7 +688,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 			break;
 		}
 
-		edge = alloc_backref_edge(cache);
+		edge = btrfs_backref_alloc_edge(cache);
 		if (!edge) {
 			btrfs_put_root(root);
 			ret = -ENOMEM;
@@ -1263,7 +1252,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 
 	if (!node->lowest) {
 		list_for_each_entry(edge, &node->lower, list[UPPER]) {
-			new_edge = alloc_backref_edge(cache);
+			new_edge = btrfs_backref_alloc_edge(cache);
 			if (!new_edge)
 				goto fail;
 
-- 
2.26.0

