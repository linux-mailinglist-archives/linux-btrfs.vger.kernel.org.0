Return-Path: <linux-btrfs+bounces-14071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE116AB9454
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FFC1BC5EB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15B288C1A;
	Fri, 16 May 2025 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OHprdw/a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D902868BF;
	Fri, 16 May 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364662; cv=fail; b=ZAYOsJMlbE3nn9RK+G+rfWFVQs9JsiX5WwKlsvfeyHlRfByKlcEtMeLhlHxZkSYn23RWgJQsRzujO6++6CJp1K43ncE06CRSwIGO26CZYFbbBqBEEtoQQFcTbS0ByUO15zCMBXxZnt2AKZ2jkRWqXblcPD/SqWZTIxwtj2BnqPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364662; c=relaxed/simple;
	bh=VD9UJqgOadgTE1lrUil1vFVauRkLPEukhoK9JZGQajM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwzI8MC3eOCVn98DosnLmJYic1uP/UQMvF7VaVEC/Y46oAOvggsa4Q7+fbJ3ofHtSgbf8eeD4AayA1qEqdELdJxjdt6wz8sSai9EC6vAiOhRPBufvoo/ksF/DW3tBtNiM60TH+7nbvzeKUGC4vfWHEW2Zy/QibFCsNxG394+3UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OHprdw/a; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzIizkKNyMz6S2EIYjBpqIFnrEPDnauSwQQyfmdFQa86QKaaioAPoGEdVSe9dCJz4OcBCTkmJ0n8rIXxGWS5uhxil6ptDti2o3rJGD03UtHsVgSJ4Xn95X/GmERT2v1+kw0B5LrxAyzfIBDZ8zEFbHTl53J7Lo2IkBhJT9nR+AaA/1iFDjxQe426UInVKcw7JNJ7RHULyeGrbUgwQp8zddFq692+z/jpQCda9UQcLWUsThW9hzK+dj1OtBTtp6R8oy4U1LrPztx4GXObLNZqwfoTIAE+wIFGdXu78V1uOAU2GOvXBUEVnB2NNwkwKbw5NoqVlLEjkeKlI20f7Nhbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQI7o7wB6TGMHyE2FjoTpA5v+YtJrTYy19j3HM0HDWM=;
 b=LW01oOKmb3ry1XgFV77KiBxJ8dPdAv1gASViOCQbm/BOqs9lxpzDFqAeJqW8Kzu1GNRCZZdDbQ6r5NhLzHIV9uJWksFqzPIXnEVIJ49BXTX9ke4O5RtY4bg7JKnkPuDdTtmeszCRHH4nDrp3Y81q7qbh4SMPoTCzRFEcSZ72vovS/oFmICxmHNuOhhQYuVy/btwOrLsO93KOY+D75VSVG89fhVkwKqeJZvHPzpMF9XnizQb+C+kuJwQbt+1BYTLiaOt5vGGO+sEU8CgVhakKNx8+WWKcfu9yqpY2Va/4kfk0Fs3dAOhR9eifXvd6JUE/DofSQrL8212mUhfxeMUYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQI7o7wB6TGMHyE2FjoTpA5v+YtJrTYy19j3HM0HDWM=;
 b=OHprdw/amVR5NoSxp/YHLIC2IIJNI5vknOYvHZyucBnK46v1EUoVLMHv0n5VOZ6QnPQhUghaB4HxUJjecZLQ8WO3BkK53TSwzWJjyCW8BTI+YO+NHIlEnA5WBMyS4ilzcrEqTM5ACjXwgjRouKoiVbz1VvvdTlfcpNLZTLPAnWwBK2N452QL31qeaAX1MtMx2cQEYaTZnVx4gYGDJtOEyt8MX3z2bi4JgBzlXsnfpjmBQ8B6G0xk4EXGJCSArVSM+KI2vWSrNFi0G+NM3kgfm/FjWEYKTrmJ5yalSUXguJ69KIEhEx83mifZC1zq47etHUUv5zFvv5iQQEyQ+5LW5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:17 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:17 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 13/15] btrfs: use rb_find_add() in btrfs_qgroup_add_swapped_blocks()
