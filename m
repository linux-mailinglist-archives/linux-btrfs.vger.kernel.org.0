Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CA5FD7D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJMKgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMKgg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 06:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9833E52CC
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 03:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725BE615BE
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EDDC433B5
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665657394;
        bh=SRqiIXCvFYJpx2iF/9wUEMRNQVQN8xozeIPBmc3AZbM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ArgYSgdWt9H5n2yiz9jUGvsWMtgixmrFn09RHEaE84wqmkSnjWM0XX99HVCIvA2dA
         er/v1GIZdARAIXoh8680D1Dtq2eml5Ex3OL729xzFuLzDaRG+nx70FfXiI07imi0GW
         mIxf0ZE9vUObbT71PjjAKqUiSgmzxBlFooWVGDdbJtl2uyvNZsrQUGuerUlhEmgULm
         w5wulHflHAj7w+JMwBVhnyqyw8nMUCVOUeJYTmv0Eu4fidTFZTT9Vw92Vi1msnbv0x
         OdD1ZMuGh1hi8OzazDuOvLjxSzZHuvnIO0KIfqZdxXBJIow3DYkrvxYTr5m1c+/hs1
         dqsw9hQn4aexQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()
Date:   Thu, 13 Oct 2022 11:36:26 +0100
Message-Id: <903be4beb2a83dcfaa278329c59f055f5a15c42e.1665656353.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665656353.git.fdmanana@suse.com>
References: <cover.1665656353.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

All callers of btrfs_tree_mod_log_insert_key() are now passing a GFP_NOFS
gfp_t flag to it, so remove the flag and use it directly within the body
of btrfs_tree_mod_log_insert_key().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c        | 16 ++++++++--------
 fs/btrfs/tree-mod-log.c |  4 ++--
 fs/btrfs/tree-mod-log.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5d4add61f0a0..861ac12815b7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -471,7 +471,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		btrfs_tree_mod_log_insert_key(parent, parent_slot,
-					      BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+					      BTRFS_MOD_LOG_KEY_REPLACE);
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,
@@ -1000,7 +1000,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
-					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+					BTRFS_MOD_LOG_KEY_REPLACE);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
@@ -1046,7 +1046,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		struct btrfs_disk_key mid_key;
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
-				BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+						    BTRFS_MOD_LOG_KEY_REPLACE);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
@@ -1148,7 +1148,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			orig_slot += left_nr;
 			btrfs_node_key(mid, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot,
-					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+					BTRFS_MOD_LOG_KEY_REPLACE);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &disk_key, pslot);
 			btrfs_mark_buffer_dirty(parent);
@@ -1202,7 +1202,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 
 			btrfs_node_key(right, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
-					BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+					BTRFS_MOD_LOG_KEY_REPLACE);
 			BUG_ON(ret < 0);
 			btrfs_set_node_key(parent, &disk_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
@@ -2400,7 +2400,7 @@ static void fixup_low_keys(struct btrfs_path *path,
 			break;
 		t = path->nodes[i];
 		ret = btrfs_tree_mod_log_insert_key(t, tslot,
-				BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
+						    BTRFS_MOD_LOG_KEY_REPLACE);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(t, key, tslot);
 		btrfs_mark_buffer_dirty(path->nodes[i]);
@@ -2761,7 +2761,7 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 	}
 	if (level) {
 		ret = btrfs_tree_mod_log_insert_key(lower, slot,
-					    BTRFS_MOD_LOG_KEY_ADD, GFP_NOFS);
+						    BTRFS_MOD_LOG_KEY_ADD);
 		BUG_ON(ret < 0);
 	}
 	btrfs_set_node_key(lower, key, slot);
@@ -4201,7 +4201,7 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 			      (nritems - slot - 1));
 	} else if (level) {
 		ret = btrfs_tree_mod_log_insert_key(parent, slot,
-				BTRFS_MOD_LOG_KEY_REMOVE, GFP_NOFS);
+						    BTRFS_MOD_LOG_KEY_REMOVE);
 		BUG_ON(ret < 0);
 	}
 
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 8a3a14686d3e..6606534fc36a 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -220,7 +220,7 @@ static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
 }
 
 int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
-				  enum btrfs_mod_log_op op, gfp_t flags)
+				  enum btrfs_mod_log_op op)
 {
 	struct tree_mod_elem *tm;
 	int ret;
@@ -228,7 +228,7 @@ int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
 	if (!tree_mod_need_log(eb->fs_info, eb))
 		return 0;
 
-	tm = alloc_tree_mod_elem(eb, slot, op, flags);
+	tm = alloc_tree_mod_elem(eb, slot, op, GFP_NOFS);
 	if (!tm)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index 12605d19621b..8cffe0bc2a39 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -32,7 +32,7 @@ int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				   struct extent_buffer *new_root,
 				   bool log_removal);
 int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
-				  enum btrfs_mod_log_op op, gfp_t flags);
+				  enum btrfs_mod_log_op op);
 int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
 struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 						struct btrfs_path *path,
-- 
2.35.1

