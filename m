Return-Path: <linux-btrfs+bounces-13207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40094A96023
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BA1188F9B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DB825291D;
	Tue, 22 Apr 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IdMWK3L/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231312459CB;
	Tue, 22 Apr 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308535; cv=fail; b=hGMmOkjyHCtBnlDm3L+n9Gg2th3/5fXvElJ/5D0pTGmyq1zESpOkPeZy0CI1pnKssUaLQEiKMaRffALBOfRFmzQFp/CwJWcM7WStcFruJmxn6M2ssG0Mhk/zQt96VGMiIh+3kDDXlclIBSBDouhoF7LtA2cuALAyahwI8XHOdDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308535; c=relaxed/simple;
	bh=uolVhQnJa7LmZ0OrMC9EwXuXQ9FwDkLykYila4TrBUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rU/ePCnxvaMO/bD3SCHUS7GuklsPGCiuaiE59nkQvTcn81IM+Wot5RGJptXsJHbnXqzO/RbVyMLTVzGAprOIwVHrco8QrjbrFdhcCiZ1Uu3RGg5JmYPHjHWZ1JmQ3kDL9OHjCajqXDyBAh+9WFMmEWfGzGenODOL/D0ZI8yn+SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IdMWK3L/; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1/3h3POZNkAjml+qeOg7THn/s2LYSt78adOUjbsT59dC4+0C9BUlf5gxVoTpX91FbRugiOfCOwSZv1llyWnxN/Gl6+oPlcItfXQ/tL+2OeoNSks3wD/3dGZk585fKCf0wK32c7UI7Tkgzma0mIrWJ332ISrMGfjgvHXtZ0tsv2gjSR1Cx8w0VTD10fn2j1T+iUsockuYJjpFkpJElZ20+Mixa1Pd9QZLZhFPw/7Y7y1KnUhuX2d8LWVFyTqerVYvwS52je1FAkkOAT/fDjcTItXVmocLdKjQrYTxGe5gf1ILviflpDdxMRFDIa/ZxTTkx8/2ywTlukmt0fsG/KpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcPj93EZh0vq58zARu3xwU9T5J2+XB4lbdO8waoIbO0=;
 b=QSqGFgPMegwJItH29t6VYcErBNS8L/AuYc+oaIb1ZWS4V+ukDBB5tQ3QRSt8pAAEx7CpZN96oX/uEo8ce7/EPy3gMsPmCrBcAsgZBIqkL/GX1UrHaMCWTnDB+SNY1T+noV8DSujSmnXKveTn3l26PQIXrfMUPpoxLiJOfC1fIqSFPz8sVcwGpzIlvX/GOuAc37woBMOe/f5LQVMTI8Hk269SuqWdTRFXTkCBGUBQRlJz1/ItQyECctPHsUdk/2nuj8KbJv0h4U1g3B75NlZ6USrQQGojPn23eclBq1QHvK8cOwqh5GvpjpLrK3gfvlrRVG7h703PSAw7Ev05Q6hzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcPj93EZh0vq58zARu3xwU9T5J2+XB4lbdO8waoIbO0=;
 b=IdMWK3L/PxaH/xbDiuZYifRySM+Z+TdMLmuXOWqq/ojVx+cLLoTb01yg/DD8vXhWSxglXSOS9ak4NwfXLKOPfNaMY36aUlCIE+D2wMG5RW9Eg7YXnOGQ9x3VHLeFJjnPBOcUokzVMtkP9DuOAEI28Mp8AzI95jCzmCjqTbLiwNA/VMNPiL2o4bIhS4PpuPZxV8WIUNxqcSLi6Dnx/qRS4dTeMvHvSts8LFjTbnyx8aoAEi6hX+hMYmRWAFxjifZMJs+Ffws6kNS0r6oYqpl69oodpQUcll9R17g4CTdZEjTYsd63BDo/iKcI6gr720kAvG0+/v84xlf86Vvld9o9Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:26 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 05/13] btrfs: update lookup_block_entry to to use rb helper
