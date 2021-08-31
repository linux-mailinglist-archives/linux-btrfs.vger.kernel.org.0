Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1883FC074
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhHaBXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 21:23:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239270AbhHaBXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 21:23:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17ULxEwt004133;
        Tue, 31 Aug 2021 01:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=R9pz7RqusfguN4BceR+4u8u23jwFB4d1fH0O5P3CUsY=;
 b=bWtnQn8e7c7PjauhTbxC0SZzDOdBa1iUMHRF7LiNTf1prAOjIUEm9sxQxKKH4U0gemhX
 01h+ltnsoUm+pNuczluZKv9tcTgkSy+8OiuX/4DUGsxMlZAfKab9+REzfdV4qErIlroc
 NuRAbTZLtpifphqIdOAVR9rFqG1Jg4s3qoSt5qn6MKFJ3P8um5ymJ2EuQRfU0QR+/qHl
 ktH9n3O8QP/QH+CnKPANwP5CKTZ+COau8kc0zDuvp2yIUiC3dTzHBnwh8VSBGfSpUYLZ
 +CS3ikJrEw93pGUcl3ZPe0DMdJ0ih2jWsN2fM7Xm44bMM1dUHA671iUqXaKmQva5wyNZ xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=R9pz7RqusfguN4BceR+4u8u23jwFB4d1fH0O5P3CUsY=;
 b=Mr8ebIgG91iyFhycc3g6Q3cNPBZqWDCZa2X8/iWTBzS/RaCxkNybAcIeeH/8AlcNaGkQ
 5eu3l6O+cnPBSCPE8MEaDQLq+vcVhLOaKO5jtu1CfTRPn/CaML4tstE2I8H6fgyxe5eF
 RZ8q/BqOVftj4b55K3GWqvjw9+MiiHbFWuD1uhlaMcbtRK45/C6MVVc0BQN8TxNHmaUj
 7PC3Pz/Hs2u9r9alNYiuPNMJiP4ytZqw0K0l9mKM43LZzjaTHQNe020WLbjkqHQFWQpR
 AZUJDHtVVgpy6+TphLyVFDMYga5u6/NIvuKIf4L9fs/IsHMcCCm6SVU+gBZqc6Gs8Cux hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbymjwb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V1GB1i193631;
        Tue, 31 Aug 2021 01:22:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3arpf3b5wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1TZQfLT0N5WoFUr4puh95HjLctEQxESfZPaPtxv39tW4LAQ3UNCru7Y3OqImbpSKgGYQUdgTtnqRULs3Lp7F7eBDbviIc7fWq9DqWWWKjkcNpFx1F9NsEMnhTK0zQnqF69UiRI2N4PhWL7R6K39/xGpijZNtPCRv1H1nj2wNLLuwDRVug+q8abvx61sbKeR0rnymWlsdP8blbP1py+KoXwbAawiXD9BEVjPYwqr0Yuu4Dy6nbdEFy78MaerxPzEWvo9ZqzljKrKS0cXuk5Xts01cCvavsRqeTf7ghK38Xmu1jMK0t683EU1oIIjWMiXIvv19aaSV/qn2T/FZejK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9pz7RqusfguN4BceR+4u8u23jwFB4d1fH0O5P3CUsY=;
 b=QOzhoSNydSsUIgehSPqlnpSeNrjrIgbf9gzL/YxZ/Xd8eoWypCc826wgqAM2yA2ol1CAF8zft+ATiYkxL71/EnYsFlFG31dfdBO1zSNKRwlwDM44Eq6NZtNVS3KQx1w9RAOw0Wlh9Rxf7hi1tHoIBAHW4/4BQi0SxUuUqJfRfptOQrmQ6teQxyGoV0ptorYHZCUG3cc3EuWY8kNTi7YNJvYnIDWjU2Axz0GAmAhT1Lq4b6oHAoPmPKF9X76qzdle7XLv7oX4mVqsnic7wUw3KZlsOK4BrK6ANMdLYNTYs1sytJWroT5j5s//Grn6r0RRlaB75GKOAP20cmHcajCp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9pz7RqusfguN4BceR+4u8u23jwFB4d1fH0O5P3CUsY=;
 b=jqQWMoH1Aatk4zI2Z+WI2+UZbMZCwwFn0tGBu/VgLEy8tyBHV0SExycmthzk3zywQ7O5GMbhKa+vozmCj91qLwHYe3qdgx7iQMg8CPSxPfC5iCiUHvW/QOC3gSqQ7HWU58k+gR0ooVXQzKj++n8ApQ2czCT7L7T8dR1irxbHE9A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 01:22:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 31 Aug 2021
 01:22:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     l@damenly.su
