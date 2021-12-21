Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC07A47B832
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLUCF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:05:57 -0500
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:41757 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235868AbhLUCFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1640052316; bh=uuLp7KsmDgPgg4owmCeQkPYFoyxvGlPoLyA9U/B7+DM=;
        h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        b=Qqm4tV57JYQeDwmDNPZN2zn24lxWS89LKgdLdTgNfmHRoJAanYVKO5uLixj05Jivc
         d99j6/OwNfqFXvqhpysN2odiqXkyAd+zoH65DRp2HgmdTFFs0cyGybsfy9rjODxjNx
         vZWPLgVUhQqfkc+t5qE5V3/yW2KmPxJ0Y8XHiS+Jw8HQw3hZwRbiBfJ5XmN/x5Yjyj
         KBaG0iD3q8qp7F5fHK7HyWzV1V/qX0IaRf1blgSXzsW699DEBei8sqYWrFkTSTL0iZ
         K0x8fAqp4WVNDTDHzUIkk0JWKHpd260ECfSVogsNXl51AvfXiM/tO7/KvHNJ4VpI2G
         +pSKpD8hiLXtw==
Received: from ALEXIS-PC (aaubervilliers-654-1-69-97.w82-121.abo.wanadoo.fr [82.121.144.97])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 8A1B92A070B;
        Tue, 21 Dec 2021 02:05:15 +0000 (UTC)
Date:   Tue, 21 Dec 2021 03:05:12 +0100
From:   Tuetuopay <tuetuopay@me.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "=?utf-8?Q?linux-btrfs=40vger.kernel.org?=" 
        <linux-btrfs@vger.kernel.org>
Message-ID: <41C61371-EB11-42B4-A9C8-6296D45CB9A7@getmailspring.com>
In-Reply-To: <ce91d387-78e0-3e8e-fd05-a3f952352e73@gmx.com>
References: <ce91d387-78e0-3e8e-fd05-a3f952352e73@gmx.com>
Subject: Re: btrfs_free_extent
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-20=5F10:2021-12-16=5F01,2021-12-20=5F10,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112210007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Thank you so much for your advice. The check in repair mode did indeed
work without issue, and the issues I had with the files now seem gone.
I'm stressing a bit the drives right now to see if everything's solved,
but it looks like it.

Cheers=21
Alexis

On d=C3=A9c. 21 2021, at 12:20 am, Qu Wenruo <quwenruo.btrfs=40gmx.com> w=
rote:
> On 2021/12/21 04:30, Tuetuopay wrote:
>> Hi,
>> =20
>> It's me again. I have completed several memtest86+ passes without erro=
rs
>> whatsoever, so this RAM can be considered good. Also, following your
>> advice, I built and upgraded the kernel to the latest stable, i.e. 5.1=
5.10.
>> =20
>> What is the next step to (hopefully) fix the error=3F Is it to run =60=
btrfs
>> check=60 but not in readonly mode. I think I'll need to upgrade
>> btrfs-progs too since I'm now running 5.15.10 instead of 5.10.70.
> =20
> Yes, latest btrfs-progs is always recommended.
> =20
> After backing up the important data and upgrading btrfs-progs, =22btrfs=

> check --repair=22 could at least solve the extent tree problem.
> =20
> Thanks,
> Qu
>> =20
>> Thank you so much in advance=21
>> =20
>> Alexis
>> =20
>> On d=C3=A9c. 20 2021, at 10:35 am, Tuetuopay <tuetuopay=40me.com> wrot=
e:
>>> Hi, thanks for the swift reply=21
>>> =20
>>> On d=C3=A9c. 20 2021, at 12:42 am, Qu Wenruo <quwenruo.btrfs=40gmx.co=
m> wrote:
>>>> On 2021/12/19 23:24, Tuetuopay wrote:
>>>>> Hi,
>>>>> =20
>>>>> I need some advice on a btrfs raid-1 volume that shows a few corrup=
tions
>>>>> on some places. I have some files that triggered some safeguards on=

>>>>> write, which ended up remounting the fs as read-only.
>>>>> =20
>>>>> Over on IRC, multicore suggested me to run a readonly check, whose
>>>>> output is here:
>>>>> =20
>>>>> =23 btrfs check --readonly
>>>>> /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40=
b2bec8f21b
>>>>> UUID: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>> =5B1/7=5D checking root items
>>>>> =5B2/7=5D checking extents
>>>>> tree backref 9882747355136 root 7 not found in extent tree
>>>>> backref 9882747355136 root 23 not referenced back 0x556ea3cb07d0
>>>> =20
>>>> This is one corruption in extent tree, we don't have root 23 at all.=

