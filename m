Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06CC1435D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 04:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUDF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 22:05:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:53539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgAUDF4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 22:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579575954;
        bh=DWVPv100e+rr2QwjjB6x9sX9TP+yskcl9xbAAt/Arqo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bo9PNPydbqFFXmMIPE+26t9lsEa5gW09N6+XS8C+qgg+nSDPfktCVA1ro5hc91Y7f
         VWc9zx7IQK+NKssn0cjblwHG8X9UXy9foZNwUcEP9A3KzuNBWSyhuZCfHdXmw+8CX5
         DlqRoIFS59uGIb2Sm5n/5yg2qyOBmbmtxJJ3fdXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm6F-1irElO14DD-00GKSF; Tue, 21
 Jan 2020 04:05:53 +0100
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
 <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com>
 <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
 <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com>
 <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
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
Message-ID: <226182ca-e389-2506-1751-79b7d0b4ec24@gmx.com>
Date:   Tue, 21 Jan 2020 11:05:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7L1CC9dUByzetxDKSuBcusaE5WUMGIaGH"
X-Provags-ID: V03:K1:hRuKu8vn7R/OjvLEHtNkLWyd12rgsrKX6nsaUOBr/s8boqZ1tFC
 v5UvVVOW9N5ymeeEGqQL2l35+0E4SwOHSFAi81C2fj8WaXGwayAbCm0Inf7ps6wj5+8oJtP
 62TtZgSESkVoTwaC1akQRaqgHupYHZW++rt/szU226GDS+Up3XdSP99FVH2dgB+xQKnvxd9
 1NNoM7hjKzJrNQvLC5qug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYuY92ApNd4=:BbK2Ug7W7SgDIAfiIUor8B
 d++JEEaDZaU/jaciJqK0NaCP3yWlufJMM8ovC47WXoeHZAhFkpzmkG88BWlUVoVEZtoOCPJAO
 1MGGNBpS4nfSM31TqBln3Gte6u4Hb/9TQKQjf1BzT/coPNk4JkrMWFhxncHfrrXZMQR1aGcXu
 7UGOx/dKUn1FnUpAYnE833BfB9NVCTFqjdy5ctJAT3LzqH00rH0BkVOlccARWDRmrc7WxuzQX
 FsO8X0Znwu0QuXgNUu/V8UGHdNQ2VOAxIvTemA8vUuZKUj7RhzBNT/IOhTujgqrHTbFDDd9TG
 K+vgQRyS+OlO5fpECW++ocupCSzYm+/2i835WKWrKyM8rjbc10anmU0pUKu0kximLFUUOjNvn
 CSe7ss0/35EO/5mmNmvTLzkUIrjcQhL/7sysg2YZSQjnpG4ybcy1txK2VJPDfRBtTnMY27loo
 yTA2QKwXexAnGAMcQ4CudutBAwHiuGG71aSQqEo+nhggenkn9kauIXoxEU7PSv/GiFiBW+5+l
 +8SNKebzVWX8X/ZfhWvV+RgCUwK0MUe6Gb95frreXuommgWpgcahW/+/aJvkb15vHcFuOvWxA
 pa0/ZubC0z+2FLtXHjYuik9E+1uF4eb+z5IKMA/7+pAxostw8e2ULaKSX1AhvQatGUPxnKmRK
 5ilfKDsHYX3Hzz5cELdbLKOFp6EsU9Di7BssHUeGSsnm6S+3aGfjomHLfKquVd2G+D4GWeci0
 g4NQpNTlmlJvIpOc8fc0rAHKnuYbPN8z6VXPvYo/mRYoouJBVnGXxyW/5Mbey2d9p/qwjzTAQ
 DX3rB72BRAZKjLTFm2Ml0filCR3jtb0JkppN09Erz4/LwNVfNygfIy2qgUZ5y1u7se5N8ns36
 PRgQtFMDNTAh3PND4SdiAXHL+apQ19JO9MV1eCb1RcAoS/CgRMYX1NdqW8BUyMUubmzIpXz8H
 Cq6TVq/7C5PJn/8dtkrIGDdfvMUbPPQzusITxCZL9pIm3XcVGuRUbmme+DjbbQB3oKaEdN1ud
 PVzDT8INdRm2aVTbcLme7rNBcqct1Z36mWNA3/Vm2pRVQcpUmC/FsqEc1VhMJcls8LqV7jMs7
 kfSf2lKWxltyjL6h16XcaYBQ1Nd9yLAKrkzWCj8BaHQzJpqwhhCEhvAtM6lZ5jYtZAFPsXU/a
 yydR+nb89j7c7YC8NN6+FJknvk1nhBHjzr1YGZk8KqG/iHu0nQpVU/uV+mb5nWVRSSeLeerYY
 aTIsqPmLY1b1udhscDQCB38XVTLeF0rU2je6QdEYhatcC7amigA10VpxuGbA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7L1CC9dUByzetxDKSuBcusaE5WUMGIaGH
