Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6311537F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfLFOqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32929 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfLFOqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id c124so6706211qkg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NxeCtVzdZRt08c2KEp652MF/MxB6kCndMLtWPCVne6s=;
        b=Q8SnzfxUIUCRryxt2W8G6d6zrL5sn/QTPyAfTFOB3mBBmltH2rfkZV+u9pBaEw8oie
         JhDN+Wu7k/h8kRe/SmedoS3PbPPT/aDWT2VBBthRNq204rwIRf1KtJRLmJt4uRacNLSQ
         7PYR9spoFWKJdz2Bk9jWMBUOP/cOX9YR1/tn7VWTg97QAx1BZ7iVCABltN369vgauuwc
         5SnFuQCIglQxao0j+fqX0j97AYQke75oilzQOGwoQ3R1W9YeGk6H45iFXGHdF28R24qM
         0JDa/rV0TRtuxG/VrrEoxmqB2v8qyXixe0ZXufhepfXxA+fvBBR9l+7s7xAqBPf5rcbl
         df8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxeCtVzdZRt08c2KEp652MF/MxB6kCndMLtWPCVne6s=;
        b=SxVqEU7wzov7sWmteZ0nHElCxKb/ZOmmkemQ0/eCQUqXI4DAT+hr39dYFrj2nE7z0b
         GxpXy31LcQj5huxZM+Q2prHXY9GyYmDZBC41G6yBPJqDxcYo5q97PgkRudNIfv0uATga
         iyI5aGF5eTTjNjup+4ctT0GszktG8RmHdLeFkFKVm6lETnMf2wTcJPLVtVhG0LpBC1rZ
         1tG6bdFiGml5GUTzdt1Lwd8K2gNF7RPxeaqX3QznQsGJ5pMlOWjni3oVS0RhZaDeRrxx
         /F/Jp33uhuGzsys3V419/U6NhMA6spD0hvsrLO1hT3nym0EllL2V9LAwvLqOC4jJEUkO
         QFEw==
X-Gm-Message-State: APjAAAWXVTqtslqTSU44pucuILSURriyWL6YHqqj0ZvLQh4wXPQ3kF+w
        YH5CkAp4lqVM2YS7wuTzuMsyN4G8UEC6SQ==
X-Google-Smtp-Source: APXvYqzRb0mBql4Ly/5QudSsJ61k5eNI1dKFilApVmh3F42sDhjAVng7XRyvGmhZFuiRmHUj5b0aew==
X-Received: by 2002:a05:620a:685:: with SMTP id f5mr12946046qkh.201.1575643581796;
        Fri, 06 Dec 2019 06:46:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z12sm1305554qki.64.2019.12.06.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/44] btrfs: hold a ref on the root in build_backref_tree
Date:   Fri,  6 Dec 2019 09:45:17 -0500
Message-Id: <20191206144538.168112-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

