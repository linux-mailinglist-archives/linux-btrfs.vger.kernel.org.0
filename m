Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0343525D98
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378329AbiEMIen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378349AbiEMIek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:34:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F302A8074
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:34:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E67711F45F
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652430877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YkwnOxXpRywerf5mIbTWyphKM/dFakJX+c5bpso7D8=;
        b=PyI8KzItbxqHi0hEKPsD8mUVESnYnIJt44p5jFcjTBHwPpU0Q8iF+7FyZmsRFkSf9q/h1t
        MQSFRKbxCqcbqaNa6AEmzpzmE+SZB59NOlGpWql5gsVcwpYhpOtjGBBpmLREFWjg/Y9pE8
        2q8q2AHv1zg/o+ZZAf4Rh6i4/dggWCI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4863913446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WK0dBR0YfmI2YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: use btrfs_raid_array[] to calculate the number of parity stripes
Date:   Fri, 13 May 2022 16:34:30 +0800
Message-Id: <8ffa25e5ce1c3728217aa3c833039aca449281a8.1652428644.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652428644.git.wqu@suse.com>
References: <cover.1652428644.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes later expansion on RAID56 based profiles easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 10 ++--------
 fs/btrfs/raid56.h  | 12 ++----------
 fs/btrfs/volumes.c |  7 +++++++
 fs/btrfs/volumes.h |  1 +
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a5b623ee6fac..068576768925 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1032,7 +1032,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int stripe_nsectors = stripe_len >> fs_info->sectorsize_bits;
 	const unsigned int num_sectors = stripe_nsectors * real_stripes;
 	struct btrfs_raid_bio *rbio;
-	int nr_data = 0;
 	void *p;
 
 	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
@@ -1085,14 +1084,9 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_nsectors));
 #undef  CONSUME_ALLOC
 
-	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
-		nr_data = real_stripes - 1;
-	else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID6)
-		nr_data = real_stripes - 2;
-	else
-		BUG();
+	ASSERT(btrfs_nr_parity_stripes(bioc->map_type));
+	rbio->nr_data = real_stripes - btrfs_nr_parity_stripes(bioc->map_type);
 
-	rbio->nr_data = nr_data;
 	return rbio;
 }
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index aaad08aefd7d..83a766bcfb17 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -7,19 +7,11 @@
 #ifndef BTRFS_RAID56_H
 #define BTRFS_RAID56_H
 
-static inline int nr_parity_stripes(const struct map_lookup *map)
-{
-	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
-		return 1;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		return 2;
-	else
-		return 0;
-}
+#include "volumes.h"
 
 static inline int nr_data_stripes(const struct map_lookup *map)
 {
-	return map->num_stripes - nr_parity_stripes(map);
+	return map->num_stripes - btrfs_nr_parity_stripes(map->type);
 }
 #define RAID5_P_STRIPE ((u64)-2)
 #define RAID6_Q_STRIPE ((u64)-1)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6c55ef17000..2ce9140fb955 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6985,6 +6985,13 @@ u64 btrfs_calc_stripe_length(const struct extent_map *em)
 	return div_u64(em->len, data_stripes);
 }
 
+int btrfs_nr_parity_stripes(u64 type)
+{
+	enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(type);
+
+	return btrfs_raid_array[index].nparity;
+}
+
 #if BITS_PER_LONG == 32
 /*
  * Due to page cache limit, metadata beyond BTRFS_32BIT_MAX_FILE_SIZE
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1338bc251ff6..2bfe14d75a15 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -602,6 +602,7 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
 u64 btrfs_calc_stripe_length(const struct extent_map *em);
+int btrfs_nr_parity_stripes(u64 type);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
-- 
2.36.1

