Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581862E8222
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 22:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLaVhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 16:37:32 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35124 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgLaVhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 16:37:32 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0C54491BD4E; Thu, 31 Dec 2020 16:36:50 -0500 (EST)
Date:   Thu, 31 Dec 2020 16:36:50 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     john terragon <jterragon@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: hierarchical, tree-like structure of snapshots
Message-ID: <20201231213650.GT31381@hungrycats.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
 <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
 <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 31, 2020 at 09:48:54PM +0100, john terragon wrote:
> On Thu, Dec 31, 2020 at 8:42 PM Andrei Borzenkov <arvidjaar@gmail.com> wr=
ote:
> >
>=20
> >
> > How exactly you create subvolume with the same content? There are many
> > possible interpretations.
> >
>=20
> Zygo wrote that any subvol could be used with -p. So, out of
> curiosity, I did the following
>=20
> 1) btrfs sub create X
> 2) I unpacked some source (linux kernel) in X
> 3) btrfs sub create W
> 4) I unpacked the same source in W (so X and W have the same content
> but they are independent)
> 5) btrfs sub snap -r X X_RO
> 6) btrfs sub snap -r W W_RO
> 7) btrfs send W_RO | btrfs receive /mnt/btrfs2
> 8) btrfs send -p W_RO X_RO | btrfs receive /mnt/btrfs2
>=20
> And this is the exact output of 8)
>=20
> At subvol X_RO
> At snapshot X_RO
> ERROR: chown o257-1648413-0 failed: No such file or directory

Yeah, I only checked that send completed without error and produced a
smaller stream.

I just dumped the send metadata stream from the incremental snapshot now,
and it's more or less garbage at the start:

	# btrfs sub create A
	# btrfs sub create B
	# date > A/date
	# date > B/date
	# mkdir A/t B/u
	# btrfs sub snap -r A A_RO
	# btrfs sub snap -r B B_RO
	# btrfs send A_RO | btrfs receive --dump
	At subvol A_RO
	subvol          ./A_RO                          uuid=3D995adde4-00ac-5e49-=
8c6f-f01743def072 transid=3D7329268
	chown           ./A_RO/                         gid=3D0 uid=3D0
	chmod           ./A_RO/                         mode=3D755
	utimes          ./A_RO/                         atime=3D2020-12-31T15:51:3=
1-0500 mtime=3D2020-12-31T15:51:48-0500 ctime=3D2020-12-31T15:51:48-0500
	mkfile          ./A_RO/o257-7329268-0
	rename          ./A_RO/o257-7329268-0           dest=3D./A_RO/date
	utimes          ./A_RO/                         atime=3D2020-12-31T15:51:3=
1-0500 mtime=3D2020-12-31T15:51:48-0500 ctime=3D2020-12-31T15:51:48-0500
	write           ./A_RO/date                     offset=3D0 len=3D29
	chown           ./A_RO/date                     gid=3D0 uid=3D0
	chmod           ./A_RO/date                     mode=3D644
	utimes          ./A_RO/date                     atime=3D2020-12-31T15:51:3=
8-0500 mtime=3D2020-12-31T15:51:38-0500 ctime=3D2020-12-31T15:51:38-0500
	mkdir           ./A_RO/o258-7329268-0
	rename          ./A_RO/o258-7329268-0           dest=3D./A_RO/t
	utimes          ./A_RO/                         atime=3D2020-12-31T15:51:3=
1-0500 mtime=3D2020-12-31T15:51:48-0500 ctime=3D2020-12-31T15:51:48-0500
	chown           ./A_RO/t                        gid=3D0 uid=3D0
	chmod           ./A_RO/t                        mode=3D755
	utimes          ./A_RO/t                        atime=3D2020-12-31T15:51:4=
8-0500 mtime=3D2020-12-31T15:51:48-0500 ctime=3D2020-12-31T15:51:48-0500
	# btrfs send B_RO -p A_RO | btrfs receive --dump
	At subvol B_RO
	snapshot        ./B_RO                          uuid=3D4aa7db26-b219-694e-=
9b3c-f8f737a46bdb transid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f=
01743def072 parent_transid=3D7329268
	utimes          ./B_RO/                         atime=3D2020-12-31T15:51:3=
3-0500 mtime=3D2020-12-31T15:51:52-0500 ctime=3D2020-12-31T15:51:52-0500
	link            ./B_RO/date                     dest=3Ddate
	unlink          ./B_RO/date
	utimes          ./B_RO/                         atime=3D2020-12-31T15:51:3=
3-0500 mtime=3D2020-12-31T15:51:52-0500 ctime=3D2020-12-31T15:51:52-0500
	write           ./B_RO/date                     offset=3D0 len=3D29
	utimes          ./B_RO/date                     atime=3D2020-12-31T15:51:4=
1-0500 mtime=3D2020-12-31T15:51:41-0500 ctime=3D2020-12-31T15:51:41-0500
	rename          ./B_RO/t                        dest=3D./B_RO/u
	utimes          ./B_RO/                         atime=3D2020-12-31T15:51:3=
3-0500 mtime=3D2020-12-31T15:51:52-0500 ctime=3D2020-12-31T15:51:52-0500
	utimes          ./B_RO/u                        atime=3D2020-12-31T15:51:5=
2-0500 mtime=3D2020-12-31T15:51:52-0500 ctime=3D2020-12-31T15:51:52-0500
	# btrfs send A_RO | btrfs receive -v /tmp/test
	At subvol A_RO
	At subvol A_RO
	receiving subvol A_RO uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, stransi=
d=3D7329268
	write date - offset=3D0 length=3D29
	BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D995adde4-00ac-5e49-8c6f-f01743def072,=
 stransid=3D7329268
	# btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
	At subvol B_RO
	At snapshot B_RO
	receiving snapshot B_RO uuid=3D4aa7db26-b219-694e-9b3c-f8f737a46bdb, ctran=
sid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, parent_ct=
ransid=3D7329268
	ERROR: link date -> date failed: File exists

The btrfs_compare_trees function can handle arbitrary tree differences,
but something happens in one of the support functions and we get a
bogus link command.  The rest of the stream is OK though:  we fill
in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update all
the timestamps.

Oh well, I didn't say send didn't have any bugs.  ;)

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCX+5EbQAKCRCB+YsaVrMb
nIG7AKDZf98nK54ODpHRd204hA+guX/VtQCfXW9g/bXRFCFX06C9Gu4l9s8J32I=
=cJyQ
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
