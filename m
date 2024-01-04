Return-Path: <linux-btrfs+bounces-1220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08B823BED
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60701F26AF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7311F958;
	Thu,  4 Jan 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyT33t0G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pjBfdKIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453591DFDA;
	Thu,  4 Jan 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40433ojp006640;
	Thu, 4 Jan 2024 05:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=VT/WXzOhC0mvXN7mFGMtAg1qZxAlXLSxYBoljRC9WmI=;
 b=VyT33t0GIuUx5vJNpmqAQ/Rvx6ndBQVod1xiKgNAtTTsIbmJCJz2BAEKinXK5eOnyDkg
 2NWuw07+kPChc/x9PZ7vMbjg6ydyqY1Gz6VtCWFhUC1xhT9oj+y8ie/KaEFQTEF1Zlqd
 kiWMsZUtg9b9lHfw/gAGiPKav72mZnCQouNX30DRm2c+fYPpv3MIDgTg8oQMkwf/OPCG
 9UV1RDXZcM7V7xqSja3X3/R4FpL2skwZZxPmL+u4K8jkQgjr4K4Yg1gj4ZQ6HJyA/Ma7
 LmwvjyKfGfEQJh7aHWmpEPohbNiRBYjcJD3Dt2Cf996rAbp1QRbJHBchG/49XMCx2zVt Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t26fe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoK015771;
	Thu, 4 Jan 2024 05:49:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfW4i7HQOOAZsR8SNTbnUW6EKjVGEMXpLidrORMv2JTpMXLZcXlUCzaLvJ0qalknyXeKfwG8+BfSGcHWIjt/XNy/rXzSqdWxud/DOrhD41oYSvNX3jt9qS4Otn5J1q/LrXtLrPbC/mbJmws3Y9QOPtCTexVL63/iQ0dGbsyi4LoR3rap7MIpdfMZaTlKkeipld7gZYXdmWbTyA/37vGDYczrzmm1fyF4cBBvMKg/tLSolQvTQOhpMUuoC+a3nFG8vbeW3qTpb6xPffTqsVD0vWR6DE0hNtXFmUIwjbzplEGMMaIm7PTo+tCE4eHsuPDDLOMN+JLNxO0TtTZSQfxIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT/WXzOhC0mvXN7mFGMtAg1qZxAlXLSxYBoljRC9WmI=;
 b=Mj46DZk0BpvErBJx+A9c3xb8sBRDdR/VQ5l4App2O2qZgcz5ApGRHFlHArPNrD477MzdKj1OXR+abuSSJmw6ri7g7WPYmJnXedC0DeUX1uNSQWtW5eDkZn67jre1zqYuR577ZiRA7uYdtxfui8iHEkXTXdIyr2h88JDMyIgJSpxg6sMG/5rp8GeXihFgEBSDpj7+nerKCP3pVhF3QfwJUF9rkpfUItOdNT1ZhIsY+XuBgY1FOHjVCqIacDUuKY30nWBra/kietHHNfsvdcvHIDZcu/oorVNzgIm6Flkm9FuZEBTKBmnKKGL2vsHw7xZwyw/F/E4ybacmNwMzR/3AvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT/WXzOhC0mvXN7mFGMtAg1qZxAlXLSxYBoljRC9WmI=;
 b=pjBfdKIk6F3u/McJVD3Tg6QpVORizIeHoYZPHIblQOLPHVnSSvKxQAk+Ahi1FuZ+VnxDdp1o9ddB4p7T25NIrBfne5UM76BeoiEhuwOJP44oHRZ+Ca1/UV3ZN5UWBlyLVD3SRIOnadMnErYE5xKn5I7Grumo8yFJJtjthztESZo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:49:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:49:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 10/10] btrfs: add fstest for overwriting a file partially with RST
