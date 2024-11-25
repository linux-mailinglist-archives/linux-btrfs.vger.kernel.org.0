Return-Path: <linux-btrfs+bounces-9889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C339D8455
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8895128498A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F00F199920;
	Mon, 25 Nov 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFPW1ZYf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EE198A19;
	Mon, 25 Nov 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533835; cv=none; b=fIakfMI/NUr3d6YKdf8VPBSGLU+eudXUxQy7kbGkk6coV1qMa7rairQlFzd8zgYfP+WW/LQVe1FbueU5B/qu4+Bl5M6N8u9YkWB3mg/Y5/VFtr3jNpfM5ideFSHOBAmf0bD++cHjQ+uDBAxRPidMYWAlTY+/40VYj/Qtg077ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533835; c=relaxed/simple;
	bh=QIe/5SOpMVjZG/VSB2hYXMoS58PeMejgW8vGitpkatE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsGFLNuLRgQP1dFajzJZtZGx/7Qpp6Duz3AlSt1WJ9sxBdidmGhFAtKxpMg10qg1Xt1uGDlmLrA/rXHSdeHwilUpB2uho0U3cH6dDJ74dwg8c09E/xIt9NY1xYc9PLNpEZBeWX7IhmFBCpxKVpHKLdJwXOL9CoaKKAnwLodtX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFPW1ZYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C8AC4CED2;
	Mon, 25 Nov 2024 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732533835;
	bh=QIe/5SOpMVjZG/VSB2hYXMoS58PeMejgW8vGitpkatE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BFPW1ZYfPMW+dJ9yUROpIARNQCvXly4ohp5Qn5oUPqYo/oMIAuuEy+Fd+F2dtK4KF
	 Cx8V5FmxJ1l+90OevHuzoGOrNRPZhzJLN/XBx8ydbjw5AH1W/pr5i3AlG2A4QZyrTC
	 i6KrSC35TI7i2hsdGurUzFWeEpwp70llgz/LOdGntfZIQzmiSPe3UQRvnJ1FM8kbe2
	 Qnbi+zC0j1edy3hG89QU/gcojGG2MT3+PsASWdeVdAW5VQF2xHGZrw+IAcayRfQOGU
	 cwGdf4B1osx4D9hJifvN64OAmRnuJ297T2bRvjAZ6Ut+oox5+hTFAOMNt+aWxRou2N
	 ImGGIueEM6Ykg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so7345251fa.0;
        Mon, 25 Nov 2024 03:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9caofwsP06dogTk3vTvU6fXA5ErgbOUlorO742uIMxPnYvOPuHGGoKyxSpeQp9bI8Apw+AA/X@vger.kernel.org, AJvYcCX9jRtlHtoealj96o0nDgKISz8kHk/06roTUajKmuQr/VQ5O+PIIOZ8D2OyBe5UPAqLF5NuGNy2vLhqGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc6wFi0lg4Dr7gCrXjMKM23OKgdPcB+1VTUxey++4G8K5F/s/
	eU3+7EcIwBABLdhWj1+bIX1J8F1xDM+DQhoEzlm6whs/dV9kymG1sBSIJv3pMlZ3JxDSuYu+mTR
	PmQid4Cj4QFuC3r7kTkYExdiRMpU=
X-Google-Smtp-Source: AGHT+IFhv2d61B2RrHMhonRCF1TU0Ryh643ZspntrcDL5fPWsQD/5uEtjCXcqmPaftm7bstHbpjevf/xt6y0hB8K9Zs=
X-Received: by 2002:a2e:be9f:0:b0:2ff:c77c:c71e with SMTP id
 38308e7fff4ca-2ffc77cc9dfmr13078251fa.20.1732533833743; Mon, 25 Nov 2024
 03:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124123912.3335344-1-sashal@kernel.org> <20241124123912.3335344-13-sashal@kernel.org>
In-Reply-To: <20241124123912.3335344-13-sashal@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Nov 2024 11:23:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4n+7ZN228X9VGvgLX9S7cw5J27cJSGSiSCHjFbY9htLQ@mail.gmail.com>
Message-ID: <CAL3q7H4n+7ZN228X9VGvgLX9S7cw5J27cJSGSiSCHjFbY9htLQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 13/19] btrfs: reduce lock contention when eb
 cache miss for btree search
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Robbie Ko <robbieko@synology.com>, Filipe Manana <fdmanana@suse.com>, 
	David Sterba <dsterba@suse.com>, clm@fb.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 12:46=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> [ Upstream commit 99785998ed1cea142e20f4904ced26537a37bf74 ]

Why is this being picked for stable?

It's not a bug fix or anything critical.
It's just a performance optimization, and it's not even one where we
know (AFAIK) of any workload where it would give very significant
gains to justify backporting to stable.

Thanks.

>
> When crawling btree, if an eb cache miss occurs, we change to use the eb
> read lock and release all previous locks (including the parent lock) to
> reduce lock contention.
>
> If an eb cache miss occurs in a leaf and needs to execute IO, before this
> change we released locks only from level 2 and up and we read a leaf's
> content from disk while holding a lock on its parent (level 1), causing
> the unnecessary lock contention on the parent, after this change we
> release locks from level 1 and up, but we lock level 0, and read leaf's
> content from disk.
>
> Because we have prepared the check parameters and the read lock of eb we
> hold, we can ensure that no race will occur during the check and cause
> unexpected errors.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/ctree.c | 101 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 70 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0cc919d15b144..dd92acd66624f 100644
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
> +               ASSERT(ret =3D=3D -EAGAIN);
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
> 2.43.0
>
>

