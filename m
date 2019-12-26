Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03512AF5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfLZWkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 17:40:25 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33562 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 17:40:24 -0500
Received: by mail-wr1-f52.google.com with SMTP id b6so24727243wrq.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Dec 2019 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLCfvFwVbyymWJUdLGXnWirLtSPQB8VNuHAzzfM4QWM=;
        b=QqMc0F/h3BeY3XOcpza3aCXXJtGkWrBcRpGXgrB5hxB92kC85/2MSDP2EhALngM9w2
         nkbSmWfnPraXBiLw+7736dskGotIMDdGp/aeBFWGMVqypE2os9vWDa3Ua9NL2cSjbwAX
         RmDd2+bRhjac7JDO44IbJqK5i4QXhoi6fLzkvQQHWgRZKhRXMHiilfpgdaLfhe032fFC
         ARbibLAXGl5VLUSfssA73O6fpW8jL39dIV9Sug6b+3VKDEgFy2WGWjxVrbEi7cC6dAOR
         RGUTbXG6wMfs/V2MBL5PG4jMOyfKI8MIiE8yl75ewa3irrKj51OHjvLYjFfvfFJuBSdY
         AO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLCfvFwVbyymWJUdLGXnWirLtSPQB8VNuHAzzfM4QWM=;
        b=S2RLcgFcc/5TIs0Iftx+6t6mddM6NC6gvFnHjnnX6w3kTXxWeu8ua6gkwRwVqCfPWe
         o6ZTjjdj3mOGrWYy6s8tDiqoAoUphWTKr8eJ1XGdg0Ajmzt9FAu31UayYvVJkNQt9qBA
         bcNi53hwHg/rfuwAxBimSQpYEaxVwJINPjlA/UUL7cZKva+IrPQPKxKjduulyjPfw9s1
         oG0DKxsRS/zdDedeXU5Xbwn/NW0CcX/BLyflUaOQpVffgv/kIBqxRUAeTAMzeL6e21vN
         tEWEaJJPlxdZqpMq/PULFQqtqMG++ZgNihej3z39GD+E3JZM2J2ppiBRbfm/jrRgfW+q
         UxwA==
X-Gm-Message-State: APjAAAVMnUxMZSAweJ6Nslxn3bui5Vz30pjVE6MY5/sim1N1R0jZMpwF
        7sS/wIOa1qOmegqXrPeWbo4C7SNrK3Eu0eXyQOJM5g==
X-Google-Smtp-Source: APXvYqyL0Z5gouYALjks6Scj+re6MaVuA8AHsYulMvUtu9Gz97hgUO4Xc/kbY9OHXW87lFcn3hxKCRE6bA5K5nPfzqw=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr47003007wrp.167.1577400022726;
 Thu, 26 Dec 2019 14:40:22 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
In-Reply-To: <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Dec 2019 15:40:06 -0700
Message-ID: <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Remi Gauvin <remi@georgianit.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 26, 2019 at 7:05 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
> Dec 22 19:20:11 wawel kernel: [ 5912.116874] ata1.00: exception Emask
> 0x0 SAct 0x1f80 SErr 0x0 action 0x0
> Dec 22 19:20:11 wawel kernel: [ 5912.116878] ata1.00: irq_stat 0x40000008
> Dec 22 19:20:11 wawel kernel: [ 5912.116880] ata1.00: failed command:
> READ FPDMA QUEUED
> Dec 22 19:20:11 wawel kernel: [ 5912.116882] ata1.00: cmd
> 60/00:38:00:00:98/0a:00:45:01:00/40 tag 7 ncq dma 1310720 in
> Dec 22 19:20:11 wawel kernel: [ 5912.116882]          res
> 43/40:18:e8:05:98/00:04:45:01:00/40 Emask 0x409 (media error) <F>
> Dec 22 19:20:11 wawel kernel: [ 5912.116885] ata1.00: status: { DRDY
> SENSE ERR }
> Dec 22 19:20:11 wawel kernel: [ 5912.116886] ata1.00: error: { UNC }
> Dec 22 19:20:11 wawel kernel: [ 5912.153695] ata1.00: configured for
> UDMA/133
> Dec 22 19:20:11 wawel kernel: [ 5912.153707] sd 0:0:0:0: [sda] tag#7
> FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Dec 22 19:20:11 wawel kernel: [ 5912.153709] sd 0:0:0:0: [sda] tag#7
> Sense Key : Medium Error [current]
> Dec 22 19:20:11 wawel kernel: [ 5912.153710] sd 0:0:0:0: [sda] tag#7
> Add. Sense: Unrecovered read error - auto reallocate failed
> Dec 22 19:20:11 wawel kernel: [ 5912.153711] sd 0:0:0:0: [sda] tag#7
> CDB: Read(16) 88 00 00 00 00 01 45 98 00 00 00 00 0a 00 00 00
> Dec 22 19:20:11 wawel kernel: [ 5912.153712] print_req_error: I/O error,
> dev sda, sector 5462556672
> Dec 22 19:20:11 wawel kernel: [ 5912.153724] ata1: EH complete
> Dec 22 19:21:28 wawel kernel: [ 5989.527853] BTRFS info (device sda2):
> found 8 extents

Weird. This is not expected. I see a discrete read error with LBA
reported for the device, and yet Btfs shows no attempt to correct it
(using raid1 metadata) nor does it report the path to file that's
affected by this lost sector. I'm expecting to see one of those two
outcomes, given the profiles being used.


>
> Dec 23 00:08:20 wawel kernel: [23201.188424] INFO: task btrfs:2546
> blocked for more than 120 seconds.

Multiples of these, but no coinciding read errors or SATA link resets.
This suggests bad sectors in deep recover. And that would explain why
the copies are so slow. It's not a Btrfs problem per se. It's that
you've decided to have only one copy of data, self healing of data
isn't possible. The file system itself is fine, but slow because the
affected drive is slow to recover these bad sectors.

Again, dropping the SCT ERC for the drives would result in a faster
error recovery when encountering bad sectors. It also increases the
chance of data loss (not metadata loss since it's raid1).




-- 
Chris Murphy
