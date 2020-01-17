Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4E140E6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQP7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:59:50 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35382 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQP7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:59:50 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E7C4957A873; Fri, 17 Jan 2020 10:59:48 -0500 (EST)
Date:   Fri, 17 Jan 2020 10:59:48 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>, linux-btrfs@vger.kernel.org
Subject: Re: Scrub resume regression
Message-ID: <20200117155948.GM13306@hungrycats.org>
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <20200115125134.GN3929@twin.jikos.cz>
 <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
 <20200116140227.GV3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t5NgoZwlhlUmGr82"
Content-Disposition: inline
In-Reply-To: <20200116140227.GV3929@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--t5NgoZwlhlUmGr82
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 03:02:27PM +0100, David Sterba wrote:
> On Wed, Jan 15, 2020 at 02:10:42PM +0100, Holger Hoffst=E4tte wrote:
> > On 1/15/20 1:51 PM, David Sterba wrote:
> > >> It is important that scrub always returns the stats, even when it
> > >> returns an error. This is critical for cancel, as that is how
> > >> cancel/resume works, but it should also apply in case of other error=
s so
> > >> that the user can see how much of the scrub was done before the fata=
l error.
> > >=20
> > > That's something we need to document in code and perhaps in the manual
> > > pages too.
> >=20
> > Isn't the real problem that cancel does not actually mean cancel,
> > but rather also implies "..and maybe continue"? IMHO cancel should canc=
el
> > (and say how much work was performed), while the intention to resume sh=
ould
> > be called e.g. "pause". This makes the behaviour clear and prevents
> > accidental semantic overlap.
>=20
> We can add 'pause', but for backward compatibility, cancel has to stay
> as is. I personally think that saving the last position after cancel is
> not a big deal. With 'pause' it will be less confusing for users and
> will have also parity with balance commands.
>=20
> start - pause - resume
> start - cancel
>=20
> One difference is that cancelling balance will also delete the state
> (stored inside the filesystem metadata). If scrub start follows cancel,
> the state is reset at the beginning. I'm not sure if adding an extra
> option eg. 'scrub cancel --reset' is worth.

Currently 'scrub cancel' doesn't reset the state, so existing scripts will
be broken if 'cancel' is not exactly the same as 'pause'.  I have such
scripts, they call 'cancel' and 'resume' blindly according to load or
maintenance window boundaries, and they leave it to btrfs userspace to
sort out whether any new work should be done.

--t5NgoZwlhlUmGr82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXiHZ8gAKCRCB+YsaVrMb
nIncAJ4qxp/aPezQV9n9BsD0gP5btzwm/gCgxtuywDI7jTXIZl6vHH66eMcsel4=
=+RrN
-----END PGP SIGNATURE-----

--t5NgoZwlhlUmGr82--
