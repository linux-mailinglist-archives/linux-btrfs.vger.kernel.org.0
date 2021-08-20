Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492A03F2B39
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHTL3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:29:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62514 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239192AbhHTL3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:29:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBG0DQ006305;
        Fri, 20 Aug 2021 11:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=C6mfZh56zZLapBtka7GI3ZZCDF8EyD/VM19a5GMj/xc=;
 b=lIOqEgEksUCgSckNOjp/CWpj3rA175WbbcNZ33WmCAnE47FoM2nTZ1dIgZkduHAthuDa
 xNU0ttwOKlI9lUN0LChGUJ+9sZyEvfowQjX9eU3hB8Mhz9IVgWOsNxVPjqYVskMS1EGD
 jQGQA3N3KmqR+CXmjPVCJ0hCGMUw29lNCcJ9LiUZ0ufhjoujswUDSqnN4mF2eld0CBup
 7zLJN8Q6Igj0f8KkSJkKp2MUrd42IWRmQI96dywgcLOCcK+Drxp7hsP56DZ26G8r24AG
 JwEAJw21Fctgqu/fGemWO6ocOOZ10YbVsY4qu/CGGTvpx5BOf1vs5q5fiI8NzY2Vaiqr Xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=C6mfZh56zZLapBtka7GI3ZZCDF8EyD/VM19a5GMj/xc=;
 b=HaxnduJZKD/uJGYnHBMp+1fRVguqXQF/d05qFEj8JVeI5qQ7DDLQ88EkyRkVektpCnEo
 MQQhU1iD3pyruCuE10Es2bg/MKSZyEZtrp3tL6L19M7iEtB9t5JT02pL7xxQEBe0DEBh
 e/CX4qoxRvgJ8I4UzYrIjDcVmiW9hp+a5PJvjIlE+OC7fnBVXrVJjm3vsC8wsGeTyCDP
 gCK57gNI0rFy5A0BmBzYnU3ZlSK2/hZXVN5F9OIsXHKq2UunDeEzIGKNvlipvdbgUZuo
 69IVWTYPLw3D/as9cKBAYNHky78aQ9Zb+s0dD45/IAZirm0qG+nqhwriHaC0xio8pv6m Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmnqqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF9CQ175016;
        Fri, 20 Aug 2021 11:29:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3aeqm1hsau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3LQhgr6iKlXhWUzhEPF/5dn2Vf+H3/ttTYnX9KInDZtenrbcXoQrgJPO5jG3LN3GH05f7Fx+qmnn2Tw6WLwwn81qhU0ONN6WCSEBPVmpDvWicDUQptzrQC8/xCGNPwPHp+Ds6XDUHZvNgFeM1r21wfSvwxk2TWqXiRsjwpW1qi/61wKnkLX0/Dqj49T/QybqovGNE3TEZGOKaIiReEUJjYVo2YD4jK2P+6L9Y2kDpQ1qz4SMfGPraMZH9ZCLrQua/Neksuarup72x8CUdVAfieXD5zQ4FDFhmisUqQ6uL6mwmX7MYweXt3CSNoFnUV6nAnlbjgNERLOjnVNfPOfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6mfZh56zZLapBtka7GI3ZZCDF8EyD/VM19a5GMj/xc=;
 b=DqrfdvparwbnBENaNgpCD6N7ShsSpkyZ1EQHB+B5b95rOIH7wURsnSBWBq4VwGA/2iR5uMyv+i5wpyhr3T8ub+afOxCKatTNSdXuVzocryqvVXOxHyOVVFZZ0yzmmeIFyCBcTgMPKIzdnEJUMOfVSYMpEaXD7GxDPtQxpCm2JFcsiDGbpXWwny+1atYkT0IaUAyFEISmp/OR9S50oTfbbMZr4zUMg9HdxxMr5NqxQzlE55dUQZ55vxIZ2MzciWFwC2WlFny70XMemzAziEGkdoNiz6FqWMIn1noKf1+twCBaqQXE5MvwQ6AESQajDRJXk3QGiezxWNpixzvFni9FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6mfZh56zZLapBtka7GI3ZZCDF8EyD/VM19a5GMj/xc=;
 b=cmtHN8Agj43qOBP8sFsrkdVFx/5oQB3SLuLyJg5/iC8LQK7APVTNzOABHYR1dMVYvHvURX4HrIOUrfIntf93WEWGIw/V9rEXzxmQ2ZN9FmgA8Vy0iNbtePiiQY5MK1eJcde5nEmasiNDcBxyBh2U4zTdCaqbMnEinCKX2PXHSsQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:29:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:29:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v3 2/4] btrfs: save latest btrfs_device instead of its block_device in fs_devices
