Return-Path: <linux-btrfs+bounces-14484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7EACF438
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C627A9607
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002962749E9;
	Thu,  5 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LPG3czEn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577225DAE2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140637; cv=none; b=EuzUqJp6axgYp9/1aavKuCAbQbYp9h6sZw5tAVGzgLFPlM5yinzwHO2lYAwDqpaOeA+AFmF13I+Y+u8dv2Ts39QubzkWG8g7hPnUI19ssuNm7uEwZgy98y9NbHn/M6xgwmbcB6aAqTleuQOu5DnDB1vcTClf/MsKDFoWm1aDLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140637; c=relaxed/simple;
	bh=YKisNki+rddCzt5iScEQfSrsAjpHJK5i9GAYQ91bu+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Adv+/ixjgUvknyInk2HB17zUKg77pHvwrnKe8GPEc7o2WK+P/ax+XELZdEAn8q8vUIIFRJtBjxlZM4LDmaR+Cdi3qLWyrh224caAA1vZjuyi9StLwOZJn1035IE/AuqLXG+dE1Z1SSegLiyqF+pO/3WOqPhHEOqXWgb8DUdKvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=LPG3czEn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bQ027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=y
	0OoguOtUbuRTw0eRS6p70bPC+H2LBHpY1OGqyr1xuY=; b=LPG3czEnEyob9VdP/
	RiV7VfTMcJvSJzRUTj6ila/fcfLk49ru01enQaM8msWgTasiH5TVIRl5thS1eCUT
	dTxOwUT33hbasuFaE5M3vXutd4+ZzEvK9E69OghiBMTsWiv46W9x1myoOKy9jmgD
	aD3OGkUk5oV+1lOE3dwcv6ePeE=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:53 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:50 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4B995FEC2E68; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 05/12] btrfs: don't add metadata items for the remap tree to the extent tree
Date: Thu, 5 Jun 2025 17:23:35 +0100
Message-ID: <20250605162345.2561026-6-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c499 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=Lw2Pa3WXfBixVx5LH7YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX30Lhi7YkVPzn 94wpiInVqxWrJ2EY7cfYzRJISaHhPS3tCpzMv+mTD/CAngkoobaUbDRZLHxnP5H+FN3Iy0yrUVE mxBydFZMs4AWpk18iTE2tU81732xLL3kg2qSc7mgzUXRFePVT/R3Ei+DUNJ3AxJkwGWmYY6E8p7
 JijSUsnDauGqUdfZ3CqIpf9emChkVcMdppfgXsyPDj7w2zvwP2gzrcY30/H3+LrdAS1Pbxj+Rc7 TKnuL/3gXPrtFyk3O3vUtz0yWCedIT1pJWyb6/5a1RPTT0Gehpzs7K5L2yiR/+00wjOmILfDu4H DoICTs4f27mzg7tRCbVFgM+cMwkWtwNnAzczPCSr6lR5jMvs5Aj6rIcHDmJO2M=
X-Proofpoint-GUID: V0cxOOrRZQQb6vtxuVbtPnKgQ8dBVvdg
X-Proofpoint-ORIG-GUID: V0cxOOrRZQQb6vtxuVbtPnKgQ8dBVvdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

There is the following potential problem with the remap tree and delayed =
refs:

* Remapped extent freed in a delayed ref, which removes an entry from the
  remap tree
* Remap tree now small enough to fit in a single leaf
* Corruption as we now have a level-0 block with a level-1 metadata item
  in the extent tree

One solution to this would be to rework the remap tree code so that it op=
erates
via delayed refs. But as we're hoping to remove cow-only metadata items i=
n the
future anyway, change things so that the remap tree doesn't have any entr=
ies in
the extent tree. This also has the benefit of reducing write amplificatio=
n.

We also make it so that the clear_cache mount option is a no-op, as with =
the
extent tree v2, as the free-space tree can no longer be recreated from th=
e
extent tree.

Finally disable relocating the remap tree itself for the time being: rath=
er
than walking the extent tree, this will need to be changed so that the re=
map
tree gets walked, and any nodes within the specified block groups get COW=
ed.
This code will also cover the future cases when we remove the metadata it=
ems
for the SYSTEM block groups, i.e. the chunk and root trees.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/disk-io.c     |   3 ++
 fs/btrfs/extent-tree.c | 114 ++++++++++++++++++++++++-----------------
 fs/btrfs/volumes.c     |   3 ++
 3 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 60cce96a9ec4..324116c3566c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3064,6 +3064,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *=
fs_info)
 		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
 			btrfs_warn(fs_info,
 				   "'clear_cache' option is ignored with extent tree v2");
