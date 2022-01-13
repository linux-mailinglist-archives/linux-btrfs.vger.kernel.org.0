Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027D348D1BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 05:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiAMEo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 23:44:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43256 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232608AbiAMEoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 23:44:22 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0UCHr001622
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 04:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oz9XcK67XvQTsdz8BQIqCdA5jgNV5E0gx98v5oT8EBE=;
 b=LGSi6ju2z83eA3NVPNqrw8BUl2/T6ftiQmYEJKSxevu9NjNsrNWTD0A/vXZ5nYXvvGnj
 nVbfRl9UFVy4fhSFlEqxeyPGueTkhagYcloYrPWAWLR8wZTQUi4u3kjWlOVLmkILnayT
 TwDjrS84rEzLZFfWTFhJadvaoHOZ8bRwKMp++burSo7oLArKFx4VOwCxFFDAXPlt12Xq
 GuINfmfGOTvx6iZuc9piDvuophlmndLJcxJectSDuva7Q7ZO8/9GxMQTQLDl7Jy4CBDL
 0vcnA2uilBXlCM0yIkRKZoUv5w3H9DAQoHgq5i8koVvqmN1A1pdA21m4w6DzhFE/F2Ob HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdc0egv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 04:44:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D4aXPT141881
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 04:44:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 3df0ngh9x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 04:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa9fHrOuXcAjEUivifyz0VOAdt/OZXdbC2zLXaYiL7BTI/pcUbYS/YPvd9d4of0GuhUK6JGeZxr/MixMbHm3AF8IHRs6PIU54n7Q1+/pSo7PSD01bK+gU2M9pypCTo7pvX18lI4wx148t9Sd2STzqEeTlN2r7YuhHpRNyFwpFutOPnhmF9mGbXumfW1Qj8nciMjVfm8nmeiRaNRk9EtQh+Mr73rKaeIth9sSN/G9gIDkN2Bw9buGMsbbpoo95/fE7FSqQGT7OfNP9WWmTVjUVHTBWXQPZsmu9dTZotJ6+FZ0r8L7ZPaH82UEuhga8zVHKfCXTNPbM/xA+qsb+QiHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz9XcK67XvQTsdz8BQIqCdA5jgNV5E0gx98v5oT8EBE=;
 b=E7OlPYU/l0mU7Zwqus/UVw+ULXg88Oh6pPHMIQVUZjpMW9kAjYjSmAGQzCIRSzRYNRvTKFZJzZBJhRJORM9QrNBMJTJx8EJvM83b0kbSAaZysriGrn2dG/aH23nXUmO0O0q/HF7EG/MJhBOR2foJ36xuCZ02fLWBskubJhw+RA7BzIUlUPflkeQNmRXtm3wl7RhKJtMF03BmcRJ5bhQfuYK7yntHM1wOieQI0l+sUfGjd3Qs7EwXRwRIrlP4rR6o1abnKQIH2FOPcHhH4OUcZJjbPWM2BWz3ZGwPZdPHbKMmE9OK96/W6P9/aAJIYPHq6Zpfya0Ip+gLzcxl8hSHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9XcK67XvQTsdz8BQIqCdA5jgNV5E0gx98v5oT8EBE=;
 b=VYxpsSIcnHZLIOB5aZuIRFD9qadI0re6qvlBCQkhvnAWPotuqpnMhRKhyPIxmuLgIAyBMNNgvVZLc46hwJOYuqQ0CJbYhMgUjfscjXj8OkzWMED9YZNxhblDBARqM9hs/aBiac2MI/BVOa4HnLsjY79/nfhklIP5AhpXwQ4CCB4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 04:44:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 04:44:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: cleanup finding rotating device
