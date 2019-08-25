Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C059C691
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfHYXvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 19:51:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:41129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfHYXvo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 19:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566777103;
        bh=MrgQoss6ZKF7QFhWHAEiKKJHFkFSDEKDbxy+ZONF614=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kd4PCo5yDxoXhMve39zbDZDjJWlK0YcJeShyIjT4KBEYJL+kr1drnJ3OTfH03NrDT
         oqwtY65ck707ZFmwbm9avbv28WASgTnfaUasTlvSG307twyWSe9gfDATG6eZdMSj/q
         H0vRkuHv93tCpb/JihydJ7AJqkQtQMT4wz3nAIlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LzLJR-1iFBRX0OZN-014WSv; Mon, 26
 Aug 2019 01:51:42 +0200
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
To:     Daniel Clarke <dan@e-dan.co.uk>, linux-btrfs@vger.kernel.org
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
 <cafc855e-b030-83ff-2984-dfb45a36d1b3@gmx.com>
 <CAP-b2nPJE_=957ARh+JMzOkVg4E_A_tAJPiN0e1BTyCLTZ=Jhw@mail.gmail.com>
 <55f9d2ff-b6b0-7f13-287e-c9916c57943f@gmx.com>
 <CAP-b2nM=s07wA0Yb9XQvea_ULZ=kui0UZNddGDa_gfd1C_m7qQ@mail.gmail.com>
 <CAP-b2nNzzjsAbJGAi=R0yk6qvQ-bRM3__k-NBCb+oko7Ume+kQ@mail.gmail.com>
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
Message-ID: <2846a423-ba1e-698d-6369-f9588223bb94@gmx.com>
Date:   Mon, 26 Aug 2019 07:51:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP-b2nNzzjsAbJGAi=R0yk6qvQ-bRM3__k-NBCb+oko7Ume+kQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K5NuW5UK006XMKlutS14lQ0n790aNLO8I"
X-Provags-ID: V03:K1:q6263O7OfgW0mCWBTpijDrLmx0a2tEwFY1xirP618ra3CN+wIp1
 AkDXz1uEyHmXNmGHvxYlbh1Q4huWTvoS6gunZK4ukLqF73iBlKsqrXXjwZ6YDdvtjx1xPy/
 6ndqSY4XVvjT3jPlSkuI9QkTfhGrCkOREYwgmdxovuwvwXUAVYhwHzQlz1U/maaK7slgFy0
 NAGgv/j2f1kNnj/2mlyjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8SeL2pZapZU=:+pLohIARW9WFfzug0mO7nb
 rqKp83OWH2U025eE51b2Sphgr6XpXMXf1bSMORgiXilhc+wS3y0AEcuVGqIdb0/GSmmIkefvs
 C1D20hUqPOWuhc/6D1NOegfPgd0rEVUj4tnUefi3G9k9Wlf4cFwZRLfDxvEPz/1QcYO5EzesF
 7tY1TRAin09cJZEHcAmvWGFkRRPzqXl02Qi1IUpQFIdmjrGS+OMySJdk0V1cORPLwSsPTtFnB
 q2yJvXz17KAqzRtXPSOBfd1AEv5mqhGTDlHNF5zXBWk/ulkupvyYwAc+ZntL9Gi2xJfe+Bszw
 UUVgjL6dNo3N8Y9SPYdIqc1BZxfDl4O9YWy+H/ZEIUXbmh5YqCARvpFpg9VoRL9P3el1qbhG9
 JlC9XwJmuLLnCsklopNLTXBgY4HqJTVoyVZCotLfE+g7E+MKOBv7r6XuJCxrn/w+88momLZOx
 S6DY6YESace06fqj7/3akMu2+2SOXEIMKuMwsCNKxhxpHn0Kf94Y1UC9e+ToSRSInO/IvQh+v
 UwhP/mOALWKzZuIQ0bjkBr4olmo0Zb/hf81ASpISStmx7x6Kai2GfgVMOjB6ITq/CBPwC3ZQA
 rT82IpAmWcuroXmUPPU1yMCVWkKrW/Cj4yv8yp0bNGmGvPvuotAdAlH2a11uC2v3kmD1pePGL
 8PntS/oBVY1MtnW2aQUqASsy/p86EiCBOwJkRhkj2F+dCQ353dO3DsSY2ei7iragwxCWvNNZo
 LY7YinxJ3h0scTFJGpAuIRr+72vZwrGPalsWbduWaBG9/6X7Np24+yZv/aqrdsx+jApIy6KTt
 GrlM/l8WS2QII46pDDCfCDDWTtySzBFBvpE/0hk+y8QOpFc4c8B0LK6QqTlH5mraefouSB2pC
 O8O8m12vJoqikG6qlY4DKSMS8pdrqL9NBh9fhRefiNxa4j2pL1mtMY2bOQ3pvdsQFyqwpHyeF
 BI2jg1PpwhADuSpzlYniiogaBjUzqNjO0sziSAB/MST77JNOi1b9qmeFUKDFipPNfoonwvrx/
 CTghQ0DntCfQoLI6vNV0v5L96dRHK7aTOAqgUmxyZatWZZtW6AjjueWzD+8wJmnq99OYtk7Xf
 0lWiVq3wP/Gr/tpQjzepssNtK7PknpTmr3vwWO/AzPa+5uv99u9mx7UHDop9We3XnZ8VR4HcH
 1g0QpbWBYzDqTTcJEMOBWY/S0XDdL2NqQ+6b64AHRkZYnmcw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K5NuW5UK006XMKlutS14lQ0n790aNLO8I
