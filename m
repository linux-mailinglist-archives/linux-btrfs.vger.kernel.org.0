Return-Path: <linux-btrfs+bounces-16635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C4B450C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CF54820FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A582FE079;
	Fri,  5 Sep 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iJNBsQ8W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56821F4262;
	Fri,  5 Sep 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059289; cv=fail; b=sPjAGxNYSPwFFN84Mmxp4BRbD6g96IbX/PUUikUdFqW4W3XL6abikqOcP/MtJHIuZ4PuVsCr86SUUecff8JG8b1x+KVoepaAaoT7awkDlcrYYXJQliVSm7BA0D89c0m07IfFySYYoMF4H0j7IMWiotUuInc0u5zsXfvoJXMqgEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059289; c=relaxed/simple;
	bh=9TCV68f9bKDZ0HupN03y73eSk+cNXb3JHjW0LIP6gSs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GawA3dBlcjjRt/QC7DcztXG8bjAMsFBpO/a4avToR+dQZJcANgWXIS/kCFc4uvz17k0r2+9UyKKNQTdouDcxMCW6IndAL14YF2zMAvDMt9fhCMfMHZFvIRRXAyOrBFz7wz3MH/+XrCGCt9ix/MnWZYKEx9U2zE1lOMQsphEHrpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iJNBsQ8W; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDmpOIHgVO0Ke0Zb5TKclJ57Ddm/+eBpm/AkIXpvXK6uPzvv2M/I6HvnwU924PzA1nfiv7+RfhiaARauidTOZWhJMcLIcRC4wAMeV0D9lSL0rVj3q1QyItzKH5fxb0RMz7Mjq65Kl06gLpNF7x7b8qsiVagDSeqxw8xWPXPLHBov65suzU5jckDBJgQXjdw1dFoaGukVTYj0l63SPKuTmwMOW43Eolqu1JYfcRHI2B1j6SYnms/PKhBy7/pBapqnj4CE/A2VvXA77Zth5ikuL8UI1DvXmyCgMljT1hH7OAW1/mhOo9I5lT0C9P6XhT9CuovmopyiNqRBDjy/yv3www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyeeoqjDUcvQHdzV4Oryw7QkRK/Syv7HfUeqhlMWVes=;
 b=DBft1zAXKiT4AcnR3A8L/2wXpxJB41fVSaosdo5Ehnzwy7M/Q8J/+zTChe08ICXInmpXoy45/IvwIGvYxNJ+NjEOgBuEi3N/DV7Qll66BFkmuDUOIq0XkicWX4GNwrdMQSaY+rlPZAbM5gAgd+EjeIOa+D90eh7DQmzdM7QpnskIk2hOVEkPIXjnlBXTm4b+XUeBgNQJ79uLWQwuQXw2L80jN5enEdOsau3UYc0MLZajakO0N8lf/zuNAZ/g9KUD4c3djchP0opycW7SAs+J654n8k8T7mZIPvzrCqvEgN67y5dIkSWGvpJq77RO8XoxNIvFLPJtzJiqhp6gaEY2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyeeoqjDUcvQHdzV4Oryw7QkRK/Syv7HfUeqhlMWVes=;
 b=iJNBsQ8W7i3XQ9eav+V660ECmMZr7y/CW3UAEOzO1qPGEXUzNh5/7H7g95p+qoDKkLUF/TldC304FL1Aim2jRyG2QRlzwp42bwO1g451hN7ct0E5Q3x8KRXNHGECBCX8H/lwURfr75yQc9kHuy1fxpJPTcrYjPti58R5ceNe7NRgVXz6SyO9gotfLhPJjq6LeLfufUza+jzqh2ochvyzGFgdTM5AGyv32mvZqrJzQtrsUuwzOYKkUe8/9YMn6V6OJytZXfOjdXJoCSy6bPQBRle2avBDDdrWM/O8t9E4tH4YaTVQYPtKnmwP62rjeZMhx4Px/sU6MLA6gdjmqd101w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SE1PPF04CB78479.apcprd06.prod.outlook.com (2603:1096:108:1::407) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.28; Fri, 5 Sep
 2025 08:01:23 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 08:01:23 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] btrfs: remove redundant condition checks
