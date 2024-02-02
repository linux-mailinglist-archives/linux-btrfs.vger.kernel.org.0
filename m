Return-Path: <linux-btrfs+bounces-2063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148D846F49
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E201C21687
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418D140795;
	Fri,  2 Feb 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXybJVuy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5D13E215
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874090; cv=none; b=GCYy6qyEGeyVI3Jzr1uPY/CLCmDqlPRrdbPTwhsHg3AiTTs56SvMZNKvZt/JEUqGdXbc72CmNcCKR9ERTyDL+WWsTsBR5jWUJJIDVuOg+h7vo0WpFdySSPrjVXrOSv/VU4i8lrf7xbVek2uriALdS30okVpaDT5lQ04VA/eM06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874090; c=relaxed/simple;
	bh=e1IKlUgd6JHDvBF9B+oR0oNAlvKRpcX0JPrp7gYx1Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVUDHi3x9cF/FruIvgZj7YfHd65L2tST3V60zX5UuoVEPcrWVfRJLsaTLf/JNjd9LTqdJA8S23aNdKXjjgKI9jCo3DvitUarFkmMpVVXDDgR5ROAkoLc/wGrzdTP2CyO5eMvHxeZroPXWRZRr3AKNGwpR43UaCiVuKHfnC6wKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXybJVuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0C2C43390
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874089;
	bh=e1IKlUgd6JHDvBF9B+oR0oNAlvKRpcX0JPrp7gYx1Ec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXybJVuyRzKS4kRsMqA/4CYNcUWfFAgZUNYpjdU5W4m1VzbUklnDQSSsc4FqPQfev
	 O/BIObHFFbQXRYtRB9m/uAt/dLXbWnarVDP7Ip2Lyb16PaooW0uU0cFlaBxOiOkZxn
	 Qrc7DzQN0XzZcINgBpqagKK7RpXQsC9DEQIBduRp4QoNlA8WwMiBHFhZO6VjizFXha
	 Txd8E5C9Z93FhXWLcxT862Gn8d3gXUkFlRJl/0RSmZuFwmKVO9+sQszERL2BMY14ik
	 rQqi0Rt7X315rEBs0z5kOB+91UDujcgGp3hYa7zYRjKECVELjxM71jOhj9ajjnpjHQ
	 2axUyVRd/9ysg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a318ccfe412so224706166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 03:41:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yyn8w901OlLdSF/XvuryQQIV/3rBJXu5xBefxHYzlfirHczDAOP
	r80z+wglKz9G8rddMqIAir104fd7ev7Z3JdnrNK6rD1GD9Qa3v38biavWSz8OFUH450QGApR1Js
	rDpTOPu6U77e6N/WNC9ewafZjZNc=
X-Google-Smtp-Source: AGHT+IFbnGSakGtA9J+d+A/ZdOlWaCLDctsAafuvkJGIakrulqA+dGfcKfVVON0PJ4qCjqaj04Azz8T9y6sOaLsioJA=
X-Received: by 2002:a17:906:ad7:b0:a35:a3e2:edd3 with SMTP id
 z23-20020a1709060ad700b00a35a3e2edd3mr1422327ejf.59.1706874087719; Fri, 02
 Feb 2024 03:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47ac92a6c8be53a5e10add9315255460c062b52d.1706817512.git.josef@toxicpanda.com>
