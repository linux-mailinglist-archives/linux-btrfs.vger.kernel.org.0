Return-Path: <linux-btrfs+bounces-14063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FCAB9444
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915C61BA4253
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E02580CB;
	Fri, 16 May 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HDMwj6+Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF622F747;
	Fri, 16 May 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364647; cv=fail; b=C8BdSmY8f6ZXGnnfMBz1WoUmh8PYUksA5rRWvSVlVFsAeLDVT4jhNOxQ6xu0jR+dkpCiOxuGf9jODycU3QlazT4kSxV+9wIzm7UIKhCUaijzmfOjLhG8rcMofosdC6ZbcFemVUHSxjTASm5aUdXtt4IKxGozg4r+x3uZEqoJtb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364647; c=relaxed/simple;
	bh=/veSfyRs0djxI2qAhtC56Y5c/ecYHUCRA4vnLiAD7PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2me9oxoOrsvti10uyjFA+SkKJPwBEfRpBimg+1WVJdmmKJvKFy5/f9+f6QDkajnlA0KbZ3EE9cy1w1AQCezk5VzkD5x6g34Gswz4EXiWNH0y/d76+IIdAaXf9J/wG2LSG0s0l5XunjGwfHqCYb6H628jJb1XqoOuWE2Txn9koQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HDMwj6+Q; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYZoCeS6G3DY5b+5Gp6oegNa17dX9SYMCwPB+6Shw+ccvvvefUOqzGhjXqw01PnVKRHrsK4S/tE8jNuwNqIx2GBRsgwTv5gQQSpDGIgRBFERDWaD/AurQ4pW86R1qSG3RuVOPLUDs2sgXds3WA/6zjYW5AWxwzbs15wqJLpxB9mx/kc5dGkBUIVTv0FFzNr+r3Fj/FHhw32KImtqF8/DcShuKvgzPTlTaq9yL8H0ZVU2wXkLoJXxgnfdBX7dZO50ICrirmOwisgHp1aIhYo9xK2SwRXyTMbFm9aloEJafRZ18l8X6UxkEaTa0iIifMt3UxXSerzoilJgIqiQEqcqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+r1EWZrxurvB1X9VtgDQDSWkZjpA1ILkvmM8pLlz4o=;
 b=ukFx/gqz8Wa1ymhsRcvjjExewx2fXBHfIlheboYT0SrQWvd9oHu3EfTvUhdNUFVSpNP10HWwA0r/irfrE99mdQQdyifV+9dVcJGkCL+e1jHEt1hu1wpk6Je0R5TIPz8EjN4i2NNXNM3/jGBgP80xDv1vroYC9WALfwvVZEXElSB9O5HCqgmzOPVw7/E6fMFEGQEoppCZGjvzV/vv/mOJZh8iGJlvTGDoyEp9M1FbP+gqUfZcXZ1BtYz8yg2XCMI/HgXOblWSgRsCb+uf6gcLDn53h0lAqNrDeATT0TiBlY28Lz1l2hP1XnIb9CL4v3gMztZ8ZXHbmNGSpBQ/rWKW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+r1EWZrxurvB1X9VtgDQDSWkZjpA1ILkvmM8pLlz4o=;
 b=HDMwj6+QulE08kOpu+pXUUVWjaPke1WRqwTen9NBGiVHmJLQ+DieF2Zplz2rQGioPDC1VBlXdg8uG+fSZNa9hw7LG7kowCZt74ZMHF0WRNip1YkaLFQkMIjatMr3HQLfgGBhYlBhtRnkHsuxbLR9bCua/JxcY9B/dQ4MO4bAshfOPLeHgudS9r2cqT09xV7nCa0sosN9SLmgImdhqLKaLGXEgI7KwDVokm1gJzFjWkCNi2UBUrAXaQA3DSN6Ykf2C+XXZCBA1DPx+zXFLHcXm/R6yDFKNwS5PqUwEeXvF3eX5UY9g3XU2352xf2DkBaIys36a4dCxbREL1nG+qWeWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:04:02 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 05/15] btrfs: use rb_find() in lookup_block_entry()
