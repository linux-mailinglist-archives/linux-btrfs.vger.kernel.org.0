Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F755A78F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 08:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiFYGoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiFYGoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 02:44:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C284F41FB5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656139448;
        bh=B8phJP4uRSkq4RK6Bz4Mvgrat8Y9J3aypUFqoF8I5LA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DDxKppTnKSzX+4tMHih2jdxfqVr1NvKLy7DXhn14nS5psQD3L45gSsXDsZVlVLHyS
         Wrq4m7Ns3/pLVee2QP5O8lETQpyLIQTHgjA1RlvFMGwl336/RCnNbOEEPNdk/kLMaZ
         wtwCiAfaRXJih2kSyu+K6l+pZhZjVyxyfjaCPCWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwXh-1nycnO144f-00BKRY; Sat, 25
 Jun 2022 08:44:07 +0200
Message-ID: <4f9fcd17-8b2c-afaf-b512-c8786320f148@gmx.com>
Date:   Sat, 25 Jun 2022 14:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: FSTRIM timeout/errors on WD RED SA500 NAS SSD
Content-Language: en-US
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ulnhFWttQHNZ5jHHFdNwZvunMRzaaz0/ZRV1kQ7aGFtQuF5F0mw
 YpHpjX0EnY3/xw4e4/JAWXnue3mAyMpHi6hBivY3kYsElIdHL+wD+/b8OpmxNXPhTUhe0P9
 iI/KwSNGrBSpSPhG0MxRh+gDZynbeIeAVj4Hp4T3X1Mtyi0FiVumhaCjKLBkBK+KIFGG/Mp
 mwzNatd9i/whCl8w2JVNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ej0GmdcamOE=:AdihqpvgA6aXgw5zvR9pRi
 Zpw5G1bhwZIJR14tEmXX5Nbp5UgVBz7o3bhcPxUqE2VSxPTG8zbmBuZ73ZYQipDLykEK7BD9o
 6OKE9vr9rXJ5xWdXwC5NGLvCwZoBBBAHRRxm5/aaUY58RpH+cD2T6szo6dH0TvIwGqCpWw2FG
 OHnxKa1Y5vDL+ZAWuZNqdpcO32oNKTmmNZtfq551oT2lPAHz7IsUz7Mmu8ayIFeALp+qlULz2
 JBm+DtFNxMsAS9KKiVaG/lmiqW4Vis2ym+yiOwYwZlEZ6KUvRj6kMW7qR/BH5LcNT8nvEGigi
 EoPYhufoypwWkRBcrsr+FPgsK2iw3k46BeH2tat6NnEHRTlqwGI8WhkMtYbFXEd432bIo1gSV
 QpNhzDUtaPL/qVXa7aNT5UZGfoNXakgwBohDh7xuV/O0NAMVeO+2nuum9EdQiZQdCoMCVY1NT
 iDm3WVfAnLPIRHuvv+J3Nv7deI3xPjiIqsUuI7qjpsH6AgWAHV6ENPV29EdmqOrsvGGXvgIeY
 IazMP2C1zzsT7LN4ALbvA8ktZosVZw/PZHfsUsmFSgu3hNH2KNqwLNFcxD8IC2c6JO8iZzLYR
 8CyQBKW3BRTcobYYgsPk5Kngnn/aNQoC52j4kLO1lMoIlKnwQg0OZWo5WnEnIKudya7xVecAI
 MNFgtI9pAlWxnSzuhApiyIJtqHX2U+kx+gepKkewnD1qmt0YCBfFMNCy3xqPloZ2Za/27E4oA
 cMcVP8NSqbmK476amsqzW4hW4C6ggkVT2eTnu+KV5qR1NcIXjWgFMi7/fbi4K6H7n2VIxuK2i
 ipEvktUE27HJI5chOdZRfmjg/zmdv+OkHxBI4e0IZRJtrik6oRYzzqeJyNWwm437E67dMRY+l
 Acd5+qEHL9M29jL14iInEapTE3W4/yaO/p2/W+6Hux8JwrHJVfq78O2te8KIARjGoOZxFdLnT
 WQck72BKBaOLioI3K6gcARc4H+xzy+3nHGuKruvUa9FYpSYweVj58rpSvA9E2vd9tjYSF7b8k
 v+Ut6AwgvtUHMKavdZYNkcYD4dPWljyegWb8ShtwZuDvJ83qKomnC7plLb0KNO3Y822qbkRl0
 bE5dWTehc74LKXB3KMFIwqthUvDDRC5RrwUuFC2v+7tmQsuQy2zuypJQw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 23:23, Forza wrote:
> Hi,
>
> I have discovered an odd issue where "fstrim" on an Btrfs filesystem
> consistently fails, while "mkfs.btrfs" always succeeds with full device
> discard.
>
> Hardware:
> * SuperMicro server
> * LSI/Broadcom HBA 9500-8i SAS/SATA controller
> * WD RED SA500 NAS SATA SSD 2TB (WDS200T1R0A-68A4W0)
>  =C2=A0 Drive FW: 411000WR
> * Alpine Linux kernel 5.15.48
>
> * /sys/block/sdf/queue/
>  =C2=A0 discard_granularity:512
>  =C2=A0 discard_max_bytes:134217216
>  =C2=A0 discard_max_hw_bytes:134217216

Weird, it's 128M - 512, not sure if this is related.

>
> # btrfs fi us -T /mnt/nas_ssd/
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.13=
TiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 90.06GiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.04TiB

Btrfs will definitely try to submit a large bio to do discard on all
those unallocated space.

Considering EXT4 has its block group headers taking up space, I guess it
will not submit large enough discard bio to trigger the problem.

