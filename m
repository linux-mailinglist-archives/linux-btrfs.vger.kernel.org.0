Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE39401526
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 05:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhIFDGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 23:06:33 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:59049 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhIFDGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Sep 2021 23:06:32 -0400
Date:   Mon, 06 Sep 2021 03:05:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630897522; bh=XQbDFn/kABEczMWI64jIvzCH6WtXnc65j5e3jrFS3ec=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=nWWCqm5G1oZs7KxgdEgIMjUfQh6FYUaXhB21AxkRHKIKS/BVt8VSZTbJWUlRpmvJL
         NHN3JG9O/wYbK10lnrg0L2a1kYPwqmTzBnJDFSdLI0GB1Ox48gqhar7AZFePxNGtwa
         TTzma4V4SsyAEszJR7uJrMRTEKezJHJzNgFnT9dtG1WU5fwV9i/LolTW1fiReVKSGg
         5WG1kNJa1586jNdUZEzpW2u6gcg/Dm+2D57MSkf2dqszAYzc2D3OnKPL31R+LHM8l5
         1DR3prMJMlRiw6F3Zqvd1EjFcxYCzBA5dOPuFcG5lNdxflivBvz0oW7rnLkWCczf2P
         XWfvKZOIOrnJA==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
In-Reply-To: <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com> <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me> <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------561401da3d85c481682ec64cd4a797b8fafa3a955e4061bda3377b43875d5dc3"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------561401da3d85c481682ec64cd4a797b8fafa3a955e4061bda3377b43875d5dc3
Content-Type: multipart/mixed;boundary=---------------------9fda48609e2e4bc12a8016ba95c51d15

-----------------------9fda48609e2e4bc12a8016ba95c51d15
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, September 5th, 2021 at 10:47 PM, Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:

> On 2021/9/6 =E4=B8=8A=E5=8D=8810:35, ahipp0 wrote:
> =


> > Qu,
> > =


> > Thank you so much for taking a look!
> > =


> > Please, see my comments inline below.
> > =


> > On Sunday, September 5th, 2021 at 9:08 PM, Qu wrote:
> > =


> > > On 2021/9/5 =E4=B8=8B=E5=8D=883:34, ahipp0 wrote:
> > =


> > > > Hi!
> > =


> > > > I started having various fun BTRFS warnings/errors/critical messag=
es all of a sudden
> > > > =


> > > > after downloading and extracting linux-5.14.1.tar.xz on a fairly n=
ew (~1TiB read/written) Samsung SSD 970 EVO Plus 500GB.
> > > > =


> > > > The laptop was resumed from suspend-to-disk ~30 minutes prior to t=
hat, I think.
> > =


> > > > Hardware:
> > > > =


> > > > TUXEDO Pulse 14 - Gen1
> > > > =


> > > > CPU: AMD Ryzen 7 4800H
> > > > =


> > > > RAM: 32GiB
> > > > =


> > > > Disk: Samsung SSD 970 EVO Plus 500GB
> > > > =


> > > > Distro: Kubuntu 20.04.2
> > > > =


> > > > Kernel: 5.11.x
> > =


> > > I'm pretty sure you have used the btrfs partition for a while, as th=
e
> > > =


> > > corrupted tree block would be rejected by kernel starting from v5.11=
.
> > =


> > > Thus such corrupted tree block should not be written to disk, thus t=
he
> > > =


> > > problem must be there for a while before you upgrading to v5.11 kern=
el.
> > =


> > Fair enough, it's been like 3 months approximately.
> > =


> > Looking at the logs, it seems I created the filesystem with 5.8 kernel=
.
> > =


> > 6/06 -- install of 5.8.0-55.62~20.04.1 -- this is when the filesystem =
was created
> > =


> > 6/26 -- upgrade to 5.8.0-59.66~20.04.1
> > =


> > 7/22 -- upgrade to 5.8.0-63.71~20.04.1
> > =


> > 8/07 -- upgrade to 5.11.0-25.27~20.04.1
> > =


> > 8/19 -- upgrade to 5.11.0-27.29~20.04.1
> > =


> > I think, a good chunk of data was written while on 5.8 kernel,
> > =


> > but probably 30% on 5.11 (a wild guess).
> > =


> > <snip>
> > =


> > > > In the past, I also noticed odd things like ldconfig hanging or no=
t picking up updated libraries are suspend-to-disk.
> > > > =


> > > > Simply rebooting helped in such cases.
> > > > =


