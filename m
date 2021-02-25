Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C7324A3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 06:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhBYFlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 00:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYFlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 00:41:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0974C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 21:40:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so3317047wml.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 21:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ovM5qbeFBFD73UPJw99m1OGdnAezLZmrcThtp+UyWIo=;
        b=gI6F5mle/m1FUzhH5ZR14QNP2yc85Xu3c3sSbOpl4OfaDbWm1iqpXUBZ3azUy9wm5o
         zJzNJQyf8vpOY5uIYbBSAWADTWNWngKOvHB76/6J7LrrfuC/Uw6Q/2FXGcDPd9CSyp6t
         Vunc711l5mFZFnJNCKNoQ0TLB2odIecJBGnseMaUnUE6v1xLdAV1O4kJpUL19q3ZU/3+
         sqi6VwtwxZcfKKdzxLcct5/VEkaEirQC+qgHxmHuUpFYJTzgKbnWvJQqJOZaI/V0q2pD
         LnqyulIUzCeRrs6Nc955w76Uqldx5yFdlgnp5GFrBjgV7+Lzhbw/asiv+aK/Fb5foJIA
         zjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ovM5qbeFBFD73UPJw99m1OGdnAezLZmrcThtp+UyWIo=;
        b=N1nD8uemrXV4AsapAKuTYnU5oeAxijBkQ63gzkjJiAf+Mu5DUo6740dpvkqamhODfR
         5juGtidiFW8RGvSLAeU1myUdMwiRtWiimlMzEBW8iF1k97gQCuwJ38/WwhbgGPOrRUAQ
         BSnfqh3cLnKj5B9DaJmB7uzZoc112WNz1jtkbj2GPgawZcP8fz2qPHsJYpPaRUFLj+Gk
         HMmLWrHnEPFZFbQSTU8At4M6TaOqxIv6RwhByJg4OnXiv8FtlZm7EB7Ym40XdubJzIYH
         zBYx4U0Wdj7rHNtqdKGWYO1ADFCOc5RZT5EWIm1wPpdqDpbw1Xi9K+SuTQfYdwhO5X8K
         r/gg==
X-Gm-Message-State: AOAM530xxY6Vi/y3or9WRn8EULAOnjDrmgAtPijvTVWvWnNlx763J0EO
        G9v1Xd55FWa7U1ttFrmV+VP3VQ1SgpRD3lXKXIQHFg==
X-Google-Smtp-Source: ABdhPJzcO+Ryus1yqJ9dqPN2/YdF9UACO9GIMtqwml6cn29/SIHNDjoQ7wA5WFQpf5uUSM+K6tTV85g0ro3zh+TYyYQ=
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr1414908wma.124.1614231623396;
 Wed, 24 Feb 2021 21:40:23 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
