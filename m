Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2CC3E7C16
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhHJPYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 11:24:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241779AbhHJPYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 11:24:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AFFiV1003439
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JMKC56jR839zCAIoKVIsTjgdGOsyKOkzyrj+kNM+Q90=;
 b=0ca3POCsji7Lr0QiHegqcG3KmJnxY92z7dFpVY9gBwEE86YGfE+8yhJQR8P2aq8jcrnX
 nUyaHTruqJHCp5UCbwaN532yLW7GgOvjwwklDmuMjKdIvbI//ZKqlSsLWc5k/ez/h7FW
 wK9/sqXFuLq5LTlnTWPEQxKszVfkX6wDlts2i+RMIbcyBgnssYChqOytF6cuDLD92GI1
 UatR9harLdjr5OdA1ta/u2GnpGNLXQc/XKJD3X9DeGqvE5ZdGyV8FJE1aY+pe1xnAxBi
 MUc03dSnBqy8MH1KHOy3jA0d3M3Q4NNjmYjXUsNkcYRwtw45OswLj4S6cfvK6Xt8UHLm Zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JMKC56jR839zCAIoKVIsTjgdGOsyKOkzyrj+kNM+Q90=;
 b=ATyaVyxqRMrgGDSlXG8HeIwVDRfSkgjrfhoRGygJ0sMZs10c4IEqevqvjJ/uRVtEK1Va
 +25sH59ym72/gt/FZinB3hFoNjClyfHTIPcxOZFCheZBttPU9uFkX6l/h73PedbswtkS
 X+X0l7DhTIWt4y57N3MF0hduwO+xU2jU5gMEbR0buTBcxsPEP7E6YYAY4JsgcemZ5B8I
 2O/4Ftwvk20r4MQpYf2iQjLXq63ivgDWzSGAS97NkOaNOuPBHvF5HdzbM3IyhE5jou9C
 HvuDM6fd70WByY0XgVi9wZ9f2TnvVqA+JMfb6mWuXu8llfWtDNVrz3Vjzg+rLLwejAUN Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fv5n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:24:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AFGUTW061312
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:23:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3aa8qt95r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNsYs/bVTl3AN6bXGxZ0rxj1rCUiECMG2sLYREQVHyN3ecyvoHf2vdLEScK9Sgovt4a5cXHCNsouSJSlG9fTJC6neP1mOcyY7VfbiQaIdJ6n7CLhL2hhAKYzz91ev4R5g5k01XOJdZK/8KY/aS9rhlg4bSjv6PQ0UEm4VYyerwyw3oRYwEu83JjYBaxUODcxcVTHMuLgFOe6QzH9i6YSp+k/6jHAOUGo9DceLbNqrm5f51oMfPIECpalfKgLhvBg434CfOKuMjbSrFveU7JU3Bzhj/LPhvhvv3kgxTAiazJOgu4R0xKUkbeOgEHY8jkL1cK6zGm0VaUPBfGdwwLcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMKC56jR839zCAIoKVIsTjgdGOsyKOkzyrj+kNM+Q90=;
 b=EEXEIDlnhyncA2/84NfEr7d/vRauEpjd1vxmU+2fxvYRwSbJQ3pfNDAef05IBh+ri/YRMz80824IhUUeJUU9Q9EKl+UES0IVNLxj15a1j5iiFgPDYfFFeUS+UxPFW3bR0oJHn+Ga63+Xjh1yvgbipL11bkci3DdDinw0sLW2l0n2q94Zq7zq++pvesq5+CqXCWY2/5KmSBx3TX6A7ByNK+NTE96f+2FjkaJQ9AnkBIUvzfoW+2qXLKk/rKRrcQqF+iv7HP5vf0hjZSbfbbrzaHjp++zZiKOD3fI7C1yZfTIs+9Cn+9G/HFS3z8D0OpjYBmZVwNSeREHucUURXR7Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMKC56jR839zCAIoKVIsTjgdGOsyKOkzyrj+kNM+Q90=;
 b=DpljxSq9Dt0EmjtZtzb3knoayhjjo4aBAzocEMteKl0PGXIL5+1fmP0LWliFvZEoPJuz6TYws7V1Uc4YG1jhzc6medIenkIordpiCsrhfWliO+2Y0fDffhTIRYY9ZfusxGxQ3AZEhRBslRdD1Z5q5u3ngNLh2H8+5stWEtmTBUs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Tue, 10 Aug
 2021 15:23:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 15:23:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
