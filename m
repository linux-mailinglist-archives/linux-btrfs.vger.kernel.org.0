Return-Path: <linux-btrfs+bounces-7052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1394C377
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A383C1F253D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A7191493;
	Thu,  8 Aug 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kwDc2VbX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D868189B8D
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137451; cv=none; b=uuDyK5Id7L95xgNFYYt3YHxeaYwXGafelVOfLvgQsT+lAmJNV+I1VzlJV7Vw4tC/tE51jU/4/icTjZAzrixfRCPVeivdt+YEGDExlUaVkTMvpqu4rwvBJEF+IcfeovsyA5OUOvk6+nBRGBo5MAHjB6uNhFYFJZT3OieVLLUbR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137451; c=relaxed/simple;
	bh=gPZ6TJLA4jpZPR+LKSF3PRc+GaB1gohFq6hzwxlO0wQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8zlr4VO8Co/fMiu3ux5YWsMbr1W+PA4ayy875KU3fuOXU87o8akmfE6n6Q2BnW+u6LvPzWI6fI3/J3WmxgfQnHSKNXoqh2qsiltOr2/Oh0V9PlAunZfusGOjZPeUeV/Br6YBrfNh20uYxloDutVz70qvAvraIXFgbI/MpF2OEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=kwDc2VbX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478G9Og3021770
	for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2024 10:17:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=Kszs091P
	+RrQzS6IodsRWr6dDmu1UcbAB3KCU2ga/54=; b=kwDc2VbX5vxZ/GuFQCpZlGR4
	ZVFG9wunpN1/h/f7/AhJOBjVU64nTgICeSyPVCownP1CjGNHoVVrXrX0AKUuDisn
	oEfOZJXJEWWb8y7aIFGsxAAFQ+FpO9IzAnI/VI9nfvLKOa9bOjc6K33wydgkrZBb
	HC3lg+pk+nTfm9UDy98=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40vjdvndg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 10:17:28 -0700 (PDT)
Received: from twshared43930.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 8 Aug 2024 17:17:27 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 64334538C12B; Thu,  8 Aug 2024 18:17:22 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Date: Thu, 8 Aug 2024 18:17:16 +0100
Message-ID: <20240808171721.370556-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 93TxOromLBjTZBgrUBqRwtkJ5wdjwNCg
X-Proofpoint-GUID: 93TxOromLBjTZBgrUBqRwtkJ5wdjwNCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01

This patch adds a --subvol option, which tells mkfs.btrfs to create the
specified directories as subvolumes.

Given a populated directory img, the command

$ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol im=
g/home/username /dev/loop0

will create subvolumes usr and home within the FS root, and subvolume
username within the home subvolume. It will fail if any of the
directories do not yet exist.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 mkfs/main.c                                 | 146 ++++++++++++++++++--
 mkfs/rootdir.c                              | 131 ++++++++++++++----
 mkfs/rootdir.h                              |   9 +-
 tests/mkfs-tests/036-rootdir-subvol/test.sh |  33 +++++
 4 files changed, 277 insertions(+), 42 deletions(-)
 create mode 100755 tests/mkfs-tests/036-rootdir-subvol/test.sh

Changelog:

Patch 2:
* Rebased against upstream changes
* Rewrote so that directory sizes are correct within transactions
* Changed --subvol so that it is relative to cwd rather than rootdir, so
that in future we might allow out-of-tree subvols

Patch 3:
* Changed btrfs_mkfs_fill_dir so it doesn't start a transaction itself
* Moved subvol creation and linking into traverse_directory
* Removed depth calculation code, no longer needed

Patch 4:
* Rebased against upstream changes

Patch 5:
* Removed some useless calls to list_empty

diff --git a/mkfs/main.c b/mkfs/main.c
index b24b148d..ebf2a9c0 100644
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
@@ -1055,6 +1056,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label =3D NULL;
 	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir =3D NULL;
+	size_t source_dir_len =3D 0;
+	struct rootdir_subvol *rds;
+	LIST_HEAD(subvols);
=20
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1085,6 +1089,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "data", required_argument, NULL, 'd' },
 			{ "version", no_argument, NULL, 'V' },
 			{ "rootdir", required_argument, NULL, 'r' },
+			{ "subvol", required_argument, NULL, 'u' },
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
@@ -1102,7 +1107,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
=20
-		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
+		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1208,6 +1213,22 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				free(source_dir);
 				source_dir =3D strdup(optarg);
 				break;
