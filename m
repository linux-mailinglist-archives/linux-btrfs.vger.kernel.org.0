Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6B3030A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 00:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbhAYX5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 18:57:02 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:23525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbhAYToU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:44:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCliP8rSaGyK6yMkhQGxZV19L8b3nyevjUWzSBsO2eKoBjTfp2mGsMaQNF2rlv2NIn8UUKc65KpxJt5WuayJgi98bypsSY5jCTUEvDBZDQIjUIfO6FpsRPAzt0Q5VToC1T9kAI2GLATzZDlX1WQUZIxK3geHigv9d1u1ynY9u9xfxX5ihpwTrv3ycYzkZFTkB2zXXBcqHfwtgnvXD+7U+LxN9WtlF8qjDSsdWKoZ/LMESQUN72BKrtoataXVsrbq4faOtTq9EJogvBLVlX+99LPq1myyVbURZTr+ujuKK+v14jyD0mfyQ25k5WKdXjcEHh4QcX+34iZJcWphftMm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZihgytemav7YES59ZjT497eN07oP6XHrl2lLduGZfk=;
 b=BnMlnCfk1MIfDuPGo75iuqm19B0r1JM+rOSnV+zHvH/kRN+QrkL44P6KYo986j7QkXFe3YArtsV10KPPqKxoaoSWpbUpQo01U7B8757j8uZCrUXZo8ptWMdoZhi3qMqoKEIsj+J3RZgaODLkEXUQ/yngt96D6NgRZC3g7vtR0ZpU0Aw2Ik8OnISItIcT5LRji5txG8v5dVyh7SwT2YPjYFRusXR8RKISSFkqLInvhlav2mTJ+cWB6ehbcXkF8UwP5I1cy6x3l6z58T8xj0b81dQlD2SrhVteMI1KPdoY53ZiSFck5SFmfM4XNPouKxwnxnuL8m1WgjgDvFLVuyWEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZihgytemav7YES59ZjT497eN07oP6XHrl2lLduGZfk=;
 b=ADqNB9F+Qz51BHGMpjeKZVX5Om75pkFesRyYmqFQ8PqHJVrD0ajLrCMuMY3HKcRRTPjNpP0dfyt3pZn4bfoxpdmcFwME5t0HpvCgfnfilLPaIMckKQzoy7Mhcnd6bi1U77W52+tDV3rLk/05knZ4kjAD1nMh0PNL4e16rb3YMftE7MTMklkAZnJ4ylOQ5V7lCJtgJnLVKMAIeKWr2A+sDYlJ7oxeJiuPRDff/uoxpB7lSRW+qQiwpP2OPKM6WoK2lY0r8F1z18is5HXusgdcyLdFo+ee06nDUdzUwY3uTO2rewYCkSRoLE5+SOYbM0RFAJK8jQLsmmuzgcqnL08ORw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:47 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:42:47 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH] btrfs: send: use struct send_ctx *sctx for btrfs_compare_trees and changed_cb
Date:   Mon, 25 Jan 2021 20:43:25 +0100
Message-Id: <20210125194325.24269-1-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 19:42:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d44410-886b-4d47-b28f-08d8c1696431
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB596272750190EEA6AE967BC994BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW+dg+tbUMVPclPuJgadMGU9HPo/XX906xMQDuQEfLH+bZwE79FCQpihO6DzzIOLZOBggzXxGUF0HZlKyhOzu5cMTQOvuNJX2NjqOkR6KT3MlbwRE2WYM7LIBIiDZ8e29fh9RMrvaLEHicIjXdMDAMdra7C7OMs0VGcxIP939B0BURyzMTXO/KmLEqe+6ockZAdqAJ+sCvNVxkVg37JrX4BTKN2HU7fbpxbQPHQQnMe2rPzYvauRfJqO8ZuT2PixvYIp1Y4eaH4YLt+oZ2N2PJGJn8tnHWHoD7vFuYgitwXD7y0og569WYhqUFc0VT6P3PF38drF0QSzYzNwgY/+UMOUEWyG/sSlDyTMeORUADKW/xPeWMIEIik2h+9HTZj2MrLxhkmxOt0SKtaqaBXhKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(6666004)(83380400001)(52116002)(36756003)(44832011)(1076003)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W98PfSeniYrn5Ynpn99q1ZhGRiHGvrcgA4uzD8Ni06RNjqNAWDcQ2XVUh2DZ?=
 =?us-ascii?Q?RbgaywdfNtsWQiXcn31neGnnAjR+jrW5kOrBl3lft/mNLx1Kl0zLjT1iFAR3?=
 =?us-ascii?Q?wWzeKYzXqFhdstMuXFVxxDeWIvg4S39bEudNeJbfgPcnZiOQn+K438Rm4ay5?=
 =?us-ascii?Q?6HaL7vpEqkVg4QC9Wx9HgmMJ2jUK56UcaocAMwikV+WKj7J54uUgEN4W4zy5?=
 =?us-ascii?Q?Oxv+s7YzyXYPC440lK0DpcS4OQ+/l+qMf9sot4DtzKbt69mNfUY4GKeYq+kO?=
 =?us-ascii?Q?h4vKCOWmO9Tg9fjIhOC9RRNKlmn7WabqiRGCbaVsNyubGAZeFcXHY6FETfgz?=
 =?us-ascii?Q?PVNXL0UP/ek2a1VZAhJy9vtna6I4S0tH70VuGPleXXdlI64CUlMgMUW6W0lH?=
 =?us-ascii?Q?PhuTU7S8Kt2/kdbDvsRa8eHqv53Ir2npw8y8Qtl40orUbuCH+nN9SDKxL4k6?=
 =?us-ascii?Q?N5pZ5UCKt6ojvYA2hopWPFa+10e6taqMnSv8DiShVNVn+ipApDhKJUyXRQvA?=
 =?us-ascii?Q?8rMKRbmLTYcV0Wd3pGX4iHpWWOXODJSun6SjvZqn0q9wjmFYHZpeQToLgvlp?=
 =?us-ascii?Q?rY4bovkU+Pzj8iRHgP3HPS1EYbk9+oA6BDtElPnmW3wb1c/rmuwLAPuGPzFv?=
 =?us-ascii?Q?ki403tN8c4Q/4wIfm17sO+Q2bJkSJdiE62M+QyKLuV00LHPJ9eyOjlGZQqhc?=
 =?us-ascii?Q?iotEygZgX2x/XECImkHxwksMH6mA++I1xB4y5X+t+jtGFlNtXthqv3AYfsTI?=
 =?us-ascii?Q?FigELLhvC+CsJMdpEKMGtaUl5VFljdggskRR9qbmCtpr1CscWLIiPEE3Uc26?=
 =?us-ascii?Q?cicZn2nUm6HycHEMmlmzEEwqtwY8kNtlXmfTZJpCntPUTHu2v+aZLrqOAlHt?=
 =?us-ascii?Q?yaMH7T8eUPRacEeD5EqDmnqlTs8FGNFB9l2cspRPVSDXizQU5D5cp6lgnOnv?=
 =?us-ascii?Q?8tBCNk3zgWyYRjpC5tsJnIQODD5KvM7Ky77d0JCyTl7JrQrHNJX9hqCOu2QE?=
 =?us-ascii?Q?ApdUjFhMYTk6UoYDlGvtQn+UpXfSrvIB6vr1gS2QiPHAa0n+zucdmyzvQuf1?=
 =?us-ascii?Q?qNvsKbAmJYUyJida3Wp8GSLBEAKZqcep4SZNUxf4t96F7mo6aNfqSLySd311?=
 =?us-ascii?Q?Queocj12gBZk?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d44410-886b-4d47-b28f-08d8c1696431
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:47.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLuvosJw8QNkifaKT08i6qORueYCYD9/tjQtfiF+bc7vWr5eczADDIEuOd1xR8zfSXU/u5ROdPV8KbVSDu7qNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_compare_trees and changed_cb use a void *ctx parameter instead of
struct send_ctx *sctx but when used in changed_cb it is immediately
casted to `struct send_ctx *sctx = ctx;`.

