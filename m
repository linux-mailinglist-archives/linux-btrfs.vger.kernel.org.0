Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34334877EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 14:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiAGNEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 08:04:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32628 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347391AbiAGNEw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 08:04:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2079ZEOv011025;
        Fri, 7 Jan 2022 13:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZWgUvmXJWnjblKaoxMbFSGi2lBHCqOy6UF4TxiYd60E=;
 b=K/1OAXT+KxXTfbPvJdFpIpcg3JECOohfbym+z/ppxKqPDrnnFV0JJYOxSkbOXPgDNwYd
 tOlGpSYcZOiDQ1WQo26oOecUHoMefjxoDphbBgiDHQZyTIE6zNeh2YDho/ii0UKpVi25
 fr+R16u0PQHeDrXlYGoKduTvIz0/g1tp2R5iMEBVs/1vEDDpV5fME4cgOuOXNjvHhfBs
 N4efmFBo6Sz6I69kWbarU+gV9CbAfnS+p0Vq/STgHiKog79DSFxA6cWgGzXcJpd/FutP
 3Rrts+ztTw6q0yghV1JB98HrwzrzLRsUiYYVOaDNp0ZVc5wq77BCHl38/Plx9LC0CZrH yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vba193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207D1OgE027845;
        Fri, 7 Jan 2022 13:04:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3de4vnnsd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh23ciGcXK+xCpai74kqY5EnGfgfOrQ3jEvcJEbCtrzHU6NeJGWnCy2/RmwFOR6xsLRiIMx9lJD1meyT5fVfDfbTWegPjiGg9elsfUSoiV01nChyyixHlgbHjnIwf51HJdOcX7h4o7P7r+YWd5CoXpVzUT0BH55K5ycky3bBwamQ1+55oi6PnxmkPjUn2JcSh7UhSRhbZDFVuROKpSC0WLpGc0mSGoqICiTkbPPT9HUAq5sm1fuv+XgUyF5VVMvAZDGPYQ3J4PiDKSEoKPAOiEUoAx1HhbLToqNv/XjKTJcQdpyVWuCvtJNDRyL4Bh3w74fB0b1ZJqAvHTY47JiRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWgUvmXJWnjblKaoxMbFSGi2lBHCqOy6UF4TxiYd60E=;
 b=D/EoV+JYsQFwEVJc3YD4WWCiBdZT4dt2LEb71/7I9Ryc+vNHBUqaxjr9PMrpeCP1SVoe52MHcJ6gu+MnHPpF6LDbtq6bkI7JcTFWmKPK4zMeXp0o3h5qx09eLTPNmCKWSx0TSMXvNQi5pUXPY+EglyqLhsADCChlBfJQ0obO9u3BYYRYKlS+y2oCYY37y+yXdfhdUFwC9cSPAEhBHi08qNLnWJA1SEayC9jx48mZwcNZJKY4Xuc1c24YZ4gKD+/HUsVgzC94mCgZBUVseEC6jo22QpvLXQZsWXy+6TZjs/9LEuivAsEpfvhAN/ccuQE0D6piL9UJNDax1s/LMzWUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWgUvmXJWnjblKaoxMbFSGi2lBHCqOy6UF4TxiYd60E=;
 b=gI740ExhkrBxQKnP5ddU3/RNW4xuBCYH03SvSnGvSXVhSa8Me9INyFdbZvEiLktrYl7gdU8HnGmgv3inFkAZdU4LeHZ4XVrT2xUzrFZVBP3gj47ka5VYrZTY0iqoZ1MrpWxPb8Nss/BPDuw4yI7DtMUp3ZACPT/V+3nrWvhnbd8=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2995.namprd10.prod.outlook.com (2603:10b6:208:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:04:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 13:04:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v3 2/4] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
