Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714C142EEF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhJOKjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 06:39:08 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:17024
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhJOKjI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 06:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWVrTTtSbYltdQ9lB/R8sUoLfucnRqw8lgN8lxmH2Hyzw8ppcXTCjniI0D3Y4ggbpuoQ+ybX8JHrOGp34GidnXVZkpzrSnBc1K3+rlZ10+v8X0WBkjGahMcP9DG6KzyyKl5JHKs99TIkKFfxlGZFvQUi+Rkao66SVDYepol0PsL3xspoty6lO/8nMn7HRSrxm3dmvQjkzdix19F0W7mgAJmPzjs1HFj4aSn1Oz/CprwZOv6c4fvv5gcTCratFoCcWST1B1y6a4p+Wz4SCi0dDdmfYGng1qPPIbE3Dp8VhA5d5rDbeK1sSe2JKmN9Lssn9VvdoQtOWeXna6YYNBhxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gymL2nQ/97AuPzbnWg+lS7S1oSf95CWe26cSL7qy7bU=;
 b=cJSKnKQxJ/0/GkLKsPAreinCw3GbZ1cPq7RH45DK3t2eCsDZ3iAFvIhQkIgNAAQy+cOb1E0uZWSELtQejSY4TEHfvMeXDNKd7H5z5kV+KOW1aYI2MKbg07CMobmxL822B/27RDnftjmspQ3SPxh0+4L/T61rF5ef1p1TKXHzKOoo3eKgBNDYPXlscAHwXUisNV7xif9dbItGlgMhI8v+AHRcBjwcXIBIT9JJOTDY07dkFmZd3DbfDzPiq9WqLbnB8wsLzp7uQydLxEq9+jY3dIXLI6JgE1PrTCV+DE2UHoqYPPppSnr9TgZSivJU3bCWCIha+eVCu2fsHvT3mxh7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gymL2nQ/97AuPzbnWg+lS7S1oSf95CWe26cSL7qy7bU=;
 b=flOFC+edvMtt/vfrpXxSRzKhabF1cIUMl5LcNuPAn4J1H1f7cbCacdcnm1oUgavgwIkbuxok2VKaCmyPKZusPkz/1x4jd0Jg+hqW58bQ8KX/ivCgr/6S9HOR2EmjTtDgHfdUEi3IWfiv15l9ipio0dc9Ip3vJBrqV28eQN5ThGE=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2203.apcprd06.prod.outlook.com (2603:1096:4:4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 10:36:56 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 10:36:55 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] btrfs: Simplify conditional in assert
