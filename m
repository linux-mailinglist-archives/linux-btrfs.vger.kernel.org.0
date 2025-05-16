Return-Path: <linux-btrfs+bounces-14061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F3AB9440
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156251BA3E8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EDB233708;
	Fri, 16 May 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bmbjPlsI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9322DFE3;
	Fri, 16 May 2025 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364645; cv=fail; b=LPk77U1Cikur7vDHj4wtsLWq+gYmQS90+oP/NHMBBb96XWE6uC1ikWBeH0YwRAWpQaLi8WNG11tzHb44jFOMYmnTF4KI4b0tigaXharbt6BWpc9vLbXUzE5NtLsO0EyaV0mJu4ykRkVZNeX7y+EgKKIwpx6djs6DnYgvRyZJjr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364645; c=relaxed/simple;
	bh=7PZ2MifOEWEKzpo5xuEjpn9bXJHR56Ld97TP7t/T07c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1y6wsfssaAwQNXgXMfilY3JkUlmooxwGSVepE4jjvWY2xFC1xRmWTWrNxM1whYPnb0523eLIHZGMPhBRg4VpNxLj8bzgOnmcstc3bOSdo3FrnZ87SMw4WdmlLWEAeHa8ncgt4RcMXhV1NTNN4yRsQwZcaTGMCPMxr5A/1gfc0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bmbjPlsI; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxMVumiLu2rMkFJzO+xncfp5JmYh5jj7pGR1HgpAiUXtub9um1j7evzxTQN/ciCy9DVcBE/GSthaOdUUvPLUxqfst04eHv6hOwH0xf7mYWLHlL/BFD/RjIh94QGyQSpBjs62GO419uzL4GctFwV1WahHTRtXKyGbUA4IhyauwJmpDp+Bvf2xqI7KXQrw7Qg3N+deUNy0PPhzXKNXAzgCxaTa+BUKLPPcjQFGlVGXFhSjrpR6Mu/m/YVIRK0jjRJcpEy05YHkkI1JjS2VLLjuLC6Agm95/pKWZrCRvb9kFD58HuaRFAXpN+JcMlchj1j3jqQY8188BUS3rQRxxeOUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htKuOTBP8GDYqQoVO7eBUybJaaWVk0HFs5mjQqjtoME=;
 b=c7ZXZwEFkOtLPuZfOLyQhZ35IStdDRXnD96DZHMgoGrXkLeEjp/o5tEzlwshqgoJqLuK2mLP+sZaDPkot2vJ6P8cf39qshIiDaad+lGoK22pekxNcM/tc7L7AiPRHhTH30yh81pVCKJfjvSSe5/Ze3LqvH7kcuHSLVzXOuwTYNOH9+Vpvs/a4ZxFamMHwjlYbrfXul3A3FFhxC8aeHEoUDrwb+tPRuTkz9c3dSjMMX3AHAN3BVXNyohSMx0A2lpN9ZMhaq5e74ED5oOXNTl4JhE7vItPuglILjM9CYnim07awIMl4Z53EoXyCNKX5TNsfvvKZF0ddZ8XGmrFlXzh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htKuOTBP8GDYqQoVO7eBUybJaaWVk0HFs5mjQqjtoME=;
 b=bmbjPlsIv0O6lKjRSTeTDKGeJua/wJLFEgN2XhMtz9bHJN0Ggyac45Fmd+3eY5vEfc8+RQZcg/cC4xpCUDBNn0gXJ9eF3G51KX8VpPv8E47TSXYLY8La07qe6NjTpEuIz2vPmUt2oP1UjyvsW92AEGR6EGLZNKRivhgV/MCdZVdjC0iySIW0C1B0DZs07aarS9GRgPyViBcuOhmZEj5llaKwdlpvh5D8ZiX4fRC0LwAJGIFj2qcBJztbyL6ppoaHNeEnHRVexppdYZqZJyHb088ZFkWVV69G5TgM9zxn46iYNN8opyL8Hl7hYFjWHwz7e82c2CA+1B0EYB4tDGVqyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:03:59 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:03:59 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 03/15] btrfs: use rb_find() in ulist_rbtree_search()
