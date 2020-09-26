Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8117C279B5D
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Sep 2020 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIZR13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Sep 2020 13:27:29 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:47732 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIZR12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Sep 2020 13:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1601141246;
        bh=pn6MMBPhZHPy8MyekBRIirWUlEmLS/GcPTb4aLrZliM=;
        h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id;
        b=FnQAER31XG1txzut64pHR0CrWCUrMynLR1ueMX1F6EFd4KUBGuCMTpEz55xWxUdwp
         3tne31ii4QhRMLr1B9oCD4BYXG1yURePxMGCeBVJLH9Qd1QsW7a2ZifJg5IFmedve2
         2OAv8DwnOUI8gKOBWXJR/xztmJzDzl9lfS0J3YPcADlRcRRzS6Ej64hIYPf7SdL4Tq
         h24a9ZOxYCABvqLK0oO6J9Dq/GCX0psqnFnUFAql9GTzbO17ut5hxVMzQhol3G6ssh
         8jxVlkb6UdRmrzBCfJFLTwp/WnkfTrmKDOOem3wzOOZ+FZ2+zoskbkXuVbeNPtMfB6
         eeOyJq/YebR9A==
Received: from [192.168.10.109] (108-230-77-122.lightspeed.chtnsc.sbcglobal.net [108.230.77.122])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id E3675700505
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Sep 2020 17:27:25 +0000 (UTC)
From:   J J <j333111@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Drive won't mount, please help
Date:   Sat, 26 Sep 2020 13:27:24 -0400
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
 <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
Message-Id: <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-26_15:2020-09-24,2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009260161
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ran btrfs-restore and recovered some data, but not most, and not the =
most critical. Believe it or not, my other backup drive failed within =
the same week (different file system, different location), so I=E2=80=99m =
worried I lost a lot of data.

I'm Following this page https://btrfs.wiki.kernel.org/index.php/Restore, =
is this the best source for information?

  find-root command did not help, It showed=20
	=E2=80=9CWell block 11516668403712 seems good=E2=80=9D  =20
 but it didn=E2=80=99t show any of the Generation lines to choose from.

Any reason to disable the write cache now? Or did you mean for future =
workaround?

Will btrfs-zero-log help?

How about these?
	=E2=80=A2 -s: Also restore snapshots. Without this option =
snapshots will not be restored.
	=E2=80=A2 -x: Get extended attributes. Without this option, =
extented attributes will not be retrieved.
	=E2=80=A2 -m: Restore metadata: owner, mode and times.

Should I move on to this advice? from =
https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/

		If we are still not able to mount normally, we can now =
run btrfs rescue super-recover, which will try to restore the superblock =
from a good copy. This is not completely safe.

		As mentioned before, if your metadata was corrupt there =
is a chance that files or part of files that are not damaged are not =
seen by the filesystem. In this scenario, we can use btrfs rescue =
chunk-recover /dev/sdXY to scan the whole drive contents and try to =
rebuild the metadata trees. This will take very long specially for big =
drives, and could result in some of the data being wrongly restored.

Thank you for your time!!

> On Sep 24, 2020, at 7:14 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2020/9/25 =E4=B8=8A=E5=8D=886:28, J J wrote:
>> Thanks for your help Qu.
>> So is the data lost? Should I follow the procedure to recover what I =
can to another disk?
>> Any other suggestions for next steps?
>=20
> btrfs-restore is the normally the tool you need to salvage your data.
>=20
> Thanks,
> Qu
>>=20
>>> On Sep 14, 2020, at 4:34 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>> On 2020/9/14 =E4=B8=8A=E5=8D=884:56, J J wrote:
>>>> I=E2=80=99m new to a lot of this, just trying to use a NAS at home, =
single usb external disk, not RAID. Was working great for a few months, =
I=E2=80=99m not sure what changed today when it stopped mounting. Any =
advice appreciated.
>>>=20
>>> Transid mismatch, and the expected transid is newer than the on-disk
>>> transid.
>>>=20
>>> This means, either btrfs has some bug that causes metadata writeback =
not
>>> following COW, or the disk controller/disk itself ignores Flush/FUA
>>> commands.
>>>=20
>>> Considering it's usb external disk, I doubt the later case.
>>>=20
>>> In that case, any fs would experience similar problem if a sudden =
power
>>> loss or cable loss happened.
>>>=20
>>> You may workaround such problem by disabling the writecache, but I =
doubt
>>> if the USB->Sata convert would follow the request.
>>>=20
>>> Thanks,
>>> Qu
>>>>=20
>>>> Dmesg log attached
>>>>=20
>>>>=20
>>>> uname -a
>>>> Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed =
Aug 28 08:59:34 UTC 2019 aarch64 GNU/Linux
>>>>=20
>>>>=20
>>>>=20
>>>> btrfs --version
>>>> btrfs-progs v4.7.3
>>>>=20
>>>>=20
>>>>=20
>>>> btrfs fi show
>>>> Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
>>>> 	Total devices 1 FS bytes used 2.48TiB
>>>> 	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt
>>>>=20
>>>>=20
>>>> btrfs fi df /dev/mapper/sda-crypt
>>>> ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt
>>>>=20
>>>>=20
>>>> btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
>>>> superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
>>>> ---------------------------------------------------------
>>>> csum_type		0 (crc32c)
>>>> csum_size		4
>>>> csum			0x9e8b0c33 [match]
>>>> bytenr			65536
>>>> flags			0x1
>>>> 			( WRITTEN )
>>>> magic			_BHRfS_M [match]
>>>> fsid			71eda2e3-384c-4868-b5d4-683f222865e6
>>>> label			3TBRock64
>>>> generation		395886
>>>> root			2638934654976
>>>> sys_array_size		129
>>>> chunk_root_generation	377485
>>>> root_level		1
>>>> chunk_root		20971520
>>>> chunk_root_level	1
>>>> log_root		2638952366080
>>>> log_root_transid	0
>>>> log_root_level		0
>>>> total_bytes		3000556847104
>>>> bytes_used		2729422221312
>>>> sectorsize		4096
>>>> nodesize		16384
>>>> leafsize		16384
>>>> stripesize		4096
>>>> root_dir		6
>>>> num_devices		1
>>>> compat_flags		0x0
>>>> compat_ro_flags		0x0
>>>> incompat_flags		0x161
>>>> 			( MIXED_BACKREF |
>>>> 			  BIG_METADATA |
>>>> 			  EXTENDED_IREF |
>>>> 			  SKINNY_METADATA )
>>>> cache_generation	395886
>>>> uuid_tree_generation	395886
>>>> dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
>>>> dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 =
[match]
>>>> dev_item.type		0
>>>> dev_item.total_bytes	3000556847104
>>>> dev_item.bytes_used	2843293515776
>>>> dev_item.io_align	4096
>>>> dev_item.io_width	4096
>>>> dev_item.sector_size	4096
>>>> dev_item.devid		1
>>>> dev_item.dev_group	0
>>>> dev_item.seek_speed	0
>>>> dev_item.bandwidth	0
>>>>=20
>>>>=20
>>>> dev_item.generation	0
>>>>=20
>>>=20
>>=20
>=20

