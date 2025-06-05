Return-Path: <linux-btrfs+bounces-14487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1AACF42D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9215B1891D54
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA8274FCF;
	Thu,  5 Jun 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mIjOAcCM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734827465B
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140638; cv=none; b=CNqGiQkjIQdegZt+nrPP9cSZjP7+G+qVC3FtIh8O2cq7G5seLi33Aq5GNe6F3j72Gsssaqpcd1ZEnSyHXGI7Xb55H6QhVWoyTGbS7+raYKvBpInb4uovTaPtk4SNYaCAyp126NDwUCWGWnHwdHfcrnE3atOe4G6KdbR6A5c7x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140638; c=relaxed/simple;
	bh=rtST8R0G5Q7/xDkaEQIBkp/9KG0ffaPRA/t7eC+igiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPoKa+gVyp4IBnq8rsysZVNGElRGMjmszbRv1LNBI1Xk6iar1gYHWwuDb4Z/wlQ0jB7PpTS/SpKUHEUo8BvuTxOAiU0zPHJZFojS51Jgn+7Vp3mWcgS6l0M0IB0rqSBupN04bhiLUeY86ZtJ+bLu5UO9ft3tSqlh/x/+CUuo3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=mIjOAcCM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bU027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=U
	0qaLkRFeWcD9RtpE/jzl3q93HmlUIxqBtRF4NT8cyM=; b=mIjOAcCMAW68yX+/e
	DN/0G+ovtBLW6NBuyZb5GcC+WQVVOS6bEPtKG0ySeJQrCklqYWmKUWvK9lNCg8L0
	ihPtQsQFUA4l0IbETh0N1zM4DOcXgY1bSBdjyQV3R1kQQQ32EDYGYiYyXG6nsbbU
	0VKNn+/05acJsW7pWc0DYpLpR0=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:55 -0700 (PDT)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:54 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 5D946FEC2E6C; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 07/12] btrfs: allow mounting filesystems with remap-tree incompat flag
Date: Thu, 5 Jun 2025 17:23:37 +0100
Message-ID: <20250605162345.2561026-8-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=wSlndb3i9brWwW7qcZoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX5m4LE+NtyesX 65KPXdBRbh/RN5WaONfyigpwxSaOqm37YfTv3tf3Lt48OQB5jN0jRhEM0UX+MTHenUnp8Pe9MgF kxtyNIheI+o3dSohuSkVYWY+3rhAdHROceNV6p8le3SRf4cmcqLNvHkJBfWZ85pUNC+bSkcJYAE
 SGZ5VnzmG+RiW4ceR/Iv2la/AxG3pnY1w+Uo8Yo2gesAJTSRc83j5uviHHSaJiHK+IponeOD75T /GJm5UgXAGi1j9nCnwWybGSblB7pMfYVvIUWIRX7uZizUsOdSo3e77Yi3WwFrOq7G4fjwzWfrvz 2E7E6QAF1adEcTult9iC1FTxfUGZJi6xZA20LkhpYGN6Snzy2mgnb9H8AbNElJ+roqqkk59Lx4G
 X3dxewTl7EzEpOVGNpBfhCR532ZsNLv0cituBGd4PtN6xJs9qSYhp361+p/E6KgRUFd6l/0J
X-Proofpoint-GUID: Vyua4LgNiO-t9uiBqPUnRfdAcyXbrzhG
X-Proofpoint-ORIG-GUID: Vyua4LgNiO-t9uiBqPUnRfdAcyXbrzhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

If we encounter a filesystem with the remap-tree incompat flag set,
valdiate its compatibility with the other flags, and load the remap tree
using the values that have been added to the superblock.

The remap-tree feature depends on the free space tere, but no-holes and
block-group-tree have been made dependencies to reduce the testing
matrix. Similarly I'm not aware of any reason why mixed-bg and zoned woul=
d be
incompatible with remap-tree, but this is blocked for the time being
until it can be fully tested.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/Kconfig                |  2 ++
 fs/btrfs/accessors.h            |  6 ++++
 fs/btrfs/disk-io.c              | 60 +++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.c          |  2 ++
 fs/btrfs/fs.h                   |  4 ++-
 fs/btrfs/transaction.c          |  7 ++++
 include/uapi/linux/btrfs_tree.h |  5 ++-
 7 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index c352f3ae0385..f41446102b14 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -114,6 +114,8 @@ config BTRFS_EXPERIMENTAL
=20
 	  - extent tree v2 - complex rework of extent tracking
=20
+	  - remap-tree - logical address remapping tree
+
 	  If unsure, say N.
=20
 config BTRFS_FS_REF_VERIFY
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 6e6dd664217b..1bb6c0439ba7 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -919,6 +919,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation,=
 struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block=
,
 			 nr_global_roots, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root, struct btrfs_super_block,
+			 remap_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root_generation, struct btrfs_super=
_block,
+			 remap_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_remap_root_level, struct btrfs_super_bloc=
k,
+			 remap_root_level, 8);
=20
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_exten=
t_item,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 324116c3566c..a0542b581f4e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1176,6 +1176,8 @@ static struct btrfs_root *btrfs_get_global_root(str=
uct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
 	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		return btrfs_grab_root(fs_info->stripe_root);
+	case BTRFS_REMAP_TREE_OBJECTID:
+		return btrfs_grab_root(fs_info->remap_root);
 	default:
 		return NULL;
 	}
