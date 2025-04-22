Return-Path: <linux-btrfs+bounces-13212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37844A9602E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED1417969A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802E256C9B;
	Tue, 22 Apr 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="StaRrEeD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD612561D7;
	Tue, 22 Apr 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308545; cv=fail; b=P8/onks+WTchtCCRYdcTsITnwUW/HDuTL+wUaCXiw+jqejNUnqtmCcJ2OTsCZDit3d3P7LAhnz4Jv/sj1HH2xeOQRuNMnoFHDNXz17qFXRw7WpSB/wp8ZIZILG+w04YsHIpwoWfbAuuvkL4/f1QbTvZIfKsrNY4QGzc6kqJ4wcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308545; c=relaxed/simple;
	bh=1a0r50VuMnIAdDSsaN/9RouVX1Upa1xjpGfev7cgaNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYkVbG+8pwuvDW599r1zBt0cEyr9cbkorpXOr6qwm3SC/D1Znl1SyahJ7gq2mH512jnD4IL2R2349rHzwLhfG0K/JLloDhmRcHMdO++IFUWWU/aRlssX6a2fmnp38kbCRj2LK/dX4ty8hYtxCWxbsPsq+3VM7mSM65070Modt7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=StaRrEeD; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKsaBdX8cMJwnNFv4zKZJxmXwP7whDViU1NhxKxrk5iHmDfv1bGVGaKA5IqCye11Ec3zeGaAYduY1BD1tMd6Usb/8v0iMr1Vbii6WvNdQxlhrfD0L8CcTPWUuHZoWnn/6PZ9BiepfrgvEnbP4h8RT3aRdOYgKFD7ZaM6Ni6h6Du+LcHliwUmZJMkkSfdRWB5LVr4dg12Qv/EIzevcopRQdmZ+t+v62CRJO6RPUDRje+EMKHv42GxUtZOw7WYviAK2eItw4I/h+zZm1JqS9HiIxJevn17C+TzZCoZlhxIsegLra+MNtCLz5NVromz/P5g+nOyx+uyOycpmPit4wgQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lozZy5hhRB8Cepetplmncu0jygdy4XZJawSXMlixYDo=;
 b=nHtrDi6oZuW4E0z93f1+2TMOI0UTSRpxGoVAM4Yu/3P0bkmHUdK4Vx0HXmMudmgPeqv7x90peFY6s7yzWUfD4RbIFJrv6E3NZI7WCvgkMsXrfQV4VwimWFr/ibDNlf1KEaCHdZIIskVudsFsld/whc3H5sXtmKjrSFkUq8IhUBkHuqedF5t+ZOwX3SKuxLy2u+qVZ3eMWcjRn55fQoReWYEZ2rAkAqsfk8YISubz76eZoVMJHS5cRwlBR1OI4wWYnUolCAvjPwzH8pPSuVoNPkV04lV37H/jWtZF0a1lITYPBSeH7IB9O7ZIJp96nNEHIWHS9IDBBSQElyKiaX4KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozZy5hhRB8Cepetplmncu0jygdy4XZJawSXMlixYDo=;
 b=StaRrEeDmofCytueDL2mCzPXZByFFkGyLBH4okDE3iYJ9kzEgzjDPwyJljeNxlV9cYALSz56K/jwntjEPWlbHIa1bPty9QsvyA/EKi8WEpd9IhW8J/B3P5GRk40L2EMOiIpxIb9fYiI4tFHz1q/1PI03E8nA5J9ynt5HoEB4rnBi6RmtKlEBFotpN9T+qx7BAJMpJW9IEeEV6GhSE3d04KifNkDWkm3VMB1pN9Ks2Me7ZoTyL83tvDDqAy7wTDp4+4lEpCy30E+XfzU6zyuZ78bXAmXxnNOp4EreXRSix/8LMmKSueQoe142ZdMV4OLbnDfQy721Om/qcuiGZuAkXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 07:55:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:55:36 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 10/13] btrfs: update find_qgroup_rb to to use rb helper
