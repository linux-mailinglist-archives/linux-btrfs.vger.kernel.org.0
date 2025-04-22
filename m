Return-Path: <linux-btrfs+bounces-13205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD8A9601E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F03B9AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457323F424;
	Tue, 22 Apr 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fRJvwETj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CA22DF9F;
	Tue, 22 Apr 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308531; cv=fail; b=bRH6ExB0p7PhMHeCAy2h4pbU520KQJp4SGnEfogjvpFlux/VwMgaaJa6Ma7gBWiqp4hHICZS+1G3L5Q3rpSw5Deun2hJXOdDiTpVAaRhw7/Dbx9G/GdlrebVpEOQJEfdWCViVERqycTkbGhggb7Xxb14B55ppq4FWWXOuPcGr8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308531; c=relaxed/simple;
	bh=4lZqB4kezoDgpRtCivMVlduN/iTM6s2O8asosH7d0FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oS0ldaBdW8nXdrGqLRMjWdh3H2WHF165LOCr1IZv1DDppoLgLIjdfcEYYhezefb8ziujveiuvYgWdbmtT0LCfGakUty6RzifT84K3JmfWqoeEPb7ezmomsfHqrz5C87FY0M+WuEqpWhcbkUSmBQWRDtZXzeKzAlk6hYIlOM/J2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fRJvwETj; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W140wqWuGHRBBdoICKgVrgZC8V0c7oGXZGjK1RZ8mPdZvSjoGKjUkfb/ossZmUHMsy52Fjy7z1ygrEVgtwbhwsKLkoqzmKcqv6q840FLBAk5wbsBVVGo86YIGfUAyaIi4YXB3QHYT9p//uGVGNpkkTkzdzg+/KTs+Pvxw9EIZmXu2pVhbqHp1WZq+s2cuHdWG18Sy5u+O/sn2vbbKOGww9OaSNKA7psP3UZvHfUhB0oe+aMA+9UJ+l49VO5F5aLuq+UbSl9tBvgIg63UTB5hoYyVVLs6XR0MxA3SuFPA7LHfPNvjjvvCpTtt3WV54ecs97J4/aBO0Qa0kEXWEuxn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHpwIOdvt0LDo6mpMebJ/CmV0p3Ihh54sIg7YxNSdMA=;
 b=aB6TTqBAaHYPGKIgVQ9/GFWFn3kqW1JiK6EHM0rrCHUvWFeNMocQXJPS2JDAzNepQdybaORlX0X38wEKJigtFQo5Nsg0sawRUk4iS/Z/nVQKQ29U8ov0KQutz8GCsxnzcOdGi5lFL0jBVct0aPmTLaeIp1/6yI/ALg96AmgkOhAKCMh98gCJ45Stmpg9d6Q4E1803dGz8GybseQu0o+iFMv3cxVn2XqVLdLaZffqwd+69s9qS/8/yRzJqxhioDUfSRZ+kRPr2M06AeDQQz4Gv4RR4licpGCXNUbXavwn8RPrOsmAKWaqNRQyymSSpaiCzS9JO288GTRx6NTDCjYT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHpwIOdvt0LDo6mpMebJ/CmV0p3Ihh54sIg7YxNSdMA=;
 b=fRJvwETjYBzhZ121jmsMGqVB6Nv4hN1RRSuWFqlwOTO6ghN3ZvhZymqP5uMZv0Jf/gTmNQ01ETr9mF8ANTKcRgMufzNlAT5MfliOrQHtFXysbxJEq52IJSy0wMjWXSSW8L1c6VE6ARj4vyiN0RguUNrHJYF4MRvCF+x9QdVrLWp50k+6D0FRfXO9pv/tbkc1r8VknlhMzKdv9zUYdRix5Ri+V4Yzrk1PrnVic6bC7bB1Q4oOvh4CxreTPSbcYoyTk+UZhE3Qgecv/u7WPSJ8cAom6qbsSM7JW+uamOVo1a9ObeVt3TDmbozRVEfLPWegwTgHHLTkTKvIfDagn8POsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:22 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 03/13] btrfs: update ulist_rbtree_search to to use rb helper
