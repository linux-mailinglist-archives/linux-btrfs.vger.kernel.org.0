Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBEF375208
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhEFKIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 06:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbhEFKIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 May 2021 06:08:34 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB5C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  6 May 2021 03:07:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so3530658qtx.11
        for <linux-btrfs@vger.kernel.org>; Thu, 06 May 2021 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=P9hDnh4/hoQx9kewnYYGGj+O4VgmJ8czX/yoPWFBx+Q=;
        b=er4DR9DjNllgllGXWG6m5wV6Swy8du1kwWtQAmx2LvMcwJzzIXR6wjQcF/U0PN1XAe
         7y+WGn9+E6kPVmglPp9pNfiR1qpR8fwq3i/3rKLS1zss+lHJ2CvoMue1RQ8kGq8nfD7S
         Dx8tbZtNNu7mHJVRrwv0UQ60c1T0nNyow+W457u8G+7CVaq2Ntm5WJ4EHwJt4p82558/
         E3CYNLcFgFKsrWlh5nUpGjH7Yt0+8G1BnxURP+FqRQjh2SWx88yrzpvNJ2BtV/xF5Cp1
         z/I+SdF/LK7Q3qe+4wGFLcrgvm5imlNQH5J5j07258P2ex9Jiz15RBVt5qinsth7sId9
         qhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=P9hDnh4/hoQx9kewnYYGGj+O4VgmJ8czX/yoPWFBx+Q=;
        b=CmOi9HR8qyHkuKmv3UdPfjygxrOO2tCrsGJ65SQyZ2jhlGlYxeD2GMIX9KR+XjycK3
         ofOB29iaBYfYUc3bLDQ6ZJqSSyLqgJzlHKB/AKTMOAc5gIVA0kK74tXDWGvLTHf9yTc/
         PJe72TToIxVhDKRYS59BzypPsVx+ubNEf+Xa8WoE6RYKpjc3W4TWE00FmZmnVoObCZu5
         Vdk6bL9R1SDFmejz2KL5/N4+7L5BX6QZj2Eb5HC/RmqKvFJ4kW9390iVYZL2kiV5JRkm
         ohAYOjr+Ja9PLqBi/XP08v+1Fdi/19/byUL+YVHzBv9WkdsKnueHMQneK4Q7c8c2/Uiw
         CxUg==
X-Gm-Message-State: AOAM533ZyXKbmgofvT1QLTXP5DTRVYPHf6rZ/vGF2QMzmOA8W5PcD1kg
        ZRMq3rF8VNFOoeL38aAPioVGPgQ5Z+9rk5qM0yFNv17S3D5CyA==
X-Google-Smtp-Source: ABdhPJw3wBSlWJXxaXJCXy59tWn4fxQfyqg9uRCGlvBMBtgcXn/yJx+sKmBWmLKAjFP5xR6j0PdPayLJjg53KJZc4OQ=
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr3391054qta.259.1620295654932;
 Thu, 06 May 2021 03:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210506070458.168945-1-wqu@suse.com>
In-Reply-To: <20210506070458.168945-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 6 May 2021 11:07:23 +0100
Message-ID: <CAL3q7H7TY9c=dzcJw62-nZh-fSieb3gQyqjdXLv+-rMVmQ+ZJg@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: temporary disable inline extent creation for
 fallocate and reflink
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 6, 2021 at 8:07 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Previously we disable inline extent creation completely for subpage
> case, due to the fact that writeback for subpage still happens for full
> page.
>
> This makes btrfs_wait_ordered_range() trigger writeback for larger
> range, thus can writeback the first sector even we don't want.
>
> But the truth is, even for regular sectorsize, we still have a race
> window there operations where fallocate and reflink can cause inline
> extent being created.

Yes, but why is it a problem for when sectorsize =3D=3D page size?
There were problems in the past with send, clone, and fsync due their
expectations of never having a regular extent following an inline
extent, but all the ones I'm aware of were fixed long ago.

>
> For example, for the following operations:
>
>  # xfs_io -f -c "pwrite 0 2k" -c "falloc 4k 4k" $file
>
> The first "pwrite 0 2k" dirtied the first sector, while inode size is
> updated to 2k.
> At this point, if the first sector is written back, it will be inlined.
>
> Then we enter "falloc 4k 4k" which will:
> a) call btrfs_cont_expand() to insert holes
> b) do the mainline to insert preallocated extents
> c) call btrfs_fallocate_update_isize() to enlarge the isize
>
> Until c), the isize is still 2K, and during that window, if the first
> sector is written back due to whatever reasons (from memory pressure to
> fadvice to writeback the pages), since the isize is still 2K, we will

