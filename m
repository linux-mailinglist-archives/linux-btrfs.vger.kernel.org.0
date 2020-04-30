Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912781BF75E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD3L5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 07:57:54 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:40005 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgD3L5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:53 -0400
X-Greylist: delayed 991 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 07:57:52 EDT
Date:   Thu, 30 Apr 2020 11:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588246880;
        bh=7Dh71GXpxRwmOc6c55DET0/8AWBDsHrSFyKs7YIw3Xw=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=UYxpl+lP/QN6HZjMsMIHNax0caKFIyzU23U6xRU0ulRr9LU+rIInVTo9OIoQtoeOx
         m97lTFD1NlTPUACKBK3VC6UgvBh9WIcxTd3pZCU6DMcRoGMNoz3bBsMtos72UvyoOj
         ZCsxTgksktMU4Un5nqLwvFimjZd1igu+Cg6uw+7c=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Nouts <nouts@protonmail.com>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
In-Reply-To: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello again,
I'm not familiar with mailing list. Should I expect an answer sooner or lat=
er ?
As I need to get back on track as soon as possible, I would like to know if=
 it's too complicated to get an answer quickly from you.
I don't want to be rude, I just want to know if I should wait long enough f=
or an answer that might save my day and my data. Or I'm doomed and I should=
 have wipe my drive already ?

I'll take any answer :)
Thank you

Nouts

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, April 28, 2020 11:26 AM, Nouts <nouts@protonmail.com> wrote:

> Hello,
>
> I am having issue with a RAID1 btrfs pool "failed to read block groups". =
I was advised to send information to this mailing list, as someone might be=
 interested in debug logs and might also help solve my issue.
>
> I have a 3 drive RAID1 pool (2x3TB + 1x6TB), mounted as /home.
>
> My system became really slow while doing nothing, and after a reboot my /=
home pool can't mount.This is the error I got :
>
> [ 4645.402880] BTRFS info (device sdb): disk space caching is enabled
> [ 4645.405687] BTRFS info (device sdb): has skinny extents
> [ 4645.451484] BTRFS error (device sdb): failed to read block groups: -11=
7
> [ 4645.472062] BTRFS error (device sdb): open_ctree failed
> mount: wrong fs type, bad option, bad superblock on /dev/sdb,missing code=
page or helper program, or other error
> In some cases useful info is found in syslog - trydmesg | tail or so.
>
> I attached you the smartctl result from the day before and the last scrub=
 report I got from a month ago. From my understanding, it was ok.
> I use hardlink (on the same partition/pool) and I deleted some data just =
the day before. I suspect my daily scrub routine triggered something that n=
ight and next day /home was gone.
>
> I can't scrub anymore as it's not mounted. Mounting with usebackuproot or=
 degraded or ro produce the same error.
> I tried "btrfs check /dev/sda" :
> checking extents
> leaf parent key incorrect 5909107507200
> bad block 5909107507200
> Errors found in extent allocation tree or chunk allocation
> Checking filesystem on /dev/sda
> UUID: 3720251f-ef92-4e21-bad0-eae1c97cff03
>
> Then "btrfs rescue super-recover /dev/sda" :
> All supers are valid, no need to recover
>
> Then "btrfs rescue zero-log /dev/sda", which produced a weird stacktrace.=
..
> Unable to find block group for 0
> extent-tree.c:289: find_search_start: Assertion '1' failed.
> btrfs[0x43e418]
> btrfs(btrfs_reserve_extent+0x5c9)[0x4425df]
> btrfs(btrfs_alloc_free_block+0x63[0x44297c]
> btrfs(__btrfs_cow_block+0xfc[0x436636]
> btrfs(btrfs_cow_block+0x8b)[0x436bd8]
> btrfs[0x43ad82]
> btrfs(btrfs_commit_transaction+0xb8)[0x43c5dc]
> btrfs[0x42c0d4]btrfs(main+0x12f)[0x40a341]/lib/x86_64-linux-gnu/libc.so.6=
(__libc_start_main+0xf1)[0x7f1462d712e1]
> btrfs(_start+0x2a)[0x40a37a]
> Clearing log on /dev/sda, previous log_root 0, level 0
>
> Finally I tried "btrfs rescue chunk-recover /dev/sda", which run on all 3=
 drives at the same time during 8+ hours...
> It asks to rebuild some metadata tree, which I accepted (I did not saved =
the full output sorry) and it ended with the same stacktrace as above.
>
> The only command left is "btrfs check --repair" but I afraid it might do =
more bad than good.
>
> I'm running Debian 9 (still, because of some dependencies). My kernel is =
already backported : 4.19.0-0.bpo.6-amd64 #1 SMP Debian 4.19.67-2+deb10u2~b=
po9+1 (2019-11-12) x86_64 GNU/Linux
> btrfs version : v4.7.3
> I originally posted on reddit : https://www.reddit.com/r/btrfs/comments/g=
99v4v/nas_raid1_not_mounting_failed_to_read_block_groups/
>
> Let me know if you need more information.
>
> Nouts


