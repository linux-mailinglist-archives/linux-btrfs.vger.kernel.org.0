Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF27C028A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjJJRZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJJRZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 13:25:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20209E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 10:25:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 538E71F460;
        Tue, 10 Oct 2023 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696958716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/Fv24+j+mWJp1dS8eMIimoGO42mEyH4jO0XlmClWhqs=;
        b=TPig3nqxOjoly3J99zzk+rDQwQol7XgPkHF6QxUZca5hmStN1Oj95O7+tCTjOaPRY5/7N1
        5fdHwnxB4nr4onJhf1ZWfe1WGjgmTjKdrsXrOBxOzUeCWjaYhXcfrI6V0qb6FhNxmeEyR1
        KxtCX+QACkcl0w0OZBGR5U6WW1HAJpE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 21E052C4B9;
        Tue, 10 Oct 2023 17:25:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9CBC5DA898; Tue, 10 Oct 2023 19:18:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: open code timespec64 in struct btrfs_inode
Date:   Tue, 10 Oct 2023 19:18:27 +0200
Message-ID: <20231010171827.11968-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The type of timespec64::tv_nsec is 'unsigned long', while we have only
u32 for on-disk and in-memory. This wastes a few bytes in btrfs_inode.
Add separate members for sec and nsec with the corresponding type width.
This creates a 4 byte hole in btrfs_inode which can be utilized in the
future.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h   |  3 ++-
 fs/btrfs/delayed-inode.c | 12 ++++--------
 fs/btrfs/inode.c         | 26 ++++++++++++--------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bebb5921b922..5572ae52444e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -253,7 +253,8 @@ struct btrfs_inode {
 	struct btrfs_delayed_node *delayed_node;
 
 	/* File creation time. */
-	struct timespec64 i_otime;
+	u64 i_otime_sec;
+	u32 i_otime_nsec;
 
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 4f364e242341..c640f87038a6 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1847,10 +1847,8 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
 				      inode_get_ctime(inode).tv_nsec);
 
-	btrfs_set_stack_timespec_sec(&inode_item->otime,
-				     BTRFS_I(inode)->i_otime.tv_sec);
-	btrfs_set_stack_timespec_nsec(&inode_item->otime,
-				     BTRFS_I(inode)->i_otime.tv_nsec);
+	btrfs_set_stack_timespec_sec(&inode_item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_stack_timespec_nsec(&inode_item->otime, BTRFS_I(inode)->i_otime_nsec);
 }
 
 int btrfs_fill_inode(struct inode *inode, u32 *rdev)
@@ -1899,10 +1897,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	inode_set_ctime(inode, btrfs_stack_timespec_sec(&inode_item->ctime),
 			btrfs_stack_timespec_nsec(&inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime.tv_sec =
-		btrfs_stack_timespec_sec(&inode_item->otime);
-	BTRFS_I(inode)->i_otime.tv_nsec =
-		btrfs_stack_timespec_nsec(&inode_item->otime);
+	BTRFS_I(inode)->i_otime_sec = btrfs_stack_timespec_sec(&inode_item->otime);
+	BTRFS_I(inode)->i_otime_nsec = btrfs_stack_timespec_nsec(&inode_item->otime);
 
 	inode->i_generation = BTRFS_I(inode)->generation;
 	BTRFS_I(inode)->index_cnt = (u64)-1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6f67ac612c6e..b388505c91cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3771,10 +3771,8 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime.tv_sec =
-		btrfs_timespec_sec(leaf, &inode_item->otime);
-	BTRFS_I(inode)->i_otime.tv_nsec =
-		btrfs_timespec_nsec(leaf, &inode_item->otime);
+	BTRFS_I(inode)->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
+	BTRFS_I(inode)->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
 
 	inode_set_bytes(inode, btrfs_inode_nbytes(leaf, inode_item));
 	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
@@ -3944,10 +3942,8 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
 				      inode_get_ctime(inode).tv_nsec);
 
-	btrfs_set_token_timespec_sec(&token, &item->otime,
-				     BTRFS_I(inode)->i_otime.tv_sec);
-	btrfs_set_token_timespec_nsec(&token, &item->otime,
-				      BTRFS_I(inode)->i_otime.tv_nsec);
+	btrfs_set_token_timespec_sec(&token, &item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->otime, BTRFS_I(inode)->i_otime_nsec);
 
 	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
 	btrfs_set_token_inode_generation(&token, item,
@@ -5609,7 +5605,8 @@ static struct inode *new_simple_dir(struct inode *dir,
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 	inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_atime = dir->i_atime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime_sec = inode->i_mtime.tv_sec;
+	BTRFS_I(inode)->i_otime_nsec = inode->i_mtime.tv_nsec;
 	inode->i_uid = dir->i_uid;
 	inode->i_gid = dir->i_gid;
 
@@ -6286,7 +6283,8 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 
 	inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_atime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime_sec = inode->i_mtime.tv_sec;
+	BTRFS_I(inode)->i_otime_nsec = inode->i_mtime.tv_nsec;
 
 	/*
 	 * We're going to fill the inode item now, so at this point the inode
@@ -8487,8 +8485,8 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 
 	ei->delayed_node = NULL;
 
-	ei->i_otime.tv_sec = 0;
-	ei->i_otime.tv_nsec = 0;
+	ei->i_otime_sec = 0;
+	ei->i_otime_nsec = 0;
 
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
@@ -8642,8 +8640,8 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
 	stat->result_mask |= STATX_BTIME;
-	stat->btime.tv_sec = BTRFS_I(inode)->i_otime.tv_sec;
-	stat->btime.tv_nsec = BTRFS_I(inode)->i_otime.tv_nsec;
+	stat->btime.tv_sec = BTRFS_I(inode)->i_otime_sec;
+	stat->btime.tv_nsec = BTRFS_I(inode)->i_otime_nsec;
 	if (bi_flags & BTRFS_INODE_APPEND)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (bi_flags & BTRFS_INODE_COMPRESS)
-- 
2.41.0

