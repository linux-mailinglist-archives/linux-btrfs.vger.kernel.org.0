Return-Path: <linux-btrfs+bounces-1158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E994D81FF64
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C81C22263
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDC11CA5;
	Fri, 29 Dec 2023 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ca/HkPcU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vF2Ajh//"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5011C88;
	Fri, 29 Dec 2023 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OLqD017923;
	Fri, 29 Dec 2023 12:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=oRc1cYCH3nlfYBThCyXSPFVwjEBEiL0o7BdL1xWbeog=;
 b=ca/HkPcU/kKu0jYtVz738bImDjVC9fyOs/O6ZFzVycxu2nlV8Pc06ogUNQSbyVVo/jya
 bGuxG9swDI5AL0IuIQDgwwYbNyvt7uCOCyME/EMyO2Y/+hxksb78s7ug7iweYUo8jZ2A
 HGBft7HfVMn99O5wai4ggJ/n6B0gBADctki+jOcZLRiixQSRfUvrmmPvCKdQ1RxPCq7h
 nPZwlTjKfy+NtxH4Qx5N/VPYHrvkb7BCFOgMGyeiDyl1v8J3/dlta8NrRKJXe2G6X15T
 4CYNY50SOjZMq17Cus7kA8+p6zOCd9M8wDX4dOBKO3ortuZjDz5UzO3OwFpYbQ8eDW5t wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5r3v7gjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBp7rL026866;
	Fri, 29 Dec 2023 12:23:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0d86jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlCH5bHBWLwrP5h1aY2nAOL3cZiPi7IUmLTv297FUWXIq19nemaaDAQBPL2oM4zbaeWOQ2aLnzMdfPNWLaWoZvp0m6tq5JCI3+slzZkCzZj3usyKICPq8Jt9FVFZygtAUlD22/I1GZFrLiGC7AzcMdQnPb57bA5+8mThawGX8ixTulgDTWXV0TjoWEhJCKeySBwTQkbkZG6yUQIbYPZTfjnfqZca583QYo67uHvNfKD2MB6B5EeR7f+UN3B7vB/7Zs9aiksMdqJigYdJDMOCu0Oj8ty/00cFqZXCTQI0on3xUiZJdiPTZLiLabfu4fsoCuei64hlR/dbkpc8ZuCb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRc1cYCH3nlfYBThCyXSPFVwjEBEiL0o7BdL1xWbeog=;
 b=cF0wlfXGUq51hlbqifeNpqGdyHDOIS6efBn6XBDKDn/uLk+MG6QeZt/aEmwSpuZwUcAD3LNKxMI7CmiWjo071UKnDn6Tb+NFGT96YNmp/ISMZpaqS71REphtsBS/C1urjFrYLlzq7uTfXRcjq8h6erAqNZbdpQaHFwuCudfqlKJ+vkwodfoU9K1j7xXkwI0vFvevaT0aG0SWqD6jz57dJP69Nt4fmNUFt9BW90rsH4NHfi1i2HtKfhP0GLMpxIAV5pK9yssHZb3U9IpBrkc+wAR4i5tXlputrxUze6miLFY2xmcoGw4O8q3xmy9ET0MU4YkpRsRiy4yTIu5biUJxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRc1cYCH3nlfYBThCyXSPFVwjEBEiL0o7BdL1xWbeog=;
 b=vF2Ajh//kRM3iuQX7lsZYmDqIDR8raOeo1C8urt0jFp8ro1wGY/xyZ8V5oVMmIoXUI07S2+K+pRfC4AE/Oz3zUMkt7n2bLIQxIsQ6oRgdlCBa59uK3DDHP/qdW3DvOigO8f4kxKCrAtheB9/RVutoBXpg6KizCCgM8FEDJzG7Io=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 06/10] btrfs: add fstest for stripe-tree metadata with 4k write
