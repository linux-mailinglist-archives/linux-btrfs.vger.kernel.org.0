Return-Path: <linux-btrfs+bounces-13208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA9A96025
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4ADF7AB575
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B1253F35;
	Tue, 22 Apr 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PE3KOIHC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A52475C3;
	Tue, 22 Apr 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308537; cv=fail; b=QwYLFAYi1xzgjk1UK8s71zryi+I7orEM5WHfE2mv2WhlnBfv0kc/IGAuVnZTfyVJ9kkQxa0BXEVL56rhjW2y3k1p9g6OHcrc4fEhrGFmwan6LVQZL745EUxcTh+vYBF7RQqqxm9shuC8M0GueVlXw8+AR9m8gHLkQsMOELRkfK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308537; c=relaxed/simple;
	bh=mPYCCjO5oMabpQt1QrR4ZGeJa97myBDITrbThQEi2Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ub1eUMir8MlncCuGVixNuYvz0pTrUbCDYWaBxqsacSCbpqnVAOOEATA68k6ZtRQjNJDmZ1JtMvv+E2hwT4M34cWCRBnSbb2vUW78TYYHVhJq7TKugg+wFNxtFL6nB2OI7HGpT2R1akTFRrRL5vwhnHJ0Dd2xUWDmV9OeWsX1HlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PE3KOIHC; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQzn2lPBZjIKXfI7MqEMr5VPDYhr8rvBR7fabhnoiZuDXzwj4EetBSGl1GTBVxpPsIHHT7LJdM9Pb6Tro49kaZB1bK9vDiTrobUMW9V+u6MbO3UvCA7NjwKBy9kqEcrHfoEqnzRca+UbvWFnqQF4gT3WKrfNt03c1HAF2VBGErYQoY4+zqxDcAm1cF8ubOjHAz60r0AbCjSaml6PAWMOdhw6UQ4LWD8XYNRmyR6dW+QnDrYrVIZWoQOX3JSMGDHj5P0AIuUivrkBOOIihzZQ0VNLtJxkyEY2dZTYsBZ6A1+1dAyuE0ovN7utNeZOUk/4zsfsOG0gRtoYuchkpqxFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu5Gmum19i5k97Vx0A/0ht38/kA3DIujLql2cbaemy8=;
 b=wo76BS8x7MuPTBF9Sf53AQE+WVH/Tn4aTUMk4tx1/C7idekwAgPIN7Jv4wIxBemW9SqQCaOXITYIkS0g2YtvuhyT27v3VO3uIn/erE5AV+gOr6LkjGdOW5UvDMJCXhjAhG9UY4BtYZgVBeObGW0cELzDUs9OnzIwiruUpGvEQH+JYPdUA1zKAWuaRCH/SaHlExBGN4TASt0m+d16PpspYF5c2Mj/jXTu2MeHDpQlyEkfcvBrvS9C/iTP/I7W8nWLYO5n8nUOxd3tHF8DVGac4KvIJ63PK2Fvev445mqAG05/j0dWyLeQ4ZP0YEe4bY20UQscpIjrtYaZ+SL5EkyT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu5Gmum19i5k97Vx0A/0ht38/kA3DIujLql2cbaemy8=;
 b=PE3KOIHCMJIjIO1c+HzZ0YFxc7nX+g7EWAswpzJp8vWiaNx0FsrCK15vhnDO+whhWk5o63kFZxgPeGMDulO29xQdpwPpwVGhgIDxdhf+MQmyJfdibvc/l5oHTDlGEVmMhr+vfwfnCZX/INUnVQs14fE8mifAiA32Wbh3Yn+KA1lp22Uryrz0PBR7VkIKyVNH4oEiJqsJx0r37COmLJLLnHJ4S5qcmsCtTEajxPdARJ4ed3mpcs631P+tz11i0VhxztmHvY+wK90Dg8+0KIMubBGTHfTFJVq3+m+pi/WOwoDgR5lsS8RHKeakH8jCMPiN/hhZvh6EyaMKJsOJl7asIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:28 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 06/13] btrfs: update insert_block_entry to to use rb helper
