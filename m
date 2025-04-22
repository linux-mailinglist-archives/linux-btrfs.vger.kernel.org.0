Return-Path: <linux-btrfs+bounces-13204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F69A9601C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B737A244B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D023314A;
	Tue, 22 Apr 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MKP7rnP9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3391EF094;
	Tue, 22 Apr 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308529; cv=fail; b=EHdZDpn9QhURupNZ9K6iMqkJsHgQBjLXVMKrnOoFwP3o2/sWwpf3grFZiG5xw+cA20lbM1tRucTmoAvYjpWepblByTbX9Ab6XHVNRNy8FLz7A3AF00Qv6aA//i4iQ7FJOWWAHERy2ecoJ9fzyUq1g8aXEtpI+uf0U1TgUcKwYMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308529; c=relaxed/simple;
	bh=w4kaNL/HJIZoPTNgAkr9ps/QhMr90WZpBwr8a0sRplk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YZHpiCfcwxdIbp4bNqX4dm3MH5QajH90Wsq7zmSxTwi3FTOLf00qxSzrEYKR1dMmPkMIPEMIK/qGjlTr5tAwpM37Wi2M6lXdz1yluwEx0ndl13KGuc801Nb/f8w/V8eZ/28bAD81HlgzDmlSNfOHIaDde1T13oTj90GREcG4Z9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MKP7rnP9; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF8+HM4oY5t8WRitH7egaURMSECFabxzkllsgE9w5VuOgnGLXiFRIMKc2ZJUM9LL783I6vCsvlXuY4j2LIs6pz0Ss9oMc8z0Ak4Scl8uu05iF//Lvq7nQs2ss6OfGA0PHyeWmOI0FgpQKfpX1bN0UiEQ53kZShkEDRg1URKGk6IG98oXzfjewiZsjik9yHKfM1U3+Mw3N67x68+4wjdS1NqO544qiGNDhadS8nrKx61tDWY63q9IiHGRHvyQ6+0+MJ/kt+Wib7G6KOgKwi0gKEea5uwLTyf4D1TkIvga32gZOZrmhBYXrXifGl3XNLzuWOgX2y9Iiw9CZ6FblGwHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJdvy2dDC4oFyCSPnpMqHmUXiBOsyEsE/Lc5Su1R34w=;
 b=YpSPDWsG14UAYps/x+jyM/l76jQo9/Uyj70i0sklPgH1nDEI4xhU3s4Ur22uNKokgcn4RwEx/dPd5fFYtanIAQr5yUm3nWbCqiJLcnJy8+KtmCGPs5Asox8URVG8Cf/cNz+2MIqT59YBtwatdtdeOdammEFYxtJsGLeo9jlmpmsaYBUDyYjuDX7FpYY60mjel6ldBVu+NiVCqRUA1t9DejDFXw84L8mO0WXConiMiVZLISI8Sk4FJeVDOXDQTKD2w9Qx/0FtlGjeZK9IoAjTYoHqat7KukN5JFmF8kTkpWYQbqI2hpT/2CSExip3XGYJwl9biOVRyRXGfCFYJNfDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJdvy2dDC4oFyCSPnpMqHmUXiBOsyEsE/Lc5Su1R34w=;
 b=MKP7rnP9k1IcNdKdS24c+gwa9Wv2HcaMVOgqduMIrnchFO0YAbb0zDUQvNGvjXr6mM0w3O815/DUUBuGQzl3iEP2NMEvY71ALkwMzUYf1FEf2bGEphPsk8Wh8HEYzIuhUoWTRURQxb6p93lMH8BMjM0/koQ2q5yocTrSRL1/TBmkuIzDaAv/qDflT6hRbdcmezfkAefH3tDuEwIVITWbkEGrNZOcSMLu1IpJsuu52m0Eqb/GETtjhQxg4jtf9yHe/C6AargU98WrtXHxqbE1N9ehuYk+Q+sq8pCkQBJWs35s+OYGQOeA1IqBPrsP27WdVSkEotA3AnuIPYkw5law1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:18 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 01/13] btrfs: update btrfs_insert_inode_defrag to to use rb helper
