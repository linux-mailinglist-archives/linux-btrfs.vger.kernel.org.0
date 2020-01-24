Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0E14893C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404568AbgAXOdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404404AbgAXOdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so1607096qte.12
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=waR2Lt/X4+7LzUw69Y9pUyuaF2RLHp3vzC1zQ/caxek=;
        b=VPhQSrsoltF/mUQ7kTvxZJbxRsIM+wfv+EobWib/YUE1MCDy6gevDoRCS2Ptke0aXw
         hnmImqpejSpjDFkr7gIzdq6ZY4ZfHU6GadKg+vrDuhr5DGHkIwv04JTgV+WKAHhaSE/0
         TPelI7G9vkn21i0tyS0vOYbOGWqBjDkWLz+3VXIaoCVXMOvBvGJN8HaqbkDVCoavYE+F
         PZAVWPBzJ8Q1dXDPps68wvXRljZioyZQLgSMQ3jQF2t3Qw0VcHLayJ0mKliqj+nKoxvx
         30Jp2juQyjzvhHY1z419hR+Ms7wcpjXrETbLJdyvnjU64oRmZFJPgww326jLsV3zRD0m
         oSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waR2Lt/X4+7LzUw69Y9pUyuaF2RLHp3vzC1zQ/caxek=;
        b=nwG/tcVG5WtgKl4OyDZyHyHsgA8zWupBJW6pcTa4q36Zf2DCakoZwiDNca6ORUBfXU
         jglgUDeqrfjvW60EqEw8kxRKEVrG8K+nXeFk3svdNbleaZ5UCeNmtNqleRRrBSPQBR13
         2Q5uePmOARfu3Jy40fztB0USEwxFtQgqtFweTmD68S/2o0WwsJZ1OWwLFwLi8vNMY9aB
         4PAZqn88Y0TnJ6R5GuoEyfYOpTrvHWnPlmfAw3YjXhqKHi2YJEJPkmLhxnWh+u2tVuY+
         rmU9vgMKU0RCnKLSv09FXUaW/24eBSBUScTqTLiczA9vIjzxHqDPacGaCXqgNCMq6lod
         OtFg==
X-Gm-Message-State: APjAAAVVHmxVW+yX6wf71sS9wwS+yTbV8Tqe64jJZEQEzgwk1cQ4zoZ8
        7yaHwjAwcXimgo7KGv+0X0E22Ir6OdfSMg==
X-Google-Smtp-Source: APXvYqy60iFT8/jQYghtXY5tYyJwAh/oY4TbXT2rRwbXv9alWFBsNxBo7UO3joqjo0C6WYS7+zcB/w==
X-Received: by 2002:ac8:2647:: with SMTP id v7mr2422479qtv.219.1579876418134;
        Fri, 24 Jan 2020 06:33:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j15sm3190027qtn.37.2020.01.24.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 21/44] btrfs: hold a ref on the root in build_backref_tree
Date:   Fri, 24 Jan 2020 09:32:38 -0500
Message-Id: <20200124143301.2186319-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is trickier than the previous conversions.  We have backref_node's
that need to hold onto their root for their lifetime.  Do the read of
the root and grab the ref.  If at any point we don't use the root we
discard it, however if we use it in our backref node we don't free it
until we free the backref node.  Any time we switch the root's for the
backref node we need to drop our ref on the old root and grab the ref on
the new root, and if we dupe a node we need to get a ref on the root
there as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index aa3aa8e0c0ea..990595a27a15 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -256,6 +256,8 @@ static void free_backref_node(struct backref_cache *cache,
 {
 	if (node) {
 		cache->nr_nodes--;
+		if (node->root)
+			btrfs_put_fs_root(node->root);
 		kfree(node);
 	}
 }
@@ -589,7 +591,7 @@ static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
 		root = (struct btrfs_root *)node->data;
 	}
 	spin_unlock(&rc->reloc_root_tree.lock);
-	return root;
+	return btrfs_grab_fs_root(root);
 }
 
 static int is_cowonly_root(u64 root_objectid)
@@ -891,6 +893,10 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			err = PTR_ERR(root);
 			goto out;
 		}
+		if (!btrfs_grab_fs_root(root)) {
+			err = -ENOENT;
+			goto out;
+		}
 
 		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 			cur->cowonly = 1;
@@ -899,10 +905,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			/* tree root */
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       cur->bytenr);
-			if (should_ignore_root(root))
+			if (should_ignore_root(root)) {
+				btrfs_put_fs_root(root);
 				list_add(&cur->list, &useless);
-			else
+			} else {
 				cur->root = root;
+			}
 			break;
 		}
 
@@ -915,6 +923,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
 		path2->lowest_level = 0;
 		if (ret < 0) {
+			btrfs_put_fs_root(root);
 			err = ret;
 			goto out;
 		}
@@ -930,6 +939,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				  root->root_key.objectid,
 				  node_key->objectid, node_key->type,
 				  node_key->offset);
+			btrfs_put_fs_root(root);
 			err = -ENOENT;
 			goto out;
 		}
@@ -941,15 +951,18 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			if (!path2->nodes[level]) {
 				ASSERT(btrfs_root_bytenr(&root->root_item) ==
 				       lower->bytenr);
-				if (should_ignore_root(root))
+				if (should_ignore_root(root)) {
+					btrfs_put_fs_root(root);
 					list_add(&lower->list, &useless);
-				else
+				} else {
 					lower->root = root;
+				}
 				break;
 			}
 
 			edge = alloc_backref_edge(cache);
 			if (!edge) {
+				btrfs_put_fs_root(root);
 				err = -ENOMEM;
 				goto out;
 			}
@@ -959,6 +972,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			if (!rb_node) {
 				upper = alloc_backref_node(cache);
 				if (!upper) {
+					btrfs_put_fs_root(root);
 					free_backref_edge(cache, edge);
 					err = -ENOMEM;
 					goto out;
@@ -1006,8 +1020,10 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			edge->node[LOWER] = lower;
 			edge->node[UPPER] = upper;
 
-			if (rb_node)
+			if (rb_node) {
+				btrfs_put_fs_root(root);
 				break;
+			}
 			lower = upper;
 			upper = NULL;
 		}
@@ -1244,7 +1260,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	new_node->level = node->level;
 	new_node->lowest = node->lowest;
 	new_node->checked = 1;
-	new_node->root = dest;
+	new_node->root = btrfs_grab_fs_root(dest);
+	ASSERT(new_node->root);
 
 	if (!node->lowest) {
 		list_for_each_entry(edge, &node->lower, list[UPPER]) {
@@ -2622,7 +2639,9 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			BUG_ON(next->new_bytenr);
 			BUG_ON(!list_empty(&next->list));
 			next->new_bytenr = root->node->start;
-			next->root = root;
+			btrfs_put_fs_root(next->root);
+			next->root = btrfs_grab_fs_root(root);
+			ASSERT(next->root);
 			list_add_tail(&next->list,
 				      &rc->backref_cache.changed);
 			__mark_block_processed(rc, next);
@@ -3094,7 +3113,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-			node->root = root;
+			btrfs_put_fs_root(node->root);
+			node->root = btrfs_grab_fs_root(root);
+			ASSERT(node->root);
 			list_add_tail(&node->list, &rc->backref_cache.changed);
 		} else {
 			path->lowest_level = node->level;
-- 
2.24.1

