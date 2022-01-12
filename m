Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8948BE09
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 06:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiALFG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 00:06:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6824 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbiALFGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 00:06:53 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C3xOuO025170;
        Wed, 12 Jan 2022 05:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Myo70f23a2NbM1p1C4lKxSsNuF+s/7O23hYnng5G7Fk=;
 b=bXAVfnjvs0jaLVJeuJrZccSvuT5ktCWl8O13c6Pxvos//ZtZdcG3/obSRM4KqM7iPXaq
 eEKCvGBhnve/NKZMIhU4WRwDj6qZ4V/ykZhHBmTfQ2VQ9IeNOuLQUzQveB+dRYRxJ3UR
 gOmQx7FiaTV7q+aB+/pkKHeqzMCSi0b/22wzY/uy5TFFLPvSJ/a0PdVNFZ1fVIpfcbAv
 fzsoI6mv5LBJZmALLgsg+XZ7yb84IsdR/TUpXDg/Bj/q9UBaB3aCKMx3p2fE4mnkUYI2
 dqU++l1iEJzatEZbHa5cP0p0vFl8jL3z7/EkHxJhff+mqo6BPiOJGHoTZz5uaLaL3AgB 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9d4gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C56TE9178739;
        Wed, 12 Jan 2022 05:06:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3df0neyntf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RImPwFDR/X0iVL4J6MdaQIANm2yOXGccYuO6FAdKPqJLYWVEF4CnP21Uxe5BNQtQA+zreoxMY7Z7Tx79PQFQbFTA1mIr4lEQAMpYRI9LNfOlP/PfsivrOdGRNYrZvwOmvX54JB0Xnt4CbIWMUPTNyu0dEVCsVIK0djCbjb8x+iUnom01MXytf6Xj6DttXBRIbadrbUTGWhVCFOOBSH1aNCMiYBd3C9nbg3YTqfC0RJb4BeyEnSSeWu0Moa601yb1tUSC9EdFjT4Sa3RzAXFENRw7eytqHzdTS8Aw4DxbpOdwmDQUvbn4qbCxOrG7tagBgqOM3aJrJ63OYnCM8w6g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myo70f23a2NbM1p1C4lKxSsNuF+s/7O23hYnng5G7Fk=;
 b=FeFWEshb7v0u5nCUH2lywx2hSQs8CmbcpLg9Vkd/P+yR4qUcUBTZTcVWU9ZwUtdiIG31WEJ038JAcmgNvIPqACzKR3I8sVkrO8qBmcNIPD9dTEVbeM+ZMs+It8bsUpvauK3Xy+rXdb10PgVZ2qw3aL1mrnrf+BCz7QxdJAS3RzRKP7u8NmTTD/0M0BkEHTuEg+7tioW1bLVQBfw9e8swYTgWl8TIzGkTVGKNf5BMMYsR+CUTKbVdGdRNDSahDo83pyLFlyN1id1oNmvqizgZhO1LX/QpF9Lk2SUeMJeI6aAzn0+yZ4XV90BQoiEAtLFD0HVnHISl4q6KZmxxWy4VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myo70f23a2NbM1p1C4lKxSsNuF+s/7O23hYnng5G7Fk=;
 b=BZ5pIZe9M1qvsqiwpVW7UxVOtABCWI87OAVtm+3GvuyN3wMAZQiFucSyc0tIHpWA3zlVS7wjMIpPi7k+Gff7RwSxD/qDg71REVSboGlBMSPFMVCw12BrnZ2mHj33Ccq+NV4MJkyjz0rnDWe+qmkjexPY0UqJvL1y+3ab3bZ3Jd4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:06:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 05:06:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su, kreijack@libero.it
