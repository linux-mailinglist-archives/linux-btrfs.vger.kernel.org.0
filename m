Return-Path: <linux-btrfs+bounces-14066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9DAB944B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FABA08624
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26399267711;
	Fri, 16 May 2025 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lNqh/YUz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DA25D8F7;
	Fri, 16 May 2025 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364653; cv=fail; b=P4v8B3OePwNKoRFXDM54MVM00UvP/KPTUL9xwWwT2xr9lEEOajrhvex3yXY7xLGGsT/kW+/PNYr0D2vT+hkP0GKFANuDcm9cgDvC+yw4L5B8FXn9y4eIGn2kz+5vxOhUbG2z+ONlGPp8kYEpSm7JRFfZNhAdypwkDWiit3U18AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364653; c=relaxed/simple;
	bh=Hkbe+4zFnOxJhgxveAgMtpm/tPwq/9Hree+1rHax8Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoIVnDc0LPUVhGs4TRYJK7NA2oClKDwa7pwEv8168ceTCChiDsVmNYeHqapCNk8pvCh2Z4XqeO+uk8n+GdkCUvDq8ZOA5vxEJ2AylP38yXV9co4DsQW3IDd6eqcFMoL5geOU9jmyDRhuZ4Y3TOl0v9gdQDqdSkEA+uzWLf4/zBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lNqh/YUz; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED0qMKAHqJibJ8zz8oc7b+VENptKcERNXTbtw+lrVj9zflRZ6B0a9YQOp0duLaGzug+1UikBNk2eu09EGyZNyI7Pma3wR6icbic/ewqpCVYwYltBp8eVBm21Yyp8fHjoHJ3kVBYkWn01SAl/t696msGLFWLjBX288AwmU4P7BaMNUGby2yXtdsPdT8dNefHNnPiYa8Z8kQqq7qOswxxdetxjQYVF7LpSc5kD8FVkB3WLv9mRCx5hwpm6AprGYYpveJBrmlTb+TtECN7kMAeBLOubRMn4MepgxIlYPKGbnSEfWIsFUoeIl6w/PfBzigugiyZMkE8BE+KdWXCMrNBwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8YcolHPNCnVWdvLYpdHNwqzZHjSu/zTKWyrbNavZyQ=;
 b=FDrg7jkbOfVJglh2dZM2aJazn+WJHRHRkRcQmVcztJibxVJlM8DOQOQdYg7bDZSyI0utFB0cccs8OYaujHmgDbLuCx2avwgnt1wLBGbL6ktwfBiV7BllwjmzbzKKbj8YTLvTwOu0rlcshUvyBH7PoZQvpa1BdBn/u/9AZxhmbX3aiYgH0hSEGD/e4oGEWJBCbT86rWHMqBBlZorPjre6Unnkt4yCPnOao4meF4TxdC1PtjQu4cifc9m0UYfKH3uiqXlZ/9U1eBO0wUhgtT/O3qcTm14mlq5EVpcoXfA4VxEUqBc647sQsitO+SHs/ZIxGx8cft0uzuFKHHgy3RWS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8YcolHPNCnVWdvLYpdHNwqzZHjSu/zTKWyrbNavZyQ=;
 b=lNqh/YUzgsdkGMGomW+caFaIxXdW2z+uzLR8NfHute7UOk1OVVj1HxlEijvasZfHoBEY9COTH/2ivhK3QaW89GI8ldL+/2TotWpIK285kKw/8KBWB5+d134i5KkY7KuxCZL4eHifroFxWhiotekYYj23D2cLM1LtAFKZ7VSWcMw3L+XH1k/cIOZfeqw2i8mCiaHLyAewAIJej48JDYI+QrEOIjNIEFWe/2cxhV3Tp9zkCrSKSw+eNgjBTSQMRc2Od9jUoEAx38JEbIpCX12aBI8mFsKK7EWww84VV2wMog50iRVi01l7vUOAyOmM7Hxet06v+gKknzJ7CVrZRnuoyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:08 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 08/15] btrfs: use rb_find_add() in insert_root_entry()
