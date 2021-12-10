Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E544147084B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhLJST0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 13:19:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16292 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236984AbhLJST0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:19:26 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGHRQb001879;
        Fri, 10 Dec 2021 18:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=DLomkm/KeynfjO2xDo/3uD98xCy6+JLKIwo52pqScR8=;
 b=q2R9duPylSYAzs7KRUEkzkEZ3a4sAKsJrqP76iMiK0xyDieiNcpOun3d9kgofXOE07vo
 VWAwb5QIqNgPBq6BtP2nyYZJqzYtK+fnZ7gRZO3o8ITv5dprOIEnqYtxw/JYwSIuMe95
 ctz9hCcp3s/urAEfmH5wMUe0sQg0qSbP109x4NLZ1Gl4s8rUIrcgxHbGuzfrQhGqgx8h
 xd81IV8BdhoXBz/RKl8WdE0U1txRIx0REiTJBSrnBYmuM3g3zJ4SbhW8r3tA3gVIEPJ6
 98sjssRBToxskbaRvIKkGWcmx0a0m5vPsEvhhFmnxQu7Q+B6EFq8mZtdOk+VkzBIWizr kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9ng99b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIFMEI188463;
        Fri, 10 Dec 2021 18:15:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3cqwf4dcgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQfv+GPDz+IPmt2qhBlQ8vM25hGdK1v4xeXVDKlELH6nUPOxpNT4YYyEYlkCbgazxBBncauyulgUVAS4/vF/k+QO9w21QCU1zQ1xh9R1sGkXUp+ZmMCVLpersZKpRrjBnHYD8lJhT/ts4PlxX6cdHrf8E703tdphrUm71lNsgcLk5H97YScfqGDOJCDujiNfmGaF5x60z10ZPciihE8TLUXJg9Ra1tfd3efbrPyLTBJ680R72rjJ+/V74nDVD/cDyc/Vz4T1Dp4oqjwWtrijAFh3B1MV9k7HwicEdbrasX9A6MGlC6URhT6uKbQ2xt0ObN+1ThKYWLgrA6d+8asg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLomkm/KeynfjO2xDo/3uD98xCy6+JLKIwo52pqScR8=;
 b=awbkYlJo6omuA98+hq8d9PE13INzLlJFUanrf+0y71ZWsJpEVqLtN/yA6kK8jBWEWBiXK215Q+yHn/HMLPj5GtzPepqDbGWJZjQrVNd94S2P7y6kUdaNkfmXrROxHA5hFslRyW99H0puUgZT0+O4juCeCN67REzjConTqBg8CZw5sU1h3R1P1VIcK3Nki7auwDPQcGL0RkzPQqIQndy8zovzFs0Gxz9hWUGYimQA9bV/s1adWlB/EwhTU7tMG3Y5sNbbtWO/jKSoXV53XnVvX/7ucB7K2Lf9PsQOD38dMibCmbjX+6Lcy+3cV1WAib3gxbfX6Q75THvRebUMb4UpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLomkm/KeynfjO2xDo/3uD98xCy6+JLKIwo52pqScR8=;
 b=nEasLtJ0x1V0KBP78ECIJCk5IUf9PFGey79beMq7amwHrWYZHyH+zKQrBwpESTbvD3SzSAD6+5roqDt+NhpbiO0pWWzOh0adhJdotVh7AcwYcySm121jIqrzj78xpuFr/IrxHfpFsqdYkVQ7IvguVRW7rhZ8XFjwko2FlHCljnM=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 18:15:47 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:15:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 1/2] btrfs: harden identification of the stale device
