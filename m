Return-Path: <linux-btrfs+bounces-14065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E70AB9448
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385A61BA5B68
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3A25DB1D;
	Fri, 16 May 2025 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Dd6ONohm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52522F75A;
	Fri, 16 May 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364650; cv=fail; b=FkABvy1mgwpCJkSocPRtX/KdRwumGZ9/cRB5K1KwjfB0s5vLfuIi8nblsfQw8g67zErCa2lWdcDqIO+VnDEMq6vQ8MNVEXS21IUawhLP0ULGdZr6zcSPcbPcuzRlGpgr8offu8pOsEKMoFCt1RM6VA77FDLd9v90BlMoj2diAXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364650; c=relaxed/simple;
	bh=FoJ+IM6JkgXuS6E1bMIbr6p4+MvBVrLiXT2Qt/tGVZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXMWGQRLrtVEZiFB8m0pcOG4DSqza73620MURL9KeYjPqiqVrI7OV11Yc03dgvPCTgpd8q+K62PR+raG733UF9G6n3a+XN32p/DvyUK1Y12P7TrNwsLWQNlCefEoffWgXlOSWUGfdXACO5nz9uLZhy+jVuXmvjMI8+Xo3wC9Gnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Dd6ONohm; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKFReyyotlbS8M+i4NPl2sURTmXYAp0bkMEF3XHXPItVacL9jjHrdxC4Bm0JapJyHTL/m4eg2ry2CjbkQQlwYteESc8Ija+qQZEhI207n9xQ6sfFt9YNi+teo1HZq5t+F/61Kke9lQIlWRLiAaUQRz724k9+VeWlF/rU6JZ5z7LBCzMsEqdEDVpZi9eU2A6FsG231Oa8tIiZWMIIE17q4z9a4PEgn45FNzu6Yih11osxMfB9TJUYYxCiXNh8du3xtiV29lIHD5AbDbtCA3GoOmAGZli8MKHzB/RW/+Dk6r3XxoPFKBY+Hs0NxN+/D9lDIXAEdfxZSTAzRN+19Vh1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj6/eXJ52H97KEb8YrMjnEXOYnzlj9Me45U35Y8Vj7s=;
 b=p4zUQSRwzujM/BeBzraqQtd2L66SlNMj02rfpAC/0V2SvkKf1vpmUFY4IGZ6FxjqlqnKLkZ9wqAUPnCJgc+jPW6gGIYLntRyCjke1/pi5ZXe4Ka0sJOxyZPCLYsK4eyfixdGksk7GAy7jxGeWubv4IOnKV+WxKOqpBKF92z83NZTdcQ9Htvuh7tQ38ADV4hg8V5XZdl4Ozcl707klhcVGEUp9944pwbzPEbVKvJrt8yWlVF63DgkxwNWMuyYwI4gqHqXvumY6Ba7LsN+AMZkIQZWMJh8ygnJE8W85HXcIHBikKlOkjgIMPPXJsUKnCpYZf4/kKTRu0v0Kmg5Zvj1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj6/eXJ52H97KEb8YrMjnEXOYnzlj9Me45U35Y8Vj7s=;
 b=Dd6ONohmV5+X6J9mq9XyHPkdmtptFfyph1tJbTHg62bS3/6pdAkkX5PSpItNjzzTNxxLclfaJtQrwbAotCC9DZFNyS+obZtI//JyphWWIoHCc/K+qckQImTED7a26dI/16xj7aBwT80zj9pI/mMTSX2F/WceS5qKM2kC97j7xJDB/FIFdbfetVIAiwjksGsdlEjdD85103qmynV4Xs/SmTvsjs9X8PUwdeN4RBJ1MuLOtxItedrNaAz9YahoV4UQ8yvUimIcfOGvioUraJPckjX4RphiK2VTP512eKmpz1ie45b+u5fqBxFxb9v75bJvxbuVC1CV7G+GMcevjQBPGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:06 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:06 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 07/15] btrfs: use rb_find() in lookup_root_entry()
