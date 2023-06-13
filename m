Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6186572DF63
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjFMK2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbjFMK1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7E1BC7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65cbi008791
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=3y1Losli319z2JzUomKwS4fKPVYvDDrivnxCdqSSqHc=;
 b=qHK+MKs+5baUlC8xyfEn5141xYFxTckuOfB7vLzptHzRugmNbQVnV5znR1s0lTiPvprL
 bdndQapHAtECryf/2t3oX4ugDt+G1wkCNtB4+S0dTbSBlmMRQN336cFPIrPdiEUwi5el
 uC0wTOTYQwnuMJ7CSwnkOEz02XWkfdRcXC4IPMDIIHSk0Jv76+kpYbztcjFXwA/Rd0U0
 eAPayst8EOVh3cdAbG4PETDJ70SXUtOkpdiCkM7meEMv6Nxet/Qn4kB8+SXjK3uwDxT7
 7qbOfFc94kUPRz5LCTosS9NwOYJ8tntpzGIeT+T1eXGMRTiheL94ix+ybjJHc8G8LPA+ cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3cw2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DA5f39008927
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm47v8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmWgDmbykG4sDHmgEq41XKMd0FX1OQGlj6JjfmK5OGn2VzEIa/WNlgiCHD6LhUGPv0SWSyWOzd/U0+jFgkesYOp5DBlZd9dOzcFQr/4LkgmKz8LWlfJQH1x+x3NlQE0yZusb1Y3NxB9l/PlMrXKFGQ0mj6nrHT4eNlRntS7OYtS/ci4FNRhBQV5OShf6PWhcsK8XBfJuiSBOmvbsMuJHuqqVaDpeS4rulnSoFXgn0rD/487tDmY8BT1qmYhHUK4ZmI6sFV0FlaHZ6+OKLC5EufUyaSywSEvS7qqsdnz0UlZsLZgbepn8Xq9Dc2tAoByoNNjhplrqzJgx0jnf32EufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y1Losli319z2JzUomKwS4fKPVYvDDrivnxCdqSSqHc=;
 b=mHFAt44wt9oITuC1tXkiqMZjdHMLr4jUrz+l4P90mRh6trDWqIlVx4Qn5EqY9ZqJ4qSUcKxmvO4CgBz7RkLrwRKF89GiFriHVYoKXUwYABHQdC+kXH4TLRU7pAhjw3/QhU50X6XycvvvJymAKBsH8kXkqbiV9IES/nbkM/050twIWoGH2g/67UQpPOZ/yvun6rssaGHNA4mWpDYVcbPcJxu2OL9DXGHvFPBS3siG4bxSOQm/i6A3JJvWe6v/7hX9ZdBcj4l6LQyDZE4DrxKogbRfirlynCildptSEmlVoUK/XohKI05wwidY9ZKD6swIN4jGJcKOBVZDUucSlDZE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y1Losli319z2JzUomKwS4fKPVYvDDrivnxCdqSSqHc=;
 b=yNi7xl9vkgVfxdltP0EkpJGZH9g0Sz2E1HnhMdRNqdYuiVg7FlDHap2bYUvO403K1SZzd7qpwa7TnpIWYn3YgZh/t8vTyNI7NpGOwABJ5QTD3urkxMuCGv7CoCUiEoEzQSs6Y38OVQo51ReA7PDJ8MHBoan1lIlV15PanNiOxdQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:27:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: drop open_ctree_flags in cmd_inspect_dump_tree
