Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E76740B93
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjF1Ic4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:32:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36386 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjF1Iaa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:30:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 895A32186F
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687927988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1xYXot8ZqKa/aNr1CJf4hXNg6w4HIvcM7GvFm1PfaT8=;
        b=J+LyNU1wcsd25InNWzwc6H3dJ0dD1qBzpfKJDYx7gN2GpW6yeLg7xEPO939KnS0VYMg+bb
        ACLPoRlB7zaIuF2NgzwGt3IGwce8ydK2eBGNnA1vQsWsLaSWTZP5S896VsqZUJ7HevdsrG
        Zqaiy3QDu+PJFDNOMYLMCyu2xOKTXtY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE0A513483
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 04:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RK+WKbO8m2QecwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 04:53:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: avoid duplicated chunk lookup during btrfs_map_block()
Date:   Wed, 28 Jun 2023 12:52:50 +0800
Message-ID: <39b29e7b3b11bf19eb5ac4ce3276c6e218b59e21.1687927850.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Changelog:
v2:
- Remove @num_copies variables
  Use map_num_copies() on @map directly.

- Add a new @out_free_em label to error out
---
 fs/btrfs/volumes.c | 49 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a536d0e0e055..512afe691c30 100644
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
@@ -6246,7 +6244,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int ret = 0;
 	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
 	int num_stripes;
-	int num_copies;
 	int max_errors = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
@@ -6257,15 +6254,16 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
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
+
+	if (mirror_num > map_num_copies(map)) {
+		ret = -EINVAL;
+		goto out_free_em;
+	}
+
 	data_stripes = nr_data_stripes(map);
 
 	map_offset = logical - em->start;
@@ -6474,6 +6472,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
 	}
+out_free_em:
 	free_extent_map(em);
 	return ret;
 }
-- 
2.41.0

