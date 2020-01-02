Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79C712F1C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 00:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgABXWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 18:22:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52472 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgABXWz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 18:22:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so6995123wmc.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0oJAM/R5JE5xW4i1s/Ai8HVdJaC5TJfX4f48vrvMMg=;
        b=HXbG1AjrHMNK+g2pHhL32BGkonREFc3DqhLBLCTxN4gokci7ORmwN1Lrl/C9bZFgGk
         1ZMm95pCtKjt6GBUbs+lo4VGj5QGbY0npOEzmfV/36NsaIdivpU8JcUheSZxf60SvGza
         O2ybxMqSKU9fgbyaFqTEw2lwpqAqrpV6J8/2gP4FkpiHRsml33hgBNogCDNJOK72YMuA
         29pJ/zIC1kUR41b1xVw6J9eAS7VYLomRWk1P8V5/elblyBXog5b7KWfLIMEWj0oAtMwE
         S8y24g7c6LO9NH8D7iQFu4EQeuSAFquPn9ywS7LWz3Jwb/e4X8zEyUfqUDwHtFaNwuzz
         jfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0oJAM/R5JE5xW4i1s/Ai8HVdJaC5TJfX4f48vrvMMg=;
        b=nGR3MkaQiCv39OifefqRRKBtHeFoLvOMY0jiof8i8GlSmJbjT6cTMOlIuJUJKgFxbG
         YUt5w4QFLgnvWt1+n/bcymgUQRE/RRtrM/RGJusBXIcFya9pQc8wSAcvj4lJQpyPqiz9
         6e1nx6UcaBkfyUjkWLTVGxff281BkWKtLe7IgHbSDFym7ZSwlI0CnevHAhuij0gMBlcP
         6vGUEIyCnNWnv2DihVyJjIa7ZFkgN8whc4KwZIdIWdZv3J61e4unKonoX+wejGl691t3
         cmykUt0p0EXjuSdClAARKe5uIiRSCuEUC/DSiQOFK5Oq4E4Nd6hf2zpVIMgBhE7X0Sw+
         XpGA==
X-Gm-Message-State: APjAAAXJKpF87mjc9giAhyfJ9Jvg5I3cedIP2hgcYHtQiP70PFJolsbW
        JHCi6NMcxCBMfUCCfDMvTLdf0qB3m5vTdez5JFr8hm9P9VMJ8Q==
X-Google-Smtp-Source: APXvYqybwsm5Nt7GJMH8IC0bOOt3hRVBEVsC+VZMK1n6oBWO1MUVDIClaMHCuBKdzdAiHrC7fCA96MQggReOVuWzQ7w=
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr15863022wmb.160.1578007373484;
 Thu, 02 Jan 2020 15:22:53 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com> <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
In-Reply-To: <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 Jan 2020 16:22:37 -0700
Message-ID: <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
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

On Thu, Jan 2, 2020 at 3:39 PM Leszek Dubiel <leszek@dubiel.pl> wrote:

>  > Almost no reads, all writes, but slow. And rather high write request
>  > per second, almost double for sdc. And sdc is near it's max
>  > utilization so it might be ear to its iops limit?
>  >
>  > ~210 rareq-sz = 210KiB is the average size of the read request for
> sda and sdb
>  >
>  > Default mkfs and default mount options? Or other and if so what other?
>  >
>  > Many small files on this file system? Or possibly large files with a
>  > lot of fragmentation?
>
> Default mkfs and default mount options.
>
> This system could have a few million (!) of small files.
> On reiserfs it takes about 40 minutes, to do "find /".
> Rsync runs for 6 hours to backup data.

There is a mount option:  max_inline=<bytes> which the man page says
(default: min(2048, page size) )

I've never used it, so in theory the max_inline byte size is 2KiB.
However, I have seen substantially larger inline extents than 2KiB
when using a nodesize larger than 16KiB at mkfs time.

I've wondered whether it makes any difference for the "many small
files" case to do more aggressive inlining of extents.

I've seen with 16KiB leaf size, often small files that could be
inlined, are instead put into a data block group, taking up a minimum
4KiB block size (on x64_64 anyway). I'm not sure why, but I suspect
there just isn't enough room in that leaf to always use inline
extents, and yet there is enough room to just reference it as a data
block group extent. When using a larger node size, a larger percentage
of small files ended up using inline extents. I'd expect this to be
quite a bit more efficient, because it eliminates a time expensive (on
HDD anyway) seek.

Another optimization, using compress=zstd:1, which is the lowest
compression setting. That'll increase the chance a file can use inline
extents, in particular with a larger nodesize.

And still another optimization, at the expense of much more
complexity, is LVM cache with an SSD. You'd have to pick a suitable
policy for the workload, but I expect that if the iostat utilizations
you see of often near max utilization in normal operation, you'll see
improved performance. SSD's can handle way higher iops than HDD. But a
lot of this optimization stuff is use case specific. I'm not even sure
what your mean small file size is.

> # iotop -d30
>
> Total DISK READ:        34.12 M/s | Total DISK WRITE: 40.36 M/s
> Current DISK READ:      34.12 M/s | Current DISK WRITE:      79.22 M/s
>    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
>   4596 be/4 root       34.12 M/s   37.79 M/s  0.00 % 91.77 % btrfs

Not so bad for many small file reads and writes with HDD. I've see
this myself with single spindle when doing small file reads and
writes.


-- 
Chris Murphy
