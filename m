Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023A467497
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379795AbhLCKRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 05:17:50 -0500
Received: from vs2.lukas-pirl.de ([5.45.100.90]:55264 "EHLO pim.lukas-pirl.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351071AbhLCKRt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 05:17:49 -0500
Received: from pygmy.fritz.box (dslb-088-068-184-120.088.068.pools.vodafone-ip.de [88.68.184.120])
        by pim.lukas-pirl.de (Postfix) with ESMTPSA id E4E9CA0F042F;
        Fri,  3 Dec 2021 11:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lukas-pirl.de;
        s=201701; t=1638526464;
        bh=ImQ3avB0uUwnPmlvz3D83eDRpyCGQO//bIVQNH3L+hQ=;
        h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Date:
         MIME-Version:From;
        b=oi9+TOHB3mGNCYzPkXx2RwUc4IIHbCLrqZgCYeIzky5ijRJRI4wbtqQFMVuhRmSuP
         0ismfiX6lZiZbMJz52IfRqjo562nLogePMsSyU68f9f82yC0nkUuU5rf8jznKF2yHD
         Hzxh8BaSuVrGB3QwDii7UjwMJxdE68mFqwWJflGEyxNaLDJcmiuZTnCirvs01hf6s7
         r4Fa8swn3K+/XF2Q6dNGx6yOr8pQQqETTgGLIJvXobqTCiELGNFjbFtqvq7OPX/5Dh
         yEkzHTKJ3AYXad6iOEiAPt7CdeG1iieZa+gK2NwlegM1sbIQgnnmBBUrCC2Zbh//lN
         X83X090Az6wLOu/5+pAryprjBeBs3swGixUpyi1U2IM56Btvx6SNMpjpOBc6L4PJLQ
         1RwcJGb4Rn3BTWj1eaoLLuuvZJ4dimkWBDNuMbpwUga0ees2t81ZNzwwULB68fbUJI
         GmB1GySDELaeX2TmAX9OS3Y6T0GF49QrqWmc8g5Mdzqq1d3qwH/ImR7HMaxumqS+r/
         u86DIMWIfPo43mDeIgagPDwz7gaNJLbDohy1RnnSl43rK/29SmnbUrN9cQHuhP1wjy
         gaQaB5nngpA+xFLmA8CtoIJKNVYjWoeVz2F5fU4cdmNaORbAPi1XSvOOZGyt7ISw0/
         3qV7XpZzYA1Gp7ieLBn8Oa9Y=
Message-ID: <05a7bb92ca85dc19637a2b306b6b17da3663e2fc.camel@lukas-pirl.de>
Subject: Re: Balance loop on "device delete missing"? (RAID 1, Linux 5.15,
 "found 1 extents, stage: update data pointers")
From:   Lukas Pirl <btrfs@lukas-pirl.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
In-Reply-To: <20211202181152.GK17148@hungrycats.org>
References: <5a73c349971ff005640af3854667f492e0697724.camel@lukas-pirl.de>
         <f5766e3cb0e2b7bcf3ef45cb7b9a7f3ef96b07ce.camel@lukas-pirl.de>
         <20211202181152.GK17148@hungrycats.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-c/FoyyVJbUL7ScbC+rPl"
Date:   Fri, 03 Dec 2021 11:14:21 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.42.1-1 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--=-c/FoyyVJbUL7ScbC+rPl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking care, Zygo.

On Thu, 2021-12-02 13:11 -0500, Zygo Blaxell wrote as excerpted:
> Does it always happen on the same block group?=C2=A0 If so, that points t=
o
> something lurking in your metadata.=C2=A0 If a reboot fixes it for one bl=
ock
> group and then it gets stuck on some other block group, it points to
> an issue in kernel memory state.

Good point, I'll check. I can also do a memory test but the machine runs we=
ll
otherwise.

> What do you get from 'btrfs check --readonly'?

Interestingly, the machine disappeared from the network shortly after I iss=
ued
the command. :) I'll drive to the machine today or tomorrow, see what is go=
ing
on and report back.

> > > (The particular fs has been created 2016, I am otherwise happy with
> > > btrfs and advocating; BTW I have backups and are ready to use them)
> > >=20
> > > Another question I was asking myself: can btrfs be forced to forget
> > > about a device (as in "delete from meta data) to then just run a
> > > regular balance?
>=20
> It can, but the way you do that is "mount in degraded mode (to force
> forget the device), then run btrfs device delete," and you're getting
> stuck on the "btrfs device delete" step.
>=20
> "btrfs device delete" is itself "resize device to zero, then run balance"
> and it's the balance step you're stuck on.

Yes, but btrfs still knows about the drive. But if it's really the balance
that hangs, it probably wouldn't make much sense to just "delete the device
from the metadata" if one would have to balance afterwards anyway.

Cheers

Lukas


--=-c/FoyyVJbUL7ScbC+rPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIfDl2cvwrHf6TgsUf2MCUJXpoBgFAmGp7fwACgkQf2MCUJXp
oBgGEQ//Z1ERxlTvi91a63LsRdJZwBfZiNbzo1+qvLJIhUFG27lnN0k7xxiD/Sgr
EnkfEbzREfBec7ZRflMK5yta8QD23mLUe2gACesiV4N0GGfK819rpG6nQgJBEp6O
vXMz7kMHnPvCrG8p1ahl4uaTlR6HZcasiK2q5grawP+pS2WnMz089BK4LXFY1w1G
qFL5F3rP7B8RKuLLPyzVZQUZ3vV8tYLXAL0RBU0WQ2tKSianG3oguxmeYZNBoyy0
d0rWCTNHSraZN/Ma3DI9If31KANzUyEttn3Z73T8NyfKKI0JU9JjX9PVuFDqRc/w
NxKHqUKnnH3zpmqBGp2ql2/K/gfPeuDYmZv837Cer7cPW8UZPLE8QrwC8f7oq4+F
/85e3pIf/ZyvytvZ2dPRIlcU4pKYK3Ij6z5eBImBNhdptkzw7zKgnOZ73noEQBfT
O6OC8w+fQ2TEsxKPyvdLYcCf9rI/cgCUn4cgOypeM84YaK07hr3QuR7V0nvYknf7
JTL1IpWN0+RAtG5L6oY+0cNf76pbi38Ogcu/4CDNM8KN9ixlCIII+1BD12rjsIsS
n4WRPhtqyEgiscO7K316mRT/caTHvo4qXPWnXsMj+4nBvahdp0G26sO2pJevADh/
CAGArk36PFTaXXcJrkTYBvDROGn+W3fGszy0LMy1zZN+8JeQOWQ=
=/iWG
-----END PGP SIGNATURE-----

--=-c/FoyyVJbUL7ScbC+rPl--
