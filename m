Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC719D7CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390930AbgDCNki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 09:40:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390789AbgDCNki (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 09:40:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD741AC92;
        Fri,  3 Apr 2020 13:40:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH 1/2] btrfs: Read stripe len directly in btrfs_rmap_block
Date:   Fri,  3 Apr 2020 16:40:34 +0300
Message-Id: <20200403134035.8875-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_map::orig_block_len contains the size of a physical stripe when
it's used to describe block groups (calculated in read_one_chunk via
calc_stripe_length or calculated in decide_stripe_size and then assigned to
extent_map::orig_block_len in create_chunk). Exploit this fact to get the
size directly rather than opencoding the calculations. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Hello David,

You had some reservations for this patch but now I've expanded the changelog to
explain why it's safe to do so.


 fs/btrfs/block-group.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 786849fcc319..d0dbaa470b88 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1628,19 +1628,12 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		return -EIO;

 	map = em->map_lookup;
-	data_stripe_length = em->len;
+	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;

-	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
-		data_stripe_length = div_u64(data_stripe_length,
-					     map->num_stripes / map->sub_stripes);
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
-		data_stripe_length = div_u64(data_stripe_length, map->num_stripes);
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		data_stripe_length = div_u64(data_stripe_length,
-					     nr_data_stripes(map));
+	/* For raid5/6 adjust to a full IO stripe length */
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		io_stripe_size = map->stripe_len * nr_data_stripes(map);
-	}

 	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
 	if (!buf) {
--
2.17.1

