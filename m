Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B195B85A20
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 07:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfHHF4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 01:56:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:49021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfHHF4o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 01:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565243771;
        bh=pxgaoVBUzIcNs7RHHl9YHY8RNa189WY6JuBErXRSJPY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K8GRDNez/xpvhco80AS6ILoXlq9FeQRmu7UbzxHEsjmhFkbm/C+1XwBJhrJxDTtpw
         nq69N0r3pZIbZIyZNkgcpAILhN8rO/zi3ZEpUygNwfeFmGC9Ubj0IrGhPqqayP/n2Z
         p45+eV+PxIupvcavUeRt8Oz3r1ZsctpvkghkKurU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MNqfr-1hwx7F03bP-007XhU; Thu, 08
 Aug 2019 07:56:11 +0200
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
 <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
 <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
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
Message-ID: <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
Date:   Thu, 8 Aug 2019 13:55:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8jdoobQugF0ZB98GInGZWttUedEOa0qcD"
X-Provags-ID: V03:K1:UzRUmEjXZsVLlCAISUCQl+KiQnCMefcsXal2S0ZJ8A34PyBvp7l
 ysGAl5OWR9/dUGV0oSOAYB1P8fgqt8j5Ito5ktFAp8HcmijvbmuEwQDJQdXa9uqYnoJ52cz
 qdzhAxj1qVh+D/zukP55ntcbbKfvC/9htLrl0AUw5NA55fjGbf0UuI4qha5usG0onvR54dE
 f02HV7J8It3jZFte1O/1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBQdWMmeF2U=:OHykqwXJwhJJZ5aBMkTrlF
 +sZkIaW0tX08zAGDu0HWbRxbIOST8UVmIXoeToGlHsNaoUwhLzKcgQnUlcF2gxP2WTKsmlnp8
 qZgRYT+0013mLSvkHhPZYFfuulWe5nqdzMpZU11KgsXV/aRc9B2FfzaPNUpeBq1dDRjwpCUHO
 r5zBSYFl6/96ckUaKH51H1QmbyN0JTuT164OhAvX8AdAh+Mq/TH17XblEivesp9/nh9iiPk7p
 P0WIwD8AG6V9GbB+tyNghW/ojhQav2lgBiRAvzXdbfuDeHz0b5q+/zmaYQiwEUq6MV7Wepv/x
 s2D3P3JfIFarnrj8Nm1khtoX9vxrrkKzezwqL4DyT1GrMc2YvZ/yWaW9UqnrbN1G4IqkmmZut
 dtXRkadOPruu/ghXpUELYVZvn7IaNW7QSQh7wnfOu8sEea1r3GdCaBIP8LTczUrJaNucfH2qk
 wQ38I5Y12w5OYvy5ec5WQvPWy+vu4ES3bWYTLQ7K2diqd+O2et7GRcU904uNQvMmRHAdmnoZC
 4cPeyZBisZinu+BjDJC/8TZ1AP2zsNwmrHsV+YIcUslDZ89iHPy7yy+GkRniJlVlxxK3iBkcf
 6CEzn3S9a27/YzpNahuMkSr3mt7ol1MaXXJmKCWlm07JcKAHoubo+S8sJTt/UWVt8FFXDolaL
 aRl6yUanD5EPElJ9w57yiPPNwvhS3laJWdqRf5XiHO2lnTRmD1rtJzpBHSkQYGsli3/TfMFXQ
 5/u775SwG4psWhxt3FsnNcE3DTQPVCjpoTIN9cv9a4gNoCSQIDUIR2NxAQcyGFnS1XluBiCCE
 gHftTaZclNnfxQiX6WzgeMqIgEqSGKspbXrbYcjXDW9Z7/aQrb4XMyPXrU5lmao2gHx63V3tT
 Idai0M/ET0bOTBkqu92rUJ28EDKqoYgIWEbFhUYxu36r1gT0/w7bxWp8ETRJrwigJRm/lbsTr
 TSbbFVHba8GGoBa64FHe80nV/c1J3rP/uD84Ybc3BmJn8VFmcL+nKf0QggHA6YzEO6qandWJg
 zaxAatuBxItJHEUOkK/xGpNFIQCsQBYFle1wJFgB9lmazQurNCqJzEZSryTenQHUzQVQWtGZo
 KLmUCTLz+1yo4uEilRULyk4bk5JX5NjaNzdkFzy0lHnOsoz0cd5VP5JpQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jdoobQugF0ZB98GInGZWttUedEOa0qcD
Content-Type: multipart/mixed; boundary="70ciu1Z9MSHDNodlSwrg8q1DWtAcSu53M";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Qu Wenruo <wqu@suse.com>
Message-ID: <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
 <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
 <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
In-Reply-To: <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>

--70ciu1Z9MSHDNodlSwrg8q1DWtAcSu53M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>>>
>>> Fundamentally, logical address space has no relevance in the user con=
text,
>>> so also I don=E2=80=99t understand your view on how anyone shall use =
the range::start
>>> even if there is no check?
>>
>> range::start =3D=3D bg_bytenr, range::len =3D bg_len to trim only a bg=
=2E
>>
>=20
>  Thanks for the efforts in explaining.
>=20
>  My point is- it should not be one single bg but it should rather be al=
l bg(s) in the specified range [start, length] so the %range.start=3D0 an=
d %range.length=3D<U64MAX/total_bytes> should trim all the bg(s).

That's the common usage, but it doesn't mean it's the only usage.

Above bg range trim is also a valid use case.

