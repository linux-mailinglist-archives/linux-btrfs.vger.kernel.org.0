Return-Path: <linux-btrfs+bounces-5500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED48FE427
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218D71F2746D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC77194AF6;
	Thu,  6 Jun 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXkkNttw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA914A63D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669347; cv=none; b=QO+xRp2OY+FqmgMkngV+R7+tJEHupTSQaBf1P6rBY3AEAef1C4dFvT4WznFKN+6D+t8yboOnJzJ1mKfBic6wNDsGkTehDwwiLhBcmzdfj19zA/n4bP8R5EfCArSLXrrIOAfkSvtjzkqkxSesVZSs0mjzNSIsHHnMF9t1sKBMfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669347; c=relaxed/simple;
	bh=L9nSrDGjHLhnmL+vJ1+zW5n9Lgp4cweP1Z8b4W41h+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gn69M1NvyiFufphA8T8/y2KNugzbIUaIDo00UbhiCOv02WGpiQzP1v+dl5pU0Fx7IReGfzp43N36KnpH0V05fuSKGo/YdkeX0MKeb0gYdTaMmZ2QJlNSUdu02ancyCpZ9ynEp0j1m5U7irFFZFbHEcWETeFfDBEroynrLrLlsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXkkNttw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iCnF032436;
	Thu, 6 Jun 2024 10:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=QFANULcY/rLn8An0Max6gmQ00ELxOynZoOb4ihJyQX8=;
 b=fXkkNttwJPDxzE+AfamfdpA9oH4d72zkSPTKxgqJTiG3HkoovKVzK9HzE8jHtNHY/8C6
 eDQ3DO5HN+IpHLisTN4ne13/pdMS0UZwdhws3oZi3K36iJ3PUsVP5ocz/TVO7YNuOW4z
 W4lQ6OXsIUHE9ATVqlhuxyFGQziMz07z4rPOxHzIedrCnUemc+9hPAeYljo9YfG1GeZW
 eC4TcAb/+yfTHFtOoeaCrbBVZMvAsVXEjgcvPVpOvd+GB+3qrYrNKDrZNJl2gaYNej0k
 aZDR+GQ37d03jIlwKQsQPtF2GpA7SrKEN3XmxLrAVvPv/O5/h63MyE30vurpAAB6AYE6 Lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrsb665-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:22:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4568fTAA005653;
	Thu, 6 Jun 2024 10:22:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmg9b6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:22:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456AMJ3x012952;
	Thu, 6 Jun 2024 10:22:19 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrmg9b6m-1;
	Thu, 06 Jun 2024 10:22:19 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Date: Thu,  6 Jun 2024 10:22:15 +0000
Message-Id: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060076
X-Proofpoint-ORIG-GUID: wCNFwVM6Rg8H8P7Omab9kBVE2eqHjhxG
X-Proofpoint-GUID: wCNFwVM6Rg8H8P7Omab9kBVE2eqHjhxG

In ext4, number of blocks can be greater than 2^32. Therefore, if
btrfs-convert is used on filesystems greater than 16TiB (Staring from
16TiB, number of blocks overflow 32 bits), it fails to convert.

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
index d204aac5..62c9b1fa 100644
--- a/convert/source-ext2.h
+++ b/convert/source-ext2.h
@@ -46,7 +46,7 @@ struct btrfs_trans_handle;
 #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
 #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
 #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
-#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
+#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count)
 #define EXT2FS_CLUSTER_RATIO(fs)	(1)
 #define EXT2_CLUSTERS_PER_GROUP(s)	(EXT2_BLOCKS_PER_GROUP(s))
 #define EXT2FS_B2C(fs, blk)		(blk)
-- 
2.39.3


