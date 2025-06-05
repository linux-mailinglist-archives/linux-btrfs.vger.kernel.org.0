Return-Path: <linux-btrfs+bounces-14486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F3ACF42C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E01889A8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81BB2749F9;
	Thu,  5 Jun 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JBG9o4NF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38321A444
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140638; cv=none; b=Vu8NzjTBxEuYU2HXpdzKpSud5W5S9rhg6UTpkoh9rds6ObipfG42V7MygCmw1OXr4B6hO29j9UgvA3lH0LnqAGXisdjwf6xazI6jhx+TxjHFzkoqTVOyqU9dOlUEGdfmeJ/LmPbuB5GswOzjxss1tVY2TayRITZB3o3XTlxW3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140638; c=relaxed/simple;
	bh=Q8iqoF32v2G9pWTVB+DeAYhiKg2LdBiPOHEeynxFtro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHJkyK6MjDXQaQzQHucRlLxC6zu2nHc6Oc6J6Sz/bzkkbuKSee1ydzN4zT4kkgFbmClyy7ar/QURnpqggyCwXxojr5yPDCzx4QABALkeVga2h78RT8j5ADfeTa4NfoXn//RefGAerL5U68DU3mpZ6/X5ti9wU8uy/VXzxAXAY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=JBG9o4NF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bT027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=l
	0nUTyap0aeYf38/AWXSlhuMxipPJVdbQvQjn4avgSw=; b=JBG9o4NFdG6qLV9K2
	6k9bwh/eKGnKl5Z1sUGb3X3rXe5elKcDCrRfH4OL5Pz9Z8n3HHgLwR4M3r9+LLiC
	UJUPnKbMPShhL08c1c9mIiyJFiC1CpfsRSCcabrBOqvA1nanHVUkRBcbDkMP+Z6b
	AMaz1l07xM6V1hzarRthXMZqZo=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:55 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:51 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 59B27FEC2E6A; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 06/12] btrfs: add extended version of struct block_group_item
Date: Thu, 5 Jun 2025 17:23:36 +0100
Message-ID: <20250605162345.2561026-7-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=g9VwQo7qJCjgKxKwdgsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX7KBx64L54VmI u/ewbQnlH8z0aGacolmj45oJsRcjGc34LhtW4YD62h1YEnW9olF+AQKkFrvat6mhzKVvfT82vJ8 ahxQ2Smkg2RkUyf1Dy0EmXjZsTz+yGY3ISrx4MnR3yLI8EQkzQ8XBFy9cKf1OS/0ciBt0iWcvwM
 pwlZiD4y5Nao6suX3BJM/Wauk1OKkySraLxL3RZ2aW3YZAY8PjPftCvz1LjuL74dnTogv4zJUGB EBSxD5cOipPmqVDqRxduDJNW/88ORjhPMI1JQg0cHLERCJNiIjXt93llaK6/QrhtG2baIoXYqkq RvnfEY9Gf2ZPRCD2DH7Aohvy4JGDU6BPqAr4mGh9aATCZIbg9QOKT5f+5L59KokPRs11ZLx76gA
 I332h1HW76obZXOX+WMHwSOffWIFbb1oeIlGsX/2Ycog6YTDiC23kmKvAc23K1A1mEgjRj2m
X-Proofpoint-GUID: c6YTiJ6YpIPxRD-nFgIvEi_FwP5RZ292
X-Proofpoint-ORIG-GUID: c6YTiJ6YpIPxRD-nFgIvEi_FwP5RZ292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

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
 fs/btrfs/discard.c              |   2 +-
 fs/btrfs/tree-checker.c         |  10 +++-
 include/uapi/linux/btrfs_tree.h |   8 +++
 6 files changed, 127 insertions(+), 28 deletions(-)

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
index 9b3b5358f1ba..4529356bb1e3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2360,7 +2360,7 @@ static int check_chunk_block_group_mappings(struct =
btrfs_fs_info *fs_info)
 }
=20
 static int read_one_block_group(struct btrfs_fs_info *info,
-				struct btrfs_block_group_item *bgi,
+				struct btrfs_block_group_item_v2 *bgi,
 				const struct btrfs_key *key,
 				int need_clear)
 {
@@ -2375,11 +2375,16 @@ static int read_one_block_group(struct btrfs_fs_i=
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
@@ -2444,7 +2449,7 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
 	} else if (cache->length =3D=3D cache->used) {
 		cache->cached =3D BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
-	} else if (cache->used =3D=3D 0) {
+	} else if (cache->used =3D=3D 0 && cache->remap_bytes =3D=3D 0) {
 		cache->cached =3D BTRFS_CACHE_FINISHED;
 		ret =3D btrfs_add_new_free_space(cache, cache->start,
 					       cache->start + cache->length, NULL);
@@ -2464,7 +2469,8 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
=20
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
-		if (cache->used =3D=3D 0) {
+		if (cache->used =3D=3D 0 && cache->identity_remap_count =3D=3D 0 &&
+		    cache->remap_bytes =3D=3D 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
 			    !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
@@ -2570,9 +2576,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
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
@@ -2583,8 +2590,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
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
@@ -2654,25 +2669,38 @@ static int insert_block_group_item(struct btrfs_t=
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
@@ -3127,10 +3155,12 @@ static int update_block_group_item(struct btrfs_t=
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
@@ -3140,13 +3170,21 @@ static int update_block_group_item(struct btrfs_t=
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
@@ -3162,11 +3200,23 @@ static int update_block_group_item(struct btrfs_t=
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
@@ -3181,6 +3231,9 @@ static int update_block_group_item(struct btrfs_tra=
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
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 1015a4d37fb2..2b7b1e440bc8 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -373,7 +373,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ct=
l *discard_ctl,
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC=
))
 		return;
=20
-	if (block_group->used =3D=3D 0)
+	if (block_group->used =3D=3D 0 && block_group->remap_bytes =3D=3D 0)
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
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


