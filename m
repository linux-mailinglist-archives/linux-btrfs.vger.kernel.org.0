Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75F3B072A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfILDdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:33:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40041 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfILDdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:33:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id C8F412256F;
        Wed, 11 Sep 2019 23:33:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 11 Sep 2019 23:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:from:to:references:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=Jna6nt5jcB+T1dx5qv0FI5o4h4E
        eSZFDZJMeWI7KRxY=; b=YZt7/uPxNI0pBXH0qB5iUvADUNIzdAWDtR4Ba4ioMKG
        YqrG5Vhep4RnHLZSEksxwKZbTZblA/eGYP50NJgYnuhgvLJUWysJ70Rp0YnfKNop
        HZhmupcrce67972laMYV90L1UsCjc6nRvM52CWH4IbYBkSy1G3Kn4JhRcwYGit9F
        nfzJ9njOOaevWjuQeXO89dlo4CpgAjrqkipva5kA3leVGnK6CBVLX5NAyLida3R/
        kMNjdgfcbLJFWRyYr0c8ILi9HdXYiAHqKu7X0Iu5lhRdiJ88MrurIx7mqgKP2uwn
        LmlcAw8zipnkGxQFxFHpkrnK0Opu3SxO3D6HFpLe2MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Jna6nt
        5jcB+T1dx5qv0FI5o4h4EeSZFDZJMeWI7KRxY=; b=v/Lb1s0isox83k33H9EtEy
        wb70DUimHpro5Ktp+uPmI/1QDdKSXPhJKD2brsVxDwb5dr9MUGQvLIJ0a50hxOvD
        GF4gkomA1QYiZF8XGCDfeEtMcPgndZTzQ3yPT2sOydRaAk1TEXMhT6Bt53i9MSwd
        ERNyJlm8UJ4TaX3SlFfOPidI7vaqcfa/l5Rw5t7Qp2AIlN+n5emt0pbElrwgbfRL
        47Ymh4my9ILNsK+XZvL6LxllS+ONhXZ9XEZuUXbq2YC2UR60uEb1I8TXz2TozIfx
        W+2si3mkV7ipvOAiTaCXmf5zeYlVHsRqRzRuDTX9/4mWrId+y868ltSAsG4B3csQ
        ==
X-ME-Sender: <xms:lrx5XYWADCm4R3XN6i4h2rYJasTK88A8OjOuIa3H1gdNwaPsYJefLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffhvfhfkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:lrx5XbWbSdoqemI4Ygf4aZbC9E9w3kjQvpITP__nxDUNSfVkK2lURw>
    <xmx:lrx5XQ_hl-pMSWKiZNEQ9k6IPsACxcVckHsYjclz8C2s8pZcixnW8Q>
    <xmx:lrx5XTZClKcn8RnWEpI1muk5Zu8XLT3kDmujVox1cMMNkJSIIQB6WQ>
    <xmx:lrx5XVOAFJkxwfq6qTrh6wEStx5u6WRbX1x2iT0w6y70lMKk367dIA>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FF378005A;
        Wed, 11 Sep 2019 23:33:42 -0400 (EDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
From:   Remi Gauvin <remi@georgianit.com>
To:     webmaster@zedlx.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
 <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
 <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>
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
Message-ID: <feaba7d1-b239-e1b7-b08a-22e1241867e2@georgianit.com>
Date:   Wed, 11 Sep 2019 23:33:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L7G8PDrmlw1OBepcTfihwb3gEJSoaMAYq"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L7G8PDrmlw1OBepcTfihwb3gEJSoaMAYq
Content-Type: multipart/mixed; boundary="ccBYpWLw4571r83e7DA1M2b5uJh98i5Pr";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: webmaster@zedlx.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <feaba7d1-b239-e1b7-b08a-22e1241867e2@georgianit.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
 <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
 <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>
In-Reply-To: <c6ec609a-bde8-2a58-ae9a-f845b7a2da43@georgianit.com>

--ccBYpWLw4571r83e7DA1M2b5uJh98i5Pr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-11 11:30 p.m., Remi Gauvin wrote:

>=20
> This statement makes me wonder if you really belong on a Linux
> Development list.
>=20
>=20

This is why I should avoid getting into debates,, ha.. ext4 does now
have defrag.. sorry :)



--ccBYpWLw4571r83e7DA1M2b5uJh98i5Pr--

--L7G8PDrmlw1OBepcTfihwb3gEJSoaMAYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdebyVAAoJEO9Tn/JHRWptrzwH/jule/Tf61u9Daw0q7ezfO9H
0dbL7n3Sd2VGtyR1h7Y8n1HrXFMf7vWWrOXGT2Xqy5OAnHTu3cdV1FMnCcSNik1H
Pi7yHk+lPhn+QgyYdTPX6FwfvOdblixIWyThxzbIutpv5hjVmKjMy5iTs8wtf2vp
56/0vudZCpzXqnKEjZXmB2LzkaqLaczgVSDh84F/wc97tGnYW92DnPVwri1yFwUN
2w0oiR5r7oSEMOgoo4E6juSvZX/WJD38OhVuvaw4fSYs/FkMb7az2ukVYZXc0w1V
DWztHpuWjYYmFvPlGzgH9eWno42835Mo5FUEuucpQij6aRvsqFgtsWdhTf4cjf4=
=jLfu
-----END PGP SIGNATURE-----

--L7G8PDrmlw1OBepcTfihwb3gEJSoaMAYq--
