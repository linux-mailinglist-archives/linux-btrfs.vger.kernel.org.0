Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB1302BEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 20:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbhAYTpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 14:45:17 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:23525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731712AbhAYTn3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBAQqDdMoABw0dJht23SQIW1Szlu40rStuhLOdzKvQipxeoe0OrHHxu4nZ5wHtuerbetQchhbyEdivM03UKkoMnNYblUVDF6a08TLNh8JBTHG+1SDNAMpNdV/CAE6aP9yHrOFU7779Br+1xU20u4ipK0WKQifCaTpYMoMoDndy6Tc5aUY82wRaBrg1uXi4jy9Au19BGc/Bv+hJQFbYHYrwKTTUne6bRFJ0sVdSIi+2gL0ZnupVH+CsqmuiToLjbPYohoig3kEkueYSmbE31cDUhaenaY14dhhPgaCD4b2iG3HxDjRpto0NgSQwiHmiORz1HwVxW7ZVHRTJmwrWCVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK2iktAAOit4/I2hlMILUBVJrLgJsN5Jn27Jwuibsr4=;
 b=ofS2hTAe2a8Ldu3yEiizk3jYEIcx0brzVBYvqGYkwvlifrp/tZPaQj86zmz28Jf7Mdm41DV/mpn+BkAuzStd2CZzJXqngCDRWSVIXfvMfnNFBWzHZndhC97731dYNXMnLTTGtp0bw16vhbbxkJuQo/sSl1EIfFkRC4sxBh6rZKCebL0Q82OxP/jZnjiC8dhRPRgFjfjnqcZ1j9GiGC3Sv0d5iohG/f6Ku3m70GRUHdf8NqWd1CG16uB6pIn2O2udnxNLjnF0Ez3/dsTqzbaqLHOKJKmMh7v/b80pOozii9GOiq8oKkULDb+G9xQ0R3Haz4DIl7cmQRT7CdKc3TNOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK2iktAAOit4/I2hlMILUBVJrLgJsN5Jn27Jwuibsr4=;
 b=mZhijh5uTKz4id8agq/X0fswnqs12APzst5PeocZKpsPPJz/7OGujxDmDNqJrlfngcTjyL1EtFDnhMqOc7GqMK/PR7PlWSjirUubnHfqM+o+jvNod4BMC9k3O4prM/nLhSgWA7wbY5K3d1TbeJCnry6edq39qLQGccjx20FkUJSvnyQbVfRZyO7H3CiguQKViHQD25xqtyfAHr7O77T30CX9wz0S9E+yIvyK1DG7mwD6Ez2wjSW+u/giO1299alJ0tBh+iPrQ7z7oBCQTM8piuGeYNVrIdu34BspAFyCnSPXROWT19ob6o8IG+yfJJOmF89EOjHCvMgJ7ELoeEVfbg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:06 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:42:06 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH v2 1/4] btrfs: send: rename send_ctx.cur_inode_new_gen to cur_inode_recreated
