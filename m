Return-Path: <linux-btrfs+bounces-14059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA2EAB943C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A57B1BA38B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D577228C86;
	Fri, 16 May 2025 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ktpuTd5A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672E23CB;
	Fri, 16 May 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364640; cv=fail; b=C44qlVPdtSYloxFheHhC4UKNroFZSi3xSNM8USWTvPFEcqAmc6UOWAvyYO6Q/SPc309xPlEwlN08rHFxZfVibSF9rAC7dFVZgP43WcnY44zJ6prOKxEJtyAWWGKrtmaW1JUqGUFH9LaQzyHlxyoXBg0VDPenw8bJpELEr15cA/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364640; c=relaxed/simple;
	bh=PReEZLqM0M+gBjx3QUAmt7pp8QemDKMIk7Y5Gc6tVUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkwcUmc2y/GZbcmZlgoHqHegDPvmv+xHJdp7FVjPUyvhbdiCXnJRRWS0cwZUhkLEVlQEf0+JeVwQKWBfFHe+WmHwhy0xk0kdKeHNO1zlStZK6sW3KN+YkdD6v3cA9yZWeQXb5eEJdEeoB2gZ81EpCDnL6Rz+s0Lpxih6dT2fFEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ktpuTd5A; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDjTpc93yZcvLCHD2t446Sd/FZALjW+dqqfGqQc3QA9Nga/OAIXyK61VF+XCC+gsng1uNYfbZ7A9gUr+wTiQ/rG/n6vIrCe9AzcgAxOX3sx5rvXi4BFLRuT6ks7xpv06qUB3xGME29Ed1QcwlGhimY4Csm1QokdXx4vAJ2jPBQxO4vxD4zo/0wdPRdfwBG6z3Bh02c1Jd2f0dIU82ymiFKhWnghjoGJF0W1WHBS59nggnI8dloZANWXu5VZ0HlbnIcDc2uw72ni82k3qVw4AS0X9zok8A5bYN07lpL7vMIhq3ivxas9HhocAyoyyQRpUPanN4Apjms68nxRvYo46lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXN8R5PvW9GNG2ZA0rJQyGu1k265YB4WZxPO5wSflEU=;
 b=l8eBtc0sUM00zYAiAy7SgogNDu3DO8RxnxRv6EHziWlC84mFgbiGMz+LU1v/DfchseS6AvMwxPem4bPtgEFoFxkTBaPyxUZ8IMgs482DPsl9jmUuxclmGIgqhjbxU/DazQmTMY/Mi/aLjfjR9dprTTP08s1b+wCW9Wkpbx57JdAEzYoE8gk0VZNShn8UcjnI6k8Cn8mdu8nzUiPtTEBAKoSPboilmt0/1LYUNsoXy//7ioKj363Raiw3f44N2ffL6+bE/2wQs5yUt8UNyt0D8XAHbwhlaj9Kyi9szeBWdNW2XVQQti3Rbje5QKCE2dTNvNd85UfA4o2N5yMOAR0zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXN8R5PvW9GNG2ZA0rJQyGu1k265YB4WZxPO5wSflEU=;
 b=ktpuTd5AIoc8crSu2ptPBz5IwekbPLpsR+wrlwwiu3vyVTFpMRJFaed66afQ/mtgPGLrvi6pcvj5xqhYYWfm8aC3sNTW3JLPUss/Vqb7T+dRc2QEKmeyRLuzUhNQmVIc8SRRmHT/RfJyPf0CVSSAYX/bXioXmz2lx89scJiz5UQVB0mhH5waNrOwHVg+r7uNA7I8qdjDE0JBOYRwGcwEa6Bapv/Sa2YyMIa+hVR1/gGQU96e0Zhfkq0ZxAMkNJgZZ6mMNLJWzd21Gaem/YRX0n1VdhKaOf6u0ykTf9sDucnTNj8mMYsBsqKaA5LGvihn4JguIsajWZQ0emI/pjS8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB6159.apcprd06.prod.outlook.com (2603:1096:101:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 03:03:55 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:03:55 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 01/15] btrfs: use rb_find_add() in btrfs_insert_inode_defrag()
