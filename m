Return-Path: <linux-btrfs+bounces-13020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0340A89287
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0864B1734E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923B42147E0;
	Tue, 15 Apr 2025 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="baqE9/pk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AC20F08E;
	Tue, 15 Apr 2025 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687773; cv=fail; b=lXyxy6ekZRzudp8vBojLDAalNeIePCFzVKvKs5JmTw6P9aHZoDyHwFL+7avgnDm7qi9Jo8FEx/gnqrONF/gqmwcy/AgfU91xjnGwfjpndrSymepOPj59RJZ5RVWvi/xI1/frqU15KNjvtRrw4vn3ruWDK7Q01pzYhCpJ2l7hRvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687773; c=relaxed/simple;
	bh=TI0CPQ9XQDVNGFTFrK+eJAqAK+v50HOdioN3n8+YGl0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y05booq4Kdp0zaWU97BsSsWv1ETwzrhOfn4G30duVmrWJ1v6doywMo5x9ta92tNqoD5hTBVeO23InxQeutvtNH3+qdlwI04WjY4RVxPouRTiE3A50ZbizHCRtru49lhBepfStyAqQ7jk5qyaPCWy5YQkTccfR9oRlg6OZ8wFhuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=baqE9/pk; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O282CmctQsfI3sFc0fQQLdzYpylYdeClt02LGOt0PekOemoM1D5WLwmjQiPmwdoQOJHD4Ux5xhYRpS+Et7/HqWlIJ23PtSGle4ACSHHOcxsmFXe79/aL3rirds6j6I9GReXy7VIrBAt64fVdxud2vcyHttG3Xrhvcu4H4nQuoq6RBlbLu2Yct8Uj4n63/T1bmmPDQFkjJNmuWDvQxCn9MYlSQYwv/fYaH6qsaC9N/Y8M1gV2SFNc2VmoYtMwLCGJpES+HDv/9yOnyeka9mdf7zKD/PUgiTz0SK/08j2IF3CbvR90MiE2wUGfPHF0fdrxFJHuyBPD7M9q3DLQhl7ZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxSohK3a1wI4XPZsDOrWbXv/+3vPp9uP+CJbVjX5Mlk=;
 b=l0jIhsNFGyl/hhekuBWDGCtj4QmimOdtwDCsRE8Y6cW+SbxSqwBG73azyAUk5JU5Ax0es6nU6Q9GXxrWzKIuz6lholL29hAXpLXgyzns7jetIXNYFzbR2YvPF9n+ua4Grsjekkco5MnSeH+5HLQIK6OyNw4kacmzi3FyctsTCDO2tVXW8LLftvO81zjcEGVLCBIheMSsMapfV8GrBuV80YJX6diFylIUlOilmB67JXI7fPIWndPHpLaFK/yJ5rOf2in5/XwS+eRcGUq0AnxqlCD7mnioB6dnXFAO0yZlylx8ywJCKqbPtQ3aVqwnkoUOAbtmIJyPmQzTZXmlxIuUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxSohK3a1wI4XPZsDOrWbXv/+3vPp9uP+CJbVjX5Mlk=;
 b=baqE9/pkOLyibYwcmaShm3vHH88udmDFfhHZ0vnoHylxmmct7H4gtJz5VFh9X9DwZZFW942v6cuz3Yaw7+NhglyASV7WzsjBpDbsZBOy8qYoRjKkrG1QHWBWXjLDs2glAEnSSQR0a2Tir9vprRQ2Sftn/KrvNECPefp2YBjQBwJGzGT4jfOZQqNA/kbAFRSL5VzVIAd9RyaPC2XJbO3ALOvgozoJh0cM9EJml2qdVQ4SIc8tbRzH8OP46Osaeav10UD+b/66wxKJqJkt0FI6nPnKEnacpGkHGema9KcDsf14VtFBuYK6jGxyzLIfdktqt64l/x8RS947L3d/8zvDYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5961.apcprd06.prod.outlook.com (2603:1096:101:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 03:29:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:29:29 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] btrfs: reuse exit helper in btrfs_bioset_init()
