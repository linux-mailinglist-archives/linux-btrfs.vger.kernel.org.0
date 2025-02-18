Return-Path: <linux-btrfs+bounces-11536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA2EA3A257
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 17:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BA9161C84
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E026E638;
	Tue, 18 Feb 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f8hQaEPF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEE26A1A5
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895245; cv=none; b=e0RczVRWp5DrvRdjhVRreqqdoOGPpqAO8tK/ENZG4gpzZonK3+BN6QOm54Y84E3dfeVAZ4qN0rjy1vbCeKn8WJ4I/VKg17skfYmg9B3XigO4x4CI8YV+8H02DbpR4k2i+ImWrgXjsSgtW2lAL333FxNnaLEokxUXfKWXE7y5w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895245; c=relaxed/simple;
	bh=XhQ5ZgJRj95Aw9fbSDihcxe5B7PjrfyckCxeU6KSwqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvuyHdIIk2xJZ7qsjRHSqx/1Ed8HUkG+c+m3SMtnEckA/dlpYaYU+bAi2WYxGaTa3sSW4hi+B6lkJ/jGmreFE6l8A8EmQaQY4Z2YLQRg4aNUzOc0mPyEpjm+PKZ79MxF12RBc3I3ZfQZhnbDoChib9SjLjMql7kWSXl+uZjXFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f8hQaEPF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso866110566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739895241; x=1740500041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npIXqocrEaDKFc+/jv0OGlykIBcXoa2tVPrTL52vw9s=;
        b=f8hQaEPFoEIA70ZsMB1XBqYz3+FV1cHSLA+6S813ICu9Oe94uKoG7Dy63/E6/9vzQO
         DwvEN2eR23XceoOWHnaIuXb1sf5hQIVbG2Fv2iAPtIQtYz5td8uxT7IWTgUBAuCL/BMx
         md/WPE0NfNEc0IcAod1XH2LRuEJVXDZ8/9dPborl8Yn4b69o7ImnYXAw0CyhPOQXD11X
         4mdEQHXuTqKnmuNHXkkAesSlfv/Gl70N+GqDP6o35uFs5ATGlof4c8AsMcAN+4YNVQGm
         5UHK4ZW1RPGurOvMRJl5OOJjWfOGte+SDBfyAz505uRcZ7kCoB0JCw8F3VQpbp0i1pPO
         c/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895241; x=1740500041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npIXqocrEaDKFc+/jv0OGlykIBcXoa2tVPrTL52vw9s=;
        b=kgWMc4oYTx9ew8SR1miNCqDBas708ZHzg1VOPudaqbuGKjw7PCnnyl1HwgoKjD6GXN
         LvIgbuZKf87Y0vRE81TBl0j4GeiAf0x4f21HSzdtCTgL9oCPl2/gyKD3FoI7iJoLj0So
         LAC5oDDAFhOi0J8LJx+biWJJHgtKV99MtrHGSKiVsscl24DiAImOkBtC+mAe3vkfyZqf
         gG+PDv1p2xz90++ioM4l0SjmGeY80vdMNgs+ajuZu+NNs/vcbAyLcsdwZSe2UxA2z/Ig
         Z0c+wyxp7Axltzk7yr1ALdIQb7fyV8bFmnMqn9R0Ap265PWn0lzIgQg6gYeBQF487Z/l
         ZQPA==
X-Forwarded-Encrypted: i=1; AJvYcCW7giLdrrfR/C2NWeDgf6BsFnjouwFZi2NesrKsYsxo6Aca74KZgTHD4T7fHjrZDDHNGqy76lV9lE3JnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTslmHvZ93vcGWIuYILdF1HXHXgxCbrTXjXR6hHKkRqcgYRNe0
	ym3xjjllvPL0RtfCybRhyKZ+1QKIcRPPRwxII4GeHeyLtZafRaYYhk0h5fWOOdgXcoKxL083EOR
	qpYvBpPbLwIvegsTFmCY8hKYd63vThAyYy+iSpA==
X-Gm-Gg: ASbGnctnYLhr2ECSPiKBQ3OsCr+QD9k9KzkMYsZsODHJpgxTEPgUjcyAs9QMBUNrr6j
	m5P/pzp9/QomL0BdvUTuGzcWtQ1ERG//QVSs8yaTUQBHmNWwKOsNYkIpBi/hb9I96QAb0Phc=
X-Google-Smtp-Source: AGHT+IF/Z2GSmbT5+A60icip7tG8+j62Mapl+eS4JrU37LMyIiyHcru9hju9xZcPMKo83ioDEHS+Fo+CND114Bd/5NM=
X-Received: by 2002:a17:907:9815:b0:abb:c7d2:3a65 with SMTP id
 a640c23a62f3a-abbcd049621mr18691466b.39.1739895241353; Tue, 18 Feb 2025
 08:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
 <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com> <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Feb 2025 17:13:50 +0100
