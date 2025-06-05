Return-Path: <linux-btrfs+bounces-14483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA307ACF42B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC64188D971
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4075521C182;
	Thu,  5 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FP/ssWtx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57071F91D6
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140636; cv=none; b=cJwnb6BLKqLCGCIYsS/gMPiYMMScK0vdJwqrWFsHk83qIYllI+wt26BuKIOZtZfXRORDRr6NOehf573CpqkvrCZubaZvrp+hnsWmMl4UIk/WfVuqmjEHhv7+Y06VAkyeNvWnp1MZIcLNb6JmmGVrA8USZAbjRyWx5JKeCVh8/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140636; c=relaxed/simple;
	bh=3pbxWpUflImzi8IGmoImq06WpLOJpGiyhWMHE/mHHoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTb2KhnI67g2iCZE7HSbGvrXlWw7csiKil3O16aoNp+Fl1vyvvIjXBIqf8SE0f1YrYKTI8/NBCSr/wfe3fMxk4yk6vjUoDbKNctlVURMQr3ONKZ02NDQZrqTMLRFXHtABvHLilA7yzzombBjdQwkeStrnSQsEpAP4L17gniYBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=FP/ssWtx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bR027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=S
	LJYYINujqW4eXVT6Fb0NOLnKgFpjOJfSa2EJ8SL9nc=; b=FP/ssWtxmyNrdQvck
	O+RXBul7SjvfTiSeoDAQtEgpdM92kJJqc+DkhFIgFOfFbDkVL+4fsmKnj90/Qd/n
	0dQthGYaKHRqaLTO7CKI3x/9XKRRvqr5C0iTYzJ1+Tj+azc9OzU98Y/tCin0u6DK
	ji4qvucr5EaknsBC0zs37xVQK4=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:54 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:51 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 66926FEC2E6E; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 08/12] btrfs: redirect I/O for remapped block groups
Date: Thu, 5 Jun 2025 17:23:38 +0100
Message-ID: <20250605162345.2561026-9-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=T2DT1MjlxhAuqhTPsMwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfXz/OcDbKpGKWi J/x82tLk2vX45ZyrqFAohVMEv26QpkYQJE5bl4Nqh0FELRAcv6O6TyjCbMLTWPaU12MvRXAdj+g 5FsAM7REcI791lWMIk1teqd+q/V4YxHY+kn4ik3Hytv8WxcXWQrIkNAE/Ij9HCehUgqQkZKJuJb
 9NKbuZXB6qKS48t6pUEywhh/jwvJ5RVtoeqKNNHrS58K3UOhitL+oMW05t48JNLQeAQy6fzO0jR saUNBTQZjUExwhiIO9j0s57LGbifT781arQCbJyhNRVDOeHvFEiGvC2g7KqlW6YQAWsbuUl5Tnc UAPWHvslni/3C6KcF/WTJSA8XUS33jY2255vnBdSmKlwf0R2k3K7rWQSo6XBBU=
X-Proofpoint-GUID: VDPPLw1bNtSZJF6CgPTu8d1bw074lOVh
X-Proofpoint-ORIG-GUID: VDPPLw1bNtSZJF6CgPTu8d1bw074lOVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

Change btrfs_map_block() so that if the block group has the REMAPPED
flag set, we call btrfs_translate_remap() to obtain a new address.

btrfs_translate_remap() searches the remap tree for a range
corresponding to the logical address passed to btrfs_map_block(). If it
is within an identity remap, this part of the block group hasn't yet
been relocated, and so we use the existing address.

If it is within an actual remap, we subtract the start of the remap
range and add the address of its destination, contained in the item's
payload.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h |  2 ++
 fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d7ec1d72821c..e45f3598ef03 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3905,6 +3905,65 @@ static const char *stage_to_string(enum reloc_stag=
e stage)
 	return "unknown";
 }
=20
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length, bool nolock)
+{
+	int ret;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap;
+	BTRFS_PATH_AUTO_FREE(path);
+
+	path =3D btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	if (nolock) {
+		path->search_commit_root =3D 1;
+		path->skip_locking =3D 1;
+	}
+
+	key.objectid =3D *logical;
+	key.type =3D (u8)-1;
+	key.offset =3D (u64)-1;
+
+	ret =3D btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
+				0, 0);
+	if (ret < 0)
+		return ret;
+
+	leaf =3D path->nodes[0];
+
+	if (path->slots[0] =3D=3D 0)
+		return -ENOENT;
+
+	path->slots[0]--;
+
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.type !=3D BTRFS_REMAP_KEY &&
+	    found_key.type !=3D BTRFS_IDENTITY_REMAP_KEY) {
+		return -ENOENT;
+	}
+
+	if (found_key.objectid > *logical ||
+	    found_key.objectid + found_key.offset <=3D *logical) {
+		return -ENOENT;
+	}
+
+	if (*logical + *length > found_key.objectid + found_key.offset)
+		*length =3D found_key.objectid + found_key.offset - *logical;
+
+	if (found_key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY)
+		return 0;
+
+	remap =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
+
+	*logical =3D *logical - found_key.objectid + btrfs_remap_address(leaf, =
remap);
+
+	return 0;
+}
+
 /*
  * function to relocate all extents in a block group.
  */
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 788c86d8633a..8c9dfc55b799 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -30,5 +30,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_i=
nfo *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 by=
tenr);
 bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length, bool nolock);
=20
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0f4954f998cd..62bd6259ebd3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6623,6 +6623,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
=20
+	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
+		u64 new_logical =3D logical;
+		bool nolock =3D !(map->type & BTRFS_BLOCK_GROUP_DATA);
+
+		/*
+		 * We use search_commit_root in btrfs_translate_remap for
+		 * metadata blocks, to avoid lockdep complaining about
+		 * recursive locking.
+		 * If we get -ENOENT this means this is a BG that has just had
+		 * its REMAPPED flag set, and so nothing has yet been actually
+		 * remapped.
+		 */
+		ret =3D btrfs_translate_remap(fs_info, &new_logical, length,
+					    nolock);
+		if (ret && (!nolock || ret !=3D -ENOENT))
+			return ret;
+
+		if (ret !=3D -ENOENT && new_logical !=3D logical) {
+			btrfs_free_chunk_map(map);
+
+			map =3D btrfs_get_chunk_map(fs_info, new_logical,
+						  *length);
+			if (IS_ERR(map))
+				return PTR_ERR(map);
+
+			logical =3D new_logical;
+		}
+
+		ret =3D 0;
+	}
+
 	num_copies =3D btrfs_chunk_map_num_copies(map);
 	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
--=20
2.49.0


