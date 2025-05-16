Return-Path: <linux-btrfs+bounces-14069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF21AB944E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFA51BA7E71
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891FD2820CA;
	Fri, 16 May 2025 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Og6OskVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB5231CB0;
	Fri, 16 May 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364658; cv=fail; b=Qtd/p8sVTlMn7ct6KGjm8313HU4sL/F3Y2MCrqa1ou6gto5tSfbPR4D4vvUSyXSzmUX0Oiz8DjtBp202FNW2+m2R/ZZnH0JzoSZrk98IPizf1TFjnxJ2I6UlBHwqhemrfCv9/pN+dBRgxucb3b82dH1HJeouAJ0S79Ebr6x5KQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364658; c=relaxed/simple;
	bh=+pJGx8H1w465DtIlB1aYsrYD2MHcvGl9m6vV7Gn4qCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrKJMFT+csJ0Tg854zq3PM/DKBfrW3VPcsa1hJ2Cc18a7rhz91Yzwfn3Vx0S5Dn55Cz1Fc5OG1nb+1mFiKMp0NWNRyLiWbmnnDyaK2NWwR/7pbMzByAqQX5lt5hP+TvfqTEtnn/6cqeAET4u130vpuy6CWanGPCCDuXEhU5qJc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Og6OskVn; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvtBoKM0Wg52ouxN8Cdhcnbp1W+iY70Bh4z6dP3dVQZfLPJJ7IuOzI16jwH0LyPQ9fKB3ZE3rzm3L93TtGlNCgdd3OLNYrwuU5y4D0UqSf5d35U3wjGZghufgE6kUNzQaEJUuDas7dL3+G2NQFqKm6LFh+eGI+psnBo3Vl4eFc0j6klATB2cJnwGWSYHT9CxABi85087c6MV75nvSKcGgZTBQM9o4qB+cCpAZXvEp8ecbnUbLbxBlakFZkjqg98soOdlnVDUIqcWEoQIAxUgPUoCQYrr38RlYjlX8RSDJlw4lKR7HPTzdHdPNNZKOdmF77C/05Poyi5t8abtURZBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkoPAgHEdrmEzSBqZqNMoPfHTxK33pPEtYeVlbB1VlQ=;
 b=RCeQPqvb4Gtr+4pVV0So4L0G3LrmuVrnxRLZRtA0h4y4clkK+oXmWre7IwLVDiSxaA0hKwOHl7nePLPF9AuoPrwd3EDFi/KMO/3UcRyBz3yyJXM0CL0jYJaHOoyEsUeseEYcONLoXHqV1jhDqjUJyzocpSy88Huv62ClaKDNc+lpDSCFAeJmpR7JrF3IDzAZfuEsjvZ1xJ/u6fSww6mK0l+VtfhKsnxOK9DigzrmW8QIyxs+6+UP/cAcpVb9WSfxQBi30yEC5VLIU9Ja3LfuML8JSTQ6dsAt/UYt6kicbcrQIu9eVXYL0lhgDjzuIv6Qknd47P+o3zCrJJ01qx0VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkoPAgHEdrmEzSBqZqNMoPfHTxK33pPEtYeVlbB1VlQ=;
 b=Og6OskVnnwTCkuWnRG/3iH30f4gVfrqtYmPQN2K7wVhQdWy9TtcFYpHPkkKkOsgkLDDalzQiP8iv58GZBRuZS0lWxFHL3U7tOQ/m6xxqTxWwQG0VUdXLvyALNng5W7icbdxW/EqGydUCjPkjSDCzMaMRXfcfCDrGbA4l/+wqcNShuW2p59seuSxSPfUHFHNzMxiY2ffAZf55BEsTtTV+nbNJZ122ChQS2+8pKreqCGoS/cm6m3LJCw3Mha0yNGok1VR81QyMtK2RHtYBazluV3F1XtGeE8SvJh3PnufQtG/LGAFOxLzJjgIif3uMITn5nCE81dohVMw5fopLslm9DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:13 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:13 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 11/15] btrfs: use rb_find_add() in add_qgroup_rb()
