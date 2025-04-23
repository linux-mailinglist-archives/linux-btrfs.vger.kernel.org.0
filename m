Return-Path: <linux-btrfs+bounces-13321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15637A99168
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA09442D6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2428290BDD;
	Wed, 23 Apr 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kANj4Hi7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24881290BCD
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421432; cv=none; b=K/jUpdBQliyq9VH8+G+Hyb0yMBZ2sj7p5XGVe/bkHcbEKJcW1RXqN5ZRhPAQCGfM7BEN5n5vQJaKJgyu94WInz6mWffaEH2DOjQFqBzEwTF4apLa/zwREr2XRejiwqeCzMlfwqNymwJ3NUhSGKs0+B5S9pLIHsO3sIEH+z6RKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421432; c=relaxed/simple;
	bh=CtOJG0wS/hHshpIeC+pAooRAiEr1eiMrX+D5tS4TaDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCQAKB8jVBTLQ3gEL+5DpOYI9HweXe9usasQm3fi2fOEjDvMBGdU6pB4scSkZWqSK/OZ/klVojSyUtyXZJF42osFE5J6nYJl8yx1EB1+aLQMaCLb2vGsdHgNucqmHO/WcXT3Uiuj4wViIpbCkbVvHh98wptQ5uYgvgM89Y/ZTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kANj4Hi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD95FC4CEEC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421431;
	bh=CtOJG0wS/hHshpIeC+pAooRAiEr1eiMrX+D5tS4TaDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kANj4Hi7PoV+y1dqXG1SAdxYSM32MbBn5gONntKMNYGZYz/7R/qgCLAt6/m1sY8+2
	 pj/jkdkYhUF/h/DfC9OvOLYk7Cj76JabpibG4Lc9m/mWd4iMTFi9FLWJ5oXy5Bi5Ub
	 PA0om+WGbC7NGnPPcfXa1vHvNv1Fxlt60jOfzbTL+hTO3lcWAl12+Co/REB64X+uhb
	 pGHKl3f188jF/pUywPhyjzeyO7l0XOmlG4lAbgAVY0hgnajIBExyPJUQiaGt2jqHIf
	 VdOVb+FYs51J8NvCw/FKLVNNW7jDftHvENOde1XMlFBOAWxDd0O+HVy70VYk7VIRnu
	 9RgktLS+WWx/g==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0ad74483fso73938026d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 08:17:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxphqHvim5bQ9p7rb0+C8DzvEfvYj9onzBIh5H/AhGBuN+MFok9
	w/i1X39QkDrFFwKlbMehbuNQn5HPzyH63qkYS24c9Iesm8wCVg6HHoNmSIk08IG658locNx0yXh
	3EJFi0I9SC5twpVGQBo6FYu8D+hY=
X-Google-Smtp-Source: AGHT+IFCYVwDeg8UOULJtnmlhTI/ZILpUFjgDF3zUgmmUtm97MsWHHH5gGrqoQiZQ6JPbwWJoAhU0LxAoqIx7y6V0fo=
X-Received: by 2002:a05:6214:1c47:b0:6e4:4484:f35b with SMTP id
 6a1803df08f44-6f2c465a117mr251814676d6.30.1745421431042; Wed, 23 Apr 2025
 08:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744984487.git.josef@toxicpanda.com> <17df8fc5c719bbe63f6269ec4b2c7bf2df226cd3.1744984487.git.josef@toxicpanda.com>
In-Reply-To: <17df8fc5c719bbe63f6269ec4b2c7bf2df226cd3.1744984487.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Apr 2025 16:16:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H78WLP-BsmTT+J-w8sxX5aS2dOui6CqZ9PZGiBsE7FOgQ@mail.gmail.com>
X-Gm-Features: ATxdqUE5J3oTpdKSeSDEuA6h9mCgb8Z69F5z4RLAzAzYv_ZDCMexM7z8vVk9YF8
Message-ID: <CAL3q7H78WLP-BsmTT+J-w8sxX5aS2dOui6CqZ9PZGiBsE7FOgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 2:57=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> In preparation for changing how we do writeout of extent buffers, start
> tagging the extent buffer xarray with DIRTY and WRITEBACK to make it
> easier to find extent buffers that are in either state.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index aa451ad52528..ef6df7bcef5d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1801,8 +1801,19 @@ static noinline_for_stack bool lock_extent_buffer_=
for_io(struct extent_buffer *e
>          */
>         spin_lock(&eb->refs_lock);
>         if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +               XA_STATE(xas, &fs_info->buffer_tree,
> +                        eb->start >> fs_info->sectorsize_bits);
> +               unsigned long flags;
> +
>                 set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
>                 spin_unlock(&eb->refs_lock);
> +
> +               xas_lock_irqsave(&xas, flags);
> +               xas_load(&xas);
> +               xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
> +               xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
> +               xas_unlock_irqrestore(&xas, flags);
> +
>                 btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
>                 percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
>                                          -eb->len,
> @@ -1888,6 +1899,33 @@ static void set_btree_ioerr(struct extent_buffer *=
eb)
>         }
>  }
>
> +static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark=
_t mark)
> +{
> +       struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +       XA_STATE(xas, &fs_info->buffer_tree,
> +                eb->start >> fs_info->sectorsize_bits);

Btw, this fits in 84 characters so it doesn't need to be split as for
quite some time we tolerate a bit more than 80 characters.

> +       unsigned long flags;
> +
> +       xas_lock_irqsave(&xas, flags);
> +       xas_load(&xas);
> +       xas_set_mark(&xas, mark);
> +       xas_unlock_irqrestore(&xas, flags);
> +}
> +
> +static void buffer_tree_clear_mark(const struct extent_buffer *eb,
> +                                    xa_mark_t mark)

This can also become a single line, it's 82 characters.

> +{
> +       struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +       XA_STATE(xas, &fs_info->buffer_tree,
> +                eb->start >> fs_info->sectorsize_bits);

Same here.

Otherwise it looks fine, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       unsigned long flags;
> +
> +       xas_lock_irqsave(&xas, flags);
> +       xas_load(&xas);
> +       xas_clear_mark(&xas, mark);
> +       xas_unlock_irqrestore(&xas, flags);
> +}
> +
>  /*
>   * The endio specific version which won't touch any unsafe spinlock in e=
ndio
>   * context.
> @@ -1921,6 +1959,7 @@ static void end_bbio_meta_write(struct btrfs_bio *b=
bio)
>                 btrfs_meta_folio_clear_writeback(fi.folio, eb);
>         }
>
> +       buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
>         clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
>         smp_mb__after_atomic();
>         wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> @@ -3537,6 +3576,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_ha=
ndle *trans,
>         if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
>                 return;
>
> +       buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
>         percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len=
,
>                                  fs_info->dirty_metadata_batch);
>
> @@ -3585,6 +3625,7 @@ void set_extent_buffer_dirty(struct extent_buffer *=
eb)
>                         folio_lock(eb->folios[0]);
>                 for (int i =3D 0; i < num_extent_folios(eb); i++)
>                         btrfs_meta_folio_set_dirty(eb->folios[i], eb);
> +               buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
>                 if (subpage)
>                         folio_unlock(eb->folios[0]);
>                 percpu_counter_add_batch(&eb->fs_info->dirty_metadata_byt=
es,
> --
> 2.48.1
>
>

