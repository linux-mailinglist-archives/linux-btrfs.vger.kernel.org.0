Return-Path: <linux-btrfs+bounces-12686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCDA76531
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76EE188B283
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F91E260A;
	Mon, 31 Mar 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaBa+geq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C3FFD
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421862; cv=none; b=vGlH+IiG2yZcv0qywaXK0tLKj2+JaRA8DteR+8pUlDfG0mUsfvND9m1Dbfa8Rx11+TCfGZSvcjXDw24q8MNTOvlxMDDvoGLgOAksiRJXkGyNk80leJLmFoRxPHs28LZ04yjf5uoCIwZpBA/CEcpzKazWy+2FJIi7ecQC5fjZGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421862; c=relaxed/simple;
	bh=XjdU3Q9HGLSWkjqFmUt+QPPkToO5oRd+XqjZBAVIySw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJCpJ66d9QrDdfTPKyWoyWHl10xQvFgCPmPa4MIxWdC9wzbXKzbztACyIT2SBShQf4Ic/JGJ3Gynl/bmdeHycy16yk1RI+VGnA7J+qiyKPeCimNm+ZjQSQv+7ll18XZlfWyMzWyL65FlY7zHg8cX9sM4Rvc5NXudnSKq5mmITUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaBa+geq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF491C4CEE5
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743421861;
	bh=XjdU3Q9HGLSWkjqFmUt+QPPkToO5oRd+XqjZBAVIySw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aaBa+geqgX9gAn/2EpKJUHs/+E4o9V/n0X7JlDInmUNPBrDCS8j9nOKzs1GUcMp8c
	 aKvaaa7uHxgTH/qS5W79XETDcgu6Uw++rS6hz9oepYd5c8lh69Omjo7RyGcyUtp+bE
	 qKs8KzLVB++SmQiAXaKGDULqHn48W/Ovfb9nF98qi4pBdZWy321swJlvGF6kxiwl7t
	 f05pOBQalm4Q0xUK45C/AsPxifPFFlV/XNtn5Ode562pyL75Viw39/xqIjFs6SCXj2
	 5Lm97Wak1IxN2PfyBILaIMVNIfcjZkwRFtUQgJNN5/rjtUBS3B6bk1GFkfqkrArPXk
	 Y3OGhC+idfsIQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso762189266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 04:51:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxkK4CnRsjjLFBmkhQn24LbxIrbEQSoTfSasScAKH1H0SJoIhR
	49GNvN5FM6+zq4gAgNN0gEdGrDu0bkPoKx1bYQsgb+whibZe1ObH7KccC2meNv2CZQT/j95WCyp
	IYJKkBxP1usm6LmpZ3QEgMWz1/wc=
X-Google-Smtp-Source: AGHT+IEJ0PKvdd5s9Dbpgk657dm0+6BuiwLQmzmOk79h69Fa0TZQMQZZgojI+4IrNsELYOdjPuakqxdFS2G/mIYIPfM=
X-Received: by 2002:a17:907:7fa5:b0:ac4:16a:1863 with SMTP id
 a640c23a62f3a-ac738a50991mr785610766b.26.1743421860303; Mon, 31 Mar 2025
 04:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743239672.git.wqu@suse.com> <86cc5b6bd21e489ea6838b01bb0948c0a19b2cb5.1743239672.git.wqu@suse.com>
In-Reply-To: <86cc5b6bd21e489ea6838b01bb0948c0a19b2cb5.1743239672.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 31 Mar 2025 11:50:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5oaA67Ube5jekmstXh=80RY3UMWs9gkbA8BwK6-bWN_Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jqo26FiPJvzsXJCCQUx7JUlHIHjSpoj8PT9ZTSgJcRDEGROtfB9MfPAA2w
Message-ID: <CAL3q7H5oaA67Ube5jekmstXh=80RY3UMWs9gkbA8BwK6-bWN_Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] btrfs: prepare btrfs_punch_hole_lock_range() for
 large data folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 9:20=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The function btrfs_punch_hole_lock_range() needs to make sure there is
> no other folio in the range, thus it goes with filemap_range_has_page(),
> which works pretty fine.
>
> But if we have large folios, under the following case
> filemap_range_has_page() will always return true, forcing
> btrfs_punch_hole_lock_range() to do a very time consuming busy loop:
>
>         start                            end
>         |                                |
>   |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
>    \         /                         \   /
>     Folio A                            Folio B
>
> In above case, folio A and B contain our start/end indexes, and there
> are no other folios in the range.
> Thus we do not need to retry inside btrfs_punch_hole_lock_range().
>
> To prepare for large data folios, introduce a helper,
> check_range_has_page(), which will:
>
> - Shrink the search range towards page boundaries
>   If the rounded down end (exclusive, otherwise it can underflow when @en=
d
>   is inside the folio at file offset 0) is no larger than the rounded up
>   start, it means the range contains no other pages other than the ones
>   covering @start and @end.
>
>   Can return false directly in that case.
>
> - Grab all the folios inside the range
>
> - Skip any large folios that cover the start and end indexes
>
> - If any other folios are found return true
>
> - Otherwise return false
>
> This new helper is going to handle both large folios and regular ones.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 69 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a7afc55bab2a..bd0bb7aea99d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2159,11 +2159,29 @@ static int find_first_non_hole(struct btrfs_inode=
 *inode, u64 *start, u64 *len)
