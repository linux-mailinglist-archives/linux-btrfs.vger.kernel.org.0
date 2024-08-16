Return-Path: <linux-btrfs+bounces-7229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E4954755
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9C228866D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63919F499;
	Fri, 16 Aug 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXoSeh2Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0B17BEB7;
	Fri, 16 Aug 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805953; cv=none; b=ZuEYl3kBdzDmt3ioWrzBaNaADFAzKS9dAbVe9xCthrUvw3rh9GGsuV/2sJK72BBvsSC5GFQvNobzkx+kl47PwYnfLeFx8PL0O0DgQPRur+roLkBg7IpgOgaR054tweT1UeBKLtdgyY5NJ5K2vmpsCDfcXZjilB9XONcFwWEEpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805953; c=relaxed/simple;
	bh=O61UUc1uRuNecDRXiAiTuYp2AzoG8zvf9F0mgbdCoMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCnQxLRVPZP3u6E2yxspKPQf0Hss5HZa5F5u03+WZDNLt/KTkYa70V1WGhNB9GGd95sMlUGZla6pQQaxMPxMPq/unZTXOwo62mOPo7Xg04lhlhiBe+4d45dFO11tJa8B7ACdrxpiSVsM1ub40nEEhkCwl+s73iz4V08K8l5Epf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXoSeh2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB904C4AF10;
	Fri, 16 Aug 2024 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805952;
	bh=O61UUc1uRuNecDRXiAiTuYp2AzoG8zvf9F0mgbdCoMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cXoSeh2QTIiGEwImr9rq2BCFJwgYRnzmn0SbiNQh729TTalhB+LQ4N1vterleT2wU
	 HNSs9qJGgXlkwbzt7DMtLvfJy0bfRTFVtw5jIqbm5/sJaLrXDR1t2GzSE3/nbLEVkZ
	 TP9gJR0wGGpbHF7LIbn5JTXT6/7WnEuDSjvwdTAYyyPhgN73fXcuP90CkSid9pzviQ
	 QBHKjmbkw9Hb4eJyijIaU0qR9V76JkNohNHkpwMTy81EtnU1LGCzf859R6ENlUFQ2d
	 aRdNru2837bmy/5HJ7KeolfD5XGebajf/45MTUHq9Ukmsu8TN4N2gL0NNRremuuqUF
	 awaPpv5cdGz7g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso2816888a12.1;
        Fri, 16 Aug 2024 03:59:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2pXcT/CVaHjheF7jsEWVAh0g77aVgf5+ntDhe/SXHl/PwNJtpOifvu4l77/GfL7h2s5p45MlV4+H34w==@vger.kernel.org, AJvYcCXBpxQNJPnPDbuGenzQKLqSYUrSbJ0KNlsNjn7OZGNZ8dICxL2gpoEednVQ79/6kBgsOwoZbFfr7u0q1TGF@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMPfqhk6AgWC/Y9QIO9Ny9UGjTRp1O7yYO8Qr5L8YzfDVyeQC
	pjVNH22xW9WRLus/KjyUjbeqRT/Z2u23EEB7VRr6gR71NMNApUeyM1dyrqDUr2E7E4t7T0ZJt8c
	AUm1pswvAHgOCitFosI9yC7ocvqY=
X-Google-Smtp-Source: AGHT+IH+zWSYMxOqKfT9jK+ik7+O2F7z4lseIBi8YYl+JUodl+ZqzxnDSGYp3IMEBBu6lJ42+HL73Aq4CxA2zNFpprU=
X-Received: by 2002:a17:907:e212:b0:a77:c199:9d01 with SMTP id
 a640c23a62f3a-a839292deecmr172829866b.22.1723805951142; Fri, 16 Aug 2024
 03:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com> <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name> <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
In-Reply-To: <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Aug 2024 11:58:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7-04s=j0fwGRx-TxGeP2-7ZeZ5Kdeo2fYdDFLE9ijupA@mail.gmail.com>
Message-ID: <CAL3q7H7-04s=j0fwGRx-TxGeP2-7ZeZ5Kdeo2fYdDFLE9ijupA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: intelfx@intelfx.name
Cc: =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:17=E2=80=AFAM <intelfx@intelfx.name> wrote:
>
> On 2024-08-16 at 00:21 +0200, intelfx@intelfx.name wrote:
> > On 2024-08-11 at 16:33 +0100, Filipe Manana wrote:
> > > <...>
> > > This came to my attention a couple days ago in a bugzilla report here=
:
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219121
> > >
> > > There's also 2 other recent threads in the mailing about it.
> > >
> > > There's a fix there in the bugzilla, and I've just sent it to the mai=
ling list.
> > > In case you want to try it:
> > >
> > > https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5baa9=
73dfc95.1723377230.git.fdmanana@suse.com/
> > >
> > > Thanks.
> >
> > Hello,
> >
> > I confirm that excessive "system" CPU usage by kswapd and btrfs-cleaner
> > kernel threads is still happening on the latest 6.10 stable with all
> > quoted patches applied, making the system close to unusable (not to
> > mention excessive power usage which crosses the line well *into*
> > "unusable" for low-power systems such as laptops).
> >
> > With just 5 minutes of uptime on a freshly booted 6.10.5 system, the
> > cumulative CPU time of kswapd is already at 2 minutes.

Less than 24 hours before your message, there was a patch merged to
Linus' tree, which was not (and is not) yet in any stable release
(including 6.10.5 of course).
Have you tried that patch?

>
> As a follow-up, after 1 hour of uptime of this system the total CPU
> time of kswapd0 is exactly 30 minutes. So whatever is the theoretical
> OOM issue that the extent map shrinker is trying to solve, the solution

It's not a theoretical problem.
It's a problem that any unprivileged user can trigger provided that
the amount of available disk space is much higher than total RAM,
which is by far the most common case.

The problem is explained in the commit change log, there's a
reproducer and it was even reported by a user:

https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amazon=
.com/

This link was included in the changelog of the patch when submitted to
the list [1], but somehow it disappeared when it was merged to the git
repository.

Any user can effectively trigger a denial of service by creating an
unlimited number of extent maps that never get removed while it keeps
a file descriptor open and doing writes, either with direct IO, which
is simpler, or even buffered IO in case it creates holes in the files
(example: keep doing append writes starting after current eof, to
create a bunch of holes). Even if that task doing that gets killed by
the OOM, as long as there are idle processes keeping the file open,
the problem doesn't go away.

[1] https://lore.kernel.org/linux-btrfs/1cb649870b6cad4411da7998735ab1141bb=
9f2f0.1712837044.git.fdmanana@suse.com/

> in its current form is clearly unacceptable.
>
> Can we please have it reverted on the basis of this severe regression,
> until a better solution is found?

Disabling the shrinker might be the best for now. I'm on vacation and
can't write and test code, but I do have plans for making it better
and solving any remaining issues.
There's already a patch for that from Qu.




>
> Thanks,
> --
> Ivan Shapovalov / intelfx /
>

