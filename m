Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA1A492984
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 16:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiARPS0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 10:18:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14908 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbiARPSY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:18:24 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4LXi007574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=DfKP9UdKtAOKMPg53BgIc81X63FP+cOmV/MAXGJEFTs=;
 b=OCrZdktrIjEJwJxVwZjTZI0TzanPKAt1asPsTL8BgOAYnhSLqeH78GmjyScQARJM48bY
 nHQ6qQEH5LK9V/VCDunZkvcvVS3ZrUJ/HeaJ3c6ORn0dlDtjUVrbUFE8mbgQMJ2Xanlb
 iJL5djO2Vv60MYHXdgFRTppP7pkT0ocuOFa+HEt3foqgcyLerXmxecJ6l6GcqUxC/xPn
 Mnr7J8A1w85MD7vyt/goFXVTNZHpxReSgim8o69eBTgeedAamWdOeCdu2aZXN43LWhEO
 vQzoy3+9bB29OTjijdCbT8iKz18RIEA18oR6M2cvtZwoy9eTL2wTo+ob9LuPs1ZBLWD0 UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vj69a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IFGN3b136410
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dkp34b907-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8C/K7vcRuJSaHP4UXSItmzGLXEbhvYlYGjaNKewmq9MK4aDehKYjlN3r/1GQ2ABEpUKislgrQg18ZyJwmWa646AQl8mDvRiQFjbM+//ebQkH6PcbXg9dexaxB7EZ7Jw/jnKcxIoykXwEOyIrAkG3HorOXipnBE9QUSzoJEdPFm8dZFgnZqqSE9vaiLGunbO27cN+ybG4xLuPZu968Xa349YEps/4O97vf604PeG1Ud/KkQJHgwJszHd9hqwlhCtZdVEnPrArEgoiBa9uEF8N0syPK+LRNObiHSFJpGUGumWLUKx35kAneXnwOaX5dnDacATBbnlO8LEQXXT/TbaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfKP9UdKtAOKMPg53BgIc81X63FP+cOmV/MAXGJEFTs=;
 b=FP2oWYr9+9IgH1N+Z8QNk1QhNhWesKIGwrML1AMdOfN/+O3viURhYCIK3nsnqw+BssvShpPPLAI11jFA91SrBYs3fv52UCU16qp9zXiij04k0ZPBehIDt3cJ+s/dpZ3OrshlxVVgnSSk76cXb6WJMPM0vUAs0vK4oC1D/+pkOBqcmjBq6XKUsxKfsj8fnZjRtCIMi//N31qVlmQYjsKkBnwRP/d7LdVfvmr8lAyJFq3+gOMOMAugOwv7k5Kiiygd0Popl2emhxnp8TTEL4VHsDATkcplo4h4seeMo35RK/nc9w1Xm6w9zUdfaWTDfNAZz4XMx7+RoHwUW7zRHBEu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKP9UdKtAOKMPg53BgIc81X63FP+cOmV/MAXGJEFTs=;
 b=hBXd4hUT394AOUc81phPWGEVER5yuSIw/fb2U5sULOaiQK2aB6lsAn8Pq1OoYcfpcmUR6LTESZ/zavozr8In4N1PrHsy1Gt67GF6pQHOqmuxB+SyG6gPzHOmq1cPAppGxasD+9fibeoY/W05Tea/hyUiTmehBGxs1LxssJ0weLE=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MWHPR1001MB2158.namprd10.prod.outlook.com (2603:10b6:301:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 15:18:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:18:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: keep device type in the struct btrfs_device
Date:   Tue, 18 Jan 2022 23:18:01 +0800
Message-Id: <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642518245.git.anand.jain@oracle.com>
References: <cover.1642518245.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace704df-27a2-43f1-6bdc-08d9da95c2ff
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2158:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2158E3B4F0D84A9DB2042ABBE5589@MWHPR1001MB2158.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1wcCEC2s9/Ut2a4WKfivYCG10bItTLEp6X7/Kmq1vmnzHFYmXeQ42oUE6cakTOY4FG/1TU0HQIB2Fk0nLps1htUJShI8YqchVXqqYbcNqfsLyfWYvomw0MzmHu4cWh9zCtO65Vcc43UfuAxGiFaaClhUF/KMywDio7VnqjrAMgZv/HkxTttkbZoPBx37T96Jy6vLFdDMMKocj7lCTOK6DzSQkNPAXVaWc+ojgDNq8GMuxLteJXpLvoCVrFckLm3/J9EYjoMbKR+t9uk3A7WMHx8AY/IyHB80GhVsXNimdUe6CNEBI0BuSpxZFIOe+yK6wgJBxLktAUXDGZmmAjk8eH1hoPgNCzVpc5myRxtkUahy7X/OM+VeoTIRoch6pYX6UufP8ptgVWMIllSD41o9VJ/Wb75uBuqswPZLEPMQ9+G70f6GOO677/ueXaf7MN9hI8o4ncTgykDBpo92hAQiwpDp6klbaT4S0+QLB79XMjAA3RKzG/rwvBcoawe4x13pE9WodT7YpNWGbH5AzJmctMrTMbAG3M/MiCXA8ryKz9/hqxTXYZ0YIWdw9Dk08jhdG9dJiPjGAFJO0Hd6hlqwqi5+wT0LuCzdIsbF6A7PnZ+16B/dGt0GvlzUH4TC0ekiYtCqMq+3hXjXuvTADLOqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(26005)(6512007)(6666004)(5660300002)(8936002)(316002)(6486002)(186003)(38100700002)(6506007)(66946007)(83380400001)(66476007)(86362001)(36756003)(44832011)(6916009)(2616005)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPxHJurcds0XpHlqhmESy1TbLZuylCkipJ92TiRzwFaMfSqA5dJ+yEkyeDnd?=
 =?us-ascii?Q?kYNnCME9+P0X76Cd1jWOG+Q+CWrkeR1thndkQ0iD2nDYfKfgfSZ3kswzHlW1?=
 =?us-ascii?Q?e5bNhYvk7r+fIkqLG8bvKi8fFiopr4N7r2FliiItpUSO8Lw1YkRMsPFQXez3?=
 =?us-ascii?Q?bJUP9UeH8dbPwORrkpSchpe1D4sDog7c14PLzPmC1x04maETSrDatbDMhPpU?=
 =?us-ascii?Q?wz2+zK1hX1nPC+RHJrE77KU0SIqPGEZByP//EgeuIThnbO74lX4p21IW09bi?=
 =?us-ascii?Q?sgWwnVHMA2UQIRWE35s2x5ZS9pNd5e45zb7L42lKPzZhqKWa77swNaCZultn?=
 =?us-ascii?Q?RXjXZGbZGnMJyTAkEBV4Yl4Z4U6ddGp2MPJ+DCEBY17Qu3e5xiD8JdzwMlfc?=
 =?us-ascii?Q?Flae8puZ10YAyxoszOD89Q0ZFaqRhMm3WG/Fm+u/OD8pY2BSFAok4XzvtmCp?=
 =?us-ascii?Q?qlDJZEu4Sw/pRksC7pAw8wAeiLFk+BHOqv5S5sxuyIWX71IbuwliCdICN40h?=
 =?us-ascii?Q?q1f5vxQAmGk+S4j9oCcxo3SHyTtf7wH135yYTDZN+44XjXLL89J4KeQ5zBmv?=
 =?us-ascii?Q?MvJ8mNOdJvslFL9y/JcCAh1zWJsfO96Ntl7GJ20y1AwsrdKCZ/bL41kN6lw3?=
 =?us-ascii?Q?jouygy/Facs8L0uMaLSW4qEngb94wayxLS5kpji1K6PseiPwbj+373GiNiWm?=
 =?us-ascii?Q?Epe+i4GX9iyBMyvMz1wXWjN9MsoQJfVYqvafcjZyOzy/FxEYDrrd2DCFBL7P?=
 =?us-ascii?Q?ley3M3DoFQeP1LcSpipAW6f7J7UwOVihdp3h5vH26/IP+MRP2dmHk9677Dwb?=
 =?us-ascii?Q?Y1A7F8s2i6O4BWK4hAw9A2jMqmoYUekAuaFDHGSTA1SmMawJbKuVIN0VPpRy?=
 =?us-ascii?Q?MIK0GRERKZM1QTF/MmBuCoQ2cWxluK/3D8hC5c4VOwfsxgBG2o/kXW36TJMk?=
 =?us-ascii?Q?zOaHPB3xyMEXdl2mfFek1c6q0+kEL+4xpygR4Xu+D1oXG2/Qh86H8Cfbvq+0?=
 =?us-ascii?Q?qFmYcBe5uBjMyrdbFgbJv/lEtc40tnJ8kz+onvl1rlzp7zDntAaKIM2HBg1l?=
 =?us-ascii?Q?UERFAWJf/vh6VvIVKsDT4tGT3GyPd1PCOCfk3dqnI0sY4KkMmupwswUQhQVm?=
 =?us-ascii?Q?AGR1FhEHJCz2sKogeC6/eEuUFRUJUw2XgNCnmJPHJ8QVN8olVScCWw6W3Ycd?=
 =?us-ascii?Q?RouUUWVeARW7Xev8WkWtnzIRTyXXDxuz37FZcfNz23DWcDkeJlYh3aJwuYsC?=
 =?us-ascii?Q?A27MHGw4VF//z68R2jq23QVcvxZdHIGfhIuA78LyWkN96TDN8g78bzLPN2pU?=
 =?us-ascii?Q?LQe0dtPESqCycvTmH+bEKPZli2dXw0piRPRnaczaJMCFdIw/1kZ79y3oCSGy?=
 =?us-ascii?Q?KiFp8HSJTG0/cGvhnvru7ZW7myXBR3SCBfpcLt9ZpLkKzF1ThQSrRuD1DGTE?=
 =?us-ascii?Q?W0TFjU0EAB5cIT0IkJ0Gx+hExRUyVKRBTikWt9ZhtDvpVdivyq3ltR5SAppu?=
 =?us-ascii?Q?R3JW9uZ5oMXirr0Nb/qzO0L1PXuaCRJsP5yPZJIu1jxrV89oiyU846N4Qq7y?=
 =?us-ascii?Q?M4WbROQ4PyRChO+lTo1lZmOEMiBh+NmOXn8C6hyRLwv7aVbLthM//OPOzMf1?=
 =?us-ascii?Q?YjIfogSeFxZ+hH//Id8VR6U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace704df-27a2-43f1-6bdc-08d9da95c2ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:18:20.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c/6o48saMP8/J+ZoIf21CNnvUYXzI20zl8ACnTnF5ux/v8eB9V5OBvhRZzqxQvExNvDH87bOfHqV3xqrWnbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2158
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180094
X-Proofpoint-GUID: JxDd82s6F5Z1DP-XSLHUXd4s9iVe2pOM
X-Proofpoint-ORIG-GUID: JxDd82s6F5Z1DP-XSLHUXd4s9iVe2pOM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation to make data/metadata chunks allocations based on the device
types- keep the identified device type in the struct btrfs_device.

This patch adds a member 'dev_type' to hold the defined device types in
the struct btrfs_devices.

Also, add a helper function and a struct btrfs_fs_devices member
'mixed_dev_type' to know if the filesystem contains the mixed device
types.

Struct btrfs_device has an existing member 'type' that stages and writes
back to the on-disk format. This patch does not use it. As just an
in-memory only data will suffice the requirement here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c |  2 ++
 fs/btrfs/volumes.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     | 26 +++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 71fd99b48283..3731c7d1c6b7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -325,6 +325,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_devices;
+	device->dev_type = btrfs_get_device_type(device);
 
 	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
@@ -334,6 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	list_add(&device->dev_list, &fs_devices->devices);
 	fs_devices->num_devices++;
 	fs_devices->open_devices++;
+	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	*device_out = device;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9d50e035e61d..da3d6d0f5bc3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1041,6 +1041,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			     device->generation > (*latest_dev)->generation)) {
 				*latest_dev = device;
 			}
