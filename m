Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457704345DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJTH0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 03:26:09 -0400
Received: from mail-eopbgr1300124.outbound.protection.outlook.com ([40.107.130.124]:17856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230061AbhJTH0I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 03:26:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPAZZkCxv7JRugQZ8kHdZko8vdQ9x5+YWh0JbPZQ8mh943dRUaJT5UXrIMYPlC1HDradvHsJygMc+grzFJwUfRzqXxVjGVorhp+ZcwNBrmDcVoS+N/YMGByazSr/4K75f0li0TVOvNGMrcmtN1BRubEXFiDXUQ12aZdib2TZHIBsUFwagVyJsNwIE7lFcJXMX149n5DfWPPTQquK6fXQwfo1eWbR4OUzTkiv1TsLzWU1RulFnRKA5lcMsygSzp2XbTW6Aze0iP98PDU/dKUhBi2ThKhCh1KUyEJsHBsd6Nyr8wkJAWz4pjgsYw47YF2RtfkzjmkNtVYQWr1Yoa9Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4xan3PItXj5j22TJ6rbNfBxfqENKBYRh7FyHGlfOjk=;
 b=KGFlakcpWL6N61Pvd/5WB916/fDQvmAA7FHXApLYY5ro9lwo2awa+lyBR3FdXS9xTLC8dJtedo8dXbhU25+LzexePaTM3EENpoBw+lxH7z976s/rG3pzyYLlpgvtPrDss2pKCNMNRcJUt+WlHHd5GyiUjme/HI0oUqimfca1or/NJMBaUVjLu6RZ4gTM50IqUg3u0gATBG3ybIDwl+ZFDBB5+Mf7IQAYbU48iW9YGChA5nE7PXiZnWEzRe1L4h2agDuEsbovnfUpa45MGVAPUTm19Y62zT7KKbhox8Ve9f6YipsXuPEE/zSiEUC0r4KrV0NG3V3paKTuX1uYU1d5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4xan3PItXj5j22TJ6rbNfBxfqENKBYRh7FyHGlfOjk=;
 b=eJfKfQ9xGoePGgxhFmCmo390B3SCubZT/yQf/gmtCn/WZCsGnd4beLWPe90Df0hfXKcL1pDA+nojRJjGJAlcHIPV+PP76osfDDyBxLYrBWGZvG39s1Vt5G7LPYC8jrDifwMtbhJu33Ssu2zAovxmbrDmPT/XTw/ElK78TbLXsCg=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3114.apcprd06.prod.outlook.com (2603:1096:100:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 07:23:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:23:52 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] btrfs: simplify redundant logic judgment
Date:   Wed, 20 Oct 2021 00:23:41 -0700
Message-Id: <1634714621-58190-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.9 via Frontend Transport; Wed, 20 Oct 2021 07:23:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e89bea51-a947-40d5-2136-08d9939a9108
X-MS-TrafficTypeDiagnostic: SL2PR06MB3114:
X-Microsoft-Antispam-PRVS: <SL2PR06MB311409F01128A375E95B6E75BDBE9@SL2PR06MB3114.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d33TSrXoteSGE20p9LPznCN1N/Vb0jmeD8l3SuX8eHkUkwvJbC33Xxj/du9SdVNbsnx5LYFktjmjqMMMeOano8bJlDp4RquUPfu1KonhGnSGNuyScKSbWV2VJkA8Qf2fz7QEy5XkiuAHw0t1eMZ2LbZy7zm1KJtGo4poZRFfBD4M13P0aLY6G8GXsIr5wWq9HuJYIQMLdycTUMRZ5NDEnt4Pmk0u2s9LUlwc4zmQX6XTd503jcf4+R+2+iCDbf1B/gITjMCDh5fILv7isyA3Y9Fjwb/4fTP+CyKKYfI2BevG1BafeT3TaDAXPtQR0mI9FZwrC58WNPY/kz7R/Mo2efkqfs3Wk7dIWG7jPG7VG5zij71GrvCgK4Wfb70I0a6dBl0MSh4YfWqmDW3qxJrucqOkIapS/vR49JOBveI7JSDynotp9m5rE3QBzDqosrGrm8fYgHVSYVxIkdoGgbWTV6s3bBEl5CvC26cUabsUOdQTtrGzyTOcr6xCkpmF9HkoDooXLmqh/s3HaiS2TZrvu1CwvhFnp2NXd+Do78q9NqgJU522HEOVJVFWXaQP/ltZGazSZvA0TAgu+Ttk6Sf2adH77eUCbGnvZ+BzMvUMbbNDqOY20YTrKft+FK1gViUmW2u1KYmAXjrGuD5cFX2svUdT0vh7yZBfX6c3I2lI51sbo4viLJsXuj+3uJt4LORZXh+qi0Be+O9wACN0iIaPTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4744005)(110136005)(26005)(316002)(66476007)(52116002)(5660300002)(6506007)(66556008)(83380400001)(6666004)(38350700002)(6486002)(38100700002)(86362001)(6512007)(956004)(66946007)(36756003)(4326008)(8676002)(8936002)(2616005)(107886003)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h4JaGBNT2gdb9xghWCNf5ZZdhqB5oeUzx3gmae5rL0y4t6lSltbkS7eypLFD?=
 =?us-ascii?Q?D4igt4iWe48CCXv4pSbZNNT9c60NBrJoTHtdWOdAuNxIPocCVlti+lqmUPei?=
 =?us-ascii?Q?B2EOCZ27TLEAYB0SUWyEp3bL+t6kitvHQb55PkLZeQXBidrUdX57+oju0uAF?=
 =?us-ascii?Q?kwnrkcLCdh8v5XsQDwYgh+4rQt/GCOT2lK6WQ9nyaaK9BVzzGDPmtniJGO1+?=
 =?us-ascii?Q?lmKyzEMtj9YBYDmMLGsy1NrPBVl9cASQ7b/YEN/3Asdmaz+k+jy3Q88NJ6fK?=
 =?us-ascii?Q?W7xzOQm4ALWhMtnlILdxXKp3QGxqCbZmKY9iDZULq639KSCzsxUyWYCkFflz?=
 =?us-ascii?Q?nuXWk5gjiomFE5rpXFCyVbNtAwHcvjZpLdjvVfipPGEMgk1bN4YijVMYtF9A?=
 =?us-ascii?Q?isrQW6IriFZQlU/TEFV7d+TgIOOu9ZMWpPED8ovglwwWUkMj0CvJFUbr8kZG?=
 =?us-ascii?Q?YUO+YyC1EYcK4Bk4TAQ7MRTEiEi/aIy1vb+Q3HrKIBWWEPnLthQFtkDet4Ec?=
 =?us-ascii?Q?1MYu0u7a5kSerCg6iTeMGsgxnR5mKqrOmWQ/KpFxfhnwON6TBERizhWdmTls?=
 =?us-ascii?Q?PFIgxHHG27aqymDsI7RF8wFIoOojnG+K43qZvBCmMCHqQtcKFJEW9N5nkfqx?=
 =?us-ascii?Q?5EwL5LJi/ngRDN6vyMOR9sGg49fJHjS9SBLtQLfg9jjwxE6RO0pB3pDI4U0l?=
 =?us-ascii?Q?oeOhsB2Hvg9jLnf1FOrBjhZscVeMo7pCv9dYeQn9h9LfZ8K1liINCbq6BaHv?=
 =?us-ascii?Q?OwO2eMVuaP1e913j/fCGZhqs9cTqWvPeqpubfZMQ8Nyy5OxN4NytiI5EQ1iw?=
 =?us-ascii?Q?AM+dAXhUh/tCIyPcC+VkGr/5YUYIoQfPG1+QpevIPND8lSvudBDwpGcLKTHG?=
 =?us-ascii?Q?ALlYi5t0pDjMznLyB99Qg3lJYIHVuhe0kLgp9qqmN+RMSu0J64GMSj/BXaBN?=
 =?us-ascii?Q?/2w0wDA+G2I7iHpDtRTg9ELUXDIsZb78yAhNqMFG39M5ZWgag/Ia7emtofdR?=
 =?us-ascii?Q?L0SQtoPwXRy/TCPMc0O64ZQN5FQKB0Jffj86Mo8v+tAWMFu9L6BSd7BGq//A?=
 =?us-ascii?Q?BCXEusz8xmHSKCpKSs1/VK28Huk46HrEned0CeVv21Nwz7EO+9PADPxs1gzo?=
 =?us-ascii?Q?AHAUSgdLsYLqc6JE+mNVWdpYj0biFq7cxnTtrd+5t36jVh/v5xi1BaZ+svsb?=
 =?us-ascii?Q?tXViffS3MJCbkdPMBch95s9P8qAAqoV37k0fQvzCD2bcXmJBNWI3aT/SmN1T?=
 =?us-ascii?Q?L6aBKjG7joys1xUdTzPG4qfG2EgPGPZIfWiIOSIqGosHHYXtaueqOc88cIiC?=
 =?us-ascii?Q?ZUnJf/WBP8j+WAxRcbbCRGI1giQ3/fNvsw1/0CovFx6U7joLfLbr7zAcU+TM?=
 =?us-ascii?Q?cwJ46sCVZshi0pTsbo0LwVjswWbbPbdvtNRgXkVRNqZMMQqXN4qVfQLSbtGO?=
 =?us-ascii?Q?x4qqPckHqrQuA1nUt96XjfI1hbzs7Dep6v14gy8Fkfb5HzrBVQSW/BI1/xog?=
 =?us-ascii?Q?dnxouZZZg1rTmW1CSzdQIXAjyGrQPrYcTYgBYOWlOtFPetXJsI+sv4AQBF3J?=
 =?us-ascii?Q?EyhhCQ0Whs7FY02SG3/4xwxXhufC3arxt7Y7ss0eBHcWEIGBVnWdwc6ewApg?=
 =?us-ascii?Q?NnBHnqJKWEShpla4ceKyB0E=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89bea51-a947-40d5-2136-08d9939a9108
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:23:51.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0TpprEO6n0E78Hz+sO1yXGD5l+l/+4WPYA/YsAwuYKhKEyWPX6nogaCPphgNZSlgU3aYK6ye8+Owy7iQFQsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3114
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

A || (!A && B) is equal to A || B

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07ba22dd..e0d2660
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
2.7.4

