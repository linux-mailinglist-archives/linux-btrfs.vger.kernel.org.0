Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7070712FCE3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgACTPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 14:15:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53949 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgACTPg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 14:15:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so9245956wmc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHDXJARR3JQjfrqUeoRSQj4NwXOGis2r6SnE2wKGFCw=;
        b=Qm9IrdXv8cdiNQ3OwqNyTR9MMb32kxYQtkBCaJo/NA1HiLPh67C7QQm4JxghQevIi+
         /gBuJMyEd55vvjMxoUft8Jook3im7fhdPfcf3flOMzQXNP5j12ekqRmswh4R1mCs1BJe
         EpVlF6BwFBQJDZ3dxJajHP+F8Yg3f7N0dDKdESxFu0sQA4D/PA3SGbLhPJtKQa4wf6Pt
         kIRWLwEL71a9F/i+BMUxaBC0TkY2FtAHmKinGJ0lqRTwGbpL5JPUE1imyFY6IeXXTZh8
         ckMILuTIax02j6J/w6bP+y06wzYjcqA8i9T96y1XugE+0yX9MQSaEL+31xWphD1z+kie
         xNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHDXJARR3JQjfrqUeoRSQj4NwXOGis2r6SnE2wKGFCw=;
        b=KCxOeAaiPeSEyAaEg4UQRP2eV72DWhCxaXSrLH6F5zpiL/su3xeDZwIT2c+2WZFlRZ
         zTX2pVwoWG9OdCwjXReJADS9G9gtFEhDFrU8q8QNiKLov6QZ2fjio8fnc6uyhSPEls5w
         SFNl6JSihXL32DJ+p66k94MILmStV40ctUE2IrkDcGd4QCazg0DQrNyE9FKICkIjkLqA
         mfM5AdpFxKfs51D/oB65WATB2xnuohTd6q5l6VKbGSytXqc5KPMs+r36K2SmFzLf0AOl
         ovzp3g1ioqXJpyntb69ya+lSTOcu4/3MlhCtiFIIYvklLq68jr2yGFgKKsJqjVIMuImm
         Kq9w==
X-Gm-Message-State: APjAAAXsFUijsjFrHg+/eKHGaeN+xjyHFbWgP3BbEHx2qfjwZuXNMnAw
        P+dbdOjTZgReRC1ySDrO+V9GHDWyiK0T8OwbQQngNg==
X-Google-Smtp-Source: APXvYqztDPvG5DeBrJQwSuqJa0bA457INGOwPXA0trp7DWa3go9LLSmJ1BTAU6Lg1c2dF4kC0D0YuDQXzmMHljDXalY=
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr20757912wmb.160.1578078933576;
 Fri, 03 Jan 2020 11:15:33 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl> <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <283b1c8a-9923-4612-0bbf-acb2a731e726@dubiel.pl>
In-Reply-To: <283b1c8a-9923-4612-0bbf-acb2a731e726@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Jan 2020 12:15:17 -0700
Message-ID: <CAJCQCtSG0nEEahu+KLxKCu3LYWFaA4Tp77Ai1NDmSSdtGc0w7g@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 3, 2020 at 2:08 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
>  >> # iotop -d30
>  >>
>  >> Total DISK READ:        34.12 M/s | Total DISK WRITE: 40.36 M/s
>  >> Current DISK READ:      34.12 M/s | Current DISK WRITE:      79.22 M/s
>  >>    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN IO> COMMAND
>  >>   4596 be/4 root       34.12 M/s   37.79 M/s  0.00 % 91.77 % btrfs
>  >
>  > Not so bad for many small file reads and writes with HDD. I've see
>  > this myself with single spindle when doing small file reads and
>  > writes.

It's not small files directly. It's the number of write requests per
second, resulting in high latency seeks. And the reason for the
seeking needs a second opinion, to be certain it's related to small
files.

I'm not really sure why there are hundreds of write requests per
second. Seems to me with thousands of small files, Btrfs can aggregate
them into a single sequential write (mostly sequential anyway) and do
the same for metadata writes; yes there is some back and forth seeking
since metadata and data block groups are in different physical
locations. But hundreds of times per second? Hmmm. I'm suspicious why.
It must be trying to read and write hundreds of small files *in
different locations* causing the seeks, and the ensuing latency.

The typical work around for this these days is add more disks or add
SSD. If you add a fourth disk, you reduce your one bottle neck:


> root@wawel:~# btrfs dev usag /
> /dev/sda2, ID: 2
>     Device size:             5.45TiB
>     Device slack:              0.00B
>     Data,RAID1:              2.62TiB
>     Metadata,RAID1:         22.00GiB
>     Unallocated:             2.81TiB
>
> /dev/sdb2, ID: 3
>     Device size:             5.45TiB
>     Device slack:              0.00B
>     Data,RAID1:              2.62TiB
>     Metadata,RAID1:         21.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             2.81TiB
>
> /dev/sdc3, ID: 4
>     Device size:            10.90TiB
>     Device slack:            3.50KiB
>     Data,RAID1:              5.24TiB
>     Metadata,RAID1:         33.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             5.62TiB

OK this is important. Two equal size drives, and the third is much
larger. This means writes are going to be IO bound to that single
large device because it's always going to be written to. The reads get
spread out somewhat.

Again, maybe the every day workload is the one to focus on  because
it's not such a big deal for a device replace to take overnight. Even
though it would be good for everyone's use case if it turns out
there's some optimization possible to avoid hundreds of write requests
per second, just because of small files.



-- 
Chris Murphy
