Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994F8A4692
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 01:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHaXsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 19:48:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfHaXsf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 19:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567295309;
        bh=sRXHz/rjqO5u8yBxpWDsRAlNGbzIUZmia2tC//qQ3FM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gOSZj81M0rQYFmZpzlzJ8kkgQRQi62YtOT1wWXr+o2k1QX5/7kcCzKh6IOYksXqBp
         d8x7Q7EaYJf5nGf6Ua2fU9NQ4bqgDgGUE2EsjxDnFhXhYgwKupWPklsOIzEp0z0VrV
         DAlGQk5Dqc9+6Z7Tb1dUtIm+kTTeznlXsu4o8wPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MeLKt-1hpAnL1l2l-00QBSR; Sun, 01
 Sep 2019 01:48:29 +0200
Subject: Re: block corruption
To:     Rann Bar-On <rann@math.duke.edu>,
        Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
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
Message-ID: <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
Date:   Sun, 1 Sep 2019 07:48:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oW8LQniwKhXektBcpKleX3LZAJl9qqVaw"
X-Provags-ID: V03:K1:aqu0X6lYQl1+NmbEJkcwWaX0VasHjjj1Sm+QKpBZ121x3V6+mX8
 k8Qwo/VyyldtkLx3zxS1H5El5Aw/rdpbyaYrfyB/HuCIicWfjbzkkoOjNohCeCu+cl9dwDZ
 j+/79JU2MvL0gGT1LatRUCc95FO9YNQPVWgCRMWTIH8DIUnTDYGOjfNVuWLzYg5nyC6Z5FI
 8Za+ZtTYsMGazquhoCIzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9KsX5p12Fqk=:t1DTqXvuWYbfsofb+eig0P
 C1aa5LEbA6UiY3OAlKZTOpE4QTLNtet0HZK0ZOsyoviK1xVkomkkQwz8WUgtM1esaKaFrnvCT
 vvh7mZ2wN/96FO5vXeKel+VHvAP0oe8ak9RhFXYQlMyS7Gz/Tp8HMwD3g1jEEWfd9/imGq972
 aRhVJA19FNHMePU4L3XaNop55l9tp76Y9ed1ciHKuDp87+uvjtxUdN/xSw42YzIfLdmdMgnqK
 /8QT1iGgNTZkOuwtFCFq8v7clOrdk5u9JHjntt+COxLFNqTckn3NHs6Wa5oIzqxP+P8Qgc257
 R+IA/ZPv0aTb58dmuizoRidQ+HKM1urRazJJUGaDeM7VNEL24p36AgCYa5oalbEF56irA9NY6
 EPo9yJYkCoj4MjjwwnmVk3rMusSPy8MaShwGxnracu5Y6uMvISiryDLShxQI0Hw0mLo3i4k16
 ZnwnQtC9xByQc1vvNh5xjXvRmTyFSdc6sUJp0AUFr8KeE34FrdMLlLMJCNRFtqW6UnlsruV2X
 NhZGIZakOxCgEYDh8JuDnCllzvXsg4EYlh5dI+tZk6cQe3uWfjBYxaxmGX2Gw2eLj/bga1FM6
 eGd9C1QCyvthtWphcpJex8MOHXoiKeTXDuHyjEAilQmT+ZJ2HnAh5moZhEBvH6QE0tZq2piMU
 F3yS5sjeZVaLSE/5v3WKw6HFqZ7pAzYaNzxiu/fIFAAuoHz9/ZtqJzylaHGRlofr0i5bILCsZ
 D3HVPO65I3X8J3I9ecdm8oecMh/DMKMYZvaGZtzBCWUMZ7SySPtduc0b/bMiA923bD+EiUlI5
 ZRpSWCyn8oRKu+KUWVK1PZ/w4B5VVvVTWMB1QwVwwf3vd44CGm50oPi9E3wUZGIQybeweTrFz
 b+dITSvtZGRXukG6GWdHikIioMHDP4RcqgN2O8/ZSh9yrfxE2bJXUtvxYEF4e1L6hNg6XXdcK
 Hr3HJMs3JNz90IY3s/pVmAnaY7izp36tbmivSJRc3B/BcBUa3aPwV+vpSlOcRtjp5hACE2h6g
 wvqhUZADu4v3rXg8WXFW+y/I1jv80vNX8/SFpyuzMMuHiK5PJuoVaFj/nknkfLwzrm8dogPsH
 DXtimtkPrbUegELi1amsOewKXlfJiQCHtAGX8yQyJDhtqfZT6zXtmuQUz1F7aE+zvU2tJdxc4
 xwp+OH0KGK47aWPoMM26XGZgMOopBUdf8/M4z27fpO29sEeA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oW8LQniwKhXektBcpKleX3LZAJl9qqVaw
Content-Type: multipart/mixed; boundary="DxdvOOUnRTGUESVdR0EH6PbNJZiUbZzpF";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Rann Bar-On <rann@math.duke.edu>, Chris Murphy <lists@colorremedies.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
Subject: Re: block corruption
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
In-Reply-To: <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>

--DxdvOOUnRTGUESVdR0EH6PbNJZiUbZzpF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/1 =E4=B8=8A=E5=8D=887:39, Rann Bar-On wrote:
>=20
> On Sat, 2019-08-31 at 17:04 -0600, Chris Murphy wrote:
>> On Sat, Aug 31, 2019 at 2:26 PM Rann Bar-On <rann@math.duke.edu>
>> wrote:
>>> I just downgraded to kernel 4.19, and the supposed corruption
>>> vanished.
>>> This may be related to
>>>
>>> https://www.spinics.net/lists/linux-btrfs/msg91046.html
>>>
>>> If I can provide information that would help fix this issue, I'd be
>>> glad to, but I cannot upgrade back to kernel 5.2, as I can't risk
>>> this
>>> system.
>>
>> 5.2 has more strict checks for corruption, exposing the rare case
>> where metadata in a leaf is corrupt but the checksum was properly
>> computed.

Exactly.

Although for your case, it's some older kernel doing something bad.

It's also reported once for the same problem, some older kernel doesn't
set the mode member properly.

>>
>>>> Btrfs v3.17
>>
>> This is old. I suggest finding a newer version of btrfs-progs,
>> ideally
>> latest stable version is 5.2.1. Definitely don't use --repair with
>> this version. It's safe to use check --readonly (which is the
>> default)
>> with this version but probably not that helpful to devs.
>>
>=20
> Not really sure why that said 3.17:
>=20
> $ btrfs --version
> btrfs-progs v5.2.1=20
>=20
> Anyway, running btrfs --repair on the file system didn't do anything to=

> fix the above errors.

That's what we need to enhance next.

>=20
> I removed at least one of the corrupt files (the only one that was mode=

> 0) using kernel 4.19.
>=20
> Happy to help further if I can. What would you suggest as far as fixing=

> this or reporting it usefully? If you believe 5.2 isn't causing the
> corruption, but rather, just exposing it, I'm more than happy to
> experiment with it.

Deleting the offending inodes would be enough to fix the alert.

Thanks,
Qu

>=20
> Rann
>=20
>>
>=20
>=20
>>
>=20


--DxdvOOUnRTGUESVdR0EH6PbNJZiUbZzpF--

--oW8LQniwKhXektBcpKleX3LZAJl9qqVaw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1rB0gACgkQwj2R86El
/qj1agf+IBRxeOBWWpl5I3Hlv8g2pNoSXAklRgJs7Sk3phFn0oDdLJIkVd+qvTV5
2TFKHHqmuYdlSM+sAmK/rIKvRwwJeXL3hbl7uLSnJebRkfQj6/Uqs4a0QxG++5kQ
jKT8CJ6KChx9tpV5zu/416t1k+cMrp4tsdXtHZ0Z6jyOKhc9XZXMM1XGE0aD3GZT
E+dEFyp+CF9R6Tywa6merhkr4KJPkV+dKd0JodJPJ/O0+qQY/6JK04S5SVYyE2To
ixV8TqH4Ontm/MLuRBB0LxQqzEfO5W5/vPrqEo75k5SltEbyouW3xillzeorK7ce
2NbqZK8pzwHH1vPE4dmRbaGhf3SGgw==
=zEPq
-----END PGP SIGNATURE-----

--oW8LQniwKhXektBcpKleX3LZAJl9qqVaw--