Date: Fri, 16 May 2025 11:03:19 +0800
Message-Id: <20250516030333.3758-2-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYSPR06MB7646:EE_|SEZPR06MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd215b8-679c-4192-2919-08dd94264b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sK6Id19gYAg31E81tw+uePIVyc6hlUvJ+AyQ9Q4uehfM1NY0zYPwBueS5iep?=
 =?us-ascii?Q?Xv8cvmCxaBW0PNxYie+VMd4KtbFe1/6jF+FFshZJBl7Fdcsz0Slh1IbOmkNQ?=
 =?us-ascii?Q?s21MlXdV9xk/x96MgYXAB0CZodGTYgVIWYLoCd9s8bLA5AZL7tLIbzdtkPLV?=
 =?us-ascii?Q?7TB+1AqUW93AB0tLsVe9ATDXu6NbhxhtiwvUW433M5DNvkHRG6whbRG3TMJO?=
 =?us-ascii?Q?BLqK5VBf6dunx6hfX9dBYfMDb//coCZPNnuVS8mtonzRL76pctZnC5+f4C6p?=
 =?us-ascii?Q?nSAjuMD+za8owENry1LqB57SSJH8QlAFU9rUEihjvtGUCygw+kxdA0TNc3sc?=
 =?us-ascii?Q?oCpJMHGs+wtE+qZmQkoS7tdMUEo3wk6k+/9IZDir9pj4aQOvxaDJvlrgQOTa?=
 =?us-ascii?Q?P/r+NC2vlXQZGfJK4q85ywqDaP1fyWanOP4hNpiHZVTj/iGks+G61O7cb3L4?=
 =?us-ascii?Q?E7xC111zZbxJYI/j1V/wPlpdE1fCqow5r0asCFOasDe8+e6t4m5GIYnTE56Q?=
 =?us-ascii?Q?4DIAjN+imS/0stGpGdW7DBEWXDXTCOale49+HoVwXHl1EJI7rN0Tnx1A4WHu?=
 =?us-ascii?Q?vPrwSFNR8I4ZNnHM0bTHlOyTtXzbEcRxZUGy9ri9gE6WxUVnC8jZvNgaRYC5?=
 =?us-ascii?Q?GtJKBi9FZT96nBJUGxYuT5a6CXCBqOjfnw/M+0Ho6WrLGLWUrApFKFw7LYkp?=
 =?us-ascii?Q?wjjCfNk0+nIxkZf8Gw0yumx7epcG6zNfCMUfLb4fGCWLJcWmkfeZchh4Noxl?=
 =?us-ascii?Q?c2XwEKFOnpq2Uu4DAhUNuI15xJYuwYcm8D7ahhAdWnubzoSHbjPhLnQEKY73?=
 =?us-ascii?Q?qMmtVWiaSFxCuo89y4DAGfz0AKAC9jPdKdZ2nH/GuJDujFTUwACk7DbDp66p?=
 =?us-ascii?Q?+wXZn1weMS1fKbWJ4qCpPNX8+hDFryM59hWR7V/rhRoOtmJzSqX0nA3OH8UO?=
 =?us-ascii?Q?YVYxqxLL6sAoOMymGs/mA6Oqr4f0eKRTs7WlEQMn1IsaQax66gPwceEwfTup?=
 =?us-ascii?Q?Y1+QoApd7cADKqSdKE5pYcLhgOiTZLTAyNmlpWqeqOcGVFJMLkjV9z/qkAdU?=
 =?us-ascii?Q?kFCvn/oKJqPncDqHV0gmXdJG3arJrvxnYsx1OIuyiSF8Wjfkuz2x9Uyc/iF+?=
 =?us-ascii?Q?IbFRDCbdW+OP7NycH8i9VwX9pz/mtgXWhGQ8vCTgifasbP82ZyDj9Holm0NF?=
 =?us-ascii?Q?sq31I2hyhdBXbMirUvxl7U0yPs0GUxLyON1gRdsp299qGPhA1212E185uH4z?=
 =?us-ascii?Q?d1thq7CmXjpqGi/fdtL88rn/0m5QIt+1SseSlReA0UIURIFO+0rDSOct/Pyb?=
 =?us-ascii?Q?UUKyniVEKUXI4a1DEaK5yh8IZ/sFnxONBXO1dKMBYonxvtQgcmHyUFh8eySz?=
 =?us-ascii?Q?uLx2vGMIHtruirnxQePWKbNKLEEGLmpsSLWUiTmKxH/zHMoXTzOgRMKipOGX?=
 =?us-ascii?Q?hHV/bA6lMHy+1YAjnENL6iIWzPpQOdhgArcr30kzzPoqFI4NPsphxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9KXNhZlDabSsfLJ5J1Mi8pU3OokYJEbEsnlNCbJGlZB+2eCpjxCsxxzh4nj?=
 =?us-ascii?Q?Mtx2Iix9sJjO7e9dfx5PPedVXsY3uJStlP1wKL4yXcSWvu9ok0ytwc2sKa/l?=
 =?us-ascii?Q?+CgKjBtPQFFyPMXfwH6OCKDHSlZdAvQj1GDE/nUmvXXJz/yG73Eqszl02gPM?=
 =?us-ascii?Q?kdzcieNXUm9x1dtb3uJU+gPWi4+DqkiUSc6bauTpLJ3l+0XJ2F7xf7uQKb5C?=
 =?us-ascii?Q?q6fuxWkzJtlvd90NLXXAsf33Hm9KDS3+O1HE9EqoZlFQKj2VGUvDo9dz0qfq?=
 =?us-ascii?Q?OtNS0N4Od38FTXRBkWPtZFRK6m11MX7zLN+2yoHXIs+TIyttgvbJZfdko1xc?=
 =?us-ascii?Q?ex9/qspMs4EgvKkDP8k115CGlmuAdrokyYQJVFBcqRnRpglbMUtVEnKRUP8l?=
 =?us-ascii?Q?w/Clkv7mQgOqnW3VfOajMWRNWOxVQR+kuIpYXO52VaXxxYPWC6BYpwtcCWSi?=
 =?us-ascii?Q?dKHDZrhpw9ecZFCxRDVQM3KEmQdWE4oVqRbAQ6mLwN1aTJpp9A2JtjiuKDMz?=
 =?us-ascii?Q?Ghp62OmSjE0W4JfcnXNEMsXtRqIXJnnJEKm90Ck9lnlpH9M4wGtM6FforOmz?=
 =?us-ascii?Q?UvfCH50FQ4IwHN6i9giXDdxzTThCV3Dud3XfQogtvBeYs6s89FLN2kZltu00?=
 =?us-ascii?Q?g1Qqvb3+bU0PSq6Boo3JZ/AjxB3PZWx4BLa870VV2FTuoY1OBGSDJJx1FpAq?=
 =?us-ascii?Q?nXjFSu61RTxNGHhoMVJZnZXHR7eOnqSCqv8fIeyFyTYCGY6CxUNczSf0HAqE?=
 =?us-ascii?Q?7iRJzV1yqrs1w3Tc3w4tngt4UlAtXBNVLK11h7feTTcagIswu8l0DTqRCQZW?=
 =?us-ascii?Q?oOsVAKzNblyhhXoWLLy3OSg5tJDE7vuGdP9X2BflL6fuFX41YR+4Jvv9FIkW?=
 =?us-ascii?Q?A1FrWNKhGZONrkitLQC12YUyb0x370nIRCj7Zgu3TTZqeMosEcucDXnEG2wQ?=
 =?us-ascii?Q?Czlr8p7dHQAGk2Kv9CtBRFTMMVSFb+A33SEPB71Y3qTpzTPq9LHPPOAVBxOt?=
 =?us-ascii?Q?mlaObZjkUU3Vd8CNIUkU/nNFkjrIA6KdGf5EDOUI4XT0pdvOKGspAGAauLe3?=
 =?us-ascii?Q?F838VkH0IU5QzzYrc9uObQIuah3iEhK/AkMcDFen5OlS1Vy8qfJqybPSjLUZ?=
 =?us-ascii?Q?mUgVwHlZzbAzJvfjP+e1//Pw26YYEU5ksrIQ9PS41hV4e5F6tNKHOMltARod?=
 =?us-ascii?Q?1hrCHUCNxp4dAOvLSuteBjCLzPQvTGtWE4x7uw1OerE13QX1MaX4OgDzN1fQ?=
 =?us-ascii?Q?W16S0j0RVRDeoaMj0bxFjCbHjmOPWIj3wJSJmfuA84eV2EvfcJx6MMASElZ6?=
 =?us-ascii?Q?Eukj1vLc6IPanTtiYm3ZJKUetfoYTGGpR99Y6zrZMTBDR3GBwXlOvbLoLjwe?=
 =?us-ascii?Q?xEXsTHtgqkMY2BLsmzk8fVQKzrc4CbqDFtu1L47FCiSXcKnbeN1X0RaWZUHR?=
 =?us-ascii?Q?xNekf4B2onxZzeVZ7Pvzw627jAvKrh/JS0KYLMQdOJgM7YObsD+3UQNF8ym8?=
 =?us-ascii?Q?HCJ3nVgY0HTJQvAoxRENrDE8W/A/4xIgyDe5mXXd3ZHcdYvMyAvkC84yfSCC?=
 =?us-ascii?Q?71hpJLxkhJvcQIrRNCq2VGla76DGCmlg5pjWldVR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd215b8-679c-4192-2919-08dd94264b99
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:03:55.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zE/9AG5APJjBoMFonJue5t5Vsjai+PayHwgcRTqDcQthq9ZGpFVSjlwUDyv3vvkjj+yq9rEVVZ21Kpm7wvDJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6159

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search and insert
code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/defrag.c | 51 ++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 1831618579cb..f334e703c702 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -60,6 +60,16 @@ static int compare_inode_defrag(const struct inode_defrag *defrag1,
 		return 0;
 }
 
