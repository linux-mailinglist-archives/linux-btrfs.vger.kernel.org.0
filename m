Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2C130B88
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 02:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgAFBcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 20:32:06 -0500
Received: from ms11p00im-qufo17291301.me.com ([17.58.38.42]:56528 "EHLO
        ms11p00im-qufo17291301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbgAFBcG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 20:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578274322;
        bh=m35FiPCbuP5czrbpeP3SBhqhZnzer7NT1wRFGC2Oj6g=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=qyLi6HanY+oBtJb+PvfAPF/sIKAh9fRvMDAmnKRP+43m7R7KkyuQJfqCYAEM2+jqo
         rsZ+L9oEDWdCgYVIQ+vBLPbKGS9k0fo7Ctj6mdyvoSK2m/IkOTFqhAqJIdONUYU+UL
         M6Pbvoqwz/Sp1DyLEUGznQFskA2Igd9wl8rnAh7ae08vBn1i8ZbkFUWU1LmjdEj15x
         Eolek+Tkum+HvWMT6q/mjlE57LjFTGs8as+5zXFApxyOYcYOftOsbGVqOP8+rv0wzu
         zbxhmYXV2wK5CmnGEzPOMkOmq1d/EBwaX3hKbfH9Krl68OURiwPyRKQUZZvGjArcEi
         /lz3n+sww/uvA==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17291301.me.com (Postfix) with ESMTPSA id AB14410065C;
        Mon,  6 Jan 2020 01:32:01 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
Date:   Sun, 5 Jan 2020 22:31:55 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F9562E6-7337-4842-855B-0AF52C4C7449@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
 <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
 <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
 <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
 <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001060013
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 5. Jan 2020, at 19:28, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Sun, Jan 5, 2020 at 2:58 PM Christian Wimmer =
<telefonchris@icloud.com> wrote:
>>> On 5. Jan 2020, at 18:13, Chris Murphy <lists@colorremedies.com> =
wrote:
>>>=20
>>> On Sun, Jan 5, 2020 at 1:36 PM Christian Wimmer =
<telefonchris@icloud.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 5. Jan 2020, at 17:30, Chris Murphy <lists@colorremedies.com> =
wrote:
>>>>>=20
>>>>> On Sun, Jan 5, 2020 at 12:48 PM Christian Wimmer
>>>>> <telefonchris@icloud.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>> #fdisk -l
>>>>>> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
>>>>>> Disk model: Suse 15.1-0 SSD
>>>>>> Units: sectors of 1 * 512 =3D 512 bytes
>>>>>> Sector size (logical/physical): 512 bytes / 4096 bytes
>>>>>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>>>>>> Disklabel type: gpt
>>>>>> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
>>>>>>=20
>>>>>> Device         Start       End   Sectors  Size Type
>>>>>> /dev/sda1       2048     18431     16384    8M BIOS boot
>>>>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
>>>>>> /dev/sda3  532674560 536870878   4196319    2G Linux swap
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> btrfs insp dump-s /dev/sda2
>>>>>>=20
>>>>>>=20
>>>>>> Here I have only btrfs-progs version 4.19.1:
>>>>>>=20
>>>>>> linux-ze6w:~ # btrfs version
>>>>>> btrfs-progs v4.19.1
>>>>>> linux-ze6w:~ # btrfs insp dump-s /dev/sda2
>>>>>> superblock: bytenr=3D65536, device=3D/dev/sda2
>>>>>> ---------------------------------------------------------
>>>>>> csum_type               0 (crc32c)
>>>>>> csum_size               4
>>>>>> csum                    0x6d9388e2 [match]
>>>>>> bytenr                  65536
>>>>>> flags                   0x1
>>>>>>                      ( WRITTEN )
>>>>>> magic                   _BHRfS_M [match]
>>>>>> fsid                    affdbdfa-7b54-4888-b6e9-951da79540a3
>>>>>> metadata_uuid           affdbdfa-7b54-4888-b6e9-951da79540a3
>>>>>> label
>>>>>> generation              799183
>>>>>> root                    724205568
>>>>>> sys_array_size          97
>>>>>> chunk_root_generation   797617
>>>>>> root_level              1
>>>>>> chunk_root              158835163136
>>>>>> chunk_root_level        0
>>>>>> log_root                0
>>>>>> log_root_transid        0
>>>>>> log_root_level          0
>>>>>> total_bytes             272719937536
>>>>>> bytes_used              106188886016
>>>>>> sectorsize              4096
>>>>>> nodesize                16384
>>>>>> leafsize (deprecated)           16384
>>>>>> stripesize              4096
>>>>>> root_dir                6
>>>>>> num_devices             1
>>>>>> compat_flags            0x0
>>>>>> compat_ro_flags         0x0
>>>>>> incompat_flags          0x163
>>>>>>                      ( MIXED_BACKREF |
>>>>>>                        DEFAULT_SUBVOL |
>>>>>>                        BIG_METADATA |
>>>>>>                        EXTENDED_IREF |
>>>>>>                        SKINNY_METADATA )
>>>>>> cache_generation        799183
>>>>>> uuid_tree_generation    557352
>>>>>> dev_item.uuid           8968cd08-0c45-4aff-ab64-65f979b21694
>>>>>> dev_item.fsid           affdbdfa-7b54-4888-b6e9-951da79540a3 =
[match]
>>>>>> dev_item.type           0
>>>>>> dev_item.total_bytes    272719937536
>>>>>> dev_item.bytes_used     129973092352
>>>>>> dev_item.io_align       4096
>>>>>> dev_item.io_width       4096
>>>>>> dev_item.sector_size    4096
>>>>>> dev_item.devid          1
>>>>>> dev_item.dev_group      0
>>>>>> dev_item.seek_speed     0
>>>>>> dev_item.bandwidth      0
>>>>>> dev_item.generation     0
>>>>>=20
>>>>> Partition map says
>>>>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
>>>>>=20
>>>>> Btrfs super says
>>>>>> total_bytes             272719937536
>>>>>=20
>>>>> 272719937536*512=3D532656128
>>>>>=20
>>>>> Kernel FITRIM want is want=3D532656128
>>>>>=20
>>>>> OK so the problem is the Btrfs super isn't set to the size of the
>>>>> partition. The usual way this happens is user error: partition is
>>>>> resized (shrink) without resizing the file system first. This file
>>>>> system is still at risk of having problems even if you disable
>>>>> fstrim.timer. You need to shrink the file system is the same size =
as
>>>>> the partition.
>>>>>=20
>>>>=20
>>>> Could this be a problem of Parallels Virtual machine that maybe =
sometimes try to get more space on the hosting file system?
>>>> One solution would be to have a fixed size of the disc file instead =
of a growing one.
>>>=20
>>> I don't see how it's related. Parallels has no ability I'm aware of =
to
>>> change the GPT partition map or the Btrfs super block - as in, =
rewrite
>>> it out with a modification correctly including all checksums being
>>> valid. This /dev/sda has somehow been mangled on purpose.
>>>=20
>>> Again, from the GPT
>>>>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
>>>>>> /dev/sda3  532674560 536870878   4196319    2G Linux swap
>>>=20
>>> The end LBA for sda2 is 419448831, but the start LBA for sda3 is
>>> 532674560. There's a ~54G gap in there as if something was removed.
>>> I'm not sure why a software installer would produce this kind of
>>> layout on purpose, because it has no purpose.
>>>=20
>>>=20
>>=20
>> Ok, understand. Very strange. Maybe we should forget about this =
particular problem.
>> Should I repair it somehow? And if yes, how?
>=20
>=20
>>>>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
>=20
> delete this partition, recreate a new one with the same start LBA,
> 18432 and a new end LBA that matches the actual fs size:
>=20
> 18432+(272719937536/512)=3D532674560
>=20
> write it and reboot the VM. You could instead resize Btrfs to match
> the partition but that might piss off the kernel if Btrfs thinks it
> needs to move block groups from a location outside the partition. So I
> would just resize the partition. And then you need to do a scrub and a
> btrfs check on this volume to see if it's damaged.
>=20
> I don't know but I suspect it could be possible that this malformed
> root might have resulted in a significant instability of the system at
> some point, and in it's last states of confusion as it face planted,
> wrote out very spurious data causing your broken Btrfs file system. I
> can't prove that.
>=20
>=20

Ok, I will try.

>=20
>=20
>=20
>=20
>>=20
>>>=20
>>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>>=20
>>>>>> linux-ze6w:~ # systemctl status fstrim.timer
>>>>>> =E2=97=8F fstrim.timer - Discard unused blocks once a week
>>>>>> Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; enabled; =
vendor preset: enabled)
>>>>>> Active: active (waiting) since Sun 2020-01-05 15:24:59 -03; 1h =
19min ago
>>>>>> Trigger: Mon 2020-01-06 00:00:00 -03; 7h left
>>>>>>   Docs: man:fstrim
>>>>>>=20
>>>>>> Jan 05 15:24:59 linux-ze6w systemd[1]: Started Discard unused =
blocks once a week.
>>>>>>=20
>>>>>> linux-ze6w:~ # systemctl status fstrim.service
>>>>>> =E2=97=8F fstrim.service - Discard unused blocks on filesystems =
from /etc/fstab
>>>>>> Loaded: loaded (/usr/lib/systemd/system/fstrim.service; static; =
vendor preset: disabled)
>>>>>> Active: inactive (dead)
>>>>>>   Docs: man:fstrim(8)
>>>>>> linux-ze6w:~ #
>>>>>=20
>>>>> OK so it's not set to run. Why do you have FITRIM being called?
>>>>=20
>>>> No idea.
>>>=20
>>> Well you're going to have to find it. I can't do that for you.
>>=20
>>=20
>> Ok, I will have a look. Can I simply deactivate the service?
>=20
> fstrim.service is a one shot. The usual method of it being activated
> once per week is via fstrim.timer - but your status check of
> fstrim.timer says it's disabled. So something else is running fstrim.
> I have no idea what it is, you have to find it in order to deactivate
> it.


