Return-Path: <linux-btrfs+bounces-14072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A01AB9455
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683B37B8979
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E269288CA1;
	Fri, 16 May 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IRTYhyLC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB9288C04;
	Fri, 16 May 2025 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364664; cv=fail; b=C779rrV0142IIY26n2XbxXNLyBnihg/86jIBzImgealrkFA2h9jBYsEB0A7JCCWxnadz6AedOfH7FIngYUBsu7wky5TW/rW/tfOtCbx0NMxR7ZpITfY+zw8NJLjZpSQQql5tcpByPVKhxhwjgOYOm60eNgyl4IA2GyOaVDqPOek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364664; c=relaxed/simple;
	bh=MV9uQs3am4/pOZ/iqnO7IbzA7Ox5tVqHC6ywSEvy7Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dh/vnqE/ttTdI04RRI61lqN0vzl6REsIyLBsoSoDn51I5hRSc5GLe/0ZBgzc3QPh2vruEspKQTEoEKMFnebYGK7m/VaN7Q1Bv7Kbv+kW26ZkZyKMKIFX6zNyvQIS8qO7/sjFU693W/zM67mf25BA1DJGWV1N4+LaT7b+7doVnzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IRTYhyLC; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgNrmv/sDgJRGHBk15fToh6tf7uPAOSm/9U8zXB/U6p6zAod9pMIjZy6A6R2ZpWvWqtsKCQNZ8idgIGLVE0yDEfw/zVCiEM5e6y917wxaCpxROo53quDzRQbn4uORxyUInK1Y/+tbk9HjedUGu61JndZtvqmhY1/VYLiDNXUAPcxarfBJiYCXKNiVEiNmB3rIBXBzQBmFx8JrVWItuHIoAXm01Ig/lZO1DDU4C+jIefvQcnQ3joA+rJhchsgYm5Rs7GbTHyNdKLvKv72Bv1w9SG2CUlwClFCFZqnMy1lggtDP/AJcyFmyBSZDut831tpcEtXIJQbJw+WTbSltcUGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8me0HjxqGxLwkFj9kETaAS13Wr8n5xxlU9KpKa5ADI=;
 b=zThPTjlvBip4i1sNzAhKRB4cqbg5Sk79t4OVAYGoX5lKVRvGmOjL631uI8/v4pBq9aSNapK6k8Ii75R7AIu7Wh8U/67rk6Xwd1yCbW3UElhhWLpzUrSs8GwL7ZIyE6ddVp1EeNdOap2bSNYDlLdnNh7rBM4O/rnqAj6r+SG5ROXA2NUI0ejXgMgdkGKzFv9MsQ0d0WD0WxZ8sI+xsrHCGYOMpGq9b9F9tj0vqiUMZGudf74IEa7bjxyaViUMfauorhK7tIE4B1vOhhQNCheDsltmdAKRyhG9eZe5L2UNp+2zx9B6UEuAFoPvCxap+ZixCmCrFL70Umy/ifS5bt0iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8me0HjxqGxLwkFj9kETaAS13Wr8n5xxlU9KpKa5ADI=;
 b=IRTYhyLCBv4yh3mU1/lqZoiI4aUtA9z/FhC7TPuMlZO19PfshQc2IxpE+MDgyYnFzlKYdTjDJ4rrNtzOFkjjROj+dl3yKapu9Fd2NJsWrDhVxEpYBK2aNi3SqX+Y5xwdG/LZ49vOqGai/LUrl0hGC1G9R3014h6UhfY66JjNA9YoDAil/OKiblldtYjBtghFMcrTiKcRQQslSZrx8Q5CkHoYS9tYeKrlyFAlK6vCpnlgC+qcQFYIuTHLu3/muYHmaK0f6Ehe6VLdeMCKjB00pD2ugiYkrDYxaLoM04qKyfAobnlTdNr5BuJswEns5CXDxPIW/1AdwP2uEkKW+oF5YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:19 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:18 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 14/15] btrfs: pass struct rb_simple_node pointer directly in rb_simple_insert()
