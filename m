Return-Path: <linux-btrfs+bounces-1160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97381FF66
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1494B22949
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EB11711;
	Fri, 29 Dec 2023 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HyXP5uHH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENFc5oMb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A97111BF;
	Fri, 29 Dec 2023 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8PDcQ014684;
	Fri, 29 Dec 2023 12:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=cSGPApT3bHxbNN17i3Fmog/oBoThzzlaNwnuqIJC2yg=;
 b=HyXP5uHHbEKlu4v/L5HlhG8/CXP1PG4Au44GbdA9qkEvTQd9kQDQCa4N/a9geWMeT+t/
 Uwh/oVNb/drLYa3ibEcxtjg8BlXdRFCMgRI54grCj453fIYNop2Ru1ZoYC6aGGnLg14j
 1lAhNv6oIvAYlwTUzMf3py6r2oJqJhvAs52rVMy/NBHMMSk2rnJOc8jYT6OyM2kL4NAf
 SaGKxjmgoVJnLs+xgH5t/zXZwuj5IjKqFBwKNE94nfbuebdfDQDpGp2kgb7mbH7ZgK9g
 Dhc/k0BU8LWXw1vFrpP6rPwAhDK8sDNek1INX8dq4gqsGotF0j8QU6ZrQciwMKJ1mnDr Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pfcfm7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBdj66022966;
	Fri, 29 Dec 2023 12:23:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v6a965mq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejjK6E75geqsIKLnwK32Qe7Ds6Y8UN3U8vPc7sJVDZjqGISUQrE0F2+6UV4Qt8nIGXH+vrYrUaIcnYw9VGWmfv+7i/CMhT5h7xRfgrkvqw28p/bwCL7Ak89KFEM7diLfbMiDEYF2m8IzcVBM2vankzthmgp+F0aGwH6Ds3EZk41iwOLP/mHQKrh4LI2E5tKtt9vpSgkGmOaVg87p7SzrgJLA/SE1/WT1mk7ptJ9DTaxQeV6Amq3qp79oBHGuK/ppHySfnQ99PVWETnfQTT00s5ggt8xOObZaI7HCK4Uk2zjsWZEPVmztQsxSU+/y5GxD6tW4eK5yfpAG/9dUaK9Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSGPApT3bHxbNN17i3Fmog/oBoThzzlaNwnuqIJC2yg=;
 b=fX3SbUB8MA3AV8x8nGhdRobr0+fAHPiCqDEl+qBnhdO2AczolFQJRVUzBB8Cw6wkOb3mXpB25tJ1bq+FEMOdFjt++Kqnfm0287aE4Cbhc//hc6xlzu6KI9xKEZQrLGsUxUubSANIjf2zfe7RDmvp06Zb/HNPsdrkZBu9BocS4vYULxWIliF5gvdwLlVulKyhyXAPO6GsFz7ifcBSJmibXjFSQbp7Gr1GQERTbsxy2232zOQEEvGbD7w8tIAkzZmeMCIcYElLYoPwHNq9+MautzxUbIlIqUT3XA58BjmlPbUaEQ4diw7VhzYGSbayKqqhMnsgp2KGvA2Bowhe+XEwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSGPApT3bHxbNN17i3Fmog/oBoThzzlaNwnuqIJC2yg=;
 b=ENFc5oMb1zy0jjDINFK+IgQM+eTs+dqDqtLstbt2no/htfx3DPNcoqyfCKv1b798iGlBnsbM1s573l4f0wCqTuXVAXM9mi2XWQpzdk7bnaAmWYNW5xVQEhhfS8EcLz/zPgkmtZVu/xxuMILQHsE+Xz9+a8q3rPb1dUFsdwhDl9A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:35 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 08/10] btrfs: add fstest for writing to a file at an offset with RST
