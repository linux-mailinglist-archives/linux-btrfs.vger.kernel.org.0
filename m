Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1B50A498
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390287AbiDUPsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390262AbiDUPsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 11:48:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3BC46B38
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 08:45:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B14871F388;
        Thu, 21 Apr 2022 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650555940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OX5GKKWVUl1vyUXF/Ii2k9dg4aVSRwnSGRQhdNQupeE=;
        b=EREM+o+c0BvS8tzkYT1ydXnTaDd5Ma/dAPpb78e7eIZk0nRAyL/4qHBzKbv1AelWmGxVdR
        nn5g1fkgjStUIh6UHfQJk+9Uc/Owfei55Pw/eedvnWpfVmnhC3dMmt84A6YaSU25M9ds0N
        echeXswxHFXN3LABQNO/E9dux/p94SA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8774813446;
        Thu, 21 Apr 2022 15:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9ZAHyR8YWJWagAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 21 Apr 2022 15:45:40 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v2] btrfs: Turn fs_info member buffer_radix into XArray
Date:   Thu, 21 Apr 2022 17:45:38 +0200
Message-Id: <20220421154538.413-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

… named 'extent_buffers'. Also adjust all usages of this object to use the
XArray API, which greatly simplifies the code as it takes care of locking
and is generally easier to use and understand, providing notionally
simpler array semantics.

Also perform some light refactoring.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---

Changes from v1:
 - Fixed first line of commit message

---
 fs/btrfs/ctree.h             |   4 +-
 fs/btrfs/disk-io.c           |   4 +-
 fs/btrfs/extent_io.c         | 118 ++++++++++++++---------------------
 fs/btrfs/tests/btrfs-tests.c |  22 +------
 4 files changed, 55 insertions(+), 93 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7631b88426e..833a95be041b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -994,10 +994,10 @@ struct btrfs_fs_info {
 
 	struct btrfs_delayed_root *delayed_root;
 
-	/* Extent buffer radix tree */
+	/* Extent buffer xarray */
 	spinlock_t buffer_lock;
 	/* Entries are eb->start / sectorsize */
-	struct radix_tree_root buffer_radix;
+	struct xarray extent_buffers;
 
 	/* next backup root to be overwritten */
 	int backup_root_index;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 126f244cdf88..4ab3eba6578d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -486,7 +486,7 @@ static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
 		uptodate = btrfs_subpage_test_uptodate(fs_info, page, cur,
 						       fs_info->nodesize);
 
-		/* A dirty eb shouldn't disappear from buffer_radix */
+		/* A dirty eb shouldn't disappear from extent_buffers */
 		if (WARN_ON(!eb))
 			return -EUCLEAN;
 
@@ -3133,7 +3133,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
-	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
+	xa_init_flags(&fs_info->extent_buffers, GFP_ATOMIC);
 	INIT_LIST_HEAD(&fs_info->trans_list);
 	INIT_LIST_HEAD(&fs_info->dead_roots);
 	INIT_LIST_HEAD(&fs_info->delayed_iputs);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 724e8fe06aa0..d54a6a20d3b9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2950,7 +2950,7 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 }
 
 /*
- * Find extent buffer for a givne bytenr.
+ * Find extent buffer for a given bytenr.
  *
  * This is for end_bio_extent_readpage(), thus we can't do any unsafe locking
  * in endio context.
@@ -2969,11 +2969,9 @@ static struct extent_buffer *find_extent_buffer_readpage(
 		return (struct extent_buffer *)page->private;
 	}
 
-	/* For subpage case, we need to lookup buffer radix tree */
-	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       bytenr >> fs_info->sectorsize_bits);
-	rcu_read_unlock();
+	/* For subpage case, we need to lookup extent buffer xarray */
+	eb = xa_load(&fs_info->extent_buffers,
+		     bytenr >> fs_info->sectorsize_bits);
 	ASSERT(eb);
 	return eb;
 }
@@ -4383,8 +4381,8 @@ static struct extent_buffer *find_extent_buffer_nolock(
 	struct extent_buffer *eb;
 
 	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> fs_info->sectorsize_bits);