>         return ret;
>  }
>
> -static void btrfs_punch_hole_lock_range(struct inode *inode,
> -                                       const u64 lockstart,
> -                                       const u64 lockend,
> -                                       struct extent_state **cached_stat=
e)
> +/*
> + * The helper to check if there is no folio in the range.
> + *
> + * We can not utilized filemap_range_has_page() in a filemap with large =
folios
> + * as we can hit the following false positive:
> + *
> + *        start                            end
> + *        |                                |
> + *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
> + *   \         /                         \   /
> + *    Folio A                            Folio B
> + *
> + * That large folio A and B cover the start and end indexes.
> + * In that case filemap_range_has_page() will always return true, but th=
e above
> + * case is fine for btrfs_punch_hole_lock_range() usage.
> + *
> + * So here we only ensure that no other folios is in the range, excludin=
g the
> + * head/tail large folio.
> + */
> +static bool check_range_has_page(struct inode *inode, u64 start, u64 end=
)
>  {
> +       struct folio_batch fbatch;
> +       bool ret =3D false;
>         /*
>          * For subpage case, if the range is not at page boundary, we cou=
ld
>          * have pages at the leading/tailing part of the range.
> @@ -2174,17 +2192,47 @@ static void btrfs_punch_hole_lock_range(struct in=
ode *inode,
>          *
>          * And do not decrease page_lockend right now, as it can be 0.
>          */
> -       const u64 page_lockstart =3D round_up(lockstart, PAGE_SIZE);
> -       const u64 page_lockend =3D round_down(lockend + 1, PAGE_SIZE);
> +       const u64 page_lockstart =3D round_up(start, PAGE_SIZE);
> +       const u64 page_lockend =3D round_down(end+ 1, PAGE_SIZE);

Missing space between 'end' and '+ 1'.

> +       const pgoff_t start_index =3D page_lockstart >> PAGE_SHIFT;
> +       const pgoff_t end_index =3D (page_lockend - 1) >> PAGE_SHIFT;
> +       pgoff_t tmp =3D start_index;
> +       int found_folios;
>
> +       /* The same page or adjacent pages. */
> +       if (page_lockend <=3D page_lockstart)
> +               return false;
> +
> +       folio_batch_init(&fbatch);
> +       found_folios =3D filemap_get_folios(inode->i_mapping, &tmp, end_i=
ndex,
> +                                         &fbatch);
> +       for (int i =3D 0; i < found_folios; i++) {
> +               struct folio *folio =3D fbatch.folios[i];
> +
> +               /* A large folio begins before the start. Not a target. *=
/
> +               if (folio->index < start_index)
> +                       continue;

We passed start_index (via tmp) to filemap_get_folios(). Isn't the
function supposed to return folios only at an index >=3D start_index?
It's what the documentation says and the implementation seems to
behave that way too.

Removing that we could also use start_index to pass to
filemap_get_folios(), making it non-const, and remove the tmp
variable.

Either way it looks good and that's a minor thing:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               /* A large folio extends beyond the end. Not a target. */
> +               if (folio->index + folio_nr_pages(folio) > end_index)
> +                       continue;
> +               /* A folio doesn't cover the head/tail index. Found a tar=
get. */
> +               ret =3D true;
> +               break;
> +       }
> +       folio_batch_release(&fbatch);
> +       return ret;
> +}
> +
> +static void btrfs_punch_hole_lock_range(struct inode *inode,
> +                                       const u64 lockstart,
> +                                       const u64 lockend,
> +                                       struct extent_state **cached_stat=
e)
> +{
>         while (1) {
>                 truncate_pagecache_range(inode, lockstart, lockend);
>
>                 lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
>                             cached_state);
> -               /* The same page or adjacent pages. */
> -               if (page_lockend <=3D page_lockstart)
> -                       break;
>                 /*
>                  * We can't have ordered extents in the range, nor dirty/=
writeback
>                  * pages, because we have locked the inode's VFS lock in =
exclusive
> @@ -2195,8 +2243,7 @@ static void btrfs_punch_hole_lock_range(struct inod=
e *inode,
>                  * locking the range check if we have pages in the range,=
 and if
>                  * we do, unlock the range and retry.
>                  */
> -               if (!filemap_range_has_page(inode->i_mapping, page_lockst=
art,
> -                                           page_lockend - 1))
> +               if (!check_range_has_page(inode, lockstart, lockend))
>                         break;
>
>                 unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, locken=
d,
> --
> 2.49.0
>
>

