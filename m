Return-Path: <linux-btrfs+bounces-11531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B87A3989F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0857D172841
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0346198E81;
	Tue, 18 Feb 2025 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTuGsDzw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF866174EE4;
	Tue, 18 Feb 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873949; cv=none; b=d6C1FD03J0q0jgq/kf/qbdRTEj2vBFaIoFzRTnL0bP72DkEB9m7kwednjb0CHTwKi5MWmKBWp9iEnP44vetkhY+OuphySvm42x4VLb45uVtHqNVxndgvWdC7ocWgwcUyNh0GFzHMdUdTtQxtmZOVucWm5wTaaoWe+CykUu9F6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873949; c=relaxed/simple;
	bh=vaVvfJXcFmwfZcKkF97Fsf9NfXhlKmDsz8nL+b3Zi3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwpCe9lwZyKfO+NzlNyGqGOhw019ACRky7sQNI5dJZTz+ATuaf5kJAge+52XbK1WjcUDGxLQr/XoOzAAwt6YGg5Lgo+XJbz8jNvzoEHLTS5X2L9OnjuZelm1tIlTXp/ngms9mDrwMI/ssdvnhcO2s8KhU7QXD+rBKiKfb2hCXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTuGsDzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7322FC4CEEB;
	Tue, 18 Feb 2025 10:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739873948;
	bh=vaVvfJXcFmwfZcKkF97Fsf9NfXhlKmDsz8nL+b3Zi3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mTuGsDzwyfT+5MP+5JAlnUdG2BPMW3ICGtG3OIFhxzxkaMkOvOxesAKYWZOSJmURn
	 kCiJgAHZpj9iTKG/sPzkXtLYm7j7j27Ub4PzQqkLMjyvXSKsISj7gO13fcc5sdHxO8
	 ZR7Me8X9gbsq/ao1qGrlP9BR7zRpeblg8ePM/xXfGVc+95TFATTohTTMlZFO0xv5YT
	 7tDEbAtByUtFICouuWXOMwG9BIS1xaMi20bLt4uQoLyxJ9G+uKP4729hpBbbyIFlRg
	 EOLvEs50yQuARHUn8Lm5pBgi8+mvDrLsww4QdqkEaI85wd6kgOF4IkNN6IxsSkPe/O
	 xUSXF57At7sEw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so6371811a12.1;
        Tue, 18 Feb 2025 02:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTCXbEKLlXzqAREFBpI4/dwgNkDlyx8LHoEtLUkrKG+gcA4DB3xuiYUYRtbhs5EHSpWz7bI40etFEMZA==@vger.kernel.org, AJvYcCWkWbAKCtNJ5k/dsKx71KSi0ZZ8/a27jPnfZVsb3DvMPoR/C8OAlVoqbEj6mJogsBTJd8136V6oL+vy5InR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdO0MAbLpAP5Vx5tLnIgaFKn1spld0Fk+1Ca5lOJ0OywqGJF/3
	kUGW1mvcEIzMeMdSRkWdkQ8fkZjSi7CR/Nc1o9XUVspTBoMsMWMCnjdY4azztbrhn6Mb7wneRPr
	4i5JJRKJ9uQqXvxkkcCoLki1923U=
X-Google-Smtp-Source: AGHT+IESIQg/pb1bDTF+w7Tx9/bjR2r2kHFFX3UETUoLtW38VRdQ5/H6L0BOTt1qYjnWMeJb/fltzlcRmRHy/QUL4PA=
X-Received: by 2002:a05:6402:2114:b0:5dc:71f6:9725 with SMTP id
 4fb4d7f45d1cf-5e036172eadmr30811548a12.27.1739873946891; Tue, 18 Feb 2025
 02:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com> <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
