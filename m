Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48648BE07
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 06:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiALFGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 00:06:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47722 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbiALFGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 00:06:41 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C4v8aE030477;
        Wed, 12 Jan 2022 05:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nnCqZvtXcwud1CviT1IG+Hymt71Zf82cfW4zfT3AS6U=;
 b=UFLw3Nf3e8GhgikIyWpJAmRt4ufqxFu/O//7DNbey8TDvZI+7J5DuOjzBbAUcYxtXR8S
 upYcZioxR2pWo/oCr4TGZCnxHY/HakHeeyeDYVPUEQAL7C7BUcM8saFb6R/wbRQXzrpF
 XY4UFMZnjx0HNL52RAcYFWR/ElexqWhWJByvUhj/wxgrQSZaJTRuCiH38lRAkmvYFPXQ
 A4X10AKWec/Jr1Z4LVDut1ALwFtuFZIB9Xi8k4x9ixPsMn7h3vVxggza6vgqdd8K+CJu
 sNsETUFh3iM7/d47SciuiEPJtKgz101TBxEYK0zZv4WxCwN5HYLWPG/Q8rML9xKzBFwP Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbwcvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C55e6Z158362;
        Wed, 12 Jan 2022 05:06:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3020.oracle.com with ESMTP id 3df42nwr39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM66OX0DS9GBF+ErhTsI/bMN9gzcNRukPkqR36sETTEQG+l74yLIYCv1yfPsDfgiwFqUSUvPHK8o4NWoXneCeMysTU4iRHSykq5LzkbIfn/tbXPWYL9kp4SO4m2/pf0xgY16/TtryvPXrRGf+ILWFrw5ElPJdpzgdq7A9nGVBKnBK+DRhoSnOuRll7beBUFbvFz/OPYOT9JshP+yVjMr1mQHvRAxN2F/5LN/ojO6S4thq0wlhBigoSLQ1JVdEKwJjPmiGkeEi+4vg0FERdB5/hnbOAuEYnLSdBKAQ7j+zY4fRdWlookaPkdDQpThE+hBSOKVwCwmzFZcCGUh6lC2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnCqZvtXcwud1CviT1IG+Hymt71Zf82cfW4zfT3AS6U=;
 b=IH1/t1dthR8MWMmu2zS4PYs7Vt1x4t1rDcjSZZMs3RuQT3stNx4zhEL7TyupngqsK+Xny5RPAUUJgwBlwmTnAUX1H2+tKAyrv9vkDRwntV/oXssHbvECK3zNrK15ABX4fsL9cHmPHe3HjddB1OQjfb3UDsDK8iX49KRpvKSI3YsKc1PxA8j2pRrZBwQi1zpZ6sNZXmtTsvFTiZaQtnLwBQSHzJFDyoXn/8NolFIGvj0UozlIUpxC9Kl6WiDWkyECzxW+qDya1yM/2C/wLROOPhBEN2KAMif5LIgiNyhPRer/+DByvdVmgoshEQb3lz5mUNAksTgvxmU8Hs+TMwFhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnCqZvtXcwud1CviT1IG+Hymt71Zf82cfW4zfT3AS6U=;
 b=RHyNakehjcnb59NUlKKyHgl1JRUb1nzFzP+4Qcf5MDpec9kvzONC6E3pGu0QO/ZZyHhqcgscElTL3opZpGiMp+3rpAR3YDZo+FJW/0nigWr8QfN8NfN8NKFs7F5J9GdB7/8yxF1BaP2RTxo+pKumDpojudcjp1ev3EksZ/IJ5Tw=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3904.namprd10.prod.outlook.com (2603:10b6:208:1bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:06:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 05:06:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su, kreijack@libero.it
Subject: [PATCH v5 2/4] btrfs: redeclare btrfs_free_stale_devices arg1 to dev_t
Date:   Wed, 12 Jan 2022 13:06:00 +0800
Message-Id: <f37806b1cb4e497af88ff694a56be03bfb3fccba.1641963296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
References: <cover.1641963296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e71897-a38e-4c61-ce8b-08d9d5894ae7
X-MS-TrafficTypeDiagnostic: MN2PR10MB3904:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3904C3B181EE305B73D48D1BE5529@MN2PR10MB3904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Vx7dHnXyG5T11y4igNbxGZWCXdEBTi2EByI5Lg5PGGgmXH5Q7l+dsRME1DDHt4hmocs5o8RzenJQzM9HnOjlaRv5lvpm5Lw41Sy72vKnyKhjQLlP0BtVYRQY+URKbk+GtMSoZjibR2ppFULzLIciEC1fgVAqafQbupJElh41s2jqY1qCFtl4/z9TyuPD3pfnekeaWJ0hwhg7+5MSb4FWZA5/V3+buO3G/u5vel2J/HMYs7HOCyL1nHbEfB2gVd6eXIJ95qkR2Jdwr6gHe7/+kDf03HwckAeZitS1o87x7Xclb4DMQDyPkLN7Z5JBeYQY/S5jdrjdnZBs16Jmv4jsSadyxTaCTop1RgqoukovZf7Dt0kFAiF7gEMeedukcz9vfg7iiFExjzv0icMSVohPY1yKCzDnoL0V214gjX2V+aXDiiBa/+qegRKTpiSxQLp3TBREuNUS1vDhh539tMptYQB7YVwzaYUisyUCc+AzqyYsa91fLzeE0U1TojYQ57Ukg5vu+ReqmzC1fgVxgyZg98F4XOUwtAZ4ApFtLiyg+cLaYX6kTakSurUe3d58N/jMczxSKCLIGMuhbu1xqiuedVSGOzA4CZSQraazKuCwFEnzzlttx0ReJ6bUPu8o+Zw0yZZ2TNtkhhjLRg5s0rd4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(44832011)(86362001)(83380400001)(36756003)(6506007)(5660300002)(508600001)(4326008)(6916009)(8676002)(316002)(6666004)(2616005)(6486002)(66556008)(66476007)(186003)(6512007)(8936002)(2906002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSQqoyoinG/d7fitLY9alwTwtzEgeW5Jhumht2Gdctep4M+ju4qe0VUFwQNk?=
 =?us-ascii?Q?CrvGvPgG8s9Hmfue/uYkwzLG8Vnlr556WCJHXjwvDfHuCjTOiiemPyqCKVlp?=
 =?us-ascii?Q?9V72zN5tBlWSD/KykunHFWbD82jNtZsA8Shkd4gPz591gZW3VNVlJs0Awx+9?=
 =?us-ascii?Q?xDS3xRHrpKkqt1y+7n1vmk14G4sYp85n4v4rx6gtgciT+9p+TXB1Dbod5+U9?=
 =?us-ascii?Q?YhlryUjzdJh+xvQnWe7TkRZ6/I56DYpEz32EGOag6afHldUYlJ3RY4XrlY/V?=
 =?us-ascii?Q?Bvbr1b8a8L37t6RDJqHYBD7DbtwyDNS8OlC2s2ZrIHNAshXFOH9jlisd/qvZ?=
 =?us-ascii?Q?9e8NwvS2zXFOjsVoyz37PmEK9u7jUOQ1HuoFREz4gqHrwm/fIi8EXGL37boT?=
 =?us-ascii?Q?R+PinxZiMre0D1OkNIYmOM/gw8F9rSRwYSXOYsGtOLQ0efksL2r3KnKa0GCM?=
 =?us-ascii?Q?Qx4GmvxDB7VjroBNGP55xVLfnFnqPLepHG7CH8tyVXKyHUBuoUDcIZevG0V/?=
 =?us-ascii?Q?ScUVUyx/qlKQguQ5Ai6onKyWPSxD6YZAx4f938sq3Xs8mPQOP2PhIDwkwXdm?=
 =?us-ascii?Q?jqhRDwBx/7hjvEyvDDxuvWxChn1J9hCs5qezRZbNSmStjv9kDozv7Nh37+hE?=
 =?us-ascii?Q?4LLbJhZ7eydvbq0PY7StBkYgZX2hUzbczgrZb33Mt9NbBk2zBRqSTiH5uOGb?=
 =?us-ascii?Q?wTJCzYrDgvM4wVh5l4taXYdrQU+/NYwLOI1E/5KGtq6lfG5KyePJ4ksjTkvr?=
 =?us-ascii?Q?6/g/0ktfk31/Bc2zt3akDIVzWsO/Mpvj621gnan1vuZRmrKstg2eD+b+v97U?=
 =?us-ascii?Q?s0JOYzmG8wYEVOqJJmkdwK4eAV5Gz3w3BuA/IifeR+COI8QpSOPtcOZWmatD?=
 =?us-ascii?Q?VtmYAQ1FVRRcnkdsMIKwwM80ZcXKfndcj67zM0kaxOTYL67DMO2hNMsBFogp?=
 =?us-ascii?Q?Pvvmrck9wyHIkWY+WQCHF4kERJWgXz73hElG65j/6SiNi6ow0aqz6ITKdowH?=
 =?us-ascii?Q?Y4VTN8tJ3KQgvsQ0qptIODgXDVSWr9/DwxZktJFfzYglsHT+MZMbxgNbNR+O?=
 =?us-ascii?Q?4GZnDGRfeTMaupVY4Ph08BIasWdoMKXq4EsbEl+BfzQhuvJvKMhc54e/YzW9?=
 =?us-ascii?Q?dQiHUqEm9e6hFYygppJtnBB2ai8ZivKxewQfNKlCAudSfCxWOzYHyHfadIhm?=
 =?us-ascii?Q?N5fg4x0sY10h3+89966HA8L5xvTJ37OqFWp9KNgsrm7Gq1A9wUTmAhJWco9r?=
 =?us-ascii?Q?yC25+izMRelNZ1sKeImyDM5uyFCCrX2jOvDYHtJRLEW44njOV9eRwipQ0tOZ?=
 =?us-ascii?Q?1uX9ntpkx2DMP8IwOcHn3Hs+6ZQWapadJM+y6rmzTQNo6qYO0/1NuboVsidy?=
 =?us-ascii?Q?d2mBFUZDQhcCchROkhFz/KQl7ccSI5DJVb5ymuvbFkFlPsnaIutqciAM0NL7?=
 =?us-ascii?Q?ye3Yep/k+LupkKDCr+o6l+J/+lJ2OuU4OyxLyb4bm5GlDUHmgnCGVdagkePU?=
 =?us-ascii?Q?nf44GsIeIpcOGlecnlmNbYm4aeMn27BtyoS30zMOU3p36DVz1G47pc7zZzuL?=
 =?us-ascii?Q?1c7UvzQijnRk36ZJ/R6PU6NOFKeu4/hSbIEU/VoHWlJIZ4VIxy+d3vLoYN0/?=
 =?us-ascii?Q?hwomv7zq6PUaVMkjzSssIQc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e71897-a38e-4c61-ce8b-08d9d5894ae7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:06:29.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlZP6kouiGIvjIpKERRimRy1Y0ghyUCXXPEWpozAfjxtQ1BzyhI5ruxfump9zzSkZKhyoLimThaL/i2CKjHR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120029
X-Proofpoint-GUID: RU5x5wNuxnhSVeBf-qWNskcRMx7hzVIA
X-Proofpoint-ORIG-GUID: RU5x5wNuxnhSVeBf-qWNskcRMx7hzVIA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit (btrfs: harden identification of the stale device), we
don't have to match the device path anymore. Instead, we match the dev_t.
So pass in the dev_t instead of the device-path, in the call chain
btrfs_forget_devices()->btrfs_free_stale_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5: Fix commit title; add a comment
v4: Change log updated drop commit id
    Use name[0] instead of strlen()
    Change logic from !lookup_bdev() to lookup_bdev == 0
v3: -
 fs/btrfs/super.c   |  8 +++++++-
 fs/btrfs/volumes.c | 49 +++++++++++++++++++++++++---------------------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 35 insertions(+), 24 deletions(-)

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
index 775d0cba2b9b..8cd273a9b325 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -542,11 +542,10 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
  *   true  If it is the same device.
  *   false If it is not the same device or on error.
  */
-static bool device_matched(struct btrfs_device *device, const char *path)
+static bool device_matched(struct btrfs_device *device, dev_t dev_new)
 {
 	char *device_name;
 	dev_t dev_old;
-	dev_t dev_new;
 	int ret;
 
 	/*
@@ -570,10 +569,6 @@ static bool device_matched(struct btrfs_device *device, const char *path)
 	if (ret)
 		return false;
 
-	ret = lookup_bdev(path, &dev_new);
-	if (ret)
-		return false;
-
 	if (dev_old == dev_new)
 		return true;
 
@@ -583,16 +578,16 @@ static bool device_matched(struct btrfs_device *device, const char *path)
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
@@ -600,7 +595,7 @@ static int btrfs_free_stale_devices(const char *path,
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (path)
+	if (devt)
 		ret = -ENOENT;
 
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
@@ -610,11 +605,11 @@ static int btrfs_free_stale_devices(const char *path,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (path && device_matched(device, path) == false)
+			if (devt && device_matched(device, devt) == false)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-				if (path && ret != 0)
+				if (devt && ret != 0)
 					ret = -EBUSY;
 				break;
 			}
@@ -1373,12 +1368,12 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
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
@@ -1427,9 +1422,15 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
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
@@ -2660,6 +2661,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
+	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2851,10 +2853,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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

