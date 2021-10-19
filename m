Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119E1432B29
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJSAYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:24:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31406 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJSAYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:24:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19INrkfe031515;
        Tue, 19 Oct 2021 00:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=LJF1gGenL9Cmap5UMZTp0D5At5amfm5u81tLfe0V92o=;
 b=hC8yuLs3POmPKcePeCbX2jQEG3nqeb7uq8nCtioQc0WUG6N3RkL5w1GhK2Ujbyx+YdML
 YCqvxt5IEOPZXFmJmy0Fyya6V8+CIil8xmFrfwyftkFyXf01V3yZ1ix49VgYHOyCfX5K
 ttr2nrchXcQ5m3DI7Jfp2xfBeunPHAmrklzOJdTaxgr0JVOrPCDxCSLowMJDtJHQcqmu
 oBefPaesacM02p0B7ychFSl3IwmVzDazc9iGw5TgDis4Z8Ql3SQUzGheKjm7omtrJpIZ
 hwboojZ1Bvnu4rMdDWte/IptQCuxUn5HnKuejWMhK3SjbPj4lPGwIzFZIeXTsDCiQnJV Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brjxn775w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0FUNt102171;
        Tue, 19 Oct 2021 00:22:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3br8grex26-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLRTlgfHNPWx+UU6HvdAw2Io5aYT1hQ1KQhR9RS6tfrqNW6XIJ/CaCDtbgrp1GM95RrT2PDEhvxVtW5eeJaag2HwfJubZ+y2C+ur3ECMhwQCkJLRM+QBFsEcNxtwtZmaMS2oGq8ko2CEuNJ7h/tMb6Tm7yqSkyizat5w7v13d5Nv84Cm26PN1KZVzN+l68YzZN/yMAQzG5RwbZqB43htPiSLhbnb6/SP90a2rFW0YPjV8bPaVWDPb7AQVMeOfYpf04YWkTx4pqcXhHI0Gmdqw5C7k4IveFJ2DgqBDRU5P1L/exR/v65SCCOG8Ow0tjkoGaDG4RMnAat5s91bzVr9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJF1gGenL9Cmap5UMZTp0D5At5amfm5u81tLfe0V92o=;
 b=S6kMF9L5s9y2NJJabAfqlkGWmptc26Opr4MYsLEgzXnJsh471TI3Reqspl1yltvdSpvJFFTyNYTtL35DcUosVEaXlmEiOfe//AL4jn1HOYVOSMrZRms9rbPaSTIzIVIhrjixlWTd8Q4TU3jbB10+dOt7T6c42bYxoBFtgwIhuh/lYstWGAZWXY6RBdMKG+UDMWZsaRv06H0eVA7aB0CfA5QevyqhTtpscmk82GuFcGwkQ6bc/rVNXihtm0cv03fdKQNJ8P5yI42X4bKhz7UmElsxr99yje591HCpmAOJ/fThotRGzAOr+wdforWFMAyccBal1QDMaytgO0kKEMCCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJF1gGenL9Cmap5UMZTp0D5At5amfm5u81tLfe0V92o=;
 b=lCN3rErPqZ7Dq8tIW2SMdemK1g5ANZ8y5n8BMyShStqd5LTl/4yfJ23T9jLfxKdlmERihwtLFvopi6DjPIbHHLpG9GZvPV2gvO8+b3YmS3NitAX9wcQWqBna2R2J5EQaQy9qZE9bQAKOtdrv/IjPvcxqhW4gvz5Hb4pCXvIAj18=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3920.namprd10.prod.outlook.com (2603:10b6:208:1bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 00:22:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:22:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
Date:   Tue, 19 Oct 2021 08:22:09 +0800
Message-Id: <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634598572.git.anand.jain@oracle.com>
References: <cover.1634598572.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:22:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5df469c1-389d-466f-d441-08d99296887b
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR10MB392078749619DC3B3C5BBBA1E5BD9@MN2PR10MB3920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbQGKsBTHbSHEqemz1mW8hBTbKzJQIm8r3CtpvYn33CWz/QCIK6g2Emg3xzuxiM0YW+HMCPUO+97bgQPheskOgQT3Ifwm/3OFXC6cGUD1PLxBNNNtnxYWk3H3Fq15AoFmuDcB9KMmzmQanGV899vJeZ7ylLYcM13C7gUKILOTui1nxjGFclB1c7tPOUqL5Yl9GBmMD+OqXqjIt1i1uRfX/e1o4OsSQduG0rDA4kUrYDhuC9Oqq43QNCbHsiy/+6k2klObtv3bK8uaqbXPz1PveWYjd0MsgiqY3nS6bXvrUnyXL1mgipPV1zAgfmi0Mf8s9K8ZWCS/SziJvWvO/7XPo40qyKR/dUtKaWGuQAWwBVOb12eIO+JmgJPT9zjh8MwBTn1cuneXce+I2glGhJNACHNFIvSiNrmDFXvC+8lzZjQYYJnOyM1tO4nCGjANNafQIa+fXOSWs0a23C6OnwRFzqySBRAa+GJ0uh2mx4tGbIBZwkjsWkvjM9rz1Dhar+hR9vTGymdgQELRAqzqeCWwuak5WAmXuD4wMnMOlMSHpcWiININf54aZlmkESMUszIB13zRE3m+14fDODu2CAieN7GgRiRpDSkfWRsv1KfCL0RBy+QrPKJAMO6lZoQ4EaJrYGWPZ2Py6AhBDpDwsabKuSYzTwdVBvDqPFY3JSU9G5ZGswHZEluZoz0dLDeangcvqnb+XO5Sq9iZF9rjT7k4zdkpIZ1C5Fne0HGRcIH0vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66946007)(26005)(508600001)(86362001)(66556008)(52116002)(6486002)(6506007)(30864003)(186003)(8676002)(66476007)(83380400001)(36756003)(2906002)(6666004)(316002)(6512007)(38350700002)(2616005)(38100700002)(5660300002)(44832011)(956004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6z2R3UoCstEijnAOa1rMerQQ/grS4mpbgDMxNV5puWV/dA0ChNcC2f+9qeUy?=
 =?us-ascii?Q?sh9zxHDzAfJ5QNtmThIUSn7o61coTH7Go3dTW1WZSuE9s/+0pikNfQUWTYUH?=
 =?us-ascii?Q?MD4PVTzdLw7pAx04EfjoGRPhCAELTsr+5ucZXYb984A7hJxt7RAdo8ObRjE7?=
 =?us-ascii?Q?VzdtU3EbOEmi9Ye5FFEg4Qu7176nHp5zmFZOtzdWMqwQ7aTL0ETcQGdPKEJl?=
 =?us-ascii?Q?N93vO32OHXjG8S568dqZ0dAOCBdzIKdqvB0T+te/OYZxDSOKuKgZHhL2nXkF?=
 =?us-ascii?Q?grjeaXcqhRz7/EE0fxmJHQnNV6lSPhWDogQzWadRkzyfLWaHdscgfW6o52Zz?=
 =?us-ascii?Q?2B6mG3ATO/ThTL6zOrtcXUqeTKVcqE40+RKK4UIRfqUsI46cDry8ET9eMZFU?=
 =?us-ascii?Q?KvllybmiXvWLO14ZQaGsXDx6mpJySM25q2chpbHZTLi3NDNL3huAEiwU6buE?=
 =?us-ascii?Q?rrr8Nv12ZZrgRVF/0fYYHNFxey7iXg9NWOFrACPvkSaYBW0tCfi4bOSLtXZ9?=
 =?us-ascii?Q?T084Zhx7OYVpmuaAMSw53FpPJlZ5sRRgmRsfRIFURvglHdUWXUM/g1syEMJT?=
 =?us-ascii?Q?EpeB5fQDb0uyLDSpnZ8wVyTl7TAW32SsbAA6seOiy1xn9e3VnagVCHg64VOP?=
 =?us-ascii?Q?cbqrax3RHSXej5vFmJvHjEylta/eI5YO+ZEgnMZxNHqH3uJFzj731Lx7U5Xx?=
 =?us-ascii?Q?1y2BuiXHBA+ICbpwIkxZtGt4GaAtg3wB44trdVdZyopQij3L9NXGVMk095lo?=
 =?us-ascii?Q?jWDNN2i/CWvGEnIDJrYSC8nG9SOXf5xHv9W9gHJyEVfvBN/tT2jCmmkoCwBj?=
 =?us-ascii?Q?+vphtuy7VZugXafWT8nsoZw7DjHEm8XYkGHE3AUyP7iLe4B9JpImZVxZNw53?=
 =?us-ascii?Q?FjL2zC+tKvgyIugmXhvV8Y3QZtblo7bylZMJsaRAf1JpcSG3wtGyk9AsrsFu?=
 =?us-ascii?Q?+RgGzAZvwrItZT/5Myq6mD7L9qKvOjflvpHfPoPUzIc/Oef71P29ZfRKO8qd?=
 =?us-ascii?Q?f3LbdXXP7rdugA8e2IHmZlX3QWJoFaKUDYLGXe09iWvbXPYdGD5NmeOD4PAE?=
 =?us-ascii?Q?kxZ5dnEIxiKgihSu4CjRiN1ChxxhH+ck9O1FZMe2WpyqjgX4AsoBBITyXhl6?=
 =?us-ascii?Q?DEgw8XbFqgLbEgL5Q4wbubDRkiKsxY5M1auUsXp+dkiFMa5zg2fSnOobrL9j?=
 =?us-ascii?Q?2zgtIBe145Mk20UpcUKl4QHJH6hbAslpHDJr35W9c6bnkYubYP/YD3TaNRZ8?=
 =?us-ascii?Q?qlP4sJGP/c5csCQQIcxfvMMs0Vi4MrC/jmtRssC4Ug1ol3D//2NYa2Lq7BRW?=
 =?us-ascii?Q?AZHuvq8LDJGa9Qa8BXnj/9GQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df469c1-389d-466f-d441-08d99296887b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:22:28.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ0v5451JqleXYFJutBHuAepcDQ67F7XMLf89WvvJZtgODphSrnmAm2UNzlpiiDK/uBtsWKsFjiA+/Je37pA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-GUID: 6003ZXucM1KGtP2blb2YVJFgnUpyYvNl
X-Proofpoint-ORIG-GUID: 6003ZXucM1KGtP2blb2YVJFgnUpyYvNl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 2efc459d06f1 (sysfs: Add sysfs_emit and sysfs_emit_at to format
sysfs out) merged in 5.10 introduced two new functions sysfs_emit() and
sysfs_emit_at() which are aware of the PAGE_SIZE max_limit of the buf.

Use the above two new functions instead of scnprintf() and snprintf()
in various sysfs show().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 102 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25a6f587852b..c0ea7269ff57 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -177,7 +177,7 @@ static ssize_t btrfs_feature_attr_show(struct kobject *kobj,
 	} else
 		val = can_modify_feature(fa);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
@@ -330,7 +330,7 @@ static const struct attribute_group btrfs_feature_attr_group = {
 static ssize_t rmdir_subvol_show(struct kobject *kobj,
 				 struct kobj_attribute *ka, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 BTRFS_ATTR(static_feature, rmdir_subvol, rmdir_subvol_show);
 
@@ -345,12 +345,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 		 * This "trick" only works as long as 'enum btrfs_csum_type' has
 		 * no holes in it
 		 */
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
+		ret += sysfs_emit_at(buf, ret, "%s%s", (i == 0 ? "" : " "),
+				     btrfs_super_csum_name(i));
 
 	}
 
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
@@ -358,7 +358,7 @@ BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
 static ssize_t send_stream_version_show(struct kobject *kobj,
 					struct kobj_attribute *ka, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", BTRFS_SEND_STREAM_VERSION);
+	return sysfs_emit(buf, "%d\n", BTRFS_SEND_STREAM_VERSION);
 }
 BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
 
@@ -378,9 +378,9 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rescue_opts); i++)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				 (i ? " " : ""), rescue_opts[i]);
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+		ret += sysfs_emit_at(buf, ret, "%s%s", (i ? " " : ""),
+				     rescue_opts[i]);
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_rescue_options,
@@ -394,10 +394,10 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 
 	/* 4K sector size is also supported with 64K page size */
 	if (PAGE_SIZE == SZ_64K)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u ", SZ_4K);