> > > > The swap partition is on the same disk. (as a separate partition, =
not a file)
> > > > =


> > > > I also started using a new power profile recently, which disables =
half of the CPU cores when on battery power.
> > > > =


> > > > (but hibernation also offlines all non-boot CPUs while preparing f=
or suspend-to-disk)
> > > > =


> > > > What could have caused the filesystem corruption?
> > =


> > > From the dmesg, at least one block group for metadata is corrupted, =
it
> > > =


> > > may explain why one tree block can't be read, as it may point to som=
e
> > > =


> > > invalid location thus got all zero.
> > > =


> > > I believe the problem exists way before v5.11.x, as in v5.11, btrfs =
has
> > =


> > > the ability to detect tons of new problems and reject such incorrect
> > > =


> > > metadata from reaching disk.
> > =


> > Ah, cool, that's good to know that 5.11 does a lot more sanity checkin=
g!
> > =


> > > Thus it should be a problem/bug caused by old kernel.
> > =


> > > Furthermore, I didn't see any obvious bitflip, thus bad memory is le=
ss
> > > =


> > > possible.
> > =


> > That's good!
> > =


> > > > Is there a way to repair the filesystem?
> > =


> > > As expected, from the btrfs-check output, extent tree is corrupted.
> > =


> > > But thankfully, the data should be all safe.
> > =


> > > So the first thing is to backup all your important data.
> > =


> > > Then try "btrfs check --mode=3Dlowmem" to get a more human readable =
error
> > > =


> > > report, and we can start from that to determine if it can be repaire=
d.
> > =


> > Sure, please see below.
> > =


> > $ btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> > =


> > Opening filesystem to check...
> > =


> > Checking filesystem on /dev/nvme0n1p4
> > =


> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > [1/7] checking root items
> > =


> > [2/7] checking extents
> =


> That's strange, this means lowmem and original mode has a different
> =


> ideas on what's going wrong.
> =


> Now we need to enhance lowmem mode to detect such problem first.
> =


> > [3/7] checking free space cache
> > =


> > block group 2169503744 has wrong amount of free space, free space cach=
e has 10440704 block group has 10346496
> > =


> > ERROR: free space cache has more free space than block group item, thi=
s could leads to serious corruption, please contact btrfs developers
> =


> Yeah, free space cache corruption is a big thing.

> Recommended to do a btrfs-check --clear-space-cache v1 first before next=
 =


> mount.

$ btrfs check --clear-space-cache v1 /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
Free space cache cleared

> =


> > failed to load free space cache for block group 2169503744
> > =


> > [4/7] checking fs roots
> > =


> > ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, =
expected: 40960
> > =


> > ERROR: errors found in fs roots
> > =


> > found 71205916672 bytes used, error(s) found
> > =


> > total csum bytes: 69299516
> > =


> > total tree bytes: 212975616
> > =


> > total fs tree bytes: 113672192
> > =


> > total extent tree bytes: 14909440
> > =


> > btree space waste bytes: 42172819
> > =


> > file data blocks allocated: 86083526656
> > =


> > referenced 70815563776
> > =


> > > But so far, I'm a little optimistic about a working repair.
> > =


> > Makes me optimistic as well. :)
> =


> You can --repair after clearing v1 cache and backing up your data.
> =


> Then run without --repair to see the result.
> =


> For the worst case, you can try --init-extent-tree, but I still want to
> =


> see the result of regular --repair.

$ btrfs check --repair /dev/nvme0n1p4 =


enabling repair mode
WARNING:

Do not use --repair unless you are advised to do so by a developer
or an experienced user, and then only after having accepted that no
fsck can successfully repair all types of filesystem corruption. Eg.
some software or hardware bugs can fatally damage a volume.
The operation will start in 10 seconds.
Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
ref mismatch on [3111260160 8192] extent item 0, found 1
data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111260160 root 257 owner 488963 offset 0=
 found 1 wanted 0 back 0x55d56b1ea2f0
backpointer mismatch on [3111260160 8192]
adding new data backref on 3111260160 root 257 owner 488963 offset 0 found=
 1
