Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8415FC93
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 05:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBOE36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 23:29:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:36127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgBOE36 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 23:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581740995;
        bh=5wnxuq+x0CfZhCGbGDrE3lrqHHDaebrWI2Jf73Dd3iw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MfVgy/zssSd8qu+wsdtAYHi/kCzmtaU1YfMHAnTF21VHROwkUz/kUq4+DRlEScMlZ
         BeysvIls3L3WRrm0nc0e2uOmp52RFkuMpszxp4pPhqoB0ATurKJXha0+IIRI9Jv65h
         jL2U9VaLFDcznUag/A7qyvbrn4TQj2/vxTQ8edS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1joD4g2P5g-00nlhW; Sat, 15
 Feb 2020 05:29:55 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
 <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com>
 <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
 <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
 <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
 <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com>
 <CAEOGEKHARKKSYMEU5kbswA7-PjxT9xAOomktG32h9RS6aYUVjA@mail.gmail.com>
 <8d8be3c5-e186-d1d5-c270-da22c61f1495@gmx.com>
 <CAEOGEKHrN_i2fSb=iWY3yCLRjCuU1Hn08trCyg0Br9fJasjK6A@mail.gmail.com>
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
Message-ID: <b52cfa2d-ba1b-f013-c0f0-5c0cd0008210@gmx.com>
Date:   Sat, 15 Feb 2020 12:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKHrN_i2fSb=iWY3yCLRjCuU1Hn08trCyg0Br9fJasjK6A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="abMO3Y1zZQhC2c10ENY6azvDhCqHgm8DH"
X-Provags-ID: V03:K1:+1BBjn4pwkEABcnT9HF9d2auPTCikDyBuwpKBgHHE99wVRl97Qm
 wn015myZUGWq/U6sFFF9DrsbH0MA95w4/j0ia0GEnEVdcPGUI/wyxnVGGDh374DK3scRLSX
 wgC9KKsPLiXn+zwM3ozXBjzsgU6EqM3fMtumqdrtiP+t+BF38morc4krWbLPCNQ/Gboyr21
 dH9q5VN1/clSDXBmzqOOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmvuZNQXv4E=:OAhbXKGKJd85XUj4UNQJEV
 lgzh9GDfFmEW6Fpimlv4n/SN7D3ymL801txdwFL01XE7qswXuYxePayrjb3jP1+szSYqYsQ2z
 dU8t2Br+Ne25tsHepoSCGs2ydq3+k63QY2eZ63gNruMWi7iRLRy9EhFIZWQIxqu/sOlw3xV5c
 PIsxUKkyz3XIpz0RH7g0O7u/LDtlgwo1/VjfUlG6p6yq+Xe6J+rKu9YsOySwYFgYwEXt7Ob8R
 wz5qHjlG4Rp27WPfv80ALXdQUjHlMLEZjTKnJUAnv4tSZO5LdvjH4/Wcmeu/66dY+ddTjtMy3
 pLfNqjK6HEUXnjmAiLPhBIgBuMh9f+Ff9hDZIZVxyHP0viOGTfJ9+/y4ffQqLemZgPdeFg8AB
 nDaf9X2GUE2S1Wf8E4yzANiCFsV6kEZVI5LBMXB7URejbkhpxZP3hComm5WccBhgOXLaKnTDa
 BlaURQLzA622mDUP4d3qudT18Ltvh+cl1pdpd3baSCC9FlJZ4are+ZP4wL5vjkU3iNa1bK7wD
 3CmNQw54IzANVwKJ7pz1iDOb8Kab4VmbEFySp4UnZxOzzpgC5MZjMYP5H8c4h5LV7z09MqF3r
 uzGHfFilCF5lojWNvMWlVEIuZkM9DVT26EqJnwcEmG62edyIXzjbeUo2ML83Ms0NNOxDeBy1w
 wg4CwLQ4/DvOTkJxDn/eDqAq9/q6vHmWmFmQIlOYJoAErfvo/zUs9Y9wYPsMsdYPA7WM8lPKv
 sNaudP2AvOVEPt3VEpbQMj+yeJOswdTVDr30AmZHUSMBc9twm7mO7fPY62UUbrVTVpCposcTG
 5nI6NKFspGhOboVikWzgx6b6imIVaGXKpy0iEndI0Jq67QNBzO7y6Tb8MR5MLpIYOIaBydrb4
 5KjJz5Ynvky7DsgvOe7itUbvnEJ/UU1NlqDANRscHgvn6DY0Hgj7+gVwff2zm8ZZDuC0JZbMB
 nKTg9TcT0PCP/+bS4e11UTs7fB3FnsLNNiTeFOGE4dNnMEXCCBfRYG7mhx9MSb7GwdVc9kLsf
 ZKhqtL0fAg2r2eKK9H7PIm3Tg1r3SHEFB8wA42oDYgZaCm1kBPqKzUllajdCkWudC+R3kcZOq
 M10Kf2VnZYgzEDbDnCGu0VFfrkVb+dfa/X9jhxZrYCQvPD/NfNv4/g+S8WU1jglQJ8MKl+F9L
 DAlosBrZxLDYUOwvRpvNttv54G32w2/5FfoP0Vbn6+bDvBAXaDhZkParUREmqneA5ArDSxyM/
 WyXtrUMla4MS9UMk4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abMO3Y1zZQhC2c10ENY6azvDhCqHgm8DH
