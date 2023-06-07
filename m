Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C8725B29
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjFGJ7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbjFGJ7s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 05:59:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA71735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 02:59:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JfRA019371
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TW2KEPod79CzbTDIsxjXaCnIbBaKv6V/w79mKVQsy1U=;
 b=U1X3zLOfEEdRkWy/siGuy2VTBHPQjukmEJU+LRJjjx0aNlaKnI/5gZQk95dRPH3Lyvpk
 7SL0eqwlbKd6DAHUu8oVGF2ahNSq2yBx4qScFFcOobyHU3JJUhNWbhI3KqfQzSEgs4J2
 ozfrkyGLR7PF6D7ROtkzYp5vUTVOOVx15LzKBlDWVKc3CNKTIEJK78wTvtN/+WuwsxGk
 n6H8M2H8de/vjO+P04POVHTXhxRsSef+tWRRUgd9j8ajLC2B8KosfHMcUV17BBwA2UXo
 eo8R5DHuSEpY9RSEKyVaByTKyyZtB/zOdpjsQcVvAYGytZWtGz2fmElSjHgt0atcNtNz CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6shd44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579QbVd036794
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 09:59:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6jh6n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 09:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExnDwW+YD2q22CzKCGyBB9I8U4s5eSIqdMKS9TF8Khnxxnmck1+PVekwQIFHxXDzEuLJneavpMVfwWoaCfbWwe7iqNjLv+KqE7qFi5ItkfUD45IbdiYVvbPMFem1MDeADneO20moEw9V5EbHL00dYh0RczeJEPJvAWEQePzvRs7y4LIagp+h2wmAPl+XJ0Pwdl0nfBLu3zyKLwVtzEpPUMwfcAZZMV0QEoG3k0i/5IM/hxy2Pd3oPeJY86C1uAm3xd50nDTxGnw0l7hDO8089IXrY8X4mSXw0s8PEuDYYCb1nMQE727JB4Oowj3WqyQnpC+M4UHu86k7ois0uYIEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW2KEPod79CzbTDIsxjXaCnIbBaKv6V/w79mKVQsy1U=;
 b=CI6pzLbRsC7Vwn5bMcykc4o605LN7S9JYBNs2dfhQFUdWJgCKlSL8IG8tOMhjE1OZrzzWm9U1MHotCuz4vwcoqLuswpBmkrTbC1Ou5Tc9HVdhs9nHR/E+ZQJiGwgCd6JzZskaFX27yso4aemeL51xaVYKwn1sZYRrPIcaOJkVG7PYJ1CbwyvYZJz5I9vN6wI6jDJ8qblBnHnhck9fobt8INm8ChjP+kyMziRo2xl/CB+1rhO4CdBcfaRnZnJk0Mt4vmFz+/FXHRZmalNpUwofjR61/N/abGv3tgp99GGHiwbbYlc0mkf08WfTM5Oc0ppyvCKgrpOItBKJDjrGgtaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW2KEPod79CzbTDIsxjXaCnIbBaKv6V/w79mKVQsy1U=;
 b=xHMFmL2idYxDUQwzfXWKXuq4sALW/fehRvs31kNWUMJ3RSjeshYZPpmWdH2HMfcFkEsNcZ4dQK23KjNRkOH5JZPE/Q+uebI+wXXiRIuHdIy0vGXcVWiqpxIbmsip9HWGBpxik6qI7IEHjz3pbtqOIx0Bc2XfeirkNhguULpIHPw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:59:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:59:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and cleanup
