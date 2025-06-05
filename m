Return-Path: <linux-btrfs+bounces-14489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9AACF43B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9566C7A981E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA60274FDF;
	Thu,  5 Jun 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KP+1DbkE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F142749D9
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140639; cv=none; b=glmCvJh+UHpD5KzMXG6Hxflwwx0YbzV0FET45Hv/RVELo31grkMuY5h8Hr/MnbImCrLaiwufVmYwkC/bqN/hV1HSUOipQUO2DA9+yPYCBILHNCnluOABMuV5fpQH/LI49TtZ3vv+njh99f68joU6s0tXiD347OUJ0Jp4ZNALB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140639; c=relaxed/simple;
	bh=H+soAwga5ibnG49mXqIKYFUX6gVkmOoKuDaMYT0nkYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQYPtjXb6NiBnXCSV2CFpyOoMdiKcecMLQcX8ZhLEpgWKZdS8F/O6eP2LQOT7oPGVleYgQQxoM5O44yP4+KaMJ+z9TcFWE60kieXbgoscwX0+czidxwD8PsyI1mf3n1NHNaziS20Tnm4BOD6gSVCT1vjXK0PJ7IkBNiVfBzMhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=KP+1DbkE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bV027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=9
	iXXcXnEIzQ8HVF6AuowawVqn97JlKimveHCUfopcmc=; b=KP+1DbkETc7Ng/Q73
	FwJSR6yBO6qFxmGf7tNOjkjxQiqh4SjiWgAnEeOvUSmoauEHYDFuGdI97af8VU0T
	H8uBNzw4H0fUalv0Iy/YI9R9hhEyE5eQOP6JB7nrJS8czVYv8GmUXSgcVDkCVD50
	b4IOdEA7fOgOEWV5T0ESnX93OY=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:56 -0700 (PDT)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:54 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 6FFCEFEC2E70; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 09/12] btrfs: handle deletions from remapped block group
Date: Thu, 5 Jun 2025 17:23:39 +0100
Message-ID: <20250605162345.2561026-10-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=yrd2W20rDEQ1Dg_uNJkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX50INnhkYGUF7 wbjCR/O3H9Er5z6rPcyDlpn6FL/L25SoGCf74IqPZ0ntYJZw10C1ujLrFm4jCpI25atS5GqH0th vmMGz+wTox6DshHJI9yQdMSYxZ/7UN3oSqtbzq6Xpj1P4Auy+63nrp13xpSMNDZG+Fd0SZqic11
 HAUcpTn3FM2pvF/BYHWJhaso1BQ/4j5ZI5Y9LA/vTFeK/xaoEhdQ0tLBf4AQNeyfYyIUnHV8u2w Mrqch/vkiVWt6fHSzByt2H1AMaAR6GkfuEJVCn8yeknW8+nOZtGOxLyXmpfHEt8pyzvPk1KdJ2O I4m49aEbkHxxFgV6UpmiMjxhWX4I4nhXe9V2BYmh6KbUGmssv26TJD7q92lIwJzx4zF7EhNcjNr
 1iDHOtByRZ9Z7wuKExYUdnwLD5P3HkM8R97rw3FgwsiisyjZ2HAOA5tA4pzOv6Kynjtk9Tzk
X-Proofpoint-GUID: 3V4E2osJPQ7OR26tteBK_NP3yfYK5onk
X-Proofpoint-ORIG-GUID: 3V4E2osJPQ7OR26tteBK_NP3yfYK5onk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

Handle the case where we free an extent from a block group that has the
REMAPPED flag set. Because the remap tree is orthogonal to the extent
tree, for data this may be within any number of identity remaps or
actual remaps. If we're freeing a metadata node, this will be wholly
inside one or the other.

btrfs_remove_extent_from_remap_tree() searches the remap tree for the
remaps that cover the range in question, then calls
remove_range_from_remap_tree() for each one, to punch a hole in the
remap and adjust the free-space tree.

