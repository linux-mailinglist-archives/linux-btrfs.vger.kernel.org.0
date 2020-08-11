Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B520C241CF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHKPMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKPMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 11:12:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C5C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 08:12:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i6so9352651edy.5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X81N6o8k7SKqq0x/ut80WfMoB5QrgFI/Qik0ZoP1jCs=;
        b=BLdK+XNIkaOcYToRUGXi8ahfCtZW6YGKAW7FkB6fEZQxykydePRqvZBhSI6rQ3oInV
         HMOFe67iG/Z1zJ+XEHQ2zq4zxdj4KVnbCqgu6Jlz/eVUtPG5rGOwfwveBCer2DSUX9PW
         qrz/4vdx5dXpsC25x2Uf3T0SJdoZWEV7n8oSfHGsuzDJP368If4p+AB74BXB4EE7JoFJ
         CMKyue+eaI/lZf9UkgIsWW9XT61Oh2/yoSAabsZ7hqBIUIV6qv1qtqc0WhbYe4EDIDiU
         U9trIr+MvdPbYSxiIqZvi4ula07nnD7PTcZlLwK4FBhQGIC/UOjy4Bys4LFgh9vkTcH/
         5JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X81N6o8k7SKqq0x/ut80WfMoB5QrgFI/Qik0ZoP1jCs=;
        b=gAkftA4oyoSBlxS1/ayUgBOi2i/kOSvAObtMqp5BYmvWo/xpMi+y63O4rsrtQibq3C
         VutR6ot1r5qkeqU2AjIvhnJj4FwgUxycbRA3XAgMxx0H61zASN6m4TD3Ioh6wBp71XLp
         23TLxooNjAGOTFlUKuRbrtU2nCZBNLJ/6P14QDGZ3w3hmuWPx35FypmgcG3Pp+crVFmO
         SAqTaD7COdtMVC+TF4/B9TXp2TRVT5kZMF+yaA79Q4J4QvDeF9OSWe1d3BQuLhPHjkX7
         lZrA/NvBaaKSpk8eaLiYWbVSMTrmdyXsycvL5QtIHpo7SAXcEnKEiuIE0wOrGiP7aX8P
         7aMA==
X-Gm-Message-State: AOAM533oTgkhJqq/FRksQR9e+14UiLaUiJQJb+yIeRcsmYxcb7x2DsRi
        Wu6Ei+7R/eXA3T9kZzNlMjhkIYDX+rUQbuRrZtg=
X-Google-Smtp-Source: ABdhPJwJa+oc/1H6PjAq6jYVouKwAu1yXuLi5XXJEx7iLlE5Bxzahe5NGqb+upeJoGurdQIf0BOk85uj795OwkGZrEg=
X-Received: by 2002:a05:6402:33a:: with SMTP id q26mr27940511edw.8.1597158762653;
 Tue, 11 Aug 2020 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XNQ=iupWN6ck5M0hUQ-+470F9PKdoKKUUt+tmQOWoC=zterg@mail.gmail.com>
 <f8742974-69b2-a0e9-ff99-4c61dc4f9ff0@gmx.com>
In-Reply-To: <f8742974-69b2-a0e9-ff99-4c61dc4f9ff0@gmx.com>
From:   Thommandra Gowtham <trgowtham123@gmail.com>
Date:   Tue, 11 Aug 2020 20:42:31 +0530
Message-ID: <CA+XNQ=g1WzZ6h+MGETbK34iUyHno_vUcufXiaJ3dKfVva+b=cQ@mail.gmail.com>
Subject: Re: BTRFS suddenly moving to read-only
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the response.

>
> > - How do we determine the Disk health apart from SMART attributes? Can
> > we do a Disk write/read test to figure it out?
>
> AFAIK SMART is the only thing we can rely on now.

Thank you. The reason I asked the question is sometimes, though SMART
reports the Percent Life remaining as > 80, we see issues with the
disk.
So I was looking if we can use dd or other tools to determine disk
write speed and compare with the new SSD's. Like below.

# dd if=/dev/zero of=/var/tmp/test1.img bs=1G count=1 oflag=dsync
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.90537 s, 564 MB/s

>
> >
> > mount options used:
> > rw,noatime,compress=lzo,ssd,space_cache,commit=60,subvolid=263
> >
> > #   btrfs --version
> > btrfs-progs v4.4
> >
> > Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
> > x86_64 x86_64 x86_64 GNU/Linux
> >
> > mkstemp: Read-only file system
> > [35816007.175210] print_req_error: I/O error, dev sda, sector 4472632
> > [35816007.182192] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> > 66, rd 725, flush 0, corrupt 0, gen 0
>
> This means some read error happened.

