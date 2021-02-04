Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF230E911
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 02:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhBDA5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 19:57:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:49095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233789AbhBDA5h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 19:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612400163;
        bh=1T00oOsXexoB4lOo5EmR5AtjqJK+Gt5HQ660iudJ34A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NWiAkHH9yGw9yI+CwK2z1U+5RSnMjYoEReoEuUJ7Z0OuHCj0SkbIQ8SkMZmTBqhah
         BHp/19qRWMsCHAsCclH6/CeLyTvxb5z4ivABziw6kVLeVPIKCOCykj3Eb98JxoKWlP
         LzTHTV+qfN2akZ+OXoDZRVHJzWwuS+uZkRuFxciM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1lAGku3xIE-00H8dy; Thu, 04
 Feb 2021 01:56:03 +0100
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on boot.
To:     joshua@mailmag.net, linux-btrfs@vger.kernel.org
References: <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <45064ba0-08e5-f311-1f9e-9a4ec62abaab@gmx.com>
Date:   Thu, 4 Feb 2021 08:56:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4VojlR/F9E70TAbrfLpYBjStfKg3Icer7+ZWEvkU6GwNWcu3aS
 /aOAAIQJD9q5xSSJusXb+/lfi6eK3kcA2SCV0Bbm+VNBsUgUYc9NQZdlTT5aK+hhn0jcf2+
 RsyJc0RnqwCmBUpZabaGYIf2ES6dANCVQM8fXHyf07o3VQhQsdtJTNVgtN1jyOjDdcZNM2r
 Toag80qx5JsnfNhV24n5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ouipcHigSMw=:56wpAjU7RIlXHVX6zgPuId
 kfJEmyDUHQG0VlKgqqow7Z1MbsaiSigEXaziGLGDYxi5FDCVf4a98rDVaOV+yfMV7KjTkjn74
 bX5gBE63V7bDqBw3Cr6/OAoUX+DJetfl9Gb56PyB/d6iSLMK9bUI2uEC9zBF38kngZ0YvvJqK
 sZso9bhKVXq38ofwWHJ1wj1tkER8IY4a0tsgmNAjoGsdI5Wn7unjR3dgpEmgsKpoixlT5e3C6
 8ofbMoKpCpc4bud+maqpzRJMb0cmUZQ8NR0XbB0LO8ZdJTd7srQ0In3zQ4MZjo2Yq5U+DTWuJ
 tfQar+OxsTd73jdEh4QZsqgc9lR0gLWqz0wIGJ1BTXeCMcyHEbYZS34K67g06PVFNL5uCPAP1
 XT0lyo/mSdnOQiKbXAhqNehxd6FQAagbz89kvZW5Y/zYByD1qGtLblEAVkq7kpR+Tkiu1wFLq
 KqMNrg/z+qNCePYBWro0Y30OHK3O3EXD7iqiuks/i1iieWZ33yt0GCj4k/sBjeMo6xB2fMhTx
 NFLLLZY5BeHqK+BvX/3o58ENWKkcdcuERcF1YdGYZnDaxVcCfbS/v4IWd6XuRmYLA6EFsEc44
 YYbM2lq4aIEX7R6aUy325m3CI2IndK7bDZA3fQfQDOheIj1RZY6D1/DLkNTIXljmAyBbjrj8c
 kFwLg09hqvm8u4IvhJYeg+P+zalYjZAoeHPPm2VVNv7OZPblcYR02VPXMdUnA3HBVQm2b+Nft
 qMHW6QX1BLz8QBEPevYQAo4A2H4i49+GuCbhyQrQfpdLRtcNrMl4KKPu06AEFqtoYanQFN7I6
 uyQVIK7THw6c9uTLKvgRE90tOwb2v7I91guThlSFuZpEvA9nmu/HKudaJhvTanrMifTAgbsE7
 feh2m3szt/7lGtuzGLIQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/4 =E4=B8=8A=E5=8D=885:54, joshua@mailmag.net wrote:
> Good Evening.
>
> I have a large BTRFS array, (14 Drives, ~100 TB RAW) which has been havi=
ng problems mounting on boot without timing out. This causes the system to=
 drop to emergency mode. I am then able to mount the array in emergency mo=
