Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1035D3CB75B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 14:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhGPM34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 08:29:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:50903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhGPM3z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626438418;
        bh=jbNp/Jfju0O3Q9De6kttA/cetoOQE8Vg4oIerm5imJE=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=GdFqB/OkstPv34Rxm11qFFyt4/w78EeY6PyHu9asphezt+vFAJ+3sBK3/TLAS+H4M
         UkNbgXMexVLlJHf++Pr6GdA97uxvOolqA9EzSfE/sR/gQ32G4JYJ3nxLC5UC5j9jFE
         V/VzEIcj94GKN1+xzxRkn4FX+KTiyRp2zlOncWR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7Ka-1lyH4C0QNm-00BYD4; Fri, 16
 Jul 2021 14:26:58 +0200
To:     bw <bwakkie@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKqYf_KZ_fWN55adSCsf6VuaaYa3FSz4XVmE8gL7N45DDO+CBA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: cannot mount after freeze
Message-ID: <98b97dff-c165-92f6-9392-ebea55387814@gmx.com>
Date:   Fri, 16 Jul 2021 20:26:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKqYf_KZ_fWN55adSCsf6VuaaYa3FSz4XVmE8gL7N45DDO+CBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wF43AaQAZiP/yDCsPC8nkM7Qetlc48jQ5AZLzSpHfh99PZdXyv6
 f2YVRoVnL2LEq1+fV+UrG+8M0INNITQB6JetX75TRm4dk4VbSaj+irep0+uVye5GEr7pALc
 9Isp9PclxIFqiCNVgU7BEC8KZiQT3u1bv8GQjmhRfaFvwDjCbYi6T+CcgNzarbzR+o3O1Mp
 mn6dP5fUFr5X2iAMzr4ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJly8Q6Gxrc=:UG2KDZaOFaK+IvmnySGGd4
 8MwBTDi3FkZvunNsSUkjWCmih7QjjScdLSSairnsvSHNKrdmVrL6oM6LaxAbkEVCctJXXKr+r
 ZaWKwux9dD7/XPbs8V8BHRYo70T3AhHCCrFjkxuUr9p9kFH5qfO3bXejF/z17gCT4WAALE0P4
 0gID8i6EGnjUP0PrlgOOhv14uO3gTh6+VakWMB9ZHocb3w5DOa09H1TIwTWY8jo/sxCHhseua
 KYQKUob5CYJe/fuxqqb8ggydpeMOsRd+4f3OBRk04urBBzuLOL0GTUo+LOuZj1D2SigIrASZh
 XAiMnRCAWGu+aPjset/UaWdjrrVG/IQcTWS+ddCa+0qHz4vXSdpPmE0btjjqcLC8YA5rzzVak
 11oMn6W2Q+yYnwojaONrgCQRzgnmemXBhl+R6KRdbbbXEfc8TomTLCJ4rH9UnViTXpZHx+mEn
 e8NsdytDcjL+4EVYaOOVqn0GZKHgJCty3N3WJzZeRjZ5a5Ky3l5fL3uhjOtYKjv8jzmhHCmRu
 EY07nikspKo45tO7iVw8ah2ytzqlLTGvku4o0iAr4s3/jozon4h7HjGIt5Wqh4tXVxofsTGoy
 vbwFKGpZV6LtyTE67hyp20rmAtOsCQnNGm7FgxrZNuw2VoDezBr+3Wg5mqMStJiDnpKBIqKa7
 muSfV/ZRrBY73rCrR7xCX6S5Zis9LuOymnhmoRIwB3wnuTRNdj1QMcWmOlFudVQb2ELjuik9F
 k0rtXO9Og7M6O8J6Qk0GWH7+SutU1K+GAy5KCDRDGw9bsLpcO7QqoVtgWdFWcqwBYGSW/ZbuB
 aACLked0cABycEv5LfrkHRUqy8d71vK46E8FcPcRPoEnmMeBTCfhtAUCBE9iSm5XZQtXwrM3h
 UNTld/gXH6EV5DaRcgu40sz6Nycm6h3oTDagLbv1ES42lXZvY6Wc9UKEylePf7NU1bFIDoE3O
 KnLxt7mvzUhjFsyb+U63cLZ53GkHvF4Vt9jiWlT3fn2TOpjfSmi2MkQayPzTBU/vEUDOfIieQ
 5yb8B+LFXQp0cVkp/lj/UN605Nq9op6eu6gmjO51ON2shnZ0D4KfAIf3m9YMmnOH6KRmpNE9A
 zSaOATXOGzULIpTesofV5GJHuSUpHK+Yu48yIf+gVx2ylWv3zXavDmrSw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8B=E5=8D=887:12, bw wrote:
