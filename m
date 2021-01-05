Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0467E2EA59D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 07:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAEGzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 01:55:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:50157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbhAEGy7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 01:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609829603;
        bh=iYZLMHDBr7+yU7dKKepNKnsyiFR6IvNYSfEy63bTrxM=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=ZVYB+A2g4wnSOMPYNng8tiS67GUgGjeO+cdcb45KhgsutCGTMu/JTDCuOb04cOd5p
         xWrzZQUUFf3OqseuxBviyoKRHWQgtRYAWgxo7eBeDWnXXH/GKJm4hnesn9HZ27hlW7
         hfEAhDDXMpiubeuDcd1CR8J4/uZ8id3IlqFsAT5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1k7S500iwH-00uaS1; Tue, 05
 Jan 2021 07:53:23 +0100
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize the
 SSD?
Message-ID: <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
Date:   Tue, 5 Jan 2021 14:53:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KA2G1Y5LLuIH3vRvk2/WTyqvfEaEyEBiRymbU+eqV2XCFcP+rt4
 0MFmWXZxfigzmWZkpMjabz3YDzz4g6iSBMgp7RqdTiNyhJbTWggkGCZzURYdYtdpMdB5hWX
 1ufXPXEliQbOygYA5iDhri/nuos9L+17wS6FsSQ7yA7BV0hGnsllAe3UvDifLtCk6SYzFtr
 IWEEuh1drA8OZShOIS8ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:txsADmuJp04=:sqkj5arV9KQo3mUILBj9r6
 jlVP9yIwR1KsIHh98BJhTctVuCYDG+I054r0UqAus/+8DuV3aGEn+JkLVQXoG06mpgi3eMwc7
 dKOZpx9IN5bglF0HIOeo3tqIrkcy+tltI/VpdhO7ZOJkWDbHeLW1Zvw8j6aFvI+tEXJOHHszS
 yPkuj5lN1+ussmLN31ZIz/4rkN1BkravyuRYwlS+S28eng8fhIsAPeUAJdkQDzaC9Tzi60lrd
 vupsWLRmdthC4HGN9q9xRQWEBYF+06KHJlXiWtqZUs8w9HL6ZGN/b57pukOMe4gbCt6Dsa78P
 hVIn6YIg2nOCnIgDnEPW0cL4qdrmxTaNZTAlGVYILht2I3mS6CIM/4zlkp0V21XOezk/NWxbQ
 FHYxPy2hxxrFJrmPugynW57qrbCXZXBy6a1PH2uNy/dcOfudEN+07W9/e4AhQ5SNJLoZgSPX2
 PARtk+KxNO5t1V0iJ5/7om5aQQpfFzhpARdBIxWGZq0UwamjmVyVI7BHjN1A8v5yUeNSfAK84
 iEDqmyXy0Wa3OI+wbH0CWCMxWgWBQAhvHygD79pdtTmHnBgAguOGKhQx2WZceeD23tViqebcv
 xH89rgprE2nNLRNBobOGhO65JkJ53Yry+O1k1FCodDotExMqFg6z2i/NcZfGxq4obcr9wUAVJ
 iyRak/H98/PElAk6YJTyuSJhzaU8kPSAVufNxQ4CnuDb0C+51NSfKhKVTZhkHgbEObN8pQsWn
 isPamIIGfaL4iai/qvn9IuvYNXlBTdW2Ixl9N6nMkuYTA5hkDMkcx7LTj/ADMY6se6GO6mDKx
 F/LHDdVruw1PcMXxW8ijMffuiRbnjJgwvEcJymOuq9WJMPyU4c2t0YKHKMY7VSRYL6bNKimvx
 BDezBsXMbUOS1AbKwgxQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/5 =E4=B8=8B=E5=8D=882:39, Cedric.dewijs@eclipso.eu wrote:
> =C2=ADI have put a SSD and a slow laptop HDD in btrfs raid. This was a b=
ad idea, my system does not feel responsive. When i load a program, dstat =
shows half of the program is loaded from the SSD, and the rest from the sl=
ow hard drive.

Btrfs uses pid to load balance read IIRC, thus it sucks in such workload.

>
> I was expecting btrfs to do almost all reads from the fast SSD, as both =
the data and the metadata is on that drive, so the slow hdd is only really=
 needed when there's a bitflip on the SSD, and the data has to be reconstr=
ucted.
IIRC there will be some read policy feature to do that, but not yet
merged, and even merged, you still need to manually specify the
priority, as there is no way for btrfs to know which driver is faster
(except the non-rotational bit, which is not reliable at all).

