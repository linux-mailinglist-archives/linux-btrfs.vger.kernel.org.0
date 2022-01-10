Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423D64899BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiAJNYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:24:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8776 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232017AbiAJNYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:24:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A9gCsq021295;
        Mon, 10 Jan 2022 13:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qJnn6tz9oS/jszKVFFIgLgb2a5HnQIIxi8t8TVA7wNw=;
 b=tMo5DxptNHUG5dzuugR8vIXUBlTnkQlmqiAbf207qMQ6rbVGUKdBTLD8/hIzrSv7E2V0
 xs0p26w8QX99lCRAxOmhTZE+N6UdB75yEb2PaX+B+po8wNCxX1HfP+kSFil4wDIvaHzE
 dJMWC6kWD4pwWk8sXkw/PD/Dis7BxIWrxXzurrH9++4qGDDg8cetrFM1HX2Jk8m0+Py0
 reEFU4JK7hcNwhZPGfxzSm6jc98kWzCitytEp6dZOUeJchs/X0gn7WdXrEc8v8/n3ESU
 9IzLDgIww9vEKZAwfZYcbIeTmJ1Hc5FjAQWPHWB9JCKBDciYHq+q86mVn0ADW2HtCLe1 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbrf04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ADBta7116495;
        Mon, 10 Jan 2022 13:23:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3df2e395ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn6sGpM7smqYLYarWhz1jo3W3asujPHfdghIjQ0p/wUB2vYVPrpyY3/LgSPJxCVYXENTnpknzcw9ZAPq5hqjNM481HzsReSUxy20LKt9D8FNDzxwIwDLhAfu0VoRTcwf34jTGkALo2y2Q8nRYplLQPe49ZQ/zcT4Cy+bZNlQ0MdnsKfeAnEhYHplmUgCToxGay53/FXnq42F3/k4pZudR3axlcIE5+TXwy23TKTd2p10MK44l8RqCNomp6BthSy7RvbluZugpmZSXRKynw2UGIvHOeu7LAz/10XBYaLT7qfqTMfMn/8pzvNKZ1izfTxGz+WY6a2uwZ8XdlOrqtWRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJnn6tz9oS/jszKVFFIgLgb2a5HnQIIxi8t8TVA7wNw=;
 b=Y+oL7Cw4v9N1ljoAoaWsgtTE6YmnJrpEbxiJeAiemKhz2qEGInk0IWHAl952RQWtEEmrkXNBRRnNNwX80hDVZqhGEohwI064lXpRbld/G5dkBaN+vs0q9/dNkjk7DU6JERMXBdp5QQlGedAGaRCLaoc/yZGojYAaQNGuUF7qRpxmCVCey8sYIKenSl/eMgTuoyP8Po7VQV+bfIKkoRNRjTd4sl2ITy8sLUJrfaNBYgRvmdGHDVYtObf+uz4DulbeiKBlFTJ26BFYx4ss6IklnzRr4HoMbJCvNRc+hMnHPIvT/lFPlcm8u+Ff+HIF6ahXa+lfCVL0gC47wnaquGqm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJnn6tz9oS/jszKVFFIgLgb2a5HnQIIxi8t8TVA7wNw=;
 b=DXrHHFIYtXFVQNbX4exDmK29VcHyLN+vmV3PK8KnV+IWK1CC4Ny5NBsWhs70c6u8PlDOtt1sosxUV35u7dH1YEA6t2mljBSvWSJzK+CqUiXvBVXZLyMyFoASiWgpoAIaWADxp9hc+aRvFOFNzUIyuzBi7MjxHm9RMO/50TAB9DU=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 13:23:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 13:23:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v4 4/4] btrfs: use dev_t to match device in device_matched
