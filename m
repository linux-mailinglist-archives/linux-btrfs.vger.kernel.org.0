Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991B24899BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiAJNXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:23:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51174 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbiAJNXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:23:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ACrfsE001308;
        Mon, 10 Jan 2022 13:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BJcPHsupW6ybUlHEjN0Xqe5V8xPqwhC25TYpgGcOKMY=;
 b=fYf1YxnBLCRWOQ/ovbWlrjd0sqRLSDm9WTOR0l8Ap86Vg1bIXsYe9YIGWWxpAsVwkmOl
 VAsy0s+nJYVrdLwvwDqSgg9Znhj6ck0Hb/PtXZc03Bg11I9pcb07loGx6DIfwO8OpxQ8
 mWCB2VBH3nAqv5+kgV708D4h90JSyGPYpk2VT/Q5YTDATX1osaipfsY/MuRistra6/45
 g5IYPF01T4EvdwG7sBrnaHcE7g9k+baP/ztvEt3qq/luWLTDDzRal/qxZ6Tjv2bclr4S
 FFpx/zLCUdUSr1dGE+Ze/g+Y56/ecegWknwhA6U79XpIlubpnqoFE+kYa3OcyVB+m6rP Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn7481uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ADBaDw018246;
        Mon, 10 Jan 2022 13:23:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3df42jxy96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRX5hn84Su8ZCp679+mKKevfdiTvMk7glR8gCbAn/QoUgvJzjjGd1fXEm0TUQVkx7y+9sOYc0uT1w0w483fYanyMewjQburWRAFboamuG5JNzRWW38gDsJ2tVpqq06tAf35mPyZ6eWa+C18LKx0/PKB3Z2No+MOPbLiZWzpyA+fn0qdgvw58rR7ywwHvPXBQdiMCpAdti+nMwMuSs2/3kkhxyAWvk4ltZ79t7pvIWT/nr5oHT6l2Lmx5FYhjWqzhkXQXxsN4/cMa31UuaUmYXXajJDWjV1hiw61HmoWDimp/cuzHogWbhRcuw0GgbLXbGVJIJ/XGooSw/3fWMXt2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJcPHsupW6ybUlHEjN0Xqe5V8xPqwhC25TYpgGcOKMY=;
 b=GsnpsMkoOz96wD0klWh+KjaVKtipSwmqR2gUlPajvJjYeVk5s6lg+yiZ2GiCVojgGb9q/sxzrHiOuAAoUyVfdN/M8j7rfNrF0eJ4RVjj3GnVnGXYIGVIFIgTWYGfFxPGSiaPWq5VWY99JtVRhH8mbQ5Uch3GAu7VV+0BRGOj7mnkrd8vXT2mCDp2jNWEd2c3XN/7tR02y/VbH16dsm/3CTBZmrXJgar2hSDfJqjvFc3ipDF0arncuTTkcO2ur/uWW+FyBSd33GgYhWcYhJPOMBfdlhQt3FiRoBaP6A6i27Mwx5YWHZmTPmZwiYoK4dxT1Hlrs86KoTYgJjzI89kNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJcPHsupW6ybUlHEjN0Xqe5V8xPqwhC25TYpgGcOKMY=;
 b=ZbQk+sTBW1Ugoi5aEtDKPoswJWGaf6ol7BBi6IDb11S58BCduVDLKQiujNiljXJ8kcLMJYpRlC+tqTKHm5Aaq0TUOwmYuye0waic+RmhZ4AXvRjWL5Q8zWtEc4i1cvk/4KhdnWLvD8m9YijRxYycZKGIO2CZrR1FuLrXtnDlGX4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 13:23:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 13:23:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v4 2/4] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
