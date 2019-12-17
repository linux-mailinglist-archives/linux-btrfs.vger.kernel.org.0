Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C35123088
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfLQPhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37409 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so5850491qky.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NxeCtVzdZRt08c2KEp652MF/MxB6kCndMLtWPCVne6s=;
        b=S/1j+hfFneH6bihaM0xY1zgFvG2v1mmulOfP7BDdprcdoVh0SBiUrY95aim+DNRjVR
         HKQ+QzxMlZh4joSyOD1xRJGTUaiAEOpKTuHqWwdJg8u4ORRXyeUVD5U+ma1WzGQTDtmV
         vAbGWjAILVF2Rr8kDFZdCbHlVs6UsaJfuf11gtYAJHzciZ40Q1BB9HSSh0jrWFoOW9FZ
         R/BTPkw/F9S32uC/dGVgVS74fCjHfE4p6FJfbal9jfJXvm68OHQoHOIEDtU3cA3T4Ctj
         7vTGAflTtrLhIxphZL4d2ji9e6/Rx23QeM8R/RuoXNzACgqRwv9KJnXT1oYwGEi6TTs8
         FoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxeCtVzdZRt08c2KEp652MF/MxB6kCndMLtWPCVne6s=;
        b=TLGnnAhlT0jYEMowVBo7lo5qryyYYj6L8tRAHtC9mjkX5CrEPnYOyRwnZ4/JHqEjsm
         dylRLLELtTrsUExgjH3lNAJkbW/rmK1E3MCnQ19oWIwqP3z5FwgL2cALmwzL+zX8nuTO
         tpsgd9dEp3KoL09UW5iurV8t5Plq6N62Z8zRvtG12yl7FRGAh3rgaZ3hRjKvZCsZ4Ccv
         TwMq730Z/aUEhTkL65vmL78XSpCM5EsFPtsIevfRe2kZJZ5pe1H8T8kz4whV07+tft6J
         FEr/u6iCNeIJJlcsz9p7H9tD+bZc+wzjPT2m2Yu40gMie70S+fX0Ewbkay734WtHAZQV
         vCbA==
X-Gm-Message-State: APjAAAXnmjrKo7Cj+u04OpCZWY1m6TfG9WZhyr1OXBEM9uKG+i6yAjnm
        Ts/5jczp8tTuwrv7r0qriFQW5PlmpcRpOw==
X-Google-Smtp-Source: APXvYqwrYmBlC9sKknDIH/e3pK0MTiAV9igpmLIB5se0FgmVNCC2XbhZlOWDE9/70MyBLurTQ8IqWw==
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr5497723qkj.116.1576597039956;
        Tue, 17 Dec 2019 07:37:19 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o16sm5979676qkj.91.2019.12.17.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/45] btrfs: hold a ref on the root in build_backref_tree
Date:   Tue, 17 Dec 2019 10:36:13 -0500
Message-Id: <20191217153635.44733-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3f11491e01eb..473bbbd58d31 100644
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
@@ -859,6 +861,10 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			err = PTR_ERR(root);
 			goto out;
 		}
+		if (!btrfs_grab_fs_root(root)) {
+			err = -ENOENT;
+			goto out;
+		}
 
 		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 			cur->cowonly = 1;
@@ -867,10 +873,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
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
 
@@ -883,6 +891,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
 		path2->lowest_level = 0;
 		if (ret < 0) {
+			btrfs_put_fs_root(root);
 			err = ret;
 			goto out;
 		}
@@ -898,6 +907,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				  root->root_key.objectid,
 				  node_key->objectid, node_key->type,
 				  node_key->offset);
+			btrfs_put_fs_root(root);
 			err = -ENOENT;
 			goto out;
 		}
@@ -909,15 +919,18 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
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
@@ -927,6 +940,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			if (!rb_node) {
 				upper = alloc_backref_node(cache);
 				if (!upper) {
+					btrfs_put_fs_root(root);
 					free_backref_edge(cache, edge);
 					err = -ENOMEM;
 					goto out;
@@ -974,8 +988,10 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
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
@@ -1212,7 +1228,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	new_node->level = node->level;
 	new_node->lowest = node->lowest;
 	new_node->checked = 1;
-	new_node->root = dest;
+	new_node->root = btrfs_grab_fs_root(dest);
+	ASSERT(new_node->root);
 
 	if (!node->lowest) {
 		list_for_each_entry(edge, &node->lower, list[UPPER]) {
@@ -2581,7 +2598,9 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
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
@@ -3053,7 +3072,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
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
2.23.0

