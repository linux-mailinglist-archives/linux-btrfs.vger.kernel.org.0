Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F63710189
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjEXXKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150CA4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F40D121D39;
        Wed, 24 May 2023 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAhSEwdzyvjiXHibpr9XwzsKjTrh+UBDcwqQAE6qo54=;
        b=S63REQWWGGgvYcW75Th8xZUbd+W4skGBWoHEPze6Y3t653btZOsKjkEPDyAqlIRWDzsv9k
        awKWBtDBLbb2YqCe4g+IotC3kLFeYBzU107lWbaXRuK/sy9xBdNPJzk//WN0NhwKCA7t/c
        km8IUlR3uIPPUq0sjOwdHT1Zas+IPPI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E46222C141;
        Wed, 24 May 2023 23:10:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C861DA85B; Thu, 25 May 2023 01:04:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/9] btrfs: open code set_extent_bits_nowait
Date:   Thu, 25 May 2023 01:04:30 +0200
Message-Id: <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper only passes GFP_NOWAIT as gfp flags and is used two times.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h | 6 ------
 fs/btrfs/extent_map.c     | 5 +++--
 fs/btrfs/zoned.c          | 4 ++--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 0fc54546a63d..ef9d54cdee5c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -156,12 +156,6 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state, gfp_t mask);
 
-static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
-					 u64 end, u32 bits)
-{
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT);
-}
-
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
 {
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 138afa955370..918ce12ea412 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -364,8 +364,9 @@ static void extent_map_device_set_bits(struct extent_map *em, unsigned bits)
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		set_extent_bits_nowait(&device->alloc_state, stripe->physical,
-				 stripe->physical + stripe_size - 1, bits);
+		set_extent_bit(&device->alloc_state, stripe->physical,
+			       stripe->physical + stripe_size - 1, bits, NULL,
+			       GFP_NOWAIT);
 	}
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bda301a55cbe..b82a350c4c59 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1611,8 +1611,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	memzero_extent_buffer(eb, 0, eb->len);
 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
-	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
-			       eb->start + eb->len - 1, EXTENT_DIRTY);
+	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
+			EXTENT_DIRTY, NULL, GFP_NOWAIT);
 }
 
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
-- 
2.40.0

