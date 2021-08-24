Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7183F577F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhHXFGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:06:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2194 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhHXFGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:06:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0xBXE012043;
        Tue, 24 Aug 2021 05:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=28ARWY1xI/Q2sM+D31TyyswewjaVeomvGMErPL0otgI=;
 b=oURwg0je+9ptwrs4/VPcJ30mZsWO3OyHVFeHpLj4kXRQTrcNKXCPjrqKYwcz+Uo0pdVo
 roWIiItAQkVLxznb4auH9yfy1gKnuwi5Otn15QKrWCTxAbBIq6My9XXrfCvjAfdEDRzD
 zh1swpdYsQxpv1bitBXsYX1dEqZd459xHAUgDdlGynb2YtPDm2CxNWN3+zou4yCTUEgm
 5tiraJwH6SHhfHPOv0lMrPAcPMPB+UYzi9IMjMfx9rvFOJ8umi1CippgF2zFMwFPb5JM
 bQd1xALBEPLn9GS2LN8jwY10UnIeSNg0PGz4OjntgzIyPpj9Zgw6DkKrL4ww1WdxWHmu IQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=28ARWY1xI/Q2sM+D31TyyswewjaVeomvGMErPL0otgI=;
 b=dg84Z2EIQkVqhUEtWRvPf7yBwhySSSpNWKTHh7EFgdRWb0M08xanbK/ecEFhbtUWHgDQ
 hJv1HIVHAsp1LIEhd3836tnTVALLNz+UKXeEJ/CHlZSC5LIUE0uSyFx5vjzbdPBP32xu
 cBoNd261W4YLv6mXXZDBBCVsGlVTYoUW1UGV+TgbPWv88hd4zQ5NVI8Xqc3k4SVfEKUg
 Jd3FPu1pj/ixQWA0WKe4M52Ct+EFlkzOzIJ/AXmQUftaSNtUatIs7b+MIGcQCop/P5kD
 Q9BiD1cso2AFJ4CUrh7ltU50TrFNc33CLTbFg0t1XDRYEbyEaOTBf4+Mgz4OtlzYmvea Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7nbabb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O55OmE062250;
        Tue, 24 Aug 2021 05:05:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3akb8u1jay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Vol4DS+c0pDhCHW57kghYlzsaFpvanVbtIEmnz4jf9fugsPCxSboDZvLgbMOEiNsjmoX3jj73ZuxU/c3cioXiA+xNu4+Ww/YSORQUoGxiF3tzW2n+RYwT3gTsRY/3HWXhILpHF1HVMQRNRAI9xNs+v8KeOp72bua//VMNGh6nA3BzNaXWu5l5Z0ScXtCVzRbOIHm58THqgKcImKEaK2ljCjtYrd6oWesZNdJEojJuC1LAHSRYNQMhGu0gFhdQfoACusgJTUuedNcLJU9lQEzYVCVusr/aUazSlUDVAC7kVQLMaETNkWxAjX/pQJAMJrwnWcIBpMwP+fUvsVt5sJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ARWY1xI/Q2sM+D31TyyswewjaVeomvGMErPL0otgI=;
 b=LaVs8E26jLdAQQkk8DM9A7TOtcrXaZRZq91WiMYQUK7Z14DI0J88CzMGQ90CpY0urqWtkmNVCbYznSQgeSCbV2mjsqNisAppNLzT5kDaj+zu8RVsXArtxeD5MgQHyeaZJRsT78t6iTSQ7wTVlUKj+OufQgWGDlucXoFCXpHL+bvHQpFUMqUuyi2EEdGCAU5D/eqZRF03x2bSDhclXElWCtvKcacgP6uJZe6v5uwTyQlJ61cX98FlBFkg2IIqYxZAICISzB4nRrUEMGxcjb65rf3Lx6ync4ZRmRKyvl/alVTAvGTVU0bByWM/GNA0BhjEGNEpfuCBr+dfVfAGHvmntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ARWY1xI/Q2sM+D31TyyswewjaVeomvGMErPL0otgI=;
 b=pHHEXHcb8W+kPCafFHQq5PXc5275q37XoPv21b+uz4QKtQ6z3FPC7Bh0tpazS9f9mmQCCJOz+30MForEtbg3PUYSaSAb3jo4yfqCgBrQkz/6Mbz9bfa7RNFJEdsl2ZUH2ErpiytoDnWhlrPbrXyjKanHYy5UzRTJVTIPTjEtBGg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 05:05:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:05:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH V5 1/4] btrfs: convert latest_bdev type to struct btrfs_device and rename
