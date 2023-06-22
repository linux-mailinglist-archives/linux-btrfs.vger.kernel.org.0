Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD0739944
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFVIT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFVITZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:19:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD31FDF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:19:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pTYP025387
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=S3KxECa01pqcqHiyGakrWwEeHodue4ns7EIBhkYJEKs=;
 b=FF7AYmnLomLrmAnGhUbZ2rYLjoBYRUJAEwjTB+BMS2XiZGe3d8oXMm1fSkRK1E/Qo8NM
 NTfnN/dpOB//gNNPnCBMu/UHzpplrX/8USh3UgmIvm+ElCZXWP5tgZrFczVjl6lYV2D4
 eq3ISp4TrP8yh/h9EEUwgEZ3p5ktM+2go2E4mDZTxV39Cws6AzBR+eJjchHcf1NL8IJE
 1jtg+mc3a1gMzof3Fcrhk0L6YdU7efKdcU/7V4EpHw6ZBkfs4O2Yq1N8C72pHp1t2nv+
 eZbGlDAWYpR7MF7tDeLOYjgYXjqy1N5Jja1iJ9w5K5BUTLnm8JQU9dFCd53d/twS17B2 ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu17gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7fLZW038670
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93976n92-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bayzeKrUvrU/NyZor9j7JeCy8W0xjLkhOOHYjvMo/P6yOC82rtdW6dRkRu9ctuLFHAAZMzEgpsWKn1OFrnGzYARuyZMvzg3UDKcz3c27e254pCVaVTFZ/n2WvzI0up4CtBM77NdsClqmy/lpE2JoebbQZ6UnFv88KZinQwgwsWrcAultVQtt1pdbyJsTfzQDdw3jKpLmT7yOi3B5ZlOO3bySyOLPxnCdrLsJRgD4jsYeDbWksCK2RqT39uC8Dtmoa56TcsH/eYBaC3OMo7R9qCVEbX+c+Uv43Z/etAW6KIkaBJHvs510MnIPrv6xXGNWN2G536CsTRNmj0BSdjxVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3KxECa01pqcqHiyGakrWwEeHodue4ns7EIBhkYJEKs=;
 b=kadyxua+U5z587CPtl926dyL079M1xHrq+NgAR9um6o/GaezSnySbxoCRM42Xu6wcEKB0aEYSmBvD5onazoLvalu/rYEnuZxvJR8dyYBPl2GlxvyIg8QrXYzJ85q1/C5E1+cdXbR08OCTIUWy3zK9iaCrN8xN7GgnBzFIYkvft+0uT3hkfO9RUOki+TWUpgiIUVHOqEmSryHsLc0rUT0hof8ORjFjTa0czH0nMXJVR52H85NKR2q9HIbZkKX6z8zkkxDgoVlgiKhl0CxYNdWI5hERercblSXQVdr7cmvsHHJ67dmbPNbtzJmzkplFfs+NvYfP0dZvz910uL3zN76CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3KxECa01pqcqHiyGakrWwEeHodue4ns7EIBhkYJEKs=;
 b=rqgWyG5u40viVOoeKI/fll/frzqBJrz3AJW/o5tcWmPQ5NXOQjmXN4FdOfmD/9kX31Gb+/mSQZ4JbVRtS95KiX2J57A40r5KbEVZgUGg0cPRrt6OYpptmrbVGZXa9t/bfMh46N3j05wmEmDFXGDUszJ6c2LyyytNOaJCQXgFwcQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 08:18:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 08:18:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2 v2] btrfs-progs: tests: check for btrfs ACL support
