Return-Path: <linux-btrfs+bounces-12950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86988A85200
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 05:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683238A75F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878627C17E;
	Fri, 11 Apr 2025 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l10iI064"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF11853;
	Fri, 11 Apr 2025 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341900; cv=fail; b=RBlmcRXEhmEc/iCuHKvUseSdRatUCa5UdgNq6rOQwORpZkHOgad+p8uyAsitk99QWomukaY1bNvaQZed0Sa/WdnlQVLg5ZiTj3O9LNXOUWktmv0l4plx9BG1z9UPw3AwIvgxfqNBrv/LG8KQtGPb1J8Wle3hJRNHYCvwsQgtm+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341900; c=relaxed/simple;
	bh=nx1nDWQk3/7TDOdIvclF7zJH9EaMQADjjyJD9JX5S3E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X4CStpYto8Oq4h5jkXZC6+Y/HNRNlNpSHyWTkcOlTNrkhOLaXe4J7Tv9qOp+SAZl5QQlJGHwY88BnjnYh6/ZUVpz49wxXE9J45Hm6RcAAS7tavchgpwgRTfAkBFRNW23Bu3BF6B8EfA5Uiug0lIGkYIGCErmGjsof6eQNJik4Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l10iI064; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8uJlOQRwmbngWMjsP3NCJXTWmcFiZ9aA5JW7pIRzKzgHtbPbyF/8s7OFhk0KPa7Vq34OXqEmqamns78H5wkNLLHLILnrAk6Lj6ikltc3V9kww0otO8axxA6MyOeVr4l/72Y/afz2hlHK6fEzkDgLPsll1Nc81Tm+R7OfT1sEIeMRfWNeKpYnxgs4ertezgBPop4f/Ya05G1iDN/qQa7DjERzoglJvDxHPeWqyoI1STVV5JHG0lbdtKW5nnz2+J/4tVRkFkjd0lFacaqCmEOb5XQepBGhyuq7p8ZG5wJjcE299oAZsbEwlAlK4zMI3o17KUQKJbaawDxCCPDKFNLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrUsIsGJt1yLVs87/1KNc5IZDUfCXaBWFGHj5bdPtN0=;
 b=bZr+w6662tpMec6lwxEdkztV+VdLTLN3eZhn4COr6tm7FPJlca75hS0eGyBG47qFXaIQRW1vrggWNWpnzyU5nqxNKCejZu0s4qZNPMkOXUZ5SDbAK9lhPZI2CSkYBKfoYc9R5ftrzwDfjTtHTYPTIhDOt7qo9sol3iXTw5GoY336qvZ7rG6K5eASDt145duZ/UapFvwsDIN7jeF67sRtuynVEtlEYTwPJS/NuqUqge2oHdKTO1RYDL7knpFtMCDRJfSrhNUoWpDskohc8NgbGhg0PurSNuu4iJ1mhf480iqEuJX7W6OH+/349HUUoylMbBD1YlLrn9Zca32/Tqgylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrUsIsGJt1yLVs87/1KNc5IZDUfCXaBWFGHj5bdPtN0=;
 b=l10iI064ywD/l3ADgF2vo2wi9jsCX05vrr4zdiyeyd4mCiiVfdjgvJlI7w0AwCF38ZqvhpwX5iF/+jZ1Al11+NuqhM/lHy8U2aT2kI1jD0VDBCKGf42r0z9Y/90QullqLf7/SevTRokGzG4lYZQpTUX+f2umnyW3UBS/1KlNck0VN+Sdswd04bRpwrf1lz17K4gkeAAFyQxcJdVyhfholiG64l3aWaOdc5H5TvPz/jBlA3TD51qfhUL9k7mG5kNIOzPkfiw4sJ5yddAYoIvGUnUVLIBNcCR2LOdXkO0UeZv7qa5/DeqNUe/TGs+Dt0/D94VACRKcyaMpLldJ/w3mHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by OSQPR06MB7112.apcprd06.prod.outlook.com (2603:1096:604:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 03:24:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 03:24:51 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_truncate_inode_items()
Date: Thu, 10 Apr 2025 21:44:25 -0600
Message-Id: <20250411034425.173648-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|OSQPR06MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 205ea30f-b1b8-4257-9457-08dd78a86b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ajct42sNKcZ5rmGHjS6u60WyhTYRzIWIDFYJlGruj3VmFcPib28QsqhCnBfZ?=
 =?us-ascii?Q?CiCgWw+LGD0e5Z7Jf0QVCbMiNa6af7216Ct1iUAnUy9KD+DvjzBFHTYgC/P0?=
 =?us-ascii?Q?ZXZOa3gtcquTKXWW4ystoRX/8mJgr4RismdCUFySNNYlKewiRcxDa81dZumM?=
 =?us-ascii?Q?PqbCzdpiPllLbMzQ0pKl07IHnKSlaBey2RaeMHbOR6tHrnnm7ht1Gw/phNk2?=
 =?us-ascii?Q?XsmVxnIFxK79r023HJq0CVJ/macaMPNrn7FEDTCgKLIAFR0rUCijFfgCRmfk?=
 =?us-ascii?Q?Dno8mW8gYvO5I2BYfspb5QnZJVE3OBZbvRa/ImgT5I2gu+ulwp1pUm+scfeA?=
 =?us-ascii?Q?3dZ/wmkA25uE65/Gq11TriYWreKM5XmoNeaK8mxhvYlQ6W+CX1UE39L3BgU0?=
 =?us-ascii?Q?YjJBcITau1x3LN3k9S/xnfsSqcblmg/Ua9B4YgGfUSC2+4InDJDQr0q7WzGL?=
 =?us-ascii?Q?dYLuNiA7DZdqrZtZFaipUkZWKQxO66nzzvyl/VR3io1ol/LkaKxaD3O6kvVZ?=
 =?us-ascii?Q?MkMnDRctjRlx/ChHurRzAiF7BfNRePZaCBdEXvzHNVF22RKEQeH5LL8zZKMG?=
 =?us-ascii?Q?9c62hNyAnDt6YrwdXENT6aGTs1qKfHEGAPNiJGOu3GuXkL2nTxX04pLB0sCq?=
 =?us-ascii?Q?2RRbHpubjnBbiyN0pjp414FWDZQf7AHcoTX94XwOJrxWltru8AJ3B628e1+Z?=
 =?us-ascii?Q?x/BuebCMnyTpxq8gmKWYhHz4ZKk/kbRs2IKrXU9sVHNFRXpHZYL1F8Zmb+ja?=
 =?us-ascii?Q?gYx2QGxFDbKQIImcmAy4iz2KR0TWW1m6bZFyeoaDYRvccEOza1tTDmxQavtq?=
 =?us-ascii?Q?wtYZwcm2tzwR/l4jvXmLe+1Cspk81Rdmam2xeva+tOD7pEigbe/HfcDSFBTZ?=
 =?us-ascii?Q?+q54eFq4YkwWY1c1lrc/MfEXHc5NlLUMSy0u1PIIC6OzgPXVoI5Vg1XxGr8z?=
 =?us-ascii?Q?iRdhKusnkxyrRDfz02ZPfvBGt6nhr3JZYdONNYlzwDvLR6BkkBGZcXYGYBLu?=
 =?us-ascii?Q?YzZ/xYE2xKdo0Gr73IQaGwqYDlbNmJdOsOp2LQr01yo7zqZd4AXRyYNM0tOX?=
 =?us-ascii?Q?91ZFqTTndyZhxLo261dMP/xrZrMZbzUst/i3F44F5oRQov/Jm6jtZQq69fjP?=
 =?us-ascii?Q?30F08geFtGSPxTnecQVvUT+y9wrvUy3dzc30p+sncp7X/LUuUHDedr86tHEn?=
 =?us-ascii?Q?XgMU+XteR5wT9KN94om4NJWtfc0+bJMM1KyLUCe6Z3t4BzV2vzTsC6xm1WoD?=
 =?us-ascii?Q?5CUUf5DJWEzovtX5XeesSObmlRmJ5XshXsFITOuL0QMXMS+hCytB1OOhPZR7?=
 =?us-ascii?Q?ZPKxcoHnz2TIwuWwqrYpZyiYb0pmZOuHSOW15VonizaWXo4DV/PLjizbprcX?=
 =?us-ascii?Q?a5jgZcVWmlw+xDW9guyWG2NU84wDt4XvohDjoKN2YXpJJMQ/cRxj7nH/eXL9?=
 =?us-ascii?Q?1LHZpjhbyBEwB8Uamb4I7QhZxkiGsAUPlH216YfNcYPtP/W1E96W6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jfj9gk5dH21HT3LHK0VlK3qsPg0agndbVXMSwjIq+3hdzNoyRZIpxl07pBlf?=
 =?us-ascii?Q?jZEh0EF0UEyUr2ADoKWGVxxjVPkUY16vyU0VlGAmHGNbp70B/T1KSSwEpxt8?=
 =?us-ascii?Q?BNUnZ5AQSnIbAkj83Y3lFzOfBlYbSFGrFYMB3pRAp28JogPuEUMUwyb4BH+B?=
 =?us-ascii?Q?1WfW9Nb5SpjOu6uYM8EucAAejELgR0m5oQr3l0zG5rw+7nGWZi60CAi2NjuP?=
 =?us-ascii?Q?86saZfoUPXZyQ7Sms2mBMMuAfU2k1/CJA0vPon24BNR1FOI6lPp4va6nUSWA?=
 =?us-ascii?Q?68jwENHgSXyMGtBUvTMVWE4+gky9YAYVyGPmRU4DOXByapRrre+WYpot6/uD?=
 =?us-ascii?Q?0pU1UJHFrth5KC/ESBeMyfM8AnF9o6kgjnoo6Pe58B5tC/08LatZ2uFuqhnY?=
 =?us-ascii?Q?3gRJwakkOPsNnletesAE+4prTndN/rlpWr38SPU3DpZ4vacZrlbHVZzVXTrb?=
 =?us-ascii?Q?XfI76kYaMYG3f7XovSiymAc5x1lLCbQ+Grr4y9ZBdHpg76Y10j3Feye87the?=
 =?us-ascii?Q?FGKtvWVBHQKicV09IeHtOwUDVT6FARR8qHiWZNr28Oyf8O3yWe23et3Jf3Ex?=
 =?us-ascii?Q?USE6FGUMNC0kFPDTLmYPE4B1e4VHAs6TpoUZuCC8iPnSxKPiln1DbJSSdQDB?=
 =?us-ascii?Q?V4h4IgR+tJ9YvLQnRCfnK6Dcc6TKJldU2h+3F5uMR2ah2+F2Cgu0bvPPxCYt?=
 =?us-ascii?Q?cIV8iHhuWD6QRnGxKl4Y6jVjxYyWx0l5NfeasAx+95tucNOaElhbzWUlIBp4?=
 =?us-ascii?Q?D6GVboIJ1yjl3Aph3SixKBd6iA9nmhcVX4jcLnTXVGaE3ZjvcjSFB2Pl8N4i?=
 =?us-ascii?Q?ssw3jbxfijPR55J3HisEcf4NosjXJSaB29KrIU3ztN3MSHcjQ0DO4CQuQFTD?=
 =?us-ascii?Q?lxPR2ob18nIrLsa3Icm6s66VzW4ncdXNR7IrUgzQZCUwRhBu+BtKlbFJZAI6?=
 =?us-ascii?Q?HRs08yV9bdMPGJOaW1Ukqhvnz2Nsx/Eh9sfXU49sl5+YsXUmKmvsOoasAKiJ?=
 =?us-ascii?Q?gJNVKlzTdjboXI6eOFyA8QCdfWFuhjGRe2vzW5iKSAtR3K0z2hxbRxMaGtA6?=
 =?us-ascii?Q?8Ikbi/SrYF1IT4qWtDeZulWIDQc9gBMmdKfUu/55trw0lrgA6YDCTq3PYEY8?=
 =?us-ascii?Q?uHwB7v8tx24DhmOj+FsvJlf22gywWfLxCQMSGPibOGCDfO8JgvmNExbJ+yQU?=
 =?us-ascii?Q?Eqh+lQPnCiamDKdGcHgAvXRyP8EjcsN7jp4TbWRRsHNQh+a5DcvOAwEUci9j?=
 =?us-ascii?Q?UX8Z6z81BQmalDXK3Z/ZAwBlNYM0XggbhXFIdKZ3hUHv2Pct+JT1A3vwTSpS?=
 =?us-ascii?Q?L7VgMvLVMUkJQR7b1FVak4krYvZ7ux9KYlpQPyVA1lzOHj/0NLspLv+/heEA?=
 =?us-ascii?Q?eV4WR02Lmd4eLjdRKlpOr157oszKPsWGUjtod97tQElw0I0Hv7lbEo424YjE?=
 =?us-ascii?Q?fE0iGLHP/qSftBvTBupHxDi2YeDX4lmhPt+hYTCtnTURNZe9AgbryU7f0UG/?=
 =?us-ascii?Q?0NIRItq2A1gByJn2xISTLTw2Rxpvab3LZGlBRDRBd1zahPcYSMg5OShD5jw3?=
 =?us-ascii?Q?FlzbUEefRMNa/eUX53h5GdYbSPEPvSEQEz/gxjwq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205ea30f-b1b8-4257-9457-08dd78a86b0f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 03:24:50.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAT5MOzH5RpHWa1rJ7Px1ILuk9S7h4Suj+8QrOic9FTmOU5r341cV1gt3fDptfzLY59iJbLbp/I8uztk3E2/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7112

All cleanup paths lead to btrfs_path_free so we can define path with the
automatic free callback.

And David Sterba point out that: 
	We may still find cases worth converting, the typical pattern is
	btrfs_path_alloc() somewhere near top of the function and
	btrfs_free_path() called right before a return.

So let's convert it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/inode-item.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 3530de0618c8..c9d37f6bb099 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -456,7 +456,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_truncate_control *control)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
@@ -743,6 +743,5 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	if (!ret && control->last_size > new_size)
 		control->last_size = new_size;
 
-	btrfs_free_path(path);
 	return ret;
 }
-- 
2.39.0


