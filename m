Return-Path: <linux-btrfs+bounces-8158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886C97E64B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 08:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A622DB20B4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7F381D9;
	Mon, 23 Sep 2024 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l2jiJzO4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEC1C3D;
	Mon, 23 Sep 2024 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074728; cv=fail; b=mVXqFzH2z4wWw8DaT9l7iCa4KBI/6CBCwbretSO7SMyZDWPbjcMw+nOnaUOlaZOoGZHdjKJ2yepovJeoIQ5qCxFxQar5+uxSfAJLjTmFYDSBQcPviOBkk0apWEpF9ocRsIAuW5+kAXo+rvHBOl2Dvzf82aBH8wqovJikDFwgtBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074728; c=relaxed/simple;
	bh=u9k6x4VTrp511PzedVylIfzFEMsD1y/kmeezA38cUy8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r1VrrQDtDb+VyPQ7Em7IOqAoqTO07SNyedCzhdWqQpSqEpzQWZkVdB6fjJOMJ+INOk82n5dunj66hQkEVT2d5IZdCM3RGQ9tAhA7g1rCq4PJox/0f5bRDvHFSUZTK1MSWM6eyyotsZHZkQVDuXmNfQU5YQAYzdrkI7HkRoI+6CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l2jiJzO4; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhgLEQCJM4zgt4WaUKEd+1VFVm87xJw94JtfYwJS93i5bDGlEnmn9efGScPRor3DvMvxkC0puJVz+xtliWJCZPiRLoibL4x5r9cxgdiAIBUvt9MHSOBMS1Kal47QKhZe5ZD7xyqs0zWwcE2LyjTDmLCr4kZVHoKxxe1q2Ldd3gD06lXRemK0RkuypoRmRxQC9+hpjtS35gg+/zmE83scxaXQGNgC+xcFjo16YQ8i3s+tfhawlFo5w8KHxlXFigM53E/GzoOsQ6RLhd5XUjHtHSg9Odq8P/b/jGg4EGasKYkEu7kZ7bYPTkAvwKZJebjNEkAqH5IZWd8Aos4td2UJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IqYt+xx4dAs9NgU7XAmkABBZwMXspV9MRypCRxilck=;
 b=y5fwD9G8YQJP3S4A+wvmh6K7k518SazsEIInx33jXmYMqasq2Pdpuqw0gcQZNCHEGgaeSCqp1mSesobjMTdoeLeqE4qrVfgcZtTZ6yLZOGdoHG8/TdbkDXmNDLpLMEaGDncqtI44tMY5zecewTI/ZS99VQAkn3+RF2JNSyJsKWgnVCm47ySFxHz0sL1IT6c25fD+CWHOgOxK5NKDzWtXAnALjrGFUEGn+A4CjTI/bVjLIgLfnM999FX1JQ25+qS6EJRizUSr1KA2CRoSotFe18B7zoWqZbxwD9u9T3X3Cm3F4N4aXdx5p2CFydyAYm+BEbEHbv0OwgtPIsXjYvSW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IqYt+xx4dAs9NgU7XAmkABBZwMXspV9MRypCRxilck=;
 b=l2jiJzO4/p5kQlyxwkBQtOLWIsaVo6uTnrNLhljL3V+8eos4G+jNk4b7pEcaxB52o1O98KOMUXEQIwFH011Uv3DszFvSzIMcV1h6YbP4FO7Cvm8zfTKsDzQVveNZfbEJbfPc0QQqBgw65i2+rCGRwdpGD3RnWve1raqaozciOwTFP9US2mJ9DVCFEpE5TmgIk5oRYyQBdhFHE7EE2XEE7C2wK/eYz1nmmS94Km8/XApD2YX9PDWYvqNXAD9qodgY1IkwfJE7U5w6Po7fhLfuTLqIHsUNiPuUTO4SSgxbl9MzdLXGSynGMeST2u0VUsQM5HT7a4WKiIKMtA5D3wIMmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYSPR06MB7246.apcprd06.prod.outlook.com (2603:1096:405:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 06:58:43 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 06:58:43 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] btrfs: Correct some typos in comments
