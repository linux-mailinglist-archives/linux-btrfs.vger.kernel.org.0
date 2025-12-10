Return-Path: <linux-btrfs+bounces-19622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD1CB2F12
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE1330FC6B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8978F2E;
	Wed, 10 Dec 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMtsuenR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09422F01
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370854; cv=none; b=DVqHgtKL3gdOiX5GBHrrgFzp8pSXNIydsOPI3T25Yz+3Ms4rw4Jg2CrEI/+jDMkNs8ZtohdeM3Wi5bg5hpr065odq7VR8Z+8bL0jcBcd4S2Q56/s/N2JTncAeyo00FOy6iMlHiznu82DVbZtaKJbIvOJSbVQ4E8Q/bPxmeOlLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370854; c=relaxed/simple;
	bh=ofjXE/sx25DTAAS+L6biseSDoPkqPQZlIFeLWM6R7TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMyAbt4+YF4EEk03MFY1WAdjigSuEkV1wfs69/nc0P0lOm+mQ9Afg6PkgvySN1Clvg2MM+yXbCWGDYK22q4CggjAiQ5Xa9Kyjx0nXmsqLyWkDgJTMzv+NqcB/EON/Wn3i7HoG9tHNZHOXpJDWmsxuZU9crVFce3SbifLXb+EI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMtsuenR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D298C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765370854;
	bh=ofjXE/sx25DTAAS+L6biseSDoPkqPQZlIFeLWM6R7TI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fMtsuenR5GW1TgjWDi3j+O+mPRZz545mb7w82bopW9eDWnEkUbvgje55qNlN4Y+3h
	 /0ccmyRw3oVrTVlx/inWIsWjkV1WLOXrkMGiqc9PaTIwtuOItmPF41pkg1N2iMpghW
	 fxxyH66KR+xtVKcn4hoTHtgkj0OF3PfQTdDVONUUc9fiaXXXi8LfyGFuvywsqqhl8a
	 RJmC76pESaLSvc6+JLOYIBVwPt2h6IMxHhB4x4nNQhroA+mWzdb687kPbjjJ1hqTH2
	 vYfiZlClgTODuN1zo9yTX1Zn4TyYf8SPci/n7tr/5SzZDzLpJn59Cd9dPv4nbovJ++
	 k9Kb7tRJmuaHw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b736ffc531fso398575166b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 04:47:33 -0800 (PST)
X-Gm-Message-State: AOJu0YwMwAlh43A3U1+Azd4vYGEx7c+XhpaZ1YZMkDDyZyyE51BaLb7i
	36CwLJdwK9Vc9VNt1kifTzI2Ei74enegVoXcx/5pv3vfHWHncggjVNDIfmVeID4bDl4B7+ukw+B
	NEQUP6qmCCVO8xqhdDU0Y0Nj8Mn1kHjY=
X-Google-Smtp-Source: AGHT+IFPRQDS8VLcwiDdK7ToA7puYuQr+p3hcTWIHL3YqT2pcdE4sCG9ATFiktRswA/wki+BQqudB1plNN0G72oRztE=
X-Received: by 2002:a17:907:9451:b0:b73:7c3e:e17c with SMTP id
 a640c23a62f3a-b7ce8445e59mr253738066b.44.1765370852553; Wed, 10 Dec 2025
 04:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
 <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com> <3c610ad4-b091-4fe2-9c18-689d6f9d3af3@suse.com>
