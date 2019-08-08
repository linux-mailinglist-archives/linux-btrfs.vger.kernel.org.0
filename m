Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCA85D0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfHHIlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 04:41:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:36057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfHHIlj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 04:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565253664;
        bh=frJHzGaMSa0Kwmua/XsNFTmzbyC9HLVJWEEXt99h4dQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R27khXxWBiefnOiENfkwf5dypniEsfuaPYFrC/jyyEA3hnRfbH8Ym2+D2iRRIUxaA
         WtWwYMNjA7A7adMgqc1J4NZHB48MZiC0pQnvrxNSTnDIVQS9jPfKOxzCPQ+3e6K3ac
         DVRIIBhC8w20iWN34Z+ssgZXu3ZVe4wn/DdPMP1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MhRUQ-1hhqU1351O-00MdBv; Thu, 08
 Aug 2019 10:41:04 +0200
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
 <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
 <F6A06BCB-D2A7-4B9F-A6F4-04498572AEF5@oracle.com>
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
Message-ID: <1cdbf089-e97a-592a-b74b-dc3c3bca1683@gmx.com>
Date:   Thu, 8 Aug 2019 16:40:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F6A06BCB-D2A7-4B9F-A6F4-04498572AEF5@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R2qANiDk7BApXCSG4unyFceMRT45DiOLR"
X-Provags-ID: V03:K1:j4MclLNVX9YZUrXGw/sUHDUw+CZpIsq0OgaZFzOUg9FL99ly74k
 pKvTsn4j8zejs6bEPzhB26IMxL76VLP+cQhGhXJDsCVN3qcDrltYO6ktgcqXYse7lbTx3QE
 fe4f2FCRZq0UNjmaEc/v+V4Redq7WZexzPGUEiNBjHfCTEfGPk+46RfaMtkuZm/QC3kixF8
 Nh3CTqwNIlGJkvgjP8xmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tRG7Esl52pU=:CI40zjTnRjdq0vbTXTMIm0
 /PQzydKT6PnhR2Ssi2QlwJMMinz6EG7Vf2aW48rBrsCvqbbrJ1b7HrF3j+JHShr5lCkWXLDV6
 iZ7Q9oATe7tIQtdpbqmQ7fwfFgR5l8+PHGxgufjPrxZEP8jWqfaqV0PPpTsnoB2sgXi3IVzLZ
 EZDDptoviPmYQ5PHC/9W2lDkL3tCOJXU5+NX1JZBby3+QwsPGHJTGvziHY1O8KG9KH2z+l56w
 Kdd3KH+YhYx62YVAxEtiY0NRBBYkyOqupMgy38uPVMhtCP9UJjwz35CRcaE2lMFv1iEUZS8vf
 MyN9lNICdl1H7vemBSh62k8It3ewapHxLWuEsBDmsXCcSfKe5hwtJ9lGqVe0ICYjxIJDBqeVP
 nOqrTtWWBhKAFA40w92+08Q3yb36o2CdJvUNhuWyGeKzgAnPxMoJ8l8Pd6UfVFemLIk+CNjGT
 DH+sVgIImkz15Tu02I3dZ28ONgrVO6BM7KRo0g9+EqcGb+DdtPQB37W5TLUx/KFyHCBRGZlBm
 Zi33+9/0xzMmJDUzLl7HX9NG+RktvGucGPtAmvAz2qOM7meQbNpDIzbghKvhMKR+1Ts5NuVYc
 ceTmCk9rx5CCI8WSER2yOEYS4mxPONIshINnYY3j0teZDSmb4Hnuwu6mDBxnigLCfC0+ao3Kl
 JehGlBbhgMpv67EDDIo9YS0Kzhi6PrGJXIH3l44nucIKMCC4/cBfXfuX3kOB18lYdMVh3q00l
 VeOjk56BG01X1GiS8GyyQGuCr/nu8tud7BHZfsDR4f1R4q++nIJEiNNsJYdT5Qe1AWZemuRyE
 iziGYANsvlwLLG9HU98Eknx9DlXRCcYBtCpm+by4OsqRJ/YI+Xgiv+4uKnatfhwCqQUEIsrFN
 /IzfsOdG2KsWQPedNe/SA3Ksbz9XsmHYPTGomARJHhomFe5SiFhBiN1C2U1/Nd3KyKak3qXCW
 DXCBBA9ilfnOkcLtc2g1n64Mh6YOF/PgGiOJVGottxuyeDlmFKmhARJi+261BnVgJ5mvALNFA
 pe7jL0zfpcEI0k5sirzTV6ELCJ/aQsWTOBn1DlIsqgpYePgw/DYaUUcXrgVGH1z8EuhFW+nmM
 ETEqjyhvekpNawLsxdX9ZLc0uARSXz6UpRmYQcae4PSb7/+85aUPBcMzQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R2qANiDk7BApXCSG4unyFceMRT45DiOLR
