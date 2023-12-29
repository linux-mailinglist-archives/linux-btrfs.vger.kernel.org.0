Return-Path: <linux-btrfs+bounces-1159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCC81FF65
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD6E1F23CFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181F111BA;
	Fri, 29 Dec 2023 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZMwo2rtk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cg0PbvOO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCB11C9E;
	Fri, 29 Dec 2023 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OY1R018015;
	Fri, 29 Dec 2023 12:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=qJDUIDtVl/OgUl+0UX+qwkgkaLKYgwxwapR8c//w7w0=;
 b=ZMwo2rtkzj5Heox1dgSIa7wP/TAcBzDuN2I96VB1KkMgRkS0zhDSdnZUWo/9gVPC6T1C
 if0RrhVKZUZ7Jb3rdZm49z5i7CRK6Ty4JUH/f2lHcddzyPRDAQOR6HiY4Y3Z9cBbkTBy
 oIfySeYfin4T/yF2oKDaj/6Bw419Mz4XfTD3Y8Sv+I2noZNn++O2SDSxP0g99K6W0/ZW
 V0rKBclhlcxLbZ6ZNkd6tOMV8GuNJTiPYT6CU5a2W/KHeyDzS0+GBEhWB/w9t9BYdPgm
 CSTqK6MG7FMqe7PuoPqMELFyheXEPso87PbcV7cXjkg2E1S0Tp334atFqZgqbIGRXzjH 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5r3v7gjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBKYB0029970;
	Fri, 29 Dec 2023 12:23:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v6a965mny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gycpjq6VzFEM63GSXl2BybV23vGhfaJrs60EYxPPIXigJkZFOhyK/t71wA13IhxeuQEKdgbIuRqfE6aWgYCKtDOdYfBnZV8v24kmY8gADre05xkt+fpUZypBjJDnak3WzDGS9TD1FmHOdOIve9ClUpNo3Gw37ueZNSFjOtHlPEJL1Yl3icRLEaT4HPwVd9xqYiWLynsn4s4H+BCxnyij6yDUqqEuKMdanoSb3bTx+tBCeuaek6i0+6bS6U6xNaREhW7G0oIeWV8uTTQqy0lrr3VsZnB+7BfULM44cmmcrWWHdUlEahvW6+KCvyAMvoNOapBaeWk/u4Ky8rqS4qof2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJDUIDtVl/OgUl+0UX+qwkgkaLKYgwxwapR8c//w7w0=;
 b=eJ9kFVm7pBPXwblfugUQTY6kkqDOFWROHj2cvK89/f8aSuTLvbd0sWnQshmhymGqD0//9P63MReW8sOkeHDM73Xurp7Cal5EQvX7vzdGmqqEbePuljf8RBylQRDvYXxFqZ3QtV0UUW0gwj6WBN343ndyYrH/XVm0UFaudDdonM9dCBNFJsAVn3kWkcxPWJi4uhfO5fKd8z/OxVhgcD2CZgg41aFTJAXt1dOfLlifnXuOjBr504ps4r4UDe3qtC6vN+SEkCWdxidzG0i7uP1WOyxwv4wQoLIn8h46ootmYgzBTdaoDIdyxnHvTUHV2rB4PDK2d82u6KD73KU1UwxWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJDUIDtVl/OgUl+0UX+qwkgkaLKYgwxwapR8c//w7w0=;
 b=cg0PbvOOJw+pP51tPYHMC0r8DYuE4lJDqtxq1wuVCZc4bNN7y99uEgrVz/O2Kkn21wa51DuwgE0AZ4cHiWjB9BNoOHiNbjE0eNapP9yWAZ6fVMqkE4wI1hfpoirwfd1CUugDiT1QWPq1TDnTnDv0pA483epe1PTEMNBGFM1DLok=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:31 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 07/10] btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
