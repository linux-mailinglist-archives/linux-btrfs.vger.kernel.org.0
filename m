Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877A54C427
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSXpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 19:45:31 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40682 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfFSXpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 19:45:31 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 71EE3350D8C; Wed, 19 Jun 2019 19:45:28 -0400 (EDT)
Date:   Wed, 19 Jun 2019 19:45:28 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Claudius Winkel <claudius@winca.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS recovery not possible
Message-ID: <20190619234528.GA11831@hungrycats.org>
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
 <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
 <0c136862-4b3c-2459-62c6-44b8e92b2815@winca.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <0c136862-4b3c-2459-62c6-44b8e92b2815@winca.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2019 at 12:05:21AM +0200, Claudius Winkel wrote:
> Thanks for the Help
>=20
> I get my data back.
>=20
> But now I`m thinking... how did it come so far?
>=20
> Was it luks the dm-crypt?

dm-crypt is fine.  dm-crypt is not a magical tool for creating data loss
in Linux storage stacks.  I've never been able to prove dm-crypt ever
lost any data on my watch, and I've been testing for that event for 10+
years (half of them on btrfs).

dm-crypt's predecessors (e.g. cryptoloop) were notoriously underspecified
and buggy, but they are not dm-crypt.  Hopefully no modern distro still
offers these as an install option.

> What did i do wrong? Old Ubuntu Kernel? ubuntu 18.04

4.15 isn't old enough for its age alone to cause the issues you
encountered.

> What should I do now ... to use btrfs safely? Should i not use it with
> DM-crypt

You might need to disable write caching on your drives, i.e. hdparm -W0.

I have a few drives in my collection that don't have working write cache.
They are usually fine, but when otherwise minor failure events occur (e.g.
bad cables, bad power supply, failing UNC sectors) then the write cache
doesn't behave correctly, and any filesystem or database on the drive
gets trashed.  This isn't normal behavior, but the problem does affect
the default configuration of some popular mid-range drive models from
top-3 hard disk vendors, so it's quite common.

After turning off write caching, btrfs can keep running on these problem
drive models until they get too old and broken to spin up any more.
With write caching turned on, these drive models will eat a btrfs every
few months.


> Or even use ZFS instead...
>
> Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
> >=20
> > On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
> > > HI Guys,
> > >=20
> > > you are my last try. I was so happy to use BTRFS but now i really hate
> > > it....
> > >=20
> > >=20
> > > Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 20=
19
> > > x86_64 x86_64 x86_64 GNU/Linux
> > > btrfs-progs v4.15.1
> > So old kernel and old progs.
> >=20
> > > btrfs fi show
> > > Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes =
used 4.58TiB
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1=
 size 7.28TiB used 4.59TiB path /dev/mapper/volume1
> > >=20
> > >=20
> > > dmesg
> > >=20
> > > [57501.267526] BTRFS info (device dm-5): trying to use backup root at
> > > mount time
> > > [57501.267528] BTRFS info (device dm-5): disk space caching is enabled
> > > [57501.267529] BTRFS info (device dm-5): has skinny extents
> > > [57507.511830] BTRFS error (device dm-5): parent transid verify failed
> > > on 2069131051008 wanted 4240 found 5115
> > Some metadata CoW is not recorded correctly.
> >=20
> > Hopes you didn't every try any btrfs check --repair|--init-* or anything
> > other than --readonly.
> > As there is a long exiting bug in btrfs-progs which could cause similar
> > corruption.
> >=20
> >=20
> >=20
> > > [57507.518764] BTRFS error (device dm-5): parent transid verify failed
> > > on 2069131051008 wanted 4240 found 5115
> > > [57507.519265] BTRFS error (device dm-5): failed to read block groups=
: -5
> > > [57507.605939] BTRFS error (device dm-5): open_ctree failed
> > >=20
> > >=20
> > > btrfs check /dev/mapper/volume1
> > > parent transid verify failed on 2069131051008 wanted 4240 found 5115
> > > parent transid verify failed on 2069131051008 wanted 4240 found 5115
> > > parent transid verify failed on 2069131051008 wanted 4240 found 5115
> > > parent transid verify failed on 2069131051008 wanted 4240 found 5115
> > > Ignoring transid failure
> > > extent buffer leak: start 2024985772032 len 16384
> > > ERROR: cannot open file system
> > >=20
> > >=20
> > >=20
> > > im not able to mount it anymore.
> > >=20
> > >=20
> > > I found the drive in RO the other day and realized somthing was wrong
> > > ... i did a reboot and now i cant mount anmyore
> > Btrfs extent tree must has been corrupted at that time.
> >=20
> > Full recovery back to fully RW mountable fs doesn't look possible.
> > As metadata CoW is completely screwed up in this case.
> >=20
> > Either you could use btrfs-restore to try to restore the data into
> > another location.
> >=20
> > Or try my kernel branch:
> > https://github.com/adam900710/linux/tree/rescue_options
> >=20
> > It's an older branch based on v5.1-rc4.
> > But it has some extra new mount options.
> > For your case, you need to compile the kernel, then mount it with "-o
> > ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
> >=20
> > If it mounts (as RO), then do all your salvage.
> > It should be a faster than btrfs-restore, and you can use all your
> > regular tool to backup.
> >=20
> > Thanks,
> > Qu
> >=20
> > >=20
> > > any help

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXQrJFAAKCRCB+YsaVrMb
nEE/AKC6KfjVvnpdW9CcSI5LpqPdrg8JoACgpfpxVEVHsoJe9/+gjKICtQgo8/M=
=G8FH
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
