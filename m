Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229D8250C7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHXXls (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 19:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHXXlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 19:41:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836C0C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 16:41:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b18so170495wrs.7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypFE0w8c0wXfxCXv6zMenuxFm68aTcapKrvpP27zTGk=;
        b=WkGARumpLYyq2OdH2JRRR52nAxVKFEXW9PCq6GwA/5XRTf6ibc3W1nG1lTouoKnIqf
         yA/mlal/rJSR0x44iqivJpOp4qtLVYAAhXrBFItw9YHO5MCJ8F1EHApQYMDAjN+4Eygf
         AJfFtnFU7nB3UvFyWxc7i1hf/r0mKht4Ms9x1J6gM7+dSH0xQ+ZQsvbogJHbibvm81Gd
         FSN0B7pOsjUTLcfcUX7Hl5Q8U3Mr2DZYpw5HF3NwjuShJ47whmoia8B5nuYq8gIV31NB
         BcBw2EsdVrZyrOajjTQRDV/ovLrDXuzeEfron5VnVTmBipDT0yYqYLDeIDkIwDsbMxkC
         nLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypFE0w8c0wXfxCXv6zMenuxFm68aTcapKrvpP27zTGk=;
        b=XJKganZ4nGgKJh9G0LFcEe4gQ7XYxhto7eXo8cmFAUKwAQiS4IZL64votbXsOJDXsU
         ny5UsVd6soJspFVMYDsZGmvGifxbNNQygpNMos0ivNcVUeQ5pmYuYQRHPOJIkcSROyOL
         5tGEsqXFyv7heGXzBPjRvTfgaDKze9WNaZVozDwC36CTc7g7OfK8sbvltFHyLciYd2X5
         D8bcIvZg/kQjrxoaC5zBIG5Ir9kpHbZZYMujrvoda2Cu455woYkfBzxgGULx6Rboqt8U
         InieW0OSHQAoS2FEYFFlk5GVICo3N0oMAP3apiunkPl0XgVMnHJdal0J+vKVwrBU8ThI
         3UWQ==
X-Gm-Message-State: AOAM533AA2rDBz5zPJSSNQ7tQ3l+x/7aqceEEom2AcqKrDlF0Bmex9ya
        7vWHtoI2kna/xLJrSOgWBMio09duhPmp7J3wBmbHemG0zpKYwA==
X-Google-Smtp-Source: ABdhPJz7Z1qTmvqQ/NvKChZwKvW/MfTb0gO7Zr/6MlItslGR1CHTN3pmexbwEk5WHW04OAZS9GKBVZ0H5wCUVgVhmAU=
X-Received: by 2002:adf:8401:: with SMTP id 1mr7803875wrf.274.1598312505667;
 Mon, 24 Aug 2020 16:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE8gLhn15dLELmeRy3TadcVg6UszxkhiB4tVL7NpEA_Q3m5sdg@mail.gmail.com>
In-Reply-To: <CAE8gLhn15dLELmeRy3TadcVg6UszxkhiB4tVL7NpEA_Q3m5sdg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Aug 2020 17:41:03 -0600
Message-ID: <CAJCQCtQHnyuhq-so15vZAKW7ih3GT++gUFj5s+AGTYfh=r143Q@mail.gmail.com>
Subject: Re: Yet another guy with a "parent transid verify failed" problem
To:     MegaBrutal <megabrutal@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 5:01 PM MegaBrutal <megabrutal@gmail.com> wrote:
>
> Hi all,
>
> My home server computer with BTRFS root file system suffered a power
> supply failure recently which caused a sudden power loss.
>
> Now the OS (Ubuntu 18.04) boots properly and it starts a bunch of LXC
> containers with the applications the server is supposed to host. After
> a certain time of running normally, the root filesystem gets remounted
> read-only and the following messages appear in dmesg. Fortunately, the
> file systems of the containers are not affected (they are mounted from
> separate LVs).
>
> [57038.544637] BTRFS error (device dm-160): parent transid verify
> failed on 169222144 wanted 9897860 found 9895362

On the surface that looks like 1500 transaction IDs have been dropped.
But it's more likely that this location has long since been
deallocated and the recent commit should have been written there
before the super block, but for some reason (firmware bug?) the
current superblock was written before the metadata writes had been
committed to stable media.

That is, lost writes. It could be write order failure, and then you
just got unlucky and had a crash so it turned into a lost write. Had
there been no crash, eventually the write would have happened. It
being out of order wouldn't matter.

It's possible that the drive does this all the time. It's also
possible it's 1 in 100 fsync/fua commands.


> The usebackuproot mount was successful, but I'm not sure how it's
> supposed to work... does it correct the file system after one mount
> and then I'm supposed to mount the file system normally?

That usebackuproot succeeded does further suggest a write order
failure. The super block made it, but the tree root didn't or whatever
exactly it's failing on that it expects but isn't there.

The way it works it it'll try to use backup roots for mounting, these
backup roots are in the super block. It's sorta like a "rollback"
which means you are probably missing up to 1 minute's worth of data
loss between the time of the crash and the last properly completed
commit in which everything made it on stable media.

At this point it's probably fixed. But it's possible this would have
gone slightly better if the setup were using Btrfs raid1, because in
that case there's a chance one drive didn't drop that write, and Btrfs
would find what it wants on that drive, automatically.

But you should do a `btrfs scrub` to see if there are other issues.
And when you get a chance it's ideal to `btrfs check` because scrub
only checks the checksums.

Disabling the write caches in both drives might reduce the chance of
this happening, but without testing it may only end up reducing write
performance though probably not by much.


>Or should I
> always use the file system with usebackuproot from now on?

No need. But even if you use it, btrfs will figure out the current
root is OK and use it.


>(It doesn't
> feel right.) Anyway, after one mount with usebackuproot, now I started
> the system regularly. But I'm not sure if it solved the problem,
> whether usebackuproot did anything, especially that now I rebooted
> with regular mount options. Since the problem presents itself after
> hours of normal operation, I'm afraid that it might come back anytime.
>
> What to do if the problem reemerges?

If either drive is dropping writes, there's a chance it'll really
confuse the file system. And md raid1 scrub check just detects
differences, it doesn't know which is correct. And if you do an md
raid1 scrub repair then it just picks one as correct and stomps on the
other one.

What do you get for 'btrfs fi us /' ?

Hopefully metadata is at least dup profile.

In the short term I'd probably disable write caching on both drives
because even if it's slower, it's incrementally safer. And also stop
having power failures :D

And in the longer term you want to redo this setup to use Btrfs raid1.
That way it will explicitly rat out which of the two drives is
dropping writes on power failures.

-- 
Chris Murphy