Date: Fri, 16 May 2025 11:03:26 +0800
Message-Id: <20250516030333.3758-9-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 949e4089-8c5a-4aed-d46e-08dd942652ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6JXZDKEbAgUlrzhOnVBPMdMHXEKx0Des4XsCJ6TNBzX3DT3aONBZ86AFf0+P?=
 =?us-ascii?Q?KH5mGIl5k+Wafvfa7z0Mtu4oWsEDv+VNUbsFU7PT9XwOlfKCYlrKdbfdDuSC?=
 =?us-ascii?Q?kaj9K3dRGknhaXrhZQGJxHZtMLKvmiaANhRw/4jEwpLIqhjw5xr9MmCPxfDR?=
 =?us-ascii?Q?SW7FhtLxcowzX3fsfFTqWaxBRkdGYDA7Uhh2Kn3SZukkJCRJU9JEf/IOM/KD?=
 =?us-ascii?Q?TKb+n0zDWP7RPBz6R2cFC3OMARevZyacS7WNe0z7CGZb9X4Q0hxMHOrV01pc?=
 =?us-ascii?Q?jh2RMmtnK09IsG6WIHmuz3knf5XWTo2MwsEaaX4tgJQn7AFagDjCwCRQ4zlw?=
 =?us-ascii?Q?FY/msxLvM0+EEgfjTPqKd99R97+k2RPYWS24hOMen60JS/l4/nZ5PBvqPb+l?=
 =?us-ascii?Q?VDpBHWAgUSxqvpEsj9CiN2V/Paj4AVAb+uMCKtsrei4GnmYYXY9V2IJfToYu?=
 =?us-ascii?Q?y/fswiuKR2BZMAx8KC+DQH08y6HGBY+i6Th8Jd0erTLQdWbfuIqr3H4nbpJ0?=
 =?us-ascii?Q?psgxV+Zt88YHBP3H1nPylI0NQFec+rGyBddFDWcB7N/KJU5YOf8Ssb0dxfeR?=
 =?us-ascii?Q?rfJTi29ckGQ/e6oYHHXz7aCGe0iiuXR5W4igrSBrJCpMXAMyP9Br6OZ/Bj/h?=
 =?us-ascii?Q?xrLbJLxqu9knI19sWWLGM1S8tDJGzGJmmmHjXA+t1UhnB14HSBkKzizpv5Lw?=
 =?us-ascii?Q?LoglvfAauWZ15g5g6MEqKfqfAIQ0CTDbwwDwsy+CLPaulJfy2FEOAPf3a1pr?=
 =?us-ascii?Q?o9hsTiqFasqJ1EXYWSJ3F7gJl0OrTMg2xl7NPr+NDnCHP8Be+c8g3yshJI+T?=
 =?us-ascii?Q?QqnQybWtnp8j3moX6EXaw4O4W+d7nmAwv00bweog4NhsWnUPduvxh6n/wWJ2?=
 =?us-ascii?Q?KkXm+zW0BFUiUHwnUS7BX6SV5J0r8v4FoFqaUk/aFyfo1521nnfBFD4lMOO9?=
 =?us-ascii?Q?vQcz5pzSDE5l3pDHuIw602KN9BaUo/kHWtPR8siWW6+m5F0GLFZhTo9tSy+G?=
 =?us-ascii?Q?Ew98ZB65cZgmVc5STeVDdCfvXcqxhFr+mibOea1HuC9ctrGvXYrAEbipDI8P?=
 =?us-ascii?Q?UT+wUv8nntqmS6LxR+AyqWc8JlkuB9oXlVhNMWfNMjr3NPQwnn/yQ0fPxKVj?=
 =?us-ascii?Q?ESY40xXs7fzDkpVaezC6HBl4Xd4H306qjYptjANYbewWpkuyzlVVCb6HFSJw?=
 =?us-ascii?Q?qTfUq8vokEnReaLx+QHpXQ2tRLvuCyHhKfCDGKuRPzw91OcvK/RhZWkO1rID?=
 =?us-ascii?Q?oywN2NQUw8o9/bC/2tw+2qq9OzzvI1OuCKa26bV+35rSpYbjEBO3aadxcL/f?=
 =?us-ascii?Q?y4Cv2tEZU8Mm2CMVQ8xdpRX94JV48leoY+z6wiGoN7QRDpENhQ+YHbwH4o92?=
 =?us-ascii?Q?NOaDDfDbpcZYevok/h8bJZIlVmSMWxLu/cwKaLDI9LE4wXb7igyUJmTKTyhT?=
 =?us-ascii?Q?m0XBT3LQNvKDY1My4s5Spxysm9IrbbBFQ7716jYRtxz2hAqzt12wXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eaDlNRLV2VP1GGf3oEq3+u0gYVN7w/L1xRvSTUEy7TvvIXAgMCqq5875TIzQ?=
 =?us-ascii?Q?hGE2iKrX32JYUTwfxnA7RstOTNr0lVlMHwnZKhfswUV6N4rDx7M0dTbfyDm6?=
 =?us-ascii?Q?Uk85Z4YzgnFcSU2/9fgIrx7lPjwGtk+7c1vKMOxFM+ZYqnDzY1wgmSFXCgb7?=
 =?us-ascii?Q?TBAew0ks8OEeaXhE2eP+FXJ9FnwMVgigkZTkjryMChcVflhikuOCqvRcOIbI?=
 =?us-ascii?Q?DTO0x1oKSEp4zz0Q9uMAZpBCr7ga0U6SIUEMf4v7G6frDJQZTYjXRhYZLQWj?=
 =?us-ascii?Q?hhVruFRf6Q59OnzoA1qPRgUP1NIlWqEwvdmjptP74P6zAtcaaxZlWK3Yjzoa?=
 =?us-ascii?Q?Nag0ZdFVeAHFbJFm0NTrFH5syP0Id4UnZUKE3tczAhsbM0h47ix+SUtebLfk?=
 =?us-ascii?Q?XA73+spp+uwc0roE4BcblzUyaDHAp+101U+F7LOouMhPVvi6hauoe2oHXuYu?=
 =?us-ascii?Q?1LPKEXlKcSSZaQSnC426F7AdjChYwcBXJ3YXc8PIcJK6LiStN8GMV+iztTbF?=
 =?us-ascii?Q?aqwPR7zPS8TaxFrCjizbsUdYzAphctwMVzRJ/Z2InCx3VcYjcd0Wxcp04Qu0?=
 =?us-ascii?Q?tKFZtuHLM2/GlCFfki6Z4guZ7x6wD3yz+CIfqUorSpGlDUdvDZi7X2E1yfB/?=
 =?us-ascii?Q?yASqxIGyKAwHIBM/yuoUTbP+CqoYnuChpCe0Visj0zijzeC+EPTyPXhKJ1LV?=
 =?us-ascii?Q?EC2BRu4fOYufTaX/UnEMYbj4peo6iHWSo4e83Vv/VgnsQYIfimrgvVmJpthZ?=
 =?us-ascii?Q?8gRzZkitlxuKezeuM5fK3oPi4448OBt7EGeTxcDsFA3OfdY4q5dVy2Iiz0LL?=
 =?us-ascii?Q?asALSwvfHSNBOTHnTDgnLorWzAqD6zd4hnYz0hcN6UjsrGdGKbgms1e8+Zb3?=
 =?us-ascii?Q?oGYbteKBZD7OQMgnZDUV62aQZQJ0qx/1mT47lexpewLm/T3SzXToV4cu6hku?=
 =?us-ascii?Q?URkuzGFuvM4/CK31iEhALtMxWMYR1Xkta8o4rzYIGIhGdv0dF95ugv5p2Egl?=
 =?us-ascii?Q?cWAPrCglEpDTcZlT2eX3XI75d1spA1uLLfuLi5gyPDtrt1g5HLWL7hcnIgzv?=
 =?us-ascii?Q?kjhnzMXLSwQ+kaI145LO6iL0JFCXvFqN7/6UY8cUv1T4nCVSWQVDrEun1O1H?=
 =?us-ascii?Q?5O12PQvoZOBF5Z5ve9H8eBe5Vq7hOMZUYh2Su8YBvX4Ms99Kzk+CWbe88Zp3?=
 =?us-ascii?Q?yJGM85lYIqqN88gnDqLFMbZJsWoL5kxbiCR9tlN6J7hsQVVLGouz1pDLm+0i?=
 =?us-ascii?Q?2LSvb3pHFHbpQvaGjOWWERmo4WDPCjP8sOEVgd5jadDdbxV7BIchUtfu4q8C?=
 =?us-ascii?Q?AmFdA4l0CX9MDlEfGmPY5cN+l7499En1QDhQV4BuUdsmb/7jL9zwssGATx42?=
 =?us-ascii?Q?e0GHmCKX7si6BJubqVHCY0h+nohyUKFA3Kjn4mnSHVnmwKn1KJJ+AYIEywha?=
 =?us-ascii?Q?gSrxq2ozQKDwX8PV84VPwjkQT25qX9CQc69DKzlvXU7RWrjXsaRLp1CAZG6V?=
 =?us-ascii?Q?a1I0vfM4ZgtMk0hSJ+Wp9rdrW0VwuCzXJdSSDzOyH13NPP8vDOtOf2rv9UdL?=
 =?us-ascii?Q?Pia7iZDBGrc9hWNIT7biiVchgxmgJ0LXVP++dO1X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949e4089-8c5a-4aed-d46e-08dd942652ec
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:07.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzszCIs5SpZa5H1O0sgACj3PRdWhjdg9i9qtZiMcWgaxdb/2nhEentNedcfFifx6go8y3yM09sNhN/rhCcH5FA==
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
 fs/btrfs/ref-verify.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 62536882e9d4..f241ed4bc21c 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -128,28 +128,20 @@ static int root_entry_root_objectid_key_cmp(const void *key, const struct rb_nod
 	return 0;
 }
 
-static struct root_entry *insert_root_entry(struct rb_root *root,
-					    struct root_entry *re)
+static int root_entry_root_objectid_cmp(struct rb_node *new, const struct rb_node *exist)
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
+	return root_entry_root_objectid_key_cmp(&new_entry->root_objectid, exist);
+}
 
-	rb_link_node(&re->node, parent_node, p);
-	rb_insert_color(&re->node, root);
-	return NULL;
+static struct root_entry *insert_root_entry(struct rb_root *root,
+					    struct root_entry *re)
+{
+	struct rb_node *node;
 
+	node = rb_find_add(&re->node, root, root_entry_root_objectid_cmp);
+	return rb_entry_safe(node, struct root_entry, node);
 }
 
 static int comp_refs(struct ref_entry *ref1, struct ref_entry *ref2)
-- 
2.39.0


