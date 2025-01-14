Return-Path: <linux-btrfs+bounces-10968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C31AA10DC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E416805E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5B1F8EFB;
	Tue, 14 Jan 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="Mrrma2M/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E81D3576
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875741; cv=none; b=OLqbKoPznBQ+v+zZatgFg15A5kSj5vjuD5MBPqaRZrmLBc1rd130R5LYBVyETfm1URuWPYJhtaU/HCOQiXZvXpUfHy9SZu6GVGtmuS3n4ZWosw2kDgSQPsyEpcOoBzc7oaWLKFdned+ThAv9P//nQRuC1AJZbB+QlaxZrG4gO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875741; c=relaxed/simple;
	bh=md7czg+AxSgk44YtKS3q7W4Z+wYmhH8S/ZiInpQznsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYV8cKgovra5l0/G4EXCj+8I5WIvKrDxYm84xz8HxaTRrhijbVpfAl2CbpLC/BiYkW4/rIUE3c1PckEhhXipos/2ccsGPLBl0FK+mtM736G+bgF/TB7AqUs1HztfVfIwclYWv7eR87BjoSZgWKS/mp9xtDKbdeoVbdtZQJ8o0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=Mrrma2M/; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29f87f1152cso2951506fac.2
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1736875738; x=1737480538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UkVsY+XBnaH609JcciFT3FGa4AFrlvcmMf+pJ+zaS8=;
        b=Mrrma2M/exHZlhQoU8gIdN5YN7rB8irapMndel0YpIwNysUc9lWlE7vhU7XHd5Y3Mh
         zHs25qfBPkbYlDpvR4SIpUYx66l6rvQ5znTJGYyMm0oaXmfZP04+HRZhZBU9DZjqH/fI
         oxt4OjvH4cPe/7oar4Tk/adVFite54D6e1P4GPptfNU56RVynlkUZLOm04o1lRV587oS
         oAMr1hUv415Xo7K6cxBJCWAQqk74BR9CSP30tUZhzGyL6vqkoMcoIKlmSd0tVYSTaQoT
         t8YZo0nTwVFIgwip3KkrFftWwVuU8/dqqOyQWl3Q4U/54nXd9fai9C8gnPHyzPj1aH8U
         mx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736875738; x=1737480538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UkVsY+XBnaH609JcciFT3FGa4AFrlvcmMf+pJ+zaS8=;
        b=hHCBwwxZLqch9ojZvWXoULTO3dAMim80orDx+tX0xTM0Rs0baFMgwAy/kRoPbmNqhK
         /+Dfa+J9Nep1de3viVgDIqvaMTzQWxi5YChKu36ZU7+4joI2mCldougfS7p0SxAaPNsh
         j0T0vhNDrI42omuntwZEKrD6mKfW0IGrLPRW1ALDF0eVeSFEHax4/iIcLeMMq5rehphu
         M/gfQ3VCFp+H1tZxy+/4UTKwrftHeccheyK3I9kN9AF9rn/W4GLvzt0MVtGZRmsa7UCt
         whQbGsqzwtZrVgEt3QKRUpuSmdQfGKiaWNsIr7CFdf3/X5X/Vu/xP+MM9SU02BPZRPE0
         JVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiRmM4NtygGGyjoygZHVFGD/q2QP3uW1dY+sQqpmPhmM/q5IMsnPqub4y2Z4zAU2Xz6N/MVEz+OZ4j3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPh+03+e6tt2QG4WLdnB1M7ar29iWsD/Flnx1h/3FMfo6rnRpl
	fLAj7qjXy/0WThfLT9c2L2qFY1VMK0FKxxLF1jw7j9BhoIGmFM/Jqmdc1xJu2eOUzbvkN4VbX1I
	FMTgn67CT648Y13ya7bb1BzfYpHl/vFXgq27EL4dcaFR2edaTZww=
X-Gm-Gg: ASbGncs8wVh0a+KkKPR5XsrtPEs7MvyoOmZnJslqlCEJbI8KGNNYiCObOi46kwwBzF9
	u8MkM/AvFcXEC2K8lJYY3bqnQNC15zleLxdil
X-Google-Smtp-Source: AGHT+IECf0oi/SeK76f+A4Sdp0HWdtJS2nPQVN8KBnvZXDgMatvDvvpRAMM8DQAaMYtM/TvYWxddXNOECKH1xjmGK5A=
X-Received: by 2002:a05:6871:6503:b0:2a3:8331:717c with SMTP id
 586e51a60fabf-2aa0669eb33mr15277604fac.10.1736875738543; Tue, 14 Jan 2025
 09:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <f31bb86619489274227cae2184283f96a3b7bf36.1603460665.git.josef@toxicpanda.com>
 <CAL3q7H54_ANFW6ZQoapzFb0i89zcAemjfxpgy6TsnYzLZdcNJg@mail.gmail.com>
