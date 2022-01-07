Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149224877F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbiAGNE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 08:04:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39126 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347391AbiAGNEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 08:04:55 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207ALROg031899;
        Fri, 7 Jan 2022 13:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Gqh13NUrGXJOsAtvR5ongSuWmckyoixtEEkNwECZo0U=;
 b=BOyKGXWxdsruwfm8WlXl/8+jp5ESZ7/HmsqEdC5BGmQ6lUZa/EtmLZz8uwi6E32MI6RM
 7dnbh8jEwv+GVMqUFnLvdi9OZ9OrhZ6MM+xAVYTj1HvgJLBX2pEIyxIOyivX3eW90r6W
 L+1qOpb7JQeZ1eJJFfM6d7BxBRd+gbWwAU1EhSiRoIlWTYo/rPLua2ppR69Xa1pV2mxE
 vm+8AKqVXBz6/QQAWRqqC3LsIY6yfVbh8XboAvRm2bKuLj7P0+6TQX8onkTrO8tN7rNu
 L4gdQSp1QD/m6jR/it9x8BP2d6/82kf71enyPGXpNM/wB1Gf9n5itxZgZupTmv8GjQVy 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v91xrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207D1twD056717;
        Fri, 7 Jan 2022 13:04:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 3de4vxs3nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL42UT2IK2A1z4srIVQjkyS6vbuU4S70x0u7q32sEA2l9SydGDShqeuMeKXxQWx9qJiexJ0VveCByu0IBEV1IGt1AxUQ36ZNhsGGGDhXuaV1/2MKxjJKqjGI1RHk8xJJ1ee2+MCuV4zilbNqf1z9qtzsKiaqDTikp4A2DD1TXC4Qw5tNqxk10/6dSI+QOlYqhiBUufIvInyt/4loBSH0SZZ7hBeVYliXC+nc980e5hHsuAYxgDAFhI4pGyrhSevd7GOian0zjN1ZysCri2QWivG6np/Np44ZeyWD0Ky3ehqMg1eTuVvA5QVpUcJ8ZaDYTUi5WlErwOCdO67hi40JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqh13NUrGXJOsAtvR5ongSuWmckyoixtEEkNwECZo0U=;
 b=ZwxhlDZXsRl+2xVVc03Vl2K2lGdlhDtP8BcYn/EaQ+UzU70cjRj+C8tQ4poxZX011tXuwR5KEnsv2x11whxwm4jVPLjvZzLfdP5LmMiyfYqyI4N6WEnCyqzKTQJ6om7yXkWFfk9S589W5qQ2RufOfwXj7URSaXlM2bszeOMg00FOVvoeAbvPgYyN5NTROaZCh5XsZmfwOqcGsDv50CF4csAP28rscZTXNgALvZM+gIMYn2aUtwRAq6joV5sqvOEW0TxwXemioSw22RcH62Or/sTQo7ntttR02vqKJ7mvPD5aBvoBKHuBrYXwotBhj3qhPK7AvmLNB3yUFKU/TrMCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqh13NUrGXJOsAtvR5ongSuWmckyoixtEEkNwECZo0U=;
 b=tSHQVQVZlGPCQ/6XnlUeoX2vqHt3bGDFWWizmyJvh8uRSPA8mwtTFmB3VhnRs3JLR1YUBchU32ebdTN8tCTSNqtfJM80ImkmRyS8z9fylP4j9w1xQ98xmBUJKlMm4WxaAs+oC2Hl37L1u3QgxstPKyEAVTZRdaGAttyhVe88ya4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2995.namprd10.prod.outlook.com (2603:10b6:208:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:04:47 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 13:04:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v3 3/4] btrfs: add device major-minor info in the struct btrfs_device
