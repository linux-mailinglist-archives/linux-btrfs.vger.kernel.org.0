Return-Path: <linux-btrfs+bounces-13211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09173A9602A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C947AB007
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4F2566EC;
	Tue, 22 Apr 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jKZyvBtq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF522E403;
	Tue, 22 Apr 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308543; cv=fail; b=Bgs/bzIv7NcqNd8w5wFsHZSZ2lS/ThcFw6Tf0Irr1lRDFnqYh/B3cWPadWSHdJu75C2ZkfiHEmat8LY3hkG8+z6G/tZkz57w+mb78vyvp6HQReZVWDbkBBAxV4flDpEWGtJalVRxgIFhuoQmhcex69DV3i9kzoFBDD3e5M4L2dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308543; c=relaxed/simple;
	bh=PDYcZnwhLTl8Iafr2eZH3MlXE17V2nDxaKJpQHQ/Uc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRP1rbwGnkRLKRSi1QEMD3AUj9HTws8Bk/n1Z11gnfJysHYYc/78+XYRWhxC0SYHWAPSY7eBOMXEP6D9ERLF0OKuyEVhNbF/jlU3cZr/rhaxq4C1l+TIuG74X6X3xNT83axMr5BIphhgoFgmymUBwN+5N8BU7iizNE7uAZRhRaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jKZyvBtq; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEywb1S9cv0UhlHcwzJ8WjSmMFsy2KdNpIsn5KkBHn0G79k3NTivZSiwud1FkVeLilF7YjwO/ojBnr9sf8I2RH57bFdPEDo8YogrxbRJepLX0+WRE5sIoCO8YmUAoxSaHFkQGwGMLnKJb2Gy1PsbALLiVB5dSe6lkI2wt4NQ0b26+5Jlw3gCRoKwGeeiis1YAkNFq96VCfcz1RxJrYS+oKvZnl/P6yEBWTq/WsJV0TQdcHqFjlAcm/1BACB02pZrCWpeSq3ie902I04D4Wo4yrRYrNe29O6/pO/MG0qjPrNFZjx13OuTHYndXasqrLADyPR7jsjuc7r7ZTXYgdnWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIZtB7rlX1M9S+Ykm0xGC2y6P+fzRd7I+VPS46SyOWE=;
 b=xBTbTayuovInzgFXL7wZs9LDU+FuVcJLAGBqOIYaqORYaHwiSJJ1lWa6XwnK3cenlGPLMx4/8myu2a9d6pFiPpKzX03AYNj2IWxRhB06yXwhq9Rw1g6vruq2kstY0eH2fPncd/DUkOnkQrTjQTMtX/YKgOIk3btXWZ4EoEkrIqm2Osf+8roAxmlfwZUc4CecVzNzk0xnb8NzCrJshfirpZ+ga07TYzLLeIvx46S1ZzAm4PLINMX55F3V6H0rs/TPB+PdUalk6hlMG0oU53rfzuyq1/YFL3LTJ8LEafFwWljDaZ6bhF2hkoTLtfwwp7YInTp6amq2tuCn90b6a+nC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIZtB7rlX1M9S+Ykm0xGC2y6P+fzRd7I+VPS46SyOWE=;
 b=jKZyvBtq9xxpn+4aAFJtoAIT84PjaRJIG3AKAIQ050WOMrpUMzuYZew+OHazAUugdOzwhstflXNiBbMQbcaJcbHMPHJcTnrDbPR0PocONmMgQVkgX5GzZG5b4YjI2RWINbDqrN+2NWPkyUhF7Icx68GChMepNYYWC2UKxGCqbY4OO9KfKaaKF4YMrxc0ej8v/1cmQGEb6phUIVI36V3QGKWedhxqQILHCxOTHaJuEt7JGDEXIPZ23pLJfSwTYQ6iQcnZwe5sFMS1CWZKrf2AC1JEcOYNAqTNe5+5FPo5kSmssASUHDGKV1lIIjwBpAo3YaRkoBK+bWTFyU+8S4Ryfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:34 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 09/13] btrfs: update insert_ref_entry to to use rb helper
