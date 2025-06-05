Return-Path: <linux-btrfs+bounces-14493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1662ACF43D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C567AA44B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD8274FFC;
	Thu,  5 Jun 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gen2yaM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70305274FE5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140648; cv=none; b=Rwg/Fwt8HReUM3iae/ZQ1WM+8C57FAa7uQRQNgoSIkLggq+W6cLlNaY9Nu4gduM8Dvsl8OnnEQzF+LVSu83IDAN5SkIGCdYp+ST0ZIJ6l6z0mgp2kuyY++WOizUaSpc/IkaGHo0bGKk9Mm8A/hDsUfOlTEfOTskiCNOXe6hoQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140648; c=relaxed/simple;
	bh=jeRfpaNyPyrZcMep3+rRlNjfDNmC24ezUdCpEZPXJVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWXVUuiu3KyTXZmdgTN4LOiS3u8RFVlnGuAOtQE5Ny3lsZsroGOhlGT6sVtsfKHiQhfKQBpRuWo+tCnCow8QFbycZDfC5UCh/nWpP8sNfXTriKdu5/g5+Q6uHBPeD6w8Pv8Wm8PHtseAl08u3+c6kK+P9L8SVxolG3IGtCx/3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Gen2yaM+; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DwMA6006750
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:24:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=a
	npY/EaTNn0cbg9etpLt+vMV7V4l39L22cpnWkztYmI=; b=Gen2yaM+hGVTVhKRa
	vBahjs3+6L70jBnfMbJx1Wyei6rbV2aZ2d3zDVLlN0gO3eURmwIQ2W5lLescJTEE
	jIgLqYNB+QAJTaXu3497PA3wEmnhhCnl+SwxrCN4dQh/kuNsFOlhEUMsR2aeo+t9
	Mcb+uHCyWkIDyWmGAw6NzPm1iw=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739uca8xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:24:03 -0700 (PDT)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:24:01 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 735DCFEC2E72; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 10/12] btrfs: handle setting up relocation of block group with remap-tree
Date: Thu, 5 Jun 2025 17:23:40 +0100
Message-ID: <20250605162345.2561026-11-maharmstone@fb.com>
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
X-Proofpoint-GUID: 5Iba62GzrnBbMhejTIZt52yETbdcXq97
X-Proofpoint-ORIG-GUID: 5Iba62GzrnBbMhejTIZt52yETbdcXq97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX4SsEqZG1AGxN viHfbLA9pcnDiRFALeiAChCVd/OvjO+RUaR0XpMUxkj4Npj+tlM7kTiG2ry0vZZV1mPOEVCgWFX nLH/vOi2uyGHy5cs2R3+vB3z02uPofCkKIo/Rh6xYbq4Pxe7hg47fLB5JbF0h6zRTgaWSNVBlLD
 G1gIOP+Mw99/L6pav44cWpNXlJsTKUANrDcshcA1QTziVGxh5HdNs0kZxD8e9FTshjPZ3o6AAZC QW8DmamiMgiNBLdSoPC930lbhoj6kSR2hXI/zDFe+YP4gDhBdZ9v6wdarXFYc+hMrl8L4HOuBCz C86yC8jbdiPKyxQZxePZaDEqJfhyxoESozS/q4I8k0HF0zUhivjfjosjPeewNToybZCOz1eF/fr
 Mx4mKLw4/ju2cBtAl7JVa3NhlO/+Dt+iCpDZIH9/kZc8WpJWvlZESsWnD3AIGSx9oLeaXHv4
X-Authority-Analysis: v=2.4 cv=MNhgmNZl c=1 sm=1 tr=0 ts=6841c4a3 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=RowYiGHi-L0KbxBVMhoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

Handle the preliminary work for relocating a block group in a filesystem
with the remap-tree flag set.

If the block group is SYSTEM or REMAP btrfs_relocate_block_group()
proceeds as it does already, as bootstrapping issues mean that these
block groups have to be processed the existing way.

