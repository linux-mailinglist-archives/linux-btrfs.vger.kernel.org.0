Return-Path: <linux-btrfs+bounces-6175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9472926620
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DD51F226DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979A1822FF;
	Wed,  3 Jul 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CCPHAiv6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A117C7C
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024183; cv=none; b=P3cpUOrTvR94VNFS8yKVDKmU+zt5ATZf27j62WdR+jNv1AO/qH7nbkPzkhwpUQEcmvhloQOc/YDA7HZNd/XDWqj2iLXz1mQtPAWlGkmVxxVLa39WABvGyXgWNBk311Ut4ye+wT4P5l8XgvSjyIoqTBsXOEh5/c18HySZEdK0+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024183; c=relaxed/simple;
	bh=UOuPIaGcl783iQt1vd2qGcWAHbRkjGJpG6xLED2WwtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJ2dDpkGKDhXUPMyBk1lYjWrzywAWg9auxQrSwscsmUu4i4Lnxh/YnnXg51EE/P+2o/pzqaGF11N6O5XHC5EcjNr+bEXcyIRkYtsN2lJni4nVB4Qc4H3g2Msylcu4+qcBeLHOwqOcFtugdYuAwcw3741z7zsrjzJNgm9XU+SBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=CCPHAiv6; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463EPjlL017448
	for <linux-btrfs@vger.kernel.org>; Wed, 3 Jul 2024 09:29:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=Yp5oqT7x
	MOxNeRDC1xfAp+GBihN6nhLIN16Jx8HhVcs=; b=CCPHAiv6uUtGwI7OXVyRx3VD
	GJLPC/WRvV0NfZoSsYptVHBOpMe5cjuvjbtqVMN+JQ/b1GW5ZlFGMBKw9moBxW1d
	0kUL6b3y2PSlzCDPtzWkxR/E+x/1J+EmfqN6bYDQH2jb7/MT9SPc/TlVXHJbjqtd
	1Y4o+N43d1heu/XsRvw=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4054gnj58j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 09:29:40 -0700 (PDT)
Received: from twshared7151.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 3 Jul 2024 16:29:39 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 3446D3E19F03; Wed,  3 Jul 2024 17:29:28 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH] btrfs-progs: add rudimentary log checking
Date: Wed, 3 Jul 2024 17:28:32 +0100
Message-ID: <20240703162925.493914-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: gI_B6autXxdf0NyOvpjIX7hkzslbXoXU
X-Proofpoint-ORIG-GUID: gI_B6autXxdf0NyOvpjIX7hkzslbXoXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01

From: Mark Harmstone <maharmstone@meta.com>

Currently the transaction log is more or less ignored by btrfs check,
meaning that it's possible for a FS with a corrupt log to pass btrfs
check, but be immediately corrupted by the kernel when it's mounted.

This patch adds a check that if there's an inode in the log, any pending
non-compressed writes also have corresponding csum entries.

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
---
 check/main.c | 293 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 281 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index 83c721d3..6f3fab35 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9787,6 +9787,263 @@ static int zero_log_tree(struct btrfs_root *root)
 	return ret;
 }
