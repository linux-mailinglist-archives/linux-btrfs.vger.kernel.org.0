Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EB672DA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjASAqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 19:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjASAqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 19:46:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC463E36
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 16:46:22 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0JW-1opc673L5s-00kL9E; Thu, 19
 Jan 2023 01:46:13 +0100
Message-ID: <ea62d04c-61db-fbe6-6c51-c0acad5e868e@gmx.com>
Date:   Thu, 19 Jan 2023 08:46:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: split extent_buffer handling into a separate file
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20230118175127.296872-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230118175127.296872-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8S0G05vupT8aS+6AroP+2LRDkoYb3s8OJCeeYYiEDlRYM6t6YJP
 hE0SSKtyHFeJ1fD5gyTPhMe6wmN/rpES1Jw7020PFu8Ffc7ybn+Aljb5/ns0hOO++GIHe9D
 xK9FDf28J2Fb40P0tIp1FdyegqEuG6FddLmS7K7zUGlaACfX6hE0O98/9gaOTgv+lzx7j3c
 ZjzoP2/qU53kw7RQ5VVJA==
UI-OutboundReport: notjunk:1;M01:P0:Ahkmzy1lK/U=;K/PZWmMxoA5gP6yQqo6fVb9CHWU
 sDV57fDJL8kBy/uGYuNztPKwQKCTnhdlToFQjx9WI65IQTd/KnW7EsimmjYZN7VGLYRv8/p6O
 sE89Db27iBMmVcWQkKp+Y6NJUuf5a6VnKM5YDQttCoJiOYyuk0xQsLR6KMjJobH9t6qvDBQA4
 q5q8rF3uuZ6PSu4D6bSfeKXZXmlkhCk0V20v76SVnWujDYLrl+qenqAaqprFmnw4MAE8cXYfh
 jB7q48e6A10L6pgdKwvThSMkRapwqfVuPsy0sf+9LP30zmhUTQEHjumBPx4HdgCbLKJmp32he
 2pIr+DRJcfpgy6vF6nxEpTiiwy4granSkL9OsZlG7zGFq6XXweXNfMOCI5VqBzzAevJGIVaO7
 VfIO7toQUJ+8+ZVW0YTm4B8D2hbNxEL4K98upaxhtz7yoLGpLDPMT4+wTT76+WDqzDoBvzjBN
 7bTNSv1ipjwkWn+yPQQJVh4HmWHhW5QyFThIZDUnS6lUgmp+TGOaPyNy/9zlmJb1xBo7UOnuj
 2Gya8evomaF51sixt28jMLBpbHXYApfZHXeXUZUPhG7ZzgsanFwWuFUcGnb9b+BsjjMjF/xlh
 WmqtuoWLtZKrA+Jac8g0z7l4WZLnLwuq4rD8jHnJtU4Yzf1LqgPVTZmUQNij9zlerS/AX5bi4
 mOZOLbMhHXwLLdU4Ue2di6/CYylpWFMaKPldV++W1TFV/GwfbeiIvHx2a9YCIgKjmuE6uflIa
 ZqZPEGVVGrUNExR4Pu9u3EJXLdxL07mKbbgj/PI/JMErzSypr4hLhAxpTT1w/I5mYrT0VDuYX
 6wTIVZ6TB6gXp6y5wxxMk34UtTutfA9nlZE2C4dthcmDkAs33uKpTYWx27gcXnRw7mGpEUafy
 FH0MMi2kKvbN+w7YY3eSZXSMH0Nu7lQ3eguIRCvbssU1jUDWuh6D4zkfCqSKnJ1vVqavwq2yz
 812n4Kn634yEwl2PhldeKkQyIT8=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/19 01:51, Christoph Hellwig wrote:
> The code dealing with the extent_buffer structure for file system
> metadata shares very little logic with the rest of extent_io.c that
> deals with data I/O.  Split it into a separate file.

Pure code move is fine.

And I agree the extent buffer read/write path is indeed better separated 
out.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/Makefile        |    2 +-
>   fs/btrfs/extent_buffer.c | 2632 +++++++++++++++++++++++
>   fs/btrfs/extent_io.c     | 4347 ++++++++------------------------------
>   fs/btrfs/extent_io.h     |   41 +
>   4 files changed, 3524 insertions(+), 3498 deletions(-)

But the chages itself is a little too large for a single patch.

Is there any better practice on such code move?
Or it's just unavoidable?

Thanks,
Qu