In-Reply-To: <CAL3q7H54_ANFW6ZQoapzFb0i89zcAemjfxpgy6TsnYzLZdcNJg@mail.gmail.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Tue, 14 Jan 2025 19:28:47 +0200
X-Gm-Features: AbW1kvb42l5ioyRET3XnAgGtnFqKytKpITWnAkrQ48mofuSGRJeU9h6Jx9tCeZ8
Message-ID: <CAOcd+r3ergmQzA=LJmwiiDmq1kB_4KWkZ2Cds2RXr5o0j6y8Rg@mail.gmail.com>
Subject: Re: [PATCH 2/8] btrfs: update last_byte_to_unpin in switch_commit_roots
To: fdmanana@gmail.com
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josef, Filipe,


On Wed, Nov 4, 2020 at 5:15=E2=80=AFPM Filipe Manana <fdmanana@gmail.com> w=
rote:
>
> On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > While writing an explanation for the need of the commit_root_sem for
> > btrfs_prepare_extent_commit, I realized we have a slight hole that coul=
d
> > result in leaked space if we have to do the old style caching.  Conside=
r
> > the following scenario
> >
> >  commit root
> >  +----+----+----+----+----+----+----+
> >  |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> >  +----+----+----+----+----+----+----+
> >  0    1    2    3    4    5    6    7
> >
> >  new commit root
> >  +----+----+----+----+----+----+----+
> >  |    |    |    |\\\\|    |    |\\\\|
> >  +----+----+----+----+----+----+----+
> >  0    1    2    3    4    5    6    7
> >
> > Prior to this patch, we run btrfs_prepare_extent_commit, which updates
> > the last_byte_to_unpin, and then we subsequently run
> > switch_commit_roots.  In this example lets assume that
> > caching_ctl->progress =3D=3D 1 at btrfs_prepare_extent_commit() time, w=
hich
> > means that cache->last_byte_to_unpin =3D=3D 1.  Then we go and do the
> > switch_commit_roots(), but in the meantime the caching thread has made
> > some more progress, because we drop the commit_root_sem and re-acquired
> > it.  Now caching_ctl->progress =3D=3D 3.  We swap out the commit root a=
nd
> > carry on to unpin.
>
> Ok, to unpin at btrfs_finish_extent_commit().
>
> So it took me a while to see the race:
>
> 1) The caching thread was running using the old commit root when it
> found the extent for [2, 3);
>
> 2) Then it released the commit_root_sem because it was in the last
> item of a leaf and the semaphore was contended, and set ->progress to
> 3 (value of 'last'), as the last extent item in the current leaf was
> for the extent for range [2, 3);
>
> 3) Next time it gets the commit_root_sem, will start using the new
> commit root and search for a key with offset 3, so it never finds the
> hole for [2, 3).
>
> So the caching thread never saw [2, 3) as free space in any of the
> commit roots, and by the time finish_extent_commit() was called for
> the range [0, 3), ->last_byte_to_unpin was 1, so it only returned the
> subrange [0, 1) to the free space cache, skipping [2, 3).
>
> >
> > In the unpin code we have last_byte_to_unpin =3D=3D 1, so we unpin [0,1=
),
> > but do not unpin [2,3).
> > However because caching_ctl->progress =3D=3D 3 we
> > do not see the newly free'd section of [2,3), and thus do not add it to
> > our free space cache.  This results in us missing a chunk of free space
> > in memory.
>
> In memory and on disk too, unless we have a power failure before
> writing the free space cache to disk.
>
> >
> > Fix this by making sure the ->last_byte_to_unpin is set at the same tim=
e
> > that we swap the commit roots, this ensures that we will always be
> > consistent.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good, thanks.
>
> > ---
> >  fs/btrfs/ctree.h       |  1 -
> >  fs/btrfs/extent-tree.c | 25 -------------------------
> >  fs/btrfs/transaction.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 39 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 8a83bce3225c..41c76db65c8e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2592,7 +2592,6 @@ int btrfs_free_reserved_extent(struct btrfs_fs_in=
fo *fs_info,
> >                                u64 start, u64 len, int delalloc);
> >  int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 st=
art,
> >                               u64 len);
> > -void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info);
> >  int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
> >  int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
> >                          struct btrfs_ref *generic_ref);
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index a98f484a2fc1..ee7bceace8b3 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2730,31 +2730,6 @@ btrfs_inc_block_group_reservations(struct btrfs_=
block_group *bg)
> >         atomic_inc(&bg->reservations);
> >  }
> >
> > -void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
> > -{
> > -       struct btrfs_caching_control *next;
> > -       struct btrfs_caching_control *caching_ctl;
> > -       struct btrfs_block_group *cache;
> > -
> > -       down_write(&fs_info->commit_root_sem);
> > -
> > -       list_for_each_entry_safe(caching_ctl, next,
> > -                                &fs_info->caching_block_groups, list) =
{
> > -               cache =3D caching_ctl->block_group;
> > -               if (btrfs_block_group_done(cache)) {
> > -                       cache->last_byte_to_unpin =3D (u64)-1;
> > -                       list_del_init(&caching_ctl->list);
> > -                       btrfs_put_caching_control(caching_ctl);
> > -               } else {
> > -                       cache->last_byte_to_unpin =3D caching_ctl->prog=
ress;
> > -               }
> > -       }
> > -
> > -       up_write(&fs_info->commit_root_sem);
> > -
> > -       btrfs_update_global_block_rsv(fs_info);
But this call is also removed. Is this intentional? As it doesn't seem
to be related to the current fix.

Thanks,
Alex.


> > -}
> > -
> >  /*
> >   * Returns the free cluster for the given space info and sets empty_cl=
uster to
> >   * what it should be based on the mount options.
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 52ada47aff50..9ef6cba1eb59 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -155,6 +155,7 @@ static noinline void switch_commit_roots(struct btr=
fs_trans_handle *trans)
> >         struct btrfs_transaction *cur_trans =3D trans->transaction;
> >         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >         struct btrfs_root *root, *tmp;
> > +       struct btrfs_caching_control *caching_ctl, *next;
> >
> >         down_write(&fs_info->commit_root_sem);
> >         list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
> > @@ -180,6 +181,44 @@ static noinline void switch_commit_roots(struct bt=
rfs_trans_handle *trans)
> >                 spin_lock(&cur_trans->dropped_roots_lock);
> >         }
> >         spin_unlock(&cur_trans->dropped_roots_lock);
> > +
> > +       /*
> > +        * We have to update the last_byte_to_unpin under the commit_ro=
ot_sem,
> > +        * at the same time we swap out the commit roots.
> > +        *
> > +        * This is because we must have a real view of the last spot th=
e caching
> > +        * kthreads were while caching.  Consider the following views o=
f the
> > +        * extent tree for a block group
> > +        *
> > +        * commit root
> > +        * +----+----+----+----+----+----+----+
> > +        * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> > +        * +----+----+----+----+----+----+----+
> > +        * 0    1    2    3    4    5    6    7
> > +        *
> > +        * new commit root
> > +        * +----+----+----+----+----+----+----+
> > +        * |    |    |    |\\\\|    |    |\\\\|
> > +        * +----+----+----+----+----+----+----+
> > +        * 0    1    2    3    4    5    6    7
> > +        *
> > +        * If the cache_ctl->progress was at 3, then we are only allowe=
d to
> > +        * unpin [0,1) and [2,3], because the caching thread has alread=
y
> > +        * processed those extents.  We are not allowed to unpin [5,6),=
 because
> > +        * the caching thread will re-start it's search from 3, and thu=
s find
> > +        * the hole from [4,6) to add to the free space cache.
> > +        */
> > +       list_for_each_entry_safe(caching_ctl, next,
> > +                                &fs_info->caching_block_groups, list) =
{
> > +               struct btrfs_block_group *cache =3D caching_ctl->block_=
group;
> > +               if (btrfs_block_group_done(cache)) {
> > +                       cache->last_byte_to_unpin =3D (u64)-1;
> > +                       list_del_init(&caching_ctl->list);
> > +                       btrfs_put_caching_control(caching_ctl);
> > +               } else {
> > +                       cache->last_byte_to_unpin =3D caching_ctl->prog=
ress;
> > +               }
> > +       }
> >         up_write(&fs_info->commit_root_sem);
> >  }
> >
> > @@ -2293,8 +2332,6 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
> >                 goto unlock_tree_log;
> >         }
> >
> > -       btrfs_prepare_extent_commit(fs_info);
> > -
> >         cur_trans =3D fs_info->running_transaction;
> >
> >         btrfs_set_root_node(&fs_info->tree_root->root_item,
> > --
> > 2.26.2
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D