Date:   Fri, 20 Aug 2021 19:28:40 +0800
Message-Id: <61d6dafaff6a119f56782fb35b2374411585b634.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fbbf88d-355d-4a24-1894-08d963cdb6b0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094ACE06E67AE988019E16CE5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiIRHUrZeLZD5o+Izm6Qe2K4SWIzbWgSgKMYR+aFP/Gtv99JLYJAMuza/KjzvWNo1JtgIUu8cBiSNmndXyan7arzM6uyh6nny2LnvOtS4s/sGtbPLy/9CGh4rqAjphbvv07KCjrrGMvjgC3M1DMT2u+BKe2WGoBYW6I9hhibzlXT8dHf/7QVAYqXQfVBIM0tgUiQdyZVf3zpbZHaTZ8Njcn7sOQi2eLpY9IEQq68UxjJUr5ZQh+d9RuqReahqV+/jEmej8JXpMggfCQn+Wsf0/jkgM3rQ0Mcct9otgxIzKOPXMbrogwNdRdWJAToGcgPqQ2Tv2N+cLezMWVFm4/KWOH1RbgpAYMbyAjGw2tw1309cmMAQz0irnAeA0zVj8loXzYj/XYhupwahNh+IrdKnVR9nwpQbxec4V7jTfbNxtqpbdmIXFqgRq/FMr3g3jfhQBDCwCMrrUwCOFcyKBa+piGJIolXxNhSc/Q87ri9fONu0WX9TX8HqCRE6F8b38Aor0WaVzMhfy5SDMj4yNXI+Wky5vjwk7QcgwSyzQIPSYTvXXrquiIOKbBs+YqoQ447FcnOR3lIACtMBobQKiPN+cxK2hKDz67BalLCBYEPzjri64RN/0iqwbaTEIJIWSTK50lDkdLNBAiTCjj6y05+y+0bBeTcDFh4KFpp7bjnqeRsk/K4jhBRnVdpzv88BN7b2SEc6ogW87cGqOYUx7Ak+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(956004)(44832011)(8676002)(8936002)(2616005)(478600001)(83380400001)(6916009)(6506007)(6486002)(4326008)(316002)(2906002)(38100700002)(38350700002)(52116002)(36756003)(6512007)(86362001)(66476007)(66556008)(186003)(66946007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzG4XJg8p2Nr9ZqjVNV+VgoGeHbyhc15K1DscxJqtYi9VyACSYviKpmFcCqn?=
 =?us-ascii?Q?8bGywrybTgiQ5Mwyv4CZoU6aNvgqnshK9Zo6SXs0GDUlBh1zYJpxCCzpZG7A?=
 =?us-ascii?Q?M/bumJ3pdg38ra5t/iagShV/eIdnCAwklx16q5SbAdUQg1Oq/741RDU/vqho?=
 =?us-ascii?Q?qk2ejlH7dOuFZoRbS8E3R2BegMFrkVK2pa3KUCy6zdUN6SQ+jnXFWBITSSZZ?=
 =?us-ascii?Q?LgCAVJQw5XzGHETClSpEOaxquzrlVp/diqEzXMdCP6qO20K1Z9e/63Su9znT?=
 =?us-ascii?Q?2ayW0Cot0JjN6xQyvofGhItHlZJLHtCNM17U7K6gmiIzAFM/Kw7HGYzradau?=
 =?us-ascii?Q?T3vHkX2UnauprDkz70fvdbePumAw6hGCPAVzYf5pGr4kqOyiErlP9WTHKDZh?=
 =?us-ascii?Q?z48TN9dUqkxuFKJNsWxliOrrZxDDyE9EWSIOMQA4ks5sRvG8o+KxnPR0OndL?=
 =?us-ascii?Q?SJyH7prydt9fBwRh8MCOINA6gi7o5qhyw2ZECyw/nqUIRWoLogjBKj9USDT2?=
 =?us-ascii?Q?k5A9w7I5ev4PqlK1JABx+t76ZLSHzQIMgfXClG6EIVjDtmKMK4fvQ0419egb?=
 =?us-ascii?Q?C3MU1bWA2Dw7VSEWb0cSr6QYGRkNQIj/dRtxp7JvrGMGza9DNEBLmYS+W8Xk?=
 =?us-ascii?Q?7oNhvM9puSZ7xciI3rkUJeNBjB+dcxMYVhx4g5/s1sOUbCFOwTsqL3WV+AbA?=
 =?us-ascii?Q?OmQuibtFyuy4s20BHiwCCDTi8OXqVuGRegZxvFkpauLU9VIuVvOaFDeJiHYl?=
 =?us-ascii?Q?aY8H30fkSDfBeS1i103V3biLoHgPhQ1EsZ4tVowRj+SIXKam1rpX1kqMCcio?=
 =?us-ascii?Q?tiMONSz0fya27etIme//JuuS6ymBz44JczWRWhg39uXVrNLuKrahxkYk75jw?=
 =?us-ascii?Q?u7YKv4yzDiM6ujFr0wUymmhjyn5Od3S5tmYnnYRiAUaGKAw8lcobug9gsZSR?=
 =?us-ascii?Q?y0O0xo+A70eV4yAvgKFsftNzPX5TCqxbC4STv+Zz2kXlMuBtKp0rvLEBMq9v?=
 =?us-ascii?Q?c4How3ITYCMmikp+enzH4yP/9yWNvpuQkhAcZ+/SIFFCd8FDISly+9yzAtMa?=
 =?us-ascii?Q?ZjNchv38xREvIrKXUD6rJrzXHlsm7G4/1bx+7cRQA9wFwVqxcGjWpgiNPact?=
 =?us-ascii?Q?dgDFUaF0g+/Uifii4xiJnNhkB1ayQnbaLb2oGBKWvEwNFOSsFHDJo/RDb5qL?=
 =?us-ascii?Q?df1P6YtWcEhP3vHRiCU0wx2XbJWLqKYH0wIPXnYgwHXk9xfJJMcbYXc3DXN9?=
 =?us-ascii?Q?7kGALM2tpHae1x13OcPQhPta0EYa/m3YHTTqwbWgm6hgyKtmPaBGxQ8ccJzN?=
 =?us-ascii?Q?+gZqRgBc4EXuXeNrKSzwrHZT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbbf88d-355d-4a24-1894-08d963cdb6b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:29:03.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk03oqDYRezWn2KKhKKx4aQlMAWHtEMA99os11zrklb24v8hVcTpIhu2+tgT8I8VjsAGCIXAk7tKExKdD6n4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-ORIG-GUID: kfAL24fMq1lcezIC-kivAV-XLGqix_Li
X-Proofpoint-GUID: kfAL24fMq1lcezIC-kivAV-XLGqix_Li
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to fix a bug in btrfs_show_devname(), save the device with
the largest generation in fs_info instead of just its bdev. So that
btrfs_show_devname() can read device's name.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: born
v3: -
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

