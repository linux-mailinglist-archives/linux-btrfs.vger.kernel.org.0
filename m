Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4183F49D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhHWLc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:32:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236368AbhHWLc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:32:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TpCl013674;
        Mon, 23 Aug 2021 11:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dTeNB8Q51nb1l74P87shsceR0w9DlgGIwGkJokCf8HU=;
 b=YFy22BuI58SmU9xsQjGFrYAh2rWuanHGh9LX9xJxXYX4u+UD7jVjauzrmlbJcfnidAZx
 CfW6Fmd0MrJzUiwfDDmG3nM7n2fdNkEZibCHbOk2zAEfpIg9xFkKwjR54hYPw2mBxqQk
 F59inrulsDXhfQehwJEV6JsGRvG6hgaE5YtLqhdMfckOG4oKWANibjRPFetrQhmVJwad
 8eayh+N2oKFQy0ohetcqSQkqRXeCLD+XkdiX+TBvA/CUtttk1eXIy2y3t5S+rH/TYDbl
 NoL6IzB5vb0PbwuGvvBN5wDfYmTfV1NOCCFX4erIkwv0qoO3TXsFLdcKLeeBNuNMu0ZK XA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dTeNB8Q51nb1l74P87shsceR0w9DlgGIwGkJokCf8HU=;
 b=yC/UsLfadNVJIlY7PHq6EmvP/6XHrFKgPGRaWQLaWtsUJf4uUjwFJ7jLSyEkiyetbmnH
 bZhkDdn26qU6k4SgKi+lJedQSkWUROQsPe5RXNwy5aEjEuYAGU1cOt+5sD1qC/wg4PUe
 zNur9Wsb/IL+W3p/ok++uRe6ltrJ90JhZlJdURXHk3vIxTOYQOpZjWQ6B7Rce1Ue2Qih
 zT3sSTJRHFbK4Ye8gyHuAzkd6SWq/hHxGsP0l5msr/tkT3FG1rYo9lRqGJU9WM1j0rnw
 Ko9HWV9tl+Phs7pk7QYprn8UPMJ04RxOXAqTUrFbGQNE/nGJD/7FZq7jsMg6p8MZW2bt OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akxre95c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NBVAJv187234;
        Mon, 23 Aug 2021 11:32:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3ajsa36nsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbpbQFoLZysvSt+MmQrV2QVTmCSsFU//1c4+kXTqL4VmrMlXwP9rb6Qva6g5TJDhZjPm7ZamgObi5ogszoB9MziCB5q+1Na6wgvshJzGmRYg7tFUVjG2+TjwtKSzS5OLenfrkNnEFFfCn6mzXIp4VOEl1K2LKvuEAzznD9HRf/NLyH0EqHNZaMF9VDL01ZRtP8A2WrjJtgkudKIUT4Zkgxml6lfypgKKfo71YNBv8Ac8y2A30t4WzUsxPvBAChWxGLBmj8rFEIHWZBzE8Wa/jAGHmRzQwvZHN/ZOFnGuuvMkQLs9KdlBFeLtYRf1slmgJjx2hRtW5NoV48+mSPE+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTeNB8Q51nb1l74P87shsceR0w9DlgGIwGkJokCf8HU=;
 b=WNEoytnd8lp6ckLJEQX3uTniC9hRpIMwidKxEN/xEKkHLrUB/dgOwXDc03+T91Quh7s5WL9Exrj9WIvkzk6m8O4IqP1i1ffEumNw8eN4VH8+pLFnIUr7vb1Z2QB1aw8MqRrDuAc2XDeXRbss9UO9YHDB1uTRdJleRFToVYyKYgbsMKK6yxHCCuuPJ5p1JDTuwbLimOauqqKYjorXAhiz+MToeKnTKmhndV1Tlfml+7HbR0790rV8FmY+dCbM/pzNftyAWL1fDIl1Tr2KYwDOOpnKuoeU9ANW8V3lPCQSlExkLekJBU3IiynqT0YQtT79hJTDB7Fae0wFx55m6rTR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTeNB8Q51nb1l74P87shsceR0w9DlgGIwGkJokCf8HU=;
 b=PPLKMdMuXOZROwg9mKKRJcORc9EFcD2VMOqC/pf6CvdkGYdzPvyQ5AtcSMmpiQy1c7I0ceHW8+hCx77m0Krh/KIADAP+rtx/vkP45MCUrbkAPTRMuLvNr1ff7Xu339TjuSbxnldFMXzQfvwhjjnPtfhEutOgyVDg9b+A9xQKy6U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 11:32:05 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:32:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v4 2/4] btrfs: save latest btrfs_device instead of its block_device in fs_devices
