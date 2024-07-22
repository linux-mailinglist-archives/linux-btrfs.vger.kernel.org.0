Return-Path: <linux-btrfs+bounces-6644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118519390B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2239128102B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6C1D551;
	Mon, 22 Jul 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z3sJliGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E868F70
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658772; cv=none; b=cZ41VLJwZAtZ3MAWiQ6TFNcYUndsKnBedD/Z2qBm0EVee6eVL86h9xnSw3UHfeXRarye27ohuBNlxcZpnKxQPhZDh5bA8mrvR/EYyvgHhESUlmmYq5USJbeubh3TyrDBGdVvFzlEXADE6chIs3ppqmYQles7avVoGXOPqiq2yfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658772; c=relaxed/simple;
	bh=xHasprSMyD07uRTgPEpKEf/XpSnTc64H1rLjfRC9TAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJgx40kjmHyM3Lp3vfNyYgCmhE7HvKaNfb5TQbczrlAqqjxFjGwYRJGFKzHuV4OZ/mpOeMsY5OVdCxce5U3O4FrkOuzguG9JGrTqPAD7b+Bg55xcSeFMVUyBO9JlBoQRvJtphiPl0S+I4BPRBhPh6cHaWUHp/2yuxWFHDJMYB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Z3sJliGe; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46MCNFuS015075
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:32:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=yyGsRmOz
	fZcft3dkYY2lUfS3vJ8kUrN7kMrB9unqGOk=; b=Z3sJliGeatqVnMVhsA0O2Kld
	zRdQqfvJLbI+jZUMJOJ25GIEb1tC7j0XQevz54XNmLWrI6Xx7r5R+7TqVNu4YhLL
	j5O6dOXeKmQ0nRY+iLsdFDX5BAMH7aQkSLbbrbu8r6AmTexRnnbsGttDW6jyBstQ
	uUu0IvB9lTD2BthKsOY=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 40g8wr07jv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:32:49 -0700 (PDT)
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 14:32:43 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 1603D493D640; Mon, 22 Jul 2024 15:32:40 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v2] btrfs-progs: simplify mkfs_main cleanup
Date: Mon, 22 Jul 2024 15:32:24 +0100
Message-ID: <20240722143235.1022223-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: 9_BypJ2w6SGEUwzX8ybKfEk2BD089YJR
X-Proofpoint-GUID: 9_BypJ2w6SGEUwzX8ybKfEk2BD089YJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

mkfs_main is a main-like function, meaning that return and exit are
equivalent. Deduplicate our cleanup code by moving the error label.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 mkfs/main.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a69aa24b..a721acde 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1158,6 +1158,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					error("unrecognized filesystem feature '%s'",
 							tmp);
 					free(orig);
+					ret =3D 1;
 					goto error;
 				}
 				free(orig);
@@ -1179,6 +1180,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					error("unrecognized runtime feature '%s'",
 					      tmp);
 					free(orig);
+					ret =3D 1;
 					goto error;
 				}
 				free(orig);
@@ -1245,8 +1247,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
=20
 	if (!sectorsize)
 		sectorsize =3D (u32)SZ_4K;
-	if (btrfs_check_sectorsize(sectorsize))
+	if (btrfs_check_sectorsize(sectorsize)) {
+		ret =3D 1;
 		goto error;
+	}
=20
 	if (!nodesize)
 		nodesize =3D max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
@@ -1261,10 +1265,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
=20
 	if (source_dir && device_count > 1) {
 		error("the option -r is limited to a single device");
+		ret =3D 1;
 		goto error;
 	}
 	if (shrink_rootdir && source_dir =3D=3D NULL) {
 		error("the option --shrink must be used with --rootdir");
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1273,11 +1279,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
=20
 		if (uuid_parse(fs_uuid, dummy_uuid) !=3D 0) {
 			error("could not parse UUID: %s", fs_uuid);
+			ret =3D 1;
 			goto error;
 		}
 		/* We allow non-unique fsid for single device btrfs filesystem. */
 		if (device_count !=3D 1 && !test_uuid_unique(fs_uuid)) {
 			error("non-unique UUID: %s", fs_uuid);
+			ret =3D 1;
 			goto error;
 		}
 	}
