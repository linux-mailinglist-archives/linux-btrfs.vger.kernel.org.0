Return-Path: <linux-btrfs+bounces-6956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F617945D3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A80B218AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677781E2132;
	Fri,  2 Aug 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rrtPIDSN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279A1E2125
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598063; cv=none; b=nDCneA9ZI31KhRSeGCf7U5jp0Hi3DdLTAAkgYo2M8donHPdIP+80VKShBl644wU4YweJGftcGMJ+RsSW8DCKIfXO+fgEzBC4TttaotNbBxcEJyehFQ2AfpNnmz/SQWDa/pqhiwyiQO11jjEq+kvmQHkBtpYsd2GD8Sul6zzKsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598063; c=relaxed/simple;
	bh=ua9JIwMhqL7tcx6ddbdeHkhCeUIjgq8pOeTC0vjFBuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCTDGkkafYMYb3jOt0cl/Z72Ui2NSubLs3+1oJkMmAPg/6wSCWRtSH3gmlxr2lC15BoA7G7TLoz8KYv5r5sznV43P+K6XolYHxP4OoTAXS7Q0VQhlXxP0/z7oEu0R10tRcWupNXmDDm+KTznC6qkAzjAA6fcl2Fznbwhc8qhBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=rrtPIDSN; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472ANrLN011564
	for <linux-btrfs@vger.kernel.org>; Fri, 2 Aug 2024 04:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=8HodEiQ7ExVKMpWnx+LtIdDeEi52lh29QrYCFpR74t8=; b=rrt
	PIDSNdYqvPyW9p+IZvQWPw9wZGrVcgZ3Qd1bQ6taK6NLYftsySrIteD0/ylIF+6U
	syDu0Kl+1JXp4b9AIVyZr8g0u7mfKXV9Rlqxos7+wyAXbY3b5ymKJCk26xkrATUc
	rZzU3gnBp1OAE5AJVvpwUt2q44EH7iFomLs1CqzI=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40rjesm616-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 04:27:41 -0700 (PDT)
Received: from twshared18385.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 2 Aug 2024 11:27:39 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id A4A0F4FE0C0B; Fri,  2 Aug 2024 12:27:33 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@meta.com>,
        Mark Harmstone
	<maharmstone@fb.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 1/3] btrfs-progs: use libbtrfsutil for btrfs subvolume create
Date: Fri, 2 Aug 2024 12:27:22 +0100
Message-ID: <20240802112730.3575159-2-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240802112730.3575159-1-maharmstone@fb.com>
References: <20240802112730.3575159-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1gDypF3yJtuB_nGE0sacWhwV42DDVLUG
X-Proofpoint-ORIG-GUID: 1gDypF3yJtuB_nGE0sacWhwV42DDVLUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01

From: Mark Harmstone <maharmstone@meta.com>

Call btrfs_util_subvolume_create in create_one_subvolume rather than
calling the ioctl directly.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Co-authored-by: Omar Sandoval <osandov@fb.com>
---
 cmds/subvolume.c | 100 ++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 57 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index b4151af2..2a635fa2 100644
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
@@ -140,28 +141,15 @@ static const char * const cmd_subvolume_create_usag=
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
 	char	*dupname =3D NULL;
 	char	*dupdir =3D NULL;
 	const char *newname;
 	char	*dstdir;
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
+	enum btrfs_util_error err;
=20
 	dupname =3D strdup(dst);
 	if (!dupname) {
@@ -179,19 +167,6 @@ static int create_one_subvolume(const char *dst, str=
uct btrfs_qgroup_inherit *in
 	}
 	dstdir =3D path_dirname(dupdir);
=20
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
-
 	if (create_parents) {
 		char p[PATH_MAX] =3D { 0 };
 		char dstdir_dup[PATH_MAX];
@@ -223,47 +198,57 @@ static int create_one_subvolume(const char *dst, st=
ruct btrfs_qgroup_inherit *in
 		}
 	}
=20
-	fddst =3D btrfs_open_dir(dstdir);
-	if (fddst < 0) {
-		ret =3D fddst;
+	err =3D btrfs_util_subvolume_create(dst, 0, NULL, inherit);
+	if (err) {
+		error_btrfs_util(err);
+		ret =3D 1;
 		goto out;
 	}
=20
-	if (inherit) {
-		struct btrfs_ioctl_vol_args_v2	args;
+	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname);
=20
-		memset(&args, 0, sizeof(args));
-		strncpy_null(args.name, newname, sizeof(args.name));
-		args.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
-		args.size =3D btrfs_qgroup_inherit_size(inherit);
-		args.qgroup_inherit =3D inherit;
+	ret =3D 0;
=20
-		ret =3D ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
-	} else {
-		struct btrfs_ioctl_vol_args	args;
+out:
+	free(dupname);
+	free(dupdir);
+
+	return ret;
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
+		err =3D btrfs_util_qgroup_inherit_create(0, inherit);
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
@@ -281,7 +266,7 @@ static int cmd_subvolume_create(const struct cmd_stru=
ct *cmd, int argc, char **a
=20
 		switch (c) {
 		case 'i':
-			ret =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
+			ret =3D qgroup_inherit_add_group(&inherit, optarg);
 			if (ret) {
 				retval =3D ret;
 				goto out;
@@ -304,13 +289,14 @@ static int cmd_subvolume_create(const struct cmd_st=
ruct *cmd, int argc, char **a
=20
 	for (int i =3D optind; i < argc; i++) {
 		ret =3D create_one_subvolume(argv[i], inherit, create_parents);
-		if (ret < 0)
+		if (ret)
 			has_error =3D true;
 	}
 	if (!has_error)
 		retval =3D 0;
 out:
-	free(inherit);
+	if (inherit)
+		btrfs_util_qgroup_inherit_destroy(inherit);
=20
 	return retval;
 }
--=20
2.44.2


