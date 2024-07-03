Return-Path: <linux-btrfs+bounces-6169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A49258CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B971F28AE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21D176237;
	Wed,  3 Jul 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2r0ASZ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C95174ED1;
	Wed,  3 Jul 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002814; cv=none; b=BHim84+eJ5Zd8yP9UtTvZzQNldzn8RrxIMEzSPGQd/DCgdBs9Pe9sDLBx36flEi/04eI+HjWEtA+OFiC3L9+4f32lfTfd5MUj7MKzEGV12ei/+jh7Hj1eypzpLs17/kJxjRhY5rTNDAkXNSX5WNjbe5Tmaplj1nyoIkjlYItUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002814; c=relaxed/simple;
	bh=b4bbljj2R0TPEnSX2GXay8TlIK8MyldIw9BxpopdVl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzukX/vEAD4SR5OZU5daph/POe2p+VWwuMsp2HSNrz4xqkEGb9hgJgSiTA7uhY4BVp7Tl9co82BlhA+rCawRvUAmPNajpB1+t0ub7W3T4S43/EAu8LSFMx6RJ4rc6e5NNxaEYnDmX9IynzD9+xB6rrcg4Z8F0C4YkcXl+WGde4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2r0ASZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C8C4AF0F;
	Wed,  3 Jul 2024 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720002814;
	bh=b4bbljj2R0TPEnSX2GXay8TlIK8MyldIw9BxpopdVl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S2r0ASZ60MIcO1NBQJ5CmsyAcUH8S5vaSPunGjgVtyrMPRc22wjTgfWNlcOVc4RyP
	 ol3yGjSz3kFV4qjf5caPspIKhzCDOnRhlBVh7MmOnCzsAuZ12O5bwPiC9WzydT9FQn
	 56tr2QCxZAnD0m2BvKlWGSmp2dNiA+yyCQiyzHqJepx6BPGtBs1jzdiSWt4uQGxUSn
	 tyi5Q1tw4VbLSf7/ZoZFkRgVtYS3w/Xzog8zhAsWVvZ3R5LRpIPH0J7bIEtnTliXP+
	 v8AMJO4Lt6y41druFWpxPjvkIZ9U9GuPoHhufxfCmW8/+NOczQrXQRIUi/hZfyID/7
	 nctHqPH+oCC3g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a727d9dd367so555132166b.3;
        Wed, 03 Jul 2024 03:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiqGv9frLpbtlRqjuonX50cBPgBUWPCGvUA3jKKh+0oxKNPaNCc+rX23DUOYxeQ9KFa65GqQw5rslD/gVA5juFKv8c0QFHxlX/N2bM9Fk8Dh8trL4SrxDzTaMF143WgziA925AFG0ARS8=
X-Gm-Message-State: AOJu0YwLtHdfF1H/RXe6exfif+OfYXWybvUXvhQVYBtluKqMz7RZbQlN
	MExQ/bpnOaSx37bQS4f6ZId/TrCyR8y71LnaTfq2znPPocmelwjJpZh4eiZvTF7OHCSzTGN+55Z
	j1o1vHVnV0E5Ee9U/6orWHxRMOQo=
X-Google-Smtp-Source: AGHT+IFRQ2YDW800S7cPFJdsj6ojw4cArV4KODCqlHwf7Vvw4HC5BzefgEBfm2decj+8AW1MFnyMMJ5gHtBzhnk9v0A=
X-Received: by 2002:a17:906:1e97:b0:a72:b811:4d43 with SMTP id
 a640c23a62f3a-a75144bae6amr705053166b.59.1720002812933; Wed, 03 Jul 2024
 03:33:32 -0700 (PDT)
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
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com> <93b5fac5-6315-4f2e-a2df-37ef4bf56f9e@app.fastmail.com>
In-Reply-To: <93b5fac5-6315-4f2e-a2df-37ef4bf56f9e@app.fastmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Jul 2024 11:32:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H78Ls2a4Tp3prik-sg=0Kouif6X4jZXqpCe8t4tgc6wGA@mail.gmail.com>
Message-ID: <CAL3q7H78Ls2a4Tp3prik-sg=0Kouif6X4jZXqpCe8t4tgc6wGA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Chris Murphy <lists@colorremedies.com>
Cc: =?UTF-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= <mikhail.v.gavrilov@gmail.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:46=E2=80=AFPM Chris Murphy <lists@colorremedies.co=
m> wrote:
>
>
>
> On Tue, Jul 2, 2024, at 1:22 PM, Filipe Manana wrote:
> > On Tue, Jul 2, 2024 at 3:13=E2=80=AFPM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
>
> >> Unfortunately, the patch didn't improve anything.
> >> kswapd0 still consumes 100% CPU under load.
> >> And my system continues to freeze.
> >
> > Ok, the concerning part is the freezing and high cpu usage.
>
> We're seeing this in Fedora Rawhide, which is always using the most recen=
t mainline kernel.
>
> User first reported June 25 they were experiencing much longer backup tim=
es, normal is ~5 minutes, they're taking 1+ hours now, with frequent freeze=
s of the DE, notices kswapd using 100% CPU and then other processes also st=
art hanging with 100% CPU. Resolution is a power cycle and reverting to 6.9=
 series.
>
> The workload is described as "restic via ssh to a repo on a backup server=
".

Any idea how many files, their sizes, the sum of their sizes, etc?

>
> I can try to get more info to narrow down the last known good and first k=
nown bad kernels if that's useful.

Isn't that what Mikhail did? He bisected it to a specific commit.

Thanks.

>
>
> --
> Chris Murphy

