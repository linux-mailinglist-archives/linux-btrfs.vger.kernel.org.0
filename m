Return-Path: <linux-btrfs+bounces-11562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF4A3B69E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D288C166FEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4D1E0B7D;
	Wed, 19 Feb 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/JMEo72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410F1CB518;
	Wed, 19 Feb 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955177; cv=none; b=Fjg0M6YXs45R1TKckkq7RX163pH9gHHECZexpiyBM04WFTeUubxHpQOWUoG3RMbUTkDNZxMLVN6OUGkIjd3sEYw7WdcS+vgbXDqyzX42WVqzZc5Rxgkdkk0xA9hjvMw//8soLDpT2QdLShUyV/HEKvn3lygXgC3SYhXG7m/5F2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955177; c=relaxed/simple;
	bh=jci8wU+mUppwHF3MfleP7kdhnU5A1Un1W0SKGtlKO6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5mPFnX1eGaufRM0t9Wl28zQLltMly5hGQLQpXbGrk5M8xqIdQRWzOOyiLG2aNGVVtqUWwanYk4/6joooJewbW4D9nmrkcic4mR+lPcX1ru9bXrKU2aw0Zwf07qKe/Bai2DIrLPjDTFXehZmgMGQ4h4+zbjdGDSlBsbuivslfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/JMEo72; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so1021730a91.1;
        Wed, 19 Feb 2025 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739955171; x=1740559971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG1o86OYTiLAxzL3Ree3H8BihYn463hfbH7TMewO7RI=;
        b=k/JMEo721U3hzRpg0tzQNwd8CM8Jm58GKl4sGmCqMKQrpxlezJ6NEpRzC8drnoghfR
         g6V2O6/5D0vxBTAIKxAjKNbVIZ/24+I9Irug2WSYiTkRdfdoKAVUnnDQ3n018nZ9MBAB
         W0qOQt9ejRl6hKYkXIq6h5/WjqsZWh1m20X7cWmeQUNG0WAKndFu0jVM64pAy0Tu67wI
         W29lSB1L2Wzc9YoL8xGLObupof6JCZnuyI7/zWrCTNJCcIFB6mIof0hyXnkZ1MtfBokt
         yQa8Dt5kdAuvhxJJTbIJoPIJX1cRkRCv21ucIdq3vrHUOvIRkiaHDutGo4cHdXcbnZJB
         w+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955171; x=1740559971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG1o86OYTiLAxzL3Ree3H8BihYn463hfbH7TMewO7RI=;
        b=fHpOmc2Cd1j79VUF8GIuVX2KXlv9AKhtKyqrO3/j/O3AYoon63TcO00u7zsWpjOdMf
         OoTjlOobwtWheibkrOUhN9WYJ99xmYkWtLiHn3uzO5YlWvIhPYXF+TWmf3DQSpso4g0c
         97H/KWQO9yQzXxdKdkSm9K1/VIEWVWXCN513DV6oj3HnmnwmR/4Ib3gz3mDOmC/AMetO
         HclC5DU6ANG1Et99yxD4XHLfJmZD+OchAG1GnxliBgd/h0cbbJaM267ZnnuD/RnEzU6n
         //Iu8O5xDIpfHrc0SaZubZuOwhqAaCsYPFyXyoX5zTgjOj2endxi37LAnf+Mk/JNT7Nm
         zEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY66zNKhCAaS/hjJa9IzcglfXPTbNbOVSDcGDbbGuial/O4hxepQlx/S20JV1m0KKcfD0GpnpUerz3mflR@vger.kernel.org, AJvYcCXYwgEoQ9Bw0vmwtozEDS1Hfhbf8v9wHHj8HjOQU5O97p09mYytEDHQHLNcw3ZNrwRNiraii4BAd+H2HA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UEEGec8uLM6OfcvfTfXnFjf+JU4Nqzgu4ckOUUnAf6B7eRGT
	Dzd3ZcMKQbsCjFUdRsn+Cly3lWVSTToKAF1PykbJDljZkfT5lV7DOtmxDNi1Ki1IGmQ27Zvgs46
	aatsNtzG5t+Af7Wyz+TMoSmWJEZQ=
X-Gm-Gg: ASbGncsdULuPizM5T10LfkUBjSBpDKojlsA9iN3h2ciUtGqv7qZ2KU8uH/bHIEyaqXj
	BRnw53Yy/Oo4bPmfHA1/q71LuFASW6VAZqrJNLoel36rYr0U0FS0DzbohTEMJqJbuZFID7wcLUw
	==
