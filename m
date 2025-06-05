Return-Path: <linux-btrfs+bounces-14491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78265ACF43A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B983AF452
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21D23E346;
	Thu,  5 Jun 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LET3HRWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F431E5B7D
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140646; cv=none; b=lWgxHlW12ooLTjTob5kVCNfXrFCBL0eh0FUADV9ONFQ5epXBKADTBbO6XdUlYRLvU99+bURXx5RE3AcrhRTkAHqJQHfB8pW7XsNHuKOK7Bd8Qa9Aaad50nyrArBmDe8WrgKGAVC2AhVpcCXcB7wgujlBDSvtScKW+iFpPu2XMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140646; c=relaxed/simple;
	bh=TyR5tw/8AiU5xJkQnlfUrPd3LbY9m1HKghih6W53+jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghv6w2vxKP11dWYHeveU6tdtSZIPq+gbYmgTxSpMo+9wd2LVpTWNdyg5TshPZiIGlFfgoxXjtcSpBmM535+zlxtyexS2f8rNZxlyJOTsjdnthdpXzptASm76+WKbAawmil/TArxN2v0Ijv7N7RFwJHiqFMR+ogT8/m6pICvT6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=LET3HRWd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DwI91006437
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=L
	djphJV2zjWQdmQfhjD5nZl8X+XXvW4R5Nljr157E1E=; b=LET3HRWd1lbv8lY7p
	Wb5CBhgKssDT+1bTiGJG1lQJhn2dfleAEqzCb2Y0aTdK+i57MsizjERE8SNbo4qI
	DWfy1LhzLItZpkKV4PmznzsdTqIwHKA5l8xWfNOkA6CgEnzWLUQQEqFhm2XcK3Jg
	i6cdIS5sRe2rSK/k7ah2GwQyb0=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739uca8x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:24:02 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:24:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 89388FEC2E76; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 12/12] btrfs: replace identity maps with actual remaps when doing relocations
Date: Thu, 5 Jun 2025 17:23:42 +0100
Message-ID: <20250605162345.2561026-13-maharmstone@fb.com>
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
X-Proofpoint-GUID: PFywvESAEEdkeNQfUA1T8UPm69w2NIng
X-Proofpoint-ORIG-GUID: PFywvESAEEdkeNQfUA1T8UPm69w2NIng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX0eneHQoOk8PZ VHZvcaQXZEVgnYc0B9MCWMZ/TMvR1XWvf3uIE/rX+5WV+comUozTNcHS8AISPXEj+FUVWfyRsMA P02/Xb0BHWjDx16SrXbrGtCWka5hcG4OneAU0Uu/ou0nrOpj8j7WkfrDg0ixe/hBqbxcxLzqMSF
 ifU2PtU34LDLJopLWu6dkPPsqvmTWnKgMIxqGm36yhMBgGO5fLs7XxT3w7O3pjdsVcHC/D03eUR Abt7+77XSR059RimqND4GGHvAiqV91dkXKMlLvmxOl1uQIxhp/7umFAYaxjDU7/5KYtfA20tMxE c3/hXesYNaTqYERuk3/cMHLpDSdOu7bdvYGsUZKX9O+XjQC/Pd9zef/iFV/BFOv2RJmk/MEL4iw
 wzMqJs8INxVc+OkOcf8O6ev1tjOSCimK733wkr0Uxhhp71CzeiY9FU0NTu75yJmkRW4nwmCH
X-Authority-Analysis: v=2.4 cv=MNhgmNZl c=1 sm=1 tr=0 ts=6841c4a2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=4R1m0SgylyorSHB2tyoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

Add a function do_remap_tree_reloc(), which does the actual work of
doing a relocation using the remap tree.

In a loop we call do_remap_tree_reloc_trans(), which searches for the
first identity remap for the block group. We call btrfs_reserve_extent()
to find space elsewhere for it, and read the data into memory and write
it to the new location. We then carve out the identity remap and replace
it with an actual remap, which points to the new location in which to
look.

Once the last identity remap has been removed we call
last_identity_remap_gone(), which, as with deletions, removes the
chunk's stripes and device extents.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/relocation.c | 335 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d7aad3f92224..95b28678fb65 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4710,6 +4710,61 @@ static int mark_bg_remapped(struct btrfs_trans_han=
dle *trans,
 	return ret;
 }
