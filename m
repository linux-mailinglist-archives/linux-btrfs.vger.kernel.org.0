Return-Path: <linux-btrfs+bounces-6042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C926791C1F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587161F24DA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1931C68B5;
	Fri, 28 Jun 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a48CjYxp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE771C2310
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586709; cv=none; b=mYsm9owKfKPMiCYuHHDj7jlWR3fxLnp4CnmCLJzMWnuq6+OUPjxjeCiEUdPmAiVO2nfnTH3jHyGQKbjCK7nf0JpzSj6flvewQKeyexu8Pwo6ZJT/djgHCpd3uXe3RLb4lzI1hBqPr+uQfM9EK4iSWF6VG/rzXr/wsgZZqAHey5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586709; c=relaxed/simple;
	bh=V1v5Y1qvJsmErKP6eACPBZmmln2eDlfF8LdIb+V+BSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDEnnZhbg9PtaIJSlwFT5ro3HJzyqo5gZuIlwXGGvLFzjI0sSCjQIdrGT9KsT2Erte0jKDYOPz83kz7H6QdF9xNZRZ2NdM3b0OVWmmumOQKJtMUR4rt2f53emeFOfkRu1qqTRpVLZNx8FLv7F7QSslZ+u8Hqk6TIChheM0NKEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=a48CjYxp; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA2YbG010220
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=RcgqlsiejS1+Zj59bYvDBllgmGWEMxCRDauiY4blxVE=; b=a48
	CjYxpShEiMp8H5CjvNceaBvQRUFN5ZwonGalHlTRNKsqtLiNMfRC4P1KxzlvN2vf
	9WP1Jx6AAQoZOTuPgPeMr38eZ0P45BQ22d4rvf6eK5SwuF3LAuKtqc9DAQiKCRLr
	ehBo93c7Hi/D4nQLpkvK8X3H8obp73GDDQomNp8k=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 401grkv7sp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:27 -0700 (PDT)
Received: from twshared13822.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 28 Jun 2024 14:58:25 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id C72F33B2670E; Fri, 28 Jun 2024 15:58:17 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH 1/3] btrfs-progs: use libbtrfsutil for btrfs subvolume create
Date: Fri, 28 Jun 2024 15:56:47 +0100
Message-ID: <20240628145807.1800474-2-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628145807.1800474-1-maharmstone@fb.com>
References: <20240628145807.1800474-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: C7MKq1cQ4jj8Ent8vPdSEjGWd12B3KLI
X-Proofpoint-ORIG-GUID: C7MKq1cQ4jj8Ent8vPdSEjGWd12B3KLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01

From: Omar Sandoval <osandov@fb.com>

Call btrfs_util_create_subvolume in create_one_subvolume rather than
calling the ioctl directly.

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
Co-authored-by: Mark Harmstone <maharmstone@meta.com>

---
 cmds/subvolume.c | 133 +++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 80 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index b4151af2..8fa0d407 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -46,6 +46,7 @@
 #include "common/units.h"
 #include "common/format-output.h"
 #include "common/tree-search.h"
+#include "common/parse-utils.h"
 #include "cmds/commands.h"
 #include "cmds/qgroup.h"
=20
@@ -140,63 +141,27 @@ static const char * const cmd_subvolume_create_usag=
e[] =3D {
 	NULL
 };
