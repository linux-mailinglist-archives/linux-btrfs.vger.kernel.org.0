Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8367491D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGEXXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjGEXX1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD3171A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 89CA15C028D;
        Wed,  5 Jul 2023 19:23:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599405; x=
        1688685805; bh=Z4Gs6nbYRxaGnbhD9LdDwK/uWxdm23BqDfWAYpQ+j2A=; b=X
        Z3ATAoFXxT/BgLTPESruQw95zAXklwC1hQSi9p0KafdN/MIVhOFRk+nCYO3qWOHa
        dEE+nnEADiGmli/IYdIeAZmESMfTwimi2UGq3d/5qyXlE8UENLLan5GkSpa49sVP
        AHzAM+gA6dmHohgwtR50GMdwE+OZPSB0+oIzVd2p/9RU4bC/1nkBI07dHaK1Qsru
        hj2E4zh9W/2VhCKeNy1w8osuGxDNkRUzO+mTSy2faur4/B5+a/uAYzQW2RAjWTor
        fzBMFxvctsPkrgPS2jZr9/QZDKhjJV0i+bTP/eyh32gVsknsp1CmiwDa8bpV3fcn
        2HAguMrrNqCem7pE58JDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599405; x=1688685805; bh=Z
        4Gs6nbYRxaGnbhD9LdDwK/uWxdm23BqDfWAYpQ+j2A=; b=hm/X27BTVjL7ViSet
        g0MZJ4blWYsbMYOKpJjfayA/coObUyrO3rtNzNzKub2w+hHrJsQk3J917QRGtqEG
        iN+j70m4hFneWnwavj8FnU0RIvMenX+Ac1bziMn/uuRL9fVvg3UbcxCotYDSSs+w
        cOUs4ZOH1n83fZySEDJU8Z6yc3a7W5twYmmBnoCyF3PsDrcK8z1JbC2g51Jjprwj
        bsMhNX7X3qV5ZrYW70W3Py9YU2RsOhqiE2VhzrySJklLlwLTK7bCar9O/sCB9z88
        GsUdp7alsS/X3MYLer45RU+5ISRzn8xRW10DwSeTU/c6t5Y/2Lk0F9L7J4XVMuDe
        prdLw==
X-ME-Sender: <xms:bfulZLSNTjQxEJlQl7E2-AH-ydOq_WaCT-Xi74EUxPYgDYjzGpKiPg>
    <xme:bfulZMwpqNozqLiRSjSCXvrpVUVUdLk51Rap-0bl2_dF_60HUlpI38Pfi5tRIMHdS
    wzyzyAZsRwHDepaB_8>
X-ME-Received: <xmr:bfulZA1sl5YI__dNsmt-XnmUZlJfxG1pmMnmtMJeN6GWsd4VE4Z8Tio-MlViGU45LrDinmtarMgM49wr8z6oswauA5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:bfulZLAbbFCcWTmUY8w4VnspFLNkOh5PUzh6NSE2Fv3TA-AUxgixPA>
    <xmx:bfulZEiua8EyswP1vyfS5RAosjyzv9xizykJ5_vUWbJPsl240gizyQ>
    <xmx:bfulZPqAtLRnznbG9eZ_baVyZyHiggDq4PW8wdZ5_rCf4uMLPUKJTQ>
    <xmx:bfulZMIdz072Kuo5Uq4QjsHzLc5qkrK-rYPEPWrKV-MhlSecdq13QA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:25 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/18] btrfs: inline owner ref lookup helper
Date:   Wed,  5 Jul 2023 16:20:50 -0700
Message-ID: <d3c4af6907e2198639cf87e61ee17f7ab504f0c0.1688597211.git.boris@bur.io>
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
---
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3313f3d7d4ae..c8f767d7e261 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2821,6 +2821,57 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
index 429d5c570061..9c8fd96cbee7 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -144,6 +144,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
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