+		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
 
 	/* Only sectorsize == PAGE_SIZE is now supported */
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
+	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
 
 	return ret;
 }
@@ -437,7 +437,7 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return sysfs_emit(buf, "%lld\n",
 			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
@@ -448,7 +448,7 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			atomic_read(&fs_info->discard_ctl.discardable_extents));
 }
 BTRFS_ATTR(discard, discardable_extents, btrfs_discardable_extents_show);
@@ -459,8 +459,8 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			fs_info->discard_ctl.discard_bitmap_bytes);
+	return sysfs_emit(buf, "%llu\n",
+			  fs_info->discard_ctl.discard_bitmap_bytes);
 }
 BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
 
@@ -470,7 +470,7 @@ static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return sysfs_emit(buf, "%lld\n",
 		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
 }
 BTRFS_ATTR(discard, discard_bytes_saved, btrfs_discard_bytes_saved_show);
@@ -481,8 +481,8 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			fs_info->discard_ctl.discard_extent_bytes);
+	return sysfs_emit(buf, "%llu\n",
+			  fs_info->discard_ctl.discard_extent_bytes);
 }
 BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
 
@@ -492,8 +492,8 @@ static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.iops_limit));
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(fs_info->discard_ctl.iops_limit));
 }
 
 static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
@@ -523,8 +523,8 @@ static ssize_t btrfs_discard_kbps_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.kbps_limit));
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(fs_info->discard_ctl.kbps_limit));
 }
 
 static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
