Return-Path: <linux-btrfs+bounces-8929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722199E31D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB801C21C9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B71DF25F;
	Tue, 15 Oct 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeJcmpt9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABC7F7FC
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985907; cv=none; b=F019KY90DV2jTlhXaHnwbY0SZfRfLt0X8AyeDlMfcsU1uJj6TdgtSVlQLd2a6ecasAAfys7SX8XskYTYobOuYl/oN54Jl4H8o8sBIIKHEgj8wRDEMrBrgawfq8nrVyjbJGvfQ7GJFljVmHFXZEza5d+q80+RTaAfhCE/DAxjAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985907; c=relaxed/simple;
	bh=eUuMkebMeU5G0l3sMPUCiHuysyrn/A8rSllezjAamN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgb+XvDeivq8I3G6wR7jH8eHVTToqylhmAS3xX9qb2vzkyUjEa+mKE+aCbZ2gN21icHODfivjPEOFUqvVaAmEB84fAvpUPHl8inLTZDPo6KWsYxighzsADMueqQ9yL5h49KwtS79LHfmoLUEQilEXKKLFGjiMjtlsKbwoT6wZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeJcmpt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E647C4CEC6
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728985907;
	bh=eUuMkebMeU5G0l3sMPUCiHuysyrn/A8rSllezjAamN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OeJcmpt9wQevl1MIPWHSczSbwcDqD/kggVIELxwHQtiV9oylNytLMbtaFdL5echNH
	 ysuLtNqbcLeGTt1La5wHx0XRTJNwZMqPVIv3zniESbxg+0zWYWPTaJPVxEfAvoOo7y
	 Tl5E5Sgrt2gNrLYJ9/gu0+rJYMRlts+0C5j5ZRA+s6++xaPgu2RIxEELN61dt41pIf
	 PcregRKMguD7MkBVuEHkigkXw7K1c0v8jXShoKfuVCEeotI54CLrEM5vgke8QRhoYF
	 y792kLqvobT4APrWXkW+VQOnWPXK4yWMF8ix/mXgFdBns8K/FD2bPjrVuN1GVrB7Fw
	 kTlobUCaTAVrg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso25723991fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 02:51:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0mlYzaXsT/BgyuCDWt4ZJw8c8+prtVaTnD6ctgJbdgnHKYpB9
	67WVi4d4+EAXmofxC2b8JwNx7bhn05BZ7rMgJJgd3O15OQ5IItbECAxW6RFGnoloE0iQ/KN+/mE
	gTWlySu+UFkNzyxAhTk+UUXtuTdA=
X-Google-Smtp-Source: AGHT+IHnQ+uxoJPGa7iDu0qDr2LYx0mJezkZPOmJgilCQIPlI8+4lsgyzUI/x5hmjt9RGPahcUc599LGt45OqzwJbmY=
X-Received: by 2002:a05:651c:546:b0:2fb:2a96:37fd with SMTP id
 38308e7fff4ca-2fb3f2c518dmr56102881fa.29.1728985905841; Tue, 15 Oct 2024
 02:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015074137.26067-1-robbieko@synology.com>