In-Reply-To: <47ac92a6c8be53a5e10add9315255460c062b52d.1706817512.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 Feb 2024 11:40:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7Dk0Ei=MFEyvt6P5Gz4WOn98KPhK7nhLgTOxyhc97hRA@mail.gmail.com>
Message-ID: <CAL3q7H7Dk0Ei=MFEyvt6P5Gz4WOn98KPhK7nhLgTOxyhc97hRA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock with fiemap and extent locking
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:59=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> While working on the patchset to remove extent locking I got a lockdep
> splat with fiemap and pagefaulting with my new extent lock replacement
> lock.
>
> This deadlock exists with our normal code, we just don't have lockdep
> annotations with the extent locking so we've never noticed it.
>
> Since we're copying the fiemap extent to user space on every iteration
> we have the chance of pagefaulting.  Because we hold the extent lock for
> the entire range we could mkwrite into a range in the file that we have
> mmap'ed.  This would deadlock with the following stack trace
>
> [<0>] lock_extent+0x28d/0x2f0
> [<0>] btrfs_page_mkwrite+0x273/0x8a0
> [<0>] do_page_mkwrite+0x50/0xb0
> [<0>] do_fault+0xc1/0x7b0
> [<0>] __handle_mm_fault+0x2fa/0x460
> [<0>] handle_mm_fault+0xa4/0x330
> [<0>] do_user_addr_fault+0x1f4/0x800
> [<0>] exc_page_fault+0x7c/0x1e0
> [<0>] asm_exc_page_fault+0x26/0x30
> [<0>] rep_movs_alternative+0x33/0x70
> [<0>] _copy_to_user+0x49/0x70
> [<0>] fiemap_fill_next_extent+0xc8/0x120
> [<0>] emit_fiemap_extent+0x4d/0xa0
> [<0>] extent_fiemap+0x7f8/0xad0
> [<0>] btrfs_fiemap+0x49/0x80
> [<0>] __x64_sys_ioctl+0x3e1/0xb50
> [<0>] do_syscall_64+0x94/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> I wrote an fstest to reproduce this deadlock without my replacement lock
> and verified that the deadlock exists with our existing locking.
>
> To fix this simply don't take the extent lock for the entire duration of
> the fiemap.  This is safe in general because we keep track of where we
> are when we're searching the tree, so if an ordered extent updates in
> the middle of our fiemap call we'll still emit the correct extents
> because we know what offset we were on before.
>
> The only place we maintain the lock is searching delalloc.  Since the
> delalloc stuff can change during writeback we want to lock the extent
> range so we have a consistent view of delalloc at the time we're
> checking to see if we need to set the delalloc flag.
>
> With this patch applied we no longer deadlock with my testcase.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, but just some minor comments below.

