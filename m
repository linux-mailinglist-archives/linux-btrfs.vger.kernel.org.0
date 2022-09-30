Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7245F1403
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiI3Up5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiI3Upk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:40 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F3564D8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u9so2539954qvo.11
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=xI+4a7m7relROw1U0bOdNx1KOLfTciJJCTfo1Xdyrpg=;
        b=nUGye/v+Qh+Q58vctkyOmukl+kIawgxTNRapSpqpbZgxcx8EKMIXeMSRdNnEsJJzo2
         bOrbd9nKj7UO+q3xxsmghajhCY4MAVJp1e9W6TG1Upy9FkbdVbcHFZyQ9qxz779RklAH
         p3gOALwJF0lbSd2xYEOF8p7ZN0ZYy+JlUBVx9kwi0YWlJ94NbMGw3JeMy/IIC1U8rmds
         GqdPpzwmv6tYNL5K7qx6vOuDi2spN+ogK9zzAAvu1wDRCvDm2bg9GjiQFo4JXDzVE/mb
         2NmI5hachM00fsGVH+wEDoIaXxxXGy7y7+KOb4ZdFdK5jTQkqIul/cYgK5a2MGvcNvyh
         pUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xI+4a7m7relROw1U0bOdNx1KOLfTciJJCTfo1Xdyrpg=;
        b=JbG+CkrWpk2PRD1KDeVHNpoC7p/C74zBnnVrK1Zx60ccwIkfuRqthC4Yq95tNbfCH8
         ioFCCd74VejWyXwmKvyMncnm+NNvAxHTpa7dW3nR7xQzxu/ZsnS8upolGE1aP6Osgaoj
         X6B/ZVXkwokQESjAxdsuLkDUn31RfIz8QYDYWeifjBciRhWRXj0H1j2zNykaXG/qQSIt
         RdGWf3y+71vVdZZxeHwpngX9xYdkGNK6d/ZdtK0ERvgroLxbbSFPJmTPFkZz/VdS8Bg3
         NDUtaDX9zum/Pey0pZN52HdnpKdovbQAJZmvQplZhFjVFOD6bdHFWjT7mqXSSxYornOR
         r5RA==
X-Gm-Message-State: ACrzQf2WEHFK9dPzWoDzycRYr/ScNREvXaBhjm9GVI0eNmpsR2r9iFMD
        EeJOTZKEBjC0PzIGHav2SfLCZMOjmz2MNw==
X-Google-Smtp-Source: AMsMyM7mX/PF3I/C2waoo81/QvJicpSjfcDzGtV/IE7/7OYfNsklZZqgIbFaJR7gfuS9XAKtH7/Gqg==
X-Received: by 2002:a0c:f4cc:0:b0:4aa:a471:978f with SMTP id o12-20020a0cf4cc000000b004aaa471978fmr8416237qvm.80.1664570730627;
        Fri, 30 Sep 2022 13:45:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i1-20020ac813c1000000b0035c1e18762csm2554101qtj.84.2022.09.30.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/6] btrfs: use a cached_state everywhere in relocation
Date:   Fri, 30 Sep 2022 16:45:11 -0400
Message-Id: <16c4c8603a37a90e054f2bb659c10124405828a2.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of the relocation code avoids using the cached state, despite
everywhere using the normal

lock_extent()
// do something
unlock_extent()

pattern.  Fix this by plumbing a cached state throughout all of these
functions in order to allow for less tree searches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e81a21082e58..9dcf9b39c798 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1113,6 +1113,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				inode = find_next_inode(root, key.objectid);
 			}
 			if (inode && btrfs_ino(BTRFS_I(inode)) == key.objectid) {
+				struct extent_state *cached_state = NULL;
+
 				end = key.offset +
 				      btrfs_file_extent_num_bytes(leaf, fi);
 				WARN_ON(!IS_ALIGNED(key.offset,
@@ -1120,14 +1122,15 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
 				end--;
 				ret = try_lock_extent(&BTRFS_I(inode)->io_tree,
-						      key.offset, end, NULL);
+						      key.offset, end,
+						      &cached_state);
 				if (!ret)
 					continue;
 
 				btrfs_drop_extent_map_range(BTRFS_I(inode),
 							    key.offset, end, true);
 				unlock_extent(&BTRFS_I(inode)->io_tree,
-					      key.offset, end, NULL);
+					      key.offset, end, &cached_state);
 			}
 		}
 
@@ -1516,6 +1519,8 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 
 	objectid = min_key->objectid;
 	while (1) {
+		struct extent_state *cached_state = NULL;
+
 		cond_resched();
 		iput(inode);
 
@@ -1566,9 +1571,9 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 		}
 
 		/* the lock_extent waits for read_folio to complete */
-		lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+		lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, true);
-		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	}
 	return 0;
 }
@@ -2863,19 +2868,21 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 
 	btrfs_inode_lock(&inode->vfs_inode, 0);
 	for (nr = 0; nr < cluster->nr; nr++) {
+		struct extent_state *cached_state = NULL;
+
 		start = cluster->boundary[nr] - offset;
 		if (nr + 1 < cluster->nr)
 			end = cluster->boundary[nr + 1] - 1 - offset;
 		else
 			end = cluster->end - offset;
 
-		lock_extent(&inode->io_tree, start, end, NULL);
+		lock_extent(&inode->io_tree, start, end, &cached_state);
 		num_bytes = end + 1 - start;
 		ret = btrfs_prealloc_file_range(&inode->vfs_inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
-		unlock_extent(&inode->io_tree, start, end, NULL);
+		unlock_extent(&inode->io_tree, start, end, &cached_state);
 		if (ret)
 			break;
 	}
@@ -2891,6 +2898,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 				u64 start, u64 end, u64 block_start)
 {
 	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
 	int ret = 0;
 
 	em = alloc_extent_map();
@@ -2903,9 +2911,9 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	em->block_start = block_start;
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 
-	lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	free_extent_map(em);
 
 	return ret;
@@ -2983,6 +2991,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	 */
 	cur = max(page_start, cluster->boundary[*cluster_nr] - offset);
 	while (cur <= page_end) {
+		struct extent_state *cached_state = NULL;
 		u64 extent_start = cluster->boundary[*cluster_nr] - offset;
 		u64 extent_end = get_cluster_boundary_end(cluster,
 						*cluster_nr) - offset;
@@ -2998,13 +3007,15 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			goto release_page;
 
 		/* Mark the range delalloc and dirty for later writeback */
-		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end, NULL);
+		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
+			    &cached_state);
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
-						clamped_end, 0, NULL);
+						clamped_end, 0, &cached_state);
 		if (ret) {
-			clear_extent_bits(&BTRFS_I(inode)->io_tree,
-					clamped_start, clamped_end,
-					EXTENT_LOCKED | EXTENT_BOUNDARY);
+			clear_extent_bit(&BTRFS_I(inode)->io_tree,
+					 clamped_start, clamped_end,
+					 EXTENT_LOCKED | EXTENT_BOUNDARY,
+					 &cached_state);
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							clamped_len, true);
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
@@ -3031,7 +3042,8 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 					boundary_start, boundary_end,
 					EXTENT_BOUNDARY);
 		}
-		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end, NULL);
+		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
+			      &cached_state);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
 		cur += clamped_len;
 
-- 
2.26.3