Date: Fri, 29 Dec 2023 17:52:48 +0530
Message-Id: <128d200f1e8f89b6a088ecd1bc04818833a8307f.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 279ee3e4-ed8d-438b-6bab-08dc0868fa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cTv2t8P0Mhh7OnquzvsCaSL3ko2rIMxLPvOFKUFnVXrX/iEPduF114WTeYL6jD4EqAus+morpPXAbNGHWySWy3qH7QEWgZj4QKtOPSoCxntcPtE3lSy+c4ENaV2JF96lmuLFNFIgfzHrDELQvXcCEoFH4mEqvX6Kycb9LUHrbOABfYwGTSZ2ycYunzrjD9gtmxTMWDTuE1NOyiuWNU/ybOYLVDjTBD7OK5HJN0mT3tGsuW8ffboSQ1UmAru7P4uI75eXmSIZ0oAseGrqI7TYEBVeJW4gppneqL14kYaodQ1DtMlWvCxVfDs0o0hoXDvccBT/w0lAqKi2dLL4Sfu1+wF4g1fniSbkxiJFkPccKlBH2uttOxbj321ebQc2eNAQKWlH36U7la5/OHGn0HFvRVbH4jG4Ld7mcaQ5GIGQwl4L0CgPBnHFaGMkV6TginDhHKM2CPa21xW9xHjgX9ICaY5fOosy05woVMc2wDM7wAwLUswUtWxM+8i1Ih2fOA7SmJyDy4I/klf5TXrmCB3o9pEXDFoZR0Y0VLeERJQ3KVQdHtw8uBdpBCorUiPr+24Wb8E5aNN0V+KVOX9Ip2CrdFi7lxLTynFafDLtRCmeHHo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UAJGaLNEW40oW+QJqATbQOHfmi7yQbIqoicqx58jEyj8dB0VguFZWYOFrs0E?=
 =?us-ascii?Q?4B7CGDtob8PN7TpM8VhZH2Z+OUNZRJHv2tZtrPwbESkk7BIoX0WRJL6pQFQC?=
 =?us-ascii?Q?w6g2PPe3Z5llJJsF6HTwfWMq/xn/fS7kO+9juFp71rRfVlFmRrZL3R9Z9St/?=
 =?us-ascii?Q?+yHElGO8eatwLIhxVF3LUO7HLeobE1Sq0scV6Xxddr4MPOIsPWojR+xcTtsX?=
 =?us-ascii?Q?ySCnZyeuMP5wLDpr3QScQyBxzf8t8xK1CxAWyPngZqOcozKhuJKkuviOiGGj?=
 =?us-ascii?Q?lLv63tp95D7C9Dg2Gbu0hpNFmKIeCjZOWcNWnDu5T8uJ89YrcP9Wf+v45Ncu?=
 =?us-ascii?Q?qei93T4adMpXSBhw4gneEzKxsRJB/Wt1ASLIPpqr11Y8q7O5GQR+UdVsAuKN?=
 =?us-ascii?Q?ebN3HiWADeeofKl0vzXTsOGzwT7OoeRmtgcII7+C7g/ckeK3XnfFFtyrlgTH?=
 =?us-ascii?Q?wFjOotwDHLUB0kg5rShyfzok5z8gZU8H/vR8nOGQklNaUdBgUOnLz2ihemkO?=
 =?us-ascii?Q?sHrngNzrqa4ePNNTCplK3I+HvioBs2qTBImi3Jh5+RIUSK6OZ2wk1SKXFoYm?=
 =?us-ascii?Q?i86VmkozJ9/8KEETVE3bRtJRghyLVAQ/5EbKzg5a/lfMBR6PeWPrZF1Nk7ji?=
 =?us-ascii?Q?AmfKES1InXh5UlV/YlMqGcd8qx4vYcV1QCjZm+bmAUM5rjuARysqudHCVQwl?=
 =?us-ascii?Q?+zPRdPAndJpwWrqdQuEvbox7xkickTExevi1zRtHNRu0uzGhs/RDqg6RV71q?=
 =?us-ascii?Q?Wp51hKHvY/UhjtMwpKD1OanTCYD8nPwbBRTCGBRHPcARRxHmRRP/qOEU/xwU?=
 =?us-ascii?Q?8u9NqHA74AyioPOeMQ9pLobbwRUV4L2sUcz2Iq2fdXBv2J7jnAS5peEBBsG+?=
 =?us-ascii?Q?wWCoSsfPStDteqTfL2J3kgXf9vwtglctZRP4DMnlV4hPXNfmLPdWQhohDfnu?=
 =?us-ascii?Q?l1yQk8bjnqkz5QQ4WV4m1MsGBFDpH7uuU5Gh2fLZqIo4C05PSshycva7naHU?=
 =?us-ascii?Q?wQedptnlnN87iv0GtkPJvlhLDG8efasDZg1Y2dOwjsR04QkHtJlB+1FZgeZK?=
 =?us-ascii?Q?SqPPLZYpx4uYQ9WQ54mqtFQz0aKGwXqimYGKPGFBLkVncCm7HmOsSg3m6nd8?=
 =?us-ascii?Q?c8+2TUb7qBD2HmLYSBU154+yipf4iKmvlKBFE6HxV1lgTL6grpQ1pqFsn+Hz?=
 =?us-ascii?Q?Ai1KhLU6g5RqfT3NHOO0RQeIvgLjKu8KJMTmYO4tpqqWJd08TZ7n16DxYRJ6?=
 =?us-ascii?Q?cgJA+6I2LKf8uL0LPdwjfIZbja6JnU1aApMzerbLnXs24mln4rgoHaoR9x3g?=
 =?us-ascii?Q?q4sz8FXJslx8pPMYvNrKQwI+k8m6fataAVWEk+C35eZ6QKHA/6p7YJ5zhxZN?=
 =?us-ascii?Q?vyAQF0aU2dCzvPAWiu/fC7jB5rBQ3tcXNQwntsdsEmnJg6f7nJ5Jm9b16tI+?=
 =?us-ascii?Q?sOKr2Ur475gJyUhjDSvOebjvIP7fNEnwuDwy08xMLYdqfYnwskbu+iuX4qUx?=
 =?us-ascii?Q?AofV9qsxr6JPTDBbQW5AGvNvCTcMXvAEzHgc5wMEoSwauKgILFJqkKeVp741?=
 =?us-ascii?Q?40hmzFFBBnkSpFaujOVGOaZEj7+k2zqsYDjUE4FefcdsJe7tDdo4aJkKuWXj?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gznDOZFkMKPRhLqJ1VdpdSPF2JQiw3sVD1a9LMwVNMaxwqg+HIq2jtfPvTNsPBQZLgbzFIF/UY+0xsGXQEH5derLmOOhFO5luzetMf58xO5fsLXz3pNvgiBZOxDqWAgrQ4y89CgLlogH4Id6YH56p5BYYzz8LgKvIxRSE5XD8ZXKTFAoEXua3C1S4QfohmEOr6LbCaK+54S+axni5Qxloe6h7hl0tMccTtpyxQvCH0IMezD17Y6eYwqNIDHURJ+kAK5/OYUUwBndvDkgLyo8KJJeHNqsEF0uYMbt6mJ9meKY2HSlQ5JnQ6ny9OOLMh4ySiSrjx7DZcUmMi51kp+MwdtnZD9yxFmnLwjqC1OUTBEkGnOagsZIgirwUVs9bOLEva9fVahddKsPK6p51rljdiF5sfz8llvhbz3UfnEq9YJd8Qp/pkYtj0C3ujIE5/HVEMHD1Ayf7v68BODCCsGXmBnNQKpmrwedxN46zjE8gyyHH7gQ0yiGkrw6RTPNopGYnGb3Q5UePGpihdyLmofX22D2xqj/FXXEy6yfsywwVmYxa3y3Mbtl37FgU1mCKYR2jLVNXSDcd03Wkqgn277OwFT3KN5LUw3j1DXnLT8imVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ee3e4-ed8d-438b-6bab-08dc0868fa9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:35.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjLJuqzDt//oI6i7K02Tuf9Aw8k9M41YPmkU7glSgp89Ba8pgkTw92+ZFEjaaeeEo0GIJ/NvfjU+WAVnaxRqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290098