Date: Thu,  4 Jan 2024 11:18:16 +0530
Message-Id: <268a2a2a0e389e4de088a4d85ea4dfdd91bf11ea.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae21a44-7371-431f-8a65-08dc0ce8dfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G/boUEa8iSdVYIlg7zppgUDOct6ASSNnBlOl52J76gxK4Ni4dca1n5fXNSyfMYfdCUF0LdrFc8c6/IhPH70vAC//7s7vmMKj78TwWvumMLxU1fqTAH8r/uSy5O+pP9jUBW9KAFsBVlAEklvXAMqt3xvbyNFY3zCgApHd9nvSOWiLXgdPZcalqmFEt/Hvpgd2LT0dH8eCDjsOePNb0fTNXyBizehXUmMxg2J2czH7X8pkoRfgCWo+gNS0LkiIViIcrLAHpbiGuW30gt4N3SdBp3QSP3mvf4wbUDeFpMeyU5IG9Dj2GfNC+0DL4XhFL/lpQ50bjgUm0G6OyIUWYVnYEPLMsLADyd5KR9J+0MvPzXN+Zd0jH78jgTC1Akgczbg0E2OBua6J82bTjxwaMglfHPlpVbsWxfkJV2zl3aW6lKrvx7bh2Hb5c47oWNifMY9V5X8CvfqgdEADiwtsUk5wbd9GJYF4k9SrHs6L+0VnWbUDRZ67YtZtBOn1Zp0PoxQt3LgO84Dgzyk3tMVOVntwcu7rg49Abugbyq/J0xpsYtNiuCBEfgF5eW4yPPgPRO3po0nQJi7Npa3D+zkFtIf9E02voJ8Rc3FYBIYb61tmBdA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(478600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mU2mfpkKA00J1nTm+HJeASM9cb6GvC2ztT/Qo/DLfl06RmhSKQSMCb42P/jM?=
 =?us-ascii?Q?IvlYN0gyU3u+FQ2dGQGqgxhdooCp80Vc6EIi5vhggJFiRZHRW7OOfYRL/aAx?=
 =?us-ascii?Q?IKev3RsA8vvRKKyOGdScmUP+emdZugSXTTkF6EEbKEQp0xyGjQAxk+47pjS+?=
 =?us-ascii?Q?snH1iVnMKPl5+MstI+66FCrlwo+MngK99coJ8eihi7gID3wGtQYQK69hbbJw?=
 =?us-ascii?Q?heN7dAF+6fT96HJAfnHs/jEUaj2BSBkUf8FIopetTOBpPoo1LGhKYRCJWntU?=
 =?us-ascii?Q?yohW+u9GwEsJqAD5f9gTm9+tdmZVSND6Bap2OFRRFgMtPIOz4jcUCq0XhZcN?=
 =?us-ascii?Q?B0AyJDhh383x9IABKD1XCadqEs5953k8V2ZSeARfwVjr0pw1qSnLMZtCCxN8?=
 =?us-ascii?Q?V/Exmpi4ziDrS3M4p0kwcDJdT4aHozAOr4c/FC1sj9wT8U4UN/JT1MYAmET6?=
 =?us-ascii?Q?I5CeueDAiZxBHirmEGDZcCbMJ8MEJxKvVD9R6JJ4H0ikrpkOuL9o14vsabgn?=
 =?us-ascii?Q?mIBoiOm1tr9HuzNqYxOb4hMgXX2f41qKGX9agvGxCIbyLWx+9VdyRQTGgn1N?=
 =?us-ascii?Q?FGE3rQOr7lpaMTz2eyqO2AKfDQ/cqwpPFs4Shkm0Sb2at5Ukau+U3nluwSMc?=
 =?us-ascii?Q?zi5Z8dzAaiAv508uBRT3BIltWFoXfG/ZyDKRFEse2EKZ5wNH64GHgYsdjmHB?=
 =?us-ascii?Q?V4veQNW9PeiiYCl/oO7pptxtqD3SXjDtQok64lYQma4dQMqscY8B/xgscQ6I?=
 =?us-ascii?Q?wvxE2qmP5hNETzMQSqMIl2q99VA9PbBiT4zoDsNOFPbmJg2Y/23nxzV6A2BV?=
 =?us-ascii?Q?oA68/jTuQGu7wrBVzAcQQm5ZA3xhvXCsxtOhLHM4r01dHR+DHsvzfkSRZw6b?=
 =?us-ascii?Q?Lv8EoQntsh7GqfdXmdj9ojxXu9+gYqipzpWZMaOX03ceSL2nx3tXwoq6ghMq?=
 =?us-ascii?Q?QCkr24FDzoZvNkAtO5SE71na6ERX8otApuE1y+v49GevEKpr5f//VHEAVgOq?=
 =?us-ascii?Q?HLMJnrCA3rpls5tZjCu+fg6TCx0nESbRZ3ZsOmSWkCyXEeI5joBLrWEiBdc3?=
 =?us-ascii?Q?hhHqhNdSGRhS94oACaqCZTiy0cJQ3EPSDz6yEyiIhE5sp9RqODLcOrOr/QoL?=
 =?us-ascii?Q?WevZE96AaO4LnDq6YZ+uihjOeWosaOaixJ4Vp9DLS8M9HIo8EDcbhHiQ27nb?=
 =?us-ascii?Q?12SFSQeo0GlBIkZcIwieOAYvdO9TCvc4/rtfzWbOr67eR2q/MokDCaReO21O?=
 =?us-ascii?Q?hN3EJnX32wbD60fyoNZjy5U2BzNKYlH9Xz6NfwNme3/32DCL3lMVrziA+alq?=
 =?us-ascii?Q?yJLbDuf2l0MbxfJtsGb+kBnvTyB1Y8QGwiSI2xGPT+3Jg74tSx8bk6h9BEcW?=
 =?us-ascii?Q?6LB5+ykDoDFRiYL8GmN5bscy2YsNJwFjxUPVQBJKIePGi3VRu2qSgxTYHBac?=
 =?us-ascii?Q?S7L77tuVPMGhxMqd1N6ehSRRM+0mTZO2NoUDWThRCD19hsB6dWuGBO6ecj/9?=
 =?us-ascii?Q?CZW+5zjTX2GgjXlOOSdQ4G508rhZaAwS+NTLacS265TnQFA8uRgatKxT+WEj?=
 =?us-ascii?Q?R3+tOkZrUl46l3dPfjP5PL2UCki0fm5t0iY2Go/QjpdNzacVlMEYSsMoXlyF?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	31Zqcp6yWnorbuoc4Pw7mD5BR0FOsm9OCym9pkR7BmBVbit5bl4vw/9FLFCwtTpR5maRPQfZWY15H8XsRBS/U5lhN4xrhsIu+G/Y4Sa+3bicvdGTg4p4+1mc6mXoKHmGQ5uMVAShFpKfArEFMSfnlxzhDaSCpNydCwfXsjMhGQX78O3AJM3UnxM9xm52zo6yWaG9MAjj5ulnwOJUnaonAUhRvL0vzWIaz2AtQRmH8YYrur+/mUBdcaXo2v3ZGOzJ2NOUlmbqBp1vAt4CXbQ9RGqUJmz6p64CIzqaMoe6F5KSlvA4zf4l2FldzV1nJLqYtQGyvKzPHK6i1iGqqrvzjJ7iJmBcl0KYgIc3UCjFcpE/vOcjRWm1HPY3o43hCuwwUQZL3XeuGHbXNdCaVecS9jnEQDknDlTinwm/q6qK7IgOVNEn9IelJSq+CsC/vwXYB+2EIG/PrDCXWUEPE7Wv6U594VCdwlaf+7Go9jzHQDALuvFReLS+5nuvsJ0LL4YHQgQkXsUorZdtkN64QkdaTT2hbOUKZrXOVKtxTHBsYBoI9/ya2rHHkMupjgRrdV5h77D0EvyG9Oexj/QUq60jHJ8H0o2mLZ4aocuQGvYr34g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae21a44-7371-431f-8a65-08dc0ce8dfea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:49:11.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JG/bY/DVobvsjIOUyFSL+cWMWYC1Ufa0A2AGLZL/mjYT9QT/qLOMFU8JySgaIfAQEkUO3ESRL+4iVO8RKtxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: aOBoTAZnJPv-gjQvZ87s3mLunIVj0u2E
X-Proofpoint-ORIG-GUID: aOBoTAZnJPv-gjQvZ87s3mLunIVj0u2E

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a test writing 128k to an empty file with one stripe already
pre-filled on-disk. Then overwrite a portion of the file in the middle.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/308     |  62 ++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100755 tests/btrfs/308
 create mode 100644 tests/btrfs/308.out

diff --git a/tests/btrfs/308 b/tests/btrfs/308
new file mode 100755
index 000000000000..ee9f15f00423
--- /dev/null
+++ b/tests/btrfs/308
@@ -0,0 +1,62 @@
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
+		_filter_stripe_tree
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
2.38.1


