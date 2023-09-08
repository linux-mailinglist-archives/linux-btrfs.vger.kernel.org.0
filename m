Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD25798284
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbjIHGms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 02:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjIHGmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 02:42:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EA819AE
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 23:42:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B13B1F750
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694155358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPHfyJgtAyIEoZamhPNGqjTrTlwn/QxEOGW8IrrIKx8=;
        b=TQgkVyPDNWv/Bo8RYP/vxOv2EY419WvUbyFSHrf/kpsx4zx+0chUqMMlHIIHRuzkBk0rb3
        4KsIujQpe7ZI4ciR5IU7mFCjH7wJObKF9waBKQOeu8I+GRBLnuOu+X3k9FbPuWRIF32ZBW
        DI0VuRwp4wqjjOJTulgVeeVgVawrkuo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D25CE131FD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SGJLKF3C+mQZeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 06:42:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove btrfsic_unmount() function
Date:   Fri,  8 Sep 2023 14:42:16 +0800
Message-ID: <3248ea82b001ca58c9a9cd8596acdf95cb587a5d.1694154699.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694154699.git.wqu@suse.com>
References: <cover.1694154699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfsic_mount() is part of the deprecated
check-integrity functionality.

Now let's remove the main entrance of check-integrity, and thankfully
most of the check-integrity code is self-contained inside
check-integrity.c, we can safely remove the function without huge
changes to btrfs code base.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile          |   1 -
 fs/btrfs/bio.c             |   1 -
 fs/btrfs/check-integrity.c | 391 -------------------------------------
 fs/btrfs/check-integrity.h |  11 --
 fs/btrfs/dev-replace.c     |   1 -
 fs/btrfs/disk-io.c         |   6 -
 fs/btrfs/extent_io.c       |   1 -
 fs/btrfs/scrub.c           |   1 -
 8 files changed, 413 deletions(-)
 delete mode 100644 fs/btrfs/check-integrity.c
 delete mode 100644 fs/btrfs/check-integrity.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 90d53209755b..c57d80729d4f 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -36,7 +36,6 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   lru_cache.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
-btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
 btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 btrfs-$(CONFIG_FS_VERITY) += verity.o
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f2486fb5f404..31ff36990404 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -10,7 +10,6 @@
 #include "volumes.h"
 #include "raid56.h"
 #include "async-thread.h"
