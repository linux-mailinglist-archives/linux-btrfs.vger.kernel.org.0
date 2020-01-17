Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCF140B74
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAQNsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41398 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so22667624qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7kCud9wI21SwngVu1c4B7RnYUDpjvLC2M9X0p3fTqzA=;
        b=0SsbBDQ6K7LfL08dv1Y1A7t42mfVlg1dMH0m+lqfaA8So4HEsIaQxoJXx/p/0FrDyT
         8GHjd/tBg24FzmX2sUXH0uZY4Yi8RwDDtugsl6fUUyMztqi6S0+n8XeY9F4S6WgmY1C8
         Zbqj8nr1hBSRMyaYsr05rcqG8OsPPG0FUR+5jPWwWIw27Zba/nlnOpd0pFV6mL6hwJ/y
         N76NCxxN9S6qorz6ni5fpOEarLPgjAl0kENXBDA895csNbvFYKDhbNNic5FXl07Y2MI1
         8HMKOJoiBOAAHFZQng8s9vibQaJq62/E5ztE/JH+kLbXYcbDuA0IdCpSOkTQAxXonJMc
         T+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kCud9wI21SwngVu1c4B7RnYUDpjvLC2M9X0p3fTqzA=;
        b=mvTMIutdwun3ljTsuYbdFZVmBVF0LXH/ekoY7+b0sra5lH04/VPkvoUviyJqgHIeFR
         jOCcZw9xLyhHIkEm/9UpRm4zPI4AJHqJJ1eNsDkpRXnaG9bOyjR1PRqrzYdwyaCa5Src
         JXYQSxCy2mCCQGL6U1/zudsYYInCyVv+HjLWL4W0cuK1dN7hwYf1jgbp7zCwiBluVG5n
         XNo/YtjDOeQSHhK1/fsesxqRrpDTsFscN/TDEKT2g9V+pQmmYfNXWKvWfPPRPMzMBPY6
         cCrjURPpA6nwaKFUADLya5UU3pQ8eltGgMBWZq6lkCvAqRjtqUFqsRLOcSoIA84o6HM+
         /xCA==
X-Gm-Message-State: APjAAAVvU9FTqQ3ksNMcuQ2qt1ALFocs+e5P7GR7ZtzVR+e63g3lFVTG
        HPAyPwu2xGQ/bCBprXOuA5UBMs+ty5qX6Q==
X-Google-Smtp-Source: APXvYqzJ3Oqk4cTQFxPk9oGoBeLf0tPtmF9/5yGRWoXDsYZZ/FI0s4Sd7ojeV/rnbuuqeiKCKk8J1w==
X-Received: by 2002:a05:620a:13da:: with SMTP id g26mr39179559qkl.410.1579268916263;
        Fri, 17 Jan 2020 05:48:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n20sm11472897qkk.54.2020.01.17.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/43] btrfs: hold a ref on the root in build_backref_tree
Date:   Fri, 17 Jan 2020 08:47:36 -0500
Message-Id: <20200117134758.41494-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index aa3aa8e0c0ea..05a301204fd9 100644
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

