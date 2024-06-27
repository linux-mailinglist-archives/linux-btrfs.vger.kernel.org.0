Return-Path: <linux-btrfs+bounces-6015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F791A331
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 11:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33B2865C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9113C906;
	Thu, 27 Jun 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IhXwwY1p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED113B587
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482113; cv=none; b=kG8zvzCw0PtUU8shqQjiBdyZ5BFQYRK6l5Tti1vKRb01PC6Xg++Qm5ntyBJiUber7SeP9XEEDxGFqg0Y3GuOaPKNoz3FgbL3GC4z1XqflxxEoXJNuHS08KVT6SXbGWm5pg1uLPXdyL41Y7l5Eu529OYD7XsecI+NctG+VbvfQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482113; c=relaxed/simple;
	bh=DHCnl2RyY5kPrmNvDu9PopjiJAh0xtwA9FOH5bcDBYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sY6+KZCz9fHKdxvZZFXWmG4Cw15mrysN7/8pQ1DF8O+9tPff04oQa82LCO1W/Jun1GxSCnmtald6P2KRQIZ1ygwoSDgbt8KgHHw+nYoAkaxi7dvGKP9Mwrg38EEZJllYM3iBHRRyEBaJsqXoAijIxk5cBCFycIH28TZO+vdj7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=IhXwwY1p; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45R2DeBH000882
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 02:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=crU5Hz4l
	pQ8DsY8bMw0I59ZTAQ9Zo/2hfAk0Y9f2xps=; b=IhXwwY1p+Iu6o52miSEEA9GI
	I8rPXJ41thVCu8wfpM55ezzPejgEUiIfRJYKAOFS9B+t1hfgUaCyc9VqGtpxhkAq
	EVUG/0HpOwv+0wukJAkM7M09AJzuOKuy9ctSkNBJbfKqUGU31DA8Wcv+YMTXTGJv
	LOoIZub+wZrHvwDvTFI=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 400e7rg1n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 02:55:10 -0700 (PDT)
Received: from twshared25218.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 27 Jun 2024 09:55:07 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 660AE3A69D6C; Thu, 27 Jun 2024 10:55:00 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
Date: Thu, 27 Jun 2024 10:54:42 +0100
Message-ID: <20240627095455.315620-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: 8uF-qt1snPK0_CMdCbKwGqiU4u19GVMJ
X-Proofpoint-GUID: 8uF-qt1snPK0_CMdCbKwGqiU4u19GVMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-25_01,2024-05-17_01

From: Mark Harmstone <maharmstone@meta.com>

This patch adds a --subvol option, which tells mkfs.btrfs to create the
specified directories as subvolumes.

Given a populated directory img, the command

$ mkfs.btrfs --rootdir img --subvol usr --subvol home --subvol home/usern=
ame /dev/loop0

will create subvolumes usr and home within the FS root, and subvolume
username within the home subvolume. It will fail if any of the
directories do not yet exist.

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
---
 convert/main.c                              |   4 +-
 kernel-shared/ctree.h                       |   3 +-
 kernel-shared/inode.c                       |  46 +--
 mkfs/main.c                                 | 357 +++++++++++++++++++-
 mkfs/rootdir.c                              |  31 +-
 mkfs/rootdir.h                              |  16 +-
 tests/mkfs-tests/034-rootdir-subvol/test.sh |  33 ++
 7 files changed, 463 insertions(+), 27 deletions(-)
 create mode 100755 tests/mkfs-tests/034-rootdir-subvol/test.sh

diff --git a/convert/main.c b/convert/main.c
index 8e73aa25..7249c793 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1314,7 +1314,9 @@ static int do_convert(const char *devname, u32 conv=
ert_flags, u32 nodesize,
 	}
