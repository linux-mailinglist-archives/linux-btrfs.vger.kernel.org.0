Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54909107CAA
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 04:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKWDtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 22:49:52 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40934 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWDtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 22:49:52 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2A77A4EAE15; Fri, 22 Nov 2019 22:49:51 -0500 (EST)
Date:   Fri, 22 Nov 2019 22:49:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
Message-ID: <20191123034950.GI22121@hungrycats.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <20191121222228.GG22121@hungrycats.org>
 <CAKbQEqFBYdi59QFPLXiiPvpFEzRnM-wG2Yz=2mdkeLOiOAAwmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tYlHSoJ8Aop8eNG2"
Content-Disposition: inline
In-Reply-To: <CAKbQEqFBYdi59QFPLXiiPvpFEzRnM-wG2Yz=2mdkeLOiOAAwmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--tYlHSoJ8Aop8eNG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 03:36:43PM +0100, Christian Pernegger wrote:
> Am Do., 21. Nov. 2019 um 23:22 Uhr schrieb Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org>:
> > Snapshot delete is pretty aggressive with IO [...]  can effectively han=
g for a few minutes
> > while btrfs-cleaner runs.
>=20
> It's doesn't look like it's btrfs-cleaner that blocks here, though,
> more like it's btrfs-transacti.

It's hard to tell.  btrfs-transaction does a lot of work for other threads.
If you have kernel stacks enabled,

	watch -n.1 cat /proc/<pid of btrfs-cleaner>/stack

will show you what btrfs-cleaner is up to.  If it's something like
'wait_for_commit' then btrfs-cleaner dumped a bunch of work on
btrfs-transaction, and now btrfs-transaction is trying to catch up.

> > Snapshot create has unbounded running time on 5.0 kernels.
>=20
> It looks to me like delete, not create, is the culprit here.
>=20
> > Anything that needs to take a sb_writer lock (which is almost everything
> > that modifies the filesystem) will hang until the snapshot create is do=
ne;
>=20
> It's not just fs activity, either. Even if I'm just typing in
> LibreOffice or at a bash prompt, the input isn't registered during the
> freeze (it's buffered, so it comes out all at once in the end).

IO pressure, especially blocked writes, can delay memory allocations
on Linux.  That stops almost everything dead in a modern GUI.

If you can log into the box from another machine you might be able to
watch what it's doing with 'top' etc.

On the other hand, from the other messages in this thread, it sounds like
you're using qgroups, which multiplies everything I said above by 1000.
qgroups is all in-kernel CPU, too, so userspace can't preempt it.

> Cheers,
> C.

--tYlHSoJ8Aop8eNG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXdisXAAKCRCB+YsaVrMb
nA7UAKCsb1IO8bCwdcyernbrDyjQ157MmwCg3vDYPYntB5QTj7LpCmMZaZR8Cf0=
=95HB
-----END PGP SIGNATURE-----

--tYlHSoJ8Aop8eNG2--