Date: Fri, 16 May 2025 11:03:32 +0800
Message-Id: <20250516030333.3758-15-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8fe1f08e-c9a0-4e3f-38da-08dd9426596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mLLM2bMXjbmBRFBf2t1wkn05p4VrBTn1gYMcTUcgMDLtQc2Es+u+5WuKkFRQ?=
 =?us-ascii?Q?N3i9kT6EkzJgtbAzP+CF0NJbn9gUU6Lmp8xHnmPxXujcR/yUoqqG/zy+Ak5S?=
 =?us-ascii?Q?k27qfF41tUYtUm34UmpUnnX/YBfoAlVAkwH80MyAb3b+Vxo8IGbPqwGB+QGH?=
 =?us-ascii?Q?vWrCDbWVe8f8EMtoBsx7Wt0RbV8OXKrYsjy9MBsWKvfuBqRn02cBNoaa2Btx?=
 =?us-ascii?Q?3JgDkDHwJs4CPc8BDmWAXUm1G1XULf8VOieQapqCqANhUwPAXVoioh3ZoGmr?=
 =?us-ascii?Q?h0/OXEZs431pD4GIRcdmLvkYWZ8hovOxijmj9qGsgwHbdJLVnNlFYG9lM7q4?=
 =?us-ascii?Q?23ooWeoP6lAVxa4dm3UiZ4Jw4FTLX2P8TqxFArI+aPRRtZpRYga2Qs6n7fbP?=
 =?us-ascii?Q?Q/DOJE2rxwRAJj1qKcbzYjcTSD9mEpLnvOW01XegeTLNQYGubr0aJQUYiI9l?=
 =?us-ascii?Q?oKJ8COMssYKd/kBJctjab2T6dGCRAQN/3X2ZIzCm7Emk8i2EvvgbEvwcvpsV?=
 =?us-ascii?Q?b/EdfjaZLm0nST7tl+2LmwGlh4o4AkUzfzTQgVFbPAbIq51yvdstbxBvmo8u?=
 =?us-ascii?Q?f2g8LsFsBmMjbix/JLjxZj+eENYtQ4f3iKtqCiGhjiuxhrhggtSLGxpeeimp?=
 =?us-ascii?Q?Pew2VsaaJdUIAwJtv3mZiABmoEPn135PL1x+IgVGGM8GBnsD03rseWazNW8n?=
 =?us-ascii?Q?xplMDJQpjZMOfLbVeQgn0HCn2weQ/CyVhExkvXA4gi0mMustiAIGbD1HhncV?=
 =?us-ascii?Q?42J4VKDGt/7MoZ8zuIDzHm+UOvROOLcOw06th8gVfoPeLklsa99IOospiTcy?=
 =?us-ascii?Q?Pc3+QTA+uEUhMxzUiP0cI9WOd6lo/Ppi462eutpAldxtuvFOjPlVrB3XLEls?=
 =?us-ascii?Q?x61/TAujuTSoioxAfy4gxXssDoKX2+13d64fI05+p5LZ08uWhDhu5RK1RQK5?=
 =?us-ascii?Q?RmEIzZwKd8lC2Coy+3SbEnfi41jBu5tgywvt2FcB9AClWyoMHanT8s+qrrlf?=
 =?us-ascii?Q?meEl5RPM8WBwXZwiH/L0DHil4OyQs33JKxBQp7s3w1+EFMbyIKVg4dId/6y3?=
 =?us-ascii?Q?cAlPnqzXMq9eu6aaUwh9o8wtFambDPDyPAfCHd8DSawMEGCAGjy5PIhaWc6J?=
 =?us-ascii?Q?JBPvDNkNWk2eYpNnS9g7c3WbmDteiwLaZr1Am5PAMcW2ZqOol3JPRfGLVdhF?=
 =?us-ascii?Q?lfXg4qZBBkAmnOI+MP6azcBWu5/0hy0AaszdjkJ5N2IHr2kno2BhudkRr8mx?=
 =?us-ascii?Q?nwo2PtZjGBVdQLDw8an6OXpFmbaJq0oSpucgeABvgekFLTKExcRxDTq8u8As?=
 =?us-ascii?Q?JuYRALs/FzBdjAnCZEs6ghm1l6xCf4PQo2TPcT6TBC4S7FAn2w5UGkKsICHL?=
 =?us-ascii?Q?Hg/leoJwVrOpdSNgglkJPrIb3XQpQE2ztJ/eVp+X3ovyz63RtbEXg5VZLX75?=
 =?us-ascii?Q?Y/eLYWRzKW435aSjFVqvhD4zYd1fOL/FE2qCP2tivVl/+olQ7Iu9sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+/o1oavCZavByWSYiENJUtMCZm7JZq+bdsiKanW9uZQmT2XT8U6Pi3Iz/hP?=
 =?us-ascii?Q?dRmbjq749of9JQdx/IupBNvMT+HUtOPuYOByuIhKIEg99JS7WkqnTmhrKYCS?=
 =?us-ascii?Q?YacmlLhaS7lthgk1cqzu5ZYRB24/+eqrwhutlDK3OIJefjGwTHqDX6QYOvK2?=
 =?us-ascii?Q?S+TSeD7TKmt6UM77ydlrKc5aTq1HLg/xQZ/nXun2kwQqpTJPjNAbgfgWyuVI?=
 =?us-ascii?Q?RdOfyuumaKGarEbBy7y2nW+J0gGEBAMhzs/FDds0lvx6UYolrluOPexVBRS9?=
 =?us-ascii?Q?9t7UNqbGtBA9XFn8I9tasMlr/tdgP1Ow7Hg9+yEVAgwegR6H5o/IekjSgWPs?=
 =?us-ascii?Q?b2INjIYKvAZYjpf5vELBQAAoScQN0j9QF0NyloLRiMPpcHrcMQQcp85EW4ss?=
 =?us-ascii?Q?dJ+hm0StbjaPlNTOYg6B2tCkaeLBt0Hc+zy40SggX+6dNGffI4k1AdfKG5mh?=
 =?us-ascii?Q?yRlPCcdQEZv4r10MUz0sFcwAWcuw4OxDGmUtJVELceRGOEBLcqIl4DKZqHoG?=
 =?us-ascii?Q?9PnwTbyiZ7JeUoOqbtVKXbCF2kdzJKTY45e3IQ3unaLEoxmQldY5sjHgysci?=
 =?us-ascii?Q?nd7zovhGrQzQ9knloe2qbxr/Vk39/W8UdOWkULNH7ECiJfawdCpBmyEXOwkp?=
 =?us-ascii?Q?YO90ms+vdbzohBAKZAImLvXDPOafclmAdBG4gqSH1g7PFf0+79LPyqELxbNa?=
 =?us-ascii?Q?C+p8jdT4cY0zZQQeuHLVfufyHjb3gU6G/7V/HPYChiCphW8fJ3JudKoN6EVw?=
 =?us-ascii?Q?TmAG3JZxrbpiMz11Dmegj3EkXqfnVrn8bdiuTN6loMk6ir5jsW1z6BPR2QQo?=
 =?us-ascii?Q?34I/6t8IJlzVizm7td8z28zd0i6VvamieWp9sLG3pDItQNJETI2Ckfz+mFZI?=
 =?us-ascii?Q?z5mdwxTHvFuExnbO+VY5D3JcvauTs/ICx7FewKin7VanjcqbH/frPq1mKZNR?=
 =?us-ascii?Q?U55XqcBCZzCczsTV07T7EzhQKuug+VJgNdGi0mrk9e09AadULXpAtWR3wO61?=
 =?us-ascii?Q?25Z7DWg+M34G06r8GiUDRFILoSOeaRW4aFyiHwMNlRwgV7wiUxwEccCwDpS5?=
 =?us-ascii?Q?9a8qJxTZ5TayTV+I52ZXb8tL8vZeFO8+uuTaFY2vqmIGmLlJivd2he84/6KK?=
 =?us-ascii?Q?1m4ZwXMx4VGfOqjAKet4k300vnxbW5tjgZdZ3yGHoh3uNs2/2JJQKKgPG3/u?=
 =?us-ascii?Q?zr1u+y1vXIilZl5EKFKmTF1D6ZxwU2Y2ezYU2pAuV6QPa529fsH3cMkNTzmP?=
 =?us-ascii?Q?WdFUfh3cm6Oe51+GuGwLafnDTJgfa/CE0/6i0dOgJ8ibhmp8+jSSZu4+zvta?=
 =?us-ascii?Q?x6Qhvp0u/e9hzf6cSgqJb02hch8gobC0B8NAch15GHB9sRmhnOWL2WWrJyg2?=
 =?us-ascii?Q?1AEcfHNYlZOt04L7Mayj/rtl//oG0bB3aOpLPFZkMdArsb2tx3Cm5o8O93Uk?=
 =?us-ascii?Q?9SxDHLRHv6eW+sL9DVOmelUW6WUn2KraE23eed/moZh0+UNlnTPp2n3TVLSU?=
 =?us-ascii?Q?8Qe2ljJ2MM053i8vRttr9InG7UleRlaFJazbRUDScQkatX926NyUpzRj/D1C?=
 =?us-ascii?Q?RAuY33ETTKJEbYssOGSHTfcwI3XlaxM8qdqeKJfe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe1f08e-c9a0-4e3f-38da-08dd9426596d
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:18.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPkvuwH4WVx44YTHMljum6jsSt81CX77JpOlxI+08HPnUSmQxRpmzHcdsS2rS0VId4qQty9mt76t4xBXcggRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

