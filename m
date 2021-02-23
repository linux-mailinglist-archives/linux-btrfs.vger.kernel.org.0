Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACA322DE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhBWPrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 10:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhBWPq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 10:46:57 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA6C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 07:46:15 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d5so5599680iln.6
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HeB9/rVOC73M3wHWIhLI44Y56YJe6d58NpvYTbe+Pb0=;
        b=lGtI/roXtRjT9N+IiX3kSVca0tS1XsvT+APY1RSa1P46AjoKZtUykMAJJifxqjhfeO
         OEeb6NT/KMlv95Do/Cmu4gvmcLcZD4TdIFghH5HJ5wQE3pcru3xb5G7KzAN+KIROT85V
         r3UJ8hFLG3v/0NJ4QEBw0GyQA+HKItpVmqOYWkpZvrI8uS/iGeZ1SFmN2blX4gugdSXv
         1oRLxs+cFUccULsPF9qF/5X+52h+7Vxq7mPPgkCT7jjdaKT7nQN7mXHr8RGBaukdYDzq
         awK9lxNmm4Td90iQWg0Xaxmrf3b/V3qdMdlm5weWUVgDxO8UDy9J0t7XO4TYbha/kL0P
         lClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HeB9/rVOC73M3wHWIhLI44Y56YJe6d58NpvYTbe+Pb0=;
        b=ileI2JFXyaf3gTbQQqZpqkgNPSca8E9+U2le0WgFwykJKQ1MH0nafjyIMaEH3AyHLO
         TmDGJ0zqOl7KQ13I7MA95sBQyWVjmReim4JkfRBdHjgp+FVHoBcf3OcAG84M6Sm7a5oS
         VbA1S3bvNbNDLgnlYrecW4oQgcwZob7BKfnCJ+qR2eW6m3Un/vQbn6rmtGzIHpz+FbMc
         9TL5vVJGM/HmgieEg1NvFtDf4p2hAPwfAzZ1TdX5ibdG3TO+iq34Za0DfyL+5GHzdx7n
         d2z5axl83r60HvbTyKQA2MPRzIiz5qg1dD61E9wcpju10nAjxSFbOvSCNQKkA4CLTsT6
         WB3w==
X-Gm-Message-State: AOAM531zEBUHA2FYUl60IRxYEZLVtBJphe5boj4BYduiwpMzp3U06bCo
        BlC3Q/Vmbs+zJyPrUxhvHRk61Xzox/Tb+FqHeu8s0cdC3kc=
X-Google-Smtp-Source: ABdhPJxg93rRW1HVr6euNH0NqIHt9TOxV99ZXLoowJi3EM05bWCWGRNQmBodtEIMIe31uGOYTAiKP0Lnd8GGve5f1Y8=
X-Received: by 2002:a92:4105:: with SMTP id o5mr19734631ila.47.1614095175315;
 Tue, 23 Feb 2021 07:46:15 -0800 (PST)
MIME-Version: 1.0
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Tue, 23 Feb 2021 16:45:39 +0100
Message-ID: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
Subject: All files are damaged after btrfs restore
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all.
Sorry for asking here directly, but I'm in a desperate situation and
out of options.
I have a 72 TB btrfs filesystem which functions as a backup drive.
After a recent controller hardware failure while the backup was
running, both original and backup fs were severely damaged.

Kernel version is 5.7.7. btrfs-progs is (now) 5.9.

At the moment I am unable to mount the btrfs filesystem.

root@hikitty:~$ mount -t btrfs -o ro,recovery /dev/sdf1 /mnt/
mount: wrong fs type, bad option, bad superblock on /dev/sdf1,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

[165097.777496] BTRFS warning (device sdf1): 'recovery' is deprecated,
use 'usebackuproot' instead
[165097.777500] BTRFS info (device sdf1): trying to use backup root at
mount time
[165097.777502] BTRFS info (device sdf1): disk space caching is enabled
[165097.777505] BTRFS info (device sdf1): has skinny extents
[165101.721250] BTRFS error (device sdf1): bad tree block start, want
126718415241216 have 0
[165101.750951] BTRFS error (device sdf1): bad tree block start, want
126718415241216 have 0
[165101.755753] BTRFS error (device sdf1): failed to verify dev
extents against chunks: -5
[165101.895065] BTRFS error (device sdf1): open_ctree failed