>
> Writing has to be done to both drives of course, but I don't expect slow=
downs from that, as the system RAM should cache that.

Write can still slow down the system even you have tons of memory.
Operations like fsync() or sync() will still wait for the writeback,
thus in your case, it will also be slowed by the HDD no matter what.

In fact, in real world desktop, most of the writes are from sometimes
unnecessary fsync().

To get rid of such slow down, you have to go dangerous by disabling
barrier, which is never a safe idea.

>
> Is there a way to tell btrfs to leave the slow hdd alone, and to priorit=
ize the SSD?

Not in upstream kernel for now.

Thus I guess you need something like bcache to do this.

Thanks,
Qu

>
> In detail:
>
> # mkfs.btrfs -f -d raid1 -m raid1 /dev/sda1 /dev/sdb1
>
> # btrfs filesystem show /
> Label: none  uuid: 485952f9-0cfc-499a-b5c2-xxxxxxxxx
> 	Total devices 2 FS bytes used 63.62GiB
> 	devid    2 size 223.57GiB used 65.03GiB path /dev/sda1
> 	devid    3 size 149.05GiB used 65.03GiB path /dev/sdb1
>
>
>   $ dstat -tdD sda,sdb --nocolor
> ----system---- --dsk/sda-- --dsk/sdb--
>       time     | read  writ: read  writ
> 05-01 08:19:39|   0     0 :   0     0
> 05-01 08:19:40|   0  4372k:   0  4096k
> 05-01 08:19:41|  61M 4404k:  16k 4680k
> 05-01 08:19:42|  52M    0 :6904k    0
> 05-01 08:19:43|4556k   76k:  31M   76k
> 05-01 08:19:44|2640k    0 :  38M    0
> 05-01 08:19:45|4064k    0 :  30M    0
> 05-01 08:19:46|1252k    0 :  30M    0
> 05-01 08:19:47|2572k    0 :  37M    0
> 05-01 08:19:48|5840k    0 :  27M    0
> 05-01 08:19:49|4480k  492k:  22M  492k
> 05-01 08:19:50|1284k    0 :  44M    0
> 05-01 08:19:51|1184k    0 :  33M    0
> 05-01 08:19:52|3592k    0 :  31M    0
> 05-01 08:19:53|  14M  156k:8268k  156k
> 05-01 08:19:54|  22M 1956k:   0  1956k
> 05-01 08:19:55|   0     0 :   0     0
> 05-01 08:19:56|7636k    0 :   0     0
> 05-01 08:19:57|  23M  116k:   0   116k
> 05-01 08:19:58|2296k  552k:   0   552k
> 05-01 08:19:59| 624k  132k:   0   132k
> 05-01 08:20:00|   0     0 :   0     0
> 05-01 08:20:01|6948k  188k:   0   188k
> 05-01 08:20:02|   0  1340k:4364k 1340k
> 05-01 08:20:03|   0     0 :   0     0
> 05-01 08:20:04|   0   484k:   0   484k
> 05-01 08:20:05|   0     0 :   0     0
> 05-01 08:20:06|   0     0 :   0     0
> 05-01 08:20:07|   0     0 :   0     0
> 05-01 08:20:08|   0    84k:   0    84k
> 05-01 08:20:09|   0   132k:   0   132k
> 05-01 08:20:10|   0     0 :   0     0
> 05-01 08:20:11|   0  7616k:  96k 7584k
> 05-01 08:20:12|   0  2264k:   0  2296k
> 05-01 08:20:13|   0     0 :   0     0
> 05-01 08:20:14|   0  1956k:   0  1956k
> 05-01 08:20:15|   0     0 :   0     0
> 05-01 08:20:16|   0     0 :   0     0
>
> # fdisk -l
> **This is the SSD**
> Disk /dev/sda: 223.57 GiB, 240057409536 bytes, 468862128 sectors
> Disk model: CT240BX200SSD1
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: dos
> Disk identifier: 0x12cfb9e1
>
> Device     Boot Start       End   Sectors   Size Id Type
> /dev/sda1        2048 468862127 468860080 223.6G 83 Linux
>
> **This is the hard drive**
> Disk /dev/sdb: 149.05 GiB, 160041885696 bytes, 312581808 sectors
> Disk model: Hitachi HTS54321
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x20000000
>
> Device     Boot Start       End   Sectors  Size Id Type
> /dev/sdb1        2048 312581807 312579760  149G 83 Linux
>
>
>
> ---
>
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: ht=
tps://www.eclipso.eu - Time to change!
>
>
