Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B88102230
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKSKn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 05:43:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:60611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfKSKn2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 05:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574160120;
        bh=SmvcyIi84w4hBPU/M9upHUxJuqHIUm9TJDnxrSB4zow=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WlBb9C3JfDtmfmR1FOn6ZPLc7E4Q1fRyZlaU5M96U3pwNO+yOTOgbvyAJw2Y4Agj2
         FG+yN5FYe6lHhNpVygXn5XItEkI+1AoxfQszOC2GawMl4Pljy7DiUxkNTnY69MODR7
         Yn/F8N4FWA23c9E6Cif5Eaekyy7y1/myGENIP1IE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1hlYci2uH6-015FQ7; Tue, 19
 Nov 2019 11:42:00 +0100
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
Date:   Tue, 19 Nov 2019 18:41:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tx1X4Q2zvk5qoeNqMpb7Ztbnoaztewa8Q"
X-Provags-ID: V03:K1:28GmCqdDg5qVrnaKuiy/R4iKmsU5zd1HYIHAkz7vWZtoRRM5+Xi
 aDyMqNI/D9HQzB20RDsbkJuQAL6RDtz4L+c8c6NmITk6AD9GD4WlcGahrTQinl6cLB7SOYs
 Zq9ZZGbQceO/gs3Km/oLUvEWPPXokC7iDt1Au5iZ9azWh7Ce4kxcvChCxpMFm+7WPPNO+JH
 yQREb1j/w9RrW8dtEc6+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G4PSErL4YVE=:sM0m2QyBUgaV20U5nYAni7
 a2GAoJtvtkjyBzwEvZTtr7Jwl6Gf914evR1v/0HIQV5DDLEG9N2m2zo5Ky2U6U4uVllYZszsT
 +QqV6GgXhWSi/OeP00j4jGy8zzaXfGMqjYGYf/PSODlM4uNEFYaaQWt7EYVY9KZsqThpWnu7I
 8bSSMV9u4tzEBE7W7ah5iEDnBApjVnfrwhBpZdCSvJ2Zocn95dz4z6ymE9pkm724R22PN80ea
 S5PGpUJX1OBNBtmEz7soq/IMrq8plpoeSgmr5uJDd9+NC6bzyDe3lI1HgxrwuvAuW5KW+MLAJ
 DvHH4gsQ/MP5wGuPzeAntwdHkOnEezl6mDlaebaIdT/rVg7zlesVXHKNnDl944emsJfRgaSkD
 Idqe6q6SphR2GlsDdNHRTB9HSQntXEHbQ0twdZsXVX8A9NPD6ZQMrk/ni724DoldJupPakKww
 a2wlKSNQUnrp1rkq3bJGZ0EQBB9Y3f1CsWNKocJI5VxM6r7S3YIKIEcnuLSxbrGkNC90kwLPP
 WND9ts9Dzig70uxcN0p8AvnUgJE0YrVZkKaQ09zxuN//5HLQD2shx9JWVGVH2eejofDDdfCCD
 F78qWOhGDoj/c3BjpIrLv0CPyd4dgsS52qRzR6ry14z41Lx8PzQMJNV/Zka3ntQ3bY/JTzTZr
 /4/lrh7Q+3coQPmNHto16Uc/+9PZfUc9igEf1I6RmoybqxvqffT821gtD1wLwdVuMdHrlIM4U
 kwH+sxIXI8+RsyJOhxpMjEHKwSQMlcyzq3MoZsJLZLyGQM5U/zBWz2WiQzIlSDExn/D7BM28U
 sbEQo/8Gg7FjAok8gBip1L1RXvmXeuRcjDcP62a4/sm7TqfbFnpAwFckExXdk2UM/V3S/edUD
 6HdRw7UAPM6dklcHjW+q2XJmm+0ioH/pQeUWIsrlhmQbco0xc7L5yjCwyPGXOwZ6lDLmILZ1Z
 nXZwEngszdaox9tkdH25rWMDfEg/LhIwK1g3aeSSYGWvJ4EO82vE29abyTRTnbAfzpS2BKMIR
 QfYeXyWvSIKEbIPOEWJ9BJH4tZVRCdDIrNQHJQmO5rZodkY+ly4JuOUE4yAW5xyVIy5TLoDX6
 geLsKa3afsLwDnDzM2trKO7Xhgmbv/jvIFzAOj9uo/tD1q0ZR/1NklhBDoYZuDyJUZsToCufm
 17idWRh1HYB4OoA8ve48MecPi3KzxI/J05D4VnIHCK/FSFZ/zBc7suWhLAKbExozdqpRvcYDk
 YN1rlsl4oiOP+88v4Ud2UYrWVFvctPFxagjqZ8UhWCrw+JsBjbVTS/Qs4ruI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tx1X4Q2zvk5qoeNqMpb7Ztbnoaztewa8Q