In-Reply-To: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 24 Feb 2021 22:40:07 -0700
Message-ID: <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 23, 2021 at 8:49 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:
>
> Hello all.
> Sorry for asking here directly, but I'm in a desperate situation and
> out of options.
> I have a 72 TB btrfs filesystem which functions as a backup drive.
> After a recent controller hardware failure while the backup was
> running, both original and backup fs were severely damaged.
>
> Kernel version is 5.7.7. btrfs-progs is (now) 5.9.
>
> At the moment I am unable to mount the btrfs filesystem.
>
> root@hikitty:~$ mount -t btrfs -o ro,recovery /dev/sdf1 /mnt/
> mount: wrong fs type, bad option, bad superblock on /dev/sdf1,
>        missing codepage or helper program, or other error
>
>        In some cases useful info is found in syslog - try
>        dmesg | tail or so.
>
> [165097.777496] BTRFS warning (device sdf1): 'recovery' is deprecated,
> use 'usebackuproot' instead
> [165097.777500] BTRFS info (device sdf1): trying to use backup root at
> mount time
> [165097.777502] BTRFS info (device sdf1): disk space caching is enabled
> [165097.777505] BTRFS info (device sdf1): has skinny extents
> [165101.721250] BTRFS error (device sdf1): bad tree block start, want
> 126718415241216 have 0
> [165101.750951] BTRFS error (device sdf1): bad tree block start, want
> 126718415241216 have 0
> [165101.755753] BTRFS error (device sdf1): failed to verify dev
> extents against chunks: -5
> [165101.895065] BTRFS error (device sdf1): open_ctree failed
>
>
> Since I desperately need the data I ran btrfs restore.
> root@hikitty:~$ install/btrfs-progs-5.9/btrfs -v restore -i -s -m -S
> --path-regex '^/(|@(|/backup(|/home(|/.*))))$' /dev/sdf1
> /mnt/dumpo/home/
> checksum verify failed on 109911545430016 found 000000B6 wanted 00000000
> checksum verify failed on 109911545462784 found 000000B6 wanted 00000000
> checksum verify failed on 57767345897472 found 000000B6 wanted 00000000
> Restoring /mnt/dumpo/home/@
> Restoring /mnt/dumpo/home/@/backup
> Restoring /mnt/dumpo/home/@/backup/home
> =E2=80=A6
> (2.1 GB of log file)
> =E2=80=A6
> Done searching /@/backup/home
> Reached the end of the tree searching the directory
> Reached the end of the tree searching the directory
> Reached the end of the tree searching the directory
>
>
> Using that restore I was able to restore approx. 7 TB of the
> originally stored 22 TB under that directory.
> Unfortunately nearly all the files are damaged. Small text files are
> still OK. But every larger binary file is useless.
> Is there any possibility to fix the filesystem in a way, that I get
> the data less damaged?
>
> So far I ran no btrfs check --repair.
>
> Since the original and the backup have been damaged any help would be
> highly appreciated.
> Thanks for your assistance.
>
> Kind regards,
> Sebastian Roller
>
> ----------------  Attachment. All outputs. -------------------
> uname -a
> Linux hikitty 5.7.7-1.el7.elrepo.x86_64 #1 SMP Wed Jul 1 11:53:16 EDT
> 2020 x86_64 x86_64 x86_64 GNU/Linux
>
>
> root@hikitty:~$ install/btrfs-progs-5.9/btrfs --version
> btrfs-progs v5.9
> (Version v5.10 fails to compile)
>
>
> root@hikitty:~$ btrfs fi show
> Label: 'history'  uuid: 56051c5f-fca6-4d54-a04e-1c1d8129fe56
>         Total devices 1 FS bytes used 68.37TiB
>         devid    2 size 72.77TiB used 68.59TiB path /dev/sdf1
>
>
> root@hikitty:~$ mount -t btrfs -o ro,recovery /dev/sdf1 /mnt/hist/
> mount: wrong fs type, bad option, bad superblock on /dev/sdf1,
>        missing codepage or helper program, or other error
>
>        In some cases useful info is found in syslog - try
>        dmesg | tail or so.
>
> [165097.777496] BTRFS warning (device sdf1): 'recovery' is deprecated,
> use 'usebackuproot' instead
> [165097.777500] BTRFS info (device sdf1): trying to use backup root at
> mount time
> [165097.777502] BTRFS info (device sdf1): disk space caching is enabled
> [165097.777505] BTRFS info (device sdf1): has skinny extents
> [165101.721250] BTRFS error (device sdf1): bad tree block start, want
> 126718415241216 have 0
> [165101.750951] BTRFS error (device sdf1): bad tree block start, want
> 126718415241216 have 0
> [165101.755753] BTRFS error (device sdf1): failed to verify dev
> extents against chunks: -5
> [165101.895065] BTRFS error (device sdf1): open_ctree failed
>
>
> root@hikitty:~$ btrfs rescue super-recover -v /dev/sdf1
> All Devices:
>         Device: id =3D 2, name =3D /dev/sdh1
>
> Before Recovering:
>         [All good supers]:
>                 device name =3D /dev/sdh1
>                 superblock bytenr =3D 65536
>
>                 device name =3D /dev/sdh1
>                 superblock bytenr =3D 67108864
>
>                 device name =3D /dev/sdh1
>                 superblock bytenr =3D 274877906944
>
>         [All bad supers]:
>
> All supers are valid, no need to recover
>
>
> root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
> Scanning: DONE in dev0
> checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> bytenr mismatch, want=3D124762809384960, have=3D0
> open with broken chunk error
> Chunk tree recovery failed
>
> ^^ This was btrfs v4.14
>
>
> root@hikitty:~$ install/btrfs-progs-5.9/btrfs check --readonly /dev/sdi1
> Opening filesystem to check...
> checksum verify failed on 99593231630336 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960, =
have=3D0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
>
> FIRST MOUNT AT BOOT TIME AFTER DESASTER
> Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): disk space
> caching is enabled
> Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): has skinny exte=
nts
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944039161856 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944039161856 (dev /dev/sdf1 sector 3974114336)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944039165952 (dev /dev/sdf1 sector 3974114344)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944039170048 (dev /dev/sdf1 sector 3974114352)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944039174144 (dev /dev/sdf1 sector 3974114360)
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944037851136 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944037851136 (dev /dev/sdf1 sector 3974111776)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944037855232 (dev /dev/sdf1 sector 3974111784)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944037859328 (dev /dev/sdf1 sector 3974111792)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944037863424 (dev /dev/sdf1 sector 3974111800)
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944040767488 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944040767488 (dev /dev/sdf1 sector 3974117472)
> Feb 15 08:05:12 hikitty kernel: BTRFS info (device sdf1): read error
> corrected: ino 0 off 141944040771584 (dev /dev/sdf1 sector 3974117480)
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944035147776 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944035115008 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944035131392 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944036327424 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944036278272 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944035164160 have 0
> Feb 15 08:05:12 hikitty kernel: BTRFS error (device sdf1): bad tree
> block start, want 141944036294656 have 0
> Feb 15 08:05:16 hikitty kernel: BTRFS error (device sdf1): failed to
> verify dev extents against chunks: -5
> Feb 15 08:05:16 hikitty kernel: BTRFS error (device sdf1): open_ctree fai=
led

I think you best chance is to start out trying to restore from a
recent snapshot. As long as the failed controller wasn't writing
totally spurious data in random locations, that snapshot should be
intact.

If there are no recent snapshots, and it's unknown what the controller
was doing while it was failing or how long it was failing for?
Recovery can be difficult.

Try using btrfs-find-root to find older roots, and use that value with
btrfs restore -t option. These are not as tidy as snapshots though,
the older they are, the more they dead end into more recent
overwrites. So you want to start out with the most recent roots you
can and work backwards in time.


--=20
Chris Murphy
