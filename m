Return-Path: <linux-btrfs+bounces-8180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77862983B7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C28F2840D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0131805A;
	Tue, 24 Sep 2024 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oUeSlYMo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8D1B85FF;
	Tue, 24 Sep 2024 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147402; cv=fail; b=DUcoxYNdjGC1R0qVa4RgvWMtMolvx1pV5ye+N3GB2PM3ZJO2HHFi43lr2tFvjdKgMTUHGRIUH/6v5/u2s8ziNr+8OL4EDzaZzsftwHh/9RmY5qZV2kn9RGCes6GSNSxE52RpyGOhTukdJl9OwWn989YRSCsiJreljsF6AMinh4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147402; c=relaxed/simple;
	bh=mJngLGpBdb9ZDQsQZ8dG6K+b8YcazkWyyXey7361h00=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N0KtP+Vq6n73zyEp0NgOtcN1QgXtDwtZleotE+XS7MtH2mOWLhxLbSNg28yzWgKIhXI4M4XHYSg1C3gIEdzt1yrr+bPMotkZdKTpPGUiuDj563k2iUGezPGK8ADpN5QzI+ldVJSp+qsLcoTzF5mLHzpIr3rv+jjfGfjwWi7rIJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oUeSlYMo; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1W12R+MBp9W1i7X1qCUsKrbWZbtmf0xsBHfe4M/Qmo7K2EUJ1leh7yx2MOd01hnHvdo8W0TTsBJ6b2nlyAAGSbJmGQlQF8YXAyLskwmuliIpA4PujFsaB8u1pgaaS5BPxyBif2wr9RwnNMxGCajbrxtqATlGXZib9CaDCK5yy6wxQpsg8X07hQbrfWKRfO4BdztYnb/YVtOht7zLThqJJ73L2F1Ak3xGVuJZGNdVFXou6VMXxo4rFCzBY22KJwQTTlKuuOE+z1sWKk62jH7VGHyYcR5H/eiTTop/2moHaaIlPAaSeLVqF0ZRjzkb1At44eM8/3dnvh1gI2TpEGo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4M9yy88DopB03LQMRd9Gc3xm1lx+sPegHU8bwoZoGk=;
 b=nggtC6j7JFZJIY46wBBgyS8H2Cay9AyS4443xH10icbhj3dd8AwByd7iZjEq8/am9s/Ae1at4hNo/yaTuqEU/Sdp/qkIjpeht+uTGSPWV1e9g20u+5X6xsY1rmB9s/RIBfxsJL4jTihDaGoCFHOn78lgggpYgsM5el8P5cOEDRKKD2yLgOnZB9geq/Ri4oDSfT2xbDiv5IZE3lzeeSN1U2+l9ai7eJWNAiiCjit7D2A8gEsyVOP1zwC8qzyI5U068Tz7McqVQ7bXRaHJtqykHeWF2hS57ZKnbCy6seJ9YEwiO7v6ZlOGn5hm81o81r7Y6YgDGcy1BUP/wryf+i9oKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4M9yy88DopB03LQMRd9Gc3xm1lx+sPegHU8bwoZoGk=;
 b=oUeSlYModh/polJA2sl6pFWsAHBolKPMvqY4qJ0wMo78B+6Qj7GTIUCNctf3QNtJ9hp4YYBZreBDBZ+XEmsbYYdGNp2tdrIw/cULMLxJAOEpZ6pyZNkVlLmVeF2ykWflUSTrNZqA5LiTvf13KeNj6sCBuulCG3P09FBnFEvccbo/JavALMYrMCnzq0DssI1gGSBehThGit89AbStidYGqOTGXmbwD/ZX8WSZkPYIHzX0+jtRNad2J8C186PmacEnpd/mHb2Ttl1Z++n+AKtGuDo5v9zuxwVHyBONNkkjhtWeXcdZkQPtZ2sR0DWYZWcDxDIF4MkHRCo+WZwhEinkkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TY0PR06MB5353.apcprd06.prod.outlook.com (2603:1096:400:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 03:09:56 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 03:09:56 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v2] btrfs: Correct typos in multiple comments across various files
