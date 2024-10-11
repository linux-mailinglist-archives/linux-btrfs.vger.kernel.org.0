Return-Path: <linux-btrfs+bounces-8854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB299A3EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 14:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED871F22F30
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AE21858D;
	Fri, 11 Oct 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDYgX91Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CA1CDFA6
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649851; cv=none; b=PJlNrfr8fOrulkKLRTCAcHFO6I3IswwUT7B9tZGzLkb3FpkG7KAorzWEI2V2jtb5DtzyrE6kwJywIhlY656IERV21autyjA5jlEz0Nhd8hHS1nQ422tQh0448QP9ZfPHUvRGCK0/d2kfLpEoYpM2MN14/S3EoIqGc1GvLc6j8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649851; c=relaxed/simple;
	bh=HZbNKGpZvBzS5FycUg3VRiAPH8Df1NpTQ9Muz1SZokc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGMhc4K1KbAi1gICw6/SM9D5+yszxTPvr03+9d1o1jSW/3+QrHNPOjOlLtFHzWRaDYiDWLdDLX4ShYyP/CD0PyXY3SKr/YHDoJF/EFJO6S68K404WvfTeaR4NyXeFEzjXjjdUjpvEZk1vPoE7aReLsenHQWaOkwNiIcLIKhtd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDYgX91Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7CEC4CECE
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649851;
	bh=HZbNKGpZvBzS5FycUg3VRiAPH8Df1NpTQ9Muz1SZokc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YDYgX91ZJgjRCXXsOzLn3sUHEx35J4jumirne0DrfFaycCy/Rl3yCS+zWogaqdPlc
	 RCtBVY8DIn01J78+TTLbKKm7YPsD9I+71iXlQSGdu7lYnmVLSD4bBqV9f6aTzfmKXq
	 AUHwYD8f3urDLpZ/BlWec7+/VsauHyAbAXmrVkYEclOwd41vh90BCGCfYIp0MWYsYq
	 6Ct2mXsa9m5xxC9XGbpShXf+slRFvFS0MU7tpOB5xojFUrR6i4ep8o97LbdytSA/3W
	 6Tuil/DxQXEMGSFpXzZUZ0vLQ6WvYMbliJDHZAbfZPGHgZh/0VFJFglllz/9SCrVHN
	 xoYSDiTD0aHPg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e044d32bso691521e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 05:30:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YxwTQHc0zp+7/IElJHOP4TIj8y42erxR/d9nAT+A8u8Gn4NB0+2
	hlxQ1R9cC75nPHQmS0sqNqfrqnsLRTBud/ZAd2h0+cZdqfSCXAoLd340Yd2GFJZ/B51xYGjx6NJ
	M91Lir5yUccUtn08yq1Url7xej+I=
X-Google-Smtp-Source: AGHT+IGDq1tMbCS6AqyBXWUj/HTn2GAFFF87C60Wme8JDFzLQxZ5/LcTik99NIqLsf11D0XZ76kRCpqQ9yERRtoQkOY=
X-Received: by 2002:ac2:4e10:0:b0:539:94b7:d6de with SMTP id
 2adb3069b0e04-539da4e258bmr1256459e87.30.1728649849227; Fri, 11 Oct 2024
 05:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011034502.24009-1-robbieko@synology.com>
In-Reply-To: <20241011034502.24009-1-robbieko@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 11 Oct 2024 13:30:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H40m71s8oKxkzFr4SCpNSqFp8wkx6BhtmwFjKaSPLJfwA@mail.gmail.com>
Message-ID: <CAL3q7H40m71s8oKxkzFr4SCpNSqFp8wkx6BhtmwFjKaSPLJfwA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reduce lock contention when eb cache miss for
 btree search
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:54=E2=80=AFAM robbieko <robbieko@synology.com> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When crawling btree, if an eb cache miss occurs, we change to use
> the eb read lock and release all previous locks to reduce lock contention=
.
>
> Because we have prepared the check parameters and the read lock
> of eb we hold, we can ensure that no race will occur during the check
> and cause unexpected errors.

So this is a bit too terse, in your reply to my questions for the v1
patch, you gave a much better explanation, that this reduces lock
contention on nodes at level 1.

Before this change we released locks only from level 2 and up and we
read a leaf's content from disk while holding a lock on its parent
(level 1), causing the unnecessary lock contention on the parent.
Please include that in the change log, it makes everything a lot clear.

>
> v2:
> * Add skip_locking handle

Information about patch version and what changed doesn't belong here,
it's pointless to have in the git log since the previous version isn't
in git.

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---

The patch version and what changed information belongs here, after the
---, which causes 'git am' to drop it.

>  fs/btrfs/ctree.c | 104 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 72 insertions(+), 32 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0cc919d15b14..ad3e734f09f6 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1515,12 +1515,15 @@ read_block_for_search(struct btrfs_root *root, st=
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
> +       bool create =3D false;

So this is better named as "read_tmp", because it's used to indicate
that we are reading the tmp extent buffer's pages from disk.

> +       bool lock =3D false;

And here naming it as "tmp_locked", because it's used to indicate if
we have locked the tmp extent buffer.
As it is named, "lock", is a bit too vague and gives the idea it means
to lock something later on after some condition is met.

> +       bool skip_locking =3D p->skip_locking;

This is unnecessary, we never change it and we can simply use
p->skip_locking directly, as it never changes too and makes it clear
it comes from the path when reading code below.

> +       bool path_released =3D false;
>
> -       unlock_up =3D ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + =
1]);
>         blocknr =3D btrfs_node_blockptr(*eb_ret, slot);
>         gen =3D btrfs_node_ptr_generation(*eb_ret, slot);
>         parent_level =3D btrfs_header_level(*eb_ret);
> @@ -1551,68 +1554,105 @@ read_block_for_search(struct btrfs_root *root, s=
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
> +               if (!skip_locking) {
>                         btrfs_unlock_up_safe(p, level + 1);
> -
> -               /* now we're allowed to do a blocking uptodate check */
> -               ret =3D btrfs_read_extent_buffer(tmp, &check);
> -               if (ret) {
> -                       free_extent_buffer(tmp);
> +                       lock =3D true;
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
> +               if (!ret) {

To be consistent with the rest of the function's code, and because
it's an integer and not a boolean, the style "ret =3D=3D 0" would be more
clear.

> +                       ASSERT(!lock);
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
> +       if (!skip_locking) {
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
> +       create =3D true;
> +
> +       if (!skip_locking) {
> +               ASSERT(ret);
> +               lock =3D true;
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
> -       if (ret =3D=3D 0) {
> +       if (!ret) {

And leave the original "ret =3D=3D 0", it was just fine, easier, more
direct to read, as it makes it clear it's an integer and not a boolean
type.

Otherwise it looks fine, thanks.

> +               ASSERT(!lock);
>                 *eb_ret =3D tmp;
> -       } else {
> -               free_extent_buffer(tmp);
> -               btrfs_release_path(p);
> +               tmp =3D NULL;
> +       }
> +out:
> +       if (tmp) {
> +               if (lock)
> +                       btrfs_tree_read_unlock(tmp);
> +               if (create && ret && ret !=3D -EAGAIN)
> +                       free_extent_buffer_stale(tmp);
> +               else
> +                       free_extent_buffer(tmp);
>         }
> +       if (ret && !path_released)
> +               btrfs_release_path(p);
>
>         return ret;
>  }
> @@ -2198,7 +2238,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
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
> @@ -2325,7 +2365,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, =
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