Since I desperately need the data I ran btrfs restore.
root@hikitty:~$ install/btrfs-progs-5.9/btrfs -v restore -i -s -m -S
--path-regex '^/(|@(|/backup(|/home(|/.*))))$' /dev/sdf1
/mnt/dumpo/home/
checksum verify failed on 109911545430016 found 000000B6 wanted 00000000
checksum verify failed on 109911545462784 found 000000B6 wanted 00000000
checksum verify failed on 57767345897472 found 000000B6 wanted 00000000
Restoring /mnt/dumpo/home/@
Restoring /mnt/dumpo/home/@/backup
Restoring /mnt/dumpo/home/@/backup/home
=E2=80=A6
(2.1 GB of log file)
=E2=80=A6
Done searching /@/backup/home
Reached the end of the tree searching the directory
Reached the end of the tree searching the directory
Reached the end of the tree searching the directory


Using that restore I was able to restore approx. 7 TB of the
originally stored 22 TB under that directory.
Unfortunately nearly all the files are damaged. Small text files are
still OK. But every larger binary file is useless.
Is there any possibility to fix the filesystem in a way, that I get
the data less damaged?

So far I ran no btrfs check --repair.

Since the original and the backup have been damaged any help would be
highly appreciated.
Thanks for your assistance.

Kind regards,
Sebastian Roller

----------------  Attachment. All outputs. -------------------
uname -a
Linux hikitty 5.7.7-1.el7.elrepo.x86_64 #1 SMP Wed Jul 1 11:53:16 EDT
2020 x86_64 x86_64 x86_64 GNU/Linux


root@hikitty:~$ install/btrfs-progs-5.9/btrfs --version
btrfs-progs v5.9
(Version v5.10 fails to compile)


root@hikitty:~$ btrfs fi show
Label: 'history'  uuid: 56051c5f-fca6-4d54-a04e-1c1d8129fe56
        Total devices 1 FS bytes used 68.37TiB
        devid    2 size 72.77TiB used 68.59TiB path /dev/sdf1


root@hikitty:~$ mount -t btrfs -o ro,recovery /dev/sdf1 /mnt/hist/
mount: wrong fs type, bad option, bad superblock on /dev/sdf1,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

[165097.777496] BTRFS warning (device sdf1): 'recovery' is deprecated,
use 'usebackuproot' instead
[165097.777500] BTRFS info (device sdf1): trying to use backup root at
mount time
[165097.777502] BTRFS info (device sdf1): disk space caching is enabled
[165097.777505] BTRFS info (device sdf1): has skinny extents
[165101.721250] BTRFS error (device sdf1): bad tree block start, want
126718415241216 have 0
[165101.750951] BTRFS error (device sdf1): bad tree block start, want
126718415241216 have 0
[165101.755753] BTRFS error (device sdf1): failed to verify dev
extents against chunks: -5
[165101.895065] BTRFS error (device sdf1): open_ctree failed


root@hikitty:~$ btrfs rescue super-recover -v /dev/sdf1
All Devices:
        Device: id =3D 2, name =3D /dev/sdh1

Before Recovering:
        [All good supers]:
                device name =3D /dev/sdh1
                superblock bytenr =3D 65536

                device name =3D /dev/sdh1
                superblock bytenr =3D 67108864

                device name =3D /dev/sdh1
                superblock bytenr =3D 274877906944

        [All bad supers]:

All supers are valid, no need to recover


root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
Scanning: DONE in dev0
checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
bytenr mismatch, want=3D124762809384960, have=3D0
open with broken chunk error
Chunk tree recovery failed

^^ This was btrfs v4.14


root@hikitty:~$ install/btrfs-progs-5.9/btrfs check --readonly /dev/sdi1
Opening filesystem to check...
checksum verify failed on 99593231630336 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960, ha=
ve=3D0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system


FIRST MOUNT AT BOOT TIME AFTER DESASTER
Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): disk space
caching is enabled
Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): has skinny extent=
s
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944039161856 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944039161856 (dev /dev/sdf1 sector 3974114336)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944039165952 (dev /dev/sdf1 sector 3974114344)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944039170048 (dev /dev/sdf1 sector 3974114352)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944039174144 (dev /dev/sdf1 sector 3974114360)
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944037851136 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944037851136 (dev /dev/sdf1 sector 3974111776)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944037855232 (dev /dev/sdf1 sector 3974111784)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944037859328 (dev /dev/sdf1 sector 3974111792)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944037863424 (dev /dev/sdf1 sector 3974111800)
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944040767488 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944040767488 (dev /dev/sdf1 sector 3974117472)
Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
corrected: ino 0 off 141944040771584 (dev /dev/sdf1 sector 3974117480)
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944035147776 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944035115008 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944035131392 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944036327424 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944036278272 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944035164160 have 0
Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
block start, want 141944036294656 have 0
Feb 15 08:05:16 hikitty kernel: BTRFS error (device sdf1): failed to
verify dev extents against chunks: -5
Feb 15 08:05:16 hikitty kernel: BTRFS error (device sdf1): open_ctree faile=
d
