Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8212AAA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfLZGun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 01:50:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:34291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfLZGun (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 01:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577343037;
        bh=JXjdhuvLjnFp+6tZ9qRuVnj+/5D0IF/iStwdZ+ptF24=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kiR1QEFm3C0LKKMVBPoxgYM0OkGu6/NKwJxN4wTuOkchJ25Ng6SG3CbS4d7QebwF5
         b24m/HB29IbypHm3NbU+ZX8ZXeEbTIMQOMg+bpJiLaM8QamrkbGFT8YraRgrr8ZcBF
         F0MY7YkLCuKtanFXfO+6Ak8la71uArhNdZvLJMIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1jE1Ki3x6i-00Vu3J; Thu, 26
 Dec 2019 07:50:37 +0100
Subject: Re: Deleting a failing drive from RAID6 fails
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Martin <mbakiev@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
 <3826413f-f81d-de13-8437-4e5b762d812f@gmx.com>
 <20191226054058.GC13306@hungrycats.org>
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
Message-ID: <50661176-b04c-882b-d87c-ee5c0395c3f6@gmx.com>
Date:   Thu, 26 Dec 2019 14:50:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191226054058.GC13306@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yXAxVqUGU57ABTXnVqHcalMaJ6ObjpeDT"
X-Provags-ID: V03:K1:U1QY7miDtSDJ+4YIA50pmA52blpZacze8G9jbbM8oYN35YpRrMR
 TUkUDBu4nsgGLP24NrYP5lGFouu+D6OVAl7mXMT0QODZR4h6J9ig6yLNTOUWirbTFmpig5R
 gxywZxkfSSy/20BlKwamE41t503nPMkMCMdGrVqYUR1oDLyPlmak7C1cn1qmA+tXb26xwU0
 r4e8i5i2y0JIsmzSdG0IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ky8gr0zLHkQ=:vHFxkvulAWRgDE3C3bzKGv
 N1H0enz1a+jXO0thMDDzxec9XV+03lAdtbxaoHDXzemOXuc/k/36YyuvZegfUvK6ESXJR62Yb
 Kl+vnw8/Cy5j7vW/5bRbUIKeP81cB1SHbFI/RL+oaznSNtysPgn5CgpFgVUYiazmSgviMcqAs
 7iYhir4JshzFEIfzCdrnd+Z7iG1Vro4iT+CHOY6ohUXyvYZh70JXkgACuyR24Y6OGFSYDq5DI
 Bst1u1KiIoKxGHPPjH+v4HjTXmgDzhLMc193sJyIgXiacbsHQUTNGqIyfdb2OzNRO5YjK3yAl
 1dfsmoSDSNaYiVphq8LbNtNkjR+kwy1XKM+89Fa/Dyk7ESmGsVmhUvmHWqNl9FczWHDXF/qbu
 cyKy9pdMVzQh9PdLMmmdFkOfKDko9e2UMAMphcyFtG3bkkym5YO3rBbK7y3Y2hbGQdZMvDqFZ
 AVr/fRLr/Yu/8SceaVPQQbaRDQ3PvPjrmZq1y8AAOWPBPHWNwBWKceHbbE00Is/X09PCscQLq
 iGFfeYqB6VnsSDZ8Kf7rWhtCMVUdMDzVoW9ang8WFjhR3XLeLt1FuLs8ZD6SLnOnEE5mgIayF
 zE1Jyj4FNam90s0Gp6ngHq8jAMM+EvbYAfBHQfrWmKcFosiVl7/b6OImw9sQC6hySxtjHJY89
 2NRQqIlBcxkpeZYgeKBTTugzsFfEQgsebhCqOlx6IwATfUwVpuH+PfnKOgZ28Ca5+zqqHkfW4
 qM/Lp4fOYNONT+UFI9KHWYNVj6+CZHl3+DGOSwJZIV1D3BraOInOW3UI5rTiEPuUoWYVNGYhX
 2MUM3wsIb6Y6tArYPQ/QUy7uBo83wasBUrk2AiS88l7wli5wwalN6wdSUiFtiz6Qv4mMcjsbk
 GU6SU2Y5Syn16P7l20Bf5GP5fjeQhxVwAnkPEeZBhHImvGtiRbfjlVPkfbKnfWsNusQ/sCisL
 e53POBrDqmJf+SpyE+oRTqH5O308sip4Xwirku6R/42ujDzVZv9mtcQ4oqBK/xkDlxKpHSmoP
 AEqTPuYJTRwu3Hi648egxFavfNsHyX73wsXKoV0DqwCUH2zB9+1Fsxxy4M7sXbHgl4OLCxfdY
 9iNw+/DzAInzl/sqqofkmIoIsYb448eKfhaWxsPTAnWaFyM71Bw+Leyfzbjr7rVX+NoXcGRUb
 wDzCkuSoRUShrR7s9EV+Nxu/IXKbvoEwXIu80LWdP/60+7zxWdgDdgX6gnqalGs1xvYMaP89j
 AO9k+X/zokrmZ6endnHocS6gtsB9CMpNDFmVWQ4Dw5qba0Q5wF+fSebVRqOM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yXAxVqUGU57ABTXnVqHcalMaJ6ObjpeDT
Content-Type: multipart/mixed; boundary="UQH1dT0hYb9J8P76oOOr8NGeBu9xw9zuC"

--UQH1dT0hYb9J8P76oOOr8NGeBu9xw9zuC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/26 =E4=B8=8B=E5=8D=881:40, Zygo Blaxell wrote:
> On Thu, Dec 26, 2019 at 01:03:47PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/12/26 =E4=B8=8A=E5=8D=883:25, Martin wrote:
>>> Hi,
>>>
>>> I have a drive that started failing (uncorrectable errors & lots of
>>> relocated sectors) in a RAID6 (12 device/70TB total with 30TB of
>>> data), btrfs scrub started showing corrected errors as well (seemingl=
y
>>> no big deal since its RAID6). I decided to remove the drive from the
>>> array with:
>>>     btrfs device delete /dev/sdg /mount_point
>>>
>>> After about 20 hours and having rebalanced 90% of the data off the
>>> drive, the operation failed with an I/O error. dmesg was showing csum=

>>> errors:
>>>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
>>> 10673848320 csum 0x8941f998 expected csum 0x253c8e4b mirror 2
>>>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
>>> 10673852416 csum 0x8941f998 expected csum 0x8a9a53fe mirror 2
>>>     . . .
>>
>> This means some data reloc tree had csum mismatch.
>> The strange part is, we shouldn't hit csum error here, as if it's some=

>> data corrupted, it should report csum error at read time, other than
>> reporting the error at this timing.
>>
>> This looks like something reported before.
>>
>>>
>>> I pulled the drive out of the system and attempted the device deletio=
n
>>> again, but getting the same error.
>>>
>>> Looking back through the logs to the previous scrubs, it showed the
>>> file paths where errors were detected, so I deleted those files, and
>>> tried removing the failing drive again. It moved along some more. Now=

>>> its down to only 13GiB of data remaining on the missing drive. Is
>>> there any way to track the above errors to specific files so I can
>>> delete them and finish the removal. Is there is a better way to finis=
h
>>> the device deletion?
>>
>> As the message shows, it's the data reloc tree, which store the newly
>> relocated data.
>> So it doesn't contain the file path.
>>
>>>
>>> Scrubbing with the device missing just racks up uncorrectable errors
>>> right off the bat, so it seemingly doesn't like missing a device - I
>>> assume it's not actually doing anything useful, right?
>>
>> Which kernel are you using?
>>
>> IIRC older kernel doesn't retry all possible device combinations, thus=

>> it can report uncorrectable errors even if it should be correctable.
>=20
>> Another possible cause is write-hole, which reduced the tolerance of
>> RAID6 stripes by stripes.
>=20
> Did you find a fix for
>=20
> 	https://www.spinics.net/lists/linux-btrfs/msg94634.html
>=20
> If that bug is happening in this case, it can abort a device delete
> on raid5/6 due to corrupted data every few block groups.

My bad, always lost my track of to-do works.

It looks like one possible cause indeed.

Thanks for reminding me that bug,
Qu

>=20
>> You can also try replace the missing device.
>> In that case, it doesn't go through the regular relocation path, but d=
ev
>> replace path (more like scrub), but you need physical access then.
>>
>> Thanks,
>> Qu
>>
>>>
>>> I'm currently traveling and away from the system physically. Is there=

>>> any way to complete the device removal without reconnecting the
>>> failing drive? Otherwise, I'll have a replacement drive in a couple o=
f
>>> weeks when I'm back, and can try anything involving reconnecting the
>>> drive.
>>>
>>> Thanks,
>>> Martin
>>>
>>
>=20
>=20
>=20


--UQH1dT0hYb9J8P76oOOr8NGeBu9xw9zuC--

--yXAxVqUGU57ABTXnVqHcalMaJ6ObjpeDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4EWDYACgkQwj2R86El
/qgE0gf/cst1wxp2YfgHuUPi6m6pkckeVek+vTJ29DU8DFyhzBJhI5o2vBZPs2Od
97RwNSkL1wLDu2mHNRCl/KFs+oHqgZKc/O1/TcVVy2xo8/Iv7IiAPfh7VJLW4QOd
lJLTTaWbvytCF4aXznDS4fwfH4KM+3N0uD6co+QXVp8QaYmR5vHcXls/cgtEgdeN
LIKCGT41FbRJXbPKOlt8IEbYcu+DcdeuXziqSpi4JeYR+AHcx3y6FGVd4YMs5AO4
CR0kW27g2c2GJmqTjbuVqfMa/OquOjJc9Fy3sgBiGBjXk5g8KauzkbO/nIrrUFJF
SxqRS7KYQPun/tSBQgaSI5D61Nv/fA==
=MuCV
-----END PGP SIGNATURE-----

--yXAxVqUGU57ABTXnVqHcalMaJ6ObjpeDT--