Date: Tue, 22 Apr 2025 02:14:52 -0600
Message-Id: <20250422081504.1998809-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e77c56-6c68-428a-1801-08dd817305e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+6iYY29WxWx1CcpGdSezCRQH/mqELmRLlfsqz5vFPlTuYcfdoy6R7YlmMjy7?=
 =?us-ascii?Q?AP4HTFuvVE1SByEOWriYWsb06dICSiG3BK5KV1k1gyL045ohOdJw9oTQhl6Q?=
 =?us-ascii?Q?1Z//2e8nO4hGI/oPbDM981ySofNheFiwv1kNQz/g5+UOwIJsx8rbXj6AvRmu?=
 =?us-ascii?Q?oCaVm5hVey18y8ggxB8QBurfxyutW3rAEnc2qQEgLqgrHDg2z6MvF5e7AxtG?=
 =?us-ascii?Q?9VaZGn8SfPZP7h/F1lNoZxKJVJPrsNPWxYKNIE9dh/Q/DASMgqRAeAtN/lGt?=
 =?us-ascii?Q?sbSoasrI0cfySIRiCFg2rODOf4Mpy6Kb7tUcml5MJ1EcQDohMzmecUDV+3dy?=
 =?us-ascii?Q?555Eu3jW5qxJlfb9Tm0gPFPLcBCVBzYPUbkZZZEY0H2mxU453Qt0V0Lwv7iQ?=
 =?us-ascii?Q?L3e7spjlh8Z7DYHMlGTYe9j7twnOoy+9mNJtXF4kqjI5FWnwdnwcZFLrY+LX?=
 =?us-ascii?Q?PbBp+quq1H4UNgi27ueTpFDe5Tq/iEiKY5oSgW4Oy13WWUjTYyyoPktSxV75?=
 =?us-ascii?Q?yrKMUpTWZcQUsa7GnsUvEc/GIDy/9ywWobVeSNV9eSb+98J5bZcdgqWy9b+l?=
 =?us-ascii?Q?Ns0k6DHBQjuBdeWxU+LdRrkQ0VdgYIyDmY9qhVKrR9DAOYYnYDXHtx5vj5mA?=
 =?us-ascii?Q?5wCOvwDYVdXVKM6ITGB5uCcDnaFVPuOJ/ZDoUN9evKiafQQcHnSdTzrkA13/?=
 =?us-ascii?Q?8REqd8SiD6dvl+coL1JL0/caVi4ARvOtdXnOak3BPb9kAgzf6eVgTgmgEYX/?=
 =?us-ascii?Q?hAAhaqniYn/V+Vv/iYSnj8k/IFlTP5go3/r+1m2oi3MAYZZo+Y8/bVctm5Eh?=
 =?us-ascii?Q?SjDr726MaBOo0aaMdtbD9Vs7YAiYRDWiLuGGzMGlmoI0+/bS5vLLRK+paUCL?=
 =?us-ascii?Q?wRZ6mhUKm3ZGLQS9o5OcOGCDfhRc5YXU/OMnAXDOLMEBAd5cu4BdLMJ1x9B8?=
 =?us-ascii?Q?fIRd+R0zLS0bsl3/CNubF6oZlheyBHtIbtKuaf3YG6IolxrGytTC6SZR0zPU?=
 =?us-ascii?Q?X5fTo52W4zqskWTT9tVBd5rUKiZv6XZFa76HF9nIqCN114sDN5goSAYKnuEG?=
 =?us-ascii?Q?/9knfIWA2DvzbgdFAMR3pVMVuISQW9mx6lBmqJ+4tTiYII8/L8SbuSpc0bwW?=
 =?us-ascii?Q?/Ca42nRm7A3L97VyZ2HYIFAtcPoPhiopvy81Uu79LEQ3phqtx+WH0NqmTUnL?=
 =?us-ascii?Q?OyHggaz4+Rkor/6XJuZNLS+dAbh2TqI5rNvwR9MHaCfns5Bdut/FhUMIaA96?=
 =?us-ascii?Q?3pbQgGL4gJaCAoBiJcJ72Klsnxx9xFfLn8ntcAswWQ5U0eQGEP+66Luh1gWN?=
 =?us-ascii?Q?f6pqVMd/Ml+6cyvSMeyT+As5e8xwmXC8VRekxncJB2vBL6H5nzX2YegpEGTB?=
 =?us-ascii?Q?XEr+BF9GY+ofzt3xD35+p492Sa6r0M4IJ1zj2Jtajm9DEbzgd6BlO0UF+Nzn?=
 =?us-ascii?Q?LhsWKCPzgsiktjNsBjR1FntJzfUUoyV6qwEvCut1H+X89hpxc2APoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8d1eqIIW7BBSZLXJ/CcQJDbAFgi+jO0D2rsBISvSrF+bQvISrYhyMWNJjx43?=
 =?us-ascii?Q?XnHxs3EaPPqo6fynTYp7eEX4Y0E3yoCGEow0pBuHmI+NjahJuOvJWAyZ4h/S?=
 =?us-ascii?Q?atLFapGPhQ+YCPCDapAbVqctaTkVQhqpy/ycguDMepTo9HZwWut1xyZfEElN?=
 =?us-ascii?Q?iOY4PJ+D6N3dfx19Acw16kctooEgU/MBGNgyzYj4AX7vC02FKOVuGY2K3rar?=
 =?us-ascii?Q?ArUzgFOjuZBokvOtzzEOCrVq7KTiHqhQLyR++losjGi25srfQtUcWzfeqPd6?=
 =?us-ascii?Q?qM7VJtJuWz/ZYrqaOtg62SrTbk6YrB19HbkiEy9jTPY751T4maQp1mcamE1f?=
 =?us-ascii?Q?xeVgz0zHWPyILl+3Eu+wim7MqcON71KBpWB6u2+ESn/i+XCOwHa317yXTtau?=
 =?us-ascii?Q?nSP5yhxLqDO1Y55XfDryMDSF7NeAScYuQVOc17LEC5nrm8rQMcZ9c9yG6YTQ?=
 =?us-ascii?Q?HeFpoLAdDJa2bseXL/4IYLAokQi9vA6YApN9C96PdBZddqH3vNsOhw+1ziel?=
 =?us-ascii?Q?1EIKim5MqMmCNoxY2a6J2VKRRJVTOr9ZUQzpQtpu8Brp0f2UkmCX01Tl+Ap0?=
 =?us-ascii?Q?8C/5+AN+eFwntf8x8KHt3wipSMSgJx81vI3wKt6r84NdL8Qo9vbk5Re6bfd/?=
 =?us-ascii?Q?yo1x3UyiqollSh3K3jtUFCvwISc2qOMceDoqQuYE+49TsWKf+Ic4/74DIJqw?=
 =?us-ascii?Q?VaS5WgVv+9kmu+QfMRwf0R3uj+RYoSEMIVyvTsX5jm4tMbD1ubaeGuNL6QB6?=
 =?us-ascii?Q?AbpbBjrpngG/axEN42uPW4o1gxxBKpYI6l+kk969huO3RZytWSjNJb3BvDcz?=
 =?us-ascii?Q?PQfKDKFI4hG9vpKM+Tut9zboXi+twT84h5AWeAiTFi2SkcvIbSHua+NcIxQA?=
 =?us-ascii?Q?qOFxGK9h6RBFEOF08rIJ+ZuuMsRxtNwAXQHLiWtqIceptCDSqUtoYV9m1pyZ?=
 =?us-ascii?Q?27aY7AoEsQT3SSiMLwWGflLw+i2qwEpHk2TCykZY9GK4XmFnmDuBNMl5kugU?=
 =?us-ascii?Q?bIHg4ZiXzZhsY9Gpt5hd6WcGB3alIciFxyTgHtBmXcnu873CT7cHmtD3JAMU?=
 =?us-ascii?Q?LyAZVtUrvE9GKvhxbkBmxjIgW2HhcJSg4bJZy+NJFz4rUmqeozbi16Xa2Vtd?=
 =?us-ascii?Q?4JC5g3BNxOvkVdyuJ3C50oGLswAhpSf6IGTv1weE8wloS47DdNLB18KdYNjI?=
 =?us-ascii?Q?p90bRP7/E6eM+gtqPh6pyIfFV+K4JA5sJaMDgnUbkahrdSnHqRFH0PrQOV6h?=
 =?us-ascii?Q?JoVRNPjkLhY9+CD6af5t/WW7w5LXobLxCNJsIUA/Pa279Ea2ZHRgwOpWImPz?=
 =?us-ascii?Q?Z4KvQKELJu/hmJvFbCU7djY0le1D2tVaitM0buVKzMbcSsLfOHo9ZllOmKOE?=
 =?us-ascii?Q?pP3FikoEcPCaimO5wvxKQ2EhPtiPoWOqysijECAn+TZE32teaStPT2Uc1G7Q?=
 =?us-ascii?Q?4ZfGEulcEsqoAHTz2Lkmvjl9GTPtP6byuYFs+GxTHgWe3rIInyYZ3w+rWLja?=
 =?us-ascii?Q?wXmP7idLZw9l7vRIzDIqaILwC4NI/6E+IhSnABCvk+YFJFDMcH46oE5+OHWl?=
 =?us-ascii?Q?I/zvWpdX9AKVm/WR4blpLuHo7n8IQU3ZatpWDOF0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e77c56-6c68-428a-1801-08dd817305e3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:18.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkU0c+uaRm+uQvvFSbfaRlAYVbdCCJZv0ah2OvkS3K5FCZ/y2H5T0aIESmXd3KFvl457tyxeFgJGE0/IvHUZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update btrfs_insert_inode_defrag() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/defrag.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index d4310d93f532..d908bce0b8a1 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -60,6 +60,16 @@ static int compare_inode_defrag(const struct inode_defrag *defrag1,
 		return 0;
 }
 
