Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7699A3ADB73
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jun 2021 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhFSStw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Jun 2021 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhFSStt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Jun 2021 14:49:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C3C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Jun 2021 11:47:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso10857679wmi.3
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Jun 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SZZCqhoQrYULpJSKkzipt+6cJfJN+usDRO4uKe6lfg=;
        b=MfSBEoe6U1Xpw0/pAFCGIOwvTbBvFN0mbphq41h5DV3QFtueIeZn6qn7eIEL+RkM2H
         eTKhOJYZPNpi6riV70XOKQYY7ba6H5NBs3Z0EMoIz6c0OqxbP6yBRouu/wUXEtnH+tjQ
         Z8e5nkiXchoYGqxr4K4brIK6cczJqn32bO3er4ti5iAZKjt8d8KZkc2plaqu7FAKtRlY
         SRBSBAoOOANCkvMkyZFDvAfB8bPts4RLuXOax1CHzIqRhBT2Mi2iFLM0cryE1fbp0lRX
         KwEm2vS1s6ID9lsLEFNTBUUou2dRZPKue7Vdas/+FViFwi3/02cnSMrJWM241IGZJPME
         T0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SZZCqhoQrYULpJSKkzipt+6cJfJN+usDRO4uKe6lfg=;
        b=gvYQN6KSuY32/9RQDumwkcwRmPjBjVOf7FWDUY8+moO0QoW8JyiSnrCEzyJUFF4H58
         px1DeShgHan3cVmlJ9I6NtbP45OOqi95tjtwjTdxNU4hoW1SiMNEv+x52dwTmHKgrTgu
         I7Le5dNcSpJlTIctQrbYF1G0kU/7OX+126zByRWlTOVYmCViFfH/i9HbDvE07O35kEKX
         8q4mxKKXsf6lN6Ht1uh5sMq0iVInu6JqXX2KugSRLvGFfzqxuBNZBDdDEr+adnkCrXgb
         hFlygyj0I92OzEEb9CPipCthj7kTmdvTOeIPp7ZPvKFqZss2owbFpxLKgirb25YG5PZJ
         ASYQ==
X-Gm-Message-State: AOAM532y7eQUqWAlF2y3ghnwdCx5xs+l82FzI2EZQ/YHzTcgAa3jYmbv
        r4285mBVGf+MbhJtqnZFcmESUMZAsuRI9bpDGJkdKA==
X-Google-Smtp-Source: ABdhPJyhvxJl8bA0j6/xeNqpEI01rhZZkfnEscV+9mP9HdIU6Gd8zDaHDznox4TRxjYdI5Ebua0jQ9KTDDIUHZvHJB4=
X-Received: by 2002:a05:600c:5122:: with SMTP id o34mr17912916wms.168.1624128454512;
 Sat, 19 Jun 2021 11:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
In-Reply-To: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 19 Jun 2021 12:47:18 -0600
Message-ID: <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>>>
[  460.053212] BTRFS info (device sdf): bdev /dev/sdf errs: wr
1298641, rd 7847, flush 5, corrupt 13, gen 0
[  460.053234] BTRFS info (device sdf): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 231, gen 0
[  460.053245] BTRFS info (device sdf): bdev /dev/sdg errs: wr 957680,
rd 477125, flush 3, corrupt 51358, gen 719
[  460.053255] BTRFS info (device sdf): bdev /dev/sdd errs: wr
3620417, rd 304456, flush 8, corrupt 164, gen 0
[  460.053264] BTRFS info (device sdf): bdev /dev/sdp errs: wr 0, rd
0, flush 0, corrupt 271, gen 0
[  460.053272] BTRFS info (device sdf): bdev /dev/sdl errs: wr 0, rd
0, flush 0, corrupt 404, gen 0
[  460.053279] BTRFS info (device sdf): bdev /dev/sdb errs: wr 0, rd
0, flush 0, corrupt 111, gen 0
[  460.053287] BTRFS info (device sdf): bdev /dev/sda errs: wr 0, rd
0, flush 0, corrupt 553, gen 0
[  460.053295] BTRFS info (device sdf): bdev /dev/sdn errs: wr 0, rd
0, flush 0, corrupt 1613, gen 0
[  460.053302] BTRFS info (device sdf): bdev /dev/sde errs: wr 0, rd
0, flush 0, corrupt 369, gen 0
[  460.053310] BTRFS info (device sdf): bdev /dev/sdm errs: wr 0, rd
0, flush 0, corrupt 175, gen 0
[  460.053317] BTRFS info (device sdf): bdev /dev/sdc errs: wr 0, rd
0, flush 0, corrupt 1663, gen 0
[  460.053325] BTRFS info (device sdf): bdev /dev/sdo errs: wr
189088938, rd 10028589, flush 0, corrupt 1037856, gen 698
[  814.681305] BTRFS info (device sdf): balance: resume skipped
>>>

I'm guessing these are stale because there aren't any other messages
indicating these counts are going up. You can optionally clear them
with 'btrfs dev stats -z'. It's personal preference, but I figure once
an array is healthy, these should be zero'd out because as soon as the
counts change from 0, it's important to find out what's going on.

>>>
Data, RAID1: total=37.59TiB, used=36.98TiB
Data, RAID6: total=13.77TiB, used=13.75TiB
System, RAID1C4: total=32.00MiB, used=12.97MiB
Metadata, RAID1C4: total=66.00GiB, used=65.63GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
>>>

The file system is pretty full and also has mixed profile for data. I
have no idea if that's causing additional confusion related to the no
free space error.

> [  814.681305] BTRFS info (device sdf): balance: resume skipped

Is there a balance in progress? Conversion between profiles? And if
so, are you converting to raid1 or to raid6? Related operations are
filesystem resize, and device remove.

You might explicitly cancel the balance, and start a new one to free
up some space in data block groups. I think what's going on is it
wants to allocate another metadata block group but because it's
raid1c4, it can't allocate a 1GiB chunk on four devices, because
there's no more unallocated space.

btrfs balance start -dlimit=5 /mntpoint

btrfs fi usage /mntpoint

Then see if something like

btrfs balance start -dusage=1 /mntpoint

And increment this by 1 until 'usage' shows that you have enough
unallocated space for the operation to complete. You need at least 1
GiB unallocated on at least four drives for a metadata block group to
be allocated. And then you need ~2 GiB on at least two drives for data
if you're converting to raid1. Definitely don't balance metadata,
it'll make the problem worse.

--
Chris Murphy
