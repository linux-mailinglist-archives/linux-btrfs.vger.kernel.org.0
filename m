Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94F4C666
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFTFBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 01:01:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:57351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTFBC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 01:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561006856;
        bh=XmxvvMOddFXIiH4RgNbRJMX6JaMRKzciHeHmwgnRm1I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gTAm+CBEMFMVVQAdesiVGnYTngctezCyqN1Y4Vbh8Y6ogYZlSZN9iDLcgVnbmDgN0
         W0+6nbNeM+4mti9pq+wjprQIyVSGuhkkhdI5oKpGLaznsETCtbymPLyPPHHMvRcm7V
         i9MfBn5MxSeFNkdgjPbInVTTV7f5FJ5hp0WBJn28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MbgKD-1hwJwg0JWv-00J3bH; Thu, 20
 Jun 2019 07:00:56 +0200
Subject: Re: BTRFS recovery not possible
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Claudius Winkel <claudius@winca.de>
Cc:     linux-btrfs@vger.kernel.org
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
 <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
 <0c136862-4b3c-2459-62c6-44b8e92b2815@winca.de>
 <20190619234528.GA11831@hungrycats.org>
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
Message-ID: <3892ad8b-9fa8-bc6a-c855-d8e7814bbebf@gmx.com>
Date:   Thu, 20 Jun 2019 13:00:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619234528.GA11831@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MAI2Bq0JUM0s1gnMWKlMnFzp6PlqV0NgF"
X-Provags-ID: V03:K1:Xs6ahR96DZ7bfZIhlqpSRyY0Zfv+/26WKMutQ8zQOb8sWihREbG
 +U1wS7zXcZtdd/iO1ynP4ag4u10YLUAn86roR5p699cqRu7YaJ9elqkAzXPJKLyD8rt8fed
 7j+sZVSmliuZigyAFOjol7nCD9VDrzFRNk5BLqlTsechboUpL3ffBRo7McVXcBdkgV4IfCm
 5VqxKbZ1MEw1QuXdkE8cA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NX+/cc7Y2PY=:HBNceYZS2xJRk0087GMEmo
 ccamSDY38ehQOk5jeS/7dY8/5Jd5gkPILmsZSl//o2SIE1SoumIaEG60qVOFmXndMI60vKJwC
 RHTMol2AalkdeQnZxKs7e3sO8SWTTqKCmBolcr/+gLvCysecpqZ33L8lYl0+NAwtmo4rdziwm
 u0tcpFb+B3vFi7D+bRuLlLyeHTFtsvKWB50rktKYw1lzmkGb0aoY2wjFamMkUkDsyHIp3VpYa
 kynwfmxUkE+kunvvCzGChS41T6GcyhJZ8foloe/8Ose9WXq29v9v6673/6CbY3VU0KIj0W5dr
 AVZoaOx0kIV8E+wnVdf273FQlw+7Uf0TUlUtuyMnFwOBLwNpsoKqUQONl8uVhkepDAhiqz4u3
 zRgX3PAMxvMO2VsVyahGC4Z4d6FptHx9crv9kIGkYEkAve5N6YiKr84ofN8HkAaluJ1cClYGY
 4L9815BsuAo7/4sMtsTpzI1fmtvghubg+9YVhkz7d+zACKtniaSeItjJ6DyjrMVSgk8RZfAdE
 CNgi2E0UKRxQmC7fmyggEId/fHsiizVxd9dhc6WPcepMWCg0pGLW0v7dwEusmsiayXuTgR4nb
 PJ79x03FayndO4Fsiqgx0Md7bC02ShceMMt7xRjJE7u5EeEtfnJGZ5ubj78HD8GEjooIq1sb9
 MdVSffAS/yMj3FuW5c/BkF1/mzM6mOcgwgvex3SNItQ1obj4A6JAYoHPCH4AXu8ApG8L/UYNo
 2Ro+/dYAT5RwUqbNnko6DUe6bz/AobdZ/QlBQ659Z3IkC05Hl0rOTKC2PxWZV8hnEHJzR3bSz
 0OgZrnxtMmbPeQys46IVMsG1EHzCo2b7aM82201wH/YE4Ix3DnSvmEUc1KmGKocdkLIFJGCec
 f4jcNwGEDSr6fgM23Y1Z0PzneVtN9pMtKimnpyynFesh/ARDEm9U9BUZSRa+P1hTNOeFj7NEe
 EzqX5eZKzDAYEkWDBGWszWEAmxbjP8SQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MAI2Bq0JUM0s1gnMWKlMnFzp6PlqV0NgF
