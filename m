Return-Path: <linux-btrfs+bounces-14064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69065AB9447
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20FD1753C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3D25C82F;
	Fri, 16 May 2025 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xgb8OGWU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A70257AC7;
	Fri, 16 May 2025 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364649; cv=fail; b=b07EhwFMKNnxMjNeqjXnx4dUCLt8Ec/G7smX15DFKqTz3v7ECJSZEbZWXURDm/tsOFu0T3FYgYdZQ8bP7/9Jjfr2yCdGcoKOLteoGGVAvPn0RKEItPH3bbq+rogQa9nKu0+/hCM+cS9TdLQZJwHSHGearb/ONsm9Uf238xzt3Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364649; c=relaxed/simple;
	bh=RCacHStNbGND8rQkSSV57cz1NTfLh81EovjpypvqP2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSp0WLiw+rny4FrvVobuLiTVj8UHnSrCEnOLWrXcuGCXQyyltKfCuAxXJZg5kWxptTNF3TRJyGrmlOlJDehJBKkzVCG3Wk8O/zd3fbEOSxXMNxD9p7kxfOyaAy1F7uzuggS0vv+uj+WukpDPKUKSbBUsdC+94bjWr5tzfdaUeWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xgb8OGWU; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0bQPGvJPC1aJaYMod7fuZIKIYSb9vkfbwWDn+tLBO5h0lC2Fm8gEQBYdsS7t37vS4yOzZlkv4cLu3btUIQsQY61eFD/bMZixneItRjA+XUCq4MAftVnEXhF4CtOtdj5w3v76bplhtqeaPCrgYyr19EoqoTPIGxNd6HSn/JBGZDiwRarJMsSNVOfCDeBmNg2CGhq74lrYQYHLwEwua4tKIkOoikrML6PKHgerprBKvNgryW/c5tKKy6+nM83O2s+I0c/CWhZHTyTI0KAHBAvhfvKuGJCNKfmEW4Y0CKCKwSI8tKyDUpU/ujyNvn7dpyFEp+1mmg3bd4Z/yjD6aBWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydF4Pf+Gnu3IrrpGZE/peTAdEl7gAVQKVQ1T4llvfWY=;
 b=RnqCnMRnv9K5P+3L/XFlQX7ti+9EwpwNU+s9OalKZdTz8Kmx0xlzoDcPs7ixll5wNsMV3G/EmQdL3+MMvqll7UAR8nqWFi2esnv/jtJaASgusSiOmBZnOEgjLQOoqxlIFrqolrjhaWPu1odgqctQrmh1tGuR6Qr1Tch7W0Bf1cfvBWR1hBisYshNrc0HNic++Ti2xfaxCGet9BSLnLJ8F5n0UQI3+O0+ZMsJQUBoLYTYfVjZHS9c1opBTNrrjurHppQItBQ/jMHlLQ0WHejHTVEMjVznBVlVHCMQnQZyAEJJpmsW7zDWcJdZTX7EJMuICxvJdKDvtWiklQSHyGhRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydF4Pf+Gnu3IrrpGZE/peTAdEl7gAVQKVQ1T4llvfWY=;
 b=Xgb8OGWUNjXDJuUj16uz3o+i8iUEWtBTwwMrlMD0hMEGZcq6mRvS1FD+ZQM1AHnYdCJR0uBfz+xOgFZyJ0xNaj8kgM+5rB1mBUrtgoOwuAprRmIRWP+BYmQ9OwyJOLPnKAiQWAjwg1YybuMKLvnwlxuvjvuNct2eevIidANQxiGaXCYDzDEJ8goSiEhpVmGaJjyffVEMHLGkx16wxBR+1v4lTbTe6yVVXGFiYRHTOi2izI5rE/87VXrNNFurqhdgyCykO/8bQUmXEsMvKhoBC5d6YYU0ZSBt/4RuxGJtXzAlTmqY1oyxjIeVyiiUxjCJtZ50Ei1u6FfaNkjmPvB2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:04:04 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 06/15] btrfs: use rb_find_add() in insert_block_entry()
