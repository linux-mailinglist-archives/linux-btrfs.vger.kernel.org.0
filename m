Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E54E627E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 12:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbiCXLbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiCXLbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 07:31:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9E2C126
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 04:30:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O8oG0X001944;
        Thu, 24 Mar 2022 11:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xYMAJQrtWTxyGVZphEgAVJ91xkmQXTVEfrAXSJP2yFA=;
 b=OLQOv0b7leY00mDhxa+eoTjn/N7F51Z9Is+ZesMKm/RvyXsE2QD2FBN5fXcZ2NfBqFt3
 x+YXbrGVeuf6GlHfUEremOb2q0018A2wrdsUw4/IuHsQgh+51mjWB6OlI1655kocjWqj
 jbryie3kj3bOMqydS1dIglYoqwUT/dQS9XCO2xEr5cbOBb8UwrTWPwPwCAdv0R6vkv0A
 4d0X5lBi7bpo0paWvfiQlHKitu3NUQ457+Fs6sa0aXrxKFMqqQXuZMUdHXfsXw4/eEs7
 sugUCNjqnotUpbo487lu8fTiEecTkdEg+em2eh769tITXV3/5o9SQbMuc0KD1QQehPGj IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcuvam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 11:30:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OBGSl6030523;
        Thu, 24 Mar 2022 11:30:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3ew701r8e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 11:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB/JiKQtGQUaOs/Zn1krnVJb6DvIZsB/LuM5/Cvgx45WFYNeo788O5oaM9TvdMG335j0lhn1s96uQUZAxbnlnt7UWxTso8tIqwlI4VW2eItyiX48KOJa7xy+HdMCJXFKw1dSLn0XLLGFBLqQ8cExthQcB1sakmXPSUGtI6oVW9ZJAGYCvL+bDuUJZuHVlg/l8dVlvaT4gTMYYuJ3xyXfx4l9Q9jeT1gKTmK3rOEX9+/kPuRy5b8vUiVcCtLTJXDDOWULEZo8kq34QxhDZuy4o3/JhCDRIfUswhO/zxMA5tTCyesPmgMIpCajbT7ktVU0PbWAStkzH4GcwqIdf23WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYMAJQrtWTxyGVZphEgAVJ91xkmQXTVEfrAXSJP2yFA=;
 b=oR6OISSbiuIRSnHeEl1/7ZxHnxuBWZrYyfXq+cDIfqGz8YQtCD7EddQT1QWvVO5P9Tt7Illi3e9pu5eoMCrYj71LNPzl2tkUoZG/z/cf2inY15LPSjYsVRiYIwuyHbWLMvpHGNzAbUvLHFzmOvzqi5eCMNvT/uSK5kUtmqST2JWBs3Us4TWGUkbcFGyxzySZckwCdF0BVTG0TqY+H5qD1u9KaUdxm3pTuQDCebmx7gQPslWcQNDn14WAexigddMPXronvvdH2CN4DqPUr+9/WQXwz59GZQDzao7XUNzXi8ASnLk6drwCh8tb9zxxFXue+qm6llgJt5nJBDDhzVR56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYMAJQrtWTxyGVZphEgAVJ91xkmQXTVEfrAXSJP2yFA=;
 b=eNnRE/+BuJ3TlYcK1FBaVWjZfw8xK2WclyjWY2m4CiRfAsF+fzsPgk30tu0s4KnnxmITQNnCYNU8XSROnfv6jDdpqzNASsJE61YV+ubttNCowWK0JeIEtrXXOV2aPaHwGMK4J7bQFgrkLoTWqrw2ZnkHYXWJa0rZwVVH8mpoLHs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1946.namprd10.prod.outlook.com (2603:10b6:3:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 11:29:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867%5]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 11:29:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, boris@bur.io
