Return-Path: <linux-btrfs+bounces-7025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8594AC9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 17:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD05B254C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF18615A;
	Wed,  7 Aug 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LB+lFb10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FE84A35
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043848; cv=none; b=OmPGvDumjfhiJbG+eoVmINvrVylj9Nh66f+npHAmtoeR5lngRGWwyX9L+0FzhPVvotYLLIpGRRHCWsWsJpyujHCovXZ6J8ib4Q0gYsOPs9cXuT9RI1LYYoSMqKzdOQrFaUey3JeF07sDM0DZEWaW//rTR31hQEaUmBiYpkja/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043848; c=relaxed/simple;
	bh=eo+97g/PE8xftBklNjG0NHFgDlVA6ImHhbEwQBdfiU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PP84RAKCDSqMmvQltwkvQNy38l6ybvfsXRhrmHeAOsHy8fSrkejLOcZfI2Jh6s2PYiXb/QBF6LPQvClADJFHm4vIOfuDeBOoZ8EuM/Z45isZtFve0ab7e4W/y1dwxt9CHceh/eFDT+WpJFy9/+9eDRpbZ2nlrQkUZbww52+yJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=LB+lFb10; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 477E7dT2025500
	for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2024 08:17:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=zL20oysO
	ITw3eX0HTi/8WaaYL/52Wl5YwpRSv6cRsDo=; b=LB+lFb10xhU2J1WiA5VD27Sz
	Wv6+D6MZD/BGBicNZBkyKNwq5/zTUQmnIOQzP+aEaFqRGWEInrCUjoSIXTuyjPLr
	s8vVef8qgBwIepQqfkc2loA+QnUGDDfo6ahKhWkNwHBbabpS7ybxrLFORvBO8NXL
	yB+uNBJjd/o57j3O+Zo=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 40usnse1uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2024 08:17:24 -0700 (PDT)
Received: from twshared25218.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 7 Aug 2024 15:17:24 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 7507D52E1501; Wed,  7 Aug 2024 16:17:12 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
Date: Wed, 7 Aug 2024 16:16:51 +0100
Message-ID: <20240807151707.2828988-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: Yd_L05eGwqVC7zx8zxEvLZlcCld7NJEo
X-Proofpoint-GUID: Yd_L05eGwqVC7zx8zxEvLZlcCld7NJEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01

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

 mkfs/main.c                                 | 155 ++++++++++++++++++--
 mkfs/rootdir.c                              | 132 +++++++++++++----
 mkfs/rootdir.h                              |   9 +-
 tests/mkfs-tests/036-rootdir-subvol/test.sh |  33 +++++
 4 files changed, 287 insertions(+), 42 deletions(-)
 create mode 100755 tests/mkfs-tests/036-rootdir-subvol/test.sh

diff --git a/mkfs/main.c b/mkfs/main.c
index b24b148d..9e0e5fc9 100644
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
@@ -1055,6 +1056,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label =3D NULL;
 	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir =3D NULL;
+	LIST_HEAD(subvols);
=20
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1085,6 +1087,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "data", required_argument, NULL, 'd' },
 			{ "version", no_argument, NULL, 'V' },
 			{ "rootdir", required_argument, NULL, 'r' },
+			{ "subvol", required_argument, NULL, 'u' },
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
@@ -1102,7 +1105,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
=20
-		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
+		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1208,6 +1211,22 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -1272,6 +1291,77 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+	}
+
+	if (!list_empty(&subvols)) {
+		size_t source_dir_len =3D strlen(source_dir);
+		struct rootdir_subvol *s;
+
+		list_for_each_entry(s, &subvols, list) {
+			char *path;
+			struct rootdir_subvol *s2;
+
+			if (!path_exists(s->dir)) {
+				error("subvol %s does not exist",
+				      s->dir);
+				ret =3D 1;
+				goto error;
+			}
+
+			if (!path_is_dir(s->dir)) {
+				error("subvol %s is not a directory", s->dir);
+				ret =3D 1;
+				goto error;
+			}
+
+			path =3D realpath(s->dir, NULL);
+
+			if (!path) {
+				error("could not get canonical path to %s",
+				      s->dir);
+				ret =3D 1;
+				goto error;
+			}
+
+			s->full_path =3D path;
+
+			if (strlen(path) < source_dir_len + 1 ||
+			    memcmp(path, source_dir, source_dir_len) ||
+			    path[source_dir_len] !=3D '/') {
+				error("subvol %s is not a child of %s",
+				      s->dir, source_dir);
+				ret =3D 1;
+				goto error;
+			}
+
+			for (s2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
+			     s2 !=3D s; s2 =3D list_next_entry(s2, list)) {
+				if (!strcmp(s2->full_path, path)) {
+					error("subvol %s specified more than once",
+					      s->dir);
+					ret =3D 1;
+					goto error;
+				}
+			}
+		}
+	}
=20
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
@@ -1821,24 +1911,42 @@ raid_groups:
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
 			goto out;
 		}
+
+		ret =3D btrfs_commit_transaction(trans, root);
+		if (ret) {
+			errno =3D -ret;
+			error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+			goto out;
+		}
+
+		if (!list_empty(&subvols)) {
+			struct rootdir_subvol *s;
+
+			list_for_each_entry(s, &subvols, list) {
+				pr_verbose(LOG_DEFAULT,
+					   "  Subvol from:      %s\n",
+					   s->full_path);
+			}
+		}
+
 		if (shrink_rootdir) {
 			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
 			ret =3D btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
@@ -1853,6 +1961,17 @@ raid_groups:
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
@@ -1946,6 +2065,18 @@ error:
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
index 05787dc3..24c57fed 100644
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
@@ -409,11 +416,80 @@ static u8 ftype_to_btrfs_type(mode_t ftype)
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
 	u64 ino;
@@ -436,7 +512,10 @@ static int ftw_add_inode(const char *full_path, cons=
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
@@ -462,7 +541,7 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		}
=20
 		/* Push (and initialize) the rootdir directory into the stack. */
-		ret =3D rootdir_path_push(&current_path,
+		ret =3D rootdir_path_push(&current_path, root,
 					btrfs_root_dirid(&root->root_item));
 		if (ret < 0) {
 			errno =3D -ret;
@@ -511,6 +590,20 @@ static int ftw_add_inode(const char *full_path, cons=
t struct stat *st,
 	while (current_path.level > ftwbuf->level)
 		rootdir_path_pop(&current_path);
=20
+	if (!list_empty(g_subvols) && S_ISDIR(st->st_mode)) {
+		struct rootdir_subvol *s;
+
+		list_for_each_entry(s, g_subvols, list) {
+			if (!strcmp(full_path, s->full_path)) {
+				return ftw_add_subvol(full_path, st, typeflag,
+						      ftwbuf, s);
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
@@ -529,7 +622,6 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		return ret;
 	}
=20
-	parent =3D rootdir_path_last(&current_path);
 	ret =3D btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -556,7 +648,7 @@ static int ftw_add_inode(const char *full_path, const=
 struct stat *st,
 		return ret;
 	}
 	if (S_ISDIR(st->st_mode)) {
-		ret =3D rootdir_path_push(&current_path, ino);
+		ret =3D rootdir_path_push(&current_path, root, ino);
 		if (ret < 0) {
 			errno =3D -ret;
 			error("failed to allocate new entry for inode %llu ('%s'): %m",
@@ -597,49 +689,31 @@ static int ftw_add_inode(const char *full_path, con=
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