@@ -553,8 +553,8 @@ static ssize_t btrfs_discard_max_discard_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			READ_ONCE(fs_info->discard_ctl.max_discard_size));
+	return sysfs_emit(buf, "%llu\n",
+			  READ_ONCE(fs_info->discard_ctl.max_discard_size));
 }
 
 static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
@@ -627,7 +627,7 @@ static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 	val = *value_ptr;
 	if (lock)
 		spin_unlock(lock);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t global_rsv_size_show(struct kobject *kobj,
@@ -673,7 +673,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 			val += block_group->used;
 	}
 	up_read(&sinfo->groups_sem);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 /*
@@ -771,7 +771,7 @@ static ssize_t btrfs_label_show(struct kobject *kobj,
 	ssize_t ret;
 
 	spin_lock(&fs_info->super_lock);
-	ret = scnprintf(buf, PAGE_SIZE, label[0] ? "%s\n" : "%s", label);
+	ret = sysfs_emit(buf, label[0] ? "%s\n" : "%s", label);
 	spin_unlock(&fs_info->super_lock);
 
 	return ret;
@@ -819,7 +819,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -829,8 +829,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -840,7 +839,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
@@ -852,7 +851,7 @@ static ssize_t quota_override_show(struct kobject *kobj,
 	int quota_override;
 
 	quota_override = test_bit(BTRFS_FS_QUOTA_OVERRIDE, &fs_info->flags);
-	return scnprintf(buf, PAGE_SIZE, "%d\n", quota_override);
+	return sysfs_emit(buf, "%d\n", quota_override);
 }
 
 static ssize_t quota_override_store(struct kobject *kobj,
@@ -890,8 +889,7 @@ static ssize_t btrfs_metadata_uuid_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%pU\n",
-			fs_info->fs_devices->metadata_uuid);
+	return sysfs_emit(buf, "%pU\n", fs_info->fs_devices->metadata_uuid);
 }
 
 BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
@@ -902,9 +900,9 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
 
-	return scnprintf(buf, PAGE_SIZE, "%s (%s)\n",
-			btrfs_super_csum_name(csum_type),
-			crypto_shash_driver_name(fs_info->csum_shash));
+	return sysfs_emit(buf, "%s (%s)\n",
+			  btrfs_super_csum_name(csum_type),
+			  crypto_shash_driver_name(fs_info->csum_shash));
 }
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
@@ -941,7 +939,7 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 			str = "UNKNOWN\n";
 			break;
 	}
-	return scnprintf(buf, PAGE_SIZE, "%s", str);
+	return sysfs_emit(buf, "%s", str);
 }
 BTRFS_ATTR(, exclusive_operation, btrfs_exclusive_operation_show);
 
@@ -950,7 +948,7 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", fs_info->generation);
+	return sysfs_emit(buf, "%llu\n", fs_info->generation);
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
@@ -1028,8 +1026,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	ssize_t ret;
 
-	ret = scnprintf(buf, PAGE_SIZE, "%d\n",
-			READ_ONCE(fs_info->bg_reclaim_threshold));
+	ret = sysfs_emit(buf, "%d\n",
+			 READ_ONCE(fs_info->bg_reclaim_threshold));
 
 	return ret;
 }
@@ -1264,8 +1262,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
 			continue;
 
 		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
-		len += scnprintf(str + len, bufsize - len, "%s%s",
-				len ? "," : "", name);
+		len += sysfs_emit_at(str, len, "%s%s", len ? "," : "", name);
 	}
 
 	return str;
@@ -1304,8 +1301,8 @@ static void init_feature_attrs(void)
 			if (fa->kobj_attr.attr.name)
 				continue;
 
-			snprintf(name, BTRFS_FEATURE_NAME_MAX, "%s:%u",
-				 btrfs_feature_set_names[set], i);
+			sysfs_emit(name, "%s:%u", btrfs_feature_set_names[set],
+				   i);
 
 			fa->kobj_attr.attr.name = name;
 			fa->kobj_attr.attr.mode = S_IRUGO;
@@ -1471,7 +1468,7 @@ static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
 
@@ -1484,7 +1481,7 @@ static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
 
@@ -1498,7 +1495,7 @@ static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
 
@@ -1509,8 +1506,7 @@ static ssize_t btrfs_devinfo_scrub_speed_max_show(struct kobject *kobj,
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			 READ_ONCE(device->scrub_speed_max));
+	return sysfs_emit(buf, "%llu\n", READ_ONCE(device->scrub_speed_max));
 }
 
 static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
@@ -1538,7 +1534,7 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
@@ -1549,14 +1545,14 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 						   devid_kobj);
 
 	if (!device->dev_stats_valid)
-		return scnprintf(buf, PAGE_SIZE, "invalid\n");
+		return sysfs_emit(buf, "invalid\n");
 
 	/*
 	 * Print all at once so we get a snapshot of all values from the same
 	 * time. Keep them in sync and in order of definition of
 	 * btrfs_dev_stat_values.
 	 */
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 		"write_errs %d\n"
 		"read_errs %d\n"
 		"flush_errs %d\n"
-- 
2.31.1