+			device->dev_type = btrfs_get_device_type(device);
 			continue;
 		}
 
@@ -1084,6 +1085,7 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
 		__btrfs_free_extra_devids(seed_dev, &latest_dev);
 
 	fs_devices->latest_dev = latest_dev;
+	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
 
 	mutex_unlock(&uuid_mutex);
 }
@@ -2183,6 +2185,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
 	btrfs_set_super_num_devices(fs_info->super_copy, num_devices);
+
+	cur_devices->mixed_dev_types = btrfs_has_mixed_dev_types(cur_devices);
+
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	/*
@@ -2584,6 +2589,44 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+bool btrfs_has_mixed_dev_types(struct btrfs_fs_devices *fs_devices)
+{
+	struct btrfs_device *device;
+	int type_rot = 0;
+	int type_nonrot = 0;
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+			continue;
+
+		switch (device->dev_type) {
+		case BTRFS_DEV_TYPE_ROT:
+			type_rot++;
+			break;
+		case BTRFS_DEV_TYPE_NONROT:
+		default:
+			type_nonrot++;
+		}
+	}
+
+	if (type_rot && type_nonrot)
+		return true;
+	else
+		return false;
+}
+
+enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device)
+{
+	if (bdev_is_zoned(device->bdev))
+		return BTRFS_DEV_TYPE_ZONED;
+
+	if (blk_queue_nonrot(bdev_get_queue(device->bdev)))
+		return BTRFS_DEV_TYPE_NONROT;
+
+	return BTRFS_DEV_TYPE_ROT;
+}
+
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
@@ -2675,6 +2718,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->mode = FMODE_EXCL;
 	device->dev_stats_valid = 1;
+	device->dev_type = btrfs_get_device_type(device);
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
@@ -2710,6 +2754,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
 	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
+	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	btrfs_set_super_total_bytes(fs_info->super_copy,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6a790b85edd8..5be31161601d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -52,6 +52,16 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 
+/*
+ * Device class types arranged by their IO latency from low to high.
+ */
+enum btrfs_dev_types {
+	BTRFS_DEV_TYPE_MEM = 1,
+	BTRFS_DEV_TYPE_NONROT,
+	BTRFS_DEV_TYPE_ROT,
+	BTRFS_DEV_TYPE_ZONED,
+};
+
 struct btrfs_zoned_device_info;
 
 struct btrfs_device {
@@ -101,9 +111,16 @@ struct btrfs_device {
 
 	/* optimal io width for this device */
 	u32 io_width;
-	/* type and info about this device */
+
+	/* Type and info about this device, on-disk (currently unused) */
 	u64 type;
 
+	/*
+	 * Device type (in memory only) at some point, merge to the on-disk
+	 * member 'type' above.
+	 */
+	enum btrfs_dev_types dev_type;
+
 	/* minimal io size for this device */
 	u32 sector_size;
 
@@ -296,6 +313,11 @@ struct btrfs_fs_devices {
 	 */
 	bool rotating;
 
+	/*
+	 * True when devices belong more than one type.
+	 */
+	bool mixed_dev_types;
+
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
@@ -636,5 +658,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device);
+bool btrfs_has_mixed_dev_types(struct btrfs_fs_devices *fs_devices);
 
 #endif
-- 
2.33.1