>   create mode 100644 fs/btrfs/extent_buffer.c
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 90d53209755bf8..b4dc92dcd67756 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -23,7 +23,7 @@ subdir-ccflags-y += -Wno-shift-negative-value
>   obj-$(CONFIG_BTRFS_FS) := btrfs.o
>   
>   btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
> -	   file-item.o inode-item.o disk-io.o \
> +	   file-item.o inode-item.o disk-io.o extent_buffer.o \
>   	   transaction.o inode.o file.o defrag.o \
>   	   extent_map.o sysfs.o accessors.o xattr.o ordered-data.o \
>   	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
> diff --git a/fs/btrfs/extent_buffer.c b/fs/btrfs/extent_buffer.c
> new file mode 100644
> index 00000000000000..b97190ea5d7cfe
> --- /dev/null
> +++ b/fs/btrfs/extent_buffer.c
> @@ -0,0 +1,2632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/swap.h>
> +#include <linux/writeback.h>
> +#include <linux/pagevec.h>
> +#include "extent_io.h"
> +#include "ctree.h"
> +#include "btrfs_inode.h"
> +#include "bio.h"
> +#include "check-integrity.h"
> +#include "disk-io.h"
> +#include "subpage.h"
> +#include "zoned.h"
> +#include "file-item.h"
> +#include "super.h"
> +
> +
> +static struct kmem_cache *extent_buffer_cache;
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> +	list_add(&eb->leak_list, &fs_info->allocated_ebs);
> +	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> +}
> +
> +static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> +	list_del(&eb->leak_list);
> +	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> +}
> +
> +void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
> +{
> +	struct extent_buffer *eb;
> +	unsigned long flags;
> +
> +	/*
> +	 * If we didn't get into open_ctree our allocated_ebs will not be
> +	 * initialized, so just skip this.
> +	 */
> +	if (!fs_info->allocated_ebs.next)
> +		return;
> +
> +	WARN_ON(!list_empty(&fs_info->allocated_ebs));
> +	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> +	while (!list_empty(&fs_info->allocated_ebs)) {
> +		eb = list_first_entry(&fs_info->allocated_ebs,
> +				      struct extent_buffer, leak_list);
> +		pr_err(
> +	"BTRFS: buffer leak start %llu len %lu refs %d bflags %lu owner %llu\n",
> +		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
> +		       btrfs_header_owner(eb));
> +		list_del(&eb->leak_list);
> +		kmem_cache_free(extent_buffer_cache, eb);
> +	}
> +	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> +}
> +#else
> +#define btrfs_leak_debug_add_eb(eb)			do {} while (0)
> +#define btrfs_leak_debug_del_eb(eb)			do {} while (0)
> +#endif
> +
> +void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
> +{
> +	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
> +		       TASK_UNINTERRUPTIBLE);
> +}
> +
> +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> +{
> +	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> +	smp_mb__after_atomic();
> +	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> +}
> +
> +/*
> + * Lock extent buffer status and pages for writeback.
> + *
> + * May try to flush write bio if we can't get the lock.
> + *
> + * Return  0 if the extent buffer doesn't need to be submitted.
> + *           (E.g. the extent buffer is not dirty)
> + * Return >0 is the extent buffer is submitted to bio.
> + * Return <0 if something went wrong, no page is locked.
> + */
> +static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
> +			  struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	int i, num_pages;
> +	int flush = 0;
> +	int ret = 0;
> +
> +	if (!btrfs_try_tree_write_lock(eb)) {
> +		submit_write_bio(bio_ctrl, 0);
> +		flush = 1;
> +		btrfs_tree_lock(eb);
> +	}
> +
> +	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
> +		btrfs_tree_unlock(eb);
> +		if (!bio_ctrl->sync_io)
> +			return 0;
> +		if (!flush) {
> +			submit_write_bio(bio_ctrl, 0);
> +			flush = 1;
> +		}
> +		while (1) {
> +			wait_on_extent_buffer_writeback(eb);
> +			btrfs_tree_lock(eb);
> +			if (!test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags))
> +				break;
> +			btrfs_tree_unlock(eb);
> +		}
> +	}
> +
> +	/*
> +	 * We need to do this to prevent races in people who check if the eb is
> +	 * under IO since we can end up having no IO bits set for a short period
> +	 * of time.
> +	 */
> +	spin_lock(&eb->refs_lock);
> +	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> +		spin_unlock(&eb->refs_lock);
> +		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
> +		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +					 -eb->len,
> +					 fs_info->dirty_metadata_batch);
> +		ret = 1;
> +	} else {
> +		spin_unlock(&eb->refs_lock);
> +	}
> +
> +	btrfs_tree_unlock(eb);
> +
> +	/*
> +	 * Either we don't need to submit any tree block, or we're submitting
> +	 * subpage eb.
> +	 * Subpage metadata doesn't use page locking at all, so we can skip
> +	 * the page locking.
> +	 */
> +	if (!ret || fs_info->nodesize < PAGE_SIZE)
> +		return ret;
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *p = eb->pages[i];
> +
> +		if (!trylock_page(p)) {
> +			if (!flush) {
> +				submit_write_bio(bio_ctrl, 0);
> +				flush = 1;
> +			}
> +			lock_page(p);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +
> +	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
> +	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
> +		return;
> +
> +	/*
> +	 * A read may stumble upon this buffer later, make sure that it gets an
> +	 * error and knows there was an error.
> +	 */
> +	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +
> +	/*
> +	 * We need to set the mapping with the io error as well because a write
> +	 * error will flip the file system readonly, and then syncfs() will
> +	 * return a 0 because we are readonly if we don't modify the err seq for
> +	 * the superblock.
> +	 */
> +	mapping_set_error(page->mapping, -EIO);
> +
> +	/*
> +	 * If we error out, we should add back the dirty_metadata_bytes
> +	 * to make it consistent.
> +	 */
> +	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +				 eb->len, fs_info->dirty_metadata_batch);
> +
> +	/*
> +	 * If writeback for a btree extent that doesn't belong to a log tree
> +	 * failed, increment the counter transaction->eb_write_errors.
> +	 * We do this because while the transaction is running and before it's
> +	 * committing (when we call filemap_fdata[write|wait]_range against
> +	 * the btree inode), we might have
> +	 * btree_inode->i_mapping->a_ops->writepages() called by the VM - if it
> +	 * returns an error or an error happens during writeback, when we're
> +	 * committing the transaction we wouldn't know about it, since the pages
> +	 * can be no longer dirty nor marked anymore for writeback (if a
> +	 * subsequent modification to the extent buffer didn't happen before the
> +	 * transaction commit), which makes filemap_fdata[write|wait]_range not
> +	 * able to find the pages tagged with SetPageError at transaction
> +	 * commit time. So if this happens we must abort the transaction,
> +	 * otherwise we commit a super block with btree roots that point to
> +	 * btree nodes/leafs whose content on disk is invalid - either garbage
> +	 * or the content of some node/leaf from a past generation that got
> +	 * cowed or deleted and is no longer valid.
> +	 *
> +	 * Note: setting AS_EIO/AS_ENOSPC in the btree inode's i_mapping would
> +	 * not be enough - we need to distinguish between log tree extents vs
> +	 * non-log tree extents, and the next filemap_fdatawait_range() call
> +	 * will catch and clear such errors in the mapping - and that call might
> +	 * be from a log sync and not from a transaction commit. Also, checking
> +	 * for the eb flag EXTENT_BUFFER_WRITE_ERR at transaction commit time is
> +	 * not done and would not be reliable - the eb might have been released
> +	 * from memory and reading it back again means that flag would not be
> +	 * set (since it's a runtime flag, not persisted on disk).
> +	 *
> +	 * Using the flags below in the btree inode also makes us achieve the
> +	 * goal of AS_EIO/AS_ENOSPC when writepages() returns success, started
> +	 * writeback for all dirty pages and before filemap_fdatawait_range()
> +	 * is called, the writeback for all dirty pages had already finished
> +	 * with errors - because we were not using AS_EIO/AS_ENOSPC,
> +	 * filemap_fdatawait_range() would return success, as it could not know
> +	 * that writeback errors happened (the pages were no longer tagged for
> +	 * writeback).
> +	 */
> +	switch (eb->log_index) {
> +	case -1:
> +		set_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags);
> +		break;
> +	case 0:
> +		set_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags);
> +		break;
> +	case 1:
> +		set_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags);
> +		break;
> +	default:
> +		BUG(); /* unexpected, logic error */
> +	}
> +}
> +
> +/*
> + * The endio specific version which won't touch any unsafe spinlock in endio
> + * context.
> + */
> +static struct extent_buffer *find_extent_buffer_nolock(
> +		struct btrfs_fs_info *fs_info, u64 start)
> +{
> +	struct extent_buffer *eb;
> +
> +	rcu_read_lock();
> +	eb = radix_tree_lookup(&fs_info->buffer_radix,
> +			       start >> fs_info->sectorsize_bits);
> +	if (eb && atomic_inc_not_zero(&eb->refs)) {
> +		rcu_read_unlock();
> +		return eb;
> +	}
> +	rcu_read_unlock();
> +	return NULL;
> +}
> +
> +/*
> + * The endio function for subpage extent buffer write.
> + *
> + * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
> + * after all extent buffers in the page has finished their writeback.
> + */
> +static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
> +{
> +	struct bio *bio = &bbio->bio;
> +	struct btrfs_fs_info *fs_info;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> +	ASSERT(fs_info->nodesize < PAGE_SIZE);
> +
> +	ASSERT(!bio_flagged(bio, BIO_CLONED));
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +		u64 bvec_start = page_offset(page) + bvec->bv_offset;
> +		u64 bvec_end = bvec_start + bvec->bv_len - 1;
> +		u64 cur_bytenr = bvec_start;
> +
> +		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
> +
> +		/* Iterate through all extent buffers in the range */
> +		while (cur_bytenr <= bvec_end) {
> +			struct extent_buffer *eb;
> +			int done;
> +
> +			/*
> +			 * Here we can't use find_extent_buffer(), as it may
> +			 * try to lock eb->refs_lock, which is not safe in endio
> +			 * context.
> +			 */
> +			eb = find_extent_buffer_nolock(fs_info, cur_bytenr);
> +			ASSERT(eb);
> +
> +			cur_bytenr = eb->start + eb->len;
> +
> +			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
> +			done = atomic_dec_and_test(&eb->io_pages);
> +			ASSERT(done);
> +
> +			if (bio->bi_status ||
> +			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> +				ClearPageUptodate(page);
> +				set_btree_ioerr(page, eb);
> +			}
> +
> +			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> +						      eb->len);
> +			end_extent_buffer_writeback(eb);
> +			/*
> +			 * free_extent_buffer() will grab spinlock which is not
> +			 * safe in endio context. Thus here we manually dec
> +			 * the ref.
> +			 */
> +			atomic_dec(&eb->refs);
> +		}
> +	}
> +	bio_put(bio);
> +}
> +
> +static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
> +{
> +	struct bio *bio = &bbio->bio;
> +	struct bio_vec *bvec;
> +	struct extent_buffer *eb;
> +	int done;
> +	struct bvec_iter_all iter_all;
> +
> +	ASSERT(!bio_flagged(bio, BIO_CLONED));
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +
> +		eb = (struct extent_buffer *)page->private;
> +		BUG_ON(!eb);
> +		done = atomic_dec_and_test(&eb->io_pages);
> +
> +		if (bio->bi_status ||
> +		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> +			ClearPageUptodate(page);
> +			set_btree_ioerr(page, eb);
> +		}
> +
> +		end_page_writeback(page);
> +
> +		if (!done)
> +			continue;
> +
> +		end_extent_buffer_writeback(eb);
> +	}
> +
> +	bio_put(bio);
> +}
> +
> +static void prepare_eb_write(struct extent_buffer *eb)
> +{
> +	u32 nritems;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> +	atomic_set(&eb->io_pages, num_extent_pages(eb));
> +
> +	/* Set btree blocks beyond nritems with 0 to avoid stale content */
> +	nritems = btrfs_header_nritems(eb);
> +	if (btrfs_header_level(eb) > 0) {
> +		end = btrfs_node_key_ptr_offset(eb, nritems);
> +		memzero_extent_buffer(eb, end, eb->len - end);
> +	} else {
> +		/*
> +		 * Leaf:
> +		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
> +		 */
> +		start = btrfs_item_nr_offset(eb, nritems);
> +		end = btrfs_item_nr_offset(eb, 0);
> +		if (nritems == 0)
> +			end += BTRFS_LEAF_DATA_SIZE(eb->fs_info);
> +		else
> +			end += btrfs_item_offset(eb, nritems - 1);
> +		memzero_extent_buffer(eb, start, end - start);
> +	}
> +}
> +
> +/*
> + * Unlike the work in write_one_eb(), we rely completely on extent locking.
> + * Page locking is only utilized at minimum to keep the VMM code happy.
> + */
> +static int write_one_subpage_eb(struct extent_buffer *eb,
> +				struct writeback_control *wbc,
> +				struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct page *page = eb->pages[0];
> +	blk_opf_t write_flags = wbc_to_write_flags(wbc);
> +	bool no_dirty_ebs = false;
> +	int ret;
> +
> +	prepare_eb_write(eb);
> +
> +	/* clear_page_dirty_for_io() in subpage helper needs page locked */
> +	lock_page(page);
> +	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
> +
> +	/* Check if this is the last dirty bit to update nr_written */
> +	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
> +							  eb->start, eb->len);
> +	if (no_dirty_ebs)
> +		clear_page_dirty_for_io(page);
> +
> +	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
> +
> +	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> +			bio_ctrl, eb->start, page, eb->len,
> +			eb->start - page_offset(page), 0, false);
> +	if (ret) {
> +		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
> +		set_btree_ioerr(page, eb);
> +		unlock_page(page);
> +
> +		if (atomic_dec_and_test(&eb->io_pages))
> +			end_extent_buffer_writeback(eb);
> +		return -EIO;
> +	}
> +	unlock_page(page);
> +	/*
> +	 * Submission finished without problem, if no range of the page is
> +	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
> +	 */
> +	if (no_dirty_ebs)
> +		wbc->nr_to_write--;
> +	return ret;
> +}
> +
> +static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
> +			struct writeback_control *wbc,
> +			struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	u64 disk_bytenr = eb->start;
> +	int i, num_pages;
> +	blk_opf_t write_flags = wbc_to_write_flags(wbc);
> +	int ret = 0;
> +
> +	prepare_eb_write(eb);
> +
> +	bio_ctrl->end_io_func = end_bio_extent_buffer_writepage;
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *p = eb->pages[i];
> +
> +		clear_page_dirty_for_io(p);
> +		set_page_writeback(p);
> +		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> +					 bio_ctrl, disk_bytenr, p,
> +					 PAGE_SIZE, 0, 0, false);
> +		if (ret) {
> +			set_btree_ioerr(p, eb);
> +			if (PageWriteback(p))
> +				end_page_writeback(p);
> +			if (atomic_sub_and_test(num_pages - i, &eb->io_pages))
> +				end_extent_buffer_writeback(eb);
> +			ret = -EIO;
> +			break;
> +		}
> +		disk_bytenr += PAGE_SIZE;
> +		wbc->nr_to_write--;
> +		unlock_page(p);
> +	}
> +
> +	if (unlikely(ret)) {
> +		for (; i < num_pages; i++) {
> +			struct page *p = eb->pages[i];
> +			clear_page_dirty_for_io(p);
> +			unlock_page(p);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Submit one subpage btree page.
> + *
> + * The main difference to submit_eb_page() is:
> + * - Page locking
> + *   For subpage, we don't rely on page locking at all.
> + *
> + * - Flush write bio
> + *   We only flush bio if we may be unable to fit current extent buffers into
> + *   current bio.
> + *
> + * Return >=0 for the number of submitted extent buffers.
> + * Return <0 for fatal error.
> + */
> +static int submit_eb_subpage(struct page *page,
> +			     struct writeback_control *wbc,
> +			     struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	int submitted = 0;
> +	u64 page_start = page_offset(page);
> +	int bit_start = 0;
> +	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
> +	int ret;
> +
> +	/* Lock and write each dirty extent buffers in the range */
> +	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
> +		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +		struct extent_buffer *eb;
> +		unsigned long flags;
> +		u64 start;
> +
> +		/*
> +		 * Take private lock to ensure the subpage won't be detached
> +		 * in the meantime.
> +		 */
> +		spin_lock(&page->mapping->private_lock);
> +		if (!PagePrivate(page)) {
> +			spin_unlock(&page->mapping->private_lock);
> +			break;
> +		}
> +		spin_lock_irqsave(&subpage->lock, flags);
> +		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
> +			      subpage->bitmaps)) {
> +			spin_unlock_irqrestore(&subpage->lock, flags);
> +			spin_unlock(&page->mapping->private_lock);
> +			bit_start++;
> +			continue;
> +		}
> +
> +		start = page_start + bit_start * fs_info->sectorsize;
> +		bit_start += sectors_per_node;
> +
> +		/*
> +		 * Here we just want to grab the eb without touching extra
> +		 * spin locks, so call find_extent_buffer_nolock().
> +		 */
> +		eb = find_extent_buffer_nolock(fs_info, start);
> +		spin_unlock_irqrestore(&subpage->lock, flags);
> +		spin_unlock(&page->mapping->private_lock);
> +
> +		/*
> +		 * The eb has already reached 0 refs thus find_extent_buffer()
> +		 * doesn't return it. We don't need to write back such eb
> +		 * anyway.
> +		 */
> +		if (!eb)
> +			continue;
> +
> +		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
> +		if (ret == 0) {
> +			free_extent_buffer(eb);
> +			continue;
> +		}
> +		if (ret < 0) {
> +			free_extent_buffer(eb);
> +			goto cleanup;
> +		}
> +		ret = write_one_subpage_eb(eb, wbc, bio_ctrl);
> +		free_extent_buffer(eb);
> +		if (ret < 0)
> +			goto cleanup;
> +		submitted++;
> +	}
> +	return submitted;
> +
> +cleanup:
> +	/* We hit error, end bio for the submitted extent buffers */
> +	submit_write_bio(bio_ctrl, ret);
> +	return ret;
> +}
> +
> +/*
> + * Submit all page(s) of one extent buffer.
> + *
> + * @page:	the page of one extent buffer
> + * @eb_context:	to determine if we need to submit this page, if current page
> + *		belongs to this eb, we don't need to submit
> + *
> + * The caller should pass each page in their bytenr order, and here we use
> + * @eb_context to determine if we have submitted pages of one extent buffer.
> + *
> + * If we have, we just skip until we hit a new page that doesn't belong to
> + * current @eb_context.
> + *
> + * If not, we submit all the page(s) of the extent buffer.
> + *
> + * Return >0 if we have submitted the extent buffer successfully.
> + * Return 0 if we don't need to submit the page, as it's already submitted by
> + * previous call.
> + * Return <0 for fatal error.
> + */
> +static int submit_eb_page(struct page *page, struct writeback_control *wbc,
> +			  struct btrfs_bio_ctrl *bio_ctrl,
> +			  struct extent_buffer **eb_context)
> +{
> +	struct address_space *mapping = page->mapping;
> +	struct btrfs_block_group *cache = NULL;
> +	struct extent_buffer *eb;
> +	int ret;
> +
> +	if (!PagePrivate(page))
> +		return 0;
> +
> +	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
> +		return submit_eb_subpage(page, wbc, bio_ctrl);
> +
> +	spin_lock(&mapping->private_lock);
> +	if (!PagePrivate(page)) {
> +		spin_unlock(&mapping->private_lock);
> +		return 0;
> +	}
> +
> +	eb = (struct extent_buffer *)page->private;
> +
> +	/*
> +	 * Shouldn't happen and normally this would be a BUG_ON but no point
> +	 * crashing the machine for something we can survive anyway.
> +	 */
> +	if (WARN_ON(!eb)) {
> +		spin_unlock(&mapping->private_lock);
> +		return 0;
> +	}
> +
> +	if (eb == *eb_context) {
> +		spin_unlock(&mapping->private_lock);
> +		return 0;
> +	}
> +	ret = atomic_inc_not_zero(&eb->refs);
> +	spin_unlock(&mapping->private_lock);
> +	if (!ret)
> +		return 0;
> +
> +	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
> +		/*
> +		 * If for_sync, this hole will be filled with
> +		 * trasnsaction commit.
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
> +			ret = -EAGAIN;
> +		else
> +			ret = 0;
> +		free_extent_buffer(eb);
> +		return ret;
> +	}
> +
> +	*eb_context = eb;
> +
> +	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
> +	if (ret <= 0) {
> +		btrfs_revert_meta_write_pointer(cache, eb);
> +		if (cache)
> +			btrfs_put_block_group(cache);
> +		free_extent_buffer(eb);
> +		return ret;
> +	}
> +	if (cache) {
> +		/*
> +		 * Implies write in zoned mode. Mark the last eb in a block group.
> +		 */
> +		btrfs_schedule_zone_finish_bg(cache, eb);
> +		btrfs_put_block_group(cache);
> +	}
> +	ret = write_one_eb(eb, wbc, bio_ctrl);
> +	free_extent_buffer(eb);
> +	if (ret < 0)
> +		return ret;
> +	return 1;
> +}
> +
> +int btree_write_cache_pages(struct address_space *mapping,
> +				   struct writeback_control *wbc)
> +{
> +	struct extent_buffer *eb_context = NULL;
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.extent_locked = 0,
> +		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
> +	};
> +	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
> +	int ret = 0;
> +	int done = 0;
> +	int nr_to_write_done = 0;
> +	struct pagevec pvec;
> +	int nr_pages;
> +	pgoff_t index;
> +	pgoff_t end;		/* Inclusive */
> +	int scanned = 0;
> +	xa_mark_t tag;
> +
> +	pagevec_init(&pvec);
> +	if (wbc->range_cyclic) {
> +		index = mapping->writeback_index; /* Start from prev offset */
> +		end = -1;
> +		/*
> +		 * Start from the beginning does not need to cycle over the
> +		 * range, mark it as scanned.
> +		 */
> +		scanned = (index == 0);
> +	} else {
> +		index = wbc->range_start >> PAGE_SHIFT;
> +		end = wbc->range_end >> PAGE_SHIFT;
> +		scanned = 1;
> +	}
> +	if (wbc->sync_mode == WB_SYNC_ALL)
> +		tag = PAGECACHE_TAG_TOWRITE;
> +	else
> +		tag = PAGECACHE_TAG_DIRTY;
> +	btrfs_zoned_meta_io_lock(fs_info);
> +retry:
> +	if (wbc->sync_mode == WB_SYNC_ALL)
> +		tag_pages_for_writeback(mapping, index, end);
> +	while (!done && !nr_to_write_done && (index <= end) &&
> +	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> +			tag))) {
> +		unsigned i;
> +
> +		for (i = 0; i < nr_pages; i++) {
> +			struct page *page = pvec.pages[i];
> +
> +			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
> +			if (ret == 0)
> +				continue;
> +			if (ret < 0) {
> +				done = 1;
> +				break;
> +			}
> +
> +			/*
> +			 * the filesystem may choose to bump up nr_to_write.
> +			 * We have to make sure to honor the new nr_to_write
> +			 * at any time
> +			 */
> +			nr_to_write_done = wbc->nr_to_write <= 0;
> +		}
> +		pagevec_release(&pvec);
> +		cond_resched();
> +	}
> +	if (!scanned && !done) {
> +		/*
> +		 * We hit the last page and there is more work to be done: wrap
> +		 * back to the start of the file
> +		 */
> +		scanned = 1;
> +		index = 0;
> +		goto retry;
> +	}
> +	/*
> +	 * If something went wrong, don't allow any metadata write bio to be
> +	 * submitted.
> +	 *
> +	 * This would prevent use-after-free if we had dirty pages not
> +	 * cleaned up, which can still happen by fuzzed images.
> +	 *
> +	 * - Bad extent tree
> +	 *   Allowing existing tree block to be allocated for other trees.
> +	 *
> +	 * - Log tree operations
> +	 *   Exiting tree blocks get allocated to log tree, bumps its
> +	 *   generation, then get cleaned in tree re-balance.
> +	 *   Such tree block will not be written back, since it's clean,
> +	 *   thus no WRITTEN flag set.
> +	 *   And after log writes back, this tree block is not traced by
> +	 *   any dirty extent_io_tree.
> +	 *
> +	 * - Offending tree block gets re-dirtied from its original owner
> +	 *   Since it has bumped generation, no WRITTEN flag, it can be
> +	 *   reused without COWing. This tree block will not be traced
> +	 *   by btrfs_transaction::dirty_pages.
> +	 *
> +	 *   Now such dirty tree block will not be cleaned by any dirty
> +	 *   extent io tree. Thus we don't want to submit such wild eb
> +	 *   if the fs already has error.
> +	 *
> +	 * We can get ret > 0 from submit_extent_page() indicating how many ebs
> +	 * were submitted. Reset it to 0 to avoid false alerts for the caller.
> +	 */
> +	if (ret > 0)
> +		ret = 0;
> +	if (!ret && BTRFS_FS_ERROR(fs_info))
> +		ret = -EROFS;
> +	submit_write_bio(&bio_ctrl, ret);
> +
> +	btrfs_zoned_meta_io_unlock(fs_info);
> +	return ret;
> +}
> +
> +static void __free_extent_buffer(struct extent_buffer *eb)
> +{
> +	kmem_cache_free(extent_buffer_cache, eb);
> +}
> +
> +int extent_buffer_under_io(const struct extent_buffer *eb)
> +{
> +	return (atomic_read(&eb->io_pages) ||
> +		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
> +		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> +}
> +
> +static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	struct btrfs_subpage *subpage;
> +
> +	lockdep_assert_held(&page->mapping->private_lock);
> +
> +	if (PagePrivate(page)) {
> +		subpage = (struct btrfs_subpage *)page->private;
> +		if (atomic_read(&subpage->eb_refs))
> +			return true;
> +		/*
> +		 * Even there is no eb refs here, we may still have
> +		 * end_page_read() call relying on page::private.
> +		 */
> +		if (atomic_read(&subpage->readers))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> +
> +	/*
> +	 * For mapped eb, we're going to change the page private, which should
> +	 * be done under the private_lock.
> +	 */
> +	if (mapped)
> +		spin_lock(&page->mapping->private_lock);
> +
> +	if (!PagePrivate(page)) {
> +		if (mapped)
> +			spin_unlock(&page->mapping->private_lock);
> +		return;
> +	}
> +
> +	if (fs_info->nodesize >= PAGE_SIZE) {
> +		/*
> +		 * We do this since we'll remove the pages after we've
> +		 * removed the eb from the radix tree, so we could race
> +		 * and have this page now attached to the new eb.  So
> +		 * only clear page_private if it's still connected to
> +		 * this eb.
> +		 */
> +		if (PagePrivate(page) &&
> +		    page->private == (unsigned long)eb) {
> +			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> +			BUG_ON(PageDirty(page));
> +			BUG_ON(PageWriteback(page));
> +			/*
> +			 * We need to make sure we haven't be attached
> +			 * to a new eb.
> +			 */
> +			detach_page_private(page);
> +		}
> +		if (mapped)
> +			spin_unlock(&page->mapping->private_lock);
> +		return;
> +	}
> +
> +	/*
> +	 * For subpage, we can have dummy eb with page private.  In this case,
> +	 * we can directly detach the private as such page is only attached to
> +	 * one dummy eb, no sharing.
> +	 */
> +	if (!mapped) {
> +		btrfs_detach_subpage(fs_info, page);
> +		return;
> +	}
> +
> +	btrfs_page_dec_eb_refs(fs_info, page);
> +
> +	/*
> +	 * We can only detach the page private if there are no other ebs in the
> +	 * page range and no unfinished IO.
> +	 */
> +	if (!page_range_has_eb(fs_info, page))
> +		btrfs_detach_subpage(fs_info, page);
> +
> +	spin_unlock(&page->mapping->private_lock);
> +}
> +
> +/* Release all pages attached to the extent buffer */
> +static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
> +{
> +	int i;
> +	int num_pages;
> +
> +	ASSERT(!extent_buffer_under_io(eb));
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *page = eb->pages[i];
> +
> +		if (!page)
> +			continue;
> +
> +		detach_extent_buffer_page(eb, page);
> +
> +		/* One for when we allocated the page */
> +		put_page(page);
> +	}
> +}
> +
> +static int attach_extent_buffer_page(struct extent_buffer *eb,
> +				     struct page *page,
> +				     struct btrfs_subpage *prealloc)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	int ret = 0;
> +
> +	/*
> +	 * If the page is mapped to btree inode, we should hold the private
> +	 * lock to prevent race.
> +	 * For cloned or dummy extent buffers, their pages are not mapped and
> +	 * will not race with any other ebs.
> +	 */
> +	if (page->mapping)
> +		lockdep_assert_held(&page->mapping->private_lock);
> +
> +	if (fs_info->nodesize >= PAGE_SIZE) {
> +		if (!PagePrivate(page))
> +			attach_page_private(page, eb);
> +		else
> +			WARN_ON(page->private != (unsigned long)eb);
> +		return 0;
> +	}
> +
> +	/* Already mapped, just free prealloc */
> +	if (PagePrivate(page)) {
> +		btrfs_free_subpage(prealloc);
> +		return 0;
> +	}
> +
> +	if (prealloc)
> +		/* Has preallocated memory for subpage */
> +		attach_page_private(page, prealloc);
> +	else
> +		/* Do new allocation to attach subpage */
> +		ret = btrfs_attach_subpage(fs_info, page,
> +					   BTRFS_SUBPAGE_METADATA);
> +	return ret;
> +}
> +
> +/*
> + * Helper for releasing the extent buffer.
> + */
> +static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
> +{
> +	btrfs_release_extent_buffer_pages(eb);
> +	btrfs_leak_debug_del_eb(eb);
> +	__free_extent_buffer(eb);
> +}
> +
> +static struct extent_buffer *
> +__alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
> +		      unsigned long len)
> +{
> +	struct extent_buffer *eb = NULL;
> +
> +	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
> +	eb->start = start;
> +	eb->len = len;
> +	eb->fs_info = fs_info;
> +	init_rwsem(&eb->lock);
> +
> +	btrfs_leak_debug_add_eb(eb);
> +	INIT_LIST_HEAD(&eb->release_list);
> +
> +	spin_lock_init(&eb->refs_lock);
> +	atomic_set(&eb->refs, 1);
> +	atomic_set(&eb->io_pages, 0);
> +
> +	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
> +
> +	return eb;
> +}
> +
> +struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> +{
> +	int i;
> +	struct extent_buffer *new;
> +	int num_pages = num_extent_pages(src);
> +	int ret;
> +
> +	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
> +	if (new == NULL)
> +		return NULL;
> +
> +	/*
> +	 * Set UNMAPPED before calling btrfs_release_extent_buffer(), as
> +	 * btrfs_release_extent_buffer() have different behavior for
> +	 * UNMAPPED subpage extent buffer.
> +	 */
> +	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> +
> +	ret = btrfs_alloc_page_array(num_pages, new->pages);
> +	if (ret) {
> +		btrfs_release_extent_buffer(new);
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < num_pages; i++) {
> +		int ret;
> +		struct page *p = new->pages[i];
> +
> +		ret = attach_extent_buffer_page(new, p, NULL);
> +		if (ret < 0) {
> +			btrfs_release_extent_buffer(new);
> +			return NULL;
> +		}
> +		WARN_ON(PageDirty(p));
> +		copy_page(page_address(p), page_address(src->pages[i]));
> +	}
> +	set_extent_buffer_uptodate(new);
> +
> +	return new;
> +}
> +
> +struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> +						  u64 start, unsigned long len)
> +{
> +	struct extent_buffer *eb;
> +	int num_pages;
> +	int i;
> +	int ret;
> +
> +	eb = __alloc_extent_buffer(fs_info, start, len);
> +	if (!eb)
> +		return NULL;
> +
> +	num_pages = num_extent_pages(eb);
> +	ret = btrfs_alloc_page_array(num_pages, eb->pages);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *p = eb->pages[i];
> +
> +		ret = attach_extent_buffer_page(eb, p, NULL);
> +		if (ret < 0)
> +			goto err;
> +	}
> +
> +	set_extent_buffer_uptodate(eb);
> +	btrfs_set_header_nritems(eb, 0);
> +	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> +
> +	return eb;
> +err:
> +	for (i = 0; i < num_pages; i++) {
> +		if (eb->pages[i]) {
> +			detach_extent_buffer_page(eb, eb->pages[i]);
> +			__free_page(eb->pages[i]);
> +		}
> +	}
> +	__free_extent_buffer(eb);
> +	return NULL;
> +}
> +
> +struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> +						u64 start)
> +{
> +	return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
> +}
> +
> +static void check_buffer_tree_ref(struct extent_buffer *eb)
> +{
> +	int refs;
> +	/*
> +	 * The TREE_REF bit is first set when the extent_buffer is added
> +	 * to the radix tree. It is also reset, if unset, when a new reference
> +	 * is created by find_extent_buffer.
> +	 *
> +	 * It is only cleared in two cases: freeing the last non-tree
> +	 * reference to the extent_buffer when its STALE bit is set or
> +	 * calling release_folio when the tree reference is the only reference.
> +	 *
> +	 * In both cases, care is taken to ensure that the extent_buffer's
> +	 * pages are not under io. However, release_folio can be concurrently
> +	 * called with creating new references, which is prone to race
> +	 * conditions between the calls to check_buffer_tree_ref in those
> +	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
> +	 *
> +	 * The actual lifetime of the extent_buffer in the radix tree is
> +	 * adequately protected by the refcount, but the TREE_REF bit and
> +	 * its corresponding reference are not. To protect against this
> +	 * class of races, we call check_buffer_tree_ref from the codepaths
> +	 * which trigger io after they set eb->io_pages. Note that once io is
> +	 * initiated, TREE_REF can no longer be cleared, so that is the
> +	 * moment at which any such race is best fixed.
> +	 */
> +	refs = atomic_read(&eb->refs);
> +	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> +		return;
> +
> +	spin_lock(&eb->refs_lock);
> +	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> +		atomic_inc(&eb->refs);
> +	spin_unlock(&eb->refs_lock);
> +}
> +
> +static void mark_extent_buffer_accessed(struct extent_buffer *eb,
> +		struct page *accessed)
> +{
> +	int num_pages, i;
> +
> +	check_buffer_tree_ref(eb);
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *p = eb->pages[i];
> +
> +		if (p != accessed)
> +			mark_page_accessed(p);
> +	}
> +}
> +
> +struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
> +					 u64 start)
> +{
> +	struct extent_buffer *eb;
> +
> +	eb = find_extent_buffer_nolock(fs_info, start);
> +	if (!eb)
> +		return NULL;
> +	/*
> +	 * Lock our eb's refs_lock to avoid races with free_extent_buffer().
> +	 * When we get our eb it might be flagged with EXTENT_BUFFER_STALE and
> +	 * another task running free_extent_buffer() might have seen that flag
> +	 * set, eb->refs == 2, that the buffer isn't under IO (dirty and
> +	 * writeback flags not set) and it's still in the tree (flag
> +	 * EXTENT_BUFFER_TREE_REF set), therefore being in the process of
> +	 * decrementing the extent buffer's reference count twice.  So here we
> +	 * could race and increment the eb's reference count, clear its stale
> +	 * flag, mark it as dirty and drop our reference before the other task
> +	 * finishes executing free_extent_buffer, which would later result in
> +	 * an attempt to free an extent buffer that is dirty.
> +	 */
> +	if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
> +		spin_lock(&eb->refs_lock);
> +		spin_unlock(&eb->refs_lock);
> +	}
> +	mark_extent_buffer_accessed(eb, NULL);
> +	return eb;
> +}
> +
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> +struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> +					u64 start)
> +{
> +	struct extent_buffer *eb, *exists = NULL;
> +	int ret;
> +
> +	eb = find_extent_buffer(fs_info, start);
> +	if (eb)
> +		return eb;
> +	eb = alloc_dummy_extent_buffer(fs_info, start);
> +	if (!eb)
> +		return ERR_PTR(-ENOMEM);
> +	eb->fs_info = fs_info;
> +again:
> +	ret = radix_tree_preload(GFP_NOFS);
> +	if (ret) {
> +		exists = ERR_PTR(ret);
> +		goto free_eb;
> +	}
> +	spin_lock(&fs_info->buffer_lock);
> +	ret = radix_tree_insert(&fs_info->buffer_radix,
> +				start >> fs_info->sectorsize_bits, eb);
> +	spin_unlock(&fs_info->buffer_lock);
> +	radix_tree_preload_end();
> +	if (ret == -EEXIST) {
> +		exists = find_extent_buffer(fs_info, start);
> +		if (exists)
> +			goto free_eb;
> +		else
> +			goto again;
> +	}
> +	check_buffer_tree_ref(eb);
> +	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
> +
> +	return eb;
> +free_eb:
> +	btrfs_release_extent_buffer(eb);
> +	return exists;
> +}
> +#endif
> +
> +static struct extent_buffer *grab_extent_buffer(
> +		struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	struct extent_buffer *exists;
> +
> +	/*
> +	 * For subpage case, we completely rely on radix tree to ensure we
> +	 * don't try to insert two ebs for the same bytenr.  So here we always
> +	 * return NULL and just continue.
> +	 */
> +	if (fs_info->nodesize < PAGE_SIZE)
> +		return NULL;
> +
> +	/* Page not yet attached to an extent buffer */
> +	if (!PagePrivate(page))
> +		return NULL;
> +
> +	/*
> +	 * We could have already allocated an eb for this page and attached one
> +	 * so lets see if we can get a ref on the existing eb, and if we can we
> +	 * know it's good and we can just return that one, else we know we can
> +	 * just overwrite page->private.
> +	 */
> +	exists = (struct extent_buffer *)page->private;
> +	if (atomic_inc_not_zero(&exists->refs))
> +		return exists;
> +
> +	WARN_ON(PageDirty(page));
> +	detach_page_private(page);
> +	return NULL;
> +}
> +
> +static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
> +{
> +	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
> +		btrfs_err(fs_info, "bad tree block start %llu", start);
> +		return -EINVAL;
> +	}
> +
> +	if (fs_info->nodesize < PAGE_SIZE &&
> +	    offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
> +		btrfs_err(fs_info,
> +		"tree block crosses page boundary, start %llu nodesize %u",
> +			  start, fs_info->nodesize);
> +		return -EINVAL;
> +	}
> +	if (fs_info->nodesize >= PAGE_SIZE &&
> +	    !PAGE_ALIGNED(start)) {
> +		btrfs_err(fs_info,
> +		"tree block is not page aligned, start %llu nodesize %u",
> +			  start, fs_info->nodesize);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> +					  u64 start, u64 owner_root, int level)
> +{
> +	unsigned long len = fs_info->nodesize;
> +	int num_pages;
> +	int i;
> +	unsigned long index = start >> PAGE_SHIFT;
> +	struct extent_buffer *eb;
> +	struct extent_buffer *exists = NULL;
> +	struct page *p;
> +	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> +	u64 lockdep_owner = owner_root;
> +	int uptodate = 1;
> +	int ret;
> +
> +	if (check_eb_alignment(fs_info, start))
> +		return ERR_PTR(-EINVAL);
> +
> +#if BITS_PER_LONG == 32
> +	if (start >= MAX_LFS_FILESIZE) {
> +		btrfs_err_rl(fs_info,
> +		"extent buffer %llu is beyond 32bit page cache limit", start);
> +		btrfs_err_32bit_limit(fs_info);
> +		return ERR_PTR(-EOVERFLOW);
> +	}
> +	if (start >= BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> +		btrfs_warn_32bit_limit(fs_info);
> +#endif
> +
> +	eb = find_extent_buffer(fs_info, start);
> +	if (eb)
> +		return eb;
> +
> +	eb = __alloc_extent_buffer(fs_info, start, len);
> +	if (!eb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * The reloc trees are just snapshots, so we need them to appear to be
> +	 * just like any other fs tree WRT lockdep.
> +	 */
> +	if (lockdep_owner == BTRFS_TREE_RELOC_OBJECTID)
> +		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
> +
> +	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++, index++) {
> +		struct btrfs_subpage *prealloc = NULL;
> +
> +		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
> +		if (!p) {
> +			exists = ERR_PTR(-ENOMEM);
> +			goto free_eb;
> +		}
> +
> +		/*
> +		 * Preallocate page->private for subpage case, so that we won't
> +		 * allocate memory with private_lock hold.  The memory will be
> +		 * freed by attach_extent_buffer_page() or freed manually if
> +		 * we exit earlier.
> +		 *
> +		 * Although we have ensured one subpage eb can only have one
> +		 * page, but it may change in the future for 16K page size
> +		 * support, so we still preallocate the memory in the loop.
> +		 */
> +		if (fs_info->nodesize < PAGE_SIZE) {
> +			prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
> +			if (IS_ERR(prealloc)) {
> +				ret = PTR_ERR(prealloc);
> +				unlock_page(p);
> +				put_page(p);
> +				exists = ERR_PTR(ret);
> +				goto free_eb;
> +			}
> +		}
> +
> +		spin_lock(&mapping->private_lock);
> +		exists = grab_extent_buffer(fs_info, p);
> +		if (exists) {
> +			spin_unlock(&mapping->private_lock);
> +			unlock_page(p);
> +			put_page(p);
> +			mark_extent_buffer_accessed(exists, p);
> +			btrfs_free_subpage(prealloc);
> +			goto free_eb;
> +		}
> +		/* Should not fail, as we have preallocated the memory */
> +		ret = attach_extent_buffer_page(eb, p, prealloc);
> +		ASSERT(!ret);
> +		/*
> +		 * To inform we have extra eb under allocation, so that
> +		 * detach_extent_buffer_page() won't release the page private
> +		 * when the eb hasn't yet been inserted into radix tree.
> +		 *
> +		 * The ref will be decreased when the eb released the page, in
> +		 * detach_extent_buffer_page().
> +		 * Thus needs no special handling in error path.
> +		 */
> +		btrfs_page_inc_eb_refs(fs_info, p);
> +		spin_unlock(&mapping->private_lock);
> +
> +		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
> +		eb->pages[i] = p;
> +		if (!PageUptodate(p))
> +			uptodate = 0;
> +
> +		/*
> +		 * We can't unlock the pages just yet since the extent buffer
> +		 * hasn't been properly inserted in the radix tree, this
> +		 * opens a race with btree_release_folio which can free a page
> +		 * while we are still filling in all pages for the buffer and
> +		 * we could crash.
> +		 */
> +	}
> +	if (uptodate)
> +		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +again:
> +	ret = radix_tree_preload(GFP_NOFS);
> +	if (ret) {
> +		exists = ERR_PTR(ret);
> +		goto free_eb;
> +	}
> +
> +	spin_lock(&fs_info->buffer_lock);
> +	ret = radix_tree_insert(&fs_info->buffer_radix,
> +				start >> fs_info->sectorsize_bits, eb);
> +	spin_unlock(&fs_info->buffer_lock);
> +	radix_tree_preload_end();
> +	if (ret == -EEXIST) {
> +		exists = find_extent_buffer(fs_info, start);
> +		if (exists)
> +			goto free_eb;
> +		else
> +			goto again;
> +	}
> +	/* add one reference for the tree */
> +	check_buffer_tree_ref(eb);
> +	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
> +
> +	/*
> +	 * Now it's safe to unlock the pages because any calls to
> +	 * btree_release_folio will correctly detect that a page belongs to a
> +	 * live buffer and won't free them prematurely.
> +	 */
> +	for (i = 0; i < num_pages; i++)
> +		unlock_page(eb->pages[i]);
> +	return eb;
> +
> +free_eb:
> +	WARN_ON(!atomic_dec_and_test(&eb->refs));
> +	for (i = 0; i < num_pages; i++) {
> +		if (eb->pages[i])
> +			unlock_page(eb->pages[i]);
> +	}
> +
> +	btrfs_release_extent_buffer(eb);
> +	return exists;
> +}
> +
> +static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
> +{
> +	struct extent_buffer *eb =
> +			container_of(head, struct extent_buffer, rcu_head);
> +
> +	__free_extent_buffer(eb);
> +}
> +
> +static int release_extent_buffer(struct extent_buffer *eb)
> +	__releases(&eb->refs_lock)
> +{
> +	lockdep_assert_held(&eb->refs_lock);
> +
> +	WARN_ON(atomic_read(&eb->refs) == 0);
> +	if (atomic_dec_and_test(&eb->refs)) {
> +		if (test_and_clear_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags)) {
> +			struct btrfs_fs_info *fs_info = eb->fs_info;
> +
> +			spin_unlock(&eb->refs_lock);
> +
> +			spin_lock(&fs_info->buffer_lock);
> +			radix_tree_delete(&fs_info->buffer_radix,
> +					  eb->start >> fs_info->sectorsize_bits);
> +			spin_unlock(&fs_info->buffer_lock);
> +		} else {
> +			spin_unlock(&eb->refs_lock);
> +		}
> +
> +		btrfs_leak_debug_del_eb(eb);
> +		/* Should be safe to release our pages at this point */
> +		btrfs_release_extent_buffer_pages(eb);
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> +		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
> +			__free_extent_buffer(eb);
> +			return 1;
> +		}
> +#endif
> +		call_rcu(&eb->rcu_head, btrfs_release_extent_buffer_rcu);
> +		return 1;
> +	}
> +	spin_unlock(&eb->refs_lock);
> +
> +	return 0;
> +}
> +
> +void free_extent_buffer(struct extent_buffer *eb)
> +{
> +	int refs;
> +	if (!eb)
> +		return;
> +
> +	refs = atomic_read(&eb->refs);
> +	while (1) {
> +		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
> +		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
> +			refs == 1))
> +			break;
> +		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
> +			return;
> +	}
> +
> +	spin_lock(&eb->refs_lock);
> +	if (atomic_read(&eb->refs) == 2 &&
> +	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
> +	    !extent_buffer_under_io(eb) &&
> +	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> +		atomic_dec(&eb->refs);
> +
> +	/*
> +	 * I know this is terrible, but it's temporary until we stop tracking
> +	 * the uptodate bits and such for the extent buffers.
> +	 */
> +	release_extent_buffer(eb);
> +}
> +
> +void free_extent_buffer_stale(struct extent_buffer *eb)
> +{
> +	if (!eb)
> +		return;
> +
> +	spin_lock(&eb->refs_lock);
> +	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
> +
> +	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
> +	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> +		atomic_dec(&eb->refs);
> +	release_extent_buffer(eb);
> +}
> +
> +static void btree_clear_page_dirty(struct page *page)
> +{
> +	ASSERT(PageDirty(page));
> +	ASSERT(PageLocked(page));
> +	clear_page_dirty_for_io(page);
> +	xa_lock_irq(&page->mapping->i_pages);
> +	if (!PageDirty(page))
> +		__xa_clear_mark(&page->mapping->i_pages,
> +				page_index(page), PAGECACHE_TAG_DIRTY);
> +	xa_unlock_irq(&page->mapping->i_pages);
> +}
> +
> +static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct page *page = eb->pages[0];
> +	bool last;
> +
> +	/* btree_clear_page_dirty() needs page locked */
> +	lock_page(page);
> +	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, eb->start,
> +						  eb->len);
> +	if (last)
> +		btree_clear_page_dirty(page);
> +	unlock_page(page);
> +	WARN_ON(atomic_read(&eb->refs) == 0);
> +}
> +
> +void clear_extent_buffer_dirty(const struct extent_buffer *eb)
> +{
> +	int i;
> +	int num_pages;
> +	struct page *page;
> +
> +	if (eb->fs_info->nodesize < PAGE_SIZE)
> +		return clear_subpage_extent_buffer_dirty(eb);
> +
> +	num_pages = num_extent_pages(eb);
> +
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +		if (!PageDirty(page))
> +			continue;
> +		lock_page(page);
> +		btree_clear_page_dirty(page);
> +		ClearPageError(page);
> +		unlock_page(page);
> +	}
> +	WARN_ON(atomic_read(&eb->refs) == 0);
> +}
> +
> +bool set_extent_buffer_dirty(struct extent_buffer *eb)
> +{
> +	int i;
> +	int num_pages;
> +	bool was_dirty;
> +
> +	check_buffer_tree_ref(eb);
> +
> +	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
> +
> +	num_pages = num_extent_pages(eb);
> +	WARN_ON(atomic_read(&eb->refs) == 0);
> +	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
> +
> +	if (!was_dirty) {
> +		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
> +
> +		/*
> +		 * For subpage case, we can have other extent buffers in the
> +		 * same page, and in clear_subpage_extent_buffer_dirty() we
> +		 * have to clear page dirty without subpage lock held.
> +		 * This can cause race where our page gets dirty cleared after
> +		 * we just set it.
> +		 *
> +		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
> +		 * its page for other reasons, we can use page lock to prevent
> +		 * the above race.
> +		 */
> +		if (subpage)
> +			lock_page(eb->pages[0]);
> +		for (i = 0; i < num_pages; i++)
> +			btrfs_page_set_dirty(eb->fs_info, eb->pages[i],
> +					     eb->start, eb->len);
> +		if (subpage)
> +			unlock_page(eb->pages[0]);
> +	}
> +#ifdef CONFIG_BTRFS_DEBUG
> +	for (i = 0; i < num_pages; i++)
> +		ASSERT(PageDirty(eb->pages[i]));
> +#endif
> +
> +	return was_dirty;
> +}
> +
> +void clear_extent_buffer_uptodate(struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct page *page;
> +	int num_pages;
> +	int i;
> +
> +	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +		if (!page)
> +			continue;
> +
> +		/*
> +		 * This is special handling for metadata subpage, as regular
> +		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
> +		 */
> +		if (fs_info->nodesize >= PAGE_SIZE)
> +			ClearPageUptodate(page);
> +		else
> +			btrfs_subpage_clear_uptodate(fs_info, page, eb->start,
> +						     eb->len);
> +	}
> +}
> +
> +void set_extent_buffer_uptodate(struct extent_buffer *eb)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct page *page;
> +	int num_pages;
> +	int i;
> +
> +	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +
> +		/*
> +		 * This is special handling for metadata subpage, as regular
> +		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
> +		 */
> +		if (fs_info->nodesize >= PAGE_SIZE)
> +			SetPageUptodate(page);
> +		else
> +			btrfs_subpage_set_uptodate(fs_info, page, eb->start,
> +						   eb->len);
> +	}
> +}
> +
> +static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
> +				      int mirror_num,
> +				      struct btrfs_tree_parent_check *check)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct extent_io_tree *io_tree;
> +	struct page *page = eb->pages[0];
> +	struct extent_state *cached_state = NULL;
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.mirror_num = mirror_num,
> +		.parent_check = check,
> +	};
> +	int ret = 0;
> +
> +	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
> +	ASSERT(PagePrivate(page));
> +	ASSERT(check);
> +	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
> +
> +	if (wait == WAIT_NONE) {
> +		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> +				     &cached_state))
> +			return -EAGAIN;
> +	} else {
> +		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> +				  &cached_state);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = 0;
> +	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
> +	    PageUptodate(page) ||
> +	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
> +		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> +			      &cached_state);
> +		return ret;
> +	}
> +
> +	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +	eb->read_mirror = 0;
> +	atomic_set(&eb->io_pages, 1);
> +	check_buffer_tree_ref(eb);
> +	bio_ctrl.end_io_func = end_bio_extent_readpage;
> +
> +	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
> +
> +	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> +	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
> +				 eb->start, page, eb->len,
> +				 eb->start - page_offset(page), 0, true);
> +	if (ret) {
> +		/*
> +		 * In the endio function, if we hit something wrong we will
> +		 * increase the io_pages, so here we need to decrease it for
> +		 * error path.
> +		 */
> +		atomic_dec(&eb->io_pages);
> +	}
> +	submit_one_bio(&bio_ctrl);
> +	if (ret || wait != WAIT_COMPLETE) {
> +		free_extent_state(cached_state);
> +		return ret;
> +	}
> +
> +	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
> +			EXTENT_LOCKED, &cached_state);
> +	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> +		ret = -EIO;
> +	return ret;
> +}
> +
> +int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
> +			     struct btrfs_tree_parent_check *check)
> +{
> +	int i;
> +	struct page *page;
> +	int err;
> +	int ret = 0;
> +	int locked_pages = 0;
> +	int all_uptodate = 1;
> +	int num_pages;
> +	unsigned long num_reads = 0;
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.mirror_num = mirror_num,
> +		.parent_check = check,
> +	};
> +
> +	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> +		return 0;
> +
> +	/*
> +	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
> +	 * operation, which could potentially still be in flight.  In this case
> +	 * we simply want to return an error.
> +	 */
> +	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
> +		return -EIO;
> +
> +	if (eb->fs_info->nodesize < PAGE_SIZE)
> +		return read_extent_buffer_subpage(eb, wait, mirror_num, check);
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +		if (wait == WAIT_NONE) {
> +			/*
> +			 * WAIT_NONE is only utilized by readahead. If we can't
> +			 * acquire the lock atomically it means either the eb
> +			 * is being read out or under modification.
> +			 * Either way the eb will be or has been cached,
> +			 * readahead can exit safely.
> +			 */
> +			if (!trylock_page(page))
> +				goto unlock_exit;
> +		} else {
> +			lock_page(page);
> +		}
> +		locked_pages++;
> +	}
> +	/*
> +	 * We need to firstly lock all pages to make sure that
> +	 * the uptodate bit of our pages won't be affected by
> +	 * clear_extent_buffer_uptodate().
> +	 */
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +		if (!PageUptodate(page)) {
> +			num_reads++;
> +			all_uptodate = 0;
> +		}
> +	}
> +
> +	if (all_uptodate) {
> +		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +		goto unlock_exit;
> +	}
> +
> +	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +	eb->read_mirror = 0;
> +	atomic_set(&eb->io_pages, num_reads);
> +	/*
> +	 * It is possible for release_folio to clear the TREE_REF bit before we
> +	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
> +	 */
> +	check_buffer_tree_ref(eb);
> +	bio_ctrl.end_io_func = end_bio_extent_readpage;
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +
> +		if (!PageUptodate(page)) {
> +			if (ret) {
> +				atomic_dec(&eb->io_pages);
> +				unlock_page(page);
> +				continue;
> +			}
> +
> +			ClearPageError(page);
> +			err = submit_extent_page(REQ_OP_READ, NULL,
> +					 &bio_ctrl, page_offset(page), page,
> +					 PAGE_SIZE, 0, 0, false);
> +			if (err) {
> +				/*
> +				 * We failed to submit the bio so it's the
> +				 * caller's responsibility to perform cleanup
> +				 * i.e unlock page/set error bit.
> +				 */
> +				ret = err;
> +				SetPageError(page);
> +				unlock_page(page);
> +				atomic_dec(&eb->io_pages);
> +			}
> +		} else {
> +			unlock_page(page);
> +		}
> +	}
> +
> +	submit_one_bio(&bio_ctrl);
> +
> +	if (ret || wait != WAIT_COMPLETE)
> +		return ret;
> +
> +	for (i = 0; i < num_pages; i++) {
> +		page = eb->pages[i];
> +		wait_on_page_locked(page);
> +		if (!PageUptodate(page))
> +			ret = -EIO;
> +	}
> +
> +	return ret;
> +
> +unlock_exit:
> +	while (locked_pages > 0) {
> +		locked_pages--;
> +		page = eb->pages[locked_pages];
> +		unlock_page(page);
> +	}
> +	return ret;
> +}
> +
> +static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
> +			    unsigned long len)
> +{
> +	btrfs_warn(eb->fs_info,
> +		"access to eb bytenr %llu len %lu out of range start %lu len %lu",
> +		eb->start, eb->len, start, len);
> +	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +
> +	return true;
> +}
> +
> +/*
> + * Check if the [start, start + len) range is valid before reading/writing
> + * the eb.
> + * NOTE: @start and @len are offset inside the eb, not logical address.
> + *
> + * Caller should not touch the dst/src memory if this function returns error.
> + */
> +static inline int check_eb_range(const struct extent_buffer *eb,
> +				 unsigned long start, unsigned long len)
> +{
> +	unsigned long offset;
> +
> +	/* start, start + len should not go beyond eb->len nor overflow */
> +	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
> +		return report_eb_range(eb, start, len);
> +
> +	return false;
> +}
> +
> +void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
> +			unsigned long start, unsigned long len)
> +{
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	char *dst = (char *)dstv;
> +	unsigned long i = get_eb_page_index(start);
> +
> +	if (check_eb_range(eb, start, len))
> +		return;
> +
> +	offset = get_eb_offset_in_page(eb, start);
> +
> +	while (len > 0) {
> +		page = eb->pages[i];
> +
> +		cur = min(len, (PAGE_SIZE - offset));
> +		kaddr = page_address(page);
> +		memcpy(dst, kaddr + offset, cur);
> +
> +		dst += cur;
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +}
> +
> +int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
> +				       void __user *dstv,
> +				       unsigned long start, unsigned long len)
> +{
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	char __user *dst = (char __user *)dstv;
> +	unsigned long i = get_eb_page_index(start);
> +	int ret = 0;
> +
> +	WARN_ON(start > eb->len);
> +	WARN_ON(start + len > eb->start + eb->len);
> +
> +	offset = get_eb_offset_in_page(eb, start);
> +
> +	while (len > 0) {
> +		page = eb->pages[i];
> +
> +		cur = min(len, (PAGE_SIZE - offset));
> +		kaddr = page_address(page);
> +		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		dst += cur;
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +
> +	return ret;
> +}
> +
> +int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
> +			 unsigned long start, unsigned long len)
> +{
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	char *ptr = (char *)ptrv;
> +	unsigned long i = get_eb_page_index(start);
> +	int ret = 0;
> +
> +	if (check_eb_range(eb, start, len))
> +		return -EINVAL;
> +
> +	offset = get_eb_offset_in_page(eb, start);
> +
> +	while (len > 0) {
> +		page = eb->pages[i];
> +
> +		cur = min(len, (PAGE_SIZE - offset));
> +
> +		kaddr = page_address(page);
> +		ret = memcmp(ptr, kaddr + offset, cur);
> +		if (ret)
> +			break;
> +
> +		ptr += cur;
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Check that the extent buffer is uptodate.
> + *
> + * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
> + * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
> + */
> +static void assert_eb_page_uptodate(const struct extent_buffer *eb,
> +				    struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +
> +	/*
> +	 * If we are using the commit root we could potentially clear a page
> +	 * Uptodate while we're using the extent buffer that we've previously
> +	 * looked up.  We don't want to complain in this case, as the page was
> +	 * valid before, we just didn't write it out.  Instead we want to catch
> +	 * the case where we didn't actually read the block properly, which
> +	 * would have !PageUptodate && !PageError, as we clear PageError before
> +	 * reading.
> +	 */
> +	if (fs_info->nodesize < PAGE_SIZE) {
> +		bool uptodate, error;
> +
> +		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
> +						       eb->start, eb->len);
> +		error = btrfs_subpage_test_error(fs_info, page, eb->start, eb->len);
> +		WARN_ON(!uptodate && !error);
> +	} else {
> +		WARN_ON(!PageUptodate(page) && !PageError(page));
> +	}
> +}
> +
> +void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
> +		const void *srcv)
> +{
> +	char *kaddr;
> +
> +	assert_eb_page_uptodate(eb, eb->pages[0]);
> +	kaddr = page_address(eb->pages[0]) +
> +		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
> +						   chunk_tree_uuid));
> +	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> +}
> +
> +void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
> +{
> +	char *kaddr;
> +
> +	assert_eb_page_uptodate(eb, eb->pages[0]);
> +	kaddr = page_address(eb->pages[0]) +
> +		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
> +	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> +}
> +
> +void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
> +			 unsigned long start, unsigned long len)
> +{
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	char *src = (char *)srcv;
> +	unsigned long i = get_eb_page_index(start);
> +
> +	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
> +
> +	if (check_eb_range(eb, start, len))
> +		return;
> +
> +	offset = get_eb_offset_in_page(eb, start);
> +
> +	while (len > 0) {
> +		page = eb->pages[i];
> +		assert_eb_page_uptodate(eb, page);
> +
> +		cur = min(len, PAGE_SIZE - offset);
> +		kaddr = page_address(page);
> +		memcpy(kaddr + offset, src, cur);
> +
> +		src += cur;
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +}
> +
> +void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
> +		unsigned long len)
> +{
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	unsigned long i = get_eb_page_index(start);
> +
> +	if (check_eb_range(eb, start, len))
> +		return;
> +
> +	offset = get_eb_offset_in_page(eb, start);
> +
> +	while (len > 0) {
> +		page = eb->pages[i];
> +		assert_eb_page_uptodate(eb, page);
> +
> +		cur = min(len, PAGE_SIZE - offset);
> +		kaddr = page_address(page);
> +		memset(kaddr + offset, 0, cur);
> +
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +}
> +
> +void copy_extent_buffer_full(const struct extent_buffer *dst,
> +			     const struct extent_buffer *src)
> +{
> +	int i;
> +	int num_pages;
> +
> +	ASSERT(dst->len == src->len);
> +
> +	if (dst->fs_info->nodesize >= PAGE_SIZE) {
> +		num_pages = num_extent_pages(dst);
> +		for (i = 0; i < num_pages; i++)
> +			copy_page(page_address(dst->pages[i]),
> +				  page_address(src->pages[i]));
> +	} else {
> +		size_t src_offset = get_eb_offset_in_page(src, 0);
> +		size_t dst_offset = get_eb_offset_in_page(dst, 0);
> +
> +		ASSERT(src->fs_info->nodesize < PAGE_SIZE);
> +		memcpy(page_address(dst->pages[0]) + dst_offset,
> +		       page_address(src->pages[0]) + src_offset,
> +		       src->len);
> +	}
> +}
> +
> +void copy_extent_buffer(const struct extent_buffer *dst,
> +			const struct extent_buffer *src,
> +			unsigned long dst_offset, unsigned long src_offset,
> +			unsigned long len)
> +{
> +	u64 dst_len = dst->len;
> +	size_t cur;
> +	size_t offset;
> +	struct page *page;
> +	char *kaddr;
> +	unsigned long i = get_eb_page_index(dst_offset);
> +
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(src, src_offset, len))
> +		return;
> +
> +	WARN_ON(src->len != dst_len);
> +
> +	offset = get_eb_offset_in_page(dst, dst_offset);
> +
> +	while (len > 0) {
> +		page = dst->pages[i];
> +		assert_eb_page_uptodate(dst, page);
> +
> +		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
> +
> +		kaddr = page_address(page);
> +		read_extent_buffer(src, kaddr + offset, src_offset, cur);
> +
> +		src_offset += cur;
> +		len -= cur;
> +		offset = 0;
> +		i++;
> +	}
> +}
> +
> +/*
> + * eb_bitmap_offset() - calculate the page and offset of the byte containing the
> + * given bit number
> + * @eb: the extent buffer
> + * @start: offset of the bitmap item in the extent buffer
> + * @nr: bit number
> + * @page_index: return index of the page in the extent buffer that contains the
> + * given bit number
> + * @page_offset: return offset into the page given by page_index
> + *
> + * This helper hides the ugliness of finding the byte in an extent buffer which
> + * contains a given bit.
> + */
> +static inline void eb_bitmap_offset(const struct extent_buffer *eb,
> +				    unsigned long start, unsigned long nr,
> +				    unsigned long *page_index,
> +				    size_t *page_offset)
> +{
> +	size_t byte_offset = BIT_BYTE(nr);
> +	size_t offset;
> +
> +	/*
> +	 * The byte we want is the offset of the extent buffer + the offset of
> +	 * the bitmap item in the extent buffer + the offset of the byte in the
> +	 * bitmap item.
> +	 */
> +	offset = start + offset_in_page(eb->start) + byte_offset;
> +
> +	*page_index = offset >> PAGE_SHIFT;
> +	*page_offset = offset_in_page(offset);
> +}
> +
> +/*
> + * Determine whether a bit in a bitmap item is set.
> + *
> + * @eb:     the extent buffer
> + * @start:  offset of the bitmap item in the extent buffer
> + * @nr:     bit number to test
> + */
> +int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
> +			   unsigned long nr)
> +{
> +	u8 *kaddr;
> +	struct page *page;
> +	unsigned long i;
> +	size_t offset;
> +
> +	eb_bitmap_offset(eb, start, nr, &i, &offset);
> +	page = eb->pages[i];
> +	assert_eb_page_uptodate(eb, page);
> +	kaddr = page_address(page);
> +	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
> +}
> +
> +/*
> + * Set an area of a bitmap to 1.
> + *
> + * @eb:     the extent buffer
> + * @start:  offset of the bitmap item in the extent buffer
> + * @pos:    bit number of the first bit
> + * @len:    number of bits to set
> + */
> +void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
> +			      unsigned long pos, unsigned long len)
> +{
> +	u8 *kaddr;
> +	struct page *page;
> +	unsigned long i;
> +	size_t offset;
> +	const unsigned int size = pos + len;
> +	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> +	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
> +
> +	eb_bitmap_offset(eb, start, pos, &i, &offset);
> +	page = eb->pages[i];
> +	assert_eb_page_uptodate(eb, page);
> +	kaddr = page_address(page);
> +
> +	while (len >= bits_to_set) {
> +		kaddr[offset] |= mask_to_set;
> +		len -= bits_to_set;
> +		bits_to_set = BITS_PER_BYTE;
> +		mask_to_set = ~0;
> +		if (++offset >= PAGE_SIZE && len > 0) {
> +			offset = 0;
> +			page = eb->pages[++i];
> +			assert_eb_page_uptodate(eb, page);
> +			kaddr = page_address(page);
> +		}
> +	}
> +	if (len) {
> +		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
> +		kaddr[offset] |= mask_to_set;
> +	}
> +}
> +
> +
> +/*
> + * Clear an area of a bitmap.
> + *
> + * @eb:     the extent buffer
> + * @start:  offset of the bitmap item in the extent buffer
> + * @pos:    bit number of the first bit
> + * @len:    number of bits to clear
> + */
> +void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
> +				unsigned long start, unsigned long pos,
> +				unsigned long len)
> +{
> +	u8 *kaddr;
> +	struct page *page;
> +	unsigned long i;
> +	size_t offset;
> +	const unsigned int size = pos + len;
> +	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> +	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
> +
> +	eb_bitmap_offset(eb, start, pos, &i, &offset);
> +	page = eb->pages[i];
> +	assert_eb_page_uptodate(eb, page);
> +	kaddr = page_address(page);
> +
> +	while (len >= bits_to_clear) {
> +		kaddr[offset] &= ~mask_to_clear;
> +		len -= bits_to_clear;
> +		bits_to_clear = BITS_PER_BYTE;
> +		mask_to_clear = ~0;
> +		if (++offset >= PAGE_SIZE && len > 0) {
> +			offset = 0;
> +			page = eb->pages[++i];
> +			assert_eb_page_uptodate(eb, page);
> +			kaddr = page_address(page);
> +		}
> +	}
> +	if (len) {
> +		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
> +		kaddr[offset] &= ~mask_to_clear;
> +	}
> +}
> +
> +static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned long len)
> +{
> +	unsigned long distance = (src > dst) ? src - dst : dst - src;
> +	return distance < len;
> +}
> +
> +static void copy_pages(struct page *dst_page, struct page *src_page,
> +		       unsigned long dst_off, unsigned long src_off,
> +		       unsigned long len)
> +{
> +	char *dst_kaddr = page_address(dst_page);
> +	char *src_kaddr;
> +	int must_memmove = 0;
> +
> +	if (dst_page != src_page) {
> +		src_kaddr = page_address(src_page);
> +	} else {
> +		src_kaddr = dst_kaddr;
> +		if (areas_overlap(src_off, dst_off, len))
> +			must_memmove = 1;
> +	}
> +
> +	if (must_memmove)
> +		memmove(dst_kaddr + dst_off, src_kaddr + src_off, len);
> +	else
> +		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
> +}
> +
> +void memcpy_extent_buffer(const struct extent_buffer *dst,
> +			  unsigned long dst_offset, unsigned long src_offset,
> +			  unsigned long len)
> +{
> +	size_t cur;
> +	size_t dst_off_in_page;
> +	size_t src_off_in_page;
> +	unsigned long dst_i;
> +	unsigned long src_i;
> +
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(dst, src_offset, len))
> +		return;
> +
> +	while (len > 0) {
> +		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
> +		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
> +
> +		dst_i = get_eb_page_index(dst_offset);
> +		src_i = get_eb_page_index(src_offset);
> +
> +		cur = min(len, (unsigned long)(PAGE_SIZE -
> +					       src_off_in_page));
> +		cur = min_t(unsigned long, cur,
> +			(unsigned long)(PAGE_SIZE - dst_off_in_page));
> +
> +		copy_pages(dst->pages[dst_i], dst->pages[src_i],
> +			   dst_off_in_page, src_off_in_page, cur);
> +
> +		src_offset += cur;
> +		dst_offset += cur;
> +		len -= cur;
> +	}
> +}
> +
> +void memmove_extent_buffer(const struct extent_buffer *dst,
> +			   unsigned long dst_offset, unsigned long src_offset,
> +			   unsigned long len)
> +{
> +	size_t cur;
> +	size_t dst_off_in_page;
> +	size_t src_off_in_page;
> +	unsigned long dst_end = dst_offset + len - 1;
> +	unsigned long src_end = src_offset + len - 1;
> +	unsigned long dst_i;
> +	unsigned long src_i;
> +
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(dst, src_offset, len))
> +		return;
> +	if (dst_offset < src_offset) {
> +		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
> +		return;
> +	}
> +	while (len > 0) {
> +		dst_i = get_eb_page_index(dst_end);
> +		src_i = get_eb_page_index(src_end);
> +
> +		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
> +		src_off_in_page = get_eb_offset_in_page(dst, src_end);
> +
> +		cur = min_t(unsigned long, len, src_off_in_page + 1);
> +		cur = min(cur, dst_off_in_page + 1);
> +		copy_pages(dst->pages[dst_i], dst->pages[src_i],
> +			   dst_off_in_page - cur + 1,
> +			   src_off_in_page - cur + 1, cur);
> +
> +		dst_end -= cur;
> +		src_end -= cur;
> +		len -= cur;
> +	}
> +}
> +
> +#define GANG_LOOKUP_SIZE	16
> +static struct extent_buffer *get_next_extent_buffer(
> +		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
> +{
> +	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> +	struct extent_buffer *found = NULL;
> +	u64 page_start = page_offset(page);
> +	u64 cur = page_start;
> +
> +	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> +	lockdep_assert_held(&fs_info->buffer_lock);
> +
> +	while (cur < page_start + PAGE_SIZE) {
> +		int ret;
> +		int i;
> +
> +		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> +				(void **)gang, cur >> fs_info->sectorsize_bits,
> +				min_t(unsigned int, GANG_LOOKUP_SIZE,
> +				      PAGE_SIZE / fs_info->nodesize));
> +		if (ret == 0)
> +			goto out;
> +		for (i = 0; i < ret; i++) {
> +			/* Already beyond page end */
> +			if (gang[i]->start >= page_start + PAGE_SIZE)
> +				goto out;
> +			/* Found one */
> +			if (gang[i]->start >= bytenr) {
> +				found = gang[i];
> +				goto out;
> +			}
> +		}
> +		cur = gang[ret - 1]->start + gang[ret - 1]->len;
> +	}
> +out:
> +	return found;
> +}
> +
> +static int try_release_subpage_extent_buffer(struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	u64 cur = page_offset(page);
> +	const u64 end = page_offset(page) + PAGE_SIZE;
> +	int ret;
> +
> +	while (cur < end) {
> +		struct extent_buffer *eb = NULL;
> +
> +		/*
> +		 * Unlike try_release_extent_buffer() which uses page->private
> +		 * to grab buffer, for subpage case we rely on radix tree, thus
> +		 * we need to ensure radix tree consistency.
> +		 *
> +		 * We also want an atomic snapshot of the radix tree, thus go
> +		 * with spinlock rather than RCU.
> +		 */
> +		spin_lock(&fs_info->buffer_lock);
> +		eb = get_next_extent_buffer(fs_info, page, cur);
> +		if (!eb) {
> +			/* No more eb in the page range after or at cur */
> +			spin_unlock(&fs_info->buffer_lock);
> +			break;
> +		}
> +		cur = eb->start + eb->len;
> +
> +		/*
> +		 * The same as try_release_extent_buffer(), to ensure the eb
> +		 * won't disappear out from under us.
> +		 */
> +		spin_lock(&eb->refs_lock);
> +		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> +			spin_unlock(&eb->refs_lock);
> +			spin_unlock(&fs_info->buffer_lock);
> +			break;
> +		}
> +		spin_unlock(&fs_info->buffer_lock);
> +
> +		/*
> +		 * If tree ref isn't set then we know the ref on this eb is a
> +		 * real ref, so just return, this eb will likely be freed soon
> +		 * anyway.
> +		 */
> +		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
> +			spin_unlock(&eb->refs_lock);
> +			break;
> +		}
> +
> +		/*
> +		 * Here we don't care about the return value, we will always
> +		 * check the page private at the end.  And
> +		 * release_extent_buffer() will release the refs_lock.
> +		 */
> +		release_extent_buffer(eb);
> +	}
> +	/*
> +	 * Finally to check if we have cleared page private, as if we have
> +	 * released all ebs in the page, the page private should be cleared now.
> +	 */
> +	spin_lock(&page->mapping->private_lock);
> +	if (!PagePrivate(page))
> +		ret = 1;
> +	else
> +		ret = 0;
> +	spin_unlock(&page->mapping->private_lock);
> +	return ret;
> +
> +}
> +
> +int try_release_extent_buffer(struct page *page)
> +{
> +	struct extent_buffer *eb;
> +
> +	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
> +		return try_release_subpage_extent_buffer(page);
> +
> +	/*
> +	 * We need to make sure nobody is changing page->private, as we rely on
> +	 * page->private as the pointer to extent buffer.
> +	 */
> +	spin_lock(&page->mapping->private_lock);
> +	if (!PagePrivate(page)) {
> +		spin_unlock(&page->mapping->private_lock);
> +		return 1;
> +	}
> +
> +	eb = (struct extent_buffer *)page->private;
> +	BUG_ON(!eb);
> +
> +	/*
> +	 * This is a little awful but should be ok, we need to make sure that
> +	 * the eb doesn't disappear out from under us while we're looking at
> +	 * this page.
> +	 */
> +	spin_lock(&eb->refs_lock);
> +	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> +		spin_unlock(&eb->refs_lock);
> +		spin_unlock(&page->mapping->private_lock);
> +		return 0;
> +	}
> +	spin_unlock(&page->mapping->private_lock);
> +
> +	/*
> +	 * If tree ref isn't set then we know the ref on this eb is a real ref,
> +	 * so just return, this page will likely be freed soon anyway.
> +	 */
> +	if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
> +		spin_unlock(&eb->refs_lock);
> +		return 0;
> +	}
> +
> +	return release_extent_buffer(eb);
> +}
> +
> +/*
> + * btrfs_readahead_tree_block - attempt to readahead a child block
> + * @fs_info:	the fs_info
> + * @bytenr:	bytenr to read
> + * @owner_root: objectid of the root that owns this eb
> + * @gen:	generation for the uptodate check, can be 0
> + * @level:	level for the eb
> + *
> + * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we do a
> + * normal uptodate check of the eb, without checking the generation.  If we have
> + * to read the block we will not block on anything.
> + */
> +void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> +				u64 bytenr, u64 owner_root, u64 gen, int level)
> +{
> +	struct btrfs_tree_parent_check check = {
> +		.has_first_key = 0,
> +		.level = level,
> +		.transid = gen
> +	};
> +	struct extent_buffer *eb;
> +	int ret;
> +
> +	eb = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
> +	if (IS_ERR(eb))
> +		return;
> +
> +	if (btrfs_buffer_uptodate(eb, gen, 1)) {
> +		free_extent_buffer(eb);
> +		return;
> +	}
> +
> +	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0, &check);
> +	if (ret < 0)
> +		free_extent_buffer_stale(eb);
> +	else
> +		free_extent_buffer(eb);
> +}
> +
> +/*
> + * btrfs_readahead_node_child - readahead a node's child block
> + * @node:	parent node we're reading from
> + * @slot:	slot in the parent node for the child we want to read
> + *
> + * A helper for btrfs_readahead_tree_block, we simply read the bytenr pointed at
> + * the slot in the node provided.
> + */
> +void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
> +{
> +	btrfs_readahead_tree_block(node->fs_info,
> +				   btrfs_node_blockptr(node, slot),
> +				   btrfs_header_owner(node),
> +				   btrfs_node_ptr_generation(node, slot),
> +				   btrfs_header_level(node) - 1);
> +}
> +
> +int __init extent_buffer_init_cachep(void)
> +{
> +	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
> +			sizeof(struct extent_buffer), 0,
> +			SLAB_MEM_SPREAD, NULL);
> +	if (!extent_buffer_cache)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void __cold extent_buffer_free_cachep(void)
> +{
> +	/*
> +	 * Make sure all delayed rcu free are flushed before we
> +	 * destroy caches.
> +	 */
> +	rcu_barrier();
> +	kmem_cache_destroy(extent_buffer_cache);
> +}
> +
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9bd32daa9b9a6f..cd12c60d9b99f6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2,7 +2,6 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/slab.h>
> -#include <linux/bio.h>
>   #include <linux/mm.h>
>   #include <linux/pagemap.h>
>   #include <linux/page-flags.h>
> @@ -20,7 +19,6 @@
>   #include "extent_map.h"
>   #include "ctree.h"
>   #include "btrfs_inode.h"
> -#include "bio.h"
>   #include "check-integrity.h"
>   #include "locking.h"
>   #include "rcu-string.h"
> @@ -37,92 +35,7 @@
>   #include "dev-replace.h"
>   #include "super.h"
>   
> -static struct kmem_cache *extent_buffer_cache;
> -
> -#ifdef CONFIG_BTRFS_DEBUG
> -static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> -	list_add(&eb->leak_list, &fs_info->allocated_ebs);
> -	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> -}
> -
> -static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> -	list_del(&eb->leak_list);
> -	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> -}
> -
> -void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
> -{
> -	struct extent_buffer *eb;
> -	unsigned long flags;
> -
> -	/*
> -	 * If we didn't get into open_ctree our allocated_ebs will not be
> -	 * initialized, so just skip this.
> -	 */
> -	if (!fs_info->allocated_ebs.next)
> -		return;
> -
> -	WARN_ON(!list_empty(&fs_info->allocated_ebs));
> -	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> -	while (!list_empty(&fs_info->allocated_ebs)) {
> -		eb = list_first_entry(&fs_info->allocated_ebs,
> -				      struct extent_buffer, leak_list);
> -		pr_err(
> -	"BTRFS: buffer leak start %llu len %lu refs %d bflags %lu owner %llu\n",
> -		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
> -		       btrfs_header_owner(eb));
> -		list_del(&eb->leak_list);
> -		kmem_cache_free(extent_buffer_cache, eb);
> -	}
> -	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> -}
> -#else
> -#define btrfs_leak_debug_add_eb(eb)			do {} while (0)
> -#define btrfs_leak_debug_del_eb(eb)			do {} while (0)
> -#endif
> -
> -/*
> - * Structure to record info about the bio being assembled, and other info like
> - * how many bytes are there before stripe/ordered extent boundary.
> - */
> -struct btrfs_bio_ctrl {
> -	struct bio *bio;
> -	int mirror_num;
> -	enum btrfs_compression_type compress_type;
> -	u32 len_to_stripe_boundary;
> -	u32 len_to_oe_boundary;
> -	btrfs_bio_end_io_t end_io_func;
> -
> -	/*
> -	 * This is for metadata read, to provide the extra needed verification
> -	 * info.  This has to be provided for submit_one_bio(), as
> -	 * submit_one_bio() can submit a bio if it ends at stripe boundary.  If
> -	 * no such parent_check is provided, the metadata can hit false alert at
> -	 * endio time.
> -	 */
> -	struct btrfs_tree_parent_check *parent_check;
> -
> -	/*
> -	 * Tell writepage not to lock the state bits for this range, it still
> -	 * does the unlocking.
> -	 */
> -	bool extent_locked;
> -
> -	/* Tell the submit_bio code to use REQ_SYNC */
> -	bool sync_io;
> -};
> -
> -static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> +void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct bio *bio;
>   	struct bio_vec *bv;
> @@ -168,7 +81,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   /*
>    * Submit or fail the current bio in the bio_ctrl structure.
>    */
> -static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
> +void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
>   {
>   	struct bio *bio = bio_ctrl->bio;
>   
> @@ -185,27 +98,6 @@ static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
>   	}
>   }
>   
> -int __init extent_buffer_init_cachep(void)
> -{
> -	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
> -			sizeof(struct extent_buffer), 0,
> -			SLAB_MEM_SPREAD, NULL);
> -	if (!extent_buffer_cache)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -void __cold extent_buffer_free_cachep(void)
> -{
> -	/*
> -	 * Make sure all delayed rcu free are flushed before we
> -	 * destroy caches.
> -	 */
> -	rcu_barrier();
> -	kmem_cache_destroy(extent_buffer_cache);
> -}
> -
>   void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
>   {
>   	unsigned long index = start >> PAGE_SHIFT;
> @@ -1073,7 +965,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
>    * Scheduling is not allowed, so the extent state tree is expected
>    * to have one and only one object corresponding to this IO.
>    */
> -static void end_bio_extent_readpage(struct btrfs_bio *bbio)
> +void end_bio_extent_readpage(struct btrfs_bio *bbio)
>   {
>   	struct bio *bio = &bbio->bio;
>   	struct bio_vec *bvec;
> @@ -1464,13 +1356,11 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>    * The mirror number for this IO should already be initizlied in
>    * @bio_ctrl->mirror_num.
>    */
> -static int submit_extent_page(blk_opf_t opf,
> -			      struct writeback_control *wbc,
> -			      struct btrfs_bio_ctrl *bio_ctrl,
> -			      u64 disk_bytenr, struct page *page,
> -			      size_t size, unsigned long pg_offset,
> -			      enum btrfs_compression_type compress_type,
> -			      bool force_bio_submit)
> +int submit_extent_page(blk_opf_t opf, struct writeback_control *wbc,
> +		       struct btrfs_bio_ctrl *bio_ctrl, u64 disk_bytenr,
> +		       struct page *page, size_t size, unsigned long pg_offset,
> +		       enum btrfs_compression_type compress_type,
> +		       bool force_bio_submit)
>   {
>   	int ret = 0;
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> @@ -1531,46 +1421,6 @@ static int submit_extent_page(blk_opf_t opf,
>   	return 0;
>   }
>   
> -static int attach_extent_buffer_page(struct extent_buffer *eb,
> -				     struct page *page,
> -				     struct btrfs_subpage *prealloc)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	int ret = 0;
> -
> -	/*
> -	 * If the page is mapped to btree inode, we should hold the private
> -	 * lock to prevent race.
> -	 * For cloned or dummy extent buffers, their pages are not mapped and
> -	 * will not race with any other ebs.
> -	 */
> -	if (page->mapping)
> -		lockdep_assert_held(&page->mapping->private_lock);
> -
> -	if (fs_info->nodesize >= PAGE_SIZE) {
> -		if (!PagePrivate(page))
> -			attach_page_private(page, eb);
> -		else
> -			WARN_ON(page->private != (unsigned long)eb);
> -		return 0;
> -	}
> -
> -	/* Already mapped, just free prealloc */
> -	if (PagePrivate(page)) {
> -		btrfs_free_subpage(prealloc);
> -		return 0;
> -	}
> -
> -	if (prealloc)
> -		/* Has preallocated memory for subpage */
> -		attach_page_private(page, prealloc);
> -	else
> -		/* Do new allocation to attach subpage */
> -		ret = btrfs_attach_subpage(fs_info, page,
> -					   BTRFS_SUBPAGE_METADATA);
> -	return ret;
> -}
> -
>   int set_page_extent_mapped(struct page *page)
>   {
>   	struct btrfs_fs_info *fs_info;
> @@ -2239,1115 +2089,385 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   	return ret;
>   }
>   
> -void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
> -{
> -	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
> -		       TASK_UNINTERRUPTIBLE);
> -}
> -
> -static void end_extent_buffer_writeback(struct extent_buffer *eb)
> -{
> -	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> -	smp_mb__after_atomic();
> -	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> -}
> -
>   /*
> - * Lock extent buffer status and pages for writeback.
> + * Walk the list of dirty pages of the given address space and write all of them.
>    *
> - * May try to flush write bio if we can't get the lock.
> + * @mapping:   address space structure to write
> + * @wbc:       subtract the number of written pages from *@wbc->nr_to_write
> + * @bio_ctrl:  holds context for the write, namely the bio
>    *
> - * Return  0 if the extent buffer doesn't need to be submitted.
> - *           (E.g. the extent buffer is not dirty)
> - * Return >0 is the extent buffer is submitted to bio.
> - * Return <0 if something went wrong, no page is locked.
> + * If a page is already under I/O, write_cache_pages() skips it, even
> + * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
> + * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
> + * and msync() need to guarantee that all the data which was dirty at the time
> + * the call was made get new I/O started against them.  If wbc->sync_mode is
> + * WB_SYNC_ALL then we were called for data integrity and we must wait for
> + * existing IO to complete.
>    */
> -static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
> -			  struct btrfs_bio_ctrl *bio_ctrl)
> +static int extent_write_cache_pages(struct address_space *mapping,
> +			     struct writeback_control *wbc,
> +			     struct btrfs_bio_ctrl *bio_ctrl)
>   {
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	int i, num_pages;
> -	int flush = 0;
> +	struct inode *inode = mapping->host;
>   	int ret = 0;
> -
> -	if (!btrfs_try_tree_write_lock(eb)) {
> -		submit_write_bio(bio_ctrl, 0);
> -		flush = 1;
> -		btrfs_tree_lock(eb);
> -	}
> -
> -	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
> -		btrfs_tree_unlock(eb);
> -		if (!bio_ctrl->sync_io)
> -			return 0;
> -		if (!flush) {
> -			submit_write_bio(bio_ctrl, 0);
> -			flush = 1;
> -		}
> -		while (1) {
> -			wait_on_extent_buffer_writeback(eb);
> -			btrfs_tree_lock(eb);
> -			if (!test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags))
> -				break;
> -			btrfs_tree_unlock(eb);
> -		}
> -	}
> +	int done = 0;
> +	int nr_to_write_done = 0;
> +	struct pagevec pvec;
> +	int nr_pages;
> +	pgoff_t index;
> +	pgoff_t end;		/* Inclusive */
> +	pgoff_t done_index;
> +	int range_whole = 0;
> +	int scanned = 0;
> +	xa_mark_t tag;
>   
>   	/*
> -	 * We need to do this to prevent races in people who check if the eb is
> -	 * under IO since we can end up having no IO bits set for a short period
> -	 * of time.
> +	 * We have to hold onto the inode so that ordered extents can do their
> +	 * work when the IO finishes.  The alternative to this is failing to add
> +	 * an ordered extent if the igrab() fails there and that is a huge pain
> +	 * to deal with, so instead just hold onto the inode throughout the
> +	 * writepages operation.  If it fails here we are freeing up the inode
> +	 * anyway and we'd rather not waste our time writing out stuff that is
> +	 * going to be truncated anyway.
>   	 */
> -	spin_lock(&eb->refs_lock);
> -	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> -		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> -		spin_unlock(&eb->refs_lock);
> -		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
> -		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> -					 -eb->len,
> -					 fs_info->dirty_metadata_batch);
> -		ret = 1;
> +	if (!igrab(inode))
> +		return 0;
> +
> +	pagevec_init(&pvec);
> +	if (wbc->range_cyclic) {
> +		index = mapping->writeback_index; /* Start from prev offset */
> +		end = -1;
> +		/*
> +		 * Start from the beginning does not need to cycle over the
> +		 * range, mark it as scanned.
> +		 */
> +		scanned = (index == 0);
>   	} else {
> -		spin_unlock(&eb->refs_lock);
> +		index = wbc->range_start >> PAGE_SHIFT;
> +		end = wbc->range_end >> PAGE_SHIFT;
> +		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
> +			range_whole = 1;
> +		scanned = 1;
>   	}
>   
> -	btrfs_tree_unlock(eb);
> -
>   	/*
> -	 * Either we don't need to submit any tree block, or we're submitting
> -	 * subpage eb.
> -	 * Subpage metadata doesn't use page locking at all, so we can skip
> -	 * the page locking.
> +	 * We do the tagged writepage as long as the snapshot flush bit is set
> +	 * and we are the first one who do the filemap_flush() on this inode.
> +	 *
> +	 * The nr_to_write == LONG_MAX is needed to make sure other flushers do
> +	 * not race in and drop the bit.
>   	 */
> -	if (!ret || fs_info->nodesize < PAGE_SIZE)
> -		return ret;
> +	if (range_whole && wbc->nr_to_write == LONG_MAX &&
> +	    test_and_clear_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
> +			       &BTRFS_I(inode)->runtime_flags))
> +		wbc->tagged_writepages = 1;
> +
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +		tag = PAGECACHE_TAG_TOWRITE;
> +	else
> +		tag = PAGECACHE_TAG_DIRTY;
> +retry:
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +		tag_pages_for_writeback(mapping, index, end);
> +	done_index = index;
> +	while (!done && !nr_to_write_done && (index <= end) &&
> +			(nr_pages = pagevec_lookup_range_tag(&pvec, mapping,
> +						&index, end, tag))) {
> +		unsigned i;
>   
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *p = eb->pages[i];
> +		for (i = 0; i < nr_pages; i++) {
> +			struct page *page = pvec.pages[i];
>   
> -		if (!trylock_page(p)) {
> -			if (!flush) {
> +			done_index = page->index + 1;
> +			/*
> +			 * At this point we hold neither the i_pages lock nor
> +			 * the page lock: the page may be truncated or
> +			 * invalidated (changing page->mapping to NULL),
> +			 * or even swizzled back from swapper_space to
> +			 * tmpfs file mapping
> +			 */
> +			if (!trylock_page(page)) {
>   				submit_write_bio(bio_ctrl, 0);
> -				flush = 1;
> +				lock_page(page);
>   			}
> -			lock_page(p);
> -		}
> -	}
> -
> -	return ret;
> -}
>   
> -static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> +			if (unlikely(page->mapping != mapping)) {
> +				unlock_page(page);
> +				continue;
> +			}
>   
> -	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
> -	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
> -		return;
> +			if (wbc->sync_mode != WB_SYNC_NONE) {
> +				if (PageWriteback(page))
> +					submit_write_bio(bio_ctrl, 0);
> +				wait_on_page_writeback(page);
> +			}
>   
> -	/*
> -	 * A read may stumble upon this buffer later, make sure that it gets an
> -	 * error and knows there was an error.
> -	 */
> -	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +			if (PageWriteback(page) ||
> +			    !clear_page_dirty_for_io(page)) {
> +				unlock_page(page);
> +				continue;
> +			}
>   
> -	/*
> -	 * We need to set the mapping with the io error as well because a write
> -	 * error will flip the file system readonly, and then syncfs() will
> -	 * return a 0 because we are readonly if we don't modify the err seq for
> -	 * the superblock.
> -	 */
> -	mapping_set_error(page->mapping, -EIO);
> +			ret = __extent_writepage(page, wbc, bio_ctrl);
> +			if (ret < 0) {
> +				done = 1;
> +				break;
> +			}
>   
> -	/*
> -	 * If we error out, we should add back the dirty_metadata_bytes
> -	 * to make it consistent.
> -	 */
> -	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> -				 eb->len, fs_info->dirty_metadata_batch);
> +			/*
> +			 * the filesystem may choose to bump up nr_to_write.
> +			 * We have to make sure to honor the new nr_to_write
> +			 * at any time
> +			 */
> +			nr_to_write_done = wbc->nr_to_write <= 0;
> +		}
> +		pagevec_release(&pvec);
> +		cond_resched();
> +	}
> +	if (!scanned && !done) {
> +		/*
> +		 * We hit the last page and there is more work to be done: wrap
> +		 * back to the start of the file
> +		 */
> +		scanned = 1;
> +		index = 0;
>   
> -	/*
> -	 * If writeback for a btree extent that doesn't belong to a log tree
> -	 * failed, increment the counter transaction->eb_write_errors.
> -	 * We do this because while the transaction is running and before it's
> -	 * committing (when we call filemap_fdata[write|wait]_range against
> -	 * the btree inode), we might have
> -	 * btree_inode->i_mapping->a_ops->writepages() called by the VM - if it
> -	 * returns an error or an error happens during writeback, when we're
> -	 * committing the transaction we wouldn't know about it, since the pages
> -	 * can be no longer dirty nor marked anymore for writeback (if a
> -	 * subsequent modification to the extent buffer didn't happen before the
> -	 * transaction commit), which makes filemap_fdata[write|wait]_range not
> -	 * able to find the pages tagged with SetPageError at transaction
> -	 * commit time. So if this happens we must abort the transaction,
> -	 * otherwise we commit a super block with btree roots that point to
> -	 * btree nodes/leafs whose content on disk is invalid - either garbage
> -	 * or the content of some node/leaf from a past generation that got
> -	 * cowed or deleted and is no longer valid.
> -	 *
> -	 * Note: setting AS_EIO/AS_ENOSPC in the btree inode's i_mapping would
> -	 * not be enough - we need to distinguish between log tree extents vs
> -	 * non-log tree extents, and the next filemap_fdatawait_range() call
> -	 * will catch and clear such errors in the mapping - and that call might
> -	 * be from a log sync and not from a transaction commit. Also, checking
> -	 * for the eb flag EXTENT_BUFFER_WRITE_ERR at transaction commit time is
> -	 * not done and would not be reliable - the eb might have been released
> -	 * from memory and reading it back again means that flag would not be
> -	 * set (since it's a runtime flag, not persisted on disk).
> -	 *
> -	 * Using the flags below in the btree inode also makes us achieve the
> -	 * goal of AS_EIO/AS_ENOSPC when writepages() returns success, started
> -	 * writeback for all dirty pages and before filemap_fdatawait_range()
> -	 * is called, the writeback for all dirty pages had already finished
> -	 * with errors - because we were not using AS_EIO/AS_ENOSPC,
> -	 * filemap_fdatawait_range() would return success, as it could not know
> -	 * that writeback errors happened (the pages were no longer tagged for
> -	 * writeback).
> -	 */
> -	switch (eb->log_index) {
> -	case -1:
> -		set_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags);
> -		break;
> -	case 0:
> -		set_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags);
> -		break;
> -	case 1:
> -		set_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags);
> -		break;
> -	default:
> -		BUG(); /* unexpected, logic error */
> +		/*
> +		 * If we're looping we could run into a page that is locked by a
> +		 * writer and that writer could be waiting on writeback for a
> +		 * page in our current bio, and thus deadlock, so flush the
> +		 * write bio here.
> +		 */
> +		submit_write_bio(bio_ctrl, 0);
> +		goto retry;
>   	}
> -}
>   
> -/*
> - * The endio specific version which won't touch any unsafe spinlock in endio
> - * context.
> - */
> -static struct extent_buffer *find_extent_buffer_nolock(
> -		struct btrfs_fs_info *fs_info, u64 start)
> -{
> -	struct extent_buffer *eb;
> +	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
> +		mapping->writeback_index = done_index;
>   
> -	rcu_read_lock();
> -	eb = radix_tree_lookup(&fs_info->buffer_radix,
> -			       start >> fs_info->sectorsize_bits);
> -	if (eb && atomic_inc_not_zero(&eb->refs)) {
> -		rcu_read_unlock();
> -		return eb;
> -	}
> -	rcu_read_unlock();
> -	return NULL;
> +	btrfs_add_delayed_iput(BTRFS_I(inode));
> +	return ret;
>   }
>   
>   /*
> - * The endio function for subpage extent buffer write.
> - *
> - * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
> - * after all extent buffers in the page has finished their writeback.
> + * Submit the pages in the range to bio for call sites which delalloc range has
> + * already been ran (aka, ordered extent inserted) and all pages are still
> + * locked.
>    */
> -static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
> +int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>   {
> -	struct bio *bio = &bbio->bio;
> -	struct btrfs_fs_info *fs_info;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> -
> -	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> -	ASSERT(fs_info->nodesize < PAGE_SIZE);
> -
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -		u64 bvec_start = page_offset(page) + bvec->bv_offset;
> -		u64 bvec_end = bvec_start + bvec->bv_len - 1;
> -		u64 cur_bytenr = bvec_start;
> -
> -		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
> -
> -		/* Iterate through all extent buffers in the range */
> -		while (cur_bytenr <= bvec_end) {
> -			struct extent_buffer *eb;
> -			int done;
> -
> -			/*
> -			 * Here we can't use find_extent_buffer(), as it may
> -			 * try to lock eb->refs_lock, which is not safe in endio
> -			 * context.
> -			 */
> -			eb = find_extent_buffer_nolock(fs_info, cur_bytenr);
> -			ASSERT(eb);
> -
> -			cur_bytenr = eb->start + eb->len;
> +	bool found_error = false;
> +	int first_error = 0;
> +	int ret = 0;
> +	struct address_space *mapping = inode->i_mapping;
> +	struct page *page;
> +	u64 cur = start;
> +	unsigned long nr_pages;
> +	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.extent_locked = 1,
> +		.sync_io = 1,
> +	};
> +	struct writeback_control wbc_writepages = {
> +		.sync_mode	= WB_SYNC_ALL,
> +		.range_start	= start,
> +		.range_end	= end + 1,
> +		/* We're called from an async helper function */
> +		.punt_to_cgroup	= 1,
> +		.no_cgroup_owner = 1,
> +	};
>   
> -			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
> -			done = atomic_dec_and_test(&eb->io_pages);
> -			ASSERT(done);
> +	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
> +	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
> +		   PAGE_SHIFT;
> +	wbc_writepages.nr_to_write = nr_pages * 2;
>   
> -			if (bio->bi_status ||
> -			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> -				ClearPageUptodate(page);
> -				set_btree_ioerr(page, eb);
> -			}
> +	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
> +	while (cur <= end) {
> +		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>   
> -			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> -						      eb->len);
> -			end_extent_buffer_writeback(eb);
> -			/*
> -			 * free_extent_buffer() will grab spinlock which is not
> -			 * safe in endio context. Thus here we manually dec
> -			 * the ref.
> -			 */
> -			atomic_dec(&eb->refs);
> +		page = find_get_page(mapping, cur >> PAGE_SHIFT);
> +		/*
> +		 * All pages in the range are locked since
> +		 * btrfs_run_delalloc_range(), thus there is no way to clear
> +		 * the page dirty flag.
> +		 */
> +		ASSERT(PageLocked(page));
> +		ASSERT(PageDirty(page));
> +		clear_page_dirty_for_io(page);
> +		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
> +		ASSERT(ret <= 0);
> +		if (ret < 0) {
> +			found_error = true;
> +			first_error = ret;
>   		}
> +		put_page(page);
> +		cur = cur_end + 1;
>   	}
> -	bio_put(bio);
> -}
>   
> -static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
> -{
> -	struct bio *bio = &bbio->bio;
> -	struct bio_vec *bvec;
> -	struct extent_buffer *eb;
> -	int done;
> -	struct bvec_iter_all iter_all;
> +	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
>   
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> +	wbc_detach_inode(&wbc_writepages);
> +	if (found_error)
> +		return first_error;
> +	return ret;
> +}
>   
> -		eb = (struct extent_buffer *)page->private;
> -		BUG_ON(!eb);
> -		done = atomic_dec_and_test(&eb->io_pages);
> +int extent_writepages(struct address_space *mapping,
> +		      struct writeback_control *wbc)
> +{
> +	struct inode *inode = mapping->host;
> +	int ret = 0;
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.extent_locked = 0,
> +		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
> +	};
>   
> -		if (bio->bi_status ||
> -		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> -			ClearPageUptodate(page);
> -			set_btree_ioerr(page, eb);
> -		}
> +	/*
> +	 * Allow only a single thread to do the reloc work in zoned mode to
> +	 * protect the write pointer updates.
> +	 */
> +	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
> +	ret = extent_write_cache_pages(mapping, wbc, &bio_ctrl);
> +	submit_write_bio(&bio_ctrl, ret);
> +	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
> +	return ret;
> +}
>   
> -		end_page_writeback(page);
> +void extent_readahead(struct readahead_control *rac)
> +{
> +	struct btrfs_bio_ctrl bio_ctrl = { 0 };
> +	struct page *pagepool[16];
> +	struct extent_map *em_cached = NULL;
> +	u64 prev_em_start = (u64)-1;
> +	int nr;
>   
> -		if (!done)
> -			continue;
> +	while ((nr = readahead_page_batch(rac, pagepool))) {
> +		u64 contig_start = readahead_pos(rac);
> +		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
>   
> -		end_extent_buffer_writeback(eb);
> +		contiguous_readpages(pagepool, nr, contig_start, contig_end,
> +				&em_cached, &bio_ctrl, &prev_em_start);
>   	}
>   
> -	bio_put(bio);
> -}
> -
> -static void prepare_eb_write(struct extent_buffer *eb)
> -{
> -	u32 nritems;
> -	unsigned long start;
> -	unsigned long end;
> -
> -	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> -	atomic_set(&eb->io_pages, num_extent_pages(eb));
> -
> -	/* Set btree blocks beyond nritems with 0 to avoid stale content */
> -	nritems = btrfs_header_nritems(eb);
> -	if (btrfs_header_level(eb) > 0) {
> -		end = btrfs_node_key_ptr_offset(eb, nritems);
> -		memzero_extent_buffer(eb, end, eb->len - end);
> -	} else {
> -		/*
> -		 * Leaf:
> -		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
> -		 */
> -		start = btrfs_item_nr_offset(eb, nritems);
> -		end = btrfs_item_nr_offset(eb, 0);
> -		if (nritems == 0)
> -			end += BTRFS_LEAF_DATA_SIZE(eb->fs_info);
> -		else
> -			end += btrfs_item_offset(eb, nritems - 1);
> -		memzero_extent_buffer(eb, start, end - start);
> -	}
> +	if (em_cached)
> +		free_extent_map(em_cached);
> +	submit_one_bio(&bio_ctrl);
>   }
>   
>   /*
> - * Unlike the work in write_one_eb(), we rely completely on extent locking.
> - * Page locking is only utilized at minimum to keep the VMM code happy.
> + * basic invalidate_folio code, this waits on any locked or writeback
> + * ranges corresponding to the folio, and then deletes any extent state
> + * records from the tree
>    */
> -static int write_one_subpage_eb(struct extent_buffer *eb,
> -				struct writeback_control *wbc,
> -				struct btrfs_bio_ctrl *bio_ctrl)
> +int extent_invalidate_folio(struct extent_io_tree *tree,
> +			  struct folio *folio, size_t offset)
>   {
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct page *page = eb->pages[0];
> -	blk_opf_t write_flags = wbc_to_write_flags(wbc);
> -	bool no_dirty_ebs = false;
> -	int ret;
> -
> -	prepare_eb_write(eb);
> -
> -	/* clear_page_dirty_for_io() in subpage helper needs page locked */
> -	lock_page(page);
> -	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
> +	struct extent_state *cached_state = NULL;
> +	u64 start = folio_pos(folio);
> +	u64 end = start + folio_size(folio) - 1;
> +	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
>   
> -	/* Check if this is the last dirty bit to update nr_written */
> -	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
> -							  eb->start, eb->len);
> -	if (no_dirty_ebs)
> -		clear_page_dirty_for_io(page);
> +	/* This function is only called for the btree inode */
> +	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
>   
> -	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
> +	start += ALIGN(offset, blocksize);
> +	if (start > end)
> +		return 0;
>   
> -	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> -			bio_ctrl, eb->start, page, eb->len,
> -			eb->start - page_offset(page), 0, false);
> -	if (ret) {
> -		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
> -		set_btree_ioerr(page, eb);
> -		unlock_page(page);
> +	lock_extent(tree, start, end, &cached_state);
> +	folio_wait_writeback(folio);
>   
> -		if (atomic_dec_and_test(&eb->io_pages))
> -			end_extent_buffer_writeback(eb);
> -		return -EIO;
> -	}
> -	unlock_page(page);
>   	/*
> -	 * Submission finished without problem, if no range of the page is
> -	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
> +	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
> +	 * so here we only need to unlock the extent range to free any
> +	 * existing extent state.
>   	 */
> -	if (no_dirty_ebs)
> -		wbc->nr_to_write--;
> -	return ret;
> -}
> -
> -static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
> -			struct writeback_control *wbc,
> -			struct btrfs_bio_ctrl *bio_ctrl)
> -{
> -	u64 disk_bytenr = eb->start;
> -	int i, num_pages;
> -	blk_opf_t write_flags = wbc_to_write_flags(wbc);
> -	int ret = 0;
> -
> -	prepare_eb_write(eb);
> -
> -	bio_ctrl->end_io_func = end_bio_extent_buffer_writepage;
> -
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *p = eb->pages[i];
> -
> -		clear_page_dirty_for_io(p);
> -		set_page_writeback(p);
> -		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> -					 bio_ctrl, disk_bytenr, p,
> -					 PAGE_SIZE, 0, 0, false);
> -		if (ret) {
> -			set_btree_ioerr(p, eb);
> -			if (PageWriteback(p))
> -				end_page_writeback(p);
> -			if (atomic_sub_and_test(num_pages - i, &eb->io_pages))
> -				end_extent_buffer_writeback(eb);
> -			ret = -EIO;
> -			break;
> -		}
> -		disk_bytenr += PAGE_SIZE;
> -		wbc->nr_to_write--;
> -		unlock_page(p);
> -	}
> -
> -	if (unlikely(ret)) {
> -		for (; i < num_pages; i++) {
> -			struct page *p = eb->pages[i];
> -			clear_page_dirty_for_io(p);
> -			unlock_page(p);
> -		}
> -	}
> -
> -	return ret;
> +	unlock_extent(tree, start, end, &cached_state);
> +	return 0;
>   }
>   
>   /*
> - * Submit one subpage btree page.
> - *
> - * The main difference to submit_eb_page() is:
> - * - Page locking
> - *   For subpage, we don't rely on page locking at all.
> - *
> - * - Flush write bio
> - *   We only flush bio if we may be unable to fit current extent buffers into
> - *   current bio.
> - *
> - * Return >=0 for the number of submitted extent buffers.
> - * Return <0 for fatal error.
> + * a helper for release_folio, this tests for areas of the page that
> + * are locked or under IO and drops the related state bits if it is safe
> + * to drop the page.
>    */
> -static int submit_eb_subpage(struct page *page,
> -			     struct writeback_control *wbc,
> -			     struct btrfs_bio_ctrl *bio_ctrl)
> +static int try_release_extent_state(struct extent_io_tree *tree,
> +				    struct page *page, gfp_t mask)
>   {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> -	int submitted = 0;
> -	u64 page_start = page_offset(page);
> -	int bit_start = 0;
> -	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
> -	int ret;
> -
> -	/* Lock and write each dirty extent buffers in the range */
> -	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
> -		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> -		struct extent_buffer *eb;
> -		unsigned long flags;
> -		u64 start;
> -
> -		/*
> -		 * Take private lock to ensure the subpage won't be detached
> -		 * in the meantime.
> -		 */
> -		spin_lock(&page->mapping->private_lock);
> -		if (!PagePrivate(page)) {
> -			spin_unlock(&page->mapping->private_lock);
> -			break;
> -		}
> -		spin_lock_irqsave(&subpage->lock, flags);
> -		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
> -			      subpage->bitmaps)) {
> -			spin_unlock_irqrestore(&subpage->lock, flags);
> -			spin_unlock(&page->mapping->private_lock);
> -			bit_start++;
> -			continue;
> -		}
> +	u64 start = page_offset(page);
> +	u64 end = start + PAGE_SIZE - 1;
> +	int ret = 1;
>   
> -		start = page_start + bit_start * fs_info->sectorsize;
> -		bit_start += sectors_per_node;
> +	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> +		ret = 0;
> +	} else {
> +		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> +				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
>   
>   		/*
> -		 * Here we just want to grab the eb without touching extra
> -		 * spin locks, so call find_extent_buffer_nolock().
> +		 * At this point we can safely clear everything except the
> +		 * locked bit, the nodatasum bit and the delalloc new bit.
> +		 * The delalloc new bit will be cleared by ordered extent
> +		 * completion.
>   		 */
> -		eb = find_extent_buffer_nolock(fs_info, start);
> -		spin_unlock_irqrestore(&subpage->lock, flags);
> -		spin_unlock(&page->mapping->private_lock);
> +		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL,
> +					 mask, NULL);
>   
> -		/*
> -		 * The eb has already reached 0 refs thus find_extent_buffer()
> -		 * doesn't return it. We don't need to write back such eb
> -		 * anyway.
> +		/* if clear_extent_bit failed for enomem reasons,
> +		 * we can't allow the release to continue.
>   		 */
> -		if (!eb)
> -			continue;
> -
> -		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
> -		if (ret == 0) {
> -			free_extent_buffer(eb);
> -			continue;
> -		}
> -		if (ret < 0) {
> -			free_extent_buffer(eb);
> -			goto cleanup;
> -		}
> -		ret = write_one_subpage_eb(eb, wbc, bio_ctrl);
> -		free_extent_buffer(eb);
>   		if (ret < 0)
> -			goto cleanup;
> -		submitted++;
> +			ret = 0;
> +		else
> +			ret = 1;
>   	}
> -	return submitted;
> -
> -cleanup:
> -	/* We hit error, end bio for the submitted extent buffers */
> -	submit_write_bio(bio_ctrl, ret);
>   	return ret;
>   }
>   
>   /*
> - * Submit all page(s) of one extent buffer.
> - *
> - * @page:	the page of one extent buffer
> - * @eb_context:	to determine if we need to submit this page, if current page
> - *		belongs to this eb, we don't need to submit
> - *
> - * The caller should pass each page in their bytenr order, and here we use
> - * @eb_context to determine if we have submitted pages of one extent buffer.
> - *
> - * If we have, we just skip until we hit a new page that doesn't belong to
> - * current @eb_context.
> - *
> - * If not, we submit all the page(s) of the extent buffer.
> - *
> - * Return >0 if we have submitted the extent buffer successfully.
> - * Return 0 if we don't need to submit the page, as it's already submitted by
> - * previous call.
> - * Return <0 for fatal error.
> + * a helper for release_folio.  As long as there are no locked extents
> + * in the range corresponding to the page, both state records and extent
> + * map records are removed
>    */
> -static int submit_eb_page(struct page *page, struct writeback_control *wbc,
> -			  struct btrfs_bio_ctrl *bio_ctrl,
> -			  struct extent_buffer **eb_context)
> +int try_release_extent_mapping(struct page *page, gfp_t mask)
>   {
> -	struct address_space *mapping = page->mapping;
> -	struct btrfs_block_group *cache = NULL;
> -	struct extent_buffer *eb;
> -	int ret;
> -
> -	if (!PagePrivate(page))
> -		return 0;
> -
> -	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
> -		return submit_eb_subpage(page, wbc, bio_ctrl);
> -
> -	spin_lock(&mapping->private_lock);
> -	if (!PagePrivate(page)) {
> -		spin_unlock(&mapping->private_lock);
> -		return 0;
> -	}
> -
> -	eb = (struct extent_buffer *)page->private;
> -
> -	/*
> -	 * Shouldn't happen and normally this would be a BUG_ON but no point
> -	 * crashing the machine for something we can survive anyway.
> -	 */
> -	if (WARN_ON(!eb)) {
> -		spin_unlock(&mapping->private_lock);
> -		return 0;
> -	}
> -
> -	if (eb == *eb_context) {
> -		spin_unlock(&mapping->private_lock);
> -		return 0;
> -	}
> -	ret = atomic_inc_not_zero(&eb->refs);
> -	spin_unlock(&mapping->private_lock);
> -	if (!ret)
> -		return 0;
> -
> -	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
> -		/*
> -		 * If for_sync, this hole will be filled with
> -		 * trasnsaction commit.
> -		 */
> -		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
> -			ret = -EAGAIN;
> -		else
> -			ret = 0;
> -		free_extent_buffer(eb);
> -		return ret;
> -	}
> +	struct extent_map *em;
> +	u64 start = page_offset(page);
> +	u64 end = start + PAGE_SIZE - 1;
> +	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
> +	struct extent_io_tree *tree = &btrfs_inode->io_tree;
> +	struct extent_map_tree *map = &btrfs_inode->extent_tree;
>   
> -	*eb_context = eb;
> +	if (gfpflags_allow_blocking(mask) &&
> +	    page->mapping->host->i_size > SZ_16M) {
> +		u64 len;
> +		while (start <= end) {
> +			struct btrfs_fs_info *fs_info;
> +			u64 cur_gen;
>   
> -	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
> -	if (ret <= 0) {
> -		btrfs_revert_meta_write_pointer(cache, eb);
> -		if (cache)
> -			btrfs_put_block_group(cache);
> -		free_extent_buffer(eb);
> -		return ret;
> -	}
> -	if (cache) {
> -		/*
> -		 * Implies write in zoned mode. Mark the last eb in a block group.
> -		 */
> -		btrfs_schedule_zone_finish_bg(cache, eb);
> -		btrfs_put_block_group(cache);
> -	}
> -	ret = write_one_eb(eb, wbc, bio_ctrl);
> -	free_extent_buffer(eb);
> -	if (ret < 0)
> -		return ret;
> -	return 1;
> -}
> -
> -int btree_write_cache_pages(struct address_space *mapping,
> -				   struct writeback_control *wbc)
> -{
> -	struct extent_buffer *eb_context = NULL;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.extent_locked = 0,
> -		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
> -	};
> -	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
> -	int ret = 0;
> -	int done = 0;
> -	int nr_to_write_done = 0;
> -	struct pagevec pvec;
> -	int nr_pages;
> -	pgoff_t index;
> -	pgoff_t end;		/* Inclusive */
> -	int scanned = 0;
> -	xa_mark_t tag;
> -
> -	pagevec_init(&pvec);
> -	if (wbc->range_cyclic) {
> -		index = mapping->writeback_index; /* Start from prev offset */
> -		end = -1;
> -		/*
> -		 * Start from the beginning does not need to cycle over the
> -		 * range, mark it as scanned.
> -		 */
> -		scanned = (index == 0);
> -	} else {
> -		index = wbc->range_start >> PAGE_SHIFT;
> -		end = wbc->range_end >> PAGE_SHIFT;
> -		scanned = 1;
> -	}
> -	if (wbc->sync_mode == WB_SYNC_ALL)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> -	btrfs_zoned_meta_io_lock(fs_info);
> -retry:
> -	if (wbc->sync_mode == WB_SYNC_ALL)
> -		tag_pages_for_writeback(mapping, index, end);
> -	while (!done && !nr_to_write_done && (index <= end) &&
> -	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> -			tag))) {
> -		unsigned i;
> -
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> -
> -			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
> -			if (ret == 0)
> -				continue;
> -			if (ret < 0) {
> -				done = 1;
> +			len = end - start + 1;
> +			write_lock(&map->lock);
> +			em = lookup_extent_mapping(map, start, len);
> +			if (!em) {
> +				write_unlock(&map->lock);
>   				break;
>   			}
> -
> -			/*
> -			 * the filesystem may choose to bump up nr_to_write.
> -			 * We have to make sure to honor the new nr_to_write
> -			 * at any time
> -			 */
> -			nr_to_write_done = wbc->nr_to_write <= 0;
> -		}
> -		pagevec_release(&pvec);
> -		cond_resched();
> -	}
> -	if (!scanned && !done) {
> -		/*
> -		 * We hit the last page and there is more work to be done: wrap
> -		 * back to the start of the file
> -		 */
> -		scanned = 1;
> -		index = 0;
> -		goto retry;
> -	}
> -	/*
> -	 * If something went wrong, don't allow any metadata write bio to be
> -	 * submitted.
> -	 *
> -	 * This would prevent use-after-free if we had dirty pages not
> -	 * cleaned up, which can still happen by fuzzed images.
> -	 *
> -	 * - Bad extent tree
> -	 *   Allowing existing tree block to be allocated for other trees.
> -	 *
> -	 * - Log tree operations
> -	 *   Exiting tree blocks get allocated to log tree, bumps its
> -	 *   generation, then get cleaned in tree re-balance.
> -	 *   Such tree block will not be written back, since it's clean,
> -	 *   thus no WRITTEN flag set.
> -	 *   And after log writes back, this tree block is not traced by
> -	 *   any dirty extent_io_tree.
> -	 *
> -	 * - Offending tree block gets re-dirtied from its original owner
> -	 *   Since it has bumped generation, no WRITTEN flag, it can be
> -	 *   reused without COWing. This tree block will not be traced
> -	 *   by btrfs_transaction::dirty_pages.
> -	 *
> -	 *   Now such dirty tree block will not be cleaned by any dirty
> -	 *   extent io tree. Thus we don't want to submit such wild eb
> -	 *   if the fs already has error.
> -	 *
> -	 * We can get ret > 0 from submit_extent_page() indicating how many ebs
> -	 * were submitted. Reset it to 0 to avoid false alerts for the caller.
> -	 */
> -	if (ret > 0)
> -		ret = 0;
> -	if (!ret && BTRFS_FS_ERROR(fs_info))
> -		ret = -EROFS;
> -	submit_write_bio(&bio_ctrl, ret);
> -
> -	btrfs_zoned_meta_io_unlock(fs_info);
> -	return ret;
> -}
> -
> -/*
> - * Walk the list of dirty pages of the given address space and write all of them.
> - *
> - * @mapping:   address space structure to write
> - * @wbc:       subtract the number of written pages from *@wbc->nr_to_write
> - * @bio_ctrl:  holds context for the write, namely the bio
> - *
> - * If a page is already under I/O, write_cache_pages() skips it, even
> - * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
> - * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
> - * and msync() need to guarantee that all the data which was dirty at the time
> - * the call was made get new I/O started against them.  If wbc->sync_mode is
> - * WB_SYNC_ALL then we were called for data integrity and we must wait for
> - * existing IO to complete.
> - */
> -static int extent_write_cache_pages(struct address_space *mapping,
> -			     struct writeback_control *wbc,
> -			     struct btrfs_bio_ctrl *bio_ctrl)
> -{
> -	struct inode *inode = mapping->host;
> -	int ret = 0;
> -	int done = 0;
> -	int nr_to_write_done = 0;
> -	struct pagevec pvec;
> -	int nr_pages;
> -	pgoff_t index;
> -	pgoff_t end;		/* Inclusive */
> -	pgoff_t done_index;
> -	int range_whole = 0;
> -	int scanned = 0;
> -	xa_mark_t tag;
> -
> -	/*
> -	 * We have to hold onto the inode so that ordered extents can do their
> -	 * work when the IO finishes.  The alternative to this is failing to add
> -	 * an ordered extent if the igrab() fails there and that is a huge pain
> -	 * to deal with, so instead just hold onto the inode throughout the
> -	 * writepages operation.  If it fails here we are freeing up the inode
> -	 * anyway and we'd rather not waste our time writing out stuff that is
> -	 * going to be truncated anyway.
> -	 */
> -	if (!igrab(inode))
> -		return 0;
> -
> -	pagevec_init(&pvec);
> -	if (wbc->range_cyclic) {
> -		index = mapping->writeback_index; /* Start from prev offset */
> -		end = -1;
> -		/*
> -		 * Start from the beginning does not need to cycle over the
> -		 * range, mark it as scanned.
> -		 */
> -		scanned = (index == 0);
> -	} else {
> -		index = wbc->range_start >> PAGE_SHIFT;
> -		end = wbc->range_end >> PAGE_SHIFT;
> -		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
> -			range_whole = 1;
> -		scanned = 1;
> -	}
> -
> -	/*
> -	 * We do the tagged writepage as long as the snapshot flush bit is set
> -	 * and we are the first one who do the filemap_flush() on this inode.
> -	 *
> -	 * The nr_to_write == LONG_MAX is needed to make sure other flushers do
> -	 * not race in and drop the bit.
> -	 */
> -	if (range_whole && wbc->nr_to_write == LONG_MAX &&
> -	    test_and_clear_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
> -			       &BTRFS_I(inode)->runtime_flags))
> -		wbc->tagged_writepages = 1;
> -
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> -retry:
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, index, end);
> -	done_index = index;
> -	while (!done && !nr_to_write_done && (index <= end) &&
> -			(nr_pages = pagevec_lookup_range_tag(&pvec, mapping,
> -						&index, end, tag))) {
> -		unsigned i;
> -
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> -
> -			done_index = page->index + 1;
> -			/*
> -			 * At this point we hold neither the i_pages lock nor
> -			 * the page lock: the page may be truncated or
> -			 * invalidated (changing page->mapping to NULL),
> -			 * or even swizzled back from swapper_space to
> -			 * tmpfs file mapping
> -			 */
> -			if (!trylock_page(page)) {
> -				submit_write_bio(bio_ctrl, 0);
> -				lock_page(page);
> -			}
> -
> -			if (unlikely(page->mapping != mapping)) {
> -				unlock_page(page);
> -				continue;
> -			}
> -
> -			if (wbc->sync_mode != WB_SYNC_NONE) {
> -				if (PageWriteback(page))
> -					submit_write_bio(bio_ctrl, 0);
> -				wait_on_page_writeback(page);
> -			}
> -
> -			if (PageWriteback(page) ||
> -			    !clear_page_dirty_for_io(page)) {
> -				unlock_page(page);
> -				continue;
> -			}
> -
> -			ret = __extent_writepage(page, wbc, bio_ctrl);
> -			if (ret < 0) {
> -				done = 1;
> +			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
> +			    em->start != start) {
> +				write_unlock(&map->lock);
> +				free_extent_map(em);
>   				break;
>   			}
> -
> +			if (test_range_bit(tree, em->start,
> +					   extent_map_end(em) - 1,
> +					   EXTENT_LOCKED, 0, NULL))
> +				goto next;
>   			/*
> -			 * the filesystem may choose to bump up nr_to_write.
> -			 * We have to make sure to honor the new nr_to_write
> -			 * at any time
> -			 */
> -			nr_to_write_done = wbc->nr_to_write <= 0;
> -		}
> -		pagevec_release(&pvec);
> -		cond_resched();
> -	}
> -	if (!scanned && !done) {
> -		/*
> -		 * We hit the last page and there is more work to be done: wrap
> -		 * back to the start of the file
> -		 */
> -		scanned = 1;
> -		index = 0;
> -
> -		/*
> -		 * If we're looping we could run into a page that is locked by a
> -		 * writer and that writer could be waiting on writeback for a
> -		 * page in our current bio, and thus deadlock, so flush the
> -		 * write bio here.
> -		 */
> -		submit_write_bio(bio_ctrl, 0);
> -		goto retry;
> -	}
> -
> -	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
> -		mapping->writeback_index = done_index;
> -
> -	btrfs_add_delayed_iput(BTRFS_I(inode));
> -	return ret;
> -}
> -
> -/*
> - * Submit the pages in the range to bio for call sites which delalloc range has
> - * already been ran (aka, ordered extent inserted) and all pages are still
> - * locked.
> - */
> -int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
> -{
> -	bool found_error = false;
> -	int first_error = 0;
> -	int ret = 0;
> -	struct address_space *mapping = inode->i_mapping;
> -	struct page *page;
> -	u64 cur = start;
> -	unsigned long nr_pages;
> -	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.extent_locked = 1,
> -		.sync_io = 1,
> -	};
> -	struct writeback_control wbc_writepages = {
> -		.sync_mode	= WB_SYNC_ALL,
> -		.range_start	= start,
> -		.range_end	= end + 1,
> -		/* We're called from an async helper function */
> -		.punt_to_cgroup	= 1,
> -		.no_cgroup_owner = 1,
> -	};
> -
> -	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
> -	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
> -		   PAGE_SHIFT;
> -	wbc_writepages.nr_to_write = nr_pages * 2;
> -
> -	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
> -	while (cur <= end) {
> -		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> -
> -		page = find_get_page(mapping, cur >> PAGE_SHIFT);
> -		/*
> -		 * All pages in the range are locked since
> -		 * btrfs_run_delalloc_range(), thus there is no way to clear
> -		 * the page dirty flag.
> -		 */
> -		ASSERT(PageLocked(page));
> -		ASSERT(PageDirty(page));
> -		clear_page_dirty_for_io(page);
> -		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
> -		ASSERT(ret <= 0);
> -		if (ret < 0) {
> -			found_error = true;
> -			first_error = ret;
> -		}
> -		put_page(page);
> -		cur = cur_end + 1;
> -	}
> -
> -	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
> -
> -	wbc_detach_inode(&wbc_writepages);
> -	if (found_error)
> -		return first_error;
> -	return ret;
> -}
> -
> -int extent_writepages(struct address_space *mapping,
> -		      struct writeback_control *wbc)
> -{
> -	struct inode *inode = mapping->host;
> -	int ret = 0;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.extent_locked = 0,
> -		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
> -	};
> -
> -	/*
> -	 * Allow only a single thread to do the reloc work in zoned mode to
> -	 * protect the write pointer updates.
> -	 */
> -	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
> -	ret = extent_write_cache_pages(mapping, wbc, &bio_ctrl);
> -	submit_write_bio(&bio_ctrl, ret);
> -	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
> -	return ret;
> -}
> -
> -void extent_readahead(struct readahead_control *rac)
> -{
> -	struct btrfs_bio_ctrl bio_ctrl = { 0 };
> -	struct page *pagepool[16];
> -	struct extent_map *em_cached = NULL;
> -	u64 prev_em_start = (u64)-1;
> -	int nr;
> -
> -	while ((nr = readahead_page_batch(rac, pagepool))) {
> -		u64 contig_start = readahead_pos(rac);
> -		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
> -
> -		contiguous_readpages(pagepool, nr, contig_start, contig_end,
> -				&em_cached, &bio_ctrl, &prev_em_start);
> -	}
> -
> -	if (em_cached)
> -		free_extent_map(em_cached);
> -	submit_one_bio(&bio_ctrl);
> -}
> -
> -/*
> - * basic invalidate_folio code, this waits on any locked or writeback
> - * ranges corresponding to the folio, and then deletes any extent state
> - * records from the tree
> - */
> -int extent_invalidate_folio(struct extent_io_tree *tree,
> -			  struct folio *folio, size_t offset)
> -{
> -	struct extent_state *cached_state = NULL;
> -	u64 start = folio_pos(folio);
> -	u64 end = start + folio_size(folio) - 1;
> -	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
> -
> -	/* This function is only called for the btree inode */
> -	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
> -
> -	start += ALIGN(offset, blocksize);
> -	if (start > end)
> -		return 0;
> -
> -	lock_extent(tree, start, end, &cached_state);
> -	folio_wait_writeback(folio);
> -
> -	/*
> -	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
> -	 * so here we only need to unlock the extent range to free any
> -	 * existing extent state.
> -	 */
> -	unlock_extent(tree, start, end, &cached_state);
> -	return 0;
> -}
> -
> -/*
> - * a helper for release_folio, this tests for areas of the page that
> - * are locked or under IO and drops the related state bits if it is safe
> - * to drop the page.
> - */
> -static int try_release_extent_state(struct extent_io_tree *tree,
> -				    struct page *page, gfp_t mask)
> -{
> -	u64 start = page_offset(page);
> -	u64 end = start + PAGE_SIZE - 1;
> -	int ret = 1;
> -
> -	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> -		ret = 0;
> -	} else {
> -		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> -				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
> -
> -		/*
> -		 * At this point we can safely clear everything except the
> -		 * locked bit, the nodatasum bit and the delalloc new bit.
> -		 * The delalloc new bit will be cleared by ordered extent
> -		 * completion.
> -		 */
> -		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL,
> -					 mask, NULL);
> -
> -		/* if clear_extent_bit failed for enomem reasons,
> -		 * we can't allow the release to continue.
> -		 */
> -		if (ret < 0)
> -			ret = 0;
> -		else
> -			ret = 1;
> -	}
> -	return ret;
> -}
> -
> -/*
> - * a helper for release_folio.  As long as there are no locked extents
> - * in the range corresponding to the page, both state records and extent
> - * map records are removed
> - */
> -int try_release_extent_mapping(struct page *page, gfp_t mask)
> -{
> -	struct extent_map *em;
> -	u64 start = page_offset(page);
> -	u64 end = start + PAGE_SIZE - 1;
> -	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
> -	struct extent_io_tree *tree = &btrfs_inode->io_tree;
> -	struct extent_map_tree *map = &btrfs_inode->extent_tree;
> -
> -	if (gfpflags_allow_blocking(mask) &&
> -	    page->mapping->host->i_size > SZ_16M) {
> -		u64 len;
> -		while (start <= end) {
> -			struct btrfs_fs_info *fs_info;
> -			u64 cur_gen;
> -
> -			len = end - start + 1;
> -			write_lock(&map->lock);
> -			em = lookup_extent_mapping(map, start, len);
> -			if (!em) {
> -				write_unlock(&map->lock);
> -				break;
> -			}
> -			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
> -			    em->start != start) {
> -				write_unlock(&map->lock);
> -				free_extent_map(em);
> -				break;
> -			}
> -			if (test_range_bit(tree, em->start,
> -					   extent_map_end(em) - 1,
> -					   EXTENT_LOCKED, 0, NULL))
> -				goto next;
> -			/*
> -			 * If it's not in the list of modified extents, used
> -			 * by a fast fsync, we can remove it. If it's being
> -			 * logged we can safely remove it since fsync took an
> -			 * extra reference on the em.
> +			 * If it's not in the list of modified extents, used
> +			 * by a fast fsync, we can remove it. If it's being
> +			 * logged we can safely remove it since fsync took an
> +			 * extra reference on the em.
>   			 */
>   			if (list_empty(&em->list) ||
>   			    test_bit(EXTENT_FLAG_LOGGING, &em->flags))
> @@ -3357,2438 +2477,671 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
>   			 * only if its generation is older then the current one,
>   			 * in which case we don't need it for a fast fsync.
>   			 * Otherwise don't remove it, we could be racing with an
> -			 * ongoing fast fsync that could miss the new extent.
> -			 */
> -			fs_info = btrfs_inode->root->fs_info;
> -			spin_lock(&fs_info->trans_lock);
> -			cur_gen = fs_info->generation;
> -			spin_unlock(&fs_info->trans_lock);
> -			if (em->generation >= cur_gen)
> -				goto next;
> -remove_em:
> -			/*
> -			 * We only remove extent maps that are not in the list of
> -			 * modified extents or that are in the list but with a
> -			 * generation lower then the current generation, so there
> -			 * is no need to set the full fsync flag on the inode (it
> -			 * hurts the fsync performance for workloads with a data
> -			 * size that exceeds or is close to the system's memory).
> -			 */
> -			remove_extent_mapping(map, em);
> -			/* once for the rb tree */
> -			free_extent_map(em);
> -next:
> -			start = extent_map_end(em);
> -			write_unlock(&map->lock);
> -
> -			/* once for us */
> -			free_extent_map(em);
> -
> -			cond_resched(); /* Allow large-extent preemption. */
> -		}
> -	}
> -	return try_release_extent_state(tree, page, mask);
> -}
> -
> -/*
> - * To cache previous fiemap extent
> - *
> - * Will be used for merging fiemap extent
> - */
> -struct fiemap_cache {
> -	u64 offset;
> -	u64 phys;
> -	u64 len;
> -	u32 flags;
> -	bool cached;
> -};
> -
> -/*
> - * Helper to submit fiemap extent.
> - *
> - * Will try to merge current fiemap extent specified by @offset, @phys,
> - * @len and @flags with cached one.
> - * And only when we fails to merge, cached one will be submitted as
> - * fiemap extent.
> - *
> - * Return value is the same as fiemap_fill_next_extent().
> - */
> -static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
> -				struct fiemap_cache *cache,
> -				u64 offset, u64 phys, u64 len, u32 flags)
> -{
> -	int ret = 0;
> -
> -	/* Set at the end of extent_fiemap(). */
> -	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
> -
> -	if (!cache->cached)
> -		goto assign;
> -
> -	/*
> -	 * Sanity check, extent_fiemap() should have ensured that new
> -	 * fiemap extent won't overlap with cached one.
> -	 * Not recoverable.
> -	 *
> -	 * NOTE: Physical address can overlap, due to compression
> -	 */
> -	if (cache->offset + cache->len > offset) {
> -		WARN_ON(1);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Only merges fiemap extents if
> -	 * 1) Their logical addresses are continuous
> -	 *
> -	 * 2) Their physical addresses are continuous
> -	 *    So truly compressed (physical size smaller than logical size)
> -	 *    extents won't get merged with each other
> -	 *
> -	 * 3) Share same flags
> -	 */
> -	if (cache->offset + cache->len  == offset &&
> -	    cache->phys + cache->len == phys  &&
> -	    cache->flags == flags) {
> -		cache->len += len;
> -		return 0;
> -	}
> -
> -	/* Not mergeable, need to submit cached one */
> -	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
> -				      cache->len, cache->flags);
> -	cache->cached = false;
> -	if (ret)
> -		return ret;
> -assign:
> -	cache->cached = true;
> -	cache->offset = offset;
> -	cache->phys = phys;
> -	cache->len = len;
> -	cache->flags = flags;
> -
> -	return 0;
> -}
> -
> -/*
> - * Emit last fiemap cache
> - *
> - * The last fiemap cache may still be cached in the following case:
> - * 0		      4k		    8k
> - * |<- Fiemap range ->|
> - * |<------------  First extent ----------->|
> - *
> - * In this case, the first extent range will be cached but not emitted.
> - * So we must emit it before ending extent_fiemap().
> - */
> -static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
> -				  struct fiemap_cache *cache)
> -{
> -	int ret;
> -
> -	if (!cache->cached)
> -		return 0;
> -
> -	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
> -				      cache->len, cache->flags);
> -	cache->cached = false;
> -	if (ret > 0)
> -		ret = 0;
> -	return ret;
> -}
> -
> -static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
> -{
> -	struct extent_buffer *clone;
> -	struct btrfs_key key;
> -	int slot;
> -	int ret;
> -
> -	path->slots[0]++;
> -	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
> -		return 0;
> -
> -	ret = btrfs_next_leaf(inode->root, path);
> -	if (ret != 0)
> -		return ret;
> -
> -	/*
> -	 * Don't bother with cloning if there are no more file extent items for
> -	 * our inode.
> -	 */
> -	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> -	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY)
> -		return 1;
> -
> -	/* See the comment at fiemap_search_slot() about why we clone. */
> -	clone = btrfs_clone_extent_buffer(path->nodes[0]);
> -	if (!clone)
> -		return -ENOMEM;
> -
> -	slot = path->slots[0];
> -	btrfs_release_path(path);
> -	path->nodes[0] = clone;
> -	path->slots[0] = slot;
> -
> -	return 0;
> -}
> -
> -/*
> - * Search for the first file extent item that starts at a given file offset or
> - * the one that starts immediately before that offset.
> - * Returns: 0 on success, < 0 on error, 1 if not found.
> - */
> -static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path,
> -			      u64 file_offset)
> -{
> -	const u64 ino = btrfs_ino(inode);
> -	struct btrfs_root *root = inode->root;
> -	struct extent_buffer *clone;
> -	struct btrfs_key key;
> -	int slot;
> -	int ret;
> -
> -	key.objectid = ino;
> -	key.type = BTRFS_EXTENT_DATA_KEY;
> -	key.offset = file_offset;
> -
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret > 0 && path->slots[0] > 0) {
> -		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
> -		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
> -			path->slots[0]--;
> -	}
> -
> -	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
> -		ret = btrfs_next_leaf(root, path);
> -		if (ret != 0)
> -			return ret;
> -
> -		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> -		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> -			return 1;
> -	}
> -
> -	/*
> -	 * We clone the leaf and use it during fiemap. This is because while
> -	 * using the leaf we do expensive things like checking if an extent is
> -	 * shared, which can take a long time. In order to prevent blocking
> -	 * other tasks for too long, we use a clone of the leaf. We have locked
> -	 * the file range in the inode's io tree, so we know none of our file
> -	 * extent items can change. This way we avoid blocking other tasks that
> -	 * want to insert items for other inodes in the same leaf or b+tree
> -	 * rebalance operations (triggered for example when someone is trying
> -	 * to push items into this leaf when trying to insert an item in a
> -	 * neighbour leaf).
> -	 * We also need the private clone because holding a read lock on an
> -	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
> -	 * when we call fiemap_fill_next_extent(), because that may cause a page
> -	 * fault when filling the user space buffer with fiemap data.
> -	 */
> -	clone = btrfs_clone_extent_buffer(path->nodes[0]);
> -	if (!clone)
> -		return -ENOMEM;
> -
> -	slot = path->slots[0];
> -	btrfs_release_path(path);
> -	path->nodes[0] = clone;
> -	path->slots[0] = slot;
> -
> -	return 0;
> -}
> -
> -/*
> - * Process a range which is a hole or a prealloc extent in the inode's subvolume
> - * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
> - * extent. The end offset (@end) is inclusive.
> - */
> -static int fiemap_process_hole(struct btrfs_inode *inode,
> -			       struct fiemap_extent_info *fieinfo,
> -			       struct fiemap_cache *cache,
> -			       struct extent_state **delalloc_cached_state,
> -			       struct btrfs_backref_share_check_ctx *backref_ctx,
> -			       u64 disk_bytenr, u64 extent_offset,
> -			       u64 extent_gen,
> -			       u64 start, u64 end)
> -{
> -	const u64 i_size = i_size_read(&inode->vfs_inode);
> -	u64 cur_offset = start;
> -	u64 last_delalloc_end = 0;
> -	u32 prealloc_flags = FIEMAP_EXTENT_UNWRITTEN;
> -	bool checked_extent_shared = false;
> -	int ret;
> -
> -	/*
> -	 * There can be no delalloc past i_size, so don't waste time looking for
> -	 * it beyond i_size.
> -	 */
> -	while (cur_offset < end && cur_offset < i_size) {
> -		u64 delalloc_start;
> -		u64 delalloc_end;
> -		u64 prealloc_start;
> -		u64 prealloc_len = 0;
> -		bool delalloc;
> -
> -		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
> -							delalloc_cached_state,
> -							&delalloc_start,
> -							&delalloc_end);
> -		if (!delalloc)
> -			break;
> -
> -		/*
> -		 * If this is a prealloc extent we have to report every section
> -		 * of it that has no delalloc.
> -		 */
> -		if (disk_bytenr != 0) {
> -			if (last_delalloc_end == 0) {
> -				prealloc_start = start;
> -				prealloc_len = delalloc_start - start;
> -			} else {
> -				prealloc_start = last_delalloc_end + 1;
> -				prealloc_len = delalloc_start - prealloc_start;
> -			}
> -		}
> -
> -		if (prealloc_len > 0) {
> -			if (!checked_extent_shared && fieinfo->fi_extents_max) {
> -				ret = btrfs_is_data_extent_shared(inode,
> -								  disk_bytenr,
> -								  extent_gen,
> -								  backref_ctx);
> -				if (ret < 0)
> -					return ret;
> -				else if (ret > 0)
> -					prealloc_flags |= FIEMAP_EXTENT_SHARED;
> -
> -				checked_extent_shared = true;
> -			}
> -			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
> -						 disk_bytenr + extent_offset,
> -						 prealloc_len, prealloc_flags);
> -			if (ret)
> -				return ret;
> -			extent_offset += prealloc_len;
> -		}
> -
> -		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
> -					 delalloc_end + 1 - delalloc_start,
> -					 FIEMAP_EXTENT_DELALLOC |
> -					 FIEMAP_EXTENT_UNKNOWN);
> -		if (ret)
> -			return ret;
> -
> -		last_delalloc_end = delalloc_end;
> -		cur_offset = delalloc_end + 1;
> -		extent_offset += cur_offset - delalloc_start;
> -		cond_resched();
> -	}
> -
> -	/*
> -	 * Either we found no delalloc for the whole prealloc extent or we have
> -	 * a prealloc extent that spans i_size or starts at or after i_size.
> -	 */
> -	if (disk_bytenr != 0 && last_delalloc_end < end) {
> -		u64 prealloc_start;
> -		u64 prealloc_len;
> -
> -		if (last_delalloc_end == 0) {
> -			prealloc_start = start;
> -			prealloc_len = end + 1 - start;
> -		} else {
> -			prealloc_start = last_delalloc_end + 1;
> -			prealloc_len = end + 1 - prealloc_start;
> -		}
> -
> -		if (!checked_extent_shared && fieinfo->fi_extents_max) {
> -			ret = btrfs_is_data_extent_shared(inode,
> -							  disk_bytenr,
> -							  extent_gen,
> -							  backref_ctx);
> -			if (ret < 0)
> -				return ret;
> -			else if (ret > 0)
> -				prealloc_flags |= FIEMAP_EXTENT_SHARED;
> -		}
> -		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
> -					 disk_bytenr + extent_offset,
> -					 prealloc_len, prealloc_flags);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
> -					  struct btrfs_path *path,
> -					  u64 *last_extent_end_ret)
> -{
> -	const u64 ino = btrfs_ino(inode);
> -	struct btrfs_root *root = inode->root;
> -	struct extent_buffer *leaf;
> -	struct btrfs_file_extent_item *ei;
> -	struct btrfs_key key;
> -	u64 disk_bytenr;
> -	int ret;
> -
> -	/*
> -	 * Lookup the last file extent. We're not using i_size here because
> -	 * there might be preallocation past i_size.
> -	 */
> -	ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
> -	/* There can't be a file extent item at offset (u64)-1 */
> -	ASSERT(ret != 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	/*
> -	 * For a non-existing key, btrfs_search_slot() always leaves us at a
> -	 * slot > 0, except if the btree is empty, which is impossible because
> -	 * at least it has the inode item for this inode and all the items for
> -	 * the root inode 256.
> -	 */
> -	ASSERT(path->slots[0] > 0);
> -	path->slots[0]--;
> -	leaf = path->nodes[0];
> -	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
> -		/* No file extent items in the subvolume tree. */
> -		*last_extent_end_ret = 0;
> -		return 0;
> -	}
> -
> -	/*
> -	 * For an inline extent, the disk_bytenr is where inline data starts at,
> -	 * so first check if we have an inline extent item before checking if we
> -	 * have an implicit hole (disk_bytenr == 0).
> -	 */
> -	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
> -	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
> -		*last_extent_end_ret = btrfs_file_extent_end(path);
> -		return 0;
> -	}
> -
> -	/*
> -	 * Find the last file extent item that is not a hole (when NO_HOLES is
> -	 * not enabled). This should take at most 2 iterations in the worst
> -	 * case: we have one hole file extent item at slot 0 of a leaf and
> -	 * another hole file extent item as the last item in the previous leaf.
> -	 * This is because we merge file extent items that represent holes.
> -	 */
> -	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> -	while (disk_bytenr == 0) {
> -		ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> -		if (ret < 0) {
> -			return ret;
> -		} else if (ret > 0) {
> -			/* No file extent items that are not holes. */
> -			*last_extent_end_ret = 0;
> -			return 0;
> -		}
> -		leaf = path->nodes[0];
> -		ei = btrfs_item_ptr(leaf, path->slots[0],
> -				    struct btrfs_file_extent_item);
> -		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> -	}
> -
> -	*last_extent_end_ret = btrfs_file_extent_end(path);
> -	return 0;
> -}
> -
> -int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> -		  u64 start, u64 len)
> -{
> -	const u64 ino = btrfs_ino(inode);
> -	struct extent_state *cached_state = NULL;
> -	struct extent_state *delalloc_cached_state = NULL;
> -	struct btrfs_path *path;
> -	struct fiemap_cache cache = { 0 };
> -	struct btrfs_backref_share_check_ctx *backref_ctx;
> -	u64 last_extent_end;
> -	u64 prev_extent_end;
> -	u64 lockstart;
> -	u64 lockend;
> -	bool stopped = false;
> -	int ret;
> -
> -	backref_ctx = btrfs_alloc_backref_share_check_ctx();
> -	path = btrfs_alloc_path();
> -	if (!backref_ctx || !path) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	lockstart = round_down(start, inode->root->fs_info->sectorsize);
> -	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
> -	prev_extent_end = lockstart;
> -
> -	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
> -
> -	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
> -	if (ret < 0)
> -		goto out_unlock;
> -	btrfs_release_path(path);
> -
> -	path->reada = READA_FORWARD;
> -	ret = fiemap_search_slot(inode, path, lockstart);
> -	if (ret < 0) {
> -		goto out_unlock;
> -	} else if (ret > 0) {
> -		/*
> -		 * No file extent item found, but we may have delalloc between
> -		 * the current offset and i_size. So check for that.
> -		 */
> -		ret = 0;
> -		goto check_eof_delalloc;
> -	}
> -
> -	while (prev_extent_end < lockend) {
> -		struct extent_buffer *leaf = path->nodes[0];
> -		struct btrfs_file_extent_item *ei;
> -		struct btrfs_key key;
> -		u64 extent_end;
> -		u64 extent_len;
> -		u64 extent_offset = 0;
> -		u64 extent_gen;
> -		u64 disk_bytenr = 0;
> -		u64 flags = 0;
> -		int extent_type;
> -		u8 compression;
> -
> -		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> -			break;
> -
> -		extent_end = btrfs_file_extent_end(path);
> -
> -		/*
> -		 * The first iteration can leave us at an extent item that ends
> -		 * before our range's start. Move to the next item.
> -		 */
> -		if (extent_end <= lockstart)
> -			goto next_item;
> -
> -		backref_ctx->curr_leaf_bytenr = leaf->start;
> -
> -		/* We have in implicit hole (NO_HOLES feature enabled). */
> -		if (prev_extent_end < key.offset) {
> -			const u64 range_end = min(key.offset, lockend) - 1;
> -
> -			ret = fiemap_process_hole(inode, fieinfo, &cache,
> -						  &delalloc_cached_state,
> -						  backref_ctx, 0, 0, 0,
> -						  prev_extent_end, range_end);
> -			if (ret < 0) {
> -				goto out_unlock;
> -			} else if (ret > 0) {
> -				/* fiemap_fill_next_extent() told us to stop. */
> -				stopped = true;
> -				break;
> -			}
> -
> -			/* We've reached the end of the fiemap range, stop. */
> -			if (key.offset >= lockend) {
> -				stopped = true;
> -				break;
> -			}
> -		}
> -
> -		extent_len = extent_end - key.offset;
> -		ei = btrfs_item_ptr(leaf, path->slots[0],
> -				    struct btrfs_file_extent_item);
> -		compression = btrfs_file_extent_compression(leaf, ei);
> -		extent_type = btrfs_file_extent_type(leaf, ei);
> -		extent_gen = btrfs_file_extent_generation(leaf, ei);
> -
> -		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
> -			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> -			if (compression == BTRFS_COMPRESS_NONE)
> -				extent_offset = btrfs_file_extent_offset(leaf, ei);
> -		}
> -
> -		if (compression != BTRFS_COMPRESS_NONE)
> -			flags |= FIEMAP_EXTENT_ENCODED;
> -
> -		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> -			flags |= FIEMAP_EXTENT_DATA_INLINE;
> -			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
> -			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
> -						 extent_len, flags);
> -		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
> -			ret = fiemap_process_hole(inode, fieinfo, &cache,
> -						  &delalloc_cached_state,
> -						  backref_ctx,
> -						  disk_bytenr, extent_offset,
> -						  extent_gen, key.offset,
> -						  extent_end - 1);
> -		} else if (disk_bytenr == 0) {
> -			/* We have an explicit hole. */
> -			ret = fiemap_process_hole(inode, fieinfo, &cache,
> -						  &delalloc_cached_state,
> -						  backref_ctx, 0, 0, 0,
> -						  key.offset, extent_end - 1);
> -		} else {
> -			/* We have a regular extent. */
> -			if (fieinfo->fi_extents_max) {
> -				ret = btrfs_is_data_extent_shared(inode,
> -								  disk_bytenr,
> -								  extent_gen,
> -								  backref_ctx);
> -				if (ret < 0)
> -					goto out_unlock;
> -				else if (ret > 0)
> -					flags |= FIEMAP_EXTENT_SHARED;
> -			}
> -
> -			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
> -						 disk_bytenr + extent_offset,
> -						 extent_len, flags);
> -		}
> -
> -		if (ret < 0) {
> -			goto out_unlock;
> -		} else if (ret > 0) {
> -			/* fiemap_fill_next_extent() told us to stop. */
> -			stopped = true;
> -			break;
> -		}
> -
> -		prev_extent_end = extent_end;
> -next_item:
> -		if (fatal_signal_pending(current)) {
> -			ret = -EINTR;
> -			goto out_unlock;
> -		}
> -
> -		ret = fiemap_next_leaf_item(inode, path);
> -		if (ret < 0) {
> -			goto out_unlock;
> -		} else if (ret > 0) {
> -			/* No more file extent items for this inode. */
> -			break;
> -		}
> -		cond_resched();
> -	}
> -
> -check_eof_delalloc:
> -	/*
> -	 * Release (and free) the path before emitting any final entries to
> -	 * fiemap_fill_next_extent() to keep lockdep happy. This is because
> -	 * once we find no more file extent items exist, we may have a
> -	 * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
> -	 * faults when copying data to the user space buffer.
> -	 */
> -	btrfs_free_path(path);
> -	path = NULL;
> -
> -	if (!stopped && prev_extent_end < lockend) {
> -		ret = fiemap_process_hole(inode, fieinfo, &cache,
> -					  &delalloc_cached_state, backref_ctx,
> -					  0, 0, 0, prev_extent_end, lockend - 1);
> -		if (ret < 0)
> -			goto out_unlock;
> -		prev_extent_end = lockend;
> -	}
> -
> -	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
> -		const u64 i_size = i_size_read(&inode->vfs_inode);
> -
> -		if (prev_extent_end < i_size) {
> -			u64 delalloc_start;
> -			u64 delalloc_end;
> -			bool delalloc;
> -
> -			delalloc = btrfs_find_delalloc_in_range(inode,
> -								prev_extent_end,
> -								i_size - 1,
> -								&delalloc_cached_state,
> -								&delalloc_start,
> -								&delalloc_end);
> -			if (!delalloc)
> -				cache.flags |= FIEMAP_EXTENT_LAST;
> -		} else {
> -			cache.flags |= FIEMAP_EXTENT_LAST;
> -		}
> -	}
> -
> -	ret = emit_last_fiemap_cache(fieinfo, &cache);
> -
> -out_unlock:
> -	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
> -out:
> -	free_extent_state(delalloc_cached_state);
> -	btrfs_free_backref_share_ctx(backref_ctx);
> -	btrfs_free_path(path);
> -	return ret;
> -}
> -
> -static void __free_extent_buffer(struct extent_buffer *eb)
> -{
> -	kmem_cache_free(extent_buffer_cache, eb);
> -}
> -
> -int extent_buffer_under_io(const struct extent_buffer *eb)
> -{
> -	return (atomic_read(&eb->io_pages) ||
> -		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
> -		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> -}
> -
> -static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
> -{
> -	struct btrfs_subpage *subpage;
> -
> -	lockdep_assert_held(&page->mapping->private_lock);
> -
> -	if (PagePrivate(page)) {
> -		subpage = (struct btrfs_subpage *)page->private;
> -		if (atomic_read(&subpage->eb_refs))
> -			return true;
> -		/*
> -		 * Even there is no eb refs here, we may still have
> -		 * end_page_read() call relying on page::private.
> -		 */
> -		if (atomic_read(&subpage->readers))
> -			return true;
> -	}
> -	return false;
> -}
> -
> -static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> -
> -	/*
> -	 * For mapped eb, we're going to change the page private, which should
> -	 * be done under the private_lock.
> -	 */
> -	if (mapped)
> -		spin_lock(&page->mapping->private_lock);
> -
> -	if (!PagePrivate(page)) {
> -		if (mapped)
> -			spin_unlock(&page->mapping->private_lock);
> -		return;
> -	}
> -
> -	if (fs_info->nodesize >= PAGE_SIZE) {
> -		/*
> -		 * We do this since we'll remove the pages after we've
> -		 * removed the eb from the radix tree, so we could race
> -		 * and have this page now attached to the new eb.  So
> -		 * only clear page_private if it's still connected to
> -		 * this eb.
> -		 */
> -		if (PagePrivate(page) &&
> -		    page->private == (unsigned long)eb) {
> -			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> -			BUG_ON(PageDirty(page));
> -			BUG_ON(PageWriteback(page));
> -			/*
> -			 * We need to make sure we haven't be attached
> -			 * to a new eb.
> -			 */
> -			detach_page_private(page);
> -		}
> -		if (mapped)
> -			spin_unlock(&page->mapping->private_lock);
> -		return;
> -	}
> -
> -	/*
> -	 * For subpage, we can have dummy eb with page private.  In this case,
> -	 * we can directly detach the private as such page is only attached to
> -	 * one dummy eb, no sharing.
> -	 */
> -	if (!mapped) {
> -		btrfs_detach_subpage(fs_info, page);
> -		return;
> -	}
> -
> -	btrfs_page_dec_eb_refs(fs_info, page);
> -
> -	/*
> -	 * We can only detach the page private if there are no other ebs in the
> -	 * page range and no unfinished IO.
> -	 */
> -	if (!page_range_has_eb(fs_info, page))
> -		btrfs_detach_subpage(fs_info, page);
> -
> -	spin_unlock(&page->mapping->private_lock);
> -}
> -
> -/* Release all pages attached to the extent buffer */
> -static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
> -{
> -	int i;
> -	int num_pages;
> -
> -	ASSERT(!extent_buffer_under_io(eb));
> -
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *page = eb->pages[i];
> -
> -		if (!page)
> -			continue;
> -
> -		detach_extent_buffer_page(eb, page);
> -
> -		/* One for when we allocated the page */
> -		put_page(page);
> -	}
> -}
> -
> -/*
> - * Helper for releasing the extent buffer.
> - */
> -static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
> -{
> -	btrfs_release_extent_buffer_pages(eb);
> -	btrfs_leak_debug_del_eb(eb);
> -	__free_extent_buffer(eb);
> -}
> -
> -static struct extent_buffer *
> -__alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
> -		      unsigned long len)
> -{
> -	struct extent_buffer *eb = NULL;
> -
> -	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
> -	eb->start = start;
> -	eb->len = len;
> -	eb->fs_info = fs_info;
> -	init_rwsem(&eb->lock);
> -
> -	btrfs_leak_debug_add_eb(eb);
> -	INIT_LIST_HEAD(&eb->release_list);
> -
> -	spin_lock_init(&eb->refs_lock);
> -	atomic_set(&eb->refs, 1);
> -	atomic_set(&eb->io_pages, 0);
> -
> -	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
> -
> -	return eb;
> -}
> -
> -struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> -{
> -	int i;
> -	struct extent_buffer *new;
> -	int num_pages = num_extent_pages(src);
> -	int ret;
> -
> -	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
> -	if (new == NULL)
> -		return NULL;
> -
> -	/*
> -	 * Set UNMAPPED before calling btrfs_release_extent_buffer(), as
> -	 * btrfs_release_extent_buffer() have different behavior for
> -	 * UNMAPPED subpage extent buffer.
> -	 */
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> -
> -	ret = btrfs_alloc_page_array(num_pages, new->pages);
> -	if (ret) {
> -		btrfs_release_extent_buffer(new);
> -		return NULL;
> -	}
> -
> -	for (i = 0; i < num_pages; i++) {
> -		int ret;
> -		struct page *p = new->pages[i];
> -
> -		ret = attach_extent_buffer_page(new, p, NULL);
> -		if (ret < 0) {
> -			btrfs_release_extent_buffer(new);
> -			return NULL;
> -		}
> -		WARN_ON(PageDirty(p));
> -		copy_page(page_address(p), page_address(src->pages[i]));
> -	}
> -	set_extent_buffer_uptodate(new);
> -
> -	return new;
> -}
> -
> -struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> -						  u64 start, unsigned long len)
> -{
> -	struct extent_buffer *eb;
> -	int num_pages;
> -	int i;
> -	int ret;
> -
> -	eb = __alloc_extent_buffer(fs_info, start, len);
> -	if (!eb)
> -		return NULL;
> -
> -	num_pages = num_extent_pages(eb);
> -	ret = btrfs_alloc_page_array(num_pages, eb->pages);
> -	if (ret)
> -		goto err;
> -
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *p = eb->pages[i];
> -
> -		ret = attach_extent_buffer_page(eb, p, NULL);
> -		if (ret < 0)
> -			goto err;
> -	}
> -
> -	set_extent_buffer_uptodate(eb);
> -	btrfs_set_header_nritems(eb, 0);
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> -
> -	return eb;
> -err:
> -	for (i = 0; i < num_pages; i++) {
> -		if (eb->pages[i]) {
> -			detach_extent_buffer_page(eb, eb->pages[i]);
> -			__free_page(eb->pages[i]);
> -		}
> -	}
> -	__free_extent_buffer(eb);
> -	return NULL;
> -}
> -
> -struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> -						u64 start)
> -{
> -	return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
> -}
> -
> -static void check_buffer_tree_ref(struct extent_buffer *eb)
> -{
> -	int refs;
> -	/*
> -	 * The TREE_REF bit is first set when the extent_buffer is added
> -	 * to the radix tree. It is also reset, if unset, when a new reference
> -	 * is created by find_extent_buffer.
> -	 *
> -	 * It is only cleared in two cases: freeing the last non-tree
> -	 * reference to the extent_buffer when its STALE bit is set or
> -	 * calling release_folio when the tree reference is the only reference.
> -	 *
> -	 * In both cases, care is taken to ensure that the extent_buffer's
> -	 * pages are not under io. However, release_folio can be concurrently
> -	 * called with creating new references, which is prone to race
> -	 * conditions between the calls to check_buffer_tree_ref in those
> -	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
> -	 *
> -	 * The actual lifetime of the extent_buffer in the radix tree is
> -	 * adequately protected by the refcount, but the TREE_REF bit and
> -	 * its corresponding reference are not. To protect against this
> -	 * class of races, we call check_buffer_tree_ref from the codepaths
> -	 * which trigger io after they set eb->io_pages. Note that once io is
> -	 * initiated, TREE_REF can no longer be cleared, so that is the
> -	 * moment at which any such race is best fixed.
> -	 */
> -	refs = atomic_read(&eb->refs);
> -	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> -		return;
> -
> -	spin_lock(&eb->refs_lock);
> -	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> -		atomic_inc(&eb->refs);
> -	spin_unlock(&eb->refs_lock);
> -}
> -
> -static void mark_extent_buffer_accessed(struct extent_buffer *eb,
> -		struct page *accessed)
> -{
> -	int num_pages, i;
> -
> -	check_buffer_tree_ref(eb);
> -
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *p = eb->pages[i];
> -
> -		if (p != accessed)
> -			mark_page_accessed(p);
> -	}
> -}
> -
> -struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
> -					 u64 start)
> -{
> -	struct extent_buffer *eb;
> -
> -	eb = find_extent_buffer_nolock(fs_info, start);
> -	if (!eb)
> -		return NULL;
> -	/*
> -	 * Lock our eb's refs_lock to avoid races with free_extent_buffer().
> -	 * When we get our eb it might be flagged with EXTENT_BUFFER_STALE and
> -	 * another task running free_extent_buffer() might have seen that flag
> -	 * set, eb->refs == 2, that the buffer isn't under IO (dirty and
> -	 * writeback flags not set) and it's still in the tree (flag
> -	 * EXTENT_BUFFER_TREE_REF set), therefore being in the process of
> -	 * decrementing the extent buffer's reference count twice.  So here we
> -	 * could race and increment the eb's reference count, clear its stale
> -	 * flag, mark it as dirty and drop our reference before the other task
> -	 * finishes executing free_extent_buffer, which would later result in
> -	 * an attempt to free an extent buffer that is dirty.
> -	 */
> -	if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
> -		spin_lock(&eb->refs_lock);
> -		spin_unlock(&eb->refs_lock);
> -	}
> -	mark_extent_buffer_accessed(eb, NULL);
> -	return eb;
> -}
> -
> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> -struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> -					u64 start)
> -{
> -	struct extent_buffer *eb, *exists = NULL;
> -	int ret;
> -
> -	eb = find_extent_buffer(fs_info, start);
> -	if (eb)
> -		return eb;
> -	eb = alloc_dummy_extent_buffer(fs_info, start);
> -	if (!eb)
> -		return ERR_PTR(-ENOMEM);
> -	eb->fs_info = fs_info;
> -again:
> -	ret = radix_tree_preload(GFP_NOFS);
> -	if (ret) {
> -		exists = ERR_PTR(ret);
> -		goto free_eb;
> -	}
> -	spin_lock(&fs_info->buffer_lock);
> -	ret = radix_tree_insert(&fs_info->buffer_radix,
> -				start >> fs_info->sectorsize_bits, eb);
> -	spin_unlock(&fs_info->buffer_lock);
> -	radix_tree_preload_end();
> -	if (ret == -EEXIST) {
> -		exists = find_extent_buffer(fs_info, start);
> -		if (exists)
> -			goto free_eb;
> -		else
> -			goto again;
> -	}
> -	check_buffer_tree_ref(eb);
> -	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
> -
> -	return eb;
> -free_eb:
> -	btrfs_release_extent_buffer(eb);
> -	return exists;
> -}
> -#endif
> -
> -static struct extent_buffer *grab_extent_buffer(
> -		struct btrfs_fs_info *fs_info, struct page *page)
> -{
> -	struct extent_buffer *exists;
> -
> -	/*
> -	 * For subpage case, we completely rely on radix tree to ensure we
> -	 * don't try to insert two ebs for the same bytenr.  So here we always
> -	 * return NULL and just continue.
> -	 */
> -	if (fs_info->nodesize < PAGE_SIZE)
> -		return NULL;
> -
> -	/* Page not yet attached to an extent buffer */
> -	if (!PagePrivate(page))
> -		return NULL;
> -
> -	/*
> -	 * We could have already allocated an eb for this page and attached one
> -	 * so lets see if we can get a ref on the existing eb, and if we can we
> -	 * know it's good and we can just return that one, else we know we can
> -	 * just overwrite page->private.
> -	 */
> -	exists = (struct extent_buffer *)page->private;
> -	if (atomic_inc_not_zero(&exists->refs))
> -		return exists;
> -
> -	WARN_ON(PageDirty(page));
> -	detach_page_private(page);
> -	return NULL;
> -}
> -
> -static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
> -{
> -	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
> -		btrfs_err(fs_info, "bad tree block start %llu", start);
> -		return -EINVAL;
> -	}
> -
> -	if (fs_info->nodesize < PAGE_SIZE &&
> -	    offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
> -		btrfs_err(fs_info,
> -		"tree block crosses page boundary, start %llu nodesize %u",
> -			  start, fs_info->nodesize);
> -		return -EINVAL;
> -	}
> -	if (fs_info->nodesize >= PAGE_SIZE &&
> -	    !PAGE_ALIGNED(start)) {
> -		btrfs_err(fs_info,
> -		"tree block is not page aligned, start %llu nodesize %u",
> -			  start, fs_info->nodesize);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> -					  u64 start, u64 owner_root, int level)
> -{
> -	unsigned long len = fs_info->nodesize;
> -	int num_pages;
> -	int i;
> -	unsigned long index = start >> PAGE_SHIFT;
> -	struct extent_buffer *eb;
> -	struct extent_buffer *exists = NULL;
> -	struct page *p;
> -	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> -	u64 lockdep_owner = owner_root;
> -	int uptodate = 1;
> -	int ret;
> -
> -	if (check_eb_alignment(fs_info, start))
> -		return ERR_PTR(-EINVAL);
> -
> -#if BITS_PER_LONG == 32
> -	if (start >= MAX_LFS_FILESIZE) {
> -		btrfs_err_rl(fs_info,
> -		"extent buffer %llu is beyond 32bit page cache limit", start);
> -		btrfs_err_32bit_limit(fs_info);
> -		return ERR_PTR(-EOVERFLOW);
> -	}
> -	if (start >= BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> -		btrfs_warn_32bit_limit(fs_info);
> -#endif
> -
> -	eb = find_extent_buffer(fs_info, start);
> -	if (eb)
> -		return eb;
> -
> -	eb = __alloc_extent_buffer(fs_info, start, len);
> -	if (!eb)
> -		return ERR_PTR(-ENOMEM);
> -
> -	/*
> -	 * The reloc trees are just snapshots, so we need them to appear to be
> -	 * just like any other fs tree WRT lockdep.
> -	 */
> -	if (lockdep_owner == BTRFS_TREE_RELOC_OBJECTID)
> -		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
> -
> -	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
> -
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++, index++) {
> -		struct btrfs_subpage *prealloc = NULL;
> -
> -		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
> -		if (!p) {
> -			exists = ERR_PTR(-ENOMEM);
> -			goto free_eb;
> -		}
> -
> -		/*
> -		 * Preallocate page->private for subpage case, so that we won't
> -		 * allocate memory with private_lock hold.  The memory will be
> -		 * freed by attach_extent_buffer_page() or freed manually if
> -		 * we exit earlier.
> -		 *
> -		 * Although we have ensured one subpage eb can only have one
> -		 * page, but it may change in the future for 16K page size
> -		 * support, so we still preallocate the memory in the loop.
> -		 */
> -		if (fs_info->nodesize < PAGE_SIZE) {
> -			prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
> -			if (IS_ERR(prealloc)) {
> -				ret = PTR_ERR(prealloc);
> -				unlock_page(p);
> -				put_page(p);
> -				exists = ERR_PTR(ret);
> -				goto free_eb;
> -			}
> -		}
> -
> -		spin_lock(&mapping->private_lock);
> -		exists = grab_extent_buffer(fs_info, p);
> -		if (exists) {
> -			spin_unlock(&mapping->private_lock);
> -			unlock_page(p);
> -			put_page(p);
> -			mark_extent_buffer_accessed(exists, p);
> -			btrfs_free_subpage(prealloc);
> -			goto free_eb;
> -		}
> -		/* Should not fail, as we have preallocated the memory */
> -		ret = attach_extent_buffer_page(eb, p, prealloc);
> -		ASSERT(!ret);
> -		/*
> -		 * To inform we have extra eb under allocation, so that
> -		 * detach_extent_buffer_page() won't release the page private
> -		 * when the eb hasn't yet been inserted into radix tree.
> -		 *
> -		 * The ref will be decreased when the eb released the page, in
> -		 * detach_extent_buffer_page().
> -		 * Thus needs no special handling in error path.
> -		 */
> -		btrfs_page_inc_eb_refs(fs_info, p);
> -		spin_unlock(&mapping->private_lock);
> -
> -		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
> -		eb->pages[i] = p;
> -		if (!PageUptodate(p))
> -			uptodate = 0;
> -
> -		/*
> -		 * We can't unlock the pages just yet since the extent buffer
> -		 * hasn't been properly inserted in the radix tree, this
> -		 * opens a race with btree_release_folio which can free a page
> -		 * while we are still filling in all pages for the buffer and
> -		 * we could crash.
> -		 */
> -	}
> -	if (uptodate)
> -		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -again:
> -	ret = radix_tree_preload(GFP_NOFS);
> -	if (ret) {
> -		exists = ERR_PTR(ret);
> -		goto free_eb;
> -	}
> -
> -	spin_lock(&fs_info->buffer_lock);
> -	ret = radix_tree_insert(&fs_info->buffer_radix,
> -				start >> fs_info->sectorsize_bits, eb);
> -	spin_unlock(&fs_info->buffer_lock);
> -	radix_tree_preload_end();
> -	if (ret == -EEXIST) {
> -		exists = find_extent_buffer(fs_info, start);
> -		if (exists)
> -			goto free_eb;
> -		else
> -			goto again;
> -	}
> -	/* add one reference for the tree */
> -	check_buffer_tree_ref(eb);
> -	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
> -
> -	/*
> -	 * Now it's safe to unlock the pages because any calls to
> -	 * btree_release_folio will correctly detect that a page belongs to a
> -	 * live buffer and won't free them prematurely.
> -	 */
> -	for (i = 0; i < num_pages; i++)
> -		unlock_page(eb->pages[i]);
> -	return eb;
> -
> -free_eb:
> -	WARN_ON(!atomic_dec_and_test(&eb->refs));
> -	for (i = 0; i < num_pages; i++) {
> -		if (eb->pages[i])
> -			unlock_page(eb->pages[i]);
> -	}
> -
> -	btrfs_release_extent_buffer(eb);
> -	return exists;
> -}
> -
> -static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
> -{
> -	struct extent_buffer *eb =
> -			container_of(head, struct extent_buffer, rcu_head);
> -
> -	__free_extent_buffer(eb);
> -}
> -
> -static int release_extent_buffer(struct extent_buffer *eb)
> -	__releases(&eb->refs_lock)
> -{
> -	lockdep_assert_held(&eb->refs_lock);
> -
> -	WARN_ON(atomic_read(&eb->refs) == 0);
> -	if (atomic_dec_and_test(&eb->refs)) {
> -		if (test_and_clear_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags)) {
> -			struct btrfs_fs_info *fs_info = eb->fs_info;
> -
> -			spin_unlock(&eb->refs_lock);
> -
> -			spin_lock(&fs_info->buffer_lock);
> -			radix_tree_delete(&fs_info->buffer_radix,
> -					  eb->start >> fs_info->sectorsize_bits);
> -			spin_unlock(&fs_info->buffer_lock);
> -		} else {
> -			spin_unlock(&eb->refs_lock);
> -		}
> -
> -		btrfs_leak_debug_del_eb(eb);
> -		/* Should be safe to release our pages at this point */
> -		btrfs_release_extent_buffer_pages(eb);
> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> -		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
> -			__free_extent_buffer(eb);
> -			return 1;
> -		}
> -#endif
> -		call_rcu(&eb->rcu_head, btrfs_release_extent_buffer_rcu);
> -		return 1;
> -	}
> -	spin_unlock(&eb->refs_lock);
> -
> -	return 0;
> -}
> -
> -void free_extent_buffer(struct extent_buffer *eb)
> -{
> -	int refs;
> -	if (!eb)
> -		return;
> -
> -	refs = atomic_read(&eb->refs);
> -	while (1) {
> -		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
> -		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
> -			refs == 1))
> -			break;
> -		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
> -			return;
> -	}
> -
> -	spin_lock(&eb->refs_lock);
> -	if (atomic_read(&eb->refs) == 2 &&
> -	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
> -	    !extent_buffer_under_io(eb) &&
> -	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> -		atomic_dec(&eb->refs);
> -
> -	/*
> -	 * I know this is terrible, but it's temporary until we stop tracking
> -	 * the uptodate bits and such for the extent buffers.
> -	 */
> -	release_extent_buffer(eb);
> -}
> -
> -void free_extent_buffer_stale(struct extent_buffer *eb)
> -{
> -	if (!eb)
> -		return;
> -
> -	spin_lock(&eb->refs_lock);
> -	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
> -
> -	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
> -	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> -		atomic_dec(&eb->refs);
> -	release_extent_buffer(eb);
> -}
> -
> -static void btree_clear_page_dirty(struct page *page)
> -{
> -	ASSERT(PageDirty(page));
> -	ASSERT(PageLocked(page));
> -	clear_page_dirty_for_io(page);
> -	xa_lock_irq(&page->mapping->i_pages);
> -	if (!PageDirty(page))
> -		__xa_clear_mark(&page->mapping->i_pages,
> -				page_index(page), PAGECACHE_TAG_DIRTY);
> -	xa_unlock_irq(&page->mapping->i_pages);
> -}
> -
> -static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct page *page = eb->pages[0];
> -	bool last;
> -
> -	/* btree_clear_page_dirty() needs page locked */
> -	lock_page(page);
> -	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, eb->start,
> -						  eb->len);
> -	if (last)
> -		btree_clear_page_dirty(page);
> -	unlock_page(page);
> -	WARN_ON(atomic_read(&eb->refs) == 0);
> -}
> -
> -void clear_extent_buffer_dirty(const struct extent_buffer *eb)
> -{
> -	int i;
> -	int num_pages;
> -	struct page *page;
> -
> -	if (eb->fs_info->nodesize < PAGE_SIZE)
> -		return clear_subpage_extent_buffer_dirty(eb);
> -
> -	num_pages = num_extent_pages(eb);
> -
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		if (!PageDirty(page))
> -			continue;
> -		lock_page(page);
> -		btree_clear_page_dirty(page);
> -		ClearPageError(page);
> -		unlock_page(page);
> -	}
> -	WARN_ON(atomic_read(&eb->refs) == 0);
> -}
> -
> -bool set_extent_buffer_dirty(struct extent_buffer *eb)
> -{
> -	int i;
> -	int num_pages;
> -	bool was_dirty;
> -
> -	check_buffer_tree_ref(eb);
> -
> -	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
> -
> -	num_pages = num_extent_pages(eb);
> -	WARN_ON(atomic_read(&eb->refs) == 0);
> -	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
> -
> -	if (!was_dirty) {
> -		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
> -
> -		/*
> -		 * For subpage case, we can have other extent buffers in the
> -		 * same page, and in clear_subpage_extent_buffer_dirty() we
> -		 * have to clear page dirty without subpage lock held.
> -		 * This can cause race where our page gets dirty cleared after
> -		 * we just set it.
> -		 *
> -		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
> -		 * its page for other reasons, we can use page lock to prevent
> -		 * the above race.
> -		 */
> -		if (subpage)
> -			lock_page(eb->pages[0]);
> -		for (i = 0; i < num_pages; i++)
> -			btrfs_page_set_dirty(eb->fs_info, eb->pages[i],
> -					     eb->start, eb->len);
> -		if (subpage)
> -			unlock_page(eb->pages[0]);
> -	}
> -#ifdef CONFIG_BTRFS_DEBUG
> -	for (i = 0; i < num_pages; i++)
> -		ASSERT(PageDirty(eb->pages[i]));
> -#endif
> -
> -	return was_dirty;
> -}
> -
> -void clear_extent_buffer_uptodate(struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct page *page;
> -	int num_pages;
> -	int i;
> -
> -	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		if (!page)
> -			continue;
> -
> -		/*
> -		 * This is special handling for metadata subpage, as regular
> -		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
> -		 */
> -		if (fs_info->nodesize >= PAGE_SIZE)
> -			ClearPageUptodate(page);
> -		else
> -			btrfs_subpage_clear_uptodate(fs_info, page, eb->start,
> -						     eb->len);
> -	}
> -}
> -
> -void set_extent_buffer_uptodate(struct extent_buffer *eb)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct page *page;
> -	int num_pages;
> -	int i;
> -
> -	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -
> -		/*
> -		 * This is special handling for metadata subpage, as regular
> -		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
> -		 */
> -		if (fs_info->nodesize >= PAGE_SIZE)
> -			SetPageUptodate(page);
> -		else
> -			btrfs_subpage_set_uptodate(fs_info, page, eb->start,
> -						   eb->len);
> -	}
> -}
> -
> -static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
> -				      int mirror_num,
> -				      struct btrfs_tree_parent_check *check)
> -{
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	struct extent_io_tree *io_tree;
> -	struct page *page = eb->pages[0];
> -	struct extent_state *cached_state = NULL;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.mirror_num = mirror_num,
> -		.parent_check = check,
> -	};
> -	int ret = 0;
> -
> -	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
> -	ASSERT(PagePrivate(page));
> -	ASSERT(check);
> -	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
> -
> -	if (wait == WAIT_NONE) {
> -		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> -				     &cached_state))
> -			return -EAGAIN;
> -	} else {
> -		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> -				  &cached_state);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	ret = 0;
> -	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
> -	    PageUptodate(page) ||
> -	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
> -		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
> -			      &cached_state);
> -		return ret;
> -	}
> -
> -	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> -	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, 1);
> -	check_buffer_tree_ref(eb);
> -	bio_ctrl.end_io_func = end_bio_extent_readpage;
> +			 * ongoing fast fsync that could miss the new extent.
> +			 */
> +			fs_info = btrfs_inode->root->fs_info;
> +			spin_lock(&fs_info->trans_lock);
> +			cur_gen = fs_info->generation;
> +			spin_unlock(&fs_info->trans_lock);
> +			if (em->generation >= cur_gen)
> +				goto next;
> +remove_em:
> +			/*
> +			 * We only remove extent maps that are not in the list of
> +			 * modified extents or that are in the list but with a
> +			 * generation lower then the current generation, so there
> +			 * is no need to set the full fsync flag on the inode (it
> +			 * hurts the fsync performance for workloads with a data
> +			 * size that exceeds or is close to the system's memory).
> +			 */
> +			remove_extent_mapping(map, em);
> +			/* once for the rb tree */
> +			free_extent_map(em);
> +next:
> +			start = extent_map_end(em);
> +			write_unlock(&map->lock);
>   
> -	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
> +			/* once for us */
> +			free_extent_map(em);
>   
> -	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
> -				 eb->start, page, eb->len,
> -				 eb->start - page_offset(page), 0, true);
> -	if (ret) {
> -		/*
> -		 * In the endio function, if we hit something wrong we will
> -		 * increase the io_pages, so here we need to decrease it for
> -		 * error path.
> -		 */
> -		atomic_dec(&eb->io_pages);
> -	}
> -	submit_one_bio(&bio_ctrl);
> -	if (ret || wait != WAIT_COMPLETE) {
> -		free_extent_state(cached_state);
> -		return ret;
> +			cond_resched(); /* Allow large-extent preemption. */
> +		}
>   	}
> -
> -	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
> -			EXTENT_LOCKED, &cached_state);
> -	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> -		ret = -EIO;
> -	return ret;
> +	return try_release_extent_state(tree, page, mask);
>   }
>   
> -int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
> -			     struct btrfs_tree_parent_check *check)
> +/*
> + * To cache previous fiemap extent
> + *
> + * Will be used for merging fiemap extent
> + */
> +struct fiemap_cache {
> +	u64 offset;
> +	u64 phys;
> +	u64 len;
> +	u32 flags;
> +	bool cached;
> +};
> +
> +/*
> + * Helper to submit fiemap extent.
> + *
> + * Will try to merge current fiemap extent specified by @offset, @phys,
> + * @len and @flags with cached one.
> + * And only when we fails to merge, cached one will be submitted as
> + * fiemap extent.
> + *
> + * Return value is the same as fiemap_fill_next_extent().
> + */
> +static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
> +				struct fiemap_cache *cache,
> +				u64 offset, u64 phys, u64 len, u32 flags)
>   {
> -	int i;
> -	struct page *page;
> -	int err;
>   	int ret = 0;
> -	int locked_pages = 0;
> -	int all_uptodate = 1;
> -	int num_pages;
> -	unsigned long num_reads = 0;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.mirror_num = mirror_num,
> -		.parent_check = check,
> -	};
> -
> -	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> -		return 0;
>   
> -	/*
> -	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
> -	 * operation, which could potentially still be in flight.  In this case
> -	 * we simply want to return an error.
> -	 */
> -	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
> -		return -EIO;
> +	/* Set at the end of extent_fiemap(). */
> +	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
>   
> -	if (eb->fs_info->nodesize < PAGE_SIZE)
> -		return read_extent_buffer_subpage(eb, wait, mirror_num, check);
> +	if (!cache->cached)
> +		goto assign;
>   
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		if (wait == WAIT_NONE) {
> -			/*
> -			 * WAIT_NONE is only utilized by readahead. If we can't
> -			 * acquire the lock atomically it means either the eb
> -			 * is being read out or under modification.
> -			 * Either way the eb will be or has been cached,
> -			 * readahead can exit safely.
> -			 */
> -			if (!trylock_page(page))
> -				goto unlock_exit;
> -		} else {
> -			lock_page(page);
> -		}
> -		locked_pages++;
> -	}
>   	/*
> -	 * We need to firstly lock all pages to make sure that
> -	 * the uptodate bit of our pages won't be affected by
> -	 * clear_extent_buffer_uptodate().
> +	 * Sanity check, extent_fiemap() should have ensured that new
> +	 * fiemap extent won't overlap with cached one.
> +	 * Not recoverable.
> +	 *
> +	 * NOTE: Physical address can overlap, due to compression
>   	 */
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		if (!PageUptodate(page)) {
> -			num_reads++;
> -			all_uptodate = 0;
> -		}
> -	}
> -
> -	if (all_uptodate) {
> -		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -		goto unlock_exit;
> +	if (cache->offset + cache->len > offset) {
> +		WARN_ON(1);
> +		return -EINVAL;
>   	}
>   
> -	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> -	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, num_reads);
>   	/*
> -	 * It is possible for release_folio to clear the TREE_REF bit before we
> -	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
> +	 * Only merges fiemap extents if
> +	 * 1) Their logical addresses are continuous
> +	 *
> +	 * 2) Their physical addresses are continuous
> +	 *    So truly compressed (physical size smaller than logical size)
> +	 *    extents won't get merged with each other
> +	 *
> +	 * 3) Share same flags
>   	 */
> -	check_buffer_tree_ref(eb);
> -	bio_ctrl.end_io_func = end_bio_extent_readpage;
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -
> -		if (!PageUptodate(page)) {
> -			if (ret) {
> -				atomic_dec(&eb->io_pages);
> -				unlock_page(page);
> -				continue;
> -			}
> -
> -			ClearPageError(page);
> -			err = submit_extent_page(REQ_OP_READ, NULL,
> -					 &bio_ctrl, page_offset(page), page,
> -					 PAGE_SIZE, 0, 0, false);
> -			if (err) {
> -				/*
> -				 * We failed to submit the bio so it's the
> -				 * caller's responsibility to perform cleanup
> -				 * i.e unlock page/set error bit.
> -				 */
> -				ret = err;
> -				SetPageError(page);
> -				unlock_page(page);
> -				atomic_dec(&eb->io_pages);
> -			}
> -		} else {
> -			unlock_page(page);
> -		}
> +	if (cache->offset + cache->len  == offset &&
> +	    cache->phys + cache->len == phys  &&
> +	    cache->flags == flags) {
> +		cache->len += len;
> +		return 0;
>   	}
>   
> -	submit_one_bio(&bio_ctrl);
> -
> -	if (ret || wait != WAIT_COMPLETE)
> +	/* Not mergeable, need to submit cached one */
> +	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
> +				      cache->len, cache->flags);
> +	cache->cached = false;
> +	if (ret)
>   		return ret;
> +assign:
> +	cache->cached = true;
> +	cache->offset = offset;
> +	cache->phys = phys;
> +	cache->len = len;
> +	cache->flags = flags;
>   
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		wait_on_page_locked(page);
> -		if (!PageUptodate(page))
> -			ret = -EIO;
> -	}
> -
> -	return ret;
> -
> -unlock_exit:
> -	while (locked_pages > 0) {
> -		locked_pages--;
> -		page = eb->pages[locked_pages];
> -		unlock_page(page);
> -	}
> -	return ret;
> -}
> -
> -static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
> -			    unsigned long len)
> -{
> -	btrfs_warn(eb->fs_info,
> -		"access to eb bytenr %llu len %lu out of range start %lu len %lu",
> -		eb->start, eb->len, start, len);
> -	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> -
> -	return true;
> +	return 0;
>   }
>   
>   /*
> - * Check if the [start, start + len) range is valid before reading/writing
> - * the eb.
> - * NOTE: @start and @len are offset inside the eb, not logical address.
> + * Emit last fiemap cache
> + *
> + * The last fiemap cache may still be cached in the following case:
> + * 0		      4k		    8k
> + * |<- Fiemap range ->|
> + * |<------------  First extent ----------->|
>    *
> - * Caller should not touch the dst/src memory if this function returns error.
> + * In this case, the first extent range will be cached but not emitted.
> + * So we must emit it before ending extent_fiemap().
>    */
> -static inline int check_eb_range(const struct extent_buffer *eb,
> -				 unsigned long start, unsigned long len)
> +static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
> +				  struct fiemap_cache *cache)
>   {
> -	unsigned long offset;
> +	int ret;
>   
> -	/* start, start + len should not go beyond eb->len nor overflow */
> -	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
> -		return report_eb_range(eb, start, len);
> +	if (!cache->cached)
> +		return 0;
>   
> -	return false;
> +	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
> +				      cache->len, cache->flags);
> +	cache->cached = false;
> +	if (ret > 0)
> +		ret = 0;
> +	return ret;
>   }
>   
> -void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
> -			unsigned long start, unsigned long len)
> +static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
>   {
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	char *dst = (char *)dstv;
> -	unsigned long i = get_eb_page_index(start);
> +	struct extent_buffer *clone;
> +	struct btrfs_key key;
> +	int slot;
> +	int ret;
>   
> -	if (check_eb_range(eb, start, len))
> -		return;
> +	path->slots[0]++;
> +	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
> +		return 0;
> +
> +	ret = btrfs_next_leaf(inode->root, path);
> +	if (ret != 0)
> +		return ret;
>   
> -	offset = get_eb_offset_in_page(eb, start);
> +	/*
> +	 * Don't bother with cloning if there are no more file extent items for
> +	 * our inode.
> +	 */
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY)
> +		return 1;
>   
> -	while (len > 0) {
> -		page = eb->pages[i];
> +	/* See the comment at fiemap_search_slot() about why we clone. */
> +	clone = btrfs_clone_extent_buffer(path->nodes[0]);
> +	if (!clone)
> +		return -ENOMEM;
>   
> -		cur = min(len, (PAGE_SIZE - offset));
> -		kaddr = page_address(page);
> -		memcpy(dst, kaddr + offset, cur);
> +	slot = path->slots[0];
> +	btrfs_release_path(path);
> +	path->nodes[0] = clone;
> +	path->slots[0] = slot;
>   
> -		dst += cur;
> -		len -= cur;
> -		offset = 0;
> -		i++;
> -	}
> +	return 0;
>   }
>   
> -int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
> -				       void __user *dstv,
> -				       unsigned long start, unsigned long len)
> +/*
> + * Search for the first file extent item that starts at a given file offset or
> + * the one that starts immediately before that offset.
> + * Returns: 0 on success, < 0 on error, 1 if not found.
> + */
> +static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path,
> +			      u64 file_offset)
>   {
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	char __user *dst = (char __user *)dstv;
> -	unsigned long i = get_eb_page_index(start);
> -	int ret = 0;
> -
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> -
> -	offset = get_eb_offset_in_page(eb, start);
> +	const u64 ino = btrfs_ino(inode);
> +	struct btrfs_root *root = inode->root;
> +	struct extent_buffer *clone;
> +	struct btrfs_key key;
> +	int slot;
> +	int ret;
>   
> -	while (len > 0) {
> -		page = eb->pages[i];
> +	key.objectid = ino;
> +	key.type = BTRFS_EXTENT_DATA_KEY;
> +	key.offset = file_offset;
>   
> -		cur = min(len, (PAGE_SIZE - offset));
> -		kaddr = page_address(page);
> -		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
> -			ret = -EFAULT;
> -			break;
> -		}
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	if (ret < 0)
> +		return ret;
>   
> -		dst += cur;
> -		len -= cur;
> -		offset = 0;
> -		i++;
> +	if (ret > 0 && path->slots[0] > 0) {
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
> +		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
> +			path->slots[0]--;
>   	}
>   
> -	return ret;
> -}
> -
> -int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
> -			 unsigned long start, unsigned long len)
> -{
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	char *ptr = (char *)ptrv;
> -	unsigned long i = get_eb_page_index(start);
> -	int ret = 0;
> -
> -	if (check_eb_range(eb, start, len))
> -		return -EINVAL;
> -
> -	offset = get_eb_offset_in_page(eb, start);
> -
> -	while (len > 0) {
> -		page = eb->pages[i];
> +	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
> +		ret = btrfs_next_leaf(root, path);
> +		if (ret != 0)
> +			return ret;
>   
> -		cur = min(len, (PAGE_SIZE - offset));
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> +			return 1;
> +	}
>   
> -		kaddr = page_address(page);
> -		ret = memcmp(ptr, kaddr + offset, cur);
> -		if (ret)
> -			break;
> +	/*
> +	 * We clone the leaf and use it during fiemap. This is because while
> +	 * using the leaf we do expensive things like checking if an extent is
> +	 * shared, which can take a long time. In order to prevent blocking
> +	 * other tasks for too long, we use a clone of the leaf. We have locked
> +	 * the file range in the inode's io tree, so we know none of our file
> +	 * extent items can change. This way we avoid blocking other tasks that
> +	 * want to insert items for other inodes in the same leaf or b+tree
> +	 * rebalance operations (triggered for example when someone is trying
> +	 * to push items into this leaf when trying to insert an item in a
> +	 * neighbour leaf).
> +	 * We also need the private clone because holding a read lock on an
> +	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
> +	 * when we call fiemap_fill_next_extent(), because that may cause a page
> +	 * fault when filling the user space buffer with fiemap data.
> +	 */
> +	clone = btrfs_clone_extent_buffer(path->nodes[0]);
> +	if (!clone)
> +		return -ENOMEM;
>   
> -		ptr += cur;
> -		len -= cur;
> -		offset = 0;
> -		i++;
> -	}
> -	return ret;
> +	slot = path->slots[0];
> +	btrfs_release_path(path);
> +	path->nodes[0] = clone;
> +	path->slots[0] = slot;
> +
> +	return 0;
>   }
>   
>   /*
> - * Check that the extent buffer is uptodate.
> - *
> - * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
> - * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
> + * Process a range which is a hole or a prealloc extent in the inode's subvolume
> + * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
> + * extent. The end offset (@end) is inclusive.
>    */
> -static void assert_eb_page_uptodate(const struct extent_buffer *eb,
> -				    struct page *page)
> +static int fiemap_process_hole(struct btrfs_inode *inode,
> +			       struct fiemap_extent_info *fieinfo,
> +			       struct fiemap_cache *cache,
> +			       struct extent_state **delalloc_cached_state,
> +			       struct btrfs_backref_share_check_ctx *backref_ctx,
> +			       u64 disk_bytenr, u64 extent_offset,
> +			       u64 extent_gen,
> +			       u64 start, u64 end)
>   {
> -	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	const u64 i_size = i_size_read(&inode->vfs_inode);
> +	u64 cur_offset = start;
> +	u64 last_delalloc_end = 0;
> +	u32 prealloc_flags = FIEMAP_EXTENT_UNWRITTEN;
> +	bool checked_extent_shared = false;
> +	int ret;
>   
>   	/*
> -	 * If we are using the commit root we could potentially clear a page
> -	 * Uptodate while we're using the extent buffer that we've previously
> -	 * looked up.  We don't want to complain in this case, as the page was
> -	 * valid before, we just didn't write it out.  Instead we want to catch
> -	 * the case where we didn't actually read the block properly, which
> -	 * would have !PageUptodate && !PageError, as we clear PageError before
> -	 * reading.
> +	 * There can be no delalloc past i_size, so don't waste time looking for
> +	 * it beyond i_size.
>   	 */
> -	if (fs_info->nodesize < PAGE_SIZE) {
> -		bool uptodate, error;
> -
> -		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
> -						       eb->start, eb->len);
> -		error = btrfs_subpage_test_error(fs_info, page, eb->start, eb->len);
> -		WARN_ON(!uptodate && !error);
> -	} else {
> -		WARN_ON(!PageUptodate(page) && !PageError(page));
> -	}
> -}
> -
> -void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
> -		const void *srcv)
> -{
> -	char *kaddr;
> -
> -	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr = page_address(eb->pages[0]) +
> -		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
> -						   chunk_tree_uuid));
> -	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> -}
> -
> -void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
> -{
> -	char *kaddr;
> -
> -	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr = page_address(eb->pages[0]) +
> -		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
> -	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> -}
> -
> -void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
> -			 unsigned long start, unsigned long len)
> -{
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	char *src = (char *)srcv;
> -	unsigned long i = get_eb_page_index(start);
> +	while (cur_offset < end && cur_offset < i_size) {
> +		u64 delalloc_start;
> +		u64 delalloc_end;
> +		u64 prealloc_start;
> +		u64 prealloc_len = 0;
> +		bool delalloc;
>   
> -	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
> +		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
> +							delalloc_cached_state,
> +							&delalloc_start,
> +							&delalloc_end);
> +		if (!delalloc)
> +			break;
>   
> -	if (check_eb_range(eb, start, len))
> -		return;
> +		/*
> +		 * If this is a prealloc extent we have to report every section
> +		 * of it that has no delalloc.
> +		 */
> +		if (disk_bytenr != 0) {
> +			if (last_delalloc_end == 0) {
> +				prealloc_start = start;
> +				prealloc_len = delalloc_start - start;
> +			} else {
> +				prealloc_start = last_delalloc_end + 1;
> +				prealloc_len = delalloc_start - prealloc_start;
> +			}
> +		}
>   
> -	offset = get_eb_offset_in_page(eb, start);
> +		if (prealloc_len > 0) {
> +			if (!checked_extent_shared && fieinfo->fi_extents_max) {
> +				ret = btrfs_is_data_extent_shared(inode,
> +								  disk_bytenr,
> +								  extent_gen,
> +								  backref_ctx);
> +				if (ret < 0)
> +					return ret;
> +				else if (ret > 0)
> +					prealloc_flags |= FIEMAP_EXTENT_SHARED;
>   
> -	while (len > 0) {
> -		page = eb->pages[i];
> -		assert_eb_page_uptodate(eb, page);
> +				checked_extent_shared = true;
> +			}
> +			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
> +						 disk_bytenr + extent_offset,
> +						 prealloc_len, prealloc_flags);
> +			if (ret)
> +				return ret;
> +			extent_offset += prealloc_len;
> +		}
>   
> -		cur = min(len, PAGE_SIZE - offset);
> -		kaddr = page_address(page);
> -		memcpy(kaddr + offset, src, cur);
> +		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
> +					 delalloc_end + 1 - delalloc_start,
> +					 FIEMAP_EXTENT_DELALLOC |
> +					 FIEMAP_EXTENT_UNKNOWN);
> +		if (ret)
> +			return ret;
>   
> -		src += cur;
> -		len -= cur;
> -		offset = 0;
> -		i++;
> +		last_delalloc_end = delalloc_end;
> +		cur_offset = delalloc_end + 1;
> +		extent_offset += cur_offset - delalloc_start;
> +		cond_resched();
>   	}
> -}
> -
> -void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
> -		unsigned long len)
> -{
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	unsigned long i = get_eb_page_index(start);
> -
> -	if (check_eb_range(eb, start, len))
> -		return;
>   
> -	offset = get_eb_offset_in_page(eb, start);
> -
> -	while (len > 0) {
> -		page = eb->pages[i];
> -		assert_eb_page_uptodate(eb, page);
> +	/*
> +	 * Either we found no delalloc for the whole prealloc extent or we have
> +	 * a prealloc extent that spans i_size or starts at or after i_size.
> +	 */
> +	if (disk_bytenr != 0 && last_delalloc_end < end) {
> +		u64 prealloc_start;
> +		u64 prealloc_len;
>   
> -		cur = min(len, PAGE_SIZE - offset);
> -		kaddr = page_address(page);
> -		memset(kaddr + offset, 0, cur);
> +		if (last_delalloc_end == 0) {
> +			prealloc_start = start;
> +			prealloc_len = end + 1 - start;
> +		} else {
> +			prealloc_start = last_delalloc_end + 1;
> +			prealloc_len = end + 1 - prealloc_start;
> +		}
>   
> -		len -= cur;
> -		offset = 0;
> -		i++;
> +		if (!checked_extent_shared && fieinfo->fi_extents_max) {
> +			ret = btrfs_is_data_extent_shared(inode,
> +							  disk_bytenr,
> +							  extent_gen,
> +							  backref_ctx);
> +			if (ret < 0)
> +				return ret;
> +			else if (ret > 0)
> +				prealloc_flags |= FIEMAP_EXTENT_SHARED;
> +		}
> +		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
> +					 disk_bytenr + extent_offset,
> +					 prealloc_len, prealloc_flags);
> +		if (ret)
> +			return ret;
>   	}
> -}
> -
> -void copy_extent_buffer_full(const struct extent_buffer *dst,
> -			     const struct extent_buffer *src)
> -{
> -	int i;
> -	int num_pages;
> -
> -	ASSERT(dst->len == src->len);
> -
> -	if (dst->fs_info->nodesize >= PAGE_SIZE) {
> -		num_pages = num_extent_pages(dst);
> -		for (i = 0; i < num_pages; i++)
> -			copy_page(page_address(dst->pages[i]),
> -				  page_address(src->pages[i]));
> -	} else {
> -		size_t src_offset = get_eb_offset_in_page(src, 0);
> -		size_t dst_offset = get_eb_offset_in_page(dst, 0);
>   
> -		ASSERT(src->fs_info->nodesize < PAGE_SIZE);
> -		memcpy(page_address(dst->pages[0]) + dst_offset,
> -		       page_address(src->pages[0]) + src_offset,
> -		       src->len);
> -	}
> +	return 0;
>   }
>   
> -void copy_extent_buffer(const struct extent_buffer *dst,
> -			const struct extent_buffer *src,
> -			unsigned long dst_offset, unsigned long src_offset,
> -			unsigned long len)
> +static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
> +					  struct btrfs_path *path,
> +					  u64 *last_extent_end_ret)
>   {
> -	u64 dst_len = dst->len;
> -	size_t cur;
> -	size_t offset;
> -	struct page *page;
> -	char *kaddr;
> -	unsigned long i = get_eb_page_index(dst_offset);
> -
> -	if (check_eb_range(dst, dst_offset, len) ||
> -	    check_eb_range(src, src_offset, len))
> -		return;
> -
> -	WARN_ON(src->len != dst_len);
> -
> -	offset = get_eb_offset_in_page(dst, dst_offset);
> -
> -	while (len > 0) {
> -		page = dst->pages[i];
> -		assert_eb_page_uptodate(dst, page);
> -
> -		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
> +	const u64 ino = btrfs_ino(inode);
> +	struct btrfs_root *root = inode->root;
> +	struct extent_buffer *leaf;
> +	struct btrfs_file_extent_item *ei;
> +	struct btrfs_key key;
> +	u64 disk_bytenr;
> +	int ret;
>   
> -		kaddr = page_address(page);
> -		read_extent_buffer(src, kaddr + offset, src_offset, cur);
> +	/*
> +	 * Lookup the last file extent. We're not using i_size here because
> +	 * there might be preallocation past i_size.
> +	 */
> +	ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
> +	/* There can't be a file extent item at offset (u64)-1 */
> +	ASSERT(ret != 0);
> +	if (ret < 0)
> +		return ret;
>   
> -		src_offset += cur;
> -		len -= cur;
> -		offset = 0;
> -		i++;
> +	/*
> +	 * For a non-existing key, btrfs_search_slot() always leaves us at a
> +	 * slot > 0, except if the btree is empty, which is impossible because
> +	 * at least it has the inode item for this inode and all the items for
> +	 * the root inode 256.
> +	 */
> +	ASSERT(path->slots[0] > 0);
> +	path->slots[0]--;
> +	leaf = path->nodes[0];
> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
> +		/* No file extent items in the subvolume tree. */
> +		*last_extent_end_ret = 0;
> +		return 0;
>   	}
> -}
> -
> -/*
> - * eb_bitmap_offset() - calculate the page and offset of the byte containing the
> - * given bit number
> - * @eb: the extent buffer
> - * @start: offset of the bitmap item in the extent buffer
> - * @nr: bit number
> - * @page_index: return index of the page in the extent buffer that contains the
> - * given bit number
> - * @page_offset: return offset into the page given by page_index
> - *
> - * This helper hides the ugliness of finding the byte in an extent buffer which
> - * contains a given bit.
> - */
> -static inline void eb_bitmap_offset(const struct extent_buffer *eb,
> -				    unsigned long start, unsigned long nr,
> -				    unsigned long *page_index,
> -				    size_t *page_offset)
> -{
> -	size_t byte_offset = BIT_BYTE(nr);
> -	size_t offset;
>   
>   	/*
> -	 * The byte we want is the offset of the extent buffer + the offset of
> -	 * the bitmap item in the extent buffer + the offset of the byte in the
> -	 * bitmap item.
> +	 * For an inline extent, the disk_bytenr is where inline data starts at,
> +	 * so first check if we have an inline extent item before checking if we
> +	 * have an implicit hole (disk_bytenr == 0).
>   	 */
> -	offset = start + offset_in_page(eb->start) + byte_offset;
> -
> -	*page_index = offset >> PAGE_SHIFT;
> -	*page_offset = offset_in_page(offset);
> -}
> -
> -/*
> - * Determine whether a bit in a bitmap item is set.
> - *
> - * @eb:     the extent buffer
> - * @start:  offset of the bitmap item in the extent buffer
> - * @nr:     bit number to test
> - */
> -int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
> -			   unsigned long nr)
> -{
> -	u8 *kaddr;
> -	struct page *page;
> -	unsigned long i;
> -	size_t offset;
> -
> -	eb_bitmap_offset(eb, start, nr, &i, &offset);
> -	page = eb->pages[i];
> -	assert_eb_page_uptodate(eb, page);
> -	kaddr = page_address(page);
> -	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
> -}
> +	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
> +	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
> +		*last_extent_end_ret = btrfs_file_extent_end(path);
> +		return 0;
> +	}
>   
> -/*
> - * Set an area of a bitmap to 1.
> - *
> - * @eb:     the extent buffer
> - * @start:  offset of the bitmap item in the extent buffer
> - * @pos:    bit number of the first bit
> - * @len:    number of bits to set
> - */
> -void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
> -			      unsigned long pos, unsigned long len)
> -{
> -	u8 *kaddr;
> -	struct page *page;
> -	unsigned long i;
> -	size_t offset;
> -	const unsigned int size = pos + len;
> -	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> -	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
> -
> -	eb_bitmap_offset(eb, start, pos, &i, &offset);
> -	page = eb->pages[i];
> -	assert_eb_page_uptodate(eb, page);
> -	kaddr = page_address(page);
> -
> -	while (len >= bits_to_set) {
> -		kaddr[offset] |= mask_to_set;
> -		len -= bits_to_set;
> -		bits_to_set = BITS_PER_BYTE;
> -		mask_to_set = ~0;
> -		if (++offset >= PAGE_SIZE && len > 0) {
> -			offset = 0;
> -			page = eb->pages[++i];
> -			assert_eb_page_uptodate(eb, page);
> -			kaddr = page_address(page);
> +	/*
> +	 * Find the last file extent item that is not a hole (when NO_HOLES is
> +	 * not enabled). This should take at most 2 iterations in the worst
> +	 * case: we have one hole file extent item at slot 0 of a leaf and
> +	 * another hole file extent item as the last item in the previous leaf.
> +	 * This is because we merge file extent items that represent holes.
> +	 */
> +	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> +	while (disk_bytenr == 0) {
> +		ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (ret > 0) {
> +			/* No file extent items that are not holes. */
> +			*last_extent_end_ret = 0;
> +			return 0;
>   		}
> +		leaf = path->nodes[0];
> +		ei = btrfs_item_ptr(leaf, path->slots[0],
> +				    struct btrfs_file_extent_item);
> +		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
>   	}
> -	if (len) {
> -		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
> -		kaddr[offset] |= mask_to_set;
> -	}
> -}
>   
> +	*last_extent_end_ret = btrfs_file_extent_end(path);
> +	return 0;
> +}
>   
> -/*
> - * Clear an area of a bitmap.
> - *
> - * @eb:     the extent buffer
> - * @start:  offset of the bitmap item in the extent buffer
> - * @pos:    bit number of the first bit
> - * @len:    number of bits to clear
> - */
> -void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
> -				unsigned long start, unsigned long pos,
> -				unsigned long len)
> +int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> +		  u64 start, u64 len)
>   {
> -	u8 *kaddr;
> -	struct page *page;
> -	unsigned long i;
> -	size_t offset;
> -	const unsigned int size = pos + len;
> -	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
> -	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
> -
> -	eb_bitmap_offset(eb, start, pos, &i, &offset);
> -	page = eb->pages[i];
> -	assert_eb_page_uptodate(eb, page);
> -	kaddr = page_address(page);
> -
> -	while (len >= bits_to_clear) {
> -		kaddr[offset] &= ~mask_to_clear;
> -		len -= bits_to_clear;
> -		bits_to_clear = BITS_PER_BYTE;
> -		mask_to_clear = ~0;
> -		if (++offset >= PAGE_SIZE && len > 0) {
> -			offset = 0;
> -			page = eb->pages[++i];
> -			assert_eb_page_uptodate(eb, page);
> -			kaddr = page_address(page);
> -		}
> -	}
> -	if (len) {
> -		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
> -		kaddr[offset] &= ~mask_to_clear;
> +	const u64 ino = btrfs_ino(inode);
> +	struct extent_state *cached_state = NULL;
> +	struct extent_state *delalloc_cached_state = NULL;
> +	struct btrfs_path *path;
> +	struct fiemap_cache cache = { 0 };
> +	struct btrfs_backref_share_check_ctx *backref_ctx;
> +	u64 last_extent_end;
> +	u64 prev_extent_end;
> +	u64 lockstart;
> +	u64 lockend;
> +	bool stopped = false;
> +	int ret;
> +
> +	backref_ctx = btrfs_alloc_backref_share_check_ctx();
> +	path = btrfs_alloc_path();
> +	if (!backref_ctx || !path) {
> +		ret = -ENOMEM;
> +		goto out;
>   	}
> -}
>   
> -static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned long len)
> -{
> -	unsigned long distance = (src > dst) ? src - dst : dst - src;
> -	return distance < len;
> -}
> +	lockstart = round_down(start, inode->root->fs_info->sectorsize);
> +	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
> +	prev_extent_end = lockstart;
>   
> -static void copy_pages(struct page *dst_page, struct page *src_page,
> -		       unsigned long dst_off, unsigned long src_off,
> -		       unsigned long len)
> -{
> -	char *dst_kaddr = page_address(dst_page);
> -	char *src_kaddr;
> -	int must_memmove = 0;
> +	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>   
> -	if (dst_page != src_page) {
> -		src_kaddr = page_address(src_page);
> -	} else {
> -		src_kaddr = dst_kaddr;
> -		if (areas_overlap(src_off, dst_off, len))
> -			must_memmove = 1;
> +	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
> +	if (ret < 0)
> +		goto out_unlock;
> +	btrfs_release_path(path);
> +
> +	path->reada = READA_FORWARD;
> +	ret = fiemap_search_slot(inode, path, lockstart);
> +	if (ret < 0) {
> +		goto out_unlock;
> +	} else if (ret > 0) {
> +		/*
> +		 * No file extent item found, but we may have delalloc between
> +		 * the current offset and i_size. So check for that.
> +		 */
> +		ret = 0;
> +		goto check_eof_delalloc;
>   	}
>   
> -	if (must_memmove)
> -		memmove(dst_kaddr + dst_off, src_kaddr + src_off, len);
> -	else
> -		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
> -}
> +	while (prev_extent_end < lockend) {
> +		struct extent_buffer *leaf = path->nodes[0];
> +		struct btrfs_file_extent_item *ei;
> +		struct btrfs_key key;
> +		u64 extent_end;
> +		u64 extent_len;
> +		u64 extent_offset = 0;
> +		u64 extent_gen;
> +		u64 disk_bytenr = 0;
> +		u64 flags = 0;
> +		int extent_type;
> +		u8 compression;
>   
> -void memcpy_extent_buffer(const struct extent_buffer *dst,
> -			  unsigned long dst_offset, unsigned long src_offset,
> -			  unsigned long len)
> -{
> -	size_t cur;
> -	size_t dst_off_in_page;
> -	size_t src_off_in_page;
> -	unsigned long dst_i;
> -	unsigned long src_i;
> -
> -	if (check_eb_range(dst, dst_offset, len) ||
> -	    check_eb_range(dst, src_offset, len))
> -		return;
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> +			break;
>   
> -	while (len > 0) {
> -		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
> -		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
> +		extent_end = btrfs_file_extent_end(path);
>   
> -		dst_i = get_eb_page_index(dst_offset);
> -		src_i = get_eb_page_index(src_offset);
> +		/*
> +		 * The first iteration can leave us at an extent item that ends
> +		 * before our range's start. Move to the next item.
> +		 */
> +		if (extent_end <= lockstart)
> +			goto next_item;
>   
> -		cur = min(len, (unsigned long)(PAGE_SIZE -
> -					       src_off_in_page));
> -		cur = min_t(unsigned long, cur,
> -			(unsigned long)(PAGE_SIZE - dst_off_in_page));
> +		backref_ctx->curr_leaf_bytenr = leaf->start;
>   
> -		copy_pages(dst->pages[dst_i], dst->pages[src_i],
> -			   dst_off_in_page, src_off_in_page, cur);
> +		/* We have in implicit hole (NO_HOLES feature enabled). */
> +		if (prev_extent_end < key.offset) {
> +			const u64 range_end = min(key.offset, lockend) - 1;
>   
> -		src_offset += cur;
> -		dst_offset += cur;
> -		len -= cur;
> -	}
> -}
> +			ret = fiemap_process_hole(inode, fieinfo, &cache,
> +						  &delalloc_cached_state,
> +						  backref_ctx, 0, 0, 0,
> +						  prev_extent_end, range_end);
> +			if (ret < 0) {
> +				goto out_unlock;
> +			} else if (ret > 0) {
> +				/* fiemap_fill_next_extent() told us to stop. */
> +				stopped = true;
> +				break;
> +			}
>   
> -void memmove_extent_buffer(const struct extent_buffer *dst,
> -			   unsigned long dst_offset, unsigned long src_offset,
> -			   unsigned long len)
> -{
> -	size_t cur;
> -	size_t dst_off_in_page;
> -	size_t src_off_in_page;
> -	unsigned long dst_end = dst_offset + len - 1;
> -	unsigned long src_end = src_offset + len - 1;
> -	unsigned long dst_i;
> -	unsigned long src_i;
> -
> -	if (check_eb_range(dst, dst_offset, len) ||
> -	    check_eb_range(dst, src_offset, len))
> -		return;
> -	if (dst_offset < src_offset) {
> -		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
> -		return;
> -	}
> -	while (len > 0) {
> -		dst_i = get_eb_page_index(dst_end);
> -		src_i = get_eb_page_index(src_end);
> -
> -		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
> -		src_off_in_page = get_eb_offset_in_page(dst, src_end);
> -
> -		cur = min_t(unsigned long, len, src_off_in_page + 1);
> -		cur = min(cur, dst_off_in_page + 1);
> -		copy_pages(dst->pages[dst_i], dst->pages[src_i],
> -			   dst_off_in_page - cur + 1,
> -			   src_off_in_page - cur + 1, cur);
> -
> -		dst_end -= cur;
> -		src_end -= cur;
> -		len -= cur;
> -	}
> -}
> +			/* We've reached the end of the fiemap range, stop. */
> +			if (key.offset >= lockend) {
> +				stopped = true;
> +				break;
> +			}
> +		}
>   
> -#define GANG_LOOKUP_SIZE	16
> -static struct extent_buffer *get_next_extent_buffer(
> -		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
> -{
> -	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> -	struct extent_buffer *found = NULL;
> -	u64 page_start = page_offset(page);
> -	u64 cur = page_start;
> +		extent_len = extent_end - key.offset;
> +		ei = btrfs_item_ptr(leaf, path->slots[0],
> +				    struct btrfs_file_extent_item);
> +		compression = btrfs_file_extent_compression(leaf, ei);
> +		extent_type = btrfs_file_extent_type(leaf, ei);
> +		extent_gen = btrfs_file_extent_generation(leaf, ei);
>   
> -	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> -	lockdep_assert_held(&fs_info->buffer_lock);
> +		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
> +			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> +			if (compression == BTRFS_COMPRESS_NONE)
> +				extent_offset = btrfs_file_extent_offset(leaf, ei);
> +		}
>   
> -	while (cur < page_start + PAGE_SIZE) {
> -		int ret;
> -		int i;
> +		if (compression != BTRFS_COMPRESS_NONE)
> +			flags |= FIEMAP_EXTENT_ENCODED;
>   
> -		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> -				(void **)gang, cur >> fs_info->sectorsize_bits,
> -				min_t(unsigned int, GANG_LOOKUP_SIZE,
> -				      PAGE_SIZE / fs_info->nodesize));
> -		if (ret == 0)
> -			goto out;
> -		for (i = 0; i < ret; i++) {
> -			/* Already beyond page end */
> -			if (gang[i]->start >= page_start + PAGE_SIZE)
> -				goto out;
> -			/* Found one */
> -			if (gang[i]->start >= bytenr) {
> -				found = gang[i];
> -				goto out;
> +		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> +			flags |= FIEMAP_EXTENT_DATA_INLINE;
> +			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
> +			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
> +						 extent_len, flags);
> +		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
> +			ret = fiemap_process_hole(inode, fieinfo, &cache,
> +						  &delalloc_cached_state,
> +						  backref_ctx,
> +						  disk_bytenr, extent_offset,
> +						  extent_gen, key.offset,
> +						  extent_end - 1);
> +		} else if (disk_bytenr == 0) {
> +			/* We have an explicit hole. */
> +			ret = fiemap_process_hole(inode, fieinfo, &cache,
> +						  &delalloc_cached_state,
> +						  backref_ctx, 0, 0, 0,
> +						  key.offset, extent_end - 1);
> +		} else {
> +			/* We have a regular extent. */
> +			if (fieinfo->fi_extents_max) {
> +				ret = btrfs_is_data_extent_shared(inode,
> +								  disk_bytenr,
> +								  extent_gen,
> +								  backref_ctx);
> +				if (ret < 0)
> +					goto out_unlock;
> +				else if (ret > 0)
> +					flags |= FIEMAP_EXTENT_SHARED;
>   			}
> -		}
> -		cur = gang[ret - 1]->start + gang[ret - 1]->len;
> -	}
> -out:
> -	return found;
> -}
> -
> -static int try_release_subpage_extent_buffer(struct page *page)
> -{
> -	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> -	u64 cur = page_offset(page);
> -	const u64 end = page_offset(page) + PAGE_SIZE;
> -	int ret;
>   
> -	while (cur < end) {
> -		struct extent_buffer *eb = NULL;
> +			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
> +						 disk_bytenr + extent_offset,
> +						 extent_len, flags);
> +		}
>   
> -		/*
> -		 * Unlike try_release_extent_buffer() which uses page->private
> -		 * to grab buffer, for subpage case we rely on radix tree, thus
> -		 * we need to ensure radix tree consistency.
> -		 *
> -		 * We also want an atomic snapshot of the radix tree, thus go
> -		 * with spinlock rather than RCU.
> -		 */
> -		spin_lock(&fs_info->buffer_lock);
> -		eb = get_next_extent_buffer(fs_info, page, cur);
> -		if (!eb) {
> -			/* No more eb in the page range after or at cur */
> -			spin_unlock(&fs_info->buffer_lock);
> +		if (ret < 0) {
> +			goto out_unlock;
> +		} else if (ret > 0) {
> +			/* fiemap_fill_next_extent() told us to stop. */
> +			stopped = true;
>   			break;
>   		}
> -		cur = eb->start + eb->len;
>   
> -		/*
> -		 * The same as try_release_extent_buffer(), to ensure the eb
> -		 * won't disappear out from under us.
> -		 */
> -		spin_lock(&eb->refs_lock);
> -		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> -			spin_unlock(&eb->refs_lock);
> -			spin_unlock(&fs_info->buffer_lock);
> -			break;
> +		prev_extent_end = extent_end;
> +next_item:
> +		if (fatal_signal_pending(current)) {
> +			ret = -EINTR;
> +			goto out_unlock;
>   		}
> -		spin_unlock(&fs_info->buffer_lock);
>   
> -		/*
> -		 * If tree ref isn't set then we know the ref on this eb is a
> -		 * real ref, so just return, this eb will likely be freed soon
> -		 * anyway.
> -		 */
> -		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
> -			spin_unlock(&eb->refs_lock);
> +		ret = fiemap_next_leaf_item(inode, path);
> +		if (ret < 0) {
> +			goto out_unlock;
> +		} else if (ret > 0) {
> +			/* No more file extent items for this inode. */
>   			break;
>   		}
> -
> -		/*
> -		 * Here we don't care about the return value, we will always
> -		 * check the page private at the end.  And
> -		 * release_extent_buffer() will release the refs_lock.
> -		 */
> -		release_extent_buffer(eb);
> -	}
> -	/*
> -	 * Finally to check if we have cleared page private, as if we have
> -	 * released all ebs in the page, the page private should be cleared now.
> -	 */
> -	spin_lock(&page->mapping->private_lock);
> -	if (!PagePrivate(page))
> -		ret = 1;
> -	else
> -		ret = 0;
> -	spin_unlock(&page->mapping->private_lock);
> -	return ret;
> -
> -}
> -
> -int try_release_extent_buffer(struct page *page)
> -{
> -	struct extent_buffer *eb;
> -
> -	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
> -		return try_release_subpage_extent_buffer(page);
> -
> -	/*
> -	 * We need to make sure nobody is changing page->private, as we rely on
> -	 * page->private as the pointer to extent buffer.
> -	 */
> -	spin_lock(&page->mapping->private_lock);
> -	if (!PagePrivate(page)) {
> -		spin_unlock(&page->mapping->private_lock);
> -		return 1;
> +		cond_resched();
>   	}
>   
> -	eb = (struct extent_buffer *)page->private;
> -	BUG_ON(!eb);
> -
> +check_eof_delalloc:
>   	/*
> -	 * This is a little awful but should be ok, we need to make sure that
> -	 * the eb doesn't disappear out from under us while we're looking at
> -	 * this page.
> +	 * Release (and free) the path before emitting any final entries to
> +	 * fiemap_fill_next_extent() to keep lockdep happy. This is because
> +	 * once we find no more file extent items exist, we may have a
> +	 * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
> +	 * faults when copying data to the user space buffer.
>   	 */
> -	spin_lock(&eb->refs_lock);
> -	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> -		spin_unlock(&eb->refs_lock);
> -		spin_unlock(&page->mapping->private_lock);
> -		return 0;
> -	}
> -	spin_unlock(&page->mapping->private_lock);
> +	btrfs_free_path(path);
> +	path = NULL;
>   
> -	/*
> -	 * If tree ref isn't set then we know the ref on this eb is a real ref,
> -	 * so just return, this page will likely be freed soon anyway.
> -	 */
> -	if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
> -		spin_unlock(&eb->refs_lock);
> -		return 0;
> +	if (!stopped && prev_extent_end < lockend) {
> +		ret = fiemap_process_hole(inode, fieinfo, &cache,
> +					  &delalloc_cached_state, backref_ctx,
> +					  0, 0, 0, prev_extent_end, lockend - 1);
> +		if (ret < 0)
> +			goto out_unlock;
> +		prev_extent_end = lockend;
>   	}
>   
> -	return release_extent_buffer(eb);
> -}
> -
> -/*
> - * btrfs_readahead_tree_block - attempt to readahead a child block
> - * @fs_info:	the fs_info
> - * @bytenr:	bytenr to read
> - * @owner_root: objectid of the root that owns this eb
> - * @gen:	generation for the uptodate check, can be 0
> - * @level:	level for the eb
> - *
> - * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we do a
> - * normal uptodate check of the eb, without checking the generation.  If we have
> - * to read the block we will not block on anything.
> - */
> -void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> -				u64 bytenr, u64 owner_root, u64 gen, int level)
> -{
> -	struct btrfs_tree_parent_check check = {
> -		.has_first_key = 0,
> -		.level = level,
> -		.transid = gen
> -	};
> -	struct extent_buffer *eb;
> -	int ret;
> +	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
> +		const u64 i_size = i_size_read(&inode->vfs_inode);
>   
> -	eb = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
> -	if (IS_ERR(eb))
> -		return;
> +		if (prev_extent_end < i_size) {
> +			u64 delalloc_start;
> +			u64 delalloc_end;
> +			bool delalloc;
>   
> -	if (btrfs_buffer_uptodate(eb, gen, 1)) {
> -		free_extent_buffer(eb);
> -		return;
> +			delalloc = btrfs_find_delalloc_in_range(inode,
> +								prev_extent_end,
> +								i_size - 1,
> +								&delalloc_cached_state,
> +								&delalloc_start,
> +								&delalloc_end);
> +			if (!delalloc)
> +				cache.flags |= FIEMAP_EXTENT_LAST;
> +		} else {
> +			cache.flags |= FIEMAP_EXTENT_LAST;
> +		}
>   	}
>   
> -	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0, &check);
> -	if (ret < 0)
> -		free_extent_buffer_stale(eb);
> -	else
> -		free_extent_buffer(eb);
> -}
> +	ret = emit_last_fiemap_cache(fieinfo, &cache);
>   
> -/*
> - * btrfs_readahead_node_child - readahead a node's child block
> - * @node:	parent node we're reading from
> - * @slot:	slot in the parent node for the child we want to read
> - *
> - * A helper for btrfs_readahead_tree_block, we simply read the bytenr pointed at
> - * the slot in the node provided.
> - */
> -void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
> -{
> -	btrfs_readahead_tree_block(node->fs_info,
> -				   btrfs_node_blockptr(node, slot),
> -				   btrfs_header_owner(node),
> -				   btrfs_node_ptr_generation(node, slot),
> -				   btrfs_header_level(node) - 1);
> +out_unlock:
> +	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
> +out:
> +	free_extent_state(delalloc_cached_state);
> +	btrfs_free_backref_share_ctx(backref_ctx);
> +	btrfs_free_path(path);
> +	return ret;
>   }
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index a2c82448b2e076..9420ffb36ae691 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -10,6 +10,7 @@
>   #include "compression.h"
>   #include "ulist.h"
>   #include "misc.h"
> +#include "bio.h"
>   
>   enum {
>   	EXTENT_BUFFER_UPTODATE,
> @@ -322,4 +323,44 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
>   #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
>   #endif
>   
> +/*
> + * Structure to record info about the bio being assembled, and other info like
> + * how many bytes are there before stripe/ordered extent boundary.
> + */
> +struct btrfs_bio_ctrl {
> +	struct bio *bio;
> +	int mirror_num;
> +	enum btrfs_compression_type compress_type;
> +	u32 len_to_stripe_boundary;
> +	u32 len_to_oe_boundary;
> +	btrfs_bio_end_io_t end_io_func;
> +
> +	/*
> +	 * This is for metadata read, to provide the extra needed verification
> +	 * info.  This has to be provided for submit_one_bio(), as
> +	 * submit_one_bio() can submit a bio if it ends at stripe boundary.  If
> +	 * no such parent_check is provided, the metadata can hit false alert at
> +	 * endio time.
> +	 */
> +	struct btrfs_tree_parent_check *parent_check;
> +
> +	/*
> +	 * Tell writepage not to lock the state bits for this range, it still
> +	 * does the unlocking.
> +	 */
> +	bool extent_locked;
> +
> +	/* Tell the submit_bio code to use REQ_SYNC */
> +	bool sync_io;
> +};
> +
> +void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl);
> +void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret);
> +void end_bio_extent_readpage(struct btrfs_bio *bbio);
> +int submit_extent_page(blk_opf_t opf, struct writeback_control *wbc,
> +		       struct btrfs_bio_ctrl *bio_ctrl, u64 disk_bytenr,
> +		       struct page *page, size_t size, unsigned long pg_offset,
> +		       enum btrfs_compression_type compress_type,
> +		       bool force_bio_submit);
> +
>   #endif