=20
 	image_root =3D btrfs_mksubvol(root, subvol_name,
-				    CONV_IMAGE_SUBVOL_OBJECTID, true);
+				    CONV_IMAGE_SUBVOL_OBJECTID, true,
+				    btrfs_root_dirid(&root->root_item),
+				    false);
 	if (!image_root) {
 		error("unable to link subvolume %s", subvol_name);
 		goto fail;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 1341a418..8a5ddcdb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1230,7 +1230,8 @@ int btrfs_add_orphan_item(struct btrfs_trans_handle=
 *trans,
 int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *roo=
t,
 		char *name, int namelen, u64 parent_ino, u64 *ino, int mode);
 struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root, const char *b=
ase,
-				  u64 root_objectid, bool convert);
+				  u64 root_objectid, bool convert, u64 dirid,
+				  bool dont_change_size);
 int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *fs_root,
 			     u64 dirid, u64 *objectid);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 91b4f629..99965558 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -584,7 +584,8 @@ out:
=20
 struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 				  const char *base, u64 root_objectid,
-				  bool convert)
+				  bool convert, u64 dirid,
+				  bool dont_change_size)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_fs_info *fs_info =3D root->fs_info;
@@ -594,7 +595,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *=
root,
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	u64 dirid =3D btrfs_root_dirid(&root->root_item);
 	u64 index =3D 2;
 	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
 	int len;
@@ -632,20 +632,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root =
*root,
 		goto fail;
 	}
=20
-	key.objectid =3D dirid;
-	key.type =3D  BTRFS_INODE_ITEM_KEY;
-	key.offset =3D 0;
-
-	ret =3D btrfs_lookup_inode(trans, root, &path, &key, 1);
-	if (ret) {
-		error("search for INODE_ITEM %llu failed: %d",
-				(unsigned long long)dirid, ret);
-		goto fail;
-	}
-	leaf =3D path.nodes[0];
-	inode_item =3D btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_inode_item);
-
 	key.objectid =3D root_objectid;
 	key.type =3D BTRFS_ROOT_ITEM_KEY;
 	key.offset =3D (u64)-1;
@@ -670,10 +656,26 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root=
 *root,
 	if (ret)
 		goto fail;
=20
-	btrfs_set_inode_size(leaf, inode_item, len * 2 +
-			     btrfs_inode_size(leaf, inode_item));
-	btrfs_mark_buffer_dirty(leaf);
-	btrfs_release_path(&path);
+	if (!dont_change_size) {
+		key.objectid =3D dirid;
+		key.type =3D  BTRFS_INODE_ITEM_KEY;
+		key.offset =3D 0;
+
+		ret =3D btrfs_lookup_inode(trans, root, &path, &key, 1);
+		if (ret) {
+			error("search for INODE_ITEM %llu failed: %d",
+					(unsigned long long)dirid, ret);
+			goto fail;
+		}
+		leaf =3D path.nodes[0];
+		inode_item =3D btrfs_item_ptr(leaf, path.slots[0],
+					struct btrfs_inode_item);
+
+		btrfs_set_inode_size(leaf, inode_item, len * 2 +
+				btrfs_inode_size(leaf, inode_item));
+		btrfs_mark_buffer_dirty(leaf);
+		btrfs_release_path(&path);
+	}
=20
 	/* add the backref first */
 	ret =3D btrfs_add_root_ref(trans, tree_root, root_objectid,
@@ -703,6 +705,10 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root =
*root,
 		goto fail;
 	}
