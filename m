Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDA1D5BC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEOVq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgEOVq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 17:46:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0AC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 14:46:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so5068547wrp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tLLDSwQt0DHF/cadf1ymiNMIp9/K+AS6UUlx1vDX8KY=;
        b=khTtKQPmq7LjJaA4/sV1MblwHw0jXi7V9BfUlyET1KFJhjl/3PyeRd0XQ8zWqT8IP7
         uCtqM6qQKNY/b+BJ9f/KGtWXGgCof+piEBX+NnlOXSrffUE6d2duyFfG/PfhCpX5/jlg
         YFLupHUDPNs31KDrVmnc/WNPZHz4LjED5LaSEH8Z+BJRxIxSbUMlD0ftEapewyCD8WkP
         NgpiLf7sWKlJlEGzdG4/Qb8ZNHGFptmIE11Nk/mwmt8CvJ2bw1psxUFGfDWNYyZmK5hk
         9HYqPF0WaN9PZbn6I4Kkl7wE4sy3hkAW8TU495M1X1olhmGlb6tu0qtvtqhbgPhumb67
         bikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tLLDSwQt0DHF/cadf1ymiNMIp9/K+AS6UUlx1vDX8KY=;
        b=Xz0l5N0U71AhOy5e7cCQ/qFFxJTVrKSe/rvBo/OvSoRHMkyl5yDpoWQGi7AM124dwj
         FFZXKQ24DVugC3vh3E4mzwFZEWU52EUu0I3Tg6dTRCqITJwidKje2aUV8iX2ZnzsfzvU
         SsT9CLEZZN7ftHIFjr3L8b+XBkbsxY7FTf7ImFwCiM2zh1smRYoFEqeyX7FLlGZPHt7i
         eCKZaaUpkYTGj2xfTh0y/Tn0NUsYEeL/UljV9dvR2K0nqcENNjFdGk/AQ+sbU7MPhFtC
         z1uxgN+cj85cVinDGhbSto5z+qzhYd6JMUdiR1THSek0tYZhNeT8O7zzN06rObOYdHfZ
         ewWQ==
X-Gm-Message-State: AOAM532Cwdhq40TK3ZRztgjssZDsjfAQ9gQCtpRqJOqmU8xOO8Z9n8te
        +LJDUBPv9KGT4IIVzwFGGXXp1q7UeE3JrLA8cjtDXQ==
X-Google-Smtp-Source: ABdhPJxcmrxo3HR6p/jMMZ++aAl05RaIuaGkAwEtCVkrlxGM8TEa6dKpUjC5hHgJtUAqgucVTwDAk+KmfXZvG4VoYsY=
X-Received: by 2002:adf:e688:: with SMTP id r8mr6263459wrm.274.1589579214206;
 Fri, 15 May 2020 14:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
In-Reply-To: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 15 May 2020 15:46:38 -0600
Message-ID: <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify failed)
To:     Emil Heimpel <broetchenrackete@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 15, 2020 at 12:03 AM Emil Heimpel
<broetchenrackete@gmail.com> wrote:
>
>
> Hi,
>
> I hope this is the right place to ask for help. I am unable to mount my B=
TRFS array and wanted to know, if it is possible to recover (some) data fro=
m it.

Hi, yes it is!


>
> I have a RAID1-Metadata/RAID5-Data array consisting of 6 drives, 2x8TB, 5=
TB, 4TB and 2x3TB. It was running fine for the last 3 months. Because I exp=
anded it drive by drive I wanted to do a full balance the other day, when a=
fter around 40% completion (ca 1.5 days) I noticed, that one drive was miss=
ing from the array (If I remember correctly, it was the 5TB one). I tried t=
o cancel the balance, but even after a few hours it didn't cancel, so I tri=
ed to do a reboot. That didn't work either, so I did a hard reset. Probably=
 not the best idea, I know....

The file system should be power fail safe (with some limited data
loss), but the hardware can betray everything. Your configuration is
better due to raid1 metadata.
>
> After the reboot all drives appeared again but now I can't mount the arra=
y anymore, it gives me the following error in dmesg:
>
> [  858.554594] BTRFS info (device sdc1): disk space caching is enabled
> [  858.554596] BTRFS info (device sdc1): has skinny extents
> [  858.556165] BTRFS error (device sdc1): parent transid verify failed on=
 23219912048640 wanted 116443 found 116484
> [  858.556516] BTRFS error (device sdc1): parent transid verify failed on=
 23219912048640 wanted 116443  found 116484
> [  858.556527] BTRFS error (device sdc1): failed to read chunk root
> [  858.588332] BTRFS error (device sdc1): open_ctree failed

Extent tree is damaged, but it's unexpected that a newer transid is
found than is wanted. Something happened out of order. Both copies.

What do you get for:
# btrfs rescue super -v /dev/anydevice
# btrfs insp dump-s -fa /dev/anydevice
# btrfs insp dump-t -b 30122546839552 /dev/anydevice
# mount -o ro,nologreplay,degraded /dev/anydevice



>
> [bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdd1

For what it's worth, btrfs check does find all member devices, so you
only have to run check on any one of them. However, scrub is
different, you can run that individually per block device to work
around some performance problems with raid56, when running it on the
volume's mount point.

> And how can I prevent it from happening again? Would using the new multi-=
parity raid1 for Metadata help?

Difficult to know yet what went wrong. Do you have dmesg/journalctl -k
for the time period the problem drive began all the way to the forced
power off? It might give a hint. Before doing a forced poweroff while
writes are happening it might help to disable the write cache on all
the drives; or alternatively always disable them.

> I'm running arch on an ssd.
> [bluemond@BlueQ btrfslogs]$ uname -a
> Linux BlueQ 5.6.12-arch1-1 #1 SMP PREEMPT Sun, 10 May 2020 10:43:42 +0000=
 x86_64 GNU/Linux
>
> [bluemond@BlueQ btrfslogs]$ btrfs --version
> btrfs-progs v5.6

5.6.1 is current but I don't think there's anything in the minor
update that applies here.

Post that info and maybe a dev will have time to take a look. If it
does mount ro,degraded, take the chance to update backups, just in
case. Yeah, ~21TB will be really inconvenient to lose. Also, since
it's over the weekend, and there's some time, it might be useful to
have a btrfs image:

btrfs-image -ss -c9 -t4 /dev/anydevice ~/problemvolume.btrfs.bin

This file will be roughly 1/2 the size of file system metadata. I
guess you could have around 140G of metadata depending on nodesize
chosen at mkfs time, and how many small files this filesystem has.

Still another option that might make it possible to mount, if above
doesn't work; build the kernel with this patch
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715

Mount using -o ro,nologreplay,rescue=3Dskipbg

This also doesn't actually fix the problem, it just might make it
possible to mount the file system, mainly for updating backups in case
it's not possible to fix.


--
Chris Murphy