Repaired extent references for 3111260160
ref mismatch on [3111411712 12288] extent item 0, found 1
data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111411712 root 257 owner 488887 offset 4=
096 found 1 wanted 0 back 0x55d56c18ca50
backpointer mismatch on [3111411712 12288]
adding new data backref on 3111411712 root 257 owner 488887 offset 4096 fo=
und 1
Repaired extent references for 3111411712
ref mismatch on [3111436288 16384] extent item 0, found 1
data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111436288 root 257 owner 488889 offset 4=
096 found 1 wanted 0 back 0x55d576d8e290
backpointer mismatch on [3111436288 16384]
adding new data backref on 3111436288 root 257 owner 488889 offset 4096 fo=
und 1
Repaired extent references for 3111436288
ref mismatch on [3111489536 8192] extent item 0, found 1
data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111489536 root 257 owner 488964 offset 0=
 found 1 wanted 0 back 0x55d5699f2700
backpointer mismatch on [3111489536 8192]
adding new data backref on 3111489536 root 257 owner 488964 offset 0 found=
 1
Repaired extent references for 3111489536
ref mismatch on [3111616512 638976] extent item 25, found 26
data backref 3111616512 root 257 owner 488965 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111616512 root 257 owner 488965 offset 0=
 found 1 wanted 0 back 0x55d56c17dc00
backref disk bytenr does not match extent record, bytenr=3D3111616512, ref=
 bytenr=3D3112091648
backref bytes do not match extent backref, bytenr=3D3111616512, ref bytes=3D=
638976, backref bytes=3D8192
backpointer mismatch on [3111616512 638976]
attempting to repair backref discrepancy for bytenr 3111616512
ref mismatch on [3111260160 8192] extent item 0, found 1
data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111260160 root 257 owner 488963 offset 0=
 found 1 wanted 0 back 0x55d578005140
backpointer mismatch on [3111260160 8192]
adding new data backref on 3111260160 root 257 owner 488963 offset 0 found=
 1
Repaired extent references for 3111260160
ref mismatch on [3111411712 12288] extent item 0, found 1
data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111411712 root 257 owner 488887 offset 4=
096 found 1 wanted 0 back 0x55d577576b70
backpointer mismatch on [3111411712 12288]
adding new data backref on 3111411712 root 257 owner 488887 offset 4096 fo=
und 1
Repaired extent references for 3111411712
ref mismatch on [3111436288 16384] extent item 0, found 1
data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111436288 root 257 owner 488889 offset 4=
096 found 1 wanted 0 back 0x55d56a2e5c40
backpointer mismatch on [3111436288 16384]
adding new data backref on 3111436288 root 257 owner 488889 offset 4096 fo=
und 1
Repaired extent references for 3111436288
ref mismatch on [3111489536 8192] extent item 0, found 1
data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111489536 root 257 owner 488964 offset 0=
 found 1 wanted 0 back 0x55d56b770820
backpointer mismatch on [3111489536 8192]
adding new data backref on 3111489536 root 257 owner 488964 offset 0 found=
 1
Repaired extent references for 3111489536
ref mismatch on [3111616512 638976] extent item 25, found 26
data backref 3111616512 root 257 owner 488965 offset 18446744073709076480 =
num_refs 0 not found in extent tree
incorrect local backref count on 3111616512 root 257 owner 488965 offset 1=
8446744073709076480 found 1 wanted 0 back 0x55d576f3cab0
backpointer mismatch on [3111616512 638976]
repair deleting extent record: key [3111616512,168,638976]
adding new data backref on 3111616512 root 257 owner 31924 offset 5496832 =
found 25
adding new data backref on 3111616512 root 257 owner 488965 offset 1844674=
4073709076480 found 1
Repaired extent references for 3111616512
ref mismatch on [3123773440 8192] extent item 0, found 1
data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3123773440 root 257 owner 488966 offset 0=
 found 1 wanted 0 back 0x55d56bb7b6e0
backpointer mismatch on [3123773440 8192]
adding new data backref on 3123773440 root 257 owner 488966 offset 0 found=
 1
Repaired extent references for 3123773440
ref mismatch on [3124051968 12288] extent item 0, found 1
data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3124051968 root 257 owner 488895 offset 0=
 found 1 wanted 0 back 0x55d56ac11990
backpointer mismatch on [3124051968 12288]
adding new data backref on 3124051968 root 257 owner 488895 offset 0 found=
 1
Repaired extent references for 3124051968
ref mismatch on [3124080640 8192] extent item 0, found 1
data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3124080640 root 257 owner 488967 offset 0=
 found 1 wanted 0 back 0x55d577900d10
backpointer mismatch on [3124080640 8192]
adding new data backref on 3124080640 root 257 owner 488967 offset 0 found=
 1
