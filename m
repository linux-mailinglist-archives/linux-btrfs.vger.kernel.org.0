Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E811514A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 04:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBDDej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 22:34:39 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45186 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgBDDej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 22:34:39 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 03D2D5A8420; Mon,  3 Feb 2020 22:34:38 -0500 (EST)
Date:   Mon, 3 Feb 2020 22:34:38 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: A collection of btrfs lockup stack traces (4.14..4.20.17, but
 not later kernels)
Message-ID: <20200204033438.GX13306@hungrycats.org>
References: <20190320033957.GA16651@hungrycats.org>
 <20190320034950.GC16651@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tpZe61tYkA9f+p/0"
Content-Disposition: inline
In-Reply-To: <20190320034950.GC16651@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--tpZe61tYkA9f+p/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 11:49:51PM -0400, Zygo Blaxell wrote:
> On Tue, Mar 19, 2019 at 11:39:59PM -0400, Zygo Blaxell wrote:
> > I haven't been able to easily reproduce these in a test environment;
> > however, they have been happening several times a year on servers in
> > production.
> >=20
> > Kernel:  most recent observation on 4.14.105 + cherry-picked deadlock
> > and misc hang fixes:
> >=20
> > 	btrfs: wakeup cleaner thread when adding delayed iput
> > 	Btrfs: fix deadlock when allocating tree block during leaf/node split
> > 	Btrfs: use nofs context when initializing security xattrs to avoid dea=
dlock
> > 	Btrfs: fix deadlock with memory reclaim during scrub
> > 	Btrfs: fix deadlock between clone/dedupe and rename
> >=20
> > Also observed on 4.20.13, and 4.14.0..4.14.105 (4.14.106 is currently
> > running, but hasn't locked up yet).
> >=20
> > Filesystem mount flags:  compress=3Dzstd,ssd,flushoncommit,space_cache=
=3Dv2.
> > Configuration is either -draid1/-mraid1 or -dsingle/-mraid1.  I've
> > also reproduced a lockup without flushoncommit.
> >=20
> > The machines that are locking up all run the same workload:
> >=20
> > 	rsync receiving data continuously (gigabytes aren't enough,
> > 	I can barely reproduce this once a month with 2TB of rsync
> > 	traffic from 10 simulated clients)
> >=20
> > 	bees doing continuous dedupe
> >=20
> > 	snapshots daily and after each rsync
> >=20
> > 	snapshot deletes as required to maintain free space
> >=20
> > 	scrubs twice monthly plus after each crash
> >=20
> > 	watchdog does a 'mkdir foo; rmdir foo' every few seconds.
> > 	If this takes longer than 50 minutes, collect a stack trace;
> > 	longer than 60 minutes, reboot the machine.

These deadlocks still occur on the LTS kernels 4.14 and 4.19 (I have
not tested earlier LTS kernels).  The deadlocks also occur on 4.15..4.18
and 4.20, but the deadlocks stopped on 5.0 and haven't occurred since.

I'm running a bisect to see if I can find where in 5.0 this was fixed,
and whether it is something that can be backported to stable.  This might
take a month or so, as it takes a few days to get a negative deadlock
result and I can only spare one VM for the tests.

In the meantime several other bugs have been fixed and those _have_
been backported to 4.14 and 4.19, so the test case for the bisect is
more aggressive:

	10x rsync write/updates
	bees dedupe, 4 threads
	snapshot create at random intervals (60-600 seconds)
	snapshot delete at random intervals
	balance start continuously
	balance cancel at random intervals
	scrub start continuously
	scrub cancel at random intervals

--tpZe61tYkA9f+p/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjjmTAAKCRCB+YsaVrMb
nN7aAKCScGU/5Ppi6qkP5JxTZHaICPF2AACfTTaPberTNCYmTEtxy4CUpLaCYqU=
=HaLm
-----END PGP SIGNATURE-----

--tpZe61tYkA9f+p/0--
