Return-Path: <linux-btrfs+bounces-12947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C23A84197
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 13:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1824D4C44A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE7281528;
	Thu, 10 Apr 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K0aFFLSj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154425745C;
	Thu, 10 Apr 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283970; cv=fail; b=Vk48AnNW01w0BmkHUa3JRSlheFfsjFBvs0IOItNxOqkhbSAese3bY+0DlZFjNQsbWdWqjZ5aPcieevYPJl6x9AhGM0f+IAjyn0EzbbOzGAQGKCvff8tcWW9MSpzJw0xxgnUr1xudQ4AUiSnA7nKDOY1W/cjstHHhXy12Umuk7kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283970; c=relaxed/simple;
	bh=L3nznGZcwRdg2KSqQGqlZIkR07zURpdkXQ60znueU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A01/2Mb3V+kHsQFcKtmr5E4FsA1paA6q3ZUuonpBo3Y6PGE6qCFrOnXT8mKn1fZsj9zZcRIXBUBP6C0RuwQJ8Yv+2Jb3dNdYZLia0vkLVHcqxkKotoRasgHkjpXrK4JUU/sTc6XatF9Z+Q3+OAWAZY/V7IZAzb+HIXYzq17cSh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K0aFFLSj; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4soByxI3YajZFEyPxLqgTel0lnkQLHZDapDOINDmjQGXerJYZQg3ftGT2EcfKiM8OmuEauB1x5SfVl4S/EtG6nfM3L/pGTQBX/6vezwTZ2LV+xUZuyULfqfpMXiUgKIvTwanGtGSR/cAcCNFv+vy1uBi797etSSOWH8rn5DEYUcBDENi5STl0uZfcvkVV2B520z0lq/TTiooUxTkUEbK1p4d5iP0AxskVRSdVzkBdpg20PfJ/ZEPsDd8ZBJkJdI88drfaLFAzDIUiPPTx2KCCt7a0aHb030M2/w4J3MDge7PYzW3cePfAeFYCCggQw3PnZmc7sCXriNApFCWxmqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3jc0xxz7J0F4UT80XqCKgJu7mrajwyfkVGIdto1Lhc=;
 b=ffboMvUV104qdJ0hjCH9W2WyQZyGeQ1qYTXoJwjPwIQGBSG6hnIDOCg4V05VoiPh/ShF/FnZ/tFkmKsbZ4iW3XDd21+AXrK7TlJ5Wnn9RNqahp8gCtcdW3UZb/uNhHScyPNJoJANaLI5XdBVpB2qWi842MMnSlTb1B/R436RJnXsNo/6/Vaqurmd7BsL3dwpH3laN65UD314UX1TzjZouPRkWYBhcCtB4X/ZkF7WOtuRNE/7qya273DQP+ZP2Ksd9wKVZxb3aQ/n4pdEEHhzyyyBrWEojGDVbJxZIu+F49ZgkUJ5PU3ayCO0CUmG3J9Dtyb8W/0krwBhGvp63vEDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3jc0xxz7J0F4UT80XqCKgJu7mrajwyfkVGIdto1Lhc=;
 b=K0aFFLSjTsDQw1yMv7b1ZTaCC2vHEbIaaQaH6uhc4Zchss3d4NoGJmHJRecsPNsYSN9nqPYnqh3s23VI5L8u4arPWjPbu2pOXSvWwuWngsd1I3a+v/+30E8aoDAU5UaJYz1+dMfya8ony0L2Mj8+Ul7FFP0LiN9q2L2gJmcMLjyAdu600hAAJtR0x2AVcG37b/b2YUVa+ZRM/TEA4EU7eCsX5vyQwUCvfD3Wgem6qZzxL9C6dgGGdiIr2azssfyUOwzD4HgSFUAaiyvJyJg1IEBUhfGHOXk6utqSI0Uam8rdPjtuCs6u/f0kusZNaQJ7+a8JvzBWRN1zNgEVesiAKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6751.apcprd06.prod.outlook.com (2603:1096:400:476::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 11:19:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 11:19:24 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] btrfs: make error handling more appropriate in btrfs_delayed_ref_init()
