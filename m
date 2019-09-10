Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB22AE31B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 06:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfIJElW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 00:41:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfIJElV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 00:41:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so17213494wrd.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSD7xXpkqssxMukeqj9U2KWeamgP7PfP3il23XWw9xE=;
        b=WsM2XQxYl5Vl5i60t/tGxwfIVLvOksSRVPZxoB36mKnurdN68enzWbXtmvrCLWKBrM
         7+6SebCs320rBJXCpiCNo3Lll5+Rm/VJZyCIyy7g5lQXSao+3wuVt1WyiNRSup6kAZri
         wA00iqlbHcDPnhegokcyyejOSHwDdMSh7AtMY/JKcLJv+5j4dJObZzumIu2Bpw5ccvoZ
         CA4HuAw3t2+D2DaisBNdAOqW8v2wQxaLVilWoIorenz6sfThRz/XOBLfMQIurzaxiX0g
         PhtC88iZ5sKOOuNo2XXl802+O6oC9tZnT3PAqSCBp9ypZB/kMR8BzSehHSexIZUOcXrB
         NlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSD7xXpkqssxMukeqj9U2KWeamgP7PfP3il23XWw9xE=;
        b=RuojOamGbtcmTl5BrEWr17ZZ0p+XXx4CZ+ZBv8l+PANiUqis1XWWVFmQZGHVbSTOEb
         9eXF1F/iEmWeATGdgZTcep4gOQgJlpEQguKUUGf53tO00IGW1Ly28COhMf5Nk3YbzizO
         zigdBavAUK8Qli+q1ToPfEWFiHEi+1dmPgdJi61MuV9nCzW26wnLQ0qt/U+PXYv0TpE1
         dDjyGjysgMwF1vvLMntND257W1d76VMsqnU4k3HrMygGKSJWLM9oy7b5jqW03CPXZ7og
         p7Enood4RE7aIgYTYarkObvjkZZmtzKQmaWOEKJrzGeBoGRaxJ1LcykfS+XvmXsfdOAV
         uzSQ==
X-Gm-Message-State: APjAAAXpxo3RSzbllQkmuLwgZHZx9mS/egDglH3ububczroorMQSfioI
        ewYHdXYKPYs+dQM3dcKc8LPsrNSpsAqgUT97KD3KYA==
X-Google-Smtp-Source: APXvYqzgHFuPSIqjJl8yJBXysvlpK3mjh8CnbMeoNE+/kUvBqp4OBMyfWJ7gKaiJRGPrWoOSQ+xbuQGXIzcVjGpVHuQ=
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr22235225wrs.268.1568090479455;
 Mon, 09 Sep 2019 21:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmfObZuWx0HR48VNnN2M1jguBsfUmyXTQ-KN5J9iCySxRapHw@mail.gmail.com>
In-Reply-To: <CAMmfObZuWx0HR48VNnN2M1jguBsfUmyXTQ-KN5J9iCySxRapHw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 9 Sep 2019 22:41:08 -0600
Message-ID: <CAJCQCtQ_QuE2dRLwrMKHQ6nFdNGeZghFizHdug5pbQWZqKewyw@mail.gmail.com>
Subject: Re: btrfs reported used space doesn't correspond with space occupied
 by the files themselves
To:     Daniel Martinez <danielsmartinez@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 9, 2019 at 10:16 PM Daniel Martinez
<danielsmartinez@gmail.com> wrote:
>
> Hello,
>
> I've recently converted my root 32GB ext4 partition to btrfs (using
> btrfs-progs 5.2). After that was done, I made a snapshot and tried to
> update the system. Unfortunately I didn't have enough free space to
> fit the whole update on that small partition, so it failed. I then
> realized my mistake and deleted not only that newly made snapshot, but
> also ext2_saved and some random files on the filesystem, totaling
> about 5GB. For my surprise, the update still failed due to ENOSPC.
>
> At this point, I tried running a balance, but it also failed with
> ENOSPC. I tried the balance -dusage X with X increasing from zero, but
> to my surprise again, it also failed.
>
> Data, single: total=28.54GiB, used=28.34GiB
> System, single: total=32.00MiB, used=16.00KiB
> Metadata, single: total=1.00GiB, used=807.45MiB
> GlobalReserve, single: total=41.44MiB, used=0.00B
>
> Looking at btrfs filesystem df, it looks like those 5GB of data I
> deleted are still occupying space. In fact, ncdu claims all the files
> on that drive sum up to only 19GB.
>
> I tried adding a second 2GB drive but that still wasn't enough to run
> a full data balance (metadata runs fine).
>
> This is what filesystem usage looks like:
>
> Overall:
>     Device size:                  31.59GiB
>     Device allocated:             29.57GiB
>     Device unallocated:            2.03GiB
>     Device missing:                  0.00B
>     Used:                         29.13GiB
>     Free (estimated):              2.22GiB      (min: 2.22GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:               41.44MiB      (used: 0.00B)
>
> Data,single: Size:28.54GiB, Used:28.34GiB
>    /dev/sda7     768.00MiB
>    /dev/sdb1      27.79GiB
>
> Metadata,single: Size:1.00GiB, Used:807.45MiB
>    /dev/sdb1       1.00GiB
>
> System,single: Size:32.00MiB, Used:16.00KiB
>    /dev/sdb1      32.00MiB
>
> Unallocated:
>    /dev/sda7       1.03GiB
>    /dev/sdb1       1.00GiB
>
>
> I then made a read-only snapshot of the root filesystem and used btrfs
> send/receive to transfer it to another btrfs filesystem, and when it
> got there its also only occupying 19GB.
>
> So there seems 10GB got lost somewhere in the process and I can't find
> a way to get them back (other thank mkfs'ing and restoring a backup),
> which in this case is about 30% of the available disk space.
>
> What may be causing this?


Since the 4.6 convert rewrite, I'm not sure off hand if a defragment
is still suggested after the conversion. Qu can answer it.

There is an edge case where extents can get pinned when modified after
a snapshot, and not released even after the snapshot is deleted. But
what you're describing would be a really extreme version of this, and
isn't one I've come across before. It could be an unintended artifact
of conversion from ext4. Hard to say.

I suggest 'btrfs-image -c9 -t4 -ss /dev/ /path/to/file' and keep it
handy in case a developer asks for it. Metadata is only 800MiB so it
should compress down to less than 400 MiB. Also report back what
kernel verion is being used.

In the meantime, I suggest deleting all snapshots to give Btrfs a
chance to clean up unused extents. And then you could try to force a
clean up of unused extents by recursive defragment. The system is so
full right now that it's likely this will fail also with ENOSPC. COW
requires a completely successful write to a new location before old
extents can be freed. So whether delete or defragment, space is
consumed before it can be later freed up. But you might have some luck
at selectively defragmenting directories that you know do not have big
files. Like, start out with /etc/ and /usr - maybe you have VM images
in /var? If not then /var can be next. Maybe big files in /home? So do
that last, or do in such a way to avoid the big files until last.


-- 
Chris Murphy
