Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A97131CBC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 01:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAGAVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 19:21:44 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42340 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgAGAVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 19:21:44 -0500
Received: by mail-wr1-f46.google.com with SMTP id q6so51874082wro.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IX6CwBF88czASyV0L0SpXwKR7YyCN2TQN3zU5/bRgKY=;
        b=Mo0QiDvj3aDCNB4fGeOLO44cE07qId46J/XX9tlvwTw6lbnO86JX2VK9rElmwZgGdy
         W4afP5T797b7G+XXgBBIsVEPkPEkUJHaQ0wcieR6TL7yN7iKJToHddmRBgosWjruVqG5
         EMFEE7PmupzvmLpReSaOxM5mIxHGlVuQnmpHKdRqs/5W8rKWnFl2lyOZlj3kXwBH3hu5
         pz6M6vhYRwBCSRytjnZS6qNmL/e5LQxg4L8vKvZH5kyq/Kfma8MhILx+EnJ5WuHoRdn7
         yhVikLlxmgPORD8dWPd1noGcRvVHWJIuWK6xm/9mpsEndVyZScWbPJ28SyC7RyjMuIqW
         38qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX6CwBF88czASyV0L0SpXwKR7YyCN2TQN3zU5/bRgKY=;
        b=ULfo+3b8HhOFlBiQbzJR0A+IZbARAOV6jIVqd+hiCDoYOodaDZLQdk0DGd5E0N4m/S
         c+2wOJKN7IwHCxBDF82p23AeJbKRqDulUXck4XCVfkQxA118A9uZWCiEZI+8M27bMGQ3
         rLb521eTRc85CGPqQO4U0Y+RAgfsGms2mlsd8AuALsSVRamIj4ZMMsuEfYS+57NyGT1S
         GSONF73Db8APev97nFGcQqrfbMkFngSrFqlrq9/QtwfYzEsJyqGadoyL9YwG2puxRz/X
         WJQy7wT5imnKz+u6WHMzJEoQsGHeaB7jYR3OtezJ5U3Vr3yQg8Fd/asBf/to+NcwIr4T
         QfQQ==
X-Gm-Message-State: APjAAAVqlq6N7OFdku2niLtt0wDpPcAIIVcd2BlR3XIRUZursSbxdOM8
        ADX7PE2LeLTgqyV4h75ZDKFToHqdonnRCS/DQlANVkplbbg=
X-Google-Smtp-Source: APXvYqzxExROATak4uu0VjE5OCPaXl7RS8NuYTgS2lAjqgbtsgxwsDbUT0jYa+yJOp6C4rPSUkSAngON3ka3Pdn58KQ=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr109339678wrm.262.1578356501372;
 Mon, 06 Jan 2020 16:21:41 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com> <4aff5709-5644-daa8-08b9-94dcefe65b19@dubiel.pl>
In-Reply-To: <4aff5709-5644-daa8-08b9-94dcefe65b19@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 6 Jan 2020 17:21:25 -0700
Message-ID: <CAJCQCtT13m+k4aWWmmj_ysLpmr7U_5dKOowEy8JuSJKaBfM1Rg@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 6, 2020 at 4:14 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
>
>
> W dniu 02.01.2020 o 22:57, Chris Murphy pisze:
>
>  > but I would say that in retrospect it would have been better to NOT
>  > delete the device with a few bad sectors, and instead use `btrfs
>  > replace` to do a 1:1 replacement of that particular drive.
>
>
> Tested "replace" on ahother server:
>
>      root@zefir:~# btrfs replace start /dev/sde1 /dev/sdb3 /
>
> and speed was quite normal:
>
>      1.49 TiB * ( 1024 * 1024 MiB/TiB ) / ( 4.5 hours * 3600 sec/hour )
>          =     1.49 * ( 1024 * 1024 ) / ( 4.5 * 3600 )   =  96.44 MiB / sec
>
>
> Questions:
>
> 1. it is a little bit confusing that kerner reports sdc1 and sde1 on the
> same line: "BTRFS warning (device sdc1): i/o error ... on dev
> /dev/sde1"....

Can you provide the entire line? It's probably already confusing but
the ellipses makes it more confusing.


>
> # reduce slack
> root@zefir:~# btrfs fi resize 4:max /
> Resize '/' of '4:max'
> root@zefir:~# btrfs dev usage /
> ...
> /dev/sdb3, ID: 4
>     Device size:             1.80TiB
>     Device slack:            3.50KiB <<<<<<<<<<<<<<<<<<<<

Maybe the partition isn't aligned on a 4KiB boundary? *shrug*

But yeah one gotcha with 'btrfs replace' is that the replacement must
be equal to or bigger than the drive being replaced; and once
complete, the file system is not resized to fully utilize the
replacement drive. That's intentional because by default you may want
allocations to have the same balance as with the original device. If
you resize to max, Btrfs will favor allocations to the drive with the
most free space.


> Jan  5 13:52:09 zefir kernel: [1291932.446093] BTRFS warning (device
> sdc1): i/o error at logical 11658111352832 on dev /dev/sde1, physical
> 867246145536: metadata leaf (level 0) in tree 9109477097472


Ahh yeah I see what you mean. I think that's confusing also. The error
is on sde1. But I guess why sdc1 is reported first is probably to do
with the device the kernel considers mounted, there's not really a
good facility (or maybe it's in the newer VFS mount code, not sure)
for showing two devices mounted on a single mount point.



> [/dev/sda1].write_io_errs    10418
> [/dev/sda1].read_io_errs     227
> [/dev/sda1].flush_io_errs    117
> [/dev/sda1].corruption_errs  77
> [/dev/sda1].generation_errs  47

This isn't good either. I'd keep an eye on that. read errors can be
fixed up if there's a good copy, Btrfs will use the good copy and
overwrite the bad sector, *if* SCT ERC is lower duration than SCSI
command timer. But write and flush errors are bad. You need to find
out what that's about.



-- 
Chris Murphy
