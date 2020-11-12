Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCC22B123F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 23:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKLWzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 17:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKLWzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 17:55:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34FC0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 14:55:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a3so6842667wmb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 14:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F5zC8NDxC8XzIq/3gNzekSjB4SZdQXJ28auMuDiQKDY=;
        b=ssZfdWzbzFJqP+V9U+wVl12YqnMnzgAAqhFqEtgt9ArzNF9tfe5MtRX3XDjisPHfb9
         3YujrTslyWshwv0b4H5MzhyBn1WUp0xGbOrKziczaIhPRGOj+AiueC9gQsBH0rngSiXh
         Pe6KUvV2boNn0YQAH6xrxl+KjaZcI1HA7NelBoIG73ZKDS5xl+fqiV7U7FVV8snRvLWD
         r8x6wk5oCttMT22TmlB6iNkfDIw9KSt85754Ej/dx+u9UJejzRKuPKpnEzSCsNtwVKXT
         jvgfDBZDnoMc30FutFeRww5MM0wNnNEQToIPN7y5CS8/QEKrQp6QAAwNqKQIf/omycgq
         JLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F5zC8NDxC8XzIq/3gNzekSjB4SZdQXJ28auMuDiQKDY=;
        b=XbTz39FAZMZfX0/QR9esl2iRETrTJePFHxtQAIeRsVWcF6eeT1m8B+WLvDKM6U4j1E
         VcmhSPm0UGe81zbL77cb6frDYBlD4uNeaLfoqegweSnwTstAazy7FUOd/yRxKrWoev9V
         CLY+P1Qx4oEyv8KtirCo7tRCVQcOV3eKFRfgXrmf5g5DBvAMnpSv4Tcs8i/x9Fpu6DpZ
         sfQUUAZ6RkAJjeCyeZupfSsohDqZY4iEP9n3f8GJ0gZgLAI+Vb4qp82LniSpMqh5KW2V
         vUV20YgwVZ6BbuPQZMOb9QATUQZLmTG3H8jFmkEcDayl7ie//yEPtuECcf2r2go+Pe/o
         AUTQ==
X-Gm-Message-State: AOAM531YnsTZjfaJ5kGDQiSeVxgUlgCl/rTuOCtTaVT2fGRrvOOdG8xT
        p1ahJJAEkvx34oQMCLArB43togwPV0yKTGPlz09dRhd2SyC6lGJC
X-Google-Smtp-Source: ABdhPJyWBrc33fpqyg2qitn9Gd5NII+2R6rbk+3MjiJq+0CdLOjt9GfOvP6OvBlUETgkVEwvvTXn0REpQ067YzBZmJM=
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr106574wmi.124.1605221736005;
 Thu, 12 Nov 2020 14:55:36 -0800 (PST)
