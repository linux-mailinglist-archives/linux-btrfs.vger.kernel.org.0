Return-Path: <linux-btrfs+bounces-13019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A7A89282
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A187A58E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77745217660;
	Tue, 15 Apr 2025 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D2kqH2uX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814420FA90;
	Tue, 15 Apr 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687165; cv=fail; b=ILVXtVSy/hhEZOyX3OzLLesY3AO9xCu4wbTya889j6Wp93g+RWOWZUf5IsqlENeVOaxdrxgZEyKYaLMantqu9h0bmZ7QMRkGpKpT9+5Fj3619JtYFY7HM+J30+0MtprowtxJNCUk7bddws+AiM9Bu5kwkUklAbSMkgFnF3t1840=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687165; c=relaxed/simple;
	bh=fAnYlYafcmgu5kd7gOOE4PjC6jvIXI30jbA3AkYVVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4yKO3Gc1K8NNoH4WpKfKrV9QIgv5G65eKqKvCSmAgBNq42olP8YxC0v0SghOGtBWloNeCyZdYkHlD44cfexcF/AIvKadSJy9OT5rJNMqrjGOyH7W5vGLR6c7a+KygOACiDgmnUiQujKSpOlawQJ+tqOXp+PmfuD/wOZaTv+0Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D2kqH2uX; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwW7QzVr09SIO0DquhBLZMwWODjTSaAVenZ4Rsqm/BtLz+gi7iJL21SfO3zjkqtwHqYZSW70gTD4HUy1iW5y8T4LZ6UEO8A08uu2tZvVc3lc1V2TSRbuA2q+ceknnFGB4DJavPAtB9FVWQIwKFEKnrVFifaHpVxOqf+BM7gMlr1xVF2g36AzF2rc4RN+UMuMictBe/wqQzXroQ853h7BBomYeOHfVrbzXJ9jaXPHt+B6YVZUq8mlhMXppZrYKoL1/qxBfuPt61TTQN4DTaTvuMdpFwkzBMrGafcx3t3nFNR9Ti+KYIxo4TJLsFoE/q4+4/yvZanIDPA/KO9Ssve1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BtzaY1k8HctZJyBIeac7YjOdJTMlB8IffUzN8nA4js=;
 b=i9L8jxlA9RCIqTl7UXlB1lu+32e92kZL3mZZCSlk2ENi0hAyRSoans3lOEKgZ2EmGcKWPgQAr9r1o30uVnZsf+UA66O7PlA/EpPgMMzCeOAFqo00q/09bQ8fcFCT7R53R6gCy2cgXjOjjgMKrZExfVp4zHcxPDGADIE0CRyWTmOI8EnuALc+0C10zWZCKA++Dx9Wvw5GgxgxTHFki3+ObycFbAw9EgcPRG6ONQjTvmiUkA0D0vxcTcSzx5DHUyCrEv00AmKxc9M/VwhKGxLyxFkw3A973US8DU4KG6iDrYluNo24wr6R773VIz3k+AUEVUaQhsFsdc0GC+WPTcqFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BtzaY1k8HctZJyBIeac7YjOdJTMlB8IffUzN8nA4js=;
 b=D2kqH2uXtu3s9J8rqzMjgCu3cuIohp+pjSCXL/wlTYVqoAWjG77hDMrRZkYAtHCNWaw72yU5HuUk6TK66sf0Ftm8tzolBp5cyEEp5+hYYHDiuPUUqw3IfsOu94aMFJg40iahq+hfAJRRXyNZiGbFs82u1vlIwCTymhpHVJItq4fBWXQS5HbXUmc9kTctVQarwL+VZ9ntivFtNWgoBRR+7EOWW+7C6rNHpUyNDSomIU+u+4w8Qlw8K9Ekl1VTFH5g04jrv0lufHxcERob4LBrRQa6uk9vhFAlSfYvV4lbxmMX0CIU7rzcoKQAUA6n3CLn+4sHCpIIsaY68aCtgdoJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7106.apcprd06.prod.outlook.com (2603:1096:990:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 15 Apr
 2025 03:19:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:19:19 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/3] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_truncate_inode_items()