Date: Fri, 29 Dec 2023 17:52:46 +0530
Message-Id: <217d0635de9a5209fb2dce85f29e63fc91bece55.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3131ac-e726-435d-fab7-08dc0868f516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kDoNICmHcNSYu5qdZZypZljSafE3D4RqUQ9O423Aw9XAxZqZwvkvjLKjacHkPU0RRLTWjfME8nWmC6JglSzwnfxKQ20TbLAUSJfw9h2sryX3+BCWJC9pdv4bwXv9aWnfwc72OdxHcHRSay3+1wtGDjt4Jf+w045wJ2sT0Rzxdo8pn0W66BcMs9AtcFzOU+CJeLIr0paV4cxM3DqwWOl3izGsLWvSnrj4JgY9bjzEBfGTEjUDljx0EofzK6yFIA5Cq4hkuPgY1tNxU/yHXz/xKndyud2pDpaWo8hNhhEsiYZIZC6Afq0by2oGpoLDmyZNJxYjiuDm7Z3MmBtobW5koEis3yHGHVvP4eq9HS/fQMSPs3/bRdBdFfHlnG8I2q/aaj8zV2P1I5bwTaF2UY7wfbM9qcpI1+SjCWiNPCiikfAFFEFwC73k+FaeoV9JXUk+cBwbqm8iYt70g760g9zAEF+L8YBS9Dt/22q3QamCFB95Gh1/3wonAcwXCbTUDvbpiGroWSuE2O1MerMRfHxIl3UYXBNCFWQ78Buq7rwOeUP9TClAfbDqcItz09Z9u0OaMgwqKhcOq5bdEj755WbYIiXcPqW0SCToHgOAN+hn6KU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XZEc0P9JGNwHmaPo8NxMxIWJB9TM2OI/GhupkuEKN3hTOeJgw4+Xh8tUta0d?=
 =?us-ascii?Q?0ZsbYvvIPM6ouy+laD8Xqire5q1B+ozn/hsxmgx3Ca2eLoaOl50ffoG3x9PV?=
 =?us-ascii?Q?2Agb/TtbetPMmMG1LUiV8nQpzhSxbs2lZ+0hDHTf8uEWIhVF20KRbWs/NbDD?=
 =?us-ascii?Q?eKKqrOkZZuioHoE/Kpzl4LgCugWxC4mkj+1/mhvNzvs6z85S7mnuvxbgGtnk?=
 =?us-ascii?Q?XBqfQVVVaFhkRr1/njIoRZlZgKkkrmstywWCjkn3oFR8qx+bcbj6576vHTYq?=
 =?us-ascii?Q?2EoFw57Uv2YbMpaY+FR/LfJkvmoRH9YMPWBDAF/vM69Yp2WoCbkjMwVkVZCC?=
 =?us-ascii?Q?XSqBmO7PXxs7xELe8BisDZZaZS0lG1TidL9jZuNILIH4q+H4xzfE+smqC7d5?=
 =?us-ascii?Q?kvvzahXb3LVSGWLBySWBQErGZ2G1PKvJyEA2fokorY/eSUwF0hXUZzMRnsqq?=
 =?us-ascii?Q?/zVV63pdWp0giqlnpSZQAx1gbaTGnobJDMCpefKg17Qb1faEe08pWx/DGUzD?=
 =?us-ascii?Q?7zmTdjF/Z081gBGMBavkY+d15fswGF0L0wuQZAwGljEcVq8AJbSB8hh+tvW+?=
 =?us-ascii?Q?Y3GYydwW2hTeJnWQr18Q14nwSl9PLbh2gq0geNGmckUKMk8tZNfpm+AYGTm0?=
 =?us-ascii?Q?EHTCvh9DkrR6m8uWW8RJDt1jlcRjzdib2VeFmO7YN26C49/I2UIR/cemQZ26?=
 =?us-ascii?Q?DYHMhZrx0XSHmSJTPwmLjf8XOvqjorTzBGU4RVisppSu0fI0D+RXFnnH2uTU?=
 =?us-ascii?Q?KjUfOxpC8026RWYCeklDxjvHV580gxzIYS0zLxD1S/JXu+QkM5Pff7X9y3o1?=
 =?us-ascii?Q?ApdaC18BBCvxYzn/YDfDVmInfjHnflVeODORgg56fEpZnN4F4bm8tkrpGOQ8?=
 =?us-ascii?Q?BHBwNB9Y7XBNRShKYkabwoQlBKvoTS0c2DL6rpicTcZrerW8jrP7sxwBKWXA?=
 =?us-ascii?Q?gkOJYRqd+TWijMc+HrCWhu691FhtxMpZ9Xcla/4HbeWRNzMCtS5b2kcj7WHJ?=
 =?us-ascii?Q?JIrbNwvhOi8fhw63aFNgJ3ckTOg/NKbhKgvOlJLR527CcFW1RkdZG9SiTO+C?=
 =?us-ascii?Q?KslpRsuBiS8jWqqN9+v3xtvSaQc6A5jMcaH4WH/0xhXJSNjzxAAN4ulwumha?=
 =?us-ascii?Q?vSTwu15smngB4EHOtOq2DjA/o7tOiSiEaetiDQHmN0fJGa5G70e0yYKEOI6p?=
 =?us-ascii?Q?Fx91j7kg+OoXzeNf2m6uPiAMiPkidKq4fWH2QBQejkTIDlE32ZP+eD3Jyvab?=
 =?us-ascii?Q?rRH8SXtOkIQt7d6GZaQvjfQuZWkfJD4vcgL++UY6+XM6wGDj/nA7i5n27JyC?=
 =?us-ascii?Q?LBIaDKYxrlBeaxhHHS+6AdFYpjQC6usdP2y1QsYMy5thKGx2P1r7z/iHrKTP?=
 =?us-ascii?Q?NRJaw3VoP3Lsbzke7W+XV+p+lYRiGS2Yu0lUpY76alVq9kct0N4YnouWYVoo?=
 =?us-ascii?Q?WvkoS0OolIlhSlHxekrwlDIbtENOflBaXq7/+4jjX82+yzleN9x6X0f0Lo6h?=
 =?us-ascii?Q?wNYIj5QqspN2VdRfb8YzgSb3CR37CmbF/6QjC94hAUdDEYYtn+0oKHI4ucq2?=
 =?us-ascii?Q?vUTVwu99iTifj11vn320FCTIXlMyXOpWmd1p+IMe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZQ7mRdHV2mbKELEus6nznMqJuJtbA3wV3XmblEGdZbspY6LZDksq1tf3RNYkTtUOF86t9RALl1o9tssiiFwB78NSMw/CEKR0AXFOjx/E/YTFSxWedsEHrzgHfet7Q+26C8Rcqi+wa5OmWCaoPQTnJ2VU9H4JIMu6iE64TwhajH2LgS1WZywdcefvyRbxdWbHKuTcIkVKCv2wywNja1XEmaT1LixFCanulmVU5MntkSJA1PQaAsL99d5BiDqoBR+usjDCISft8BYkTz3THIqmBY3kDpOjCpF+0l4pXQWHL87CdMzbJ49FiY/+ReObTJkdnwBhJA4tFIsj3OEGMcK/FSjDPD8H8wmca0NlUyAERn3P9zG/CJwasXDWW2RdtYovyfbayexo8jCXzAOji/ARpffJszu/x8xMryCwbtdHclNGaNIpVoSkn8Umhz6WQA2cQ+YubSzBhFZh9Qys9ncUQfQc2EToOILgkX/ro3TN6UyxLmTeW8qZRuwYQxt8cin1zuxgUtnUv++Dr3BMlJaa9P/YWxjpaM07N7pUIfnDFrEtQky3+7rh/9XIAWNIErMqZt7HmGa3c55EFIWCAe9r3fPKrJl2tEKgV99vhBC85f4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3131ac-e726-435d-fab7-08dc0868f516
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:26.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUluicxC+rDyMvBy1GNEeRTS2Bfzi9ibCPXzw05+YJZIEKeWk+b3fL8Whe6Kw56V9NUGj5zmXFzNfOpKPNmvjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: jKlV8PY4M3fX5iCNYq_8gejYpTHyRilz
X-Proofpoint-ORIG-GUID: jKlV8PY4M3fX5iCNYq_8gejYpTHyRilz

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Test a simple 4k write on all RAID profiles currently supported with the
raid-stripe-tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/304     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 58 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100755 tests/btrfs/304
 create mode 100644 tests/btrfs/304.out

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..186fa1646e48
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 304
+#
+# Test on-disk layout of RAID Stripe Tree Metadata writing 4k to a new file on
+# a pristine file system.
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
+test_4k_write()
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
+	$XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+
+	_scratch_cycle_mount
+	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
+
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
+		_filter_trailing_whitespace |\
+		_filter_btrfs_version |  _filter_stripe_tree
+
+	_scratch_dev_pool_put
+}
+
+echo "= Test basic 4k write ="
+test_4k_write raid0 2
+test_4k_write raid1 2
+test_4k_write raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
new file mode 100644
index 000000000000..39f56f32274d
--- /dev/null
+++ b/tests/btrfs/304.out
@@ -0,0 +1,58 @@
+QA output created by 304
+= Test basic 4k write =
+==== Testing raid0 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.39.3


