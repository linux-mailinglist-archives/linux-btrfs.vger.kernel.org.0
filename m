Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9947726C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhLPM6z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:58:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23498 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237049AbhLPM5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:06 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCFmDr007980;
        Thu, 16 Dec 2021 12:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7P1zOUWejRpKWGMzps/xmDJu3V6UD4OS3VRWhStecjA=;
 b=E5bxKiOzn0Fq9rSBc7+rIpulrJ0WMPC1YVhYgu+Pc89i/XUI/ndjU5i916aThSsWezzh
 sNkgF/95mZaGTPTFwjbvxAw0FJEz1YkZUEIJM1O9HM8h/aIqYBXzCujcztIEU/AxWPSl
 5r6K/kyP0vJ6W8quh+iGbCC0+WMQihaL0cixXLswZM5ByXQoocRgmb0ELi7oh0TXahNM
 fwR362o7Pzq60L3r3f0ndh52bjwnFWN0Fu/HYkvrOmLWbrPQOXpY/TFfw4ZGTys5Txhw
 Cbckgj35yhGoFZcO3Wsam683zw8yYNB60DgnTZUm+++jaN4c009SNNkCXQo2Xt4gjMUy Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc2ndg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCoBms133932;
        Thu, 16 Dec 2021 12:57:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3030.oracle.com with ESMTP id 3cyju9u7b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoQueXYFwh6NQOiJavckDhQl7tp7CdAKDLNnyr+cGTeC5FOgA9JRvs5ikq1M2R7Ah0IIx2ytoyFFkIJBEiuVWaA7ULVlcbsy05H6iNda7mWFU1ZDSqW532/gsvED+SC9IeAxIKn3gRidCCknGixwqX/VT38+PuBLt31IA0yhwdSvvkgLbi1Yd4mks/i90+ebzyST3jfikBHCLgAcwF6nXpCBJ2s/Y4WjQdMjThEYWt+RRYIf0qwHFPCxPCc9w3Se1ULXNDC9Ln/RN7ZKE8+8vRD6XzFqRjLBAz2SmFLrE67R5bF6a6pwIOLlPvSc0UgS7d+LalY02PRaeFs2thDvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P1zOUWejRpKWGMzps/xmDJu3V6UD4OS3VRWhStecjA=;
 b=mGodrKgOqKEQl5IYTOtmxT6kyL5Wv+d76dyFYpqARCvWADXUk6S5bsC6MuXKA7HhQwO4Pl5sVAvq7CKyC3gQ4kAmrv4/ey1Rh/CLKmnYQBpM1cN80nKO/q0AYtfwC0eIdHNX5Zt6ePFc+Hq7T/dgeMngbifcRCmaPN1qQVxS1HXek4fN9o6J1IqfQhZ6PS/W24zTQW/xXteZhPAMfGpLIp2LZ//u7kv0LMI7UCFFc8S3kaAW+3YcZEr8Ayfk3RtZpiyEjaTA47fEfbgytp39LKCuqSMPuxvjEBHo3BhoT/aUs0ygszCHqE7xv7LxuE632v2mHObQSgHD14PqL7ultg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P1zOUWejRpKWGMzps/xmDJu3V6UD4OS3VRWhStecjA=;
 b=i1xY25cfdUonZbx5NM+p08uQqCNddqBLZHpog0+2ycbVBW0Cm27ZhbhdXr5Du6F2rcZX4N16k7FG8kZ/WHsMRkZy7N6vmbjDEDfVIc2OQ8muc3Fg54+mRjkBykvzg0iRYf8ThoqinsLKlv4ZfSME62lQGwIOhd9PD0v4MVhtsVA=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3425.namprd10.prod.outlook.com (2603:10b6:208:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 12:57:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:57:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH stable-5.15.y 1/4] btrfs: convert latest_bdev type to btrfs_device and rename
