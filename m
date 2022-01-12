Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466D448BE08
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 06:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiALFGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 00:06:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56028 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbiALFGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 00:06:49 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C4MuhA030467;
        Wed, 12 Jan 2022 05:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=sJjSvm/0zY1O4d2ItfaVihgbfiDDfVx3ac/NIYybDS8=;
 b=ghdAr8dm3MxpU346suCSKkfSGpTsDs3mbyzZkOe5YpXrG/K/AVu/iR0r+0GZ/BOFqajT
 l/xZ90BjRTmSieA7KQc+D5vTXHt2GnomUUvL5r/N/jl439BRGfmP82FkU3yu9u93Ab7M
 VXN9lOR7PRV+KEJpGkLWV3IxwfJjDPyTGQJ04LDP7wpCb+FHZCktPToXNQKDMte3nxEt
 JxB3NcpF6BrJAPkqSObCAYw7d7XtbThub9KMQjKiMBdB+2q/ZtjXzgkPADr6nDOJaV3q
 WxAwrN3HoPlNsg5TARUYRmNsKwmBXqkyLFAhoIJU1e/m7pB4MmwMAPAajEdy2s9olzOB 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbwcvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C561cP021814;
        Wed, 12 Jan 2022 05:06:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by aserp3020.oracle.com with ESMTP id 3df2e5rkux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA9/SusnCyz9aRqhCXRQrvCCT3gNAmm+cTr/XeGW5Z74PT1LTVHORR9on8T+j1hmb0VSWhfHN3NbXUZJ33MYFahI95cU+L6ZfJL5M65q2v6sx7qI4JawZTX+xvSU+nkCZAxqRKrFoPmdIwrEQkAOxnT8vmaP5frupcj6SYi6L9JG0/0I3LOTyM+oHybmqUmyI5U5G/HL1GXq6+6FoE68yj2gptHdoPxaeq+xK45ZFWFmVTe5UhQpBQn9hOa45AqMK9Kr/lAFiFT1lM7h3yCgAELsILO4XKh6aaVdv4LPAfksrMoCj0rhSmNOaf5TUsoQcbwm+mEhGzPPZnnOeJyiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJjSvm/0zY1O4d2ItfaVihgbfiDDfVx3ac/NIYybDS8=;
 b=dtPhJJUQc3Z7eptUNvQFpe3PM75p8xJDFH9Y8+gbqOFZDybCGz6vH3Y1fWWQCnHzSoBQZE/oxZGlX/zBXxtnY0H2QXyD1RFtXvxyjdig1RwBC+/fiHpibETDauoDyu/TTAF5OvacJbFsVV2Ga7weSTOqkQJZwJEWiBsoU25M89a/fH/wjJ+CgoGDJSLZUrm/XwTQd/nlFjxRJqtQ7FT8u0544UgwN/Xo8Idi0ZdSeXdtjI8rDdlBXl3UIwkL7Uq5bAr4laXWNuQojX9Sp0ogKJzzHKFEPgWJDy2HqRp51twEyuS9H/k4sohgXdAzagNL9xHCCvJo8/DR7YeMEYi9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJjSvm/0zY1O4d2ItfaVihgbfiDDfVx3ac/NIYybDS8=;
 b=tz5plTxo7QXFi3ZGDnl4PUuY6DLC4VMfpUHoxEnkA2tw+Dcg2exz/1LLMYZO/qFNdWyyyluB4V4ffyBUuBtANiP1pSTlxKGec4UnkDovDX25TTwgReWl+CXtMB7IRwf92UnR/WtBjDWTq67Qior5n63PQmtE31JYV09EQxAc9e0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3904.namprd10.prod.outlook.com (2603:10b6:208:1bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:06:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 05:06:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su, kreijack@libero.it
Subject: [PATCH v5 3/4] btrfs: add device major-minor info in the struct btrfs_device
Date:   Wed, 12 Jan 2022 13:06:01 +0800
Message-Id: <a784e9337c09c66f3c94fa23ac4f8578688bfc9f.1641963296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
References: <cover.1641963296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ba896f-abb9-45e9-ab5a-08d9d5894faa
X-MS-TrafficTypeDiagnostic: MN2PR10MB3904:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3904F124722D95AD7EBA64FAE5529@MN2PR10MB3904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mci6lqd89Yws5ev9L57Z8xgLJdkC1iRDbki0xavVq6uWG311Tc+VRfIYBhJEpcBazrslgALhXgypdiqMDMB7pOKGpIF1Rzf0u67Q/xCN4oi8h90uJ7Y3OWK5UzThC/09Gekfb5us/9xapf+FlxiDsV7eRWrL76UO6ZfUiETeRxMNHTEgcAZAPIK6JdQxmoXf3ph4vQu2SifTpsBOK4J438hys+IOvzi95hFmdVa/GI8Ji/gquwSwxkS13CXwQYaZJg/L0L2wWsHEkAJn0NO28gaJD9VIuj8+LqRx2N6m9UEaEY6NnQXPl52ErCfSnTi15N/VleEbRs4nlvbLEfeYHMuq0bcRQLPL3P2EKWIcgPBQ3vCkR9SMhGH8s8DwNlonqW6wKyn5itc9eKVqUg2NoUVm2UstC/GblM2CuMWR90F1sNHqSEM4Pw18axV9+L31O9i0zH5pHPGo701vTPdZVyLWTOEB7Xt7AhX//MP0lH5OqLdWhLUPoC8Rthy5WcwO0OzRsVmeyoPMHZmJTPVygG5ifOUdNHb7a/vnjZZnoFmjLauzAx/yIrdu1jOBe/3AZbPE+wmBmbnEwTIJSHDNHj5RKksDg8NVGCDSlJc4NNvGaD8bWRFuwL9eR0DifyfOJiXf2YVs7O+ocbEd3m1BQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(44832011)(86362001)(83380400001)(36756003)(6506007)(5660300002)(508600001)(4326008)(6916009)(8676002)(316002)(6666004)(2616005)(6486002)(66556008)(66476007)(186003)(6512007)(8936002)(2906002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efg6+GQHtud6vryz2zB3VhXq/DOI2RaaY1p2DSen/QZh87KQPLfYL/tAtiCr?=
 =?us-ascii?Q?O8rHSyoDBiu/0hYIftacNQJBdSP12yPy1uiWj2m/XSPCn5Y7Qk+9ACjvznGG?=
 =?us-ascii?Q?0kl+6GY2wy8oo+KofUzUIoOGDp7cYe0PhJg0l/8M9CX9XWItWKwcFeaNNJpH?=
 =?us-ascii?Q?GNi6/hRO1lGNLpR/urtkxcy7Lo+p7l5Y0X6vPfxbw0jcpMOlulrfSvunfbSs?=
 =?us-ascii?Q?RuZS1a4garYd4mGosKxDlSDmzc5aE62bQcmLVhHOqLgDF+OfoMRdxcjv8r7j?=
 =?us-ascii?Q?eqllAhPiSe5D23oKyj1qnS/AuGX6dqJDGdnwE1iQ5AiNusZ1vvoMUOLs7vjr?=
 =?us-ascii?Q?WAmRlHgWG/s+rIP1vatQYIOUxAnLm91w/OqtDCgn2C5q7LJkCCHxmYj88UKP?=
 =?us-ascii?Q?mOs7BbZRf/BSnZLOD3DZ6Jlrsvk/XS4HXMicXd5Ji4YtSt/ed+OOMVHhMnRb?=
 =?us-ascii?Q?OWIslhV6q3XEFKXtF1RBbl50tD+mgMYGnWmIXo4Mgkx9nZuAUH2KOs0U8/vh?=
 =?us-ascii?Q?7Xcy5mfOCQylkVYb/siE2o8c/3kodVHwkMWgQ2TO9MfegKy7WNoxFVOTxsVe?=
 =?us-ascii?Q?xG3RC5enKSp69w4gMXuyRFkYmEmXSLM6K99W+2c3LRCZwJmfOq5JmkPVkBVn?=
 =?us-ascii?Q?neJh3dD17T89OrphRgGBI8hS7VR0+u9YXNhS3angF1l6DmGpQZMLCuFvm3+B?=
 =?us-ascii?Q?gYePRKIVrZdEkEn7voyfe/1mdX4jPkjWo42yeWYQPS2YdB2OnRpnAV4vAB+3?=
 =?us-ascii?Q?VhZ+OVEcNZC7gQ/h9/dPtZz0YjS52kbXIhNRdp1GUmvA58ngXNfVjBCdkHoc?=
 =?us-ascii?Q?N50P2dph+doNrS7JfXYgW99Y+HXhYa7D8XBqaPMe/O1slLRVP9V9pdrUhuhs?=
 =?us-ascii?Q?++8P4T8breLwmFDxUKCgxrjz1ONqRiY6ulJy8BIqT+wIFXVmooSt3j/cZEXa?=
 =?us-ascii?Q?db36bt8EM3xXgoGPNhSQGKp+b0nkF+gqJAlqQV3FZ5vOK6feBcQT/lw6U4gd?=
 =?us-ascii?Q?fZkbv4NtQVaViYlXBI5tuOlyTP8Oi2HBlwNw+2eCSxFvBEB69GEnNBADN3jK?=
 =?us-ascii?Q?mhuIFyyC2KDHjOvjXBFenCslUCcdt0xHWatBGuhQn3Z4PCFeOwYcAPwxdkG9?=
 =?us-ascii?Q?FgAoAsXCcSfOGU8ILzlwgkJkM5FLGUr4szYbUZsZ6xSqovz2ABxZKRPQyGwX?=
 =?us-ascii?Q?iH80rrWHXc9YYldrR2KaTTKmJKa9SYTj5EaknUikOC8yaxdVjsh9YEMgWOBT?=
 =?us-ascii?Q?Om9i1IDqjM+X9Pf29+SNJGCmHccaNqPy1w/IG2Qp/RFcPfd1L43SgT3IkFG4?=
 =?us-ascii?Q?T8rhaeekshSgb23F1rMgKJ1vfJVUQUohca5xACI1I5roWcame7N4UEGS+cU1?=
 =?us-ascii?Q?o2TPE9KBhnWaw89x8GNJDZnTJ9i6HHdOT2fUmC5URa/qOKOObsBH67YTxa6y?=
 =?us-ascii?Q?AIm4F/yoYLmk/ipKbaum0waG5ppzHAbtHz8ZMHdCntq71dkKtKND45/wj9uf?=
 =?us-ascii?Q?5xn0mKKUqcMi/gwjyhxF+MBtgY4tMqzQURFypEfA8zESoj9GKLKaxkhZ3SGU?=
 =?us-ascii?Q?Wi8/TUs4bXUBi+5AuDSJrtHHc6fEyV12+slbB1eRDPj1ZB6D/XBxaCSYLIAh?=
 =?us-ascii?Q?cWpUewIBX+bJbQlMvj9RH6I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ba896f-abb9-45e9-ab5a-08d9d5894faa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:06:37.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Lrwz2EP62Qhw3KwL4ANB91EowJv1ZPtsDeXUwH1GeAO364fqKrh5519AbX6ET8becrCrhu0IQDce4Nn3uFvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120029
X-Proofpoint-GUID: 8-ZOxe9PO9LTei_irlqyFeM_5mks6peA
X-Proofpoint-ORIG-GUID: 8-ZOxe9PO9LTei_irlqyFeM_5mks6peA
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
v5: Add more comment for the member btrfs_device::devt.
v4: Add comment; And, use the logic lookup_bdev() == 0;
v3: -

 fs/btrfs/dev-replace.c |  3 +++
 fs/btrfs/volumes.c     | 40 +++++++++++++++-------------------------
 fs/btrfs/volumes.h     |  5 +++++
 3 files changed, 23 insertions(+), 25 deletions(-)

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
index 8cd273a9b325..5044b8f9cfff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -818,11 +818,17 @@ static noinline struct btrfs_device *device_list_add(const char *path,
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
@@ -905,6 +911,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			return ERR_PTR(-ENOMEM);
 		}
 		rcu_assign_pointer(device->name, name);
+		device->devt = path_devt;
 
 		list_add_rcu(&device->dev_list, &fs_devices->devices);
 		fs_devices->num_devices++;
@@ -967,16 +974,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
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
@@ -1009,6 +1007,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			fs_devices->missing_devices--;
 			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 		}
