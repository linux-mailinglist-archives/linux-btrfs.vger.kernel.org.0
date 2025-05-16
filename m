Return-Path: <linux-btrfs+bounces-14068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5409AB9451
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2897C3AF47B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55C2798FE;
	Fri, 16 May 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="P/Sq37JY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B837270552;
	Fri, 16 May 2025 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364656; cv=fail; b=qMSr0aS3WGpcnDVe693zPc18V49n7nu9kTWZ4lSdo36yaCJqcBf1OWtmdg0ty8DXQjDTmSOl46Estf5bDmyiRCzfgs05ZFGnYHp4c0KcxEzKrjSqeaeioTmHcrbunH/juaWLOloDlukL22k16kgyo4LUdjzjGmz5HiBcbljQ2W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364656; c=relaxed/simple;
	bh=UJReI4f0Kb9O1aFjCFFA+Tw7K5DlN9g6L1vUoPkRBf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9UsXoIZaW/zTRmQFhdnqnPm91iEQ9hZjNNrxjjpDZOWylVVHovx4Rd/WIVY67ru/51om7h+ppSZYoYD5N4jcdOaANXymjFsvfUnBkD5/c66VwUesGDuuNWF1cV7UGmJXyG+Vx/rWbOG8UKHRbMFCzMQ0yruEAS9c/JOX8hj3tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=P/Sq37JY; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLxdMiBf+keIpCGs4kzAWC9wJpH5zE7/zsrMLkC/Pqf8thub9H7uNzKfT6gS4J8uARkKiL38ewqYBXxG7Vv0ir3d1f7OlLFBF3Bd/rXGsNMfdwiMvfnn7hZ0R4V3v8TZGcuGTXaFfkoSfZgAMgas22LsVszNv1O4GCKFkYEV2nixYctvVRjFQscLcn8u8LpiYk6KWkBzKMur+j88Ct7c6acl9jIGrc2GRtjxiFwgXO/EaxAGH2c9cwsTExy7BUS8qvI1wy4v7S47dWCPLNlX7J5ki4Q/shxESDG7ocRMkWXoc7vw/eMIExN5cX8v9rVrq8ZyL56HJbouHr97NU8Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk7sXuEC0+IxJiCVNnjtCxFZVepHvU5VrZWLzWLZ0Mg=;
 b=Pn2vfPO8sRwyqmEP1ANDdFZrhrc/pS/pKbmCmFjoDPWD7LX1plujDIjAUOtIpVSlyhWxLkI+QI/fTEYpTCa4Kl6WmqHE1CelfovEXRqgNLkhuaZMR/BurMsEsPYzJtmmVn/TxtURWi7VVNeKxxVllra+PHVWnVYEyAqkycBlwLT8R/iReIVG2jmFYaHcWCYKZ+ghDn9ePKkxQr/TXf99m/IrJscL4v9S0RQWXjoB3DpXt0EJyNpI8ugfyS3BdJ1y+VmL+z5+1UFPHwW3T58q5mvDlMMBdzqzh48gmQSm7p++auohk0xdsc32aSjCuKhmwcjn0+4Ne6lb7RN7Ado18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk7sXuEC0+IxJiCVNnjtCxFZVepHvU5VrZWLzWLZ0Mg=;
 b=P/Sq37JYIBhGs30M7IMixTSfa42O0X7RJwnBgVn6zCpC6O80hDDwmfo30FIRagnIeRLDd4zrkXXPZgPRnuvZmv3VkRcUN0TqKwF6HJ6qZGnZ3QFk6mzsqkQrFxAP93JFPYB6o0/Fd6swIXLH3hBoZCFo84kUeFmMuMtKOLocbWNC+0vexZaX/lUhras/8yy99Ufj3WSeM/ECcktUjKdsLkvvgBsYmcx+y0+IjnebB4vPstdT5rtb10By/mOm6WtnsFTgATv1b2RG5sGT69lmJQmgM4BtTprv6xZZTNoXx5T7SAEht1mBqX5sf2GyLWc8wcoDcGlJdE6dUOesWJdAjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:11 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:11 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 10/15] btrfs: use rb_find() in find_qgroup_rb()
