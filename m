Return-Path: <linux-btrfs+bounces-11372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857EA3092A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 11:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C002C7A1384
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899BC1F3D31;
	Tue, 11 Feb 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxJ7Jrpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7631F3B8A;
	Tue, 11 Feb 2025 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271349; cv=none; b=UGzzY/IKA2CVuxw4Dm1DpyJtROBFLsguHMlmVJueJkSLEPn60Xe0oW/GV+GXvy/xxYvJGxgW0Ness2BE0h42CDSiD44ZloovwcjqNLckbsUp42ikPRZbmaS/qS25L69U+ZaCPLNCyYGGwlhmfdAqnWfdquUfXaK3EopcbZY9294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271349; c=relaxed/simple;
	bh=IvHR8ZVU8lzZrIYM3mBaqJGQwC+2WNqWo0OmDyEGhXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7c03CpGI0rLphKSmooHNPqx6enYSxv7zi89Sm7bVNlo9X/e6DIx0C85pe4ku58Uzr4YwhSFoI0iZ3MkjYck8fbw/vzqknKjiSIqDprjpNxKKVpHCsU5U/guBep1F61ftK1QTFT5OQXUSMnB8X9QtwayqR6Par0Qz23y01AADCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxJ7Jrpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB7C4CEE6;
	Tue, 11 Feb 2025 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739271349;
	bh=IvHR8ZVU8lzZrIYM3mBaqJGQwC+2WNqWo0OmDyEGhXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PxJ7JrpddKsFeYh2EZn0SHVhm5foLMrHMH/BaKNRz/zaTu1r6liKkvDqbMpLqntY/
	 WjQFkJ6mzxptaOHJIZtIGOA6/kFukGBvCbM+gNm6SCFZjqGD7+AGY7Q8syCgAZjl6d
	 8LYPyerFmIJw5qJEBSiXimovdUu3wOO1MW9mXlPPLBM02oP/wKS4VjBLN+OSx3guMF
	 +i03dRzdNWV0QM+91/G5mCHyUVEW34la+Xz0uBILsIiwBsdiwVg7f551i8tsJtnj5N
	 7rERXgI8Mh72KF/zfKxqfnL/ldLbG67dTrg3KPdo9CQaX1Cmy/PRR1oAgnac/60Cjd
	 4MwgOSmJn/DjA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7b7250256so361190366b.0;
        Tue, 11 Feb 2025 02:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGqe3eAr61DhkF7SZ3zls767kjbXGFpJoaI1ae1oNmo7YvRSQ9FWg89BJS2wgc66ugSco80d7ZSVxvWpQ=@vger.kernel.org, AJvYcCXFHI5tgINhw9y9JkJ9uog93P8ElzEZWGCPiRglGSTZG3XPKdURJta0m5V7PLzbzNGwyvpVe9OZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/J9x2jjHrmZR/reQpC3ZZIpG16s7XbxwFlTXpN9El2NUdabx
	lWUMvKEB3vzDvm/BcFTc5avNJ6QkjhT/CqxMbuMEUZFNs/1H72GWhGejcdYAEqIKjF8gi5CU8v/
	05r9RZj6vMEmKlSrXjweN+yjJLHA=
X-Google-Smtp-Source: AGHT+IG5mTREYnDuy3g3gixeRHMnEa/WKQpTVjERA2VVsAzwBuhw/SnpXy+/5WSvm7b7z56/MsoDJAlUNGYPTo5FOeg=
X-Received: by 2002:a17:907:890b:b0:ab7:e234:526b with SMTP id
 a640c23a62f3a-ab7e2345b81mr152745666b.3.1739271347642; Tue, 11 Feb 2025
 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <Z6TC_yP7pTlzDOH4@infradead.org> <20250206155501.GM21799@frogsfrogsfrogs> <20250210143702.6f5fet6rzrkha7r2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250210143702.6f5fet6rzrkha7r2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 11 Feb 2025 10:55:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H54Ojqj87OLUs0+H9y+LgOhnWy6Jmw3SJ-O0K9uU9eWsg@mail.gmail.com>
X-Gm-Features: AWEUYZmhFHnaOzs6W8AaEBn4m54QxJ2gQlBKxjJHJAb-0Vq16C79K9dqAqAfVBw
Message-ID: <CAL3q7H54Ojqj87OLUs0+H9y+LgOhnWy6Jmw3SJ-O0K9uU9eWsg@mail.gmail.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
To: Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:37=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Feb 06, 2025 at 07:55:01AM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 06, 2025 at 06:11:11AM -0800, Christoph Hellwig wrote:
> > > On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > > > +if [ "$FSTYP" =3D "xfs" ]; then
> > > > + _fixed_by_kernel_commit 68415b349f3f \
> > > > +         "xfs: Fix the owner setting issue for rmap query in xfs f=
smap"
> > > > + _fixed_by_kernel_commit ca6448aed4f1 \
> > > > +         "xfs: Fix missing interval for missing_owner in xfs fsmap=
"
> > > > +fi
> > >
> > > How about you add a new helper instead of the boilerplate, something
> > > like
> > >
> > > _fixed_by_fs_kernel_commit xfs 68415b349f3f \
> > >     "xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>
> This looks good to me ^^
>
> >
> > While we're at it, we should move these _fixed_by* functions to a
> > separate file to declutter common/rc?
> >
> > And maybe add a few more dumb wrappers like
> >
> > _fixed_by_xfsprogs_commit()
> > {
> >       test "$FSTYP" =3D "xfs" && \
> >               __fixed_by_git_commit xfsprogs "$@"
>
> Yes, this makes sense to me.
>
> Hi Filipe, I can review and merge this patch at first, if you'd like to
> do above changes in another patch. Or I'll ignore this one, and wait your
> next patchset. What's your plan?

You may review and merge if it's ok for you.

As for the refactoring, it will take a while, I would likely have to
go over hundreds of generic tests, which I can't afford right now.

Thanks.

>
> Thanks,
> Zorro
>
> > }
> >
> > to replace the opencoded versions?
> >
> > --D
> >
> > > ?
> > >
> >
>