@@ -1287,12 +1295,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
=20
 		if (uuid_parse(dev_uuid, dummy_uuid) !=3D 0) {
 			error("could not parse device UUID: %s", dev_uuid);
+			ret =3D 1;
 			goto error;
 		}
 		/* We allow non-unique device uuid for single device filesystem. */
 		if (device_count !=3D 1 && !test_uuid_unique(dev_uuid)) {
 			error("the option --device-uuid %s can be used only for a single devi=
ce filesystem",
 			      dev_uuid);
+			ret =3D 1;
 			goto error;
 		}
 	}
@@ -1356,6 +1366,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			if (metadata_profile !=3D data_profile) {
 				error(
 	"with mixed block groups data and metadata profiles must be the same");
+				ret =3D 1;
 				goto error;
 			}
 		}
@@ -1425,12 +1436,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			warning("libblkid < 2.38 does not support zoned mode's superblock loc=
ation, update recommended");
 	}
=20
-	if (btrfs_check_nodesize(nodesize, sectorsize, &features))
+	if (btrfs_check_nodesize(nodesize, sectorsize, &features)) {
+		ret =3D 1;
 		goto error;
+	}
=20
 	if (sectorsize < sizeof(struct btrfs_super_block)) {
 		error("sectorsize smaller than superblock: %u < %zu",
 				sectorsize, sizeof(struct btrfs_super_block));
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1461,6 +1475,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					 S_IROTH);
 		if (fd < 0) {
 			error("unable to open %s: %m", file);
+			ret =3D 1;
 			goto error;
 		}
=20
@@ -1506,6 +1521,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("size %llu is too small to make a usable filesystem", byte_count=
);
 		error("minimum size for a %sbtrfs filesystem is %llu",
 		      opt_zoned ? "zoned mode " : "", min_dev_size);
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1559,6 +1575,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		if (!zoned_profile_supported(metadata, rst) ||
 		    !zoned_profile_supported(data, rst)) {
 			error("zoned mode does not yet support the selected RAID profiles");
+			ret =3D 1;
 			goto error;
 		}
 	}
@@ -1568,6 +1585,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
=20
 	if (!t_prepare || !prepare_ctx) {
 		error_msg(ERROR_MSG_MEMORY, "thread for preparing devices");
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1609,6 +1627,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (byte_count && byte_count > dev_byte_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
 		      file, byte_count, dev_byte_count);
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1652,6 +1671,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	fs_info =3D open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("open ctree failed");
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1675,6 +1695,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (IS_ERR(trans)) {
 		errno =3D -PTR_ERR(trans);
 		error_msg(ERROR_MSG_START_TRANS, "%m");
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1709,6 +1730,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (IS_ERR(trans)) {
 		errno =3D -PTR_ERR(trans);
 		error_msg(ERROR_MSG_START_TRANS, "%m");
+		ret =3D 1;
 		goto error;
 	}
=20
@@ -1728,6 +1750,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		if (prepare_ctx[i].ret) {
 			errno =3D -prepare_ctx[i].ret;
 			error("unable to prepare device %s: %m", prepare_ctx[i].file);
+			ret =3D 1;
 			goto error;
 		}
=20
@@ -1776,6 +1799,7 @@ raid_groups:
 	if (IS_ERR(trans)) {
 		errno =3D -PTR_ERR(trans);
 		error_msg(ERROR_MSG_START_TRANS, "%m");
+		ret =3D 1;
 		goto error;
 	}
 	/* COW all tree blocks to newly created chunks */
@@ -1915,6 +1939,8 @@ out:
 	}
=20
 	btrfs_close_all_devices();
+
+error:
 	if (prepare_ctx) {
 		for (i =3D 0; i < device_count; i++)
 			close(prepare_ctx[i].fd);
@@ -1926,16 +1952,6 @@ out:
=20
 	return !!ret;
=20
-error:
-	if (prepare_ctx) {
-		for (i =3D 0; i < device_count; i++)
-			close(prepare_ctx[i].fd);
-	}
-	free(t_prepare);
-	free(prepare_ctx);
-	free(label);
-	free(source_dir);
-	exit(1);
 success:
 	exit(0);
 }
--=20
2.44.2


