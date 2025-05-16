Return-Path: <linux-btrfs+bounces-14070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F5AB944F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407415036E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016D28750A;
	Fri, 16 May 2025 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aH8ro8ne"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0228151E;
	Fri, 16 May 2025 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364660; cv=fail; b=HlYns6kDDEEjBe85ozzpmPRf31zoGck4cant+7ROORSYB3nDQ//sV4a52LPRY9GhcihlYI/VStz0xuKVcvh50MuNGjKupqyrODQsjgTsqGvZ+a3m3MfbRhsaMfWMl3QdLlgqC+JEbeLCWkxc8AZ1oajLdIV5TbIYKlVnHnbtiuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364660; c=relaxed/simple;
	bh=OpoLFVjLrpF2edQ4Wdd7LyEC3t0ePmjAonj7potmYCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJUh3yBg1eOOVRTBQ1cVXBh9nDrO1A4rJF0/m9nDiiACxkf7qhQqjEQ+iHgdRSwZLzwPauiXdchIbg7VvbGw9o8X5/JcX3EXVC8T+jwRGGoX/K5Ya3b8WiIcrwNSTvPDEMR7//8jbEfJbUhok/cUeDjm8za2NIMDcVUlex8xmcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aH8ro8ne; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHrkaVKlOqNHUpaiMrrDSQOby67Lvn7tyu/Tace9rrgfXc9p427RtTYT4kgQ9OTvk2KE/PffERJ49C9bi0bEwk2n8UUoFPH+csHGn4buT/Y9iDhpGsf9gc4dLihOV1xgmhyENvO4UJ78mtJJSIBcmTZ/a9v5eO6P4Z4cKEfQaPSJuEfmesoYrjVMGAM8U7GJTfwQYjpF3h1FfU0Hjg0bsknz1SgHEYPrC1+1N7imacJg21hplOxCSHPbXA1L6YgdBZgICHnFkkWIRx+91+V1lngeDzCq8SL0VPaIOtXpSL/+sbN6OR/aTmLZ/F13urURmoTYRPaK/GqLTDw6oj4uKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax1bKhD/QyK1NCFP2x7dJgaLzmkhFLniKqypa4NZZQI=;
 b=fQXlgwk8R1N1pUO3WO2CXbeenXbBUpm63VOFhcAl8aIfmVF8tl5wviMMfZq+htUeC60l79HkMiZdxKH/lWhGmPNJPaJSwJcnN0FEQ2dLKOWcS05kuURlBLiqSK94n2UPFAyTyiZNfyQpJ+aXcI4Jzn97nhWVMprhP1HQQWb6+M9REp32i0arEDXzNM62KgKXHZMSEqfXCt4EitmT5LvX4qCtb3kEnSpVxHiA/K6+PjQOKwThnNFS0Uh4RFnqOcM6uOLsRU1HfESt7HkvkoNO09u9bgr/0qsPbeLrGPa+uZ9SNCahFm9NvdyFQLLchQzVvYyqx4QksNS+/Y5Zb152Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax1bKhD/QyK1NCFP2x7dJgaLzmkhFLniKqypa4NZZQI=;
 b=aH8ro8nexZYsj7Ebl6U1/nZhMvsmOjthwhNXiUbEs6ZqrJX9ZIr4sDQAvZaxtMiT359RXwrqFQx42ftBf0sVg44GGEdAvv4sU6/sTM4q7t3801eYThv41wO7yu7qKNC479IvURcoQ264EgW+GAlsRbJgfpHMg4ARrjhrpt2mQLe6WxitkO4LfJVsjQ20Iz4cMDiTAvPCLDliEQJI3rakDfrcDuJakQGqDeUyZnL35E4+M2etPjYHbHHEeSi0SIeoXepS+5puXtPYyuFL+QLzt9ViDW5ZMpxUMarn8AGSvc2Q9wXS3JME8cKRkY3sfzEgkX/RMqQqf/Uux3K6OUWzsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:14 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:14 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 12/15] btrfs: use rb_find() in btrfs_qgroup_trace_subtree_after_cow()
