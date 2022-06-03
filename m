Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4953C260
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbiFCBml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 21:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiFCBmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 21:42:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9A14D1E
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 18:42:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252Ji2jZ011394
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=d6FQgeTpMBKOBN+rOUf5JNeHVRhx7Foz+ZdTiW6ZlkU=;
 b=eOZGjxqcNc8yfYp3am/WTtbXui8iWNSDl4wRCendB8l4e/Jy/Z/FnLQugMMOpxSxrQFm
 e5dRi57j6VRizrV+fBaS1UK+fr+nr21VfFQGave4ywyp+ZjZlETPCygGb+F6Otdlm4f3
 trzxmX91qP1k9M52JZVXYXo3UWC6HenqRHziGU2LiywlbXmhZfK9TNLVK/o6idw1swfg
 Afa86y3zf/+mXhpDu7EOIp3ee69pQ61B/qpmWZFhZ70/9Y9O8uZ782Z6tlDyO0p1yGsV
 pTMzpygqzbQDGmPQPMFMBvGEI+WXmtXDxa4GGOj4SnnplnouH3pD7Wo3qfKzZRetx95h aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6xbt76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2531ew89033620
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kn79ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IruSlwgWMM9nz17oXUZZj5jUOhFPiTuRaSLcOdemtCojb8Fpdq5QCzV6tX1ztbvejL+u3KI2rIZg5S7zYtwJLyZQnDyMvlS181cH7fO/Wfyck8tJlEpaO7PD8KOGtIiXjkwsmRUJaqKVO3OXimrP1vZp0/YbF9wNF0+VPbUvzBinm78luu/3/2q3vFSoOCBThqxXJrzJe0BgH041zQ1K1VUGnxQMlVJeT5Zqnririm++IXm40loYTyKacPipUP5hf/Ot46Tr4ftn/AytbukYPocdxH9kGYkvHryRS/tDE2rwzQgWHZczatOpXIr70gd7VKIjNL/kyvX4iBRA8j5ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6FQgeTpMBKOBN+rOUf5JNeHVRhx7Foz+ZdTiW6ZlkU=;
 b=VnU4bqO/Q6+0KK8jMCjD4f+px8IxYS8aK0LVVOrDGvzGg4PFK+jn6VlD3qPlvDLRo0jrw+IDZFkc43ngz0ED2QFrFeB3fVY+gKBbfDOjLNknMMH1wXkqHgXQpn9ZrgWgHqwMIKGUM/kkHneunAd3g48YL1kYWJiBJkeO9B4Zg//S2ABirXb02j9HPRP4bZ6M6RGCTIaAc/cYaHzlBzqP2lcoFkN2BQ8XrfUOT0gsNlbOfmyzglu+U0k0ZvJlJ8dD519pLOI2VB2D+SUkVUWRoYFSCPc1S9wMSWCpjn0tRBbnvXg2mJ+iYONhqw5JoZ/4EWJSKIkwaINqHaLmrcJZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6FQgeTpMBKOBN+rOUf5JNeHVRhx7Foz+ZdTiW6ZlkU=;
 b=M1mL5FZb3yUI4uken0jAQaSUIjMjDrkR9IxKcLC/czyhU8pKLoRzI8fzMjBGGIFsFraDB//pB/rGV1R+AxBExKt5FUwSuSVoxZ8oaAQ+TuC/gu5mEhSWKQyzcBNyb4BzY1wpXCHI93dGWOKvH+Xo5K/7qs46pYmxApI9Qu9xvHg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1530.namprd10.prod.outlook.com (2603:10b6:3:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 01:42:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 01:42:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RESEND PATCH 1/3] btrfs: wrap rdonly check into btrfs_fs_is_rdonly
