Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7260BE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfGETvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 15:51:44 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:48364 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGETvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 15:51:44 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hjUFD-0005Vn-1s
        for linux-btrfs@vger.kernel.org; Fri, 05 Jul 2019 19:51:43 +0000
Date:   Fri, 5 Jul 2019 19:51:42 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: delete recursivly subvolumes?
Message-ID: <20190705195142.GQ32479@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20190705193945.GB23600@tik.uni-stuttgart.de>
 <20190705194720.GC23600@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
In-Reply-To: <20190705194720.GC23600@tik.uni-stuttgart.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 09:47:20PM +0200, Ulli Horlacher wrote:
> On Fri 2019-07-05 (21:39), Ulli Horlacher wrote:
> 
> > Is there a command/script/whatever to remove subvolume which contains
> > (somewhere) other subvolumes?
> 
> ADONN QUESTION! :-)
> 
> Is there a command/script/whatever to snapshot (copy) a subvolume which
> contains (somewhere) other subvolumes?
> 
> Example:
> 
> root@xerus:/test# btrfs_subvolume_list /test/ | grep /tmp
> /test/tmp
> /test/tmp/xx/ss1
> /test/tmp/xx/ss2
> /test/tmp/xx/ss3
> 
> I want to have (with one command):
> 
> /test/tmp --> /test/tmp2
> /test/tmp/xx/ss1 --> /test/tmp2/xx/ss1
> /test/tmp/xx/ss2 --> /test/tmp2/xx/ss2
> /test/tmp/xx/ss3 --> /test/tmp2/xx/ss3

   Remember that this isn't quite so useful, because you can't make
read-only snapshots in that structure.

   Generally, I'd recommend not having nested subvols at all, but to
put every subvol independently, and mount them into the places you
want them to be. That avoids a lot of the issues of nested subvols,
such as the ones you're trying to deal with here.

   Hugo.

-- 
Hugo Mills             | "You know, the British have always been nice to mad
hugo@... carfax.org.uk | people."
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                         Laura Jesson, Brief Encounter

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJdH6pOAAoJEFheFHXiqx3kV4MP/Rly1y8XzdDUz5/45K6Qvb5P
AWUJPZ10IbAb0hujnDO7Y3Ezx+lRL3Hpey96dCTpcSwyvTGVN9eXEKXA1snsIBw1
geOUD8LZjvBCvM7o+FK0zwjqYLFEeJ+/qYCwzzOcwJNx0VbQ+y5Gjs7ayXdThJSw
rd0aGzfFKZdDNKFt81qejobZZX0CNBqXoJ9KX2YRyWprRL4DOffv3bTv7EffwPaG
RVOZKvRo2RNfZAOtgsuAo0mYe7EeeqlhQsNodXljo6XyF56dQHAKDoxe2h5eM2rx
yCwEtBn+kV6Mm/3QZTcIFP21PGTQ6k2a5IG/nHel6eKtN0dNMy8Z2R4yI/EL46XE
sMa/bsfQsviyeik44jnhYvMHe5aX6NwPwg7nSKt2iwxQ/FeaeSfXYVJuKOsvxHdZ
fFNZjtZv0lhG7WczXIp8mkyab0+d5eS5WNrVqYvyEThvJu8q0tZ8yTD93LU/xeAo
st6AP+zXXzZ38jiImBo0CqLQxXROvuvIIlJ/Gxdejok8mmwVlGkt7vN59F/MS1gm
L5eUTGjAn3tg9INNBmSpF1a0vOl+sNVFJYi/nH+QBYxOymQK8ByciFDlVr+UcxXA
56wTL7ciN+oOMYvsKhYG3g3dit+dHpnOPl6FSrsmT78BBE8rSBbv1LxvS8ZSuvbC
ZMFopUk2LBo6QEN3vCz4
=B2k8
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--
