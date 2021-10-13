Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D242B9D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhJMIEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 04:04:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11434 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhJMIEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 04:04:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6xpPE013097;
        Wed, 13 Oct 2021 08:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OuXTNzWIogsqt6Xgk37+A6/wXVtASBLpsgDXFHIUyTA=;
 b=fSXyxhQLzXFq+EHtCHu6XasoGC+7wfbtU6vbQBSQQT5WkvL1xrAkdckgp+UuDK1KgGuq
 DWIvyfpTlMxMbiRATckVgKIlD0HUMfljfzq9ngjdh71wFrfdlsEfsu4pMVBAyoifcIK8
 aR0wbJHkhMgduNUIcKxoAcCP2oQoXrGDTHFYXXdbr9AvGGL5BSd6ffPf/pHstfFWE0fe
 qEYGgrAMxIHa/wPNd85QiEDvafz8fQFGHbJfhDiZrSyviNFMiUpiP6/E77xfg0D2BwsF
 JgCzDBoi1j1nC829LDKj5i4LamYlkYVQZBOcckaeQZeUc5zkIXh4Ilvy/Btc1TlgnK0B cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbmt65m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:01:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D81Bca044474;
        Wed, 13 Oct 2021 08:01:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 3bkyvabpe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNPf2/wv0ow2wuNeKTX5NIMTpPnbThf0t7Iahzafj6iPhM1Fm8aE+mcrzkBTox0OOyGnxSoCjww8lwVI4hbSG+BO2sLTniuNEesFjP1bBumOaMEU7+1EU6lCMQiPRPAVf5GC0fjCDl3nCkZ7pPusAt70aPk5T7Hw0OA7sKZ1m4dgSV/CP0bYyNtC842a4QeiixSbzHRbHaVKCK/7ckil95/9fPjEZiUUY+GKcHLg6ptM5Sh0jmbVfVHoeut0+XbueHtignIMsBgmVn4/agMPki/gRre4F8FjbqIPlP8Bg0D9h7wmQfiBteiqvTsb8Qgb96q5afg4S13OdHCPtHvQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuXTNzWIogsqt6Xgk37+A6/wXVtASBLpsgDXFHIUyTA=;
 b=dhOpvYJUqbav4aQblocYWEgM4XArEuJpCbq8oPJM4xJoqkINgCk/0hCQHMBJcBqsAwxB4DQvuzBjMyeZ4Cc6tQWtTH4lKC30hjTEuMztaHV+f4mptZD46yNH6oXYvhyDd4xSRMzNo4TG3Aq95ODWukrkd98f68lcQ2sASLw4r5FaIdt4Ft4fUoH7bqFFmXM08SvVftFyEVabgLWhysSf8PEzSG1vUYJ3QwJxziE22UpRtCplGVXfH1PGFXxeUQWk/R9JTbrQzWMttZdqGZpeIYYyO1oHUMcWVDTQ2Cv9f8YurLBOh/4xiN4ZUUtUObt8r8K7UumeCLZCFG+nY+P6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuXTNzWIogsqt6Xgk37+A6/wXVtASBLpsgDXFHIUyTA=;
 b=NaNWdlLZaApLYNGzP2gzMoV1CqexQwRum+2guyEs1WqXM24as3QbABXaxf+Oih39LEdGJ49342gYOYGgu/e6EjHOqGDcLJlhOF9Ntra2xowz34yC3scHnqjmkl4sLmjzBr6G5gE47KglNz6wj2KHxYLllaEwZ6xiFVF/QN9/Dxc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3838.namprd10.prod.outlook.com (2603:10b6:208:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 08:01:52 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:01:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v8] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Wed, 13 Oct 2021 16:01:37 +0800