Date: Thu, 10 Apr 2025 05:38:58 -0600
Message-Id: <20250410113858.149032-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 91869863-37c7-41cc-c865-08dd78218c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/geWh1CG9EmTN/8Vd4Y+R8T0BvOuFeD1xHVKmmJKgVDCQ+ydpJLVmMehMC43?=
 =?us-ascii?Q?AaTYo+TO1S7WNGmRA9xeAwSm3m/Ua2Azp4SoMrqzY0IFqwK8sYlCn6kLHHH4?=
 =?us-ascii?Q?kcXoPnxnrCg2hVQGnve4o485csehfuGya13qLA3aTwAs5/aNEbKL/vpQtP88?=
 =?us-ascii?Q?hrOLSXxdejE15qDTdyIg/EUwJKYNkKtlg1JnjDFSfAqC8fbkhq+6GRW8v2Ri?=
 =?us-ascii?Q?FUcdbmkH2nZkHedDB5khA7eHkYWUWAWZYnguesfqzcErZ40NSk4/xCeJh+OX?=
 =?us-ascii?Q?Yqk505IHkeLYRTvzy3pIOshD3mDQdRPkqZxRn3soKslWJdYLzJtj43jj59GF?=
 =?us-ascii?Q?4iSbTFuGD7VxFxCq7u+YT89D/lCFpEYJXrdrIldpAEr8HszkopDlymdqxLQC?=
 =?us-ascii?Q?N41Npbkm1gVXXolQftGPejZ3RWXDk6o2lxdi2Im567/jJoZMJ83mATVItDJ0?=
 =?us-ascii?Q?XxoiYbriAErQ3gi0GE9nEC2hMfQVe7UH9M795fcroT8Rigwv8kpq4Knniyfg?=
 =?us-ascii?Q?qJlr8Esu/kYiuvD5YukUHTrGZvbyg6+sC8LiqOJvd90xhXR433bRQVbCXeYn?=
 =?us-ascii?Q?gdN7eYtJ6eegEtiB1aOUXQrX4sbFNO/a46DN8AQAwj1cFOfa+n46Zl6/9mXY?=
 =?us-ascii?Q?hJujPcS6caHvZnYUBx56fqqmBqGuRtyXcW+MuUjp8sy8mTnOiPynfg7n40R0?=
 =?us-ascii?Q?OESe2uZOMC1M/xrb4ATgeban2gQUqckloHC7Lm+TTOJ1yV8InKRBf7FLm3tD?=
 =?us-ascii?Q?OLDzhvN8GwDEk6Fyqo8azue6fQ+lnsgY/WZgPwtJRW5hX5uyO+k6Ye76YAMT?=
 =?us-ascii?Q?/wLTQwTUS32GdKakBtXELNlzymoqylkMDpETwY1lbNv9jONEf1QbcBDwtpRB?=
 =?us-ascii?Q?1Ygo0svEovUQ8QHueO0Vs+tu5l59eSpr5XjybiW3JhftNtL8hsem5Oud8nYE?=
 =?us-ascii?Q?d9OI82JMRpaVggCoiEOjd6rgPyjI2p6rg7oPBGsemkIy9h/Xe/TIoi0E/2DF?=
 =?us-ascii?Q?sjuxka5q3dF+Vyura+JyFsvmU/962iQKGuleCvhMl8GKOsD+AAPh+frWe3g3?=
 =?us-ascii?Q?Z3aZIF8+K4PBBdfgVWDDZkH7evvCQvsbEzHjaHzSe/BtLBLowyhYXv5yXdPc?=
 =?us-ascii?Q?7PJdkNeWVaBHeo51D19Wo4ESG3IJ7XQfCZTFdn3jZ/PhThauJavQbRthjtWx?=
 =?us-ascii?Q?OJ6a5tB84cUKZc8Eu1SebzvDjrBS56RRMRempNu4EIeI+v1L2fk/cMyWHh5D?=
 =?us-ascii?Q?RlwyiHhXIxuaDcX9WXGe/AwFHfx6rW7CsNel31jFFe2R7V29pCXRBAn8hXYK?=
 =?us-ascii?Q?nFT6U5dfOwRP2IG5N6ftPryq4xWjy0fwe7lHD6cLpUzNaxU3WfMtvJFJbdt5?=
 =?us-ascii?Q?6Mi+SZ5kDSGscRfkCk42mip8hQtVs9mF9lHt3jk5NJtV6P5rn9DMcEDZccXT?=
 =?us-ascii?Q?8pXC8VkRmJEfYJnFr7uuZ95l1zWG8o9M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dT6otItdqHk2C0Ve0xaDxWIA723zZC97CtwLhjH8QRyxe2PNalZNfeiASzI?=
 =?us-ascii?Q?Er6bOCpJIfTbtqcAbqLG0ri8s+Qf5QtEw7dd80NQ5Hmo7W1D2PE4XA6NQPbw?=
 =?us-ascii?Q?pPBEogb5cFGMr4RwdRDiRte4HdLjIp0X89QUjsYxIDbUIKFALa6DOfG4t2Bl?=
 =?us-ascii?Q?xzPMQsVZrx0HCgDFlePABs3k8uqWo9Rq/10zT+ECcb/pbBAKJ8uMRHf6ksa6?=
 =?us-ascii?Q?TJHOMddM0yBI8LWdNoVakGkY0r7YriSc8CUlijAku6SswKwOUXLWZnfgNuUV?=
 =?us-ascii?Q?ybFY85G8Mo7Y3Nhg2V7dRU5w/IOexY2OIeom+LGTtmSETDW8zuEXbhazCuER?=
 =?us-ascii?Q?j3/FOBQYvHTmWrYr/K7zHYKpqAeCQFm/cVdXKiMJEeMez2hoDdlQwcmZPixY?=
 =?us-ascii?Q?TVBSlU2UeVQ2aYLN/dHvEuEPH60iitgf1U/KlsfWXURZWcjSOUpQ8IU7rabo?=
 =?us-ascii?Q?NqDsySqWBcB970oNaDfijtnGaWh9jdgSSenlRMsQ+DYyXz6uZz54Mx2Yk8RF?=
 =?us-ascii?Q?E028nkX4n2jmSOd2RvWbR2AxeyqzsRXobHZHIDaAiTGIHs7EEhA+QnFGw62V?=
 =?us-ascii?Q?8uzVf00nzGkSLoW9ospfNjODyo5jML5xLlcWN1KjT3a6iR1u4Owyzj1R29v6?=
 =?us-ascii?Q?QBbLisb08D9j6rrv+EUnyF6P9021m7tUZeZH75gamchaS3JurXCyzC3jygwC?=
 =?us-ascii?Q?0qu4d2SeEll/NL09sjTtsWoqckJLBAOMHcYCVLtOu78ROqvOg/ItDWMt6SPd?=
 =?us-ascii?Q?qieUzE652zsnyylOsn8r/levkynAsZc8s28QQtZDx02U8y6CNpiSYSLAIced?=
 =?us-ascii?Q?vXh06qpzoMhOG54l5gR83ezfonGbCvhMnRugIgZ62yebo0o+siw5em92U9Ds?=
 =?us-ascii?Q?jZQJ8p8mL+yxEX9450gA1ESJvyxt+reHR79580iAvGIV6PImb5aQMJfx6N6e?=
 =?us-ascii?Q?xgkaczxNG11UP3X1y3frkcy76vkGDV9l0P6CyGYJOCDm0NrQUkX/lBp/2dJf?=
 =?us-ascii?Q?Cg/UA2bJZlgmdkaKRKIWVY30wLHZEcAoWsvQ4HTmrFtk4oczjaat/HBgbHd+?=
 =?us-ascii?Q?+yT2CYoyaoz2xjJnLKZ2+3pfUCs5MAkwWz4geU/hXPs7VPDRqom/1UL1hTgH?=
 =?us-ascii?Q?aKDDK1oepBZyuHxTdlh88epgzysw7uV+z0UmBKlBJJFoRJ1a0Ry9H+d/1LEB?=
 =?us-ascii?Q?5b+eUYOIzlOGs2A99aOVDW8Gv+EJ3cJ2v0GrFYG7VV9xpF9GMrA2tcJ6fMFd?=
 =?us-ascii?Q?aQf4Iulz9DTqdd95hecI9hhM2QB6p4FHtUs9UUf084N2E9TDLjVkCnbBe0gg?=
 =?us-ascii?Q?rsfkBCNGuajGVbdWoHbpLaHSdhLAU1wHISB4G3c9NSxBv5Chs83XyxmvRGni?=
 =?us-ascii?Q?z+qzUqJW0Is6NjtN9oM3kCzNm1YSas0ODPkdL8H9kD7KFMPgXIBb/PC0Q9cc?=
 =?us-ascii?Q?AbH7qNz9tqlKfYUXhN/AESUY02Wgyhg/I5CquZ2Hrz+RzNKim073fHOg7yPK?=
 =?us-ascii?Q?KcNoIZ80uPKvHLx1mYaBfOnyxa+oclpvF/5iEr7tyBxfDxt4kjsepjDzqvME?=
 =?us-ascii?Q?8UzE1kvtmXrktFZjMa4me664DaKHaFMWiajqlW8p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91869863-37c7-41cc-c865-08dd78218c2b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:19:24.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 558OYrNf7H/jeUimrJjU0xTh77wtuwL9S7wHz3Eb39a3OpLdENTBmnZZegpc1dbYkvZaZv0WQa9U/0U4kj+cfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6751

1. Remove unnecessary goto
2. Make the execution logic of the function jumped by goto more appropriate

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/delayed-ref.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 98c5b61dabe8..e984f1761afa 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1339,11 +1339,11 @@ int __init btrfs_delayed_ref_init(void)
 {
 	btrfs_delayed_ref_head_cachep = KMEM_CACHE(btrfs_delayed_ref_head, 0);
 	if (!btrfs_delayed_ref_head_cachep)
-		goto fail;
+		return -ENOMEM;
 
 	btrfs_delayed_ref_node_cachep = KMEM_CACHE(btrfs_delayed_ref_node, 0);
 	if (!btrfs_delayed_ref_node_cachep)
-		goto fail;
+		goto out;
 
 	btrfs_delayed_extent_op_cachep = KMEM_CACHE(btrfs_delayed_extent_op, 0);
 	if (!btrfs_delayed_extent_op_cachep)
@@ -1351,6 +1351,8 @@ int __init btrfs_delayed_ref_init(void)
 
 	return 0;
 fail:
-	btrfs_delayed_ref_exit();
+	kmem_cache_destroy(btrfs_delayed_ref_node_cachep);
+out:
+	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
 	return -ENOMEM;
 }
-- 
2.39.0


