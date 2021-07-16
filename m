Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6003CB7CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhGPNWQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 09:22:16 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:52066 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 09:22:15 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 42B776C00845;
        Fri, 16 Jul 2021 16:19:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1626441559; bh=93e8brkEKNzBx6FEj/hm52Ea1E6HmL4/MT5Ve5VgJYg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=UxW4KUGu2Fruua5NxXUvTSFuluC1rWBe7DZsKO6gP7czdxJjMWiXxUmuiwxzA3HHx
         Gcoa2+PrivmnEs2DFaqgdIJWaBZW9XHZChHwcy1Wos/sAl8EjmPOFD6SKjSV3AXd5B
         skUO130AXWTkePCU43hjLYhqWmoZwmo8sI4P06ts=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 332356C00834;
        Fri, 16 Jul 2021 16:19:19 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id sLK0661lpnei; Fri, 16 Jul 2021 16:19:18 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id BFB7B6C00802;
        Fri, 16 Jul 2021 16:19:18 +0300 (EEST)
Received: from nas (unknown [103.138.53.19])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 4C43F1BE00C2;
        Fri, 16 Jul 2021 16:19:17 +0300 (EEST)
References: <CAKqYf_KZ_fWN55adSCsf6VuaaYa3FSz4XVmE8gL7N45DDO+CBA@mail.gmail.com>
 <98b97dff-c165-92f6-9392-ebea55387814@gmx.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     bw <bwakkie@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: cannot mount after freeze
Date:   Fri, 16 Jul 2021 21:00:17 +0800
Message-ID: <o8b2wg5i.fsf@damenly.su>
In-reply-to: <98b97dff-c165-92f6-9392-ebea55387814@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+ngkCkQGXfDBpE3CcxJ/GHiOq5zH8tkXr8MS+GdksMVBar7hJ7DSP4og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 16 Jul 2021 at 20:26, Qu Wenruo <quwenruo.btrfs@gmx.com>=20
wrote:

> On 2021/7/16 =E4=B8=8B=E5=8D=887:12, bw wrote:
>> Hello,
>>
>> My raid1 with 3 hdd's that contain /home and /data cannot be=20
>> mounted
>> after a freeze/restart on the 14 of juli
>>
>> My root / (ubuntu 20.10) is on a raid with 2 ssd's so I can=20
>> boot but I
>> always end up in rescue mode atm. When disabling the two mounts=20
>> (/data
>> and /home) in fstab i can log in as root. (had to first change=20
>> the
>> root password via a rescue usb in order to log in)
>
> /dev/sde has corrupted chunk root, which is pretty rare.
>
> [    8.175417] BTRFS error (device sde): parent transid verify=20
> failed on
> 5028524228608 wanted 1427600 found 1429491
> [    8.175729] BTRFS error (device sde): bad tree block start,=20
> want
> 5028524228608 have 0
> [    8.175771] BTRFS error (device sde): failed to read chunk=20
> root
>
> Chunk tree is the very essential tree, handling the logical=20
> bytenr ->
> physical device mapping.
>
> If it has something wrong, it's a big problem.
>
> But normally, such transid error indicates the HDD or the=20
> hardware RAID
> controller has something wrong handling barrier/flush command.
> Mostly it means the disk or the hardware controller is lying=20
> about its
> FLUSH command.
>
>
> You can try "btrfs rescue chunk-recovery" but I doubt the chance=20
> of
> success, as such transid error never just show up in one tree.
>
>
> Now let's talk about the other device, /dev/sdb.
>
> This is more straightforward:
>
> [    3.165790] ata2.00: exception Emask 0x10 SAct 0x10000 SErr=20
> 0x680101
> action 0x6 frozen
> [    3.165846] ata2.00: irq_stat 0x08000000, interface fatal=20
> error
> [    3.165892] ata2: SError: { RecovData UnrecovData 10B8B=20
> BadCRC Handshk }
> [    3.165940] ata2.00: failed command: READ FPDMA QUEUED
> [    3.165987] ata2.00: cmd 60/f8:80:08:01:00/00:00:00:00:00/40=20
> tag 16
> ncq dma 126976 in
>                          res 40/00:80:08:01:00/00:00:00:00:00/40=20
>                          Emask
> 0x10 (ATA bus error)
> [    3.166055] ata2.00: status: { DRDY }
>
> Read command just failed, with hardware reporting internal=20
> checksum error.
>
> This definitely means the device is not working properly.
>
>
> And later we got the even stranger error message:
>
> [    3.571793] sd 1:0:0:0: [sdb] tag#16 FAILED Result:=20
> hostbyte=3DDID_OK
> driverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [    3.571848] sd 1:0:0:0: [sdb] tag#16 Sense Key : Illegal=20
> Request
> [current]
> [    3.571895] sd 1:0:0:0: [sdb] tag#16 Add. Sense: Unaligned=20
> write command
> [    3.571943] sd 1:0:0:0: [sdb] tag#16 CDB: Read(10) 28 00 00=20
> 00 01 08
> 00 00 f8 00
> [    3.571996] blk_update_request: I/O error, dev sdb, sector=20
> 264 op
> 0x0:(READ) flags 0x80700 phys_seg 30 prio class 0
>
> The disk reports it got some unaligned write, but the block=20
> layer says
> the operation failed is a READ.
>
> Not sure if the device is really sane.
>
>
> All these disks are the same model, ST2000DM008, I think it=20
> should more
> or less indicate there is something wrong in the model...
>
> Recently I have got at least two friends reporting Seagate HDDs=20
> have
> various problems.
> Not sure if they are using the same model.
>
Just say what I have seen.

Right, the model is ST2000DM008, 2T version. The background is=20
that
there are three disks in ST2000DM008 model running with xfs on=20
Dell
OEM machines respectively. I think other hardwares OEM by Dell=20
should
be stable enough except the suspicious Seagate disks in SMR.
All of the three disks have abnormal error info in their smart=20
info
after running only 10,000 hours. One disk even has 609 error logs.

--
Su
>>
>> smartctl seam to say the disks are ok but i'm still unable to=20
>> mount.
>> scrub doesnt see any errors
>
> Well, you already have /dev/sdb report internal checksum error,=20
> aka data
> corruption inside the disk, and your smartctl is report=20
> everything fine.
>
> Then I guess the disk is lying again on the smart info.
> (Now I'm more convinced the disk is lying about FLUSH or at=20
> least has
> something wrong doing FLUSH).
>
>>
>> I have installed btrfsmaintanance btw.
>>
>> Can anyone advice me which steps to take in order to save the=20
>> data?
>> There is no backup (yes I'm a fool but was under the impression=20
>> that
>> with a copy of each file on 2 different disks I'll survive)
>
> For /dev/sdb, I have no idea at all, as we failed to read=20
> something from
> the disk, it's a completely disk failure.
>
> For /dev/sde, as mentioned, you can try "btrfs rescue=20
> chunk-recovery",
> and then let "btrfs check" to find out what's wrong.
>
> And I'm pretty sure you won't buy the same disks from Seagate=20
> next time.
>
> Thanks,
> Qu
>>
>> Attached all(?) important files + a history of my attempts the=20
>> past
>> days. My attempts from the system rescue usb are not in though.
>>
>> kind regards,
>> Bastiaan
>>