Date:   Thu, 22 Jun 2023 16:18:12 +0800
Message-Id: <7e35dc221bee1810d2a549edb7420378d866ff52.1687419918.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687419918.git.anand.jain@oracle.com>
References: <cover.1687419918.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 095ddc55-c98f-4f7f-2fb7-08db72f94a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+whQ41apwUKH5hbawP5Amj6MGLWzDVZBv+fqcYGd3KzXirrGZDhOA2zms0e10PniheYxMcwm7xaTnSqw101m8CWJUUS0STrROtO0Y4PI+EC2JF3XZ4srHbeNwtm4oqqihDAF+s3bZWcEp+4HV47g+WYY6rl0imy7ih1N5GgCDbXYUjK7U6m06/Ad6o3n29iolZHNLD4aL+1IsqwrG9HMzn6iQH2sLj423vYOHEF09TYDs4WcfbqATsR6ZkW/qJ1q9wPBdbz4PrPaZilBVLBzpJHY2O5hthF6YepODJnQsqWCzH6GlIrBh1lqZXpKIgp43XLFJPd6Dcsz8mIp83067VWsHUftJrB11oFGV57F0QollWUsmf9ImFMcUnTyrvVaYetuuNDH49dm3KD0mPaTYIGyVktnJIb7Uxn0nieQwuGjBY4xyNzzYlj77uU88Du+UgfTv48eccjJt2WLapDluGoiKLShCdgbtoGaDHRIH7k8V0HkppWD9cAHKEm6FNUIRmu82h/YI6wmNHEbcVGGR+W/LWtYlovS38FQJ4W4HRj7vInPLRmR6wwGyPTE/4Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36756003)(86362001)(38100700002)(2616005)(83380400001)(6506007)(186003)(26005)(6512007)(8676002)(478600001)(44832011)(6666004)(6486002)(316002)(66476007)(6916009)(66946007)(66556008)(5660300002)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmsDqCDiB0zUs+ou3NrL/zS3993lkDwWLR/PSm4jkHAPIn+Zsv/1R4BuBtdB?=
 =?us-ascii?Q?Wxua+wEWJfBoPYbYIhsxDt30t8rLAyti0BLETH23w2J9pMlrVimXecc3txGj?=
 =?us-ascii?Q?pR7qSPQGVa5GfvP3QIkdScFYObxAGopnhCgKR6umI//6E4+dexGiLBziUys+?=
 =?us-ascii?Q?xkHTp3AvOV5cANmoSggeVSPfGbVyNeAKW7qRA+1tVsZBiuC7jRohHzuc+IxN?=
 =?us-ascii?Q?wpECeuf6aVEvAvCXlhG7D3ACyILHxoNVu8cbaq3x/BG+K6yVX6aIZ+YzM+kF?=
 =?us-ascii?Q?JuuXJ3sdKJQJHHam/9j2LIdbDLZrCwAkcJAL/tCCl9V9nCCadQibyOVc+X1G?=
 =?us-ascii?Q?TeZtTpitf9rdnGxF3nzLkEjI/IFzPPSzwACJan6cxocZFkd31N43sWybVx/j?=
 =?us-ascii?Q?fT9b+0J0r6oPFiHx9ZafadvcXD1ltEA5n8Eyd12zAOepw8CqrTV0Jc9uEzHm?=
 =?us-ascii?Q?btHH3WJhM/nY/VauiaEAnYX8Vlh5jH1vW+Ibvr5GO2JhCswbd1+qdL1kK0we?=
 =?us-ascii?Q?OaKTezT1+tm1T5v5MmEQDFRGWZ0B8A/tV9D7roIbcDVHpYCLJOyK+hj9h/vV?=
 =?us-ascii?Q?vu8KZoPDCOQxxdsnlTfxQHOE9Dg+ZN5g5xtX2Zg4TqfybzusrY/+2V0/JK1z?=
 =?us-ascii?Q?jYLrPp+8e/qxm5Z+CdV2sLl81fxAWC2HVM4H1eV3/E2EFSQO/2jOTWWxBaP/?=
 =?us-ascii?Q?Flu2CfgjpjKanThJ9yp7CAfmHYpGP9tOEu03AJL2ftvCG2qF93+DHy3gYNz/?=
 =?us-ascii?Q?CqZ0412121d8m/vv5HeC+l+IM98Z3709q6TgYCN1/qW39hF0W6DIexp7pZyR?=
 =?us-ascii?Q?AhZMXrSC7Dv5C2QJLeJ09WXE/ZfcTKilgecAjKQb2b+n+P9DjFTyamU+WBoQ?=
 =?us-ascii?Q?AQUQxPpO+5Y2NKUsd7fjUe7dc9puqpSJt+at7ANd/b11vs/QNZPGFWuoyREn?=
 =?us-ascii?Q?uns9xvxsGwWXj3VnUH7c+P9WHL8YEo8vam9qbdaApimSt7jZKiBnDBPqanZa?=
 =?us-ascii?Q?wQm1x7RDzHRypTM2IlHEJqbdOd5dpeR1EuG8cJCb7z7XYhPXj0gYMKRTsiPN?=
 =?us-ascii?Q?MsXnwqmT2QKWXpAmuXWEMDEkBIoFJPv8AnGdbsZcfSgIsjegWB2wyFN1XIHz?=
 =?us-ascii?Q?dLrOZjZ1t0PgpGsIwrSxjxAgZuC+102OuYPEmxj2ehlvv/g6f5TBfaJkOQzE?=
 =?us-ascii?Q?vvOajOt3f6cnq5kqCpqgeCUl6AKH5o9aFE6MsgdpW0zORwOOV1mHFoofGoqh?=
 =?us-ascii?Q?18TdrhEEmOjoU4IlIjuvYbbQMyt+H8vK9782rzMfL8UQN0OU/b8ng7cuBEYY?=
 =?us-ascii?Q?tfnLbRH3S1GaLVKP1mkoQremcOOzX4c2jRgk5uqia99sslmWhgUIfiTIqwoE?=
 =?us-ascii?Q?wDO5YSwhvwO4gxMoG/FemdfxAhV2x7fTqyLrmiiJlXsKSVIX4XDbUEeDD4n2?=
 =?us-ascii?Q?el4ofwOOZ/bfa+lhkqDzYl3Pnqm/yPA4olVinu8HVLxXQazpqU3f3tyIYFKE?=
 =?us-ascii?Q?4fdGVtSZSgsqHzk/YQ0+aoSUyd1UtsR/oMQyWiV1qhMw29wC9cgetU3sUTkg?=
 =?us-ascii?Q?v+7L74pzt9YtZ33P7qHFHxC0MVf3mSt63ooubuul?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iD7O/qV61Cq0LhKtOJhbmsLGVj9/+XMCpkoXywzrki4kgbg0spJtjaEyoMlxlehaAgvYGrbmraosr0DOv+camSQIRzW96Mtif7WgMPItkaQbyQBjG/xWSaCYOpU/c163njqhxZMFL8UIDf4bvRFZJlVvI61LPRPPuw3K+4k362LMphttkqXHalze/rDUzzmzEnILmU/mdhNheQptJODyeQIyanfrvUcT3MsqOMiwtIE+683EjhWRc8OJV+g9iiVwLQZkcbDKV0WpxzlxZggcLQpR+eYXcDMdOSpZ9r3gXwJBbx3iqbpqP7sRJVIiLBYUAbla+rE/fpK9Aq9rGph5Eg7e7XRJradPD6dMQPVEgbk/hV27EIan9NIuQu2TYOBWqkXnJfVnYtyyGN57En/uwY/j9X5k/7YKI7emzJH3t9rY8lgG/DxrCd3jIKn3E+M+D1EtGB8S3esKu9qPu5MlTmObDzuT8/hGe3rBXV3DIBhRiug0owQsQBlWDnxqcVh55rsjVOOfxWKMZTLBoDxaXo8ftzIO5s793H2moQx9VNW31n2Ax6l/a6/QyWKwt9+fcjBUj9ffOZL5jj5VrWSdPGqSMGumILPk5EWJUMZqGtfBWLasEuleZfIzemT+Dz/dna1+Ef80Cy/ilOzdpC8x6jeRiAK41Bp/3scNQAjBW2C8SxHscyCf8JYlHVP4FGkIwVoKca0QdDnRDc1Eac97sixJ21asUwq/hHY5v+AqvasqNfI9BQhWfdOfHUEgH7bJ9CI+M3YdC0jLtRiOl4tI7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ddc55-c98f-4f7f-2fb7-08db72f94a2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:18:42.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2MBWCUGCV51/2ZhRGjfdQ65WMptKxWmB6qlrWHeqNMZ6ZcuJDE4e8J7cY3x3o3MSd+qQp7ZyQFW8zfbMzt0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220068
