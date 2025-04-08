Return-Path: <linux-btrfs+bounces-12866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C10A804E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11E57A1691
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6803F26E151;
	Tue,  8 Apr 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q8yMhqa4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D826B95A;
	Tue,  8 Apr 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114215; cv=fail; b=KSBhjRRgFV/X216MWxEkaZWgGFVmjMmxGIxlE5ML6zpgsk0mwHYHgAKNj8FsTeLiOkRsr2KyuZf1EKFEfHQH6D3TG29oia6GVRHbMs5xHEPNLftWA55+tAl4cIG49cRrSow0d537gqttRTo6vqcs1PgWjS4ssVzD/42SrJ12Hok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114215; c=relaxed/simple;
	bh=itujg89EuYbOMnoforr4Hoxko6/prHFkAPU4qiWxi48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAjbSJ19DlfslE7qS6U2VXDrdEJJLiWyjYUU5vaUJYfuxkKg/cbh5hjE8JFr0tuDrpdS1ASVIGRWJ2rDSmRlFxfBe2cqzUPcFH92tzzcEQZIExDiQRL6MoQDNTN2Rp+KsZ9ugXNSMMrU5ov2MnmkG25Lyp+pjQBlTm+9hhU0SsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q8yMhqa4; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4AsJcnUjQ0DALFD9tAKjzy2gPtuF8tOyhfJIbEK2uIaIRfdh7shL3vjiJhPTK9nu4KcWPRiRDjEbPXoT6Oed0DgRcGm5BeHf5B4uffwGusv/K5CL7Q6d1b0oyQ1oM0x8lW4xE9xp5GLjLiI0CLhLvr9FwzHSVtr7HprJhYVbvrYPQyhEIBpgTKl0cpH6mOtnVqdqXm1gJirbgsDza5SHyp3rToXc77KC6zF3HVvm0up0QqkxNijwS5EQNhARaad2x5GvtFTChvS3GByP3cAttB4mSFOBAITP1D6vdj0iPljDZjwtjcS0+V46/cACcHUR/VETOVoEMHurY++ZZ0kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7+as/rM9I0EUJtDgKEdpdAVvsbtMq57jYicjzfof1o=;
 b=cOMmjrHxHVCvT1ynkxxaawKXSCt3qRjw3VsdH4yEB9j1WtOp30KEHtEnEbxjTH+JVSYauqmNKDsY27Hajbq8rptF8paN1GdKoed9K/OfrEzMVCd5IICBvkuNyceyCIRwNO7VB87eCJ9IHpd0xRQC/tTTgUwEgmTpPtdDHYmwG+kAZPviY7PgjH+RL78lpwY7mL7V0ObsHKfk+C0qBfUtposoNJLKg1qaOegvXidBu7IQuefZnXt7vHWF4J1t9Cu+3dFRGHk/Haj00MAWW5fNPV7eflPko4Pcr2GPzF9AESLStuZAwdXaASk5hsJnsyuRzTBtojI5tGyr90iyV/C/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7+as/rM9I0EUJtDgKEdpdAVvsbtMq57jYicjzfof1o=;
 b=Q8yMhqa4DGcMPkOy5DB+eZkx+jSvDtWrqFmgyQ2T1vHmjEh+wZx2LIA7/bjPY9S03BP4pdanTrh3y164Y8tSHdOOCs0duu2MOKNjgFQuKOmbOTG5FZQam+Tiq6x1anN0g3KVPgVpmQeD0NI8opxi/CoxtwSvMEmCWhNoU4Pt3ZNt04F9xQQAL5e7ZeCq7mQeGmsYoUGbsK5LLEOddpcEOf7XxGQu58OHrx7itGKA4jVITAZ5UBFfu8C8GuZwYXcHJA+i+NuVLovr030kwZju0+kmorT82AMUy1DERTvs9bRhHUvRRCIRpbKuPAcskNzGFhFHgMMYRWAPCokRHfhs+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6074.apcprd06.prod.outlook.com (2603:1096:400:339::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 12:10:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:10:10 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 4/4] btrfs: Fix transaction abort during failure in del_balance_item()
