Return-Path: <linux-btrfs+bounces-5288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C958CEE86
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 May 2024 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653221C20AC5
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 May 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430E2AF18;
	Sat, 25 May 2024 10:31:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3482B644
	for <linux-btrfs@vger.kernel.org>; Sat, 25 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716633098; cv=none; b=k5GMewu8RWXND9C4HWau997805+N61dxyZO0WsHfR7w+VZMXC0yvmCGVWi5yfb4420PD7UleG0syr58+RO1HLTrWb/DHKEJqt+p5BwdNuKZExL5rpi2Lr3aQh6QSl09Y0Nb5+qkp8TLsGJuH5bW9UMj+l6EP7a7TXmTxqZZvODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716633098; c=relaxed/simple;
	bh=R4MIrKJ7oX6LBiNxSxZiUXy3x1sDTPG6KgKLM+z85xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5h/CuM2k8yBx5VhgJz8H1aWsnE4EiS2SZ+lllMJ6vcCWG1PiT4i/QYepjIH7/WHFupUwHfuhD6rumJen//4CVkGyk8gqOEGrgWHXVQwMDS94hPSiOP+0X71IZof8vhStwYfl9xkOZgMjUdxSTeTqozd/Stsr6ujSMfSt5+OWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44P9cSPH013047;
	Sat, 25 May 2024 10:31:32 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DeXfu4M3d8qn+vUVDB/zHAh?=
 =?UTF-8?Q?oQiqkI/9w42oulx8O5gdY=3D;_b=3DbIq+2UWOw5qnOB38xOcf6JTJZtx3ntRVh?=
 =?UTF-8?Q?xEMbVFATwZfJB1P1wxj5vVfDIGaXPaFd9T8_JMH3T5glGgky0kabQOqzYLX+3Ry?=
 =?UTF-8?Q?FRIFgDZXxUa3dv5Ez6aF56H+B6yOvA43a+92+RjYG_x70gsXoLpU3Pt5/+FGr7/?=
 =?UTF-8?Q?QXRsPGOFYB8cPrGxSFvLyM3L/GOkX8KnvdipNzLnaLNrszU_UY2LAh9kUdiUZMY?=
 =?UTF-8?Q?eK2uXnX6QauiUjylaDjCu8gyqEXhgqnIwrH56BB+NPeuz2VMpUxaJ_xbgAlm1ge?=
 =?UTF-8?Q?vdeHZjFD04kepgGqmIpF38CpqyrFOjk12+mzaBbhclCy6KlZLHZ9y66pbSo_4Q?=
 =?UTF-8?Q?=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7g7tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 May 2024 10:31:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44P8ZQhq038682;
	Sat, 25 May 2024 10:31:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yb6e4833k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 May 2024 10:31:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44PAVVEu037814;
	Sat, 25 May 2024 10:31:31 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yb6e4833b-1;
	Sat, 25 May 2024 10:31:30 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH] btrfs-progs: convert: Add 64 bit block numbers support
Date: Sat, 25 May 2024 10:31:13 +0000
Message-Id: <20240525103113.2623372-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-25_05,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405250083
X-Proofpoint-ORIG-GUID: hqY29RyIEI4E5ffeCuT3ipfQgMf8YCFg
X-Proofpoint-GUID: hqY29RyIEI4E5ffeCuT3ipfQgMf8YCFg

In ext4, number of blocks can be greater than 2^32. Therefore, if
btrfs-convert is used on filesystems greater than 16TiB (Staring from
16TiB, number of blocks overflow 32 bits), it fails to convert.

Fix it by considering 64 bit block numbers.

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 convert/source-ext2.c | 6 +++---
 convert/source-ext2.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 2186b252..afa48606 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -288,8 +288,8 @@ error:
 	return -1;
 }
 
-static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
-			        e2_blkcnt_t blockcnt, blk_t ref_block,
+static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
+			        e2_blkcnt_t blockcnt, blk64_t ref_block,
 			        int ref_offset, void *priv_data)
 {
 	int ret;
@@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
 			convert_flags & CONVERT_FLAG_DATACSUM);
 
-	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
+	err = ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
 				    NULL, ext2_block_iterate_proc, &data);
 	if (err)
 		goto error;
diff --git a/convert/source-ext2.h b/convert/source-ext2.h
index d204aac5..73c39e23 100644
--- a/convert/source-ext2.h
+++ b/convert/source-ext2.h
@@ -46,7 +46,7 @@ struct btrfs_trans_handle;
 #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
 #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
 #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
-#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
+#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count
 #define EXT2FS_CLUSTER_RATIO(fs)	(1)
 #define EXT2_CLUSTERS_PER_GROUP(s)	(EXT2_BLOCKS_PER_GROUP(s))
 #define EXT2FS_B2C(fs, blk)		(blk)
-- 
2.39.3


