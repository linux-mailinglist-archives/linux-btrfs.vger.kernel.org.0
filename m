Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6D26D37E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIQGPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQGPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 02:15:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C3C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 23:15:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so1243841edv.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KC0tSWlbzIuAu3yRvFLkJJq6vBnV+fs0D6hM7SrGYd4=;
        b=q34CCTm31ronbvc9BFs4PDnDflsl0U9AYNghOo6oVQ+jpYYUBgs/MonVR7ElifXhwt
         hX7HykLuPNlY2y6E8/0ECayk8aymNnl8RpBFzKkgvnAb42PXWzmxpRef21avMAcD/mYV
         +hprhzT89p5061Sjw8G6DEAefKxV8yJ9Un1hG3QIBNgDRRnuL1mQKaAX69UhmYWcwL36
         aGo6+JLjJuH+b7XO2Hj0iTOLVKcCE5YQ3ixgIH6lZo/EzDeAtYQkv+yt8Lw5CHFBwv8L
         w8kU8d71CzqmrmMg6RHmEwW0pA5gdylC9YOp8v2jhCS/jhbBCVd0a5BhMdIjWpmam/SH
         yRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KC0tSWlbzIuAu3yRvFLkJJq6vBnV+fs0D6hM7SrGYd4=;
        b=aco60OFvbr5cYgnmzFxF+vi7mz2XsIsO8dHPAxpgoQUsrTIyfa/M0YtQM+dBnzCEQ6
         8yLPJPjPh1fj3ZGnEHk7yfzGw8yRQGOX1kS1NjICf7LtBRGXHfN4z+y4ixhyPZBYOEwC
         aNre+M3bWZmYCEdqq9RZeNG9BKfM8ROO5u/NqPSMw9XuCiAhCh7lFpWCJwWpheDxsGf0
         i2HNYpVm414tzThFBliBAFWxL8KjxZgCn3ANycI/v8lD5ICM7PijCSOF05zb8alQ4TTM
         ZnFU2FTvVsZOSHrTWt5ypBbYspAAoQ3C/GOghukgE6rsx0tQjIre0W8wI/Sa2jfFD521
         5haw==
X-Gm-Message-State: AOAM531Bs1ZKdkkskfWffhtbX44O/IOsJ5hqI/LnGfDwkF3NpAcAIl7C
        j7fUU9Ilen1r2ONxeRoD63Uk9HVbZ/ZxttDmXdQ=
X-Google-Smtp-Source: ABdhPJyD56WXsYIfa5dPsXaqxxlTkqnZNfXHaQrJnK02PvWRhnmrQNof+UTw27cTO+MuXSXDUrHHa0cNUYEu8JlEnUY=
X-Received: by 2002:aa7:d585:: with SMTP id r5mr31497503edq.278.1600323331476;
 Wed, 16 Sep 2020 23:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
 <9b5706c1-fe21-6905-9c42-ffdc985202d9@gmx.com> <CA+XNQ=j1=XObwis138fphNcRVfwgXUcfm7JW1FJG2UWm8pBEGA@mail.gmail.com>
 <9415e33b-c018-7a60-33c5-4d2b992bca80@suse.com>
In-Reply-To: <9415e33b-c018-7a60-33c5-4d2b992bca80@suse.com>
From:   Thommandra Gowtham <trgowtham123@gmail.com>
Date:   Thu, 17 Sep 2020 11:45:20 +0530
Message-ID: <CA+XNQ=hVzU5vWB-hw=3vVpiH=Fmx5QAeE-uvmRkSavD2wspdbQ@mail.gmail.com>
Subject: Re: Need solution: BTRFS read-only
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks a lot for your response. A few questions

- I had evaluated the SSD health by looking at the SMART attributes
and did not find any faults. Is there any other way to evaluate if a
problem is indeed hardware related?
- If we had used duplication for metadata, would this issue not be
seen? I mean can it survive a sudden power-loss to the system when
BTRFS is writing to disk? Also, I believe with duplication of metadata
we can see a performance dip, additional disk space used(critical
because few of the SSD are low-end 8/16Gb disks as well). Right?
- Is there any way we can recover from this situation if we are able
to clone the disk to a new SSD?

Thanks,
Gowtham

