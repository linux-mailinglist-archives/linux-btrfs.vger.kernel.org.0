Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87242F1E7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbhAKTEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 14:04:15 -0500
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:34664
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbhAKTEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 14:04:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5q4T2gNXgv2Oape8ut1nG210/WCp8BaEv4rr/cI+bQUT0VTcHyZHnAmLODx1J4LWJD97NQSD/IKTIjT2ATWbGDMyfgdKHxQIEHLdcJb+jscJj1HJVQExZ/2vR2OyI7WadxD/fU4F6n9pURpQdzsb2C55XntDkcoYioe1AEPpeSvmZVAKso1cdohkX3QYTboPJovBvir9VpDOaZW9C6AW3LfLIJbiI71DdGpnj3h9DS2fVfGOdA+kZjIfntdoB4XBv9DaoNNgvwcDorYoYIJvmpPawdrzX2ggLsyQbhjh5s4jnPMxMS90PeKd2uMalvnmvt19s/mAe5xDzM+mntoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ha/RJKIRbE8xKfthKsPXNtXL8hxTIKcZnHa1fXHxY=;
 b=BqoeWBbiks8kMeWhjEcoAHYpVC0p1cC617sNRdzoc9+iORNeYq1U20eUlYWUBvjnQHPj1zVbTEx9pFA3u+VZU+1Kpvy4lAu7hTID1M4rgJh/konMJd2oQ+2xM423S2NDaM3H6V3gKnzfCZ9ZpX8nTVOafDjHvOfdMSXSwOkwB8SqJQmOp1msIp2JB5xL44voTuf22MkKYiTySS8mnVwVy7C8AouXwvH/qsKFSwm7y6DzHZUGqtJue83JG3D8f3kqugmEQQQTF0lGzBXnSzGdGRckz/BffgMcDAq97JFhYSKq1dvMJZnzcpS0cn6ead0XeiNbrHSEFr7fSUb2RE1TSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ha/RJKIRbE8xKfthKsPXNtXL8hxTIKcZnHa1fXHxY=;
 b=k74qXFP+IcuH1/P8moJt7IpO11/mmvKE6WoBsOLNTWPpNuojc4R2zcPY11zplmkljA1CPDd/8z+Xai5g7gXj/EQd+nvOPrJNlP+GX9ITY1L6WqGjzQr4A1vhsqXmL/+QyJRIWlG/6YCHwWUj4tIITTu0dt0p0FuoQQeFKiepCcMpZmMWdK3e1bNZfK15M0b/4LA+9JEQjuMYZV2Qxkai6wuonIrVtUxpo1ia2O2EW7odxZoI/X4NpNi5vG68TIxFhgjhB9ZDNaz7881bCHNr+YTTZbcLR/bge3tEckxG/Ed8JAK9ypIbZiydJmK5Qd3XPGs5VI3ELXHJJXR+N7C27g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB6PR0301MB2520.eurprd03.prod.outlook.com (2603:10a6:4:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 19:02:49 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 19:02:49 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH 1/2] btrfs: send: rename send_ctx.cur_inode_new_gen to cur_inode_recreated