X-Google-Smtp-Source: AGHT+IFlt/omkNd9yvjQ73i9iaP39l+q+ypgb3SsHdAC/r/nv82+7zRg5B57SfeafGSmOVpFNOG1UumfxX2ZcPCwwRE=
X-Received: by 2002:a17:90b:2252:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2fc40f1086amr26350955a91.11.1739955171341; Wed, 19 Feb 2025
 00:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
 <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
 <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
 <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com> <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
In-Reply-To: <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Wed, 19 Feb 2025 16:52:40 +0800
X-Gm-Features: AWEUYZl0AqWU4PSGnrD1gRPn8X09Y09pv6l1WfgF5DpjbcufmseVqHpio1YeBqM
Message-ID: <CAKa5YKjymZzRWy6WhVhu+mMzENunsM6URBL3o-_yy1wPGhdV-A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Daniel Vacek <neelx@suse.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:29=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Tue, Feb 18, 2025 at 4:14=E2=80=AFPM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Tue, 18 Feb 2025 at 11:19, Filipe Manana <fdmanana@kernel.org> wrote=
:
> > >
> > > On Tue, Feb 18, 2025 at 8:08=E2=80=AFAM Daniel Vacek <neelx@suse.com>=
 wrote:
> > > >
> > > > On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> w=
rote:
> > > > >
> > > > > On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran=
154@gmail.com> wrote:
> > > > > >
> > > > > > A data race may occur when the function `btrfs_discard_queue_wo=
rk()`
> > > > > > and the function `btrfs_update_block_group()` is executed concu=
rrently.
> > > > > > Specifically, when the `btrfs_update_block_group()` function is=
 executed
