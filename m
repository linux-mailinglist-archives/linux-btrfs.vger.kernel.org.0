Return-Path: <linux-btrfs+bounces-14067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F183AB944D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11A6A02591
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7B231A55;
	Fri, 16 May 2025 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ATH+Sw68"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964325E832;
	Fri, 16 May 2025 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364655; cv=fail; b=aqiDjcY+eZtQo1vAjUK20ZEKUOI5lAntQSrpasbjScYXYIsgFi0cc048YOQkR7mXD54tJD7hTezHDo2967XiecXZWcSYcgfk1nSMzXehVSd9bayyMvLXNw6ZkK9thnylBhP1lLpt90aUOzU9Q0OK1TjMLOGsP2+njYj5R8OruvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364655; c=relaxed/simple;
	bh=RlJomE8o2ht/iQ/WFhsuf+4YxYCCBfq2OCyPD0xzzo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODEyO3K9wW458w/Js7ZI58UvHKMtwACl+GA4VZe91FoGw48lNuufAnIrY2ttCBEh7Qh2LXzhc1pRYeClKDsgBGBNTl+orhk3K6zUXhakjZRR7mFDFh/vhGnx5d4fxkbRjqkNHMmYCtQzf7mERZdPW1fKpGsp0uQ2+h/QPKlWqIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ATH+Sw68; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqmuSuwtEjjXE9y7e+fTnWChXMGHsh+Lz8wuoASLt18YdQcXOMIIBvM2yb//e7slDglDhhtR8zWw4XnxSPu6Vq1Nuqt0MP3uzdQ8NTVz22LfRC4p2fbI0yf8fGvllp32lcE2ZVXpBwOEYVLv5Mp9DFzAnvYKMbreFyTDdLTy2FvDSZ7aYMZil3pv7j4jfnczHdx9V6bheb3Dvd2aqhFZL3dLF8SPb3qSIdKJXCGKK0dnJwZNpkQZzzesSdKNop6ZtbFW1pO+Qma3ojtZpNaj9bDHCKMo3U2SSXtrSg3xutiEKrNvTQceTf1PRpwKBo1cerzEGtmdXZHWEPsL1YgxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/H+l8+FB/aQNAV/lGJ0EbOxW5UG1QJr7ssig/o4g0Q=;
 b=T5fHRYR8hGLBlPGgrX9i7UiWozDeINeJaSjOA+QCQ0RAHlLeMB6fePpZYJWyqU2GwCTGOhzXwcYDKvgCUPVNCcpQpND6erK405ZsPG/VFGmZ5LthOF1Hq9eMoQFyeHUykKa9M4Z4UMRHHN08c8p+CqFSuK6tMSfys6xWdrbRLvrWl1XiBW2T0XPTshtF5bSx8cJUdd8uQi5TQ5z5S3DZJlvsgpyNGbpFGmTTqkMvz+I3l3eizziBuSiMvCtkLfXGzzS6KJmZ65w/iyOvXYG5ky4ed2CSxc6V1ZTECKPEKLNvBLmzK1CrK+xPnW6P0mJdw3TjQnw7ATehldXinnGDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/H+l8+FB/aQNAV/lGJ0EbOxW5UG1QJr7ssig/o4g0Q=;
 b=ATH+Sw68cgRlOsv2voqGMq+yZB+gFMYfPUX+rkCj6gFDIS66UopVxZKMgtf5itEZ95n/jEeTCzYMIE1lwjQj9jR6lrTw+RIYtj7m/GLwpSJCC69hlyEroS2iQAzPYLrGa7rcv2wXqCM2bojcg2B5ogALWvpUgfie1/QOerUgG6ub17UHG3pC1GOIJCyWwqoKOvdTGJHrgI4AckW4KOxrKNt9PLVvQ4q3MLWcdN/7LH+t9nk4hebae8U+y44GrZTinLiSGr3Huch9s6uXg5mOuXoytV7PBBqYprs/R7ArXW4u3nGLd/Rw0/5e5NY/YyA/3NkOy8/pmGGiZ7tWx9zYqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com (2603:1096:405:bf::11)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 03:04:09 +0000
