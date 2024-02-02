Return-Path: <linux-btrfs+bounces-2077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B7847557
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E283B1C21FB1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668614900B;
	Fri,  2 Feb 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEKrceoK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221414A08B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892573; cv=none; b=BHextlqKrciAgdFw+6Ossnvr1ITM4n1UwBElczOOhLwTkYI4OgKEn5YN3xJ4himWKN+fy8982vhTeoguwIXLNrmz3UZB8LdgRpqhd8jB9o7mvY8VdUxcL6YlTTPDZ71Fv4ZHeZpAWGAOwcDMynZyFW0RICWHgu7SPfWiwaVWu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892573; c=relaxed/simple;
	bh=jti3G/7Rus8IqP8tXawd3l4ZOWYZeHG6MrWwyynbqno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNCn7tKfULl0+CqNB2+2fd49AcDvXER9EXnt5KqmRQ16fVKSwHy2q+WiSKRR0t6POequh0kLwtpZ9DiSngxxSxUyMZQE92aPSMKRQFfP3lKu00IaHXJw/vVXxYVw1YwffCvDMJ8/4ykcughzOwGupVZpYHtl4NcHgLmj+vPgeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEKrceoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96BEC43394
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892572;
	bh=jti3G/7Rus8IqP8tXawd3l4ZOWYZeHG6MrWwyynbqno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EEKrceoKNAQNV0HZXTn3HhUrxzcJX29kj2slQJxDMsOfkgHAXHgW2cCCawhoe3ehx
	 OKGJ24FN22oRxjvb0tBBfatWHUCvPs/aiZkdWH31p8mfl3o1dTrs45P17tWcfZFPbN
	 w/hmWXi8vfdFeS0Vic6SlTjNhKLRlpOgbxDKc/MPNyOOgQaAIVtEMGbYb6AhpJ2hJv
	 P8VFAhE5tQcEL8gvPqeab584dUuxUVTPPpICowxnTK+yTDL2Nb54TFpFbaLu3psrat
	 pVwRZgkAEsY2mUlNDvsBNEHXROPGzWvrVtdKkkXLri4+MyxGEi2h/By60T/GtZ3e3s
	 b/LnKr8VzrdRQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so342008266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 08:49:32 -0800 (PST)
X-Gm-Message-State: AOJu0YzbaJFzwqqsEGCBFPKty/GYPSsGeF97wVja3JMWvnAp4P1vRvuE
	jhqadts6c0raZQZ79aHtfB7AR1PKvwMUSgiI8UoShphxF1cV6NgczrU4OW6U5UUm4yasJZ4klDs
	GN6NFrsdlausD6Dgdb8bI3XgpqfU=
X-Google-Smtp-Source: AGHT+IGvcV6gFFS1tFXrCFyK8wdq568l7RH0U0FfCxLlj6V1YdSbHhdllfN1FYMqi/mOwUDBP7RZKrT+/CcAenwTeMI=
X-Received: by 2002:a17:906:3b89:b0:a34:bc0d:3ca5 with SMTP id
 u9-20020a1709063b8900b00a34bc0d3ca5mr1822041ejf.13.1706892571338; Fri, 02 Feb
 2024 08:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706177914.git.fdmanana@suse.com> <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
 <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com>
 <2c1c21479e8998953541708648d0c02e21d7fd6e.camel@intelfx.name>
 <CAL3q7H5qeUv9phjDq9=NJsH6i2FscUv48M37YSza-UeEVChoOQ@mail.gmail.com> <64552ef1b8713e29bf31c18e92f610ef3cdd82ea.camel@intelfx.name>
