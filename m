Return-Path: <linux-btrfs+bounces-13017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DBA8927E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217AD7A5E65
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99420ADE6;
	Tue, 15 Apr 2025 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lCEKe4qa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011008.outbound.protection.outlook.com [52.101.129.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B132DFA41;
	Tue, 15 Apr 2025 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687162; cv=fail; b=WGLNsptU0in0gSWgPQZYBtsvD6BbzqCxN+913EjT/v8w7QZatO6coiepdsBXVulmJB/26pm2NKynFSHRwchY/BBbU6uiQB1UqBBU3lKl56PHMFhPSjUZm2UUCxXJ2krgGLBIBVTB3L5Xv0fRMQK4jFRj35BXmcbG317C18gzFsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687162; c=relaxed/simple;
	bh=lhsM8FBGq3WwS+s39CCV3mCr2QKfVHftUKqnfxwuLB4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R7Ed4kxDrl8Vhrjy/rk2ktWizWaJ+PES001g6EtWX6Rgx5aELDI84JNLtD+lTynRD8qOckuCFofVxOWdnPaHkXiO7LRQaGbIrXYyNxLLLl6xTVeswdcS1Jc56wV70SnbDu7fzCU6k4KcgQMHUhq5422+yhw9jDzgssBiA4cmJwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lCEKe4qa; arc=fail smtp.client-ip=52.101.129.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXl0kDsn2rJnBAukirXTcRUQi3PhATUClbpuSH73rVy4TWnmZ9UOrUtTf/tmNXAWKBBSR7eW01VYRnhl7zmq28BDMwIqAeexNm/ZZw38YdAZ5UmlNdAM2pg3rN1hmpJn2xnFVhrolcT1Cv2Tuang43npdYU9+gQIq6+rUwJ5caK7KayVIvjR+VcAXJoeyfMvuBN9b6lGSKygVlZvyZIIb3/ySN796QR/hL3NsUu+sVCeb8Dnv8iwOvOdjZGZR+FvKTmiH/83MPJPZk5am88GifW0A8AXKOaiA0bjypJHp5v7/R0/sg7Ps6iOBo5Agn1mnyXwogYg3n/CPJTHr+EirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlHMmETapy01h596qhm417/EdFir6kaB06CqLT90rm4=;
 b=CZ+SdBmn27gB7ruGzrTJKBOZ4PFo9mq97YBf5+h6qcUjRoFcXasPWiwG5KDQS02JC5kxmls9/OFTZkNntqNTXach4e/ppcqiuY8HvxoL2+LL1QDVyTaV8g4dVfLvKLLka3mKf8NNNmP4zg4KNfvMh8fpLPL4s29TgpEhiflKemqp1f8T5ciAXy7tG0537C+5tuuNlohMiT1DmiLM0542JwcrqNxuJgC1o+yZuLB62odiFz3dnH3eSLqyruY+0hFJQ41C8UWnxMSXZYdJQ1t6slL+R8AjNlkJDZAwc4qIzitApEym+uRvUt6mFYCsYzyg4NvzLG532dg0ar50S03rgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlHMmETapy01h596qhm417/EdFir6kaB06CqLT90rm4=;
 b=lCEKe4qaBaAi/QDKBQStNAHzV6d1uLzdIcqr4nqGOYnx0mTO7E8eBHNw3s4sRYbFoo1cM0ZMyGYb8VKmJADT/of2lZJVTFVZribrFZg1yBPvNFgDM4wQ+uqedN/TTKtoUD7G2720A6yojEEAy9SO/mYE1dL0Jxagf3PqS5dwwgUqoInzool2Gmk2NCEa2LfT/C2XMd1B2C39tc6PQqN/Op2HvOb8WNQ9zZQNzjjvUenSkIbmMvKNCGBQbs2FEWYvLKImDtojuZ7QfN/1k/GzGADHPZ9n9TVpZFWTHaHdmnz6LTBayBcFBrAkMJPbEL+zbUDOMpJw4yHkcLbzokvA4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6319.apcprd06.prod.outlook.com (2603:1096:990:b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Tue, 15 Apr
 2025 03:19:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 03:19:15 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH 1/3] btrfs: get rid of path allocation in btrfs_del_inode_extref()
Date: Mon, 14 Apr 2025 21:38:52 -0600
Message-Id: <20250415033854.848776-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: d286270f-3d55-4486-f3cb-08dd7bcc4d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iMwRybCQ3j1j5szdoCNTMaGHscPwAVjMVnG+pabDVDUvDx9971BlobhSWM0S?=
 =?us-ascii?Q?XXyZn1LWP2yjT82gNrH0Ipe8+6VuUufSDL4YhJJrzVQvUYsiijQgPOmllJEY?=
 =?us-ascii?Q?iARlsgm+VND3pJ+DQ2kvfFTdAjUqDVxnMTzDRXXck7d5mVy6VHWL1D+baTE9?=
 =?us-ascii?Q?BR25Z3NaQbk1MNRN1j/42Tkzc6QbmpZnGIa2pFQYvKXz442+XwZ5trn+bm7D?=
 =?us-ascii?Q?bo/ZgwWRqDs494HNMBGlaIyCcxz8tRAWyoSda6rjBI1r65aLMvyheACyFTbM?=
 =?us-ascii?Q?nrDObASYqBym9E3z6Mt1I+DdixOS7rOgF1rWaRw9YuAuGntRdFfFOLdB4MxF?=
 =?us-ascii?Q?zpyE0fOg3Kdp4YwXwsZ251cRt9obytbh8MuGAQrxX6n6CV5haNjnqHUoyhqz?=
 =?us-ascii?Q?BPBBiPVYNt6nX/rmPYfPHkemoPiegz/2g/JRioxPJm4X0ZxPH+don93N4JcN?=
 =?us-ascii?Q?a5QEd2yx5gc0EHTolTZ8qlEJh3L6thzuRYMbY2m7G3V2PoFOdPwIHVEN6BKQ?=
 =?us-ascii?Q?vaM6PPBV8uUWjZvV0zB6B0OVhVhhod0qtsRAw0B+aDYu8UvEH1+8couDbh39?=
 =?us-ascii?Q?xtKFW1ebcti5jZyUe2TDneunfFTw2x6RQzORlIeGmD8IRakQWHRMN4+Af/qe?=
 =?us-ascii?Q?PRWnDL1roP5d88/4rSfue10Ji2hvvJsG/fYffzA74UxXuaHjsQFBsdl215XZ?=
 =?us-ascii?Q?dBnTgSX0WTWL/ANjwsQEL0hzarUDQ7xTZJ5VBW0gEjcb7kQwb+zMewK8AQYA?=
 =?us-ascii?Q?vYJGCIsqK7d+QatLg3q7CbJUKzraYw9uaXhZKBW3wAjGPUYKOMfvR8KM69dT?=
 =?us-ascii?Q?iy8e04/4M0Ah5/L6dT4jRUJt1SvCdknMjr7SRsg7wsW8b/FZX935JVWHmOT9?=
 =?us-ascii?Q?4k3rauN4s3bgkkbWipsoBxer0ZbVF+5tAaMVnmIieIBVkLtUBY2aaU6C7SPl?=
 =?us-ascii?Q?mmCBGldmyedCeEy8jHfi+blG/bzMx4iy+Z9O8vcC5Er1waJMLBqLmq/PNZB7?=
 =?us-ascii?Q?Ldb0xkAAPxr7lIxgBmgWFt8+SFIF2z9qaLpLvh3TQSH4rgPASeQJ50TXjxca?=
 =?us-ascii?Q?dInq3gWZbAwf+ip68GBocp0m4SM4ZsbYV6I5nHHjbiLhvYaKOnghZS2ZXJmz?=
 =?us-ascii?Q?VNptad/z6fUq7b+fWbIANLHmV2q3wNpmG3xXhOALzj+GeGKDS5mU33Kxp+4s?=
 =?us-ascii?Q?Jq36p3fw22PYDxfMNoa9GkqNwJ/iNUf84VS7Kq411aK3aFiV+o97nlF/PBcT?=
 =?us-ascii?Q?sdpbI68K8IFa26Yp0/tIq3ob1jv1XSza3OqAlSiE1EZpJk8lU4AvjlvG5Xg7?=
 =?us-ascii?Q?37jOkU1LxVdKjUwuVHm5tvqKDwTlpacCMp+xd+deBj/p64y36AL2xTX0u+De?=
 =?us-ascii?Q?HbrP8kAwUzoFX4kG5eKxtHylDw8HC4clz/UolJp4MpsI2zXzCIg7PGgs7b9J?=
 =?us-ascii?Q?uhztDzrhlamXPMk4re4W0KRPsmjk+YDOtUCvu3+/qCeCX+iE3unDWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o67qlsTCkJnmjmlepvbXfg6B0fdX56BvDQAcI8/d4pdDLncBLVMdn2WOxFxD?=
 =?us-ascii?Q?2PEMWvZ2xFoP/fs1Kk1+RC5I5tUCY4NksTkLxdv1BNur/atviSDuNQMcnl2+?=
 =?us-ascii?Q?+3ue29DtjaOg0spfX5JaGA/ea4wxStj96SpZoi+hViqv2MjNGRW4ZKVC07dV?=
 =?us-ascii?Q?edeVW/fVfvxpMH5O0436JVJyrvpu6KyBxht0QLW7n8i63iJdkkn6AAtqQyI2?=
 =?us-ascii?Q?qZ0TSnTD/Xcvnl5Ir5TWf9SM8ZgIjBmfppVqh9dImpslSsVkYFiaJUs0YJa6?=
 =?us-ascii?Q?PEMgBuEWYv915TczKh67RhlHFEXvKxCHxAgu/eBa6veJjXry6Fu1le/y9r3H?=
 =?us-ascii?Q?qHsmWhyts9DbwnV/PN6QjlMGMopt+3LrHok4H6VEbmDICqYXoYdQEl8/kpCj?=
 =?us-ascii?Q?ZHsrOGX90HEjbIGcCjTk8lRrS2d/12bQeNd302114k32/1ajtGJ8L7jIatOa?=
 =?us-ascii?Q?k/CCUHyjHQtfsabWKDUKCzEopRCfcKOCORoQJmIqwH3W8b509l6PecYGY9n/?=
 =?us-ascii?Q?YGmlN1r30C2dZv4cN9u5Q5doGgl6bYhRxjnMP00Mu/lVSA5P8rIg/okjQF2e?=
 =?us-ascii?Q?iEX9bXyMmk6tJuFrv9SIVL3JHAE2r9GPFWTZ0JMsz/7SdmOsd3VBqxaiaPID?=
 =?us-ascii?Q?0KIwrx3xOy7nt8g/qEvAY8Y3AJ539DKre4Lxv0sZbYH3uuK40x9+MbRqa/SV?=
 =?us-ascii?Q?VKK4roT6NXcQoZOM7VunYaFPmpUeWOUdAetsKNE6EjQ2VVJVQx6A+FkbY2AA?=
 =?us-ascii?Q?B6him/HU6gqEWr0LX+x+kSo5KFBk5CxX8ZIbsMQFWwZiS0bi6ERjhC6LFUyt?=
 =?us-ascii?Q?WYMQopq4Pfc0CDml56TJlJxI7xQ39FqsT5wx8fqSmDEnxlhADeWOEg0i2HYb?=
 =?us-ascii?Q?qFNrYphuzCj2hQtdQjS8t1W0VSI8BoT0ZgWrONWbm0JlFNwoCe2NOPaLLrqt?=
 =?us-ascii?Q?k2xQ4jMcNCuTU9eQ1AmXRSBF+MugeqOtk8GbeGRg38ssd2flrRcC+kqVpjeb?=
 =?us-ascii?Q?edwZoMTZ/LUqJwC1Rydsvv8hpeIvQgPasNvf8vyeaB9v8r2nvMc3IPudtOLQ?=
 =?us-ascii?Q?B3qZRN/EdhgA029yJCKjocNroefocAdbUI0L2SVpTOYjiw34h0eJAlyj+S5n?=
 =?us-ascii?Q?ed2ulOT5EQam+Ioin8k6a+4QnEfe3cRMYtYD7jG3QzpKqJ+LH+j8fr9YPFft?=
 =?us-ascii?Q?6Z8oZn2c9Fyq9SFRGjP+2oM8r8VDo7STZq+w7/FrF2Gj9i8P52/XvZzHzXYM?=
 =?us-ascii?Q?8o4x/g2mUjRHNcl+7FAWYlJDIxyRNo0hDyte6mHu1DeWsN7iR+lhS35tOSFX?=
 =?us-ascii?Q?zRmrX8v0nhNnWe2QlATCoxoW1tlVT1pOPy2u4bcad7Tmpd3NUWMh+el18O7x?=
 =?us-ascii?Q?ltYuJ7Z2L5pZlb3nKwboJ6WWKwT8Cl+pe1d2PFpcL7jqTPBfmhDp4xQGz0tX?=
 =?us-ascii?Q?rx5V3rsxIuCZ/lusocHn5++vZUuf45uM9Tuj4xN68z34L0DpjyAY8PA1dAqH?=
 =?us-ascii?Q?gt6aWq4Gm7axmHOwhn95wG8Abk1A5iuCXKTh5H27aBTVEptpiJx/R+wamMVw?=
 =?us-ascii?Q?a8PwMK+0pNt7cVZfV+A6FOs28RfBA7APwKfDOxFh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d286270f-3d55-4486-f3cb-08dd7bcc4d01
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:19:15.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDZNdE4YFz3ml1wC8LtMLRXVh8WAnO2bfOFjID7P2VLg7yPwQpyaEGhRHUCEqMvEM97WgZmjZTa2tBK/71QtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6319

Pass path objects from btrfs_del_inode_ref() to
btrfs_del_inode_extref(), which reducing path allocations
and potential failures.

BTW convert to use BTRFS_PATH_AUTO_FREE macro.

Suggested-by: Daniel Vacek <neelx@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/inode-item.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 3530de0618c8..693cd47668eb 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -105,11 +105,11 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 
 static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
+				  struct btrfs_path *path,
 				  const struct fscrypt_str *name,
 				  u64 inode_objectid, u64 ref_objectid,
 				  u64 *index)
 {
-	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_inode_extref *extref;
 	struct extent_buffer *leaf;
@@ -123,15 +123,11 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_INODE_EXTREF_KEY;
 	key.offset = btrfs_extref_hash(ref_objectid, name->name, name->len);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/*
 	 * Sanity check - did we find the right item for this name?
@@ -142,8 +138,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 						ref_objectid, name);
 	if (!extref) {
 		btrfs_abort_transaction(trans, -ENOENT);
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	leaf = path->nodes[0];
@@ -156,8 +151,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 		 * Common case only one ref in the item, remove the
 		 * whole item.
 		 */
-		ret = btrfs_del_item(trans, root, path);
-		goto out;
+		return btrfs_del_item(trans, root, path);
 	}
 
 	ptr = (unsigned long)extref;
@@ -168,17 +162,14 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 
 	btrfs_truncate_item(trans, path, item_size - del_len, 1);
 
-out:
-	btrfs_free_path(path);
-
-	return ret;
+	return 0;
 }
 
 int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, const struct fscrypt_str *name,
 			u64 inode_objectid, u64 ref_objectid, u64 *index)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_inode_ref *ref;
 	struct extent_buffer *leaf;
@@ -230,7 +221,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			      item_size - (ptr + sub_item_len - item_start));
 	btrfs_truncate_item(trans, path, item_size - sub_item_len, 1);
 out:
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	if (search_ext_refs) {
 		/*
@@ -238,7 +229,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		 * name in our ref array. Find and remove the extended
 		 * inode ref then.
 		 */
-		return btrfs_del_inode_extref(trans, root, name,
+		return btrfs_del_inode_extref(trans, root, path, name,
 					      inode_objectid, ref_objectid, index);
 	}
 
-- 
2.39.0