=20
+static int find_next_identity_remap(struct btrfs_trans_handle *trans,
+				    struct btrfs_path *path, u64 bg_end,
+				    u64 last_start, u64 *start,
+				    u64 *length)
+{
+	int ret;
+	struct btrfs_key key, found_key;
+	struct btrfs_root *remap_root =3D trans->fs_info->remap_root;
+	struct extent_buffer *leaf;
+
+	key.objectid =3D last_start;
+	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+	key.offset =3D 0;
+
+	ret =3D btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	leaf =3D path->nodes[0];
+	while (true) {
+		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(remap_root, path);
+
+			if (ret !=3D 0) {
+				if (ret =3D=3D 1)
+					ret =3D -ENOENT;
+				goto out;
+			}
+
+			leaf =3D path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.objectid >=3D bg_end) {
+			ret =3D -ENOENT;
+			goto out;
+		}
+
+		if (found_key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY) {
+			*start =3D found_key.objectid;
+			*length =3D found_key.offset;
+			ret =3D 0;
+			goto out;
+		}
+
+		path->slots[0]++;
+	}
+
+out:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
 				struct btrfs_chunk_map *chunk,
 				struct btrfs_path *path)
@@ -4829,6 +4884,98 @@ static int adjust_identity_remap_count(struct btrf=
s_trans_handle *trans,
 	return ret;
 }
