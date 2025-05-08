Return-Path: <linux-btrfs+bounces-13842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFAAB009A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79D23A2DEC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1190283686;
	Thu,  8 May 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K88mNS1C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CE78F32
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722603; cv=none; b=NAbiVXtSbyEBxus5XsfXCOVHmu5tZcJLbOGhmPCfxKZvJFdaTF9G6sIZFjopRuCbrwO1WIOknyzOe+c3Bg5NNVmd6/fUQIAmuLB+FLY3/jcgpFuR585R45oY1t1MH5ZujLzw02IuD5Gl5ciWsFBLrJ8RKRHY/Smm+jgbewtA8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722603; c=relaxed/simple;
	bh=PYWXmfyMTmlJsIem9VrfVu35h8yykh/rHVBaNHyYabM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSgxxMAr3Ga2msj4rHzV0m3eElxwYyEMxpInyZdJBMLy7Zn3aIJwfZ4UayOHcNzmqVXWcBH53QFKGKVJhO6I5PGJ7z/MCysO6uGzoMUMQBUP6ZE1QwngI5PVR2ds9jYVmbYLJjlTQf9n0fZ/nLGZMYG9OcPjCLTmcTbHt0hkxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K88mNS1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760A8C4CEEF
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746722602;
	bh=PYWXmfyMTmlJsIem9VrfVu35h8yykh/rHVBaNHyYabM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K88mNS1CnaDvoZkSbKOrBIvyQbQmqYYVmz6g8qe5OTrghaIn/WM7ur2OGf1D3zm/1
	 cRK256HyreTjwVFpr7K9AR3+Ic9H40kGRrp8n+vdxAXF++UszuWIOYOUr5RKPx7BZ0
	 AQkCWuNjGsj/z003t1dkcGCIKd+NSwoMtur442AmnX/6onXYltB0da4P1taaOsIp4b
	 /Ah9/JIBenfoOzxwhhlPG5g6rG1NrdhDOln+sH1niwyaC1IBTNylld8EOlrSYNi00r
	 ZitisH921htKmYW2+k8GUwfs0MNgK0/JEt9XTA5It+lseMFSCQKPUc1z9E66XipXIj
	 dnC0FxeKm4I8Q==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbf29d0ff1so1841805a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 09:43:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/89PN0bnXAOzM81KD9DcxpeW1fZ+Q34YKF/kJceAd10c2wVEH
	6ib2CVNpMT9oKE9FO6ws1lHCFMaB2apIdRj/gPYT1SFyMqmhBrLSDd5MhO3mS9iWvmH0UU7+7Ta
	DZcF4oDTCxAaFi23Sun5ywBn7Pcw=
X-Google-Smtp-Source: AGHT+IGcQPwidGRoofybbaTKsMM+h2zxy9E+qpTPyTheQWQP/kzCmF7Jvi29E4Y+uQL5mEqweOsmHUYPtyUZOh/pEw8=
X-Received: by 2002:a17:907:c081:b0:ad1:e587:9387 with SMTP id
 a640c23a62f3a-ad218f19a66mr33725266b.21.1746722601035; Thu, 08 May 2025
 09:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9458a40fed8e6a27ada539372170d52c45967f0.1746652135.git.boris@bur.io>
 <CAL3q7H4tV-i95ORA91LPVBbgOVp8+Ym8=dBqn94+0KgFWiEWSQ@mail.gmail.com> <20250508160610.GA3935696@zen.localdomain>
In-Reply-To: <20250508160610.GA3935696@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 May 2025 17:42:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H47V6CpV6Rj59w7ohRaNGRa_S3=C653FMcysoz=Juh1cQ@mail.gmail.com>
X-Gm-Features: ATxdqUEdfpQjxHTfEfDmOf9uF4AFnJH310MNi2Z39Ho5bEdYRP4i0N8Pfp05GTM
Message-ID: <CAL3q7H47V6CpV6Rj59w7ohRaNGRa_S3=C653FMcysoz=Juh1cQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix folio leak in submit_one_async_extent()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:05=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, May 08, 2025 at 03:02:46PM +0100, Filipe Manana wrote:
> > On Wed, May 7, 2025 at 10:08=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > If btrfs_reserve_extent() fails while submitting an async_extent for =
a
> > > compressed write, then we fail to call free_async_extent_pages() on t=
he
> > > async_extent and leak its folios. A likely cause for such a failure
> > > would be btrfs_reserve_extent() failing to find a large enough
> > > contiguous free extent for the compressed extent.
> > >
> > > I was able to reproduce this by:
> > > 1. mount with compress-force=3Dzstd:3
> > > 2. fallocating most of a filesystem to a big file
> > > 3. fragmenting the remaining free space
> > > 4. trying to copy in a file which zstd would generate large compresse=
d
> > > extents for (vmlinux worked well for this)
> > >
> > > Step 4. hits the memory leak and can be repeated ad nauseam to
> > > eventually exhaust the system memory.
> > >
> > > Fix this by detecting the case where we fallback to uncompressed
> > > submission for a compressed async_extent and ensuring that we call
> > > free_async_extent_pages().
> > >
> > > Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOS=
PC")
> > > Co-authored-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/inode.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 2666b0f73452..9d4b99ba8950 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -1092,6 +1092,7 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
> > >         struct extent_state *cached =3D NULL;
> > >         struct extent_map *em;
> > >         int ret =3D 0;
> > > +       bool free_pages =3D false;
> > >         u64 start =3D async_extent->start;
> > >         u64 end =3D async_extent->start + async_extent->ram_size - 1;
> > >
> > > @@ -1112,6 +1113,8 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
> > >         }
> > >
> > >         if (async_extent->compress_type =3D=3D BTRFS_COMPRESS_NONE) {
> > > +               ASSERT(!async_extent->folios);
> > > +               ASSERT(!async_extent->nr_folios);
> >
> > It wouldn't hurt to still set free_pages to true in this case.
> > This is just to be safe and prevent leaks in case running on a kernel
> > with CONFIG_BTRFS_DEBUG not set - which several distros do like Debian
> > for example (since the Kconfg says this setting is meant for
> > developers).
>
> Sounds good. I will leave the ASSERTs, though, to communicate our
> current understanding of the state, right?

Yep, so that if it's hit by us or any user with a distro that has
CONFIG_BTRFS_DEBUG=3Dy (like SUSE distros for example) we get to know
about it and investigate why it's happening.

Thanks.

>
> >
> > Anyway:
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> > >                 submit_uncompressed_range(inode, async_extent, locked=
_folio);
> > >                 goto done;
> > >         }
> > > @@ -1128,6 +1131,7 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
> > >                  * fall back to uncompressed.
> > >                  */
> > >                 submit_uncompressed_range(inode, async_extent, locked=
_folio);
> > > +               free_pages =3D true;
> > >                 goto done;
> > >         }
> > >
> > > @@ -1169,6 +1173,8 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
> > >  done:
> > >         if (async_chunk->blkcg_css)
> > >                 kthread_associate_blkcg(NULL);
> > > +       if (free_pages)
> > > +               free_async_extent_pages(async_extent);
> > >         kfree(async_extent);
> > >         return;
> > >
> > > --
> > > 2.49.0
> > >
> > >

