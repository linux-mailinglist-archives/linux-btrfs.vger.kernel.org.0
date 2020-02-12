Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2986315A019
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 05:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBLEXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 23:23:31 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43144 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 23:23:31 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D71435BCD34; Tue, 11 Feb 2020 23:23:29 -0500 (EST)
Date:   Tue, 11 Feb 2020 23:23:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: some more information on multi-hour data rollbacks, fsync, and
 superblock updates or lack thereof
Message-ID: <20200212042329.GM13306@hungrycats.org>
References: <20200212040154.GL13306@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Tc49Tft5g1TIuAea"
Content-Disposition: inline
In-Reply-To: <20200212040154.GL13306@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Tc49Tft5g1TIuAea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 11:01:54PM -0500, Zygo Blaxell wrote:
> One reboot later:
>=20
> 	# ls -l
> 	total 8448
> 	-rw-r--r-- 1 root root   92256 Feb 11 20:56 fsync.log
> 	-rw------- 1 root root 8550048 Feb 11 22:09 test-fsync
> 	-rw-r--r-- 1 root root    3652 Feb 11 19:57 transid.log
> 	# cmp test-fsync /boot/vmlinuz
> 	#
>=20
> So the file that was fsynced is complete and correct, but the file
> that was not fsynced--and 73 minutes of other writes throughout the
> filesystem--neatly disappeared.
>=20
> This was the third of three consecutive hour-plus transactions on
> this host:
>=20
>         end of transaction timestamp   seconds with same transid
>         2020-02-11-19-57-39 1581469059 4315.585493582
>         2020-02-11-21-22-06 1581474126 5067.863739094
>         [third transaction aborted by reboot 47 minutes later]
>=20
> The timestamps don't quite line up here--there is data on the filesystem
> after the last superblock update (at 21:22), but still far from current
> (73 minutes lost).  Maybe btrfs is updating one superblock at a time,
> so I only see one of every 3 transid updates with this method?  But the
> transid increment is always 1, and I'd expect to see increments 3 at a
> time if I was missing two thirds of them.

Sorry, I have the above backwards:  the superblock was updated at 21:22,
but the last data that survived without help from fsync was at 20:56,
26 minutes earlier, not later.  That makes more sense--the transaction
could include only data that was written before the superblock update.

transid.log would not contain the last transaction update record, since
that record is necessarily written after the transaction is complete.
So the file transid.log has the timestamp of the earlier transaction at
19:57.  The log update at 19:57:01 is included in the later transaction
at 21:22.  The log message about the 21:22 transaction died in the reboot,
because it was written at 21:22:01 and lost--I only have it because I
made copies of the logs to another machine before rebooting.

--Tc49Tft5g1TIuAea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXkN9vgAKCRCB+YsaVrMb
nKZTAJ0aqFaN041JURnpAAz4KciWF11wYgCeKlWJQfDZhDVZlfPIdOC979pYLIk=
=QuFA
-----END PGP SIGNATURE-----

--Tc49Tft5g1TIuAea--
