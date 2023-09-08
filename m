Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B89798B65
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbjIHRU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245341AbjIHRUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BDD199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF3BC433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193651;
        bh=oSekCeaXH8j4TNAJnFikiKQcu1ew2ny8AW4C0vzQa7o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qf/928iagRgzI6+bMMwMykDfOoYTzqNbObxnERzqkpu24gqp2FFNApzo499zkO92q
         iquUfD6nLOTzfLJa2ueEaOM7ancc5nRI8QjcNyEWSnjmZcJzmroePbsuaQT/xPAr33
         mOiHlRJ+acxpYlDmq5reY5C5h4Yjr9nnWGtf0s+7+hbKvPB7o9a1WlUagt51AXflp2
         Q2VVJd2X8gcpf4ZS1LQt1xlQr3K9b5matYpCeVEQxNQh1WmoTx6EZZBhRu01vqJruJ
         YRKbqTaxm6Uj2zcB1BpRTR0yMogt4lg+ofVVFhf70hT6kzu7hvx+l6w0ZKkC3S3Cyc
         wTp4XmllHGhhQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/21] btrfs: remove refs_to_drop argument from __btrfs_free_extent()
Date:   Fri,  8 Sep 2023 18:20:26 +0100
Message-Id: <70661a0f9e1799b1213071a7313e2ec612c7177b.1694192469.git.fdmanana@suse.com>
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

Currently the 'refs_to_drop' argument of __btrfs_free_extent() always
matches the value of node->ref_mod, so remove the argument and use
node->ref_mod at __btrfs_free_extent().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 16e511f3d24b..de63e873be3a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -49,7 +49,7 @@
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
 			       u64 root_objectid, u64 owner_objectid,
-			       u64 owner_offset, int refs_to_drop,
+			       u64 owner_offset,
 			       struct btrfs_delayed_extent_op *extra_op);
 static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 				    struct extent_buffer *leaf,
@@ -1565,8 +1565,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent,
 					  ref_root, ref->objectid,
-					  ref->offset, node->ref_mod,
-					  extent_op);
+					  ref->offset, extent_op);
 	} else {
 		BUG();
 	}
@@ -1712,7 +1711,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 					     ref->level, 0, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent, ref_root,
-					  ref->level, 0, 1, extent_op);
+					  ref->level, 0, extent_op);
 	} else {
 		BUG();
 	}
@@ -2927,7 +2926,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
 			       u64 root_objectid, u64 owner_objectid,
-			       u64 owner_offset, int refs_to_drop,
+			       u64 owner_offset,
 			       struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
@@ -2942,6 +2941,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	int extent_slot = 0;
 	int found_extent = 0;
 	int num_to_del = 1;
+	int refs_to_drop = node->ref_mod;
 	u32 item_size;
 	u64 refs;
 	u64 bytenr = node->bytenr;
-- 
2.40.1

