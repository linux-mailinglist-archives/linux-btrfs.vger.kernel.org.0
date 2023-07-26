Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD997640AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGZUlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGZUlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED18211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 188D65C0116;
        Wed, 26 Jul 2023 16:41:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Jul 2023 16:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404064; x=
        1690490464; bh=a50CTy9NdFASIxp8tSCPfQqoNkZI4nMeuv/lYiAY+9s=; b=B
        eGis74VULbk2HUp/QEkaNb38xz78+V9XylLsph4XQwqx6pexgo0bhS0rVh5dIuZl
        GbBpZxSQ2edGXk779thNaOUz/xi6ukG/2FfIHTI3Fvb9SfWBwRr7IWC3SLckGo65
        k6KEGp7eEuJcvl42uPAz5RsNLVywEXkE7m2cIBs4zxBuCYsujVWImj/8VxaEkksR
        UGf/JfCzJyLqB2gWldT8ss1uHoGpSKi4Z2j24t2UMF6NgvdmbMl3ktgIriNY9blp
        PykBbiwGqp/APKaMD/2GMWVhCju7iqYZS7SpCOcbCgeyDWVNDOI9SzN/uAzcACB8
        A6d8f5/nP9acEdpeKGAPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404064; x=1690490464; bh=a
        50CTy9NdFASIxp8tSCPfQqoNkZI4nMeuv/lYiAY+9s=; b=VRj53w+oPUpqvYqH9
        tPG99xzF0KEiUW0YJaVo4vrq/oeRuNhNfqF4ddoAn/WQjlizGxNSvB7L7i7blsNy
        gfQ6GAqlbCeUlu0Rj94kurelVOHSA6VcRmw2EMpllJaeXQN+hqGi6TTTX10hjd1y
        yd10zLYPDSy0ylZjWYtvvAQ8nksGGSWjjvHKw16tHTg8WVq/f4d9KEGJ5o6WGkCo
        MCfV14I5ME7N77aVHVF71ksa3HDa1txHoAUpAupFbOPzQqbTIM6466kB4f8gy3zm
        xt2eQAPmxSeokDbbpi/JTgVuhvr68Jzxvti3ohLeSZnjgh4CuLkIxnu1qlqyoDjm
        zv5qg==
X-ME-Sender: <xms:34TBZBBLwTvecjjA3u7CIcPNs0rGbGIdc_m5vLNjnpJ2qaKaCo3-Jg>
    <xme:34TBZPhxc3U265tZrtOBSJ47e1ntyVTd0mMmW1HMUxvr5kk-w4zg92rwQeO_sELjS
    FpI-6-H7ALPncSFRwc>
X-ME-Received: <xmr:34TBZMmujNIs5nDSz2TG7ZXvtW3NmdBykt3CO7yEg_pzFGUnSrCuoOpDS2mH-kuCx_B3ETxv2R15JB7sHQMfHmPfSt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:34TBZLxtHr_D92y-OdeiP1B3tr3tO30zSaUUSRizKPBpj569kFkELg>
    <xmx:34TBZGRlHyRSaCvoOV5H8HO3olvgQ9FKuR53J9BwBF-KdElcmS_Jqg>
    <xmx:34TBZOafjEeSPzFtKKGlyqqaQ7KiHtN241Rtj5-60QIgmvTHrc0GMA>
    <xmx:4ITBZP57C8e6A1mOjqZl-SgdsLYe8DweXqsLg_q9gylpBjMd0pfZcA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:41:03 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 12/18] btrfs: inline owner ref lookup helper
Date:   Wed, 26 Jul 2023 13:38:39 -0700
Message-ID: <c43550d1d5068ca8a596704bcd25d2ec1ea6f3bb.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d3b09e2269b0..9b44fb85eed4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2804,6 +2804,57 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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