> May be your next question is- as we relocate the chunks how would the u=
ser ever know correct range.start to use? for which I don=E2=80=99t have =
an answer and the same question again applies to your proposal range.star=
t=3D[0 to U64MAX] as well.
>=20
>  So I am asking you again, even if you allow range.start=3D[0 to U64MAX=
] how will the user use it? Can you please explain?

There are a lot of tools to show the bg bytenr and usage of each bg.
It isn't a problem at all.

>=20
>=20
>> And that bg_bytenr is at 128T, since the fs has gone through several
>> balance.
>> But there is only one device, and its size is only 1T.
>>
>> Please tell me how to trim that block group only?
>>
>=20
>  Block groups are something internal the users don=E2=80=99t have to wo=
rry about it. The range is [0 to totalbytes] for start and [0 to U64MAX] =
for len is fair.

Nope, users sometimes care. Especially for the usage of each bg.

Furthermore, we have vusage/vrange filter for balance, so user is not
blocked from the whole bg thing.

>=20
>>>
>>> As in the man page it's ok to adjust the range internally, and as len=
gth
>>> can be up to U64MAX we can still trim beyond super_total_bytes?
>>
>> As I said already, super_total_bytes makes no sense in logical address=

>> space.
>=20
>  But super_total_bytes makes sense in the user land though, on the othe=
r hand logical address space which you are trying to expose to the user l=
and does not make sense to me.

Nope, super_total_bytes in fact makes no sense under most cases.
It doesn't even shows the up limit of usable space. (E.g. For all RADI1
profiles, it's only half the space at most. Even for all SINGLE
profiles, it doesn't account the 1M reserved space).

It's a good thing to detect device list corruption, but despite that, it
really doesn't make much sense.

For logical address space, as explains, we have tools (not in
btrfs-progs though) and interface (balance vrange filter) to take use of
them.

>=20
>> As super_total_bytes is just the sum of all devices, it's a device lay=
er
>> thing, nothing to do with logical address space.
>>
>> You're mixing logical bytenr with something not even a device physical=

>> offset, how can it be correct?
>>
>> Let me make it more clear, btrfs has its own logical address space
>> unrelated to whatever the devices mapping are.
>> It's always [0, U64_MAX], no matter how many devices there are.
>>
>> If btrfs is implemented using dm, it should be more clear.
>>
>> (single device btrfs)
>>          |
>> (dm linear, 0 ~ U64_MAX, virtual devices)<- that's logical address spa=
ce
>>  |   |   |    |
>>  |   |   |    \- (dm raid1, 1T ~ 1T + 128M, devid1 XXX, devid2 XXX)
>>  |   |   \------ (dm raid0, 2T ~ 2T + 1G, devid1 XXX, devid2 XXX)
>>  |   \---------- (dm raid1, 128G ~ 128G + 128M, devi1 XXX, devid xxx)
>>  \-------------- (dm raid0, 1M ~ 1M + 1G, devid1 xxx, devid2 xxx).
>>
>> If we're trim such fs layout, you tell me which offset you should use.=

>>
>=20
>  There is no perfect solution, the nearest solution I can think - map r=
ange.start and range.len to the physical disk range and search and discar=
d free spaces in that range.

Nope, that's way worse than current behavior.
See the above example, how did you pass devid? Above case is using RAID0
and RAID1 on two devices, how do you handle that?
Furthermore, btrfs can have different devices sizes for RAID profiles,
how to handle that them? Using super total bytes would easily exceed
every devices boundary.

Yes, the current behavior is not the perfect solution either, but you're
attacking from the wrong direction.
In fact, for allocated bgs, the current behavior is the best solution,
you can choose to trim any range and you have the tool like Hans'
python-btrfs.

The not-so-perfect part is about the unallocated range.
IIRC things like thin-provision LVM choose not to trim the unallocated
part, while btrfs choose to trim all the unallocated part.

If you're arguing how btrfs handles unallocated space, I have no word to
defend at all. But for the logical address part? I can't have more words
to spare.

Thanks,
Qu

> This idea may be ok for raids/linear profiles, but again as btrfs can r=
elocate the chunks its not perfect.
>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> The change log is also vague to me, doesn't explain why you are
>>>>> re-adding that check.
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>>       /*
>>>>>>        * NOTE: Don't truncate the range using super->total_bytes. =
 Bytenr of
>>>>>> --
>>>>>> 2.21.0 (Apple Git-120)
>=20


--70ciu1Z9MSHDNodlSwrg8q1DWtAcSu53M--

--8jdoobQugF0ZB98GInGZWttUedEOa0qcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1LuWcACgkQwj2R86El
/qirQgf/WSKJIQs0SSh8acITm3OPq2fBmHfQgb7kVGOQYsy+waKPXo2LkeD5rWTB
QtRUef322Tc53WgoOiRfgQnIWXrqFtitB9yexEOquintAiNXbzzA3iY9fHQZ7GY/
kqCveNKuryxmjhSrFH509M6kBCqI4bA7l0xm47mKxwyO2XhRNCDthYcK1UYHkYvF
8WagI73fZE6nxXiwAkgqe5RPLHfkI/jVgVVylp+aB82bEfyeGAmNW0slqClU/VlY
iV0+0eVX6MoU4rRysLtvirvsjwXPXYHf08iP2Apb5fkmfOV6ex2B7ZQDu98Oxwlg
t3dLTICceG30fVnUXx0a2THHL1VDgg==
=YoqG
-----END PGP SIGNATURE-----

--8jdoobQugF0ZB98GInGZWttUedEOa0qcD--
