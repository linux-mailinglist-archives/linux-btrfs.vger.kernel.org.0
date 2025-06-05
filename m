Return-Path: <linux-btrfs+bounces-14506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713EACF81F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE847A2031
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DFD2750FC;
	Thu,  5 Jun 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cph2m9ul"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413747260C;
	Thu,  5 Jun 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152302; cv=none; b=YBr6JLpw5inwUmZprn99sm799nTMfvhOley3QBANWLhFzLba9JyBBJrXAwUvHGC3zs929VwzdFygtMBilKF50lTppnKcCQPKoQljb9Yd5r6bxwecqNTfynM2wGbJMS7kUz03JZJ/O8bDDu2CZe8d41gx53/iqaX+s6cqA8JelDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152302; c=relaxed/simple;
	bh=dyH6RiFTISsak2E9X/cen0d7peVWpHE1EyY0UXYk804=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtUlueILSczaqQh7csIoOvB6EpNf59l9Cn/PQ87uZ42QxKPn1RJULcX61s0OUudwsKdpAj0Oe6FYoVHXVqdju64cbI3yop3wOCCebvBrNgrFC1BuXSxbCIalDo0TRRYi2aNq815Os6byNhlMcxRaEqFXy5A0WdRRFtYf3n+vjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cph2m9ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF2C4CEE7;
	Thu,  5 Jun 2025 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749152296;
	bh=dyH6RiFTISsak2E9X/cen0d7peVWpHE1EyY0UXYk804=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cph2m9ulOiJJJK6IHrF2i+w/mKgzQpa0NLjxKN2ohAV7W//qoHwOGSIfpEYtc0UAx
	 OYmcbyxPa4uyhdL8NNFfu8SxjC98Bf4cSnVW13O5CgSm7nTC/G5V87Ge1c6mK85rM8
	 KBmRdLQMG41jPZFckQYkpwzNVQRFXo9WM5lY/fiBvLbQnS+0KHLQd0hdVnmSILIb+B
	 yTyGouTQwciejA9S8B7/4V6ff6WZhYsoEjeltNkrJz2T4PKkLN+6RUQK18zhcS+IlK
	 6j25xKIWScG0mgQz2Z8uB5XmAMCjo2c3MzakFXbV43QFRTEc9W3K6DDf3PWKkiGIUy
	 NU7de+msQtozg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so2443673a12.3;
        Thu, 05 Jun 2025 12:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDmkm7ipGr7OVP4tV1W4jI7PgNZw5J5Mg92YJpYLxrstCVF69rdc+WQGoiYfYmhW7vptOhPUgscLgeoUA=@vger.kernel.org, AJvYcCXWHQPqbvaB9fm4cLjjIqizilTOc3e90zRT+ZkaRMqctUha3L0EBS12V+mnmVP6waRt3lyu3734@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5O7D6E75Z1yWeRVyz7nMF8nrNo3G0U8x7CY2ffAmovEeDyxs
	aKgR7K9bQuHkA6JqDm62RCGz83hI29jpozG/2BqPAKwKd4Kvm2/6FISeDWzaW0VX1k6fhj0xTRP
	+JtkXd8smfOjtB/40ZMgaEs0YvZLinKE=
X-Google-Smtp-Source: AGHT+IG6/xm9d5UyC4RIT+5onNDev/TCUhEa55Ztsy5StOW+h9VIHr8wTzUHbeJUCoF0wHReX+ctT+4efCEdWeHdSSE=
X-Received: by 2002:a17:907:2d92:b0:ad2:4b0c:ee8c with SMTP id
 a640c23a62f3a-ade1a92d206mr44347666b.35.1749152294126; Thu, 05 Jun 2025
 12:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
 <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 5 Jun 2025 20:37:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>
X-Gm-Features: AX0GCFsHwAZnzu7_gBOLqBTog1Rg0DmMLMiwJ4KSqyVeHJe55r0lBNo6_Ac2WAU
Message-ID: <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 5:52=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Running generic/032 can sporadically fail like this:
> >
> >   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfs=
tests/results//generic/032.out.bad)
> >       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
> >       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad =
   2025-05-28 10:39:34.549499493 +0100
> >       @@ -1,5 +1,6 @@
> >        QA output created by 032
> >        100 iterations
> >       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait=
: pid 3708239 is not a child of this shell
> >        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >.......=
.........<
> >        *
> >        100000
> >       ...
> >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.o=
ut /home/fdmanana/git/h
> >
> > This is because we are attempting to wait for a process that is not a
> > child process of the test process and it's instead a child of a process
> > spawned by the test.
> >
> > To make sure that after we kill the process running _syncloop() there
> > isn't any xfs_io process still running syncfs, add instead a trap to
> > to _syncloop() that waits for xfs_io to finish before the process runni=
ng
> > that function exits.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
>
> Oh... I didn't remove the _pgrep when I reverted those "setsid" things.
>
> CC Darrick, what do you think if I remove the _pgrep from common/rc
> and generic/032 :) On the other words, revert the:
>
>   commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
>   Author: Darrick J. Wong <djwong@kernel.org>
>   Date:   Mon Feb 3 14:00:29 2025 -0800
>
>       generic/032: fix pinned mount failure

Reverting that commit won't fix anything. One still needs a mechanism
to ensure that we don't attempt to unmount the scratch device while
xfs_io from sync_pid is still running. The mechanism implemented in
that commit is buggy and the trap based one from this patch should
always work (and we do this trap based approach on several other tests
to solve this same problem).

Thanks.


>
> Thanks,
> Zorro
>
> >  tests/generic/032 | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/tests/generic/032 b/tests/generic/032
> > index 48d594fe..b04b84de 100755
> > --- a/tests/generic/032
> > +++ b/tests/generic/032
> > @@ -28,6 +28,10 @@ _cleanup()
> >
> >  _syncloop()
> >  {
> > +     # Wait for any running xfs_io command running syncfs before we ex=
it so
> > +     # that unmount will not fail due to the mount being pinned by xfs=
_io.
> > +     trap "wait; exit" SIGTERM
> > +
> >       while [ true ]; do
> >               _scratch_sync
> >       done
> > @@ -81,15 +85,6 @@ echo $iters iterations
> >  kill $syncpid
> >  wait
> >
> > -# The xfs_io instance started by _scratch_sync could be stuck in D sta=
te when
> > -# the subshell running _syncloop & is killed.  That xfs_io process pin=
s the
> > -# mount so we must kill it and wait for it to die before cycling the m=
ount.
> > -dead_syncfs_pid=3D$(_pgrep xfs_io)
> > -if [ -n "$dead_syncfs_pid" ]; then
> > -     _pkill xfs_io
> > -     wait $dead_syncfs_pid
> > -fi
> > -
> >  # clear page cache and dump the file
> >  _scratch_cycle_mount
> >  _hexdump $SCRATCH_MNT/file
> > --
> > 2.47.2
> >
> >
>