Content-Type: multipart/mixed; boundary="b95URRRrCdL8YlA7Hk3R2qdQuSXNnrCPD"

--b95URRRrCdL8YlA7Hk3R2qdQuSXNnrCPD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=886:05, Anand Jain wrote:
> On 11/7/19 2:27 PM, Qu Wenruo wrote:
>> [PROBLEM]
>> Btrfs degraded mount will fallback to SINGLE profile if there are not
>> enough devices:
>=20
> =C2=A0Its better to keep it like this for now until there is a fix for =
the
> =C2=A0write hole. Otherwise hitting the write hole bug in case of degra=
ded
> =C2=A0raid1 will be more prevalent.

Write hole should be a problem for RAID5/6, not the degraded chunk
feature itself.

Furthermore, this design will try to avoid allocating chunks using
missing devices.
So even for 3 devices RAID5, new chunks will be allocated by using
existing devices (2 devices RAID5), so no new write hole is introduced.

>=20
> =C2=A0I proposed a RFC a long time before [1] (also in there, there
> =C2=A0is a commit id which turned the degraded raid1 profile into singl=
e
> =C2=A0profile (without much write-up on it)).
>=20
> =C2=A0=C2=A0 [1] [PATCH 0/2] [RFC] btrfs: create degraded-RAID1 chunks

My point for this patchset is:
- Create regular chunk if we have enough devices
- Create degraded chunk only when we have not enough devices

I guess since you didn't get the point of my preparation patches, your
patches aren't that good to avoid missing devices.

>=20
> =C2=A0Similarly the patch related to the reappearing missing device [2]=

> =C2=A0falls under the same category. Will push for the integration afte=
r
> =C2=A0the write hole fix.
>=20
> =C2=A0=C2=A0 [2] [PATCH] btrfs: handle dynamically reappearing missing =
device
> =C2=A0=C2=A0 (test case 154).

That's another case, and I didn't see how it affects this feature.

>=20
> =C2=A0If you look close enough the original author has quite nicely mad=
e
> =C2=A0sure write hole bug will be very difficultly to hit. These fixes
> =C2=A0shall make it easy to hit. So its better to work on the write hol=
e
> =C2=A0first.

If you're talking about RAID5/6, you are talking at the wrong thread.
Go implement some write-a-head log for RAID5/6, or mark all degraded
RAID5/6 chunks read-only at mount time.

>=20
> =C2=A0I am trying to fix write hole. First attempt has limited success
> =C2=A0(works fine in two disk raid1 only). Now trying other ways to fix=
=2E
>=20
>> =C2=A0 # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>> =C2=A0 # wipefs -fa /dev/test/scratch2
>> =C2=A0 # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>> =C2=A0 # fallocate -l 1G /mnt/btrfs/foobar
>> =C2=A0 # btrfs ins dump-tree -t chunk /dev/test/scratch1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 7 key (FIRST_CHU=
NK_TREE CHUNK_ITEM 1674575872) itemoff
>> 15511 itemsize 80
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 length 536870912 owner 2 stripe_len 65536 type D=
ATA
>> =C2=A0 New data chunk will fallback to SINGLE.
>>
>> If user doesn't balance those SINGLE chunks, even with missing devices=

>> replaced, the fs is no longer full RAID1, and a missing device can bre=
ak
>> the tolerance.
>=20
> =C2=A0As its been discussed quite a lot of time before, the current
> =C2=A0re-silver/recovery approach for degraded-raid1 (with offload to S=
ingle)
> =C2=A0requires balance. Its kind of known.

I'd call such "well-known" behavior BS.

All other raid1 implementation can accept single device RAID1 and
resilver itself with more device into a full RAID1 setup.

But for BTRFS you're calling SINGLE profile "well-known"?
It's "well-known" because it's not working properly, that's why I'm
trying to fix it.


