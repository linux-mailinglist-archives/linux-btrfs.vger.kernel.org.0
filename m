Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0747084C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhLJSTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 13:19:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236861AbhLJSTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:19:34 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGHT4h005395;
        Fri, 10 Dec 2021 18:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ot5V6yIRb0N8D5om+P3BlirnB/bWciqWtVmmSCehyVk=;
 b=RvfIzNkXBCicCIwNVjOP8UYCYpshPvJUmry7a+HVktAVbeeJyMRR3LG4ft04wdQaCgHN
 62P3EJBv+N/weS5KH1tRYUqx81lrsg2/kDt55KhcGcU2uR9OAkmuiO5S8eE5wChpFDp3
 BwPQk/bAmy6E4gVVNHok28z1Ik5YSGz1cFJXI7Foycd93u969nX+EWSmOXTAVWduYVj1
 ndMdgtMBqhIXPAid4ZLIZQoo4U0KREcfR9GJAo9ZZcnWJBzowWTa2EyMFl8zcQwGvRdO
 eAmZsAfDH0gPii1Tjv1zXyj8qNczXmSVdvnCjnM7BvR1vvwFA8zJsSYGGWnmdgK54S7n FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9ng97p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAI6GkJ148135;
        Fri, 10 Dec 2021 18:15:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3cr059mdyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1021Yf1QqR3l26401TYhYzxAJkKLdn21ey+gInALEzpl9JlkjjoOT9Q8hQY14ErsjiR5QVpkVcKQmWAfeu0ViCidPaFE0WXF8h1YWRQyufZ5py0idMmb20Bx81Engw1Z7oWhU4RMFp6SkVrL+lsFbfGkfeBOj73ENF87V7GoFzE6h2V2Nz7its/0ooJOZjAjf5GtyyO9tZJiGfFPY//o32yxh2Hi8f80wWZldEVxpF8dFhL6lhbxJ+TXYM9Rf3FrOnRa4qaSNwcPMQlaTnJdYxR45tNpAn6f13VVhvikFgLBJXwH38LHy7ua7nPgBTU+NJI09kJOMp/TTnPsp1GyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot5V6yIRb0N8D5om+P3BlirnB/bWciqWtVmmSCehyVk=;
 b=iLvHhIQokGJDztgsHb3RtTdKI35J5Uh7BIHxULML+TXMfBsrJpuGOHM7d45VV7RKHCfdRdEuurdtyslyX++MsbuAZoGSAzhmJeBkv+aMqjDBYFfchKS29tz6f6C7QIRADzPF7FiOt1QkXGH4r5EbkQDTFnnrJbQPYk0NlVvoswJLFBNwO6NJhsVW4YA4rqY/d99fkE+Q62kDwCIH9injreIVc/Vwn6iLzlr1jkOe/xsjLQrKap8k/EH2G+gAgc8MPYtlxi5DI/zupzfKX5SEKfV0+3NpjibjoizdImkIuT2WPNeCsyWHf6kUKPK78aetJvOD9VJM2E5fYMCg6f1VxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5V6yIRb0N8D5om+P3BlirnB/bWciqWtVmmSCehyVk=;
 b=DKMQO2QVg/+RUmQDNTvmxTDThqcCIXqZNsXVwK09vdE4Euh88woWqPjZPnAS00S67Pidk8mzbf8QzF/ZikNba8uuUdlG2tZoGTLJFKl7tQdMBq3xYfJJcH66OSwwvSqPapdXbrE95Bfpxy8StXkfiNlOUdiIZPFYSxmelywtJjE=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 10 Dec
 2021 18:15:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:15:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 2/2] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
