Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0F623BBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiKJGXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiKJGXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:23:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F02FC17
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:23:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6Bxx3000533
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=MG1wtysQIrnG9aENP2AOHBiAbGme68HrDH88HkZCSg4=;
 b=JMPvJVFZt9yDcDEKUfDZvQSRjEFkU6+Asj5baN3tlIpUOd2gAbuUXu4T8McJeKjIlXtb
 M/YgqNLlXJLbyCyC4rfgXxEjj/Qu8Iqg6doCpL7jJIdCnUByIHjl4F9VaRnnjLXT/wZq
 eRbPsoMt/LEE2oM4QQLRs+nKoyCcgWC2fckApMMBA16JdxwcIyTxkMRYidEU00/Emfeq
 BRl2H8+ejrH4xl0A/i7vN7BE9w5yGxZa/C4vO+kvSys6h3tN5s0ZEkAQXutxfgEZtaTE
 6b/7L2YEzCtKahCbPW8h3bodzUJKx798rmfEQiAkpCe1dd2Iq4loPhgqdZNu0h031NA4 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krutr80gv-34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:23:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4OHBc017828
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctep7kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUIDLFOYXJ8WYOnE3ZQxYMA6xOTa5W6hjDbfkAyYDyA2O45HtHrClbc90ruoYJ1IThg6J/6EkNS80eoKBk0eOLh+CBhFWXGP2rLWW25auBUwWdPQKhVB91iRyiYT4nvMQvDl+o8rHMDCxt/Q41M4tGHFH0H4BqvPpaOw82fACKc1yzji+LN4Kq7wo5m5mLCjIXFbasS5vmt2q6oLBAILxP/b12O8mSUSiDOZTPxjtUY7xJ5ALjacOBovb7epdKAFlg0mi1ofIxVfUF528JouYswekzAv7YtqYUfFykkHLfKUwm9OaYOD5PQRA+bUobdTmeB/GOen7Y4Xn31pr9oKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG1wtysQIrnG9aENP2AOHBiAbGme68HrDH88HkZCSg4=;
 b=XdB3rTo2TwBcygN7mlo4WxFzmADj4PliXFYGEm0aVUTpiSLK3B/R3cViHOg/X0cK/iCDlNu3MHjvwBAcuqHy7SfTTlTLVBshsqNBeI+hiyfnFLXs+z8fEo0kEsxuPdezs2PKdj7/S1AMGdaz9SRBmfDgeHz3QHKDh13KvSD5Qy1KkOLeDOArqsyM1BejbsAAFGWPJiZyOnkAdjjn22b2fU0iASaC8h3Iv4FJYAj+YqQ62Koo3aQYJyFzS5nB/LXmd6EYBogWFvEpHIp/ECtXYMVoAxNOdRAAndp99u164WhvlGGS6Ma2WyNORydOUcEo6XP7Whz7Ssktju4touAfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG1wtysQIrnG9aENP2AOHBiAbGme68HrDH88HkZCSg4=;
 b=iRTxphknKKSeTvqYvmXgxHYWfUS6VSufCKhlkySka5o8/ymV/Yw8R0jxTezgMll7VCwxpiUPWb3g05GUvt18YmtiesN3sl1JNYysXQOkN7c1xhuI+yZi7yj+lnSnDrY0jJGWzdt4epL0VOprvowgE6wKAvAzrP5kOeY2X483WPs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:06:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:06:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: drop path before copying inodes to userspace
