Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33095599AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiFXMaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXMaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 08:30:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE14BFE8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656073805;
        bh=qKSehZ5kaW09vJZPh0kjXq7d/xliCvoPNsaAxcAudFo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=flJ/cTzEbWI3/jhZtZviuzG+0Y+eC0mqYKuyfE5lBj6HQ7xjxge09TnPlNhIJU6+D
         OOxUnqmx9QQA4RMQvJEqQk1djOPNb1Aj9HCfiNkl0fj1LO1ukEvHlwtoGvgdDRhHyS
         7HSOFr8J0ulA9QjKP0ZDD7wg08d4po12UQW4dHmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1oL0NV2FGv-00J4Tz; Fri, 24
 Jun 2022 14:30:05 +0200
Message-ID: <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
Date:   Fri, 24 Jun 2022 20:30:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
In-Reply-To: <20220624122334.80603-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hDbfoK81tPPrmnAi5//08lGiEcW59Wwze+/VgcZLFQU9GEqGhQr
 Bq3OshzdpyhqYs3R5xHoaxD4hVfkRdVZwGuqAzNKOZqQy07/5sRUW1ukKxNkLWAC4tRW85y
 9qWgUtN9fxOJxX3bwcUbcNABUl3MmZ+a1UKwy/KogpDs8r2aVvwsYaPonGh8aNjz2FCltfb
 pVNvJHadERDluR1ZtKZcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:13RUG5YezPo=:ztstZNTdOfmrHQwsGJNbbg
 EJ36VePvlyI1WYMpi9FL++xN+dqnkoPiShiJokYb86mpV/coxRiUddqxHixb6Enyz6NFmnO8r
 RwxLvtlo34cN9IKf4BDX/sw7iIdkYr9H3cwgkDweicchFK3yQL3E5jFkbh6bV5Rk+4nIEK4I1
 c5NIlaftMbVzTEX+A/oDTGxtUhHcAXQUNs5INwjBh9s5s0ED6Z5bvi2H3tL3nkgNb7MZsmMQ5
 t4mJtkIqqvGjWV6mzA1lHu/EFmRX6zhp2NnwFhqRZQdhVsk7Rg3td7YDmJevaZNhp8+YtZpG/
 35j+S1mQorTvZ6C/K1H4gcT/CrEUAVOL8gwggxphbuPu+zkcu1nVFECwD/JzY6Qjaclv2qCB2
 my67IDKidLtU46Pn8Axf0hq7ki2SB+5aQyt2ZvH+2azbdjMeeY/2jppG46RVZ8PG41qYMGRea
 K7AuxsfLf/pAgTt7yctqO/+NMimm9CeKUdfQBo5BolvmkJyqJ5RYBP7A0pmYeGXNV9sSEMDmB
 badiOBeBTo6bdaspVsQIaYjVF5gIl6LJiuwl1dmD2h0/X67a4phEuQn7DkEHcFvzI2ND77Dse
 n0jsj3LIv8IA6AN5rjb7CHUFvxHVAcCfiKRwF834Z+AZ8z5yHiutL3PuEQv6CQiJxSwfU6ox/
 n2YAn35kCHhyqgE13VjYGNAToh8YGtvt3Xh1wat38CSg2izCCP/541PISGZ8He0jZm00fq+3+
 an+0raOyxSoGwclUr9CxGDa3U3QtoL8VI1//PeRE6EZFzN0yVGnueKeeX868h23iT/LJW1xc5
 WyhZhYNQ6VLJH5EBMv32aurF41tkER6yr/OGEEdxjbmS4cZkZ5NCa7T4dqYSi38ahowW78ox0
 Dx2XJSxnSkP8ncJNVOkFMbcPicFP4u0oBN3gRxYl/G0IYKklfG5gIPI8JwztSRFd5JjamxfUo
 fPbv8KNHDh1fhcU2Z8i2uD/9PeWgb9HIA8hbB8qKMEJCfauzbj3V2HA+rJIK+QcFbu9uFZqXe
 y1W99MwoN1aHm0k/VLQI74Z61IPHRmtLYIAsw2Rf3mU0TgRWtl3yqaEH4Xl4Z00C6emDc4veN
 flr8m+V/G8yy3Rcyoh3+/Uad/pqvBA/1BdtkDMfb4sbgVuMXtb4r1obGw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 20:23, Christoph Hellwig wrote:
> Since the page_mkwrite address space operation was added, starting with
> commit 9637a5efd4fb ("[PATCH] add page_mkwrite() vm_operations method")
> in 2006, the kernel does not just dirty random pages without telling
> the file system.  Remove the code to handles this now impossible case
> and replace it with a WARN_ON_ONCE.

I'm super happy to remove that.

In fact, if we can get that removed, we can also remove the
PageOrdered() related code, which takes extra space for subpage support.


But from my previous feedback on subpage code, it looks like it's some
hardware archs (S390?) that can not do page flags update atomically.

I have tested similar thing, with extra ASSERT() to make sure the cow
fixup code never get triggered.

At least for x86_64 and aarch64 it's OK here.

So I hope this time we can get a concrete reason on why we need the
extra page Private2 bit in the first place.

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/ctree.h     |   8 --
>   fs/btrfs/disk-io.c   |   6 +-
>   fs/btrfs/extent_io.c |   9 +--
>   fs/btrfs/inode.c     | 188 -------------------------------------------
>   4 files changed, 3 insertions(+), 208 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 12f59e35755fa..39a1235eda48b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -882,13 +882,6 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *endio_write_workers;
>   	struct btrfs_workqueue *endio_freespace_worker;
>   	struct btrfs_workqueue *caching_workers;
> -
> -	/*
> -	 * fixup workers take dirty pages that didn't properly go through
> -	 * the cow mechanism and make them safe to write.  It happens
> -	 * for the sys_munmap function call path
> -	 */
> -	struct btrfs_workqueue *fixup_workers;
>   	struct btrfs_workqueue *delayed_workers;
>
>   	struct task_struct *transaction_kthread;
> @@ -3390,7 +3383,6 @@ int btrfs_prealloc_file_range_trans(struct inode *=
inode,
>   int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *l=
ocked_page,
>   		u64 start, u64 end, int *page_started, unsigned long *nr_written,
>   		struct writeback_control *wbc);
> -int btrfs_writepage_cow_fixup(struct page *page);
>   void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>   					  struct page *page, u64 start,
>   					  u64 end, bool uptodate);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 71d92f5dfcb2e..bf908e178ee59 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2163,7 +2163,6 @@ static int read_backup_root(struct btrfs_fs_info *=
fs_info, u8 priority)
>   /* helper to cleanup workers */
>   static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   {
> -	btrfs_destroy_workqueue(fs_info->fixup_workers);
>   	btrfs_destroy_workqueue(fs_info->delalloc_workers);
>   	btrfs_destroy_workqueue(fs_info->hipri_workers);
>   	btrfs_destroy_workqueue(fs_info->workers);
> @@ -2358,9 +2357,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_i=
nfo *fs_info)
>   	fs_info->caching_workers =3D
>   		btrfs_alloc_workqueue(fs_info, "cache", flags, max_active, 0);
>
> -	fs_info->fixup_workers =3D
> -		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
> -
>   	fs_info->endio_workers =3D
>   		alloc_workqueue("btrfs-endio", flags, max_active);
>   	fs_info->endio_meta_workers =3D
> @@ -2390,7 +2386,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_i=
nfo *fs_info)
>   	      fs_info->compressed_write_workers &&
>   	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &=
&
>   	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
> -	      fs_info->caching_workers && fs_info->fixup_workers &&
> +	      fs_info->caching_workers &&
>   	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
>   	      fs_info->discard_ctl.discard_workers)) {
>   		return -ENOMEM;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 587d2ba20b53b..232a858b99a0a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3944,13 +3944,8 @@ static noinline_for_stack int __extent_writepage_=
io(struct btrfs_inode *inode,
>   	bool has_error =3D false;
>   	bool compressed;
>
> -	ret =3D btrfs_writepage_cow_fixup(page);
> -	if (ret) {
> -		/* Fixup worker will requeue */
> -		redirty_page_for_writepage(wbc, page);
> -		unlock_page(page);
> -		return 1;
> -	}
> +	if (WARN_ON_ONCE(!PageOrdered(page)))
> +		return -EIO;
>
>   	/*
>   	 * we don't want to touch the inode after unlocking the page,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index eea351216db33..5cf314a1b5d17 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2815,194 +2815,6 @@ int btrfs_set_extent_delalloc(struct btrfs_inode=
 *inode, u64 start, u64 end,
>   				   cached_state);
>   }
>
> -/* see btrfs_writepage_start_hook for details on why this is required *=
/
> -struct btrfs_writepage_fixup {
> -	struct page *page;
> -	struct inode *inode;
> -	struct btrfs_work work;
> -};
> -
> -static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
> -{
> -	struct btrfs_writepage_fixup *fixup;
> -	struct btrfs_ordered_extent *ordered;
> -	struct extent_state *cached_state =3D NULL;
> -	struct extent_changeset *data_reserved =3D NULL;
> -	struct page *page;
> -	struct btrfs_inode *inode;
> -	u64 page_start;
> -	u64 page_end;
> -	int ret =3D 0;
> -	bool free_delalloc_space =3D true;
> -
> -	fixup =3D container_of(work, struct btrfs_writepage_fixup, work);
> -	page =3D fixup->page;
> -	inode =3D BTRFS_I(fixup->inode);
> -	page_start =3D page_offset(page);
> -	page_end =3D page_offset(page) + PAGE_SIZE - 1;
> -
> -	/*
> -	 * This is similar to page_mkwrite, we need to reserve the space befor=
e
> -	 * we take the page lock.
> -	 */
> -	ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, page_start=
,
> -					   PAGE_SIZE);
> -again:
> -	lock_page(page);
> -
> -	/*
> -	 * Before we queued this fixup, we took a reference on the page.
> -	 * page->mapping may go NULL, but it shouldn't be moved to a different
> -	 * address space.
> -	 */
> -	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
> -		/*
> -		 * Unfortunately this is a little tricky, either
> -		 *
> -		 * 1) We got here and our page had already been dealt with and
> -		 *    we reserved our space, thus ret =3D=3D 0, so we need to just
> -		 *    drop our space reservation and bail.  This can happen the
> -		 *    first time we come into the fixup worker, or could happen
> -		 *    while waiting for the ordered extent.
> -		 * 2) Our page was already dealt with, but we happened to get an
> -		 *    ENOSPC above from the btrfs_delalloc_reserve_space.  In
> -		 *    this case we obviously don't have anything to release, but
> -		 *    because the page was already dealt with we don't want to
> -		 *    mark the page with an error, so make sure we're resetting
> -		 *    ret to 0.  This is why we have this check _before_ the ret
> -		 *    check, because we do not want to have a surprise ENOSPC
> -		 *    when the page was already properly dealt with.
> -		 */
> -		if (!ret) {
> -			btrfs_delalloc_release_extents(inode, PAGE_SIZE);
> -			btrfs_delalloc_release_space(inode, data_reserved,
> -						     page_start, PAGE_SIZE,
> -						     true);
> -		}
> -		ret =3D 0;
> -		goto out_page;
> -	}
> -
> -	/*
> -	 * We can't mess with the page state unless it is locked, so now that
> -	 * it is locked bail if we failed to make our space reservation.
> -	 */
> -	if (ret)
> -		goto out_page;
> -
> -	lock_extent_bits(&inode->io_tree, page_start, page_end, &cached_state)=
;
> -
> -	/* already ordered? We're done */
> -	if (PageOrdered(page))
> -		goto out_reserved;
> -
> -	ordered =3D btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
> -	if (ordered) {
> -		unlock_extent_cached(&inode->io_tree, page_start, page_end,
> -				     &cached_state);
> -		unlock_page(page);
> -		btrfs_start_ordered_extent(ordered, 1);
> -		btrfs_put_ordered_extent(ordered);
> -		goto again;
> -	}
> -
> -	ret =3D btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
> -					&cached_state);
> -	if (ret)
> -		goto out_reserved;
> -
> -	/*
> -	 * Everything went as planned, we're now the owner of a dirty page wit=
h
> -	 * delayed allocation bits set and space reserved for our COW
> -	 * destination.
> -	 *
> -	 * The page was dirty when we started, nothing should have cleaned it.
> -	 */
> -	BUG_ON(!PageDirty(page));
> -	free_delalloc_space =3D false;
> -out_reserved:
> -	btrfs_delalloc_release_extents(inode, PAGE_SIZE);
> -	if (free_delalloc_space)
> -		btrfs_delalloc_release_space(inode, data_reserved, page_start,
> -					     PAGE_SIZE, true);
> -	unlock_extent_cached(&inode->io_tree, page_start, page_end,
> -			     &cached_state);
> -out_page:
> -	if (ret) {
> -		/*
> -		 * We hit ENOSPC or other errors.  Update the mapping and page
> -		 * to reflect the errors and clean the page.
> -		 */
> -		mapping_set_error(page->mapping, ret);
> -		end_extent_writepage(page, ret, page_start, page_end);
> -		clear_page_dirty_for_io(page);
> -		SetPageError(page);
> -	}
> -	btrfs_page_clear_checked(inode->root->fs_info, page, page_start, PAGE_=
SIZE);
> -	unlock_page(page);
> -	put_page(page);
> -	kfree(fixup);
> -	extent_changeset_free(data_reserved);
> -	/*
> -	 * As a precaution, do a delayed iput in case it would be the last ipu=
t
> -	 * that could need flushing space. Recursing back to fixup worker woul=
d
> -	 * deadlock.
> -	 */
> -	btrfs_add_delayed_iput(&inode->vfs_inode);
> -}
> -
> -/*
> - * There are a few paths in the higher layers of the kernel that direct=
ly
> - * set the page dirty bit without asking the filesystem if it is a
> - * good idea.  This causes problems because we want to make sure COW
> - * properly happens and the data=3Dordered rules are followed.
> - *
> - * In our case any range that doesn't have the ORDERED bit set
> - * hasn't been properly setup for IO.  We kick off an async process
> - * to fix it up.  The async helper will wait for ordered extents, set
> - * the delalloc bit and make it safe to write the page.
> - */
> -int btrfs_writepage_cow_fixup(struct page *page)
> -{
> -	struct inode *inode =3D page->mapping->host;
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	struct btrfs_writepage_fixup *fixup;
> -
> -	/* This page has ordered extent covering it already */
> -	if (PageOrdered(page))
> -		return 0;
> -
> -	/*
> -	 * PageChecked is set below when we create a fixup worker for this pag=
e,
> -	 * don't try to create another one if we're already PageChecked()
> -	 *
> -	 * The extent_io writepage code will redirty the page if we send back
> -	 * EAGAIN.
> -	 */
> -	if (PageChecked(page))
> -		return -EAGAIN;
> -
> -	fixup =3D kzalloc(sizeof(*fixup), GFP_NOFS);
> -	if (!fixup)
> -		return -EAGAIN;
> -
> -	/*
> -	 * We are already holding a reference to this inode from
> -	 * write_cache_pages.  We need to hold it because the space reservatio=
n
> -	 * takes place outside of the page lock, and we can't trust
> -	 * page->mapping outside of the page lock.
> -	 */
> -	ihold(inode);
> -	btrfs_page_set_checked(fs_info, page, page_offset(page), PAGE_SIZE);
> -	get_page(page);
> -	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL=
);
> -	fixup->page =3D page;
> -	fixup->inode =3D inode;
> -	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
> -
> -	return -EAGAIN;
> -}
> -
>   static int insert_reserved_file_extent(struct btrfs_trans_handle *tran=
s,
>   				       struct btrfs_inode *inode, u64 file_pos,
>   				       struct btrfs_file_extent_item *stack_fi,