Content-Type: multipart/mixed; boundary="2SqhpljWLJ7XoxgMmJlB3zwFHX9SRb8Ll";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Daniel Clarke <dan@e-dan.co.uk>, linux-btrfs@vger.kernel.org
Message-ID: <2846a423-ba1e-698d-6369-f9588223bb94@gmx.com>
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
 <cafc855e-b030-83ff-2984-dfb45a36d1b3@gmx.com>
 <CAP-b2nPJE_=957ARh+JMzOkVg4E_A_tAJPiN0e1BTyCLTZ=Jhw@mail.gmail.com>
 <55f9d2ff-b6b0-7f13-287e-c9916c57943f@gmx.com>
 <CAP-b2nM=s07wA0Yb9XQvea_ULZ=kui0UZNddGDa_gfd1C_m7qQ@mail.gmail.com>
 <CAP-b2nNzzjsAbJGAi=R0yk6qvQ-bRM3__k-NBCb+oko7Ume+kQ@mail.gmail.com>
In-Reply-To: <CAP-b2nNzzjsAbJGAi=R0yk6qvQ-bRM3__k-NBCb+oko7Ume+kQ@mail.gmail.com>

--2SqhpljWLJ7XoxgMmJlB3zwFHX9SRb8Ll
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/26 =E4=B8=8A=E5=8D=884:49, Daniel Clarke wrote:
> Hello,
>=20
> Not sure if you got my previous email (see below).

Well, I didn't get the previous mail at all.

Not sure why but it looks like my personal mail box seems to have
something strange, mostly due to the name...

>=20
> Today I ran another attempt at using btrfs restore, and it's picked up
> a fair amount of files (about 80% of them).
>=20
> Command used:
>=20
> ~$ btrfs restore -x -m -i -v --path-regex '^/(|home(|/dan(|/.*)))$'
> /dev/sdb1 /mnt/ssd1/
>=20
> and rerun without attributes/metadata in case it helped (no change thou=
gh):
>=20
> ~$ btrfs restore -i -v --path-regex '^/(|home(|/dan(|/.*)))$'
> /dev/sdb1 /mnt/ssd1/
>=20
> I logged various output (stdout and stderr) and there is a fair amount
> skipped with messages like below:
>=20
> bad tree block 1058371960832, bytenr mismatch, want=3D1058371960832, ha=
ve=3D0

Yep, this means btrfs fails to read out data on the missing device.
Thus really hard to restore info from those tree blocks.

