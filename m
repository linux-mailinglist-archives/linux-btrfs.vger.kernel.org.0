Return-Path: <linux-btrfs+bounces-8259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F49874AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18971C23530
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72FD52F88;
	Thu, 26 Sep 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNqKez/v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA518035;
	Thu, 26 Sep 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358353; cv=none; b=TRoQJ0MwQxMf/Tq60z88/TLHS+0hJqsaDQausaCe37+MzFApcUkCOAMQ4sP4NGog9CiDo7v2MANFK58PwlSQuIj/ECokZCh9POc12HJrxStFi6C20gOPZCKlfDEWbveUjHQAJ4ZpswPJ7pIZDRMLtoxdnIFPCWcGMvtmmUbXXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358353; c=relaxed/simple;
	bh=1uFJb2e5ZoM+/Gw6903F0Y1uaBMhlpQKR9SnwwgaLWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2mZS7eJVjKoiCq10jpoHiiTebXsS5EcyssL4Xqr+XNIkutXO+NuEPqoes/O9ClA4egS/kQ6wR6gChcE9abmG/O5UrLFQiLx8xkoK8m/cqMaWaC+MeYbaqMhZQ5gPPeqvAO6uyYHpBgRT7AyKKCpFUaWZyOVnsbyF6K6dR03s/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNqKez/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58208C4CEC6;
	Thu, 26 Sep 2024 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727358353;
	bh=1uFJb2e5ZoM+/Gw6903F0Y1uaBMhlpQKR9SnwwgaLWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mNqKez/vYHIjFhna6yVhFlestNGVJWSPvIAFMJoZg2SHWbk6ZJlutsj2amAsAVCjG
	 pKXB8F8P0O02tKk7a3vMG1KgpLpa0dr/A9m01+TGWmh1iA5XJ8Kt5exJQSS+A2Q5h8
	 Is1crBEmAI/f3vppbede8K+kZB0WGB/ThjBIKWCPE5PuWBDPGy2x0C6wyz3IN7vquh
	 cQdYBG/o/21OkvlWqws7Xm8Voq6e0maphddEP5GtTaD0+TEi+OhxrapZLDKD1gRc4k
	 u1aliz3EnfCopyWuXsYnmDwWPfAzSWdtN69GfyMmDp9OX/MmBF/znQzpFLV7B2Uo9m
	 ctKMqwS3U6LwA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so137515466b.3;
        Thu, 26 Sep 2024 06:45:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvbCN5SQ1kDjYdoGlGoSrSrvzxfDKiTue7DjAJtrUhCJHwVsz4QFvfquFnPAbz7dU9xSf8b91hvZGhvAVX@vger.kernel.org, AJvYcCWityCKlKzTxHeWFh5fuIeIFc1Jc3FOFTgcE1uGCCEwMM7mRzdzJSgK6BpnGo2FRVlqsj+MU3tLanm79w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcqmI46cor6HnEXRnVCiG2+h4SGRDMh38PqeIs8LcaEqeQl9D
	/sFjgrffTmav5b02EibkzDOtMVk/ZwJXMU4QRxsegos/fKxuoU8DTJkC6jxBlrnLx9+szRjXync
	JTn1SNtAq1S6CxGQ0zotV1lXDJuI=
X-Google-Smtp-Source: AGHT+IFEY4RcEcOqFR2EbtRy+3OabibFd0iyiOoP2ILjcXpxzOCAS3hrOlb6wpUaxVim4qPQ7kNIkbJ08AWJAFEXPYM=
X-Received: by 2002:a17:907:9627:b0:a8a:83e9:43e2 with SMTP id
 a640c23a62f3a-a93a0343183mr481200566b.12.1727358351926; Thu, 26 Sep 2024
 06:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com> <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
 <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
 <CAL3q7H7-04s=j0fwGRx-TxGeP2-7ZeZ5Kdeo2fYdDFLE9ijupA@mail.gmail.com> <c876143d683d356a1c657455e295525f18e08895.camel@intelfx.name>
