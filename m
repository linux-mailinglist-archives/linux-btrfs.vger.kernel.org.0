Return-Path: <linux-btrfs+bounces-6603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08793797D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CECE1C20B68
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5B144D24;
	Fri, 19 Jul 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BJFs2BUU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394710E6
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401447; cv=none; b=Q76R8Gxb7fWMi43dFaBJX2DTy3FXeLtbvW4sghSv8LZ1wWllsFIjwu6qPecQCMW3zzp0IUR3nyzwyIKnUIxkZbDWZd4qS0wwqu9gN073RN3mV07eidiuutKYg0boTLQPhKJ1ooKykUF9DgQ6Rp9cPeLkVfpTWDGnt1Cag7+LqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401447; c=relaxed/simple;
	bh=HOBrQ6oaR5l4ecQ7Faz4LsVH+IrzgdaENIJCm4ZE5+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL/xKiMW7qkK5LZWKJZ9yjjyMw8hQfxT0WVbRCrKVEIfUXd/Tzy0fFLjUxdGFg1FqgF/c5LvIETXw4PQcVpFjeqZYMrgYecklGZVrKAhQ33WqLkELzPiPUupx8mtRpTMcz2AofGJIIvtQSXTRNh5tRb2slFhJleZResM8F8w1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=BJFs2BUU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JExoRU017409
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:04:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=mDcmLVcomsKFGE708buhMKvhI4TnpHk0FFNCI5JA7TY=; b=BJF
	s2BUUEE1J87+eY4nP26OwukP5Xm/pDNtQYGSK5MBx8vkZ0HjZCKr4ft/OyYLlF+u
	+uhfeTOHIHCoGC3Vm4tbCxa7SbMgysbMzxsnipxHw8twmut07KtO5qfLn2f1wb0A
	RpTiDn6ninr7w5Xlo5QdAVMu9T4bOURFLhTUsPXA=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40f1qq16h5-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:04:04 -0700 (PDT)
Received: from twshared3252.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 19 Jul 2024 15:03:59 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id E91FD47743F0; Fri, 19 Jul 2024 16:03:50 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 2/2] btrfs-progs: set subvol uuids when converting
Date: Fri, 19 Jul 2024 16:03:24 +0100
Message-ID: <20240719150343.3992904-2-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719150343.3992904-1-maharmstone@fb.com>
References: <20240719150343.3992904-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mbwbsuRXfNtKovUz2lT0EQvG8G7mWXeN
X-Proofpoint-ORIG-GUID: mbwbsuRXfNtKovUz2lT0EQvG8G7mWXeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01

Currently when using btrfs-convert, neither the main subvolume nor the
image subvolume get uuids assigned, nor is the uuid tree created.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 common/root-tree-utils.c | 29 +++++++++++++++++++++++++++++
 common/root-tree-utils.h |  1 +
 convert/common.c         | 14 +++++++++-----
 convert/main.c           |  8 +++++++-
 mkfs/main.c              | 29 -----------------------------
 5 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
index f9343304..9495178c 100644
--- a/common/root-tree-utils.c
+++ b/common/root-tree-utils.c
@@ -59,6 +59,35 @@ error:
 	return ret;
 }
=20
+int create_uuid_tree(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_root *root;
+	struct btrfs_key key =3D {
+		.objectid =3D BTRFS_UUID_TREE_OBJECTID,
+		.type =3D BTRFS_ROOT_ITEM_KEY,
+	};
+	int ret =3D 0;
+
+	UASSERT(fs_info->uuid_root =3D=3D NULL);
+	root =3D btrfs_create_tree(trans, &key);
+	if (IS_ERR(root)) {
+		ret =3D PTR_ERR(root);
+		goto out;
+	}
+
+	add_root_to_dirty_list(root);
+	fs_info->uuid_root =3D root;
+	ret =3D btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
+				  BTRFS_UUID_KEY_SUBVOL,
+				  fs_info->fs_root->root_key.objectid);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+
+out:
+	return ret;
+}
+
 int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 t=
ype,
 			u64 subvol_id_cpu)
 {
diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
index 78731dd5..aec1849b 100644
--- a/common/root-tree-utils.h
+++ b/common/root-tree-utils.h
@@ -29,5 +29,6 @@ int btrfs_link_subvolume(struct btrfs_trans_handle *tra=
ns,
 			 int namelen, struct btrfs_root *subvol);
 int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 t=
ype,
 			u64 subvol_id_cpu);