Date:   Wed,  7 Jun 2023 17:59:05 +0800
Message-Id: <cover.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: d23a1e5f-8ea2-4076-5878-08db673de679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dI/QanU+NOIm9pHD4ZEHrwQ4EOlXLQwtj/EKCjLxanaGEk4yHotSa+zSo9dX6A4aD7LV+DStCg/xRBMnpMU6+dJRiBc9vgqcqri+p8DyAlNm+WgdlmQIyba7r4OY0ps6ITYNutEan45ebnYUMKdeOqzB/T1vJyb+KUC56y/qd56M8VAkarlp6QeObJ19avXVjRWWouIjKfMt8MjdP8qYaUCcrmx8Z1ATfALseipCKIHO07+9BG5JVcSNeTPkN8FhEVMOsGTpA7HJQLFUziiJ2UeW49xZ4yuzSyyOyH5Obx9/sE5YSeJG/T9in105A3jbIG7rGsA9TRU1YJew6u7xP41gjTvDudCsxiqT6BzDIYt3ZQhSzzXxaLdf/b3kZTeTRw7m4wAWKLpCzr+I2CxNii2Qe8eO/CgUfp38RcbKAtuHHuqBu0qsmLhXG6UD4eC2t25Zw5QKWxMyJWnq4pmwI5hRRcz3NCIXyxErPSQ0LGPb6lKwBOf7DMQA24cIMgbeXmWe8P44H9EKFFpsLNxIBc6aO61qn5D5Op2xeeC2902IGp6zYawWaMN9LpvTo1q8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZCOlf60KXiRQP/riX6SZadx1AsCg6BHPUphLN6rjkRTz34+6HFDm1IP8UB+?=
 =?us-ascii?Q?OttgOi24awEVpHJWQjWexesbad8AMScHNZy0fBcslRUawCF88+J+HM7oHsc2?=
 =?us-ascii?Q?r/b6eLe4bw2nS6Y9+WpftKhT7n7t7VhTSyrdaCHC9KhL6ALfdh4LD2jH2mNp?=
 =?us-ascii?Q?qyfE/uptg3IF7HgReyBNqghEl/lVbF8WR523DFdn/+D3ao1wycBpjxvBuqG/?=
 =?us-ascii?Q?wD9qpTr01ssWbinl6DI0XVJIzBGIdmx2wQhqi1vvr8qYerhy+JM5WcxcctgL?=
 =?us-ascii?Q?+CiUVPoBh2W3eujwZbdVjuR1LjD+dgUs5ajRIshyzzHdF6SuEGfz63rPlsbH?=
 =?us-ascii?Q?pR+pQ0bFBOxLqHJ5TnM0mpkLNs6RQTouA3JPvGFkYQnSPQ+nG/DemYcCAgGH?=
 =?us-ascii?Q?aPRHjHlzC9nVps4l2MOR6me/ofmzoeLUlHklI/n5aulEeyAi9nMYAHA+QHF7?=
 =?us-ascii?Q?gmaM1SBA+Gi4Qu2ch/Ljwsa/FgA+8ZFAvSH9iR1EBtsH/0kO/HpQNzcU+KOJ?=
 =?us-ascii?Q?AM6/0pLGkuk2QQvw3lMiTDQhwzLY6qJTbLYr+vysoV5Sz6eqRaRiv8Vclj5C?=
 =?us-ascii?Q?yPWYmL2SJ4MOiKVaqkKTawnlwGOvEw8JIHkFpZus/ciBZwI1EZ4VHPY3ikFA?=
 =?us-ascii?Q?1MndsFkzdXLEwGJz1b9vGyyb6mt7xSwmZ+9Qp/PtAXDDQPRTisrFUMDtxNuq?=
 =?us-ascii?Q?TD/ylMNxs90Af9Jd+bIJPNqIej/q8WWk6WZLS6kAAKRunJjaKJ2qcNW750eU?=
 =?us-ascii?Q?+JB/RzeOiV8o43WCJhup3ahs9oqxTxsQpluuBuBGPcc5hhNTDImY39TGWO1F?=
 =?us-ascii?Q?GqlZy8BX0WKjnaaDcgMnGa8N5K9GE1yzbsjnz+/P6/yvqKG3nIDxUNN1G1VG?=
 =?us-ascii?Q?YpEAAc62c8mxiW25O3tDGWjCarYk/in7UPWXotblUgD/Og33vlwGZnabyjW9?=
 =?us-ascii?Q?qfo6DggfOScXwVQuyHx18IPnNZdv+690hZEcEG1Imx0DMOZKB0+o3fp+NlkQ?=
 =?us-ascii?Q?XauJPfWZvnwivCH22Wi/px9GLx9dHfEI/bKlj+r1xsugsh4/0hgleCLIgokD?=
 =?us-ascii?Q?oIPln4Khr8UknAcmOclZKFJUCTnLrfjF/R4lmP/izQHOyK0yBiysZjceM1jj?=
 =?us-ascii?Q?C8FC2Lc84Z0/4XjAVjIXmTmVHdzFw1tKOHeTTQD87KMkZbcMN+cuuv4pohOY?=
 =?us-ascii?Q?xS6QtoXmP2vRtKx/ckJcontaW0kJfvy/Z3ZrbnBQ8bM8xCN8uL3ubqVUVEOO?=
 =?us-ascii?Q?jw1IXwYAAZmJmCLY0OvmHBOtTILbwrsYR4EMXfLPEryyq0dbNDyXmkA5J9Uf?=
 =?us-ascii?Q?4Q/Atkv9/IJWvguzUw9TuaLPBWZkskxh8ndnVgxxA5td3EROgC7WtFJUKI49?=
 =?us-ascii?Q?IuzeSzmsTrnZ4OBvA1FuowNUgM7xC3j6IFGljxspk3KRGbE+SHZzejiGURJa?=
 =?us-ascii?Q?qKzC5CyGZJ8dovq4LPY2msMj2Cdoi20o3YPU9a1YY5J7WRf6AfRTPUc4IVr6?=
 =?us-ascii?Q?yHjLJfldyjRJTkkuW4VNxFtWgi3YZRNHWFjFMncDUwfFkTgrPiVtG6exEcRP?=
 =?us-ascii?Q?wrWqeqf3UazP3mR1iNJtf7iK44s04bf8d7xppGjb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JQ9K4RC6k2gnUYVwCrq8Anh+BWey6fr0WNUzIcmDqDJ0IBz6w2nescZcDHE2qlviyiMN2N8K+KV6tdBjVG35Cd9uTSXPY7C//J+JBFIijsoYrj1GKwH7iTo1wnmRIrSFod/iT1D3lLh/VB3pHQavszp/GEOvJ2TBj0RUCWJVTrzU/0FGpRwDnZYYz11UEuZWwSg1sS0zx9qfGSPkqFtw4hrVZMukD+mdFrHKnm1RkTpYaJV8Vpqh64iOgfUtke09KbSkQShD3cZd+tqESGcnCm7cKOBGOGRMvLq966ZevUprXAiJOnwYOa19aoEpCdbA5ZhYGNANcGLkthJrvVPM3Y73yrxXNiSdZtd3Oam58maxNgA1Eu9MEwDRkM9eE7+gnnQ0vwFL1Z9rumS0k5f/Q/jYhpor/7+yeTryi8gHFkkbHTFt0LqG0K4X+KtxHFqd0bHhSGPhepfvmp7lISIBdTJi0vZgfuoITrVb4QcJtUrV9f/7OakXSJ/abAAT6OOuvz/p+s5jkkA4PGlsz1oexkHykD3HU136iHJi9Vhjsry+H7Z+AMICYllCrZosPmuSVWrR8wu2paC7hL2PrXj3UiHZmGxtekua5oEuSTzVqOFq2s4I0a4GISFb7N34ErgXm6UqPpcVztr8kYpziC88n4AHVc3sM5tzy4YbTOGF/1s/IFetgqQMJY5LTLZm+N5dIZPNu9QwdDuWBDB8WLyQHn8b4tSwxcNEXZzGhJcOAeM2NQvw/0SKbNGXMfP3i88d
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a1e5f-8ea2-4076-5878-08db673de679
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:59:36.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2o4St9GjxEsDW6k09UM0P/FC+FYcsRHaID04g80piI/C3Ae5bQjfY3AT0jm09vswAm10bP1U5Vuh7SdffqNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: bV1ouzsOqgvpYr9Fw_IAcLmP3hrgoZKT
X-Proofpoint-ORIG-GUID: bV1ouzsOqgvpYr9Fw_IAcLmP3hrgoZKT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In an attempt to enable btrfstune to accept multiple devices from the
command line, this patch includes some cleanup around the related code
and functions.

Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
preparatory changes. Patch 7 enables btrfstune to accept multiple
devices. Patch 9 ensures that btrfstune no longer automatically uses the
system block devices when --noscan option is specified.
Patches 10 and 11 are help and documentation part.