Content-Type: multipart/mixed; boundary="wo7UGtnuyjxoIGJP9Hgih0U88hFkkZ6pq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Qu Wenruo <wqu@suse.com>
Message-ID: <1cdbf089-e97a-592a-b74b-dc3c3bca1683@gmx.com>
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
 <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
 <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
 <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
 <F6A06BCB-D2A7-4B9F-A6F4-04498572AEF5@oracle.com>
In-Reply-To: <F6A06BCB-D2A7-4B9F-A6F4-04498572AEF5@oracle.com>

--wo7UGtnuyjxoIGJP9Hgih0U88hFkkZ6pq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/8 =E4=B8=8B=E5=8D=884:34, Anand Jain wrote:
>=20
>=20
>> On 8 Aug 2019, at 1:55 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> [...]
>>>>>
>>>>> Fundamentally, logical address space has no relevance in the user c=
ontext,
>>>>> so also I don=E2=80=99t understand your view on how anyone shall us=
e the range::start
>>>>> even if there is no check?
>>>>
>>>> range::start =3D=3D bg_bytenr, range::len =3D bg_len to trim only a =
bg.
>>>>
>>>
>>> Thanks for the efforts in explaining.
>>>
>>> My point is- it should not be one single bg but it should rather be a=
ll bg(s) in the specified range [start, length] so the %range.start=3D0 a=
nd %range.length=3D<U64MAX/total_bytes> should trim all the bg(s).
>>
>> That's the common usage, but it doesn't mean it's the only usage.
>=20
>  Oh you are right. man page doesn=E2=80=99t restrict range.start to be =
within super_total_bytes. It's only generic/260 that it is trying to enfo=
rce.

This reminds me again about the test case update of generic/260.

It looks like my previous update is not yet merged...

Thanks,
Qu

>=20
>> Above bg range trim is also a valid use case.
>>
>>> May be your next question is- as we relocate the chunks how would the=
 user ever know correct range.start to use? for which I don=E2=80=99t hav=
e an answer and the same question again applies to your proposal range.st=
art=3D[0 to U64MAX] as well.
>>>
>>> So I am asking you again, even if you allow range.start=3D[0 to U64MA=
X] how will the user use it? Can you please explain?
>>
>> There are a lot of tools to show the bg bytenr and usage of each bg.
>> It isn't a problem at all.
>>
>=20
> External tools sounds better than some logic within kernel to perform s=
uch a transformations. Now I get your idea. My bad.
>=20
> I am withdrawing this patch.
>=20
> Thanks, Anand
>=20
>>>
>>>
>>>> And that bg_bytenr is at 128T, since the fs has gone through several=

>>>> balance.
>>>> But there is only one device, and its size is only 1T.
>>>>
>>>> Please tell me how to trim that block group only?
>>>>
>>>
>>> Block groups are something internal the users don=E2=80=99t have to w=
orry about it. The range is [0 to totalbytes] for start and [0 to U64MAX]=
 for len is fair.
