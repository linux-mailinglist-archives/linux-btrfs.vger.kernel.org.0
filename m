Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1656912BED6
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 21:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfL1UXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 15:23:46 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43026 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1UXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 15:23:46 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 07A3A5459F9; Sat, 28 Dec 2019 15:23:44 -0500 (EST)
Date:   Sat, 28 Dec 2019 15:23:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Remi Gauvin <remi@georgianit.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
Message-ID: <20191228202344.GE13306@hungrycats.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2019 at 06:04:21PM +0100, Leszek Dubiel wrote:
>=20
> PROBLEM SOLVED --- btrfs was busy cleaing after snaphot deletion few days
> ago, so it dodn't have time to "dev delete", that's why it was slow

That checks out.  Snapshot delete and remove-device/resize/balance are
not able to run at the same time.  There is a mutex, so one or the
other will run while the other is blocked.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> I restarted server, so job "btrfs delete" was not existent any more.
> But disks were still working (!!!). I wondered why? What is BTRFS doing a=
ll
> the time?
>=20
> I realized that afew days before starting "btrfs dev delete" I have remov=
ed
> many snapshots -- there were about 400 snapshots and I left 20 only. I did
> that because I have read that many snapshot could slowdown btrfs operatio=
ns
> severely.
>=20
>=20
>=20
> I made an experiment on another testing serwer:
>=20
> 1. started command "watch -n1 'btrfs fi df /"
> 2. started "iostat -x -m"
>=20
> Disks were not working at all.
>=20
>=20
> 3. Then I removed many shapshots on that testing server
>=20
> and I was watching:
>=20
> Data, single: total=3D6.56TiB, used=3D5.13TiB
> System, RAID1: total=3D32.00MiB, used=3D992.00KiB
> Metadata, RAID1: total=3D92.00GiB, used=3D70.56GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D1.39MiB
>=20
> Disks started to work hard. So btrfs was probably cleaining after snapshot
> deletion.
>=20
> At the beginning in "Metadata" line there was "used=3D70.00GiB".
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Metadata, RAID1: total=3D92.00GiB, used=3D=
70.00GiB
>=20
> It was changing all the time... getting lower and lower. During that proc=
ess
> in line
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GlobalReserve, single: total=3D512.00MiB, =
used=3D1.39MiB
>=20
> "used=3D" was going up until it reached about 100MiB, then it was flushed=
 to
> zero, and started again to fill, flush, fill, flush... some
> loop/buffer/cache (?).
> It convinced me, that after snapshot deletion btrfs is really working hard
> on cleanup.
> After some time "Metadata...used=3D" stopped changing, disks stopped work=
ing,
> server got lazy again.
>=20
>=20
>=20
> I got back to main server. Started to watch "Metadata...used=3D". It was =
going
> down and down...
> I waited. When "Metadata...used=3D" stopped changing, then "iostat -m" st=
opped
> showing any disk activity.
>=20
> I started "btrfs dev delete" again and now speed is 50Mb/sek. Hurrray!
> Problem solved.
>=20
>=20
> Sorry for not beeing clever enough to connect all this facts at the
> beginning.
> Anyway -- maybe in the future someone has the same problem, then btrfs
> experts could ask him if he let btrfs do some other hard work in the same
> time (eg cleaning up after massive snapsot deletion).
>=20
> Maybe it would be usful to have a tool to ask btrfs "what are you doing? =
are
> you busy?".
> It would respond "I am cleaing up after snapshot deletion... I am
> balancing... I am scrubbing... I am resizing... I am deleting ...".

Usually 'top' or 'iotop' suffices for that.  btrfs-cleaner =3D deleting
snapshots, other activities will be tied to their respective userspace
agents.  The balance/delete/resize/drop-snapshot mutex is the only special
case that I know of where one btrfs maintenance thread waits for another.

It might be handy to give users a clue on snapshot delete, like add
"use btrfs sub list -d to monitor deletion progress, or btrfs sub sync
to wait for deletion to finish".

>=20
>=20
>=20

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXge5zQAKCRCB+YsaVrMb
nCEyAJ401fz/uoUzTZLJFlkdlnVv03h8UgCgvZQBEq6lxOAZDVT5F/5Zg5u7jeI=
=ZLXg
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
