Return-Path: <linux-btrfs+bounces-1162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C118281FF68
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424381F23F72
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338251172F;
	Fri, 29 Dec 2023 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXQkE4+7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7CIFU/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72911701;
	Fri, 29 Dec 2023 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBSdbJ011768;
	Fri, 29 Dec 2023 12:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=dLm9mQva9idge1wPPMm75VA2v+dP7I3cdVN31Xg3dQQ=;
 b=aXQkE4+7MbqWmHA96lF+pfLjCzniHmO40WoyvjhozhQjJ8NF/Q1lVmR8k5mbvVz/yI+5
 rQaLw2JDY3nsbidc/13AZwDb8xwJLLTRHuUnW8U+kRWaAd/Ro7SUM4x0THqvbAxGg24Z
 TD0pTQiKqAeHlVBtjCA4s7niEhTUWoGdqfaO2GbSd6FxyjHMzy74576eNW9+/Zlu8la5
 1KFbflqGW0uvBsKxYVS95Ln1CojNmDbj3jq/IJtGv0d3nzMGx/0TWIk06bwdvfnEhy2K
 gl3Z9WdhnTls16SHKJ0tRWb/iQWrxsqrF/9XPxKC3TpVHfYIc4JrrFpX72DHWVWYeCAX fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5p52fkmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBpQkM003004;
	Fri, 29 Dec 2023 12:23:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v6a965msp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gar4bKSBxakbSshjzrvt1ZZZ+uy6LfbOOT3p/myfc8NGjedQPoYD6qA3J0kLF1KVhoYKhlDdd8GcR1Mquhondy3A2W1wHXar7kNlO8mMBms+b8q2a3TKpaTCSF83AVhq7027hVIDxx7LJhv7tewHubMCOxtRx9GFlcXmq5ffDm7rJU2qZF3C8ETww9/HmrOevI8lYIzpg2v/yVMOvjO72O+6IiXu+BZU/JKoovDxFGuLCI3S/euxtlWSUsmlN1OGoSljdEBZR8h9FzMXgUnXbuCO1KEcKv3QJWFDtdpY1D8dDhO1zGdiBa37z4TmfzFXCpWikc/5T5ICSZTAQzAT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLm9mQva9idge1wPPMm75VA2v+dP7I3cdVN31Xg3dQQ=;
 b=GVT4E4beLgzeYtD+rUpbEX2mVdq3G7RFkVwPmgZNrMtsuKeO/wghsGGI//kcPVzdXG9uiaqRBwBG/OzhhutGh4NRjWD4J4qo0Mf/rc+VXGOYX5nLbcZXIpkXOs5yhTU/Wp+KQU5tWGNrCnotrnXapXOD7p+5C7/4aaDGJ226OgWC6Pw2Q+j++d/XBAdfW4lRWxw4bTtc5CM0N/axgyG8i4evgXBlzYz+avB7rnq7uLgc7nwAQrrjB9EbpTEo0+3RYemzQ6CMwa3OvuCyNdJ8GKBgMZmCmkwGFJRWp4Lxgud6PE3or4EuzGeWt6ha97rSZlDQrFGjF3yPTrj5vI2I8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLm9mQva9idge1wPPMm75VA2v+dP7I3cdVN31Xg3dQQ=;
 b=N7CIFU/GZGgBz9uoshoLUydbpbUpuQZwvX5+gF4VkBVVsf6P7Qf9qHyh04ZYLcN3VS18fykiGhKBtc7Xleecl7N4bgYCDrD71rDTXs69SakC+UBw6GRKOPJPkuirlvR2GNJee3whZvGn+oMkim6f0+lpr2vOfsnL822pDOL9w4s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 10/10] btrfs: add fstest for overwriting a file partially with RST
