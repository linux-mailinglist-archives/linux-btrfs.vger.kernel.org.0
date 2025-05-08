Return-Path: <linux-btrfs+bounces-13832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A8AAFBB1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FDB4C6AA7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24222D4FD;
	Thu,  8 May 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFtWmXgW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C722C339
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711672; cv=none; b=EH6mpO3ELd9iFWKdwEehX5PBjaW1Xiey71kMCkIcyJDBZthlWfgKudZ8dt7IKR30BmB7QGfBx4OAef+ij22+KqtIXvn5UmlRzpso0EwcCS9EjabVY425NBRf1pbGBpq6y7HGnxKaM3IR5xODtsFUHTLhK2K06fIckr7SYdAsc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711672; c=relaxed/simple;
	bh=kEwLciPjJZVU1N71/b0MvqjvUcsJ7k+3M2j1BJo5Nxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAJmTuVQNYzEn2zyTb+xFG1PEts1sKVAoDD9GgvdOff4HcVrRdnl4IFjJALvF+tSEgFPY9xD4uPhErt2QDir8nRQDO+YihXz+hXtT4gmZrK765alHHz671ZhLIo/bTtpQjlCSrgFpynWh7LU/umocTH3UNIHS1/WfTTtkCiSHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFtWmXgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6DBC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746711671;
	bh=kEwLciPjJZVU1N71/b0MvqjvUcsJ7k+3M2j1BJo5Nxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EFtWmXgWayoGvKwo2sYKMB4tTze5LzDE/q5rXNX+V8dnqy2ctGWGo3200Z3TIfB2x
	 9dGHazWK0ZYTKFFGp/4ncPdDcx1DP62KPHq9pgxQLOoPlhSnZd8LuKevYiVjPfFsjY
	 9S/kxTBGc7XQ19V2yNbGx3FO8pZEueLwfY1vqgo1ImBNvPSK7oGhhAyLwzar2E2Dpd
	 22Li9asPHNKt7gV26EjCdA3pEV9nh3JvVxGqOOj/7paFcWlXEAy9GiyhXoYCtUQ/ja
	 fm4wAYyTWdj4h5EvhhuMNAvMRePgKGLakk8l8YXXByjQWeFIqTHOP4NwY3ADTDlAGh
	 WgLN9Djl4K//Q==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso1970384a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 06:41:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGPxTzA1CwvahpyLPzuIKcOjmZa3lz9yrTQAPhGXCUsQKSH+pq
	L3DkUKsWxqCGju5KNN28z7deFBh0ODMBZGQspNcjdF28xR8u6KNghNmRwWTkVSZ7ZwZRp0+Ftwv
	sdbaiCYXMtb0MI9Vzw9u+I/xqQbU=
X-Google-Smtp-Source: AGHT+IFhF7hC4eXi2+loG93+zs5rjtPie9+MqtYjJ4IciUfGkkN+aM7fKNhpsv0lnwVbCH4xNtCeXfKGanopm4TPng8=
X-Received: by 2002:a17:907:9694:b0:ad1:f880:5796 with SMTP id
 a640c23a62f3a-ad1fe6f6ab3mr325325866b.33.1746711659438; Thu, 08 May 2025
 06:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746638347.git.fdmanana@suse.com> <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
In-Reply-To: <20250507223347.GB332956@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 May 2025 14:40:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6tk-Z3bQY8uiZf=CfqfD_9tmpqRTdOS5wHymwgChp+EA@mail.gmail.com>
X-Gm-Features: ATxdqUGcTINvCZvSWmuKh7oQtmCJ9q8M2jsSc1H0-i79pu76Ewei5lgcsZ6iOmw
Message-ID: <CAL3q7H6tk-Z3bQY8uiZf=CfqfD_9tmpqRTdOS5wHymwgChp+EA@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 11:33=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we fail to allocate an ordered extent for a COW write we end up leak=
ing
> > a qgroup data reservation since we called btrfs_qgroup_release_data() b=
ut
> > we didn't call btrfs_qgroup_free_refroot() (which would happen when
> > running the respective data delayed ref created by ordered extent
> > completion or when finishing the ordered extent in case an error happen=
ed).
> >
> > So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate=
 an
> > ordered extent for a COW write.
>
> I haven't tried it myself yet, but I believe that this patch will double
> free reservation from the qgroup when this case occurs.

Nop, see below.

>
> Can you share the context where you saw this bug? Have you run fstests
> with qgroups or squotas enabled? I think this should show pretty quickly
> in generic/475 with qgroups on.

Yes, I have run fstests. I always do before sending a patch, no matter
how simple or trivial it is (or seems to be).

