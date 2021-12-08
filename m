Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104446D509
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 15:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhLHOJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 09:09:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56086 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234653AbhLHOJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Dec 2021 09:09:20 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8CxVbP012167;
        Wed, 8 Dec 2021 14:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=s/9Oe2t+YWYR8LxyVYc5PH27E6VbbuZ3shlRFwXav94=;
 b=uSuDEYPXNrMg9/neyaf7XjF8MBMHkvR3/dyeWW8SieWU1ltrjK8SELkIho6NmvPXsfB2
 8KGN+NXjJPz+eWTm447lB3QQJ5eNV3ZdymkPfC4noX3qRQHWXD/dDJ5lqic025l1XG/s
 8UZo/+vNmvAteDA5BuCi0u6NxLCrp8ZyxY5j7S9JknZNgkbnw/dCuOhm9Z0meIsVWOmC
 yOmi8D+olGu6rykl/dfth9WZQa397L8RyvWWaAntSwdg3MnOCpEUNhWM8eXXToLDVbZx
 a+FHur743fld/435kp6mXRNcvwaF5Q0CsFakiquAjUNIQNs0rsCHr899rcjTUMAnHctk gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mrhvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 14:05:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8E1Fjj084076;
        Wed, 8 Dec 2021 14:05:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 3cqwf0frb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 14:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFqklFYA3OIFJU6byBz297LS2akOXezFGIVNeW/VfV6dgO+IfldUMhPiXliK5IEnv+C3mfYWjoCP3WbNpmWRp1XuAYtN7Kjeg6k1/6yWv/iL2M7UcKuEi12NDlN6Mehx1RDgEAQoE6oir7VQDxjsIARUxsKn41BOSUdcFIaPkKrLwCffjK8awta9D5B7T621ir7SCoJFPdJwcBZxY0Bj2IPJ131F69T8/ORI64jhoz1XDXyr4WxOXUOMpUkdfL/4FQ/d/oPyv35BoF19rHI6Hd3ZTqoubwAy3tvvT2AqzyZz/0Hk7HFhNHxygt2elNq3ldeZ9j7Z9XmjW3ErkJ3cQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/9Oe2t+YWYR8LxyVYc5PH27E6VbbuZ3shlRFwXav94=;
 b=miwvZPcKRfCOkoSBA2g5R/63Y0I54oKMINO16xoO8K1MMZyp9148gOuVFcqjGJU10xPLP2Tun5Od2sWJkPkquM2SC7DQJY2fsC+DNy3cJwEVrCM2tmxwBB7dbbp5wosjjNx6q2GMQ4Bghw7QhDPDEaD0l7vhLW3adEvGu5e5nUQrMSmj/DRD0aeeWA/KUNQiyPWkdGh29bFaSjpFHc1O7nn66h9HxvelBmzTuR7nGCsUszms00nzmEJFh7dMe2b/rhouF76FbBT/gau3LcF5z3plXakB1MUgOXo8IQdZXTjoBePKpZdVGSlbOOD+5coMU2SN//Ixr1vBdAL6WiwtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/9Oe2t+YWYR8LxyVYc5PH27E6VbbuZ3shlRFwXav94=;
 b=FT9JwVpkYuXzareAawT5cCxkwvZRjiDtz7zOob5Nc9t8jrGOCivOiGJ5gBo5Y/iWdYI8MYoF1+gAPSh464wV492IxHy4cwEwthyXNNZSv+ZYVm4wbEsZaQGgDBAyzBpCEuFpWUrjljPxQ8Ng/j8Cyg9Xz4pIf86B7AG5EIEPlZc=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 14:05:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 14:05:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: harden identification of the stale device