Date: Fri, 16 May 2025 11:03:28 +0800
Message-Id: <20250516030333.3758-11-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1f2815f-69b3-45de-383a-08dd942654f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djk3nbm8h7QJpEr3jEAiClLiOsIttxKWqZAXCjFWgenG2QsGyRCdn4ZZuKC7?=
 =?us-ascii?Q?Z3BOYvo6s8x9QfYiv3mb6s+Z9GakBMjbCRRa8TUaYXKhoM6sDGqIIPBbuKO9?=
 =?us-ascii?Q?n8e4+pleHgOoTDHhSz2+xzd6c88Sr7cFlR5DliCoAFirTOfJFPK3vq6sWSZJ?=
 =?us-ascii?Q?kdCAqde8M8bHOUvhFJzJcmpcxZPRPk/gampn3ejVoDOg8spTbPXlfxvW9zFE?=
 =?us-ascii?Q?NOhB8aRkwGtGeE6wDSDNtYLZIZN3dcDNAcsVLWEFO0jkA7oEbv0ymrMvj+Tq?=
 =?us-ascii?Q?HO1G5uwNMREce8jo1XscEWLkAHShS4IEn2w0rV1Cx46is2zTbIOVzTZa6U8o?=
 =?us-ascii?Q?OpcT2czBB+aM5l7/m9pDmhFGzunRu9S0dUVQhXnFBkA2LtE2o4sM0B/mGMVu?=
 =?us-ascii?Q?uOW79HDXLLQmrskqpZQLlpsTsPP3SzfceU6gZgCnwqru0RtOwzgeJevBW1OH?=
 =?us-ascii?Q?nxulEJQcNprB85JA0q8ydZU4Wn96JuK10W17fcN+O02kO+JXuXVZUJ9UJcs1?=
 =?us-ascii?Q?1f6DJtIhFIl7Dv4DsjVUz06lTMXSdBUHnkTNMKvCmssqT6D08kWINa4qiktV?=
 =?us-ascii?Q?Roji2K/jErh0PPVjki/zPUyctQXabje9K3tCU8uIU5ey8I7QPD8sui2YwVlA?=
 =?us-ascii?Q?k2FJkkWHxSuBffRmyIPTM5P1W5tuiI/AJQkhNeBsBfTTGD5fz/xD+4LjO8I7?=
 =?us-ascii?Q?l1J/69/bK3770WML1Et4o8L8wM1fIkSPoNO5pFaOatWp8qLknUgp0fcIEf3c?=
 =?us-ascii?Q?xukQvCqKy27VJotNSQn/UQ8b4AHo0ppr0asfik1h3DbiwNGgvPtFjsiHm+43?=
 =?us-ascii?Q?lU8TtPP948LRI6sgrNzKN1Qb+pK9KZqUg4MXwmNoe9Z71KBCiGRl5SVpTeCA?=
 =?us-ascii?Q?QOVWagxbNu5QVBrorCOKnr1giPQcqnKI4LSMFelkYWgnpjyXI+pDmswBzBZT?=
 =?us-ascii?Q?B4cNN2Xv6jXmoxs4EPlvKN4O3j+X/M2yr+sXfcZsNEfCwa3+LmZRJNr1sz5X?=
 =?us-ascii?Q?siMFc/19kZvjAR+hcyGY8w1D4JPyGTRliD3rGKu/UpZTUyxGFBw+/aLvb3ZN?=
 =?us-ascii?Q?PaEvVmVZ4jsxKrOi8oheF1mudhYJbO1SGoRugY5ehobGG7Dy2gQN1Jra8904?=
 =?us-ascii?Q?uboNtLa8D7KaLmKH8G0HnFlDcB3TtiZFZTwGDEgcT7UFXYOAjAYKH1e6m2LA?=
 =?us-ascii?Q?JsHW5LlJxVX71C4vKII5g4g0JjtjIKayGmHuhKN7QvvQ1hbLV6XEds1gnCnL?=
 =?us-ascii?Q?GLpsfQq5ieu62MvYHR3axTf6Cxw+k94qttu8755FI5ISHHQaJ6QMbhcVCYmE?=
 =?us-ascii?Q?B/YwMr30eOCpAzKEc21jLkNoAd96lz4hRysTSdDPzH1yxYGWaBip7YrDtbGR?=
 =?us-ascii?Q?WfAwI5qfcoHKhBCdOxYAttrYJ8LKJBdR1KL9QFUKfpeEYd2McLHnP5B0LkX1?=
 =?us-ascii?Q?5avLqj0g/0ANCKC6zxAZ6yeQq+fXQTqo8JTU3lX+o2XQzACmsGz1Ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nlqWlZUaTzA66dEToWnz2jHaA0H5Z+1Y05MN3211jxn73tvS3J2dV9y5CLn?=
 =?us-ascii?Q?4hSwbtRRCWcfnVBOsvDdWWcPmPHX4GzuEsS4sVcDpwMjYQnosgQeidVjJcaK?=
 =?us-ascii?Q?S6F4hb3tOMrdhPM6VrjqrpKRssKLVaH0BQSsYtWmouNrdUwqDV7YFblzy6XI?=
 =?us-ascii?Q?yhGbuuATxAblnPbo6wSUt66BKAjOGc5UbGnz+Fl5PoOfrvHeTURbKot8sY9Z?=
 =?us-ascii?Q?WznyBMM7e+uG/U+0kUj3AQZy4R1xfXl19+2WN9LZaWIArAQhHDszagJvni5I?=
 =?us-ascii?Q?wTrsXkC6IXVeEnTvj1xRX1du18Az0g33Rr7oKCnem4VfDGeSoMjs4YtQQos7?=
 =?us-ascii?Q?vjppF1rAQD6DljsJnpi6a3simUn6Wn2+qjTDdrPvwOtyGWhlK0gy5hY74WLD?=
 =?us-ascii?Q?09kSmmuE05FzvmJ0b7pnNn/h2AwCShnm6dMpGWsw4t82tubEJgwD+pMtDuab?=
 =?us-ascii?Q?pR5AIp3b4Wapw7tVBgbACwg1hW+YzDU/ZbwFWSr0Z/8goi5zJzm7H9XWXU+4?=
 =?us-ascii?Q?r07owqMjDd1nEH/HFsav0h1ofYMkya0fh3UXrOdpbHD4479n5izNCHDXSRY7?=
 =?us-ascii?Q?TBWK286pq1AaEtFjMRuM5/47OfghtKJeAlQCntuh1uXGO+Upr/2oXm+C2JYZ?=
 =?us-ascii?Q?aXFG0h89k/71LXaFn5+gR72go1Al3blE2XlFtFtw1q0JcnG5be7Mw7Jugbif?=
 =?us-ascii?Q?02CZ7nlKaXFuzTtfuVpftUyeP/0LSS8m+/pouB9ir+rKQ3IRuA7Ja6P0lirQ?=
 =?us-ascii?Q?2dN5xGCgkGo9frqHYxzrUT1hbwR9gmOZgVAS8PzXvyUjhwOdybZRvuIArSzI?=
 =?us-ascii?Q?Xkg66ehNVm9OWlYiHfHhdcrdk1aLbJGOF+Tv3pa097N1N9A9bSgnuInuVZGr?=
 =?us-ascii?Q?PfkE7arlAjlnQB/Y5PgrpmcjgWfjuKKfTQ5Z3BKRi25Ryi/Gvy3j2P50xuFD?=
 =?us-ascii?Q?z95miu3Jsjvh+87rAcOgqldkSEPo8cnsgpVoQ22pgRG303v0le0qXyzdJt//?=
 =?us-ascii?Q?XcPsKVPsOtGTwET3NVxQy+HDmwqPo3vepWCxTw0pw6QTb261GiPz6uayoSlF?=
 =?us-ascii?Q?OVLtkkyF4KabUNcyEL0r18FSnSruFQYUW1++yoJiBgWeselPrhRrnKf5NTYf?=
 =?us-ascii?Q?WyjP2ezswS+oIUI1VALXQaohzIjxH9P8a1X/FTg0kpcd9dfA20JtAsjizE0p?=
 =?us-ascii?Q?FZ/9iGWZYKLUKrYuOnopOLinQQPl6PWj2LdJVVSN5uxtSAFAp6WdhSrUmcZy?=
 =?us-ascii?Q?pq+OphVAQCdLW83o6qXqv59RqvN3oMOu1N856pjcFirKVfm5rWii1YQU7VOp?=
 =?us-ascii?Q?Sb3Hf/YSqvrMmUIBvJf7ge2MWehqlCfJ/U060ZwiQ0QwQi0aRTEcLlLSNCCC?=
 =?us-ascii?Q?X6Jo9r6GN3rPSdAZP9wpj2/f8GDvJ+vzrVAWf/EH0AXwE4C4w0pKdzC08ZmV?=
 =?us-ascii?Q?LBwkdMsNPLfXP7jH0UpMJhmFU7nAjCQVWdxSHt7LucZgmwHFpe48gRASYofV?=
 =?us-ascii?Q?xLoL3SWx641rhqYjUjlu06CROWrXV7jwSqv+Xou3/uvY7fvn+MNRv/Ld+4E/?=
 =?us-ascii?Q?cKOv5RO05HqOpSPakU9NqtNvoOWe9L/rLIG69kBt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2815f-69b3-45de-383a-08dd942654f3
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:11.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUOO+9AsiMbuq/KrX629TmLSU2g4QqIvOPNjIGevzCfdT37t9MkyeSEW90P2X6294pqCbvVUMtOzXw6JRWg/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/qgroup.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b3176edbde82..2e2a76c3e92a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -160,23 +160,27 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		   int init_flags);
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
+static int btrfs_qgroup_qgroupid_key_cmp(const void *key, const struct rb_node *node)
+{
+	const u64 *qgroupid = key;
+	const struct btrfs_qgroup *qgroup = rb_entry(node, struct btrfs_qgroup, node);
+
+	if (qgroup->qgroupid < *qgroupid)
+		return -1;
+	else if (qgroup->qgroupid > *qgroupid)
+		return 1;
+
+	return 0;
+}
+
 /* must be called with qgroup_ioctl_lock held */
 static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
-	struct rb_node *n = fs_info->qgroup_tree.rb_node;
-	struct btrfs_qgroup *qgroup;
+	struct rb_node *node;
 
-	while (n) {
-		qgroup = rb_entry(n, struct btrfs_qgroup, node);
-		if (qgroup->qgroupid < qgroupid)
-			n = n->rb_left;
-		else if (qgroup->qgroupid > qgroupid)
-			n = n->rb_right;
-		else
-			return qgroup;
-	}
-	return NULL;
+	node = rb_find(&qgroupid, &fs_info->qgroup_tree, btrfs_qgroup_qgroupid_key_cmp);
+	return rb_entry_safe(node, struct btrfs_qgroup, node);
 }
 
 /*
-- 
2.39.0


