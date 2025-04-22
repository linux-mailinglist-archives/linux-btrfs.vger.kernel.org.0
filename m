Return-Path: <linux-btrfs+bounces-13213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF7A96031
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81F1189A9C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8C257453;
	Tue, 22 Apr 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="faJxvr0J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363C2356DD;
	Tue, 22 Apr 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308547; cv=fail; b=dSb/9be8lmifQ94kcO8mK9Gc5OfX7TLH/dcb2UKGrof9uUHxNfRuQZ9RzFo1aenDQpHaWDnZHc85amv05DmvKrfU6LH4+VBVgV1itFT9VcfbntQPMmxV04jiDqSIu7PMf/bS9iDA27BYU3ndySIEVf/cCeFO97gfBQYUxBE8ggE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308547; c=relaxed/simple;
	bh=tWoRg3BRmOtMZJHq4YInPuTSkCnp51ufYlkSKE6ckEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPvh73zgqnQ6GucAgn6OPtBHydHeYa8VadB7Tmirde12NmIgF8ZTHA1yH+z+dJQHG1AwDg6UE82bKV22T+TKBNzESyUzQJBdRKJH/4v4XCAK4QzEDeThfrkYXcfpYWCPaqnNkXQwuQDKZtW4MV0oHVm8/V9KabF4faBzVpm8k0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=faJxvr0J; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxY2LM4BMjo1Cr6gng0jEiREY9Rd5PN+jjftmSqbVfdEvUHzwjsYtybi2AsOcqRRataISPJmoln1dC5OUw4D5MIT4vmF07k8OylvzjD9PtH2nTJUc8h6Z/A6h5oxcqGW9GuCTmPU8LcUcFbeCAPkjF+njU++ClvguZI1sWmmY+fxQSgLfN+VluJeH1bd4gpCjsTqsFiV+uzBFDe/JIsnXcHPSSX8elvwVE3Ftkd710s45ggyaRJL+mPOvRJFIrf5gFLKNkUbWrDXNw5SMwvDrzFLUUd6bfmZnQ8zySXzi1zyHM+77nDFEdvyBZS6rhS3Nq0IlR6VT/jYmrXG8OirtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9uNrrQkZeLtTB+W40TLxrHYhDhKqdCzUqsb68nKRNA=;
 b=HlrNEdkfuhAh/zHSH9CLotsEnKgTG6LVqlp2RQT7FBSrUJgrABmaVOyyN3rEMD0OhlzhNKpWw7ssE1UweWgIn7EAx+sfCNJAS57ZZufjslNoBYoN8ApNwkYU8FdULRKat/xV4x/QnpngNRikyadZxzf+KV3ijKTGRLcrSIAt7fzmMrTJE+TtSAqVOLA9Xs5lG+kAVX7+ZMwWIuSLRpY3GppKkqJcmdeXfUWm1vFJ+AlQEs7ndMndkwtcfs1s8hQlpJDV6/EG6AP4HRJbWSODBJ8aT5+vuX4wkjcwgCVqabAjr6wazSjC2bxku1nPy7vjPnAuZUfuyhsRUStTdJq4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9uNrrQkZeLtTB+W40TLxrHYhDhKqdCzUqsb68nKRNA=;
 b=faJxvr0JXcjWpKsK2Qz7VKw7lGQ0dAxV67e8jYkIPgiy779ZMuOu2WSvcioUKYyibH2Q1ZStO/vY0m/9WXVl/vs0KXy5Ylnp8HAo4aj27TKI1WciWHK4yH9wY/2s1g31WjGlFbx/2erslJKi71Gc7YfcJu/hVIweCdSjnpXiTGywE/cJjonPXDZZ0JFomRctaFKTHaW9Xy/RYK7jsL0EYX5Mu9CgekDmDYU7WWwTss54U3BpPzQBxO+VKVKbFy7/voSbqPLF/7ffAGIX7JG+PR84mKW1OVuBMEj1mFcSS8nmyGJ4d0Ck4ZxsIzopVlTKFttOhyyC8MKiZEtK5b6Ifg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:37 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 11/13] btrfs: update add_qgroup_rb to to use rb helper