Content-Type: multipart/mixed; boundary="b7TgrOAjPIOo2VjpiUI2XYlZuvlzSLG8v"

--b7TgrOAjPIOo2VjpiUI2XYlZuvlzSLG8v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/15 =E4=B8=8A=E5=8D=8811:47, Chiung-Ming Huang wrote:
> Hi Qu
>=20
> Thanks for your reply. That's really helpful. BTW, I just read this url=
 and
> the mail thread in it. https://unix.stackexchange.com/a/345972
> It seems to say if raid1 is degraded and even if rw, it should not be a=
pplied
> any operations other than btrfs-replace or btrfs-balance.

That would be the best case.

>=20
> Does it mean the degraded raid1 should not be used with both
> btrfs-replace/balance and the original server rw services at the meanti=
me?

No, as long as the fs is still mounted, degraded RAID1 can be pretty
safe in fact.
At least to me, all the problem happen when we try to mount the fs again
using a mix of up-to-date disks with out-of-data disk.

For running degraded fs, btrfs knows which device is missing, it just
submit read/write to existing devices, and replace/balance can all
handle the case where.

>=20
> For example, I put PostgreSQL DB on btrfs raid1 and I though one of rai=
d1
> two copies is my backup. Even if I lost one copy, the service still can=
 keep
> running by another one immediately. Okay, maybe not immediately. I need=

> to reboot.

You'd better not to reboot, at least not reboot directly to normal
running status, with the bad disk attached.

> But waiting 24 hours or longer which depends on the size of data
> for the completion of btrfs-replace/balance seems not to be a good idea=
=2E

Btrfs-replace works just like scrub, which can only copying/verify data
on certain disk. It's not rewriting/verifying the whole fs, but I
understand that it can be very slow.

For btrfs-replace, you can just run the replace in the background.
Replace has extra protection to avoid data out-of-sync.

In short, for your case, it looks the problem is between some of your
degraded mount which screwed up some metadata blocks due to metadata out
of sync.

To avoid such problem, it may be a good idea to allow btrfs to use
superblock generation to find out which device is out-of-data, and do
self re-silver or at least avoid reading data/meta from the old device.
But that feature will need extra consideration before we even trying to
implement.

So currently my only practical recommendation would be, if you find one
disk failing, please remove it completely and ensure it will never show
up before remount the fs.
Then you can safely replace/remount.

Thanks,
Qu
>=20
> Regards,
> Chiung-Ming Huang
>=20
> Regards,
> Chiung-Ming Huang
>=20
>=20
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:03=E5=AF=AB=E9=81=93=EF=BC=9A=

>>
>>
>>
>> On 2020/2/10 =E4=B8=8B=E5=8D=882:50, Chiung-Ming Huang wrote:
>>> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
>>>>
>>>>
>>>>
>>>> On 2020/2/7 =E4=B8=8B=E5=8D=882:16, Chiung-Ming Huang wrote:
>>>>> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=88=
7=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
>>>>>>
>>>>>> All these subvolumes had a missing root dir. That's not good eithe=
r.
>>>>>> I guess btrfs-restore is your last chance, or RO mount with my
>>>>>> rescue=3Dskipbg patchset:
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D17=
0715
>>>>>>
>>>>>
>>>>> Is it possible to use original disks to keep the restored data safe=
ly?
>>>>> I would like
>>>>> to restore the data of /dev/bcache3 to the new btrfs RAID0 at the f=
irst and then
>>>>> add it to the new btrfs RAID0. Does `btrfs restore` need metadata o=
r something
>>>>> in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?
>>>>
>>>> Devid 1 (bcache 2) seems OK to be missing, as all its data and metad=
ata
>>>> are in RAID1.
>>>>
>>>> But it's strongly recommended to test without wiping bcache2, to mak=
e
>>>> sure btrfs-restore can salvage enough data, then wipeing bcache2.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Is it possible to shrink the size of bcache2 btrfs without making
>>> everything worse?
>>> I need more disk space but I still need bcache2 itself.
>>
>> That is kinda possible, but please keep in mind that, even in the best=

