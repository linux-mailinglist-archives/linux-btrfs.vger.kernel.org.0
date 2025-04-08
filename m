Return-Path: <linux-btrfs+bounces-12865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57589A80586
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982A01B81484
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223026E143;
	Tue,  8 Apr 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kn/FnjVZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011049.outbound.protection.outlook.com [52.101.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0B26B949;
	Tue,  8 Apr 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114215; cv=fail; b=bXDJBxGizNOYz7nwqRZD1nPWCrzKCwF5f2ldW2U263LyEaLb6jEH1pM/9TuQcJRx7p4a179RgCt53ODV4NUOs6sbg+DFLjCEhBfuDxee8laejgnWvZatZJix9A86nxqMSclPF9QfBmHKmoP4+TpqgpFgJdNaxS6GAjXDAsZ0RAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114215; c=relaxed/simple;
	bh=Lso2ZO90yTR/MXe8I+087qwcBiY2f2QxdnHzvumbmsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVNAaMBzZmQs6we1Ewg7yW+AsWigs85pw/lQk6NYjLoY/Y6UDQIuxHGkGTIrhDQG0mbC+uB7RNMW7x1ouLW0T/61hdZILhDs0J6DHjlcWB/NuBR/soiLZthB4Q84tKHx2hBTtkDdLiPIWZba2ow+ZOUlvV3IIaA/PiNDVPkEuX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kn/FnjVZ; arc=fail smtp.client-ip=52.101.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClUyXv0Wf7hbWtRJf3b5+fJylYhPOcAsM2lZY8V0T5Cg+LOmMLcuXQKb1TDRdsI23zr2ng1QelWi+CO7cRZZd2vCZfLw63iUKJW1pIljS3vL7sZEDF1DnC3kvMJr4ESv8b4r2omkblyENZGUju1eREq93Y9IrvR/ARx3QlCE2b/y/2QKzOdSX+5IfPFBDrdHty0qH0CGpGn110ZqrKZLg5l3ZAQsRVtgsuOiL+a3+tsMFNGiiDYlrxOnOr+dtj8FqquYg76UXu/cVp0D7HhWqpL/rYCmel4q4mGowUTuLc8b1+rqTKl6lFJpV8g8hsLrp0ckA7w0N+0XpXL+DT4x2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zzX6s0uU9xYB6dFRY90xnexXDuGXq9pb0ZKzGhY/XY=;
 b=V4gnxacekPSVszGELEwppBNLhnXguYqw64UfWtppRNTGGjM6H1jkoS6an9Cij4mZJzuMQdIffc9KUqTB/AsRp1rRwGZW5HQXdhcMEoju5qG0/pmsTzrTOIMu6znelOgA3Ukomz8UGWWH8IMT/i0QwaTPRmWfmUTraGpkaGq+ERy8+Lu7bvt/S0kQBx6+Rz1hc1twwaKJi+IjA1Kh28KTvcqq9bNfiEFobmTDh928tJ65rPCePWWLjFSOuFwbadMUl/GGZI478t4CjAheb0+8Cdwiw3XkB3DDNGM8CvNGuslBTliIEVntXZ+sSbd71pYkI23tLVfCKpWaiuvK0QRSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zzX6s0uU9xYB6dFRY90xnexXDuGXq9pb0ZKzGhY/XY=;
 b=kn/FnjVZoCYufarELe3I/CVX/3s3VnLnfIcOCKRIFke2JhCWJ5RU7T8AVWxLU6f+w4AEo9JzToccnCT+zahRzMbc2Mnj+9J0l1HUfFp1XXyjDinvxDyMtscTOdQ9wBoaLsBzsAjiNP+x4L7fnOz7bE2HErHe65r2XwusfHCa7lfdsiHPxSvOAXbG+8JRenlLrPoci9gjnJiFmWqyNh12NdnMB0U5QrUw5aASwV43xbmjcy/RZHwAtU9KBtdTKKXMl/eXka4rFzDSDzO1/9/4TjTfSOpy5DwE6zK4llezHgAG98HC7mtdYlRKcTsuaiv21ns9C7x+bnUwNwJ5U3UvSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 12:10:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:10:08 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/4] btrfs: Fix transaction abort during failure in insert_balance_item()