Subject: [PATCH] btrfs: fix max max_inline for pagesize=64K
Date:   Tue, 10 Aug 2021 23:23:44 +0800
Message-Id: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (39.109.186.25) by SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.4 via Frontend Transport; Tue, 10 Aug 2021 15:23:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfcb482-cf32-46c1-3e51-08d95c12dee3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB43658A532BB84CF1A6A4FBE6E5F79@MN2PR10MB4365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PlPNKdfk35qYfnIOT68to5bc20MSIi7fN4XB1sh2PCaSUPbz6xEdTRZW50PpPgboZWG0VmxJZvzSjRFnmlxYEMl+qjek7bGbkLV/M9MseoRdMRy6ciC8o/QmavuZUazv1px4mMGXc2HrR60X4CKLZ6vrPBoaNuatGavRpc3NwXjHYA/i8Pm0h00zQ0j32OxRONpmKiOIdm4b+bo6Z7JuZUmprrqFwCvVM9NJqPqP8j+CZ+CH1tRrl3NCPXRrluWZRBHlWLdFCxTyQcHAPVGp8Y8W/byoOno9wTpdmApewbFNes61WL9zY9syVDL5DLHO7r32kAgX/UD8n9GR1w+6n/oB79S7OjdO8m44dSYryDcOXtrW2kBwT0hd2Cqf7t+Slt1MS0O+V6z8/LHrxamEkN0rOzwLKijzKuXI8ZjR4HWtTc3K1lKR/FNC9a95V/vojBA5VJ/qbQMovbSZUvkkCEV2cR/g8AxagyW2gOi4gMre6n7FVgrO0JXc138klH4Hy7lrpGORqQilyI74pGqQif+nvRo97fnDZaBmi3y/yHm5Ibm6KYJtBFrL8rH23Y5Hw9lrXgpRz3tuIWRJlivU6SAksrGD3mhMT3o9P2OYFlmtTXl4VFnNXKPBoyVitbHtlxH03RS9oTDacmIub1+zq5gP8WKxrfR8583Mep7jq5+62aXb45698ygc0iPIdh7/gzF5go7xAvWDKXHDGEMgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(956004)(107886003)(186003)(2616005)(4326008)(316002)(8936002)(6486002)(44832011)(2906002)(6666004)(86362001)(66476007)(38350700002)(38100700002)(36756003)(8676002)(66946007)(7696005)(52116002)(6916009)(26005)(478600001)(66556008)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzIYR6eDh709wKtw1UU7DPVRDWWkM/WOqFN9o0m+rZKzGcrWzylS2zgrbWPp?=
 =?us-ascii?Q?eE6LjANtLsHS0/gASDKLiLH4HTzLyhC8Ezo584ewWIjTOs7/yd+UHFbjUzvP?=
 =?us-ascii?Q?O4fSiSsnjrWfoHoZbbzJncCFHkfzYKpoN33lQ8oDrlH34S3c4hY0rkuMD3u8?=
 =?us-ascii?Q?DjQyM9kLFRc8PtfRj+vHBc06HlZRU5+3yXROFTxxubHV6SexvQYrmv1dYgN9?=
 =?us-ascii?Q?Cp87o9GrKwQaeR3wBpes3SlBxtbQXJiccM53XgLTWiQnupoukBA06XmNI1kL?=
 =?us-ascii?Q?OgRq2tKDFGWdYPkGgVxtgk0aJpmRdvNWlhfEwz0MPr5RTigbvyowqi3V9gAp?=
 =?us-ascii?Q?D70m8ad5JU7vMff+ZyW0A9XAMl+X78gEHKRFHfJPuiXpmZDFjdvm+cZc3LJg?=
 =?us-ascii?Q?Whq2Ni/27O8N9hhL/ogbrJpFz/FzjLS27Li8dm7DeZ9aWoVWKU7DbAIV1fI/?=
 =?us-ascii?Q?mkldkl7pd+J32zF/Ovlz0vHoQ+EzRfMMC2ytpKhHoqnHjfxk6pBcIzXw1KML?=
 =?us-ascii?Q?jseyBs/iRbVhKGH4oqfcHS9/Uqbq0nnvX/icwvKlsZ/b8+zdoODKbjzysCDJ?=
 =?us-ascii?Q?Hzbu70Qhi15F99gO1bZJuVuI4ltsJw1I4WmPDIQD4oqY/DMujV/3EwD+J+z8?=
 =?us-ascii?Q?/CcV71IKRS84KqBPMfwcdktr6XIxG2yoT6pmSb5mfRAoNe9N3Sg7C5P8J/hl?=
 =?us-ascii?Q?PfzKrTLMO3Ax7yX5j3GRZIaAENdIddFTFls9LjlD/jYSEqsulJ3czJXkzoMb?=
 =?us-ascii?Q?gw80+Htinwoa4ZGcpnSGA+sjiuC3Exo0oVyc7P/2aGUjQgpGzqz/eueHFeUG?=
 =?us-ascii?Q?/K91rGfY+h3Cal2ziQ9wPM0IrgBk+faiZmmEkZwIHsf6r/yg9EAVOtPjmP+Q?=
 =?us-ascii?Q?Cq+S4tbnmFjq4z6yobGBGtJ0oMGJUF75d1gz+QRfWD+NE11MV4oWzmn0riUi?=
 =?us-ascii?Q?2Dbu+R+9qHItGjEpCQQ4MbNJTwR8gIGmFwgmdEHMMgY669vPwWNHhEX35c2C?=
 =?us-ascii?Q?LhYg3h9AVXymx5f2E1Sq1quq+VtDoCZNkY9RqdSC1fh5ULaGU/nwFpRYYjCt?=
 =?us-ascii?Q?r2IQ1rnzRDeKPBoqmFyRt3tOdqiSDv6VIUrrW9U6Dq16X5zOasPrNzMyYh+p?=
 =?us-ascii?Q?821UyTbyQ6lnbuBkcaeqvFr338GiyVqlxLyKjQ7AsTcFrRKyPtvUrDfsRM6B?=
 =?us-ascii?Q?7dgMwJjTx0ZxGcacOEk+ZMRpcx7sdJWlz/0M6RbKYl0qCTzK2HwnRlAYH+wp?=
 =?us-ascii?Q?O12NIIIyGQ7MA7C2YdsSvG+kM0zx5/5+SxBdyMWREN0YcWCpNhqu/C5Ne+Ia?=
 =?us-ascii?Q?oxv3RwdNOhppzpdNnJ+Th3A8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfcb482-cf32-46c1-3e51-08d95c12dee3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:23:57.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4IDIRCxuapc/nUDbjAh7Fl+Cnj4HJXEHeJrZq5T74NiPReh37YPkOIAP5b79b92JUmf9xT4v162zOgYmlPFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100098