Date: Fri, 16 May 2025 11:03:25 +0800
Message-Id: <20250516030333.3758-8-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10d9502e-7d1f-4cc2-7d5b-08dd942651e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjzZKfhwfl1JzQAMOHIXsM/Uo/pI1u/2w6zEo9X29vbDQNcj0/TTj35pfxZK?=
 =?us-ascii?Q?S7R9gp5xvlOVA3FVhvN9hNIp4/DQY62Qo40fe2NxXaUsvUNFEHEgeWh7C/B+?=
 =?us-ascii?Q?YJheSGBYbzaKi2AxvHL8sGrLlt/ILSQZIF2HqLAyzA2uBs1sf43VVMt78Uk/?=
 =?us-ascii?Q?LToUs7wR1N+/TF0xB+SXvz/04rh9vqA6ZCckD76uYU54N+lJpnH1gT9t2mm8?=
 =?us-ascii?Q?0lQ+mEyoKs8s27dU7ZNXT5ocEtwQB4njPWpEKtHgUj/sUlmBpC1aKH4Q3TM4?=
 =?us-ascii?Q?F45v1MaYZs6CDBl0pudmPQEVnLXm0tx0L9zYGKasqQ3BUFFhU+jFcGg8MxO9?=
 =?us-ascii?Q?V9x8PL+3HBkp+tw1+BLqS3L38BSCxx4Wg2GAm3i6gyQfnzaWz0TzYkgqASj/?=
 =?us-ascii?Q?oinjuCLAmE3v1ucqWUujUrpXEdRu36hERkXqRdadChV66RY7Hn0FkSrU84A/?=
 =?us-ascii?Q?N8i/PSuacsHQtqcREgtHpJMvdJadTuPvWljuZrYN8dNgdsStOQBI5XRkVESA?=
 =?us-ascii?Q?pWpjUfoSm3wCPnCQswNH9jDNXxDhv29MhEuWeyZ1EkuvOX23v5qhhvATjgT7?=
 =?us-ascii?Q?de8tPaBJQvUoiFGpFOOsas5uMS0BXnC68FhhfxuSSKn6HB1hk59YF2hi5Cjz?=
 =?us-ascii?Q?yfkpy5RLiadNv4TsaVVZgku13ctqqWB3tN9AT4gBOx9uRN1y2UUE+dPDBG3W?=
 =?us-ascii?Q?IV07TUcAH7D5Lwx2p2YnserorIryKxutlWU20ATJTneF3ChOHw+nfTpg0siX?=
 =?us-ascii?Q?VD869pmneGUaSJV9G6GEARPOo/FC8czbF0sEjgLjblJc1wPZ5q30Y6w6y3c8?=
 =?us-ascii?Q?Ij0VtQssjAxmKcYlDlrXlZ6Erjrw7mKwp43ypoE1DXWc3fbTtbXFVKHNjPVf?=
 =?us-ascii?Q?c6hRwhAuJl5I6r8e3mIQjUFE0pE1ffMmioAd3TazoQwIEfyuL1nWcNf87qGs?=
 =?us-ascii?Q?JvEVG4sulLL+p69/xR9IdmExQpGQ9QjnD6b8EDINrWkpmyD8cvp5Wr62Sc5H?=
 =?us-ascii?Q?t6O5jtC6yADV4urmyT7BWAWDLTKZdgIOxKOH64ZIDSVAHmOJOFwPrIi9kJGp?=
 =?us-ascii?Q?pe+2dBnIg/KzkNmooEHLuebtV05EZ850qPBEs7ilBGGDQGNg5maVoaQsb49o?=
 =?us-ascii?Q?V9TTIsZCc+i6WLIbFIu0T8Kx+xvuAipvfnUMontFUxqoQCkhEMf9CvUWPlVf?=
 =?us-ascii?Q?fcUAhL8sl6npUc1EK3GBjD4CdvNHZNpM6PsbSW4rDBXowQF8Sl3CFKcaqi5Z?=
 =?us-ascii?Q?GvvRX5hPXraaDWWzspGu8XxnWCQCQsg7+rPjgoYW4WfpResDfuLtMOV/D7QC?=
 =?us-ascii?Q?fo7KS9xJUFXw4cM3rjud+l8qH11hxHS6vikTWNIlZF3rBaOPAxwjrTPdnqkh?=
 =?us-ascii?Q?cZvasEtWeh1JHjMDi8vITmSkBD76YlHojRPkeYsXlScaUzhJgFdBDSa+6jLK?=
 =?us-ascii?Q?ot2+WkA3pOcj9wnERMMUvXlYCTA3g8Qav1FAoqqfxWF3bdo6d4lhiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GIeZ3IfLr+2nfkKfFfTcrUWTzQK5ZxV4aqW5dBPSzevn4iA7Ar57++UOl4N1?=
 =?us-ascii?Q?nigzCP95g+Kx1rioU+0u0y2QJ6iUXP3OBZ6cLucQocjn23RXC1eEolJFeUy3?=
 =?us-ascii?Q?FQGoDtUYbp39BBXv1fJ9dyx/9AHlQgSymsXRSivDwK1xsxca0j+muOuDXkDt?=
 =?us-ascii?Q?6fqWqMYL69uN37p8fpuwr0jPkNPoU6O1N+DVdDYNWaUovvsxcz9h97g74g6Z?=
 =?us-ascii?Q?W8obmc1eFIg5k5mPoY+28yDTS25+wzFFg05XDziinrma7xIA61cbZwCL5h66?=
 =?us-ascii?Q?nrK/bn7vkpEFRztf5xrd3eb27elm9gOF4CsAbH+UggLBNh+9W8XJ9kM0Vxoa?=
 =?us-ascii?Q?TAQSgrjRFoZEwRN+35BRAAeNJjtJ/SQvfZ/MUWfiubZve3Z+opCI/y0E/tHs?=
 =?us-ascii?Q?qtmgm6IL65Dyg50VJ9npAq6DoH13CRerW/pnwZ6BCuuceaiLsyxmY7oXhL4f?=
 =?us-ascii?Q?rC5eEuIn2FSPHjbnohOGAL5UIVZrplxBkVFdVmRKqYqOptkg5Tudax/6WdTX?=
 =?us-ascii?Q?hTM0u16MFj96h88szjng0qOUTKkeCB8uPOWmOujK3r9bOLfzYEkBsfsDhNf3?=
 =?us-ascii?Q?HnXV28odeWh9PcU/iPUAIWq1NgZTPrnYr2eMHvr8BHB8FdEQMbdAdQt/Y3rK?=
 =?us-ascii?Q?E5as7zqRBlX3e4PYyKkTeTWRD9Sg4sXU4D3mYa6fEeEaAk4L0QZTK7Vt7AdS?=
 =?us-ascii?Q?c23Kpk+uyQ8Mkhn+4iarJj5bt/Inl+8FZDXvJR2/KyyP+U2Uu3epXHGvHEYY?=
 =?us-ascii?Q?O4ZhTwxMrBafwYSjONKPY1zBWg73cIT5O7eVJiUzUwhDg9CP7MIy24+3upGo?=
 =?us-ascii?Q?tGDCJ7YuufyOGhGLly0zjCEiikcpv4QmXd9p053kDoBbeuH2tGMugrbd0llF?=
 =?us-ascii?Q?88K2JDaNsxw7/RfxOQtt6pAgp5sB1/w2OJkKcfapw6UVE5qWK74h2s0M7/5T?=
 =?us-ascii?Q?hQpVSCXFkEuQUgUFf1/gkbbrl07HqKs6+HED9eknxnRbE+o7tzv0lRbENtGA?=
 =?us-ascii?Q?UgfK0zRtXfeaS40POFW9qgD/Fit0m6F1M7ZFpOAo1AFAApfBsEvtEEMmYKRT?=
 =?us-ascii?Q?UImtpMG+JZV0MyaonIzw9m5v5t12sqQf8O15rdmEjSH4F/RdITJ7+n2J3LJg?=
 =?us-ascii?Q?9iAk9AqE69fnXpT9sjagDxpZGqdbsImiv1IaBuwERVRdl95JgsDUlytQwH2L?=
 =?us-ascii?Q?Z9d/x6Gt19q7RFV3+0xNx+vkNRxBx7RYmv5SpXi/uY8V+E6mISJxuLsyYQLE?=
 =?us-ascii?Q?ko++RkaXvAEevHS0kJvsuUF9s9iO3NKutqEHMesyLZT1ttVJabiLevxEG264?=
 =?us-ascii?Q?0ZRaBVg9AFqnI/KJht/uqyJuavTzGLz6ZiGXqe0HMVUMtcIarkohy2AJK36O?=
 =?us-ascii?Q?916JjknPTRgUvEKnVfR5+935NNQFBObvKwh9/5MozAzY2hpXsHLhxzCfdFJk?=
 =?us-ascii?Q?VqHzZv0xwGS9RL70+gT+zSd7ri2UZtyTv/7mk1MRrVf4PcevRtAiqYMq1D7m?=
 =?us-ascii?Q?m9DH9SBbivfJNAdBbVmYhDsF8p3+Ly3qsjs2fAfnC69lna9hTfoQzIsPxaOj?=
 =?us-ascii?Q?Ny48rX7kypHTQIpjuCNsNNF0puON9YKPJMLvuFyr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d9502e-7d1f-4cc2-7d5b-08dd942651e7
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:06.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYCax6Xy/ozbjHfFPW/pSbuaKQYVKzDFNet3j4Y/9YnFY3Wu9Yh3UJDUIDwpiAWIEv2SJiVUEPPuOEsCiw1LLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/ref-verify.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 49bb58ce1083..62536882e9d4 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -114,6 +114,20 @@ static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
 	return rb_entry_safe(node, struct block_entry, node);
 }
 
+static int root_entry_root_objectid_key_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *objectid = key;
+	const struct root_entry *entry =
+		rb_entry(node, struct root_entry, node);
+
+	if (entry->root_objectid < *objectid)
+		return 1;
+	else if (entry->root_objectid > *objectid)
+		return -1;
+
+	return 0;
+}
+
 static struct root_entry *insert_root_entry(struct rb_root *root,
 					    struct root_entry *re)
 {
@@ -187,20 +201,10 @@ static struct ref_entry *insert_ref_entry(struct rb_root *root,
 
 static struct root_entry *lookup_root_entry(struct rb_root *root, u64 objectid)
 {
-	struct rb_node *n;
-	struct root_entry *entry = NULL;
+	struct rb_node *node;
 
-	n = root->rb_node;
-	while (n) {
-		entry = rb_entry(n, struct root_entry, node);
-		if (entry->root_objectid < objectid)
-			n = n->rb_right;
-		else if (entry->root_objectid > objectid)
-			n = n->rb_left;
-		else
-			return entry;
-	}
-	return NULL;
+	node = rb_find(&objectid, root, root_entry_root_objectid_key_cmp);
+	return rb_entry_safe(node, struct root_entry, node);
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
2.39.0