=20
+	key.objectid =3D root_objectid;
+	key.type =3D BTRFS_ROOT_ITEM_KEY;
+	key.offset =3D (u64)-1;
+
 	new_root =3D btrfs_read_fs_root(fs_info, &key);
 	if (IS_ERR(new_root)) {
 		error("unable to fs read root: %lu", PTR_ERR(new_root));
diff --git a/mkfs/main.c b/mkfs/main.c
index b40f7432..63119fc3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -440,6 +440,7 @@ static const char * const mkfs_usage[] =3D {
 	"Creation:",
 	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (files=
ystem size is sum of all device sizes)"),
 	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root dire=
ctory"),
+	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than n=
ormal directory"),
 	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to m=
inimal size"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
@@ -1168,6 +1169,67 @@ static void *prepare_one_device(void *ctx)
 	return NULL;
 }
=20
+static int create_subvol(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *root, u64 root_objectid)
+{
+	struct extent_buffer *tmp;
+	struct btrfs_root *new_root;
+	struct btrfs_key key;
+	struct btrfs_root_item root_item;
+	u8 uuid[BTRFS_UUID_SIZE];
+	int ret;
+
+	ret =3D btrfs_copy_root(trans, root, root->node, &tmp,
+			      root_objectid);
+	if (ret)
+		return ret;
+
+	uuid_generate(uuid);
+
+	memcpy(&root_item, &root->root_item, sizeof(root_item));
+	btrfs_set_root_bytenr(&root_item, tmp->start);
+	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
+	btrfs_set_root_generation(&root_item, trans->transid);
+	memcpy(&root_item.uuid, uuid, BTRFS_UUID_SIZE);
+
+	free_extent_buffer(tmp);
+
+	key.objectid =3D root_objectid;
+	key.type =3D BTRFS_ROOT_ITEM_KEY;
+	key.offset =3D trans->transid;
+	ret =3D btrfs_insert_root(trans, root->fs_info->tree_root,
+				&key, &root_item);
+
+	key.offset =3D (u64)-1;
+	new_root =3D btrfs_read_fs_root(root->fs_info, &key);
+	if (!new_root || IS_ERR(new_root)) {
+		error("unable to fs read root: %lu", PTR_ERR(new_root));
+		return PTR_ERR(new_root);
+	}
+
+	ret =3D btrfs_uuid_tree_add(trans, uuid, BTRFS_UUID_KEY_SUBVOL,
+				  root_objectid);
+	if (ret < 0) {
+		error("failed to add uuid entry");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int subvol_compar(const void *p1, const void *p2)
+{
+	const struct rootdir_subvol *s1 =3D *(const struct rootdir_subvol**)p1;
+	const struct rootdir_subvol *s2 =3D *(const struct rootdir_subvol**)p2;
+
+	if (s1->depth < s2->depth)
+		return 1;
+	else if (s1->depth > s2->depth)
+		return -1;
+	else
+		return 0;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -1209,6 +1271,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label =3D NULL;
 	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir =3D NULL;
+	LIST_HEAD(subvols);
=20
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1239,6 +1302,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "data", required_argument, NULL, 'd' },
 			{ "version", no_argument, NULL, 'V' },
 			{ "rootdir", required_argument, NULL, 'r' },
+			{ "subvol", required_argument, NULL, 'u' },
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
@@ -1360,6 +1424,25 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				free(source_dir);
 				source_dir =3D strdup(optarg);
 				break;
+			case 'u': {
+				struct rootdir_subvol *s;
+
+				s =3D malloc(sizeof(struct rootdir_subvol));
+				if (!s) {
+					error("out of memory");
+					goto error;
+				}
+
+				s->dir =3D strdup(optarg);
+				s->fullpath =3D NULL;
+				s->parent =3D NULL;
+				s->parent_inum =3D 0;
+				INIT_LIST_HEAD(&s->children);
+				s->root =3D NULL;
+
+				list_add_tail(&s->list, &subvols);
+				break;
+				}
 			case 'U':
 				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
 				break;
@@ -1420,6 +1503,159 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("the option --shrink must be used with --rootdir");
 		goto error;
 	}
+	if (!list_empty(&subvols) && source_dir =3D=3D NULL) {
+		error("the option --subvol must be used with --rootdir");
+		goto error;
+	}
+
+	if (source_dir) {
+		char *canonical =3D realpath(source_dir, NULL);
+
+		if (!canonical) {
+			error("could not get canonical path to %s", source_dir);
+			goto error;
+		}
+
+		free(source_dir);
+		source_dir =3D canonical;
+	}
+
+	if (!list_empty(&subvols)) {
+		unsigned int num_subvols =3D 0;
+		size_t source_dir_len =3D strlen(source_dir);
+		struct rootdir_subvol **arr, **ptr, *s;
+
+		list_for_each_entry(s, &subvols, list) {
+			size_t tmp_len;
+			char *tmp, *path;
+			struct rootdir_subvol *s2;
+
+			tmp_len =3D source_dir_len + 1 + strlen(s->dir) + 1;
+
+			tmp =3D malloc(tmp_len);
+			if (!tmp) {
+				error("out of memory");
+				goto error;
+			}
+
+			strcpy(tmp, source_dir);
+			strcat(tmp, "/");
+			strcat(tmp, s->dir);
+
+			if (!path_exists(tmp)) {
+				error("subvol %s does not exist within rootdir",
+				      s->dir);
+				free(tmp);
+				goto error;
+			}
+
+			if (!path_is_dir(tmp)) {
+				error("subvol %s is not a directory", s->dir);
+				free(tmp);
+				goto error;
+			}
+
+			path =3D realpath(tmp, NULL);
+
+			free(tmp);
+
+			if (!path) {
+				error("could not get canonical path to %s",
+				      s->dir);
+				goto error;
+			}
+
+			if (strlen(path) < source_dir_len + 1 ||
+			    memcmp(path, source_dir, source_dir_len) ||
+			    path[source_dir_len] !=3D '/') {
+				error("subvol %s is not a child of %s",
+				      s->dir, source_dir);
+				free(path);
+				goto error;
+			}
+
+			for (s2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
+			     s2 !=3D s; s2 =3D list_next_entry(s2, list)) {
+				if (!strcmp(s2->fullpath, path)) {
+					error("subvol %s specified more than once",
+					      s->dir);
+					free(path);
+					goto error;
+				}
+			}
+
+			s->fullpath =3D path;
+
+			s->depth =3D 0;
+			for (i =3D source_dir_len + 1; i < strlen(s->fullpath); i++) {
+				if (s->fullpath[i] =3D=3D '/')
+					s->depth++;
+			}
+
+			num_subvols++;
+		}
+
+		/* Reorder subvol list by depth. */
+
+		arr =3D malloc(sizeof(struct rootdir_subvol*) * num_subvols);
+		if (!arr) {
+			error("out of memory");
+			goto error;
+		}
+
+		ptr =3D arr;
+
+		list_for_each_entry(s, &subvols, list) {
+			*ptr =3D s;
+			ptr++;
+		}
+
+		qsort(arr, num_subvols, sizeof(struct rootdir_subvol*),
+		      subvol_compar);
+
+		INIT_LIST_HEAD(&subvols);
+		for (i =3D 0; i < num_subvols; i++) {
+			list_add_tail(&arr[i]->list, &subvols);
+		}
+
+		free(arr);
+
+		/* Assign subvols to parents. */
+
+		list_for_each_entry(s, &subvols, list) {
+			size_t len1;
+
+			if (s->depth =3D=3D 0)
+				break;
+
+			len1 =3D strlen(s->fullpath);
+
+			for (struct rootdir_subvol *s2 =3D list_next_entry(s, list);
+			     !list_entry_is_head(s2, &subvols, list);
+			     s2 =3D list_next_entry(s2, list)) {
+				size_t len2;
+
+				if (s2->depth =3D=3D s->depth)
+					continue;
+
+				len2 =3D strlen(s2->fullpath);
+
+				if (len1 <=3D len2 + 1)
+					continue;
+
+				if (s->fullpath[len2] !=3D '/')
+					continue;
+
+				if (memcmp(s->fullpath, s2->fullpath, len2))
+					continue;
+
+				s->parent =3D s2;
+				list_add_tail(&s->child_list, &s2->children);
+
+				break;
+			}
+		}
+	}
=20
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
@@ -1964,9 +2200,68 @@ raid_groups:
 		goto out;
 	}
=20
+	if (!list_empty(&subvols)) {
+		struct rootdir_subvol *s;
+		u64 objectid =3D BTRFS_FIRST_FREE_OBJECTID;
+
+		list_for_each_entry_reverse(s, &subvols, list) {
+			struct btrfs_key key;
+
+			s->objectid =3D objectid;
+
+			trans =3D btrfs_start_transaction(root, 1);
+			if (IS_ERR(trans)) {
+				errno =3D -PTR_ERR(trans);
+				error_msg(ERROR_MSG_START_TRANS, "%m");
+				goto error;
+			}
+
+			ret =3D create_subvol(trans, root, objectid);
+			if (ret < 0) {
+				error("failed to create subvolume: %d", ret);
+				goto out;
+			}
+
+			ret =3D btrfs_commit_transaction(trans, root);
+			if (ret) {
+				errno =3D -ret;
+				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+				goto out;
+			}
+
+			key.objectid =3D objectid;
+			key.type =3D BTRFS_ROOT_ITEM_KEY;
+			key.offset =3D (u64)-1;
+
+			s->root =3D btrfs_read_fs_root(fs_info, &key);
+			if (IS_ERR(s->root)) {
+				error("unable to fs read root: %lu", PTR_ERR(s->root));
+				goto out;
+			}
+
+			objectid++;
+		}
+	}
+
 	if (source_dir) {
+		LIST_HEAD(subvol_children);
+
 		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
-		ret =3D btrfs_mkfs_fill_dir(source_dir, root);
+
+		if (!list_empty(&subvols)) {
+			struct rootdir_subvol *s;
+
+			list_for_each_entry(s, &subvols, list) {
+				if (s->parent)
+					continue;
+
+				list_add_tail(&s->child_list,
+					      &subvol_children);
+			}
+		}
+
+		ret =3D btrfs_mkfs_fill_dir(source_dir, root,
+					  &subvol_children);
 		if (ret) {
 			error("error while filling filesystem: %d", ret);
 			goto out;
@@ -1983,6 +2278,41 @@ raid_groups:
 		} else {
 			pr_verbose(LOG_DEFAULT, "  Shrink:           no\n");
 		}
+
+		if (!list_empty(&subvols)) {
+			struct rootdir_subvol *s;
+
+			list_for_each_entry_reverse(s, &subvols, list) {
+				pr_verbose(LOG_DEFAULT,
+					   "  Subvol from:      %s\n",
+					   s->fullpath);
+			}
+		}
+	}
+
+	if (!list_empty(&subvols)) {
+		struct rootdir_subvol *s;
+
+		list_for_each_entry(s, &subvols, list) {
+			ret =3D btrfs_mkfs_fill_dir(s->fullpath, s->root,
+						  &s->children);
+			if (ret) {
+				error("error while filling filesystem: %d",
+				      ret);
+				goto out;
+			}
+		}
+
+		list_for_each_entry_reverse(s, &subvols, list) {
+			if (!btrfs_mksubvol(s->parent ? s->parent->root : root,
+					    path_basename(s->dir), s->objectid,
+					    false, s->parent_inum,
+					    true)) {
+				error("unable to link subvolume %s",
+				      path_basename(s->dir));
+				goto out;
+			}
+		}
 	}
=20
 	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
@@ -2076,6 +2406,18 @@ out:
 	free(label);
 	free(source_dir);
=20
+	while (!list_empty(&subvols)) {
+		struct rootdir_subvol *head =3D list_entry(subvols.next,
+					      struct rootdir_subvol,
+					      list);
+
+		free(head->dir);
+		free(head->fullpath);
+
+		list_del(&head->list);
+		free(head);
+	}
+
 	return !!ret;
=20
 error:
@@ -2087,6 +2429,19 @@ error:
 	free(prepare_ctx);
 	free(label);
 	free(source_dir);
+
+	while (!list_empty(&subvols)) {
+		struct rootdir_subvol *head =3D list_entry(subvols.next,
+					      struct rootdir_subvol,
+					      list);
+
+		free(head->dir);
+		free(head->fullpath);
+
+		list_del(&head->list);
+		free(head);
+	}
+
 	exit(1);
 success:
 	exit(0);
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 617a7efd..3377bec5 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -493,7 +493,8 @@ error:
=20
 static int traverse_directory(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root, const char *dir_name,
-			      struct directory_name_entry *dir_head)
+			      struct directory_name_entry *dir_head,
+			      struct list_head *subvol_children)
 {
 	int ret =3D 0;
=20
@@ -570,6 +571,28 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
 				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
 			}
