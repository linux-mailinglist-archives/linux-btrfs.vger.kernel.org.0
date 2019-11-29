Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20E10D037
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK2Ao3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 19:44:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:52671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfK2Ao3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 19:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574988263;
        bh=/lffysegcLXjasZ+Il5ZT7X11aVfopGEPaf/Q2nOZw0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Py2SMxv3l75BBLEQmZhcobUxUoI6pGHIzxyvbq4FSpOJI2ctEEW50eSK7hS+8b2Sj
         vO9AVygx4c4zpKfmvuJXbLupIzZHDi/nYfWX2kKuuXJUhVyDckb50TvhF3H25XQX0L
         NY8sGGxGm3prpHbcJaPAE42xX8a7QprXpjHJgY2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42jK-1iaUOU2zs8-000765; Fri, 29
 Nov 2019 01:44:23 +0100
Subject: Re: BTRFS subvolume RAID level
To:     waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
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
Message-ID: <f355213c-cd11-a346-b945-74bffe0f5e41@gmx.com>
Date:   Fri, 29 Nov 2019 08:44:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="234ovL1ttQKLA5VwdJMU2mbjGv34vCAqk"
X-Provags-ID: V03:K1:zKsIvziL4Odirq/+xBYwNaB59lL8L7Vsb0FXEE8ZB9zD1fW0wJC
 e4Yahki6RI/4ghURuMKfsi5Ef3I+yWNXax+IWbBqWJyQmC+mRj9IJLbqnLXbkCmWMDe2UJN
 sMAC+pSBHNGEcZGIQerdGmXWfYQ/Tu8TNGbEkf8w3dPtCMgpzOKMzngra3D/+h5XAdSqGby
 wUU4pKcwsOHSK74G11Gfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/wsQdJ73XDM=:cFy3Je/D3VgisvwY1qJgft
 g3hMXss9SvNPWd7RW8SBZKLARHGhRDP2dVbXJBQp4miE9+OkzbpwTqZQJhCkbjxvRDxGRUmGQ
 o86K6ofiQ6yN+w+nIgtcYfZHJsYPFL6UkFfswqAozjRp9W81LnaFH93eHVujzpk3/7JXVgiMn
 +PyvaV3I4lgytSCk5LWhZkGRgzspBLQjxhskoacGqZDUJZbWCnQD6B82Md0fKJdVO1JrKJhCe
 PGfsfI5SNR0PkctkjQt+XdcaNmBi3zLhKt9cocplwRJH1NUZTtJiLYFk3BAHzyn2NVvBsVkwA
 9QvKW8AVqnsxcQOEWtTBbqVjtq70Dx38RSko3srW4FZGaer/Cv4sikYCf6mPswJGKtc7swKC2
 F+mGFpZA5yFS1aKlQobHPyC/sJ9oQAsehlpmcoDL8y5Y1Ly0xWqUhA4v6YhHt0VF7yChOsMp5
 fazP8IO7f63GYws8n5u28Lwzfau73RIG4b6qgfiwOWXLGtrPDr5ZiIJ7VT3dtEhN1eM7VZvXC
 GbWsLVtKugrmp5hTbsg1IALi/RpabPavVoSLLhdANoImxlLvFBHksEyz7RwNjYBi5og2rdLNO
 4VZwrrNJKBvSLza1fhgpLaBxIPWCzebhFr+pJTTymM6w23HgBRBGb3rXjXpD5ADMRaafYGDHd
 1wZ/qKXL6HLZoJl6B8RldFQO+JyT+Dcm+QMVaVJuj2ZCxdvho1LsvW+YQOqZ63ANPGPgr6qjd
 ToOiQuwhJGxfAQ6DAQVRZY6/bkbYqxTKqN4l9dzOMN+9+0GzWzjMpWXul05+8LCUrsjGaKqaB
 G5wlINZLvCDwGRf0KQuKupOsNjYOekIsggpdzApKXN6+bUhgK0r9SKx0aISVS7Lh3lBcLvB2J
 LRPFGvuuodKD7G2Cnm6fiyaC0+UJ8Zsiy3IN4b/Fl0K92pGh3THzPnxtKo4eCUW2u0kr6oMHd
 90xfbQWxn30FtSrMG7AiGDm7Q133anNW3hDL/yHAlpGkWjVrPqeyPlHFnVjaPZvmPCXw0BBdT
 dEMHklZLQp9rce1TJTF/tunbOqoVfUVlMxcbyidMy49TNeG18i6Jaj2zh2/i8bQHvaeshNEiL
 mLxCbylPN/XHjRM6cuFMiSd4rHgM4E9IPSnm/Gf+c7mSnGw+nDh14C+Ar1xVm49abxvxzJT5d
 j/Uowk+QY3wfjD0xjfhprhEB72M/hIIvVB8Mps+uQn+ZihTmIoPuEC0ftCYkdl49MQiWYniHK
 1RzLMg3NAXYOhpwe1NJGX2U7EzUQMnrOxYR79lzXw+IbpexTqwclj8X2HhTo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--234ovL1ttQKLA5VwdJMU2mbjGv34vCAqk
Content-Type: multipart/mixed; boundary="UhYLy1JObTqQwOKkkltN0tUxOBuITmv2L"

--UhYLy1JObTqQwOKkkltN0tUxOBuITmv2L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/29 =E4=B8=8A=E5=8D=886:48, waxhead wrote:
> Just out of curiosity....
>=20
> What are the (potential) show stoppers for implementing subvolume RAID
> levels in BTRFS? This is more and more interesting now that new RAID
> levels has been merged (RAID1c3/4) and RAID5/6 is slowly inching toward=
s
> usable status.

My quick guesses are:
- Subvolume and RAID aware extent allocator
  Current extent allocator cares nothing about who is requesting the
  extent.
  It cares a little about the RAID profile (only for convert).
  We need some work here at least.

- Way to prevent false ENOSPC due to profile restriction
  If subvolume is using some exotic profile, while extent/csum tree is
  using regular profile, and subvolume eats too many space, making
  it impossible to fit extent in their desired profile.
  We will got ENOSPC and even goes RO.

Thanks,
Qu

>=20
> I imagine that RAIDc4 for example could potentially give a grotesque
> speed increase for parallel read operations once BTRFS learns to
> distribute reads to the device with the least waitqueue / fastest devic=
es.


--UhYLy1JObTqQwOKkkltN0tUxOBuITmv2L--

--234ovL1ttQKLA5VwdJMU2mbjGv34vCAqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3gaeIACgkQwj2R86El
/qhHvggAon+T2jw/21EmVbPFePZk7vJZBNkmWhMKRAdU+qNHn7sgewCmNPzD8AYa
vr/5+9O7ddUWLdvhjE+86n+xfYWWNvFXq/XuhBvDKoG7Ov+BvyALMIGmt48WbM/6
YvM+F8Imo3GKBUIstiOpxZZWNF5MW/A9x/FRIJgeJaCmpTRZVdDUz3RmDWrqjG6A
LXWGnO6F97eT0v4YLeK6y79tlaTB5kcWTE81KDNGld+f77AYUd/7bvls95q7S2I0
MKbzAkbP3YnWxdJAV0Ic0En4ofjXV1q6lQdEmLD1/WyMwsNsf6/vNfuvKqKBGyvI
vHPSXcjgbftLjvoz8oVzDGMB/mCG2w==
=Mv7I
-----END PGP SIGNATURE-----

--234ovL1ttQKLA5VwdJMU2mbjGv34vCAqk--
