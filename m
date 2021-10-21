Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7B43664F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJUPd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:33:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51568 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231939AbhJUPd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:33:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFIDjf010260;
        Thu, 21 Oct 2021 15:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=FJ+fDI5Auq6DwO4Mcy9MCx8aqG2mc15LBQwoOq94jJs=;
 b=QFGX3ihkNzupie2AnZYVC1I8QuBw+BPMYZmL0TgEooOhgEhX0k8EGrGhqXPkomvb5pgT
 TkePUoes7u6W1+CgsuGksdIe9y8slwPF08QBZt28WiaRDFrK8Y3uuc4yfhrnBH9h+uXB
 GRE1VxxwYWJ7jjm9C76LfPMDWuVCMBrHKsmCe0/oYnkm276a0Sq+hAHTqoQsxuPk4tW1
 Z0mlDZifHfGLL36RRsYMb22VN95DPRVbkOYP+imVS6oBQyS+wVC8hxyYqSvp5RSyCxHa
 J1wVP4FLGV8hbkjC92jYEhjr8myjpvsQObzoEATLkhXaUkOtS6e+6HyHmHVUXB+gJ2qI DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqypnycg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:31:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LFVEWd076337;
        Thu, 21 Oct 2021 15:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3bqpj90t19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B05PIJFKAWxao9bpkmTJAI2wbrXlgE56mpkq5XBPLLrI+NkQhHikdkFU2FqBQBM4FnKuE4qPeEXG0s0gyaTFEth2vt39c/BSmnF0M+HPhWas1T8WJOg9ETvVdLobivXayiHd2V3GLS3Rr/F0x7BYtDR5Gl2XkNxyGaF1XFcoqjCZJKqdPdu5GAS6QcWTaXs1af+E2c+IYkq0I045q3VB1vySrGl5p0HuxEASuSF6bSrJPR2366WoEPK5h+Oieujztn9xww7U1staxnh4UxDOKkLSEOUhaEUQhCa09gTc2SRjNxyEsElGssp4S62I2fuAVZo0D9Vi4rl7YdWYO4rv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ+fDI5Auq6DwO4Mcy9MCx8aqG2mc15LBQwoOq94jJs=;
 b=gte1uIEJC3Ox66zTPyjM2dn3I0TKtyDeiVY75zkxEPM/yUkxmwlu/eEqMp2JIMVRcHnj6cAwlx8aZb0hULciyXciR5YDO1F2v3iuIT/HbeIPv7szhJ9CccpRfxiBeTSd8sdoGMbU2yqWs9KjwItNWxUSbxfafXURxx9darYg8LKkZRqrCkb4ueQHhIXeTW0DTgE/M5Cv1D7PsXEdNRiEKuNurgoDjMgfL/zqyeJYSfIaAFFJBHexqeYKgqpatoLqlldlTcN+95YREGhZ5WIMigO6N4r+/FIAJBn16eSoPUMsSoiM8FtHNZbD6aTKVIn7lzeCLQdSI6cGlI33BVpPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ+fDI5Auq6DwO4Mcy9MCx8aqG2mc15LBQwoOq94jJs=;
 b=ZT+QXSZUv+vu3iL+/MkbfiahG3Z0nxn4ro3lNIOsudHmSqSCF5nJpPAvZasT4QOkb/cdhuBvxjbPWThGz+PKUzYrslO0TbuJuN4ffnbDJAbMrKk4mFRjoFsIHKirleQhhTZ18OSO6byUnbE+ucOLxdQ6jfROc+gwX5dnWWvykec=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3839.namprd10.prod.outlook.com (2603:10b6:208:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 15:31:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 15:31:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/2] btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