Date:   Fri,  3 Jun 2022 07:12:09 +0530
Message-Id: <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1654216941.git.anand.jain@oracle.com>
References: <cover.1654216941.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f5cb2b-eef5-49f4-6585-08da4502521e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1530:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB153058FD45B3C98D1B425CF5E5A19@DM5PR10MB1530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etz75dSovW+g7L0MgPpvp3T/gLPV5KF3FZaJIRIWTvHH93ibtYopBxAFC+mtEQO1lMYynOCnuvzyK0o03X+V4D6qWgMv6WhdQ4I/3ja9r18WMr2RkzEtdovUrJXV7YM/G8FYDqIdMTIAzNaTP6zhUwwuuWBPnW6olZ7FQCqQEfJ6XkwEc0weNGYOQbf5gXihWvC/QEdN6/AaiBVJtGkdTu1ZJm7y1XcwU2CLMN+kTZHVIZJOsQrbrYubXRapwq60uxZpgLFGh1oN2M7n8bam7019Kl4kgV8u/OHWIsoJy9pntmSJmngUyCeURZAJAINXG3Jz0WNm+ghT0ZrL/dGiGAccZJ8rJDZ8M8pbDA9LwYOMMVBTXSSKwj8wLYoxzy0F+RWq9XxKMT08K1pouEotEZ2tpZxfrihXhmuZQktj25+o3PmaH6mYShi0Akwm71rOMnNLnUXoqsy8pz4uDeL3BKTn2OJIruDzCKjHqhKakjJgiV/jXv3VBjENgznKmm7nxqBjpnLWPxclv5CfV5ubF/utH7HzGzqGPHQqojIcsejve/cm3FN6ux9saisUayCCza3wB7mMlFBtU7cLhnF8+M4SNfNfOsVKhueuu+rdGQ302+Q3h4Bxbp0OVPv/3G4FjbtmxZEzrZoL3AfpR866uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(26005)(66946007)(66476007)(36756003)(8676002)(186003)(316002)(66556008)(508600001)(6506007)(2906002)(86362001)(6512007)(44832011)(30864003)(6666004)(38100700002)(8936002)(6486002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGQU5WCNXE92iZu5SjUqYtZFOC3emu8UD0xDUIzp6KLV54qGTQiJkVLsQyyU?=
 =?us-ascii?Q?i/szJGSLJh9bLS0bcWN65nvpb+WhkOkckUYx4yexnkJVflxJWWdEf1AGPkZU?=
 =?us-ascii?Q?K8bba3Bzf58/cKkoufz0os0eBLy31PhMt7VvGg8kzqrCQtru/KpFkxmTethF?=
 =?us-ascii?Q?/h2G6zWdVwpa/TB2iG/gpUFoKFnEeX2Yy5jAAxGnVlI/w22OjMasYv+LSgQV?=
 =?us-ascii?Q?eVtNCZW/cWEnxjJjr16Pw0UIiyAVW7a7roFHl0UrWiuXJ2h3DwkxiUEVRFC5?=
 =?us-ascii?Q?J3uNxnS5dZXFBTnvooOnoIgzYc8chAWebRfkKnKRGFCii0afIG+ZJbQ+h1My?=
 =?us-ascii?Q?jl9ReobYxldzwNHTIk3wulkDldn6wlZLr6vw4nl2HVWz/Pyk31SQfMkEYDJL?=
 =?us-ascii?Q?ppmDxUp3IGHsLRm5dF7imWgBcUF2N16H3waTF3JgvV8GGQKH3J60H3Fnzv8Y?=
 =?us-ascii?Q?jw6TOm63V3HPP/XSVWuOHYPzmY1119vgaG+BwjHlos9dm//BxuN/dYqMlHYs?=
 =?us-ascii?Q?/hfKyyEuBzqgbNMbSr2jgjSVEwscWm/m7T+iRAQ7HuxNd0uwn8xflpyAf8X9?=
 =?us-ascii?Q?dNxT9mch7Xs/1qgv3NwFur5p6bCJ/jhJX89s66TAQfa4B8HlQVrev5us1xG3?=
 =?us-ascii?Q?VCmyZRFrxlAbZdR7V2U8qNwKhJSL964XKIgWZAxqEpdqdNTeouYl+CHIijF+?=
 =?us-ascii?Q?8eGqg8ohDlk/Zrm/BH5Vi5g4fL0gzug5bZkUBzUnu6Lw4T5HdiSxzyED3spj?=
 =?us-ascii?Q?sN4p8AVE5BRWB3mycoc7YFYHwNJfj60MYbH8k+qoea5Ahuz9ehdaZjNVltuE?=
 =?us-ascii?Q?FM37dmbjjywgDITtcJ5x57LGKinx1bLZv0Yek6HhV4P/sOROWszFdxrYMbAJ?=
 =?us-ascii?Q?DlOvWK92dL6ASIsFgp2AcxvuMGgci82pfSk2qoFHAMacF/UfVVH2E9WrBppp?=
 =?us-ascii?Q?aKHy6aj7la8VgEi1PUJ6iqt3JQ8fmVcxa9ZsuP9dzmxJdm+eD11lh1RAvrY4?=
 =?us-ascii?Q?MXZ59UBDEC6SwG1byXoxghD05M3zOIcfVVfGaRyelvPYn28IY/OcdKkbcj22?=
 =?us-ascii?Q?IYQ8xW+tvujPq9UhY7HJI9KMzSy0AAZI4LTVWcBF3J5XYzmelyIf1kTCZ5uP?=
 =?us-ascii?Q?cM48u2wwtyRXGHHK9yVq5f4HxRI9w86q4RFwfLR7N6b1ROWWjM8jRZkPAHyY?=
 =?us-ascii?Q?Lce7C4MVtxk8uyLTPTpVBjzBblGOFBnqcC2f/rH6IL7IhEYxvN61c9WdeqDa?=
 =?us-ascii?Q?P0g58KWtC3sBJw5bkT08EDzjzjwNHT+2ko8JWOQNsdjOmBbkKZYqeflO59+Q?=
 =?us-ascii?Q?CjP7DAtcGmE/83itj4OCKeDZAh5m2eYXtlBp4zyqvwRNHQ7jU3XrkDz2CWnQ?=
 =?us-ascii?Q?f6Vp107eEeCmgXlxcEbzfEfIbnwj6ipFaFP5CiphUNWBrO5a7LMl+riPRTV9?=
 =?us-ascii?Q?F6mPnwkHoSOiqxjZYTKAj+zNMEnoXYU7Z6KyAllt2vSkzjMPLC7PYZNEkGtV?=
 =?us-ascii?Q?xyjV2Qavm+H6TYR/kKR4HZrOEVtodUikmkEV0vneAlfpbixyj04pVBtzhHFM?=
 =?us-ascii?Q?+XVT32aawVdrlDcDeezKf/E1KfK5RKFjLE9xAQSXysGsvAu55pl8O2SEr103?=
 =?us-ascii?Q?yzisQatALRZ0RukT1aXIIZcQu0gIyEfpccpcQiyCZYEJN2aq2gs9ouazXu4a?=
 =?us-ascii?Q?JFgt7siPzUPNbuiCkqIHtm12uo7AYYWpIpVeOvoiSJsKmKZN6sze4KONvscw?=
 =?us-ascii?Q?alpYTERU0g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5cb2b-eef5-49f4-6585-08da4502521e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 01:42:30.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M/TlNqkRhzej6tr//gbzNC27PT6rwXKXz5B5qAk6L2eKOIEvrfM7YrD0VgtSN//khsiXCvix3Y3XZ5+GrMX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_01:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030006
X-Proofpoint-GUID: 3ZkHVz2i3d0N3gF196SaOSgmR_anImkc
X-Proofpoint-ORIG-GUID: 3ZkHVz2i3d0N3gF196SaOSgmR_anImkc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, the BTRFS_FS_OPEN flag is true if the filesystem open is complete
and as well as it is used for the affirmation if the filesystem read-write
able.

In preparatory to take out the rw affirm part in the above flag, first
consolidate the check for filesystem rdonly into the function
btrfs_fs_is_rdonly(). It makes migration to the new definition of the
flag BTRFS_FS_OPEN cleaner.

Here I introduce a new function btrfs_fs_is_rdonly(), it consolidates the
current two ways we check for the filesystem in rdonly.

At all places we use the check
   sb_rdonly(fs_info->sb)
however in the funtion btrfs_need_cleaner_sleep() we use the
   test_bit(BTRFS_FS_STATE_RO....).

As per the comment of btrfs_need_cleaner_sleep(), it needs to use
BTRFS_FS_STATE_RO state for the atomicity purpose.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Change log reworded.
The same patch was marked as RFC before. To know if there is any better way to 
clean up. Now I think there isn't. Removed 

 fs/btrfs/block-group.c  |  2 +-
 fs/btrfs/ctree.h        | 13 +++++++++++--
 fs/btrfs/dev-replace.c  |  2 +-
 fs/btrfs/disk-io.c      | 11 ++++++-----
 fs/btrfs/extent_io.c    |  4 ++--
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/super.c        | 12 ++++++------
 fs/btrfs/sysfs.c        |  4 ++--
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/volumes.c      |  4 ++--
 11 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ede389f2602d..8f73dc120290 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2597,7 +2597,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * In that case we should not start a new transaction on read-only fs.
 	 * Thus here we skip all chunk allocations.
 	 */
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		mutex_lock(&fs_info->ro_block_group_mutex);
 		ret = inc_block_group_ro(cache, 0);
 		mutex_unlock(&fs_info->ro_block_group_mutex);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 777d0b1a0b1e..171dd25def8b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3119,6 +3119,16 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_info)
