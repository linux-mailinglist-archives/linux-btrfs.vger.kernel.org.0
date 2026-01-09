Return-Path: <linux-btrfs+bounces-20332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E693D09F6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8600D30745B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24835B153;
	Fri,  9 Jan 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRVSBHqw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7F35B135
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962199; cv=none; b=cB0XtBUee/qUDgV+76rdi0td7SMAnAAYkNUDCTldqa6u7NiO+zrOp9m4a83iQ3oas4ROXRRgqXSst6f6kMDbkpJd8DY47nnGxndFqMnhHzn4Ic6Jhat9GidZQiqsfC+tGt2K7vS7C0LDzwl/MR8iUKwhHes9hxFha+ZbdujwVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962199; c=relaxed/simple;
	bh=24H8ghIN0mo46aQRappBArCdRzMizawyd4qiKsVO9wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8A8eQBa21A4Yp4RanDyeR0xA1zmiexjNT8tqKdBQ+ZY5ILzOr1w98sn2t3K+1Or+2uNMlprpm+I8JUBNY9lmJWTwi7FcSDPW+7iPfX5BtV5ADEQ6AyX75V/ReLfnpAz2UoUPZkDXOp2kNTp2ZOHhh+RVAmHYnVsWl5YkmdTwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRVSBHqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F71C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767962199;
	bh=24H8ghIN0mo46aQRappBArCdRzMizawyd4qiKsVO9wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oRVSBHqwxM5TkPYBmN6ETL/fq8eG6jDSUG0+GgqkaHstsl3x2Jj92OdxktONAKq+L
	 wuS0V028pqhPoKCruIelEXWb4VgPzgB1kh18o/f7iDPz2nSyynDiqoYYt4pNkxGWQE
	 6KZKrYQYFIDSKpEfFTd1tdCg2wpcSttgRmGhSgbg1EdqlX1JS2T+gesl6v0zoYD+Gp
	 zX/MK9YsLpzJ5CSxiSTF/NZIlwwb2EPVjlySy+7BP3ZG1G6Js85aVZ0nmvaZQjyslP
	 nk0ul9APrIVO5wVhqs2zyiHsvz8navX//WFroNkBdR/RJeKDCcusDmPgozDKrlUnxd
	 EJJq4/Ww6PRoQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79af62d36bso732588866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 04:36:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyLRuHwjdAXnorovA1dv9k7YS8Sr3f3BcD+S8ZR+82R6qYBwAln
	gRXej0cGYoFBGY5b9z46doKF1LXttKUtxECszPZGWzH9kImY1HPk7GdsIuDHGJPsHLhWIfeXz2H
	8xbYhcYuvR1O6N2ya3DAAHVs1+Rp7eDU=
X-Google-Smtp-Source: AGHT+IGMUx8hQ4fQQYzXiRXQhB9E6y0WdvCFzL6YUfbwnlRAOHNMervigBNkhw2YyHPMBczlLEnd86M95rbd9LYH7vk=
X-Received: by 2002:a17:907:2d0b:b0:b73:870f:fa32 with SMTP id
 a640c23a62f3a-b8444f93553mr1031073166b.43.1767962197467; Fri, 09 Jan 2026
 04:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
 <20260108191733.GA2485498@zen.localdomain> <CAL3q7H4fE1YrARD4UZJWUXzoXK1bZ2k_kaiT5xHuj=yGvFVpPQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4fE1YrARD4UZJWUXzoXK1bZ2k_kaiT5xHuj=yGvFVpPQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 12:36:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4KEbV6--=2NS3ttu+zhTEK3DpoSgdh+_Jwt2U0fWkrEw@mail.gmail.com>
X-Gm-Features: AQt7F2o4hDxcwpr6Q06gW7dVXuTrJRsp-xS3DEV2Nt7GHwMzTbEdLVhySon7xuw
Message-ID: <CAL3q7H4KEbV6--=2NS3ttu+zhTEK3DpoSgdh+_Jwt2U0fWkrEw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after reflinking
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Thu, Jan 8, 2026 at 7:17=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Jan 08, 2026 at 05:10:04PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Qu reported that generic/164 often fails because the read operations =
get
> > > zeroes when it expects to either get all bytes with a value of 0x61 o=
r
> > > 0x62. The issue stems from truncating the pages from the page cache
> > > instead of invalidating, as truncating can zero page contents.
> >
> > Can you make it more clear if this is a subpage/large folios issue or a
> > generic issue? Or maybe just explain the "can zero page contents" in a
> > little more detail? I agree that it is the wrong "contract" so your
> > change makes sense either way, this is just for future
> > knowledge/archaeology.
> >
> > The documentation of truncate_inode_pages_range only mentions zeroing
> > partial pages when "lstart or lend + 1 is not page aligned" but our cal=
l
> > is
> >
> >         truncate_inode_pages_range(&inode->i_data,
> >                                 round_down(destoff, PAGE_SIZE),
> >                                 round_up(destoff + len, PAGE_SIZE) - 1)=
;
> >
> > which appears to align it?
> >
> > Sorry if I am missing something obvious :)
> >
> > >
> > > So instead of truncating, invalidate the page cache range with a call=
 to
> > > filemap_invalidate_inode(), which besides not doing any zeroing also
> > > ensures that while it's invalidating folios, no new folios are added.
> > > This helps ensure that buffered reads that happen while a reflink
> > > operation is in progress always get either the whole old data (the on=
e
> > > before the reflink) or the whole new data, which is what generic/164
> > > expects.
> > >
> > > Reported-by: Qu Wenruo <wqu@suse.com>
> >
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/reflink.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > > index e746980567da..f7ddd3765249 100644
> > > --- a/fs/btrfs/reflink.c
> > > +++ b/fs/btrfs/reflink.c
> > > @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file=
 *file, struct file *file_src,
> > >       struct inode *src =3D file_inode(file_src);
> > >       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> > >       int ret;
> > > -     int wb_ret;
> > >       u64 len =3D olen;
> > >       u64 bs =3D fs_info->sectorsize;
> > >       u64 end;
> > > @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct fi=
le *file, struct file *file_src,
> > >       btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cach=
ed_state);
> > >       ret =3D btrfs_clone(src, inode, off, olen, len, destoff, 0);
> > >       btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &ca=
ched_state);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       /*
> > >        * We may have copied an inline extent into a page of the desti=
nation
> > >        * range, so wait for writeback to complete before truncating p=
ages
> >
> > s/truncating/invalidating/
> >
> > >        * from the page cache. This is a rare case.
> > >        */
> > > -     wb_ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, le=
n);
> > > -     ret =3D ret ? ret : wb_ret;
> > > +     ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> >
> > Even if it's true, not worth doing in a fix like this, but a question:
> > I think buffered reads will check for outstanding ordered_extents and
> > wait for them. If we are invalidating the cache next, then how can we
> > read the file without seeing this ordered_extent? Is this
> > wait_ordered_range still necessary?
>
> The call to btrfs_wait_ordered_range() has nothing to do with the read
> path waiting or not for ordered extents.
>
> The call is there to flush any dirty page due to copying an inline extent=
.
> Because any dirty page would cause the truncation to fail and run the
> risk of not truncating any pages after it (we can have regular extents
> following an inline extent for a few cases like compression and
> fallocate).
>
> With invalidate it's not necessary as the rest of the range is not skippe=
d.
> It can be removed now. Will do that separately.

Nevermind, it's still needed.

Invalidate calls release folio (btrfs_release_folio()) which will fail
if for example a folio is dirty, making the invalidation return -EBUSY
(but still tries to invalidate all other folios in the range).

I've updated the comment here:

https://lore.kernel.org/linux-btrfs/cover.1767960735.git.fdmanana@suse.com/


>
> >
> > Again, not a blocker for this patch.
> >
> > >       /*
> > > -      * Truncate page cache pages so that future reads will see the =
cloned
> > > -      * data immediately and not the previous data.
> > > +      * Invalidate page cache so that future reads will see the clon=
ed data
> > > +      * immediately and not the previous data.
> > >        */
> > > -     truncate_inode_pages_range(&inode->i_data,
> > > -                             round_down(destoff, PAGE_SIZE),
> > > -                             round_up(destoff + len, PAGE_SIZE) - 1)=
;
> > > +     ret =3D filemap_invalidate_inode(inode, false, destoff, end);
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       btrfs_btree_balance_dirty(fs_info);
> > >
> > > -     return ret;
> > > +     return 0;
> > >  }
> > >
> > >  static int btrfs_remap_file_range_prep(struct file *file_in, loff_t =
pos_in,
> > > --
> > > 2.47.2
> > >