Date:   Mon, 10 Jan 2022 21:23:12 +0800
Message-Id: <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641794058.git.anand.jain@oracle.com>
References: <cover.1641794058.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82eea00f-5756-4109-c290-08d9d43c6893
X-MS-TrafficTypeDiagnostic: BLAPR10MB4852:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4852753F4B15C7A78BE13768E5509@BLAPR10MB4852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: The41LzuwCb7Jkpz7ZbJgCm03NtsLWKVG3zGj13PbWq84tdEgkP014jLe/p/jp8UXRzqfG0sAiS4oDUQajv5QT1E3fYbQHL5CkkZdvIINJj8rxBLLMLI35G2N5BqIVegey2YbQUw+DG46MeDubo8k1+Hpu0hJmEoM9KrWPbPzZJUhX4q0KoEiL/4F1N3AWYCH9oLY/SxS31aj+W3rXGiRRRLsDKKkZ70AdKK7xfBXPt/dJrPNxIYlLrqBSzKK4ZEs/Vw1fmk9GGraNFIO1pfln4UdA8xq5l669w7BhU3xKjYfL+VF9bVysxHYIU44HJwJ3x1F0Vv8ElRnb2aIcebHXB1gA09Q+GX3+78zw5gMtTUE7QKunxvlQoF8CFGam303uGpaAIXdx8WYdXKv4WJELmwYdbpqbfBFcKpmuwAeSd75uwaf2glIN7it1SPrmN0GIH8hGJAyt6n32KkBf01hrBsrr+M3fdYW38emDAuwRSU/NAvv/1SJGNn4xTJIJ2CAc6SlRT+A7FuPSup2szzLgYoO6yucIicKBPI8yANvOEauD1zlV24uRMh2XJUMPnHCFpCfinZYMuBC2/pH5ORbSCgN5VrvQP+1VUOlQh/Cd2E620Cw+gdC2ce2FFaaPt4SPfvyc1fzyya01O3T7Jy7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6486002)(44832011)(36756003)(83380400001)(66476007)(2616005)(6916009)(66946007)(186003)(2906002)(66556008)(26005)(38100700002)(6506007)(86362001)(8676002)(8936002)(316002)(6512007)(6666004)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLe2d22P8NrR9ErK2GhyHhONIGhz7wM/duKUm4UKO3YY0SdM8nno5qWO5Mzz?=
 =?us-ascii?Q?RDHr2EvJeZVV5Ny22lZuCj9M5RUeDqmjUsO2AIDF9vFxSg2om+m9gn1YNLy/?=
 =?us-ascii?Q?vszSQC0RiGD91dKAGGDcS21cjpKRMHw017txWhQvskqqm7WRZ9w5qU/53k8v?=
 =?us-ascii?Q?+Pn0yDKzXT8syYvWoZeS2PLSkQG5WVmZiEbLS+7NKV/AUywqEGP4mEMTjgm5?=
 =?us-ascii?Q?Scohfxq+lc4sT/qz1VNrrJZxtfgCUzm6cgJfD9+Iiu7X5xjxg7WpjilJ5JDL?=
 =?us-ascii?Q?OYDC7r9pgCxWa4kcZLqpogRMwAVso/aZ6vhIUYto7GZUCRhQDAdNvMPO4pI+?=
 =?us-ascii?Q?0x0ebDzD6xjiTkloXLl9/j2q83nO3Z/9L4mhTYnwWbmTXieJjAbxETcBQdxO?=
 =?us-ascii?Q?Nnj8DJrgBF6eJVRk/XkgxSjQtszBvq/WYdVc8gMMS4HCfENmfuVc8KfzeU1m?=
 =?us-ascii?Q?Zep/HeU5yIizMdhiSjWJJkMPcZg9RjpZXry9CqnSjSS2mkB6eSsLe/bABkld?=
 =?us-ascii?Q?T3OSQehHSDtXxHM71K37aqm8XYOb8XPBdiPuRR+jX02ThHRLKXB/xg9tolbK?=
 =?us-ascii?Q?IV1Nl26WkJmalL+cCDLVarL1WBtUuBsBxK7EiWX+QdX/v5GWctzLorOFmgWx?=
 =?us-ascii?Q?Z8dsUKNOnywqDVOps1D4xCU8fetmMipf9AuR90kVCf6jDCEWlI6eAc30jE4W?=
 =?us-ascii?Q?aPMQpr5s1KDSPcjE7Dkr1vtvodS3hp8hOrnvjYeBkdPVTLsfHM9+odtb+joh?=
 =?us-ascii?Q?sSAELo/OTQQmN+QzLTSouD0Lyr1l8osSaxSCP87qlbNxiVegwwmC2Qnkh9DE?=
 =?us-ascii?Q?HrMybtmcl6r8TznrQ6PoJ0zOzBBtyUcaWKJZuKauwXVCRvWSFTFfo4eT9R7Q?=
 =?us-ascii?Q?aFYik5KwrcRUe3tezHnJS5v64T6ej8V7NyDQ9/c09QnoFTc4UyVWXGhiz4hb?=
 =?us-ascii?Q?NugUwrYVPL0+cEsU6m/6M2zOUNr1KWpcstxrucStL5ZG0mkJAR6n51fRfRFH?=
 =?us-ascii?Q?EmvlOMM9Ai4wNxvCWRxCKwGKffwhxj1BmmoTbPIShmP9+BwbAjT61/FHG8y5?=
 =?us-ascii?Q?9axnJ6F7tjPz/p/nmpLFmBKFkHy93KCkJ3uFV0IELwuCwngkUkEE9hi5apja?=
 =?us-ascii?Q?gNaJKGHkKC6VTUSrqMKkSIT1Nc+27SSRQ4EP9ixh4asAtF7F4uRX/zdHk5j9?=
 =?us-ascii?Q?muk/lVuUOBURVazIpRDBadTqWmRDMijM9ujRlmRWvmRpkM3qOHV/Pd2DAyCA?=
 =?us-ascii?Q?MakT8fvQKkcNyu/mixnLtn5U+pu06Ua6SvVwqI8kWZa4n8ob2akcMAe/yze+?=
 =?us-ascii?Q?G/EWz3eRWk5O7fjo3rgX2pqMREnRPouPnNM8ayP7EvuKJEEftxwyrkDyhfNc?=
 =?us-ascii?Q?x6hdBeSQ87o+ckA/tIf53kEJOdj6WYZ3VMjbPvlnElS69nMJxehyzEsravXG?=
 =?us-ascii?Q?jT+IWLz1j4CDq4utaJgAabus8seIE7ZVmSux8mtPcQ4eKuOgtXXWKIV/c8g1?=
 =?us-ascii?Q?7eozV83Z1en+Fx0u7UuFzxTeVrQhMEi0ntBJNkrNtEKiEDWviDYbAoisXvCN?=
 =?us-ascii?Q?DHtp3JfWgDN1dv+Q5o0e7g4GMW12fEkj/RU5Dm7guVuvUJFZRaEObq8hI5gK?=
 =?us-ascii?Q?SFYc/sKBkbO28F1kn7fTPSM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82eea00f-5756-4109-c290-08d9d43c6893
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 13:23:36.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiAsCcFF0jotUC5ElLEiXxf+GriVLNhr5QKJquz1dV5BHfgUCUU4n/HfC8uupgWbW2oeD0iLPosSQV0x0pQUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100093
X-Proofpoint-ORIG-GUID: L8y2HnTuzhYAuGXFaNuAY7eLBxlh7Ley
X-Proofpoint-GUID: L8y2HnTuzhYAuGXFaNuAY7eLBxlh7Ley
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit (btrfs: harden identification of the stale device), we
don't have to match the device path anymore. Instead, we match the dev_t.
So pass in the dev_t instead of the device-path, in the call chain
btrfs_forget_devices()->btrfs_free_stale_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: Change log updated drop commit id
    Use name[0] instead of strlen()
    Change logic from !lookup_bdev() to lookup_bdev == 0
