Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AA3AD326
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFRTwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhFRTww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 15:52:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A1C061760
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 12:50:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d196so13677595qkg.12
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/GDlAwgzx3VeDnuQmctVYyrpSEYpo/2hdlhfczqXr+E=;
        b=MBJWcow99ansixg7/RIa/dU/m7sgsMKRT3va4MAM4TV0A5mH3jNUIpBLYelRdTxHg/
         t4j4d0lg3wsBLOcxwXY2ptO7BnyoOTUnC6iBKB86QxWIPg00+iKv7Y7BpfAd7/E9rtRE
         C9hkNx0/Rd6tbYxAX7c6zhJ/L2A+0wqY/0kQHUbfbCpstAxtQIRuE+c6SRxkDQq1rI6u
         f2Q2ZGIJ7qgCbtwBr5j9VjAsECkfcIc0e1FKGZ+oHl9lHMebUZxqLFTiU60aEXKZdvKJ
         LzkcSGv6uXToGIKZTAY3x2FYHHO7HlmDqN1KVCU6140Db64YJApMVltY90dYTapuV8Y9
         7WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/GDlAwgzx3VeDnuQmctVYyrpSEYpo/2hdlhfczqXr+E=;
        b=ms+CeXFGrc0s6j9YlxtMI8pW9+zo8n38T6mBSUFN+AuzD3sFK9CG8xhS72kZPLzNIt
         Bo/hMsjZ8ozGEHAXAkcYF7dLGjaAp/PvNYwXRPoDOi83kcpjlla1diOSmPUKw2EJ9cEc
         LGHQmSPN9E2gSbqSj9ikk+VOrxQFjiLDnZ44TNJoKiHQL2NMEad+AZUgnBeLYwc2bzdO
         CFmcptsrZg6YfakQst24wnZBMp3/cWqcq/6f1OUfycwalU3DQ0Sv2OW4YRr6aLoFF6RT
         k1mINKHHOIi11mqWxN3aEn5tvZCAgYgqAfg0b6IcOiQ8ycNKG2/hor7Lkwcvdpi18cu7
         4mSg==
X-Gm-Message-State: AOAM533aRUzpvdifoJQMcwtnIKEBKG+rn+J2hi9emxGVLE9/QIu8ZUB5
        rV3eebJYuzVysoqx3VHL4aPAODZ9r9WZ/PTTa78GBpn7Dqc0ZUS2
X-Google-Smtp-Source: ABdhPJztZs6QrvE94blEixcYVK9DvW6yLRMtK3JEcnWTz2SRs9+dc6+Hdvd2W8FIHLwXbUMFXhoD3OdAahGz0Xm5uLI=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr15626503ybg.111.1624045841150;
 Fri, 18 Jun 2021 12:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAO1Y9wrzMEf+H5cg2SaJrcZy8Qb7aeufHDXAt0f71bEA_5HAwg@mail.gmail.com>
 <CAJCQCtR=18jaormwxmGMQJjcHozNZF0U30K_1L9KV-HvW5uCWQ@mail.gmail.com>
In-Reply-To: <CAJCQCtR=18jaormwxmGMQJjcHozNZF0U30K_1L9KV-HvW5uCWQ@mail.gmail.com>
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Fri, 18 Jun 2021 16:50:30 -0300
Message-ID: <CAO1Y9wq47=dM26Lc6EC33PJCOJF1e_B8OkZ+o6maX518hZr0sA@mail.gmail.com>
Subject: Re: Kernel GPF on RAID6 replace
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Setup is a bit unusual, BTRFS is running over BCACHE, whole
unpartitioned disks, here's the raw data, removed the unrelated disks:

lsblk -o NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,MOD=
EL:

