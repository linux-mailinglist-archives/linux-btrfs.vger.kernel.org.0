Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A768280FA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBJQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 05:16:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:44235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBJQH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 05:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601630158;
        bh=c8fKXqIy4z8dGKD5A+FQ2BiGsRLW+QuJyyo7mLNtm6c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SK5ua8ASY8RKUnGTb0P/+mQ2uXAOBuspiDnXVNHlF7qUeqx11ymWZkLQGWCK9ZWVu
         uD/mCx1nWplw/N//vOMas11vycvjrjB85huYRefGLmRooKgLApyULIAUVCW+Qh9cxN
         L0w4vVOzJhMEhZDYx8pZpn00NAcO4GFpeuUaM9V4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIMfW-1k9xIu2q1s-00EJeC; Fri, 02
 Oct 2020 11:15:58 +0200
Subject: Re: simple Chunk allocator like calculation to replace Factor based
 calculation
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201002095951.8454.409509F4@e16-tech.com>
 <3cf4a1c4-b4a3-732d-6852-5b13e0cb1bf4@gmx.com>
 <20201002170124.20D8.409509F4@e16-tech.com>
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
Message-ID: <a4b9523e-9d65-e8c4-43f6-8305c5dcc1c6@gmx.com>
Date:   Fri, 2 Oct 2020 17:15:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002170124.20D8.409509F4@e16-tech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dD4gNQV49gDGnZ50phV4iVGu9U59z99Eq"
X-Provags-ID: V03:K1:3+Pw1q6eXDSj39+H8fV8lNmF+qfd8TUMQTA/rjZouO6mukkAr4Y
 8mOwLp2MW3ZNZ9SI4PLLEee34iBXbSk5cyE64uMhGyVqIXvzSHJLpq4Zn2niSILIKSVqhUR
 A8B6PmvT5BULGwiBkY9An/3sX+mP24aX7rZHRmuavumzFWCvrMUoqmufXBiZWlK8PR5y5Zq
 z2+HYO2iggj286ZrFOqLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8mua7YBjlIw=:lsj5UWlKmZsDFvbbsYnvsh
 BEdqepKEbKn/PR6pJddL6iRMeYF6jgQmjF2MO8XKF2aSpi2uEDasxD/ByE/yDwVgF16A9mc21
 uJg0U6RCf8JF2SIVKHn4QXEwzgdrYoLygQg3tcgNIVNofTS7+fIPJEyCoOWOG/ji494Thz1bE
 plb8UThe+K6rVeT6t0md6E8TpHTaWcJRKmIvDgn7h3j50y1asNjf/EVaCkKKed4qPUGrJ2gXa
 6cwAkIJCGbckqj9eVZCEr5jvg9hbL9MwgRaCTLpaTiiB+NQrPVF8FMOsisXRozvJNmfDm7XQi
 6W78hChUrv3mQZVdsowHa/QEeL3s0yj9CyLXNNFnBXaT/p8Pg2J+CY1QKTNOIVxcVXHYvVhsK
 ntN1LzerfB/c0X20tAev5AUUZj9qRkA9xm8MKzrvfkQAwwUIr5Cl9Efxs/D3Ht+dxY8S6ssy3
 BCDHzxJas0sl4hS4yeAWihsPSUrkFSRiCfiRH66NPOXWT6fm0Nk3nSEdFc6eAN154YkOY3CoI
 Q3u5uTCFpQAyE6yQhiS+gaieSK49lOX9qP7V+ihAJ10rWwARHaT+I3MS7ruWLgQQd5Whyx+Xi
 XQUADABE2wh+s1iUq2Oj+ejtILH7nMLFleE0oxymMx+r3gfJE+2ESDZaiOXOvWUqV1sGvq6OZ
 +tQ81lHOIafS/5q5Wg89fd6cOW9mYBFOs/uUOG7q/EjmXLi5G0fh+Bz4ErlKE/XZEj75CP1yD
 z7yjsZl1pU/07bZybL8pYnJDOdBzKS2ZH/p40idnGu5+tAf1etn5qdeY0sH43adXdcy1NiRr9
 HkyeSGn/Qv+Gw6uCuJR57vPhrmPkIy4RiTsdgnxTyslbFTTKN4bU3d1gDmrjoH0ohTWyQX6OI
 wfT+WciqLwrd3tbc/AP4APXd5Tepn+rhm0VBTJuIEP6oFt1CzZk8u7cJIQYXTH1Eq+VYJ0ecm
 7kSt7Ioz+pWLtwVKMD6gBDKa8Yqs3erD/zZgF10kRLs4UpWo6j1/zk396cBnwWzPsdJm55To1
 rD+hv+Gx2xdgRxEfHFgstsLjLeoq+PIso7DB2oao1WnO+XIriSZAHEqEQERj2oW2uffRtC6c0
 UunUxBhQlwV0PlhwbdQcBWtWlcVNJLNHluk4Lh619fdia4QqbQTT67/cjLFJXNIdzXYhZ/e0/
 oHgwWgahFz/qotGw/upyEZaWiZmo4OkhnzHxrSTciiUPy3yddT7KSE3ih9wN39NyiAjgAg8LU
 7kZwWgrW1sEa6n7ucux47njdDJuHRACrjohlSsA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dD4gNQV49gDGnZ50phV4iVGu9U59z99Eq
Content-Type: multipart/mixed; boundary="Zh7k0i1EPKTysHqhhZdxYNgowUmcMSFCs"

--Zh7k0i1EPKTysHqhhZdxYNgowUmcMSFCs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/2 =E4=B8=8B=E5=8D=885:01, Wang Yugui wrote:
> Hi,
>=20
> We have another user case difficult to process.
>=20
> Use case:=20
> Add 10T disk * 4  to near full  full RAID10 10T *4;
> free space maybe be such as 10T,10T,10T,10T,2G,2G,2G,2G.
>=20
> There maybe a lot of iterations for this case because of 2G chunk size,=

> and then result in bad performance?

For that case, it won't. Just 2 runs.

The first run, we choose to use 2G as stripe length, it results the last
4 devices to be exhausted.

Then in the 2nd run, we use the remaining (10T-2G) as stripe size, and
exhaust all devices.

Thanks,
Qu

>=20
> Best Regards
> =E7=8E=8B=E7=8E=89=E8=B4=B5
> 2020/10/02
>=20
>>
>>
>> On 2020/10/2 =E4=B8=8A=E5=8D=889:59, Wang Yugui wrote:
>>> Hi,
>>>
>>>
>>>>> such as
>>>>> 1) RAID10 with 8T,1T,1T,1T,1T
>>>>>     the virtal chunk size of 1st iteration:	1T or 0.33T?
>>>>>     1T    chunk will use 4T at most
>>>>>     0.33T chunk will use 5.33T at most?
>>>>
>>>> You didn't get the point.
>>>> For the each loop we:
>>>> - Sort the devices with their free space.
>>>>   In this case, it's 8, 1, 1, 1, 1.
>>>>
>>>> - Round down to dev increament
>>>>   Then we got 8, 1, 1, 1.
>>>>
>>>> - Then allocate chunk
>>>>   Since the biggest unallocated space is 1T, we allocate a RAID10 wi=
th
>>>>   1T stripe size, which will be a 2T chunk.
>>>>
>>>>   The remaining size is 7, 0, 0, 0, 1.
>>>
>>> That is the problem.  1T chunk size is too big for this case.
>>>
>>> if we use 1/3T chunk size, the result will be same as 1G chunk size.
>>>
>>> 1st:	8T - 1/3T     2/3T, 2/3T, 2/3T, 1T
>>> 2nd:	8T -2/3T     2/3T, 1/3T, 1/3T, 2/3T
>>> 3rd:	8T -1T        1/3T, 1/3T, 0T, 1/3T
>>> 4th:	8T -4/3T     0T,     0T,   0T,  0T
>>
>> You're right, smaller balloon chunk size would make the allocation mor=
e
>> accurate to real chunk allocator.
>>
>> However that would slow down the calculation, don't forget that we nee=
d
>> to run that calculation on each chunk allocation.
>> Changing the balloon chunk allocation size dynamically may improve thi=
s.
>>
>> But please also keep in mind that, with less and less space left, our
>> predication will be more and more accurate, and under estimate is alwa=
ys
>> less a problem.
>>
>> So I'll keep your suggestion for future enhancement.
>>
>> Thanks for pointing out the pitfall of current calculation,
>> Qu
>>
>>>
>>> Best Regards
>>> =E7=8E=8B=E7=8E=89=E8=B4=B5
>>> 2020/10/02
>>>
>>>>
>>>> - We go to next round.
>>>>   No way to allocate new chunk.
>>>>
>>>> In this case, we can only get 2T chunk.
>>>> Just as the chunk allocator do.
>>>>
>>>>>
>>>>> 2) RAID10 with 8T,1T,1T,1T,0.5T
>>>>>     the virtal chunk size of 1st iteration:0.5T or smaller?
>>>>
>>>> Still the same, 2T chunk can be allocated using the largest 4 device=
s.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Best Regards
>>>>> =E7=8E=8B=E7=8E=89=E8=B4=B5
>>>>> 2020/10/02
>>>>>
>>>>>
>>>>> --------------------------------------
>>>>> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=
=90=E5=85=AC=E5=8F=B8
>>>>> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
>>>>> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>>>>>
>>>>
>>>
>>> --------------------------------------
>>> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=
=90=E5=85=AC=E5=8F=B8
>>> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
>>> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>>>
>>
>=20
> --------------------------------------
> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>=20


--Zh7k0i1EPKTysHqhhZdxYNgowUmcMSFCs--

--dD4gNQV49gDGnZ50phV4iVGu9U59z99Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9278gACgkQwj2R86El
/qgFXAf/a6RrrHrRiC6fEHQQBONBiACNEvCKDZRoAmB5ejsGtg2snorC7q1YIAN/
l+/XdrirJjMZrKqavo5aHveZ74IZDUCLCIaESofNZL8MmvOGX69g6KoIrwY5nHa0
00O8kEMHTPY1zXmP/R/KR+O+ratqr3D3BhbxDmjpOpKLa527/mNMT+z3A3n8P7km
tBsOfJ9cU428RP6wmppLAVQ88Kv5rEMwp277pTQOhIqY/hwcV/kGIAwKqSkhv18I
a63+eAyN1qJTG0d/G+81uMZ6rB+1MnvGyHp+zK8fiCewRQjylDm+MsW/6DKajjA+
umjO0M4oIozWIvc/KeEfAR4ViBbIwg==
=bpeI
-----END PGP SIGNATURE-----

--dD4gNQV49gDGnZ50phV4iVGu9U59z99Eq--
