Return-Path: <linux-btrfs+bounces-6170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D46925BCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B87DB30643
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2E17625D;
	Wed,  3 Jul 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/dbKkCo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2E136E2A;
	Wed,  3 Jul 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003510; cv=none; b=XewEbY6YctYoe9Gn/tBDxgqLjYHmjAl2pQUfozQFMlA3XBj1XPNH4FWPvCQb3DxFtoKbkzGk1DgzGCGAt8Ez0pAvAqVJOUlu39ZTUctOnseXt3pYBySh+O4U9EKai5rfZClSbZ5Jm1mZF2MXDwMuAibJfhUuc0HwF2I6J2zTPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003510; c=relaxed/simple;
	bh=PtQNUlx8ansBCk+WctUe9IMiEXLQyi16mlQEDtfaI0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+7Ln4YMpG7EPjN/995k3jRDzwcVppJ3u3OEmOqEav3ekCuYZ5lKyJjg9IqtdMiZj419zotq7ftANSGNDVQTXnTnvmM+cde1Xc/rfsh9szWdZ+rrGuNRbXL75xUj8TfkwvdPF6j74Sk3M1pw0drkoBOjEO2O7XUbcV0DmtU9BPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/dbKkCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA8C4AF0A;
	Wed,  3 Jul 2024 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720003510;
	bh=PtQNUlx8ansBCk+WctUe9IMiEXLQyi16mlQEDtfaI0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/dbKkCo8418U3YgZo3vL3QEhwgmbEw8uLXqVq9r7Deo8OCi/A9mI4fIukRYmYSPx
	 xD7O9t/Ocjt+XcklvHPEFdF/LmpkdwcgYEVY2eOpcDj5ZJKEMebFDbYaPkwdf05tgF
	 5y4+m4AWLppp/Fw2MO9G3VSJuwmRgrXPVId2Qtl/9EdybbCXIEbaEoC5D1aw3nHqnn
	 k3iT9KNH2aQYV028PVlvFtjvc0XbgIcFItBvJNv+tNxPqvGKS1n1jhJ0FGX2VMzlar
	 8HsMtM0GqbSVrZPmk0NlXTdNEjlMPrlR4+SbMUOjfvNBvYehyvep4jJCmAILYHKzZD
	 eVzxLrFETSKHA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a729d9d7086so91505966b.0;
        Wed, 03 Jul 2024 03:45:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUigJPjxcSkw+NUyrogq/8v6pflInC60WXNJWlhKJYUJCBEBwQvQqqV8VzFeb612C+Ieh5NARz6uPxnS6jPfrirSHzUIl548MvY1gc=
X-Gm-Message-State: AOJu0YxK3N1BNtTyypks+UWZzLWpj5cpx0CD9YFwCmXb30Z37gPxqfRJ
	/DZnBIuEp/LIK+ui10wVxHzQgNHlOqRkYOubewJL1yAtDUx3rDtvUoerI71DM6vk7TeCH5R4h2F
	h2IDkF1RHjp84UylOni3miyh3V2I=
X-Google-Smtp-Source: AGHT+IFSSZRSZiPOdAVlcgtTYF0Q7TZArdGktuMCmFK5m3DdOJNmu80FkBBogvdkrJxRYC7UIxsHSxlNbePArkkq+no=
X-Received: by 2002:a17:906:5a91:b0:a6f:b352:a74b with SMTP id
 a640c23a62f3a-a77a252e4d9mr84232066b.38.1720003508655; Wed, 03 Jul 2024
 03:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com> <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