Date:   Mon, 10 Jan 2022 21:23:14 +0800
Message-Id: <c48fff4bf06c28bfac5298260fd810e152245797.1641794058.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641794058.git.anand.jain@oracle.com>
References: <cover.1641794058.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1dbaaf4-0730-4ec6-6b53-08d9d43c711b
X-MS-TrafficTypeDiagnostic: BLAPR10MB4852:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48520C3FBA83C73A8257DF97E5509@BLAPR10MB4852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SF3HGZaUAtAS7nH4v4oIcIid9spM6OwusGCvkCwOX47zWCw/XbPvwvak+agEaEXD18q/Ply+poKpzSdmbte1FFIzJkMm567mFN0kInyQIP8xKMHq8xGqmT/KWgBCKsu17O9/rDMbjwjMbonAbiwvwI20oVIxHAyMlBR25Sf8wZZz7HnU+fuJhXRa/DSiZYg9akYjwxM7/rlKe7r2USDouwBNgbqm7Q/lsF07zLvyzyKTcVWAvHjEFFu+6kylNPj6Td6NJ++MIFBQSCJX/Hk0EeI4LNpSN2lz5F9f/rACQpgwxhcRtxLuo6qUOBidu+k4GbRza5SDjE8scetGr242UgtRbJEbrfzfpHZ87ipRoQJEHFhI6bfIr0c2Gxi48nZe+8Mo9JmxZDDpph/TFCCz+O31nMAAQfGc7fPZSZcbbrThF1jgNYTrOXA86MnM36PXIaTi2lEF/y9qolabOoeH5t4Kj4BRle6cVBC+i1r6BGwdeKu3bbm4AvKtVrTUl9b+PIcZQ+5WgcuqQeM3SsN5mXPkXaXmFQx2aWZn3o+hJuDAjvrwgKpq18ylxwtIpqDH9Uwhvaaf6w3ujGmq/xtJYnLbmwWLLTL/JsPw+JigmdQujxVCxblZnQKL5mUAobgPogBcclc2e7UkrXm11jxa9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6486002)(44832011)(36756003)(83380400001)(66476007)(2616005)(6916009)(66946007)(186003)(2906002)(66556008)(26005)(38100700002)(6506007)(86362001)(8676002)(8936002)(316002)(6512007)(6666004)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+LSycVEjCNDcZ5c1/tOYziR5fY97XTnxaz95S6dxRaSTaPqHM+CVpzrda1V?=
 =?us-ascii?Q?kD4iAQlkmdQ1E5DAVrRcy+FLuBRGwcdU34C/kKFZ0qdJQNMR3ZL5zfcJSx4U?=
 =?us-ascii?Q?fkD/bvPn6sIvBkX+8toMslhqy8Xd8i1T7wLuH7c0+vXVCmTiesTxfNk0M+ZV?=
 =?us-ascii?Q?BugDmhOimmhR5XOK9NNF1zSi5JEY3WFzIFx8HGBlgGlN92PE/c93DMVxIOxX?=
 =?us-ascii?Q?jIXn/mqykyulutdW7FmAjelyHQZ38JSWsmgizF16oPKjZoyFRGT9TQNw5zP1?=
 =?us-ascii?Q?EgMqAcZ15Qt3EuXVXzBtqlFTCmnvLErs6n6x0AgXF9pCivR95dtHVN4JrDBm?=
 =?us-ascii?Q?6oVJ5nHD5DqF1zHCd/Cvg8FMYSk8q4wsp35rsbAzyZhQxa+3o8jmF5r+OjFh?=
 =?us-ascii?Q?sxEFyBFo+kQnShE4C4iFDZNaCUYi+EDHeEoLF0jdz+Klk4sFwV3wZRTXWcPp?=
 =?us-ascii?Q?/j3xD6t/Pm48tSL7K0/UoLVXnVmFOFc0IDKxDhyfCmcZOn2zrFCacgBgJLC9?=
 =?us-ascii?Q?AHTrzdfFwNVH/QP0gsVqCRcxFZOgdCQpcfcKB3IqIsdRHEy8K7HONcxmDZVr?=
 =?us-ascii?Q?lc8IwwZRE2aUVBA/eThc1sGv5PxrE7v9tffJRzgAmsLWA8+Q8K8TlrkUXNT7?=
 =?us-ascii?Q?2z0gSBq2SUFdxWU7qImLZqKLHtfmo0MNnSP5E+np55oLGlf/sIMqGHtM8ZKL?=
 =?us-ascii?Q?61SDidz0+hoLQAm4WPmS1QxTDUxnDvMoTG3jxf5vodHnNL26H6nHPwenU/xC?=
 =?us-ascii?Q?5QzZpxAEZCZuWIz/MQGrdnKi+KYWgaT3zKUNwLBuCusEc/pVrMe6owKV6c9X?=
 =?us-ascii?Q?b/Dq3Tj01L5zzzgGtFlglaHN5s913e7EytXleaOVKRRPn+ax1GQZyStmcvQ6?=
 =?us-ascii?Q?zYpiUscXT/mUlXrfuZ+cOYVRldusqA14PWWwVurHPRHdrwOm+8++LNn03+bn?=
 =?us-ascii?Q?UhPPpOIryoS+qKR6UuZiBK0XDWDqahlj3sgIJIfldECMr9Mx/qI9O1BsosjH?=
 =?us-ascii?Q?Jr9z2TRNrhUSikL2RYUi23oa8O/R+tuo4ZgHDPxLkIwVuKXCsnnaTa9xxJT8?=
 =?us-ascii?Q?jPk4BI0upLHQvZMWJl1pbxUf1io5TZ9jaMvCS6HR9v51MDcfDeMmAzpKDpsS?=
 =?us-ascii?Q?/WHMBFwYHloQAYFVNuErvuz7e21ob1LreweF/VhcZ2xfagur8Wmi1rJewbPl?=
 =?us-ascii?Q?9PG/0cM3DRDjG9vMEFkHeiRfyJAZvM9XzZqb/8Ns6bVXRJNwLV9KuN9SQxoi?=
 =?us-ascii?Q?ghsSSnbHG4vQycW9In7tdm11PzE7aaWu/icUGn1jA0ScpSmPgNP8Wt6WYRO3?=
 =?us-ascii?Q?xKzdeFmoYksVowhMs6O4/EfEarRzOF6hEejfMnQMfxyFT1TowWopSeOLj+3K?=
 =?us-ascii?Q?wMIawqqRBWrMkVY8iHAehHWkZis3oN2ShIJxD4TX8C5LazOetoraATAmRabM?=
 =?us-ascii?Q?gzOGfMWJVwgrAvbGdwA1Hkz8QlJzmp7u48ZL6ZIObF73c4uomOdTy1J75LEp?=
 =?us-ascii?Q?+qJwY3vI660LOWfOhdo//xBIkvCnN7KLmSGIWKS/1qNo0wUIf3zIrK1VCZup?=
 =?us-ascii?Q?kpo9HSFAwQBC+30k9AuXquXb9urw/PjO4UgWKiOMtHjKLQdeF0leAKhcXwY8?=
 =?us-ascii?Q?Dru9s0g4Bkn/UbIp4A6RFlA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dbaaf4-0730-4ec6-6b53-08d9d43c711b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 13:23:51.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIpJM6CWcT2IEpTTMTpoiWRbYMhp7cdl0Z7uX2GuUMJCMz9QdExqtlkFZBoUZaWovv55V2a49OL7ujPCSQwuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100093
