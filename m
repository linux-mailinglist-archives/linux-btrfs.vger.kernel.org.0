Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A117CF77E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjJSLw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 07:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjJSLwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 07:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB6B12D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 04:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1BCC433C8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716342;
        bh=nwLQczFFct0Yj+JdkvnZnEapENyT1KYTyL5wyT2Op4U=;
        h=From:To:Subject:Date:From;
        b=W2I8lJ0cyAPgf2Jb20E9Xze15cxbRER8PThQfSmWudbjyta+hUT31cB2Iq92wJI3/
         cDBGd4UFSytJx37de/6Aec+TlURf5gG6Cc5EBh7i02zlGl6RgoxM2RkFsSMpa3Iaxn
         gBgdhETKYvEPus67V8OY1rl0cEfSeUBsOiWpMmLYK8C05RmXbSXUcZG1ay2ZKuDYPt
         +nY0RT1bXfMZJUHCUXaTqCkXpaUB49Q8QCxnV/GVBhpZl6YxiplAR52hiNus1YmbA4
         BpLfIFFRCeQCipyDhDA7dHJUCYRexjY468GVIv7ZAFELEjw0OSRdlx3i+YQ6AorVVv
         +78cP/NXjZnaw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove log_extents_lock and logged_list from struct btrfs_root
Date:   Thu, 19 Oct 2023 12:52:18 +0100
Message-Id: <ab9b3104c0c49f8605cf7c4e57b1370a350a11ef.1697716246.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The logged_list[2] and log_extents_lock[2] members of struct btrfs_root
are no longer used, their last use was removed in commit 5636cf7d6dc8
("btrfs: remove the logged extents infrastructure"). So remove these
fields. This reduces the size of struct btrfs_root, on a release kernel,
from 1392 bytes down to 1352 bytes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   | 3 ---
 fs/btrfs/disk-io.c | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8f1d2d7c46c..4dfa20e2f39a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -224,9 +224,6 @@ struct btrfs_root {
 
 	struct list_head root_list;
 
-	spinlock_t log_extents_lock[2];
-	struct list_head logged_list[2];
-
 	spinlock_t inode_lock;
 	/* red-black tree that keeps track of in-memory inodes */
 	struct rb_root inode_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..350e1b02cc8e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -650,14 +650,10 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&root->ordered_extents);
 	INIT_LIST_HEAD(&root->ordered_root);
 	INIT_LIST_HEAD(&root->reloc_dirty_list);
-	INIT_LIST_HEAD(&root->logged_list[0]);
-	INIT_LIST_HEAD(&root->logged_list[1]);
 	spin_lock_init(&root->inode_lock);
 	spin_lock_init(&root->delalloc_lock);
 	spin_lock_init(&root->ordered_extent_lock);
 	spin_lock_init(&root->accounting_lock);
-	spin_lock_init(&root->log_extents_lock[0]);
-	spin_lock_init(&root->log_extents_lock[1]);
 	spin_lock_init(&root->qgroup_meta_rsv_lock);
 	mutex_init(&root->objectid_mutex);
 	mutex_init(&root->log_mutex);
-- 
2.40.1

