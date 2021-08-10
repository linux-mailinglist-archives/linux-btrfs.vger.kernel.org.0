Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3E3E53FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhHJG4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 02:56:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:40439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhHJG4x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 02:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628578586;
        bh=eCtRGqaXjwsz39Zbg50sIkjXa6fvvvUpMThPo6bcbxE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AbUc8Qx4f5lnvIuoUJ1CbaOmmZWWzAMPnQ6yDVdSiqEXuRg+iMBpkcDaIzKW/rOwO
         P5rinQ3cYNTyKQ+uJ0S0thyVODmvc+iIBQ9cfKc38VLNgAS6DnnWvJ6VjP7p7r+/MA
         J7ShGVuSRDUAwR/BtWKxPvfL2LZiNMhARhIR4tKA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1mkESI4Au3-00gsvN; Tue, 10
 Aug 2021 08:56:26 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
Date:   Tue, 10 Aug 2021 14:56:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YLU38i/gZ37EwCkMDguf46aY9sY6b7SIiv+ORtyqMZl2wZiHNDw
 T1RHycY/VDtA30z35X0G9YgiHFUaTRv7DO6jPMZYd+ezZSe5i4s+fPBIShJ7r/2lmUg49t7
 +pvI43NfCLm4P5laDc/TkOKpV45uqehQ+4GyTNvAN+ZxaV7lMtyA7YhdeOOr0c1EyZ2TRd0
 eVoywA9ZUw7cv5rFGwYyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gSoHpFy5byk=:oqTbeRmx7mmVz3wgjCfvKJ
 +sRrJk6gFVSa6Yl9Xy447CUsbl2kvi5s5P5TCdN5kS1EWst/YwXz5q16YGoP/zthsqqf+Xp1R
 d91u4/87fxRzdKBhvMCS46WPTdi+j6BQ43yyFtOPh9q/fQZ+L2Mb4xnOcAARdUN3RYEXxv0j3
 RS6PfzwIA1mPGbQpsrNGzXwa1mQQshGj6w3EqRJ5i5gQYYOfMQ/I9YuUZCBX7P5wk0HMGJPlC
 9yK1UZ2KmFKSw50ruFTiDAErx69Byu863k8ie6L2gItuP0xgH/9KOk53LPFLyrAxLXiZh5Emf
 LS8JM5jPhjUu+6EIbdO5IwScvuWMLICeXjGW4zxt2pdumY9w3baGqumLmnUMT0f9OdgGb4A0i
 2ILJP9oxtSO5PaBYBbpMUuuUqp/WAFsY9+9aDxeiMYz5XQSJfMeEQF+4ei2eR6mzLdZfJg4os
 oUbuuU0V3gM1LjFBN7x7TkpTPQIO+NUggIzxK87Z6UJgQMPJiZMLYMyYWSJyRt5hXRQukFH3H
 ySuXvWsQoE3WyjoZpexUF7O5HW4U+qp/aGm/DipK01XKSHLxrp9gahU4lOlmKVn4ST12a2cfg
 Zitq5a7JAVDvaENMwKCUzXiJiQfxHsdN/9ci/0ovyz4876hpKbqvTokzm0JXCQNWNlYNYO0dG
 i+HD8MNtxzAJhmOVjn7Hs3gd5+wuOial4jAVGFgvD5278UeizHvVAu7Dj6WaL/gJ8SechEoP8
 bN9wteP5PfwzCGq3ObrwPLOcXd0lsPo/MUq2Ih1YQGnma8m06mDdHzAROVWHfIO8nrC8A88W2
 v4Sxoe8+ZUDHTOof6tmfqjUN9d6nnmK6PulQT2DcKxy1/B64bjyCu5mF7vxAX90Yzvw8ef57M
 GcrYr39a+ZIObmTzAKtR3lOu3YfDZjZADtW8zJuGQv7OjFZ+pk3FtBggJ5QMwTgx9fmpEpng+
 u6KPlGy7G/I+pTG/vlJSbohrHlBNpkjFDYrQuc8ACcQc6+Zh2ZBgB0zWPI+T2ewKvKtdURymF
 0ALG+UqqxQG2JEVAdKUM+Z5TEONlYyAe+PPEDvH7As1lgPtxvzqSqrx9UtwvP3q+9sIdXRNy0
 Vz1qwx9ioVJjaOgbvfcPldVyVBjIYHr9FAi8VYWyZr2/HMg1fQOdPr3rQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/10 =E4=B8=8B=E5=8D=882:44, Konstantin Svist wrote:
> It's a Micron MTFDDAK512MBF, firmware M603

CC Zygo to see if he also hits such hardware.

>
> I don't know how to do that (corrupt the extent tree)

There is the more detailed version:
https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299a@g=
mx.com/

Or if you can re-compile btrfs kernel module, this patch would allow
your to mount with rescue=3Dall, without destroying the existing extent
tree root:
https://patchwork.kernel.org/project/linux-btrfs/patch/20210719054304.1815=
09-1-wqu@suse.com/


