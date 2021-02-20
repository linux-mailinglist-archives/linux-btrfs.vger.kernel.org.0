Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A765D3207BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 00:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBTXqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBTXqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 18:46:03 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27966C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 15:45:23 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id dg2so2323447qvb.12
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KpHeEbkh4geNKdyGellsltU2pHhQbHV6JluDpb+ZPc=;
        b=ntNU1OoJZFfWKB3NM0cIzVVpUs7IxD9K5y1OZgSLc0QsDh+IY/KwhXf7XPDD4QxgMe
         /Z8TsXgqHOwMPq6xI2pDV2g1if/ifvMLXLbsCgHwsnik7ZrhJzHdFLAhy9bORfomcLlB
         G/9/Z0cuk7nPWsqPbHUE4YOled35T0PyTBUl87X78CJsnbsIJ5sx0iIriab5ZP5mJJyT
         AVO8qfpFmwxexUvLAEfRafaB9kWfsaC7o+hEQydeyTzaaFYcrdzAXfH00EPjMLWCm+n3
         8OQIfiJ2P4mXa49G1QRTmgh7I5iEWy6Fi8uEt9W4/gChXFoND4+xp9Y2NUBYFjCHfX5s
         TcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KpHeEbkh4geNKdyGellsltU2pHhQbHV6JluDpb+ZPc=;
        b=uZ8KvWKBYYMQmSdGyZnpFjZOHucbY2Zw3+An6/UoNxGeG5wQq0ne/3I8ktAF21puhf
         1oP7eg6w5pRwhDuOPTuzV7VYGPh+2bYP2sO20RxRHBedh7FbuWAO+DDZHV8yWOo4vAuX
         ubZnFiRaDgvHoS/hkYAciCOWFNwrYGurTdCuoDfEXWwkV8qrNuBkvzESpyVgGJcEUO7v
         Ef51zvIPruBb5HkUKjJpfiZ0ILrAK0gdIbnH+k8KPj8ri7d9FtXHaznvm+iYxmhppmUz
         B19am0B5i5cFrCBRq5bvVgtinh8dr8yV8D/K8B5Gm++tTsgNIbV/evlrJiJxdF1LObri
         V9jg==
X-Gm-Message-State: AOAM532RLhKHmasxWo4TJ6MBc2sxk97tRc5kTS5Vgzk7niwc8WfQmCbw
        IKpPyOKZa+N8SE1MG2uKBInTAnSx9tyLZc7IrcI=
X-Google-Smtp-Source: ABdhPJw8U1g6iLxOmt354++ITzeLTdL8JiXoSdlFQABPE42HbK2kAF2wSqXjyXsSpOYohI9oI+raQxxhwsfh3pgtNq8=
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr15271196qvo.10.1613864722028;
 Sat, 20 Feb 2021 15:45:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <20210219192947.GJ32440@hungrycats.org>
In-Reply-To: <20210219192947.GJ32440@hungrycats.org>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 21 Feb 2021 01:45:10 +0200
Message-ID: <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
Subject: Re: ERROR: failed to read block groups: Input/output error
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

piektd., 2021. g. 19. febr., plkst. 07:16 =E2=80=94 lietot=C4=81js Chris Mu=
rphy
(<lists@colorremedies.com>) rakst=C4=ABja:
> [...]
> What do you get for
>
> btrfs rescue super -v /dev/
>

That seems to be all good

$ btrfs rescue super -v /dev/sda
All Devices:
Device: id =3D 2, name =3D /dev/sdt
Device: id =3D 4, name =3D /dev/sdj
Device: id =3D 3, name =3D /dev/sdg
Device: id =3D 6, name =3D /dev/sdb
Device: id =3D 1, name =3D /dev/sdl
Device: id =3D 5, name =3D /dev/sda

Before Recovering:
[All good supers]:
device name =3D /dev/sdt
superblock bytenr =3D 65536

device name =3D /dev/sdt
superblock bytenr =3D 67108864

device name =3D /dev/sdt
superblock bytenr =3D 274877906944

device name =3D /dev/sdj
superblock bytenr =3D 65536

device name =3D /dev/sdj
superblock bytenr =3D 67108864

device name =3D /dev/sdj
superblock bytenr =3D 274877906944

device name =3D /dev/sdg
superblock bytenr =3D 65536

device name =3D /dev/sdg
superblock bytenr =3D 67108864

device name =3D /dev/sdg
superblock bytenr =3D 274877906944

device name =3D /dev/sdb
superblock bytenr =3D 65536

