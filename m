Return-Path: <linux-btrfs+bounces-12097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25AA56A74
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 15:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FE11675AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622821B8F6;
	Fri,  7 Mar 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5oR9n9V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4201547C0
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358050; cv=none; b=qou0QY8azNwLhPY/OvcpfaBvlzdZRjcRo/YWSc9NiRlVyrcj5Io+hTKSmy3g6XAfxDi8pfZ2NnMgko3v+Q9Wg+iBQ7/5YGopC1Wf4ai+bcsWjvh/RGMW5LO1/lbvAvP8UnLW5xYVClRgAxWHi9fLrVOV5u1BjliMBaEdeaPk2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358050; c=relaxed/simple;
	bh=VSySF5XRbCck3YIfvfbRC/ljcS7MjheK3uN5pwTiig4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b92aEh9bL81a6x0HGy4x3/zI2h+Cw6DbAxg/Qmq1MBT25aXxuNsIRt2b6NKUAh3MyJiT9DCa/1ZKTLqWAAUakuB0fTtYYQjHsYPaa4YmmZGHUNzkATARQ/7Yh/MBBtwyr0enItM0MBZdIDzKWHlR9hGgjGQg39NWIihhQ2PCqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5oR9n9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334E9C4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741358050;
	bh=VSySF5XRbCck3YIfvfbRC/ljcS7MjheK3uN5pwTiig4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a5oR9n9VMxx30Y3vq4+ZwrOhesPWVOpyasab3EdjSNEt4Mu9FGFC3CNse5J/wK9Jq
	 aLWBGfUwH22AAx2sV7wqoVZvFbDfgm7CaL+yMEDXzIkkE/I2DhiwVoTPBO2PEHWED1
	 8SA0fQ02UUb9xL9NfkJwwIsbsLaW1u8uRctK76GD/YEJMnDX9mzfd75oRE2wMoKiga
	 n/Vegf60shN93De4aH102Lq/t8CAhGJPYgl49hn7IT/EBQaRusRU/5dLfStReYKM9U
	 TwNULIxcyDBmiNE1mMYF/5d9ptIrBespum2474TWk0bsmZIBia3j7ymJTqysuiAgbS
	 1dJ2SYJumty1g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac256f4b3ecso130076966b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 06:34:10 -0800 (PST)
X-Gm-Message-State: AOJu0YzsxvJ9IQo6u4EjAsgksvSYeJuR6304JISjwFrg7WS4QnY1SJqI
	IrlUAOVn0E5YaUK25WoNK4w8yGaoCLzlFUSXb+Lu9NCu22J9vA5WvapOHgJBo4u8Cge+Xp3Uh2j
	j7+qBLXlxCQcrWGdHu1UW98TPTdQ=
X-Google-Smtp-Source: AGHT+IFxgA7KiqWUmnfwCVe7yvjRQu0bkQeyhWM2AvwSql8SZ3341JkKfxxwW43zgwD2cv/fFcXTzmF0HHPQjCP1Pcs=
X-Received: by 2002:a17:906:59a1:b0:ac1:415c:29df with SMTP id
 a640c23a62f3a-ac24e8a57acmr426660666b.5.1741358048721; Fri, 07 Mar 2025
 06:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <ab8a6f9b2e3ce6ee7196a481233956ea9629b7b8.1741306938.git.boris@bur.io>