>>
>> Nope, users sometimes care. Especially for the usage of each bg.
>>
>> Furthermore, we have vusage/vrange filter for balance, so user is not
>> blocked from the whole bg thing.
>>
>>>
>>>>>
>>>>> As in the man page it's ok to adjust the range internally, and as l=
ength
>>>>> can be up to U64MAX we can still trim beyond super_total_bytes?
>>>>
>>>> As I said already, super_total_bytes makes no sense in logical addre=
ss
>>>> space.
>>>
>>> But super_total_bytes makes sense in the user land though, on the oth=
er hand logical address space which you are trying to expose to the user =
land does not make sense to me.
>>
>> Nope, super_total_bytes in fact makes no sense under most cases.
>> It doesn't even shows the up limit of usable space. (E.g. For all RADI=
1
>> profiles, it's only half the space at most. Even for all SINGLE
>> profiles, it doesn't account the 1M reserved space).
>>
>> It's a good thing to detect device list corruption, but despite that, =
it
>> really doesn't make much sense.
>>
>> For logical address space, as explains, we have tools (not in
>> btrfs-progs though) and interface (balance vrange filter) to take use =
of
>> them.
>>
>>>
>>>> As super_total_bytes is just the sum of all devices, it's a device l=
ayer
>>>> thing, nothing to do with logical address space.
>>>>
>>>> You're mixing logical bytenr with something not even a device physic=
al
>>>> offset, how can it be correct?
>>>>
>>>> Let me make it more clear, btrfs has its own logical address space
>>>> unrelated to whatever the devices mapping are.
>>>> It's always [0, U64_MAX], no matter how many devices there are.
>>>>
>>>> If btrfs is implemented using dm, it should be more clear.
>>>>
>>>> (single device btrfs)
>>>>         |
>>>> (dm linear, 0 ~ U64_MAX, virtual devices)<- that's logical address s=
pace
>>>> |   |   |    |
>>>> |   |   |    \- (dm raid1, 1T ~ 1T + 128M, devid1 XXX, devid2 XXX)
>>>> |   |   \------ (dm raid0, 2T ~ 2T + 1G, devid1 XXX, devid2 XXX)
>>>> |   \---------- (dm raid1, 128G ~ 128G + 128M, devi1 XXX, devid xxx)=

>>>> \-------------- (dm raid0, 1M ~ 1M + 1G, devid1 xxx, devid2 xxx).
>>>>
>>>> If we're trim such fs layout, you tell me which offset you should us=
e.
>>>>
>>>
>>> There is no perfect solution, the nearest solution I can think - map =
range.start and range.len to the physical disk range and search and disca=
rd free spaces in that range.
>>
>> Nope, that's way worse than current behavior.
>> See the above example, how did you pass devid? Above case is using RAI=
D0
>> and RAID1 on two devices, how do you handle that?
>> Furthermore, btrfs can have different devices sizes for RAID profiles,=

>> how to handle that them? Using super total bytes would easily exceed
>> every devices boundary.
>>
>> Yes, the current behavior is not the perfect solution either, but you'=
re
>> attacking from the wrong direction.
>> In fact, for allocated bgs, the current behavior is the best solution,=

>> you can choose to trim any range and you have the tool like Hans'
>> python-btrfs.
>>
>> The not-so-perfect part is about the unallocated range.
>> IIRC things like thin-provision LVM choose not to trim the unallocated=

>> part, while btrfs choose to trim all the unallocated part.
>>
>> If you're arguing how btrfs handles unallocated space, I have no word =
to
>> defend at all. But for the logical address part? I can't have more wor=
ds
>> to spare.
>>
>> Thanks,
>> Qu
>>
>>> This idea may be ok for raids/linear profiles, but again as btrfs can=
 relocate the chunks its not perfect.
>>>
>>> Thanks, Anand
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks, Anand
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> The change log is also vague to me, doesn't explain why you are
>>>>>>> re-adding that check.
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>>
>>>>>>>>      /*
>>>>>>>>       * NOTE: Don't truncate the range using super->total_bytes.=
  Bytenr of
>>>>>>>> --
>>>>>>>> 2.21.0 (Apple Git-120)
>=20


--wo7UGtnuyjxoIGJP9Hgih0U88hFkkZ6pq--

--R2qANiDk7BApXCSG4unyFceMRT45DiOLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1L4BoACgkQwj2R86El
/qgHyQgAlCOJBaAHoG/Z2HMvqzbxD9gPqLlCz64W+984i2SbiD41omat+IvJobTE
XbOUlO0XfQACPuN93xOP5l3jdE3QwBbEs0MGWbZ4izAcHoEQ+Hok09j1yJOsF0wU
2P/9cPpH6e0EL/vF1TIMRM9Q1SVJJkhwTI4OWkuHTjy6mEmQ5P+ugo9SZH0l41da
R53ARBhCL8AMJ1W3froJswaPrVX61qTwmcua1E5uxq7UFMaFH40WctFyfMedtN75
26PBv+kh2Vner2y7sbfr9QTO23jb6DVZTSnT9p6bbegBQbPihONVs78yX8DLsCRB
4TvHIjrRcW1/LeJRj/0aW3iP2X7m5w==
=aVah
-----END PGP SIGNATURE-----

--R2qANiDk7BApXCSG4unyFceMRT45DiOLR--
