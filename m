Return-Path: <linux-btrfs+bounces-8256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4D9872B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910BB2816F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7200918C022;
	Thu, 26 Sep 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM4ql4zA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B919158553
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349522; cv=none; b=KhmKgKEq+m3r4f+GNVMAef7RdbK4po0sfQG+pUY5Dyolu785bwxv1myXm01Rl7IdxQ2EqEl7nsua/BhBuAdQMyZyXEINa2q5uy8tT+VTvGeu67AtKwY/Gr12sKbw9GzoRtvnRpGAPI1Af29b1jWnsRlH4arCKr0mWf7e/d1WZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349522; c=relaxed/simple;
	bh=AaRYlSHNZ1q0DtJtP/fVmK/2DpaRSOHQYTpYU40KCAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbBnBT9cVHCNv66FV39mLcEQpLp6G3m7e0SPvtv9JhEXKBwNMjK2NxKtYcemsrcM7VyAAKQ0O7DNI6KD1Q1zwQHS3meQ6hwt5lO+SRTEFBmSLiRBwgFPFOTXxMU1vHkNRUiwNV2aQYxibgVxF3c71jzLHPQcjiRkDmke34gVwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM4ql4zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E3EC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727349522;
	bh=AaRYlSHNZ1q0DtJtP/fVmK/2DpaRSOHQYTpYU40KCAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dM4ql4zAaaJfuiaLRux6J5UWrDmZBcDcpnIdSnKMWFAuCsT3KqPG9+lCg2jr4XHWr
	 OzdFykD3jdx35DPUe7wGhoEiIS752xSdbYKOUMHpxqXg+j+u0+YtTvB+iJFEdovo3w
	 tFnEm8As2UO00YLxcbHd3T5TaXLfoEuniFOgZum3gKKEFYIIYfpHf0wYKZQdTGGVgx
	 nrGtfsUeCv35yJadtSCi1U+fQsldTsC9j2FqnXyhB/BtZFP49zycAM8H1fHzYwW2oM
	 EU8giUk7szA5yhzBAfyEk3QzKGy39E7mntrp66smBAYC7pfTmX3pJguUdOS7Jg84/v
	 zspSHr3N/Jz4g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8ce5db8668so137660866b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 04:18:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyr9O1RiUzxgMMwewKfAN07lNa/eNRpBS+LrGW7CZY33Xkbxpq1
	timHZ5ssxP52SYa71oNNA+dWHEeL4/feVbo4e8wc4FGLSwbn6a83p0L2cGEwPsVI2KshF1xWD3D
	1QWC3mUkoUSyih3wBSjzehn8A8ao=
X-Google-Smtp-Source: AGHT+IHvhQ/Y9H4d5/Xz3aYtICOboJCULQJe4vXuu5Ho0ncVmzUDZDMgAUjUNbG+DjOvc3Lz/xHmdzkcmTSFyqr370w=
X-Received: by 2002:a17:907:3d8d:b0:a91:158a:a900 with SMTP id
 a640c23a62f3a-a93a069bf67mr640442166b.58.1727349520525; Thu, 26 Sep 2024
 04:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <2ddc45133bcee20c64699abf10cc24bf2737b606.1727174151.git.fdmanana@suse.com>
 <fcd229e6-7d45-46bb-b886-75a8059f8dac@gmx.com> <CAL3q7H5G6pSk65esyLNryzXO8LkMbn44u8+erLTe4+bCWc9WbA@mail.gmail.com>
In-Reply-To: <CAL3q7H5G6pSk65esyLNryzXO8LkMbn44u8+erLTe4+bCWc9WbA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 12:18:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4J9RYxr6mwVNLb5QTnJETFMCrZ7e=4SANZVhW=mLEGaw@mail.gmail.com>
Message-ID: <CAL3q7H4J9RYxr6mwVNLb5QTnJETFMCrZ7e=4SANZVhW=mLEGaw@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: re-enable the extent map shrinker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:52=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Thu, Sep 26, 2024 at 11:00=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >
> >
> >
> > =E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Now that the extent map shrinker can only be run by a single task and=
 runs
> > > asynchronously as a work queue job, enable it as it can no longer cau=
se
> > > stalls on tasks allocating memory and entering the extent map shrinke=
r
> > > through the fs shrinker (implemented by btrfs_free_cached_objects()).
> > >
> > > This is crucial to prevent exhaustion of memory due to unbounded exte=
nt
> > > map creation, primarily with direct IO but also for buffered IO on fi=
les
> > > with holes. This problem, for the direct IO case, was first reported =
in
> > > the Link tag below. That report was added to a Link tag of the first =
patch
> > > that introduced the extent map shrinker, commit 956a17d9d050 ("btrfs:=
 add
> > > a shrinker for extent maps"), however the Link tag disappeared someho=
w
> > > from the committed patch (but was included in the submitted patch to =
the
> > > mailing list), so adding it below for future reference.
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d4=
2c55e@amazon.com/
> >
> > Forgot to mention, I'd prefer the enablement patch to be merged in a
> > later release cycle, not at the same time inside the series.
> >
> > We need more tests, especially from the original reporters, and that's
> > why we have EXPERIMENTAL flags.
>
> Sure I can ping them and see if they have the availability to test and re=
port.
> But expecting every single user to be able to test may not be possible.
>
> But I don't think we ever had to have explicit ack from users to move
> things out of experimental, especially for things that don't affect
> disk format changes or incompatibility issues, for things that are
> fully transparent.

Further while this is under the experimental flags (previously debug),
it's not a feature but a bug fix (functional and security). It just
happened that while I was under vacation it was placed in that
category just to disable it, instead of commenting out code or other
alternatives.

>
> >
> > Thanks,
> > Qu
> >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >   fs/btrfs/super.c | 8 +-------
> > >   1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index e9e209dd8e05..7e20b5e8386c 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -2401,13 +2401,7 @@ static long btrfs_nr_cached_objects(struct sup=
er_block *sb, struct shrink_contro
> > >
> > >       trace_btrfs_extent_map_shrinker_count(fs_info, nr);
> > >
> > > -     /*
> > > -      * Only report the real number for EXPERIMENTAL builds, as ther=
e are
> > > -      * reports of serious performance degradation caused by too fre=
quent shrinks.
> > > -      */
> > > -     if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
> > > -             return nr;
> > > -     return 0;
> > > +     return nr;
> > >   }
> > >
> > >   static long btrfs_free_cached_objects(struct super_block *sb, struc=
t shrink_control *sc)
> >

