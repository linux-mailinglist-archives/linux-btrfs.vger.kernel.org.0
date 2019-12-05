Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277F0113A0D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 03:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfLECpq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 21:45:46 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43822 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfLECpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 21:45:45 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D86E450D745; Wed,  4 Dec 2019 21:45:44 -0500 (EST)
Date:   Wed, 4 Dec 2019 21:45:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Gard Vaaler <gardv@megacandy.net>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unrecoverable corruption after loss of cache
Message-ID: <20191205024544.GW22121@hungrycats.org>
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <2292c7cc-fc18-364b-7b7c-dfef014a028f@suse.com>
 <E5ED2688-A506-4D11-8D01-27BD7C366894@megacandy.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4N29bJelYIMOTi0e"
Content-Disposition: inline
In-Reply-To: <E5ED2688-A506-4D11-8D01-27BD7C366894@megacandy.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--4N29bJelYIMOTi0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 10:27:49PM +0100, Gard Vaaler wrote:
> > 1. des. 2019 kl. 19:51 skrev Nikolay Borisov <nborisov@suse.com>:
> > On 1.12.19 =D0=B3. 19:27 =D1=87., Gard Vaaler wrote:
> >> Trying to recover a filesystem that was corrupted by losing writes due=
 to a failing caching device, I get the following error:
> >>> ERROR: child eb corrupted: parent bytenr=3D2529690976256 item=3D0 par=
ent level=3D2 child level=3D0
> >>=20
> >> Trying to zero the journal or reinitialising the extent tree yields th=
e same error. Is there any way to recover the filesystem? Relevant logs att=
ached.
> >=20
> > Provide more information about your storage stack.
>=20
>=20
> Nothing special: SATA disks with (now-detached) SATA SSDs.

Is it a pair of 2x (bcache-on-disk) in raid1?  Did both cache devices
fail?  Were they configured as writeback cache?  Does the drive firmware
have bugs that affect either btrfs or bcache?

If the caches are independent (no shared caches or disks), and you
had only one cache device failure, and the filesystem is btrfs raid1,
then the non-failing cache should be OK, and can be used to recover the
contents of failed device.  You'll need at least one pair of cache and
disk to be up and running.

If any of those conditions are false then it's probably toast.  btrfs
will reject a filesystem missing just one write--a filesystem missing
thousands or millions of writes due to a writeback cache failure is
going to be data soup.



> --=20
> Gard
>=20

--4N29bJelYIMOTi0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXehvVQAKCRCB+YsaVrMb
nP7nAJ4n22eyeEN86YCmi3SJDQFLP8K1wwCghxIbTOWnt+xmLEUfq88X/UdYjDk=
=vMeH
-----END PGP SIGNATURE-----

--4N29bJelYIMOTi0e--
