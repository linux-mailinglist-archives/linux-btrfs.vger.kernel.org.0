Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A934D72A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfJOJ4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 05:56:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43144 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJOJ4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 05:56:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id b1so12730523vsr.10
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8szKLMRyYv4AiKXI5JmsJPlDpaHIggXB5mT90I+/tI4=;
        b=gUtiyA395niYiA8JEnNtaUv4+IPXm+9DVvjLjJFlVU4IjTjrCIbM1H+t1b+ZyDry/X
         RZvp+wVhjpIhelEspKqOwgGbBTOuHkOav5V3/Y0cUlLKcZbBZfwjZFx6q5ErvMF3LE8U
         puMo7SHNK/QXmOIyoXx32uaoxjikWffWTlIH/wjGAe0N6zG8p92XL0WYUs5ZQMrN3L6s
         nj4OrIkkMYrbEVZbRWPBKotE4pZMQ0HEVgBTCGw2l8gTsR4LzujfckEzwSee7QOiGbvN
         AbkCv61bAZS9nr5TQwZV4RrvfxRi+/vmzOQzw1lDksDgYyUruFiIiwhx7V3r6Wou+Qyb
         +GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8szKLMRyYv4AiKXI5JmsJPlDpaHIggXB5mT90I+/tI4=;
        b=jip1B4MwzJE4Wb8pu7Xa8Z49ddyNBJlAmiqt1L6T7uEtSPigZyFdm5+YDaJNLHNreo
         jK/M0fL9B27+4n3f5C3rsNXEKt8HrpYx+B2a9eprcIvFRfdwN3gs4k/Ybp3J1vmo3jWq
         YnRXlcXcBKNGVVRZT6ZNPU83sFuk4OLYcOgICY/HAgz3TZ5yctq0xBlJfTD5Z6dRxmz9
         NXqiv48TWMFCoCuKPsl8GSg1Di8YzazmldjofKWADT4TAZGEuxuNiC4p9hhOdF/Ojv1B
         uKkTRopMK7fkF3TVAQwTqU+xW7APX8YMV+2FG9DBQMzlFRvE7o+1tLv50KmhG44cMIpQ
         qG+A==
X-Gm-Message-State: APjAAAXOm2xXQ4HdajZXDRoyxxzs5Sv+9FoPjqWyc3un0jkiH2hxZxlt
        K3R+gdah37f3NWKvBjvFNm05SmHnzLLdHGcuGaRjjf2J
X-Google-Smtp-Source: APXvYqyOhsh95gCMR2nwP8p6UEbLgmbq+PKgoy3Q3bkQb5UJV2hKXUdSyuTejBzP5qwmZ3fJ1rkuBEGa6ISBwnm9XYg=
X-Received: by 2002:a67:ba16:: with SMTP id l22mr19249658vsn.14.1571133410538;
 Tue, 15 Oct 2019 02:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191014063451.37343-1-wqu@suse.com>
