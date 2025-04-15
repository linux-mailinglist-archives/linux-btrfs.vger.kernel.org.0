Return-Path: <linux-btrfs+bounces-13021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA68A89291
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092B17A9569
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF20215F7F;
	Tue, 15 Apr 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AG4APbiI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011052.outbound.protection.outlook.com [52.101.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A18211A23;
	Tue, 15 Apr 2025 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688048; cv=fail; b=qpulmjJUkSbF3c5dYzUJ6XZxhyTbBSBbezExAujqiMKZk4Iw9rfxDrmpm345rA+0l/J64D3Pufm1C9g5yb1foKeE8/T+Htl4acy0GGpYTAN07uXRY12ocWXwq0k/ZLO6auNR4u/jX/+V25FTF3tSYfReXQ0lX9Ya6MMd5V9SZYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688048; c=relaxed/simple;
	bh=fNMNsVcL3RHIKXZYJGc+Bu8OkdM6F/ffpgbx7NnE7Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mvN7Ty6T9ZVztNvfjc+nWAd/gwDCBOvbrnkeIfVG1YuYURq8EoxuggYI/vctCugobGVRtP3k/Ifefxinb/gdSvFykddIrgJukT3URKl3OiTyCbyGmF9q4xz6DytGk7kK+p5U0YCZDmyECKyLlPicNVkToQWLHyO/gwQlVgB5aHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AG4APbiI; arc=fail smtp.client-ip=52.101.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbhiUScEKRf5hJXz+NRcCGYiC213j/MfQxFJ9qpYHGQfmYNzp3VkXpk8p9E+0vBqIcyTLgUMdBhnsw/OEY99iO0FcHSTDr0wvsoqzII8v3AX4aKfgou6Lx4LrHNNucBdSEafWDt/VIBUtvfqabn8R7Zc5NsCxG/+Sv+3LcVUF0Br6ynxCnYGGjepLtyzy3BdCjqCFhd+Xen2dKM7WYpuRnpu30PbD1BxWngGZjUnljKTEwx0a+4wRFRSVcHI5xXoFvwcaY9ja2Wv9oQz1/+RYTYl3NEezFq8RZaecK6E6+Kb19nyo3mqrf+rZ7Y57V+6Bx1V55ERxB2n/zl4MjaaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZJ+Eedx1TPMxcJCGMfSxJ8xlIW96pIpsYTr86s0gEk=;
 b=zQ7anB8MbXiOOR5T9BAJLpXjvyjtqIPPZk8za8q1woaguY39rot/DvsCltCl34Mnfuk4aVxRo4w6Z6XPtE9isoK9a5VNzpfBd1zysXQzXteSuR1PB7TqBQ0cJAKKVYwvl+lk4kzai14/XsC3sbfkOa7lrPoMPw2HajyeIp+DB7GBHqMGXNNZCyHyH0SJSW3mRSFFbZSKI9KzF68Iu4Sz9doRhhNKovW8k1mCDa72C/XiWXWIyfBdkw0OYnIlr7QArLKyEgheAfQDCrPrAXW7T6p7kJ/JlBbSslLi4tW1OlgrcZ2VJygO1O2cXePSZf7qlUT4SeKE6xik4gRiz11Fzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZJ+Eedx1TPMxcJCGMfSxJ8xlIW96pIpsYTr86s0gEk=;
 b=AG4APbiIwvi3x7cvfddaz+xmAEcVueY5UaETF5NKgQ89eom4IPwS95fRWcNZ7T1NRNW6tGo90fTzY2zyej6iZAS5AEJL6TB8OsNgKPPQUsLE1k6ADJnLncjyEV94AqIctzco4luHpwlUBcAVFsRwcHy8BN3VUnq84LlPo8N1Syt21BGVf6+2I8T06sa2PLH11cjC/+6kKdT2LelRQjnnZg2/Sy24u1gq5rXv8UJZkO2fuk4bX3Opj+63ldDJWkPcjwW5r34XyEpo/5BxUmsG81XmLh2FdUw2ZoAif6FraeH6Dzy7HV9H47X0OAKdWLCXd1DASRLlPYtF6scbXu4djw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7032.apcprd06.prod.outlook.com (2603:1096:990:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 03:34:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:34:01 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3] btrfs: reuse exit helper in btrfs_bioset_init()
Date: Mon, 14 Apr 2025 21:53:40 -0600
Message-Id: <20250415035340.851288-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: e00835c1-6d5f-4d58-830b-08dd7bce5ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hoViOWhwpSoKsW7Yy4xk5LlBVPDVP62f2s8CztpdDLHp1EWrT5bJNkG/rlnk?=
 =?us-ascii?Q?YyO2q72GkwiAdTWriMmrYhgMj8spVXaub0HP11OuYRviooUu5xzFqU/Red/m?=
 =?us-ascii?Q?g0xDFIiMQ/xi3Z4zM0EwQ/0nZDPEOaZxIDlHApFBS730jCxE5w48Ez7HyO7W?=
 =?us-ascii?Q?617Yvq44XGQFh+ahRP/mPdVN927l32ER35bDqnaBm6387GwFr2CFJ6dRwAUA?=
 =?us-ascii?Q?pJuwMQgOKNlKoXxeJgZVfbISA9z9yxnK/c9QRestsGYS2Wa9d/MyMWF9X/Sw?=
 =?us-ascii?Q?eI/m79rI0sC/5tgx2uUVObXdkTr4H2sjDI2HEEEKbHA+s/JkyVr8fdOR2Id1?=
 =?us-ascii?Q?v4++QKM9LHuLXH3WpV3kvTj9Z6P2dKRaQ+zHejha42Rd1kXTjv0XrpwrgP65?=
 =?us-ascii?Q?rfdsHDG8CxOiG1n1Az9XPQeen1Ukiqnv63Lj8p4z6y/kCLFxiRfDqYlisVJA?=
 =?us-ascii?Q?wTy9NZocdJ5xYyBvYKLqaBObO2ahvkqyri/yvcyTHop7Bh4I23mIHg9sKUk/?=
 =?us-ascii?Q?n9l95eRoEkwNTm2CcFVFOl6hNFXFHLVRdcDUewTbx59llZG4807TNa7qdCnw?=
 =?us-ascii?Q?m7DHUGsKsJDTgtUPLYjHPwz6mNqM/ctybluM+cK6LwSn0bFG6ftFKpaGco4h?=
 =?us-ascii?Q?+t+rg/+epOOuUoS4hwG2hEjJcDLemHktTKLEp6G9QYk6ZlaObXHuZG5kp3Rz?=
 =?us-ascii?Q?j4qr7I4KpOwN5HMMpzxOHlBkbzrJwodfppqcGT0p+4GknIM/i9pJhHxh2rKg?=
 =?us-ascii?Q?E0+5C+NdH8Sqf1E1LcCgQ5JlNZ8V7Dce0y+Rrl59kz/mNjnDd04kQ5OIZukY?=
 =?us-ascii?Q?PwDGVlILamTYlU/486hFYJ//15J4seLcelGuknkSq2JYi7+efeDdBzXSWA6B?=
 =?us-ascii?Q?ScqZsFxavvk9ZEKqfk86nX+AXZNDIK3Ge9wvP6KB9GXAgvCyqQ0aHTcOc/gq?=
 =?us-ascii?Q?Gbl79y6NxDSGp6hdCGsnHrF2Hb4uX/OaDnEWuWAs/NzpnDs8VAxdYerlTbbD?=
 =?us-ascii?Q?UX1Adm/Bplr1sKo4p/yXPDXANlZM+Hnt32BFXmaMV30jAKZ4a4DZKiAV8wIa?=
 =?us-ascii?Q?OGXqze5sEI1vDoMlJ1tnlVDqTAaKLByK2DtC0MQLyNW0CYIwyjZlGMX3jtEs?=
 =?us-ascii?Q?XBaJZwTqa0ro3ex3gNr+1DJmgriYSvdMkuxRvhvA2ZbhFqaan2/UfupVDcCf?=
 =?us-ascii?Q?Y0RJgVn6qY1wog6PugCgpPiAUbU60AR5AnK9sZC25Rcht/g6OJtVk35iXNYh?=
 =?us-ascii?Q?VybJqefePbMz0i+wxl+fmz/a/5byvIg0bAcDmSNTjd49iZidh2eM51aBCdbk?=
 =?us-ascii?Q?jeOahygk8nNkzNsNgQ9u8kPAZmL6LEeXgiS7s7rrrbjjbI7TXONDvqgrKmc4?=
 =?us-ascii?Q?jzLPXYgB4CjqZ/TGd4illFE0C/gm25ul/L0ZeilhEejfj1sWnI3zF6F+5tZE?=
 =?us-ascii?Q?Uq0gzHZiKtW1lFjWbNhR7EhrODFkP223ECI6Be/TsecpjpiIgtEIaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvZERgf2q63vc7fCZdAh8wm8AYvyMuuDVz+KRNwhJPKdK3+zn8O/ddc2L6bw?=
 =?us-ascii?Q?uojA3SVep2WQwV/e8Hzdo/wRkd94HoGdL6wWdyPPykKJL8fNLURHB6RD8Ukd?=
 =?us-ascii?Q?x20WM8klo4h0K1WaT4LFVE0WJ4rh0UeQ0EMGCP23jVPNyNTD2F/g/WDr+a86?=
 =?us-ascii?Q?lrs4Fq0N7+1X8jNaw9e/RgKvea2fcUb2LSKb6f/RKjkvUv8UjSOFe1YswdsO?=
 =?us-ascii?Q?mvZS2prSIIY+tkpfSbjWKq56NIciMDF3J1sqRHwmsp7Kw3ac7N+09+meBDfX?=
 =?us-ascii?Q?nSoP92cUM76rmzotP8nJ88kon+VMsT9mvxu64s2FLt62E7txyWjJ7XiFOTe3?=
 =?us-ascii?Q?xjnZkotvv8eB2PBP5+6ibykhSEn08gdKkfrjlwc4FtRlJQFKNG5lmHIvGhWA?=
 =?us-ascii?Q?yeCm8MtGrPdQeERXQSJIA5nre0EN9Tah9kZKgjvmNmqUcLgBogBFOcf1o2So?=
 =?us-ascii?Q?RSwrDydfkgdViy8ZHrKNkrYZWbJwu+Xor4/8kkc1grM2ql35W+PSze0eLHFx?=
 =?us-ascii?Q?uk0K28d7PwzFwQ3IT1cVKev5ItKuSEVHqFJTS7IKiKHHjwjVvvXeuQDOjfjs?=
 =?us-ascii?Q?UxexqM/U732HRXc3lR1j76ERkyaLODst5MS1qsUtvquRSp3lgZVp6qDztDqL?=
 =?us-ascii?Q?ikWGLpTgaYw9u7gqWZMI/E6V4GoHT/j6kiDzmNYxrG3ZCAUXvIw6H8Z0ZvM5?=
 =?us-ascii?Q?FFoZIkvlxuUnuHQW+7V9fBkHPqf79NsDfo3vRsrXqDOPSnQEcXEkotdkWr5H?=
 =?us-ascii?Q?F2A6YnSIJwzD3UxnR22FJXsi84vjt1M/euElx5anj+y2oiclFVeU5wEihIPj?=
 =?us-ascii?Q?3DPEzud2nEwgU+3FPI8HKxNTcFNgMaFBs9pxLrE38DAm7pwrcU0fwV0dXktM?=
 =?us-ascii?Q?nIcsUR8acVGKcmniRQEUEgRjlbIVQqelmdh2j80zv6HO+/bIC7dsI5ovhzVb?=
 =?us-ascii?Q?UwT6ZtRWuGnSV2x0U/+jWLGD7+3lWonfR4tebKcik/6Zoe03DyDpu6g3VVMs?=
 =?us-ascii?Q?pIffnJq24meDHPN5KIIpdXmpXGlcKRr91lBeLwSyPGaYcbowjT8er23wOOg2?=
 =?us-ascii?Q?ExU/g0dMiDtTSCzs00+Y6TnbWUDfN1m6lC95U3PAH0Lupx9c5xf2U46vRskI?=
 =?us-ascii?Q?CWth2DoSVs43QRSbU+rJx3cPwV6cjgw762r0FWJ/0yARWocowzJZvmuWacOy?=
 =?us-ascii?Q?5Ls3nMcwpYs0W0+St6pf8vUlXtL70s/VRpkm9wyWRjYtkKkg2+lEB/FYP1G3?=
 =?us-ascii?Q?XeDJN6Tk+boq6RLQHOJbhH57Rqnj4yZQxvI9nmYedVDhdvdobk+zvP0sETid?=
 =?us-ascii?Q?YKINaaMyeOFDOaa2nF6BKuldEro3TOBkaJwKf9M22SG37nAYkL/09amIqZzv?=
 =?us-ascii?Q?vOmor+mVBeVPQIV7JhsC7HTmYK36RwkaPrdVEnfH8fn2HdG0U9G+68U80bGq?=
 =?us-ascii?Q?JKqXlFVyqclfAAYC1+O9iHdEbemg1duYujZVLa68j2hU6SX6XBrc2y50PMLY?=
 =?us-ascii?Q?/qb7hPX2dIY0Rt9u4aP0hJ1csHefixXT/d0Uz4Rugp6/QJ0OB/Lb/dgUr7pK?=
 =?us-ascii?Q?kMbXbt2eLoBHFolsGscIsMO9qafctZfs2p14SXYd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00835c1-6d5f-4d58-830b-08dd7bce5ceb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:34:01.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQXAsg/hGVHdSFxpUF9uR9vdkkSbOItv4OyuRG1UwSjghGMcA+GIu+/X+/X9n3vYhUqSWwDp2gKwzCmUxGTcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7032

Use btrfs_bioset_exit() instead, which is the preferred patttern in btrfs.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-add Suggested-by
v2:
-update commit msg
-cancel reorder btrfs_bioset_exit()
 fs/btrfs/bio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c2eee1f1878..f602dda99af0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -900,22 +900,18 @@ int __init btrfs_bioset_init(void)
 		return -ENOMEM;
 	if (bioset_init(&btrfs_clone_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_bio, bio), 0))
-		goto out_free_bioset;
+		goto out;
 	if (bioset_init(&btrfs_repair_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_bio, bio),
 			BIOSET_NEED_BVECS))
-		goto out_free_clone_bioset;
+		goto out;
 	if (mempool_init_kmalloc_pool(&btrfs_failed_bio_pool, BIO_POOL_SIZE,
 				      sizeof(struct btrfs_failed_bio)))
-		goto out_free_repair_bioset;
+		goto out;
 	return 0;
 
-out_free_repair_bioset:
-	bioset_exit(&btrfs_repair_bioset);
-out_free_clone_bioset:
-	bioset_exit(&btrfs_clone_bioset);
-out_free_bioset:
-	bioset_exit(&btrfs_bioset);
+out:
+	btrfs_bioset_exit();
 	return -ENOMEM;
 }
 
-- 
2.39.0