Repaired extent references for 3124080640
ref mismatch on [3124252672 208896] extent item 12, found 13
data backref 3124252672 root 257 owner 488902 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3124252672 root 257 owner 488902 offset 0=
 found 1 wanted 0 back 0x55d56b005980
backref disk bytenr does not match extent record, bytenr=3D3124252672, ref=
 bytenr=3D3124428800
backref bytes do not match extent backref, bytenr=3D3124252672, ref bytes=3D=
208896, backref bytes=3D12288
backpointer mismatch on [3124252672 208896]
attempting to repair backref discrepancy for bytenr 3124252672
ref mismatch on [3111260160 8192] extent item 0, found 1
data backref 3111260160 root 257 owner 488963 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111260160 root 257 owner 488963 offset 0=
 found 1 wanted 0 back 0x55d576dbdef0
backpointer mismatch on [3111260160 8192]
adding new data backref on 3111260160 root 257 owner 488963 offset 0 found=
 1
Repaired extent references for 3111260160
ref mismatch on [3111411712 12288] extent item 0, found 1
data backref 3111411712 root 257 owner 488887 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111411712 root 257 owner 488887 offset 4=
096 found 1 wanted 0 back 0x55d56b68d090
backpointer mismatch on [3111411712 12288]
adding new data backref on 3111411712 root 257 owner 488887 offset 4096 fo=
und 1
Repaired extent references for 3111411712
ref mismatch on [3111436288 16384] extent item 0, found 1
data backref 3111436288 root 257 owner 488889 offset 4096 num_refs 0 not f=
ound in extent tree
incorrect local backref count on 3111436288 root 257 owner 488889 offset 4=
096 found 1 wanted 0 back 0x55d576c0fb70
backpointer mismatch on [3111436288 16384]
adding new data backref on 3111436288 root 257 owner 488889 offset 4096 fo=
und 1
Repaired extent references for 3111436288
ref mismatch on [3111489536 8192] extent item 0, found 1
data backref 3111489536 root 257 owner 488964 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3111489536 root 257 owner 488964 offset 0=
 found 1 wanted 0 back 0x55d56ab85320
backpointer mismatch on [3111489536 8192]
adding new data backref on 3111489536 root 257 owner 488964 offset 0 found=
 1
Repaired extent references for 3111489536
ref mismatch on [3123773440 8192] extent item 0, found 1
data backref 3123773440 root 257 owner 488966 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3123773440 root 257 owner 488966 offset 0=
 found 1 wanted 0 back 0x55d56ab937e0
backpointer mismatch on [3123773440 8192]
adding new data backref on 3123773440 root 257 owner 488966 offset 0 found=
 1
Repaired extent references for 3123773440
ref mismatch on [3124051968 12288] extent item 0, found 1
data backref 3124051968 root 257 owner 488895 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3124051968 root 257 owner 488895 offset 0=
 found 1 wanted 0 back 0x55d576c155b0
backpointer mismatch on [3124051968 12288]
adding new data backref on 3124051968 root 257 owner 488895 offset 0 found=
 1
Repaired extent references for 3124051968
ref mismatch on [3124080640 8192] extent item 0, found 1
data backref 3124080640 root 257 owner 488967 offset 0 num_refs 0 not foun=
d in extent tree
incorrect local backref count on 3124080640 root 257 owner 488967 offset 0=
 found 1 wanted 0 back 0x55d56b031700
backpointer mismatch on [3124080640 8192]
adding new data backref on 3124080640 root 257 owner 488967 offset 0 found=
 1
Repaired extent references for 3124080640
ref mismatch on [3124252672 208896] extent item 12, found 13
data backref 3124252672 root 257 owner 488902 offset 18446744073709375488 =
num_refs 0 not found in extent tree
incorrect local backref count on 3124252672 root 257 owner 488902 offset 1=
8446744073709375488 found 1 wanted 0 back 0x55d5773b8b20
backpointer mismatch on [3124252672 208896]
repair deleting extent record: key [3124252672,168,208896]
adding new data backref on 3124252672 root 257 owner 31924 offset 7163904 =
found 12
adding new data backref on 3124252672 root 257 owner 488902 offset 1844674=
4073709375488 found 1
Repaired extent references for 3124252672
No device size related problem found
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 31924 errors 1000, some csum missing
ERROR: errors found in fs roots
found 427087040512 bytes used, error(s) found
total csum bytes: 415797096
total tree bytes: 1277558784
total fs tree bytes: 682033152
total extent tree bytes: 89456640
btree space waste bytes: 252979190
file data blocks allocated: 516356227072
 referenced 424745533440