Date:   Wed,  8 Dec 2021 22:05:29 +0800
Message-Id: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 14:05:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18ad872-adc1-4d2b-f47f-08d9ba53d3a8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4191F06B97C3FD062FD88C48E56F9@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmQQhyoKpvChmEa2SyB6A14b/VpFIL9VDB8+ci/w3u8sVF5YUcDs50m37BM0rzOP4MYEaEvuCb/70ylKv2/E64NpfQI6g/cEShRjghKOwRhCalRrpRG85pqkWpcsyJL5UyZkDdcnQpmnBMS+5rMjbRFRzI+JG0IKZVgmjshXtZkjpiI+1Zs8yvAZj3Lge++Pm4VOUuCqe67nnwF9EZkEtC7SCGOaRYGjs+GwcTSTUCEA3OALT/VKDMfYAv2FZ9wJaozVYgQbrz+Tulqail6EMJJQdm+2efHBjxjpq/x0IWREAaECRfQiFYT3tn0FeW4hiIBmVJsm7Iq5oNMeHETWy2MGXtwq7F87gpL38HMLU6ws8EATghx143kPT8g6JPyd9+zLfp7oTX7S/QSygggjURRmVkp+3eXKisNhzC/o/QLk6l60Ohh8eeFeG+wD7C2oZyR246eOrsDEhlXY7g+FKFX3lR3YyNk4K6h1qR3EEYdyR6WDraIcuifGqle/SlEBPLJByhY2ltb61H+hbphAhoMeT/yMEs4qc9qZvo404edlel5+cZS5kAsODnI0cjSdE2C2QnZqe4OQq+douSh56JRAEFyZ3idAOj35uW75maGnn74WTfQXHPScmNZfhv/IQiwr3ZRj3chhwiDwV+ipbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(86362001)(4326008)(38100700002)(66556008)(66476007)(508600001)(83380400001)(956004)(36756003)(26005)(6486002)(44832011)(316002)(6916009)(5660300002)(6496006)(186003)(66946007)(6666004)(8676002)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vRocXfVHT91kl1CeGCaqdNEpdJJTDI+erBG9T9785NmxEcvs+Y6prXZwoo/?=
 =?us-ascii?Q?FG1I759WJXlPDfBQJpD/Ifl0hTUEMseK+JND3Fxucj2XKqogVNWjkTRadTEt?=
 =?us-ascii?Q?5LtixXo1SWLyAAV4kHbJBtJyUUrubomN97/1yPGAJikP4EKuOKnAEWi3tJIq?=
 =?us-ascii?Q?Pa8MS4U6DMpwBxccULtexnsOnHx2DjCNJW/ryE+mv86FdLK/UY8vUuuQ6fAX?=
 =?us-ascii?Q?BA/mjRSgfdqcgHaUvL4sl9CoJQjoYHSe6TRfN9ZvXYJhtFDK2B+uq4FZRf/N?=
 =?us-ascii?Q?5OC/YROMKFe40puYZjPWBky1j1yXtKYFDX+hziEJXMHKVGvv6bH4gCvbMRlh?=
 =?us-ascii?Q?iBajSjp3VhU14IK7vDqV3GZsQ+65W/GbF33XKTSksczLuJpRNe/y1wKs7Nfx?=
 =?us-ascii?Q?kpN4BPlTCmAbAmGV8g/GCsOtTTIGa30swaqrp316SQIAschQbncxT8Zl95M/?=
 =?us-ascii?Q?2b7ZCiy+Kq+XsAsYfJSVuuaPPcOqR8gIl6Npo6si45/lPDA9UebUOxiwZe4Z?=
 =?us-ascii?Q?uojjtB1eW+ZjWApinpLas42/w+de4zYYMLMyInWglw12E3i0n0YFQ1dCTWbp?=
 =?us-ascii?Q?Hlye1jio4++heVEBNfYO3eloJq4TJkMwfyfc349TUYM5NOKsTxPsMFUsaxpq?=
 =?us-ascii?Q?Tvr7C4gyJOG/q4mhWYQqoQvKwLKAG4F93uh4Aw7h9AB1dFxvIIhGJJ+bqDO0?=
 =?us-ascii?Q?3jqHXmzP3d1iZxAvM/f4hmpau1GxzpIhFcUuNTWZX70iMHP0dQPXBuje7pF9?=
 =?us-ascii?Q?Nuvb2XzO4leqAthscZC5jsEyyDAmowwVEmvQc2M8ZNc0cVObQWXH+LtUX+J5?=
 =?us-ascii?Q?jmPuy7S1jSsDha62XQF2jz2VTqXDf+C1uzT439rVJz+IvvyRS30VUlI7rydW?=
 =?us-ascii?Q?NyzwcPOnMVb+t0dfavdNXNRWHOllXneuVcnvghgK2690nXvcy/3GWsKJL/sX?=
 =?us-ascii?Q?DnErf0RbV6hmUGvQDJXjX9HlZbQ0MeH48pV9ZnorDULRhvDib4htsK6sotVV?=
 =?us-ascii?Q?/wxDyRpq9Dffp9SnBNY5CmWzcBeLJP/XFNW6I2QDSBNV+CqxEctbkYDjnnWv?=
 =?us-ascii?Q?9OPnPdamHISK4eUZJya7aqqyz0AvjdI8i1zfOTKX4fWK2/3BPWhkVccYZBMh?=
 =?us-ascii?Q?RmNnyF4Z2CD9Px8cPFq78vUfJgUTobo43Jh2WwgKx9E/dQxSp8+9eeNN4Hko?=
 =?us-ascii?Q?MhZLdXaRE/19ydVxqlZEml7MbEMSaUJ2b6GjQmSqwO0u5kxxjY64qCj0IEvp?=
 =?us-ascii?Q?mVykudFrkfou08wmX1xYLCmT1wgGFpmUluQJ1KFeS2AAMT5dK74g7bs5YPh5?=
 =?us-ascii?Q?ThbdJMDrwlghKYQYpl2QhqirZnDEaSYBJSiTvCpxUbAPLsqg6uGbJUlP4DDU?=
 =?us-ascii?Q?z7aKC7tGSLi0yJAymA02/8EGUUlu31Hsgt5th2Q8PltCCz4k7BdtWRIFGtxR?=
 =?us-ascii?Q?Bf5Rkou+pfivAp7aqs8uZDM1PU/L/CkNSFDeYpxRLhaXATNDuZAIJvNso9hn?=
 =?us-ascii?Q?KrBXK7bt53/fZippQb0oyxLzMZeGGzaSKg6TMdUCraeuiybtLI5Vv2FwPmpY?=
 =?us-ascii?Q?7mA70nSxmgHUe7ea3xI06VKnsfeFeaornIemiMuXJ9NZMtBiQyMch3tJQ5vl?=
 =?us-ascii?Q?5O3/r4PppZIzRGOL1a+ySbE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18ad872-adc1-4d2b-f47f-08d9ba53d3a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 14:05:44.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rog2OFn4d352C4veWkjbtaHV7W4Yq2/AvGY+sKAx6KAo6PJbwe0cH5Q3giiMYEtFFKGgZ+fXei2+3pabOHQflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080089
