Return-Path: <linux-btrfs+bounces-12988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00047A88052
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670E7177268
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE529CB3F;
	Mon, 14 Apr 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o94q2w6w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011019.outbound.protection.outlook.com [52.101.129.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C301E505;
	Mon, 14 Apr 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633475; cv=fail; b=X+ILAOaEqvGA84U+/ev5T9rTcy2fGVUVN1yw+s5VgJarTj2gJU2l8EHGNfdvxdAh6H7My2KbKVTEi0w99jCYXzTKg7TPjxOat/VQvhxwUDNkY4+iJiasdoJSd7Q1H4fKJcCZPw0u59YTwbo0M6rwJVNXFQ0C7VTu++DDNd/YjBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633475; c=relaxed/simple;
	bh=zxSq5QHp0MAk/toP0kSYknsb20OtKOcip37MvS6xBpo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eKTH6r7q2J//LTRC0VUTGCwUAS4QOLO+7bXwcDuJ1XeGAGaWBAMQ7b2S8bly0UxvjFRuYkCEkFNsrX2aParlswCZMfYW/LKFca+lPE98ef/yN0C7+JpbPaoCBexSisIFR12oyIWBhNU9X8LbuquK4Okq/IpjppC2rKn2GTCtK3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o94q2w6w; arc=fail smtp.client-ip=52.101.129.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZU6aZx6X96hu+jQYtgT7g1xY5m1Xfs4QZ6JDrU/aGY8/9mb8zZhOdiQ3YD3SDcFdzDIsQ751Hj8AHIqaBu/4tSzVuu/Z5yvrlwV9pDUnbZGaE4AUPTDqiwoVuknA2Qdn9GqwrhPYTe8nZczY0DfZ9UvCK5uNOY/x1rkw7cLhw1Q5nsi9LzegpoGye5AZucQY5S+0xzKs0ojdO1KHS/8rSKb+sBelC+ie3xk/s6MzGOeMCzaEgNmQwxSDbdA2NXiGM0JuEArBSU7nb8FtKWbjAuRgeRJUpTI/0V3+2MYFAn9koXbraeqMtJzVHixbbIJzqalmZzIlubz2AYBKcYGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQsym7/tp3W+AKySrYNBVGZPvZkWRUeoLGSamGcALQU=;
 b=zLvEb57hKIyCZVatwLrUkM4xellEYXw9tm2Hs4g3QtJitm0D4HzsOF1XMQcrKTcTLq17qEehkocrIEelfqXbLvux/PH6ilYyLtCchxcHEeWc+G0TUg+XR2+QLhHDvCmpklC2+vZDf4fYj2wp0NDmIENZILqrQqZi1zjIya3pRRJdmvN/dnLVK2gOBNsnkUQVw5LeSWMrUR3bAySKSJ4wSeMJ3Cfqb86+3a6WDpEs/oolRq4yDBRQe9b046T7zyK6eVU32K7KHMOAE7ds9ekvYBk+s/y13/spgoZOiPLRDVq+fQ9CaLiilxvmiIVmo/Z0+W303znPPgX3s5xUBMc3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQsym7/tp3W+AKySrYNBVGZPvZkWRUeoLGSamGcALQU=;
 b=o94q2w6wK9I74NBc5r6VH2biRDt+cht8K2KruaCm2Q39kvITRfmtICqWFKYdjAy+/MELpWThf2rGGdBzMvxPRfw/VBYq0GW9TBbq50dBeQRlkVq9GDq5RYudHoBKVEx11/J2S6ERw5my3u1UHjE0pZkFUy8+UVHLyuEppn6I2RA1prPjL+fnfdiEvq0BCBGwzO3kOa/7h4qYGxnR2pDSQfVLflBkIdMUROlFptvRRAcwtwjpUWVvL3H7WByMNYq7XZOA/P7TBO2sMkzSabnNA3WPLplaJsoXr1wmvG9kgK7akipigOptVqdUmDtxR2FwfVI82fyh8MXJKZekw0ph6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6321.apcprd06.prod.outlook.com (2603:1096:820:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 12:24:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:24:23 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] btrfs: reuse exit helper in btrfs_bioset_init()
Date: Mon, 14 Apr 2025 06:44:01 -0600
Message-Id: <20250414124401.739723-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: b683baf3-6e05-4469-7ef8-08dd7b4f49f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QhqNqqfgbEtgtTpd92TPx8qFL7lC+71O3mOwKIFGBTH08efdCaVynnpF3O6?=
 =?us-ascii?Q?+pv9Um2jDpA/KqKIf/e8mpzTJnpBgO31qlmCvzwQxCzQfGvh8CN1jurBi3wy?=
 =?us-ascii?Q?ed9tnlxB+B62rBpXE0bX/nrB0Cub8MgroLJTME0YTCxIO2JFUv9HwUJuDjxv?=
 =?us-ascii?Q?Ix5f4AAlDuX38IHMakKn+pPqcmTHv4GRX8tfFHNGWiB4LeEiKeHymSheCQsU?=
 =?us-ascii?Q?YPqPtrU94ItnlOVzZks2PedKqAqSlTFwUUSAvmN3EGNPQ9o4LsV0RPY0R8zL?=
 =?us-ascii?Q?U7yAVYVf9UGdzIzbaTH/gckMMUJD83AcJVtpMOi2XSdMSjXkcm0+ZwTkNc/h?=
 =?us-ascii?Q?vO8enPPdtQLQrviGz706ztycjjLgE4MfwB3yK0BiFbmb2msG6NRjWLNYg5lm?=
 =?us-ascii?Q?RiROzkLlzhF4JN1xY9mWH5Vkl7cLu8xS8UwXawChd1d+elKW0q4YUIF761Ir?=
 =?us-ascii?Q?OR9bDWuzNEHCjslbqx13JAjJuZ9YNngKlLiDXEzVecoKNYCVY0AY771+23Kd?=
 =?us-ascii?Q?+dx/hJDkuDFktHFfMZDGIG+1klKF03hVcelJ507TphZnpUgo9KSB8rXy9T0x?=
 =?us-ascii?Q?LDpSk1dX/Ch3vfjiy6TmMCyCqhc98D19doGG+UIv+UAVHvUmkewT/QmlPKTl?=
 =?us-ascii?Q?2rJfqlXOiO/J1hj3Fg5+10JqaSbEMfLHZu23OjZCANRVDoV4h0eplhACFil5?=
 =?us-ascii?Q?uUCBJp9mDP/6UaLSbItutnJarsW92qKhBXgshzEGGs1dOvdJol0FNZjdtAA8?=
 =?us-ascii?Q?JLwL4Ve/2VIElFoNEj0gcJCiI9fLM8LmbzpPjY096OsxwZSEnrhfK36cvN6p?=
 =?us-ascii?Q?bgntAJV3Pt3MrLb2tRQ6dQwhoL7eLYG4y4DWSRKMGjjpzGtNRSCdNNR4CHSO?=
 =?us-ascii?Q?LHC3hmXY/Rf08R3J9yTexRKE5L2AjdMl7HQuN6UQoCyZHf0n1ZBOecYtDXvW?=
 =?us-ascii?Q?XvPtYqTA8rUj5aP2i8BXzduErC+HpbclIXbQCYndJrL0iZANdz6A4cPOhFsF?=
 =?us-ascii?Q?9Ecv5/aA6CrANbI9n6xtqNVcc/oJ3LuWoNyI6Vv6/S/IPc7kzt1sO5B73CmG?=
 =?us-ascii?Q?tIOSi3ctJYcA5lxQBGiTD1w/QEd4bQ7HDTtgyq9ge34rVz+SntZV90EttPJp?=
 =?us-ascii?Q?hMHPcs3nCka01gpfdZMY7nuJ2QajlNCrtyl7eL7wLiV7uDQWEeAa5ncLJnlM?=
 =?us-ascii?Q?NldonVaRBYMnAWDpi6v52+CUq7h4ZT+skpjgdlr2QJghQNapVm1nw7FmDZbS?=
 =?us-ascii?Q?VaGxAcrnGKKub71mnbLXKFEwt2fvdlB/Qb/ORJLrqR6Whnfap0VaChClg4NP?=
 =?us-ascii?Q?NVZINjuL8YkRC3CSDuqvWtKasIuA2F4q/L/xo41bLbLvUfEi7LH+iFiyQfqx?=
 =?us-ascii?Q?/pN1Msovubj+msDXDzVjXRWRhQkOVhjLUvtXHmf7KUX94Hen9n6MsT5JIAPc?=
 =?us-ascii?Q?8ZFk4MkD/xuz2ANEUI9AdmPGtVaIkm5jNaqTCkm1ZRW8O9IPGTuAvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xagh9xFnldemUwhx+xOgwZgMS620qWvVxgfYVwUaafl+eeXhZ/K8PQ0nDT5Q?=
 =?us-ascii?Q?jDkqRKu3a7FQRJFmJOCBUo1L50jLZ5t6xaGYNT4GDFjQONbcBrS2YxGm6Xv4?=
 =?us-ascii?Q?lvKZcccK6XngQhWVXI7sCOgQ6srTR6psfiIs6Sh3R1lKZh1xBvDjykX/IQLf?=
 =?us-ascii?Q?ZmbKp2HnwYORnJRQWEOlPgtCCec6MzsAtqfEkcaYgVRLbg9lF3LhjQ/HZATZ?=
 =?us-ascii?Q?JrL7biSjqA4dK6NB8eOx/m7cs8en6sBhYXDcf4qZtuPBUD6qdqt8rFLIeW0n?=
 =?us-ascii?Q?42iTWj58newsk/HboQtxZ3hfL8i2mlQnamyM0R2rdwEpf178D3JC5gZBisfe?=
 =?us-ascii?Q?WPA9N2YWqFNnW+jR/ZyhtzZr5MfCsjpBnP3IIRd8KA3nCeV+xkD5iYJVvWW0?=
 =?us-ascii?Q?oDMyyz8Wy462waRJydFixbyilUgrFj62CpOvtyL8pNz9TK0TH0DuB4oR1Dnr?=
 =?us-ascii?Q?v1Yr6bCiieM+FF0SPNXaoFltA6GTMiVfFY+2Tij6lHIZ6yE2FIqZqRrZo21G?=
 =?us-ascii?Q?sPd7XCFvKjLlfVOjAjg/jWZDt86F9U5lMzUNYMCjl1MHE1+eb1ekWZ3sKolL?=
 =?us-ascii?Q?rwzUcR4/8M/kp+hZqhWNeyH1sL45/lxuLsQgE1bOrXGaEfZ5In94E2MufoOX?=
 =?us-ascii?Q?YFjzlHuSnBpKAzjDiKtad78SUe14u86fxinaOZ+cHciqo4UOIjcihvbY3Fjj?=
 =?us-ascii?Q?7cjr8VsF08UH29Jk5LQbyOAvhuLCx0CYBDkkzj6MbvRS3b0W01UCZz/P0wBO?=
 =?us-ascii?Q?ffHJBxNaETQSs9lxsBPeNfwWKRBMZL7eHi/kJcAcCwFcXFwxjpcoL/no1H19?=
 =?us-ascii?Q?ZNOsie0gnSgG2zlf/6PuQO3yXarzeeBg1bf2Q0DrTTzpjW8crq9UauevjJ6u?=
 =?us-ascii?Q?ZGX+QOTig6edcfl+3MdNZCC3BPgFfLuTeYN6pI/XvciR862riuJ6UlVgrGaT?=
 =?us-ascii?Q?+vHx2Khopjx6wxfEOuKtTXGmFwWpFIQ54FWl1+AJO/Wwif0hpQE6eaTSBrBw?=
 =?us-ascii?Q?sYysU/oOADFcGvRcHC4NcNePosD7Mw9IvoletKau4LPvNdIh4Gr74ZYTmDNq?=
 =?us-ascii?Q?05C70nf+s5vUUaA2igy/qD6O9ApD000e9QitJqdUccMVqSmxxeyCRXvaJ4Ws?=
 =?us-ascii?Q?PDl6sUV+Ig/U1bp8c+9Qo1WCMZb4+WWsuaY4KzOTsgCunGOyI7AOXqIXSoiP?=
 =?us-ascii?Q?RdfGWzxVXlzYnsek3ULIqZzrDNpbN9EV5fkx+n9KBmzix+bLi6a1VEvSHB9V?=
 =?us-ascii?Q?3DwsAg1bmcKeye17JOrLG/EC8ZCFbo8alnWWGRqryVQS+dl9GZnEjvrwjJIY?=
 =?us-ascii?Q?03jJcFv+/KtYI5aRS8zmQJe//VNvr42fkUzaF+UHL3sc98P3cjxQxNUUs3Yw?=
 =?us-ascii?Q?dzyYQOhcwJwGwiW7olKKN6/Eg1VbbvSVlgtuNm9CtaKg57t8B4SfjEhrrWBe?=
 =?us-ascii?Q?9pyCcnyyQZK1aDPraxn0cjMdAgvQ8x0fsGy5hr9p5PhLFqz1JGtzx0LRI0lX?=
 =?us-ascii?Q?97YbUjQkWQdLIR7d7wNU8tAmCiU+Z5ayje/j1cMun2uvBDBp1N75WKKtSAce?=
 =?us-ascii?Q?BoVTB0um5eNxxIog28ggdj7FgvLyP6ZKNrkJ9dHI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b683baf3-6e05-4469-7ef8-08dd7b4f49f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:24:23.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgq+vYadRBGWPKFDFnRv3F31mYpiZWVKKsBp1cfwInulKKgms0c+Wy1feR+cLJwurYn+uRg8g0UG5cZsyhHGmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6321

As David Sterba said before:

  This is partially duplicating btrfs_delayed_ref_exit(), I'd rather reuse
  the exit helper.

  I've checked if this can be done elsewhere, seems that there's only one
  other case btrfs_bioset_init(), which is partially duplicating
  btrfs_bioset_exit(). All other init/exit functions are trivial and
  allocate one structure. So if you want to do that cleanup, please update
  btrfs_bioset_init() to the preferred pattern. Thanks.

So let's convert it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/bio.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c2eee1f1878..f6f84837d62b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -892,6 +892,14 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
 }
 
+void __cold btrfs_bioset_exit(void)
+{
+	mempool_exit(&btrfs_failed_bio_pool);
+	bioset_exit(&btrfs_repair_bioset);
+	bioset_exit(&btrfs_clone_bioset);
+	bioset_exit(&btrfs_bioset);
+}
+
 int __init btrfs_bioset_init(void)
 {
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
@@ -900,29 +908,17 @@ int __init btrfs_bioset_init(void)
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
-
-void __cold btrfs_bioset_exit(void)
-{
-	mempool_exit(&btrfs_failed_bio_pool);
-	bioset_exit(&btrfs_repair_bioset);
-	bioset_exit(&btrfs_clone_bioset);
-	bioset_exit(&btrfs_bioset);
-}
-- 
2.39.0