> bad tree block 1058371977216, bytenr mismatch, want=3D1058371977216, ha=
ve=3D0
> bad tree block 1058371993600, bytenr mismatch, want=3D1058371993600, ha=
ve=3D0
> bad tree block 1058372009984, bytenr mismatch, want=3D1058372009984, ha=
ve=3D0
> bad tree block 1058372026368, bytenr mismatch, want=3D1058372026368, ha=
ve=3D0
> bad tree block 1058372042752, bytenr mismatch, want=3D1058372042752, ha=
ve=3D0
> bad tree block 1058372059136, bytenr mismatch, want=3D1058372059136, ha=
ve=3D0
> bad tree block 1058372075520, bytenr mismatch, want=3D1058372075520, ha=
ve=3D0
> bad tree block 1058372091904, bytenr mismatch, want=3D1058372091904, ha=
ve=3D0
> bad tree block 1058372108288, bytenr mismatch, want=3D1058372108288, ha=
ve=3D0
> bad tree block 1058372124672, bytenr mismatch, want=3D1058372124672, ha=
ve=3D0
> bad tree block 1058405138432, bytenr mismatch, want=3D1058405138432, ha=
ve=3D0
> bad tree block 1058372075520, bytenr mismatch, want=3D1058372075520, ha=
ve=3D0
> Error searching -5
> Error searching /mnt/ssd1/home/dan/Pictures/Malaysia Singapore 2012
> bad tree block 1058405138432, bytenr mismatch, want=3D1058405138432, ha=
ve=3D0
>=20
> Is there any option to try to fix/recovery in these cases.

It's really hard to recover data from a missing device.
I suggest to get that missing device back and retry.

There maybe some exotic ways to scan the whole disk and try to get some
old copy from it.
But that feature is not implemented by btrfs-progs yet.

Someone in the mail list suggested some commercial tool which does the
above behavior, but I can't recall the name of the tool or the thread.

>=20
> Thanks very much,
>=20
> Dan
>=20
>=20
> On Thu, 22 Aug 2019 at 21:10, Daniel Clarke <dan@e-dan.co.uk> wrote:
>>
>> Hi Qu,
>>
>> Thanks again,
>>
>> The dump-tree output ran really quick, but somewhat large so I've
>> attached as a txt file.

Didn't get that, but I think it should be OK as you have found the
offending chunk.

>>
>> Your thoughts are correct, everything looks ok (RAID1) apart from this=

>> one item (DUP):
>>
>>     item 43 key (FIRST_CHUNK_TREE CHUNK_ITEM 1057666105344) itemoff
>> 11355 itemsize 112
>>         length 1073741824 owner 2 stripe_len 65536 type METADATA|DUP
>>         io_align 65536 io_width 65536 sector_size 4096
>>         num_stripes 2 sub_stripes 1
>>             stripe 0 devid 2 offset 172873482240
>>             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d
>>             stripe 1 devid 2 offset 173947224064
>>             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d

This looks like you have mounted the fs degraded at sometime, and did
some write to trigger a chunk allocation.

Since at degraded mode, there is only one device, thus btrfs can't
create degraded RAID1 chunk, it created a DUP chunk.

And that caused the problem of unable to mount.
As mentioned, try to get that device back and retry may be a good idea.

Thanks,
Qu

>>
>> Cheers,
>>
>> Dan
>>
>> On Thu, 22 Aug 2019 at 00:23, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>>
>>>
>>>
>>> On 2019/8/22 =E4=B8=8A=E5=8D=882:51, Daniel Clarke wrote:
>>>> Hi Qu,
>>>>
>>>> Many thanks for you response, see below:
>>>>
>>>>>
>>>>>
>>>>>
>>>>> On 2019/8/21 =E4=B8=8A=E5=8D=883:42, Daniel Clarke wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm having some trouble recovering my data after a single disk has=

>>>>>> failed in a raid1 two disk setup.
>>>>>>
>>>>>> The original setup:
>>>>>> mkfs.btrfs -L MASTER /dev/sdb1
>>>>>> mount -o compress=3Dzstd,noatime /dev/sdb1 /mnt/master
>>>>>> btrfs subvolume create /mnt/master/home
>>>>>> btrfs device add /dev/sdc1 /mnt/master
>>>>>> btrfs balance start -dconvert=3Draid1 -mconvert=3Draid1 /mnt/maste=
r
>>>>>>
>>>>>> Mount after in fstab:
>>>>>>
>>>>>> UUID=3D70a651ab-4837-4891-9099-a6c8a52aa40f /mnt/master     btrfs
>>>>>> defaults,noatime,compress=3Dzstd 0      0
>>>>>>
>>>>>> Was working fine for about 8 months, however I found the filesyste=
m
>>>>>> went to read only,
>>>>>
>>>>> Dmesg of that please.
>>>>>
>>>>> And there is a known bug that an aborted transaction can cause race=
 and