Date: Tue, 22 Apr 2025 02:14:54 -0600
Message-Id: <20250422081504.1998809-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f692fd5-b53b-4a06-a2bb-08dd817308a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oy5cvOoyu9OOP+bWEOV0BvCTWraAzGjxU2hN9HENXeJl20OPSy47ubkkt9jK?=
 =?us-ascii?Q?VC/pKs4jf9SX9OmqJGWft7gIUEnmbCfloIi17uBMp5IYhMzb6jO8oL8okHVr?=
 =?us-ascii?Q?ZBslXMsf7Lq4jsuV6QnzVWZfS8HkNf8tRWJeYeuj/iHNnPaIlvyF3E4a5eXy?=
 =?us-ascii?Q?WEp7MdPz8fCA/68PPo1myRRh1AOdDtmzU6Qd7uoFZh70VWJpJsU3UuasHXmH?=
 =?us-ascii?Q?sT6yKPQoTF3bqIf4XHJr8A1lTG3kmMLln/VRASFleFRdhsSEBlcNI5F7MbW/?=
 =?us-ascii?Q?xvJy6t4v7yIrvsM7DJOjvlNjazuDf9Me/yEsi78/pkSCs0kVtc+a2xzPtmhT?=
 =?us-ascii?Q?Xvvoo6HIMsXXmBWj9Ly4l5rjw2eXaWLGI2kmKJ2hNPbGxIlPUDz+cZJPzPog?=
 =?us-ascii?Q?NyZvqOMxsCdBFR3B7zB+xFEX4XzOJhs1o5Zt8yMKVcIZWvPWjV7s63lXgHha?=
 =?us-ascii?Q?tEeDcKWvMxiRl99MXNuQ6lhev8+IvOPISLOfdF+aswfQ39wp7ssuj7hpSEk8?=
 =?us-ascii?Q?ocfEIrF0uVpLZKpQb+KuYfkT/5X3GoUApIefOo4KjGCpRODbkQ+CISUDF0Mt?=
 =?us-ascii?Q?fbRq/DPUxbYRMRyus+kQYYpdNfD3fw5FFJEETs5MgOwteCUbWrWXQ+UFXK08?=
 =?us-ascii?Q?57CagsVlcC2L807kYG0jdzZCIoktLDXgzuGU5M8VMY6ALwSotEa/fH4oBraH?=
 =?us-ascii?Q?kzCIbY3M7oLKHxlHxAOkIjQo2NF5gDku05y/FsemHrhIv4R2cwHFrWsYeO1y?=
 =?us-ascii?Q?CK+ne6kyije/Tjd1lehVI2hT1w30rPgMT+itsJAcfDmnULroywDe4PZ5L5bt?=
 =?us-ascii?Q?tj905eSB+cXMVQbt33DLOL2KzoJ439lKfrVMwKdt7sVIrEWTPQNq+Stu0WS7?=
 =?us-ascii?Q?d06vCQiAIrt/hMkUxOClirX3j0N6Ou0CMLKlwcC/cpBaE71KyKpcR0hZftXf?=
 =?us-ascii?Q?g1O5ewQdCLu2fM6qr9vRdPZ0htfFTj5hg2pXLEspYobVn5Ce1OL8cuqSVZby?=
 =?us-ascii?Q?W2ik2igv3Tx4WnvEeQah+zjx4BQRdzil1F2xV6aQxMh3L8gy7PeY4fnsG7Wo?=
 =?us-ascii?Q?/7uXveKqAI4HgErrzWRr1X4ZXR9J2aKehDZ4CeaFVObHRyctuTV4lfY6goqt?=
 =?us-ascii?Q?4nXJG49Uzr5vuhbbS4YL0+qOhMxpPG167bAzSpP7FSSbtw06VWGtQvrH7aeR?=
 =?us-ascii?Q?uSwxl/sVsaVeyOh78fKJJoTm//L5U4gsEb+SNfEdOHc+DH2TggIECnRH/VmN?=
 =?us-ascii?Q?kWHFng+nK6dFYKiJBAkrTJfbzAWDGTyeIrnx86mwQWcev5k1rRv2RS5boJUS?=
 =?us-ascii?Q?kGQ9Q6N0LzKusbLDb39pYUn1tYfDX+2sDYbQ3ibRGYJBT4eherb5uzFs6mS2?=
 =?us-ascii?Q?lAJI3SxtYSCWu0NcpXV1KCKKxN1KRY+UPGtQf255XiuPy1gVqcJ65x4tPo9M?=
 =?us-ascii?Q?hgefTUCyoaHr7iSPhiygIepst+bULo383ol9Zod5z0UlMsh99ANang=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PreXkXdg6xsAhoBqybGfCvar9ABpmD81qCADdSLzRVMoCZaIOD5nxPlPRQCG?=
 =?us-ascii?Q?7jmwF91wOZtjM1c1OMTahAby1me+/c+AwzuG4ckBzAzVLRW3+N3v3dnjSxn5?=
 =?us-ascii?Q?cswlrIaiWwqKpRoY/lwucLVGmMIGp0dGk2eqMUddvnxalohG4P9r0D7FXltu?=
 =?us-ascii?Q?IzvI10/qSKK1x7uaW9xmOwySqWzlG1u9WU6Y0zimgiWvMwoWQVxdeyB0QA0t?=
 =?us-ascii?Q?Rsu0NEV2deI9FOsmosZRBVM6xhQVmWMrO3bgUSwuHQiwbBZMsqdgF+xt8ZWV?=
 =?us-ascii?Q?/wV68zCWQbOXMQ1qpwZxOzB+zlc5uR/BrmG1RybokIhr0Yy0RSiD+BfVIdCz?=
 =?us-ascii?Q?qqsUs8ir7Y9GqI7hYiI2NNiR8spYz0V/bNPRvb72Lktxi6FodcD8E8w6Ynly?=
 =?us-ascii?Q?d1ukX5zp8zfRUG3cCnfEuBdb0qllQKIjQFtDokyQxHQgsDPZYCxqkS5pkap4?=
 =?us-ascii?Q?CeJnqgg1JRIiQlrJhBoQ/qHLT+++ZA1RDdJ5VG+05X7r43R6Vc554pC3nuiU?=
 =?us-ascii?Q?VHwE7ZOe5q/ls/Os12k77KAOpgWXCtAE+gY35NM3ZD/0VqyeRE36b6kyeLYx?=
 =?us-ascii?Q?hvm+5I3ffVvkbTJ28wWumKm/O2ufFfn/dArX3EcvnkNyTsxORKBtL3MIRm1X?=
 =?us-ascii?Q?Io+7oXj0zKSZTyXxc5OePt0zAfb0Te4BXT7dDLhUvnzSFdRfmJOpme5oKUpb?=
 =?us-ascii?Q?+j+N2ZGgZcqMl9RfUTwjOxw5FfzjASOjVuZoNo572UNgbLuU8n+v7tZmFDqn?=
 =?us-ascii?Q?zzTqcnFp6PfckdTIjzUBShGxJWaT/YLUciQRGzQv2H4W+XOLAYxqRYNrydXk?=
 =?us-ascii?Q?QVwm9pjKYz1TSgAF/QmM7DvMfa8gqAunXMceKzZsuQ/Ka/rMVCLKomKStGxn?=
 =?us-ascii?Q?AIJvkshJ4erGXupTrxL/aR+ok9fiyTuWm+froI5E+SlW57ZjcEubBCkzA0sO?=
 =?us-ascii?Q?P0mLTq1ksOsHqmEce56XMCHGOnsfbdlCqLNzbO3Xs+dmGxTaR8aDlU40z+Rb?=
 =?us-ascii?Q?kgYTtdfXJ2ubnR9ukQobuCWf0opZ12cA69C+3AjQK/Y6UbilpH5m0bfF9+wc?=
 =?us-ascii?Q?OXLc2xRZeLrtyCmmcKS4pR5PpCyXofNNLPfO+Yulqk6A+uIykj098HRURHjL?=
 =?us-ascii?Q?U8rZofqONiFgDDNpaJah/9CE0Pe6ECohuftB5t9+KmgydvA7M0kzOzLhQPZG?=
 =?us-ascii?Q?7tqszJUH1mS9HrE4JJgOA/EAxZwPLVhw/Ln7P9wXAmVY/ddxqUSu2MNS7++e?=
 =?us-ascii?Q?Sy3XR9TVn2l1+LraI9xHM+KfoYX1ifXCRpZ1wRCNLEFj3RL2efogaJyOcApp?=
 =?us-ascii?Q?TRWnXnZeU1GR9KVM2NzEkMZubeiGnMQbar2xqYdaeNYU9uvtxlpmTyE2AlrY?=
 =?us-ascii?Q?BKDRNA9EyVw1nCUoeVkILu/CRGghaLu8l4FffX9eoJojZsnsGRed9qgjlGRM?=
 =?us-ascii?Q?nEnBaIVPUndmC4cBVvKWVqydH0LavEcKw1MevlnJaO3nG4EaNRNPG/OgZ7jx?=
 =?us-ascii?Q?MuYqM7OCz1sQ38AJ9NzQB8JqxiJ6r9UwPPMsDvyhzYqJCpF9Qb/MaU87jaVa?=
 =?us-ascii?Q?QFzh9eSeOqHHqoluj4rGHeA7P0fdKSQWEWEENYm3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f692fd5-b53b-4a06-a2bb-08dd817308a5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:22.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cqXTlcVslesv/qLIuMi7pa8stf9T8T7ttWvZn/wjLPxp1Ed87Wonc++FQLSMrr63GbKb8bGBAMfOY7bNmIZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update ulist_rbtree_search() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ulist.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index fc59b57257d6..9cdf0b47772c 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -129,21 +129,25 @@ void ulist_free(struct ulist *ulist)
 	kfree(ulist);
 }
 
+static int ulist_node_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *val = k;
+	const struct ulist_node *u = rb_entry(node, struct ulist_node, rb_node);
+
+	if (u->val < *val)
+		return 1;
+	else if (u->val > *val)
+		return -1;
+
+	return 0;
+}
+
 static struct ulist_node *ulist_rbtree_search(struct ulist *ulist, u64 val)
 {
-	struct rb_node *n = ulist->root.rb_node;
-	struct ulist_node *u = NULL;
-
-	while (n) {
-		u = rb_entry(n, struct ulist_node, rb_node);
-		if (u->val < val)
-			n = n->rb_right;
-		else if (u->val > val)
-			n = n->rb_left;
-		else
-			return u;
-	}
-	return NULL;
+	struct rb_node *node;
+
+	node = rb_find(&val, &ulist->root, ulist_node_key_cmp);
+	return rb_entry_safe(node, struct ulist_node, rb_node);
 }
 
 static void ulist_rbtree_erase(struct ulist *ulist, struct ulist_node *node)
-- 
2.39.0


