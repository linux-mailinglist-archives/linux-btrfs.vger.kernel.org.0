Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2873E3F1FCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhHSSTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 14:19:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13906 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234488AbhHSSTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIGGsT000996;
        Thu, 19 Aug 2021 18:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=74Pcusb0SKrUbZ95ItZabiX+ThWS5bKtL7JYFa066qE=;
 b=Kcw1iLBEp5S5ZnfE47Cx80dYxsf6/aKCCeCqTSKJFoyRPV9OjlEaXnSdsi9GpP53EoZl
 bgqUwOFurgrtPXCScXr8Wf0OW2ceXApWQ+uKxzNyA/UP4UAwjAh3U5EP7jycRXbDTIjn
 o7a6SNl+TQeyormJG3SMRfz8ScBF/y+C85oeCTlJSQh/3JdqsI4ENZUz0hHIeoH8PCjn
 E3weLzfHMhe+umiUlI7NxL2jIYMxYOGvWuwP/B6mr/c2WHi6EmlIikPjwUGgAFpw9acT
 LRwycfz/bvS3503vS40f8oqhcYvnp0JwUs2cl3pfIJtFPFKmTzJrtXk0QJnXcJPFqu00 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=74Pcusb0SKrUbZ95ItZabiX+ThWS5bKtL7JYFa066qE=;
 b=QBOUhn3iY8JAPOXVtd8LGov5RGM/+sbDb6pCDFn0dT3sUULsybkTPfURIdD0FqS2nJfD
 RGlaKskARme+aFyihbV2WLh3We/LnFy4JNEP3bmU3LJbAVUWPvEtw6aLept48W0mkDla
 LKOitFMy0yiuvSnACKP30R7a3KDo+xHYqRh5yFL6aY/6yDA5KzjM5DT4nfwH4r81kN26
 E4MNgdyyQiLbwGhJuWSkuYuDY7b7nRhYfXDMGjgfKvTMDNw3SFBxoU2h+DqoQ6gnXDPt
 VUObWwnTux9qefqFAMtae3ZsFRNB84yHNKVbSNYvsQTaTQM8Csg7Cc2rUUZTVIJN0eYN FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agw7t4enm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JIF8vs004095;
        Thu, 19 Aug 2021 18:18:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vm0d31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1qQpb7Dr7bSeXr3V8BWLo3CrgQV31nS8ANjfWEP4avQykGa+Gm0s6ajQq8DzI/oDP7bIqIpY9G0SuQbtF5Vg1cxM6yzVf6M4NZga/02FhzzgNhs12OTPMgiyS5fxjLrAiFDWc1rc6L9id7ZU4cajLc6LmRWVOtu0wQk9gAhE/Mz9V80XOoo5uf9HyGy3+vk8bG97axzkOnC15FG9ouzOwCSjDla79KPsPQUK2ai1LQN4o85pxA3IgGM/E0Qz6QH0EOlcLdjKnuLGodgaDqoD1ihj6g6/+MradBzGV4d7u0xD93JhF6qjncmwvgws1jZIJ4fYk9R20TW9RiteDFwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Pcusb0SKrUbZ95ItZabiX+ThWS5bKtL7JYFa066qE=;
 b=TUjLZRorL2J8/VDs65dVRe4deb/tMlAv81RXe5dn57EDfGXoWzzeNTCzIA/V0pSO/MBo06e4PRsW8QlUrENye/74HlvGH4W6QbD+RvSNDA5keCdJQv11Kaj7pFrKbG8LZsZvhpoJJlhkimcNVX7mE2SU9zvhCLl9zotsGTa1u5UViBFHxACEiVHvN4pWqznQ+x1NpO6ecN2Fr7X4qYMtTLKVwnqs1rjliitnSB68ECSCxQ97204kdndg+wojW1YylX8erXHXt6Ruhjt38Tv26wEelFRkW4ySrpspBPWWntWyl07I/Xd7UFMZqPYYn77yOhOdTlA/FJonaO3ljKcI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Pcusb0SKrUbZ95ItZabiX+ThWS5bKtL7JYFa066qE=;
 b=hu4R0VgYGZDYIvX/ro3eNHs75VB1sSbqtkEHOZ0ibCy5N/bCEnXiA4TqTdxFgtmaTjVzN2QM9JPYKEavdseQZ6qDqZzYih9PdhqNKVVpJT5/GM/eCqh5TxAXr89MMQAKhTQmTBeidLbKWQUqFp+OkWQdV58KzDFeU8mTmr4ccfc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3966.namprd10.prod.outlook.com (2603:10b6:208:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 18:18:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 18:18:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Fri, 20 Aug 2021 02:18:13 +0800
Message-Id: <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629396187.git.anand.jain@oracle.com>
References: <cover.1629396187.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (203.116.164.13) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:18:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d69ea8-78ef-4f1b-f4b9-08d9633dcd69
X-MS-TrafficTypeDiagnostic: MN2PR10MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3966110265D0E74E8B81366DE5C09@MN2PR10MB3966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25osedR1CJKb0xaaDM2d4Xd5G5lGJgrPWC7fiTUnvJ0TSIRMrsYYYsbywU1F24EeVeDnuHQWUx/fbPQsYoUQz5NKVueNVMuIbwGcxLpT+JZq4dgPC8Db9J4uLlb3bLo/X/VL80DSKtEBHg/6DbJQUwcyyEZtSCsnCSOA6asVL/1dla6lmeP4NvOazNAOBaCg0faDN1uiCzBVs1/WYpRYQeO6SZ9VqoOXeE7wIqA8veItmptcj1Nwn+tmzCuYIEfYiqBwMEjYiIGzDjM+jvqPZsQZ5FokzHeZL6EpV+59Y4n0pljWn/huH8O2Kj3AfLLBi1Y5Ytswc426CstjFdFfiLQ5sMduiZAp/nPdOwPx2jksGsSzQS6k3bjpi/Joc/J0o/gBTWpQTbUH9+Oyo0VnFgoyXEsK4J+0UGhOWjEc1w68clmO8/162CkFHuZBEqyrWEnE9YsO9LML8Ym5K56xsm+3PxaXpBaRkURFKUXwuGQeN8vNxNvqCJBt5Dz/bmvHpzI8Re7R2UYwWsISeV6luBHmZwKM9WcJEKktrIQaQB5/cGqWhMDPfh6IaO0LIF9OREVsXPXab5Oa/pANVmI/5x8MIrf7t+u/zqBoRA04qVxca9VjOs7JJl5Yz5C4rdiqqZjO2GHH6C0cd9zLXKh5sInBPugJq4g9UFbB4CM7q8rMsPHHiKSkRl/PIUKTo0fIL1YrtCmgifq3VbXyGDf4Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(38100700002)(316002)(86362001)(38350700002)(83380400001)(6666004)(66476007)(6512007)(4326008)(186003)(2906002)(44832011)(66946007)(66556008)(478600001)(6916009)(52116002)(8676002)(2616005)(36756003)(6486002)(5660300002)(956004)(26005)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2eut0T2/vzcdx+RDgHX0fmIEtoSx14Ia4nnlCd7XCg/gumgaZH38DLhYQnA?=
 =?us-ascii?Q?JuQmM1YbvzrSW2NVNamvBv5cOI0zCs6OdiqAWGNeZ/4nXYsJsbn8ZkvMfO+4?=
 =?us-ascii?Q?MJ7V2t1r2oWD33nKZLyCd0Wy1P6VQ7fpEpQzXUWipICfhDDKY14G9peNiAMQ?=
 =?us-ascii?Q?pMs9OZXa2MmFMmPqgNi5FtV4jGqsIIINvSJIQo6UrVFUeaBkJQVbDE/AP9AR?=
 =?us-ascii?Q?dMIWU5ZQmRmcvHVnON5vymVqLNMWzGsJMOKIf7dYC/VRKYNCup+N6xArzCqy?=
 =?us-ascii?Q?qARiRn8M3gflRaIOyDYBLeMOSZ4EBoFOZy9AKp0PWVblyYLIM2CDVGX3Wd2l?=
 =?us-ascii?Q?yY156xbVcDBz7+IFWrsRaS+InMd7SCUYav1lXJr5LxOSdvEQrX2jzc5UGKy1?=
 =?us-ascii?Q?sRP+Nv2/ZwJk5N3ZMqQ/au09+ItVDh9jo2YXxXJ64F5p+V3xCuDmaZ+4ZaGe?=
 =?us-ascii?Q?1EbZjWUiVlXiclaYQ91U1SjXpKUeHcTCaZfCgiIEawiUXhK9/dpQw/fgNtpm?=
 =?us-ascii?Q?P+JMh2IbbOD/M4AxTYs4c7iqqgWRWT62l2Oc+zZNKOX8rZEHeCR33UNzcmxb?=
 =?us-ascii?Q?RgG83GFlHy5YEuPLErJ63q7zd7OKMFVSB/mVOfqI14x11FJZz8E1FeTx7R+Y?=
 =?us-ascii?Q?XPO3S91poJeY30f1A6TOaM2hVfFCNjflkQSbM5wWmUCBDjZTnESTVt+mQPcC?=
 =?us-ascii?Q?5jqn1kNeF0DO8V4jRHZYhzW9cKf4dZRv2svHoV+yVY1QAC5Yrf7Ih3AoKdqr?=
 =?us-ascii?Q?CHdgQrQCWKYTwAdD7tLjdj9STXHFvFW5gkskm0Bj7CeTpM0xlBPRN0g1l7Sp?=
 =?us-ascii?Q?dVs7XElo9d+fa5heYjBuBimbwqgt/JhjzyfNw1yS/PXg02BV0XOJJzKHSwFb?=
 =?us-ascii?Q?4UJlKo1JcFfHssMRmpjzOqwEKyq/pA2SwsXRe8AuZ6rpbKH0vKX2doqUSgNv?=
 =?us-ascii?Q?YlfWywoIvSXBwwl6dKgdc80qrh2KYzv6F45K/RGZSlRhLuKNg6Ff4lJqIsuO?=
 =?us-ascii?Q?AvoShWmyk9yhFhlXmJmvyYmJnpc8tPjUiW3SmAnsvA/5SBEP/y7dKtU+ojzR?=
 =?us-ascii?Q?Qx0BBJuwJZcQluWKq1KdZVTGc1ZuUxGkJr7FUf9FeKtY0yaSQpBWzPCjQDR2?=
 =?us-ascii?Q?DJgo6pTvoKG5/2v2zxpTuPvTCu5Heheu+BjwzXXCc/IUvnvzLHrDKhenoRlj?=
 =?us-ascii?Q?u/QL2lC7EVZ/QZHRiHI0386dvc2FQP4f23ktK3oRec6LnRdA7sORWj0dx4Pq?=
 =?us-ascii?Q?3zq/+832jMj0M7Y/S0O6cJwcK/kqAnczhbUFxkUrJsa7M6uEqY1GH1Yop65g?=
 =?us-ascii?Q?+2woSB1UXWlI7NDTuITfB3gr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d69ea8-78ef-4f1b-f4b9-08d9633dcd69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:18:54.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg2TtKcDgUnhCzzliR1E+285HYf5pi7OGZNXfENDRUrhI7N7U+So5QOXKVoBNYXYEnBAXziPm44mc3Ew796btg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190107
X-Proofpoint-ORIG-GUID: TeSTXqWMHIdezVF-JtafG9DXNAyk5bmq
X-Proofpoint-GUID: TeSTXqWMHIdezVF-JtafG9DXNAyk5bmq
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
so that its parent function btrfs_init_new_device() can add the new sprout
device to fs_info->fs_devices.

Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
device_list_mutex. But they are holding it sequentially, thus creates a
small window to an opportunity to race. Close this opportunity and hold
device_list_mutex common to both btrfs_init_new_device() and
btrfs_prepare_sprout().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because I haven't identified the other thread which could race with
this, but still does this cleanup makes sense?

 fs/btrfs/volumes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 91b8422b3f67..f490d1897c56 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	u64 super_flags;
 
 	lockdep_assert_held(&uuid_mutex);
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	if (!fs_devices->seeding)
 		return -EINVAL;
 
@@ -2397,7 +2399,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2413,7 +2414,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
@@ -2588,6 +2588,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
+	mutex_lock(&fs_devices->device_list_mutex);
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
 		ret = btrfs_prepare_sprout(fs_info);
@@ -2599,7 +2600,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
-- 
2.31.1

