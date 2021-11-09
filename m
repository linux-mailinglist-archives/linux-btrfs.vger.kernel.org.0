Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312A144AAFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbhKIJzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 04:55:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26290 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243025AbhKIJzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 04:55:12 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A98SbU4017452;
        Tue, 9 Nov 2021 09:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=NB83R15Ili0zQTLOP1hT3kY1u0Jrx/d/nA6tS1HJcLo=;
 b=mPE9jor/BDrh330yIvgG2ly7c9+OUWaitwMs/BJVYa/BrtuVjCMLT6BZnaR4aKPj86eM
 MHBRplywqxssCkhCks+/q8Vt56z/l8KbboOebkiCQH7SuX14ASUFQP7t/qJ8GD1tqCAG
 b3CkGblebd0RVh1TSJTUuCSJ3VxKfYBf2XVYRszH3l4KEWOucyCQ3isC2V6qVgz3vuzx
 gCTOjkfa2VyHIJCmkIo9FK7XTm4au/OgUHzt8Gm5CYdDECA6P9b6I0bh46RTZHB6xo+b
 nOcjoNn62hL9nO07sRObcvbXbDq2h3EoAcdup0fFeFwPfCR2TA2xsSBBkur53c/a+w2n bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh4htu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:52:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A99pMqR170559;
        Tue, 9 Nov 2021 09:52:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3c5etvcqhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGlD3CBJHLjQjHb0kMgM/ijDMESBE6vYnPUqPwCIf6Azo6/nHpDjrYmjW9rNcIEicYMmZW06zWjT4bawfQnjpJz9UDuivZXsS8L2uVJMuOi0eAcdz9sQSENUxwe608G7k3S0rb0qnlaco/RdRBydZdQiRFIMwhqE39QTxaj507+MT+mfOHvSRkfwymjNRN1pnHq2HV2nUXseLto0CIzGqobgH5hMRlgsTY1YYC7Lj+qY6ehYywqFE/yO1qmlB6v6oNNOYZB95MK6mi0jQOsF5LoV8kXYQ/Ip3AXqGpcD2nSmwspEalEFmHyRiMmJTzs8vrRYsuLXAQf1VtimnmINkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB83R15Ili0zQTLOP1hT3kY1u0Jrx/d/nA6tS1HJcLo=;
 b=T0k1wwfIJB8yr97XAoj5ZOE0cj+hLoXC/7c2ch6YBKqhJreiKEnZ1hbg6e1SmYdpIgxlAym7iIz1sc5xajNC1vbnKaIzAFZdTd85pWZo2cSCiZ97S2hfBB9U4e0TJBbQ6nrIGwbYx4ejdjNx+ocoydXShFJjIMqeTCQ+FZEGbCxeHZT3M42XcYwZZXpNqWiJY6RrBE0xCBpnvx2WQ6GRTmeFSrFrvrEgNUcg7vaYJttVJLV7pCo2G0nEPqKxcHt3QHP4zBJxmXecuOeCsPl2FzEnsNSXOiGanVUWNqqjlepelAoW1Lf6FW8pYrGiHGuGH79dyhSJ+6wNPFWdixxokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB83R15Ili0zQTLOP1hT3kY1u0Jrx/d/nA6tS1HJcLo=;
 b=G1q35bEYPJnf+WJ+RLbrNkXWE/IPIhtBcSVObC1Iq0n3T/qhWapee0Q06jgiFEyRVyE192td58PKtPFQuxmRt/lXD1dnlCw/zir8TXIDuxNbLBkI6Ue/YQS9l+3w860fD701AqfAjnf6wcR94VVy6kqItbHF99uYeBJl3MYiZgQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5028.namprd10.prod.outlook.com (2603:10b6:208:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 09:52:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:52:12 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Tue,  9 Nov 2021 17:51:58 +0800
Message-Id: <31950264637728c53f794571354ef91842c6ea59.1636443598.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:4:188::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 09:52:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ded707b-36eb-44e7-3356-08d9a3669a94
X-MS-TrafficTypeDiagnostic: BLAPR10MB5028:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5028E28E7B675E1A612515BCE5929@BLAPR10MB5028.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sx+ALZ1tAS7DVAEBGmmbYdyA+e7V5bhYMscjUY99o9VqsVbtU+fC22JwHcMWoZNQiwWceIykLcGZ6C7Cx+x0x3WvE6d4TFcVO+deftspvUDlkjOQtO66oBcTmExOIhtHJD38GGRCVxh5bLbv7lS8yy16nhm9Jur1CDJHOVSZKqvG5oy2ruJn+oW9wCP3BKE197cJL0uLQP2c31Tbz6G54obxxXJiQCYU9h9W1jqd/4FuPMjf9H34SQoOOESKavA803iaQN08WyZJ/0tASFyu1YyJvGGwqUTRo3FFSeYmczXlrGb6WBYTtKQQ1L56Y0UkAKkoBsdz3jNnjV0GnNUFXg0K2C0LqpiTKGtkq+siYublNfkt3JqWqacOTnasPOQ2nEZH5n2KlH/NAZYDIyt2OeQVbW52QaVyyMcueMvbATnf8gA308Dni2U3WIt1zoZLugqOgpTm808GDw6mF1VbQ79T+5sI/YtPsqa9zEjaxW1HJEfOghDjwBv5F9Xls/7L5toVY1kNMhF8QWOTHzNkKXpg+l40qsHduNhx343Ij7bqm2NxQ8hWTsCXtDNS1WEZE22oPWxl6eahMXifXav+59WCDO18K7wUo6QgvCxD6bJoLXU4ndWKRXizeOzigOi04ibh2NbMitjdPyDWt1R076hphuVYhLcawAdahEP7bVgkwgFBATtcmuTIYSJuZo+0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(83380400001)(508600001)(956004)(8936002)(6486002)(186003)(44832011)(6506007)(5660300002)(66476007)(66556008)(6916009)(66946007)(36756003)(4326008)(38350700002)(8676002)(38100700002)(52116002)(2616005)(26005)(2906002)(86362001)(6512007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTMpSJ2yR5rNwk/+Xg3V/UmFTQ9cArTYgcVq9oTvGWT3FOqOnG/i2z8avsBZ?=
 =?us-ascii?Q?K8YMgC1+jlo25zDjJ4tAUpUYKCAC7gIWocr6BSKYuZ8HQBxD/XpwUbcNMglI?=
 =?us-ascii?Q?+dYZlLLeLSFOOvZpB6AhxCF88XTEQ6tmi42yKRGSPzepfC+xiUn6y3Mupu88?=
 =?us-ascii?Q?hdpgBQNG7vX3GFmtEqfwGQgT0Vf9bq7/Gc2fkPADpuGB67TZ5D3lX7Sz6KU6?=
 =?us-ascii?Q?YgEBmoyoAhjvmaMN5aLVmcjCqz7+UsSIOYT/gqJpn7SLGSD5N0hVsRjkNiYH?=
 =?us-ascii?Q?y4//2aafn/RXK44WCpI+NpxoPGgTSR9RUr2+c/6BvqnOk2U9FchRV9B6mD40?=
 =?us-ascii?Q?ht2c6UrD6slgYjKS6YfGscZwov4hum7TUKzFv47k+Ww/a+1Q2a1e5C2+IXLo?=
 =?us-ascii?Q?uDx1oyHEX3lO6MDKn2gfqEwuY0hSgO7ln8rieoyCgaHThZjeT5cJe8EPLuRS?=
 =?us-ascii?Q?OxSiIzUXwtTSgYkZ+IeXaSUAqOZ55vvZQMwsUKXtvFf2vJJhOUY0EEiMVUg7?=
 =?us-ascii?Q?u+lpFkVoV/jBvoy/lQwSQECfpTgmRYFqKM8qDX3ADo6x51laL6LuWfW15s3a?=
 =?us-ascii?Q?1rlJHTTmtO8s7o+eKdr233z3qAGB0ujBjJPav6wfBsp04ODBm9xKCZ125XAN?=
 =?us-ascii?Q?jN7OJajnBKgde3Lz79PEVslqBk4umQL9Y/ymhrOF0s0iOUMbS2Laq3LhFLsw?=
 =?us-ascii?Q?MSKyJKHYknR2zmzapdSja/rff4NRjhjxVbxKsiysIRW30o3WXS0cRAYMUR+c?=
 =?us-ascii?Q?mGKJn11qSNgTpcHcyD1fpVB9Fzw3ZtRXJePZIxt61D1KsNh8bHpZKsZd7eJx?=
 =?us-ascii?Q?XW6AnZmAoi1NVLvzC1+zstsswoUm+bVxWpfJLEWY4DzMZwxNZ7V1hDT7dllY?=
 =?us-ascii?Q?XkNrtRZCZBqAOOZ9jtlrRrCRHEthEtHIGs9PoXIXoKy5/9ddZV7Wecav4VBj?=
 =?us-ascii?Q?i61CDgMJk+fnlG0AU/fyI2Ceq9c4ErR2vKFAnnAIX4fD3nzwPx6/gG2aLyoM?=
 =?us-ascii?Q?c8pFr0IXMzzNmF/SOooqhgYWiKXQ6ePn4sxtAJ5YkU0+00ujpOE1CkjFOBTB?=
 =?us-ascii?Q?c2BQSRqXQKiQCKeTd/8aDbaskSQGIrVgIRh/oaDg9yhunTlBELHMAZd+2AGE?=
 =?us-ascii?Q?cFMjPncskmnelTw60jRSk+Vx1tEgehbrHaFewT6kR0ystccogn2pvRcc5Olb?=
 =?us-ascii?Q?Cm7v7dkto8/bJhdb9oDe1hOOAOBJiiVc3iyyJyAsrRdV4Ph16TwobpnIHK9/?=
 =?us-ascii?Q?mxHUZ8WiEfxRvbXa08SqJmHIzUi1osd4uL3ab5d389oB7NjknNKnfzRbV4m/?=
 =?us-ascii?Q?bpYw7JkC2FeWg2RWazqO37+SECEMTStUcQb72pwHC/m0ItAmzSODYIbY/bGk?=
 =?us-ascii?Q?+XqnVPbDPFtFqzfhSgpRVHE++NBUgFk38X3e3+AgxBBumeVqYypvj9IThDS2?=
 =?us-ascii?Q?bZQ286Haxic80wBNtSdYAur/I/SVP7jSjKczEaBAX/bcvldkbi5evTo8ZiS8?=
 =?us-ascii?Q?YQhmuraVJtAWJwq3fLm1aquy77GrZfGnHjhmjY5/qc1qLkwacNW0xnYKcZbc?=
 =?us-ascii?Q?HDpY5foDN0o3RVb71cTY5meDFvf/I+AHKXxGFAm/jRF4fxBZ+7SeXk6b5agr?=
 =?us-ascii?Q?C5Di7KqUK8AI7W9UzK12SLY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ded707b-36eb-44e7-3356-08d9a3669a94
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 09:52:12.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PlDTUoAsQ6jhD6a58DujP3J8+4Uo4YrfZb1IZwExtNrP7c+sKVg+zU7AUv67cVe8HJCaZelZr37hto2BKJfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5028
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090059
X-Proofpoint-ORIG-GUID: QGYIT5rBXJAqAgdsGNFYLR7pmYNWiTi0
X-Proofpoint-GUID: QGYIT5rBXJAqAgdsGNFYLR7pmYNWiTi0
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

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v10:
 %ret should carry the error code from the init sprout, thx David.

v9:
 Moved back the lockdep_assert_held(&uuid_mutex) to the top of the func
   per Josef comment.
 Add Josef RB.

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

 fs/btrfs/volumes.c | 70 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 68bb3709834a..155892bf5c7f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2429,21 +2429,15 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	return device;
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
 
 	lockdep_assert_held(&uuid_mutex);
 	if (!fs_devices->seeding)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Private copy of the seed devices, anchored at
@@ -2451,7 +2445,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	 */
 	seed_devices = alloc_fs_devices(NULL, NULL);
 	if (IS_ERR(seed_devices))
-		return PTR_ERR(seed_devices);
+		return seed_devices;
 
 	/*
 	 * It's necessary to retain a copy of the original seed fs_devices in
@@ -2462,7 +2456,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
 		kfree(seed_devices);
-		return PTR_ERR(old_devices);
+		return old_devices;
 	}
 
 	list_add(&old_devices->fs_list, &fs_uuids);
@@ -2473,7 +2467,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
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
@@ -2489,13 +2517,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
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
@@ -2586,6 +2611,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct super_block *sb = fs_info->sb;
 	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
@@ -2669,18 +2695,26 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
-		ret = btrfs_prepare_sprout(fs_info);
-		if (ret) {
+
+		/* GFP_KERNEL alloc should not be under device_list_mutex */
+		seed_devices = btrfs_init_sprout(fs_info);
+		if (IS_ERR(seed_devices)) {
+			ret = PTR_ERR(seed_devices);
 			btrfs_abort_transaction(trans, ret);
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
@@ -2742,7 +2776,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 		/*
 		 * fs_devices now represents the newly sprouted filesystem and
-		 * its fsid has been changed by btrfs_prepare_sprout
+		 * its fsid has been changed by btrfs_sprout_splice().
 		 */
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
-- 
2.33.1

