Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFD19D7CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbgDCNkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 09:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390849AbgDCNki (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 09:40:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10447ADA3;
        Fri,  3 Apr 2020 13:40:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH 2/2] btrfs: Remove dead code exclude_super_stripes
Date:   Fri,  3 Apr 2020 16:40:35 +0300
Message-Id: <20200403134035.8875-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403134035.8875-1-nborisov@suse.com>
References: <20200403134035.8875-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adresses held in 'logical' array are always guaranteed to fall within
the boundaries of the block group. That is, 'start' can never be
smaller than cache->start. This invariant follows from the way the
address are calculated in btrfs_rmap_block:

    stripe_nr = physical - map->stripes[i].physical;
    stripe_nr = div64_u64(stripe_nr, map->stripe_len);
    bytenr = chunk_start + stripe_nr * io_stripe_size;

I.e it's always some IO stripe within the given chunk.

Exploit this invariant to simplify the body of the loop by removing the
unnecessary 'if' since its 'else' part is the one always executed.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d0dbaa470b88..7b96ded820f9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1712,25 +1712,12 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 			return ret;

 		while (nr--) {
-			u64 start, len;
-
-			if (logical[nr] > cache->start + cache->length)
-				continue;
-
-			if (logical[nr] + stripe_len <= cache->start)
-				continue;
-
-			start = logical[nr];
-			if (start < cache->start) {
-				start = cache->start;
-				len = (logical[nr] + stripe_len) - start;
-			} else {
-				len = min_t(u64, stripe_len,
-					    cache->start + cache->length - start);
-			}
+			u64 len = min_t(u64, stripe_len,
+				cache->start + cache->length - logical[nr]);

 			cache->bytes_super += len;
-			ret = btrfs_add_excluded_extent(fs_info, start, len);
+			ret = btrfs_add_excluded_extent(fs_info, logical[nr],
+							len);
 			if (ret) {
 				kfree(logical);
 				return ret;
--
2.17.1

