Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C875CD15
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGUQEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGUQEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:43 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617B30C7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EEE9332009A6;
        Fri, 21 Jul 2023 12:04:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 21 Jul 2023 12:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955480; x=
        1690041880; bh=9fAh8ZEKDorlwLLTutooJL2nX4ML3Pjoa6m+dYsxiic=; b=V
        fCvP3YPj2vV1KsqOQh22/tgozHfT1WVtjfiMD6Rim29gWQ058dvDATzjQfdle4ga
        RXUbMF2Lx3mbhhsTqWNeVn+dzz2elcPOlZu92pVs6E0wC0ox/6KtTnOwhyiDKMiX
        xRYXSw6Qhymk8fLBtdPStC81hHArz02yOGgvfEIUAQA6OLQ9YLYyTb+ynGufDQ3f
        04YNCQJ0tJ6hW8SADhvYLAtu1fxOZitQ5ouZSVLikOmjWfTuFrXCzeGWEtMUrlUI
        uZheeD9UcuQKs064V7lINsWnzUI+WLohK41SPFPEYnCfHJZ3IiOt09H4dWg+KFMz
        i0pOOV042pIO4bLXZty9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955480; x=1690041880; bh=9
        fAh8ZEKDorlwLLTutooJL2nX4ML3Pjoa6m+dYsxiic=; b=kA99Tj5zqH3ScWLlc
        5GENaD9tVv/dLtZAMofHNYdYBtsFMxWvt2IJaX15+98ST3Egn+ccU8LZJMoHbJkq
        51KDzgWrjnYAmXO2NQfOS3yxYycZj5wY0Iw3fSeemPdP99ZfWBXh/sC+2Zlg3Dx5
        rCKtdXR+SkRy9ncDvRjJx+q8NbLuPPBfrCsu62CEziGkDqQpGZSq0QdnfANCH2eK
        Sld0oM0bfS7oLjrCX8f8kfGFFbxkk1+RbDxaFbcWx6F+uObdOVrPluzn6ARQqu7j
        ch/IpiyVDGYLV/31IT3GX7iBuM9PGDKQL4uerfR7stxaovV7Lc5Ajd1Wl8E1GA8H
        wmlwg==
X-ME-Sender: <xms:mKy6ZK41s0hGaquy6hNv8Uo9lfkdD89ftWKkeM2fgKQc1HbUdHWIDg>
    <xme:mKy6ZD5L5p6gIN2gr5YB70yr6LJpiYlAOe6-wM68RrPtzYumzRJ79fpfYoUOVkLZR
    CSjmmIfbX53PDSsCA0>
X-ME-Received: <xmr:mKy6ZJcVMKgaoJiMt1FurCqZvKc-JFAVfgVXpApRUmhIn2vmVY2ky3-xMJ27aMhmVyDFs2LnDkm7O6_AYCHp4axKK4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:mKy6ZHJH9u0C7AQfXR4tYJJFIZZzXd6IPK9b4MrVl7iZyRIXZtRqTQ>
    <xmx:mKy6ZOKbaItRkKZLx0iSlqja0CRHjDkJiuQ-KaKZBZ_JJxRT8LzP-w>
    <xmx:mKy6ZIwH1oixcIur1EbsF0YMRK_Uq700pY7_J_jRSSubxCfPUC7rEg>
    <xmx:mKy6ZIyuu5sXbrogj_gbNHBfLvBPd0C8_jpaGK-HqDFFyz8O_AsjKA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:39 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 14/20] btrfs: inline owner ref lookup helper
Date:   Fri, 21 Jul 2023 09:02:19 -0700
Message-ID: <fc9729477aef5a125130de1a9a76a7b7946bde1c.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 85f23238456c..7636c0361a61 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2799,6 +2799,57 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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

