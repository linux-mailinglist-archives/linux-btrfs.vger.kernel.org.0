Return-Path: <linux-btrfs+bounces-6602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E293797C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB9285231
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB407142E85;
	Fri, 19 Jul 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hX1fcC2/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6510E6
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401443; cv=none; b=OD0bqLw9wjhP51bNf22DFQyBrJ2AKsowGANEdTHOWe/Pu3KO8w3Eq9Sqk1vpUv5RQ0VtNBYm/K9Ub3+r/kyqirWFmqpMJ6NilQyAPCCM6B1MsIiF1tco9tKeMXTq9g2BVqxmDAukJy0apE6455cQDwJq95HmOWxhfHSzBFF5XOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401443; c=relaxed/simple;
	bh=nLZPwxiAKqBXT2mYQWJXxetK/dRvVbN+K5E153fssm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fT0Gdv/DE0CcQUduzB5xQcUlCYIo13/lnAtOej+zo9Q9lRYEmSsw1tqetdmeDaFSUhmTdF7pvVO82+MKgJqZsOjjnGJpHVjnNV3Lh07mg1DG9lLLurCh5moN2B6qB4ocP8g83NbXX33Em2K2wA7ih8LaZAMLIKo3BlZarFTRIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=hX1fcC2/; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46JEbGge031681
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=FT4+WDT9
	CKfgnm40Uz15faSPCLMPlpc53zY75/0dMDc=; b=hX1fcC2/CnIGHWeDF6QYRLte
	FedPHxgqHpT4xbkPmZ6hFt7ul66mxxvAB5hzOnaAW15jBGBAF7FG89I+VuvJ9AQ3
	W8vGaysEYsKnPEqrt+KcxxDyndRgCM/d428HghggHkh/L/3HB/14UFo06opD8z91
	j0mZcbDtuxZUp2Y8TV8=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 40f1p0982w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:04:00 -0700 (PDT)
Received: from twshared25218.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 19 Jul 2024 15:03:55 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id CEA0047743C4; Fri, 19 Jul 2024 16:03:47 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 1/2] btrfs-progs: add set_uuid param to btrfs_make_subvolume
Date: Fri, 19 Jul 2024 16:03:23 +0100
Message-ID: <20240719150343.3992904-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tuA14qJ03Z4YgPsQ7hXcPQnngh0Xefzr
X-Proofpoint-GUID: tuA14qJ03Z4YgPsQ7hXcPQnngh0Xefzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01

Adds a set_uuid parameter to btrfs_make_subvolume, which generates a
uuid for the new root and adds it to the uuid tree.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 common/root-tree-utils.c | 72 +++++++++++++++++++++++++++++++++++++++-
 common/root-tree-utils.h |  5 ++-
 convert/main.c           |  5 +--
 mkfs/main.c              | 59 ++------------------------------
 4 files changed, 80 insertions(+), 61 deletions(-)

diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
index 6a57c51a..f9343304 100644
--- a/common/root-tree-utils.c
+++ b/common/root-tree-utils.c
@@ -15,6 +15,7 @@
  */
=20
 #include <time.h>
+#include <uuid/uuid.h>
 #include "common/root-tree-utils.h"
 #include "common/messages.h"
 #include "kernel-shared/disk-io.h"
@@ -58,13 +59,70 @@ error:
 	return ret;
 }
=20
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 t=
ype,
+			u64 subvol_id_cpu)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
+	int ret;
+	struct btrfs_path *path =3D NULL;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	int slot;
+	unsigned long offset;
+	__le64 subvol_id_le;
+
+	btrfs_uuid_to_key(uuid, type, &key);
+
+	path =3D btrfs_alloc_path();
+	if (!path) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	ret =3D btrfs_insert_empty_item(trans, uuid_root, path, &key, sizeof(su=
bvol_id_le));
+	if (ret < 0 && ret !=3D -EEXIST) {
+		warning(
+		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
+			key.objectid, key.offset, type, ret);
+		goto out;
+	}
+
+	if (ret >=3D 0) {
+		/* Add an item for the type for the first time. */
+		eb =3D path->nodes[0];
+		slot =3D path->slots[0];
+		offset =3D btrfs_item_ptr_offset(eb, slot);
+	} else {
+		/*
+		 * ret =3D=3D -EEXIST case, an item with that type already exists.
+		 * Extend the item and store the new subvol_id at the end.
+		 */
+		btrfs_extend_item(path, sizeof(subvol_id_le));
+		eb =3D path->nodes[0];
+		slot =3D path->slots[0];
+		offset =3D btrfs_item_ptr_offset(eb, slot);
+		offset +=3D btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
+	}
+
+	ret =3D 0;
+	subvol_id_le =3D cpu_to_le64(subvol_id_cpu);
+	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
+	btrfs_mark_buffer_dirty(eb);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 /*
  * Create a subvolume and initialize its content with the top inode.
  *
  * The created tree root would have its root_ref as 1.
  * Thus for subvolumes caller needs to properly add ROOT_BACKREF items.
  */
