Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33B33E645
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 02:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhCQBia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 21:38:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:34055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCQBiG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 21:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615945084;
        bh=Ejxa2TJLMrZTEH/+H1OiR0i8vqMnF+jdCFcfTxzcNhc=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=OnETlQCwvXkTazDrKi3sQdIKb1Gv6w84S+nWrbN3uzi17CvtEnnjPHpLZMI2Jh0W3
         Cg9IjEzxNV2WrAUP4dz6sWiLvtqO7jZw0NneDlOqRhzOQMshBsLdLux4GQkel/Bs1a
         eUfcsJF7QZ1wzzZCHBgVftjmcnBABPScN8BP5804=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1l2iqO3wAV-00P9yJ; Wed, 17
 Mar 2021 02:38:04 +0100
To:     Sebastian Roller <sebastian.roller@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: All files are damaged after btrfs restore
Message-ID: <2411012e-0b50-ff76-2710-5fa55b8487eb@gmx.com>
Date:   Wed, 17 Mar 2021 09:38:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xs8QM2VQukBfkuGPCdF3uxbKtxIgUBzC+tPuHcUSCASRprZlSgg
 oA+90yB13zGqvjg5+bI4H8fcQh4AGrR7J+sLvADOUe+02IXuxLBizROW6Uyq0iZD1hBzUPT
 CjqU63dKdqlPWiOEezr1AOJVi3NQ7qOYDyenN10CwdAmcRDHDqmz9yqEJWsoVQzunJ4e1t5
 EAwJZT5+WSKRmo/HX6TNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cl4jRPFFm9s=:yGPi34P86cqk1ElXxmRHHm
 yPo7nBJL8Ty1hpGmD4DlLO+UVjXeAXqwTHYC1CSSOtQYCMhZuOiGqd1w2Z6fhTjixQBAta/u5
 FcUtk1kDkdZGXLXruJ5gehjs+0aqd/PNH5qAvFlPsH7uw0G2MuecEjG1aMMEsSopmsKILtjFi
 yNcNLWkeOLO//MUS1zS5sFxnYVGk+psq9wRy7S9V8JYjA52zH5ErmEfHyBZveGLCDLjkHtgMP
 I97fLp1Cb/YzYXxb1spLTVXQNVYyhj5rFLL34+7LspEaWhvoLERb47MBvdqVQ8PhuliKmL94k
 4xhZ0xTOm47eCI2vH2kJVKH8matrgPSeFnvtBVbDLWNk0lQrIA0KVPZ47uG9nzrEuaie6OVv5
 6noojiG4GM0J8JvYFvBmT3zRMZzt4JoGwSRqOVLXnqsaqktBMhp4aOufExgnAXmNjLEDtFb4k
 Oe0uZJRRvTwCZ0OR4SN24PAEfwC9i/M+UY21VWF2ZcKblbQa5mx5rlqeX4OeQSaan0NwmxvM0
 W3SawFQxQm6no7MEXtTe4LafSuRyYm9emeYSrKYLMvgS6hhjGla0bcnKL8945ydv21xVLjDBs
 rIiv0d+DZIC4pyZAOPQbiHpgx3UI8304ubIhBPDuoQVgptmwWmpoOlCgKlRD/jh5P5JtxGm9+
 2dGBvEDqbZhr33GVMDfwxd6HopC0PV43FCEsuopt6QeqnRaAmvHpfrTd6PrugSGiI7zwHyXaR
 nx01qRjEMogNxi6eT5XX+pyPS7A2bDM2I/mN48JjoaG8/SGL6iK9Z2OaZTYDXrOptX18ykQR0
 nOyk9MscFlif4bXEfI//VmxZmAZYMizcjOeqXceXJzDkn87T/aVfOJx4oHB9tH7UrSFNyNZk+
 I5RMakn8f/At9otiJcVg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8B=E5=8D=8811:45, Sebastian Roller wrote:
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
>         missing codepage or helper program, or other error
>
>         In some cases useful info is found in syslog - try
>         dmesg | tail or so.
>
> [165097.777496] BTRFS warning (device sdf1): 'recovery' is deprecated,
> use 'usebackuproot' instead
> [165097.777500] BTRFS info (device sdf1): trying to use backup root at
> mount time
> [165097.777502] BTRFS info (device sdf1): disk space caching is enabled
> [165097.777505] BTRFS info (device sdf1): has skinny extents
> [165101.721250] BTRFS error (device sdf1): bad tree block start, want
> 126718415241216 have 0

This means the tree block is completely wiped out.

And I don't believe it's just one tree block wiped out, but a much
larger range of on-disk data get wiped out.

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

This looks like the same problem.

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

 From the result, it looks like the on-disk data get (partially) wiped out=
.
I doubt if it's just simple controller failure, but more likely
something not really reaching disk or something more weird.

In short, this is really the worst case.

Thanks,
Qu


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
>          Total devices 1 FS bytes used 68.37TiB
>          devid    2 size 72.77TiB used 68.59TiB path /dev/sdf1
>
>
> root@hikitty:~$ mount -t btrfs -o ro,recovery /dev/sdf1 /mnt/hist/
> mount: wrong fs type, bad option, bad superblock on /dev/sdf1,
>         missing codepage or helper program, or other error
>
>         In some cases useful info is found in syslog - try
>         dmesg | tail or so.
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
>          Device: id =3D 2, name =3D /dev/sdh1
>
> Before Recovering:
>          [All good supers]:
>                  device name =3D /dev/sdh1
>                  superblock bytenr =3D 65536
>
>                  device name =3D /dev/sdh1
>                  superblock bytenr =3D 67108864
>
>                  device name =3D /dev/sdh1
>                  superblock bytenr =3D 274877906944
>
>          [All bad supers]:
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
> bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960,=
 have=3D0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
>
> FIRST MOUNT AT BOOT TIME AFTER DESASTER
> Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): disk space
> caching is enabled
> Feb 15 08:05:11 hikitty kernel: BTRFS info (device sdf1): has skinny ext=
ents
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
> Feb 15 08:05:16 hikitty kernel: BTRFS error (device sdf1): open_ctree fa=
iled
>
