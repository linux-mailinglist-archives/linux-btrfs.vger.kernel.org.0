Return-Path: <linux-btrfs+bounces-14060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3969AB943E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1AAA20FBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8C22F39B;
	Fri, 16 May 2025 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nC0Y4tuR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF11D5ADC;
	Fri, 16 May 2025 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364644; cv=fail; b=F+BYmhOIAiC35365u86lhGiAamrgu9e46CYnG9riSDaVcoeZGZJRQDXaVxcslDhu61qw8CNLGASzRlGVHZIBrXORQ6m/p/6kwDi/vfV37PQ1O1R10Gd9CT7BMpYBmTWJWEDpwGTpIPyypze3V0IvHo8jmM8oT2JDopVtYZ9E21s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364644; c=relaxed/simple;
	bh=YB0Q25RWRV+6jA+WgREGVlWV9EVP+27H5CfSFkMQhd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6kAi0cYEc2AtlJIszi7Fsb4Qd0wsGco3kvI949Ia2FHPF+in0ih6oCvSyDDyyDyRHIQnhFotrrCZxbNh0Yiwcw1ss1+Rs4a0u06FVPRpm+QciSPe+GekV13OeGXptkCLaFUkrhkLrgU5lN5NMGMDfmrp7GfiRW2m+SiJayXRxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nC0Y4tuR; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ+SjHzrbZJSvcHD7lfCYxgmjosN5q5N597UbXzuljztd/9NqnklHmnxFI3lvasYDFEOQxqd4ed9Sp8MmmztpXBoebo4dA2ALpyob6oSQxFH568P5gO1AI6XiyCXOJFyWrdo20EpMcSdZkEYG6nIU+pMv2WIV6I/6NApwurXiiEHUE9lknextxdXdp0ZPg8g//5kcdSFBx/x66aoMLbe0oXpnG0Xf8qDhGZ8Wh3jojoHpm72MpkFS/b9YBCb6pMzIZU0d6D7AuerLiMMI5nC6QPAlQXG9M0B49YIHkdGe0Pd7KSbb1CxLIecidEAqeYMMN24l5s4zL4wmFGokJosVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V46bph9whFZdVKd38XHX85Flw1S6RbQgnXzJziKAE4=;
 b=FHN8FAehxfB/jL0jww/IzsRkbWSTEYVqB0gW9l0x/DnrsJhBeYve5tsWvryqGsDJq3jS7SAhBiTmGMukJSRyHW/m63OZ1dV+5k3BtsuiSmLlL1vE9NQSCXut9iNWMCdsYxrZJ4yUBDGCaiJ2BxGTal8FOdkqj5BM0QuI1EndbLMBKpilkK29M8clxfr6a5W6gHdGIMnPEnsBfmpfH2LuTetzXIl6L3u6tljIHQVm9T3XYNlj3Wbk5pRGKb7tMk8tbDezWXzP9SY/981G+n8l5NIlv/iCSvvnIdGrS1pOuJxLQmfr9C300qVnGTyheBJbYMH093Lt/po9VSZnl0ie7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V46bph9whFZdVKd38XHX85Flw1S6RbQgnXzJziKAE4=;
 b=nC0Y4tuRL/y9R6/ot5mlGqbv23HxUyTvQq5LyXhQMEEeM89Ikz3V4fx14p2+1mMRijGVu8tTmgxbz4dOomgrPfImz/kEpsMGGNizQ/5hZjgxWl6Ek/RVmu5JeUnLxh+THA6PIty5T0JTyiE/IDTGwOlXuXw4HXXfH8y3yciVwjdjZ1sJN9oRkwbAryhoRQyKv4Poz5y4H/+0qn6IJdImIsX8Xcr1WVrzKcZJ9OlqNB3nKJTrmwmUcNzN3eCv8SWdXEFiyOqRdtvPmZxV29B5VQu8nq/mUeXGEj31NIYglMSfzWoBVms27IJBg98eLIPDOqDtkZjWYkaV4vNW23wdSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:03:57 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:03:57 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 02/15] btrfs: use rb_find() in __btrfs_lookup_delayed_item()