Date:   Sat, 11 Dec 2021 02:15:30 +0800
Message-Id: <859725555b836e4aba6338fe78a0a3c175787ac2.1639155519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639155519.git.anand.jain@oracle.com>
References: <cover.1639155519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SG2PR01CA0134.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 18:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b73268-25ab-4d11-4def-08d9bc091bc6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4368:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4368E73B78C789A7424DCDFEE5719@MN2PR10MB4368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeJ4zXgnn/lfClm+ZaPwYjg5RrslFvNhkSHM6JkbbmYkjhmHVWzK60xqRJsW7sYF+eucFATizq1a7X8v41sC9drhHGr3Yhhr1D1S1kegwW+ElgTBMmXjP+nkhOZYzPZ8mtSCE4+cbIKP+wdaDFQkcxIKGum97pTtK2Z7y+luw3vdTgaWfx5yynj8Ho3zYrOwR3o4J2U+SZAEK7wyoz/QPgz/88RLTBuC0lxUgQHaQnIcQmgcqSZhUiBIDDyU2el/CnlilmThMld0tCf6YxxZBsCo4T68+cw2pL9vIVMezh9456D61NIz22UBvZD0Ww3Syz0PPMhPho3B/cbA0z9hK15kmNkmSJefiZBx15VodRXouitqvwtfz/lGHRTjaxUYrPSm+BWvh0ud0aTbhYo0iyqgOO53ndrlWQd7HEPSbkR3gxPjdH7qEuWF1Q9lPVZsEzBFKDd6C0aOR4fne4J4er+eu8Fnw+7N+0PZmUdOfVRFvwPKLIhYm19JqY8BES+75Ds6QpkRAUBAMTu6KnL7BB+CFIG6D7ouVw7mZUhCdi3ua2qI/D+iR8tX+hdT7Wpbr7TBYMf2EawqqOhgHx5ZPfG10CtW3V9WHICk9/fLXg23MA2eHYoP4AWvfs+W+1ACLwGL8TD/zGkfXKUy3iOQLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(38100700002)(66476007)(6496006)(6916009)(66946007)(4326008)(66556008)(83380400001)(6666004)(508600001)(8676002)(26005)(44832011)(2906002)(956004)(36756003)(186003)(316002)(8936002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q0GbB5qgckFhzgW3x04SkYx+o9mNqS/n3eIdqNdqgwC+1sjrv7bIlt3FYoXF?=
 =?us-ascii?Q?Ih2wiN73Bf6lYXUJrft1ROcxp2etoWFpt0L7tXRjqrp1VDZANu/SEhGppPeW?=
 =?us-ascii?Q?dpRJ2onUGv5DEsNZtdpgcZRUqWJ1Emh/KZo5SHgvMO+/OwkIWPsSIlZcF/IE?=
 =?us-ascii?Q?pv9tSx48JaHSyW+/WG60WGaePZnj72nhgu8bzioJO4aaDyzQPhOrzihJVVUi?=
 =?us-ascii?Q?hX7Tg8r5H90o3DnqN4XR2SFKwWXWWAe49m/J0+eSOcNL0JQCJOQfHgTkOnhm?=
 =?us-ascii?Q?Qj6yne7gJR8WwOrgP1qH1Wx85U84SwfkUn3wmm0CzkNv/OfnKp0Ir/KPQWDL?=
 =?us-ascii?Q?jGJAZiN68R/SvsPtpEZepAh8WmfWuofx0SQ/suGmxbXN1gELL/rV6L5Sb3uY?=
 =?us-ascii?Q?E0uU3lPuRvITu3CTZw6BcMbaDRgreF3cl0yPoTKr0qrkK/ACo7AtyXwudjes?=
 =?us-ascii?Q?jUxVfoQfhXRtMnnZ3LtrPMJHqakfL7iGOHzgyChuqoWlOYYJ1sn43kg+qabD?=
 =?us-ascii?Q?xQt0TMBhm1u8XsI6l9+UtN5ZeiP6Q4NpliPT79B+96Fsyia1hchRQbpSUeaP?=
 =?us-ascii?Q?WFUtLSVqmeUsjrh+SWnXBk5sA9tp/mpQpagtqwuJZhYcKLo97BgCcT2yXGkf?=
 =?us-ascii?Q?A48U3ufIuO+VXQTzXM4TScm5HTnRRKtP4D/sM2qgMs2RMOaGZUJEzgtGlS8d?=
 =?us-ascii?Q?EyZ8QMbdgABE6QHiTz67ifmD0VM0UtAoVIJdfBdg1NEBy63saprw79Xbagb1?=
 =?us-ascii?Q?KW6DzqnteJYXNg5MoZy73JWo1FFPA/7Zid3QCsri1ZQWEY5QX0BHNVgf7WZt?=
 =?us-ascii?Q?nNfbU8j5R7vXrowQ8JGmkMshzzA7fzX1hExBM7U7hox5LiBLG/nA3Vp2O/A7?=
 =?us-ascii?Q?RSNY0XD/2WMZ93HHLNEj+pig5GBKd7xjKwVx/abuh5XiXwWWlz6vl5mJgVUo?=
 =?us-ascii?Q?kpO1xtytO3KcJD/LqjbXthuLkETeKMRL8Qnr4kGpiDPQtMwSCoyQWwnJQLxZ?=
 =?us-ascii?Q?NqsRbJzDNm4AKcHvAOv4ly9hM2/BdWrACgZbIZrzS3/yOWsJazFjT7BdE2pg?=
 =?us-ascii?Q?VGw0cIxGNMH8+ipZo+TXYoVMhG5B3YY4H2147QPbcb8rcDj91jBbVRAh1i2e?=
 =?us-ascii?Q?yB7Nbt/hg5YmqasYTY2JvAJsBuA0dhjieBrZ+zqiOqgex+ufjfZ3URzsQEXy?=
 =?us-ascii?Q?SAujDvaVzhumBmU4Vwwb9G19c/gVNMbF+7+cBYKkiXFKAJJKCSLiY2SlB17k?=
 =?us-ascii?Q?whYzbDjN2spKM9EC6D67kLlbiw2qvXC718DnQcR6FrFCa/SDVYW8+3hXrYBy?=
 =?us-ascii?Q?kj0WQU8zcCTD3U1mQ1y+bPWQ3oCZZMK+T1WzoPf3qqQWkBA19xhxpRJvrZW6?=
 =?us-ascii?Q?kAW/YWVOmzcQijekS/tdKCCrBCe0PFqCp+x34DNdvy4qHzSw9TE0+CgF5D4w?=
 =?us-ascii?Q?DZLXQ2mW+iQUGLabjVDhi+zoF2Gi1Q10Hzbj+SQDplrkme6dDCAi8eYkpVXB?=
 =?us-ascii?Q?7+LxVOS56OhC3VtpPoVkGWwK4GHiQ3q6fWR549dizhEKL+E8lgX0kKxaxERa?=
 =?us-ascii?Q?cL1AdTwS20BLzjvg4OkVB1CSxg0XFirQxN4jmRh9cXpTIZ+R0iCZPhUCVVAH?=
 =?us-ascii?Q?gvTQWRFO1sd/XqHmgj8B+Gw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b73268-25ab-4d11-4def-08d9bc091bc6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:15:55.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A28gOZ4TtdYKN20pqZAcAt1kJsjwZuUZ8yk4f1yod8Njb1+5Zp8N0SzoGckqMyAX+CWADaPbyCZ/7qsh+nlhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100102
X-Proofpoint-GUID: sO3MdLn7nOJ8O3p5luCzqkrTrtW13cjT
X-Proofpoint-ORIG-GUID: sO3MdLn7nOJ8O3p5luCzqkrTrtW13cjT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit cb57afa39796 ("btrfs: harden identification of the stale
device"), we don't have to match the device path anymore. Instead, we
match the dev_t. So pass in the dev_t instead of the device-path, in the call
chain btrfs_forget_devices()->btrfs_free_stale_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c   |  8 +++++++-
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++++----------------------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..985395085886 100644
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
index 559fdb0c4a0e..fdf35dc561ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -542,11 +542,10 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
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
@@ -566,10 +565,6 @@ static int device_matched(struct btrfs_device *device, const char *path)
 	if (ret)
 		return ret;
 
-	ret = lookup_bdev(path, &dev_new);
-	if (ret)
-		return ret;
-
 	if (dev_old == dev_new)
 		return 0;
 
@@ -579,16 +574,16 @@ static int device_matched(struct btrfs_device *device, const char *path)
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
@@ -596,7 +591,7 @@ static int btrfs_free_stale_devices(const char *path,
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (path)
+	if (devt)
 		ret = -ENOENT;
 
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
@@ -606,13 +601,13 @@ static int btrfs_free_stale_devices(const char *path,
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
@@ -1361,12 +1356,12 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
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
@@ -1414,8 +1409,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 
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
@@ -2649,6 +2648,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	int ret = 0;
 	bool seeding_dev = false;
 	bool locked = false;
+	dev_t devt;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
@@ -2843,7 +2843,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 * We can ignore the return value as it typically returns -EINVAL and
 	 * only succeeds if the device was an alien.
 	 */
-	btrfs_forget_devices(device_path);
+	if (!lookup_bdev(device_path, &devt))
+		btrfs_forget_devices(devt);
 
 	/* Update ctime/mtime for blkid or udev */
 	update_dev_time(device_path);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9cf1d93a3d66..1b644ee60d22 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -512,7 +512,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
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