Date: Tue, 24 Sep 2024 11:09:44 +0800
Message-Id: <20240924030944.5352-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TY0PR06MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 04559b8b-171a-4eee-52dc-08dcdc465dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RU3WJAgvPSgmVrZWcBghB8wnEOKaL0ohmWvqw1QoDsE11OPN7ptTBpMvMkvU?=
 =?us-ascii?Q?KZcfPgFsl4D2OOFIIUQ+6zYyAAx/AfMSfReWusHi0jl8MQBGSDgBhBGyR+sE?=
 =?us-ascii?Q?qR+FSTDZlexBkUlpQBtCYd0nxaO01Hl4gG0WDBTu4/DWvxQrKKW+gOpZUjso?=
 =?us-ascii?Q?iLfzlPCaneOAVxhOHBcDXeOCvpc8vHKSnnfUQUbDpAjPg3TmTWAtAVADrt4K?=
 =?us-ascii?Q?Fq8/md+Djj1BXw9LRjNkTykHtBoGo/TRUTBq9uwnBIW2uOt4LaGwEtXZUbD8?=
 =?us-ascii?Q?X2b/ZTVsuk/+Z3KrZOOE8p19q9BHmLJqUMLa3pcbQFxKHmcMp9GYLPrB6k6P?=
 =?us-ascii?Q?N9iPjJptRCR3cvdi1n9RIt0hX70Dla74xhx8t+PZFOfZ4f7coBSNxWjkd9n+?=
 =?us-ascii?Q?k804vlfypQq5jFC2R31b05xxEw6T7iTI8JZcHgG0RAw6F9aTd+Z1amckCbUF?=
 =?us-ascii?Q?envmv4/b8uZ3QLWqCfmwxzrx1WjdFiKhCW8Q70ijHsK+B/OK2ynmts8gwQFL?=
 =?us-ascii?Q?WdZMc2NeKJwzAnkSR3oV0Ndj5vOrcevOi7PMb5TJPPPsqxiEU2KdZlVEqTZw?=
 =?us-ascii?Q?OpcJk1repPL2oz4GT8KGQ7CFVcNF0JH3R1sDFtpimst6kXRde7SFor4jFdMo?=
 =?us-ascii?Q?rMQZrA9bQPYEjMISUdx6pwa+deURU5xhdt2hcmSn2CauQvcapsUekXXvVdoT?=
 =?us-ascii?Q?Y7xo/H8sJZB2wnZRKSaA0xkRZOWJB6XSiSUOEPHrBz087ZBhZ0pGG3xJ/VEq?=
 =?us-ascii?Q?BNu1QcqZjNpZn96i5XKrpb7eMeo4XW6R0rlTO0NzFtfczHp9lEbD8nsBiq0W?=
 =?us-ascii?Q?KZrAZYmZAAP+JM9vxEhFPfYanpFGzVsFSPak/sdsFVG54U4bz6Qms1RcfkpM?=
 =?us-ascii?Q?ZIWIjc1bE+a8ggjVneWsc4CyeYQ4FnP7BW3VDuhynOCuVXBd4F+iZ6Bq6eFz?=
 =?us-ascii?Q?QrJ7j6DQjIW1AnXrPGQEbN7MBAoFX4l+AQEDF0kKlTeB4Uj3uReOVgqQhdlb?=
 =?us-ascii?Q?uztGxuICqt8hpEkgTxMeMs/VbkQ26XbfAgyA3yV2uiMOWmTLMZHGyNXoBED6?=
 =?us-ascii?Q?W4gR9yqry5JXiS/3WRhsoUJyTiOHQMb3vUtgnZxMc/aspHOpgmeTwKixw7lA?=
 =?us-ascii?Q?k4alEiM5ImeeZTGyXBa4lWVPa5U3R1RZVYSkMmUIFqiVv/IyOTLOCOP5Qxwe?=
 =?us-ascii?Q?9w3y7PB5d7d6kucRnd7AwZnM45Ve6SCxNcx2+sBBWleOlPB3FzVEA/CsYfoY?=
 =?us-ascii?Q?k8rc8g3SvKWl3zB7Se6J7su/7+AlBmT4EIYT2PsCh5S0iFyUPglQiW7nLJc5?=
 =?us-ascii?Q?vu1VYHX3DhO3beT18anVDLbaO5CnJMI6mNd8lQOzUIJsoMrMsyCi7bq11pav?=
 =?us-ascii?Q?lz8HhlyoXVf3ppWxJ19gPY87Q7x9YbXIR0u2Ms3//5gE0Wt9ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWn9M8TbfdSTBBQBTi/YL+3yHCHPrvL0E7ssGwRSk+g6Nd/3Zs3owEWdB+Jt?=
 =?us-ascii?Q?83ZHczm7mskTHLoYLZ68U9iQdUPfEr701xHl8XmPc2JRYKVYwcm1dKb7eJyw?=
 =?us-ascii?Q?vqUcFAxFBNQ7NW1lD8OluRVD3OId+ZpUXffJpJb/gSeRlkcsPFUT+IEeSL20?=
 =?us-ascii?Q?kAMus81lR8cZ9ONsRrQfSrMH13gulEvLXEh8eoa15D8MLdaVXLDweEMdXChG?=
 =?us-ascii?Q?0kiOIIGiyMU8dNYfq5UpRX2AZ1UjdljcvJZbh4IV4BWcRV4vK3HBY5OOnGDE?=
 =?us-ascii?Q?U8sxgsTNJvqdSrlvrWBSXPw21Y06K6GObl3bHSLbTYjYU2ECNk2AU1RSKsz4?=
 =?us-ascii?Q?eGcaRYVihqqa+83+kzkWALoHAPe+gmL9svI3wZWIsTyMkhO4tWmhVsBwdrGp?=
 =?us-ascii?Q?9Uzhi9Le/zpHMupSLwqRSIIknJ0nGu+7P0V7Qn07SnXFb/bQUSm5kp4MNHmI?=
 =?us-ascii?Q?bJTOi+QJzWazIk8jd5YofjEIQr7IB6+HcPICzhKwc/TJlWWGDOlIGf3ZwmLi?=
 =?us-ascii?Q?1MfVch1MOskbXUPBMuvJT2/udK2PdH2DN8BdOhLZsH4Wd3TlEPsRss6ic+Q5?=
 =?us-ascii?Q?z3WMd9mlT8ruW77n2USK5pfTCfCLNfBr6WTAP8TmBx+BxjzvZfTnBRbn3q2M?=
 =?us-ascii?Q?d8Z/6DPVAVvsggvvMA1hByHkifP9TX2lpsunb2fbASaHmAMIjiybB4Z/kFYg?=
 =?us-ascii?Q?9mxB845egNihd2RtFdLSw5UBKgMoPlGIL0ilxndYNcCQrcwBeABAhXzHu2xe?=
 =?us-ascii?Q?jjiTobNgWNaL4RQAZkVpLOuxBHUO/unnQugVLjok0QrJoZuGDYIYCy7tSzrd?=
 =?us-ascii?Q?KHQ4dfq/jrTyDLFQCvXsyA1n0C7LKDap3z4ryRo2gUqMgjRqMWejf3nN7BxY?=
 =?us-ascii?Q?r54q2jE8uHVkrdjj0Rl2KNsqTR5Jwa+J0kZDd6vYJG6LBgEnBC/JQYczVxOC?=
 =?us-ascii?Q?LKMZ90EepzBt1uxRUMWQAQpz/FQGD638RotGqY0CxzNoRtd1fT5htkaGIdHa?=
 =?us-ascii?Q?MsmGoVt42psTlwjj9HjG/fVv4z5sNgHb+IZbNf7KU6hzsBZr+4aEWoYXLen8?=
 =?us-ascii?Q?/suQy7tZNgV/xe01eTepOdNPLq8n7pCzrSMc6RXr39zDmsRnI5AqiAmF8C+u?=
 =?us-ascii?Q?H6vmn0JG5Ap8b+c1MsfY31eecc3SWcH8Wpy+HJTZVw1clkkt8Ca94pgy+t7q?=
 =?us-ascii?Q?JEbdGxP7aDXPuU8Y6+kp2gQVBu9B+lCoTk2UzkbXYUVkUbtdYbqD6fiUwrcm?=
 =?us-ascii?Q?f/3F0+hZzWEviLKI6bxEEtGK4kbIdvi1j0q7P25DZXYc1MF9n5A8yOHN6hyC?=
 =?us-ascii?Q?pJLsVuj9xfgMzUAauk8ZXEY4Uvy4xtIJJ25kJX2ECbUcpk0F/qgPyz97bxxI?=
 =?us-ascii?Q?hFgMPP1tdRg1Ae9BS5uq7Qe1flDNfIw5QQHAUKRbkjtenMJDL3IbPw4DFqNi?=
 =?us-ascii?Q?CTI8H9rvxuSBhrX4rgrjcrYxwdKk5C3+yVrL3snHBpyLTvWIyVxn/J/DPiVG?=
 =?us-ascii?Q?c7YKfzFWxywgBIHTZW3zChPyU7S9NqAWu0ohsvMzASQkNJzbjTvIsgOpPHiS?=
 =?us-ascii?Q?Tw3wLA0SgqGuYvsIw/9KtrQpgSCHZnvXyo97NbrP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04559b8b-171a-4eee-52dc-08dcdc465dd0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 03:09:56.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QkDtg/azX6/88F0oPhrYrgbZ7wSVw9tbWpxJ+fLkliGi3ODBOH1BdRlAaGd7EtHFQ9lYbBy5grSPW5GSIDIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5353

