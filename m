Return-Path: <linux-btrfs+bounces-1215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1B823BE8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A737C287642
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF11DFD9;
	Thu,  4 Jan 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEUq5a+C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gmR/Cfb+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034C1D68F;
	Thu,  4 Jan 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4044ae2V030247;
	Thu, 4 Jan 2024 05:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=EOSbtE/m7FQiOt3hWnWaMHctLbJ0itvcjhLnpIWiwB4=;
 b=LEUq5a+CTjtqkmVZaHGPfmHZPL5GYQ7OIRZFX8rqi/IWFNNZ+LDxJckg/t57LffwMg7w
 iD3lLo7qDTR1ur5HVpNxzX3rtnblEUC6EBK3EMBmb2qpZUJ73/XJnN+XDgNtvTFoqQWr
 7WimuTA/oWvxSlc55ujbW9iyat8xURpOD+PDP58sEoDitb0GKetAB0o06P9ehtwMJ6+R
 7IA3rfvBU+hnedWLT/SfEDJCPTxfuRwwjjO9m5apEkInUCG6ALOpjIs+2FhwsP4MwEAM
 5EVtKXsrVm/lYqYrGFBRer5Xqv6ZiqMsENkiHW2qa00g88Y+stx1S7mmoYdBeR1W/XE7 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa03xdwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoG015771;
	Thu, 4 Jan 2024 05:49:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUtp9zUkkUj5GJbjUkoEthTawXr6k+t9ZQZrS+PIk3tMJgzl0V4hWbOvKpQ0nfrgv8+s84ou911XF2OJ8ZD8UvYO9D8vri3NNRCtalq5RwOwNdfWai4KdkagXprDmRYLhb19jLY4NKtcn/gPCVancUbaeoTu5Sj+lddredsZFaeKq0T9cVi9MsRSx84HoFHy89ay7RfPPdE0DSN+w/lt3lmAKVhtybcQjMXGpt41O0MOT7oztcDTVzUMGUjx10h5RAV3Vfz8JhjdIQLEK8qlCKZJzchbmxAtCv7ndqG6VnkgK8f+lm4ae5bAGdqwp1UwGnkK5b0Z5IFtYzQsNMcfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOSbtE/m7FQiOt3hWnWaMHctLbJ0itvcjhLnpIWiwB4=;
 b=gyi0S8dRpE+NBG1HFGoly/msq/QAztJifqTwzoG7Ts2Piy1/Qq5Y2hlVf7fHyoTD45+rNJD7hTN6l/syf/GCBbm0p081hxOzCrP4pTXaGeJIT325aKzA/ZcfwlSKSmLTfktgPuDDsgfy4XETkgcmXkJpeIvWen15/Aa+rv2tBzWEgP80yR2jQnrOkfofqyqembLstNyzRRipmVVI6jD7yHTxTO+EvM9Or6Pvww7UxhivtZtq28ERRRItokwfPaKRS/cKikPInr1kMpkmn1l+2t53VFQid9Eijuv698oWRX/TOiAHxL2FSrPZYLEDz1K4jpJhV6nU7dGtpTDkPfXODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOSbtE/m7FQiOt3hWnWaMHctLbJ0itvcjhLnpIWiwB4=;
 b=gmR/Cfb+VSwp2m2eMerNhdux4sJxSrBHfZJsFi0aR/JEi2j9zji6J3YDwfgqIuZCSN3EuFiBsKsYOkP1+E8bGLV7d82QyNZUk3TpjWGxjoCRg2YVW8RO0bTGiI3V9rmTCFhvPrg7yB0RNfqtHbYS/rabp8yMS6B6DcRj0J5NNqo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 06/10] btrfs: add fstest for stripe-tree metadata with 4k write
