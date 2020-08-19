Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2691524990D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHSJJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHSJJt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 05:09:49 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD2C061342
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 02:09:49 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x187so4952488vkc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=B6yLdUqMCaeK2G7AjR8G+o/r7rmZUMRp9i/ep4oHl/0=;
        b=UqDy1baeJyGR+HIus6OW4i2fp1r1P7ezkOZJtZUKvGFZDplTLv3oReguGcz6fcVyxu
         Aycl9Vu2GuJeYufpkazk1TQFGNo3UU7/FzSZBQx9/tRpdDnT7wStW3v+aKCQ7Ojy7FBR
         DKnXgOjsmsS/fzi+mYcZgUSaDQMXtAQcs8q2eH68kqPZsgi8Vdqe0jBGfLctJkU95PR8
         WpC9aib4sLBLcu6ol7KvYKRGVTf9P56Cl1hLlwDZxE1oF5eiAO0ruIQodJgI+8KRAgH9
         K3kEHAU97KMFQN8zWlgwvKZIV2dnAfORICyY3QL0vE+JCVcN9V4TnrqvkqyHlk4igYiq
         oq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=B6yLdUqMCaeK2G7AjR8G+o/r7rmZUMRp9i/ep4oHl/0=;
        b=hZF/fcB1lChSc//Zz1xZuStzZA7+s+xbI/wNfOWJBA0upzqUjlpELN6hOJuZ7l/8Vk
         zj7qqKUus/kNfkr5DFO3z2mQLtRNtGzGskZIsy3BvdX/MTJxRU9ClaFxsrfombNTsp65
         cr3RFm+T8OHxQnxbm77UZj7hW+Axt8Zy6oDblkw48YQcbB1uOc871s+CUqhOUfgkGt+j
         +Fw/q9qyIoKUsR92hUHhmUTytdVK8x8+dvcngrQJR25zpsyVC7aqzU3RixOD4p5e9ycX
         peEE6Ro/7k+5mlfZ5pJzOjurbM18VH75lMlrg/DcSvcmwsKATIYr9iRiuc/k4zjGjiEe
         T61A==
X-Gm-Message-State: AOAM531KV/rHVze/u3K4xoj6pLTKyz7rqRK5egHWFMWRl1BQyJzM6PhC
        sMxHkJkuR30H8Pr5pcFJCHIbmK4/OuXwrLyRd+52Rc+J
X-Google-Smtp-Source: ABdhPJyYF5s1/b4E06oYldKCPwEDZncZNwAqzLYWsVts6cX9Ikc8NooMDJhcn1PxRsNEk41DjVA3rgPFH8tW41ejxmU=
X-Received: by 2002:a1f:2dd7:: with SMTP id t206mr13705752vkt.13.1597828184588;
 Wed, 19 Aug 2020 02:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200819055344.50784-1-wqu@suse.com>
In-Reply-To: <20200819055344.50784-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 19 Aug 2020 10:09:33 +0100
Message-ID: <CAL3q7H4XU3i2S5Kr5jbPuATM2yFx9Bq1Cs6mmZZdCrMZm9QTuQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: switch btrfs_buffered_write() to page-by-page pace
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 6:55 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Before this patch, btrfs_buffered_write() do page copy in a 8 pages
> batch.
>
> While for EXT4, it uses generic_perform_write() which does page by page
> copy.
>
> This 8 pages batch behavior makes a lot of things more complex:
> - More complex error handling
>   Now we need to handle all errors for half written case.
>
> - More complex advance check
>   Since for 8 pages, we need to consider cases like 4 pages copied.
>   This makes we need to release reserved space for the untouched 4
>   pages.
>
> - More wrappers for multi-pages operations
>   The most obvious one is btrfs_copy_from_user(), which introduces way
>   more complexity than we need.
>
> This patch will change the behavior by going to the page-by-page pace,
> each time we only reserve space for one page, do one page copy.
>
> There are still a lot of complexity remained, mostly for short copy,
> non-uptodate page and extent locking.
> But that's more or less the same as the generic_perform_write().
>
> The performance is the same for 4K block size buffered write, but has an
> obvious impact when using multiple pages siuzed block size:
>
> The test involves writing a 128MiB file, which is smaller than 1/8th of
> the system memory.
>                 Speed (MiB/sec)         Ops (ops/sec)
> Unpatched:      931.498                 14903.9756
> Patched:        447.606                 7161.6806
>
> In fact, if we account the execution time of btrfs_buffered_write(),
> meta/data rsv and later page dirty takes way more time than memory copy:
>
> Patched:
>  nr_runs          =3D 32768
>  total_prepare_ns =3D 66908022
>  total_copy_ns    =3D 75532103
>  total_cleanup_ns =3D 135749090
>
> Unpatched:
>  nr_runs          =3D 2176
>  total_prepare_ns =3D 7425773
>  total_copy_ns    =3D 87780898
>  total_cleanup_ns =3D 37704811
>
> The patched behavior is now similar to EXT4, the buffered write remain
> mostly unchanged for from 4K blocksize and larger.
>
> On the other hand, XFS uses iomap, which supports multi-page reserve and
> copy, leading to similar performance of unpatched btrfs.
>
> It looks like that we'd better go iomap routine other than the
> generic_perform_write().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> The performance drop is enough for this patch to be discarded.

