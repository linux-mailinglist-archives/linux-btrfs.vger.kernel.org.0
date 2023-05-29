Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C9714CD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjE2PRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE2PRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E4C9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A491C615DD
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917A5C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373438;
        bh=GnM9+H8HNqWtwUPyvqjLvbhwrnnY5k50Jv246I/XFiQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sOrFljfiKN1HI4uYbC/b6s4jSrSCsWm7yWV0Mn5a0tohznB5tHLCXrH8c69az0DQd
         NZ2ovA08JjcTMCXS5JxFj3MhBESW+6h0YE2RKakaPjfnlHqog/G4cA/xk5Up099ZFE
         0Jhm5vOm7Rz3FvGfwrnXFPk/F1XPsa3AF79lOJdxB/5jm6m2SdE39nBrLRKOS8+rN0
         nMy21oN+jF2WS/IyYffcMtxo3Cro3RaLsTp1o+gmGhBHjo2lfv4nOXefS4pSvzVC4i
         8oosz7Mu3YM2ick/9mSGazwrPdv/hk858P2oiGzpbQCKfXQZcbJi2RUDByb01vDMYe
         2pH3rt+ZlUPqw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: remove pointless in_tree field from struct btrfs_delayed_ref_node
Date:   Mon, 29 May 2023 16:16:59 +0100
Message-Id: <18656b6d56a9813f52f3594637ab3acb31e129ba.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The 'in_tree' field is really not needed in struct btrfs_delayed_ref_node,
as we can check whether a reference is in the tree or not simply by
checking its red black tree node member with RB_EMPTY_NODE(), as when we
remove it from the tree we always call RB_CLEAR_NODE(). So remove that
field and use RB_EMPTY_NODE().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 2 --
 fs/btrfs/delayed-ref.h | 3 +--
 fs/btrfs/disk-io.c     | 1 -
 fs/btrfs/extent-tree.c | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index be1d18ec5cef..d6dce5792c0f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -407,7 +407,6 @@ static inline void drop_delayed_ref(struct btrfs_delayed_ref_root *delayed_refs,
 	RB_CLEAR_NODE(&ref->ref_node);
 	if (!list_empty(&ref->add_list))
 		list_del(&ref->add_list);
-	ref->in_tree = 0;
 	btrfs_put_delayed_ref(ref);
 	atomic_dec(&delayed_refs->num_entries);
 }
@@ -853,7 +852,6 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->num_bytes = num_bytes;
 	ref->ref_mod = 1;
 	ref->action = action;
-	ref->in_tree = 1;
 	ref->seq = seq;
 	ref->type = ref_type;
 	RB_CLEAR_NODE(&ref->ref_node);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 77b3e735772d..9b103bf27185 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -48,7 +48,6 @@ struct btrfs_delayed_ref_node {
 
 	unsigned int action:8;
 	unsigned int type:8;
-	unsigned int in_tree:1;
 };
 
 struct btrfs_delayed_extent_op {
@@ -341,7 +340,7 @@ static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 {
 	WARN_ON(refcount_read(&ref->refs) == 0);
 	if (refcount_dec_and_test(&ref->refs)) {
-		WARN_ON(ref->in_tree);
+		WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
 		switch (ref->type) {
 		case BTRFS_TREE_BLOCK_REF_KEY:
 		case BTRFS_SHARED_BLOCK_REF_KEY:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 96f144094af6..793f7e48d62e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4849,7 +4849,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 		while ((n = rb_first_cached(&head->ref_tree)) != NULL) {
 			ref = rb_entry(n, struct btrfs_delayed_ref_node,
 				       ref_node);
-			ref->in_tree = 0;
 			rb_erase_cached(&ref->ref_node, &head->ref_tree);
 			RB_CLEAR_NODE(&ref->ref_node);
 			if (!list_empty(&ref->add_list))
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4f7ac5a5d29e..0aa775ac31e4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1913,7 +1913,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 			return -EAGAIN;
 		}
 
-		ref->in_tree = 0;
 		rb_erase_cached(&ref->ref_node, &locked_ref->ref_tree);
 		RB_CLEAR_NODE(&ref->ref_node);
 		if (!list_empty(&ref->add_list))
-- 
2.34.1