+			case 'u': {
+				struct rootdir_subvol *s;
+
+				s =3D malloc(sizeof(struct rootdir_subvol));
+				if (!s) {
+					error("out of memory");
+					ret =3D 1;
+					goto error;
+				}
+
+				s->dir =3D strdup(optarg);
+				s->full_path =3D NULL;
+
+				list_add_tail(&s->list, &subvols);
+				break;
+				}
 			case 'U':
 				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
 				break;
@@ -1272,6 +1293,71 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		ret =3D 1;
 		goto error;
 	}
+	if (!list_empty(&subvols) && source_dir =3D=3D NULL) {
+		error("the option --subvol must be used with --rootdir");
+		ret =3D 1;
+		goto error;
+	}
+
+	if (source_dir) {
+		char *canonical =3D realpath(source_dir, NULL);
+
+		if (!canonical) {
+			error("could not get canonical path to %s", source_dir);
+			ret =3D 1;
+			goto error;
+		}
+
+		free(source_dir);
+		source_dir =3D canonical;
+		source_dir_len =3D strlen(source_dir);
+	}
+
+	list_for_each_entry(rds, &subvols, list) {
+		char *path;
+		struct rootdir_subvol *rds2;
+
+		if (!path_exists(rds->dir)) {
+			error("subvol %s does not exist", rds->dir);
+			ret =3D 1;
+			goto error;
+		}
+
+		if (!path_is_dir(rds->dir)) {
+			error("subvol %s is not a directory", rds->dir);
+			ret =3D 1;
+			goto error;
+		}
+
+		path =3D realpath(rds->dir, NULL);
+
+		if (!path) {
+			error("could not get canonical path to %s", rds->dir);
+			ret =3D 1;
+			goto error;
+		}
+
+		rds->full_path =3D path;
+
+		if (strlen(path) < source_dir_len + 1 ||
+		    memcmp(path, source_dir, source_dir_len) ||
+		    path[source_dir_len] !=3D '/') {
+			error("subvol %s is not a child of %s", rds->dir,
+			      source_dir);
+			ret =3D 1;
+			goto error;
+		}
+
+		for (rds2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
+		     rds2 !=3D rds; rds2 =3D list_next_entry(rds2, list)) {
+			if (!strcmp(rds2->full_path, path)) {
+				error("subvol %s specified more than once",
+					rds->dir);
+				ret =3D 1;
+				goto error;
+			}
+		}
+	}
=20
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
@@ -1821,24 +1907,37 @@ raid_groups:
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		goto out;
 	}
-	ret =3D btrfs_rebuild_uuid_tree(fs_info);
-	if (ret < 0)
-		goto out;
-
-	ret =3D cleanup_temp_chunks(fs_info, &allocation, data_profile,
-				  metadata_profile, metadata_profile);
-	if (ret < 0) {
-		error("failed to cleanup temporary chunks: %d", ret);
-		goto out;
-	}
=20
 	if (source_dir) {
 		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
-		ret =3D btrfs_mkfs_fill_dir(source_dir, root);
+
+		trans =3D btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans)) {
+			errno =3D -PTR_ERR(trans);
+			error_msg(ERROR_MSG_START_TRANS, "%m");
+			goto out;
+		}
+
+		ret =3D btrfs_mkfs_fill_dir(trans, source_dir, root,
+					  &subvols);
 		if (ret) {
 			error("error while filling filesystem: %d", ret);
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		ret =3D btrfs_commit_transaction(trans, root);
+		if (ret) {
+			errno =3D -ret;
+			error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
 			goto out;
 		}
+
+		list_for_each_entry(rds, &subvols, list) {
+			pr_verbose(LOG_DEFAULT, "  Subvol from:      %s\n",
+				   rds->full_path);
+		}
+
 		if (shrink_rootdir) {
 			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
 			ret =3D btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
@@ -1853,6 +1952,17 @@ raid_groups:
 		}
 	}
