Return-Path: <linux-btrfs+bounces-6880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C537941432
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189AC1F2378B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664681A2560;
	Tue, 30 Jul 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ImnwBNkp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBA522F
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349323; cv=none; b=Dn/cCB7js+mUpgfSCCWsi1yDSaFJBuznoyC08n8qDlj63BgLgwVyKzuUd5JUZA9hhrph/mHEb2M5YUmNU1pMn/AV7kIYHKsRwHn3AlGXL8c99KwsbC6jo8GymfA4k6QXyXndyzrP7iVZDkFeabW2p1GozDIfFp7s5yp0L7pY8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349323; c=relaxed/simple;
	bh=fMzMi6KR+ZClww9v0w4wE8KWJ1+3AyIibV9dWRIhezs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kiMukVs9I6cqYPZZ5g05fq2VYAcPq0Uh9iXWEMsavVtA/AEXp+NyjCfKSf0Y/AK7Jp0nrVJL4SUy4URVe0bNi0LKQ9zBEBo3zygKPi0XPaGjvI24EgHagZcYyOXIixvqgM5Td//KJKuatYl/pHmC6CWSNltuxp0TyWUOfKWpAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=ImnwBNkp; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U90B1E026110
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 07:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=AoZ+ESP3
	dFwUFlgWRoDy/WvEHeTft3IpvduJl0cATIw=; b=ImnwBNkpXsZz7C4zSCi0w0fz
	1NDVqZkKJXBjjEb2auSKcrFhwxAEj96jXl5FOOHIfpJQoLisRXalv+ZTdYD/4vNB
	ROogEyLlvnpiPBip713sBicjRIxew90YvfSLYclXGeFYxiSMA8CsIwX0Ufn41Uye
	ApX4lsayUiXTNWnhAO4=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40pw5esw7d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 07:22:00 -0700 (PDT)
Received: from twshared23930.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 30 Jul 2024 14:21:56 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 093C24E16CCE; Tue, 30 Jul 2024 15:21:56 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v3] btrfs-progs: add --subvol option to mkfs.btrfs
Date: Tue, 30 Jul 2024 15:21:53 +0100
Message-ID: <20240730142155.2154877-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: GWbcoyPix9BZAeqe35fUw-3wF6i8iRJE
X-Proofpoint-ORIG-GUID: GWbcoyPix9BZAeqe35fUw-3wF6i8iRJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

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

 mkfs/main.c                                 | 173 +++++++++++++++--
 mkfs/rootdir.c                              | 194 +++++++++++++++-----
 mkfs/rootdir.h                              |  14 +-
 tests/mkfs-tests/034-rootdir-subvol/test.sh |  33 ++++
 4 files changed, 360 insertions(+), 54 deletions(-)
 create mode 100755 tests/mkfs-tests/034-rootdir-subvol/test.sh

diff --git a/mkfs/main.c b/mkfs/main.c
index e000aeff..72256816 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -442,6 +442,7 @@ static const char * const mkfs_usage[] =3D {
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
@@ -1057,6 +1058,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label =3D NULL;
 	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir =3D NULL;
+	LIST_HEAD(subvols);
=20
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1087,6 +1089,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "data", required_argument, NULL, 'd' },
 			{ "version", no_argument, NULL, 'V' },
 			{ "rootdir", required_argument, NULL, 'r' },
+			{ "subvol", required_argument, NULL, 'u' },
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
@@ -1104,7 +1107,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
=20
-		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
+		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1210,6 +1213,23 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+				s->srcpath =3D NULL;
+				s->destpath =3D NULL;
+
+				list_add_tail(&s->list, &subvols);
+				break;
+				}
 			case 'U':
 				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
 				break;
