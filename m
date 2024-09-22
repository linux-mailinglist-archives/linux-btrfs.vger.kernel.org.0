Return-Path: <linux-btrfs+bounces-8155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14697E10E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2024 13:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15489B20E94
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFF193099;
	Sun, 22 Sep 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRQRr4dD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6707868B
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003758; cv=none; b=PV214MRrI5LyTSFX1ZDNZxGd1fu5Q54gHLgOSf7MZCQGRAJ11XJ1CeTcLZvZB59AicvQKeI2XY6T4pGkS+zz3oEyRgDKsHdSwutoWnhN9leK3rwuV5LnoNIwXXsSuvQfAHxpva5eYvgpJSwfF/4qDrG08h3x0G/XmN7O+9EvP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003758; c=relaxed/simple;
	bh=K6T+VJxqCfMT60ICO61EBLH5Oh1aJJwK2adXfpmMMn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssLrwUchXU4PQ9i3OH3Ri5fza2LXSRu3cLPX786S/3FDekGFTWwIVeQQM1b4GOsFgAw2UHPh0jOwdkwUtik/Sbr3jrUVsHlwC6LsBIf1mYzUQL81lBruwTHyKYFfw4z/9Lu3fi/91JiQuBMl0dK4CulyidXCV3cbQEwmGheq9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRQRr4dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D74C4CEC3
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2024 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727003757;
	bh=K6T+VJxqCfMT60ICO61EBLH5Oh1aJJwK2adXfpmMMn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XRQRr4dDXQbF6F5j1rgHqFKwCcTXtmODezUlGPSpbNfpof9kwM4q7k09CpW08+mVp
	 uxBLXV08FsQuwpGK8n4uaN6Ci3cWEeDurTnvHKyX0gG7ahhlt25SjrAldsFoDCHr81
	 MMf15knsV8+6b3asFZ9P3wiT84lF8XsXygqX7w69XDuGg3F4rsGiB3IAvogiI5DeMF
	 9+R83L8pR6oWFqhnDKKSdfYWPKcGNrq5mAn104RMUL8jDjozzCyiow0JLL89tDPm/o
	 EiriCfFAj7glv8KwsJRXslu6uuaLIdNf9ZT24bO6NxuPfa9w1pb1cp0AGaC8mI5UYS
	 FXy/CkPN56diw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso494337166b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2024 04:15:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9rH2mS+wYYyegOulYVVfc7yRfxezeey6yIVO0y4QTaWkF9hzT
	d1PCw/BzIbd33oHDu7LFsXAuRAac99IVod0gu8JncE3v3fbF1i/yIhBFx20NgwV510ZhLfc8fGh
	AnjlOKxj4POIFQglac5ubOHv5Ojg=
X-Google-Smtp-Source: AGHT+IEAdlObAL2ttF+VbJr11fA55PIvOSWcbUOETxZMALMQJZ6wkxJirnrrW+RQJps9V088McjlYCpqe/MsdBDfYtQ=
X-Received: by 2002:a17:907:3f2a:b0:a8d:128a:cc23 with SMTP id
 a640c23a62f3a-a90d51281e4mr889978466b.59.1727003755878; Sun, 22 Sep 2024
 04:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
 <20240922060246.B4CE.409509F4@e16-tech.com> <20240922091015.EE50.409509F4@e16-tech.com>
In-Reply-To: <20240922091015.EE50.409509F4@e16-tech.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 22 Sep 2024 12:15:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6seCkuoyp9PXkaeefHkySKqK1GejBn5cUGjhWvcOd5eg@mail.gmail.com>
Message-ID: <CAL3q7H6seCkuoyp9PXkaeefHkySKqK1GejBn5cUGjhWvcOd5eg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: fix buffer overflow detection when copying
 path to cache entry
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 2:10=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
>
> > Hi,
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Starting with commit c0247d289e73 ("btrfs: send: annotate struct
> > > name_cache_entry with __counted_by()") we annotated the variable leng=
th
> > > array "name" from the name_cache_entry structure with __counted_by() =
to
> > > improve overflow detection. However that alone was not correct, becau=
se
> > > the length of that array does not match the "name_len" field - it mat=
ches
> > > that plus 1 to include the nul string terminador, so that makes a
> > > fortified kernel think there's an overflow and report a splat like th=
is:
> >
> > xfstests generic/591 failed with this patch.
> >
> > generic/591 1s ... - output mismatch (see
> > /usr/hpc-bio/xfstests/results//generic/591.out.bad)
> >     --- tests/generic/591.out   2024-08-06 21:26:52.100477701 +0800
> >     +++ /usr/hpc-bio/xfstests/results//generic/591.out.bad      2024-09=
-22 06:00:37.920543850 +0800
> >     @@ -1,5 +1,10 @@
> >      QA output created by 591
> >      concurrent reader with O_DIRECT
> >     +splice-test: open: /mnt/test/a: Is a directory
> >      concurrent reader without O_DIRECT
> >     +splice-test: open: /mnt/test/a: Is a directory
> >      sequential reader with O_DIRECT
> >     +splice-test: open: /mnt/test/a: Is a directory
> >     ...
> >     (Run 'diff -u /usr/hpc-bio/xfstests/tests/generic/591.out /usr/hpc-=
bio/xfstests/results//generic/591.out.bad'  to see the entire diff)
>
> This is just a noise. Sorry.
>
> =E2=80=98splice-test: open: /mnt/test/a: Is a directory=E2=80=99 is a pro=
blem of other patch,
> not this one.

Evidently, as this is a patch that touches only the btrfs send
feature, and generic/591 is a test that doesn't exercise the send
feature...


>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/09/22
>
>
>
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2024/09/22
> >
> >
>
>
>

