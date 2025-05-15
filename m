Return-Path: <linux-btrfs+bounces-14052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69552AB8C9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3601BC69C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E77224B09;
	Thu, 15 May 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ppKaBqyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D19224248
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327026; cv=none; b=OTOiPJ0kyEAOIG/Jp6fDx9EDpfQ/plP47HDWmLuH6oWZXyyJrhhhZe9O6sEGm/3sU4QnXZLyxzK1aZWGdmwVAPcuqf17YEGSSesGHltXFvOSUDss/1COzxbl8wt0xcwkBbR8XZQkuoyZRk4kDJ1XL0A5sKm0TXUJ+m5pfdCdNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327026; c=relaxed/simple;
	bh=iDN7RIk238eQ8CXVfXH+JbZmml4cAPDnDDZm4SVWMX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O82TAtvs21Cf0A7MXgmP2Svj6RlXCadPhR+IvKkH0EOeB/3nyFE0/T1KPquf+U9/xL/quJiCL5SJpqMICzszW+mwtAxTjKbn25WB35zB+IiXBIWBQQZXGnW7hUOpUP7Ygoeoy8AX+NGNXyByXJmeM6UITUQF+UgTc++lg1Q33FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=ppKaBqyy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 54FFiLOj032382
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=g
	enwpFM50vdoyZSBW7FvLEVm3HTTtKGTd/B73Py9gOo=; b=ppKaBqyyMvBifpYsQ
	FEKvj5gwk3rnnGGHwH824/3WlypL5WRhoMgN54j0RV/xgOcq+Po2a1eCljjk4CdY
	En2R91C9oKNy8TFVIiqexiywbrlG7KvCeObqjwThNsADaX9zBG/Yga2b/4PGP8M4
	vtvKeIBCR8FrGCYMsg0e2nWvSw=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 46mmw2muad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:02 -0700 (PDT)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:37:01 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 5C15AF3BE118; Thu, 15 May 2025 17:36:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 04/10] btrfs: add extended version of struct block_group_item
Date: Thu, 15 May 2025 17:36:32 +0100
Message-ID: <20250515163641.3449017-5-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515163641.3449017-1-maharmstone@fb.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SU67PYDuetbFvPC-uqqph1YGnyICVHfS
X-Proofpoint-ORIG-GUID: SU67PYDuetbFvPC-uqqph1YGnyICVHfS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfX63PM1rPCXSmP cmJhcV5wCGHThjvwbQAHyCE4RnuhI7qq4wggEaEEjMty0oYGJ5xWUN/rxh0uARoAyciC5J3iOrw VkcYlFFD/6ZjxHUo8xv21pNlcEey1TrBsu2QFHSilIdFuVz4SsORdvITD2u+V0jJczAgVjA6OlE
 J4nZ8UEbl0OcFzsZnR8zKXZ+Xcndc79XR71H9VNUfCLHKxPdN55XSfNMfKztMKqAZ/1VelOEMxR SGSOKCR4K+GX7py9YyCHXyW3z53cjQX8uEj2+gJShs4O9TFuDwGAKBGzfPT+3kG3Lnjay3Ocqvs 5asbqznR5qv4ZT5zqgHI3Jh6vae/rEdFkzsolrqp1pK4N6npV0KqOP6kSEpV/3LLhvmhSkOIlH5
 hviQ0K1IDlkDhXGU5XR4VODgPJ99WRgxI3W/FVQ2zSXkSxZ4GO3n3xK5kbjDWRVr+4EsVbdA
X-Authority-Analysis: v=2.4 cv=DtZW+H/+ c=1 sm=1 tr=0 ts=6826182f cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=br1nD8lMFxwNaoIH4XsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

Add a struct btrfs_block_group_item_v2, which is used in the block group
tree if the remap-tree incompat flag is set.

This adds two new fields to the block group item: `remap_bytes` and
`identity_remap_count`.

`remap_bytes` records the amount of data that's physically within this
block group, but nominally in another, remapped block group. This is
necessary because this data will need to be moved first if this block
group is itself relocated. If `remap_bytes` > 0, this is an indicator to
the relocation thread that it will need to search the remap-tree for
backrefs. A block group must also have `remap_bytes` =3D=3D 0 before it c=
an
be dropped.

