Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5B17B251
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 00:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 18:40:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:41981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCEXkw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 18:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583451644;
        bh=K6w9vNhQ1DOH+CJbueRuH+I2AN6WrhXSeWT+i4cIfCo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d+OixlfQ77thV1yemXdJmCuBkDzoBHnqe4vvV2vHyixuGuk1w9jLOYEAC7uhZwPrh
         JXl9DO7rGB7juLCljjFq7N4BFf9wIJDXgTOKKjIRC1py78PSuDnZixf+VQ0uMlB5k9
         ibZKmEpbolfwKrRKH8CJOcLIns8Jnwm0Q2lln9U8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1jQT713a28-017Ycg; Fri, 06
 Mar 2020 00:40:44 +0100
Subject: Re: problem with newer kernels
To:     Arun Persaud <apersaud@lbl.gov>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
 <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
 <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
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
Message-ID: <dd0dffb5-e248-4498-dffb-4a6e6e4fd0fb@gmx.com>
Date:   Fri, 6 Mar 2020 07:40:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IqS1vXJLeRH7AhyLq675igxYjNaAGTsQJ"
X-Provags-ID: V03:K1:xs2t7SkTiCwnnLTgD/cwN5H7KjzsYaO8TtWvsl3Jh6IEEPIWn65
 LqKqGcorY/zfrC5M0w8TBJsFlRvTCFPstsc1Uz07JWOLZ280NlSOaO5ST+KuujZE8I/bsBL
 SgZzZhpmY2bHP/FF2jdWpCLUIR9JQdrLA1j38tphroOlCBFif+3R/5neIAQiKI80F4/gJzW
 G1/ZCjx9KTKtk8Z+W8plA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7NxoOZ2Msc=:HiBHxOn5HYTk5yybwA61/H
 wjYtlzvEU7kvmRZQZ+bMB/o9sTw/LeCZgVEQlYrz+SrUzo6gJJtB/UfvCWSUo2XZ5mSnIe/be
 H1us55Wu3P+5bUdZ79lPDu21heudUHdFbgeQZNTkut6F+wPfI+Im53e7haKqtf63y4Uc5NKSl
 6Qldq91A4ohlHO64bAcIWm1Eo12a+F/3qNkxUtomE0Yo8H222LH/7elHMvn3JFQlHzmwtZ5cC
 iQi20yipdlXOkFx9mK1CGkvSZvN9kk6HCy8Pn1fyg0qIye2vJPEQeJtm4iEjRuksMcm08LX7J
 bO6pTeyAveve8yk5NQRi0LBebrLU8Pxi6zQ/xdL2sqNN8glGI9KABriKtwHjrb1rP7CKuQ8lE
 p6fOhoxxOoxtbjoUnuqbppW2n/gOtLaZ64CqMyA5ayIFsdU2edkQRXCmSpvGkaMQwK5ogqs0V
 SXj8mjhyzlgRNv0w34AWA2IjcPa4R780bjSoEjwvQuVcJUGnEzOck6+dmMG4bL7l6fv4GG9PW
 5Xv7YT4e/77mmxECmhR+W6CjU/zTHiQdh3/E0JDRZ/VlvJaVP8yMx57Rx+3wYrjM7OHV9gH4r
 qI1UJOXYoVVJiwbnb7gflHYrc9HgIdkYqJrMIq3hszw6Y9M95Zh0QTaHw6MZGxSrQpVq845eR
 ita0mtd28PhiYVLBkR+H1N3y2Uimle2tt43kgJDBDfVfmicbBKkl5tX14MCUh4kkQpV+Z5+Ky
 6gIJP7EK8alybL1UAA6Ei7uuRyL3BKIH0mMgW3L442oaeJcDcUL62+5SMKCWzonZn/HlvWTCm
 E5TOuDoKVlBioCbRt8EeqLN0h4r725Xl9EumAxdCiuihzhSgMiHKIZoKTdmsgjh8mMbtpUV65
 9iTdjRuOhYQlQZVl0humvSlUQkVFZxaPbrslQu6gMGSsBT0pOOoEliPtUeDg1zvI+1hvFh4sj
 G60SNZGWep5VTZrwhEoFMEI29ako8SHAy/GQ95AUnjYP1qgi/U/voL3JpkmCOdOX8S5vt/eEr
 hUqUaLtaXAjDqhBJqeSXgz0FhA72y36wLV1ZX8Z/XEuq0qyyNDxD+nj9zRGe99fSXhApPZ8P1
 pw3N6HeCLwOsKLzTxrA6xp7X84GehsKA0ZG1IHLdAgKBvJzzABZ0HBKPR4DL9yhTGbC/f/l7U
 rfufWioF80kHh3atCOVj1uJUUoMovc+bo7BaoJ3EgAyBW9A6n8rhmziyEE67X1qlC+N/XGFIL
 FrU0sMU9yUoiaVXN/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IqS1vXJLeRH7AhyLq675igxYjNaAGTsQJ
