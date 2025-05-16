Return-Path: <linux-btrfs+bounces-14073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7BAB9458
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6029A7A5938
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A0289348;
	Fri, 16 May 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QCvaqr9f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF4288C86;
	Fri, 16 May 2025 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364666; cv=fail; b=uH71AoAJqKiuHfAUprpZBUJyacL+ht7QbQez92c0PtmG81b2vrtXPH34SGt2CJLwUXV/cIqmJoW+RiZNDiEFc3M12p6NjWZNoAY9dq/E8y/h1oDaBjMFsTbFcaRSou7CEWppGo0b4BRMF/A9hsf13tN3bt08wVKJwn9RMiQWE0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364666; c=relaxed/simple;
	bh=tm1wN8X6fNumwoFTPeARj7r85Z56m8gH4RxJpzkU3Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pw/brQh/NqQcTYFqM9LHUKHYvsIi1NKhugenHucQMBn4qGf11rzdM85citcEBNhf3R619sbPLk53GXBwmW+fNEyxKb2KW7k8fg0JxZwnzNNtdoQQe85LeQgnRG1Uz6Abuwm9oSoqIKsPI1mkaK1obKcy2JhCQzJRlL5qcsnX0oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QCvaqr9f; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzQt4VEWr9iGKFzmjF0MTlTPzYsdI7KC+HKbbueJqCF1BeQ7GDPP11a+mZGw5MjpVcWbv24vXlqISg2WiJzOpehb97Bhi7NENXDjIPA5+6B05VSy24x5aXTFrUYS/M7J7b9/r7ORUXdjaQiO2tX6bj5Re3SWvwqF5x7fByj+T7MplFH8nTrMjIDDocIuu4IR+KwOIEJzM532/RA53IkZXRTw7tedtzDFafgeceRgSxcn/7f5wvphG+SgtUGEwU1Ypy3bz+/Y5MEm0P5vpzyxSWiv3jcAebx7LG0G+2/hAm5HyhaT8p2iNpoYdkJdOtAXoNwhLCdDQNNq1jOZkvcAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBNvz/LoyD06VjGjngA31ALX87U4Ww564RdVHPqDe+c=;
 b=wUxb1LZmzGjShtzAapH5WeFUsSqodtsUgD0tcBjL1zRvSbm4TU0f/h79BCOSBAFufT6Naw0ogI1CHEE1/uj1RIJHc0Tqf6+TP8HtT2TdsiCheIKbiXDLO0V4ibHpqmrvYULpkFPUiKRyK0gLd/+4Zu5W4Tq5bsubliDkY9e+VMLG/RQmCP6z6gEyzfyZjUZxrouMEixR4F0TOANmPlWSJOFj8bOdfjzX5s+fanNAdkuzDL/BetLbc3u1LiV8HkhWFAFSNO2YJPZiBzXAhAcwp03TdMEqffz3yF7jeDyQUaeWiotylvBxmsbvq8GNLucBSJzvpf0hhGjfZaeSCcRt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBNvz/LoyD06VjGjngA31ALX87U4Ww564RdVHPqDe+c=;
 b=QCvaqr9flf8ERT8h5YS8dem/iPzt08Qzzxctcmz35jxTt/9L6d9IgnUUOB7W5cfqjoe7UwqOVpRxReoVHkNxZjGEjHWUs1SA8xwDmG8fV2KAJvfT9Sf+bXoXRRNbapRCPY9BgJVDrG8tzLCo2i+WbncpzCaoGY5f13b+gkEtFwiESgxsogDK7jn6Dt2syx3wx0jyy+uy1lyZV0iv6nq8iZ/7EomFnEVwk74EPays3vzffBHutInYlX9c/F6UxUeF5+0SZ+HStJMYPCLti/PqKwKuXn/z/qtZgTlWXDrOpxzVpnwkEB0/62N6oa9q3NgM4Y6dDb38PlK6b4KH1KzRdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:20 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:20 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 15/15] btrfs: use rb_find_add() in rb_simple_insert()