Date: Fri, 16 May 2025 11:03:20 +0800
Message-Id: <20250516030333.3758-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd1165f0-2271-4f66-60c2-08dd94264cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdAjTeDZTEwtYQw/eG+6frTg8av+X2osloqVwjSkDmXPTB3Fs5A1C7TRHnpJ?=
 =?us-ascii?Q?E3Z+/0LcB8GRyn4r5DoNQmH2AN15liOVQlbva4WZFuIiYFEFFxPd6Qots3yJ?=
 =?us-ascii?Q?W/joWh70lyYJEKI3yJiOt6LireL8Xep2gzZPnXYxangOAx5ZZjj6PB0QYjpI?=
 =?us-ascii?Q?PQiwC79YIiUMt1UYAp5OeTP/FGc0jofpDOUpsoWzKdxoUFhAu7CSGsc3aruu?=
 =?us-ascii?Q?RlK1/E3zojEj1gKtBGmMYrEGh50Xr5dTZfLZJsZhJAxZJY4vGLEy4unslg/n?=
 =?us-ascii?Q?00oCUOPgqcGqv49/T+Q+ol6kg7rm2+Zyd89LGIk3D5CVuVFmsKZv4aaJjbsk?=
 =?us-ascii?Q?SD69BjNs6vf7StWi1k/9EEi1S/TpvkvXnZh0I6zIB+ewRC15PInJufhEkIlz?=
 =?us-ascii?Q?KkQKDgQBIUGM3cGxsAaE5Gf7vEbSCBjba9zTbiTNpw7BKRkTUpx2LmnFRqua?=
 =?us-ascii?Q?tkhZje+I6F9cu3egbma5Edfcqor0G5B6IoSAeHznlp3c5tk4USA2zHOIq8tP?=
 =?us-ascii?Q?aY6WXETFz70xgmyJ5kQFBk6YhoNG8qc83k1MO3JHAHFg3AV6J8maXoOu3ASG?=
 =?us-ascii?Q?clIGrbgvYLGZHKvVK9hC7UGWG5Ldkhj6lFXDhp7PxrKgdjSrkC2/egcdzyG0?=
 =?us-ascii?Q?0/CxIHy3XZGFIjEZ7p7jzoAjWsRy4OYos5G4Hn6tcS7rVA9G6Y5lTHKiPKpL?=
 =?us-ascii?Q?q97CMq7bGdg4Nhwl0BoLLayYzYJvWB96GI0CgOQ6/Y9yNtqmRitoEYO6/DcO?=
 =?us-ascii?Q?Q+mxWrAqNzjajEdfpn6qC/UInoS05nRH9s+qoTRRm9bHqlvmVR3um0uCli8r?=
 =?us-ascii?Q?xAh2ZzEPmuQl4XpX/9SMzXLy0Fh3b5xB/NJBolAvS/yKmuZSMg7oGoAZIBFV?=
 =?us-ascii?Q?606isSIMvozIrVc7HcAI7Vk2IYm/iOKgTLew7NQ08NpCqSU7HwZxmfp/LaLb?=
 =?us-ascii?Q?phwHtxVb6cZ500umv3dLi32yXgg3k1CwR/Wi80b0KeU10aM8d06lPOWBjqrh?=
 =?us-ascii?Q?zCQvzheJhxX9PI9NpxaOUD0FUhSK7t8yd76rdb+CGIQU9hLEqw3BuiBosvNZ?=
 =?us-ascii?Q?S3L3Gy/uRkKGKVFrBDxuREJjalp5vVx9t2FGU3GH99RFL5mL+h7izffjiFYT?=
 =?us-ascii?Q?SSK2Y8UH6/4147HKaiUeZ2fCiyJRuEeFRHLGLmPKCh+xBCCuc3UKwShtM1yA?=
 =?us-ascii?Q?DWl0k0RuqdIsIwscjaaVjIOwcJ/2c5TinpuoHjQs/x193epA/gZylKlKftlj?=
 =?us-ascii?Q?CO+tO2NMqa2bwFJj5ZCW3tkWsw8UlFgq+NYbkLYFM9p5MYCJEB8y3abZLgYf?=
 =?us-ascii?Q?inf1lFxluOnL5m+B01ZKQZaoeVArD8zhmhV7I984hZI1UP42U9JjYoIZ9AFO?=
 =?us-ascii?Q?1gnxInv0TUtZK19YkH0giLB6k4FmsvD24i8y31myLzYd0qjvXhw0efCgphlv?=
 =?us-ascii?Q?DUMFlSweE+jK1cxTULIrcMyOE1lt0QIAU9iV+0J10G+kpLOGdSv90g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BkEFMnPTNEFOYrmqzRhSbhIQJt6iNLofOVwMwabGrrS8Vmq70ZEtqG/p43i?=
 =?us-ascii?Q?XCbM32lNPfzo2CqgDbS2pisP2D4Hi7oJYjC1PbXS/KKsL2WNmuJQ/6Cyx8jd?=
 =?us-ascii?Q?f8Y4l1GcXyZ+VefwrrZsJA+GxZ9w5syyswH+YlgiRAa23lV3U27rPv/Nhvmo?=
 =?us-ascii?Q?5DxeWVcjdqKTRM7cFt0T9oqHn97JtNFcA3IRMbTwFnzg33BxAEyVsRzTUEuO?=
 =?us-ascii?Q?ax4b0QWU1wZjV1ZUZPlWGjT4sKGPOhO5pxgPlJ+Iy+4dEVvE6Pqjpz6u0yY4?=
 =?us-ascii?Q?leLacZW/N7da7j/UVqQHyK+LsdQtLfV8cPPD+w0TeLkNUstf3mc4ymxFOww5?=
 =?us-ascii?Q?wKSpTXzeJbRq+hQoUVX/9ninuZnr71DYbvZulPRFCtbx/KdAgxkpmtw+aOML?=
 =?us-ascii?Q?kDyaGcpkrVaR81bAu1wmavCgsR/yjGMMVtkaBJGGUQAo/yngUkF26soevmbE?=
 =?us-ascii?Q?V8cvfMKOCuO+5H3hpM8f1VAx3rqWe+axjNFC5SdxyX1HdeWl2pFd+YeQYia7?=
 =?us-ascii?Q?gVgamuiV6/FXPipjvc8+r7rKEHQyeUp4zHzB/DVDeBhxJL5Z/YJ+7mof8ewe?=
 =?us-ascii?Q?p2nkUsVp/YtlBIbrbR3lJzHt/ZvT0Ra5h1FtXZkglJAkPJuYv++NYfvZkWuX?=
 =?us-ascii?Q?qNHZTrZNEaxlaCmZV9ZJQ59Re0NPyqWmZu66vHxS8MNQCNjnYN9NQGmlBWYx?=
 =?us-ascii?Q?RuepHVlNEgx3i783YlkzEoZYXZM9j0z7QPLDJls0X7A6IvnMiMq0nvQsDmi0?=
 =?us-ascii?Q?4VVxFkZEfAxQD/d9SNZqUK9+YPXDwS9qaJtWGoH0+ID8FlvkJhjIJLCumcqO?=
 =?us-ascii?Q?tBLERgdE1IhYHeBb4mvK/ZD3pOHjHJprP3nRf990/dPLfiRCOOqvD8+H2rHz?=
 =?us-ascii?Q?K0lsXq/z8/0atFJK/5RkXGVS6Zi9Ziu3cLzQbMrW1xL6/6HsUSbX0DXCTz/I?=
 =?us-ascii?Q?aLB4dX23ezajo2VxolLijE2T6HFe5MeXe2kUx/35w/ogHZJBWp7bZMXka4oI?=
 =?us-ascii?Q?nfuU2bdugN1EjvainjcugaNOc9pJrxYF0IFSKwNlAEn7w4akvRDPmTqTbOjh?=
 =?us-ascii?Q?obhV9hrfNFcZfJkHcjOFTnQY+JIrC0k98csXqD9NdC36luwcezrftK5FYOg1?=
 =?us-ascii?Q?Hpk58hcaqsHbSdsEApZqUy4RcG+riwDqDzPQNGN9v6yvMT2gs6GCCoGP2YDp?=
 =?us-ascii?Q?WjkrGHtcQfnAv7D+7EdfyQ8O0GDRMFIpd6bd8B+oqqt/KX3dFq8uQ/F0+VtZ?=
 =?us-ascii?Q?5y4840i3JnArq5s+fHSFdSgOkV0RtL4eUwmx1Mdox4eF2kMP1jK0KoPQCPns?=
 =?us-ascii?Q?ThQ6URZPbVeqvHGbE4fUIlnAZjVsAEfKI+QHIqboDW0fNiUv+Nt8RqkY16Vm?=
 =?us-ascii?Q?zC5j6h39rwK3qOe3wDaj9FpHLFCeqohIaLNnWjD5+SuqPrOl/llVY4ADM3Kp?=
 =?us-ascii?Q?W2ZSiSbbBlm8ROSkbaIVcZwESNOAT5MM2eLw0LQUVUIcwhHQ//v9HOmOLg45?=
 =?us-ascii?Q?fgVL1Npjuy88oozu3qLkq2Yf1qmeyKq1DMDimkmLGsyHYW06h9BPRFBxKbBN?=
 =?us-ascii?Q?MfsN0QwmSRK6MiuoO+p69ZAPwZIEQmThNJ8NFJiz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1165f0-2271-4f66-60c2-08dd94264cb1
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:03:57.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x00XthKZU+WPiAELJ/2PUBYqgszy4e51AmEZe+S8OjdznQUeqUSuTYQQeuMVGTAw9nyGSPM1sTSQLV2UDD2e2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/delayed-inode.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c7cc24a5dd5e..3f696fce7c6b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -334,6 +334,20 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 	return item;
 }
 
