Return-Path: <linux-btrfs+bounces-5108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8878C9AAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA71F2131B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163053E49D;
	Mon, 20 May 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj9wyQPY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319C3A8D8
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198428; cv=none; b=E0MnlbsK0G/SiUJAWhLl8tnIHINJuzL3mU7yD4uhRJnMBYZ6cbQINAecWlRXBeWA2T4TOe+W06+JUDGiBTVMgpdxwjEzGVJWZheCtzcjyP/xS9/nz6rHdIWFBsfGtAK8o1ZAwdLdPfkO37xMRAw5IPAB/YFdjSjUGjuDRJIZeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198428; c=relaxed/simple;
	bh=OKSqnyIcp0UT77Tc67J2IicFM0kgNENwsgaTfrp9sek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYSl9QgELR/q7xKNM6RnPuQWlY051N7weaU+H17NdGkKLbiFv4c+AKzkTUe0EwpYhulRsMCnii+BgzmdY1JH7S6cmUOwZy4P2kylNAgIBPvX8P7j06T/fsbuUA4NhqxDSpOJ43z4fTiGXr1FTBK4S3gJa/Mgb2d/cmITuX4GqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj9wyQPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F3AC2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198428;
	bh=OKSqnyIcp0UT77Tc67J2IicFM0kgNENwsgaTfrp9sek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vj9wyQPYgXNYwlnYImKTnMa/fenCVkyv/rYXzBVRUUiAc/4bs/wF+FcBzudqliyLW
	 jMGaTsa96EW0CkQylVMA4PDzTZ1OrrV/z9c9EGGJIJ+CNhfd5XLIOxYf4beiNR0s0f
	 bUp0/ezE8qGlvJss4Ns5HgLcVdC34/T/GqCM+yar8LA5GS/F1HOoJ7ojz1hkOuSpcQ
	 Fg4sbC2arYzTKo4pqQovPN9V9JMWhe/hYb66jbMOtX4QpmTMl8aDPzsRtXArSNk8mf
	 bDS3iR4XLrKBpAE1mupRGd6pt5hl5o0/DCddf3VXp+gRdsoBoUgxIAjxGSS7x0UwZo
	 s9LBNfLFoAR5A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f174e316eso3014979e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 02:47:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfKOLg/evt5QR0HNDOrnx6XOtrvb2yXHi2l71f9jpJJiIxh/+6
	Y0lqp6O1NAjonu1XYn5y1auH88EhdpqimFI0Q5WrRh1+oCi909EDR41/VNkHpYtc22V1P/03XL6
	f0EalQpH3B4aseQ+cc/Etn+rf+Lw=
X-Google-Smtp-Source: AGHT+IHGwaK0mzKtuEmPep1lWRf4yRZuGG9iVc7ttum1q+JgUStU70sjipZYbEY675rg+3F7moQ5MUxBopkIqoVjbAo=
X-Received: by 2002:a05:6512:b18:b0:523:bbcd:ed5f with SMTP id
 2adb3069b0e04-523bbcdedcemr9492459e87.33.1716198426384; Mon, 20 May 2024
 02:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715964570.git.fdmanana@suse.com> <bc50545a6356d32644de712bbd0e6128276596a2.1715964570.git.fdmanana@suse.com>
 <487495ec-8c14-4654-89b6-7b74c4e41be8@gmx.com>