Subject: [PATCH RFC V5 2/2] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Tue, 31 Aug 2021 09:21:29 +0800
Message-Id: <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630370459.git.anand.jain@oracle.com>
References: <cover.1630370459.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0144.apcprd03.prod.outlook.com
 (2603:1096:4:c8::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (203.116.164.13) by SG2PR03CA0144.apcprd03.prod.outlook.com (2603:1096:4:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Tue, 31 Aug 2021 01:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7781171c-7416-4528-2863-08d96c1dc54e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4350:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4350F87889D69835C2A1516AE5CC9@MN2PR10MB4350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWLphWjE4FY+hKtMHi7aCZQEydpUUVAAY4N4HCfcj8sBE6DUZ+UlxBk72hzTs8hoXIBUOnqszwbPqvewLO8iltzkP+0EIZY1pxRQYX9C9KMAtsRbfkibxpSEJzSLdcC8QE401qrlL9uZPDMRcsuUIqCoAyM/1f6h/3r9u1E7TMqvqj8/4a78JbF4kHEqRhlqzg8GIqMT/45fXOk++MvP9LP6KCihzcsNy5qZawyMliud5j/Gtzwyg57XtcC4jX1sG+r9JPVAfYsrByvIwAGA/slzK4BcihI4Pw983vp8vSXk/vxW8O0S8JoS5TTdZZptnrI1FaZLt0aIh3u0y0kts+wmnzD46jV5jqWdAT+V82T0FD+Qoa5DvwPpkLnTeOa+hfD1/ir1gKpT9tBas7+8TmSbKddJm4iJCWn7noa4YihMz88nwifJ1bgbxk48XpeOCCGrfJ0aT5uXeySAgNK49CkXzzSUE9vl+//6bxuPgTMB3MAhi0ncZeTjgmkyH9n8FzjVmDRBJxi79abn4AZOR/h4rLs5WvD21hZmXo7gzwU3mWsij/mdpfba6YCex7gfPfZu/nuKgRobE4OEqMAEI2Xxi/tewRLhHnvFUqsLn9dB49sciIQp8r+nfqMGdcgQjih78+MY9XEron2ssthifTtGFELpHox6KVTxCj73lVonL1vnOQ7hWOZbjunHT9j/4l5pTpl3lxXTF5jDVVj7yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(66946007)(52116002)(956004)(36756003)(186003)(2906002)(44832011)(66476007)(478600001)(6486002)(2616005)(316002)(8936002)(86362001)(4326008)(38350700002)(6666004)(26005)(8676002)(83380400001)(7696005)(5660300002)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+BCtUbJfQxerXTIJiElkc7CbxHO3TDxXWUvXIMqfUEGtYJCnsiQqhyavFjR?=
 =?us-ascii?Q?sJQUuemfmd96SjIcqz3/nLQjsfvgobX9N+SGO+hla6OdMRbAFsnQkIlzKLC5?=
 =?us-ascii?Q?ynkDsC39PRo0bDBFcFX8k1wSt1mqtQFZLEW+rxJgTnwhvB0bJL9iF7UvV689?=
 =?us-ascii?Q?BzA7wukJajDOKIjpt15ApW9ZW9XMuVPs24VvWZ9OAEevTOz1JvRF5ps40MBQ?=
 =?us-ascii?Q?JHuE1xuiBip6JnFlgQHntDW3rIiZVzlCVzrEq/ovMpVd75VD5xuovWH4bRpM?=
 =?us-ascii?Q?CeUll/FlMUgeslMJZVz4547pkd1ZtdR6PB13pwMxcucghgE8ton0dV5KcYZI?=
 =?us-ascii?Q?Nzfzs8ITq911vDQD85BPFjsBdSfb7sEinQqkvKsHl0Hbr5JiQ2A4n0bz7alK?=
 =?us-ascii?Q?DEdrIAq9rwbFVeX7QFxwC186ij9q6UwqXYJUP/T7NV1eioGP9knxRVnmjqnW?=
 =?us-ascii?Q?6x8xF/BaPn3DakAu7d47mh4ptPZZLhW9jyOsLk8Vfg0zs+i1kkKzrm2eC2St?=
 =?us-ascii?Q?stbUs3R6fWTcOYLcuU3IB/BRFYVHqkgZOk/aQWcwKHBeHNCAXTb0wsYyfdkN?=
 =?us-ascii?Q?LdsaIaBk9X1tWDu62iAUyz0ug+btP+MEgRkLkq0IE7vjSvUdpnYgkkOFARRI?=
 =?us-ascii?Q?hV7GpFws5LrtMN+QE9gHuXwoEYY5lABQIuLDdkG5TruO9wbrnTlck3u4uRMv?=
 =?us-ascii?Q?EyhnwUoym36xP7be/O6/Wywx6++1b4xTpcm4Wb5K9Z0lsEwDC6ZmQH58IWox?=
 =?us-ascii?Q?gAreCiTo+vP4lphEtIMgNshubxSdaS8MxbaWI0/Mw4YpaCuj05zwRdfHMalZ?=
 =?us-ascii?Q?uMw/s0QrJc2jgyHWwqEGigD+Q/HJdxxS/1HYuRDGWyiR2Y2sFiKD4hVjW2eh?=
 =?us-ascii?Q?FB2g1/3+oKYW9yrFDadtbXRqAQFcTNhI4jAeKJuTUd9n6Zz6jwBPWOg38bmf?=
 =?us-ascii?Q?iGVscXscZgkVtCgICZILMnIFQrog1uOE81ed68CbWgjM08XYnGqhqrDxbTZ3?=
 =?us-ascii?Q?pT0sesYLuHww+c6yv4Sm++i/oP5mHRednCSW8G0MGrxld7Z/FkFhr8WmOwgv?=
 =?us-ascii?Q?pkVf8TYZ1q+LWMBZ9gXepryIbN+qVYyYr4hrPsUO8wb0QhrrU6dZL4XHsQv5?=
 =?us-ascii?Q?hdmy9xvs0AgkfQSuqBdg0Yzydvuu1sAuXXxP2w/l79rEmqrtlq2pqmmN0tgg?=
 =?us-ascii?Q?ucmiCqUk3Yrpi4g5nNh/eB4iHiQzT1sdo8Bc5ITQgFJrYPl5u11UMXk8VC6F?=
 =?us-ascii?Q?3LdpgCfKxdhRJ2zhber8GLRzHFmAdFhjZ0DWxSFn17j6cLSXVQLpchUePg6x?=
 =?us-ascii?Q?DWs/I6C3fGXII7GiD/g8OhdU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7781171c-7416-4528-2863-08d96c1dc54e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 01:22:17.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m312FPY2soQ+hN2pCSjcqgQyLvgPR4fy0bSq59ynGirKpdaU5zetTsUrRf28ELZh8pGagtLXLd8HygjdizmXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310006
X-Proofpoint-ORIG-GUID: XF_fE0FygWnipNsFc5XlSXSotV6ZhUlL
X-Proofpoint-GUID: XF_fE0FygWnipNsFc5XlSXSotV6ZhUlL
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
RFC because IMO the cleanup of device_list_mutex makes sense even though
there isn't another thread that could race potentially race as of now.

Depends on
 [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
which removed the device_list_mutex from clone_fs_devices() otherwise
this patch will cause a double mutex error.

v2: fix the missing mutex_unlock in the error return
v3: -
v4: -
v5: - (Except for the change in below SO comments)

 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa9fe47b5b68..53ead67b625c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2369,6 +2369,8 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	u64 super_flags;
 
 	lockdep_assert_held(&uuid_mutex);
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	if (!fs_devices->seeding)
 		return -EINVAL;
 
@@ -2400,7 +2402,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2416,7 +2417,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
@@ -2591,10 +2591,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
+	mutex_lock(&fs_devices->device_list_mutex);
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
 		ret = btrfs_prepare_sprout(fs_info);
 		if (ret) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
@@ -2604,7 +2606,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
-- 
2.31.1