In-Reply-To: <64552ef1b8713e29bf31c18e92f610ef3cdd82ea.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 Feb 2024 16:48:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6KTaji758O-hhHmNTA6UOPAko27Agd9U-vo9Uaw4Fmkg@mail.gmail.com>
Message-ID: <CAL3q7H6KTaji758O-hhHmNTA6UOPAko27Agd9U-vo9Uaw4Fmkg@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:52=E2=80=AFAM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2024-01-29 at 20:28 +0000, Filipe Manana wrote:
> > On Mon, Jan 29, 2024 at 5:56=E2=80=AFPM Ivan Shapovalov
> > <intelfx@intelfx.name> wrote:
> > >
> > > On 2024-01-29 at 12:49 +0000, Filipe Manana wrote:
> > > > On Sat, Jan 27, 2024 at 9:39=E2=80=AFPM Ivan Shapovalov
> > > > <intelfx@intelfx.name> wrote:
> > > > >
> > > > > On 2024-01-25 at 10:26 +0000, fdmanana@kernel.org wrote:
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > These fix a couple issues regarding block group deletion,
> > > > > > either
> > > > > > deleting
> > > > > > an unused block group when it shouldn't be deleted due to
> > > > > > outstanding
> > > > > > reservations relying on the block group, or unused block
> > > > > > groups
> > > > > > never
> > > > > > getting deleted since they were created due to pessimistic
> > > > > > space
> > > > > > reservation and ended up never being used. More details on
> > > > > > the
> > > > > > change
> > > > > > logs of each patch.
> > > > > >
> > > > > > Filipe Manana (5):
> > > > > >   btrfs: add and use helper to check if block group is used
> > > > > >   btrfs: do not delete unused block group if it may be used
> > > > > > soon
> > > > > >   btrfs: add new unused block groups to the list of unused
> > > > > > block
> > > > > > groups
> > > > > >   btrfs: document what the spinlock unused_bgs_lock protects
> > > > > >   btrfs: add comment about list_is_singular() use at
> > > > > > btrfs_delete_unused_bgs()
> > > > > >
> > > > > >  fs/btrfs/block-group.c | 87
> > > > > > +++++++++++++++++++++++++++++++++++++++++-
> > > > > >  fs/btrfs/block-group.h |  7 ++++
> > > > > >  fs/btrfs/fs.h          |  3 ++
> > > > > >  3 files changed, 95 insertions(+), 2 deletions(-)
> > > > > >
> > > > >
> > > > > Still broken for me, unfortunately.
> > > >
> > > > I'm curious about your workload. Is it something like continuous,
> > > > non-stop deduplication or cloning for example?
> > > >
> > > > Did you actually experience -ENOSPC errors?
> > > >
> > > > Also, if you unmount and then mount again the fs, any unused
> > > > block
> > > > groups should be scheduled for deletion once the cleaner thread
> > > > runs,
> > > > at least if there's not a huge workload for a minute or two.
> > >
> > > Apologies, I must have clarified the workload.
> > >
> > > The easiest way to reproduce the original problem was to run a
> > > metadata
> > > balance, e. g. `btrfs balance start -m /` or
> > > `for u in {0..75..5}; do btrfs balance start -musage=3D$u /`.
> > >
> > > I originally spotted this regression by observing an abnormally low
> > > metadata space utilization and trying to run the above balance,
> > > only to
> > > discover that it makes overallocation even worse.
> > >
> > > So, with the patchset applied, the _metadata balance_ is still
> > > broken.
> > > I cannot say anything about normal usage, but any attempt to
> > > balance
> > > metadata immediately explodes the metadata allocation. I did not
> > > experience a -ENOSPC per se, but the balance (that I used as a
> > > reproducer) eventually consumed *all* unallocated space on the
> > > volume
> > > and stopped making progress. Attempting to cancel that balance
> > > RO'ed
> > > the filesystem and I had to reboot.
> >
> > I tried that but I didn't see any problem.
> > Here's a sample test script:
> >
> > https://pastebin.com/raw/vc70BqY5
> >
> > >
> > > >
> > > > On top of this patchset, can you try the following patch?
> > > >
> > > > https://pastebin.com/raw/U7b0e03g
> > > >
> > > > If that still doesn't help, try the following the following patch
> > > > on
> > > > top of this patchset:
> > > >
> > > > https://pastebin.com/raw/rKiSmG5w
> > >
> > > Should I still try these patches to see if they help with metadata
> > > balance, or is that a different problem then?
> >
> > Yes. Please try them, given that I can't reproduce your issue with
> > the balance.
>
> Hi,
>
> The second pastebinned patch (applied on top of the patchset and the
> first pastebinned patch) passes my balance smoke test.

Ok, thanks, I've just sent it to the list a few minutes ago:

https://lore.kernel.org/linux-btrfs/eba624e8cef9a1e84c9e1ba0c8f32347aa487e6=
3.1706892030.git.fdmanana@suse.com/

>
> As for reproducing the issue: it's a long shot, but could you try on a
> 4K-native block device (i. e. where `blockdev --getpbsz` tells `4096`)?

Well, that's irrelevant. It doesn't change anything on btrfs (node
sizes, sector sizes, etc).

>
> >
> > I could trigger getting 1 or 2 at most unused metadata block groups
> > after having a bunch of tasks doing metadata operations, and patch
> > 3/5
> > is to address that case.
> >
> > So one thing I'm curious about, and I asked before, is that if you
> > unmount and mount again the fs, after a few minutes (without running
> > that balance), you should get space reclaimed,
> > as any empty block groups are scheduled for deletion at mount time,
> > and the next time the cleaner kthread runs, it deletes them.
>
> Yes, that indeed does happen. Cancelling the balance and letting the
> system idle for a while reclaims all (or almost all) overallocated
> space. However, that only happens _after_ I cancel the balance. If I do
> not cancel it, it ends up consuming all unallocated space on the volume
> and ceases to make progress. So, basically, at least the balance
> operation becomes completely unusable.

Ok, I see. I think relocation of a block group creates another block
group when reserving
space somewhere, and that block group gets caught next for relocation,
which generates
another one, and so forth.

Thanks for the testing and report.

>
> --
> Ivan Shapovalov / intelfx /

