Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB7193AF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCZIeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgCZIeG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B74BACAE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 21/39] btrfs: Rename link_backref_edge() to btrfs_backref_link_edge() and move it backref.h
Date:   Thu, 26 Mar 2020 16:32:58 +0800
Message-Id: <20200326083316.48847-22-wqu@suse.com>
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
 fs/btrfs/backref.h    | 16 ++++++++++++++++
 fs/btrfs/relocation.c | 23 ++++-------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index f04b366144ad..c09fd4024cc2 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -278,4 +278,20 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 		struct btrfs_backref_cache *cache, u64 bytenr, int level);
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		struct btrfs_backref_cache *cache);
+
+#define		LINK_LOWER	(1 << 0)
+#define		LINK_UPPER	(1 << 1)
+static inline void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
+					   struct btrfs_backref_node *lower,
+					   struct btrfs_backref_node *upper,
+					   int link_which)
+{
+	ASSERT(upper && lower && upper->level == lower->level + 1);
+	edge->node[LOWER] = lower;
+	edge->node[UPPER] = upper;
+	if (link_which & LINK_LOWER)
+		list_add_tail(&edge->list[LOWER], &lower->upper);
+	if (link_which & LINK_UPPER)
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+}
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 87bc0b20cbfd..3a95f5cd353a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -218,21 +218,6 @@ static void free_backref_node(struct btrfs_backref_cache *cache,
 	}
 }
 
-#define		LINK_LOWER	(1 << 0)
-#define		LINK_UPPER	(1 << 1)
-static void link_backref_edge(struct btrfs_backref_edge *edge,
-			      struct btrfs_backref_node *lower,
-			      struct btrfs_backref_node *upper,
-			      int link_which)
-{
-	ASSERT(upper && lower && upper->level == lower->level + 1);
-	edge->node[LOWER] = lower;
-	edge->node[UPPER] = upper;
-	if (link_which & LINK_LOWER)
-		list_add_tail(&edge->list[LOWER], &lower->upper);
-	if (link_which & LINK_UPPER)
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-}
 
 static void free_backref_edge(struct btrfs_backref_cache *cache,
 			      struct btrfs_backref_edge *edge)
@@ -596,7 +581,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		ASSERT(upper->checked);
 		INIT_LIST_HEAD(&edge->list[UPPER]);
 	}
-	link_backref_edge(edge, cur, upper, LINK_LOWER);
+	btrfs_backref_link_edge(edge, cur, upper, LINK_LOWER);
 	return 0;
 }
 
@@ -741,7 +726,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 			if (!upper->owner)
 				upper->owner = btrfs_header_owner(eb);
 		}
-		link_backref_edge(edge, lower, upper, LINK_LOWER);
+		btrfs_backref_link_edge(edge, lower, upper, LINK_LOWER);
 
 		if (rb_node) {
 			btrfs_put_root(root);
@@ -1256,8 +1241,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 			if (!new_edge)
 				goto fail;
 
-			link_backref_edge(new_edge, edge->node[LOWER], new_node,
-					  LINK_UPPER);
+			btrfs_backref_link_edge(new_edge, edge->node[LOWER],
+						new_node, LINK_UPPER);
 		}
 	} else {
 		list_add_tail(&new_node->lower, &cache->leaves);
-- 
2.26.0

