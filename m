Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD51FC1DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFPWtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 18:49:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:52003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPWtx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 18:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592347790;
        bh=hrT8jVkqWyj1jUUqo3uQjQ3/dnND/oU4h81N0t5dLr4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Hg8j84fvWMgDBAAMSzLSPScS2PrcAGZKqq2MGMyoGJMgkYYW4arhypGhrJEPsoX34
         5nRgu+llkW6PYzTty8VAgONtjrBonEsJiGqtrUhH8oZhlzqXCGGaVlm7VMIcFtvvOj
         U7iyoU72f9d0gt4IxjOAnGZ+Z6eoclev+5ytOmH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUYu-1j6o3l1zqu-00pwYI; Wed, 17
 Jun 2020 00:49:50 +0200
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
Date:   Wed, 17 Jun 2020 06:49:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xXZHvlMS5mOvkY4CpApkaJOrlAm3Hx2e5"
X-Provags-ID: V03:K1:LegE/8atrvpePyVhXS+OkMidTUs9XAnXlUHbVBbVV4DTFtPs8hs
 Va/A3+ne6Z3mGIgbHFXkzXsixAQhp4xUG5C49Zpyd90Ao/scschzpfacHtkGs1y0pt3v3Dm
 7WgnlSX5WfcWthxriL81xb/blTW/UHGohIN5tAyCrOrcNxSwJzQLJ+tDUVegu2+/VEjDSJt
 pBO+qeVBgv4Kgxcrrf/AQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:slQXYS7y93k=:OkPYF7uWm9liVG8lrqNI9j
 WhBYbw5iNVS1TxupV47B560mq/y40cDUWcN3/ezF68frUrps7EpbAw9Kb8CLFQOSTAV2tKRuh
 zvlyHPcWFgRmDGsOkKksqORXhf3dPqZ2OPcN3E2V39jyJAILPL8tn8gaH/iZJDGUMehv1NLrM
 79WGESPKel/VpEX7VfQVSBJB1hItihPmOzcvUn5RObo8fT9+hhhDlcfDUv1IjJgyut/SIMAim
 MI1zDeeN/siXO2eEKeBF5GoIdFUwlb8BJwgLqxAcAIYvDzthVgU5x1E2RXTr8uO3LLgUf9OiM
 KrfoRxHz2tTgMJgTVFCb3iGEN+FRAcfYIgQmv0royf8nh8f6vyQmhlwF3sdKFsxCQZENhsp0C
 z9KaJfI69Lk+MjUb+wJCaSdlZyUeGRZF/e3+e+CeXuvNREV9KY4aO9EgQBjT5+u3ndjGpspNA
 OA7VKxX90hPXOQr5Ps5YWju+GXP8KtiL4gR+U5HOTc4QVp4xYq0b0aCS4LqQ9Pfh2gMT+or2J
 NsbdGDiyQ5pzFAeh3C3QltVu7sEHI7o95T1GtdhV/vy2g0q9qHGfxwI++/IHXWvzo5Hjgf9KA
 rAld5sQoMWmo4fIhgMicsJK6GzJVNrlr8tQdd3HqrlMZolyGFpn9QWY0z6F9Mw+PMUICYmCIS
 XIu2hylacLog74SGmUXDDr/cdMEA+ABgKAXOAio1cyfkvwv33AKwH+MHMczHczj+gq6RZRYZH
 cbTNmuTaje5UeYriQCfmAmSIoAPdJg7BvCTU/Dnz6zpSJHag9WF34qjSfhkzbJl7fB9S5Doe1
 5pk8cqjAzfvlpCfrKNFtaFqvdiC28gU8Xu12MK/gS1KXVnTDmzrhETQtDmnVIUzv49Jn30AAK
 cZfrmkieMO0o5pyo85/irtw19MEu62hf9E8GzTJAjZwG8D36OHZeyFR8yERPdbLs1eyVeiWum
 ZIWHgSi28zab8ifj59BXlMQMsJK60+ppeIUl5atjfPof/hdj0g+fo5PMVbmZq/voYfGVv0AUo
 apdwkfAJ7QxjyeWC1gBZkJwqUFI03dBGy3MLwFkarxH+XsPGOwHdmhS1hwoqCYdS5rn4O3LC8
 oCW3SIKDTN5iDIaqOP23hCg9ppJsb2PSfvqi62Ga9i4cpZFTC/3vGo9jCqfphjq3xqLwOmr43
 vX4ugrXIp7bPfFGrXjrvVyHlnnoFN6W61tfgtHYhsZ9+EoQJpPF/CQdhuf4jaRT9yV4ez3IEx
 7fdqE8SMKeoan8m32
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXZHvlMS5mOvkY4CpApkaJOrlAm3Hx2e5
Content-Type: multipart/mixed; boundary="nBe4gHXLzjlu8jkTAQiYiX3mfRghuZ44G"

--nBe4gHXLzjlu8jkTAQiYiX3mfRghuZ44G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/17 =E4=B8=8A=E5=8D=883:25, Josef Bacik wrote:
> On 6/15/20 10:17 PM, Qu Wenruo wrote:
>> btrfs_root::anon_dev is an indicator for different subvolume namespace=
s.
>> Thus it should always be initialized to an anonymous block device.
>>
>> Add a safe net to catch such uninitialized values.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Can we handle stat->dev not having a device set?=C2=A0 Or will this blo=
w up
> in other ways?=C2=A0 Thanks,

We can handle it without any problem, just users get confused.

As a common practice, we use different bdev as a namespace for different
subvolumes.
Without a valid bdev, some user space tools may not be able to
distinguish inodes in different subvolumes.

Thanks,
Qu
>=20
> Josef


--nBe4gHXLzjlu8jkTAQiYiX3mfRghuZ44G--

--xXZHvlMS5mOvkY4CpApkaJOrlAm3Hx2e5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7pTIkACgkQwj2R86El
/qjHWQf/SH1+hEVgKvLlEjYgHO03G8kD/sRa8lODWP1RXWfwFbsWoo0+hR6ujARQ
Z1TvQ2CZZFXYbIoh8O4H0bfAyx5DgSPZTExbMYbITSbahcEF2U4206tb99izwLkf
/m4vF3Hib4sijPQeLGwUdkCjEElTcVPC8oaZEr2NZ6U2DrZKmK8zulzDkcJy4ZTL
SdWvk2M9mmr+xvXexYM3Xp+HaJfcM/LSZQo/qdKNOPyppDuZO4m9fuLkaeVSfPO5
cjoKnbXs8p18TA8a4G/NeZ/XZ6Jb6Ds05414XZK12EcKlDgw2zH8aafyOPyjTmz3
868tCxljvYs+pdndrYZvOj7ix28GCw==
=Uw4m
-----END PGP SIGNATURE-----

--xXZHvlMS5mOvkY4CpApkaJOrlAm3Hx2e5--