Otherwise we walk the free-space tree for the block group in question,
recording any holes. These get converted into identity remaps and placed
in the remap tree, and the block group's REMAPPED flag is set. From now
on no new allocations are possible within this block group, and any I/O
to it will be funnelled through btrfs_translate_remap(). We store the
number of identity remaps in `identity_remap_count`, so that we know
when we've removed the last one and the block group is fully remapped.

The change in btrfs_read_roots() is because data relocations no longer
rely on the data reloc tree as a hidden subvolume in which to do
snapshots.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/disk-io.c         |  30 +--
 fs/btrfs/free-space-tree.c |   4 +-
 fs/btrfs/free-space-tree.h |   5 +-
 fs/btrfs/relocation.c      | 452 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h      |   3 +-
 fs/btrfs/space-info.c      |   9 +-
 fs/btrfs/volumes.c         |  15 +-
 7 files changed, 483 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dac22efd2332..f2a9192293b1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2268,22 +2268,22 @@ static int btrfs_read_roots(struct btrfs_fs_info =
*fs_info)
 		root->root_key.objectid =3D BTRFS_REMAP_TREE_OBJECTID;
 		root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
 		root->root_key.offset =3D 0;
-	}
-
-	/*
-	 * This tree can share blocks with some other fs tree during relocation
-	 * and we need a proper setup by btrfs_get_fs_root
-	 */
-	root =3D btrfs_get_fs_root(tree_root->fs_info,
-				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
-	if (IS_ERR(root)) {
-		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
-			ret =3D PTR_ERR(root);
-			goto out;
-		}
 	} else {
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->data_reloc_root =3D root;
+		/*
+		 * This tree can share blocks with some other fs tree during
+		 * relocation and we need a proper setup by btrfs_get_fs_root
+		 */
+		root =3D btrfs_get_fs_root(tree_root->fs_info,
+					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret =3D PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->data_reloc_root =3D root;
+		}
 	}
=20
 	location.objectid =3D BTRFS_QUOTA_TREE_OBJECTID;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index af51cf784a5b..eb579c17a79f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -21,8 +21,7 @@ static int __add_block_group_free_space(struct btrfs_tr=
ans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path);
=20
-static struct btrfs_root *btrfs_free_space_root(
-				struct btrfs_block_group *block_group)
+struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block=
_group)
 {
 	struct btrfs_key key =3D {
 		.objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID,
@@ -96,7 +95,6 @@ static int add_new_free_space_info(struct btrfs_trans_h=
andle *trans,
 	return ret;
 }
=20
-EXPORT_FOR_TESTS
 struct btrfs_free_space_info *search_free_space_info(
 		struct btrfs_trans_handle *trans,
 		struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index e6c6d6f4f221..1b804544730a 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -35,12 +35,13 @@ int add_to_free_space_tree(struct btrfs_trans_handle =
*trans,
 			   u64 start, u64 size);
 int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				u64 start, u64 size);
-
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
 search_free_space_info(struct btrfs_trans_handle *trans,
 		       struct btrfs_block_group *block_group,
 		       struct btrfs_path *path, int cow);
+struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block=
_group);
+
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_block_group *block_group,
 			     struct btrfs_path *path, u64 start, u64 size);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 54c3e99c7dab..acf2fefedc96 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3659,7 +3659,7 @@ static noinline_for_stack int relocate_block_group(=
struct reloc_control *rc)
 		btrfs_btree_balance_dirty(fs_info);
 	}
=20
-	if (!err) {
+	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		ret =3D relocate_file_extent_cluster(rc);
 		if (ret < 0)
 			err =3D ret;
@@ -3906,6 +3906,90 @@ static const char *stage_to_string(enum reloc_stag=
e stage)
 	return "unknown";
 }
