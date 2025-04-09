Return-Path: <linux-btrfs+bounces-12924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D14A82515
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85193B4D0C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681D261579;
	Wed,  9 Apr 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EgpyHlRH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F825FA09;
	Wed,  9 Apr 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202286; cv=fail; b=S14/1bhbVhfpGTtkA4ZN2DMuknjxtGIxy5n78d81KkuJJx0O70qEFdmF84x2ToXZ/XzXW1yAnvUd4qXsbA0D89Qqr9s44a/VS7E0aSr2tNIMVeJkQT248gSXnHZtgGHRv9Q9QYlYHPPoB5X+1QYCu+ODVdrOyNVDRqtWBmyGZAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202286; c=relaxed/simple;
	bh=HRBbsxpeTUbwtJ/oQeprfFgQYbdVJh/CcT167Vf8cJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCZGMK/kRafIg08YmH6244BnYIxakqinVAfkocDxpJNiTMDzYL+70U16gvqsBFj9o3AE3ePfqcdjzA0gP6vblLUN7eqheC68iVapTSckfrMY0FKZmouXcBnYq2kU1ofcMyMal3v8Syf4AFv3/ojhAqRW0E/DBIL45NlHwI5+llU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EgpyHlRH; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4c+e4b0AbLdbZ5fW1Y8CegnQMOt5RzA4RSL9E2ZUoIwnNOMXREpG6bzCVGGrddWItEFUxxzfnzJJ5siQNucozCkyrlzDQMa/kFsoltJSLKs6O5rJERkonUiegMOxtknMf/+4NJgrzExUouviNqpOSNIwXPLbrT12kPl9nwiXyYSq3V020+IJmasfr7gOSO0w/4gQ4/7D1LPxY/4hhDIm/9ENZK04++XSQtqjvRh4C+tMycZ8CLRixL1e8dex414mukeus0vFMQBvWFPZwUrIW6mmHvlGG5SZeuaAxBthwhXVqdaJWjOpb4pB88htpCW/j2yYDMafTYwUf6OBo1iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktzkkkczXjFu6M15fVmXX44kWVA63ZjvEf5VZltISYQ=;
 b=D6dU5SbVq+STeqAwg91+rsh1hcdTnHNUOBe21eFCAR5d3AeMLFbGP1sjUMOD+VE9tittryqCfV7do/cNEyWGlajxdN2UASJi7irc+mE/mD2BiYg/50j8IdEuydNzk8TQPpdtokC6pP85PUOX17cCrtIUiHEkQ0Qztyp5VwUvLdAyqLRnck12NwlYRqeIWfrzY82FoOBDKdqQqBeIFWIti7AJJfJtfpAANwmAbEVNAR8wHRJEwNBkjqCsYKQpK5H4KUIuPrFdqGOVp+HaXRfjveDvoFWG2SqEF3Xyvq868fV5mPsZhdQpnRWw1QaizOGOxGoqKSRJjwGUZAMXZMsj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktzkkkczXjFu6M15fVmXX44kWVA63ZjvEf5VZltISYQ=;
 b=EgpyHlRHWSrC0chYRNTdqryUWOABS42V6/w4aTIfktb6HtnYrjsJ5KH/4JnDStsZrRZbnRviJ5fxG3Td+qqEEJLJV/4xDyM9q2CaeIGFvoPT4YW+Zetf8DajTivreJdVZlolaH7MBXzNF6P2ST+CUQQcpHCuF5ZjVAGHVc9/UUwCDOsgCu8HXbXbyofybg3ojcM2B7vDMcbF1A/DIgV9s1bJge49d6jQu/g/btc+lTPOsEzz0Hw3FaKdp6v1f3J6F9UeaDF7WWoFHNk/eBXLcA8ezv/Cjb6+qp77aDDkNpPAiScoXFZ3B6v4o8aGWqU4vvGAErMhsHhjiK+VvPZNYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6292.apcprd06.prod.outlook.com (2603:1096:400:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 12:37:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 12:37:58 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] btrfs: convert to mutex guard in btrfs_ioctl_balance_progress()
