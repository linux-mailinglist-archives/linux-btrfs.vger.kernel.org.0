Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7FA91B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfIDSXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 14:23:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39871 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388744AbfIDSCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 14:02:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id C023221EB2
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2019 14:02:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 04 Sep 2019 14:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=wXdDyKzjYAPe1U2V4gJxSUS7B0H
        KnwkZGnU668NrgJo=; b=JUEJPeTwxfAKmfuLShytjfTN8ukqpDHrjUxTgDi9U3P
        OY/ff5JRKdxdJvffQNz9QbkrJMAqoXx1PPY+zMPCEljCKUJ4ulONLjJ7ZaW4fnss
        ZlN0rfYFn4NR4G4agmatNsr44tpihdEemHvBz5oYcOaMt2C+1O6DfOWmBqWo/moX
        z8YXPdnNowh4KSblAfGTLYjBmQ/aM8zEnkUYmXFiDDVmSCCNflqhNEGgEc3Q+wVY
        Uaz1iKDMNZZB5OFhwVFj21YNYULyAJnSvZndUfI2LVxuayM3Femj293MhcDEsg2F
        p641HDZ5WsqukNvwp4r6byeEh2lDCUckB1sKyFm75tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wXdDyK
        zjYAPe1U2V4gJxSUS7B0HKnwkZGnU668NrgJo=; b=EX3cd9XW9oPDHb7+kleiON
        nUnSyUGDL11KhMUBPxwepSAmVIlMEBe5iwQ6fNk6HoH3RN6AuVv1m2HrRPnTfgTl
        k5HMwqFGwL/Lt8VPjccONel60pQZ4T0RJ9YnSr0f4ADtJ29Pj6imswBH5fzvFlTI
        H5kpa/v4kDgcrbbWDjb7sGwCaK88TIo4jvopCuVSi2JvWr0omfd/cnDvcCPk8cHR
        zzUxRe4DinmooMBlocEZLuXXmsingSFde217zHRr3kkQlPoIzdIPgNOEmCTxT1G1
        L1Xlktm2uEYEdhDLHba9UJ+CE9ou/AiKc+xrFe4C1rjjBuLULjy7myQcMA0Zskuw
        ==
X-ME-Sender: <xms:NfxvXUz7ft3Co04jtXC442PxDtg3JZW8oKLp6GdO9W9wKwRV5QviuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtd
    erofdtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NfxvXbHWa9BtazMwfGvzhU-1cce7yQTIOxLMafpNxmG4IUT307VMHA>
    <xmx:NfxvXbuoYbZkkioIuin4qo-5gkvsWjPMvobyywsQCjiorv2tU-UAuQ>
    <xmx:NfxvXQRZ4qlS22jDPEEBcEEXvzFIQFtKXgVqqXI8HSl9ZLoBMdvENg>
    <xmx:NfxvXUMRRU7xp9e1Ebg6yCvXVzjez51YnNPNsf37IU4k-jTGQrGJ_A>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B7B180063
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2019 14:02:29 -0400 (EDT)
Subject: Re: No files in snapshot
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
 <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
 <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
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
Message-ID: <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
Date:   Wed, 4 Sep 2019 14:02:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s9eRTCBljtZfC7Xc63nPhLDgLQ4py00VO"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9eRTCBljtZfC7Xc63nPhLDgLQ4py00VO
Content-Type: multipart/mixed; boundary="EQ6xur8oCZHj7tEBNX4hiqfspw9ga15gd";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
Subject: Re: No files in snapshot
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
 <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
 <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
In-Reply-To: <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>

--EQ6xur8oCZHj7tEBNX4hiqfspw9ga15gd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-04 1:36 p.m., Chris Murphy wrote:

>>
>=20
> I don't really know how snapper works.
>=20
> The way 'btrfs subvolume snapshot' works,  you must point it to a
> subvolume. It won't snapshot a regular directory and from what you
> posted above, there are no subvolumes in /var or /var/lib which means
> trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
> it's failing but snapper doesn't show the error. I'm not really sure.
>=20

In this case, his snapshots are all of the root.

I don't know how Ceph works, but since we already confirmed that there
are no subvolumes under /var, the only other explanation is that
/var/lib/ceph/osd/ceph-<n> is a submount

What is the the result of running:
mount | grep /var


--EQ6xur8oCZHj7tEBNX4hiqfspw9ga15gd--

--s9eRTCBljtZfC7Xc63nPhLDgLQ4py00VO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdb/w0AAoJEO9Tn/JHRWptUNAH/jyK8vvoSKAEByj8wLRx1AHb
iWG8zju7kYMnZhZog1E9UN3PMxdwywqC8CMPZwjq34xNjnrVzCFbbUXsgSdDxjLU
PDmtGaGJC7UtK+xq4igjv3ntJ1TtKN3bt46NGMhtt9Q/zj/dXXTYEE+4Rdo/OzQA
i3Y6Tupt6lLWYsBt7kyO3nJd9+F6tCZFX2546UeCXT093l72WMV4K3QELzlslKTe
6tciWDI/JlGRmabkTINoPaD3HTE0uufCWvYJrhS8a/t8EexBDRT3Ix995Ii/93GI
McSn2CzMYj+eoe+r7He6Ugm75hBGZlStTcU4Hqw/rrcT6IQvUH6bT2le1vd8Qvg=
=M613
-----END PGP SIGNATURE-----

--s9eRTCBljtZfC7Xc63nPhLDgLQ4py00VO--