Date: Tue,  8 Apr 2025 06:29:32 -0600
Message-Id: <20250408122933.121056-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408122933.121056-1-frank.li@vivo.com>
References: <20250408122933.121056-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: cbab4f72-7104-46fe-06fb-08dd76964e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1gh3oSaTNl+0Pa0wYYDKmqILD/nZ09W1zAVYia2V8HkCEyW0S8Pltu8G0Pu?=
 =?us-ascii?Q?+/qozAhJACme+SqO7ZXax33Or3k8/Aq0LzR2Qqt15JghhdaJQgj5teMNTdn2?=
 =?us-ascii?Q?+OW1et+s175yl9eKZySfEmI1Fh/L/Oh8DTbmBmt/sFs0IoerVC73chtqAZMu?=
 =?us-ascii?Q?uwsl6kofoEzMU4F+FGrRYwPmGZKktEgtgDlwUT/opJ+XrAFu9kIOo/cA2Vou?=
 =?us-ascii?Q?xrk+CxHUGQexjLVUbICTki+uxm8Vr3fY3jg0jtsrEGoY/qIBkTxBGcg7ZIeR?=
 =?us-ascii?Q?cbz2j+dLqNMUGGcqfqjaiRGyf1rhu7BHl+1HmsqHNXc4lR/4+ptPhIO+2t87?=
 =?us-ascii?Q?LOOHEgujeYJnZfgvXlAyipBFmj3bA5kBISApBs0HK5dpG+kOo/omsM/KV/LE?=
 =?us-ascii?Q?0biP4l2edMiDdZnG5gWZbeXEQ/4gBfVliXryBi0HDrdCQDEuq614y6Q/1MiU?=
 =?us-ascii?Q?LbtobnNg+w0DuHiIBXjWz9+yb58YqVMAArFbp7Kx/jrjwUJNR8iSuuYIESga?=
 =?us-ascii?Q?ytIF0Ux+HvLMGdXWjdum7rHSV5h3u/2vTPHuvzaibQIiPu+NjY4J46xZ4FuC?=
 =?us-ascii?Q?TAfU47Aho57oqMeO1IEmeqL0aKoNr74CA1YT13Zjbl49NVYe2SwSCldcwn+p?=
 =?us-ascii?Q?do6C2Q5REkAViRRGmbPT+u/4p+hfaNRt/WvCaQ+hSUGj+/QjbzU1k+2JJtAf?=
 =?us-ascii?Q?PjvTGw9ZdlctpwKwPHwlVH3NdqbuqzGPkPW2dYhjnNb44/RUJD3cy02ZPNRx?=
 =?us-ascii?Q?Gb5XE4ZHluOXP3Pd1lbWd8PfY3JKVij+kjyZ820GH07Q1NIdc7ERX9h4gLag?=
 =?us-ascii?Q?3JUJHvOVejDBmWpa+HDExUDALToimH3m/yVtkTC3QpLGfbAAMhgn/keeBQCt?=
 =?us-ascii?Q?UNsrEELSfUQpyvm2PsMyWolbK6rQME/uQaGLA1PXM1OzYa3i4mrCuDwIDKfx?=
 =?us-ascii?Q?0jCVJV/HW5h6lPpfynQTz0eNWFpKDOh0OTeHsLr/VfPRXVnujAC7lbYZkBsZ?=
 =?us-ascii?Q?Ambim9E49tOKRVPR7bhP0r4ZMmfjrXi+KVZl3C2kCsiB/KIyHvVI4H9IUXRz?=
 =?us-ascii?Q?7muXVe0VauV95zCeYGiuNSSxq/GUZ1vRM61hCf64HG7gt7ZEir8RGsBLq9Qz?=
 =?us-ascii?Q?REJ5mChAo25CEU6/uE9C3s4wrWr2PXUUdq0qwCA0pN22MXzZv82W3WT9wYFk?=
 =?us-ascii?Q?c3Q54caqdRjrXKPN1AFlwJ+eUaKa8OhzPXmmSkGbxB04JN77oJuoFlZPna0Z?=
 =?us-ascii?Q?JEprEafnpxVUWFms9AyXED4DcrVwlzu+TbWS7+La2cI3dk/N+trtL7Ss521w?=
 =?us-ascii?Q?fPLEkQsIIsS5lWp3RcBJxO3GM/LpwJwcqzDU8tG+IWCWkpnrinGdEvE0FkPJ?=
 =?us-ascii?Q?Y8JOdr7Mf22VE+mswfUnK3y/Du2Bxe0A51t1Af1IR2XUE1icayb3UFh7Hz3e?=
 =?us-ascii?Q?mqPm3qaoPrFUjdRk75uNI8aWj6dhiav6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLtuQY2zmF7v5jMyQo20H+5SipXxfLhQ2fZWZfCka6nfhPhS+OoxPlhdgNeJ?=
 =?us-ascii?Q?VazsVHdvQlfjelEu1hZdv8wtcTp4Dfpct1c7yf4eIoz9mR1FDZsRfSENr1+N?=
 =?us-ascii?Q?X/hf+MuomniATB0A6aqA7FCQiKZp+5KwW7AZxJFicPUlDumwaNe2z6pvE4c6?=
 =?us-ascii?Q?uPWoCSuq50kXhS3xQrNuZohiPGNDIAHQEP7PEnpbyPkEMhNMYN+qklTVQC5t?=
 =?us-ascii?Q?O/oTGs/ab2yQ/kCqO3IItYlVi+nm451X52Oa5lBnnlIUWCyMGQTystkr4dtp?=
 =?us-ascii?Q?ouMWE/Bz+aeHq1B52zVHnfkXfSmO/rwyMw8bzIeNYZdksJAnVyRD7rLVAWmh?=
 =?us-ascii?Q?JWZgOKZYIQcWYjxyZBvEsPGXuCl5LwHm2UD/FfvlY/XgTPoRUj5BFLe6o2Ke?=
 =?us-ascii?Q?fhnO8CEXwrmHIuDghNYmfQBwG3Nfj0Ar+M7AJ3ATh/CXgj9xNmW6hSHcLOF8?=
 =?us-ascii?Q?/I36rXXaprMZxqEyLUcG8pwsjiYQa0i+lmTTlK2XgY9EoEgwA4B4RJ/Pc4Iz?=
 =?us-ascii?Q?vt2nBF13MelE5nGqBJ6uy+lDtNGjRMAcnHjReCXv14HAN1H3WEdzml+ahfuY?=
 =?us-ascii?Q?Ju/lNbLTTNV0coI2bsps8pd8wI7u88TFB6HwKOM8X9bcaFRNFeMvGdyYiB++?=
 =?us-ascii?Q?D8ELbuUiqN8b7U7nPZMZ1zf01VWSwpbtfQjMhw1QKVmLVHZ7LlBz+PXnx+l9?=
 =?us-ascii?Q?Jv0VMqKKKfuil1BrW+1MknkRKWgSnbdO5RPpOwQdywQfnt03+3Vq6XnznOkV?=
 =?us-ascii?Q?8edvO2RWZQJ1pIhG/2GtRviyevCn3Q1d4s8+9IO/+Mf3rDm39nMFrZG6VX+L?=
 =?us-ascii?Q?oy4Chhl7dKLZ1n2u+1tsxRy/o4MUMCjcPcFsz1jxfWTVvZCJb2S/R1e5uBu7?=
 =?us-ascii?Q?ZSsr17gU/Lv07W6o4iKApKRXYrXwdW39Q55s7DK1oERSKYcAai/Ze1oVoGGq?=
 =?us-ascii?Q?Be9RzBOt49+H8lvb0Xop8PBxhho0uVpal8QAtmRatKsHjwZjBetq8T6prcj8?=
 =?us-ascii?Q?8fjmg6kPrVp6gMv2QCsBdUrjhST5LUA+1skn+FyBCKi944tspN5mFxscpsqp?=
 =?us-ascii?Q?1r2fsVraSWRLfIO3DBJYe0kINK5yYAy7PnGK7+uXdpHgEUf1fOy4EpTcIJGi?=
 =?us-ascii?Q?Yj4dW+QdgXx6IpawPJa3ZqvdDf8uqoR5Z0ws9KD57SUWiRjwcgmxK30yV2fe?=
 =?us-ascii?Q?ysHGSrKtShLgHbjNU2lqO0+fGOQewK9Ae9lm+JN5qsjiwblfohlZIWRrjGcI?=
 =?us-ascii?Q?QEBeuEQSmovR93XPIDrvViDQEjjcC8lwYgiZ9ZMGkQtCgDqcAWG29RIbdYpl?=
 =?us-ascii?Q?F1EORaJiu+x3eWImrK2ZUhOhHMIyr5D0E0hTwgFOZ5mfC7ykwlA0gawICtPe?=
 =?us-ascii?Q?D0WMzxxS1rMsOpB6av2sHN2ESfzXh14tnYVowtKg/cgxifCVz17ytVt2T8rE?=
 =?us-ascii?Q?OQ+95g4+LzFR6ErfFBv/p9fZinZ1GnmSc6zRH3c7OEjagF/CjGrIYp62tGxF?=
 =?us-ascii?Q?uh50z1i9zpgglkQz8uaqtqP//Zd2YNwxekISOlascxfKSXGMRz6q1v28GBhf?=
 =?us-ascii?Q?3DnZwL26LR5R9Ir4BbN0zDxBqURTxqKREYQcNunG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbab4f72-7104-46fe-06fb-08dd76964e3d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:10:08.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtV+VRh7hEIIO3+MothRqt4SBP/J5YolH6Dzwgb1Un4dIdKYMAxN/noKJ/CY+rFMXX/V03wg2XYf7eRwT1gG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233

Handle insert_empty_item errors by adding explicit
btrfs_abort_transaction/btrfs_end_transaction calls.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/volumes.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 375d92720e17..347c475028e0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3733,7 +3733,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	int ret, err;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3749,8 +3749,11 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      sizeof(*item));
-	if (ret)
-		goto out;
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_balance_item);
@@ -3764,11 +3767,8 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_cpu_balance_args_to_disk(&disk_bargs, &bctl->sys);
 	btrfs_set_balance_sys(leaf, item, &disk_bargs);
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
-out:
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
-	return ret;
+
+	return btrfs_commit_transaction(trans);
 }
 
 static int del_balance_item(struct btrfs_fs_info *fs_info)
-- 
2.39.0


