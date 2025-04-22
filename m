Return-Path: <linux-btrfs+bounces-13210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF7A96029
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538717A6FFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EEF255E2F;
	Tue, 22 Apr 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fMw2BhNC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F717254B05;
	Tue, 22 Apr 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308541; cv=fail; b=Tc4tHcCJaI2EwHwmHUZsjeCqcSSeFzP4+kOVmmGTSWBLm64T7SXLqUk8f+1+aiCvQYZ11HxGldvzigeP9FWniovRiO6Jylm2QG1F/HmDFw9lIpycOP1rnbpPd1Y2Id+U8Mo91qj0iaUoTsC0UT5+kWohOKUlL8CJkNRaFEEihZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308541; c=relaxed/simple;
	bh=97vdhGiorqk0ADOvRTfOnLZVJJth0/sA4uRvIkptiaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtUJbwmCmLrOxJVy0/4dr1lzErfwmSLwGBNxhlsmKw0K48TMw0KTde6NudktW3KSPdnG8d534dCy6q6x5yE6MEoEWfToTGl1OvBBjhxx3ZixMCNqeyEGpP+dQbrRNCocYGYjwbauOP+mVve6s7SVa8LjqGXSZX9K7G4IpHyRLMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fMw2BhNC; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4zTzhDlBz7vm/bEGWTjhnwJz58OBeadEoz8bKiILdg8JPBZr+SYjRW5UeH+HxDF3IWLK86NpdTjLk4dg2n8kT7LpfRYvfqA9zk/Rf3j7/YgEMPc0aIMae+HUAROCY4p3sUc+Z5lQDD4talz2BKavpqJCL4ELfoM4C0JhJV2lqo3aPi+KsgfVkIRTqH2/DRm+vM9XnBhHITA3eJSEWTbBjgBRDXYlcN+0jt3hNkFaENS/ZoiE1YzrKFVkqKCscNkgTeLwnBwJTPMel1CbEL1/x9r/K8ZU2wVdjrUpEPt9gtxjoHe/Us1YCXVo1/bgS1rn4ojbND+0p0Jki2LEZFUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS7AmeuFO5frbUAUHA7BxazmHD3LknxdmR6DNoimr8c=;
 b=XWRXoSGgbwGEVz8RrX2EVzX8pnKcZ0LvTEbtp2tE2MvCgS7K6snSQLaC8NucFPwLeXzKcR3gEXZqbvno2dENa/t2FqovKtkORMhDYRiWxd5CXhTZ+vIRZGFDHt6ek35rVG81D95LmuCdmq67YKO2taS5a3c7uxZMjHgewwGgr8in9loAfEM1pAXxv9/rOkSyt9Pq4MLj+AAk+OMOxmROB5GVzK5FTo3bnxWaWH6nr5ka5Tvh/oGbwPVgtudrqNb0pL6XdXFk4UhkmV1zMrtoQ9Jsf9lWwCxeF/5HSVpYqw8WSmz1OMys3+pQTeQIHe6QTSBLBiT99xcQT2HhzMfDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS7AmeuFO5frbUAUHA7BxazmHD3LknxdmR6DNoimr8c=;
 b=fMw2BhNCD7iuC00SOsfRFbLQgtWHJ2/TQFVR+/bbJXdjTaMj8xzahp3GDkFF9tMqi2vyUBhpV4rwm0vuFyJHUfb8wtvzvpLYppAob2uDL76oDdmyG9zc+iZFQNRiDZ2ROrnfKaIr+4qYpIuJhQJNViuo9Q4hfDLEEnnl5gCMOKH2NA6pUKBH9olTMm9cvm8vXcxrINyiHHILEpaPXSTlY67YuFawpEt5CRt7GyTYAk6UVNeuybGfFFdhA1Y3ngKXdiPMe54U5U4nsKYKaDtsmoYUpvV7bwx6PbYPh4CmUWBddAhxy6+vkzPWA3TfVXoGQmOcXKEvFfrKI+/OsBiT4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:32 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 08/13] btrfs: update insert_root_entry to to use rb helper
