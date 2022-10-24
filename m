Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C860BB4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiJXUzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiJXUyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:54:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081981A2E36
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 12:00:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t25so6674300qkm.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpdrboqRykhyAKsso2ouFK1XC39SbLPoBbdeXwxCSNk=;
        b=PdgodeWNPhCNKpFw7TvI2ZwKqNOsYdtATxkmcmdeFRrBqYitGC7IjA1q0KlPGMMsOZ
         QA9KYm4EZNhBFfsHprb0kUX9Pnb7EFf0J4LdXtTMGl8Qr/2OWZyNyHJMUKaEqY+e5ZtS
         HrwLUwGv2Hcg88DN5uAUciwvJXWEHvgofu6CUjwuh7q/sI/pTY62P7qvB8JKvBBg/4wJ
         9HI/T6nZKw5dW1HZgw0OVBZ5McwiDmcSxVJOPbBXXuMmGSjwR12Zc0YoZqk9s5u3JWIN
         UqxyuOvKbplMaKU4i6VzEjH/GqAVOqGheqr7ip5nmh7g5XnSzlretdaK1UHmPsgTtVmg
         GOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpdrboqRykhyAKsso2ouFK1XC39SbLPoBbdeXwxCSNk=;
        b=8KBXCprLwXMxk6TQhJzcivg6t35CIjn3DmWIN1cEoipP917wwoL8Ah06P/VLb5ukZw
         J2lqAE+05q2bqh6Q+k5rAWlJ7gOOzNEwBOXWwaAX0jEWjvWheIRBTxM8PHE5EWSLfKlX
         ngEOFCFtdeuCXUTvMtAAUo6BtWaquw9615kgGa7xbFSkAMjkyXS61oCbrwkX5Ha/2R5B
         G5A1qC0FNeAdvSrx7ohwRwt14ygmOqveyDsm20VQQ2/61KC80HGdj8ofTT/9Goej0Mxo
         ijPyjA4Qsm9AS9aypkbClpTV2SmTIozYEFN1lN2iAnhxOS/wgNrojzvowQAfb1UkgFj4
         zuDg==
X-Gm-Message-State: ACrzQf1E27JeoCAkbFZgn2iFwgiRcAr9szRwM5kj5IeQaIUo85MrQD47
        1tDpcztmYeLQc4UHa+qjhrh7/QhxrKjpuA==
X-Google-Smtp-Source: AMsMyM4lYy/JELTkm2RzRDNvh3uTDHyRfxIU1ITuHdeUhQpVY1Ntc4DPxeC4Dd890Ad2PPOs8QFZEg==
X-Received: by 2002:a05:620a:10a1:b0:6ed:3b23:6991 with SMTP id h1-20020a05620a10a100b006ed3b236991mr23289488qkk.683.1666637224078;
        Mon, 24 Oct 2022 11:47:04 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a444500b006e2d087fd63sm453784qkp.63.2022.10.24.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: move btrfs_fs_info declarations into fs.h
Date:   Mon, 24 Oct 2022 14:46:52 -0400
Message-Id: <4dcc1929125100d8117e463adca1c6b30f92ac51.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

Now that we have a lot of the fs_info related helpers and stuff
isolated, copy these over to fs.h out of ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 659 +----------------------------------------------
 fs/btrfs/fs.h    | 657 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 658 insertions(+), 658 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1da8f1579e4f..065137f0920f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -34,6 +34,7 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 #include "locking.h"
+#include "fs.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -51,25 +52,6 @@ struct btrfs_balance_control;
 struct btrfs_delayed_root;
 struct reloc_control;
 
-#define BTRFS_OLDEST_GENERATION	0ULL
-
-#define BTRFS_EMPTY_DIR_SIZE 0
-
-#define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
-
-#define BTRFS_MAX_EXTENT_SIZE SZ_128M
-
-#define BTRFS_SUPER_INFO_OFFSET			SZ_64K
-#define BTRFS_SUPER_INFO_SIZE			4096
-static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
-
-/*
- * The reserved space at the beginning of each device.
- * It covers the primary super block and leaves space for potential use by other
- * tools like bootloaders or to lower potential damage of accidental overwrite.
- */
-#define BTRFS_DEVICE_RANGE_RESERVED			(SZ_1M)
-
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
@@ -128,645 +110,6 @@ struct btrfs_path {
 	unsigned int nowait:1;
 };
 