Date: Mon, 14 Apr 2025 21:38:54 -0600
Message-Id: <20250415033854.848776-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415033854.848776-1-frank.li@vivo.com>
References: <20250415033854.848776-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3857c046-8239-4134-a1a8-08dd7bcc4f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r1kPo++BGi/JPVRaSjedRokrHYQsQorMG7uzhj6bi1aFn9zX2SfkRwkzbU+K?=
 =?us-ascii?Q?P5CXVoOa/aNOCxwQvYtU1dun0PCcSEuIE8nThAyzDgjMQfZK9ekrDitTznwv?=
 =?us-ascii?Q?WdQq7SPgjLAxdcBGl1BOm22JvYxoYxbZKkLQK3xqKYyLQGQ9P0TuLbRjmE0M?=
 =?us-ascii?Q?rp5DJHvCht78q00FIQdyB15Pq51yayjrsimn4XF0Y4OLmNdYtKxRmJhIG7jq?=
 =?us-ascii?Q?umUeI5RrRpTr5WR27nOdOTh6xvKkAWII5gDH/TJVk8zLsFCJHNfU/K3cUfY/?=
 =?us-ascii?Q?ESBB7/IWHKdJVz4AHNgpT17EPDi9gYEaFRBJAlWgTJdCFmcrqIRo7eFVVtMu?=
 =?us-ascii?Q?oa2NjZmDOUpqmtJL/SgjDyKlMk+uVb4a67i+vMWYty0WGaUfZzKL94EZeTwQ?=
 =?us-ascii?Q?7GdXAhKITvucDSDqnGewwLh0MSrgySQEm/fCQ+/PzZH3GXEfsawVx63xbmCB?=
 =?us-ascii?Q?8h3plrv3Ja8LRlcVKuJFRjCPgpwjtAqwWPh8OviqImAV8ygY09hCNeZGcbmP?=
 =?us-ascii?Q?wiLncQpXNx8uPHd6rHsQeEHjK6Rk4OVxyxk/9+Xs7CBWuy0mOmA6Rgz8XqOa?=
 =?us-ascii?Q?uRanKo+IY1wFno+IxjlfBquye97SB9ujDSZOgXFE5XdykMfK/Q6ST7ahi5cr?=
 =?us-ascii?Q?VAaNq0n5FUTMax4wZdhll80H7kXbqivQbhuSgnetUALBzWYVcdbjngnZ/VVr?=
 =?us-ascii?Q?EAUhkjuKJkFPtyM25gee54MjQTs1l0FT97mQTvDbf/2X4VzdNdPfo5KWOm/P?=
 =?us-ascii?Q?vsQ0EWKiguSnJjCp7Y89QjIRKy4QTncg/Cw9W9WT4N01drbU0FAClvVx0QXs?=
 =?us-ascii?Q?I+pvTR8h5wqdnvoTAQSJha3TPCldz14oO4kPWbRjbQ85skJdJ1xEM9+XkLmR?=
 =?us-ascii?Q?e/wYShqm9J6JSnWX0BLBNEUqAZ7UV4EdXeX4DBX0EI/ppukDjR2EWEP9CuMX?=
 =?us-ascii?Q?nkp/OzPiSuXUNJyX8VGoo+UIAxAPQaf6667rhWp5AzkDonSYt4Ty+X0LR/Bi?=
 =?us-ascii?Q?t+kzMTTbiNi+zXd8Z0BkVAgM3ubxO25l7ztw6M/TQWNLMgzeMRatotkYX+4t?=
 =?us-ascii?Q?3eawdEfhlleJ7aTkmOQc8kapR7071rB0leUZk/FivTrPa7pbhMyAgj0RFb+7?=
 =?us-ascii?Q?K3YYVybvTrJoNAngGfnf7CiXJ0PU+AFQ7+BdMS9Dk10uopxGYCGGwLyDdk7Y?=
 =?us-ascii?Q?ETFnJeBd4FIepQZF/e2cTwBDs5CxPWy2tN82MMt95v71fMSoHsD4DFyMo4Aw?=
 =?us-ascii?Q?M20uBaL7mWozDb6C/G/Vio2g3nyvnOhCd1QKh7mQecJjGXN/4Iq7qLQqog0l?=
 =?us-ascii?Q?pLLjKo67Ws/Vkz5drz2xjo0eWl+hzIKwxGhNbQlomaesBeHENGscl+VJIDeL?=
 =?us-ascii?Q?PzQqDqZy0ph/SLrmQCzRpfoNiZqAAZC+zBp0HSFQDpg6qAhMQlxNrtNvv2KE?=
 =?us-ascii?Q?zEHEXdeCLXTwn2AHW5iYJGah8shJGRbV8J/l32T6qfsUTtllEfYkmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wz2mRdzUGrW2awwDwknKi5/x5J5Vl0/G1+Y0Nve8mk5kNdMe99U+DNgMsFm?=
 =?us-ascii?Q?vh5EU2RrsViVaCRPWGp6CxGQrmYkbc0m0/tlfbbhez5ROxmi/Yaw0DmjMbaU?=
 =?us-ascii?Q?VdOphAzGDL8yoJLa0/c1+kH98eOHgDfBRrNfl3+Lrg4l8UUg6eN3HCizfN53?=
 =?us-ascii?Q?oapeOtT/X+FhXs5ooglLa8xce8YnJNlQ8ZRN/ylounewq+3p3WitHgOfWHS+?=
 =?us-ascii?Q?yfCxQWqFm0xRmfS3Xa0JXzOw7kVOjOhldtoeaNhyS+4o3x+P2z2BHl11C7bm?=
 =?us-ascii?Q?bNISSpVsiC556jrn73G4oXwghQzBt4QNB789AyLJgSheNxM4d4PqA5Gk3Umq?=
 =?us-ascii?Q?mTDWeVlqob3Fsk2u21XTX8zjI5YGrODV9774OrtMAVPUzXmZKzJ3x1ipTa4H?=
 =?us-ascii?Q?7Drt66uKYWTuy1CtIK09CpJSgXTUcSEnzuhMQi7XGUBTPGQFOi5BIItKmzNW?=
 =?us-ascii?Q?TrROvU1qvXDzhuxY+tzh9Ttslm7X8uI02LFpSLdrw15c/2UtBcBSyUal/Ss8?=
 =?us-ascii?Q?w0hlnTDQG6RNCbRJASEVSXDf2ejJyzbW8CNgheCPUDymbF7/kXAHDwebYtG4?=
 =?us-ascii?Q?c9E3jPoSz6k1PqLNpytOqIaywDzsoAR185ma+x0MIQgp3bgHabNsb1k8mP8z?=
 =?us-ascii?Q?yoaLqu7Tfw9V7qSQzKMonQZQQdRmLI+RQTuos7jDeiuyEpSTvDdWqWNZCMGC?=
 =?us-ascii?Q?Db6yxBhSTIcGVmPuqKu6kB/Ew0ljn2u/Kjma2vJKfl5uxRBvD9s+caSCMw8U?=
 =?us-ascii?Q?BHWp6mnKYQA2m6ou2lVPQhL8VaFrYTcJ4sD0Q6skjKKvoOJ6ZwR4UrLDzXLJ?=
 =?us-ascii?Q?JiSx8GwBlpvngSgH3uHKX6mwzPyfKd1MjsCC5qH4FQHBnShLzWVQa8JIKmfa?=
 =?us-ascii?Q?2/+yBRbA875hjJwOoVwix/94vx5IDmD6rx0zxZLg47agm9Dh4nu6CVrd3hqV?=
 =?us-ascii?Q?lurT/Fpu10KH5DtoPBViHjDZu1iahLpPED+vR19cNsWtzAgMfDxZDGEc/hYi?=
 =?us-ascii?Q?gjsBc1LQiBMbHxeJ0XMy7OQt69S6fnxFmkCQ/TIp7RLjLHgegLxwP7ebgh4J?=
 =?us-ascii?Q?ZU2Zb+/DhBw6HizymlabaKj7f7jbky5Tp7HErtlVK2Dlswqd2gpRVA4aqDui?=
 =?us-ascii?Q?r+mh3121Xygmb9AJOlHyVtMFiuSJ7+CwyMjjDlMXuIQC5TJp3+YHoYAQHgmF?=
 =?us-ascii?Q?jSqLlTNO/bClSdi8OWaEeF87QXTQHuzyJQNu+Ve43enb3c//BgtWTWoMgv2J?=
 =?us-ascii?Q?tzfKCApWYmP8gAq+2YWpqhQzcqvgey/vKog4xs7YqiRVHf2w/ZIgfhGjQypd?=
 =?us-ascii?Q?mkZ9EaMA3pu/eruhGExXTLcJf2mRXGuLjvODh9Ta0SAq+Ku/5o0M8UkAdDJc?=
 =?us-ascii?Q?FUqdL9enFgfxKa9wqKXFr/uWcn3qDYESByMreoz18bLM8QXrKeA4/yzaba7t?=
 =?us-ascii?Q?qnwAiUFg/K8O2aBxXt/b2H9JS4Ecm+Y0NLGMsRVZof+bSa0n96kJlFniDa4T?=
 =?us-ascii?Q?+CEzcwTikndDZPU2qUKZCXxEGdNgOXtE3kVcXu+sZtH12N2Somb3ADWz3rUT?=
 =?us-ascii?Q?nM4PRmgDw+MziQQOQOB3EvhxnA6olxUMSEqHds0w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3857c046-8239-4134-a1a8-08dd7bcc4f88
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:19:19.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltNZKOV4gkEUzr8ziNplu8uZj3Z/O1Uy8/WTyhA92ZB5p3O9VH9fzbncdmCwg5xzSHJ/4EWW6srlndAU6su6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7106

All cleanup paths lead to btrfs_path_free so we can define path with the
automatic free callback.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/inode-item.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index ff775dfbe6b7..c702597174f7 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -442,7 +442,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_truncate_control *control)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
@@ -729,6 +729,5 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	if (!ret && control->last_size > new_size)
 		control->last_size = new_size;
 
-	btrfs_free_path(path);
 	return ret;
 }
-- 
2.39.0


