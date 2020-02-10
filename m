Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B2156E66
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 05:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJEKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 23:10:42 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48110 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJEKm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 23:10:42 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4DFF45B79FD; Sun,  9 Feb 2020 23:10:41 -0500 (EST)
Date:   Sun, 9 Feb 2020 23:10:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times,
 watchdog evasion on 5.4.11
Message-ID: <20200210041041.GH13306@hungrycats.org>
References: <20200209004307.GG13306@hungrycats.org>
 <2202848.tjv8jjdcNr@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DlCDOi0rxj7hgWX9"
Content-Disposition: inline
In-Reply-To: <2202848.tjv8jjdcNr@merkaba>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--DlCDOi0rxj7hgWX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 10:00:34AM +0100, Martin Steigerwald wrote:
> Zygo Blaxell - 09.02.20, 01:43:07 CET:
> > Up to that point, a few processes have been blocked for up to 5 hours,
> > but this is not unusual on a big filesystem given #1.  Usually
> > processes that read the filesystem (e.g. calling lstat) are not
> > blocked, unless they try to access a directory being modified by a
> > process that is blocked. lstat() being blocked is unusual.
>=20
> This is really funny, cause what you consider not being unusual, I'd=20
> consider a bug or at least a huge limitation.
>=20
> But in a sense I never really got that processed can be stuck in=20
> uninterruptible sleep on Linux or Unix *at all*. Such a situation=20
> without giving a user at least the ability to end it by saying "I don't=
=20
> care about the data that process is to write, let me remove it already"=
=20
> for me is a major limitation to what appears to be kind of specific to=20
> the UNIX architecture or at least the way the Linux virtual memory=20
> manager is working.

> That written I may be completely ignorant of something very important=20
> here and some may tell me it can't be any other way for this and that=20
> reason. Currently I still think it can.

The process in uninterruptible sleep is waiting for the filesystem code to
finish whatever it's doing so the in-memory and on-disk structures end in
a consistent state.  If whatever it's doing is "waiting for a lock held by
some other thread doing an expensive thing", it can block for a long time.

We can't simply abort the kernel thread here, which is why it's
uninterruptible wait (*).  Generic interruption would need to unwind the
kernel stack all the way back to userspace, reverting all changes made
to the filesystem's internal data structures as we go, without tripping
over the need for some other lock in the process, and without introducing
horrible new regressions.

In theory we can interrupt any kernel thread at any time--that happens
naturally whenever there's a BUG() or power failure, for instance--but
the effect on all the other threads that might be running is pretty
painful.

If you add a level of indirection--e.g. run the btrfs code in a VM and
access it via a network or virtio client--then we can interrupt the
client, but the server ends up having to finish whatever operation the
client requested anyway, so the client just gets to immediately hang
waiting for the server on its next call.

> And even if uninterruptible sleep can still happen cause it is really=20
> necessary, five hours is at least about five hours minus probably a minut=
e=20
> or so too long.

Yes it would be nice if btrfs could avoid overcommitting itself so badly,
but that's a somewhat older and larger-scoped bug.

> Ciao,
> --=20
> Martin
>=20
>=20

(*) well we could, if all the filesystem code was written that way.
Patches welcome!

--DlCDOi0rxj7hgWX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXkDXvgAKCRCB+YsaVrMb
nLVFAJ9ndrgeH4NtsfrA3xjnW++mSFewRACfU0YF1hq8Nf1ZMv8ThYOyLNbtLrw=
=m6A0
-----END PGP SIGNATURE-----

--DlCDOi0rxj7hgWX9--
