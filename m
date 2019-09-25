Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2DBD621
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 03:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411295AbfIYBht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 21:37:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37867 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392412AbfIYBht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 21:37:49 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so9409682iob.4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx8jYMtXzSIBAreBPaiSkIOAkhKzOQvqziESi10CWk4=;
        b=JxeABiuWZjuLh8E6mIA4OAy9RD2KEkiqg/kFL6ub3y3N3JnVmqr7d7eAndVROwhP3s
         E5XHXDlGb/xifuk+thR0Xg3r58meA7M89djyLBkX0ehWueVC0Ka/yVHgptcHg1X5tEcF
         NwvC9moVQrO9eaoPAaQ/4yuLr2r+LbFpwf6SFkeysM+ZIpF7F7h+juc61V0DMJLVvS1e
         12f8/4MUv0YKNmo0pWkTMoieQxVwXMFWsVujHlDmH5JPXJVTTGNxRSfQZ5RPjq053JBw
         IZ7KlzMTZ5AeMObLLPzTRfONGBX5oVWgLqf5ZIWxpcwse81VkTFNTHNW2UmtSR8hukti
         eTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx8jYMtXzSIBAreBPaiSkIOAkhKzOQvqziESi10CWk4=;
        b=WuG/u7lcFJLanF06VxzqHvMqossqwLn2AhqxfFABbLazZQfB7k/7we5BhCknGzf6vL
         1Nt+9vzmJJDK6myGg5likU5VrGWBSsLXeyfJxIgUT4aJ493EmY71CUxAL6PguaFh0CzD
         UqAWKDLDQr0nhzf8dhi+VbYQltF6eWq1iukUgeaETzqrczWPBfver/FA5GREIZ5BvJKT
         Mn0YHJLPsmPdqc+Rp4Ze8VZ8vCaPGVGFAclYthW1Mpuo4kazsXZt3HofqDZteJaq1w3d
         YpTywYw5gfjVHXpOaYxH/Qa9E2l5OnK0bUrrQt+VB5d0KMKn7lnOy1bk9yXYw56/3Tw8
         mEeg==
X-Gm-Message-State: APjAAAXyEv9EMvt7KiE1yUxQO+OiAevaP8yaDiabj4r9KZeZuzCPVtp/
        fPI4WhKKNVrYt3CrSBMieHoJtdDy3wyqMf271XM=
X-Google-Smtp-Source: APXvYqwcuX7PXjsCj9N1vx1YgEiD4i5ponXiVKL8axIAiyfkRnl562HmeGE4SryMBsV8ZQU53YaDOxloO9qIVVPCsOw=
X-Received: by 2002:a6b:6b06:: with SMTP id g6mr2668438ioc.72.1569375468283;
 Tue, 24 Sep 2019 18:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
 <CAJCQCtSUFcpCX_w-iWqsrjK3O5bpT=PMfmQk23mVeYrz1jo8Mg@mail.gmail.com>
In-Reply-To: <CAJCQCtSUFcpCX_w-iWqsrjK3O5bpT=PMfmQk23mVeYrz1jo8Mg@mail.gmail.com>
From:   Charles Wright <charles.v.wright@gmail.com>
Date:   Tue, 24 Sep 2019 21:37:37 -0400
Message-ID: <CAFN5=-NrfZs8d=H8iTJtKM2is2E_XbZ8eewN+C=tHQxUX4knsg@mail.gmail.com>
Subject: Re: Tree checker
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, I'll check it out.

I think I'v tracked down all the files with bad "atime" and cleared
all the BTRFS errors by cp -r , deleting the originals and moving the
copies in .

thanks a bunch .

Charles Wright


On Tue, Sep 24, 2019 at 12:08 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, Sep 23, 2019 at 6:35 PM Charles Wright
> <charles.v.wright@gmail.com> wrote:
> >
> > if I boot the 5.0.0-30 kernel and enter the "dwhelper" directory and
> > do "dmesg" their is this
> >
> > [  199.522886] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x2d0100
> > action 0x6 frozen
> > [  199.522891] ata2.00: irq_stat 0x08000000, interface fatal error
> > [  199.522893] ata2: SError: { UnrecovData PHYRdyChg CommWake 10B8B BadCRC }
> > [  199.522897] ata2.00: failed command: READ FPDMA QUEUED
> > [  199.522902] ata2.00: cmd 60/08:78:a8:57:f3/00:00:12:00:00/40 tag 15
> > ncq dma 4096 in
> >                         res 50/00:08:a8:57:f3/00:00:12:00:00/40 Emask
> > 0x10 (ATA bus error)
> > [  199.522904] ata2.00: status: { DRDY }
> > [  199.522908] ata2: hard resetting link
> > [  199.837384] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [  199.840579] ata2.00: configured for UDMA/133
> > [  199.840771] ata2: EH complete
>
> This is a hardware problem. I suggest swapping out the cable between
> the drive and controller.
>
> "interface fatal error"
> "BadCRC"
>
> >
> > but all works  as in I can access the files as normal
>
> It's not normal to having the ATA link hard reset due to CRC errors.
> That blows away the entire command queue on SATA drives. There's
> nothing any file system can do about this.
>
>
>
> --
> Chris Murphy