=20
+static int add_remap_tree_entries(struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path,
+				  struct btrfs_key *entries,
+				  unsigned int num_entries)
+{
+	int ret;
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_item_batch batch;
+	u32 *data_sizes;
+	u32 max_items;
+
+	max_items =3D BTRFS_LEAF_DATA_SIZE(trans->fs_info) / sizeof(struct btrf=
s_item);
+
+	data_sizes =3D kzalloc(sizeof(u32) * min_t(u32, num_entries, max_items)=
,
+			     GFP_NOFS);
+	if (!data_sizes)
+		return -ENOMEM;
+
+	while (true) {
+		batch.keys =3D entries;
+		batch.data_sizes =3D data_sizes;
+		batch.total_data_size =3D 0;
+		batch.nr =3D min_t(u32, num_entries, max_items);
+
+		ret =3D btrfs_insert_empty_items(trans, fs_info->remap_root, path,
+					       &batch);
+		btrfs_release_path(path);
+
+		if (num_entries <=3D max_items)
+			break;
+
+		num_entries -=3D max_items;
+		entries +=3D max_items;
+	}
+
+	kfree(data_sizes);
+
+	return ret;
+}
+
+struct space_run {
+	u64 start;
+	u64 end;
+};
+
+static void parse_bitmap(u64 block_size, const unsigned long *bitmap,
+			 unsigned long size, u64 address,
+			 struct space_run *space_runs,
+			 unsigned int *num_space_runs)
+{
+	unsigned long pos, end;
+	u64 run_start, run_length;
+
+	pos =3D find_first_bit(bitmap, size);
+
+	if (pos =3D=3D size)
+		return;
+
+	while (true) {
+		end =3D find_next_zero_bit(bitmap, size, pos);
+
+		run_start =3D address + (pos * block_size);
+		run_length =3D (end - pos) * block_size;
+
+		if (*num_space_runs !=3D 0 &&
+		    space_runs[*num_space_runs - 1].end =3D=3D run_start) {
+			space_runs[*num_space_runs - 1].end +=3D run_length;
+		} else {
+			space_runs[*num_space_runs].start =3D run_start;
+			space_runs[*num_space_runs].end =3D run_start + run_length;
+
+			(*num_space_runs)++;
+		}
+
+		if (end =3D=3D size)
+			break;
+
+		pos =3D find_next_bit(bitmap, size, end + 1);
+
+		if (pos =3D=3D size)
+			break;
+	}
+}
+
 static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *tr=
ans,
 					   struct btrfs_block_group *bg,
 					   s64 diff)
@@ -3931,6 +4015,227 @@ static void adjust_block_group_remap_bytes(struct=
 btrfs_trans_handle *trans,
 		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
 }
