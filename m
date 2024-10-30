Return-Path: <linux-btrfs+bounces-9243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DFD9B5D1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 08:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDED52846DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3851E0DD7;
	Wed, 30 Oct 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbEOtWOS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091454BD4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274106; cv=none; b=VWi4MnHvOlzWa3aaLulXotWUw8841sjKRJyt+V4giko4G3wimpZC5uEyHWr4V9bjCdfrN4u1RBo40YzgsVx2ZSabm3l9Xp99HlmRCsQm7AKsjohe78v8Ju+njsExfiPhxF1qTSG410+GT884grbQRk0VSIkvFZt0sEXuVCP8TWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274106; c=relaxed/simple;
	bh=4KJchZqPNpySNIpe9dRH71oFjL4lARoJwI/xsC+nOR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsIytIP13qH4EaCf7cFVmoxX8ANIuqqH9hJW4XBIOJ34NXkBDlC5c8hgI16bc3ZZExpOtNoZcm4acRBr5GrlIYxCxPowX9BFPglIqpLFYE0rV1TXBMnYw35U+Y4xISiF1A1LyYoIMszA50JeRStXr3B+5ue5cnKkrzVS9FAm6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbEOtWOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BD4C4CEE4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730274105;
	bh=4KJchZqPNpySNIpe9dRH71oFjL4lARoJwI/xsC+nOR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbEOtWOSLQTM7JDCzzYZu91t8cuAk/Q7JrsUZ1Q/sudpIkXoD0MnV/E558F0mUTpa
	 ywGSMiR/+dfc5lPNqQQ5hHrZUzBXAvrJK+odY5tOnd+2srwM5WbGt518IsqfIPKPlA
	 hjAKj0Ub+M/tw6w3dfmJpy4Yy1/gQSFUsstuZJXWosmbFgOJiKbLDApqjBP0wIL4DE
	 LFMPD55eu5va8Os/BV0OPZWc4JsbRNv5TXC6NSypPp0gzZktE3vsHsIOsGr7J8VuzE
	 pTZbZHUuLflOUrZv+XKWuLpbBQo/UZRvVLFisCsOufD8eWcLs46CJdRc3cUOL4V22/
	 TNHn6K43vAURg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a16b310f5so971877666b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:41:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yypb+LVBo1oVUOqC0iCi2nuqtApgfKsGjelJB3zuYau3HnbeRy+
	LpoLSNk3FRDJ94dqSM1tFo6yBgwLkj/JO6iBg/7LFaMCwGmEYEE1610hf7bKUAcGJ/bnUMyPWfk
	XrD56JJ04+kCPuxMuC5BHcpMejc0=
X-Google-Smtp-Source: AGHT+IH3wcje3nYPxV+ebE5o0ml1knutg+me8ost1hTGbeavEYt3Apek/I4vbvGjVSgCS6LaKo13m3HXU4lhsX5JQ5U=
X-Received: by 2002:a17:907:9608:b0:a9a:835:b4eb with SMTP id
 a640c23a62f3a-a9de5fa6071mr1290608566b.38.1730274103889; Wed, 30 Oct 2024
 00:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730220532.git.fdmanana@suse.com> <9243b672972756682e44c7e69a696c9cc08181ff.1730220532.git.fdmanana@suse.com>
 <385283b3-0bd9-4937-8a7e-3393fa40069f@oracle.com>