de and all data appears fine, but upon reboot it fails again.
>
> I actually first had this problem around a year ago, and initially put c=
onsiderable effort into extending the timeout in systemd, as I believed th=
at to be the problem. However, all the methods I attempted did not work pr=
operly or caused the system to continue booting before the array was mount=
ed, causing all sorts of issues. Eventually, I was able to almost complete=
ly resolve it by defragmenting the extent tree and subvolume tree for each=
 subvolume. (btrfs fi defrag /mountpoint/subvolume/) This seemed to reduce=
 the time required to mount, and made it mount on boot the majority of the=
 time.
>
> Recently I expanded the array yet again by adding another drive, (and so=
me more data) and now I am having the same issue again. I've posted the re=
levant entries from my dmesg, as well as some information on my array and =
system below. I ran a defrag as mentioned above on each subvolume, and was=
 able to get the system to boot successfully. Any ideas on a more reliable=
 and permanent solution this this? Thanks much!
>
> dmesg entries upon boot:
> [ 22.775439] BTRFS info (device sdh): use lzo compression, level 0
> [ 22.775441] BTRFS info (device sdh): using free space tree
> [ 22.775442] BTRFS info (device sdh): has skinny extents
> [ 124.250554] BTRFS error (device sdh): open_ctree failed
>
> dmesg entries after running 'mount -a' in emergency mode:
> [ 178.317339] BTRFS info (device sdh): force zstd compression, level 2
> [ 178.317342] BTRFS info (device sdh): using free space tree
> [ 178.317343] BTRFS info (device sdh): has skinny extents
>
> uname -a:
> Linux HOSTNAME 5.10.0-2-amd64 #1 SMP Debian 5.10.9-1 (2021-01-20) x86-64=
 GNU/Linux
>
> btrfs --version:
> btrfs-progs v5.10
>
> btrfs fi show /mountpoint:
> Label: 'DATA' uuid: {snip}
> Total devices 14 FS bytes used 41.94TiB
> devid 1 size 2.73TiB used 2.46TiB path /dev/sdh
> devid 2 size 7.28TiB used 6.87TiB path /dev/sdm
> devid 3 size 2.73TiB used 2.46TiB path /dev/sdk
> devid 4 size 9.10TiB used 8.57TiB path /dev/sdj
> devid 5 size 9.10TiB used 8.57TiB path /dev/sde
> devid 6 size 9.10TiB used 8.57TiB path /dev/sdn
> devid 7 size 7.28TiB used 4.65TiB path /dev/sdc
> devid 9 size 9.10TiB used 8.57TiB path /dev/sdf
> devid 10 size 2.73TiB used 2.21TiB path /dev/sdl
> devid 12 size 2.73TiB used 2.20TiB path /dev/sdg
> devid 13 size 9.10TiB used 8.57TiB path /dev/sdd
> devid 15 size 7.28TiB used 6.75TiB path /dev/sda
> devid 16 size 7.28TiB used 6.75TiB path /dev/sdi
> devid 17 size 7.28TiB used 6.75TiB path /dev/sdb

With such a large array, the extent tree is considerably large.

And that's causing the mount time problem, as at mount we need to load
each block group item into memory.
When extent tree goes large, the read is mostly random read which is
never a good thing for HDD.

I was pushing skinny block group tree for btrfs, which arrange block
group items into a very compact tree, just like chunk tree.

This should greatly improve the mount performance, but there are several
problems:
- The feature is not yet merged
- The feature needs to convert existing fs to the new tree
   For your fs, it may take quite some time

So unfortunately, no good short term solution yet.

THanks,
Qu
>
> btrfs fi usage /mountpoint:
> Overall:
> Device size: 92.78TiB
> Device allocated: 83.96TiB
> Device unallocated: 8.83TiB
> Device missing: 0.00B
> Used: 83.94TiB
> Free (estimated): 4.42TiB (min: 2.95TiB)
> Free (statfs, df): 3.31TiB
> Data ratio: 2.00
> Metadata ratio: 3.00
> Global reserve: 512.00MiB (used: 0.00B)
> Multiple profiles: no
>
> Data,RAID1: Size:41.88TiB, Used:41.877TiB (99.99%)
> {snip}
>
> Metadata,RAID1C3: Size:68GiB, Used:63.79GiB (93.81%)
> {snip}
>
> System,RAID1C3: Size:32MiB, Used:6.69MiB (20.90%)
> {snip}
>
> Unallocated:
> {snip}
>
