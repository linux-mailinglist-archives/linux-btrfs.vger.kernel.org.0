Return-Path: <linux-btrfs+bounces-17391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694BBB6A9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC50E4EBAFA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C12EDD76;
	Fri,  3 Oct 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUlsPb6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CB2ECD22
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494693; cv=none; b=ORh9gGp0k4BfSbcHDREmmlFHVzaN5N1CNYOhxqdDo6T/gFrDP0jP8PRE/jeuRoF6EDYwFWiqgcm/Ca3qAKT3cBmvXHOfIJkqHAMq+WIrA69/caDJyww1lL0tq1IeZeiJ3XuciBLiGfSHuj0LFzurrqSHr7dzcTQb+7X6IDMJU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494693; c=relaxed/simple;
	bh=TpgD73XO8BVP+FxbgS3hz6MfPBTnwpkBkIQfERGXcmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWjcq8KEAW1CD7Juj71h2ReIhbmKEk2Gj4WPuTQgxDv+fBf3eqN8dmqt8NckQsx4YOeonh4OjF1o5CMYJMZKBmz0sw+FJY+NT/oBXtAwLjGaaL5LbTNPMIt9XvS8Sl6CExl4+F+rJ+kn77jb4ffeejBidFQqfYztoOeYpAHlM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUlsPb6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94DFC4AF09
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759494692;
	bh=TpgD73XO8BVP+FxbgS3hz6MfPBTnwpkBkIQfERGXcmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aUlsPb6V0g/TI6WXpzPWD30CrzzoFB7pAsrH9lRqHrWVOGq4yTY3+8iTye8aEgczd
	 bTudkYbalzaP3DjdSEuxd292gwdha0voh0jonX/VeVBuaXXqYemfjxlZsDOOBszY5I
	 BfgdUnddl8cgq6Ko8HLQbUldGfnal/LQd7wVa+gBCAAZmSZ0z8c13uqD9HeaNoEznm
	 o0DQuic915lbXDfPHu60PIGGTXzWMZwMJ40ieqjuK2y6Vfr6/KyE/7eB59m9EQS0xP
	 zXKaqPS2MgIZB1QRR0gVHjvIRMCAmdnUR2W5E5jeHTks7Ni0T37rgGcrRvB06ZvA0v
	 z+CULV0eUDcXg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so4029193a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 05:31:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7+UCyMECGxvL+rF/1IACP9gwfJIyCdgSOULQNvTyJ8lvXFZvv
	3MsNcxnbfMo7ity/iKGHi9yQVwr11GfVN9J5Y/JvfLTLw8sOGGk3cfZIz7H06/uytOcmjsyJWLC
	nIM5x0R1u63yUw2jk9uD/LPrRg7FsZqM=
X-Google-Smtp-Source: AGHT+IESqXpUcZ3HSXVNNZEQMd+tlBsmGtErNfYnHP8rLuC8rOVKN2r4G8BQ2MATfIOHRxHQpInI9vwPsxHmuC+Ap2s=
X-Received: by 2002:a17:907:3d91:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b49c1f54862mr334839066b.29.1759494691230; Fri, 03 Oct 2025
 05:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
 <CAL3q7H4uPf0+dV=7-x4GyfqU2SxW1uzr5iT32aH10Pupa6r81g@mail.gmail.com> <20251001211410.GA2927167@zen.localdomain>