Date: Fri, 16 May 2025 11:03:24 +0800
Message-Id: <20250516030333.3758-7-panchuang@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250516030333.3758-1-panchuang@vivo.com>
References: <20250516030333.3758-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To TYSPR06MB7646.apcprd06.prod.outlook.com
 (2603:1096:405:bf::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7646:EE_|SEZPR06MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad6fdf3-ec82-4754-5350-08dd942650e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+oTisufCs0BMXG5s9haJM1px2OJCQdRbHUBQ0ln3uojMqAyMUklmkqJyiQu2?=
 =?us-ascii?Q?aCCQZIGDWEe8qsx9uEoOLjJC0713o+1Ag9NqompcHXVN1KiS7s0iHL3epPsz?=
 =?us-ascii?Q?/dKhWldl/z5TMom7OmQ3/OllS0gTpN6rtWJSEEkWyunXCHtwIknLvFoIFkJW?=
 =?us-ascii?Q?m9rC1684zil2kG6KKo58fWtRdbX0Ld4av/m74VNtVyCR1bchrRM/t1RocXM0?=
 =?us-ascii?Q?9lVDcoF9oeDwmRyrfmU5qszZ5HmTnLbgtqHxl+X6LD1A67YPHa4U7j7gvGhy?=
 =?us-ascii?Q?FDJsXc5F7l1gh05okrVVgw6bAWf+7uBkitdIhu9J/Ixy5UbFtW0FCtbtENwV?=
 =?us-ascii?Q?aw93KTYqhnk6ZfQaXtAltKOCCucSXcA7kAKsTOm6GuRcBY66liv81CKyoU/M?=
 =?us-ascii?Q?PpvbHi0PG+a0iEpgXzwNIoacaoec06WjgtfRTKe45ob+WVmmIllev9H64p0Z?=
 =?us-ascii?Q?M27a/6/333ff/L0Z9IuIw6P7ckoYEPXEZNM+e79GzARTiptsiNrVJx+TAFXV?=
 =?us-ascii?Q?py3pqwg68H48DjZhT0abVzJVilyZXdSCj1gcFvwvPlhtwt0q6P/OYOhhfHw+?=
 =?us-ascii?Q?f98i0zDFoFAnMlBXhWKtL/3c5vjwevEsnhEFR1ByAunSoysewC71j7P3/Cc6?=
 =?us-ascii?Q?uqYjJfmzKGTyDGF6XzdvrdnyOw6RsI4bNv0IeQ07WW+4EC6/Lqol0LJWDzMb?=
 =?us-ascii?Q?uzNkRcn6JdJjXg/mu6bMUKm5N9Lrs3Yqycj5bvn/SCSYOaBza/nMXk41GKNX?=
 =?us-ascii?Q?aHfFL9yFrYZfpfBOBjmTuW2XJAMRTBWclfJih7m4c+NWfgd7+9xVHeGGKibU?=
 =?us-ascii?Q?eBOxhMP2a0MF8u+4e4Oa8mibvdnOoHRxKfNknSCly84XjQj8UPU2tnxvLaXv?=
 =?us-ascii?Q?WmHfBmVky7wGXFWwrpHbVALaEGgO1AeRV134eX6nNdyrwjaJLMfR0L4GREIm?=
 =?us-ascii?Q?LlswsK3jgRqIhrsFX4rDGztKC9mLmGp55fGCoK+UNxJplobyOo6BlZLy8x2t?=
 =?us-ascii?Q?AJ8AnSgK137KWTAnTjYRkIxQ6kOmNbWDJy7vQXyhu2HZ3+KR4N4+TnzRA8Sf?=
 =?us-ascii?Q?VzxLA3K3WyKfPMtPsZ+iUPBQVgayMvJjD7S3mNabqB4f2jAfqNJFCgwCvbPz?=
 =?us-ascii?Q?1XqwfU2142/fIxdmq7uVA4+0XikHY81Kr2FJd99C43Ty0dTlSVWZdaqlAn71?=
 =?us-ascii?Q?0QMRfqnZFzhV8pNRGslgcB3qb2QaqvfiTXSXr2uMsp8NTgn6fwzGStcYfI2V?=
 =?us-ascii?Q?PxXC16YG1vHQRb8yNG4zY/aC7xUvQsU8UAkZhCKyol6KDnPs0F4wsrI1u4pD?=
 =?us-ascii?Q?fy7ElGWIdITZ1+a565WKVlssABw3JgLub9ZLDALWLhbugIzPWxRcAFoO87BQ?=
 =?us-ascii?Q?MtBpGtDtQUGx8Vo3xev2+DT16KNrpvpcDsEugU2CmOzMg1ZN9bEFphWOSJ5M?=
 =?us-ascii?Q?n2jCQJBJ9Fx2Bx5x33sk/RqaMEM17pAl/WMzzjVCLjlyPZ0sbbTtaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZbu/WNmgQadcO2aLaSFNgA8H58VgwnvIfMV/Gvin/zCnJL1KVVKY1+yyYlt?=
 =?us-ascii?Q?7PtAlTGYtb4UqBE9oar2FufgMT7SrBlDnvvsTwmOSGSrxy6P6wQw0xlTafO2?=
 =?us-ascii?Q?HzfQupLN5dzVn2tshymsHx8VFCdp+Ry8pHvfA0mb6fKaBhZvedhciRHZBMpS?=
 =?us-ascii?Q?flSSe+BPLdZe+2Ii3xdcX8sCEmupa7l8Vcw/dH1rUwK3KBm9FLDtgCDwVsT4?=
 =?us-ascii?Q?QDF5wT/WxJYtwARfEUPm89CEoht0UXljGJpm1v3lBiLRRwwd1hi79dQfoZjj?=
 =?us-ascii?Q?NJoFindCSsMLhY7iMrlN20xEptaYR/M9UXwDrDyOpUZzcL+PGIKL5FEipOkA?=
 =?us-ascii?Q?QEAXlGB1a2aG0N6mlpi6nVeReWcsrhxCnsrg1lcMsVUPZvaGwCayjsX85tmk?=
 =?us-ascii?Q?meu9MI8Vrw99/nIbLuWD4D1JWzqZyivZ9Ma3u5FJSQ6eV3AYPHLzwQwSaqz/?=
 =?us-ascii?Q?BqadTL6mUObe0ZOEh1wkD0loiqZDaHxyH/1rbNqYbHNMTxF35b1iEtbxXoiO?=
 =?us-ascii?Q?nFE6inTt49yD6vIZI2Spqv4MgUIOJKyA3Ow80eBr7d6tjwmRp3IOHz/vK4ZJ?=
 =?us-ascii?Q?2wXPm7X74ZRD0eKG46osUeiKihQVs7f2p7utQX19QL0Vxw7ZhznZ70oG4ky0?=
 =?us-ascii?Q?ZV/KrObf6+ju0OnuUOJklnujEMYt13L2kBxrjxsKoAN6Gru03rvLV1Y7Uv7f?=
 =?us-ascii?Q?vdnmKXliLATiHEuvA00eN5DDsjZ85IHFEMRkRcoIqR9sQL5LIlZ+w/P22nmw?=
 =?us-ascii?Q?4za0bJ40dpDaBd8PoeAUyOkCXFpkQW3zFi2uaC/xG3uTkUfwGfXm9zGBbj12?=
 =?us-ascii?Q?0OXYlk7DMATkQ7Z9z+A+YQjRRgug/RmjT8SG/PJVpY8o26wl1jTJ7xH/Cbyd?=
 =?us-ascii?Q?5pejDO9pbin06kHIiVACBdYNhUmlnqOOvuYUMK72RhDlKj/a4N5qhRx5b+p/?=
 =?us-ascii?Q?wbOVc46Wo8+k/yx6mqBmFj/895wWolWDnrsAPlzNbk+Xlu5W9nFYKvFJPEU4?=
 =?us-ascii?Q?MpDmZVeCIgIv4h6+LLLFYo921Ij9adnaeuedTHEvzrWUmIvPrObRZepqOXRw?=
 =?us-ascii?Q?GwYWqekaNtRHTmuYS+0O9FiBSGLhB9fNrFCI8pJV59ScCgP5tl/dNscmXKPG?=
 =?us-ascii?Q?TmJIWedBMzfyqd7yC9bnL+MHe5832NmkcGnaTE6DemIKXFCL2FBydD72ehwx?=
 =?us-ascii?Q?oKZQgbQITiuYjwrKis0kyVYbC9hxKZ1aOyqPNUZpIVp2wWRZb8Bj2JxAurMZ?=
 =?us-ascii?Q?gkBErWlT6ubQYwRIQWU+VnpuzRs7UXETHf8snF53KYN2aptWwqBaL4fQ+m1i?=
 =?us-ascii?Q?z7THIFVqDVcbfztp+NBVNCZNfXwmGi0x3h3Q32siTwwTn/K45O6zSMPyWfEE?=
 =?us-ascii?Q?DhRlJkQhrOT/D6UkQE52iqUy3cf19lTtYTn4rHAmgzQhMS91pi+7s0ODxeAz?=
 =?us-ascii?Q?DNTODQ76qad+7UP2oRGUefj5gFzZp5oXC5pOceys8tYfAujqVUG+to3w+xIE?=
 =?us-ascii?Q?WondLb6M/ecR163Ps9fn6nuEJ8+uTuViGqq7ww/JQ94RSo79kyK+neMscsSA?=
 =?us-ascii?Q?sPZt71NrqKuj535Kf2s36m8zCMusdSDxaUCLxtcJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad6fdf3-ec82-4754-5350-08dd942650e4
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:04.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoVIZuxAszzDbaQodbgvlB/nMBKd2crxQajlsgdFTw4xw0dAwkDJ5f4L6PqNaA/nsOMluwDebsT6NtbXT0EWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search and insert
code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/ref-verify.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 38c1d3b442d0..49bb58ce1083 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -89,27 +89,21 @@ static int block_entry_bytenr_key_cmp(const void *key, const struct rb_node *nod
 	return 0;
 }
 
+static int block_entry_bytenr_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct block_entry *new_entry =
+		rb_entry(new, struct block_entry, node);
+
+	return block_entry_bytenr_key_cmp(&new_entry->bytenr, exist);
+}
+
 static struct block_entry *insert_block_entry(struct rb_root *root,
 					      struct block_entry *be)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent_node = NULL;
-	struct block_entry *entry;
-
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct block_entry, node);
-		if (entry->bytenr > be->bytenr)
-			p = &(*p)->rb_left;
-		else if (entry->bytenr < be->bytenr)
-			p = &(*p)->rb_right;
-		else
-			return entry;
-	}
+	struct rb_node *node;
 
-	rb_link_node(&be->node, parent_node, p);
-	rb_insert_color(&be->node, root);
-	return NULL;
+	node = rb_find_add(&be->node, root, block_entry_bytenr_cmp);
+	return rb_entry_safe(node, struct block_entry, node);
 }
 
 static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
-- 
2.39.0


