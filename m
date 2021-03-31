Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8B350054
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhCaM3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 08:29:18 -0400
Received: from mout.web.de ([212.227.15.3]:56593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235571AbhCaM2r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 08:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617193726;
        bh=ii4SLTt3vOwzpx1eMAJWD3vB8u3RIXCz1M10/vfe+UQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=XQ/9R5zw2eWuGasobKuuKjgJoEKjF3uJdo64fV6JGjUpezjdBxi6xRAYeEJ3M/wX6
         kgUz3c5VC3ANzbYBRkNr+qSaTC470+anGmwMub5CCfl1iAYRhnG3ALkXh7wPRZM8gL
         /tiRtjshgTfJdtMD0vVE6JIN31iazGmFZXeqn+/k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko.fritz.box ([89.247.255.31]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7ssy-1lnf4q3tXE-00vNFR; Wed, 31
 Mar 2021 14:23:36 +0200
Date:   Wed, 31 Mar 2021 14:23:27 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Thierry Testeur <thierry.testeur@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Support demand on Btrfs crashed fs.
Message-ID: <20210331142327.09af250d@gecko.fritz.box>
In-Reply-To: <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com>
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
        <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/audkGNufwi.k8LGNNjyU0Xv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:4oVcc5yEAdc1vk/DJuQucYKgdtjh9gZttyCRSIWG6jFnHK+tTJl
 4Pizk1XW5fuyr6SV4FhMHe0ke8cDrnjOnRULQmobCZec+qEiJdwOh4Rm6OfPCiByftuwVRk
 niTcjqe+L57FPYobbzmfg9XmGXwvvciJryaPIs1ayRyWfM0CzcQ1gkRbIPCjgG3DNjdDY9Q
 QgwDji9JIGT/5+CsWPcJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPw9g9RIAuw=:Uol13zUi/4Nx+jvMt4FQJe
 jImeY1d8ECS++PM30BwilLmo8KKevwrWmwrk7J79IKTziK5xIYBLHsvSOJyTXnvioRyyvvStr
 5cYP0LeGVj3v9rTsgDb2UkMKZn4XsWyZ8CnrysqWMjEGZNV8wx4vdr5NokPYRSAiFQv2WWnb9
 pHTcqpX5LTUkaRydZqWcKcorH5m38gxfTmsxCbqqaEpOxfeT3nufvwD/MrAQ8LPAi8RNt7kKK
 UfO1VQdVK4Hkh6HGfXRe+Fl5nTTmVDSCYIlQoWasgEokGgPXJIh8cvPE6PS4Op3cq43vxVWW2
 pxujupLS99XvyKMgsyANyMHfg2fomQic4ybIxCHOJJPJCm6Orm1zMEYcvDGA0ZOzm/hSJw3NT
 ertFbM5UnBsO2rx/kA0L2Kg0p6TbbmOeiC+FvhwQX1HweVebKHwmm1FOTLMxvI/WdoHtmiMl9
 KXR3fueH4icAeyOb+iLUxInHKvL6PX7OyT4IAbCzBGrssLx6XloBRk2rPz1C9fw/wRId4W1zR
 bBGi8t7xlhfTQRJAv0yXvcapHGYlWc4Qb9skY5zk9sLxF276oAzs7dn51n+fwo72+K2dNAha3
 FymlGMP9YDo3WSaM5DG8cQWZ4OvTO6HiO9mzXMxcwMNjQ08bGriVN0uLbXU0y2bWHJo+K6R3J
 g7vYTTKuI0oef0iK69kejdlbVT7THSnsLsVvDXWB3R7/CnBzYuA51WYvn+I6yQLu8W/H820rV
 edQZGi9TO3iAPUkV9/WWsH45Cc0uR5cPsJqwGUX7TCfpb+sSXnOIQy+CWF/qKPGmw5Bu+wQcn
 Q/14wq9V+e9P0NZE+DXSC/XR/xhvMgUrzKruDgw/s0Ih3QJglk+fv0KdMifD8Z/fY563xE01X
 byOUhCPNqBUsO90566aQ1SESb+yin9i8bl56ig2CVwonxWc8Bt9770mtoR+VN2nVhDX9oggzt
 MYLltx+PN616/qjEqrauysGPAWhHx8phHdakNeChhK6xw/VIPDNZpNEFxZMVB8+nd/+t5WL2S
 dXHMXoH8kZLSEnYqKMNe5qJNaqWTW3x/x1OWhDy5+YZE72ybXOqxOWyeqSm2Cb47O6Tp9lkb5
 LbyOgO7SbaIzRHKem14GhXtbtqh/HQUvY5YGm3J5NUy0ZEpwN2qnBj7U/os0EA9aM+AIS589s
 PbEKtVmg+uCcEcUhj6CmVCqYDFYOAGWOW1Hd5/CNFw1G5GtLVCh4QEyVeaa657fqirsMw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/audkGNufwi.k8LGNNjyU0Xv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Mar 2021 02:17:48 +0200
Thierry Testeur <thierry.testeur@gmail.com> wrote:

> Hello,
>=20
> if anyone can help me with the problem above?
> Have tried a Photorec (even if i know the chance are really poor), and
> have got some non-sens files, lkie pdf of 2Gb, .... most of them are
> unusable, except smal size file, like jpg pic...
>=20
> thanks for any help.
> Thierry

Weird, I would have expected photorec to recover more. Did you have compres=
sion enabled?

Regards,
Lukas Straub

--=20


--Sig_/audkGNufwi.k8LGNNjyU0Xv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmBkab8ACgkQNasLKJxd
sljt6w/9GDsq329LNLRJ/7du1M2H51K6sa5abWML9XbrxbrkMIcLiQrfKQ3FWLQG
d9EiCN4UKCI7B4xNzSsreLXWSSbtFbFyGMvah/aH7/8BDLff2ldBm9PIoOntyNxZ
UtE8RuK3XHWxXGhAFygTpx/22W7L7A2NcDAoHfhnRzIaseIk8aGsWKxKa5R2mhCj
yVLS2UVA8gXT3SrDqT6Qzv9m3mEJ9BXV63nnQHUegVcFI5Rgf8ewIyv9MqO3VFlz
2b2CSeBVLBN/u5LIWkMu5qlYUiLimbCwVPdzkN8vVZxybHBLAJ0tIgsWv8H4W5oY
wtvMRJiucwhd8rKAyHxLnZWwFu6mFOv8F2U+rEjpsfRTmS/bAK12ehzj76bG0iZu
duahBk53VhX2AuLCTqnoDt5AsiyQ1c4Q9zQty8h0YEALVqEtLVfZNcHGOR3U1FHW
ZOqc6wLZt9kgPW4INGf8XKQg0WXXJLTB5Hu7t3gL0sc/IuYx/+4JNvwAMj/vQHdV
KA1P1sJlYW+wpLwN1KD5PPZe7AFjHcKO+ccZlNVyObtfA/TY89FhGuA9bRkr9Y8i
zR5L5O8CU3cDbeXwbc8VSkgdPZ0Am0E72lFD/SqVlRQ3CCtTDmDHssz6jZ8G7jae
Xo+ofEcDAb6buA1haNe01huu7mBMndAarJagJ1TModSglz2VQOA=
=OFuh
-----END PGP SIGNATURE-----

--Sig_/audkGNufwi.k8LGNNjyU0Xv--