=20
+			/* Omit child if it is going to be a subvolume. */
+			if (!list_empty(subvol_children) && S_ISDIR(st.st_mode)) {
+				struct rootdir_subvol *s;
+				bool skip =3D false;
+
+				if (bconf.verbose < LOG_INFO) {
+					path_cat_out(tmp, parent_dir_entry->path,
+						     cur_file->d_name);
+				}
+
+				list_for_each_entry(s, subvol_children, child_list) {
+					if (!strcmp(tmp, s->fullpath)) {
+						s->parent_inum =3D parent_inum;
+						skip =3D true;
+						break;
+					}
+				}
+
+				if (skip)
+					continue;
+			}
+
 			/*
 			 * We can not directly use the source ino number,
 			 * as there is a chance that the ino is smaller than
@@ -680,7 +703,8 @@ fail_no_dir:
 	goto out;
 }
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
+int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root,
+			struct list_head *subvol_children)
 {
 	int ret;
 	struct btrfs_trans_handle *trans;
@@ -705,7 +729,8 @@ int btrfs_mkfs_fill_dir(const char *source_dir, struc=
t btrfs_root *root)
 		goto fail;
 }
=20
-	ret =3D traverse_directory(trans, root, source_dir, &dir_head);
+	ret =3D traverse_directory(trans, root, source_dir, &dir_head,
+				 subvol_children);
 	if (ret) {
 		error("unable to traverse directory %s: %d", source_dir, ret);
 		goto fail;
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 8d5f6896..598eb1a7 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -36,7 +36,21 @@ struct directory_name_entry {
 	struct list_head list;
 };
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)=
;
+struct rootdir_subvol {
+	struct list_head list;
+	struct list_head child_list;
+	char *dir;
+	char *fullpath;
+	struct rootdir_subvol *parent;
+	u64 parent_inum;
+	struct list_head children;
+	unsigned int depth;
+	u64 objectid;
+	struct btrfs_root *root;
+};
+
+int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root,
+			struct list_head *subvol_children);
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_de=
v_size,
 			u64 meta_profile, u64 data_profile);
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_re=
t,
diff --git a/tests/mkfs-tests/034-rootdir-subvol/test.sh b/tests/mkfs-tes=
ts/034-rootdir-subvol/test.sh
new file mode 100755
index 00000000..d8085659
--- /dev/null
+++ b/tests/mkfs-tests/034-rootdir-subvol/test.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# smoke test for mkfs.btrfs --subvol option
+
+source "$TEST_TOP/common" || exit
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+tmp=3D$(_mktemp_dir mkfs-rootdir)
+
+touch $tmp/foo
+mkdir $tmp/dir
+mkdir $tmp/dir/subvol
+touch $tmp/dir/subvol/bar
+
+run_check_mkfs_test_dev --rootdir "$tmp" --subvol dir/subvol
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mount_test_dev
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" | =
\
+	cut -d\  -f9 > "$tmp/output"
+run_check_umount_test_dev
+
+result=3D$(cat "$tmp/output")
+
+if [ "$result" !=3D "dir/subvol" ]; then
+	_fail "dir/subvol not in subvolume list"
+fi
+
+rm -rf -- "$tmp"
--=20
2.44.2