=20
+static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
+				     struct btrfs_path *path,
+				     struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_free_space_info *fsi;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_root *space_root;
+	u32 extent_count;
+	struct space_run *space_runs =3D NULL;
+	unsigned int num_space_runs =3D 0;
+	struct btrfs_key *entries =3D NULL;
+	unsigned int max_entries, num_entries;
+	int ret;
+
+	mutex_lock(&bg->free_space_lock);
+
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
+		mutex_unlock(&bg->free_space_lock);
+
+		ret =3D add_block_group_free_space(trans, bg);
+		if (ret)
+			return ret;
+
+		mutex_lock(&bg->free_space_lock);
+	}
+
+	fsi =3D search_free_space_info(trans, bg, path, 0);
+	if (IS_ERR(fsi)) {
+		mutex_unlock(&bg->free_space_lock);
+		return PTR_ERR(fsi);
+	}
+
+	extent_count =3D btrfs_free_space_extent_count(path->nodes[0], fsi);
+
+	btrfs_release_path(path);
+
+	space_runs =3D kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
+	if (!space_runs) {
+		mutex_unlock(&bg->free_space_lock);
+		return -ENOMEM;
+	}
+
+	key.objectid =3D bg->start;
+	key.type =3D 0;
+	key.offset =3D 0;
+
+	space_root =3D btrfs_free_space_root(bg);
+
+	ret =3D btrfs_search_slot(trans, space_root, &key, path, 0, 0);
+	if (ret < 0) {
+		mutex_unlock(&bg->free_space_lock);
+		goto out;
+	}
+
+	ret =3D 0;
+
+	while (true) {
+		leaf =3D path->nodes[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.objectid >=3D bg->start + bg->length)
+			break;
+
+		if (found_key.type =3D=3D BTRFS_FREE_SPACE_EXTENT_KEY) {
+			if (num_space_runs !=3D 0 &&
+			    space_runs[num_space_runs - 1].end =3D=3D found_key.objectid) {
+				space_runs[num_space_runs - 1].end =3D
+					found_key.objectid + found_key.offset;
+			} else {
+				space_runs[num_space_runs].start =3D found_key.objectid;
+				space_runs[num_space_runs].end =3D
+					found_key.objectid + found_key.offset;
+
+				num_space_runs++;
+
+				BUG_ON(num_space_runs > extent_count);
+			}
+		} else if (found_key.type =3D=3D BTRFS_FREE_SPACE_BITMAP_KEY) {
+			void *bitmap;
+			unsigned long offset;
+			u32 data_size;
+
+			offset =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
+			data_size =3D btrfs_item_size(leaf, path->slots[0]);
+
+			if (data_size !=3D 0) {
+				bitmap =3D kmalloc(data_size, GFP_NOFS);
+				if (!bitmap) {
+					mutex_unlock(&bg->free_space_lock);
+					ret =3D -ENOMEM;
+					goto out;
+				}
+
+				read_extent_buffer(leaf, bitmap, offset,
+						   data_size);
+
+				parse_bitmap(fs_info->sectorsize, bitmap,
+					     data_size * BITS_PER_BYTE,
+					     found_key.objectid, space_runs,
+					     &num_space_runs);
+
+				BUG_ON(num_space_runs > extent_count);
+
+				kfree(bitmap);
+			}
+		}
+
+		path->slots[0]++;
+
+		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(space_root, path);
+			if (ret !=3D 0) {
+				if (ret =3D=3D 1)
+					ret =3D 0;
+				break;
+			}
+			leaf =3D path->nodes[0];
+		}
+	}
+
+	btrfs_release_path(path);
+
+	mutex_unlock(&bg->free_space_lock);
+
+	max_entries =3D extent_count + 2;
+	entries =3D kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
+	if (!entries) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	num_entries =3D 0;
+
+	if (num_space_runs > 0 && space_runs[0].start > bg->start) {
+		entries[num_entries].objectid =3D bg->start;
+		entries[num_entries].type =3D BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =3D space_runs[0].start - bg->start;
+		num_entries++;
+	}
+
+	for (unsigned int i =3D 1; i < num_space_runs; i++) {
+		entries[num_entries].objectid =3D space_runs[i - 1].end;
+		entries[num_entries].type =3D BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =3D
+			space_runs[i].start - space_runs[i - 1].end;
+		num_entries++;
+	}
+
+	if (num_space_runs =3D=3D 0) {
+		entries[num_entries].objectid =3D bg->start;
+		entries[num_entries].type =3D BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =3D bg->length;
+		num_entries++;
+	} else if (space_runs[num_space_runs - 1].end < bg->start + bg->length)=
 {
+		entries[num_entries].objectid =3D space_runs[num_space_runs - 1].end;
+		entries[num_entries].type =3D BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =3D
+			bg->start + bg->length - space_runs[num_space_runs - 1].end;
+		num_entries++;
+	}
+
+	if (num_entries =3D=3D 0)
+		goto out;
+
+	bg->identity_remap_count =3D num_entries;
+
+	ret =3D add_remap_tree_entries(trans, path, entries, num_entries);
+
+out:
+	kfree(entries);
+	kfree(space_runs);
+
+	return ret;
+}
+
+static int mark_bg_remapped(struct btrfs_trans_handle *trans,
+			    struct btrfs_path *path,
+			    struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	unsigned long bi;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group_item_v2 bgi;
+	struct btrfs_key key;
+	int ret;
+
+	bg->flags |=3D BTRFS_BLOCK_GROUP_REMAPPED;
+
+	key.objectid =3D bg->start;
+	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset =3D bg->length;
+
+	ret =3D btrfs_search_slot(trans, fs_info->block_group_root, &key,
+				path, 0, 1);
+	if (ret) {
+		if (ret > 0)
+			ret =3D -ENOENT;
+		goto out;
+	}
+
+	leaf =3D path->nodes[0];
+	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
+	read_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
+	btrfs_set_stack_block_group_v2_flags(&bgi, bg->flags);
+	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
+						bg->identity_remap_count);
+	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	bg->commit_identity_remap_count =3D bg->identity_remap_count;
+
+	ret =3D 0;
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
 static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
 				struct btrfs_chunk_map *chunk,
 				struct btrfs_path *path)