sda                        bcache        7.3T
bc7c0748-4cb4-43cc-ad5d-d736e5e0db82     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache1                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdb                        bcache        7.3T
0a642b3a-78c8-435f-89bd-4fce86c270a7     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache8                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdc                        bcache        7.3T
5f2a88df-1465-464a-96f7-53432f5d4acc     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache9                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdd                        bcache        7.3T
f48df2c8-b665-485b-ae82-ac0cb256c1de     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache11                 btrfs         7.3T    66% /data
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdg                        bcache        7.3T
ba8101e5-6d9e-44a1-8339-3bbbfa9db030     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache6                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdh                        bcache        7.3T
301fb860-2eb3-488c-94b7-7013f2a9ad0c     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache3                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdi                        bcache        7.3T
7ba65110-6a17-4c67-be63-060d2f721a87     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache5                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdj                        bcache        7.3T
36d72ae0-b03d-458c-b75d-c62804ddb240     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache4                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdk                        bcache        7.3T
2b494639-5863-4bb9-b462-686f62e75091     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache2                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdl                        bcache        7.3T
03b62951-3532-40f5-9a67-1ef287caa890     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache0                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdm                        bcache        7.3T
8b978d80-c6c3-426b-a260-86221212610c     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache7                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdn                        bcache        7.3T
5e36e48a-c550-402e-b249-11fae77cc740     4096 mq-deadline        0B
ST8000DM004-2CX1
=E2=94=94=E2=94=80bcache10                 btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
sdp                        bcache      223.6G
517b4831-9c41-4c86-8c8f-f5e5a2d74d27      512 mq-deadline      512B
KINGSTON_SA400S3
=E2=94=9C=E2=94=80bcache0                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache1                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache2                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache3                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache4                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache5                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache6                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache7                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache8                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache9                  btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache10                 btrfs         7.3T
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=9C=E2=94=80bcache11                 btrfs         7.3T    66% /data
224936e2-df99-4952-952e-9fc8cf87fc34      512                  512B
=E2=94=94=E2=94=80bcache12                 ext4          3.7T    42% /scrat=
ch
3590506e-c0f0-45c1-8fd7-3fafe3a73024      512                  512B

btrfs filesystem usage -T /data
WARNING: RAID56 detected, not implemented
Overall:
    Device size:                  94.61TiB
    Device allocated:            488.12GiB
    Device unallocated:           94.13TiB
    Device missing:                7.28TiB
    Used:                        447.63GiB
    Free (estimated):                0.00B      (min: 8.00EiB)
    Data ratio:                       0.00
    Metadata ratio:                   4.00
    Global reserve:              512.00MiB      (used: 0.00B)

                 Data     Metadata  System
Id Path          RAID6    RAID1C4   RAID1C4  Unallocated
-- ------------- -------- --------- -------- -----------
 0 /dev/bcache11        -         -        -     7.28TiB
 1 /dev/bcache2   5.71TiB  41.00GiB        -     1.53TiB
 4 /dev/bcache8   5.71TiB  40.00GiB 32.00MiB     1.53TiB
 5 /dev/bcache0   5.71TiB  41.00GiB        -     1.53TiB
 6 missing        5.71TiB  41.00GiB        -    -5.75TiB
 7 /dev/bcache1   5.71TiB  40.00GiB 32.00MiB     1.53TiB
 8 /dev/bcache9   5.71TiB  41.00GiB        -     1.53TiB
 9 /dev/bcache7   5.71TiB  41.00GiB        -     1.53TiB
10 /dev/bcache10  5.71TiB  40.00GiB 32.00MiB     1.53TiB
11 /dev/bcache6   5.71TiB  41.00GiB        -     1.53TiB
12 /dev/bcache3   5.71TiB  40.00GiB 32.00MiB     1.53TiB
13 /dev/bcache5   5.71TiB  41.00GiB        -     1.53TiB
14 /dev/bcache4   5.71TiB  41.00GiB        -     1.53TiB
-- ------------- -------- --------- -------- -----------
   Total         57.11TiB 122.00GiB 32.00MiB    18.32TiB
   Used          56.95TiB 111.91GiB  2.69MiB

Currently mounted degraded,readonly. Didn't explore much yet, but
overall seems "fine" (as much as fine as a RAID6 missing a disk can
be).

On Fri, Jun 18, 2021 at 4:24 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> It'd be useful to see the storage stack:
>
> lsblk -o NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,M=
ODEL
>
> It's fine to omit the UUID. Mainly I just want to see all the physical
> devices, their partitions, and how everything is being assembled to
> make up this Btrfs file system.
>
> Also useful info
>
> sudo btrfs filesystem usage -T /mntpoint
>
>
> Chris Murphy
