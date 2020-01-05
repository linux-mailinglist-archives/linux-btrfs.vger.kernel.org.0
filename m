Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BB130581
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 03:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAECXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 21:23:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAECXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 21:23:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so11647175wmc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2020 18:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8n2Luax5tOE0OeEhTsswMU/g8Ts9z30GUeuBN5fKEA=;
        b=UuGEjCUx34gOmDVUA0LKcF8OVueZe7sBwTht0bxsyc9RJ3i47CwXHTC8caQWHtG9kH
         h6DhoHuwTA+KWhA1QnxZdo7o9BKUbqcmuBt3Tj8Dc75oJBzlVCCJR8v4hBGrcC/wCmTh
         EZNyphN1goSS9NGkybGWkoDVnkKWwc/OuiXnQni1T2VJ5T//35Tsf1/YfeWntuQ/D/EZ
         VhE+5GEuKe9evsFtDfTbjtSQeQoJRa6fXAv+wp+HUjwk9UcUkZRRYvql7b5BdK6g9tza
         3Pv1oxpljDQoc9u7e27NQ7GwiI8DvWecW6YOK/o3O5i1GUYxcZdb39k+MJKKgi4/o/oq
         qb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8n2Luax5tOE0OeEhTsswMU/g8Ts9z30GUeuBN5fKEA=;
        b=QV85g4sKoU964Q3X1olbzojRShFL8JY9QfP93mLUJF6EbVu4D4GuDRjpPBIYOCLtWf
         vibH3aTU2Fla1iCatv1d7LvnTnKjJ6BrFhjhKmGzOApi6vqlhC0wtKjSojqUdj5AfrZb
         Taw819U/awJTCb8KCITWi9NDCOytegxh8/ovelj90sILDl2CLK+LzBDbMaSWV5YiNY6r
         N0Np1tira0lJYm1Sqztod7rfcZaWreTRjIlzwy08tU8GmNeGky0NncQ8AE8/ZVWozx6o
         ekej8HdEDNNvJakKmb7EGleIRljiT9HLTAvFL2dDcT4D+ItZajS2cMLTU0+RvOM3rf/k
         YfZg==
X-Gm-Message-State: APjAAAXVoK0L/UUBy0olfUUhJh44mSKA3pjIXIH5swv7QRVWkY02YYFt
        r+CD/YUl6ovI211HikugJ6DLwKfudguCaQQqt4IFgA==
X-Google-Smtp-Source: APXvYqwGy2qbSt3hHiWJ2VGuUWmO2mc21VX3zrBgFk1M2DVaLdUjPBadbyT5pfAGIq4RNSv1WkbrYCDsfNjP8lTo4Tw=
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr27238846wmm.44.1578190987022;
 Sat, 04 Jan 2020 18:23:07 -0800 (PST)
MIME-Version: 1.0
References: <CADy2AqZvJHP3YtCvUNNtCY-RopecWiTrBwDO15vTbQMqA3EGeQ@mail.gmail.com>
In-Reply-To: <CADy2AqZvJHP3YtCvUNNtCY-RopecWiTrBwDO15vTbQMqA3EGeQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 4 Jan 2020 19:22:51 -0700
Message-ID: <CAJCQCtSp1L0Hps2GY8OR6awzzfiwQ=5tuOzO1fq0OsWnXbRNKg@mail.gmail.com>
Subject: Re: Read time tree block corruption not detected by btrfs check
To:     Vladimir <amigo.elite@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 4, 2020 at 6:31 PM Vladimir <amigo.elite@gmail.com> wrote:
>
> Dear BTRFS community,
>
> I hit a strange issue: btrfsck unable to detect any errors, but I'm
> also unable to mount this "sane" (by the btrfsck opinion) BTRFS
> partition.
>
> Long story short: at some point, I had to forcefully power off my
> laptop due to near-OOM hang with very intensive swapping caused by
> starting the memory-hungry app.
> This happened on 5.4.0-1.el7.elrepo.x86_64 kernel.
>
> After reboot I was unable to mount my data partition (/dev/stripe/data):
> [29798.631579] BTRFS info (device dm-11): disk space caching is enabled
> [29798.631581] BTRFS info (device dm-11): has skinny extents
> [29798.637910] BTRFS info (device dm-11): bdev
> /dev/mapper/stripe-data--snap2 errs: wr 0, rd 11, flush 0, corrupt
> 3452, gen 0
> [29798.677872] BTRFS critical (device dm-11): corrupt leaf:
> block=1651991592960 slot=16 extent bytenr=93983342592 len=524288
> invalid generation, have 140287904167864 expect (0, 6389777]
> [29798.677875] BTRFS error (device dm-11): block=1651991592960 read
> time tree block corruption detected

What do you get for

btrfs insp dump-t -b 1651991592960 /dev/

I'm not sure why the tree checker can find this problem but not btrfs
check. Can you try 'btrfs check --mode=lowmem' and see if you get
different results?


-- 
Chris Murphy
