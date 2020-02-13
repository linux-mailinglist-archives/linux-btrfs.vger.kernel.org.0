Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11EB15BCAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 11:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBMKWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 05:22:24 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46598 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 05:22:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so3214347vso.13
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 02:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dme1qrHm8Yzv+xCYRnFB0JZETyMPQED75KaiXjLTixo=;
        b=Nf2AQCr8ZeCS47D0elBzdIHt0wUrQ+bliezGP1h3mRAV8Q9lIMVULGRbJNFbdDM2Dg
         GjQWKjTcq8KVyrho5feFSdMuViRkWTCoC+3mh5k7Dn7Yw24otdNmOMStLQtKOde62Z/+
         o+MXJNGZiFCiYN0rNMTIai+4XGi2HAmzsix2BFDGxyJEDB1QuE6Bs4Y/BEV2hXGRV9/0
         yz4VKCKKrHuXEckOdjjl/d0kx4vELXaYPdF2TekwknSKoTG7uYyOaJeu83d4qW2eQYnC
         cggrnirZcXR28dodi3/MV4VN1TCssOJZf+l0pLkB3nUgT2A268bZeoa6y02IWUUnnHdT
         OW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dme1qrHm8Yzv+xCYRnFB0JZETyMPQED75KaiXjLTixo=;
        b=tU4v+7sFqcYhYiqODOmNzfLXmXLd3zuALvH/2PBjLGc/FhdIjHVJVajCSMXnPy5zqV
         CejVGKZDhdALG1mqvkrrlfyAVdOT0xD3QYsbroktolAA84IMF0MBmC50QwHVI+SsDu8a
         8gtmGg/xyZMrkeT+yRPwicF+BNtyze2DpJ0HLwOXFk4PBsnP5PALRFfuikV08sSkaPN7
         yg9POwh0ZV+MtX6Tc7io8+hlKN4in+IaNghUjcWKMJIAUdX/fvk1AaPeynq+vsbH014l
         q3jmr33SH3Omt+p4r3St9zT+FfoIA85MsE3vpKDvvCePNqzdnrp7JxC5BmXZplMtGULJ
         ykIQ==
X-Gm-Message-State: APjAAAXlzZwNy4uupY0ghuU0bBxj+tvarAHS0EzAYyvYzt7iUiwnjMoX
        7PL6mWtK17kNP1ME9lPt90HJ2O4Au0aCN8P3JIQ=
X-Google-Smtp-Source: APXvYqz4faVWDNSGiWnFWxuTzDX0yKj5H4QxVKu0UN4431K5aDii0MvtjF6ASdm03xUuSV0p3hpxiFFTCriZYHHvqEA=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr1649211vsq.206.1581589342705;
 Thu, 13 Feb 2020 02:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20200212183831.78293-1-josef@toxicpanda.com>
In-Reply-To: <20200212183831.78293-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 13 Feb 2020 10:22:11 +0000
Message-ID: <CAL3q7H7H1=Fq6z+-4FUzai+yTEgJbhxuNCiDBH0SnesZS8UWqA@mail.gmail.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Alright, survived overnight tests (without my optimization patch), so
it's all good.
Thanks.

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
