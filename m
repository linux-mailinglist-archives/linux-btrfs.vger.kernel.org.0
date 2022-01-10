Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA744899BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiAJNXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:23:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39414 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbiAJNXj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:23:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ACnSJ3009055;
        Mon, 10 Jan 2022 13:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pOsAy+9EmsGDEmiLCPrxwQd2+uA+Pt5rGnfQt9trRV8=;
 b=IJBTPDK0eDduSMZWUtklv8mB3xyBpaK0kQR/9uANrgDmzUYipGFkpMOKIKVE9fYzOVJQ
 eD+ERwS/FCBhCkXRaXf0MD9rfgpC1EelH6rTWT1h2d+d/DivS8RC02+Sy4aCepcMhSyC
 /39ybQpQymf7B5UDcwc/jpHafQ4ckvHYw/FXHLdir4+k4P/zIZ82WYI7tTGPVhpoUXOv
 E4vePvx3MvIAPLX+UcprRVEM2srIjxg5vR0PsmWLGr+LUPq5QoHlCkFFrCZ4PC+Ck4YT
 vswaB68aEXeNKKQL+1N0HjRAf5LpASSdETnsvHQHqgI/LKsfxvWAdXTNRvubHK0DMrWy rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df35u33p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ADBsE5116424;
        Mon, 10 Jan 2022 13:23:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3df2e3955e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk88eAzE90AGurnp1O5isyLFdCIvbuU7KLZFWJJ35sBBhzqphfv4KZ6rnMMEB0fp6jUJC85XLld7fuSjt2aGzqQlLTU6sE6hbqCehDOtyJF9XKl4jON3Jzn+82uJT/JjH2s2oZfGWNZPtnsH1XQ3iO9IcIVexiAv93YUzUQYp1bsLaEy4shXwva+arePm9rpS0vcaGw+YRJGPY1Uyf0wydVzsYMPBH3ir2neokgL1N6IlPT5qobhCYsnsE/xcVwukIxvELKAgzxBdc1mSqdWVKTTJd92dqiKS1QKk6qYKVfcx98Qx+5U2eiMfsrzjAGDx+sVtrwMoGIrSsMnbr+MCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOsAy+9EmsGDEmiLCPrxwQd2+uA+Pt5rGnfQt9trRV8=;
 b=CKuPEbpM9kCd3BoxYBgr2HttLen/RLEr9LRk4BUUAvMA8pLdLqsVOG69p5ifnjoGd/mcJRicnXxeBT3OoZT3tdW9yI0YFblFnHwmzVHerMuLfnpJkQsj+ZmZHTa0iBKadaThgpvERd0CI5pU1X6m27cvWjavxiKZiqs8f9zqgj0VS/2Vu7VvJbQZVjRbmEsnYek+UcypSWvCAcGsd4/56L/yGL4sE3xMqGkH/L4fmoWk7Jrd/iuCoWpe/tSPgQVKrPcWUGAUkrE/BdgyKWgplfnE4V9GEjOMzYCwJqFLojaFwf/2rru4t6NUyEEgLrPrnFen0D9sZWHUnSjA2V3dxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOsAy+9EmsGDEmiLCPrxwQd2+uA+Pt5rGnfQt9trRV8=;
 b=zNwGiNUjyUAcIdy1yNy2OW+N00tVMq2SvzVr3t//EHdgaVoM5cNU73IGv7dK3rnpsJ2H3oz4kQYgCKjBjwz6baUkHKy/vBlrcmiXlbinylZ5lXu7mJYHLifvmpVVxXGVNGGBCsx94iY8G2DAHw9tnWS9zC+Moh4zhEy6M1Mjzoo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3791.namprd10.prod.outlook.com (2603:10b6:208:1bb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 13:23:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 13:23:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v4 1/4] btrfs: harden identification of the stale device