Content-Type: multipart/mixed; boundary="ntBKvL95RvXgv9aauevXxfxl8xA07yton";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
 Claudius Winkel <claudius@winca.de>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <3892ad8b-9fa8-bc6a-c855-d8e7814bbebf@gmx.com>
Subject: Re: BTRFS recovery not possible
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
 <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
 <0c136862-4b3c-2459-62c6-44b8e92b2815@winca.de>
 <20190619234528.GA11831@hungrycats.org>
In-Reply-To: <20190619234528.GA11831@hungrycats.org>

--ntBKvL95RvXgv9aauevXxfxl8xA07yton
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/20 =E4=B8=8A=E5=8D=887:45, Zygo Blaxell wrote:
> On Sun, Jun 16, 2019 at 12:05:21AM +0200, Claudius Winkel wrote:
>> Thanks for the Help
>>
>> I get my data back.
>>
>> But now I`m thinking... how did it come so far?
>>
>> Was it luks the dm-crypt?
>=20
> dm-crypt is fine.  dm-crypt is not a magical tool for creating data los=
s
> in Linux storage stacks.  I've never been able to prove dm-crypt ever
> lost any data on my watch, and I've been testing for that event for 10+=

> years (half of them on btrfs).
>=20
> dm-crypt's predecessors (e.g. cryptoloop) were notoriously underspecifi=
ed
> and buggy, but they are not dm-crypt.  Hopefully no modern distro still=

> offers these as an install option.
>=20
>> What did i do wrong? Old Ubuntu Kernel? ubuntu 18.04
>=20
> 4.15 isn't old enough for its age alone to cause the issues you
> encountered.
>=20
>> What should I do now ... to use btrfs safely? Should i not use it with=

>> DM-crypt
>=20
> You might need to disable write caching on your drives, i.e. hdparm -W0=
=2E

This is quite troublesome.

Disabling write cache normally means performance impact.

And disabling it normally would hide the true cause (if it's something
btrfs' fault).

>=20
> I have a few drives in my collection that don't have working write cach=
e.
> They are usually fine, but when otherwise minor failure events occur (e=
=2Eg.
> bad cables, bad power supply, failing UNC sectors) then the write cache=

> doesn't behave correctly, and any filesystem or database on the drive
> gets trashed.

Normally this shouldn't be the case, as long as the fs has correct
journal and flush/barrier.

If it's really the hardware to blame, then it means its flush/fua is not
implemented properly at all, thus the possibility of a single power loss
leading to corruption should be VERY VERY high.

>  This isn't normal behavior, but the problem does affect
> the default configuration of some popular mid-range drive models from
> top-3 hard disk vendors, so it's quite common.

Would you like to share the info and test methodology to determine it's
the device to blame? (maybe in another thread)

Your idea on hardware's faulty FLUSH/FUA implementation could definitely
cause exactly the same problem, but the last time I asked similar
problem to fs-devel, there is no proof for such possibility.

The problem is always a ghost to chase, extra info would greatly help us
to pin it down.

Thanks,
Qu

>=20
> After turning off write caching, btrfs can keep running on these proble=
m
> drive models until they get too old and broken to spin up any more.
> With write caching turned on, these drive models will eat a btrfs every=

> few months.
>=20
>=20
>> Or even use ZFS instead...
>>
>> Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
>>>
>>> On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
>>>> HI Guys,
>>>>
>>>> you are my last try. I was so happy to use BTRFS but now i really ha=
te
>>>> it....
>>>>
>>>>
>>>> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2=
019
>>>> x86_64 x86_64 x86_64 GNU/Linux
>>>> btrfs-progs v4.15.1
>>> So old kernel and old progs.
>>>
>>>> btrfs fi show
>>>> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes=
 used 4.58TiB
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
1 size 7.28TiB used 4.59TiB path /dev/mapper/volume1
>>>>
>>>>
>>>> dmesg
>>>>
>>>> [57501.267526] BTRFS info (device dm-5): trying to use backup root a=
t
>>>> mount time
>>>> [57501.267528] BTRFS info (device dm-5): disk space caching is enabl=
ed
>>>> [57501.267529] BTRFS info (device dm-5): has skinny extents
>>>> [57507.511830] BTRFS error (device dm-5): parent transid verify fail=
ed
>>>> on 2069131051008 wanted 4240 found 5115
>>> Some metadata CoW is not recorded correctly.
>>>
>>> Hopes you didn't every try any btrfs check --repair|--init-* or anyth=
ing
>>> other than --readonly.
>>> As there is a long exiting bug in btrfs-progs which could cause simil=
ar
>>> corruption.
>>>
>>>
>>>
>>>> [57507.518764] BTRFS error (device dm-5): parent transid verify fail=
ed
>>>> on 2069131051008 wanted 4240 found 5115
>>>> [57507.519265] BTRFS error (device dm-5): failed to read block group=
s: -5
>>>> [57507.605939] BTRFS error (device dm-5): open_ctree failed
>>>>
>>>>
>>>> btrfs check /dev/mapper/volume1
>>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115=

>>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115=

>>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115=

>>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115=

>>>> Ignoring transid failure
>>>> extent buffer leak: start 2024985772032 len 16384
>>>> ERROR: cannot open file system
>>>>
>>>>
>>>>
>>>> im not able to mount it anymore.
>>>>
>>>>
>>>> I found the drive in RO the other day and realized somthing was wron=
g
>>>> ... i did a reboot and now i cant mount anmyore
>>> Btrfs extent tree must has been corrupted at that time.
>>>
>>> Full recovery back to fully RW mountable fs doesn't look possible.
>>> As metadata CoW is completely screwed up in this case.
>>>
>>> Either you could use btrfs-restore to try to restore the data into
>>> another location.
>>>
>>> Or try my kernel branch:
>>> https://github.com/adam900710/linux/tree/rescue_options
>>>
>>> It's an older branch based on v5.1-rc4.
>>> But it has some extra new mount options.
>>> For your case, you need to compile the kernel, then mount it with "-o=

>>> ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
>>>
>>> If it mounts (as RO), then do all your salvage.
>>> It should be a faster than btrfs-restore, and you can use all your
>>> regular tool to backup.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> any help


--ntBKvL95RvXgv9aauevXxfxl8xA07yton--

--MAI2Bq0JUM0s1gnMWKlMnFzp6PlqV0NgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0LEwIACgkQwj2R86El
/qi5Owf9FsIhnNRiGmtWvwPIkarZD6uhFXR6Hc8r+Fm/6OW6pZJRXZ6Qwys5EIqq
mwakXyVfUV1JHF7oTYic7m4K3lOjRBwvhXy8a3hra3sU5Asi/NZz1qSYxD1D6WKh
VSU7CtQv70HIea82j/y7yhjz/3SpvXn4hwAwmb0wsclDeDYTJ84++4rFELbmeZIo
ct8eFsZpFQyynXbxuKJylSyLgowcYhzWFWISSHjNdIUUbant4xxfdOj3qpfEAYxf
hEp0w+QRt7Jj8JNS0tz7k2i7COgm3qTM1hlQsPlqO82ZMeBmETNOdrieKvrSXVEd
WYdoCVqhyAk4ESgPhZzJ8lOc12MjrQ==
=R8oA
-----END PGP SIGNATURE-----

--MAI2Bq0JUM0s1gnMWKlMnFzp6PlqV0NgF--