+{
+	bool rdonly = sb_rdonly(fs_info->sb);
+	bool fs_rdonly = test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
+
+	BUG_ON(rdonly != fs_rdonly);
+
+	return rdonly;
+}
+
 /*
  * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
  * anything except sleeping. This function is used to check the status of
@@ -3129,8 +3139,7 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
  */
 static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
-		btrfs_fs_closing(fs_info);
+	return btrfs_fs_is_rdonly(fs_info) || btrfs_fs_closing(fs_info);
 }
 
 static inline void btrfs_set_sb_rdonly(struct super_block *sb)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ee92854b3a49..0790e0e49a78 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1082,7 +1082,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 	int result;
 	int ret;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	mutex_lock(&dev_replace->lock_finishing_cancel_unmount);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a39e63c7aa4..624070f144d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2570,7 +2570,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		return ret;
 	}
 
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		ret = btrfs_commit_super(fs_info);
 		if (ret)
 			return ret;
@@ -3648,7 +3648,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	features = btrfs_super_compat_ro_flags(disk_super) &
 		~BTRFS_FEATURE_COMPAT_RO_SUPP;
-	if (!sb_rdonly(sb) && features) {
+	if (!btrfs_fs_is_rdonly(fs_info) && features) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unsupported optional features (0x%llx)",
 		       features);