>=20
> Thanks, Anand
>=20
>=20
>> [CAUSE]
>> The cause is pretty simple, when mounted degraded, missing devices can=
't
>> be used for chunk allocation.
>> Thus btrfs has to fall back to SINGLE profile.
>>
>> [ENHANCEMENT]
>> To avoid such problem, this patch will:
>> - Make all profiler reducer/updater to consider missing devices as par=
t
>> =C2=A0=C2=A0 of num_devices
>> - Make chunk allocator to fallback to missing_list as last resort
>>
>> If we have enough rw_devices, then go regular chunk allocation code.
>=20
>> This can avoid allocating degraded chunks.
>> E.g. for 3 devices RAID1 degraded mount, we will use the 2 existing
>> devices to allocate chunk, avoid degraded chunk.
>=20
>> But if we don't have enough rw_devices, then we check missing devices =
to
>> allocate degraded chunks.
>> E.g. for 2 devices RAID1 degraded mount, we have to allocate degraded
>> chunks to keep the RAID1 profile.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/block-group.c | 10 +++++++---
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++++++++++++=
---
>> =C2=A0 2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index bf7e3f23bba7..1686fd31679b 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -52,11 +52,13 @@ static u64 get_restripe_target(struct
>> btrfs_fs_info *fs_info, u64 flags)
>> =C2=A0=C2=A0 */
>> =C2=A0 static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_=
info,
>> u64 flags)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 u64 num_devices =3D fs_info->fs_devices->rw_device=
s;
>> +=C2=A0=C2=A0=C2=A0 u64 num_devices;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 target;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 raid_type;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 allowed =3D 0;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 num_devices =3D fs_info->fs_devices->rw_dev=
ices +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fs_info->fs_devices->missing_devices;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * See if restripe for this chunk_=
type is in progress, if so try to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reduce to the target profile
>> @@ -1986,7 +1988,8 @@ static u64 update_block_group_flags(struct
>> btrfs_fs_info *fs_info, u64 flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stripped)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return extended=
_to_chunk(stripped);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 num_devices =3D fs_info->fs_devices->rw_dev=
ices;
>> +=C2=A0=C2=A0=C2=A0 num_devices =3D fs_info->fs_devices->rw_devices +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fs_info->fs_devices->missing_devices;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stripped =3D BTRFS_BLOCK_GROUP_R=
AID0 |
>> BTRFS_BLOCK_GROUP_RAID56_MASK |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_BLOCK_GRO=
UP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
>> @@ -2981,7 +2984,8 @@ static u64 get_profile_num_devs(struct
>> btrfs_fs_info *fs_info, u64 type)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_dev =3D
>> btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!num_dev)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_dev =3D fs_info->fs_de=
vices->rw_devices;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_dev =3D fs_info->fs_de=
vices->rw_devices +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fs_info->fs_devices->missing_devices;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return num_dev;
>> =C2=A0 }
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a462d8de5d2a..4dee1974ceb7 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5052,8 +5052,9 @@ static int __btrfs_alloc_chunk(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_chunk_size =3D min(div_factor(fs_de=
vices->total_rw_bytes, 1),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_chunk_size);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 devices_info =3D kcalloc(fs_devices->rw_dev=
ices,
>> sizeof(*devices_info),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 devices_info =3D kcalloc(fs_devices->rw_devices +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->missing_devices,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*devices_info), GFP_NOFS);=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!devices_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;=

>> =C2=A0 @@ -5067,7 +5068,18 @@ static int __btrfs_alloc_chunk(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 max_stripe_size, dev_stripes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> -
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If rw devices can't fullfil the request, f=
allback to missing
>> devices
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as last resort.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ndevs < devs_min) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D gather_dev_holes(i=
nfo, devices_info + ndevs, &ndevs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &fs_devices->missing_list,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_devices->missing_devices,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max_stripe_size, dev_stripes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to error;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * now sort the devices by hole si=
ze / available space
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>=20


--b95URRRrCdL8YlA7Hk3R2qdQuSXNnrCPD--

--tx1X4Q2zvk5qoeNqMpb7Ztbnoaztewa8Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Txu0XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjD9Qf+PRPRkkP4O8ZVp5YxG3/X0sn8
jZPq3+XboqMIGMQQ7YgpKJ2iC0xtv+uX1fuNujt7oQA/RVxWOc6JiQ1YaimQvaCj
ROVFB0LJBnEA07OcBWY4OGr7RP61Tyw7kdZjeygHtFMMaJtWSThp3xv4j4uz0oEL
g1gfugYHkO8Md5JKxNta9++5g6VNpDkEAOsMlJ+BCgm0nsFbyGl3A8ukwaCuZq3/
zNhPKJQ7i/Sr12dxelSSi3JPFj4/93OfRkSJVA7FI5HD0hixn4nwxi1lVd8r28jg
ZvRKECudOMyU2nbuHk2Syzm9oN6+A6+HzRT5U8YBzz6ciap5ejxrilghIIJs9Q==
=t0lI
-----END PGP SIGNATURE-----

--tx1X4Q2zvk5qoeNqMpb7Ztbnoaztewa8Q--
