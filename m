Return-Path: <linux-btrfs+bounces-13214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC3A96035
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F683A9CD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C042586F6;
	Tue, 22 Apr 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="b+hnzTV2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B7257425;
	Tue, 22 Apr 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308549; cv=fail; b=jhU65qOIwv4JZztgRJP97Tk6lT3Xfgf7q5vFrq52gUariLemocsbU1hMYcyDa3YoEK3xJpSsNxaPW0WpZwF/tfDTA+1yfcjY5uy1lbIrGQnhFWDwveTnTO3X2pAKglaw/G+ptNBnkm+FjAQIipXG4vnlBlOdUi2azGcd/9dkstI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308549; c=relaxed/simple;
	bh=o7vboDFDJpjO7TlP2Q/Bj3q6JbiBznb8rY3wQFoOB00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZirvzzzD6Ebahf78yP7N9tW6wtpFN5rNAjRKvAgzGY9ivGI5RN+C/AE6hK43vbD/ZX15QDXlQCcTgoXTbEJ7++F2DC35Ap7A3LHhgJ9qRitgBjf2zb0OBvA5bSD+XKqrEul6zUJ5c38FmfVWF/yvvjmi77/y4ukcjPLJrSmEgqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=b+hnzTV2; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEL42kmDaDmFWYwrQbn1Eb+yr8b+UfV3h8wKMCIxKxAljiwNJeE4WBQiINL0GcdZVuqqyIArJmLOvPioZzT5DEd3NHb5cGUPEH/58t8PrkTQUqDmjd07UO8h3R31x9RlvOqjaXcJY92HAhF09qsVkgdT7oBqRhMN5bMga3y5d5orPx0AH+9W1BqoHqaSmd40TwvuE+G6VCMl+RdVO211EgFi5MpClr+Hi7TmHC7H/e32UUMXM5D4vPZuO3m8rNxMK6W08d5zCw7UNQn811b01ACxSEj9k+FTkpz16Fj7T9oCBl5W3lbnTBP6HTrJMeADlwdK9IEas11VOzptP9C0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BW5tW75M5/eBDS7FWhM9K9sIaFf8TLe+Lo6Zpb4K1o=;
 b=kGNdAKMpdJunJrxlSXkVXqGr9gcb4gUKhbTuFG/FRjEnEpomUB3Y2nIZ4JlCdtLiTTGo/2fMPWKJVzXEVxpAw6MYpFWzaml3/JjrQD9p+Jq77cJkY9ExMkUEjsdeQB4rH84HnodEEvA6HqnQxRHkCbrgfN+9MyMI13kudT/+TCBaigNKIX3QPMu/3lzoTlOnN4VUh9bVOVT7RnVw46llvDSOHovxR69KgIlmn8BZ2ENi8MHpqaarsgOMwb4b3xxJ9Gsf2p5M+6YHqGIKGf6LU4/7+xkf6DQQRsHRf4KMbDjHn3VIHp32xyYPlpgdp4yfGyZpYNCWtdeXvRr3QIoxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BW5tW75M5/eBDS7FWhM9K9sIaFf8TLe+Lo6Zpb4K1o=;
 b=b+hnzTV2WaTLmn8ts6LPENxMQ9BishfNuG14oiAw6PVKnIXONlt4/Gm+l/O/cPJ7a/3NJaHCxgD+TtRMK1FV8CcjwBhlP7b1udPIvBX0l26lkpUOEmIW9EjaQuICsmmCSKkwzVJHTy0ZjpJ5QH7XlOYPalucdmHLk8SUcSDvdP/0kmXGgSwh0RMFbG2uiLlF/vJWPqDpy/FMUVrdnBGXieONwuoUG1VjBa6AInN+v7X1JSDfVYRPVZjgWoJCuDXIRd47kLxfFx8bZkuuuk+gWwK0ut0qLejNWSer+tL30f2Ca3mCSx0vnv+0VcK8tlRxyOtr0gTePYixJZgvhYjFWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:39 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 12/13] btrfs: update btrfs_qgroup_trace_subtree_after_cow to to use rb helper
