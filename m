Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACFD70F5DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjEXMEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjEXMEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:04:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7289D
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:04:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBxeLK029508
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=md6ik/li0xugefKE28vF1l7w4i02GhDSa3Zdws5DPb8=;
 b=LlvTvdz9+l0ElQN0OrSJGt1A6TPhbKn0+zJT96LpK0E5pY+JlU8aNtMHVXUHON/RPdZy
 gzfHWniJqqfteMLER8mH7jTUFYQpTMyFcdZTd/PvEOXed3JDemop3EhungaPy8uQZyZZ
 SZL/veYryGLfkjG3Y0AHhf26Qt1tzJlmN802ypeoCHvxYmAgUiABPNtL2taJY0T6QLCE
 +GIGkrrDhONvSzpJS24fxFK4HkzqzBG3fmG6w+lqNoCNKp5C1CPQG5uy4mNgr7LFWis5
 E506ETa0eZ06i+QEI+X/ReiGeetWdevwxJSgDYvpF7e0dZNhYe8ZFgjkZyL0ZOBJ+imb 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj27r0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OB6Uj2027324
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2evkqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9i9J3swn7I9UdN4OcJjkm73IsYAnfB3SowFyrCvhQBnIk9isqReW164V0BL1m5fxiUibIcoF7acjfVUCHaRCCEDDdmyxB4YgAxGm+5Y/82EcTsl69/qy/JhGmbSKHlL/DhP9jA1mXrWCQ0fGeMAPxIp+kQ4RSg6e8ypCEUHq3uqiDjTMNIZzh7i57NT3VBbVRg6shdU8FcXDjcH+PfSmCQZf90Zd6LQHsB2B/qb3mFmq+7wzmANz82qPZ14TiFmZYE0o7+XlK+TQglYget1rYsFAckTEpARw4KpHLHX1evtypjhWbJNKpTxS4MrO2iBhejhEMaoFAUluAJ18ACK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md6ik/li0xugefKE28vF1l7w4i02GhDSa3Zdws5DPb8=;
 b=GXjhlj7oBY2cjOJIhAvCS/knO8UdLOCtjfDqr2xCHmA/Iivl1dcsPIUHrdYqGB6HJinhPD+wCKy5pnBNGxoQK2oLtJ6DpbOV1EPHtSCV8qd3SZSkODGvv4SuLnsORr54c/O3qpI5PfJ27MNhhKG5WyZ9Qafvq65M1vt12ru6h8PxtuSEU+uLMWRFNNH8XZu6WGb+ot/JQ9z2DG0R5wbaDTgtB92Fpxj6YrcCoSZPbbPrd6d29fEIFtl7/zlwMRtvcpG8cpBxcKg5Clzf9AVYIYI5hQoskd8SqAdAhMLxwQPJnutg7TgimyPKlW81/XUC/qDy64mraFZaWgxP0AUI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md6ik/li0xugefKE28vF1l7w4i02GhDSa3Zdws5DPb8=;
 b=PFTNHDrdnJNSc8Doswx2WB+IBXrzwLLUSkBV0BylKJEYM4dtbMUm07WqZmG2a1e95Mxs5k3fvqvys5rwMZKllGRiJsxeuYTgTwDRAoIpDd2WETzDtGt9+RsReb34N0j3d0NKCl5FOKvBl618XzQ2yYzfqVLlijyDQFsguSYiM4Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 24 May
 2023 12:04:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:04:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 8/9] btrfs: consolidate uuid memcmp in btrfs_validate_super