Date:   Mon, 11 Jan 2021 20:02:42 +0100
Message-Id: <20210111190243.4152-2-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210111190243.4152-1-roman.anasal@bdsu.de>
References: <20210111190243.4152-1-roman.anasal@bdsu.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM9P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::14) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM9P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 19:02:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eaa1c55-c248-4ca4-ecd2-08d8b6637da3
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB2520592082D75738407FB22C94AB0@DB6PR0301MB2520.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMRbvQvuRJPgDxBlh0fwv4s3wD+XCAaSU0z3lCMZXKcrUHe5Gu7LLif61hcFgFO2KrCccxVJp5XxRuDZVH0dsZ0vaq31WxtCnI8zsqLAYPf9RF4aMspZ8PIqeq/kzrJiOEQXr++hmCrmA5NFMCPfdBFKymAQU3TCv+LmKHNqPfG9bJ01qK435+FqQNw5652FE041V0s7/3kLajDSPWFmUK768/QMcTFbfEvWU8K5Otp/h5rZBDgzbR21EdCA0/dFwcsjE2tzFH3p8HTsPTnPnfTMtrG2w/lha/aP1wJgSrYP2esWx8FyBJxoUcxWUSsXzFHViLsfizqIN7h8Phu//qalz2ZvkmnvkHpx6ROO0YLrVZQ8yD4Zv80ZN28rMbm2vWVKquvh9fBYT3IoVDBNNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(366004)(376002)(316002)(786003)(44832011)(66476007)(66946007)(52116002)(36756003)(1076003)(66556008)(83380400001)(2616005)(107886003)(4326008)(86362001)(5660300002)(16526019)(186003)(6512007)(6666004)(6506007)(6916009)(8936002)(2906002)(8676002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?STaOSLjJp9qyBum3kFke951Q3gJDnIvmTwcJ+SkKFz06NZk+s5m28NjCiaFo?=
 =?us-ascii?Q?3VuOHHhiHz4t20cL/RgHJvDtmIaMZ+bIG11lusBA4vj6FjT+kkZ4MtWT79a6?=
 =?us-ascii?Q?53zMDzKoSypaW4yiMfDmvtWlujT4zu3PwM+J95WQhLksSXvvg8/BFygHjobs?=
 =?us-ascii?Q?rwnu5fte3PBWsofcg62txGTTQT3thFZOwdN8hBQCnSOCdMuwyFJ2drL9gRrX?=
 =?us-ascii?Q?jw5j4+PWUA++Rk6yQBoq11rZskRNG65/v4qDQEqpDqR7SaFOeoPPfPBgN27z?=
 =?us-ascii?Q?N++1HmbuaFYWCAwUH0gr1wwhZqGg8RWDBA4khYBl7K9b1nwEWwjVd3G2MQ1L?=
 =?us-ascii?Q?eiRIfghfnS8hLdpv3laxGnhxj580gZIwRSsJdkH4HSrNUAolQ2mqGW3DDh6i?=
 =?us-ascii?Q?4MysnnicqjlqNdW3y8VFGOKPT25fo4Sb/6OYTTGcak9j0nlGtFY5HPMjel0w?=
 =?us-ascii?Q?Xj0FsNPx9kUqG/8WQ2pj982VaTfKm6IFWOGUF9YndU34Cu2ICgSMgoeWaMn5?=
 =?us-ascii?Q?nhlcexVO36DIFkfK2r8eJbYKPSKqrvcqutdSPeatL/4CyCrPEkMCQ3QXeaWJ?=
 =?us-ascii?Q?+gAMQeswLz/GgjKmAp9YunNMHaVxD4SmReXbKykxiGKxmuhCND/wfsjClURA?=
 =?us-ascii?Q?zdQKSH/KyNyw+RXMg+Ns5UItfVM/o0F/HD3nKA3TC9qygJVJEiJF4P3gCjS3?=
 =?us-ascii?Q?HK+K77PrtXgCvvke8JkW99BNzR8XhpRr8K/GhbOeRWfUErWvWdt/rPCNjjqW?=
 =?us-ascii?Q?OxOtRUU/GCcQnp99eiS64n6a5+pHATA8BLSM6gTaSikRAbci8W8nALr6pAb8?=
 =?us-ascii?Q?xHuhqMGdsCheVybHdimuE/EprQq3FBcJj6tBw0dvjP2Y2DbniqLQjNJJOmRA?=
 =?us-ascii?Q?imPLaKRt/iV5Bxf+h2wEXn0QE5ygtwP94Tvx1CU4OJKB8V8kflZYo+8GuKq2?=
 =?us-ascii?Q?O7ZSESLxCjSB5Oabsm0KwGrj74UGSbaF1DVXnXT0M6WGm6y8UHjPGG7psXyJ?=
 =?us-ascii?Q?8D5BZf53BF5pIUNIqA9z9/aaUdoCFXPsTnagD8NppURiCvB0gkjyfmRbm/ah?=
 =?us-ascii?Q?f/Ygkgoz?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 19:02:49.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaa1c55-c248-4ca4-ecd2-08d8b6637da3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1Ak6Kucfy9w2AudAT31CidPug/W8A8m8qwsxnyDre+c3FzApXrrcJ+OCbNy8xF5U4IkJGVnWaNK+3tEQN0ehQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2520
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