+static int delayed_item_index_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *index = key;
+	const struct btrfs_delayed_item *delayed_item =
+		rb_entry(node, struct btrfs_delayed_item, rb_node);
+
+	if (delayed_item->index < *index)
+		return 1;
+	else if (delayed_item->index > *index)
+		return -1;
+
+	return 0;
+}
+
 /*
  * Look up the delayed item by key.
  *
@@ -347,21 +361,10 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 				struct rb_root *root,
 				u64 index)
 {
-	struct rb_node *node = root->rb_node;
-	struct btrfs_delayed_item *delayed_item = NULL;
-
-	while (node) {
-		delayed_item = rb_entry(node, struct btrfs_delayed_item,
-					rb_node);
-		if (delayed_item->index < index)
-			node = node->rb_right;
-		else if (delayed_item->index > index)
-			node = node->rb_left;
-		else
-			return delayed_item;
-	}
+	struct rb_node *node;
 
-	return NULL;
+	node = rb_find(&index, root, delayed_item_index_cmp);
+	return rb_entry_safe(node, struct btrfs_delayed_item, rb_node);
 }
 
 static int btrfs_delayed_item_cmp(const struct rb_node *new,
@@ -369,14 +372,8 @@ static int btrfs_delayed_item_cmp(const struct rb_node *new,
 {
 	const struct btrfs_delayed_item *new_item =
 		rb_entry(new, struct btrfs_delayed_item, rb_node);
-	const struct btrfs_delayed_item *exist_item =
-		rb_entry(exist, struct btrfs_delayed_item, rb_node);
 
-	if (new_item->index < exist_item->index)
-		return -1;
-	if (new_item->index > exist_item->index)
-		return 1;
-	return 0;
+	return delayed_item_index_cmp(&new_item->index, exist);
 }
 
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
-- 
2.39.0


