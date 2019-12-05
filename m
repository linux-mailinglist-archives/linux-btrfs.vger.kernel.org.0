Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56E114844
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLEUnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 15:43:00 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:43764 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfLEUnA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 15:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575578578;
        bh=U3ZmzaCbfjMmSrUsp2GbcaAOYgYxyjpuUxTsLVPVa08=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=nks6UpwgRmhzCZn6tATgEHFEd4a6upNHtV84lnudcJVRri1bM4lxji+q9SUtK14wV
         GxuCPFC7NunWTQ8CD5NpoxdwziZuLmXK0sZSu08AGebu6xDuq+uux3zgk9iII96bl2
         BmfQoEkiwMGQA14/EMKCeiC0pzxMyDDwDfQ/oddp4RzKkzeJ8j+IwDC8VfztXnPa3k
         U7aFXixPshgrmVyTn9sTJnCTdsg1wADFGuLLVZH2NtSRYxdHmySYUkIQ4Nachi2tEN
         sJJon3sy1uVz2jB9wh6BlxTT2XLvHcvEpbjO2LnCk41DZkvF46WCLcrgta3riJ6me1
         o/MLi6+26jDkw==
Received: from [100.98.43.211] (unknown [5.62.51.38])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 8FEB3AC0728;
        Thu,  5 Dec 2019 20:42:57 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <20191205202449.GH4760@savella.carfax.org.uk>
Date:   Thu, 5 Dec 2019 17:42:55 -0300
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
To:     Hugo Mills <hugo@carfax.org.uk>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912050170
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Hugo,

I am so happy to hear your voice!

I would be very happy if you could help me get my filesystem back =
working.

Here is my setup (little special):

Mac Mini 2018
Inside Mac Mini I run Parallels and inside Parallels I run Suse 15.2
Promise Pegasus R8 with 32TB, divided into a 24TB and 4TB partition =
formatted under Mac OS.
Inside Promise Pegasus Storage (the 24TB Partition) I have the virtual =
disc that is attached to the Parallels Linux.
This virtual disc is formatted with btrfs and appears in Linux under:

Disk /dev/sde: 11.7 TiB, 12884901888000 bytes, 25165824000 sectors
Disk model: Linux_raid5_12tb
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 2EFA3FA4-8849-40CE-A065-6CDF3581894B

Device     Start         End     Sectors  Size Type
/dev/sde1   2048 25165821951 25165819904 11.7T Linux filesystem


When I try to mount it this happens:

# mount /dev/sde1 /home/promise/
mount: /home/promise: wrong fs type, bad option, bad superblock on =
/dev/sde1, missing codepage or helper program, or other error.
#=20

dmesg says:
[ 2376.180819] BTRFS info (device sde1): disk space caching is enabled
[ 2376.180820] BTRFS info (device sde1): has skinny extents
[ 2376.275469] BTRFS error (device sde1): bad tree block start =
14275350892879035392 5349895454720
[ 2376.283339] BTRFS error (device sde1): bad tree block start =
14275350892879035392 5349895454720
[ 2376.344799] BTRFS error (device sde1): open_ctree failed


The command btrfs restore tells:

linux-ze6w:/home/chris # btrfs restore -x /dev/sde1 test/
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
Could not open root, trying backup super
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
Could not open root, trying backup super
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
checksum verify failed on 5349895454720 found B80B9FA8 wanted C61C3C00
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
Couldn't setup device tree
Could not open root, trying backup super
linux-ze6w:/home/chris # btrfs restore -v /dev/sde1 test/


Now what I did in order for all this to happen was the following:

I was editing a file inside Linux with sublime_text.
Inside this editor I wanted to "replay macro=E2=80=9D and the command =
for it is CTRL-ALT-SHIFT-Q which is the same command for rebooting the =
MAC.
When I pressed that command it was already too late and my Mac began to =
reboot, doing a suspend of the virtual machine.
So far so good.
I rebooted the MAC and started Parallels and the suspended Linux woke up =
again and I entered in the /home/promise directory where /dev/sde1 is =
mounted and I say only some=20
files instead of all 5TB data. Some directories were empty, some had =
broken links and so on.
So I discovered that something went wrong during reboot and thus I shut =
down the linux.
When I started linux again, I could not mount any more the promise.

Please help me to get out of this.

I did a backup of the 5,5TB hard disc file of Parallels, so we can play =
a little.

What would you suggest to do?
Actually I do not need all files of that disc, only some. IS there any =
chance to mount and copy what I need?

Thanks a lot for your patience and your time for reading this Hugo.

Best regards,

Chris




> On 5. Dec 2019, at 17:24, Hugo Mills <hugo@carfax.org.uk> wrote:
>=20
> On Thu, Dec 05, 2019 at 05:00:40PM -0300, Christian Wimmer wrote:
>> Hi, my name is Chris,=20
>>=20
>> is this the right place for asking on support on how to repair a =
broken btrfs?
>>=20
>> There is no hardware problem, just that the power went out and now I =
can not mount any more.
>=20
>   What does dmesg say when you try to mount the FS?
>=20
>> Who is the best specialist that could help here?
>>=20
>> Of course I already scanned the WEB some hours and tried all =
not-destructive commands without success.
>=20
>   "Non-destructive" is a fairly limited of things, and most of the
> easily-findable advice on the web about fixing btrfs filesystems is at
> best badly misguided, if not actively wrong. :(
>=20
>   Can you also tell us exactly what you ran?
>=20
>   Hugo.
>=20
> --=20
> Hugo Mills             | Is it true that "last known good" on Windows =
XP
> hugo@... carfax.org.uk | boots into CP/M?
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |                                       Adrian =
Bridgett

