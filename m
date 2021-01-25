Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00AF303128
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 02:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbhAZBZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 20:25:05 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:62438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731604AbhAYTn1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6MJxg8W+462bnngIGd3IhEDQLRez+900L+a3DPGqsVaA6Puk81bJqr0X197+wMqcEz+IA4/oRbvsrg+utIWXLDGq+6vC0TrVtqoZASoAw/kCRx7kYkOePa+4Z11pogWhVQEZ8tJXI9HClEJtyJJpRXaY75zqjwQnBZOc3A2Jx6zOG9U+e7gcpCAfogxl7A0g4fEdsC8f/QgK74mvMkuzA29PEn/qlI6wBttVnIolFK2h5arfsk0fpJ7oCM8POMOjJYa9icGj05M+uaQcZD/ZFx4F6FuRRxJTqZEt+MdEYICIE5FWOlYPDee9+CIG2aDsRRAsvJo0AHklzrW15v9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KTtiqyhFapbU643JQbGUL1KEa2DwXAt5OOq3Gb7jmw=;
 b=JcjWpkbeExjFiVI0xWcjymnZWv4Ieva3FjelXA/wAxpBLEPiOKsSE8N6krSL7yUjTZUxHPY4JSpSVLfZ0Jl8VhDxMgiUB2kfUK4B0DffmyKR2T5SGAN0FujORuJARZGs3njM57yWhuRnTTNiunxBg0ejexsz8CS1EFJPyYxaAGNclnqwdiJw1XIM7eWuv8HLxmoHPLdHPbQRRSrNYspTiNFbJci426xoE1HbjGWxxLZy7zkcIYLEJEOB3nOve5Ey7jE/LMIEjst4E1oJbPYFEwfmGi1S0ak210v2XtJCDwap05UvBsc+GvfXtAsJ129MmbDtZMDFDOJQXii6yXTAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KTtiqyhFapbU643JQbGUL1KEa2DwXAt5OOq3Gb7jmw=;
 b=c01tzxCoryoxjeBqD07uEDl0FYJs8tbJclOYtSpWnkfn16NMUpGFnulIeh9CK6lJv35OchBqM0cGnw2/TCJrC7MrUrvqbnWOwWs0kehldRi66wLJpLZQyxzlgl1mmeUBj+nWcIC+Ko+FEvlIT1NWD/ec3JUJr5tqiy+GX2XbLGpihlbnvPG3nKsicZ5kKu27zuo2mZn2YNF/3s6nsw6FQS7arq8usfX0vjJY0pkStq8AQUbvjuolxgKlu2LW0OLrmU+vERHfHlYuqg/oAVbKG6X/aOecfcO6QmunRsxJd13AYNITei05g8QnB7XpRcBAZdypU6Fli3SnR7RKUXxPhA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:08 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:42:07 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH v2 2/4] btrfs: send: fix invalid commands for inodes with changed type but same gen
