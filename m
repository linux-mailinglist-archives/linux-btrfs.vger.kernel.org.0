Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5263AE0B2
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFTVeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTVeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 17:34:08 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527DC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:31:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d196so25489671qkg.12
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eNb3qKg3hxUfPUJX44fBfGctblaBmpd9XZNqXOJ/zjE=;
        b=VPpVjXkiWB0P8M5lX2ePfjgVIZfzt3Lx/NbYfVwzYAUxeDCfDqps4W4Hwn/EPJ4qJK
         iKoNNayjDU2nINTlyrP+vtTYD1xDq36T3EMpRpcoi/aDMWuL3+XT51WirFFEYa/GK0aV
         aRGcmD08E22p/wi3UuQqKxTOs15x+FsaRXtFJY56mNNRyrUboQJ9yfE3numeUHr04LkW
         jzQH7DOPmi8igcCckOFMRnO/+E6DyC2oOIRMhJSkLYFx3qckchxFv1F1WSGrENLZXOeU
         oocmWv8xzYMt+r4HhPf10K+WjzCfzLD8GTQY8UTJgA8jJEbob1NzgOf/HoTbxdS8XruS
         ocUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eNb3qKg3hxUfPUJX44fBfGctblaBmpd9XZNqXOJ/zjE=;
        b=QODIf3lU83vnd/hF2+hOVddrOEvZggtTgsXQVpu2TJNSv1J+HAEP/RZ0NKUokY+ul+
         f2kuEWCOiYC/IutPswetl/RsDVT58JYDk1to5MAUVU9C9DIkLDzXXhyCD8rLZU1N3Pz/
         2Zev13ybz+H81ux9sm5DHcDY0azIQliipJMTcGVRVNWqjjnJnbV8dRGln+dduHa/Vrd8
         bk1Fm26qQjsqWmNg3gCHvK2wb5gV0+N14pGXw/wk+VCYjZ/NrTQprBQXBEGt9kSBwVVr
         I6HzAUUXI3t/EUymgAwGBJcQG8eYV4rnN71pWGBqwZewxAZySpjge0TTmQqRBHI5o/zz
         s2OA==
X-Gm-Message-State: AOAM532Rc8KnidModG1a1SRjD/z7UyACZOAGaRWcW/v/gElM5feEABqz
        A2xJg9B92Gu9VJgot4nlt1mwvgKyi3OFj8rG1biRVaimoCc=
X-Google-Smtp-Source: ABdhPJxsN69O1MThM1EcxupWapRE81PG+fPEC9p+41kvnfxk24Yv2+RUywqv+Os90VidDi61R/inP5wMM3ACANpP9AQ=
X-Received: by 2002:a25:4c42:: with SMTP id z63mr21031631yba.20.1624224712483;
 Sun, 20 Jun 2021 14:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
 <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com>
In-Reply-To: <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com>
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sun, 20 Jun 2021 21:31:41 +0000
Message-ID: <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>Was bcache in write back or write through mode?
Writeback.

>What's the configuration?
NAME        FSTYPE              SIZE FSUSE% MOUNTPOINT
UUID                                  MIN-IO SCHED       DISC-GRAN
MODEL
loop0       squashfs          655.6M   100% /run/archiso/sfs/airootfs
                                        512 mq-deadline        0B
sda                           238.5G
                                        512 mq-deadline      512B
C300-CTFDDAC256MAG
=E2=94=9C=E2=94=80sda1                            2M
                                        512 mq-deadline      512B
=E2=94=9C=E2=94=80sda2      linux_raid_member   512M
325a2f12-18b8-27f7-2f81-f554a9b0fccc     512 mq-deadline      512B
=E2=94=82 =E2=94=94=E2=94=80md126   vfat              511.9M
EF35-0411                                512                  512B
=E2=94=94=E2=94=80sda3      linux_raid_member    16G
93ed641f-394b-2122-7525-b3311aaac6b8     512 mq-deadline      512B
  =E2=94=94=E2=94=80md125   swap                 16G
9ea84fb7-8bd7-4a0e-91fe-398790643066 1048576                  512B
sdb                           232.9G
                                        512 mq-deadline      512B
Samsung_SSD_850_EVO_250GB
=E2=94=9C=E2=94=80sdb1                            2M
                                        512 mq-deadline      512B
=E2=94=9C=E2=94=80sdb2      linux_raid_member   512M
325a2f12-18b8-27f7-2f81-f554a9b0fccc     512 mq-deadline      512B
=E2=94=82 =E2=94=94=E2=94=80md126   vfat              511.9M
EF35-0411                                512                  512B
=E2=94=94=E2=94=80sdb3      linux_raid_member    16G
93ed641f-394b-2122-7525-b3311aaac6b8     512 mq-deadline      512B
  =E2=94=94=E2=94=80md125   swap                 16G
9ea84fb7-8bd7-4a0e-91fe-398790643066 1048576                  512B
sdc         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Z3A0
=E2=94=94=E2=94=80sdc1      bcache            931.5G
f34b26ea-8229-4f3f-bdc5-29c5fe16eaae     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache0 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdd         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Z3A0
=E2=94=94=E2=94=80sdd1      bcache            931.5G
beb25260-1b36-473f-93c4-7ef016a62f44     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache1 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sde         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1    4096 mq-deadline        0B
WDC_WD1003FZEX-00MK2A0
=E2=94=94=E2=94=80sde1      bcache            931.5G
21b55c83-c951-4e4f-affc-0b9bf54c8783    4096 mq-deadline        0B
  =E2=94=94=E2=94=80bcache2 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdf         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Z3A0
