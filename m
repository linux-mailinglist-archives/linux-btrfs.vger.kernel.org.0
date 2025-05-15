Return-Path: <linux-btrfs+bounces-14044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1EAB8C95
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE075189788E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984E221719;
	Thu, 15 May 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h6hBMF5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CA1A23A0
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327019; cv=none; b=gl1AMhIHNBHJkOwb+x3eB3ssgm0bxNU4Kl3kuV4OyYQD0t9l/2A7XCSf+sadayZ+PdNkeKNuw83V0Y6YRHN+Z0rsoodokq3caRBp+g4E3+XIOodSaK28HL5Ifoqf/wL+K918LQgaVaouoD9Seq/6d+ro/T+GlvFAgrMr5zDyvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327019; c=relaxed/simple;
	bh=GJj09idSmBlnFOoDRmKNgYkgN5kgGiJX6vqPmovEy6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/c9BNHaC8h0T5xfpIpCrwWzUbV2DkAM2wXNlf6RbB01N4LFAD/GO1rCZI5gBSkYCZvWXmzUKL/g6+lwSYEoxfGOemEd365n/zcjf1jWJgpaX2PyRY/UEHVCSYFX1hOWJ3ccrAMMtBZcV8MkWb1NnAb92DbQdugBfq7p9oyMN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=h6hBMF5d; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFiJ7t009916
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=N
	rq5noAb5EflEz/0AZhhyhhTYb2jim29MN2JV8V02yE=; b=h6hBMF5dnEh7F6Q1A
	N0nc+c39RqFwym34nJRkjkp2ybcBZ29dSuUAa83hC30URWbxEQolAQVLjVLZcuzs
	MJmEfTfKNlTLqKSw/YLn9q1mzmlDFTHYx0yb9csmybcOG8FRbvJ4mPqcnVnODRxw
	/HPrD33LMHzElsHkmXg+Rd8kcA=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46n7y5cnku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:36:56 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:36:55 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 751DEF3BE123; Thu, 15 May 2025 17:36:49 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 06/10] btrfs: redirect I/O for remapped block groups
Date: Thu, 15 May 2025 17:36:34 +0100
Message-ID: <20250515163641.3449017-7-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=68261828 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=TJ4gW3yi-_f36nYRMjcA:9
X-Proofpoint-GUID: keg44Le_pDw18IM5W7V7hnp0X-63exxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfX4yXUCT8HyDAO ChpcTzm3u4PNKezQ6Bj/P1gncDJm1fIF+Ouub2Tzf7o+pyhOIrCGJpFgIK049BBi9oh9qcV/JK1 kBi1fFuiHJEwQ7TwiDG444bAOI5X36yU8U6CYSQZop30l+gngVO5Efsmf/xBo4rwd4Yyz4518dz
 T469domKmVUuMbmVLXV9LGb7QM/gzhq7zt3duCGkbvZD4cwq4oOTbyo+i3HxyoMSqjk0qRp0nQy obz43yhQJlUIJ/uOwEtzNRzcfS2emurSmKB3xQWeLxx6zzeGG0fOT0KC9Q0Z1jljqjmnIgACMz2 CGf81xIb1JQ69CB3oDVgcLyQvIq2jnaoprsKuF/ucm0oGfiA7+Bcb9Tau6kX4V1e23ibAxM7jq9
 aYZkAzvOCK/tjFgtY0EcOaW2U0zYZYLk82Nq37yOOt4R74NzpuTWlYrv09ydNQZ4/bxD07nV
X-Proofpoint-ORIG-GUID: keg44Le_pDw18IM5W7V7hnp0X-63exxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

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
 fs/btrfs/ctree.c      | 11 ++++---
 fs/btrfs/ctree.h      |  3 ++
 fs/btrfs/relocation.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h |  2 ++
 fs/btrfs/volumes.c    | 19 +++++++++++
 5 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372cc..7808f7bc2303 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2331,7 +2331,8 @@ int btrfs_search_old_slot(struct btrfs_root *root, =
const struct btrfs_key *key,
  * This may release the path, and so you may lose any locks held at the
  * time you call it.
  */
-static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *p=
ath)
+int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct btrfs_root =
*root,
+		    struct btrfs_path *path, int ins_len, int cow)
 {
 	struct btrfs_key key;
 	struct btrfs_key orig_key;
@@ -2355,7 +2356,7 @@ static int btrfs_prev_leaf(struct btrfs_root *root,=
 struct btrfs_path *path)
 	}