>>>>> corrupt the fs.
>>>>> Please provide the kernel version of that RO event.
>>>>>
>>>>
>>>> When the original event occurred, the kernel version was:
>>>> ~$ uname -a
>>>> Linux dan-server 4.15.0-58-generic #64-Ubuntu SMP Tue Aug 6 11:12:41=

>>>> UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> A little old, but should be OK as I haven't see much problem related =
to
>>> older kernel yet.
>>>
>>>>
>>>> I've only got syslog going back 7 days, and it looks like the failur=
e
>>>> occurred before that without me knowing. I've attached syslog.7.gz f=
or
>>>> your information anyway.
>>>
>>> From that, the most obvious is your sdc1 has some hardware related
>>> problem, a lot of read error directly from disk controller.
>>>
>>>>
>>>> File system was read only at that point, but the restart failed, so =
I
>>>> commented out the mount in fstab and tried manually.
>>>
>>> Consider how many read error and write error it hit, it's very possib=
le
>>> that btrfs goes RO as some tree blocks write fails, thus it goes RO.
>>>
>>> And considering it's sdc1 causing the problem, if you're using RAID1 =
for
>>> both metadata and data, your sdb1 should be more or less OK.
>>>
>>>>
>>>> Actually that first mount returned these errors (in attached syslog.=
3.gz):
>>>> Aug 17 09:08:01 dan-server kernel: [   68.568642] BTRFS info (device=

>>>> sdb1): allowing degraded mounts
>>>> Aug 17 09:08:01 dan-server kernel: [   68.568644] BTRFS info (device=

>>>> sdb1): disk space caching is enabled
>>>> Aug 17 09:08:01 dan-server kernel: [   68.568645] BTRFS info (device=

>>>> sdb1): has skinny extents
>>>> Aug 17 09:08:01 dan-server kernel: [   68.569781] BTRFS warning
>>>> (device sdb1): devid 2 uuid a3889c61-07b3-4165-bc37-e9918e41ea8d is
>>>> missing
>>>> Aug 17 09:08:01 dan-server kernel: [   68.577883] BTRFS warning
>>>> (device sdb1): devid 2 uuid a3889c61-07b3-4165-bc37-e9918e41ea8d is
>>>> missing
>>>> Aug 17 09:08:02 dan-server kernel: [   69.586393] BTRFS error (devic=
e
>>>> sdb1): failed to read block groups: -5
>>>
>>> Then I'd say, some tree blocks are just missing, maybe you have some
>>> SINGLE/DUP tree blocks on sdc1, thus causing the problem.
>>>
>>> It shouldn't be a problem if you only want RO mount.
>>>
>>> [...]
>>>>> # btrfs ins dump-super -FfA /dev/sdc1
>>> [...]
>>>> stripesize        4096
>>>> root_dir        6
>>>> num_devices        2
>>>> compat_flags        0x0
>>>> compat_ro_flags        0x0
>>>> incompat_flags        0x171
>>>>             ( MIXED_BACKREF |
>>>>               COMPRESS_ZSTD |
>>>>               BIG_METADATA |
>>>>               EXTENDED_IREF |
>>>>               SKINNY_METADATA )
>>>> cache_generation    8596
>>>> uuid_tree_generation    8596
>>>> dev_item.uuid        150986ba-521c-4eb0-85ec-9435edecaf2a
>>>> dev_item.fsid        70a651ab-4837-4891-9099-a6c8a52aa40f [match]
>>>> dev_item.type        0
>>>> dev_item.total_bytes    2000397864960
>>>> dev_item.bytes_used    1076996603904
>>>> dev_item.io_align    4096
>>>> dev_item.io_width    4096
>>>> dev_item.sector_size    4096
>>>> dev_item.devid        1
>>>> dev_item.dev_group    0
>>>> dev_item.seek_speed    0
>>>> dev_item.bandwidth    0
>>>> dev_item.generation    0
>>>> sys_chunk_array[2048]:
>>>>     item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1769556934656)
>>>>         length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
>>>>         io_align 65536 io_width 65536 sector_size 4096
>>>>         num_stripes 2 sub_stripes 1
>>>>             stripe 0 devid 1 offset 2186280960
>>>>             dev_uuid 150986ba-521c-4eb0-85ec-9435edecaf2a
>>>>             stripe 1 devid 2 offset 885838053376
>>>>             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d
>>>
>>> So system chunk is still OK, all RAID1.
>>>
>>> Then maybe some metadata chunks causing the problem. (can be caused b=
y
>>> btrfs-progs writes).
>>>
>>> If you want some more analyse why this mount fails, please provide th=
e
>>> following dump:
>>> # btrfs ins dump-tree -t chunk /dev/sdb1
>>>
>>> Thanks,
>>> Qu
>>>
>>>> backup_roots[4]:
>>>>     backup 0:
>>>>         backup_tree_root:    1507300622336    gen: 8594    level: 1
>>>>         backup_chunk_root:    1769556934656    gen: 8191    level: 1=

