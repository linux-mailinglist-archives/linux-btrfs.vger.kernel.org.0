Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B797A9660
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjIURIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjIURI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 13:08:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56C5276;
        Thu, 21 Sep 2023 10:05:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJdIf031818;
        Thu, 21 Sep 2023 05:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gBILbacAw6IlWBrOxsGQrzD4kMtB1keNbzfF72vqlbI=;
 b=MHlsTimfIK7TdHr1R3FoK9SIKPJU4HTm4xa0cBmf7vOqcxW1QLthNo7Jw8ZIVgCFoAnq
 fAPsy3Ap9gSFnWXBKNKf7hy+w9GfKTd35F1/N+K9d+9+mqAlQdnxo4/v0q3OS7UQSCY4
 SSkNi13P303LbmJwpah+7WngpNZYcLfw+DDmVgimfLOmsoNwXpUCWP1k+SG1xKzHZzlu
 i3k79mEVr3QncBkO/fXuxODoNgVdAtoQC+JGn1k0wZTMzPAPbQpiikqW/7gpks3ZnZ6d
 ZlvDhdyMPhFE/QC0AAieB+YNUC11uQBwsrePV5JMM0QgrSxz5e78SVOL8XGaXldIVQXo VQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wuruq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 05:23:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38L43vs6030065;
        Thu, 21 Sep 2023 05:23:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t81q3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 05:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS9fTU8r4uRrRce5uZXFZ+NI2EG2f4C+raTzp31gYjvvtJrJ/RBD1cAXblmHxzy4H2yY694qt5+lThy+2VcbreAjyaoFN4grrC4euLY156dGPHU2QShKoSF126xQbfPZqZsLvnqbDSO7STvDdKsn/XCD/ktUtP8kO4YUKynRSgVpwlG+Gl+xt4nSP9k5ldyetbV0XbwJ4fukQU5+bP07/jKoV0nqBnVL/siSNFTb8HCFru4oQN2kMPaTnX6D4sJUGUB42fdq/XEsPAmgzNMcRpwZI6PqAHasN+ceUoeKJIryzJUUNZi+oJYmzm1/RSAtcA/Ixcq/LDaKvvcDQgfNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBILbacAw6IlWBrOxsGQrzD4kMtB1keNbzfF72vqlbI=;
 b=D5xhHmJxvGUShjAUnM5pr0rxcVBIC/KZN40VeW5CGhcZsaVdyWRcMhynu/3sf46hHHL/Y15TopZJV7sbTjf3ikoRItQWNLmn0TXQlLL+8wWKSKkomvu8FAspLh/9bwoYNaISalfVgPuN6cUdBwma11cg3AtAk3Sdn67k4yvCYySuUosUwlAWi6hHdYUK8Gb8nOXrMcQ643zP/mA+Dks4XIdmvoA+pU5OTt7D/ONrrLPXlt6F25myS83V5AcmFwD6nqDDhqms0mW7gXXInaErkd+/x9GuKzqcpnbnsVpx8Bc+WhCdI6mOF9aSGuLyUFRMeQtA+Aa833u9fGrfQ6wOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBILbacAw6IlWBrOxsGQrzD4kMtB1keNbzfF72vqlbI=;
 b=l78A0iMla5tFw3DLbLYHut8QEyBTq04JuMyuug3jes05lZ6J+6mAHTNQpiY0paGp2nW+qkdocxAyY0PILhVBJlX433zimzocAbLIkvdCmgqCbnDq1m34KuN6Jfc6LIaA+qeEtaDPw1WN+4+EQQ3Q9r40DtIscJbm8e1DsbFhWh8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 21 Sep
 2023 05:23:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 05:23:10 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add missing _fixed_by_kernel_commit for a few tests