@@ -1274,6 +1294,91 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+			s->srcpath =3D path;
+			s->srcpath_len =3D strlen(path);
+
+			if (s->srcpath_len >=3D source_dir_len + 1 &&
+			    !memcmp(path, source_dir, source_dir_len) &&
+			    path[source_dir_len] =3D=3D '/') {
+				s->destpath_len =3D s->srcpath_len - source_dir_len - 1;
+
+				s->destpath =3D malloc(s->destpath_len + 1);
+				if (!s->destpath) {
+					error("out of memory");
+					ret =3D 1;
+					goto error;
+				}
+
+				memcpy(s->destpath, s->srcpath + source_dir_len + 1,
+				       s->destpath_len);
+				s->destpath[s->destpath_len] =3D 0;
+			} else {
+				error("subvol %s is not a child of %s",
+				      s->dir, source_dir);
+				ret =3D 1;
+				goto error;
+			}
+
+			for (s2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
+			     s2 !=3D s; s2 =3D list_next_entry(s2, list)) {
+				if (!strcmp(s2->srcpath, path)) {
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
@@ -1823,24 +1928,44 @@ raid_groups:
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
+		u64 next_subvol_id =3D BTRFS_FIRST_FREE_OBJECTID;
+
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
+					  &subvols, "", &next_subvol_id);
 		if (ret) {
 			error("error while filling filesystem: %d", ret);
+			btrfs_commit_transaction(trans, root);
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
+					   "  Subvol from:      %s -> %s\n",
+					   s->srcpath, s->destpath);
+			}
+		}
+
 		if (shrink_rootdir) {
 			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
 			ret =3D btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
@@ -1855,6 +1980,17 @@ raid_groups:
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
@@ -1948,6 +2084,19 @@ error:
 	free(label);
 	free(source_dir);
=20
+	while (!list_empty(&subvols)) {
+		struct rootdir_subvol *head =3D list_entry(subvols.next,
+					      struct rootdir_subvol,
+					      list);
+
+		free(head->dir);
+		free(head->srcpath);
+		free(head->destpath);
+
+		list_del(&head->list);
+		free(head);
+	}
+
 	return !!ret;
=20
 success:
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 2b39f6bb..981f106f 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -41,6 +41,7 @@
 #include "common/path-utils.h"
 #include "common/utils.h"
 #include "common/extent-tree-utils.h"
+#include "common/root-tree-utils.h"
 #include "mkfs/rootdir.h"
=20
 static u32 fs_block_size;
@@ -184,17 +185,58 @@ static void free_namelist(struct dirent **files, in=
t count)
 	free(files);
 }
=20
-static u64 calculate_dir_inode_size(const char *dirname)
+static u64 calculate_dir_inode_size(const char *src_dir,
+				    struct list_head *subvols,
+				    const char *dest_dir)
 {
 	int count, i;
 	struct dirent **files, *cur_file;
 	u64 dir_inode_size =3D 0;
+	struct rootdir_subvol *s;
=20
-	count =3D scandir(dirname, &files, directory_select, NULL);
+	count =3D scandir(src_dir, &files, directory_select, NULL);
=20
 	for (i =3D 0; i < count; i++) {
+		size_t name_len;
+
 		cur_file =3D files[i];
-		dir_inode_size +=3D strlen(cur_file->d_name);
+		name_len =3D strlen(cur_file->d_name);
+
+		/* Skip entry if it's going to be a subvol (it will be accounted
+		 * for in btrfs_link_subvolume). */
+		if (cur_file->d_type =3D=3D DT_DIR && !list_empty(subvols)) {
+			bool skip =3D false;
+
+			list_for_each_entry(s, subvols, list) {
+				if (!strcmp(dest_dir, "")) {
+					if (!strcmp(cur_file->d_name, s->destpath)) {
+						skip =3D true;
+						break;
+					}
+				} else {
+					if (s->destpath_len !=3D strlen(dest_dir) + 1 +
+					    name_len)
+						continue;
+
+					if (memcmp(s->destpath, dest_dir, strlen(dest_dir)))
+						continue;
+
+					if (s->destpath[strlen(dest_dir)] !=3D '/')
+						continue;
+
+					if (!memcmp(s->destpath + strlen(dest_dir) + 1,
+						    cur_file->d_name, name_len)) {
+						skip =3D true;
+						break;
+					}
+				}
+			}
+
+			if (skip)
+				continue;
+		}
+
+		dir_inode_size +=3D name_len;
 	}
=20
 	free_namelist(files, count);
@@ -207,7 +249,9 @@ static int add_inode_items(struct btrfs_trans_handle =
*trans,
 			   struct btrfs_root *root,
 			   struct stat *st, const char *name,
 			   u64 self_objectid,
-			   struct btrfs_inode_item *inode_ret)
+			   struct btrfs_inode_item *inode_ret,
+			   struct list_head *subvols,
+			   const char *dest_dir)
 {
 	int ret;
 	struct btrfs_inode_item btrfs_inode;
@@ -218,7 +262,7 @@ static int add_inode_items(struct btrfs_trans_handle =
*trans,
 	objectid =3D self_objectid;
=20
 	if (S_ISDIR(st->st_mode)) {
-		inode_size =3D calculate_dir_inode_size(name);
+		inode_size =3D calculate_dir_inode_size(name, subvols, dest_dir);
 		btrfs_set_stack_inode_size(&btrfs_inode, inode_size);
 	}
=20
@@ -430,7 +474,8 @@ end:
 }
=20
 static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, const char *dir_name)