Date: Fri, 29 Dec 2023 17:52:50 +0530
Message-Id: <a06c570ccdaba6f4b30b39b1c709bcb125fdd28c.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe9cd0a-af1c-4c7a-5e4d-08dc0868ff1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yZWKz4J/0Z7+GAvs3m52WbN8y+uYIdKnYzmpssV6qUmAGKPMFWy/r25cQBZZ+rKOx2VV9KUX0SCy0g0hvV2PgUq2Hmv9msCoKovvQPf5HmgLCyMFs1xaNPaB4MsAzHTEd6axbOHnwRTjzUoNXexxKVPhVEocqTJAPHIws2vtPEu8q4iUnVdlDXWYZADLl99YHtxK7OP1E7STmwQvXdkuucsqmez2OpKz7KPpVEBkftA9CCM4PVHkkGqkGuYMhKcd4I08IkKcYIlMvnTESp2AiF7Q6xVqb95RMyYNVIiSte5SM3NV5nH8Pu3lBIKLgjwBAEYY7ejkwtr4Mt/wca8EU9tACtbUvlCM8M75x1ZDnYAq6Kz1SUmKmgckQNU0jIF6Ohz3qkx4BjvldwzcxsVMLrVqb2abiZzbilMvn64AGW7dicTf3hiZQ+XcplepAV93CHNjb7pmnK+KzSqKDkJFuCKhltSp0Y86iTl45Cm80Wx+7lytcv7rGjuG4K2kGOD+2L7pGdkDZAGluIX/uFeE1DkCRuuLUkDqD1Jg+wkaa5o0NE/9hEHLr5TZpJkt6pVOmiD5AaSn2XtrxZ8ongMyIXx31DohLUdhg3+/zOQ8PII=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(8936002)(6916009)(66556008)(66476007)(86362001)(66946007)(6666004)(478600001)(6486002)(2616005)(26005)(36756003)(316002)(4326008)(5660300002)(44832011)(8676002)(2906002)(41300700001)(38100700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gq5NxcL2bcFR2LaNjgA8ZG8UWV+oQvCLeP2qXvNgIpyC5GooPEJU45wOaNhb?=
 =?us-ascii?Q?qSbw6GK3w6fCLAWrmStlJuOBvvFPFs1+Jkzs9YtENp2YARovH1owodIwEK7B?=
 =?us-ascii?Q?RubDB3gOXUp4YN5E21G6pTpSwh0ebrx25yixUvh2YLkw1EpRPebtwTiqpt5k?=
 =?us-ascii?Q?nLrKrJnUTUHGS60Mq13biYuDrvqLVdC2nUlbSXa1iGe91F5i4xMqmK2LNbB5?=
 =?us-ascii?Q?eBkjH9P/TYTkqpF0hCBkf7QB91f3qur48WeefMYA5L2W5GG5tnTz0JJLlOgy?=
 =?us-ascii?Q?rKjx7Me0vBum0MHCEgpc8dOL+LOSp+9fQoczQZ0BZu+0PX6Qu0/sSBjEJiwH?=
 =?us-ascii?Q?Kb2Z2zU5FmS/TVvYGTXbo/ceCjsX+HeFwhiltPFo7zrC5Y6O8PFYoF8bUiMg?=
 =?us-ascii?Q?o3DzsrxQ0/bBjVPzuUzVnrZukkspMOYcrz4FuacfUyoZJoZgehCdCegSeFNf?=
 =?us-ascii?Q?xBsYsCrOE6wkPD24t+VJRcYecU+wiqt5ES7Vmn1AQ5gDcKNpqGlh6QSrucSb?=
 =?us-ascii?Q?2bUw9/dT2ucN+U2qL+fhLUX2VTwMb+SE+1iHxh6KhFtMwo51zO1KT95GtN9a?=
 =?us-ascii?Q?HeiFn9Hpz6mGm4GsBop9jeCaE5AMLJyUQiBi9h1jrLD5tNICd9mBYoMr51ib?=
 =?us-ascii?Q?nTnfDbIZGyCLMtreYfPViy9F8JQ95rfJH+8YIkzZvTWaaAUIlH7meYTLkbco?=
 =?us-ascii?Q?aOBKyYpbRcWhgna+yfScfQVMnnebsu7eEQ+jHetgPmYj5dy4VStFjeXiR78M?=
 =?us-ascii?Q?A9GbnImEGeXUxhSJ+2OEDz/JW34K+58eJkdsnWDnRtQqkU6FKR6poVIwo0N1?=
 =?us-ascii?Q?U96dm3xjlZehOwGyw3CuvB1r5hrXj/WKtALl8guvEbqJzDb0vHXIri1hrjPF?=
 =?us-ascii?Q?lR8/eu6ozP3Io+VZ6rwgIVd7J3P50b5ULVZseG9F133Oj2R+9NLRwjyDaRLx?=
 =?us-ascii?Q?N0KQ1A4Qmc1b5dCM5+rrRhA6YbhS/KBRKIM5A8XRKMuoXGF2Jz+LMP96vpHA?=
 =?us-ascii?Q?aFJgNj9G8dZ3Ne5IbAA2NB77kyzExkpexDU5p/rmlnvWyYW6XxXDZyTwAc65?=
 =?us-ascii?Q?e535abgBQjI1h7ygvlPcS1GbHDLuHQyXIduCsR9+CjFXn9AEdrWJZyAJ4l9s?=
 =?us-ascii?Q?wa0zVla8pxHZb3MNRnAj1NWvVmEt9IPO5kUBJVzJUhPDFq2PyeUS95HMRWbi?=
 =?us-ascii?Q?uTUFgvVFyvPr5lyU+b9mo1nyH1/DtE0KTsBX3RNx6nJch/enyVnPw1IdoP0l?=
 =?us-ascii?Q?1O3p59kFqM64ICKviivr8q4+QwX4I9+fUUto/vOgl7/Y5kKBtl+2QPmFK7A2?=
 =?us-ascii?Q?hx8zBS4ukjM6u1qM1y10cO7I9VrLNAvJ3dmOr8l5oIf5+kW8Jpz/GO/Cf0AX?=
 =?us-ascii?Q?qhCjLIug4nJa21s3kbE5yATgOBKO1RKE536QJsdbPedTnDeJCJy8xra0pNZJ?=
 =?us-ascii?Q?coEoc+ui7MYjm7DCUcDKYGbgTNWq7xaD75+6Y8jEOVy3HtDpysFuHkIAKpMI?=
 =?us-ascii?Q?IuiPsU1W3BOaxfo0Pr9sBN4Ke3wN3c66lAnqx1/JMeJ5TO8wBE5OTUZUIXSx?=
 =?us-ascii?Q?XzsFhN/hO4tLhloEP52zwCbgPjXcbmnxwSbch+1kzR2uGbyGGd5D1Vd1asTO?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DNB8deVI/XdxaMaYPvfBj5SjX0rg6idp6BUdSr62VNUN7BZW45jJ3Pi5zXaucsySuiiAapWc0Xzxoyj1qkvYrYLMFEIsPyKhL79EcnP0iizpdcKvZevXbcQVv4Pb2Livn55X5eWeA82OjDn2zUmlfgxbmYMLY0+xZkTBX9Gcrb5QMzNC1jQIyoO9KlkoZNdXFqL9T6K0gBJb4Cg4tXkBw59cEFVngydRuBP2s5fs/tL2+uJajHRwDFTAXDuYlL2aN1bsFSOA0+gxfc19Bycpzb9tY08XfpIxw7xcvU/M7F+Ws/ZO0Sc5HHEjRg0x7W+Tc1TcGu119P/8z7HmMBleBVq70PZAFHClLENPvXNg+nMDkDbz3g8P7UWy26mWIZKxzzK3oQT879ZRHKSNm64ibhQx8HZYeGhwnVURMndWUVlDzadixjx8UPzj9p5b+jOCZkcbV90R757BMId86vMfSwjQrPpU1wSTHfp6N6sUHjUthw/edyz3+hGE0YM3DLx2yYh7hABRzl16tkrIz9EvHNkAV/jY31enqCNIcJ0otrtmd5TUfhr91jLSCYaLpYe/dSnXkMAuDXixQJhYojej1pDWXeAF3OjhTK64wOt4IZw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe9cd0a-af1c-4c7a-5e4d-08dc0868ff1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:43.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwpDX/RvKuVY7sCkb5HBTpZKNdtmq0REbo1RT3Rz7DA3vSJPgvO402GxCkZFyRQe5LS7cLpmqupriSKAbQH4mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290098
X-Proofpoint-GUID: mwFbpxnESz35dnTScM-CC2ULLJfHAopW
X-Proofpoint-ORIG-GUID: mwFbpxnESz35dnTScM-CC2ULLJfHAopW

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a test writing 128k to an empty file with one stripe already
pre-filled on-disk. Then overwrite a portion of the file in the middle.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/308     |  63 ++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100755 tests/btrfs/308
 create mode 100644 tests/btrfs/308.out

diff --git a/tests/btrfs/308 b/tests/btrfs/308
new file mode 100755
index 000000000000..7d651b2b4c9c
--- /dev/null
+++ b/tests/btrfs/308
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 308
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 128k to an empty
+# file on a filesystem that has one stripe already pre-filled. Afterwards
+# overwrite a portion of the file.
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
+_require_btrfs_no_nodatacow
+
+test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+
+test_128k_write_overwrite()
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
+	$XFS_IO_PROG -fc "pwrite -W 0 32k" "$SCRATCH_MNT/bar" | _filter_xfs_io
+	$XFS_IO_PROG -fc "pwrite -W 0 128k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+	$XFS_IO_PROG -fc "pwrite -W 64k 8k" "$SCRATCH_MNT/foo" | _filter_xfs_io
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
+
+echo "= Test 128k write to empty file with 1st stripe partially prefilled then overwrite ="
+test_128k_write_overwrite raid0 2
+test_128k_write_overwrite raid1 2
+test_128k_write_overwrite raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
new file mode 100644
index 000000000000..23b31dd32959
--- /dev/null
+++ b/tests/btrfs/308.out
@@ -0,0 +1,106 @@
+QA output created by 308
+= Test 128k write to empty file with 1st stripe partially prefilled then overwrite =
+==== Testing raid0 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 65536
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
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.39.3