Date:   Fri, 15 Oct 2021 06:36:39 -0400
Message-Id: <20211015103639.21838-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR02CA0190.apcprd02.prod.outlook.com (2603:1096:201:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 10:36:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291e9d12-cbb3-44be-4bba-08d98fc7b546
X-MS-TrafficTypeDiagnostic: SG2PR06MB2203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB2203C948704509CED80139DAABB99@SG2PR06MB2203.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWIqUC9y24ugh9QLp02c0j2BsJHUf6xSyPhwwbG2apDNgL2nGg9Mi0l/DgWc49vAo4+fIg1lz5sinAEp7+lpTUQd1V/6bnSZxAgeLbRGTopozWalAyemex/qEJOogl0r0E/5crg5qxdaeYk9ixFB9onuekmCzg29C1TW+5CcHe0hX2NBhZDBWiejrcv/6DR/lOoAxqU120HUDhy8HgP0J6vBdL13jOFBzy/+iTugcEGfW8G+R44qDcX2VeZnLuMlRKaHsbORS1sL09+lYZLXNemam/nSlbtehIGI8s4C3dqeZzmO7+CJ/3QOS82oxgDTObAlmaNeEJklD3pYQRR1sMXNxAxBhf7jrDIFpEZ+VLxAV1z3L/56J16D9kMs3GtzFLILrhsivG3s47R2vugKFgd91bH8JAIyzK6wYQzmAk45NhYLO4R1TksWqqciNrQR9HKt3IDG+4PTXCBGMVpu+tA4oG9NB1R4oIZn1j+s2CNr0Pe/MPUhWn9sl4oj24379oBW83peWvz+T0OsejAb4mOo8+WNUo568FsBy/5+weSUEsaGEd0qGiphYkJh+5XeyzzTh2fLNcWUgo5kcnu6ycFohFf3A997Ye7dnrGIcv4yDZMxVHur68Zl2oQvnacS4XZIVIGXYWl3ZmCBZBcqIoSsh9v+wDmOQtTuuSxyE25rb9N/D30gdVodFLDIN1CYZKwSTugUh7eajrukjGTnKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(36756003)(38350700002)(6512007)(66946007)(66556008)(66476007)(52116002)(186003)(1076003)(26005)(5660300002)(86362001)(2906002)(6486002)(38100700002)(6666004)(8676002)(4744005)(508600001)(956004)(316002)(83380400001)(6506007)(110136005)(107886003)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0rl/mUXsySE0Zc5y6VOPyPMMJqa8bWWlmZNfeyK4qHnFQwSoeKuvLK4pyx+j?=
 =?us-ascii?Q?FjmETXgepImdMrEWqiTH+XUiMA8PXBPB0T/iUF+g9DCYFT1/44CwRNlaLCI0?=
 =?us-ascii?Q?1r9TfdDX6Z6Vp5/b0anty5FxgJ5j/bJg6mZG3CFvSlsAlw8ADjelV9s3Xc6k?=
 =?us-ascii?Q?IV7moWJqeZB7aJDxLablttjjnuzyyeQz72Th51U0H9R+nrbfJxKMQJv3+bin?=
 =?us-ascii?Q?9rI+OPAyrRFMf5Ru7OamR4Y9c5fZ0sWvT9lv/poyfLkznm1F7mv9TqEFf+5v?=
 =?us-ascii?Q?yRHuoAYKJLhSV6MLyvfA3ETXp1ZrPI5fJtgjJQj2YR/AFqpI3Qm/UsI/LeYD?=
 =?us-ascii?Q?5Z6vmGggO4q7PRjRIm/g3VZV6yQuk+I2Dn5pRnbOcMmCqR/GbJhDhH8BJHUD?=
 =?us-ascii?Q?otRmrhWS23sw4U48f5si9LDtrCkcJIGySpTpmEa5xXDrKIFLRKONSocHbI7R?=
 =?us-ascii?Q?IeQ8uz/vbNHAOZ09tyT2PeO8jrd0uicXNAJZGxn+1KixlErxHBABu2e+GUw5?=
 =?us-ascii?Q?JXCjD6wkfBNK630c/oi6AQPlwmfklUmj/g72yo2Vmxu2aUaUWGZaZhDH8LKU?=
 =?us-ascii?Q?n0q7RFvDUCWS5FSDbaTG3IPFc12Pgp+W77B/H+Fdc9xNSp5r9ELisTifD7Dv?=
 =?us-ascii?Q?TjwiXhZc2m6UeaVBStVnK3G1ONAVeqbAHnk5RqitZxVgD8KGlvR3OpctMTmY?=
 =?us-ascii?Q?njhbexpEX1ZFPScjcyGu1ECQEq0zjElqzg/fptTizAM3K0br0k8+rKiWbzWA?=
 =?us-ascii?Q?S2Y6MHqQGjpr9TO5BDoToASwXQj7DZwuZu76vuoWj4OV6bfaiTiKCJ2kfJYb?=
 =?us-ascii?Q?wevJxnTN+ubcfhWuy8idRB4/KuVbVX6mdqrS6xMGcMWbJVmLVfz1AFhQx9lf?=
 =?us-ascii?Q?fJNvEArJHMBnr0BdZqeg38KNbOUIJ2NM060E/DGDErCpKeqqriRp0jqeh/Ew?=
 =?us-ascii?Q?k3TNVN8we1IkiDz9MRTfptB91rDj2bGp+9NQ6Eeu8qGU97+lJNtseQ7vYmzh?=
 =?us-ascii?Q?g+0w8CzWsxgmu96FQn07le6q42+ft3Eg8DMYz8qdFtHzf7B+VfXahwWz4W4I?=
 =?us-ascii?Q?+yn5p8x38hj2K2YqPUS3EA7SCvqkQV7M5gc3sOgVWtXNdVmnWO/1rrsyczIY?=
 =?us-ascii?Q?ZaFxT5phHdwnSx1XBAovGth1sE17XeDq8ByzTJY8XDnhOsQmRJU3Du5z2WHq?=
 =?us-ascii?Q?gBxwnfPxDkOuj7Ye7wxKAr9LL6zEU/JsEuEv2mFMawqUnxTzunrhNcCChT/u?=
 =?us-ascii?Q?Gd54fpuUBiCxbBfjB61OSYZIaQbAbekUV/ChfytwfSdVwQ0hvBJLrazgHBuU?=
 =?us-ascii?Q?CyTKk70S0RhDwsli8GizxnKK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291e9d12-cbb3-44be-4bba-08d98fc7b546
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 10:36:55.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/g1U6gFIAgFMto0/bpwJIz6EE4jj9fh+/t20SJNdFCCoVom7Loa3bHcrU9gPlxXG7fWgDrovKguCjkOFNcS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2203
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix following coccicheck warning:
./fs/btrfs/inode.c:2015:16-18: WARNING !A || A && B is equivalent to !A || B

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e9154b436c47..da4aeef73b0d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2011,8 +2011,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		 * to use run_delalloc_nocow() here, like for  regular
 		 * preallocated inodes.
 		 */
-		ASSERT(!zoned ||
-		       (zoned && btrfs_is_data_reloc_root(inode->root)));
+		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
 	} else if (!inode_can_compress(inode) ||
-- 
2.20.1