`identity_remap_count` records how many identity remap items are located
in the remap tree for this block group. When relocation is begun for
this block group, this is set to the number of holes in the free-space
tree for this range. As identity remaps are converted into actual remaps
by the relocation process, this number is decreased. Once it reaches 0,
either because of relocation or because extents have been deleted, the
block group has been fully remapped and its chunk's device extents are
removed.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/accessors.h            |  20 +++++++
 fs/btrfs/block-group.c          | 101 ++++++++++++++++++++++++--------
 fs/btrfs/block-group.h          |  14 ++++-
 fs/btrfs/tree-checker.c         |  10 +++-
 include/uapi/linux/btrfs_tree.h |   8 +++
 5 files changed, 126 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 5f5eda8d6f9e..6e6dd664217b 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -264,6 +264,26 @@ BTRFS_SETGET_FUNCS(block_group_flags, struct btrfs_b=
lock_group_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
=20
+/* struct btrfs_block_group_item_v2 */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_used, struct btrfs_block_g=
roup_item_v2,
+			 used, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_used, struct btrfs_block_group_item_v2=
, used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_chunk_objectid,
+			 struct btrfs_block_group_item_v2, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_chunk_objectid,
+		   struct btrfs_block_group_item_v2, chunk_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_flags,
+			 struct btrfs_block_group_item_v2, flags, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_flags, struct btrfs_block_group_item_v=
2, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_remap_bytes,
+			 struct btrfs_block_group_item_v2, remap_bytes, 64);
+BTRFS_SETGET_FUNCS(block_group_v2_remap_bytes, struct btrfs_block_group_=
item_v2,
+		   remap_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_identity_remap_count,
+			 struct btrfs_block_group_item_v2, identity_remap_count, 32);
+BTRFS_SETGET_FUNCS(block_group_v2_identity_remap_count, struct btrfs_blo=
ck_group_item_v2,
+		   identity_remap_count, 32);
+
 /* struct btrfs_free_space_info */
 BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info=
,
 		   extent_count, 32);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b0cb04b2b93..6a2aa792ccb2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2351,7 +2351,7 @@ static int check_chunk_block_group_mappings(struct =
btrfs_fs_info *fs_info)
 }
=20
 static int read_one_block_group(struct btrfs_fs_info *info,
-				struct btrfs_block_group_item *bgi,
+				struct btrfs_block_group_item_v2 *bgi,
 				const struct btrfs_key *key,
 				int need_clear)
 {
@@ -2366,11 +2366,16 @@ static int read_one_block_group(struct btrfs_fs_i=
nfo *info,
 		return -ENOMEM;
=20
 	cache->length =3D key->offset;
-	cache->used =3D btrfs_stack_block_group_used(bgi);
+	cache->used =3D btrfs_stack_block_group_v2_used(bgi);
 	cache->commit_used =3D cache->used;
-	cache->flags =3D btrfs_stack_block_group_flags(bgi);
-	cache->global_root_id =3D btrfs_stack_block_group_chunk_objectid(bgi);
+	cache->flags =3D btrfs_stack_block_group_v2_flags(bgi);
+	cache->global_root_id =3D btrfs_stack_block_group_v2_chunk_objectid(bgi=
);
 	cache->space_info =3D btrfs_find_space_info(info, cache->flags);
+	cache->remap_bytes =3D btrfs_stack_block_group_v2_remap_bytes(bgi);
+	cache->commit_remap_bytes =3D cache->remap_bytes;
+	cache->identity_remap_count =3D
+		btrfs_stack_block_group_v2_identity_remap_count(bgi);
+	cache->commit_identity_remap_count =3D cache->identity_remap_count;
=20
 	set_free_space_tree_thresholds(cache);
=20
@@ -2435,7 +2440,7 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
 	} else if (cache->length =3D=3D cache->used) {
 		cache->cached =3D BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
-	} else if (cache->used =3D=3D 0) {
+	} else if (cache->used =3D=3D 0 && cache->remap_bytes =3D=3D 0) {
 		cache->cached =3D BTRFS_CACHE_FINISHED;
 		ret =3D btrfs_add_new_free_space(cache, cache->start,
 					       cache->start + cache->length, NULL);
@@ -2455,7 +2460,8 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
=20
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
-		if (cache->used =3D=3D 0) {
+		if (cache->used =3D=3D 0 && cache->identity_remap_count =3D=3D 0 &&
+		    cache->remap_bytes =3D=3D 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			if (btrfs_test_opt(info, DISCARD_ASYNC))
 				btrfs_discard_queue_work(&info->discard_ctl, cache);
@@ -2559,9 +2565,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
 		need_clear =3D 1;
=20
 	while (1) {
-		struct btrfs_block_group_item bgi;
+		struct btrfs_block_group_item_v2 bgi;
 		struct extent_buffer *leaf;
 		int slot;
+		size_t size;
=20
 		ret =3D find_first_block_group(info, path, &key);
 		if (ret > 0)
@@ -2572,8 +2579,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
 		leaf =3D path->nodes[0];
 		slot =3D path->slots[0];
=20
+		if (btrfs_fs_incompat(info, REMAP_TREE)) {
+			size =3D sizeof(struct btrfs_block_group_item_v2);
+		} else {
+			size =3D sizeof(struct btrfs_block_group_item);
+			btrfs_set_stack_block_group_v2_remap_bytes(&bgi, 0);
+			btrfs_set_stack_block_group_v2_identity_remap_count(&bgi, 0);
+		}
+
 		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-				   sizeof(bgi));
+				   size);
=20
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 		btrfs_release_path(path);
@@ -2643,25 +2658,38 @@ static int insert_block_group_item(struct btrfs_t=
rans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
-	struct btrfs_block_group_item bgi;
+	struct btrfs_block_group_item_v2 bgi;
 	struct btrfs_root *root =3D btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	u64 old_commit_used;
+	size_t size;
 	int ret;
=20
 	spin_lock(&block_group->lock);
-	btrfs_set_stack_block_group_used(&bgi, block_group->used);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-						   block_group->global_root_id);
-	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
+	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
+	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
+						      block_group->global_root_id);
+	btrfs_set_stack_block_group_v2_flags(&bgi, block_group->flags);
+	btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
+						   block_group->remap_bytes);
+	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
+					block_group->identity_remap_count);
 	old_commit_used =3D block_group->commit_used;
 	block_group->commit_used =3D block_group->used;