Date: Fri, 16 May 2025 11:03:29 +0800
Message-Id: <20250516030333.3758-12-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYSPR06MB7646:EE_|SEZPR06MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 25311cae-8449-4648-a11b-08dd942655f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAcLnoNOGvXQm2CH+m8HzeT/I2PK+Z/NUTIqfGDEDSTevvGWKfITUyP1G+dY?=
 =?us-ascii?Q?x0bfvLwkyaNv1L5mpcctF4uZ9+R41DINr922FP4vO4v/RcyAD96l1ICz1rN0?=
 =?us-ascii?Q?3Rv5mDr6luF0SRFyyZPRRx8snMx14GXs/Wy95xK6ESF94jvpWweJfOtb9TyE?=
 =?us-ascii?Q?ZDS+aOphnS7OLrSGwZqsGvuMZ8K4OF1EIPnp3qkDmm3jsYYcBQ02VLr/4dvN?=
 =?us-ascii?Q?rorjooQ9wJjXYlXI1qEAh6RlVtvaskgzLwRfnwOSV6aR3LUfUUp/P4fkkANd?=
 =?us-ascii?Q?7rHQCl2ZzH/sUQVW7cBgcml7UuC9TrGvisT32ZC8GsIakF8kZMWAfWXjpcR0?=
 =?us-ascii?Q?WDMVEnEPVN+6YST367HTguhVzTWoqWsaG51qAMKqkNOJQieWzVa8A7JwMVTn?=
 =?us-ascii?Q?tWJQ6Vb1d70d+S8jRC88Wbsj/b/1cEjKfWmt9FbObgP3Q74XzHSBxGd3IB2X?=
 =?us-ascii?Q?rbLw303SJ5M7Kv8dmDLaXFir6zrtepzNqRFlLh/U8ximkM0rqIf7YUSlxov7?=
 =?us-ascii?Q?qNsHIg8dKikQGNeaI6HAikFhcVdr1p893EIEA+atm/dzDYlUZGVlrmQPPaWZ?=
 =?us-ascii?Q?D1OQscvzePfqG8fYqinaYbAVPBnfl0EplonorZSgd+xMtZ6i/Jdd9kM+4Z1V?=
 =?us-ascii?Q?JqcqMs7bAfk2qADW6Q0ka84nly2e99qD6ylg6AQQimDRSMPq2sYuWfhyhNQN?=
 =?us-ascii?Q?DwujsQ/2ykpHcJa4H5VSiyr2ARw/+14RJ4XmQ2ZdhFyVYwNlXpih91/1YVj/?=
 =?us-ascii?Q?Xx5lXy/owQVhSTD9zxeyTfWdywQwft8hbcNmJH6s/AS/s2C2KZeMz9h2NzBq?=
 =?us-ascii?Q?f3kjJzGzWQywEtTnUc3YyVGyZGqlBVJu7CLzipg/o0RT9t0fktJRiRDCtxo+?=
 =?us-ascii?Q?oPkzEfmroVudOz/TVLW9MhDPWkv5jA/OBJ3SCCL5yIo1l/Veb4EWHsYVxcxh?=
 =?us-ascii?Q?DJdB917ZQZsC/dX6Gz+IjWhXAWwfnDDkDKH8rOqrfwHMTQvfZMWiPIQVKgLX?=
 =?us-ascii?Q?lCdYi2PlV4WBxuuFQsDPwviBbWjuZCB0F7tPmogLi3pHwSSh/6pYqTz+MmC4?=
 =?us-ascii?Q?VbxEQMKnf8ZGaxrAWFXy7fwpg8oAEvRhOrJ4861wy645iENQBP55Zbih9YDJ?=
 =?us-ascii?Q?baeAXOicQwXCB+YFxiwLkywQgj1LO/SpHtSFXjps1TaKiIp5P3uT/uc1BR+7?=
 =?us-ascii?Q?BscFqOSwO4LMr9amIXTCTqjpBBPbCzkvFlXaLbbppoQyVbCrcIkkrQCSYWWV?=
 =?us-ascii?Q?LrfXPkry0P573EXR1IQLa3jmKDO3q9ApWqXs45Wa+XDn2SfXun7muIMk+vjg?=
 =?us-ascii?Q?dK39CS/vyZp5TzOZuAH/7AKWZDz2jru50LEcMvRwxHdazCaVd3Tb/YGu1yh5?=
 =?us-ascii?Q?owDO4R3gl0bi/qNrFSDtmBb8LSWeirJ3VEqsboAvqaBQMMpZ8I7O8KQUUiJP?=
 =?us-ascii?Q?0Sy1cwBYI/t3hk3s1T7TNFaTxQ3S+Fw/JGceeQQDeNsaqE6sOMXqjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tpNYWmg3cN7spLC87G16yNmqGaYuOBejGj7mD7iDaKq/vswpH978k3kefQ4M?=
 =?us-ascii?Q?j00DDYlrpag2LnW6L+AkUStn8YnZGm+TMJaqCT1oCO4WuHQrQjmmPnIpDwsy?=
 =?us-ascii?Q?vpvWj6UyljJblNrqPNu52FPhNdVsigAUD5IRtmPKkdUigu7mlu3tM+ayxUwW?=
 =?us-ascii?Q?GWX8mMR2Ip1N1GvwfY/YuShTduiwu+Um1xJPuYvbmk9CXY9uJW3FetAQWAVp?=
 =?us-ascii?Q?QobHhKRSz9fU+9V4grImTSaeROPLjlc90J4Uy3PJsumfu5PZJrRWXhkd64P/?=
 =?us-ascii?Q?xJEbdlZdIJFN+qkEBA+Qh3rm74/XjismeaO5h9wzC8bYGBY88sbKFPxrS7Nk?=
 =?us-ascii?Q?sDncXTaNcIz/l1c4WHuK5bMy4166ajcO1zzxBXRW42E621tvIXjbahIpFmc7?=
 =?us-ascii?Q?jHluV9gaofqkjBmHLpeodfcWSC1p0rteSIEgIb4Vjl+7GN7FT9X7FcZh3/Zi?=
 =?us-ascii?Q?EYeOOvfVEdIniDwXtDOFdc6AZnETZF6oBTEa5aMDJhReVWuuW+2rgWE/R1S+?=
 =?us-ascii?Q?ijiY/i+RnpTg3PqiaU4EdXW/DU7KMk3XYD4jNXCoZ2qdUZtS4OJvstLo4XYx?=
 =?us-ascii?Q?UX3o8ekg2C37vrs8hu/AcPLF20pzNYP1wnp+Y4kNhdd8FJHHlOIAEeWm4IYA?=
 =?us-ascii?Q?sovh80ottnDwIb0qgyI8e36EwAnJRqjd6DMFhbyDXmfMRf0lWfe9YlG13Ayl?=
 =?us-ascii?Q?hymZIHrGuTA3Mmd7fuC/WR1YUa6/P6sZKsEFn3tKCrFY8u2br18k/vt1YLFX?=
 =?us-ascii?Q?sW7BxfPxZw2doO0WoUpi8NM9/96072tzTwRyPxI6Arv1iaqbsHWlKkeHhFZB?=
 =?us-ascii?Q?dwFzf0osvyWSgMffXKxGpIyBIYh0krKKrduLi3HNUfhqpY0jbkq74GiL9jU0?=
 =?us-ascii?Q?cfeNiGw1gXSMGszo9CdSJLWJENV8xAL1oZgdBGqGypoiK5o9hJ5lgZTsHUR9?=
 =?us-ascii?Q?IPYiLC5O3/QIXmyt/D1RCyJjITKA1PhDgMrYX6K/UipaMgd4k0kumzNBs0Ks?=
 =?us-ascii?Q?eI5CnwKz5abRGUQf6EjQAgrCdk4DOd0ntEovnSW7PJhtOT7EG1xn1uUChmJc?=
 =?us-ascii?Q?odrcqymV9KJQxtSo2zHJFiJfUNw9ywSSNJD53oxHNQ31kHxHzniiwNiUhw0M?=
 =?us-ascii?Q?7X3RAK90ycf07xEFnfa1Ja35OL/81A1qef1UnULVq3exUZZb9HlCT9NVK2Wa?=
 =?us-ascii?Q?nNfLQ82U5PN4rUFbx9S6keUXu/wycttdh4jkziLnK3tQd07bvlGdfMnKZVnh?=
 =?us-ascii?Q?YEn1GIshZFV0xGZKaisLhzlfkysXuFH1j86/ftWPQr7pK3sBeiXCU9cTdzY8?=
 =?us-ascii?Q?RMz5cxhPTcZNeGTmfI+LCDWGbYIRWr5vsWjfMjGy6xRq8DWiKcORM56bLhv7?=
 =?us-ascii?Q?+Q8mZwfm1ZsMSLB1uqlZjhiXcfJdEyMIgW/zEu+oH0vhhIuu8FzZTmgQdRrz?=
 =?us-ascii?Q?sM14xXfkXr00rZndvYb5eUMlB8ll+RTDIjBrcUmLPTr4cR580WPovdTEsSCR?=
 =?us-ascii?Q?o9uWxYVON8JGjes1I5yEIuGNFyal+ldrjIDifRF+9OpRVvDXpmWRTVxNp/m9?=
 =?us-ascii?Q?MNgwsAyXv5OojufDevcA79nMgBkCxA+hEBEuMJXK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25311cae-8449-4648-a11b-08dd942655f7
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:13.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL6mi0Xcd7S9NYryKV6nTd1ZeGGdcYNIO+dn3VzLWx+YrEBzTVswSnAKbkCu1wh1x7hF9hH7K5vjfAkNuotf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search and insert
code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/qgroup.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2e2a76c3e92a..683a35bd36e9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -183,6 +183,14 @@ static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 	return rb_entry_safe(node, struct btrfs_qgroup, node);
 }
 