Date:   Tue, 13 Jun 2023 18:26:54 +0800
Message-Id: <672f8622c658d14a2168598c4bb51cae1bbadf7e.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: e0214850-ec7b-4b7b-9171-08db6bf8c951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FppYduoJkbafYC8RPVkBKUH8lbbK08Yb9zG+leQNu/xHA2xdQmQ79LBtiGH9/qRbF6niCbGYHLChJJ+8j9tzs9+mpSoC36ccEMxcIlOgwHor4iX1QK48N+XBxjxuWcM6OOD1WaN/s0w/TR5v4qG0TUrQNWX7LOI3I2ayDBmT/LNI4t2MZ2ZodwIQeBAoptyR9VOk9Dh5HS8YKSQ9SE0gJg+2W0hT97YrpLP67k0zdSYAZ3XMjQsJuik+VBSHRpAD3nIWp0rVuzLVOtxNtAuAVFYOmZP7VRkePII+0VBLuInq1FrzKIs6gCz8y/6DUWb5c/gCvTCrHuClIGORguIwvX81pwZ8c0YW3/jm45IlWObS9ga2KixJUzPW55QAK0Gz2h+v1UBSn+fzOOGuISmrOuDPHOyD58DlFvyNJdf+o96Xw0VsY7nAiOWg4ZEcgvnf1ruUdZifpdLSTKiM9wgs10q2TgeKUAZ3VPahfmnqb4mFegrucMRJzDCY19b9FlVJpdP9NqMsYEpAFyjXzfa3RKinRTb+LeNSodECl1nH5acqk9DdOGb1KgRBF3hKlavy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(5660300002)(478600001)(316002)(6916009)(2616005)(8936002)(8676002)(66946007)(66476007)(41300700001)(66556008)(186003)(83380400001)(6486002)(6666004)(26005)(6512007)(6506007)(44832011)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lMiKk/LVLeHTSEXiMnClcus2xAhJykCE+M/zF+bhX6+Hga6CSYOH6Ch9THo?=
 =?us-ascii?Q?lgK1vYjqGqQFpKppXRJjN7flHw54BKXOMpednpZfwDqmP5oi+uBFw/6U4Qe6?=
 =?us-ascii?Q?N2+LJs6fe0T3eit2/AajA04VrOk827Wt0FU0RpUaeRMCoWEOYMmy1RxwG1Qi?=
 =?us-ascii?Q?txwgu2PY+6JzR9ery9WF5uwB0AUNO/8Rgkka4SKhtktZIav2UiDj3JvmW9O0?=
 =?us-ascii?Q?FyyUC75wVdMHGHhcI4b0A/L5IlnUIzUf2Eephgxfvwdgh2B8YSoKo+LcVubQ?=
 =?us-ascii?Q?Un4WWv1DCPLVqiexMAAz1GSYQ4OOR7hX30kWuPnsxPV8yhUb+prhTyWw0yeT?=
 =?us-ascii?Q?iklJWa0+Ousq2nXBzfr9DyvcRcHVbzqDSRnwXMGXNr+GUqNqawBUw1Nmu5X4?=
 =?us-ascii?Q?DLwkNVcdOvuLNsA0sb+j5a6YA3AP0O3hXhE8v9j1VrK38P8MDiWi0RYNs+P0?=
 =?us-ascii?Q?npWFPMpMba+ZmM2Co+jtZgjd2DRlPkehiY/1NhVYfG9nXhnvD4bqjDNtwwGg?=
 =?us-ascii?Q?cVpuxwsiKN48pWISBJjJB623G6fulnSyuChtQ/GrBG50JmI/gYBNcYgGB+4D?=
 =?us-ascii?Q?smm0vizgyqXBu2QdtGbWIi13wPi6kBA3tWXA+vSQ+YcTP7tS+aZ6e2vXStQi?=
 =?us-ascii?Q?LLgXk+BwpV7+xjFnsqXYAW+SKWzpoACEkBYww7xJYdxEEDwNXxS8xuevrHUQ?=
 =?us-ascii?Q?NzbCvZ3t3TQ7k/1gqvFIB9R6yJy3NNPP8iBMqC/UbzbQcOn5nPc9D0ysIeu8?=
 =?us-ascii?Q?jy23yRB6cBVSDU3kFCklE9EbsMLxHpAxI+x2xuZpqalPt1VN8AFrCK1FpITc?=
 =?us-ascii?Q?xcZwa8FhIzN2ZGOd7VzU2dXa4iJE9Lnfz+jzkCm6jSlJST5Rn8PZY5RLkeTW?=
 =?us-ascii?Q?rlkhglNXrVyP2n67J4/JumvDOHaqkARAbcbyzEaxO6uM3nzSC/YQ+txv+zkM?=
 =?us-ascii?Q?5/ftBBxYVK7GhQojm8/piaUazFWD9MzEqWCIok4P7tAyG+EuvLaK+7NS6ETk?=
 =?us-ascii?Q?bxJ7KTGXxvdlgTkIVZb4NjT7XlRjBWgM7F6ihvZxzXlFkiiH8ndKYCd5YEZe?=
 =?us-ascii?Q?31g1AuUriyBvBqfttXAptcGiRbwy936I7P9B54fTPlyVa1uAsMT77YynxI4Y?=
 =?us-ascii?Q?rFALQZE6/yaEkgaAMfXAh0g0sh/E/G2cIsOdhBWHQkKQJ1v7rb2rlDPkUjYt?=
 =?us-ascii?Q?JNayJ1HdKoxQP9qZHDR+/XknFGJ+jmHqS3+FCyEFOQQ3xUghG+c3OvBhzRW3?=
 =?us-ascii?Q?u+DY6QrdKsigSkyWtIe3eqI9REOr/7U+2jb0GGZPlatOouEpUdK3PPO1KhJL?=
 =?us-ascii?Q?AtJ/iV/OiYwGPts0xNoBAjqt0advemkQjDYIrUwefbfwkUfYXNJwTPLNSOZb?=
 =?us-ascii?Q?PA/1aJiC/Ysh+pE/1pAC1bqPKJ2fCcZlH0c4s7fsmiQb/XDJhxO71Wj4ozi4?=
 =?us-ascii?Q?0l+Yh5axjCh7qBMZEi49co6ClFJ407sS+PzIHJIm9yGFLsiewZe4/GKhjwBv?=
 =?us-ascii?Q?SGTkIQxRcnj7hRiIhajIkL2s0n+20KR2lqYfRDz+SAEEH+8H7IODacXNS+Nx?=
 =?us-ascii?Q?i1Chi5vuwf79E/OT4+tFQ4MH9ORymdOdPDx8x2Nc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LNEgLFpvMdUB3IMB3BYvD3P0i5pKHjzP0UeN0kOKJrde0tI0sfjrFqefM8aeXvo+ub/FqV9lYTCZG43hekpJGsbzAfB6FcwqFs3lVDWSmDli3jTT7k59wuYuBOFMBkBJwgpNpjAx/9dv78UDoB+0dqZ7xrvYtPdRV4ykKHTQ41QoqD+5jIC6rpsycrAgVLy70XICkUBZjKec+TsLUrwGOsTwnNfD+5Vo2fz5OS30emjsJQpCEjDkvjnKoVyR07JEDbgAx/83eREhb1ztZuDnKx/omuWeX99qvF7qODqDt3N0PpeRlCCBuX/nCMn/oF8NwFWPI5B0N5GaAnoKOdBZ1d4hB33GsJ6tiTmV9tz5Crkfd9FsLVgnm1VrsZAKm5K3NcNXCV6FM4CDH2LbASG7Oq+cm0gkbSlyMieQ8tPJWZmHQDKaaqzVa+tDPNXkqEhHeX95NLrd2H3T6/7aycR+LhgsyeXl4l2ZJfyfiXu2xIdVdHynsc10TWTkbvviB+nOfqWZ31YkvSUsbE28JukLHSGPJWcgB5TFqzK+p1RhAsS7s3qfMo+VXQ6encC8SyT9aDmbJu1+ay0HwcBI/I+0Sgt0wFJljEOaxpODOtjp7PXPMn1VmXwpKjSGRIbm+koH0bOTRJFJKQbkl4peBKuemEeyE6VZhr0t9wqZFksAuQmDD9rm4MGJ/LQLkpqolTw9hcP++zakHR8u+xBxaf8rRrlTdpdmopseRBpUQTNG0n4Ht9uiZwBaEus9HQrU9wZ53zKjawv5HmyT6oSAoDIfag==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0214850-ec7b-4b7b-9171-08db6bf8c951
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:27.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II2TdA/g6yRIG0dgwIO1s65CM/dyldLb02cov/FKNnSmOAHqYUgWHj0rYO87Aavu+Sa/ptX3Huv9uAWZtMLLLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130092
X-Proofpoint-GUID: 4MqM3lvItClS0sud-2gJTwyK8wzi1b5B
X-Proofpoint-ORIG-GUID: 4MqM3lvItClS0sud-2gJTwyK8wzi1b5B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Local variable open_ctree_flags carries the flags whose final update is
for the locally declared struct variable oca_flags. Just use oca.flags
directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-tree.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 4c65f55db014..1d2a785ac5c3 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -328,7 +328,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	bool root_backups = false;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
 	int dev_optind;
