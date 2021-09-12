Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F263407E6A
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhILQI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 12:08:27 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:58217 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhILQI1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 12:08:27 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id 7434F210244; Sun, 12 Sep 2021 17:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631461885;
        bh=HtMVELN8ClfZ6/tfXgLWmcqeTfYCA8+zAzKdFy3TAZ8=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=M04FH8G4/hZT+1S7e9cRSjY9jjV6If22GQnEMomeujbgF84tLLw0WZ64wlAR4Ydjj
         PCSr1d5mF7Ai37k946mPl/+mW3td1oOPxbgqKiYasE4jlklMAgfPaiooF9onlqKqXc
         q2KylDZ9EF1ynx/VgTXd+9yGxoxCiG6U1+5/Vjr8=
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 12 Sep 2021 17:51:25 +0200
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <e71b92f4-43ba-1544-07c7-2dcc1dbf546c@gmx.com>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <7163096f475d3c31d7513c22277ad00f@linuxsystems.it>
 <e71b92f4-43ba-1544-07c7-2dcc1dbf546c@gmx.com>
Message-ID: <7294d85b7a0b3386be95fbe2d1ec6f9b@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-12 15:35 Qu Wenruo ha scritto:
> My bad, the commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
> skip bad extent tree when reading block group items"), which is only
> merged into the incoming v5.15-rc1.

I've compiled linux-git master and tried again:

$ uname -a
Linux arch-laptop 5.14.0-1-git-11152-g78e709522d2c #1 SMP PREEMPT Sun, 
12 Sep 2021 12:53:13 +0000 x86_64 GNU/Linux

$ sudo mount -o ro,rescue=ibadroots 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6.img.copy 
/mnt2/
mount: /mnt2: can't read superblock on /dev/loop0.

[  196.277414] loop: module loaded
[  196.278228] loop0: detected capacity change from 0 to 207618048
[  196.736456] BTRFS: device label fedora_localhost-live devid 1 transid 
1029644 /dev/loop0 scanned by mount (2730)
[  196.736819] BTRFS info (device loop0): flagging fs with big metadata 
feature
[  196.736825] BTRFS info (device loop0): ignoring bad roots
[  196.736826] BTRFS info (device loop0): disk space caching is enabled
[  196.736827] BTRFS info (device loop0): has skinny extents
[  197.408704] BTRFS warning (device loop0): checksum verify failed on 
21348679680 wanted 0xd05bf9be found 0x2874489b level 1
[  197.408843] BTRFS info (device loop0): start tree-log replay
[  197.408847] BTRFS warning (device loop0): log replay required on RO 
media
[  197.409458] BTRFS error (device loop0): open_ctree failed

So I've added nologreplay and it did the trick:

$ sudo mount -o ro,rescue=nologreplay:ibadroots 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6.img.copy 
/mnt2/

[  416.913016] loop0: detected capacity change from 0 to 207618048
[  416.918895] BTRFS info (device loop0): flagging fs with big metadata 
feature
[  416.918903] BTRFS info (device loop0): disabling log replay at mount 
time
[  416.918905] BTRFS info (device loop0): ignoring bad roots
[  416.918907] BTRFS info (device loop0): disk space caching is enabled
[  416.918908] BTRFS info (device loop0): has skinny extents
[  416.929887] BTRFS warning (device loop0): checksum verify failed on 
21348679680 wanted 0xd05bf9be found 0x2874489b level 1

$ sudo btrfs subvolume list /mnt2 | grep -v snapshot | grep -v docker
ID 256 gen 1029644 top level 5 path home
ID 265 gen 1029641 top level 256 path home/niko/.cache
ID 912 gen 1029406 top level 5 path images
ID 2428 gen 359129 top level 5 path var
ID 2429 gen 1026054 top level 2428 path var/tmp
ID 2430 gen 1029044 top level 2428 path var/cache
ID 2433 gen 1029641 top level 5 path root
ID 2653 gen 1029641 top level 5 path avd

$ ls -al /mnt2
totale 16
drwxr-xr-x 1 root root  58 16 giu 19.09 .
drwxr-xr-x 1 root root 198 12 set 17.50 ..
drwxr-xr-x 1 niko niko  72 26 ago 10.22 avd
drwxr-xr-x 1 root root  28 16 apr 10.25 home
drwxrwxrwx 1 niko niko  96 20 ago 17.23 images
dr-xr-xr-x 1 root root 196 24 ago 14.58 root
drwxr-xr-x 1 root root  28 16 apr 10.21 snapshots
drwxr-xr-x 1 root root  16 13 giu 00.10 var

Apart from backing my files up, what else should I be able to do at this 
point?

I've tried scrubbing but it's a no go:

$ sudo btrfs scrub start /dev/loop0
scrub started on /dev/loop0, fsid d3d387d6-eb5e-4b4b-9a9c-581d74fb56b4 
(pid=3255)

$ sudo btrfs scrub status /dev/loop0
UUID:             d3d387d6-eb5e-4b4b-9a9c-581d74fb56b4
Scrub started:    Sun Sep 12 18:00:30 2021
Status:           aborted
Duration:         0:00:00
Total to scrub:   97.27GiB
Rate:             0.00B/s
Error summary:    no errors found

Any chance to recover the partition?

Niccolò