=20
+static int check_log_csum(struct btrfs_root *root, u64 addr, u64 length)
+{
+	struct btrfs_path path =3D { 0 };
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	u16 csum_size =3D gfs_info->csum_size;
+	u16 num_entries;
+	u64 data_len;
+	int ret;
+
+	key.objectid =3D BTRFS_EXTENT_CSUM_OBJECTID;
+	key.type =3D BTRFS_EXTENT_CSUM_KEY;
+	key.offset =3D addr;
+
+	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0 && path.slots[0])
+		path.slots[0]--;
+
+	ret =3D 0;
+
+	while (1) {
+		leaf =3D path.nodes[0];
+		if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(root, &path);
+			if (ret) {
+				if (ret > 0)
+					ret =3D 0;
+
+				break;
+			}
+			leaf =3D path.nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
+
+		if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
+			break;
+
+		if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID &&
+		    key.type =3D=3D BTRFS_EXTENT_CSUM_KEY) {
+			if (key.offset >=3D addr + length)
+				break;
+
+			num_entries =3D btrfs_item_size(leaf, path.slots[0]) / csum_size;
+			data_len =3D num_entries * gfs_info->sectorsize;
+
+			if (addr >=3D key.offset && addr + length <=3D key.offset + data_len)=
 {
+				u64 end =3D min(addr + length, key.offset + data_len);
+
+				length =3D addr + length - end;
+				addr =3D end;
+
+				if (length =3D=3D 0)
+					break;
+			}
+		}
+
+		path.slots[0]++;
+	}
+
+	btrfs_release_path(&path);
+
+	if (ret >=3D 0)
+		ret =3D length =3D=3D 0 ? 1 : 0;
+
+	return ret;
+}
+
+static int check_log_root(struct btrfs_root *root, struct cache_tree *ro=
ot_cache,
+			  struct walk_control *wc)
+{
+	struct btrfs_path path =3D { 0 };
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret, err =3D 0;
+	u64 last_csum_inode =3D 0;
+
+	key.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
+	key.type =3D BTRFS_INODE_ITEM_KEY;
+	key.offset =3D 0;
+	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return 1;
+
+	while (1) {
+		leaf =3D path.nodes[0];
+		if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(root, &path);
+			if (ret) {
+				if (ret < 0)
+					err =3D 1;
+
+				break;
+			}
+			leaf =3D path.nodes[0];
+		}
+		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
+
+		if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID)
+			break;
+
+		if (key.type =3D=3D BTRFS_INODE_ITEM_KEY) {
+			struct btrfs_inode_item *item;
+
+			item =3D btrfs_item_ptr(leaf, path.slots[0],
+					      struct btrfs_inode_item);
+
+			if (!(btrfs_inode_flags(leaf, item) & BTRFS_INODE_NODATASUM))
+				last_csum_inode =3D key.objectid;
+		} else if (key.type =3D=3D BTRFS_EXTENT_DATA_KEY &&
+			   key.objectid =3D=3D last_csum_inode) {
+			struct btrfs_file_extent_item *fi;
+			u64 addr, length;
+
+			fi =3D btrfs_item_ptr(leaf, path.slots[0],
+					    struct btrfs_file_extent_item);
+
+			if (btrfs_file_extent_type(leaf, fi) !=3D BTRFS_FILE_EXTENT_REG)
+				goto next;
+
+			if (btrfs_file_extent_compression(leaf, fi) !=3D 0)
+				goto next;
+
+			addr =3D btrfs_file_extent_disk_bytenr(leaf, fi) +
+				btrfs_file_extent_offset(leaf, fi);
+			length =3D btrfs_file_extent_disk_num_bytes(leaf, fi);
+
+			ret =3D check_log_csum(root, addr, length);
+			if (ret < 0) {
+				err =3D 1;
+				break;
+			}
+
+			if (!ret) {
+				error("csum missing in log (root %llu, inode %llu, "
+				      "offset %llu, address 0x%llx, length %llu)",
+				      root->objectid, last_csum_inode, key.offset,
+				      addr, length);
+				err =3D 1;
+			}
+		}
+
+next:
+		path.slots[0]++;
+	}
+
+	btrfs_release_path(&path);
+
+	return err;
+}
+
+static int check_log(struct cache_tree *root_cache)
+{
+	struct btrfs_path path =3D { 0 };
+	struct walk_control wc;
+
+	memset(&wc, 0, sizeof(wc));
+	cache_tree_init(&wc.shared);
+
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_root *log_root =3D gfs_info->log_root_tree;
+	int ret;
+	int err =3D 0;
+
+	key.objectid =3D BTRFS_TREE_LOG_OBJECTID;
+	key.type =3D BTRFS_ROOT_ITEM_KEY;
+	key.offset =3D 0;
+	ret =3D btrfs_search_slot(NULL, log_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		err =3D 1;
+		goto out;
+	}
+
+	while (1) {
+		leaf =3D path.nodes[0];
+		if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(log_root, &path);
+			if (ret) {
+				if (ret < 0)
+					err =3D 1;
+				break;
+			}
+			leaf =3D path.nodes[0];
+		}
+		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
+
+		if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
+		    key.type > BTRFS_ROOT_ITEM_KEY)
+			break;
+
+		if (key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID &&
+		    key.type =3D=3D BTRFS_ROOT_ITEM_KEY &&
+		    fs_root_objectid(key.offset)) {
+			struct btrfs_root tmp_root;
+			struct extent_buffer *l;
+			struct btrfs_tree_parent_check check =3D { 0 };
+
+			memset(&tmp_root, 0, sizeof(tmp_root));
+
+			btrfs_setup_root(&tmp_root, gfs_info, key.offset);
+
+			l =3D path.nodes[0];
+			read_extent_buffer(l, &tmp_root.root_item,
+					btrfs_item_ptr_offset(l, path.slots[0]),
+					sizeof(tmp_root.root_item));
+
+			tmp_root.root_key.objectid =3D key.offset;
+			tmp_root.root_key.type =3D BTRFS_ROOT_ITEM_KEY;
+			tmp_root.root_key.offset =3D 0;
+
+			check.owner_root =3D btrfs_root_id(&tmp_root);
+			check.transid =3D btrfs_root_generation(&tmp_root.root_item);
+			check.level =3D btrfs_root_level(&tmp_root.root_item);
+
+			tmp_root.node =3D read_tree_block(gfs_info,
+							btrfs_root_bytenr(&tmp_root.root_item),
+							&check);
+			if (IS_ERR(tmp_root.node)) {
+				tmp_root.node =3D NULL;
+				err =3D 1;
+				goto next;
+			}
+
+			if (btrfs_header_level(tmp_root.node) !=3D btrfs_root_level(&tmp_root=
.root_item)) {
+				error("root [%llu %llu] level %d does not match %d",
+					tmp_root.root_key.objectid,
+					tmp_root.root_key.offset,
+					btrfs_header_level(tmp_root.node),
+					btrfs_root_level(&tmp_root.root_item));
+				err =3D 1;
+				goto next;
+			}
+
+			ret =3D check_log_root(&tmp_root, root_cache, &wc);
+			if (ret)
+				err =3D 1;
+
+next:
+			if (tmp_root.node)
+				free_extent_buffer(tmp_root.node);
+		}
+		path.slots[0]++;
+	}
+out:
+	btrfs_release_path(&path);
+	if (err)
+		free_extent_cache_tree(&wc.shared);
+	if (!cache_tree_empty(&wc.shared))
+		fprintf(stderr, "warning line %d\n", __LINE__);
+
+	return err;
+}
+
 static void free_roots_info_cache(void)
 {
 	if (!roots_info_cache)
@@ -10587,7 +10844,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
=20
 	if (!init_extent_tree) {
 		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[1/7] checking root items\n");
+			fprintf(stderr, "[1/8] checking root items\n");
 		} else {
 			g_task_ctx.tp =3D TASK_ROOT_ITEMS;
 			task_start(g_task_ctx.info, &g_task_ctx.start_time,
@@ -10622,11 +10879,11 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
 			}
 		}
 	} else {
-		fprintf(stderr, "[1/7] checking root items... skipped\n");
+		fprintf(stderr, "[1/8] checking root items... skipped\n");
 	}