Received: from TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5]) by TYSPR06MB7646.apcprd06.prod.outlook.com
 ([fe80::b735:577c:48bd:c7c5%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 03:04:09 +0000
From: Pan Chuang <panchuang@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	frank.li@vivo.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 09/15] btrfs: use rb_find_add() in insert_ref_entry()
Date: Fri, 16 May 2025 11:03:27 +0800
Message-Id: <20250516030333.3758-10-panchuang@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250516030333.3758-1-panchuang@vivo.com>
References: <20250516030333.3758-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To TYSPR06MB7646.apcprd06.prod.outlook.com
 (2603:1096:405:bf::11)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7646:EE_|SEZPR06MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: c7805cb0-135f-4421-8ab1-08dd942653ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNNpehofJZosNaswS6lzt2rhImiRJ2qU+6x/EMb7z0meFx2DfRCWSQClUlbY?=
 =?us-ascii?Q?UmIfywMgxHKRlhE5po0LGxkDzqvfkB1IGehd1g7C2EAG6WSlm2h9zFmhKC9G?=
 =?us-ascii?Q?CkdM2GR9QhSdPtYCCmQsHIxkSugswnai5h17ejEPc5ybIsZ/rDUs970+Rs4K?=
 =?us-ascii?Q?vTc6s+XlgPbefFj2YxHDC5tTxkPsgNrRdDFsaN9edSkutxjqYfhkUepGmGKO?=
 =?us-ascii?Q?TGgjq9oimePOeYYoPog1jxAiaajC/FU8Du/S6BbldXQ1UbZQz83PJ+uOCif0?=
 =?us-ascii?Q?6IE3+Ov/qoBBPFM8dRxWUadqGuqv8tSvUvkqOeQd8BqzK5YLFiwuR+Ol2rUl?=
 =?us-ascii?Q?8+w0b5ypCUeeVrb2v1LFn5msvda9fPCNNO8ejMjmVa+yYw8uRtx7SApr17xb?=
 =?us-ascii?Q?/H5GEdl6V3X9RmCh87URm55EQDcvqRQw9AUcOSd+NVKiNhJSmCdgUJJRgrof?=
 =?us-ascii?Q?VLWNPj4x+3h19e+QeBI5sZ0C0eK/ZKCTAtJY3nQ5fAZuEXfozBVS3Hzb8w6K?=
 =?us-ascii?Q?4Nqoj/jHDOonb2ofCoULEZ6gys+SB0MJX1HHNkWnuzU+Z9T9egCK9XDF4TDm?=
 =?us-ascii?Q?R1almjJ99Wl9kGsRhNDD3W6hhWZDKknrCOdVGtLVl4+AANg5PDKorvBl/tKl?=
 =?us-ascii?Q?XJsXfdbsAFM/qTCXT+viKf28Pg1wY8jEENKCm0ivNlHhy9d7HmEwYh8Mhrgv?=
 =?us-ascii?Q?pwapC0lmRffWiQQ5d9NYK6HhDTF0sq2nDuD8ej9YvE8QHc94o8Wgjb6K1wTQ?=
 =?us-ascii?Q?5rT1DJhID2gi1iYFESf8It4TDWnmzdFxjGgQEbrxkeKP5qRVNoo7k8CuGRtc?=
 =?us-ascii?Q?27exYcA9WJ4lKqCmlpOA4oFBOGhG/jDb4uIl0K8KwPiYATwZHqaKYtm8RxzP?=
 =?us-ascii?Q?yvcsqogjvDa5238EedLLFq5xIWPDp2zkORQ3sbmAzLPBoeTXomM/qh30LStt?=
 =?us-ascii?Q?pkBDWlf4VxSqc/78DnfusHCUAqQDrzZ08BSwKqZVALk+vALv6NmcXH7EMWi/?=
 =?us-ascii?Q?JC971e7bq7AZh7gbJ0i5RwfF/vXe/+qy/qPyZmedH4n1j71via8WsGnvf2Fv?=
 =?us-ascii?Q?BgmXAtoUurhxMQwTtadTRSDfrvtHmpcwgkJO+SYK8rT0qNKwQu2J1G5DM35g?=
 =?us-ascii?Q?L73wjEPO94jkPmwT20s/wAqtsZmMLdRbQm/RWK0YCNIHG0sBBhqY9HLH+qwM?=
 =?us-ascii?Q?qBKqZlYrUWwv/GhIWocFpTZt/bjCBIq4oW7DmwkkHmksLpWZKVhSQ29bO192?=
 =?us-ascii?Q?x18aNwEGZjrnSW/UJTla5EOIi/SCRdcZ2zeJr9tjNlrvaqgFDsIiwXOd9RBH?=
 =?us-ascii?Q?fSPquhtgD044Z1lPOMCpY5KTK0XcGAHO7hTKcYnXZe9yTaw5YWdd1DMfM+Ff?=
 =?us-ascii?Q?gOvQaOeSOvaMOt18+iR+pL19mtXW1Ld8OdkhhJMahdcHTEQ4ZEtFf2oVhmaQ?=
 =?us-ascii?Q?Zn1oyWJbXvklHYaNMdkL2LfiDDI+jXe8aw47D4bxvKXSKjXSGb5aYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7646.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0+qIxqmKf3bncxfzSJOEiFB/CtrShqfEy68TvzXCzOTsaANouJFUhGxmNrD?=
 =?us-ascii?Q?/Dj9QhKoD+3CrTaqiOWR5pVTCXXbJUFQrXrds39JlIBxnOf62cuO691BKp0p?=
 =?us-ascii?Q?PVYCH7PVMEp0jvUikjCeFk7P8zM2HRJ9RrsHwIo1PBwiFXdgBeQiJO2+eizl?=
 =?us-ascii?Q?jdpclSXO5iv9QdD5kIE0n8Y4gN/J+slRV+V3mNef4hq2G9MK3WdbTNAOEuoo?=
 =?us-ascii?Q?pxbrtzQJUdK87Xe98vmd5RJ4J/1CP+VdXjHTGJMp+BOPqLQbyPwvG7kS7j3d?=
 =?us-ascii?Q?Dmue2uwqtqmAqYM13twZ5J+GyrtuXycMrPEo65mhYtC9DWIsDyyNdT6q2tie?=
 =?us-ascii?Q?GGxdF/4bA4xzZ7a7E6d12zOt7gLC7PtiYVkbuhgM4XwZlattjW3DirbvaUDs?=
 =?us-ascii?Q?Qyvs1nveZACb1Ke5FuhXViBLggHb/65m0vmZr9BEQhbfyk5sK3wdeMhlpe5t?=
 =?us-ascii?Q?EQTCzVMq7HdT7qqWoBBnoyiYFVWzLGHwgrQa+h9Qv0DvXAlbfQJ4St3ZVIa/?=
 =?us-ascii?Q?dJG34AEcpk7Pa4+H0OQz/zBn0pAfj5+XY8yt85CEH77u49eTzylVJ4nRLrY7?=
 =?us-ascii?Q?rVgB7ujlh+yc427z9xjU6SAs1WJvpRQJ1f8TP5d27tKrLJeJzB029ZzZ3ZCU?=
 =?us-ascii?Q?AYc1rBOz7obucYO8odW3Ud3xW9SrRxvVAy9YeIRMSRZiTE5Gzo15h7fQcIl/?=
 =?us-ascii?Q?mR8JOzRqh6b4vrvtv9pGTirYTRlLpr0R463UOKL2n2nOAhSswfGKpe4n2KAz?=
 =?us-ascii?Q?/xPONKw3sfzEDLn7I7yaoaSSlrNDFu8OfyUxkFYCTY4jzmqTDebAJZto1p0o?=
 =?us-ascii?Q?y7orBjD5dp8y0FKqpxK4UeGbzwfCwsJ9Lwbkhg1++Tol2i+o5oGIoJvl3FED?=
 =?us-ascii?Q?3CmWi/txyMaQAJ0VJ3bw0JJE8X8bY/VkRzZJTotAzRDb8voUCISnyJQX+QTg?=
 =?us-ascii?Q?BfyO7UY8C2tLb8Z2hOeKDKRZb+tlgQyRDIiu4AOJNjtQAeQcLLKDZ7o3Fai3?=
 =?us-ascii?Q?MSlnKlmqbm9L/FSeG7h2sov0Qzo2l8nDz9sXPyHKffViv8qokNI2XpBAzimD?=
 =?us-ascii?Q?vqy+ln0uVAGvjwp9+VLg/TdLwanDPvYTBQcA0x3JJhs/iZn3TLHHkHtWpdd8?=
 =?us-ascii?Q?ApoLa67/sov/An8We6Cjad57jYWgruB3Dq8OuPUiB/nWdXLbhcYeNf+Yl4sP?=
 =?us-ascii?Q?2JeAUmrBpsdIQrkC/hOsiWizMq3XZIgwZ7AK1d4tOdG9BvZi5ij1rdeAnZek?=
 =?us-ascii?Q?p/a5JDWCmz0l03C7PIZspP13DGgYexRWvI43C4MViwy9Kg53QmLjzMdZ6H8o?=
 =?us-ascii?Q?wkgN3gQ1ETfJi6wRP8geAzy9ZOZuS5Aywc3euJ48EWLfUiW+cGM9sMIkW8DU?=
 =?us-ascii?Q?eIp9VGEsObVdb0Tt0pTmiF9P4FnuVkkIqBjES/QJJgRxuMQrFlXJgUq4vveP?=
 =?us-ascii?Q?aaB/CBtSAju6CIotMH4+n/8u4baKr9WJj+ZzyTq0b55J5/zsUzKjuZULu6Wj?=
 =?us-ascii?Q?HJcFGxapbkTA9kLqF/X04+nvSj70F0qtGuoLvzVpfRHzzLCYStQ32oQ9uXCI?=
 =?us-ascii?Q?XndcJEJ0gHsumeW3JB0BIHkIgmiBHsEAHJgN/T0c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7805cb0-135f-4421-8ab1-08dd942653ed
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7646.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:04:09.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhoiQDa0uaTH+IkHUHu7yn6okrD4T2iQk9Qwk2GnqkIvEg5kwlNdPzklIGdpDBv8Y+SaP0H3qftOJzmhrnlxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

From: Yangtao Li <frank.li@vivo.com>

Use the rb-tree helper so we don't open code the search and insert
code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
v2:
 - Standardize coding style without logical change.
---
 fs/btrfs/ref-verify.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index f241ed4bc21c..d97dfa45521c 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -165,30 +165,21 @@ static int comp_refs(struct ref_entry *ref1, struct ref_entry *ref2)
 	return 0;
 }
 
+static int ref_entry_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct ref_entry *new_entry = rb_entry(new, struct ref_entry, node);
+	struct ref_entry *exist_entry = rb_entry(exist, struct ref_entry, node);
+
+	return comp_refs(new_entry, exist_entry);
+}
+
 static struct ref_entry *insert_ref_entry(struct rb_root *root,
 					  struct ref_entry *ref)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent_node = NULL;
-	struct ref_entry *entry;
-	int cmp;
-
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct ref_entry, node);
-		cmp = comp_refs(entry, ref);
-		if (cmp > 0)
-			p = &(*p)->rb_left;
-		else if (cmp < 0)
-			p = &(*p)->rb_right;
-		else
-			return entry;
-	}
-
-	rb_link_node(&ref->node, parent_node, p);
-	rb_insert_color(&ref->node, root);
-	return NULL;
+	struct rb_node *node;
 
+	node = rb_find_add(&ref->node, root, ref_entry_cmp);
+	return rb_entry_safe(node, struct ref_entry, node);
 }
 
 static struct root_entry *lookup_root_entry(struct rb_root *root, u64 objectid)
-- 
2.39.0


