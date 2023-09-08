Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706BA7986CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbjIHMJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjIHMJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595911BE7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF08C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174978;
        bh=PAP3FOJoTPSe/qm3pOdT9zqiWK6FT6FFWFqv4QY3dIw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ypl8Mk1ZFKPRVzr97ls7jiKupK3eejo1eOZ2GGv8+wynmmB4GDR6pHLsiwsO8r/J0
         T9ufgrIg1XM3Vl/ZLouqAQcyTly0SuHmUwIRysq0/Lqv7wjOelO5NHYcyYPPSuebHP
         LcsPSNod0FVT+XIXgUrmjXz8vdFz6PF3NMQy4N4BvLD6Y44APSlcNorEKyp0cVgoW8
         fQQQXsnzLiLngRXFJyRhxiX8xwyN5Dpq8zpTgKbrrrePywSLij1fmNb0Jf7+ItXier
         wijp2+Lll5m5NNRt6lEMslBCHCBXuF9VgEOyDVXUptcyhr3GsH+CGMhPmoA9/las0I
         tgKH8MPCFEFxg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/21] btrfs: remove pointless 'ref_root' variable from run_delayed_data_ref()
Date:   Fri,  8 Sep 2023 13:09:13 +0100
Message-Id: <0f7ec851de1a7913b102ea39723fa3cf636cf6b0.1694174371.git.fdmanana@suse.com>
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

The 'ref_root' variable, at run_delayed_data_ref(), is not really needed
as we can always use ref->root directly, plus its initialization to 0 is
completely pointless as we assign it ref->root before its first use.
So just drop that variable and use ref->root directly.

This may help avoid some warnings with clang tools such as the one
reported/fixed by commit 966de47ff0c9 ("btrfs: remove redundant
initialization of variables in log_new_ancestors").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 16c7122bdfb5..21049609c5fc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1536,7 +1536,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	struct btrfs_delayed_data_ref *ref;
 	u64 parent = 0;
-	u64 ref_root = 0;
 	u64 flags = 0;
 
 	ref = btrfs_delayed_node_to_data_ref(node);
@@ -1544,7 +1543,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 
 	if (node->type == BTRFS_SHARED_DATA_REF_KEY)
 		parent = ref->parent;
-	ref_root = ref->root;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		struct btrfs_key key;
@@ -1556,17 +1554,17 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = node->num_bytes;
 
-		ret = alloc_reserved_file_extent(trans, parent, ref_root,
+		ret = alloc_reserved_file_extent(trans, parent, ref->root,
 						 flags, ref->objectid,
 						 ref->offset, &key,
 						 node->ref_mod);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
-		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
+		ret = __btrfs_inc_extent_ref(trans, node, parent, ref->root,
 					     ref->objectid, ref->offset,
 					     extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent,
-					  ref_root, ref->objectid,
+					  ref->root, ref->objectid,
 					  ref->offset, extent_op);
 	} else {
 		BUG();
-- 
2.40.1