Date: Fri, 16 May 2025 11:03:23 +0800
Message-Id: <20250516030333.3758-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89ca4871-3821-47c7-e72b-08dd94264fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGPO1p2wq5ca2i2YnqDNZ2WkZEELjP9UBQSxnccr00Mxz5WFpdZxYe7sXxWO?=
 =?us-ascii?Q?lwV3dMa+8YtWS5i6fmvuHQamn2LBKm5ImqH4JaokWaBHf7hv0MT7pS/XebQ3?=
 =?us-ascii?Q?DIFRWlbOb6nqofF/EGmhzG5YSvRAGs5GmtQDbtfoQu8dLyOX6D3aOmY+0Q18?=
 =?us-ascii?Q?RiZoxqgbqAocvKXgG8Zc77SPYOAFmTOyunh1dXKED1Nv1EhA3etlaoGVk8ra?=
 =?us-ascii?Q?N9LvU70VxbxFyvNMibRKpITCAD0tj0aV1ruJXso7+veLSoFbn6GB3r4jjTYn?=
 =?us-ascii?Q?co3izbVzDuCVcDGNn7FaJfkNGnflxA/niD33kx0LfOjrra54qqhv3tLXR5vy?=
 =?us-ascii?Q?JaRF7tyU5J9TwZ965Wec2glFK1mdJvVHlJnAhavLZYGKLVwyD5kMVp5lYlCP?=
 =?us-ascii?Q?25mQ1uEyGpXAE5kufxZ8QSfP8vqBnMBjrLFTGKLHjZOPHX+21i7d96gVN8xM?=
 =?us-ascii?Q?toJsE6Ez9ve/54qH3Tgbrm+OVxLE2okXmHkC3k3ZL59snHCWTmDm1jdeFOwv?=
 =?us-ascii?Q?OawejAOmtKvz4MFm1VQHu8a8tkPVIY1e6rlZyuBm1MuM/IkpAKmtL59tWhar?=
 =?us-ascii?Q?VT9Mq7tspW6rxPj4mFvOh+0eXeQFibbIcRmpEBzhGHrr1S2r/INAyQs+xu6j?=
 =?us-ascii?Q?cdtKSy9FvI2ontWmxyTTClg3BXmzRv5q1Ht+eUEIkiBee2TkrtjQSMzZb3HB?=
 =?us-ascii?Q?SFWa+9+WgGmLmAwc0hS0OypZW21p++x9byEUKVbwHTz7cB3GnwDYVOTs6YhD?=
 =?us-ascii?Q?s04UFIszJR2Ni/Z+6OO/29hMqSilKf8XAtiT5KX63Ls5EiLX9BzgHYCsScan?=
 =?us-ascii?Q?pwLkScY9rUdbIF2EuCCP/HdyphVdr7EiQQeJs4Ow/YA/Vn2V9bx1mSnSB2jX?=
 =?us-ascii?Q?N6hgY/9PkyV6Er8m+vfRaaYUeC7qROhkA3UskETJcNlSA3B2wW3SPHHvh7iA?=
 =?us-ascii?Q?zMniP0MEzYbZKp7yffCj8FRAW0aM1CmGgL1yxIfCbBnTE0Yv/qNAvwnzDGwK?=
 =?us-ascii?Q?L3mwelA4h2Etoz2mZfs+Wd6LC1C7QDb3eX4h+tXEDKzvG43y/6NmMfbLe9M7?=
 =?us-ascii?Q?WlxKQZM9FCpos5RI4yx3Ozd6AOYkZjBTsZIfTLR+YGCCx0+QoKCW4B+1DtpA?=
 =?us-ascii?Q?1EY93hRNQL/YhvFpR29zHFP4BuTEgOaZmLamxIzglepBhkXhNRuOV+IHpTd/?=
 =?us-ascii?Q?KKFrpI4OHRE4RvoJVw9gqu9duWE4/Rfaq7nVPLeL1eGQH5UETnGvCSoX0phl?=
 =?us-ascii?Q?jkIPh6dmmfktSsMXsxDjeoPR9NK0EBdXQgpkha0GZ38YQvogoz1IYU91lTGK?=
 =?us-ascii?Q?lavM9g4vKwTfesdzgIH2EhNds+cvQjsVuQTvr2v5+PwnTmTURX1zFLBdKuEf?=
 =?us-ascii?Q?NuiolGYC2kT/g/e3Evshgt2jvSQkMn5NnNdfkTz/ShIMTm1f3pW0Z5/L+7Du?=
 =?us-ascii?Q?kc6mjchz1lUp1QT3BLEPGF5v0FAGPCsjYgbW2LbCMwygoTL1JzEfnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mG+yMU3JOp0IU0IJpcrgAZiZhQxfiaTEkkjTKr9c62nfwfk8mlsw3A2Ti1VD?=
 =?us-ascii?Q?Ds3YuqUYuUG44zaXnQawhO8RwgBqKVGzO37AaPq6S/Hsz20Wvo2KHY3Kkh97?=
 =?us-ascii?Q?HWS4aYbiY5QK/LejfypZXUsjoXT1pLWLeWA1y4hfAbdJQ1GXjAYtMmjLG/WD?=
 =?us-ascii?Q?uvfflu+JcRh4Yu62BvPsxirgvoD/EqoY0ijzEfQxL9PF68CjnA0XDGgAmdDK?=
 =?us-ascii?Q?DWQW8mMaWmfewCiIAbpdHH5HUqsImNecRFQGrm+JMJbI4Rt5FvX3ubrsek0S?=
 =?us-ascii?Q?FeTO2nYgDgm07j5VdfYh3Gh1UiSYEDrRWvyMwzn/G9vWmrnwnENqvM0bwbsX?=
 =?us-ascii?Q?p5OasVjDcEmsNV8zyzl392eLjmhH3Adccy3xtK+sKWQmqOVtdWHhmCyvMJV3?=
 =?us-ascii?Q?O0zfEqD0OXcm8h0nPFctUw33yfev/rTHExMOYP7h2FsFjZ/y+nxU8baAfwVX?=
 =?us-ascii?Q?UTxbae0KD55t918mbKljUm2rG6/aaduCiySrGZromi9T3nZib6/UO/ScZsjm?=
 =?us-ascii?Q?0W/4dPbKuYmL0Z3xWq45WMjjO3otA+vMioLOJsqhVT2YJRXgJFKd3bNom5iw?=
 =?us-ascii?Q?NUvqa4pMQKXbH30Z3OHBQyoNfPQ9PJWgM9ZYaMdDNLSH6/tSj5IoYrTVUtKd?=
 =?us-ascii?Q?gcGATEfcct/XjC37zHLR/OQ+9Gq1gij9XczPtj+wj1yYKyc77V2lNjw7F3Es?=
 =?us-ascii?Q?6CE2FpklTI4vx2L9zRIv7p+M5tKlKmrUVM1mZYgtqfqgVjyyhGyj8JZiN+B3?=
 =?us-ascii?Q?upR29UB3tySqW3kbbeRhyLu5FTfckIiaqGDO9MQ1ckqT4h8SKB1/sRzwTQAX?=
 =?us-ascii?Q?qBtydxTEBx7K+WSrvfKZYymJ0dQr+2ogV5J81lYwqtvjWhsKeKzwUn6t5UZC?=
 =?us-ascii?Q?XHHKgxG3qWf8m+/KDEuqBDzWAScNm/A4L5QEX3cmPVCc1BOoeV1S8J4ynHrH?=
 =?us-ascii?Q?8hjhtGtwPzTFj4u0h43e9cQme+WAsypNe8mA/vS0Xm5IVBeVTQzvsD8oTK5y?=
 =?us-ascii?Q?RbhcUTvPxb7Q6GKAq5VLaz0J/NJTsZnWYDLH9cyne80rKkEg6DMKB4wfgcua?=
 =?us-ascii?Q?O8pQR+2X7rKjSNts71gBBP9qdHDT9YVUHeGi3tPONwW+23GKgHNOGcRCKMr4?=
 =?us-ascii?Q?6LwVYtyIGmoT9EDSQtUKsnDMZRD5zyBcwqauAuDkveQPlaPXHoWj5nWx58lg?=
 =?us-ascii?Q?M/jyT+3Kev14lR/3hmHN6uSgrX0tmQKBApaJKGVxR+AhWhUAFtlfUriPkBje?=
 =?us-ascii?Q?g9kW+gd239bUBBSJlKPTEcGa6s+2nGDGAsq7b74i/vsxaiK05lGldi/c8oz5?=
 =?us-ascii?Q?D1p19RROL35FlOmXqfXj+OFnKQGofI9CHLKwQb03Wy2wWrbsSoIFeXxunMir?=
 =?us-ascii?Q?jQV9DHj7ji+LGVO3G2OHCc/+0ueA5OycvEfM3ryhP7KljWN/aMOyzQdUZuxs?=
 =?us-ascii?Q?4sJAhOAuQhNWdkt0c9ufjmOVwWGflwm7uWOw6xlSJCBiZx2ngoP0dpGSmuvt?=
 =?us-ascii?Q?eJceN5h8rwn4neFWxPngt2fcSsGl/p/Y5dpuYfBq39/ku/U7QNxXYm/ln+Yl?=
 =?us-ascii?Q?+8yatwpJlhiml/Xcq4AvYieoMwa9Cg0x9ji6z6t6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca4871-3821-47c7-e72b-08dd94264fdf
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:02.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuisOro8jCx8WV1Ek25Cg1yQXa8cbOm3YVQNonQiwAx8hO0T0aKcD1wxvYikTe2oO7HEs+sHsHEpBvxohbkI9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/ref-verify.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 2928abf7eb82..38c1d3b442d0 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -75,6 +75,20 @@ struct block_entry {
 	struct list_head actions;
 };
 
+static int block_entry_bytenr_key_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *bytenr = key;
+	const struct block_entry *entry =
+		rb_entry(node, struct block_entry, node);
+
+	if (entry->bytenr < *bytenr)
+		return 1;
+	else if (entry->bytenr > *bytenr)
+		return -1;
+
+	return 0;
+}
+
 static struct block_entry *insert_block_entry(struct rb_root *root,
 					      struct block_entry *be)
 {
@@ -100,20 +114,10 @@ static struct block_entry *insert_block_entry(struct rb_root *root,
 
 static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
 {
-	struct rb_node *n;
-	struct block_entry *entry = NULL;
+	struct rb_node *node;
 
-	n = root->rb_node;
-	while (n) {
-		entry = rb_entry(n, struct block_entry, node);
-		if (entry->bytenr < bytenr)
-			n = n->rb_right;
-		else if (entry->bytenr > bytenr)
-			n = n->rb_left;
-		else
-			return entry;
-	}
-	return NULL;
+	node = rb_find(&bytenr, root, block_entry_bytenr_key_cmp);
+	return rb_entry_safe(node, struct block_entry, node);
 }
 
 static struct root_entry *insert_root_entry(struct rb_root *root,
-- 
2.39.0