X-Proofpoint-GUID: bQcP--MbXGxL-1hI77RFpv3PoLaobjTK
X-Proofpoint-ORIG-GUID: bQcP--MbXGxL-1hI77RFpv3PoLaobjTK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix failures caused by the lack of ACL support in btrfs. For example:

  $ make test
    ::
    [TEST/misc]   057-btrfstune-free-space-tree
    failed: setfacl -m u:root:x /Volumes/ws/btrfs-progs/tests/mnt/acls/acls.1
    test failed for case 057-btrfstune-free-space-tree
    make: *** [Makefile:493: test-misc] Error 1

Similar failures occurred in the test cases convert/001-ext2-basic,
convert/003-ext4-basic, convert/005-delete-all-rollback, and
convert/006-large-hole-extent.

Resolve it by adding a check for ACL support using the
check_kernel_support_acl() helper function. It gracefully handles the case
when ACL support is not compiled by calling _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Merge individual test case fixes into a single patch.

 tests/convert-tests/001-ext2-basic/test.sh             | 1 +
 tests/convert-tests/003-ext4-basic/test.sh             | 1 +
 tests/convert-tests/005-delete-all-rollback/test.sh    | 1 +
 tests/convert-tests/006-large-hole-extent/test.sh      | 1 +
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 4e8aaecb2f55..3ed3ed0b82c9 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -8,6 +8,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index 8a0b2e333554..dd7bb59181b0 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -8,6 +8,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
diff --git a/tests/convert-tests/005-delete-all-rollback/test.sh b/tests/convert-tests/005-delete-all-rollback/test.sh
index 0b668a6fc1de..17bf8a379b6b 100755
--- a/tests/convert-tests/005-delete-all-rollback/test.sh
+++ b/tests/convert-tests/005-delete-all-rollback/test.sh
@@ -10,6 +10,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_kernel_support_acl
 
 # simple wrapper for a convert test
 # $1: btrfs features, argument to -O
diff --git a/tests/convert-tests/006-large-hole-extent/test.sh b/tests/convert-tests/006-large-hole-extent/test.sh
index 872b4a6f6175..7d92eb463af8 100755
--- a/tests/convert-tests/006-large-hole-extent/test.sh
+++ b/tests/convert-tests/006-large-hole-extent/test.sh
@@ -13,6 +13,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_kernel_support_acl
 
 default_mke2fs="mke2fs -t ext4 -b 4096"
 convert_test_preamble '' 'large hole extent test' 16k "$default_mke2fs"
diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
index 93ff4307fca9..8d9a858ddc2f 100755
--- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -10,6 +10,7 @@ check_prereq btrfs
 
 setup_root_helper
 prepare_test_dev
+check_kernel_support_acl
 
 run_check_mkfs_test_dev -O ^free-space-tree
 run_check_mount_test_dev
-- 
2.39.3