Date: Tue,  8 Apr 2025 06:29:33 -0600
Message-Id: <20250408122933.121056-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e0c44b-7a16-4a6e-fc60-08dd76964f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzUCITX7EOXlmtVhBqe7JKu/kX5kThso3FCjgdLkFpLqqNSByYLDpJhb5f1H?=
 =?us-ascii?Q?3WyCngcdKfBgGauS5py0ZD2IeRAms6wcfzkHmxPZ+lhLICN+B/FvlYsX3SVm?=
 =?us-ascii?Q?OMDPsJUgYiW0ey9e877uKofrB2AuQqobJhlcEKobmdsxkP9ykk77y3CKb9wo?=
 =?us-ascii?Q?eVPEeYubTfgVoPXLMox7MDXlDpXFuNzU1c2pdVrbKjWUn+DhbMvbaGcqAI1S?=
 =?us-ascii?Q?jEB+FvBYjaHQX9W0cIpNLy8PeViNXDCN4aFR9cTNlkv6J0RKP8de+UXIhLlE?=
 =?us-ascii?Q?7an5efDk7+oy5Iz6Ks77JCnuZzljR5W9Xuumc4h4ivUzd0GIrFdOwRi2O8jc?=
 =?us-ascii?Q?0d6OUBxVKZM83cc3MLcVkFXthEqwf8NTq1MuGT9mVrwhkH0+BFGUedy6ESRO?=
 =?us-ascii?Q?xAf3qm5zbUUDMci50uFNxITnQW5JNQxnt1HylJ+q6/s8iLD2p91pMNmNFdRQ?=
 =?us-ascii?Q?AMv0DGB2tQBwHy4vD5u9u7OWdmbtxYjp4LahbAkUKotr+seP+dr2iAFf/5Q9?=
 =?us-ascii?Q?OegSRtN9Ms2lzW8L0Nsr6Fwcf73j8odCoegE571mywiRmY+GdpVpISEsIEln?=
 =?us-ascii?Q?0FUn1yJmhV0zFbR6S4tefUG46wdUqGsdeNFjMM4WjbiUO5DDORd+a1lGVK6F?=
 =?us-ascii?Q?Cm8hBY/kurtbiPpQxSlxSUDOqfTE57N6KGC3PwNwnRdFnDTnAkAqPKvfg99V?=
 =?us-ascii?Q?jAiI+JbZRgbbbxXySc/IIluOIw1Vxq9Ann9guc1yqcv4gUm9L/UFUT2JKzoz?=
 =?us-ascii?Q?WDrwXPsaz37MwANmU5kUwvB4NAQFZdFliJB02X6JoGw6RMEOAM8Ha5OGA0JI?=
 =?us-ascii?Q?+qkk254Bv6WO1melvnyClbWQ6mh+o7f6muzYBJxtw93QplwBZBWtC4dS8NNQ?=
 =?us-ascii?Q?MdzC3LNlDzxEAxtGplN/ckgz74McC+0h0qR0j8aS0b89Ifd8YfRmYfzcKZGk?=
 =?us-ascii?Q?pUw0q159QUW5opZF0uF23sQaw/xooQekMfRpaGorUZxnHgpwnCEUW1oWbb1W?=
 =?us-ascii?Q?ta7SdXy4f2Vn4+eNcn6P7iUT6htNDqU7fcLVlZzkbLUxEX7VOqXH5t3d99Br?=
 =?us-ascii?Q?dRMCodDqqwsxRXKgMc2mr735N/7jiFDe+rTVtszShNQaY5d5DGOoQTRqZmwk?=
 =?us-ascii?Q?4TSG6+uf7rBdQYd+J9LjOQLxgvqOsaEzLrv9sLtY7u+bIFnqsql3OmhInywA?=
 =?us-ascii?Q?TalyT6BxruPF9CbuBvvAeRuuN0b/fkC2JkDjHyLlISEpSko5oIiC3QFHuU6I?=
 =?us-ascii?Q?ApngzbvgL2fGVEq5G60XH4Ggr9tvTxexTmaGnTRt5V/n6Ob+eSuD7HvHBiys?=
 =?us-ascii?Q?RaRXeYsexpLiqEqwzxoqvuHujD1CkT/uuWrVElWa8XadazgqrKzeVIRl8yvV?=
 =?us-ascii?Q?INbboP9oXFOXU97zM4KtBDtCrjxAXa5lAyqSTzmslm/wkgDSDSKt9R/q/jD6?=
 =?us-ascii?Q?LZjueBD1Vrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNJr0XMsNzdFBfzfMFSTxuGJSRXiY8G0xiaApCQ+jH5PM3KQHspytXRkEq74?=
 =?us-ascii?Q?zlgHf3n6Ry28vzYuv9dMQmGEYzH7+dN+t1bfiRYk9D3hrlfhMQ5jT0io/tJR?=
 =?us-ascii?Q?5Ih6K1WuEBn8AnyylBgqMoZEOliagGCC4xrD5WEKrHtymNMZ7Y4TR/v5cRQP?=
 =?us-ascii?Q?nBg8Eqw0i48n0Oou4jhcqwqfBk+5JFr+ZfzkpzKjOIuuxor2hUfGOG17px2B?=
 =?us-ascii?Q?YeuDRP3P5PIAxfzaSQtdykYf2wAkcVtWWls0ihPD+5d5ewpvdMUxyAH5hx4T?=
 =?us-ascii?Q?jfuzqvqzLvLA40vKbI34vsW8vw8JAUcvS2S5fSxYKSJPPrFaAF8s+l6z9PMF?=
 =?us-ascii?Q?2Y0+hY2ZiZ923VJyhT0R+2mGide6BdHC+xOJPDfdnxj7zsZGPPYqgaXtqvBT?=
 =?us-ascii?Q?tAjoAwK3R8+SR+IuDUtxnbwDp1v2/nVrKGbLLfjVH1UoJRjDrOlyYQdoAeJS?=
 =?us-ascii?Q?JDgd5WxpESBQ6ABb6vDmPXizgwmlh6fCOASL5x3llUihhdwU0133qS/Twc3k?=
 =?us-ascii?Q?1tuCTScqeEMbT67ExkcodCLDauQbkO/t+r+fBTaewyA03jiS7ehPx8Q8U5Or?=
 =?us-ascii?Q?KA7CzzYyG7ye6Vc3EVAZnaUt1rD084vaZOS8QNclJekxBJaMonEOmCuc2kr5?=
 =?us-ascii?Q?J2UxJM3TSKnQ9me66olAI66Czxv9q+lRDgHRNT78bJV2XKzKYDK9A/KrEZPN?=
 =?us-ascii?Q?JyAFyg6Zzr/881MD3JEfbfrPzFJZA5SfehHIJ6Q4QpO8kz2GequbLH3LljtA?=
 =?us-ascii?Q?ymr/6+WhHZm49Oh5ZND8uJtcWISGGbFMgpQJFobuAr/EA+8+W4tpf01txZE2?=
 =?us-ascii?Q?m12FijV5BqL4w4QCWkuY0loOao91Nz/kMHDERNyFWsQY6ncKwzJUrHMJcFJY?=
 =?us-ascii?Q?WHjamqdQPY1s9LIKvV9fiBIvjGBhfFXMUd+icBA1C502T1Nm9o7IqnxvPlvY?=
 =?us-ascii?Q?5ahQ7MBpjZM6ZoLkkrJtRrg+7HdSPm++AR3ajQ5VjlO4OxyQameDVIJMSIw+?=
 =?us-ascii?Q?17axewiZIHkUBwAtP8ga1DkxEdYK6F43KTrlGPUiG/I9llLT02ldm3TLNAlU?=
 =?us-ascii?Q?Zb+/3V0Xg6jC1DFEiIhDck0YWeK1uc9ugk7jtTqR55lneIY0+GROwj+fuWrG?=
 =?us-ascii?Q?jlVDQwSCseYeZtr08LGNA9dLJDRGUBDI0zz0evHVijpG/RE4bH1nX8uIG+2C?=
 =?us-ascii?Q?q0REbOyUyBP0xvAd07ia8p8SvTAtpzerhhpoMD0gdYCk6PrKxmJkf5+kDS1W?=
 =?us-ascii?Q?kN11QYoBiOPeb/jf1vM261ZVi1of5RMHn9rtEXmHypzQdsmp4m29TGAzXOU8?=
 =?us-ascii?Q?gDMCK5Q1RcBOi54H3uGcouyVo9YuBn53LBpiSWyjfOXpfnvHIFuHOPGalT0m?=
 =?us-ascii?Q?NsIxXAeFYRGqmKMQAMi+I7MEplYeID29zAOC/l5nXX8k2TX0dHDn/lrMVYld?=
 =?us-ascii?Q?2Suq7XRDG28rbAV283E1Cfvlpz1E7JYt/i0IoYqTI4F1AZcgl3gch5Md8/eU?=
 =?us-ascii?Q?ydreE+W+5xXxCnsoECmCvDM8q7VIECkrW+L/xTNKY6+muiWfjzChgSac/ALn?=
 =?us-ascii?Q?dr/9G5RvGT99wOVA/o39HxxJItDVIyR5KQaAHOgf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0c44b-7a16-4a6e-fc60-08dd76964f5c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:10:10.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5Lo/lk62Zu43ITYzZQkSLvPcROnaX9xlrktfCEPgAAo5DbfMMfDo0zYHfxhf5hoCqewc1D7plNMiUrMuz6qGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6074

Handle errors by adding explicit btrfs_abort_transaction
and btrfs_end_transaction calls.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 347c475028e0..23739d18d833 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3777,7 +3777,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	struct btrfs_trans_handle *trans;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
-	int ret, err;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3800,10 +3800,13 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	}
 
 	ret = btrfs_del_item(trans, root, path);
+	if (ret)
+		goto out;
+
+	return btrfs_commit_transaction(trans);
 out:
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.39.0


