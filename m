Return-Path: <linux-btrfs+bounces-1219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0D823BEC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD781F26931
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E21F60B;
	Thu,  4 Jan 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwezbSbL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yx5CdpWt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D21DFD7;
	Thu,  4 Jan 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40427xZI020733;
	Thu, 4 Jan 2024 05:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OoBSTKu/Pk6WBfQP21vruAhhYUTAp7CyaZ5uA4pER4E=;
 b=HwezbSbLV02UiGf0va2+2GAnMSciffGZLG9gw21omLD6NdOReqai3KyLi/Yiq72FrHW8
 CnVOgnzZSgL3SOT7FRzRFczv4ph184eMVSdsslT5RkWcvNf76DqHDsaKAdJCGWoALSuA
 nHQEGhMKLExdSZQ9EdeGJuBnaGAz/cfcL5TuDrJiGm5gWscd3b6ZzspGqAm5TbrO0FXw
 qBGZlkSb+osSpj9pAO/EQGyPA3/01jue4zME4m+oADg4qlvflOxNIFT83KNs2vFYrFRM
 aPFyTr2F6UGN8gxNaRILXAwVz4VX4blftNTcd5fBEAmTnI7O7NP+ItwZxqzJ9D8aRBw4 Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vabrv6dcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoH015771;
	Thu, 4 Jan 2024 05:49:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT87S9pKQK3hEiibU4yDp06xzCHCj4BxR5dcG+iQHrIo+YYDUuzEa1LFQpY8idV5tjNRXjwq+JEbyNrFMzVcRV4zBiVGRY0Yr7/40e1xiZBwxkTVsKOG+2jrithZyWOxWpf1frh5/UROe4axf1nPhQoa5d5gPeBDfmAy/cxbZ/124aOFWHGc/5hcpNH3wO3jifnU/E3WckUAXq4pkTFU07vrfRkswOCcwh0gJynR4uHkCfO6BIs9yXZC/vl6JJ5+qucRd/sHQ+GUkAfyl49nQCxYGn3SHpejHSrwSbpeS5fRlE+5LRiexHotEwuj5htGJDccyAZ1XEzmsOqAbxoXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoBSTKu/Pk6WBfQP21vruAhhYUTAp7CyaZ5uA4pER4E=;
 b=ebygAmbBoaVg8p34K8/2RcLOj5yXLkWtng+fiJKsv2KeADj1werlgsfRuSR9o+7mXxMycc+RQeW1Nw0ZNcKL17Dy/akgmM8kUzaE331Sy5zhcDNvX90mFPxtUDpr9aCkmqNGEqCoVWBBebMGvSDgtdW9js9FcQBNnFqFbA61wuvqhjJk1vdR+4db/082hAUY6GjWZKv6yno7rwTPjDCf13Mvj8STr8MKHUqPN62oHsyPzqgUD0X31/Vwu6H2cTS+0ggyo5FG3Lbu4T8Qj7f9Q7f7V8DM4HGK+8swIINkHisgZziWzYd1LD7hOOxxJE+XxZzSgZGu4C3MY0HqJaZHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoBSTKu/Pk6WBfQP21vruAhhYUTAp7CyaZ5uA4pER4E=;
 b=Yx5CdpWtvj4DZAJ5M0sCpiuBH9c3D5esKHA0qo3hUMxlgL8Ii39AaIH8qIYsnruLc/FbNiuToDf7ehPem13Ge710bSLZ9TYRolR0ksEXn/0qHzBotAucw0y5Cv/YozPBA0KBrhZXS4WWK08YYbYNS4uAxE1kSl4dNAESlzvUMW8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:58 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 07/10] btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
