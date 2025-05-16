Return-Path: <linux-btrfs+bounces-14058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA6AB943A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7BEA0214B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F922DA06;
	Fri, 16 May 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QfUdRQCx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013046.outbound.protection.outlook.com [40.107.44.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0323CB;
	Fri, 16 May 2025 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364634; cv=fail; b=Hsy9QRiUz4yz9IWVhXjokpPZSc6HcVkXvx3zIx1+s7EgTQm330cGDyCqutuHhM+y3koybUHbZ1KYPTW1nUv8BrdVxTg+oQ6hO/pQGGgt0VaWpY3qL2KhhFH6RtVWXD9NNrdCMnUMrO0jOl3nRdyjNuMqSWNokffSYYjYFwUWDW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364634; c=relaxed/simple;
	bh=rjxeLi9VRUGBH1ZFHewgd+DrK2w4yrfM33BaGtn4dqc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DzUsec3IgZbxMsbCdWa5MABQfMq3a5tYA040Fus73ic6c7OLJl3BuM7tMSTerw4UmAoBRjQz77hvwoD1Y7KthFfai9cJqZy8jrig9Vd+yQEtVsA9WNmKADMLNicl1CZQrmKBkM33UY+gf7u7UWNQqsTCt+M/+UaoIWtx6dhNNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QfUdRQCx; arc=fail smtp.client-ip=40.107.44.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/ebjzqbHdyXUPvfx3la3UqkyxkdxPn3bh3bnQfvWpQgzupgOpkg5EY2+uXFdHbNt07SEdTEwCTU5+bnHhE8yrSvquMadhkMw7KZWA9R3LHQblae23r+difL8+YY15EFIMG/KspN0znyUXVvoCH3aFbWqtv8JwZgQHZC3R63GW1Jz7Z5EvBItTpqPcN+F92cgSjX0R5tdBUAJVdPlMxQXyFmstls7wEIkE0Vh30LMcq6jSf//TDvDfTacLfCvhXBgUNTVzHl+UCkrGdMXaUvliTNlH3klpHs9cfnIleW1MZ+XM9i1BbQuJK3IqNbC9W8vxnlvQCt9IIV1KZYNOQTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lXafQPGbPJ5YNlD1kyyyfyDZdflf1CdsN+8SGHnAUQ=;
 b=gYP88FmtalDh3KtlbdhWYdMRzPPWfU0mKLYDWoRgR7xSfz0RghnKNanKHDeDymkS5J+kPEtKoDTZkCZRggjRUrVHnibQUkWhfrR1KixTW0Ntlm/lqy6VwcwLY3WiipqdtfjrGJIhM0RucsdJVIw732luOYF8btUlz3To6UwlmBS8SDIMMMKOKx2Ymo5a3CUoxL/6Pc3ksMic5DFo7C2DBjvxvGdVpqmHLPkP9KQyus+jbzEBKT84hyoqWhID1pklYqo51P6d4wZlbgoB4D6S6MWzu/1439RF89936TNS3yLTyPlkWwoPbFycGc/bMV9xHmrEVB5MQ/TkYOdXmt7I9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lXafQPGbPJ5YNlD1kyyyfyDZdflf1CdsN+8SGHnAUQ=;
 b=QfUdRQCxaK+bBoi+T3P/ED/n7fxmNy/DkON9s32Gv5Ce59GMoq0LpBUGkr+2BYdkmzAhLi3kDYLkm6fkmCCG2gXsnfTAAX4vsfEA10A4lRK9kMcPmYROc8J+cClY6vJmmgcWmHtkuuY1RgnzbAHnQ9fu9vP9qXZiyuLYxPLVwyqVxlcAl+K+AhdBhgPETY/OR3D4u4iPHtzsSpGy8lRVie+tGFSKJ9oFLjpdbmKTi87W/g1ODfoaUbY1MpCro/yDWP6RIbe4VGmyr/LOzqGUCfdKrjvR8VGWOAKVvMeyvT0SFev2M4Fs0yW66DAdYPouVHf7Qx3fMZPk/4dt181+4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:03:46 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:03:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 00/15] btrfs: convert to use rb_find() and rb_find_add() helper