In-Reply-To: <487495ec-8c14-4654-89b6-7b74c4e41be8@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 10:46:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6gwO45TOoPRXGguJb4EVEWjuQJh09WxKtyUjf5_3LJdA@mail.gmail.com>
Message-ID: <CAL3q7H6gwO45TOoPRXGguJb4EVEWjuQJh09WxKtyUjf5_3LJdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: ensure fast fsync waits for ordered extents
 after a write failure
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 6:28=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/5/18 02:22, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If a write path in COW mode fails, either before submitting a bio for t=
he
> > new extents or an actual IO error happens, we can end up allowing a fas=
t
> > fsync to log file extent items that point to unwritten extents.
> >
> > This is because dropping the extent maps happens when completing ordere=
d
> > extents, at btrfs_finish_one_ordered(), and the completion of an ordere=
d
> > extent is executed in a work queue.
> >
> > This can result in a fast fsync to start logging file extent items base=
d
> > on existing extent maps before the ordered extents complete, therefore
> > resulting in a log that has file extent items that point to unwritten
> > extents, resulting in a corrupt file if a crash happens after and the l=
og
> > tree is replayed the next time the fs is mounted.
> >
> > This can happen for both direct IO writes and buffered writes.
> >
> > For example consider a direct IO write, in COW mode, that fails at
> > btrfs_dio_submit_io() because btrfs_extract_ordered_extent() returned a=
n
> > error:
> >
> > 1) We call btrfs_finish_ordered_extent() with the 'uptodate' parameter
> >     set to false, meaning an error happened;
> >
> > 2) That results in marking the ordered extent with the BTRFS_ORDERED_IO=
ERR
> >     flag;
> >
> > 3) btrfs_finish_ordered_extent() queues the completion of the ordered
> >     extent - so that btrfs_finish_one_ordered() will be executed later =
in
> >     a work queue. That function will drop extent maps in the range when
> >     it's executed, since the extent maps point to unwritten locations
> >     (signaled by the BTRFS_ORDERED_IOERR flag);
> >
> > 4) After calling btrfs_finish_ordered_extent() we keep going down the
> >     write path and unlock the inode;
> >
> > 5) After that a fast fsync starts and locks the inode;
> >
> > 6) Before the work queue executes btrfs_finish_one_ordered(), the fsync
> >     task sees the extent maps that point to the unwritten locations and
> >     logs file extent items based on them - it does not know they are
> >     unwritten, and the fast fsync path does not wait for ordered extent=
s
> >     to complete, which is an intentional behaviour in order to reduce
> >     latency.
> >
> > For the buffered write case, here's one example:
> >
> > 1) A fast fsync begins, and it starts by flushing delalloc and waiting =
for
> >     the writeback to complete by calling filemap_fdatawait_range();
> >
> > 2) Flushing the dellaloc created a new extent map X;
> >
> > 3) During the writeback some IO error happened, and at the end io callb=
ack
> >     (end_bbio_data_write()) we call btrfs_finish_ordered_extent(), whic=
h
> >     sets the BTRFS_ORDERED_IOERR flag in the ordered extent and queues =
its
> >     completion;
> >
> > 4) After queuing the ordered extent completion, the end io callback cle=
ars
> >     the writeback flag from all pages (or folios), and from that moment=
 the
> >     fast fsync can proceed;
> >
> > 5) The fast fsync proceeds sees extent map X and logs a file extent ite=
m
> >     based on extent map X, resulting in a log that points to an unwritt=
en
> >     data extent - because the ordered extent completion hasn't run yet,=
 it
> >     happens only after the logging.
> >
> > To fix this make btrfs_finish_ordered_extent() set the inode flag
> > BTRFS_INODE_NEEDS_FULL_SYNC in case an error happened for a COW write,
> > so that a fast fsync will wait for ordered extent completion.
> >
> > Note that this issues of using extent maps that point to unwritten
> > locations can not happen for reads, because in read paths we start by
> > locking the extent range and wait for any ordered extents in the range
> > to complete before looking for extent maps.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks for the updated commit messages, it's much clear for the race wind=
ow.
>
> And since we no longer try to run finish_ordered_io() inside the endio
> function, we should no longer hit the memory allocation warning inside
> irq context.
>
> But the inode->lock usage seems unsafe to me, comment inlined below:
> [...]
> > @@ -478,10 +485,10 @@ static inline void btrfs_set_inode_full_sync(stru=
ct btrfs_inode *inode)
> >        * while ->last_trans was not yet updated in the current transact=
ion,
> >        * and therefore has a lower value.
> >        */
> > -     spin_lock(&inode->lock);
> > +     spin_lock_irqsave(&inode->lock, flags);
> >       if (inode->last_reflink_trans < inode->last_trans)
> >               inode->last_reflink_trans =3D inode->last_trans;
> > -     spin_unlock(&inode->lock);
> > +     spin_unlock_irqrestore(&inode->lock, flags);
>
> IIRC this is not how we change the lock usage to be irq safe.
> We need all lock users to use irq variants.
>
> Or we can hit situation like:
>
>         Thread A
>
>         spin_lock(&inode->lock);
> --- IRQ happens for the endio ---
>         spin_lock_irqsave();
>
> Then we dead lock.
>
> Thus all inode->lock users needs to use the irq variant, which would be
> a huge change.