> > > > > > to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_w=
ork()`
> > > > > > is accessing `if(block_group->used =3D=3D 0)` will appear with =
data race,
> > > > > > which may cause block_group to be placed unexpectedly in discar=
d_list or
> > > > > > discard_unused_list. The specific function call stack is as fol=
lows:
> > > > > >
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> > > > > >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> > > > > >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> > > > > >  unpin_extent_range+0x847/0x2120 [btrfs]
> > > > > >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> > > > > >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> > > > > >  transaction_kthread+0x764/0xc20 [btrfs]
> > > > > >  kthread+0x292/0x330
> > > > > >  ret_from_fork+0x4d/0x80
> > > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> > > > > >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> > > > > >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> > > > > >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> > > > > >  flush_space+0x388/0x1440 [btrfs]
> > > > > >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> > > > > >  process_scheduled_works+0x716/0xf10
> > > > > >  worker_thread+0xb6a/0x1190
> > > > > >  kthread+0x292/0x330
> > > > > >  ret_from_fork+0x4d/0x80
> > > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >
> > > > > > Although the `block_group->used` was checked again in the use o=
f the
> > > > > > `peek_discard_list` function, considering that `block_group->us=
ed` is
> > > > > > a 64-bit variable, we still think that the data race here is an
> > > > > > unexpected behavior. It is recommended to add `READ_ONCE` and
> > > > > > `WRITE_ONCE` to read and write.
> > > > > >
> > > > > > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > > > > > ---
> > > > > >  fs/btrfs/block-group.c | 4 ++--
> > > > > >  fs/btrfs/discard.c     | 2 +-
> > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > > > index c0a8f7d92acc..c681b97f6835 100644
> > > > > > --- a/fs/btrfs/block-group.c
> > > > > > +++ b/fs/btrfs/block-group.c
> > > > > > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs=
_trans_handle *trans,
> > > > > >         old_val =3D cache->used;
> > > > > >         if (alloc) {
> > > > > >                 old_val +=3D num_bytes;
> > > > > > -               cache->used =3D old_val;
> > > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > > >                 cache->reserved -=3D num_bytes;
> > > > > >                 cache->reclaim_mark =3D 0;
> > > > > >                 space_info->bytes_reserved -=3D num_bytes;
> > > > > > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs=
_trans_handle *trans,
> > > > > >                 spin_unlock(&space_info->lock);
> > > > > >         } else {
> > > > > >                 old_val -=3D num_bytes;
> > > > > > -               cache->used =3D old_val;
> > > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > > >                 cache->pinned +=3D num_bytes;
> > > > > >                 btrfs_space_info_update_bytes_pinned(space_info=
, num_bytes);
> > > > > >                 space_info->bytes_used -=3D num_bytes;
> > > > > > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > > > > > index e815d165cccc..71c57b571d50 100644
> > > > > > --- a/fs/btrfs/discard.c
> > > > > > +++ b/fs/btrfs/discard.c
> > > > > > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_=
discard_ctl *discard_ctl,
> > > > > >         if (!block_group || !btrfs_test_opt(block_group->fs_inf=
o, DISCARD_ASYNC))
> > > > > >                 return;
> > > > > >
> > > > > > -       if (block_group->used =3D=3D 0)
> > > > > > +       if (READ_ONCE(block_group->used) =3D=3D 0)
> > > > >
> > > > > There are at least 3 more places in discard.c where we access ->u=
sed
> > > > > without being under the protection of the block group's spinlock.
> > > > > So let's fix this for all places and not just a single one...
> > > > >
> > > > > Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over =
the place.
> > > > > What we typically do in btrfs is to add helpers that hide them, s=
ee
> > > > > block-rsv.h for example.
> > > > >
> > > > > Also, I don't think we need READ_ONCE/WRITE_ONCE.
> > > > > We could use data_race(), though I think that could be subject to
> > > > > load/store tearing, or just take the lock.
> > > > > So adding a helper like this to block-group.h:
> > > > >
> > > > > static inline u64 btrfs_block_group_used(struct btrfs_block_group=
 *bg)
> > > > > {
> > > > >    u64 ret;
> > > > >
> > > > >    spin_lock(&bg->lock);
> > > > >    ret =3D bg->used;
> > > > >    spin_unlock(&bg->lock);
> > > > >
> > > > >     return ret;
> > > > > }

I understand that using lock to protect block_group->used
in discard.c file is feasible. In addition, I looked at the code
of block-group.c and found that locks have been added in
some places where block_group->used are used. , it
seems that it is not appropriate to call
btrfs_block_group_used again to obtain (because it will
cause deadlock). I would like to ask other similar places
where block_group->used needs to call
btrfs_block_group_used function in addition to the four
places in discard.c?

> > > >
> > > > Would memory barriers be sufficient here? Taking a lock just for
> > > > reading one member seems excessive...

Do I need to perform performance testing to ensure the impact if I lock it?

> > >
> > > Do you think there's heavy contention on this lock?
> >
> > This is not about contention. Spin lock should just never be used this
> > way. Or any lock actually. The critical section only contains a single
> > fetch operation which does not justify using a lock.
> > Hence the only guarantee such lock usage provides are the implicit
> > memory barriers (from which maybe only one of them is really needed
> > depending on the context where this helper is going to be used).
> >
> > Simply put, the lock is degraded into a memory barrier this way. So
> > why not just use the barriers in the first place if only ordering
> > guarantees are required? It only makes sense.
>
> As said earlier, it's a lot easier to reason about lock() and unlock()
> calls rather than spreading memory barriers in the write and read
> sides.
> Historically he had several mistakes with barriers, they're simply not
> as straightforward to reason as locks.
>
> Plus spreading the barriers in the read and write sides makes the code
> not so easy to read, not to mention in case of any new sites updating
> the member, we'll have to not forget adding a barrier.
>
> It's just easier to reason and maintain.
>
>
> >
> > > Usually I prefer to go the simplest way, and using locks is a lot mor=
e
> > > straightforward and easier to understand than memory barriers.
> >
> > How so? Locks provide the same memory barriers implicitly.
>
> I'm not saying they don't.
> I'm talking about easier code to read and maintain.
>
> >
> > > Unless it's clear there's an observable performance penalty, keeping
> > > it simple is better.
> >
> > Exactly. Here is where our opinions differ. For me 'simple' means
> > without useless locking.
> > I mean especially with locks they should only be used when absolutely
> > necessary. In a sense of 'use the right tool for the job'. There are
> > more lightweight tools possible in this context. Locks provide
> > additional guarantees which are not needed here.
> >
> > On the other hand I understand that using a lock is a 'better safe
> > than sorry' approach which should also work. Just keep in mind that
> > spinlock may sleep on RT.
>
> It's not about a better safe than sorry, but easier to read, reason
> and maintain.
>
> >
> > > data_race() may be ok here, at least for one of the unprotected
> > > accesses it's fine, but would have to analyse the other 3 cases.
> >
> > That's exactly my thoughts. Maybe not even the barriers are needed
> > after all. This needs to be checked on a per-case basis.
> >
> > > >
> > > > > And then use btrfs_bock_group_used() everywhere in discard.c wher=
e we
> > > > > aren't holding a block group's lock.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >                 add_to_discard_unused_list(discard_ctl, block_g=
roup);
> > > > > >         else
> > > > > >                 add_to_discard_list(discard_ctl, block_group);
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > > >
> > > > >

