Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858F59BDDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiHVKv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiHVKvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9013123B
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E5660FFF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7C3C433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165511;
        bh=6EcyOPKEZ8ByNUXXAzW34NNHJMETgjPq0nFeRVwdIbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R/P2/OzA0Z9YF3f8MTBTUJZtGhplxczKCDHxEvMeGG5i/p9Vgzc4vB9oS04PzA8QL
         mR5iXUZwKnVo4NIJ3+Nt7b6CFXsn/L1ocjwM0Ahpgd2ZVhFloI2Td3MMQqBJf3AGvm
         iJ5XGWivTz5lsWCWK8Ia9Z6dkR8aYKcqQqpLREsKJrBjWdw7hOkgZCjtjNShQizxFD
         tDHZr6I/ZPtCwo60OOdMaUV8tRnB4dKjDl2ju9Plrd3ca05CXEaActZv3wnX5xZ2EN
         D8vQgKTebWi3xqjiU9h+iGURin3qK4/uIwC9CO/rUbpJnxBMKfzwuBk9gCd85Tf0Dd
         KZ/CwJDSpqvIg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/15] btrfs: free list element sooner at log_new_dir_dentries()
Date:   Mon, 22 Aug 2022 11:51:33 +0100
Message-Id: <bcfff559fa2ceb5d935de5f71fc5ae346bd75787.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At log_new_dir_dentries(), there's no need to keep the current list
element allocated while processing the leaves with directory items for
the current directory, and while logging other inodes. Plus in case we
find a subdirectory, we also end up allocating a new list element while
the current one is still allocated, temporarily using more memory than
necessary.

So free the current list element early on, before processing leaves.
Also make the removal and release of all list elements in case of an
error more simple by eliminating the label and goto, adding an explicit
loop to release all list elements in case an error happens.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9625707bfa8a..bd50509e9839 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6002,25 +6002,28 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	while (!list_empty(&dir_list)) {
 		struct extent_buffer *leaf;
 		struct btrfs_key min_key;
+		u64 ino;
+		bool continue_curr_inode = true;
 		int nritems;
 		int i;
 
 		dir_elem = list_first_entry(&dir_list, struct btrfs_dir_list,
 					    list);
-		if (ret)
-			goto next_dir_inode;
+		ino = dir_elem->ino;
+		list_del(&dir_elem->list);
+		kfree(dir_elem);
 
-		min_key.objectid = dir_elem->ino;
+		min_key.objectid = ino;
 		min_key.type = BTRFS_DIR_INDEX_KEY;
 		min_key.offset = 0;
 again:
 		btrfs_release_path(path);
 		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
 		if (ret < 0) {
-			goto next_dir_inode;
+			break;
 		} else if (ret > 0) {
 			ret = 0;
-			goto next_dir_inode;
+			continue;
 		}
 
 		leaf = path->nodes[0];
@@ -6029,14 +6032,15 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
 			struct inode *di_inode;
-			struct btrfs_dir_list *new_dir_elem;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
 			btrfs_item_key_to_cpu(leaf, &min_key, i);
-			if (min_key.objectid != dir_elem->ino ||
-			    min_key.type != BTRFS_DIR_INDEX_KEY)
-				goto next_dir_inode;
+			if (min_key.objectid != ino ||
+			    min_key.type != BTRFS_DIR_INDEX_KEY) {
+				continue_curr_inode = false;
+				break;
+			}
 
 			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
 			type = btrfs_dir_type(leaf, di);
@@ -6050,7 +6054,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			di_inode = btrfs_iget(fs_info->sb, di_key.objectid, root);
 			if (IS_ERR(di_inode)) {
 				ret = PTR_ERR(di_inode);
-				goto next_dir_inode;
+				goto out;
 			}
 
 			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
@@ -6065,29 +6069,33 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 					      log_mode, ctx);
 			btrfs_add_delayed_iput(di_inode);
 			if (ret)
-				goto next_dir_inode;
+				goto out;
 			if (ctx->log_new_dentries) {
-				new_dir_elem = kmalloc(sizeof(*new_dir_elem),
-						       GFP_NOFS);
-				if (!new_dir_elem) {
+				dir_elem = kmalloc(sizeof(*dir_elem), GFP_NOFS);
+				if (!dir_elem) {
 					ret = -ENOMEM;
-					goto next_dir_inode;
+					goto out;
 				}
-				new_dir_elem->ino = di_key.objectid;
-				list_add_tail(&new_dir_elem->list, &dir_list);
+				dir_elem->ino = di_key.objectid;
+				list_add_tail(&dir_elem->list, &dir_list);
 			}
 			break;
 		}
-		if (min_key.offset < (u64)-1) {
+
+		if (continue_curr_inode && min_key.offset < (u64)-1) {
 			min_key.offset++;
 			goto again;
 		}
-next_dir_inode:
-		list_del(&dir_elem->list);
-		kfree(dir_elem);
 	}
-
+out:
 	btrfs_free_path(path);
+	if (ret) {
+		struct btrfs_dir_list *next;
+
+		list_for_each_entry_safe(dir_elem, next, &dir_list, list)
+			kfree(dir_elem);
+	}
+
 	return ret;
 }
 
-- 
2.35.1

