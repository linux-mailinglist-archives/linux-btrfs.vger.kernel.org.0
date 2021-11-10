Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0803844CDFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 00:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhKJXtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 18:49:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:46203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhKJXtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 18:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636587983;
        bh=YHkLLv9/aJuHuJjMyfMXYv7WwynLh6ka35TPrk5cCAo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=dY6vdchKONRlkTvnMmfzY7RdMoY6mPL0GWnQpl/KigQtHumxZfVaBPL4jKwEokQ54
         arTBj9qNzNrMJ2c4s4LKg5uLyGhM1eg9rFvfWH0i27Xtqg8FIncZjtuJ8iw4Ag3Rlt
         QQrLv0C+2vp9i2aVmK0wdh2WB7X9X2TehEhO/5SU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1nF9s82R0Q-00WS2x; Thu, 11
 Nov 2021 00:46:23 +0100
Message-ID: <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
Date:   Thu, 11 Nov 2021 07:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZkHO3upzmKucjut5YU/IUPlB1TsKDvYWBEBx6FCsCu6JuExOMh
 Ngue9zO0TzFSw83E64o/V4w5yUcSR76tMTXK/y2vwbKfqouMoypkmvoj9uG96mtXnDh2f55
 nF+YU+OeQPZZMVg41RgkMobz2gUCZER5N/naxT7/5RjktZ4QLX43jJbPYdCip3WzA0t3Fth
 bVUO5XUR4itYQN7nKpuUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPRlZLHzLzw=:2jXmiIMsQzHU7gKh0DrXNc
 kt8qV5uAup7AM7rlP5tMaJAE+l6g8R+hlDs/vDcz2FCzfI+/GWzQZKBbUpKNyicxmhyDb8x4A
 lcQEBZy4jJ4HKunG6cilG80NXrcnGTwOcvGeGPAFOMtMkU7rHQNqxg5XHJuuVpMcaRDvlHFlF
 jWwPBZvcTfm5G34gRmplP6fT8L3YpVrfr4hoxnPE5YNhOKxQa2lYQ9wondsOysloYuOo2qlR6
 cfAOUazLP6q4SuO5zOJN/f1mdqbNF4SAycODQjxdRKXW/gJTklzC8QK+gXRzfJyXpxf7Tw7G9
 C19FIqpQT2nbpyAvmBYBQAv8rTbNHce2ATjluQGGaplTvcaY5koO1cNvkweenRI5HsWg+inwI
 ihpfWa9PG2VT6h17ZyD9oRmegSmYRDtks6mRDIultL59AR1ABdrlqPOAYXFdXCzDh9levrnyK
 VctVFwmiFvOBfl+R7njyO3FYSqAKi5fkp+xufNbUaRh5lK2MVfl6uIF9oQDI8psAgLtDk1IYA
 mUx7EZltNGM3VBQmebxC2/UKRyv0OhpAqbrzDROa98itqYaEU/Y5K9yl1+aVLGEmeiMBQRQ2f
 rLhho8C9N4L7dToofWXWffmTZDDVMkMyetRGg9czpaX9sNSdj+U0Z4wY+fjyDcf742lT+0fm6
 RTzZJbDIzi5sxe39HdWsA5U2koVkEA9FMaJxziX3MQ/GFQV+R/r5PM8jc8X5iyA9aF45fsYmF
 Xww8703o+sJw1PC0ienXleK13fSbYAp4bYX8KZmC+uDSPl7wKqqMKSJKxHmZO8Do/vNz6loBy
 W6aiq6/57VtYCH6jvMlzYgw2UO1wq6D0CIwyY93UglqCgqruuxkEFlppTfAW5jPXuwKTpZGm4
 qbnqZyRrHx+1e6jWaTpo3332RXi7LQpCvpFzEb416uMUm4/VSCmgCIzMyt77w7/iF7st7RGT8
 mlHhcdHkJxfOHEsCMu+kUzZoMy/MT4HwrKU+mXs0acLaEH/x5yqu2iV4PFT18uXI+r+/Aw6G4
 MGAkAnUDkQ3BqE1FBB6whpmWvc4A11Vtrffs7TooEwDi/FDaUOFL6/cpp0qilWqUITseWo7Wx
 JWbotc2+2CwI9g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 22:01, S. wrote:
>
> On 11/10/21 02:01, Qu Wenruo wrote:
>> If you can revert to older kernel/distro, then you can mount the fs wit=
h
>> "-o rescan_uuid" to regenerate the UUID tree using the old kernel.
>>
>> Then it would rebuild the UUID tree, no need for a tool in user space.
>
> Thanks very much for the explanation and for the suggestions.
> Fortunately the system saved a copy of the old 4.19 kernel and initrd
> image. You are correct that the old kernel can still boot the filesystem
> without errors. Then I unmounted it and remounted it with `-o
> rescan_uuid_tree`. This also appeared to work, as it was able to mount.
> However, after rebooting into the new Bullseye kernel the filesystem is
> still unmountable:
>
> ------------------------
> [=C2=A0 115.250774] BTRFS info (device sda3): flagging fs with big metad=
ata
> feature
> [=C2=A0 115.257773] BTRFS info (device sda3): disk space caching is enab=
led
> [=C2=A0 115.264089] BTRFS info (device sda3): has skinny extents
> [=C2=A0 115.414229] BTRFS critical (device sda3): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096r
> [=C2=A0 115.428780] BTRFS error (device sda3): block=3D170459136 read ti=
me tree
> block corruption detected
> [=C2=A0 115.459643] BTRFS critical (device sda3): corrupt leaf: root=3D9
> block=3D170459136 slot=3D0, invalid key objectid, have 11018354394740573=
44
> expect to be aligned to 4096
> [=C2=A0 115.474296] BTRFS error (device sda3): block=3D170459136 read ti=
me tree
> block corruption detected
> [=C2=A0 115.483109] BTRFS warning (device sda3): failed to read root
> (objectid=3D9): -5
> [=C2=A0 115.534748] BTRFS error (device sda3): open_ctree failed
> ------------------------

After a deeper look into the uuid rescan code, it doesn't delete those
corrupted keys, but only add back correct items.

So it means, we still need btrfs-progs to repair it.

Thus I believe you still need to prepare a build environment for it.

For the worst case, I could try to build a static btrfs-progs for you if
you could provide the "uname -a" output.

Thanks,
Qu
>
> Any more ideas? Thanks again.