Content-Type: multipart/mixed; boundary="0XrKvZlYQYOHIpHJdZFgendJzb7Mu6tIl"

--0XrKvZlYQYOHIpHJdZFgendJzb7Mu6tIl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/6 =E4=B8=8A=E5=8D=881:01, Arun Persaud wrote:
> Hi
>=20
>>> I use btrfs for a partition (/dev/sda2) and when I try to boot with a=

>>> newer kernel (on openSUSE tumbleweed), the system doesn't finish the
>>> boot and goes into an emergency console and I get the following error=

>>> (don't have a log at the moment, but can produce one if needed):
>>>
>>> BTRFS critical, corrupt leaf...
>>
>> Complete dmesg is needed, thanks.
>=20
> dmesg is attached

It's inode generation underflow, caused by some older kernel.

It can be fixed by v5.4 btrfs-progs, by running btrfs check --repair.

Thanks,
Qu
>=20
>>> However, if I boot with an older kernel (5.1.10), everything works OK=
=2E
>>
>> Sounds like it's hitting the tree checker which is much more
>> sophisticated in kernel 5.5 than 5.1, so the problem is still there
>> it's just that 5.1 doesn't complain. What is the kernel history of the=

>> file system? Was kernel 5.2.0 through 5.2.14 used?
>=20
> I'm pretty sure I tried all those kernels, but I don't have a history o=
f
> it (the problematic partition is used for /var, so no record via
> journalctl).
>=20
> Here are some more information about the system that doesn't boot:
>=20
> uname -a
>=20
> Linux ndcxii 5.5.6-1-default #1 SMP Mon Feb 24 09:02:31 UTC 2020
> (4a830b1) x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs-progs v5.4.1
>=20
>>> this was with btrfs-progs 5.4.1
>>>
>>> both didn't find any error or repaired anything, so they suggested to=

>>> email the list.
>>
>> That's unexpected. What about:
>>
>> btrfs check --mode=3Dlowmem /dev/
>=20
> This showed some errors:
>=20
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 5 EXTENT_DATA[394462 0] csum missing, have: 0, expected: 40=
96
> ERROR: root 5 INODE[394462] nbytes 0 not equal to extent_size 4096
> ERROR: root 5 EXTENT_DATA[785218 8192] csum missing, have: 0, expected:=
 4096
> ERROR: root 5 EXTENT_DATA[785218 24576] csum missing, have: 0, expected=
:
> 4096
> ERROR: root 5 EXTENT_DATA[785218 32768] csum missing, have: 0, expected=
:
> 98304
> ERROR: root 5 EXTENT_DATA[785218 147456] csum missing, have: 0,
> expected: 143360
> ERROR: root 5 INODE[785218] nbytes 49152 not equal to extent_size 29900=
8
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda2
> UUID: e7b29c18-4707-48a4-8c29-dd4dd70378b8
> found 17940045824 bytes used, error(s) found
> total csum bytes: 10656228
> total tree bytes: 145596416
> total fs tree bytes: 90025984
> total extent tree bytes: 35987456
> btree space waste bytes: 33201183
> file data blocks allocated: 28054265856
>  referenced 14007422976
>=20
> For the working system:
>=20
> uname -a
> Linux ndcxii 5.1.10-1-default #1 SMP Mon Jun 17 14:44:35 UTC 2019
> (ad24342) x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs-progs v5.4.1
>=20
>=20
> Let me know if I can provide anything else
>=20
> Arun
>=20


--0XrKvZlYQYOHIpHJdZFgendJzb7Mu6tIl--

--IqS1vXJLeRH7AhyLq675igxYjNaAGTsQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5hjfgACgkQwj2R86El
/qgOkAf/fDz6mB6H1D2cKiXQD3SBrsBsBdWiltgpWTkHWrcMa/6Lu5pHXNKPiJn6
URD4++VJnzj8Z+l57+7wIdD7GazaFFsblxvHB7C5KASkeOpMbvyYtg8QRwb4+2Dc
Y1xa2xQLz8IoIcpCSX6xfItZcXqO5Wwh4IIxlvt0u+bKVjhv7kriFBzHXVG0lQEm
XJhTNStMM24/F98n69ZOxiQqwQCSKkG4r2nkGWcistwdQiRYb+zesXYx/nd72r2T
WfXhTx30fNxrcDARtOm5ks//MoPsXTISitC5SAQOPeKHOLMEu7TShSo1Ok96Xy8q
8NZgUkTxUXqT5r4ohkrFl3eZ30dDaw==
=r0nU
-----END PGP SIGNATURE-----

--IqS1vXJLeRH7AhyLq675igxYjNaAGTsQJ--