In-Reply-To: <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Feb 2025 10:18:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
X-Gm-Features: AWEUYZnfaf1uh9r_LRrZYr0CnRktb_0k-BbgmOZusFw9D__YFn10meZLUw7vpaU
Message-ID: <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Daniel Vacek <neelx@suse.com>
Cc: Hao-ran Zheng <zhenghaoran154@gmail.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:08=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gm=
ail.com> wrote:
> > >
> > > A data race may occur when the function `btrfs_discard_queue_work()`
> > > and the function `btrfs_update_block_group()` is executed concurrentl=
y.
> > > Specifically, when the `btrfs_update_block_group()` function is execu=
ted
> > > to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_work()`
> > > is accessing `if(block_group->used =3D=3D 0)` will appear with data r=
ace,
> > > which may cause block_group to be placed unexpectedly in discard_list=
 or
> > > discard_unused_list. The specific function call stack is as follows:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> > >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> > >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> > >  unpin_extent_range+0x847/0x2120 [btrfs]
> > >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> > >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> > >  transaction_kthread+0x764/0xc20 [btrfs]
> > >  kthread+0x292/0x330
> > >  ret_from_fork+0x4d/0x80
> > >  ret_from_fork_asm+0x1a/0x30
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> > >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> > >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> > >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> > >  flush_space+0x388/0x1440 [btrfs]
> > >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> > >  process_scheduled_works+0x716/0xf10
> > >  worker_thread+0xb6a/0x1190
> > >  kthread+0x292/0x330
> > >  ret_from_fork+0x4d/0x80
> > >  ret_from_fork_asm+0x1a/0x30
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Although the `block_group->used` was checked again in the use of the
> > > `peek_discard_list` function, considering that `block_group->used` is
> > > a 64-bit variable, we still think that the data race here is an
> > > unexpected behavior. It is recommended to add `READ_ONCE` and
> > > `WRITE_ONCE` to read and write.
> > >
> > > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > > ---
> > >  fs/btrfs/block-group.c | 4 ++--
> > >  fs/btrfs/discard.c     | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index c0a8f7d92acc..c681b97f6835 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_trans=
_handle *trans,
> > >         old_val =3D cache->used;
> > >         if (alloc) {
> > >                 old_val +=3D num_bytes;
> > > -               cache->used =3D old_val;
> > > +               WRITE_ONCE(cache->used, old_val);
> > >                 cache->reserved -=3D num_bytes;
> > >                 cache->reclaim_mark =3D 0;
> > >                 space_info->bytes_reserved -=3D num_bytes;
> > > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_trans=
_handle *trans,
> > >                 spin_unlock(&space_info->lock);
> > >         } else {
> > >                 old_val -=3D num_bytes;
> > > -               cache->used =3D old_val;
> > > +               WRITE_ONCE(cache->used, old_val);
> > >                 cache->pinned +=3D num_bytes;
> > >                 btrfs_space_info_update_bytes_pinned(space_info, num_=
bytes);
> > >                 space_info->bytes_used -=3D num_bytes;
> > > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > > index e815d165cccc..71c57b571d50 100644
> > > --- a/fs/btrfs/discard.c
> > > +++ b/fs/btrfs/discard.c
> > > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discar=
d_ctl *discard_ctl,
> > >         if (!block_group || !btrfs_test_opt(block_group->fs_info, DIS=
CARD_ASYNC))
> > >                 return;
> > >
> > > -       if (block_group->used =3D=3D 0)
> > > +       if (READ_ONCE(block_group->used) =3D=3D 0)
> >
> > There are at least 3 more places in discard.c where we access ->used
> > without being under the protection of the block group's spinlock.
> > So let's fix this for all places and not just a single one...
> >
> > Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over the pl=
ace.
> > What we typically do in btrfs is to add helpers that hide them, see
> > block-rsv.h for example.
> >
> > Also, I don't think we need READ_ONCE/WRITE_ONCE.
> > We could use data_race(), though I think that could be subject to
> > load/store tearing, or just take the lock.
> > So adding a helper like this to block-group.h:
> >
> > static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg)
> > {
> >    u64 ret;
> >
> >    spin_lock(&bg->lock);
> >    ret =3D bg->used;
> >    spin_unlock(&bg->lock);
> >
> >     return ret;
> > }
>
> Would memory barriers be sufficient here? Taking a lock just for
> reading one member seems excessive...

Do you think there's heavy contention on this lock?

Usually I prefer to go the simplest way, and using locks is a lot more
straightforward and easier to understand than memory barriers.
Unless it's clear there's an observable performance penalty, keeping
it simple is better.

data_race() may be ok here, at least for one of the unprotected
accesses it's fine, but would have to analyse the other 3 cases.



>
> > And then use btrfs_bock_group_used() everywhere in discard.c where we
> > aren't holding a block group's lock.
> >
> > Thanks.
> >
> >
> > >                 add_to_discard_unused_list(discard_ctl, block_group);
> > >         else
> > >                 add_to_discard_list(discard_ctl, block_group);
> > > --
> > > 2.34.1
> > >
> > >
> >

