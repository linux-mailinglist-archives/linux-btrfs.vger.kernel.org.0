Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6434951A52
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfFXSPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 14:15:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44338 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbfFXSPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 14:15:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so14894081wrl.11
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyzngSmbA+Vpji5exMt/mMllyDIZvkL36qBsYo2WGQQ=;
        b=sfbFHqrV6AuVFYzx/9kfTo+MM57+EV3lEgwJNwKmUx8dChA6j+r6emU4/YrzGNScce
         p7jfze3pI5NHi2X9TB2mfj/DF7oADYb/VXIFZrSmDvAk5pjnwe7odspuc2LP6imQBfJC
         KVTE4sGRCWgl5ZE4AN0wMy/vMUB6EL8nAadr8Outwf8f+Z9G7k/CXziHDJshHVy8wJ15
         0imLUABYhetP43fWI8DiDY0ZY+kbCKz6QHRzC5jriZ4zsSrMlE0dv2R36RhYrSPnEWyO
         7dHmSQxuCr04ULAA+LhZ+l0iK/xdudZTt6eIXECklvOXVyn3AvR0LdIb/tzIRdOhrb2o
         MTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyzngSmbA+Vpji5exMt/mMllyDIZvkL36qBsYo2WGQQ=;
        b=CJVcooyO3NH+fha4YTpoacAwYxrB86byiQ5cEMyN6gYhWAggY3cslg66YALV6cBxZD
         RpUyerJ+liNx3YXkyQFRsHPa1leE6Yc50qh6f5KSa+9CIatDuzJKnCTLaMCJrafdFRgH
         HjhmrRuuJN0Jk2CasEbFlREh2rYpIbhnIEMMqo2YpSonJLpmdShFugQrRoHstls1rJ4N
         syQvdMz3csey4lH6biKsNRn3DZmBMAfZ8DGCOqz5eisitJ503bRh4RI1QTR8DpbDTpZa
         orCgwbLYrvQdpkSyL5wJcWc/E4wW8anmLHxAarpkQ1Nh2fnP3MByUdGlwd42OxG5xrbE
         CSmA==
X-Gm-Message-State: APjAAAUoalewK6WBRWKRAnfpe6x1j3lKmTQ6xIon19UBazDOimWVe73t
        AkuXXql1HHg89BEdgpVfKwDf9XANjXmYquEQIeAEnxntKivVCQ==
X-Google-Smtp-Source: APXvYqygdGPsU/fJm54wbTEpJeREHJa3TgT2TwigrVdzjSH2u+LpY7Jas1VQTzJ5t0cvwfMnk/RxDXEF7m4G9iuVS34=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr31966414wrx.82.1561400147317;
 Mon, 24 Jun 2019 11:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPfCsGuLi6J_CW8_FgA4DQR8-SrOUhmFjZs4imTVW05ta7RXMw@mail.gmail.com>
In-Reply-To: <CAPfCsGuLi6J_CW8_FgA4DQR8-SrOUhmFjZs4imTVW05ta7RXMw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 12:15:35 -0600
Message-ID: <CAJCQCtSm0Wh9rknhLT66x3xof1bfB-4=+1N7Uv7Hoq8-s4=mBA@mail.gmail.com>
Subject: Re: Recover files from broken btrfs
To:     Robert <robertgt4@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 23, 2019 at 7:23 AM Robert <robertgt4@gmail.com> wrote:
>
> root@Dyskietka:~# uname -a
> Linux Dyskietka 4.4.116.armada.1 #1 SMP Mon Feb 19 22:05:00 PST 2018
> armv7l GNU/Linux
> root@Dyskietka:~# btrfs --version
> btrfs-progs v4.12


Old kernel, old progs. Definitely do not use 'btrfs check --repair'





> root@Dyskietka:~# btrfs fi show
> Label: '2fe4f8e6:data'  uuid: 0970e8c4-fd47-43d3-aa93-593006e3d0c3
>         Total devices 1 FS bytes used 8.11TiB
>         devid    1 size 10.90TiB used 8.11TiB path /dev/md127
>
> root@Dyskietka:~# btrfs fi df /dev/md127
> ERROR: not a btrfs filesystem: /dev/md127

That command won't work on an unmount device, so that's normal.



> [Sat Jun  1 13:18:53 2019] BTRFS: device label 2fe4f8e6:data devid 1
> transid 155439 /dev/md127
> [Sat Jun  1 13:18:53 2019] BTRFS info (device md127): setting nodatasum

*shrug* I guess some attempt to make it more like ext4 but with
metadata checksums and snapshots, but it renders a lot of the data
guarantees of Btrfs moot.


> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
> find logical 62139990016 len 4096
> [Sat Jun  1 13:18:54 2019] BTRFS error (device md127): failed to read chunk root
> [Sat Jun  1 13:18:54 2019] BTRFS error (device md127): open_ctree failed

a. Don't modify the volume at all, as in do not try to repair it. You
need to see if a developer has any advice first.

b. Realize that this list is about development of btrfs, not
maintaining old versions of it. The maintenance job is for the vendor
who chose to use and keep using a 4.4.x kernel and 4.12 btrfs-progs.
So it's really their responsibility. This list is upstream
development: linux-next, mainline, and most recent stable kernels.

c. The most likely chance of success, even though it will take a long
time, is to use 'btrfs restore' to scrape data off the volume.
Hopefully you have a backup and you only have to try and scrape recent
data.
https://btrfs.wiki.kernel.org/index.php/Restore

d. I don't know that a newer kernel or progs will magically tell us
what's going on, or fix things. So I wouldn't necessarily go to the
trouble of imaging the Btrfs volume from md127, onto a big enough
single drive, so that you can stick it in a computer that's running
newer kernel and progs. But it's an option. And at the least,
btrfs-progs 5.1.1 for restore to scrape data off the disk should have
a better chance of success if it doesn't work with 4.12.



-- 
Chris Murphy
