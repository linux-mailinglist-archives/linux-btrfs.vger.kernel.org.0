Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E977491D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGEXX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjGEXXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:35 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54CE57
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 197495C0290;
        Wed,  5 Jul 2023 19:23:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jul 2023 19:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599414; x=
        1688685814; bh=a31zqO//fC/H2T4qCHwyOHDOKM65sKV0Mw8O7zaO0dM=; b=A
        4Un0ME8zJgrVZ0ITHZ0MH/cNk8Aj3iFc8EKW05XKrKPXrdS8reGoCKKXLDG/iq2s
        PmRlwqTDTnNHK1CAQfm53N5JwIprRrx+O33QyYo3OcjBtdcGSamQt9LaMA1D+NwK
        1dB2otxLOA5aPMY7XEsHyUaQAKjTX1Pw21IER3Hdzh/Texm44X45v1oJuXha83Q0
        RcSDzwhiOwhOYyJ72Wm3nMhPYXKM/z+tPVU2IXzGenl/QWwqqqu/C67cfYCdaj1M
        sQMIVrLUgkRzw0VUkfGMxl8GgQItHvRfQdjxu59SKgRdcM7xyDuhQ558rnz4Tiji
        +ZqWUcRfBqD0PPtoMSouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599414; x=1688685814; bh=a
        31zqO//fC/H2T4qCHwyOHDOKM65sKV0Mw8O7zaO0dM=; b=HkUJAZjz4xx/kpdna
        BgVz8PiNNFXjUr5j0A/LH8JpQX0bTLVkLoSH9xmO5Po2G66C1j56iIq/lTPaCKMK
        f7o9eZnQ/0mC4JsTF9M0q158lKMvLoFm0usQiK2U/l2cXxjjgS11A3FOgdOOyZgV
        0iQWRaDj9rkhukT9Qo2eYQD85MFALk/llR9b1nB4Patk8AMdqvW9b+c9YJdIgneu
        kOa+3a5Xd1UFCHFGo3E/HaNglCEAGZ0Ks8TRySwV4/tA/8ECTPM73PNMK/GwEwEJ
        ovKw7lfGxZIX64Um+bMcIDW9o4ZLRA1/l1kUEGDEK6txbT+tVn8xHyaydw1AO4C3
        dYz2A==
X-ME-Sender: <xms:dvulZD1A-FEqXcmqAVZJ661YVjvmojzvPrvNFptmMIq8IJiHgrDCmw>
    <xme:dvulZCFEnFZSHuT_5dS4q9Vt_Ghlgh35ivE6T8DY1WdtK2aaYqTxY0qIOaLPoYK0F
    m9a1HiKrGlSxH0WzOA>
X-ME-Received: <xmr:dvulZD4Ai6lb6KNnzdYorei6qSP71ujVauH-C9SmUVTpDKFlydTCKO-8H6JWfilh49noOc6VfEdbElEDwDGFOVAxNZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:dvulZI06clTEN4CGRQ8cfm22ifRBrsY2RH_Vu5T40MtWPWATEp9b4A>
    <xmx:dvulZGFgfRF7iOYW3XAr6kji0nXEYsxOQU_MxzJpVXXO6YaeTRIU2g>
    <xmx:dvulZJ_LS49Iow1sHF0C6jK5tkVZcGDWtzm8uWYcoZzKKAH-0BKujA>
    <xmx:dvulZBOnVOMPUDVq7kQ_fOYVibLPAR1tst92TRxrXYa3XYOTLwmqQg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:33 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/18] btrfs: track data relocation with simple quota
Date:   Wed,  5 Jul 2023 16:20:55 -0700
Message-ID: <d9e6a4525095ec5abb1818547d565fcf3ef58460.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation data allocations are quite tricky for simple quotas. The
basic data relocation sequence is (ignoring details that aren't relevant
to this fix):
- create a fake relocation data fs root
- create a fake relocation inode in that root
- foreach data extent:
  - preallocate a data extent on behalf of the fake inode
  - copy over the data