Date: Wed,  9 Apr 2025 06:57:23 -0600
Message-Id: <20250409125724.145597-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409125724.145597-1-frank.li@vivo.com>
References: <20250409125724.145597-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4490a780-d8b1-4b4c-f89d-08dd77635bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DiI+QkDWLMC/FuIAYV3UM5x7t9kXeXpPJu/zeOqDkpk6KGu4srQ3vKhUn6cB?=
 =?us-ascii?Q?6k/G6mSAMZ2x15jzFkGLHylSOwsjbCeDD7DP1FAsaZM3XMa3yruJGpkn1YEw?=
 =?us-ascii?Q?g4+Eg5YromAJcsMg2qVAla/NOg/tqkyMAxsljrqzGdWfR9t9OocGswx9l6Vy?=
 =?us-ascii?Q?1avxOZMDQQDizHNGobeEaeTh4ogeaOGWtbjT/B5munpDw7Xi9fjXm6RA3wRF?=
 =?us-ascii?Q?ikRY3OYEfbrOYAotk5CrF1NKQfOwfrsr4Jd3zjvT06b2SKReomlQm38ArN69?=
 =?us-ascii?Q?zeUTnx14FWDR8MXKAsVtS8WXK8qzPQT4QRZirikNX+2jURQCZh838vlNDqXH?=
 =?us-ascii?Q?DNIPmOrwqG5pqFRtnQxvPZKHMokrAMjeSIfQrPwCve7M4qNIa6eO4d50qETp?=
 =?us-ascii?Q?xFZxPni4xeH1wcxMH5YSa7ywG9unagbdZCwpaExWPM6QmxDO/+zDJLJXZzCR?=
 =?us-ascii?Q?hN9qGvZdq4C8LjNMG+La4eWMnt1jVpERsDECiHUiN4SLW9I844K7tZtDFD5G?=
 =?us-ascii?Q?WqBCwbaa4NfMbNGEGyEkPvunmzH1w7GuvWVOwUol2YcEYXB4bmFPltxwBVEq?=
 =?us-ascii?Q?7J9UJ68BjEE35ljNnZtU7ovW4sh2vYwqRyToUHZnNGTRGAc1+7p44Sh0bjB6?=
 =?us-ascii?Q?TC2vZlY3KnszlW8FPyA+h7BxgE3F5IEVwdaN6qxL8n02ykpMlkAWCODoDnED?=
 =?us-ascii?Q?SmSwmEwgSdw0sktovTl3ekKAMIdfE9JZlkQP0QqzctC8fc4NJb4f3Zmprx67?=
 =?us-ascii?Q?Rqin4sH/p2gj+RB0EhBHKbUmUrO2b62e10PijpGR9/kQMsiZG6eP/7vqe4vZ?=
 =?us-ascii?Q?it225WVP4iS0ZjUq63WvGLzQ2fahiH+HYYID8G2Qpn9uoTMtg+eOI4YFy1mm?=
 =?us-ascii?Q?78l97guutXxL3n7O7xz4n32nSMUbRB4Q8vLgTxk5D+WFrvE/fgO1wZz31Ywo?=
 =?us-ascii?Q?nvzd3Hoh9/DEgjW0ppcbpRNiZbRqEEi0ws4hflvntDyLXVnCuSc2G78JO/+z?=
 =?us-ascii?Q?6Kaw96uVHjcc6Wv6cFu06JM0DTpjeaSm2dkpdtjVR0xlHHFpCJ1a9vMYHaKA?=
 =?us-ascii?Q?Be7zLdJGE6B6iuK+v9aX3USgk/GbyMdg6OKJIKDfZOl4SiD09lghGG4ucQv9?=
 =?us-ascii?Q?Gbas6VKsrE4hSXPAW20e0lK81/2YW0i/sW10KC1ntiFzj7oMFJmpo5XBK/6s?=
 =?us-ascii?Q?J3bfDhTCBc0Q8jBmoQTKhEz3Sy8Y2X/XbZcPWwkBWz+QkUWnzy2auV3G7Ic7?=
 =?us-ascii?Q?3/AGYZzxykWeNV8p/tNLHz7aj8eQiHqgPV8vAjcPGLBiedH1daRxBRR3rXvz?=
 =?us-ascii?Q?YmsQZUv9ysp8ARy9qtnogstQF7IH+30hFg+TJqPpdUcs2txY+KvjzzVjXMui?=
 =?us-ascii?Q?OVYAlFH8B6TRtQOL5PgZ7yEg7VeqP++XFdNUye+Di8Ga4bz/kMp3Y/3+HG/I?=
 =?us-ascii?Q?eUu4omTEAnvpHFhB5169o8RzR29wIodQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0i4y/3lG+4701SM0MtODPP+LZ8YDdWuhwf07r8+Kgf/G7AWIwbFmNAgYuCGT?=
 =?us-ascii?Q?fTm7571fvD9CfT0rf3NWlYf677B3BdVe7NIKKSlBbNZCCy2MWn8eiTu2AiF5?=
 =?us-ascii?Q?WTjrJsBp5fvUJZA1fgsKkuu1JnLlz/X2d/SMQfBRziJmIf3BF7e8tmHhGZtt?=
 =?us-ascii?Q?jPUccFQ9nHN9yc6ZTr02qNUXAZjzTbM5D1he6MX/ZYbXo1OoHPxybVF42tmF?=
 =?us-ascii?Q?yBcgWItkSkrY0XDZwazTuNmXuyUhvFtK/FTFmdUQDybsI5FUNUKKj+KKQIMJ?=
 =?us-ascii?Q?rGbfTpTmB5lTIFWtNy/vOngw8pxxpkBG4xEvJXfbmCd7tPeWI3C8jQ9N584J?=
 =?us-ascii?Q?2h9Xnt/OoQoEzXpAwR9cqeevm7EZB/CajWne3nP7w2u3cFLy6Zqo9DuXefZ6?=
 =?us-ascii?Q?T3NaBlZlsMCC6ptBEVShPp4qgPjDbGyapQ7dxkkhFS+SnRQ7PCsqKzrUbmae?=
 =?us-ascii?Q?fQBU8uatsMvloSaRgVzZIB/9AGInriMHEuz/6ywOiR0WTFrzqakbTrqFawfy?=
 =?us-ascii?Q?/MwZ7m9HOeeq35VUzqhqnaWjZWiMMPXPp1/iqCa8f3zEX09SGTd8p+nGGVHc?=
 =?us-ascii?Q?rbqHqJOY07vVtbf96vtbNpDUfeQmRftxh94CAgqhOYfQ34jvR2z+TaXxDA7z?=
 =?us-ascii?Q?F2Dp74ZceGwGz1ELsKWLwu2xcm6xMdWIzP9mmgwx0Sc7h3WA/p91QArhQ0q5?=
 =?us-ascii?Q?+oNrvrMGCPO2bDGQaFBBEA7xE9U+fn+wRMQZOB0vwf63s2D/JEbi6NqeuPCS?=
 =?us-ascii?Q?jdRY4s99C6o/wa+AkA0bhqW2IEJ4gOCGTOnQbSgaA3ih7oYo0HwJH1MTYsI3?=
 =?us-ascii?Q?Gx3lUHUWtf8A4R5ugCp5dk0dTVgJfucHQBoepPFBaCW1tfBFIsHmgakRYGYU?=
 =?us-ascii?Q?0dTdWol2/+gFW6ai9HmGa3LP4Jwj2CujQVL5Q5TXaCv4CD2hY6QEKofKxWqY?=
 =?us-ascii?Q?hK1aTJfBgCFlLzIB+o+VfQgbFAnB/fD4RlIhkUL+ee/HX+7K3yc7yRq3ZDn8?=
 =?us-ascii?Q?OLfGp1PONC8/BFNbPPSSc61Q4PJMnwx/WKG/S0oR840YjbmL0/Gsm6sUQSe2?=
 =?us-ascii?Q?KP9UMUF3JbwYWVWoZE71VZNaEpKRba5VLxVdvl4ylalUJmvEWrvZLYsXGbGr?=
 =?us-ascii?Q?a1fxf8PO844kY81VeK1/ar+qyxABUnPqFgWuOVXYo/KGw/qBkWvAzSB6pubi?=
 =?us-ascii?Q?9RLTeGLT0MK6Hg2QxCRjitF2u+RYgitZA2aqVw1a2xmFyXUqAnirf/pOTceh?=
 =?us-ascii?Q?W1IP/7RzIRezkLSyYyRd0tfqObHq8GswltFEA5t8FMLR9Az4NDbhfC7Ivi9+?=
 =?us-ascii?Q?3EUKxyclrfhN/nFSI+9RigWiOEw1J9Lxs5w5ZvnhNVj7Og1dMPBvfCrFJHVq?=
 =?us-ascii?Q?kSIkB6QwqsCXTC4NpK2XkIzmlgfnFCaR0QHZpYW6tIF7EjlNYCqquAv2hAPw?=
 =?us-ascii?Q?+47CMQ0u/xs4+G6oaDEI6SQ8OuROoXJdTiH8SeqRwdpOK4dBdR2jSgBsVPu6?=
 =?us-ascii?Q?zCXvkbuOCB5zdAju/EFRRZmkI3afXQ8xSnD9VkRfHS+AkWRSdBUmO/nIGQRY?=
 =?us-ascii?Q?iWBq3t9jY7XvCUsrC2pE7HnFJ6L5F5iS4s1og7vU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4490a780-d8b1-4b4c-f89d-08dd77635bc5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:37:58.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0aOf10PoGdNwFtt7lUSMt+sXiS+Q8C8UGo7sNx1UvJvE9iqHMGAgNEFj0892UHU8KGpCOrEUKAso5I7ROA16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6292

To simplify handling, use the guard helper to let the compiler care for
unlocking.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ioctl.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7cec105a4cb0..1d8c28aa84d2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3620,22 +3620,19 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 					 void __user *arg)
 {
 	struct btrfs_ioctl_balance_args *bargs;
-	int ret = 0;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	mutex_lock(&fs_info->balance_mutex);
-	if (!fs_info->balance_ctl) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	guard(mutex)(&fs_info->balance_mutex);
+
+	if (!fs_info->balance_ctl)
+		return -ENOTCONN;
 
 	bargs = kzalloc(sizeof(*bargs), GFP_KERNEL);
-	if (!bargs) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!bargs)
+		return -ENOMEM;
 
 	btrfs_update_ioctl_balance_args(fs_info, bargs);
 
@@ -3643,8 +3640,7 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 		ret = -EFAULT;
 
 	kfree(bargs);
-out:
-	mutex_unlock(&fs_info->balance_mutex);
+
 	return ret;
 }
 
-- 
2.39.0


