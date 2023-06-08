Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D37276FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjFHGCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGCA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:02:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC410FB
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357NRKiY018013
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=RMZAREKSvEDI5pxcXS1k9S4YwPL1ght3d5y4fGz5kfo=;
 b=NKPBvDqPWxK/qrOIeehx6hV++sD/+zRrKCJJ29+mFuZmzS08KI3rnlHx9D2lnvQwg/s4
 /H4caQrLldL6qzlQyRe7C7oot3xFiiR+f/ZKeCL4bd+63sDqONpeagsF2o+A5kJopCPn
 IoEN8nsT85vKu4Q4KohZGtS8FmWMJzwxe6I0IkKRSGDoS4pcJbU8ntIb81NPYrrakVqv
 KosoX1c9a7uO29glrCCgUEVsmvwj8ZEnaCoc3MsZPHLyLg7dRxQqAnkuZTbHcl2guzez
 JrSb+35zF1B+KhMUM3EXBQ+VCCxX8FKIP94oo/eAMURt/LSPOolqiiTBFINfAqYlK04E gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ubcdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3585hjbQ036628
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kntkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKuvVR1HtzzREJhOXc37kl2vY+BB0YsZe3XnyDEvvOX1+M+TESlzN1HtxgsH7iawz7t7hqK/tgnp8tCgYuclUwRFEHKDLleBALHeoraXWQN44cllEWtdr5YNT9+pagoB0YD18O9jcACKxrE+OZz1Lfa7uclrMZgaidbWJiyvs9N2AKg1KGXzvtr3VFLssxnXa0k9VulrENaneUJpo3IwzJmoXyYvWJmckxMQqFtvSk/fI0dURQC/r9hdMy/LtnEtQqSU19ulVjzTQuhOEv2kCLJFdR9ZeWu7y/obZIvSzJhUlwxigR0H+TPQ578OXdgt53vbIKRs5BJhaiSD01TsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMZAREKSvEDI5pxcXS1k9S4YwPL1ght3d5y4fGz5kfo=;
 b=GKFrbNgBk85m39kz8Ly59sh51wc9EGGPQl9JIX+q+MKZXwGvrKZ4oS7o2EeWXlp2TzD2HrHWqsfomf/HFRzz6vryDBgJ//8ZWXJUDgRkzSEmvZipYdLhsclEeYs61pfy8luKDv2HXNYFkt3TrMU6Xw4RsaDJQNYhdNZXB2WAJMKOUPVKYh4zZVreODHCvEWXBE/s/uLkjo61QpdmZTapxEodKSmPO80TY2vjRhvKyd4fMcLze+bpzMGv7ize2STFmquIKtksKye1RzKsJf1ttyxVWpAzVVcDL9WUSYXfC9IqwH8IqkMKov6PLSYY36C739ua59PPRTPRQQodskfLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMZAREKSvEDI5pxcXS1k9S4YwPL1ght3d5y4fGz5kfo=;
 b=t7q6eXBCgDXVqvw795Jz8MHLrt3BAxQDjnwansRbKT8NS1L1hL7fDd+tSJyZi4w0+2ZPIRGOYqjy0DSERRKV+Uoq+ld/xgTUnwlSRHy4ehiiS1fQgZE2J+iDOifUWRmfSJuu0+AIhDdLFnDmNe5Jk5rmy+/myY9F6TpH3QaOYDI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 5/7] btrfs-progs: btrfs_scan_one_device: drop local variable ret
