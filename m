Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68E156C539
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiGHXTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGHXTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527AD41980;
        Fri,  8 Jul 2022 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322353; x=1688858353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKCSa9IFVquArH+CHsNurvH2tukAQ0tT7Aga37iEAAM=;
  b=QIXCqMKhUKDebS+V7xkoLFJ8vRtPbsp8nwQYsPB4Bp0YGT1gjUjzFoJo
   kfe0xDUuuUcRL1kh8o5ZMkVfuZHRPAsEQIUBV18tkwfSj9Hfa8InTJid5
   H9JWPd1ZM3BmjCja1soXEu+Q2w3vjuAXflPmfI04MlVX5p5n/bBo98MXA
   dOyi5TE1DtPlu+QyYlImSNsryM6WaBy5YvqfkgjYI0dUf4d2zRpJbDQn2
   TwIigeBpu1mcNgLOkCYL+BP3ibKrlwrW7+og3X5VqxC++0lHvr+RzAvRh
   5NutoIvNAFHWvAH4LXOMvT/f65Wdv72K+vzf+ROKYbBHv2c4kNdPA1RMz
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871827"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:11 +0800
IronPort-SDR: JWtpO3xtMFQdJ1ojDyQF5pi6P0i83UoF1RrQgFtfHVAWJd6EGulk4AIlzKSbuFI0aAGeZ0mqkz
 yQ25yuZ3Ktsd/C14XLZaK45ppMlMC2XusSSP2cucP56TQ6xuezrX/gVVHDTG4FzFSc0h7yBCmf
 SgZrfJJ+6/4KTuATITx+yPz5CmH4s0NQwPwpIi0fMkFcX/ly7/Xt9RDxl82DY3x7AgbAvPCU73
 4ea9YBn5VYcFR92oZrZmgW2ONP2tovEZGfDpc/xnGRaPpbYFw13cNqefW1Lx0fwm5FiUf4EVcA
 T/UeumRYPnEB9GJ2kS7JfEFB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:16 -0700
IronPort-SDR: EoxQdNvQNkc9R58eGoL1wXQdF8ZcYha5IuGHjEqoRUHO1eT0YWODQ5rTIUOOgUKo7qFFwHEA9Y
 42WlU1gNMlHt1LdTZyDcYFp9qsGVRpgz+RsDoRYUaI/WzgkCq/1ktfvRhf5xqhq/MnEtehivel
 PINGuBLFP3+felVNNSErnVQXOJrRjFq8RzvPLeNdv6BqIWAWe/R6TnM1rZV6CatOOIxImHjYO+
 nNgGKTyYAg8P9kO1M+a5ULlO3m4IGPrTZZ85r7ur75JK9IVhgOe5GQfkCYNrNamYIDiORKliV6
 LaE=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/13] btrfs: let can_allocate_chunk return int
Date:   Sat,  9 Jul 2022 08:18:43 +0900
Message-Id: <109038d56dfcb9c2f0dc9d37f71acf135bd9ca1b.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the later patch, convert the return type from bool to int. There is no
functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f97a0f28f464..c8f26ab7fe24 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3965,12 +3965,12 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
-static bool can_allocate_chunk(struct btrfs_fs_info *fs_info,
-			       struct find_free_extent_ctl *ffe_ctl)
+static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
+			      struct find_free_extent_ctl *ffe_ctl)
 {
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
-		return true;
+		return 0;
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		/*
 		 * If we have enough free space left in an already
@@ -3980,8 +3980,8 @@ static bool can_allocate_chunk(struct btrfs_fs_info *fs_info,
 		 */
 		if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size &&
 		    !btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
-			return false;
-		return true;
+			return -ENOSPC;
+		return 0;
 	default:
 		BUG();
 	}
@@ -4063,8 +4063,9 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			int exist = 0;
 
 			/*Check if allocation policy allows to create a new chunk */
-			if (!can_allocate_chunk(fs_info, ffe_ctl))
-				return -ENOSPC;
+			ret = can_allocate_chunk(fs_info, ffe_ctl);
+			if (ret)
+				return ret;
 
 			trans = current->journal_info;
 			if (trans)
-- 
2.35.1

