Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA322D2064
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 02:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLHBzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 20:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgLHBzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 20:55:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDBC061749
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 17:55:06 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m5so5031422wrx.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pFZnQv+ObGEY15fCcpfpMHYQIq6lVClHwD5AFLNJdY=;
        b=Ns9QqZngXOnCJPU55IH4Wh+ZDkruAjtuR31p6raAe+/qwmz2dAuvUigarDXgcuROz3
         1e2r7dNEOJ8RH0uPzovF9cKA2wtdoF9NW7mZG3ExyTYrtyCknmSsPwPGl+eibuomY2Oh
         4wm52ozddXQNv4QCpRnKKdvh/XuYSr7wNOu5XjTp3okYlpS8/kJkswJEVnaz9jpZFAr0
         skeqfrefG2RAcl2/1dwamesEGNo+VIdNtHTmbNnMYqEp8NQ+LIFRi0IrS6U6BOf+yqy2
         dekHKs+e546qY74Xz20hZA8Ckn90I5XugyaHdJC7RnxwXb8tdLCNfTE9MCNhktpFPrBg
         Z0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pFZnQv+ObGEY15fCcpfpMHYQIq6lVClHwD5AFLNJdY=;
        b=P7YToU9tr5iUnRGTguzeoe9cWRjuQhJRLQ9BEm4ykL5+3ecgo+zA9A4M4vLesz9qom
         NR+r5cs7xnn54eiyf9q37yUaCn8c1SPCLo1xbndRUgrKeqpwMrwYESHsgKoUV/4MSppk
         VV/6dTw3n4eu0daWwSTqhBZf6o/f5e/Nky6OcJBPqL2lAxA7vWiQslNQBpZSUjbI6DwG
         iRm6LvcLzs7StBMXuHRqvLqI6MxmotCypX+DcVEIZFQoan8CsJJB6V+iSqRGZQyVLw65
         q/otIgaP3YF205YarDO5jKU0xTWMW0rgP+N1l7VCSblTpuOQVqZnEnI93EH2mz8E5OIX
         EQ3A==
X-Gm-Message-State: AOAM533STApZqgaAicPhwcreEVC2xaF1Rk35iwk6O+AZ5N4BYBf77jBO
        WqKjOUwsFQixSgoMvYVUuydkVhIKzol54bGgFAI3IrPULlzvMgfK
X-Google-Smtp-Source: ABdhPJy/je2jcMNx+gHJQicYhM8Dll/j0kU+Ejlb8AYLFdcfLixMsUFJrfSCnSxOs/8khhkF8cg/0njGQWmr8cGzOYU=
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr22785540wrv.252.1607392504819;
 Mon, 07 Dec 2020 17:55:04 -0800 (PST)
MIME-Version: 1.0
References: <CAAdkh9xzT=wYY3jui3d4xF4kp20tB5EiL-KBJdMK69h1oWO3ig@mail.gmail.com>
 <CAJCQCtTXDufgm=ZYR4K7+-O_g=ztR9DDTUxCM67mKQRPGtWrWQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTXDufgm=ZYR4K7+-O_g=ztR9DDTUxCM67mKQRPGtWrWQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 7 Dec 2020 18:54:47 -0700
Message-ID: <CAJCQCtRm9YXDJOhgKJTLjGo7cqXOWQUrvjWts7KwiX3PXzf3tQ@mail.gmail.com>
Subject: Re: data Raid6 with metadata Raid1c3 appears unrecoverable
To:     Marcus Bannerman <m.bannerman@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 3:57 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:35 AM Marcus Bannerman <m.bannerman@gmail.com> wrote:
> >
> > Help!
> > I have an array of 4x6Tb and 4x3Tb disks on BTRFS. I noticed I was
> > getting csum errors in dmesg, and found that one of the 3Tb drives was
> > failing. Smartctl reported a lot of read errors on one device. Short
> > tests were failing at 90%, but SMART status was still OK(!). I tried
> > removing the drive with a plan to then rebalance as I don't currently
> > have a spare drive.
> >
> > $ btrfs devices remove /dev/sdX /raid
> > ERROR: error removing device 'missing': Input/output error
>
> There should be kernel messages at this same time.
>
> Also, this is quite an expensive operation because it involves a file
> system shrink, and restripe to the remaining devices. You're better
> off leaving it degraded,rw  while waiting for the replacement drive
> and using 'btrfs replace' to replace the bad drive.

Looks like there's a bug and 'device remove' won't work with degraded
raid6. And it's expected (known bug) that you'll get spurious read
errors while degraded. Data is fine on disk but the reads will
transiently have errors, probably a race.

When replacing the drive, there's also a known deadlock that can
happen. You'll see kernel call traces about this when it happens, and
it'll stop making progress. The solution is to reboot. Depending on
how much data, it might take a few of these before the replace
succeeds but eventually it does succeed. You definitely need to get a
replacement drive.

Also, obligatory reading:

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

If that's too much to live with then I suggest ZFS raidz2. It's a bit
of a pain not having it built-into the kernel, combined with frequent
Fedora kernel updates. And it's

-- 
Chris Murphy
