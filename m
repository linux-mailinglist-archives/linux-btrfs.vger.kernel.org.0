Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62E64574
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGJKyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 06:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbfGJKyw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 06:54:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54509AC2C;
        Wed, 10 Jul 2019 10:54:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BB8481E43B7; Wed, 10 Jul 2019 12:54:48 +0200 (CEST)
Date:   Wed, 10 Jul 2019 12:54:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/5] blkcg, writeback: Rename wbc_account_io() to
 wbc_account_cgroup_owner()
Message-ID: <20190710105448.GA9171@quack2.suse.cz>
References: <20190627203952.386785-1-tj@kernel.org>
 <20190627203952.386785-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627203952.386785-3-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 27-06-19 13:39:49, Tejun Heo wrote:
> wbc_account_io() does a very specific job - try to see which cgroup is
> actually dirtying an inode and transfer its ownership to the majority
> dirtier if needed.  The name is too generic and confusing.  Let's
> rename it to something more specific.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  fs/btrfs/extent_io.c                    | 4 ++--
>  fs/buffer.c                             | 2 +-
>  fs/ext4/page-io.c                       | 2 +-
>  fs/f2fs/data.c                          | 4 ++--
>  fs/fs-writeback.c                       | 8 ++++----
>  fs/mpage.c                              | 2 +-
>  include/linux/writeback.h               | 8 ++++----
>  8 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index cf88c1f98270..356a7a3dcb2f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2108,7 +2108,7 @@ following two functions.
>  	a queue (device) has been associated with the bio and
>  	before submission.
>  
> -  wbc_account_io(@wbc, @page, @bytes)
> +  wbc_account_cgroup_owner(@wbc, @page, @bytes)
>  	Should be called for each data segment being written out.
>  	While this function doesn't care exactly when it's called
>  	during the writeback session, it's the easiest and most
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index db337e53aab3..5106008f5e28 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2911,7 +2911,7 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
>  			bio = NULL;
>  		} else {
>  			if (wbc)
> -				wbc_account_io(wbc, page, page_size);
> +				wbc_account_cgroup_owner(wbc, page, page_size);
>  			return 0;
>  		}
>  	}
> @@ -2924,7 +2924,7 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
>  	bio->bi_opf = opf;
>  	if (wbc) {
>  		wbc_init_bio(wbc, bio);
> -		wbc_account_io(wbc, page, page_size);
> +		wbc_account_cgroup_owner(wbc, page, page_size);
>  	}
>  
>  	*bio_ret = bio;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e450c55f6434..40547bbbea94 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3093,7 +3093,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  
>  	if (wbc) {
>  		wbc_init_bio(wbc, bio);
> -		wbc_account_io(wbc, bh->b_page, bh->b_size);
> +		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
>  	}
>  
>  	submit_bio(bio);
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 4690618a92e9..56e287f5ee50 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -404,7 +404,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
>  	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
>  	if (ret != bh->b_size)
>  		goto submit_and_retry;
> -	wbc_account_io(io->io_wbc, page, bh->b_size);
> +	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
>  	io->io_next_block++;
>  	return 0;
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index eda4181d2092..e1cab1717ac7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -470,7 +470,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	}
>  
>  	if (fio->io_wbc && !is_read_io(fio->op))
> -		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
> +		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);
>  
>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
>  
> @@ -537,7 +537,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	}
>  
>  	if (fio->io_wbc)
> -		wbc_account_io(fio->io_wbc, bio_page, PAGE_SIZE);
> +		wbc_account_cgroup_owner(fio->io_wbc, bio_page, PAGE_SIZE);
>  
>  	io->last_block_in_bio = fio->new_blkaddr;
>  	f2fs_trace_ios(fio, 0);
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a8a40bc26c2f..0aef79e934bb 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -706,7 +706,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
>  EXPORT_SYMBOL_GPL(wbc_detach_inode);
>  
>  /**
> - * wbc_account_io - account IO issued during writeback
> + * wbc_account_cgroup_owner - account writeback to update inode cgroup ownership
>   * @wbc: writeback_control of the writeback in progress
>   * @page: page being written out
>   * @bytes: number of bytes being written out
> @@ -715,8 +715,8 @@ EXPORT_SYMBOL_GPL(wbc_detach_inode);
>   * controlled by @wbc.  Keep the book for foreign inode detection.  See
>   * wbc_detach_inode().
>   */
> -void wbc_account_io(struct writeback_control *wbc, struct page *page,
> -		    size_t bytes)
> +void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
> +			      size_t bytes)
>  {
>  	struct cgroup_subsys_state *css;
>  	int id;
> @@ -753,7 +753,7 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
>  	else
>  		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
>  }
> -EXPORT_SYMBOL_GPL(wbc_account_io);
> +EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
>  
>  /**
>   * inode_congested - test whether an inode is congested
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 436a85260394..a63620cdb73a 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -647,7 +647,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>  	 * the confused fail path above (OOM) will be very confused when
>  	 * it finds all bh marked clean (i.e. it will not write anything)
>  	 */
> -	wbc_account_io(wbc, page, PAGE_SIZE);
> +	wbc_account_cgroup_owner(wbc, page, PAGE_SIZE);
>  	length = first_unmapped << blkbits;
>  	if (bio_add_page(bio, page, length, 0) < length) {
>  		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 738a0c24874f..dda5cf228172 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -188,8 +188,8 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  				 struct inode *inode)
>  	__releases(&inode->i_lock);
>  void wbc_detach_inode(struct writeback_control *wbc);
> -void wbc_account_io(struct writeback_control *wbc, struct page *page,
> -		    size_t bytes);
> +void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
> +			      size_t bytes);
>  void cgroup_writeback_umount(void);
>  
>  /**
> @@ -291,8 +291,8 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
>  {
>  }
>  
> -static inline void wbc_account_io(struct writeback_control *wbc,
> -				  struct page *page, size_t bytes)
> +static inline void wbc_account_cgroup_owner(struct writeback_control *wbc,
> +					    struct page *page, size_t bytes)
>  {
>  }
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
