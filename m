Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009979C408
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfHYNhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 09:37:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:57105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfHYNhN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 09:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566740225;
        bh=J2y2OK8TFtrLFOKF8KHymk2jDU+EDH8/yp14ebu4qdg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=INnDnpVVUH8Adc+/Tleuykiyha2ufaHPTIGa0XwGVSo/15vXmE2RtYO/YED+3l5oB
         Hh1Didk7I8KpY26s7B9FnlwUmTd1mPyJo42e3cTHvV26YhYy4vuD06/+9KtZiIf1ws
         2LehS4kSRQGVp1ohDTMlYcrOS1VYcm5iHOgRBByk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LZynd-1iVjrW0HpF-00llbH; Sun, 25
 Aug 2019 15:37:04 +0200
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
To:     Patrick Dijkgraaf <bolderbast@duckstad.net>,
        linux-btrfs@vger.kernel.org
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
 <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
 <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
 <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
 <2c681f5fd6ea3d8bc764416bad7da1f6f0665347.camel@duckstad.net>
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
Message-ID: <f1725975-9a05-e26c-db70-ae2295fff4ab@gmx.com>
Date:   Sun, 25 Aug 2019 21:36:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c681f5fd6ea3d8bc764416bad7da1f6f0665347.camel@duckstad.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LNDDNbYfjI8TAexiSozDK3iJyxOQrmn3P"
X-Provags-ID: V03:K1:p7RR/LEXf6dclmTJm4zQiqZRqUkYLVuMgHbP0/rc15ptcU15Uzw
 gu53vydGc6dQSKqJb/k1rcKftsYaX6VLMfVxsB/7xtl9emVpRlNIGVr2bfTIytKbMY60wT2
 JysqvHphDnP/XedCW8qp/uFCr3FFinDMmIYtva3g/MuhAQe6Bhyqo1L/c9Jv1D1s8Qvq2oX
 UM99LCZQqzAGcEPP58rog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VafLn1M6VFs=:TAagcJ/56IlDMZCeRB75ni
 02LEPZLo7dZyewYqKNpMiNjbS95J+UybFHbSXDHELPyfju7qKP4r+rxzhZQSFa/ThLhM+ydd9
 889v6cwmKhKcEtIkgjA1xDTLpNGHA1ZIqu9IN8tW1eu6K7LGh+Q55wg0JjI7IQMp5YBTSd7gy
 RHwopiZFI6TmRsHGmW+XGxQ2AyM/mIIjpILvTuumxOG/jo+Fv8iGoEKQzydpNKcDeWh4sTY4j
 LUS2x1Atsb4dfT81AsMql/AvyEiq88XHuayiD1qGyHrcgHUQwvtCPGGkE8rX4AwVE/VTCH2P9
 6a69RtokwfALn7NUyLDdjbWEjzTckjg0104iVOf+fWJ4fzqUUvUxYCW9tH2dAMJdvqxoyUo3k
 vKgfruD1Ru0ednfEqO0Blvgli5wcvNFf+529hg+TMQrF6ggbxrf7oqVacscVSMSD6UNTSUIxN
 XEo1d9Jt6yH+FSyee/iBjMfIYUodX2ahbbpuyJKCnWDs10PgpEIpIzwOCDJt5E/RRExuFSN+t
 8TVjfr+wEwnNS51+aYVF7/f+uUU2el4gkeAmeGWC5aEd6YGvEOKWza2KEUPHRemdREJt8AugZ
 Z9sRhiIdZrTNhuRwh6Ecc32GfE+rwJFIUKps+uChW4dntKGhZq/IoUcyyeGWZ6c0dBiX3s7LW
 uM7R293OriU7h4WPDSV+k5dhz6Ac2eVnJPEGccv5ms2ACf+ait52facP1J5HYaczeLYFBmIwI
 1Jl+KqEZ0ppINDNwJhFa0F8c8I99Wo8s4BgMW0xxCSwXH3Jwl+LvkCNwbCOcCuK0EYqAk/W7k
 POFVUoWD0aKXJUU3UXDgs1QAjLAP6lQ42+imH60kEESWaRJDpMsOoq+WvLQopAM34YOVFtXoY
 dJ5j45HqzNomQ6fpmNhI3VjVeVqIqBIlYNFLC1994nUZmlpasEn6rHo1s9vabUk62g5BrCEso
 IXWhYWVed+qm6xE5kuPAdD13YUfvMR5ex2d/j5YTeYUoSL+3XV6FGXWplvQytQqdzPvN/2w+W
 lhunt5wDfnBdfieKnJwfLbQbLihI4mV7LdpNw8XWW7GuNwicfg9UfSq94WftxahHk3bdghwt/
 6a42HuNeudxLra5VkgbByZ6x+4/0XG9K346BcdHm0omwB6DiCtoeIaYpA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LNDDNbYfjI8TAexiSozDK3iJyxOQrmn3P
Content-Type: multipart/mixed; boundary="NuxTd2rzg2OpJJ9O2K9taMS96c1mOGdaK";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Patrick Dijkgraaf <bolderbast@duckstad.net>, linux-btrfs@vger.kernel.org
Message-ID: <f1725975-9a05-e26c-db70-ae2295fff4ab@gmx.com>
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
 <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
 <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
 <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
 <2c681f5fd6ea3d8bc764416bad7da1f6f0665347.camel@duckstad.net>
In-Reply-To: <2c681f5fd6ea3d8bc764416bad7da1f6f0665347.camel@duckstad.net>