MIME-Version: 1.0
References: <roibjb$u1$1@ciao.gmane.io>
In-Reply-To: <roibjb$u1$1@ciao.gmane.io>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 12 Nov 2020 15:55:19 -0700
Message-ID: <CAJCQCtS81a96whvBXzkWY3wv9qLbTWiyjP_=3pQTVMi1uAnJrw@mail.gmail.com>
Subject: Re: ERROR: could not setup extent tree
To:     Jean-Denis Girard <jd.girard@sysnux.pf>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 10:32 PM Jean-Denis Girard <jd.girard@sysnux.pf> wr=
ote:
>
> Hi list,
>
> I have a RAID1 Btrfs (on sdb and sdc) behind bcache (on nvme0n1p4):
>
> [jdg@tiare ~]$  lsblk -o NAME,UUID,SIZE,MOUNTPOINT
> NAME           UUID                                   SIZE MOUNTPOINT
> sdb            8ae3c26b-6932-4dad-89bc-569ae2c74366   3,7T
> =E2=94=94=E2=94=80bcache1      c5b8386b-b81d-4473-9340-7b8a74fc3a3c   3,7=
T
> sdc            7ccac426-dc8c-4cb3-9e64-13b1cf48d4bf   3,7T
> =E2=94=94=E2=94=80bcache0      c5b8386b-b81d-4473-9340-7b8a74fc3a3c   3,7=
T
> nvme0n1                                             119,2G
> =E2=94=9C=E2=94=80nvme0n1p1    1725-D2D0                              512=
M /boot/efi
> =E2=94=9C=E2=94=80nvme0n1p2    d3cc080c-0c3f-4191-a25d-7c419e00316a    40=
G /
> =E2=94=9C=E2=94=80nvme0n1p3    572b43a3-7690-4daa-beeb-d1c030f194e8    16=
G [SWAP]
> =E2=94=94=E2=94=80nvme0n1p4    a3ed0098-36b4-46a6-8e38-efe9b9a94e52  62,8=
G <- bcache
>
> The Btrfs filesystem is used for /home (one subvolume per user).
>
> An error happened during the nightly backup on nvme0 (see below) and
> Btrfs went readonly. After reboot, it refused to mount.
>
> I'm on Fedora-32 with kernel-5.9.7, and I compiled latest btrfs-progs:
>
> [root@tiare btrfs-progs-5.9]# ./btrfs -v check  /dev/bcache0
> Opening filesystem to check...
> parent transid verify failed on 3010317451264 wanted 29647859 found 29647=
852
> parent transid verify failed on 3010317451264 wanted 29647859 found 29647=
852
> parent transid verify failed on 3010317451264 wanted 29647859 found 29647=
852
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system
>
> I have restored from backups on a different disk, but still, I would be
> interested in trying to restore the broken filesystem: what should I try?
>
> /var/log/messages :
> Nov 11 00:24:28 tiare kernel: nvme nvme0: I/O 0 QID 5 timeout, aborting
> Nov 11 00:24:28 tiare kernel: nvme nvme0: I/O 1 QID 5 timeout, aborting
> Nov 11 00:24:28 tiare kernel: nvme nvme0: I/O 2 QID 5 timeout, aborting
> Nov 11 00:24:28 tiare kernel: nvme nvme0: Abort status: 0x0
> Nov 11 00:24:28 tiare kernel: nvme nvme0: I/O 3 QID 5 timeout, aborting
> Nov 11 00:24:28 tiare kernel: nvme nvme0: I/O 4 QID 5 timeout, aborting
>   ...
> Nov 11 00:24:58 tiare kernel: nvme nvme0: I/O 0 QID 5 timeout, reset
> controller
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333328 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from
>   cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333344 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333384 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333424 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333464 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 153333520 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 142766872 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_io_errors() nvme0n1p4:
> IO error on reading from cache, recovering.
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 142766888 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_cache_set_error() error on
> db563a68-d350-4eaf-978b-eee7095543c5: nvme0n1p4: too many IO errors
> reading from cache#012, disabling caching
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 142766912 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: blk_update_request: I/O error, dev
> nvme0n1, sector 142766936 op 0x0:(READ) flags 0x80700 phys_seg 1 prio
> class 0
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: conditional_stop_bcache_device()
> stop_when_cache_set_failed of bcache1 is "auto" and cache is dirty, stop
> it to avoid potential data corruption.
> Nov 11 00:24:58 tiare kernel: bcache: conditional_stop_bcache_device()
> stop_when_cache_set_failed of bcache0 is "auto" and cache is dirty, stop
> it to avoid potential data corruption.
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 1, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 2, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 3, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 4, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: BTRFS error (device bcache0): bdev
> /dev/bcache0 errs: wr 3, rd 5, flush 0, corrupt 0, gen 0
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: bcache: bch_count_backing_io_errors() sdc:
> Read-ahead I/O failed on backing device, ignore
> Nov 11 00:24:58 tiare kernel: nvme nvme0: 8/0/0 default/read/poll queues


Hypothesis: The NVMe drive has had some kind of failure, and since
this single NVMe is used as cache for both HDDs, in effect this
thwarts the raid1 protection of Btrfs. i.e. you don't have complete
hardware isolation by having dedicated SSD's to use as cache for each
HDD. Something went wrong, and it's adversely affected the writes to
both drives. Btrfs is reporting write errors for both bcache0 and
bcache1 at the same time.

I don't know for sure what the next step is, so my strong advice is to
make no changes until the problem and path forward is well understood.
The more things are changed at this point, the greater the likelihood
of non-recovery. Importantly, I'd say whatever you do should be
reversible, until you get superior advice.

You might consider reposting or cross-posting on the bcache list and
see if they have some advice for recovery, or maybe it's safer to just
decouple bcache, and once the HDDs are freed to see if Btrfs can
recover on its own.


--=20
Chris Murphy