Date:   Thu, 16 Dec 2021 20:56:44 +0800
Message-Id: <b3a61db6a89cdbdcc9bd7505bfd19241324326b6.1639658429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639658429.git.anand.jain@oracle.com>
References: <cover.1639658429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7995a738-9dae-4688-190f-08d9c0938d62
X-MS-TrafficTypeDiagnostic: BL0PR10MB3425:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB342539CFF82898C9B279C9AAE5779@BL0PR10MB3425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfNUoBLiC0CTf5Gs09wah/100M6BUKwxTIfzg80rB+hBZUVY747XOMkEp0KD0HKFrtXBJMCe2AGUZp40++jG2GqCQ7NLpPjA0Hk8eyXKKlQwCtQpIqHtcGs5K6X8RYhVZp3gNFcB8zPiFyZhgHTXgEnSd389HT/7BPnap6xXN0dNCLVYAxQ6Jt9elFDWFOgcQHg1L5LbtSofpoZxv+PWNbivO6pYS/uV3NjIpGknw0BZooF1cO8+x/EZc/vOjAXXwdrg3lBnOoXFOap50M34DEa0MyqZgwfi/+k3QyU4agUHTxMqSr8sGRZ7soAkZuZupRZ9BW2GJdMLjntMOPcZI+GT282ZoQ26UwUoyDLiHZBDB1yJMv9KbMK/MZ8DxI+1iHf5AoiEX+RZCIzJLxc8irKsPixvNia4Ga6jJQZ4RJk99USAe35BOnC/QGfSOraYW+Ztzw56ehpr9jjh/0pyVVm2IvAZlLVvR2BE08Wf05acsqLTsMw6fzChqL/yQzuLwMpDdnsxMjTdw6eUuzhpYe3afRmwgWjYuBjmQetzbpIqxEXsGUuvTHvTVy6tPxGhhzm4kTBIEvH8aRm9tHFIZ9yshJfllDgd4VgbMkTBYEBswJkhM8zbMOg9SypPH1o5Z4cBQUzIKI66AFPLVFR6yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(316002)(5660300002)(186003)(6916009)(6486002)(6666004)(66476007)(508600001)(4326008)(6506007)(86362001)(36756003)(6512007)(2906002)(2616005)(8936002)(83380400001)(38100700002)(44832011)(8676002)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?353haDn+uNw3oHdNrkkL3K9f+ciIyS4fuE+j4gPFFs8XwgTX1FJAeAiCWfep?=
 =?us-ascii?Q?pbC2jrQL9nL23/TW4hO2h+pODZKz1RyXHm24AzgP7S87CM2FGAQikuHVkAsU?=
 =?us-ascii?Q?ZkHL3k/uqj1r4c8dHVIePkOmVBJ2HEE0Eq73eRhNlFGEiWzf6JsMKe8fO7Av?=
 =?us-ascii?Q?wn4pxud86gbM6qmGt+qouUma4WBKYRS0blOyOk6QCeDsRySZgSkUKKhfts7f?=
 =?us-ascii?Q?LnLLG3cDj0zuxHnDozsml9XKSaPehK3md2G/kOINMybtm/NQyy1vcOnVeJ/q?=
 =?us-ascii?Q?F4z2KVZS6vyuEGr/6aCqZ6mms9p9Ix7VL2gb4zAe5XcvhoQP1MpKlFXBo6Hf?=
 =?us-ascii?Q?/v5mPr7o/MCSX8wy6dwT3o+HQ3pv9fASLbzbo1Dh1q99N2VsVeF3hZakGARz?=
 =?us-ascii?Q?xoNZ1JAXkojF+4o2ZwGq0fhHwX8Ie//IYc4CHNTpXLYbWtuSWG7j58N5Q/MU?=
 =?us-ascii?Q?HZrEnr700bC4nooZJwEqqN8tixNo+i/7RNM2Ke/e2IDCeQPhjP6aBQnzQRWP?=
 =?us-ascii?Q?EHlaBgFJ+sRHbyE5bS/pTEQgZ/i+kZosfIGekPVOcQM0f1w4ye8NgflPQiKf?=
 =?us-ascii?Q?xXwA7CCYym1kAIxI5lgGWJIuqvPy6vhWHrvLdZ123ubbs/BY/Sj5QajoA+2k?=
 =?us-ascii?Q?rql6m3tFC3ls+hjE/WREl5G5N9SYrp25yQd+3LIQtaQoArrDuOKZKd8miRJG?=
 =?us-ascii?Q?z0JXAnref0W/0Q+6ADCiNq+S7hS377MXX/5Y9kJJWOgRXZ8rCFZmPumAfJaC?=
 =?us-ascii?Q?g582SFHXnin2dfRZ69EUeOtpkEhqPwFEIOcKwvK76gnVUReCQfaWIRIMsyxU?=
 =?us-ascii?Q?xupLg9ATnSlnk9Fa32sih+q9en4kjgcTBAsQyQrJgOUZyBUZj4qhG76poJs5?=
 =?us-ascii?Q?RJrFepvC0/Cta+DZSRlp42MBWz8N0OPY9FnWztQUUMEQinNeV5HiZ9yCBl/B?=
 =?us-ascii?Q?aLbORAprV4drCRhHoOMoTaaWZon2PLLnVEE3j4506knQveHNUpWmecB92vMv?=
 =?us-ascii?Q?wAYa7DSW2inizzhUyw+w4whavMbOmFJH4Hm6pQeTOC4jfMOcQH931Yqb1m3R?=
 =?us-ascii?Q?VFrFeg0qu+fS36m6Bm3FGQ5HEhfFZC0r/wFR/2c1HrrXrlN6YsPftl3e2IDk?=
 =?us-ascii?Q?6ZNbfNskBdudeTtZdDxH617DU6GgyYvzHPGIzvjvhGQ4u6dYLATycht5CHr1?=
 =?us-ascii?Q?bZD/oMOsqVTgP1u3qtA6SooDT4ckf/pZ0/8N/3pcLIj5DbgLO5DaDg8cUZr2?=
 =?us-ascii?Q?9ETaDjSl4xqfShQBJPk05MCLfqXl8JsvTL8ai+mgdEVc/rw5+eKHhCgeOQ42?=
 =?us-ascii?Q?ZUiT/mUTsX2KEDWmwheRN6h/hma77AHyNj+DpE5/x0c5oVM5p8gOY6NG23SS?=
 =?us-ascii?Q?wwzt6GN6cIjfJbDkGV2Ax4E27KSRbvkVaGEOVbn242jZlIw2GRmo59OumqWk?=
 =?us-ascii?Q?KX4J4sWu4EOVmBe/jt6c4ewyQjkXqZLQITFx+208amos2Kc9NjrMB3pO3ecg?=
 =?us-ascii?Q?kDOHEPz9J8Y3zu3XdzElb4Ri0d+7r/sRLK1Xc6/5CYknhC1hqj9mxI2VAg83?=
 =?us-ascii?Q?4hJVh75hVzCVQFDYAYj73koBnHdEphgqXjQTntCbEK6qgD/4o8Z+JGcnHLqD?=
 =?us-ascii?Q?DwDtJmf727hD1lIPSamsH4j90NLNzUpp1T2WafuJ9uWYTkbgZPLTwV37lh7B?=
 =?us-ascii?Q?i5j87Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7995a738-9dae-4688-190f-08d9c0938d62
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:57:01.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrNeBH3FLNOjSeusfNn4Oq7DtL8eg8IjxuTjjqKJ7YPZ4Q+qTjPcqkjYyfO20MD+ebF2Ws7+EeRQosYNH7rS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160072
X-Proofpoint-ORIG-GUID: -oyjhwP0pAuUDvK27rcl2RDJWhH2b1wU
X-Proofpoint-GUID: -oyjhwP0pAuUDvK27rcl2RDJWhH2b1wU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit d24fa5c1da08026be9959baca309fa0adf8708bf upstream.