cur_inode_new_gen is used to detect whether an inode was/has to be
recreated which is - currently (!) - only based on whether a changed
inode as differing generations.
To allow additional checks for recreating an inode (see following patch)
and still have a sane naming this change was made.

Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
---
 fs/btrfs/send.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae97f4dba..420371c1d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -102,7 +102,7 @@ struct send_ctx {
 	u64 cur_ino;
 	u64 cur_inode_gen;
 	int cur_inode_new;
-	int cur_inode_new_gen;
+	int cur_inode_recreated;
 	int cur_inode_deleted;
 	u64 cur_inode_size;
 	u64 cur_inode_mode;
@@ -322,7 +322,7 @@ static int is_waiting_for_rm(struct send_ctx *sctx, u64 dir_ino, u64 gen);
 static int need_send_hole(struct send_ctx *sctx)
 {
 	return (sctx->parent_root && !sctx->cur_inode_new &&
-		!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted &&
+		!sctx->cur_inode_recreated && !sctx->cur_inode_deleted &&
 		S_ISREG(sctx->cur_inode_mode));
 }
 
@@ -6265,7 +6265,7 @@ static int changed_inode(struct send_ctx *sctx,
 	u64 right_gen = 0;
 
 	sctx->cur_ino = key->objectid;
-	sctx->cur_inode_new_gen = 0;
+	sctx->cur_inode_recreated = 0;
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
@@ -6306,7 +6306,7 @@ static int changed_inode(struct send_ctx *sctx,
 		 */
 		if (left_gen != right_gen &&
 		    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
-			sctx->cur_inode_new_gen = 1;
+			sctx->cur_inode_recreated = 1;
 	}
 
 	/*
@@ -6364,7 +6364,7 @@ static int changed_inode(struct send_ctx *sctx,
 		 * reused the same inum. So we have to treat the old inode as
 		 * deleted and the new one as new.
 		 */
-		if (sctx->cur_inode_new_gen) {
+		if (sctx->cur_inode_recreated) {
 			/*
 			 * First, process the inode as if it was deleted.
 			 */
@@ -6401,7 +6401,8 @@ static int changed_inode(struct send_ctx *sctx,
 				goto out;
 			/*
 			 * Advance send_progress now as we did not get into
-			 * process_recorded_refs_if_needed in the new_gen case.
+			 * process_recorded_refs_if_needed in the
+			 * cur_inode_recreated case.
 			 */
 			sctx->send_progress = sctx->cur_ino + 1;
 
@@ -6418,7 +6419,7 @@ static int changed_inode(struct send_ctx *sctx,
 		} else {
 			sctx->cur_inode_gen = left_gen;
 			sctx->cur_inode_new = 0;
-			sctx->cur_inode_new_gen = 0;
+			sctx->cur_inode_recreated = 0;
 			sctx->cur_inode_deleted = 0;
 			sctx->cur_inode_size = btrfs_inode_size(
 					sctx->left_path->nodes[0], left_ii);
@@ -6435,7 +6436,7 @@ static int changed_inode(struct send_ctx *sctx,
  * We have to process new refs before deleted refs, but compare_trees gives us
  * the new and deleted refs mixed. To fix this, we record the new/deleted refs
  * first and later process them in process_recorded_refs.
- * For the cur_inode_new_gen case, we skip recording completely because
+ * For the cur_inode_recreated case, we skip recording completely because
  * changed_inode did already initiate processing of refs. The reason for this is
  * that in this case, compare_tree actually compares the refs of 2 different
  * inodes. To fix this, process_all_refs is used in changed_inode to handle all
@@ -6451,7 +6452,7 @@ static int changed_ref(struct send_ctx *sctx,
 		return -EIO;
 	}
 
-	if (!sctx->cur_inode_new_gen &&
+	if (!sctx->cur_inode_recreated &&
 	    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID) {
 		if (result == BTRFS_COMPARE_TREE_NEW)
 			ret = record_new_ref(sctx);
@@ -6466,8 +6467,8 @@ static int changed_ref(struct send_ctx *sctx,
 
 /*
  * Process new/deleted/changed xattrs. We skip processing in the
- * cur_inode_new_gen case because changed_inode did already initiate processing
- * of xattrs. The reason is the same as in changed_ref
+ * cur_inode_recreated case because changed_inode did already initiate
+ * processing of xattrs. The reason is the same as in changed_ref
  */
 static int changed_xattr(struct send_ctx *sctx,
 			 enum btrfs_compare_tree_result result)
@@ -6479,7 +6480,7 @@ static int changed_xattr(struct send_ctx *sctx,
 		return -EIO;
 	}
 
-	if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
+	if (!sctx->cur_inode_recreated && !sctx->cur_inode_deleted) {
 		if (result == BTRFS_COMPARE_TREE_NEW)
 			ret = process_new_xattr(sctx);
 		else if (result == BTRFS_COMPARE_TREE_DELETED)
@@ -6493,8 +6494,8 @@ static int changed_xattr(struct send_ctx *sctx,
 
 /*
  * Process new/deleted/changed extents. We skip processing in the
- * cur_inode_new_gen case because changed_inode did already initiate processing
- * of extents. The reason is the same as in changed_ref
+ * cur_inode_recreated case because changed_inode did already initiate
+ * processing of extents. The reason is the same as in changed_ref
  */
 static int changed_extent(struct send_ctx *sctx,
 			  enum btrfs_compare_tree_result result)
@@ -6517,7 +6518,7 @@ static int changed_extent(struct send_ctx *sctx,
 	if (sctx->cur_ino != sctx->cmp_key->objectid)
 		return 0;
 
-	if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
+	if (!sctx->cur_inode_recreated && !sctx->cur_inode_deleted) {
 		if (result != BTRFS_COMPARE_TREE_DELETED)
 			ret = process_extent(sctx, sctx->left_path,
 					sctx->cmp_key);
-- 
2.26.2

