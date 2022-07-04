Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDD564CE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiGDE64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiGDE6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25304267E
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910730; x=1688446730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbfB8v/DgIT2PWfK91wcaqwjDog/GV8t3neYpFK4HUY=;
  b=TWMvBppbXFCzjjAv3LFHt8CcgbpYTiZwvy7wFVjW328eAftH6Qh0lBrF
   MnL8Mmdk7YLljIQmag1mqFbjgrF675r1LCmqsTVsAQDFAsXkNwhi2dGHx
   p6uJdHd9oDWekNC2txFIZ0qQnZRsXYS0mmhyu7jjZxswOf5k5SmLXlhJq
   rgOMomlXLICICSV5Nl2Y3jBbB1KJCGu7YpRNHBNS5DWYBjV3NQYYA5B2e
   wnxT7snp88h8jeq9jS08ii6e3tw0NzkiXkAjTUHVfUNJft0XZDBwxQ0T9
   s5p5KOLlMbmdB2smm06l3/BesKMgt3vJqSeuxOKrmHNVl4U3n+ZhITbXE
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732405"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:50 +0800
IronPort-SDR: be/f2K4xn1y+fF01UqAV1xBlq3n6VDrPPs8JkeqzrcLBw21oWtBlOG9gzVbKF6l2caovTzf9SO
 5cwJAgPzG4kaFMebi8GQf1Yt7IgMnYakbFg8Wn6SbtWfGUb02kxkYZMxJkM6NmW2BYaTGmNoz6
 Vyc+vcWFBP4sFGKGCiUOlLxdXVL05fgAJ5FVAX+8EFzZdNlxe1+quBOCVIRW41xBjmCIbGluGg
 uANAXygtZtiKAKfnixfoOQ7vFuVspdIxy9A73VvPAJpVhpfvym0KXOsrcgKlv2VPbgQOv3wFVs
 F0bkTbqhIR6mVrgkxO0Iyvzw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:43 -0700
IronPort-SDR: PBQFFl0mqQ8eKPRGPUKYC3aFPnPYD2+NKjRBWE0ZcJWwhqxLyeZGp9TZ5/I7rjWMjo72RgH0L7
 dQCoxiZFBgcsCYuN9HQBX9p5VocIQ33qEWWs9QWhlmM26dPPc+341OjNGYtUr3xxoL/OrX3zvV
 z53SUMXYsBSR07AVmhgu5bvzCC+KNcQ7I0bDEGQRWyh0NH8rb6mhbWaa5r+ZGPX2lPGpkYRB4n
 XE20+jpb+GwqjGFzjV8wykZh7bsdsQ4mwobDv3OCjoCo7VJ2SVP04Cm4oKpB5ZPtFLACMO08EZ
 JZU=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/13] btrfs: let can_allocate_chunk return int
Date:   Mon,  4 Jul 2022 13:58:10 +0900
Message-Id: <11f96ae212fb278793c81eedbb7edc01864c8a33.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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

