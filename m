Return-Path: <linux-btrfs+bounces-13206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614EA96021
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5768E3B9BE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BA24BBFD;
	Tue, 22 Apr 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GvXrPtfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD123C8A0;
	Tue, 22 Apr 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308533; cv=fail; b=ckTtXghn0+JnuZg70YueSRyrlMvLX/A9DTuWvxf23/A5zl3u9riZA4U1riwDFUS4LKF5t/nTj3T4QFX/fyagLZP4vyXwn/CUkM5/A7sVdvrQwSh2wk6wdMJH48hCvXr/+iqUBW1kGHgAIfY5owcAeM2EOOyM9EdswjAumt0ofGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308533; c=relaxed/simple;
	bh=0kwN/Vx6T9cC4G0t730sduXbZNuLftxjgHWXDxTBtkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U04gSudVXQHMf9pQM9BatFdUUzrzRr9vpDiXMdtEtyD7rNZEFIpHl4o9KBW4DW9RS//07hb0cDGh1wsxILpU+To+lVtWR7DCAd+n7fuEJDcg/4OWAUdCrnHYNHQ5I5rg+hmPTs2/6xmKvNAsavKubnU7rwmEuEsmxZlFyDgkSkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GvXrPtfV; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoUzOXt8r75CpoLd7nAiJ+8z9aTJxLpvRrA1J1ypl9sDI5Qi5j2KdvNM/u7mbHNmuz1wY53WbhBlGuork2S2lKrjmqpFqMpeYru5vC4jRQF1kqVGStJqAj689YPIqOnOvVzKEte5RBhN315f0BX+N/HeVfHJtVC9EqShGEaAqlCNgWL50Yr9xgCViIv5sgmrf+19o/sMYWLUbyRSI7K2EjqPglbsdehk7CnTfE3bDttiBaNYV3Xv+K0xZz7B/TVTzSKlh2EJTSm6vDePCB5yL44hScDHym971yAHko86xcanJT8X+FPZexue2bdwLihBIkC3TD5faGzefgZa2kDERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLMOG0J9T7q+dXZnF4W+qxf3tHGgZASr5SkWsskd06o=;
 b=paWYlnhviDCb5Pw4pGbSal2iJUQKd4WFZmRi87vUmjd4xMuXvbgXRE09+dWXQ0KQdKNu/BnlnNHk5WHeM5X/6wgrnbeR9/NzwyEzbmXWhSWaZMxt7kMADa3kvW+EHaEKbJCV7Esi3fhu26zNDRofoy10j9zR00ZRCrFaG9YsgiYqP1S2dNGTpGv4Uq1nmgeU4dXOFx+PfPzIO7uajtPs9QxoCqiDDIQVqtYPGD5YD/PRTeJnPYYuTF+WUCxmF1FjJpcwv99qhV9ZD9OWIyzzIf8YZr10Zso7iBnKtOnF3cU2oZmgy5GTEka9luLaCVQ/4hk/yTv02mCjQMSW5XylqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLMOG0J9T7q+dXZnF4W+qxf3tHGgZASr5SkWsskd06o=;
 b=GvXrPtfVtNvlZp3Ec7imlGHDvuwEynzqa9ynMkKhTIOh7R21S/GOTN8Ln8o6gTsaY0awGhxhuA7U/iAzLrxMn9oHmHnlhawkaV2POr0ezGqLcWjX+Azu7r0nTNlAl9forkXxDMqEaANCXTniDTT0fP7cSdBVOjwtAlxqd88xuOCJHE5wbaqZRmXpLIFA9kjp7voLsj+S55DTmLnxT4zh4MEF7TkgpWR6Cidc6V2btFoKH/NJrimJDQYjfwr6d3KndF6fNZ32Mr13WkxGMiwQF2jHX4MMqJq+MVQzes8vgW2ikeY7meSbW5IZlyJ3T1Eu1xZBpJxIqo1Qug5rXm2AiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:24 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 04/13] btrfs: update ulist_rbtree_insert to to use rb helper
