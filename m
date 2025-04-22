Return-Path: <linux-btrfs+bounces-13203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEAA96019
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CA83B49FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770571F461B;
	Tue, 22 Apr 2025 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W+8/fnMe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C2F510;
	Tue, 22 Apr 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308527; cv=fail; b=PjF1MyEeMqoguyQBhI8Qg/FdX7C0Lpq5a9hRrAmkt1nbB5nc/sz/JcwTNkDJ0jxlshBPf0ikRuhilZBvJBdy9XhcGaBAEb6dtKg/GtA/sgz6ktt+3bUG2QB6fLquL3zomw3Zami7NIdKYYJijbsGJk8/clz783VU7OjfFPgSxcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308527; c=relaxed/simple;
	bh=Jl/P6twpDZ5SGyQ4QEaAR3D+p771rFmsQ+Fax2xZWEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axDSIo5DxAehL6qrGpTl9bsjQSMJn8wT0EVptiMwDJ13X9Qv5OASUWHpQwbkqaEZ5THrB11tcVmfZlAHIZe+faWRJiYtYI1+RY92MBlAX7ic3IWMXcTUPTdlf6DxE5uDtWJlNeem4jFx4Jrn/lwCgGgq5tuOXqaj/7QEMENjn7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W+8/fnMe; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2RUsDIV+ytIi2WiXXxXmuXvUAi53fvzYIp34KgRxx2R+9QIgeoshIUgr239jcyMdw+Tc8gZxgNpU1kg5dvp2Ytqnte1d00VHBIjopaHwPdRbcE3BNpGFaTi5Co/g7e1SaJfnR5J2Mv2VDJHw2YyOrES4CPJar9BaLq/s4SlxtUMTLXFDXV5XahuDVpOftYOvTcUSbvJSVqW7F0FsA0ycFalMItBk+OmtXgxAoD/tYVxBcS+E3dTLH0iAFSheHFvXlazGvvG/J9+RxuT+JOITFodmy9GN3dqSdmHPjr4/6Z6SasEoOqz2zB9fMlPTSrl2VzHRkFabM1Whhho98njRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jt3inCbd7avVP3W2ASuqT5YnS626Ew0QteZ2FjErPA=;
 b=nCJBjMaCn82ylE/MwqMlf6PiWeb6OkjT8VIJ/pzDOATelgVjuU2sKKQylXRdlYldPMAF56DJ4/8MduLCI3QD8LEiggEzHb3GYdvY9w/9w2eAfT+b0JVgubJI7e0OUXY40yFJH11OWcbpTwHFWWLAa1DrZanlFOwVWPVWJ9XJboFlcn2OmiiHvP9O5UOjrD5kKb4AFuiw/XO7Ln4lu77PDqK6gkvNY7BiqaE6t09SIyw9GcIs2Ro31PWx3CabcSbv5HqXfNTnQ7YIiOpfiX7eWxoD7HGnX9pNFCIePJUvh9FMiFO40BeCG+rvqIHKCkhOeA9+Se/hGA6UOoZ3a4qgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jt3inCbd7avVP3W2ASuqT5YnS626Ew0QteZ2FjErPA=;
 b=W+8/fnMeZiZYIVhJBfcpTYUUm6Rs+OQa+zycR8vV2up7+Pb7L7FkcNMQWQIlrMyL1joRS7aArvvdUU5SHvxdkjkHa3W8OZvK00lrzlJhbhEln2EpLJ8ucsw3/WYXCnPsGIYCw3bM21r3kDDzA/E1CP2y2wX+dXK8o8KEtzCiwMJ/GTaX4ZvPECvZxc5S8aml6XFXE8nnH/rimfuQAUz8yBdDaw8Jh0m8NJpk0xvGxqhln/YkQGLxdvH8zGRSFZvW4o/uxqNT5TAWLqRWJftCrLfEVPKA6okI0KokeAftIJw2Arqsh5DumxOW6ZiL3+SMXA04nw2Q1df+fT+SacQhhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:20 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 02/13] btrfs: update __btrfs_lookup_delayed_item to to use rb helper
