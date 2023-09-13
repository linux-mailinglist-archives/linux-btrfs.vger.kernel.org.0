Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD579DD0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjIMANR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjIMANQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:16 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064D1706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AAA5E320093C;
        Tue, 12 Sep 2023 20:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 20:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563991; x=
        1694650391; bh=Ixeb9JpSNzpXGkqNR8txifhVE73rHXZtceR1pGhm2yA=; b=k
        tvzlleBubVrL7bgNs4Ig7dOp5twI20MFD6f2JwHz3roWpZJyqhCrpw4xeluqeI5I
        vyxQOqmMBfwip8h1+Ui+PacL2MTVjWKKwWhjbhLu3PpWf46A6uwbK7L9YZXiZCRb
        pFjhY/eKB4td7+shsB6FTvlpYDqw0qE1dRQ913uJDKXmy3YwfHiMwTihx/9Dc+WN
        dWpuQifylnkNKispJ5DZoazg4hUjxJSL+KC4I6V7k5jZyrb5tE0K8DP7EqDu153E
        ehVu/AdxCfushbJguIzXafPfw26M9ifZKPHh6APyF/kPJNbhpnltpiP/eP7lJtnP
        Qp55Wby+TRxVfsIoKBaYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563991; x=1694650391; bh=I
        xeb9JpSNzpXGkqNR8txifhVE73rHXZtceR1pGhm2yA=; b=k9IcRjYU2rpMcR9ie
        UURkRMqesOzk1NO/avX7jjnxMPjGtx0cb57KinW9ATz7nEM4wFFsvzK3pkeGRvsw
        FVjQm7J1+wOQ2WlBaYaUtmhXRZ0HvXWcsa71Hsl3D9D7quOPDwQqX0Ccxx9BbUsQ
        b8W/2WSrsywIIEVruk0Yn1lepUGUPouV3MIYULlENKhopylpR3fQpe3UKgV+DZ7J
        spqYzt6zd0g1JWS7uLYiOuP3nzWSVLje+Zd4IY0n4GTB3ld+qWrlmVrm0pFM/hAn
        N2f6HD0xn8LK36bGXbVVhVBXc7lMlZYJWdm7/hk/U+Rd4TJG6C2XJ2L5qHz1lzZm
        oNRPg==
X-ME-Sender: <xms:l_4AZbHolJKbdmX3gk-X2X5M60GR4p9HdcX_CUDEcImefJwCjPig7w>
    <xme:l_4AZYU1mHu_FOSySzQz91Jle6oCmHvPX4VF5Nl9gZM-JuxFvaQ3LWet8dSANQtC7
    XU6B1Fs6NzCjhYhl_Y>
X-ME-Received: <xmr:l_4AZdKf4APIxSCDYLAm5Xgz5CnkdlWX51y01sUVS7AfYMOFj1V7mVGR-w5gwvoZvsw5rTb0G7ZPMTkySq7_sx9dk98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:l_4AZZEktizgnC6hwvYKIV83IaD9XtLn4UP2vamwWCPrEFW3qPzAbA>
    <xmx:l_4AZRWcV17jazBNPwhbfq9-nzfMkX0rWK4x62O9-dvC9wGJkat9UQ>
    <xmx:l_4AZUPvyntXziX6FAd_E8myEcE7S5SKx6RSGYorStazdCj6WATJLg>
    <xmx:l_4AZScl37JsnDVsmi0xidCXLSwOt4Olg7BplE5LYY6mw2zV-oOV0w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:10 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 11/18] btrfs: new inline ref storing owning subvol of data extents
Date:   Tue, 12 Sep 2023 17:13:22 -0700
Message-ID: <8256c4f8cfd25f7179e988ea3b35135739319d39.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to implement simple quota groups, we need to be able to
associate a data extent with the subvolume that created it. Once you
account for reflink, this information cannot be recovered without
explicitly storing it. Options for storing it are:
- a new key/item
- a new extent inline ref item

