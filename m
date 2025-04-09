Return-Path: <linux-btrfs+bounces-12923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115BA82513
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35BA3A5F6E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968225EF97;
	Wed,  9 Apr 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f7lwI6rw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011041.outbound.protection.outlook.com [52.101.129.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0A15689A;
	Wed,  9 Apr 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202282; cv=fail; b=HFdEN5RpZhGeEU1UMJeWVCn/nm6yF9nQEpvz/55JpXWSUOB6QGi3hpb58+wO6RuoFx36ZYm7GN0G3YtDamuhV2NAwwoaN2CC2JaDDh/peOCU6pvn8QyYjQhIw0IG6W9uSKzoB3v+Bz22WfneZDYscpu7AVsGZF7fJHsGz5l+0vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202282; c=relaxed/simple;
	bh=H15p5Dx2FYmJzzdRNudfWEhSKUXYAxMdvjxMPBTLveI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lvCwuqdStSX86Q7p/tlxVT9sfZ9eYEdCMlUGzgwaShyBrfFr64jSV4YOk0Jsiv1PGVVj+puTPEPISUPS+4NsL2SVTe0SG+3qfE4eQy4+IO1NgFPOeeI5Z1xIw+/uViGGTZldfJcw46IoKYzZ8cB3y0vhDmcBPbfBqGP8KHNU6uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f7lwI6rw; arc=fail smtp.client-ip=52.101.129.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqfa0Jl7Zgh0GzzaA3Zr0ZhcfiTd3OejJGJOgkBExD1Gn9Lp0kIOUTBdGgb+msJM/iQIE8dIAvGx3PnovXnm6uNQJP4L201VoIGD0/Jh1ruNqfI8wdaqe+1IuGQG+UOfRr/mX5bHcQdBRWRjgFOt554HWePMncXeUTcQIWhkb0g1yHU4bRzYrpP/72rGREQN2422C93ysUYQBgD/1/AbOjSZSZa9mQqsakk5ghMB0s/x8MRHHHC2apPVx11+8tdYJ5AlHH/Tmv85Dwh0+1pyXRwddNzxpilEtp+gmdNSZsLwXSwYq+cyyhiUuQ3qPMaFhLE5Qs2ShRIBMVflPIUAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPjFlqnFRDkqconjnOtiVz8tD6UxFCF0epEZFOpbUfM=;
 b=o8ANLvwApw+n9LfPmbHTWIhC26NuqMjLc/2tmoARWEYSKDoDVbi2gJbUgi/LZGUnchXB0ymgUzgdnLs9W4k7LBh/kNGidSVBPjicm2VW16+No4ZKaoqaRx71E+hSjR+gmPOhevUhPmMMNSnMbPW3GWIOkDdWs1XFKa3e4SMwC+SgIXpLzSiOYB08FmhRdFfB3hyH8lOxHwcq964hs+ZnM4fkfDZfq8JwkswKAqMFwTorhJhR3Y9k4tXwileee+Vm6J2/dN72/ilWLW8EeFESAYdIu8nmcG365ENKTUkkiBs/QTOiXo56KLI8DZgEERm6TaGhkVKethLuM+eoREN/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPjFlqnFRDkqconjnOtiVz8tD6UxFCF0epEZFOpbUfM=;
 b=f7lwI6rw+HMIlPk3VUXcU2D8HzMeElfI8EOe5GpzOhyvNnJIYPF0XpFVGHEVEDTMQYRfoO/9roHTT2aU3mMOQ6hnvsYhq7MMAab9pl+PEoBWaWMZ3devpnJEHAIK3GObRCGTibvthvog+jNPBJZYCj6VzPXWkclyfgXD4wnzPtx1K5Xpjgu0ia9r+Epm/Ee/Xv5R1jtX/jzoz8JS8JKJeQz2DJeKX98LBdZgwCbchTbT+pTrM7SNdbrXkils2k/hD0N08Kh4xQWBB0dy++vCd4vOlgv4GMP8QMHrhExBSmkYDH1EfXr5oP9geHLX9kbjdHF0yKCTrbbNCuYIdzcrsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6744.apcprd06.prod.outlook.com (2603:1096:101:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 12:37:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 12:37:56 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] btrfs: convert to spinlock guards in btrfs_update_ioctl_balance_args()
Date: Wed,  9 Apr 2025 06:57:22 -0600
Message-Id: <20250409125724.145597-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a82f18a-3d6e-4e96-da75-08dd77635a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8ifgudHBlUZoqQ1ibbC5L43BzcW1M5lbgfDlHWkbGZS98kG1QKl9pgje8R0?=
 =?us-ascii?Q?ZE3jz0WklrqVSoHetDGp/t6D18beQ4Sl/Ud+j4TCIrf36ctaJ3ptcxFek3Da?=
 =?us-ascii?Q?F0+xqdqqCsor6xDqdNtpAE2S02qDYenSOqTUyMke0hlIHoyM/zGxNBj3Ddz/?=
 =?us-ascii?Q?L97V4vWmmX5/QVklq8JhsoD9w0d8VMcXTehX47yGO8/Wg+rrpZ/Tii70sVuo?=
 =?us-ascii?Q?b02H0JtkcMupIC/6pAO88M02CYj1Mcx9qhclqLdLDt2lO+WfMufutOkZ6kdQ?=
 =?us-ascii?Q?p6/USOIPc5JtlYJJuZeUFKW40dDkvOQYYf6TVgSYzv/h0A0bAcENnuGQ3+PN?=
 =?us-ascii?Q?2TWql90b6OIomuZHnj/z5nOQrgppTxDzazxWfv071uf+K0GcdY7zyhd9Tz/i?=
 =?us-ascii?Q?+b+CKaEXos4nIFTK8/7QFTYhcKzsjwMPqf7ena7djbo04eittF0GrPsQ6SRs?=
 =?us-ascii?Q?OkC38MOh8FebLMnppclrCGk9/And8QiEEQ9ET1kob/UxiHSBr4qEJDHtMmFA?=
 =?us-ascii?Q?UW6FVT8w3Qjuo/vebxxQJ/4mQHM+KqXLGITN2Vx6rkJr4TWKndzAfjbvsFRj?=
 =?us-ascii?Q?rrqZ+yjp/ZixkGARQrCwnpMUUOhOETqEoCm56Ly4l06euG0ocwywYWyIpLT0?=
 =?us-ascii?Q?pED/Q6mwrsNKUtxx1LeXkSMsVX3M2SDUeeirQmjvfsJrc1ulmkA2c8gqHMuK?=
 =?us-ascii?Q?qLGX8AiMf5e3X2QvZqQxUSqcRbxz3vQhtGGHXOF9CrcVXtOkZFy0zkGit0XK?=
 =?us-ascii?Q?eW8cj71hIXxqtQg9myyMxuMapPSBzcygoA7AhNlEjZHsTKfkWWQJntLn7ohh?=
 =?us-ascii?Q?WNQAL5TwVEKFipWK0FF0XbdTwXhxOn8rlxNojlI7Rriu9cAZ2f1W5ramHE7W?=
 =?us-ascii?Q?sa95aAVxPwCQy/Wq/+ulqvWJeCCe3Dk3UImF9i2gpHqjwBERR0CaL0gavJeD?=
 =?us-ascii?Q?7WP8ZoyJnT7WHLRMDfrbjUEZ0tvLYNy278eZJr+Jpa3PRZXenJa0iFR3+cVq?=
 =?us-ascii?Q?WxQctj0nBKgZKA97mK4TJQyU9MJDTjH5E//M16UHlSAOixuxcSdJt3eVxCSs?=
 =?us-ascii?Q?712e0W9BMgMiDWq7m6hF3bKd+sPvKYZuu+LsvHdNYT0FPlrUP3DrDSliInI2?=
 =?us-ascii?Q?Y2crp0t7hwAEyISelF313j61GJvv1oqLa4po5NTH/epL4k4QQ0OMkpncBkR4?=
 =?us-ascii?Q?C6vhSeqIYbUK5nNgROUb+DyyPoA584ilEG1IJIIVoBr6i+jT64eL1twtz9VR?=
 =?us-ascii?Q?cMcHjMunsXE6GeIjpEMA4xmSZQ8I6HY31KE6KaPyeadGt0ZpJ+pttvEcEGwC?=
 =?us-ascii?Q?qzdazVOqRUhj8fK0de2GONYYbcOrAfkjkjqzmxp5d5mYSJEdkrkY/lYPHPDL?=
 =?us-ascii?Q?2Uf4rbmgJNwKtMLHpJHN8U2XatuxLv1J0MSjOKFfx+K4poWIg/RC+T2rokzB?=
 =?us-ascii?Q?LhUxVTLWr4phUR1O42HWjDorGmtqPqw+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvFTXY5Kla8w2dfLc2qw/8xWMRTxFTrYuC/jupowqroeLmiE3BzcqEoGnV+k?=
 =?us-ascii?Q?EyxrBMOcj9ebkQmPHtdy0i7tKe+oVE3o39lEvNsFby9bQt0tYWN1U/ClbG3X?=
 =?us-ascii?Q?7Lf00sg2w5yyIw851dZQut7oQOy6+shSve4Cdz9kDDllJMXbOS1hjyj95qK9?=
 =?us-ascii?Q?L4xu91qjqi19jH1arIc68zLwdVZS3G8Sj/LniblIzuJ0SoQCr1J6IyCU+T6d?=
 =?us-ascii?Q?VPfc6yFX8JI9gG4eVWdatJJCWgLLECincKPOh1b6SMB/BxTFrsUAd8y8KuJP?=
 =?us-ascii?Q?hbV1hvHXLs2B+WgR+hkwlE2VZvB2Ol+nc6IwH2gWSXLNJsCS5eCfYvXcoOWo?=
 =?us-ascii?Q?eaj3zSKCdwM3R+CtSForLJR5qBef1eOLWPoFoHHBAt8yxpqqrRwnLNFHQ+s0?=
 =?us-ascii?Q?kY4oI7aGIw1DQrPsTDEe5EoL/+uqAWUt1R94QyQ7eLV05XJEDqoxvlzs3UC6?=
 =?us-ascii?Q?ZoivfbEW1SYzT15xU/fDrbhV/4KxTNh2IzY2HgHbItaD/QWgTVqKUHvtnBhI?=
 =?us-ascii?Q?QFckzzP2bV1IxPqaAq1o5qgjysh5+Ymx430b0+WraJApTtAQBpM/cvKZy/CS?=
 =?us-ascii?Q?L3+miyNLzKNM4TKmC6+C8kY5flJdWeYsNp1XR8A1r86/frxUwo5jaw35ZYMG?=
 =?us-ascii?Q?SR5WMQNGoHehxPxoYe3pulFzWkXeLNyAtSydjbdJSRynTNFpN5nMki4sWPea?=
 =?us-ascii?Q?IxRrL6Mzlk4VAXAashSQ6ZzvxlrvBkyhVaDW1vMUA1GyEWv4QcoysOyxDGQb?=
 =?us-ascii?Q?9oOj7S3OaxQhKVx/IugHQOYOAr5ke2Ynoj7uQQsfXsWOjtuOlfsGcAVmrjfH?=
 =?us-ascii?Q?IF2fvIwJJyY2eOz21RKULAW5wdW7Ym+tcFYXC/yTHLit/pe7To8s8XIcqMMG?=
 =?us-ascii?Q?k/cdBwovEgHPCJ1+65hx9GAe5g+92MHnEYkWde29ax0o8P6J1ZiVAKsXFg+I?=
 =?us-ascii?Q?CovqRmtpBGVdZn3nJJurQ+KRTZTu88kzR+hIePOT7tLIzdAdVZIKu21D4oQn?=
 =?us-ascii?Q?YrDFm/cx4DxU375+Jd2yUTJPdOEOFeCdqVTLHzlnCjQE7W0IN3bYpxG2iv18?=
 =?us-ascii?Q?rF8rupacZ2F7pIiWZNlEjf1/pev7CXL9qngVTy+v9Sb9MoMOOa/CimGh+P2a?=
 =?us-ascii?Q?sxx/e0Cvun3srkjyx7GTUHvU1+7XVLP+hlbsPl54IJGjRh1cFgBP5Nb6G60R?=
 =?us-ascii?Q?aEMZ5WvZVgUVuRRE5lht6Qj7BbbQki8S+yb76pe+iGJwzUVNRfaVI55FPac4?=
 =?us-ascii?Q?FbhXeu7O+JXtRKDXC8GcSuOSeXmqf4iGzjN+pOSIazQw2aOufIVjxmyazYaz?=
 =?us-ascii?Q?i5AgBRsOdSw3a61MELtbm+TleTaeJy//svDBxNnSuZz3c8rVk7jSn/4l7IEs?=
 =?us-ascii?Q?EmVHn5mN1HkLRqHKi/yXu/6IQiNiA+9w8/C+GVF9gxcJXOTKSWfTPxQ3dfJl?=
 =?us-ascii?Q?Aj2RIWmDPckDReNvmVoOwQNa7P2xX0s92XoLBNylxJc+oNqbAqaX7k1cdCxM?=
 =?us-ascii?Q?AZUouAbabBXPIAL5cvjp0lRraXX815qeA3dF6vACPL/1FkDoFDqprvF5rn5p?=
 =?us-ascii?Q?GY19y7iSGcPEB3WXisUMhZ2RhcwJK0tKJrUkcdJr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a82f18a-3d6e-4e96-da75-08dd77635a7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:37:56.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPOyp9ciS9HYH43xR1foLzDG+LzZDktqQzR6y1LuLhfGeEsUgyLbz40b1lhAaB+3xb595G4kU2CesV7kDjI+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6744

To simplify handling, use the guard helper to let the compiler care for
unlocking.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 63aeacc54945..7cec105a4cb0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3438,9 +3438,8 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 	memcpy(&bargs->meta, &bctl->meta, sizeof(bargs->meta));
 	memcpy(&bargs->sys, &bctl->sys, sizeof(bargs->sys));
 
-	spin_lock(&fs_info->balance_lock);
+	guard(spinlock)(&fs_info->balance_lock);
 	memcpy(&bargs->stat, &bctl->stat, sizeof(bargs->stat));
-	spin_unlock(&fs_info->balance_lock);
 }
 
 /*
-- 
2.39.0