Date:   Thu, 10 Nov 2022 11:36:28 +0530
Message-Id: <514db2d809fa1569d6c409238b98dc5123cb4b3b.1668056532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1668056532.git.anand.jain@oracle.com>
References: <cover.1668056532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 059c03c3-409a-495b-6b74-08dac2e1bf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYInOjBIZb32tRmJoMpvl/evN504AgAS8qkZ55cCSDce73lxKXYqqCZtEIYohj82owXHHvXUKBlk4X49cXG4yTgTQCDGai7/epUXHo6Cy6/aoOY5qI1Lw96STJUIjiVIp+mLGzGXcLPPPz6jyvzq41hOUiwVgtmiFlCVfguxE6hvwldhvJeLAvbTrYnJnmwHnH+JY8GCRDp/0vy+bBUf/AIHhkF32cQ/0uK/7r7BdXJK54BylkQ0Gvvz5hTL0xWk99St53/RNggzpfQOrwypDzDnCGrkBVVTyqayanPrrBFsfb8EmC3syXoQ2fnqpkk9ChAub43PSVOjAoCzWLQSWqWgTkWsb7CpR7xh8MmubrVdPhfaxkqIkjPo56WuPK5RQqRvWSNfmqZbnJvU4jYfetzeTaJRz7R7WkVtmkxVpo5SANO4Prt1AeZNTQLv6bY0q4DbEpPMF4ubIxqgFMXaLIGg6kgAUX6NVQi+AU6NOf65s6v3p3rRySGvqoz6kSsPrRKCs5i0og6ZUXwzo7E7KBKh6a98FIT4M6v+mWM5uiJmAIWXD7y7jlM3SNsrPmKZ6wzW3BL+/DUGjt975CQW3VnNcJ8y7wtq50iXd1S7ok8J1xb/C70LcdeRn2fuS6+ghmxSIDDm80/jjsCdyt87cp5NIqsxiHLzuqjVT8KO3uEbWoBNPF1ZFYZhChDLTTrXhqr98gA+NIt1lcBNJkUjIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(6666004)(6486002)(44832011)(36756003)(6506007)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?peLD+ErapUmTehLRvy9hbrEwAYWJeHhhe+tmC00hS4WgJBmPTworEh59R2Jo?=
 =?us-ascii?Q?d/1AFPi/MU37/o/6Gab6YxQgqgjwQ0PkT+kUYVYFuCEhsZR2nQnk5qq7/vtV?=
 =?us-ascii?Q?oyS8P76YfqwyIm2FbhFu3GAUS0zV9zrSDiZrUHMMWP2QlrN06z0tlDwgm5yV?=
 =?us-ascii?Q?QGYnJhmgAGHkp8anl3EVZxyxe0FJdr4y5apgzVHA3/cui1dEjRyFQR60f7JV?=
 =?us-ascii?Q?QQOTPEnCM2rpEpFtO6nqE77NB5G75LFcOFwkVKODAl9jV47AWhJbEI/EaCEP?=
 =?us-ascii?Q?bp1mwbPsp65J1p0mMUPq1meBr2zLfbcvRn0D8EwhjYUs9O2iWSlnwMqrGy5V?=
 =?us-ascii?Q?KuFiidA62LeDp70xDQB6l5NxaUqjMwiOeNL32Lyv4WXpU1C3y70AAeXgyQu5?=
 =?us-ascii?Q?DsCOO7QChFUdvietue23l7L/Ouz5ep6JmPNyczgKHQ3etxz8jmlwy54sveMV?=
 =?us-ascii?Q?BeYMSs1f3+mJPv+9zcvjmRpGZAoMCQSeC7YlyeQ0U1GRjGdx3ISWBChHFlC1?=
 =?us-ascii?Q?FovSZrwS6sfCQtP4x5xvgwxv6c5USV26xAgvzA5ISIynqxMFpM3EdCui6UY5?=
 =?us-ascii?Q?DPbrkw/GkUkPjsEEB5iJUBmwdnzD6v9xRUszLb8wneb/ih3bxbbLXJmMQDtD?=
 =?us-ascii?Q?ZZfS+clH3SinadOg8QFF2U/Hkn+OhahUbuCSSJY2pO70YyvtvxFYFbGJwIi3?=
 =?us-ascii?Q?b5uazZNTVN5rg/sYkW6ME64s9TEHaWJF33/SEbaeNuieSQfhj9ur8f1WhAHM?=
 =?us-ascii?Q?6bd9YP72OJzHc4gePYvlgOgC1q4QkqMOIFrfDGs3PEPCZaLhYLHris9rBBwD?=
 =?us-ascii?Q?/rNwQPJti8foQeaitPoCpoeYE5YoP/PrqnnUg+h4CkOXCsIfkcqeuuB6UtAL?=
 =?us-ascii?Q?XN1b53MY9z0/E1fhviu2s36CDMlp7yBqmV05z2GlwfKI39W+2EODnzAtriqe?=
 =?us-ascii?Q?FVcquHa93tNnaRfHgggHKyGMMV0aJizDYnBzyNmJm52XWoH1xRKudISpSVYz?=
 =?us-ascii?Q?8iDwkYGjJhCX7Sfi8d0pnc+CDjQJQcu17O8crHtYloEROvj7LUis3Kklyx98?=
 =?us-ascii?Q?ZRPRuJy1ziMsP0PoFfqLVmMCiDDWk49q0+U8bOCB7ahMR4WGxgLqu5f2w1Qx?=
 =?us-ascii?Q?X1OLXfZTn09ap1olmAFxcIduJcCohMWJ1d8NvEi3DEOviiwEzy/s8zDNJM5m?=
 =?us-ascii?Q?x2eEcsDnKz25CbnbcGNbzcxr/NNpb77QZtA5tA2qtm+Li1Nr2wV9wS21Ewo3?=
 =?us-ascii?Q?o9c6kgXTh/g204QaPm1TCxJV9+h64uNGaEh2Lu2Oj6vzoY5Qd5GvCxYrH695?=
 =?us-ascii?Q?fbUjBhK5jr6FK1I64GGPZhSGm2GfG6wdpdQRUP+UA9iJ3NDQ02JNjPymamiE?=
 =?us-ascii?Q?fL9J6oeGAKJMMWrDKAGsbf/rxu3CaBaBkSictUw8d3h2y5kaSpXk0wCWLTYD?=
 =?us-ascii?Q?5YeL1uh6zhOv6hTQ061Y+CF9aemeIRZFq0+sBqNxF8miTPy27q5U/B5U5s6x?=
 =?us-ascii?Q?I+wrcMbnfgJPEXqJ6WNTsZMArLt351f2g00Q+mHDFn5LxQohEexhf+ALcKHu?=
 =?us-ascii?Q?JjuN4y6C/V6NfthnPFeHUdpOlHxzEm3ffKuz6tcd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059c03c3-409a-495b-6b74-08dac2e1bf0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:06:45.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01+/N2TyaZvG4l/NnYmlZQvIJPT32lO3ggk0T2GjGjc9e+pwEBrEkD7N8H9IZ9sSf7u5I9dOsdh+fCITXxTXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-GUID: -MPO4bmsJcqIjFT6hCUOnDYhAp3USrpm
X-Proofpoint-ORIG-GUID: -MPO4bmsJcqIjFT6hCUOnDYhAp3USrpm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl_logical_to_ino() frees the search path after the userspace
copy from the temp buffer %inodes. Which potentially can lead to a lock
splat.

Fix this by freeing the path before we copy %inodes to userspace.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a64a71d882dc..76198c7203f1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3391,21 +3391,20 @@ static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 		size = min_t(u32, loi->size, SZ_16M);
 	}
 
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	inodes = init_data_container(size);
 	if (IS_ERR(inodes)) {
 		ret = PTR_ERR(inodes);
-		inodes = NULL;
-		goto out;
+		goto out_loi;
 	}
 
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	ret = iterate_inodes_from_logical(loi->logical, fs_info, path,
 					  inodes, ignore_offset);
+	btrfs_free_path(path);
 	if (ret == -EINVAL)
 		ret = -ENOENT;
 	if (ret < 0)
@@ -3417,7 +3416,6 @@ static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 		ret = -EFAULT;
 
 out:
-	btrfs_free_path(path);
 	kvfree(inodes);
 out_loi:
 	kfree(loi);
-- 
2.31.1

