Return-Path: <linux-btrfs+bounces-13209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBFA96026
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF44617952C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CED254B1D;
	Tue, 22 Apr 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VCh02KS/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B9253F0D;
	Tue, 22 Apr 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308539; cv=fail; b=F+AfbdCNnPsm1C393RlYqfJPeFis5gRDidFjydyPqILtETYMLlHNzEJHRhDxm6LxJhJF23PLUha8xeIj4k08RWeRL90uxu2ERZ1a4vK3XM4ZPajSBkTvAWn/DbI1/iEldyefEOUKazmeEEMrZk8SziyY94aJW/uS1M34LxnV11c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308539; c=relaxed/simple;
	bh=mgnqvBx0elbgDMZav23lvMVJ6lTjeUF1I59lKrnJwDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlIiSCijGbq3k2v7cMsTN97DfsIJyITyl3KGB5JRfb+tp+pwous+K1S94VDb3j/WFaHPU1paBJvaZK4BZy8uBITRrZKBzo/z4UhnLXCSfT6LLO16a+dW8YbfHCJv1+C42CufDsxTNBsNpzX2Npf63GPbwOEgXm+o93RRtu/QeY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VCh02KS/; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoGsRRSUp5HSWQs85oGwUGj0ex1TXopUTTu8tJ6wPeX2TLt0x8UFA/z5x3v/sn04+ujJZpeVF29fh5Pe2QDzogc8bhI2bfceTUDPrlChtvNNSRvI8cU7GjcSzbW0+75G7HYMkqEczIKhESYJI8ryX1EwaoVexY+XA/Akpsi3A67RjSUmeEl6oh4FghW/7RQa8jQXRo7GhlcQhr0/v8GwkTsKHRMtMf4Ykbnwj7wulxj/HRmCIsioSkfL4EN0udCFpZ39qQaFub1iEvvPoPcimZlstCqckBYlHTmcwZ3rDu3csiz1/MwSpEuZKo8FQdvodXzZPi8tDoBEFwjBYvkrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8l/nSh9BGAY0bS8QTs7i1/Sv31kcC8faFPp36sWoSQ=;
 b=g3U5g2xZiELmFS18yuRozDGelIRRzCqNLYJUF085s5UWIKU9piETkzA9eCFww0oMu+CgcY/LFF1+VBJsgRzCEsV3ThKH3ZNyRpcb3NUd6e/2Wy+lfdtjlVkNwGaBSeyHf6gGUNzCOYuwuOSVRmkkzNNTOTYlQLbPn/MZPBFzGj7YYHBhQ/X0tD0QyAFnCRcqnmcO/6C2UUH5r8hQQ+6gEJoANVPBRxO/xCKI7PL9Z3ZFWflQLMO6NDl157qTSHKE2e4fJzXtjsXFYGfkBpi21x7+Eni10TXyugNbFa4YZ7jgxemERhtlMWPGwOej5BhrU3w1GRUXxBzMTK85tPR6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8l/nSh9BGAY0bS8QTs7i1/Sv31kcC8faFPp36sWoSQ=;
 b=VCh02KS/L9kirXe0xciXCpZFXV8Oipxbw+n1ZA1hk5LXrJrNS7xqqmDZpWGSDTr2ZiNLIIR+4ubn6IPrr6QGidg8OgEeWHOeEq7i1EGIV4fBxE14fJZovTJZvi9v/u9m13Y19jQTWoN9arEJOB27vuCI2z5M8I84TuBS44Y3P/3QTqOag8Pq7l5qEPiLF+OO0Bm8XnBtg9VnM/Y1ZzAbfk3dwZ7O82/io1zbiynKJAANCI8rp3LO1RlwQwlKmXhzF1o/DubYpkTxwsdE2CKlL1TI01BKXyqGNfZXP+n1J2BDIm5Hrp4+NBfkjxo4bpFICdGtrY8kwFOo/9FfIZLYvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:30 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 07/13] btrfs: update lookup_root_entry to to use rb helper