Date: Fri, 16 May 2025 11:03:31 +0800
Message-Id: <20250516030333.3758-14-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1955bdee-8b53-41f2-899d-08dd9426584b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wH2FjLcqm4fW/cZi8pjOO/ULLWFdwVojane+nXdw/HGYn1LzP5fN0kDZxF+?=
 =?us-ascii?Q?4RwtV7p589bmx9u0NvLeDAJEi+LIywA3eWGjI5awlgptSFr8QF17DJpdRYwu?=
 =?us-ascii?Q?FIHXuG2FgDjx8puU1eJL/nngs9UqEQC7N12dP1qkmZE3C0YRj7JVubeLxiC/?=
 =?us-ascii?Q?sm86x66sj3xWopxzqqFV1SfuA4Jx1JS2fEhp7/PqixzJ9LOsP03Mczqm7+bD?=
 =?us-ascii?Q?ucEGczmJgjX8uUVLvchnreb3dXkt+cPL62Rs+maYpqCH8lzSsWZ/49ZtzNlv?=
 =?us-ascii?Q?tNBGiSv2oipz70T6jedeZab3QnL9x+XbVf1gG7Mcws7Szc30gQLZvddqLN0o?=
 =?us-ascii?Q?HreJrxVAifN74aJ1ATrDvtX6PZo8VLMgzCUi41jcxy4CJY/4+EESxbpa+3PL?=
 =?us-ascii?Q?Fs3Kcsa5GaLoiviKyx79ae78yZ8phQIVuvbZFCgFJJYavGJn6vU5LGQlJLzB?=
 =?us-ascii?Q?sai6tzBybsdwWxXFTBvr9pMd2lnap365b8eBZ4jqyvpUcfosYYeyjsVuxeg/?=
 =?us-ascii?Q?BfEOSCkT+h/MUchT4ObzGW9jZ6Tz+s9IhGRDpltuBMen1yjlnkWhWwUTRa0X?=
 =?us-ascii?Q?08AsyYxrNf2WdAgClt7b8Wuv3X5nEHduRFz22a43jLk/vZX5ij6Y0YenX3xT?=
 =?us-ascii?Q?/er7EmnWkVa9ulGZsUEob+ORmmOaP3hNVUiijR+8pBvaBn1GfNxsDbB1+x0i?=
 =?us-ascii?Q?C2qhxPxJtlQ3I/jtGmFuEc96/mOmGU2VBV7YYME2SIqO+2xajQo495mR4/Gh?=
 =?us-ascii?Q?I++So1PivE11tnpu8fD+y+UOb+uzbL+6OTz+eBQuKKjdckvYL+fzMNlm62oB?=
 =?us-ascii?Q?B/o+Ec7uIkVTimVCkOE1Zn6cm95Cv7qfG1PE1TzjxE0msKcUNe050l6mwdaD?=
 =?us-ascii?Q?K25Ra3xAGXn2nA3Yr2I5iNmPIx5rIe01BJQQInoVGltvAgkQvbldIrYJ7BBK?=
 =?us-ascii?Q?ZnDttJ5qqFHKg8WzKbP8js+cPJxYAwMEiI/RBCqygSZ85LfemscBhPh7vQib?=
 =?us-ascii?Q?+r8R4KPd0zCNQK71z0AHWccKUnj1JcJn8MOOmjFKTht0bf8Ec8wOGI98055i?=
 =?us-ascii?Q?0SjBaIydpDRVXlleUD6YLlhE5AZMReCjsgpIfV/3n1dYOrxMratbpesMp45G?=
 =?us-ascii?Q?tXiLXyFltxZt+AGhv7Pdy52AcTXwwW42PNERoKOBm14F18M3qakQRRjgq173?=
 =?us-ascii?Q?DBBo4tPbr7+x/dVzRFMASaE1wYfO6TdAqfdm9w5cV/EnD4eiIEPrGbeROkf9?=
 =?us-ascii?Q?8AvvyJ3X4rL7FkcuPEHL0OHl3RHdYEHOZCHYKefN2rIWTYVl+mYqNyyo9JAE?=
 =?us-ascii?Q?sxptMFVhOp8+7nIhlqZMzHzwGd/Vix+C6nleHTLs8TkNOZB+/COhOd0wTepF?=
 =?us-ascii?Q?HnzShggxQ+hoI2akdAjxQQL4Yp6r2HSxwVv0XIWpQmk8uIB06l/fUBt6+yEl?=
 =?us-ascii?Q?MJT35R/4/WEea4df2kw8ypGAoARIBVFeq26PPgy33mYWsNSlIT3NfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FPhJUmTpcLq4BVrMbsdgvzY0B0T7nq7TgtyR/d7/on0hujS0Gz27POD86+9?=
 =?us-ascii?Q?e190kZYybeVA8H2QU9GLbTrZrDRnirM4aZp4MrJXCQabLe2zwiUezPP6FOnV?=
 =?us-ascii?Q?NE2zhjuYasMumrnKnBri2wzwo+VTclEwZOPeHPbe4rJXTpk7t0uC8EzCFtcN?=
 =?us-ascii?Q?ys+3B/ykUdGub83CK6QYPT/a2xM8S2Yygerju+Pn0f3oEXWpGDJsh4L20SB5?=
 =?us-ascii?Q?V3/hmifCMsyaQukGOCrcG23GCLKXO5iIVT401XIhbN6R7VSBRwkH+gt+28cy?=
 =?us-ascii?Q?+GfTgdjfv5hHjpXrIMNLCMrt7LNuLuW5adlUP4rbLwILMD+MeL/tGTq7mjT+?=
 =?us-ascii?Q?3vLWhtci9g832HhqchOMx45MnAq5Dez3s9IEQ23UYwSlMxTffa3xUQViGE3V?=
 =?us-ascii?Q?1xq47zYDzPwchup8CC5bKeqHobFKPtpHxLMpUugD3diDsEC4cd2c1nYGqpcf?=
 =?us-ascii?Q?kefL0Z61j6kLBzrLOjOPVmk/hQOYS/RsA/mPeq7/yOsrovGyBWsH0fppl1qj?=
 =?us-ascii?Q?OluqnTOhBIjymILZAsbTzSSDpsAisCbt4uCu/FBwzpx7Ns7VM2E1lUPgPvI3?=
 =?us-ascii?Q?Tr4MYPJB4LHKCeJyPy7Rwfr+ciEm+U4APUfMcexlX4P6te9NMN3bksNIHOU+?=
 =?us-ascii?Q?4HiDsxePXGoyDd9c7dmoWOkkOLFHhlocLK1zkXNbxWrIi6FyRxve7zW/swIb?=
 =?us-ascii?Q?vIty0VVWx/zwq8uJcmVR1/QwCyGpvOe63T4/9sMSAE6Z5CkFI69jheK3YCLi?=
 =?us-ascii?Q?3e3qQOPeCpzW8mVgCbbdHF4zD0xHfWqyQWvPoFhTTHnJbjB4PVYWofugwdns?=
 =?us-ascii?Q?SM9AAU8J7/QPj7XO1R8ISUm/MTN5BnQpZDACHAUr2Vx7huDMEA8nnD12+bV8?=
 =?us-ascii?Q?wVgZMb5Lz6zYdLLCswTiNhTlAmgQS3z0H2LYG+z4sU2XYunNk7hdBkSmHomJ?=
 =?us-ascii?Q?Gb0DL9NaPlZRUWVcR1ER2Sew4GnyCuIbfOo8n9tN8eGSpgh+pWkdPAq1h7TK?=
 =?us-ascii?Q?rdr3A12SixsXzvVLT5nIWPa40eC8ZU787et4z470VBY0oGwoQhIvVZLfNUaA?=
 =?us-ascii?Q?HRQJClaOvEMg6sB4LO5Yzh02qhOSFHKKVZSsFUntIM+AFIc3TYnUCC8zlo/p?=
 =?us-ascii?Q?DNsIUnk1LMZ7u8o5ZeiefG3EwN6S0v5rhbXphvb6OqIx7owyaemxWu9/+nUV?=
 =?us-ascii?Q?Qoq7X3HLYx0bIn1t0QggN2U2k7pR5NLIGHrLk+79ustb33EWu/6dYJ2OJtl1?=
 =?us-ascii?Q?eC6108Pyev8CXZyB8As1jp2HaxEcxUMtfyxu9ytVtHFx6i/OOtvsqwotujmW?=
 =?us-ascii?Q?B7erTDoPURi4B8AsHtZu17pBhj+4HDhfKU6h39s9tB+MoqxfWmadeT/A2ZrT?=
 =?us-ascii?Q?Szkc/J8Hk0H3YvtUqtdCxiCOfw3lC/XT7WLK6p3CTj/tGAsE8KR2dSxtNw6S?=
 =?us-ascii?Q?fk3MBTkp6Q4tk+5gEndUdhcB/6Q1uuv17UF/O7EbsXtHmj/zXKumlOrFMXnY?=
 =?us-ascii?Q?jE3muwJvgCEYcr4t12oANyWaKJEFWnx20XXRbcQTebbaV+6X+EL3n8nKfx5q?=
 =?us-ascii?Q?KVGKVnNCEi4B9kxGnG0PmLnXaKNmlOgwMH0w5tAY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1955bdee-8b53-41f2-899d-08dd9426584b
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:17.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSZxr5DIV8b0+1b0PXNxFdBB/2gYlmvARGIQ+VAfDOjazbqq5pRlQ70v32rGAUwQIrPmt7y83idRJCZATtJuow==
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
 fs/btrfs/qgroup.c | 59 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2e8f6ab004e9..e9498c6a55d2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4685,6 +4685,14 @@ static int qgroup_swapped_block_bytenr_key_cmp(const void *key, const struct rb_
 	return 0;
 }
 
