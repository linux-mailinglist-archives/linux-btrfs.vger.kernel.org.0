Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026967CB0C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 18:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjJPQ6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjJPQ5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 12:57:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5174C35;
        Mon, 16 Oct 2023 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475293; x=1729011293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21Fx+hFixGLkxGOcejHgCCiwDa7TN8Oe8e/pIoRbM/M=;
  b=L2WJMov31p6wki9oM00RXiukVH7y+EMJ3OgeyU7yXHz9GUvCbgljehWB
   ynVa78m7kwIXetfZYbRiDDEKVAfQXSst5evbr6CEolLqEfWJWWGp0osCb
   nOrvw8OX7CAPibLDxtjS2oZjscMvADQnNAtWRyWNg66b6Ei1IErqvC6oc
   NBNelKyrj4mm6NuOsgDNOxh5n5uqFwMCOb3pXfCrndCp7EFfPMxQ83PUH
   2lZJO4/fRyx9/c1+lGiNkLy+5H/CbmtxrxYo4uzRKtoaco46AuFV7lfm/
   HIaA98clTgtQr3gFtsaQZe7zCO7vbzS69PbJ8ctQniB8LK8mubrOHOKyg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="364937215"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="364937215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826084263"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="826084263"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 09:54:45 -0700
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
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 07/13] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
Date:   Mon, 16 Oct 2023 18:52:41 +0200
Message-ID: <20231016165247.14212-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016165247.14212-1-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
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
Acked-by: David Sterba <dsterba@suse.com>
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

