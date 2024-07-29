Return-Path: <linux-btrfs+bounces-6824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918F793F46C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8661C21F47
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A63145FED;
	Mon, 29 Jul 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNdf5ugc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8B817
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253647; cv=none; b=QUPeycutJADpQ/2yisZOX4xJV9pavahYUs3B6tBcKc0V/DPSWUQZauXKLEyzyyWqC8JbsutQyAZCG3e0Qfcx43x7EUU0hzteIjtl5alBCZJoTePDZf7KxWhH83NU8/N3bXPxMiQ5PexacyJQuDMv/FB7pMw9dqmQRK7oXkqY4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253647; c=relaxed/simple;
	bh=SBV+I2CChM6+9zoC1hl5JLzr0gs/P2MI8FVTZ978NCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If3Pqptqp1O6POHbdmm6idcxSGI9dQJiG7kJR1ho9Q+a5UcP1a8aFHpiJFmBB0VTcAMkMVfeilxCVnTML8aTm/KN90yefX8c3BmX1Q3W5Tih3A7IhqglE88cO0JSRTejVWFcnPSLs5xwVfImiSgPMIUfqJjncLabJGROghvJ8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNdf5ugc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660A0C32786
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722253647;
	bh=SBV+I2CChM6+9zoC1hl5JLzr0gs/P2MI8FVTZ978NCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eNdf5ugcEPXj1DPndFsCg70ABvHYea+VOgEPtMLtpHRwzU7GJgPD1F+Tc7LjYRRjE
	 6o0ZvwRd4CAgUnlH3jNMZa4cdJwUM/eWSTQc/23CnGrTqbL5v+E+50zeb931YD2gZY
	 wUAJ39WYLvaqdjoeKDH740zOAGfwDiD0REPO6550+VJmH2ffPpDaTc+z9wv6al5Dt5
	 BgTg3H+DSoHqPKd9NE8M+lcMZV/KbbjNr7c9K1C72iP5A/k6TlmmgZT8Q3wBz1cUuc
	 3LXyP1gZ8P2uZ5+Wh0+wWD0/D1Do9QKqPkJeH3YCd/0nwxnDl/pKayMv3jwzGoRkL2
	 CYK/vcEM8ZD4g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so2023131a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 04:47:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw15zprxlGUrnJxQ2qpwSrmfBEsriXonUrJ7IGghN3nuELCgf0K
	/sVe1FgyWgRlTv9her/8MBCzkHbm6zZnCbkafb/KmPqlkHql353ZU6tN3LleabehomIE9nNQXUS
	pu+pAXMZYxPpFZUo0cbXm37S70F0=
X-Google-Smtp-Source: AGHT+IEWQdAo57fp4ScLH6ugtz3w22+p8uHqw+Bbp6mq4+JSHqsBA4eQ1tFrOoGinH1PF8qWidr8Ykf/bRn2PhfRxC0=
X-Received: by 2002:a17:906:d551:b0:a7a:a3f7:389e with SMTP id
 a640c23a62f3a-a7d3fdb64c2mr611110466b.6.1722253645994; Mon, 29 Jul 2024
 04:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
In-Reply-To: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jul 2024 12:46:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
Message-ID: <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:33=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> __btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
> ro, and zone_unusable, but without taking the lock. It is mostly safe
> because they monotonically increase (at least for now) and this function =
is
> mostly called by a transaction commit, which is serialized by itself.
>
> Still, taking the lock is a safer and correct option and I'm going to add=
 a
> change to reset zone_unusable while a block group is still alive. So, add
> locking around the operations.
>
> Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/free-space-cache.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index f5996a43db24..51263d6dac36 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct bt=
rfs_block_group *block_group,
>         u64 offset =3D bytenr - block_group->start;
>         u64 to_free, to_unusable;
>         int bg_reclaim_threshold =3D 0;
> -       bool initial =3D ((size =3D=3D block_group->length) && (block_gro=
up->alloc_offset =3D=3D 0));
> +       bool initial;
>         u64 reclaimable_unusable;
>
> -       WARN_ON(!initial && offset + size > block_group->zone_capacity);
> +       guard(spinlock)(&block_group->lock);

What's this guard thing and why do we use it only here? We don't use
it anywhere else in btrfs' code base.
A quick search in the Documentation directory of the kernel and I
can't find anything there.
In the fs/ directory there's only two users of it.

Why not the usual spin_lock(&block_group->lock) call?

>
> +       initial =3D ((size =3D=3D block_group->length) && (block_group->a=
lloc_offset =3D=3D 0));
> +       WARN_ON(!initial && offset + size > block_group->zone_capacity);
>         if (!initial)
>                 bg_reclaim_threshold =3D READ_ONCE(sinfo->bg_reclaim_thre=
shold);
>
> -       spin_lock(&ctl->tree_lock);
>         if (!used)
>                 to_free =3D size;
>         else if (initial)
> @@ -2718,7 +2719,9 @@ static int __btrfs_add_free_space_zoned(struct btrf=
s_block_group *block_group,
>                 to_free =3D offset + size - block_group->alloc_offset;
>         to_unusable =3D size - to_free;
>
> -       ctl->free_space +=3D to_free;
> +       scoped_guard(spinlock, &ctl->tree_lock) {
> +               ctl->free_space +=3D to_free;
> +       }

Can you clarify (in the changelog) why is the locking so unusual here
by using these guard() things? Do we really need it, what do we gain
from it?

>         /*
>          * If the block group is read-only, we should account freed space=
 into
>          * bytes_readonly.
> @@ -2727,15 +2730,13 @@ static int __btrfs_add_free_space_zoned(struct bt=
rfs_block_group *block_group,
>                 block_group->zone_unusable +=3D to_unusable;
>                 WARN_ON(block_group->zone_unusable > block_group->length)=
;
>         }
> -       spin_unlock(&ctl->tree_lock);
>         if (!used) {
> -               spin_lock(&block_group->lock);
>                 block_group->alloc_offset -=3D size;
> -               spin_unlock(&block_group->lock);
>         }
>
>         reclaimable_unusable =3D block_group->zone_unusable -
>                                (block_group->length - block_group->zone_c=
apacity);
> +

Stray new line, unrelated to the change.

Thanks.


>         /* All the region is now unusable. Mark it as unused and reclaim =
*/
>         if (block_group->zone_unusable =3D=3D block_group->length) {
>                 btrfs_mark_bg_unused(block_group);
> --
> 2.45.2
>
>