Date: Tue, 22 Apr 2025 02:14:59 -0600
Message-Id: <20250422081504.1998809-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f3fd5d7-d85d-41ac-f2ee-08dd81730e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+G6v/esdEtssea79crlOAVjEtx3XwPI3jDdPDH+is+R4Qi5HRU9ASoZSJ81Q?=
 =?us-ascii?Q?7o5K7uuJHy6Er0AQD6fXeqIuOKjf6BhE1vPJmi7noecQm1k8lr/6fBtOXwOz?=
 =?us-ascii?Q?IPDihiiuddcNEoCnaJLXSsDsxAPkCB6TZCYN3e0Rz3HQ/6BNbGcR3+WzMhSO?=
 =?us-ascii?Q?gwRl1OjpnbUhRCzO0WoLNPn2PJp8xUTOw2tm5bMSwY318DmrBYGvLshZgkWI?=
 =?us-ascii?Q?XK9GsSMhOmHIEb3aNg+vfXQz5JOcJkleUbj8wHP0jYS4AsdG1fJ2oQ0M50eF?=
 =?us-ascii?Q?Z6QpMTU4ZwKy7wPwxD3+PdAbusPW+npi6dd6DqaqeC8lIrt4jRJtlMR77aqC?=
 =?us-ascii?Q?25bZaBPs6yU2N7XvHkBMRhoBIw+CxfHoW4xAc/vts/3sNboJ9SbTVyZBFdJT?=
 =?us-ascii?Q?6SVPQD4o5jyhL5QA+33SNMcsseO1Y6kinKYnu42fEkjk/syyzygSLLtEEvpM?=
 =?us-ascii?Q?KezPUgEc8scIov4AjaIZ/NZWvERh7TowZruF7xUSYn5VXyTGqhWWPUH6fVOC?=
 =?us-ascii?Q?V9WRs+xPcS64TeZOkvQjZ+Npcs6qFd3TsuNiWsLoyg6C/V0GMH1RfWsbVGhI?=
 =?us-ascii?Q?LhW4wpg+5r7jI0xPBA43ghTrjsy4kFudXrR6rF6jPbf5c0Z1JcPieC4nayzr?=
 =?us-ascii?Q?3IWbFuwi6WSa/9YOMqNX64a4sarLDBb5vkTE9stg4OTVWIOv+l7jCRQoTgsw?=
 =?us-ascii?Q?KFYjWAa3gV7Tos62WkrRSHkvm0to/DeQrw575TAn3My7MbIA4L2Vzqa1GSlo?=
 =?us-ascii?Q?crUPXo3vdG9yNG7bzxRRNGIUs509IZAr3RG6/Whdz0aK0p2aj9oF/F41oLm4?=
 =?us-ascii?Q?jDGxkaT2knivSc0Jnw/Dt7HpBzjCsrwpVqiik6i5D6BaF2yRSoISeTfaKE3E?=
 =?us-ascii?Q?LttUTwhoQktwygE/XomsM3QD0ytr6EXKTeb1pgRunrZ7urTmFmaeYI/5aWU5?=
 =?us-ascii?Q?6DhFFMzrSzG+A25ZNBNXV1wX0CE9kGX5tQNOM6zO2+33bkvoULXybRiEVojS?=
 =?us-ascii?Q?tvRNdBN4RHe3kz78qqaJoAjGi3lcdt1jDQKMBgOCyDc2y0iOjKlwY5mDHTaJ?=
 =?us-ascii?Q?W9tAWqR6GNVSZfZh0z8lj6IusZJWpoGHcFE6yoprCqoi+nY5ltfx4aDFmNYR?=
 =?us-ascii?Q?y+v23r+b/CgOqz1cSr02PXSs1XXGCXo5hEyjXRtB6+mnCWBIMPA4HQiUF8gR?=
 =?us-ascii?Q?7hfBxvcpu1iJkusfGOoURGM4dYyhLYOyyXnUh5QeQP2CJesj5xUmCriPvKwc?=
 =?us-ascii?Q?vNYnGubj2e3PeWUvvWRj1cXEo9mMNEvtIbgbv1oyxkyxgEB2UsOxV0VTESpP?=
 =?us-ascii?Q?hIOeAauwP9MMhrlZp7iTeJC/67bHLvmh80qIqLRAc1EotjTRC6L2as9OWbRg?=
 =?us-ascii?Q?7AXuo1e+yDKGmMeZjgMQ3FzO18qroQ9plSV7plycwv02dFXT/2+7JmF20sRq?=
 =?us-ascii?Q?+T5VCgrBoz5Ny6ONt05zCxfQwk6+QWdsCNX5xhnJ100V4ucLwam8aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvuDMlxOYpTuurtyz0w4QSKXTRU4bVgOoEbX6fZL1qlXfRPDctXBuSytteEu?=
 =?us-ascii?Q?/dRImo+xKhVII3cFbw6HlUC5FRNxgfFqxtofCJ/NemfEDN3MLuG79RbNuB4U?=
 =?us-ascii?Q?U+ayNRV8ltMAYiFvJuvG6Y3EiNsf7Pd8sWDiVm4nuPn6zhvKSHVNfRnLmEBX?=
 =?us-ascii?Q?NZWvjC5m/0J5hvwPmsdrVU89f7ChuOXC8JL3jv5ZgOfa4NyY0Gg4nW1lXOiH?=
 =?us-ascii?Q?dINr1M4405UwEbXbzGnODxaBaqeehKj5gE49OEO5Ev35cW367aBy3AirEUIM?=
 =?us-ascii?Q?2rTMGIMIkyQ4wIA9cIqz8Yv/NujXaibFfLYroz3TlCQQ9AE8GhxlQjLkys26?=
 =?us-ascii?Q?N9c2ZqSEJFIzW3mN/UM+2tlED8KrwVw4++E4yIOkF7YAwLH0ykiigbfUzmJn?=
 =?us-ascii?Q?QL7C1Rp5nLsABLRqXUqTmEt7aGnXMotF//QA7KW0m3aq/j9+pHu7uCGYpYLK?=
 =?us-ascii?Q?ZyNDSZO/yLm3/tYm+61xPowi6PGjbAdR9AIWI9BFpMRB/yUUd037AiT/arKq?=
 =?us-ascii?Q?uoaj8jDbPXoaKqtwe1x5kBmR+iN1AZosDBveqn9EXHjosianb9y69quDM8pM?=
 =?us-ascii?Q?lp0c+uhKI3bnNx2vSa4ISEmN/l0bQjFqYL+zCRk5aNf2hWb3jWSJ+hSZSqwL?=
 =?us-ascii?Q?2DK9qhjt+xZ8uEi95ZgoUo8b7i8oq2dApD3ZJmF1v8arFmluOqnY2DGotXlg?=
 =?us-ascii?Q?OziI+reY7ova6Lg5bHRm+aIVMljzF+c9N0FdrqboU0q4S5kKT6ehTQdu3h/2?=
 =?us-ascii?Q?uLYFc/SVuHy+/0S0cqFLbN02i4Uv/RByWKG5nij1lte8GarEJkmwuAWbujfq?=
 =?us-ascii?Q?zv0tO2peq8v/4nzzT0CAqq8l0yUtNDkLIkKoCezwKWJjmK7E6gyPgN5+uAlc?=
 =?us-ascii?Q?KcUy3NGTwHs4vnl/qu2wKc3r2kjqLCc/aKxawyrGK5ZuMctAm7pyYlTLL80p?=
 =?us-ascii?Q?aizgeB1h/5/gllhVY5mK56oVGyIxY2ym5uM7YnBxboYQ5Vw8Y6dVu2h0BI2t?=
 =?us-ascii?Q?ZQH/rD701ChQOMI/wL8SJpUj5k7KxOUncPX9VgHoQwKgMbDgY0vFFKk7qMMV?=
 =?us-ascii?Q?X+mlalMC9Plg8DZnZZjUCBRPT+bwk+E4s+LgHF2tVv8e33ElMqieDD2TDWqm?=
 =?us-ascii?Q?lw1ZKfdWdH4W2sdeEpdo9IiSFvDycsgFSFA8dsL1Ohdx/qQ6+Mry1BV8QKje?=
 =?us-ascii?Q?jMledJf5lae0TIu858j+SDD06xqgDWhGw2nZhnKcbO5TSV7DO1DkQaQ6oMgo?=
 =?us-ascii?Q?uWCbn8G34W/xtSrtGG+PyU0mJGXljlvh4oZl7glH5PV/EK2x1yQBisjt9RVd?=
 =?us-ascii?Q?KWQ1z1hlb13G3ipKnLJ1CFkTuWItZsx+CLs0LN3CKr185c63Ez/X1UtIkyAG?=
 =?us-ascii?Q?F/3WxBUYh0ZCah+VSZi3G6mug0BPtJPS2Ma4OqY/U1H1P7xkPC1Ga+0cpa9U?=
 =?us-ascii?Q?C7MBWpDshN4EmEwEVtlKeeX+by9lGmre9Aa3lPreNzY/fVvdHJ3Ii5MR964L?=
 =?us-ascii?Q?IA2NcQSyxqf4ndSjZI/p5MVq4KkA0+YDK4o/AZNcPVGTkCqBrbVqdHSWBow6?=
 =?us-ascii?Q?26uv41NukYX5WJBFn94Bx//tSfbyVO+6kTV0sh3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3fd5d7-d85d-41ac-f2ee-08dd81730e5c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:32.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsTsBg/2QUZMXDlMcdRnYA9onejGVzKYFU3Da04ox3X/+iAFLP/7m4AgeqQhVoogP9eiW7WBy4IpIK4h27GFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update insert_root_entry() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ref-verify.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 67e999262137..140b036b5c80 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -128,28 +128,20 @@ static int root_entry_key_cmp(const void *k, const struct rb_node *node)
 	return 0;
 }
 
-static struct root_entry *insert_root_entry(struct rb_root *root,
-					    struct root_entry *re)
+static int root_entry_cmp(struct rb_node *new, const struct rb_node *exist)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent_node = NULL;
-	struct root_entry *entry;
+	const struct root_entry *new_entry = rb_entry(new, struct root_entry, node);
 
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct root_entry, node);
-		if (entry->root_objectid > re->root_objectid)
-			p = &(*p)->rb_left;
-		else if (entry->root_objectid < re->root_objectid)
-			p = &(*p)->rb_right;
-		else
-			return entry;
-	}
+	return root_entry_key_cmp(&new_entry->root_objectid, exist);
+}
 
-	rb_link_node(&re->node, parent_node, p);
-	rb_insert_color(&re->node, root);
-	return NULL;
+static struct root_entry *insert_root_entry(struct rb_root *root,
+					    struct root_entry *re)
+{
+	struct rb_node *exist;
 
+	exist = rb_find_add(&re->node, root, root_entry_cmp);
+	return rb_entry_safe(exist, struct root_entry, node);
 }
 
 static int comp_refs(struct ref_entry *ref1, struct ref_entry *ref2)
-- 
2.39.0