Date:   Thu, 21 Sep 2023 13:22:16 +0800
Message-Id: <34b81b45d31ac4f951a1eb218870f27e74920a75.1695272311.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaeb2ce-a231-4472-4fe1-08dbba62d809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xduNPUWHaLTmxRht0sr4dm8CLZotdPCxbnqUAkFbM/YjFIFQYZY0MsRZAQsSoC+8d68vhP8eXNi6IBXqmyBzKkSqMEgyVBKprl09fUmkt4KaARGpHixyDTjBQQUl1by+jRuK7DJ6beb284ZpHHVMJKc7OexcHv39i+Rdv6qdGrSzknsIDj1khg39EFp6MB/XeFa9OSWl9gZSJToyyljGkTddEnGsAM2xziqZ61vZBZ7+i7f7KtXZEyoKuozLI11uEd3snmhv+5TEk1VsoHXAEqw01Vgp2Rjh3r/CkZkIgDeZvW/Iw+8Ak74ctdrhPbsd2c5UYV7dBXssXi8mNt9TdHRqWC12PPJ3y9hySwYlyC3aK4OQNz+iFZe2uR/3jEBLzJJ6iHse1lbe19E0tTKvYeeoUJJH9o5EtnVaRtoM3f2QF70t1FFN6g2j7/iBn15NW78au+kPeiDugoUoggU6Ibg+RUCDCy8KI3U0eDpYfVaBakcra2id28SuVYTSAVaWz1RUoDwPZByLGeeVztxd0rlqUk7JiJIUn5rEq+LB/GYlMDY5XieqdFVEuNHBGQX1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199024)(186009)(1800799009)(2906002)(4326008)(5660300002)(44832011)(8936002)(41300700001)(450100002)(26005)(6916009)(316002)(66946007)(66556008)(8676002)(6506007)(478600001)(36756003)(6486002)(83380400001)(66476007)(2616005)(38100700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnZx+ekWSBbQ+S2DvD0/Lq2yJFvhIWsLP1E6bTCSxsxZXfc8Z6QNFZrV3EfL?=
 =?us-ascii?Q?xCdRZtxpNrThpFhmOag2+ezY7cUJ7ve+emLG63vCSFSL1xAGyA6f+ia0B0iC?=
 =?us-ascii?Q?BdU+jAUG17FAe74LEkyMMxma8YaLf/hh8L1tZtyRb2ms8GdZ8A7nbKB7iVHt?=
 =?us-ascii?Q?CM0dlkMArMnLfOYEPQmMzee56mwR9V1pIWkrF9gZKyn95aUkMDTVq7vbuPLi?=
 =?us-ascii?Q?whieXLP/fD4+vmi9VjY5jqo0F2s4BLFqMvQYl+uqtZpFZHPD6uAQ9G+Y0Fja?=
 =?us-ascii?Q?kNEN35ofzTQP9BD33jDxxrRxVekKNT+zQrkN443Jlp/WjcZ9QY+99mkceuzI?=
 =?us-ascii?Q?eH68cF6e9PSh9pwepbxrJ70s8qRE6yyR2Jsr3f6pg6MaaHC8xVGg13+b2AcO?=
 =?us-ascii?Q?4TOfRG+FrEFqUhqKfPS41rQMyFDZqPktMRwajwIj6YPINT+Lei0cB4iUfP6g?=
 =?us-ascii?Q?GHuDQ3JmUNXUsVRViKbW7Q96TLk6FTyXyZWlXx566VQc4Qt7l9oLpfXEtFvG?=
 =?us-ascii?Q?ZOJ6yxfZb3vkVrPVdYyYMuaNCrDaI0vZuoXWNf97z5mexQWDROwKtpGvI0J7?=
 =?us-ascii?Q?y8xRktPWGLoOFGqRCUgfOiD9PECjBu9TWfsxVWYxwgKhkKw8K8WP5tRuUx+o?=
 =?us-ascii?Q?cUMgPe5L50DvIrP896R9BqPbYMgH2fFL5uZpIWQ9AJxnSHcXtaqMFwCPd0w7?=
 =?us-ascii?Q?vFxYNcluQs6Dg0QqatAfFBbSCoBFJhva9vAOqcHJtivLwIeSoCysJnNpZtXD?=
 =?us-ascii?Q?fRBYnaUx+/K5oktc4bt5BvdufbAiy1AGNQsjN6iTYFWUh6A9H7avQhWfbxWj?=
 =?us-ascii?Q?R+UDDrxXMdKcN4IVLgeD++cD01Di3E1RC0XbVzYJ7XU+h6EmFUZVKkrK8S4C?=
 =?us-ascii?Q?f4pbbnYEEk+tAQOj2s3tR8X36IucIFksgAG0mc1MOCSKGatwkOlk9G/cRnM7?=
 =?us-ascii?Q?QHAZ/7uc9gVW7+xrV7rVdxs2foLRQUJOaccLBgS0BdOEx89qPfN6RNgAu92z?=
 =?us-ascii?Q?LyC4idwxDMAmf+qxpVYumQJjayEsKqG+kEINRfE1LTc2UX/+aZtT7TNmx7tP?=
 =?us-ascii?Q?eHY/nTmrq4a7XT4cAEDWFWVfnl0ohuLe9p0v/7gdiPW4CLKBiYbBXvoK6t37?=
 =?us-ascii?Q?zOipYurYsF+FTvjFn2/Hez+Oqgzfu5GFORAizdgnRPAdb70sf/7GxVvGgfko?=
 =?us-ascii?Q?n9mAQZO9ZSMD22qacS0i5fuPSlBAOX248YxnIM4U4STir5pZU3wX4Oa9Gwds?=
 =?us-ascii?Q?xQrdwkSL90TYaSwFEd9YhCFwH9uvBGUEPoW/bmwJBiglOG/MrFhyEBKNJob9?=
 =?us-ascii?Q?80WXdVD9EuEFY3KhJueUIhcoAOKWDy/2mQzZsRZMUpSkpE0YvbWronB5H2Ed?=
 =?us-ascii?Q?E9sV5wODiCR2xwFwPf3juTnGtLaOCIJRivhEI/2nwnBZj3jvBtDd250+/tYv?=
 =?us-ascii?Q?04Oa4+v0dMzi1cLpEjq03YMVHT0PmejY9grkQ/WN135E+Fq2QhqPI+aOg6Xt?=
 =?us-ascii?Q?rKU4y13f9K980haQmDCSq/riQFz+zOBQxNH1MQHEhKlfdmEYnya2BQ2Szgge?=
 =?us-ascii?Q?e3zDy4h27ljzNI7HEKQEptQVmfWoozbBZ0mMU+CT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uYB+BEYOFZUclC2iklVhnGtVEIlP0bPdNEspBjHmYQt2hD120DAMEbLst1StrYPl/c96Tn6u+I/ScaSZ+SNb5nWx+3pXj0iJaiOJx7nxTj3vRcaSPbNKfSx7wlgugMZ5CnH4BTz8ndDNx4P1gIpw5Pxa7OBqjz+tv1HhNMTeN25wTGb0NBUVCs+OLwfVWZvcpOvVawrp4Ax5WHFMC7Nq6aDrMwTFNxfNoUfePh/MWCzp9DNgMcg7JWzm0mrrMSyoqOrX8WP2o/GjEC/wXapCiKiPLpKP4kGXC8PpX850Wqtp7hH/eQIbKEVIQMfLpwWUnOM157Zqjg4HSalX3CxFCzpZQu37aDuiiqSj3jKasHjdzcMZiApZHl6potZtKnATKl8SCIHWEerk35wMrRyJ2wEWsMbUmGBjsm9CqzylAcSF1RdaQEBt7K5owC9ULr0S3zy5T9agYJ0OgqvmHNcDsZ+0eRfMIvf6k7weEUBNkiwJC+HFNMDBYG3UVL+e5xBrdMskCY6RVXLS3TSY0WNi4qpizgNsOfs6ijeGaQvkERzkw3cv7b1x8rxqukLlSuV7ddckAoNkiOIPqNOQx5PmOKOrs9ozQQ8lKB0JOrQEhs+XzJ/x6Vch9QubL0cY8YcvSLOrmmSrmzJ/41Yjn7/R0HD7GXi+NJedgOV8u3vAcHvlVL+HZ3pStVFbKHxKU8vzp8PdC4zBCukfEJ61XCW5ugjIw/IgNqldeumyrHW0QBHONXTCoupcrurDCkDpiecGtpaHGa/ohqNkD3VPtRxAiQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaeb2ce-a231-4472-4fe1-08dbba62d809
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 05:23:09.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtpmw8wXg2PsO73emExi/H9IAoZH6YhYsj6XAqPMbkZHx9mTZASOqUa8ZzDFh8eKcq0sEKDBT/RxAYRjqHAReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_03,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210047
X-Proofpoint-GUID: RFxOiQgzuqlA58ZULGFcXBShXHJzEQ9D
X-Proofpoint-ORIG-GUID: RFxOiQgzuqlA58ZULGFcXBShXHJzEQ9D
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few tests were still using the older style of mentioning the fix in the
comment section. This patch migrates them to using
_fixed_by_kernel_commit.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/199 | 6 +++---
 tests/btrfs/216 | 4 ++--
 tests/btrfs/218 | 6 ++----
 tests/btrfs/225 | 4 ++--
 tests/btrfs/238 | 5 ++---
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tests/btrfs/199 b/tests/btrfs/199
index 709ad1f988c3..a4920b99ef97 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -12,9 +12,6 @@
 # There is a long existing bug that btrfs doesn't discard all space for
 # above mentioned case.
 #
-# The fix is: "btrfs: extent-tree: Ensure we trim ranges across block group
-# boundary"
-#
 . ./common/preamble
 _begin_fstest auto quick trim fiemap
 
@@ -34,6 +31,9 @@ _cleanup()
 
 # Modify as appropriate.
 _supported_fs btrfs
+_fixed_by_kernel_commit 6b7faadd985c \
+	"btrfs: Ensure we trim ranges across block group boundary"
+
 _require_loop
 _require_xfs_io_command "fiemap"
 
diff --git a/tests/btrfs/216 b/tests/btrfs/216
index 2ed4866887f7..979dcb73f097 100755
--- a/tests/btrfs/216
+++ b/tests/btrfs/216
@@ -6,8 +6,6 @@
 #
 # Test if the show_devname() returns sprout device instead of seed device.
 #
-# Fixed in kernel patch:
-#   btrfs: btrfs_show_devname don't traverse into the seed fsid
 
 . ./common/preamble
 _begin_fstest auto quick seed
@@ -17,6 +15,8 @@ _begin_fstest auto quick seed
 
 # real QA test starts here
 _supported_fs btrfs
+_fixed_by_kernel_commit 4faf55b03823 \
+	"btrfs: don't traverse into the seed devices in show_devname"
 _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index 672ad0ff61f0..b0434834ff65 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -4,10 +4,6 @@
 #
 # FS QA Test 218
 #
-# Regression test for the problem fixed by the patch
-#
-#  btrfs: init device stats for seed devices
-#
 # Make a seed device, add a sprout to it, and then make sure we can still read
 # the device stats for both devices after we remount with the new sprout device.
 #
@@ -22,6 +18,8 @@ _begin_fstest auto quick volume
 
 # Modify as appropriate.
 _supported_fs btrfs
+_fixed_by_kernel_commit 124604eb50f8 \
+	"btrfs: init device stats for seed devices"
 _require_test
 _require_scratch_dev_pool 2
 
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index cfb64a342644..677c162cb63a 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -5,8 +5,6 @@
 # FS QA Test 225
 #
 # Test for seed device-delete on a sprouted FS.
-# Requires kernel patch
-#    b5ddcffa3777  btrfs: fix put of uninitialized kobject after seed device delete
 #
 # Steps:
 #  Create a seed FS. Add a RW device to make it sprout FS and then delete
@@ -30,6 +28,8 @@ _cleanup()
 
 # Modify as appropriate.
 _supported_fs btrfs
+_fixed_by_kernel_commit b5ddcffa3777 \
+	"btrfs: fix put of uninitialized kobject after seed device delete"
 _require_test
 _require_scratch_dev_pool 2
 _require_btrfs_forget_or_module_loadable
diff --git a/tests/btrfs/238 b/tests/btrfs/238
index 57245917e16a..3a711ea7a1a8 100755
--- a/tests/btrfs/238
+++ b/tests/btrfs/238
@@ -6,9 +6,6 @@
 #
 # Check seed device integrity after fstrim on the sprout device.
 #
-#  Kernel bug is fixed by the commit:
-#    btrfs: fix unmountable seed device after fstrim
-
 . ./common/preamble
 _begin_fstest auto quick seed trim
 
@@ -19,6 +16,8 @@ _begin_fstest auto quick seed trim
 
 # Modify as appropriate.
 _supported_fs btrfs
+_fixed_by_kernel_commit 5e753a817b2d \
+	"btrfs: fix unmountable seed device after fstrim"
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_fstrim
 _require_scratch_dev_pool 2
-- 
2.31.1