In-Reply-To: <20191014063451.37343-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 15 Oct 2019 10:56:39 +0100
Message-ID: <CAL3q7H6GYEoUXAQtyKAd1AmRMh_bn0=g9tWL+rhrjO9O9_Dt0A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: Always free PREALLOC META reserve in btrfs_delalloc_release_extents()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 7:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [Background]
> Btrfs qgroup uses two types of reserved space for METADATA space,
> PERTRANS and PREALLOC.
>
> PERTRANS is metadata space reserved for each transaction started by
> btrfs_start_transaction().
> While PREALLOC is for delalloc, where we reserve space before joining a
> transaction, and finally it will be converted to PERTRANS after the
> writeback is done.
>
> [Inconsistency]
> However there is inconsistency in how we handle PREALLOC metadata space.
>
> The most obvious one is:
> In btrfs_buffered_write():
>         btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes, tru=
e);
>
> We always free qgroup PREALLOC meta space.
>
> While in btrfs_truncate_block():
>         btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, (ret !=
=3D 0));
>
> We only free qgroup PREALLOC meta space when something went wrong.
>
> [The Correct Behavior]
> The correct behavior should be the one in btrfs_buffered_write(), we
> should always free PREALLOC metadata space.
>
> The reason is, the btrfs_delalloc_* mechanism works by:
> - Reserve metadata first, even it's not necessary
>   In btrfs_delalloc_reserve_metadata()
>
> - Free the unused metadata space
>   Normally in:
>   btrfs_delalloc_release_extents()
>   |- btrfs_inode_rsv_release()
>      Here we do calculation on whether we should release or not.
>
> E.g. for 64K buffered write, the metadata rsv works like:
>
> /* The first page */
> reserve_meta:   num_bytes=3Dcalc_inode_reservations()
> free_meta:      num_bytes=3D0
> total:          num_bytes=3Dcalc_inode_reservations()
> /* The first page caused one outstanding extent, thus needs metadata
>    rsv */
>
> /* The 2nd page */
> reserve_meta:   num_bytes=3Dcalc_inode_reservations()
> free_meta:      num_bytes=3Dcalc_inode_reservations()
> total:          not changed
> /* The 2nd page doesn't cause new outstanding extent, needs no new meta
>    rsv, so we free what we have reserved */
>
> /* The 3rd~16th pages */
> reserve_meta:   num_bytes=3Dcalc_inode_reservations()
> free_meta:      num_bytes=3Dcalc_inode_reservations()
> total:          not changed (still space for one outstanding extent)
>
> This means, if btrfs_delalloc_release_extents() determines to free some
> space, then those space should be freed NOW.
> So for qgroup, we should call btrfs_qgroup_free_meta_prealloc() other
> than btrfs_qgroup_convert_reserved_meta().
>
> The good news is:
> - The callers are not that hot
>   The hottest caller is in btrfs_buffered_write(), which is already
>   fixed by commit 336a8bb8e36a ("btrfs: Fix wrong
>   btrfs_delalloc_release_extents parameter"). Thus it's not that
>   easy to cause false EDQUOT.
>
> - The trans commit in advance for qgroup would hide the bug
>   Since commit f5fef4593653 ("btrfs: qgroup: Make qgroup async transactio=
n
>   commit more aggressive"), when btrfs qgroup metadata free space is slow=
,
>   it will try to commit transaction and free the wrongly converted
>   PERTRANS space, so it's not that easy to hit such bug.
>
> [FIX]
> So to fix the problem, remove the @qgroup_free parameter for
> btrfs_delalloc_release_extents(), and always pass true to
> btrfs_inode_rsv_release().
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 43b18595d660 ("btrfs: qgroup: Use separate meta reservation type f=
or delalloc")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for looking into this!

> ---
>  fs/btrfs/ctree.h          |  3 +--
>  fs/btrfs/delalloc-space.c |  6 ++----
>  fs/btrfs/file.c           |  7 +++----
>  fs/btrfs/inode-map.c      |  4 ++--
>  fs/btrfs/inode.c          | 12 ++++++------
>  fs/btrfs/ioctl.c          |  6 ++----
>  fs/btrfs/relocation.c     |  7 +++----
>  7 files changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 19d669d12ca1..6b50bafd6a64 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2489,8 +2489,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_r=
oot *root,
>                                      int nitems, bool use_global_rsv);
>  void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
>                                       struct btrfs_block_rsv *rsv);
> -void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_b=
ytes,
> -                                   bool qgroup_free);
> +void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_b=
ytes);
>
>  int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_b=
ytes);
>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *si=
nfo);
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index d949d7d2abed..571e7b31ea2f 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -418,7 +418,6 @@ void btrfs_delalloc_release_metadata(struct btrfs_ino=
de *inode, u64 num_bytes,
>   * btrfs_delalloc_release_extents - release our outstanding_extents
>   * @inode: the inode to balance the reservation for.
>   * @num_bytes: the number of bytes we originally reserved with
> - * @qgroup_free: do we need to free qgroup meta reservation or convert t=
hem.
>   *
>   * When we reserve space we increase outstanding_extents for the extents=
 we may
>   * add.  Once we've set the range as delalloc or created our ordered ext=
ents we
> @@ -426,8 +425,7 @@ void btrfs_delalloc_release_metadata(struct btrfs_ino=
de *inode, u64 num_bytes,
>   * temporarily tracked outstanding_extents.  This _must_ be used in conj=
unction
>   * with btrfs_delalloc_reserve_metadata.
>   */
> -void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_b=
ytes,
> -                                   bool qgroup_free)
> +void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_b=
ytes)
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         unsigned num_extents;
> @@ -441,7 +439,7 @@ void btrfs_delalloc_release_extents(struct btrfs_inod=
e *inode, u64 num_bytes,
>         if (btrfs_is_testing(fs_info))
>                 return;
>
> -       btrfs_inode_rsv_release(inode, qgroup_free);
> +       btrfs_inode_rsv_release(inode, true);
>  }
>
>  /**
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 8fe4eb7e5045..59b20fb89abe 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1692,7 +1692,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>                                     force_page_uptodate);
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      reserve_bytes, tru=
e);
> +                                                      reserve_bytes);
>                         break;
>                 }
>
> @@ -1704,7 +1704,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>                         if (extents_locked =3D=3D -EAGAIN)
>                                 goto again;
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      reserve_bytes, tru=
e);
> +                                                      reserve_bytes);
>                         ret =3D extents_locked;
>                         break;
>                 }
> @@ -1761,8 +1761,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>                 if (extents_locked)
>                         unlock_extent_cached(&BTRFS_I(inode)->io_tree,
>                                              lockstart, lockend, &cached_=
state);
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_by=
tes,
> -                                              true);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_by=
tes);
>                 if (ret) {
>                         btrfs_drop_pages(pages, num_pages);
>                         break;
> diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> index 63cad7865d75..37345fb6191d 100644
> --- a/fs/btrfs/inode-map.c
> +++ b/fs/btrfs/inode-map.c
> @@ -501,13 +501,13 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
>         ret =3D btrfs_prealloc_file_range_trans(inode, trans, 0, 0, preal=
loc,
>                                               prealloc, prealloc, &alloc_=
hint);
>         if (ret) {
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc, =
true);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc);
>                 btrfs_delalloc_release_metadata(BTRFS_I(inode), prealloc,=
 true);
>                 goto out_put;
>         }
>
>         ret =3D btrfs_write_out_ino_cache(root, trans, path, inode);
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc, false);
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc);
>  out_put:
>         iput(inode);
>  out_release:
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a0546401bc0a..166b3acfbb1f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2206,7 +2206,7 @@ static void btrfs_writepage_fixup_worker(struct btr=
fs_work *work)
>
>         ClearPageChecked(page);
>         set_page_dirty(page);
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, false);
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>  out:
>         unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_e=
nd,
>                              &cached_state);
> @@ -4951,7 +4951,7 @@ int btrfs_truncate_block(struct inode *inode, loff_=
t from, loff_t len,
>         if (!page) {
>                 btrfs_delalloc_release_space(inode, data_reserved,
>                                              block_start, blocksize, true=
);
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize,=
 true);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize)=
;
>                 ret =3D -ENOMEM;
>                 goto out;
>         }
> @@ -5018,7 +5018,7 @@ int btrfs_truncate_block(struct inode *inode, loff_=
t from, loff_t len,
>         if (ret)
>                 btrfs_delalloc_release_space(inode, data_reserved, block_=
start,
>                                              blocksize, true);
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, (ret !=
=3D 0));
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
>         unlock_page(page);
>         put_page(page);
>  out:
> @@ -8706,7 +8706,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, =
struct iov_iter *iter)
>                 } else if (ret >=3D 0 && (size_t)ret < count)
>                         btrfs_delalloc_release_space(inode, data_reserved=
,
>                                         offset, count - (size_t)ret, true=
);
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), count, fal=
se);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), count);
>         }
>  out:
>         if (wakeup)
> @@ -9056,7 +9056,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>         unlock_extent_cached(io_tree, page_start, page_end, &cached_state=
);
>
>         if (!ret2) {
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE,=
 true);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE)=
;
>                 sb_end_pagefault(inode->i_sb);
>                 extent_changeset_free(data_reserved);
>                 return VM_FAULT_LOCKED;
> @@ -9065,7 +9065,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  out_unlock:
>         unlock_page(page);
>  out:
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, (ret !=
=3D 0));
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>         btrfs_delalloc_release_space(inode, data_reserved, page_start,
>                                      reserved_space, (ret !=3D 0));
>  out_noreserve:
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..7c145a41decd 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1360,8 +1360,7 @@ static int cluster_pages_for_defrag(struct inode *i=
node,
>                 unlock_page(pages[i]);
>                 put_page(pages[i]);
>         }
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_S=
HIFT,
> -                                      false);
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_S=
HIFT);
>         extent_changeset_free(data_reserved);
>         return i_done;
>  out:
> @@ -1372,8 +1371,7 @@ static int cluster_pages_for_defrag(struct inode *i=
node,
>         btrfs_delalloc_release_space(inode, data_reserved,
>                         start_index << PAGE_SHIFT,
>                         page_cnt << PAGE_SHIFT, true);
> -       btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_S=
HIFT,
> -                                      true);
> +       btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_S=
HIFT);
>         extent_changeset_free(data_reserved);
>         return ret;
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 00504657b602..205b35ee2fb3 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3297,7 +3297,7 @@ static int relocate_file_extent_cluster(struct inod=
e *inode,
>                                 btrfs_delalloc_release_metadata(BTRFS_I(i=
node),
>                                                         PAGE_SIZE, true);
>                                 btrfs_delalloc_release_extents(BTRFS_I(in=
ode),
> -                                                              PAGE_SIZE,=
 true);
> +                                                              PAGE_SIZE)=
;
>                                 ret =3D -EIO;
>                                 goto out;
>                         }
> @@ -3326,7 +3326,7 @@ static int relocate_file_extent_cluster(struct inod=
e *inode,
>                         btrfs_delalloc_release_metadata(BTRFS_I(inode),
>                                                          PAGE_SIZE, true)=
;
>                         btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      PAGE_SIZE, true);
> +                                                      PAGE_SIZE);
>
>                         clear_extent_bits(&BTRFS_I(inode)->io_tree,
>                                           page_start, page_end,
> @@ -3342,8 +3342,7 @@ static int relocate_file_extent_cluster(struct inod=
e *inode,
>                 put_page(page);
>
>                 index++;
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE,
> -                                              false);
> +               btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE)=
;
>                 balance_dirty_pages_ratelimited(inode->i_mapping);
>                 btrfs_throttle(fs_info);
>         }
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
