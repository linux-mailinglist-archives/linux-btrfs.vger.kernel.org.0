Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186913D46F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 11:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhGXJHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 05:07:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:49809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhGXJHT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 05:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627120070;
        bh=c8vO5nQehslGRbmJrWPvXvhc90q4unMVow960wVgc98=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dEyO62WQB/xWD7O9TCZC0WyIXnjIlx07hBiq+CgdtTE9/y+mHZYxXyD9+6LS5ry7p
         Itpx9mRo80HnziszTJPj/y3vTpLJP8X7/Gup78RBok21Rh5LqiVQpeXcSjvUEOZ7jT
         Qo1TpX1xrskrd0VyEU+w2WpsjpEL789qtBVgRo7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1m7EG13eYy-0001lR; Sat, 24
 Jul 2021 11:47:50 +0200
Subject: Re: Help Dealing with BTRFS errors on a root partition in NVMe M2
 PCIe
To:     Fernando Peral <fperal@iesmariamoliner.com>,
        linux-btrfs@vger.kernel.org
References: <26346381-4981-0e95-9cf6-4bbfc6e9bf18@iesmariamoliner.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <28d51753-d8ec-63c0-d4ac-a8fc7629ca6f@gmx.com>
Date:   Sat, 24 Jul 2021 17:47:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <26346381-4981-0e95-9cf6-4bbfc6e9bf18@iesmariamoliner.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n1q7wb0vDmz+aa4LXUFRcMhHHIv4mK7kb+ltLuDAFd7+hM5Csps
 DEC427ombL9p1Ls/bktdeFkyj3GhI5x6FUdoqEySK14Wf/ygKIzOgxXuI1AzfrcN1AGuaNc
 iKre2ZFiGu1a7JJK5jUk1TvRmNr1x4LRmidG6Xlo8j/nh8WL+ixOqbkLsFaCgw8oo4nKO49
 a9YCCZEC7goK/8aiA/fWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:am1tV51y8tY=:BGRUenOpgAxl5v493DddU6
 n9/jHJUu/ilfoWxXPYUiKEpf7Hizr+wmMrP0XcNCd+ynG4VDGcdRrt5CwoOkLzqdzisYzbgie
 cdmn0tUqvXy3D2H/uCM5BBcLC46B6Vk6G2kzJlc3HwqiX52ijYpoqTGN4RQQKcHrH/RciF+Im
 yNyp/VNrbEZaxxnGpQxs+cpu19hk9OqPt0NvPcZaOkMHIn3tJYpEatIxNVyESVmOgE02I4NFT
 n8GWdKyah0z/2H6gebJyigfVShWjd5cONMgS69wm3/mvfNF/WsnDSyE+W1BNsSmrziybhtGHa
 I9nMz9Nmm4r+rrXXXrjnWmsGkCCmZo4Knt4XucQvB3VOpfqQsQemVYqvIxLpOuVfl5IDwVDHZ
 icFLK0AZ2msjXYU+iuryjbt+hn5HsfgW7gKR7wHpgGvedS+WQ5XwRhrQUMJruzhw3BXBsyUE1
 jq0k+9P6Zvj0u8BHrXH09ub5UzuBZ5ZaFACtpOhJMuXfcmM66xz/DNkgh2U3O575W68gxPD24
 xrQbB+iUz1FanWIdy3R2ETjeqFOHmTEHBiMnewhB3t7cJY88lYlW6Voou3r6+v/Tv3AildI+N
 8oajbDsBrA0J9fZpbgkus9saiEaRKHUL8VchqikApDPjmgeefIj7Ja93nf7UkGhAlEirWk+gW
 PF3r8zAnOKXZWD19BRCG9Ltm9NVc+1fw1d1LDwzpIhYtZfdkEosTjgRea8QUvclkz+n+9lKUx
 EyD85RWW4awd+dpGAYUmzXCMbppF8IzHlAQ/qEpnPh5zwhTAETfybTvh6kWT5Z3dG0J2XCXlk
 lSOlNFQMJV5P9vzZmTqLItf9Fz25bpqt1peYsZd6FiGK8xDFCBhTCXv5Yyw6yRNXaBj1+vAkB
 QzthXKSzWCcAvHdPsWbY9DPEnAsTeU1xKan0DB0fiSYT5kAxCpqtULYocGB+bjq/HHH4CS4G4
 ii9/I5R+gCuh2g1vupt9f1okvoVNHXoRTJuD7QctUAoTg88jSP6F+ZpKGzn9vh7B+1uaRtnZV
 UgDPngnW/9yhhoEpKo606HqDPqG5I70a1PabQgz0B1S9tWholp7rlkZPry0AR5cKRMIY2fyhU
 n9RDXGvxhVAfySPfCrM4BJX8awiRJOKPh9mP0k1dGHU0ans0gAFq6zgKw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/24 =E4=B8=8B=E5=8D=885:25, Fernando Peral wrote:
> Hi.
>
> I'm having an error on the root partition of a opensuse leap 15.3 system=
.
>
> I have been asking for help in the opensuse forums
>
> The problem seems to have been caused by a faulty ram module wich has
> been already replaced, but the error of the fs is still there.
>
> It has been suggested that it has been a bitflip and to ask here if a
> btrfs check and repair should be done. >
>
>
> #btrfs
> check --readonly --force /dev/nvme0n1p1
> [1/7] checking root items
> [2/7] checking extents
> data backref 227831808 root 263 owner 7983 offset 0 num_refs 0 not found
> in extent tree
> incorrect local backref count on 227831808 root 263 owner 7983 offset 0
> found 1 wanted 0 back 0x5559e0ab7020
> incorrect local backref count on 227831808 root 263 owner
> 140737488363311offset 0 found 0 wanted 1 back 0x5559dde718d0

The owner number 140737488363311 (0x800000001f2f) really looks like a
bitflip in the high bit.

Thus the faulty memory theory looks pretty solid.

So far just two bad EXTENT_ITEM, I think btrfs check --repair is able to
fix it.

But before calling "btrfs check --repair", please backup all your
important data, as there is still a low chance that "btrfs check
=2D-repair" may make things worse.

Thanks,
Qu

> backref disk bytenr does not match extent record, bytenr=3D227831808, re=
f
> bytenr=3D0
> backpointer mismatch on [227831808 4096]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7]checking free space cache
> [4/7]checking fs roots
> [5/7]checking only csums items (without verifying data)
> [6/7]checking root refs
> [7/7]checking quota groups
> Qgroup are marked as inconsistent.
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p1
> UUID: 5b000355-3a1a-49f5-8005-f10668008aa7
> Rescan hasn't been initialized, a difference in qgroup accounting is
> expected
> found 51878920192 bytes used, error(s) found
> total csum bytes: 48135312
> total tree bytes: 991313920
> total fs tree bytes: 885358592
> total extent tree bytes: 48414720
> btree space waste bytes: 151592274
> file data blocks allocated: 239972728832
> referenced 85539778560
>
>
> pruebas:~# uname -a
> Linux pruebas 5.3.18-59.13-default #1 SMP Tue Jul 6
> 07:33:56 UTC 2021 (23ab94f) x86_64 x86_64 x86_64 GNU/Linux
>
>
> pruebas:~#btrfs --version
> btrfs-progs v4.19.1 =C3=82 =C3=83=C2=A7
>
> pruebas:~# btrfs fi show
> Label: none=C2=A0 uuid: 5b000355-3a1a-49f5-8005-f10668008aa7
> Totaldevices 1 FS bytes used 48.42GiB
> devid=C2=A0 1 size 931.51GiB used 51.05GiB path /dev/nvme0n1p1
>
>
> pruebas:~#btrfs fi df /
> Data, single: total=3D49.01GiB, used=3D47.48GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D2.01GiB, used=3D962.69MiB
> GlobalReserve, single: total=3D101.06MiB, used=3D0.00B
>
>