-#include "check-integrity.h"
 #include "dev-replace.h"
 #include "rcu-string.h"
 #include "zoned.h"
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
deleted file mode 100644
index a8131eee583c..000000000000
--- a/fs/btrfs/check-integrity.c
+++ /dev/null
@@ -1,391 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) STRATO AG 2011.  All rights reserved.
- */
-
-/*
- * This module can be used to catch cases when the btrfs kernel
- * code executes write requests to the disk that bring the file
- * system in an inconsistent state. In such a state, a power-loss
- * or kernel panic event would cause that the data on disk is
- * lost or at least damaged.
- *
- * Code is added that examines all block write requests during
- * runtime (including writes of the super block). Three rules
- * are verified and an error is printed on violation of the
- * rules:
- * 1. It is not allowed to write a disk block which is
- *    currently referenced by the super block (either directly
- *    or indirectly).
- * 2. When a super block is written, it is verified that all
- *    referenced (directly or indirectly) blocks fulfill the
- *    following requirements:
- *    2a. All referenced blocks have either been present when
- *        the file system was mounted, (i.e., they have been
- *        referenced by the super block) or they have been
- *        written since then and the write completion callback
- *        was called and no write error was indicated and a
- *        FLUSH request to the device where these blocks are
- *        located was received and completed.
- *    2b. All referenced blocks need to have a generation
- *        number which is equal to the parent's number.
- *
- * One issue that was found using this module was that the log
- * tree on disk became temporarily corrupted because disk blocks
- * that had been in use for the log tree had been freed and
- * reused too early, while being referenced by the written super
- * block.
- *
- * The search term in the kernel log that can be used to filter
- * on the existence of detected integrity issues is
- * "btrfs: attempt".
- *
- * The integrity check is enabled via mount options. These
- * mount options are only supported if the integrity check
- * tool is compiled by defining BTRFS_FS_CHECK_INTEGRITY.
- *
- * Example #1, apply integrity checks to all metadata:
- * mount /dev/sdb1 /mnt -o check_int
- *
- * Example #2, apply integrity checks to all metadata and
- * to data extents:
- * mount /dev/sdb1 /mnt -o check_int_data
- *
- * Example #3, apply integrity checks to all metadata and dump
- * the tree that the super block references to kernel messages
- * each time after a super block was written:
- * mount /dev/sdb1 /mnt -o check_int,check_int_print_mask=263
- *
- * If the integrity check tool is included and activated in
- * the mount options, plenty of kernel memory is used, and
- * plenty of additional CPU cycles are spent. Enabling this
- * functionality is not intended for normal use. In most
- * cases, unless you are a btrfs developer who needs to verify
- * the integrity of (super)-block write requests, do not
- * enable the config option BTRFS_FS_CHECK_INTEGRITY to
- * include and compile the integrity check tool.
- *
- * Expect millions of lines of information in the kernel log with an
- * enabled check_int_print_mask. Therefore set LOG_BUF_SHIFT in the
- * kernel config to at least 26 (which is 64MB). Usually the value is
- * limited to 21 (which is 2MB) in init/Kconfig. The file needs to be
- * changed like this before LOG_BUF_SHIFT can be set to a high value:
- * config LOG_BUF_SHIFT
- *       int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
- *       range 12 30
- */
-
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/mutex.h>
-#include <linux/blkdev.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <crypto/hash.h>
-#include "messages.h"
-#include "ctree.h"
-#include "disk-io.h"
-#include "transaction.h"
-#include "extent_io.h"
-#include "volumes.h"
-#include "print-tree.h"
-#include "locking.h"
-#include "check-integrity.h"
-#include "rcu-string.h"
-#include "compression.h"
-#include "accessors.h"
-
-#define BTRFSIC_BLOCK_HASHTABLE_SIZE 0x10000
-#define BTRFSIC_BLOCK_LINK_HASHTABLE_SIZE 0x10000
-#define BTRFSIC_DEV2STATE_HASHTABLE_SIZE 0x100
-#define BTRFSIC_BLOCK_MAGIC_NUMBER 0x14491051
-#define BTRFSIC_BLOCK_LINK_MAGIC_NUMBER 0x11070807
-#define BTRFSIC_DEV2STATE_MAGIC_NUMBER 0x20111530
-#define BTRFSIC_BLOCK_STACK_FRAME_MAGIC_NUMBER 20111300
-#define BTRFSIC_TREE_DUMP_MAX_INDENT_LEVEL (200 - 6)	/* in characters,
-							 * excluding " [...]" */
-#define BTRFSIC_GENERATION_UNKNOWN ((u64)-1)
-
-/*
- * The definition of the bitmask fields for the print_mask.
- * They are specified with the mount option check_integrity_print_mask.
- */
-#define BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE			0x00000001
-#define BTRFSIC_PRINT_MASK_ROOT_CHUNK_LOG_TREE_LOCATION		0x00000002
-#define BTRFSIC_PRINT_MASK_TREE_AFTER_SB_WRITE			0x00000004
-#define BTRFSIC_PRINT_MASK_TREE_BEFORE_SB_WRITE			0x00000008
-#define BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH			0x00000010
-#define BTRFSIC_PRINT_MASK_END_IO_BIO_BH			0x00000020
-#define BTRFSIC_PRINT_MASK_VERBOSE				0x00000040
-#define BTRFSIC_PRINT_MASK_VERY_VERBOSE				0x00000080
-#define BTRFSIC_PRINT_MASK_INITIAL_TREE				0x00000100
-#define BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES			0x00000200
-#define BTRFSIC_PRINT_MASK_INITIAL_DATABASE			0x00000400
-#define BTRFSIC_PRINT_MASK_NUM_COPIES				0x00000800
-#define BTRFSIC_PRINT_MASK_TREE_WITH_ALL_MIRRORS		0x00001000
-#define BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE		0x00002000
-
-struct btrfsic_dev_state;
-struct btrfsic_state;
-
-struct btrfsic_block {
-	u32 magic_num;		/* only used for debug purposes */
-	unsigned int is_metadata:1;	/* if it is meta-data, not data-data */
-	unsigned int is_superblock:1;	/* if it is one of the superblocks */
-	unsigned int is_iodone:1;	/* if is done by lower subsystem */
-	unsigned int iodone_w_error:1;	/* error was indicated to endio */
-	unsigned int never_written:1;	/* block was added because it was
-					 * referenced, not because it was
-					 * written */
-	unsigned int mirror_num;	/* large enough to hold
-					 * BTRFS_SUPER_MIRROR_MAX */
-	struct btrfsic_dev_state *dev_state;
-	u64 dev_bytenr;		/* key, physical byte num on disk */
-	u64 logical_bytenr;	/* logical byte num on disk */
-	u64 generation;
-	struct btrfs_disk_key disk_key;	/* extra info to print in case of
-					 * issues, will not always be correct */
-	struct list_head collision_resolving_node;	/* list node */
-	struct list_head all_blocks_node;	/* list node */
-
-	/* the following two lists contain block_link items */
-	struct list_head ref_to_list;	/* list */
-	struct list_head ref_from_list;	/* list */
-	struct btrfsic_block *next_in_same_bio;
-	void *orig_bio_private;
-	bio_end_io_t *orig_bio_end_io;
-	blk_opf_t submit_bio_bh_rw;
-	u64 flush_gen; /* only valid if !never_written */
-};
-
-/*
- * Elements of this type are allocated dynamically and required because
- * each block object can refer to and can be ref from multiple blocks.
- * The key to lookup them in the hashtable is the dev_bytenr of
- * the block ref to plus the one from the block referred from.
- * The fact that they are searchable via a hashtable and that a
- * ref_cnt is maintained is not required for the btrfs integrity
- * check algorithm itself, it is only used to make the output more
- * beautiful in case that an error is detected (an error is defined
- * as a write operation to a block while that block is still referenced).
- */
-struct btrfsic_block_link {
-	u32 magic_num;		/* only used for debug purposes */
-	u32 ref_cnt;
-	struct list_head node_ref_to;	/* list node */
-	struct list_head node_ref_from;	/* list node */
-	struct list_head collision_resolving_node;	/* list node */
-	struct btrfsic_block *block_ref_to;
-	struct btrfsic_block *block_ref_from;
-	u64 parent_generation;
-};
-
-struct btrfsic_dev_state {
-	u32 magic_num;		/* only used for debug purposes */
-	struct block_device *bdev;
-	struct btrfsic_state *state;
-	struct list_head collision_resolving_node;	/* list node */
-	struct btrfsic_block dummy_block_for_bio_bh_flush;
-	u64 last_flush_gen;
-};
-
-struct btrfsic_block_hashtable {
-	struct list_head table[BTRFSIC_BLOCK_HASHTABLE_SIZE];
-};
-
-struct btrfsic_block_link_hashtable {
-	struct list_head table[BTRFSIC_BLOCK_LINK_HASHTABLE_SIZE];
-};
-
-struct btrfsic_dev_state_hashtable {
-	struct list_head table[BTRFSIC_DEV2STATE_HASHTABLE_SIZE];
-};
-
-struct btrfsic_block_data_ctx {
-	u64 start;		/* virtual bytenr */
-	u64 dev_bytenr;		/* physical bytenr on device */
-	u32 len;
-	struct btrfsic_dev_state *dev;
-	char **datav;
-	struct page **pagev;
-	void *mem_to_free;
-};
-
-/* This structure is used to implement recursion without occupying
- * any stack space, refer to btrfsic_process_metablock() */
-struct btrfsic_stack_frame {
-	u32 magic;
-	u32 nr;
-	int error;
-	int i;
-	int limit_nesting;
-	int num_copies;
-	int mirror_num;
-	struct btrfsic_block *block;
-	struct btrfsic_block_data_ctx *block_ctx;
-	struct btrfsic_block *next_block;
-	struct btrfsic_block_data_ctx next_block_ctx;
-	struct btrfs_header *hdr;
-	struct btrfsic_stack_frame *prev;
-};
-
-/* Some state per mounted filesystem */
-struct btrfsic_state {
-	u32 print_mask;
-	int include_extent_data;
-	struct list_head all_blocks_list;
-	struct btrfsic_block_hashtable block_hashtable;
-	struct btrfsic_block_link_hashtable block_link_hashtable;
-	struct btrfs_fs_info *fs_info;
-	u64 max_superblock_generation;
-	struct btrfsic_block *latest_superblock;
-	u32 metablock_size;
-	u32 datablock_size;
-};
-
-static void btrfsic_print_rem_link(const struct btrfsic_state *state,
-				   const struct btrfsic_block_link *l);
-static char btrfsic_get_block_type(const struct btrfsic_state *state,
-				   const struct btrfsic_block *block);
-static struct mutex btrfsic_mutex;
-static int btrfsic_is_initialized;
-static struct btrfsic_dev_state_hashtable btrfsic_dev_state_hashtable;
-
-
-static void btrfsic_block_free(struct btrfsic_block *b)
-{
-	BUG_ON(!(NULL == b || BTRFSIC_BLOCK_MAGIC_NUMBER == b->magic_num));
-	kfree(b);
-}
-
-static void btrfsic_block_link_free(struct btrfsic_block_link *l)
-{
-	BUG_ON(!(NULL == l || BTRFSIC_BLOCK_LINK_MAGIC_NUMBER == l->magic_num));
-	kfree(l);
-}
-
-static void btrfsic_dev_state_free(struct btrfsic_dev_state *ds)
-{
-	BUG_ON(!(NULL == ds ||
-		 BTRFSIC_DEV2STATE_MAGIC_NUMBER == ds->magic_num));
-	kfree(ds);
-}
-
-static void btrfsic_dev_state_hashtable_remove(struct btrfsic_dev_state *ds)
-{
-	list_del(&ds->collision_resolving_node);
-}
-
-static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
-		struct btrfsic_dev_state_hashtable *h)
-{
-	const unsigned int hashval =
-		dev & (BTRFSIC_DEV2STATE_HASHTABLE_SIZE - 1);
-	struct btrfsic_dev_state *ds;
-
-	list_for_each_entry(ds, h->table + hashval, collision_resolving_node) {
-		if (ds->bdev->bd_dev == dev)
-			return ds;
-	}
-
-	return NULL;
-}
-
-static void btrfsic_print_rem_link(const struct btrfsic_state *state,
-				   const struct btrfsic_block_link *l)
-{
-	pr_info("rem %u* link from %c @%llu (%pg/%llu/%d) to %c @%llu (%pg/%llu/%d)\n",
-	       l->ref_cnt,
-	       btrfsic_get_block_type(state, l->block_ref_from),
-	       l->block_ref_from->logical_bytenr,
-	       l->block_ref_from->dev_state->bdev,
-	       l->block_ref_from->dev_bytenr, l->block_ref_from->mirror_num,
-	       btrfsic_get_block_type(state, l->block_ref_to),
-	       l->block_ref_to->logical_bytenr,
-	       l->block_ref_to->dev_state->bdev, l->block_ref_to->dev_bytenr,
-	       l->block_ref_to->mirror_num);
-}
-
-static char btrfsic_get_block_type(const struct btrfsic_state *state,
-				   const struct btrfsic_block *block)
-{
-	if (block->is_superblock &&
-	    state->latest_superblock->dev_bytenr == block->dev_bytenr &&
-	    state->latest_superblock->dev_state->bdev == block->dev_state->bdev)
-		return 'S';
-	else if (block->is_superblock)
-		return 's';
-	else if (block->is_metadata)
-		return 'M';
-	else
-		return 'D';
-}
-
-void btrfsic_unmount(struct btrfs_fs_devices *fs_devices)
-{
-	struct btrfsic_block *b_all, *tmp_all;
-	struct btrfsic_state *state;
-	struct list_head *dev_head = &fs_devices->devices;
-	struct btrfs_device *device;
-
-	if (!btrfsic_is_initialized)
-		return;
-
-	mutex_lock(&btrfsic_mutex);
-
-	state = NULL;
-	list_for_each_entry(device, dev_head, dev_list) {
-		struct btrfsic_dev_state *ds;
-
-		if (!device->bdev || !device->name)
-			continue;
-
-		ds = btrfsic_dev_state_hashtable_lookup(
-				device->bdev->bd_dev,
-				&btrfsic_dev_state_hashtable);
-		if (NULL != ds) {
-			state = ds->state;
-			btrfsic_dev_state_hashtable_remove(ds);
-			btrfsic_dev_state_free(ds);
-		}
-	}
-
-	if (NULL == state) {
-		pr_info("btrfsic: error, cannot find state information on umount!\n");
-		mutex_unlock(&btrfsic_mutex);
-		return;
-	}
-
-	/*
-	 * Don't care about keeping the lists' state up to date,
-	 * just free all memory that was allocated dynamically.
-	 * Free the blocks and the block_links.
-	 */
-	list_for_each_entry_safe(b_all, tmp_all, &state->all_blocks_list,
-				 all_blocks_node) {
-		struct btrfsic_block_link *l, *tmp;
-
-		list_for_each_entry_safe(l, tmp, &b_all->ref_to_list,
-					 node_ref_to) {
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				btrfsic_print_rem_link(state, l);
-
-			l->ref_cnt--;
-			if (0 == l->ref_cnt)
-				btrfsic_block_link_free(l);
-		}
-
-		if (b_all->is_iodone || b_all->never_written)
-			btrfsic_block_free(b_all);
-		else
-			pr_info(
-"btrfs: attempt to free %c-block @%llu (%pg/%llu/%d) on umount which is not yet iodone!\n",
-			       btrfsic_get_block_type(state, b_all),
-			       b_all->logical_bytenr, b_all->dev_state->bdev,
-			       b_all->dev_bytenr, b_all->mirror_num);
-	}
-
-	mutex_unlock(&btrfsic_mutex);
-
-	kvfree(state);
-}
diff --git a/fs/btrfs/check-integrity.h b/fs/btrfs/check-integrity.h
deleted file mode 100644
index 8c1648f1b745..000000000000
--- a/fs/btrfs/check-integrity.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) STRATO AG 2011.  All rights reserved.
- */
-
-#ifndef BTRFS_CHECK_INTEGRITY_H
-#define BTRFS_CHECK_INTEGRITY_H
-
-void btrfsic_unmount(struct btrfs_fs_devices *fs_devices);
-
-#endif
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index fff22ed55c42..53c1fbd3b590 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -17,7 +17,6 @@
 #include "print-tree.h"
 #include "volumes.h"
 #include "async-thread.h"
-#include "check-integrity.h"
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3a7b5f5c8ee9..728dab15d620 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -29,7 +29,6 @@
 #include "tree-log.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
-#include "check-integrity.h"
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "raid56.h"
@@ -4399,11 +4398,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	iput(fs_info->btree_inode);
 
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY))
-		btrfsic_unmount(fs_info->fs_devices);
-#endif
-
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 	btrfs_close_devices(fs_info->fs_devices);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac3fca5a5e41..27a5f9e0268e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -21,7 +21,6 @@
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "bio.h"
-#include "check-integrity.h"
 #include "locking.h"
 #include "rcu-string.h"
 #include "backref.h"
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b877203f1dc5..f16220ce5fba 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -16,7 +16,6 @@
 #include "backref.h"
 #include "extent_io.h"
 #include "dev-replace.h"
-#include "check-integrity.h"
 #include "raid56.h"
 #include "block-group.h"
 #include "zoned.h"
-- 
2.42.0

