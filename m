Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F393F299C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhHTJzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:55:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21460 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238938AbhHTJzJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9kg78029587
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=jvLXbC3tcenD3SJpsn0iHWRsN6vZz3Y4QkDmRdUt19E=;
 b=ImGAYQlIPQHy3oVyeHucoUtzvhl4Gx/rVYVijti68EUkVJL375K1Uq2YkoETnKnQ7OPu
 oRwbpoeSgCUzeCJD7kzk9EUWC0FgxyXo2qMkbG6IdGjvdy5QgcJpk38tAc65zzH/PqP/
 rrD/OXsbRjRY6/vyuTYEBBN8TWzhYeQzDutHAc4I9JWaEMNqf0VIATfb0/YyNNHRXOd6
 9bbCWF8W3AMQiVbPQr6tSJTlxqviHSo/4ymCiJH0RyQgqjLaYgl0iyR7WdatuBNNeqDh
 CTjGBq6bDCL4lsbPhPkGsTCgG5+Y1E0F1fEVqJdoIMYQTsIhWMYJoAegJwj2gDFTId9c 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=jvLXbC3tcenD3SJpsn0iHWRsN6vZz3Y4QkDmRdUt19E=;
 b=eBi6VhaqfhY6hbezoSk2wcZQYe4nsDUkVQoVT2ARpwzLVOqGJpcA37v4dV2SVUq6IXNS
 xeA3drmswSrETJ5K1LLKKUo7/jWD2c/WZJzLTYfjPzZr7XxiXLw442ftXQcba5tSI6r2
 BPpQsEsr/ufYIwROkVHZ0IW4QW+Dj9cdr+YGWvrVZT/pAP/LwuxVrZlTyCuut90WlH0+
 AEw1O2oSSKBdGAW5e6eNmwvWbt6fxcIuNRA88u5TgLrAVOuE2FAijZ8URPgZAuUookbn
 R7xBThHuynu/I20WSAdDdyUdBxlVAcIJcm6hd6H3xa3bSaLxhOQy1paJjP29HYYHDpUS 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24p53g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K9ixBw137509
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3020.oracle.com with ESMTP id 3ae5nd9s87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERbnvgWQagDyBHo/QoUL+P2l5I+g2TDhaJ2KI1dEV/GeHSZ4wvDMVBc/ujHRMY32Bf8uH0cEIJs36zw4lrh5gjqTAu9H3wWkfHNuoUPMvjJ0NV4Md50SnUq/1YwMmQttxI+0CgWf+zlYw8ersw57kiCpOkJqz5THCwlXvK4lumA58N6mN4JbKOjwpgwX6yuc20kZjWtbgvikWwb7UM/w1t1mKd7jDMEE79laZIB1Q77Wlw0M0mO7PXCsxxbTj4TBTSMcFgqxC4/l9nssRpUe6NZEVBoUL9p7jELl6czeoOe3ny0gseF3HlfIUvzTGpaJit6MgVRErCvHomqPulTSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvLXbC3tcenD3SJpsn0iHWRsN6vZz3Y4QkDmRdUt19E=;
 b=cJkbSvdTpeQx/FZtVz7T6L3Iqhucmu4Oj5Y0YFCtMHz52rlgg42WWoxQfjQZFt0NCL9pm0jKU8EnkC1v7hkC2Q0HbMJb6CyPIWrsDMBzU4TeXVzoF9/3rhZ277CFkzy8LSXWC6EC7iZMCuZwiG/ywaqakwiQlMqBRsI2ixzafWJR2rOwAPA+E1niBLTCSPlm9Dafdi5fv2ti49Esq1kYislVOcHLKiqJXK6sJXd5Hlc6ukYAyIUHZY9CyADHgwxoskq4BUoPS/A/eIiQC4NpSvb2liyKWZo7Asqj2F5l9ty6mhLWUFeF88FoRwiI6Tj2sOfOprG9+/d5oChTrCnu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvLXbC3tcenD3SJpsn0iHWRsN6vZz3Y4QkDmRdUt19E=;
 b=Iz7TVAOdUxI29nSlf6btV10aZZVkemIDsh107qgYK9Ft3tbSmUbSnHFSxoxlNYgO5PjBiXeihJWBPPLLVxdXp835wunBtcfq719qqkyidU4j5LvtdPntd+zHN0qzUiVxukcNB6enkbT79kuxTL77wH61meuap6xfjPsI9bV3+a4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:54:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: save latest btrfs_device instead of its block_device in fs_devices
