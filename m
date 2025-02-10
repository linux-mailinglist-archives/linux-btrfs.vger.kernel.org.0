Return-Path: <linux-btrfs+bounces-11359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E71A2EABF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 12:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8174A1883DD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006691E3DEB;
	Mon, 10 Feb 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULM1k4ty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC301E376C;
	Mon, 10 Feb 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185823; cv=none; b=O3yR+v+Px8hA2W7YSZWGIKH8MX87T47/5bxXf0uUCQz3i+o4A91XvrE855WxPdvmMM4Urp32GVfg1+S1ohjoJrj7VUnUnawjxia2+dOJBUpLnveUCpScbF4qpyhZ+QevDviHFI81Rf/1IxC+fZWzl8/9rsBNtfbyQdtLiTtNL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185823; c=relaxed/simple;
	bh=omkxE/xwllUPIeBKBVlFqZT7mgut+b/W8IgvwVyzHkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrqnpXAv0F+3hfnOJN4b44GDebWzaMNPd2fTPKTtJi5sxqrETLmGKNexNMmvwmmnLGEPorb5wQw3/bAborJI5bvzfJYDt+hQHN7rY3tQt3+QYFEdCItsjOfGWQgUlZs2wZMhltXdICayCIybc5vx2KkKLlCVYilJNJDQ8D3bPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULM1k4ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7542BC4AF09;
	Mon, 10 Feb 2025 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739185822;
	bh=omkxE/xwllUPIeBKBVlFqZT7mgut+b/W8IgvwVyzHkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ULM1k4tyJQzgd1az0I4N/ZLrFBLfq5mLDS/SbZFx6PgwC0q86B+1Yg5weVDYwELg6
	 k1GUbHVg6uOZbTqPQZIIpS7U34x0DnLl/vvrHOnexg4XIx1pBGvvtg2Gh4rTsQQI7w
	 lJyLE1EGgW3oOK9Oz98vhZ0whRFq+EF9bSod+b/tk5Su8OknEyNDjO2ORgPFc1e3qp
	 aLTSCnsuYK5Ff7GF39I9zniZ1HV4AYm77IEJee3ODYgC0+s+XDdyML3HSTRcvJqCC8
	 HOvAOQcObYuaQ+Qv5zBYCn1cuUZqEGsc4kxRqLLrBdwExvNKEjS1Kme89wybeILQd5
	 322aezhz8WoKQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de7531434fso1871858a12.0;
        Mon, 10 Feb 2025 03:10:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrhMHDYoSRyPMXyySgQUD13HfEsrxslAR8KR1PgQEo+mZolJDe/N5rx6xaZI9toKglx9YRzaYWRvpTUg==@vger.kernel.org, AJvYcCWvwTX52RIdgyBCq2kpinx9CptrnxOm7LuDbnPHq1s96DR3KILhsVRFg3HEbbOZOBVXq+ckHnYBcoB80CDd@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlYUZqNMpQCzblDvq7efTPor9XDOTsmY/YZ5We/N6rEBHPOTM
	p8Eulh3XuTrFcV5VjcLhsOoX2IfQ7w5eZUYwnZF8VKxOW3MFlw/FhY0w6wohEpEnr7ICFGidiZM
	Ouu9x9BN1jNZlMl5cqri8HI+39ZY=
X-Google-Smtp-Source: AGHT+IF1UTVbamBg5wE45A1gdtdNpPEpauLTl5jx+z/pS6BWz87JkK2Vxf79aitOA+9XmbRQLFYwB3I4+Kbafh/Efx4=
X-Received: by 2002:a17:907:3f0f:b0:aab:8ca7:43df with SMTP id
 a640c23a62f3a-ab789cbe101mr1434656166b.39.1739185820985; Mon, 10 Feb 2025
 03:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
In-Reply-To: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Feb 2025 11:09:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
X-Gm-Features: AWEUYZlWGaHYc5nZOdUlR5v9sD5AA_4t-RDU7vzzBQHP59v6GTU0El2gRWfV_QQ
Message-ID: <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Hao-ran Zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gmail.=
com> wrote:
>
> A data race may occur when the function `btrfs_discard_queue_work()`
> and the function `btrfs_update_block_group()` is executed concurrently.
> Specifically, when the `btrfs_update_block_group()` function is executed
> to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_work()`
> is accessing `if(block_group->used =3D=3D 0)` will appear with data race,
> which may cause block_group to be placed unexpectedly in discard_list or
> discard_unused_list. The specific function call stack is as follows:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_discard_queue_work+0x245/0x500 [btrfs]
>  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
>  btrfs_add_free_space+0x19a/0x200 [btrfs]
>  unpin_extent_range+0x847/0x2120 [btrfs]
>  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
>  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
>  transaction_kthread+0x764/0xc20 [btrfs]
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
>  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
>  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
>  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
>  flush_space+0x388/0x1440 [btrfs]
>  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
>  process_scheduled_works+0x716/0xf10
>  worker_thread+0xb6a/0x1190
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Although the `block_group->used` was checked again in the use of the
> `peek_discard_list` function, considering that `block_group->used` is
> a 64-bit variable, we still think that the data race here is an
> unexpected behavior. It is recommended to add `READ_ONCE` and
> `WRITE_ONCE` to read and write.
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> ---
>  fs/btrfs/block-group.c | 4 ++--
>  fs/btrfs/discard.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c0a8f7d92acc..c681b97f6835 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_trans_han=
dle *trans,
>         old_val =3D cache->used;
>         if (alloc) {
>                 old_val +=3D num_bytes;
> -               cache->used =3D old_val;
> +               WRITE_ONCE(cache->used, old_val);
>                 cache->reserved -=3D num_bytes;
>                 cache->reclaim_mark =3D 0;
>                 space_info->bytes_reserved -=3D num_bytes;
> @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_trans_han=
dle *trans,
>                 spin_unlock(&space_info->lock);
>         } else {
>                 old_val -=3D num_bytes;
> -               cache->used =3D old_val;
> +               WRITE_ONCE(cache->used, old_val);
>                 cache->pinned +=3D num_bytes;
>                 btrfs_space_info_update_bytes_pinned(space_info, num_byte=
s);
>                 space_info->bytes_used -=3D num_bytes;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index e815d165cccc..71c57b571d50 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ct=
l *discard_ctl,
>         if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD=
_ASYNC))
>                 return;
>
> -       if (block_group->used =3D=3D 0)
> +       if (READ_ONCE(block_group->used) =3D=3D 0)

There are at least 3 more places in discard.c where we access ->used
without being under the protection of the block group's spinlock.
So let's fix this for all places and not just a single one...

Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over the place.
What we typically do in btrfs is to add helpers that hide them, see
block-rsv.h for example.

Also, I don't think we need READ_ONCE/WRITE_ONCE.
We could use data_race(), though I think that could be subject to
load/store tearing, or just take the lock.
So adding a helper like this to block-group.h:

static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg)
{
   u64 ret;

   spin_lock(&bg->lock);
   ret =3D bg->used;
   spin_unlock(&bg->lock);

    return ret;
}

And then use btrfs_bock_group_used() everywhere in discard.c where we
aren't holding a block group's lock.

Thanks.


>                 add_to_discard_unused_list(discard_ctl, block_group);
>         else
>                 add_to_discard_list(discard_ctl, block_group);
> --
> 2.34.1
>
>

