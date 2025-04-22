Return-Path: <linux-btrfs+bounces-13215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9847A96038
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3F3BA1A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B150258CF5;
	Tue, 22 Apr 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zz/7/Ht5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6E238C02;
	Tue, 22 Apr 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308551; cv=fail; b=F9s5MbflU0kMcGKHR/9oKy7HysUDr+wUn3PGYcikPX/bFqqiZrxa8pQ942zNwFxhN6qRC91JOtQAeVTlSfEVZJtPweUVr4TfKFoloabq3e9d8xG5oCbunaIHlIaD8sx9kIkzt0U/id4tmDUaVej5cCZo+scHT4HAZxqbYbZVV/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308551; c=relaxed/simple;
	bh=fzu3urwFyssXS8qpUgih00D9XmBOfBUO5gUDKy8kJ6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1YRalT7vPjVnNYo4DoBITaqHNAaNtHIks1FARyek/J/arfvm9ER2oatTc1gvw8T2wHsohCKLhrID6yLIYhGROvY+vxn0ZZRc7ynxwLRRe+arKG9TGWHZPuGvfXFNsd/b0cbvlla8epwh0pefXuEvYomXKLsnW7J6mqa4CgS89U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zz/7/Ht5; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbSO3QTm8JcHsFOi9hvZsli0s8GJaX452uUJpXr/mrWQOZKuUvOYnfHgDhfhykGpybaQnHZTXEL/4MAfkk3y6UCe4277o28Jqds9jJZQTVLjHO2bQqP1ZzoBtPLkvQorr/SdZsMlU7xK6MoLqP61/h+mbc7yLtcWLoLRf/1ltY/wifiiQrmxE/ZNWQtEA/opu220n+eD6m8lpiIh/7rSyZA/RrTmr2cjAXa5uf/DI1q1b9qaC8czGqr0vDHie32iMLe3l0XHy3DK7UdWRJTuHu38qWhJzzDoOeV71EcqLJyUBWVfFSvkaKkNF9kk++OKvGuJFTWzTCGwhUy3oltNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RiHoLSjiqnEmXRe63XEAQ/qaCU9nX6BnVE2lhRIkA4=;
 b=P8xf9bjtRHXaFL7HwmvmrZERAdddHW6x2Cm4gmujfCVpWp3+87aXH2KsIMi7S797z5PpQZcnELDburUpZ1VNYRZcbP5SaChElH6g+nBBDnQAzwdOEOeTejUe9J/TZoTEnQtCbFWMaznM6c7HaFNdclelrSioSPvQSZu5slb2BHLJzcC3hvJjDn6CVaG6LdwBj/FbnFhPCP46uglp8E++WYzr60d5CtiARJmpDzXj21DjO1IbhkEHaACZBCcbnNVQq0SCMyPu1PNyoeau3SyMWCNwokMASjT27R4hXnY57pDmrDso8WGrTVNZsVxieqhfcIrxvcxynE4KR3x3jUUO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RiHoLSjiqnEmXRe63XEAQ/qaCU9nX6BnVE2lhRIkA4=;
 b=Zz/7/Ht5UB6Fldcs84oidltf2o32jaobuuOW9tN4D3mtdPowAUupDPxrwSf7gOYZ34YppNh9mgGbdJeogocmcZjbEGw0v1SHxcaftKAwVEf3id449WBQgoau1jVzvWHi66WjBdN5srjR6V5gmraWh7Z/NDx3Z1sxFKW0z0OF5r1yrHsAGocrE3UrhBJVXL5CeGtVBThaohh2oOakQe9+gWVwi+t9banM8aedSPGAvQea6gmB7mdZ+UprjcNYmLRv32JlN5vao6xHhqNnna2egIayBVTm1NNDi1jTKuUtWApHL7qiLHM7xSKZKqcLCmSyKO5m8Wl/2kjXQC6Cvq7HDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:41 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 13/13] btrfs: update btrfs_qgroup_add_swapped_blocks to to use rb helper