Date: Fri, 29 Dec 2023 17:52:47 +0530
Message-Id: <a2205087293c5686166c607a29d05c6bf4f73257.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: e98f8e4f-7b8f-4159-8695-08dc0868f84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uj10ut/UqV/Bja0V6qTUqR1Q7Mcgoh93kRaTempZc/NioSrgxJJ71hJ0UsiEmccEJyh5X2+XVDAnKdnL3Ip6Fs8iJIhSUnUKcGVZ1dSHaML4Q3zTTTZD9jJDNhpfzy/6M3Aa/LbxA7vrALjJAVUMc7pgyvjPb6MRzbiRQW/vLiP8t2izpw2lQcWfJ1q1lxoBfUwrE80O2KGL1xmbKpuXx9VWoEI/UeAcmimRYRBUkf+z0SCdFsIOtbbG+mLeO2xgUQsxIjffp543SRobDx8rslUnRV3ws/dyz6dZy2f85mdIZNtRML+b8K2JtPXjKQr1D5iUiFe3VGySeuAeNAjC4LTogGwelBk7KWZ8LJ9EofyXM5JdJzTJHb//EoXfYRGIGBhi/OgWiEOQmgsbkzCLAvdSOe4tljXL4X0PWmRnAmykIzjGRVuEyA+kLly7fd6bm17tP+0YpjSKang8Cn+TFWT2nO66WXpd4YsWZTsSGCH7KCGDW+yB1nfFBa5ZPkTy06QaYbbp0T+PeVOj7DmEmYaguIba8yxWoE5lha+KZq6ByYvrrBpd+0HTAd597VFgXoP9PTzy+ytfwNkMIXrdybBX4UsmFgeGjU5MeKGe+dg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+qd1XOQBw8BuHIn1/5eadbn09H/irgXd146gl+9Wp06q1BalUFPAMHPWB0PD?=
 =?us-ascii?Q?M2Gth+ZQ5WFukediQ2glKLI5KBmNpFdt2wzUCAUO+bhWPLkvOMk20aJQ/TuA?=
 =?us-ascii?Q?m2rU4tFmgkTjdQ7SghkYPLSnyvaywYHS/yC7eMTafc+0Mu0SiPag90F7gAts?=
 =?us-ascii?Q?HdWJ1qEOpTpi9qQGccF/XCXNO/xGrgqzTaAgo4s53CljRe0kZbPZSMxKNF9V?=
 =?us-ascii?Q?xyBEI98cdv6ViKf6gYw0W5DFHZnWVaCqGCHh4rTRSGNXA5vz6jQ14pQwID+S?=
 =?us-ascii?Q?FqGfG6Q6ag790pb+bsabQToOcxJ/q4jbHS0c/g2aECPKU2B7Tfhuh3RVRny6?=
 =?us-ascii?Q?UAOK6Bo+HAbDfbwfwSiwtru4zwGPD0lMfW8u49etuFZsuyYSvo9NLMdTiVEL?=
 =?us-ascii?Q?vFSKaPuBNPDAP9KNtP17yxxMW40H4Xl16s1FaR620ByPhp6XI3E/gTh3zEkL?=
 =?us-ascii?Q?1+mceviQk03xAubusjVhj6I1Es6zKJCkHqRzgvmHWHXix2lZu3qR4PxnLuyf?=
 =?us-ascii?Q?nkJpgZI7OqTqdq9pu5AnJrohJZ3Zv69widQPL2TzPwQc38NirNnF6peg9gI5?=
 =?us-ascii?Q?vGxIVO6zoExAST0Rpb5Ja1UL1iOi/JZmnY5e18fDx96Mjrb+2mXRuo6Hzpfu?=
 =?us-ascii?Q?ftbDbnoua6i/mTfLzgRnPPXX07Ac4C2aHZJiA1yGeeXvCQNlwz4jcXyFUReq?=
 =?us-ascii?Q?dFaVtPiTvMokDt9BmT0RJTnKqh6K5Vj/FHi5+G3I9HfGVk7PZJQFdX/qQoQK?=
 =?us-ascii?Q?1JATIBw19nP7zyXzLtg8gu1nZJL0j00wOHkUhmgguE+qRzysUUj4hol2BP5g?=
 =?us-ascii?Q?de2g8ScAAIKkiQodxpmxhUV1amhVyIxzFF6KB7KEjnsu2SvSp2hSUW9SasgR?=
 =?us-ascii?Q?oDWqrXFFQXxwpVbxk59MejYuRmjC27XQjBCC+2MxYB8o9wmhWkmc380xyrPZ?=
 =?us-ascii?Q?o85DXd4+QdsDRPWUpZCxaENVrDTQFLQfYqpvIvfRJoTduUkrmq+ZQk8iJZgh?=
 =?us-ascii?Q?oz+OT26KOwlh5B3zM791KX+kRCdHdUjKUbO7suUlyaEiezgIHMoSjimon15n?=
 =?us-ascii?Q?kzJvwj4g9Td3N1Y1IOLg4GJsfUMGgT3RWqfEyGu1D6cbeA8xxqImQwoLCRKh?=
 =?us-ascii?Q?3DuSLoTgMoU9svhkhT0+TRcqdA8R9m0+TVInM6ctjRbBs02oCT3Ral/Dxc8n?=
 =?us-ascii?Q?ZbjpwqJjEKj82tO4TiiAobsQ5hzHLtDQkJ3yWu90DwjBVXR7CgiAAUKGl1ZO?=
 =?us-ascii?Q?Ab0isVz+P+dvn4nYK2uAojMFWi1uXnDcm5kreiPdUPe7AdWXlivQwhpdfgtQ?=
 =?us-ascii?Q?TPaLK3wICULi6mrce5JzQGh1WVjSetp7Fiss6pU0Ue6Mm2fuRDm1+kxEd9y6?=
 =?us-ascii?Q?gIzd+Qph3I8ijDhHU8iYmLziL4fnRyu1oNLhg7DnWgSi++RAKq7KJahGIQg2?=
 =?us-ascii?Q?C3DsVlbFneCCGTGKNuClfytiS/CJJoxgj7iiSVompP/vg1DQQplINGmxFghj?=
 =?us-ascii?Q?P4P50uFmoNrqE6vRLvYdhGsEQcOqaHe/eqiswPNy4Dj2Dr4JkfTK1QvFr8zI?=
 =?us-ascii?Q?9+TMqtJkR5FkQXYRtEJrc4CcPYUNboJOe1QZl/HD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bwr6F3/FzGTvWrzenBx39pC8l3q4Gh29s2eKOcDyHwaEnZB5v9q9VyYHF7QFKexmlF/3Ld3cp95/2SBvnRQhL6BGHOGqCnXXHmNSDJr11otVeV3E2mLA1JeSqVKkGNkbyjTpCHL5zj0oO5Y+sh+HsLc6fEAaO+Rs1Q9Ra/GTV9hu1yJy8agtU4gV2JvmkFjw2Ca3HwRtqgZxJvPvZyz7iCjfBobmY6p5VTHNMBb0Kwguc6z7Dq37ApsQ7NRHAt3tJChL/UTjMa1xlFF7DXHBX8vR65e/cGUp/bjWV7NQGh2WlQcsO/6aZLitz1HqgEv9iBRKpQ7RrRvyrYQegMKsYWzSH0FbsK95hAJXe6UrFKylh1OEXoGWVrZc+6qjlhN/HR+EQfyh6onAW9G0/NlGDCl78Vwak0BRWTxslpEsJkYXpNLEFOjE5zrmBD8no0iPCcnuhX8NQ6fek/oGHQa/r0i4JLbfio6WIL+aOhrX/56atPvdehV20AfNsGHHfrZHx1u6dC095ADT6QylWrwwSN4oRadsir6GsO102IOogooBkIGJruWJVx91qDWjoQNvEwelwP7FMbpcdoQbVEQ9A0MsqJE4ua3koCYL3uzJuTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98f8e4f-7b8f-4159-8695-08dc0868f84d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:31.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGzUDyR0VLBaOsrYOoXKqRHKdwPowwD3CI6e+eY64LJ0IIKFLRD82wU8jvLLv973JMwPutsYD8IPB/lZjIoiQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290098
X-Proofpoint-GUID: KGXXxCGEIZM0ywRTtA6gVe3jiww1-Pdx
X-Proofpoint-ORIG-GUID: KGXXxCGEIZM0ywRTtA6gVe3jiww1-Pdx

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
 tests/btrfs/305     | 64 +++++++++++++++++++++++++++++++++++
 tests/btrfs/305.out | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100755 tests/btrfs/305
 create mode 100644 tests/btrfs/305.out

diff --git a/tests/btrfs/305 b/tests/btrfs/305
new file mode 100755
index 000000000000..f3bf0faa414c
--- /dev/null
+++ b/tests/btrfs/305
@@ -0,0 +1,64 @@
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
+		_filter_trailing_whitespace |\
+		_filter_btrfs_version | _filter_stripe_tree
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
2.39.3