device name =3D /dev/sdb
superblock bytenr =3D 67108864

device name =3D /dev/sdb
superblock bytenr =3D 274877906944

device name =3D /dev/sdl
superblock bytenr =3D 65536

device name =3D /dev/sdl
superblock bytenr =3D 67108864

device name =3D /dev/sdl
superblock bytenr =3D 274877906944

device name =3D /dev/sda
superblock bytenr =3D 65536

device name =3D /dev/sda
superblock bytenr =3D 67108864

device name =3D /dev/sda
superblock bytenr =3D 274877906944

[All bad supers]:

All supers are valid, no need to recover


$ btrfs inspect dump-super -f /dev/sda
superblock: bytenr=3D65536, device=3D/dev/sda
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xf72e6634 [match]
bytenr                  65536
flags                   0x1
( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    8aef11a9-beb6-49ea-9b2d-7876611a39e5
metadata_uuid           8aef11a9-beb6-49ea-9b2d-7876611a39e5
label                   RAID
generation              2262739
root                    21057011679232
sys_array_size          129
chunk_root_generation   2205349
root_level              1
chunk_root              21056798736384
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             18003557892096
bytes_used              5154539671552
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             6
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x36b
( MIXED_BACKREF |
DEFAULT_SUBVOL |
COMPRESS_LZO |
BIG_METADATA |
EXTENDED_IREF |
SKINNY_METADATA |
NO_HOLES )
cache_generation        2262739
uuid_tree_generation    1807368
dev_item.uuid           098e5987-adf9-4a37-aad0-dff0819c6588
dev_item.fsid           8aef11a9-beb6-49ea-9b2d-7876611a39e5 [match]
dev_item.type           0
dev_item.total_bytes    3000592982016
dev_item.bytes_used     1860828135424
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          5
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 21056797999104)
length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
io_align 65536 io_width 65536 sector_size 4096
num_stripes 2 sub_stripes 1
stripe 0 devid 5 offset 4329570304
dev_uuid 098e5987-adf9-4a37-aad0-dff0819c6588
stripe 1 devid 6 offset 4329570304
dev_uuid 7036ea10-4dce-48c6-b6d5-66378ba54b03
backup_roots[4]:
backup 0:
backup_tree_root:       21056867319808  gen: 2262737    level: 1
backup_chunk_root:      21056798736384  gen: 2205349    level: 1
backup_extent_root:     21056867106816  gen: 2262737    level: 3
backup_fs_root:         21063463993344  gen: 2095377    level: 1
backup_dev_root:        21056861863936  gen: 2262736    level: 1
backup_csum_root:       21056868122624  gen: 2262737    level: 3
backup_total_bytes:     18003557892096
backup_bytes_used:      5154539933696
backup_num_devices:     6

backup 1:
backup_tree_root:       21056933724160  gen: 2262738    level: 1
backup_chunk_root:      21056798736384  gen: 2205349    level: 1
backup_extent_root:     21056867762176  gen: 2262738    level: 3
backup_fs_root:         21063463993344  gen: 2095377    level: 1
backup_dev_root:        21056861863936  gen: 2262736    level: 1
backup_csum_root:       21056944685056  gen: 2262738    level: 3
backup_total_bytes:     18003557892096
backup_bytes_used:      5154548318208
backup_num_devices:     6

backup 2:
backup_tree_root:       21057011679232  gen: 2262739    level: 1
backup_chunk_root:      21056798736384  gen: 2205349    level: 1
backup_extent_root:     21057133690880  gen: 2262740    level: 3
backup_fs_root:         21063463993344  gen: 2095377    level: 1
backup_dev_root:        21056861863936  gen: 2262736    level: 1
backup_csum_root:       21057139916800  gen: 2262740    level: 3
backup_total_bytes:     18003557892096
backup_bytes_used:      5154540572672
backup_num_devices:     6

backup 3:
backup_tree_root:       21056855900160  gen: 2262736    level: 1
backup_chunk_root:      21056798736384  gen: 2205349    level: 1
backup_extent_root:     21056854228992  gen: 2262736    level: 3
backup_fs_root:         21063463993344  gen: 2095377    level: 1
backup_dev_root:        21056861863936  gen: 2262736    level: 1
backup_csum_root:       21056857341952  gen: 2262736    level: 3
backup_total_bytes:     18003557892096
backup_bytes_used:      5154539933696
backup_num_devices:     6


> btrfs check -b /dev/
>