In-Reply-To: <20251001211410.GA2927167@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 3 Oct 2025 13:30:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7QJ8xr2XmN6VVgaDveHRgPQ_tDeGbkXTTa+GeH4RQr5Q@mail.gmail.com>
X-Gm-Features: AS18NWAJrLZra7_x18HuluZSXD14fnFmT8Zn8alwRlyynAETm_g8Tzx5Tz6Uqt8
Message-ID: <CAL3q7H7QJ8xr2XmN6VVgaDveHRgPQ_tDeGbkXTTa+GeH4RQr5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix incorrect readahead expansion length
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:14=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Oct 01, 2025 at 06:10:21PM +0100, Filipe Manana wrote:
> > On Wed, Oct 1, 2025 at 5:51=E2=80=AFPM Boris Burkov <boris@bur.io> wrot=
e:
> > >
> > > The intent of btrfs_readahead_expand() was to expand to the length of
> > > the current compressed extent being read. However, "ram_bytes" is *no=
t*
> > > that, in the case where a single physical compressed extent is used f=
or
> > > multiple file extents.
> > >
> > > Consider this case with a large compressed extent C and then later tw=
o
> > > non-compressed extents N1 and N2 written over C, leaving C1 and C2
> > > pointing to offset/len pairs of C:
> > > [               C                 ]
> > > [ N1 ][     C1     ][ N2 ][   C2  ]
> > >
> > > In such a case, ram_bytes for both C1 and C2 is the full uncompressed
> > > length of C. So starting readahead in C1 will expand the readahead pa=
st
> > > the end of C1, past N2, and into C2. This will then expand readahead
> > > again, to C2_start + ram_bytes, way past EOF. First of all, this is
> > > totally undesirable, we don't want to read the whole file in arbitrar=
y
> > > chunks of the large underlying extent if it happens to exist. Secondl=
y,
> > > it results in zeroing the range past the end of C2 up to ram_bytes. T=
his
> > > is particularly unpleasant with fs-verity as it can zero and set
> > > uptodate pages in the verity virtual space past EOF. This incorrect
> > > readahead behavior can lead to verity verification errors, if we iter=
ate
> > > in a way that happens to do the wrong readahead.
> >
> > So this misses being clear, explicit, about the worst problem:
> > buffered read corruption (even when not using verity).
> > In that case the readahead loaded data from C into the page cache
> > range for N2, so then later anyone doing a buffered read for N2's
> > range, will get data from C.
>
> I believe you, but I actually don't see it myself yet. Can you help me
> understand?
>
> As I currently see it:
>
> Changing the readahead window will change which folios we call
> btrfs_do_readpage() on, but inside btrfs_do_readpage(), we still have
> the same logic to force submissions on extent boundaries. Whether due to
> holes/inline extents, changing compression types or mismatched em->start
> and bio_ctrl->last_em_start for compressed extents.

Oh yes, the last_em_start thing, I forgot about it, though I
introduced it years ago because of multiple file extent items pointing
to parts of the same compressed extent leading to read corruption in
that kind of scenario I was mentioning.

So it's fine.
You can add my RB tag and push it to for-next so that we get this
merged into Linus' tree asap.

Thanks.

>
> I have prepared an fstest that is roughly:
>
>         # write a big-ish compressed extent
>         _scratch_mount "-o compress-force=3Dzstd:3" >/dev/null 2>&1
>         $XFS_IO_PROG -f -c "pwrite -S 0xab 0 65536" $SCRATCH_MNT/foo &>/d=
ev/null
>
>         # put a couple smaller normal extents in over it
>         _scratch_unmount
>         _scratch_mount "-o compress=3Dnone" >/dev/null 2>&1
>         $XFS_IO_PROG -f -c "pwrite -S 0xcd 4096 4096" $SCRATCH_MNT/foo &>=
/dev/null
>         $XFS_IO_PROG -f -c "pwrite -S 0xcd 32768 16384" $SCRATCH_MNT/foo =
&>/dev/null
>
>         # do some verification
>         fsverity enable $SCRATCH_MNT/foo
>         _scratch_unmount
>         _scratch_mount "-o compress=3Dnone" >/dev/null 2>&1
>         # clean cache read of 1 byte from the compressed extent. File
>         # extent size 4096, ram bytes size 64k
>         dd if=3D$SCRATCH_MNT/foo bs=3D1 count=3D1 2>/dev/null | _hexdump
>         # if the read of "C1" wrote into "N", then we should see it on
>         # this read, right?
>         dd if=3D$SCRATCH_MNT/foo bs=3D1 count=3D1 skip=3D4096 2>/dev/null=
 | _hexdump
>
> And it triggers the fsverity errors, but I am not able to make the read
> into the uncompressed range see the compressed bytes, yet.
>
> Maybe that will be a clue towards my misunderstanding...
>
> Thanks for the review and help,
> Boris
>
> >
> > This should be easy to turn into a test case for fstests too.
> >
> > With that changelog update:
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > >
> > > Fix this by using em->len for readahead expansion, not em->ram_bytes,
> > > resulting in the expected behavior of stopping readahead at the exten=
t
> > > boundary.
> > >
> > > Reported-by: Max Chernoff <git@maxchernoff.ca>
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2399898
> > > Fixes: 9e9ff875e417 ("btrfs: use readahead_expand() on compressed ext=
ents")
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/extent_io.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index dfda8f6da194..3a8681566fc5 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -972,7 +972,7 @@ static void btrfs_readahead_expand(struct readahe=
ad_control *ractl,
> > >  {
> > >         const u64 ra_pos =3D readahead_pos(ractl);
> > >         const u64 ra_end =3D ra_pos + readahead_length(ractl);
> > > -       const u64 em_end =3D em->start + em->ram_bytes;
> > > +       const u64 em_end =3D em->start + em->len;
> > >
> > >         /* No expansion for holes and inline extents. */
> > >         if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
> > > --
> > > 2.50.1
> > >
> > >

