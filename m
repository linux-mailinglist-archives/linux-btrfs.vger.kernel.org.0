Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAB7BE43A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbjJIPOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377005AbjJIPNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:13:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55317C6;
        Mon,  9 Oct 2023 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864415; x=1728400415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZMyF6TDtCKn2j7MBSZqcT5w2Tsjobk9HIX7JwHcMVA=;
  b=PCmpo63rTrk5KVCZeDp4qVwaMdHtGifBQQJCc/vfUQvvgMvXhVqIqxA7
   NTeUsbtXSkHte6rTfyqsDUknHWeS9m+SnucFW5EZkOStAzp/WaUUoW5To
   7Bv/jU0ImFqeReEG/Bj2U1HYlXZefc19Q7DP3//KeKovbfTxoG/+884Sc
   SV3AuktK93d88OkX/UgH899v8qLoVtzhX6kJVG0+V/ZHLTO6XQrz5Zyj6
   XO+v1Unze8JexpuB7fEMqe7oXL6p3lxSMkAB+jGSu1tgUIlUzvoGA7SIE
   F5ehPHpu8J5ZGaSp/3zpcmluOil12VoCXNwpaJJYAqgDSqwJAg7+H7YOJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232223"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232223"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869288032"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869288032"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:25 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
Date:   Mon,  9 Oct 2023 17:10:19 +0200
Message-ID: <20231009151026.66145-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009151026.66145-1-aleksander.lobakin@intel.com>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bitmap_set_bits() does not start with the FS' prefix and may collide
with a new generic helper one day. It operates with the FS-specific
types, so there's no change those two could do the same thing.
Just add the prefix to exclude such possible conflict.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 27fad70451aa..94249b5ee447 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1909,9 +1909,9 @@ static inline void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count, end;
 	int extent_delta = 1;
@@ -2247,7 +2247,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	return bytes_to_set;
 
-- 
2.41.0

