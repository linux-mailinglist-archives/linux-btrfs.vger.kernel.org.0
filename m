Return-Path: <linux-btrfs+bounces-12863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9304A80574
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1323F1B80FAA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B226B2D8;
	Tue,  8 Apr 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ip3ssHLh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011049.outbound.protection.outlook.com [52.101.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4DF26B2B8;
	Tue,  8 Apr 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114210; cv=fail; b=IWOYvgBCAItaGVy9XxEIi3rrk3Ou1WBWIDzydPkHH3AwQS3CDDtDqQtgDzQCPIUruYap4kItofZ+9hB+uvkdHKrpvoXkDqhfhE9LnL0KqBJZou3G4/hbrQ6r7oq98dNb4oGnd+Ccvl0X3lXcRG7TG0wrcRA/Je2n4pvyExVucA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114210; c=relaxed/simple;
	bh=Jl3fZCZc4C9gbbFOak5RP7mMZaYoMBS4FOyWbb+o+go=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rnZWjVRtPOSWMqaCIi4Dd4oGtt5sD9Qlp0omZ8knlPMMPV/CO40PmAsnt/raor/b2kayoALelmCz8H+N8OZMgU/7IN9ZWuSj8ACg+E42yuthLzLIascNAjkpVaMA5zo801sO/Gt3JNXPocj5suyzODF7P7SJA17N0xvS8ts89HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ip3ssHLh; arc=fail smtp.client-ip=52.101.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErP2DqYwblICUUxWu5YXWIUhfpJmAhSKGH/i0a+NYHx2QWlwqZ2apR6K/TgYaUlRyeaFUENxtSbAOv6T23JlPJc93UvPHveqCqNaqDmkI4OTEGbWpALbawMlNG8bgKUgCovIKARefO0AwnBtrNus72w/V2aRUCJaCVlkPna7dKOqmgSE1CVylqVaWD3DsL/od/wjW98kXKB0K6witbMLC/HrO2iiIpzCEVFQdQAhsCtsjUsV6cKpZc9iGZfF8LqxzsA//qBFf/HGCRa7X8iKThcXMOvbO1wg/6D3yJ+++J0OR+j2oZk9BD9PB+Rq0FK48NqgncTJcz/xtpnmZGclEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gQmQ1M4UJndloGVVGQQ0xZwUDCRtmHzxBUo5KB7hAk=;
 b=dmF0XKTWUxt1jqixaSMkxIg82rEGAb59Q2f6bd1CawrheHvQAj8l3PwAJvak6uu9OfJpNEZW948cwro9W+MXJk3DoDksuNDPgbH2LH2+lPYy5RvqGGse9HCIygiG2w+lJVoIzOfwwkJ37cuOLNJzC85CV8Un2Ls795B3LtG7Gq3TqY0KB1CGfz54fqSW8QeSrBXOtk+XhDS0ZyALFWWYL/vJcoNPFHHxO+FsXRSy9d2Sxwe7s4ezn6qKM/94gkODfTMnN4zmoi1P/a00K1CTVd9SZXmGx0vxYW8FXRXn7ZFxHEf9+W5I8LkfbaqSSpzpDKtoPNjRayrjObOivdslvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gQmQ1M4UJndloGVVGQQ0xZwUDCRtmHzxBUo5KB7hAk=;
 b=ip3ssHLhNtS4WdwQCkW9P9ojzd8kvwtYfXd+Ne9qIeNhun+BsDyEaRjCWPMpsQgXy3Evo/sMqOZ0GvOD6f9CuIiGXvPBrXli3llMa8m0AQSX1c3DBXZ1Kjn8mvfwBowohNkkvBcQq4thAOHBjvHclvAueeF/IHqdhrUaDbBxhHxxr92L27GIaQ5p+v6TOdmBCA+totOKOf1MnKVeyh5Tz5cCx/XvxbibCE8oXjqKyDpJjDeUXcEO1AZkFVdKHbLab+Z+01lYmoFE1D08yD2Co9hLJy3d+JWFrRP8L0zYVxga6gJVOQE+jnwCvjWgFn9Wr+MtPe+O3NY1mSVeIXhPvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 12:10:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:10:04 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
Date: Tue,  8 Apr 2025 06:29:30 -0600
Message-Id: <20250408122933.121056-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: bb998d2e-0059-4435-12ad-08dd76964b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+RVF/Zn2WIWR93d4KGb8QO0IqrKGEGi0DCzT6ZyFoX/jWz1EEmabvwRKEnaC?=
 =?us-ascii?Q?GYqdvMv1DXuBiwnpECDvgQk5clROirN4AuQfbIhnu4xfUInMBtLxeBgL3rzm?=
 =?us-ascii?Q?TknU01am858x9/BXXnZVE/igeWgfRYXT4RNrllqQypoAGNt0X3iR4t4xANOJ?=
 =?us-ascii?Q?0E30Y/U5p4Ojb2kXtFcuR1mqyBYTeDkC0NmbQU+qB9baS4/sP80VHO0fzOTy?=
 =?us-ascii?Q?cK4zEhTbDsSWsySrqJtTMB1e++Cf7fpqCDKi8RfiQHvcCckq9v0uCNrHTTDW?=
 =?us-ascii?Q?LsQ7M+drITvekQhMEvpD2nlr18kM952anCM1rGiQrdT6PWGb8vuC5Y0x6g57?=
 =?us-ascii?Q?9qdCVFBFo5B1BKvmA2/mDkk5KqSTZtA1Buk1zWlig4jZrBzOmNNuFpdp7gYE?=
 =?us-ascii?Q?c/hinWy9M/n9Gj9O8OnH7Q/XKPHzeaeNTne/QSMLF489qny33Zep2ZC0+cPo?=
 =?us-ascii?Q?h94rjH9YftVLejui4A+p9Ef/X49xUl1aKnKbO45sm7EJmk325KayXutqj6J0?=
 =?us-ascii?Q?GPr+fi1+9oGusRYpu6M6MWcsDqxVfidqoUrL9swp41aTC68VLpyfk548h7lu?=
 =?us-ascii?Q?oZqdrvxY5c0sduKhv0RQzms31qrt2gXjjie1DNB+5omDJ9MXQoPJ6aSIWIIQ?=
 =?us-ascii?Q?LXKrlprESwHe32/F4QDzC6OkUezC+zB/CEtCyk6/3rjDWSlsGdcxgjxES9Zu?=
 =?us-ascii?Q?4GQDxCpMi4ASM+kH9FhX21iQSMaT83jJjXqG/1UTk/lrLrvzS3ARrniFq0Qj?=
 =?us-ascii?Q?WR8k7s4l4YrTS46lsiR/DyKyhCn17n9RPv0iWY7dqlAWJL2ddyd6+P9oGi2W?=
 =?us-ascii?Q?3mym6W3HKvp+5Z2KLphJr8l50Qdm1IzM5CKjkkKS584v/RMvr9jMohB/R4by?=
 =?us-ascii?Q?9pkoC0bQx/AnNZKwWUG9OkO9Efiy9DYB8V7+MWJfZT4gZJpWTfEGtEwp294V?=
 =?us-ascii?Q?0mpVCJQqslf17lZ/zxbBiXSPf8gR04jdy05yAr2lW573mOzCjhHMZ4GQ96IJ?=
 =?us-ascii?Q?QHj1C8hv6jzIEQEbHtTvRMl9kIzb5FS9oB6mB9sKrksXsOvBEajQWpi/2oSk?=
 =?us-ascii?Q?XCsriS9hqsL2ciE9xgFT575jeSwZQYMoqkwpNbG7+g5HHs8MwVdFtAVoo/kC?=
 =?us-ascii?Q?8+76W0cYsLiD7pAWvN+byz5JfabVTg/gl8gf5TWcm9MNxkHrdg8TeUg5gb6k?=
 =?us-ascii?Q?Pmuj2PrYRf5Oe1NTGov8d3eyR9UjTFQMqeTb/aqaEBqOO9dPhHQA62iqxHqq?=
 =?us-ascii?Q?ETbw8HIjESNkVTsO12SuLw5wmtLeQGBImIEyqZUOsq6Fy6MBoTUaT1eBjy6D?=
 =?us-ascii?Q?ImpXOTcFlK2Vdwl46Ice5tmSbmqUt6auKtGGzUWWN/6HlrrbIWL2SMNkobwy?=
 =?us-ascii?Q?svrztjfN4Ar6+dI8aMz8SIIgzkpLxr+lwj+SntYRpAv3QccMuievgYm7V5Km?=
 =?us-ascii?Q?eM/zdixQ2Mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZJzMXWqr/4MFpma7NFw0Mb5f1AQSzI4znXyCFubtPpp2G6ofToNRNM63u7r?=
 =?us-ascii?Q?1Q4xzQQtjVd5WUBVOMItfRFYmQmOhVlNusLq17ybFgbUbvqJ7PvcVP0XS8gL?=
 =?us-ascii?Q?0elrhgM46jwx41EBMc3Cv16iUuyHzW7GmJDhk5wG7Tb5FSnF94UzIBC34WWi?=
 =?us-ascii?Q?20td5FpbErX/ja74cauirhL/EHCanCTK+wmU5KRPMEchhuW3eEQCAflmTxHo?=
 =?us-ascii?Q?HEry0ucO+O7x48xsjGazSFOhe3y+7zC7hjnI5qdcknY18t7vI77FT59GGJ/6?=
 =?us-ascii?Q?ZZ9vdXyF2y5Ddgi4XMaxwBXLbcwoP/lxnjfqtjMjTS371HTVC73mUjfurhd4?=
 =?us-ascii?Q?roo7wWHjNc6yOXoP9qMzStt7TyAqF6r5Ngu08E81K5NYShRiWVzoVu/ajXFr?=
 =?us-ascii?Q?26i1cU/V+Q7SuqFqyZgcYXds4BnklVISqJVDr4qgflAvYK2omZ7ajBEWZnvR?=
 =?us-ascii?Q?jVCxZfSlZ/JNad4XwwDOrA2zSnuzgarlXlYqydYgzE3Si0VPawdHVoSwg40W?=
 =?us-ascii?Q?3iljwcrELO0ZpMehVO8bHeTSlXThhe0BYZVyVNIqWFiFb/1jU3/tGHO0Hn9o?=
 =?us-ascii?Q?B2/M1subqahxLSEYbo36LbxRidaFhpKCJdjrONjyyRN8OO5l728bQAhEWpQn?=
 =?us-ascii?Q?spLM/tstczerYogPiuclyWokfrKB8c91h5bcTbLQo1u+HTUNDFVfC5HIKThy?=
 =?us-ascii?Q?o+LosRHxa8PKJbL7jqug/vIBUFOnXwFeF5awY0G1Vzy+9VPol4R8NePyEcbg?=
 =?us-ascii?Q?0yxPbGHuZhr6ZMFOWSuRjZdJlK6+7v+X6fCdpLsbviPo3d/UjR4ihEZLHabN?=
 =?us-ascii?Q?jVEZG+3jjIICQfXV20rs1+/vTU/ePxW7Hfjx8ot3XEqf7+KnLuZahs5fu8y9?=
 =?us-ascii?Q?4cSg++a3BMutkdjhbFaZFo6Ama688iBm+ClJ9s7r876/M0fAV6e2TF4RaWj4?=
 =?us-ascii?Q?pdF8AsRT1SNoKzQnu2ueobkSQoywkTSTQrMsOly8G/HLk8QpYL89iEo9Zkdg?=
 =?us-ascii?Q?XmeJHPIvpDe7sf5PXDP0CaidduRfxpGqU89eytHZsB7LYv78CCYbncJPXTuZ?=
 =?us-ascii?Q?nHD6oX3oWmvDlYLVPA71b87CpyJNaE1EPahkjHFKFIEK2dTLzIFiPHlpurzs?=
 =?us-ascii?Q?sqSWqC/xHXutMdCIJqR43Z9YnyowMjAf6+1CuhXuntqbsYQ3tdipgBbbVWuD?=
 =?us-ascii?Q?GYXGr85kdJQIYKWxQSVjjzbWLUkgoU2BeX+sCMVCcCC2blBsGzWrrY6bUSek?=
 =?us-ascii?Q?ZGIng+O8iLl56JkmxauRCdn/8Jl8+R7gwqRUFaNiRr8wUxlzVuSm1Sax9zAB?=
 =?us-ascii?Q?nd3C9hHYMZi4rM++F6HaFDrTP1dno2zRWoK7cKT2g/bqQuJVPJgaRnMxv1O2?=
 =?us-ascii?Q?IVLSaCOcjf6oLdBVObAzpm6axn0JI7ApzPZR+6qJwyFGqQSu6a0aJEUGRQ8d?=
 =?us-ascii?Q?3hLVK2MKqImwKI9pAS/eMJDiQqgVor6x9j1ybRyQsXJI3qSg/urLVTh7OUNa?=
 =?us-ascii?Q?v7vkw/XdlSOJuv6yNZvQ9m7qKDiQb6vuPf1HQN7BuIMrY+jWWBLqfqapRoZO?=
 =?us-ascii?Q?11prVMAMdtXbo/QC/0T9wwVlbn8yb0T2qHcjfpR9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb998d2e-0059-4435-12ad-08dd76964b32
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:10:03.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUs85pArn3VbdJwAOvWx7NtgGW3Wv9dGTfAOTadaIEazLYzsR6ZMmDw4boCSZTqnpo0eCCstI4yJcEl1LFEBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233

All cleanup paths lead to btrfs_path_free so we can define path with the
automatic free callback.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/volumes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8c21c55be53..a962efaec4ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_balance_item *item;
 	struct btrfs_disk_balance_args disk_bargs;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int ret, err;
@@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	trans = btrfs_start_transaction(root, 0);
-	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
+	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-	}
 
 	key.objectid = BTRFS_BALANCE_OBJECTID;
 	key.type = BTRFS_TEMPORARY_ITEM_KEY;
@@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_set_balance_sys(leaf, item, &disk_bargs);
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
 out:
-	btrfs_free_path(path);
 	err = btrfs_commit_transaction(trans);
 	if (err && !ret)
 		ret = err;
-- 
2.39.0