Date: Tue, 22 Apr 2025 02:14:56 -0600
Message-Id: <20250422081504.1998809-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422081504.1998809-1-frank.li@vivo.com>
References: <20250422081504.1998809-1-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6fc0749-49e2-4510-4d59-08dd81730aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wYQF3Bpl658bUkQc/HqDV/btM6EOsov4eixeROCz1cX0ILsqY2kiZyZKsFiZ?=
 =?us-ascii?Q?fW1x1d7MABkHnffm9mOb2LTixcQKkbxDxyEo59L7e4gpeqf2ZHN8HXLZzyen?=
 =?us-ascii?Q?W4JJ79/dgVpp54nqTCi21n+LTOVKtv/hHe0MoRmrctj981MZTCLz2ACCk3qc?=
 =?us-ascii?Q?nUnHJl4PwE4sh4n3lKCvDGtKHZfPG4l8TLIrACav202D7/4KezLIRIgDf+WY?=
 =?us-ascii?Q?sld7SBxBjH+iZL1OjUic5b/lIWxwd2o9oRI1aMWdKB+PAPT/HkFzUfobFdba?=
 =?us-ascii?Q?0y5pJTZtSveMmh2DZF8I+Ol67Sddrmf2rHnSh1W33X/AUgKkcXRi3sZ/27Zg?=
 =?us-ascii?Q?A6ULhKAaSkhyUPkw8pe+0/pyQ/TxuHeQ9tV8NfDyG4rU0krr2BQwCrn8pDwy?=
 =?us-ascii?Q?WVQeRZQvrekds+ae6OhgRxYOfTsqS1fNXSgw3YJgh6U6KEHEhxgontFCqqSZ?=
 =?us-ascii?Q?jar2yPmBuKnqOIVbW1GTxepnJBUuDP7U13FeAcaoqI178pY24qIi3OPPUNlg?=
 =?us-ascii?Q?6WJdN1nrh36Ih/ID8uvijjl/O2hHbRRxOXXAzIfPZtKwXw8UTodThAg9DN7S?=
 =?us-ascii?Q?Y12NxI6zcMf4XC1GHAirgDM2GHlirK+edeKnQYIJmKf3U8zhafARnRIzd6BQ?=
 =?us-ascii?Q?iSmiUWG7iZY+w7fHkzYKtFKNHNZQLFUf740lkIAsKtZeWy+6b1YIuQy8sEKc?=
 =?us-ascii?Q?yK/UzDbHRLjYEsOiWYJkgpP7YR/wSa/GggK0DsVp2jPKB6PK+3bD6o65O2mh?=
 =?us-ascii?Q?VJ6BRmuGzM8jhOeAxueJLRjNbsm4LeXLWT0GL6vy4/pD0UWf6SlAfj0aZMrP?=
 =?us-ascii?Q?DfnLgSMyAagt9Vi0cGsu+KdGra1sU8dVjB6OrTZKsuXesEwtaIP4S8qfMA1n?=
 =?us-ascii?Q?9Be/yge/23CAJ+QHLq4owyOTyyJu2a9234B8kSVa5Cw5AOqQP0KHKvvr1O5y?=
 =?us-ascii?Q?pLO2W4bA6ckktupxZAJX/W2d9WJfLTaBCasricpqNvswlqD5KlOIHzhnSg5Q?=
 =?us-ascii?Q?StnZuadDp21Ry5BCS1uS0iuz/HzD4T9P2+2+FV7bIJKcF8YwhigwBbqPNfiS?=
 =?us-ascii?Q?XMkHZPsO8Bcc5tqSSERloOQUycGnsOXSxBhxJcIh1vsr9Rf50BcQOMLpwHct?=
 =?us-ascii?Q?hCxEtkFThSdx5rSWt9wKV+GaS2WIQNAYu+eDaVo/WyXzA8HhkHdftxHHg/wm?=
 =?us-ascii?Q?yKgRKu33VkjnQFJZoqBIxuHFBGo/mrza2H1/Sux060t4laPolDV3A6nPtg1n?=
 =?us-ascii?Q?TVbdDp+yC8hQdfZXuCh0+cFDNvIrjT6LmxXvhXufvO14IZ6LBTje6ZWYn7lL?=
 =?us-ascii?Q?N58yM2oodDb9YPLYgUr1uQ9qAeZ/c6XEq0vYwbgbjdIqU9SCuuKjAU6477R2?=
 =?us-ascii?Q?KlMtHu62f1pyrUVcoYDa9pHvjDgPGisS9gdmn0LYnXaHjd/luPriaZ1lT5WC?=
 =?us-ascii?Q?TC75STMWUZnlsiwuNcvNivOCWgoR3yjCk/Qi/yBdi4lpxkYxLlUsLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nj1oYsigoVQeeNkzukKBUA3OR1kRev0+FVe5HSMlRHzfppe+5GHciAgL1qde?=
 =?us-ascii?Q?DImd5tKLxOIlCPUntghqlClQCzmnXpBEbIS+hrqWx/EgsB6D73mEQ2SfE5RV?=
 =?us-ascii?Q?aOWNpeQmiFHoHLIJ01I95p5EsTIsskUoso47MbIhyr/WPMa6EVYq6P3lw9f7?=
 =?us-ascii?Q?J2sfJLOWpcYGeYK1D/f1G45LJcBIfJ+QXkN4YfTF7g+5qFAOk6VFoRFfeSKW?=
 =?us-ascii?Q?byI73Aum8ISEt11GY5PZStVl3YjIW7gcQo09B/VU6My+tnqn56/3P6CngvPi?=
 =?us-ascii?Q?t4XcSZZ56Qhu8FmsOnOSIa7aOaVT8V/BnyDZ9wWxyj+gZjPbBW2toL4DExOs?=
 =?us-ascii?Q?OdHJigjtU656ToseF/vDFcL4PyxR/aethO44CxpZ0RpZDjL7LoeRWX4zUW4K?=
 =?us-ascii?Q?GEyvreqkQTUiteINV+ME6Vl47rjiBP0PhDGUUgHjzFFy+wLxiXW1M44ewhqy?=
 =?us-ascii?Q?vFPvyFwCfH9oTIedQx7K+eZdJO7DktzY/gpu5OTjdc++O7rkkhOFnFQr4MrN?=
 =?us-ascii?Q?eztsk8G4nNTQVE54f3HgxF/AtDWEBUAWLVd3Pb7i0ka8o40RvZUwc99q8+qW?=
 =?us-ascii?Q?EttD+HSVn9LB3/6qRjPBSvYW2FXfmbs1nFOeHnUQMNs8Pu8FKAUwIVfLzb5i?=
 =?us-ascii?Q?UDfOxDoYzTxCMUPCa837+YJcQ2pyFIJ5J34ZWR1F4xNkQlZx0/BpRz/nq5G8?=
 =?us-ascii?Q?hZyzH/4s8arYVZXs+UtX1/FLBX+3WmWWF6GSiWw0oirIo/N0F56hgU7K66os?=
 =?us-ascii?Q?aqAXwyztskSUr4egsVXhCuAEw98ikemslKaCyLiXyQq4Kit+HtO/RZ+kzOAO?=
 =?us-ascii?Q?vOXL/Ffk8jwplaHyso4KPYP40U3cMGf+xMd13y2c9BW8VKAkmKglheDHNES7?=
 =?us-ascii?Q?oafFZnJlfB2MbaZq3HVifz9MGUuZ8jcImn43UtKjqqOghvI/YIQCj2fIXLmS?=
 =?us-ascii?Q?lgwghgxEoRPp/f8FBPAr5JwD3CE4c+JZWnY3Ag9UAy0LxDGq9+3SwQ7qz+AM?=
 =?us-ascii?Q?Tkf1hZvy8UTWfQtfpTq+yTFGW7u9rXPOr7YgsgWsjV28kKKd+37iK9w1a6vO?=
 =?us-ascii?Q?e6lbQMYkjdHC4iyY08HZ72LhWI6USBshMAkNrGwVZgShEYHRE9MTjBf4QpVU?=
 =?us-ascii?Q?AHEUkcqFVwqRU2VM7opC8t+Qnora+9NlxR5ot40zQ3OUIUXLRf0sh/EXH9JE?=
 =?us-ascii?Q?RlOPPP5wlUzouErmXgHtOpgbeFC4V+26hkbz/1GcgbtMHFfVx3JDEExzun1R?=
 =?us-ascii?Q?c6xQMdk4lJNcDLdsDn8a9mOvxHtMNIyh1jUApqhUnCkOBz9enWGhDRMUVOcl?=
 =?us-ascii?Q?tFpXJIcwNr7a5nMwtxhrMh9k1k8rVGFJmu7cqQ1ZITOc7cpUN/ppijHktQ3w?=
 =?us-ascii?Q?vF0RRyAsjAzSPuH2JH/0r8/fCa6WICColZL5uJq3wVi/WZASSleaYt+/JvH2?=
 =?us-ascii?Q?m2B2V9vnZ3jNI0J0xNmXOmA+OuSXBLDwkm+S4zdztJ8R4rb7p4U25GMVFn5S?=
 =?us-ascii?Q?8t66qt1LFQyMbzJCzTdlmPNSpYe+Q4Z7yij+3DSwjPZNF8Yufxftn7kfs2qY?=
 =?us-ascii?Q?jUTaC9ajaH14CNP1xEhs3BVWtnskTRtlmLIDtp80?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fc0749-49e2-4510-4d59-08dd81730aec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:26.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqCrYf+LKvd3wXfsrZYzo6nh/+PwDBzTuq5X8VKbMwIE4zBuoCm1Mb6ICgAszX7rW9glAuYc5NsYVE52Q895+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update lookup_block_entry() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/ref-verify.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 2928abf7eb82..6445c7d9a7b1 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -75,6 +75,20 @@ struct block_entry {
 	struct list_head actions;
 };
 
