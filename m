Return-Path: <linux-btrfs+bounces-11537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED4A3A2E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FD97A4F67
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882426E621;
	Tue, 18 Feb 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTEkrOlZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36D158A13;
	Tue, 18 Feb 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896157; cv=none; b=paTD/R1tyZZf27pwLIxOkBgtnjuuWCdgT4IO8/xh94pe0SsC9mUM89NkRUDA2+X5tkEmjfD9FL5ed4z3U7TERwfgOrzV8Kx3wHsX9QO07lK/WA/V8EMx8kHRN5nCyzdo52iBcM411zSBUB1lDDPkdEK83TdJ/+7eFr0gkJknn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896157; c=relaxed/simple;
	bh=EW2CAZHUWvPWCmrJJBan5/T+VE4vFolvkku2aB2FNLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo2P06BVqZ+NoBDWtIGWoF5w/SOLOYte5AEUZb026eubTDxRRkcuEtzApUOFj/TR4cYukl9iPwJeDb1KXtDK+/U1rQ1vpETBek+x0b51legqWGlY/v87yYiLIuQv2+V7B8wwuI6KqyhDSKku2PjKelz65hRupAFoCa3DidgqMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTEkrOlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54958C4AF09;
	Tue, 18 Feb 2025 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896154;
	bh=EW2CAZHUWvPWCmrJJBan5/T+VE4vFolvkku2aB2FNLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gTEkrOlZXfbCRkI+fugA3WL/LTcBmR2kigsKkGHNJP4dMlkqsPAUgbJOIY/3Yvg/U
	 iJuWXtBft/zJFx8LDTX3euM2GCyVLkFsod+1LnncTlpFNi3626cBKb4FO9tiwIbtyg
	 8hIWEtnNxZ1RlPwXlfqmP9D4wMOZDzTKBkdI+Pn8Ey3f+FVMV0XAWdyIlC+meqBuWj
	 DjANPXIPsgnTVUB28mNSsxHZpqDGyXe4Ow5/3Rwl+pG468AcnHJMRtJ43/7OMB7E+d
	 OSr5SvK6bHNIxtlXlFdFC2rtsCI5oGLJAgX+h+EnI2UPEKatK1HS8eGyKeFEShSZ70
	 q+w+qPuwsufhQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb8e405640so387874966b.0;
        Tue, 18 Feb 2025 08:29:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Guy1TipoEPDjLTPtdtisB1MTeFsFRnnouduwbYBZcUpscckf9VVRb6zoICt7G4Jmq91mDCbUeDOkxg==@vger.kernel.org, AJvYcCV0psOj4JTP5CNYdxYDuNxXBTqyYL3dJwRMifKesPi16tDs2TSYyw1IxuLmcoR19cyeX6I9hwRFCruszRGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RZrSWi8Aa2l/lDXoMFJzgJpNbFx3c7hIsC/ZOZeZxygvm7do
	m7SwCZ/0NS2EITT2D24qV2QIRBVEq6UQe0eZSy1wskPiNoLMgBAH7+xa8ZVqdkQXUYrM4XQ9Ojv
	qSb1ZpM0wKSJg6YU1eHIFLLJAyC0=
X-Google-Smtp-Source: AGHT+IEqkDDPTzKouQajjbWiwypCIz++hje7mHLY3n+PCAvlEZ6urwHDb3LfrtL/+KnRMQM0lSRBK/Tsdyhsk/Yodxc=
X-Received: by 2002:a17:906:318e:b0:ab7:5fcd:d4d9 with SMTP id
 a640c23a62f3a-abb70d96dc0mr1172353766b.43.1739896152729; Tue, 18 Feb 2025
 08:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
 <CAL3q7H5JgQkFavwrjOsvxDt9mMjVUK_nPOha-WYU-muLW=Orug@mail.gmail.com>
 <CAPjX3FeaL2+oRz81OEkLKjWwr1XuOOa3t-kgCrc51we-C-GVng@mail.gmail.com>
 <CAL3q7H7iFQ0pS+TB8NNj5CDA=c1cmurSiGsuXDn61O6A5=mBSQ@mail.gmail.com> <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com>