Date: Mon, 23 Sep 2024 14:58:33 +0800
Message-Id: <20240923065833.12046-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::6) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYSPR06MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d094a1-b648-45a7-0d52-08dcdb9d297f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSibSYiDvDm//hqhABoAacIpoC0HoPenWyGGPCX0HeHfT0z5XFHNTcN2M9af?=
 =?us-ascii?Q?vbZAXc2jxZ7xm+1Kz4dEjMO4F9MmM8yQklTeYnjRq3jINHm1VKj7YvnBKYzt?=
 =?us-ascii?Q?EnA8D2l+mJa7LLllmpWArBZ4mCLHYVcAZmODh/91plDP7ZH7g6D7fDHQBagO?=
 =?us-ascii?Q?sV42DHJDe+DLjBDtTCwq9YXWQQ1apQbQ8fUIwE2nHNA0FOW5A+TmCGs4M4Ky?=
 =?us-ascii?Q?TWuWTnJAs7r9ZYJlPGKibQyk27jgTSz0XrwNhsMw5+XN4nH6lWzI8Cn5F2dd?=
 =?us-ascii?Q?OznqMQ0EYyjsmENMyDGe6j0hpWrZr0I6gpJWfCu1toD16PhOxUxI+1+IwoeU?=
 =?us-ascii?Q?NVNZj+r2XyWlolLNIADmMYV7tAFmZQ7MoDZxMNXX16vIItqBMBwNld6LGcfs?=
 =?us-ascii?Q?9jg6RCegslkgNllXUj2B9jnkt7gRVhzI1UWd4ERxNXmLghGTZMaj/9jR17/u?=
 =?us-ascii?Q?1Uyk3YxdTkkpiBvHFWXpsu7mmTNThUB9BAEdUlLq3kV8MW9Yi0bcBpHS9zU1?=
 =?us-ascii?Q?8qrDOjrnmvwtW6A5DckfXh8EO9uVf355dtocRsW3RpHt/l60aRpEE2zaNF2A?=
 =?us-ascii?Q?ci67ks5pIBcQe6O/vorVLTZ2Y9ZZBa+2U2zsGshdf9lNWsZxLbzXR7yXoFO4?=
 =?us-ascii?Q?gzQcXjWj4obbKqojdECJbQsASnh6STUOc+XGqR+ekT6tLg+qq3WH53J63g8P?=
 =?us-ascii?Q?NF2v0PUSWyJr8S9aNb68ORxgkTn3gh/1CyPQoS84YuBk52uo/NM1ZDrSTehW?=
 =?us-ascii?Q?Td3EXVSd6GYQ8GXRGOQK8bYDtH6I1SG1vpuyKoorkCVWdUdOvUVYKz7fBEYc?=
 =?us-ascii?Q?/e3Y9KKXIbx9HMIumXr020qf6qDaCF3FSICd9fSVyDrI3x7ZFZi6C3RThIfg?=
 =?us-ascii?Q?VsSLArmeULvNHA4aS2Le2cYouQfLhUK16GGnTy5yf/X7Z0ONYv9WeO9KYS8f?=
 =?us-ascii?Q?4mkNeKH6NGcIr3HpFS2X/BJpXcxr6AIblbAg2kZ+9ecpO8TSW1cdpMcxxnjP?=
 =?us-ascii?Q?1qazd0Lxkgwkd3nJee3SJ0Nl5JQrDKoqFa6ElAdBsDQ93jPdjeS707sFz5OF?=
 =?us-ascii?Q?mYcwli7oelcDwhGT/ftW+Eqd1NwvKDMznnRYlApf2PCszTBq55Huiw32iJIn?=
 =?us-ascii?Q?7l0qsU3Z8Q+AgYJbz9nzPYbgb7Ldme/F5Ohl0mmmeM89pCUwRtQSnDf4eNBX?=
 =?us-ascii?Q?40B4H6aQXpbeXvSRYoE0/V4y6YrajQ64bMGm0oKlIA3VB7nvDRPrr79J5pBH?=
 =?us-ascii?Q?MsvGJwCDB3E2v87wVkfL6K2dJQ8exM5qAmMIMB8WiwsjHJTcVWH+Oilocs/Y?=
 =?us-ascii?Q?bE/CnM9RiR8fE2mbNaLJHYzHzBcCFQO5IlRRKpHNytvvjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IFVs6SMKDdiIQleb4z5NWh78lNOsUxFHNqN+XoKitapfNV7E5cRykKGFBZl5?=
 =?us-ascii?Q?NPmhx6nqAEX4fTvgmhMDOfy0xSXmUKUGBgsMH/oUe8T4Tvu3CrhAEL7NBr6R?=
 =?us-ascii?Q?/AeYfWq88iUPSYQNhs5yGhKVE8Qq6xd4/7rWWXwEy6V8V6Gm81vokOxEFZsN?=
 =?us-ascii?Q?ArFWWly8Z78WxsA43nkN4LaVhOibE3u1AuxYDCmeS3J5qaUkAI5l7RSGzDhg?=
 =?us-ascii?Q?FcqR5mhP3ZNH0G33SHlp87geUcsgKKy5SYHfSSOd5mWERdAN4y8pn0Ob1+EK?=
 =?us-ascii?Q?NuUj4kGx20HWXxJ0OAltWsO5n9rRlZJnuzKTqOp/0crc9x54w2X1rE/xlvxp?=
 =?us-ascii?Q?m+XEZUKiBLWVkFGLFAUh97vLBMQMwOgdkZeHlFjLLNHFqFQvLckD0ztol4Yx?=
 =?us-ascii?Q?4uKDv8YmuIg3FPOIYCs3DR1XnBbWq+odtt1CJgspjFKFS0svJ6/tAVhWoHXL?=
 =?us-ascii?Q?CVqTI4x1FFjkfiLS2Sgg8ySPBJPGsWY5QLo9S4KVRmy7U+bJfjQ/CiRhgzoG?=
 =?us-ascii?Q?tGVdZmVssNG28Uci+iFD3XYgXeRIy2I2RbFij5mzlC0Cz/dZMBrZ5CWGh95q?=
 =?us-ascii?Q?se4FpZqCMq5ThiVuotCYBeO88zWOs4jlD8YjGNhvB+GZBokTQC87aELh//BJ?=
 =?us-ascii?Q?L0sOYoAXqabkzGlgX2fm5vXbAY3YLdCU7o/D/oe/oFXVcepHhApqleKDQpFj?=
 =?us-ascii?Q?8JJZK/ZZYgsnQNzJ++a6H52cN02X0L0F9uhf4H3Iie9GX0NIoL3oKdJuMs13?=
 =?us-ascii?Q?e7xOWbG/TsuzqS0lravap6Lhgbku9TSCBnFg9D5WC0WBmiYoNkdT+KHnj2qy?=
 =?us-ascii?Q?JrkqVx3bnBzDV2RrHSf9me4B2PwByTnWJo9ylF7UNfYoYSZ8djEDbcCjIQNE?=
 =?us-ascii?Q?51nE4iK7Pfut8y+pMrj4e+riVR8jV4FuO7SiWyQGdaq97hZISweBb9/unxCp?=
 =?us-ascii?Q?j9B8v2F+qQI3T5HRtUWLF2WFQrFd9ho/0vZkty81vuVVMtJ2SEiLGJT4l6A+?=
 =?us-ascii?Q?Kbd4GUbTX8LNpbuITQs9UcEtViqgJ7UvEp12tX4Nj2lMRIz/4FHZTudRo+lA?=
 =?us-ascii?Q?C+eElUATYuj+KJtUKzqp6hT8ApfDSMr5egpotFyWVSR/gfwS8vvQcOk4qgoP?=
 =?us-ascii?Q?PM67K0PnF0rPXKS6p8zIXReRZL97jdiUyTO0/Ij2HqvenYNYGfS2VnV/AYmK?=
 =?us-ascii?Q?1Fp0mNh7k8DnR4lwW5Ar3ExgAKNAhlRaxpPLzDEbfvWAe7Hmt0uTY6qdAHFN?=
 =?us-ascii?Q?/PAu0dMcrR7iJDQiX7NY38yFyYLtycl4Ko0zdXgrcEax+UusJsn5tUwOCKrV?=
 =?us-ascii?Q?a0jMbGXaW7cVmOQ1T4JD01rWAW9R7noUjYib3eAbLu9jKvoo/bRw4yflGuY3?=
 =?us-ascii?Q?mJTuxX1kz3OVVQrCAZKmvweHGhs7KrV4EMnwcqaMsjd0iLajGM85spZJK4x1?=
 =?us-ascii?Q?J3QMvL29fzJtFlgdea/XDScL596SBRlh8eaS6uJ+eXQlBGvL+2ZwD41ZuWth?=
 =?us-ascii?Q?TaymAljNFSrBcbvgZr9zMTNlnMvSNuG5exZ05/58GWW103GDrwgWZ7V93sO2?=
 =?us-ascii?Q?0FBTRcS0vJfEyqUC8JmhAvTiC+dYbri8tvW6js7w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d094a1-b648-45a7-0d52-08dcdb9d297f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 06:58:43.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfSkoHQtbyJ5NwrFnro6QUuC/dwfF44WChbIRfH8jlKj9MATj7OgOxq2cVXLdRQxUKpgrpQ5MmxwRtgTZJb1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7246

Fixed some confusing spelling errors, the details are as follows:

-in the code comments:
	filesysmte	-> filesystem
	trasnsaction	-> transaction

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/zoned.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995b0647f538..555a817bf065 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5309,7 +5309,7 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
 
-	/* stripe_size is fixed in zoned filesysmte. Reduce ndevs instead. */
+	/* stripe_size is fixed in zoned filesystem. Reduce ndevs instead. */
 	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
 		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
 					     ctl->stripe_size) + ctl->nparity,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7fa2920632ba..00a016691d8e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1973,7 +1973,7 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (block_group->meta_write_pointer > eb->start)
 		return -EBUSY;
 
-	/* If for_sync, this hole will be filled with trasnsaction commit. */
+	/* If for_sync, this hole will be filled with transaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 		return -EAGAIN;
 	return -EBUSY;
-- 
2.17.1


