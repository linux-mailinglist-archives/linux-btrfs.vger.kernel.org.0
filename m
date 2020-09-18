Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2152926F90A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIRJQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 05:16:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:52152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgIRJP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 05:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600420555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BBOG0cccyz3usypP0SZG5mfcrBlZCdzkAvD0kbMIgK8=;
        b=OkVWWxEH4yNvczgdRobxvTTBATAsnrlkRMzjNlyapsaiIObnacnI+sqKjYrrE7oS7hTznw
        d0MCdEtD7499+l9sTsgdch4ohF3E94hu1r5o+tXbi6R50bT+gnVZHr2GqhOS65Hz7drq4R
        wtkM65whOMQO3a3Lj+vBeDhjzwL/l4A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DE99ACE5;
        Fri, 18 Sep 2020 09:16:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/5] btrfs: Switch btrfs_remove_ordered_extent to btrfs_inode
Date:   Fri, 18 Sep 2020 12:15:50 +0300
Message-Id: <20200918091553.29584-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918091553.29584-1-nborisov@suse.com>
References: <20200918091553.29584-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 4 ++--
 fs/btrfs/ordered-data.c | 7 +++----
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6054a80a07bc..5bcc9307b0f9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2738,7 +2738,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	 * This needs to be done to make sure anybody waiting knows we are done
 	 * updating everything for this ordered extent.
 	 */
-	btrfs_remove_ordered_extent(inode, ordered_extent);
+	btrfs_remove_ordered_extent(BTRFS_I(inode), ordered_extent);
 
 	/* once for us */
 	btrfs_put_ordered_extent(ordered_extent);
@@ -8675,7 +8675,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 			btrfs_err(fs_info,
 				  "found ordered extent %llu %llu on inode cleanup",
 				  ordered->file_offset, ordered->num_bytes);
-			btrfs_remove_ordered_extent(vfs_inode, ordered);
+			btrfs_remove_ordered_extent(inode, ordered);
 			btrfs_put_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 		}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c8a13d143877..c93b4f2c778b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -463,13 +463,12 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
  * remove an ordered extent from the tree.  No references are dropped
  * and waiters are woken up.
  */
-void btrfs_remove_ordered_extent(struct inode *inode,
+void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				 struct btrfs_ordered_extent *entry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_inode_tree *tree;
-	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
 	struct btrfs_root *root = btrfs_inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *node;
 	bool pending;
 
@@ -527,7 +526,7 @@ void btrfs_remove_ordered_extent(struct inode *inode,
 	list_del_init(&entry->root_extent_list);
 	root->nr_ordered_extents--;
 
-	trace_btrfs_ordered_extent_remove(BTRFS_I(inode), entry);
+	trace_btrfs_ordered_extent_remove(btrfs_inode, entry);
 
 	if (!root->nr_ordered_extents) {
 		spin_lock(&fs_info->ordered_root_lock);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 6a1d5bf5aee3..8fe720da0b31 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -151,7 +151,7 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 }
 
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
-void btrfs_remove_ordered_extent(struct inode *inode,
+void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
 int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				   struct btrfs_ordered_extent **cached,
-- 
2.17.1