$ btrfs check /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
extent item 3109511168 has multiple extent items
ref mismatch on [3109511168 2105344] extent item 1, found 5
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111489536
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111260160
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111411712
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D12288
backref disk bytenr does not match extent record, bytenr=3D3109511168, ref=
 bytenr=3D3111436288
backref bytes do not match extent backref, bytenr=3D3109511168, ref bytes=3D=
2105344, backref bytes=3D16384
backpointer mismatch on [3109511168 2105344]
extent item 3121950720 has multiple extent items
ref mismatch on [3121950720 2220032] extent item 1, found 4
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124080640
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3123773440
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D8192
backref disk bytenr does not match extent record, bytenr=3D3121950720, ref=
 bytenr=3D3124051968
backref bytes do not match extent backref, bytenr=3D3121950720, ref bytes=3D=
2220032, backref bytes=3D12288
backpointer mismatch on [3121950720 2220032]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 31924 errors 1000, some csum missing
ERROR: errors found in fs roots
found 71181148160 bytes used, error(s) found
total csum bytes: 69299516
total tree bytes: 212942848
total fs tree bytes: 113672192
total extent tree bytes: 14925824
btree space waste bytes: 42179056
file data blocks allocated: 86059712512
 referenced 70790922240


Hm, doesn't look overly promising anymore. :/

> =


> > > > How safe is it to continue using this particular filesystem after/=
if it's repaired on this drive?
> > =


> > > It's safe to mount it read-only.
> > > =


> > > It's not going to work well to read-write mount it, as btrfs will ab=
ort
> > > =


> > > transaction just as you already see in the dmesg.
> > =


> > Oh, even after repairing it?
> =


> I mean before repair.
> =


> After repair, depends on whether btrfs-check reports any remaining error=
.
> =


> If no more error, RW mount should be fine.
> =


> > Or is it yet to be seen if it can be repaired?
> > =


> > > Thankfully with more and more sanity check introduced in recent kern=
els,
> > > =


> > > btrfs can handle such corrupted fs without crashing the whole kernel=
.
> > =


> > > So at least you can try to grab the data without crashing the kernel=
.
> > =


> > Yeah, that's definitely very helpful as I was able to backup all the i=
mportant stuff seemingly with no problems.
> > =


> > > > How safe is it to keep using BTRFS on this drive going forward (ev=
en after creating a new filesystem)?
> > =


> > > As long as you're using v5.11 and newer kernel, btrfs is very strict=
 on
> > > =


> > > any data it writes back to disk, thus it can even detect quite some
> > > =


> > > memory bitflips.
> > =


> > > So unless there is a proof of the SSD is bad, you're pretty safe to
> > > =


> > > continue use the disk.
> > =


> > > And I don't see anything special related to the SSD, thus you're pre=
tty
> > > =


> > > safe to go.
> > =


> > Good to hear!
> > =


> > I started suspecting something with TRIM/discard support in the SSD/dr=
iver after seeing these all zero checksums,
> > =


> > but your explanation that it's just because of the corrupt tree makes =
more sense.
> > =


> > I also saw another thread on the mailing list (from Martin)
> > =


> > about quite a similar (from my point of view) issue on a similar syste=
m (AMD-based, Samsung 980 SSD) with similar usage (suspend-to-disk),
> > =


> > so trying to figure out if it's the drive issue, a driver issue, suspe=
nd-to-disk issue, or a combination of these.
> =


> I guess suspend to disk may be involved, but can't say for sure.
> =


> As although I'm also using AMD based CPU (3700X though), with PM981 SSD
> from Samsung, but I never use suspend to disk/ram, but just power off...
> =


> So I can't say for sure.

I see.
Yeah, I'm going to stick to just powering off for the time being too.
Or using suspend-to-ram as the last resort.

> =


> Thanks,
> =


> Qu
> =


> > So far, suspend-to-disk seems to be the main suspect (or it somehow tr=
iggers issues elsewhere)
> > =


> > as I saw strange behavior upon resume from hibernation, but never on a=
 clean reboot.
> > =


> > > > I've backed up important files,
> > > > =


> > > > so I'll be glad to try various suggestions.
> > =


> > > > Also, I'll keep using ext4 on this drive for now and will keep an =
eye on it.
> > > > =


> > > > I think I was able to resolve the "corrupt leaf" issue by deleting=
 affected files
> > =


