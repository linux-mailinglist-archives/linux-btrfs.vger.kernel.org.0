Return-Path: <linux-btrfs+bounces-8254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DD98720F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2793B289C4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B061AE856;
	Thu, 26 Sep 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/bjqIVs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87E1AD9DD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347977; cv=none; b=bcvR0IDcJpuOXporeQJyFg8fK5XGuO06izF25Oruq5E80bSY58SwmJjWAqpZZtUT7fgLt8bfyWWAbINkiijXG8napuxmr1taSnDBlvUiVQnrXlVYi7Xhgc+zpgi/QTQTSIEEkA8vDzUx0Qkhs/my9tykOrwTC3eOX/tJ0hl9Ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347977; c=relaxed/simple;
	bh=OFXebP2VHlzw6lzmKbuBfUPXTntVkCj0PNU1OPVJ/kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8r9jhyMKPLmVYdnxZbOkF9iVuH1Un6LcRbll5CqF5/lgyKU9SiYgQlMrJXJZW6wRr7czvuUl0mLyuVUiT2lK90AvrgjOgn0ywAe4SpIkYvE80K5MGhwnoRBo9JtLTVZyFDRYf4D3VbBmyw8SNIibV8XhsPSALHhtR50GJOzNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/bjqIVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9137C4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727347976;
	bh=OFXebP2VHlzw6lzmKbuBfUPXTntVkCj0PNU1OPVJ/kg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b/bjqIVsbDgD5OEkxkmKoddgrQmgbRaX0bIC8AB+UFY44HZx9jFtzuV4dztrCkAjn
	 Wj8WHGubny/VmVhZLE/JrSQ1Qc7c3ur+WFFtGLdIcVzL0EUwbsZaCXRwFhX0RGpxM3
	 ojiLOvtSxEAv8fNGCdlRzUP3Zj7SldfIZiXw9DLvHgMtyTUCQEtJv/w8qj7LPyhcBq
	 Yk3TgkVxfqmEESIgYpFoj4vWIBPhxH03URaRzJMnX/y2ntPVqPKyiWxK9EEFtgm9Hn
	 OdZXKIMCCwbKmvv05nkPnoe2RksBbkYxY+QZ1vRDXcuyJMcZoDim1Jsx8I9SoLS5VT
	 3+zvvclmkLKjw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4093722bso120099766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 03:52:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YymEKnN4j6u5i/iMYUUXZOVcLDVtnH8pmJNnEZfTT8l1YyjBSMm
	+ziSdTM08FkVM7+TSjtEVt3kD00JkbPCprAuaUGxxayupkfmKhbtt6T5HIbER2WKHfQViD2I8on
	YlmYhIYA/IWwezx1UWTNF7o663CA=
X-Google-Smtp-Source: AGHT+IEqrs0WUCwURbeV5SrTmao4WynClpi4wVWfNL6kQKJ/4xbyGJMt3k4DIO1zxJqF4zz9YLULu3YDM3aBj9BzSWE=
X-Received: by 2002:a17:907:961e:b0:a90:126f:bcb6 with SMTP id
 a640c23a62f3a-a93a033d724mr631194066b.12.1727347975436; Thu, 26 Sep 2024
 03:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <2ddc45133bcee20c64699abf10cc24bf2737b606.1727174151.git.fdmanana@suse.com>
 <fcd229e6-7d45-46bb-b886-75a8059f8dac@gmx.com>
In-Reply-To: <fcd229e6-7d45-46bb-b886-75a8059f8dac@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 11:52:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5G6pSk65esyLNryzXO8LkMbn44u8+erLTe4+bCWc9WbA@mail.gmail.com>
Message-ID: <CAL3q7H5G6pSk65esyLNryzXO8LkMbn44u8+erLTe4+bCWc9WbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: re-enable the extent map shrinker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:00=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Now that the extent map shrinker can only be run by a single task and r=
uns
> > asynchronously as a work queue job, enable it as it can no longer cause
> > stalls on tasks allocating memory and entering the extent map shrinker
> > through the fs shrinker (implemented by btrfs_free_cached_objects()).
> >
> > This is crucial to prevent exhaustion of memory due to unbounded extent
> > map creation, primarily with direct IO but also for buffered IO on file=
s
> > with holes. This problem, for the direct IO case, was first reported in
> > the Link tag below. That report was added to a Link tag of the first pa=
tch
> > that introduced the extent map shrinker, commit 956a17d9d050 ("btrfs: a=
dd
> > a shrinker for extent maps"), however the Link tag disappeared somehow
> > from the committed patch (but was included in the submitted patch to th=
e
> > mailing list), so adding it below for future reference.
> >
> > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c=
55e@amazon.com/
>
> Forgot to mention, I'd prefer the enablement patch to be merged in a
> later release cycle, not at the same time inside the series.
>
> We need more tests, especially from the original reporters, and that's
> why we have EXPERIMENTAL flags.

Sure I can ping them and see if they have the availability to test and repo=
rt.
But expecting every single user to be able to test may not be possible.

But I don't think we ever had to have explicit ack from users to move
things out of experimental, especially for things that don't affect
disk format changes or incompatibility issues, for things that are
fully transparent.

>
> Thanks,
> Qu
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/super.c | 8 +-------
> >   1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index e9e209dd8e05..7e20b5e8386c 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -2401,13 +2401,7 @@ static long btrfs_nr_cached_objects(struct super=
_block *sb, struct shrink_contro
> >
> >       trace_btrfs_extent_map_shrinker_count(fs_info, nr);
> >
> > -     /*
> > -      * Only report the real number for EXPERIMENTAL builds, as there =
are
> > -      * reports of serious performance degradation caused by too frequ=
ent shrinks.
> > -      */
> > -     if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
> > -             return nr;
> > -     return 0;
> > +     return nr;
> >   }
> >
> >   static long btrfs_free_cached_objects(struct super_block *sb, struct =
shrink_control *sc)
>

