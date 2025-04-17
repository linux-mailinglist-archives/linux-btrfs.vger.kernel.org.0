Return-Path: <linux-btrfs+bounces-13141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C22A91F1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683DF442F6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899FD24EAA9;
	Thu, 17 Apr 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M0LXN8C2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013013.outbound.protection.outlook.com [40.107.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DE33FD;
	Thu, 17 Apr 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898842; cv=fail; b=a64DkDEqDrbFUnNhFqEgYLzPRVJ07o6YYsGCZjIXtXiyJs2LW9CEcZOpQQQ2RV813/aX6OFvzuNib8m8CYz3qc16PGOeYiziEjI9duuyK9wet9EBUGfGFmruQd6f5D8XrrqCk0cnSLx1fN38Axlq8kCe8og1G17t5wkeAOcV3Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898842; c=relaxed/simple;
	bh=tNkoVIJE16dmSSuC48hJrIOR6UP38GLDOTSIlzb7l0I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xxq4e/7UdNe/vZX2MIG4cZroLX38bw2abtOVLtNVl0hfRYf8hLMw6ZdgdwlXQQnIb9lNz7nlFk2RZCLA/vNJFb3wsxWV6LS9zrD4nHidLOrAgGXDwwvSqkr07SfmxPpCxNP5xwYIW0P3j0z3fg1Q+qtCLGEbrQZmcB8TdmrnYWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M0LXN8C2; arc=fail smtp.client-ip=40.107.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQFYgFnhZV9n+EmFcJSc4iAw+wyGPKoW1R0HesZczs7zKIIswXzUv7ZANqBbCDNPT0y2qg5xOVIJ7NnPQfWRxVjPbAMfDFGEkdWc4U/nc0d3Lv/JlEZA9b/I8TYmHNLuInSm2q6RPDDRePfuVk3RAZH/5GdCHNhf/YPUX903vv9SdM1HxWOQXujVq8bL+tCVUf7olMTpkUHyFaWl32vH7KaESWswphVzW1fuRcBgG8Z9Ue7uy+UkeuQx7yqcz3gBnf3HXMQGn96UVfA+8bdaQiGkmzvBFXqVaY0A+runl/yMzUFfmewHrzlvU8ITmNOk9YxhqNKqywIP6LhGjxwXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm+OnGjz0Zre1FvZk56i4mu1N0oc2QN1pi0V0tMw8lE=;
 b=prCzGdGZ6BXPlbBmueXWNAX8fsmu/X8ZZe0pQJr07v9m018jZu2+f/pKEb3KVpSAWuZv1GVz7h8xRxR5gC8BAhy68DyLEI03HRzxZfRoWB9mbSWLq59SfzlQsUJ7APbUbXzpOtmxG4m76v1wtsZOER28rc7VQ2fXvAiAL1I9yu7D6BAA70vYABtHQV0bSVarCEC0KthiYgLoUNA+L2EY2MCDHho70nq03Z4zIyWhCaK0E7INdzfOv4Ocl9AiuoJSxv7pN94Kp6zwwUIWsYYxecNrnykgN3YAD+teG/JXlgxvVK82NXrRxc/iuMpxGBch7bID2FoYWAE2Yw1KQPVm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm+OnGjz0Zre1FvZk56i4mu1N0oc2QN1pi0V0tMw8lE=;
 b=M0LXN8C2OErogBbWAdL5TpaDWubEJS1Jw3ZVY4FwqvYOVTwsWp/uhnpS7dt4oQW2Yh2JPq7lIVWnzHa3abmus+h0U8TItcVOP3Vpv/V8zTlllorz85PIHFbkrW3l/dfgQrjnAb4Hc+oA+l6huNjp+ENw9gozIIqqmoiJCf0IXscBipdEq0siu7TETMiK5eyE0yElxgo8ejyjGmD9jAAs9DfCxc8AXxM1LavJK8AH8uhPjkoX8eV33pmVGxZlujGyDf/q07yKJ0cxVi9PC8PirQHIy6txVkj64Zu99Uv902NkC84jghxt5M/gR74bnauofB0Jp5CJ0JMarPvDQ/BK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6585.apcprd06.prod.outlook.com (2603:1096:101:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Thu, 17 Apr
 2025 14:07:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 14:07:14 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Date: Thu, 17 Apr 2025 08:26:49 -0600
Message-Id: <20250417142655.1284388-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb9007d-7e69-495e-aa04-08dd7db92743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L4lQ71iQcvq8x8ASTzTXyatXJ89DgaAqTajpya1QXQgcsV54GGlqrA0PhhxJ?=
 =?us-ascii?Q?7SacIc0vfZaRBHpXIYn6bk+zyII1g6UncaX56Ua4n4OFL2aAtxaQgv8sYI9X?=
 =?us-ascii?Q?xMA3nr05tZ5BKgH/nROyYERt54mfLKEecnp4VOOdvwz+lohjYz6vV14zIUqG?=
 =?us-ascii?Q?877HuLwSI8udUNHt2W/hypn1+c6Nm9nWXKvwmIo5kew1veDI2+JpBIJPvc7l?=
 =?us-ascii?Q?xT2gOuYeuNMvRNGzq3iU/NLnEXl6TtRHlBInxe8Xde329aX/c39NYNjoRyM+?=
 =?us-ascii?Q?zRtsJYzAArpjc2om54Rs6YaHc1p6GuCpCnBJD+GJ5ntbvexhwVt+JPlw7LMb?=
 =?us-ascii?Q?nSgtUvT6zH2iYyAgwbz1huubqY8ACGj671ONgQ7PeuNuRq/pnzYJDvQN3hKm?=
 =?us-ascii?Q?MeISZjwixQp9rwYZZPy/STHTkGX08XAAiHPB2Gfq3XtMpaswkNeL0MCRXRxX?=
 =?us-ascii?Q?HtVQap5t13mvOIWeIExt6cWws+zLnFVQ4UG/kS9wxLKADsX54m0o+NICl0kd?=
 =?us-ascii?Q?wMSApjGCvUo/91OUvm1UDoZf7ZoWNVxz4c9aCz4QRThxJK51qqhUIdSuCgjr?=
 =?us-ascii?Q?2tNZxUgpyBcjnQWqS+HVEd+j+JO2/JfhakTRKkFQ5QSUOwpueGD3Xdbc1TjT?=
 =?us-ascii?Q?KvIlVoJGhLj0Xu9l/N/XSLdEoNBbn61HZxZjLS0RWY7VKZZU2Qyk3u6tFpWG?=
 =?us-ascii?Q?ZOg5itKctkQKO3ukQL78NfiY2567BLAIoKoftC4PvRcgB0GH0jkfyTZHco5m?=
 =?us-ascii?Q?yTaIkT6VFJjS46mgcQgUBd9LS4OBK8TDLwyjPG7kl9BfxMNsJqDeK1n9mDi/?=
 =?us-ascii?Q?7Re+Bpp92QFH5kXAicD8Jasbg8Bh0zrD7nWPzd6TVNo4rGlkTzVThZI8Rn8Y?=
 =?us-ascii?Q?TfzvP9ncmKhIAFpfSH/1i3tNzXzAOnsHrrAQq7gU0asnLSffyGT8UFgAwR8q?=
 =?us-ascii?Q?tyUKQzNprfpJVoLWkSyP54YbEJd/EZr51P+F4rwVi7bJ73kYhk4o5izCv7lU?=
 =?us-ascii?Q?egqk5TxtcXYZIFw1tTufhwUtsm8ZXMNnW//p8A5I1BpIOEwBFdqQ5D97V0Gq?=
 =?us-ascii?Q?gzh5S2/F+ceCkaAVrVWrGk1P1qndjdet9Ej9z0YBpUyn/JL0oeV1LGcz1MOn?=
 =?us-ascii?Q?6uawVuvMdBLtUkKweFEzEN6h3pTXdeyp75WsaopIEZHe8bsNterYVoULJV/6?=
 =?us-ascii?Q?TXM/F01yaBuxMcJ5iTcCNiWISGmM0oz40MA3HsVw41RiIPBS71HJHLMFWdQ1?=
 =?us-ascii?Q?g7h3L6FDVVJIKj++CqDj1rT46ZCVMB+yS1OlI+Ss+76fRjtOmPXJ4QY4PaxL?=
 =?us-ascii?Q?gfEeO+1yZQCbbZlGqVMW5FVi82h6LzU7W/ttT6sIzwf70aYjr4SsJooCpa1i?=
 =?us-ascii?Q?sQf8tnINCn3HEQJPV9+fzM9tCoVFhRUNke90YYckc2C4+/zgYBS0kYOfwVVC?=
 =?us-ascii?Q?cNWsGKSH6YmQ8fsfGqS3ooWUYzsxxHMCZGr7VHoscOCx+Ebul3JJrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eq3iWTC3CiUO1dnaMnrfB70GZYfz8kFBGs6as+uquXuPmd/BglGT4ZEU3bwD?=
 =?us-ascii?Q?JaAv2FyJh09g21+iEI1RCJjs5vv2i27X5S4cU4WRzJMDTNPwJih+3MaxXRMO?=
 =?us-ascii?Q?Vdm6wSWckLhTjlxKfmEMC2DOnrf8/mI90CbDnsqfkvGNpr4LZfWCirQlmCq/?=
 =?us-ascii?Q?Kr3zwKRWGgHJmgjg+X/C3Hz5ovxM8HxwTwJmeKslNltiatHxk7AzHVIEHBB1?=
 =?us-ascii?Q?17Nlk7Av9gy8vzurA96u3o3+1zP4uVcYakFn1mr0Y1uFPCFdcXxpmYRyPiVf?=
 =?us-ascii?Q?zJwKjxzUCrdcWrJRyZIEJwxO5vDfGqGJdbZgVxcwRJ6T0jk1cWwLHlr9eeeP?=
 =?us-ascii?Q?BdnqFGEwPn73prgZfGoeu/GgaM2k9TvOeli3blzSWA/ksIIxXj9E7iw4AZz1?=
 =?us-ascii?Q?iUiUhiTO34mhyPQ4iVHk/P2cj0VWr7U/h3GDjqQkC6cg+kHYIm0b/muzwET+?=
 =?us-ascii?Q?F4phupoofjfB79ldUki1SITk6/of7rgwRKYWggGb8jnmyw/Aav/KoTjGkx7i?=
 =?us-ascii?Q?jA4UYT274mV41RBtEJP6aO0tEnA1GuakqoVsZJEKwcGt1l5lzNGAA33Mxkhb?=
 =?us-ascii?Q?QmusSCqeskgdGlQ+JsIwwC6czNZrGkzAZ32eRewcJcWeZ1k8vjskCsmLUlYL?=
 =?us-ascii?Q?46RKre80leZw7uDMn+VMaRJU7IQl4/TAQqMIUrenCtwoQTN9vPxKC+74RzD0?=
 =?us-ascii?Q?xaCHuj+i1HL276mKFP/sjR21fhTWDOot3CTwSj+FRky95XK8Ndv5fLCE8nUb?=
 =?us-ascii?Q?ptRyCWQlolBcViJbFqcdg56ELwQHjVsaqoL9MLUVsoHOVIHsiwo36hjjy7VQ?=
 =?us-ascii?Q?9sScRtOTK1s1HL+GvgnrcKj9KxkqCH76ZxDs/qh1AT6gIvSz1pgkL/LWiw6c?=
 =?us-ascii?Q?kiJ5QDlPPWEmZFk5KKnrSJaCW1Zmd77BbttfGWlspOEAvm1kXxiyPABuv6Fw?=
 =?us-ascii?Q?7Pex2ekYRg1zWTM3mZY2xQcjwiBbj6IZjVKJniogNJCIxDx/yaZCs4d97ZMn?=
 =?us-ascii?Q?ltZ5+8ubdqUuajWhkIjv6rtXmt/jQnBcMjlZj5HkuXs6qA+ZTC0rJzp1eV1n?=
 =?us-ascii?Q?/bcBU/6F1STrTtcTKXk8xbb/nEsE/E9NrCY3YV/P1SMvzG0z4bjzwQwYsIrr?=
 =?us-ascii?Q?+9qF6O4WJtLYRF+AbtEz372aa4hR4RdJezs8ZQ2uXuC3IS39aRzJWo88BICx?=
 =?us-ascii?Q?Ire+48VO/AduQX1Vd3Pjo02zlzMciDPByp+yY3uMNteLf1FS/9YqRrmkJcyV?=
 =?us-ascii?Q?5UaE3GSEnDReLhUh9f2gPwoKDIITwKG+LvwPCcfIHQsKmmoCX+5hEmbAGRHp?=
 =?us-ascii?Q?VJFg1cSMoY46uM/A4//B6zUgjcEvlsnwatv+OWTZWH/+6vQByVZd1YFuu0nN?=
 =?us-ascii?Q?TD0inSY6Qx1RW+BRqhPynv/O3hP6cnBiknwop8Hob/j8VjtWGOmL6omfm5Wd?=
 =?us-ascii?Q?2J+jjjHtT9Cbxy34m/nKfbFTtVr2NofUI9XjMvBxjAh+a/OYIrxSSLSK16UN?=
 =?us-ascii?Q?g0ezC9LWW3WOWoQapmr4ItHJ3BYD+8o0dtc34yitsy+F77DsjZASYzd0XXpk?=
 =?us-ascii?Q?O8EIOpOthZy2tCZmpHyHWF7GZeCwN5T/QYuccUkG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb9007d-7e69-495e-aa04-08dd7db92743
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:07:14.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAfAWK/6urR/wzx6k7MukQr0ywCSUTzyAXMIB9rqeFjvQmZzAHbnEjUxh92k9731WkLCih4gWy9iXCTqMAIOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6585

Commit b28b1f0ce44c ("btrfs: delayed-ref: Introduce better documented
delayed ref structures") introduced BTRFS_REF_LAST, which can be used
for sanity checking.

In btrfs_ref_type() there was an assertion

ASSERT(ref->type == BTRFS_REF_DATA || ref->type == BTRFS_REF_METADATA);

to validate the value. 

And there is currently no enum or switch to use the upper limit,
so let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/delayed-ref.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index f5ae880308d3..78cc23837610 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -262,7 +262,6 @@ enum btrfs_ref_type {
 	BTRFS_REF_NOT_SET,
 	BTRFS_REF_DATA,
 	BTRFS_REF_METADATA,
-	BTRFS_REF_LAST,
 } __packed;
 
 struct btrfs_ref {
-- 
2.39.0


