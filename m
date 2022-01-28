Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8A49F902
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbiA1MOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:14:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:60435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbiA1MOV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643372060;
        bh=J+FKeTPeQuVdrPIjvPrbSX2bzz3cdx4wIaDL6eYP5hE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=benP/S6hMI8bytK5nk6LuZ7QEZTsDV157HNRzsUSAI26E6HlK7Rqsc6VEwV+k+42V
         jsJVK57KD0Wz1GJySLeShTbCf0YnzWUU2H/ak5s7kQ7r15KppLzarUpAn27vL8zRq9
         KAHSCW0bcsks88/qe1xR9UrdNzOsPl3HTpCMTn5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.232] ([86.8.113.40]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1mKjif34G6-00zGQD; Fri, 28
 Jan 2022 13:14:19 +0100
Message-ID: <cf0cd0df-7391-adf5-abbc-42dfd1f07129@gmx.com>
Date:   Fri, 28 Jan 2022 12:14:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Content-Language: en-GB
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
From:   piorunz <piorunz@gmx.com>
In-Reply-To: <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5JuVotHJ2N4qqMUaASmz/d+/Tn8x31u7Yf1vUUDVFuSpxnFe3jY
 c0wjxoh+IcRBH9Hw0BDGAk7UGChHeGHwW2nfaik3XFkm5DUv3YA4wwy6wFqTdPu7upWAoqd
 c0X7vTanLyWYUp8bgYn9/g//FRVB49UpmkJfqYtqeKWMoFt3hNxVcle91JAWiWciZl/XL0Z
 T3pV7SWzYwQUHmtd1FTGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQ9Qp8cj1J8=:Er8ESvOgAijtRvUveDrQeW
 NmdiotAywwKknSmQ6ascF8QhV6GRpk82+ABLTo1oQAba3bS31zkkbZTrgT1uMBaef4SBJ49aV
 ZXZkLQnzOGGzfOw22WxqQFhniLAIp9ynmGzkdeZ4vmvMx++G3Kn3dudTlPG+DaHzP+unbFOkF
 B1387D/vfZ0RYlIW7hIATqn1giZYTRabReAUG/RG7qL/+e2LTZD7EiHPpQv8G+hE5/JMTvFcH
 aaeP19UwS2F0q8Pi3d/atjIKX8qPU+zzqdU8Z0sJ2711fUIZiRvRolOLRU9hz6W2R4j9T9g9/
 gzMDL9/zg8mubsNgLkJILygHmgHBl4iE1CjL9WoCT6Jl7kgujRMPx00PZ7BA/a39Yp/GaGuoi
 nfzgCQEdSzr/WFnlwsjMC05rx1HVIUeLvPo0/k0EeK8L23YnzRMZq0mlxt+ge50y64+P29qvv
 eg7BDZcGxSApCpEUDIjmq6ZdmNX8XiTvtpanR8Gtc13ddPX4H7kgPB5ldTmEfSXdCD0WEtgcI
 npUeQ4ap/msI+0/pjVr5rzU+SpQ9vlo+ouVyjlstNeaB35/csnpr26gVEse2RyxecWGKnrySF
 J0l78qftEoSz9rQlZw999KAWjG77vM1BXrUHDrkIo/HmT7Abj56C8MTbTW7/dzvvcsj+fMOMm
 /SzA0aB4nHMFRj5lXg0UQXwzENonX7e3AhG+3xhFt4vXajBRXOMUhekec6HfD1u6KRYtnvT/N
 wuuYpG82cv+OaLio5PgrEb8MMv5unfndRNg0Jz1hQx06wqlGnWnJ11xQmK2d3P5H9ErDzWaMt
 72noaboqobfKzk8EzYYfhR/85aDkEBm+1vAXPM8Cr31gWJbqR/9R2TWQivcetjKd3byjStf0F
 YrO6TDO6dpPHgRcS2ep4+2KdmNIU9NZ0xX108moMaBbG6wASU0G2JYSq5/my7ZuCRuoiChK/C
 idFSHc7jNanrpJycCOWjxlRclF2iz3QbriHlKxy1j4HDQC0z1OHok3H+LQTQZoMKtcViGth7S
 g60nMaq9ChgTvVO1CJ+h9teViN4W4g+ZWV78tmHru8VQvt81jChoQ+fjPJCJcMDM0ckMbV1kR
 Fy7E/86ZCAr+xY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Chris, Qu, Kai, thanks for all your replies. :)