changed_cb is only ever called from btrfs_compare_trees and full_send_tree:
- full_send_tree already passes a struct send_ctx *sctx
- btrfs_compare_trees is only called by send_subvol with a struct send_ctx *sctx
- void *ctx in btrfs_compare_trees is only used to be passed to changed_cb

So casting to/from void *ctx seems unnecessary and directly using
struct send_ctx *sctx instead provides better type-safety.

The original reason for using void *ctx in the first place seems to have
been dropped with
1b51d6f ("btrfs: send: remove indirect callback parameter for changed_cb")

Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
---
 fs/btrfs/send.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae97f4dba..fee15c4d3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6592,10 +6592,9 @@ static int changed_cb(struct btrfs_path *left_path,
 		      struct btrfs_path *right_path,
 		      struct btrfs_key *key,
 		      enum btrfs_compare_tree_result result,
-		      void *ctx)
+		      struct send_ctx *sctx)
 {
 	int ret = 0;
-	struct send_ctx *sctx = ctx;
 
 	if (result == BTRFS_COMPARE_TREE_SAME) {
 		if (key->type == BTRFS_INODE_REF_KEY ||
@@ -6800,7 +6799,7 @@ static int tree_compare_item(struct btrfs_path *left_path,
  * If it detects a change, it aborts immediately.
  */
 static int btrfs_compare_trees(struct btrfs_root *left_root,
-			struct btrfs_root *right_root, void *ctx)
+			struct btrfs_root *right_root, struct send_ctx *sctx)
 {
 	struct btrfs_fs_info *fs_info = left_root->fs_info;
 	int ret;
@@ -6952,7 +6951,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				ret = changed_cb(left_path, right_path,
 						&right_key,
 						BTRFS_COMPARE_TREE_DELETED,
-						ctx);
+						sctx);
 				if (ret < 0)
 					goto out;
 			}
@@ -6963,7 +6962,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				ret = changed_cb(left_path, right_path,
 						&left_key,
 						BTRFS_COMPARE_TREE_NEW,
-						ctx);
+						sctx);
 				if (ret < 0)
 					goto out;
 			}
@@ -6977,7 +6976,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				ret = changed_cb(left_path, right_path,
 						&left_key,
 						BTRFS_COMPARE_TREE_NEW,
-						ctx);
+						sctx);
 				if (ret < 0)
 					goto out;
 				advance_left = ADVANCE;
@@ -6985,7 +6984,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				ret = changed_cb(left_path, right_path,
 						&right_key,
 						BTRFS_COMPARE_TREE_DELETED,
-						ctx);
+						sctx);
 				if (ret < 0)
 					goto out;
 				advance_right = ADVANCE;
@@ -7000,7 +6999,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				else
 					result = BTRFS_COMPARE_TREE_SAME;
 				ret = changed_cb(left_path, right_path,
-						 &left_key, result, ctx);
+						 &left_key, result, sctx);
 				if (ret < 0)
 					goto out;
 				advance_left = ADVANCE;
-- 
2.26.2

