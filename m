Return-Path: <linux-btrfs+bounces-6156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D322924581
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E4B22CB7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF41BE24E;
	Tue,  2 Jul 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7EtQm8L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845D15218A;
	Tue,  2 Jul 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940986; cv=none; b=WtbyJWHiDPjnyKEQMKBTJw8rqgWrai4RKJgjyrj2h6KX/KxoTULaJKxk0EIVKIgLXZVFjBzylqGW0hvinUSKvIq5FraQLCzK02JRo9GRgj3V7rs1kSkOuFbx947qAMH4nOLwWtNzgHz4AY6AHa3A+enQ8hBoWTRki16KJcPvW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940986; c=relaxed/simple;
	bh=3RkhrkCsDj/rWDDE6h/Y/eiySzgdZEtD7L+eGORbcj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoO2AHkAmEWxIFtvxBIdo+38jl8CR6t+kKgQb16OWTPo2/9n6KP65HIIz1lnjk+87W1xX62GoaFvpEOC9wmgkkdbwLViure6A7M2I4jjdvANbJTrT6FmLPZGnKKV5ZBy4vfU31DCIZU+0lXZDdXiPXMKokNmG+1Fy3zOy+H0dEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7EtQm8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F4C4AF07;
	Tue,  2 Jul 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719940986;
	bh=3RkhrkCsDj/rWDDE6h/Y/eiySzgdZEtD7L+eGORbcj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E7EtQm8LEH9s0u/4qwA9kyXKZU1MF+7HgEr3PCYG5weVQLfUK7+gXNM4WZBIBTiSe
	 yTjtfpFtYSFZUfTne1ZEmcMOZgxkD4/SAA/EwWzs5rGUkR6zkMXzfQCJt5XsQe3jaU
	 +2xYPPXqFVhdEUQmIqrslP9q1tfURjPAvRY6Y5daXrlHcL3OgeAIaQAZnwAKIBmTiH
	 H4wPiMPHwaGyGBl904G5xLpPvbrWYRlucbOA4es1zFt+BBqpwlPhEYHM5SIheEIg6G
	 ae+Fwpu0LxC7kwCaivo21UrkAOOcTFwKAGDK/FSHTtPDsyo9SVyQV8qrL+LAVgn/Jq
	 gxv/E2xWrwemw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a727d9dd367so481773366b.3;
        Tue, 02 Jul 2024 10:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbF1dIjZj6B0J9FTOaewmJn7Rv/CuVHj9TRCs/zIhAihUgS2kIHgDA+jV6UF4luf5x+hZCy69XW1JPoFux0DCb0ZB7xSZEXpI4PeE=
X-Gm-Message-State: AOJu0YwTGzu/BjlsX+tNBXwh4pbSNLCoNc5BYlFuMqvIsiy2foGhy6YE
	3lMfZD2MG5Wd7qAolvL4W/Lg3DwvlBehuFB8mHbkpYQl2Vs00uAjPma31AWV1BSny/f3ZlpMG2w
	nGCNgf3idiFO5rxvRh2opspXPnLY=
X-Google-Smtp-Source: AGHT+IFHZRFJIkl21gROK6833dtOQFdcTFQHZl/+DXEhNIDbjcRrc5YKDfHhEfdhQQqI7Jxjxi0qdFkIt3rxAoUpWw8=
X-Received: by 2002:a17:907:988:b0:a72:65e5:3e2 with SMTP id
 a640c23a62f3a-a751443c66dmr738739266b.6.1719940985196; Tue, 02 Jul 2024
 10:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com> <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
In-Reply-To: <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Jul 2024 18:22:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
Message-ID: <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:13=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Mon, Jul 1, 2024 at 2:31=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
> >
> > Try this:
> >
> > https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c9102767267=
625b2.1719825714.git.fdmanana@suse.com/
> >
> > That applies only to the "for-next", it will need conflict resolution
> > for 6.10-rc, as noted in the commnets.
> > For a version that cleanly applies to 6.10-rc:
> >
> > https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad=
49863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again-o=
ver-pinned-extent-maps-when-.patch
>
> I tested this patch on top of v6.10-rc6
>
> > Btw, besides the longer kswapd execution times, what else do you observ=
e?
> > Is it impacting performance of any applications?
>
> I observe that the system freezes under load.
> Demonstration: https://youtu.be/1-gUrnEi2aU
> The GNOME shell stops responding, and even the clock in the GNOME
> status bar stops updating seconds.
> And this didn't happen when the v6.9 kernel was running. Second, I
> spotted high CPU usage by process kswapd0 when freezes occurred.
> Therefore, I decided to find the commit that led to high CPU
> consumption by the kswapd0 process.
> As we found out, this commit turned out to be 956a17d9d050.
>
> > I think no matter what we do, it's likely that kswapd will take more
> > time than before, because now there's extra work of going through
> > extent maps and dropping them.
> > We had to do it to prevent OOM situations because extent map creation
> > was unbounded.
>
> Unfortunately, the patch didn't improve anything.
> kswapd0 still consumes 100% CPU under load.
> And my system continues to freeze.

Ok, the concerning part is the freezing and high cpu usage.

So besides that patch, try 2 other patches on top of it:

1) https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad4=
9863/raw/aaf4c00fd40aaee0ee2788cd9fdfe2f083328c39/btrfs-don-t-loop-again-ov=
er-pinned-extent-maps-when-.patch
    (this is the patch you tried before)

2) https://gist.githubusercontent.com/fdmanana/f2275050f04d1830adb811745bfd=
99d4/raw/1001d8154133d862e305959ee9eedebf55941669/gistfile1.txt

3) https://gist.githubusercontent.com/fdmanana/0a71b9e0fe71f38f67a50b7b53d5=
20e6/raw/680cab70d2ef32337583bee6a4fb6519241b2faa/0003-btrfs-prevent-extent=
-map-shrinker-from-monopolizing-.patch

Apply those patches on top of 6.10-rc in that order and let me know how it =
goes.
Thanks.

>
> 6.10.0-0.rc6.51.fc41.x86_64+debug with patch
> up  1:00
> root         269 13.1  0.0      0     0 ?        S    12:24   7:53 [kswap=
d0]
> up  2:00
> root         269 29.9  0.0      0     0 ?        R    12:24  36:02 [kswap=
d0]
> up  3:00
> root         269 37.8  0.0      0     0 ?        S    12:24  68:19 [kswap=
d0]
> up  4:05
> root         269 39.3  0.0      0     0 ?        R    12:24  96:40 [kswap=
d0]
> up  5:01
> root         269 38.8  0.0      0     0 ?        R    12:24 117:00 [kswap=
d0]
> up  6:00
> root         269 40.3  0.0      0     0 ?        S    12:24 145:24 [kswap=
d0]
>
> --
> Best Regards,
> Mike Gavrilov.

