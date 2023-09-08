Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F9798B64
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbjIHRUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbjIHRUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522EBCE6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE84C433CB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193650;
        bh=TxZmlvyZ6C3+PQhT/HuAYK6BHwt4zLCulzjUm+W5JL4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D32ko8QhbcGlJr4hwrcmX2aZhw2BzHWCtM0LNy8Sz3vilSW1CaGb/ag1IMe5EHD3d
         /Kk+Cj2ZFEOm5SSpDn9kwDeeLQ0gJakNSFDsl+HMq2Z4G+LD9r/VfMgrNuiMJAGITP
         B45UK/8tu5CVCwjYI+9rbaxgi+R98Ly94f3ecR7PUJqvxwbBwPpXXNZtASUOnPDQ24
         TpQAL2Lz0e3Lu1MeCg7t7ABCjM+1S0J3jWz9kIaf9NkXjUMr7Xpte/ATdru+9R3WSf
         zsei+gKo+LH+NNW7Hya0uqQ+uGdYox6S/v9xbuG+GcWcnAEmc/dPjdFanlw9LGtvEP
         BAvoTrepwJWtA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/21] btrfs: remove refs_to_add argument from __btrfs_inc_extent_ref()
Date:   Fri,  8 Sep 2023 18:20:25 +0100
Message-Id: <ca230c04666d478f5601636705c12aa231095d7f.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