Date: Thu,  4 Jan 2024 11:18:13 +0530
Message-Id: <d7192051024ed8c7818e8a6bd4dfe9f35bf07a67.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6543c21a-6d18-4ba0-7f14-08dc0ce8d847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	heeXFhsKbHP56YzgFF3qzgpLOyeGfML0Wy6D1/Z78f1TBxrVon8y+RG2L3siJT6uhyTN/jmiHrYcrdH9I/mL9sQ5dYoq3R7YE+i+PGjHgPzjv4czGPPnhHpTi1icz+qnDH/FCqVx8o0Y8QId1cORsch+iaQ0BF3788VA/oulT62pqzwZYWPKsc6RV3Kcg+Zin3xQVhM5zcPbbuM4ax3q67RbeR4KcoHYA0AzbG/PIdXL/MkXWDfnKKvaZmA2XGpQUdwMt29ZAvz4sNzCb+lfl6+uI99hnX7T0ple1zQulwJ3/a2JwaayZjtbL0bvuhY+ns6LjeSMth17OBgSseIZjIMmu/3LZyQpUkfft8snovxczEGsXuoLneqQejzNvSLuQak7PWIusKa7r7pmfXF0X+eJWj7c+ss5NTihnXhOoTL+7CaweAaMFbGu02CvD4swI30tDqV7W+45zANl3l0CVuM3OpKFsS9A9giXmz7Gj6XSiteyqazhKcFIanWtqDDODvDEahUUiJLkKmD+mbCNMU/a/r5rbTDyKafu6nmHGtq6LQEU6fXDMJXrwIuVUhOwvrFnAAzlXKoPfTgMF7/8v5sS/zW2Eo7Jem9eGiWNkaY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mYfrqC8t3usibKnxdVH0r8bN/WOCtcpoKtKm0i5oUV3HYcVdQ/xTjZ+ub7yn?=
 =?us-ascii?Q?RF7k9vnZ7r4NEOeV3YyQMv/V2Cjri046d8iiX4DqqNnWstwR8BNsKhtB04oY?=
 =?us-ascii?Q?XaPnk0ZXA/+mtklJEcvZgFiVfhWtVcm/EOdvlARVU+nwDJDQPG0u0KiyBErf?=
 =?us-ascii?Q?0ke6I9i8V61GhLuspoeq0MulrmpOH0vfTBubyJC3RFJeZCIFwdUVsa+R9YKX?=
 =?us-ascii?Q?mT9U6wIkCGIJNbPqExXIZZZRic6Sa5qnCHLMofgcIuk0pm/kmKAEXsDEYj+Q?=
 =?us-ascii?Q?hYaLaS4/Dwa6I1J1AMYUc11lpaqr/WZZG8RGXmAGMTLt3zHOHNZ29ox/syIf?=
 =?us-ascii?Q?Z/WcThyZ83aBDnPHDKpd5iZPBmahacY35GjIbfnM4gZRwb41ZiPf5IOf/P8Z?=
 =?us-ascii?Q?IK73GlkIesTtvecyVgMa5mwLT+vHF5Iynvs+FVNgYZi8rTER1ocAzyZ3JEeG?=
 =?us-ascii?Q?k2lOUJ+eFb9NlVPODoj00pHYKBdGttvBIN+sPmDE/whbc5noULn2ZC4hdUhO?=
 =?us-ascii?Q?hznc3cegE4eLla/K2j1CbGWBl5LflxIBo6VZBrc+FluAPex1RL6twRaMsdw2?=
 =?us-ascii?Q?4ZVgrgt5cgpAc1AUlDrTJWV0i5WpFLmSaPnTfqoDodYE1TKw43/qH5SplCi5?=
 =?us-ascii?Q?3X58Ii4HohO8Ok/8iHikY8Eivw47UkMrjZlT4EaXsGeV6tfu//ksXBTG9H+U?=
 =?us-ascii?Q?cnKmkyBTjDhsmUYChGFYQtH3GbTSamsh+2WegnFD0qELALi5FfDFY6R0vKzB?=
 =?us-ascii?Q?acIStrAND4b87PGjxkIhPrpdefCiETIEkB3SShYgW6V1YKFBlg8zJDXP9Tsa?=
 =?us-ascii?Q?E4/+xQGO3+lY0GoM+Lbf44G6dWTCOmkNqB12KRkg7Basj61l6nUOJ/jMn6u9?=
 =?us-ascii?Q?5AfGsb/nOTGvA8Et0qm1bRDGdUO8w0h3HeX27AZHs90fxcquRV3nITkA65NJ?=
 =?us-ascii?Q?FmP9SPVQ3weaGtOLn/uBoNeFJPRo68uBSeIPrH5KcTFrFaB6TAJOSd1uFzcJ?=
 =?us-ascii?Q?HwE0c0CbO4MtOiUW7+dwsXc0Q8Lyva/hLsvfrI0YOZZWl0o4/MN5L4srqFhv?=
 =?us-ascii?Q?xq7Csa2MeTXLXjiyiPl2mpj1I1eldy/e1dnq3zhyycelw9QZUi6UES1Slo7y?=
 =?us-ascii?Q?LrYtqj1BlBV1xAzZdO5cD3pZ4Qi/I77q0AAWZ0Otjyw1P6LpQ6g0KYBeV28j?=
 =?us-ascii?Q?c6jJ/Tu3VwKq8/rXB99LliEsJJIhy9g6meQa23cNkOKXBpbTzB4RvM7X7+Cw?=
 =?us-ascii?Q?OW8eCth/EdBGanY5sxh+7MEiSRXfPEodYm9nk3dOBwRCbkUWVzM2sZZc4quH?=
 =?us-ascii?Q?cuiDEXYxwigExxvqfKEFRK5DcbhkzX3likqRosanP4Mc+LwFyo1mPwrIiMsD?=
 =?us-ascii?Q?1a2nZNkq2cQkDtKgIAKM7bG6YotNy/MwQysYGFqCZhDywajeA4ESt+np33eo?=
 =?us-ascii?Q?mHUZ0rVedyaaL1x+FDp35ysu9EiJ9jGnD4qyGGdiAht9r8xFn8SHUsVeZ7Cf?=
 =?us-ascii?Q?SDNZp6+XFvrtxYhoS2LxCAMq2VjrNCRTHaeA6Ok4558cyO0G0ExipOndQEcz?=
 =?us-ascii?Q?GfVYK3Go1Nz1ATqWvTYWXQUX30xK4cUep5k/M7YPLspEvvWW+nffB0wTNpgC?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yt2ybGHTxd+4PytjS4aQUeeyt0O6mdUigyxZIEGKCbkBsWoXK7pc9sdpeF4CJH3h7nNl2NoELNFHDASB4g1qXtWnMHof2YIEp3/6JzwYynUlzpby5HMPJudAEu6CZa47oZDh2ROFgc9AqEvEFt9Qqg9jgWJmy7blcSdGPg9ejQ9sBI1tt/cOc5WRQ4AgNOcjzbzVPiLenGkR+Rdfyv9U2pxzm1ZvY2tKRBwmbNialel2FPkEUcj2S1wRKGrOIKPZN5zsXeHKniv55IYZu7wQRs41SZKBBmP5ZL5EQ41icQDLvqxOHBlLmZlnqP/aKWAUpw+poDoL88rA4fwjntQ7Iknez2gKcR+bL2JGpBDkZVqKVZGWAjw+UgGB6zkaZVdVZKMxYqKngycDDOEXM+xOdq5Zf8rArzwSroiQTQsuGDj0BwGbiv5ibA+XjDkYvBvsUeCrhQN8RjFKSb8PHSKdC/wbLWLB9g9Swa711xAORsYDKaIA7XCXKerKWXNFujMqKB1LLJX93iOsJe3y69a/yyRj2K1c3nmOM6ixFTRKV0z8R1PZgqthV8olDVq5pHLlUyv3XEw3PtcIzT6RmoZE5Dpd4TqTNEOJFq7L6uIc/DA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6543c21a-6d18-4ba0-7f14-08dc0ce8d847
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:58.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW7fWNqikaBX0a8B2MQI16hAF9ZZo4MlVmso4781IBjVNlCy5dR4jtGOv6lxcGrjfb5EMan5fgJtGykm0EI51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-ORIG-GUID: MaE1f6zDG32fLx6aKWbM3GxAmOOGSRFn
X-Proofpoint-GUID: MaE1f6zDG32fLx6aKWbM3GxAmOOGSRFn

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a test-case writing 8k to a raid-stripe-tree formatted filesystem with
one stripe pre-filled to 60k so the 8k are split into a 4k write finishing
stripe 1 and a 4k write starting the next stripe.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/305     | 63 ++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100755 tests/btrfs/305
 create mode 100644 tests/btrfs/305.out

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..1c092482e8ce
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 305
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 8k to a new file
+# with a filesystem prepropulated, so that 4k of the write are written to the
+# 1st stripe and 4k start a new stripe.
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
+test_8k_new_stripe()
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
+	# Fill the first stripe up to 64k - 4k
+	$XFS_IO_PROG -fc "pwrite 0 60k" -c fsync "$SCRATCH_MNT/bar" | _filter_xfs_io
+
+	# The actual 8k write
+	$XFS_IO_PROG -fc "pwrite 0 8k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+
+echo "= Test 8k write to a new file so that 4k start a new stripe ="
+test_8k_new_stripe raid0 2
+test_8k_new_stripe raid1 2
+test_8k_new_stripe raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
new file mode 100644
index 000000000000..7090626c3036
--- /dev/null
+++ b/tests/btrfs/305.out
@@ -0,0 +1,82 @@
+QA output created by 305
+= Test 8k write to a new file so that 4k start a new stripe =
+==== Testing raid0 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 61440/61440 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9d3940adb41dd525e008a847e01b15f4  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.38.1


