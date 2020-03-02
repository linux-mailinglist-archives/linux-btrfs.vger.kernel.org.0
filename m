Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22E175172
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 02:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBBKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 20:10:52 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36488 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCBBKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 20:10:52 -0500
Received: by mail-wm1-f46.google.com with SMTP id g83so6908951wme.1
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 17:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIYE1IjrQXRB85Du+J/Econ2DAScz0OONy8Sth6O2MM=;
        b=1SKoz4z1XgeDxUJNAdX6XzSf93sC+kkVwbePxaMSL/OEtw1/lRPRll9lzX9sjIjmq8
         U9M5fOWqkX4lroNSMgoyrR1Zqzipetkh4t+yTo391KaahZ6OxxoHP7R/NNLiWzViq+PP
         QT3YPq1KCoMzR/UDQ7UHzlR5N9iEIse6wRw/JJw2Z4Zgg6NktI/Iv8l1lF92zZy+BbP6
         aw9ZE6VX5HkSk+ZvfPY1GlZRZjlQpe2Jq6TFJKMnt8T9pRHHN1KITiCayNH+6bUccE81
         WFKXYC75EqDo0pq3YeHqbmdwrCyGPYSDWg1EcuMsHYdXOAUFGkSKS7cpAh4U3ynii96M
         ii+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIYE1IjrQXRB85Du+J/Econ2DAScz0OONy8Sth6O2MM=;
        b=I8q/tREV/HXn/nDi9qht0mLOytn5Q8J0NCJDAr9QGQ5uI00LIrBAzfqHm3TOSpxL36
         kQhGNAZ/5FlcW6KzMeRGeGlLfcuekC5EFjQ3m68y2Ko+trG89zUD+z/87sCsXi8e9URR
         LsgtfoO2PEssJTXXTPdTlgKSD2V+ILJ/1ijCCr67QJ/BNLW0171U4FAEItCTLXDwTYR4
         EYeC5pAOqJ0VuoY2gVGlzjeIcLpK0ORhklFpAP/TxQuM9nE58N4h7rCwJOsfgNG2GXRX
         xHf7KVFWRc3W06nf2qes5qiUDwFZN3LORipGXFO7KJ9WyTofXYqDQ0ApFmfv/F1Vp/fw
         zVDQ==
X-Gm-Message-State: APjAAAW5ISP97KtLy69BjAoenRwB4e/AX/mviiAjjIotWa66Zha+UCKL
        Rv7brQJ4SdEpZHX91VDj2ShRRmm5FbflTN+kHp+Dvg==
X-Google-Smtp-Source: APXvYqzkdrM48GyYLt8u/4JSSF0t13zl0PS20vd/zcwfCzP1LNM+0dMtP1mOruzV7cbzf1SVFMFMXUOPFVJgglsrROE=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr9984017wmf.168.1583111449723;
 Sun, 01 Mar 2020 17:10:49 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
In-Reply-To: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 18:10:33 -0700
Message-ID: <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 1:32 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
>
> (Is this just taking really long because I didn't provide filters when
> balancing across the new drive?)

I don't think so. It might be fairly wedged in because it has no
unallocated space on 3 of 4 drives, and is writing into already
allocated block groups.

I think the mistake was adding only one new drive instead of two *and*
then also doing a balance.

I also think it's possible there's a bug, where Btrfs is trying too
hard to avoid ENOSPC. Ironic if true. It should just give up, or at
least it should cancel faster.

>
> $ sudo btrfs fi show /.BACKUPS/
> Label: 'BACKUPS'  uuid: cfd65dcd-2a63-4fb1-89a7-0bb9ebe66ddf
>         Total devices 4 FS bytes used 3.64TiB
>         devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
>         devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
>         devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1
>         devid    5 size 3.64TiB used 8.31MiB path /dev/sdj1

This suggests 3 of 4 are full.



> $ sudo btrfs fi usage /.BACKUPS/
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.28TiB
>     Device unallocated:            3.64TiB
>     Device missing:                  0.00B
>     Used:                          7.27TiB
>     Free (estimated):              1.82TiB      (min: 1.82TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,RAID1: Size:3.63TiB, Used:3.63TiB
>    /dev/sda1       1.82TiB
>    /dev/sdb1       3.63TiB
>    /dev/sdc1       1.82TiB
>    /dev/sdj1       8.31MiB
>
> Metadata,RAID1: Size:5.00GiB, Used:3.88GiB
>    /dev/sda1       3.00GiB
>    /dev/sdb1       5.00GiB
>    /dev/sdc1       2.00GiB
>
> System,RAID1: Size:32.00MiB, Used:736.00KiB
>    /dev/sda1      32.00MiB
>    /dev/sdb1      32.00MiB
>
> Unallocated:
>    /dev/sda1       1.00MiB
>    /dev/sdb1       1.00MiB
>    /dev/sdc1       1.00MiB
>    /dev/sdj1       3.64TiB

Free is 1.82 exactly half of  unallocated on one drive and no
unallocate on the other drives, so yeah this file system is 100% full.
Adding one drive was not enough, it's raid1. You needed to add two
drives.

So now what? The problem is you have a balance in-progress, and a
cancel in-progress, and I'm not sure which is less risky:

- add another device, even if it's small like a 32G partition or flash drive
- force reboot

What I *would* do before you do anything else is disable the write
cache on all the drives. At least that way if you have to force a
reboot, there's less of a chance COW and barrier guarantees can be
thwarted.

Be careful with hdparm, small w is dangerous, capital W is what you want.

-- 
Chris Murphy