@@ -1264,6 +1266,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
 	btrfs_put_root(fs_info->stripe_root);
+	btrfs_put_root(fs_info->remap_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1818,6 +1821,7 @@ static void free_root_pointers(struct btrfs_fs_info=
 *info, bool free_chunk_root)
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
 	free_root_extent_buffers(info->stripe_root);
+	free_root_extent_buffers(info->remap_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2255,6 +2259,17 @@ static int btrfs_read_roots(struct btrfs_fs_info *=
fs_info)
 	if (ret)
 		goto out;
=20
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		/* remap_root already loaded in load_important_roots() */
+		root =3D fs_info->remap_root;
+
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+
+		root->root_key.objectid =3D BTRFS_REMAP_TREE_OBJECTID;
+		root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
+		root->root_key.offset =3D 0;
+	}
+
 	/*
 	 * This tree can share blocks with some other fs tree during relocation
 	 * and we need a proper setup by btrfs_get_fs_root
@@ -2522,6 +2537,28 @@ int btrfs_validate_super(const struct btrfs_fs_inf=
o *fs_info,
 		ret =3D -EINVAL;
 	}
=20
+	/* Ditto for remap_tree */
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+	     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
+	     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
+		btrfs_err(fs_info,
+"remap-tree feature requires free-space-tree, no-holes, and block-group-=
tree");
+		ret =3D -EINVAL;
+	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
+		ret =3D -EINVAL;
+	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+	    btrfs_fs_incompat(fs_info, ZONED)) {
+		btrfs_err(fs_info, "remap-tree not supported with zoned devices");
+		ret =3D -EINVAL;
+	}
+
 	/*
 	 * Hint to catch really bogus numbers, bitflips or so, more exact check=
s are
 	 * done later
@@ -2680,6 +2717,18 @@ static int load_important_roots(struct btrfs_fs_in=
fo *fs_info)
 		btrfs_warn(fs_info, "couldn't read tree root");
 		return ret;
 	}
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		bytenr =3D btrfs_super_remap_root(sb);
+		gen =3D btrfs_super_remap_root_generation(sb);
+		level =3D btrfs_super_remap_root_level(sb);
+		ret =3D load_super_root(fs_info->remap_root, bytenr, gen, level);
+		if (ret) {
+			btrfs_warn(fs_info, "couldn't read remap root");
+			return ret;
+		}
+	}
+
 	return 0;
 }
=20
@@ -3293,6 +3342,7 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
 	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
+	struct btrfs_root *remap_root;
 	int ret;
 	int level;
=20
@@ -3327,6 +3377,16 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
=20
+	if (btrfs_super_incompat_flags(disk_super) & BTRFS_FEATURE_INCOMPAT_REM=
AP_TREE) {
+		remap_root =3D btrfs_alloc_root(fs_info, BTRFS_REMAP_TREE_OBJECTID,
+					      GFP_KERNEL);
+		fs_info->remap_root =3D remap_root;
+		if (!remap_root) {
+			ret =3D -ENOMEM;
+			goto fail_alloc;
+		}
+	}
+
 	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 205692fc1c7e..e8f752ef1da9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2564,6 +2564,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_r=
oot *root, int data)
 		flags =3D BTRFS_BLOCK_GROUP_DATA;
 	else if (root =3D=3D fs_info->chunk_root)
 		flags =3D BTRFS_BLOCK_GROUP_SYSTEM;
+	else if (root =3D=3D fs_info->remap_root)
+		flags =3D BTRFS_BLOCK_GROUP_REMAP;
 	else
 		flags =3D BTRFS_BLOCK_GROUP_METADATA;
=20
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 07ac1a96477a..8ceeb64aceb3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -286,7 +286,8 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
 	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
=20
 #else
=20
@@ -442,6 +443,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
 	struct btrfs_root *stripe_root;
+	struct btrfs_root *remap_root;
=20
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 825d135ef6c7..045468fc807d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1951,6 +1951,13 @@ static void update_super_roots(struct btrfs_fs_inf=
o *fs_info)
 		super->cache_generation =3D 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation =3D root_item->generation;
+
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		root_item =3D &fs_info->remap_root->root_item;
+		super->remap_root =3D root_item->bytenr;
+		super->remap_root_generation =3D root_item->generation;
+		super->remap_root_level =3D root_item->level;
+	}
 }
=20
 int btrfs_transaction_blocked(struct btrfs_fs_info *info)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_t=
ree.h
index 500e3a7df90b..89bcb80081a6 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -721,9 +721,12 @@ struct btrfs_super_block {
 	__u8 metadata_uuid[BTRFS_FSID_SIZE];
=20
 	__u64 nr_global_roots;
+	__le64 remap_root;
+	__le64 remap_root_generation;
+	__u8 remap_root_level;
=20
 	/* Future expansion */
-	__le64 reserved[27];
+	__u8 reserved[199];
 	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
=20
--=20
2.49.0