- foreach extent
  - swap the refs so that the original file extent now refers to the new
    extent item
- drop the fake root, dropping its refs on the old extents, which lets
  us delete them.

Done naively, this results in storing an extent item in the extent tree
whose owner_ref points at the relocation data root and a no-op squota
recording, since the reloc root is not a legit fstree. So far, that's
OK. The problem comes when you do the swap, and leave an extent item
owned by this bogus root as the real permanent extents of the file. If
the file then drops that ref, we free it and no-op account that against
the fake relocation root. Essentially, this means that relocation is
simple quota "extent laundering", since we re-own the extents into a
fake root.

Simple quotas very intentionally doesn't have a mechanism for
transferring ownership of extents, as that is exactly the complicated
thing we are trying to avoid with the new design. Further, it cannot be
correctly done in this case, since at the time you create the new
"real" refs, there is no way to know which was the original owner before
relocation unless we track it.

Therefore, it makes more sense to trick the preallocation to handle
relocation as a special case and note the proper owner ref from the
beginning. That way, we never write out an extent item without the
correct owner ref that it will eventually have.

This could be done by wiring a special root parameter all the way
through the allocation code path, but to avoid that special case
touching all the code, take advantage of the serial nature of relocation
to store the src root on the relocation root object. Then when we finish
the prealloc, if it happens to be this case, prepare the delayed ref
appropriately.

This is obviously a smelly bit of code, but I think it is the best
solution to the problem, given the relocation implementation.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/extent-tree.c | 13 +++++++------
 fs/btrfs/relocation.c  | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f2d2b313bde5..577186994188 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -333,6 +333,7 @@ struct btrfs_root {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
+	u64 relocation_src_root;
 };
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 99845a54e168..10e026d5b684 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -57,7 +57,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod);
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root);
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op);
@@ -1541,7 +1541,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		ret = alloc_reserved_file_extent(trans, parent, ref_root,
 						 flags, ref->objectid,
 						 ref->offset, &ins,
-						 node->ref_mod);
+						 node->ref_mod, href->owning_root);
 		if (!ret)
 			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
@@ -4683,7 +4683,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
-				      struct btrfs_key *ins, int ref_mod)
+				      struct btrfs_key *ins, int ref_mod, u64 oref_root)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *extent_root;
@@ -4731,7 +4731,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (simple_quota) {
 		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
 		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
-		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
+		btrfs_set_extent_owner_ref_root_id(leaf, oref, oref_root);
 		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
 	}
 	btrfs_set_extent_inline_ref_type(leaf, iref, type);
@@ -4842,7 +4842,8 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
 
-	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
+		owning_root = root->relocation_src_root;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
 			       ins->objectid, ins->offset, 0, owning_root);
@@ -4899,7 +4900,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&space_info->lock);
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
-					 offset, ins, 1);
+					 offset, ins, 1, root_objectid);
 	if (ret)
 		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
 	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 119f670538f7..e12377c818c0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3665,6 +3665,21 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 				    struct btrfs_extent_item);
 		flags = btrfs_extent_flags(path->nodes[0], ei);
 
+		/*
+		 * If we are relocating a simple quota owned extent item, we need
+		 * to note the owner on the reloc data root so that when we
+		 * allocate the replacement item, we can attribute it to the
+		 * correct eventual owner (rather than the reloc data root)
+		 */
+		if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+			struct btrfs_root *root = BTRFS_I(rc->data_inode)->root;
+			u64 owning_root_id = btrfs_get_extent_owner_root(fs_info,
+									 path->nodes[0],
+									 path->slots[0]);
+
+			root->relocation_src_root = owning_root_id;
+		}
+
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
 		} else if (rc->stage == UPDATE_DATA_PTRS &&
-- 
2.41.0

