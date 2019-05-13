Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B965E1BE51
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfEMUD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 16:03:59 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:48772 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMUD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 16:03:59 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hQHAu-0005Ws-U7; Mon, 13 May 2019 20:03:52 +0000
Date:   Mon, 13 May 2019 20:03:52 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, Timofey Titovets <timofey.titovets@synesis.ru>,
        linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
Subject: Re: [PATCH V9] Btrfs: enhance raid1/10 balance heuristic
Message-ID: <20190513200352.GE13348@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        waxhead <waxhead@dirtcellar.net>, dsterba@suse.cz,
        Timofey Titovets <timofey.titovets@synesis.ru>,
        linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
References: <20190506143740.26614-1-timofey.titovets@synesis.ru>
 <20190513185250.GJ3138@twin.jikos.cz>
 <574d214e-0c9c-0f93-1078-d07d183554dd@dirtcellar.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pTYhUwqpXRR/mkN7"
Content-Disposition: inline
In-Reply-To: <574d214e-0c9c-0f93-1078-d07d183554dd@dirtcellar.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--pTYhUwqpXRR/mkN7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 09:57:43PM +0200, waxhead wrote:
> David Sterba wrote:
> >On Mon, May 06, 2019 at 05:37:40PM +0300, Timofey Titovets wrote:
> >>From: Timofey Titovets <nefelim4ag@gmail.com>
> >>
> >>Currently btrfs raid1/10 b=D0=B0lance requests to mirrors,
> >>based on pid % num of mirrors.
> >>
> >
> >Regarding the patches to select mirror policy, that Anand sent, I think
> >we first should provide a sane default policy that addresses most
> >commong workloads before we offer an interface for users that see the
> >need to fiddle with it.
> >
> As just a regular btrfs user I would just like to add that I earlier
> made a comment where I think that btrfs should have the ability to
> assign certain DevID's to groups (storage device groups).
>=20
> From there I think it would be a good idea to "assign" subvolumes to
> either one (or more) group(s) so that btrfs would prefer (if free
> space permits) to store data from that subvolume on a certain group
> of storage devices.
>=20
> If you could also set a weight value for read and write separately
> for a group then you are from a humble users point of view good to
> go and any PID% optimization (and management) while very interesting
> sounds less important.
>=20
> As BTRFS scales to more than 32 devices (I think there is a limit
> for 30 or 32????) device groups should really be in there from a
> management point of view and mount options for readmirror policy
> does not sound good the way I understand it as this would affect the
> fileystem globally.
>=20
> Groups could also allow for useful features like making sure
> metadata stays on fast devices, migrating hot data to faster groups
> automatically on read, and when (if?) subvolumes support different
> storage profiles "Raid1/10/5/6" it sounds like an even better idea
> to assign such subvolumes to faster/slower groups depending on the
> storage profile.
>=20
> Anyway... I just felt like airing some ideas since the readmirror
> topic has come up a few times on the mailing list recently.

   I did write up a slightly more concrete proposal on how to do this
algorithmically (plus quite a lot more) some years ago. I even started
implementing it, but I ran into problems of available time and
available kernel mad skillz, neither of which I had enough of.

https://www.spinics.net/lists/linux-btrfs/msg33916.html

   Hugo.

--=20
Hugo Mills             | Questions are a burden, and answers a prison for
hugo@... carfax.org.uk | oneself
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                          The Priso=
ner

--pTYhUwqpXRR/mkN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc2c2oAAoJEFheFHXiqx3kWGgP/1r87vxRhNRwdZE5iOEzO9Ra
GG7uykL/QlxkTpGmklE4wbCwNO0yp7CPfZWPjx7olJ/uyMYMkDTGUBBpG/rvEU9T
Pz+GKoY1krzA1BaCp3wREUxcn8nT/rGDN58NiB6Hsovwf2tT0UIz7ejDUaivyT37
bhicpNg0jnELpamfWZWsWqdb+xI9xtQ0Ev5jQ3hBAB8h2XLVVPEigd/PBVkTKnJp
IZG21BOvCaozehuURkkCtbRhx3ufEs52CifmV5ggQUSbj++wXMAUS2Ou+DjbPmJl
i3LwZL1vraTAUbP+D/bfJ6qD5SI91dzcgrn5o5DLiQXZHQWD37HR2omu/XcduE4C
ONo382nCwUJmbo4vPB4bSx3kfX9MTrgN5qP+deaOTcjTvStPyjGjzI1vsFPDAI5V
tfI8q5qExNyCnvqfaIcmXjv9Ms9jNzKOTj9uFUC/sJmhftqMuagEuHPPpywqK/MQ
+OMtUOysy/NBw1KtqhkFmwjvUyXEiezPsbxF+PDZs11qu2dIfy3XSU+GkfndDx/f
S3Zmidi29ImCbc7p2fMn09vfw+cnZ+bEqZZZFak6oivUkMO4ocSR3dm8wUTErEEX
7jyJymsPFUa2QulEhNUOrOAnuaxcp3DK6TvMuUWJ0HNfoqtnmWyTp5EZ3HbWIPAv
ZTDDRcFat0QNKJBuqXQ6
=+QKw
-----END PGP SIGNATURE-----

--pTYhUwqpXRR/mkN7--
