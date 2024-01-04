Return-Path: <linux-btrfs+bounces-1217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A884823BEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35EE1F26856
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389E1EA87;
	Thu,  4 Jan 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J16Q9iIS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K/cwo31k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9D1DFC0;
	Thu,  4 Jan 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40427uEh011318;
	Thu, 4 Jan 2024 05:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=2pOM7DWikuCOhaNtCYpzoD+9wi6B3ojim5KneYpaMec=;
 b=J16Q9iISydvliiU6HXaP1HoWYdHocmWstCPtb8FK6Bq4x7+XgR/sVu9EigHlI+7R0LHI
 Oaqw2IC6MiIj2KT9PaQJ7pxPXHlddLe9aJNPSfXN75ZoUcpa9n6mKLZNZBMlMV6gfVW3
 F6Nxkd1l/Ivjlqd3vm2Qs/6ITDOy3PyTfBozTuvDCSrub4fhQHh3O6XIgcFus2s/CSon
 bsiSYOl0SOWcEyz70eBuUFtaSaK9HwY7geigO9qEiRQaBiYhV8ejXKu5O3vJK2EHEv8d
 g6G6igTTkI89m84s5EbcGbx8bn51MFoXCE4RvcxFnHXlU28kb6UEqWuvlWJ2I4HtZe1V cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4cefy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoJ015771;
	Thu, 4 Jan 2024 05:49:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agJALdrvIY9z+/hRezoIDwAHZlydmRNZxlwulZX7pzbTV6mWxoCr7uwaJx95J5xnNiCO4M/MCtKHQHSttc3ygozKJm+0X+/XBLkYflemPdhDGMyDcfWmBJ3KXwRoJBzyoXnCjkEX58z+q5Xc16R316prwedkIwk/GxjjGkpLbMqvEbghV7yBd771i/yJd868s55/ku6bew9qKY7rJwVPatHIowTA3FW33l13AZEkpQ9xR9ncc6hbq/yXBsNIGbgtqTupzxHVKlLut96/9Y+OpEnngdRFjp5EA0cUX2np5MZBkStAsm/1kLUrImTXIdJdXX61CpbpZnLrTnsUVdkamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pOM7DWikuCOhaNtCYpzoD+9wi6B3ojim5KneYpaMec=;
 b=eUEEnyWf2wZXkGiMEC9vfvnsqlOTyDHuYF+n1V4isjB3nkk0L6iR2/UW9v0jXNFYaqIJPwfVAS/e8Y4EPnQhO0LwTlfXtbJ/AsblhiwdJifvVtSxtu1wWV6kMGPPP8z3hD1SxUJc8WT0sn8wTmNiHITAdjJvAmRRtK2VNNzdhIrGqYCB+F6DuL4QCf1R68mQ43zy/ucf/8tpbG+kK1Io5mtoYM8bJVsfi4ESHmho2uFIaAUMU78z2sCRAbcZxAmXj6JKWdautaEHj0+UH2WfD3jqr3UPqaP+OuJDZStIQf+oSCIcw2KNCuVSrzxZYG1EZ6l/hlI3kRqWJbWZO+AcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pOM7DWikuCOhaNtCYpzoD+9wi6B3ojim5KneYpaMec=;
 b=K/cwo31kEvsGfqiOQfeujlioTTrKhxpkXor3F8SfFdbSACTXaHdSUtAgYZQFTTQG2M1kBqNCclSQUMD1GCyeMZEMVjKD7D9rIM+Ht0wmfWyV2suUVMtdohpv1xxrDH30dNU3xSeNQKwyXShrneEeLnswFXdKoreYRFfwXIf72WI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:49:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:49:07 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 09/10] btrfs: add fstests to write 128k to a RST filesystem