fadvice -> fadvise

> write the first sector as inlined.
>
> Then we have a case where we get mixed inline and regular extents.

Again, the change log should mention why it is a problem, how it affects us=
ers?
Some data corruption, reads returning wrong data, some crash, something els=
e?
Is it only a problem for pagesize > sectorsize, or for pagesize =3D=3D
sectorsize too?

>
> Fix the problem by introducing a new runtime inode flag,
> BTRFS_INODE_NOINLINE, to temporarily disable inline extent creation
> until the isize get enlarged.
>
> So that we don't need to disable inline extent creation completely for
> subpage.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> I'm not sure if this is the best solution, as the original race window
> for regular sector has existed for a long long time.

Yes, but as mentioned before, it does not cause bug, does it?

>
> I have also tried other solutions like switching the timing of
> btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
> btrfs_wait_ordered_range() happens before btrfs_cont_expand().
>
> So that we will writeback the first sector for subpage as inline, then
> btrfs_cont_expand() will re-dirty the first sector.
>
> This would solve the problem for subpage, but not the race window.
>
> Another idea is to enlarge inode size first, but that would greatly
> change the error path, may cause new regressions.

I think I would prefer it that way. I don't see why it would change
the error paths so much.
Instead of clearing the bit, it would be just assigning the old i_isize val=
ue.

But I don't have a strong preference.

>
> I'm all ears for advice on this problem.
> ---
>  fs/btrfs/ctree.h         | 10 ++++++++++
>  fs/btrfs/delayed-inode.c |  3 ++-
>  fs/btrfs/file.c          | 19 +++++++++++++++++++
>  fs/btrfs/inode.c         | 21 ++++-----------------
>  fs/btrfs/reflink.c       | 14 ++++++++++++--
>  fs/btrfs/root-tree.c     |  3 ++-
>  fs/btrfs/tree-log.c      |  3 ++-
>  7 files changed, 51 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7bb4212b90d3..7c74d57ad8fc 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1488,6 +1488,16 @@ do {                                              =
                     \
>  #define BTRFS_INODE_DIRSYNC            (1 << 10)
>  #define BTRFS_INODE_COMPRESS           (1 << 11)
>
> +/*
> + * Runtime bit to temporary disable inline extent creation.
> + * To prevent the first sector get written back as inline before the isi=
ze
> + * get enlarged.
> + *
> + * This flag is for runtime only, won't reach disk, thus is not included
> + * in BTRFS_INODE_FLAG_MASK.
> + */
> +#define BTRFS_INODE_NOINLINE           (1 << 30)
> +
>  #define BTRFS_INODE_ROOT_ITEM_INIT     (1 << 31)
>
>  #define BTRFS_INODE_FLAG_MASK                                          \
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 1a88f6214ebc..64d931da083d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_tran=
s_handle *trans,
>                                        inode_peek_iversion(inode));
>         btrfs_set_stack_inode_transid(inode_item, trans->transid);
>         btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
> -       btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags);
> +       btrfs_set_stack_inode_flags(inode_item,
> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);

If it's a runtime flag, not meant to be persisted, then it should be
set in btrfs_inode->runtime flags and not on btrfs_inode->flags,
which not only makes it more clear, but avoids doing this sort of bit
manipulation.

