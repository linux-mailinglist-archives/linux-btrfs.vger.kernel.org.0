Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F83183E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 04:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKDNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 22:13:48 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47592 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBKDNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 22:13:48 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9324397C0C4; Wed, 10 Feb 2021 22:13:06 -0500 (EST)
Date:   Wed, 10 Feb 2021 22:13:06 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
Message-ID: <20210211031306.GL28049@hungrycats.org>
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
 <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
 <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
 <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
 <20210211030836.GE32440@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20210211030836.GE32440@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, I busted my mail client.  That was from me.  :-P

On Wed, Feb 10, 2021 at 10:08:37PM -0500, kreijack@inwind.it wrote:
> On Wed, Feb 10, 2021 at 08:14:09PM +0100, Goffredo Baroncelli wrote:
> > Hi Chris,
> >=20
> > it seems that systemd-journald is more smart/complex than I thought:
> >=20
> > 1) systemd-journald set the "live" journal as NOCOW; *when* (see below)=
 it
> > closes the files, it mark again these as COW then defrag [1]
> >=20
> > 2) looking at the code, I suspect that systemd-journald closes the
> > file asynchronously [2]. This means that looking at the "live" journal
> > is not sufficient. In fact:
> >=20
> > /var/log/journal/e84907d099904117b355a99c98378dca$ sudo lsattr $(ls -rt=
 *)
> > [...]
> > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000=
000000bd4f-0005baed61106a18.journal
> > --------------------- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000=
000bd64-0005baed659feff4.journal
> > --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000=
000000bd67-0005baed65a0901f.journal
> > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000=
000cc63-0005bafed4f12f0a.journal
> > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000=
000000cc85-0005baff0ce27e49.journal
> > ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000=
000cd38-0005baffe9080b4d.journal
> > ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000=
000000cd3b-0005baffe908f244.journal
> > ---------------C----- user-1000.journal
> > ---------------C----- system.journal
> >=20
> > The output above means that the last 6 files are "pending" for a de-fra=
gmentation. When these will be
> > "closed", the NOCOW flag will be removed and a defragmentation will sta=
rt.
>=20
> Wait what?
>=20
> > Now my journals have few (2 or 3 extents). But I saw cases where the ex=
tents
> > of the more recent files are hundreds, but after few "journalct --rotat=
e" the older files become less
> > fragmented.
> >=20
> > [1] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472=
036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L383
>=20
> That line doesn't work, and systemd ignores the error.
>=20
> The NOCOW flag cannot be set or cleared unless the file is empty.
> This is checked in btrfs_ioctl_setflags.
>=20
> This is not something that can be changed easily--if the NOCOW bit is
> cleared on a non-empty file, btrfs data read code will expect csums
> that aren't present on disk because they were written while the file was
> NODATASUM, and the reads will fail pretty badly.  The entire file would
> have to have csums added or removed at the same time as the flag change
> (or all nodatacow file reads take a performance hit looking for csums
> that may or may not be present).
>=20
> At file close, the systemd should copy the data to a new file with no
> special attributes and discard or recycle the old inode.  This copy
> will be mostly contiguous and have desirable properties like csums and
> compression, and will have iops equivalent to btrfs fi defrag.
>=20
> > [2] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472=
036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L3687
> >=20
> > On 2/10/21 7:37 AM, Chris Murphy wrote:
> > > This is an active (but idle) system.journal file. That is, it's open
> > > but not being written to. I did a sync right before this:
> > >=20
> > > https://pastebin.com/jHh5tfpe
> > >=20
> > > And then: btrfs fi defrag -l 8M system.journal
> > >=20
> > > https://pastebin.com/Kq1GjJuh
> > >=20
> > > Looks like most of it was a no op. So it seems btrfs in this case is
> > > not confused by so many small extent items, it know they are
> > > contiguous?
> > >=20
> > > It doesn't answer the question what the "too small" threshold is for
> > > BTRFS_IOC_DEFRAG, which is what sd-journald is using, though.
> > >=20
> > > Another sync, and then, 'journalctl --rotate' and the resulting
> > > archived file is now:
> > >=20
> > > https://pastebin.com/aqac0dRj
> > >=20
> > > These are not the same results between the two ioctls for the same
> > > file, and not the same result as what you get with -l 32M (which I do
> > > get if I use the default 32M). The BTRFS_IOC_DEFRAG interleaved result
> > > is peculiar, but I don't think we can say it's ineffective, it might
> > > be an intentional no op either because it's nodatacow or it sees that
> > > these many extents are mostly contiguous and not worth defragmenting
> > > (which would be good for keeping write amplification down).
> > >=20
> > > So I don't know, maybe it's not wrong.
> > >=20
> > > --
> > > Chris Murphy
> > >=20
> >=20
> >=20
> > --=20
> > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCYCSgvgAKCRCB+YsaVrMb
nACDAJsHJE+C+04+I/hVJfUoosO/MKK1GACfZB/jHkeJ5FYZOIzY60uzPdp3aQI=
=TmBq
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
