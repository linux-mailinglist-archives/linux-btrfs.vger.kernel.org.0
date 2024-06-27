Return-Path: <linux-btrfs+bounces-6020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A791AB0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E7E289C5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AAB198A27;
	Thu, 27 Jun 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G53ro+ax"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF11946DD
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501738; cv=none; b=mMWbb6BVLhNyFImHAtTAbLSGT3qTn2X0aVr60zk1x7M7hEz6xHTRKLe29ecNy+Kq8eY9Ft3ZMt/0KQEIDx+WRlkqijx09+Rrkr7sd9HAHrVeah+8fb9obOQTek3CwRjIGuWYh8xPB3w+6fO1ZYsxWTgocLdsGbAvl3npvtip27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501738; c=relaxed/simple;
	bh=P688g9qd2+vl+A1IRVDTuWCpSqiHCzI0rvKwkVBhOsM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fYoL7wA98Il/+X4PV70Y2t+S/Saw/MVOWItK8HB4Q70nZWditQ9CuqX5e2pqr5Q5jnRJqUzwTSs10F/4natadG2aSNXNCOjKqW+GA5UH4NF2Iy0CgNyDt4+H8e8DxmeI89nqP5PEzYpgyDZ7h97NfXjCjrFjmtFOE7fpUlhZRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=G53ro+ax; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RDHDEa019535
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:22:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=facebook; bh=iwgZ/YgW
	9KTZUMV7t5sSIlOvAzOTWkUdMhYaZK3wB7w=; b=G53ro+axZmR/MAPzno/eiTF4
	jHtQNG1bKKYrOAR2yQieUyMbblr8Mws9KNnRQIjeH2PcIOsCIsBrxALDUXchJ8U/
	PWMis1OfhyXwa0xvZHZyPRYR6eWoKOIPvkWSy6WgXDNgQgSVdAzVewpOo4cxOHwC
	TdmHed6iKroVXKfDxfY=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4015w91twb-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 08:22:15 -0700 (PDT)
Received: from twshared19175.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 27 Jun 2024 15:22:06 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 662203A8B4F0; Thu, 27 Jun 2024 16:21:59 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH] btrfs-progs: add recursive subvol delete
Date: Thu, 27 Jun 2024 16:21:38 +0100
Message-ID: <20240627152156.1349692-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8EyJ2m7YNXMW0dZYBPGfr2Kjo9CRD8vq
X-Proofpoint-ORIG-GUID: 8EyJ2m7YNXMW0dZYBPGfr2Kjo9CRD8vq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01

From: Omar Sandoval <osandov@fb.com>

Adds a --recursive option to btrfs subvol delete, causing it to pass the
BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE flag through to libbtrfsutil.

This is a resubmission of part of a patch that Omar Sandoval sent in
2018, which appears to have been overlooked:
https://lore.kernel.org/linux-btrfs/e42cdc5d5287269faf4d09e8c9786d0b3adeb65=
8.1516991902.git.osandov@fb.com/

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
Co-authored-by: Mark Harmstone <maharmstone@meta.com>
---
 Documentation/btrfs-subvolume.rst |  4 ++++
 cmds/subvolume.c                  | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvol=
ume.rst
index d1e89f15..b1f22344 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -112,6 +112,10 @@ delete [options] [<subvolume> [<subvolume>...]], delet=
e -i|--subvolid <subvolid>
         -i|--subvolid <subvolid>
                 subvolume id to be removed instead of the <path> that shou=
ld point to the
                 filesystem with the subvolume
+
+        -R|--recursive
+                delete subvolumes beneath each subvolume recursively
+
         -v|--verbose
                 (deprecated) alias for global *-v* option
=20
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 52bc8850..b4151af2 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -347,6 +347,7 @@ static const char * const cmd_subvolume_delete_usage[] =
=3D {
 	OPTLINE("-c|--commit-after", "wait for transaction commit at the end of t=
he operation"),
 	OPTLINE("-C|--commit-each", "wait for transaction commit after deleting e=
ach subvolume"),
 	OPTLINE("-i|--subvolid", "subvolume id of the to be removed subvolume"),
+	OPTLINE("-R|--recursive", "delete subvolumes beneath each subvolume recur=
sively"),
 	OPTLINE("-v|--verbose", "deprecated, alias for global -v option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -367,6 +368,7 @@ static int cmd_subvolume_delete(const struct cmd_struct=
 *cmd, int argc, char **a
 	char	*path =3D NULL;
 	int commit_mode =3D 0;
 	bool subvol_path_not_found =3D false;
+	int flags =3D 0;
 	u8 fsid[BTRFS_FSID_SIZE];
 	u64 subvolid =3D 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
@@ -383,11 +385,12 @@ static int cmd_subvolume_delete(const struct cmd_stru=
ct *cmd, int argc, char **a
 			{"commit-after", no_argument, NULL, 'c'},
 			{"commit-each", no_argument, NULL, 'C'},
 			{"subvolid", required_argument, NULL, 'i'},
+			{"recursive", no_argument, NULL, 'R'},
 			{"verbose", no_argument, NULL, 'v'},
 			{NULL, 0, NULL, 0}
 		};
=20
-		c =3D getopt_long(argc, argv, "cCi:v", long_options, NULL);
+		c =3D getopt_long(argc, argv, "cCi:Rv", long_options, NULL);
 		if (c < 0)
 			break;
=20
@@ -401,6 +404,9 @@ static int cmd_subvolume_delete(const struct cmd_struct=
 *cmd, int argc, char **a
 		case 'i':
 			subvolid =3D arg_strtou64(optarg);
 			break;
+		case 'R':
+			flags |=3D BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE;
+			break;
 		case 'v':
 			bconf_be_verbose();
 			break;
@@ -416,6 +422,11 @@ static int cmd_subvolume_delete(const struct cmd_struc=
t *cmd, int argc, char **a
 	if (subvolid > 0 && check_argc_exact(argc - optind, 1))
 		return 1;
=20
+	if (subvolid > 0 && flags & BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE) {
+		error("option --recursive not supported with --subvolid");
+		return 1;
+	}
+
 	pr_verbose(LOG_INFO, "Transaction commit: %s\n",
 		   !commit_mode ? "none (default)" :
 		   commit_mode =3D=3D COMMIT_AFTER ? "at the end" : "after each");
@@ -528,7 +539,7 @@ again:
=20
 	/* Start deleting. */
 	if (subvolid =3D=3D 0)
-		err =3D btrfs_util_delete_subvolume_fd(fd, vname, 0);
+		err =3D btrfs_util_delete_subvolume_fd(fd, vname, flags);
 	else
 		err =3D btrfs_util_delete_subvolume_by_id_fd(fd, subvolid);
 	if (err) {
--=20
2.44.2