Date: Tue, 22 Apr 2025 02:15:04 -0600
Message-Id: <20250422081504.1998809-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51d5e506-576c-42de-a761-08dd8173141c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYRzsWLIGSO/lPv7T2xXg3X+UCz6YmndAUjCn8dJtUWLyYeZAV/1Hwr6cNhj?=
 =?us-ascii?Q?RcQUNnanSgb6Uz2klHLgy40Ud3jVadARMPZ7OgRUXTPEtqDravWBo4uoCC8h?=
 =?us-ascii?Q?uB3YZat3TQoAL+j2gguG1HdHwFEByhYIPdL4Fey0cnjQVg4oCe7pLOUpncp1?=
 =?us-ascii?Q?z734IDZKcdEN+qvjmfII+0u9HGYLlJxuOobQKwl47q7Rzv8gRkA5e0fEcGHF?=
 =?us-ascii?Q?NYBGofIE64sFA+2iL5MVfmjc/7hjau94B65A7O5J9Kyp8QwKDHnAxgOiqA7q?=
 =?us-ascii?Q?Sniy17vQa+nPB1hB/wrugjepQW/GlFWL7XCJpxuYWPurMKTnoiwcpa9TOTtr?=
 =?us-ascii?Q?oDL/+HYtP/i42YrnQhKogojsNsJhF3ABs5J2JmG47AjYxhz0Xu4QvM+7ygW0?=
 =?us-ascii?Q?IbCxqoKxawSmRfKABGaN7ts60PjByWhhgN6JFJ4TezEiph3vT4zcknOFOuti?=
 =?us-ascii?Q?dSXCfS0WwqLlMeDwOYdU1khYYpXDvJmWBsoWjh89HAelmkkBY+uBhQgL/s5X?=
 =?us-ascii?Q?oAVcPSFHGdYiAg/8g/aRX51oblhKFikahc2WwBaLLcWcx8Tkbn4LxazwhFYE?=
 =?us-ascii?Q?EXkDaam+ueICTXKoyTdwjLuZaNX1X7buCspSd7IG67p/volqQ/0+jrluziU6?=
 =?us-ascii?Q?HArLSChvQHp8/aZi0HsmjBauJDft8aDpKSh+nAgcRj79fDfHH7KpZ5CxMwJt?=
 =?us-ascii?Q?Z81B+agrf7fnwWlwPa386p+JbzYvttSEwLqwgI/buth6uINgnKArsZ081Xp4?=
 =?us-ascii?Q?yHFrcw8F3mn+avcPwlrSyF0XQNm2RwpLWNKqZtHABROW3SszjHSA5XVZyw60?=
 =?us-ascii?Q?2o2HiyQwrrnQr+oeRbpBPAQQxbL6jin89WardbTsRe3AcwR552SS1a1+xewx?=
 =?us-ascii?Q?fVAzzXn4HXcGhdmUAje5+4UZWZ0DqIGxzc4skwdCo+d18OWubfpgjjM5wWjx?=
 =?us-ascii?Q?t8UlMjC6uSOb4lzvexO0GQya1tmT2/6acSWAEULnwl1NLNmngVGn7Ip511Vs?=
 =?us-ascii?Q?an27vZAdFevBjoqVEFKNJayjjcW7bhQaYsIhFfgLtmWtye6UTz5DipTCyqgj?=
 =?us-ascii?Q?CZ4ghyVql1T81q7adeM0yLG/y9l8I7IfYO0z1rLrhkn3pBPw7D0iLlJumdYs?=
 =?us-ascii?Q?fmDFktHaOv8nCHgRO7eLky3fmgZwBieNMRRZIqs2ShKelTFH+jSKZrZhYErB?=
 =?us-ascii?Q?HadhU0EourLORTiKOmW7EVepnZoNOWMYF11m5CENNURKjL/eDhULWl3rHcnE?=
 =?us-ascii?Q?wuub/gJz6d6kXV3a+axgA8cCU0xHgWcLyJ+Pq0g+6rVivlSL+Xx9J5eFBYC2?=
 =?us-ascii?Q?S6n9VkbIxivbBpa4PUZRNBvKf0oB5nfUicnjTvuGsm/9mSR3yzbNU2vJBAZN?=
 =?us-ascii?Q?lQqzHJ98vnpb7nt40wKAb9kbh1G73VWeJgr7nSOswH33+ifkLlKYxLOQppXu?=
 =?us-ascii?Q?6NhW8y7QBlgqEQuUyXeKPhZHkssn/TujgzUOV4jvmQiJhL4xfWVcxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7cDCjRi66MqtqqOCXswT+IFu6gs4jOUbDAplMVTCgi0Jkicl+/7LGGtHYU1?=
 =?us-ascii?Q?vZZxXtHh9hRI+OS3qFp8LZPshLjUICmMFB+gGDUi/8FfOFbkFjT/Bzu8u0Am?=
 =?us-ascii?Q?G1WRPUiacLICBR3G3ENSFAdzCcFs/kRgSExQhCmyPxqNW6dLHXQX5SPcfxlP?=
 =?us-ascii?Q?whs8K32aa6vfwIRfsBy4QucL3CgiREOQ3wPfhoZ/42t5ktsA2mTdOFTpU89s?=
 =?us-ascii?Q?nHJWWWxElZSlWervG8GaXLlDGR6tqg28Glt8plVkR7yVavS42JVTgyh/ot8q?=
 =?us-ascii?Q?gkrA68H5PYx1/DjVJU3IvwAcFw0Lo4ORjIZ/5O+d0la/w1rVRxub0mV/W+MK?=
 =?us-ascii?Q?BeOx4eAnt6Amya4ZYSFyA//fueiQG9k0xlz12NtmwTWQYGiYWMlbtADlu8cr?=
 =?us-ascii?Q?CwlxhhGH4gtXWAZwfpJ/217TOxyLWpMg5nLjIn58YCvfxm+qOWXdAPGPaC1E?=
 =?us-ascii?Q?aZXqHrB4uq71kGYfvx08dqmRCQzBgjPq9AeH/kXCDbSZyHa8NBxp+EgaaqE6?=
 =?us-ascii?Q?VzZ8AApf2LbtMS3yc4vcl5pYQ8P/GCa1vUzZgRJxMPem5x5xgJJyfcE94wbW?=
 =?us-ascii?Q?24Dx8z45ojV+3RSJ2NRLIthnCqJQoe+qkskbP2PbeCzNmR8BzHJ5ZXPJ6ANY?=
 =?us-ascii?Q?nO6XEqaiVJoGkm6O2VBCQq+iWYXE9+vqlgCqJvdfYVpF6EkC7QK6iYdoU7SE?=
 =?us-ascii?Q?USNc2RkmDbx1O0dvpqlwCi7pdCqf9tlCMv7GCT5Tg/6xZsR1Q3OypdTF8/Sj?=
 =?us-ascii?Q?/wKrZqB/cEi/riZF4XLzLncp8zV+svLFykE7L3EYuI1oWhFWPzPlC0me6iOH?=
 =?us-ascii?Q?ET3hENKpvKHvJgRWFz4DtLk8Ava6a4sW3cgPWzqCi+nfh8mqjx8gKKI967XT?=
 =?us-ascii?Q?omfOy3S3qtTI9/jZGuGtiWdoQKnesQaYPS/BKVzKBT5Sxh8VwrYjqPMTO47P?=
 =?us-ascii?Q?7hyYT5gJoEnSWTdD+xHww8YL57InKPf3Q/xtMO/fNgGQVQWDc9vE/VTsDwcL?=
 =?us-ascii?Q?wUZilpuITDw9Napl0r2TZgO3VvegG3y8iiPyWEUOtIrPrznxmDURwaRYWvJ9?=
 =?us-ascii?Q?zPxrK/KE5pR3W76GWx44pddz2Q//ymInwmNiTLQTSLVjvsilILrYvs3B44lF?=
 =?us-ascii?Q?aih0j+8cqR6zgkn3ner4/vWlT4V2+n1qu24+2HZyEUzYGbYJX700py+T9ti+?=
 =?us-ascii?Q?ldDmUmhut84VzN9DAUcZcEuufFysC6dsooO0/NFefg056q9HZdyLqCTZKKGO?=
 =?us-ascii?Q?3iLxWp11zTuamhGreijhBaGsh9v9IALgjfYHBhGMgbH9WMtxhfuvQ8t4CbRA?=
 =?us-ascii?Q?mFzdRBstiTKKzZlz2yh2ImCWQDaEHVXhqgslPNIJTP17TpJW2+5Y6xDdV9WK?=
 =?us-ascii?Q?aZf7sPP3xzB4rFolaQ99YROrdxt1ysTuWocM/J5Ev6YMusgrKagnsmrYt/W/?=
 =?us-ascii?Q?B8eRPM/t6NrdtWq2kya9gopnCmvk082T+U1jhNkUobdxw6aq5uTTNTHMtmR1?=
 =?us-ascii?Q?1/Rexx296PYDxTvT8Z+p1wUFMxFr+uNaM4AqSwbChMO2kFyj7usnEf9j1erk?=
 =?us-ascii?Q?2H1qet2o4pk6gkPwO1FJWe78N9aKGiAVL+ijFVso?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d5e506-576c-42de-a761-08dd8173141c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:41.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9skuWg5q7MyTakcBisN8tsYCwqPek7g1FqJtMl5w/a6yeu5dHUxtySVmppo3rAvWN0sFDzCBwSGhJGjoiJMxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update btrfs_qgroup_add_swapped_blocks() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/qgroup.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5b862470fd67..669c3160573a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4684,6 +4684,14 @@ static int btrfs_qgroup_swapped_block_key_cmp(const void *k, const struct rb_nod
 	return 0;
 }
 
