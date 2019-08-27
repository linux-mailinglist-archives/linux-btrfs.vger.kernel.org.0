Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746D39E689
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfH0LL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:11:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:51211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfH0LLz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566904305;
        bh=FAOqeEbgQ5BCGR2PZNqaTdw/q4Pnt8Nl+edPVRRIpSU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VwZWsXhTww0l9Cewt3JkTyofyGbrN2D3NwjXxOtjxKNWf1xDRFz52DBDGflb15zKV
         o2wDUPEVd78plcb8+AfxWWoxoxKs/q/IXCtnsHcVmjxkZBcnEtFwR+hYSH3kAK6qEM
         M8OdfWrVm0+ow7kLxphH9ZjKRP+y24ohHoYodiuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bSt-1iBsf50cU7-010bCW; Tue, 27
 Aug 2019 13:11:44 +0200
Subject: Re: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in
 find_next_devid
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827074045.5563-2-anand.jain@oracle.com>
 <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
 <5b866472-0a12-78df-d8a3-d940caf755ef@oracle.com>
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
Message-ID: <7f933f89-4747-a0d0-32b7-3d084c10338a@gmx.com>
Date:   Tue, 27 Aug 2019 19:11:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5b866472-0a12-78df-d8a3-d940caf755ef@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bSemYku4saYjgSdCEUDvTyerSBi8r9jjk"
X-Provags-ID: V03:K1:WlpsPZgoLWhQJ7MK95bxU8cxvPim9Z6xuspE9CyL+3EHfJYMyGb
 mwzHeG1/DpM/igq9mgfhDAcD3466eSuvDb9BswVSlo2pQxNo4FiJFsmgZAtahQC2jLgZEGs
 /oMOvUNbGrGes8WovWBwgzeUny93NVi12Vo0uUCw5XWiAk3mALMAqTR8hhAMhMjnrsvgZhI
 Q6Fs+1M8ePl9Ehz7gow3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UToiM+mDDn4=:Zx0UwuCO56+Te4cj6ClbYM
 OjMDyUkNBS77hE69ZIKvSB7kB8Sj1/rShfJWdZQvQjrG29Enjrgjj2HF8+QAML/FdXHCozvlJ
 aytZyDgAjwleQKI0dxupnwHUwx+CNoh4dlZqitqM9LXVI0tje1gw0J/zjnFvdQH2ffHMnSLcP
 eldpzHm3YriX4n5/4xIb5G2X6HwMJid7ReYzOLkDez4Ms+PMZxxnqmGvdP1/BMHLpMWXJHDOo
 M2IhNOju/bdqfIfWIkOd6CppxntaNlxf4AMWsoYP1UyIWd+TT83ewUwKIzuEZUl+QmEcIaHS9
 i8E606jD/ssuJt2XZPXxpbmyPw5VQSEI6HTDB4byXBdaXaesx/MF5KAoT39TT8Nra9lrqD5jI
 yPGyU2R53Yor+gswLYcG0uQLpxe3nkVKxHeBoBJm33fNY4HyRmHYmnR/IHEZJj+JppEDaWweY
 o0oX8a4pT2049Mm4p11p3+POCQcHrNQOy/5qH48Ot+xrNoTahPrcn+kMf2kP43LMPZ7o2Fohl
 4rRwdg6sKsGyYzMG2uuMPrsMCvy4SM9waoM1S+6eCFBD464OjLMLfXLkl26nHhu1JgWkvJFkg
 TCYJk8PZQkkIQGs9vAmEf9kkNlSBo/APxpi67qMOvOM2vft/gA1OpsGedkUIxZ6zTISrXpuQb
 k4OdmpqGjLTjq9GU8JSU3madmW4MC45sBJdPVwlLCQWlpNeVnll37LCaH3Rid3MpdiKUNceTP
 OpWAGttBd8UuutooHhmd6sHeU5CJ8twLbPXMsHR1z099Abtq5rbnidEmzcG6tyj7Kfv6TDz5p
 D2XFulZgz+FQuBQRBVs3qD1JGSyTh6KF1ES7AJSpnFMjMAPOkTxmeAzO5JnsOCERxBjuUCHcq
 XVZHSh9sO4J9Aj7DI0mK2cw4pbm/qNmPyg9GPiVR3jvoStU2ssV7JlX/c8rPsegLBEDvdy1zk
 VpFHIoDp2xMTPkX+hP266084iJRQtNfbgO2a4La2agPvRmuIl0e9eGBr3JikTSkA+Xw0aCd3J
 WbD+4XY0Y1jmqHzKLb9p1wejLBMdPffDEig0+2BF7VppTmQBEWJuI/Jj7I0ctupatosx8N/yH
 jgZ9uwx+4O2ms9jPwQNBqo253S3O6qA2hA12Mm0VzHaeqv9MY2PGl51Gw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bSemYku4saYjgSdCEUDvTyerSBi8r9jjk
Content-Type: multipart/mixed; boundary="NzI1yCh9kfEQDi4zCuMrign5t0wVrdyFt";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <7f933f89-4747-a0d0-32b7-3d084c10338a@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in
 find_next_devid
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827074045.5563-2-anand.jain@oracle.com>
 <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
 <5b866472-0a12-78df-d8a3-d940caf755ef@oracle.com>
