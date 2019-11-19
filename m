Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DE1023DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfKSMGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:06:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:49336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbfKSMGC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:06:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FCC2B32A;
        Tue, 19 Nov 2019 12:06:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/6] btrfs: Remove dead code exclude_super_stripes
Date:   Tue, 19 Nov 2019 14:05:55 +0200
Message-Id: <20191119120555.6465-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119120555.6465-1-nborisov@suse.com>
References: <20191119120555.6465-1-nborisov@suse.com>
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
index 2ab4d9cb598a..3c7c34b6a0a8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1627,25 +1627,12 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
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

