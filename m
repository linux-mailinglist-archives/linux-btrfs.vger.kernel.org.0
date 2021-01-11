Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2432F1E7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390706AbhAKTDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 14:03:34 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:14190
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390703AbhAKTDe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 14:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpfioXd78TrFGWrQ9Vg3ZMKz0DjwT6+WjMXopvNUJUCVHLQmA9AqR7U/eYWN1nALIwDVgEPjf/mxzUPiSZ48lv3LHPFtWjpZby6DFkmDCPdbDioLlV8y6YxdsORRxATp49DGxu79RtzVznGQNrlS7ipvBFPv6Y8EyrXBpgOzSSy9fgbY7KcMRhFoQTfOXYtsBrtW7jpWCHP45+AlHXYTtkIu5LeejIkeor1NbqdTDGi1y7LKh3xUVkuB6l1uF2UR0TVIGDv7g5FgpYO+9T0vEAa0bdtqLrU4fut4hjvQUr2gbJH/bFQvr/EMzis4vyFRwad/uhpkmKcN0y7P1MxP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8YcKYH6HpPtthGXPtsOE/n2gx/TK/J0nnUvuu3/oL8=;
 b=nACm2NX0ELSeHDOqcK6zzuFSHMgYr2z6WGfJicm46R5B6MMxQG075sDPWvTWBBTUPcqTdUrsAi7dvVQuSVRkUvx5KaBYsN67kEPOLZTIw9MZK53KM095yXWFLDD32kbIKvbSrcSqmkfM/BooeUvifCNGtJ5uQeyO17m4JNbC7naiYR2A4hm9KDhKWqCsIfvJoYt0RrGpgUQVGCRFM+6GG2NVfjVcAQSeaqSCuXmo34ex/geiECxYLvi1D3uNX4iHCSQQGjbDXDk+JI2cs3PC6gCLRrmmdWYYzA4JjA2XQQyCj121iu52AKrQYdrKWyk5SJrnb6qjcTGt+1J8q/5jBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8YcKYH6HpPtthGXPtsOE/n2gx/TK/J0nnUvuu3/oL8=;
 b=QWqM4lBR9f5OKMypvRXT2kcPUzUG9KtiBoeuzZBgF2iPUkaXEtbG7TZYk21Vah9ejIbLlzN3jV4hFQNLtHf9Tj2Rn6TEOKA+neEpJJIg+DE/xKwD8KLempHc8Jf/CHLQZRzDbcXAYqnK74BaRVyHcuczCI3ZwwJtTc55losnVq9JRfScFET5IHCxEhholdtr53TtdAUQzzLdZYhnlxr4OgEpJho0P+ybGaUTCgFqBh+pUeQ8hJpDZHZ2WThxtHX16CE9Ccwzpak+Sz5WkkTcb1ev2gEyCpdjHybzve+dTN7rSJQpjQYNukFqW7/MFLFHycBHsLBK1ggnMcXpXXPXqA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB6PR0301MB2520.eurprd03.prod.outlook.com (2603:10a6:4:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 19:02:44 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 19:02:44 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH 0/2] btrfs: send: correctly recreate changed inodes