In-Reply-To: <3c610ad4-b091-4fe2-9c18-689d6f9d3af3@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 12:46:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4JBhA74Mc_KDp8gFbykAd86h-1inLw_fSr8Z0bHJW9Gg@mail.gmail.com>
X-Gm-Features: AQt7F2rCDcAwViu_SfsMQq-i3H084CGU8e5G3grSkW6GGlbBUxVCirY2w8oa638
Message-ID: <CAL3q7H4JBhA74Mc_KDp8gFbykAd86h-1inLw_fSr8Z0bHJW9Gg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 8:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/11/25 21:15, Filipe Manana =E5=86=99=E9=81=93:
> > On Tue, Nov 25, 2025 at 8:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [POSSIBLE BUG]
> >> If there are multiple ordered extents beyond EOF, at folio writeback
> >> time we may only truncate the first ordered extent, but leaving the
> >> remaining ones finished but not marked as truncated.
> >>
> >> Since those OEs are not marked as truncated, it will still insert an
> >> file extent item, and may lead to false missing csum errors during
> >> "btrfs check".
> >>
> >> [CAUSE]
> >> Since we have bs < ps support for a while and experimental large data
> >> folios are also going to graduate from experimental features soon, we
> >> can have the following folio to be written back:
> >>
> >>    fs block size 4K
> >>    page size 4K, folio size 64K.
> >>
> >>             0        16K      32K                  64K
> >>             |<---------------- Dirty -------------->|
> >>             |<-OE A->|<-OE B->|<----- OE C -------->|
> >>                 |
> >>                 i_size 4K.
> >>
> >> In above case we need to submit the writeback for the range [0, 4K).
> >> For range [4K, 64K) there is no need to submit any IO but mark the
> >> involved OEs (OE A, B, C) all as truncated.
> >>
> >> However during the EOF handling, patch "btrfs: truncate ordered extent
> >> when skipping writeback past i_size" only calls
> >> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark i=
t
> >> as truncated.
> >
> > And there's a reason why the patch only looks for one ordered extent.
> >
> > Because there shouldn't be more than one: btrfs_truncate() calls
> > btrfs_wait_ordered_range() when we truncate the size of a file to a
> > smaller value.
> > The range goes from the new i_size, rounded down by sector size, to
> > (u64)-1. And btrfs_wait_ordered_range() flushed any delalloc besides
> > waiting for ordered extents.
>
> Couldn't something like 18de34daa7c6 ("btrfs: truncate ordered extent
> when skipping writeback past i_size") happen? E.g. with more holes:
>
>      0          16K    32K     36K   48K    52K   60K    64K
>      |//////////|      |///////|     |//////|     |//////|
>
> The range [0, 64k) is inside a large folio or just a single page (64K
> page size), and above "//" range is dirtied by buffered write.
>
> Then we truncate the inode size to 16K, which set the inode size to 16K
> first, then call btrfs_truncate() which triggers
> btrfs_wait_ordered_range()->btrfs_fdatawrite_range() to do the writeback.
>
> Then we start writing back the large folio 0 for range [0, 64K),
> creating ordered extents for [0, 16K), [32K, 36K), [48K, 52K), [60K, 64K)=
.
>
> Then call extent_writepage_io() to do the submission, which will only
> submit [0, 16K).
> And the current code will only mark OE [32K, 36K) as truncated, missing
> [48K, 52K) and [60K, 64K).

No, it will mark all ordered extents as truncated.

In extent_writepage_io() we go through each dirty subrange inside the
folio with the for_each_set_bit() loop.
For each subrange after 16K, we check the start offset ('cur'
variable) is >=3D i_size, so we look up the ordered extent for that
subrange and truncate it.

As long as for_each_set_bit() works and finds each dirty subrange we
don't need this patch.
If we did the ordered extent truncation outside that loop, then we
would need something like this patch to ensure we process all ordered
extents.

Thanks.

