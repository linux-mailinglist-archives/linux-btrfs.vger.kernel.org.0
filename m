Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2802E85EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Jan 2021 00:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAAXLw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 18:11:52 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42892 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAAXLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 18:11:51 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 37DEF91FE58; Fri,  1 Jan 2021 18:11:10 -0500 (EST)
Date:   Fri, 1 Jan 2021 18:11:09 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     john terragon <jterragon@gmail.com>, sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: hierarchical, tree-like structure of snapshots
Message-ID: <20210101231109.GU31381@hungrycats.org>
References: <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
 <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
 <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
 <20201231213650.GT31381@hungrycats.org>
 <49e405a1-ca48-7654-6b1e-408bcf6553b8@gmail.com>
 <c61863f5-64f5-2fe7-0607-11debddc1d7f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <c61863f5-64f5-2fe7-0607-11debddc1d7f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 01, 2021 at 11:40:28PM +0300, Andrei Borzenkov wrote:
> 01.01.2021 14:42, Andrei Borzenkov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 01.01.2021 00:36, Zygo Blaxell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > ...
> >>
> >> Yeah, I only checked that send completed without error and produced a
> >> smaller stream.
> >>
> >> I just dumped the send metadata stream from the incremental snapshot n=
ow,
> >> and it's more or less garbage at the start:
> >>
> >> 	# btrfs sub create A
> >> 	# btrfs sub create B
> >> 	# date > A/date
> >> 	# date > B/date
> >> 	# mkdir A/t B/u
> >> 	# btrfs sub snap -r A A_RO
> >> 	# btrfs sub snap -r B B_RO
> > ...
> >> 	# btrfs send A_RO | btrfs receive -v /tmp/test
> >> 	At subvol A_RO
> >> 	At subvol A_RO
> >> 	receiving subvol A_RO uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, st=
ransid=3D7329268
> >> 	write date - offset=3D0 length=3D29
> >> 	BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D995adde4-00ac-5e49-8c6f-f01743de=
f072, stransid=3D7329268
> >> 	# btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
> >> 	At subvol B_RO
> >> 	At snapshot B_RO
> >> 	receiving snapshot B_RO uuid=3D4aa7db26-b219-694e-9b3c-f8f737a46bdb, =
ctransid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, pare=
nt_ctransid=3D7329268
> >> 	ERROR: link date -> date failed: File exists
> >>
> >> The btrfs_compare_trees function can handle arbitrary tree differences,
> >=20
> > I am not sure. It apparently relies on the fact that inodes are ever
> > monotonically increasing. This is probably true for clones of the same
> > subvolume (I assume clone inherits highest_objectid) but two subvolumes
> > created independently have the same range of inode numbers.
> >=20
>=20
> In particular in your example both A/date and B/date have identical
> inode numbers and in general INODE_ITEMs are identical (including
> generation numbers) up to times so two inodes are compared as changed.
> At the same time INODE_REFs for them are considered different because
> INODE_ITEMs for root have different generations. This leads to code path
> that attempts to create additional alias to existing inode, as it is
> regular file it tries to link it. It does not really compares ref names
> at this point at all.
>=20
> This would not really be possible if A and B were clones of the same
> subvolume (not necessary consecutive) as A/date and B/date would always
> have different inode numbers.

After v5.11-rc1 inode_cache can no longer be used, but any filesystem that
has inode_cache in its history might have cases like this hiding in
metadata even with a linear series of snapshots.

The send code is mostly used to transmit linear sequences of snapshots
(a series of snapshots which capture the state of a single subvol at
different times, ordered from oldest to newest) between machines that
are not using the inode_cache mount option.  Any other case isn't getting
very well tested in the field, even if it happens to work sometimes.

> If I force different generation numbers for A/date and B/date (by
> syncing in between) send stream contains correct sequence of removing
> old B/date (from A clone) and re-creating it again.
>
> Which shows that unfortunately generation numbers are not reliable to
> differentiate between different object generations (pun unintended). As
> I understand generation is tied to transaction and multiple changes can
> be packed into one transaction.

I'm pretty sure that the 6000+ lines of special-case code in send.c still
don't cover every possible case, or even all of the likely ones, even
with linear snapshot sequences.  We still get people on IRC reporting
strange receive issues, and usually the best solution we can find is
to start over with a new full send.  That's OK for small filesystems,
but when you have to unexpectedly do a full send of dozens of terabytes
over a medium-speed link, it's probably time to switch to rsync.

Subversion used to have problems like this (maybe it still does, I
switched to git years ago) where a complicated commit that combined
multiple operations on objects of the same name would break the tool.
I'm surprised btrfs is trying to do similar things in the kernel
(though with the current send implementation there's nowhere else we
could do them).  At least for fsync we get to say "nope, too hard,
do a full commit instead" when complications arise.

> > Also I am not sure if using later clone as base for difference to
> > earlier clone will work for the same reason.

That use case can come up e.g. if you have snapshots of / and you roll
back to an earlier snapshot after a bad upgrade, but your backups are
using incremental snapshots made from '/'.  Then the last-sent-snapshot
(from the bad upgrade) is newer than the origin subvol (from an earlier
good upgrade, with new modifications on top).

Cases like these really need to work, or at least reliably throw
errors when they have failed, as the application that rolls back to
earlier snapshots might have no knowledge of the application that does
incremental send backups on a user's system if they integrated tools
=66rom different vendors.

> >> but something happens in one of the support functions and we get a
> >> bogus link command.  The rest of the stream is OK though:  we fill
> >> in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update all
> >> the timestamps.
> >>
> >> Oh well, I didn't say send didn't have any bugs.  ;)
> >>
> >=20
>=20
>=20




--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCX++sCgAKCRCB+YsaVrMb
nFONAKDbMQr9/DaMAJHKYcVzlkXys3qvEwCg51Y5C+ua9Yo+kxY0MkN44aqGjck=
=eWb+
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