Date:   Mon, 23 Aug 2021 19:31:42 +0800
Message-Id: <b1b21ce004e94ce309e40368067535699a3148be.1629716901.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d2aa6a-28a5-4b67-55b4-08d96629a21c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42066187D12710CC83383178E5C49@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kP62jRdhB58PWWSSo50gEU45RW+VITW7wfLS3rWMrG9oEYi9DolP0NER0sbCbptnzdEmamQK6jkIAJEECuIrJjB2U6Dky0TlPFPXGI8kcvdNTeXBeF8jLiF1v+bHDvon/dzwXziIDkDmf5/n2X/QsiiO+gKU9LMZsogAKMtFxsLtZCWa+4aAodr1fay+yGaQSvLTN64bTrV8DKkrqDNmGwtzxBBG85vn9dKipko4eX+UGRE/FkQpTTc6rmzdUw3Mf5Y2vvYIuWow/MU76XHTcBPPcJNHBKFCi1yOR+nxjVpu2B4it6KGFGnlU7Ip2ZSC6DSpSQDzFm1e0j+Ah/3jUxNLLzwM+GVmXFsXysLWajl2btPcjh4YrjYOrutfI/nJROz1OfhUzS7J4IcKNmC/Dc7iAdTV8B4l7S6p+j6XBW1SRc3bb7Jn7mtoiLyxcBkeol+vzv6Cqxd4EF7rZeTmtUg/iZNWEFZtxm5DEvc+On5GQLsrfy2FkzkLKJEFms5Pr/C3l/YcS0Akbve+Wyj8Cip0llyhR3PBPOxWisIypuDZbjCIHlLQD4JpEAPo10FeM8Ue30NXXrVsMnA2J888rH1hpZOhpuiU2a6pU1WbgvlNy9e2U33vWxj+ehpox9o5gCNDN/g8/vN3X+hMc8WsUel0evYscT7eTM4i1SgWVOogMSVEPjzZKvgE6hSOZA1ipOrENewXtmCJCGiDa6+QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6666004)(52116002)(66476007)(38350700002)(6512007)(26005)(478600001)(38100700002)(6486002)(6916009)(86362001)(316002)(83380400001)(2906002)(44832011)(66946007)(8676002)(4326008)(6506007)(8936002)(66556008)(956004)(5660300002)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2P2erbZ+ccU9hP3YsWN1GK3FpqN9TWB92rUMqTEcb289SqPXd2RHAaj/Ld5?=
 =?us-ascii?Q?Ky34Hda4HA7ZA1fnXNOHZgtRm9D9BL4HvJX9d3icQ/zOq4QtNtu0uDRbQtp9?=
 =?us-ascii?Q?OL96luEfK3LeUDBqFlqNTYVJye8L1Nbw5gIFOS4kjDEFPUnkmxITvdFWhGXY?=
 =?us-ascii?Q?LWY6nuytsJUsh1pP/TtGtMj285Xb4Dqgv6sf5IApsBNG6uztHusGrvjNT8q3?=
 =?us-ascii?Q?LrphcaMfNovF//jjWuTfJ22RD/iRj04Eqb/dwKNpKbGoJj0QqPiWMT298Do1?=
 =?us-ascii?Q?JnP9w2mFTvLE1SSVd5W8illHJIYpp0Y3NZv3de/SmNgwrvKjRQj3RhFulceC?=
 =?us-ascii?Q?9FaJaMLB1o5kyDdEIYIdFSvN0LEOAhESmHHFXk7heJr+fjsoRQ6McFXz843K?=
 =?us-ascii?Q?ifjDtHX9eMdgQTTu48D6tVu0u9cShGVLguKsyVFh04WOcgSlzEBOMfOvTXIV?=
 =?us-ascii?Q?0y1gRmUwin2OaplNiugOzwJIxTeoKEkmxPqKf6g44v3Va1K8nXt5Ff2AIP3U?=
 =?us-ascii?Q?nmj0uVLmIO68bd9LZYy6dYQgxgkoQYOEYmKpMGiuZRZmkorly+GX40GMN7Qa?=
 =?us-ascii?Q?gWwb2LdsrFomZ0AlD8sozFYBWtuGCnGdpru1PbqdvFFXPJgV6/uixFIOBNZ4?=
 =?us-ascii?Q?rmplCeRbsKfA0+TwA8rFpxxOz5E2Tpc/pRjHEKlNz1SGrsBC4jM8tlaOnVZE?=
 =?us-ascii?Q?LBibwbsJNqTsgAUKn3PEQGBaJPJPAo0x8N69jfOViA/yjVcpMwtgBmYvFkyu?=
 =?us-ascii?Q?+DBBgIl91ctuD4adIYYXtRAQBC+ZWf3Je7e8m2DcrPyapGBOl/ROdS5fWAXI?=
 =?us-ascii?Q?JKgAw45Ypfaz+tBFdq10qTDixjTBx2Ka9msW4t8X+UmHJNQfv7nA+0TN1+k1?=
 =?us-ascii?Q?Mv9uRitUUx181P6neMeRSNr/YVveXYhj3dCJ4E0UHEAmmdGlwfUhzyvq2WLh?=
 =?us-ascii?Q?rUEWZJog2zBprQoBXBCTHkMB00cRBTYV2lohE4Ej8vPXsP+DGW60L307Dqbu?=
 =?us-ascii?Q?RjBAASgTJaNt+ckVvJhBFg7s1+IPEhuOTAgsZqdjlbEKsJeEh8k+IpyrO7IG?=
 =?us-ascii?Q?Qc8JvCczhwxlnsr8gfO2uA3ZD2BZ1GsE2XTXl/8ZE5Il5quXUPjR/6Iafp8F?=
 =?us-ascii?Q?Qw6Fw0yNxco5cu3DjSX+Ch7CKJPY3xSLlDQhEq6xJe2b2quFoaNPW8dm/vyv?=
 =?us-ascii?Q?ZNK2rCo5ox9DadbNFl6eux+8ZSHQUR6M89EI+peHyKvG17wFVlqdSkb7NSme?=
 =?us-ascii?Q?6Z4jNNbzD3fnu5bxZegLv0Zhjf2Jr7rIBmZJOLH3PDfMLhYl0tBQWTIGn6IY?=
 =?us-ascii?Q?9AX0i+stbJXQjlDi8SDzGDuW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d2aa6a-28a5-4b67-55b4-08d96629a21c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:32:05.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8iFT8BSisgQBi5vg6owKmI5TCYjkBg6ShplaclpXU/1LURzzmt/1hNkZHewtnecOBzp8ejq+HNDGnUHDiftyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230077
X-Proofpoint-ORIG-GUID: YFjI4CszEp2fy3lJGT0LVIi42qm8FOkm
X-Proofpoint-GUID: YFjI4CszEp2fy3lJGT0LVIi42qm8FOkm
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
v4: remove changes that do not belong to this patch

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