X-Proofpoint-GUID: TnRT6zLpTzAakfbD21Y4X4kRi6eC-lcu
X-Proofpoint-ORIG-GUID: TnRT6zLpTzAakfbD21Y4X4kRi6eC-lcu
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
v4: -
v3: -

 fs/btrfs/volumes.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9eedf8dfac02..7834f7d18293 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,40 +535,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-/*
- * Check if the device in the 'path' matches with the device in the given
- * struct btrfs_device '*device'.
- * Returns:
- *	1	If it is the same device.
- *	0	If it is not the same device.
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
-	scnprintf(device_name, BTRFS_PATH_NAME_MAX, "%s",
-		  rcu_str_deref(device->name));
-	rcu_read_unlock();
-
-	ret = lookup_bdev(device_name, &dev_old);
-	kfree(device_name);
-	if (ret)
-		return ret;
-
-	if (dev_old == dev_new)
-		return 1;
-
-	return 0;
-}
-
 /*
  *  Search and remove all stale (devices which are not mounted) devices.
  *  When both inputs are NULL, it will search and release all stale devices.
@@ -602,7 +568,7 @@ static int btrfs_free_stale_devices(dev_t devt,
 			if (devt && !device->name)
 				continue;
 			/* Errors are considered as match failed */
-			if (devt && device_matched(device, devt) != 1)
+			if (devt && device->devt != devt)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

