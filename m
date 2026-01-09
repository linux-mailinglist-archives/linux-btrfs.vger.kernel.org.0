Return-Path: <linux-btrfs+bounces-20326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E7DD08D6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98CA303869A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAB3382F2;
	Fri,  9 Jan 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEUX5khz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A33AD9D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957128; cv=none; b=pnfS6PAVHT2/gzHqXaNZdFk0zoYLk/DKHWQZVXNc3t9BmHVYVQhUMQa+T1Gk/p/qcyOqlUYQENtFPDS0/IKQxPBU0O9QabgStt859npoLuZvEVrKm9Qz6hyiuLhdi0qYrmZ217QpVjrO+UvkQBzDC65GnBAOumr+f2tEILjCeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957128; c=relaxed/simple;
	bh=eGxqTz4QzuLjvIl5ohsM9gZCTP73SqgWp2uhuG7netg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbWBeaVwOiS+XYpmEOKzQeBZsXYNDZxXAN27nIpuPqnuwtWwXqpwHZlGx5JMtagXoZKsEg8O+Dd3Mekv0qqN4sBBMA5R5hnYUJavv2QPkrfjGKKBWzBmFCGh+pD+CC5nvtgAC9IA/iwwarg0BeGidwqDJI3x7JJSJhzoKvGqWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEUX5khz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE6AC19421
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767957127;
	bh=eGxqTz4QzuLjvIl5ohsM9gZCTP73SqgWp2uhuG7netg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cEUX5khzZZ/Gj/jUQ2bhFWpCW73QNO0aIscaj4zxydr3bzlfqNyTvQfkTXSBq4JTf
	 1baGx49JoW4QCR8aZCPLJZ6DqZRhnXPwHZUNdHnwrLejBGDFPhpvvqu5YOvpanZGu1
	 awCC+gnDC0T5f3sWHV/oQpFhxlt0F6dWjLaF94IasVqatLZZOf7afZUIrHHeWpJ9x4
	 oyC0ud0Acle0hcTPSqc5gwxiGrp3XCQXHpRL1UktwC+OvGUiO3/mNH1AoTNcYjt+Tc
	 PWTaoUxxmIGeGw/epV6v/BEADe1hZ6ExRmO6mfe1bbSik64WOJA76c1z+9eihfViJ9
	 46xnRsILL8XRg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72b495aa81so797993166b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 03:12:07 -0800 (PST)
X-Gm-Message-State: AOJu0YwgEwWPVVwieaTUa7IdkVlcg4YgpOsLKbsoCwGwZE+g6ZwH8zVB
	/teE6nusNVJznXNY4ktw0Q3M5CnmdVnK1HCICk+Sx8IBie4ddvC21Csmh9I6cb0LhaWYU9fwPUZ
	T8cXtpRVkaBeFbyuxAtIu/QN2Px41wlE=
X-Google-Smtp-Source: AGHT+IFVXiD0PQ+KUMhFURdUH7OLpp834oWpGNNdQwM8uzNLox1OPVOHhoXy5WLezZdavuHk2zS2agq3Peda4XzqYU0=
X-Received: by 2002:a17:907:cd0e:b0:b73:5b9a:47c7 with SMTP id
 a640c23a62f3a-b8445413775mr960269066b.51.1767957126065; Fri, 09 Jan 2026
 03:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
 <20260108191733.GA2485498@zen.localdomain>
In-Reply-To: <20260108191733.GA2485498@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 11:11:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4fE1YrARD4UZJWUXzoXK1bZ2k_kaiT5xHuj=yGvFVpPQ@mail.gmail.com>
X-Gm-Features: AZwV_QioY8Wp_i6gOJtmhnLRCQ8Iq1__6QBu6QQmLH5kqk962MaHCyYodjqgnXE
Message-ID: <CAL3q7H4fE1YrARD4UZJWUXzoXK1bZ2k_kaiT5xHuj=yGvFVpPQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after reflinking
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:17=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Jan 08, 2026 at 05:10:04PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Qu reported that generic/164 often fails because the read operations ge=
t
> > zeroes when it expects to either get all bytes with a value of 0x61 or
> > 0x62. The issue stems from truncating the pages from the page cache
> > instead of invalidating, as truncating can zero page contents.
>
> Can you make it more clear if this is a subpage/large folios issue or a
> generic issue? Or maybe just explain the "can zero page contents" in a
> little more detail? I agree that it is the wrong "contract" so your
> change makes sense either way, this is just for future
> knowledge/archaeology.
>
> The documentation of truncate_inode_pages_range only mentions zeroing
> partial pages when "lstart or lend + 1 is not page aligned" but our call
> is
>
>         truncate_inode_pages_range(&inode->i_data,
>                                 round_down(destoff, PAGE_SIZE),
>                                 round_up(destoff + len, PAGE_SIZE) - 1);
>
> which appears to align it?
>
> Sorry if I am missing something obvious :)
>
> >
> > So instead of truncating, invalidate the page cache range with a call t=
o
> > filemap_invalidate_inode(), which besides not doing any zeroing also
> > ensures that while it's invalidating folios, no new folios are added.
> > This helps ensure that buffered reads that happen while a reflink
> > operation is in progress always get either the whole old data (the one
> > before the reflink) or the whole new data, which is what generic/164
> > expects.
> >
> > Reported-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/reflink.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index e746980567da..f7ddd3765249 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
> >       struct inode *src =3D file_inode(file_src);
> >       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> >       int ret;
> > -     int wb_ret;
> >       u64 len =3D olen;
> >       u64 bs =3D fs_info->sectorsize;
> >       u64 end;
> > @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file=
 *file, struct file *file_src,
> >       btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached=
_state);
> >       ret =3D btrfs_clone(src, inode, off, olen, len, destoff, 0);
> >       btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cach=
ed_state);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       /*
> >        * We may have copied an inline extent into a page of the destina=
tion
> >        * range, so wait for writeback to complete before truncating pag=
es
>
> s/truncating/invalidating/
>
> >        * from the page cache. This is a rare case.
> >        */
> > -     wb_ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len)=
;
> > -     ret =3D ret ? ret : wb_ret;
> > +     ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> Even if it's true, not worth doing in a fix like this, but a question:
> I think buffered reads will check for outstanding ordered_extents and
> wait for them. If we are invalidating the cache next, then how can we
> read the file without seeing this ordered_extent? Is this
> wait_ordered_range still necessary?

The call to btrfs_wait_ordered_range() has nothing to do with the read
path waiting or not for ordered extents.

The call is there to flush any dirty page due to copying an inline extent.
Because any dirty page would cause the truncation to fail and run the
risk of not truncating any pages after it (we can have regular extents
following an inline extent for a few cases like compression and
fallocate).

With invalidate it's not necessary as the rest of the range is not skipped.
It can be removed now. Will do that separately.

>
> Again, not a blocker for this patch.
>
> >       /*
> > -      * Truncate page cache pages so that future reads will see the cl=
oned
> > -      * data immediately and not the previous data.
> > +      * Invalidate page cache so that future reads will see the cloned=
 data
> > +      * immediately and not the previous data.
> >        */
> > -     truncate_inode_pages_range(&inode->i_data,
> > -                             round_down(destoff, PAGE_SIZE),
> > -                             round_up(destoff + len, PAGE_SIZE) - 1);
> > +     ret =3D filemap_invalidate_inode(inode, false, destoff, end);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       btrfs_btree_balance_dirty(fs_info);
> >
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static int btrfs_remap_file_range_prep(struct file *file_in, loff_t po=
s_in,
> > --
> > 2.47.2
> >