1. Replace struct embedding with union to enable safe type conversion in
   btrfs_backref_node, tree_block and mapping_node.
2. Adjust function calls to use the new unified API, eliminating redundant
   parameters.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 fs/btrfs/backref.c    |  6 +++---
 fs/btrfs/backref.h    | 12 ++++++++----
 fs/btrfs/misc.h       | 12 ++++++------
 fs/btrfs/relocation.c | 30 +++++++++++++++++++-----------
 4 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ed497f5f8d1b..878baeb0660b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3570,7 +3570,7 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 
 	ASSERT(start->checked);
 
-	rb_node = rb_simple_insert(&cache->rb_root, start->bytenr, &start->rb_node);
+	rb_node = rb_simple_insert(&cache->rb_root, &start->simple_node);
 	if (rb_node)
 		btrfs_backref_panic(cache->fs_info, start->bytenr, -EEXIST);
 
@@ -3621,8 +3621,8 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 			return -EUCLEAN;
 		}
 
-		rb_node = rb_simple_insert(&cache->rb_root, upper->bytenr,
-					   &upper->rb_node);
+		rb_node = rb_simple_insert(&cache->rb_root,
+				&upper->simple_node);
 		if (unlikely(rb_node)) {
 			btrfs_backref_panic(cache->fs_info, upper->bytenr, -EEXIST);
 			return -EUCLEAN;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 953637115956..d59c51072fad 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -313,10 +313,14 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter);
  * Represent a tree block in the backref cache
  */
 struct btrfs_backref_node {
-	struct {
-		struct rb_node rb_node;
-		u64 bytenr;
-	}; /* Use rb_simple_node for search/insert */
+	union{
+		struct {
+			struct rb_node rb_node;
+			u64 bytenr;
+		}; /* Use rb_simple_node for search/insert */
+
+		struct rb_simple_node simple_node;
+	};
 
 	/*
 	 * This is a sanity check, whenever we COW a block we will update
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 0d599fd847c9..e28bca1b3de5 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -119,8 +119,8 @@ static inline struct rb_node *rb_simple_search_first(const struct rb_root *root,
 	return ret;
 }
 
-static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
-					       struct rb_node *node)
+static inline struct rb_node *rb_simple_insert(struct rb_root *root,
+					       struct rb_simple_node *simple_node)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -130,16 +130,16 @@ static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
 		parent = *p;
 		entry = rb_entry(parent, struct rb_simple_node, rb_node);
 
-		if (bytenr < entry->bytenr)
+		if (simple_node->bytenr < entry->bytenr)
 			p = &(*p)->rb_left;
-		else if (bytenr > entry->bytenr)
+		else if (simple_node->bytenr > entry->bytenr)
 			p = &(*p)->rb_right;
 		else
 			return parent;
 	}
 
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, root);
+	rb_link_node(&simple_node->rb_node, parent, p);
+	rb_insert_color(&simple_node->rb_node, root);
 	return NULL;
 }
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02086191630d..6323129510cd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -90,10 +90,14 @@
  * map address of tree root to tree
  */
 struct mapping_node {
-	struct {
-		struct rb_node rb_node;
-		u64 bytenr;
-	}; /* Use rb_simle_node for search/insert */
+	union{
+		struct {
+			struct rb_node rb_node;
+			u64 bytenr;
+		}; /* Use rb_simple_node for search/insert */
+
+		struct rb_simple_node simple_node;
+	};
 	void *data;
 };
 
@@ -106,10 +110,14 @@ struct mapping_tree {
  * present a tree block to process
  */
 struct tree_block {
-	struct {
-		struct rb_node rb_node;
-		u64 bytenr;
-	}; /* Use rb_simple_node for search/insert */
+	union{
+		struct {
+			struct rb_node rb_node;
+			u64 bytenr;
+		}; /* Use rb_simple_node for search/insert */
+
+		struct rb_simple_node simple_node;
+	};
 	u64 owner;
 	struct btrfs_key key;
 	u8 level;
@@ -481,7 +489,7 @@ static int __add_reloc_root(struct btrfs_root *root)
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	rb_node = rb_simple_insert(&rc->reloc_root_tree.rb_root,
-				   node->bytenr, &node->rb_node);
+				   &node->simple_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
 		btrfs_err(fs_info,
@@ -565,7 +573,7 @@ static int __update_reloc_root(struct btrfs_root *root)
 	spin_lock(&rc->reloc_root_tree.lock);
 	node->bytenr = root->node->start;
 	rb_node = rb_simple_insert(&rc->reloc_root_tree.rb_root,
-				   node->bytenr, &node->rb_node);
+				   &node->simple_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
 		btrfs_backref_panic(fs_info, node->bytenr, -EEXIST);
@@ -3155,7 +3163,7 @@ static int add_tree_block(struct reloc_control *rc,
 	block->key_ready = false;
 	block->owner = owner;
 
-	rb_node = rb_simple_insert(blocks, block->bytenr, &block->rb_node);
+	rb_node = rb_simple_insert(blocks, &block->simple_node);
 	if (rb_node)
 		btrfs_backref_panic(rc->extent_root->fs_info, block->bytenr,
 				    -EEXIST);
-- 
2.39.0


