Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB6412DE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 06:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhIUEfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 00:35:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhIUEfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 00:35:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L3TVGQ020314;
        Tue, 21 Sep 2021 04:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=gCBKuEI7gIAEN04DC1nuUkfU4k8ibAYUhMeMZAkK5Oo=;
 b=iVoBpJPjy/uW5f9FmMaYQ8qNsOuaVsv4hbZER9z79bGoUELjtRtz1tEEkbas88M2rPzk
 8RrQ4UZqalsIqKoTE9GFySc/V8sjUdMcY9wPeHVhbyGe4mkBZTb7PTmD4v1EVPghQnpT
 JCr1fKOdpexhM+LXiNeZg1DIJRwNq0XqhDsqbkZytLR7t2DjDY5JYUKBX/Epu8shI9jY
 ujd3c6OvNTHc4MhLUJB3vUPhJnuGc3Orrmo8ok5qaN5pRwP3WM2rvNCCO5RiYNDWX3K0
 t4kxYp2kC8+y1yaUOeq5fQE9O1gz5cL7ySDs/rMqV1BHT2+2bo97fiA0lk4j/Zx+rUHn EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66hnnnh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L4UkS4043556;
        Tue, 21 Sep 2021 04:33:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3020.oracle.com with ESMTP id 3b57x4xkjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF2MyEedzoh3xUJXQemaPPOgNFX982Eko+gb4JtOpWtnsWbTA1R2JeLwD4BtbDJLvfFJTaSfmUq+NijMXCi0fnjF9pDh9tyjj9G9LmJXcivt5pwwzcvxAoUZANTUR84FcemNp3snweBTZnj2YzzVnNjciBk1m24Jk4wyQLyagQ2eHes8Uf/gTc1dIEGXOvkuakkpdeVP/13bN0uN7pFu5rUO42fx4M2hvCypo4CpnLI5ZaNrQ1/jy7FAaBCGnvduDKCN7mkbrLYbZ1x/u0KyfB129twavRaBC92IbIURzbm41caOIFoK94ZWBY3K1pBddew4B2s8OBLW2p0e6imqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gCBKuEI7gIAEN04DC1nuUkfU4k8ibAYUhMeMZAkK5Oo=;
 b=BTEhtbtYBP4b83OVaVSHQFJRqyLiyzRFElMCd8vY+Dgl9ARwtHTi+DynE5q5Ce8F/YOEWZOgYfBoJoEhrlDYbqWh24Zebk2rVFQcRCoAwMdRRQq78fIyWiPvNpSLom4qIPYiJM9Tuwmf3Uk720wyf11x33XWl/S4aqCfz5VErqEdHPyJcVDJXMnVRvgDCHJ1pgrka8XqbCCcVpdSdlEVX5qCoRv1nMufgoifuKvVQq0TbLCmO+CKXpqVroyqyBHh3+caOJlN4hPQBuv+V8XvZ8gFg4AssHchwnrLy8ZcY0NTx3/zwVTTyezWySBnxssu5SQELqkvyLRoWaewiWzKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBKuEI7gIAEN04DC1nuUkfU4k8ibAYUhMeMZAkK5Oo=;
 b=JRByWhD9TsuXmFyeqFzUoUNT3XPxZ3gnivSahen88n7sX+d4tPiYP1rCI/aBcSgcidbUWfVyaTTSrOHMKoAgICed15u2ewYUResE0eUnS0RzU18imN4WFBOYSDh1I/u7TOJqTsuf1Jv+PrbAAyb7hfNcctD9l7TBgLY1jxX0TKA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3984.namprd10.prod.outlook.com (2603:10b6:208:1bf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 04:33:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Tue, 21 Sep 2021
 04:33:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v6 1/3] btrfs: declare seeding_dev in init_new_device as bool