This gives lots of errors and not sure if main superblock can be fixed
with less errors.

$ btrfs check -b /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 8aef11a9-beb6-49ea-9b2d-7876611a39e5
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 20733568155648 has wrong amount of free space, free space
cache has 696320 block group has 729088
failed to load free space cache for block group 20733568155648
[4/7] checking fs roots
root 457 inode 682022 errors 1040, bad file extent, some csum missing
root 457 inode 2438260 errors 1040, bad file extent, some csum missing
root 599 inode 228661 errors 1040, bad file extent, some csum missing
root 18950 inode 2298187 errors 1040, bad file extent, some csum missing

[...] 21068 entries like: root 18950 inode X errors 1040, bad file
extent, some csum missing

root 18950 inode 13845002 errors 1040, bad file extent, some csum missing
root 18952 inode 682022 errors 1040, bad file extent, some csum missing
root 18952 inode 2438161 errors 1040, bad file extent, some csum missing
root 18952 inode 2438162 errors 1040, bad file extent, some csum missing
root 18952 inode 2438166 errors 1040, bad file extent, some csum missing
root 18952 inode 2438167 errors 1040, bad file extent, some csum missing
root 18952 inode 2438170 errors 1040, bad file extent, some csum missing
root 18952 inode 2438187 errors 1040, bad file extent, some csum missing
root 18952 inode 2438260 errors 1040, bad file extent, some csum missing
root 18955 inode 228661 errors 1040, bad file extent, some csum missing
root 28874 inode 682022 errors 1040, bad file extent, some csum missing
root 28874 inode 2438162 errors 1040, bad file extent, some csum missing
root 28874 inode 2438187 errors 1040, bad file extent, some csum missing
root 28874 inode 2438260 errors 1040, bad file extent, some csum missing
root 28877 inode 228661 errors 1040, bad file extent, some csum missing
root 29405 inode 682022 errors 1040, bad file extent, some csum missing
root 29405 inode 2438260 errors 1040, bad file extent, some csum missing
root 29408 inode 228661 errors 1040, bad file extent, some csum missing
root 29581 inode 682022 errors 1040, bad file extent, some csum missing
root 29581 inode 2438260 errors 1040, bad file extent, some csum missing
root 29584 inode 228661 errors 1040, bad file extent, some csum missing
root 29597 inode 682022 errors 1040, bad file extent, some csum missing
root 29597 inode 2438260 errors 1040, bad file extent, some csum missing
root 29600 inode 228661 errors 1040, bad file extent, some csum missing
root 29613 inode 682022 errors 1040, bad file extent, some csum missing
root 29613 inode 2438260 errors 1040, bad file extent, some csum missing
root 29616 inode 228661 errors 1040, bad file extent, some csum missing
root 29629 inode 682022 errors 1040, bad file extent, some csum missing
root 29629 inode 2438260 errors 1040, bad file extent, some csum missing
root 29632 inode 228661 errors 1040, bad file extent, some csum missing
root 29645 inode 682022 errors 1040, bad file extent, some csum missing
root 29645 inode 2438260 errors 1040, bad file extent, some csum missing
root 29648 inode 228661 errors 1040, bad file extent, some csum missing
root 29661 inode 682022 errors 1040, bad file extent, some csum missing
root 29661 inode 2438260 errors 1040, bad file extent, some csum missing
root 29664 inode 228661 errors 1040, bad file extent, some csum missing
ERROR: errors found in fs roots
found 5152420646912 bytes used, error(s) found
total csum bytes: 4748365652
total tree bytes: 22860578816
total fs tree bytes: 15688564736
total extent tree bytes: 1642725376
btree space waste bytes: 3881167880
file data blocks allocated: 24721653870592
referenced 7836810440704

I also tried
$ btrfs check -r 21056933724160 /dev/sda
but the output was exactly same so seems it doesn't really make difference.

So I think btrfs check -b --repair should be able to fix most of things.

> You might try kernel 5.11 which has a new mount option that will skip
> bad roots and csums. It's 'mount -o ro,rescue=3Dall' and while it won't
> let you fix it, in the off chance it mounts, it'll let you get data
> out before trying to repair the file system, which sometimes makes
> things worse.
>
>

It doesn't make any difference, still doesn't mount
$ uname -r
5.11.0-arch2-1
$ sudo mount -o ro,rescue=3Dall /dev/sda ./RAID
mount: /mnt/RAID: wrong fs type, bad option, bad superblock on
/dev/sda, missing codepage or helper program, or other error.