>>>>         backup_extent_root:    1507302375424    gen: 8594    level: =
2
>>>>         backup_fs_root:        1506503901184    gen: 7886    level: =
0
>>>>         backup_dev_root:    1507550887936    gen: 8473    level: 1
>>>>         backup_csum_root:    1507311517696    gen: 8594    level: 2
>>>>         backup_total_bytes:    4000795729920
>>>>         backup_bytes_used:    1075454636032
>>>>         backup_num_devices:    2
>>>>
>>>>     backup 1:
>>>>         backup_tree_root:    1507500949504    gen: 8595    level: 1
>>>>         backup_chunk_root:    1769556934656    gen: 8191    level: 1=

>>>>         backup_extent_root:    1507297804288    gen: 8595    level: =
2
>>>>         backup_fs_root:        1506503901184    gen: 7886    level: =
0
>>>>         backup_dev_root:    1507550887936    gen: 8473    level: 1
>>>>         backup_csum_root:    1768498708480    gen: 8595    level: 2
>>>>         backup_total_bytes:    4000795729920
>>>>         backup_bytes_used:    1075454439424
>>>>         backup_num_devices:    2
>>>>
>>>>     backup 2:
>>>>         backup_tree_root:    1768503099392    gen: 8596    level: 1
>>>>         backup_chunk_root:    1769556934656    gen: 8191    level: 1=

>>>>         backup_extent_root:    1768503115776    gen: 8596    level: =
2
>>>>         backup_fs_root:        1506503901184    gen: 7886    level: =
0
>>>>         backup_dev_root:    1507550887936    gen: 8473    level: 1
>>>>         backup_csum_root:    1768505966592    gen: 8596    level: 2
>>>>         backup_total_bytes:    4000795729920
>>>>         backup_bytes_used:    1075454439424
>>>>         backup_num_devices:    2
>>>>
>>>>     backup 3:
>>>>         backup_tree_root:    1507234676736    gen: 8593    level: 1
>>>>         backup_chunk_root:    1769556934656    gen: 8191    level: 1=