In-Reply-To: <c876143d683d356a1c657455e295525f18e08895.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 14:45:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6onXi5oZT8vJaCnqKZKjMm-gq2FiDx3583nu3mfsPNAg@mail.gmail.com>
Message-ID: <CAL3q7H6onXi5oZT8vJaCnqKZKjMm-gq2FiDx3583nu3mfsPNAg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:16=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.n=
ame> wrote:
>
> On 2024-08-16 at 11:58 +0100, Filipe Manana wrote:
> > On Fri, Aug 16, 2024 at 12:17=E2=80=AFAM <intelfx@intelfx.name> wrote:
> > >
> > > On 2024-08-16 at 00:21 +0200, intelfx@intelfx.name wrote:
> > > > On 2024-08-11 at 16:33 +0100, Filipe Manana wrote:
> > > > > <...>
> > > > > This came to my attention a couple days ago in a bugzilla report =
here:
> > > > >
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219121
> > > > >
> > > > > There's also 2 other recent threads in the mailing about it.
> > > > >
> > > > > There's a fix there in the bugzilla, and I've just sent it to the=
 mailing list.
> > > > > In case you want to try it:
> > > > >
> > > > > https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5=
baa973dfc95.1723377230.git.fdmanana@suse.com/
> > > > >
> > > > > Thanks.
> > > >
> > > > Hello,
> > > >
> > > > I confirm that excessive "system" CPU usage by kswapd and btrfs-cle=
aner
> > > > kernel threads is still happening on the latest 6.10 stable with al=
l
> > > > quoted patches applied, making the system close to unusable (not to
> > > > mention excessive power usage which crosses the line well *into*
> > > > "unusable" for low-power systems such as laptops).
> > > >
> > > > With just 5 minutes of uptime on a freshly booted 6.10.5 system, th=
e
> > > > cumulative CPU time of kswapd is already at 2 minutes.
> >
> > Less than 24 hours before your message, there was a patch merged to
> > Linus' tree, which was not (and is not) yet in any stable release
> > (including 6.10.5 of course).
> > Have you tried that patch?
>
> Yes, I did =E2=80=94 as I said, I tried 6.10.5 with all combinations of p=
atches
> ever posted in this thread (skipping those that I was not able to
> apply; it seems that there were a few mutually incompatible attempts to
> improve the extent map shrinker, some of which have already gone into
> the stable tree, thus making others inapplicable).
>
> > > As a follow-up, after 1 hour of uptime of this system the total CPU
> > > time of kswapd0 is exactly 30 minutes. So whatever is the theoretical
> > > OOM issue that the extent map shrinker is trying to solve, the soluti=
on
> >
> > It's not a theoretical problem.
> > It's a problem that any unprivileged user can trigger provided that
> > the amount of available disk space is much higher than total RAM,
> > which is by far the most common case.
> >
> > The problem is explained in the commit change log, there's a
> > reproducer and it was even reported by a user:
> >
> > https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@am=
azon.com/
> >
> > This link was included in the changelog of the patch when submitted to
> > the list [1], but somehow it disappeared when it was merged to the git
> > repository.
> >
> > Any user can effectively trigger a denial of service by creating an
> > unlimited number of extent maps that never get removed while it keeps
> > a file descriptor open and doing writes, either with direct IO, which
> > is simpler, or even buffered IO in case it creates holes in the files
> > (example: keep doing append writes starting after current eof, to
> > create a bunch of holes). Even if that task doing that gets killed by
> > the OOM, as long as there are idle processes keeping the file open,
> > the problem doesn't go away.
>
> Sorry, I did not intend to sound dismissive =E2=80=94 what I wanted to sa=
y was
> that we fixed an edge case (and yes, I acknowledge that this edge case
> could be a security problem) by instead pessimizing a common case.

So I've recently sent out a patchset to update the shrinker and
re-enable it again:

https://lore.kernel.org/linux-btrfs/cover.1727174151.git.fdmanana@suse.com/

It applies against the current for-next branch, and should apply
against a 6.11 release too, except for the last patch due to a rename
in a function: CONFIG_BTRFS_DEBUG to CONFIG_BTRFS_EXPERIMENTAL.
I can prepare a git branch based on a 6.11 release (or 6.10) if anyone
prefers that rather than manually picking patches and resolving
conflicts (or testing for-next which has many unrelated changes).

If any of you can test it and report, it would be much appreciated.
Thanks.


>
> --
> Ivan Shapovalov / intelfx /
>
> > [1] https://lore.kernel.org/linux-btrfs/1cb649870b6cad4411da7998735ab11=
41bb9f2f0.1712837044.git.fdmanana@suse.com/
> >
> > > in its current form is clearly unacceptable.
> > >
> > > Can we please have it reverted on the basis of this severe regression=
,
> > > until a better solution is found?
> >
> > Disabling the shrinker might be the best for now. I'm on vacation and
> > can't write and test code, but I do have plans for making it better
> > and solving any remaining issues.
> > There's already a patch for that from Qu.

