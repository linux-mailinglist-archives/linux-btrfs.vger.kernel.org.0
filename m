Return-Path: <linux-btrfs+bounces-11083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCDA1DB9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C74164B0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C618A6C1;
	Mon, 27 Jan 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D18hJbuo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76256186E26
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000419; cv=none; b=rdYTs+t3Cj6NgRAnaMguo6PEE3GH68JTX7Xdw1VS5zdsG4kU7BbEB6+nq/BSIzCmEdgPbUR9Xg7uAxYZIplf8FNNGUpRGVyKSnjfcMHMiBaFXYwp7EE9uz2N0BsMQG1/83RUPkJeTQIZodlEjcmXqzER/du7LCTZc4uOjOHR+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000419; c=relaxed/simple;
	bh=ivyLzA3rmnS9sZe1uN4v/6fRRfyT+xU1Fe4xDCPkncg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fy86V37oJOiFofTD+pdPuuHmeNTWZAA8bQdHWvJ/siX2dxrLvMqQD3nO2mRNqyRIRCA5RGQBBVHiLGXFBPLtnjSpU4WyUgznK7FZaHraY1mfCy5ttPq2/4dCKF1NApqKXz0NBmMrxKE3CbHuRHKylR4GfVFG5Azd34xJwQ8QRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D18hJbuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76EAC4CEE0
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000418;
	bh=ivyLzA3rmnS9sZe1uN4v/6fRRfyT+xU1Fe4xDCPkncg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D18hJbuoJj4j9uoHZY6zuGY7AW4n9R+ip0mGHglbh0u66vZu4V9c/4Q8gv3SV37T9
	 fYu1hEmQ8VGQuJN/+ySrGSI2lzWL5bwvgrRtabeB4ggmcZT4J3uee3PKuZ7zkaeZlJ
	 dmq6eD7eZxXZAU4580NLJh5HtL1Wm5jeM5v2u6YpPdTISvtEFCdW2Aca8eKsbp/K3V
	 nzfOBJIh7n4ySY4vr1EMAKdXdTJL/dUd/0wSPXwN7BLWm/xeP0NfslWA6wpcvM6tlw
	 CyJm8ZC9IEXVpsMVRFFBHFAy8xyyM6idrssnXycGnVq1d3/FK+VPoUpWNRl/n9hPJt
	 YLjdhKcjRJuig==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso954225166b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 09:53:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnZpVUcY9UihaaJe694Gq1KsC8lgVZKkXXIfX58Sr1cZdNCkjwjaXXKEZs8QfZuomfK7xDGDcNm0Rl+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1mZ7e+tDqVjzmfiVgVeRlFbuWfxG7g4zwNF4yrRo9BAsoVyE
	gAsjksUYKPJE2wR0UVQujqu1e5u+Tu2sy51sy2dgi4hB+ZhlVTY4+Ph1On86mqEcDrC8KyaTNHp
	Rf02STIDqrKxGGQwOdl8tqBA5Ask=
X-Google-Smtp-Source: AGHT+IGGBY9iENDgRAkHlLJCtQheprrgGkpxg5fntmsW78VCsRQYhAaHQ6AgUlObiE1TKiyY4EeY+2Qa9+4PVmEsJEo=
X-Received: by 2002:a17:907:1c85:b0:aa6:81dc:6638 with SMTP id
 a640c23a62f3a-ab38b26f4cemr3969480466b.16.1738000417425; Mon, 27 Jan 2025
 09:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz> <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com> <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
In-Reply-To: <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 27 Jan 2025 17:53:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7fhneT77wNgjy=+9h+n_ybkbbm=E2i=Oh9=vgAC3Tm8w@mail.gmail.com>
X-Gm-Features: AWEUYZm4Z1a-iUgpDpov2saHWYAjeWLQEGeEGnlLkRZcBHt1Vcav5gpbFsuYeHs
Message-ID: <CAL3q7H7fhneT77wNgjy=+9h+n_ybkbbm=E2i=Oh9=vgAC3Tm8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Mark Harmstone <maharmstone@meta.com>
Cc: Daniel Vacek <neelx@suse.com>, "dsterba@suse.cz" <dsterba@suse.cz>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:42=E2=80=AFPM Mark Harmstone <maharmstone@meta.co=
m> wrote:
>
> On 24/1/25 12:25, Filipe Manana wrote:
> >>
> >> It will only retry precisely when more concurrent requests race here.
> >> And thanks to cmpxchg only one of them wins and increments. The others
> >> retry in another iteration of the loop.
> >>
> >> I think this way no lock is needed and the previous behavior is preser=
ved.
> >
> > That looks fine to me. But under heavy concurrency, there's the
> > potential to loop too much, so I would at least add a cond_resched()
> > call before doing the goto.
> > With the mutex there's the advantage of not looping and wasting CPU if
> > such high concurrency happens, tasks will be blocked and yield the cpu
> > for other tasks.
>
> And then we have the problem of the function potentially sleeping, which
> was one of the things I'm trying to avoid.

The sleep should be there to avoid looping too much and starving other
tasks in case of too heavy concurrency.

>
> I still think an atomic is the correct choice here:

I'm not saying it isn't.

>
> * Skipped integers aren't a problem, as there's no reliance on the
> numbers being contiguous.

That wasn't the problem with the patch.

> * The overflow check is wasted cycles, and should never have been there
> in the first place. Even if we were to grab a new integer a billion
> times a second, it would take 584 years to wrap around.

That still feels wrong to me. We do limit checks everywhere, even
because corruptions and bugs can happen.
Removing the limit checks, could also result in using the invalid
range from 0 to BTRFS_FIRST_FREE_OBJECTID (256), besides reusing
numbers after that range.

Do you actually have numbers to compare the atomic vs mutex?

>
> Mark