For an identity remap, remove_range_from_remap_tree() will adjust the
block group's `identity_remap_count` if this changes. If it reaches
zero we call last_identity_remap_gone(), which removes the chunk's
stripes and device extents - it is now fully remapped.

The changes which involve the block group's ro flag are because the
REMAPPED flag itself prevents a block group from having any new
allocations within it, and so we don't need to account for this
separately.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/block-group.c |  80 ++++---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/disk-io.c     |   1 +
 fs/btrfs/extent-tree.c |  30 ++-
 fs/btrfs/fs.h          |   1 +
 fs/btrfs/relocation.c  | 505 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h  |   3 +
 fs/btrfs/volumes.c     |  56 +++--
 fs/btrfs/volumes.h     |   6 +
 9 files changed, 628 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4529356bb1e3..334df145ab3f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1055,6 +1055,32 @@ static int remove_block_group_item(struct btrfs_tr=
ans_handle *trans,
 	return ret;
 }
=20
+void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group)
+{
+	int factor =3D btrfs_bg_type_to_factor(block_group->flags);
+
+	spin_lock(&block_group->space_info->lock);
+
+	if (btrfs_test_opt(block_group->fs_info, ENOSPC_DEBUG)) {
+		WARN_ON(block_group->space_info->total_bytes
+			< block_group->length);
+		WARN_ON(block_group->space_info->bytes_readonly
+			< block_group->length - block_group->zone_unusable);
+		WARN_ON(block_group->space_info->bytes_zone_unusable
+			< block_group->zone_unusable);
+		WARN_ON(block_group->space_info->disk_total
+			< block_group->length * factor);
+	}
+	block_group->space_info->total_bytes -=3D block_group->length;
+	block_group->space_info->bytes_readonly -=3D
+		(block_group->length - block_group->zone_unusable);
+	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
+						    -block_group->zone_unusable);
+	block_group->space_info->disk_total -=3D block_group->length * factor;
+
+	spin_unlock(&block_group->space_info->lock);
+}
+
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map)
 {
@@ -1066,7 +1092,6 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
 	struct kobject *kobj =3D NULL;
 	int ret;
 	int index;
-	int factor;
 	struct btrfs_caching_control *caching_ctl =3D NULL;
 	bool remove_map;
 	bool remove_rsv =3D false;
@@ -1075,7 +1100,7 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
 	if (!block_group)
 		return -ENOENT;
=20
-	BUG_ON(!block_group->ro);
+	BUG_ON(!block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REM=
APPED));
=20
 	trace_btrfs_remove_block_group(block_group);
 	/*
@@ -1087,7 +1112,6 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
 				  block_group->length);
=20
 	index =3D btrfs_bg_flags_to_raid_index(block_group->flags);
-	factor =3D btrfs_bg_type_to_factor(block_group->flags);
=20
 	/* make sure this block group isn't part of an allocation cluster */
 	cluster =3D &fs_info->data_alloc_cluster;
@@ -1211,26 +1235,11 @@ int btrfs_remove_block_group(struct btrfs_trans_h=
andle *trans,
=20
 	spin_lock(&block_group->space_info->lock);
 	list_del_init(&block_group->ro_list);
-
-	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		WARN_ON(block_group->space_info->total_bytes
-			< block_group->length);
-		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length - block_group->zone_unusable);
-		WARN_ON(block_group->space_info->bytes_zone_unusable
-			< block_group->zone_unusable);
-		WARN_ON(block_group->space_info->disk_total
-			< block_group->length * factor);
-	}
-	block_group->space_info->total_bytes -=3D block_group->length;
-	block_group->space_info->bytes_readonly -=3D
-		(block_group->length - block_group->zone_unusable);
-	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
-						    -block_group->zone_unusable);
-	block_group->space_info->disk_total -=3D block_group->length * factor;
-
 	spin_unlock(&block_group->space_info->lock);