>
> Normally the file extent item insertion and later truncation (which
> drops all the inserted file extents) are inside the same transaction.
>
> But if the transaction committed after the file extent items insertion
> but before the transaction dropping file extent items, then power loss
> happened, we got the same ordered extents beyond EOF and without csum.
>
> Or did I miss something?
>
> Thanks,
> Qu
>
> >
> > So how can we find more than one ordered extent after this?
> >
> > I think this changelog should explain that, it makes no mention of
> > this detail about btrfs_truncate().
> >
> > Thanks.
> >
> >
> >>
> >> But OE B and C are not marked as truncated, they will finish as usual,
> >> which will leave a regular file extent item to be inserted beyond EOF,
> >> and without any data checksum.
> >>
> >> [FIX]
> >> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle a=
ll
> >> OEs of a range, and mark them all as truncated.
> >>
> >> With that helper, all OEs (A B and C) will be marked as truncated.
> >> OE B and C will have 0 truncated_len, preventing any file extent item =
to
> >> be inserted from them.
> >>
> >> Reviewed-by: Boris Burkov <boris@bur.io>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
> >>    Since the range passed in is to the end of the folio during writeba=
ck
> >>    path, there is no guarantee that there is always one or more ordere=
d
> >>    extents covering the full range.
> >>
> >>    This get triggered during fsstress runs, especially common on bs < =
ps
> >>    cases.
> >>
> >>    Remove the ASSERT() and exit the oe search instead.
> >>
> >> Resend:
> >> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
> >>    calls for buffered write path'
> >>    As this is a bug fix, which needs a little higher priority than
> >>    the remaining optimizations.
> >>
> >> - Fix various grammar errors
> >>
> >> - Use @end to replace duplicated calculations
> >>
> >> - Remove the Fixes: tag
> >>    The involved patch is not yet merged upstream.
> >>    Just mention the patch subject inside the commit message.
> >> ---
> >>   fs/btrfs/extent_io.c    | 19 +------------------
> >>   fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
> >>   fs/btrfs/ordered-data.h |  2 ++
> >>   3 files changed, 36 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 2d32dfc34ae3..2044b889c887 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_=
io(struct btrfs_inode *inode,
> >>                  cur =3D folio_pos(folio) + (bit << fs_info->sectorsiz=
e_bits);
> >>
> >>                  if (cur >=3D i_size) {
> >> -                       struct btrfs_ordered_extent *ordered;
> >> -
> >> -                       ordered =3D btrfs_lookup_first_ordered_range(i=
node, cur,
> >> -                                                                  fol=
io_end - cur);
> >> -                       /*
> >> -                        * We have just run delalloc before getting he=
re, so
> >> -                        * there must be an ordered extent.
> >> -                        */
> >> -                       ASSERT(ordered !=3D NULL);
> >> -                       spin_lock(&inode->ordered_tree_lock);
> >> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->fla=
gs);
> >> -                       ordered->truncated_len =3D min(ordered->trunca=
ted_len,
> >> -                                                    cur - ordered->fi=
le_offset);
> >> -                       spin_unlock(&inode->ordered_tree_lock);
> >> -                       btrfs_put_ordered_extent(ordered);
> >> -
> >> -                       btrfs_mark_ordered_io_finished(inode, folio, c=
ur,
> >> -                                                      end - cur, true=
);
> >> +                       btrfs_mark_ordered_io_truncated(inode, folio, =
cur, end - cur);
> >>                          /*
> >>                           * This range is beyond i_size, thus we don't=
 need to
> >>                           * bother writing back.
> >> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >> index a421f7db9eec..3c0b89164139 100644
> >> --- a/fs/btrfs/ordered-data.c
> >> +++ b/fs/btrfs/ordered-data.c
> >> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_=
inode *inode,
> >>          spin_unlock(&inode->ordered_tree_lock);
> >>   }
> >>
> >> +/*
> >> + * Mark any ordered extents io inside the specified range as truncate=
d.
> >> + */
> >> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struc=
t folio *folio,
> >> +                                    u64 file_offset, u32 len)
> >> +{
> >> +       const u64 end =3D file_offset + len;
> >> +       u64 cur =3D file_offset;
> >> +
> >> +       ASSERT(file_offset >=3D folio_pos(folio));
> >> +       ASSERT(end <=3D folio_pos(folio) + folio_size(folio));
> >> +
> >> +       while (cur < end) {
> >> +               u32 cur_len =3D end - cur;
> >> +               struct btrfs_ordered_extent *ordered;
> >> +
> >> +               ordered =3D btrfs_lookup_first_ordered_range(inode, cu=
r, cur_len);
> >> +
> >> +               if (!ordered)
> >> +                       break;
> >> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> >> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->fla=
gs);
> >> +                       ordered->truncated_len =3D min(ordered->trunca=
ted_len,
> >> +                                                    cur - ordered->fi=
le_offset);
> >> +               }
> >> +               cur_len =3D min(cur_len, ordered->file_offset + ordere=
d->num_bytes - cur);
> >> +               btrfs_put_ordered_extent(ordered);
> >> +
> >> +               cur +=3D cur_len;
> >> +       }
> >> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, len,=
 true);
> >> +}
> >> +
> >>   /*
> >>    * Finish IO for one ordered extent across a given range.  The range=
 can only
> >>    * contain one ordered extent.
> >> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> >> index 1e6b0b182b29..dd4cdc1a8b78 100644
> >> --- a/fs/btrfs/ordered-data.h
> >> +++ b/fs/btrfs/ordered-data.h
> >> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_orde=
red_extent *ordered,
> >>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> >>                                      struct folio *folio, u64 file_off=
set,
> >>                                      u64 num_bytes, bool uptodate);
> >> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struc=
t folio *folio,
> >> +                                    u64 file_offset, u32 len);
> >>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
> >>                                      struct btrfs_ordered_extent **cac=
hed,
> >>                                      u64 file_offset, u64 io_size);
> >> --
> >> 2.52.0
> >>
> >>
>

