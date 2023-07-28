Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054AC767052
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjG1PQu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1PQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:16:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4C11D
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:16:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4Zal018474
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XP4hajZdjLN+VdDBd3Kxw3rQyAfyw/C7rT4D1TnRnlc=;
 b=hey380pdnbRTUKwwtftlwrg2h4FsAoNq1vi2+B8CAB0qIlMLA0uGIN3Xcvesri8QnNXO
 kr2WIdvCHjO782AJdNMhdUsYEmy6nyqmAEMwIBGVk3Fm7Lb7AnaVHxDfc3Mlr1glPrc0
 jwhlwYJ8KATUy4g5BJqu2KWDZnpTCILrjZTJqwFNq1ZSASNmRkm3FrrfMLUnUhIgF7GA
 JWJbtqjBeOZeId1VGbEROzx65sybnMxyymUA8tbOl9URxlU2etIgLwf9rNyEPoImKT53
 OAK5/XTCGFW92Ld+AG5VPDfxX0wb6kdK57m+EQWtLIuQ3kNO3Eu46W97QKQV2PktrNVD QQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3v4gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE6phs029437
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j962fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3NyGeAxQQFRImptnGISv6ftcUPQOg620p/Bey8B+K7Ik8cWw/WTDOq8EFDKMqWO1DFqiyuQsYoVB1uLkDBcTqAu/KjJ+sCyVFn0OIHa8+1y7PignrBw+0Kb6ZFs6pgk9L7L5EEEzcL9wyp7eBOuBS7xUiNFdKHc+nEXyXYLcSHcieD1181rUwHVTg5Fw6heDV6sqjEAqnxCTsZS4y0yMjfv1/hqtKQCUHCnwQ7W7Ni4yMNfiju9SaXemZ72aEomYwqZ9OfKXxiyfoGa11HnPXwP3xOzC1QzNMJ/GOYutrjykKj2zNleQPiL9cbnN2rgx++xAtBB/DsF28Isl1Ce6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP4hajZdjLN+VdDBd3Kxw3rQyAfyw/C7rT4D1TnRnlc=;
 b=ej3lxjosvHQ5KV1zFQmjaKwNaiPIeGL8IfDGBkK1lJSZJPEuiFwkz1p+GAiSVs3WcXWr0t9sxJu6ON2XCNbWr1DL6uZFwkM7Re6IehrNEnJqX+SHzXXfCyKTm1WqjqPpNelAsVUgx3vkHXmTS2eY0ej34XCwcsuuqxO3KdsCiUKXdLG9vPdV30yFKmmm7gQajI+o/g8Ycdyq/o7IQmGB/Xz8kXIWZn6dX0Mwtly34jT7QBOKIjHHbhJ2GlXrQDJzI+NMP9ELjLu8SLKGqNsxXNicmzJIz8IlTK5tAbyh4ktPHGF2FBa2IhZPcVk2l2oGr/nbFcY0Pm7bzKDpd4lHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP4hajZdjLN+VdDBd3Kxw3rQyAfyw/C7rT4D1TnRnlc=;
 b=OaX6qQxaDzK9DsjHil3rhshsTle+9bsztgo3xYXLd/j66xpdZroBN7moScIL7jeuQLF3WECDyp/PRPZSDouBAHrupbuFuN+LyIki4ug6TftI0wL8/CmDK/TbKm1umL/oW1KBhO8UBZBvanx6aVkBWBj7afnSWq8oDbpW6cmWDy8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:16:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:16:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/4] btrfs: fix fsid in btrfs_validate_super
