Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F972C973
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjFLPLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjFLPK5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 11:10:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B9010F4
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 08:10:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so3336660b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686582644; x=1689174644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kZE7yaorUgpaFKFr7v2ai+YBWcZiaBT/Hk4v54FEpbI=;
        b=aINhEP0r3NzTdJYBTgGN3gzfd+SxcrPb3yC5zvfg7ExCzOqWxvb5cGHLWTNBOYpk9i
         U12s52jS5kyqrHekiT5emi61kxx6xa8aCAMWnx85FuRY7eC01KzmVLCQPn/sqSZc8i07
         BOfZZrMfS2G3b1lOObirqmPEOTf/MRfF9kwKHdHObnM24GQPPSHPCR7ogUZSRFBd8iNh
         hPxqwHGikZrS7B+U9rmWU9woll5p8E+zTN5gJ+1UAObLTVxW5jjdFEJFrLX9W7pSR9uX
         P8BgdxwhZF0IbrO8PqiaWNpBk8NL//otwoPf20BR5bslsFeY+QQHub7YuTpfMU4Trhpi
         r1pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686582644; x=1689174644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kZE7yaorUgpaFKFr7v2ai+YBWcZiaBT/Hk4v54FEpbI=;
        b=eC9jY6fSexRH7JmvGabdYaxHaRlszsxbgzGLOZDHmXP6twCZrfbcoOMOMgwcrjipmP
         UUtvUBDWZUK0t4Ux5zhPCQjPmKJU3lazi+ysrG0GN+gWTb9JoXH9ALigsApGM9/yH+z6
         imzMQOIywqfVq7F1LbOfb9iEYcwV5zT4FBAABueqBfgJmXiIB/hnfZK4yEfxJYFtW8IR
         tVkAoCiFHUlTmYmBMAzmlKstqtUETPAPmHawKozZ24yDatkafGjkwHZ2mGNOXMLbo1w2
         jTMdnt7Uxyet4fZl5qZrUaME0qzpR10U9FZQzwqxpmvyI/SUwxskf3kFdj17fp8E3PRA
         ScVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582644; x=1689174644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZE7yaorUgpaFKFr7v2ai+YBWcZiaBT/Hk4v54FEpbI=;
        b=gzIUwII73D8XMoqO7gIGdfN3beKN/OlbLqkFHXMSL4SKIIoJPqAeGXHxnNy0V8iURF
         qHxk+iVMnvMaPLSzx0gAVrA4sT0Nbyh3lKy1v6OnnzZ78fkRdWR6CiIoPu8IYbYOHpzB
         L/WvrXOcWedIcBmldmrobjNzKsV6hsUE2Q5DJ50QdZuvqZCJfNOBDBDdCloQhrqnrI+o
         huV/R48HRQMma6xIQC6/fu5DWPX1Mkmt2GFlz8c2XwlwSc2vW/gY3pCCnEpLL69/QoRH
         wWjWUtz6uh9BZ6OUkfamn3Lhcq6XYhVck0NjnhZJIKLl+8eiMhpX6NXMhMhme/2wCRDK
         XjTA==
X-Gm-Message-State: AC+VfDzg+uUFw1+3L78Q79Z4/QHuohzubodukB7RXR+pyk1ruxM2KqYu
        4kHx82VyrjWunKtPuDanT4I0XTDHBquILOLueWFimgDyPFmTeWbey/AVymHlC/1fxoBrPREK1cg
        1Iha7G+eGWyw2b+7KVym9lu7qfunj9DxFBc+G9xYEbcS/DcwwEmqde1EnynrRcczRMWjFbnlEt7
        pKrJaf9qi7+bod
X-Google-Smtp-Source: ACHHUZ72fzSin+04WJ8Fzne82KpzlB47bABftJb6o0dFykSr3RWp9dpeMy9tmAH/1R8/GVfKA34QVQ==
X-Received: by 2002:a05:6a00:23c7:b0:64d:1c59:6767 with SMTP id g7-20020a056a0023c700b0064d1c596767mr12280959pfc.24.1686582644353;
        Mon, 12 Jun 2023 08:10:44 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id f8-20020aa782c8000000b006635846f3a8sm7116989pfn.91.2023.06.12.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:10:43 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: do not limit delalloc size to fs_info->max_extent_size
