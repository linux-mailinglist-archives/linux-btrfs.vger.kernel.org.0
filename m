Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9A71018F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjEXXKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462B99
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80E381FE3B;
        Wed, 24 May 2023 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PR/w/kW1cfLfAGsKJJOlYbs3BL6xzgX6mmcfyn5qjnY=;
        b=vJZLTZ1OufPiNxBvEh/vBsCmAVSGdoEWfyivIYuG/2n+VqxAkXou1Ip2AkBe/uul4NrgLx
        mHAFHiq2TBTZ9Flf4JKiQvU05hVhwPDe9VjjSuJYULedgXbntRa6ycE2786DDuDIW0gWPp
        HKRreS9zWSaW1ukA2V/uDTHvg3tWriU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 71B682C141;
        Wed, 24 May 2023 23:10:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C1CCDA85B; Thu, 25 May 2023 01:04:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/9] btrfs: pass NOWAIT for set/clear extent bits as another bit
Date:   Thu, 25 May 2023 01:04:37 +0200
Message-Id: <5a874cbeb134199da0c42f6e3dd2cee91f20252d.1684967924.git.dsterba@suse.com>
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

The only flags we now pass to set_extent_bit/__clear_extent_bit are
GFP_NOFS and GFP_NOWAIT (a few functions handling mappings). This
requires an extra parameter to be passed everywhere but is almost always
the same.

Encode the GFP_NOWAIT as an artificial extent bit and extract the
real bits and gfp mask in the lowest level helpers. Now the passed
gfp mask is not actually used and can be removed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 12 ++++++++++++
 fs/btrfs/extent-io-tree.h |  9 +++++++++
 fs/btrfs/extent_map.c     |  7 ++++---
 fs/btrfs/zoned.c          |  2 +-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 29a225836e28..83e40c02f62e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -532,6 +532,16 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	return next;
 }
 
+/*
+ * Detect if extent bits request NOWAIT semantics and set the gfp mask accordingly,
+ * unset the EXTENT_NOWAIT bit.
+ */
+static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
+{
+	*mask = (*bits & EXTENT_NOWAIT ? GFP_NOWAIT : GFP_NOFS);
+	*bits &= EXTENT_NOWAIT - 1;
+}
+
 /*
  * Clear some bits on a range in the tree.  This may require splitting or
  * inserting elements in the tree, so the gfp mask is used to indicate which
@@ -557,6 +567,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	int wake;
 	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
 
+	set_gfp_mask_from_bits(&bits, &mask);
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
 
@@ -979,6 +990,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 last_end;
 	u32 exclusive_bits = (bits & EXTENT_LOCKED);
 
+	set_gfp_mask_from_bits(&bits, &mask);
 	btrfs_debug_check_extent_io_range(tree, start, end);
 	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 5a53a4558366..d7f5afeb5ce7 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -43,6 +43,15 @@ enum {
 	 * want the extent states to go away.
 	 */
 	ENUM_BIT(EXTENT_CLEAR_ALL_BITS),
+
+	/*
+	 * This must be last.
+	 *
+	 * Bit not representing a state but a request for NOWAIT semantics,
+	 * e.g. when allocating memory, and must be masked out from the other
+	 * bits.
+	 */
+	ENUM_BIT(EXTENT_NOWAIT)
 };
 
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 918ce12ea412..4c8c87524d62 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -365,8 +365,8 @@ static void extent_map_device_set_bits(struct extent_map *em, unsigned bits)
 		struct btrfs_device *device = stripe->dev;
 
 		set_extent_bit(&device->alloc_state, stripe->physical,
-			       stripe->physical + stripe_size - 1, bits, NULL,
-			       GFP_NOWAIT);
+			       stripe->physical + stripe_size - 1,
+			       bits | EXTENT_NOWAIT, NULL, GFP_NOWAIT);
 	}
 }
 
@@ -381,7 +381,8 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 		struct btrfs_device *device = stripe->dev;
 
 		__clear_extent_bit(&device->alloc_state, stripe->physical,
-				   stripe->physical + stripe_size - 1, bits,
+				   stripe->physical + stripe_size - 1,
+				   bits | EXTENT_NOWAIT,
 				   NULL, GFP_NOWAIT, NULL);
 	}
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b82a350c4c59..fb90e2b20614 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1612,7 +1612,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
-			EXTENT_DIRTY, NULL, GFP_NOWAIT);
+			EXTENT_DIRTY | EXTENT_NOWAIT, NULL, GFP_NOWAIT);
 }
 
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
-- 
2.40.0

