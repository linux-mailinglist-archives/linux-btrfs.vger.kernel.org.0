Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120AE4301B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhJPKKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 06:10:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:38057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235573AbhJPKKy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 06:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634378919;
        bh=KpJBrZKPZrnUp2N2nrvdXZY8hYkB4BsmC1bMtRk2OxY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=EKllPi0JoTJDMo9+yetdvalIjQXhORWFgozxC9wVjHGlW3CUESr2gInXpouNrOGxa
         Xw5fa5NPbvQJnAteQSLOiDah2uwH309lBcL2pjRIlK4C2AeD//7AGdAzFU8GfO7LO7
         u2w9Ko1H6MxlObHegk/r3TVLGt1QcbCmlySMcWd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1mXojA1x9a-00EsC3; Sat, 16
 Oct 2021 12:08:39 +0200
Message-ID: <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
Date:   Sat, 16 Oct 2021 18:08:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
 <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: need help in a broken 2TB BTRFS partition
In-Reply-To: <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G1rzXwKTV/73or1/bY2DZv5JAe7PDa6lgLKiJ6IijdWnP8MeUFR
 /XIMebhaNfrxjL/R3e78EUv/KpC1XrDSiiWZ43RYD10Zt6+DnVCa1ZhzbV6EYsceGl7JCDE
 SCFXeFheF873flHNDDTMaZp4WQih0ol1QuQWD6dRQeeqc1rzX5Bfxd192hL1y3MCXqpRZ4o
 R7trSnMYDm+WrHidv4O9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYVvBcsLPGo=:BeeY7xmh3a2hRAE7pvFlCt
 zKc4SFRytT+Z7mmem+td5ANty/ItkdFFCIFjrOhdv7JeyoQPo8HvJ4qqU6s2cL9GrTARwIib/
 QdsnAXAlLXD1P6W7vGb4xU/R6xNTSzbn8q3DWNhNgNjUI9dph47o1xn9pSh+ygYIQh2WXehXZ
 L5auBAghRplCYZTfQPhWwziJVLDpgaRhZeqvdDFdRPaQbsfJFLD9IdrsOgUaplPpHIn4LTTuN
 4E2kxt7eZryRYyut5hxk8XEqsUdkKSXYnyIfwO+WuseUOgDcK5WoY8yMIjTrDmt0Zw5EW3mpP
 n6gUDCZNfumY147gkzf4VrkMEb8LXv6f6D1Ppd3kXN9FgrW0X+2GUUoDDG7SLU5oPFdjQ04OI
 fsmsvyh/4/Dvin1A4JKZblGYJ214L49a2xE6Vb72bXH742Gz+/YGCXergKw655JR8yJmaj2En
 IrEPnKL+Ub0WxV42KghKw5NVKmvW3jMKbaxp23anc5f57CvtsjEPdibei3dP88Xnn9iE6bCsl
 KkUF3jxg20BaXPMBMZ98/hrPQHW3ZPsnsS7DP+ZLjdpPB0HtDgYS0Ag5xYKOSuN5vn8Hc3t+8
 suep8nXv+VYHMNgYfRxDYwdcwOCCmKpUOZ63g5HtjqAj3f7mQM/uhrU4p5oiz8BYK6nTb0aGp
 ZZIYRXJrQJtuaSEEeXP1ZDIJnTSr018dYlA9sGBqSOV2tlBGh/WANq+8w5FLLyAIw7BXBpVaY
 f2k46egCabcXPgVkCdujFkoaJ0c8q50n0zc14e1OPPDJLu5pLdx4T4cNzPxCjg5qgjs0sdGYH
 +xdgx+3OOfJN8xsG9i6ASJxqBEoIVMAuoqYQcnvsRQ0Z76Rs+GAGU9u1XL2ieXGjJn8gvEjWl
 pzYcqxr6vBlHX/PEUd0yVDqiOIYsDgl0CpPX8+rTIn83uypHV3joZi8FEx92LgoI0S05czH6G
 ibhKjpUY16QO7lzaqbj8Ew5yqVwZgYa2b0AtXaSH0zYbIM3/KIeawGkLhoU5AjvOFQPFDXK6i
 O0xDgsoK8uqGzRJeM8YdpIMacDtiA+DjIicpZ9+1dsDWNj+aqMgYdUvUbNfqCSuWKb17kmzeG
 M6nNfrELilMTdw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/16 05:01, Christian Wimmer wrote:
> Hi Qu,
>
> I hope I find you well.
>
> Almost two years that my system runs without any failure.
> Since this is very boring I tried make my life somehow harder and tested=
 again the snapshot feature of my Parallels Desktop installation yesterday=
:-)
> When I erased the old snapshots I could feel (and actually hear) already=
 that the system is writing too much to the partitions.
> What I want to say is that it took too long (for any reason) to erase th=
e old snapshots and to shut the system down.

The slow down seems to be caused by qgroup.

We already have an idea how to solve the problem and have some patches
for that.

Although it would add a new sysfs interface and may need user space
tools support.

>
> Well, after booting I saw that one of the discs is not coming back and I=
 got the following error message:
>
> Suse_Tumbleweed:/home/proc # btrfs check /dev/sdd1
> Opening filesystem to check...
> parent transid verify failed on 324239360 wanted 208553 found 184371
> parent transid verify failed on 324239360 wanted 208553 found 184371
> parent transid verify failed on 324239360 wanted 208553 found 184371

This is the typical transid mismatch, caused by missing writes.

Normally if it's a physical machine, the first thing we suspect would be
the disk.

But since you're using an VM in MacOS, it has a whole storage stack to
go through.

And any of the stack is not handling flush/fua correctly, then it can
definitely go wrong like this.


> Ignoring transid failure
> leaf parent key incorrect 324239360
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>
>
> Could you help me to debug and repair this please?

Repair is not really possible.

>
> I already run the command btrfs restore /dev/sdd1 . and could restore 90=
% of the data but not the important last 10%.

Using newer kernel like v5.14, you can using "-o ro,rescue=3Dall" mount
option, which would act mostly like btrfs-restore, and you may have a
chance to recover the lost 10%.

>
> My system is:
>
> Suse Tumbleweed inside Parallels Desktop on a Mac Mini
>
> Mac Min: Big Sur
> Parallels Desktop: 17.1.0
> Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 03:36:02 =
UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux
>
> Suse_Tumbleweed:~ # btrfs --version
> btrfs-progs v5.13
>
> The disk /dev/sdd1 is one of several 2TB partitions that reside on a NAS=
 attached to the Mac Mini like

/dev/sdd1 is directly mapped into the VM or something else?

Or a file in remote filesystem (like NFS) then mapped into the VM?

Thanks,
Qu

>
> Disk /dev/sde: 2 TiB, 2197949513728 bytes, 4292870144 sectors
> Disk model: Linux_raid5_2tb_
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: gpt
> Disk identifier: 942781EC-8969-408B-BE8D-67F6A8AD6355
>
> Device     Start        End    Sectors Size Type
> /dev/sde1   2048 4292868095 4292866048   2T Linux filesystem
>
>
> What would be the next steps to repair this disk?
>
> Thank you all in advance for your help,
>
> Chris
>