Content-Type: multipart/mixed; boundary="tRPFHE1Pik7prWv0soALqGQ40K6z02uMh"

--tRPFHE1Pik7prWv0soALqGQ40K6z02uMh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/21 =E4=B8=8A=E5=8D=8810:58, Robbie Smith wrote:
[...]
>>
>> Really hard to say, there are at least 3 things related to this proble=
m.
>>
>> - Btrfs itself
>> - Hibernation
>> - Dm-crypt (less possible)
>>
>> For btrfs, if you have used kernel between version v5.2.0 and v5.2.15,=

>> then it's possible the fs is already corrupted but not detected.
>>
>> For the hibernation part, Linux is not the best place to utilize it fo=
r
>> the first place.
>> (My ThinkPad X1 Carbon 6th suffers from hibernation, so I rarely use
>> suspension/hiberation)
>>
>> Since linux development is mostly server oriented, such daily consumer=

>> operation may not be that well tested.
>>
>> Things like Windows updating certain firmware could break the controll=
er
>> behavior and cause unexpected behavior.
>>
>> So my personal recommendation is, to avoid hibernation/suspension, use=

>> Windows as little as possible.
>>
>> Thanks,
>> Qu
>=20
> Suspension works flawlessly for me, and hibernation usually does as
> well. The one thing that has happened both times I've had a failure
> has been something weird with the power: first time was a static shock
> from walking on carpet and then touching the laptop, second time was
> the BIOS reporting a wattage error with the charger.

This doesn't look correct for ThinkPad T series machine...

>=20
> I tried mounting the FS from a live USB and the mount said: "can't
> read superblock on /dev/mapper/cryptroot" in addition to the transid
> failures. Should I try running a `btrfs check --repair`? At this point
> I'm pretty much resigned to reinstalling today, so I can't make things
> any worse, can I?

Full output please.

>=20
> I've also used kernel between version 5.2.0 and 5.2.15 on both my
> machines, so does that mean there's a risk of undetected disk errors
> on my desktop as well?

It's possible.

> I don't have backups of my backups, and all my
> drives use BTRFS because I like the subvolume/snapshot features. I
> also don't have a backup of my music/video library because I don't
> have another 5 TB HDD.

You can just run "btrfs check" from a liveUSB to check if the fs is OK.

Thanks,
Qu


--tRPFHE1Pik7prWv0soALqGQ40K6z02uMh--

--7L1CC9dUByzetxDKSuBcusaE5WUMGIaGH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mao4ACgkQwj2R86El
/qhDYggAkNYBpJm+suVTA30BGhJMP7Xhi8zQ+d1zz6jVtrs0/2lK9U6b8UCKcKX2
/Me6NDp+W3pGkABADf5wWlRFLhZ3+9Yt8Aky8I/QqmFRYODdnSQt7S2sGGPhZjlZ
qyCezP/inaysaqYkQFWPFj3QaUnr8bHA1eQb8BTps1u8TBKseSLCcU1Fu59QytbC
ppXeM/X4/vJmwMmkrRozFNtN//M5f/gY6Xws9wop/s5HGQelYFvkZWNjUEfLNd99
jvt5qR27iuHKAFqPXr3J/7Fjwb3C0EixjJYnmWLwuLQcyE7SV20zcPN6ISOAq2kz
1CA/UAMluy4FSM14VsdNe0TZAocAFA==
=0Ht4
-----END PGP SIGNATURE-----

--7L1CC9dUByzetxDKSuBcusaE5WUMGIaGH--
