Return-Path: <linux-btrfs+bounces-14642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065DAD8CB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B36189F5C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5FF4FA;
	Fri, 13 Jun 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7KWPAas"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED493595A;
	Fri, 13 Jun 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819813; cv=none; b=FUjIiMq4X1fA+pJTc5bQ+6q4VKFW0DJLDWiIQp2Gs4IgqWTGwcY2CJleKCJ7ciEcsbO85vTtPPrW2/lRepCeQVLKzjLSfbAg2PVnBG6iZpC61uYThf5e5ptL/Fs7JwTzu1hDIrjA54k5/LfjPKAb46JI5hn+Q+cCm2BKrXdMMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819813; c=relaxed/simple;
	bh=iJGz1JI9gZHhPZEE4lR4hZtsjwVmgkig9x1HJ+ynBJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Klza1viQIyadGq2NMnjYwQRsGgeIDDkHSwtI2TbWWzVGBdNpNQPLSFwgc8+uhnYTNBLPcV2CByBJHjloO8IBJUz2Jy/C+8pYmwQEOn3k1rmxyCS66GkPW3BUX8cURIAYAIb6MC0wKuk0jt4N251knVenr4FVgDIhv9WXNsuH/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7KWPAas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EFFC4CEF5;
	Fri, 13 Jun 2025 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819813;
	bh=iJGz1JI9gZHhPZEE4lR4hZtsjwVmgkig9x1HJ+ynBJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P7KWPAasWdoqH8scWlqI6V8LYE/yZfcqqrfK7/ZdfP5hlxdN2WeH4SS/5kFe9NS0j
	 CJ3b1vVCKXQQ36Nz35OiIhtMM1jAvBqO9BVt4aDh1PwZ0TGV3CL3GUBglWfWfi1ez+
	 lLRCzOYDsVEqNKSg4z1Sq+9YGuwonUEjlZfu5OC4hVzAo3m+3DQedgEVGZ1SoZSJiG
	 Odbqvw5VIiaBPzSPRPiCKQ+ytD6RvbfJHcLoXZIrQAR/Lt+LLSKGRAv8ktJN7P8Fwy
	 VAFh+U5IgVgVlwVwqbP3tduAWRzA2TTeXcAVwfXt+79SRP0m4RjDx0uH3tDOZmxmpU
	 LgJecNn0wYPsw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acbb85ce788so348753666b.3;
        Fri, 13 Jun 2025 06:03:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFph32AwDLrb+bLFVXOCwYY8fSMbgX3LXIRs8zI12weX0KdagNu8oO5sp/q13WYIgA2uhfyEku@vger.kernel.org, AJvYcCWAEoMlWXd5zCRtbYJH8mRT4u/GprxqRdbS8osIL3yd11wDe4jb9Fes15QGxXiOt/KIzm4BTD49az8T78Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJMTdBRaJLOtD1N1FSlNmSkQvj1y7r4Xnjwe1Lkfr2XFIv0PD
	rXCj3o65+wFh3RMwxbzI1UkE7VNFjBF0taALq6FTMwJhqA4AVzbyJGL/KwI0BJZxt7WJxG7nxsF
	XNX6KQ5DW5Io0amA4vmiRt9268F/ppu4=
X-Google-Smtp-Source: AGHT+IEa++u/tUARLwFfhRugZXWtjxh9SkqMr5bButWgfz0A/414iTXnKqCcPtDYx3ChhejBPjZDPsZs7o9VMY2zqUg=
X-Received: by 2002:a17:907:97ce:b0:ad5:2d77:7ca7 with SMTP id
 a640c23a62f3a-adec569ebb3mr277372066b.43.1749819811548; Fri, 13 Jun 2025
 06:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
 <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com> <20250606005304.p36cjy23ekdlg53u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250606005304.p36cjy23ekdlg53u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Jun 2025 14:02:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H42puqn4=eX1SthjE_7eowQKvgWAzmbTx79eh+jJbtBqQ@mail.gmail.com>
