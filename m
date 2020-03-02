Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27A31751C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 03:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBCYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 21:24:22 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:42749 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBCYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 21:24:22 -0500
Received: by mail-il1-f169.google.com with SMTP id x2so7955010ila.9
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IktJnsIhHfy0cem0YHXikWKkWaigeh/WmYDeTRqFz4=;
        b=F+tuw4EJI89HRG3goFDfZrexkcudcmcIYGxTvdnZu4Qbdp3kI7217MGt6c3J7Ih0Oi
         zbhYisXPwqRV/yjkS1j7H3pDknmc7t+um2zkcKIm9zH1uJBlAdEf/RSuVyb3gawo4nI1
         yMAv3EshF44kFVDYhzPBJUrN3Yarz1QuejGRTL0FcdhyMO0MBjMEK2JaEhMM3FvTxehf
         2eZXhwBqPsL+4KrZILzeYS5nWHspaduCRh1mq/qTqyaMm1n4gaZJo7oEe08w46pgFuXp
         Whz0iCLsUIKbBEg+AZzh9saEoQfbsdtrzP4GQYQwaxFkzecjNkKCwUURAnJ6pQNtQJJ0
         7g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IktJnsIhHfy0cem0YHXikWKkWaigeh/WmYDeTRqFz4=;
        b=K7eLapAN2SbZvmFhCOxLTl/0mwmzlecdFawaL3/jEGLlKgY4YMIFWdh+51OeshWpS+
         jk9pPE68mC7Q2Q+sPA/w0oXGfHqHMb/DvKMCIY1JkPKj/c4NIyhkUPot/1n5E4SOASv7
         0GL6Owq/YWUEVXzFDTrJipx4qkg0YI5duXzsPgsHpP7Xz+fVve74pT5oTu/DshQZShEg
         Dxsnp4FdhQXtmCb893E8VdHkXf+I5sFPB4UMHtqgiqqaxoF9+Ce8L3FOEf33qThKT1MS
         RuEnc9hRaPiL0qnn9+yk8Q3pqrCM0tTtHkXtpcFZ8dEK4//KpSWKTR3hf5lijOOYwXu7
         9DhA==
X-Gm-Message-State: APjAAAVK7EraMJ0Jz95a4RiNHGoWMP0+auYh54YKQFLB4lpmLx5rcbP7
        7rbPpze3iHringnS8uxFUS0MtiebmALYGYEFTHM+1lXEZ5o=
X-Google-Smtp-Source: APXvYqxU48LfnbalYfpJEktTbto1aAq6I6pd016fnAKp0PC4kQvCjEHnGQmbZw8gt4QTfpKrUTKaQk7NdWvk+GY0cQc=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr14140834ill.150.1583115861155;
 Sun, 01 Mar 2020 18:24:21 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com> <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 18:24:10 -0800
Message-ID: <CAG+QAKVf7nxzHr+yfj-7eXEWD+Zdc7-DwuVkZBYDK9fmzAQxKA@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 5:57 PM Chris Murphy <lists@colorremedies.com> wrote:
> > I'm not following the btrfs logic here - I had three drives, 2 x 1 TB and a 1 x 4 TB and added a 4TB.
>
> The original three drives:
>
>         devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
>         devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
>         devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1
>
> Simplistically, devid 2 mirrors with 50% of devid 4, and devid 3
> mirrors with the other 50% of devid 4. You have 4TB of data on an 8TB
> volume in a raid1 configuration. That's completely full and using up
> all space.
>
> Then you added one drive. Doesn't matter what its size is. There's no
> where for more data to go.
>
> https://carfax.org.uk/btrfs-usage/

That shows I should have 6TB at RAID1, but only 4TB at RAID10.  I'm at
RAID1,  not RAID10.  (Although I'm not sure what the difference is
exactly in this context...):

$ sudo btrfs fi df /.BACKUPS/
Data, RAID1: total=3.63TiB, used=3.62TiB
System, RAID1: total=32.00MiB, used=736.00KiB
Metadata, RAID1: total=5.00GiB, used=3.87GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

The web tool says:

Total space for files: 6000
Unusable: 0

Device 2 has size 4000
Device 3 has size 4000
Device 0 has size 2000
Device 1 has size 2000
Allocate 2 chunks at a time
Trivial bound is 12000 / 2 = 6000
q=0 bound is 8000 / 1 = 8000