Subject: [PATCH v5 4/4] btrfs: use dev_t to match device in device_matched
Date:   Wed, 12 Jan 2022 13:06:02 +0800
Message-Id: <7cafdd3a0183bc4e14a4c418c1cd220230798a8c.1641963296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
References: <cover.1641963296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b358368-3bcf-48b2-3071-08d9d5895362
X-MS-TrafficTypeDiagnostic: MN2PR10MB4238:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4238A31544E82215C66E1443E5529@MN2PR10MB4238.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8zV6voZHNwUz7RLSAE23DS5gTtjXJq5ZUx6VZAwAq9WQVhv8OfUcpHtZcjRqmo6PEA9wKxm0TK3HvugCYhLGAusJSqyDHm63i3z2KvKNFgCA04urLq/7BtcYryS/Xi40vk05VrB+zt8kvHMT6tCZQwVCD5tXWj/3xG5Ef20Vu0mCBhSQGVxht6p+8dGB7OyWUwh17kwheIyqQJgF1xxFKVBpHSyRuinF2YUtFQDKhlifCWR0DHKp44F3ubF7Dxaq2Kzr+Zs58kj/bB5Nh74fQrR6Vmk7OFI7or5FEJji+jN7odHaRMoL+DnDCYcoxWzz8GKnzmoXfADOtuA4CbtFHrGM6MKr3aXdOOklUmwPzM3mVdy8FyZa+jOnxcycHXQfrAv9aqYtWGA5qEDlyg0mYUUGILCy1Mywo/DH4C/XjeDIfnmmtzxpgc0lPYa0o5oLNO9KM5Bo9BT+pRW/bhfSUvOvGfvOmCA9/LOraOS9sVhrPUNt/m+RIxJKssKUR8hCtdr7f+OXSJXPjbAKo1GRRnsEl2RDpVkMAlyUUv2GnNJXESVOokwhK8gbUhWo9J4vBmapBu0H90hI0JGekjdq2mkVQi76zzeQKyQhf3V4AU5+Y9uRS8fEQBIUd26q4yBGpCDQJsSuf/mNS3xLxcIoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(2616005)(44832011)(66476007)(36756003)(6916009)(83380400001)(66946007)(8936002)(6506007)(26005)(8676002)(186003)(66556008)(316002)(4326008)(6486002)(6666004)(5660300002)(38100700002)(508600001)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?taacMhGYisRJEwr66E7eWtXowrQW5G0NqxMnjpOw18JqCANM6ohmKIuBn4dn?=
 =?us-ascii?Q?r4oCSoBGVUH4KPONwqFLahyy7DkgNbiTrKkKY9DcC9y96XEe0feh9H5/IwlZ?=
 =?us-ascii?Q?cE1yISjsvoVKMcEkaxaU8SSoH+td2rvmUWBEcoWVi3/WZ3JwDuoXUYk7fIfQ?=
 =?us-ascii?Q?maCg/KXzpvZKmPPibTOOdLZFveGdWjPoL6Uyb9Pa4myemEkl1hxeVJCa3ygi?=
 =?us-ascii?Q?FG49Cg5KQGnP/BVrMRbYV8lIViJxtRxjGKZfD6svliQ1EhsX2P+wn3XbUn2y?=
 =?us-ascii?Q?AK5tOSkSyXmmlHJHJX9WkIKZd8bCgnGmsF2TdzlDrGmBci/v+I7gqNf8s99+?=
 =?us-ascii?Q?8aNwE0Y1paTbh5++T4L8I/njUjSRdx3+n4fuL7A4YrcoPWlobKD2V/lgNo/0?=
 =?us-ascii?Q?Jha7AnWP3Wx3hO9zVpZK7851mWJ+el21w6xEEAq3hXVnWuzE++811X7qZo0z?=
 =?us-ascii?Q?q1ZtbndhrajBj/duWfrEjTsvK2omOmc8molMyMLzOlSMTM4WnHOCF2TKfyx8?=
 =?us-ascii?Q?qKjOPNPsY3Opxz0RCfoFEj5AZ5sTG6QmEZxlPBzSeHtU7PQJnKY5XzNzoLnd?=
 =?us-ascii?Q?zBb3/LoS4DqeGCLiBYUpJpr6UultQ4Ha8jFPowQcYEy0bZH2pC+9RwdxHV4f?=
 =?us-ascii?Q?I026DUx2hoCPIUX7ffkdkrv1iMhCzgsRhb9VbF4tqLF0i9O0kj/tFGHttWuU?=
 =?us-ascii?Q?0WFwPdJQeu7Vj+OD+wFKkYzN4zGHxDVSoo+gbNCPy3sRuJfwQ98M7vgfJifs?=
 =?us-ascii?Q?mEKJk+sOXXsHiPudmgFmV//Syf4KWLxuzToY6+ggAu5+gIGSmk5v8/tgEKd2?=
 =?us-ascii?Q?ivWJJz3+aWdGGI+h+RCzvNJW1vGtuIRisTyQK/qNULc9uqKsS/HCakGVzYvg?=
 =?us-ascii?Q?FAMqzQ5GaRjluvD+69Hgz4/9OxRmg5Q+qCs5yYMN/wzjt2Wcw3oNV2F9pKm8?=
 =?us-ascii?Q?lsmtfbnUzIGh/53XpOPmmO+i/H1pMYuDiMkj4e6JE5/1DLyP13GuoFqkdPPG?=
 =?us-ascii?Q?KgwLvF8h/QQk//SuNqYDBWNeXR86w5dOSeXuX6E+PUuXx/5zRPnXhy8I+JpW?=
 =?us-ascii?Q?JERS2Y83Pk3oDZchCY9N+VJaVYFWQJ4e7s2t50n7+4wIFOQwiCuikgDntwHO?=
 =?us-ascii?Q?cmAXbU8iEaH/SBqIoQOGGId8Qqdn3YMEFdtwbkSScQw5PRYQ0zeJ0v4S14py?=
 =?us-ascii?Q?EcfBvK/PZyP0kW3vTCmop6ACqMTxE00sF7fr2X1RIjXHUPM42uMQkb+wgjpy?=
 =?us-ascii?Q?987Lq9DmcFlaLlo5x+Xfe4rRfnG2ARWkuynuXtCnoJsB8TtDPv+YmivDRicH?=
 =?us-ascii?Q?9HG1UY4c5p636FGDP/8b5eZANmF8SlBP/ks2c5iHPynUC8WdM3Ze6tq/mpTn?=
 =?us-ascii?Q?8eBuB9+wld1JDbVzaz8znIdX2v1s6ji5sn3Jq9oQ2BYBPRNWY4TVRzN0N/1a?=
 =?us-ascii?Q?apck/CXjQpqL51GIS8Fc2eXyGLg1BsPjt4001oYNN/LP16WSzAXZBX4A9cQ0?=
 =?us-ascii?Q?XdyXcM86jfRF3mrsHjgdBs4PB7QujkAugOOIOhzHJDJ9sty+T1hM+JWhMBL9?=
 =?us-ascii?Q?htVu6EZn83+02o+ZoFY0oJw14TiaDDk58v4ggu/rxd5f+Fo6cKnmzBgWJjoZ?=
 =?us-ascii?Q?/XP15hjuQGUl0AhwzbBeaLU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b358368-3bcf-48b2-3071-08d9d5895362
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:06:43.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03OgPOTQggkfGaiPIUTGW+T4CjnCT0pxuo6gUAqx+/Gh0ehzDQAKgKJqwfd8KlBOICEj9iMyIjANCb7TgJYlpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120029
X-Proofpoint-GUID: TjXeIETdtaOUxNvaZog2k4n4A0XRNU4R
X-Proofpoint-ORIG-GUID: TjXeIETdtaOUxNvaZog2k4n4A0XRNU4R
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
v5: -
v4: -
v3: -

 fs/btrfs/volumes.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5044b8f9cfff..87d53b3a3377 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,46 +535,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-/*
- * Check if the device in the 'path' matches with the device in the given
- * struct btrfs_device '*device'.
- * Returns:
- *   true  If it is the same device.
- *   false If it is not the same device or on error.
- */
-static bool device_matched(struct btrfs_device *device, dev_t dev_new)
-{
-	char *device_name;
-	dev_t dev_old;
-	int ret;
-
-	/*
-	 * If we are looking for a device with the matching dev_t, then skip
-	 * device without a name (a missing device).
-	 */
-	if (!device->name)
-		return false;
-
-	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
-	if (!device_name)
-		return false;
-
-	rcu_read_lock();
-	scnprintf(device_name, BTRFS_PATH_NAME_MAX, "%s",
-		  rcu_str_deref(device->name));
-	rcu_read_unlock();
-
-	ret = lookup_bdev(device_name, &dev_old);
-	kfree(device_name);
-	if (ret)
-		return false;
-
-	if (dev_old == dev_new)
-		return true;
-
-	return false;
-}
-
 /*
  *  Search and remove all stale (devices which are not mounted) devices.
  *  When both inputs are NULL, it will search and release all stale devices.
@@ -605,7 +565,7 @@ static int btrfs_free_stale_devices(dev_t devt,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (devt && device_matched(device, devt) == false)
+			if (devt && devt != device->devt)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

