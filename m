Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E670D9E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjEWKFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEWKFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:05:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9FC109
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:05:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EBrZ032761
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=RB28Rd/gmelDbKdBRHvC3WTF8zQiCJJI4fK1bPgRb1c=;
 b=hAfS4B9jixwGSsWrraw5z3sV4EhoGD+/Gf3ECOgblXuu5sGS80Ht07Q7RdQxGpM2FyJp
 pSftrBGsk5bpdh/BzAenCiUOek6X2QgPEuYfA/ElRMaxdW2Mba+L4ZLCTG1Q2UN30ZqA
 XajJeCNjkRlF5LIu+y5MeDagJlRguTtWoOq43QiDQKMVF8sEh82GsTYj0YzkZmHyf1cI
 7NIPKVPwUgIPULHI4ySFtMA9M+lkfx0a+BoiP0v7wmo4S/BGX76Tc/j7lRStl28YLezn
 G9XhdpO5VI2rmxqTGkXjPiNuzlg3UF9mwcB2KOb2dD6muZN7Zm2GIKOSqAgUugH5qjZZ 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44mp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N91rt7023588
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u44wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKH0smbGWcDtK+7hIsXrm1+dvtWIWg97pUb6jz/DfGEnxiu4r71waUGFQPZndGWBVwfauSztDK0t60TwIqs+/wwQXnMZEz0UJ9t7vhGdIMfyUk29Bfw7Cz4Ab8ZhS8MyBKMzfxitiGz+NGb3/3CuUza1QQWLbYmzX/X1sx2DhpsvlBIuKz0k8mMI284Ok7y7Enb7Ci1uJmD2TWvYReLH2wI3+HYGQRReC2B2u/ZRf2sf7D8/l0+6ORb1wrttYPjEG/nuiizpEiDPy1cUDct5FW5Zbh3vIQ1PXPhBczCKPK5mSmWYhSffOYJwe42HLR0TiWzgN8mtnfufwTL7QnUvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB28Rd/gmelDbKdBRHvC3WTF8zQiCJJI4fK1bPgRb1c=;
 b=HkUWHMty7GsFqI5IlKi2s/615B3NjyH1iQFvuAgMY+cbQKbMVQXGiUasWAR6HvEBvgG6RKnFuIqDesjeH+Xixjb9Uqk3mI397B7rTloJU3d2D7tfrULpbOCEZGXgeLyQhHEOFDuQrzkZlLsDXe8KmULJhvvETfPCahnmv1g1likP5+4myHnVZFHe+cWw7I8N1AEIV92LvOjFKmRee8C7JOUx87vBHzCEPoL2UpijSamXJjhENX2rcLrTYmZhfSS90/G5qUnRVar8ArLYj2lJ3oVD7a/7qVmRxYePuQyNtVCVIrrh8VyQbzelVdRdlCnj1x6Al/wkM8Eyl4zs/g01mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB28Rd/gmelDbKdBRHvC3WTF8zQiCJJI4fK1bPgRb1c=;
 b=aqM5OEiBQxmfXK2FIgFRqGo/IKB2DANbzVK9xHmCM4wLg3UAQX0NjyTIZ9YHi3++8jGFVh0UMgVd70LdR2MvAFwrh80o25tsnpznyxQgdEh3EA/8HJcFP83TEF4icNWSjcsjzIPxdlweuTabpH3Y8wnE7CdW4Py72aRReMZXzDU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:05:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:05:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 8/9] btrfs: consolidate uuid memcmp in btrfs_validate_super