Date: Fri, 16 May 2025 11:03:21 +0800
Message-Id: <20250516030333.3758-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1b1fe5b-76be-43a2-efc7-08dd94264dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7n1eRR/jFMaY5qX2GgIDL2d7Pq4WGEPVxBzMZKfHY78Al4sZLtJ/35iw+/1G?=
 =?us-ascii?Q?ME2NiQX67HccaQYPAFyP9NBsYh1+IO41QJjeoLG4pnDjYUMmgZVXxEABq1R5?=
 =?us-ascii?Q?vPlSM4F+6ie/40v/DYAk1n5A8wd/iNDkowikuuy4Z5XidxTQDUM9C4p2iyFA?=
 =?us-ascii?Q?Y/g0DnRrDIarQCvM5JISihw/7X4FwCi/SFosYFTWDa2BHnMWdQqEVn7nSMMB?=
 =?us-ascii?Q?R3X3yvC02mfRpI6LU+RGfbFj2gPkKvBNuEHJXgZSCDvSBdEt5LSxR/Mp7Vuq?=
 =?us-ascii?Q?N5so/Xz2oGGHrAusNvUa6W1lIDJtbV23guFhBXjudAVlVXXFPD1f7laVlZxw?=
 =?us-ascii?Q?9TRML4DnqJhMVd0MzaSxRzD/iI44j0i+2u6r6XRDv9fDSs2CtV8vOUI2Wvsc?=
 =?us-ascii?Q?aKqjuYttuloi6/Ja3TQznN6R58NjpZI71BNLocx/sw4Eg8kAaKLMg3cUhbm8?=
 =?us-ascii?Q?KzF7L/CAy4/iME9ALsKfMRyJMiUfG4htWa+0nAya3zkDNhKQGZ8zMBbMd0qT?=
 =?us-ascii?Q?zpYj/QhHmwQAdaRl+qvwjA+9aZrPrny89m5pfodINt+y6AG+mFDcStLIFOKZ?=
 =?us-ascii?Q?W7jubQE/vArF2TxQ2uEoao5KjNcqSNWG5CkqTenZAjVnCGLEVlRBuHhoAAd+?=
 =?us-ascii?Q?k4BmjSahMBgGHbGm1yGWeo/MkpEu4lQlNKwmntM9sFbZVN37Ch01C3tTcrIR?=
 =?us-ascii?Q?ucCAfHJQi1wD27wjy2LA6N76SuypBFOh0etnaeKLUpF+Kyu9t8MsF7cO8SeE?=
 =?us-ascii?Q?pFJSgvAVJa+McV3SS7ETGAE2melrrdvlaQxXm9Hg7Tcmvn6WLnxzgObd75ie?=
 =?us-ascii?Q?ASIpn0v4z8t/Z/NLQyqwjEeG0LOVs4ncaj4K12DbRmJZ5ibl0mo2YZ4ipqz4?=
 =?us-ascii?Q?RyaPnsvj6DzuXZ17yhCeyw4AWdn9i6YgQtCRyeiwY9KXPE3mBXUN7mygz5R0?=
 =?us-ascii?Q?pjIh6XM4FB6+DErlT2Po4sPLNsL4mA/J0TXGgqfyKgS+SK5GrTu25BERH6/2?=
 =?us-ascii?Q?cxLt+XV+0zYY31uqTNnjyB7+KOJELnYDZhtPhiCiNdGSqQoUYYZlxVYtOoAl?=
 =?us-ascii?Q?VLr27zgRanw90jRwThNKa10KkEGJOer3NYBFefvzdvnAWOrQ38iEDFedIBDq?=
 =?us-ascii?Q?9RS1/AnXlrVUKRCxuCHkQTSDnye2ISWJjnt2CE8rnbM5CmruTT499WlGhsVo?=
 =?us-ascii?Q?k/Be1rMJnG/5EaefUye9ogiwjey7mB4i7Vzt1EVuSBSQpdfdLe5CTpRo1bK0?=
 =?us-ascii?Q?cLQsSBsnsz/p0J66ws8POiZxhs036MR4ntrLegcqGrIdJZN1nwERXqEllLzt?=
 =?us-ascii?Q?g3gPuBgVgdFde5u8HVHZVYENVI9QHkFERZjE1IYXpaDQKtK1vDxmAPs/GqAf?=
 =?us-ascii?Q?xheJ4i8J5mPlcCU9LxU8Nsb68NdsqhgELFTH4gHnPQmhwYAdWjBSOabadORl?=
 =?us-ascii?Q?hFCIFRCtMcN3o1oBXFwo31K+oNXxGro9xDxKjwC5/ub6VoLD/NjNkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFfU5ZFRECYT9fMxcM2YkK4PEqaEexD+V4J8swyonXJLTk/xVIQ8RplL4jOj?=
 =?us-ascii?Q?/6xn6zX1JEKmbMWfyKZ7oTb3v426T/TAo2r9kp17m2sKDge7TezpkhXSY7eY?=
 =?us-ascii?Q?qxCOdEeWMgMFuoA7L25LvdhTi92ZA/653LFYXym6yhU0rU3B8ad7aT+K6uiv?=
 =?us-ascii?Q?+q0Vwz5bXEHnrRkPLGZdkRfP2l7rSiEy65YU/zGL2e7rWk5tJjHhwM9akB18?=
 =?us-ascii?Q?K02HumMoCtb1/iJJb/y63ZEkT4bpnQEizid1uRfdCmA48YFi6IGX9rCByK4g?=
 =?us-ascii?Q?twMS8vDkA6V63an8wGJpsHvtJAga5ZRQQmAHWh+j8MZU3Eo/0A22h7wcC8gl?=
 =?us-ascii?Q?1Sstj64WSNeN1qywL+dBiWNVX6qh8LPGFv5j4JLi8x40oqxUNtn3c62wxMju?=
 =?us-ascii?Q?Ol4P4IaOMF1Sl+t188w7dpjStXw04d4k9JI18d2qTQAZ7iz9SR5ompXxQ9nF?=
 =?us-ascii?Q?qbW93I2QOoN1fXYq6SB7DEKAlZzDhQ06aSw2xU4Tyj6Yu+tqyKSwWnoqTRbG?=
 =?us-ascii?Q?DmynucGj2VdfAb1rmTZBUIZBmOKI3a6Y104RG8wC623lzZDbyo/BkIVCRGCd?=
 =?us-ascii?Q?VvW4xRn5HrVzES18HJ3Wk9DJMk3dWzVNOsuOFFDwhtUasNSFYi9SyTfs72GQ?=
 =?us-ascii?Q?amyzO4pb35kmmcPrm1rmBWlJpU9F6Iekh1IN+kmnIA9Kn0It0z/D668boTFq?=
 =?us-ascii?Q?nivAkiO0+OTRSNMb2AVUNDDr2fJEKZa0Ad9BJLPSuL97ZGF0sAUDzHhAfhg1?=
 =?us-ascii?Q?+wdBUS6WMWCVsADO8tRofBHBoeWZDF+oYOh1bUIW3BnbgqN4/ZHkThie2hoc?=
 =?us-ascii?Q?3VGRg3grW6MNXKo3Y1qttnu55ezmbM/c82cYzGs0jPWNkEMv1DsyM8FOHsFQ?=
 =?us-ascii?Q?5Vcb5LOvl4+ap6E6EvZflrA/Cvx3BJTpXNoUS7baaGpT4t80zjkaepvYdguB?=
 =?us-ascii?Q?4GGQEX6eASzUBJ/UmrIo1OItxJbNWC0on8N8qE687Ggefm84BjUdtGiQXQzK?=
 =?us-ascii?Q?ekHb5G9fVQDr5CQDYxRdkhGDje0yu1WShfd05vsriRP8hsl28XdmYPP1l1yI?=
 =?us-ascii?Q?FAXMJzSmVC0DTsJ23beFafvlj4wDWCjY1XKnfS6jrzzVi16IKeqGtZUTkAnW?=
 =?us-ascii?Q?4whHaG/XS5cpu3kP2ZfqUfws1LmGuS9UXspqIxIbAwbOPw+MMtpmY10GEA1r?=
 =?us-ascii?Q?CQ8YtiaOBwH6Tu84OZ/3q+L0K6q2KOW7iAYfvDM3X19o4fDZB+PnvOy1yzCh?=
 =?us-ascii?Q?bfwmPQuEwtw3HlWtn0a1vthcqydOa/ao0ktosrScppV/JfC/nzoI1nPeDlTw?=
 =?us-ascii?Q?r5cUtJSpNBKpH+XMSfjDrCtJ2a2aMi6C8rw01ITHPRLA6pD8vfRyDoq/BgBG?=
 =?us-ascii?Q?WXLqWzWkKbjnLnln0l1tV0WJRwWZ0aCrBKrX84Vje3AZV6Bdxc1gxpbk8ssx?=
 =?us-ascii?Q?bbNLHTr8iunZm0iFlx+z4u9rfUrexil1kBQOeTkpW0eJDFLzbHz54Ey4af7L?=
 =?us-ascii?Q?3GglgkNheAk7P3JMYr9vkyL2SilAlxi1df5gLwPJEe02pN84sxYjNQEplSi0?=
 =?us-ascii?Q?eFFLak58Dr3AwsmyVgC5zFrD5n02ONP9Mk/LSKsr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b1fe5b-76be-43a2-efc7-08dd94264dc5
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:03:59.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NEaGMlWehNAq70iS7GbSIJPGuhpATnyP9ZDEzK/7NMgEzK/e+wP+1pFqXTEY36KUILixNJuley4BOZtTm/MVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/ulist.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index fc59b57257d6..e1a4e8643685 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -129,21 +129,25 @@ void ulist_free(struct ulist *ulist)
 	kfree(ulist);
 }
 
+static int ulist_node_val_key_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *val = key;
+	const struct ulist_node *u = rb_entry(node, struct ulist_node, rb_node);
+
+	if (u->val < *val)
+		return 1;
+	else if (u->val > *val)
+		return -1;
+
+	return 0;
+}
+
 static struct ulist_node *ulist_rbtree_search(struct ulist *ulist, u64 val)
 {
-	struct rb_node *n = ulist->root.rb_node;
-	struct ulist_node *u = NULL;
-
-	while (n) {
-		u = rb_entry(n, struct ulist_node, rb_node);
-		if (u->val < val)
-			n = n->rb_right;
-		else if (u->val > val)
-			n = n->rb_left;
-		else
-			return u;
-	}
-	return NULL;
+	struct rb_node *node;
+
+	node = rb_find(&val, &ulist->root, ulist_node_val_key_cmp);
+	return rb_entry_safe(node, struct ulist_node, rb_node);
 }
 
 static void ulist_rbtree_erase(struct ulist *ulist, struct ulist_node *node)
-- 
2.39.0