>         btrfs_set_stack_inode_block_group(inode_item, 0);
>
>         btrfs_set_stack_timespec_sec(&inode_item->atime,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 70a36852b680..a3559ce93780 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>                         goto out;
>         }
>
> +       /*
> +        * Disable inline extent creation until we enlarged the inode siz=
e.

until we enlarged -> until we increase (or update)

> +        *
> +        * Since the inode size is only increased after we allocated all

So this is a bit confusing to read. You'll want to mention that happens onl=
y
for fallocate and cloning.

As I read it, if I had little or no knowledge of the code, I would
interpret that that happens for all cases.
But those two cases, fallocate and cloning, are the exceptions to the
rule, which is we update the i_size and then fill in the file extent
items (like in the write path).

> +        * extents, there are several cases to writeback the first sector=
,
> +        * which can be inlined, leaving inline extent mixed with regular
> +        * extents:
> +        *
> +        * - btrfs_wait_ordered_range() call for subpage case
> +        *   The writeback happens for the full page, thus can writeback
> +        *   the first sector of an inode.
> +        *
> +        * - Memory pressure
> +        *
> +        * So here we temporarily disable inline extent creation for the =
inode.

Same as commented before, I would like to know why is it a problem,
how does it affect correctness, if there's some corruption, crash, or
something else affecting users.

> +        */
> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
> +
>         /*
>          * TODO: Move these two operations after we have checked
>          * accurate reserved space, or fallocate can still fail but
> @@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, int =
mode,
>         unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locke=
d_end,
>                              &cached_state);
>  out:
> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>         btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>         /* Let go of our reservation. */
>         if (ret !=3D 0 && !(mode & FALLOC_FL_ZERO_RANGE))
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4fc6e6766234..59972cb2efce 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -666,11 +666,7 @@ static noinline int compress_file_range(struct async=
_chunk *async_chunk)
>                 }
>         }
>  cont:
> -       /*
> -        * Check cow_file_range() for why we don't even try to create
> -        * inline extent for subpage case.
> -        */
> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +       if (start =3D=3D 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NOINL=
INE)) {
>                 /* lets try to make an inline extent */
>                 if (ret || total_in < actual_end) {
>                         /* we didn't compress the entire range, try
> @@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>
>         inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>
> -       /*
> -        * Due to the page size limit, for subpage we can only trigger th=
e
> -        * writeback for the dirty sectors of page, that means data write=
back
> -        * is doing more writeback than what we want.
> -        *
> -        * This is especially unexpected for some call sites like falloca=
te,
> -        * where we only increase isize after everything is done.
> -        * This means we can trigger inline extent even we didn't want.
> -        * So here we skip inline extent creation completely.
> -        */
> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +       if (start =3D=3D 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) {
>                 /* lets try to make an inline extent */
>                 ret =3D cow_file_range_inline(inode, start, end, 0,
>                                             BTRFS_COMPRESS_NONE, NULL);
> @@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_hand=
le *trans,
>         btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(=
inode));
>         btrfs_set_token_inode_transid(&token, item, trans->transid);
>         btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
> +       btrfs_set_token_inode_flags(&token, item,
> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>         btrfs_set_token_inode_block_group(&token, item, 0);
>  }
>
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e5680c03ead4..48f8bdd185de 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
>         if (off + len =3D=3D src->i_size)
>                 len =3D ALIGN(src->i_size, bs) - off;
>
> +       /*
> +        * Temporarily disable inline extent creation, check btrfs_falloc=
ate()
> +        * for details
> +        */
> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>         if (destoff > inode->i_size) {
>                 const u64 wb_start =3D ALIGN_DOWN(inode->i_size, bs);
>
>                 ret =3D btrfs_cont_expand(BTRFS_I(inode), inode->i_size, =
destoff);
> -               if (ret)
> +               if (ret) {
> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>                         return ret;
> +               }
>                 /*
>                  * We may have truncated the last block if the inode's si=
ze is
>                  * not sector size aligned, so we need to wait for writeb=
ack to
> @@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file *f=
ile, struct file *file_src,
>                  */
>                 ret =3D btrfs_wait_ordered_range(inode, wb_start,
>                                                destoff - wb_start);
> -               if (ret)
> +               if (ret) {
> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>                         return ret;
> +               }
>         }
>
>         /*
> @@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file *fi=
le, struct file *file_src,
>                                 round_down(destoff, PAGE_SIZE),
>                                 round_up(destoff + len, PAGE_SIZE) - 1);
>
> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>         return ret;
>  }
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 702dc5441f03..5ce3a1dfaf3f 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_root=
_item *root_item)
>
>         if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
>                 inode_flags |=3D BTRFS_INODE_ROOT_ITEM_INIT;
> -               btrfs_set_stack_inode_flags(&root_item->inode, inode_flag=
s);
> +               btrfs_set_stack_inode_flags(&root_item->inode,
> +                               inode_flags & BTRFS_INODE_FLAG_MASK);

Same as before, using btrfs_inode->runtime_flags would eliminate the
need for this.

>                 btrfs_set_root_flags(root_item, 0);
>                 btrfs_set_root_limit(root_item, 0);
>         }
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c1353b84ae54..f7e6abfc89c0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_hand=
le *trans,
>         btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(=
inode));
>         btrfs_set_token_inode_transid(&token, item, trans->transid);
>         btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
> +       btrfs_set_token_inode_flags(&token, item,
> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);

Same as before, using btrfs_inode->runtime_flags would eliminate the
need for this.

Thanks.

>         btrfs_set_token_inode_block_group(&token, item, 0);
>  }
>
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