-int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid)
+int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid,
+			 bool set_uuid)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
 	struct btrfs_root *root;
@@ -96,6 +154,18 @@ int btrfs_make_subvolume(struct btrfs_trans_handle *t=
rans, u64 objectid)
 	ret =3D btrfs_make_root_dir(trans, root, BTRFS_FIRST_FREE_OBJECTID);
 	if (ret < 0)
 		goto error;
+
+	if (set_uuid) {
+		uuid_generate(root->root_item.uuid);
+
+		ret =3D btrfs_uuid_tree_add(trans, root->root_item.uuid,
+					  BTRFS_UUID_KEY_SUBVOL, objectid);
+		if (ret < 0) {
+			error("failed to add uuid entry");
+			goto error;
+		}
+	}
+
 	ret =3D btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
 				&root->root_item);
 	if (ret < 0)
diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
index 0c4ece24..78731dd5 100644
--- a/common/root-tree-utils.h
+++ b/common/root-tree-utils.h
@@ -21,10 +21,13 @@
=20
 int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, u64 objectid);
-int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid)=
;
+int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid,
+			 bool set_uuid);
 int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
 			 struct btrfs_root *parent_root,
 			 u64 parent_dir, const char *name,
 			 int namelen, struct btrfs_root *subvol);
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 t=
ype,
+			u64 subvol_id_cpu);
=20
 #endif
diff --git a/convert/main.c b/convert/main.c
index 078ef64e..c863ce91 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1022,13 +1022,14 @@ static int init_btrfs(struct btrfs_mkfs_config *c=
fg, struct btrfs_root *root,
 			     BTRFS_FIRST_FREE_OBJECTID);
=20
 	/* subvol for fs image file */
-	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID);
+	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, false);
 	if (ret < 0) {
 		error("failed to create subvolume image root: %d", ret);
 		goto err;
 	}
 	/* subvol for data relocation tree */
-	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID,
+				   false);
 	if (ret < 0) {
 		error("failed to create DATA_RELOC root: %d", ret);
 		goto err;
diff --git a/mkfs/main.c b/mkfs/main.c
index cf5cae45..0bdb414a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -735,62 +735,6 @@ static void update_chunk_allocation(struct btrfs_fs_=
info *fs_info,
 	}
 }
=20
-static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uui=
d,
-			       u8 type, u64 subvol_id_cpu)
-{
-	struct btrfs_fs_info *fs_info =3D trans->fs_info;
-	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
-	int ret;
-	struct btrfs_path *path =3D NULL;
-	struct btrfs_key key;
-	struct extent_buffer *eb;
-	int slot;
-	unsigned long offset;
-	__le64 subvol_id_le;
-
-	btrfs_uuid_to_key(uuid, type, &key);
-
-	path =3D btrfs_alloc_path();
-	if (!path) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-
-	ret =3D btrfs_insert_empty_item(trans, uuid_root, path, &key, sizeof(su=
bvol_id_le));
-	if (ret < 0 && ret !=3D -EEXIST) {
-		warning(
-		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
-			key.objectid, key.offset, type, ret);
-		goto out;
-	}
-
-	if (ret >=3D 0) {
-		/* Add an item for the type for the first time. */
-		eb =3D path->nodes[0];
-		slot =3D path->slots[0];
-		offset =3D btrfs_item_ptr_offset(eb, slot);
-	} else {
-		/*
-		 * ret =3D=3D -EEXIST case, an item with that type already exists.
-		 * Extend the item and store the new subvol_id at the end.
-		 */
-		btrfs_extend_item(path, sizeof(subvol_id_le));
-		eb =3D path->nodes[0];
-		slot =3D path->slots[0];
-		offset =3D btrfs_item_ptr_offset(eb, slot);
-		offset +=3D btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
-	}
-
-	ret =3D 0;
-	subvol_id_le =3D cpu_to_le64(subvol_id_cpu);
-	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
-	btrfs_mark_buffer_dirty(eb);
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
 static int create_uuid_tree(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info =3D trans->fs_info;
@@ -1871,7 +1815,8 @@ raid_groups:
 		goto out;
 	}
=20
-	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID,
+				   false);
 	if (ret) {
 		error("unable to create data reloc tree: %d", ret);
 		goto out;
--=20
2.44.2