Date:   Mon, 25 Jan 2021 20:42:08 +0100
Message-Id: <20210125194210.24071-3-roman.anasal@bdsu.de>
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
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 19:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a24080-3e3f-4386-1d60-08d8c1694cca
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB59623CE81A76449123976E6894BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEeAZL29qN8viiiAF/DZ1mW7k/HyEAnaDkrdWBTa3qmZndQn2zOFESWqK+DTyn8ZNkA9+jSkuk4rBwgHhr5wGZwxPvXl7xJo6/jzhVkaKqgHpwrk//5HaVaWOhY4/UGlbIpXwTsrVLJBJNNNmUsgyjfFmV6Q+cGFyN6Onw6KFAUPRoRNcL+Qxr0e9gPRDnwDSTrFILTRkf0AjqaPrYsvdSZyq9yRvXtFupydJna4Bwcl+EEbfBf4qOGnd94mvlqb+1TXnarqHaVWqxL2Jl/t/z/e3JRrAT79JvWixU7oatLc+hFafs6OlJBK1dX7qy7rK2wyOBCCiy5pAreJYsVGIhGaJiC7Lgr4LENUp+yknAuO2mXpWnRFNDM4GiPRNLbf/KzCaGrxchEAUOS7Z+AsCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(83380400001)(52116002)(36756003)(44832011)(1076003)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wsoTXVjIKBC+mPmFGrPWTnCto0t4HdF1UdhhLPPz3UjhbgBltK+XcR6prT48?=
 =?us-ascii?Q?D+Ncta2M7McbH2HJ914az/bNb70Zb8TzQS+/AgdfFUFA3Yg0Ww63no1Uwusu?=
 =?us-ascii?Q?9Dui8mfxMx9kwIFNMsgO3qW7kFcaPQh/ZpuRifbFMeJHHU6Tl8QsrIiWvBf4?=
 =?us-ascii?Q?iLel831v+XWxhXsMA1bN8p11epy69L+1C6Dd4c06JMUeKN/gsvkdxtSLYGf/?=
 =?us-ascii?Q?3HIl0kYPNmJPQbYYqt2v7a22gE1Ew9sxnNL4iPlmLo5RfXu9ZwHr2K2rYIge?=
 =?us-ascii?Q?skGMlKol3iDADsuWuyrYYznuaXRLI7ZTOcMSi4vvYqdcLn9OdzVMlKPE9d2o?=
 =?us-ascii?Q?L1CevbIa2bwHsBzACVG/EHDjMo27e0twyR7FF26QXZxmBFlPGQOXNl2QZFrv?=
 =?us-ascii?Q?qAJblPn3wsDxF80TElQZyz6lw1YU61G62tc5ASrXDxMj/XmA6AdCgTcSvFOz?=
 =?us-ascii?Q?2lxrj3E94s8VtF3PTKltR/YC9MIXNKcacx8W174Ffr7PMTB26FPLQukGlQX+?=
 =?us-ascii?Q?SPqT2OH1c04awKhCT0yFy5I5RwMbGZ7PFSOAb6fH76UCxkdLO6XSwjdWhCZ+?=
 =?us-ascii?Q?qfr1OcdWIztiwyoU/PGAs8TOvrNhp+EOH/MBE8TzLT1dniGvgJ5NizUp1T/H?=
 =?us-ascii?Q?+fcW+1wTud5UvG90XMaXW+6849sNYAhDhTGns8N+1dH1WSfbPzlGWFcMPixP?=
 =?us-ascii?Q?de8kJFsCda6Nv4SWJBaslMOliJVv8EeUjeG7dj8bsSoPp8rYNt5muSPkOIRq?=
 =?us-ascii?Q?nY29KnDFt0yRN/GhTiwOAvDll+X69sXOa7yEichaAU/5j4j2VCwyRHZtn/Wd?=
 =?us-ascii?Q?bprNFeFX7unhQ2AcBwKrUw3/O/bcqjJcZc2e7MlR2p2jI/eOm1kBjmtKxhD0?=
 =?us-ascii?Q?lRMMHyxBIUVwnP4xjsyUnQC21MLAYYhbfPkkleEr9QQkaM7OHAPt27dBB/Ii?=
 =?us-ascii?Q?C/hYTmBYsH49mqywqSSBYc0yCFaZnq29RqnaKvK0QYdjRSntg6hh6eulmTIL?=
 =?us-ascii?Q?uUKuJje2FL2+ilYOGajBzft/qU7zbfbvM9pswzamjam28fkYWMLTm4pgeNk3?=
 =?us-ascii?Q?j+lLW9/r4v7bQPsanTMQjPxEeSOvvEwTyxL0IwXPSm/V/5+lWwLcTzohiFgf?=
 =?us-ascii?Q?POTpvZ8r2xzL?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a24080-3e3f-4386-1d60-08d8c1694cca
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:07.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOSPwivzpduGKQbqGX3cTv3JeOgvJlHyZAgA3Ig8yJrBS5ngXkb0tFL82ynOF/RUDvOJlQRr+h9cCtrlPsc0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
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
v2:
  - move declarations to the top
---
 fs/btrfs/send.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ca78f66a0..c8b1f441f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6263,6 +6263,7 @@ static int changed_inode(struct send_ctx *sctx,
 	struct btrfs_inode_item *right_ii = NULL;
 	u64 left_gen = 0;
 	u64 right_gen = 0;
+	u64 left_type, right_type;
 
 	sctx->cur_ino = key->objectid;
 	sctx->cur_inode_recreated = 0;
@@ -6299,12 +6300,17 @@ static int changed_inode(struct send_ctx *sctx,
 		right_gen = btrfs_inode_generation(sctx->right_path->nodes[0],
 				right_ii);
 
+		left_type = S_IFMT & btrfs_inode_mode(
+				sctx->left_path->nodes[0], left_ii);
+		right_type = S_IFMT & btrfs_inode_mode(
+				sctx->right_path->nodes[0], right_ii);
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

