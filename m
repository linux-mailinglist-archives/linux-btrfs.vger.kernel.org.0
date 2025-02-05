Return-Path: <linux-btrfs+bounces-11283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB981A28861
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5323C1881C47
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCDB22CBEE;
	Wed,  5 Feb 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsvVjIQe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72122CBDA
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752229; cv=none; b=ut1aquU5PRaIFNdhdJui2AC3brEg0sLZlJdgT5inXnkJwRDGbEw1Rt0m2LlUSdVmRZ1uXzKZI3N7K/qY4QReu5lX05x/4G7nO8IeeVBuq6E/hsBodoWcsmmOl4UgeOkQO/JqaJNtKiMUGwNaGFUYmllIvwLgiDtFYLgpuKV2YJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752229; c=relaxed/simple;
	bh=PF8y8rOpqPwB+TwQwlrzzu+cSI7AKnFKY+MahXgNEzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAKPQgLj715BzgoatZSN7W5nGM/oXxLtKnD3g5O+i4pcMrbqSwLAOgRvamyaTuubnN9vnPt+q2liCiO8JN7jnqRk9+d/b5YNCKdpOh3LSIGWW/fz0sQnkzaxdQJ5l9bcKhmbOoqAFMK6EZtwUnnTocmgEKjS9KE+Wr9rOZ5oLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsvVjIQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33090C4CEE5
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738752229;
	bh=PF8y8rOpqPwB+TwQwlrzzu+cSI7AKnFKY+MahXgNEzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IsvVjIQeDq/DuCqPHmv8VlgtHflppixBVEKRYKcDFbn993uk2U5l+h9cc0LNSM3Zt
	 babBoFDZe7QCcl3+rHh1L/A6fQONc8IwMh7AGc+eJtLvmANPbkMgvcpd8AuQHRCapr
	 NV80FM0DpiV/zaoUI4vxafX2qM7rUkI+W1/RPiHZh3991d3cYhLDB/32imgsnHrpkF
	 4JAdZejyJtwnpybCdFYprfuXi13oD9FuJbyXixUv9dH+FFUudFI7FNww4edCsLmE22
	 S/7Z+0c1VinLmV+TgnkHmyZx0VmpFx+IatvRYZX1IURmn6hIr8AiGKMmnt6xeZrZQ2
	 P3zAfoxdYAMSQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so1190309066b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 02:43:49 -0800 (PST)
X-Gm-Message-State: AOJu0YwrabOk4tbCdZudBVESvJXH2XMoRpS0ix2e2mFAJ0mKuI5chQkJ
	hrTrcZSImJACUTKD5hnvQGESJLOuH4JeK2af4fhB7UWaXUrKzwbzM1VuWGO3IwKxZ3amorfQb+a
	FkmIxqHMN0d2bZYuM19qxjiWUXmY=
X-Google-Smtp-Source: AGHT+IFznXYA1Z3YI3TqgqvXW7NbdKv9IVsiFTzJ8tHAwvGWu5LShYzpj7cF7O4oZBVZuqZ4iVD/YawVk0IJlORPDd8=
X-Received: by 2002:a17:907:c28:b0:ab7:c1f:2b63 with SMTP id
 a640c23a62f3a-ab75e2a7450mr225515766b.27.1738752227656; Wed, 05 Feb 2025
 02:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
 <a94fb3db-ac05-4fea-afda-df42cd9286b1@gmx.com> <CAL3q7H5nYQiV++o6jtOc98S1P7B1O2kwFKXa8e2u-GzAdJAaoA@mail.gmail.com>
 <9fba7307-fb07-4d83-8d25-295dc5562e06@gmx.com>
In-Reply-To: <9fba7307-fb07-4d83-8d25-295dc5562e06@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Feb 2025 10:43:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H68hC3pbu5KnZRdM7wcanx1jmzwdqJZrbS0=tp9eKDc3A@mail.gmail.com>
X-Gm-Features: AWEUYZnDVqT0Q95Gx1ne52OD7krT5sSDJReol5jVcD_qQn2NZ6zd4i2v4dDZ9DE
Message-ID: <CAL3q7H68hC3pbu5KnZRdM7wcanx1jmzwdqJZrbS0=tp9eKDc3A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix stale page cache after race between readahead
 and direct IO write
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2025/2/5 18:54, Filipe Manana =E5=86=99=E9=81=93:
> > On Wed, Feb 5, 2025 at 5:15=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> [...]
> >> I'm not confident enough about this lock, as it can cross several page=
s.
> >>
> >> E.g. if we have the following case, 4K page size 4K block size.
> >>
> >>           0       4K      8K      12K     16K
> >>           |       |///////|               |
> >>
> >> And range [4K, 8K) is uptodate, and it has been submitted for writebac=
k,
> >> and finished writeback.
> >> But it still have ordered extent, not yet finished.
> >>
> >> Then we go into the following call chain:
> >> btrfs_lock_and_write_flush()
> >> |- btrfs_start_ordered_extent()
> >>      |- filemap_fdatawrite_range()
> >>
> >> Which will try to writeback the range [4K, 8K) again.
> >
> > But you just said above that the writeback has finished...
>
> You're right, for the writeback finished case, the page is no longer
> dirty and write path will not try to hold the lock.
>
> So it's still only possible for subpage with partial uptodate page suppor=
t.
> Not possible for the current cases.
>
> >
> >> But since the folio at [4K, 8K) is going to be passed to
> >> btrfs_do_readpage(), it should already have been locked.
> >>
> >> Thus the writeback will never be able to lock the folio, thus causing =
a
> >> deadlock.
> >
> > readahead (and readpage) are never called for pages that are already
> > in the page cache,
> > so how can that happen?
>
> Mind to be more explicit on the readahead requirement?
> E.g. if we have a folio that's dirty but not uptodate, what will happen?