Date:   Thu, 13 Jan 2022 12:44:10 +0800
Message-Id: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 113cb44a-3966-4f65-95bd-08d9d64f5b73
X-MS-TrafficTypeDiagnostic: BLAPR10MB5137:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5137037205ED832E23FEB61CE5539@BLAPR10MB5137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8dodzlB2szeOpGWXUGEGf9kckmcVBFBJrYNSkeyj/R2iWVxiQC8Tef8grlQaHT7Iy8FGHywIvmA+Al4MMekmw0xEvLJTi3pZDfpf1B1hpdLH7BwS4R0l9e0I8wHccGHBoj18BdQ+a3GcCQV5NhW12xMz8hOYBdnAIFlmW8uWbPPsF75yceSpR6QZzFmWuTngyPoAhkZMQUEVhTYBiFc00c0A4x9WAGgDFB9H5gZ8PzWB3AFZElwRCJvEJUOguJ/ew1wE2TTyTLqMNveNcmzoBfpDdlmqpBhroDcpRf0lWpfUD0fS0UuXRu3HXr+Xjn/JjQApuArik91XzlCRUS9l6arNEGz0Exl6JVI4MgvKqjFIJBFxuZw28vUDHeq5+HxryPBG1/gPVujDK3UA/utuGv6RJB5O+peWQUPB8NiOHSdYm8YJv+tNooWsBm5zc0S67F2KoKf9yzOjRRFX9LrrYHCrUyLVUXmjTSWevC3kyA4m3YTVDSZ5WJeE2l9h0J09Mgeea0hSFAWwdh/I44JyKf7cHgDWi5i+KISUwh7S2JqMDvvSn851r/p2pRWOngNFPUGqX70+tDWBkdM+swY6HhRJWAW3jIlDVxlb6kFotfz1EYPPpZluvNnSbI4hBKvuWfseTouWdWG5O4RbFVDZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8936002)(8676002)(6486002)(86362001)(44832011)(66476007)(66556008)(36756003)(2616005)(186003)(6916009)(316002)(83380400001)(5660300002)(26005)(66946007)(6506007)(6666004)(6512007)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkPaA3/GulgiiWGQWPicW/9DtkDuH/Oi3Hlqs/19Qt0s72uP00DQAmX0s1Dm?=
 =?us-ascii?Q?EPUllBGd/tdx/1mrV9VtV26Y97hYLgvG1W0FFqE6C/+miC2gWmMpprJK45dn?=
 =?us-ascii?Q?d2+vDwAY4+SkY5i+ufORz78Ye/2BI2IH9XNSGGligBR5OQ5ZGIlG6LJRzhvd?=
 =?us-ascii?Q?kFksjSO1ednsE/TAdJTz+S95qhdp0RPiLEimCuyYt23650JkjzMYIX/zxJxf?=
 =?us-ascii?Q?b4JjkG6PjiJOcsaVg0nuk2iuuj9my8HnlkRn5Mn/JcS2+56ns/T3oiSNGrW2?=
 =?us-ascii?Q?NROdJqKBJszL0yMXO1mU/OAbYiDzZny4Od+Z5kjoaXinVIn2Y2MDI+SX+ONA?=
 =?us-ascii?Q?Jq/fXZffqqeNn3klIX+ATAzlSzH1UVRhRjQ5NeItqq+iGqdcIciSTIipKaAG?=
 =?us-ascii?Q?56MvdVkdieuGXuyYT2axCqhWKP+RJu+QZ+ge/hPj2326Cdn32Bi9HHCiyBkb?=
 =?us-ascii?Q?s/lIhjg3xSGzbnteTTO2lGP3EdKt84AIV0eE6lXcwzURFXext3AXnALgCMBD?=
 =?us-ascii?Q?hgo9Or3MxnKRrlK7qE+OyNclr/UWJOySmxsaVX1h36lWaeN5UtYnK9xylEiY?=
 =?us-ascii?Q?Z9FiWfYagu7rMsG7/EMkxnhldX/JyZWHwwotdghdJG9eCR49oZ7w026CRGRj?=
 =?us-ascii?Q?+Wq8Fr+z6pvX0QbiQNNbJVMEsxygTEg+mLL3cNuRias7emEZ0qkuMCVhvKaK?=
 =?us-ascii?Q?rGcZhmGQubBDzCOHJaoSLwflJz9vJGRaFLRVgeMlCg3KRWUZJIsRxGEPyct9?=
 =?us-ascii?Q?YyuHRLjm/1veEfvrhSsdoZTAfi47yge0rq6KtnQUmI/zdX/WPsoxg5MkMgiL?=
 =?us-ascii?Q?Al3qh7CoJ2BRfzHUhuRhJWI0hL7vcRHYG4VsThR6uCjCictu5PmHrvRMmLzk?=
 =?us-ascii?Q?ubNzbQhFeDILebchfMJ3NpeIE3QdvoRAK0wLSGF+dss+BNN+uw9wCtzcjZgW?=
 =?us-ascii?Q?PIQiNLxgwj+HFJFOxi9wDco8qezRpChYAnKmKHp+OrKjVbX3C5TNAmhl5WW0?=
 =?us-ascii?Q?ZRIoNGzB4mlVvsfEtZn801sEGkAfGbOoUA5JMPnkfe1kn8+GmHbGHoM6ZwSN?=
 =?us-ascii?Q?v5hQtJE5cvVFVaTv43nFdPlJjSNh8kXprnimjwrne1upIH36mIcIzO27o7oV?=
 =?us-ascii?Q?VTuzx+ps+zvKZm6ClLPf/NwPVzCFSN9hmycjVMe1WFHa9gcrT+7xA71C/bvv?=
 =?us-ascii?Q?LtILDAab1Th9cUxYkxURBU3cKh+sfODAuTpHOb7zNo/xcd8rBlks7DnxSAUn?=
 =?us-ascii?Q?lJZaOY6gcXo1epxVRKZcMTcKythOOqWgIgSGstUeNWFM/fI+beogXEUc1AcF?=
 =?us-ascii?Q?ZTYKZtUDPhCQIRd1VqNWa0yyyUhRUWZbacSc1tiGXOt8WdXQyfZYgrQkYtII?=
 =?us-ascii?Q?JA//u+xm9uww61LQxIQkAenAune15VxKL4UApokfE81I83wc5umH2ZkUjdAT?=
 =?us-ascii?Q?tHnnnMpIgbm8dUj96h18CwFJw2SlEMrxMX0KtegTV8Ox7cnstfHtzah0KXaS?=
 =?us-ascii?Q?ICT1fP/n4L2tHaxEjZXLhoz81BfTOptb26+Yc/1UL3e6xPgMcRafK7E+hhW5?=
 =?us-ascii?Q?Tf80ut1vvvDdO7kQ+9PMu9yUNCZkMhI+F5ijujxcQUQRuY7nrtbBWY22Lvlu?=
 =?us-ascii?Q?LKpcN1XEeouhlhRU/y+B3Po=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113cb44a-3966-4f65-95bd-08d9d64f5b73
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 04:44:17.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTqHIZesUvy4/xEQ+5a4ojQQoeUauhqvy64LyP/1LRE7OJdMPJKUq/fy/VdrpnRu/LKRn5GGF+yQDz3OHkS5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130021
X-Proofpoint-GUID: IE44MRT2c6fOjQ9FCNwUpb2czkCQk5jt
X-Proofpoint-ORIG-GUID: IE44MRT2c6fOjQ9FCNwUpb2czkCQk5jt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pointer to struct request_queue is used only to get device type
rotating or the non-rotating. So use it directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7e92bf130137..68ea15e8e3cb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -609,7 +609,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, fmode_t flags,
 			void *holder)
 {
-	struct request_queue *q;
 	struct block_device *bdev;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
@@ -651,8 +650,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	q = bdev_get_queue(bdev);
-	if (!blk_queue_nonrot(q))
+	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
 		fs_devices->rotating = true;
 
 	device->bdev = bdev;
@@ -2600,7 +2598,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
-	struct request_queue *q;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
 	struct block_device *bdev;
@@ -2676,7 +2673,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error_free_zone;
 	}
 
-	q = bdev_get_queue(bdev);
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	device->generation = trans->transid;
 	device->io_width = fs_info->sectorsize;
@@ -2724,7 +2720,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
-	if (!blk_queue_nonrot(q))
+	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
 		fs_devices->rotating = true;
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
-- 
2.33.1