Date: Tue, 22 Apr 2025 02:14:53 -0600
Message-Id: <20250422081504.1998809-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 15fa4446-2ba7-4e74-ed09-08dd81730756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y77M0rYjFFzynONShnnaRCo5z9jBJMSnszD3/c+3WYOMqC8LncmuL+qajgbb?=
 =?us-ascii?Q?XgKCPkQcmMzRPk6XEWfeU5uasm4LBBs1VI11b1mlA1glOTedbml1wY0twSE5?=
 =?us-ascii?Q?2BPYNXxrZ5SH07m4ZLNhE/FjxoUsjiSnjLiFnUhwzXu+X6/4F1kVT5YrSLSA?=
 =?us-ascii?Q?73iJuLHSpszkvDR30OunAq+RpZ+8KKbzVyYb7+bzIKK59U33lhi0pUcBEymU?=
 =?us-ascii?Q?2UQQmnAHxi4/clCWVQm5PrzlmXYZbdp31MpNyr2ZOveCDxzHzSesxMfLPPXt?=
 =?us-ascii?Q?BzYbUIH213YckmCnA8kreNNccxjTnWkzvgJkwNDQuowFKA2e/g8xUBWZrpXX?=
 =?us-ascii?Q?CgHtYQDMc5sgL9erdNGLIo8skIRKgqPh1lhZ5oEclfH61/f2cvmhc75ifkrl?=
 =?us-ascii?Q?LmbAPFa5OW5BsRVm2h53yV2+Vh2cXy4Vb3soenpyIyn1a4P04cQo0h26qIyx?=
 =?us-ascii?Q?822KJL8VxVvmpx21shHR3Zc/PRWQOPRGtCjDWSEQBLd18UM5YtfD6lV3zLCn?=
 =?us-ascii?Q?AI9WISQHax1BfLEmiCYTLlsXFYpgDq8EcIl5f1fMlmICXzO4/MSTr1CtJoM0?=
 =?us-ascii?Q?y1IYA1ZnOFXaXV/lYRGfP8JlAV4p5CcS9GZpopQr3lS8ba338f1oDwsnM7Lr?=
 =?us-ascii?Q?rJ34PO7ll9ghA4RtwCFRfmN+cDZprt6zFm3/EKVLkev0sbbOSGKh/u2GrWMF?=
 =?us-ascii?Q?r1qlRdfOYFtDZA79QTrGqHMXHbPoYy6z2idKITxa+5SC55CO3g6mq++UvA2m?=
 =?us-ascii?Q?41GTkTNeljma88y9QMzQw0Bhzifn4Nw5uUu2dvSXyhROSkv0mfLhLh40d2wA?=
 =?us-ascii?Q?z3xaKQXT2D37N0TtC3BHDLEToqytpyIMWRb1o2jCjzEnGukTX4DFTKoSRkuo?=
 =?us-ascii?Q?U01angsOneeYgV94CoLQXCVXT8a8m9rtUjWvzb8BzE21VoVu+cv05rwJFDJG?=
 =?us-ascii?Q?wPdhriYcfw5SUocgQ6zLe+Fdrzp3v317a7PP5MCfj9c0accOcI8IXReOXLxL?=
 =?us-ascii?Q?O0qfVxMfyGgqCwngiEUmiR0s8WG0xWhwGmRq31aCa+ITsa2Zh2IQ6kb7bGeO?=
 =?us-ascii?Q?fTrWUNaxppUCpZurkT7tJVW+qbbGBEUGg+gQ9R+1rKjsDi5gyxma3ldfxoze?=
 =?us-ascii?Q?5ejMf7vlPCrYZxxxUTSgXmKtHwaSJvijG0N2uifV6qEkcDBSmGsM1AiLblKc?=
 =?us-ascii?Q?u2w8dREamgU5tF+8kBLyhrp+WYb80ZS9ZFWeOVRmHScL7lIOQE3rTnKYP3bU?=
 =?us-ascii?Q?lag3bP38eWbuE52jv9st+WsrizTZtnTyDFX9fET10b78owggeXU00nSNUX04?=
 =?us-ascii?Q?eSm2J7safAZQF0PvD2ZtVJ2f6fbZpFA0u8Ro4AJMJo1rMXdx8QcxHCjuKudd?=
 =?us-ascii?Q?ZZ56angw6Mv3gltcgtvsSKZ/M4h3fWGkg1N8MSyPfl2B/7KqmK6QgiIHdYd4?=
 =?us-ascii?Q?cX9u6nmjTNg70dwU0QyXKuxFzDtZDTIJV9w/3dM/O9k1nMsefBZyHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oox4OcW8R5GAV5WQHZo5t3B/8ve0N41ZXl1ShzopjwWG2nYtaxWld5a8Bg1R?=
 =?us-ascii?Q?p4uRIBDTMCH8kPFXsRXmOzzIRkEZ/gal3gFb0HwnL/nHICbPyanLtcBPFa4G?=
 =?us-ascii?Q?VgGj98AzYa2MVBfZqd/Hl+f5OSvBLpV0j2hgAduSoI7wVXcUoT6za+MVsMDX?=
 =?us-ascii?Q?oHtGss2jp9lwSrathR4aFRCvHQZn/xxfZQ0xGvelgn7m929aezmvrv+bTsBs?=
 =?us-ascii?Q?cFUjtSeTzMW4BC+YE7N41aN/dBdC2X0zxX0B1Q3ndxagrBgSA21d7Vhty47l?=
 =?us-ascii?Q?wWpoT3yoHJhd4PvB0ZggW+a3iopxfp1UXJ5vYBAG4VXGOpMtl2xVT7qcTaU9?=
 =?us-ascii?Q?dNa6IzpT4PgDa8U9B4w6yD5S7VIqg7umkMFGy3BnM/a6x0ueTKCw/G6Gj02m?=
 =?us-ascii?Q?bER+Ib2nbCLWDqFeE8pmFkH+PzwGkLE3UtbxTOYTSEOpYRS2lfbwQIgO7AF/?=
 =?us-ascii?Q?t9+U3z3rLXhx2Gt95y5qef5WZ1r8iuuZJfOmXXW1NF1R0QwZFCkUX88I56gg?=
 =?us-ascii?Q?dwmTf+beFuzAl+C5L8IDgeUdtDtSz886REQMRm/QQkA7M684ME+UCV4aTmMC?=
 =?us-ascii?Q?O1Kqnox5z9JIj1DkdX7ZYsK7XfyBpKALpH9Bb485NbuCBbwSK/hAS3LjK9NY?=
 =?us-ascii?Q?sw1KCbx0xZofMnA6EuRTJRG4k5QEPlxrZOMkNJi31mbsmBrQCYS7fvx4Whbj?=
 =?us-ascii?Q?23QCFP7FkOfAwvDC8lgMhFLE8SFUF92WeoQvJbzGKaYYL3qj/vqPvevz950j?=
 =?us-ascii?Q?nJVI4kKtJYUbH9z7hT2MJgLSGwO13NVDIKjqqR/rO+dY4jNdzxIiJ7RYi28w?=
 =?us-ascii?Q?F7y7/PNX3X/h65RzeXLIJKI/+Sjm9Zl9oO3yKkqcntkX2/uasFWPn6x5RIJU?=
 =?us-ascii?Q?WmSTlbydNnINekGChQINRt8zN1xbbhM+v74Sy1bCbvGkh6RyveVU2V7tF8uB?=
 =?us-ascii?Q?TUBGO4lEF6siKLB3Kjyi9Jn7YiynqtTjXsjHVHnqz4vsDq8NQ8OCFmYuZwde?=
 =?us-ascii?Q?quFyzV7SLcKcwWuvlgvbH6EayK2b+M3+WEqufTtt+jEGXPkawQTDMDuy8VOg?=
 =?us-ascii?Q?TOLCfdEHW46jrJDS0SHUJ8HEzrV++udvM9fS7O+SbQ8zXy20Q1IJEAqrh/UX?=
 =?us-ascii?Q?y8tXYAnDnFBqQQxU3TfCPYKjOa0ZsKpCVeiruIxx94tZj41QSbDkhVcJ/014?=
 =?us-ascii?Q?xDp2xmxTebi4aG4BHRjyxAIEoKSUPEooh8R+8fTQAJdsPJMhj+v9QZFtBsa+?=
 =?us-ascii?Q?q6keM+g5PUC6rDFT1h2GIXqU4bpiQ1yYyt5D/yxyOPj9FJSbe9NRgfvN7Yt1?=
 =?us-ascii?Q?yOun78xUMPNpYPQCkEhHptNGsfCvDEHCJzpdKlksA8940jlb/l14CFR05AE6?=
 =?us-ascii?Q?yZ/987JIsCNZA/UQl+uhhWojNZ9NdZSqZrdpLN4mqbqsgU2nv5HNXrogv8Zk?=
 =?us-ascii?Q?A5bvg/LCsTEqXw1k0mocp9noGzOuDKX6eYZ9S4ozzKZ11z/VXA1LRhWGiba7?=
 =?us-ascii?Q?CMBm1Uw9FwC972ywq9WRhI/Xbxl/Z1kYZZNkSxfyQloqDcxSqxULNxv/PwKY?=
 =?us-ascii?Q?ckGOIa52ePlqRS5V7u9accMRwGjSLrrJRSMMjRDC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fa4446-2ba7-4e74-ed09-08dd81730756
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:20.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCiNxpbrJMmch/5jZwxQE0mHjvLeSZBOqNTWNbWracF8eazp28OxMN/GSW+BOlGjB9Y5hENBTe1yKeGoACTR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update __btrfs_lookup_delayed_item() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/delayed-inode.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3f1551d8a5c6..dbc1bc1cdf20 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -336,6 +336,20 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 	return item;
 }
 
+static int btrfs_delayed_item_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *index = k;
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
@@ -349,21 +363,10 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
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
+	node = rb_find(&index, root, btrfs_delayed_item_key_cmp);
+	return rb_entry_safe(node, struct btrfs_delayed_item, rb_node);
 }
 
 static int btrfs_delayed_item_cmp(const struct rb_node *new,
@@ -371,14 +374,8 @@ static int btrfs_delayed_item_cmp(const struct rb_node *new,
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
+	return btrfs_delayed_item_key_cmp(&new_item->index, exist);
 }
 
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
-- 
2.39.0