v3: -

 fs/btrfs/super.c   |  8 +++++++-
 fs/btrfs/volumes.c | 51 +++++++++++++++++++++++++---------------------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1ff03fb6c64a..6eca93096ca5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2386,6 +2386,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 {
 	struct btrfs_ioctl_vol_args *vol;
 	struct btrfs_device *device = NULL;
+	dev_t devt = 0;
 	int ret = -ENOTTY;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -2405,7 +2406,12 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		mutex_unlock(&uuid_mutex);
 		break;
 	case BTRFS_IOC_FORGET_DEV:
-		ret = btrfs_forget_devices(vol->name);
+		if (vol->name[0] != '\0') {
+			ret = lookup_bdev(vol->name, &devt);
+			if (ret)
+				break;
+		}
+		ret = btrfs_forget_devices(devt);
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 05333133e877..c3f387cb549d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -543,11 +543,10 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
  *	0	If it is not the same device.
  *	-errno	For error.
  */
-static int device_matched(struct btrfs_device *device, const char *path)
+static int device_matched(struct btrfs_device *device, dev_t dev_new)
 {
 	char *device_name;
 	dev_t dev_old;
-	dev_t dev_new;
 	int ret;
 
 	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
@@ -564,10 +563,6 @@ static int device_matched(struct btrfs_device *device, const char *path)
 	if (ret)
 		return ret;
 
-	ret = lookup_bdev(path, &dev_new);
-	if (ret)
-		return ret;
-
 	if (dev_old == dev_new)
 		return 1;
 
@@ -577,16 +572,16 @@ static int device_matched(struct btrfs_device *device, const char *path)
 /*
  *  Search and remove all stale (devices which are not mounted) devices.
  *  When both inputs are NULL, it will search and release all stale devices.
- *  path:	Optional. When provided will it release all unmounted devices
- *		matching this path only.
+ *  devt:	Optional. When provided will it release all unmounted devices
+ *		matching this devt only.
  *  skip_dev:	Optional. Will skip this device when searching for the stale
  *		devices.
- *  Return:	0 for success or if @path is NULL.
- * 		-EBUSY if @path is a mounted device.
- * 		-ENOENT if @path does not match any device in the list.
+ *  Return:	0 for success or if @devt is 0.
+ *		-EBUSY if @devt is a mounted device.
+ *		-ENOENT if @devt does not match any device in the list.
  */
-static int btrfs_free_stale_devices(const char *path,
-				     struct btrfs_device *skip_device)
+static int btrfs_free_stale_devices(dev_t devt,
+				    struct btrfs_device *skip_device)
 {
 	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
 	struct btrfs_device *device, *tmp_device;
@@ -594,7 +589,7 @@ static int btrfs_free_stale_devices(const char *path,
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (path)
+	if (devt)
 		ret = -ENOENT;
 
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
@@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char *path,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (path && !device->name)
+			if (devt && !device->name)
 				continue;
 			/* Errors are considered as match failed */
-			if (path && device_matched(device, path) != 1)
+			if (devt && device_matched(device, devt) != 1)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-				if (path && ret != 0)
+				if (devt && ret != 0)
 					ret = -EBUSY;
 				break;
 			}
@@ -1370,12 +1365,12 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	return disk_super;
 }
 
-int btrfs_forget_devices(const char *path)
+int btrfs_forget_devices(dev_t devt)
 {
 	int ret;
 
 	mutex_lock(&uuid_mutex);
-	ret = btrfs_free_stale_devices(strlen(path) ? path : NULL, NULL);
+	ret = btrfs_free_stale_devices(devt, NULL);
 	mutex_unlock(&uuid_mutex);
 
 	return ret;
@@ -1424,9 +1419,15 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	}
 
 	device = device_list_add(path, disk_super, &new_device_added);
-	if (!IS_ERR(device)) {
-		if (new_device_added)
-			btrfs_free_stale_devices(path, device);
+	if (!IS_ERR(device) && new_device_added) {
+		dev_t devt;
+
+		/*
+		 * It is ok to ignore if we fail to free the stale device (if
+		 * any). As there is nothing much that can be done about it.
+		 */
+		if (lookup_bdev(path, &devt) == 0)
+			btrfs_free_stale_devices(devt, device);
 	}
 
 	btrfs_release_disk_super(disk_super);
@@ -2657,6 +2658,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
+	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2848,10 +2850,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 * Now that we have written a new super block to this device, check all
 	 * other fs_devices list if device_path alienates any other scanned
 	 * device.
+	 * Skip forget_deivces if lookup_bdev() fails as there is nothing much
+	 * that can do about it.
 	 * We can ignore the return value as it typically returns -EINVAL and
 	 * only succeeds if the device was an alien.
 	 */
-	btrfs_forget_devices(device_path);
+	if (lookup_bdev(device_path, &devt) == 0)
+		btrfs_forget_devices(devt);
 
 	/* Update ctime/mtime for blkid or udev */
 	update_dev_time(device_path);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 98bbb293a3f9..76215de8ce34 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -529,7 +529,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
-int btrfs_forget_devices(const char *path);
+int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
 void btrfs_assign_next_active_device(struct btrfs_device *device,
-- 
2.33.1

