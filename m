Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB573F4CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjF0Gry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF0GrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:47:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3010E7
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:45:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEEC1F8BA
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687848337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ehzWtpeoYfMiGiDtP8NXo7kKyUdsrDCQ3IC9XrDRH4k=;
        b=O9T2VE7aelgCMz2A+25ogqB04mQjU5j1bKjJHp7U3x9Q3usa2j6UIT7+k+2H3XPPosHYeh
        dSOf+tWzEhVb0Sdlhrdsb8kNO2lGdrAY5j+pNKrZM0WJU8iG5Q9Pv/X66Bsj81FNnORrc5
        /uwM/3mwDzETjeaAIPZtsbT77OsGWXw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71A0F13276
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 06:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AwmSD5CFmmSPBwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 06:45:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid duplicated chunk lookup during btrfs_map_block()
Date:   Tue, 27 Jun 2023 14:45:18 +0800
Message-ID: <c063726e0bdcf99226ba474f93b56f9fd2f939f3.1687848314.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[INEFFICIENCY]
Inside btrfs_map_block() we will call btrfs_get_chunk_map() twice in a
row:

  btrfs_map_block()
  |- btrfs_num_copies()
  |  \- btrfs_get_chunk_map()
  \- btrfs_get_chunk_map()

This is duplicated and has no special benefit.

[ENHANCEMENT]
Instead of the duplicated btrfs_get_chunk_map() calls, just calculate
the number of copies using the same extent map.

This would reduce one unnecessary rb tree lookup for the pretty hot
btrfs_map_block().

Also to reduce the duplicated code on calculating the number of mirrors
on RAID56, extract a helper, map_num_copies(), to do the extra RAID56
related checks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a536d0e0e055..ed15c89d4350 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5758,11 +5758,25 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
 	}
 }
 
+static int map_num_copies(struct map_lookup *map)
+{
+	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+		return 2;
+	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		return map->num_stripes;
+	return btrfs_bg_type_to_factor(map->type);
+}
+
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
 	struct extent_map *em;
-	struct map_lookup *map;
-	enum btrfs_raid_types index;
 	int ret = 1;
 
 	em = btrfs_get_chunk_map(fs_info, logical, len);
@@ -5775,23 +5789,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 */
 		return 1;
 
-	map = em->map_lookup;
-	index = btrfs_bg_flags_to_raid_index(map->type);
-
-	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
-	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
-		ret = btrfs_raid_array[index].ncopies;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
-		ret = 2;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		/*
-		 * There could be two corrupted data stripes, we need
-		 * to loop retry in order to rebuild the correct data.
-		 *
-		 * Fail a stripe at a time on every retry except the
-		 * stripe under reconstruction.
-		 */
-		ret = map->num_stripes;
+	ret = map_num_copies(em->map_lookup);
 	free_extent_map(em);
 	return ret;
 }
@@ -6257,15 +6255,17 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	ASSERT(bioc_ret);
 
-	num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
-	if (mirror_num > num_copies)
-		return -EINVAL;
-
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
-
 	map = em->map_lookup;
+	num_copies = map_num_copies(map);
+
+	if (mirror_num > num_copies) {
+		free_extent_map(em);
+		return -EINVAL;
+	}
+
 	data_stripes = nr_data_stripes(map);
 
 	map_offset = logical - em->start;
-- 
2.41.0