=20
 	if (!g_task_ctx.progress_enabled) {
-		fprintf(stderr, "[2/7] checking extents\n");
+		fprintf(stderr, "[2/8] checking extents\n");
 	} else {
 		g_task_ctx.tp =3D TASK_EXTENTS;
 		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_c=
ount);
@@ -10644,9 +10901,9 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
=20
 	if (!g_task_ctx.progress_enabled) {
 		if (is_free_space_tree)
-			fprintf(stderr, "[3/7] checking free space tree\n");
+			fprintf(stderr, "[3/8] checking free space tree\n");
 		else
-			fprintf(stderr, "[3/7] checking free space cache\n");
+			fprintf(stderr, "[3/8] checking free space cache\n");
 	} else {
 		g_task_ctx.tp =3D TASK_FREE_SPACE;
 		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_c=
ount);
@@ -10664,7 +10921,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
 	 */
 	no_holes =3D btrfs_fs_incompat(gfs_info, NO_HOLES);
 	if (!g_task_ctx.progress_enabled) {
-		fprintf(stderr, "[4/7] checking fs roots\n");
+		fprintf(stderr, "[4/8] checking fs roots\n");
 	} else {
 		g_task_ctx.tp =3D TASK_FS_ROOTS;
 		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_c=
ount);
@@ -10680,10 +10937,10 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
=20
 	if (!g_task_ctx.progress_enabled) {
 		if (check_data_csum)
-			fprintf(stderr, "[5/7] checking csums against data\n");
+			fprintf(stderr, "[5/8] checking csums against data\n");
 		else
 			fprintf(stderr,
-		"[5/7] checking only csums items (without verifying data)\n");
+		"[5/8] checking only csums items (without verifying data)\n");
 	} else {
 		g_task_ctx.tp =3D TASK_CSUMS;
 		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_c=
ount);
@@ -10702,7 +10959,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
 	/* For low memory mode, check_fs_roots_v2 handles root refs */
         if (check_mode !=3D CHECK_MODE_LOWMEM) {
 		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[6/7] checking root refs\n");
+			fprintf(stderr, "[6/8] checking root refs\n");
 		} else {
 			g_task_ctx.tp =3D TASK_ROOT_REFS;
 			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_=
count);
@@ -10717,7 +10974,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
 		}
 	} else {
 		fprintf(stderr,
-	"[6/7] checking root refs done with fs roots in lowmem mode, skipping\n=
");
+	"[6/8] checking root refs done with fs roots in lowmem mode, skipping\n=
");
 	}
=20
 	while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
@@ -10749,7 +11006,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
=20
 	if (gfs_info->quota_enabled) {
 		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[7/7] checking quota groups\n");
+			fprintf(stderr, "[7/8] checking quota groups\n");
 		} else {
 			g_task_ctx.tp =3D TASK_QGROUPS;
 			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_=
count);
@@ -10772,7 +11029,19 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
 		ret =3D 0;
 	} else {
 		fprintf(stderr,
-		"[7/7] checking quota groups skipped (not enabled on this FS)\n");
+		"[7/8] checking quota groups skipped (not enabled on this FS)\n");
+	}
+
+	if (gfs_info->log_root_tree) {
+		fprintf(stderr, "[8/8] checking log\n");
+		ret =3D check_log(&root_cache);
+
+		if (ret)
+			error("errors found in log");
+		err |=3D !!ret;
+	} else {
+		fprintf(stderr,
+		"[8/8] checking log skipped (none written)\n");
 	}
=20
 	if (!list_empty(&gfs_info->recow_ebs)) {
--=20
2.44.2