>>>>         backup_extent_root:    1507234725888    gen: 8593    level: =
2
>>>>         backup_fs_root:        1506503901184    gen: 7886    level: =
0
>>>>         backup_dev_root:    1507550887936    gen: 8473    level: 1
>>>>         backup_csum_root:    1507297738752    gen: 8593    level: 2
>>>>         backup_total_bytes:    4000795729920
>>>>         backup_bytes_used:    1075454636032
>>>>         backup_num_devices:    2
>>>>
>>>>
>>>>
>>>>>
>>>>>> [ 4044.863400] BTRFS error (device sdc1): open_ctree failed
>>>>>>
>>>>>> Pretty much the same thing with other mount options, with same
>>>>>> messages in dmesg.
>>>>>>
>>>>>> ~$ btrfs check --init-extent-tree /dev/sdc1
>>>>>
>>>>> Why you're doing so?! It's already mentioned --init-extent-tree is =
UNSAFE!
>>>>
>>>> Apologies, saw it somewhere and tried in some desperation. It ran an=
d
>>>> exited in just a second though so maybe didn't do anything.
>>>>
>>>>>
>>>>>> warning, device 2 is missing
>>>>>> Checking filesystem on /dev/sdc1
>>>>>> UUID: 70a651ab-4837-4891-9099-a6c8a52aa40f
>>>>>> Creating a new extent tree
>>>>>> bytenr mismatch, want=3D1058577645568, have=3D0
>>>>>> Error reading tree block
>>>>>> error pinning down used bytes
>>>>>> ERROR: attempt to start transaction over already running one
>>>>>
>>>>> Transaction get aborted, exactly the situation where fs can get fur=
ther
>>>>> corrupted.
>>>>>
>>>>> The only good news is, we shouldn't have written much data as it's
>>>>> happening in tree pinning down process, so no further damage.
>>>>
>>>> Thanks, that's what I'm hoping!
>>>>
>>>>>
>>>>>> extent buffer leak: start 1768503115776 len 16384
>>>>>>
>>>>>> ~$ btrfs rescue super-recover -v /dev/sdc1
>>>>>> All Devices:
>>>>>> Device: id =3D 1, name =3D /dev/sdc1
>>>>>>
>>>>>> Before Recovering:
>>>>>> [All good supers]:
>>>>>> device name =3D /dev/sdc1
>>>>>> superblock bytenr =3D 65536
>>>>>>
>>>>>> device name =3D /dev/sdc1
>>>>>> superblock bytenr =3D 67108864
>>>>>>
>>>>>> device name =3D /dev/sdc1
>>>>>> superblock bytenr =3D 274877906944
>>>>>>
>>>>>> [All bad supers]:
>>>>>>
>>>>>> All supers are valid, no need to recover
>>>>>>
>>>>>>
>>>>>> ~$ sudo btrfs restore -mxs /dev/sdc1 /mnt/ssd1/
>>>>>> warning, device 2 is missing
>>>>>> bytenr mismatch, want=3D1057828618240, have=3D0
>>>>>> Could not open root, trying backup super
>>>>>> warning, device 2 is missing
>>>>>> bytenr mismatch, want=3D1057828618240, have=3D0
>>>>>> Could not open root, trying backup super
>>>>>> warning, device 2 is missing
>>>>>> bytenr mismatch, want=3D1057828618240, have=3D0
>>>>>> Could not open root, trying backup super
>>>>>>
>>>>>> ~$ btrfs check /dev/sdc1
>>>>>> warning, device 2 is missing
>>>>>> bytenr mismatch, want=3D1057828618240, have=3D0
>>>>>> ERROR: cannot open file system
>>>>>>
>>>>>> ~$ btrfs rescue zero-log /dev/sdc1
>>>>>> warning, device 2 is missing
>>>>>> bytenr mismatch, want=3D1057828618240, have=3D0
>>>>>> ERROR: could not open ctree
>>>>>>
>>>>>> I'm only interested in getting it read-only mounted so I can copy
>>>>>> somewhere else. Any ideas you have are welcome!
>>>>>
>>>>> It looks like some metadata tree blocks are still not in RAID1 mode=
=2E
>>>>> Needs that ins dump-super output to confirm.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Many Thanks,
>>>>>>
>>>>>> Daniel Clarke
>>>>>>
>>>>>
>>>>
>>>> Thanks again,
>>>>
>>>> Dan
>>>>
>>>


--2SqhpljWLJ7XoxgMmJlB3zwFHX9SRb8Ll--

--K5NuW5UK006XMKlutS14lQ0n790aNLO8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1jHwsACgkQwj2R86El
/qi5/ggArCdyqsGRxMFG1eZq/qdA5SQ3REemvKIxXieQOZoWrddk4ieDBEIOw1Ay
XBTFZeANXUJ9vz0pX4a3utuhj3fbyhoujaWl8lqvs+tDn4G0sJfjmdaVBWw30YhB
EnHkujM2cTF39UUCzfBlEOYpJRvymY5bU8tC+GDrEoWK4RDM2PolgYjZhyivBVl0
McCYFD5dQeU77tH66iMwMWnVgecl6Ayc0sghvZikOe+rGBS9RQLn7PtPvGLHjhN+
+UOVZD2s3QXVCrAq4SlQjAg2pgaA7lKmFLyJhFc2ftAJICX2F3Lz36LFpF7agEOG
cWfSpjvysOfI5cGfrmYhwXuNV4u/Lg==
=3EiP
-----END PGP SIGNATURE-----

--K5NuW5UK006XMKlutS14lQ0n790aNLO8I--