X-Proofpoint-ORIG-GUID: t7YZ7CMSSJlw8QIHFCbWraJNjL-bbvvD
X-Proofpoint-GUID: t7YZ7CMSSJlw8QIHFCbWraJNjL-bbvvD
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mount option max_inline ranges from 0 to the sectorsize (which is
equal to pagesize). But we parse the mount options too early and before
the sectorsize is a cache from the superblock. So the upper limit of
max_inline is unaware of the actual sectorsize. And is limited by the
temporary sectorsize 4096 (as below), even on a system where the default
sectorsize is 64K.

disk-io.c
::
2980         /* Usable values until the real ones are cached from the superblock */
2981         fs_info->nodesize = 4096;
2982         fs_info->sectorsize = 4096;

Fix this by reading the superblock sectorsize before the mount option parse.

Reported-by: Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2dd56ee23b35..d9505b35c7f5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3317,6 +3317,31 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
 
+	/*
+	 * flag our filesystem as having big metadata blocks if
+	 * they are bigger than the page size
+	 */
+	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
+		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
+			btrfs_info(fs_info,
+				"flagging fs with big metadata feature");
+		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
+	}
+
+	/* btrfs_parse_options uses fs_info::sectorsize, so read it here */
+	nodesize = btrfs_super_nodesize(disk_super);
+	sectorsize = btrfs_super_sectorsize(disk_super);
+	stripesize = sectorsize;
+	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
+	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
+
+	/* Cache block sizes */
+	fs_info->nodesize = nodesize;
+	fs_info->sectorsize = sectorsize;
+	fs_info->sectorsize_bits = ilog2(sectorsize);
+	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
+	fs_info->stripesize = stripesize;
+
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
@@ -3343,30 +3368,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
-	/*
-	 * flag our filesystem as having big metadata blocks if
-	 * they are bigger than the page size
-	 */
-	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
-		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
-			btrfs_info(fs_info,
-				"flagging fs with big metadata feature");
-		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
-	}
-
-	nodesize = btrfs_super_nodesize(disk_super);
-	sectorsize = btrfs_super_sectorsize(disk_super);
-	stripesize = sectorsize;
-	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
-	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
-
-	/* Cache block sizes */
-	fs_info->nodesize = nodesize;
-	fs_info->sectorsize = sectorsize;
-	fs_info->sectorsize_bits = ilog2(sectorsize);
-	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
-	fs_info->stripesize = stripesize;
-
 	/*
 	 * mixed block groups end up with duplicate but slightly offset
 	 * extent buffers for the same range.  It leads to corruptions
-- 
2.27.0