=20
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED))
+		btrfs_remove_bg_from_sinfo(block_group);
+
 	/*
 	 * Remove the free space for the block group from the free space tree
 	 * and the block group's item from the extent tree before marking the
@@ -1517,6 +1526,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
 	while (!list_empty(&fs_info->unused_bgs)) {
 		u64 used;
 		int trimming;
+		bool made_ro =3D false;
=20
 		block_group =3D list_first_entry(&fs_info->unused_bgs,
 					       struct btrfs_block_group,
@@ -1553,7 +1563,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
=20
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
-		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) ||
+		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAP=
PED)) ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
@@ -1596,7 +1607,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
 		 */
 		used =3D btrfs_space_info_used(space_info, true);
 		if (space_info->total_bytes - block_group->length < used &&
-		    block_group->zone_unusable < block_group->length) {
+		    block_group->zone_unusable < block_group->length &&
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
@@ -1614,8 +1626,14 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
 		spin_unlock(&block_group->lock);
 		spin_unlock(&space_info->lock);
=20
-		/* We don't want to force the issue, only flip if it's ok. */
-		ret =3D inc_block_group_ro(block_group, 0);
+		if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+			/* We don't want to force the issue, only flip if it's ok. */
+			ret =3D inc_block_group_ro(block_group, 0);
+			made_ro =3D true;
+		} else {
+			ret =3D 0;
+		}
+
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret =3D 0;
@@ -1624,7 +1642,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
=20
 		ret =3D btrfs_zone_finish(block_group);
 		if (ret < 0) {
-			btrfs_dec_block_group_ro(block_group);
+			if (made_ro)
+				btrfs_dec_block_group_ro(block_group);
 			if (ret =3D=3D -EAGAIN)
 				ret =3D 0;
 			goto next;
@@ -1637,7 +1656,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
 		trans =3D btrfs_start_trans_remove_block_group(fs_info,
 						     block_group->start);
 		if (IS_ERR(trans)) {
-			btrfs_dec_block_group_ro(block_group);
+			if (made_ro)
+				btrfs_dec_block_group_ro(block_group);
 			ret =3D PTR_ERR(trans);
 			goto next;
 		}
@@ -1647,7 +1667,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
 		 * just delete them, we don't care about them anymore.
 		 */
 		if (!clean_pinned_extents(trans, block_group)) {
-			btrfs_dec_block_group_ro(block_group);
+			if (made_ro)
+				btrfs_dec_block_group_ro(block_group);
 			goto end_trans;
 		}
=20
@@ -1661,7 +1682,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
 		spin_lock(&fs_info->discard_ctl.lock);
 		if (!list_empty(&block_group->discard_list)) {
 			spin_unlock(&fs_info->discard_ctl.lock);
-			btrfs_dec_block_group_ro(block_group);
+			if (made_ro)
+				btrfs_dec_block_group_ro(block_group);
 			btrfs_discard_queue_work(&fs_info->discard_ctl,
 						 block_group);
 			goto end_trans;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c484118b8b8d..767898929960 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -329,6 +329,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group=
 *block_group,
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
+void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group);
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a0542b581f4e..dac22efd2332 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2922,6 +2922,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	mutex_init(&fs_info->chunk_mutex);
 	mutex_init(&fs_info->transaction_kthread_mutex);
 	mutex_init(&fs_info->cleaner_mutex);
+	mutex_init(&fs_info->remap_mutex);
 	mutex_init(&fs_info->ro_block_group_mutex);
 	init_rwsem(&fs_info->commit_root_sem);
 	init_rwsem(&fs_info->cleanup_work_sem);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e8f752ef1da9..995784cdca9d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -40,6 +40,7 @@
 #include "orphan.h"
 #include "tree-checker.h"
 #include "raid-stripe-tree.h"
+#include "relocation.h"
=20
 #undef SCRAMBLE_DELAYED_REFS
=20
@@ -2977,6 +2978,8 @@ static int do_free_extent_accounting(struct btrfs_t=
rans_handle *trans,
 				     u64 bytenr, struct btrfs_squota_delta *delta)
 {
 	int ret;
+	struct btrfs_block_group *bg;
+	bool bg_is_remapped =3D false;
 	u64 num_bytes =3D delta->num_bytes;
=20
 	if (delta->is_data) {
@@ -3002,10 +3005,22 @@ static int do_free_extent_accounting(struct btrfs=
_trans_handle *trans,
 		return ret;
 	}
=20
-	ret =3D add_to_free_space_tree(trans, bytenr, num_bytes);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		return ret;
+	if (btrfs_fs_incompat(trans->fs_info, REMAP_TREE)) {
+		bg =3D btrfs_lookup_block_group(trans->fs_info, bytenr);
+		bg_is_remapped =3D bg->flags & BTRFS_BLOCK_GROUP_REMAPPED;
+		btrfs_put_block_group(bg);
+	}
+
+	/*
+	 * If remapped, FST has already been taken care of in
+	 * remove_range_from_remap_tree().
+	 */
+	if (!bg_is_remapped) {
+		ret =3D add_to_free_space_tree(trans, bytenr, num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
=20
 	ret =3D btrfs_update_block_group(trans, bytenr, num_bytes, false);
@@ -3387,6 +3402,13 @@ static int __btrfs_free_extent(struct btrfs_trans_=
handle *trans,
 		}
 		btrfs_release_path(path);
=20
+		ret =3D btrfs_remove_extent_from_remap_tree(trans, path, bytenr,
+							  num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
 		ret =3D do_free_extent_accounting(trans, bytenr, &delta);
 	}
 	btrfs_release_path(path);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8ceeb64aceb3..fd7dc61be9c7 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -551,6 +551,7 @@ struct btrfs_fs_info {
 	struct mutex transaction_kthread_mutex;
 	struct mutex cleaner_mutex;
 	struct mutex chunk_mutex;
+	struct mutex remap_mutex;
=20
 	/*
 	 * This is taken to make sure we don't set block groups ro after the
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e45f3598ef03..54c3e99c7dab 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -37,6 +37,7 @@
 #include "super.h"
 #include "tree-checker.h"
 #include "raid-stripe-tree.h"
+#include "free-space-tree.h"
=20
 /*
  * Relocation overview
@@ -3905,6 +3906,150 @@ static const char *stage_to_string(enum reloc_sta=
ge stage)
 	return "unknown";
 }
=20
+static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *tr=
ans,
+					   struct btrfs_block_group *bg,
+					   s64 diff)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	bool bg_already_dirty =3D true;
+
+	bg->remap_bytes +=3D diff;
+
+	if (bg->used =3D=3D 0 && bg->remap_bytes =3D=3D 0)
+		btrfs_mark_bg_unused(bg);
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
+		bg_already_dirty =3D false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
+}
+
+static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
+				struct btrfs_chunk_map *chunk,
+				struct btrfs_path *path)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_chunk *c;
+	int ret;
+
+	key.objectid =3D BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type =3D BTRFS_CHUNK_ITEM_KEY;
+	key.offset =3D chunk->start;
+
+	ret =3D btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
+				0, 1);
+	if (ret) {
+		if (ret =3D=3D 1) {
+			btrfs_release_path(path);
+			ret =3D -ENOENT;
+		}
+		return ret;
+	}
+
+	leaf =3D path->nodes[0];
+
+	c =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
+	btrfs_set_chunk_num_stripes(leaf, c, 0);
+
+	btrfs_truncate_item(trans, path, offsetof(struct btrfs_chunk, stripe),
+			    1);
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	btrfs_release_path(path);
+
+	chunk->num_stripes =3D 0;
+
+	return 0;
+}
+
+static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
+				    struct btrfs_chunk_map *chunk,
+				    struct btrfs_block_group *bg,
+				    struct btrfs_path *path)
+{
+	int ret;
+
+	ret =3D btrfs_remove_dev_extents(trans, chunk);
+	if (ret)
+		return ret;
+
+	mutex_lock(&trans->fs_info->chunk_mutex);
+
+	for (unsigned int i =3D 0; i < chunk->num_stripes; i++) {
+		ret =3D btrfs_update_device(trans, chunk->stripes[i].dev);
+		if (ret) {
+			mutex_unlock(&trans->fs_info->chunk_mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&trans->fs_info->chunk_mutex);
+
+	write_lock(&trans->fs_info->mapping_tree_lock);
+	btrfs_chunk_map_device_clear_bits(chunk, CHUNK_ALLOCATED);
+	write_unlock(&trans->fs_info->mapping_tree_lock);
+
+	btrfs_remove_bg_from_sinfo(bg);
+
+	ret =3D remove_chunk_stripes(trans, chunk, path);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
+				       struct btrfs_path *path,
+				       struct btrfs_block_group *bg, int delta)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_chunk_map *chunk;
+	bool bg_already_dirty =3D true;
+	int ret;
+
+	WARN_ON(delta < 0 && -delta > bg->identity_remap_count);
+
+	bg->identity_remap_count +=3D delta;
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
+		bg_already_dirty =3D false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
+
+	if (bg->identity_remap_count !=3D 0)
+		return 0;
+
+	chunk =3D btrfs_find_chunk_map(fs_info, bg->start, 1);
+	if (!chunk)
+		return -ENOENT;
+
+	ret =3D last_identity_remap_gone(trans, chunk, bg, path);
+	if (ret)
+		goto end;
+
+	ret =3D 0;
+end:
+	btrfs_free_chunk_map(chunk);
+	return ret;
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length, bool nolock)
 {
@@ -4521,3 +4666,363 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_=
fs_info *fs_info)
 		logical =3D fs_info->reloc_ctl->block_group->start;
 	return logical;
 }
+
+static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans=
,
+					struct btrfs_path *path,
+					struct btrfs_block_group *bg,
+					u64 bytenr, u64 num_bytes)
+{
+	int ret;
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct extent_buffer *leaf =3D path->nodes[0];
+	struct btrfs_key key, new_key;
+	struct btrfs_remap *remap_ptr =3D NULL, remap;
+	struct btrfs_block_group *dest_bg =3D NULL;
+	u64 end, new_addr =3D 0, remap_start, remap_length, overlap_length;
+	bool is_identity_remap;
+
+	end =3D bytenr + num_bytes;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+	is_identity_remap =3D key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY;
+
+	remap_start =3D key.objectid;
+	remap_length =3D key.offset;
+
+	if (!is_identity_remap) {
+		remap_ptr =3D btrfs_item_ptr(leaf, path->slots[0],
+					   struct btrfs_remap);
+		new_addr =3D btrfs_remap_address(leaf, remap_ptr);
+
+		dest_bg =3D btrfs_lookup_block_group(fs_info, new_addr);
+	}
+
+	if (bytenr =3D=3D remap_start && num_bytes >=3D remap_length) {
+		/* Remove entirely. */
+
+		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret)
+			goto end;
+
+		btrfs_release_path(path);
+
+		overlap_length =3D remap_length;
+
+		if (!is_identity_remap) {
+			/* Remove backref. */
+
+			key.objectid =3D new_addr;
+			key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			key.offset =3D remap_length;
+
+			ret =3D btrfs_search_slot(trans, fs_info->remap_root,
+						&key, path, -1, 1);
+			if (ret) {
+				if (ret =3D=3D 1) {
+					btrfs_release_path(path);
+					ret =3D -ENOENT;
+				}
+				goto end;
+			}
+
+			ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+
+			btrfs_release_path(path);
+
+			if (ret)
+				goto end;
+
+			adjust_block_group_remap_bytes(trans, dest_bg,
+						       -remap_length);
+		} else {
+			ret =3D adjust_identity_remap_count(trans, path, bg, -1);
+			if (ret)
+				goto end;
+		}
+	} else if (bytenr =3D=3D remap_start) {
+		/* Remove beginning. */
+
+		new_key.objectid =3D end;
+		new_key.type =3D key.type;
+		new_key.offset =3D remap_length + remap_start - end;
+
+		btrfs_set_item_key_safe(trans, path, &new_key);
+		btrfs_mark_buffer_dirty(trans, leaf);
+
+		overlap_length =3D num_bytes;
+
+		if (!is_identity_remap) {
+			btrfs_set_remap_address(leaf, remap_ptr,
+						new_addr + end - remap_start);
+			btrfs_release_path(path);
+
+			/* Adjust backref. */
+
+			key.objectid =3D new_addr;
+			key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			key.offset =3D remap_length;
+
+			ret =3D btrfs_search_slot(trans, fs_info->remap_root,
+						&key, path, -1, 1);
+			if (ret) {
+				if (ret =3D=3D 1) {
+					btrfs_release_path(path);
+					ret =3D -ENOENT;
+				}
+				goto end;
+			}
+
+			leaf =3D path->nodes[0];
+
+			new_key.objectid =3D new_addr + end - remap_start;
+			new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			new_key.offset =3D remap_length + remap_start - end;
+
+			btrfs_set_item_key_safe(trans, path, &new_key);
+
+			remap_ptr =3D btrfs_item_ptr(leaf, path->slots[0],
+						   struct btrfs_remap);
+			btrfs_set_remap_address(leaf, remap_ptr, end);
+
+			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
+
+			btrfs_release_path(path);
+
+			adjust_block_group_remap_bytes(trans, dest_bg,
+						       -num_bytes);
+		}
+	} else if (bytenr + num_bytes < remap_start + remap_length) {
+		/* Remove middle. */
+
+		new_key.objectid =3D remap_start;
+		new_key.type =3D key.type;
+		new_key.offset =3D bytenr - remap_start;
+
+		btrfs_set_item_key_safe(trans, path, &new_key);
+		btrfs_mark_buffer_dirty(trans, leaf);
+
+		new_key.objectid =3D end;
+		new_key.offset =3D remap_start + remap_length - end;
+
+		btrfs_release_path(path);
+
+		overlap_length =3D num_bytes;
+
+		if (!is_identity_remap) {
+			/* Add second remap entry. */
+
+			ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+						path, &new_key,
+						sizeof(struct btrfs_remap));
+			if (ret)
+				goto end;
+
+			btrfs_set_stack_remap_address(&remap,
+						new_addr + end - remap_start);
+
+			write_extent_buffer(path->nodes[0], &remap,
+				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+				sizeof(struct btrfs_remap));
+
+			btrfs_release_path(path);
+
+			/* Shorten backref entry. */
+
+			key.objectid =3D new_addr;
+			key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			key.offset =3D remap_length;
+
+			ret =3D btrfs_search_slot(trans, fs_info->remap_root,
+						&key, path, -1, 1);
+			if (ret) {
+				if (ret =3D=3D 1) {
+					btrfs_release_path(path);
+					ret =3D -ENOENT;
+				}
+				goto end;
+			}
+
+			new_key.objectid =3D new_addr;
+			new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			new_key.offset =3D bytenr - remap_start;
+
+			btrfs_set_item_key_safe(trans, path, &new_key);
+			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
+
+			btrfs_release_path(path);
+
+			/* Add second backref entry. */
+
+			new_key.objectid =3D new_addr + end - remap_start;
+			new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			new_key.offset =3D remap_start + remap_length - end;
+
+			ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+						path, &new_key,
+						sizeof(struct btrfs_remap));
+			if (ret)
+				goto end;
+
+			btrfs_set_stack_remap_address(&remap, end);
+
+			write_extent_buffer(path->nodes[0], &remap,
+				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+				sizeof(struct btrfs_remap));
+
+			btrfs_release_path(path);
+
+			adjust_block_group_remap_bytes(trans, dest_bg,
+						       -num_bytes);
+		} else {
+			/* Add second identity remap entry. */
+
+			ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+						      path, &new_key, 0);
+			if (ret)
+				goto end;
+
+			btrfs_release_path(path);
+
+			ret =3D adjust_identity_remap_count(trans, path, bg, 1);
+			if (ret)
+				goto end;
+		}
+	} else {
+		/* Remove end. */
+
+		new_key.objectid =3D remap_start;
+		new_key.type =3D key.type;
+		new_key.offset =3D bytenr - remap_start;
+
+		btrfs_set_item_key_safe(trans, path, &new_key);
+		btrfs_mark_buffer_dirty(trans, leaf);
+
+		btrfs_release_path(path);
+
+		overlap_length =3D remap_start + remap_length - bytenr;
+
+		if (!is_identity_remap) {
+			/* Shorten backref entry. */
+
+			key.objectid =3D new_addr;
+			key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			key.offset =3D remap_length;
+
+			ret =3D btrfs_search_slot(trans, fs_info->remap_root,
+						&key, path, -1, 1);
+			if (ret) {
+				if (ret =3D=3D 1) {
+					btrfs_release_path(path);
+					ret =3D -ENOENT;
+				}
+				goto end;
+			}
+
+			new_key.objectid =3D new_addr;
+			new_key.type =3D BTRFS_REMAP_BACKREF_KEY;
+			new_key.offset =3D bytenr - remap_start;
+
+			btrfs_set_item_key_safe(trans, path, &new_key);
+			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
+
+			btrfs_release_path(path);
+
+			adjust_block_group_remap_bytes(trans, dest_bg,
+					bytenr - remap_start - remap_length);
+		}
+	}
+
+	if (!is_identity_remap) {
+		ret =3D add_to_free_space_tree(trans,
+					     bytenr - remap_start + new_addr,
+					     overlap_length);
+		if (ret)
+			goto end;
+	}
+
+	ret =3D overlap_length;
+
+end:
+	if (dest_bg)
+		btrfs_put_block_group(dest_bg);
+
+	return ret;
+}
+
+int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans=
,
+					struct btrfs_path *path,
+					u64 bytenr, u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group *bg;
+	int ret;
+
+	if (!(btrfs_super_incompat_flags(fs_info->super_copy) &
+	      BTRFS_FEATURE_INCOMPAT_REMAP_TREE))
+		return 0;
+
+	bg =3D btrfs_lookup_block_group(fs_info, bytenr);
+	if (!bg)
+		return 0;
+
+	if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+		btrfs_put_block_group(bg);
+		return 0;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	do {
+		key.objectid =3D bytenr;
+		key.type =3D (u8)-1;
+		key.offset =3D (u64)-1;
+
+		ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key, path,
+					-1, 1);
+		if (ret < 0)
+			goto end;
+
+		leaf =3D path->nodes[0];
+
+		if (path->slots[0] =3D=3D 0) {
+			ret =3D -ENOENT;
+			goto end;
+		}
+
+		path->slots[0]--;
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.type !=3D BTRFS_IDENTITY_REMAP_KEY &&
+		    found_key.type !=3D BTRFS_REMAP_KEY) {
+			ret =3D -ENOENT;
+			goto end;
+		}
+
+		if (bytenr < found_key.objectid ||
+		    bytenr >=3D found_key.objectid + found_key.offset) {
+			ret =3D -ENOENT;
+			goto end;
+		}
+
+		ret =3D remove_range_from_remap_tree(trans, path, bg, bytenr,
+						   num_bytes);
+		if (ret < 0)
+			goto end;
+
+		bytenr +=3D ret;
+		num_bytes -=3D ret;
+	} while (num_bytes > 0);
+
+	ret =3D 0;
+
+end:
+	mutex_unlock(&fs_info->remap_mutex);
+
+	btrfs_put_block_group(bg);
+	btrfs_release_path(path);
+	return ret;
+}
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 8c9dfc55b799..0021f812b12c 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -32,5 +32,8 @@ bool btrfs_should_ignore_reloc_root(const struct btrfs_=
root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length, bool nolock);
+int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans=
,
+					struct btrfs_path *path,
+					u64 bytenr, u64 num_bytes);
=20
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 62bd6259ebd3..6c0a67da92f1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2931,8 +2931,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_=
info, const char *device_path
 	return ret;
 }