Date:   Thu, 21 Oct 2021 23:31:16 +0800
Message-Id: <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634829757.git.anand.jain@oracle.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:4:193::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 15:31:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502fefc3-026c-4bf0-2699-08d994a7ddb1
X-MS-TrafficTypeDiagnostic: MN2PR10MB3839:
X-Microsoft-Antispam-PRVS: <MN2PR10MB383982DCA2E499DD07F0C0F9E5BF9@MN2PR10MB3839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXSzmHd4eTPHa4qpUZ9RTfkbeEtIrHE+5WQ3416Z3do6I5WFwefUQCijDrNGOFRaQ//G1lqhkk9Xx/zOZr1CLMs0QSiNM+fkJ2FUymO2ivFoGCQPrxeCLNL6239iI5FuUFNqRiImcI6aHMhmllT/+Ddyk9/amsMZRVSa8MIT+OZXdj0Xz+HGYvVMO0iAJqlZEQDzDU0cVJMpVsPHIz7AmVGj02OqAd1wHvQ2gYZb5sYroGfRJUzWZZfzr5l38QEiywfSojnxeKh1AMe+hoQj5G5JSeVcE2bED6j5V3BE86VFGPlHNUePBwyYUXpBRPHSOppT9gtEJKIrfwe9wUhqHRDH9bnWzHYsJsUkPA5fqgvQ8VF+NRr6qTKJo/Qu+RBHAL6srRzdwsank+gN23zGfq1Kp7VINPVieWh+Rh31nJxRYd35eQoXMrPngd+UvoBSd8tHQXaSDxdosA02wOldmpSBLwzYTYAFQR4tXy8JyvMYa3GmBviMAymAN/wkiyf38uTMV970pXKZpmxwcJqvbpOnl9SqV1K11eqs+/zSIp23OkAMf8kJGakaiMxW8cnISjj7lxq5afSN68dhQj5/BXGpSwqlepxnAv8+KD0qHZKvW5zqfORqPtP1FTwOKjcQtuYH5ozV0tCBf20uivbmnYo2NbSyt/xQgw3X9RRZw8jCYSyV74wNCjiX4yBdtU1UG6fEdZxyTYO46rHbatDm7iscwqEHJLSnUwzm2QarVZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(86362001)(30864003)(83380400001)(186003)(4326008)(316002)(6506007)(36756003)(6512007)(5660300002)(38350700002)(2906002)(6666004)(26005)(66556008)(66476007)(66946007)(8676002)(6486002)(2616005)(8936002)(956004)(38100700002)(6916009)(508600001)(44832011)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6skZVm//Yl6/jtM2crq+qs7salc51JW23oh1kKx8exALeYBPQwWSJVMJbPJ?=
 =?us-ascii?Q?ZBu90qTno3w/h2X8V+t9yuYx/M3nLvHoW+ORHTAR72pGFFuiFqV8Wjms/IQp?=
 =?us-ascii?Q?OrjKLTgohh3kg30b5grudM0piFWOX9S2dYCHrbKAnm1xYwCiiv61kyYz/iYq?=
 =?us-ascii?Q?kj5HilvO4/gUba8cpVp+/Mqdvtjsx/bvYgV74MjqK88CzRzCajIoX6J5XVaN?=
 =?us-ascii?Q?+LwnE9I7J4fPnWw3tFE7UziDVtx+e1ZwcZz0gD6VPRW1B112od+RqsewRb2K?=
 =?us-ascii?Q?4tXbsSAemjuF5CuiBDUb4Bhujtu65TZPfAp1U4wrq1Uxtp7/+RYYpFKlCAf4?=
 =?us-ascii?Q?ruYcgmrqLwY5eWiUtUrZlZpcZw1mWRRZlw/sq6HCB5pplTLCMn5dmS69YnDv?=
 =?us-ascii?Q?JNg8apIg6/pYh5zN96QjMqs29Yw6bAxlpJRTVcOzTrggeNdlLB6vyvhKL5AL?=
 =?us-ascii?Q?sIrkdACSDt6tcDB7PrNuHSytCTwmdpKXnQZFCczA5/hBygZBgki2hgjLSLyD?=
 =?us-ascii?Q?4ssYvynMCdCiJ6A13fiGgnRiAdC5j6ICI5hZsY3O0g92nT8Jun/CiwwEhA9i?=
 =?us-ascii?Q?bj3UkgnrFLgz5G6FjMa8Kwa2pdj4Y2EoG2VU44AgEZXsUI0Py65gMo8x7lbr?=
 =?us-ascii?Q?7DsoRqqj3+QawTb8zkzaif/RClULdAhqBO8HGOVh6g4Xr4BwMMLahOUT7hT+?=
 =?us-ascii?Q?giB+HJPjfRsB9fxoaWKl74StwsLPEw0mcSZwDdvIT7LQI5RpCmIkLRyHJ8BG?=
 =?us-ascii?Q?apAZ85BCbQ9toocjNycduVuQgjktqLOQh5rHjzoXtcvy5lph26nsP1VhRLqS?=
 =?us-ascii?Q?tOg9IE4U1xH4PPh4TcsNdTNk5g4Gd1eYotkJ1wi3wltfOXbgLfDvCaZZKAuA?=
 =?us-ascii?Q?u+o4p1yWmT+WDZMPvmFq5OeDmv3F8l9rx9xKyg4i6bWUdS2Huqpw/IAYvbRq?=
 =?us-ascii?Q?tkhfDHcc9DiRYC+Ebra3V1bNIVKIqRMuKq5UnBqED2Z5Owqt24Xj2L7BS7yK?=
 =?us-ascii?Q?wVLjbPiZ/dx6W/JEkwi2My+9r6hkLFSHeUvsjcfmhTucf9IB8gzzazyqxwNW?=
 =?us-ascii?Q?VcS5ly4BxbNrJkoaGl8hv2lV7UtBPFSfqviBcRjnfeVxKDpEkWv8SvIRnwvn?=
 =?us-ascii?Q?5AdYh3q2ir3e9jqIeCahN9EgfsbqH52cCIX7+H8SsP7KtyHmo/5b8LrtJgqB?=
 =?us-ascii?Q?TmXstEo3BoY4S0dQUg/BG2JRItMUtoG+HqeWfDgN0wW9/PLjFAoZSvK1Xw3O?=
 =?us-ascii?Q?aZW7OmoiCyzXsUuIj3uFQSa5277MhaDrdX7U2wpMXp2fumVMY5482xvwZab4?=
 =?us-ascii?Q?xJ8pd61cb4CRelPE14nfGANi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502fefc3-026c-4bf0-2699-08d994a7ddb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:31:36.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3839
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210080
X-Proofpoint-ORIG-GUID: umccUyIcifjHi78xXq5lgASpDQKXhIqP
X-Proofpoint-GUID: umccUyIcifjHi78xXq5lgASpDQKXhIqP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 2efc459d06f1 (sysfs: Add sysfs_emit and sysfs_emit_at to format
sysfs out) merged in 5.10 introduced two new functions sysfs_emit() and
sysfs_emit_at() which are aware of the PAGE_SIZE max_limit of the buf.

Use the above two new functions instead of scnprintf() and snprintf()
in various sysfs show().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 fs/btrfs/sysfs.c | 95 +++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25a6f587852b..28ff7fce1ac5 100644
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
@@ -1471,7 +1469,7 @@ static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
 
@@ -1484,7 +1482,7 @@ static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
 
@@ -1498,7 +1496,7 @@ static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
 
@@ -1509,8 +1507,7 @@ static ssize_t btrfs_devinfo_scrub_speed_max_show(struct kobject *kobj,
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			 READ_ONCE(device->scrub_speed_max));
+	return sysfs_emit(buf, "%llu\n", READ_ONCE(device->scrub_speed_max));
 }
 
 static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
@@ -1538,7 +1535,7 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
@@ -1549,14 +1546,14 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
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