+int create_uuid_tree(struct btrfs_trans_handle *trans);
=20
 #endif
diff --git a/convert/common.c b/convert/common.c
index b093fdb5..667f38a4 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -190,7 +190,7 @@ static int setup_temp_extent_buffer(struct extent_buf=
fer *buf,
 static void insert_temp_root_item(struct extent_buffer *buf,
 				  struct btrfs_mkfs_config *cfg,
 				  int *slot, u32 *itemoff, u64 objectid,
-				  u64 bytenr)
+				  u64 bytenr, bool set_uuid)
 {
 	struct btrfs_root_item root_item;
 	struct btrfs_inode_item *inode_item;
@@ -210,6 +210,9 @@ static void insert_temp_root_item(struct extent_buffe=
r *buf,
 	btrfs_set_root_generation(&root_item, 1);
 	btrfs_set_root_bytenr(&root_item, bytenr);
=20
+	if (set_uuid)
+		uuid_generate(root_item.uuid);
+
 	memset(&disk_key, 0, sizeof(disk_key));
 	btrfs_set_disk_key_type(&disk_key, BTRFS_ROOT_ITEM_KEY);
 	btrfs_set_disk_key_objectid(&disk_key, objectid);
@@ -281,13 +284,14 @@ static int setup_temp_root_tree(int fd, struct btrf=
s_mkfs_config *cfg,
 		goto out;
=20
 	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr);
+			      BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr,
+			      false);
 	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_DEV_TREE_OBJECTID, dev_bytenr);
+			      BTRFS_DEV_TREE_OBJECTID, dev_bytenr, false);
 	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_FS_TREE_OBJECTID, fs_bytenr);
+			      BTRFS_FS_TREE_OBJECTID, fs_bytenr, true);
 	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_CSUM_TREE_OBJECTID, csum_bytenr);
+			      BTRFS_CSUM_TREE_OBJECTID, csum_bytenr, false);
=20
 	ret =3D write_temp_extent_buffer(fd, buf, root_bytenr, cfg);
 out:
diff --git a/convert/main.c b/convert/main.c
index c863ce91..8cfd9407 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1021,8 +1021,14 @@ static int init_btrfs(struct btrfs_mkfs_config *cf=
g, struct btrfs_root *root,
 	btrfs_set_root_dirid(&fs_info->fs_root->root_item,
 			     BTRFS_FIRST_FREE_OBJECTID);
=20
+	ret =3D create_uuid_tree(trans);
+	if (ret) {
+		error("failed to create uuid tree: %d", ret);
+		goto err;
+	}
+
 	/* subvol for fs image file */
-	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, false);
+	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, true);
 	if (ret < 0) {
 		error("failed to create subvolume image root: %d", ret);
 		goto err;
diff --git a/mkfs/main.c b/mkfs/main.c
index 0bdb414a..a69aa24b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -735,35 +735,6 @@ static void update_chunk_allocation(struct btrfs_fs_=
info *fs_info,
 	}
 }
=20
-static int create_uuid_tree(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info =3D trans->fs_info;
-	struct btrfs_root *root;
-	struct btrfs_key key =3D {
-		.objectid =3D BTRFS_UUID_TREE_OBJECTID,
-		.type =3D BTRFS_ROOT_ITEM_KEY,
-	};
-	int ret =3D 0;
-
-	UASSERT(fs_info->uuid_root =3D=3D NULL);
-	root =3D btrfs_create_tree(trans, &key);
-	if (IS_ERR(root)) {
-		ret =3D PTR_ERR(root);
-		goto out;
-	}
-
-	add_root_to_dirty_list(root);
-	fs_info->uuid_root =3D root;
-	ret =3D btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
-				  BTRFS_UUID_KEY_SUBVOL,
-				  fs_info->fs_root->root_key.objectid);
-	if (ret < 0)
-		btrfs_abort_transaction(trans, ret);
-
-out:
-	return ret;
-}
-
 static int create_global_root(struct btrfs_trans_handle *trans, u64 obje=
ctid,
 			      int root_id)
 {
--=20
2.44.2