Fixed some confusing spelling errors that were currently identified, 
the details are as follows:

-in the code comments:
	block-group.c: 2800: 	uncompressible 	==> incompressible
	extent-tree.c: 3131:	EXTEMT		==> EXTENT
	extent_io.c: 3124: 	utlizing 	==> utilizing
	extent_map.c: 1323: 	ealier		==> earlier
	extent_map.c: 1325:	possiblity	==> possibility
	fiemap.c: 189:		emmitted	==> emitted
	fiemap.c: 197:		emmitted	==> emitted
	fiemap.c: 203:		emmitted	==> emitted
	transaction.h: 36:	trasaction	==> transaction
	volumes.c: 5312:	filesysmte	==> filesystem
	zoned.c: 1977:		trasnsaction	==> transaction

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
v2:
* Fixed more spelling mistakes in patch.
* Made the subject more precise.
v1: https://lore.kernel.org/all/20240923141957.GE13599@twin.jikos.cz/

 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/extent_map.c  | 4 ++--
 fs/btrfs/fiemap.c      | 6 +++---
 fs/btrfs/transaction.h | 2 +-
 fs/btrfs/volumes.c     | 2 +-
 fs/btrfs/zoned.c       | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7980b2e33a92..5c5539eb82d3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2797,7 +2797,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		 * uncompressed data size, because the compression is only done
 		 * when writeback triggered and we don't know how much space we
 		 * are actually going to need, so we reserve the uncompressed