@@ -3823,7 +3823,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_zone_cache(fs_info);
 
-	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
+	if (!btrfs_fs_is_rdonly(fs_info) &&
+	    fs_info->fs_devices->missing_devices &&
 	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
@@ -3890,7 +3891,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (sb_rdonly(sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		goto clear_oneshot;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
@@ -4687,7 +4688,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
 
-	if (!sb_rdonly(fs_info->sb)) {
+	if (!btrfs_fs_is_rdonly(fs_info)) {
 		/*
 		 * The cleaner kthread is stopped, so do one final pass over
 		 * unused block groups.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4847e0471dbf..70283ebcc3c4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2402,7 +2402,7 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	int i, num_pages = num_extent_pages(eb);
 	int ret = 0;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	for (i = 0; i < num_pages; i++) {
@@ -2445,7 +2445,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 
 	BUG_ON(!failrec->this_mirror);
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		goto out;
 
 	spin_lock(&io_tree->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bb1677f6f201..809aa9d31bb3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5785,7 +5785,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 
 	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
-		if (!sb_rdonly(inode->i_sb))
+		if (!btrfs_fs_is_rdonly(fs_info))
 			ret = btrfs_orphan_cleanup(sub_root);
 		up_read(&fs_info->cleanup_work_sem);
 		if (ret) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 840a7d95ab86..8acf54d1962a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4152,7 +4152,7 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 
 	switch (p->cmd) {
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_START:
-		if (sb_rdonly(fs_info->sb)) {
+		if (btrfs_fs_is_rdonly(fs_info)) {
 			ret = -EROFS;
 			goto out;
 		}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4d43895504b7..9ace5ac8a688 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -183,7 +183,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * Special case: if the error is EROFS, and we're already
 	 * under SB_RDONLY, then it is safe here.
 	 */
-	if (errno == -EROFS && sb_rdonly(sb))
+	if (errno == -EROFS && btrfs_fs_is_rdonly(fs_info))
   		return;
 
 #ifdef CONFIG_PRINTK
@@ -216,7 +216,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	if (!(sb->s_flags & SB_BORN))
 		return;
 
-	if (sb_rdonly(sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return;
 
 	btrfs_discard_stop(fs_info);
@@ -1940,9 +1940,9 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	 * close or the filesystem is read only.
 	 */
 	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
-	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) || sb_rdonly(fs_info->sb))) {
+	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) ||
+	     btrfs_fs_is_rdonly(fs_info)))
 		btrfs_cleanup_defrag_inodes(fs_info);
-	}
 
 	/* If we toggled discard async */
 	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
@@ -2000,7 +2000,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
 	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
+	    (!btrfs_fs_is_rdonly(fs_info) || (*flags & SB_RDONLY))) {
 		btrfs_warn(fs_info,
 		"remount supports changing free space tree only from ro to rw");
 		/* Make sure free space cache options match the state on disk */
@@ -2014,7 +2014,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(*flags & SB_RDONLY) == btrfs_fs_is_rdonly(fs_info))
 		goto out;
 
 	if (*flags & SB_RDONLY) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index ebe76d7a4a64..857600537c3b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -200,7 +200,7 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
 	if (!fs_info)
 		return -EPERM;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	ret = kstrtoul(skip_spaces(buf), 0, &val);