Date: Fri, 16 May 2025 11:03:30 +0800
Message-Id: <20250516030333.3758-13-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8be19287-3d85-4c9c-e26e-08dd942656fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rhhDx9M9GP62fTQN213aJUFT8czrOuMKnQ3xU/+VG1CxYOBdOP+CspLJL6bu?=
 =?us-ascii?Q?1N64FBYf5ws3OkIYOUx71wtH0uXtMJvBS7Q5/DDK4+37H2YAqzK9oE/h8CJK?=
 =?us-ascii?Q?21q3+30os0sqdqcUU61K1ai9sqSkZnYkGDjVVaYC+Bb9J1LM2cZ9A09sn316?=
 =?us-ascii?Q?5b5ZhbdjwgDWdfuI2L9FwWJc89Aqu5CpJ/uOX/f7U+TCf5lP00mZG+j6q929?=
 =?us-ascii?Q?+utizfuBaLbVug4y9r+Xipfqfb1lATu/RZYo3zS6D2FOQb/1be9H1piIDWrh?=
 =?us-ascii?Q?LllVLIevq0o4iYP85lEFlQ3U5u0YlE/cl4dvj2iK3tgh7iyb0bwo37fAZJ1V?=
 =?us-ascii?Q?KbZyubJWTOmVhLBoIieRjGkhfH0gkp1AANWQAjGbgdZjmQf8JNZbDBUHReDM?=
 =?us-ascii?Q?txPcKUfnsfNYpNAIgJplIyg4NMX+PyyFqAxaJDJVOW6J+kOVxQVhWquLGaFU?=
 =?us-ascii?Q?y0xET3W42e1K+xAyVuWaUPAPBHjHFlSSmvEgMb0QvFhjFdv26LTsVX9glY6N?=
 =?us-ascii?Q?W7+kqM1o2xjE4QLzCWcbaVVuPHa8WYgF7NqZMeuD91HTsGjS9tCs/Tpqz1vW?=
 =?us-ascii?Q?jum9peM3BjveGDcxfeAlSE1yOIeacJqAwTMVJaY0ukg/DB1KOfpPpIzHixzG?=
 =?us-ascii?Q?qZrP0w2lqOTkJ6ulDfbPaByLLGkynZ7KlZX0mNIKQA8+SRF1WFLa49dLNSfY?=
 =?us-ascii?Q?uTlfKSFAzNu78RcD+hq41UXDZ9ULhIVUOMABfPQJNrM7IDfMznrUWGwqXufl?=
 =?us-ascii?Q?MsieMO8bTTik7aEfAFH1HAJIS8PYu2iJePQ51ywIfCfSLsLtN/Pih0foR06h?=
 =?us-ascii?Q?K3WNAu8IYtedla9VVcuWRy0Jh5iwpVhn77vaTNcLWn8Lw4Sil04vNMbfOfrM?=
 =?us-ascii?Q?SGB8GhmNtFOUI7e19HyfWfbW+reCs+B28GdZVI07fPx7JF+SF3kzthNaUWu7?=
 =?us-ascii?Q?MfQeO2WR6IfbOXhrmwrvha9L0/oxo9ZI/dYy6OzBzJiAvewxvj5+SiB11bx1?=
 =?us-ascii?Q?b+jX1F/GR7UXW+Pz77qD38N1QF48Jpb+djdbXOFDKJmS9tN1n0mafYJ3Mdbv?=
 =?us-ascii?Q?QHFkpwOATtrg4dJl9Ld6PcMgWwSQnt0Khxt+1KOmGP4DWRMegrc4aE29UF4a?=
 =?us-ascii?Q?mfnRiPBGvBhzmmPlT2RhiWarDRJxG3CPfgxCXXFehY4qggwii9gCK/2XoI9o?=
 =?us-ascii?Q?yYfbNvKN4YPFIOqZQfuvE8436WyeS21KYaG0V1tRc2Q4VaQohrdfUCTNUMvQ?=
 =?us-ascii?Q?8qwAUqncFwgDTVZgwY/fkufELftEzGC3X9/taY5TnUelLjnDBk0s7+GYmx9t?=
 =?us-ascii?Q?hI6mifWnQnvzcAwzDklHsNGtGgjWfBDcsViBY52gLYVms2h6nmfPd3loR8jz?=
 =?us-ascii?Q?edn+kaP4AoA0LbBkTBaeXMS9FqbpzWSxkR8z93aL4zyVsqNtTuNKdsN7s30y?=
 =?us-ascii?Q?7mINUSatcByfjBed2X5IXctNrkKbBZFpe++sGf+OrXYqegDjWa0CJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AW/spohB5nVgrSM0Gyr/JtCVZaATVOlE/xJW9fKQh+Oqi5EUbTf0Ls26Plz?=
 =?us-ascii?Q?2BIEJ4x9kBB5g0LKbPp2P+S+eWHxvsUuGCvop5kxHL/KrHDRAuy3uXkaQZuU?=
 =?us-ascii?Q?MFDRXvy6bVC1+pJjUGz3Ttiw+v0Zg4o/sQxupi4iKxxlRNd8zbopgEM/Jl2Q?=
 =?us-ascii?Q?AeEPm3+/Cuvck1o49Lp8GlMFFpXZKdoMmWGVcl6XskhjF75RTYhp8IImL4AU?=
 =?us-ascii?Q?714yMgHHfQZGV9h8yDZuYT5lH0T0U3nyGPU4A0Dbq9skQsPU3YuwyRwaxnPB?=
 =?us-ascii?Q?mvYc27IGVqmb4pG3+z0cjKTMQ2+uz3UVf8ItXnnVC9Bl7y1GJhInGXiOJ9Pi?=
 =?us-ascii?Q?O7mm1Cj8AwsbSGjsISN3s4LZf3ibEUUL56WKac0HkLo8G6TJcMJ3l9A9ElfL?=
 =?us-ascii?Q?8rpyV1w42F548Kr9gF+YQJWX74R5UnR2mWPGkFIyKgBgmulIyAvLcuke39x2?=
 =?us-ascii?Q?RDECehkE3Ub+S7Lg0f34Rp+6kb8ZkeQ/FayAB1tv9dTEkv5HciAJMgFZ2A28?=
 =?us-ascii?Q?t6QtEaZN0+Fo3H2upliK8KSPYuDoyslxK73V8LNefJXIw4yZ7V7aUyrBXVdn?=
 =?us-ascii?Q?s5DjdMkz/H7uRT141uth7RtqXEjkTYxp7C/IRWIiNgbfK/rrM1/cS0CYpIuO?=
 =?us-ascii?Q?P9h9yd+pMy0W/bGs5ogxOz79H3MI8mcULHGjj6KtBbWzbrXe7gOZQxx5JL5q?=
 =?us-ascii?Q?fI0gJ6w+MkUNYM+2VotCPVdscUgrE7xTtKxSWcUVQsIFW0aZIPqHTTMfWB7A?=
 =?us-ascii?Q?AYOL/arzqNDyC0iqRg6oZwbnCXrbFHXg01zioq52bH37832aZ6LRkzLTwCsx?=
 =?us-ascii?Q?0xFlbA0wrMNX/X4/DPtgtQ4mnt9hHQLAZjWFzlcGD2ZKh3GEhyLhVCGcRfri?=
 =?us-ascii?Q?Kv3kAfv4lrb0xt2jVCw9xOhjViUYqWoP7A2RS2v/NMV9JVQZYnRHVHKjDm8l?=
 =?us-ascii?Q?8gHqgr5Fo0AONoROZitqcaKJY7QfJJQiQ17ptPl+q+bCK/Ue8Qg/HVk0up6P?=
 =?us-ascii?Q?CEXPST3tJEl5f0126dzIaiIIVNY7Jn4B3hX7fB6reXFCPL8/jGcv0X+d+XhO?=
 =?us-ascii?Q?tA59v8efqYlI5p851yiaa2mbVZ7/idlrTBdNFdiiBNR/CU4kjcy2Eosh/bIq?=
 =?us-ascii?Q?a3ztcFccYgIe9YywY6g1vKdjiddo5pJr2E+vs4jeQe7JREh16MPAeVxlwFpR?=
 =?us-ascii?Q?WNR4bpN5eUkwOMN1Lycjgtpk+AtJ7A2RI4KHQOgyZFcNlC0pSWswQtR7OKY0?=
 =?us-ascii?Q?yzRrnkzvHbqnez119LBhPeS/N4udxSVSAPYvikaGcRVaa14Wu9gxewsnFc+X?=
 =?us-ascii?Q?h/l2f2IhvmC43jYuy2rI0hu7PYbnZ325kAaV2GFtokhD2bCmbLI2gBUjbiPH?=
 =?us-ascii?Q?cqRbRLXcyTHGXds/sHjxdpi/ly87y44hbs11rceWz+oZjYnuNFTGSQIZvf0L?=
 =?us-ascii?Q?TAN2UgLGXUUWNWEjnq4QldLYAxj7zvRqkSaM7O4xRdDvfDMfQcBDLE8oD5C1?=
 =?us-ascii?Q?pxkyB8o4koE0N59v4BHf5caTlj59PezoSafTuOd5vdAqeZQpVzPM1Zsw+zdU?=
 =?us-ascii?Q?TtLBhJiwvmmmCyoA7JWJrepJSlwLvOkdyVbhY8YJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be19287-3d85-4c9c-e26e-08dd942656fd
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:14.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPgeJ74a000ZfvxrCl9dqemFG2bA4IwsW5OYFv+y/PXTTP8ggvnorH9Xvu3ZQ1uJ+yMEeZuhcCsdAcV7CVAzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/qgroup.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 683a35bd36e9..2e8f6ab004e9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4671,6 +4671,20 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root)
 	spin_unlock(&swapped_blocks->lock);
 }
 