=E2=94=94=E2=94=80sdf1      bcache            931.5G
d4d2b9d6-077d-4328-b2cd-14f6db259955     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache3 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdg         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
ST1000NM0011
=E2=94=94=E2=94=80sdg1      bcache            931.5G
a8513a01-c6be-4bec-b3f9-a5797225d304     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache4 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdh                           931.5G
                                        512 mq-deadline        0B
WDC_WD1002FAEX-00Z3A0
=E2=94=94=E2=94=80sdh1      bcache            931.5G
ffeacab7-ff42-453c-b012-58b119236fa5     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache5 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdi         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Y9A0
=E2=94=94=E2=94=80sdi1      bcache            931.5G
f3f4d706-7d73-4b48-a5b3-9802fc0de978     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache6 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdj         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1    4096 mq-deadline        0B
WDC_WD1003FZEX-00MK2A0
=E2=94=94=E2=94=80sdj1      bcache            931.5G
64d10dda-4ac2-44d4-941a-362ccb5ddbba    4096 mq-deadline        0B
  =E2=94=94=E2=94=80bcache7 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdk         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Y9A0
=E2=94=94=E2=94=80sdk1      bcache            931.5G
c3ddc718-f700-4360-82c9-7db76114e3f6     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache8 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdl         btrfs             931.5G
12bcde5c-b3ae-4fa6-8e17-0a4b564f1ba1     512 mq-deadline        0B
WDC_WD1002FAEX-00Z3A0
=E2=94=94=E2=94=80sdl1      bcache            931.5G
2bf5ac80-cdf6-4c0c-9434-bcdc4626abff     512 mq-deadline        0B
  =E2=94=94=E2=94=80bcache9 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
sdm         iso9660            14.9G
2021-05-08-11-22-02-00                   512 mq-deadline        0B
USB_2.0_FD
=E2=94=9C=E2=94=80sdm1      iso9660             717M   100% /run/archiso/bo=
otmnt
2021-05-08-11-22-02-00                   512 mq-deadline        0B
=E2=94=94=E2=94=80sdm2      vfat                1.4M
0A52-44A0                                512 mq-deadline        0B
nvme0n1     linux_raid_member  13.4G
4703551c-4570-b6c8-7dda-991b93b99c9a     512 none             512B
INTEL MEMPEK1W016GA
=E2=94=94=E2=94=80md127     bcache             13.4G
dfda7dc0-07a4-40bf-b5b8-e3458c181ce4   16384                  512B
  =E2=94=9C=E2=94=80bcache0 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache1 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache2 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache3 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache4 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache5 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache6 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache7 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache8 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=94=E2=94=80bcache9 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
nvme1n1     linux_raid_member  13.4G
4703551c-4570-b6c8-7dda-991b93b99c9a     512 none             512B
INTEL MEMPEK1W016GA
=E2=94=94=E2=94=80md127     bcache             13.4G
dfda7dc0-07a4-40bf-b5b8-e3458c181ce4   16384                  512B
  =E2=94=9C=E2=94=80bcache0 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache1 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache2 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache3 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache4 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache5 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache6 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache7 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=9C=E2=94=80bcache8 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B
  =E2=94=94=E2=94=80bcache9 btrfs             931.5G
76189222-b60d-4402-a7ff-141f057e8574     512                  512B

On Sun, Jun 20, 2021 at 9:09 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> On Sun, Jun 20, 2021 at 2:38 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
> >
> > A machine failed to boot, so I tried to mount its root partition from
> > systemrescuecd, which failed:
> >
> > [ 5404.240019] BTRFS info (device bcache3): disk space caching is enabl=
ed
> > [ 5404.240022] BTRFS info (device bcache3): has skinny extents
> > [ 5404.243195] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243279] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243362] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243432] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
> > [ 5404.244114] BTRFS error (device bcache3): open_ctree failed
> >
> > btrfs rescue super-recover -v /dev/bcache0 returned this:
> >
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420=
435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420=
435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420=
435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420=
435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420=
435
> > Ignoring transid failure
> > ERROR: could not setup extent tree
> > Failed to recover bad superblocks
> >
> > uname -a:
> >
> > Linux sysrescue 5.10.34-1-lts #1 SMP Sun, 02 May 2021 12:41:09 +0000
> > x86_64 GNU/Linux
> >
> > btrfs --version:
> >
> > btrfs-progs v5.10.1
> >
> > btrfs fi show:
> >
> > Label: none  uuid: 76189222-b60d-4402-a7ff-141f057e8574
> >         Total devices 10 FS bytes used 1.50TiB
> >         devid    1 size 931.51GiB used 311.03GiB path /dev/bcache3
> >         devid    2 size 931.51GiB used 311.00GiB path /dev/bcache2
> >         devid    3 size 931.51GiB used 311.00GiB path /dev/bcache1
> >         devid    4 size 931.51GiB used 311.00GiB path /dev/bcache0
> >         devid    5 size 931.51GiB used 311.00GiB path /dev/bcache4
> >         devid    6 size 931.51GiB used 311.00GiB path /dev/bcache8
> >         devid    7 size 931.51GiB used 311.00GiB path /dev/bcache6
> >         devid    8 size 931.51GiB used 311.03GiB path /dev/bcache9
> >         devid    9 size 931.51GiB used 311.03GiB path /dev/bcache7
> >         devid   10 size 931.51GiB used 311.03GiB path /dev/bcache5
> >
> > Is this filesystem recoverable?
> >> (Sorry, re-sending because I forgot to add a subject)
>
> Definitely don't write any irreversible changes, such as a repair
> attempt, to anything until you understand what what wrong or it'll
> make recovery harder or impossible.
>
> Was bcache in write back or write through mode?
>
> What's the configuration? Can you supply something like
>
> lsblk -o NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,M=
ODEL
>
>
>
> --
> Chris Murphy
