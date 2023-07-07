Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456A274AD3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGGIku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 04:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGGIkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 04:40:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E31997
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 01:40:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED2F61FDD8
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688719245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/TxeA24R68UyEUghvhtr0rnRZuariQiu79IvXiDIZQw=;
        b=FkVI4R1SlBCovQOx/ZxjFPXuDybZDIMxU4b3MpHitdHS4hEScAdBCrMVljvim7fA50uohK
        Y4InyHpsRUtdI/ChO4R4uh8iNtly4avHnIk4SLBPImtv3oC2kTNeNCJ0fh5CKjgMHJ9VeJ
        nsUcWjHRwwhC3wScDGgfzv7HwXjkFUY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51FF31346D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMPjB43Pp2RDQwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 08:40:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
Date:   Fri,  7 Jul 2023 16:40:27 +0800
Message-ID: <20230707084027.91022-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

!!! DO NOT MERGE !!!

Although the current folio interface is not yet providing a way to
allocate a range of contiguous pages, I'm always curious if we can get
rid of the cross page handling.

So this patch is an attempt to provide some benchmark on the extent
buffer page contiguousness.

The patch handle such work by:

- Every allocated extent buffer (except dummy) would increase
  fs_info->eb_allocated

- If the pages of the extent buffer are contiguous, increase
  fs_info->eb_pages_contig

- On close_ctree(), output both numbers

The VM has the following setup for benchmark:

- Mem: 4G
- CPU: 8 vCores
- Disk: 500G SATA SSD directly passed to VM
- Fs: 2X10G LV, 16K nodesize 4K sectorsize.

I tested two sitautions:

- Metadata heavy workload
  The workload is "fsstress -p 20 -n 10000 -w -d $mnt".

  The result is 566140 / 854009 = 66.3 %

  Which is better than what I thought.

- Data heavy workload
  The workload is fio with a 12G file (3x system memory).

  The result is 1355 / 2358 = 57.5 %

Considering it's mostly beyond 50%, I believe it should be worthy for us
to consider reduce the cross-page boundary overhead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 5 +++++
 fs/btrfs/extent_io.c | 8 +++++++-
 fs/btrfs/extent_io.h | 3 +++
 fs/btrfs/fs.h        | 2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567..4ba51e1235c4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2698,6 +2698,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
+	atomic64_set(&fs_info->eb_allocated, 0);
+	atomic64_set(&fs_info->eb_pages_contig, 0);
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
@@ -4321,6 +4323,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
 
+	btrfs_info(fs_info, "eb contig=%llu allocated=%llu",
+			atomic64_read(&fs_info->eb_pages_contig),
+			atomic64_read(&fs_info->eb_allocated));
 	if (!sb_rdonly(fs_info->sb)) {
 		/*
 		 * The cleaner kthread is stopped, so do one final pass over
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a91d5ad27984..995205441937 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3530,6 +3530,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	u64 lockdep_owner = owner_root;
+	bool pages_contig = true;
 	int uptodate = 1;
 	int ret;
 
@@ -3624,6 +3625,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		eb->pages[i] = p;
 		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
 			uptodate = 0;
+		if (i && eb->pages[i - 1] + 1 != p)
+			pages_contig = false;
 
 		/*
 		 * We can't unlock the pages just yet since the extent buffer
@@ -3657,7 +3660,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	/* add one reference for the tree */
 	check_buffer_tree_ref(eb);
 	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
-
+	eb->pages_contig = pages_contig;
+	atomic64_inc(&fs_info->eb_allocated);
+	if (pages_contig)
+		atomic64_inc(&fs_info->eb_pages_contig);
 	/*
 	 * Now it's safe to unlock the pages because any calls to
 	 * btree_release_folio will correctly detect that a page belongs to a
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c5fae3a7d911..98b596bbac2e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -86,6 +86,9 @@ struct extent_buffer {
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
 
+	/* Set if the pages are contiguous. */
+	bool pages_contig;
+
 	struct rw_semaphore lock;
 
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..8cdd2af98bd6 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -802,6 +802,8 @@ struct btrfs_fs_info {
 
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
+	atomic64_t eb_allocated;
+	atomic64_t eb_pages_contig;
 #endif
 };
 
-- 
2.39.0