In-Reply-To: <CAPjX3Feo9=hkptSxOMREKVckbvhfbmjHAWYBL2sBryDcVzp0NA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Feb 2025 16:28:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
X-Gm-Features: AWEUYZlyetB3trihz8EXi1_ZGsCdfxMd_uCvLrg39Cxm3c4JYJDm5C6BxkcyrLM
Message-ID: <CAL3q7H7eSw0gg=JQwiEe9_pSEqcxugpgOWJDdv45UHrZbsFhzw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the block_group's
 used field
To: Daniel Vacek <neelx@suse.com>
Cc: Hao-ran Zheng <zhenghaoran154@gmail.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 4:14=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Tue, 18 Feb 2025 at 11:19, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Tue, Feb 18, 2025 at 8:08=E2=80=AFAM Daniel Vacek <neelx@suse.com> w=
rote:
> > >
> > > On Mon, 10 Feb 2025 at 12:11, Filipe Manana <fdmanana@kernel.org> wro=
te:
> > > >
> > > > On Sat, Feb 8, 2025 at 7:38=E2=80=AFAM Hao-ran Zheng <zhenghaoran15=
4@gmail.com> wrote:
> > > > >
> > > > > A data race may occur when the function `btrfs_discard_queue_work=
()`
> > > > > and the function `btrfs_update_block_group()` is executed concurr=
ently.
> > > > > Specifically, when the `btrfs_update_block_group()` function is e=
xecuted
> > > > > to lines `cache->used =3D old_val;`, and `btrfs_discard_queue_wor=
k()`
> > > > > is accessing `if(block_group->used =3D=3D 0)` will appear with da=
ta race,
> > > > > which may cause block_group to be placed unexpectedly in discard_=
list or
> > > > > discard_unused_list. The specific function call stack is as follo=
ws:
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > >  btrfs_discard_queue_work+0x245/0x500 [btrfs]
> > > > >  __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
> > > > >  btrfs_add_free_space+0x19a/0x200 [btrfs]
> > > > >  unpin_extent_range+0x847/0x2120 [btrfs]
> > > > >  btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
> > > > >  btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
> > > > >  transaction_kthread+0x764/0xc20 [btrfs]
> > > > >  kthread+0x292/0x330
> > > > >  ret_from_fork+0x4d/0x80
> > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > >  btrfs_update_block_group+0xa9d/0x2430 [btrfs]
> > > > >  __btrfs_free_extent+0x4f69/0x9920 [btrfs]
> > > > >  __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
> > > > >  btrfs_run_delayed_refs+0x317/0x770 [btrfs]
> > > > >  flush_space+0x388/0x1440 [btrfs]
> > > > >  btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
> > > > >  process_scheduled_works+0x716/0xf10
> > > > >  worker_thread+0xb6a/0x1190
> > > > >  kthread+0x292/0x330
> > > > >  ret_from_fork+0x4d/0x80
> > > > >  ret_from_fork_asm+0x1a/0x30
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Although the `block_group->used` was checked again in the use of =
the
> > > > > `peek_discard_list` function, considering that `block_group->used=
` is
> > > > > a 64-bit variable, we still think that the data race here is an
> > > > > unexpected behavior. It is recommended to add `READ_ONCE` and
> > > > > `WRITE_ONCE` to read and write.
> > > > >
> > > > > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > > > > ---
> > > > >  fs/btrfs/block-group.c | 4 ++--
> > > > >  fs/btrfs/discard.c     | 2 +-
> > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > > index c0a8f7d92acc..c681b97f6835 100644
> > > > > --- a/fs/btrfs/block-group.c
> > > > > +++ b/fs/btrfs/block-group.c
> > > > > @@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_t=
rans_handle *trans,
> > > > >         old_val =3D cache->used;
> > > > >         if (alloc) {
> > > > >                 old_val +=3D num_bytes;
> > > > > -               cache->used =3D old_val;
> > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > >                 cache->reserved -=3D num_bytes;
> > > > >                 cache->reclaim_mark =3D 0;
> > > > >                 space_info->bytes_reserved -=3D num_bytes;
> > > > > @@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_t=
rans_handle *trans,
> > > > >                 spin_unlock(&space_info->lock);
> > > > >         } else {
> > > > >                 old_val -=3D num_bytes;
> > > > > -               cache->used =3D old_val;
> > > > > +               WRITE_ONCE(cache->used, old_val);
> > > > >                 cache->pinned +=3D num_bytes;
> > > > >                 btrfs_space_info_update_bytes_pinned(space_info, =
num_bytes);
> > > > >                 space_info->bytes_used -=3D num_bytes;
> > > > > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > > > > index e815d165cccc..71c57b571d50 100644
> > > > > --- a/fs/btrfs/discard.c
> > > > > +++ b/fs/btrfs/discard.c
> > > > > @@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_di=
scard_ctl *discard_ctl,
> > > > >         if (!block_group || !btrfs_test_opt(block_group->fs_info,=
 DISCARD_ASYNC))
> > > > >                 return;
> > > > >
> > > > > -       if (block_group->used =3D=3D 0)
> > > > > +       if (READ_ONCE(block_group->used) =3D=3D 0)
> > > >
> > > > There are at least 3 more places in discard.c where we access ->use=
d
> > > > without being under the protection of the block group's spinlock.
> > > > So let's fix this for all places and not just a single one...
> > > >
> > > > Also, this is quite ugly to spread READ_ONCE/WRITE_ONCE all over th=
e place.
> > > > What we typically do in btrfs is to add helpers that hide them, see
> > > > block-rsv.h for example.
> > > >
> > > > Also, I don't think we need READ_ONCE/WRITE_ONCE.
> > > > We could use data_race(), though I think that could be subject to
> > > > load/store tearing, or just take the lock.
> > > > So adding a helper like this to block-group.h:
> > > >
> > > > static inline u64 btrfs_block_group_used(struct btrfs_block_group *=
bg)
> > > > {
> > > >    u64 ret;
> > > >
> > > >    spin_lock(&bg->lock);
> > > >    ret =3D bg->used;
> > > >    spin_unlock(&bg->lock);
> > > >
> > > >     return ret;
> > > > }
> > >
> > > Would memory barriers be sufficient here? Taking a lock just for
> > > reading one member seems excessive...
> >
> > Do you think there's heavy contention on this lock?
>
> This is not about contention. Spin lock should just never be used this
> way. Or any lock actually. The critical section only contains a single
> fetch operation which does not justify using a lock.
> Hence the only guarantee such lock usage provides are the implicit
> memory barriers (from which maybe only one of them is really needed
> depending on the context where this helper is going to be used).
>
> Simply put, the lock is degraded into a memory barrier this way. So
> why not just use the barriers in the first place if only ordering
> guarantees are required? It only makes sense.

As said earlier, it's a lot easier to reason about lock() and unlock()
calls rather than spreading memory barriers in the write and read
sides.
Historically he had several mistakes with barriers, they're simply not
as straightforward to reason as locks.

Plus spreading the barriers in the read and write sides makes the code
not so easy to read, not to mention in case of any new sites updating
the member, we'll have to not forget adding a barrier.

It's just easier to reason and maintain.


>
> > Usually I prefer to go the simplest way, and using locks is a lot more
> > straightforward and easier to understand than memory barriers.
>
> How so? Locks provide the same memory barriers implicitly.

I'm not saying they don't.
I'm talking about easier code to read and maintain.

>
> > Unless it's clear there's an observable performance penalty, keeping
> > it simple is better.
>
> Exactly. Here is where our opinions differ. For me 'simple' means
> without useless locking.
> I mean especially with locks they should only be used when absolutely
> necessary. In a sense of 'use the right tool for the job'. There are
> more lightweight tools possible in this context. Locks provide
> additional guarantees which are not needed here.
>
> On the other hand I understand that using a lock is a 'better safe
> than sorry' approach which should also work. Just keep in mind that
> spinlock may sleep on RT.

It's not about a better safe than sorry, but easier to read, reason
and maintain.

>
> > data_race() may be ok here, at least for one of the unprotected
> > accesses it's fine, but would have to analyse the other 3 cases.
>
> That's exactly my thoughts. Maybe not even the barriers are needed
> after all. This needs to be checked on a per-case basis.
>
> > >
> > > > And then use btrfs_bock_group_used() everywhere in discard.c where =
we
> > > > aren't holding a block group's lock.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >                 add_to_discard_unused_list(discard_ctl, block_gro=
up);
> > > > >         else
> > > > >                 add_to_discard_list(discard_ctl, block_group);
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > >

