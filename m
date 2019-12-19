Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B1270B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 23:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSWeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 17:34:31 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56683 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfLSWeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 17:34:31 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0BA4E77D;
        Thu, 19 Dec 2019 17:34:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 19 Dec 2019 17:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=a/4EZLnaLmJJ2kNl9VqBAFCzvIz
        YiiyqPMveFyR7p5s=; b=gxnDb6D1qr6SPCnpFX9zys69BfOghC7ux3hAFarchwO
        sV+hmaH6ugA1pY3Kr8Bl3XkH4E2ysAhDNw0/Q62EnauTUceIGZ4phRUI9rIinJip
        gD0tUsYK9CXJuYH95XadKUsYJ98S6cwvaEjVLgFtIGv4sv/OfyTHtYAkQlgamfCk
        tIAY6dzSfLCclTfimOPhbidm/P9LrXkL4T4Upw20gCjiNlrsULE7b2vzNmsJFp+l
        3MLdZnjdfEpzkN7/IynxODvQteojMJUVRP3MtNInIzdX1aW1uFhQ71EraePJJm8o
        1+aJgg3ouy5/XBLA/bRIfZqPEOz8my/1X+kUWaBYevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a/4EZL
        naLmJJ2kNl9VqBAFCzvIzYiiyqPMveFyR7p5s=; b=LwvqRoz1rpSgG3/MSKSm4v
        7XBKHt1geJENcCwoBQX8BlRqiGmnoEXi7F4zJxKCdCogdGVO7FRMnvibZoqbqqrW
        hya/pgBLN8fhUOMGfrAjxnCMVA1jZuVtM2PItNmf/MISZCBq9UkotlTQQi/r7raB
        RAYGQjBrI/0vO6iW18WcnqwYjRVBmQc/zDzh+23w0pyMsmxiDWnNEm+F51sj/Lec
        hw/vFjNOBneSMB4XgJ2fAS0KtCzJGsIXdvnKo7H5ZgFwm6iYv1CEPYDGtlrZTfR+
        jWmoLTg8HeH0P1eUuF1x8qpTrmc+0S42wkM37kAC5kyXEW2Ivk9CaGge1Pwuky3A
        ==
X-ME-Sender: <xms:9fr7XVTXpNaeBskZ0EC2WBfmk1Ys-_s4dfXEhUu2yRcwO29FQEGaQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucfkphepvd
    efrddvfeefrddutddvrdefkeenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:9fr7XUFciKHE3vhJ9-mtYAUw_lfbqdtPtAf_Can0zX8T5-obtvdJDA>
    <xmx:9fr7XW6lqxBclJ2y81_Rir6drveg9xB0NYI2vJ2PzY9PoQzXoa4QsA>
    <xmx:9fr7XZkmqxLlpPA8G2cFOtd3ctLXsIZvfm8maJAGw_dbC7UIm2p-_Q>
    <xmx:9fr7XZaO7GVTT0IOKvw0TwXWNTY43-hx4tKEqpAciKH7u1hfCiShGA>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05847306081D;
        Thu, 19 Dec 2019 17:34:28 -0500 (EST)
Subject: Re: How to heel this btrfs fi corruption?
To:     Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc:     Ralf Zerres <Ralf.Zerres@networkx.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
 <1774589.FgVfPneX5p@merkaba>
 <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <992c672c-75d9-27fd-0819-a3735a7eea89@georgianit.com>
Date:   Thu, 19 Dec 2019 17:34:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FDByK1JxJhgB1urozROAcVRV2O6ZiUi7x"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FDByK1JxJhgB1urozROAcVRV2O6ZiUi7x
Content-Type: multipart/mixed; boundary="Nm9FAkKnA60ViwDfU1BtNRoJORLfj1LhL";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Chris Murphy <lists@colorremedies.com>,
 Martin Steigerwald <martin@lichtvoll.de>
Cc: Ralf Zerres <Ralf.Zerres@networkx.de>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <992c672c-75d9-27fd-0819-a3735a7eea89@georgianit.com>
Subject: Re: How to heel this btrfs fi corruption?
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
 <1774589.FgVfPneX5p@merkaba>
 <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>
In-Reply-To: <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>

--Nm9FAkKnA60ViwDfU1BtNRoJORLfj1LhL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-12-19 4:43 p.m., Chris Murphy wrote:
> It's bogus.
>
>> #    Free (estimated):            134.13GiB      (min: 134.13GiB)


Perhaps not.

Lots of free space, but it's *all* allocated.


#    Device size:                   7.27TiB
#    Device allocated:              7.27TiB

 Metadata,DUP: Size:21.50GiB, Used:14.31GiB
#   /dev/<mydev>       43.00GiB
#
# System,DUP: Size:8.00MiB, Used:864.00KiB
#   /dev/<mydev>       16.00MiB

# Unallocated:
#   /dev/<mydev>        1.00MiB


--Nm9FAkKnA60ViwDfU1BtNRoJORLfj1LhL--

--FDByK1JxJhgB1urozROAcVRV2O6ZiUi7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJd+/r0AAoJEO9Tn/JHRWptFX8IAOMF7s2GYc1wIxZIZMytmvuf
0JlOQ46mTyPKX5vMKT3aBFGjg1x+5yu+07lGVNdoO4icF+00h9z3dLkV9nOo1hKV
ZjBOK46keaY3fkZbxqZV7NOoYuLF8Ss4Aq+eLtaqvc1GG4UQTW94qoi2Gtia0wwS
JnSg4sVrYNl/IksldzAXL4b3bsVucdvlsHwALt5cKd2NJbSd0It27vU7dDO+LegL
5TYu+fMJTTqIF9IDP8ebmFWIycIO19evo7w+T/P0v9ce7y3N4QiSf9M/vqdkhQHH
tgSFHNYbi5uBeEb2pumRuCWiPf0Hj0eDXRUZtXDXGpr8AUz/iiU2X09yJ3P8kh0=
=CLrB
-----END PGP SIGNATURE-----

--FDByK1JxJhgB1urozROAcVRV2O6ZiUi7x--
