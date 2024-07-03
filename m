Return-Path: <linux-btrfs+bounces-6166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E59258FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7343DB2AFDA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B416DECF;
	Wed,  3 Jul 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ0INMgy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F00137911;
	Wed,  3 Jul 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002726; cv=none; b=bTlOAtm5ngq+gF9xer3qjg+sUUiA0H1zNZWj5uE/Jpo7EBt8kUa4dm0ofENGPHfQfZAPcli91U9vlgOoT/IMTBJbe2SmQcy+OQ8CQmaihXXYyjXxIkrloQEl3BfAZ55T4mn8QtjOwokATLev+ozB1faIN1rN8KlrcDI1u3HqDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002726; c=relaxed/simple;
	bh=BUNSlRMhsXsEjdrAtE/PYMno10A849bFR3slyOWBk3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqDS7qcdsTCvuCWXytIPlwJh1GZv2pRv6qZIKm6xRC859fWpjpwV2XLEwk3jVWabodCoddzfQSjIJZHh7VRs7JbgCK1mLgMgpg/ycIUX83EjD2pMPUGsUN3pa6jvjYTzSI2IVmvwO8BYmMRdxzb2RWuEMF9LRDd1mSfCjg8X/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ0INMgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F8BC4AF0C;
	Wed,  3 Jul 2024 10:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720002725;
	bh=BUNSlRMhsXsEjdrAtE/PYMno10A849bFR3slyOWBk3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TJ0INMgyD2BoRmYOHUOrTecvxiFkfVB66qsNgUKwo002D2jJU6GT/9qxyptfyzJ79
	 VXr+mVCjVe54B7ugnpL7FCLJuFfNydWuLuylWtBav/JNdtmGOmJ3mO1BhTi3e9ztgn
	 tZ0ClbLI9jdHjrWp1RU/wuvcTkca07AelHthOBNoJiTEnDDZKmLNBBu5ZCKfSoxQ85
	 GI9TJVgUPMdPW8Cu+3M9lVAaEIeSWYdZ7NucC5czGksniKkWJ8UtwbbYVERa4EV8Yi
	 0artv+v9ZApYBkgwe6wJRXA2mE7cUtf2k+sX3VsEh1/wavV357lmGjG99PYTLAZrNu
	 UjJLpHLLKUzfw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9380add2so2127027e87.3;
        Wed, 03 Jul 2024 03:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX/Fi3wc71w7v5+IFQP29InKnvEGkpHMcto4uLdpAbmfKzW5oZ9PvDygY0g4wLW1itdaL/TN/cHg/FsS4rE8Mgyqeft1fTRIHKVhk=
X-Gm-Message-State: AOJu0YxjaabzvLnciOkvaNixM8kR/KPxTzZBLtKtIu1B/z5OhXNBK+xf
	8yTlJlZbNwtFzd8BLHDeW/SUbQmWVDEsnar6exJWUAvGandAWpJeuB9kuxu1w5s40JjJ3mfs6rs
	ZSgjySGyEzdI2Q/OqjeYShN6UlNs=
X-Google-Smtp-Source: AGHT+IGPM4Is6nxQwc56lNT3I/hYoefrXRTPEi/138EUSwH0uHYyo0NY+hUL96/N+jlwBdYXSK+Eau7G9dEFmyfawRY=
X-Received: by 2002:a05:6512:b96:b0:52e:8071:e89d with SMTP id
 2adb3069b0e04-52e82688db8mr11844670e87.40.1720002724112; Wed, 03 Jul 2024
 03:32:04 -0700 (PDT)
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
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com> <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
In-Reply-To: <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Jul 2024 11:31:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
Message-ID: <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:22=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Tue, Jul 2, 2024 at 3:13=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > On Mon, Jul 1, 2024 at 2:31=E2=80=AFPM Filipe Manana <fdmanana@kernel.o=
rg> wrote:
> > >
> > > Try this:
> > >
> > > https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c91027672=
67625b2.1719825714.git.fdmanana@suse.com/
> > >
> > > That applies only to the "for-next", it will need conflict resolution
> > > for 6.10-rc, as noted in the commnets.
> > > For a version that cleanly applies to 6.10-rc:
> > >
> > > https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8d=
ad49863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again=
-over-pinned-extent-maps-when-.patch
> >
> > I tested this patch on top of v6.10-rc6
> >
> > > Btw, besides the longer kswapd execution times, what else do you obse=
rve?
> > > Is it impacting performance of any applications?
> >
> > I observe that the system freezes under load.
> > Demonstration: https://youtu.be/1-gUrnEi2aU
> > The GNOME shell stops responding, and even the clock in the GNOME
> > status bar stops updating seconds.
> > And this didn't happen when the v6.9 kernel was running. Second, I
> > spotted high CPU usage by process kswapd0 when freezes occurred.
> > Therefore, I decided to find the commit that led to high CPU
> > consumption by the kswapd0 process.
> > As we found out, this commit turned out to be 956a17d9d050.
> >
> > > I think no matter what we do, it's likely that kswapd will take more
> > > time than before, because now there's extra work of going through
> > > extent maps and dropping them.
> > > We had to do it to prevent OOM situations because extent map creation
> > > was unbounded.
> >
> > Unfortunately, the patch didn't improve anything.
> > kswapd0 still consumes 100% CPU under load.
> > And my system continues to freeze.
>
> Ok, the concerning part is the freezing and high cpu usage.
>
> So besides that patch, try 2 other patches on top of it:
>
> 1) https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8da=
d49863/raw/aaf4c00fd40aaee0ee2788cd9fdfe2f083328c39/btrfs-don-t-loop-again-=
over-pinned-extent-maps-when-.patch
>     (this is the patch you tried before)
>
> 2) https://gist.githubusercontent.com/fdmanana/f2275050f04d1830adb811745b=
fd99d4/raw/1001d8154133d862e305959ee9eedebf55941669/gistfile1.txt
>
> 3) https://gist.githubusercontent.com/fdmanana/0a71b9e0fe71f38f67a50b7b53=
d520e6/raw/680cab70d2ef32337583bee6a4fb6519241b2faa/0003-btrfs-prevent-exte=
nt-map-shrinker-from-monopolizing-.patch
>
> Apply those patches on top of 6.10-rc in that order and let me know how i=
t goes.

Also, a 4th one:

https://gist.githubusercontent.com/fdmanana/638d90142e4db7cd462121d812075de=
7/raw/acb90d92c1cab512414e0bd5461640c9015da4ec/0004-btrfs-use-delayed-iput-=
during-extent-map-shrinking.patch

This one should apply in any order. Try all those 4 together please.
Thanks!

> Thanks.
>
> >
> > 6.10.0-0.rc6.51.fc41.x86_64+debug with patch
> > up  1:00
> > root         269 13.1  0.0      0     0 ?        S    12:24   7:53 [ksw=
apd0]
> > up  2:00
> > root         269 29.9  0.0      0     0 ?        R    12:24  36:02 [ksw=
apd0]
> > up  3:00
> > root         269 37.8  0.0      0     0 ?        S    12:24  68:19 [ksw=
apd0]
> > up  4:05
> > root         269 39.3  0.0      0     0 ?        R    12:24  96:40 [ksw=
apd0]
> > up  5:01
> > root         269 38.8  0.0      0     0 ?        R    12:24 117:00 [ksw=
apd0]
> > up  6:00
> > root         269 40.3  0.0      0     0 ?        S    12:24 145:24 [ksw=
apd0]
> >
> > --
> > Best Regards,
> > Mike Gavrilov.

