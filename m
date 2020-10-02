Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2E280C70
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 05:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgJBDGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 23:06:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:34429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJBDGa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 23:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601607981;
        bh=sJ9gQUUZqzRwNnWV9Buag99PlEoql5VdkTNT3LnvugU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=csZyiNLBYF+EevnaNJgwFWs/YjC8ncGld3Ypl+pAuLDuddMAyJQRGpyVGq5rRcAOU
         6pP1qgcLIR7o7yzUZl/zytMFTaxdqx5TVRebESc1qJI7MBkhxdQYrGNvwB5/gB5m24
         R44Ffr7IavVL5IlH892tXYa3xc7jg/ftUetTX67E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1kQeEn3ysT-002UV9; Fri, 02
 Oct 2020 05:06:21 +0200
Subject: Re: simple Chunk allocator like calculation to replace Factor based
 calculation
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201002093001.19E0.409509F4@e16-tech.com>
 <6941eed6-19a3-add6-6608-8a5d5ec86006@gmx.com>
 <20201002095951.8454.409509F4@e16-tech.com>
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
Message-ID: <3cf4a1c4-b4a3-732d-6852-5b13e0cb1bf4@gmx.com>
Date:   Fri, 2 Oct 2020 11:06:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002095951.8454.409509F4@e16-tech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TMxF05QPSNctDjHVUh9mQK2bfYEnQrM76"
X-Provags-ID: V03:K1:SvLiChdzNaYbLsyNlAfRCc0Tzqq78tY4+Nx1WaC2qsK/LtFKREz
 4MZNDzrtfOyGI+AOA2OBMYUezh2m81B956tqtZ3ETzaaw3OWhRbmX3W8YSbnFgeMidACvKy
 GNkRoVqDRlyHU+zekZfHBSYwSExBHSLK1EUUUMe019S8l9jIUVsqOLhCAShXOorbBxday3N
 1Lf6iYP8uCuMPNR6T5H2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:94+yqUUxl5g=:TqYgtw0vR0nz5zftvlKZnH
 fOrES7q/CWMUf4MNQ5lpmdq9nvJhevHZeXnzl2TCcS+EggmW6fyqm3PBGTnpfD2JyNp0kVuI2
 uhEYjEoVJo+WKI+wUAss2hS9mBMvCs4Bu/VhFOZRtbAUgYlPwAd1EvfjwZ2OA+HxHEykgl1ve
 1bqJ4U95ALZSTRJp7mS+57/BucFzN8RCJNGuJinDVhueBtVhG6o2KfVQ4G0yYsJyW8ewT1k/g
 qg8D2jWCLvCmAiB3jQ5+bM40fUNKyT8Ino2miGV2LMyeYi0VI0/kHXZFUmHqDedmgb8W2lv8S
 t0r0TiGFvddxXjzty26O0f7rT4tM9w3XCHx3k1p0TGk+wkK7XesK7GTrbK6dywN+NZMExeRff
 +iLQIprNVdSsJi0eFKUULrYRUI78dmHrKvYDXCBB2gvwoeskhy2GtaGlCE9DJNTA0mjt46Qqh
 k5sAtPlRsw4nnxGuziECzMs2Bjuv1gVMS6ukGKlLuIracNnYS1Zj4sEuve2rGGadyd7CJhCJd
 lccDk1/Yi412D+wl+0CAbJ+rG+/3C+r1KeoQnYk9gESRU8BY9d7+BP0P19idgem4794/+UQjg
 v/2s1XCn+Qln8BXITUGA4DZNUPY0GyEafOrjG2zoL4KM/Y2vhE7RoPk5A4o9xwZ29qzxQEhN3
 LFlSpJz0/DcTmD2VRxsFY0s9LYLaIFQcorkZ6+CQHZBiEscTfZ7ioIODgZ4iTVgIf/VVKwWK6
 oNq9S4Y3vGAsptGTxtPOa4CyhO+GFWtEZIOyQbqVePNQ9XKH6RnNw9C3PRxse7pBexv8kwg6f
 jiOK3bvrluJhvF6GAIgn5tIzbOqz456kxfXwcWQcpqPt4QNIiJoOvSMibr8fcwvqdJASgZczW
 76GgEQFV/OXcOPgh9RjNuxQDx+c7TuW9pp+WiY8P+mlO5gprLnp3vBH0ttHk7xaGUDfIPY7nf
 2rwF1/4Csa8vW0eJg5sbzkJmdQMMNsNGVLOqytX9iTkgplYhXxiObo0n4QjNA52dOsm5pVGlP
 A2u9co81qbGB2Mo+fWuuYSkWBRjnM3fsFdkzBC46x7ecEJ462Iq5xc3n1izAPaimM90B4vKya
 QUBCGUIPMggY7EfRWYWsVm3EgLUm8NC6EwpGm0lRuqdW4dEIZ7FyLrCMKWb3A2YBb/0aimZao
 kr48m8seL6HoGxAGsUYmZsqhHlwIH6eLRmWKE8Ts6ghCAxUY2xgIj/ixjhQtBpN0Hu+kDUbWH
 88ByBxcCljQyGs8nnGN1QibToRfbnomhLrYTpGA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMxF05QPSNctDjHVUh9mQK2bfYEnQrM76
Content-Type: multipart/mixed; boundary="PkgLGkCSVO43Bu3WoqwYQ791yTjayjk3y"

--PkgLGkCSVO43Bu3WoqwYQ791yTjayjk3y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/2 =E4=B8=8A=E5=8D=889:59, Wang Yugui wrote:
> Hi,
>=20
>=20
>>> such as
>>> 1) RAID10 with 8T,1T,1T,1T,1T
>>>     the virtal chunk size of 1st iteration:	1T or 0.33T?
>>>     1T    chunk will use 4T at most
>>>     0.33T chunk will use 5.33T at most?
>>
>> You didn't get the point.
>> For the each loop we:
>> - Sort the devices with their free space.
>>   In this case, it's 8, 1, 1, 1, 1.
>>
>> - Round down to dev increament
>>   Then we got 8, 1, 1, 1.
>>
>> - Then allocate chunk
>>   Since the biggest unallocated space is 1T, we allocate a RAID10 with=

>>   1T stripe size, which will be a 2T chunk.
>>
>>   The remaining size is 7, 0, 0, 0, 1.
>=20
> That is the problem.  1T chunk size is too big for this case.
>=20
> if we use 1/3T chunk size, the result will be same as 1G chunk size.
>=20
> 1st:	8T - 1/3T     2/3T, 2/3T, 2/3T, 1T
> 2nd:	8T -2/3T     2/3T, 1/3T, 1/3T, 2/3T
> 3rd:	8T -1T        1/3T, 1/3T, 0T, 1/3T
> 4th:	8T -4/3T     0T,     0T,   0T,  0T

You're right, smaller balloon chunk size would make the allocation more
accurate to real chunk allocator.

However that would slow down the calculation, don't forget that we need
to run that calculation on each chunk allocation.
Changing the balloon chunk allocation size dynamically may improve this.

But please also keep in mind that, with less and less space left, our
predication will be more and more accurate, and under estimate is always
less a problem.

So I'll keep your suggestion for future enhancement.

Thanks for pointing out the pitfall of current calculation,
Qu

>=20
> Best Regards
> =E7=8E=8B=E7=8E=89=E8=B4=B5
> 2020/10/02
>=20
>>
>> - We go to next round.
>>   No way to allocate new chunk.
>>
>> In this case, we can only get 2T chunk.
>> Just as the chunk allocator do.
>>
>>>
>>> 2) RAID10 with 8T,1T,1T,1T,0.5T
>>>     the virtal chunk size of 1st iteration:0.5T or smaller?
>>
>> Still the same, 2T chunk can be allocated using the largest 4 devices.=

>>
>> Thanks,
>> Qu
>>
>>>
>>> Best Regards
>>> =E7=8E=8B=E7=8E=89=E8=B4=B5
>>> 2020/10/02
>>>
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


--PkgLGkCSVO43Bu3WoqwYQ791yTjayjk3y--

--TMxF05QPSNctDjHVUh9mQK2bfYEnQrM76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl92mSkACgkQwj2R86El
/qhfFQgArtUfiwcyMjiQVA6fDW4DWnHovjzLgQqwzkOScRib4kRiML6AXI4LpKPF
ceO6wjxjamgvTKFT/txIJb2MXsNwvjoFeXbILlvXZwqgW2nNixTSBT9RTQm/DQpt
bRsGBSpvdGmFLGqjmiyEzLWZPCMp8tdg69mgHufVOe44TZcpklxGX32IP3MPkaR+
eOzsWPsVpRvof1kJo6lZGpSJjjS2c7O/sETuRsy2sGA4QIfmRujiubtZTMlaIFkp
SRG5c5cdQdxHI+kCg7FcPHeGydkVq2urO0ERrcqaK0HtFonvW3qQegxtiHGvebNR
fHK6dC8u30h9VF8k6aokjoRoU8T6tA==
=xAR9
-----END PGP SIGNATURE-----

--TMxF05QPSNctDjHVUh9mQK2bfYEnQrM76--