Date: Fri, 16 May 2025 11:03:33 +0800
Message-Id: <20250516030333.3758-16-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d7a4929-355d-49ee-5dbf-08dd94265a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M4qxm44m0+jm8zRGKGhX38lzzxF4+RDxQUpZNN1b3f+PevORsZc3Ur/SaLnK?=
 =?us-ascii?Q?lvBJrVc50+CmUR3KWNgJR/SqpoFXX9HjUTD03zbfsdv7Hwz4nZo2GSATzqp2?=
 =?us-ascii?Q?TU81t9BR35mSmkKuQxC3PYs1EmNfPVzifTwEda55p4QMLknYLR0Tyw5xoAV9?=
 =?us-ascii?Q?uDt93+MmDV1c8FgvWxY7Oq8i7j4T8UL/4/OxMNt7brEJPxSvvs4FVkU5WPYp?=
 =?us-ascii?Q?Bh0VdXVqdHzA99l1ufB25YZ5uTA2j0q1IN6vi7SvOZBGDS8MST9uULk6e/Oi?=
 =?us-ascii?Q?8ZgrY0XQODToCZIt1au5JOxuKACNsYhRAwnIqWJTjx6ol+hrfHNt9F+I6oqS?=
 =?us-ascii?Q?qzrPxhiPhxHgxAFX4Fujaz++NnhdFvWOBc7b6Pih7Qa6gt2swXooqKXKZCSd?=
 =?us-ascii?Q?vDLHBWD40Bf3EoAnsgyftAn8obXvGtHdeHRdknCLHo13N5QmWkkGynYrwEAr?=
 =?us-ascii?Q?E32fWBZ8y5lC4+zfOWUzTepPXPmjQFrPfsQKCmut6Az88lnFk7vEnInQXXXy?=
 =?us-ascii?Q?LovPpLasBcCKRq7O0SzwKhlISpyU5f60eGiBqxwJy1UebPhkuIstOe8/OBGe?=
 =?us-ascii?Q?isFbdc7RXSbzWhY7bxJ1dECsaX05mHMQRmR8VaTAMxVwlcsJfsRMiCbxR0mT?=
 =?us-ascii?Q?CIVic8JX5t/UATMIqAgOjZ+X7M6ATeu+1IfKsOW03jkjZzyvI+0lSP0APQbG?=
 =?us-ascii?Q?jt20FKuBs0pyd8WTngJM2tk/YvGCZvpicHGwboZmknyfmv+aT0Ezq0wljxc/?=
 =?us-ascii?Q?CXiiDOQ1AnJhuuVYxy44FBb8iaTdX96XrfMHiGFDU8yRdwIKPjmDB5K3zxSM?=
 =?us-ascii?Q?Y82w8hj8E67NXPOfmLWaSMHnp5nigbC3BJhvE/gv4KVylzxB0dodRhrKaRJ3?=
 =?us-ascii?Q?ifnFo4bzYpNeyooMB99wJ7XgYzD8b2ggCzpcdtwG6alP7oGDg0JHmgmVyheK?=
 =?us-ascii?Q?uQiis95hDW8ykc1OjaQUbx6DMNSpj07SH52SbCmDKZucl57A7lKoe5evhgqx?=
 =?us-ascii?Q?U1a3sAJiT4EdKy9dwXW0MbDeqjCAPstGrCislcSkWF54ztCeZC734otC4kM5?=
 =?us-ascii?Q?PWCGz/Ab6FNloEl7QS7nbipiEP+pkGJEslisWGSqrqNVVy59wIbHq6lqtjEN?=
 =?us-ascii?Q?ex/MGXALDC566CKXbz3zHJfgsBkDfcTragDs1MZ1qEhbbW/DS9V8JkLJh8zB?=
 =?us-ascii?Q?WIQmn/XZy18/ttPmgVWdnV5Nu/uTsdZwy7oRFSpwDaQhjoD9uMHeB0u4KYjl?=
 =?us-ascii?Q?YJXCJFk2jbVsK4nlzT0+mPu2gdlFokMVeCTb/kqcourGor8TvIZUzDkzQbhV?=
 =?us-ascii?Q?s+zMXI1dyxYaMT1ypYCUh8QfpsGmRLJPnx3FqZHBk7gsPjLq11/OYgz+rkpL?=
 =?us-ascii?Q?2q2Ve/P1+6R40fLXAJfnWb+dIFRzfJqbibwz8sXOJMG8o5K9x+RDwI7hmd/g?=
 =?us-ascii?Q?4UjkPoNdJy1G3x4tI1OD0vPU7wzvAlyX6waNbMhSuo+ERwl6EkJv3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJ7DZSg5i6pGICESUJfnVVVdeLWTxjGw3MQvkKkeu8R+vOJ40JYb1GhMN7QJ?=
 =?us-ascii?Q?unPJRTgVg1E/1VHFmBaHBTsmCY/wVaz9sfII7fTBeoNoeMC+qfhFc+bvtLmY?=
 =?us-ascii?Q?CwdQGB8SVcSeVLoVNzHL8ko2ZwDJpKTMAoHsSJ6G20hyPI4qE+uNt4JtKKn3?=
 =?us-ascii?Q?fdyalrBaHkDzOC//Ua5vtzsGEDNKWNhFwuXq1FcnGBuTLu363CwBa2fZ56wn?=
 =?us-ascii?Q?QopWwsk7HqkHiunWPc19Uawxq0/8WTuHbutM8yHFFS/4RxF4WQ7pzaFCB1nl?=
 =?us-ascii?Q?gEWv42yQ8Fnsua6h5PDwSmGzmxfvlNN/QsiTYFfsHUEAKG6pGuR5De124N0R?=
 =?us-ascii?Q?IBFJLHPioJ0yBC5wXDZrfzEAYAXeXQycJIFJAf0GJ+jUSeEDTr1nbGAe3uZb?=
 =?us-ascii?Q?89ZeOCXbfIqIbvatrnDDphglCSEmbPpBUTh0B2IDhhhxQkcDPY4ymxgWeBxB?=
 =?us-ascii?Q?aBUHh4o/il8EqKd9wklukhRaJ8FGSwEBHDHm2FRADPYcIZ4BOm/jmeQ/TDso?=
 =?us-ascii?Q?3n4BDscrGJrRn2tHoBjJ81NBPMeun30WQzBtBmJ9+JVn4fqmvqnb6gsOkH/D?=
 =?us-ascii?Q?E0IDalQqligyJZulmlvZFWJnl9oUF7ORZohZ6b2mHT+6XwUhFjYmchANiTmk?=
 =?us-ascii?Q?uyhfDhH8jAbGSlFBoDEMOH0LxDBS+/Q6wkbt54NgxOKUEI0xvoi+8bzgNUiI?=
 =?us-ascii?Q?4pNmSVpwUlpHq/X8fQ/X1hJJWBXEwLOX+ezd92mOqeRcJmZf/B9S92e1d0J5?=
 =?us-ascii?Q?e6pnhg+Qaj05wrv2wwlia3XSAS1mKtDG+g/W3wafDdFJ6+RnJFxjTehudpJa?=
 =?us-ascii?Q?2ueRKgbTY8PWiWzZxsjOv/EJYjaUStp9ZVweKbDldZUio5z43O9UA2NTyU4R?=
 =?us-ascii?Q?pmzL7wH/HEfmH/H3odm1Xe44jrVssi7+wozhFUmX/1U0AB2WBaSEzGofdbqi?=
 =?us-ascii?Q?dbDFfgMdtJAdbmM/Oa0BnwaspjzLkC/ISNyEuuatbX0KF0kTypsmiXXDCzHc?=
 =?us-ascii?Q?ZgZBNpd6MaNSKKrNEGnc8QDw4xwBTEGX7Y5rSSmTQumIjhrVNId6g5yhDm61?=
 =?us-ascii?Q?y6IBy4JuL/M7xpALpAsBks/eFszrwSV0up16uDeMl/xFF9Jff+5dHgIuDdeJ?=
 =?us-ascii?Q?AhtWEZY9mY98ELNbMI6fhdkY94Ol3aCoK8Js2zXWNw5xakWl/t1bsBW/rL/Z?=
 =?us-ascii?Q?d46nQbrX6AovXbbA+l+zQiP7+PCVU0goo8wcD/e3+T/VrqDHr81N5nY3VQnK?=
 =?us-ascii?Q?QoOs0qqygJ43bh8Qw6uo6SgyPssRFPxglR2OwTEWB9YGWER8Gi3ZPgpvbIzT?=
 =?us-ascii?Q?0aQK7LHX+IEygwyjoijLgpOQAh0kTzo2pqLCQBGTXS0sv5+U7GkDFVHM1/hY?=
 =?us-ascii?Q?/ylQ1ueCjRUwfOCEYxBeb/0174jL5CoqkncQoD14y4akZ6fPOwSpiBsm2PB7?=
 =?us-ascii?Q?6Gv7Sm8QpqzUukwjxoQUjUI3WRBMVPqczyVES6Q13vagmePfKaWEK2o9XSWE?=
 =?us-ascii?Q?i0ziTCLjdeMNGvrgaDk6IdFQlVnjJCDnx7/JyTDGIdFNPz60LvnEVVIJc8Tk?=
 =?us-ascii?Q?FpvI5yJtLIKXxjCTjjFNXqGFntaQ21Wy7ZPLy5A+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7a4929-355d-49ee-5dbf-08dd94265a7e
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:20.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bndZO96a2aI/Ecb8y85vwuJl6GRj0TW8BZZQxNEZOw1JKk+kVXYSsfZ++DaaNr7VSk5t9tU9miUf/yj1lw+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