Date: Tue, 22 Apr 2025 02:15:01 -0600
Message-Id: <20250422081504.1998809-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41667ccb-cb3d-4c13-651b-08dd817310b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMfWqZXW/oZ38ZssItC9NbK5dGIxpdLZh4ota1sYkCW2TNZJs59kASu8Qp0S?=
 =?us-ascii?Q?gBjZd8BWzFuM3gXmYFxr6ikCTvVfQgrDXaW+fwB8QjUTwTTrNn8H4Qca3Ycc?=
 =?us-ascii?Q?7PX7k/WSqB70/DD7XHYvqLiab4SFYVa4Z7t12ekz4w72+yxgqGxI7o68dc2G?=
 =?us-ascii?Q?LyNXbg4CtL12XAozcXRlMpVS3emmSmAaqfCIjqbgQlCSvomP1NUjXtr7Tii/?=
 =?us-ascii?Q?tc29oHSVayJhIxk/6KvhwYV+ymELlRmwqh5kiJL5812EpMavM+NjDkZLH63a?=
 =?us-ascii?Q?f7+x1GSVLdVd6mrTqVlKoVvLLgYT2mR3gbhfKDq+6c4ONIUMsEUQMktGACR+?=
 =?us-ascii?Q?mfymfimDzfhio8pfhrFg/AVzlY1RYJE0UicaGEPuA7p72E3eTjWYjvaj5ULK?=
 =?us-ascii?Q?55eJaQQS73VtMKvXv2ZmvwvGz5dckRHdUzYADSBX6OcHdHOMsT7ZSDTHi2PB?=
 =?us-ascii?Q?azggsv97qdKHa4zthx+xiVHYw5Ui1KGFKgCElhM2HAb6iMcJR6fBV7o7BDN8?=
 =?us-ascii?Q?XeN3QS2CAVISwX76fQ75QHT43a7doMLJ/+mSZ8nk96KpkJrHexoyjdKNadQe?=
 =?us-ascii?Q?5hGNWvLvV+0CiIHvP5MSEkVJxFx3bWAbnedqufC5Gyq7O2xS0iNtHXTdWlUh?=
 =?us-ascii?Q?rA2DuIsWCh7Jg5VGNcHqzcQUhm3WM9DgIiZXTWrJ78g55ia3RANQGvdsaghy?=
 =?us-ascii?Q?10W1hocy+dfYS9MdiCjErOr8b7ONCPSYy4YQcrRmMuoqJRVX+4GZO1ehemqL?=
 =?us-ascii?Q?GNoW0OiMSiCVNaAKdsy6DnUYoaGkaCE9psrHoDebbJ90qWz40KXUxGgAgheF?=
 =?us-ascii?Q?0N5pia+j/Rf1XmqnUngDn8LL7fxOXMEiUpwx2IW2V9OOeHqmo2nESgW8OpL+?=
 =?us-ascii?Q?HzKHxpleTdgjURFOjkAszgbGS5TyuQBPWrN/99c5XMH//Hpx5QxfSUgYed0b?=
 =?us-ascii?Q?DTjhAK6VM1D+fn1HkXhPg4CED9bE4AgvoxbJWom7k9pICMPKUpVgqO0YE783?=
 =?us-ascii?Q?vXY2p6LXGn/sQoaiGQgIySuEF0eTdfrF0EmE8y4Pn11NV4R1iRfP8XbwM0r2?=
 =?us-ascii?Q?KLTRXdVTP/Leq0KQUISL4UhU2CGy0TAQCJDTBV51ouruDGeBUgVz2DyDwZbS?=
 =?us-ascii?Q?RxyXXWh1IP21FBqxN1VqWCQR34AiTLf9I9gZ/gUraJjSqYgyectMrE41YOZC?=
 =?us-ascii?Q?27ZDghBQw/hAhIc1c0na+J+XqOmUGovbUacVgSWL7Xe2j7Hg42A4WKolz+QZ?=
 =?us-ascii?Q?OyAJCJT0ORU8tbrmUKrDVcx2UoPhU8oFxS5289SAxjfsEEadVoxJGzUe8XS7?=
 =?us-ascii?Q?riVDnPbv4iaTOV4UOimjbq5qW2JoYBNpQ8/22DI1eaU+OWqRVxhCPsggFTzb?=
 =?us-ascii?Q?HTK4RvxX2tYqIH445dBP5ZPK6C0rDy/tTbdvCBR3erASDINWlC4hlLQgBs6K?=
 =?us-ascii?Q?zzYhif7n3lGZKNz7wSJJq6ozya/bKjOOfoFSu3NxokfUe2bIOJK9wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzGHWGAZU9YS+eBjfYWcxqVR8Cp/fmQ7P5Si5e1qOjGzkVMVxeJU/cHjTuUb?=
 =?us-ascii?Q?lWz2tBH48bi+6dk7TiYIqViYV9rTVxC4Tt7phOsUiU6rT5OxR7gNPfxPehdF?=
 =?us-ascii?Q?FjgWYKCtgpdLQJRG+6vy6V1AKJDbW8kp9fvlZRrA3tXb8Ob6QNcoBN3EsK3r?=
 =?us-ascii?Q?wxSvoN4277sa5qLNibsk8zHhYihgBqU86/wgGOcSih/3QWxrT07ZMLeZq/mx?=
 =?us-ascii?Q?BxgzpabNNaWT+kikeWNLONdd34LXUjAb7tk0STlGBCFbIaRSX2/HNSt0Veum?=
 =?us-ascii?Q?Dn87i3hfzEvzpxqvxXSu9CPnyFqs1dfgVyhjCScBHX2N2SO9+kzPs3WH2y/l?=
 =?us-ascii?Q?mm1YmgP1TFUis+IYR9ZrWAVSa/vRH7E/sMregNxAQqXI3b9cDrK/PEAar+oi?=
 =?us-ascii?Q?vPOKIZrHlncHuxWtaYTNskFDs0TftbbRa1eSggyYuxHlFMpSZQVFf4B99O+E?=
 =?us-ascii?Q?vixp0S88TDsnnBeVo1/VJU0svP586UkYNhipnxgGAxT3haa4naXjCYhQBjnX?=
 =?us-ascii?Q?NZjUbfH6p7ewI64KCafOyN7sWphTPgVoVNNcuj0bixZoz4xwu5tUIDuGvYHY?=
 =?us-ascii?Q?WC+T/uXAbVg3t53mDk9d9MtyHE7+Y9nimA4DLr4LhJyaTwoxV2b0yUnqB1b6?=
 =?us-ascii?Q?rpT0CVgZSZ2vA0cskIhzvuHHtJODBJyyhXW/c/jFZXXU8r+EaCtTmYsjrwbD?=
 =?us-ascii?Q?DKeCRtlJ8snE0FvDyRJnGFbOuKl+OJUSVvF7Fm/VfGd4spL5SpENNlP81pU2?=
 =?us-ascii?Q?V3JNt8InNNG72JzvDLkFkzgcrHDnUfWFul/C+BByrclfIuQLCplY8Z4tCMBv?=
 =?us-ascii?Q?O+Nqt2Oj58NZDAjf/UT45t5U498Av/uajyH8txtmaqo+vI/dqOr52hp+n9zC?=
 =?us-ascii?Q?8oFn3otxmB/SFi9+JzdQ53f0RDa/SFgmas6M39lAOXCsKizxX1lN/yku+2Ve?=
 =?us-ascii?Q?fPseFTH4DBPDigNTswAfh6XL4JofwNvQqIcYFOY4IgkomFfGXqtfk8O4QfAX?=
 =?us-ascii?Q?wPqsIqfJ9wt/fqkRnF9DUpsXqbeEQS4efpF4O+7Zgp/fnF6JBtbbfeqdY8lG?=
 =?us-ascii?Q?E1LdT7K0BF4oMU6voD/AtVnW5ehHn0wFct1ojgGrQr/bWe0kXuAfs7bOXsye?=
 =?us-ascii?Q?rutaj143jC1LnjjkizrPIJzqh7etku2DxzwLoxNNrR2oQWjR2kfLREDWCJ7w?=
 =?us-ascii?Q?jGwut+x9Z6fp1r5KjArjgDN9oa+kSDF3NeHzaNn2PU9aDOHvRj/Wv933cHyC?=
 =?us-ascii?Q?+BngYBXvUK7xRaMf0UacDoWElOWsvf+bcnpblZ3DL/RdtMrx1xMwQog1xsYM?=
 =?us-ascii?Q?Y9DaO0WLjAJYk4DrBHmOVNG9vcdfd4t42mmaSNXzeSGUFkTCOu5c/xDtvhLj?=
 =?us-ascii?Q?n67wtTG8Zk1CVFzsw1lFgGNceQzRF+aSzLpeurCIoLKZOQnUDaBJFEUlhClm?=
 =?us-ascii?Q?TKqZggXVPg0yyR/gYCjcPRnAV17T/eDpythHE4E2VWosO+wWXLdBaQdpWS8l?=
 =?us-ascii?Q?sQXEtWyvsQyoGIKNUCi9YjoWcMoH7Og/n37H+yADs97RniM/bopHSUXo5y+D?=
 =?us-ascii?Q?o6tJUYNKWlMynFYDFdmUw6s7LPb/7PBAAJJUztu9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41667ccb-cb3d-4c13-651b-08dd817310b9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:55:35.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3bUwXOjRgbBC2SnRli2gnCRTDMk7lH5HCo+jfgmZO6pvBjB6NOS/v5IEzywaLyxJUtZVW8gdS2mbxN07bAnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