+static int inode_defrag_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct inode_defrag *new_defrag =
+		rb_entry(new, struct inode_defrag, rb_node);
+	const struct inode_defrag *exist_defrag =
+		rb_entry(exist, struct inode_defrag, rb_node);
+
+	return compare_inode_defrag(new_defrag, exist_defrag);
+}
+
 /*
  * Insert a record for an inode into the defrag tree.  The lock must be held
  * already.
@@ -71,37 +81,25 @@ static int btrfs_insert_inode_defrag(struct btrfs_inode *inode,
 				     struct inode_defrag *defrag)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct inode_defrag *entry;
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	int ret;
+	struct rb_node *exist;
 
-	p = &fs_info->defrag_inodes.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct inode_defrag, rb_node);
+	exist = rb_find_add(&defrag->rb_node, &fs_info->defrag_inodes, inode_defrag_cmp);
+	if (exist) {
+		struct inode_defrag *entry;
 
-		ret = compare_inode_defrag(defrag, entry);
-		if (ret < 0)
-			p = &parent->rb_left;
-		else if (ret > 0)
-			p = &parent->rb_right;
-		else {
-			/*
-			 * If we're reinserting an entry for an old defrag run,
-			 * make sure to lower the transid of our existing
-			 * record.
-			 */
-			if (defrag->transid < entry->transid)
-				entry->transid = defrag->transid;
-			entry->extent_thresh = min(defrag->extent_thresh,
-						   entry->extent_thresh);
-			return -EEXIST;
-		}
+		entry = rb_entry(exist, struct inode_defrag, rb_node);
+		/*
+		 * If we're reinserting an entry for an old defrag run,
+		 * make sure to lower the transid of our existing
+		 * record.
+		 */
+		if (defrag->transid < entry->transid)
+			entry->transid = defrag->transid;
+		entry->extent_thresh = min(defrag->extent_thresh,
+					   entry->extent_thresh);
+		return -EEXIST;
 	}
 	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
-	rb_link_node(&defrag->rb_node, parent, p);
-	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
 	return 0;
 }
 
-- 
2.39.0