+static int qgroup_swapped_block_bytenr_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct btrfs_qgroup_swapped_block *new_block =
+		rb_entry(new, struct btrfs_qgroup_swapped_block, node);
+
+	return qgroup_swapped_block_bytenr_key_cmp(&new_block->subvol_bytenr, exist);
+}
+
 /*
  * Add subtree roots record into @subvol_root.
  *
@@ -4704,8 +4712,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 	struct btrfs_fs_info *fs_info = subvol_root->fs_info;
 	struct btrfs_qgroup_swapped_blocks *blocks = &subvol_root->swapped_blocks;
 	struct btrfs_qgroup_swapped_block *block;
-	struct rb_node **cur;
-	struct rb_node *parent = NULL;
+	struct rb_node *node;
 	int level = btrfs_header_level(subvol_parent) - 1;
 	int ret = 0;
 
@@ -4754,40 +4761,32 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 
 	/* Insert @block into @blocks */
 	spin_lock(&blocks->lock);
-	cur = &blocks->blocks[level].rb_node;
-	while (*cur) {
+	node = rb_find_add(&block->node, &blocks->blocks[level],
+				qgroup_swapped_block_bytenr_cmp);
+	if (node) {
 		struct btrfs_qgroup_swapped_block *entry;
 
-		parent = *cur;
-		entry = rb_entry(parent, struct btrfs_qgroup_swapped_block,
+		entry = rb_entry(node, struct btrfs_qgroup_swapped_block,
 				 node);
 
-		if (entry->subvol_bytenr < block->subvol_bytenr) {
-			cur = &(*cur)->rb_left;
-		} else if (entry->subvol_bytenr > block->subvol_bytenr) {
-			cur = &(*cur)->rb_right;
-		} else {
-			if (entry->subvol_generation !=
-					block->subvol_generation ||
-			    entry->reloc_bytenr != block->reloc_bytenr ||
-			    entry->reloc_generation !=
-					block->reloc_generation) {
-				/*
-				 * Duplicated but mismatch entry found.
-				 * Shouldn't happen.
-				 *
-				 * Marking qgroup inconsistent should be enough
-				 * for end users.
-				 */
-				DEBUG_WARN("duplicated but mismatched entry found");
-				ret = -EEXIST;
-			}
-			kfree(block);
-			goto out_unlock;
+		if (entry->subvol_generation !=
+				block->subvol_generation ||
+		    entry->reloc_bytenr != block->reloc_bytenr ||
+		    entry->reloc_generation !=
+				block->reloc_generation) {
+			/*
+			 * Duplicated but mismatch entry found.
+			 * Shouldn't happen.
+			 *
+			 * Marking qgroup inconsistent should be enough for end
+			 * users.
+			 */
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			ret = -EEXIST;
 		}
+		kfree(block);
+		goto out_unlock;
 	}
-	rb_link_node(&block->node, parent, cur);
-	rb_insert_color(&block->node, &blocks->blocks[level]);
 	blocks->swapped = true;
 out_unlock:
 	spin_unlock(&blocks->lock);
-- 
2.39.0


