Return-Path: <linux-btrfs+bounces-12989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6FA88065
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF173AE85A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6A2BD5AB;
	Mon, 14 Apr 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NEGIzUHI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011046.outbound.protection.outlook.com [52.101.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA51A2380;
	Mon, 14 Apr 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633980; cv=fail; b=W7QXMEJOriZXYLocNqUV53IaWQHLUcvWf08/thSsLXQW0/0tiS4XnSPS9HzY/yQJ3NUg4jzdFpIYBRVipjLAsUdSx7WOQbIcC6GxI3wMhdkCFnY6MnCcP2d/UkCnHhuuJbPvw9v1xkgHnY/PCUyJbLOJ5jWV1jlI65UBI6xVlPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633980; c=relaxed/simple;
	bh=b86EzMSHW7jbiprRxy0nz2bADBDM7alEptlC+wx+7VA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MTucfq64+t+iEW7YVdxPw4eXrH5jHMwdas+JqfH2EStkcHFWV72DYQPLoF7WcQZqiygmN9T/bX4+/gUg3tgfqX9yyG61pAVYHPg6DkKrnXg5A5IcAiff+b3aQVqXyh8wl2QpItfDH3e8s9B/tzP+j88yJ57M1lTmbYB7wLGW9F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NEGIzUHI; arc=fail smtp.client-ip=52.101.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg5NiRP7aoGV9TPjyDezJg7avAT2uiARLgf5H1NLsnP0DZ/ZIY3Cnvpz0uWVwqjAH4bqSl+ReBxud7g1maPKY/ihrgmMG6x46FNPIQyRBUhf4FvzsUeay82wiDjb65PdpAyiz8h9qMqAHtYlOHHrVzTGAo5G2i3+9aIYYFqfho3fpMC+QdI6E+Yvtj0Vl2pIredp2rILLvwl+TDuhx8QBOzBvGZmHgqg6QMATfq2TQQacGhfc4vuZb4+BqkOI5rBAHH2CZrUENHpllU+RzlGLpqWMCVDPTpXVjkg8wX18rLK5rF87RqpbcjM8UtlPnNFpTLywyUUbiJ/Ph+Y6g2qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsbqOnevddgjonm9mjUvWuAajdj+y4Bi/5ep9tbc+js=;
 b=KT7wcqstgqE921Pw2mlOSeAq7onFye2APOFiZ4eNV6Cg1RWkG2jK/4upK5ODpCR4CjsXQ0TmjbwNCh4Tx2hwHCZNSUPVGi3wX5SwUTklqxFAzc3ADQg10JCG/diHEJSNCXVMZvXSmuYsHrrHGzMXcUS607dvshjZqnw8lwTfiUjyEIduNOlWOQyhDsB3pZ0J1eqbmfc0vi0SWDPULCJVqY6/V/4rcYYl4iRUvUW2BtajBKD4HzbxbvawwvdDplebE1FhCN4hh4eX4bbMjzXjObSRT5qQ/XdTPre05WNg0n10X5VFueDhotj/amQiPfdLyBeXSTuef6gHZc7SBhC4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsbqOnevddgjonm9mjUvWuAajdj+y4Bi/5ep9tbc+js=;
 b=NEGIzUHICghoawtMwVh0IZbjY54HxEWpKH+Q3Y5/CbB6N2Iepu9Jy2Cp30MwAHxMxpFaN6x5oeSrwOzUqlY4LCzIThY6LP80Z/2Ii4CihIozPSU+SuTnXbiOtvN4u6r3P6V+6dujLtxYukI3S7SpBlT38xmyvnxIksGdtUf8Q/wummQ7AWYQ+3Vkg/tqU1ltbffZF0RTgYJfHwJ/DQ1qQ8nhAv0GVV7JCnSoy15HUYELS7AYCuqLKWdN9xHp0ztaFggDCYCN1t1JldvTktvu66rks2c22n7h11qvFMWSm8IzS2eQqo6hV3Xb4NNkBgFRSLxeGPrYUtkypkJdiM2LTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6759.apcprd06.prod.outlook.com (2603:1096:820:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.42; Mon, 14 Apr
 2025 12:32:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:32:52 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] btrfs: simplify return logic from btrfs_delayed_ref_init()
Date: Mon, 14 Apr 2025 06:52:31 -0600
Message-Id: <20250414125231.740999-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6605da61-10cf-4fbc-2ba0-08dd7b507996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14vzncumySyp72THlmKTat77rIopYzhgSXZr58xdr9mHqh7iYWlbgVbus2/z?=
 =?us-ascii?Q?ZVlSSu+KW0riZbHy/lRyYTA0KvD1eqODxqm/Ojp7ks8Z3u3o3NxULggsenxB?=
 =?us-ascii?Q?jMBlMWadu2Qi22JeCtnhhkEqgFHeYsAilq13/8eidu9oNknTzDWyeAcRvyMA?=
 =?us-ascii?Q?IB/Uvj7xdDOYa90Us5r+Wt4i/voWU8+LXzTG5s+wXLSGVgiPhh+rTitx7S78?=
 =?us-ascii?Q?h9+M7yePO5zB+1bVvNQxi5B9Wc+fc+uaRgpLSe696vT3QBrq8ove7ohi6n02?=
 =?us-ascii?Q?zyR2IdOxo0GlNgt/+ggkahDeTsVgQbUaLQ3twdEqrAHkN9glJNHd0BGLopKg?=
 =?us-ascii?Q?Kyrz5sS0JdPrPRSuI4TpH905QR4n+Vv5n57fw9ToGsoQoGmhN0ECcbmSntJr?=
 =?us-ascii?Q?f1bLE/3OsSurH4p/pvHVayum1bpEc6Hmx/6vKNi3dfURBmEK/Q6sL0e00MfC?=
 =?us-ascii?Q?aQCFYjKSt4P/fnflpXPOKzDt/RHqjRWYOvPVHj152elqdL7UgWdYNWUy7lAu?=
 =?us-ascii?Q?fW5E9LijIN/WfJAbmpck5mVHddKkRDZu2IlcYhvChEVn4G8cTVaM3HEbOips?=
 =?us-ascii?Q?QeOZYXyNHhgYo+iQj0QUEGsQ+makGuIN5840EDMCD+sw/2Kcu6llv+jYjCcf?=
 =?us-ascii?Q?vecZV2Le0B/1RL4IBTHU4y5EsSjgcb3TWN/Iwl4xPhB5LyeK4nuIYWHCj1CG?=
 =?us-ascii?Q?HDwLJ/7Y5qQMLmsyFlhyQbiGrSBGcdnbGETri2SCKi9kLNpYFTwIpzFUba+3?=
 =?us-ascii?Q?EIdxJW/ZtXWaeKidHws5xzQrQwuDPNUv63bcXJjMqzhKOBYeYcZYCYsqW3v8?=
 =?us-ascii?Q?rmuc79O0mwAaWRzwUH/V3qJJZhTwurpBQBD2AWVMMYB46v8I+hsVMQ35hz/g?=
 =?us-ascii?Q?DM/vrQfYv4c1dbpbgT16y2bNwrC4cdnZICXPtUk6+Gb+OSzv/jCR9FYnViGa?=
 =?us-ascii?Q?0EuXxAI3hOLSI/LS8ONRUJ/zjc2gi+vuUB8qNREqlEOL4RPsOG3efNUhkhBP?=
 =?us-ascii?Q?Ib26H8QwpFO3Lf9jtM/GKze/kfNxO2r94WaWmNej5wyk561sKqjTLzbDpM4B?=
 =?us-ascii?Q?Ai9guF7l2/D5/UorltbyLSOD8umhCJ5eNwya/nNMqj6ohOwBqGZurV7MDxCc?=
 =?us-ascii?Q?jRmCgrtu/QvlLD9VlNDAkoYl6Ej8LDFv5QEQ2CFYJMsSTmtceZVvwVWh8IlC?=
 =?us-ascii?Q?Cmfb1absQaVNp2j2KTMOUVDXkdjYjZTmkX6mPXxjRSjyVnU7Z09kkGZ8CNF/?=
 =?us-ascii?Q?QqJ2gW8aRNWKKDGROU6IsfGLpEbUDF5dVLsECxkDbC4SeCoQJmvjYzXOA160?=
 =?us-ascii?Q?4JyHb1KzogJrR37S0gEvnSZd5s9Wh0HaS4a+avC1zVORydLYUNEzX40tLp/A?=
 =?us-ascii?Q?7+Y8ctrtRcKtvwPRPEABW/DmBgTiy4e8YS+f5btzANUT01vo7cX+hBr8TmIb?=
 =?us-ascii?Q?pJ8f2bryWG5yiAsv3QHKBuJXfpp+iHsDAdzTzHdQx+m0m7FYItw2Lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+DSZYkbAEk+J6FG0Iq04Pm8CmkgLBBvAIg15O4ls62qId2uR3zxnMkdd9GN?=
 =?us-ascii?Q?PfwnYclCteBCdl94H00zQ92z8duSJhPg3EzyyjY2/1b/WOHOJkFbvkaybnXB?=
 =?us-ascii?Q?nWDhw9MY9ARfuKjPF1dG4sYJpKDJFCP4NksF6NPPg5Xzt9vmqTd/RKnJ0K20?=
 =?us-ascii?Q?a75KDMGwnm4kubv7g9tk8/aq1l03/s5d1w6z9RRCleSE8oWpAGRR8YZisonH?=
 =?us-ascii?Q?FfM2U9HR2G99gf8Ou5ZGygd2U7jRORAA+Crrq2XTKG7YLdNBqtw8BKDK/PIt?=
 =?us-ascii?Q?v6HU1J5ilLwKXmpWwDR4s1SWfolVWW04HTPmbXc+nLIG9ru6Jp3BTKLbFAc+?=
 =?us-ascii?Q?RYP3H11xKBcepiKreILxqqNiwiDKrs55DdrzuJN6oSN3ogkALPI7fPJ4mSKD?=
 =?us-ascii?Q?a15hZ9Mc4aYeTP1Y0luB9kwijGoRP6XqSN3lVXCny80ArgJshJwStekhp4Ej?=
 =?us-ascii?Q?ODEuKOZrMHslo6LtEy5sFnTvrPnd1CWYol64Y1PUYeRPeEq/mW+5v8Pl2+5Y?=
 =?us-ascii?Q?8bQxiuNdS7VMxH2AGfjQxXi4Z1+BPblP+t3QdoCMut41ujWoNqhkYxIdvX1P?=
 =?us-ascii?Q?Z9Df+TGk2U7OObpe9sWgOjJ5etL6Jx85MqW12FughDZHpg5Y23FaMfOGzYzz?=
 =?us-ascii?Q?QIihlJz9p45Ak23Mn4+W4S8/t3XFuIURKY6hXgrooYzXvilwbNYvnwgCV5Ut?=
 =?us-ascii?Q?ujXc7LM2+vhp1151GWU69XTWLtWZOsq0/GdKXfG/ol3/Snz2f+7ti6eOPIrh?=
 =?us-ascii?Q?+dqGEb1JggXeX4kIcuwRyzaiCsDGSW35SaqEM3SI5iK3rTUBDKJXXBae3MmO?=
 =?us-ascii?Q?eWCvdhuOAytniu1RQc/45FzLH/pkG4iOiTBZQmR1IWEf5NHikHirimBjFhJH?=
 =?us-ascii?Q?Xs+nMT2JycGLVWEBIEfkX6pOGGXfV51Q0KBd5xLTeowCl2TLu3GUy6akgp/8?=
 =?us-ascii?Q?aEG6qMA9gS4KwF4GeY58Bx9/TQYDGV8MAeV+C7Y1jNFgbL523uWO+FPFRur6?=
 =?us-ascii?Q?HHpaNx0qV3SfU2dThaqFI/SGk/dq9pnx0LkWVF/mv3OfcJClN4Z2H28FuwIt?=
 =?us-ascii?Q?olBe8b7tB+LVNq8s/LArTMdPXZb9toa4U7BBHjrFMY8a0UjAAu4llzuXBI1V?=
 =?us-ascii?Q?m3TP8EOkCCWloxLva9Z5+VZSXlJVPsME3+8xw1FeAyrhS15T5IIWzIil0CKu?=
 =?us-ascii?Q?1uxgf18yVOLWiGXrTuPYX4DOwlIl2WDcWOcgZa2N4ajPUQXORr1E0exRmL5O?=
 =?us-ascii?Q?1LJEk/yCHzl+uuo2eLvgE/Wv9/YIRIKPoJW23FGewiJZ0/9cgYfT8y4Y7coE?=
 =?us-ascii?Q?ExVd1/+50wiFOSTSLOirnN+WpJMtAp1wO4IxNMokTNXL+83hYg9pqlRQe+EB?=
 =?us-ascii?Q?pgLj8gK9Uag4jq7a40gjb7+GJOOaFoT56WRYSuXKzjlCCk7tRUlsVj7sQiff?=
 =?us-ascii?Q?mT5fUX1qAHU3PNRqdaus9MWbXniTDk3Pau2CqypeNDqFAgsn6rFXBxzQp/5/?=
 =?us-ascii?Q?fkutCi1ydwALwr5tLily4tqt5hS5bnAzJY9804BZkYzD1MWktGIU9t+QVm4G?=
 =?us-ascii?Q?U3vstfTaY3dUaB9GRstGydJxmv9AQuEsp1aNOWHQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605da61-10cf-4fbc-2ba0-08dd7b507996
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:32:52.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kcEfAl6LcSlPHGmhQ+riWdkOcfVpGNJLgvnsa06uQYkrRSPyc2943luo2mfSDVjnnKs44XisM2dz5MBtHPDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6759

Make this simpler by returning directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 98c5b61dabe8..fbb5239ab9da 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1339,7 +1339,7 @@ int __init btrfs_delayed_ref_init(void)
 {
 	btrfs_delayed_ref_head_cachep = KMEM_CACHE(btrfs_delayed_ref_head, 0);
 	if (!btrfs_delayed_ref_head_cachep)
-		goto fail;
+		return -ENOMEM;
 
 	btrfs_delayed_ref_node_cachep = KMEM_CACHE(btrfs_delayed_ref_node, 0);
 	if (!btrfs_delayed_ref_node_cachep)
-- 
2.39.0


