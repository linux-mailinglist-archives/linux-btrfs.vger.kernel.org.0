Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F37986D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbjIHMJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjIHMJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E091BE7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88232C433C7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174976;
        bh=2aHNAZsssZgCQJ8ExnofXwfQibQSzTru6TtpRQDdE18=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RFNgqhMio4b2btcXIJwV4qKJ+z4ME6PM5DoQ9NchprOym/7A/YyMmkbcrmLqVHaHl
         75VK8roOzPfCVF9H1wiZ+5zcG8axz2NjbGamo1F8K2weGZAznnGUS0mSlR3x0cHj8H
         5QOW/6hPcK3NqJyEwhVhym2BttdYQnIsUqR0Acw58aq0hZs+ddFNdHxZxYifAoNcYB
         adQ0R4tHD7Ncq4JppdlXhwHoz+2YJsEE1oLTYQtd8RhtUbS6wksDfV59VlF1i66FW4
         wCPLVwTY++KK/hgz09eTie2gQXvID8gzwBIxFYTX1z87xPeLupwsf/pWrzLiG2+rXB
         3tyv5vjPAkNcQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/21] btrfs: remove refs_to_drop argument from __btrfs_free_extent()
Date:   Fri,  8 Sep 2023 13:09:11 +0100
Message-Id: <bb7c546282b4084cf94aa255da100d40af81b66b.1694174371.git.fdmanana@suse.com>
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

Currently the 'refs_to_drop' argument of __btrfs_free_extent() always
matches the value of node->ref_mod, so remove the argument and use
node->ref_mod at __btrfs_free_extent().

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