+static int btrfs_qgroup_qgroupid_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct btrfs_qgroup *new_qgroup =
+		rb_entry(new, struct btrfs_qgroup, node);
+
+	return btrfs_qgroup_qgroupid_key_cmp(&new_qgroup->qgroupid, exist);
+}
+
 /*
  * Add qgroup to the filesystem's qgroup tree.
  *
@@ -195,39 +203,25 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 					  struct btrfs_qgroup *prealloc,
 					  u64 qgroupid)
 {
-	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct btrfs_qgroup *qgroup;
+	struct rb_node *node;
 
 	/* Caller must have pre-allocated @prealloc. */
 	ASSERT(prealloc);
 
-	while (*p) {
-		parent = *p;
-		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
-
-		if (qgroup->qgroupid < qgroupid) {
-			p = &(*p)->rb_left;
-		} else if (qgroup->qgroupid > qgroupid) {
-			p = &(*p)->rb_right;
-		} else {
-			kfree(prealloc);
-			return qgroup;
-		}
+	prealloc->qgroupid = qgroupid;
+	node = rb_find_add(&prealloc->node, &fs_info->qgroup_tree, btrfs_qgroup_qgroupid_cmp);
+	if (node) {
+		kfree(prealloc);
+		return rb_entry(node, struct btrfs_qgroup, node);
 	}
 
-	qgroup = prealloc;
-	qgroup->qgroupid = qgroupid;
-	INIT_LIST_HEAD(&qgroup->groups);
-	INIT_LIST_HEAD(&qgroup->members);
-	INIT_LIST_HEAD(&qgroup->dirty);
-	INIT_LIST_HEAD(&qgroup->iterator);
-	INIT_LIST_HEAD(&qgroup->nested_iterator);
-
-	rb_link_node(&qgroup->node, parent, p);
-	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
+	INIT_LIST_HEAD(&prealloc->groups);
+	INIT_LIST_HEAD(&prealloc->members);
+	INIT_LIST_HEAD(&prealloc->dirty);
+	INIT_LIST_HEAD(&prealloc->iterator);
+	INIT_LIST_HEAD(&prealloc->nested_iterator);
 
-	return qgroup;
+	return prealloc;
 }
 
 static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
-- 
2.39.0


