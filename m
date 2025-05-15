Return-Path: <linux-btrfs+bounces-14046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E658AB8C94
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76D14A1E6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B32222C3;
	Thu, 15 May 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JU8xeVW9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B521FF4A
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327020; cv=none; b=Y/Ciz6D0glF9FtQgYlrKF6gctq+qyXfXgFUOC1wErcWHettclyU9SdLX9EidPgPL74AMKxyAn2uAvJ+igl7L9B1dGSpNbh2VDTF9TynjMamzGZF12gXUG7L69XxYNCdtBQarhuxFqEN3gUT+mUThDIZqykHks4mDUNqsPYvJdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327020; c=relaxed/simple;
	bh=Lnm2TrjBtdfqMKWoFA/KjsNyMm902J8KYCVTQnJ5oQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQfoZBlZoD9aKyqOPDeeNIuY208wuAt2hQ+pbXFwT69efV9QR+jFqshjic3D7kYF19JE+KksulCAQwBJwb4ceA/kOGhaP4nF7xVncK2XTg1j5Fl3XIUxbx/aeceLwHcHb1cvdPt+k4bv3Q7X/98pQ2b56xbTq+1kGbYMEM3vUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=JU8xeVW9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFiJ7u009916
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=o
	Gqq4nkZMSKrTDSV8UOCbkVgR7PjVhC/v8lucUMY2ME=; b=JU8xeVW97x2YKnB6h
	mvwWm21ogDuoEV688xAmBQNZ/dRX/IJ7VrdM2+JTnI5fob1msqMcmd+61YroJsLW
	FVbIpxnz5DqFWizOcgxiBejUOtATEMr+Rfxvs4/oqtjqkhOmtErAnTjdAKJKoAzK
	mcjV3XmffKWY9q76s0/go7S3W8=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46n7y5cnku-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:56 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:36:55 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4B0F6F3BE12D; Thu, 15 May 2025 17:36:51 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 10/10] btrfs: replace identity maps with actual remaps when doing relocations
Date: Thu, 15 May 2025 17:36:38 +0100
Message-ID: <20250515163641.3449017-11-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=68261828 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=2XcNAMO55qtriRe8onAA:9
X-Proofpoint-GUID: WGbVRO9ZxebtmDhbu2a7mWWbRmS1DwDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfXxnrtq4LWif72 5sJnoakDrfrms5jLQxYoftWDAirCnxeAx38TNoYzTg94JwZLaOH+JapsrlTPjG4bIaoUJL+W7Xn WW62k7KcI+kwandEzPUmyRJqimQeSHPWzH0q16rZr5rhQXGb6de+WVG9452CL9SDp6ob0eoWH/y
 mfcMyFXF+t3oQjUSi2hDNlsvxaHCRbHGzFeLQZqzmwSRXsL56wWc0hAkENAqldR/XyFoYvw49Ov rYazF/8+XWVNPtVrGqSBn8IlpfKIjWDeLtKbqPrAOyk1+8Z/ijl58T8y0Ci/VFMr7L1pFkngFm6 TD9CFH58zR9RdhGOGqGHw5M6q+iTMVgMs9AgfjDlWex2Kxf1kKT4SghbsPvlmqqrj70aaQML2yI
 ebJG3b4Vay5tbac+BygYTDE0Pckw2a0Lp8dOoTqytap0RVz+W0+RRXE0gcYaUZWXi2sXxoA3