In-Reply-To: <20241015074137.26067-1-robbieko@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 15 Oct 2024 10:51:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5L85QJ1_6xax6fw+tnWwaVm8Y7FjzTC94_gTvfDoY7rQ@mail.gmail.com>
Message-ID: <CAL3q7H5L85QJ1_6xax6fw+tnWwaVm8Y7FjzTC94_gTvfDoY7rQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: reduce lock contention when eb cache miss for
 btree search
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:41=E2=80=AFAM robbieko <robbieko@synology.com> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When crawling btree, if an eb cache miss occurs, we change to use
> the eb read lock and release all previous locks (include parent lock)
> to reduce lock contention.
>
> If a eb cache miss occurs in a leaf and needs to execute IO, before
> this change we released locks only from level 2 and up and we
> read a leaf's content from disk while holding a lock on its parent
> (level 1), causing the unnecessary lock contention on the parent,
> after this change we release locks from level 1 and up, but we lock
> level 0, and read leaf's content from disk.
>
> Because we have prepared the check parameters and the read lock
> of eb we hold, we can ensure that no race will occur during the check
> and cause unexpected errors.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
> v3: Improve the change log, and change variable named
> v2: Add skip_locking handle
>  fs/btrfs/ctree.c | 101 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 70 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0cc919d15b14..dc1d4e05214a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1515,12 +1515,14 @@ read_block_for_search(struct btrfs_root *root, st=
ruct btrfs_path *p,
>         struct btrfs_tree_parent_check check =3D { 0 };
>         u64 blocknr;
>         u64 gen;
> -       struct extent_buffer *tmp;
> -       int ret;
> +       struct extent_buffer *tmp =3D NULL;
> +       int ret =3D 0;
>         int parent_level;
> -       bool unlock_up;
> +       int err;
> +       bool read_tmp =3D false;
> +       bool tmp_locked =3D false;
> +       bool path_released =3D false;
>
> -       unlock_up =3D ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + =
1]);
>         blocknr =3D btrfs_node_blockptr(*eb_ret, slot);
>         gen =3D btrfs_node_ptr_generation(*eb_ret, slot);
>         parent_level =3D btrfs_header_level(*eb_ret);
> @@ -1551,68 +1553,105 @@ read_block_for_search(struct btrfs_root *root, s=
truct btrfs_path *p,
>                          */
>                         if (btrfs_verify_level_key(tmp,
>                                         parent_level - 1, &check.first_ke=
y, gen)) {
> -                               free_extent_buffer(tmp);
> -                               return -EUCLEAN;
> +                               ret =3D -EUCLEAN;
> +                               goto out;
>                         }
>                         *eb_ret =3D tmp;
> -                       return 0;
> +                       tmp =3D NULL;
> +                       ret =3D 0;
> +                       goto out;
>                 }
>
>                 if (p->nowait) {
> -                       free_extent_buffer(tmp);
> -                       return -EAGAIN;
> +                       ret =3D -EAGAIN;
> +                       goto out;
>                 }
>
> -               if (unlock_up)
> +               if (!p->skip_locking) {
>                         btrfs_unlock_up_safe(p, level + 1);
> -
> -               /* now we're allowed to do a blocking uptodate check */
> -               ret =3D btrfs_read_extent_buffer(tmp, &check);
> -               if (ret) {
> -                       free_extent_buffer(tmp);
> +                       tmp_locked =3D true;
> +                       btrfs_tree_read_lock(tmp);
>                         btrfs_release_path(p);
> -                       return ret;
> +                       ret =3D -EAGAIN;
> +                       path_released =3D true;
>                 }
>
> -               if (unlock_up)
> -                       ret =3D -EAGAIN;
> +               /* Now we're allowed to do a blocking uptodate check. */
> +               err =3D btrfs_read_extent_buffer(tmp, &check);
> +               if (err) {
> +                       ret =3D err;
> +                       goto out;
> +               }
>
> +               if (ret =3D=3D 0) {
> +                       ASSERT(!tmp_locked);
> +                       *eb_ret =3D tmp;
> +                       tmp =3D NULL;
> +               }
>                 goto out;
>         } else if (p->nowait) {
> -               return -EAGAIN;
> +               ret =3D -EAGAIN;
> +               goto out;
>         }
>
> -       if (unlock_up) {
> +       if (!p->skip_locking) {
>                 btrfs_unlock_up_safe(p, level + 1);
>                 ret =3D -EAGAIN;
> -       } else {
> -               ret =3D 0;
>         }
>
>         if (p->reada !=3D READA_NONE)
>                 reada_for_search(fs_info, p, level, slot, key->objectid);
>
> -       tmp =3D read_tree_block(fs_info, blocknr, &check);
> +       tmp =3D btrfs_find_create_tree_block(fs_info, blocknr, check.owne=
r_root, check.level);
>         if (IS_ERR(tmp)) {
> +               ret =3D PTR_ERR(tmp);
> +               tmp =3D NULL;
> +               goto out;
> +       }
> +       read_tmp =3D true;
> +
> +       if (!p->skip_locking) {
> +               ASSERT(ret);

We can be more explicit here and do instead:

ASSERT(ret =3D=3D -EAGAIN);

The patch looks good to me, and I'll soon add it to the for-next
branch, after some testing, with that small change if you're ok with
it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               tmp_locked =3D true;
> +               btrfs_tree_read_lock(tmp);
>                 btrfs_release_path(p);
> -               return PTR_ERR(tmp);
> +               path_released =3D true;
> +       }
> +
> +       /* Now we're allowed to do a blocking uptodate check. */
> +       err =3D btrfs_read_extent_buffer(tmp, &check);
> +       if (err) {
> +               ret =3D err;
> +               goto out;
>         }
> +
>         /*
>          * If the read above didn't mark this buffer up to date,
>          * it will never end up being up to date.  Set ret to EIO now
>          * and give up so that our caller doesn't loop forever
>          * on our EAGAINs.
>          */
> -       if (!extent_buffer_uptodate(tmp))
> +       if (!extent_buffer_uptodate(tmp)) {
>                 ret =3D -EIO;
> +               goto out;
> +       }
>
> -out:
>         if (ret =3D=3D 0) {
> +               ASSERT(!tmp_locked);
>                 *eb_ret =3D tmp;
> -       } else {
> -               free_extent_buffer(tmp);
> -               btrfs_release_path(p);
> +               tmp =3D NULL;
> +       }
> +out:
> +       if (tmp) {
> +               if (tmp_locked)
> +                       btrfs_tree_read_unlock(tmp);
> +               if (read_tmp && ret && ret !=3D -EAGAIN)
> +                       free_extent_buffer_stale(tmp);
> +               else
> +                       free_extent_buffer(tmp);
>         }
> +       if (ret && !path_released)
> +               btrfs_release_path(p);
>
>         return ret;
>  }
> @@ -2198,7 +2237,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                 }
>
>                 err =3D read_block_for_search(root, p, &b, level, slot, k=
ey);
> -               if (err =3D=3D -EAGAIN)
> +               if (err =3D=3D -EAGAIN && !p->nowait)
>                         goto again;
>                 if (err) {
>                         ret =3D err;
> @@ -2325,7 +2364,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, =
const struct btrfs_key *key,
>                 }
>
>                 err =3D read_block_for_search(root, p, &b, level, slot, k=
ey);
> -               if (err =3D=3D -EAGAIN)
> +               if (err =3D=3D -EAGAIN && !p->nowait)
>                         goto again;
>                 if (err) {
>                         ret =3D err;
> --
> 2.17.1
>
>