Date:   Fri, 28 Jul 2023 23:16:15 +0800
Message-Id: <b98c9c2de895323e5bf1ec9f21cb299ec7731814.1690541079.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690541079.git.anand.jain@oracle.com>
References: <cover.1690541079.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2cf965-5ca3-4277-6206-08db8f7da67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv3poSrO7w9pu9FiD6YiKjmH6RmzVVX2dBF8QgFff55PCxonJvPlQBbd66c99q7W3NZp/DKTw/peySLLzkvhBU/OXuryhMkq8vv97WhFs8AKRyTQgMrR55qAvKp9jBJYYZ9kmVgfIt7b4bjEi5O2wZst/UOJOTt1sBqcwkYxunWWUy1v8V0VrGu0EKgExE55szAzxSGJOEaJqC65Z3j3KcT5hwIkrqsiC/Y2Shxwv8w0vgHhi3F4hhC7Rop2ht5AuYny8/kuWG7iCK+1v5zWvWocgOZ92Ex7a38ZuTjj4dG2JRc+NNB2DFlPJlq7/nCxFg0l3Gzn5piUwYBsz+YQAZhmdc14PfnwXcjPOzV2GCzLsNS1xHwL84uyxc/ImRrE33Zt3qXN4IJCKfgAPF3+3PL88j+uioLEnhUZZF0aVRhmD6WzN+lLPRP55W4bTuut8w3tqIqrxUKkAZMyAUZYbzXqWpnAhYofHkBoITWrS9VRx/O1jCX4t7TDznhgZHTUZR+GeI2d50oPCkyJvMPGESuol/iHMI1HGi+B9bL5xuEGvcklXUe32hoYAUH17mR3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(83380400001)(26005)(2616005)(8936002)(8676002)(186003)(5660300002)(86362001)(6506007)(107886003)(41300700001)(6512007)(6666004)(478600001)(2906002)(66946007)(6486002)(36756003)(38100700002)(316002)(66556008)(6916009)(4326008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MnXcAvY10Zcz58dKZXLMc9cGtJQlh6aHIiEPBfYJYPp5d4j1Y8p3z+5QVW1p?=
 =?us-ascii?Q?nvCkqs+deYbkrZnkASo5gc7Id4VtjzZLHn15+/hWgGgLjlkcUz3IJd/3NfdC?=
 =?us-ascii?Q?6AnvvQXGRvCgmG/kuHFvMraAJUVfsHVGtCoA9hI3afh6V6G1LKHDmsBPIGub?=
 =?us-ascii?Q?/0Lcp5YegpbdMvoqTq5Va2co9c9zNfmh9tY09UxARhtTW9fAd5ipo7FKdl3k?=
 =?us-ascii?Q?WjPAEqlda7G3FgWouojYKs4C1ek9awL9WBGdTW7yMOjkTtsi6DN3auCIFY4l?=
 =?us-ascii?Q?x0MAQtvPQMBY4mlQwcMLg4FzLj+23pbIkVJbiJaCLpSu1fzOxP4EjBplqUd+?=
 =?us-ascii?Q?CiC5OxtFrCSk159/qlebNkb7gzCUED33IK1OiS1anmZKCSZE8TL3MGKvDudc?=
 =?us-ascii?Q?GYD4tifsR9LtSrVkGKKVNa6SS57aRseQ7dwF77nYn/0EWxbhaEuAuRVkctoi?=
 =?us-ascii?Q?SwC0jjOXtoN4k/XtJjb0Fg2/njDBXMLV31Wqc9rYB4d6XY9wHAsoEVSN46A+?=
 =?us-ascii?Q?h++EBpM7f5slSHprAqFJgZ081HTjVwk3Fb7aZIgMNoGwZSgnTJ6S0Zmd3AP9?=
 =?us-ascii?Q?b9WRnON6/lV6cqUD4kgLBaVdbxoFJmgW8ab50PIctXkdAixrsEUCPdosEKQs?=
 =?us-ascii?Q?RGXURusgK1QG/j4X7an5XfdJnGrzS3EQOHM5vTfTHflhAU3v0RWFi6GTgt29?=
 =?us-ascii?Q?ty8jVkRvaUPSqdbmC1Vxth8yjJsB1dAJRRI9XS/DhA/Tw31a61VlvA7Q0EkH?=
 =?us-ascii?Q?eH73hM40QBhiNmwxJWJ1DEVKySzWHOsDYuOoKE6MyF4aUoaljWDnIECkSCNJ?=
 =?us-ascii?Q?vH28POa7y0dIK1fYmE68fiecQaGbf/nByNAhp+iPDYvTanpSN/kKe1ihbKTt?=
 =?us-ascii?Q?g5TJfELbCEUv3UwrR09yoTgJuihp3H3pEtkwqe6Wne0DSBmrA0Fegfq11dIv?=
 =?us-ascii?Q?0ZLjd3SFQ4Ru2IZoxg4kzA9rGoyFsSZgTbjhBvs3PKSFPvuN0evTj3Y5kTPP?=
 =?us-ascii?Q?yKu6jVfzApJV2aPQBnpSIKBNZ4Zza2kIs0SMM27fb6tHozAaGGe7QRh4hDHs?=
 =?us-ascii?Q?JhDnFTD99j40ZuD1T39wTqT7kaDQNy9dk9Y32QQH4HKQbgVp+2OQvNQbzO3/?=
 =?us-ascii?Q?Vyrwe+DVc7sxFSrDUNjkJauvryMDy5ttFVK0opgSayQ6QBGyAogKnklvHdIp?=
 =?us-ascii?Q?yKirhyM5HFkM0BNCKzOsbCuwWQfwNLu9Xko68E1UtJkVEghdaec+/jNrLn7e?=
 =?us-ascii?Q?PM5DWtm/R1MvRkxFt5ZAG6oQhemhmn5600S+WdVKgHJFh3NC8/iQULpSZe5c?=
 =?us-ascii?Q?n5VVqolEdAnXPl8MX31KzRBRd6Hqe+RoQuss0D9hcWNw7B7v90szx5g8nNKT?=
 =?us-ascii?Q?AUyjEOktYHBfMNOpMrHYwi/AohBoS13WBCOaQELi0vzDH9jne/NtlIsnlhgB?=
 =?us-ascii?Q?PIGDFwzyeDoraAIagljKGBcix2jSUfH0fgw2FSlKHXGgLae1etMCbfXIGijK?=
 =?us-ascii?Q?eUX7OA6mU4JL0EPTSUFoLVOP9fWItp6palN2eikUFcKw8XTwyo3/JD+7JJ6o?=
 =?us-ascii?Q?deujzai3zfsiVoYngwhYtFDapsEl71uTxlzDR7rK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIkzwcgIAUdXFeucz5+jp+duDsla50+kHaFZ02YJsbPyx7yWPNZ6O3AdpuLpXiKU4QJGJwkneSzlU5i+4A5aik+3lEH21ZHpzfpzmHnWoS3V62jcYaT7LS4zeBypCEK1+x40pLkpn8YKc6qpX0TFK4Wb+XmxG/ij6xV9bvdO3cRiWGe5fT5ctjrCrwBZi8jssMBVtkZCDwgJGCgKhFo+1gkFSy8LoiZ9mf0cJIEAuAvGF/Iu8aQNCA0wZCgtiufLZePX3wd/E3uxXO4IsS56SDJ2nIMej+2FlTdg+dMpJidBvGqka6GewM55Rp7jECCOy33hY8lUe9085jBVi+GGvmGY8awXf5uSuK1WJvhCyBMoDXFLx1pLDEzoJehc00FNtv7B+OaX5fS0oogCeQnHbv717bOfYNNpwpmf1a4EJaaqdY0UhCL8qkEcbhHFtM3vdcnGqYBa8lz3ti48y+NCIbpmtGMPz7zsQ+5Wx+QCV9uckTa4ruO/2ZJUGGBagr/49ia+F1cHIxMFn/3mjReAygoveiV7StGPIvS/KVaPzLBMEco3SK4ITtvSJ8ylhegyJGPSxXUfUrMpOHg+JhSJtpxgxVjNEvrLoz/H7rzxXBvVxxI6oIdCKOASpu1LzJ0TguaC8NpFwZoDk95fApXXDGcLhRGFGNxvsi5nXkk2896xJN59Vi70OhPzl4i2x6i5P+egmwbb7NKJfqywISPFS4tBFvyYAcNx3MWcibuFApdP+oEoYTSEVfv+6FeWY2m8vUVsQJH3R8n6BQZO8dezOw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2cf965-5ca3-4277-6206-08db8f7da67e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:16:43.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jgg4JqSRs65spHQslnh3Ruhl6fcInJ3K9VbTVwDZFI0bA59D8EppQY0ukVeoqkVmbzUgVzGU9/m7wJykPMP/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280140
X-Proofpoint-GUID: GgBFhxXTQYbe1Mys3LeVtpZRlBM25bmS
X-Proofpoint-ORIG-GUID: GgBFhxXTQYbe1Mys3LeVtpZRlBM25bmS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_validate_super() should verify the fsid in the provided
superblock argument. Because, all its callers expects it to do that.

Such as in the following stack:

   write_all_supers()
       sb = fs_info->super_for_commit;
       btrfs_validate_write_super(.., sb)
         btrfs_validate_super(.., sb, ..)

   scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

But, currently we verifies the fs_info::super_copy::fsid instead,
which does not help.

Fix this using the correct fsid in the superblock argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b4495d4c1533..f2279eb93370 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2373,11 +2373,10 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		   BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
-			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
+			  sb->fsid, fs_info->fs_devices->fsid);
 		ret = -EINVAL;
 	}
 
-- 
2.38.1