Date: Thu,  4 Jan 2024 11:18:12 +0530
Message-Id: <a4728ceef4f8ced1c384acf778a5b66f4803225a.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d99735-9a11-4f4f-872b-08dc0ce8d5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FjtkNjoCcwrf0joT7T6hXfJy4vx6DID1to5V9EGUtvg+PdzhRIfG0THCH3mVZWhDUZu0k80oyNMCe+qr2J33VMdq4NvhAgvVMnHhnv86wLlm1AzzCXK16BoUujNBC7d1+38Lwpa6TQXALXgNMGNxyOuHLI0YoEEQiezlpBpr3FV39qCpe+IsVOTh94dFaU2dAtMm6lcz1gpOwMU6mvd1EY9A5BnRIPpUnUJyo+5SCFfOcXWVI7FPhTFA8ukQGD1QDHpKnYtBLp8T0mxmqSDTdeHc/xzaIoOSACTb9yvmDoQBThOE2ICnaxGURKSIODl+VReaKl2l28P12CrBfxWois6NfLOnss6gNI2N/WiKHFrmYqQfpzCXcIEPWDzI0CdYUUYVDWOz92+gxR/WLVFBawb6OHAvDRL04qNy0BE0upWnDhWbGEOA+I3KPuD9KDxCkKPBom2/r66HTcsNJ243A0GeEF2EApZQ2r6oK+QUnEdK/zGeY21ZBgLpQfB2l6IVll9c8Z5ttKD7qU8jEqrB5U7iyMPLbLxBa525xeIEYPV7jjmxe0+1Cy5p82Um+iTFv/jU4unbGsYt9rYaz6viknI1YcMNLBEVW4L9qvyyAy4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KFQXkI53Ys4lsIFuXPY1uOdkXn65nZxlYe2PZYZdk/DA8kAcHvEJn+9N8l71?=
 =?us-ascii?Q?xDxJ5LlI+pH+UMBocIuzLEF1DWqc7/FIpQHft1tEli4mHD2+eJK4QydVNpth?=
 =?us-ascii?Q?ICRvSSLKX0Fb0R2ugPaiBu+R3aGVWEVfKKpRBp9OWZ4iyLV+yJvopSaIGIVK?=
 =?us-ascii?Q?NtRaKL+45GExvz6c7X26OMLp0vY4G4J3wbZnhR9qLNzjdzZfiyIQRE0K+3wO?=
 =?us-ascii?Q?IeWJ7LXjBmDOCLh7JnbYVWrZau7OnOF2fjgrOm0r/6RWprrWDplf/TRypKVF?=
 =?us-ascii?Q?HtBkMnKtLpTKM2ZsIvO4ZnEgIvQhYeCtZh8K8TZOquA+cjZ9Lid67VaFj9MB?=
 =?us-ascii?Q?bWLzeAgv+bmXknlbUHoJn53/G/ogFwHsU4GZtr2kyPvZekqeKSkinpu0FeIS?=
 =?us-ascii?Q?d9I6WLsxn+RmGGOK9snBu58Rw/vbjg5a7TFXZALMfN+cJK+XNAU4LfkFV/S+?=
 =?us-ascii?Q?BYWzQOpmxJLKwb0zEmW2SscBp/Rq3kz6+K4SpTjosdFBUCK2vkMDmGtkSeRb?=
 =?us-ascii?Q?nK78zt2RLo2zZZgJR6L/imEKqYlx9c0C9IGB/S9By/+Pz7zhsVKsYPC8waDa?=
 =?us-ascii?Q?/Xj6n8TCIZ6dwXm0e6suftMGez50v7nQoo8D0XvVHDrxuWREdI2SEHtO5Bal?=
 =?us-ascii?Q?3Jc1mqcvIAjJlggpLfxR8nxvO8G38SV/GUK8Bz4lRGDUEtvquaur7kllCfHf?=
 =?us-ascii?Q?c86QZRoY1P1nr+hSag5WiXVlFnEBihaD0qLNNgKahuWdTwkIw/hVErXfga+3?=
 =?us-ascii?Q?pt+BNAU/MJhTPBUclaP1I6qeMhMxPeYQAT2zkPLms2IpMovQgwk0N5R4moqX?=
 =?us-ascii?Q?oYfVlrA+t7Ga6lOd0BqPeDNuAskUnEffxRZwhpITPBfZLxWAydScADHlhqL4?=
 =?us-ascii?Q?dcB9H3k/9CUuHZKds8P/YDcRx2nL3uza5IpjNZjGS0q6Q4tuFtvR1Iz2l9eh?=
 =?us-ascii?Q?I6id/Tl9MjhLfsoJSxT0VfaS8hC8YaXnLufmL5Hn7QXZQTttrwTAmg2RnHgk?=
 =?us-ascii?Q?gZKLMD2kzUZys6XoYb7wC6x7/7zxTjGrOm/qZLYnrpX3gxw3o4GKo4Wr5dK2?=
 =?us-ascii?Q?CY5DCs9P91tHz2puO2/hP70S29W5UsLHJcTtuk3JGQpHRjw3HW5NJUthOcGt?=
 =?us-ascii?Q?7ed8EMihg3OEpWlJY3sgwDdBF9Y0emOW5Fc2wkVH1UlC4novy4jtoeY9tf1l?=
 =?us-ascii?Q?iquU4YZDJYw1nSGF4YzoJi+2sYQkpvPMuSKQKPiIfS/iUrlVHAoCP4yeT1E7?=
 =?us-ascii?Q?rv4Ovtnn/JffeMAKYXCF7Py9B632geW3nsw9RgEu7YfYIRZLoBZQMsf+ugDd?=
 =?us-ascii?Q?SHU5RwGF1D9fVTIwnrQXtSOg7BZox315z81vuH2uVwTOQ0NRW4IrSLL8zpvq?=
 =?us-ascii?Q?cAok+VKh7t/DeG6FPAeulPuenA9tFIWMJBnzmwxiIgfq05b/PtWI+scVGeJI?=
 =?us-ascii?Q?sd9lcDWPijCF1mRtVDCBlOmV7gnHpJBz+CDfBB4Xqe3DdPq/tIMFE4Awyabi?=
 =?us-ascii?Q?yeHr+v950grvTYDb/vj4OLLP6AkSl6LTVx5V0t3Y1++PIfMTJ24MdDdjhNnN?=
 =?us-ascii?Q?Fmq5+k9gxferc+AvGbXpgmW4if3FK+59vgHMVRTa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/wYgVgOeeVwShYhcYB483T+FqUZYP+mjttHsFbN9WsxmVQGNPl/KSM1FFUzaLs3Emcox3lm9MySKSurHpkFfmu7fDddvkVzti3SXic+cVv4ZBaHKAIAqVafQHvJLX9wgFsl+VqdqcfUzJmOo4au1M2zRgWu/Pne153v8ls1UVXN1Z74pGGKnyanLfdPAQnBOr6Dc2pgrcY5k+arlRI8qgWR/1MNSzfH7ty8lF2DIRTpc6a09B73Fnyuz/y2N41KGR2wYF9AloZU5RDzOulGRuu+zst5lIpM27JbbMLprMHoBAREcKLbFc5YKFmt4miY0/NkBR2toWJOt5upkMfOfk8NdVR8enilV4Br5cF9Bs1Ca+Jq5bo/LFrN/9C5W4duVwvFR0xnUkOh0EqlakF5ccrVisXPNph01uoJlo3h71ZRpxXa2dlmuQAraMRRAXNXmH5aAtkaYh935M3M+LhWnEu69w+QV2+1aYrYe78VTDDkZPor/pyCLci3k2jRElzcFLc3n158OMcMfyRCUG6emvekrcQ0x6sQNoG5kwbAA4LyP413VHIXBEdFwX41TzOY+gy6uYumtwAATnlGaGENYyESHqnWQUZLnNRkeBt0Ddzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d99735-9a11-4f4f-872b-08dc0ce8d5e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:54.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npYiaMPD/cl1McM0bzZb8tVhsKIXR6xv6Khxj4qtlWYTHl3BJu37RzECLya93bWfaiQDubILvkoztRkANCts3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-ORIG-GUID: z-b-yWiDTmIQ4Q4T4LXhsd5rUUgsVZGk
X-Proofpoint-GUID: z-b-yWiDTmIQ4Q4T4LXhsd5rUUgsVZGk

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Test a simple 4k write on all RAID profiles currently supported with the
raid-stripe-tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/304     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100755 tests/btrfs/304
 create mode 100644 tests/btrfs/304.out

diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000000..1ecc528d687a
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,58 @@
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
+		_filter_stripe_tree
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
2.38.1