In-Reply-To: <385283b3-0bd9-4937-8a7e-3393fa40069f@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Oct 2024 07:41:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4UzUqvcuqUXXn4dP1zNyJGGRemvj=DKh2-s+D82YVj2g@mail.gmail.com>
Message-ID: <CAL3q7H4UzUqvcuqUXXn4dP1zNyJGGRemvj=DKh2-s+D82YVj2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix extent map merging not happening for
 adjacent extents
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:48=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> On 30/10/24 01:22, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we have 3 or more adjacent extents in a file, that is, consecutive f=
ile
> > extent items pointing to adjacent extents, within a contiguous file ran=
ge
> > and compatible flags, we end up not merging all the extents into a sing=
le
> > extent map.
> >
> > For example:
> >
> >    $ mkfs.btrfs -f /dev/sdc
> >    $ mount /dev/sdc /mnt/sdc
> >
> >    $ xfs_io -f -d -c "pwrite -b 64K 0 64K" \
> >                   -c "pwrite -b 64K 64K 64K" \
> >                   -c "pwrite -b 64K 128K 64K" \
> >                   -c "pwrite -b 64K 192K 64K" \
> >                   /mnt/sdc/foo
> >
> > After all the ordered extents complete we unpin the extent maps and try
> > to merge them, but instead of getting a single extent map we get two
> > because:
> >
> > 1) When the first ordered extent completes (file range [0, 64K)) we
> >     unpin its extent map and attempt to merge it with the extent map fo=
r
> >     the range [64K, 128K), but we can't because that extent map is stil=
l
> >     pinned;
> >
> > 2) When the second ordered extent completes (file range [64K, 128K)), w=
e
> >     unpin its extent map and merge it with the previous extent map, for
> >     file range [0, 64K), but we can't merge with the next extent map, f=
or
> >     the file range [128K, 192K), because this one is still pinned.
> >
> >     The merged extent map for the file range [0, 128K) gets the flag
> >     EXTENT_MAP_MERGED set;
> >
> > 3) When the third ordered extent completes (file range [128K, 192K)), w=
e
> >     unpin its exent map and attempt to merge it with the previous exten=
t
> >     map, for file range [0, 128K), but we can't because that extent map
> >     has the flag EXTENT_MAP_MERGED set (mergeable_maps() returns false
> >     due to different flags) while the extent map for the range [128K, 1=
92K)
> >     doesn't have that flag set.
> >
> >     We also can't merge it with the next extent map, for file range
> >     [192K, 256K), because that one is still pinned.
> >
> >     At this moment we have 3 extent maps:
> >
> >     One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
> >     One for file range [128K, 192K).
> >     One for file range [192K, 256K) which is still pinned;
> >
> > 4) When the fourth and final extent completes (file range [192K, 256K))=
,
> >     we unpin its extent map and attempt to merge it with the previous
> >     extent map, for file range [128K, 192K), which succeeds since none
> >     of these extent maps have the EXTENT_MAP_MERGED flag set.
> >
> >     So we end up with 2 extent maps:
> >
> >     One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
> >     One for file range [128K, 256K), with the flag EXTENT_MAP_MERGED se=
t.
> >
> >     Since after merging extent maps we don't attempt to merge again, th=
at
> >     is, merge the resulting extent map with the one that is now precedi=
ng
> >     it (and the one following it), we end up with those two extent maps=
,
> >     when we could have had a single extent map to represent the whole f=
ile.
> >
> > Fix this by making mergeable_maps() ignore the EXTENT_MAP_MERGED flag.
> > While this doesn't present any functional issue, it prevents the mergin=
g
> > of extent maps which allows to save memory, and can make defrag not
> > merging extents too (that will be addressed in the next patch).
> >
>
> Why don=E2=80=99t the extents merge, even after mount-recycles and multip=
le
> manual defrag runs, without this fix?

Why do you think mount recycles would make any difference? Whenever
extent maps are merged they get the merge flag set.
As for defrag and merged extent maps, that's explained in the next patch.

>
> Thanks, Anand
>
>
> > Fixes: 199257a78bb0 ("btrfs: defrag: don't use merged extent map for th=
eir generation check")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/extent_map.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index 1f85b54c8f0c..67ce85ff0ae2 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -233,7 +233,12 @@ static bool mergeable_maps(const struct extent_map=
 *prev, const struct extent_ma
> >       if (extent_map_end(prev) !=3D next->start)
> >               return false;
> >
> > -     if (prev->flags !=3D next->flags)
> > +     /*
> > +      * The merged flag is not an on-disk flag, it just indicates we h=
ad the
> > +      * extent maps of 2 (or more) adjacent extents merged, so factor =
it out.
> > +      */
> > +     if ((prev->flags & ~EXTENT_FLAG_MERGED) !=3D
> > +         (next->flags & ~EXTENT_FLAG_MERGED))
> >               return false;
> >
> >       if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
>