+		device->devt = path_devt;
 	}
 
 	/*
@@ -1422,16 +1421,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	}
 
 	device = device_list_add(path, disk_super, &new_device_added);
-	if (!IS_ERR(device) && new_device_added) {
-		dev_t devt;
-
-		/*
-		 * It is ok to ignore if we fail to free the stale device (if
-		 * any). As there is nothing much that can be done about it.
-		 */
-		if (lookup_bdev(path, &devt) == 0)
-			btrfs_free_stale_devices(devt, device);
-	}
+	if (!IS_ERR(device) && new_device_added)
+		btrfs_free_stale_devices(device->devt, device);
 
 	btrfs_release_disk_super(disk_super);
 
@@ -2661,7 +2652,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
-	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2711,6 +2701,9 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	device->fs_info = fs_info;
 	device->bdev = bdev;
+	ret = lookup_bdev(device_path, &device->devt);
+	if (ret)
+		goto error_free_device;
 
 	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
@@ -2853,13 +2846,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 * Now that we have written a new super block to this device, check all
 	 * other fs_devices list if device_path alienates any other scanned
 	 * device.
-	 * Skip forget_deivces if lookup_bdev() fails as there is nothing much
-	 * that can do about it.
 	 * We can ignore the return value as it typically returns -EINVAL and
 	 * only succeeds if the device was an alien.
 	 */
-	if (lookup_bdev(device_path, &devt) == 0)
-		btrfs_forget_devices(devt);
+	btrfs_forget_devices(device->devt);
 
 	/* Update ctime/mtime for blkid or udev */
 	update_dev_time(device_path);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 76215de8ce34..d0c6dfcfc0f6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -73,6 +73,11 @@ struct btrfs_device {
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
+	/*
+	 * Device's major-minor number. Must set even if the device is not
+	 * opened (bdev == NULL), unless the device is missing.
+	 */
+	dev_t devt;
 	unsigned long dev_state;
 	blk_status_t last_flush_error;
 
-- 
2.33.1