This isn't a scenario that can be triggered with fstests since there
are no test cases that inject memory allocation failures on ordered
extents or anything else.
generic/475 simulates IO failures with dm error, so I don't see why
you think that would be relevant when the problem here is on ordered
extent allocation failure and not IO errors.

>
> Consider, for example, the following execution of the dio case:
>
> btrfs_dio_iomap_begin
>   btrfs_check_data_free_space // reserves the data into `reserved`, sets =
dio_data->data_space_reserved
>   btrfs_get_blocks_direct_write
>     btrfs_create_dio_extent
>       btrfs_alloc_ordered_extent
>         alloc_ordered_extent // fails and frees refroot, reserved is "wro=
ng" now.
>       // error propagates up
>     // error propagates up via PTR_ERR
>
> which brings us to the code:
> if (ret < 0)
>         goto unlock_err;
> ...
> unlock_err:
> ...
> if (dio_data->data_space_reserved) {
>         btrfs_free_reserved_data_space()
> }
>
> so the execution continues...
>
> btrfs_free_reserved_data_space
>   btrfs_qgroup_free_data
>     __btrfs_qgroup_release_data
>       qgroup_free_reserved_data
>         btrfs_qgroup_free_refroot
>
> This will result in a underflow of the reservation once everything
> outstanding gets released.

No, it won't.

For a COW write, before we failed to allocate the ordered extent, at
alloc_ordered_extent(), we called btrfs_qgroup_release_data().
That function will find all subranges in the inode's iotree marked
with EXTENT_QGROUP_RESERVED, clear that bit from them and sum their
lengths into @qgroup_rsv (local variable from alloc_ordered_extent()).

So calling qgroup_free_reserved_data() in an error path such as that
one will do nothing because it can't find any more ranges in the
inode's iotree marked with EXTENT_QGROUP_RESERVED.

So we leak reserved space... from the moment we called
btrfs_qgroup_release_data(), at alloc_ordered_extent(), we transferred
how we track the reserved space - which was intended to be in the
ordered extent and then when the ordered extent completes a delayed
data ref is created and when that delayed ref is ran we release the
space with btrfs_qgroup_free_refroot(). But since we failed to
allocate the ordered extent and the reserved space is no longer
tracked in the inode's iotree, we fail to release qgroup space.

Actually patch 3 in the patchset updates the comments at
alloc_ordered_extent() with those details to make it clear.

Hope it's more clear now what's going on and how qgroup tracks reserved spa=
ce.

Thanks.



>
> Furthermore, raw calls to free_refroot in cases where we have a reserved
> changeset make me worried, because they will run afoul of races with
> multiple threads touching the various bits. I don't see the bugs here,
> but the reservation lifetime is really tricky so I wouldn't be surprised
> if something like that was wrong too.
>
> As of the last time I looked at this, I think cow_file_range handles
> this correctly as well. Looking really quickly now, it looks like maybe
> submit_one_async_extent() might not do a qgroup free, but I'm not sure
> where the corresponding reservation is coming from.
>
> I think if you have indeed found a different codepath that makes a data
> reservation but doesn't release the qgroup part when allocating the
> ordered extent fails, then the fastest path to a fix is to do that at
> the same level as where it calls btrfs_check_data_free_space or (however
> it gets the reservation), as is currently done by the main
> ordered_extent allocation paths. With async_extent, we might need to
> plumb through the reserved extent changeset through the async chunk to
> do it perfectly...
>
> Thanks,
> Boris
>
> >
> > Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space fo=
r ordered extents to fix reserved space leak")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ordered-data.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index ae49f87b27e8..e44d3dd17caf 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_=
extent(
> >       struct btrfs_ordered_extent *entry;
> >       int ret;
> >       u64 qgroup_rsv =3D 0;
> > +     const bool is_nocow =3D (flags &
> > +            ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALL=
OC)));
> >
> > -     if (flags &
> > -         ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)=
)) {
> > +     if (is_nocow) {
> >               /* For nocow write, we can release the qgroup rsv right n=
ow */
> >               ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, =
num_bytes, &qgroup_rsv);
> >               if (ret < 0)
> > @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_=
extent(
> >                       return ERR_PTR(ret);
> >       }
> >       entry =3D kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS)=
;
> > -     if (!entry)
> > +     if (!entry) {
> > +             if (!is_nocow)
> > +                     btrfs_qgroup_free_refroot(inode->root->fs_info,
> > +                                               btrfs_root_id(inode->ro=
ot),
> > +                                               qgroup_rsv, BTRFS_QGROU=
P_RSV_DATA);
> >               return ERR_PTR(-ENOMEM);
> > +     }
> >
> >       entry->file_offset =3D file_offset;
> >       entry->num_bytes =3D num_bytes;
> > --
> > 2.47.2
> >

