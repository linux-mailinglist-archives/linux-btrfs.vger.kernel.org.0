Return-Path: <linux-btrfs+bounces-6040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31391C1F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AC281CAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9FB1CD5AB;
	Fri, 28 Jun 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rlltqUmW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CA1C230B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586709; cv=none; b=UzimLiWd2nhUA0/j56lFZAi1xvPVzmXdsophH0IO8WQGhAIVFtHdeOVEvLEiWXIXWj0aHShAna+aaEljjSI75gwvMhjtYAJIOkHkDh/G7WS1FS1B9zjns57mAV6rAf2JRZpU/sNa0SgmHPkYc9As9f8/ad7PsEB44RS36MQcdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586709; c=relaxed/simple;
	bh=wdQuDgu+iO+37x2Jo53YT21oS0H+jAQCGV5WCPe1Csc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mc77EcvzN6wf0rL233ZlJUTF58VglLtYUuZJsyV1HgUsO9gvjZmbl9l6SELZAZtMFNQY8URhKu75+HPyVzXmZlnKvxXz69GiVY1si+kp6E+gqLDXOd0Md7ot3oB5uFlbh93iLz87akD06oBmpmuCgyJTWaebAMQQIPQzFlft0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=rlltqUmW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA2O65016820
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=VmmW1bvPtWkXMhCe7v38iPKdKVdMmf01FrXriwWS5eo=; b=rll
	tqUmWvHKEo/CSoYR/M+8g+VM1kXokfjvl6OQONE2uQYn2M7yP/9w17NiJq85A1gu
	jbBmzkEgnOblDDuf5Aij77iIaWXI5SWaqC6ta0IXTBOMnL/emDdA/MAFT1M6KRjt
	ociUQtkHDSf+SXH01bMTn6svEAjBmWEe25+/mUPI=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 401j2g3qwq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:25 -0700 (PDT)
Received: from twshared48820.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 28 Jun 2024 14:58:22 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 9C7273B26711; Fri, 28 Jun 2024 15:58:18 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH 2/3] btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot
Date: Fri, 28 Jun 2024 15:56:48 +0100
Message-ID: <20240628145807.1800474-3-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: snsx-V09gjN4vaSbIRo4J0lJ0jtBrnIF
X-Proofpoint-GUID: snsx-V09gjN4vaSbIRo4J0lJ0jtBrnIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01

From: Omar Sandoval <osandov@fb.com>

Call btrfs_util_create_snapshot in cmd_subvolume_snapshot rather than
calling the ioctl directly.

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
Co-authored-by: Mark Harmstone <maharmstone@meta.com>

---
 cmds/subvolume.c | 94 +++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 61 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 8fa0d407..c668ae91 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -622,18 +622,11 @@ static int cmd_subvolume_snapshot(const struct cmd_=
struct *cmd, int argc, char *
 {
 	char	*subvol, *dst;
 	int	res, retval;
-	int	fd =3D -1, fddst =3D -1;
-	int	len;
-	bool readonly =3D false;
-	char	*dupname =3D NULL;
-	char	*dupdir =3D NULL;
-	const char *newname;
-	char	*dstdir;
+	char	*dstdir =3D NULL;
 	enum btrfs_util_error err;
-	struct btrfs_ioctl_vol_args_v2	args;
-	struct btrfs_qgroup_inherit *inherit =3D NULL;
+	struct btrfs_util_qgroup_inherit *inherit =3D NULL;
+	int flags =3D 0;
=20
-	memset(&args, 0, sizeof(args));
 	optind =3D 0;
 	while (1) {
 		int c =3D getopt(argc, argv, "i:r");
@@ -642,14 +635,14 @@ static int cmd_subvolume_snapshot(const struct cmd_=
struct *cmd, int argc, char *
=20
 		switch (c) {
 		case 'i':
-			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
+			res =3D qgroup_inherit_add_group(&inherit, optarg);
 			if (res) {
 				retval =3D res;
 				goto out;
 			}
 			break;
 		case 'r':
-			readonly =3D true;
+			flags |=3D BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -683,72 +676,51 @@ static int cmd_subvolume_snapshot(const struct cmd_=
struct *cmd, int argc, char *
 	}
=20
 	if (res > 0) {
+		char *dupname;
+		const char *newname;
+
 		dupname =3D strdup(subvol);
 		newname =3D path_basename(dupname);
-		dstdir =3D dst;
-	} else {
-		dupname =3D strdup(dst);
-		newname =3D path_basename(dupname);
-		dupdir =3D strdup(dst);
-		dstdir =3D path_dirname(dupdir);
-	}
-
-	if (!test_issubvolname(newname)) {
-		error("invalid snapshot name '%s'", newname);
-		goto out;
-	}
-
-	len =3D strlen(newname);
-	if (len > BTRFS_VOL_NAME_MAX) {
-		error("snapshot name too long '%s'", newname);
-		goto out;
-	}
=20
-	fddst =3D btrfs_open_dir(dstdir);
-	if (fddst < 0)
-		goto out;
-
-	fd =3D btrfs_open_dir(subvol);
-	if (fd < 0)
-		goto out;
+		dstdir =3D malloc(strlen(dst) + 1 + strlen(newname) + 1);
+		if (!dstdir) {
+			error("out of memory");
+			free(dupname);
+			goto out;
+		}
=20
-	if (readonly)
-		args.flags |=3D BTRFS_SUBVOL_RDONLY;
+		dstdir[0] =3D 0;
+		strcpy(dstdir, dst);
+		strcat(dstdir, "/");
+		strcat(dstdir, newname);
=20
-	args.fd =3D fd;
-	if (inherit) {
-		args.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
-		args.size =3D btrfs_qgroup_inherit_size(inherit);
-		args.qgroup_inherit =3D inherit;
+		free(dupname);
+	} else {
+		dstdir =3D strdup(dst);
 	}
-	strncpy_null(args.name, newname, sizeof(args.name));
=20
-	res =3D ioctl(fddst, BTRFS_IOC_SNAP_CREATE_V2, &args);
-	if (res < 0) {
-		if (errno =3D=3D ETXTBSY)
-			error("cannot snapshot '%s': source subvolume contains an active swap=
file (%m)", subvol);
-		else
-			error("cannot snapshot '%s': %m", subvol);
+	err =3D btrfs_util_create_snapshot(subvol, dstdir, flags, NULL, inherit=
);
+	if (err) {
+		error_btrfs_util(err);
 		goto out;
 	}
=20
 	retval =3D 0;	/* success */
=20
-	if (readonly)
+	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
 		pr_verbose(LOG_DEFAULT,
-			   "Create readonly snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);
+			   "Create readonly snapshot of '%s' in '%s'\n",
+			   subvol, dstdir);
 	else
 		pr_verbose(LOG_DEFAULT,
-			   "Create snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);
+			   "Create snapshot of '%s' in '%s'\n",
+			   subvol, dstdir);
=20
 out:
-	close(fddst);
-	close(fd);
-	free(inherit);
-	free(dupname);
-	free(dupdir);
+	free(dstdir);
+
+	if (inherit)
+		btrfs_util_destroy_qgroup_inherit(inherit);
=20
 	return retval;
 }
--=20
2.44.2