Date:   Mon, 10 Jan 2022 21:23:11 +0800
Message-Id: <b1523d512e2e032c38bbb1b0341e95c52a0f08ba.1641794058.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641794058.git.anand.jain@oracle.com>
References: <cover.1641794058.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9971e86b-97d6-48b0-5285-08d9d43c6441
X-MS-TrafficTypeDiagnostic: MN2PR10MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3791443C9E88C3A117BFAAA9E5509@MN2PR10MB3791.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzJizYsdzareSP81IO28Z0ZY4/d2N0JtqG5vzSYGHzzofaf3ZsPzlgFaXsgiUyqK18dfU0mOhjLhXbKRF/1DnwrKxaoSDoVR50bq6oQAmfrUP570YZE25RKhxY1Tx3E40Hvr467MdqaOQ9iO/jDzAsy418O99lLkG5NcVXxfR5MBpoc8w8cbHDl48Izxz/BglLZz2i/e18yYs3/gXqqAMllwL6EEBAfVJBOEZM3nAQzACIW1iH+nDVY/Rc8OXRNXjsLMW6YM/mWYckrUfJqyUafRiYVfUuKNQmHcDh14AWrd31hhaZSUdrbD8TP5onSqrgGzX5PBrEz4Lrzi0YqHmIvgWSGHZxQUyVrnydPgccdeQjk49ukFo21HSpPrutPWIiVz9wvJkc1erQFT5xHAql2jCF8FUaeW2lINV2WN6VP/ETF5rBzFY/brKWxSNVOxuH/PgIq82yzc1HbSwhYhpozJEcoLqldGrRljDDbTUqiEQCg57+hPz5KPyxRXMCnMzGCYXPsfZCy+xUan9cydTSL3v1CGSrZNXd+puG7DlhAb53VbREqF+WBz52rac5RYQUtw0322QIiq1uXgLlyjEnE40sFoI7KmMxzw7IW3fxrf+jxTVFzKlGfk5fSJVUtGUvR9KptIpc5s14SBuZ8/1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(6486002)(26005)(38100700002)(44832011)(2616005)(6916009)(6512007)(4326008)(6666004)(316002)(66556008)(66476007)(6506007)(66946007)(36756003)(508600001)(83380400001)(86362001)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yH7sPUxqlb8ryYUxRePEPDxV9wbmGVg5pwPRu4a6/qPCIDuhqbvfGzlBdqym?=
 =?us-ascii?Q?cCsDgLU3LVg2gAZl1ms0QGp6+hZfKCqxkOhWWqSZjW9tq3g6bsQlsFS/s81f?=
 =?us-ascii?Q?eOLT/2Jvc93Jzb31A0cgSajrvCBY1Enr42V7QivW+mMyiDuoVi9P7DU0kdxJ?=
 =?us-ascii?Q?l1oCbmJ8Blo1lBJIwFejLPTML9tafb35jQ2Ua9zy0aMwwTAP/QE7LzP1j7UZ?=
 =?us-ascii?Q?alZJraTkYWT0M617QGaH4fOVhh1yHOdLKu/heAZGfHDOJWLY/D5K9nRSK4XK?=
 =?us-ascii?Q?ticji2lIMpKCju12BD39XpUueFo75MUTKE7HuUQnX/a67uttoABA9lRtTK4L?=
 =?us-ascii?Q?fVXMg91AzuxxaIIQJSG1QYC+eiUrc1+J6hmpThEDd1uMvawm7IeQriRbFpXJ?=
 =?us-ascii?Q?ZS6lyiovsEF5xKrn+4Y+1fR0Alk8I0J9I208XwQ98D1aRtn4nh5JNUBDkGAY?=
 =?us-ascii?Q?Q6dCrwxFkC2hDXfjDlaJ++pkY39z1mthOgwZPPq/vfXhBsOz8CLM4Y8iOCnW?=
 =?us-ascii?Q?j+HLRiSAX5F0xUStxNmoM+DecK20mgHsmVe9mlStvDMxnOWE31hAjXMocORD?=
 =?us-ascii?Q?98JXG30675WVeWRn7khbighu1t2X039zd++zIZJtlF3DVYTMdwKMVgJY5Qmb?=
 =?us-ascii?Q?EiOQqXYyphD8NrHE22D1evIofH7cIi/kgCnmLzJkXD6KqLxVJJT4TQJa7Gxj?=
 =?us-ascii?Q?5cF6X1/9UAhYlm184bPqdU7okfeYO7mXYjTR/T80higExZBo30YnusiJMXNN?=
 =?us-ascii?Q?VrqKBLuZnZ/pbDdaXPMCjn3+h6aunKEV5dYE8zu5MYxLLXSxsphrz952XXql?=
 =?us-ascii?Q?QmilX7+ZZpRs6vY/jQdgCYG1RT/9HsgdvikJpsVcxRc6/wa65Qh+ISNZALVu?=
 =?us-ascii?Q?50IsAPYjPcjYeYZiAMrDe1IYMmhdxwFFDObmctoiVIIWiPhw/PFsjk+g5Msx?=
 =?us-ascii?Q?m8m9Rf9O6HJy3J4INQHYSJ0cSkEmy7EU/vGzdRt4MllY7HEmqkImaC7Zz/dT?=
 =?us-ascii?Q?8NrReQMnvFFTZSq8wMlNc0zWgyeNzaGMbfIJJ2BaloCUpIRvT5rIXDLxcw1j?=
 =?us-ascii?Q?k1mweOny6HfhI2c0mXvJ+kWkcH1bdq2trxw5Nr8sXOdvA9m1I2TyK25yYcfe?=
 =?us-ascii?Q?WVlNE8gBQmOltG0FcXNTKARb/cC29WaY+RoBPr+cIMlMCCfnVhDmYNgu5jnV?=
 =?us-ascii?Q?NWTnVhOB7wvUZUZd5OQE2Hq425hBJTiKcVJ57/jMIE7YgkQGZwpag+eur7T9?=
 =?us-ascii?Q?qJ+d2KsC9EH5FDoyYwARd9W+vXif3YyaYubD6fz0mkxj6y240ANuW2Zab+cx?=
 =?us-ascii?Q?N8TLEyTPIDAgKc06vfMKi7Nxk/g8Gv2XRecFpvBb8N0r2J3Jns2BMvvYb7K1?=
 =?us-ascii?Q?Zhy36ZEr4ViK5b5NE/lcr2UgcLG1nmpa2yJcEzd0Qtq7FrfEN8ysVgNtbcS8?=
 =?us-ascii?Q?tp/RCVWxuOCZFnoiU1S4om/xilnTRBxUspmy+5XEWnyekTwkmeEvrv1iE5wg?=
 =?us-ascii?Q?oBgC08DoZJKQr94pJNVcVr3amyQ0TezeBHB2ycnTPkZUvigYlNJM96rY6P1a?=
 =?us-ascii?Q?pT+ztDosfZJsb1k8ut0/T/O+jL6sUpKfHSuOHxFNg9fHGTi1etpsGaAKZMGe?=
 =?us-ascii?Q?SrHAOWjkZcmk3mMRr/bgBTg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9971e86b-97d6-48b0-5285-08d9d43c6441
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 13:23:29.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeYnahpgZWjpUpfCHZpfMTgF6HAQsEwfGEEoMxm/KuhyAQ5YlMyTTESoD4wojxIi8izb6ns/RXURze9VlE33MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3791
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100093
X-Proofpoint-ORIG-GUID: Bdmxi4aTcmZ79BwQVz2cUczlW8XhfZN7
X-Proofpoint-GUID: Bdmxi4aTcmZ79BwQVz2cUczlW8XhfZN7
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
v4: Return 1 for device matched in device_matched()
    Use scnprintf() instead of sprintf() in device_matched()
v3: -
v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.

 fs/btrfs/volumes.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b244acd0cfa..05333133e877 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,15 +535,43 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-static bool device_path_matched(const char *path, struct btrfs_device *device)
+/*
+ * Check if the device in the 'path' matches with the device in the given
+ * struct btrfs_device '*device'.
+ * Returns:
+ *	1	If it is the same device.
+ *	0	If it is not the same device.
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
+	scnprintf(device_name, BTRFS_PATH_NAME_MAX, "%s",
+		  rcu_str_deref(device->name));
 	rcu_read_unlock();
 
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
+		return 1;
+
+	return 0;
 }
 
 /*
@@ -578,7 +606,8 @@ static int btrfs_free_stale_devices(const char *path,
 				continue;
 			if (path && !device->name)
 				continue;
-			if (path && !device_path_matched(path, device))
+			/* Errors are considered as match failed */
+			if (path && device_matched(device, path) != 1)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

