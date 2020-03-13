Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93BA1850DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCMVRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:17:20 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34974 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:17:19 -0400
Received: by mail-qv1-f65.google.com with SMTP id u10so5442653qvi.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=akRCjfl9I7cFVek0vSrA3nYHCMZiQYs0OOpn/itmBes=;
        b=eohvAJ40x8936pQ3uPy1vAae8AsvH0yUPzJ5YbwhN+2plLBDIm4oIYlQlxp3R6dtrD
         6A+qoczoQt0g83NS7yl+qcDjpTaBlI+113B1u3MvQyUenrwHmc1G1PLonOdXAcaotmBc
         I7LroerVkpkOWJ3qwlWgpSwPBShO5wr2NnER67mT3EyZOWe1eOs1NKgvzSS+3GaDhHWG
         SJjZo19OJAiYG8+Mkxz6/eqZoX0zzLxdGKEgmR/uNZoAs7ipXaojckE1snRSUOyZxIsq
         0NbnUECerkIsOvoUPorS2rx/h69AEOLkG4233oIZVZoKw2ROTdZYz9rm4B5JQRb8mH1i
         yo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akRCjfl9I7cFVek0vSrA3nYHCMZiQYs0OOpn/itmBes=;
        b=a6aEq7ZfPUB++XFPgZbCNws+szIp9AZQlbeKnXiQ/A+j3p0k4gC1EqahMstgr71duY
         Um15Ukg7Z0PDN1idCtmGwOYvfQ/QjeHUVRi+8R4Sg0XtCJbGiCGT7yqv1icu+/ZaoYhP
         w2r9WLKWG4lhUcyu22gwOPVGiTS7ZLlsPdNkDJ+zMbHUOxOuAnLJ6X18LVQd7zAKPeJE
         HNFTapX4ZN78wP9lkdxQI+ln5nDowSi5DpDbwfQfiYtz96pK0guhgZoIu748l/UuLYH0
         9SWcve95pekezt0wuNwlYFrSU9vEM182eF0OhSZMXsNJvOZuDWAYalLMnSUTiIsA+QTd
         DJbw==
X-Gm-Message-State: ANhLgQ2hOF1uKCb1ycB23ZziYksjby72ejO+KFqiDEFPu85h1yGYzvdF
        dl/lOZVkf/hoFKX+WLJNeHZTW5OA5pchJg==
X-Google-Smtp-Source: ADFU+vtHw44A667X0u7vbt16RvAEVY4sfpM32hncYsQQiCzizBhlzsW2o3jPz5vAL3j+Hnv/C0dfVQ==
X-Received: by 2002:ad4:5401:: with SMTP id f1mr13955436qvt.209.1584134237218;
        Fri, 13 Mar 2020 14:17:17 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x7sm24218280qkx.110.2020.03.13.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:17:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: track reloc roots based on their commit_root bytenr
Date:   Fri, 13 Mar 2020 17:17:08 -0400
Message-Id: <20200313211709.148967-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211709.148967-1-josef@toxicpanda.com>
References: <20200313211709.148967-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We always search the commit root of the extent tree for looking up
back references, however we track the reloc roots based on their current
bytenr.

This is wrong, if we commit the transaction between relocating tree
blocks we could end up in this code in build_backref_tree

if (key.objectid == key.offset) {
	/*
	 * Only root blocks of reloc trees use
	 backref
	 * pointing to itself.
	 */
	root = find_reloc_root(rc, cur->bytenr);
	ASSERT(root);
	cur->root = root;
	break;
}

find_reloc_root() is looking based on the bytenr we had in the commit
root, but if we've cow'ed this reloc root we will not find that bytenr,
and we will trip over the ASSERT(root).

Fix this by using the commit_root->start bytenr for indexing the commit
root.  Then we change the __update_reloc_root() caller to be used when
we switch the commit root for the reloc root during commit.

This fixes the panic I was seeing when we started throttling relocation
for delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 66a344df4f05..45268e50cb17 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,7 +1355,7 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	if (!node)
 		return -ENOMEM;
 
-	node->bytenr = root->node->start;
+	node->bytenr = root->commit_root->start;
 	node->data = root;
 
 	spin_lock(&rc->reloc_root_tree.lock);
@@ -1386,10 +1386,11 @@ static void __del_reloc_root(struct btrfs_root *root)
 	if (rc && root->node) {
 		spin_lock(&rc->reloc_root_tree.lock);
 		rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-				      root->node->start);
+				      root->commit_root->start);
 		if (rb_node) {
 			node = rb_entry(rb_node, struct mapping_node, rb_node);
 			rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
 		if (!node)
@@ -1407,7 +1408,7 @@ static void __del_reloc_root(struct btrfs_root *root)
  * helper to update the 'address of tree root -> reloc tree'
  * mapping
  */
-static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
+static int __update_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *rb_node;
@@ -1416,7 +1417,7 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-			      root->node->start);
+			      root->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
 		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
@@ -1428,7 +1429,7 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 	BUG_ON((struct btrfs_root *)node->data != root);
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	node->bytenr = new_bytenr;
+	node->bytenr = root->node->start;
 	rb_node = tree_insert(&rc->reloc_root_tree.rb_root,
 			      node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
@@ -1587,6 +1588,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	}
 
 	if (reloc_root->commit_root != reloc_root->node) {
+		__update_reloc_root(reloc_root);
 		btrfs_set_root_node(root_item, reloc_root->node);
 		free_extent_buffer(reloc_root->commit_root);
 		reloc_root->commit_root = btrfs_root_node(reloc_root);
@@ -4789,11 +4791,6 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 	BUG_ON(rc->stage == UPDATE_DATA_PTRS &&
 	       root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID);
 
-	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-		if (buf == root->node)
-			__update_reloc_root(root, cow->start);
-	}
-
 	level = btrfs_header_level(buf);
 	if (btrfs_header_generation(buf) <=
 	    btrfs_root_last_snapshot(&root->root_item))
-- 
2.24.1

