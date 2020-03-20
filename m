Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3618D719
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCTSes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35684 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgCTSes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id v15so5832976qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=akRCjfl9I7cFVek0vSrA3nYHCMZiQYs0OOpn/itmBes=;
        b=tK4HafW8mpG4CHItlXMy0FOqz9vtBnaIhb5x0Ax8rfHTbwZXNHpvBvJoEI8zN1Svoc
         yJ2MTIKsutHz+dU+pybIKoSYTdGumpJ+DFXHOzm+mQKlJLC0djFI+oB4AQnwVPFn2EVC
         /JpwgrlmnKfcJpXTg+ytZdWBzlpD9GNOXrGYmWqRUNr3lHHvHjqU72IHjd3BhNT7AKnE
         W9TjKhH8iXZrqEg7VqqiZjs5IJV61bxmxDGsO8gIrpBtlQQ05mf0cWSrzODTyLwPSLDa
         JMxIdBUyyDEQXdDGWhU87eQNi1he1CX+YwBEpPcXxlV9JJ8yjlTlI/RmHee9qpdk6qfW
         mcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akRCjfl9I7cFVek0vSrA3nYHCMZiQYs0OOpn/itmBes=;
        b=nC5WFY572hNP2BmlmtSLB8uSNjWwwG99Z6CEK0APZPkTskaMLYGvuvXB0r1bvxBBqh
         MQZUno7Jz2e1b+9+VVm10/85pihZcHGTeCvpTo5qKgFbCzbMeuM+HkaehX817vIVBsbR
         RMtSrx4tN1X8TjuITseC0tmzb96KO0ZAWJUJlgG++KU3XAum36rSaJwibnTc3vTvUZS6
         g4D9Qbu6ImRIHbCmGfWk/eO+HmNs9tjnlMe7SsGrX9wX1p2whke6k8tOVE4fMucq5610
         TW4ruQMZeghR6a4aoqF9P7ovVbM0oCMS9zfuB/ykjeJMZpe2XMz1FHQR3Qzu8rZZ3kiE
         Oz2A==
X-Gm-Message-State: ANhLgQ0A/x8vVj+Q/0a4Av3JiI0zdZA0gGD91W0WxYVFODN/rx8Ft+aW
        U9wVXMFTkEBhN8gvGHWfnnaysk9MnljQig==
X-Google-Smtp-Source: ADFU+vt3ZHOho9uaR8ha+hWzuaTB2XvwASa8jkn4YzgvYjxhg5T0lvfU+qvqy/LxvuuFLcfh1bKs1A==
X-Received: by 2002:ac8:32fc:: with SMTP id a57mr9079617qtb.331.1584729285716;
        Fri, 20 Mar 2020 11:34:45 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 17sm4627510qkm.105.2020.03.20.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: track reloc roots based on their commit_root bytenr
Date:   Fri, 20 Mar 2020 14:34:34 -0400
Message-Id: <20200320183436.16908-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320183436.16908-1-josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
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