>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 86.73GiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.52TiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (min: 3.52TiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.52TiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 94.58MiB=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (used: 0.00B)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Data=C2=A0=C2=A0=C2=A0=C2=A0 Metadata=C2=A0 System
> Id Path=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAID1=C2=A0=C2=A0=C2=A0 RAID1=C2=
=A0=C2=A0=C2=A0=C2=A0 RAID1=C2=A0=C2=A0=C2=A0 Unallocated
> -- --------- -------- --------- -------- -----------
>  =C2=A09 /dev/sdc1 44.00GiB=C2=A0=C2=A0 1.00GiB 32.00MiB=C2=A0=C2=A0=C2=
=A0=C2=A0 1.77TiB
> 10 /dev/sdf1 44.00GiB=C2=A0=C2=A0 1.00GiB 32.00MiB=C2=A0=C2=A0=C2=A0=C2=
=A0 1.77TiB
> 11 /dev/sdd1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -=C2=A0=C2=A0 894.25GiB
> 12 /dev/sde1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -=C2=A0=C2=A0 894.25GiB
> 13 /dev/sdg1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -=C2=A0=C2=A0=C2=A0=C2=A0 1.82TiB
> 14 /dev/sdh1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -=C2=A0=C2=A0=C2=A0=C2=A0 1.82TiB
> -- --------- -------- --------- -------- -----------
>  =C2=A0=C2=A0 Total=C2=A0=C2=A0=C2=A0=C2=A0 44.00GiB=C2=A0=C2=A0 1.00GiB=
 32.00MiB=C2=A0=C2=A0=C2=A0=C2=A0 8.94TiB
>  =C2=A0=C2=A0 Used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 43.23GiB 133.44MiB 16.0=
0KiB
>
>
>
>
> The root cause I believe is that the WD drives take 1.5-2.5 minutes to
> do a full device discard. The Kingston DC500 drives only take 6-7
> seconds for the same. I have 4 identical WD drives and 2 Kingston
> drives. All WD drives have the same issue.
>
> When issuing 'fstrim -v /mnt/btrfs' I get the following message in dmesg
> after about 30 seconds:
>
> # time fstrim -v /mnt/nas_ssd/
> /mnt/nas_ssd/: 6.2 TiB (6834839748608 bytes) trimmed
>
> real=C2=A0=C2=A0=C2=A0 4m21.356s
> user=C2=A0=C2=A0=C2=A0 0m0.001s
> sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.241s
>
> [=C2=A0 +0.000003] scsi target6:0:4: handle(0x0029),
> sas_address(0x5003048020db4543), phy(3)
> [=C2=A0 +0.000003] scsi target6:0:4: enclosure logical
> id(0x5003048020db457f), slot(3)
> [=C2=A0 +0.000003] scsi target6:0:4: enclosure level(0x0000), connector =
name(
> C0.1)
> [=C2=A0 +0.000003] sd 6:0:4:0: No reference found at driver, assuming
> scmd(0x00000000eb0d9438) might have completed
> [=C2=A0 +0.000003] sd 6:0:4:0: task abort: SUCCESS scmd(0x00000000eb0d94=
38)
> [=C2=A0 +0.000012] sd 6:0:4:0: attempting task
> abort!scmd(0x0000000075f63919), outstanding for 30397 ms & timeout 30000=
 ms
> [=C2=A0 +0.000003] sd 6:0:4:0: [sdg] tag#2762 CDB: opcode=3D0x42 42 00 0=
0 00 00
> 00 00 00 18 00
> [=C2=A0 +0.000002] scsi target6:0:4: handle(0x0029),
> sas_address(0x5003048020db4543), phy(3)
> [=C2=A0 +0.000004] scsi target6:0:4: enclosure logical
> id(0x5003048020db457f), slot(3)
> [=C2=A0 +0.000002] scsi target6:0:4: enclosure level(0x0000), connector =
name(
> C0.1)
> [=C2=A0 +0.000003] sd 6:0:4:0: No reference found at driver, assuming
> scmd(0x0000000075f63919) might have completed
> [=C2=A0 +0.000003] sd 6:0:4:0: task abort: SUCCESS scmd(0x0000000075f639=
19)
> [=C2=A0 +0.255021] sd 6:0:4:0: Power-on or device reset occurred

Just want to make sure it's not btrfs screwing up things, mind to use
blktrace to trace the bio submitted so we can make sure btrfs is doing
its work correct?

Thanks,
Qu
>
>
>
>
> An interesting observation is that "fstrim" works on the same device if
> it is mounted as ext4. There are no errors in dmesg.
>
> To sum up:
>
> Works:
> * "mkfs.btrfs"
> * "btrfs replace"
> * "btrfs device add"
> * "fstrim" on ext4 mounted device.
>
> Does not work:
> * "fstrim" on Btrfs mounted device
> * "blkdiscard" on /dev/sdX
>
> The btrfs-progs code seems to do 'BLKDISCARD' on 1GiB chunks. This may
> explain why "mkfs.btrfs" and "btrfs relace" and "btrfs device add"
> works, while "fstrim" and "blkdiscard" tools do not.
> https://github.com/kdave/btrfs-progs/blob/c0ad9bde429196db7e8710ea1abfab=
7a2bca2e43/common/device-utils.c#L79
>
>
> Not exactly sure how ext4 handles the "fstrim" case, but it seems to
> group trim requests in smaller batches, which may explain why the SSD
> returns status before the 30s timeout of the HBA.
> https://github.com/torvalds/linux/blob/92f20ff72066d8d7e2ffb655c2236259a=
c9d1c5d/fs/ext4/mballoc.c#L6467
>
>
> Can we work around the Btrfs fstrim issue, for example by splitting up
> fstrim requests in "discard_max_bytes" sized chunks?
>
> Thanks,
> Forza