+static int btrfs_qgroup_swapped_block_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct btrfs_qgroup_swapped_block *new_block =
+		rb_entry(new, struct btrfs_qgroup_swapped_block, node);
+
+	return btrfs_qgroup_swapped_block_key_cmp(&new_block->subvol_bytenr, exist);
+}
+
 /*
  * Add subtree roots record into @subvol_root.
  *
@@ -4703,8 +4711,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 	struct btrfs_fs_info *fs_info = subvol_root->fs_info;
 	struct btrfs_qgroup_swapped_blocks *blocks = &subvol_root->swapped_blocks;
 	struct btrfs_qgroup_swapped_block *block;
-	struct rb_node **cur;
-	struct rb_node *parent = NULL;
+	struct rb_node *exist;
 	int level = btrfs_header_level(subvol_parent) - 1;
 	int ret = 0;
 
@@ -4753,40 +4760,31 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 
 	/* Insert @block into @blocks */
 	spin_lock(&blocks->lock);
-	cur = &blocks->blocks[level].rb_node;
-	while (*cur) {
+	exist = rb_find_add(&block->node, &blocks->blocks[level],
+				btrfs_qgroup_swapped_block_cmp);
+	if (exist) {
 		struct btrfs_qgroup_swapped_block *entry;
 
-		parent = *cur;
-		entry = rb_entry(parent, struct btrfs_qgroup_swapped_block,
+		entry = rb_entry(exist, struct btrfs_qgroup_swapped_block,
 				 node);
-
-		if (entry->subvol_bytenr < block->subvol_bytenr) {
-			cur = &(*cur)->rb_left;
-		} else if (entry->subvol_bytenr > block->subvol_bytenr) {
-			cur = &(*cur)->rb_right;
-		} else {
-			if (entry->subvol_generation !=
-					block->subvol_generation ||
-			    entry->reloc_bytenr != block->reloc_bytenr ||
-			    entry->reloc_generation !=
-					block->reloc_generation) {
-				/*
-				 * Duplicated but mismatch entry found.
-				 * Shouldn't happen.
-				 *
-				 * Marking qgroup inconsistent should be enough
-				 * for end users.
-				 */
-				WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
-				ret = -EEXIST;
-			}
-			kfree(block);
-			goto out_unlock;
+		if (entry->subvol_generation !=
+				block->subvol_generation ||
+		    entry->reloc_bytenr != block->reloc_bytenr ||
+		    entry->reloc_generation !=
+				block->reloc_generation) {
+			/*
+			 * Duplicated but mismatch entry found.
+			 * Shouldn't happen.
+			 *
+			 * Marking qgroup inconsistent should be enough
+			 * for end users.
+			 */
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			ret = -EEXIST;
 		}
+		kfree(block);
+		goto out_unlock;
 	}
-	rb_link_node(&block->node, parent, cur);
-	rb_insert_color(&block->node, &blocks->blocks[level]);
 	blocks->swapped = true;
 out_unlock:
 	spin_unlock(&blocks->lock);
-- 
2.39.0