Date: Fri, 16 May 2025 11:03:18 +0800
Message-Id: <20250516030333.3758-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.39.0
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
X-MS-Office365-Filtering-Correlation-Id: 8ef678dc-c041-425a-c037-08dd942645bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43ttHOMtVDGe8QpRtPvdhA54BR0MvQax3CKw9HfVrONcA0SN7eQQlG5Xd+Zd?=
 =?us-ascii?Q?EYPzwTRe+UNn0sMHhbjhLS7yQnPsFmKgPplxxCAJlJSvXAfWCuA3mxH8DwIH?=
 =?us-ascii?Q?ZouSb+fec8cO8EGPRvugZazYdZyivCgEPaNdyW7gVgx0BkTEIv+fM/Y6AfYb?=
 =?us-ascii?Q?KwQL2X/deGtkF8fvzJPjv5+4o41SMIB4eKPF+w6a5SlAXJ+qmnCrTnXx4JEU?=
 =?us-ascii?Q?nZ0lE4J74XJCOzcGK2NmB4KGCqnHJjgMhE4S7yMmNrffGyaQfvViyR0BRQ25?=
 =?us-ascii?Q?b9E8kSjA5R6TTMZWAVHFe3YQ+kPl0swzUVoU1C6VvDuJ5AHifAgcgnYyz8qn?=
 =?us-ascii?Q?isv9J9nYf3ZVVzeybGsCOz3BQA4TQu9dQWBwhheozdiwWRQr3HqNN4bTB+6i?=
 =?us-ascii?Q?3bl44x0XXY+v4Q8ibgEqvIL2ywdoPrvLNcPNUXi+PDMN8obdq8Ab3Q7FiuAP?=
 =?us-ascii?Q?2CTo6NRblW7sbzZazPw0Hi9GcTL0r+Z/YGsHoHgAuhvqFSkSIh0uk1HeXE4z?=
 =?us-ascii?Q?idgkEk4fdhe+B8tLLJ4aDhJR0EaMPHKeQg0Sh2QqkP1z6HYuylXvvAq6x2i3?=
 =?us-ascii?Q?vlP7Eyy8Tic/q1tirb7VVLYp/R7wTyLUqjpTbhCNoW6RtuZ4RIMhM6foGOjg?=
 =?us-ascii?Q?OjhusaERfGHrbd3ZnOJILRzDNryF5OurKXineGe8vDc7estg4HccSL2lW7Ds?=
 =?us-ascii?Q?wERTe9tCxQl4quBwqcwzfQ5eNR/csVGOI3u2ODenQVu97atljs9hkFUK8vi+?=
 =?us-ascii?Q?srvrVnZ2KCz9rCcIGOwZ9GU5cAdQZizR7x4cHx6w17nypHjtFhF1KaVuExGb?=
 =?us-ascii?Q?bSOdA7tYHISlHqJxFrdpPt0arJ0+JaeOnopI5BpDY3sciIJIyKTzUZLbCj2/?=
 =?us-ascii?Q?DhfV2hq8FSp5XKYOpHt1T0Az9emRtbcdZxs2q45WwDUJDbEGRM1DYoPR4Loo?=
 =?us-ascii?Q?dvaKkyFUskR4WL/XZeZMe9WsnEGawEpJ3V8BNXxRUOEoBCiZAPYp1FxFD8g2?=
 =?us-ascii?Q?1WpBbFIqIsNxdlsPlpElIPj9Nq48HHkVXTohKZKF2jGrLzPSZfENauOm8uWi?=
 =?us-ascii?Q?hb6RmC0eu1B4WWzoGgGjQFE5VkZqVrr22s0eYAweNU2mzRb1BpLUEC7lYBhD?=
 =?us-ascii?Q?lcchtWqNtFV43L/WfZ7fjXzezA0ic2F95gV5QbSjJgGkFf7SuXp5Uhbh6FRx?=
 =?us-ascii?Q?skd2LtJMu2tX/+PUsDgQVvuoOLGb7QyCzQFEfP914Iu6mzVfGETT26R2dAjs?=
 =?us-ascii?Q?OWlPg5r0HvpMXPXse4H9UY9LWt8xLcEUa53oCq1BCtycgKd5jstO7VzxhfUI?=
 =?us-ascii?Q?/SCL2tXdgiwoCldkTCT7Vy0PlkuK8onhvZ63GwORJuJ+B80f1hEBhnliY4ep?=
 =?us-ascii?Q?bVqZBbCSQIVkD5AN9HKBY6aWfQzA7hizntTMZQMYt4zelywuOlBulnIv24S2?=
 =?us-ascii?Q?H+LM2YF+w2oba0J0xHRFErUPOBoygIOsrTsl+/bQvMcDKY/gpk4c2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N81YPdQv1IM9RX4h6Gw5N7ol89aJiti4hINu42WieOwabG1kOxezqLQ90kUW?=
 =?us-ascii?Q?ZWIS4RCz9HXvIjTR1GeJjwzF9q38CgP9SDUoA2xd/YMad6sGJTw3XSYuSBtO?=
 =?us-ascii?Q?6rw4YoGhlB98o7Hp5XqAOOOas5cU7ay21I0PIG+zCd/wGroJLf4LrVWFVK1p?=
 =?us-ascii?Q?u0Knq8GJyy/sliL1E7fpOvGxMrPWSlPUyK8smeLw3LEy1F68XNkbSB9PQBV5?=
 =?us-ascii?Q?beyC67B5Ay9KqK+b5LboYIOLH5/Of0pnzWkU1LQnJxzHXvRy63CXeTmvtZn3?=
 =?us-ascii?Q?fTcEWdiURYOY7KiGYI/JMriLnD0+XplN2yHKLzU7jDLCbnvq+xXHQNIlsHP6?=
 =?us-ascii?Q?4NG34ZU5w6WblA48A3rgXLnwfJvQolHh1Ku/21mx7bUUBmShm++23blJjU5T?=
 =?us-ascii?Q?unSbml25A+d6eL1DDziJRy3k188TF/VBWxUvlGkxiOEqPg/vHZzsLKIPeOsV?=
 =?us-ascii?Q?xNwRgXk1Th19/vs8pRCB6cncup8+YX6P5dbjTULx2yAEkphpD4/OuI/a/qkq?=
 =?us-ascii?Q?eCJwl6de8WaXDSuxRsuYth/H8GYFm+ijnQfhnQMtaa2Jqr+ImoFUT3hC6n1M?=
 =?us-ascii?Q?9/vj3LhcpcAmtoTqQ5DVbVCCLEM4H+FN+21Iq6bX+igkEDUtto0JDAThYMOr?=
 =?us-ascii?Q?3jjGUhMTjTfbNSNv/6Eg6W2iAok0AncyH7xeTju1olSn0zt9XgSGCYH28nt1?=
 =?us-ascii?Q?bBdw9Rja/Qc8PYUKvuy82XFxbGga8Xs8fGI+zbS3cTaY2SwdWOn0HkWPed+e?=
 =?us-ascii?Q?jV1NIPTPVLD/trv9xC8QrOyqqpxQUFoHRBV/jCP3Y5V7qY+/nkhmprt3Llp6?=
 =?us-ascii?Q?kNTqn/Osqwa1iAMOcd97YkYz2Vsk2tAk1n3hjV1/nuiYJYCjpggnLGsT+7+3?=
 =?us-ascii?Q?gBZ/o/xsa6/PQdqow5XBsXyBf7qaFJYXw6iqVjowaq15HIyla3NEdcs/I0gD?=
 =?us-ascii?Q?4N54Gg9X3gt5Gan1NmkwLl/gagK6YyHng3uGNGnQZwHIPtsq6VdyMXXEyNpk?=
 =?us-ascii?Q?DAmBs8Ssh942kgmXEqTQr9LX4Pzde9Nzu4sL6LuO/PG4x2+vbiJVbgAc3w9S?=
 =?us-ascii?Q?RSaagpCSMXMsS2loLQdTOKADqBOH5pIe+vG8CmSVrcV0Obj5PpNXupE1R4TE?=
 =?us-ascii?Q?2g3lstovw3iRxkBnYKv7rTeKIoSaHOLFvcVLkRQWaryGpqV/yDe6aBRns8cG?=
 =?us-ascii?Q?nMWsWyQtcNvOufyEmGZlMvODHaBFB+zRtLZJWOSJWKU43GZ9eULCRb+y6+Pf?=
 =?us-ascii?Q?foj4QuVp2f4vXzitbu8kpM8edp0FfyTRW99A98HWWNFrJLeie/fbKGmtRxPV?=
 =?us-ascii?Q?phZWRcSfFNV4ggf93zjuUvCHnKY9eV8F9cl3BeO3cVBowU1YzPzogI3cf3zr?=
 =?us-ascii?Q?tuQ8stM4QP4qzTnWINEAcICsPSTURtB+BVnLkIVlXs/jYqb3LyVme6Kxu5ym?=
 =?us-ascii?Q?ejgoJA2nPj+hw/1Ft4XRkE2rhaHLrbg6+Ngcw2REwe72OSCA90WARkbVEZM7?=
 =?us-ascii?Q?c0t3s29GGXuZghW05Ftcs7D+vu4Z56SXKeNFHQDWxAFcufBU1Qf0clhJtmpE?=
 =?us-ascii?Q?9mKnAX7gIko+1WNq2Hjg9Q7WUm3y8tW/zRDL8Uef?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef678dc-c041-425a-c037-08dd942645bd
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:03:45.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1/tuPnUSJMh4kFmEyAVPo9lW7yjvLk3uO0w1rkhA3AVzSHlI26tIB+NtLxb3IgD0WMKXgIjoi254rkCgcMvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