More than enough, a nearly 50% drop of performance for a very common operat=
ion.
I can't even understand why you bothered proposing it.

Thanks.

> ---
>  fs/btrfs/file.c | 293 ++++++++++++------------------------------------
>  1 file changed, 72 insertions(+), 221 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index bbfc8819cf28..be595da9bc05 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -379,60 +379,6 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs=
_info)
>         return 0;
>  }
>
> -/* simple helper to fault in pages and copy.  This should go away
> - * and be replaced with calls into generic code.
> - */
> -static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
> -                                        struct page **prepared_pages,
> -                                        struct iov_iter *i)
> -{
> -       size_t copied =3D 0;
> -       size_t total_copied =3D 0;
> -       int pg =3D 0;
> -       int offset =3D offset_in_page(pos);
> -
> -       while (write_bytes > 0) {
> -               size_t count =3D min_t(size_t,
> -                                    PAGE_SIZE - offset, write_bytes);
> -               struct page *page =3D prepared_pages[pg];
> -               /*
> -                * Copy data from userspace to the current page
> -                */
> -               copied =3D iov_iter_copy_from_user_atomic(page, i, offset=
, count);
> -
> -               /* Flush processor's dcache for this page */
> -               flush_dcache_page(page);
> -
> -               /*
> -                * if we get a partial write, we can end up with
> -                * partially up to date pages.  These add
> -                * a lot of complexity, so make sure they don't
> -                * happen by forcing this copy to be retried.
> -                *
> -                * The rest of the btrfs_file_write code will fall
> -                * back to page at a time copies after we return 0.
> -                */
> -               if (!PageUptodate(page) && copied < count)
> -                       copied =3D 0;
> -
> -               iov_iter_advance(i, copied);
> -               write_bytes -=3D copied;
> -               total_copied +=3D copied;
> -
> -               /* Return to btrfs_file_write_iter to fault page */
> -               if (unlikely(copied =3D=3D 0))
> -                       break;
> -
> -               if (copied < PAGE_SIZE - offset) {
> -                       offset +=3D copied;
> -               } else {
> -                       pg++;
> -                       offset =3D 0;
> -               }
> -       }
> -       return total_copied;
> -}
> -
>  /*
>   * unlocks pages after btrfs_file_write is done with them
>   */
> @@ -443,8 +389,8 @@ static void btrfs_drop_pages(struct page **pages, siz=
e_t num_pages)
>                 /* page checked is some magic around finding pages that
>                  * have been modified without going through btrfs_set_pag=
e_dirty
>                  * clear it here. There should be no need to mark the pag=
es
> -                * accessed as prepare_pages should have marked them acce=
ssed
> -                * in prepare_pages via find_or_create_page()
> +                * accessed as prepare_pages() should have marked them ac=
cessed
> +                * in prepare_pages() via find_or_create_page()
>                  */
>                 ClearPageChecked(pages[i]);
>                 unlock_page(pages[i]);
> @@ -1400,58 +1346,6 @@ static int prepare_uptodate_page(struct inode *ino=
de,
>         return 0;
>  }
>
> -/*
> - * this just gets pages into the page cache and locks them down.
> - */
> -static noinline int prepare_pages(struct inode *inode, struct page **pag=
es,
> -                                 size_t num_pages, loff_t pos,
> -                                 size_t write_bytes, bool force_uptodate=
)
> -{
> -       int i;
> -       unsigned long index =3D pos >> PAGE_SHIFT;
> -       gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
> -       int err =3D 0;
> -       int faili;
> -
> -       for (i =3D 0; i < num_pages; i++) {
> -again:
> -               pages[i] =3D find_or_create_page(inode->i_mapping, index =
+ i,
> -                                              mask | __GFP_WRITE);
> -               if (!pages[i]) {
> -                       faili =3D i - 1;
> -                       err =3D -ENOMEM;
> -                       goto fail;
> -               }
> -
> -               if (i =3D=3D 0)
> -                       err =3D prepare_uptodate_page(inode, pages[i], po=
s,
> -                                                   force_uptodate);
> -               if (!err && i =3D=3D num_pages - 1)
> -                       err =3D prepare_uptodate_page(inode, pages[i],
> -                                                   pos + write_bytes, fa=
lse);
> -               if (err) {
> -                       put_page(pages[i]);
> -                       if (err =3D=3D -EAGAIN) {
> -                               err =3D 0;
> -                               goto again;
> -                       }
> -                       faili =3D i - 1;
> -                       goto fail;
> -               }
> -               wait_on_page_writeback(pages[i]);
> -       }
> -
> -       return 0;
> -fail:
> -       while (faili >=3D 0) {
> -               unlock_page(pages[faili]);
> -               put_page(pages[faili]);
> -               faili--;
> -       }
> -       return err;
> -
> -}
> -
>  /*
>   * This function locks the extent and properly waits for data=3Dordered =
extents
>   * to finish before allowing the pages to be modified if need.
> @@ -1619,6 +1513,38 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *=
inode)
>         btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>  }
>
> +static int prepare_one_page(struct inode *inode, struct page **page_ret,
> +                           loff_t pos, size_t write_bytes, bool force_up=
todate)
> +{
> +       gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping) | __GFP_W=
RITE;
> +       struct page *page;
> +       int ret;
> +
> +again:
> +       page =3D find_or_create_page(inode->i_mapping, pos >> PAGE_SHIFT,=
 mask);
> +       if (!page)
> +               return -ENOMEM;
> +
> +       /*
> +        * We need the page uptodate for the following cases:
> +        * - Write range only covers part of the page
> +        * - We got a short copy on non-uptodate page in previous run
> +        */
> +       if ((!(offset_in_page(pos) =3D=3D 0 && write_bytes =3D=3D PAGE_SI=
ZE) ||
> +            force_uptodate) && !PageUptodate(page)) {
> +               ret =3D prepare_uptodate_page(inode, page, pos, true);
> +               if (ret) {
> +                       put_page(page);
> +                       if (ret =3D=3D -EAGAIN)
> +                               goto again;
> +                       return ret;
> +               }
> +               wait_on_page_writeback(page);
> +       }
> +       *page_ret =3D page;
> +       return 0;
> +}
> +
>  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>                                                struct iov_iter *i)
>  {
> @@ -1626,45 +1552,26 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>         loff_t pos =3D iocb->ki_pos;
>         struct inode *inode =3D file_inode(file);
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -       struct page **pages =3D NULL;
> +       struct page *page =3D NULL;
>         struct extent_changeset *data_reserved =3D NULL;
> -       u64 release_bytes =3D 0;
>         u64 lockstart;
>         u64 lockend;
>         size_t num_written =3D 0;
> -       int nrptrs;
>         int ret =3D 0;
>         bool only_release_metadata =3D false;
>         bool force_page_uptodate =3D false;
>
> -       nrptrs =3D min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
> -                       PAGE_SIZE / (sizeof(struct page *)));
> -       nrptrs =3D min(nrptrs, current->nr_dirtied_pause - current->nr_di=
rtied);
> -       nrptrs =3D max(nrptrs, 8);
> -       pages =3D kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL=
);
> -       if (!pages)
> -               return -ENOMEM;
> -
>         while (iov_iter_count(i) > 0) {
>                 struct extent_state *cached_state =3D NULL;
>                 size_t offset =3D offset_in_page(pos);
> -               size_t sector_offset;
>                 size_t write_bytes =3D min(iov_iter_count(i),
> -                                        nrptrs * (size_t)PAGE_SIZE -
> -                                        offset);
> -               size_t num_pages =3D DIV_ROUND_UP(write_bytes + offset,
> -                                               PAGE_SIZE);
> -               size_t reserve_bytes;
> -               size_t dirty_pages;
> +                                        PAGE_SIZE - offset);
> +               size_t reserve_bytes =3D PAGE_SIZE;
>                 size_t copied;
> -               size_t dirty_sectors;
> -               size_t num_sectors;
>                 int extents_locked;
>
> -               WARN_ON(num_pages > nrptrs);
> -
>                 /*
> -                * Fault pages before locking them in prepare_pages
> +                * Fault pages before locking them in prepare_page()
>                  * to avoid recursive lock
>                  */
>                 if (unlikely(iov_iter_fault_in_readable(i, write_bytes)))=
 {
> @@ -1673,37 +1580,27 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>                 }
>
>                 only_release_metadata =3D false;
> -               sector_offset =3D pos & (fs_info->sectorsize - 1);
> -               reserve_bytes =3D round_up(write_bytes + sector_offset,
> -                               fs_info->sectorsize);
>
>                 extent_changeset_release(data_reserved);
>                 ret =3D btrfs_check_data_free_space(BTRFS_I(inode),
>                                                   &data_reserved, pos,
>                                                   write_bytes);
>                 if (ret < 0) {
> +                       size_t tmp =3D write_bytes;
>                         if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
> -                                                  &write_bytes) > 0) {
> +                                                  &tmp) > 0) {
> +                               ASSERT(tmp =3D=3D write_bytes);
>                                 /*
>                                  * For nodata cow case, no need to reserv=
e
>                                  * data space.
>                                  */
>                                 only_release_metadata =3D true;
> -                               /*
> -                                * our prealloc extent may be smaller tha=
n
> -                                * write_bytes, so scale down.
> -                                */
> -                               num_pages =3D DIV_ROUND_UP(write_bytes + =
offset,
> -                                                        PAGE_SIZE);
> -                               reserve_bytes =3D round_up(write_bytes +
> -                                                        sector_offset,
> -                                                        fs_info->sectors=
ize);
> +                               reserve_bytes =3D 0;
>                         } else {
>                                 break;
>                         }
>                 }
>
> -               WARN_ON(reserve_bytes =3D=3D 0);
>                 ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
>                                 reserve_bytes);
>                 if (ret) {
> @@ -1716,16 +1613,9 @@ static noinline ssize_t btrfs_buffered_write(struc=
t kiocb *iocb,
>                         break;
>                 }
>
> -               release_bytes =3D reserve_bytes;
>  again:
> -               /*
> -                * This is going to setup the pages array with the number=
 of
> -                * pages we want, so we don't really need to worry about =
the
> -                * contents of pages from loop to loop
> -                */
> -               ret =3D prepare_pages(inode, pages, num_pages,
> -                                   pos, write_bytes,
> -                                   force_page_uptodate);
> +               ret =3D prepare_one_page(inode, &page, pos, write_bytes,
> +                                      force_page_uptodate);
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
>                                                        reserve_bytes);
> @@ -1733,9 +1623,8 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>                 }
>
>                 extents_locked =3D lock_and_cleanup_extent_if_need(
> -                               BTRFS_I(inode), pages,
> -                               num_pages, pos, write_bytes, &lockstart,
> -                               &lockend, &cached_state);
> +                               BTRFS_I(inode), &page, 1, pos, write_byte=
s,
> +                               &lockstart, &lockend, &cached_state);
>                 if (extents_locked < 0) {
>                         if (extents_locked =3D=3D -EAGAIN)
>                                 goto again;
> @@ -1745,57 +1634,38 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>                         break;
>                 }
>
> -               copied =3D btrfs_copy_from_user(pos, write_bytes, pages, =
i);
> -
> -               num_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_byte=
s);
> -               dirty_sectors =3D round_up(copied + sector_offset,
> -                                       fs_info->sectorsize);
> -               dirty_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_sect=
ors);
> -
> -               /*
> -                * if we have trouble faulting in the pages, fall
> -                * back to one page at a time
> -                */
> -               if (copied < write_bytes)
> -                       nrptrs =3D 1;
> +               copied =3D iov_iter_copy_from_user_atomic(page, i, offset=
,
> +                                                       write_bytes);
> +               flush_dcache_page(page);
>
> -               if (copied =3D=3D 0) {
> +               if (!PageUptodate(page) && copied < write_bytes) {
> +                       /*
> +                        * Short write on non-uptodate page, we must retr=
y and
> +                        * force the page uptodate in next run.
> +                        */
> +                       copied =3D 0;
>                         force_page_uptodate =3D true;
> -                       dirty_sectors =3D 0;
> -                       dirty_pages =3D 0;
>                 } else {
> +                       /* Next run doesn't need forced uptodate */
>                         force_page_uptodate =3D false;
> -                       dirty_pages =3D DIV_ROUND_UP(copied + offset,
> -                                                  PAGE_SIZE);
>                 }
>
> -               if (num_sectors > dirty_sectors) {
> -                       /* release everything except the sectors we dirti=
ed */
> -                       release_bytes -=3D dirty_sectors <<
> -                                               fs_info->sb->s_blocksize_=
bits;
> -                       if (only_release_metadata) {
> -                               btrfs_delalloc_release_metadata(BTRFS_I(i=
node),
> -                                                       release_bytes, tr=
ue);
> -                       } else {
> -                               u64 __pos;
> +               iov_iter_advance(i, copied);
>
> -                               __pos =3D round_down(pos,
> -                                                  fs_info->sectorsize) +
> -                                       (dirty_pages << PAGE_SHIFT);
> +               if (copied > 0) {
> +                       ret =3D btrfs_dirty_pages(BTRFS_I(inode), &page, =
1, pos,
> +                                               copied, &cached_state);
> +               } else {
> +                       /* No bytes copied, need to free reserved space *=
/
> +                       if (only_release_metadata)
> +                               btrfs_delalloc_release_metadata(BTRFS_I(i=
node),
> +                                               reserve_bytes, true);
> +                       else
>                                 btrfs_delalloc_release_space(BTRFS_I(inod=
e),
> -                                               data_reserved, __pos,
> -                                               release_bytes, true);
> -                       }
> +                                               data_reserved, pos, write=
_bytes,
> +                                               true);
>                 }
>
> -               release_bytes =3D round_up(copied + sector_offset,
> -                                       fs_info->sectorsize);
> -
> -               if (copied > 0)
> -                       ret =3D btrfs_dirty_pages(BTRFS_I(inode), pages,
> -                                               dirty_pages, pos, copied,
> -                                               &cached_state);
> -
>                 /*
>                  * If we have not locked the extent range, because the ra=
nge's
>                  * start offset is >=3D i_size, we might still have a non=
-NULL
> @@ -1811,26 +1681,22 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>
>                 btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_by=
tes);
>                 if (ret) {
> -                       btrfs_drop_pages(pages, num_pages);
> +                       btrfs_drop_pages(&page, 1);
>                         break;
>                 }
>
> -               release_bytes =3D 0;
> -               if (only_release_metadata)
> +               if (only_release_metadata) {
>                         btrfs_check_nocow_unlock(BTRFS_I(inode));
> -
> -               if (only_release_metadata && copied > 0) {
>                         lockstart =3D round_down(pos,
>                                                fs_info->sectorsize);
> -                       lockend =3D round_up(pos + copied,
> -                                          fs_info->sectorsize) - 1;
> +                       lockend =3D lockstart + PAGE_SIZE - 1;
>
>                         set_extent_bit(&BTRFS_I(inode)->io_tree, lockstar=
t,
>                                        lockend, EXTENT_NORESERVE, NULL,
>                                        NULL, GFP_NOFS);
>                 }
>
> -               btrfs_drop_pages(pages, num_pages);
> +               btrfs_drop_pages(&page, 1);
>
>                 cond_resched();
>
> @@ -1840,21 +1706,6 @@ static noinline ssize_t btrfs_buffered_write(struc=
t kiocb *iocb,
>                 num_written +=3D copied;
>         }
>
> -       kfree(pages);
> -
> -       if (release_bytes) {
> -               if (only_release_metadata) {
> -                       btrfs_check_nocow_unlock(BTRFS_I(inode));
> -                       btrfs_delalloc_release_metadata(BTRFS_I(inode),
> -                                       release_bytes, true);
> -               } else {
> -                       btrfs_delalloc_release_space(BTRFS_I(inode),
> -                                       data_reserved,
> -                                       round_down(pos, fs_info->sectorsi=
ze),
> -                                       release_bytes, true);
> -               }
> -       }
> -
>         extent_changeset_free(data_reserved);
>         return num_written ? num_written : ret;
>  }
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