Date:   Fri,  7 Jan 2022 21:04:15 +0800
Message-Id: <6531891b2bcb2d68baf4e0cfbc37e6d9d614cbef.1641535030.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641535030.git.anand.jain@oracle.com>
References: <cover.1641535030.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38bb842c-fdbf-42e6-d239-08d9d1de47e9
X-MS-TrafficTypeDiagnostic: BL0PR10MB2995:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB299508A3AABE695C1F30B507E54D9@BL0PR10MB2995.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ks1ZF8FiEZnNUxK2haGCQcr3meH9UqO+Iio4YT4Qd3OBgOeP1Cx2ACmHhne9nzziV3Gjc53IkiPyIMKJixFgFK/PnTMEYLfzu3/iVyqXVfnAgILCtQlrUhWhxqnc84raNns9VRY2HNOFaqg6eSFy+1kC8FvNNmLkXA3G2CMj642W+HnM6VY/D23ymcMoONpM74K64MnhRnip3Krl+YG+08HP0SxTUH7yhGMHiDDtdvnNbB6hlF16WMdLeoQlt0SuNii3CdAdHmFtWS+Oykn2ty5Uzt/45RdvBu1mZ+ymXMA0/1fLrngvA8jlv9fnbM4mtfsuAVaGrU3ySDs+GmdilPowmNlX+pwz7KV8MzlXL2/4Qob+TdqApXOiWe5TZCZ0SKPodsY5QTPpF67gWVVMvqpW4BvtquR//YUPqKvmf8njW9M/IZmCNta2URtyapmPuf3kW+aKASsg0gHj9tm90Dyf0K5MMxPPd2Fp/Ynp1slZGY+W1MBnyiVZZCPJUEMjMfHFKwqw+XpofOVw1E1EgQ5kTwXJWbbMRsjQ4PWe3U4bFGO07I3GgvgFA0iePpQ9fgm5Dw3dhTcZ1IdwC7Y1nE3Lnifgwa2W8owBYsprPoQRuI/JehpCV9YCWAxE3AXCGvCixP3nLUu9X4hIysUjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6666004)(186003)(83380400001)(316002)(38100700002)(6916009)(26005)(8676002)(44832011)(66476007)(508600001)(2906002)(86362001)(6512007)(4326008)(8936002)(66946007)(2616005)(36756003)(6486002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoNMQ3nvKvabFg3gc2wCIkTh99mhXAcaftw2QIfJYmX/cSOUc1Mihdr69poz?=
 =?us-ascii?Q?gh+iUaE7Pd4B+5Tb3qCqAzm7gY/rnkclgWUqMYfDVRD22hHAgyWjpmCyi7+9?=
 =?us-ascii?Q?y2ihYEe46K+QtbZWjgJr645b6JHXBToG+nUy5QgMigF8XG44l9bGjGfTxJQZ?=
 =?us-ascii?Q?zIeNAKpJBCcn+pbQKx0yh9lHlTL2/1iAnlWQID45Wf/EaAMQDAGi/q2KEI43?=
 =?us-ascii?Q?339Tf3vt+8BDv0vtFDz7SnqUdegR3e/w8wfS1R8BJINCrtb5qOJsXkoUCbKB?=
 =?us-ascii?Q?HtxTkLj/URNI3YYRF5Uh9BQhymRwUFb9SiF31Amjjfl2GMBeWq/f88rq/fvd?=
 =?us-ascii?Q?frMQUK4mD21pDjUWFNtdp+6CjjhS50GBlH7gkMot1YtzvzONnDXCIfCVSBDk?=
 =?us-ascii?Q?CDl6gLcYstqJS2kBuK66VlXIbHzSjQ+P/VjDcIEFHljjyL0pSLRZNlOdfsfr?=
 =?us-ascii?Q?/NmU+hIiG5We048AJYklJagfq/PQBHlVLlQDBNtw/hYi2dncSVdWKvN3P4+K?=
 =?us-ascii?Q?lm0DWVcM9xuN5EglyROugF2czXCY4gck4Oe/a/dflU55bSWm2Zjwpq3c608E?=
 =?us-ascii?Q?wMd+t3JG0aKOR8bwWfyMsvrzRGJ32sag1v71XhxAtvarQdSpnAaivysqlosn?=
 =?us-ascii?Q?aDq+zxYbWN0MAjAE3xTF4akai2fm+IWXWjBSYhx2Y54zHihuZOqOGKmgGaHu?=
 =?us-ascii?Q?XdG8QoP2LdK8wZt8N9KQrxk1IinGEA4clID7ozPMiSlKtobf77JCLgdaVPsw?=
 =?us-ascii?Q?UI3L9G/NIC0LrU7N4ox4LqI/hMBEpUBDW/YV/Wda75ORV4YGjngT0O/eoNmC?=
 =?us-ascii?Q?fIQg5McGtltnBkWO58/2qdEzV+n1KoE2Fp/L7JMilGsFoZV29imMzYJKXinw?=
 =?us-ascii?Q?ziQfnfJzjD30Msp8XwZ/OIogpsF/hzXXbRckUh+XEYMDw+aksvEqhCa7eFtP?=
 =?us-ascii?Q?iyPm3r5FsZHaWMAFS/HT4URcvwGPPo1i/hD24kEpAeGHvQEcZ3Vxyx61Jlqw?=
 =?us-ascii?Q?uTP8G4ShoVJogTBov4skojet1tQJoHT7Yn6zdNAas/K9algU6vyYd6zMTpGD?=
 =?us-ascii?Q?P0sK9JG5yHtlab7yCHWEfjfBP+CkSwJkgO0I3YWKQ4EdfEX+8hVyjxyiLGka?=
 =?us-ascii?Q?ynTxBvQFh6abSfsU8dtdNM26O45NGiY4/i+k4u5LnMqpvMpBUx+jvfI2yAOT?=
 =?us-ascii?Q?xJw4o9OkvzJbGeJx5X3ue9njJpM4QzD2boCnDqfZd3cyKaavdlpknrqlMKb+?=
 =?us-ascii?Q?HKb7K2I+0YtuY85bnQ4NolVaITGoUc3/D0YJqiztRQ01p+JVnR5BYO+mfnPD?=
 =?us-ascii?Q?vXmuObQ9fr8pS5WCKMFzSc8ldK2/Y6K7gvJ+0XXQ/vCtqDca66/CNeXm6Lfh?=
 =?us-ascii?Q?N93HQMqVLw9lolErfbfwBddDUNj7SqxsWnfc5HbUlkX3UdYopO+v2VYhhFK6?=
 =?us-ascii?Q?dC+uQYghiM5Boyz5kUgxiJg+nRCKCY2M0t/VKRmmPOlKQdCwRk32DxhgHjd3?=
 =?us-ascii?Q?sa73xKi31QSKqVjVs1/ClZyhZSexzDTfJCqDBNU/5apy61if1NbEvNt6DsU4?=
 =?us-ascii?Q?8EnE8TpJKvCZfkV7AfJ/Qc4Yhrt9316VNimXZnRGGTG7kY5B+0WNTQhpzkHn?=
 =?us-ascii?Q?iTwxrtfALLHISGGk6phSRbg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bb842c-fdbf-42e6-d239-08d9d1de47e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:04:47.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+hHjB66icygmF//dIpoCX27qe9uxp9MWWlLs1BHD2T7PSl+8rXzGK4aNj4SALGOkQBgjEvXNyJu/KhgywOrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2995
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070089
X-Proofpoint-GUID: GAv6wUZB2W1baeumfvjcIoFzCBd0iZgS
X-Proofpoint-ORIG-GUID: GAv6wUZB2W1baeumfvjcIoFzCBd0iZgS
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Internally it is common to use the major-minor number to identify a device
and, at a few locations in btrfs, we use the major-minor number to match
the device.