Subject: [PATCH] btrfs: rename BTRFS_FS_OPEN add comment
Date:   Thu, 24 Mar 2022 19:29:51 +0800
Message-Id: <67a23a46711e1e479332622728d035af0b21bc16.1648120624.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be19f7db-f9b3-423a-b9c7-08da0d89a14b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1946:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB19469717078CA95F1888AEADE5199@DM5PR10MB1946.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwjef0l0iIk5tv+i4DjsHG+GUry/Zeuyk19M+XIqk0VLIwGVVS77G6mOnN8KynP6fw1mdqOSmpP3djb0jH/oC/AzWmI75NM2ZWPO1/jmOUjDhQEWhaEmETpbnx20GKLASqMYqBOzmX95AnXz4sGaqn1K6D4VZE7wbKZT2m2koG5KzXA7eLYiCp9b3MG/0PY4BBIo1NyWEfCL5dSV8O6/5+14hhBo8BfRERXtBAUtJc0GIwNBpjyOJlAEN53iolEK1Q0HLfOmUd7nyewNjXEXtalDOCKdKue6KqJ6X0/wXEG+6ruHbWOlLhB10UKf3ZnaBANdymepTOkI0iJM/kCkekPQCROOjfWNx1obXrIO7U2WpnRV0z24GHLzUARreAePbx3B7ZAp3qDmjlpSaNSgekiC/hqYoJ3YyAtMomYXkpjDpz4LuKKfpPFL+SCgvdQGWVmk39hCjq/rM4OUHvMDgcGNUtCd4rFwedBjhq0Fp1o/s2exTiUakDEZ5UWWvXnCAjsxyWBEhDdkDdpm8nP6otbJ2eYxQDWUcFRcXYAtudwFnEhjNwe2ud6LH9Ajcu2gEgQVhgrF2A2x+xCHl1VbFLQPFTLj9uH27dFOG2tYvuZX23loqdeY+z11TN2cBYZKrRnkO0fcf0gcKIjJ+pju5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(4326008)(8676002)(508600001)(2616005)(66476007)(6916009)(6666004)(86362001)(6512007)(66946007)(66556008)(2906002)(6506007)(83380400001)(5660300002)(26005)(38100700002)(186003)(44832011)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yZ9Hp0XrkRaVrSnqmVUWHfBC5ai+SG5OjfATGD7uW6KDpanROpPBsOntWIK?=
 =?us-ascii?Q?Qdoaj9sBcpbX+T4wRP7EQuuIo6tTmNTZ0Dq+LwzW+bqATuizQQA38TYlf/yS?=
 =?us-ascii?Q?QtyC/Fxwo8XMAsooi6TdkAxRDejtQvENE1hqzJ6Q55z91nhoWNli+K/7jpZv?=
 =?us-ascii?Q?+nMjFDzXCcU0ScZfIoK7rOHyCHoQy2zNNFcPhuVxiVvBduUUuz8jhPYQaLrO?=
 =?us-ascii?Q?MYYjTrOwO0NvjwA27U1mhcCiFcCSMZJhGw9FtGfv9Z8Lor5+6WrrOaeJUWlt?=
 =?us-ascii?Q?2hchV2LWr9pufn8cCnWYdAxibLK9+ly8KWYjZnN28Tv5CCMh+EVG1wp/wboQ?=
 =?us-ascii?Q?PcXXeZSgHzxhtNE/oMrUy+rF7vZE9uvDKUJxAeoy5eqnQvBwKVrUr59Cx1Wr?=
 =?us-ascii?Q?45Lwu37nXWqrcdmYHF+6YdfIu3oLoggHghw301tB4V1m1Y1Z9P6hc4s2xN9a?=
 =?us-ascii?Q?S7N/jynnoljyb7Ltj0uBN8+h1f8CZicX7FCmVcZpaRLQ1/wncHDG29I/DhfD?=
 =?us-ascii?Q?W3jv/RNgj1wSUIZvolIXj+aocfZxTQMpYlBybR5c33QfOFNuglHcLHHw+LVZ?=
 =?us-ascii?Q?pGWGCm39wL1QSRiVjQsrEKsOdiR2kZia/6uozaEwn9dUOTKKqc/jRgtOYKvy?=
 =?us-ascii?Q?iO8dAAg40d+0+M/2/jWi4OgOLVid4O9AB8O8xoaaTx7/Xzw1ulLLadFvWKeb?=
 =?us-ascii?Q?JHgfOyRsz9ubG218Q05sZKbi4BRNt3uzK+XQabuwjxNeZcdsPN8kRQXDfFYL?=
 =?us-ascii?Q?YEftF5kmaarYrf21hMuOfT1ABYP9tJ6N55Q3mno8NYwOCFMBjMjjk0CILrhO?=
 =?us-ascii?Q?d9V45LkIZPVU2A7ZmEdm9kNVoaIAMhBj/h62zMm716BWq/qxELXpl1yl3/r6?=
 =?us-ascii?Q?SiVYO8aZ+W1aiIcEwt7Lm+6nIBKzvKCvt2ENra0iOT/mpIKL+HuqG8GxIPXk?=
 =?us-ascii?Q?dlD1hrCyO31k13iOmswMXPHbbuLqGs7wsUakGBJRMNH5/dfMudiL+fUruQn8?=
 =?us-ascii?Q?guAnwtXAdpS5Kfy9ah8E5jMVQIhiKNXHDmr+fVix/zKuKOm0Po00AKl4W64m?=
 =?us-ascii?Q?FSBwSn431sj9VIpEC5Y7AWgkLXjef20jZK0vKWjTJDIe3BqU+DI6j1bqrUrh?=
 =?us-ascii?Q?zGebgyGheQnKBGGp1TWCF9umh9Oo5c3+nw92zCAQ2nHkz7IkXREaIzdVMxsa?=
 =?us-ascii?Q?Uc5RN6ON9mjHu76Kk7OBoYQtoXDxurgrG0oNjiEeiSvfWho7QsVHEd9W07Hg?=
 =?us-ascii?Q?y2qa/Qs/EJohOOCYK33QIHc0qMWb6EGGGw5W0R20nvQmvV3+6+lM0extx68l?=
 =?us-ascii?Q?n5HvP+wBg3g4DLwkfwlipSz1s45taguiseWtt2bhGuKpmCYvbZyLIgn4ppU/?=
 =?us-ascii?Q?ek/A3PJ58TkBWhcA7Z/Re/E6Dd2IntcgHnfdFo61aoze8J04ChFtuvUyTMQ6?=
 =?us-ascii?Q?0pFPRZR34IAxKwTEi/dk2ZhXCWZCpVVNxH+3rTWABtDhnVAVwaWBENS7fIkV?=
 =?us-ascii?Q?8yWAKrfPjRLGQw5F4dJBWhYDs0V5GF0DMTQxeXlrc6p4ZjfMxugxfrjy/koH?=
 =?us-ascii?Q?tfCMG5VBIlRWhfEBbB00RU6ZJzjicxGeSYCEYTM0yRm0ZhduDFGyc+E2OaWC?=
 =?us-ascii?Q?g+MZfj/Tez1U1aRt0/6K0GsRqtVYUWjSVoQe2G1xRrDGQAbXjLL6RZMlW9Ct?=
 =?us-ascii?Q?waXLvwSkCGjEHwbte0t1ImdUGqbt7AHqMohv+73cOGszL6RJAw5/siSZ7g/5?=
 =?us-ascii?Q?JDkql4clSY/rwgJqBmNUv2uPBJ+FcxE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be19f7db-f9b3-423a-b9c7-08da0d89a14b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 11:29:59.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgMhLSWycIi/mq7fs52AS4sDNoa7DHvVraGpFPyVOpSlGE4W7OZlexDR/vynxOvUIZ5CZUjs2dFYz6nsI5XRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1946
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240067
X-Proofpoint-GUID: PHLBg09MHxCiAV5ZAx-0ELu0TPWZyA5b
X-Proofpoint-ORIG-GUID: PHLBg09MHxCiAV5ZAx-0ELu0TPWZyA5b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The in-memory flag BTRFS_FS_OPEN in fs_info->flags indicate the status of
the open_ctree() if it has completed for the read-write. The mount -o ro
or the seed device don't get this flag set because they aren't RW
mounted.

