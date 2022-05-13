Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EE525DA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378340AbiEMIeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiEMIem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:34:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E72A83C2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:34:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0A071F92C
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652430878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1g6J7OSDqHmrxDUkzBOpZX37ALiZn6zjStAGuOVW9CE=;
        b=EuIoZFg7uDkvj0Orfi2QH4TE3CFahCAGlHYXAnxhM0tI1HK0czj49Ur00gQfDHsG7YXqAP
        /bvk99qQccimYE8RGjXXGtNMJFVskWVcWYT0c2g8tUyL4w2esGAEZrdYfSJOhdCoFWxnFL
        5klSq+GzGQZr812nlzcv+kEWm0OuqBw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5336113446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gMX4Bx4YfmI2YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in btrfs_num_copies()
Date:   Fri, 13 May 2022 16:34:31 +0800
Message-Id: <a51939d1e568f36135c8f0383a4f34da5bda0f4b.1652428644.git.wqu@suse.com>
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

For all non-raid56 profiles, we can just use btrfs_raid_array[].ncopies
directly.

Only for RAID5 and RAID6 we need some extra handling.

This will reduce several branches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ce9140fb955..cddbbd8eb310 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5721,7 +5721,8 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
-	int ret;
+	enum btrfs_raid_types index;
+	int ret = 1;
 
 	em = btrfs_get_chunk_map(fs_info, logical, len);
 	if (IS_ERR(em))
@@ -5734,10 +5735,11 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		return 1;
 
 	map = em->map_lookup;
-	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MASK))
-		ret = map->num_stripes;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
-		ret = map->sub_stripes;
+	index = btrfs_bg_flags_to_raid_index(map->type);
+
+	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
+		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */
+		ret = btrfs_raid_array[index].ncopies;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret = 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
@@ -5749,8 +5751,6 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 * stripe under reconstruction.
 		 */
 		ret = map->num_stripes;
-	else
-		ret = 1;
 	free_extent_map(em);
 
 	down_read(&fs_info->dev_replace.rwsem);
-- 
2.36.1