BTRFS warning (device sdl): sdl checksum verify failed on
21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
BTRFS warning (device sdl): sdl checksum verify failed on
21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
BTRFS error (device sdl): failed to read block groups: -5
BTRFS error (device sdl): open_ctree failed

It seems there should be a way to mount with backup tree root like I
did for check but strangly usebackuproot doesn't do that...

piektd., 2021. g. 19. febr., plkst. 21:29 =E2=80=94 lietot=C4=81js Zygo Bla=
xell
(<ce3g8jdj@umail.furryterror.org>) rakst=C4=ABja:
>
> On Thu, Jan 14, 2021 at 01:09:40AM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > Hi,
> >
> > I've 6x 3TB HDD RAID1 BTRFS filesystem where HBA card failed and
> > caused some corruption.
> > When I try to mount it I get
> > $ mount /dev/sdt /mnt
> > mount: /mnt/: wrong fs type, bad option, bad superblock on /dev/sdt,
> > missing codepage or helper program, or other error
> > $ dmesg | tail -n 9
> > [  617.158962] BTRFS info (device sdt): disk space caching is enabled
> > [  617.158965] BTRFS info (device sdt): has skinny extents
> > [  617.756924] BTRFS info (device sdt): bdev /dev/sdl errs: wr 0, rd
> > 0, flush 0, corrupt 473, gen 0
> > [  617.756929] BTRFS info (device sdt): bdev /dev/sdj errs: wr 31626,
> > rd 18765, flush 178, corrupt 5841, gen 0
> > [  617.756933] BTRFS info (device sdt): bdev /dev/sdg errs: wr 6867,
> > rd 2640, flush 178, corrupt 1066, gen 0
>
> You have write errors on 2 disks, read errors on 3 disks, and raid1
> tolerates only 1 disk failure, so successful recovery is unlikely.
>

Those wr/rd/corrupt error counts are inflated/misleading, in past when
some HDD drops out I've had them increase in huge numbers, but after
running scrub usually it was able to fix almost everything except like
few files that could be just deleted. Only now it's possible that it
failed while scrub was running making it a lot worse.

> > [  631.353725] BTRFS warning (device sdt): sdt checksum verify failed
> > on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> > [  631.376024] BTRFS warning (device sdt): sdt checksum verify failed
> > on 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
>
> Both copies of this metadata block are corrupted, differently.
>
> This is consistent with some kinds of HBA failure:  every outgoing block
> from the host is potentially corrupted, usually silently.  Due to the HBA
> failure, there is no indication of failure available to the filesystem
> until after several corrupt blocks are written to disk.  By the time
> failure is detected, damage is extensive, especially for metadata where
> overwrites are frequent.
>

I don't think it's that bad here. My guess is that it failed while
updating extent tree and some part of it didn't got written to disk. I
want to check how it looks like on disk, is there some tool to map
block number to offset in disk?

> This is failure mode that you need backups to recover from (or mirror
> disks on separate, non-failing HBA hardware).
>

I don't know how btrfs decides in which disks it stores copies or if
it's always in same disk. To prevent such failure in future I could
split RAID1 across 2 different HBAs but it's not clear which disks
would need to be seperated.