Date: Tue, 22 Apr 2025 02:15:02 -0600
Message-Id: <20250422081504.1998809-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8235fa9-e660-49b9-12bb-08dd817311d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOcYU6keddYn+YhdCTXpxqnz6f4X8qydqwnSbFVnw1bf9TUU2q/pnUgBHfrE?=
 =?us-ascii?Q?lHRvexYpgcyP3UT+evlZN+RfIDsCJ0/+gpDwQeD5Ql1uje8lDqUKe38cZ0qk?=
 =?us-ascii?Q?V6VTj5LhXrf9NZOdeG5KCN8/Uu0DmefsZghbU4CYxdsBGIwso1XDraAmErkO?=
 =?us-ascii?Q?tCAVu1xlOTVRqAAMJPoD8eGYGyYnL+Jo/ACzs11qXMOfQ0O+9/n5L2e1gtzQ?=
 =?us-ascii?Q?wNFnUZKWX8JhFSWZGuivnCRK+V6opQsebxo624A8V86YQa2O0PQ/QmbENJ6w?=
 =?us-ascii?Q?vJ/iFOz9oisxPL/a0c3Y9dznoAzsBJk32MEObezdi+ATysFHk5QafEYUQQen?=
 =?us-ascii?Q?uGL3UV0eubUKgmp0R5QiZ5qGxeyNcIqnJAn4tdu55iNsHW9qx8rOo/MwoEQM?=
 =?us-ascii?Q?qqaVEZkRqyoFVK7pTcTQHcZkpUM0vCk7b5WQTUibpCl3VNbXb5Z1Ua+kX4Qt?=
 =?us-ascii?Q?poFOfwcIPn0Y9KKX/hc56c4gzMPkRuMsG4TppQfOYmXkxIAvmdY3lrWt6P92?=
 =?us-ascii?Q?2JXjzErSxblp/IRWI/QfaBACG3oAXmllpoUAQAe/DJkH4tdACJwiFBS8WPZb?=
 =?us-ascii?Q?Hhn4y6gB7oY3lKK2RkxEWVDJDP7pTHqW5Os4Yf4Vd7U5Zn8gkWNMHNoD+y7n?=
 =?us-ascii?Q?1RwzbPWuSOjHnHWyABaE/0gHRNsQjzmBk8Da8YyI13NWPsBOJtS8wlTDsFD9?=
 =?us-ascii?Q?RU+YXWtpBZynDv9yprj+bRPPzlBpaxNt4x4/mVsc1/K+zHRgmM7nUJWso7Ta?=
 =?us-ascii?Q?Ag2FM0Nv91LWAW7SdSeZpOA5Gplu3DnvJRo0zwiDMdFsvKP+noHawd9pHdRv?=
 =?us-ascii?Q?LZFh6NlUpgY79Uy+kTW3iXTsIoLuooPWzTdfap7LIAb0tRvBh7suTpyhHbLD?=
 =?us-ascii?Q?vQXJf3FCGLp/Da9HBhV1FfnIQ2akAP1dbUPZqJ83+e0ScN8xel+9fxXXmUev?=
 =?us-ascii?Q?TVkB19QISRRr8mio1aDvtU9YsCfWIPDx7HZFRvJUDMVHIcv3XRU3eOKkAOJW?=
 =?us-ascii?Q?cGohZk6cDWzhlINcFh21fEJi17+yP0ECmOBvwLkt8sPBC7KjwTnaAeMBIW5x?=
 =?us-ascii?Q?rYwrdaqKtTwyuypbWbfLTZBkyhTVAbHtWAEyf3BDz9d39ZQspZ4EX531cF8T?=
 =?us-ascii?Q?aiyh1p8h9pnac6g2smL07VGL5O+0MZg1en9sDnXI0/gFzFHHGhSLXOro+z/Q?=
 =?us-ascii?Q?BZBUJGSvrqoBC/i9UlF7c6+RmjyjzdzEsaiVd8hr1g8b1u8GO6Wg6OztaNy4?=
 =?us-ascii?Q?60AwaE53q4PJTD416F7IRpPG0qLeMRdirlCcj8bbm4wS6W88LYAYmFxtmcvI?=
 =?us-ascii?Q?6VMWd9pphYYauLRus7eapFTNshZYIQ3t9RL7/Y/oVPer9BYfAoUAQdnnfhRd?=
 =?us-ascii?Q?i8f/g/Zonvv4EfVUL4cHj5KEV8S3HdMqMi5rrGWXakil51Ouknhv6K+2B9cI?=
 =?us-ascii?Q?/k9uv08gfOKJLBKoVxleOKiLkl1amYBZR+1CPhqVsuIeorEMKGy6wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gmfx2Ak02RkmdHO8U1iTM5dEIjalx92fGxt/vCU0TZn+r6KHubzgwyXEMzxD?=
 =?us-ascii?Q?5lmB+50kzVy/H2FVJ4PrNHrFfIpURGl5E1dpTWPIAFyq/dL7OieaMgZSAPVK?=
 =?us-ascii?Q?7AcDDcJk2m/cUwzbj2jQpPzuDPWi2p0iDzcQ8c5yjn6CPO0F2RRSx+AxsTB6?=
 =?us-ascii?Q?9qrYsBuz5Q1ps61ycuBGPxvQkyZp9hn5daKL9/55PBMezE/V4cqM7I0cKb5t?=
 =?us-ascii?Q?1cbVxx903eZ7/ZG8JRNzQI29sgy4LjWccScJ8v++FJu7bdD9LcVaqIdtQD3Z?=
 =?us-ascii?Q?ti/53dHgOBwkm+dDXjloSaIMhtgxzk6fNVnu7eXIaRgKa6nUaxPfK5P3JJWS?=
 =?us-ascii?Q?Bzj62Ll1shgZdjlO9ioHLDCEyjer/xcEXbuJwYAUe2Mz4znG6Oz+GJMFfBmq?=
 =?us-ascii?Q?Ylfhy9o+RX9m7G6z6+XrFPJYYnh//JCWA2KgOXy9AbHo/DpbZGMCxFEGc7VZ?=
 =?us-ascii?Q?V/X4ikVfLP5qm14N50Kvt4TttB2M2Cksw39zE2aytDfQkCLuSHyXQVJzLha9?=
 =?us-ascii?Q?gR4Dh9se3tyj9ObDHkS6r2Ek/jGyMm1Z+jpQv6saC34vVUAeZ8zlTWq0M4bV?=
 =?us-ascii?Q?o+PHgzzUiGAafiFX1gz+8U95J9x2SrOdprZAcsxN7ppIoJR9bFGZQYwS4SW/?=
 =?us-ascii?Q?Fqu+unAZ5B2rsB2q4iCosRtLVtSZd2gQMSrox1AUR+looVUqAmPNWw5w2K8k?=
 =?us-ascii?Q?sgClOSKRKZeSYaOBB53LK6db7WQCI3gyl/rbNloBHMVgMi6NxCsvtfOrHhn8?=
 =?us-ascii?Q?4ARIEkWHCuZF2VQQyxTCZVm9Tg2fzKqYz7U62fYFveLc1bnRcLNQ8iDM87M6?=
 =?us-ascii?Q?fVsx28cn0gOviY7ZosghZPlYuvwFXbT3jZf5MtthfPRTzYq9yyq9V2qixZIc?=
 =?us-ascii?Q?L3uK7z637gYL1HSo6gdZrOEeiFCX/mbkkwVRMKV/zaNN8z+SsdwHZ4v4lztI?=
 =?us-ascii?Q?k6ePeijViB5979hMMu2nRGWuRWBMdbp5V0P8I+5nXj+AFgZ8Oh3DeLb+UCwZ?=
 =?us-ascii?Q?xBQxJhd9ZkWZq714LnY2kklhZSMpcjM/lh9+KOXmh2F2+KffSs11PIvNbPYf?=
 =?us-ascii?Q?COG4Eumu0n6RKts4IBvlRhJy06/bd/2XvnYE0Z0B/aUdTJRJffGQJir62/RG?=
 =?us-ascii?Q?RxnlvA2Il+CinQZ3xmvIvVVxfWIAP2+aV2rBC9kU010z+RF40TkS0FUPx7SK?=
 =?us-ascii?Q?N17F8oSDpNNwO2r1lonwSPQXnos1R7+KKlCb9QnG2PcUPaGrj8qdu3WRq7y7?=
 =?us-ascii?Q?XJU7efOgZcGqR5ajgUOhqQeZJj/W5DIq2xpaO0Od+EBtVhuVdCjTYmjPBiGW?=
 =?us-ascii?Q?r4tMIVAgbR+VJER9zmQpvrfpvUC+LJWEtSi1ZI4o/Z11Y6OrdhrNTDWcNkwY?=
 =?us-ascii?Q?IBHdB1Wc6SQSaVwlCJquDBSU3nFLRAsMQvkPoTiuG+mwCRWnOGfAk8Z2rxJa?=
 =?us-ascii?Q?QBcsg0z2JCAa4PiLaUrCyJ7Rc6fUBA9knwZ/nNBdDQasS14pZPza3AOM98Jc?=
 =?us-ascii?Q?IjqplPDHGrlhIP91W2w5TK1UqCXRwCdKmTH+DwjcckdmqGXnxlnQDQDMXNBI?=
 =?us-ascii?Q?INoU9XDn+BWftAnLL7Z9DSyH1crA97o2CK1J1iiC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8235fa9-e660-49b9-12bb-08dd817311d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:37.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLFNi/H9Daqa4cUKXbz+9qNlec2mHYimh9CCB/5wytAffJOJH7qJmDtMnECZe130sxWDYoUnX8yqUFkNyMJuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update add_qgroup_rb() to use rb_find_add().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/qgroup.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7325dbb16e38..989386311834 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -183,6 +183,14 @@ static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 	return rb_entry_safe(node, struct btrfs_qgroup, node);
 }
 