+static int block_entry_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *bytenr = k;
+	const struct block_entry *entry =
+		rb_entry(node, struct block_entry, node);
+
+	if (entry->bytenr < *bytenr)
+		return 1;
+	else if (entry->bytenr > *bytenr)
+		return -1;
+
+	return 0;
+}
+
 static struct block_entry *insert_block_entry(struct rb_root *root,
 					      struct block_entry *be)
 {
@@ -100,20 +114,10 @@ static struct block_entry *insert_block_entry(struct rb_root *root,
 
 static struct block_entry *lookup_block_entry(struct rb_root *root, u64 bytenr)
 {
-	struct rb_node *n;
-	struct block_entry *entry = NULL;
+	struct rb_node *node;
 
-	n = root->rb_node;
-	while (n) {
-		entry = rb_entry(n, struct block_entry, node);
-		if (entry->bytenr < bytenr)
-			n = n->rb_right;
-		else if (entry->bytenr > bytenr)
-			n = n->rb_left;
-		else
-			return entry;
-	}
-	return NULL;
+	node = rb_find(&bytenr, root, block_entry_key_cmp);
+	return rb_entry_safe(node, struct block_entry, node);
 }
 
 static struct root_entry *insert_root_entry(struct rb_root *root,
-- 
2.39.0