Message-Id: <6585e7d938e6600189c1bc7b61a7c76badef18dd.1633003671.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR04CA0004.apcprd04.prod.outlook.com (2603:1096:4:197::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 08:01:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168e4703-5e0b-4a53-d7eb-08d98e1fb78c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR10MB38388357F0444AE33169C39EE5B79@MN2PR10MB3838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YZCjqV85PNpe1BMHQBP9rsf38CiRbxXW6FTfby5pHgXaarQ1RkfKP4qTWRpKez764UY8FXyg9a4w1bDxFrtZvwNfRVVAF6I5TWY1jzqSRPB6YqmVsnR/+fpOEwOafka40oh1UBLHzAyog4LOPjjfhbAQC44Vwo5bg4KDWyhyY+NE2loDFqfdCJOy57cGnLQ/EVVbdf/Ll2itp5SPRobZ4rKDqaX3D6nYrtmkMhiE2kVRDFoCUrx3g+5HP6cffzPoGr3IyTlGXITv78CCD8rttkJlyYZwbszMjHlriHklVz5CaLWgJ9mf0v3AndLCN5jtvinCt7b4n45hTGLPMF7XCN/DFdpNhaQz06rzBkEFjFPGRI6i/ZvXFp76VODYkSkuK17KM6bwsuJM4cwSn7VLTYndmFJ2zVXhBcA6ZTB4oZOhBkZerqyq8Ga1KgC7PkEMhRj0dbKjBcZrav+9XcxA212jRacsMR2hUBu7IxolkOc7o7ifHBpg2tw4pDO2syJPt5OYzoDd050em4jKPEXpLjyTaiMB9o7TBy6p5r2V1bviYxMYN14n8gx4NyanjgbiX/G7c7KHJQDvKTlj0iiEyANLEYMKITRjRmWQ/j5JV0XN0BSXNgKuvZnQcp65TVZVdk433RV09OsE+3giA1eucgY7QyQoZM2owyWOw16wU0PCyExC+wgaNOzk3tzoPiL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(316002)(83380400001)(508600001)(2906002)(5660300002)(86362001)(2616005)(36756003)(6506007)(66946007)(186003)(8936002)(38100700002)(6666004)(38350700002)(66556008)(26005)(66476007)(6486002)(44832011)(52116002)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9f4FliEoJgKttxNqdQoHyFu9VPraR0uHE7awSmrP42p8lamQBKv3FRBXzJxf?=
 =?us-ascii?Q?I1mIBLbTCP88Xd/0RchqrxUS0lOst9HIx6GDFAKgzrBuSTcoWS4jOnZHHRKS?=
 =?us-ascii?Q?4pN4usp7vEGM2bD9HJZLQMuwQWzads7eiV+GIR11um9VGC9wW0f2ioAUsdtC?=
 =?us-ascii?Q?QgB0wTwU+BLsGE5Sgvsugxn/ai+7J5/ow4e9/kvTgyXxrC8i+o1zn1DjUyIZ?=
 =?us-ascii?Q?Jkm5aIdOJRRpbaV1FgLiOxjnbIj8phWrj3dooZR72AIAIKgA4jukXMlg0EAL?=
 =?us-ascii?Q?jHcgzpF/uwcnwriShdcEipCEQBVQHW/JfmW/zX2RLAxW29axTwvX0VxSFXvX?=
 =?us-ascii?Q?E3ZgHnBNmKD+ZmM/2spxO3eCSJBK8S+/x8RnoYkHrvLC/10AMw63JGGOLx/J?=
 =?us-ascii?Q?H1tCz3u3t05QzyS93zaZPpgJSmQCxXVCAx7SDwd3Cr+pJtkXx+QF5q7hzAKn?=
 =?us-ascii?Q?okAGtDB4eiHHSe6zF8XuQfLEUd2XJyhYoIN/kYKDWbXxsH25XaDcKL5kgbJ4?=
 =?us-ascii?Q?cegjpDGp9Z3+TG8K+yZEpSHYZKINqB5PeR24VUYY1r+guw0KcoiRDGO5jZhK?=
 =?us-ascii?Q?r0x5r1zF8EAHsmZWSK/PhfSqO/uLf2MQEXvuA4IXMBgK/b08EpGgRmtzhJnM?=
 =?us-ascii?Q?Ng+B95Nple/fs0e8f5HL7PI37wItKdeEEaZSwGdAB7tBZVSWzT7wF06ub8Qk?=
 =?us-ascii?Q?ZwhMu6PH/9jLTPW8fyOw31EA3kUa49eUnUiObnwXNtToZX67rb1UICWIN4bi?=
 =?us-ascii?Q?I6h/IK47iTtLeOXp966mCzmYH+2fLXoqU95couEgdBnGQECLARAZbJuQ2Ndu?=
 =?us-ascii?Q?hq6vKqlS195RcZvVtBh0CaqsxUUdpWqPUUJ+JihYQOm0U+YGulZV75Jkzi8H?=
 =?us-ascii?Q?KyUIQ17G1fCjVM8nNepzB12OuyNKMMud8iwAredYVVIbfvbfQAzO4GJ1Fmj8?=
 =?us-ascii?Q?wz/ituses2MZX/r9u4BdPP3CVpyY8+wVeDQIHNTNE+LjL4Wk7zH4+UTJXfzj?=
 =?us-ascii?Q?as0ZFCyltXCwxSQODkPfeXPIEeSqfQVBNDgEwxNR8BceB8mwoz6sQSYzOPzc?=
 =?us-ascii?Q?8KrpZ6As9QPj7QGGuCsqgDDEgHk/4RmOmPOqXLKCQjvLyAKLnlulbI93cS0F?=
 =?us-ascii?Q?M54kbBM909VwE6y3fUtCxcfnPuAmjGqSW6Ut6OnRONcr5AhtfQe5e4tOmyj6?=
 =?us-ascii?Q?HLkH5lSwTbYFskbHMyx82gof6zbYJgafQqUW2OXQEyjsKD7xywHPDLj3uhVk?=
 =?us-ascii?Q?7P1/Bs6u1ktKU1/i8dAe9vDnHBEbOH55AowQM/oF2vhNzecnQlrJFUMT5Tdz?=
 =?us-ascii?Q?l7Y7Lol3ysQbBqd97PHyQLjk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168e4703-5e0b-4a53-d7eb-08d98e1fb78c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 08:01:52.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa8JV4VbJvCgqu06tvVgM7KF2j+6DcacWoWZGiO+wUGevnqHnJ1+sHVFEp3o49j/QrAgi7Y1uT9uRVp8Y78ROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130053
X-Proofpoint-ORIG-GUID: 2bhLNhIlB92iBiHEYiXTHTO0L3yHFeYC
X-Proofpoint-GUID: 2bhLNhIlB92iBiHEYiXTHTO0L3yHFeYC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
so that its parent function btrfs_init_new_device() can add the new sprout
device to fs_info->fs_devices.

Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
device_list_mutex. But they are holding it sequentially, thus creates a
small window to an opportunity to race. Close this opportunity and hold
device_list_mutex common to both btrfs_init_new_device() and
btrfs_prepare_sprout().

This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
btrfs_setup_sprout(). This split is essential because device_list_mutex
shouldn't be held for allocs in btrfs_init_sprout() but must be held for
btrfs_setup_sprout(). So now a common device_list_mutex can be used
between btrfs_init_new_device() and btrfs_setup_sprout().

This patch also moves the lockdep_assert_held(&uuid_mutex) from the
starting of the function to just above the line where we need this lock.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v8:
 Change log update:
 s/btrfs_alloc_sprout/btrfs_init_sprout/g
 s/btrfs_splice_sprout/btrfs_setup_sprout/g
 No code change.

v7:
 . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
 1/3 is merged and 2/3 is dropped.
 . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
 than just alloc and change return to btrfs_device *.
 . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
 than just the splice.
 . Add lockdep_assert_held(&uuid_mutex) and
 lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().

v6:
 Remove RFC.
 Split btrfs_prepare_sprout so that the allocation part can be outside
 of the device_list_mutex in the parent function btrfs_init_new_device().

 fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8e2b76b5fd14..10227b13a1a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2378,21 +2378,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	return btrfs_find_device_by_path(fs_info, device_path);
 }
 
