Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05EC401642
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbhIFGOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 02:14:48 -0400
Received: from mail-4323.protonmail.ch ([185.70.43.23]:25759 "EHLO
        mail-4323.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbhIFGOr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 02:14:47 -0400
X-Greylist: delayed 81564 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 02:14:46 EDT
Date:   Mon, 06 Sep 2021 06:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630908819; bh=Ff0pMSE7JTioU8kjTR+R/zxwT/y+ecMXri1EUB3Zo70=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aOGoBCZGfMNBqenQ2trqRSf5fK/iS9jooG82bX/u4GCP7XQUNYGdwM8bcLQJ+r2Sn
         gSEkND53hZ7QmbyaoNaBBLUNlzzN2+pMDMspA9KdZUkIGKxuAcZ5tdKe6aV+Vnmmtg
         LrBiaU9I46GDO4xNlMlJUZgXzXEIwk971iApU4PpwQ7reaxLpFze5DeRYSPPbrWn2S
         7BmGQgm6nWkEJaFdTWU1BoqFRv9d/yNr88W9xiYlpqgI6/CKpjuGscesQjX9ASKHQi
         jRe6gl4e6jzOxMA8ZuUC6yGuKkUfYEikT01DijQPv6s0xG+XPOwPzwQMXXF3xOpljr
         bK4ZegHqdTjeQ==
To:     Qu Wenruo <wqu@suse.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me>
In-Reply-To: <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com> <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me> <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com> <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me> <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com> <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me> <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9f835499f19799155766bccc9a37ee5095fa860ea3404e0252ba5cd8bf510507"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9f835499f19799155766bccc9a37ee5095fa860ea3404e0252ba5cd8bf510507
Content-Type: multipart/mixed;boundary=---------------------01a2c9e0bbed30f950859cdda0714121

-----------------------01a2c9e0bbed30f950859cdda0714121
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Monday, September 6th, 2021 at 1:20 AM, Qu wrote:

> On 2021/9/6 =E4=B8=8B=E5=8D=8812:07, ahipp0 wrote:
> =


> [...]
> =


> > > Those offending blocks are some data extents.
> > =


> > $ sudo ./btrfs inspect-internal logical-resolve 3109511168 /mnt/hippo/
> > =


> > /mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandor=
a_sqliite_database/00000011
> > =


> > $ sudo ./btrfs inspect-internal logical-resolve 3121950720 /mnt/hippo/
> > =


> > /mnt/hippo/home-andrey/.config/SpiderOakONE/tss_external_blocks_pandor=
a_sqliite_database/00000011
> > =


> > I remember it was complaining about the file when I was backing things=
 up.
> > =


> > This file can be easily dropped -- I already rebuilt SpiderOak databas=
e anyway since I couldn't back it up.
> =


> You can try to delete them, but the problem is, if it doesn't work well,
> =


> it can cause btrfs to abort transaction (aka, turns into read-only mount=
).
> =


> Thus you may want to delete them, sync the fs, check the dmesg to make
> =


> sure the fs is still fine.

Hm, looks like it didn't complain.
(I just nuked the whole .config/SpiderOakONE directory)

> If that works, then btrfs-check again to make sure the problem is gone.

Looks much better now:

$ sudo ./btrfs check /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 488887 errors 1000, some csum missing
root 257 inode 488889 errors 1000, some csum missing
root 257 inode 488895 errors 1000, some csum missing
root 257 inode 488963 errors 1000, some csum missing
root 257 inode 488964 errors 1000, some csum missing
root 257 inode 488966 errors 1000, some csum missing
root 257 inode 488967 errors 1000, some csum missing
ERROR: errors found in fs roots
found 70414278656 bytes used, error(s) found
total csum bytes: 68552088
total tree bytes: 209338368
total fs tree bytes: 111853568
total extent tree bytes: 14024704
btree space waste bytes: 41823418
file data blocks allocated: 73253691392
 referenced 70072770560


$ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 257 EXTENT_DATA[488887 4096] csum missing, have: 0, expected: =
12288
ERROR: root 257 EXTENT_DATA[488889 4096] csum missing, have: 0, expected: =
16384
ERROR: root 257 EXTENT_DATA[488895 0] csum missing, have: 0, expected: 122=
88
ERROR: root 257 EXTENT_DATA[488963 0] csum missing, have: 0, expected: 819=
2
ERROR: root 257 EXTENT_DATA[488964 0] csum missing, have: 0, expected: 819=
2
ERROR: root 257 EXTENT_DATA[488966 0] csum missing, have: 0, expected: 819=
2
ERROR: root 257 EXTENT_DATA[488967 0] csum missing, have: 0, expected: 819=
2
ERROR: errors found in fs roots
found 70414278656 bytes used, error(s) found
total csum bytes: 68552088
total tree bytes: 209338368
total fs tree bytes: 111853568
total extent tree bytes: 14024704
btree space waste bytes: 41823418
file data blocks allocated: 73253691392
 referenced 70072770560


Seems like these inodes with zero csums can all be removed too since it's =
some Steam (built-in browser?) cache.

$ for i in 488887 488889 488895 488963 488964 488966 488967 ; do sudo ./bt=
rfs inspect-internal inode-resolve "$i" /mnt/hippo/ ; done
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
f3778f4fc6657764_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
fc05b030bc3ab2bc_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
aa9d1c627d0d4ae1_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
24ede0e2ab3e0575_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
5aa559bb0d57bd6a_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
da80b0a1607292bd_0
/mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cache/=
90b6c5585a06e357_0

$ for i in 488887 488889 488895 488963 488964 488966 488967 ; do stat $(su=
do ./btrfs inspect-internal inode-resolve "$i" /mnt/hippo/) ; done
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/f3778f4fc6657764_0
Size: 15094           Blocks: 32         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488887      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:30.297522881 -0400
Modify: 2021-09-03 23:23:30.705560160 -0400
Change: 2021-09-03 23:23:30.705560160 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/fc05b030bc3ab2bc_0
Size: 19104           Blocks: 40         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488889      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:30.509542251 -0400
Modify: 2021-09-03 23:23:30.893577338 -0400
Change: 2021-09-03 23:23:30.893577338 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/aa9d1c627d0d4ae1_0
Size: 8406            Blocks: 24         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488895      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:35.802021943 -0400
Modify: 2021-09-03 23:23:37.138141842 -0400
Change: 2021-09-03 23:23:37.138141842 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/24ede0e2ab3e0575_0
Size: 7844            Blocks: 16         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488963      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:40.054401865 -0400
Modify: 2021-09-03 23:23:40.362429172 -0400
Change: 2021-09-03 23:23:40.362429172 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/5aa559bb0d57bd6a_0
Size: 7473            Blocks: 16         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488964      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:40.054401865 -0400
Modify: 2021-09-03 23:23:40.370429882 -0400
Change: 2021-09-03 23:23:40.370429882 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/da80b0a1607292bd_0
Size: 5808            Blocks: 16         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488966      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:40.054401865 -0400
Modify: 2021-09-03 23:23:40.226417115 -0400
Change: 2021-09-03 23:23:40.226417115 -0400
Birth: -
File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/=
Cache/90b6c5585a06e357_0
Size: 7110            Blocks: 16         IO Block: 4096   regular file
Device: 3bh/59d Inode: 488967      Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
Access: 2021-09-03 23:23:40.054401865 -0400
Modify: 2021-09-03 23:23:40.362429172 -0400
Change: 2021-09-03 23:23:40.362429172 -0400
Birth: -

Seems like these files were all created within 10 seconds of each other.

After deleting the whole /mnt/hippo//home-andrey/.steam/debian-installatio=
n/config/htmlcache/Cache directory,
it seems the filesystem is clean.

$ sudo ./btrfs check /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 70097395712 bytes used, no error found
total csum bytes: 68235972
total tree bytes: 206290944
total fs tree bytes: 109363200
total extent tree bytes: 13598720
btree space waste bytes: 41683028
file data blocks allocated: 72939855872
 referenced 69761359872

$ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 70097395712 bytes used, no error found
total csum bytes: 68235972
total tree bytes: 206290944
total fs tree bytes: 109363200
total extent tree bytes: 13598720
btree space waste bytes: 41683028
file data blocks allocated: 72939855872
 referenced 69761359872

$ sudo ./btrfs scrub status /mnt/hippo/
UUID:             2b69016b-e03b-478a-84cd-f794eddfebd5
Scrub started:    Mon Sep  6 02:06:54 2021
Status:           finished
Duration:         0:00:22
Total to scrub:   65.28GiB
Rate:             2.97GiB/s
Error summary:    no errors found


Can the filesystem now be considered clean as in "never corrupted"?
Or is there still a reason to reformat it?

Would using DUP profile for metadata and system help with this kind of cor=
ruption?
Would it be generally advisable to use it going forward?


> =


> The csum missing problem is not a big deal, that can be easily deleted
> by finding inode 31924 of subvolume 257 and delete it.
> Or you can easily ignore it completely.

Seems like it's gone already:

$ sudo ./btrfs inspect-internal inode-resolve 31924 /mnt/hippo/
ERROR: ino paths ioctl: No such file or directory

> =


> Thanks,
> =


> Qu
> =


> > > Can you use some newer btrfs-progs and run check on it again? (not y=
et
> > > =


> > > repair)
> > =


> > > This time in both original and lowmem mode.
> > =


> > > As the involved btrfs-progs is pretty old, thus newer btrfs-progs (t=
he
> > > =


> > > newer the better) may cause some difference.
> > > =


> > > (Sorry, I should mention it earlier)
> > =


> > No worries.
> > =


> > Just built the latest tag from btrfs-progs repository with
> > =


> > ./configure --prefix=3D"${PWD}/_install" --disable-documentation --dis=
able-shared --disable-convert --disable-python --disable-zoned
> > =


> > $ ./btrfs --version
> > =


> > btrfs-progs v5.13.1
> > =


> > $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
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
> > =


> > [3/7] checking free space cache
> > =


> > [4/7] checking fs roots
> > =


> > ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, =
expected: 40960
> > =


> > ERROR: errors found in fs roots
> > =


> > found 71181221888 bytes used, error(s) found
> > =


> > total csum bytes: 69299516
> > =


> > total tree bytes: 212942848
> > =


> > total fs tree bytes: 113672192
> > =


> > total extent tree bytes: 14925824
> > =


> > btree space waste bytes: 42179056
> > =


> > file data blocks allocated: 86059712512
> > =


> > referenced 70790922240
> > =


> > $ sudo ./btrfs check /dev/nvme0n1p4
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
> > =


> > extent item 3109511168 has multiple extent items
> > =


> > ref mismatch on [3109511168 2105344] extent item 1, found 5
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111489536
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111260160
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111411712
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D12288
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111436288
> > =


> > backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D16384
> > =


> > backpointer mismatch on [3109511168 2105344]
> > =


> > extent item 3121950720 has multiple extent items
> > =


> > ref mismatch on [3121950720 2220032] extent item 1, found 4
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124080640
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3123773440
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
> > =


> > backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124051968
> > =


> > backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D12288
> > =


> > backpointer mismatch on [3121950720 2220032]
> > =


> > ERROR: errors found in extent allocation tree or chunk allocation
> > =


> > [3/7] checking free space cache
> > =


> > [4/7] checking fs roots
> > =


> > root 257 inode 31924 errors 1000, some csum missing
> > =


> > ERROR: errors found in fs roots
> > =


> > found 71181148160 bytes used, error(s) found
> > =


> > total csum bytes: 69299516
> > =


> > total tree bytes: 212942848
> > =


> > total fs tree bytes: 113672192
> > =


> > total extent tree bytes: 14925824
> > =


> > btree space waste bytes: 42179056
> > =


> > file data blocks allocated: 86059712512
> > =


> > referenced 70790922240
> > =


> > > Thanks,
> > =


> > > Qu
-----------------------01a2c9e0bbed30f950859cdda0714121--

--------9f835499f19799155766bccc9a37ee5095fa860ea3404e0252ba5cd8bf510507
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1sWYAIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZK59bAQCWFMcauJqD+JyYfsA8oHAHzfu2aJGtXRBMhSQ2HP5vIAD/Uv+E
tfgoEtEAJZvSO/cMDJXXWUh1OEulinDM8zAT9AI=
=edq9
-----END PGP SIGNATURE-----


--------9f835499f19799155766bccc9a37ee5095fa860ea3404e0252ba5cd8bf510507--