So when we identify a new btrfs device through device add or device
replace or device-scan/ready save the device's major-minor (dev_t) in the
struct btrfs_device so that we don't have to call lookup_bdev() again.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: -

 fs/btrfs/dev-replace.c |  3 +++
 fs/btrfs/volumes.c     | 36 +++++++++++++++---------------------
 fs/btrfs/volumes.h     |  1 +
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 62b9651ea662..289d6cc1f5db 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -302,6 +302,9 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		goto error;
 	}
 	rcu_assign_pointer(device->name, name);
+	ret = lookup_bdev(device_path, &device->devt);
+	if (ret)
+		goto error;
 
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	device->generation = 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cb43ee5925ad..33b5f40d030a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -817,11 +817,17 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	struct rcu_string *name;
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
+	dev_t path_devt;
+	int error;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 
+	error = lookup_bdev(path, &path_devt);
+	if (error)
+		return ERR_PTR(error);
+
 	if (fsid_change_in_progress) {
 		if (!has_metadata_uuid)
 			fs_devices = find_fsid_inprogress(disk_super);
@@ -904,6 +910,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			return ERR_PTR(-ENOMEM);
 		}
 		rcu_assign_pointer(device->name, name);
+		device->devt = path_devt;
 
 		list_add_rcu(&device->dev_list, &fs_devices->devices);
 		fs_devices->num_devices++;
@@ -966,16 +973,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * make sure it's the same device if the device is mounted
 		 */
 		if (device->bdev) {
-			int error;
-			dev_t path_dev;
-
-			error = lookup_bdev(path, &path_dev);
-			if (error) {
-				mutex_unlock(&fs_devices->device_list_mutex);
-				return ERR_PTR(error);
-			}
-
-			if (device->bdev->bd_dev != path_dev) {
+			if (device->devt != path_devt) {
 				mutex_unlock(&fs_devices->device_list_mutex);
 				/*
 				 * device->fs_info may not be reliable here, so
@@ -1008,6 +1006,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			fs_devices->missing_devices--;
 			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 		}
+		device->devt = path_devt;
 	}
 
 	/*
@@ -1421,14 +1420,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	}
 
 	device = device_list_add(path, disk_super, &new_device_added);
-	if (!IS_ERR(device)) {
-		if (new_device_added) {
-			dev_t devt;
-
-			if (!lookup_bdev(path, &devt))
-				btrfs_free_stale_devices(devt, device);
-		}
-	}
+	if (!IS_ERR(device) && new_device_added)
+		btrfs_free_stale_devices(device->devt, device);
 
 	btrfs_release_disk_super(disk_super);
 
@@ -2658,7 +2651,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
-	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2708,6 +2700,9 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	device->fs_info = fs_info;
 	device->bdev = bdev;
+	ret = lookup_bdev(device_path, &device->devt);
+	if (ret)
+		goto error_free_device;
 
 	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
@@ -2853,8 +2848,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 * We can ignore the return value as it typically returns -EINVAL and
 	 * only succeeds if the device was an alien.
 	 */
-	if (!lookup_bdev(device_path, &devt))
-		btrfs_forget_devices(devt);
+	btrfs_forget_devices(device->devt);
 
 	/* Update ctime/mtime for blkid or udev */
 	update_dev_time(device_path);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 76215de8ce34..d75450a11713 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -73,6 +73,7 @@ struct btrfs_device {
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
+	dev_t devt;
 	unsigned long dev_state;
 	blk_status_t last_flush_error;
 
-- 
2.33.1

