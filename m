Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5434A23E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfH2SS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 14:18:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfH2SS6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 14:18:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so2644074wmc.1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lKCYB4Fty5i77I0dar4HOxW5qSZfqlrhayxzobItuVI=;
        b=14OE+uk48sxQe+vAqLV7QLZzKeMrkPU9jvmMfPP+VxNo0Szrok2p6h+kDOCJt0otCH
         2uUAPiT3c4D667y2xYKVqB49avwV0ist+/F61YDyogKpgua6uu3ANsVtMUGQy1123IpP
         /WVNK53viXG8rFPMsahTCYrENzwABbiARYnjxrlaHIOW2cRXpawoVTS/UZCJaQ5AbyjB
         vhIhFEdsEQLvvysKDfucgRSxqoLQ1k5YFpAFfnziz37D9a9qBNQwwMYFoS5ElvWtk+E4
         AxSVtupUCwpb65/EafTRdOa2kk5GcsntnVJbk9oMfZ7LgdAd+rSyaA1f8ebTbUaxUdbn
         E9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lKCYB4Fty5i77I0dar4HOxW5qSZfqlrhayxzobItuVI=;
        b=jzhgP2AlTs04iihQY8cTmoU2f0Wn97QrQaLNot+9L4W2jBw8xNdU/v4f3lOS4obRvn
         95LQBKgBT1NDKl0+yJoTPdI82Piy3m1DcQCjuRBO68uxJSTsU8KWwI8132m77JV1Wzhd
         dMj80HMOh5HBZ0NVQ+M9jPw4QzUuocFRWsEhRXzBpPy5wbteuf8CnTc8Q4N7/sJ40bMF
         2ud/Hi3YDSIJpD2Nob1yFwaYggyk4bgPDKY+GQIsjLq0y79IrVfirHsYCV3c8onIYaGJ
         YDEVXAZQzFsfukxBMnWR5RTKkpBgqUoirgnoZ1fF6oqgP3KI84C0rJo/l5iNPf/PnAtE
         AXjA==
X-Gm-Message-State: APjAAAUfWqONSqhE65wq6ADfEdxhD1wIebC6WktgScoObsNv3AM4dqwo
        IWh18ATFj5muWsRGvnLV4l02l5QzEdJIBcDg5r5z5g==
X-Google-Smtp-Source: APXvYqyHyrL/KqkyH/U2lCHsXMVp1Ur74zEVJ3DMbhlvqsSivK5CVPSla1pQHbos6zZ1T1kbAu1jtIEmYFPtBvubKDk=
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr13376271wme.176.1567102736484;
 Thu, 29 Aug 2019 11:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEgruXsjz36vEZhULWneZKY4yD3x2n05yR8qx9eiN-GOVvfiJg@mail.gmail.com>
 <20190829145732.GB2488@savella.carfax.org.uk>
In-Reply-To: <20190829145732.GB2488@savella.carfax.org.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 29 Aug 2019 12:18:44 -0600
Message-ID: <CAJCQCtQokwhyWWK-KLCtn3zyVGAG3iWAX_U8jxQ8teXF6ABQGQ@mail.gmail.com>
Subject: Re: Need advice for fixing a btrfs volume
To:     Hugo Mills <hugo@carfax.org.uk>, UGlee <matianfu@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 29, 2019 at 8:57 AM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Thu, Aug 29, 2019 at 10:45:37PM +0800, UGlee wrote:
> > Dear:
> >
> > We are using btrfs in an embedded arm/linux device.
> >
> > The bootloader (u-boot) has only limited support for btrfs.
> > Occasionally the device lost power supply unexpectedly, leaving an
> > inconsistent file system on eMMC. If I dump the partition image from
> > eMMC and mount it on linux desktop, the file system is perfectly
> > usable.

What kernel messages do you get when trying to mount the mmc device?
And also, does it mount ok with '-o ro,norecovery' ? And also I wonder
if there is even a log tree, which you can discover with 'btrfs insp
dump-s -f <dev>' and see if the log tree address is something other
than 0. Anyway, point is, Btrfs gets to a certain point in the mount
process and will try to do a write, and if that write fails, it
complains. Writes could fail on the mmc device but succeed on the
image file.

Both eMMC and SD cards are dreadfully susceptible to failure with
abrupt power supply loss, perhaps especially if writes are happening
at the time of the loss (there probably is some research and better
anecdotal information to support this contention). This topic comes up
all the time on Hacker News and people who do this a lot swear by
getting industrial grade flash for such embedded devices. This stuff
is not cheap compared to consumer grade flash. It's decently likely
the consumer grade stuff is optimized for exFAT, and the kind of
sequential writes you get from photos and video being written out by a
camera, rather than a file system like Btrfs (or even ext4 or XFS)
containing an operating system, and writing system logs/journals, and
doing updates, and things like that.



> >
> > My guess is that the linux kernel can fully handle the journalled
> > update and garbage data.
>
>    btrfs doesn't have a journal -- if the hardware is telling the
> truth about barriers, and about written data reaching permanent
> storage, then the FS structures on disk are always consistent. It's
> got a log tree which is used for recovery of partial writes in the
> case of a crash midway through a transaction, but that doesn't affect
> the primary FS structures.

Yeah and the log tree is per subvolume. A possible work around might
be to separate things in their own subvolumes, thereby obviating the
problem with a bootloader's lack of support for log tree replay. In
that case rudimentary breakdown would be boot, root, home subvolumes
at the top level of the file system, that way subvolid 5 isn't getting
the log tree added, rather it'll be root or home - hopefully boot
would be spared a log tree if writes weren't happening at the time of
the power failure.

Also, it's worth 'chattr +C' on the boot subvolume to ensure it's not
subject to compression mount options, if the bootloader doesn't
explicitly support compression.

-- 
Chris Murphy