Based on patch v1, perform code style conversions such as function naming
and commit message adjustments without changing the logic. Additionally,
add patch 14 and patch 15.

Pan Chuang (2):
  btrfs: pass struct rb_simple_node pointer directly in
    rb_simple_insert()
  btrfs: use rb_find_add() in rb_simple_insert()

Yangtao Li (13):
  btrfs: use rb_find_add() in btrfs_insert_inode_defrag()
  btrfs: use rb_find() in __btrfs_lookup_delayed_item()
  btrfs: use rb_find() in ulist_rbtree_search()
  btrfs: use rb_find_add() in ulist_rbtree_insert()
  btrfs: use rb_find() in lookup_block_entry()
  btrfs: use rb_find_add() in insert_block_entry()
  btrfs: use rb_find() in lookup_root_entry()
  btrfs: use rb_find_add() in insert_root_entry()
  btrfs: use rb_find_add() in insert_ref_entry()
  btrfs: use rb_find() in find_qgroup_rb()
  btrfs: use rb_find_add() in add_qgroup_rb()
  btrfs: use rb_find() in btrfs_qgroup_trace_subtree_after_cow()
  btrfs: use rb_find_add() in btrfs_qgroup_add_swapped_blocks()

 fs/btrfs/backref.c       |   6 +-
 fs/btrfs/backref.h       |  12 ++-
 fs/btrfs/defrag.c        |  51 ++++++------
 fs/btrfs/delayed-inode.c |  39 +++++----
 fs/btrfs/misc.h          |  35 ++++----
 fs/btrfs/qgroup.c        | 167 ++++++++++++++++++++-------------------
 fs/btrfs/ref-verify.c    | 147 ++++++++++++++++------------------
 fs/btrfs/relocation.c    |  30 ++++---
 fs/btrfs/ulist.c         |  60 +++++++-------
 9 files changed, 269 insertions(+), 278 deletions(-)

-- 
2.39.0