-		 * size because the data may be uncompressible in the worst case.
+		 * size because the data may be incompressible in the worst case.
 		 */
 		if (ret == 0) {
 			bool used;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..dd7337c36db6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3128,7 +3128,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				break;
 			}
 
-			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
+			/* Quick path didn't find the EXTENT/METADATA_ITEM */
 			if (path->slots[0] - extent_slot > 5)
 				break;
 			extent_slot--;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39c9677c47d5..a17383681b81 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3121,7 +3121,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	/*
 	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-	 * so it can be cleaned up without utlizing page->mapping.
+	 * so it can be cleaned up without utilizing page->mapping.
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 25d191f1ac10..9e1a8af6629c 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1320,9 +1320,9 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	 * not possible to know which task made more progress because we can
 	 * cycle back to the first root and first inode if it's not the first
 	 * time the shrinker ran, see the above logic. Also a task that started
-	 * later may finish ealier than another task and made less progress. So
+	 * later may finish earlier than another task and made less progress. So
 	 * make this simple and update to the progress of the last task that
-	 * finished, with the occasional possiblity of having two consecutive
+	 * finished, with the occasional possibility of having two consecutive
 	 * runs of the shrinker process the same inodes.
 	 */
 	spin_lock(&fs_info->extent_map_shrinker_lock);
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index df7f09f3b02e..b80c07ad8c5e 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -186,7 +186,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			 * we have in the cache is the last delalloc range we
 			 * found while the file extent item we found can be
 			 * either for a whole delalloc range we previously
-			 * emmitted or only a part of that range.
+			 * emitted or only a part of that range.
 			 *
 			 * We have two cases here:
 			 *
@@ -194,13 +194,13 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			 *    cached extent's end. In this case just ignore the
 			 *    current file extent item because we don't want to
 			 *    overlap with previous ranges that may have been
-			 *    emmitted already;
+			 *    emitted already;
 			 *
 			 * 2) The file extent item starts behind the currently
 			 *    cached extent but its end offset goes beyond the
 			 *    end offset of the cached extent. We don't want to
 			 *    overlap with a previous range that may have been
-			 *    emmitted already, so we emit the currently cached
+			 *    emitted already, so we emit the currently cached
 			 *    extent and then partially store the current file
 			 *    extent item's range in the cache, for the subrange
 			 *    going the cached extent's end to the end of the
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index dd9ce9b9f69e..184fa5c0062a 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -33,7 +33,7 @@ struct btrfs_path;
  */
 #define BTRFS_TRANS_DIO_WRITE_STUB	((void *) 1)
 
-/* Radix-tree tag for roots that are part of the trasaction. */
+/* Radix-tree tag for roots that are part of the transaction. */
 #define BTRFS_ROOT_TRANS_TAG			0
 
 enum btrfs_trans_state {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995b0647f538..555a817bf065 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5309,7 +5309,7 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
 
-	/* stripe_size is fixed in zoned filesysmte. Reduce ndevs instead. */
+	/* stripe_size is fixed in zoned filesystem. Reduce ndevs instead. */
 	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
 		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
 					     ctl->stripe_size) + ctl->nparity,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7fa2920632ba..00a016691d8e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1973,7 +1973,7 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (block_group->meta_write_pointer > eb->start)
 		return -EBUSY;
 
-	/* If for_sync, this hole will be filled with trasnsaction commit. */
+	/* If for_sync, this hole will be filled with transaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 		return -EAGAIN;
 	return -EBUSY;
-- 
2.17.1


