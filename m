Return-Path: <linux-btrfs+bounces-13018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B1A8927F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD02189C4FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C0F2135C9;
	Tue, 15 Apr 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HB5SYn1g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BB13EFE3;
	Tue, 15 Apr 2025 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687163; cv=fail; b=P6RTFJ9aty9eFruYWYJToHp+FI6zIkhisWIO3Z4dE4ClBrnuGldUpfG4KqfWWxGxGDnMlFO4epHUR3Ux0p7mW+NBy4XK9lS6T7vxXZ8pYd/hijQqSwZ9GO2RZahjUnPDiLO5sBOPmORjS8FNg2uqTE8BO1SNQtALz4zkZPf47Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687163; c=relaxed/simple;
	bh=q0b4M3TTTy68KtFXlchvcknYh/oVESYWR1jXRy+2kOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTrIvk5SI8BcVtsDGn+4iRzVqGcLcsLS+NaZ+eHciN2h7IYWusdX/SU5NxqOEaqf5TEVktN0vCaq8AGQVopn/wZJk3MqHWhFrIKGehwaJd7Jb9NNQupEhaFKjjpeE5cZlMBV/ODCKEiKnPaCqvhmbfJS+DfS+79AX8ewJ3zGiNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HB5SYn1g; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrU4tn+B7onDv3TiXchnr0870BTwabnUywosofWL0Qy+VEYprC/o234qSwinmmtAdpInEH4G2XFpoyxk2C0mw54s9G4lWJGW+0x7gPT0aiFW9IVHspxW/D1IWNWwp9CSQAM3qgcOgyymL5ADxlboZmbXJXfe3B+933O3b6MHs2O82tUJctw/Bma9kmtf0TLc+Q4mL3bzgJNGV0fiBbwn3dnTxJeOdbmlrkK3LBRa6YGu9sDe+ko2qSVA/bvAcC0D4zyvpQlgflPwBmuy3lo2Hg0dmqrFz364JFxo+pavDaJZqJBhWbZ2EwlNrJSjdgt65iJqL8GunbPKubdkA0YTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo4i8JaJgfJ85ybghD5Dw0dqlaoOBccGvljggKm8gGU=;
 b=BYG+a8jasrmv90cKrsO/snkBeUXFYOJ0gW7TvSX4/ZK3YXPn4hFbLb5iOGUOMoeLiu/8U5fw8T+k1+qh74nqf6TuZEWyKnXB57USwI1qoBZZemCZMfGBgjrdMM0+3h3p9iNLUGTx+R7SStd3uqtmMXlWWSoPZahZp5dWv4BJEYzW85Ga8QqWEPd2XraoikhmcLTVuBl4W29K9T/DKu38pfM5XErLA5FkLZmvaW8Ec8rtmpzBuE4OjRKrMD8iAHYVQ2LCdg06T9kLaFtrWCPalr/Pm8k+V8S203kQAzkWRxDBetwziDAHeR8u3v88NVsm5rv8B7AjwqwRXY2GYpRwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo4i8JaJgfJ85ybghD5Dw0dqlaoOBccGvljggKm8gGU=;
 b=HB5SYn1gfMqMSd5MmCz8kP1YXIVowMR/gll/fz1hruW7lHOETl8a0spKrH69Tc8M8bZ6pWxbNEgydH/VrZPRelzykN7G0X+pa4fExHD+BCCi8/v3i7wlXHfPww3rx2s+5NBRUtjvcyDjvLiHPaaxQWEuHdtvi3+pc28VeYrA6ib4SEFVA0l8oAmR+ldTsnM6486wF3w9cjiTLNtI8MTRI4cSaEsoZ/MB9ybugfgmk5Z99Lcxl88nc+XgJF/Kt98reNRc7emwiUIbqZYWEnJqd2wq/ONpXuegX9KRArqQ34bNw3QghJ73YfJJYK4NQVM3kd9sFFxDnrLOgtW7RH1huw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7106.apcprd06.prod.outlook.com (2603:1096:990:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 15 Apr
 2025 03:19:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:19:17 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH 2/3] btrfs: get rid of path allocation in btrfs_insert_inode_extref()
