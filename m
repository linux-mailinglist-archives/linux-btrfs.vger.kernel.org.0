Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79548193AE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCZIds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbgCZIds (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C04E5AD08;
        Thu, 26 Mar 2020 08:33:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 11/39] btrfs: relocation: Specify essential members for alloc_backref_node()
Date:   Thu, 26 Mar 2020 16:32:48 +0800
Message-Id: <20200326083316.48847-12-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Bytenr and level are essential parameters for backref_node, thus it
makes sense to initial them at alloc time.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a022b46804ff..1ea184e8afb2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -339,18 +339,23 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static struct backref_node *alloc_backref_node(struct backref_cache *cache)
+static struct backref_node *alloc_backref_node(struct backref_cache *cache,
+						u64 bytenr, int level)
 {
 	struct backref_node *node;
 
+	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
 	node = kzalloc(sizeof(*node), GFP_NOFS);
-	if (node) {
-		INIT_LIST_HEAD(&node->list);
-		INIT_LIST_HEAD(&node->upper);
-		INIT_LIST_HEAD(&node->lower);
-		RB_CLEAR_NODE(&node->rb_node);
-		cache->nr_nodes++;
-	}
+	if (!node)
+		return node;
+	INIT_LIST_HEAD(&node->list);
+	INIT_LIST_HEAD(&node->upper);
+	INIT_LIST_HEAD(&node->lower);
+	RB_CLEAR_NODE(&node->rb_node);
+	cache->nr_nodes++;
+
+	node->level = level;
+	node->bytenr = bytenr;
 	return node;
 }
 
@@ -775,13 +780,12 @@ static int handle_direct_tree_backref(struct backref_cache *cache,
 	rb_node = tree_search(&cache->rb_root, ref_key->offset);
 	if (!rb_node) {
 		/* Parent node not yet cached */
-		upper = alloc_backref_node(cache);
+		upper = alloc_backref_node(cache, ref_key->offset,
+					   cur->level + 1);
 		if (!upper) {
 			free_backref_edge(cache, edge);
 			return -ENOMEM;
 		}
-		upper->bytenr = ref_key->offset;
-		upper->level = cur->level + 1;
 
 		/*
 		 *  backrefs for the upper level block isn't
@@ -897,16 +901,15 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 		eb = path->nodes[level];
 		rb_node = tree_search(&cache->rb_root, eb->start);
 		if (!rb_node) {
-			upper = alloc_backref_node(cache);
+			upper = alloc_backref_node(cache, eb->start,
+						   lower->level + 1);
 			if (!upper) {
 				btrfs_put_root(root);
 				free_backref_edge(cache, edge);
 				ret = -ENOMEM;
 				goto out;
 			}
-			upper->bytenr = eb->start;
 			upper->owner = btrfs_header_owner(eb);
-			upper->level = lower->level + 1;
 			if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 				upper->cowonly = 1;
 
@@ -996,14 +999,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		goto out;
 	}
 
-	node = alloc_backref_node(cache);
+	node = alloc_backref_node(cache, bytenr, level);
 	if (!node) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	node->bytenr = bytenr;
-	node->level = level;
 	node->lowest = 1;
 	cur = node;
 again:
@@ -1346,12 +1347,10 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	if (!node)
 		return 0;
 
-	new_node = alloc_backref_node(cache);
+	new_node = alloc_backref_node(cache, dest->node->start, node->level);
 	if (!new_node)
 		return -ENOMEM;
 
-	new_node->bytenr = dest->node->start;
-	new_node->level = node->level;
 	new_node->lowest = node->lowest;
 	new_node->checked = 1;
 	new_node->root = btrfs_grab_root(dest);
-- 
2.26.0