On Thu, Sep 17, 2020 at 11:16 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/9/17 =E4=B8=8B=E5=8D=881:26, Thommandra Gowtham wrote:
> > Attached the dmesg file.
> >
> > I think the primary cause are the below issues
>
> It's really better to see the first btrfs related error to grab a full vi=
ew:
>
> > [   10.565736] BTRFS error (device sda4): bad tree block start
> 12455654870318135914 4455038976
>
> This shows that, we want bytenr 4455038976 (0x1098a8000), but got
> 12455654870318135914 (0xacdb601c962d3a6a), which is completely garbage.
>
> And according to the later more similar error messages, this means a lot
> of your metadata are already filled with garbage.
> This looks like a big problem already.
>
> What makes the problem even worse is, there is no duplication for your
> metadata, thus btrfs can't grab a good copy.
>
> So far, this already indicates your fs is heavily damaged by losing tons
> of its metadata.
>
>
> But so far, btrfs is just failed to *read* tree blocks, not yet enough
> to force the fs read-only.
>
> The killing blow happens here:
>
> > [   41.892643] BTRFS error (device sda4): bad tree block start
> 16883770880424882955 4455632896
> > [   41.902071] BTRFS: error (device sda4) in __btrfs_free_extent:6997:
> errno=3D-5 IO failure
> > [   41.911097] BTRFS info (device sda4): forced readonly
>
> When btrfs tries to read extent tree block to update its extent tree, it
> failed due to garbage on-disk data again.
>
> And extent tree update is vital for btrfs, if it fails btrfs has to
> force the fs RO to prevent further problems.
>
>
> So your fs is too damaged to grab most tree blocks and finally leads to
> fs RO.
>
> According to the error pattern, a range of garbage overwrites btrfs
> metadata, and this looks more like a hardware problem.
>
> Thanks,
> Qu
>
>
> >
> >    43.066928] BTRFS warning (device sda4): checksum error at logical
> > 166334464 on dev /dev/sda4, physical 166334464, root 288, inode
> > 350101, offset 2965504, length 4096, links 1 (path:
> > var/etc/vport/vport.mtable.5)
> > [   43.069662] BTRFS warning (device sda4): checksum error at logical
> > 166334464 on dev /dev/sda4, physical 166334464, root 285, inode
> > 350101, offset 2965504, length 4096, links 1 (path:
> > var/etc/vport/vport.mtable.3)
> > [   43.072073] BTRFS warning (device sda4): checksum error at logical
> > 166334464 on dev /dev/sda4, physical 166334464, root 284, inode
> > 350101, offset 2965504, length 4096, links 1 (path:
> > var/etc/vport/vport.mtable.0)
> > [   45.330412] BTRFS warning (device sda4): checksum error at logical
> > 440729600 on dev /dev/sda4, physical 440729600, root 269, inode 11983,
> > offset 3682304, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.330532] BTRFS warning (device sda4): checksum error at logical
> > 440860672 on dev /dev/sda4, physical 440860672, root 269, inode 11983,
> > offset 3813376, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.330542] BTRFS warning (device sda4): checksum error at logical
> > 440668160 on dev /dev/sda4, physical 440668160, root 269, inode 11983,
> > offset 3620864, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.332656] BTRFS warning (device sda4): checksum error at logical
> > 440729600 on dev /dev/sda4, physical 440729600, root 256, inode 11983,
> > offset 3682304, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.337842] BTRFS warning (device sda4): checksum error at logical
> > 440860672 on dev /dev/sda4, physical 440860672, root 256, inode 11983,
> > offset 3813376, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.337977] BTRFS warning (device sda4): checksum error at logical
> > 440668160 on dev /dev/sda4, physical 440668160, root 256, inode 11983,
> > offset 3620864, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> > [   45.392220] BTRFS warning (device sda4): checksum error at logical
> > 440672256 on dev /dev/sda4, physical 440672256, root 269, inode 11983,
> > offset 3624960, length 4096, links 1 (path:
> > usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> >
> > On Thu, Sep 17, 2020 at 10:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>
> >>
> >>
> >> On 2020/9/17 =E4=B8=8B=E5=8D=8812:52, Thommandra Gowtham wrote:
> >>> Hi,
> >>>
> >>> We are using BTRFS as a root filesystem and after a power outage, the
> >>> file-system is mounted read-only.  The system is stuck in that
> >>> state(even after multiple reboots) with below errors on console
> >>
> >> Please provide full dmesg.
> >>
> >> The provided dmesg doesn't provide much help to show the root cause.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> [   35.099841] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> >>> rd 0, flush 0, corrupt 1, gen 0
> >>> [   35.109822] BTRFS error (device sda4): unable to fixup (regular)
> >>> error at logical 166334464 on dev /dev/sda4
> >>> [   37.500975] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> >>> rd 0, flush 0, corrupt 2, gen 0
> >>> [   37.510993] BTRFS error (device sda4): unable to fixup (regular)
> >>> error at logical 440860672 on dev /dev/sda4
> >>> [   37.522128] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> >>> rd 0, flush 0, corrupt 3, gen 0
> >>>
> >>> Is there a way to make BTRFS delay moving the filesystem to read-only
> >>> after a reboot so that we can scrub the FS? Or is there a code-change
> >>> we can use to modify the btrfs module to affect this change?
> >>>
> >>> Regards,
> >>> Gowtham
> >>>
> >>>
> >>> mount options used:
> >>> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
> >>>
> >>> #   btrfs --version
> >>> btrfs-progs v4.4
> >>>
> >>> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
> >>> x86_64 x86_64 x86_64 GNU/Linux
> >>>
> >>
>