>> case, it still needs to write some (very small amount) metadata into t=
he
>> fs, thus I can't ensure it won't make things worse, or even possible
>> without falling back to RO.
>>
>> You need to dump the device extent tree, to determine the where the la=
st
>> dev extent is for each device, then shrink to that size.
>>
>> Some example here:
>>
>> # btrfs ins dump-tree -t dev /dev/nvme/btrfs
>> ...
>>
>>         item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48=

>>                 dev extent chunk_tree 3
>>                 chunk_objectid 256 chunk_offset 2169503744 length 1073=
741824
>>                 chunk_tree_uuid 00000000-0000-0000-0000-000000000000
>>
>> Here for the key, 1 means devid 1, 2169503744 means where the device
>> extent starts at. 1073741824 is the length of the device extent.
>>
>> In above case, the device with devid 1 can be resized to 2169503744 +
>> 1073741824, without relocating any data/metadata.
>>
>> # time btrfs fi resize 1:3243245568 /mnt/btrfs/
>> Resize '/mnt/btrfs/' of '1:3243245568'
>>
>> real    0m0.013s
>> user    0m0.006s
>> sys     0m0.004s
>>
>> And the dump-tree shows the same last device extent:
>> ...
>>         item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48=

>>                 dev extent chunk_tree 3
>>                 chunk_objectid 256 chunk_offset 2169503744 length 1073=
741824
>>                 chunk_tree_uuid 00000000-0000-0000-0000-000000000000
>>
>> (Maybe it's a good time to implement some like fast shrink for btrfs-p=
rogs)
>>
>> Of course, after resizing btrfs, you still need to resize bcache, but
>> that's not related to btrfs (and I am not familiar with bcache either)=
=2E
>>
>> Thanks,
>> Qu
>>
>>>
>>> Regards,
>>> Chiung-Ming Huang
>>>
>>>
>>>>>
>>>>> /dev/bcache2, ID: 1
>>>>>    Device size:             9.09TiB
>>>>>    Device slack:              0.00B
>>>>>    Data,RAID1:              3.93TiB
>>>>>    Metadata,RAID1:          2.00GiB
>>>>>    System,RAID1:           32.00MiB
>>>>>    Unallocated:             5.16TiB
>>>>>
>>>>> /dev/bcache3, ID: 3
>>>>>    Device size:             2.73TiB
>>>>>    Device slack:              0.00B
>>>>>    Data,single:           378.00GiB
>>>>>    Data,RAID1:            355.00GiB
>>>>>    Metadata,single:         2.00GiB
>>>>>    Metadata,RAID1:         11.00GiB
>>>>>    Unallocated:             2.00TiB
>>>>>
>>>>> /dev/bcache4, ID: 5
>>>>>    Device size:             9.09TiB
>>>>>    Device slack:              0.00B
>>>>>    Data,single:             2.93TiB
>>>>>    Data,RAID1:              4.15TiB
>>>>>    Metadata,single:         6.00GiB
>>>>>    Metadata,RAID1:         11.00GiB
>>>>>    System,RAID1:           32.00MiB
>>>>>    Unallocated:             2.00TiB
>>>>>
>>>>> Regards,
>>>>> Chiung-Ming Huang
>>>>>
>>>>
>>


--b7TgrOAjPIOo2VjpiUI2XYlZuvlzSLG8v--

--abMO3Y1zZQhC2c10ENY6azvDhCqHgm8DH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Hc78ACgkQwj2R86El
/qgwZggAjYyyQh0RgtX3UbZmAqBsRmLeESJcnXNeAhV/aDIP5VRoicBtwVgieBT4
WaJaHvmF17vtm4/OGjNupvDjh9FSL9xYwcqY2U8gaenDLnYKX/xxSTluvTQq/dxP
6qBk7okHK6UYGhiBxukCGGTci0S2VfFLL+mtD73t2N3Nt/sJnlRhKk5I7G7984gj
hHduT4INJrKJW9YTcU6xFE+eN4H7ewslB1cTrK/ONM6ITqzZDbe/TnGYOE7GI+cT
Gy8EBBJ4ta10vePSjKqgEOGS5UBf4tlBjg2c2I/YgPAaabNirIIuyhJNI2D7Wady
rnb4dfB3It3jIWEVYkRo4yeqcHLt2g==
=IG5r
-----END PGP SIGNATURE-----

--abMO3Y1zZQhC2c10ENY6azvDhCqHgm8DH--