Date: Thu,  4 Jan 2024 11:18:15 +0530
Message-Id: <ddc93d86ae7b6d75dd6a7a5bc7fce206302ebd79.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8745eb-3fb9-4b78-0590-08dc0ce8dda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EmWgf5mjQuaRtMGJXvY2r3FmEFbbIxfEjHdf+21iWJVW0aDkMaG2z2AdGGsfWOny+Lok4MzWylarvuGn8iDSOy5CifXgqfZtqw56bXEZAX05G7vWmAaoCkBsz1fBG/MHCRKTCqeuMeEwXAKG13o+HlOkn4iRm0Arf+khkJdHgQ8KcDNUuG4u9xowD1QPZN0aJU0t1GvN64yxqCHQG9/ewJlVDvzhqpYCpMJRa5F9jxZbtyFaHsMchvdu4nAjON29Ea0CG4TWgGY4WdiXMfYnzzkOTQ3N35/b/dQdzczcMjtFGf6eDX6p7kPb0sicAbsI2Botqa8fwqouZG+QmZ6Z+BQJY41MLglU/nNjYzkXtl2eqWX0YqPRL6A+fLXZUyuDfXn085/2GSVix541UjdeHu2mch2Db9IUZC6YGOhpZ4B7w5L6ZyuhcE2m1/nPxYAKQP0yJ4k4rt3EVpXGrmDMgYVc0nPZiuCna/j75r4ZDH7WlXeQ5CDRLs7KGN59ShPx2zVJJJab9W4CbzCyix55ivGzJaWx+ec8CJNMDTj/Ut4DwT2maMK7kup7HHKmPEwbDV+I2C3lDasIieNNBO3ABS7nY8IGXJR8MCNV8VeJyQk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0UG9yZ0VvFTu2XzePu/yh+bD5KDoE0Skq4ZqCobC4kUzjEIjKxsI5KRF8VVj?=
 =?us-ascii?Q?YJYFiuvE0odlxtqDXaZZwrj6oqagdtpvne0FCcD3O8CvyJcfqPhyAVcNqTWf?=
 =?us-ascii?Q?YTAIQyJmoDFbL6EYpLadw7a+T1ueQE3W0n8o3di6XGcnrqhf7IfIQR3ywMn8?=
 =?us-ascii?Q?WceZQjx0XhOWkWMU5t9DcGyy8CE0VlFvOV1M1r2T//OH63/hY8r28/wyMSqh?=
 =?us-ascii?Q?wuA0MCUHRM3vm5rterxopBstxbwb6T0xgBbrTS0I2B9E9hq3+6O4w6X7Ye5/?=
 =?us-ascii?Q?2qaK+VmvbpyhWX/jftsHJz6CQbeLakurQQL9xZlp++1x7hfxfb2fM/+EsKuS?=
 =?us-ascii?Q?tBRDEDWVWWO1K53pmm/VgqecdqsMdJzx91T5Mt0n5Y960eK74QN8jen7qmUj?=
 =?us-ascii?Q?I/kGWt9U7STdW7c4z3l+/m8n0HD/WUz3KZwbQzATQAIPq1tkQpxuHbxE0SdD?=
 =?us-ascii?Q?Q7PlujKiXVajmV8kxSEkEpCckc46bQcNsSiORcj+EKonFMlB/38zSBxf9TL6?=
 =?us-ascii?Q?3T0DilQzNuCKcDa812O6wwEYwuvXMbr+DuUGkhBQYVFZTXVxn2rzZC6bkb56?=
 =?us-ascii?Q?m3MSCJlz5Q/a/LgWy2UwTmz74MpgM2WiBleyOhIzh/QRoWjSKm0VslnhJ4HA?=
 =?us-ascii?Q?7EEhdRzHuqJ7wQFuh+hXlLsKSQ151eJpzprM3lt8GhSN+6j9tK8MWNB1mU8i?=
 =?us-ascii?Q?XHjapip7xelKNnO2c44hXNYVJqNuy5/IeuCeKrvd69f8q0v5bLatmaas6NGS?=
 =?us-ascii?Q?cM/fXTQO6qmcsOhp+qI8MUuyNtYS7GRYs/lxgM9ZqWZ0AXVYJTVea3fSwsuu?=
 =?us-ascii?Q?z/sEF16GtlXh7vJKIBDwJLtk4L498s5Nkv4yI0KipnMOStI4xDgkoJEA/hlP?=
 =?us-ascii?Q?a/WJ7mcyJk8x2NWvSxMf6+fgTrhchoYixveFzszLypDveI4BqpG28evrGK2o?=
 =?us-ascii?Q?5k0n6KmeJVpam+rUThSq+kyfphSEUYCprC0KTo2i4a0kHmRV8k9u7XHBeRLG?=
 =?us-ascii?Q?awoXmAYQ4lPOp/xjgh8d8aS3Rak8mDrqEOtYe5Z6WpSpEbDHAuBualIRjjRl?=
 =?us-ascii?Q?6YdadxJ5s6+2wrCwTrSylgtwCZ7x/rL0uzwOQBQimVRhD7spQl3fb66hgvQZ?=
 =?us-ascii?Q?ib5bzTUyatf4SLwfdsAuJwArwM98FXkW7S5BNziwiGtx+1bezzUi00wn/Ibv?=
 =?us-ascii?Q?lB4DLFTPvWVDaRijLw0KLfRuV/YnrYspW75PUzXKkzpgug9uR/wzutZ3u5R0?=
 =?us-ascii?Q?tvNDwbcFfC+j1NfBTs59LzLja0y37uWmLGhUt15f9NZ/J0hJDc+neH2piGxG?=
 =?us-ascii?Q?FC1OrEG6YZ6tIuJ9GKDK4bwAvw0EeiqfkIyOR5TOfwDU3PIkxm9xlkD2X/65?=
 =?us-ascii?Q?wa/nd0LcW72+t6CE5M2dZKFYL3aM5NhpIqhlhCXZxWIh07btroCbf017Nx9/?=
 =?us-ascii?Q?HdUGI5RqRbT5dtaL0MF94zUo2yxkwdOiZxBh8aqROQaY71AzCxo2oyLIudC2?=
 =?us-ascii?Q?55Fy/m0FTOZHWqK2j16teUy38MQ3Lyzov1TbA2lOthNHrtuP+c/gBonoXy+r?=
 =?us-ascii?Q?UrQp7AuKX6PMYT0p5P7DPp8S34tQ2JejEjewbLdZqIZZQhQA8cjeCgj2Z7zj?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G45OIJFjEhT3oEdUYW0d/QxZUh3LDutADs8sK4nXB+HWMnJjoDHUWmpUWevTXeywcaoZJc+MdcwhGC6RAwiQExpasaQSj3zrEgR0TDr0bMTMNwKnjrZRTubV2zKjBJ8IZuHwsXGiXWWsnEPSxi0Q4Smjj/q9wRvseGgj6jzs2EBCXAbcJExCjRPQwdIMH+zQgUtUbczLpkJ2mVKhP+2djSklQZECe62tE0u3afkPmlHSgQAXRS0OwuBQestj07ccXYAFoSahNbrvRsRuRFPRkdJgYUcbYOFeeVNG4SfRjoE2oSg3btz8lMrt6P2eIKd7wrm70aY4g9TqY/UxUNm+ohmSzIiaYaboFF4bsgZvdsyVfs5rXAtHGytd4ERdFK3eYLxR0opLRSAtCGOgFbe9yr5h/T1fVxYu/Iyk+VhvgAlfveyJcBsH4eY4b+aPhJ7HOu8FFmTlVfUYVFR5C57noelxsi6mUPuOqMjr+8Q8hzWjBrcsYbdC5qU+maxPv5y/Do/DBKqJisWIMglBUI9s8pqwcI2JbyzM3spqIGa7ojuIP17Pmh6kCXrGX6P0wH/E7FA6AgtmiJ8u5Y5nUa87jgiU5mddUuiyNcm6DXOaShs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8745eb-3fb9-4b78-0590-08dc0ce8dda0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:49:07.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIiPEFtlAdeMqHRSOCQqR72wOHEwXi34zTc0J8rWB9qGOP5BQO+gfMnrHWF1T5F4SYsDTb/salTDwQ5qgdblPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: QWff4wK1HCww5xGfcMtav7Am49NC3weC
X-Proofpoint-ORIG-GUID: QWff4wK1HCww5xGfcMtav7Am49NC3weC

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a test writing 128k to a file on an empty filesystem formatted with a
raid-stripe-tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/307     | 58 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/307.out | 65 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100755 tests/btrfs/307
 create mode 100644 tests/btrfs/307.out

diff --git a/tests/btrfs/307 b/tests/btrfs/307
new file mode 100755
index 000000000000..d9c39b928e00
--- /dev/null
+++ b/tests/btrfs/307
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 307
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 128k to a new
+# file on a pristine filesystem
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
+test_128k_write()
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
+	$XFS_IO_PROG -fc "pwrite 0 128k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+echo "= Test 128k write to empty file  ="
+test_128k_write raid0 2
+test_128k_write raid1 2
+test_128k_write raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
new file mode 100644
index 000000000000..2815d17d7f03
--- /dev/null
+++ b/tests/btrfs/307.out
@@ -0,0 +1,65 @@
+QA output created by 307
+= Test 128k write to empty file  =
+==== Testing raid0 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
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
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
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
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.38.1