Date: Mon, 14 Apr 2025 21:38:53 -0600
Message-Id: <20250415033854.848776-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415033854.848776-1-frank.li@vivo.com>
References: <20250415033854.848776-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b977857-0f14-4deb-9985-08dd7bcc4e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZNgGydi+5frkhm9KeGAWh9zH1dSBhex7gm1fi3ZRFMlWJ+Ticm51myJfWqpX?=
 =?us-ascii?Q?KoJPnJ73OiRuJ4JGKK9BYwHhse3Ttg1pikLuYXfKxoBXcAGJ3b1pD0fuKWOz?=
 =?us-ascii?Q?L5Boy96GHBdhb7LCS0rsdjs/d+heOJwLUkTrJAB1pYjhvlEG20/97Iq0lI2K?=
 =?us-ascii?Q?FJduOdfV33QsChE+U3J/uc0VxrXgb4A+9sxnNQBj/5X56XBPBYPeHzSgxMq7?=
 =?us-ascii?Q?7hDUZ1dzGjd1yD60UJSgWRB0KkqwBx6MSLrrH4LwIMPKJWoN99HiMFixld9N?=
 =?us-ascii?Q?icIKo41FG88XcyuIB/YtFw6ntvShoXxl8nZ167qdP/EZO96lc0Pj5P5f7vup?=
 =?us-ascii?Q?8Jz2LJpItKC/t/IcVIt90twCYwisqEBHiYHTu47yXx2/N1NfAiw/iIgljPAd?=
 =?us-ascii?Q?JijsgRGDNxL78dR20Eld2dzWwIXQY+IC851iKcnCqR3uQMXTc7GVef0eIXKI?=
 =?us-ascii?Q?aq1f33AzSl6VTG4XCrqP5L+mJrI306tc84dJl2aDh46A1a+Gj0w7ogQFlx+i?=
 =?us-ascii?Q?c1dXAajd6dxmxZNcOSKcG8HQLeQV7BaIAqSLJ5kAsNdUSv1+tKu+Q+WLqpnI?=
 =?us-ascii?Q?J+xurzPD24hLAghSDTRJTBtTey/oM+w5UtAg+dWP5CBqQDliTNklIdph4g63?=
 =?us-ascii?Q?pOfIr2jo47/Un2D7QOO6K08fzMXsyxYqARAT4C2h4VFdCkTHs8bPI82yUzLQ?=
 =?us-ascii?Q?VKjk1vs3KYCLR4aq62nucWzCe4IN86xeFymrc5OAt9a28hp6w378LBIIKptn?=
 =?us-ascii?Q?MHFRGRqk50pdwF82Mtw3uBhdiQjS6NHIjVRCkSEGkQdrbKNYA1qwuW5K6tO2?=
 =?us-ascii?Q?jB+SnO7Z1TqQU7lCrhq/97qphhxYZwJeotYB+wYCgecyaW8rP26eS5Et1faq?=
 =?us-ascii?Q?2gjY6fgkDEWxYmLTU7jcaAvy2H8cLrWZEsyqX+0LE+pCcxB91dT8M6gb8xz9?=
 =?us-ascii?Q?SW/QjBtExd0RURGrsz0RiahUt7ZFuZBx7jKTXD+YHq2p0y3F7Ma7sqbYG6Ev?=
 =?us-ascii?Q?fG9NcZxBRGCSaysgg11s2tTxAU4EU8A08rWXlwtimhPX+BO2PfYWI5I6NV17?=
 =?us-ascii?Q?yVY5eIDkUYBwjaiibXZj8L25Bh9/dddnCBfir3Uyz0/mujAygxGVRGt+zt6j?=
 =?us-ascii?Q?fPzR0Qlq+LZ7cy/IaHgiduroOD2XqUVpYGwziFxdkiBhEl2p8c/BQROOKzUv?=
 =?us-ascii?Q?3Ec73iSMr5OqY8P0C04L7rRIePUU38M2D08/qcY03L40HVbGeCFZhqXNu/Kc?=
 =?us-ascii?Q?kEkVfh5ndHMsxpG60jyR9wXYjS4KPyEG0LgH2dFPtCu+3/eaq5VL2Y6BeIcz?=
 =?us-ascii?Q?PMcjXjxiJpohiT8A8v1B20T9edkn8azy9Jzjy+ySsbV2FGujU+d0kyLzLitX?=
 =?us-ascii?Q?i2SUDeLx31KPjEsXN/a87KNCH/eMYxtiqomY7FLU0q+IQN2wJbsNQiVB64r8?=
 =?us-ascii?Q?BP0cu3jW5eSlfBW+00tQ2krZkPuECeD8n8zU69AcUn8cspICctkqFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLpkB0lGif5Snx9y3fhrhipbLF894IzDUia7+DvHNoSf/ThiHFZZZBtO0bwA?=
 =?us-ascii?Q?dwwYCCV/TdiH/b/ltvXdfn6u6HurrTWaQ+8tIGocNb8XjlxOrsg2Gl5RYTMf?=
 =?us-ascii?Q?We689SWxxUnYx3W/MXbO9yzXN1GmLztNP5V40GD5/jZSRlac18fCnGl7vJJ5?=
 =?us-ascii?Q?aAw9rshXO8gV1pujWb68mMAIYdyaje2fbVMy563uhBkoHwHyUsrhFl5UpG8H?=
 =?us-ascii?Q?jQzFAxsidJBJBHWQcNAC7Bqx94qEvhM12YzC8pEPZJMeI9GQXRHIgaImgua1?=
 =?us-ascii?Q?YMHi4eF3NIHMgjU88x6QSkalqG3Z2oWQkT5X6Y5UgXiHaUr2ZpJpab84odS7?=
 =?us-ascii?Q?byLrpuKubEEycqzy/Uwjn50HI8OZRem90WOF9eneIDPDGhAFcAK7iMoPaa2Z?=
 =?us-ascii?Q?vOdxSGd7W0Vw5Y0u54J56QZgmosG3z6jDlHfC8eUjpkrcbw2uB/lCbpUc2/K?=
 =?us-ascii?Q?OawskppfIi5pJtIkIKSHJHctcvwPxMouumXAZfDUF2aMwscm8nxYm6wugJBo?=
 =?us-ascii?Q?gNOvIX++qJtgky0uy8oOZ6w/85kHUeyviLvOwDTffeMH3R7zPW0jiHZQD2JA?=
 =?us-ascii?Q?Kg6AuDMhUwLLVpTenLsLi8E9hU//dQjsQQhTbi45YM8GeSAyLdWaluOy8H9H?=
 =?us-ascii?Q?LfZSNnpwp4xq3ZVyS9x0Pnx31yKqRkq8gcobQ7J57x39C3/Fv/GhPryshvXl?=
 =?us-ascii?Q?n+vYvz34nnJvlR98oWIVstIxnqwGvqdtFb2PVPe2OuRHF5ykgnM0eWHDhq5m?=
 =?us-ascii?Q?UZXcgvnvO2vjdulswW9UhDIPC3JUF7CcyA4WMtfOywknPSBQyIdcFaZaLeVI?=
 =?us-ascii?Q?SSHHu0RIsBMzbIM2NjOLFSqTCxu2gDWkCmCvtDQnbLkGAUht7G9IUaeXnkoV?=
 =?us-ascii?Q?Ue9yPv5hdLrxpnpFr+o6jNgrBjjCk0yYZLbJMUiChJYJNwyz+PgrO7wxumPP?=
 =?us-ascii?Q?eQTPifjyi9FOcrhmy/FQmnT+EnCFIeO64Mb8NvDV4lMuXa9/sjzfng5du/uN?=
 =?us-ascii?Q?AxxHA0UqQOq2Qnsfwr6lRbza8n40XTMZWzZZrvIt6p8f8xBdtkqrqUMUjpHk?=
 =?us-ascii?Q?VQN7Zt6+QcChaL3sQ7CUjLazznopnOGhpAA3tHq1bKJ4Ch2TNJkxRQXVh3Yq?=
 =?us-ascii?Q?jqCcL0NMCa1Mix4GUoEOmK+n3YiUbMdYOgtkIwY4eKgStrXA+eV4M0O17a43?=
 =?us-ascii?Q?nx2iPsyjis50AGKXdsrdrswrycYWCLKch+VMYzHnilvV0E5gEB8gSMW93tF8?=
 =?us-ascii?Q?Nsg4d8pGRkznfzS+ZV5FlwCUuWbNauseNjF/dh0hjTVRJga2YWKuDfvidabx?=
 =?us-ascii?Q?HoCHZBPtfjlUL9zlRQm8ABI3fPcdcqqnVp+GO6g5gShWY3J1CHHNNHehkuIP?=
 =?us-ascii?Q?9T0kdGOVaVMU7kricD0LgpCVNywbuq5ymYQls+AtfyiUz1f5wAj8KpIIn0hR?=
 =?us-ascii?Q?CxOHu/M5qt8Evw1cpgQkHnPtsFYdsc6T6/1mogxjhUEWtKATc3DjylWkrqfr?=
 =?us-ascii?Q?PP/g6NNKyva4oFDcBPc+A1h0Wt4Mpn7joK/gM1FpkvjmKQD4DDKpg6PXcjy4?=
 =?us-ascii?Q?1G2ZLUvm/eEfUCY5oP1LfbQUAptsn1XvtWix5sY3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b977857-0f14-4deb-9985-08dd7bcc4e62
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:19:17.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMpiHgiiqPuIg+LAmJtib0LFUbWDAGqgDqjmCtTaxQTnNsYuCPNKe5/t6IhPdgD/bwJqGzUOLI2RUv+U8XGi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7106