=20
+	ret =3D btrfs_rebuild_uuid_tree(fs_info);
+	if (ret < 0)
+		goto out;
+
+	ret =3D cleanup_temp_chunks(fs_info, &allocation, data_profile,
+				  metadata_profile, metadata_profile);
+	if (ret < 0) {
+		error("failed to cleanup temporary chunks: %d", ret);
+		goto out;
+	}
+
 	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
 	    features.incompat_flags & BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA) {
 		ret =3D setup_quota_root(fs_info);
@@ -1946,6 +2056,18 @@ error:
 	free(label);
 	free(source_dir);
=20
+	while (!list_empty(&subvols)) {
+		struct rootdir_subvol *head =3D list_entry(subvols.next,
+					      struct rootdir_subvol,
+					      list);
+
+		free(head->dir);
+		free(head->full_path);
+
+		list_del(&head->list);
+		free(head);
+	}
+
 	return !!ret;
=20
 success:
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 05787dc3..8f5658e1 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -40,6 +40,8 @@
 #include "common/messages.h"
 #include "common/utils.h"
 #include "common/extent-tree-utils.h"
+#include "common/root-tree-utils.h"
+#include "common/path-utils.h"
 #include "mkfs/rootdir.h"
=20
 static u32 fs_block_size;
@@ -68,6 +70,7 @@ static u64 ftw_data_size;
 struct inode_entry {
 	/* The inode number inside btrfs. */
 	u64 ino;
+	struct btrfs_root *root;
 	struct list_head list;
 };
=20
@@ -91,6 +94,8 @@ static struct rootdir_path current_path =3D {
 };
=20
 static struct btrfs_trans_handle *g_trans =3D NULL;
+static struct list_head *g_subvols;
+static u64 next_subvol_id =3D BTRFS_FIRST_FREE_OBJECTID;
=20
 static inline struct inode_entry *rootdir_path_last(struct rootdir_path =
*path)
 {
@@ -111,13 +116,15 @@ static void rootdir_path_pop(struct rootdir_path *p=
ath)
 	free(last);
 }
=20
-static int rootdir_path_push(struct rootdir_path *path, u64 ino)
+static int rootdir_path_push(struct rootdir_path *path, struct btrfs_roo=
t *root,
+			     u64 ino)
 {
 	struct inode_entry *new;
=20
 	new =3D malloc(sizeof(*new));
 	if (!new)
 		return -ENOMEM;
+	new->root =3D root;
 	new->ino =3D ino;
 	list_add_tail(&new->list, &path->inode_list);
 	path->level++;
@@ -409,13 +416,83 @@ static u8 ftype_to_btrfs_type(mode_t ftype)
 	return BTRFS_FT_UNKNOWN;
 }
=20
+static int ftw_add_subvol(const char *full_path, const struct stat *st,
+			  int typeflag, struct FTW *ftwbuf,
+			  struct rootdir_subvol *s)
+{
+	int ret;
+	struct btrfs_key key;
+	struct btrfs_root *new_root;
+	struct inode_entry *parent;
+	struct btrfs_inode_item inode_item =3D { 0 };
+	u64 subvol_id, ino;
+
+	subvol_id =3D next_subvol_id++;
+
+	ret =3D btrfs_make_subvolume(g_trans, subvol_id);
+	if (ret < 0) {
+		error("failed to create subvolume: %d", ret);
+		return ret;
+	}
+
+	key.objectid =3D subvol_id;
+	key.type =3D BTRFS_ROOT_ITEM_KEY;
+	key.offset =3D (u64)-1;
+
+	new_root =3D btrfs_read_fs_root(g_trans->fs_info, &key);
+	if (IS_ERR(new_root)) {
+		error("unable to fs read root: %lu", PTR_ERR(new_root));
+		return -PTR_ERR(new_root);
+	}
+
+	parent =3D rootdir_path_last(&current_path);
+
+	ret =3D btrfs_link_subvolume(g_trans, parent->root, parent->ino,
+				   path_basename(s->full_path),
+				   strlen(path_basename(s->full_path)), new_root);
+	if (ret) {
+		error("unable to link subvolume %s", path_basename(s->full_path));
+		return ret;
+	}
+
+	ino =3D btrfs_root_dirid(&new_root->root_item);
+
+	ret =3D add_xattr_item(g_trans, new_root, ino, full_path);
+	if (ret < 0) {
+		errno =3D -ret;
+		error("failed to add xattr item for the top level inode in subvol %llu=
: %m",
+		      subvol_id);
+		return ret;
+	}
+	stat_to_inode_item(&inode_item, st);
+
+	btrfs_set_stack_inode_nlink(&inode_item, 1);
+	ret =3D update_inode_item(g_trans, new_root, &inode_item, ino);
+	if (ret < 0) {
+		errno =3D -ret;
+		error("failed to update root dir for root %llu: %m", subvol_id);
+		return ret;
+	}
+
+	ret =3D rootdir_path_push(&current_path, new_root, ino);
+	if (ret < 0) {
+		errno =3D -ret;
+		error("failed to allocate new entry for subvol %llu ('%s'): %m",
+		      subvol_id, full_path);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ftw_add_inode(const char *full_path, const struct stat *st,
 			 int typeflag, struct FTW *ftwbuf)
 {
 	struct btrfs_fs_info *fs_info =3D g_trans->fs_info;
-	struct btrfs_root *root =3D fs_info->fs_root;
+	struct btrfs_root *root;
 	struct btrfs_inode_item inode_item =3D { 0 };
 	struct inode_entry *parent;
+	struct rootdir_subvol *rds;
 	u64 ino;
 	int ret;
=20
@@ -436,7 +513,10 @@ static int ftw_add_inode(const char *full_path, cons=
t struct stat *st,
=20
 	/* The rootdir itself. */
 	if (unlikely(ftwbuf->level =3D=3D 0)) {
-		u64 root_ino =3D btrfs_root_dirid(&root->root_item);
+		u64 root_ino;
+
+		root =3D fs_info->fs_root;
+		root_ino =3D btrfs_root_dirid(&root->root_item);
=20
 		UASSERT(S_ISDIR(st->st_mode));
 		UASSERT(current_path.level =3D=3D 0);
@@ -462,7 +542,7 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		}
=20
 		/* Push (and initialize) the rootdir directory into the stack. */
-		ret =3D rootdir_path_push(&current_path,
+		ret =3D rootdir_path_push(&current_path, root,
 					btrfs_root_dirid(&root->root_item));
 		if (ret < 0) {
 			errno =3D -ret;
@@ -511,6 +591,18 @@ static int ftw_add_inode(const char *full_path, cons=
t struct stat *st,
 	while (current_path.level > ftwbuf->level)
 		rootdir_path_pop(&current_path);
=20
+	if (S_ISDIR(st->st_mode)) {
+		list_for_each_entry(rds, g_subvols, list) {
+			if (!strcmp(full_path, rds->full_path)) {
+				return ftw_add_subvol(full_path, st, typeflag,
+						      ftwbuf, rds);
+			}
+		}
+	}
+
+	parent =3D rootdir_path_last(&current_path);
+	root =3D parent->root;
+
 	ret =3D btrfs_find_free_objectid(g_trans, root,
 				       BTRFS_FIRST_FREE_OBJECTID, &ino);
 	if (ret < 0) {
@@ -529,7 +621,6 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		return ret;
 	}
=20
-	parent =3D rootdir_path_last(&current_path);
 	ret =3D btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -556,7 +647,7 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		return ret;
 	}
 	if (S_ISDIR(st->st_mode)) {
-		ret =3D rootdir_path_push(&current_path, ino);
+		ret =3D rootdir_path_push(&current_path, root, ino);
 		if (ret < 0) {
 			errno =3D -ret;
 			error("failed to allocate new entry for inode %llu ('%s'): %m",
@@ -597,49 +688,31 @@ static int ftw_add_inode(const char *full_path, con=
st struct stat *st,
 	return 0;
 };
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
+int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *so=
urce_dir,
+			struct btrfs_root *root, struct list_head *subvols)
 {
 	int ret;
-	struct btrfs_trans_handle *trans;
 	struct stat root_st;
=20
 	ret =3D lstat(source_dir, &root_st);
 	if (ret) {
 		error("unable to lstat %s: %m", source_dir);
-		ret =3D -errno;
-		goto out;
-	}
-
-	trans =3D btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret =3D PTR_ERR(trans);
-		errno =3D -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		goto fail;
+		return -errno;
 	}
=20
 	g_trans =3D trans;
+	g_subvols =3D subvols;
 	INIT_LIST_HEAD(&current_path.inode_list);
=20
 	ret =3D nftw(source_dir, ftw_add_inode, 32, FTW_PHYS);
 	if (ret) {
 		error("unable to traverse directory %s: %d", source_dir, ret);
-		goto fail;
-	}
-	ret =3D btrfs_commit_transaction(trans, root);
-	if (ret) {
-		errno =3D -ret;
-		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
-		goto out;
+		return ret;
 	}
 	while (current_path.level > 0)
 		rootdir_path_pop(&current_path);
=20
 	return 0;
-fail:
-	btrfs_abort_transaction(trans, ret);
-out:
-	return ret;
 }
=20
 static int ftw_add_entry_size(const char *fpath, const struct stat *st,
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 4233431a..128e9e09 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -28,7 +28,14 @@
 struct btrfs_fs_info;
 struct btrfs_root;
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)=
;
+struct rootdir_subvol {
+	struct list_head list;
+	char *dir;
+	char *full_path;
+};
+
+int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *so=
urce_dir,
+			struct btrfs_root *root, struct list_head *subvols);
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_de=
v_size,
 			u64 meta_profile, u64 data_profile);
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_re=
t,
diff --git a/tests/mkfs-tests/036-rootdir-subvol/test.sh b/tests/mkfs-tes=
ts/036-rootdir-subvol/test.sh
new file mode 100755
index 00000000..ccd6893f
--- /dev/null
+++ b/tests/mkfs-tests/036-rootdir-subvol/test.sh
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
+run_check_mkfs_test_dev --rootdir "$tmp" --subvol "$tmp/dir/subvol"
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