+	block_group->commit_remap_bytes =3D block_group->remap_bytes;
+	block_group->commit_identity_remap_count =3D
+		block_group->identity_remap_count;
 	key.objectid =3D block_group->start;
 	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset =3D block_group->length;
 	spin_unlock(&block_group->lock);
=20
-	ret =3D btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+		size =3D sizeof(struct btrfs_block_group_item_v2);
+	else
+		size =3D sizeof(struct btrfs_block_group_item);
+
+	ret =3D btrfs_insert_item(trans, root, &key, &bgi, size);
 	if (ret < 0) {
 		spin_lock(&block_group->lock);
 		block_group->commit_used =3D old_commit_used;
@@ -3116,10 +3144,12 @@ static int update_block_group_item(struct btrfs_t=
rans_handle *trans,
 	struct btrfs_root *root =3D btrfs_block_group_root(fs_info);
 	unsigned long bi;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bgi;
+	struct btrfs_block_group_item_v2 bgi;
 	struct btrfs_key key;
-	u64 old_commit_used;
-	u64 used;
+	u64 old_commit_used, old_commit_remap_bytes;
+	u32 old_commit_identity_remap_count;
+	u64 used, remap_bytes;
+	u32 identity_remap_count;
=20
 	/*
 	 * Block group items update can be triggered out of commit transaction
@@ -3129,13 +3159,21 @@ static int update_block_group_item(struct btrfs_t=
rans_handle *trans,
 	 */
 	spin_lock(&cache->lock);
 	old_commit_used =3D cache->commit_used;
+	old_commit_remap_bytes =3D cache->commit_remap_bytes;
+	old_commit_identity_remap_count =3D cache->commit_identity_remap_count;
 	used =3D cache->used;
-	/* No change in used bytes, can safely skip it. */
-	if (cache->commit_used =3D=3D used) {
+	remap_bytes =3D cache->remap_bytes;
+	identity_remap_count =3D cache->identity_remap_count;
+	/* No change in values, can safely skip it. */
+	if (cache->commit_used =3D=3D used &&
+	    cache->commit_remap_bytes =3D=3D remap_bytes &&
+	    cache->commit_identity_remap_count =3D=3D identity_remap_count) {
 		spin_unlock(&cache->lock);
 		return 0;
 	}
 	cache->commit_used =3D used;
+	cache->commit_remap_bytes =3D remap_bytes;
+	cache->commit_identity_remap_count =3D identity_remap_count;
 	spin_unlock(&cache->lock);
=20
 	key.objectid =3D cache->start;
@@ -3151,11 +3189,23 @@ static int update_block_group_item(struct btrfs_t=
rans_handle *trans,
=20
 	leaf =3D path->nodes[0];
 	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, used);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-						   cache->global_root_id);
-	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
+	btrfs_set_stack_block_group_v2_used(&bgi, used);
+	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
+						      cache->global_root_id);
+	btrfs_set_stack_block_group_v2_flags(&bgi, cache->flags);
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
+							   cache->remap_bytes);
+		btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
+						cache->identity_remap_count);
+		write_extent_buffer(leaf, &bgi, bi,
+				    sizeof(struct btrfs_block_group_item_v2));
+	} else {
+		write_extent_buffer(leaf, &bgi, bi,
+				    sizeof(struct btrfs_block_group_item));
+	}
+
 fail:
 	btrfs_release_path(path);
 	/*
@@ -3170,6 +3220,9 @@ static int update_block_group_item(struct btrfs_tra=
ns_handle *trans,
 	if (ret < 0 && ret !=3D -ENOENT) {
 		spin_lock(&cache->lock);
 		cache->commit_used =3D old_commit_used;
+		cache->commit_remap_bytes =3D old_commit_remap_bytes;
+		cache->commit_identity_remap_count =3D
+			old_commit_identity_remap_count;
 		spin_unlock(&cache->lock);
 	}
 	return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9de356bcb411..c484118b8b8d 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -127,6 +127,8 @@ struct btrfs_block_group {
 	u64 flags;
 	u64 cache_generation;
 	u64 global_root_id;
+	u64 remap_bytes;
+	u32 identity_remap_count;
=20
 	/*
 	 * The last committed used bytes of this block group, if the above @use=
d
@@ -134,6 +136,15 @@ struct btrfs_block_group {
 	 * group item of this block group.
 	 */
 	u64 commit_used;
