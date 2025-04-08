Return-Path: <linux-btrfs+bounces-12864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F77A80582
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E261B8115E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9D26B953;
	Tue,  8 Apr 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZQeNCyfX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011049.outbound.protection.outlook.com [52.101.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B707269CF7;
	Tue,  8 Apr 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114212; cv=fail; b=k5d6jXgbPlIY1ksCCuVi40/lJ3vWqfp6WCdHWmjBDnc3vaDT5fJ3ao0K0fAdMGkApzlmKbR89vjNC9/jps39WvtYuvLAZNDI8m5uN3QI1izuL+Po9BAqc9KjWUa7HSZFFK4KtoKBHkFlNVRQULkBf8onwVVnZ0+kXz/16g+CFgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114212; c=relaxed/simple;
	bh=oveKT0mvZ+oXNGpmFOSwuN22A6WQsPTqui/PqUG59WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UykygaL7IHMxMM9bOqHNRR3vvIimVg0ZAROIBAd/X8DlJHHvHhOCaxo/GNIKAEMhSkeI4tFNeD8wp+hp9SYOj4FBq+IqqrNU91zi3zjs9/2tJR0z4nNnWQLaN1cuflrDC0l3eVhciI1yNqPjxhjjbmSSDw1F6FL9KHNvCP58z5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZQeNCyfX; arc=fail smtp.client-ip=52.101.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcJzsmJaNqjPa7ZMTgBpTsDrOGHng25XxAvaTtvdogrFVRsuLcZwmbeSp9jKmQcdf1Nyl5Erj8HibWNuruknX856HOSm3Y+Lw0u0ES4K/LODGYfZ2azOg+yYF63YAkAQqq2Asm9tcYntLBxo08Ivi8sdFw9FgCMVIv9zK1RPWLJlIRpAYIACVVEqq8LwP1biFSOni2/JJknUyi2AOs7f8W5+G4TI0I6H/VNBZjYFZKgz4VtopPJ5H6I29NpOM3l3bznjSYT3ZqAidq6oI5hTYPqnVFO6URrwk78X7Jr6sXAem/ekkYRz8qxKTFGs0F1obMtM61aqYxEZdf0pjFKp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1wX7p+3JjeVKBbSy+JnF9YNtqSE16FCSxHkYVC9V54=;
 b=wcgIMhmchZPztC6xiLWgChpUufoZYtUJTdNO/HzEHVEUqCl8yWgt+xgQJ6Wf/OBzejh5raYzaFlAuf++qpTZHHrjn2iWtL83o/MEpG6gbKKKBV/8oBnnleoSybeTYwfIXqaHPP8ZmLg3El0gCB6ZFw8wb7ZRLUx4ySI+dNx+I7qorlu0QCer6IoD9a11x/fcDV3RW4IbjSkmodqRaAGYgLKu11T6Zd7apLW1V0lB0sk0OBlR2bALEE2hlDI74YeNOPPT/YFQqfzKP0IlecvyuMGg3vGAFuv7DEU7a16ZWod3cA/8yaR+j/Us6SE4iNprX8VCBRHd47gOaDl3pGN4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1wX7p+3JjeVKBbSy+JnF9YNtqSE16FCSxHkYVC9V54=;
 b=ZQeNCyfX5m9rTaCD0c1Sa1E1FVWLgFWgvkqBBBNX3shQVHTB6hmhAGmBZTWzhUAJ+cqlrTNjBPTAva6AnC43gsnwrHk9M4BQniDi+mdDpbp4u8tD170ykn1Hf0czkr4JE02dHk0q2PA1o/mP5XhzKYFbyWS+MZaQgyXB2zSWOm7nF5sWL5ZPHzuW/cUKuhhTeMcX74Rdox8onPK4z/rNYQ1E+petGdgZ4ABLJNS1DaO7IxryP45yMG3Eii4Xd6Ja7vUvGEp5eS6ZP8rlq4x5ye1YJuG5zEO7s19UiG7yhyPS8l7TW47cNzH2M1qOLV0M1Ta+lXyfQWRgrd5Xb+3+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 12:10:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:10:07 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/4] btrfs: use BTRFS_PATH_AUTO_FREE in del_balance_item()