I would say flushing (start writeback and wait for it to complete) is
being triggered elsewhere outside btrfs,
otherwise we would always deadlock there, no matter if we range lock
only the range for that page or a wider range that includes the page.

And we haven't observed that for ages (for the non subpage case at least).

>
> I know readapge can be called on page that's already in the page cache,
> especially for subpage cases (although not for now).

So you're saying it can after some patchset that is not yet merged.

>
> E.g. 16K page size, 4K block size.
>
>     0       4K       8K      12K     16K
>     |       |////////|               |
>
> Where [4K, 8K) is dirtied by buffered write, which lands exactly at [4K,
> 8K).
>
> It's not possible for now, because at buffered write we will read out
> the whole page if the write is not page aligned.
>
> But XFS/EXT4 allows to skip the full page read, and just dirty the block
> aligned range, and I'm making btrfs to support that.
> (https://lore.kernel.org/linux-btrfs/cover.1736848277.git.wqu@suse.com/)
>
> So in that case, if we hit a such dirty but not uptodate page, will
> readahead still try to read it, because the folio is not uptodate.
>
> >
> > And why do you think that is specific to the case where the range
> > covers more than one page?
> > I.e. why doesn't the current scenario of locking only [4K, 8K) doesn't
> > lead to that?
>
> Right, the dead lock is really limited to the subpage + partial uptodate
> case.
>
> But I really believe, without such subpage mindset, we are never going
> to support larger data folios.

I get it that it's frustrating and it's unfortunate, but I'm working
with the infrastructure we currently have and with a regression fix
and backport in mind.

>
> >
> >>
> >> Or did I miss something specific to readahead so it will avoid readahe=
ad
> >> on already uptodate pages?
> >
> > It will skip pages already in the page cache (whether uptodate, under
> > writeback, etc).
> >
> > If you look closer, what this patch is doing is restoring the
> > behaviour we had before
> > commit ac325fc2aad5 ("btrfs: do not hold the extent lock for entire
> > read"), with the
> > exception of doing the unlock in readahead/readpage instead of when
> > submitted bios complete.
>
> I'm fine reverting to the old behavior, and so far it looks good to me.
>
> So I can give it a reviewed-by:
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>
>
> My concern is, with the multi-folio lock back, what is the proper way to
> avoid the subpage deadlock for subpage partial uptodate folio, and
> future larger data folio?
>
>
> My current fix will not be feasible, as it relies on the single folio
> pointer, to determine if btrfs_start_ordered_extent() should skip
> writeback, and now we have multi-folio range back.
>
> Maybe we should just make those
> btrfs_lock_and_flush_ordered_range()/btrfs_start_ordered_extent() to
> avoid writeback for those read page related call sites?

Maybe.
I can't advise because I haven't been actively involved in large folio
support or subpage support,
and it would take quite a lot of time for me to grok all we have and
the current problems (plus I
don't have access to a machine to test subpage code).

>
> I know it's not your responsibility to bother those subpage cases, but
> if you can give some ideas/advices, it would be great.
>
> Thanks,
> Qu
>
> >
> > If there was a possibility for such a deadlock, we would almost
> > certainly have noticed it before,
> > as that has been the behaviour for ages until that commit that landed
> > last summer.
> >
> >
> >>
> >>
> >> And even if it will not cause the above deadlock, I'm not confident th=
e
> >> mentioned subpage fix conflict can be proper fixed.
> >> In the subpage fix, I can only add a folio parameter to
> >> btrfs_lock_and_flush_ordered_range(), but in this case, we have multip=
le
> >> folios, how can we avoid the same subpage dead lock then?
> >
> > About the subpage case I have no idea.
> > But given that readahead/readpage is never called for pages already in
> > the page cache, I don't think there should be a problem even for
> > subpage scenario.
> >
> > We also have many places where we lock ranges wider than 1 page, so I
> > don't see why this specific place would be a problem.
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>        while ((folio =3D readahead_folio(rac)) !=3D NULL)
> >>>                btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_=
em_start);
> >>>
> >>> +     unlock_extent(&inode->io_tree, start, end, &cached_state);
> >>> +
> >>>        if (em_cached)
> >>>                free_extent_map(em_cached);
> >>>        submit_one_bio(&bio_ctrl);
> >>
>