Date:   Tue, 24 Aug 2021 13:05:19 +0800
Message-Id: <34dc747f52cf2fef1f851c163cc619889d1fd852.1629780501.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629780501.git.anand.jain@oracle.com>
References: <cover.1629780501.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Tue, 24 Aug 2021 05:05:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 958e67ce-b7a6-44ee-521f-08d966bcd178
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3428EA0AFD0C49DBE91FE68DE5C59@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkIrTvwrhoRVhI+c1itP5PrPt0ARLd9jqqRLJnrbbhOkWFj66X3/uHwDDEYxPlzqW0nus6vpMhHfVS7ewrcswERKXy8NlR8fVpFSMoQyHGpoLboIdBN+xyIPzfoqRUvfVOom3hBf38emThZgXqfLXlDxwgX74/eO14CqL6mCwGrRf9Rb9vLNzIWfhnWNqciX3O7CUj4yob8bqa1hfQJo99mt4uaJVVczvRRFKpWdj6D61o383ZW3nah++M1Nerdttz+ZWL12Fw7ZlXx1yk959H5+MkwOhkBG+fW8AKndpJkMU3KSG8lwaZBiDaH5jtLp+OakpC6Gojtsab9jVTQVAZEk7e4HWN9j3Ahx7PMqkn6hfNeHDb699DXGfEpbvk6iRBdrayIFBE536o280uybJwKraUzqyW2gwS7r10bXu8HbyR7PUXbXX9xoAWpDaQpv5XJ+urj+7gaVsKMgVEK8mzRvn8dbpZkuzyuhUZ9p2d7wm8WttVldvMOBSoo0HnZkJ4/6bDOlgrO6sM2B6Jrp7ck91UxGh87LajM1UUpsvvnh3ELV9cbTeBj7ibVesGV2Pyetp9PmH3AVkhPP0IFFbxq2006QFYoNLjRAOVrZ5UGaOJliBevplcI9lUdwP1IKjbIZ3xPZKrXqUlV1GWcj4LlZo39Dy/+Nx2sGRnQww1AYUXlDhBnxo2EkC8nTzjkFKCoVWd+vC39emdTQoZk0gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(6506007)(6512007)(956004)(86362001)(8676002)(2616005)(66476007)(38100700002)(66946007)(38350700002)(83380400001)(5660300002)(66556008)(478600001)(52116002)(6486002)(316002)(186003)(4326008)(26005)(6916009)(36756003)(2906002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uje6c87Jy39NNfD/bgWJ9h2IorGUNX4TJyea/SF783a9kGJdfzCrt8VOjWvh?=
 =?us-ascii?Q?P5T4vtVGRGY/TAR/zi0yDDTafvPsubr0Ep8bW9diq569dtKlLdcJe52gQDzX?=
 =?us-ascii?Q?WVkQJFMycybPhGlmKuOqCr82ZvQmfh5VygL2oVRFbB71q09orQ7jcQ9bmg2w?=
 =?us-ascii?Q?q1JKsopbp3wOODEJ3AaXtlclvPLyyxNNFuZ3BHNLf9OfO5QHEsZC1Xj45gYa?=
 =?us-ascii?Q?KmFWYExv/p99vRb+ay2Lb4rKVGXSrq2coSoiLMJkuit9wJryLbLF4AXh+dWb?=
 =?us-ascii?Q?Dpw+2fjqHdx5B3KEzhaYhmMBxTxBS0XbTxT9kHDGPbprvW8MaQXHlvoOHhsN?=
 =?us-ascii?Q?3laJuvydCp8fl9n/oX2/AZBsoDIuqYi43W3QuG37Yb2IMMNMaafjCFeTTwIv?=
 =?us-ascii?Q?CjJDYOp4V7bWhiJX4zhSHp4BhzvMZ44/Y1fJc90iBx6J6SWeq25XDHKuxfrz?=
 =?us-ascii?Q?k3XP+1pCBmFh3lioiMAC19eKHfay/LZJiQjWDZKDhc5xbndlR0BPbXLK/vme?=
 =?us-ascii?Q?fQKkTBi5rTXsTWGxnYe2gNellvrEznnEHXWahXPKT5P1AJaVwenodWXPTGOA?=
 =?us-ascii?Q?tIgH4rm+ylfQheaePbmQ63luxPHqC4Xd5DdUUdZLDgbreiKH30JbXRPlZ+7Z?=
 =?us-ascii?Q?JbRwCVJlwA+aFQTmsG9NJHM0cc9qlNVbqgksUO1GMj7XmAJp9KZNjMfq535i?=
 =?us-ascii?Q?cv/E8gM+QqB67JsjpwIAnDyesy96nTVTjoWvgYKmty4gmZufOBczT2oIUBYc?=
 =?us-ascii?Q?+0uPnAdnLCdAF58uzSx6PGIq1/ea9buVuIj2J1ZvsTqF1+0dgVW+ENsq6Jsr?=
 =?us-ascii?Q?GMsTl9oPmHsairjym0rdHIi/T9Md0muG8qC4efEs8LarbDVVQW8lMoM43sUT?=
 =?us-ascii?Q?yuN2DEd88EPuAJ7QyxTDeadsyPZCHvqK+rbu4Z4IePEvpaZjdIuL8MyAWC8+?=
 =?us-ascii?Q?D4SCT7uMcmD7nqDO/VN1wRcajzK5OzD3QoBghzrSrHe0XW/i5p21mouS0YmS?=
 =?us-ascii?Q?wVSCaK5V5Camtqo52JYOKIG6+yB2fby37u1UJvoFsx0gbwlvM3UKXsh6/D05?=
 =?us-ascii?Q?8m6h5buewDNreD6Lr4V56ZUH5v8Y1KHuSv1QFv2jpU3ITCx3M1UYTjcVrwzn?=
 =?us-ascii?Q?pxzAD3vvheLAIOmeaVXKcThCpHJz7mRX1KMe+3aYNzZGmMhQrEX0b4Os91Fy?=
 =?us-ascii?Q?WhOpEiPLtBYGFEJe4LnEU5l8tzZoVYugPfkeTFYeMY2jPUJIcZFoTJt+GNfp?=
 =?us-ascii?Q?kfOS3kQDrxJ/Pw4mc7Bj+ie+kA2nWi4eCToWjcVZ31HrUSqJKoKg9Qhzmu42?=
 =?us-ascii?Q?dt/Sc8OFtfYkDGHfvb7eo/77?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958e67ce-b7a6-44ee-521f-08d966bcd178
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:05:40.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQfa2tuDsi0Etc3HXgHTTtdW5VqBk7n2a9LZ0or7eKc8N2dxHnna+IOJKjGVN16Vj8mRd+lfq1sFpGsDY9taVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240031
X-Proofpoint-GUID: -dWAikEsWG_jvxAGRu_WasmaPN_ZQZ8Y
X-Proofpoint-ORIG-GUID: -dWAikEsWG_jvxAGRu_WasmaPN_ZQZ8Y
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to fix a bug in btrfs_show_devname().

Convert fs_devices::latest_bdev type from struct block_device to struct
btrfs_device and, rename the member to fs_devices::latest_dev.
So that btrfs_show_devname() can use fs_devices::latest_dev::name.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/super.c     |  2 +-
 fs/btrfs/volumes.c   | 10 +++++-----
 fs/btrfs/volumes.h   |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1052437cec64..c0d2c093b874 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3228,12 +3228,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
 	btrfs_init_btree_inode(fs_info);
 
-	invalidate_bdev(fs_devices->latest_bdev);
+	invalidate_bdev(fs_devices->latest_dev->bdev);
 
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_bdev);
+	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
 	if (IS_ERR(disk_super)) {
 		err = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3466,7 +3466,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * below in btrfs_init_dev_replace().
 	 */
 	btrfs_free_extra_devids(fs_devices);
-	if (!fs_devices->latest_bdev) {
+	if (!fs_devices->latest_dev->bdev) {
 		btrfs_err(fs_info, "failed to read devices");
 		goto fail_tree_roots;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aaddd7225348..edf0162c9020 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3327,7 +3327,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	if (wbc) {
 		struct block_device *bdev;
 
-		bdev = fs_info->fs_devices->latest_bdev;
+		bdev = fs_info->fs_devices->latest_dev->bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2aa9646bce56..ceedcd54e6d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7961,7 +7961,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
 
 	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1f9dd1a4faa3..64ecbdb50c1a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1706,7 +1706,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		goto error_close_devices;
 	}
 
-	bdev = fs_devices->latest_bdev;
+	bdev = fs_devices->latest_dev->bdev;
 	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
 		 fs_info);
 	if (IS_ERR(s)) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 55f0a82ff5d7..ae317b0c39a3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1091,7 +1091,7 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
 	list_for_each_entry(seed_dev, &fs_devices->seed_list, seed_list)
 		__btrfs_free_extra_devids(seed_dev, &latest_dev);
 
-	fs_devices->latest_bdev = latest_dev->bdev;
+	fs_devices->latest_dev = latest_dev;
 
 	mutex_unlock(&uuid_mutex);
 }
@@ -1206,7 +1206,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	fs_devices->opened = 1;
-	fs_devices->latest_bdev = latest_dev->bdev;
+	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
@@ -1968,7 +1968,7 @@ static struct btrfs_device * btrfs_find_next_active_device(
 }
 
 /*
- * Helper function to check if the given device is part of s_bdev / latest_bdev
+ * Helper function to check if the given device is part of s_bdev / latest_dev
  * and replace it with the provided or the next active device, in the context
  * where this function called, there should be always be another device (or
  * this_dev) which is active.
@@ -1987,8 +1987,8 @@ void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
 			(fs_info->sb->s_bdev == device->bdev))
 		fs_info->sb->s_bdev = next_device->bdev;
 
-	if (fs_info->fs_devices->latest_bdev == device->bdev)
-		fs_info->fs_devices->latest_bdev = next_device->bdev;
+	if (fs_info->fs_devices->latest_dev->bdev == device->bdev)
+		fs_info->fs_devices->latest_dev = next_device;
 }
 
 /*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4c941b4dd269..150b4cd8f81f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -246,7 +246,7 @@ struct btrfs_fs_devices {
 	/* Highest generation number of seen devices */
 	u64 latest_generation;
 
-	struct block_device *latest_bdev;
+	struct btrfs_device *latest_dev;
 
 	/* all of the devices in the FS, protected by a mutex
 	 * so we can safely walk it to write out the supers without
-- 
2.31.1