The former is backwards compatible, but wastes space, the latter is
incompat, but is efficient in space and reuses the existing inline ref
machinery, while only abusing it a tiny amount -- specifically, the new
item is not a ref, per-se.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/accessors.h            |  4 +++
 fs/btrfs/backref.c              |  3 ++
 fs/btrfs/extent-tree.c          | 57 ++++++++++++++++++++++++++-------
 fs/btrfs/print-tree.c           | 12 +++++++
 fs/btrfs/ref-verify.c           |  3 ++
 fs/btrfs/tree-checker.c         |  3 ++
 include/uapi/linux/btrfs_tree.h | 12 +++++++
 7 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index f958eccff477..ad8aa1ae5c0c 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -350,6 +350,8 @@ BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 3
 
 BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
 
+BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
+
 BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
 		   type, 8);
 BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
@@ -366,6 +368,8 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
 	if (type == BTRFS_EXTENT_DATA_REF_KEY)
 		return sizeof(struct btrfs_extent_data_ref) +
 		       offsetof(struct btrfs_extent_inline_ref, offset);
+	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
+		return sizeof(struct btrfs_extent_inline_ref);
 	return 0;
 }
 
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b7d54efb4728..0cde873bdee2 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1129,6 +1129,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
 						       count, sc, GFP_NOFS);
 			break;
 		}
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			ASSERT(btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));
+			break;
 		default:
 			WARN_ON(1);
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 336957737c6c..4fb8fd9d9e40 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -344,9 +344,15 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     struct btrfs_extent_inline_ref *iref,
 				     enum btrfs_inline_ref_type is_data)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int type = btrfs_extent_inline_ref_type(eb, iref);
 	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
 
+	if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+		ASSERT(btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+		return type;
+	}
+
 	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
 	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
 	    type == BTRFS_SHARED_DATA_REF_KEY ||