In-Reply-To: <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Jul 2024 11:44:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
Message-ID: <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:31=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Jul 2, 2024 at 6:22=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
> >
> > On Tue, Jul 2, 2024 at 3:13=E2=80=AFPM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > On Mon, Jul 1, 2024 at 2:31=E2=80=AFPM Filipe Manana <fdmanana@kernel=
.org> wrote:
> > > >
> > > > Try this:
> > > >
> > > > https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c910276=
7267625b2.1719825714.git.fdmanana@suse.com/
> > > >
> > > > That applies only to the "for-next", it will need conflict resoluti=
on
> > > > for 6.10-rc, as noted in the commnets.
> > > > For a version that cleanly applies to 6.10-rc:
> > > >
> > > > https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f=
8dad49863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-aga=
in-over-pinned-extent-maps-when-.patch
> > >
> > > I tested this patch on top of v6.10-rc6
> > >
> > > > Btw, besides the longer kswapd execution times, what else do you ob=
serve?
> > > > Is it impacting performance of any applications?
> > >
> > > I observe that the system freezes under load.
> > > Demonstration: https://youtu.be/1-gUrnEi2aU
> > > The GNOME shell stops responding, and even the clock in the GNOME
> > > status bar stops updating seconds.
> > > And this didn't happen when the v6.9 kernel was running. Second, I
> > > spotted high CPU usage by process kswapd0 when freezes occurred.
> > > Therefore, I decided to find the commit that led to high CPU
> > > consumption by the kswapd0 process.
> > > As we found out, this commit turned out to be 956a17d9d050.
> > >
> > > > I think no matter what we do, it's likely that kswapd will take mor=
e
> > > > time than before, because now there's extra work of going through
> > > > extent maps and dropping them.
> > > > We had to do it to prevent OOM situations because extent map creati=
on
> > > > was unbounded.
> > >
> > > Unfortunately, the patch didn't improve anything.
> > > kswapd0 still consumes 100% CPU under load.
> > > And my system continues to freeze.
> >
> > Ok, the concerning part is the freezing and high cpu usage.
> >
> > So besides that patch, try 2 other patches on top of it:
> >
> > 1) https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8=
dad49863/raw/aaf4c00fd40aaee0ee2788cd9fdfe2f083328c39/btrfs-don-t-loop-agai=
n-over-pinned-extent-maps-when-.patch
> >     (this is the patch you tried before)
> >
> > 2) https://gist.githubusercontent.com/fdmanana/f2275050f04d1830adb81174=
5bfd99d4/raw/1001d8154133d862e305959ee9eedebf55941669/gistfile1.txt
> >
> > 3) https://gist.githubusercontent.com/fdmanana/0a71b9e0fe71f38f67a50b7b=
53d520e6/raw/680cab70d2ef32337583bee6a4fb6519241b2faa/0003-btrfs-prevent-ex=
tent-map-shrinker-from-monopolizing-.patch
> >
> > Apply those patches on top of 6.10-rc in that order and let me know how=
 it goes.
>
> Also, a 4th one:
>
> https://gist.githubusercontent.com/fdmanana/638d90142e4db7cd462121d812075=
de7/raw/acb90d92c1cab512414e0bd5461640c9015da4ec/0004-btrfs-use-delayed-ipu=
t-during-extent-map-shrinking.patch
>
> This one should apply in any order. Try all those 4 together please.
> Thanks!

I'm collecting all the patches in this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=
=3Dem_shrinker_6.10

They apply cleanly to 6.10-rc.

>
> > Thanks.
> >
> > >
> > > 6.10.0-0.rc6.51.fc41.x86_64+debug with patch
> > > up  1:00
> > > root         269 13.1  0.0      0     0 ?        S    12:24   7:53 [k=
swapd0]
> > > up  2:00
> > > root         269 29.9  0.0      0     0 ?        R    12:24  36:02 [k=
swapd0]
> > > up  3:00
> > > root         269 37.8  0.0      0     0 ?        S    12:24  68:19 [k=
swapd0]
> > > up  4:05
> > > root         269 39.3  0.0      0     0 ?        R    12:24  96:40 [k=
swapd0]
> > > up  5:01
> > > root         269 38.8  0.0      0     0 ?        R    12:24 117:00 [k=
swapd0]
> > > up  6:00
> > > root         269 40.3  0.0      0     0 ?        S    12:24 145:24 [k=
swapd0]
> > >
> > > --
> > > Best Regards,
> > > Mike Gavrilov.