Date:   Thu,  8 Jun 2023 14:01:02 +0800
Message-Id: <718713677855382e44cb57d1ad590063ca20d8f7.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c66d07b-b0e3-4e5b-cbf2-08db67e5dcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMZpUPp29Nxt9QzVhh+x3TnnLxOdzyWIJA5VQE0D2gXyKrQ29isEwocKgetRwOBbELPabFt9JXcgAV+hM9gldXSZNZzpcjWhwP74AcIhGnjxv91PM637MWjQ/lGO8PozZ0W2r5NDui+KULVd25fN/XQCrvcAlZT6pBwgj1sp+A6Y4tkwrOUBLiCW00eaxG4O86ebg9MiyUDloGrL8eiSvKu0nxzK2/UOMWNcNaFsvwA2KHmrNc/IkE9Stnvl2wjAWKk83H8XJr8rEtvLleS6mf7y5PDFDzeU45XP3/gD/6cz/4XuVdkkbC0r/k03wHyZbQvE7zfzoe0LeRT4RG/YdjAvS1A2WfupQK4mOS/S5mFC0qcLxdD/hdG90zWAMrC5C0xAIU1w6yAPzyiwACU9IYB2rxZxlwOg7/oIMOjI60I5uuMA5Y9iow9gA9/hl2KlXnOxuDOFvtPLegDDTVRzvxwUf4jX5PrTbYipVscNsqC5p7X0m/1uh9vAgFe/ix3vR4ZXSAI9rwZ6kUdaPw3I8wHclJuJOLIRdD2o52EnOxkqx6fissc7ZfaEIS+52O2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNLRlz1fxve91JcKQ+Bk6HM4syzRR7Gj8rbq5oyvuKEKNU5yDz6+9HLzXlZR?=
 =?us-ascii?Q?AsdH/g9/hFgGXT+J3WqBQ6XtQ7yc25JSKxRhAcqVRRcV/jb6QDY8NKL1YIYs?=
 =?us-ascii?Q?KC66U5LIn1L1vFDy+aYSSLn4OiFTf8vmxkmTOEcwzP7pXDxquuawTK7TVND1?=
 =?us-ascii?Q?jDdBS0OP+VQd+257AZX9Tvz7ENVt/dzllcC1RT15aMp5wfGolYp2KqC7oEdy?=
 =?us-ascii?Q?2QHouQo6DLqXAnvsxh9WBzeWIm9tzBcSvDESyt3jWcqlaAe1BKOqC+V3t1/7?=
 =?us-ascii?Q?HUhcLHFNUahnKdkcPMg0J7RtpxobgBWgLEfWhE/cgKvn3RCILhZzdPhbyiYm?=
 =?us-ascii?Q?c41BSwG9Ah8I1uZrg/n9xmb81244kn5I8vGXAtJonqGs3X56FxmasahU6OYp?=
 =?us-ascii?Q?b/HQ628OCKYNaeBO7uJnzRYotttD5bOVpSa5GaZdobBDPXUl53kYmxmW53+s?=
 =?us-ascii?Q?7dWQOooxyJpEOjI773Wkv83yBcNpm17E9k3BFt1TTERxNgmX6uN+ewgpsouW?=
 =?us-ascii?Q?co+KxvsfTJdj63ajlYtgbRkGcNGwan//V46m6/qqkRWWzJ4u5Kh2eIkQHxTK?=
 =?us-ascii?Q?OMjD4qYbKHYDC2pJbZs1z0SjJhdTXs98uQYy8rZTy5hQhno+Eb0sIcs5nyC+?=
 =?us-ascii?Q?Ho+rRfSlyjI08dSmIuPGf7yGG5wWZe6qmL17b+X6O/hS11BGtEU+hrURVCyD?=
 =?us-ascii?Q?Domt7IhGUWmHME1vVJOF0KBTs7clVSAVc2m3dMonKeyoy9PLusqRZrIp/4rx?=
 =?us-ascii?Q?kczXUCiYczbjwYUBZpCKTMeO1QZAYQ18XhlZNttGtzWnHdzOp6yQNzaID8mR?=
 =?us-ascii?Q?mDC6val8FDzPhPLZJtc6o/Uucm+U/A82Kp5GdVrGB0dJRzR5vaahOHhRcj5x?=
 =?us-ascii?Q?lwoUF/ji/3T5H324wBYdR2be4GShv69VlbmdJ3EgQGrfdZOSkmKS14+0dpFD?=
 =?us-ascii?Q?SfF9RtXHPYPElBATh1M9ro5hccoQbC6yYTCcCtGibXLbEHVCSUhibdi9Rujv?=
 =?us-ascii?Q?uu7zPIZfxnbto3W8fM4QQz3mXlmyi55P8rwjQKsw/V6POPUkGOQFwErWJHSb?=
 =?us-ascii?Q?PyE0rqhFKbmGM9Ah9y50gLHXA+4sC/yb7Ud+s0dfJcobRSotZvcJygCVmzSZ?=
 =?us-ascii?Q?UBdYkpsFAxM6yW4PyxzrYEhAp8fT4JHyNXK7cuQEHobIWZQkiuLoD5eY5Vus?=
 =?us-ascii?Q?clvrbnpsXt2HZ+GX8pUhUcPaM32rQL0v8a4IqfAjsQylMDMSEUMNZSch3zG/?=
 =?us-ascii?Q?hTT6J31xbRiiTM5QCWKiTMEuEhTxYAagXtigUhhKUGNf0s9lPbJN5NQSOH16?=
 =?us-ascii?Q?oPSDhBt4NZtpjyUr3V1P8uDbUzh2edCJW97hgmU2N0zSHDUPma6v64Zt5p5C?=
 =?us-ascii?Q?Hp2814kvAXOeTQei3kjdgsHxhjTXhc18VgNZsAAYwNl6IEM+fJWY5pAp9e2b?=
 =?us-ascii?Q?P81DHrK6Z9WwI92PJDmtD0KUcrB2hEYegYG1WelXMeE+E7BgroKH07ZpONmt?=
 =?us-ascii?Q?RYqgPGMP24SKIyWrmQenZUgeURu4FLog2EX7zBYADOGBNYoV4Bogu6cUeRa5?=
 =?us-ascii?Q?3IHskX4rOZMeiqhKVkEB6ex5ABxgWq6PrzOYFu0Uu//ZPY5bQX1voe5q8cZp?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YIiIBc14/PHO38REkKTizGi1iAnTu3Q679LoPXK7sDdq+Q38v6l8n3kt3GqFjnjRamUJAF9yrKVkzmYxYhfcXOn+WlgtMbMn6HA+R8Y9DzTaoXW860ec7ozr/0Pcm1ARbicJzcOnQk1W+6RzHadpPBN7U+NajYNgB32gsF+jnzunT5ybxL00hDUHNgUPwyLS2grqA0YxCjXkw5cl0CW08n+y+onCpra3r+ff1Va/wRIOS77Y2+LacM3RXh7X0HoEcTTobkbPqV+Xg2ps/UA7GZGmdDbe6Y7XbkFAWNnRg/phYRnikqbVqxGPv5txbCj+f486P1zgscUwjEaLHU4nMiJPerQZKFt5BKG8rqa3NxKn2kOimhOK5Nbje1lmoXnK0eKrl1JQKiuuz3ItprVlxBf+JplQ0FBRZ8+DTFhvr1o8c+2Uh0RW360ZPc9YAI2YSOL1+1d5WSBV+x2mw25UlAJchX4Op0ksW4pO2Zi4kOxkmDCG7ZDAek9ZDldHf9qZ+s62KDovekjONouEeACX2a1Bk0N/342V6yUhvel8GT1f4lkNViRaeFgT9bVNM/st7aY0L7PpFY8mBykxUvnfpNrJvRcUO8T+ZPtuwmBvzK94tCyXw/dd1MF3ZMkBpq+v7myk1dGVl/ZPpVrSbc/Gql3sXz624KF019cQXFN7pFKy+0aKGgY75QyoWp2/Nffmzn66yGcHSKKv+8GFt3aRFzCpns1x2wAKTuD/G1e0EqDJlDaaUOcExOl7EBefXSDF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c66d07b-b0e3-4e5b-cbf2-08db67e5dcb4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:55.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpRkDf+ECM82+NqI3+6GC57FvkUtKUr7FIDv5O7MmUqYLTlfleoDI5SS0B6Vtth10HQn2Hq+IMceAqZhiWJHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-GUID: 7R8liW7InY1jS-SPsaeTYyLap3nIx1tb
X-Proofpoint-ORIG-GUID: 7R8liW7InY1jS-SPsaeTYyLap3nIx1tb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Local variable int ret is unnecessary, drop it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 81abda3f7d1c..c8053ae1c7f7 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -545,10 +545,8 @@ int btrfs_scan_one_device(int fd, const char *path,
 			  u64 *total_devs, u64 super_offset, unsigned sbflags)
 {
 	struct btrfs_super_block disk_super;
-	int ret;
 
-	ret = btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
-	if (ret < 0)
+	if (btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags) < 0)
 		return -EIO;
 
 	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
@@ -556,9 +554,7 @@ int btrfs_scan_one_device(int fd, const char *path,
 	else
 		*total_devs = btrfs_super_num_devices(&disk_super);
 
-	ret = device_list_add(path, &disk_super, fs_devices_ret);
-
-	return ret;
+	return device_list_add(path, &disk_super, fs_devices_ret);
 }
 
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
-- 
2.38.1