Date:   Tue, 21 Sep 2021 12:33:23 +0800
Message-Id: <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632179897.git.anand.jain@oracle.com>
References: <cover.1632179897.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR03CA0129.apcprd03.prod.outlook.com (2603:1096:4:91::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Tue, 21 Sep 2021 04:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cc7794-7c3a-4b24-ae3b-08d97cb8fefa
X-MS-TrafficTypeDiagnostic: MN2PR10MB3984:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39844988C181AC31D992BE6EE5A19@MN2PR10MB3984.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3I9g+OwOUHIrmqtWacP5Ys4EnogBWI689E8X83/1AJnMnoKZnzgBr7Z0yU7t4ykSVCNEfMYUl3KYEbXgw3R4xCaOmZ7Tc3BT1bKkcMjNqShhyXWCtyQJMcQTNhnmaHclHhTEWtpDCAxmWyy3VEGbroXwNKmlm5DTwho8OTqmCkfzKuS6JsG7sBc89PUuPRlvdE7L5Nh1NU/NYKBRfdNDAu2jwwrypcHI/JqCm9eg1/J6K/jpxtSJ4FSFUPAep8nbjXj7VRLFOwz8QKR61Upm0KQ4rUNlazfcORTptF55Z1aQOV9dawbx8w1Xr8cQ5dJfZ6+sK5z14bpcEBUTHmVzEioSr+6+v8rbg4dcD2OfG345Oa7QkVWmrpZ/6GaCi0YWXUPl57MUQJq/p7uPFENQb2Pfjj+N8KLGsGMetrelCzPZO3sTZ2E/O1WD4mbvE4/hPV5DDd88yQJNRnhlbbv9Cykn4B/Sul+UsSB/vdHpBOEM54Hg0JPs54vesPPB7hXUc9Q3rJxySGcZkfXno+ZVD0Ux50SJiJnKjRlplugCzZUpoK32ZKcKVUE3xA7zSM1HsDTiEcSW1ThZVIcWfa38XCfjgc8BX+GoLxGps9VwCLWvEfZ4q/CVRulxlFSOQzTrK6aB+CqL0tHAK+o1lPUe3Q6oK5INqK0b5RSiKkMcf/EXYMvM2BKkwM9z9imyAkKHnJms2z5XNyK8O7LUQPb0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(52116002)(2616005)(83380400001)(956004)(478600001)(66556008)(66946007)(8676002)(8936002)(6506007)(5660300002)(36756003)(6666004)(6512007)(38100700002)(2906002)(38350700002)(316002)(26005)(44832011)(186003)(4744005)(86362001)(6486002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yubR7hftBOhbR6RLbLZDw+mNdaYLRULEkYS7FIqAje1Hb0DFElWzuWN8A6id?=
 =?us-ascii?Q?J95Afq/qGgNuRMKrj/i/vLnF2jGK8k85g/wTObAiOKx0dKv3gTwFQBG55Acq?=
 =?us-ascii?Q?I/9uJlx4fl1wj2qFvlWAnzKaTVn6RYpEzIp1vaBvHhVWjdHcSQu7gwxUpQTN?=
 =?us-ascii?Q?8PqE20/nruPR+SDl3gD5ttaGuAlVaNkcYlAUqW7svCfjv5TQMStVuyWiYcyL?=
 =?us-ascii?Q?Rb4PyQUXjri2Qw+xSsv/70RwmAmOj5PUaCcWdFfPEn7RMMGVDYzXbXS1qdyl?=
 =?us-ascii?Q?eNxYHCuxKIhkvwj4Y9x3Ks1gtzWQ63tdSWyuJB3b4YbNofjhg26R0xLx2naR?=
 =?us-ascii?Q?otqr6/MxCYucZ0dDjjovACN4XCjTZDwgJdLi7BFF0SYGF6sCUgLELo3ymAQ8?=
 =?us-ascii?Q?s8mMOni1WdJo4SFJGXim7I1VNI1Hx71uTVltgX5HL7ZXLgG6e9ergrn0gJQo?=
 =?us-ascii?Q?pCTtHHUXJy/nKhuDSULv6zz+SS/5H21MSo+JsGcDCZ3esXQEQvQ4J4VfOz3U?=
 =?us-ascii?Q?tEw75i2f1wIkEaLQ4kK/Mg1KhhAiUig6NntrWR/VwZMk+juJ80doqPOr9Bae?=
 =?us-ascii?Q?vVPbNVPz6Iz5qh3Rb6pv5udw8jaLp0PrIerDtRBVqYXTgvMPr4a50aM/zlaq?=
 =?us-ascii?Q?81KhmsgGwI3eaT4ceaaQS4LVGuXn7qpGyko3bus/S50IvLfP1DlCBNL1PBbz?=
 =?us-ascii?Q?94b2bWRTlh1dcr+7QdMRIxJC8aSj/VG/e2dpUbEfSdCWhGtUzhd1I8F6GMlT?=
 =?us-ascii?Q?E9da1/ukq+nC/xGC2V+Xi5lgJtR6KgnGwYra+B4LwIcoGddL8Tb4wGJ9MfcY?=
 =?us-ascii?Q?J3rutoAKaQ9uT/OvL7gfGnAF8iJkHJDIhCszfn3xtDwTYOnr3njUi+jovWq7?=
 =?us-ascii?Q?UjOIK4n/NjEiBHC7lmxaabcaBQTkQ8yKpcJEGP9GaA2I00xSu+et9qvHjXlL?=
 =?us-ascii?Q?DMuyPDhcptcBc7J0AXX5O8H2/UlKV0xjaFheu8B0LowYPssiEssqWJcFquyl?=
 =?us-ascii?Q?Nq9lDOAFz6xjQ/RIt/+7pHyqKPW4uf87nsuIBSQiFd03yUH/GtsYAXocroRf?=
 =?us-ascii?Q?AoVqLWPWosJj7XccVpwJHk5Jiw4YNVTdBwOT1dDXts0Wmhty6WPvWDIp5G8W?=
 =?us-ascii?Q?g9XGi9q9SqeAupFPQZiXD2652XfRejDiZq6sVfRNuPC32ojgmNdLJF0xp6Qf?=
 =?us-ascii?Q?40mmDHQrb2+2bl5vlzLd5KHtPZqml0m2UmfKTXMHHaRPbHOiOqVTWlhb86bc?=
 =?us-ascii?Q?cjZkXuRpIoOBJ/oAfTbpi2j3Mn4FXvCb1bpSDBQnIF2PxX1AznUuAT53sfLA?=
 =?us-ascii?Q?dsvFRFaMEwCtS9t+PXq6zvlF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc7794-7c3a-4b24-ae3b-08d97cb8fefa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 04:33:44.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bIN8axKbdsjViQ7r8aF8+S8mu+kiyTMLMXxtua7CREh4CBwWCP8/M6rqzvEdB0T94EmNJMfjBrSx0RMwkZIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3984
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210026
X-Proofpoint-GUID: xrMAvATdxA3YxCDfZyRCKfMgyifxMawz
X-Proofpoint-ORIG-GUID: xrMAvATdxA3YxCDfZyRCKfMgyifxMawz
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch declares int seeding_dev as a bool. Also, move its declaration
a line below to adjust packing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v6: new
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5117c5816922..c4bc49e58b69 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2532,8 +2532,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
-	int seeding_dev = 0;
 	int ret = 0;
+	bool seeding_dev = false;
 	bool locked = false;
 
 	if (sb_rdonly(sb) && !fs_devices->seeding)
@@ -2550,7 +2550,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 
 	if (fs_devices->seeding) {
-		seeding_dev = 1;
+		seeding_dev = true;
 		down_write(&sb->s_umount);
 		mutex_lock(&uuid_mutex);
 		locked = true;
-- 
2.31.1