=20
-static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inh=
erit *inherit,
+static int create_one_subvolume(const char *dst, struct btrfs_util_qgrou=
p_inherit *inherit,
 				bool create_parents)
 {
 	int ret;
-	int len;
-	int	fddst =3D -1;
-	char	*dupname =3D NULL;
-	char	*dupdir =3D NULL;
-	const char *newname;
-	char	*dstdir;
-
-	ret =3D path_is_dir(dst);
-	if (ret < 0 && ret !=3D -ENOENT) {
-		errno =3D -ret;
-		error("cannot access %s: %m", dst);
-		goto out;
-	}
-	if (ret >=3D 0) {
-		error("target path already exists: %s", dst);
-		ret =3D -EEXIST;
-		goto out;
-	}
-
-	dupname =3D strdup(dst);
-	if (!dupname) {
-		error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);
-		ret =3D -ENOMEM;
-		goto out;
-	}
-	newname =3D path_basename(dupname);
-
-	dupdir =3D strdup(dst);
-	if (!dupdir) {
-		error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);
-		ret =3D -ENOMEM;
-		goto out;
-	}
-	dstdir =3D path_dirname(dupdir);
-
-	if (!test_issubvolname(newname)) {
-		error("invalid subvolume name: %s", newname);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	len =3D strlen(newname);
-	if (len > BTRFS_VOL_NAME_MAX) {
-		error("subvolume name too long: %s", newname);
-		ret =3D -EINVAL;
-		goto out;
-	}
+	enum btrfs_util_error err;
=20
 	if (create_parents) {
 		char p[PATH_MAX] =3D { 0 };
 		char dstdir_dup[PATH_MAX];
+		char *dupdir =3D NULL;
+		char *dstdir;
 		char *token;
=20
+		dupdir =3D strdup(dst);
+		if (!dupdir) {
+			error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);
+			free(dupdir);
+			return -ENOMEM;
+		}
+		dstdir =3D path_dirname(dupdir);
+
 		strncpy_null(dstdir_dup, dstdir, sizeof(dstdir_dup));
 		if (dstdir_dup[0] =3D=3D '/')
 			strcat(p, "/");
@@ -209,61 +174,68 @@ static int create_one_subvolume(const char *dst, st=
ruct btrfs_qgroup_inherit *in
 				ret =3D mkdir(p, 0777);
 				if (ret < 0) {
 					error("failed to create directory %s: %m", p);
-					goto out;
+					free(dupdir);
+					return ret;
 				}
 			} else if (ret <=3D 0) {
 				if (ret =3D=3D 0)
 					ret =3D -EEXIST;
 				errno =3D ret ;
 				error("failed to check directory %s before creation: %m", p);
-				goto out;
+				free(dupdir);
+				return ret;
 			}
 			strcat(p, "/");
 			token =3D strtok(NULL, "/");
 		}
-	}
=20
-	fddst =3D btrfs_open_dir(dstdir);
-	if (fddst < 0) {
-		ret =3D fddst;
-		goto out;
+		free(dupdir);
 	}
=20
-	if (inherit) {
-		struct btrfs_ioctl_vol_args_v2	args;
+	pr_verbose(LOG_DEFAULT, "Create subvolume '%s'\n", dst);
=20
-		memset(&args, 0, sizeof(args));
-		strncpy_null(args.name, newname, sizeof(args.name));
-		args.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
-		args.size =3D btrfs_qgroup_inherit_size(inherit);
-		args.qgroup_inherit =3D inherit;
+	err =3D btrfs_util_create_subvolume(dst, 0, NULL, inherit);
+	if (err) {
+		error_btrfs_util(err);
+		return 1;
+	}
=20
-		ret =3D ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
-	} else {
-		struct btrfs_ioctl_vol_args	args;
+	return 0;
+}
+
+static int qgroup_inherit_add_group(struct btrfs_util_qgroup_inherit **i=
nherit,
+				    const char *arg)
+{
+	enum btrfs_util_error err;
+	u64 qgroupid;
=20
-		memset(&args, 0, sizeof(args));
-		strncpy_null(args.name, newname, sizeof(args.name));
-		ret =3D ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE, &args);
+	if (!*inherit) {
+		err =3D btrfs_util_create_qgroup_inherit(0, inherit);
+		if (err) {
+			error_btrfs_util(err);
+			return -1;
+		}
 	}
=20
-	if (ret < 0) {
-		error("cannot create subvolume: %m");
-		goto out;
+	qgroupid =3D parse_qgroupid_or_path(optarg);
+	if (qgroupid =3D=3D 0) {
+		error("invalid qgroup specification, qgroupid must not be 0");
+		return -1;
 	}
-	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname);
=20
-out:
-	close(fddst);
-	free(dupname);
-	free(dupdir);
+	err =3D btrfs_util_qgroup_inherit_add_group(inherit, qgroupid);
+	if (err) {
+		error_btrfs_util(err);
+		return -1;
+	}
=20
-	return ret;
+	return 0;
 }
+
 static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, =
char **argv)
 {
 	int retval, ret;
-	struct btrfs_qgroup_inherit *inherit =3D NULL;
+	struct btrfs_util_qgroup_inherit *inherit =3D NULL;
 	bool has_error =3D false;
 	bool create_parents =3D false;
=20
@@ -281,7 +253,7 @@ static int cmd_subvolume_create(const struct cmd_stru=
ct *cmd, int argc, char **a
=20
 		switch (c) {
 		case 'i':
-			ret =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
+			ret =3D qgroup_inherit_add_group(&inherit, optarg);
 			if (ret) {
 				retval =3D ret;
 				goto out;
@@ -310,7 +282,8 @@ static int cmd_subvolume_create(const struct cmd_stru=
ct *cmd, int argc, char **a
 	if (!has_error)
 		retval =3D 0;
 out:
-	free(inherit);
+	if (inherit)
+		btrfs_util_destroy_qgroup_inherit(inherit);
=20
 	return retval;
 }
--=20
2.44.2