-struct btrfs_dev_replace {
-	u64 replace_state;	/* see #define above */
-	time64_t time_started;	/* seconds since 1-Jan-1970 */
-	time64_t time_stopped;	/* seconds since 1-Jan-1970 */
-	atomic64_t num_write_errors;
-	atomic64_t num_uncorrectable_read_errors;
-
-	u64 cursor_left;
-	u64 committed_cursor_left;
-	u64 cursor_left_last_write_of_item;
-	u64 cursor_right;
-
-	u64 cont_reading_from_srcdev_mode;	/* see #define above */
-
-	int is_valid;
-	int item_needs_writeback;
-	struct btrfs_device *srcdev;
-	struct btrfs_device *tgtdev;
-
-	struct mutex lock_finishing_cancel_unmount;
-	struct rw_semaphore rwsem;
-
-	struct btrfs_scrub_progress scrub_progress;
-
-	struct percpu_counter bio_counter;
-	wait_queue_head_t replace_wait;
-};
-
-/*
- * free clusters are used to claim free space in relatively large chunks,
- * allowing us to do less seeky writes. They are used for all metadata
- * allocations. In ssd_spread mode they are also used for data allocations.
- */
-struct btrfs_free_cluster {
-	spinlock_t lock;
-	spinlock_t refill_lock;
-	struct rb_root root;
-
-	/* largest extent in this cluster */
-	u64 max_size;
-
-	/* first extent starting offset */
-	u64 window_start;
-
-	/* We did a full search and couldn't create a cluster */
-	bool fragmented;
-
-	struct btrfs_block_group *block_group;
-	/*
-	 * when a cluster is allocated from a block group, we put the
-	 * cluster onto a list in the block group so that it can
-	 * be freed before the block group is freed.
-	 */
-	struct list_head block_group_list;
-};
-
-/* Discard control. */
-/*
- * Async discard uses multiple lists to differentiate the discard filter
- * parameters.  Index 0 is for completely free block groups where we need to
- * ensure the entire block group is trimmed without being lossy.  Indices
- * afterwards represent monotonically decreasing discard filter sizes to
- * prioritize what should be discarded next.
- */
-#define BTRFS_NR_DISCARD_LISTS		3
-#define BTRFS_DISCARD_INDEX_UNUSED	0
-#define BTRFS_DISCARD_INDEX_START	1
-
-struct btrfs_discard_ctl {
-	struct workqueue_struct *discard_workers;
-	struct delayed_work work;
-	spinlock_t lock;
-	struct btrfs_block_group *block_group;
-	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
-	u64 prev_discard;
-	u64 prev_discard_time;
-	atomic_t discardable_extents;
-	atomic64_t discardable_bytes;
-	u64 max_discard_size;
-	u64 delay_ms;
-	u32 iops_limit;
-	u32 kbps_limit;
-	u64 discard_extent_bytes;
-	u64 discard_bitmap_bytes;
-	atomic64_t discard_bytes_saved;
-};
-
-/*
- * Exclusive operations (device replace, resize, device add/remove, balance)
- */
-enum btrfs_exclusive_operation {
-	BTRFS_EXCLOP_NONE,
-	BTRFS_EXCLOP_BALANCE_PAUSED,
-	BTRFS_EXCLOP_BALANCE,
-	BTRFS_EXCLOP_DEV_ADD,
-	BTRFS_EXCLOP_DEV_REMOVE,
-	BTRFS_EXCLOP_DEV_REPLACE,
-	BTRFS_EXCLOP_RESIZE,
-	BTRFS_EXCLOP_SWAP_ACTIVATE,
-};
-
-/* Store data about transaction commits, exported via sysfs. */
-struct btrfs_commit_stats {
-	/* Total number of commits */
-	u64 commit_count;
-	/* The maximum commit duration so far in ns */
-	u64 max_commit_dur;
-	/* The last commit duration in ns */
-	u64 last_commit_dur;
-	/* The total commit duration in ns */
-	u64 total_commit_dur;
-};
-
-struct btrfs_fs_info {
-	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
-	unsigned long flags;
-	struct btrfs_root *tree_root;
-	struct btrfs_root *chunk_root;
-	struct btrfs_root *dev_root;
-	struct btrfs_root *fs_root;
-	struct btrfs_root *quota_root;
-	struct btrfs_root *uuid_root;
-	struct btrfs_root *data_reloc_root;
-	struct btrfs_root *block_group_root;
-
-	/* the log root tree is a directory of all the other log roots */
-	struct btrfs_root *log_root_tree;
-
-	/* The tree that holds the global roots (csum, extent, etc) */
-	rwlock_t global_root_lock;
-	struct rb_root global_root_tree;
-
-	spinlock_t fs_roots_radix_lock;
-	struct radix_tree_root fs_roots_radix;
-
-	/* block group cache stuff */
-	rwlock_t block_group_cache_lock;
-	struct rb_root_cached block_group_cache_tree;
-
-	/* keep track of unallocated space */
-	atomic64_t free_chunk_space;
-
-	/* Track ranges which are used by log trees blocks/logged data extents */
-	struct extent_io_tree excluded_extents;
-
-	/* logical->physical extent mapping */
-	struct extent_map_tree mapping_tree;
-
-	/*
-	 * block reservation for extent, checksum, root tree and
-	 * delayed dir index item
-	 */
-	struct btrfs_block_rsv global_block_rsv;
-	/* block reservation for metadata operations */
-	struct btrfs_block_rsv trans_block_rsv;
-	/* block reservation for chunk tree */
-	struct btrfs_block_rsv chunk_block_rsv;
-	/* block reservation for delayed operations */
-	struct btrfs_block_rsv delayed_block_rsv;
-	/* block reservation for delayed refs */
-	struct btrfs_block_rsv delayed_refs_rsv;
-
-	struct btrfs_block_rsv empty_block_rsv;
-
-	u64 generation;
-	u64 last_trans_committed;
-	/*
-	 * Generation of the last transaction used for block group relocation
-	 * since the filesystem was last mounted (or 0 if none happened yet).
-	 * Must be written and read while holding btrfs_fs_info::commit_root_sem.
-	 */
-	u64 last_reloc_trans;
-	u64 avg_delayed_ref_runtime;
-
-	/*
-	 * this is updated to the current trans every time a full commit
-	 * is required instead of the faster short fsync log commits
-	 */
-	u64 last_trans_log_full_commit;
-	unsigned long mount_opt;
-
-	unsigned long compress_type:4;
-	unsigned int compress_level;
-	u32 commit_interval;
-	/*
-	 * It is a suggestive number, the read side is safe even it gets a
-	 * wrong number because we will write out the data into a regular
-	 * extent. The write side(mount/remount) is under ->s_umount lock,
-	 * so it is also safe.
-	 */
-	u64 max_inline;
-
-	struct btrfs_transaction *running_transaction;
-	wait_queue_head_t transaction_throttle;
-	wait_queue_head_t transaction_wait;
-	wait_queue_head_t transaction_blocked_wait;
-	wait_queue_head_t async_submit_wait;
-
-	/*
-	 * Used to protect the incompat_flags, compat_flags, compat_ro_flags
-	 * when they are updated.
-	 *
-	 * Because we do not clear the flags for ever, so we needn't use
-	 * the lock on the read side.
-	 *
-	 * We also needn't use the lock when we mount the fs, because
-	 * there is no other task which will update the flag.
-	 */
-	spinlock_t super_lock;
-	struct btrfs_super_block *super_copy;
-	struct btrfs_super_block *super_for_commit;
-	struct super_block *sb;
-	struct inode *btree_inode;
-	struct mutex tree_log_mutex;
-	struct mutex transaction_kthread_mutex;
-	struct mutex cleaner_mutex;
-	struct mutex chunk_mutex;
-
-	/*
-	 * this is taken to make sure we don't set block groups ro after
-	 * the free space cache has been allocated on them
-	 */
-	struct mutex ro_block_group_mutex;
-
-	/* this is used during read/modify/write to make sure
-	 * no two ios are trying to mod the same stripe at the same
-	 * time
-	 */
-	struct btrfs_stripe_hash_table *stripe_hash_table;
-
-	/*
-	 * this protects the ordered operations list only while we are
-	 * processing all of the entries on it.  This way we make
-	 * sure the commit code doesn't find the list temporarily empty
-	 * because another function happens to be doing non-waiting preflush
-	 * before jumping into the main commit.
-	 */
-	struct mutex ordered_operations_mutex;
-
-	struct rw_semaphore commit_root_sem;
-
-	struct rw_semaphore cleanup_work_sem;
-
-	struct rw_semaphore subvol_sem;
-
-	spinlock_t trans_lock;
-	/*
-	 * the reloc mutex goes with the trans lock, it is taken
-	 * during commit to protect us from the relocation code
-	 */
-	struct mutex reloc_mutex;
-
-	struct list_head trans_list;
-	struct list_head dead_roots;
-	struct list_head caching_block_groups;
-
-	spinlock_t delayed_iput_lock;
-	struct list_head delayed_iputs;
-	atomic_t nr_delayed_iputs;
-	wait_queue_head_t delayed_iputs_wait;
-
-	atomic64_t tree_mod_seq;
-
-	/* this protects tree_mod_log and tree_mod_seq_list */
-	rwlock_t tree_mod_log_lock;
-	struct rb_root tree_mod_log;
-	struct list_head tree_mod_seq_list;
-
-	atomic_t async_delalloc_pages;
-
-	/*
-	 * this is used to protect the following list -- ordered_roots.
-	 */
-	spinlock_t ordered_root_lock;
-
-	/*
-	 * all fs/file tree roots in which there are data=ordered extents
-	 * pending writeback are added into this list.
-	 *
-	 * these can span multiple transactions and basically include
-	 * every dirty data page that isn't from nodatacow
-	 */
-	struct list_head ordered_roots;
-
-	struct mutex delalloc_root_mutex;
-	spinlock_t delalloc_root_lock;
-	/* all fs/file tree roots that have delalloc inodes. */
-	struct list_head delalloc_roots;
-
-	/*
-	 * there is a pool of worker threads for checksumming during writes
-	 * and a pool for checksumming after reads.  This is because readers
-	 * can run with FS locks held, and the writers may be waiting for
-	 * those locks.  We don't want ordering in the pending list to cause
-	 * deadlocks, and so the two are serviced separately.
-	 *
-	 * A third pool does submit_bio to avoid deadlocking with the other
-	 * two
-	 */
-	struct btrfs_workqueue *workers;
-	struct btrfs_workqueue *hipri_workers;
-	struct btrfs_workqueue *delalloc_workers;
-	struct btrfs_workqueue *flush_workers;
-	struct workqueue_struct *endio_workers;
-	struct workqueue_struct *endio_meta_workers;
-	struct workqueue_struct *endio_raid56_workers;
-	struct workqueue_struct *rmw_workers;
-	struct workqueue_struct *compressed_write_workers;
-	struct btrfs_workqueue *endio_write_workers;
-	struct btrfs_workqueue *endio_freespace_worker;
-	struct btrfs_workqueue *caching_workers;
-
-	/*
-	 * fixup workers take dirty pages that didn't properly go through
-	 * the cow mechanism and make them safe to write.  It happens
-	 * for the sys_munmap function call path
-	 */
-	struct btrfs_workqueue *fixup_workers;
-	struct btrfs_workqueue *delayed_workers;
-
-	struct task_struct *transaction_kthread;
-	struct task_struct *cleaner_kthread;
-	u32 thread_pool_size;
-
-	struct kobject *space_info_kobj;
-	struct kobject *qgroups_kobj;
-	struct kobject *discard_kobj;
-
-	/* used to keep from writing metadata until there is a nice batch */
-	struct percpu_counter dirty_metadata_bytes;
-	struct percpu_counter delalloc_bytes;
-	struct percpu_counter ordered_bytes;
-	s32 dirty_metadata_batch;
-	s32 delalloc_batch;
-
-	struct list_head dirty_cowonly_roots;
-
-	struct btrfs_fs_devices *fs_devices;
-
-	/*
-	 * The space_info list is effectively read only after initial
-	 * setup.  It is populated at mount time and cleaned up after
-	 * all block groups are removed.  RCU is used to protect it.
-	 */
-	struct list_head space_info;
-
-	struct btrfs_space_info *data_sinfo;
-
-	struct reloc_control *reloc_ctl;
-
-	/* data_alloc_cluster is only used in ssd_spread mode */
-	struct btrfs_free_cluster data_alloc_cluster;
-
-	/* all metadata allocations go through this cluster */
-	struct btrfs_free_cluster meta_alloc_cluster;
-
-	/* auto defrag inodes go here */
-	spinlock_t defrag_inodes_lock;
-	struct rb_root defrag_inodes;
-	atomic_t defrag_running;
-
-	/* Used to protect avail_{data, metadata, system}_alloc_bits */
-	seqlock_t profiles_lock;
-	/*
-	 * these three are in extended format (availability of single
-	 * chunks is denoted by BTRFS_AVAIL_ALLOC_BIT_SINGLE bit, other
-	 * types are denoted by corresponding BTRFS_BLOCK_GROUP_* bits)
-	 */
-	u64 avail_data_alloc_bits;
-	u64 avail_metadata_alloc_bits;
-	u64 avail_system_alloc_bits;
-
-	/* restriper state */
-	spinlock_t balance_lock;
-	struct mutex balance_mutex;
-	atomic_t balance_pause_req;
-	atomic_t balance_cancel_req;
-	struct btrfs_balance_control *balance_ctl;
-	wait_queue_head_t balance_wait_q;
-
-	/* Cancellation requests for chunk relocation */
-	atomic_t reloc_cancel_req;
-
-	u32 data_chunk_allocations;
-	u32 metadata_ratio;
-
-	void *bdev_holder;
-
-	/* private scrub information */
-	struct mutex scrub_lock;
-	atomic_t scrubs_running;
-	atomic_t scrub_pause_req;
-	atomic_t scrubs_paused;
-	atomic_t scrub_cancel_req;
-	wait_queue_head_t scrub_pause_wait;
-	/*
-	 * The worker pointers are NULL iff the refcount is 0, ie. scrub is not
-	 * running.
-	 */
-	refcount_t scrub_workers_refcnt;
-	struct workqueue_struct *scrub_workers;
-	struct workqueue_struct *scrub_wr_completion_workers;
-	struct workqueue_struct *scrub_parity_workers;
-	struct btrfs_subpage_info *subpage_info;
-
-	struct btrfs_discard_ctl discard_ctl;
-
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	u32 check_integrity_print_mask;
-#endif
-	/* is qgroup tracking in a consistent state? */
-	u64 qgroup_flags;
-
-	/* holds configuration and tracking. Protected by qgroup_lock */
-	struct rb_root qgroup_tree;
-	spinlock_t qgroup_lock;
-
-	/*
-	 * used to avoid frequently calling ulist_alloc()/ulist_free()
-	 * when doing qgroup accounting, it must be protected by qgroup_lock.
-	 */
-	struct ulist *qgroup_ulist;
-
-	/*
-	 * Protect user change for quota operations. If a transaction is needed,
-	 * it must be started before locking this lock.
-	 */
-	struct mutex qgroup_ioctl_lock;
-
-	/* list of dirty qgroups to be written at next commit */
-	struct list_head dirty_qgroups;
-
-	/* used by qgroup for an efficient tree traversal */
-	u64 qgroup_seq;
-
-	/* qgroup rescan items */
-	struct mutex qgroup_rescan_lock; /* protects the progress item */
-	struct btrfs_key qgroup_rescan_progress;
-	struct btrfs_workqueue *qgroup_rescan_workers;
-	struct completion qgroup_rescan_completion;
-	struct btrfs_work qgroup_rescan_work;
-	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
-	u8 qgroup_drop_subtree_thres;
-
-	/* filesystem state */
-	unsigned long fs_state;
-
-	struct btrfs_delayed_root *delayed_root;
-
-	/* Extent buffer radix tree */
-	spinlock_t buffer_lock;
-	/* Entries are eb->start / sectorsize */
-	struct radix_tree_root buffer_radix;
-
-	/* next backup root to be overwritten */
-	int backup_root_index;
-
-	/* device replace state */
-	struct btrfs_dev_replace dev_replace;
-
-	struct semaphore uuid_tree_rescan_sem;
-
-	/* Used to reclaim the metadata space in the background. */
-	struct work_struct async_reclaim_work;
-	struct work_struct async_data_reclaim_work;
-	struct work_struct preempt_reclaim_work;
-
-	/* Reclaim partially filled block groups in the background */
-	struct work_struct reclaim_bgs_work;
-	struct list_head reclaim_bgs;
-	int bg_reclaim_threshold;
-
-	spinlock_t unused_bgs_lock;
-	struct list_head unused_bgs;
-	struct mutex unused_bg_unpin_mutex;
-	/* Protect block groups that are going to be deleted */
-	struct mutex reclaim_bgs_lock;
-
-	/* Cached block sizes */
-	u32 nodesize;
-	u32 sectorsize;
-	/* ilog2 of sectorsize, use to avoid 64bit division */
-	u32 sectorsize_bits;
-	u32 csum_size;
-	u32 csums_per_leaf;
-	u32 stripesize;
-
-	/*
-	 * Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular
-	 * filesystem, on zoned it depends on the device constraints.
-	 */
-	u64 max_extent_size;
-
-	/* Block groups and devices containing active swapfiles. */
-	spinlock_t swapfile_pins_lock;
-	struct rb_root swapfile_pins;
-
-	struct crypto_shash *csum_shash;
-
-	/* Type of exclusive operation running, protected by super_lock */
-	enum btrfs_exclusive_operation exclusive_operation;
-
-	/*
-	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
-	 * if the mode is enabled
-	 */
-	u64 zone_size;
-
-	/* Max size to emit ZONE_APPEND write command */
-	u64 max_zone_append_size;
-	struct mutex zoned_meta_io_lock;
-	spinlock_t treelog_bg_lock;
-	u64 treelog_bg;
-
-	/*
-	 * Start of the dedicated data relocation block group, protected by
-	 * relocation_bg_lock.
-	 */
-	spinlock_t relocation_bg_lock;
-	u64 data_reloc_bg;
-	struct mutex zoned_data_reloc_io_lock;
-
-	u64 nr_global_roots;
-
-	spinlock_t zone_active_bgs_lock;
-	struct list_head zone_active_bgs;
-
-	/* Updates are not protected by any lock */
-	struct btrfs_commit_stats commit_stats;
-
-	/*
-	 * Last generation where we dropped a non-relocation root.
-	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
-	 * to change it and to read it, respectively.
-	 */
-	u64 last_root_drop_gen;
-
-	/*
-	 * Annotations for transaction events (structures are empty when
-	 * compiled without lockdep).
-	 */
-	struct lockdep_map btrfs_trans_num_writers_map;
-	struct lockdep_map btrfs_trans_num_extwriters_map;
-	struct lockdep_map btrfs_state_change_map[4];
-	struct lockdep_map btrfs_trans_pending_ordered_map;
-	struct lockdep_map btrfs_ordered_extent_map;
-
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	spinlock_t ref_verify_lock;
-	struct rb_root block_tree;
-#endif
-
-#ifdef CONFIG_BTRFS_DEBUG
-	struct kobject *debug_kobj;
-	struct list_head allocated_roots;
-
-	spinlock_t eb_leak_lock;
-	struct list_head allocated_ebs;
-#endif
-};
-
-static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
-						u64 gen)
-{
-	WRITE_ONCE(fs_info->last_root_drop_gen, gen);
-}
-
-static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_info *fs_info)
-{
-	return READ_ONCE(fs_info->last_root_drop_gen);
-}
-
-static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-/*
- * Take the number of bytes to be checksummed and figure out how many leaves
- * it would require to store the csums for that many bytes.
- */
-static inline u64 btrfs_csum_bytes_to_leaves(
-			const struct btrfs_fs_info *fs_info, u64 csum_bytes)
-{
-	const u64 num_csums = csum_bytes >> fs_info->sectorsize_bits;
-
-	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
-}
-
-/*
- * Use this if we would be adding new items, as we could split nodes as we cow
- * down the tree.
- */
-static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
-						  unsigned num_items)
-{
-	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
-}
-
-/*
- * Doing a truncate or a modification won't result in new nodes or leaves, just
- * what we need for COW.
- */
-static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
-						 unsigned num_items)
-{
-	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
-}
-
-#define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
-					sizeof(struct btrfs_item))
-
-static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
-{
-	return fs_info->zone_size > 0;
-}
-
-/*
- * Count how many fs_info->max_extent_size cover the @size
- */
-static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
-{
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-	if (!fs_info)
-		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
-#endif
-
-	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
-}
-
-bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
-			enum btrfs_exclusive_operation type);
-bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
-				 enum btrfs_exclusive_operation type);
-void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
-void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
-void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
-			  enum btrfs_exclusive_operation op);
-
 /*
  * The state of btrfs root
  */
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ac223da28576..9956565f9e37 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,24 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#define BTRFS_MAX_EXTENT_SIZE SZ_128M
+
+#define BTRFS_OLDEST_GENERATION	0ULL
+
+#define BTRFS_EMPTY_DIR_SIZE 0
+
+#define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
+
+#define BTRFS_SUPER_INFO_OFFSET			SZ_64K
+#define BTRFS_SUPER_INFO_SIZE			4096
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
+
+/*
+ * The reserved space at the beginning of each device.
+ * It covers the primary super block and leaves space for potential use by other
+ * tools like bootloaders or to lower potential damage of accidental overwrite.
+ */
+#define BTRFS_DEVICE_RANGE_RESERVED			(SZ_1M)
 /*
  * Runtime (in-memory) states of filesystem
  */