X-Proofpoint-GUID: 4wpkLDOHqLLnoxeQmkv1INcbzwvQAmfR
X-Proofpoint-ORIG-GUID: 4wpkLDOHqLLnoxeQmkv1INcbzwvQAmfR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Identifying and removing the stale device from the fs_uuids list is done
by the function btrfs_free_stale_devices().
btrfs_free_stale_devices() in turn depends on the function
device_path_matched() to check if the device repeats in more than one
btrfs_device structure.

The matching of the device happens by its path, the device path. However,
when dm mapper is in use, the dm device paths are nothing but a link to
the actual block device, which leads to the device_path_matched() failing
to match.

Fix this by matching the dev_t as provided by lookup_bdev() instead of
plain strcmp() the device paths.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This patch should go to Stable-5.4.y and up but, there is a conflict.
I will send a separate patch for the stable.

 fs/btrfs/volumes.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 553ee97078f6..cedadc81c851 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,15 +535,34 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-static bool device_path_matched(const char *path, struct btrfs_device *device)
+/*
+ * Check if the device in the 'path' matches with the device in the given
+ * struct btrfs_device '*device'.
+ * Returns:
+ *	0	If it is the same device.
+ *	1	If it is not the same device.
+ *	-errno	For error.
+ */
+static int device_matched(struct btrfs_device *device, const char *path)
 {
-	int found;
+	dev_t dev_old;
+	dev_t dev_new;
+	int error;
 
-	rcu_read_lock();
-	found = strcmp(rcu_str_deref(device->name), path);
-	rcu_read_unlock();
+	lockdep_assert_held(&device->fs_devices->device_list_mutex);
+	/* rcu is not required as we are inside the device_list_mutex */
+	error = lookup_bdev(device->name->str, &dev_old);
+	if (error)
+		return error;
 
-	return found == 0;
+	error = lookup_bdev(path, &dev_new);
+	if (error)
+		return error;
+
+	if (dev_old == dev_new)
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -578,7 +597,7 @@ static int btrfs_free_stale_devices(const char *path,
 				continue;
 			if (path && !device->name)
 				continue;
-			if (path && !device_path_matched(path, device))
+			if (path && device_matched(device, path) != 0)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