=20
+static int add_remap_entry(struct btrfs_trans_handle *trans,
+			   struct btrfs_path *path,
+			   struct btrfs_block_group *src_bg, u64 old_addr,
+			   u64 new_addr, u64 length)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_key key, new_key;
+	int ret;
+	int identity_count_delta =3D 0;
+
+	key.objectid =3D old_addr;
+	key.type =3D (u8)-1;
+	key.offset =3D (u64)-1;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, -1, 1=
);
+	if (ret < 0)
+		goto end;
+
+	if (path->slots[0] =3D=3D 0) {
+		ret =3D -ENOENT;
+		goto end;
+	}
+
+	path->slots[0]--;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+	if (key.type !=3D BTRFS_IDENTITY_REMAP_KEY ||
+	    key.objectid > old_addr ||
+	    key.objectid + key.offset <=3D old_addr) {
+		ret =3D -ENOENT;
+		goto end;
+	}
+
+	/* Shorten or delete identity mapping entry. */
+
+	if (key.objectid =3D=3D old_addr) {
+		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret)
+			goto end;
+
+		identity_count_delta--;
+	} else {
+		new_key.objectid =3D key.objectid;
+		new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+		new_key.offset =3D old_addr - key.objectid;
+
+		btrfs_set_item_key_safe(trans, path, &new_key);
+	}
+
+	btrfs_release_path(path);
+
+	/* Create new remap entry. */
+
+	ret =3D add_remap_item(trans, path, new_addr, length, old_addr);
+	if (ret)
+		goto end;
+
+	/* Add entry for remainder of identity mapping, if necessary. */
+
+	if (key.objectid + key.offset !=3D old_addr + length) {
+		new_key.objectid =3D old_addr + length;
+		new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+		new_key.offset =3D key.objectid + key.offset - old_addr - length;
+
+		ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+					      path, &new_key, 0);
+		if (ret)
+			goto end;
+
+		btrfs_release_path(path);
+
+		identity_count_delta++;
+	}
+
+	/* Add backref. */
+
+	ret =3D add_remap_backref_item(trans, path, new_addr, length, old_addr)=
;
+	if (ret)
+		goto end;
+
+	if (identity_count_delta !=3D 0) {
+		ret =3D adjust_identity_remap_count(trans, path, src_bg,
+						  identity_count_delta);
+	}
+
+end:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
 			       struct btrfs_path *path, uint64_t start)
 {
@@ -4878,6 +5025,186 @@ static int mark_chunk_remapped(struct btrfs_trans=
_handle *trans,
 	return ret;
 }
=20
+static int do_remap_tree_reloc_trans(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group *src_bg,
+				     struct btrfs_path *path, u64 *last_start)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *extent_root;
+	struct btrfs_key ins;
+	struct btrfs_block_group *dest_bg =3D NULL;
+	struct btrfs_chunk_map *chunk;
+	u64 start, remap_length, length, new_addr, min_size;
+	int ret;
+	bool no_more =3D false;
+	bool is_data =3D src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
+	bool made_reservation =3D false, bg_needs_free_space;
+	struct btrfs_space_info *sinfo =3D src_bg->space_info;
+
+	extent_root =3D btrfs_extent_root(fs_info, src_bg->start);
+
+	trans =3D btrfs_start_transaction(extent_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	ret =3D find_next_identity_remap(trans, path, src_bg->start + src_bg->l=
ength,
+				       *last_start, &start, &remap_length);
+	if (ret =3D=3D -ENOENT) {
+		no_more =3D true;
+		goto next;
+	} else if (ret) {
+		mutex_unlock(&fs_info->remap_mutex);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	/* Try to reserve enough space for block. */
+
+	spin_lock(&sinfo->lock);
+	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
+	spin_unlock(&sinfo->lock);
+
+	if (is_data)
+		min_size =3D fs_info->sectorsize;
+	else
+		min_size =3D fs_info->nodesize;
+
+	ret =3D btrfs_reserve_extent(fs_info->fs_root, remap_length,
+				   remap_length, min_size,
+				   0, 0, &ins, is_data, false);
+	if (ret) {
+		spin_lock(&sinfo->lock);
+		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
+		spin_unlock(&sinfo->lock);
+
+		mutex_unlock(&fs_info->remap_mutex);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	made_reservation =3D true;
+
+	new_addr =3D ins.objectid;
+	length =3D ins.offset;
+
+	if (!is_data && !IS_ALIGNED(length, fs_info->nodesize)) {
+		u64 new_length =3D ALIGN_DOWN(length, fs_info->nodesize);
+
+		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
+					   length - new_length, 0);
+
+		length =3D new_length;
+	}
+
+	dest_bg =3D btrfs_lookup_block_group(fs_info, new_addr);
+
+	mutex_lock(&dest_bg->free_space_lock);
+	bg_needs_free_space =3D test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+				       &dest_bg->runtime_flags);
+	mutex_unlock(&dest_bg->free_space_lock);
+
+	if (bg_needs_free_space) {
+		ret =3D add_block_group_free_space(trans, dest_bg);
+		if (ret)
+			goto fail;
+	}
+
+	ret =3D do_copy(fs_info, start, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret =3D remove_from_free_space_tree(trans, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret =3D add_remap_entry(trans, path, src_bg, start, new_addr, length);
+	if (ret) {
+		add_to_free_space_tree(trans, new_addr, length);
+		goto fail;
+	}
+
+	adjust_block_group_remap_bytes(trans, dest_bg, length);
+	btrfs_free_reserved_bytes(dest_bg, length, 0);
+
+	spin_lock(&sinfo->lock);
+	sinfo->bytes_readonly +=3D length;
+	spin_unlock(&sinfo->lock);
+
+next:
+	if (dest_bg)
+		btrfs_put_block_group(dest_bg);
+
+	if (made_reservation)
+		btrfs_dec_block_group_reservations(fs_info, new_addr);
+
+	if (src_bg->used =3D=3D 0 && src_bg->remap_bytes =3D=3D 0) {
+		chunk =3D btrfs_find_chunk_map(fs_info, src_bg->start, 1);
+		if (!chunk) {
+			mutex_unlock(&fs_info->remap_mutex);
+			btrfs_end_transaction(trans);
+			return -ENOENT;
+		}
+
+		ret =3D last_identity_remap_gone(trans, chunk, src_bg, path);
+		if (ret) {
+			btrfs_free_chunk_map(chunk);
+			mutex_unlock(&fs_info->remap_mutex);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+
+		btrfs_free_chunk_map(chunk);
+	}
+
+	mutex_unlock(&fs_info->remap_mutex);
+
+	ret =3D btrfs_end_transaction(trans);
+	if (ret)
+		return ret;
+
+	if (no_more)
+		return 1;
+
+	*last_start =3D start;
+
+	return 0;
+
+fail:
+	if (dest_bg)
+		btrfs_put_block_group(dest_bg);
+
+	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
+
+	mutex_unlock(&fs_info->remap_mutex);
+	btrfs_end_transaction(trans);
+
+	return ret;
+}
+
+static int do_remap_tree_reloc(struct btrfs_fs_info *fs_info,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *bg)
+{
+	u64 last_start;
+	int ret;
+
+	last_start =3D bg->start;
+
+	while (true) {
+		ret =3D do_remap_tree_reloc_trans(fs_info, bg, path,
+						&last_start);
+		if (ret) {
+			if (ret =3D=3D 1)
+				ret =3D 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length, bool nolock)
 {
@@ -5119,6 +5446,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start,
 		}
=20
 		err =3D start_block_group_remapping(fs_info, path, bg);
+		if (err)
+			goto out;
+
+		err =3D do_remap_tree_reloc(fs_info, path, rc->block_group);
+		if (err)
+			goto out;
+
+		btrfs_delete_unused_bgs(fs_info);
=20
 		goto out;
 	}
--=20
2.49.0