X-Gm-Features: AWEUYZnah0d0RxF9HzXGI3BrXNEp4GFgvzkz_bJaENaCUAdkcbJRGb28Sxqqt1c
Message-ID: <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Hao-ran Zheng <zhenghaoran154@gmail.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 at 11:19, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Feb 18, 2025 at 8:08=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> wrote=
:
> > >
> > > On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@=
gmail.com> wrote:
> > > >
> > > > A data race may occur when the function `btrfs_discard_queue_work()=
`
> > > > and the function `btrfs_update_block_group()` is executed concurren=
tly.
> > > > Specifically, when the `btrfs_update_block_group()` function is exe=
cuted
> > > > to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_work(=
)`
> > > > is accessing `if(block_group->used =3D=3D 0)` will appear with data=
 race,
> > > > which may cause block_group to be placed unexpectedly in discard_li=
st or
> > > > discard_unused_list. The specific function call stack is as follows=
:
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> > > >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> > > >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> > > >  unpin_extent_range+0x847/0x2120 [btrfs]
> > > >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> > > >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> > > >  transaction_kthread+0x764/0xc20 [btrfs]
> > > >  kthread+0x292/0x330
> > > >  ret_from_fork+0x4d/0x80
> > > >  ret_from_fork_asm+0x1a/0x30
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> > > >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> > > >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> > > >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> > > >  flush_space+0x388/0x1440 [btrfs]
> > > >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> > > >  process_scheduled_works+0x716/0xf10
> > > >  worker_thread+0xb6a/0x1190
> > > >  kthread+0x292/0x330
> > > >  ret_from_fork+0x4d/0x80
> > > >  ret_from_fork_asm+0x1a/0x30
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Although the `block_group->used` was checked again in the use of th=
e
> > > > `peek_discard_list` function, considering that `block_group->used` =
is
> > > > a 64-bit variable, we still think that the data race here is an
> > > > unexpected behavior. It is recommended to add `READ_ONCE` and
> > > > `WRITE_ONCE` to read and write.
> > > >
> > > > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > > > ---
> > > >  fs/btrfs/block-group.c | 4 ++--
> > > >  fs/btrfs/discard.c     | 2 +-
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > index c0a8f7d92acc..c681b97f6835 100644
> > > > --- a/fs/btrfs/block-group.c
> > > > +++ b/fs/btrfs/block-group.c
> > > > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_tra=
ns_handle *trans,
> > > >         old_val =3D cache->used;
> > > >         if (alloc) {
> > > >                 old_val +=3D num_bytes;
> > > > -               cache->used =3D old_val;
> > > > +               WRITE_ONCE(cache->used, old_val);
> > > >                 cache->reserved -=3D num_bytes;
> > > >                 cache->reclaim_mark =3D 0;
> > > >                 space_info->bytes_reserved -=3D num_bytes;
> > > > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_tra=
ns_handle *trans,
> > > >                 spin_unlock(&space_info->lock);
> > > >         } else {
> > > >                 old_val -=3D num_bytes;
> > > > -               cache->used =3D old_val;
> > > > +               WRITE_ONCE(cache->used, old_val);
> > > >                 cache->pinned +=3D num_bytes;
> > > >                 btrfs_space_info_update_bytes_pinned(space_info, nu=
m_bytes);
> > > >                 space_info->bytes_used -=3D num_bytes;
> > > > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > > > index e815d165cccc..71c57b571d50 100644
> > > > --- a/fs/btrfs/discard.c
> > > > +++ b/fs/btrfs/discard.c
> > > > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_disc=
ard_ctl *discard_ctl,
> > > >         if (!block_group || !btrfs_test_opt(block_group->fs_info, D=
ISCARD_ASYNC))
> > > >                 return;
> > > >
> > > > -       if (block_group->used =3D=3D 0)
> > > > +       if (READ_ONCE(block_group->used) =3D=3D 0)
> > >
> > > There are at least 3 more places in discard.c where we access ->used
> > > without being under the protection of the block group's spinlock.
> > > So let's fix this for all places and not just a single one...
> > >
> > > Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over the =
place.
> > > What we typically do in btrfs is to add helpers that hide them, see
> > > block-rsv.h for example.
> > >
> > > Also, I don't think we need READ_ONCE/WRITE_ONCE.
> > > We could use data_race(), though I think that could be subject to
> > > load/store tearing, or just take the lock.
> > > So adding a helper like this to block-group.h:
> > >
> > > static inline u64 btrfs_block_group_used(struct btrfs_block_group *bg=
)
> > > {
> > >    u64 ret;
> > >
> > >    spin_lock(&bg->lock);
> > >    ret =3D bg->used;
> > >    spin_unlock(&bg->lock);
> > >
> > >     return ret;
> > > }
> >
> > Would memory barriers be sufficient here? Taking a lock just for
> > reading one member seems excessive...
>
> Do you think there's heavy contention on this lock?

This is not about contention. Spin lock should just never be used this
way. Or any lock actually. The critical section only contains a single
fetch operation which does not justify using a lock.
Hence the only guarantee such lock usage provides are the implicit
memory barriers (from which maybe only one of them is really needed
depending on the context where this helper is going to be used).

Simply put, the lock is degraded into a memory barrier this way. So
why not just use the barriers in the first place if only ordering
guarantees are required? It only makes sense.

> Usually I prefer to go the simplest way, and using locks is a lot more
> straightforward and easier to understand than memory barriers.

How so? Locks provide the same memory barriers implicitly.

> Unless it's clear there's an observable performance penalty, keeping
> it simple is better.

Exactly. Here is where our opinions differ. For me 'simple' means
without useless locking.
I mean especially with locks they should only be used when absolutely
necessary. In a sense of 'use the right tool for the job'. There are
more lightweight tools possible in this context. Locks provide
additional guarantees which are not needed here.

On the other hand I understand that using a lock is a 'better safe
than sorry' approach which should also work. Just keep in mind that
spinlock may sleep on RT.

> data_race() may be ok here, at least for one of the unprotected
> accesses it's fine, but would have to analyse the other 3 cases.

That's exactly my thoughts. Maybe not even the barriers are needed
after all. This needs to be checked on a per-case basis.

> >
> > > And then use btrfs_bock_group_used() everywhere in discard.c where we
> > > aren't holding a block group's lock.
> > >
> > > Thanks.
> > >
> > >
> > > >                 add_to_discard_unused_list(discard_ctl, block_group=
);
> > > >         else
> > > >                 add_to_discard_list(discard_ctl, block_group);
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >

