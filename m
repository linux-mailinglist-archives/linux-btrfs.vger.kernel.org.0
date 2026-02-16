Return-Path: <linux-btrfs+bounces-21685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFGaDIoMk2nw1AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21685-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:24:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD3143526
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B141302924F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E030E0F4;
	Mon, 16 Feb 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6nJ4Xsx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500E30DED5
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244656; cv=none; b=hETc+VfYy0WoVyAYmx6FfpFTmU25CQ3KaxeTEOCU5BiBc47vdwB7tnXeWcokFio6clcXCWd5YJYdBrt3+DM6zquAh6AMgM5FUn5psH97N9JEIePqs72mWFSg68adWcM5ievfcj+20vZioEIOexnDMq+WEPoCLFQc5NazcpgtJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244656; c=relaxed/simple;
	bh=NAwHwJNE8zh2KcdBi503CV9efKWhvJwTOtkGO3i41Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgeSHPKgpOsqLRBwEn+oMc4AI/jD+6cQCc/bok4kz1ZzpuAEPSY9S2TUKsl0eJoXWRXK9PMS5aRhmIEbrSJSEeOuNHbmPQgUzpKPqiLH62g+0LO0kD4CQzYiXhDMXlr9+Yx/v3pBNHFqwr2xIUGcLJEq5g8vUd8xdk28kM0HCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6nJ4Xsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB44C19424
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771244655;
	bh=NAwHwJNE8zh2KcdBi503CV9efKWhvJwTOtkGO3i41Es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i6nJ4XsxlpZzowYSwtxlUAkrWblCguMfB462xCHauTRq3xVlqRBHQ1R+nwHbrytoG
	 VdSVUNvsiX6Mx3BEziDB8aXvl9ERFQHlhNNPov2NFdSdbJ0gUU8ivjmmsPxgbTMV5r
	 mckImC160YGaLX3H7mSkAGljhjGTzJ7Aq7D2aEZ6vE7xY8zF+tg1gb99y2nWqWFD70
	 iMaBRId8inkRoXCJN1mzttGUpnO6A2KMVcjiRaJ7ReUbzCKicAiQycccxp9fwU+Ggo
	 tVcad0ySEl5z8e/iOLl4sYYL4q5Jw+6ecsrKUl+C95vhnw6WlDXvdNXryy3tN1nlmR
	 EBcXy+DfFSqlQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so380903266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 04:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXml9oIbGaoXd1/K9/y/0bzTyJzHCGPSkdJ2nMZ1V2IlmnkBXPol9xm12pdbQPh4sL9E3PYeMhbGix5DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1dmxK0kSkKL2So0qkBTOw3afumDBkHWnRI4cJvOqGiFl7MuE
	bt8S/YlVQruf4fhShtjsf+oBxW2hV1XA5zFNgZNU8DG7hjIKMDirRcBaBo2OTyo0HF9rQJqbbc8
	PjVxAtg10hSGLicahG936qQNJDJjPW30=
X-Received: by 2002:a17:907:9808:b0:b8e:d04e:e510 with SMTP id
 a640c23a62f3a-b8fb452db06mr562755766b.55.1771244654111; Mon, 16 Feb 2026
 04:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd0abcd6792c8a155af818bbe88d37d9957f4465.1770887628.git.wqu@suse.com>
 <CAL3q7H4y3reiYwXZPTXYyPqKOjxOP_SVHGPQKH7q3V=LmmBUmg@mail.gmail.com> <cdfc5693-9d6c-420f-b13d-b0e6495054c3@gmx.com>
In-Reply-To: <cdfc5693-9d6c-420f-b13d-b0e6495054c3@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Feb 2026 12:23:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4052behXuaqkRxcPMbGyPYNeN0uruJ-b3RGJ3NC9aRsA@mail.gmail.com>
X-Gm-Features: AaiRm539kNBng77jFzkiqU2Hq-pS-uqLEOXDWfY7Eq_q0tXpqJTvCPUjQCn58hs
Message-ID: <CAL3q7H4052behXuaqkRxcPMbGyPYNeN0uruJ-b3RGJ3NC9aRsA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove folio parameter from ordered io related functions
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21685-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,gmx.com:email]
X-Rspamd-Queue-Id: F0CD3143526
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 4:47=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2026/2/13 02:57, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Feb 12, 2026 at 9:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Both functions btrfs_finish_ordered_extent() and
> >> btrfs_mark_ordered_io_finished() are accepting an optional folio
> >> parameter.
> >>
> >> That @folio is passed into can_finish_ordered_extent(), which later wi=
ll
> >> test and clear the ordered flag for the involved range.
> >>
> >> However I do not think there is any other call site that can clear
> >> ordered flags of an page cache folio and can affect
> >> can_finish_ordered_extent().
> >>
> >> There are limited *_clear_ordered() callers out of
> >> can_finish_ordered_extent() function:
> >>
> >> - btrfs_migrate_folio()
> >>    This is completely unrelated, it's just migrating the ordered flag =
to
> >>    the new folio.
> >>
> >> - btrfs_cleanup_ordered_extents()
> >>    We manually clean the ordered flags of all involved folios, then ca=
ll
> >>    btrfs_mark_ordered_io_finished() without a @folio parameter.
> >>    So it doesn't need and didn't pass a @folio parameter in the first
> >>    place.
> >>
> >> - btrfs_writepage_fixup_worker()
> >>    This function is going to be removed soon, and we should not hit th=
at
> >>    function anymore.
> >
> > I still hit that sporadically with fstests, (generic/475 and
> > generic/648 at least).
>
> It may help if you have saved the dmesg of failed runs and can share
> that dmesg.

https://pastebin.com/raw/JZD4bWar

>
> I just checked my failed dmesgs, but failed to get a good clue.
>
> Thanks,
> Qu
>
> >
> >>
> >> - btrfs_invalidate_folio()
> >>    This is the real call site we need to bother.
> >
> > bother -> bother with
> >
> > Otherwise it looks good.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> >>
> >>    If we already have a bio running, btrfs_finish_ordered_extent() in
> >>    end_bbio_data_write() will be executed first, as
> >>    btrfs_invalidate_folio() will wait for the writeback to finish.
> >>
> >>    Thus if there is a running bio, it will not see the range has
> >>    ordered flags, and just skip to the next range.
> >>
> >>    If there is no bio running, meaning the ordered extent is created b=
ut
> >>    the folio is not yet submitted.
> >>
> >>    In that case btrfs_invalidate_folio() will manually clear the folio
> >>    ordered range, but then manually finish the ordered extent with
> >>    btrfs_dec_test_ordered_pending() without bothering the folio ordere=
d
> >>    flags.
> >>
> >>    Meaning if the OE range with folio ordered flags will be finished
> >>    manually without the need to call can_finish_ordered_extent().
> >>
> >> This means all can_finish_ordered_extent() call sites should get a ran=
ge
> >> that has folio ordered flag set, thus the old "return false" branch
> >> should never be triggered.
> >>
> >> Now we can:
> >>
> >> - Remove the @folio parameter from involved functions
> >>    * btrfs_mark_ordered_io_finished()
> >>    * btrfs_finish_ordered_extent()
> >>
> >>    For call sites passing a @folio into those functions, let them
> >>    manually clear the ordered flag of involved folios.
> >>
> >> - Move btrfs_finish_ordered_extent() out of the loop in
> >>    end_bbio_data_write()
> >>
> >>    We only need to call btrfs_finish_ordered_extent() once per bbio,
> >>    not per folio.
> >>
> >> - Add an ASSERT() to make sure all folio ranges have ordered flags
> >>    It's only for end_bbio_data_write().
> >>
> >>    And we already have enough safe nets to catch over-accounting of or=
dered
> >>    extents.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>
> >> But I still appreciate any extra eyes on the call site analyze.
> >> ---
> >>   fs/btrfs/compression.c  |  2 +-
> >>   fs/btrfs/direct-io.c    |  9 ++++-----
> >>   fs/btrfs/extent_io.c    | 23 ++++++++++++++---------
> >>   fs/btrfs/inode.c        |  6 ++++--
> >>   fs/btrfs/ordered-data.c | 29 +++++------------------------
> >>   fs/btrfs/ordered-data.h |  6 ++----
> >>   6 files changed, 30 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> >> index 1e7174ad32e2..1938d33ab57a 100644
> >> --- a/fs/btrfs/compression.c
> >> +++ b/fs/btrfs/compression.c
> >> @@ -292,7 +292,7 @@ static void end_bbio_compressed_write(struct btrfs=
_bio *bbio)
> >>          struct compressed_bio *cb =3D to_compressed_bio(bbio);
> >>          struct folio_iter fi;
> >>
> >> -       btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start,=
 cb->len,
> >> +       btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->l=
en,
> >>                                      cb->bbio.bio.bi_status =3D=3D BLK=
_STS_OK);
> >>
> >>          if (cb->writeback)
> >> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> >> index 9a63200d7a53..837306254f73 100644
> >> --- a/fs/btrfs/direct-io.c
> >> +++ b/fs/btrfs/direct-io.c
> >> @@ -625,7 +625,7 @@ static int btrfs_dio_iomap_end(struct inode *inode=
, loff_t pos, loff_t length,
> >>                  pos +=3D submitted;
> >>                  length -=3D submitted;
> >>                  if (write)
> >> -                       btrfs_finish_ordered_extent(dio_data->ordered,=
 NULL,
> >> +                       btrfs_finish_ordered_extent(dio_data->ordered,
> >>                                                      pos, length, fals=
e);
> >>                  else
> >>                          btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_t=
ree, pos,
> >> @@ -657,9 +657,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbi=
o)
> >>          }
> >>
> >>          if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> >> -               btrfs_finish_ordered_extent(bbio->ordered, NULL,
> >> -                                           dip->file_offset, dip->byt=
es,
> >> -                                           !bio->bi_status);
> >> +               btrfs_finish_ordered_extent(bbio->ordered, dip->file_o=
ffset,
> >> +                                           dip->bytes, !bio->bi_statu=
s);
> >>          } else {
> >>                  btrfs_unlock_dio_extent(&inode->io_tree, dip->file_of=
fset,
> >>                                          dip->file_offset + dip->bytes=
 - 1, NULL);
> >> @@ -735,7 +734,7 @@ static void btrfs_dio_submit_io(const struct iomap=
_iter *iter, struct bio *bio,
> >>
> >>                  ret =3D btrfs_extract_ordered_extent(bbio, dio_data->=
ordered);
> >>                  if (ret) {
> >> -                       btrfs_finish_ordered_extent(dio_data->ordered,=
 NULL,
> >> +                       btrfs_finish_ordered_extent(dio_data->ordered,
> >>                                                      file_offset, dip-=
>bytes,
> >>                                                      !ret);
> >>                          bio->bi_status =3D errno_to_blk_status(ret);
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 11faecb66109..8914eda1c28f 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -521,6 +521,7 @@ static void end_bbio_data_write(struct btrfs_bio *=
bbio)
> >>          int error =3D blk_status_to_errno(bio->bi_status);
> >>          struct folio_iter fi;
> >>          const u32 sectorsize =3D fs_info->sectorsize;
> >> +       u32 bio_size =3D 0;
> >>
> >>          ASSERT(!bio_flagged(bio, BIO_CLONED));
> >>          bio_for_each_folio_all(fi, bio) {
> >> @@ -528,6 +529,7 @@ static void end_bbio_data_write(struct btrfs_bio *=
bbio)
> >>                  u64 start =3D folio_pos(folio) + fi.offset;
> >>                  u32 len =3D fi.length;
> >>
> >> +               bio_size +=3D len;
> >>                  /* Our read/write should always be sector aligned. */
> >>                  if (!IS_ALIGNED(fi.offset, sectorsize))
> >>                          btrfs_err(fs_info,
> >> @@ -538,13 +540,15 @@ static void end_bbio_data_write(struct btrfs_bio=
 *bbio)
> >>                  "incomplete page write with offset %zu and length %zu=
",
> >>                                     fi.offset, fi.length);
> >>
> >> -               btrfs_finish_ordered_extent(bbio->ordered, folio, star=
t, len,
> >> -                                           !error);
> >>                  if (error)
> >>                          mapping_set_error(folio->mapping, error);
> >> +
> >> +               ASSERT(btrfs_folio_test_ordered(fs_info, folio, start,=
 len));
> >> +               btrfs_folio_clear_ordered(fs_info, folio, start, len);
> >>                  btrfs_folio_clear_writeback(fs_info, folio, start, le=
n);
> >>          }
> >>
> >> +       btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, =
bio_size, !error);
> >>          bio_put(bio);
> >>   }
> >>
> >> @@ -1577,7 +1581,8 @@ static noinline_for_stack int writepage_delalloc=
(struct btrfs_inode *inode,
> >>                          u64 start =3D page_start + (start_bit << fs_i=
nfo->sectorsize_bits);
> >>                          u32 len =3D (end_bit - start_bit) << fs_info-=
>sectorsize_bits;
> >>
> >> -                       btrfs_mark_ordered_io_finished(inode, folio, s=
tart, len, false);
> >> +                       btrfs_folio_clear_ordered(fs_info, folio, star=
t, len);
> >> +                       btrfs_mark_ordered_io_finished(inode, start, l=
en, false);
> >>                  }
> >>                  return ret;
> >>          }
> >> @@ -1653,6 +1658,7 @@ static int submit_one_sector(struct btrfs_inode =
*inode,
> >>                   * ordered extent.
> >>                   */
> >>                  btrfs_folio_clear_dirty(fs_info, folio, filepos, sect=
orsize);
> >> +               btrfs_folio_clear_ordered(fs_info, folio, filepos, sec=
torsize);
> >>                  btrfs_folio_set_writeback(fs_info, folio, filepos, se=
ctorsize);
> >>                  btrfs_folio_clear_writeback(fs_info, folio, filepos, =
sectorsize);
> >>
> >> @@ -1660,8 +1666,8 @@ static int submit_one_sector(struct btrfs_inode =
*inode,
> >>                   * Since there is no bio submitted to finish the orde=
red
> >>                   * extent, we have to manually finish this sector.
> >>                   */
> >> -               btrfs_mark_ordered_io_finished(inode, folio, filepos,
> >> -                                              fs_info->sectorsize, fa=
lse);
> >> +               btrfs_mark_ordered_io_finished(inode, filepos, fs_info=
->sectorsize,
> >> +                                              false);
> >>                  return PTR_ERR(em);
> >>          }
> >>
> >> @@ -1773,8 +1779,8 @@ static noinline_for_stack int extent_writepage_i=
o(struct btrfs_inode *inode,
> >>                          spin_unlock(&inode->ordered_tree_lock);
> >>                          btrfs_put_ordered_extent(ordered);
> >>
> >> -                       btrfs_mark_ordered_io_finished(inode, folio, c=
ur,
> >> -                                                      fs_info->sector=
size, true);
> >> +                       btrfs_folio_clear_ordered(fs_info, folio, cur,=
 fs_info->sectorsize);
> >> +                       btrfs_mark_ordered_io_finished(inode, cur, fs_=
info->sectorsize, true);
> >>                          /*
> >>                           * This range is beyond i_size, thus we don't=
 need to
> >>                           * bother writing back.
> >> @@ -2649,8 +2655,7 @@ void extent_write_locked_range(struct inode *ino=
de, const struct folio *locked_f
> >>                  if (IS_ERR(folio)) {
> >>                          cur_end =3D min(round_down(cur, PAGE_SIZE) + =
PAGE_SIZE - 1, end);
> >>                          cur_len =3D cur_end + 1 - cur;
> >> -                       btrfs_mark_ordered_io_finished(BTRFS_I(inode),=
 NULL,
> >> -                                                      cur, cur_len, f=
alse);
> >> +                       btrfs_mark_ordered_io_finished(BTRFS_I(inode),=
 cur, cur_len, false);
> >>                          mapping_set_error(mapping, PTR_ERR(folio));
> >>                          cur =3D cur_end;
> >>                          continue;
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 3af087c81724..b6b386e06529 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -424,7 +424,7 @@ static inline void btrfs_cleanup_ordered_extents(s=
truct btrfs_inode *inode,
> >>                  folio_put(folio);
> >>          }
> >>
> >> -       return btrfs_mark_ordered_io_finished(inode, NULL, offset, byt=
es, false);
> >> +       return btrfs_mark_ordered_io_finished(inode, offset, bytes, fa=
lse);
> >>   }
> >>
> >>   static int btrfs_dirty_inode(struct btrfs_inode *inode);
> >> @@ -2945,7 +2945,9 @@ static void btrfs_writepage_fixup_worker(struct =
btrfs_work *work)
> >>                   * to reflect the errors and clean the page.
> >>                   */
> >>                  mapping_set_error(folio->mapping, ret);
> >> -               btrfs_mark_ordered_io_finished(inode, folio, page_star=
t,
> >> +               btrfs_folio_clear_ordered(fs_info, folio, page_start,
> >> +                                         folio_size(folio));
> >> +               btrfs_mark_ordered_io_finished(inode, page_start,
> >>                                                 folio_size(folio), !re=
t);
> >>                  folio_clear_dirty_for_io(folio);
> >>          }
> >> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >> index e47c3a3a619a..8405d07b49cd 100644
> >> --- a/fs/btrfs/ordered-data.c
> >> +++ b/fs/btrfs/ordered-data.c
> >> @@ -348,30 +348,13 @@ static void finish_ordered_fn(struct btrfs_work =
*work)
> >>   }
> >>
> >>   static bool can_finish_ordered_extent(struct btrfs_ordered_extent *o=
rdered,
> >> -                                     struct folio *folio, u64 file_of=
fset,
> >> -                                     u64 len, bool uptodate)
> >> +                                     u64 file_offset, u64 len, bool u=
ptodate)
> >>   {
> >>          struct btrfs_inode *inode =3D ordered->inode;
> >>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>
> >>          lockdep_assert_held(&inode->ordered_tree_lock);
> >>
> >> -       if (folio) {
> >> -               ASSERT(folio->mapping);
> >> -               ASSERT(folio_pos(folio) <=3D file_offset);
> >> -               ASSERT(file_offset + len <=3D folio_next_pos(folio));
> >> -
> >> -               /*
> >> -                * Ordered flag indicates whether we still have
> >> -                * pending io unfinished for the ordered extent.
> >> -                *
> >> -                * If it's not set, we need to skip to next range.
> >> -                */
> >> -               if (!btrfs_folio_test_ordered(fs_info, folio, file_off=
set, len))
> >> -                       return false;
> >> -               btrfs_folio_clear_ordered(fs_info, folio, file_offset,=
 len);
> >> -       }
> >> -
> >>          /* Now we're fine to update the accounting. */
> >>          if (WARN_ON_ONCE(len > ordered->bytes_left)) {
> >>                  btrfs_crit(fs_info,
> >> @@ -413,8 +396,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_or=
dered_extent *ordered)
> >>   }
> >>
> >>   void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordere=
d,
> >> -                                struct folio *folio, u64 file_offset,=
 u64 len,
> >> -                                bool uptodate)
> >> +                                u64 file_offset, u64 len, bool uptoda=
te)
> >>   {
> >>          struct btrfs_inode *inode =3D ordered->inode;
> >>          bool ret;
> >> @@ -422,7 +404,7 @@ void btrfs_finish_ordered_extent(struct btrfs_orde=
red_extent *ordered,
> >>          trace_btrfs_finish_ordered_extent(inode, file_offset, len, up=
todate);
> >>
> >>          spin_lock(&inode->ordered_tree_lock);
> >> -       ret =3D can_finish_ordered_extent(ordered, folio, file_offset,=
 len,
> >> +       ret =3D can_finish_ordered_extent(ordered, file_offset, len,
> >>                                          uptodate);
> >>          spin_unlock(&inode->ordered_tree_lock);
> >>
> >> @@ -475,8 +457,7 @@ void btrfs_finish_ordered_extent(struct btrfs_orde=
red_extent *ordered,
> >>    * extent(s) covering it.
> >>    */
> >>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> >> -                                   struct folio *folio, u64 file_offs=
et,
> >> -                                   u64 num_bytes, bool uptodate)
> >> +                                   u64 file_offset, u64 num_bytes, bo=
ol uptodate)
> >>   {
> >>          struct rb_node *node;
> >>          struct btrfs_ordered_extent *entry =3D NULL;
> >> @@ -536,7 +517,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_i=
node *inode,
> >>                  len =3D this_end - cur;
> >>                  ASSERT(len < U32_MAX);
> >>
> >> -               if (can_finish_ordered_extent(entry, folio, cur, len, =
uptodate)) {
> >> +               if (can_finish_ordered_extent(entry, cur, len, uptodat=
e)) {
> >>                          spin_unlock(&inode->ordered_tree_lock);
> >>                          btrfs_queue_ordered_fn(entry);
> >>                          spin_lock(&inode->ordered_tree_lock);
> >> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> >> index 86e69de9e9ff..cd74c5ecfd67 100644
> >> --- a/fs/btrfs/ordered-data.h
> >> +++ b/fs/btrfs/ordered-data.h
> >> @@ -163,11 +163,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_=
extent *ordered_extent);
> >>   void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
> >>   void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry)=
;
> >>   void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordere=
d,
> >> -                                struct folio *folio, u64 file_offset,=
 u64 len,
> >> -                                bool uptodate);
> >> +                                u64 file_offset, u64 len, bool uptoda=
te);
> >>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> >> -                                   struct folio *folio, u64 file_offs=
et,
> >> -                                   u64 num_bytes, bool uptodate);
> >> +                                   u64 file_offset, u64 num_bytes, bo=
ol uptodate);
> >>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
> >>                                      struct btrfs_ordered_extent **cac=
hed,
> >>                                      u64 file_offset, u64 io_size);
> >> --
> >> 2.52.0
> >>
> >>
> >
>
>

