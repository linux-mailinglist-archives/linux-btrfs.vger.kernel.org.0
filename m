Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928E302BED
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbhAYTpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 14:45:42 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:62438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732080AbhAYTn5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY45OepgjEFaPZXYZ+X5ydJrMnrQa9RfuSUDs/B5A3KeN3hBdGwt1gV0u9qI+geWTm8dmwRFAkjuoK1sLA5BBTks0D+NMWlaRe4mIdtR6tSm+6BleFfQZF71Pvef7QiF1oEcfBNGy3Ob9KrOmciJnKjgwzeskF1rY5a0yTSIUtedvczc+YrvwNjpxrk9YG9mIBKVwgsCzus76rP0CKWrss8/nOqVwpWstObJu3CeaRiOP2Um0pRt3i+W8rYhwGbtgnfvouTVqH7qB4fUxtn6mC2vMR8CrfbjofzOrV3GmZschcrHghjdlYTu9eNc7rHO7YXr29c2WQ8Sgx8ii3Wh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6z5UFG0TkCEPw/dudiFKMVK1rl9HIDGKoFW0X2z8LI=;
 b=YgLntgTcibboVbE7jT7hT16k8VVqPzEuXZzylzwrwI1t6UygUjKp2i0PuMRXdJRiMlG6PfWsqM4wf8zLkmtH6XmQQitBVmpnFQ0FX99/IvnXk8kMpZOFstryBzul94K3XEUoOBGfDkaC39itqRQmhjKuPe/k1tDwWx9WfIpetEPJP844WEMBpw0ZvnPAXuxhDx3pCx34/HLOSVz3KHIeM+2bKjcU8RoR+38mehaIApB69wZ8gkXog57pKCpDwFpdYysqLE47i+DVWtC8sCJnZhejTksjgZbrvnb3qDT6ZUZnqkqk/tM4D0YlsMpYYAQyDaU1Y/LbuYrlw8OJsLrl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6z5UFG0TkCEPw/dudiFKMVK1rl9HIDGKoFW0X2z8LI=;
 b=DcSekaQMBKOPRZPtDZ6olEqWCK1h1QKK2mI+NhrseRj4r9+wB+nEKwc9h/vVsqEyojmu9pC+eEGgpAZjhQacmeTUZSEMADvzYm2cGBCPO1aw4gv27WvS4fBjPFlQZDRMU0+FHfHNM24/jTvrqSWNrlbytAYpYqMT6o54UjJL8y7AplO3OPhwRCOneLF6p3LAelhAfNBVyVu54lNI5Z72Jb0s2scPSWc8dyDQCCczZWBzsssWJP4qqS9qVgK0+LlUnLjYHAEJMv4jbEHvBiefkOacKC6VBvtLqX9CmslEsODgwxhDU3EyVO7oHa3b3veO3uc3JSu+91NIXZn0dziThA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:09 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:42:09 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH v2 3/4] btrfs: send: fix invalid commands for inodes with changed rdev but same gen
