Return-Path: <linux-btrfs+bounces-1218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF54823BEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618831F268DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913081EB35;
	Thu,  4 Jan 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIzAxG1B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DLn29+ma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D871DA27;
	Thu,  4 Jan 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLWD9028105;
	Thu, 4 Jan 2024 05:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ST0KX8+xDA5QtnA/oeWDlMWIZEi16TFYwUNYsCIpH5U=;
 b=nIzAxG1BR/qyQCbVC7hbpefO0U7dGXb7/UTdjyCqKoUnr3xuBz37R3Ar5VDA2FnaBTOA
 d4uI8x2HXWfZLn8qvAILbZ6uKO655KbRQROt1b8Zat3aPUCvYaYhTcc3UZ334T0qtjiL
 tJEyKd6KoPS+usM7zRTsnB1z/BB/K2EvKBJrE9mfFwK9oYNGHiaUf5yWemoY2qruwvit
 Sj/QGl+1WPTXvdF3oG4rEZAMGE6I8nLf4O9q367YRD9xj+GHS0FcFEOhXUvfGVHHJzvV
 rd0FSIZiEWegrcP4wt1dJyTqk+b85S+8cwVsuI1vfXQkXVtmEvr1WiMq7Hw3HiivCcSv LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d6e93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoI015771;
	Thu, 4 Jan 2024 05:49:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWziiecANed3t1PzG2JlQyM1FC2U9xNVlg/vuPMYkaiWZfdN3avWru0H4s1zuDOFfHo4e1iQsxZ8/AqlMUXvkeUBts7EapnGushmj0EzRHFRvtSI2+4aaZ31qC7ABJLShDjHQ8TVf1fOYM1IAWtqPOpETaGFr4TGxrj4UWB8/bwi1cyzLaxw2BRQsP0+JqgiChQ05FTg/yCJXe98LE1r4g1URX+ohrzp928t22rgQKwUSgqUgMiN2UjHZkWy0sn7z134+xgSiPmOjLH+gvWbMmq2vCa62L2V3FFEbUhR9f92NSV6cVgc98BntPG1F8x+j1vDrnFXW5cmTmAH4v8lvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST0KX8+xDA5QtnA/oeWDlMWIZEi16TFYwUNYsCIpH5U=;
 b=Qygf6yl4QzFnnHmEWGbxN/PZXlGSuh/hme3Z6MGFtdzUnxCoHTXyycDP4DhS+qoTOTubKQreLHoDeIYqXtFrOnWOL9r23v/UFc2qFHzUMgL8DT58aAbGcKchPfDoct76kA21prHNLuxBBk5oBg6eHzwTacSuS3yUCytUx3sRp++p3AohFMq8b3BJkwg71FO1szPcj7vUjlW+vK5+uD43qUGwCgb1vzrC2bWTgOFHPcNYHjd/tU3SjYO3mRbmzcWra9KlD3lYCg8mhBMsZIrI1UF0iKdTL3cr4fgjFllkQjFRZc1SruEcLeRNgu+iSkmyWJVNOJlzpN7mojBsAyHkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST0KX8+xDA5QtnA/oeWDlMWIZEi16TFYwUNYsCIpH5U=;
 b=DLn29+maMy5ssWKuwnCSmhDDfLlKGFB2aDB2rbrydkQFzPjAAhfq9DwclxRx3NgpDlw0bQDa3mVfLwomyPed+7OC9WguNm31eezrMgymCmjoo8tK9h8gNH37BdYA9OoS7BIMKOGKspvCzhkVUJHDuBMzbTjUmHFyUv+JbzxvEpw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:49:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:49:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 08/10] btrfs: add fstest for writing to a file at an offset with RST