Date:   Fri, 20 Aug 2021 17:54:10 +0800
Message-Id: <61d6dafaff6a119f56782fb35b2374411585b634.1629452691.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629452691.git.anand.jain@oracle.com>
References: <cover.1629452691.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 09:54:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd165c1-4b3b-4fa4-9232-08d963c08054
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34272A3FB7798DE45BBCD1FCE5C19@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEriEW8Jf0zw3A141bHeAsCJDh5ZelWNrOjJHjuM3xatk9e6guwv66kEZ9Ocj5ZPjfSb2/IS4mf7a/3LQnNoaaPFTJrBE8UFtSATDeUAdqsrwwA2wRUuKRw+XY++sqJqdoXELnmRQjYPHO70fTqkDwuMBMCFO05s0tZp4GRba7DZa1YzWBAsIe1k5xJYEHqi+XKE7MY255W/RbYr8QvSeN2e1JLkM3mNffadp/XNfrEinyzpTt73mSJjIgxghsf+t2n46fbRxbiK352LwC2X6LEFSvX5WcmtBcnzVntuaMXzMXG/pBu9xQdp8/BPtuKxVgQ/ohrId/bUAXEDRPQRI5BfvtBC9a79yeGyrwz2bCuqKEbjQXwEcslj97Y5rJQSuVaTyFeP0l7MaY3HpCvQySr6q8J9c5BBSq5LChHrN7P5VNHsrB6JzHyaMImzgbnytjQOAAxhm73lzdT89N7/2O0kpoHy17TjG8E+O1adD3i96s5ADXWLQfAhriUUunVcPMHamEkm6pMNOG6TQbTNyXKoseN8uYFSH24rXsbr13cQzMLms2iVB/vQSSacGMWFeQnR7HF8heuDmwtRF4TzLCm0PMtKA1GinGaJGMFMWCIT3fD7v2ODJ/7m4aoTbtOBvAWUMEi8nGZGGy2v9GRpt8P+Fsju5O3O7Wt69Yp/p+BVc8pNz5RFE3zbHtGMKpx4IDJvMGjaBausNcChAxp0bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(6506007)(5660300002)(6916009)(66946007)(36756003)(66476007)(66556008)(83380400001)(186003)(6666004)(478600001)(6486002)(52116002)(8676002)(6512007)(8936002)(86362001)(2616005)(956004)(44832011)(38350700002)(38100700002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?894yke6DXzisDHT13XdA5l2q8GJ7vndPqO4/r815VoobQM+PAFKHtFYjDkb7?=
 =?us-ascii?Q?8uVV/Wkf0yZQSa3W/XDjyHEUgEKE33VPxFUY0fdvbPNvwkGYD/ibjnhuD92s?=
 =?us-ascii?Q?mEMRgvYlG473enoBqD8kidBn28bGW4oCZwMWb8zKGNtb0pZVx5CU127hl24R?=
 =?us-ascii?Q?ZjqNHsXaA6hiG0EfDwOsE0onBJRmxMIXHXG3rOA/rbtnQcyZX5ygG4vN+fAj?=
 =?us-ascii?Q?uLDTq1Xnira/zBMOSSUNy3J7TuV2YxG23zhHKn7vKH0OGUoxWyiInAJjTWLb?=
 =?us-ascii?Q?Q10x2FUm5whly9coe0chtpI1ZXEmq+Vu+bNEmUw1k2DvQcqqPCbo6KhLR+H7?=
 =?us-ascii?Q?PVyigSC+i7xCKSyHio4gy/qnqz6PnA7DyUlfQA98ulu3ew7J6jpgNyf0j5BQ?=
 =?us-ascii?Q?eZVfg9/j13tZScQQj0h/ICGzj69dXNinwG4SLBIBcjxZIJuPXaqKSwPcs67F?=
 =?us-ascii?Q?bQJ+mLX9R+eMnE+SCVMKMOCWlnbZXSbRP8jIG0kbI/Jwxq1razjmSbNxh8of?=
 =?us-ascii?Q?XDmldaC5E+AFZB8CP9HJje4ohHGitatF3FlHIwHV5E33o1zG5ej+1LHOdGND?=
 =?us-ascii?Q?CB9gcaeGOFkFAn0KLhKvrg/3daA6hselEjAEg6jreeFErYgEIONTX3Wm0bOR?=
 =?us-ascii?Q?e5cbRCFVTXU19FoIWeq6Y3vgA6gfkptUNToBO0Y2JuJ+xVCnDXt1cCReRBZy?=
 =?us-ascii?Q?gVIhXqxCDxqTupomDmkTFwv6r0t4HxjAofb3PX6uXGe4VD4xHcKYX0tuLiq4?=
 =?us-ascii?Q?PbgApr4W8KMN60qXPiipvP9IvYo5uSennE4ELgPMKWjXjeMrNlT/WqvAV73i?=
 =?us-ascii?Q?EtdZV4j7zyasnuGUxgjeajubnL3DDQvOHEVAHSeRhfVTdTGQLHULroKZRhxz?=
 =?us-ascii?Q?4MDlRRBPpGnKAO2CPvjk6/44WUWbdQvTi+E1Dy1CkEi3bI4Cvh4AjF7yRLKs?=
 =?us-ascii?Q?tuAFZZH13beCMQZLE9FaY7Ev9tf53t1g90/YsUo+b89IGLTdBzn6VeArD9Ef?=
 =?us-ascii?Q?fEZMkI08llvV1H+J/lDsy/nskgZsS1jyek2ieNA4m8TTVT4xX6mXreH3MCC5?=
 =?us-ascii?Q?+Pjqec1xc6Rj4Z9DVHWdRirQ+/w6aDGAD9EFwWUDQCXx3fNPQuT4F2Sr2V3v?=
 =?us-ascii?Q?zSb6FDSnpwKthOtOCii9UPuTNGZE7CfuueVhGALE1Fy3c2Yo66CBJrrvFRne?=
 =?us-ascii?Q?nWuXiQ1mu9qPxa+t/dtp4YKF6BUUB0vXs4HjSGKISmhClhxJVnqtqhrCahIa?=
 =?us-ascii?Q?Fw9APyR94/rWVUx5QDbVrEREbqrDCuqJNybaNQeEwT3NPAc71o9uQY2MdIde?=
 =?us-ascii?Q?1zcb24xavfvUnNrQ6ZGT9JNE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd165c1-4b3b-4fa4-9232-08d963c08054
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:54:29.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvdRaEiRlPpVIim7S6qu+SDBfGEA1Difj93HrV4BS4vNjDR6REcask/CHjageGlyYIya2CY27fgGlXjSUKHmxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200054
X-Proofpoint-GUID: JUDgqr9r-GWxzapn7-G-jOBX6DPzOOeS
X-Proofpoint-ORIG-GUID: JUDgqr9r-GWxzapn7-G-jOBX6DPzOOeS
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to fix a bug in btrfs_show_devname(), save the device with
the largest generation in fs_devices instead of just its bdev (as of
now). So that btrfs_show_devname() can read device's name.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: born
 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/procfs.c    |  6 +++---
 fs/btrfs/super.c     |  2 +-
 fs/btrfs/volumes.c   | 10 +++++-----
 fs/btrfs/volumes.h   |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

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
diff --git a/fs/btrfs/procfs.c b/fs/btrfs/procfs.c
index 30eaeca07aeb..2c3bb474c28f 100644
--- a/fs/btrfs/procfs.c
+++ b/fs/btrfs/procfs.c
@@ -291,9 +291,9 @@ void btrfs_print_fsinfo(struct seq_file *seq)
 					bdevname(fs_info->sb->s_bdev, b) :
 					"null");
 		BTRFS_SEQ_PRINT2("\tlatest_bdev:\t\t%s\n",
-				fs_devices->latest_bdev ?
-					bdevname(fs_devices->latest_bdev, b) :
-					"null");
+				  fs_devices->latest_dev->bdev ?
+				  bdevname(fs_devices->latest_dev->bdev, b) :
+				  "null");
 
 		fs_state_to_str(fs_info, fs_str);
 		BTRFS_SEQ_PRINT2("\tfs_state:\t\t%s\n", fs_str);
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
index 51cf68785782..958503c8a854 100644
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