> > [  631.376038] BTRFS error (device sdt): failed to read block groups: -=
5
> > [  631.422811] BTRFS error (device sdt): open_ctree failed
> >
> > $ uname -r
> > 5.9.14-arch1-1
> > $ btrfs --version
> > btrfs-progs v5.9
> > $ btrfs check /dev/sdt
> > Opening filesystem to check...
> > checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> > checksum verify failed on 21057101103104 found 0000009C wanted 00000075
> > checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> > Csum didn't match
> > ERROR: failed to read block groups: Input/output error
> > ERROR: cannot open file system
> >
> > $ btrfs filesystem show
> > Label: 'RAID'  uuid: 8aef11a9-beb6-49ea-9b2d-7876611a39e5
> > Total devices 6 FS bytes used 4.69TiB
> > devid    1 size 2.73TiB used 1.71TiB path /dev/sdt
> > devid    2 size 2.73TiB used 1.70TiB path /dev/sdl
> > devid    3 size 2.73TiB used 1.71TiB path /dev/sdj
> > devid    4 size 2.73TiB used 1.70TiB path /dev/sds
> > devid    5 size 2.73TiB used 1.69TiB path /dev/sdg
> > devid    6 size 2.73TiB used 1.69TiB path /dev/sdc
> >
> >
> > My guess is that some drives dropped out while kernel was still
> > writing to rest thus causing inconsistency.
> > There should be some way to find out which drives has the most
> > up-to-date info and assume those are correct.
>
> Neither available copy is correct, so the kernel's self-healing mechanism
> doesn't work.  Thousands of pages are damaged, possibly only with minor
> errors, but multiply a minor error by a thousand and it's no longer minor=
.
>
> At this point it is a forensic recovery exercise.
>
> > I tried to mount with
> > $ mount -o ro,degraded,rescue=3Dusebackuproot /dev/sdt /mnt
> > but that didn't make any difference
> >
> > So any idea how to fix this filesystem?
>
> Before you can mount the filesystem read-write again, you would need to
> rebuild the extent tree from the surviving pages of the subvol trees.
> All other metadata pages on the filesystem must be scanned, any excess
> reference items must be deleted, and any missing reference items must
> be inserted.  Once the metadata references are correct, btrfs can
> rebuild the free space maps, and then you can scrub and delete/replace
> any damaged data files.
>
> 'btrfs check --repair' might work if only a handful of blocks are
> corrupted (it takes a few short cuts and can repair minor damage)
> but according to your dev stats you have thousands of corrupted blocks,
> so the filesystem is probably beyond the capabilities of this tool.
>
> 'btrfs check --repair --init-extent-tree' is a brute-force operation that
> will more or less rebuild the entire filesystem by scraping metadata
> leaf pages off the disks.  This is your only hope here, and it's not a
> good one.
>

I don't want to use --init-extent-tree because I don't want to reset
everything, but only corrupted things. Also btrfs check --repair
doesn't work as it aborts too quickly, only using with -b flag could
fix it I think.

> Both methods are likely to fail in the presence of so much corruption
> and they may take so long to run that mkfs + restore from backups could
> be significantly faster.  Definitely extract any data from the filesystem
> that you want to keep _before_ attempting any of these operations.
>

It's not really about time, I rather want to reduce possilble data
loss as much as possible.
I can't mount it even read-only so it seems the only way to get data
out is by using btrfs restore which seems to work fine but does it
verify file checksums? It looks like it doesn't... I have some files
where it said:
We seem to be looping a lot on ./something, do you want to keep going
on ? (y/N/a)

When I checked this file I see that it's corrupted. Basically I want
restore only files with valid checksums and then have a list of
corrupted files. From currupted files there are few I want to see if
they can be recovered. I have lot of of snapshots but even the oldest
ones are corrupted in exactly same way - they're identical. It seems I
need to find previous copy of this file if it exsists at all... Any
idea how to find previous version of file?
I tried
$ btrfs restore -u 2 -t 21056933724160
with different superblocks/tree roots but they all give same corrupted file=
.
The file looks like this
$ hexdump -C file | head -n 5
00000000  27 47 10 00 6d 64 61 74  7b 7b 7b 7b 7b 7b 7b 7b  |'G..mdat{{{{{{=
{{|
00000010  7a 7a 79 79 7a 7a 7a 7a  7b 7b 7b 7c 7c 7c 7b 7b  |zzyyzzzz{{{|||=
{{|
00000020  7c 7c 7c 7b 7b 7b 7b 7b  7c 7c 7c 7c 7c 7b 7b 7b  ||||{{{{{|||||{=
{{|
00000030  7b 7b 7b 7b 7b 7b 7b 7b  7b 7a 7a 7a 7a 79 79 7a  |{{{{{{{{{zzzzy=
yz|
00000040  7b 7b 7b 7b 7a 7b 7b 7c  7b 7c 7c 7b 7c 7c 7b 7b  |{{{{z{{|{||{||=
{{|

Those repeated 7a/b/c is wrong data. Also I'm not sure if these files
have been corrupted now or more in past... So I need to check if
checksum matches.

> It might be possible to recover by manually inspecting the corrupted
> metadata blocks and making guesses and adjustments, but that could take
> even longer than check --repair if there are thousands of damaged pages.
>

I want to look into this but not sure if there are any tools with
which it would be easy to inspect data. dump-tree is nice but it
doesn't work when checksum is incorrect.

My current plan is:
1. btrfs restore only valid files, how? I don't want to mix good files
with corrupted ones together
2. look into how exactly extent tree is corrupted
3. try to see if few of corrupted files can be recovered in some way
4. do btrfs check -b --repair (maybe if extent tree can be fixed then
wouldn't need to use -b flag)
5. try to mount and btrfs scrub
6. maybe wipe and recreate new fielsystem