Date:   Sat, 11 Dec 2021 02:15:29 +0800
Message-Id: <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639155519.git.anand.jain@oracle.com>
References: <cover.1639155519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost (39.109.140.76) by SG2PR01CA0186.apcprd01.prod.exchangelabs.com (2603:1096:4:189::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 18:15:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7937693d-07bd-4e93-73aa-08d9bc091680
X-MS-TrafficTypeDiagnostic: BLAPR10MB5188:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB518862AD1CD9FF5ED291D2D1E5719@BLAPR10MB5188.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ivUQDbe3KjMp/amx6kPfRbRad8EkjNRwxp2q23+tW7ikBHNIJgQEqMEfrzBfTpGjhoMxFMLdXq5vis1caj7qBshdkikvGC6c86vcbKBm+mB9mm9XxQ4QBct8ocfbwJhVtznIoF8z8PvGgF6D+D2nRVaF/g0SwtdjM+bZFwUFZF7/QTX2SqqV9BGFRDO8G78FzTiHWc6G+fCUHsGC5tVgLfhar0be2aRsZbqB8hsv2OyK6jVlhWtt9r1XbDZKntTg2vuyqQwGSUkeQUxX14TXNTZEzS1MBpT2HcUpdY09mtWrreFUD5J6rgFNuMI2cfviPKtmUf3IwJUkXUuf1H9VkWTrPXdCSlQRWg2X9v5Zu+3Z1O2NRCW/t71oTq4xshEjZZgCf8d9AjyPbH3YFv7/RhGHbnonpuBSiEnWGev3G3U3aLFiLego+UYWWLy25uRDqC2ilkNTn3x4c1ohTUqj+5gLsECIqrh1QpYmQkcCVaf2Y4cS1cy0wCvGzRfF7D4VSkmumZyhPlMdjFn30LsQNo/FwDRxDsm66C51Uvkoi1wLIItFO0iAB8wBgpK27zYbfxEmkzinRBd/1edCU7I3/IHURp7MsxJL9JPjjyiQ179WnOKDUQHyKngfa44zb9OiCAkNE8GCbEkmN1a8XifMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(83380400001)(86362001)(38100700002)(44832011)(4326008)(956004)(66476007)(66556008)(66946007)(8676002)(6916009)(186003)(316002)(6486002)(6666004)(5660300002)(2906002)(8936002)(2616005)(508600001)(6496006)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iya+w/FYango0jt61x6gkOYbObpFA5JK+Buf2/4YDJ5/5xYFklZhO5TAL+kx?=
 =?us-ascii?Q?saZVwKEO5+HonrQrfGLEqK9ZSonqbFnvnSf0Qcv7RhewXdZljGHdiQGrUrMf?=
 =?us-ascii?Q?mkzE7SH6XckYOKP2iItu+YVyem/iKlNi5tKyw2ENo2DUtks0Q1QACCYdB9o/?=
 =?us-ascii?Q?1dwYBvNUOWpa9A7IzX19lTFHogHqsiWyQF4r96kh443NkxZYbqjQCYZCK1Rv?=
 =?us-ascii?Q?pwlRXVLQxW5VvL3bTgv4Dfjl8kBgTEJ4+MwoN2MFVCGm004uGtKvIzMag/sN?=
 =?us-ascii?Q?PAF/UmrKIf2HYxXGVbDhyG3VT1uhk//q+yJ/0mkYWFBypZcPeo3rtsV419p+?=
 =?us-ascii?Q?Ar/tUMBRgGESKFv5ipoOxhF3LRuweq4cWN3L0DV7ANNOCRFRZEYra9tk3SiE?=
 =?us-ascii?Q?j7B2/09u24B+hExQ+Mp7yYfM8YC8FimgKMc7oxHWimfXiWWZd5FCmNTehtSt?=
 =?us-ascii?Q?IuvKUPjcafi7qDdzAct653XiEI8V+cwG7tvw4gaIwcwOBS49x9MK9C+E+gr2?=
 =?us-ascii?Q?OYvKoMtS/MmzjUbOhGOy3+9k6VI0Uy5mEm+e1Psn0Dd303+y9v2bEiK1+EbF?=
 =?us-ascii?Q?VmOl0wQId8pUNqne9oiqRncLOceIDq9sy9W3vUulM+pWAvO7zLCtRaneqSk9?=
 =?us-ascii?Q?Z6AKEAUoYfQFLJEilPc5li8OOXMp56vm4xS0ovzmZJGLlM5ltaTP4iESVohc?=
 =?us-ascii?Q?wLq5egq8OsAzyo2+/S7QffvJI2+NDx2Dog45AWxrLcVtJc/d+4SO+3X+sWDa?=
 =?us-ascii?Q?yq28tc/e6Ob2fl8H82RRGfjMwualegtXbvTn4t9AsbBF6KDdylUgriDyYhwQ?=
 =?us-ascii?Q?YiKdd2quCjyTL/rGzVtB4JbUnyV8T5RlKpkgpz437wDBE4QRjpVVF4Y/xfPT?=
 =?us-ascii?Q?nakG2WpBazEeO/WvgryG04OQ1Fz6Roe+g8r9MeX0d3upDhxEQIgdSsQcdMCK?=
 =?us-ascii?Q?hpNTNPtpUzma54GwOrgVim3VI1yNCVJipUXqlcEf062gIk88+Nwxbi2k8xzU?=
 =?us-ascii?Q?74o2KaKo9sydyfakXvIfivq4OPpwqTFJeRKW8sNiK5bGS4vQyr5dAiVK5Ek9?=
 =?us-ascii?Q?++68Yj+y+B5vIbFSc7agwzHxRyVtMsL2qCSCpsgEEtmpCdImocG9adZ4/k9W?=
 =?us-ascii?Q?PdlYW4lqhViq/D1WOuEOQwHmLcQqc+CbdaQeoI/MKWxRQ6rzBnXnKHCkj4WD?=
 =?us-ascii?Q?UaNNC2GLfbQC8k9ZUZY6ePAKEB42WKAXNlKbSsOMPPTxYqZKwHSpSGvCr2r5?=
 =?us-ascii?Q?PHtFUCeC4nWJ20sQaAGFXr4nDRnjRdI9ywEN0VRss3WI8OPC+dNN0EF4vVlC?=
 =?us-ascii?Q?E3sXSG+maQgN+IkLG9LcGSUGQtHANGgAMWmAvy5329Hm4Qyila2bF4TMcZ8T?=
 =?us-ascii?Q?ofFR+JCiZIQmi3RYDmeL4Pct+8Vf1Zj5QH7ijl2Ieni2lguZBB0SEbMFSOUs?=
 =?us-ascii?Q?F8p30rXYhKgFB5NegOPOdaHLnxGbVn3V6gyJxA7LNu3QcLF39eX9y6lrq3+v?=
 =?us-ascii?Q?9P8vrNvG68QXdI3rcGvaGEu1DseHvu/sRSfq3FoBsV98NJGNDRPz4uUeqmr0?=
 =?us-ascii?Q?TlYE6hEfC9fPUPUzX4Hrq2IkclYLHSjF+FZFNuAc6ipB32K6xj+KwT6Hctmw?=
 =?us-ascii?Q?KF+uqC9vOvPgZVeyE/7saE8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7937693d-07bd-4e93-73aa-08d9bc091680
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:15:46.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69C28DMFHWVnTA4joHfpoHInDIMt06xBkg1Vm3iF2kwcsePjhjDFaVht2+qiae7+IrfZDeq5EHgvMHzwD3yMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100103
X-Proofpoint-GUID: FLDQEADuC36Sq9YUtAvAwOunAybbFwD7
X-Proofpoint-ORIG-GUID: FLDQEADuC36Sq9YUtAvAwOunAybbFwD7
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

v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.

 fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1b02c03a882c..559fdb0c4a0e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
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
+	char *device_name;
+	dev_t dev_old;
+	dev_t dev_new;
+	int ret;
+
+	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
+	if (!device_name)
+		return -ENOMEM;
 
 	rcu_read_lock();
-	found = strcmp(rcu_str_deref(device->name), path);
+	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
 	rcu_read_unlock();
+	if (!ret) {
+		kfree(device_name);
+		return -EINVAL;
+	}
 
-	return found == 0;
+	ret = lookup_bdev(device_name, &dev_old);
+	kfree(device_name);
+	if (ret)
+		return ret;
+
+	ret = lookup_bdev(path, &dev_new);
+	if (ret)
+		return ret;
+
+	if (dev_old == dev_new)
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const char *path,
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