Date:   Wed, 24 May 2023 20:02:42 +0800
Message-Id: <f6c697aa32c6bdb8478ec463433ce6a6ed3b8389.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f18a70-292a-4b0e-be28-08db5c4ef5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ubb7pK0Z2d4v6aYI4r3cJj6bW5Wnx+gz2GIA2xxMbFv+HLWuGWPXUgzPzAoTs1aGVoE1ACCXPmZZAzGK3w6WFUKMu2NKMHr4FRYfbWpjSKuTQtaQaay0m2VcfXKmsXR9N7e4Pqx4qXLJohCGjxEVE9QP4VOBXriRtVp8dA8CaXVhs4XSlhLJAXmw5eeKKgFZcJvy5VGzq17Jq+p+T6wSmAbNyl465PPBzNl4KUyyWP1or/PSwZHad750Hj5oLTbyeKePu2GnZApQhOpDU2KcpMzhbHfScbdS3ce80GKRiCqyRQt7R5eBgEuDQ8pwRhWeqhIuQJxL4z7Fkl+3uwccbg1KMQwyi7NA1amywjiRJ5hFmECcyQDNkDWuUCBlkNrHaLcChZoBtBo87RQCr6e3wbPZkauyAvFUYf5J7rUg/dpCCq0oFAR6PFAm2dlISuSUBqMKy4tvfoyVZvbGoHSO/3G0s5i1N6Dk94KDnOpGvPdlx7Iq5wpiBMy1XKW7tavD05FNCfc8gvbgdnK7yNx0ReHhRoJecweSnPgArOIESKmZ1s+0GnhYSukkD0uA2g8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(2616005)(186003)(66476007)(66946007)(6916009)(4326008)(66556008)(2906002)(26005)(316002)(6666004)(6512007)(6506007)(6486002)(44832011)(107886003)(41300700001)(8936002)(5660300002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5EuaoHr6g0nOkegCjFmXp4PPN62zWpWVScwKYfqIKA5xXrNNrt69/lFJUX6?=
 =?us-ascii?Q?UxZuyj8jK73c7BoPvSFVvwAKYJiCPCJgacotYC2Vt7hbyJLyqskH5qNDndcl?=
 =?us-ascii?Q?pk/IUSCx2ymNhyoGRF6TWs7GhCP8KzSixED+WzOfextkxPR5mP3fldmMCNxF?=
 =?us-ascii?Q?rfvXgNuWacGlx24QfYE8hQzFssElOVEM9f1i9z2bS9q09dhMYgbirw2KqlPD?=
 =?us-ascii?Q?lAHBckydWsq2+HPB0u6gLjssjNQhLVFL5Mrb5rXynnmWq4gcNaSP2Y8UMDQv?=
 =?us-ascii?Q?nSoaM2SLFi2fTpwkzSjUq7dRvdOlXpT/LTvq8imq4FRnGx8yQ/lCKrpDU/gB?=
 =?us-ascii?Q?+L0Sz9h983oCo97672+CknPF1lM6Hux1gQinuUBfMekGKtRv/VZ9lj6Kfd+O?=
 =?us-ascii?Q?/wWYDe2iIaiGY2OyBeEtQ3WyS5d2bvXHcyk0z6YVaaiSr/8bg/uLKahMeK9I?=
 =?us-ascii?Q?CzHjC4rP8AfMy+po5D0hcW6gNo46aFI4zVVegxVNea2EUfom7i+c5ygxGZ1l?=
 =?us-ascii?Q?flOIVdhksmzTfYaEYs8rDd/a84cj2WYpxpNEL1oBxX3XcUkyD/voHmrWdBQc?=
 =?us-ascii?Q?ay4GwN2ThLdhGFffZhAJ5P13dZ3noKwm60bVOOKVW2uH6kKpMRQFMG12sbvo?=
 =?us-ascii?Q?6f3Z0mxdmyg11665XtFlk+Eip+ToyGTFy1uvQYIAcI+dgw1Io22Oj0tdiVv1?=
 =?us-ascii?Q?BGulxHLJFE0itga8Lc1djYwIxiFtS8khE9HS8Vl+cJFE8jr0vEL9ObAZr6A1?=
 =?us-ascii?Q?oMku/HD9BhSJVCTKN3QddHVHeABMqS/RMRw26z0DRSdLMuNgPSpFzOEJVlBV?=
 =?us-ascii?Q?5ouWgBhhRAiwM/YYuIdUZZv7f4AdbJdPXrvkkcGh4J/qbuWepzvP1wvq9uH4?=
 =?us-ascii?Q?2h37Zc2GWRCLAecBUcoMxmNnasiFtM8Vqf1tUm3ePjsPmxIS1+6iD+KJGrX3?=
 =?us-ascii?Q?uA5WjPK77HaQJQOZVAcdlSXsVOeSpLhmVx2FrTdCeZEGDDOJpqp5grD4A2HD?=
 =?us-ascii?Q?F6QD8fRHugnZXgnVnWDrshVtGY4F9gwdoR0CFUiG5yrSpcSqklHWkd75zBdT?=
 =?us-ascii?Q?lnMqu0lheOBlqF8nJ2OZA4PmWLLNaDGqBYofGxEeE2RIXedR52m64vLHg/V8?=
 =?us-ascii?Q?ewtdM7IvniTCPO2rfDMWeRD4rk+q4XKUzFD4kyPIbQjD/Egw5vCRLRE77kKK?=
 =?us-ascii?Q?wR8xqC4uS6+5KeHFeN7fvuxgcWqpMzdM/Wv19514G094bdS841sLBQv7xk1D?=
 =?us-ascii?Q?X2/gVXWxomvDzYlvhZqbp/eI/4tU9fBCVtrSA+3NC+mP3ivr5y64PhxkmbQ/?=
 =?us-ascii?Q?TrCDbpJsPARZjd4Ul/ECh4lcl4jGPigjsWsczHqflQ1hETfpGZpVU3jvZVaH?=
 =?us-ascii?Q?mfrgvVNmPHmF+e8OViS7EScU7Ul9vOLcL0jYygf5i8MnGRwzti/z+OTvOYya?=
 =?us-ascii?Q?e8n7K+NnqNVxgiQVjlEyG6bz8Q3j56e1nXuel0hvrY3zZTbNl3QqGjyGJmk/?=
 =?us-ascii?Q?trr2/uNlYc3arubhqQQCId1/Zep522mweN5lofKQ6/58gKOFdNHqzCx+doJ3?=
 =?us-ascii?Q?OgioupOYNwZlp6ALJ2V8gnx1liLv86jagIvLffcX5eZSxAMs3appXBN/Nn3l?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uFd3ZX31ruTQUy+SESwgz/ywaKqvP1PGiydj7PhPqnCK8tILOEcQcTVekFBY6ZrxdidhH/sKsiUF/PZLVzHiuZQEaeJjXuHE2cyTjIxdwC8fWRgjmFGoeog0Q9v7jkRtWrgK/lzrrzNFbwvDsAABclD0gp2tB8+VZjq6uYrxc8wJvQZ09sr2gQHipUIxEFUQOuXoYBkRYrPkkEby2DPr3Dcj6NBheYc+vm77XdOizwiUON0qlhcd8s/+AzSDGSGTXND9XOQsNPS9MfHwyyLiViiDWHmXNCc6/eiq8rnUJpAohmFMziOj46455PIkFIMZ1H1TdLNQCvA8EnsvmnmE0OoQvj7OJaTahfjkbBp/hiXPIV3YLxGP/BTz/MBtoXsk2jRwlFRFI/6lGGe31KJP444eYDdqSzlu+pE60FUnpDxyrIeZ2xK4cmf+hLzikZJfVcADhNcWpIOBnK1a94BkTJHYXM301eWTJ2K7knkJYS9BDNmHa3Jj6VbXndVJ55T48wDNKMShiZrx+o8uwBjk5QXY0PYJqGiTlDiRo3cMIY2pyEowKA9ByGz+/arh1A/Ugsg1Y/uNMN+75aHfwBjQNm78sspS/NAADulv+Uyp8l9U9kv2gc8ELtiP+PnYkpvSdzzkUhkPKMvWGk2MKlFgVE9a4YX4MA64/uit4QLFBBKc5rPvI6vowcYMz5NXZPPlghiltLKTe18JktyPu4CXFEl9I4sC0q8Hj+IgNOHQpSp60FBk1dN62y2FrSYnX0ARcpudZEyUkGSO8ZdKAhThhw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f18a70-292a-4b0e-be28-08db5c4ef5a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:04:00.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tHPmKqigWN/BuEpSeGX8/uX3csO1LN7e5xEV9TlKSwgFN7SLb9xl9lUxrE6Tp57i1+P8nTj8Accysb20mRE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: lMaK5RHzW5aIqDLAXHIxR6jnZ68IxRpX
X-Proofpoint-ORIG-GUID: lMaK5RHzW5aIqDLAXHIxR6jnZ68IxRpX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2: None.

 fs/btrfs/disk-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6681e82900b0..d09f767c7bda 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2392,6 +2392,14 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
@@ -2404,14 +2412,6 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
2.38.1

