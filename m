Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F67B29F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 06:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfINE7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Sep 2019 00:59:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48306 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbfINE7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 00:59:44 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 05350425A8C; Sat, 14 Sep 2019 00:59:43 -0400 (EDT)
Date:   Sat, 14 Sep 2019 00:59:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix balance convert to single on 32-bit host CPUs
Message-ID: <20190914045943.GO22121@hungrycats.org>
References: <20190912235507.3DE794232AF@james.kirk.hungrycats.org>
 <20190913161408.fs3i4apgrcmajmev@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20190913161408.fs3i4apgrcmajmev@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 09:14:08AM -0700, Josef Bacik wrote:
> On Thu, Sep 12, 2019 at 07:55:01PM -0400, Zygo Blaxell wrote:
> > Currently, the command:
> >=20
> > 	btrfs balance start -dconvert=3Dsingle,soft .
> >=20
> > on a Raspberry Pi produces the following kernel message:
> >=20
> > 	BTRFS error (device mmcblk0p2): balance: invalid convert data profile =
single
> >=20
> > This fails because we use is_power_of_2(unsigned long) to validate
> > the new data profile, the constant for 'single' profile uses bit 48,
> > and there are only 32 bits in a long on ARM.
> >=20
> > Fix by open-coding the check using u64 variables.
> >=20
> > Tested by completing the original balance command on several Raspberry
> > Pis.
> >=20
> > Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>=20
> Honestly I'd rather we fixed is_power_of_2 to work on 32bit, that way any=
 other
> users don't get bitten by the same problem.  Thanks,

is_power_of_2 doesn't live in the btrfs tree.  I considered modifying it,
but worried about side-effects elsewhere (i.e. breaking some other 32-bit
device I've never heard of).

What do you think about using the IS_ALIGNED macro?

> Josef

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXXxzvwAKCRCB+YsaVrMb
nLz0AKDB/h8A1fmq/WEtVmjgFp6+xD8MjwCgyiq08jF5rAXvPfqzjnFxG3Ag7NU=
=rICQ
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