> Hello,
>
> My raid1 with 3 hdd's that contain /home and /data cannot be mounted
> after a freeze/restart on the 14 of juli
>
> My root / (ubuntu 20.10) is on a raid with 2 ssd's so I can boot but I
> always end up in rescue mode atm. When disabling the two mounts (/data
> and /home) in fstab i can log in as root. (had to first change the
> root password via a rescue usb in order to log in)

/dev/sde has corrupted chunk root, which is pretty rare.

[    8.175417] BTRFS error (device sde): parent transid verify failed on
5028524228608 wanted 1427600 found 1429491
[    8.175729] BTRFS error (device sde): bad tree block start, want
5028524228608 have 0
[    8.175771] BTRFS error (device sde): failed to read chunk root

Chunk tree is the very essential tree, handling the logical bytenr ->
physical device mapping.

If it has something wrong, it's a big problem.

But normally, such transid error indicates the HDD or the hardware RAID
controller has something wrong handling barrier/flush command.
Mostly it means the disk or the hardware controller is lying about its
FLUSH command.


You can try "btrfs rescue chunk-recovery" but I doubt the chance of
success, as such transid error never just show up in one tree.


Now let's talk about the other device, /dev/sdb.

This is more straightforward:

[    3.165790] ata2.00: exception Emask 0x10 SAct 0x10000 SErr 0x680101
action 0x6 frozen
[    3.165846] ata2.00: irq_stat 0x08000000, interface fatal error
[    3.165892] ata2: SError: { RecovData UnrecovData 10B8B BadCRC Handshk =
}
[    3.165940] ata2.00: failed command: READ FPDMA QUEUED
[    3.165987] ata2.00: cmd 60/f8:80:08:01:00/00:00:00:00:00/40 tag 16
ncq dma 126976 in
                         res 40/00:80:08:01:00/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[    3.166055] ata2.00: status: { DRDY }

Read command just failed, with hardware reporting internal checksum error.

This definitely means the device is not working properly.


And later we got the even stranger error message:

[    3.571793] sd 1:0:0:0: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE cmd_age=3D0s
[    3.571848] sd 1:0:0:0: [sdb] tag#16 Sense Key : Illegal Request
[current]
[    3.571895] sd 1:0:0:0: [sdb] tag#16 Add. Sense: Unaligned write comman=
d
[    3.571943] sd 1:0:0:0: [sdb] tag#16 CDB: Read(10) 28 00 00 00 01 08
00 00 f8 00
[    3.571996] blk_update_request: I/O error, dev sdb, sector 264 op
0x0:(READ) flags 0x80700 phys_seg 30 prio class 0

The disk reports it got some unaligned write, but the block layer says
the operation failed is a READ.

Not sure if the device is really sane.


All these disks are the same model, ST2000DM008, I think it should more
or less indicate there is something wrong in the model...

Recently I have got at least two friends reporting Seagate HDDs have
various problems.
Not sure if they are using the same model.

>
> smartctl seam to say the disks are ok but i'm still unable to mount.
> scrub doesnt see any errors

Well, you already have /dev/sdb report internal checksum error, aka data
corruption inside the disk, and your smartctl is report everything fine.

Then I guess the disk is lying again on the smart info.
(Now I'm more convinced the disk is lying about FLUSH or at least has
something wrong doing FLUSH).

>
> I have installed btrfsmaintanance btw.
>
> Can anyone advice me which steps to take in order to save the data?
> There is no backup (yes I'm a fool but was under the impression that
> with a copy of each file on 2 different disks I'll survive)

For /dev/sdb, I have no idea at all, as we failed to read something from
the disk, it's a completely disk failure.

For /dev/sde, as mentioned, you can try "btrfs rescue chunk-recovery",
and then let "btrfs check" to find out what's wrong.

And I'm pretty sure you won't buy the same disks from Seagate next time.

Thanks,
Qu
>
> Attached all(?) important files + a history of my attempts the past
> days. My attempts from the system rescue usb are not in though.
>
> kind regards,
> Bastiaan
>