The threads like delete_unused_bgs(), reclaim_bgs_work() and
cleaner_kthread() test this flag and if false they return without executing
the functionality in it.

This patch renames BTRFS_FS_OPEN to BTRFS_FS_OPENED_RW to make it more
intuitive. Also, add a comment.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/ctree.h       | 5 ++++-
 fs/btrfs/disk-io.c     | 6 +++---
 fs/btrfs/super.c       | 2 +-
 fs/btrfs/volumes.c     | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 59f18a10fd5f..cefbab299a35 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1295,7 +1295,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	const bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!test_bit(BTRFS_FS_OPENED_RW, &fs_info->flags))
 		return;
 
 	/*
@@ -1519,7 +1519,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!test_bit(BTRFS_FS_OPENED_RW, &fs_info->flags))
 		return;
 
 	sb_start_write(fs_info->sb);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 49026d27063b..4675645e1329 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -586,7 +586,10 @@ enum {
 	BTRFS_FS_CLOSING_START,
 	BTRFS_FS_CLOSING_DONE,
 	BTRFS_FS_LOG_RECOVERING,
-	BTRFS_FS_OPEN,
+
+	/* Indicates the open_ctree() is complete for read-write operations */
+	BTRFS_FS_OPENED_RW,
+
 	BTRFS_FS_QUOTA_ENABLED,
 	BTRFS_FS_UPDATE_UUID_TREE_GEN,
 	BTRFS_FS_CREATING_FREE_SPACE_TREE,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3de3e67145e5..0a1b23f8d968 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1998,7 +1998,7 @@ static int cleaner_kthread(void *arg)
 		 * Do not do anything if we might cause open_ctree() to block
 		 * before we have finished mounting the filesystem.
 		 */
-		if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		if (!test_bit(BTRFS_FS_OPENED_RW, &fs_info->flags))
 			goto sleep;
 
 		if (!mutex_trylock(&fs_info->cleaner_mutex))
@@ -3927,7 +3927,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+	set_bit(BTRFS_FS_OPENED_RW, &fs_info->flags);
 
 	/* Kick the cleaner thread so it'll start deleting snapshots. */
 	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
@@ -4761,7 +4761,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* We shouldn't have any transaction open at this point */
 	warn_about_uncommitted_trans(fs_info);
 
-	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
+	clear_bit(BTRFS_FS_OPENED_RW, &fs_info->flags);
 	free_root_pointers(fs_info, true);
 	btrfs_free_fs_roots(fs_info);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5f7032d14455..66ca1e24586c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2112,7 +2112,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 		btrfs_clear_sb_rdonly(sb);
 
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+		set_bit(BTRFS_FS_OPENED_RW, &fs_info->flags);
 	}
 out:
 	/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5be81fc26092..39b5a9f7664a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7710,7 +7710,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * and at this point there can't be any concurrent task modifying the
 	 * chunk tree, to keep it simple, just skip locking on the chunk tree.
 	 */
-	ASSERT(!test_bit(BTRFS_FS_OPEN, &fs_info->flags));
+	ASSERT(!test_bit(BTRFS_FS_OPENED_RW, &fs_info->flags));
 	path->skip_locking = 1;
 
 	/*
-- 
2.33.1