@@ -942,7 +942,7 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
 	if (!fs_info)
 		return -EPERM;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	/*
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9e0e0ae2288c..24aa0e00bf5a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1104,7 +1104,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 			       "unknown incompat flags detected: 0x%x", flags);
 		return -EUCLEAN;
 	}
-	if (unlikely(!sb_rdonly(fs_info->sb) &&
+	if (unlikely(!btrfs_fs_is_rdonly(fs_info) &&
 		     (ro_flags & ~BTRFS_INODE_RO_FLAG_MASK))) {
 		inode_item_err(leaf, slot,
 			"unknown ro-compat flags detected on writeable mount: 0x%x",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 982a2417d5bb..35b6b87464f7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2630,7 +2630,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	bool seeding_dev = false;
 	bool locked = false;
 
-	if (sb_rdonly(sb) && !fs_devices->seeding)
+	if (btrfs_fs_is_rdonly(fs_info) && !fs_devices->seeding)
 		return -EROFS;
 
 	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
@@ -4616,7 +4616,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 	 * mount time if the mount is read-write. Otherwise it's still paused
 	 * and we must not allow cancelling as it deletes the item.
 	 */
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		mutex_unlock(&fs_info->balance_mutex);
 		return -EROFS;
 	}
-- 
2.33.1