Indeed, I missed that, thanks.

>
> I guess if we unconditionally wait for ordered extents inside
> btrfs_sync_file() would be too slow?

No way. Not waiting for ordered extent completion is one of the main
things that makes the fast fsync faster then the full fsync.
It's ok to wait only in case of errors, since they are unexpected and
unlikely, and in error cases the ordered extent completion doesn't do
much (no trees to update).

Fixed in v4, thanks.

>
> Thanks,
> Qu
>
> >   }
> >
> >   static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 =
generation)
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 0c7c1b42028e..d635bc0c01df 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1894,6 +1894,21 @@ int btrfs_sync_file(struct file *file, loff_t st=
art, loff_t end, int datasync)
> >               btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
> >                                                     &ctx.ordered_extent=
s);
> >               ret =3D filemap_fdatawait_range(inode->i_mapping, start, =
end);
> > +             if (ret)
> > +                     goto out_release_extents;
> > +
> > +             /*
> > +              * Check again the full sync flag, because it may have be=
en set
> > +              * during the end IO callback (end_bbio_data_write() ->
> > +              * btrfs_finish_ordered_extent()) in case an error happen=
ed and
> > +              * we need to wait for ordered extents to complete so tha=
t any
> > +              * extent maps that point to unwritten locations are drop=
ped and
> > +              * we don't log them.
> > +              */
> > +             full_sync =3D test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> > +                                  &BTRFS_I(inode)->runtime_flags);
> > +             if (full_sync)
> > +                     ret =3D btrfs_wait_ordered_range(inode, start, le=
n);
> >       }
> >
> >       if (ret)
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 44157e43fd2a..55a9aeed7344 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -388,6 +388,37 @@ bool btrfs_finish_ordered_extent(struct btrfs_orde=
red_extent *ordered,
> >       ret =3D can_finish_ordered_extent(ordered, page, file_offset, len=
, uptodate);
> >       spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
> >
> > +     /*
> > +      * If this is a COW write it means we created new extent maps for=
 the
> > +      * range and they point to unwritten locations if we got an error=
 either
> > +      * before submitting a bio or during IO.
> > +      *
> > +      * We have marked the ordered extent with BTRFS_ORDERED_IOERR, an=
d we
> > +      * are queuing its completion below. During completion, at
> > +      * btrfs_finish_one_ordered(), we will drop the extent maps for t=
he
> > +      * unwritten extents.
> > +      *
> > +      * However because completion runs in a work queue we can end up =
having
> > +      * a fast fsync running before that. In the case of direct IO, on=
ce we
> > +      * unlock the inode the fsync might start, and we queue the compl=
etion
> > +      * before unlocking the inode. In the case of buffered IO when wr=
iteback
> > +      * finishes (end_bbio_data_write()) we queue the completion, so i=
f the
> > +      * writeback was triggered by a fast fsync, the fsync might start
> > +      * logging before ordered extent completion runs in the work queu=
e.
> > +      *
> > +      * The fast fsync will log file extent items based on the extent =
maps it
> > +      * finds, so if by the time it collects extent maps the ordered e=
xtent
> > +      * completion didn't happen yet, it will log file extent items th=
at
> > +      * point to unwritten extents, resulting in a corruption if a cra=
sh
> > +      * happens and the log tree is replayed. Note that a fast fsync d=
oes not
> > +      * wait for completion of ordered extents in order to reduce late=
ncy.
> > +      *
> > +      * Set a flag in the inode so that the next fast fsync will wait =
for
> > +      * ordered extents to complete before starting to log.
> > +      */
> > +     if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
> > +             btrfs_set_inode_full_sync(inode);
> > +
> >       if (ret)
> >               btrfs_queue_ordered_fn(ordered);
> >       return ret;