Date:   Mon, 25 Jan 2021 20:42:07 +0100
Message-Id: <20210125194210.24071-2-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125194210.24071-1-roman.anasal@bdsu.de>
References: <20210125194210.24071-1-roman.anasal@bdsu.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 19:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd405c04-ec57-4ef6-3bfe-08d8c1694bd1
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB596266E8672AE7F97FAF8D3994BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB3VmRjAv+IWW0gWyPNR1bswmfSh1Je5Emm4EMkC1Cr/kjTXd2typdH8IzeShcDj4/bgWG6Lg9xwpCxamchA9nxy/+vmBn6icpuir8n22AYW5zLlTNyLf/MoHwdnOz3ZszwFf9JWK8oT5LvHwPLkJp8q0CYIXzVusFG16/yVDVMzEWAv32637kMg7+GNwDoDrp5MyJHKmfHRsTahl3tsZ1rGmJoU1yEIimWKVZ7RX72iG+A0KhZUdGQUIVfODHA9xZsVM7nGulq2TyysY9BJL7w8JMzN1B0ZrqoBYmw/VMrKfOh3BIHRB7FGSfsLw3v1dcsqydlouB54EsNOaPhJFAZ3vnM8EOByuo+zJ0XDCm2gGzjyMqc2Fm1K3YDJzF84ncmrEpqNfJtNFb1zZ4R4OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(83380400001)(52116002)(36756003)(44832011)(1076003)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WjgZr79D4ianS6YqT5mmmFkaX3I6cZnTXiln0d80lGalex3k+ARzptDd2zxp?=
 =?us-ascii?Q?vsen+3W2Z7J0pdT0PJQx375tKsnMEd3Q7gjfpnbLMjQHkK0+f5ts3CRK7kvT?=
 =?us-ascii?Q?++eMDSXIRV4kdh1B0dUXDhBPUoijildgfVZs0iZJgJBzuP2kS8EP9cihqW1W?=
 =?us-ascii?Q?9GyyVa4O+dLhem7/OTmBr7yW+A6eeoKzkmbDgwJrlH7jWhOQcdQ1odRhFRoX?=
 =?us-ascii?Q?JkKuJmh4QgW3IuarKmDoJOMif4A9SqzMj3jL6wCB0nDZIwmMdvNwNSN9gx+x?=
 =?us-ascii?Q?c2I8NbsrBcZdPtkdpRnH0UoNNODwszqT8WBtyjn8NW979iXBuFafKM+EWVsD?=
 =?us-ascii?Q?UJ+yc6FnNbZHeovB0YdalWL3cBIOTpRAZOFJKt/QjTCOBAzGHeL5oK8W+/+S?=
 =?us-ascii?Q?im3mcQR5XR2Ry0ZMlqWI++y4ZM6gRQaTYNwwHEAkf3/AydXWPUcAP7/bhHLV?=
 =?us-ascii?Q?q8qdtliS1Yt7pYFkHjlBlR96TQji7iR5W4vpNbBDKNvutzvtJIYFFkWFy0Kz?=
 =?us-ascii?Q?49KN0PnapcYq18lE63IPjI4BDm1oqoZuTNSNlV+SfTS4ZAM7Ag3uoUhZeJlW?=
 =?us-ascii?Q?75MKKPzG6Eup+exBHaneHi68RioVuj/Jz9Mc2ANJ3huKJSnR0u72LT6C8hsZ?=
 =?us-ascii?Q?VW+0WXGZkeo18B0J+Yz+p+vKqsjmPzPfUwWB29zlc8ivRhFnVB0bC6wEnRhd?=
 =?us-ascii?Q?YtXxUOX6WJ69HllZhaeDYarP5SwoMmaxKZ1AhjEF/RmSZfv8MN/ve3lKudTu?=
 =?us-ascii?Q?khCAmaeM18WcqcN8lUkHx2WYQ09cL3WDWj8leAb/URZlMwshYmzMRsg4hXr/?=
 =?us-ascii?Q?HoDAxWhRu2mJL5iVLLlOEzJa2mPVHu4VDRUAPYqcuqa2Y7pKu8r6UUcrPB+z?=
 =?us-ascii?Q?/P460z9Q14rfXZ5SayprH51OVE/f3gymrdkp9GqZccc2sg9GcsO2jT26BKji?=
 =?us-ascii?Q?Ffe+QzE9msWN407sl9ivKEro+kgD1r0mLBXF9YqUurVJb0yT+Wtd7xkQhplo?=
 =?us-ascii?Q?5J7JViVs46ro3xyTuPsKDiEodO1PsSquHR4G85+jlnTjw0schWLBXMKqFzyv?=
 =?us-ascii?Q?n6r2a30m14Dj1xZ/i+jrktklogahCj2Hi0Nb5zEaWJ7Chp5qn0qCbwE56ko3?=
 =?us-ascii?Q?++TXQkVWRm84?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd405c04-ec57-4ef6-3bfe-08d8c1694bd1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:06.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrxyZtb4raycEkI0w9kYmVcxnO0R8swuD7nDgNbYjXAWqESd9EjMrYa2yt9iXOOsiyn4xEDscpJv8bqFrhEewg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
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
index fee15c4d3..ca78f66a0 100644
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

