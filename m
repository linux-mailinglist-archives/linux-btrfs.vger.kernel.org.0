Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2675BADA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGTWzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTWzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799851999
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 90B2C5C01C1;
        Thu, 20 Jul 2023 18:54:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 18:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893689; x=
        1689980089; bh=9fAh8ZEKDorlwLLTutooJL2nX4ML3Pjoa6m+dYsxiic=; b=S
        TGde2BwPH0wKP5i1KLkO2tUZwRk0+IVgI3MfdpP7Xxix9C9stG6888caJ7Ix1e1A
        3YiaZhqc1M7AvmaWO195W02A/VM+6RCk2vHGjS6aoIddKmWyB+hCtsjSRqrD3vWZ
        w5P1NgETADyNhS5VqL6VYHY6RnsNIUnyOLwpaRPSDDwMAXKPWNU19bGiVbB2ACaU
        jYki/ooylHh1vYYT0F96DIy/QryoFa6/FSe/LDWdnCo2eveaPfQjJMASFBnRyQST
        IwzadbwSfB7ZV/tI5TB8KoCzt6+nV3lahZ2GGlYEd+hRz3L3+9Es6GCLMdskXO0i
        wN9YMmaVT/hcmU+w9pPAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893689; x=1689980089; bh=9
        fAh8ZEKDorlwLLTutooJL2nX4ML3Pjoa6m+dYsxiic=; b=I7098st//e/fv/TkA
        gu6kkv3IIuqZVHEGAtJYQjuKjO11prpnDwZhgCMxVTO7BQWPoB+OUEkduuWXQDXI
        9M+CaaoMY8nMwnyonI0aKiDn3uYvTdikuR6J2B2ps1mlEc0o8xF6iaMyTj4EKtL6
        bvKG76RRgXvfuOqQ+iS8U9F3kfPNn/tqgo9IIFXb5v4jVBkfSzsAl543twNbf7ie
        5RiCEdGt4jmIrBAZ+XgZ+xaOj6J8XQlJlTYeQQecEZL+m++7y0kmdyGoOQbRZFXg
        S2eDzzI50RAPxpn7lcR0hxwjnvfZ7b9HTjMKeVeEtr2MJPhz2jK+SK8JRk0/LCXV
        0424A==
X-ME-Sender: <xms:Obu5ZK87NbWjLmqZ7JTLcB7DHk_GTHwAxGXV_KPPxz69v4AL2Ab4jw>
    <xme:Obu5ZKu_kwomqNwKXfCy5E_CXCHjTFzLb7jLBXhOI-MbkQzmkvphN5XTseg5-0caq
    rsiEvm7-GfJ8c42l2g>
X-ME-Received: <xmr:Obu5ZACWIDJx6fTdE88C4jNXxZe8bTNLunyWa99IcOuFtDTTa0bBdYvJ1X1tfNBffxNQJJqb9hglYKIAC52zX1gsL2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Obu5ZCdKhysBWvwbQO8b-CcrSU1lzbw6cPqWySzYazZFoSwo9wIMUg>
    <xmx:Obu5ZPNgcX8Avot0_uvlZX8m8Vfpex42B2Dz1OjR0SEHwtWCdnAvKQ>
    <xmx:Obu5ZMk1S7vr7n6yARJpLuQTDxnA7OFWq5L6fF3NB_vwa1GQ13uFGg>
    <xmx:Obu5ZBVzqom2DXmA9G47hZNMTS9MJmmL81aCdaCYP4aJXsGEY-TuRw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:49 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/20] btrfs: inline owner ref lookup helper
Date:   Thu, 20 Jul 2023 15:52:42 -0700
Message-ID: <2ca5afd4bc89d37deb6a3fac1093ae1713aab68d.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