In-Reply-To: <5b866472-0a12-78df-d8a3-d940caf755ef@oracle.com>

--NzI1yCh9kfEQDi4zCuMrign5t0wVrdyFt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/27 =E4=B8=8B=E5=8D=885:58, Anand Jain wrote:
> On 27/8/19 4:12 PM, Qu Wenruo wrote:
>>
>>
>> On 2019/8/27 =E4=B8=8B=E5=8D=883:40, Anand Jain wrote:
>>> In a corrupted tree if search for next devid finds the device with
>>> devid =3D -1, then report the error -EUCLEAN back to the parent
>>> function to fail gracefully.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 fs/btrfs/volumes.c | 7 ++++++-
>>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 4db4a100c05b..36aa5f79fb6c 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1849,7 +1849,12 @@ static noinline int find_next_devid(struct
>>> btrfs_fs_info *fs_info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 BUG_ON(ret =3D=3D 0); /* Corruption */
>>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Corruption */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "corru=
pted chunk tree devid -1 matched");
>>
>> It will never hit this branch.
>>
>> As in tree checker, we have checked if the devid is so large that a
>> chunk item or system chunk array can't contain one.
>=20
> =C2=A0That check is buggy. It assumes devid represents the num_devices,=

> =C2=A0it does not account for the possible devid hole as created in the=

> =C2=A0below script.
>=20
> $ cat t
>=20
> umount /btrfs
> dev1=3D/dev/sdb
> dev2=3D/dev/sdc
> mkfs.btrfs -fq -dsingle -msingle $dev1
> mount $dev1 /btrfs
>=20
> _fail()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0echo $1
> =C2=A0=C2=A0=C2=A0=C2=A0exit 1
> }
>=20
> while true; do
> =C2=A0=C2=A0=C2=A0=C2=A0btrfs dev add -f $dev2 /btrfs || _fail "add fai=
led"
> =C2=A0=C2=A0=C2=A0=C2=A0btrfs dev del $dev1 /btrfs || _fail "del failed=
"
> =C2=A0=C2=A0=C2=A0=C2=A0dev_tmp=3D$dev1
> =C2=A0=C2=A0=C2=A0=C2=A0dev1=3D$dev2
> =C2=A0=C2=A0=C2=A0=C2=A0dev2=3D$dev_tmp
> done
>=20
> -----------------------
> [=C2=A0 185.446441] BTRFS critical (device sdb): corrupt leaf: root=3D3=

> block=3D313739198464 slot=3D1 devid=3D1 invalid devid: has=3D507 expect=
=3D[0, 506]
> [=C2=A0 185.446446] BTRFS error (device sdb): block=3D313739198464 writ=
e time
> tree block corruption detected
> [=C2=A0 185.446556] BTRFS: error (device sdb) in
> btrfs_commit_transaction:2268: errno=3D-5 IO failure (Error while writi=
ng
> out transaction)
> [=C2=A0 185.446559] BTRFS warning (device sdb): Skipping commit of abor=
ted
> transaction.
> [=C2=A0 185.446561] BTRFS: error (device sdb) in cleanup_transaction:18=
27:
> errno=3D-5 IO failure
> -----------------------

Oh, that's a case I haven't considered.

Great we can find a bug in a seemingly unrelated patch.

So the patch itself is OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
>=20
> Thanks, Anand
>=20
>=20
>> That limit is way smaller than (u64)-1.
>> Thus if we really have a key (DEV_ITEMS DEV_ITEM -1), it will be
>> rejected by tree-checker in the first place, thus you will get a ret =3D=
=3D
>> -EUCLEAN from previous btrfs_search_slot() call.
>>
>> Thanks,
>> Qu
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_previous_item(fs_=
info->chunk_root, path,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_DEV_ITEMS_OBJECTID,
>>>
>>
>=20


--NzI1yCh9kfEQDi4zCuMrign5t0wVrdyFt--

--bSemYku4saYjgSdCEUDvTyerSBi8r9jjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1lD+wACgkQwj2R86El
/qgSYgf+MuYrrjPM6WQmIUCbRPrhYabo1jr8oGgR0Cu8f3kHk+aqOek2yZNk9GIa
Tq6IPdv93Ol4ybBc8mrHDutFid8t8qIZ5tz0hCqkYfN3KSn7UkwmxrQfuoCMJLVG
TNRkMgjDkUYqTfA5Pn58IY/2JHdmR37YQ8bAOZ0s1tfCcJFq2+cwSlg6ngd08Q1F
fb0yaEaxxtM2DP8+2YjvAJ+6n4yqkbx/2+sCSCdTct6kiWf3/v1zqY4islTdkDSX
3ZhiM3jyH3yXheCPNoaqA8gPGsq7iaJCWlsKqFel/XTX7UqUr7ngjE2vMb6Awgsm
eaH5z4Nqr20ZnSt3GcGt6ewkR+yl0w==
=/wxJ
-----END PGP SIGNATURE-----

--bSemYku4saYjgSdCEUDvTyerSBi8r9jjk--