-	unsigned open_ctree_flags;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
 	u64 tree_id = 0;
@@ -346,8 +345,8 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	 * And we want to avoid tree-checker, which can rejects the target tree
 	 * block completely, while we may be debugging the problem.
 	 */
-	open_ctree_flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
-			   OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
+	oca.flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
+					OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
 	cache_tree_init(&block_root);
 	optind = 0;
 	while (1) {
@@ -400,7 +399,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 			 * If only showing one block, no need to fill roots
 			 * other than chunk root
 			 */
-			open_ctree_flags |= __OPEN_CTREE_RETURN_CHUNK_ROOT;
+			oca.flags |= __OPEN_CTREE_RETURN_CHUNK_ROOT;
 			block_bytenr = arg_strtou64(optarg);
 			ret = dump_add_tree_block(&block_root, block_bytenr);
 			if (ret < 0)
@@ -437,10 +436,10 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 			traverse = BTRFS_PRINT_TREE_BFS;
 			break;
 		case GETOPT_VAL_NOSCAN:
-			open_ctree_flags |= OPEN_CTREE_NO_DEVICES;
+			oca.flags |= OPEN_CTREE_NO_DEVICES;
 			break;
 		case GETOPT_VAL_HIDE_NAMES:
-			open_ctree_flags |= OPEN_CTREE_HIDE_NAMES;
+			oca.flags |= OPEN_CTREE_HIDE_NAMES;
 			break;
 		case GETOPT_VAL_CSUM_HEADERS:
 			csum_mode |= BTRFS_PRINT_TREE_CSUM_HEADERS;
@@ -493,7 +492,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
 
 	oca.filename = argv[optind];
-	oca.flags = open_ctree_flags;
 	info = open_ctree_fs_info(&oca);
 	if (!info) {
 		error("unable to open %s", argv[optind]);
-- 
2.38.1