Date:   Mon, 11 Jan 2021 20:02:41 +0100
Message-Id: <20210111190243.4152-1-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM9P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::14) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM9P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 19:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37039316-9647-4d2d-6c41-08d8b6637a2f
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB25201F1709EA407E8F28CAAD94AB0@DB6PR0301MB2520.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bta+9aq/gnJ7FnNe1S09k4bd7duafOTWAbCvob5oB9EBsN3vl5vzOqJh3IPbXiB/FTz/O5QXcjk7721PP7xP0gG+NADvJRZ3dF2rlRLTfDZAVbnEkUeTB+zPywDedFdAAjxHkWREebuxj2p7eqJWMoF6KhQgWPstHBISfc2ZlMSuQu+txYbptuViwI1UDX1FV+JfivMleaCw3OSPZSfKNiCEEFYLS7PTjHAun+yepJVJu33Yy/82v+sJi8vYAjs76OBfsyvV9ygILZSuQDzBqF00YBHqdk1W6ppv+Ms39CmqaXwIMJUYyToJ2r9QbOuJa40kxmtudCfZe+OP9DV5cr2eq5DpY0TzrzKENcQzQeC4d0mwATXOryPVoTY/CMfR218paiSEh2VERPnXsEvrtzKYfg+XqUc4gcYai0x28KJ6JNxUTBDLg87U7hGGu0X7Hz5q6MDvs3cHcDbhaaWn+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(366004)(376002)(316002)(786003)(44832011)(66476007)(66946007)(52116002)(36756003)(1076003)(66556008)(83380400001)(966005)(2616005)(107886003)(4326008)(86362001)(5660300002)(16526019)(186003)(6512007)(6506007)(6916009)(8936002)(2906002)(8676002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9XG7PTELdH81e2ga75BZN9s5t/HxDJ9EUFZI/0aJVuvJwU7iFYqGxyQzE+KX?=
 =?us-ascii?Q?88OByRjfLWkeLmXyY+zO9i799ozfN4KXKUybfvv/M+PGCz9x+mgHvddoimHR?=
 =?us-ascii?Q?CC0WIhBUbPyHJHF8t0v3jzByuzqpL02AJu2OiFIWveXGyAcAbzBeJd0mylu8?=
 =?us-ascii?Q?690jkQTSCCMK/eSaFn+JNtx4gZI4dpBEai4cakKcnXXfFwa18xkJe3dkAlH+?=
 =?us-ascii?Q?SsrKZOKKexZ2YNmdUIS6mDsHodCcf3GkGgLKYyo73vVkRMcOZ+eH4I0hTYBQ?=
 =?us-ascii?Q?ruhCPaBGIkVAH0dTuDzWx1f/q+b6MxdkEGzt9+S8Hd+pdI2o7mCbOwhgw/on?=
 =?us-ascii?Q?asBNeNMrZus020qAKi9b26qi/2UgBbEApDmXA+KqIjHDA8l9egkaGIbRaNsN?=
 =?us-ascii?Q?wOJTbQpBU6CFrR7NhQhK9WEuYt44pbS91amkvWf4b+syWG2hqTIZF8b8Sqf8?=
 =?us-ascii?Q?tuI36N6QSczE9+3TCydDXtgR3D1VRbqbMunz7O+99UuGckpXH2VnwG0fa+a/?=
 =?us-ascii?Q?qmlZIwK/93uD1O5N/zsZ5R+LFclsGQuNIIOfnYTh+FenwcSUsypNy2j6i1oz?=
 =?us-ascii?Q?fQ3t+6cD31hBXQxkzKC1g3U2XXa7jnAeee0pjXZ8ULAaX4snqEYwSPaNW1km?=
 =?us-ascii?Q?2dAfYMxsrJyzMZ8BSpLHWMgKREIFc0EZCK3KzBgK5KNTMBDb3q1W/+3vUGv6?=
 =?us-ascii?Q?fTBEJG4Kt35pUiIoFRSWvcBiMMSSzAge4Fd5k2zCU5Y2Gxn4tgXostamHYkQ?=
 =?us-ascii?Q?AZW37eUKuQ8reGn6lkIOeBxadjM48tJKA7rX34XWe92Jxc08Oa447oMnBt83?=
 =?us-ascii?Q?4rnuibH5NyEvK8FZbyCZzjaXKPq0lF7d7HPxEUeJBwQG59ZL4+RWEM8BJ0SM?=
 =?us-ascii?Q?fMZK+o92QyaltLTeAJdSoC2EE5YG2/ByNp1dio9/g+Mq/PMqje4tzAa2jdho?=
 =?us-ascii?Q?0L6hQsj5ysRdFKI7mnernLaZF7t3WaBP5xk3Ek6me4RGGcKePY/8FsKoql57?=
 =?us-ascii?Q?D4p31/hE/w2GrxmUky41TrR5OvvaEQcjRjOq4Xy8yWAYcXI=3D?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 19:02:43.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-Network-Message-Id: 37039316-9647-4d2d-6c41-08d8b6637a2f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zLUi3sTJM+j8T+yWXOCUFO9A7CCe4KETtF0x2sVn8FVAvBuY0oAI4B0aCD8h7UGXTZ0t9psxKWj3x1kiQ2LUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2520
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Trying to incremental send and receive some subvolumes I repeatedly ran into
errors with btrfs-receive failing. Taking a deeper look into the issue showed
that btrfs-send was producing (semantically) invalid command streams. I could
pin down the conditions of this happening to having inodes with the same number
and the same generation but different inode type in the parent and the sent
subvolume.

The cause of this was that the kernel code for btrfs-send did not check if the
type of the inode changed but only recreated the inode when the generation
changed, too. Having the two inodes originate in the same generation though
would produce a command stream that causes the receiver to fail.

This small patch set adds the check for the same type and causes a deleted and
create of the inode if necessary.
For this the first patch renames send_ctx.cur_inode_new_gen to
cur_inode_recreated because that is what this currently _actually_ is used for:
detecting whether an inode was/should be recreated.
I deemed this refactoring/renaming to be appropriate because the second patch
then adds another condition that will set cur_inode_recreated - i.e. if the
inode types differ.


Looking through the code and developing this patch I also identified an
assumption that seems to be hard coded into many places and that probably caused
other bugs, too, e.g. [1]:

That people would only ever incremental send read-only snapshots of the provided
parent snapshot that they're based off.

But this assumption fails/causes bugs when send/receive is used with:
1. snapshots that were modified after their creation
2. subvolumes that were created independently and are not descendants of each
   other

(Although 2. may look like total nonsense it actually makes sense for
independent subvolumes that share some extents e.g. by cp --reflink or some
other means of deduplication.)

Thus I suspect there to be further hidden bugs for very rare edge cases
especially where the generation number is used to check for differences -
because taking 1./2. into account the generations between the subvolume and
parent may arbitrarily be smaller, equal or greater and as such does not qualify
as a good indicator for change detection.
The same is true for the inode numbers.

This makes it also connected to [1]:
"btrfs: send: fix wrong file path when there is an inode with a pending rmdir"

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?id=0b3f407e6728d990ae1630a02c7b952c21c288d3


Roman Anasal (2):
  btrfs: send: rename send_ctx.cur_inode_new_gen to cur_inode_recreated
  btrfs: send: fix invalid commands for inodes with changed type but
    same gen

 fs/btrfs/send.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

--
2.26.2