@@ -4050,6 +4355,55 @@ static int adjust_identity_remap_count(struct btrf=
s_trans_handle *trans,
 	return ret;
 }
=20
+static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
+			       struct btrfs_path *path, uint64_t start)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_chunk_map *chunk;
+	struct btrfs_key key;
+	u64 type;
+	int ret;
+	struct extent_buffer *leaf;
+	struct btrfs_chunk *c;
+
+	read_lock(&fs_info->mapping_tree_lock);
+
+	chunk =3D btrfs_find_chunk_map_nolock(fs_info, start, 1);
+	if (!chunk) {
+		read_unlock(&fs_info->mapping_tree_lock);
+		return -ENOENT;
+	}
+
+	chunk->type |=3D BTRFS_BLOCK_GROUP_REMAPPED;
+	type =3D chunk->type;
+
+	read_unlock(&fs_info->mapping_tree_lock);
+
+	key.objectid =3D BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type =3D BTRFS_CHUNK_ITEM_KEY;
+	key.offset =3D start;
+
+	ret =3D btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
+				0, 1);
+	if (ret =3D=3D 1) {
+		ret =3D -ENOENT;
+		goto end;
+	} else if (ret < 0)
+		goto end;
+
+	leaf =3D path->nodes[0];
+
+	c =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
+	btrfs_set_chunk_type(leaf, c, type);
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	ret =3D 0;
+end:
+	btrfs_free_chunk_map(chunk);
+	btrfs_release_path(path);
+	return ret;
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length, bool nolock)
 {
@@ -4109,16 +4463,78 @@ int btrfs_translate_remap(struct btrfs_fs_info *f=
s_info, u64 *logical,
 	return 0;
 }
=20
+static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
+				       struct btrfs_path *path,
+				       struct btrfs_block_group *bg)
+{
+	struct btrfs_trans_handle *trans;
+	int ret, ret2;
+
+	ret =3D btrfs_cache_block_group(bg, true);
+	if (ret)
+		return ret;
+
+	trans =3D btrfs_start_transaction(fs_info->remap_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	/* We need to run delayed refs, to make sure FST is up to date. */
+	ret =3D btrfs_run_delayed_refs(trans, U64_MAX);
+	if (ret) {
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
+		ret =3D 0;
+		goto end;
+	}
+
+	ret =3D create_remap_tree_entries(trans, path, bg);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	ret =3D mark_bg_remapped(trans, path, bg);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	ret =3D mark_chunk_remapped(trans, path, bg->start);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	ret =3D remove_block_group_free_space(trans, bg);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+end:
+	mutex_unlock(&fs_info->remap_mutex);
+
+	ret2 =3D btrfs_end_transaction(trans);
+	if (!ret)
+		ret =3D ret2;
+
+	return ret;
+}
+
 /*
  * function to relocate all extents in a block group.
  */
-int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_=
start)
+int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_=
start,
+			       bool *using_remap_tree)
 {
 	struct btrfs_block_group *bg;
 	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, group_sta=
rt);
 	struct reloc_control *rc;
 	struct inode *inode;
-	struct btrfs_path *path;
+	struct btrfs_path *path =3D NULL;
 	int ret;
 	int rw =3D 0;
 	int err =3D 0;
@@ -4185,7 +4601,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info=
 *fs_info, u64 group_start)
 	}
=20
 	inode =3D lookup_free_space_inode(rc->block_group, path);
-	btrfs_free_path(path);
+	btrfs_release_path(path);
=20
 	if (!IS_ERR(inode))
 		ret =3D delete_block_group_cache(rc->block_group, inode, 0);
@@ -4197,11 +4613,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_in=
fo *fs_info, u64 group_start)
 		goto out;
 	}
