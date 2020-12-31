Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF12E817E
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLaR27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 12:28:59 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36200 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLaR27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 12:28:59 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6E9F391AF75; Thu, 31 Dec 2020 12:28:15 -0500 (EST)
Date:   Thu, 31 Dec 2020 12:28:13 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     john terragon <jterragon@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: hierarchical, tree-like structure of snapshots
Message-ID: <20201231172812.GS31381@hungrycats.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 31, 2020 at 05:08:57PM +0100, john terragon wrote:
> On Thu, Dec 31, 2020 at 8:05 AM Andrei Borzenkov <arvidjaar@gmail.com> wr=
ote:
> >
>=20
> > >
> > > OK, but then could I use Y as parent of the rw snapshot, let's call it
> > > W, in a send?
> >
> > No
> >
>=20
> Of course I didn't mean to use Y as a parent of W itself but to a
> readonly snapshot of W whenever I want to send it to the second FS.
>=20
> And I just tried the following steps and they worked:
>=20
> 1) created subvol X
> 2) created readonly snap Y of X
> 3) sent Y to second FS
> 4) modified X
> 5) created readonly snap X1 of X
> 6) sent -p Y X1 to second FS
> 7) created readwrite snap Y1 of Y
> 8) modified Y1
> 9) created readonly snap Y1_RO of Y1
> 10) sent -p Y Y1_RO to second FS
>=20
> So, as you can see,
>=20
> -in 6) I've used the RO snap Y of X as the parent of X1 (and X) to
> send X1 to the second FS
>=20
> -in 10) I did the opposite, Y is still used as the parent but this
> time I've sent the RO snap of a subvol that is a snap of Y.
>=20
> So it seems to work both ways

I think your confusion is that you are thinking of these as a tree.
There is no tree, each subvol is an equal peer in the filesystem.

"send -p A B" just walks over subvol A and B and sends a diff of the
parts of B not in A.  You can pick any subvol with -p as long as it's
read-only and present on the receiving side.  Obviously it's much more
efficient if the two subvols have a lot of shared extents (e.g. because
B and A were both snapshots made at different times of some other subvol
C), but this is not required.

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCX+4KKAAKCRCB+YsaVrMb
nHSyAKCHGZLB4VhSrvzMmTcr/fOtPlzqPQCg66w6u7464EaGmLmEN8CVtfvIKgI=
=nqdR
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
