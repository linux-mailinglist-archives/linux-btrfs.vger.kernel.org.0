Return-Path: <linux-btrfs+bounces-8581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E37992A41
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8371F22F7C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4361D1319;
	Mon,  7 Oct 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1BHA76V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F114AD17;
	Mon,  7 Oct 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300753; cv=none; b=NIbBbJpGiu4BZX8rzPSR0r0jg+jn8ES3K6VVciPwDHjg9jKYPAtJVAWvUGlkApBZnutBY5SJjkF80LNft0eM8yif0GIkrDxGS6m2Dv5eJoJA2g5WHeJ8l9qEQ5Qs77hKQawpduO+aNtRdMhu0myx+AeHE6LihoWd7Q84bWKVPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300753; c=relaxed/simple;
	bh=mJ6S/VW53LSGP/Bk/SfXTBI2NaP4OyXrVOjZSxLP7eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXwBiAubrTBsAlAgxXldw9wusFBgS9rlR5GWwYEmWrquk9vRHaEoftBcxi8kXoSj2V517cI8kiQzcKNCTpLgoGlEHJENG8VkX274TVqRoble2cFPmpYeUuh7I8ijbJUBi16+9hyIBoBU3NxnRyF5rlA5g3uL6OzceaYoB9yQvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1BHA76V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00FDC4CECC;
	Mon,  7 Oct 2024 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300751;
	bh=mJ6S/VW53LSGP/Bk/SfXTBI2NaP4OyXrVOjZSxLP7eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1BHA76V/DgNAL/F5Non/V1/bao+/REPbjxHKfrr1gDs+5CL3TrI3rHODWzrjJ+B3
	 KPUdrKoeBvR6rOeSXe7BxNCy27g55Z/JKGNPEUwcgDoVCAFldjYpIkQyfqDHfIfYaK
	 H+qvNlknacS7wpw6ECWpI7jZ9CBpEKwuNb2FcrchEH4NWN8iW2ZIyvapOpv2dwqTxD
	 pa6PrkE5ryP2BEGFBpt5Z5T51/Sqlp9MWf6MKezIc/RlRw4gGLBzeVh0ATE+8B3/2l
	 Cg8VB6hnz5tyqkVEfw+UFZeALK/lZAYndbg4m2ar4mizywXK8o7+LI4PaMwCjUjWoh
	 WKlEOWuPzfDmA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so5060306a12.1;
        Mon, 07 Oct 2024 04:32:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1rUlrmFKYLoMPjxVbmLAWmR4Nh4inZC7nmFQXr1mEAdQDA0U8EdxrWcXWu8ERvAt3BQUisIbaIoJG7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzazE1odRJXsKwx9n9Qr+XnYawK92mmhflc+/Ufp0Mt4SJhy+bV
	p6JnPxjhkti4n8V20gAnq83ydfpHS3sWHPVXbbchrDDbraDG7mfH2nC+Z8v8VQTtsH8TiCQl8y1
	5zGe/3lZVY7LNAB9Ou2WX1UV43ik=
X-Google-Smtp-Source: AGHT+IEhsc0BURy0FIZ+23uHvXSDA+kXwB345JQ0tH+o0L827sgb/FxbnDuofzPOGjsA6PE5dpyPuZGtc78Q4A7NvY0=
X-Received: by 2002:a17:907:2ce5:b0:a99:5240:383f with SMTP id
 a640c23a62f3a-a9952403aa0mr361367066b.1.1728300750387; Mon, 07 Oct 2024
 04:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
 <20241004182310.GA1779439@zen.localdomain>
In-Reply-To: <20241004182310.GA1779439@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 12:31:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4c+kXoELthJU0wTQ3kYY1rZhmEa_xPEjq8XXr_tHzB-g@mail.gmail.com>
Message-ID: <CAL3q7H4c+kXoELthJU0wTQ3kYY1rZhmEa_xPEjq8XXr_tHzB-g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: update some tests to be able to run with
 btrfs-progs v6.11
To: Boris Burkov <boris@bur.io>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:23=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Oct 02, 2024 at 04:28:49PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > In btrfs-progs v6.11 the output of the "filesystem show" command change=
d
> > so that it no longers prints blank lines. This happened with commit
> > 4331bfb011bd ("btrfs-progs: fi show: remove stray newline in filesystem
> > show").
> >
> > We have some tests that expect the blank lines in their golden output,
> > and therefore they fail with btrfs-progs v6.11.
> >
> > So update the filter _filter_btrfs_filesystem_show to remove blank line=
s
> > and change the golden output of the tests to not expect the blank lines=
,
> > making the tests work with btrfs-progs v6.11 and older versions.
>
> I got around to updating my test boxes to include this and did a full
> re-run and I believe you may have missed removing the newline from the
> golden outputs of btrfs/006 and btrfs/101. Sorry if I missed an updated
> version or something.

No, I really missed those 2 tests, and I don't know why.

>
> I don't yet see this patch in the various branches I look at, so I
> assume it's not to late to fold in those two changes as well. If not,
> lmk, and I'm happy to send a follow up later.

It hasn't been merged anywhere yet, so I've sent an updated v2.

Thanks.

>
> Thanks,
> Boris
>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  common/filter.btrfs | 5 ++++-
> >  tests/btrfs/100.out | 2 --
> >  tests/btrfs/218.out | 1 -
> >  tests/btrfs/254.out | 1 -
> >  4 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/common/filter.btrfs b/common/filter.btrfs
> > index 5a944aeb..6c53dffe 100644
> > --- a/common/filter.btrfs
> > +++ b/common/filter.btrfs
> > @@ -30,11 +30,14 @@ _filter_btrfs_filesystem_show()
> >               UUID=3D$2
> >       fi
> >
> > -     # the uniq collapses all device lines into 1
> > +     # Before btrfs-progs v6.11 we had some blank lines in the output,=
 so
> > +     # delete them.
> > +     # The uniq collapses all device lines into 1.
> >       _filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
> >       _filter_size | _filter_btrfs_version | _filter_devid | \
> >       _filter_zero_size | \
> >       sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
> > +     sed -e "/^\s*$/d" | \
> >       uniq > $tmp.btrfs_filesystem_show
> >
> >       # The first two lines are Label/UUID and total devices
> > diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
> > index aa492919..1fe3c0de 100644
> > --- a/tests/btrfs/100.out
> > +++ b/tests/btrfs/100.out
> > @@ -3,9 +3,7 @@ Label: none  uuid: <UUID>
> >       Total devices <NUM> FS bytes used <SIZE>
> >       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> >       devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> > -
> >  Label: none  uuid: <UUID>
> >       Total devices <NUM> FS bytes used <SIZE>
> >       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> > -
> >  =3D=3D=3D device replace completed
> > diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
> > index 7ccf13e9..be11074c 100644
> > --- a/tests/btrfs/218.out
> > +++ b/tests/btrfs/218.out
> > @@ -2,7 +2,6 @@ QA output created by 218
> >  Label: none  uuid: <UUID>
> >       Total devices <NUM> FS bytes used <SIZE>
> >       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> > -
> >  [SCRATCH_DEV].write_io_errs    0
> >  [SCRATCH_DEV].read_io_errs     0
> >  [SCRATCH_DEV].flush_io_errs    0
> > diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
> > index 20819cf5..86089ee3 100644
> > --- a/tests/btrfs/254.out
> > +++ b/tests/btrfs/254.out
> > @@ -3,4 +3,3 @@ Label: none  uuid: <UUID>
> >       Total devices <NUM> FS bytes used <SIZE>
> >       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> >       *** Some devices missing
> > -
> > --
> > 2.43.0
> >