As I mentioned, I never considered defragmenting before, so I am not
experienced in this matter, but now I decided to tackle this problem a
bit more seriously.
So yes, I run /home RAID10 on 4 HDDs and I don't want to change it at
this time. It's running quite fine. I'd love to run RAID 5 or 6 but I
know this functionality is not ready.
HDDs are 2TB each in my server, and 500GB each in desktop.

So, I see that solution I found while searching internet (defrag with
-t4G) is not suitable for compressed Btrfs.
Also, autodefrag will not work in my case. I use 5.10 and 5.15 kernels.

So, I should manually run:
sudo btrfs filesystem defrag -v -t128K -r /home
That will be more suitable, right?

I know performance can be improved for databases or VMs I run (6x
Windows running 24/7), but I don't want to complicate systems more than
they already are, so I will skip manual attr changes at this point, let
me try one thing at a time. :)

If manual defragging with -t128K is correct, I can run that regularly,
please let me know if that would be your consensus guys. Thank you.

On 28/01/2022 11:55, Kai Krakow wrote:
> Hi!
>
> Am Fr., 28. Jan. 2022 um 08:51 Uhr schrieb piorunz <piorunz@gmx.com>:
>
>> Is it safe & recommended to run autodefrag mount option in fstab?
>
> I've tried autodefrag a few times, and usually it caused btrfs to
> explode under some loads (usually databases and VMs), ending in
> invalid tree states, and after reboot the FS was unmountable. This may
> have changed meanwhile (last time I tried was in the 5.10 series).
> YMMV. Run and test your backups.
>
>
>> I am considering two machines here, normal desktop which has Btrfs as
>> /home, and server with VM and other databases also btrfs /home. Both
>> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
>> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
>> Testing (kernel 5.15) on desktop.
>
> Database and VM workloads are not well suited for btrfs-cow. I'd
> consider using `chattr +C` on the directories storing such data, then
> backup the contents, purge the directory empty, and restore the
> contents, thus properly recreating the files in nocow mode. This
> allows the databases and VMs to write data in-place. You're losing
> transactional guarantees and checksums but at least for databases,
> this is probably better left to the database itself anyways. For VMs
> it depends, usually the embedded VM filesystem running in the images
> should detect errors properly. That said, qemu qcow2 works very well
> for me even with cow but I disabled compression (`chattr +m`) for the
> images directory ("+m" is supported by recent chattr versions).
>
>
>> Running manual defrag on server machine, like:
>> sudo btrfs filesystem defrag -v -t4G -r /home
>> takes ages and can cause 120 second timeout kernel error in dmesg due t=
o
>> service timeouts. I prefer to autodefrag gradually, overtime, mount
>> option seems to be good for that.
>
> This is probably the worst scenario you can create: forcing
> compression forces extents to be no bigger than 128k, which in turn
> increases IO overhead, and encourages fragmentation a lot. Since you
> are forcing compression, setting a target size of 4G probably does
> nothing, your extents will end up with 128k size.
>
> I also found that depending on your workload, RAID10 may not be
> beneficial at all because IO will always engage all spindles. In a
> multi-process environment, a non-striping mode may be better (e.g.
> RAID1). The high fragmentation would emphasize this bottleneck a lot.
>
>
>> My current fstab mounting:
>>
>> noatime,space_cache=3Dv2,compress-force=3Dzstd:3 0 2
>>
>> Will autodefrag break COW files? Like I copy paste a file and I save
>> space, but defrag with destroy this space saving?
>
> Yes, it will. You could run the bees daemon instead to recombine
> duplicate extents. It usually gives better space savings than forcing
> compression. Using forced compression is probably only useful for
> archive storage, or when every single byte counts.
>
>
>> Also, will autodefrag compress files automatically, as mount option
>> enforces (compress-force=3Dzstd:3)?
>
> It should, but I never tried. Compression is usually only skipped for
> very small extents (when it wouldn't save a block), or for inline
> extents. If you run without forced compression, a heuristic is used
> for whether compressing an extent.
>
>
> Regards,
> Kai


=2D-
With kindest regards, Piotr.

=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Debian - T=
he universal operating system
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 https://ww=
w.debian.org/
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
