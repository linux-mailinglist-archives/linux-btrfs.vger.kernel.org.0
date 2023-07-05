Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAB7491D0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjGEXXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjGEXX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E0198E
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D63975C0281;
        Wed,  5 Jul 2023 19:23:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599403; x=
        1688685803; bh=QKh0tgqhtGxgsxuW9+z1Fvc2Qk9Qm3eBGgcUo8DHsi8=; b=D
        wlAaI0o5XR7L/SvtoJjjStLKn8rhOFgiADvbG01fTq7griqxIFGuASzKD8j3TdB1
        TF4vh3YAO/AnSn47gJeKP0AgAAnAAsfZb4g6TTj9D14UBwEebqXhTa/vaINw3XzK
        oK2hDZ6GnI8qkfOW9BRL4EIzJNXx2UpmwgoYcaJ/R8N15nvkZEUHg60WhIHr3ySy
        m0Y5GEmcRjnIismFHLSesiKzrcnLjVTOUUSZVEsDuBlw6+QQhJj/zovAHEKzo5Nb
        Ooq9WtT+VZqpDog9v0LV83DdbeLY0pGlNNgdrCFZodcVhcveUi0uSiIBkbAGeuoJ
        Fbsd3c+VxzObSFMNeiHUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599403; x=1688685803; bh=Q
        Kh0tgqhtGxgsxuW9+z1Fvc2Qk9Qm3eBGgcUo8DHsi8=; b=QgfH9Kz2HnZ1jJbQE
        Rc963oKG6EHh3UavtTB6+fRVUKCPxBwFXPHOjI5ASO3npi9TNoTMU8vqMKM7iKcI
        Cqhdyrks8bZPkDivcYADJJmGIwhi4YkRsPRCk+7hf3GmaFuNhorOwJOev/W0czzt
        /M3YFeyVDBG2/bcVMpZFaoS4nlPujGVC239kOBUnXvBX19LsuJjKEb36L43/PhBK
        5QiDEktoqJVvu4gt3hU/Z8HYssRcs2fu+EPcdpp920tHMtU2GJEeFKrhzs+hzNhA
        Gqsic/2M2WwMc1gMTQR7dafGowTFwn10ldR35SWlJmZ8ARIU8LZ6phzZaLJU5qQj
        UGlJg==
X-ME-Sender: <xms:a_ulZP4pNKXK6kcdd9IF25jB72f5gngWLQrh5nKLk0vMWNCoWe0cgQ>
    <xme:a_ulZE4xDnewQvr5X7JTJQr02k34T3MjT-kJdEH3lOLkgu-sIz6Xn_G4QT2Bx3Vzv
    khCHSMxRXFS_7lKhN4>
X-ME-Received: <xmr:a_ulZGdqn4C-ewoBJcH_muxMWf9GX6CaJKWYIG0yG5ulTmgpmFkSTT5C6F7Uyymg2Kqc_0qZz_du7RJ59CaAn8g16Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:a_ulZAJEUKvVUkYJLZGA0Thhe0XWc3qZWnd4RsUs-ty5S8lOCEQaVA>
    <xmx:a_ulZDKFYriP7tj8yobJZKO0OuXDAnYHLcvSPwjScfolGMyqG2XK5w>
    <xmx:a_ulZJw-nKwRBVJhRGRunTEk8Dtydom4OXgt-5zxcO4exMa27RH7iQ>
    <xmx:a_ulZFzN0hltMFR21j76ExwrEay3CCGZTSQ8Ywf3w7-xjRxQebZWCA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/18] btrfs: new inline ref storing owning subvol of data extents