Date: Tue, 22 Apr 2025 02:14:58 -0600
Message-Id: <20250422081504.1998809-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422081504.1998809-1-frank.li@vivo.com>
References: <20250422081504.1998809-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: e144559d-6c0e-4767-c713-08dd81730d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+tA6Sbtfl8r4OHCO3m02jU5ai6uNOP/iTo6p1Mq8RjdbU9Cezqjo6orZxreB?=
 =?us-ascii?Q?1MQlQIsZlcpIpCPfYygWEbDM4BoT11suXBVTx27U99XPWxTcRSvjVYBrWZdT?=
 =?us-ascii?Q?NRBCY+L4leVovadkaK4kN08RuSHufOzmeGvKD29FQhiW/e/MIfmRp+4UY1h5?=
 =?us-ascii?Q?dZbqRUzsILyhb4XkkShAXPHFwfxIs5wlYcbwp7bsKhZOWWRUtss5rRFK4qQ/?=
 =?us-ascii?Q?btFwGkIDRGbC0am+7OCixNNaiSiPgdir/d0r+zD536/HC6saWWuMsXDjemah?=
 =?us-ascii?Q?Xwlz8+F6UBtAiJecvpxknI0IdEeNdixWGxuSnFvpmrUCr5ACzzZx95bVFc7H?=
 =?us-ascii?Q?x9xt04DJjzF3etbYXk5D0HijvlXbL3wJsUrvkCnbMnqa7NUmdfGymg8a8CoL?=
 =?us-ascii?Q?LQnJ7s3IJiBODJB3Gmx3w4aBfCh19nH66QLY9h++BLEyUOtgUZY9ltCW6Mb5?=
 =?us-ascii?Q?bCxzaE+pW6xgShqNcPaRpE30EPCtGb+KNZqgqf1taF4V/ZPSBEsL8IvcVpmU?=
 =?us-ascii?Q?KHq8Yh0S1/aXxjWZwvSyvAzFQm0gMmKzuubU2t4sUJjXM8Q4yu6dLKExdj58?=
 =?us-ascii?Q?Xb50fLxOJmjR86F9F4Nk9PGcH7ohnecc1ET2M3vHkhH0tQmD3dxHh/ywu1kn?=
 =?us-ascii?Q?ykVJG6GGfZFKowVn992AjlsRQIBp6ccGbNvsnbF75Gu1EW7MCTWQIeDS+miw?=
 =?us-ascii?Q?b2vKUzGLJd8ojZoXTsks+BNwDMezzaIEuB4KBXVVUx5k1HsD4+s1Dl4Bykw2?=
 =?us-ascii?Q?8ovaSoaKZPXRx0T4tv5mMjcfgk849gJ3J8179AC6WEENbRsOgzZf7G/QL1tU?=
 =?us-ascii?Q?b0PHV/lU8Uor15Zh6M+iclPaJgumunps+vQrK5BLA6USa946FHTaW4k/OTju?=
 =?us-ascii?Q?t6OF0rIAio9H0XepXXhjDdKiEDCYM3caFrhdoczX8X7PqtXICn1tk1Vkh5ml?=
 =?us-ascii?Q?RGhxFCeFUWY/kWes5Sr/NnwvwbpiZCNhWfL+mbNwVJ5WTBBpw9AHZNKyR0KG?=
 =?us-ascii?Q?w+bN8TvKnRpI9Twi6iTGQ6pE4juHEMQw48Sc/4Y6qH7/MqoZPYQoVvMMo7br?=
 =?us-ascii?Q?lPj2eKHZYe9VIApa3Wi65EL2osSpKI5yVhZxD8bWzezJukHk2P3H4Rc8jnT+?=
 =?us-ascii?Q?rAD7t5jXue8ntN903fK6xcGidLuhDarEtSSPTWRcH1dq8nHEc+ugg50RiSx7?=
 =?us-ascii?Q?jrc9xmmYxhUwtEiMXlY/5lWo2e3gV7EE1E1Yv5NCCwyKr+6uQ3ZhpHTB7rIT?=
 =?us-ascii?Q?GX7xgcihLaMh4sPXtus9sCLZWyYvg5WC5p7f4lRxi6Wx0G+xkyM9ncQXsCSL?=
 =?us-ascii?Q?4c1XGBuTx4ENEAgEMDcC69udKjyC+4RytMV7dyD8AzIhSizsAkw3tTHZbSvL?=
 =?us-ascii?Q?/2wByDqTnKJyWtTy+J6fJSII8tcdznOe3oegO0KeTQFhfzCTGOjtj8fX8zdt?=
 =?us-ascii?Q?jSFUgUGmtguiwusO000K7Ygia2wYSyo7NgtJ3sbtGeAsPzAkZ6cBog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOdoe2auhAw/ND9bcPee2kp/bPSLRvv+J/fe/nmne3DkatwnBtcNtyJSumwL?=
 =?us-ascii?Q?vj6jHxlRr0MiXuy/qEvM+Rs+po1imFDFtrJ0S8fmM/OSSekQEoj8HhInm0Pn?=
 =?us-ascii?Q?wD9CZ6uMQD+d6W6M5SFrjn763DahNIwbu/zKfZ3rksCAdVYyxyphbHEX2oHN?=
 =?us-ascii?Q?572nIY0UrkxHiI8T96ABevnvYdM+8u42qx7uAAqfrmnUOwuZrXOqOPaYZ85q?=
 =?us-ascii?Q?VF7uAdqQ00DhyxwaeD03Llwbwp1n9r9lccyc2zD2LPnrGcl5YqlzU2lR6gIN?=
 =?us-ascii?Q?OYA5TsnvYfvf9ChNsAZNU/8Al1OLXDpmQL3Z28rwntjT//McGFRIMcA7vAjn?=
 =?us-ascii?Q?fMIQbtqLl/rWlfnlGIfQlwcD1h7WaGc+LifoigB579VEd8hSlVW3MoEWAru5?=
 =?us-ascii?Q?swt5A8Zq/V+Fl5hRvDabhHokMTmBxW1hlBmfl4+fdI40dDD+VZtM2YrY06Rf?=
 =?us-ascii?Q?1Yt/VS15QhcdmaPwDD2eVSaK9xZ+D6W8tHfc8lhjSYe40LRFZb8Jr3M/fotp?=
 =?us-ascii?Q?CHdL/qgbFWk/OWkeAWrNsTsrTItZPSqvU4lyAyGXiucZz+H8RW734nML8CH7?=
 =?us-ascii?Q?GLr9TpAiTV1NGbKtcP5UcfSu8okByBSdA1ginkucHsZhx1Y07oyeyfC/XeIJ?=
 =?us-ascii?Q?XeQCFhBJkf8ZxD0SXPkSIDRzDJp4LRkeRM/phbYjFW9wFr3TdgHREiXgvfjm?=
 =?us-ascii?Q?vAcchWy9kYwSypQuYAAcCVjT4n6BuHb85bxbnXp2LLgCN2FpJpgIH7vuCxqS?=
 =?us-ascii?Q?LpTe6Udv9y3zhWNPBawVL4TirfJX8Sy3WgPsV0SOTar2UDPFi+zhRsPEt1tB?=
 =?us-ascii?Q?lmNeQD5fvLU8ymjw98Coipr7bgCcZS2L6TWENiiq/tryYXMC18IxPuswGoRN?=
 =?us-ascii?Q?9o6UhRCja6XHByamoP5CYkU27xcEPubnhBMrJkeB4CdXd9TOm7QrI1MQ6GN8?=
 =?us-ascii?Q?81GSWpDoMfVsMHoSTXRRlbrXoxvjmcyfqLnU0ZryV7l6uQi06gSA2tr8bHlv?=
 =?us-ascii?Q?o157+x3/1h6weDz7k3IOk1MExXRpBz9NVXSAAJYTUxYYuAxtd4KsqiPmfMti?=
 =?us-ascii?Q?HF49LGrSS97Jn9aESjU0NiAuooZuPJLhaszG7rXQ8Psp2kQDp+vy4CzrUqI9?=
 =?us-ascii?Q?OHMSEIOIJ2U0N8Nzd6KWro7DYL9iaFAF7d+1S1r+Znt2I8lcgXKqvmnAxHWb?=
 =?us-ascii?Q?04J29y0L3VLsQYEDPGWCeGeDTFmjh5N42Z2uXgLR+I9hyTbHW6r4+1vAmWLZ?=
 =?us-ascii?Q?D01x5m8mY82xpB8sO7XpQAGOYTi9knWrdNMPHndTMazPL0R8gYf/She42aL6?=
 =?us-ascii?Q?1FVxDQKXyIC5OLL/IVYHZ2Va62JiPztF0ay7Yx4vh3nB3gi3fh/TL4Aj4Lna?=
 =?us-ascii?Q?bTzq64oEIDmsa0670njy6QOdZUc+CeUKZX34ux3Tloh4J1PC97CVauklwRRW?=
 =?us-ascii?Q?2tWTxmUbf6myMzR/rNUqf4/CI5686mY4C2Q0qpdbIvvyoKdTV/LfnlGTEK9z?=
 =?us-ascii?Q?w1ibJe0jzZK/62Y0c1sbpHfHpmd4X3ydwRvEre79xOyzU6l02nnvLVqQqpjJ?=
 =?us-ascii?Q?Orp9Ul/DDP/BoEDV3/SODAOEiRdQ1VcF4RlBOyZT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e144559d-6c0e-4767-c713-08dd81730d32
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:30.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfR9nBnQ6jMo/DDK3guMSJnBPX/Oor8/hqebCecU9Y6riAKnThEP+s1IZn1XFGXtQaF5B8swG3pn/Dwrpj45bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update lookup_root_entry() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ref-verify.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 6113f325df82..67e999262137 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -114,6 +114,20 @@ static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
 	return rb_entry_safe(node, struct block_entry, node);
 }
 
+static int root_entry_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *objectid = k;
+	const struct root_entry *entry =
+		rb_entry(node, struct root_entry, node);
+
+	if (entry->root_objectid < *objectid)
+		return 1;
+	else if (entry->root_objectid > *objectid)
+		return -1;
+
+	return 0;
+}
+
 static struct root_entry *insert_root_entry(struct rb_root *root,
 					    struct root_entry *re)
 {
@@ -187,20 +201,10 @@ static struct ref_entry *insert_ref_entry(struct rb_root *root,
 
 static struct root_entry *lookup_root_entry(struct rb_root *root, u64 objectid)
 {
-	struct rb_node *n;
-	struct root_entry *entry = NULL;
+	struct rb_node *node;
 
-	n = root->rb_node;
-	while (n) {
-		entry = rb_entry(n, struct root_entry, node);
-		if (entry->root_objectid < objectid)
-			n = n->rb_right;
-		else if (entry->root_objectid > objectid)
-			n = n->rb_left;
-		else
-			return entry;
-	}
-	return NULL;
+	node = rb_find(&objectid, root, root_entry_key_cmp);
+	return rb_entry_safe(node, struct root_entry, node);
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
2.39.0


