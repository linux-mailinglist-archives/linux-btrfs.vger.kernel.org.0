Return-Path: <linux-btrfs+bounces-14062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984AAB9442
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DF91BA3CEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA48253B5A;
	Fri, 16 May 2025 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y5xehcm6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012054.outbound.protection.outlook.com [40.107.75.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCA2356C7;
	Fri, 16 May 2025 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364646; cv=fail; b=e1YgbPUndgYdIPKOJ0vPQzCLjTvWQk8qr5Y41X7HfBJKQK1AwOMJPJJl7sWtJOyRq8MRijyzT96elB+Ga2gzZ0QuAdKozWjPy9Z3LymrPVboPBWyRFA3IHHvvNSEqYclczZmyPlvtJEmUT23Yk+RO02nHV48+9jr+e7xm16Lbwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364646; c=relaxed/simple;
	bh=8Ov6sgGyhtM+lC9FPsbB3l+0dKWBZsLDaBY5k8id8yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaKRpmNZOvJnreCxEooHWdo6z9CwBvzRtD+k3+R0RgbeXJ58QC3limfD02S6rkVo6EDQS0AhqqcLzZ0M9AQO/pBOhtgN124j5zIZitGa05M1L/Pw1Yxs8reGtVWuktMUCi/Le4vg+jhxQJ+/m+bYP9ORw8uBTZ0rFGgV5vrlwdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y5xehcm6; arc=fail smtp.client-ip=40.107.75.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0ihtrC3dVcXjEBSeHU5qjbsX9NGVTzyfdv9DF7AhvNrRMxwkBeDKaW/IlaiLF2SqDDUTBT+D/zQMDWRlmRFaXRh2xArkqSGuBAB2SNVfPyix1hjw6gIaCjTPC7JLFZZll4mt3sjJC1eU8VRRU95Fkb1cgXyBwFADOGJyuTZBVLQ4zj0CTBYbjTEWDZaRtjp0OsPqx9WllZrw74axgq7E8JSPFeDl67YrB9CyLC9s7YesJZfFDFx2tQKZ8UjWu4MeXVM3CuhSnQn8pThSP61Pwp+QpMVUMlvpkZIEyZL8EqlGZ1cmSlStmoQYreFjpN68XDLW7u4QLZsoLjhg5GrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUedylmjIvL4jTgkVz8ym1zL9IdhzLKRMjPv1H3/eCU=;
 b=ZnlJsEZhidQqAaX0bpWCFlmTvaWe5etFg4Tqkez2CYC4Do25O4Ea+ClTEJQnaA4obNv7Yxw268GkP7gWDxcXfHkJ5d7IhsVl94tpwLRV3KNWjW+xcGetuXYx00guigSBLOQSuWibIf519EM/LUXLy65O70eeZaDGy4+Ah4Z5QuiA+YJN23h4zcCus1c0jbRzaSKwL8ck3lFQBoXQgX/dFekdL3+DS+FTMDRJKFyahMdSUOAZGh3VkBu6Tn7wAY1edzDFSvJI+0qakdVNwhimVyzdmjEN1LZxryaeX5LGfiKJI9moj2d0qVwYz4/FPNxlyZ+eyYlT6DVf06aYTO2fNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUedylmjIvL4jTgkVz8ym1zL9IdhzLKRMjPv1H3/eCU=;
 b=Y5xehcm6Fe4VVYylWuUvajEE+kkub2cTH7qTtYagNeJgX1DGhIDbt9vN75drq99VDu8Tz0xrzsODveTx3NSR3U6kh4SiIWX+1Oqw9JwdMXl33zV8OZ4U9G9YSTqUcIH5g230WJznbAz0vxOY3+/aFCPAoDFhWoD9RlFrdo39Tl0MDXmrOWoLTyMxnIcVwFDfotgu3rZZ8KHHdhs5DtNP52idTWd1usFJqrkPr1fGMJcXoOyGF55YJxjdqUF2ihxHFE79HdGOw75RndCmwDFAQKOC1kpPqt4WaUbMourtT5u+6tGF27X36Q/UYg8l/A5kBRWjpdkWyBag4OL5NTjfdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:01 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:01 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 04/15] btrfs: use rb_find_add() in ulist_rbtree_insert()