X-Proofpoint-GUID: 3_uN4B95kkDgrp2zf1Rp2SbfjhjI_395
X-Proofpoint-ORIG-GUID: 3_uN4B95kkDgrp2zf1Rp2SbfjhjI_395

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/306     | 62 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/306.out | 75 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100755 tests/btrfs/306
 create mode 100644 tests/btrfs/306.out

diff --git a/tests/btrfs/306 b/tests/btrfs/306
new file mode 100755
index 000000000000..e2a9f804ac8b
--- /dev/null
+++ b/tests/btrfs/306
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 306
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 4k to an emppty
+# file at offset 64k with one stripe pre-filled on an otherwise pristine
+# filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick raid remount volume raid-stripe-tree
+
+. ./common/filter
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_mkfs_feature "raid-stripe-tree"
+_require_scratch_dev_pool 4
+_require_btrfs_fs_feature "raid_stripe_tree"
+_require_btrfs_fs_feature "free_space_tree"
+_require_btrfs_free_space_tree
+_require_btrfs_no_compress
+
+test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+
+test_4k_write_64koff()
+{
+	local profile=$1
+	local ndevs=$2
+
+	_scratch_dev_pool_get $ndevs
+
+	echo "==== Testing $profile ===="
+	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_mount
+
+	# precondition one stripe
+	$XFS_IO_PROG -fc "pwrite 0 64k" "$SCRATCH_MNT/bar" | _filter_xfs_io
+
+	$XFS_IO_PROG -fc "pwrite 64k 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+
+	_scratch_cycle_mount
+	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
+
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
+		_filter_trailing_whitespace |\
+		_filter_btrfs_version | _filter_stripe_tree
+
+	_scratch_dev_pool_put
+}
+echo "= Test 4k write to an empty file at offset 64k with one stripe prefilled ="
+test_4k_write_64koff raid0 2
+test_4k_write_64koff raid1 2
+test_4k_write_64koff raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
new file mode 100644
index 000000000000..25065674c77b
--- /dev/null
+++ b/tests/btrfs/306.out
@@ -0,0 +1,75 @@
+QA output created by 306
+= Test 4k write to an empty file at offset 64k with one stripe prefilled =
+==== Testing raid0 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+381b0e7d72cb4f75286fe2b445e8d92a  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.39.3


