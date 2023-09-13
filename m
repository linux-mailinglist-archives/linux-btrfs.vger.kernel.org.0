Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9E79DD0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjIMANU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMANT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1001706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 54F52320093C;
        Tue, 12 Sep 2023 20:13:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 20:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563993; x=
        1694650393; bh=h1MeA0in5gQ9ykVn6wpcdrwY1FhiRV4SiNAZTQ3HGqw=; b=k
        omiVqFsHuH8o0Wmn/Ly5WHzXkyYRxycP7shyQvPahUpjIkvMXg9Mshn5A6odUWFp
        6ixrgi1JdYNx/QgHYUrf7kbk85u/NPL8t+jby+ULkNiBIvThIf/fRCfhrLYeSMoU
        s7GRXpJxF7NY6Sd4kVxwm/LqRFam1UhsmL6ZNmtMh7X3p+126LHsj27MmiBn0RBW
        L4MiYXEykWD7YCyZOlr2PglTSvYvV3sr9Kbf/iAyh7mFxwWacL9iEUPiMeyyNazz
        6d8YQNofnhtlTGMFUX7km+7B0st3HiWcdAp7R6FxuPOlVsWBiohw8dtwzyRD/wye
        w9t4XVybPGp3LMn3dLAxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563993; x=1694650393; bh=h
        1MeA0in5gQ9ykVn6wpcdrwY1FhiRV4SiNAZTQ3HGqw=; b=coQ2S+hfmtn9DQ0Y2
        Rh1oSaOxoODcliIMiz2eYhhv4l6z8I9gnYtYZZ0uJa2d2TDrANXdv8bg0u4rrwhm
        QJwrfs8Tbv1t+xLrPrBRdgQ/HLu7X9nLry8f0gFqaz2MzB1UmPR7PtSe9C5CZrPc
        km6AGpN/zJ/nvYeAUxWRKxAes7Ip3XV9l3B6HRR9WguQl0hoTxWexWl7iZT3xrLO
        kPg6GR80vKzQg0zsif4tJQD1xPs443fD2JO5Y/rnwNTst0xXnTVLfzDZBvg3BWn3
        6nYqr+PaKNY+Hou19utEbabeVH233f9LwLbVb0Z8tHG07H/+8vpoH36vCv/P1nyw
        VlG8w==
X-ME-Sender: <xms:mf4AZSWD0sn8UC6CEC0DJiPTMaQPJKHAxqA04Yp4xt613jCgwqu6sg>
    <xme:mf4AZekwh1QBVF_O-2bwHJWSX-Un1pwn-9B6DegRjNimTDsjikBd06fbAaDrw0arp
    K4xl3MG7u2riKjsoAE>
X-ME-Received: <xmr:mf4AZWaBrY98afyNR8pA3aBFMDSHpifuQxQLL6hknJu0uB7Z7scRh9EPW-TSbLsBFiCuhUW84fzX_zvvASCznhocsUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:mf4AZZUoDRKdOyQJlou535ZS_btsBZQImaNCYoZfJxsg_QbOin-KLA>
    <xmx:mf4AZcnpr13oSCi7Wl-OQLL4zdfbht0716NvWkmbxwLWT-u1Hp3-gA>
    <xmx:mf4AZee8I0SORd5qIWVoYvY-HUvUIxUCAvspIHd5AFIRhQ2kQFR_SA>
    <xmx:mf4AZTslx36AzdCye_VDmyuQ_cyVb8VdM7JB07vM-Dle2gbXKrnZqw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:13 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 12/18] btrfs: inline owner ref lookup helper
Date:   Tue, 12 Sep 2023 17:13:23 -0700
Message-ID: <8c92388560eace362e182f6416141a45957fe41d.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/btrfs/extent-tree.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.h |  3 +++
 2 files changed, 53 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4fb8fd9d9e40..249b3bfe181a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2865,6 +2865,56 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
+/*
+ * Helper to parse an extent item's inline extents looking for a simple
+ * quotas owner ref.
+ *
+ * @fs_info:	the btrfs_fs_info for this mount
+ * @leaf:	a leaf in the extent tree containing the extent item
+ * @slot:	the slot in the leaf where the extent item is found
+ *
+ * Returns the objectid of the root that originally allocated the extent item
+ * if the inline owner ref is expected and present, otherwise 0.
+ *
+ * If an extent item has an owner ref item, it will be the first inline ref
+ * item. Therefore the logic is to check whether there are any inline ref
+ * items, then check the type of the first one.
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
index 397cccafc885..5a02faa05464 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -137,6 +137,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 				struct extent_buffer *eb, u64 flags);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
+u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
+				struct extent_buffer *leaf,
+				int slot);
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
 int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
-- 
2.41.0