Date:   Tue, 23 May 2023 18:03:24 +0800
Message-Id: <f76753ad3f140e24b41c9b6f4e245d720a76fa51.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c4c27d-49b7-4bc7-ead0-08db5b753110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st9NsUqZlSZ7R4EOp6w3LLy9vD65zd5tikUPlm5gr+HqaKIp2/mvWwhg3Z0ccObb10pXfBig97ix+pjENyHPplo1/vCIEemW83S/5Wb9SOKBeX/nathpNb8WNNx+gOQK2+vTL7cXXgBN9LQQ0DOcRqtrRP+RTOy+0rIrNnRK18gQR3aFuSw+7uJaRkTE14W841seiM7vwtXDL/0E7/houlNei5safIz9PbgjzRtSUaxZJmqJ2m7fVMqhFI2Hb07JwJMGBJxvMvZIaQw41GFRFmU/lHZV6Ut/QJM0ZZBjHbrVFKQ66hFMdWBNXSL75PHcXpORXJDoMvG1nlIG8JMVFvE/UejCVoH50FMHXLudR2wFk3PkwGmdOOJin1mvGtnZTtaroYdcax3x0M9P4uei6a/Upq8jISuLpWqsdNU/BEUADdHfH4Vrzwwm1wTVyN0O4RMMNRjzb0DALiDEeJ04xWxcywHz19cmHB8Hoa5dha2su1dpf11sj9bZm1/1gbWDnzayd1uUW/KAZ6wdGyJ//1Lvsp0UjxDUPAqFC1d80qqxlAj95or8o+3Bq863fsMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hD1oUdndnQVL4CIfZm/GqUlWVfdXemNlMQ/QJawMXWxNIPaRzdXRYy4hezTN?=
 =?us-ascii?Q?JLCAt9jXD6FFSXU87c0bolHbvSoUard6SPwlTwBPACYqV32yoxMVSv4HgwnO?=
 =?us-ascii?Q?q92cYI89yxr2DucrquN7zj1g1Tk0JFaVrMwhSDub/9whH6r9CMmC1h6zUAZg?=
 =?us-ascii?Q?0k21KKY6NdSqcIg1Jyco67WwbBWdGUcnNR6Uzn3LAGYuSUm2V7zXx1+4NuK6?=
 =?us-ascii?Q?8utNhGxwSXtpxIaM55+k15NflTyenoh8BdX34ZGRh72485wqUjjFbKkm5EZ/?=
 =?us-ascii?Q?QM/xgKBg61s6mhaBpQMviIrJMpHS7fvb0igeAZXsl+xQr2gcFJ+ZtpGnJw8V?=
 =?us-ascii?Q?tn+nI88c9GuV8cfh6pexmaHSGAMqCBbgUsI2reRSJ50G0EIEUA21VPkDEL9+?=
 =?us-ascii?Q?KhNfFJ2lN/C1RtqEI198WbKPXOeQXC9CQc1mGKJIjFLnrfkSo9GpwmAIfl4m?=
 =?us-ascii?Q?aFFpGrUBUf2tIVgEN0GI9yw1b1o54VDZ2KkGXa1sLNLAVOi+ZTnWWJ3JMDKp?=
 =?us-ascii?Q?qN+l6XdCSYmwKggF+OxDYK3DoBpAzj8SU8/VT41NNB4+Xi0MX+DfQ5g5Iqy4?=
 =?us-ascii?Q?Y/1MWiNMn+FPu2P3jj5RTtTrPr2FsiT/e8Nyy/sP5Evcyah/ZpTrntKkT5Uo?=
 =?us-ascii?Q?iCSYPg7ugAht/X3gWqosbrmi9uDs8+u16WqT1atfozT+OomewH50vpsFcsOR?=
 =?us-ascii?Q?NinxY5mlEeylvbbedZ4EvPNS42eqQAugTsvNZggqtrzJE9iQxnGbWNB19Wqm?=
 =?us-ascii?Q?vIfdDi4x8H9e16ViwLkE6+rcWHsv9bW+h8CXy0xQhMRGX3sCNQR5+PHjSsWy?=
 =?us-ascii?Q?7QqmCGDRpE2ddXhIKSUxxTOn2MmZ3Zix/2Ie9wt0lb3hRjvG0YCqL9mFULRX?=
 =?us-ascii?Q?OP1z8TU+U/T8Dujsb68ABz9Ci9wJ/PNCRPlpz7ucZI4dv6OnwBC2XQiusFpP?=
 =?us-ascii?Q?sLsuXr8D41/5ihitqlpLa7rmbR2vfP9xbWRaLX37Jp2wc0ZTrJyuG4HbvhQh?=
 =?us-ascii?Q?qh3sY9ImylrrHUhQPj7H+fAJIOmPm2cH8XltYtlPh1cZ/DCZ2eVDciOaMsOl?=
 =?us-ascii?Q?SrhI74Qh5ZI0xw+8vtoZ8PeOfkHTDSNZe2SusdVRYBUeQAHlU71Y9InY+pDA?=
 =?us-ascii?Q?xHnq9NCZbYMdJAt6wFqades9Y6Y6/IuW00LnIMEmDDYB1VYp45C39XR3NpIu?=
 =?us-ascii?Q?U/wcubAYNbelc4dnlbiula4rm4RmoQFyFtvNdviNfP9dtay0DfwIRQDCxVrt?=
 =?us-ascii?Q?EWcseLeWaD7RJ8gsnlLStatJASQdydAYh4UL+mOAzcWAUWgEBtgLtGrcdts1?=
 =?us-ascii?Q?9/WP9+a5iz/IU8CZsUAs9dbpo9O83oUvD1+0WJ2TEqHZNW7Tk3QMFcyNQUqL?=
 =?us-ascii?Q?0sIyaVgW9X2ARHcNC4CBYj+Z9jmqegwiGSLLfdcMbqw68I7sPlOvTMoDDX8P?=
 =?us-ascii?Q?6ERjI4EcU7bJF6H0/eZmFt4dF2ALZngRc9A/+5zyZC4EEgDk9kh/faU7uQOn?=
 =?us-ascii?Q?qZhe63G9ose4qfeRp69LWeRvCmIdsC0dzN8KepDb0ztI2XCW5iOrXcyGZSYJ?=
 =?us-ascii?Q?+5gK5Hg1hNTt8pbcrfVtbajccTxOQyeQRi/Yl47lJz1cF6ImdjIqN8QDrdcd?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KLEjo7XxwRWaTOz3HI19rF9XI1aLw3/V1W9U29u8hh0IQ30tS6j/6KDDiXp0iVFZSHpfY7Zl4MjvgU4vQi617DdDQbFs6mpU99pJyfzpZucxfnLG2blqUA0078Uvf9+8YGvq9ptKrtDSunswYYlX4qS0q6RW51dRSkJaOboxaDLW0icUlZqRtgBEHwUPUQJR67eh6utrOm2ae7S9FpgVeYiEekPuC5jp0wFVQUTij5Iripr0VGOA7BCWE0ks87JO/haZIelKbFilZmFRpLjSs6P9h/jRK1NIi1mKJxZZS4fshcpwMQi9MKwb6Kal/lGH3tRVQnMn43wepcm3r930WRJPhLPaAYgM5sBSJPLtuWiFBDSQj7S4eVG06Mj2llXbbJGep2bhZfayZ46HRkuFVAAoIyDwKNL3oBz1VXNhoHtnlAtBlG0HKda/Km1KLuzYZV2c9FVr/9KBE0s8WO1U3mnnu2m3Xw96w1czgqD436QJkov661SlYp3QlxRkUeHA7/QEO094hMdCQNvFIQq1+n/pMAIp3U7nfHqmQZbIfYDvvlPkAoDUCw14OTDL382fqIzonDp8qHHyv4RRpS8H3i0Y5DYlywszBM2nuKwda2pI/tZr+Z9YjQi08nFnNSFHcUYsXxjR/uIA0zb2zp6iKN0CcaWr0mFxhTCfaiKxfG8AZE999nNcSWUyWx0W9Rcis125N0R2B9O7PcmdWGgoPa7Psdt6ea3EHFzeDOiF0Ubh0JyPhpBQQujE1jlIP3mDkMaTJ24pfZTwL4b1P5dWaw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c4c27d-49b7-4bc7-ead0-08db5b753110
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:05:09.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzwgHy5tc2nMIlVYERbj6D0NHoNVJoeR8ADW0YOSvKlCJo9rXr4BSzqpnZPWWSioOblR2nEqdIqo4R2/XOlWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: _cvgN2GyYNbOnzYZAuREZ-7VuZwZiXsQ
X-Proofpoint-ORIG-GUID: _cvgN2GyYNbOnzYZAuREZ-7VuZwZiXsQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are three ways the fsid is validated in btrfs_validate_super():

First, it verifies that super_copy::fsid is the same as fs_devices::fsid.
Second, if the metadata_uuid flag is set, it verifies if
 super_copy::metadata_uuid and fs_devices::metadata_uuid are the same.
Third, a few lines below, often missed out, it verifies if dev_item::fsid
 is the same as fs_devices::metadata_uuid.

The function btrfs_validate_super() contains multiple if-statements with
memcmp() to check UUIDs. This patch consolidates them into a single
location.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a3e92fedcde..85e75d84675f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2574,6 +2574,14 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
+		   BTRFS_FSID_SIZE) != 0) {
+		btrfs_err(fs_info,
+			"dev_item UUID does not match metadata fsid: %pU != %pU",
+			fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid);
+		ret = -EINVAL;
+	}
+
 	/*
 	 * Artificial requirement for block-group-tree to force newer features
 	 * (free-space-tree, no-holes) so the test matrix is smaller.
@@ -2586,14 +2594,6 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
-		   BTRFS_FSID_SIZE) != 0) {
-		btrfs_err(fs_info,
-			"dev_item UUID does not match metadata fsid: %pU != %pU",
-			fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid);
-		ret = -EINVAL;
-	}
-
 	/*
 	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
 	 * done later
-- 
2.39.2