Anand Jain (11):
  btrfs-progs: check_mounted_where declare is_btrfs as bool
  btrfs-progs: check_mounted_where pack varibles type by size
  btrfs-progs: rename struct open_ctree_flags to open_ctree_args
  btrfs-progs: optimize device_list_add
  btrfs-progs: simplify btrfs_scan_one_device()
  btrfs-progs: factor out btrfs_scan_stdin_devices
  btrfs-progs: tune: add stdin device list
  btrfs-progs: refactor check_where_mounted with noscan option
  btrfs-progs: tune: add noscan option
  btrfs-progs: tune: add help for multiple devices and noscan option
  btrfs-progs: Documentation: update btrfstune --noscan option

 Documentation/btrfstune.rst |  4 ++++
 btrfs-find-root.c           |  2 +-
 check/main.c                |  2 +-
 cmds/filesystem.c           |  2 +-
 cmds/inspect-dump-tree.c    | 39 ++++---------------------------------
 cmds/rescue.c               |  4 ++--
 cmds/restore.c              |  2 +-
 common/device-scan.c        | 39 +++++++++++++++++++++++++++++++++++++
 common/device-scan.h        |  1 +
 common/open-utils.c         | 21 +++++++++++---------
 common/open-utils.h         |  3 ++-
 common/utils.c              |  3 ++-
 image/main.c                |  4 ++--
 kernel-shared/disk-io.c     |  8 ++++----
 kernel-shared/disk-io.h     |  4 ++--
 kernel-shared/volumes.c     | 14 +++++--------
 mkfs/main.c                 |  2 +-
 tune/main.c                 | 25 +++++++++++++++++++-----
 18 files changed, 104 insertions(+), 75 deletions(-)

-- 
2.31.1

