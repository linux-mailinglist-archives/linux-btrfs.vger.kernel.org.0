Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB515B010
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 19:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLSow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 13:44:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35563 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 13:44:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so2204245vsc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QWI8O3KGmRxKmPO81LSqc36NbpK8zjcvZ/DHlbeAGzs=;
        b=SRrkYNMZqfdGfUScJwDTMn+ODpfOwPaWOBfcjxesZpFO5Ek9qNhKGrcY33f8KaMPVO
         zV/uqOs3Fi+HaHTv92nNsX0qYHRhT3mYyD18vMaap0AxzVPhASC6AhpxmAwY/uGfCt+B
         rXkQxS/SGz4AHG69X56aq5BIlZVrsQCR1c2UbFZDImXgM4E6gAZl5qlJ0xh++2DRRIjm
         qBz2YfEwFTsndPTxche+tqj6v/3vkaQQuCXFoXBNReOf1M7UX0SwI9uDmBjtslqQi6xz
         LC0e42ZUMnMo++hNnXVP++qLlfzyeLObENQRLxuAJ6ur+uSJlXllvt6FcNBehUzAnnlC
         JWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QWI8O3KGmRxKmPO81LSqc36NbpK8zjcvZ/DHlbeAGzs=;
        b=Jq/ab3CFoluTmKX/xCIB6rgaHs12vH3yQ2HkgBgQ6LIxs8ymdYS4SctvvZfTj7U3Ue
         6lTyGRN7lE5TZ/QS1ldIJbDfUW6+QiN07zzELXodbaxYDC2Epbv5LHE0Jai3KCiO1hbV
         1EW9bWuDsprFjmRFaDabnYEXjQA4zWAN9cctKg+9QOikPsqzB7L3Lx4NBRmDgLWGUi4F
         ECGFCtHmLVV1ngpY7tH6V5KSboIZiHsa0pZ1jI0IQ2cApYpFj+vGaq8kXCC28PgdnBbP
         jeAy+u0iGNzKjeNu4ulv3iUF7HAebTt2ZG1qu2iFbtp1emPWcm6ibZZ3hIiYJTrzIyYT
         xBTQ==
X-Gm-Message-State: APjAAAW5wrrQsNp7qbiqh5ZLa9S6ZUPJ7FKTCugZLwaP+EQeWwfRhuvT
        Qiohu91VxsyPiYklXiERilpJ5mxNZ2uMS7SMTdKxrA==
X-Google-Smtp-Source: APXvYqw1sws5x3qmFQV6fouYtVpaktJgvbdGlbzCnYZGsCNvY/Os1yHnFyabU9qMxSXFbm/whXWXN53cQwXeORD9K/0=
X-Received: by 2002:a67:af11:: with SMTP id v17mr11972498vsl.99.1581533091270;
 Wed, 12 Feb 2020 10:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20200212183831.78293-1-josef@toxicpanda.com>
In-Reply-To: <20200212183831.78293-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 12 Feb 2020 18:44:39 +0000
Message-ID: <CAL3q7H7vUxcghnxfyVTrG0ztHZT-=9uo7H7nwRCJUzyB25CiPQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use it
 for safe isize
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 6:40 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Filipe noticed a race where we would sometimes get the wrong answer for
> the i_disk_size for !NO_HOLES with my patch.  That is because I expected
> that find_first_extent_bit() would find the contiguous range, since I'm
> only ever setting EXTENT_DIRTY.  However the way set_extent_bit() works
> is it'll temporarily split the range, loop around and set our bits, and
> then merge the state.  When it loops it drops the tree->lock, so there
> is a window where we can have two adjacent states instead of one large
> state.  Fix this by walking forward until we find a non-contiguous
> state, and set our end_ret to the end of our logically contiguous area.
> This fixes the problem without relying on specific behavior from
> set_extent_bit().
>
> Fixes: 79ceff7f6e5d ("btrfs: introduce per-inode file extent tree")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> Dave, I assume you'll want to fold this in to the referenced patch, if no=
t let
> me know and I'll rework the series to include this as a different patch.
>
>  fs/btrfs/extent-io-tree.h |  2 ++
>  fs/btrfs/extent_io.c      | 36 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/file-item.c      |  4 ++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 16fd403447eb..cc3037f9765e 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -223,6 +223,8 @@ int find_first_extent_bit(struct extent_io_tree *tree=
, u64 start,
>                           struct extent_state **cached_state);
>  void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
>                                  u64 *start_ret, u64 *end_ret, unsigned b=
its);
> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
> +                              u64 *start_ret, u64 *end_ret, unsigned bit=
s);
>  int extent_invalidatepage(struct extent_io_tree *tree,
>                           struct page *page, unsigned long offset);
>  bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d91a48d73e8f..50bbaf1c7cf0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1578,6 +1578,42 @@ int find_first_extent_bit(struct extent_io_tree *t=
ree, u64 start,
>         return ret;
>  }
>
> +/**
> + * find_contiguous_extent_bit: find a contiguous area of bits
> + * @tree - io tree to check
> + * @start - offset to start the search from
> + * @start_ret - the first offset we found with the bits set
> + * @end_ret - the final contiguous range of the bits that were set
> + *
> + * set_extent_bit anc clear_extent_bit can temporarily split contiguous =
ranges
> + * to set bits appropriately, and then merge them again.  During this ti=
me it
> + * will drop the tree->lock, so use this helper if you want to find the =
actual
> + * contiguous area for given bits.  We will search to the first bit we f=
ind, and
> + * then walk down the tree until we find a non-contiguous area.  The are=
a
> + * returned will be the full contiguous area with the bits set.
> + */
> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
> +                              u64 *start_ret, u64 *end_ret, unsigned bit=
s)
> +{
> +       struct extent_state *state;
> +       int ret =3D 1;
> +
> +       spin_lock(&tree->lock);
> +       state =3D find_first_extent_bit_state(tree, start, bits);
> +       if (state) {
> +               *start_ret =3D state->start;
> +               *end_ret =3D state->end;
> +               while ((state =3D next_state(state)) !=3D NULL) {
> +                       if (state->start > (*end_ret + 1))
> +                               break;
> +                       *end_ret =3D state->end;
> +               }
> +               ret =3D 0;

So as long as the tree is not empty, we will always be returning 0
(success), right?
If we break from the while loop we should return with 1, but this
makes us return 0.

thanks

> +       }
> +       spin_unlock(&tree->lock);
> +       return ret;
> +}
> +
>  /**
>   * find_first_clear_extent_bit - find the first range that has @bits not=
 set.
>   * This range could start before @start.
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index a73878051761..6c849e8fd5a1 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -51,8 +51,8 @@ void btrfs_inode_safe_disk_i_size_write(struct inode *i=
node, u64 new_i_size)
>         }
>
>         spin_lock(&BTRFS_I(inode)->lock);
> -       ret =3D find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, =
0,
> -                                   &start, &end, EXTENT_DIRTY, NULL);
> +       ret =3D find_contiguous_extent_bit(&BTRFS_I(inode)->file_extent_t=
ree, 0,
> +                                        &start, &end, EXTENT_DIRTY);
>         if (!ret && start =3D=3D 0)
>                 i_size =3D min(i_size, end + 1);
>         else
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