Pass path objects from btrfs_insert_inode_ref() to
btrfs_insert_inode_extref(), which reducing path allocations
and potential failures.

BTW convert to use BTRFS_PATH_AUTO_FREE macro.

Suggested-by: Daniel Vacek <neelx@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/inode-item.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 693cd47668eb..ff775dfbe6b7 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -243,6 +243,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
  */
 static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
+				     struct btrfs_path *path,
 				     const struct fscrypt_str *name,
 				     u64 inode_objectid, u64 ref_objectid,
 				     u64 index)
@@ -251,7 +252,6 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	int ret;
 	int ins_len = name->len + sizeof(*extref);
 	unsigned long ptr;
-	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 
@@ -259,10 +259,6 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_INODE_EXTREF_KEY;
 	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      ins_len);
 	if (ret == -EEXIST) {
@@ -270,13 +266,13 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 						   path->slots[0],
 						   ref_objectid,
 						   name))
-			goto out;
+			return ret;
 
 		btrfs_extend_item(trans, path, ins_len);
 		ret = 0;
 	}
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
@@ -289,9 +285,8 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	ptr = (unsigned long)&extref->name;
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 0;
 }
 
 /* Will return 0, -ENOMEM, -EMLINK, or -EEXIST or anything from the CoW path */
@@ -300,7 +295,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			   u64 inode_objectid, u64 ref_objectid, u64 index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
@@ -353,7 +348,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	}
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
 out:
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	if (ret == -EMLINK) {
 		struct btrfs_super_block *disk_super = fs_info->super_copy;
@@ -361,7 +356,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		 * add an extended ref. */
 		if (btrfs_super_incompat_flags(disk_super)
 		    & BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-			ret = btrfs_insert_inode_extref(trans, root, name,
+			ret = btrfs_insert_inode_extref(trans, root, path, name,
 							inode_objectid,
 							ref_objectid, index);
 	}
-- 
2.39.0


