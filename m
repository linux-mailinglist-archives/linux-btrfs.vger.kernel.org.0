Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B824877F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiAGNFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 08:05:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62646 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347377AbiAGNFI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 08:05:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207AQiNL009243;
        Fri, 7 Jan 2022 13:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VNpZsHVnlAyccp+SQQ/RUAX5AsftNUM7xlXkx2BJM/g=;
 b=weuuKxzJIcJZWolJLwiR8ISdIEcwC+t0HSjLBZZ97U9SqYiKZavoLh16wXat6W+PGP9m
 DtPlqjTRMUTcTKh3qzgSdsMJY0ktqRveQOjuQxJ47wz5X5c7AHX6pGkvtv9aU9tUXB+O
 wJbIxxHXK68FZcA0GymfRV7dBWwItCXgwoz7v3clx6bM+w7l8DENkRqyDLkU0xnGU9qc
 uZQJQkbbTkI7SKC5enrCbgCaq6YZ18v7x5b8iazaKUG/aSO4iEOCiXOxW2vtwndafqZG
 IlMYbfVZfYFNikZpkV45uHK27h4yHXKiv4pQ2RdIciG6ptTr4zeLq1TK9ruDqPLF/Udw Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh9w04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207D0GK1070919;
        Fri, 7 Jan 2022 13:04:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3de4w31xv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7pnYjuDwksv28dSjoiGZI1JcyaWe2/Dlsn+q+gR7O+RtHPtzpd6ulpT55Napl03LEeFM99AYE0I/71S5Bl4bliuy6wTFW9rS/ytWlB9ms4tdIExxSAl90dfRQLchwPUej8Ei+JsQnv9BSBAE6GUesqfaHnKHIe9SuKKvnrP+fYNGhSlC1mZYLPSRzsg/yrHaH+f8EuB0UYeD5BWY++WUIC733aypKF/CuC24cb/tmznMjcB+wBXXFqJW2WNZa3o6B7KejmEGeDDSmx7hZ0Or5hNAbcoSP+rCRELaruVCpq5QvmgsqVPlkiBFVchL4Qp7/m/Nhc5buHslYi7GDfs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNpZsHVnlAyccp+SQQ/RUAX5AsftNUM7xlXkx2BJM/g=;
 b=kZTnEmk5Pc6zbSwfdWICiWs7OYLCfKF2sWtGintEt3o5UpGLA3+JnFtBcY+AAVQteC327pfyPRmBQ+4bXUyskWlRXhOgtmPN7LIAUSbNloyiRsJulFvMdjMEM1CJwtKJgyaKoUsHPY9MaRC8WbvO48X+EcoBJPJ03nbbNz/WDwDdWcUhWv1EvQX5xnbNJtcCmCFu/3x1nbhwyNgz+lcp48RHnGPKD6Zb2fYTs+zmt3EMLo9E8qudc2YaP8dTyUz+YYGpW5+rZ3di9OUVe1sPOxAmYWnqa8i+ef4oNgbwOLpqXIVgQ+F08vpLRIE52JeaQiQpJr1zknejfEbPftpzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNpZsHVnlAyccp+SQQ/RUAX5AsftNUM7xlXkx2BJM/g=;
 b=nqXh6004b0BcUIeSFyz9PfVxitxtD4I7OGg7hHOuWyhqtns2X6UzO5gD9Gn0olpE+ksI63ttkQWaiwTbSxKdnMQC5ASX+oyeqqPm16NOzFXAy5nOSWDtJ7EjM+iE0TyeOKKsDr/qIT5YAfOc0MeXpR5Z7QfkyrmVOh7N4Sjuk6Q=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2995.namprd10.prod.outlook.com (2603:10b6:208:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:04:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 13:04:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v3 4/4] btrfs: use dev_t to match device in device_matched