X-Proofpoint-ORIG-GUID: WGbVRO9ZxebtmDhbu2a7mWWbRmS1DwDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

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
 fs/btrfs/relocation.c | 522 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 522 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7da95b82c798..bcf04d4c5af1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4660,6 +4660,60 @@ static int mark_bg_remapped(struct btrfs_trans_han=
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
@@ -4779,6 +4833,288 @@ static int adjust_identity_remap_count(struct btr=
fs_trans_handle *trans,
 	return ret;
 }
=20
+static int merge_remap_entries(struct btrfs_trans_handle *trans,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *src_bg, u64 old_addr,
+			       u64 new_addr, u64 length)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_remap *remap_ptr;
+	struct extent_buffer *leaf;
+	struct btrfs_key key, new_key;
+	u64 last_addr, old_length;
+	int ret;
+
+	leaf =3D path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+	remap_ptr =3D btrfs_item_ptr(leaf, path->slots[0],
+				   struct btrfs_remap);
+
+	last_addr =3D btrfs_remap_address(leaf, remap_ptr);
+	old_length =3D key.offset;
+
+	if (last_addr + old_length !=3D new_addr)
+		return 0;
+
+	/* Merge entries. */
+
+	new_key.objectid =3D key.objectid;
+	new_key.type =3D BTRFS_REMAP_KEY;
+	new_key.offset =3D old_length + length;
+
+	btrfs_set_item_key_safe(trans, path, &new_key);
+
+	btrfs_release_path(path);
+
+	/* Merge backref too. */
+
+	key.objectid =3D new_addr - old_length;
+	key.type =3D BTRFS_REMAP_BACKREF_KEY;
+	key.offset =3D old_length;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1)=
;
+	if (ret < 0) {
+		return ret;
+	} else if (ret =3D=3D 1) {
+		btrfs_release_path(path);
+		return -ENOENT;
+	}
+
+	new_key.objectid =3D new_addr - old_length;
+	new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+	new_key.offset =3D old_length + length;
+
+	btrfs_set_item_key_safe(trans, path, &new_key);
+
+	btrfs_release_path(path);
+
+	/* Fix the following identity map. */
+
+	key.objectid =3D old_addr;
+	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+	key.offset =3D 0;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1)=
;
+	if (ret < 0)
+		return ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+	if (key.objectid !=3D old_addr || key.type !=3D BTRFS_IDENTITY_REMAP_KE=
Y)
+		return -ENOENT;
+
+	if (key.offset =3D=3D length) {
+		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret)
+			return ret;
+
+		btrfs_release_path(path);
+
+		ret =3D adjust_identity_remap_count(trans, path, src_bg, -1);
+		if (ret)
+			return ret;
+
+		return 1;
+	}
+
+	new_key.objectid =3D old_addr + length;
+	new_key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+	new_key.offset =3D key.offset - length;
+
+	btrfs_set_item_key_safe(trans, path, &new_key);
+
+	btrfs_release_path(path);
+
+	return 1;
+}
+
+static int add_new_remap_entry(struct btrfs_trans_handle *trans,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *src_bg, u64 old_addr,
+			       u64 new_addr, u64 length)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_key key, new_key;
+	struct btrfs_remap remap;
+	int ret;
+	int identity_count_delta =3D 0;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+	/* Shorten or delete identity mapping entry. */
+
+	if (key.objectid =3D=3D old_addr) {
+		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret)
+			return ret;
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
+	new_key.objectid =3D old_addr;
+	new_key.type =3D BTRFS_REMAP_KEY;
+	new_key.offset =3D length;
+
+	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+		path, &new_key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	btrfs_set_stack_remap_address(&remap, new_addr);
+
+	write_extent_buffer(path->nodes[0], &remap,
+		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+		sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
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
+			return ret;
+
+		btrfs_release_path(path);
+
+		identity_count_delta++;
+	}
+
+	/* Add backref. */
+
+	new_key.objectid =3D new_addr;
+	new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+	new_key.offset =3D length;
+
+	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root, path,
+				      &new_key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	btrfs_set_stack_remap_address(&remap, old_addr);
+
+	write_extent_buffer(path->nodes[0], &remap,
+		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+		sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
+
+	if (identity_count_delta =3D=3D 0)
+		return 0;
+
+	ret =3D adjust_identity_remap_count(trans, path, src_bg,
+					  identity_count_delta);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int add_remap_entry(struct btrfs_trans_handle *trans,
+			   struct btrfs_path *path,
+			   struct btrfs_block_group *src_bg, u64 old_addr,
+			   u64 new_addr, u64 length)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid =3D old_addr;
+	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+	key.offset =3D 0;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1)=
;
+	if (ret < 0)
+		goto end;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+	if (key.objectid >=3D old_addr) {
+		if (path->slots[0] =3D=3D 0) {
+			ret =3D btrfs_prev_leaf(trans, fs_info->remap_root, path,
+					      0, 1);
+			if (ret < 0)
+				goto end;
+		} else {
+			path->slots[0]--;
+		}
+	}
+
+	while (true) {
+		leaf =3D path->nodes[0];
+		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(fs_info->remap_root, path);
+			if (ret < 0)
+				goto end;
+			else if (ret =3D=3D 1)
+				break;
+			leaf =3D path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+		if (key.objectid >=3D old_addr + length) {
+			ret =3D -ENOENT;
+			goto end;
+		}
+
+		if (key.type !=3D BTRFS_REMAP_KEY &&
+		    key.type !=3D BTRFS_IDENTITY_REMAP_KEY) {
+			path->slots[0]++;
+			continue;
+		}
+
+		if (key.type =3D=3D BTRFS_REMAP_KEY &&
+		    key.objectid + key.offset =3D=3D old_addr) {
+			ret =3D merge_remap_entries(trans, path, src_bg, old_addr,
+						  new_addr, length);
+			if (ret < 0) {
+				goto end;
+			} else if (ret =3D=3D 0) {
+				path->slots[0]++;
+				continue;
+			}
+			break;
+		}
+
+		if (key.objectid <=3D old_addr &&
+		    key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY &&
+		    key.objectid + key.offset > old_addr) {
+			ret =3D add_new_remap_entry(trans, path, src_bg,
+						  old_addr, new_addr, length);
+			if (ret)
+				goto end;
+			break;
+		}
+
+		path->slots[0]++;
+	}
+
+	ret =3D 0;
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
@@ -4828,6 +5164,188 @@ static int mark_chunk_remapped(struct btrfs_trans=
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
+	if (!is_data && length % fs_info->nodesize) {
+		u64 new_length =3D length - (length % fs_info->nodesize);
+
+		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
+					   length - new_length, 0);
+
+		length =3D new_length;
+	}
+
+	ret =3D add_to_free_space_tree(trans, start, length);
+	if (ret)
+		goto fail;
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
+	ret =3D remove_from_free_space_tree(trans, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret =3D do_copy(fs_info, start, new_addr, length);
+	if (ret)
+		goto fail;
+
+	ret =3D add_remap_entry(trans, path, src_bg, start, new_addr, length);
+	if (ret)
+		goto fail;
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
 			  u64 *length)
 {
@@ -5073,6 +5591,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start,
 		}
=20
 		err =3D start_block_group_remapping(fs_info, path, bg);
+		if (err)
+			goto out;
+
+		err =3D do_remap_tree_reloc(fs_info, path, rc->block_group);
=20
 		goto out;
 	}
--=20
2.49.0