Date:   Wed,  5 Jul 2023 16:20:49 -0700
Message-ID: <8d5a36641f7d79b66a1b306cee87f52bf1fb3b23.1688597211.git.boris@bur.io>
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
 fs/btrfs/extent-tree.c          | 51 ++++++++++++++++++++++++++-------
 fs/btrfs/print-tree.c           | 12 ++++++++
 fs/btrfs/ref-verify.c           |  3 ++
 fs/btrfs/tree-checker.c         |  3 ++
 include/uapi/linux/btrfs_tree.h |  6 ++++
 7 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ceadfc5d6c66..aab61312e4e8 100644
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
index 79336fa853db..d5bb6a880713 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1129,6 +1129,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
 						       count, sc, GFP_NOFS);
 			break;
 		}
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			WARN_ON(!btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));
+			break;
 		default:
 			WARN_ON(1);
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fa53f7cbd84a..3313f3d7d4ae 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -363,9 +363,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     struct btrfs_extent_inline_ref *iref,
 				     enum btrfs_inline_ref_type is_data)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int type = btrfs_extent_inline_ref_type(eb, iref);
 	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
 
+	if (type == BTRFS_EXTENT_OWNER_REF_KEY && btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
+		return type;
+
 	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
 	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
 	    type == BTRFS_SHARED_DATA_REF_KEY ||
@@ -374,26 +378,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
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
@@ -403,7 +406,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 	}
 
 	btrfs_print_leaf(eb);
-	btrfs_err(eb->fs_info,
+	btrfs_err(fs_info,
 		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
 		  eb->start, (unsigned long)iref, type);
 	WARN_ON(1);
@@ -912,6 +915,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		}
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
+		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
+			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			ptr += btrfs_extent_inline_ref_size(type);
+			continue;
+		}
 		if (type == BTRFS_REF_TYPE_INVALID) {
 			err = -EUCLEAN;
 			goto out;
@@ -1705,6 +1713,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 		 node->type == BTRFS_SHARED_DATA_REF_KEY)
 		ret = run_delayed_data_ref(trans, node, extent_op,
 					   insert_reserved);
+	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
+		ret = 0;
 	else
 		BUG();
 	if (ret && insert_reserved)
@@ -2271,6 +2281,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	struct btrfs_extent_item *ei;
 	struct btrfs_key key;
 	u32 item_size;
+	u32 expected_size;
 	int type;
 	int ret;
 
@@ -2297,10 +2308,17 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	ret = 1;
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
+	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
+
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
@@ -2312,8 +2330,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	     btrfs_root_last_snapshot(&root->root_item)))
 		goto out;
 
-	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
-
 	/* If this extent has SHARED_DATA_REF then it's shared */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
@@ -4564,18 +4580,23 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root;
 	int ret;
 	struct btrfs_extent_item *extent_item;
+	struct btrfs_extent_owner_ref *oref;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	int type;
 	u32 size;
+	bool simple_quota = btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE;
 
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
@@ -4596,8 +4617,16 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_extent_flags(leaf, extent_item,
 			       flags | BTRFS_EXTENT_FLAG_DATA);
 
+
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
index aa06d9ca911d..3fac15ce0db0 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -80,12 +80,20 @@ static void print_extent_data_ref(const struct extent_buffer *eb,
 	       btrfs_extent_data_ref_count(eb, ref));
 }
 
+static void print_extent_owner_ref(const struct extent_buffer *eb,
+				   struct btrfs_extent_owner_ref *ref)
+{
+	WARN_ON(!btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));
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
@@ -159,6 +167,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
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
index b7b3bd86f5e2..c0660233feb4 100644
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
index 038dfa8f1788..72d29ab74a01 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1451,6 +1451,9 @@ static int check_extent_item(struct extent_buffer *leaf,
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
index ab38d0f411fa..424c7f342712 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -226,6 +226,8 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
+#define BTRFS_EXTENT_OWNER_REF_KEY	190
+
 /*
  * block groups give us hints into the extent allocation trees.  Which
  * blocks are free etc etc
@@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
 	__le32 count;
 } __attribute__ ((__packed__));
 
+struct btrfs_extent_owner_ref {
+	u64 root_id;
+} __attribute__ ((__packed__));
+
 struct btrfs_extent_inline_ref {
 	__u8 type;
 	__le64 offset;
-- 
2.41.0

