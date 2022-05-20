Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B052E1FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 03:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiETBcN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344483AbiETBcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 21:32:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4B99AE49
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 18:32:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 435271FA1F
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653010330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baRQv8xvgDGg5xGbim1PYP8CIbMd94mrLy2Bo23KKSM=;
        b=iNDUlQRUiByX7/lwgwuQ29plrIpfkzbxrgywBGh/ZSoIBRWnCje44wKJ9V7w788MvzO53x
        s45mDLfO/DRw06UU7U+vPOU6pSBScKWsq+zpI16TVvtpzpZIN3JEHVlhDomIAHLohrkHYn
        2ghL+Gx7Y08iW5aEh6KT/P2ZMSBpqks=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACA3313A5F
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ACLnHpnvhmKXOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: properly initialize btrfs_block_group::bitmap_high_thresh
Date:   Fri, 20 May 2022 09:31:50 +0800
Message-Id: <784b57e83fbc025cc01bb44906dfc0c6cf1f7c8f.1653009947.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653009947.git.wqu@suse.com>
References: <cover.1653009947.git.wqu@suse.com>
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

[BUG]
When creating btrfs with new v2 cache (the default behavior), mkfs.btrfs
always create the free space tree using bitmap.

It's fine for small fs, but will be a disaster if the device is large
and the data profile is something like RAID0:

  $ mkfs.btrfs  -f -m raid1 -d raid0 /dev/test/scratch[1234]
  btrfs-progs v5.17
  [...]
  Block group profiles:
    Data:             RAID0             4.00GiB
    Metadata:         RAID1           256.00MiB
    System:           RAID1             8.00MiB
  [..]

  $ btrfs ins dump-tree -t free-space /dev/test/scratch1
  btrfs-progs v5.17
  free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
  node 30441472 level 1 items 10 free space 483 generation 6 owner FREE_SPACE_TREE
  node 30441472 flags 0x1(WRITTEN) backref revision 1
  fs uuid deddccae-afd0-4160-9a12-48fe7b526fb1
  chunk uuid 68f6cf98-afe3-4f47-9797-37fd9c610219
          key (1048576 FREE_SPACE_INFO 4194304) block 30457856 gen 6
          key (475004928 FREE_SPACE_BITMAP 8388608) block 30703616 gen 5
          key (953155584 FREE_SPACE_BITMAP 8388608) block 30720000 gen 5
          key (1431306240 FREE_SPACE_BITMAP 8388608) block 30736384 gen 5
          key (1909456896 FREE_SPACE_BITMAP 8388608) block 30752768 gen 5
          key (2387607552 FREE_SPACE_BITMAP 8388608) block 30769152 gen 5
          key (2865758208 FREE_SPACE_BITMAP 8388608) block 30785536 gen 5
          key (3343908864 FREE_SPACE_BITMAP 8388608) block 30801920 gen 5
          key (3822059520 FREE_SPACE_BITMAP 8388608) block 30818304 gen 5
          key (4300210176 FREE_SPACE_BITMAP 8388608) block 30834688 gen 5
  [...]
  ^^^ So many bitmaps that an empty fs will have two levels for free
      space tree already

[CAUSE]
Member btrfs_block_group::bitmap_high_thresh is never properly set to
any value other than 0, thus in function
update_free_space_extent_count(), the following check is always true:

	if (!(flags & BTRFS_FREE_SPACE_USING_BITMAPS) &&
	    extent_count > block_group->bitmap_high_thresh) {
		ret = convert_free_space_to_bitmaps(trans, block_group, path);

Thus we always got converted to bitmaps.

[FIX]
Crossport the function set_free_space_tree_thresholds() from kernel, and
call that function in btrfs_make_block_group() and
read_one_block_group() so that every block group has bitmap_high_thresh
properly set.

Now even for that 4GiB large data chunk, we still only have one free extent:

  btrfs-progs v5.17
  free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
  leaf 30572544 items 15 free space 15860 generation 6 owner FREE_SPACE_TREE
  leaf 30572544 flags 0x1(WRITTEN) backref revision 1
  fs uuid b24e52ea-6580-4a88-aa70-cb173090bfe3
  chunk uuid d85f3905-fc61-4084-b335-2b6b97814b8e
  [...]
          item 13 key (298844160 FREE_SPACE_INFO 4294967296) itemoff 16235 itemsize 8
                  free space info extent count 1 flags 0
          item 14 key (298844160 FREE_SPACE_EXTENT 4294967296) itemoff 16235 itemsize 0
                  free space extent

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c     |  2 ++
 kernel-shared/free-space-tree.c | 29 +++++++++++++++++++++++++++++
 kernel-shared/free-space-tree.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 697a8a1e4dec..5807b11a7b1a 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2697,6 +2697,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 		free(cache);
 		return ret;
 	}
+	set_free_space_tree_thresholds(fs_info, cache);
 	INIT_LIST_HEAD(&cache->dirty_list);
 
 	set_avail_alloc_bits(fs_info, cache->flags);
@@ -2845,6 +2846,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 
 	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
 				      size);
+	set_free_space_tree_thresholds(fs_info, cache);
 	ret = insert_block_group_item(trans, cache);
 	if (ret)
 		return ret;
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 03eb0ed290fc..e8034057fc56 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -40,6 +40,35 @@ static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 	return btrfs_global_root(fs_info, &key);
 }
 
+void set_free_space_tree_thresholds(struct btrfs_fs_info *fs_info,
+				    struct btrfs_block_group *cache)
+{
+	u32 bitmap_range;
+	size_t bitmap_size;
+	u64 num_bitmaps, total_bitmap_size;
+
+	/*
+	 * We convert to bitmaps when the disk space required for using extents
+	 * exceeds that required for using bitmaps.
+	 */
+	bitmap_range = fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
+	num_bitmaps = div_u64(cache->start + bitmap_range - 1,
+			      bitmap_range);
+	bitmap_size = sizeof(struct btrfs_item) + BTRFS_FREE_SPACE_BITMAP_SIZE;
+	total_bitmap_size = num_bitmaps * bitmap_size;
+	cache->bitmap_high_thresh = div_u64(total_bitmap_size,
+					    sizeof(struct btrfs_item));
+
+	/*
+	 * We allow for a small buffer between the high threshold and low
+	 * threshold to avoid thrashing back and forth between the two formats.
+	 */
+	if (cache->bitmap_high_thresh > 100)
+		cache->bitmap_low_thresh = cache->bitmap_high_thresh - 100;
+	else
+		cache->bitmap_low_thresh = 0;
+}
+
 static struct btrfs_free_space_info *
 search_free_space_info(struct btrfs_trans_handle *trans,
 		       struct btrfs_fs_info *fs_info,
diff --git a/kernel-shared/free-space-tree.h b/kernel-shared/free-space-tree.h
index 4f6aa5fc9eaf..e3ae38e10d9f 100644
--- a/kernel-shared/free-space-tree.h
+++ b/kernel-shared/free-space-tree.h
@@ -22,6 +22,8 @@
 #define BTRFS_FREE_SPACE_BITMAP_SIZE 256
 #define BTRFS_FREE_SPACE_BITMAP_BITS (BTRFS_FREE_SPACE_BITMAP_SIZE * BITS_PER_BYTE)
 
+void set_free_space_tree_thresholds(struct btrfs_fs_info *fs_info,
+				    struct btrfs_block_group *cache);
 int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
 int load_free_space_tree(struct btrfs_fs_info *fs_info,
 			 struct btrfs_block_group *block_group);
-- 
2.36.1

