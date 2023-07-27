Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD406765F19
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjG0WPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjG0WPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:34 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197913E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4A33B3200319;
        Thu, 27 Jul 2023 18:15:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 27 Jul 2023 18:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496132; x=
        1690582532; bh=mbSqJY84oKAUNngqx1n9zWCWniZ19wbmjFVSiK9XK9Y=; b=f
        f0wpn6xmo7Cq03erQ500vP1YHExyMcDRBzm2rmZ8ZWsLNbimPqwGB1mN9mxQ/Qnv
        fXOL9PoPQYATTWIhj+4pq/XxC/uFLWQORixHfZwBabvus9gDpExpqq8j+1nE6bOD
        tfBfuUwzReYmRz4pFvHE4osTk1dhmjyW081mhHPgfiLw5WsIBmYTwx2u0J9LLINu
        fAPSVSJ8QvAI7WvLncAr6q7l9At9mumWHSc9Cte/FaBmt165Njw1HjEU/zHCrjT3
        JAgev9YcrC/ei3JWgaRp9y8zw7vRizdotdYO03ERSpcRz5L1fvKIBwUiMwRdFG3R
        lTlozS7o001adVr6fWakw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496132; x=1690582532; bh=m
        bSqJY84oKAUNngqx1n9zWCWniZ19wbmjFVSiK9XK9Y=; b=P2PkkpjeAROy0YRME
        v14KD+ws0tCymN/QUnzn7MhlYTgSsDrEyOsjcPlhjU8isqws90DHwiS/c0OIK5JK
        htA/SKBzemrg9hkIuwGH43KQkYyRTY4Caxzlw5Dk+dSBHBUqhByDppcOzYOgU/K4
        6mMqb/4tb0U1HvjHWrma3f/yyb7uJIr8xi4RWCPqjbCHeycdZp0L0xM7+PVJcnf6
        y1yO8byKw5TCSIu3d/+CQrjrIPCs/d+6soMMapmfzU0SJ2zOlAcNNtQycJPgM9vA
        ZO8RQyLtHMHJckLXpooxRebeOADatLYj70vHXeW6Vtn5Z9HeL4aa4ozZGHtemSaP
        kB75g==
X-ME-Sender: <xms:hOzCZFEDW8RxwHbhXJzuplAigeTbQmoB8QSwyIqHhOXbsldLK2uZpA>
    <xme:hOzCZKVLXfQVWThLoONVKh0CQD3g9f98O3hVVH-G23je42GP0Owmg8NfIgvxJ1JdI
    JlpKBlwpyAs_6i9fxk>
X-ME-Received: <xmr:hOzCZHLLK6fhcOV55uRkYvM0FZUGLNWRFmlDBnlAzs26AeSGCQr4e63Kf8qm2u4jUlh3qH7LVHxZWqcM7hJWcDEDexU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:hOzCZLF3aTSQWJXnuNZA_UBCEgrmzYQzhiYqJXHNgbqMND6bF1W2uA>
    <xmx:hOzCZLXA4COilrKPt2wQKooRXsLYgQgIVLzcct7MVr6sP7IbukvKpw>
    <xmx:hOzCZGNHl1HH-UktBOxBjd3LIUOmAj73QuGGMhWunc3tikclYppwMA>
    <xmx:hOzCZMckyB1F06NLyjw8ye-0YOVDfEe_GZ1sJ3syCnZwYqjP4ybwcA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:32 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 12/18] btrfs: inline owner ref lookup helper
Date:   Thu, 27 Jul 2023 15:12:59 -0700
Message-ID: <7932d8390746ab6334c8f1edce6394d10fc930fe.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inline ref parsing is a bit tricky and relies on a decent amount of
implicit information, so I think it is beneficial to have a helper
function for reading the owner ref, if only to "document" the format,
along with the write path.

The main subtlety of note which I was missing by open-coding this was
that it is important to check whether or not inline refs are present
*at all*. i.e., if we are writing out a new extent under squotas, we
will always use a big enough item for the inline ref and have it.
However, it is possible that some random item predating squotas will not
have any inline refs. In that case, trying to read the "type" field of
the first inline ref will just be reading garbage in the form of
whatever is in the next item.

This will be used by the extent free-ing path, which looks up data
extent owners as well as a relocation path which needs to grab the owner
before relocating an extent.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c6d537bf5ad4..09fb321fa560 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2805,6 +2805,57 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
+/*
+ * Helper to parse an extent item's inline extents looking for a simple
+ * quotas owner ref.
+ *
+ * @fs_info  - the btrfs_fs_info for this mount
+ * @leaf     - a leaf in the extent tree containing the extent item
+ * @slot     - the slot in the leaf where the extent item is found
+ *
+ * Returns the objectid of the root that originally allocated the extent item
+ * if the inline owner ref is expected and present, otherwise 0.
+ *
+ * If an extent item has an owner ref item, it will be the first
+ * inline ref item. Therefore the logic is to check whether there are
+ * any inline ref items, then check the type of the first one.
+ *
+ */
+u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
+				struct extent_buffer *leaf,
+				int slot)
+{
+	struct btrfs_extent_item *ei;
+	struct btrfs_extent_inline_ref *iref;
+	struct btrfs_extent_owner_ref *oref;
+	unsigned long ptr;
+	unsigned long end;
+	int type;
+
+	if (!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
+		return 0;
+
+	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	ptr = (unsigned long)(ei + 1);
+	end = (unsigned long)ei + btrfs_item_size(leaf, slot);
+
+	/* No inline ref items of any kind, can't check type */
+	if (ptr == end)
+		return 0;
+
+	iref = (struct btrfs_extent_inline_ref *)ptr;
+	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_ANY);
+
+	/* We found an owner ref, get the root out of it */
+	if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
+		return btrfs_extent_owner_ref_root_id(leaf, oref);
+	}
+
+	/* We have inline refs, but not an owner ref */
+	return 0;
+}
+
 static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 				     u64 bytenr, u64 num_bytes, bool is_data)
 {
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index b9e148adcd28..7c27652880a2 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -141,6 +141,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 				struct extent_buffer *eb, u64 flags);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
+u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
+				struct extent_buffer *leaf,
+				int slot);
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
 int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start, u64 len);
-- 
2.41.0