X-Gm-Features: AX0GCFsgvB_O9BjkfyznlHI1mCLPOCEa6iCkb6t0bXMJlYFRbeGAeq47uFajwFk
Message-ID: <CAL3q7H42puqn4=eX1SthjE_7eowQKvgWAzmbTx79eh+jJbtBqQ@mail.gmail.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:53=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Jun 05, 2025 at 08:37:35PM +0100, Filipe Manana wrote:
> > On Thu, Jun 5, 2025 at 5:52=E2=80=AFPM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Running generic/032 can sporadically fail like this:
> > > >
> > > >   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub=
/xfstests/results//generic/032.out.bad)
> > > >       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +00=
00
> > > >       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.=
bad    2025-05-28 10:39:34.549499493 +0100
> > > >       @@ -1,5 +1,6 @@
> > > >        QA output created by 032
> > > >        100 iterations
> > > >       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: =
wait: pid 3708239 is not a child of this shell
> > > >        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >...=
.............<
> > > >        *
> > > >        100000
> > > >       ...
> > > >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/0=
32.out /home/fdmanana/git/h
> > > >
> > > > This is because we are attempting to wait for a process that is not=
 a
> > > > child process of the test process and it's instead a child of a pro=
cess
> > > > spawned by the test.
> > > >
> > > > To make sure that after we kill the process running _syncloop() the=
re
> > > > isn't any xfs_io process still running syncfs, add instead a trap t=
o
> > > > to _syncloop() that waits for xfs_io to finish before the process r=
unning
> > > > that function exits.
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > >
> > > Oh... I didn't remove the _pgrep when I reverted those "setsid" thing=
s.
> > >
> > > CC Darrick, what do you think if I remove the _pgrep from common/rc
> > > and generic/032 :) On the other words, revert the:
> > >
> > >   commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
> > >   Author: Darrick J. Wong <djwong@kernel.org>
> > >   Date:   Mon Feb 3 14:00:29 2025 -0800
> > >
> > >       generic/032: fix pinned mount failure
> >
> > Reverting that commit won't fix anything. One still needs a mechanism
> > to ensure that we don't attempt to unmount the scratch device while
> > xfs_io from sync_pid is still running. The mechanism implemented in
> > that commit is buggy and the trap based one from this patch should
> > always work (and we do this trap based approach on several other tests
> > to solve this same problem).
>
> Sure, don't worry, I didn't try to Nack your patch:) Just due to you remo=
ve
> the _pgrep() in your patch, then I thought it can be removed from common/=
rc
> totally, looks like nothing need that function. So I tried to confirm tha=
t
> with Darrick (who brought in this function:)
>
> Due to commit 1bb15a27573 does two things:
> 1) create a new function _pgrep
> 2) call _pgrep in g/032
>
> You've removed the 2) in this patch, so I'm wondering how about removing
> the 1) and 2) totally. As you can see, g/032 is the only one place uses
> _pgrep:

Ok, but that shouldn't be a blocker to fix a bug.
Can we make some progress on this?

Do you want me to remove the function in a v2 of this patch, or do it
as a separate patch?

Thanks.

>
> $ grep -rsn _pgrep .
> ./common/rc:40:_pgrep()
> ./tests/generic/032:87:dead_syncfs_pid=3D$(_pgrep xfs_io)
>
> Thanks,
> Zorro
>
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >  tests/generic/032 | 13 ++++---------
> > > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/tests/generic/032 b/tests/generic/032
> > > > index 48d594fe..b04b84de 100755
> > > > --- a/tests/generic/032
> > > > +++ b/tests/generic/032
> > > > @@ -28,6 +28,10 @@ _cleanup()
> > > >
> > > >  _syncloop()
> > > >  {
> > > > +     # Wait for any running xfs_io command running syncfs before w=
e exit so
> > > > +     # that unmount will not fail due to the mount being pinned by=
 xfs_io.
> > > > +     trap "wait; exit" SIGTERM
> > > > +
> > > >       while [ true ]; do
> > > >               _scratch_sync
> > > >       done
> > > > @@ -81,15 +85,6 @@ echo $iters iterations
> > > >  kill $syncpid
> > > >  wait
> > > >
> > > > -# The xfs_io instance started by _scratch_sync could be stuck in D=
 state when
> > > > -# the subshell running _syncloop & is killed.  That xfs_io process=
 pins the
> > > > -# mount so we must kill it and wait for it to die before cycling t=
he mount.
> > > > -dead_syncfs_pid=3D$(_pgrep xfs_io)
> > > > -if [ -n "$dead_syncfs_pid" ]; then
> > > > -     _pkill xfs_io
> > > > -     wait $dead_syncfs_pid
> > > > -fi
> > > > -
> > > >  # clear page cache and dump the file
> > > >  _scratch_cycle_mount
> > > >  _hexdump $SCRATCH_MNT/file
> > > > --
> > > > 2.47.2
> > > >
> > > >
> > >
> >
>