+	eb = xa_load(&fs_info->extent_buffers,
+		     start >> fs_info->sectorsize_bits);
 	if (eb && atomic_inc_not_zero(&eb->refs)) {
 		rcu_read_unlock();
 		return eb;
@@ -6072,24 +6070,22 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
 	eb->fs_info = fs_info;
-again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
-		goto free_eb;
-	}
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
+
+	do {
+		ret = xa_insert(&fs_info->extent_buffers,
+				start >> fs_info->sectorsize_bits,
+				eb, GFP_NOFS);
+		if (ret == -ENOMEM) {
+			exists = ERR_PTR(ret);
 			goto free_eb;
-		else
-			goto again;
-	}
+		}
+		if (ret == -EBUSY) {
+			exists = find_extent_buffer(fs_info, start);
+			if (exists)
+				goto free_eb;
+		}
+	} while (ret);
+
 	check_buffer_tree_ref(eb);
 	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
 
@@ -6250,25 +6246,22 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	if (uptodate)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-again:
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
-		goto free_eb;
-	}
-
-	spin_lock(&fs_info->buffer_lock);
-	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
-	spin_unlock(&fs_info->buffer_lock);
-	radix_tree_preload_end();
-	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
+
+	do {
+		ret = xa_insert(&fs_info->extent_buffers,
+				start >> fs_info->sectorsize_bits,
+				eb, GFP_NOFS);
+		if (ret == -ENOMEM) {
+			exists = ERR_PTR(ret);
 			goto free_eb;
-		else
-			goto again;
-	}
+		}
+		if (ret == -EBUSY) {
+			exists = find_extent_buffer(fs_info, start);
+			if (exists)
+				goto free_eb;
+		}
+	} while (ret);
+
 	/* add one reference for the tree */
 	check_buffer_tree_ref(eb);
 	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
@@ -6313,10 +6306,8 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 			spin_unlock(&eb->refs_lock);
 
-			spin_lock(&fs_info->buffer_lock);
-			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> fs_info->sectorsize_bits);
-			spin_unlock(&fs_info->buffer_lock);
+			xa_erase(&fs_info->extent_buffers,
+				 eb->start >> fs_info->sectorsize_bits);
 		} else {
 			spin_unlock(&eb->refs_lock);
 		}
@@ -7249,41 +7240,28 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
-#define GANG_LOOKUP_SIZE	16
 static struct extent_buffer *get_next_extent_buffer(
 		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
 {
-	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
+	struct extent_buffer *eb;
 	struct extent_buffer *found = NULL;
+	unsigned long index;
 	u64 page_start = page_offset(page);
-	u64 cur = page_start;
 
 	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
 	lockdep_assert_held(&fs_info->buffer_lock);
 
-	while (cur < page_start + PAGE_SIZE) {
-		int ret;
-		int i;
-
-		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
-				(void **)gang, cur >> fs_info->sectorsize_bits,
-				min_t(unsigned int, GANG_LOOKUP_SIZE,
-				      PAGE_SIZE / fs_info->nodesize));
-		if (ret == 0)
-			goto out;
-		for (i = 0; i < ret; i++) {
-			/* Already beyond page end */
-			if (gang[i]->start >= page_start + PAGE_SIZE)
-				goto out;
+	xa_for_each_start(&fs_info->extent_buffers, index, eb,
+			  page_start >> fs_info->sectorsize_bits) {
+		if (eb->start >= page_start + PAGE_SIZE)
+		        /* Already beyond page end */
+			break;
+		if (eb->start >= bytenr) {
 			/* Found one */
-			if (gang[i]->start >= bytenr) {
-				found = gang[i];
-				goto out;
-			}
+			found = eb;
+			break;
 		}
-		cur = gang[ret - 1]->start + gang[ret - 1]->len;
 	}
-out:
 	return found;
 }
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index d8e56edd6991..c8c4efc9a3fb 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -150,8 +150,8 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	unsigned long index;
+	struct extent_buffer *eb;
 	struct btrfs_device *dev, *tmp;
 
 	if (!fs_info)
@@ -163,25 +163,9 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 	test_mnt->mnt_sb->s_fs_info = NULL;
 
-	spin_lock(&fs_info->buffer_lock);
-	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
-		struct extent_buffer *eb;
-
-		eb = radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
-		if (!eb)
-			continue;
-		/* Shouldn't happen but that kind of thinking creates CVE's */
-		if (radix_tree_exception(eb)) {
-			if (radix_tree_deref_retry(eb))
-				slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		spin_unlock(&fs_info->buffer_lock);
+	xa_for_each(&fs_info->extent_buffers, index, eb) {
 		free_extent_buffer_stale(eb);
-		spin_lock(&fs_info->buffer_lock);
 	}
-	spin_unlock(&fs_info->buffer_lock);
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
-- 
2.35.3

