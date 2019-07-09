Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E747C62D45
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2019 03:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGIBEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 21:04:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:34021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfGIBEN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 21:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562634250;
        bh=s13l6ffboKY3lYOK7kbgdgdbwKW8sdhhed0CPbAjZks=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WU01mwei8TO+7B89pJnGIryLBUnwj+TR4GDl1ntY4xPSX3xS92S+mj64eXMsf6zMi
         Kca9mdw+pzQnD8rHCx1FnQEuQSEngfbPYjC1gUtHpb7oLtOOzJVrTFEXdIasO7rjV7
         0TdJP3ClQYgDReYzNYWNscdbPnCLwg41JFmzVEF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LeSOH-1iIJoy2pjR-00qEOg; Tue, 09
 Jul 2019 03:04:10 +0200
Subject: Re: Btrfs Bug Report
To:     Jungyeon Yoon <jungyeon.yoon@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <d204f223-3bfb-5f12-50bc-d61d34b0f9a7@gmx.com>
Date:   Tue, 9 Jul 2019 09:04:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yFGHZnXml52F4PlBd1bcFvwSgfv78EDfV"
X-Provags-ID: V03:K1:fYilmUCF830zH+JIEpr8M326dyEm894MSXTfeszIukeWfh6Ecou
 Ryqx/MlOUmpeCES4wvUNxq5aO5D3+/IlnBGGM7Aqzx+/LmlSWq9Rbp8W/rIT2bROcmTKEVq
 kx/+yzaS4lbT51UVO5+iynT/PmXG5CCGirAJSJ8bPCJ6QLRqe/MMO/7IS7a6IexUrlL7X0p
 zG5h+zHcrlMgxni+VCr+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ba94d44LCKg=:CjbJsHwh6hh/1rGZjLSqcD
 Z954hG7VkYQywgDS7vgeoWLA3stRICpKVDHPF8GjPE9C+q4q6MmxkY6kVJeUy2vO6cTgpqMmi
 gt9WQ8R6Aohr9rAOV7v8SBfexgtb6tjxVGOZNFtOrlM8xDMcWKWYsW4tpf0RAowRsd6Bty+Zg
 o8yJBb6T9u3Bbysk+7rRi9edXT1BIDiL0G/ZONUwtdkFLe0FETpCpo/B/G2EaJoqoV98AtB8P
 4UIe0XdFtWZ2UeWqvfm1XjCkqEVSD3zOI3kxB7R1CKUH4eU3v0YJeqjN5cl81Jc34Hu+goK52
 Hv8pX0HCy4C+wirTVN0IBEevL8sAVZLmoabTQySgncY/PSynA5pgLDlTkbNS7w+n1fHJD/ebV
 xvkOdvX60+74D1529AW/LNePopCBEAOnL4MruUNZYZdWkkKinHe+7hl7wRzJYRVtl2He2/Xqp
 YeucV3JCGwyss24v+XRo/dJVmJQ3oLstGmgu3xnlY3tAInJ2VaeHoEIsQPqnbIYUBoiJcYfn6
 /LKPUlrMBt4gQjne5XNMFhgcCGtgZDRYRKXKpcGT0+gG5wXud1X3D5+koKpz8xbZbcRMe7Etn
 rZFFXfPOqEbY8uWk3GPKbzQF/PzZJPeXUiiqHio52FLTg2WHUaa1TQFoSodUZyNBDRMFQHP1q
 k/mhP9M6hD3kd1pRQ+20BfsbWkBcBqQj/7Y24elnB3/hUlPKnp3zSvn76joGwRJ5PNTKUwwyh
 S6aMkpzIWb3jI4yBmrOZNDZNM+jeCT3dg/0TxCtxexUYXVEUyZUimCq2Lc/kbsWuA6oTkq7u0
 RQBwgwvxpFsmqG0Tn1ipJMyz4wMT37dyQTuXVxdzU6L/yVvUEaIyqvt5urh8m184JFx8sltMS
 OrFosMr2HdCz/NGeU6AEFoSfEhrNZjimFJ+e2V3k46+C1gw8CMqKowfQ01sRjk+NWOFQzFAXE
 CkKAsUVyIsF4/Q/i/CC3r/JlBmZLgOloJxG00GE7Xmw46auzSvWgdguqsZz19drCniyM0v4Ol
 S8iiFxqCc433z9egdz4GH739zCq8JeRIPLS8URRC6IJ3N/ZCc8Fo/O52AtFW68yDdWVmMF1rM
 S7q/PyC2s1wVFI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yFGHZnXml52F4PlBd1bcFvwSgfv78EDfV
Content-Type: multipart/mixed; boundary="BS1Tw9YP1KojbXElKk4XlJbL6GeZHTSJH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jungyeon Yoon <jungyeon.yoon@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <d204f223-3bfb-5f12-50bc-d61d34b0f9a7@gmx.com>
Subject: Re: Btrfs Bug Report
References: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
In-Reply-To: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>

--BS1Tw9YP1KojbXElKk4XlJbL6GeZHTSJH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/9 =E4=B8=8A=E5=8D=888:49, Jungyeon Yoon wrote:
> Hi btrfs developers,
>=20
> I'm Jungyeon Yoon. I have reported btrfs bug before.
> Some of them have marked to fixed thanks to your efforts.
> Additionally following bugs seems also fixed as I've checked.
> If okay, I would like to close following bugs, too.

Thanks for your previous report, feel free to close them.

>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202839
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202751
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202753
>=20
>=20
> In addition to those bugs,
> I would like for following 16 reports to be checked.
> Most of following 9 cases end up reporting kernel panic or kernel BUG m=
essages.

Great, we have some new work to do!

>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202817
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202819
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202821
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202823
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202825
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202827
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202829
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202831
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202833
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202837
>=20
>=20
> Following 7 cases run into assertion with btrfs check integrity options=
 on.

Oh, check integrity needs more love.

I'll try to address them all soon.

Thanks,
Qu

> https://bugzilla.kernel.org/show_bug.cgi?id=3D203279
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203253
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203255
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203257
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203259
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203261
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203251
>=20
>=20
> Thank you,
> Jungyeon
>=20


--BS1Tw9YP1KojbXElKk4XlJbL6GeZHTSJH--

--yFGHZnXml52F4PlBd1bcFvwSgfv78EDfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0j6AUACgkQwj2R86El
/qjmzAgAsHYkWkhXKe96K03K3ele0HuadoppkEscRVOiolitxzRXUELdL3XnQXLm
UurufKkcHZgMilQX5Ti8J3GE+lTTx/QnyvVKpks1qdeQpvr9T6nmF68eHChjKn5s
Dq2wAd/L9Sqr8pGFqBpxZB2Ggz+e3zC+jNgzmAIHUDfxSoEipqAdLIku2uJJnUQM
dPgeBNOWqubfDXs5dmR3lA2B7RDuUVt+e+A8GVCUHM7c4LB/3eUH5YmN7+M8rLJ5
ETSREZxsxhC9DCBt/u0BWxBZwEK++aqWtwXMmX6naiINOlpYQepLJQCoqQV8GRrr
CZtuBue4ZlNeDe6wkUk2i9W5BIfttg==
=EnVo
-----END PGP SIGNATURE-----

--yFGHZnXml52F4PlBd1bcFvwSgfv78EDfV--