Date: Fri,  5 Sep 2025 16:01:03 +0800
Message-Id: <20250905080103.382846-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|SE1PPF04CB78479:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ebbd34-111f-4363-336e-08ddec52677c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kLlQgK9WPzYYDA56CeCZKh89pD14ddOJmyMWXki2iWZiWC+Y3erWVung1UDp?=
 =?us-ascii?Q?sVC+/qcrao8wBE2+XPIfKopRg5v4CfimVNGOyPk1fcKR2MOTVOwbxYMrJOJx?=
 =?us-ascii?Q?mMe0OoRc9nZSejDhhZMvzdokxNCQybWCoLSux5lMOg6G8ga7d506d7N5+0lo?=
 =?us-ascii?Q?UvYkEjG9TbDSvcG3j/hQ5SSXT7j+8KrxYZ9IBw0EyiZL3d8dq5Bq1r0sgW+2?=
 =?us-ascii?Q?e2zaY5QwBiRoJJTs/whpEzF/CUtWxCcl3f6D89BvwLv1Cu/zNtQ3GsRg/uAn?=
 =?us-ascii?Q?1ShMv5qspZF5HrnbYFeT5PNwwax7W/P2QlljWS7lt1xe0Lq2EWjUuCVd2dAH?=
 =?us-ascii?Q?qzyuTVMqVLu5GJTb0+eJLcSnwtsKusFLc96ss4cdkYSgq1N4pXLMaZVPKMCU?=
 =?us-ascii?Q?JeZvl0qux5cuXeRp9UYKV9xn+vExNlAJWcU8YZuT/yzbLeniACECXPpQ6fUW?=
 =?us-ascii?Q?3gfhsTmuMZ8AXAwbNXor1SOf2nS03Kyg11Xjgx++BSv7305eSCpdBIEAXj+/?=
 =?us-ascii?Q?xh7r8RyPhRsQWchDW2IlQyU9ng/QbDjvvuZVOhON0p51rSlf6w5JQYoUdNFE?=
 =?us-ascii?Q?akNWDBke54fmJgxynL9FrtgMLhaCMJpzvPoo0bqXQyIBGONGpevX7wrqvkSp?=
 =?us-ascii?Q?GjU3kkdOwfAmfUSoL6a+EGw6Yt/iTex4lwI08Ghum/u2VFLGW6u8JjlW31r+?=
 =?us-ascii?Q?ApoKORkzaEtnI/+eSfDcrpVaU+UlgbpOWgNooLJPBpsy/Mn3LJOLbQEwJjuZ?=
 =?us-ascii?Q?lRy4osap6nw3MQl23mxas2r+2C9onQw2mG65ajHnD2+q95Q6HE74R+pgcPJh?=
 =?us-ascii?Q?hlUSE/EQd2hYLSrS6jekWh/AYYTfp0sfkFwYvxRUB3ZjgTp4WtFjD+8wFgkr?=
 =?us-ascii?Q?3j/TkBCNtzkYndl5s8qWjzWGIMjhtAF4kznnSYskJPuOaAIbCe04a3E/It9c?=
 =?us-ascii?Q?G8P/rMEnBK9d0klirP0kSbqGQk7baFp7GHafKUp+TD1+aYWspZLL/gG8tgyy?=
 =?us-ascii?Q?b7guWF/yM7+2YM+5+onWOXyrJIiZGjaQVOxxTSGhMUSD+ISurrs95M+gTeMX?=
 =?us-ascii?Q?/09PKpvsgt57aqEceZi8ryHtPZz2PN1z//0x2Hlam9daDQ4zMtA6qrcgLzOf?=
 =?us-ascii?Q?pqLJMeXFsN5brevOumBXEC488mnq9u9WEqznfgs4gu5gFKYa/1fXqfuMfCBf?=
 =?us-ascii?Q?LbNpN52Lw86k66Gkg1KXih1qLKEPNoUmoMFuP9Ie+fiSAt7F1Bw44o0bhW3g?=
 =?us-ascii?Q?vxsIWZjbqczn8EYc+YVaGrMFbXOZ18d1pTxtl4JPxcObM27nHEzicsszYYVb?=
 =?us-ascii?Q?W7ApQg7b62tT5bSPdgWlfWBu4JYKANa0yZtcBHc1nLrBDiYBGgvsvf+Y1N4N?=
 =?us-ascii?Q?BsMUkFwL/pNSRqE0J0IaUJJh+YTMY5qfG10Llkb9P+uvQM86/jSyn9vddaP2?=
 =?us-ascii?Q?8cW3hvf2rnqBneUNT6njG+Wax3pvI/Z/11gsxBM13YrudJSR8UGLgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlo4u/024J/5xqSqOvTkiWesYI4MXYLs+rhTABpqNH4P1Dr7QOo4aPlLjd1R?=
 =?us-ascii?Q?VxAf8GtKIPczKBmyjOT8zDcue8XaYRaH3h0HmLTbnw/tFiTN1rkzYrRqgRa2?=
 =?us-ascii?Q?feTrktgFQUbcSAgGXDD9/pQocPqA5699G8psrwCSsvILGkPrnorJHt9u2l0V?=
 =?us-ascii?Q?+4B/wTSGU3Y7hiAiiDAFApTmj1s0BEt2j7IEsaU9T727jcIeJs3U5RtzBCI6?=
 =?us-ascii?Q?3CjVr9oE0TDGArm7cepecMnblmT3uR8wI+aICyXiQAKZ2OR5Sq8yfEmMLWIy?=
 =?us-ascii?Q?bx3Hba/xy1wr9mLIqA+mUMKZhmjJShw1E2i7gfUsU/ug8geML4/dSHj1k5Ev?=
 =?us-ascii?Q?evDl/4qpBniy5G1fxFH74oWlB57XHguL46e6qxzR5lvqnUATYnnw8s8I+3yX?=
 =?us-ascii?Q?nY8AIjEn+4GZ27HAliAU5bFna/jpwAfxDw6uj8FAofWWHYi5XjhY9llrkQRZ?=
 =?us-ascii?Q?p3+nbnodqs36YxlD5HUEXsFhG2UuZEz2u0mzovubAXsKfX1ZDWK1rt6aOnDM?=
 =?us-ascii?Q?PhbFK39o2I3yAVVdiamc63h1uiI+GNEYDV6nLfsohAZJ+tYB7l49DuJFJSwt?=
 =?us-ascii?Q?SG9taVtsVNtgHg19SAAStSM7mJBUJqjiz1l+79MkXzRf3+GuJQ2gBYzeOai8?=
 =?us-ascii?Q?Vk50GUH3IKmAsYM0oQ/iRDRNrVqttb9uIPluigoSj11MIq4PomjgPM9/iSwn?=
 =?us-ascii?Q?ubWPmnN3kyP/aLzurTD+a3HjLfDsnb13drWbIlH8EU60sF9iXG+RnV28pk3G?=
 =?us-ascii?Q?wMCoJyNx4NDAGNm1hkDQbQ3kDyynTNVb1huBFuXsVCPAQmKt9DOVlxrOcGS7?=
 =?us-ascii?Q?vTKPrjGtYmz9vAW+sZ1QMa2M69SB8phAuJbAQE9BtmlWq99oFnEaYcmiZlfr?=
 =?us-ascii?Q?iCVwzZF5Yw/MZKxt16czEbWHCtb4yrrVIyWXYxtii5BKlYPzEfWMdt/bVKMx?=
 =?us-ascii?Q?NWHX7m7EviL49FT1bMEzl0/zBDzTskM8MwgrlaW/aRjVS16NXQCpKF8NbJQT?=
 =?us-ascii?Q?jOmuK+JsKtowahJ16ZhpafOfQwDnjB/S21tgHFuFresj10AmOLFhoaFCCFdc?=
 =?us-ascii?Q?Hy3GMiLCM+XyCPFL0H6eqbgJdlm7V35P26xPhnX1NwKDUq3Cq9kRIvdzT811?=
 =?us-ascii?Q?2Yknp94va3IxJUJl6L4QXa94DWZa1300rpSknTL08HqATchm5CuH8bKSg8R8?=
 =?us-ascii?Q?OVpiwD6A/oJO9T4oCQ8rxNi5xIt7ks752JMgz915G97boBtGMEAwbfpBOphc?=
 =?us-ascii?Q?ipK3sZfpwOGYuW+P3+12cf7Ey9/Oa2Ou1WnvFf0iYD89mgpJvCDYOB0XLxlc?=
 =?us-ascii?Q?uub6s7OLGIY9COuQo9MTdZVxnjVSOL1vKqWlTt5smA8LK0PqE51XH1B5rT15?=
 =?us-ascii?Q?GcL1z4ywcH6nz9R4ARz+6Aduozn3n6v+8kTseNPuKd35VIkfTeoAe8ljlMyZ?=
 =?us-ascii?Q?uAKrav1lin8WaSCldIUXOtbcBRDcd/1JI2esV35CIaAIWNWHJJbuZWhi6N3+?=
 =?us-ascii?Q?N7jBcv7g029fN9EmjKBZNOUHO/5lXqaDj5UiEzA0WqVKC2uGBEjxLy9KRWmM?=
 =?us-ascii?Q?urilNCjz4YpundmWt6jziViK4+LTIA+OM2u7YPMk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ebbd34-111f-4363-336e-08ddec52677c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:01:22.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3tWBD+tNo4IiSOdl4wTIFOXLM51GkRE5N6MgCuFRwnSU+tXIuUx97NbQx231/A87lXItnCsFgR87qf1qf7c4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF04CB78479

Remove redundant condition checks and replace else if with else.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/btrfs/inode-item.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index f06cf701ae5a..3d0631bf7389 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -531,7 +531,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			if (extent_type != BTRFS_FILE_EXTENT_INLINE)
 				item_end +=
 				    btrfs_file_extent_num_bytes(leaf, fi);
-			else if (extent_type == BTRFS_FILE_EXTENT_INLINE)
+			else
 				item_end += btrfs_file_extent_ram_bytes(leaf, fi);
 
 			btrfs_trace_truncate(control->inode, leaf, fi,
@@ -586,7 +586,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 					control->sub_bytes += num_dec;
 			}
 			clear_len = num_dec;
-		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+		} else {
 			/*
 			 * We can't truncate inline items that have had
 			 * special encodings
-- 
2.34.1