--NuxTd2rzg2OpJJ9O2K9taMS96c1mOGdaK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/25 =E4=B8=8B=E5=8D=882:41, Patrick Dijkgraaf wrote:
> Hi Qu,
>=20
> At the end of my first initial post, I mentioned that I finally was
> able to mount the volume using:
>=20
> mount -o usebackuproot,ro /dev/sdh2 /mnt/data
>=20
> The chunk tree and super blocks dumps were taken after that.
>=20
> Now I noticed that I was able to mount the volume without special
> options (same kernel version). YAY! =E2=98=BA
> Could it be that the "usebackuproot,ro" mount options already fixed the=

> issue?

Nope. It should be something wrong with the kernel code verifying the
total devices space.
As long as all your later mount is using ro, and no log tree replay
happened, the fs should not be modified.
It may be a race, but anyway, your on-disk data is completely valid, so
as long as your kernel is doing something correct, it should mount the fs=
=2E

Thanks,
Qu

>=20
> Cheers,
> Patrick
>=20
>=20
> On Sat, 2019-08-24 at 21:24 +0800, Qu Wenruo wrote:
>> On 2019/8/24 =E4=B8=8B=E5=8D=888:05, Patrick Dijkgraaf wrote:
>>> Thanks for the quick reply!
>>> See responses inline.
>>>
>>> On Sat, 2019-08-24 at 19:01 +0800, Qu Wenruo wrote:
>>>> On 2019/8/24 =E4=B8=8B=E5=8D=882:48, Patrick Dijkgraaf wrote:
>>>>> Hi all,
>>>>>
>>>>> My server hung this morning, and I had to hard-reset is. I did
>>>>> not
>>>>> apply any updates. After the reboot, my FS won't mount:
>>>>>
>>>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
>>>>> super_total_bytes
>>>>> 92017957797888 mismatch with fs_devices total_rw_bytes
>>>>> 184035915595776
>>>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to
>>>>> read
>>>>> chunk tree: -22
>>>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
>>>>> open_ctree
>>>>> failed
>>>>>
>>>>> However, running btrfs rescue shows:
>>>>> root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
>>>>> No device size related problem found
>>>>
>>>> That's strange.
>>>>
>>>> Would you please dump the chunk tree and super blocks?
>>>> # btrfs ins dump-super -fFa /dev/sdh2
>>>
>>> See:=20
>>> https://pastebin.com/f5Wn15sx
>>>
>>
>> Did a quick calculation, from your fi show result, it's 83.72TiB,
>> thus
>> the super total_bytes is correct.
>>
>> It's the kernel doing incorrect calculation for its
>> fs_devices->total_rw_bytes.
>>
>> This matches the output of dump-super. No wonder why btrfs-progs
>> refuse
>> to fix.
>>>> # btrfs ins dump-tree -t chunk /dev/sdh2
>>>
>>> This output is too large for pastebin. The output is
>>> viewable/downloadable here:=20
>>> https://kwek.duckstad.net/tree.txt
>>>
>>
>> This also proves your chunk tree is CORRECT!
>> The sum of all devices is 92017957797888, which matches with super
>> block.
>> [...]
>>>> The simplest way to fix it is to just update the
>>>
>>> Nice teaser! =F0=9F=98=89 What should I update?
>>
>> Sorry, I meant to say just update the "superblock", but it turns out,
>> it's something wrong with your kernel. Probably some old bug we fixed
>> before.
>>
>> Would you try to use latest ARCH kernel from an Archiso to try to
>> mount
>> it RO (just to be safe)?
>>
>> I checked latest v5.3-rc kernels, haven't found an obvious problem
>> with
>> the fs_devices->total_rw_bytes update routines.
>>
>> So it may be an old bug which is already fixed.
>>
>> Thanks,
>> Qu
>>
>>>> Thanks,
>>>> Qu
>>>>> Other info:
>>>>> [root@cornelis ~]# uname -r
>>>>> 4.18.16-arch1-1-ARCH
>>>>>
>>>>> I was able to mount is using:
>>>>> [root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2
>>>>> /mnt/data
>>>>>
>>>>> Now updating my backup, but I REALLY hope to get this fixed on
>>>>> the
>>>>> production server!
>>>>>
>>>
>>>
>=20
>=20


--NuxTd2rzg2OpJJ9O2K9taMS96c1mOGdaK--

--LNDDNbYfjI8TAexiSozDK3iJyxOQrmn3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1ijvoACgkQwj2R86El
/qhYYAf/R/M6LKWm6XzA46J59OqoFlzSsItQikr4MW78D4NWQOdEKu+Kr66+jH7L
tdLOJyGg5zx6BRm+2kunVXz57Hx0m49UqqMdfPzTmxgemvZkSYxINJQQtnX5b3W+
gRqgDBOpaaFgf5bk/exj5PsmZkYuToDwuqbvHwaVEeB3oVNwUwGnYGup5Z7ur95p
O5ekUueHu6wLT8u1z+P8lvlk31dSds3KDFBDmhcK2uDkqI+C1ekZcKXg5fTc1tJQ
Pk0PUNWW0ITo+OpTUb5C6rKkKODihNDuMyDtj2/TvBbNfcyzHzaTP+tFAi1QFhNh
xIkonB/5E0o8q0gFEM+k90izGOr5Zg==
=t3et
-----END PGP SIGNATURE-----

--LNDDNbYfjI8TAexiSozDK3iJyxOQrmn3P--
