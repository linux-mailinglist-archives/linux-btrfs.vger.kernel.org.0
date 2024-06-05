Return-Path: <linux-btrfs+bounces-5484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9D8FDA3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69881F21F62
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E31667EE;
	Wed,  5 Jun 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO2hvlMo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F33146599;
	Wed,  5 Jun 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629463; cv=none; b=W3O/j8TkammfZ2SJEtOYn2EDqM+NF9Z8ctbRWnP13r3lVdhYRyi9UaV6LJom9FDr3lzqeE3G8UXGFfts0+3QuZGxd8wGG5iQTdlrLO5UgfVzX7y6y80JY6K84g1bElrbU4EIpsyuObKqXgGve3/0ECF1ixpY0hRatU6FA5l8+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629463; c=relaxed/simple;
	bh=KsnupWni5Qv1pdECua/sBMJ0z3iG3tbpWh3GbFGmimc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2g/wt64DQIOKlnTl6bfvRH9bzBzpsLIKZs1SaBaek97nYD8obEumh4YtzK76MqlQ4DUSl0UXT9ENKB/F+yuFF7yE4Wlucog7lfmGKc/odeuK9U243Xy+zLxlbjo8r6l/fvnakwXAmRu//mykhhrsR4wIhLmiUBubllJrK8xvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO2hvlMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83919C4AF08;
	Wed,  5 Jun 2024 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717629463;
	bh=KsnupWni5Qv1pdECua/sBMJ0z3iG3tbpWh3GbFGmimc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tO2hvlMoABTAbtwSFruxChyTpqyV3JlmY6sp9Jrl9dCwzgkNSJoM6E9zk9kcXb08L
	 CH5zUUigVxuoeR28NnMEtZa5mTt9JNwT+7rcWMDOEiSa5tyl7Moyl39EJYN9bmSUEu
	 vDPZyE0yKX+wNrGkQLZxtqofqbcfpQlsvbMakGSwsYykoVoUfp2uez8gIr937TzE0i
	 9KhvuJuBFcK6Yblm/gGBmKolic22rlfi4KA+30192WqXAmTCGYRTjOOarQMkkFrzxc
	 DxLLFFjfBBa2dvk6pJ/bkjWOxqsxZ3ECNF7U49AMPfDZ4ywe1p5p464YtI0e7BY3MR
	 7XA+PN7BEuN7A==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7952d75f52bso20100985a.3;
        Wed, 05 Jun 2024 16:17:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxeA/KjCck/ecjIjWPrBZy9f9PMcNCE07IwssdqTQadZLKS6JKemR/HUc6g6IyGKVA7/fSV1R0KUN9K3uB8u/nP/dltqeYDrQYweE=
X-Gm-Message-State: AOJu0Ywemg3Yd9hDkqGt6S3AI+xzX4TGaYjdKWtTjX2zQdWWMdOmqoBW
	UNHokq2R/G0KQ+qvU8AbRzKNCOdePeaXzh2JDOIkPeZ/+waJgCZfzGmiBbnxNVlz/Y43SxG8LyN
	bgjJj57pGdetWrwPMWtWVBQCFkcw=
X-Google-Smtp-Source: AGHT+IEzcugPD2AxWV2rVmvHAVYk+Z4RGeAtQ9wM6rz0lekZKqmQM3lbfxWW1Mr01OheUDgxFOUEOPebJoB2Drz1XVw=
X-Received: by 2002:a05:6214:5904:b0:6ae:24da:ba17 with SMTP id
 6a1803df08f44-6b030a97439mr39504276d6.59.1717629462512; Wed, 05 Jun 2024
 16:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
 <8e44aa93-895c-438f-b4ad-9887a0c95b0b@gmx.com>
In-Reply-To: <8e44aa93-895c-438f-b4ad-9887a0c95b0b@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Jun 2024 00:17:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H59sLUyGuC0_K-rG6zE_LDUB6kA1S24rUskxJ1ZgC7muw@mail.gmail.com>
Message-ID: <CAL3q7H59sLUyGuC0_K-rG6zE_LDUB6kA1S24rUskxJ1ZgC7muw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/280: run defrag after creating file to get expected
 extent layout
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 11:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/6/5 20:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The test writes a 128M file and expects to end up with 1024 extents, ea=
ch
> > with a size of 128K, which is the maximum size for compressed extents.
> > Generally this is what happens, but often it's possibly for writeback t=
o
> > kick in while creating the file (due to memory pressure, or something
> > calling sync in parallel, etc) which may result in creating more and
> > smaller extents, which makes the test fail since its golden output
> > expects exactly 1024 extents with a size of 128K each.
> >
> > So to work around run defrag after creating the file, which will ensure
> > we get only 128K extents in the file.
>
> But defrag is not much different than reading the page and set it dirty
> for writeback again.
>
> It can be affected by the same memory pressure things to get split.

Defrag locks the range, the pages, then dirties the pages and then
unlocks the pages. So any writeback attempt happening in parallel will
wait for the pages
to be unlocked. So we shouldn't get extents smaller than 128K. Did I
miss anything?

>
> I guess you choose compressed file extents is to bump up the subvolume
> tree meanwhile also compatible for all sector sizes.

Yes, and to be fast and use very little space.

>
> In that case, what about doing DIO using sectorsize of the fs?
> So that each dio write would result one file extent item, meanwhile
> since it's a single sector/page, memory pressure will never be able to
> writeback that sector halfway.

I thought about DIO, but would have to leave holes between every
extent (and for that I would rather use buffered IO for simplicity and
probably faster).
Otherwise fiemap merges all adjacent extents, you get one 8M extent
reported, covering the range of the odd single profile data block group cre=
ated
by mkfs, and another one for the remaining of the file - it's just
ugly and hard to reason about, plus that could break one day if we
ever get rid of that 8M data block group.



>
> Thanks,
> Qu
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/280 | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/280 b/tests/btrfs/280
> > index d4f613ce..0f7f8a37 100755
> > --- a/tests/btrfs/280
> > +++ b/tests/btrfs/280
> > @@ -13,7 +13,7 @@
> >   # the backref walking code, used by fiemap to determine if an extent =
is shared.
> >   #
> >   . ./common/preamble
> > -_begin_fstest auto quick compress snapshot fiemap
> > +_begin_fstest auto quick compress snapshot fiemap defrag
> >
> >   . ./common/filter
> >   . ./common/punch # for _filter_fiemap_flags
> > @@ -36,6 +36,14 @@ _scratch_mount -o compress
> >   # extent tree (if the root was a leaf, we would have only data refere=
nces).
> >   $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_x=
fs_io
> >
> > +# While writing the file it's possible, but rare, that writeback kicke=
d in due
> > +# to memory pressure or a concurrent sync call for example, so we may =
end up
> > +# with extents smaller than 128K (the maximum size for compressed exte=
nts) and
> > +# therefore make the test expectations fail because we get more extent=
s than
> > +# what the golden output expects. So run defrag to make sure we get ex=
actly
> > +# the expected number of 128K extents (1024 extents).
> > +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foo" >> $seqres.full
> > +
> >   # Create a RW snapshot of the default subvolume.
> >   _btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
> >