=20
-	rc->data_inode =3D create_reloc_inode(rc->block_group);
-	if (IS_ERR(rc->data_inode)) {
-		err =3D PTR_ERR(rc->data_inode);
-		rc->data_inode =3D NULL;
-		goto out;
+	*using_remap_tree =3D btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+		!(bg->flags & BTRFS_BLOCK_GROUP_SYSTEM) &&
+		!(bg->flags & BTRFS_BLOCK_GROUP_REMAP);
+
+	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		rc->data_inode =3D create_reloc_inode(rc->block_group);
+		if (IS_ERR(rc->data_inode)) {
+			err =3D PTR_ERR(rc->data_inode);
+			rc->data_inode =3D NULL;
+			goto out;
+		}
 	}
=20
 	describe_relocation(rc->block_group);
@@ -4213,6 +4635,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
 	ret =3D btrfs_zone_finish(rc->block_group);
 	WARN_ON(ret && ret !=3D -EAGAIN);
=20
+	if (*using_remap_tree) {
+		err =3D start_block_group_remapping(fs_info, path, bg);
+
+		goto out;
+	}
+
 	while (1) {
 		enum reloc_stage finishes_stage;
=20
@@ -4258,7 +4686,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info=
 *fs_info, u64 group_start)
 out:
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
-	iput(rc->data_inode);
+	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
+		iput(rc->data_inode);
+	btrfs_free_path(path);
 out_put_bg:
 	btrfs_put_block_group(bg);
 	reloc_chunk_end(fs_info);
@@ -4452,7 +4882,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *=
fs_info)
=20
 	btrfs_free_path(path);
=20
-	if (ret =3D=3D 0) {
+	if (ret =3D=3D 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root =3D btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 0021f812b12c..49bd48296ddb 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -12,7 +12,8 @@ struct btrfs_trans_handle;
 struct btrfs_ordered_extent;
 struct btrfs_pending_snapshot;
=20
-int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_=
start);
+int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_=
start,
+			       bool *using_remap_tree);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs=
_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6471861c4b25..ab4a70c420de 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -375,8 +375,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info=
 *info,
 	factor =3D btrfs_bg_type_to_factor(block_group->flags);
=20
 	spin_lock(&space_info->lock);
-	space_info->total_bytes +=3D block_group->length;
-	space_info->disk_total +=3D block_group->length * factor;
+
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) ||
+	    block_group->identity_remap_count !=3D 0) {
+		space_info->total_bytes +=3D block_group->length;
+		space_info->disk_total +=3D block_group->length * factor;
+	}
+
 	space_info->bytes_used +=3D block_group->used;
 	space_info->disk_used +=3D block_group->used * factor;
 	space_info->bytes_readonly +=3D block_group->bytes_super;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6c0a67da92f1..771415139dc0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3425,6 +3425,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_i=
nfo, u64 chunk_offset)
 	struct btrfs_block_group *block_group;
 	u64 length;
 	int ret;
+	bool using_remap_tree;
=20
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info,
@@ -3448,7 +3449,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_i=
nfo, u64 chunk_offset)
=20
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
-	ret =3D btrfs_relocate_block_group(fs_info, chunk_offset);
+	ret =3D btrfs_relocate_block_group(fs_info, chunk_offset,
+					 &using_remap_tree);
 	btrfs_scrub_continue(fs_info);
 	if (ret) {
 		/*
@@ -3467,6 +3469,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_i=
nfo, u64 chunk_offset)
 	length =3D block_group->length;
 	btrfs_put_block_group(block_group);
=20
+	if (using_remap_tree)
+		return 0;
+
 	/*
 	 * On a zoned file system, discard the whole block group, this will
 	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
@@ -4165,6 +4170,14 @@ static int __btrfs_balance(struct btrfs_fs_info *f=
s_info)
 		chunk =3D btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
 		chunk_type =3D btrfs_chunk_type(leaf, chunk);
=20
+		/* Check if chunk has already been fully relocated. */
+		if (chunk_type & BTRFS_BLOCK_GROUP_REMAPPED &&
+		    btrfs_chunk_num_stripes(leaf, chunk) =3D=3D 0) {
+			btrfs_release_path(path);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+			goto loop;
+		}
+
 		if (!counting) {
 			spin_lock(&fs_info->balance_lock);
 			bctl->stat.considered++;
--=20
2.49.0