In-Reply-To: <ab8a6f9b2e3ce6ee7196a481233956ea9629b7b8.1741306938.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 14:33:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6OtZprU8NSUu4DWov=9pZPCduHoSC9_h6YcUnVys9FsA@mail.gmail.com>
X-Gm-Features: AQ5f1JqI78l5j3k8wr3pfzlKYlJf-99Rkil6IInE0QpCzwHR1lzxvtzv8IHMMC4
Message-ID: <CAL3q7H6OtZprU8NSUu4DWov=9pZPCduHoSC9_h6YcUnVys9FsA@mail.gmail.com>
Subject: Re: [PATCH 3/5] btrfs: make discard_workfn block_group ref explicit
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> Currently, the async discard machinery owns a ref to the block_group
> when the block_group is queued on a discard list. However, to handle
> races with discard cancellation and the discard workfn, we have some
> cute logic to detect that the block_group is *currently* running in the
> workfn, to protect the workfn's usage amidst cancellation.
>
> As far as I can tell, this doesn't have any overt bugs (though
> finish_discard_pass and remove_from_discard_list racing can have a
> surprising outcome for the caller of remove_from_discard_list in that it
> is again added at the end)
>
> But it is needlessly complicated to rely on locking and the nullity of
> discard_ctl->block_group. Simplify this significantly by just taking a
> refcount while we are in the workfn and uncondtionally drop it in both
> the remove and workfn paths, regardless of if they race.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/discard.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index e815d165cccc..d6eef4bd9e9d 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -167,13 +167,7 @@ static bool remove_from_discard_list(struct btrfs_di=
scard_ctl *discard_ctl,
>         block_group->discard_eligible_time =3D 0;
>         queued =3D !list_empty(&block_group->discard_list);
>         list_del_init(&block_group->discard_list);
> -       /*
> -        * If the block group is currently running in the discard workfn,=
 we
> -        * don't want to deref it, since it's still being used by the wor=
kfn.
> -        * The workfn will notice this case and deref the block group whe=
n it is
> -        * finished.
> -        */
> -       if (queued && !running)
> +       if (queued)
>                 btrfs_put_block_group(block_group);
>
>         spin_unlock(&discard_ctl->lock);
> @@ -260,9 +254,10 @@ static struct btrfs_block_group *peek_discard_list(
>                         block_group->discard_cursor =3D block_group->star=
t;
>                         block_group->discard_state =3D BTRFS_DISCARD_EXTE=
NTS;
>                 }
> -               discard_ctl->block_group =3D block_group;
>         }
>         if (block_group) {
> +               btrfs_get_block_group(block_group);
> +               discard_ctl->block_group =3D block_group;
>                 *discard_state =3D block_group->discard_state;
>                 *discard_index =3D block_group->discard_index;
>         }
> @@ -493,9 +488,20 @@ static void btrfs_discard_workfn(struct work_struct =
*work)
>
>         block_group =3D peek_discard_list(discard_ctl, &discard_state,
>                                         &discard_index, now);
> -       if (!block_group || !btrfs_run_discard_work(discard_ctl))
> +       if (!block_group)
>                 return;
> +       if (!btrfs_run_discard_work(discard_ctl)) {
> +               spin_lock(&discard_ctl->lock);
> +               btrfs_put_block_group(block_group);
> +               discard_ctl->block_group =3D NULL;
> +               spin_unlock(&discard_ctl->lock);
> +               return;
> +       }
>         if (now < block_group->discard_eligible_time) {
> +               spin_lock(&discard_ctl->lock);
> +               btrfs_put_block_group(block_group);
> +               discard_ctl->block_group =3D NULL;
> +               spin_unlock(&discard_ctl->lock);
>                 btrfs_discard_schedule_work(discard_ctl, false);
>                 return;
>         }
> @@ -547,15 +553,7 @@ static void btrfs_discard_workfn(struct work_struct =
*work)
>         spin_lock(&discard_ctl->lock);
>         discard_ctl->prev_discard =3D trimmed;
>         discard_ctl->prev_discard_time =3D now;
> -       /*
> -        * If the block group was removed from the discard list while it =
was
> -        * running in this workfn, then we didn't deref it, since this fu=
nction
> -        * still owned that reference. But we set the discard_ctl->block_=
group
> -        * back to NULL, so we can use that condition to know that now we=
 need
> -        * to deref the block_group.
> -        */
> -       if (discard_ctl->block_group =3D=3D NULL)
> -               btrfs_put_block_group(block_group);
> +       btrfs_put_block_group(block_group);
>         discard_ctl->block_group =3D NULL;
>         __btrfs_discard_schedule_work(discard_ctl, now, false);
>         spin_unlock(&discard_ctl->lock);
> --
> 2.48.1
>
>

