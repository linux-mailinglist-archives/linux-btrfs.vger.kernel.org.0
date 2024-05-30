Return-Path: <linux-btrfs+bounces-5362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E28D44D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 07:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CEC283F1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 05:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB5143C54;
	Thu, 30 May 2024 05:38:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF38C06
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047513; cv=none; b=Pk/Rto9SsUOoM+L1b6FTazIE2FYfZC6QiDKJOEjHf9wfr3tqL6Uy4w8LgwE/+BThTm61tuF9qHeK4T2cjax06H3TfUV11JCrkr5rBXrGRRem1e9G0/wOxJ6O6kbw54YXzJ4KYTR8yGZDcGqE88DUdmzb7eGQr8opOnlmWPaDc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047513; c=relaxed/simple;
	bh=OBZDhoGEqHvluCUK3bRyFmP7g01YuYRrKeJkN6ft7xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BScwLx5uwLjp+/acUymg/zkZGmXAPSEiG0VRu/Y3lUFv3LrFlT1LuDD646DUjj50D8mkm1ULd6h/e9DT+r8nf/mFkkzDFJXyDQSmjhHjG/lMKdp7eSX4jreFqQpl2fFDGH7PloqxGGBmxXSBbCUhTn+LJgPD0gnfGvGYLZYPqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U2d9JG018007;
	Thu, 30 May 2024 05:38:26 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dl9yrS9/IXmJEgCDDVp3Srl?=
 =?UTF-8?Q?KiWHVGzkomqc/IMdK/VVw=3D;_b=3DJ6jlkAIJorXPzMz5Jbqw+eTMVL1VSzzvv?=
 =?UTF-8?Q?29S7gxp6o0EBzlBUJ/PKN3zAQopasGIFxLJ_rXK5mk8vW3hgxMo9TkADl/k1J+J?=
 =?UTF-8?Q?ygMbJFyOfd0O08rqrlXCL6leMYVG+H7KKIdMRaJ+e_XhjOzFaI343RhCha7/Ni3?=
 =?UTF-8?Q?ZW1jPbzI8GhOdok/GUHxJoBlL0UKRY2XrTnlyLLrQULSoOt_Z85LZX40MqI7CYB?=
 =?UTF-8?Q?1LWPEScVEWzQGqsdhwu1L89wXO554WPBZPBEV5uPzu2OS6RFUTHo3_b1pQ+h45o?=
 =?UTF-8?Q?IZtFfjJZ5XytKLy4YjqyVvUkOQcTWrpKMq7j3yxNY8sLIJ+rD5qpNpachG6_MA?=
 =?UTF-8?Q?=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8820s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 05:38:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U5W0gH006262;
	Thu, 30 May 2024 05:38:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c6f89p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 05:38:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U5XxBP035550;
	Thu, 30 May 2024 05:38:24 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yd7c6f82w-1;
	Thu, 30 May 2024 05:38:24 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Subject: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers support
Date: Thu, 30 May 2024 05:37:54 +0000
Message-Id: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-05-30_03,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300040
X-Proofpoint-ORIG-GUID: hOicm7XYemEH7aH5HUrGpH0YeziIo9Az
X-Proofpoint-GUID: hOicm7XYemEH7aH5HUrGpH0YeziIo9Az

In ext4, number of blocks can be greater than 2^32. Therefore, if
btrfs-convert is used on filesystems greater than or equal to 16TiB
(Staring from 16TiB, number of blocks overflow 32 bits), it fails to
convert.

Example:

Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.

[root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
btrfs-convert from btrfs-progs v5.15.1

convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
btrfs-convert(+0xfd04)[0xaaaaba44fd04]
btrfs-convert(main+0x258)[0xaaaaba44d278]
/lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
Aborted (core dumped)

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