+static int btrfs_qgroup_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	const struct btrfs_qgroup *new_qgroup =
+		rb_entry(new, struct btrfs_qgroup, node);
+
+	return btrfs_qgroup_key_cmp(&new_qgroup->qgroupid, exist);
+}
+
 /*
  * Add qgroup to the filesystem's qgroup tree.
  *
@@ -195,39 +203,25 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 					  struct btrfs_qgroup *prealloc,
 					  u64 qgroupid)
 {
-	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct btrfs_qgroup *qgroup;
+	struct rb_node *exist;
 
 	/* Caller must have pre-allocated @prealloc. */
 	ASSERT(prealloc);
 
-	while (*p) {
-		parent = *p;
-		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
-
-		if (qgroup->qgroupid < qgroupid) {
-			p = &(*p)->rb_left;
-		} else if (qgroup->qgroupid > qgroupid) {
-			p = &(*p)->rb_right;
-		} else {
-			kfree(prealloc);
-			return qgroup;
-		}
+	prealloc->qgroupid = qgroupid;
+	exist = rb_find_add(&prealloc->node, &fs_info->qgroup_tree, btrfs_qgroup_cmp);
+	if (exist) {
+		kfree(prealloc);
+		return rb_entry(exist, struct btrfs_qgroup, node);
 	}
 
-	qgroup = prealloc;
-	qgroup->qgroupid = qgroupid;
-	INIT_LIST_HEAD(&qgroup->groups);
-	INIT_LIST_HEAD(&qgroup->members);
-	INIT_LIST_HEAD(&qgroup->dirty);
-	INIT_LIST_HEAD(&qgroup->iterator);
-	INIT_LIST_HEAD(&qgroup->nested_iterator);
-
-	rb_link_node(&qgroup->node, parent, p);
-	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
+	INIT_LIST_HEAD(&prealloc->groups);
+	INIT_LIST_HEAD(&prealloc->members);
+	INIT_LIST_HEAD(&prealloc->dirty);
+	INIT_LIST_HEAD(&prealloc->iterator);
+	INIT_LIST_HEAD(&prealloc->nested_iterator);
 
-	return qgroup;
+	return prealloc;
 }
 
 static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
-- 
2.39.0