+			      struct btrfs_root *root, const char *dir_name,
+			      struct list_head *subvols, const char *dest_dir)
 {
 	u64 root_dir_inode_size;
 	struct btrfs_inode_item *inode_item;
@@ -468,7 +513,8 @@ static int copy_rootdir_inode(struct btrfs_trans_hand=
le *trans,
 	leaf =3D path.nodes[0];
 	inode_item =3D btrfs_item_ptr(leaf, path.slots[0], struct btrfs_inode_i=
tem);
=20
-	root_dir_inode_size =3D calculate_dir_inode_size(dir_name);
+	root_dir_inode_size =3D calculate_dir_inode_size(dir_name, subvols,
+						       dest_dir);
 	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
=20
 	/* Unlike fill_inode_item, we only need to copy part of the attributes.=
 */
@@ -493,7 +539,9 @@ error:
=20
 static int traverse_directory(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root, const char *dir_name,
-			      struct directory_name_entry *dir_head)
+			      struct directory_name_entry *dir_head,
+			      struct list_head *subvols, const char *dest_dir,
+			      u64 *next_subvol_id)
 {
 	int ret =3D 0;
=20
@@ -519,12 +567,20 @@ static int traverse_directory(struct btrfs_trans_ha=
ndle *trans,
 		goto fail_no_dir;
 	}
=20
+	dir_entry->dest_dir =3D strdup(dest_dir);
+	if (!dir_entry->dest_dir) {
+		error_msg(ERROR_MSG_MEMORY, NULL);
+		ret =3D -ENOMEM;
+		goto fail_no_dir;
+	}
+
 	parent_inum =3D highest_inum + BTRFS_FIRST_FREE_OBJECTID;
 	dir_entry->inum =3D parent_inum;
 	list_add_tail(&dir_entry->list, &dir_head->list);
=20
-	ret =3D copy_rootdir_inode(trans, root, dir_name);
+	ret =3D copy_rootdir_inode(trans, root, dir_name, subvols, dest_dir);
 	if (ret < 0) {
+		free(dir_entry->dest_dir);
 		errno =3D -ret;
 		error("failed to copy rootdir inode: %m");
 		goto fail_no_dir;
@@ -555,7 +611,7 @@ static int traverse_directory(struct btrfs_trans_hand=
le *trans,
 		}
=20
 		for (i =3D 0; i < count; i++) {
-			char tmp[PATH_MAX];
+			char tmp[PATH_MAX], cur_dest[PATH_MAX];
=20
 			cur_file =3D files[i];
=20
@@ -570,6 +626,76 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
 				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
 			}
=20
+			if (S_ISDIR(st.st_mode)) {
+				if (!strcmp(parent_dir_entry->dest_dir, "")) {
+					strcpy(cur_dest, cur_file->d_name);
+				} else {
+					strcpy(cur_dest, parent_dir_entry->dest_dir);
+					strcat(cur_dest, "/");
+					strcat(cur_dest, cur_file->d_name);
+				}
+			}
+
+			if (!list_empty(subvols) && S_ISDIR(st.st_mode)) {
+				struct rootdir_subvol *s;
+				bool found =3D false;
+
+				list_for_each_entry(s, subvols, list) {
+					if (!strcmp(cur_dest, s->destpath)) {
+						found =3D true;
+						break;
+					}
+				}
+
+				if (found) {
+					struct btrfs_key key;
+					struct btrfs_root *new_root;
+					u64 objectid;
+
+					objectid =3D *next_subvol_id;
+
+					ret =3D btrfs_make_subvolume(trans, objectid);
+					if (ret < 0) {
+						error("failed to create subvolume: %d",
+						      ret);
+						goto out;
+					}
+
+					key.objectid =3D objectid;
+					key.type =3D BTRFS_ROOT_ITEM_KEY;
+					key.offset =3D (u64)-1;
+
+					new_root =3D btrfs_read_fs_root(trans->fs_info, &key);
+					if (IS_ERR(new_root)) {
+						error("unable to fs read root: %lu",
+						      PTR_ERR(new_root));
+						goto out;
+					}
+
+					(*next_subvol_id)++;
+
+					ret =3D btrfs_mkfs_fill_dir(trans, s->srcpath,
+								  new_root, subvols,
+								  s->destpath, next_subvol_id);
+
+					if (ret)
+						goto out;
+
+					ret =3D btrfs_link_subvolume(trans, root,
+							parent_inum,
+							path_basename(s->destpath),
+							strlen(path_basename(s->destpath)),
+							new_root);
+					if (ret) {
+						error("unable to link subvolume %s",
+						      path_basename(s->destpath));
+						goto out;
+					}
+
+					continue;
+				}
+			}
+
 			/*
 			 * We can not directly use the source ino number,
 			 * as there is a chance that the ino is smaller than
@@ -589,7 +715,8 @@ static int traverse_directory(struct btrfs_trans_hand=
le *trans,
=20
 			ret =3D add_inode_items(trans, root, &st,
 					      cur_file->d_name, cur_inum,
-					      &cur_inode);
+					      &cur_inode, subvols,
+					      cur_dest);
 			if (ret =3D=3D -EEXIST) {
 				if (st.st_nlink <=3D 1) {
 					error(
@@ -638,6 +765,15 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
 					goto fail;
 				}
 				dir_entry->inum =3D cur_inum;
+
+				dir_entry->dest_dir =3D strdup(cur_dest);
+				if (!dir_entry->dest_dir) {
+					free(dir_entry->path);
+					error_msg(ERROR_MSG_MEMORY, NULL);
+					ret =3D -ENOMEM;
+					goto fail;
+				}
+
 				list_add_tail(&dir_entry->list,
 					      &dir_head->list);
 			} else if (S_ISREG(st.st_mode)) {
@@ -661,6 +797,7 @@ static int traverse_directory(struct btrfs_trans_hand=
le *trans,
 		}
=20
 		free_namelist(files, count);
+		free(parent_dir_entry->dest_dir);
 		free(parent_dir_entry->path);
 		free(parent_dir_entry);
=20
@@ -680,10 +817,11 @@ fail_no_dir:
 	goto out;
 }
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)
+int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *so=
urce_dir,
+			struct btrfs_root *root, struct list_head *subvols,
+			const char* dest_dir, u64 *next_subvol_id)
 {
 	int ret;
-	struct btrfs_trans_handle *trans;
 	struct stat root_st;
 	struct directory_name_entry dir_head;
 	struct directory_name_entry *dir_entry =3D NULL;
@@ -697,41 +835,15 @@ int btrfs_mkfs_fill_dir(const char *source_dir, str=
uct btrfs_root *root)
=20
 	INIT_LIST_HEAD(&dir_head.list);
=20
-	trans =3D btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret =3D PTR_ERR(trans);
-		errno =3D -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		goto fail;
-}
-
-	ret =3D traverse_directory(trans, root, source_dir, &dir_head);
+	ret =3D traverse_directory(trans, root, source_dir, &dir_head,
+				 subvols, dest_dir, next_subvol_id);
 	if (ret) {
 		error("unable to traverse directory %s: %d", source_dir, ret);
 		goto fail;
 	}
-	ret =3D btrfs_commit_transaction(trans, root);
-	if (ret) {
-		errno =3D -ret;
-		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
-		goto out;
-	}
=20
 	return 0;
 fail:
-	/*
-	 * Since we don't have btrfs_abort_transaction() yet, uncommitted trans
-	 * will trigger a BUG_ON().
-	 *
-	 * However before mkfs is fully finished, the magic number is invalid,
-	 * so even we commit transaction here, the fs still can't be mounted.
-	 *
-	 * To do a graceful error out, here we commit transaction as a
-	 * workaround.
-	 * Since we have already hit some problem, the return value doesn't
-	 * matter now.
-	 */
-	btrfs_commit_transaction(trans, root);
 	while (!list_empty(&dir_head.list)) {
 		dir_entry =3D list_entry(dir_head.list.next,
 				       struct directory_name_entry, list);
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 8d5f6896..806c1d8e 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -33,10 +33,22 @@ struct directory_name_entry {
 	const char *dir_name;
 	char *path;
 	ino_t inum;
+	char *dest_dir;
 	struct list_head list;
 };
=20
-int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root)=
;
+struct rootdir_subvol {
+	struct list_head list;
+	char *dir;
+	char *srcpath;
+	size_t srcpath_len;
+	char *destpath;
+	size_t destpath_len;
+};
+
+int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *so=
urce_dir,
+			struct btrfs_root *root, struct list_head *subvols,
+			const char* dest_dir, u64 *next_subvol_id);
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_de=
v_size,
 			u64 meta_profile, u64 data_profile);
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_re=
t,
diff --git a/tests/mkfs-tests/034-rootdir-subvol/test.sh b/tests/mkfs-tes=
ts/034-rootdir-subvol/test.sh
new file mode 100755
index 00000000..ccd6893f
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