=20
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans=
,
-					struct btrfs_device *device)
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device)
 {
 	int ret;
 	struct btrfs_path *path;
@@ -3236,25 +3236,13 @@ static int remove_chunk_item(struct btrfs_trans_h=
andle *trans,
 	return btrfs_free_chunk(trans, chunk_offset);
 }
=20
-int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offse=
t)
+int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
+			     struct btrfs_chunk_map *map)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
-	struct btrfs_chunk_map *map;
+	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
 	u64 dev_extent_len =3D 0;
 	int i, ret =3D 0;
-	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
-
-	map =3D btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	if (IS_ERR(map)) {
-		/*
-		 * This is a logic error, but we don't want to just rely on the
-		 * user having built with ASSERT enabled, so if ASSERT doesn't
-		 * do anything we still error out.
-		 */
-		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
-			   PTR_ERR(map), chunk_offset);
-		return PTR_ERR(map);
-	}
=20
 	/*
 	 * First delete the device extent items from the devices btree.
@@ -3275,7 +3263,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *t=
rans, u64 chunk_offset)
 		if (ret) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
=20
 		if (device->bytes_used > 0) {
@@ -3295,6 +3283,30 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *=
trans, u64 chunk_offset)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
=20
+	return 0;
+}
+
+int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offse=
t)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_chunk_map *map;
+	int ret;
+
+	map =3D btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	if (IS_ERR(map)) {
+		/*
+		 * This is a logic error, but we don't want to just rely on the
+		 * user having built with ASSERT enabled, so if ASSERT doesn't
+		 * do anything we still error out.
+		 */
+		ASSERT(0);
+		return PTR_ERR(map);
+	}
+
+	ret =3D btrfs_remove_dev_extents(trans, map);
+	if (ret)
+		goto out;
+
 	/*
 	 * We acquire fs_info->chunk_mutex for 2 reasons:
 	 *
@@ -5436,7 +5448,7 @@ static void chunk_map_device_set_bits(struct btrfs_=
chunk_map *map, unsigned int
 	}
 }
=20
-static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, uns=
igned int bits)
+void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsi=
gned int bits)
 {
 	for (int i =3D 0; i < map->num_stripes; i++) {
 		struct btrfs_io_stripe *stripe =3D &map->stripes[i];
@@ -5453,7 +5465,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *f=
s_info, struct btrfs_chunk_ma
 	write_lock(&fs_info->mapping_tree_lock);
 	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
 	RB_CLEAR_NODE(&map->rb_node);
-	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
 	write_unlock(&fs_info->mapping_tree_lock);
=20
 	/* Once for the tree reference. */
@@ -5489,7 +5501,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_in=
fo, struct btrfs_chunk_map *m
 		return -EEXIST;
 	}
 	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
-	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
+	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
 	write_unlock(&fs_info->mapping_tree_lock);
=20
 	return 0;
@@ -5854,7 +5866,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *=
fs_info)
 		map =3D rb_entry(node, struct btrfs_chunk_map, rb_node);
 		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
 		RB_CLEAR_NODE(&map->rb_node);
-		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
 		/* Once for the tree ref. */
 		btrfs_free_chunk_map(map);
 		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9fb8fe4312a5..0a73ea2a2a6a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -779,6 +779,8 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk=
_map *map);
 int btrfs_nr_parity_stripes(u64 type);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
+int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
+			     struct btrfs_chunk_map *map);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offse=
t);
=20
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
@@ -876,6 +878,10 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_=
info, u64 logical);
=20
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
+void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map,
+				       unsigned int bits);
=20
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs=
_info,
--=20
2.49.0