@@ -199,6 +217,645 @@ enum {
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
+struct btrfs_dev_replace {
+	u64 replace_state;	/* see #define above */
+	time64_t time_started;	/* seconds since 1-Jan-1970 */
+	time64_t time_stopped;	/* seconds since 1-Jan-1970 */
+	atomic64_t num_write_errors;
+	atomic64_t num_uncorrectable_read_errors;
+
+	u64 cursor_left;
+	u64 committed_cursor_left;
+	u64 cursor_left_last_write_of_item;
+	u64 cursor_right;
+
+	u64 cont_reading_from_srcdev_mode;	/* see #define above */
+
+	int is_valid;
+	int item_needs_writeback;
+	struct btrfs_device *srcdev;
+	struct btrfs_device *tgtdev;
+
+	struct mutex lock_finishing_cancel_unmount;
+	struct rw_semaphore rwsem;
+
+	struct btrfs_scrub_progress scrub_progress;
+
+	struct percpu_counter bio_counter;
+	wait_queue_head_t replace_wait;
+};
+
+/*
+ * free clusters are used to claim free space in relatively large chunks,
+ * allowing us to do less seeky writes. They are used for all metadata
+ * allocations. In ssd_spread mode they are also used for data allocations.
+ */
+struct btrfs_free_cluster {
+	spinlock_t lock;
+	spinlock_t refill_lock;
+	struct rb_root root;
+
+	/* largest extent in this cluster */
+	u64 max_size;
+
+	/* first extent starting offset */
+	u64 window_start;
+
+	/* We did a full search and couldn't create a cluster */
+	bool fragmented;
+
+	struct btrfs_block_group *block_group;
+	/*
+	 * when a cluster is allocated from a block group, we put the
+	 * cluster onto a list in the block group so that it can
+	 * be freed before the block group is freed.
+	 */
+	struct list_head block_group_list;
+};
+
+/* Discard control. */
+/*
+ * Async discard uses multiple lists to differentiate the discard filter
+ * parameters.  Index 0 is for completely free block groups where we need to
+ * ensure the entire block group is trimmed without being lossy.  Indices
+ * afterwards represent monotonically decreasing discard filter sizes to
+ * prioritize what should be discarded next.
+ */
+#define BTRFS_NR_DISCARD_LISTS		3
+#define BTRFS_DISCARD_INDEX_UNUSED	0
+#define BTRFS_DISCARD_INDEX_START	1
+
+struct btrfs_discard_ctl {
+	struct workqueue_struct *discard_workers;
+	struct delayed_work work;
+	spinlock_t lock;
+	struct btrfs_block_group *block_group;
+	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	u64 prev_discard;
+	u64 prev_discard_time;
+	atomic_t discardable_extents;
+	atomic64_t discardable_bytes;
+	u64 max_discard_size;
+	u64 delay_ms;
+	u32 iops_limit;
+	u32 kbps_limit;
+	u64 discard_extent_bytes;
+	u64 discard_bitmap_bytes;
+	atomic64_t discard_bytes_saved;
+};
+
+/*
+ * Exclusive operations (device replace, resize, device add/remove, balance)
+ */
+enum btrfs_exclusive_operation {
+	BTRFS_EXCLOP_NONE,
+	BTRFS_EXCLOP_BALANCE_PAUSED,
+	BTRFS_EXCLOP_BALANCE,
+	BTRFS_EXCLOP_DEV_ADD,
+	BTRFS_EXCLOP_DEV_REMOVE,
+	BTRFS_EXCLOP_DEV_REPLACE,
+	BTRFS_EXCLOP_RESIZE,
+	BTRFS_EXCLOP_SWAP_ACTIVATE,
+};
+
+/* Store data about transaction commits, exported via sysfs. */
+struct btrfs_commit_stats {
+	/* Total number of commits */
+	u64 commit_count;
+	/* The maximum commit duration so far in ns */
+	u64 max_commit_dur;
+	/* The last commit duration in ns */
+	u64 last_commit_dur;
+	/* The total commit duration in ns */
+	u64 total_commit_dur;
+};
+
+struct btrfs_fs_info {
+	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	unsigned long flags;
+	struct btrfs_root *tree_root;
+	struct btrfs_root *chunk_root;
+	struct btrfs_root *dev_root;
+	struct btrfs_root *fs_root;
+	struct btrfs_root *quota_root;
+	struct btrfs_root *uuid_root;
+	struct btrfs_root *data_reloc_root;
+	struct btrfs_root *block_group_root;
+
+	/* the log root tree is a directory of all the other log roots */
+	struct btrfs_root *log_root_tree;
+
+	/* The tree that holds the global roots (csum, extent, etc) */
+	rwlock_t global_root_lock;
+	struct rb_root global_root_tree;
+
+	spinlock_t fs_roots_radix_lock;
+	struct radix_tree_root fs_roots_radix;
+
+	/* block group cache stuff */
+	rwlock_t block_group_cache_lock;
+	struct rb_root_cached block_group_cache_tree;
+
+	/* keep track of unallocated space */
+	atomic64_t free_chunk_space;
+
+	/* Track ranges which are used by log trees blocks/logged data extents */
+	struct extent_io_tree excluded_extents;
+
+	/* logical->physical extent mapping */
+	struct extent_map_tree mapping_tree;
+
+	/*
+	 * block reservation for extent, checksum, root tree and
+	 * delayed dir index item
+	 */
+	struct btrfs_block_rsv global_block_rsv;
+	/* block reservation for metadata operations */
+	struct btrfs_block_rsv trans_block_rsv;
+	/* block reservation for chunk tree */
+	struct btrfs_block_rsv chunk_block_rsv;
+	/* block reservation for delayed operations */
+	struct btrfs_block_rsv delayed_block_rsv;
+	/* block reservation for delayed refs */
+	struct btrfs_block_rsv delayed_refs_rsv;
+
+	struct btrfs_block_rsv empty_block_rsv;
+
+	u64 generation;
+	u64 last_trans_committed;
+	/*
+	 * Generation of the last transaction used for block group relocation
+	 * since the filesystem was last mounted (or 0 if none happened yet).
+	 * Must be written and read while holding btrfs_fs_info::commit_root_sem.
+	 */
+	u64 last_reloc_trans;
+	u64 avg_delayed_ref_runtime;
+
+	/*
+	 * this is updated to the current trans every time a full commit
+	 * is required instead of the faster short fsync log commits
+	 */
+	u64 last_trans_log_full_commit;
+	unsigned long mount_opt;
+
+	unsigned long compress_type:4;
+	unsigned int compress_level;
+	u32 commit_interval;
+	/*
+	 * It is a suggestive number, the read side is safe even it gets a
+	 * wrong number because we will write out the data into a regular
+	 * extent. The write side(mount/remount) is under ->s_umount lock,
+	 * so it is also safe.
+	 */
+	u64 max_inline;
+
+	struct btrfs_transaction *running_transaction;
+	wait_queue_head_t transaction_throttle;
+	wait_queue_head_t transaction_wait;
+	wait_queue_head_t transaction_blocked_wait;
+	wait_queue_head_t async_submit_wait;
+
+	/*
+	 * Used to protect the incompat_flags, compat_flags, compat_ro_flags
+	 * when they are updated.
+	 *
+	 * Because we do not clear the flags for ever, so we needn't use
+	 * the lock on the read side.
+	 *
+	 * We also needn't use the lock when we mount the fs, because
+	 * there is no other task which will update the flag.
+	 */
+	spinlock_t super_lock;
+	struct btrfs_super_block *super_copy;
+	struct btrfs_super_block *super_for_commit;
+	struct super_block *sb;
+	struct inode *btree_inode;
+	struct mutex tree_log_mutex;
+	struct mutex transaction_kthread_mutex;
+	struct mutex cleaner_mutex;
+	struct mutex chunk_mutex;
+
+	/*
+	 * this is taken to make sure we don't set block groups ro after
+	 * the free space cache has been allocated on them
+	 */
+	struct mutex ro_block_group_mutex;
+
+	/* this is used during read/modify/write to make sure
+	 * no two ios are trying to mod the same stripe at the same
+	 * time
+	 */
+	struct btrfs_stripe_hash_table *stripe_hash_table;
+
+	/*
+	 * this protects the ordered operations list only while we are
+	 * processing all of the entries on it.  This way we make
+	 * sure the commit code doesn't find the list temporarily empty
+	 * because another function happens to be doing non-waiting preflush
+	 * before jumping into the main commit.
+	 */
+	struct mutex ordered_operations_mutex;
+
+	struct rw_semaphore commit_root_sem;
+
+	struct rw_semaphore cleanup_work_sem;
+
+	struct rw_semaphore subvol_sem;
+
+	spinlock_t trans_lock;
+	/*
+	 * the reloc mutex goes with the trans lock, it is taken
+	 * during commit to protect us from the relocation code
+	 */
+	struct mutex reloc_mutex;
+
+	struct list_head trans_list;
+	struct list_head dead_roots;
+	struct list_head caching_block_groups;
+
+	spinlock_t delayed_iput_lock;
+	struct list_head delayed_iputs;
+	atomic_t nr_delayed_iputs;
+	wait_queue_head_t delayed_iputs_wait;
+
+	atomic64_t tree_mod_seq;
+
+	/* this protects tree_mod_log and tree_mod_seq_list */
+	rwlock_t tree_mod_log_lock;
+	struct rb_root tree_mod_log;
+	struct list_head tree_mod_seq_list;
+
+	atomic_t async_delalloc_pages;
+
+	/*
+	 * this is used to protect the following list -- ordered_roots.
+	 */
+	spinlock_t ordered_root_lock;
+
+	/*
+	 * all fs/file tree roots in which there are data=ordered extents
+	 * pending writeback are added into this list.
+	 *
+	 * these can span multiple transactions and basically include
+	 * every dirty data page that isn't from nodatacow
+	 */
+	struct list_head ordered_roots;
+
+	struct mutex delalloc_root_mutex;
+	spinlock_t delalloc_root_lock;
+	/* all fs/file tree roots that have delalloc inodes. */
+	struct list_head delalloc_roots;
+
+	/*
+	 * there is a pool of worker threads for checksumming during writes
+	 * and a pool for checksumming after reads.  This is because readers
+	 * can run with FS locks held, and the writers may be waiting for
+	 * those locks.  We don't want ordering in the pending list to cause
+	 * deadlocks, and so the two are serviced separately.
+	 *
+	 * A third pool does submit_bio to avoid deadlocking with the other
+	 * two
+	 */
+	struct btrfs_workqueue *workers;
+	struct btrfs_workqueue *hipri_workers;
+	struct btrfs_workqueue *delalloc_workers;
+	struct btrfs_workqueue *flush_workers;
+	struct workqueue_struct *endio_workers;
+	struct workqueue_struct *endio_meta_workers;
+	struct workqueue_struct *endio_raid56_workers;
+	struct workqueue_struct *rmw_workers;
+	struct workqueue_struct *compressed_write_workers;
+	struct btrfs_workqueue *endio_write_workers;
+	struct btrfs_workqueue *endio_freespace_worker;
+	struct btrfs_workqueue *caching_workers;
+
+	/*
+	 * fixup workers take dirty pages that didn't properly go through
+	 * the cow mechanism and make them safe to write.  It happens
+	 * for the sys_munmap function call path
+	 */
+	struct btrfs_workqueue *fixup_workers;
+	struct btrfs_workqueue *delayed_workers;
+
+	struct task_struct *transaction_kthread;
+	struct task_struct *cleaner_kthread;
+	u32 thread_pool_size;
+
+	struct kobject *space_info_kobj;
+	struct kobject *qgroups_kobj;
+	struct kobject *discard_kobj;
+
+	/* used to keep from writing metadata until there is a nice batch */
+	struct percpu_counter dirty_metadata_bytes;
+	struct percpu_counter delalloc_bytes;
+	struct percpu_counter ordered_bytes;
+	s32 dirty_metadata_batch;
+	s32 delalloc_batch;
+
+	struct list_head dirty_cowonly_roots;
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * The space_info list is effectively read only after initial
+	 * setup.  It is populated at mount time and cleaned up after
+	 * all block groups are removed.  RCU is used to protect it.
+	 */
+	struct list_head space_info;
+
+	struct btrfs_space_info *data_sinfo;
+
+	struct reloc_control *reloc_ctl;
+
+	/* data_alloc_cluster is only used in ssd_spread mode */
+	struct btrfs_free_cluster data_alloc_cluster;
+
+	/* all metadata allocations go through this cluster */
+	struct btrfs_free_cluster meta_alloc_cluster;
+
+	/* auto defrag inodes go here */
+	spinlock_t defrag_inodes_lock;
+	struct rb_root defrag_inodes;
+	atomic_t defrag_running;
+
+	/* Used to protect avail_{data, metadata, system}_alloc_bits */
+	seqlock_t profiles_lock;
+	/*
+	 * these three are in extended format (availability of single
+	 * chunks is denoted by BTRFS_AVAIL_ALLOC_BIT_SINGLE bit, other
+	 * types are denoted by corresponding BTRFS_BLOCK_GROUP_* bits)
+	 */
+	u64 avail_data_alloc_bits;
+	u64 avail_metadata_alloc_bits;
+	u64 avail_system_alloc_bits;
+
+	/* restriper state */
+	spinlock_t balance_lock;
+	struct mutex balance_mutex;
+	atomic_t balance_pause_req;
+	atomic_t balance_cancel_req;
+	struct btrfs_balance_control *balance_ctl;
+	wait_queue_head_t balance_wait_q;
+
+	/* Cancellation requests for chunk relocation */
+	atomic_t reloc_cancel_req;
+
+	u32 data_chunk_allocations;
+	u32 metadata_ratio;
+
+	void *bdev_holder;
+
+	/* private scrub information */
+	struct mutex scrub_lock;
+	atomic_t scrubs_running;
+	atomic_t scrub_pause_req;
+	atomic_t scrubs_paused;
+	atomic_t scrub_cancel_req;
+	wait_queue_head_t scrub_pause_wait;
+	/*
+	 * The worker pointers are NULL iff the refcount is 0, ie. scrub is not
+	 * running.
+	 */
+	refcount_t scrub_workers_refcnt;
+	struct workqueue_struct *scrub_workers;
+	struct workqueue_struct *scrub_wr_completion_workers;
+	struct workqueue_struct *scrub_parity_workers;
+	struct btrfs_subpage_info *subpage_info;
+
+	struct btrfs_discard_ctl discard_ctl;
+
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	u32 check_integrity_print_mask;
+#endif
+	/* is qgroup tracking in a consistent state? */
+	u64 qgroup_flags;
+
+	/* holds configuration and tracking. Protected by qgroup_lock */
+	struct rb_root qgroup_tree;
+	spinlock_t qgroup_lock;
+
+	/*
+	 * used to avoid frequently calling ulist_alloc()/ulist_free()
+	 * when doing qgroup accounting, it must be protected by qgroup_lock.
+	 */
+	struct ulist *qgroup_ulist;
+
+	/*
+	 * Protect user change for quota operations. If a transaction is needed,
+	 * it must be started before locking this lock.
+	 */
+	struct mutex qgroup_ioctl_lock;
+
+	/* list of dirty qgroups to be written at next commit */
+	struct list_head dirty_qgroups;
+
+	/* used by qgroup for an efficient tree traversal */
+	u64 qgroup_seq;
+
+	/* qgroup rescan items */
+	struct mutex qgroup_rescan_lock; /* protects the progress item */
+	struct btrfs_key qgroup_rescan_progress;
+	struct btrfs_workqueue *qgroup_rescan_workers;
+	struct completion qgroup_rescan_completion;
+	struct btrfs_work qgroup_rescan_work;
+	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
+	u8 qgroup_drop_subtree_thres;
+
+	/* filesystem state */
+	unsigned long fs_state;
+
+	struct btrfs_delayed_root *delayed_root;
+
+	/* Extent buffer radix tree */
+	spinlock_t buffer_lock;
+	/* Entries are eb->start / sectorsize */
+	struct radix_tree_root buffer_radix;
+
+	/* next backup root to be overwritten */
+	int backup_root_index;
+
+	/* device replace state */
+	struct btrfs_dev_replace dev_replace;
+
+	struct semaphore uuid_tree_rescan_sem;
+
+	/* Used to reclaim the metadata space in the background. */
+	struct work_struct async_reclaim_work;
+	struct work_struct async_data_reclaim_work;
+	struct work_struct preempt_reclaim_work;
+
+	/* Reclaim partially filled block groups in the background */
+	struct work_struct reclaim_bgs_work;
+	struct list_head reclaim_bgs;
+	int bg_reclaim_threshold;
+
+	spinlock_t unused_bgs_lock;
+	struct list_head unused_bgs;
+	struct mutex unused_bg_unpin_mutex;
+	/* Protect block groups that are going to be deleted */
+	struct mutex reclaim_bgs_lock;
+
+	/* Cached block sizes */
+	u32 nodesize;
+	u32 sectorsize;
+	/* ilog2 of sectorsize, use to avoid 64bit division */
+	u32 sectorsize_bits;
+	u32 csum_size;
+	u32 csums_per_leaf;
+	u32 stripesize;
+
+	/*
+	 * Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular
+	 * filesystem, on zoned it depends on the device constraints.
+	 */
+	u64 max_extent_size;
+
+	/* Block groups and devices containing active swapfiles. */
+	spinlock_t swapfile_pins_lock;
+	struct rb_root swapfile_pins;
+
+	struct crypto_shash *csum_shash;
+
+	/* Type of exclusive operation running, protected by super_lock */
+	enum btrfs_exclusive_operation exclusive_operation;
+
+	/*
+	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
+	 * if the mode is enabled
+	 */
+	u64 zone_size;
+
+	/* Max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
+	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
+
+	/*
+	 * Start of the dedicated data relocation block group, protected by
+	 * relocation_bg_lock.
+	 */
+	spinlock_t relocation_bg_lock;
+	u64 data_reloc_bg;
+	struct mutex zoned_data_reloc_io_lock;
+
+	u64 nr_global_roots;
+
+	spinlock_t zone_active_bgs_lock;
+	struct list_head zone_active_bgs;
+
+	/* Updates are not protected by any lock */
+	struct btrfs_commit_stats commit_stats;
+
+	/*
+	 * Last generation where we dropped a non-relocation root.
+	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
+	 * to change it and to read it, respectively.
+	 */
+	u64 last_root_drop_gen;
+
+	/*
+	 * Annotations for transaction events (structures are empty when
+	 * compiled without lockdep).
+	 */
+	struct lockdep_map btrfs_trans_num_writers_map;
+	struct lockdep_map btrfs_trans_num_extwriters_map;
+	struct lockdep_map btrfs_state_change_map[4];
+	struct lockdep_map btrfs_trans_pending_ordered_map;
+	struct lockdep_map btrfs_ordered_extent_map;
+
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	spinlock_t ref_verify_lock;
+	struct rb_root block_tree;
+#endif
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct kobject *debug_kobj;
+	struct list_head allocated_roots;
+
+	spinlock_t eb_leak_lock;
+	struct list_head allocated_ebs;
+#endif
+};
+
+static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
+						u64 gen)
+{
+	WRITE_ONCE(fs_info->last_root_drop_gen, gen);
+}
+
+static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_info *fs_info)
+{
+	return READ_ONCE(fs_info->last_root_drop_gen);
+}
+
+static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/*
+ * Take the number of bytes to be checksummed and figure out how many leaves
+ * it would require to store the csums for that many bytes.
+ */
+static inline u64 btrfs_csum_bytes_to_leaves(
+			const struct btrfs_fs_info *fs_info, u64 csum_bytes)
+{
+	const u64 num_csums = csum_bytes >> fs_info->sectorsize_bits;
+
+	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
+}
+
+/*
+ * Use this if we would be adding new items, as we could split nodes as we cow
+ * down the tree.
+ */
+static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
+						  unsigned num_items)
+{
+	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
+}
+
+/*
+ * Doing a truncate or a modification won't result in new nodes or leaves, just
+ * what we need for COW.
+ */
+static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
+						 unsigned num_items)
+{
+	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
+}
+
+#define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
+					sizeof(struct btrfs_item))
+
+static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
+{
+	return fs_info->zone_size > 0;
+}
+
+/*
+ * Count how many fs_info->max_extent_size cover the @size
+ */
+static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+{
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+	if (!fs_info)
+		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
+#endif
+
+	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
+}
+
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type);
+bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
+				 enum btrfs_exclusive_operation type);
+void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
+			  enum btrfs_exclusive_operation op);
+
 /* compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
-- 
2.26.3