Ok, got it.

>=20
> This 12T file system is a single "device" backed by a 12T file on the
> Promise drive? And it's a Parallel's formatted VM file? I guess I
> would have used raw instead of a Parallels format. That way you can
> inspect things from outside the VM. But that's perhaps a minor point.

I would like to do so! I will investigate on how to do so.

I am using this way that I am doing because of the speed.
I have a 2TB Samsung_X5 where I have a 1.8TB disc file and writing a =
10GB file takes only 4.4 seconds:

bash$ dd if=3D/dev/zero of=3Derasemenow6 bs=3D1M count=3D10000
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB, 9.8 GiB) copied, 4.43557 s, 2.4 GB/s
bash$=20

Isn=E2=80=99t that fantastic?

A little worse results I get with the Pegasus Promise3:

bash$ dd if=3D/dev/zero of=3Derasemenow6 bs=3D1M count=3D10000
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB, 9.8 GiB) copied, 5.49031 s, 1.9 GB/s
bash$=20

This speeds I did not achieve with any other combination of files =
systems.
And all this I get together with the fantastic btrfs file system that =
allows me to copy files of 10GB size in just a fraction of a second.
It is just that I am a little afraid now because of the two mega crashes =
that damaged all my data.

The Parallels Virtual machine can not access the Samsung_X5 or Pegasus =
directly in order to partition it, so I have to format them in Mac OS =
with =E2=80=98Mac Os Extended (Journaled). Then the Parallels formatted =
VM files are created on it.=20
BTW, this files are created as =E2=80=9CExpanding disc=E2=80=9D, so they =
occupy only some MB in the beginning and grow by time. Should this be a =
problem?

Actually I liked a lot your idea of creating the file in raw format and =
thus being able to inspect things outside the VM.=20
How can I do this? Do you have any idea?

Thanks a lot guys!

Chris