Date: Thu,  4 Jan 2024 11:18:14 +0530
Message-Id: <b49ac199c91288949535bf95d01cdff671c9c2bd.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: d372c4de-5b43-4944-f10f-08dc0ce8da7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8nkcMn2eL33f5OXk4cch30GpuEhPbI/xANCP5W0oYXSUMBgn0wQmLDSk9DpW8TWNegyyXm6VAWcqvMDQgc7oulOmY9LT1GOmLgMFqvIWvzBqaZq0mYe49DeLxmBzfhzIBf67fWH6ScEOgNXdgxeQBObtcRTJ+EcnIRGwr4kKzOAdQzYX//ONOQJ/eZ+H1lnz9pqxYcxlxy5qMuYUJL6jeep/0C3nSgERfFVgL0/2mUPbKvyR6HLQgg4EwgCQh2PxkpsaQHXtTRvqffa+knAz2ngQhxUZERe209bSE5tkcjZrG/1q7P1qrpdpMC9Vn5hKb+RaApdAcycdxLEm0WkmMbAVnlcoVDfxOI/8whUmtJMofUL7ZVYqMLVLcNfrz5AN3LQKo5XLnynIDcmHG6xwi0C3kR16Q26/JB+75JfEjJDcqgerA1jBS0Qs9G4ZYOO5SPClqjNFvlY6NdI6yyrnwEp8UnYneXdefMBIBq5SFOo8EoDzzpEuNzB2UZCUUgLqhyOuVwgbDhEaRIBUoR1y8Afl49RTcUefY2xI8yid5n9dqq2ow5wuzpvUnePUx4QQ/aajLT5TZs+pbfhOTlkJNyRAojEL0C1faJS4aKKy2U8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QeXZcnHyM70u5ASL86uVURGlczxtNLTlOY/akSRtTmgpOprr9EycdnZbkuvG?=
 =?us-ascii?Q?zJTm55w2NYLNZxSK9tuTfC+9Ufu8QrWc3uG6dViW2YT2uEcBjiykdPiLL+oe?=
 =?us-ascii?Q?cRozhiaVqNuDq900AP6Vntsz2SYC7uRB1Z69ju099Cn7uKZtCpZfgD18DVFt?=
 =?us-ascii?Q?SdCO5pRTCkLkFRkmrs0Eie/w+K4mkSI+ZFjVThFH09tn6m+1SU0wTe3IFGdy?=
 =?us-ascii?Q?il5FjPDQFmprXbXS7um9Tl5DQREZJNimITagHGurV1GJcZwjkBHNkF41i1U8?=
 =?us-ascii?Q?n1hs7YdqnD53A2zPWN0zNYa2ipCiF/0cJ11RxFHEfteYCzTc5DpPfWr3H5RB?=
 =?us-ascii?Q?w+kfZOt8UqlTawn7k6IxXlDa9epb5pt5fS22714YL0sxD1Q2tgge54YEkPM6?=
 =?us-ascii?Q?GOkSnpFifBKTURJIP3+dQjrLneaDpnB53fqdMkaRTth7Su2LRY7OkxQLRvpl?=
 =?us-ascii?Q?2bHdGzvG3OyMrRwQTlviAvnXabkb6ZluCXmOVr/uyNgwXAzOJx772+nRgBjc?=
 =?us-ascii?Q?iIONFtDPk30JL9o6rji1Z5r6X1hclrShnelZY927IzXf6M0V1xm/kwHXobw+?=
 =?us-ascii?Q?ibQH5hauNRXYgj4jnrg2PemB9P5qXtD0TAKsTnvfCOpcLI16fL0LuE8KwXM0?=
 =?us-ascii?Q?kosOj+uWDG1Su3bhsqF5V1QVDUQpyxPqOau4yrOIwvlHTwwOwrmNzqr2JnJ6?=
 =?us-ascii?Q?A1oi/Apr/LIsdByd45acnTr/+APeIllUJSYVVgIosXsYYvtKiKJcJC1kMNlR?=
 =?us-ascii?Q?2w6KNpeXJ/MFn47Yk6QlhKYd2PkL+vlBgXP5YBMCxS8TMXsoELTZ7hfROLd1?=
 =?us-ascii?Q?8pT+Zfcy0vVdpba8KXzVxWj+1A8HLutUKmWb8+A5loVmhXgXR1dOElwRwMfV?=
 =?us-ascii?Q?o6udMC58v0GdqPbWFhJpHvH9HOrFrpjuJz2S92GWtyTQ5TSL3hQr42WcMecU?=
 =?us-ascii?Q?9a+0rKx08+ApzMLR3xrimuVGaBp0hC+T+BZur6iA/RYbXBFQx98MZaCq2Reo?=
 =?us-ascii?Q?rfw+8QDlRK2hPpDkFbtfRuZ2sRjeA49qOmst73nbQuJbtIsWEN3+UPa6mkjx?=
 =?us-ascii?Q?ytSHe+InDJmYrp658gSTQ5XCN8PJdpgft/QnYRkw497j4FVzOm46APoM+8Df?=
 =?us-ascii?Q?WPWiq9SS+rax0UNk2gwRS93KbCFXsVhExWshwuQTWQ2ax2pDIIHZJCSfg0U4?=
 =?us-ascii?Q?/McX7oLzBdslAOR9ewv0flIgv3niuIA8fBqEwYjrBbbSRyw/lw9wTRkaF2eK?=
 =?us-ascii?Q?8w8KpxfuE580Gmujj6EM+E9YJuYnD+JxPjOiB3oBLb1fVK2ODInLcc2c5CoD?=
 =?us-ascii?Q?lSto680er8IbF5pMcqfZqaBNW1oo3FRSfl0UzRgwIpqmIQvxUCUsHyVJGviy?=
 =?us-ascii?Q?oSy/u5vVEMSr8F3anPjR3wFSRmCsdrz7ZLj0lld0AAKjst37nUgkslGx6b3/?=
 =?us-ascii?Q?jK3JDULiV+gpF0fVQiKJ1UMVZb71Z0AEcGLtqfH6l4yXOzEEcj9UqH0Ogjwy?=
 =?us-ascii?Q?fdCrxikX99xgC3yaXK34kJs7TxlorQfFDINy75isBDIvzfvBYoxQNd53FtBj?=
 =?us-ascii?Q?1yi32gfa0FgXd5GS2GAuCm39U1NHOIRkMFwCYGSaddlpNuiAFG6sNUHLk+jJ?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3viDvoKn2D7XZ9OrFdJOTa6JhfayEayjVnifCoKAIKdX2Tfm9/8TFf03tRs8cUqbb+83BRSUKJ9gOmR9vBsLODqJPbRIL0r13WW52oW9CGwuY7tBCIpEXWc91oOy/f3RltibVRBKpyru59kVH9mrWB57aXtt146784/bAEyiC4nkZkgHwF56Jfxd2UuqRMtpIL8YAE/aqX8SEYUyJLnNkBCavp0O8PR8u/yrrwYN4X9fgZrlMeRtbyP0GgGPd/crxPqujugUstQH2cw+nQzD+P4rC+vG1JuH7HDRKKpgdmGrCwmGcKwbDCh2tFq1Lp/BaVAGi0WSJ80x0MxE/AfSJTnY+4HLWRj6RY+wApmdqZigaL/1fA8MvKfAoGGAAnpeZF0KknvH5QwqdTL895pP+wrfoUYBtHl+72DKzz9k3yPSBWsvx5z5Q11W4v/pFCdqBsb3JHtmN3QY3suxI45Lqrvaw3ZwVIGHa6IWz0YfhVg+A412bT7hHkAQY0IE/YdhF/CbFmLyy+Z97tX4moLIUPSI+7N2cOvvgyCfj8YgqIiZYd0RrY6jqak9vnoI2UVP0wUEN2zo8lojiypFOjtgmyJuFP9fEaDw9RgyNuFcIaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d372c4de-5b43-4944-f10f-08dc0ce8da7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:49:02.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0csU6yKdui6pwAE8Mfdw6NYxVEfR6oKNfzCBFT8L/mUcsCNOAP2Fbz4GxOJkETeU5EGghxaRpWcmYxFFscrC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: jlspxMQFIMr-LqvVwebXhtkrhYorfnRg
X-Proofpoint-ORIG-GUID: jlspxMQFIMr-LqvVwebXhtkrhYorfnRg

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a fstest writing 4k at offset 64k to a file with one RAID tripe
already pre-filled for a raid-stripe-tree formatted file system.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/306     | 61 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/306.out | 75 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100755 tests/btrfs/306
 create mode 100644 tests/btrfs/306.out

diff --git a/tests/btrfs/306 b/tests/btrfs/306
new file mode 100755
index 000000000000..6e3843186fd5
--- /dev/null
+++ b/tests/btrfs/306
@@ -0,0 +1,61 @@
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
+		_filter_stripe_tree
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
2.38.1


