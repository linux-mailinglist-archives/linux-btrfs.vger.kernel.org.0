Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019B14303F8
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhJPRh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 13:37:59 -0400
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:49187 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244452AbhJPRh4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 13:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1634405747;
        bh=AM2y3OCEosnlh+aPzxPry3MAO4jFC+2dv6RYC/uwqtg=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=kft+mmqbSMglgwPGH81ndbybV8utTA9vlbOfqyJn0UE3HgoMsK1rRbkT93g/ErHy8
         v/d3xXlTI1b3y9Ut0KB+U7V2/hYxp9YTdHRMUbQRUbvidtsukoEo8Vt4ICY3vJeGui
         Eke8rQDH1TJXnQP2lRwgcpIfDlIAMAEY7a6VpOL4+qs8A2wPJ2XcroNdN7EEyr01YJ
         SdzptF3/JX382PPzvK9JbdFLqKToIwIb5tlDZEZajWpA/QyuHYRburt1HFS+piuthJ
         5NedtNubBAt3je0OxukhPDSITqH/+aIowhq61UqI3Ea2BAb1pf5UclmZ6GMXKNSrid
         YHXP0Wh+auhRw==
Received: from smtpclient.apple (unknown [152.249.37.238])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 9E8C5C80279;
        Sat, 16 Oct 2021 17:35:41 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: need help in a broken 2TB BTRFS partition
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
Date:   Sat, 16 Oct 2021 14:35:38 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B57D8AFF-FE6E-4CC2-B6C1-066F3A8CEDF0@icloud.com>
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
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
 <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
 <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-10-16=5F05:2021-10-14=5F02,2021-10-16=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2110160120
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTW, due to some unsuccessful boot attempts this disc /dev/sdd1 does not =
work any more with =E2=80=9C-o ro,rescue=3Dall=E2=80=9D
so I decided to try some nasty commands like the following:


Suse_Tumbleweed:/home/proc # btrfs rescue chunk-recover /dev/sdd1
Scanning: 4914069504 in dev0cmds/rescue-chunk-recover.c:130: =
process_extent_buffer: BUG_ON `exist->nmirrors >=3D BTRFS_MAX_MIRRORS` =
triggered, value 1
btrfs(+0x1a121)[0x55830a51d121]
btrfs(+0x508dc)[0x55830a5538dc]
/lib64/libc.so.6(+0x8db37)[0x7fa8984cbb37]
/lib64/libc.so.6(+0x112640)[0x7fa898550640]
Aborted (core dumped)

Unfortunately the program crashes. Is this expected?

What else can I try if the mount command reports:

Suse_Tumbleweed:/home/proc # mount -o ro,rescue=3Dall /dev/sdd1 =
/home/promise2/disk3
mount: /home/promise2/disk3: wrong fs type, bad option, bad superblock =
on /dev/sdd1, missing codepage or helper program, or other error.





> On 16. Oct 2021, at 07:08, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2021/10/16 05:01, Christian Wimmer wrote:
>> Hi Qu,
>>=20
>> I hope I find you well.
>>=20
>> Almost two years that my system runs without any failure.
>> Since this is very boring I tried make my life somehow harder and =
tested again the snapshot feature of my Parallels Desktop installation =
yesterday:-)
>> When I erased the old snapshots I could feel (and actually hear) =
already that the system is writing too much to the partitions.
>> What I want to say is that it took too long (for any reason) to erase =
the old snapshots and to shut the system down.
>=20
> The slow down seems to be caused by qgroup.
>=20
> We already have an idea how to solve the problem and have some patches
> for that.
>=20
> Although it would add a new sysfs interface and may need user space
> tools support.
>=20
>>=20
>> Well, after booting I saw that one of the discs is not coming back =
and I got the following error message:
>>=20
>> Suse_Tumbleweed:/home/proc # btrfs check /dev/sdd1
>> Opening filesystem to check...
>> parent transid verify failed on 324239360 wanted 208553 found 184371
>> parent transid verify failed on 324239360 wanted 208553 found 184371
>> parent transid verify failed on 324239360 wanted 208553 found 184371
>=20
> This is the typical transid mismatch, caused by missing writes.
>=20
> Normally if it's a physical machine, the first thing we suspect would =
be
> the disk.
>=20
> But since you're using an VM in MacOS, it has a whole storage stack to
> go through.
>=20
> And any of the stack is not handling flush/fua correctly, then it can
> definitely go wrong like this.
>=20
>=20
>> Ignoring transid failure
>> leaf parent key incorrect 324239360
>> ERROR: failed to read block groups: Operation not permitted
>> ERROR: cannot open file system
>>=20
>>=20
>> Could you help me to debug and repair this please?
>=20
> Repair is not really possible.
>=20
>>=20
>> I already run the command btrfs restore /dev/sdd1 . and could restore =
90% of the data but not the important last 10%.
>=20
> Using newer kernel like v5.14, you can using "-o ro,rescue=3Dall" =
mount
> option, which would act mostly like btrfs-restore, and you may have a
> chance to recover the lost 10%.
>=20
>>=20
>> My system is:
>>=20
>> Suse Tumbleweed inside Parallels Desktop on a Mac Mini
>>=20
>> Mac Min: Big Sur
>> Parallels Desktop: 17.1.0
>> Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 =
03:36:02 UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux
>>=20
>> Suse_Tumbleweed:~ # btrfs --version
>> btrfs-progs v5.13
>>=20
>> The disk /dev/sdd1 is one of several 2TB partitions that reside on a =
NAS attached to the Mac Mini like
>=20
> /dev/sdd1 is directly mapped into the VM or something else?
>=20
> Or a file in remote filesystem (like NFS) then mapped into the VM?
>=20
> Thanks,
> Qu
>=20
>>=20
>> Disk /dev/sde: 2 TiB, 2197949513728 bytes, 4292870144 sectors
>> Disk model: Linux_raid5_2tb_
>> Units: sectors of 1 * 512 =3D 512 bytes
>> Sector size (logical/physical): 512 bytes / 4096 bytes
>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>> Disklabel type: gpt
>> Disk identifier: 942781EC-8969-408B-BE8D-67F6A8AD6355
>>=20
>> Device     Start        End    Sectors Size Type
>> /dev/sde1   2048 4292868095 4292866048   2T Linux filesystem
>>=20
>>=20
>> What would be the next steps to repair this disk?
>>=20
>> Thank you all in advance for your help,
>>=20
>> Chris
>>=20