> > > Nope, there is no way to solve it just using the btrfs kernel module=
.
> > =


> > > Btrfs refuses to read such corrupted tree block at all, thus no way =
to
> > > =


> > > modify it.
> > =


> > > Unless you're using a much older kernel, but then you lost all the n=
ew
> > > =


> > > sanity checks in v5.11, thus not recommended.
> > =


> > Hm, I don't remember for sure now,
> > =


> > but chances are that I deleted those files when booting from a LiveUSB=
,
> > =


> > which used kernel 5.10.61.
> > =


> > (I didn't know that 5.11 is so much more strict, otherwise I would hav=
e found another bootable ISO)
> > =


> > This would explain how I could have deleted them.
> > =


> > But overall, I was mostly following instructions here:
> > =


> > https://lore.kernel.org/linux-btrfs/75c522e9-88ff-0b9d-1ede-b524388d42=
d1@gmx.com/
> > =


> > > Thanks,
> > =


> > > Qu
> > =


> > > > (the Linux kernel sources I was unpacking while I hit the issue),
> > =


> > > > because "btrfs ins logical-resolve" can't find the file anymore:
> > =


> > > > $ btrfs ins logical-resolve 1376043008 /mnt/hippo/
> > =


> > > > ERROR: logical ino ioctl: No such file or directory
> > =


> > > > However, checksum and "btrfs check" errors make me seriously worri=
ed.
> > =


> > > > This is the earliest BTRFS warning I see in the logs:
> > =


> > > > Sep 4 14:04:51 hippo-tuxedo kernel: [ 19.338196] BTRFS warning (de=
vice nvme0n1p4): block group 2169503744 has wrong amount of free space
> > =


> > > > Sep 4 14:04:51 hippo-tuxedo kernel: [ 19.338202] BTRFS warning (de=
vice nvme0n1p4): failed to load free space cache for block group 216950374=
4, rebuilding it now
> > =


> > > > Here's the first "corrupt leaf" error:
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151911] BTRFS critical =
(device nvme0n1p4): corrupt leaf: root=3D2 block=3D1376043008 slot=3D7 bg_=
start=3D2169503744 bg_len=3D1073741824, invalid block group used, have 107=
3790976 expect [0, 1073741824)
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151925] BTRFS info (dev=
ice nvme0n1p4): leaf 1376043008 gen 24254 total ptrs 121 free space 6994 o=
wner 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151929] item 0 key (216=
9339904 169 0) itemoff 16250 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151932] extent refs 1 g=
en 20692 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151933] ref#0: tree blo=
ck backref root 7
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151936] item 1 key (216=
9356288 169 0) itemoff 16217 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151938] extent refs 1 g=
en 20692 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151939] ref#0: tree blo=
ck backref root 7
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151940] item 2 key (216=
9372672 169 0) itemoff 16184 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151942] extent refs 1 g=
en 20692 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151943] ref#0: tree blo=
ck backref root 7
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151945] item 3 key (216=
9405440 169 0) itemoff 16151 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151946] extent refs 1 g=
en 20692 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151947] ref#0: tree blo=
ck backref root 7
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151949] item 4 key (216=
9421824 169 0) itemoff 16118 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151950] extent refs 1 g=
en 20692 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151951] ref#0: tree blo=
ck backref root 7
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151953] item 5 key (216=
9470976 169 0) itemoff 16085 itemsize 33
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151954] extent refs 1 g=
en 24164 flags 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151955] ref#0: tree blo=
ck backref root 2
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151957] item 6 key (216=
9503744 168 16429056) itemoff 16032 itemsize 53
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151959] extent refs 1 g=
en 47 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151960] ref#0: extent d=
ata backref root 257 objectid 20379 offset 0 count 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151962] item 7 key (216=
9503744 192 1073741824) itemoff 16008 itemsize 24
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151964] block group use=
d 1073790976 chunk_objectid 256 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151966] item 8 key (218=
5932800 168 241664) itemoff 15955 itemsize 53
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151968] extent refs 1 g=
en 47 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151969] ref#0: extent d=
ata backref root 257 objectid 20417 offset 0 count 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151971] item 9 key (218=
6174464 168 299008) itemoff 15902 itemsize 53
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151973] extent refs 1 g=
en 47 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151974] ref#0: extent d=
ata backref root 257 objectid 20418 offset 0 count 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151976] item 10 key (21=
86473472 168 135168) itemoff 15849 itemsize 53
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151977] extent refs 1 g=
en 47 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.151978] ref#0: extent d=
ata backref root 257 objectid 20419 offset 0 count 1
> > =