+static int qgroup_swapped_block_bytenr_key_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *bytenr = key;
+	const struct btrfs_qgroup_swapped_block *block =
+		rb_entry(node, struct btrfs_qgroup_swapped_block, node);
+
+	if (block->subvol_bytenr < *bytenr)
+		return -1;
+	else if (block->subvol_bytenr > *bytenr)
+		return 1;
+
+	return 0;
+}
+
 /*
  * Add subtree roots record into @subvol_root.
  *
@@ -4799,7 +4813,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	struct btrfs_qgroup_swapped_block *block;
 	struct extent_buffer *reloc_eb = NULL;
 	struct rb_node *node;
-	bool found = false;
 	bool swapped = false;
 	int level = btrfs_header_level(subvol_eb);
 	int ret = 0;
@@ -4815,23 +4828,14 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		spin_unlock(&blocks->lock);
 		return 0;
 	}
-	node = blocks->blocks[level].rb_node;
-
-	while (node) {
-		block = rb_entry(node, struct btrfs_qgroup_swapped_block, node);
-		if (block->subvol_bytenr < subvol_eb->start) {
-			node = node->rb_left;
-		} else if (block->subvol_bytenr > subvol_eb->start) {
-			node = node->rb_right;
-		} else {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
+	node = rb_find(&subvol_eb->start, &blocks->blocks[level],
+			qgroup_swapped_block_bytenr_key_cmp);
+	if (!node) {
 		spin_unlock(&blocks->lock);
 		goto out;
 	}
+	block = rb_entry(node, struct btrfs_qgroup_swapped_block, node);
+
 	/* Found one, remove it from @blocks first and update blocks->swapped */
 	rb_erase(&block->node, &blocks->blocks[level]);
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-- 
2.39.0