Yes. The errors started to occur when we were upgrading the packages.
Eventually the upgrade failed with read-only filesystem errors.

>
> Do you have extra log context?

Not much on this system as we couldn't get anything from syslog after
power-cycle.

But on other instances, we see errors like below

# cat syslog | grep error
Jun 25 13:12:13   kernel: [154559.788764]          res
41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154559.821041]          res
41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154559.900810]          res
41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154559.933070]          res
41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154560.016591]          res
41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154560.048882]          res
41/04:00:80:08:00/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154560.114361] ata2.00: NCQ disabled due to
excessive errors
Jun 25 13:12:13   kernel: [154560.132361]          res
41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:13   kernel: [154560.154507] ata2.00: error: { ABRT }
Jun 25 13:12:13   kernel: [154560.164580]          res
41/04:00:00:08:02/00:00:00:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:14   kernel: [154560.339129] ata2.00: error: { ABRT }
Jun 25 13:12:14   kernel: [154560.346548] print_req_error: I/O error,
dev sdb, sector 67111040
Jun 25 13:12:14   kernel: [154560.360192] BTRFS error (device sdb3):
bdev /dev/sdb3 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
Jun 25 13:12:14   kernel: [154560.417322]          res
51/04:00:00:08:02/00:00:04:00:00/60 Emask 0x1 (device error)
Jun 25 13:12:14   kernel: [154560.511036] ata2.00: error: { ABRT }
Jun 25 13:12:14   kernel: [154560.518434] print_req_error: I/O error,
dev sdb, sector 67241984
Jun 25 13:12:14   kernel: [154560.525291] BTRFS error (device sdb3):
bdev /dev/sdb3 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0

>
> > [35816007.192913] print_req_error: I/O error, dev sda, sector 4472632
> > [35816007.199855] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> > 66, rd 726, flush 0, corrupt 0, gen 0
> > [35816007.210675] print_req_error: I/O error, dev sda, sector 10180680
> > [35816007.217748] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> > 66, rd 727, flush 0, corrupt 0, gen 0
> > [35816007.461941] print_req_error: I/O error, dev sda, sector 4472048
> > [35816007.468903] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
> > 66, rd 728, flush 0, corrupt 0, gen 0
> > [35816007.479611] systemd[7035]: serial-getty@ttyS0.service: Failed at
> > step EXEC spawning /sbin/agetty: Input/output error
> > [35816007.712006] print_req_error: I/O error, dev sda, sector 4472048
>
> This means, we failed to read some data from sda.
>
> It's not the error from btrfs checksum verification, but directly read
> error from the device driver.
>
> So the command, agetty can't be executed due to we failed to read the
> content of that executable file.
>
> >
> > # dmesg | tail
> > bash: /bin/dmesg: Input/output error
> >
> > Doesn't Input/output error mean the disk is inaccessible?
>
> This means, we can't even access /bin/dmesg the file itself.

Yes. That would technically mean that the Disk is not accessible
though it is being reported as read-only by 'mount -t btrfs'.

If a disk is missing or offline, is it done by kernel (bug) or
something related to hardware. This is being seen on multiple systems.
So there has to be some commonality among them and as the disk moves
to sudden read-only, we are unable to get much logs on all cases.

How can we debug these instances? Can you please give some pointers?

>
> >
> > # btrfs fi show
> > Label: 'rpool'  uuid: 42d39990-e4eb-414b-8b17-0c4a2f76cc76
> >     Total devices 1 FS bytes used 11.80GiB
> >     devid    1 size 27.20GiB used 19.01GiB path /dev/sda4
> >
> > # smartctl -a /dev/sda
> > smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local build)
> > Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org
> >
> > Short INQUIRY response, skip product id
> > A mandatory SMART command failed: exiting. To continue, add one or
> > more '-T permissive' options.
> >
> >
> > We were able to get smartctl o/p after a power-cycle
>
> Did you get dmesg/agetty run after a power-cycle?
>
> Or it still triggers the same -EIO error?

No. After power-cycle everything is back to normal(rw mounted) with
logs not showing any abnormalities.
Subsequent IO activity(upgrading the packages) was successful as well.

>
> BTW, if the smartctl doesn't record above read error as error, maybe
> it's some unstable cables causing temporary errors?

> > 169 Unknown_Attribute       0x0000   100   100   000    Old_age
> > Offline      -       66

The Disk Percent life remaining is at '66' for this system which is
low in my opinion. Can a disk go offline suddenly when the health
drops low?

Regards,
Gowtham

>
> Thanks,
> Qu
>