Date: Tue, 22 Apr 2025 02:15:00 -0600
Message-Id: <20250422081504.1998809-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ec41905-47d3-4b11-af23-08dd81730f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFAtI/BuvPP8v6fwAGfMGL0Rd9MCzIMaHF8hL838bwIDq59jh5ZwIEcrbs2M?=
 =?us-ascii?Q?RfWJxvGVwDjaLfi/azuJybYsTfjuVZrJOWAyMHyhdO/wz7URaLavA+Q5i5qv?=
 =?us-ascii?Q?zAXOTTzO2a65HjHw0eG2QogdxqI3Oa36hI0+RnbTa6cGfv+wuDQRslgfRYDy?=
 =?us-ascii?Q?S92TYJjgiac7YdWTev54vrEnZ1v4Grq4L89wX8OF2lkdGmyvfcHxX3u1uTL6?=
 =?us-ascii?Q?1lEm9WqIs+1M1kCcHXsV5vsAvM9NHZ8pXMb/pcQXA9+P8LmVePIIbTy0h5id?=
 =?us-ascii?Q?lE7925IcGgj4YuTWhLhUqjXIlSz3EwokrzScjRs8O9Fi8A1cfgf/MJ/hWT3u?=
 =?us-ascii?Q?HZXczPd6Zn5Pvm+4/uJQ4fdd1CUZZboUZ7JBxBYxphJtOSodsGiQNWQ5x7Ky?=
 =?us-ascii?Q?hOa6s4DFKaCqaFB4yjDQ/yyeHLAvq3A7T6sGU02eLLYF3EDpjwMKGBjMSU6g?=
 =?us-ascii?Q?o+IhSMTKVKA1maJ1wxj2XmoCTQcy56CmTFDPq614hauelZNQAPeVwK0DZ/K9?=
 =?us-ascii?Q?pRRYSzpbnQ9pnOXLNAlpsn7QXfTME/+FMMs/UTOu4cAMf6A3bdLTORYTWGfU?=
 =?us-ascii?Q?YnQLjCotKAqFAPcYWHgQ3vu6hnxZvD3NzImk7vyaoXUWS0+0MZo3PEZ6PVvF?=
 =?us-ascii?Q?QfZ1f7IMYkHqpRJmQ2uBz9VdRS+v4HS4NXcpccYAJf9rFhLVhia0QkZn7cUd?=
 =?us-ascii?Q?4H+eebC/bIHtb5FL/xCBQpY4IiB7Br1M22QgD7AxRnXy9gqBCq1lp6k40aeL?=
 =?us-ascii?Q?8VaH9u46Xv88kFsyEu79WcFCoyAx2oKKac+eBZICR81pHEodqpla3r70JLoq?=
 =?us-ascii?Q?8CgLaL9CNjpoqF3Ysz+OICzQKupul6FbxHK8evfV5+ZMrR+QLGdLRR5jB40f?=
 =?us-ascii?Q?KM+ki3VAiFLsCxjVQGO41Tt01IRfQvk5v2Wh7ef8NJEX6PhzqIPW3sAuv9DM?=
 =?us-ascii?Q?hIdTNs/4FjCVmfsqbycaxzMeMSjleOriAJ7mRiFPm62E0ARwDsPuVZC0x+tD?=
 =?us-ascii?Q?EFouaDDj2IbwP47j6LrfswViA7W6svuCMu0g0bteKirZ3i3syRwlxM3xZlz9?=
 =?us-ascii?Q?DOiPRmklvtW8byh5bj24R1ngDcCgTFgECXStGSWhgKhicc1ulZqdj0J/5fUR?=
 =?us-ascii?Q?OqVEj5nFfivb8ONT4bDMYZkGFugvH0u7VzuqkxuL5q4oZ9fZBt3wIRmQkCi4?=
 =?us-ascii?Q?QMeIX+JbpUL8c2J4gMWQJo/nOq2RrdWPJvfPrpkSjfpCJAFdMrEQSLdcZQB/?=
 =?us-ascii?Q?TghBIKUKFXdrlFZviN8MnP4ejZpPL1ernGbXacgJgLkAALDFRJMGfuChJps7?=
 =?us-ascii?Q?r75HJCtD0XYdbQZyUFJjUycyCqRYIyH9dMOmlW5JKL+MNJW0YZEy5BgxxzGU?=
 =?us-ascii?Q?cnJ4KkUm3stDbB9esIkbECIeDik/br9xYBPBkivsZk9VGmy59bDyl3B8gw0J?=
 =?us-ascii?Q?5aoSocr0l93vMdWUsJ9B753Ec9S007OwuFC5GD4S3JZPj8taIAq2Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIKuhsgz2Da4GGZrNBd7zr8McFvFuf4Nyf+hGAG2zBPhjcFo0QbmHile68Rc?=
 =?us-ascii?Q?uF1xOy9viBu0FJUMhZbqfna4/32iysV90pPt1LSFdgMY1L4lZ1DTJiY54UIz?=
 =?us-ascii?Q?oRg+onGz1CXYWcIE8/9ePKvPTT2bJFQ2HFXm2bufVU/xVSXiGyv85NreKMhe?=
 =?us-ascii?Q?vY72be3nxOEKFNBQVXxJ2r78ssl6Q4glcWWS7PrQAH115NQrc7QxBMcsTvbC?=
 =?us-ascii?Q?2bhDdG2+CXvBadb5lGBml36H2fa23kcCa/1t4HfC/K4C3GM3am/AKDH0WAfx?=
 =?us-ascii?Q?6krFQZ8TWdxUtooq/KtYdAe7V+QcBopgy9WhdTRhYrYoPS9KtzU9Tu4lzS+l?=
 =?us-ascii?Q?AYtaAMlhbpSg5nboEC5nFTA9RKtka4gMVhYbfqq4x5C6vdtlYvubNBXoOnL/?=
 =?us-ascii?Q?qBl336brKUZBCzcGRqULC3n11k8FOFKEbGvn/09teqpuZu7ZOyxBPYGc55NI?=
 =?us-ascii?Q?V/9BS1z2sZRpvaQ8Tfgh3dcqWwI73/8Dfa0+WOeKWhCUizh0LYObh4HX28eJ?=
 =?us-ascii?Q?CEEesd/w8IFAZe1QCZix1hI0TV6JelsECzJR8HGtsT32pAih5AsExvcWR+uF?=
 =?us-ascii?Q?uA8HGeZTZeJhJrsewAhm3VCGURDgz1z5qqcsg2X4HW9sCI8v3GqnreUujo+r?=
 =?us-ascii?Q?hiHS0vZ5sBXxCUCf1zNotMfFsYWqiKLxKOBt7cRKyEWzZk9OC5nQLFUuHD7G?=
 =?us-ascii?Q?V1oN3q2S4yZmBqga6RmNo8SSIypnvjpg9kkurRGk6lZBgQAX+/fSidtvrhyA?=
 =?us-ascii?Q?snF6ire3Z3tRm8oYXugwbkWCLf5U82ffhKMrf8TrSR/GTqoQu9W3jCBA7bvZ?=
 =?us-ascii?Q?IjVDQfjKjQ0wasPcZkwctgV4+LAKbvh24EshAUVg1XM5kTVZR5X3kznq3rpn?=
 =?us-ascii?Q?NogmDvl/fsw9nbfvgUkuQU/FFk1SRneJg49MuR5W3WTSNJZctkYMds+i4B9+?=
 =?us-ascii?Q?ScUL/HMiYoJnT+lW3wJ+WzUUwVnmYogAyURwmPYkCWbvl5fDVeZ0Am603hiO?=
 =?us-ascii?Q?Vg/rJ3S7c5LhUZT7tVbW9wZXoJ/1/ud6AAH7bEUgio+UUPOhwruBjT676mRA?=
 =?us-ascii?Q?RrN5sd5hwhHZ7kGYrwjVZUoDXUVnyrCc1R6kTByI1AOA8fm6NrfC1Bg+0DTD?=
 =?us-ascii?Q?eLFzg/lPa4zO8eQT1M9uz9d0tmI7NHhTOhNHZUh3bZNLfMkmjB6HtFXx1yAB?=
 =?us-ascii?Q?uxTMFO1WUA6aaKzyitTkKoRJvZNdJYNRaQpwzJw21p3Tz01jERCayB4sfN5z?=
 =?us-ascii?Q?V3QYCHw0hGiV8uOhp/774pwMR987FkPKbEx+9SsI2a8DFP41dG9clRcrF0bc?=
 =?us-ascii?Q?FGflKey5QlWkHd/KLIR681fgbLcrNLofQsE+Ln3aPhNeKUlhEFaQELFrfi9O?=
 =?us-ascii?Q?Gd3RdMC1udlKj2XGgcFv3NexqOgTI0HxAHq2sR4Bk6TfQBtou766YqcRQ1MB?=
 =?us-ascii?Q?HsxSXU4NFhB8jJ/0NSi9hEhwzkIuAP9YYV5LwjShwb2zI+hh0pqei/inW6rv?=
 =?us-ascii?Q?fUYb4TSG/cVbBspXUBFURwAw3Gr1B/GkMMzhGqlKc3KDC0iNgv8vRkEn+xHt?=
 =?us-ascii?Q?EhKN55Tum22ALQTEgE21/sGQAFMkZy2ENWqSF3OF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec41905-47d3-4b11-af23-08dd81730f82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:34.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ0fw4CDWPZVRNdC0w8dZp0RIwpK6OZSTsfvST7rA3rj0k7o3gpc9rIWbYy1wmftuoYcOIqMPx8SShshEAlcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update insert_ref_entry() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ref-verify.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 140b036b5c80..1de15586ecc2 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -165,30 +165,21 @@ static int comp_refs(struct ref_entry *ref1, struct ref_entry *ref2)
 	return 0;
 }
 
+static int ref_entry_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct ref_entry *new_entry = rb_entry(new, struct ref_entry, node);
+	struct ref_entry *exist_entry = rb_entry(exist, struct ref_entry, node);
+
+	return comp_refs(new_entry, exist_entry);
+}
+
 static struct ref_entry *insert_ref_entry(struct rb_root *root,
 					  struct ref_entry *ref)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent_node = NULL;
-	struct ref_entry *entry;
-	int cmp;
-
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct ref_entry, node);
-		cmp = comp_refs(entry, ref);
-		if (cmp > 0)
-			p = &(*p)->rb_left;
-		else if (cmp < 0)
-			p = &(*p)->rb_right;
-		else
-			return entry;
-	}
-
-	rb_link_node(&ref->node, parent_node, p);
-	rb_insert_color(&ref->node, root);
-	return NULL;
+	struct rb_node *exist;
 
+	exist = rb_find_add(&ref->node, root, ref_entry_cmp);
+	return rb_entry_safe(exist, struct ref_entry, node);
 }
 
 static struct root_entry *lookup_root_entry(struct rb_root *root, u64 objectid)
-- 
2.39.0