Date:   Mon, 25 Jan 2021 20:42:09 +0100
Message-Id: <20210125194210.24071-4-roman.anasal@bdsu.de>
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
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 19:42:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d087bc-9e8a-41ee-e2a0-08d8c1694de0
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB5962D840A14F779971ED9B4B94BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXOYSKt4FLrojYekJEA8nYOHDCogTbs1XWU74Xk3RToD0JVBMs5S080toIdh1340u8k06OxNLCuJS4yM9/bD+USKPxlbFaR1c5n/p8Fej2JZqbfIWqEcHz4LrU9u42DWPL4RWzgK/++ggnKa5YgPqiG6KmXeOwP0Z3m+e19GEilOYrqJuehomf3fZkKS7L/FBLyqe0UDzUlxRtxp3T0aX7mHqL6GjlF7xxNsprZgJWvhlxQbUhJPURyBJSPpHdIzqHeqGwTVLXe05zeLf9gF8yye9XWLEfExiVyPv38UF6hvxcQQuejNmU+sCWhnQdtWDOmTY58Vvf+GYDKXnL41q+manGw6kRtqxfiUFyE+c0ulWxAnfsIrAOgr6tMfenApr2UPBcAmgp/4ONzY2w5yJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(83380400001)(52116002)(36756003)(44832011)(1076003)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/ANWlDfdJPzLr/nNLr/RfiBuurPOcF3prFe1JnYz2jQHYGU/Xtg3XBdnMrb2?=
 =?us-ascii?Q?iduLMFfGuNDMOy/C9MbSGkTrtGF6ZvhZx0J7fEC6PyXGyMjeu4LaZGRZnfK1?=
 =?us-ascii?Q?FcE4Cx/z4rIGRr05OcIDzQ+A6wNL1799GY2HKHqKFWvb8XG8PMpKaN5HDmih?=
 =?us-ascii?Q?MEvwUh+BstyI9w6Py7HqbaU2ssva3aqkwYN2jfb7leefsUa7Yk7BgrMUodZz?=
 =?us-ascii?Q?lwjkD5oVo1AUARyPDe5q/OCmo8Q/PPThvZOFX6Zc2rCWmuEzDCLJ2rPESK2f?=
 =?us-ascii?Q?EaR/+4jwh7iR2jsd0VAxYo5dI9vfoeGDZYengT2z4MJSeBKG4nOO7Z7eyXpn?=
 =?us-ascii?Q?0/gvRLT3oPBdgcfABBq4nWyb343MNV7CCKXQXuLu6tVGPMPkFIInCNHE3VK9?=
 =?us-ascii?Q?bZ2TCyXGXYUbkLy9qs6l0ix1pAMUMlurPz2hl3L2CqT3RSWCte9alebta7dL?=
 =?us-ascii?Q?TNEt+yfoLHyJkYQKKHJF3prs01ciUhbE89/kAxI4acf642ywQguT26UeWXtR?=
 =?us-ascii?Q?Z4fnqEzE2+WaTB94QGAyOD9YS1v/EZN2at4EJVYrQ6QocFMErXIms0TD+ivL?=
 =?us-ascii?Q?teNy5mhWOYUlXbR93DUzpE9rMhWfmeNyIl8XUOZu1r0DVLQBqGQWo7Wtgk/R?=
 =?us-ascii?Q?8xB1pRzva94DUnA+6ancNM+T0e5RVwwuYZgQVBok9o/K6NwnBBFtWK4J1qfI?=
 =?us-ascii?Q?5u5GiA8Hln09ipt38cBEBrwmf9BVx1Ay45TphqLAvHkQPVm5pPwPRP6bR6Jw?=
 =?us-ascii?Q?9GAUzVCMG1cOtsdpxGAKwGgEH2RoFjKfbT+OiYpqglfY/01A2gWxxZZkM7BT?=
 =?us-ascii?Q?O/LnC4RxHj5IBmcS4OVFIuwahiS7mxjSyiWe9Hb9BT6rf3/SPg+doyVRFOee?=
 =?us-ascii?Q?NsRIILkqhSaRqF4MVr3R3lj+X9G6k3HNbCjd6yEKnyrixLeJl1aa5oFuTrmm?=
 =?us-ascii?Q?WEJxB9t2PNjKnFASZt3j6BqwSCbdPZyYRFSIiEsGXqAxvuK2kE67Eu8s9dXS?=
 =?us-ascii?Q?BxULF4Ug2GrrTWv8rEtI0ugqjYp/L3FSIfYlKET2Qliv6XYAJshBBVXbWyyY?=
 =?us-ascii?Q?3RKTKR72FGonhXEjHPt7qRSQzFITAHd8kLsPcCjwcNjde8tiqX7TCW8ffSwP?=
 =?us-ascii?Q?MVj/Ypgp0ZAW?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d087bc-9e8a-41ee-e2a0-08d8c1694de0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:09.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHS5in64SZtOtqyJgD5RLgH1RXTySJpuwLN5rIO52WatdodVNzNebfUSQT5OZmx9K9B9O1K1hBMH90HDPO+VZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is analogous to the preceding patch ("btrfs: send: fix invalid
commands for inodes with changed type but same gen") but for changed
rdev:

When doing an incremental send, if a new inode has the same number as an
inode in the parent subvolume, was created with the same generation but
has differing rdev it will not be detected as changed and thus not
recreated. This will lead to incorrect results on the receiver where the
inode will keep the rdev of the inode in the parent subvolume or even
fail when also the ref is unchanged.

This case does not happen when doing incremental sends with snapshots
that are kept read-only by the user all the time, but it may happen if
- a snapshot was modified in the same transaction as its parent after it
  was created
- the subvol used as parent was created independently from the sent subvol

Example reproducers:

  # case 1: same ino at same path
  btrfs subvolume create subvol1
  btrfs subvolume create subvol2
  mknod subvol1/a c 1 3
  mknod subvol2/a c 1 5
  btrfs property set subvol1 ro true
  btrfs property set subvol2 ro true
  btrfs send -p subvol1 subvol2 | btrfs receive --dump

The produced tree state here is:
  |-- subvol1
  |   `-- a         (ino 257, c 1,3)
  |
  `-- subvol2
      `-- a         (ino 257, c 1,5)

Where subvol1/a and subvol2/a are character devices with differing minor
numbers but same inode number and same generation.

Example output of the receive command:
  At subvol subvol2
  snapshot        ./subvol2                       uuid=7513941c-4ef7-f847-b05e-4fdfe003af7b transid=9 parent_uuid=b66f015b-c226-2548-9e39-048c7fdbec99 parent_transid=9
  utimes          ./subvol2/                      atime=2021-01-25T17:14:36+0000 mtime=2021-01-25T17:14:36+0000 ctime=2021-01-25T17:14:36+0000
  link            ./subvol2/a                     dest=a
  unlink          ./subvol2/a
  utimes          ./subvol2/                      atime=2021-01-25T17:14:36+0000 mtime=2021-01-25T17:14:36+0000 ctime=2021-01-25T17:14:36+0000
  utimes          ./subvol2/a                     atime=2021-01-25T17:14:36+0000 mtime=2021-01-25T17:14:36+0000 ctime=2021-01-25T17:14:36+0000

=> the `link` command causes the receiver to fail with:
   ERROR: link a -> a failed: File exists

Second example:
  # case 2: same ino at different path
  btrfs subvolume create subvol1
  btrfs subvolume create subvol2
  mknod subvol1/a c 1 3
  mknod subvol2/b c 1 5
  btrfs property set subvol1 ro true
  btrfs property set subvol2 ro true
  btrfs send -p subvol1 subvol2 | btrfs receive --dump

The produced tree state here is:
  |-- subvol1
  |   `-- a         (ino 257, c 1,3)
  |
  `-- subvol2
      `-- b         (ino 257, c 1,5)

Where subvol1/a and subvol2/b are character devices with differing minor
numbers but same inode number and same generation.

Example output of the receive command:
  At subvol subvol2
  snapshot        ./subvol2                       uuid=1c175819-8b97-0046-a20e-5f95e37cbd40 transid=13 parent_uuid=bad4a908-21b4-6f40-9a08-6b0768346725 parent_transid=13
  utimes          ./subvol2/                      atime=2021-01-25T17:18:46+0000 mtime=2021-01-25T17:18:46+0000 ctime=2021-01-25T17:18:46+0000
  link            ./subvol2/b                     dest=a
  unlink          ./subvol2/a
  utimes          ./subvol2/                      atime=2021-01-25T17:18:46+0000 mtime=2021-01-25T17:18:46+0000 ctime=2021-01-25T17:18:46+0000
  utimes          ./subvol2/b                     atime=2021-01-25T17:18:46+0000 mtime=2021-01-25T17:18:46+0000 ctime=2021-01-25T17:18:46+0000

=> subvol1/a is renamed to subvol2/b instead of recreated to updated
   rdev which results in received subvol2/b having the wrong minor
   number:

  257 crw-r--r--. 1 root root 1, 3 Jan 25 17:18 subvol2/b

Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
---
v2:
  - add this patch to also handle changed rdev
---
 fs/btrfs/send.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c8b1f441f..ef544525f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6263,6 +6263,7 @@ static int changed_inode(struct send_ctx *sctx,
 	struct btrfs_inode_item *right_ii = NULL;
 	u64 left_gen = 0;
 	u64 right_gen = 0;
+	u64 left_rdev, right_rdev;
 	u64 left_type, right_type;
 
 	sctx->cur_ino = key->objectid;
@@ -6285,6 +6286,8 @@ static int changed_inode(struct send_ctx *sctx,
 				struct btrfs_inode_item);
 		left_gen = btrfs_inode_generation(sctx->left_path->nodes[0],
 				left_ii);
+		left_rdev = btrfs_inode_rdev(sctx->left_path->nodes[0],
+				left_ii);
 	} else {
 		right_ii = btrfs_item_ptr(sctx->right_path->nodes[0],
 				sctx->right_path->slots[0],
@@ -6300,6 +6303,9 @@ static int changed_inode(struct send_ctx *sctx,
 		right_gen = btrfs_inode_generation(sctx->right_path->nodes[0],
 				right_ii);
 
+		right_rdev = btrfs_inode_rdev(sctx->right_path->nodes[0],
+				right_ii);
+
 		left_type = S_IFMT & btrfs_inode_mode(
 				sctx->left_path->nodes[0], left_ii);
 		right_type = S_IFMT & btrfs_inode_mode(
@@ -6310,7 +6316,8 @@ static int changed_inode(struct send_ctx *sctx,
 		 * the inode as deleted+reused because it would generate a
 		 * stream that tries to delete/mkdir the root dir.
 		 */
-		if ((left_gen != right_gen || left_type != right_type) &&
+		if ((left_gen != right_gen || left_type != right_type ||
+		    left_rdev != right_rdev) &&
 		    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
 			sctx->cur_inode_recreated = 1;
 	}
@@ -6350,8 +6357,7 @@ static int changed_inode(struct send_ctx *sctx,
 				sctx->left_path->nodes[0], left_ii);
 		sctx->cur_inode_mode = btrfs_inode_mode(
 				sctx->left_path->nodes[0], left_ii);
-		sctx->cur_inode_rdev = btrfs_inode_rdev(
-				sctx->left_path->nodes[0], left_ii);
+		sctx->cur_inode_rdev = left_rdev;
 		if (sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
 			ret = send_create_inode_if_needed(sctx);
 	} else if (result == BTRFS_COMPARE_TREE_DELETED) {
@@ -6396,8 +6402,7 @@ static int changed_inode(struct send_ctx *sctx,
 					sctx->left_path->nodes[0], left_ii);
 			sctx->cur_inode_mode = btrfs_inode_mode(
 					sctx->left_path->nodes[0], left_ii);
-			sctx->cur_inode_rdev = btrfs_inode_rdev(
-					sctx->left_path->nodes[0], left_ii);
+			sctx->cur_inode_rdev = left_rdev;
 			ret = send_create_inode_if_needed(sctx);
 			if (ret < 0)
 				goto out;
-- 
2.26.2

