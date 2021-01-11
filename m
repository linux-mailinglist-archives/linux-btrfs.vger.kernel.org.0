Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96C2F1E7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbhAKTD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 14:03:58 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:14190
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbhAKTD5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 14:03:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjJuk2ir7OeIuGJnjosU2avXUtNeseDPgveCJI+nPMyICbEF9zZdKgUVl4jk2CkE+ZkmccwNK1CoI3IT+1dnZi+zFiXx+Pis5Lq5zsHWfAxj7T6e+6BOWB5grP5VN4toUvdwm3lpYx+QLMP8M+/+eqJWNd7v7at++WdToehXG1/NcG3l305+Vv7xmsGsjRxBqqMPjOerwnvL4qVOXt5DZ0h3QjNDRDeL8GSkzizF44R9fX/q0523gyFrRFGlZt5KYTPdasTAzfamsQWwkVAzoLUee7K2CKiUpYvKT1FTx2/CcTEAnFkIJVH6sC9UzRV0KYewLh6yteSnvnezog8N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Br8ncdZgVjChhont8Dq421789cNaDNtXIo1UXu87YM=;
 b=k/QSJjL4eRQVn06R46nd68/ipb95N+zEJ0t5oZUt0YUc4zeVV1y9pWi4OdX7y91iugh301fF5svF4UZbsV242TyUCjKDID9zrdzp+BDYbGymudQ/LKhb/kDv3IgKTJYrh0NHGvwEf9maF7DqelGybWPVWG6oaD0aeBs4QO7nl2M4rDnLSibPprf4Gzr87MDbBeX0ez5KxD6pIBlaldG4vxesaUQzzg3anGaqzWP517g22to8+NBVtUJzygWNsSx64cNJsYUSn1BdhX17Ux3sYDfytiXYoSeNZ6OXKswZ4iX2weJRYk8HbcNhiYs4Ay3ADKk77FrhnoHYaE9ZWubaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Br8ncdZgVjChhont8Dq421789cNaDNtXIo1UXu87YM=;
 b=DMI1deDeIVFeoLL7QBSVgrR6NdS1lxq2syQInVSgUCPsCeh8GfkkvaQrfAyuPQk3W2d49JYk7zV1grx38HfyOGoUjUaOULz4QIU3mH+LPJnyW0pmVVrSS+WDSd/aMHt26zNf8wA0SMawFsEHHE0PzhuIXjKLeJlCxKFlb2TQeNNtjlCB0iKPnakq6v16Ga9byKk/fhjfjye7rXX36PORzK4PkQYY7+kWBARj8HGCyVgLEvM+pQfgiIphsSl1EbYlbLSi+zg1EXmgUhqEbgKzUrY5Ys354lf7uTet0uofUYKPKMhRUjzP3XJy6fIk3tiv8/aeOpTbGbU82/nFGU015g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB6PR0301MB2520.eurprd03.prod.outlook.com (2603:10a6:4:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 19:02:58 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 19:02:58 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with changed type but same gen
Date:   Mon, 11 Jan 2021 20:02:43 +0100
Message-Id: <20210111190243.4152-3-roman.anasal@bdsu.de>
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
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM9P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 19:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6bc1f26-762d-4838-bb1a-08d8b663828f
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB25202AA86B87C4B1B612432F94AB0@DB6PR0301MB2520.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW9CNZ/OdeHFfMbVVs09i8Vx2tOsEiU/bSBg6juHVJz5dOFpI2z8ScVIp5iXBb91sgy3uS0LksUJBpuyCJXUa3BfSvX1w80jY84pSffCTqBzRuuf7PgH/mve5KMSNFww1M281QzY0tAjqGnvl/xCO0/THhSTOkN2UvQnAmHjkVT++Umz0ahyvF6KyrZUwmsEDWOvjEkteCi8d21iJljEVT4uv6ODLXr+8jxRP1sAYFWRyfPauamKUFpOqW218Za5ege3bsn/oEczhVer20M/AGGyIDgkJs+NuNFyHnEZiv0b+E0qLZQlKCy+rgDTfYEYizvOezNWWEa19jLFU4LjTwoZoRstbOwkecpL394h9JCtGxioCOpQeNz04ouKUAnwgtA1zNXZ97eZoCfr+68obQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(366004)(376002)(316002)(786003)(44832011)(66476007)(66946007)(52116002)(36756003)(1076003)(66556008)(83380400001)(2616005)(107886003)(4326008)(86362001)(5660300002)(16526019)(186003)(6512007)(6666004)(6506007)(6916009)(8936002)(2906002)(8676002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vb3flGfC6wQUvrN8FOAqbOofvQq04bP5MAdUWg/qgvVqtSUwebQosVt9bCRb?=
 =?us-ascii?Q?XL0prx8EZZJv111VioPxSlb4I73H4s4QUr8JKxQm6Vd9DsesOfu3gYnfUQXk?=
 =?us-ascii?Q?lxf1f3WL8uSLM+TJ7809gNFtqn9cPbxFz8bYGja77G7MzupRGXc2RQ9Rw84x?=
 =?us-ascii?Q?AOtLTBcS/uEcEfDZAh2vd09s3h5mWu8PjLmZyg/UfuPhcjdCZeVAcI9eLSpS?=
 =?us-ascii?Q?jk6TURIyJRcEv1/iTGRdLc6SOhroIyKMhjjbeIP7MEGJvjIokT84OBzunm7E?=
 =?us-ascii?Q?PuWqqL+gjJSxDhUSdPpBb5YXkDjNcMllAm0vddk1wQmv558xFme2SiaioCjq?=
 =?us-ascii?Q?n7gUX6ZZEy6QiTlmHCuwTUN/+9WOHntDLnXHxanHS0lVW5Zm0LJBDW2RqljO?=
 =?us-ascii?Q?vBmF5S3N8s6cKYyuUex7O32rRfYJ9Jv0mRQdzzQyssLD13NPNfxMXLu6gSzO?=
 =?us-ascii?Q?RDI7HZK4LFhn08PqdAFw6qWJ7EkbgNW10MvPtC38N3ie1lbDjtiIGLUewMVp?=
 =?us-ascii?Q?n9mXd8jPlWrbIFqVhLmCMGHIisx7DcDvCzgIf1WYtqGIQGpEMlPRqvF7le8w?=
 =?us-ascii?Q?J5pmvgAk5nmiMQNvLBmgU0AtbUgZuBuO61wlAzLi+83+BpDeS1hqTIYjnlPn?=
 =?us-ascii?Q?t79WGrUQvDVqcPoyO0A6yC/28NpR25ICI/o0cUm1feZhOx+WBRag/lyMSVwv?=
 =?us-ascii?Q?HWbcDInW1sbltW2DlkpYawGGlRidc7fm31Kcvpf8BOYtyJd50W7i0727rfxH?=
 =?us-ascii?Q?XdOmQyXbWQTMdXkRQY6x6vsCmUsWKGvX15TnZQU9U1tLV4wZUEtgQ/+FCPvX?=
 =?us-ascii?Q?xs+LFUvMF7ZELM/F21pVjhvY8w/UPTDbWo2DJkB4/0mS7rXDIMlWt5vQuZpJ?=
 =?us-ascii?Q?rJ2EUZcR6OZ598bWHzDoxjCrTgDd4u2I5QQ6+u3ikLBsnOE1K3X4VLM3kgHZ?=
 =?us-ascii?Q?tYJXNNVlPSAdEvjILuJ8ghgzjEJV3ZmJg44EIfZczFsAvyDbRItMC9oSCbzD?=
 =?us-ascii?Q?Xx+lLMpmqIi5w5ibVRUOJVLT/LLqJvPwtssuoMLWqwMrh0tKIZIpecjdIK9+?=
 =?us-ascii?Q?xedEJUG+?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 19:02:57.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bc1f26-762d-4838-bb1a-08d8b663828f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1Ii3VxXJsFwAeZ5vT/W6eeqS7Hx3gy2ixekXGBSwaU+M5vnj+bVKRG4UoHiw70aBoJluVbHZuqZS7qdZ4iqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2520
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When doing a send, if a new inode has the same number as an inode in the
parent subvolume it will only be detected as to be recreated when the
genrations differ. But with inodes in the same generation the emitted
commands will cause the receiver to fail.

This case does not happen when doing incremental sends with snapshots
that are kept read-only by the user all the time, but it may happen if
- a snapshot was modified after it was created
- the subvol used as parent was created independently from the sent subvol

Example reproducers:

  # case 1: same ino at same path
  btrfs subvolume create subvol1
  btrfs subvolume create subvol2
  mkdir subvol1/a
  touch subvol2/a
  btrfs property set subvol1 ro true
  btrfs property set subvol2 ro true
  btrfs send -p subvol1 subvol2 | btrfs receive --dump

The produced tree state here is:
  |-- subvol1
  |   `-- a/        (ino 257)
  |
  `-- subvol2
      `-- a         (ino 257)

  Where subvol1/a/ is a directory and subvol2/a is a file with the same
  inode number and same generation.

Example output of the receive command:
  At subvol subvol2
  snapshot        ./subvol2                       uuid=19d2be0a-5af1-fa44-9b3f-f21815178d00 transid=9 parent_uuid=1bac8b12-ddb2-6441-8551-700456991785 parent_transid=9
  utimes          ./subvol2/                      atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000
  link            ./subvol2/a                     dest=a
  unlink          ./subvol2/a
  utimes          ./subvol2/                      atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000
  chmod           ./subvol2/a                     mode=644
  utimes          ./subvol2/a                     atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000

=> the `link` command causes the receiver to fail with:
   ERROR: link a -> a failed: File exists

Second example:
  # case 2: same ino at different path
  btrfs subvolume create subvol1
  btrfs subvolume create subvol2
  mkdir subvol1/a
  touch subvol2/b
  btrfs property set subvol1 ro true
  btrfs property set subvol2 ro true
  btrfs send -p subvol1 subvol2 | btrfs receive --dump

The produced tree state here is:
  |-- subvol1
  |   `-- a/        (ino 257)
  |
  `-- subvol2
      `-- b         (ino 257)

  Where subvol1/a/ is a directory and subvol2/b is a file with the same
  inode number and same generation.

Example output of the receive command:
  At subvol subvol2
  snapshot        ./subvol2                       uuid=ea93c47a-5f47-724f-8a43-e15ce745aef0 transid=20 parent_uuid=f03578ef-5bca-1445-a480-3df63677fddf parent_transid=20
  utimes          ./subvol2/                      atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000
  link            ./subvol2/b                     dest=a
  unlink          ./subvol2/a
  utimes          ./subvol2/                      atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000
  chmod           ./subvol2/b                     mode=644
  utimes          ./subvol2/b                     atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000

=> the `link` command causes the receiver to fail with:
   ERROR: link b -> a failed: Operation not permitted

Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
---
 fs/btrfs/send.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 420371c1d..33ae48442 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6299,12 +6299,18 @@ static int changed_inode(struct send_ctx *sctx,
 		right_gen = btrfs_inode_generation(sctx->right_path->nodes[0],
 				right_ii);
 
+		u64 left_type = S_IFMT & btrfs_inode_mode(
+				sctx->left_path->nodes[0], left_ii);
+		u64 right_type = S_IFMT & btrfs_inode_mode(
+				sctx->right_path->nodes[0], right_ii);
+
+
 		/*
 		 * The cur_ino = root dir case is special here. We can't treat
 		 * the inode as deleted+reused because it would generate a
 		 * stream that tries to delete/mkdir the root dir.
 		 */
-		if (left_gen != right_gen &&
+		if ((left_gen != right_gen || left_type != right_type) &&
 		    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
 			sctx->cur_inode_recreated = 1;
 	}
@@ -6359,10 +6365,10 @@ static int changed_inode(struct send_ctx *sctx,
 	} else if (result == BTRFS_COMPARE_TREE_CHANGED) {
 		/*
 		 * We need to do some special handling in case the inode was
-		 * reported as changed with a changed generation number. This
-		 * means that the original inode was deleted and new inode
-		 * reused the same inum. So we have to treat the old inode as
-		 * deleted and the new one as new.
+		 * reported as changed with a changed generation number or
+		 * changed inode type. This means that the original inode was
+		 * deleted and new inode reused the same inum. So we have to
+		 * treat the old inode as deleted and the new one as new.
 		 */
 		if (sctx->cur_inode_recreated) {
 			/*
-- 
2.26.2