+	/*
+	 * The last committed remap_bytes value of this block group.
+	 */
+	u64 commit_remap_bytes;
+	/*
+	 * The last commited identity_remap_count value of this block group.
+	 */
+	u32 commit_identity_remap_count;
+
 	/*
 	 * If the free space extent count exceeds this number, convert the bloc=
k
 	 * group to bitmaps.
@@ -275,7 +286,8 @@ static inline bool btrfs_is_block_group_used(const st=
ruct btrfs_block_group *bg)
 {
 	lockdep_assert_held(&bg->lock);
=20
-	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0 ||
+		bg->remap_bytes > 0);
 }
=20
 static inline bool btrfs_is_block_group_data_only(const struct btrfs_blo=
ck_group *block_group)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index fd83df06e3fb..25311576fab6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -687,6 +687,7 @@ static int check_block_group_item(struct extent_buffe=
r *leaf,
 	u64 chunk_objectid;
 	u64 flags;
 	u64 type;
+	size_t exp_size;
=20
 	/*
 	 * Here we don't really care about alignment since extent allocator can
@@ -698,10 +699,15 @@ static int check_block_group_item(struct extent_buf=
fer *leaf,
 		return -EUCLEAN;
 	}
=20
-	if (unlikely(item_size !=3D sizeof(bgi))) {
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
+		exp_size =3D sizeof(struct btrfs_block_group_item_v2);
+	else
+		exp_size =3D sizeof(struct btrfs_block_group_item);
+
+	if (unlikely(item_size !=3D exp_size)) {
 		block_group_err(leaf, slot,
 			"invalid item size, have %u expect %zu",
-				item_size, sizeof(bgi));
+				item_size, exp_size);
 		return -EUCLEAN;
 	}
=20
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_t=
ree.h
index 9a36f0206d90..500e3a7df90b 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1229,6 +1229,14 @@ struct btrfs_block_group_item {
 	__le64 flags;
 } __attribute__ ((__packed__));
=20
+struct btrfs_block_group_item_v2 {
+	__le64 used;
+	__le64 chunk_objectid;
+	__le64 flags;
+	__le64 remap_bytes;
+	__le32 identity_remap_count;
+} __attribute__ ((__packed__));
+
 struct btrfs_free_space_info {
 	__le32 extent_count;
 	__le32 flags;
--=20
2.49.0