Date:   Tue, 13 Jun 2023 00:10:29 +0900
Message-ID: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an issue writing out huge buffered data with the compressed mount
option on zoned mode. For example, when you buffered write 16GB data and
call "sync" command on "mount -o compress" file-system on a zoned device,
it takes more than 3 minutes to finish the sync, invoking the hung_task
timeout.

Before the patch:

    + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
    wrote 17179869184/17179869184 bytes at offset 0
    16.000 GiB, 2048 ops; 0:00:23.74 (690.013 MiB/sec and 86.2516 ops/sec)

    real    0m23.770s
    user    0m0.005s
    sys     0m23.599s
    + sync

    real    3m55.921s
    user    0m0.000s
    sys     0m0.134s

After the patch:

    + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
    wrote 17179869184/17179869184 bytes at offset 0
    16.000 GiB, 2048 ops; 0:00:28.11 (582.648 MiB/sec and 72.8311 ops/sec)

    real    0m28.146s
    user    0m0.004s
    sys     0m27.951s
    + sync

    real    0m12.310s
    user    0m0.000s
    sys     0m0.048s

This slow "sync" comes from inefficient async chunk building due to
needlessly limited delalloc size.

find_lock_delalloc_range() looks for pages for the delayed allocation at
most fs_info->max_extent_size in its size. For the non-compress write case,
that range directly corresponds to num_bytes at cow_file_range() (= size of
allocation). So, limiting the size to the max_extent_size seems no harm as
we will split the extent even if we can have a larger allocation.

However, things are different with the compression case. The
run_delalloc_compressed() divides the delalloc range into 512 KB sized
chunks and queues a worker for each chunk. The device of the above test
case has 672 KB zone_append_max_bytes, which is equal to
fs_info->max_extent_size. Thus, one run_delalloc_compressed() call can
build only two chunks at most, which is really smaller than
BTRFS_MAX_EXTENT_SIZE / 512KB = 256, making it inefficient.

Also, as 672 KB is not aligned to 512 KB, it is creating ceil(16G / 672K) *
2 = 49934 async chunks for the above case. OTOH, with BTRFS_MAX_EXTENT_SIZE
delalloced, we will create 32768 chunks, which is 34% reduced.

This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
not directly corresponds to the size of one extent. Instead, this patch
will limit the allocation size at cow_file_range() for the zoned mode.

As shown above, with this patch applied, the "sync" time is reduced from
almost 4 minutes to 12 seconds.

Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
CC: stable@vger.kernel.org # 6.1+
---
 fs/btrfs/extent-tree.c |  3 +++
 fs/btrfs/extent_io.c   | 11 ++++++++---
 fs/btrfs/inode.c       |  5 ++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 911908ea5f6f..e6944c4db18b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4452,6 +4452,9 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 	bool for_data_reloc = (btrfs_is_data_reloc_root(root) && is_data);
 
+	if (btrfs_is_zoned(fs_info))
+		ASSERT(num_bytes <= fs_info->max_extent_size);
+
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a91d5ad27984..bd86d9fc2b31 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -371,12 +371,17 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    struct page *locked_page, u64 *start,
 				    u64 *end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u64 orig_start = *start;
 	const u64 orig_end = *end;
-	/* The sanity tests may not set a valid fs_info. */
-	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
+	/*
+	 * We don't use fs_info->max_extent_size here. The delalloc range will
+	 * not directly corresponds to the size of an extent. The allocation
+	 * size will be capped by either cow_file_range() (only for zoned) or
+	 * run_delalloc_compressed(). We can give large enough size to collect
+	 * delalloc pages.
+	 */
+	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool found;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27bb1298f73c..3823ecc836c2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1494,7 +1494,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	while (num_bytes > 0) {
 		struct btrfs_ordered_extent *ordered;
 
-		cur_alloc_size = num_bytes;
+		if (btrfs_is_zoned(fs_info))
+			cur_alloc_size = min_t(u64, num_bytes, fs_info->max_extent_size);
+		else
+			cur_alloc_size = num_bytes;
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   min_alloc_size, 0, alloc_hint,
 					   &ins, 1, 1);
-- 
2.41.0