-/*
- * does all the dirty work required for changing file system's UUID.
- */
-static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
+static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *old_devices;
 	struct btrfs_fs_devices *seed_devices;
-	struct btrfs_super_block *disk_super = fs_info->super_copy;
-	struct btrfs_device *device;
-	u64 super_flags;
 
-	lockdep_assert_held(&uuid_mutex);
 	if (!fs_devices->seeding)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Private copy of the seed devices, anchored at
@@ -2400,7 +2393,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	 */
 	seed_devices = alloc_fs_devices(NULL, NULL);
 	if (IS_ERR(seed_devices))
-		return PTR_ERR(seed_devices);
+		return seed_devices;
 
 	/*
 	 * It's necessary to retain a copy of the original seed fs_devices in
@@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
 		kfree(seed_devices);
-		return PTR_ERR(old_devices);
+		return old_devices;
 	}
 
+	lockdep_assert_held(&uuid_mutex);
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
@@ -2422,7 +2416,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	return seed_devices;
+}
+
+/*
+ * Splice seed devices into the sprout fs_devices.
+ * Generate a new fsid for the sprouted readwrite btrfs.
+ */
+static void btrfs_setup_sprout(struct btrfs_fs_info *fs_info,
+			       struct btrfs_fs_devices *seed_devices)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_super_block *disk_super = fs_info->super_copy;
+	struct btrfs_device *device;
+	u64 super_flags;
+
+	/*
+	 * We are updating the fsid, the thread leading to device_list_add()
+	 * could race, so uuid_mutex is needed.
+	 */
+	lockdep_assert_held(&uuid_mutex);
+
+	/*
+	 * Below threads though they parse dev_list they are fine without
+	 * device_list_mutex:
+	 *   All device ops and balance - as we are in btrfs_exclop_start.
+	 *   Various dev_list read parser - are using rcu.
+	 *   btrfs_ioctl_fitrim() - is using rcu.
+	 *
+	 * For-read threads as below are using device_list_mutex:
+	 *   Readonly scrub btrfs_scrub_dev()
+	 *   Readonly scrub btrfs_scrub_progress()
+	 *   btrfs_get_dev_stats()
+	 */
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2438,13 +2466,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
 	btrfs_set_super_flags(disk_super, super_flags);
-
-	return 0;
 }
 
 /*
@@ -2532,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct super_block *sb = fs_info->sb;
 	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
@@ -2615,18 +2641,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
-		ret = btrfs_prepare_sprout(fs_info);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+
+		/* GFP_KERNEL alloc should not be under device_list_mutex */
+		seed_devices = btrfs_init_sprout(fs_info);
+		if (IS_ERR(seed_devices)) {
+			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
 			goto error_trans;
 		}
+	}
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (seeding_dev) {
+		btrfs_setup_sprout(fs_info, seed_devices);
+
 		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
 						device);
 	}
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
@@ -2688,7 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 		/*
 		 * fs_devices now represents the newly sprouted filesystem and
-		 * its fsid has been changed by btrfs_prepare_sprout
+		 * its fsid has been changed by btrfs_sprout_splice().
 		 */
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
-- 
2.31.1