Use the rb-tree helper so we don't open code the search and insert
code.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 fs/btrfs/misc.h | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index e28bca1b3de5..45fd64b18adf 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -119,28 +119,27 @@ static inline struct rb_node *rb_simple_search_first(const struct rb_root *root,
 	return ret;
 }
 
-static inline struct rb_node *rb_simple_insert(struct rb_root *root,
-					       struct rb_simple_node *simple_node)
+static int rb_simple_node_bytenr_cmp(struct rb_node *new,
+		const struct rb_node *exist)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct rb_simple_node *entry;
+	struct rb_simple_node *new_entry = rb_entry(new,
+			struct rb_simple_node, rb_node);
+	struct rb_simple_node *exist_entry = rb_entry(exist,
+			struct rb_simple_node, rb_node);
 
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct rb_simple_node, rb_node);
+	if (new_entry->bytenr < exist_entry->bytenr)
+		return -1;
+	else if (new_entry->bytenr > exist_entry->bytenr)
+		return 1;
 
-		if (simple_node->bytenr < entry->bytenr)
-			p = &(*p)->rb_left;
-		else if (simple_node->bytenr > entry->bytenr)
-			p = &(*p)->rb_right;
-		else
-			return parent;
-	}
+	return 0;
+}
 
-	rb_link_node(&simple_node->rb_node, parent, p);
-	rb_insert_color(&simple_node->rb_node, root);
-	return NULL;
+static inline struct rb_node *rb_simple_insert(struct rb_root *root,
+					       struct rb_simple_node *simple_node)
+{
+	return rb_find_add(&simple_node->rb_node, root,
+			rb_simple_node_bytenr_cmp);
 }
 
 static inline bool bitmap_test_range_all_set(const unsigned long *addr,
-- 
2.39.0


