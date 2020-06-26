Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C074320BA1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 22:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFZUSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 16:18:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37429 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgFZUSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 16:18:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1D71A3B2;
        Fri, 26 Jun 2020 16:18:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jun 2020 16:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=+TYSeLDp5eWj8EjGfc6burD37+2
        9YOuXRtQG2oN+18k=; b=qIjlTjZyjOPC1n3KeBH0LRhNFfTF0kqCf1xG5TOp6B0
        j1ALQbDqXx7n6nP6sqK3H5ckcYNp1HAZOw5UwwOjgsN1Yh0DZ+y3dTNbI7y+B7QF
        riWl875zx4TmGMUrYktZ56iJHgoNQHtOYHH1AvPwRVR9PNDJepYpbNH5NR+l6wVa
        7y6Wk7IVYVAiHzoE4MyFex66w+0KJ7GMRUqYw8NWZuD/CSpZ6qaawokuui1sMGth
        TeLCBteruCrU0YgAmmw9IbGJvBeWFcF90EwxKoBeqxHSZ/OZZ1K8PrKnhhJxpuMq
        oVedSPSbWT4dVhV4+jB2+s46HZ82VSnsVPaUeu6SQ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+TYSeL
        Dp5eWj8EjGfc6burD37+29YOuXRtQG2oN+18k=; b=OH/FG31pJMbPa/480qn0Tn
        Se/2YfL41gxL2omh/joGptpAe95FU96xWGnzXnofoF5+t8H9NR+JN8NTFIBLPwoy
        u4gnQC9LEjfqRfpw7ZT+P5G0W5C/iP2pPhLb9JGe0hsTV3vHFr3igRI2DaQ+V6Nq
        1Vn2c/W5LJZH90TKmX/boGYfHqAGyGP2+lV3s9lC/lI0ENSWgVzfrwPHINtiA26g
        VBqg3h/C3wVT6vjPBImBh3poTxpACAkrsVJW6Bs6KPZZPpOlBQ2mcXCvQz8RT6Ss
        vhRjqTzsU02EFmuBlrFcTSmzQ6iDA8qd0TziPZpo55OszS/ff2IxFzd1fE+BL5Vg
        ==
X-ME-Sender: <xms:_Ff2XgyQ5JzlTXf3RAiSE8wG9ETU9QTRvfNXJd7kfT2FiTlRrlaT7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeluddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtd
    erofdtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepveeljeeuieevueefieejhffgud
    efleevfeetjedtgeehueefvdejveffgeeuvedunecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucfkphepudelvddrtddrvdefledrudeftdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgt
    ohhm
X-ME-Proxy: <xmx:_Ff2XkQ5wqHq28JVpP0oc43CGAiuxjqSDqwIDnAmp5rSvtx-qOACXA>
    <xmx:_Ff2XiXSNRnCgWUD-RPuJ8oT7NyJ1BNTwEN_khQ_URTK_UU8lK9e9Q>
    <xmx:_Ff2Xugjtyv_gmk8blU3nOIFBRwZ_BWQqBsgchVEgSq4XLh4jGgoDg>
    <xmx:_Ff2XlNw-gALi4MYvLC52UtD9Hc6t6jMDFEJ-mrxSKLRG7MO38EDng>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DDA1328005E;
        Fri, 26 Jun 2020 16:18:04 -0400 (EDT)
Subject: Re: weekly fstrim (still) necessary?
To:     Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
 <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de>
 <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
 <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
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
Message-ID: <5bf091c5-b769-b865-c1ab-4437565961d3@georgianit.com>
Date:   Fri, 26 Jun 2020 16:18:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UttrQnQgmRsV4SjzHwEWmY8sHTANU6ukE"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UttrQnQgmRsV4SjzHwEWmY8sHTANU6ukE
Content-Type: multipart/mixed; boundary="31llDVJubbZvziBfymNm7CfKpMBpNymRe";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <5bf091c5-b769-b865-c1ab-4437565961d3@georgianit.com>
Subject: Re: weekly fstrim (still) necessary?
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
 <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de>
 <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
 <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
In-Reply-To: <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>

--31llDVJubbZvziBfymNm7CfKpMBpNymRe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-06-26 11:40 a.m., Chris Mason wrote:

>=20
> We=E2=80=99re using this on a pretty wide variety of hardware, so I=E2=80=
=99m surprised
> to hear this.=C2=A0 Are you able to reproduce the problem?=C2=A0 Is a p=
eriodic
> fstrim still happening?
>=20
> -chris
>=20


I'm probably just confusing the terminology... But could this be related
to the queued trim problems with Samsung for which they should be
blakclisted?


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/ata/libata-core.c?id=3D9a9324d3969678d44b330e1230ad2c8ae67acf81


--31llDVJubbZvziBfymNm7CfKpMBpNymRe--

--UttrQnQgmRsV4SjzHwEWmY8sHTANU6ukE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJe9lf7AAoJEO9Tn/JHRWpt3/8H/jdXcFWQTRYTgTXSy+1yk1yo
SD9G+kfjTXUD64F+2Tkua/Yxsf66+JoBU4HjdiFvG43iT9SJ0YAnrR7neWI9etjU
rSQMt+8+NplaiF5Fftu0p06xTzyVejPoaBCIhQ8XpNWnAziJzaSRIqer9FGpMpO2
Onr5wz34njy07TBaIhOSCUGm9WUkR7dnnEf+JyoIYXTb02a7QhuBv2nA1wjJVbkR
T9JXgliZ9pKV8WWKyeOhugu2KwXm8XIrs3kz/hhTqlZNgyxBOclgmrJDNdb+kp7y
jC2UkmSCn6ZTQ9O658N7Org04sWodavGasRM449bPyOxuLHCXm83YHFRZ7WKdCo=
=VZBz
-----END PGP SIGNATURE-----

--UttrQnQgmRsV4SjzHwEWmY8sHTANU6ukE--