Update find_qgroup_rb() to use rb_find().

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/qgroup.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d6fa36674270..7325dbb16e38 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -160,23 +160,27 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		   int init_flags);
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
+static int btrfs_qgroup_key_cmp(const void *k, const struct rb_node *node)
+{
+	const u64 *qgroupid = k;
+	const struct btrfs_qgroup *qgroup = rb_entry(node, struct btrfs_qgroup, node);
+
+	if (qgroup->qgroupid < *qgroupid)
+		return -1;
+	else if (qgroup->qgroupid > *qgroupid)
+		return 1;
+
+	return 0;
+}
+
 /* must be called with qgroup_ioctl_lock held */
 static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
-	struct rb_node *n = fs_info->qgroup_tree.rb_node;
-	struct btrfs_qgroup *qgroup;
+	struct rb_node *node;
 
-	while (n) {
-		qgroup = rb_entry(n, struct btrfs_qgroup, node);
-		if (qgroup->qgroupid < qgroupid)
-			n = n->rb_left;
-		else if (qgroup->qgroupid > qgroupid)
-			n = n->rb_right;
-		else
-			return qgroup;
-	}
-	return NULL;
+	node = rb_find(&qgroupid, &fs_info->qgroup_tree, btrfs_qgroup_key_cmp);
+	return rb_entry_safe(node, struct btrfs_qgroup, node);
 }
 
 /*
-- 
2.39.0