Date: Tue, 22 Apr 2025 02:14:55 -0600
Message-Id: <20250422081504.1998809-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f29cb0d-8f26-470d-4d24-08dd817309cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwHc3AUPzsiKYUkduwhvQppBXbQgrFMmrmrt0B9Qv1jGR8A/FxfEGDxPCQac?=
 =?us-ascii?Q?zLMY/fffV5dYH/XgatFJnMPtnIhy+vy85NDYBeMoJosNYuK8FmcZ+/R9TsAa?=
 =?us-ascii?Q?wcB/8upMcRJNuI4hFWyXWq0bmAzhw+hLonOA6BzLk/VUF0UHOwD8bV3pXrlN?=
 =?us-ascii?Q?zic0vf/8oTcdlRBAon7fhQtRaw+z/VoBaqxKwYj+QLuYJhNrL6cIQoKglfHs?=
 =?us-ascii?Q?8MxcMAs6jG6nm/i5b7fsQkL7+V0cNRgstYt6fyfh2mYz+ujnASVqtEcNhzPK?=
 =?us-ascii?Q?gLUpdeUV1i/Yly492xxHzKG14ydfBKwW+BTtRKznZAFvifltnv8YRZaN6tUx?=
 =?us-ascii?Q?5TNWa+l6oqSGFPCRN8o5Z1WqYRM8fta/sb2OxXfWWpVDTm/hYsdaFb0P1Vec?=
 =?us-ascii?Q?Z6BQRGLfJnUU9oXQe3+/y3HNdcmmr9Fyl4D16Of0gLIEy6vugtIsQWv2Lwv9?=
 =?us-ascii?Q?I3r/UhQ1JUSFTS6VJnxtlLPMJ33ugzICpHAvoc3IFRNiNfFoykn9Si8Yi7Ij?=
 =?us-ascii?Q?mWYA+KXfaYR3KkGG9gx5/T03Nic3vAQz2z4MZNAX6LMXn5b9IDQWGTfprdCd?=
 =?us-ascii?Q?wAQc4zmDvy5UEBDZESGDz6r9OPsau5GBngPqmNWi2ioae8beid6Kov37Mi+i?=
 =?us-ascii?Q?2wIb62903Cie/gCWtOyT1Tv/E3Kwiqchf8M/JkJu4+goUI2SvrzPaWKeg2mH?=
 =?us-ascii?Q?fByRaZJXvBfd7q9ZtNaUXI8Ufywbr2d1pPG1WlIRLtAiOwQsdVP7Y0hYzGoX?=
 =?us-ascii?Q?OyWT0qnqc+0F6Hhpq2LcRinImUZaXkzNQtW2cfGwgVOO/r+fEiPyJpG3QSlD?=
 =?us-ascii?Q?Y2fK4TiyL9Z4AlePfI7G8fE/o1L0Zl/Zpu88QPnXI71gVBeSpd4YF/fXV+/j?=
 =?us-ascii?Q?+n18JmozewqxfT7NfY30S3BEJoPtrkLuQYi/WTXNTBMJIPGO3Zmo1UECzVBJ?=
 =?us-ascii?Q?eaUwd5Ad3SysJu1zhJOQk/cD1RjjWy/RmUsuog1IaHglNgT8Oeffqid17LYe?=
 =?us-ascii?Q?2Iy4K+RvwLPIp2OU48nCbqG+8cglQjaeIdTsEDU1frJ7NBFvbQ1zHwQ1lE/o?=
 =?us-ascii?Q?DlHL++0+Pti88Mr3DH/IdF7RIhTKi+96htMY0RlRCEOMdJnTa9WXNzYBSjvS?=
 =?us-ascii?Q?MALHpmZKmWoLgVTuBecIcjFEsr0iR9SRRIsjRkY1q8yo9fDMKCAS8MTKNhTr?=
 =?us-ascii?Q?aCGo6VFs8lvIOgu6AaeZAEDs5PBn/kj9Dj2mIWHZJDOG+VMI/gdxvO9cwmzs?=
 =?us-ascii?Q?xPTmQ6HreY95N9SxDsYstFZgENXz2LXcyUS4//hkFtRXFvtPnWKdTZy02boL?=
 =?us-ascii?Q?a4YS8WGXinj0JHyj8HdR5kJPzUp5UARP6xdom2CIAq8iHbVB9byYbWyhpg0O?=
 =?us-ascii?Q?J3roD/0z4V9mBH+b7CsBPqtHbEVqwBFlFd3ol27HYlXMMBeh7L5nYhff6ph9?=
 =?us-ascii?Q?InSwSSQnCVGvasmjeTLEu5GG2JN+kE5ln+K5DmZZyEeCC19E/vAfrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iiKUo2z2hAJi+smz+9e4Ay3XdxObaeDaKFl0CPHj+XVRjHupnZ4xpB6CySv?=
 =?us-ascii?Q?KnBqD+nwAN5L/QKrpZHv307nGqq51HwCa6rgz+PhKFi5HXLp9LXMk3g10AWV?=
 =?us-ascii?Q?v40pq2tx+s3N5ANpHZXYwbF85JLvT/LiOL/XXfdD6xgGyU6ojFeNAt5NbenM?=
 =?us-ascii?Q?jAbh3MW10PUkuLBsODwJX4ARsuBhoNFUTq8OFmyLjnvtQA3at4zPq5VMydk9?=
 =?us-ascii?Q?OAy98UmorxHRhsjtp531sPltslgBiyBQ00/N8UX8mNMDzCx4E2EPSEGBJ92M?=
 =?us-ascii?Q?GmzIczv6KbUtgRFziNL9Sb0oEx3RxFvoGeorApHsIBy/9ZtKXS1YXj0SICx8?=
 =?us-ascii?Q?nDRcW0BFbEr0tEda/wQrlR2Bay0YrLuioDRC5CdVbNmvT7PTxFGwE+A9SFZr?=
 =?us-ascii?Q?Onu5LYmJU36gV+rG0UHqbWUyqFeO0VlT1SpyFE7ATE53/U5c1akaH0lRjt9m?=
 =?us-ascii?Q?BxDnXcFMBrfcA/Ui32Mhh5XqlEZuoGAE1bcKxzLsL2XFvWyI5KPmWX91QIc9?=
 =?us-ascii?Q?7STEhxjp/wuuiRHJuPMNZcfbeCz9UD0dc79kjBAs4JHFv1Ns+JTKERGHvN71?=
 =?us-ascii?Q?TS4keh66v9wMXb0Ezrtjd6eMl5rzfII8jbmLazmfGEaE21ZY8UV6eHGIYl4P?=
 =?us-ascii?Q?jGjHJnVCnYQ97L2e5zNAB+VOSTPKGOKwjhVSuZ5GtCWJfjEIJKWa1H1meuOs?=
 =?us-ascii?Q?Dfscsuwgz8vaZ8pu1XRIQBkdbzn48a4zB9Lackw4ND7/UIKVv6YxJDrrKKb7?=
 =?us-ascii?Q?L5qR/7mzcdcvlicqL9B3hVl+f8mNzQnWG9fF+bUt4LLqPgJi270mxamn63Ah?=
 =?us-ascii?Q?Mv0Gg9uBVainTkL6BwaAqgeY+wYJa5e/QfGp82v751D4m2lm3LsfXp4iXHUv?=
 =?us-ascii?Q?/woWels0h+ybH4JldFpTcH36+v8yeVIM5gM+bZmwsYQW6u+Rm2lVcv6AT4fu?=
 =?us-ascii?Q?pKemg2f2LRdOsZpgEjSgm0tFzEyGijSPfXsQoh5ymP2KnFaxxYQRYBn8iGgf?=
 =?us-ascii?Q?JRHwtr3P+KLGpQaY6g8EKcbwTVni0BLX8ceG46EdUiDxotvMyzlBmzHAlLRj?=
 =?us-ascii?Q?x61SzQ/5Ycmvhm4LYOOpGN8/NGx2lJiFZGfwS62FUBBcsfVv0muQxLq/6HiO?=
 =?us-ascii?Q?xk8QV2JnEWM4pvxnMyddF3NZ8zUGpXZu3taguo/hs900+VQtDWJPRhl3kXqN?=
 =?us-ascii?Q?ujtzl2FfYLdUGF0tnwvp5HhGyLQqMhFGwuHQQhkcsDuzCGabxKD1s+JgGaYF?=
 =?us-ascii?Q?nPoH0gnW91QO9qYJ9Ocmz5x2uv6y8fxfJ7UCNtRCTOzh/W5PeogT6X3sUSG2?=
 =?us-ascii?Q?53nno4ydoSbxHZ/c2/NwOog94pJmub+uIABYf6LnO8ZKCl5bz1CWW+k3wx7C?=
 =?us-ascii?Q?mrXkDUE9YMrSPpe2qpe4DP4vr+LutYgmnWRnyGzskDP1jIoLVXqeJ7DLd7q8?=
 =?us-ascii?Q?WxG+NYt2I/1OR0zZf5/FFIeIPkaItpZsMa19RI1vUG6zN++cxMgowyaoXwDK?=
 =?us-ascii?Q?3wOgA5JtmZg26RJfP/kK/yV5K0M8pzC/thvfeOLNvTSifhFcXHyTmBfipJhT?=
 =?us-ascii?Q?F0l8jvB623s6rCLBfupBJUNKlTgPjKcN6FHg1hq1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f29cb0d-8f26-470d-4d24-08dd817309cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:24.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv1yTmC9DMi3h3lSZSDm5SZ5NENO7XyaAk+5AhBWJ4WERCqZyVe55I60876i26XJU//cCi+QcvWRh3QcmVR5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update ulist_rbtree_insert() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ulist.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 9cdf0b47772c..cef652986c67 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -159,25 +159,21 @@ static void ulist_rbtree_erase(struct ulist *ulist, struct ulist_node *node)
 	ulist->nnodes--;
 }
 
+static int ulist_node_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct ulist_node *u = rb_entry(new, struct ulist_node, rb_node);
+
+	return ulist_node_key_cmp(&u->val, exist);
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
+	struct rb_node *exist;
+
+	exist = rb_find_add(&ins->rb_node, &ulist->root, ulist_node_cmp);
+	if (exist)
+		return -EEXIST;
 	return 0;
 }
 
-- 
2.39.0