@@ -355,26 +361,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 			if (type == BTRFS_TREE_BLOCK_REF_KEY)
 				return type;
 			if (type == BTRFS_SHARED_BLOCK_REF_KEY) {
-				ASSERT(eb->fs_info);
+				ASSERT(fs_info);
 				/*
 				 * Every shared one has parent tree block,
 				 * which must be aligned to sector size.
 				 */
-				if (offset &&
-				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
+				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
 					return type;
 			}
 		} else if (is_data == BTRFS_REF_TYPE_DATA) {
 			if (type == BTRFS_EXTENT_DATA_REF_KEY)
 				return type;
 			if (type == BTRFS_SHARED_DATA_REF_KEY) {
-				ASSERT(eb->fs_info);
+				ASSERT(fs_info);
 				/*
 				 * Every shared one has parent tree block,
 				 * which must be aligned to sector size.
 				 */
 				if (offset &&
-				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
+				    IS_ALIGNED(offset, fs_info->sectorsize))
 					return type;
 			}
 		} else {
@@ -385,7 +390,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 
 	WARN_ON(1);
 	btrfs_print_leaf(eb);
-	btrfs_err(eb->fs_info,
+	btrfs_err(fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
 
@@ -886,6 +891,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	while (ptr < end) {
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
+		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+			ASSERT(btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			ptr += btrfs_extent_inline_ref_size(type);
+			continue;
+		}
 		if (type == BTRFS_REF_TYPE_INVALID) {
 			ret = -EUCLEAN;
 			goto out;
@@ -1737,6 +1747,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 		 node->type == BTRFS_SHARED_DATA_REF_KEY)
 		ret = run_delayed_data_ref(trans, node, extent_op,
 					   insert_reserved);
+	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
+		ret = 0;
 	else
 		BUG();
 	if (ret && insert_reserved)
@@ -2308,6 +2320,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
 	u32 item_size;
+	u32 expected_size;
 	int type;
 	int ret;
 
@@ -2334,10 +2347,22 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	ret = 1;
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
+	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
+
+	/* No inline refs; we need to bail before checking for owner ref */
+	if (item_size == sizeof(*ei))
+		goto out;
+
+	/* Check for an owner ref; skip over it to the real inline refs */
+	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
+	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
+	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
+		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
+		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
+	}
 
 	/* If extent item has more than 1 inline ref then it's shared */
-	if (item_size != sizeof(*ei) +
-	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
+	if (item_size != expected_size)
 		goto out;
 
 	/*
@@ -2349,8 +2374,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	     btrfs_root_last_snapshot(&root->root_item)))
 		goto out;
 
-	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
-
 	/* If this extent has SHARED_DATA_REF then it's shared */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
@@ -4610,18 +4633,23 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root;
 	int ret;
 	struct btrfs_extent_item *extent_item;
+	struct btrfs_extent_owner_ref *oref;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	int type;
 	u32 size;
+	const bool simple_quota = (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE);
 
 	if (parent > 0)
 		type = BTRFS_SHARED_DATA_REF_KEY;
 	else
 		type = BTRFS_EXTENT_DATA_REF_KEY;
 
-	size = sizeof(*extent_item) + btrfs_extent_inline_ref_size(type);
+	size = sizeof(*extent_item);
+	if (simple_quota)
+		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
+	size += btrfs_extent_inline_ref_size(type);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4643,7 +4671,14 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 			       flags | BTRFS_EXTENT_FLAG_DATA);
 
 	iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
+	if (simple_quota) {
+		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
+		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
+		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
+		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
+	}
 	btrfs_set_extent_inline_ref_type(leaf, iref, type);
+
 	if (parent > 0) {
 		struct btrfs_shared_data_ref *ref;
 		ref = (struct btrfs_shared_data_ref *)(iref + 1);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 0c93439e929f..8860075ab25e 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -80,12 +80,20 @@ static void print_extent_data_ref(const struct extent_buffer *eb,
 	       btrfs_extent_data_ref_count(eb, ref));
 }
 
+static void print_extent_owner_ref(const struct extent_buffer *eb,
+				   const struct btrfs_extent_owner_ref *ref)
+{
+	ASSERT(btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));
+	pr_cont("extent data owner root %llu\n", btrfs_extent_owner_ref_root_id(eb, ref));
+}
+
 static void print_extent_item(const struct extent_buffer *eb, int slot, int type)
 {
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
+	struct btrfs_extent_owner_ref *oref;
 	struct btrfs_disk_key key;
 	unsigned long end;
 	unsigned long ptr;
@@ -161,6 +169,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
+			print_extent_owner_ref(eb, oref);
+			break;
 		default:
 			pr_cont("(extent %llu has INVALID ref type %d)\n",
 				  eb->start, type);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index e9e1ebd8dd6a..1f62976bee82 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -485,6 +485,9 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 			ret = add_shared_data_ref(fs_info, offset, count,
 						  key->objectid, key->offset);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			break;
 		default:
 			btrfs_err(fs_info, "invalid key type in iref");
 			ret = -EINVAL;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8ad92aa43924..01bba79165e7 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1466,6 +1466,9 @@ static int check_extent_item(struct extent_buffer *leaf,
 			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			break;
 		default:
 			extent_err(leaf, slot, "unknown inline ref type: %u",
 				   inline_type);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index a4b44b13fff5..e60b62c1627e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -230,6 +230,14 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
+/*
+ * Special inline ref key which stores the id of the subvolume which originally
+ * created the extent. This subvolume owns the extent permanently from the
+ * perspective of simple quotas. Needed to know which subvolume to free quota
+ * usage from when the extent is deleted.
+ */
+#define BTRFS_EXTENT_OWNER_REF_KEY	188
+
 /*
  * block groups give us hints into the extent allocation trees.  Which
  * blocks are free etc etc
@@ -787,6 +795,10 @@ struct btrfs_shared_data_ref {
 	__le32 count;
 } __attribute__ ((__packed__));
 
+struct btrfs_extent_owner_ref {
+	__le64 root_id;
+} __attribute__ ((__packed__));
+
 struct btrfs_extent_inline_ref {
 	__u8 type;
 	__le64 offset;
-- 
2.41.0