Date: Tue, 22 Apr 2025 02:14:57 -0600
Message-Id: <20250422081504.1998809-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a2212ac-4064-4d9c-59e2-08dd81730c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3PKOs7A7ugbpZzUc6n52giGEUWwKiAN8PXpCYGAyLmgGtiWLUGmQsCnthmsr?=
 =?us-ascii?Q?LVWpX58620x7dHaq8lABAcO4rT7kZCbiPQZfB88Vfma863mtxOCj1+9Z6H70?=
 =?us-ascii?Q?0EXyQMcaTRfmjUwRVkf6Rqd9sed6XCz3EOxaNQHbnKvQqQmUbA7Ots77OgD7?=
 =?us-ascii?Q?a6JPGI4K3LiUa09hujAsVSzvjw4Tl6gDkXRTFUaLT+YSghF3DdxnohdfW67L?=
 =?us-ascii?Q?+2myiI2r4pW8c2IN4CeznvocyCHQb/WUeGjRYB8En/3A5q51WHDHnHoTeU/v?=
 =?us-ascii?Q?Y7rwwGkzDGfwwU2gOL2fytFcBUh0ybc0ctUYJK1c0QZgWy0c2KH9ug1fwB3y?=
 =?us-ascii?Q?oOBe9f76d7HCFXzr3HtC0tNxY4jZTtsKf3WZCXxWPMtoh5Eics2YPDgHfGJN?=
 =?us-ascii?Q?Mg+Hjh8FQ0BNnbVba7t7d2HSXm6QKv5ma+szEgRftBdR6cFyz8e0uBNd+2q/?=
 =?us-ascii?Q?AdV3VJ9hgy0otH1LN4AYkE1v1gZPrMGSUMMbxcFPKRkK8EMUSLQjfV4IxuKT?=
 =?us-ascii?Q?iaj9NxzqqVPuAtLHeD0D05+oDGcWwp8M5bUq24Qj7YP0S3JCW4qqgqKl2u0+?=
 =?us-ascii?Q?yXebIXMVCqvyhCnckMbp6AMaxJ0J+NgUkOtwoL+6f5dL2Fvzdk/6hKd2gp/X?=
 =?us-ascii?Q?0udVt5A6vumw8POejWAiiQAUeGYJKqghXfHos+LfxgzBOgqFZo8V7d/cowT4?=
 =?us-ascii?Q?vUaHXBSP/TeJ5HRoQs7Tp3pA0xrG3iPVjPJeH2FmUNeY6yTpgm8y2xjIo6PD?=
 =?us-ascii?Q?wCsP6AJJmjBQQWCmsTyJFNq0CP8d5GokgSsUHXGjVC4Q9Vs+SU2Alpr9zw9L?=
 =?us-ascii?Q?Wp5fE1SWgWCpYvQhMSLNz66xhnpdiSd07q9Kfo/vWu0OabFnJANlKuWF+5BN?=
 =?us-ascii?Q?Y7ifGvVpmLZq20JqH9pCd3GoKaBcvU1e1KzlArq+nMF4hLuIEokoxBnRcHI1?=
 =?us-ascii?Q?nm59oTfpWn064aLcEOy6QXGgiY1rFUOC3Q9lPY7YYX8XiYrTNShgApvutf/f?=
 =?us-ascii?Q?1QOYrhj8KVtcQYGoTZSwsN923EXR69roiYhV5nG2CRPnzuTWqrHNlFgdoiZM?=
 =?us-ascii?Q?g1Tr+yFH/sQzpMMK/RJN0QNSRHEV7PPqjMgT0HIzIiuZE7l0GIZu/VCJ7Diu?=
 =?us-ascii?Q?Y0Iajx6nz+99OHIrgnmJAoQA1M8oERJBzKV9yWR+o5oOPUET0jRpTk9xnTfS?=
 =?us-ascii?Q?VVYvZ84b6XTA1ifmGjc1IK9PswUiSzfBwm8y98F5e1MzwtJn/baUkgnbsiKf?=
 =?us-ascii?Q?QTVTh3FwIiIsZtbPwRAZFxWiQJd/9wPr8D3obxyNUS/y7Cje3b1kR63tN5kX?=
 =?us-ascii?Q?XYm6O4367HcfPxYqYYPJL4y8rFDcXrSVpC+f/7+GnDXjrR0LpVwAJbz1Dua8?=
 =?us-ascii?Q?PmNNPb02QDenobnVvDeXeYuXZPI4NYsW8W2MnzIsWY72Q/OYkGcplHkxWcwZ?=
 =?us-ascii?Q?NUEVDqBjmEFZWsZ/shQwDVcoC/k+/ei3EjEprzSIhvPE7wKS0L14FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lsbeI+3xbl3IcbInXde/I5TS57/1fcrz5c0M7FhyAJlg5QcVd7fv8IpwWLsg?=
 =?us-ascii?Q?sBdn/pIrVjek4M42OiVeCyKRlGShhIbNL15ZtjzCkNjZeGXMcr+Z0ELTU36p?=
 =?us-ascii?Q?/G6csfqcqaKT54AqN5/Zk2lVpWhiXchrZZ07zMrwVhEn0rlu08MLOWv0QCNm?=
 =?us-ascii?Q?pp2u+NiJeO+IUvdR9T0DxAi0cMOHP7c8CcPRzlPVCM5Ci6G7DtDihyiCvIi7?=
 =?us-ascii?Q?LIUW3LQSFe/qp/LPODyGZZ/38skd6DbocCFhpWZK8fqknosuT2P3mG4cO2IS?=
 =?us-ascii?Q?bguAMzlAKBbiY2ij25/vKfchs1gvq0aBVjX30UwAeD68Kihng/0Gk5A/0kqB?=
 =?us-ascii?Q?z4AvHajAwtJZz5Z4HGl814NWDq87AVNa//p/zKcHCu7hCUu3aCkWR6L/n5vR?=
 =?us-ascii?Q?ofoppPBpVuGPfZZxxcpKe9dB3w3yXyH0ryC3edJcG7Uwl2sCfLZ4Ux/2B+s9?=
 =?us-ascii?Q?5Oqa1L5y/4RLr8oypiGwlKwqEOWDEoUssaLBdhK8b+0ydLtv9T4tLO/bHbT7?=
 =?us-ascii?Q?VVNFV0dWO0ha2cGHHcNeUAQZbtCfguZZNq67a1/tkilc00lqx87ATpF0mQ4J?=
 =?us-ascii?Q?0SvPx8v+N2hHCVlMe8xF0lQMEn4B4U2EF7kJl1UT4Y8zfYB3+cN2A4wiscuf?=
 =?us-ascii?Q?slCsY0OFkLP2HvzBH+VtomdvmAXCHFM7kcCo/3uPeU6owWCSTPMjU+CmgECC?=
 =?us-ascii?Q?z9Sk3K5rdgm5I0rb+/5WDFvO4Hq9QZpzHy6OIHzQio8gBqZAvREZEP2DnOM2?=
 =?us-ascii?Q?NeuISC9LVDUGHeyvqirPgZ2RlxrxIwT+wA44KtAEod5SxujFy9UCR4wKobO0?=
 =?us-ascii?Q?VxWF8J6zsZ97/Oitvtg5WXxlbxMkJwGSsQEgEKgWUrTPEVE7Cf+kG32mNI/V?=
 =?us-ascii?Q?LyeUU3dUMO9NGmbJZPMFAOvaoGwj9vW1vun4UMl9ywgoiCRTuhBjMGmJ8/Y/?=
 =?us-ascii?Q?8T/ZrOuOT6WliokPU9c/8+SmElR43M+upGYmk0auNdtgnwGl4IHnweiMPsTw?=
 =?us-ascii?Q?3ZFOWoL96sLOL4ag4/U2+ExkNIrPUho1Kw/AehuszSYjlEoCDuxNdBeqH2mF?=
 =?us-ascii?Q?p3+SyXHuCWes4HNLCPxXJ2HzPleK0DMKrCO6plsGgqBvD8DCY4x2cN7NvoWi?=
 =?us-ascii?Q?Cqz+VRuycv6DTvPqmKqkC4bMZqr7skKYySyVXR7IXAGxiIfpz/k4vcNZMfuo?=
 =?us-ascii?Q?iIjFAMdJxdaKIU4i0d/BPTuaNXJ2CGHOTgKdwpsx9f+ZWKcscUEzki17YRw7?=
 =?us-ascii?Q?JhWuE+vjrLsnHzvSwde2zO2+JYilxGHs9W2IhQiKLm9+HdZcn4rfTxIq0oIP?=
 =?us-ascii?Q?ICkdfx6Y5CdWySoZLOLNejQIt1S9qZNYP7bwPeDmTuAyEOb+MI9ZyLRB61ax?=
 =?us-ascii?Q?dgXLXCuUEyeHToK3alb4MeWs/k0NtT42Asugo2cmABPAh/hVJOKfVHvkbzf7?=
 =?us-ascii?Q?pQoj8mcfM9Zsup0tyVlw2a5ycY8q66RtSUVRUTvVnp2h4UhVJi3xfjm5FzPa?=
 =?us-ascii?Q?tlPbO+BSm2tCy28PaCG3VRmWmB2zHB9qewGQDxAkRjye2S1Qa6zJkW7Nd7Iq?=
 =?us-ascii?Q?j3eGXF51KUXNZ2tfzs2O/dCyyXf2eDXgKuKaPKmg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2212ac-4064-4d9c-59e2-08dd81730c0a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:28.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wupeCIcAmGIATwGTy84zpGwvyKDvYOIMOqjsyHcOahh6SxBXEpCnmhdXyqb14mh1JaDZRxn2WzCDWzH6FN0A3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update insert_block_entry() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ref-verify.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 6445c7d9a7b1..6113f325df82 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -89,27 +89,21 @@ static int block_entry_key_cmp(const void *k, const struct rb_node *node)
 	return 0;
 }
 
+static int block_entry_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct block_entry *new_entry =
+		rb_entry(new, struct block_entry, node);
+
+	return block_entry_key_cmp(&new_entry->bytenr, exist);
+}
+
 static struct block_entry *insert_block_entry(struct rb_root *root,
 					      struct block_entry *be)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent_node = NULL;
-	struct block_entry *entry;
+	struct rb_node *exist;
 
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
-
-	rb_link_node(&be->node, parent_node, p);
-	rb_insert_color(&be->node, root);
-	return NULL;
+	exist = rb_find_add(&be->node, root, block_entry_cmp);
+	return rb_entry_safe(exist, struct block_entry, node);
 }
 
 static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
-- 
2.39.0