Date: Mon, 14 Apr 2025 21:49:07 -0600
Message-Id: <20250415034908.850609-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: d5393c72-03f2-4ca6-b2c4-08dd7bcdba9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4ojkJtitxBP4zwA/K+8ySW1kw/t2VpIadJoxbZrwdfYLPh2ETjs3HnsPlrW?=
 =?us-ascii?Q?JzEO66QVwf4PoJsmd/PA2tlcajkbRIV7OMQ1gRLBEOPcWGljxSGW/gyQ+XdO?=
 =?us-ascii?Q?YY7sZSTgXlHUGtQOWQK/ic6+j6ko+s1hGwQAXta5cr1IIrv5XEZ5SN3iUbI6?=
 =?us-ascii?Q?M5xwIBpymYcLpbbjnDx1KBdJUHfY7xdloy4oERJuQPjAB5zIp/fxeS7Kn/QV?=
 =?us-ascii?Q?vBpNvRRz9hFxye2uGfSvAJWWGiyhj1d5ErGx2FdDE7AHqMWJfptkr6ymrRVg?=
 =?us-ascii?Q?Pb9+h5qs1HMhbgfefJ5XqCMISULQkxpQOhGSDkBDTQmfAO+bn+YIA70gn3zu?=
 =?us-ascii?Q?cdiH1apPwtNcjdAuPKEOuzEqmSKiO5h5TGFuI/UwHgbYKqQTMX/sBx3gGQCw?=
 =?us-ascii?Q?C81qqBYSAY8hf87PhN3yaOUm8iU4Va3XZgti8hOfKrK2GqGKbtuoMnDN0LqQ?=
 =?us-ascii?Q?lKI7gqD0XJmlxmI6cdjVcEfqbBvxp91k1x8dsHvizyYf+DSsrYhX+B5/kuKS?=
 =?us-ascii?Q?A/+Cb5SWYFyK0wjVghmDuHaYTdL8h4hjZc0j1HHxwRlCEqrPS+w6V3nF098Q?=
 =?us-ascii?Q?8JDK+zXvn5ZfhRr5/ubsfpIw9Br7B2DaQr7zotJD2MsYHlWtQ4qBs1gTW1t7?=
 =?us-ascii?Q?oK+Furtf9xQqPb5iK6fv3bVqnDWnwZBXoi6OPUTbyID0DE9yrE0/kA7lW39I?=
 =?us-ascii?Q?tyLbuPwjrxjvGwn7eacOlZnMTZztf+V7pIm7Aq8Du5Y2/CX1S6sljWArcG3r?=
 =?us-ascii?Q?GARFAcI9fmUUqYMiP52l1cD5GHygUpjvJv3jWddpTh0YPc943BZw/AoPIA4a?=
 =?us-ascii?Q?tUwOh6HRaQk82lfo79v6LJSkkuwQC+/EbHwPVIx3BMNkkiQ/2OXIEcbjClNC?=
 =?us-ascii?Q?KMuShR6SQQ94X4tbx/axshKfFqvm+LcJWP3hv7ckdS3Xd1gy4O6NC8rSNAB0?=
 =?us-ascii?Q?LFWbKuCkqMvLPxUQEB0pseaVApwCu1B+bTORU6C6tGJ/TvzjIeErMy4rV4Qa?=
 =?us-ascii?Q?JrSq79MOCShiYJ0rp1TwfS+mFnea4C5YtauDkbUEjrrA1qQgEbjsnPb0bWm7?=
 =?us-ascii?Q?twohlU6fLdU8B6R6g15BCoTFzscHdqnXknmg1cMTU0yGQs/2Armz61S7CksM?=
 =?us-ascii?Q?vP3w2TE7HZhu+/Xls5exVZQ5yGOFOwuLc+Mkgiy/S8KRlcLIZzEuzRjRQNTm?=
 =?us-ascii?Q?CjNLfUNWAgP04Zry/hPJ9FWOkdboXaoGKkjvzGt10LoKrZG6mYl2oQrEnO+i?=
 =?us-ascii?Q?fdYd1GIhyRVb873L/6ztwptLCwDNR8/UmjJh30QtpOEF7noO+mqVSr2N2IjZ?=
 =?us-ascii?Q?g/zUQ9DhO4DYv1CI+PHUvwl5ext4XBKBQuEiyHa7yiKvKCNoAjoqcPBmEl71?=
 =?us-ascii?Q?LhFdaAoqfoI4KVagQVlGPfiePg0zsvGVxmkPyGUWH/m9M1fPjKipybVdbChi?=
 =?us-ascii?Q?RvI0EKgWPPnSBEWy4xauxPVVBqFIYEms96tAPMgJtfY697dzbW5R1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSAJ+fQqQbu+BjYlmUe1OeQbMJDo3h1bTpc9iDuppNu9fDf7LEYrFTMRcs/R?=
 =?us-ascii?Q?zJTrIJIx4nRGAS8sz1hL4mModl+iE0mAmNc94Ozu3lYlibGACH75DZzyXcAS?=
 =?us-ascii?Q?BQDZ9DPTFWc86f7C1JR5PIwamw6xbI7MdFGV6gqVCvuKIhAPJaWzapYiJP8g?=
 =?us-ascii?Q?Tr9cRfs+soFSMdbEfKvUkxxrPBGBIsoVDvG6hbSIqLJGczPohyDhO+UvsiBP?=
 =?us-ascii?Q?cSFssodcChxUzCKkKdWoMfkk+9BRMPZb1/DMdunvFt6C3ZApDOtJJ0r5wHdr?=
 =?us-ascii?Q?BIWX1uk8T82Fb5AKoRr19OuFIW4jcDQeZ61Yv6V1OAE8nkK5KLhLE9efnjaF?=
 =?us-ascii?Q?39pJLnfA/JM+Lt+sc6X31uJidUlsDsJABvDBUgP/Otw8jRKWUUu+diUZIfni?=
 =?us-ascii?Q?6bFQY8+yxFbnmC+p3oYyVAT38+YQDB7Mb/Dkl8CTx32igjzGdcA5SmDCzqrr?=
 =?us-ascii?Q?PfFcsi3rApvhNcaBzGhvVg9IKsN/mi/0NqQFwAbKO+00JEq7itnIqv/LD/vI?=
 =?us-ascii?Q?EEaEO5HWe4qiRt2edv1pjt+9XQCPMD+9EnwcRsfAVLM30YadoyVTGoiFFQTx?=
 =?us-ascii?Q?5eEdvvn/24K8uI0AxLB8RzT+E4CKK4cIkiEDDji+lHsF52We4PpotWmyOhRZ?=
 =?us-ascii?Q?F2gSBeeF2LH1ZWuMJDZi+AmNc/2oZClqxXIT8bdBbp/iSODMzDkC0Fw9dEe5?=
 =?us-ascii?Q?ezcqavXpwNuxs6TKrD+Y3iTyfce0ePKmwK/fNyU6Ew9QWF1kveLZlMQGnwZY?=
 =?us-ascii?Q?kUJgqmaCZsTBrmW2kkbtXPhoaR7P8F577vRvgyC+OnDjmAYYpkMzOaPTLQUP?=
 =?us-ascii?Q?4lGRqV4kHvH6v3+wOlmIn7Yk/EpCBv1jKQapDIJIvTGRbtd10Bj5ly2GJev9?=
 =?us-ascii?Q?ED3xF6KUbTC2nkphnMMctSmp+YhcEXjh2jp7y8Pqz5WixcIbf+W9EQSj+272?=
 =?us-ascii?Q?RTDJUOyDtDk1dbPT305gcX0s3TB3szHvvVQ3AyVGDxvcqJw9BBun0Clb90p9?=
 =?us-ascii?Q?4m9FkSKuXQdPiMZDZS8eP7aQCyM//4cwQkKXk4LuGadSQlSOuHP1Yhg8u53v?=
 =?us-ascii?Q?cdCjnVauUKtIU/yuaCivs/057+5IEBTvVRsciK/hmWOUGlh78iHIBcUm+wrh?=
 =?us-ascii?Q?SG7Np9QjTppuaMlPqRWbQ5qASm9yF5AQJrqLLNn6NlB/wdzydgZQTXTDuRns?=
 =?us-ascii?Q?muSvMu8u6Zfyc8z4V00tw6Sk5sRPxTWTLv9tWAjbAo1rafwcS/oKEiAbxk7+?=
 =?us-ascii?Q?ghZAFtr0l3aM28T1tntPDQc4mEBkCkes0FNyYpsrHa7TShyXTZLQYNeF7uci?=
 =?us-ascii?Q?WFVofWx/Apqka4HpZibWzqxMbYrrjT67NJh8dVPMKqCXT9L6Tpmox7YxTiwn?=
 =?us-ascii?Q?INyMcChguoKX+t8Drrz4Goembb7r/U4fg3J86AwXt414YFim1p4UBKaQJNov?=
 =?us-ascii?Q?wOGxWU7MP0cO7rjieRtCLOJtkDl4sDxNm/si4hCUuzhSsaCmcBZvK5frpMAK?=
 =?us-ascii?Q?hhrRjJW8+SksOCMIaTPbWZ8dLV2yARjWmEsQBKFIwDFVcFrAM1fpsIRSIvtW?=
 =?us-ascii?Q?pQLU9JSqSZffOpcU/o8LTxIYDtVPVnWz3UFEbjJH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5393c72-03f2-4ca6-b2c4-08dd7bcdba9d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:29:28.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD5uOR9msbbjjNIOTWCdrQvvgEtNSe6e6tX9yJDWFTa7kiA/pywdLCNx/1168nhzPvIF8abOf3UJxJlnwBDmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5961

Use btrfs_bioset_exit() instead, which is the preferred patttern in btrfs.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
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