Date: Fri, 16 May 2025 11:03:22 +0800
Message-Id: <20250516030333.3758-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 683dbe8c-e7dd-4326-79d0-08dd94264ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCWSmySkzwYCiKQbDuR4QcNlwpHlIS8wZyh+SF7vpXYGgjApspczPldLlbsI?=
 =?us-ascii?Q?oWe3xA9GDTRqtsunwSFZrvanXFkPBQyVsnJ/yAyYp8MYq+mvKdJ0BAB6k/Bs?=
 =?us-ascii?Q?NN3VBzfhe5ttawcWy74ytW+fMrzvg+M5a8stsgLRXpzze7UyTa2+a2BAJiPY?=
 =?us-ascii?Q?nhtQljaqAP6PF0v9EPps/NE0F973INlEH9HnkMTzjkPD4UUK9RoaDDGDwLQl?=
 =?us-ascii?Q?gud+wMlYn3UYGwaiPUiDwS17LHigdEMRs1OTFIgi1Dy3BRZ8/XbNOS4SQBXl?=
 =?us-ascii?Q?YIPp6SC1QL//KFrl/aW3BpelLPMcJeqTlV8Jf0UKxgJw8+mjLeKCH0sHxzHD?=
 =?us-ascii?Q?KW4AU9DKwvckMC9Aq6/2oKRGWv1o18CadmoJRxYrk1d8eMcKR3lpgCYJi/uK?=
 =?us-ascii?Q?tryZI2VChRymDe6y/fG613f3twgvVY/+mo5VRIelpqdt0lRzZJV5bdAMI+1S?=
 =?us-ascii?Q?7SVj3nxtKUM+1JnGVm4eJjLcUhhsl62vXHH8JBGXj/kBC12ej18Sl5sRhCPh?=
 =?us-ascii?Q?IJTnTN/9dCOGVlmkirKLBA2qCFfULPpC1v+ScElTqYYOVAwU17HxXorVTqQ1?=
 =?us-ascii?Q?RpVpJ8sCviCFGq5YK9p6g0OZSTi0jHTICfguRxf+AG4g7P+OFQZu51lKB6lN?=
 =?us-ascii?Q?OXezPOaiUiv4AExLXmpFfBbf8zgF/MPjqZrOYntEa8rgIHSeYFPrRuwrOmDh?=
 =?us-ascii?Q?Ufpt4Rx0cI/W8O0oXn2jrO47kTZfnCLfLixxyF3mA/6mY7k/vKAuA7FcD6XO?=
 =?us-ascii?Q?jClHpcA4Ofm4X77XE16R5Hd6hHTqo47o4VpnOMxWh9y+QPb+3W2y7NUD+x+X?=
 =?us-ascii?Q?y1wgqg3qAHbI4dbZzGHQ1GJndq0MhsoJx60iitmHVs3rrs/sXpAOAq97idsl?=
 =?us-ascii?Q?xsd1NznuYXZ39EaF/MRmJdhRUCY/XAJObpac47Hs6zGn+VmVGtCJb0W7G23n?=
 =?us-ascii?Q?D7eFkholsTEAqI5B/me1I72Kv7nNrcbbPsuKUw6Ti38QkUswiIICN9pu8H7g?=
 =?us-ascii?Q?FF2Giy9X4rDfZ5gar69RVZNY/QmJjxOLSfDnrOXTw+N7sg7m10UvrqWAwAb9?=
 =?us-ascii?Q?7iVKF29y0C3WFac6Rmt5mInH9fXuPGpMfw5V5r//FKPDUrlG4N32itvY8bPy?=
 =?us-ascii?Q?SzimevWF3u4mOlkqxKD4PYYjYftw0fdYKfQRAIxkWTKrxSkVUhavw5hJzj1y?=
 =?us-ascii?Q?0QJfYG/c/557PHT+jRYYiHbNQ7cPRMY8LLRmt375UQKhvb9hDpUQRpNES/Nu?=
 =?us-ascii?Q?VgGo9ziyC0jc65jb4epsPxAAzdTXEuHnI5y4CgZeTyS1D9r/A2tVB5ZqEXCi?=
 =?us-ascii?Q?/+mLU5Fg7NDiA6lnAcsnrCSpNU9k/hIkNmcekPzM4kvD3vLz1Zm63w3q2V8F?=
 =?us-ascii?Q?oG7CEmMbE+/inYWBo4fmPhc7ECch3EwC8GCE3mAXobEHXBu6YSebDDjcfB9C?=
 =?us-ascii?Q?sJJ+cJk2uIQVSfavWlUPV+5E8hq/27FXi4jLJdVCsOMi0Lr9wnzQog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5Q5T95M4Y1guGbAoY45KqMob1qZQPY6EvuqJXcdgpbfaRF3Nvf/BhGiSYTe?=
 =?us-ascii?Q?LqSJ3UIy5EoEyDgRMpJ/VZCuC4KoI8IXc2PO/B0gWys3q1zI/tm079Mrhme9?=
 =?us-ascii?Q?slHfgOYPXA/bY9qum5hZ40Xx0xWSCGJgaDWt70sDHGEM0k5ml5w1qXQhYskq?=
 =?us-ascii?Q?4zs4kqjE2RZGh17FFziGUKmfBbkueTgVcwMS2fFk/jVl1Rk6/EeO+QjcXktD?=
 =?us-ascii?Q?Rxyco7ZU79OFA/jiN7iObVs2hKUQLeKHpQ/TB7yL1mkQVZU+HW8+vGG4Iz37?=
 =?us-ascii?Q?KU15Wst/uXh3pbZg3KvBr6jOn7qSpNGq3IbvqTVIRz3w0XzD/czYHjax/S4a?=
 =?us-ascii?Q?KVtyFnGZDdOqVZqJzH0GiaKR05HPHCwRdST2peKq09ZiN7KYqTauETW5h4xO?=
 =?us-ascii?Q?X7oSfxxir6Xxt1jHC5ZHZyydbJCmQHIE7akzDWX1ZjFEF42zNHaSuhDEVdUF?=
 =?us-ascii?Q?jP4qSPHUnnA4epWThySQbPur4NH5XA4mTc+Jj/eyVBnkOSs9m5ArKBZGC8CI?=
 =?us-ascii?Q?P+g/y7K15SudxAWqNpp+Rspne8p24xrmPfXoKuqUNaYo+AUJAV8lh0BOWKfh?=
 =?us-ascii?Q?X2zZAYZ/cWOLdHUMkBJbo1iIYEJImAKbu0kgFywL++Ae19XZytUMrvamFmXw?=
 =?us-ascii?Q?c75WVk2zVEBF51eIS1kpxcsYcGs+exv2/x0O3M48Lz/gw2ZdWo9lUqD1eurZ?=
 =?us-ascii?Q?hhhTViHQHJz2A7B0dzIpUobDISE4Y+FSfmP7p+uip4tdTb3uPe4bTgDeGUr6?=
 =?us-ascii?Q?jm83gZ7KsK8yJsDzUwxYcvGFibOBG8XYeFn/+HkBB+Ehu5qTHBHs75CporoJ?=
 =?us-ascii?Q?vzOpjGv6JmhqfeOwnkjJ/kNTSQnKiP61hg+5U2wPfL98+4S3mFgMZSgqL6O9?=
 =?us-ascii?Q?yUqb7Pdzlmf5tSdDyxP5sCVwGSuFPvOa3vbseXmiGEQRHpsIMiUpuY7L5e0S?=
 =?us-ascii?Q?ZrwIrj9osXmAGt6o9BZ3qoeVH81ux6wxYkmsgV2R17gJnQIQkAN6H6+Thggm?=
 =?us-ascii?Q?rIeGg/vMWyH9FKkhT45wQ48rR6ZNl/kSTff1AWIIghjp2JPZlLaNSGeZ7jGQ?=
 =?us-ascii?Q?xabe0FzNXiwsiV0budo+FG838r0wt5gVoxU8UoQxE8NntT0licntvhzc9asg?=
 =?us-ascii?Q?pJbyf1Sdb4K+JL54kIRw8Siw9seZ+9YD/sd7uYiUlo4TQA/YSfobWI61KWpK?=
 =?us-ascii?Q?ymClwhNeWgCdY4vjsYXpn6QBbNsJWLf2yelZTX6CTvPckVTQVT9nOx1bXg8S?=
 =?us-ascii?Q?yUR9Y1cafX7qO2YOyOf78SJ82mcohi2QurfPeYwj9ydJveWeTOXHM19Nwcx4?=
 =?us-ascii?Q?x+kPXIukhk9CrD3C3s+Jl8UwaCd8OX1Any6+Y/mxauAUEoEUFEkW59uoTU3/?=
 =?us-ascii?Q?IfGv7MzPTNC2Szc34FujC0Xx/iyILglcl793++HuF8/lpkL3NMI5ghs8HSna?=
 =?us-ascii?Q?/wYfWkBP5x/iwYLsKHjTIw3SFttXbaDSr27F/24x3EgBZGill4dDQfu4OEnP?=
 =?us-ascii?Q?MCIDHS9+eOkTGfLy8pXkmzciOPvNwaL7w0RuyJh3VkYVJLcMM0l4tHax0wvd?=
 =?us-ascii?Q?QdEDiIT9QG7+LlaewQvNHJrqH1gIa7RMSldvXd9f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683dbe8c-e7dd-4326-79d0-08dd94264ed6
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:01.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Yt8MuRbokk+06zxP9ohNlHg8mCT/fB/VNJY399Z74zlkZusUnu0+VrK/2kLNzA4NY1ELsPUW4XmxHL/QqSDng==
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
 fs/btrfs/ulist.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index e1a4e8643685..f5b156d89189 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -159,25 +159,21 @@ static void ulist_rbtree_erase(struct ulist *ulist, struct ulist_node *node)
 	ulist->nnodes--;
 }
 
+static int ulist_node_val_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct ulist_node *u = rb_entry(new, struct ulist_node, rb_node);
+
+	return ulist_node_val_key_cmp(&u->val, exist);
+}
+
+
 static int ulist_rbtree_insert(struct ulist *ulist, struct ulist_node *ins)
 {
-	struct rb_node **p = &ulist->root.rb_node;
-	struct rb_node *parent = NULL;
-	struct ulist_node *cur = NULL;
-
-	while (*p) {
-		parent = *p;
-		cur = rb_entry(parent, struct ulist_node, rb_node);
-
-		if (cur->val < ins->val)
-			p = &(*p)->rb_right;
-		else if (cur->val > ins->val)
-			p = &(*p)->rb_left;
-		else
-			return -EEXIST;
-	}
-	rb_link_node(&ins->rb_node, parent, p);
-	rb_insert_color(&ins->rb_node, &ulist->root);
+	struct rb_node *node;
+
+	node = rb_find_add(&ins->rb_node, &ulist->root, ulist_node_val_cmp);
+	if (node)
+		return -EEXIST;
 	return 0;
 }
 
-- 
2.39.0