Date: Tue,  8 Apr 2025 06:29:31 -0600
Message-Id: <20250408122933.121056-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8d878e1-10aa-475e-d8c7-08dd76964d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBUBVmJb6yoBvhMZH/HH95wl/9uMuSv6vQY866Dy6diBKJruwy+LfqNYdM/W?=
 =?us-ascii?Q?YXJstxayN782O/bRo8ZzbXL/HnijY/mG729KrXnLOJJWgr5YSI3rzxMnVfyP?=
 =?us-ascii?Q?RbCchBoQyd3UcajQ9lfCAByWg0mDhr+tzRrTPcNaXNEoF0qlbJgWSLp8kwAV?=
 =?us-ascii?Q?hM3bDcEDScbbXASM39S3EJlSVc26juq9241J0pXny5O2jzjrsVOsrveipDR3?=
 =?us-ascii?Q?lVy/TwHUJ4Z6Y1mAcOsve3ucyRW5WKBCC4cCQBbgqpDP6QHniwee+dgX6mYm?=
 =?us-ascii?Q?NbPr5PJJ3H9hKq6Gy85B0sapDnTbUB0k2OeG4Iy+UCd5BwiICOOScLSkGfX4?=
 =?us-ascii?Q?XvDu84o/99PCEE18bjvcE/kmTqX5G7dDJA4N3ZroGlZE76vn6h5J0mJaI71E?=
 =?us-ascii?Q?zoXSIjIyaj05NPaiy8/t4ICMYiUQ2JjZYYpMsWAYTzKkE4C9ok4Mn6Zd6RVq?=
 =?us-ascii?Q?4QiuOFokddx647EF6UeBbJAJqGmtmwaWFC2Wz0zjZ+gC38aWsL+hQ1e8fwyN?=
 =?us-ascii?Q?bJ3d7HSGBpq2Bx/QMTPV27QPE53HxDdg1RlZMZAC98rq7Cw+5bJ0Imrjr+xn?=
 =?us-ascii?Q?a402nmqaTb/LnQOI5OhmhD2wTGPCJq0HtAaOpNTjAg7KqhS8nGEneQwhaNa2?=
 =?us-ascii?Q?j/LBhi6QAXOVx7tcu6+qjyFSmH/flFL2HTEamG0yOTt/9cbxkT80TzkM2gt2?=
 =?us-ascii?Q?mq6nQXGinbjCHkbj4y3PI4FUfjjLV5EBlgCVIKZ3DcB6B7zlybLF7by0A+8H?=
 =?us-ascii?Q?KQIf0cfqS789Zcso7dWe2ai1w0BpTs0fB30g1tMC/A7cwAKtF4iG8mqI0AOB?=
 =?us-ascii?Q?mTBIGuktNTbo5CHbdlDjOhwAgEKTR8TPOHnIKApjlCo229X8tzCdAfs6nd0j?=
 =?us-ascii?Q?8CrtX9nVOzpxZPIQLW5UIEBna7nAp4K0H2F+CvvDD/eIkcOfvkkzz94fmsTj?=
 =?us-ascii?Q?iKBtcBEnqEXLQEsxY/tTjx/r9Ep7W1t8AhJ5BuNMgyf1XFezXDmJOMV3G+58?=
 =?us-ascii?Q?jaQTD/VkmS4XxBlYz30Ei0vk6pneCsJl6WMinq6XYk2BvE79IXjilW3pWW8h?=
 =?us-ascii?Q?6Os8W1pyYdnwiR2s4wyQOyS8jXY9O2qV4y8BKWAJiHPIaZXnzn8dFit3ZRXS?=
 =?us-ascii?Q?YkW0dJz8pc7/J8pUFrWiyx/VVCAbqpg+zwjToNwAaDu8u38+y5mF7VWT/+HM?=
 =?us-ascii?Q?v/XN1HOaJmLXxON7uYh/TTVvaR0Pf2en15pwmKTmBbzq4ItGLXnTq43uMQbe?=
 =?us-ascii?Q?jkUt8pZvvmUwi5zfJ2ZDTcJYd4c4vQoEuLH6I/Okq5FpIpAnVzyzfdR2xzIK?=
 =?us-ascii?Q?Auv9zn7P3HEPgWrI8sW/yKQlAgVn3cZtGrBXR9L+qa9r5RRW62e7sLtBIdR8?=
 =?us-ascii?Q?rE5om+AUrsrJwXC0ee27vKnhrIpbahvr6SdEuOwqwQvfR2/+iVNCCrpE0KVO?=
 =?us-ascii?Q?tNfEk/hYf51mt9dSOGrtqmBQrp9DmJ7D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNqxHnOaEXPj0pD4IxEZX1O5z2TKpEN6UWnMB5rfwe2iBF8z/1GyS+cAqCRJ?=
 =?us-ascii?Q?zhXT6BbemqwOHkJLTSsDQwblcl68NgxW9VQUj9XCdXcsYyQj5FaAeed/+s+w?=
 =?us-ascii?Q?0oxYoMwNhJOaW8zq2/V4+lATshsgNjTdrfPSdUJNsnqqQ9km6A34hjhPHwGG?=
 =?us-ascii?Q?sHMAMQqm+p9Ub9Tl4jMGE4a/Y/UgiiQNBSysJb/cS9K3cy+xhq437+5CZ0ci?=
 =?us-ascii?Q?XIZuONVqd9xnxf7MeqGkEDgcYKsl/Hdn7gq7It876Xa5VlWJ9g//qnN64E3g?=
 =?us-ascii?Q?RYG7M51Cza4voV282SumoTuOZdVXmMa9RuPHTbN8sD09Hcj9oHyBGk1/rJ4l?=
 =?us-ascii?Q?QOp3u+O948ypLbvz3a/ewhe3XvnVpUKMJV/99ysfkLZH3znw+Wx7RtCS45ji?=
 =?us-ascii?Q?q/CVBFsGgO/fGMRf5pAJp9PaOv64ywdzUz9Q6U/VMVC+eu8InBSjzepaJujA?=
 =?us-ascii?Q?CgXn1CS1i9+gdl+1c2yf3u34Bw2StYPQTa6062yhwgEsJny6e3Lf+Oo8Xqog?=
 =?us-ascii?Q?1C/wbJowRcz/7G5lj1UT/A7HSOqvffTG0S86YY8817Q0h3uCzwmIFIq0tOMQ?=
 =?us-ascii?Q?Aw5rC24wfPIUfhEF9BWrMHPlSE/eGy5cRMe2AG51vu/O+wVzaj6mJy9DWDWF?=
 =?us-ascii?Q?n6iW53ouNse+XSh19QC/dR4Bvsb1cXRB2bDQw5lAqawOcDd0NmgBpNOKDF7F?=
 =?us-ascii?Q?vSLGy7PAi6eK8SmRsE+rYghvoYU+eEYA8FEp0vBS8QXo9itWHHXJZi/tVCjA?=
 =?us-ascii?Q?mBuns7GX6kMw97Zi+hqolqRLkPmlwz43j67/4M54IZgYDMj3ybc0uSjmRpIy?=
 =?us-ascii?Q?3qQn92vbcDbfRbOMOoZ+jxc6aCs0PjVi1Du6nbgIsM0z2Wm4N5IUQfKOLfnk?=
 =?us-ascii?Q?9TR2TlzWu9Fm7ynNNNsQXMvd7/cABZf/vpE9//2DXEgmGpeMxrfmV7BKWKMF?=
 =?us-ascii?Q?Qw6FYy9fnmiJXLXM9Xxpo4Pyw34IPoWubbPWv1hvpQ9X9AF/0GIYRNG6bHen?=
 =?us-ascii?Q?ACbcJxaLvTLYcIojHe7FdFG0ovpz54eZ4cmfIliiGaUFmFUNEpv0MViFjNft?=
 =?us-ascii?Q?KHItr2LAGPgJKbR8QFWiwmnTpCDpDb78MP48Z8za8otd/GBKv7Xp2kuExmxc?=
 =?us-ascii?Q?m/6C18hNc8BgWnO68+Ywk7s18ONn7A+WzeGIS0jqzXjZwo+EyN/Ic5r2M4XM?=
 =?us-ascii?Q?9uxBvytPCcMjzS/c9tT0RwhKWtxGKSYFObW2gjpGbISvS47em4stLb7ec9QU?=
 =?us-ascii?Q?F2N5wTAdWFKdFfIB9ocxt5LpDL50RF3JLigGwk8e3xVp+0+0T6PstitW45dj?=
 =?us-ascii?Q?qDokurOJ2guBqKH6oWbhh5AiLG61wOkspIPPGT/HFxDcMWATFJoZbSQbDZg8?=
 =?us-ascii?Q?SuAzc6zniPoaLHvRb8lWKvAw/gih35XcCK3dx2QISezFCJTNbgtSafsas2Ku?=
 =?us-ascii?Q?oU5kS8PbWHYD5y+ieR33G8UAYTtOSTKd7HnYRgyydoNuWNEkCp6psr7a8awn?=
 =?us-ascii?Q?mNWqiIGmBvGf0LERU1gckQbygrzA+6xyRg3saIJYlPDOwxme4BKr5An98IHW?=
 =?us-ascii?Q?wf93CXf9benIog/FolWECwLvTFmbr8qsRQRhzUEs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d878e1-10aa-475e-d8c7-08dd76964d13
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:10:06.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkTlZaLcl//wtDEumFD4Yf4lyy4LuZskicT23BP0+uKEaq14Yd/Jzd4BbAkKbfKovRP8b+QEBjr6RhVjUBvdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233

All cleanup paths lead to btrfs_path_free so we can define path with the
automatic free callback.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/volumes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a962efaec4ea..375d92720e17 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3775,7 +3775,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret, err;
 
@@ -3784,10 +3784,8 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
-	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
+	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-	}
 
 	key.objectid = BTRFS_BALANCE_OBJECTID;
 	key.type = BTRFS_TEMPORARY_ITEM_KEY;
@@ -3803,7 +3801,6 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 
 	ret = btrfs_del_item(trans, root, path);
 out:
-	btrfs_free_path(path);
 	err = btrfs_commit_transaction(trans);
 	if (err && !ret)
 		ret = err;
-- 
2.39.0