Date:   Fri,  7 Jan 2022 21:04:14 +0800
Message-Id: <513f904de2c8c7a5268424cc6a525cfbeea0e39e.1641535030.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641535030.git.anand.jain@oracle.com>
References: <cover.1641535030.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fd18a6-6bf4-49f9-7956-08d9d1de441d
X-MS-TrafficTypeDiagnostic: BL0PR10MB2995:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2995949AB83EF9CE561BAA97E54D9@BL0PR10MB2995.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4y4ddgE0Mm+Hvs8hv5R5VqiJZeKBMCFeAg9SsIuHCvYAQKK53QUc9BMuVV3l3Ks7XHr0VKnLLgWdfliXpMny4OkCCkA8+hHfUg5qTbUpq2UP/pQRqFX1CugcyVYjgDqiCg2R6Q3RwXZR+Yc7T3SnE829fqooIkEiUi303/ZTRwZZ56nnAbtuB9UnpWcWQAI8eaaMlwn/0ihcHahvHZe7NjgCV/0EGqpksBeGH3qo3XlpTmlBZ39f2HaKN0ELr38Xn0NgRO+mVgwNrVYBHz/1xg0is6oaYMHfqmj9x8gAQZqeSw8URZc9DrYYeYP7Kt23IB3oztTTv9hblWw2XNHt9UWm0eCQXG5WidKT7zoKl2vbigcGAmMSNkJIlfuHJfuoVP+fFT59wJU8iSJUBZ+RqSfQBxshs7Czg1XwzOmzP7j9x9Ied9peHG8ZeWrSXWBh5KzSjpePtnFeOlgfiAC5U7l9LgF2yGFo80oPuv1jGObY8QcAufcRUMMNBSS4bEBW3GAZiDojdFMPAZypCCxvSL1NqD8aP36ULONE07MM8Vm3ztSQKh1x6AlgDpooIN7fPBFvemLYx3YWR7wS8GSNDmbZ78ejPBWAasytdIsdN4sM2OWtK0OhsjBwKoF3AUcH6+1Cn5nnfNugAL6xpyXiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6666004)(186003)(83380400001)(316002)(38100700002)(6916009)(26005)(8676002)(44832011)(66476007)(508600001)(2906002)(86362001)(6512007)(4326008)(8936002)(66946007)(2616005)(36756003)(6486002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiHkBZyywb5yPLtDJHqP5NXoYKSkJdcnzLnVJZSnNqjJdGvmXrTW5RleyK8X?=
 =?us-ascii?Q?f8NLesssgFlhD5zSSzCq2PagYvHNzXyECfAfWGfTPI6QqHxVWql8MFeIWWtN?=
 =?us-ascii?Q?pnwe2Y1ms4PdFly+BQMZWxY8XjzDYgnjemno+skorXx8+8GW2cAgJ8zyLFVT?=
 =?us-ascii?Q?KsFDVj2in3T07EGErL34UBVFZwnmIrFUwJZdEYi4mZA3ahk7Aelm5Gw1WRol?=
 =?us-ascii?Q?bKOfRjxRcQrMvTs0sqMAhFFK5ms9vyvpNgMABujM5tmH2jVFwzP6KustQfXp?=
 =?us-ascii?Q?oHD/MGoboo8i8MohaBIz/xRvRlmI8qTttndbWUYACe0e5LjqDe8CDKZQyVvm?=
 =?us-ascii?Q?YDPDka6WPy06Ab9AwrfFty5AxK748N2ObmCyAa5o4USsUXFGHL0K5fXW0SWt?=
 =?us-ascii?Q?p+m1fXx74vx//wMWE1182vTkuoRKeErq/JoVAPdbP8Qz4DswKgqX3cqFdY4U?=
 =?us-ascii?Q?EnMLJdt83OunybYYjkriIqy2AB3+vQ5YNKn0RS4pjs8ZxZZ4qnOixpln6xU2?=
 =?us-ascii?Q?KGrQXhDzWYFSPa9cx+800y9JdNdDKEw8Tyanh6nsIA09fjkH3Kv7aQzpZpcm?=
 =?us-ascii?Q?rCx2cPXZk4hJu2hnN/Oo7VJf3Eekwo41UgMZATd5/wPbT7PeWXonCKLcwjrV?=
 =?us-ascii?Q?4NICX4ImQNtE98dNVyCK+dwRN/03vwtcUzQoh1Lh4aMhtu8xe0Eo3VWb6Cjs?=
 =?us-ascii?Q?HWNN/8ZRvvoE4dSsZG83kaiHWvc/+KIk2CFZiqxRQyMtu4fvqNmCONb46PCV?=
 =?us-ascii?Q?GNbbQSDTFfXtTzEdpjNcLEC5JFG/FNjNcrd6LLe/H7DUfBAdyUdNy3PQI8ub?=
 =?us-ascii?Q?HbR4lEq97sQxAqNbmA7sWevDlWOAC6cM+MfUHd252Tx2aIB7IXp1Zf1qPx7M?=
 =?us-ascii?Q?Bad1JHl7bPEDX1Tzic60I3Ewk/pzq7WS19YYt8ExvvoIRSYpe5ukIoPTaiIU?=
 =?us-ascii?Q?t8jxP5mnrdVk6dwpuT+90E9Lg12QsUjM82eZ/ixv8x9+bLjclf4ksMWo881t?=
 =?us-ascii?Q?N/MQ/b543hAQLOrcE78QGqsYqK67/+urQbv6xnAN1ZUCeX2OcyC5d/dICRUB?=
 =?us-ascii?Q?FPXD+C07GYiPqPPPtgadBdXHmQQMmim19Q7UUfzmSqu6GSTOpmI/wMw/5bm1?=
 =?us-ascii?Q?MdDh52vj0487051zZfVskOc8AQ1c2T/47OXIV0+R9FQvX3luh/ctiap50XvU?=
 =?us-ascii?Q?zZIE6dDkzo/IUtD4OcRHMbYyoQBhf52v27+VYQJr8bojdTM+8m3Q+H/5IZsi?=
 =?us-ascii?Q?/o98yMJ64k6ICz5rh4epxfaDlx/rXlqx7qPka7Cp2Yrt0/iMoV2UG+9qE2i3?=
 =?us-ascii?Q?nBdfE2NuFRHQvK+vwivg32uFaHvIoAVZyo1xAF/Mr14JtEv+d6UNL1XqBk0L?=
 =?us-ascii?Q?7+r1rRzDSo1sFGvta0L0sxF4lr6Fkhp9dkMbPHil6lVWISvZ/H0H/aDecOp/?=
 =?us-ascii?Q?puxefNzGzn3nSvLTvAB5UQRjt1ERohhokr26eOJz4YqHVmjW0dfxK+Ct2Huu?=
 =?us-ascii?Q?w+FFsEfwyob3bQHobqeYxdQXfMI/Cj2h9AeYatKNVS1S/zHbzAiUQIMXCs/R?=
 =?us-ascii?Q?yqwPoMU7/o569aiDSjYFG9yRSTSINEbQBM+ANTJaRcdlu/yIihFlhyJStpG6?=
 =?us-ascii?Q?n7wBlAReCXM3zNHJyEFKtJQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd18a6-6bf4-49f9-7956-08d9d1de441d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:04:40.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCYmobWCLDxl8xTIJdJGzdmVEZ94+/+j6VHURFyqK1HVdmnnA0nJgSIGZ8pSJukuvuUMLKDcBTQZMNBtl9GdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2995
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070089
X-Proofpoint-ORIG-GUID: Xa7tcDT5v4dEI5MvEKOypoXRRVgKpDZQ
X-Proofpoint-GUID: Xa7tcDT5v4dEI5MvEKOypoXRRVgKpDZQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit cb57afa39796 ("btrfs: harden identification of the stale
device"), we don't have to match the device path anymore. Instead, we
match the dev_t. So pass in the dev_t instead of the device-path, in the call
chain btrfs_forget_devices()->btrfs_free_stale_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: -

 fs/btrfs/super.c   |  8 +++++++-
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++++----------------------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1ff03fb6c64a..bdf54b2673fe 100644
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
+		if (strlen(vol->name)) {
+			ret = lookup_bdev(vol->name, &devt);
+			if (ret)
+				break;
+		}
+		ret = btrfs_forget_devices(devt);
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ad9e08c3199c..cb43ee5925ad 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -543,11 +543,10 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
  *	1	If it is not the same device.
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
@@ -567,10 +566,6 @@ static int device_matched(struct btrfs_device *device, const char *path)
 	if (ret)
 		return ret;
 
-	ret = lookup_bdev(path, &dev_new);
-	if (ret)
-		return ret;
-
 	if (dev_old == dev_new)
 		return 0;
 
@@ -580,16 +575,16 @@ static int device_matched(struct btrfs_device *device, const char *path)
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
@@ -597,7 +592,7 @@ static int btrfs_free_stale_devices(const char *path,
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (path)
+	if (devt)
 		ret = -ENOENT;
 
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
@@ -607,13 +602,13 @@ static int btrfs_free_stale_devices(const char *path,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (path && !device->name)
+			if (devt && !device->name)
 				continue;
-			if (path && device_matched(device, path) != 0)
+			if (devt && device_matched(device, devt) != 0)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-				if (path && ret != 0)
+				if (devt && ret != 0)
 					ret = -EBUSY;
 				break;
 			}
@@ -1372,12 +1367,12 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
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
@@ -1427,8 +1422,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device)) {
-		if (new_device_added)
-			btrfs_free_stale_devices(path, device);
+		if (new_device_added) {
+			dev_t devt;
+
+			if (!lookup_bdev(path, &devt))
+				btrfs_free_stale_devices(devt, device);
+		}
 	}
 
 	btrfs_release_disk_super(disk_super);
@@ -2659,6 +2658,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
+	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2853,7 +2853,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 * We can ignore the return value as it typically returns -EINVAL and
 	 * only succeeds if the device was an alien.
 	 */
-	btrfs_forget_devices(device_path);
+	if (!lookup_bdev(device_path, &devt))
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