> > > > ...
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152480] item 120 key (2=
195210240 168 4096) itemoff 10019 itemsize 53
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152481] extent refs 1 g=
en 47 flags 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152482] ref#0: extent d=
ata backref root 257 objectid 20558 offset 0 count 1
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152484] BTRFS error (de=
vice nvme0n1p4): block=3D1376043008 write time tree block corruption detec=
ted
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152661] BTRFS: error (d=
evice nvme0n1p4) in btrfs_commit_transaction:2339: errno=3D-5 IO failure (=
Error while writing out transaction)
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152663] BTRFS info (dev=
ice nvme0n1p4): forced readonly
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152664] BTRFS warning (=
device nvme0n1p4): Skipping commit of aborted transaction.
> > =


> > > > Sep 4 23:44:25 hippo-tuxedo kernel: [ 9855.152665] BTRFS: error (d=
evice nvme0n1p4) in cleanup_transaction:1939: errno=3D-5 IO failure
> > =


> > > > I hit these csum 0x00000000 errors while trying to backup the file=
s to ext4 partition on the same disk:
> > =


> > > > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.475516] BTRFS info (devi=
ce nvme0n1p4): disk space caching is enabled
> > =


> > > > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.475523] BTRFS info (devi=
ce nvme0n1p4): has skinny extents
> > =


