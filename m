Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA41309B0
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 20:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAETtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 14:49:16 -0500
Received: from ms11p00im-qufo17282001.me.com ([17.58.38.57]:33693 "EHLO
        ms11p00im-qufo17282001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgAETtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 14:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578253754;
        bh=+vJoG6jNVWIeNGU8Sg++AqxZfDi6FSKaooKUDgBBc4Q=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=lfttdXHXxbyfJwO2RECuTDEtsJi1H+MWzscWJOcUTmIKePrTwRwhPOuhfHZdEvfr8
         0YVzum8YJyegZhocOKSSfqL+nBHlAuObp/m381TrH7izkXG0cgaeo9D07nuFwlbJJP
         B5LTgwUZieznTDPuKFdu1YCLA8PclCvaqKlkQ6XvboYtGz4oaTuypkdAAwT+rWR76z
         pzcbaRMTXxPJXSNsfXidG3YmGNbjnRbJRMezZe0kWqG2N/AheK/xSVImGbqmpZ9lc1
         os9p7impbQEpUkemnfQmpWeUQqfyNBgkaWbJvvA0NCU7FDcngXmz6BTpjHjTgr1mKn
         b36QUiClBc8LA==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id BC587A00630;
        Sun,  5 Jan 2020 19:49:10 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
Date:   Sun, 5 Jan 2020 16:49:10 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8CD32C6-1CAF-45ED-B0D8-62B9D74055D1@icloud.com>
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
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050183
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 5. Jan 2020, at 16:36, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Sun, Jan 5, 2020 at 12:18 PM Christian Wimmer
> <telefonchris@icloud.com> wrote:
>>=20
>>=20
>>=20
>>> On 5. Jan 2020, at 15:50, Chris Murphy <lists@colorremedies.com> =
wrote:
>>>=20
>>> On Sun, Jan 5, 2020 at 7:17 AM Christian Wimmer =
<telefonchris@icloud.com> wrote:
>>>>=20
>=20
>>>> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: =
[1297857.324177] sda2: rw=3D2051, want=3D532656128, limit=3D419430400
>=20
>> /dev/sda is the hard disc file that holds the  Linux:
>>=20
>> #fdisk -l
>> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
>> Disk model: Suse 15.1-0 SSD
>> Units: sectors of 1 * 512 =3D 512 bytes
>> Sector size (logical/physical): 512 bytes / 4096 bytes
>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>> Disklabel type: gpt
>> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
>>=20
>> Device         Start       End   Sectors  Size Type
>> /dev/sda1       2048     18431     16384    8M BIOS boot
>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
>> /dev/sda3  532674560 536870878   4196319    2G Linux swap
>=20
>=20
> Why does the kernel want=3D532656128 but knows the limit=3D419430400? =
The
> limit matches the GPT partition map.
>=20
> What do you get for
>=20
> btrfs insp dump-s /dev/sda2

Here I have only btrfs-progs version 4.19.1:

linux-ze6w:~ # btrfs version
btrfs-progs v4.19.1=20
linux-ze6w:~ # btrfs insp dump-s /dev/sda2
superblock: bytenr=3D65536, device=3D/dev/sda2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x6d9388e2 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    affdbdfa-7b54-4888-b6e9-951da79540a3
metadata_uuid           affdbdfa-7b54-4888-b6e9-951da79540a3
label
generation              799183
root                    724205568
sys_array_size          97
chunk_root_generation   797617
root_level              1
chunk_root              158835163136
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             272719937536
bytes_used              106188886016
sectorsize              4096
nodesize                16384
leafsize (deprecated)           16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x163
                        ( MIXED_BACKREF |
                          DEFAULT_SUBVOL |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        799183
uuid_tree_generation    557352
dev_item.uuid           8968cd08-0c45-4aff-ab64-65f979b21694
dev_item.fsid           affdbdfa-7b54-4888-b6e9-951da79540a3 [match]
dev_item.type           0
dev_item.total_bytes    272719937536
dev_item.bytes_used     129973092352
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0



>=20
>=20
>>> This is a virtual drive inside the
>>> guest VM? And is backed by a file on the Promise storage? What about
>>> /dev/sdb? Same thing? You're only having a problem with /dev/sdb,
>>> which contains a Btrfs file system.
>>=20
>> Actually I have only a problem with the /dev/sdb which is a hard disc =
file on my Promise storage. The sda2 complains but boots normally.
>=20
> sda2 complains? You mean just the previously mentioned FITRIM I/O
> failures? Or there's more?

Only what I found in the previously mentioned messages. Nothing else.

>=20
>=20
>>=20
>> Regarding any logs. Which log files I should look at and how to =
display them?
>> I looked at the /var/log/messages but did not find any related =
information.
>=20
> Start with
>=20
> systemctl status fstrim.timer
> systemctl status fstrim.service

linux-ze6w:~ # systemctl status fstrim.timer
=E2=97=8F fstrim.timer - Discard unused blocks once a week
   Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; enabled; vendor =
preset: enabled)
   Active: active (waiting) since Sun 2020-01-05 15:24:59 -03; 1h 19min =
ago
  Trigger: Mon 2020-01-06 00:00:00 -03; 7h left
     Docs: man:fstrim

Jan 05 15:24:59 linux-ze6w systemd[1]: Started Discard unused blocks =
once a week.

linux-ze6w:~ # systemctl status fstrim.service
=E2=97=8F fstrim.service - Discard unused blocks on filesystems from =
/etc/fstab
   Loaded: loaded (/usr/lib/systemd/system/fstrim.service; static; =
vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:fstrim(8)
linux-ze6w:~ #=20

>=20
> Find the location of the fstrim.service file and cat it, and post that
> too. I want to know exactly what fstrim options it's using. Older
> versions try to trim all file systems.

linux-ze6w:~ # cat /usr/lib/systemd/system/fstrim.service
[Unit]
Description=3DDiscard unused blocks on filesystems from /etc/fstab
Documentation=3Dman:fstrim(8)

[Service]
Type=3Doneshot
ExecStart=3D/usr/sbin/fstrim -Av
linux-ze6w:~ #=20



>=20
> journalctl --since=3D-8d | grep fstrim


journalctl --since=3D-8d

this command shows only the messages from today and there is no fstrim =
inside

Chris