+static int inode_defrag_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct inode_defrag *new_defrag =
+		rb_entry(new, struct inode_defrag, rb_node);
+	const struct inode_defrag *exist_defrag =
+		rb_entry(exist, struct inode_defrag, rb_node);
+
+	return compare_inode_defrag(new_defrag, exist_defrag);
+}
+
 /*
  * Insert a record for an inode into the defrag tree.  The lock must be held
  * already.
@@ -71,37 +81,24 @@ static int btrfs_insert_inode_defrag(struct btrfs_inode *inode,
 				     struct inode_defrag *defrag)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct inode_defrag *entry;
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	int ret;
+	struct rb_node *node;
 
-	p = &fs_info->defrag_inodes.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct inode_defrag, rb_node);
+	node = rb_find_add(&defrag->rb_node, &fs_info->defrag_inodes, inode_defrag_cmp);
+	if (node) {
+		struct inode_defrag *entry;
 
-		ret = compare_inode_defrag(defrag, entry);
-		if (ret < 0)
-			p = &parent->rb_left;
-		else if (ret > 0)
-			p = &parent->rb_right;
-		else {
-			/*
-			 * If we're reinserting an entry for an old defrag run,
-			 * make sure to lower the transid of our existing
-			 * record.
-			 */
-			if (defrag->transid < entry->transid)
-				entry->transid = defrag->transid;
-			entry->extent_thresh = min(defrag->extent_thresh,
-						   entry->extent_thresh);
-			return -EEXIST;
-		}
+		entry = rb_entry(node, struct inode_defrag, rb_node);
+		/*
+		 * If we're reinserting an entry for an old defrag run, make
+		 * sure to lower the transid of our existing record.
+		 */
+		if (defrag->transid < entry->transid)
+			entry->transid = defrag->transid;
+		entry->extent_thresh = min(defrag->extent_thresh,
+					   entry->extent_thresh);
+		return -EEXIST;
 	}
 	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
-	rb_link_node(&defrag->rb_node, parent, p);
-	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
 	return 0;
 }
 
-- 
2.39.0