> Is there any other way to pull files off of the drive?

Either btrfs-restore or above rescue=3Dall mount option.

Since btrfs-restore doesn't give you the recent files, I guess the
rescue=3Dall method is the only alternative.

Thanks,
Qu

>
>
> On Mon, Aug 9, 2021, 22:24 Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     On 2021/8/10 =E4=B8=8B=E5=8D=8812:41, Konstantin Svist wrote:
>      > Not sure exactly when it stopped working, possibly had a power
>     outage..
>      > I was able to pull most of a snapshot with btrfs restore -s --
>     but it's
>      > months old and I want the more recent files from.
>      >
>      >
>      > Testing the SSD for bad sectors, but nothing so far
>      >
>      >
>      > While trying to mount:
>      > [442587.465598] BTRFS info (device sdb3): allowing degraded mount=
s
>      > [442587.465602] BTRFS info (device sdb3): disk space caching is
>     enabled
>      > [442587.465603] BTRFS info (device sdb3): has skinny extents
>      > [442587.522301] BTRFS error (device sdb3): bad tree block start, =
want
>      > 952483840 have 0
>      > [442587.522867] BTRFS error (device sdb3): bad tree block start, =
want
>      > 952483840 have 0
>
>     Some metadata is completely lost.
>
>     Mind to share the hardware model? Maybe it's some known bad hardware=
.
>
>     Just a small note, all filesystems (including btrfs) should survive =
a
>     power loss, as long as the disk is following the FLUSH/FUA requireme=
nt
>     properly.
>
>      > [442587.522876] BTRFS error (device sdb3): failed to read block
>     groups: -5
>      > [442587.523520] BTRFS error (device sdb3): open_ctree failed
>      > [442782.661849] BTRFS error (device sdb3): unrecognized mount opt=
ion
>      > 'rootflags=3Drecovery'
>      > [442782.661926] BTRFS error (device sdb3): open_ctree failed
>
>     Since the fs is already corrupted, you can try to corrupt extent tre=
e
>     root completely, then "rescue=3Dall" mount option should allow you t=
o
>     mount the fs RO, and grab as much data as you can.
>
>     But I doubt if it's any better than btrfs-restore.
>
>     Thanks,
>     Qu
>      >
>      > # btrfs-find-root /dev/sdb3
>      > ERROR: failed to read block groups: Input/output error
>      > Superblock thinks the generation is 166932
>      > Superblock thinks the level is 1
>      > Found tree root at 787070976 gen 166932 level 1
>      > Well block 786399232(gen: 166931 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 781172736(gen: 166930 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 778108928(gen: 166929 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 100696064(gen: 166928 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 99565568(gen: 166927 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 97599488(gen: 166926 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 91701248(gen: 166925 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 89620480(gen: 166924 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 86818816(gen: 166923 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 84197376(gen: 166922 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 76398592(gen: 166921 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 72400896(gen: 166920 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 63275008(gen: 166919 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 60080128(gen: 166918 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 58032128(gen: 166917 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 55689216(gen: 166916 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 52264960(gen: 166915 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 49758208(gen: 166914 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 48300032(gen: 166913 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 45350912(gen: 166912 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 40337408(gen: 166911 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 71172096(gen: 166846 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 61210624(gen: 166843 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 55492608(gen: 166840 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 36044800(gen: 166829 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 34095104(gen: 166828 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 33046528(gen: 166827 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 31014912(gen: 166826 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 30556160(gen: 166825 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 777011200(gen: 166822 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 766672896(gen: 166821 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 690274304(gen: 166820 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 175046656(gen: 166819 level: 1) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 766017536(gen: 166813 level: 0) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 765739008(gen: 166813 level: 0) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > Well block 32604160(gen: 152478 level: 0) seems good, but
>      > generation/level doesn't match, want gen: 166932 level: 1
>      > # btrfs check /dev/sdb3
>      > Opening filesystem to check...
>      > checksum verify failed on 952483840 wanted 0x00000000 found
>     0xb6bde3e4
>      > checksum verify failed on 952483840 wanted 0x00000000 found
>     0xb6bde3e4
>      > checksum verify failed on 952483840 wanted 0x00000000 found
>     0xb6bde3e4
>      > bad tree block 952483840, bytenr mismatch, want=3D952483840, have=
=3D0
>      > ERROR: failed to read block groups: Input/output error
>      > ERROR: cannot open file system
>      >
>      >
>      > # uname -a
>      > Linux fry 5.13.6-200.fc34.x86_64 #1 SMP Wed Jul 28 15:31:21 UTC 2=
021
>      > x86_64 x86_64 x86_64 GNU/Linux
>      > # btrfs --version
>      > btrfs-progs v5.13.1
>      > # btrfs fi show /dev/sdb3
>      > Label: none=C2=A0 uuid: 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
>      >=C2=A0 =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 171.92GiB
>      >=C2=A0 =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 472.10GiB=
 used 214.02GiB path /dev/sdb3
>      >
>      >
>