>>>> Only root 7 is correct.
>>>> =20
>>>> On the other hand, 23 =3D 0x17, while 7 =3D 0x07.
>>>> =20
>>>> So, see a pattern here=3F
>>>> =20
>>>> Thus recommend to memtest to make sure it's not a memory bitflip cau=
sing
>>>> the corruption in the first hand.
>>> =20
>>> That definitely looks like a bitflip to me.
>>> =20
>>>>> incorrect global backref count on 9882747355136 found 2 wanted 1
>>>>> backpointer mismatch on =5B9882747355136 16384=5D
>>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>>> =5B3/7=5D checking free space cache
>>>>> =5B4/7=5D checking fs roots
>>>>> root 5 inode 1626695 errors 40000
>>>>> Dir items with mismatch hash:
>>>>> 	name: fendor.qti.hardware.sigma=5Fmiracast=401.0-impl.so namelen: =
46 wanted
>>>>> 0x12c67915 has 0x0471bc31
>>>>> root 5 inode 1626696 errors 2000, link count wrong
>>>>> 	unresolved ref dir 1626695 index 2 namelen 46 name
>>>>> vendor.qti.hardware.sigma=5Fmiracast=401.0-impl.so filetype 1 error=
s
>>>>> 1, no
>>>>> dir item
>>>> =20
>>>> This can also be caused by memory bitfip.
>>>> =20
>>>> =46ortunately, both cases should be repairable.
>>>> But that should only be done after you have checked your memory.
>>>> You won't want to have unreliable memory which can definitely cause =
more
>>>> damage during repair.
>>>> =20
>>>> But it's still better to keep important data backed up.
>>> =20
>>> Yes, definitely a bitflip, f =3D 0x66 and v =3D 0x76.
>>> =20
>>>>> ERROR: errors found in fs roots
>>>>> found 6870080626688 bytes used, error(s) found
>>>>> total csum bytes: 6668958308
>>>>> total tree bytes: 9075539968
>>>>> total fs tree bytes: 1478344704
>>>>> total extent tree bytes: 243793920
>>>>> btree space waste bytes: 820626944
>>>>> file data blocks allocated: 326941710356480
>>>>>    referenced 6854941941760
>>>>> =20
>>>>> They suggested that I run a non-ro check, but warned that it could =
do
>>>>> more harm than good, hence this email seeking advice. Has check any=

>>>>> chance to fix the issue=3F
>>>>> =20
>>>>> I think I should also mention that I'm fine deleting those specific=

>>>>> files as I can get them back somewhat easily.
>>>>> =20
>>>>> To finish off, here is the information requested by the wiki page:
>>>>> =20
>>>>> =24 uname -a
>>>>> Linux gimli 5.10.70-3ware =231 SMP Wed Dec 15 03:46:13 CET 2021
>>>>> x86=5F64 GNU/Linux
>>>> =20
>>>> One thing to mention is, if you're running kernel newer than v5.11, =
the
>>>> last corruption (the one on name hash mismatch) can be detected earl=
y,
>>>> without writing the corrupted data back to disk.
>>>> =20
>>>> Thus it's recommended to use newer kernel.
>>> =20
>>> Amazing advice. I'll definitely upgrade the kernel, likely latest.
>>> =20
>>>> Thanks,
>>>> Qu
>>> =20
>>> Thank you very much to you=21 I just started a full memtest on the
>>> machine. I expect it to be good, since the RAM is brand new (just
>>> swapped the whole system due to the previous motherboard dying), but =
you
>>> never know. I'll get back to you with the results=21
>>> =20
>>> Also, if I can get my hands on a DDR3 system, I'll test the old ram t=
o
>>> be sure. If this ends up being a RAM issue, I'll send back the curren=
t
>>> one and buy some ECC memory.
>>> =20
>>> Thanks,
>>> Alexis
>>> =20
>>>>> =24 btrfs fi show
>>>>> Label: none  uuid: 381bd0ef-20cb-4517-b825-d45630a6ca0a
>>>>> 	Total devices 1 =46S bytes used 65.49GiB
>>>>> 	devid    1 size 111.79GiB used 111.79GiB path /dev/sdk1
>>>>> =20
>>>>> Label: 'storage'  uuid: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>> 	Total devices 5 =46S bytes used 6.25TiB
>>>>> 	devid    1 size 2.73TiB used 2.50TiB path /dev/sdd
>>>>> 	devid    2 size 2.73TiB used 2.50TiB path /dev/sdc
>>>>> 	devid    4 size 931.51GiB used 702.00GiB path /dev/sdf
>>>>> 	devid    6 size 3.64TiB used 3.41TiB path /dev/sdg
>>>>> 	devid    7 size 3.64TiB used 3.41TiB path /dev/sdh
>>>>> =20
>>>>> =24 btrfs fi df /media/storage
>>>>> Data, RAID1: total=3D6.25TiB, used=3D6.24TiB
>>>>> System, RAID1: total=3D32.00MiB, used=3D944.00KiB
>>>>> Metadata, RAID1: total=3D10.00GiB, used=3D8.45GiB
>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>> =24 btrfs --version
>>>>> btrfs-progs v5.10.1
>>>>> =20
>>>>> The dmesg is attached to the email, but most of the =60BTR=46S
>>>>> critical=60 log
>>>>> lines related to name corruption have been removed to get the file
>>>>> to 200KB.
>>>>> =20
>>>>> Some things to note:
>>>>> - I recently upgraded the machine from Debian 9 to 11, getting the
>>>>> kernel from 4.9 to 5.10, but the issue already existed on 4.9 (it e=
ven
>>>>> started there, prompting me to replace a drive as I though it to
>>>>> be the
>>>>> source of the corruption).
>>>>> - The kernel is almost the vanilla debian bullseye kernel, with an =
added
>>>>> (tiny) patch to fix an issue between 3Ware RAID cards and AMD Ryzen=

>>>>> CPUs. It should not affect the BTR=46S subsystem as it adds a quirk=

>>>>> to the
>>>>> PCIe subsystem.
>>>>> - I have a few name mismatches, which can be seen in the logs too. =
While
>>>>> I'd love someday to get rid of them, I simply moved the affected fi=
les
>>>>> in a corner for now. That's not the issue I'm trying to solve now
>>>>> (though if someone can help, I'd be glad). They come from a ZIP arc=
hive,
>>>>> so deleting them is fine, but I can't as I only get =22Input/Output=
 error=22
>>>>> when trying to rm them.
>>>>> =20
>>>>> Thank you very much to whoever can help=21
>>>> =20
> 