Date:   Fri,  7 Jan 2022 21:04:16 +0800
Message-Id: <419e8e48639f2bf54e7790cf28a1f4f8e51df451.1641535030.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641535030.git.anand.jain@oracle.com>
References: <cover.1641535030.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9020884-b964-4322-433c-08d9d1de4cd5
X-MS-TrafficTypeDiagnostic: BL0PR10MB2995:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB29956D235AA3317230A69F8EE54D9@BL0PR10MB2995.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMf8bPSUHdbK99D5xhNu/wksq9m0II8+ANAHb5QzFod5qXEQx239v/mjDoRfeATntgM1YH3cDDPeiEwsvDR4tWe12N1Cd2jwyXmSCOlifM83FAOnRHEmcEPrIWH4StmeZf4zdeNIF/NUACXtpOhEJKOEeBrb/SoqzuqeLHXO2K9Tm8rF7QDFucrWUoT3TrkVI9WOKR7yeHn8FYap4IK4JkV/MM1qBkULMkdNxUyti8Xz8tMtGwiJh1XCrcGKk79s6ARRnSNL0qEzGJfZIs+unoOYsc2TxkDrvkX0zxPisrFnvnZSzio7V7XzyzQjzAIMawN+n8ELMw+hunDCDaqpnIhZSympZ24LNxW3MEsi1h8h9lKMS8+nFmopsbdcK6fZ90vSDbmCCZl2TFlBmvKDqKDttVMxpyOO3rf9s95S6/5P//3l9+kLzRgcf+Qucw9rzLZjqVX+B/HuZzwcRfp+3cAHoDOr3wiLjMwp4bM6DKrR10fVVAgtMExZ9ys+fz/sXqlmtY2S1Kf4AdZKdHVMNyoOzuDEpQN4tuDX3i7sGMIYYlJIR4pt2CnHgBweWeLblPypDCEFPkAtaerEitMXq01Wr9l3cvZzhkDnKII/H8evfw2eMemYbPAbSQ7VQO0PcXsbAdaTRbi15E1ddF5gDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6666004)(186003)(83380400001)(316002)(38100700002)(6916009)(26005)(8676002)(44832011)(66476007)(508600001)(2906002)(86362001)(6512007)(4326008)(8936002)(66946007)(2616005)(36756003)(6486002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+zrgkIdbcTgxYw/MjEc/YgdDlAMuRhpH4W86syl2OheqmAkocJHh2QXYAQu?=
 =?us-ascii?Q?VNh/Kf613bSJqkEStLxmtxR0XfyZTptOFYKtsFm4TafCS5/YnCs4UNsrNX2i?=
 =?us-ascii?Q?EfcfbJygAQRkN6D3TgoiHFOWCiZzeN8k2IZ0pLRrIKHV1ruCyXLycKW2qn4c?=
 =?us-ascii?Q?BdI+7XGi0r9xzTk98PQD+y9bxUVvLj9gGLfGRZ2eQN4Y8h1V64C3PSLaR3hU?=
 =?us-ascii?Q?ULc6bH1a8NiJ253yHmWiUrdJvNbfkrREKhphugEMYgZ97vGhVeES/UiQVo9D?=
 =?us-ascii?Q?+w2IheYrIKxTFDpLcJxfkODPNfHO8xS5q/7jkP81GPgna6RcZb5pBirUxPe3?=
 =?us-ascii?Q?3IA2HSRDoMxor4QS0XPIYPKqEO8Hqhh41X1YTlRuhjWr9iNNfexb82loIHST?=
 =?us-ascii?Q?jdHTX8+NrgqfCORfFZbcopfylr/sSxzqW80WQCOrg2KTu3v67TNumCplfHNA?=
 =?us-ascii?Q?5T5S9H7Ri7MqbL7PCSVHchsrVJIjlxXCbNPc53aIHAKOUKLkIeN2GVWh1Y+1?=
 =?us-ascii?Q?LhQvxlRIYvqLce6KPjJLlMrUpLOiuNNKVz23AtRBwe8rRoelISo/Yl/ChEPt?=
 =?us-ascii?Q?vxzgciLXgHWPgZCRRea5tt120t5uvtipNtQCrc/QvIpKp7pVNMqitz+WIDI4?=
 =?us-ascii?Q?zneJ3DSgJnA5/HfxpF50mzMmqp6+AiexJe0JIiop1Qe+epuGx9g5b4PSuS9A?=
 =?us-ascii?Q?nJEQZrjKQOy4JKokJ/pVvl0a3w5CoHGZaaG0fB1KJmCNdKpD5b0RNETEmJvI?=
 =?us-ascii?Q?rNcfzf/rXHYgUFpbTeB+u9UFCMC/g6oBO/9I5XqjXGmdxXaSKOqNyaB9k2Aj?=
 =?us-ascii?Q?gTxlbtfKPG5kIFHllXpmwX/WHLs8Q9OwlmyqsVJ2eYTV+bauAD0ar950v5ie?=
 =?us-ascii?Q?DmvXHPMlMQAHGlg+MUCnFaHtYxANpSmmWr06TyK/2FG9WQVmHzbWHgPaIOBF?=
 =?us-ascii?Q?sYQ6L35CSraToP7kcDTo+uiYOHZtJokS3LCi1Nw60LGrcOpXsSMiXICb2fgA?=
 =?us-ascii?Q?FwqV2XZ6gTpkkx6s3nJZGsI2ic5SrFQxJhZXaO6PIyXX2xV+wa8I0MBkWabH?=
 =?us-ascii?Q?iuGkOA7/eLhXcQehGGcx+fPoyF6CjhRdWglkZMT/SsWmzp0Kl+DigWR+Y07E?=
 =?us-ascii?Q?B6zjxEWpqzk8Lvwzax8fAcGrZ2BYBgdb3Ne3mFv4PFdxt7QMLorxbxiSILGB?=
 =?us-ascii?Q?wPh+FdDuN4tAA2SIkJgyZpJsGhYj3Fc1XYr6na97HzQFd1Rt9XPPqO09AJxI?=
 =?us-ascii?Q?FjdzLb9xEc5p9zIzf3Sc04Mam4ksvxESFHybp0v6hVvAbOt3hJbbe0s1wg66?=
 =?us-ascii?Q?vbcy170fAuFtwM75oUKCFWpJre6LmbEzn4uVZSZ757b4gObAlCzWsGn6EDYN?=
 =?us-ascii?Q?W/Z4r5e4aaWXRc/zNozQIyWNWBQdNQnNJD1VGalEhfQtZ2rhGx//quSRcJfj?=
 =?us-ascii?Q?eK9bIyptik7BXJ2zZL8IEiU41KwmOgM/kIusMUtCbd15tcOiR7d+ZwfOSAPV?=
 =?us-ascii?Q?KXmx/MrGeaXOIMVDP/yya/HeJ1DHFZqw1wcfhlnA7qr8OOxsyy67u9VLkEYX?=
 =?us-ascii?Q?1CnU0DGzhY9v7CN6H6fZ3g2RAx/xTD5DIdp0D5pY2tgTaOWTl8DkAe/ncv4Q?=
 =?us-ascii?Q?RE+4G1AOdsvByWKlPKUMPLc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9020884-b964-4322-433c-08d9d1de4cd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:04:55.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD05ZYU31f2CaX+uFRUYobYrZ/FUxS0dZDy8vx7q3hqRaLO4x/l5t2XBMAXK/5dmyxYDkvF9k1u6V2S0CqkiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2995
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070089
X-Proofpoint-ORIG-GUID: 3GA7Ar0gxEGKSc8Jz0JwNkemUA3nxIOf
X-Proofpoint-GUID: 3GA7Ar0gxEGKSc8Jz0JwNkemUA3nxIOf
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6531891b2bcb ("btrfs: add device major-minor info in the struct
btrfs_device") saved the device major-minor number in the struct
btrfs_device upon discovering it.

So no need to lookup_bdev() again just match, which means
device_matched() can go away.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: -

 fs/btrfs/volumes.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 33b5f40d030a..4d424c058a27 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,43 +535,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-/*
- * Check if the device in the 'path' matches with the device in the given
- * struct btrfs_device '*device'.
- * Returns:
- *	0	If it is the same device.
- *	1	If it is not the same device.
- *	-errno	For error.
- */
-static int device_matched(struct btrfs_device *device, dev_t dev_new)
-{
-	char *device_name;
-	dev_t dev_old;
-	int ret;
-
-	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
-	rcu_read_lock();
-	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
-	rcu_read_unlock();
-	if (!ret) {
-		kfree(device_name);
-		return -EINVAL;
-	}
-
-	ret = lookup_bdev(device_name, &dev_old);
-	kfree(device_name);
-	if (ret)
-		return ret;
-
-	if (dev_old == dev_new)
-		return 0;
-
-	return 1;
-}
-
 /*
  *  Search and remove all stale (devices which are not mounted) devices.
  *  When both inputs are NULL, it will search and release all stale devices.
@@ -602,9 +565,7 @@ static int btrfs_free_stale_devices(dev_t devt,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (devt && !device->name)
-				continue;
-			if (devt && device_matched(device, devt) != 0)
+			if (devt && device->devt != devt)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