+		else if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+			btrfs_warn(fs_info,
+				   "'clear_cache' option is ignored with remap tree");
 		else
 			rebuild_free_space_tree =3D true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46d4963a8241..205692fc1c7e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3106,6 +3106,24 @@ static int __btrfs_free_extent(struct btrfs_trans_=
handle *trans,
 	bool skinny_metadata =3D btrfs_fs_incompat(info, SKINNY_METADATA);
 	u64 delayed_ref_root =3D href->owning_root;
=20
+	is_data =3D owner_objectid >=3D BTRFS_FIRST_FREE_OBJECTID;
+
+	if (!is_data && node->ref_root =3D=3D BTRFS_REMAP_TREE_OBJECTID) {
+		ret =3D add_to_free_space_tree(trans, bytenr, num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+
+		ret =3D btrfs_update_block_group(trans, bytenr, num_bytes, false);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+
+		return 0;
+	}
+
 	extent_root =3D btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
=20
@@ -3113,8 +3131,6 @@ static int __btrfs_free_extent(struct btrfs_trans_h=
andle *trans,
 	if (!path)
 		return -ENOMEM;
=20
-	is_data =3D owner_objectid >=3D BTRFS_FIRST_FREE_OBJECTID;
-
 	if (!is_data && refs_to_drop !=3D 1) {
 		btrfs_crit(info,
 "invalid refs_to_drop, dropping more than 1 refs for tree block %llu ref=
s_to_drop %u",
@@ -4893,57 +4909,61 @@ static int alloc_reserved_tree_block(struct btrfs=
_trans_handle *trans,
 	int level =3D btrfs_delayed_ref_owner(node);
 	bool skinny_metadata =3D btrfs_fs_incompat(fs_info, SKINNY_METADATA);
=20
-	extent_key.objectid =3D node->bytenr;
-	if (skinny_metadata) {
-		/* The owner of a tree block is the level. */
-		extent_key.offset =3D level;
-		extent_key.type =3D BTRFS_METADATA_ITEM_KEY;
-	} else {
-		extent_key.offset =3D node->num_bytes;
-		extent_key.type =3D BTRFS_EXTENT_ITEM_KEY;
-		size +=3D sizeof(*block_info);
-	}
+	if (node->ref_root !=3D BTRFS_REMAP_TREE_OBJECTID) {
+		extent_key.objectid =3D node->bytenr;
+		if (skinny_metadata) {
+			/* The owner of a tree block is the level. */
+			extent_key.offset =3D level;
+			extent_key.type =3D BTRFS_METADATA_ITEM_KEY;
+		} else {
+			extent_key.offset =3D node->num_bytes;
+			extent_key.type =3D BTRFS_EXTENT_ITEM_KEY;
+			size +=3D sizeof(*block_info);
+		}
=20
-	path =3D btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+		path =3D btrfs_alloc_path();
+		if (!path)
+			return -ENOMEM;
=20
-	extent_root =3D btrfs_extent_root(fs_info, extent_key.objectid);
-	ret =3D btrfs_insert_empty_item(trans, extent_root, path, &extent_key,
-				      size);
-	if (ret) {
-		btrfs_free_path(path);
-		return ret;
-	}
+		extent_root =3D btrfs_extent_root(fs_info, extent_key.objectid);
+		ret =3D btrfs_insert_empty_item(trans, extent_root, path,
+					      &extent_key, size);
+		if (ret) {
+			btrfs_free_path(path);
+			return ret;
+		}
=20
-	leaf =3D path->nodes[0];
-	extent_item =3D btrfs_item_ptr(leaf, path->slots[0],
-				     struct btrfs_extent_item);
-	btrfs_set_extent_refs(leaf, extent_item, 1);
-	btrfs_set_extent_generation(leaf, extent_item, trans->transid);
-	btrfs_set_extent_flags(leaf, extent_item,
-			       flags | BTRFS_EXTENT_FLAG_TREE_BLOCK);
+		leaf =3D path->nodes[0];
+		extent_item =3D btrfs_item_ptr(leaf, path->slots[0],
+					struct btrfs_extent_item);
+		btrfs_set_extent_refs(leaf, extent_item, 1);
+		btrfs_set_extent_generation(leaf, extent_item, trans->transid);
+		btrfs_set_extent_flags(leaf, extent_item,
+				flags | BTRFS_EXTENT_FLAG_TREE_BLOCK);
=20
-	if (skinny_metadata) {
-		iref =3D (struct btrfs_extent_inline_ref *)(extent_item + 1);
-	} else {
-		block_info =3D (struct btrfs_tree_block_info *)(extent_item + 1);
-		btrfs_set_tree_block_key(leaf, block_info, &extent_op->key);
-		btrfs_set_tree_block_level(leaf, block_info, level);
-		iref =3D (struct btrfs_extent_inline_ref *)(block_info + 1);
-	}
+		if (skinny_metadata) {
+			iref =3D (struct btrfs_extent_inline_ref *)(extent_item + 1);
+		} else {
+			block_info =3D (struct btrfs_tree_block_info *)(extent_item + 1);
+			btrfs_set_tree_block_key(leaf, block_info, &extent_op->key);
+			btrfs_set_tree_block_level(leaf, block_info, level);
+			iref =3D (struct btrfs_extent_inline_ref *)(block_info + 1);
+		}
=20
-	if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY) {
-		btrfs_set_extent_inline_ref_type(leaf, iref,
-						 BTRFS_SHARED_BLOCK_REF_KEY);
-		btrfs_set_extent_inline_ref_offset(leaf, iref, node->parent);
-	} else {
-		btrfs_set_extent_inline_ref_type(leaf, iref,
-						 BTRFS_TREE_BLOCK_REF_KEY);
-		btrfs_set_extent_inline_ref_offset(leaf, iref, node->ref_root);
-	}
+		if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY) {
+			btrfs_set_extent_inline_ref_type(leaf, iref,
+						BTRFS_SHARED_BLOCK_REF_KEY);
+			btrfs_set_extent_inline_ref_offset(leaf, iref,
+							   node->parent);
+		} else {
+			btrfs_set_extent_inline_ref_type(leaf, iref,
+						BTRFS_TREE_BLOCK_REF_KEY);
+			btrfs_set_extent_inline_ref_offset(leaf, iref,
+							   node->ref_root);
+		}
=20
-	btrfs_free_path(path);
+		btrfs_free_path(path);
+	}
=20
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9159d11cb143..0f4954f998cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3981,6 +3981,9 @@ static bool should_balance_chunk(struct extent_buff=
er *leaf, struct btrfs_chunk
 	struct btrfs_balance_args *bargs =3D NULL;
 	u64 chunk_type =3D btrfs_chunk_type(leaf, chunk);
=20
+	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
+		return false;
+
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
--=20
2.49.0