Date: Tue, 22 Apr 2025 02:15:03 -0600
Message-Id: <20250422081504.1998809-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7680a83a-9ac4-4d48-cb97-08dd817312fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?voKWghaats7+sHw4R4xBsjK6glRhLV0nx0YmFHn9loiqjJBlQ4ZYrv/o4TkC?=
 =?us-ascii?Q?2hBjVWfPGSo3iheEEMKGfcE2m6Oz56sas5xImsvY6IXpiH09dW6pR++SL9Ux?=
 =?us-ascii?Q?MkS/mdiTTXQmhyc+UGRp/qryF0Kcd0lh5knfB4pAlF6sbVLI47yUiEdMilMr?=
 =?us-ascii?Q?Byp1Sa5t7UMMd5AN1lWIyx9JNvULnORk07baze3ej6LJ0OeiXwO3+fXMGqVK?=
 =?us-ascii?Q?SBJ6z6BXKbcKReMi4j2FjoujMzaDo3Wo8sHNHMSdj5NVEehHEj2fbS+ELAGH?=
 =?us-ascii?Q?xxvjCft1ZFRA/SAVod83piZDCjRgdNqdNnMFRXY18slj3i0u1pZopEn+u7wx?=
 =?us-ascii?Q?0qg3U/3CIDvZuBcMl95gIHn/T0eizHGp2xDrgkXegV7FhyzO5x1qc+dP+sr0?=
 =?us-ascii?Q?FsuaFbeF/R2/sT2DBFdzwebq5xk4aFsrVpLN4YLXA17wqWwy+yvIZAO+EZdh?=
 =?us-ascii?Q?M37ehir4a2MNOqk+v2dEjwwvjDQrYVlbhecQRMOapxL95c6K3eTVWE8b0gve?=
 =?us-ascii?Q?3hCcfB/DvpNxMW03HSvCY8NagrXW+exw+3cloJzoOBpgSogt7rG48wxdWGkA?=
 =?us-ascii?Q?NRTDxLEM0gXWpiOuvhly9Hr0uKR0n1X6PTqUSYNbuHN/PFIglZBbPLTWnKwv?=
 =?us-ascii?Q?CGuBzRF+Eo3loy2GA8VByC/QJ4VGtGFt8wLeNtgrIhNPjIsI0Vwq+acIH8bZ?=
 =?us-ascii?Q?sBZ+dYe8hr3rz6/HES2kPId8h1ubjVVSzeu8H/VFPNH2IufxJiz/Af9D4oxi?=
 =?us-ascii?Q?RWfRzi6Vv7xMEMQz71i5YZGzibTDixOsDyjbFUZyqeUOnP2NYAjr4l00vNRo?=
 =?us-ascii?Q?ylDUqQi+RF0whOu+E8qGagJQgBVPVJ13cLoII8XPMJYGBnC5uEsexWYMPtqS?=
 =?us-ascii?Q?VY/xl7/Ju6yf0MzfHENM/hDMkSpj8Td8DOdCLakXtpMZzFkgTHQxYiQavVLu?=
 =?us-ascii?Q?qVbqKSW4lUMAK2froKiLcezHJNmcJx+N/KGsT4D3ZXEC9xOlm82O09SGB/3H?=
 =?us-ascii?Q?AYtANeXGQSY4QSFKsX/w2uXHpoLxpQAeDJo18FNrI4/msoHdFTOP3FkYJgNd?=
 =?us-ascii?Q?ZmQIqUlWb3ywip6gJIaMlFx8TfisDnSnaiDeg2E5R7T27UHHegGDA8Zl73kc?=
 =?us-ascii?Q?p7OFVN58OILwQmdHWOiq80XePllxEjBqBon4FVlc8bxYvTq2LqFtAoJEIpoa?=
 =?us-ascii?Q?PHz57aBEXXZkC77awRZMIp2SbflVO10C+PuN6W30S//JcQnA8gOsPm+n7+Ur?=
 =?us-ascii?Q?BNqFwzbuy+gK6MGrMOeAQga1EBt/AJ/sL9Kn2epLq+Qg2QU66WGPewsiUYI7?=
 =?us-ascii?Q?FQsNVJit5eTuboqJ5TOb9blNmpx0MtbZld+W8u+brKzjNlDn8WAUNUve3JRf?=
 =?us-ascii?Q?Mns0QtBmKbImSFYYzFB+J+wfC4syuNqvke++nikMEzC3FTywDEu6hUbidhWW?=
 =?us-ascii?Q?JiJPzFDr9uZova+uiI+WluW8Ju0E9BFLmfqivXflSQCNyQ8CTqX16w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSt9OCK5NToi5tqf6t0IdWWgMkmVW2sGEJYfkK6ihkug1XRSwQasA9FQwHBB?=
 =?us-ascii?Q?Me6AkrLhB1dG/rWxOm5PLHm9VlmTdFhZvTf2wyPhKs5BMXQ/zBk/c7vqGQbq?=
 =?us-ascii?Q?Y31qZ2y2YQHNlcSzJBRgQhYRtkX19dX0Ek4fQqQOlrdr4Uo4MiH3U2KYzELD?=
 =?us-ascii?Q?jOIzsz6WJL7JGeLcEF56jQo4EhNVU5OgWONBFx7vDz8QZQ+cHAJ1LnSuThDl?=
 =?us-ascii?Q?U0VD7l0eB/oPHxlXWaZ/zwfdgazVECLBgyZbqHmYnen7w/E+DTcVdJYMLiyQ?=
 =?us-ascii?Q?x4UilRbQ70TuLhToN9qJGN2vFr2pNjErPtzys2aBvzCZwfe1b7quJ9EVgW4g?=
 =?us-ascii?Q?7yt/KxaUnvtER5UfnbUcRUPqX+1YQ59FreIZhK72OQD/sN/xvM6bTP3GBzkR?=
 =?us-ascii?Q?PPYEaBbJKDiYvjVwJvcb9flUAnz+pn0pnd9o7dD6BbjU5GNAf13UotzJjX3J?=
 =?us-ascii?Q?LNtbg12nbI6fVZNIvGAWALA3ANZ6ZLg+I/xJpxPflrE+NoATGKeWky20lMfA?=
 =?us-ascii?Q?VH1Oswd1+bopBHaRzUJ4EQHA5Z1a8gZIJTt/cgW8zaQb+Jg4vWBxU0oP185B?=
 =?us-ascii?Q?FDT7bUYqLoqnkODiW6R2kDHNawSIIVNLVbFOYhGreLwb+BVCnlaEq2cFLHeB?=
 =?us-ascii?Q?hn/jdmyCyjxb1Nd9O7SGGjw2PbsLFCEzyE/b62hkIrvhYB8J9qRvwqhpQrGB?=
 =?us-ascii?Q?+vTjgQ+3AFRycQKyIrpzNMiMr9rxG59u4ZaZeUb3UDb3BJj/gE+RY6VNVGGo?=
 =?us-ascii?Q?pDWmUWBScsO6ruoSwz4zf9gxUDEGYC4jmb6r1JB0PdW+Kcm5+cbg14jeksek?=
 =?us-ascii?Q?W7FmDxyUmQIzNeRM3+2v+YXg9Nhb8+eLqMlrodu05Ce7rDSFnS+Db76Xcfq4?=
 =?us-ascii?Q?YcfghnTEZd6VNcMsY7J0ZZclcqCRIcfJRbrETCcT45CRQ8ramkgyCIjxM46f?=
 =?us-ascii?Q?YmvQSnIWgbInriH0jHFO1QVOWDEz43RbujNcnvouEY3vU8i3CDMIof/Lg1Xx?=
 =?us-ascii?Q?5o4k9zKbil3vtLPP/jfTp8lnuPCGAXwzUjDTAxIfv2A58Fz63OWeVBTF+2ij?=
 =?us-ascii?Q?ZT+pWb0gtA9uVm/aO85L9nxPdq+tYsVlBoVemITEX34W4VP95ZOyrqPv2psJ?=
 =?us-ascii?Q?juhr6JhIqIUqW0uPfDTc0GaRw6jYz3W7FmL9/wYCsWFlrNWLK2W1QoMRXchu?=
 =?us-ascii?Q?lFuksP0M8t8FcRUf7lB2GLWnBwyYKlRuXwE9KWw/iE9uceLo5XQKOnT5FCxB?=
 =?us-ascii?Q?qgTRhg48ecCuCwzR64uObpE4/g+UAc5s43/QADU4RIav9VVA6Ooo+AsiAM3k?=
 =?us-ascii?Q?YRPbXI7l2LWyiTCKtFQ1cFAcKCpxv/OBPhhRjCRth8hsTUR847cwKVW9eJxq?=
 =?us-ascii?Q?gxlLs+MONFaMLAidsyr6dIzwxUxn3W1YhvNDuWD+Y3Rvd0J8Rb0Cq5+FAz34?=
 =?us-ascii?Q?J8KEq54iAtROOanvFA6Ps+qncUrsW/Nt3Z47PKGagJBdEu7ZhO6lzS7I6JSl?=
 =?us-ascii?Q?QfvWmwonidM3BqsrOOvaQB5nVByvGHjB4oeJUzrZ+VJrqoIjj541j726u6DB?=
 =?us-ascii?Q?yXp40qfXRrqDUXXCtWctEaOpyljeBOepUi1AAytZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7680a83a-9ac4-4d48-cb97-08dd817312fa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:39.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHqJlEUBOfRDkO7MyBei7QOWGsSBCvP9tY4y3VeWYtY//ED8N7QB42Y60XdKMcSBhis6SVIv5mErezg6OusHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update btrfs_qgroup_trace_subtree_after_cow() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/qgroup.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 989386311834..5b862470fd67 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4670,6 +4670,20 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root)
 	spin_unlock(&swapped_blocks->lock);
 }
 
+static int btrfs_qgroup_swapped_block_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *bytenr = k;
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
@@ -4798,7 +4812,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	struct btrfs_qgroup_swapped_block *block;
 	struct extent_buffer *reloc_eb = NULL;
 	struct rb_node *node;
-	bool found = false;
 	bool swapped = false;
 	int level = btrfs_header_level(subvol_eb);
 	int ret = 0;
@@ -4814,23 +4827,14 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
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
+			btrfs_qgroup_swapped_block_key_cmp);
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