In preparation to fix a bug in btrfs_show_devname().

Convert fs_devices::latest_bdev type from struct block_device to struct
btrfs_device and, rename the member to fs_devices::latest_dev.
So that btrfs_show_devname() can use fs_devices::latest_dev::name.

Tested-by: Su Yue <l@damenly.su>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/super.c     |  2 +-
 fs/btrfs/volumes.c   | 10 +++++-----
 fs/btrfs/volumes.h   |  6 +++++-
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e00c4c1f622f..244cddf050d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3229,12 +3229,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index a40fb9c74dda..3c7ee83e9199 100644
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
index 61b4651f008d..4af74b62e7d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7967,7 +7967,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
 
 	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 537d90bf5d84..e4963da4dd08 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1705,7 +1705,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		goto error_close_devices;
 	}
 
-	bdev = fs_devices->latest_bdev;
+	bdev = fs_devices->latest_dev->bdev;
 	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
 		 fs_info);
 	if (IS_ERR(s)) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc2e4683e856..4afa050384d9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1092,7 +1092,7 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
 	list_for_each_entry(seed_dev, &fs_devices->seed_list, seed_list)
 		__btrfs_free_extra_devids(seed_dev, &latest_dev);
 
-	fs_devices->latest_bdev = latest_dev->bdev;
+	fs_devices->latest_dev = latest_dev;
 
 	mutex_unlock(&uuid_mutex);
 }
@@ -1225,7 +1225,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	fs_devices->opened = 1;
-	fs_devices->latest_bdev = latest_dev->bdev;
+	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
@@ -1993,7 +1993,7 @@ static struct btrfs_device * btrfs_find_next_active_device(
 }
 
 /*
- * Helper function to check if the given device is part of s_bdev / latest_bdev
+ * Helper function to check if the given device is part of s_bdev / latest_dev
  * and replace it with the provided or the next active device, in the context
  * where this function called, there should be always be another device (or
  * this_dev) which is active.
@@ -2012,8 +2012,8 @@ void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
 			(fs_info->sb->s_bdev == device->bdev))
 		fs_info->sb->s_bdev = next_device->bdev;
 
-	if (fs_info->fs_devices->latest_bdev == device->bdev)
-		fs_info->fs_devices->latest_bdev = next_device->bdev;
+	if (fs_info->fs_devices->latest_dev->bdev == device->bdev)
+		fs_info->fs_devices->latest_dev = next_device;
 }
 
 /*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2183361db614..4db10d071d67 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -246,7 +246,11 @@ struct btrfs_fs_devices {
 	/* Highest generation number of seen devices */
 	u64 latest_generation;
 
-	struct block_device *latest_bdev;
+	/*
+	 * The mount device or a device with highest generation after removal
+	 * or replace.
+	 */
+	struct btrfs_device *latest_dev;
 
 	/* all of the devices in the FS, protected by a mutex
 	 * so we can safely walk it to write out the supers without
-- 
2.33.1