> > > > Sep 5 00:12:26 hippo-tuxedo kernel: [ 891.494832] BTRFS info (devi=
ce nvme0n1p4): enabling ssd optimizations
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627577] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111=
849984)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627805] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271=
056 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.627814] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 1,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628316] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3112013824, 3112=
017920)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628931] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3112058880, 3112=
062976)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.628943] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3112083456, 3112=
087552)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629210] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5894144 csum 0x45d7e=
010 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629214] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 2,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.629238] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5963776 csum 0x95b8b=
716 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.630311] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 3,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648130] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111=
849984)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648226] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271=
056 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.648234] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 4,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649275] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111=
849984)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649353] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271=
056 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.649357] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 5,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650397] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111845888, 3111=
849984)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650475] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271=
056 expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.650478] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 6,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678142] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111124992, 3111=
129088)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678149] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111276544, 3111=
280640)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.678151] BTRFS warning (=
device nvme0n1p4): csum hole found for disk bytenr range [3111346176, 3111=
350272)
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.680593] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab=
29ce expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.680604] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 7,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.686438] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab=
29ce expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.686449] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 8,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.687671] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab=
29ce expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.687683] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 9,=
 gen 0
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.688871] BTRFS warning (=
device nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab=
29ce expected csum 0x00000000 mirror 1
> > =


> > > > Sep 5 00:16:42 hippo-tuxedo kernel: [ 1147.688876] BTRFS error (de=
vice nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 10=
, gen 0
> > =


> > > > Sep 5 00:17:05 hippo-tuxedo kernel: [ 1170.527686] BTRFS warning (=
device nvme0n1p4): block group 2169503744 has wrong amount of free space
> > =


> > > > Sep 5 00:17:05 hippo-tuxedo kernel: [ 1170.527695] BTRFS warning (=
device nvme0n1p4): failed to load free space cache for block group 2169503=
744, rebuilding it now
> > =


> > > > $ uname -a
> > =


> > > > Linux hippo-tuxedo 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Au=
g 11 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > =


> > > > $ btrfs --version
> > =


> > > > btrfs-progs v5.4.1
> > =


> > > > $ btrfs fi show
> > =


> > > > Label: 'HIPPO' uuid: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > > > Total devices 1 FS bytes used 66.32GiB
> > =


> > > > devid 1 size 256.00GiB used 95.02GiB path /dev/nvme0n1p4
> > =


> > > > $ btrfs fi df /mnt/hippo/
> > =


> > > > Data, single: total=3D94.01GiB, used=3D66.12GiB
> > =


> > > > System, single: total=3D4.00MiB, used=3D16.00KiB
> > =


> > > > Metadata, single: total=3D1.01GiB, used=3D203.09MiB
> > =


> > > > GlobalReserve, single: total=3D94.59MiB, used=3D0.00B
> > =


> > > > $ cat /etc/lsb-release
> > =


> > > > DISTRIB_ID=3DUbuntu
> > =


> > > > DISTRIB_RELEASE=3D20.04
> > =


> > > > DISTRIB_CODENAME=3Dfocal
> > =


> > > > DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.2 LTS"
> > =


> > > > Mount options:
> > =


> > > > relatime,ssd,space_cache,subvolid=3D5,subvol=3Dandrey
> > =


> > > > $ btrfs check --readonly /dev/nvme0n1p4
> > =


> > > > Opening filesystem to check...
> > =


> > > > Checking filesystem on /dev/nvme0n1p4
> > =


> > > > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > =


> > > > [1/7] checking root items
> > =


> > > > [2/7] checking extents
> > =


> > > > extent item 3109511168 has multiple extent items
> > =


> > > > ref mismatch on [3109511168 2105344] extent item 1, found 5
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3109511=
168, ref bytenr=3D3111489536
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3109511168, re=
f bytes=3D2105344, backref bytes=3D8192
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3109511=
168, ref bytenr=3D3111436288
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3109511168, re=
f bytes=3D2105344, backref bytes=3D16384
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3109511=
168, ref bytenr=3D3111260160
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3109511168, re=
f bytes=3D2105344, backref bytes=3D8192
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3109511=
168, ref bytenr=3D3111411712
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3109511168, re=
f bytes=3D2105344, backref bytes=3D12288
> > =


> > > > backpointer mismatch on [3109511168 2105344]
> > =


> > > > extent item 3111616512 has multiple extent items
> > =


> > > > ref mismatch on [3111616512 638976] extent item 25, found 26
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3111616=
512, ref bytenr=3D3112091648
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3111616512, re=
f bytes=3D638976, backref bytes=3D8192
> > =


> > > > backpointer mismatch on [3111616512 638976]
> > =


> > > > extent item 3121950720 has multiple extent items
> > =


> > > > ref mismatch on [3121950720 2220032] extent item 1, found 4
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3121950=
720, ref bytenr=3D3124080640
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3121950720, re=
f bytes=3D2220032, backref bytes=3D8192
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3121950=
720, ref bytenr=3D3124051968
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3121950720, re=
f bytes=3D2220032, backref bytes=3D12288
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3121950=
720, ref bytenr=3D3123773440
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3121950720, re=
f bytes=3D2220032, backref bytes=3D8192
> > =


> > > > backpointer mismatch on [3121950720 2220032]
> > =


> > > > extent item 3124252672 has multiple extent items
> > =


> > > > ref mismatch on [3124252672 208896] extent item 12, found 13
> > =


> > > > backref disk bytenr does not match extent record, bytenr=3D3124252=
672, ref bytenr=3D3124428800
> > =


> > > > backref bytes do not match extent backref, bytenr=3D3124252672, re=
f bytes=3D208896, backref bytes=3D12288
> > =


> > > > backpointer mismatch on [3124252672 208896]
> > =


> > > > ERROR: errors found in extent allocation tree or chunk allocation
> > =


> > > > [3/7] checking free space cache
> > =


> > > > block group 2169503744 has wrong amount of free space, free space =
cache has 10440704 block group has 10346496
> > =


> > > > ERROR: free space cache has more free space than block group item,=
 this could leads to serious corruption, please contact btrfs developers
> > =


> > > > failed to load free space cache for block group 2169503744
> > =


> > > > [4/7] checking fs roots
> > =


> > > > root 257 inode 31924 errors 1000, some csum missing
> > =


> > > > ERROR: errors found in fs roots
> > =


> > > > found 71205822464 bytes used, error(s) found
> > =


> > > > total csum bytes: 69299516
> > =


> > > > total tree bytes: 212975616
> > =


> > > > total fs tree bytes: 113672192
> > =


> > > > total extent tree bytes: 14909440
> > =


> > > > btree space waste bytes: 42172819
> > =


> > > > file data blocks allocated: 86083526656
> > =


> > > > referenced 70815563776
<snip>
-----------------------9fda48609e2e4bc12a8016ba95c51d15--

--------561401da3d85c481682ec64cd4a797b8fafa3a955e4061bda3377b43875d5dc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1hV4AIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZK4/VAP41wPS/q1xH22tBgCymq3X4IgmMGPRXtn0/LyqcbZE6CwD+M1Ji
4sXz6J+pQ2BKkUiX2XooioTQJ2QagZNqu17zyg4=
=CMFZ
-----END PGP SIGNATURE-----


--------561401da3d85c481682ec64cd4a797b8fafa3a955e4061bda3377b43875d5dc3--