> ---
>  fs/btrfs/extent_io.c | 49 +++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8648ea9b5fb5..f8b68249d958 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2683,16 +2683,25 @@ static int fiemap_process_hole(struct btrfs_inode=
 *inode,
>          * it beyond i_size.
>          */
>         while (cur_offset < end && cur_offset < i_size) {
> +               struct extent_state *cached_state =3D NULL;
>                 u64 delalloc_start;
>                 u64 delalloc_end;
>                 u64 prealloc_start;
> +               u64 lockstart, lockend;

I think our preferred style is to declare one variable per line.
It also makes it consistent with the rest of the existing local code.

>                 u64 prealloc_len =3D 0;
>                 bool delalloc;
>
> +               lockstart =3D round_down(cur_offset,
> +                                      inode->root->fs_info->sectorsize);

As a single that would be 85 characters wide, still acceptable.

> +               lockend =3D round_up(end, inode->root->fs_info->sectorsiz=
e);
> +
> +               lock_extent(&inode->io_tree, lockstart, lockend, &cached_=
state);
>                 delalloc =3D btrfs_find_delalloc_in_range(inode, cur_offs=
et, end,
>                                                         delalloc_cached_s=
tate,
>                                                         &delalloc_start,
>                                                         &delalloc_end);
> +               unlock_extent(&inode->io_tree, lockstart, lockend,
> +                             &cached_state);

This can be made into a single line, as it's only 82 characters wide.

>                 if (!delalloc)
>                         break;
>
> @@ -2860,15 +2869,14 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                   u64 start, u64 len)
>  {
>         const u64 ino =3D btrfs_ino(inode);
> -       struct extent_state *cached_state =3D NULL;
>         struct extent_state *delalloc_cached_state =3D NULL;
>         struct btrfs_path *path;
>         struct fiemap_cache cache =3D { 0 };
>         struct btrfs_backref_share_check_ctx *backref_ctx;
>         u64 last_extent_end;
>         u64 prev_extent_end;
> -       u64 lockstart;
> -       u64 lockend;
> +       u64 align_start;
> +       u64 align_end;
>         bool stopped =3D false;
>         int ret;
>
> @@ -2879,12 +2887,11 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                 goto out;
>         }
>
> -       lockstart =3D round_down(start, inode->root->fs_info->sectorsize)=
;
> -       lockend =3D round_up(start + len, inode->root->fs_info->sectorsiz=
e);
> -       prev_extent_end =3D lockstart;
> +       align_start =3D round_down(start, inode->root->fs_info->sectorsiz=
e);
> +       align_end =3D round_up(start + len, inode->root->fs_info->sectors=
ize);
> +       prev_extent_end =3D align_start;
>
>         btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> -       lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>
>         ret =3D fiemap_find_last_extent_offset(inode, path, &last_extent_=
end);
>         if (ret < 0)
> @@ -2892,7 +2899,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>         btrfs_release_path(path);
>
>         path->reada =3D READA_FORWARD;
> -       ret =3D fiemap_search_slot(inode, path, lockstart);
> +       ret =3D fiemap_search_slot(inode, path, align_start);
>         if (ret < 0) {
>                 goto out_unlock;
>         } else if (ret > 0) {
> @@ -2904,7 +2911,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>                 goto check_eof_delalloc;
>         }
>
> -       while (prev_extent_end < lockend) {
> +       while (prev_extent_end < align_end) {
>                 struct extent_buffer *leaf =3D path->nodes[0];
>                 struct btrfs_file_extent_item *ei;
>                 struct btrfs_key key;
> @@ -2927,14 +2934,14 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                  * The first iteration can leave us at an extent item tha=
t ends
>                  * before our range's start. Move to the next item.
>                  */
> -               if (extent_end <=3D lockstart)
> +               if (extent_end <=3D align_start)
>                         goto next_item;
>
>                 backref_ctx->curr_leaf_bytenr =3D leaf->start;
>
>                 /* We have in implicit hole (NO_HOLES feature enabled). *=
/
>                 if (prev_extent_end < key.offset) {
> -                       const u64 range_end =3D min(key.offset, lockend) =
- 1;
> +                       const u64 range_end =3D min(key.offset, align_end=
) - 1;
>
>                         ret =3D fiemap_process_hole(inode, fieinfo, &cach=
e,
>                                                   &delalloc_cached_state,
> @@ -2949,7 +2956,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>                         }
>
>                         /* We've reached the end of the fiemap range, sto=
p. */
> -                       if (key.offset >=3D lockend) {
> +                       if (key.offset >=3D align_end) {
>                                 stopped =3D true;
>                                 break;
>                         }
> @@ -3043,29 +3050,40 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>         btrfs_free_path(path);
>         path =3D NULL;
>
> -       if (!stopped && prev_extent_end < lockend) {
> +       if (!stopped && prev_extent_end < align_end) {
>                 ret =3D fiemap_process_hole(inode, fieinfo, &cache,
>                                           &delalloc_cached_state, backref=
_ctx,
> -                                         0, 0, 0, prev_extent_end, locke=
nd - 1);
> +                                         0, 0, 0, prev_extent_end, align=
_end - 1);
>                 if (ret < 0)
>                         goto out_unlock;
> -               prev_extent_end =3D lockend;
> +               prev_extent_end =3D align_end;
>         }
>
>         if (cache.cached && cache.offset + cache.len >=3D last_extent_end=
) {
>                 const u64 i_size =3D i_size_read(&inode->vfs_inode);
>
>                 if (prev_extent_end < i_size) {
> +                       struct extent_state *cached_state =3D NULL;
>                         u64 delalloc_start;
>                         u64 delalloc_end;
> +                       u64 lockstart, lockend;

Same as before, one per line.

>                         bool delalloc;
>
> +                       lockstart =3D round_down(prev_extent_end,
> +                                              inode->root->fs_info->sect=
orsize);
> +                       lockend =3D round_up(i_size,
> +                                          inode->root->fs_info->sectorsi=
ze);
> +

With several places in the whole function now using
inode->root->fs_info->sectorsize, we could
have a:

const u64 sectorsize =3D inode->root->fs_info->sectorsize;

At the top level of the function and then use it and avoid multiple lines.

> +                       lock_extent(&inode->io_tree, lockstart, lockend,
> +                                   &cached_state);
>                         delalloc =3D btrfs_find_delalloc_in_range(inode,
>                                                                 prev_exte=
nt_end,
>                                                                 i_size - =
1,
>                                                                 &delalloc=
_cached_state,
>                                                                 &delalloc=
_start,
>                                                                 &delalloc=
_end);
> +                       unlock_extent(&inode->io_tree, lockstart, lockend=
,
> +                                     &cached_state);
>                         if (!delalloc)
>                                 cache.flags |=3D FIEMAP_EXTENT_LAST;
>                 } else {
> @@ -3076,7 +3094,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>         ret =3D emit_last_fiemap_cache(fieinfo, &cache);
>
>  out_unlock:
> -       unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state)=
;
>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>  out:
>         free_extent_state(delalloc_cached_state);
> --
> 2.43.0
>
>