=20
 	btrfs_release_path(path);
-	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret <=3D 0)
 		return ret;
=20
@@ -2454,7 +2455,7 @@ int btrfs_search_slot_for_read(struct btrfs_root *r=
oot,
 		}
 	} else {
 		if (p->slots[0] =3D=3D 0) {
-			ret =3D btrfs_prev_leaf(root, p);
+			ret =3D btrfs_prev_leaf(NULL, root, p, 0, 0);
 			if (ret < 0)
 				return ret;
 			if (!ret) {
@@ -5003,7 +5004,7 @@ int btrfs_previous_item(struct btrfs_root *root,
=20
 	while (1) {
 		if (path->slots[0] =3D=3D 0) {
-			ret =3D btrfs_prev_leaf(root, path);
+			ret =3D btrfs_prev_leaf(NULL, root, path, 0, 0);
 			if (ret !=3D 0)
 				return ret;
 		} else {
@@ -5044,7 +5045,7 @@ int btrfs_previous_extent_item(struct btrfs_root *r=
oot,
=20
 	while (1) {
 		if (path->slots[0] =3D=3D 0) {
-			ret =3D btrfs_prev_leaf(root, path);
+			ret =3D btrfs_prev_leaf(NULL, root, path, 0, 0);
 			if (ret !=3D 0)
 				return ret;
 		} else {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 075a06db43a1..90a0d38a31c9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -721,6 +721,9 @@ static inline int btrfs_next_leaf(struct btrfs_root *=
root, struct btrfs_path *pa
 	return btrfs_next_old_leaf(root, path, 0);
 }
=20
+int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct btrfs_root =
*root,
+		    struct btrfs_path *path, int ins_len, int cow);
+
 static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_=
path *p)
 {
 	return btrfs_next_old_item(root, p, 0);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02086191630d..e5571c897906 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3897,6 +3897,81 @@ static const char *stage_to_string(enum reloc_stag=
e stage)
 	return "unknown";
 }
=20
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length)
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
+	key.objectid =3D *logical;
+	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
+	key.offset =3D 0;
+
+	ret =3D btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
+				0, 0);
+	if (ret < 0)
+		return ret;
+
+	leaf =3D path->nodes[0];
+
+	if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+		ret =3D btrfs_next_leaf(fs_info->remap_root, path);
+		if (ret < 0)
+			return ret;
+
+		leaf =3D path->nodes[0];
+	}
+
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.objectid > *logical) {
+		if (path->slots[0] =3D=3D 0) {
+			ret =3D btrfs_prev_leaf(NULL, fs_info->remap_root, path,
+					      0, 0);
+			if (ret) {
+				if (ret =3D=3D 1)
+					ret =3D -ENOENT;
+				return ret;
+			}
+
+			leaf =3D path->nodes[0];
+		} else {
+			path->slots[0]--;
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+	}
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
index 788c86d8633a..f07dbd9a89c6 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -30,5 +30,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_i=
nfo *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 by=
tenr);
 bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
+int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
+			  u64 *length);
=20
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 77194bb46b40..4777926213c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6620,6 +6620,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
=20
+	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
+		u64 new_logical =3D logical;
+
+		ret =3D btrfs_translate_remap(fs_info, &new_logical, length);
+		if (ret)
+			return ret;
+
+		if (new_logical !=3D logical) {
+			btrfs_free_chunk_map(map);
+
+			map =3D btrfs_get_chunk_map(fs_info, new_logical,
+						  *length);
+			if (IS_ERR(map))
+				return PTR_ERR(map);
+
+			logical =3D new_logical;
+		}
+	}
+
 	num_copies =3D btrfs_chunk_map_num_copies(map);
 	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
--=20
2.49.0


