Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A147986D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbjIHMJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjIHMJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE991BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F2BC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174975;
        bh=aiwc3+PamXF4i1nUGTHtwy2uw159CpOb9gZSGpC1mYI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QykUCIOZof5DfBHRds3FluXfT6/LEneyZtBW33xbxZkKT6xBgFX8eyo0Rhtn77eZG
         x0WocXtQcXmZt5y8kImb4I541FCUhvnBcw/n8S5fRjPvs2Dbfge0we+JczWcUd8NnU
         6lVH9KHZXOS0PVigXCCiWoVFt5IycFngYi/yVXnqB9hf0uycQKgLxAzjYUfnX/OBP7
         yPFdEcESNcrZEV5o52n/O88xItnCnSXHMTkYA0xSCut9XVHNxJcle2u3gjRO1JcCWk
         HhjrYLaAp91iPoFNYl9thQMz/4JwOnzIWTa5HEi2B1EEwSCI2zhUxL7N0VjMijGMPe
         Kqt6gIXHDMo5Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/21] btrfs: remove refs_to_add argument from __btrfs_inc_extent_ref()
Date:   Fri,  8 Sep 2023 13:09:10 +0100
Message-Id: <e4d368a85ac2405337139bdbfa4c4939a961a4dd.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

Currently the 'refs_to_add' argument of __btrfs_inc_extent_ref() always
matches the value of node->ref_mod, so remove the argument and use
node->ref_mod at __btrfs_inc_extent_ref().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cf503f2972a1..16e511f3d24b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1465,8 +1465,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
  *		    always passed as 0. For data extents it is the fileoffset
  *		    this extent belongs to.
  *
- * @refs_to_add     Number of references to add
- *
  * @extent_op       Pointer to a structure, holding information necessary when
  *                  updating a tree block's flags
  *
@@ -1474,7 +1472,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_delayed_ref_node *node,
 				  u64 parent, u64 root_objectid,
-				  u64 owner, u64 offset, int refs_to_add,
+				  u64 owner, u64 offset,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_path *path;
@@ -1484,6 +1482,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	u64 refs;
+	int refs_to_add = node->ref_mod;
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -1562,7 +1561,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
 					     ref->objectid, ref->offset,
-					     node->ref_mod, extent_op);
+					     extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent,
 					  ref_root, ref->objectid,
@@ -1710,7 +1709,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		ret = alloc_reserved_tree_block(trans, node, extent_op);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
-					     ref->level, 0, 1, extent_op);
+					     ref->level, 0, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent, ref_root,
 					  ref->level, 0, 1, extent_op);
-- 
2.40.1

