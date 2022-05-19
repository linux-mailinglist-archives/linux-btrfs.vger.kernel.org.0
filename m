Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CFB52D196
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiESLgo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiESLgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:36:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A1393CB
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:36:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b32so5906561ljf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcIb8CgIo2VupRFlv5IFQcvJdEf06erQ8CuIpQiSZGU=;
        b=SI8XOgxPbZT5C4Wrr8qRT+tOl9krCeFpi0OV3RDMrtoV+1ecAIAI+Ix9qwPdAxtPRz
         98wwZmlgD2i2Uo0aYmk0s9ZE0b1cHlHPmjGhsqIrN20bV+1EcP5HQR3RwaLOWbC+AHzj
         P8ShRCa+7x1kHxfTir78HCwWf507Xov5C+W6cqtN9cp7GfToOBTQ7pQKigUKfPF8R5UU
         vT3Atpqgs6kGXxGbR9CzIBIDCgd48DluH0+XChterMlipkXY7RMGaLogw0qr/s1Y0gwn
         TecILVrnqS5sqjliC3lb+V/doTxP6nsYYL5brvW+Dy0ICfM7boknwK5KqQ2zA5P5W2QA
         hgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcIb8CgIo2VupRFlv5IFQcvJdEf06erQ8CuIpQiSZGU=;
        b=EF215oauSxB1jJMXBD6YJcEejzmbSlOpvPCfItu4gjqyYpNUld0nz1ZllnQGHAIxKK
         GBKWqITa10pqGF4jkXFjbmIoL4q9GZ22olpyk8snLY93IYw7qRbvzWlA0cBQ6D0GZ0j3
         LVhFxQUMwREXqrW0I1z9dHUjBjEO2iHMbHRrWbU91OtkhdcRaX76ry1EkNcf3zQd0T9x
         h8ooyq8ScMghwEbL3tQmriGhE/OoC1yOlU4ocbcECuBmFwNgaJT7jLvUh7oh0AscdWdL
         8ZCF+RctBeUFeUTxRWdBkzVVVadKx1YM2hTcfkC31rUz6i1F+nD/QMKx69cZ/9k+fsO6
         O9XQ==
X-Gm-Message-State: AOAM530bah/nFNh9gODKKg+hhYlCafcbPHT98PgxGjEtZuQpsGYZWhfq
        6Yz9L2PCQaK6kJ4Mdo4wbDZT5xmRlaKYHKdtcwF4RSzWe1QcSg==
X-Google-Smtp-Source: ABdhPJwa62lELjLzBE0/QJTZlUIRxb4o87Wbrx0HXMUVv2ikr98nnwhlWJdiAW1XyTpTstNYh5yph19fjasXwjohfRs=
X-Received: by 2002:a2e:9649:0:b0:24f:15e6:a6c5 with SMTP id
 z9-20020a2e9649000000b0024f15e6a6c5mr2422023ljh.86.1652960196855; Thu, 19 May
 2022 04:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
In-Reply-To: <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
From:   arnaud gaboury <arnaud.gaboury@gmail.com>
Date:   Thu, 19 May 2022 13:36:17 +0200
Message-ID: <CAK1hC9u_9w5K6Mz=k+AhzjNcZ4N_7fmaDtrLqVSpM3ttb46muQ@mail.gmail.com>
Subject: Re: can't boot into filesystem
To:     Graham Cobb <g.btrfs@cobb.me.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I take the opportunity of this thread to find a solution on my initial
probel: how to use an external device to store the backup snapshots?
'btrfs subvolume snapshot' command will not allow me to store on
another device. So my idea was to add the external device to my btrfs
filesystem.
I can do it with the 'btrfs device add' as the device has a btrfs
filesystem. I was then trying to add this device to my fstab and then
came my issue.
my fstab:
----------------------------------------------------
# /dev/sdb2 LABEL=magnolia
UUID=712ec7ac-0d1e-40fa-81a1-a8f049750d6e    /             btrfs
  rw,noatime,compress=zstd:3,discard=async,ssd,space_cache,commit=120,subvol=/@
   0 0

LABEL=magnolia                    /btrbk_pool    btrfs
noatime,compress=zstd:3,discard=async,ssd,space_cache,commit=120,subvolid=5
   0 0

# /dev/sdb1 LABEL=BOOT
UUID=225C-FDAC          /boot         vfat
rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro
   0 2

# /dev/sdb2 LABEL=magnolia
UUID=712ec7ac-0d1e-40fa-81a1-a8f049750d6e    /home         btrfs
  rw,noatime,compress=zstd:3,discard=async,ssd,space_cache,commit=120,subvol=/@home
   0 0
------------------------------

the device I want to add is on /dev/vg0/back_ssd.
How can I modify my fstab accordingly?

On Thu, May 19, 2022 at 12:39 PM Graham Cobb <g.btrfs@cobb.me.uk> wrote:
>
> You will probably get a much more useful reply from a developer later
> but in the meantime...
>
> Probably your rescue CD has an older kernel - new kernels do more
> validation on the filesystem. In that case, there is something wrong
> with the filesystem but the old kernel hasn't noticed.
>
> You might want to try a rescue CD based on a newer kernel. And/or you
> should do a "btrfs check" with the latest btrfs-progs that you can run.
> You could even chroot into /mnt/@ (bind mounting dev, proc and sys, of
> course) and see if you can run the btrfs image from /mnt/@/usr/bin/btrfs
> while booted in your rescue CD. If so, try using it to do a "btrfs
> check" on your filesystem. If not, use the btrfs check from the rescue
> CD itself. In either case, DO NOT SPECIFY --repair UNLESS A DEVELOPER
> TELLS YOU TO!!
>
> By the way, /mnt/@ IS your root - it isn't a copy of it. You can see in
> fstab that the "@" subvolume of your disk gets mounted into "/" on boot.
>
> On 19/05/2022 10:58, arnaud gaboury wrote:
> > My OS has been freshly installed on a btrfs filesystem. I am quite new
> > to btrfs, especially when mounting specific partitions. After a change
> > in my fstab, I couldn't boot into the filesystem. Booting from a
> > rescue CD, I changed the fstab back to its original. Unfortunately I
> > still can't boot.
> > Here is part of the error message I have:
> > devid 2 uuid XXYYY is missing
> > failed to read chunk tree: -2
> >
> > part of my fstab:
> > LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
> > LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
> > LABEL=magnolia   /home   btrfs .....,subvol=/@home
> > ......
> >
> >
> >
> > I am now back to rescue CD. I can mount my filesystem with no error:
> > # mount -t btrfs /dev/sdb2 /mnt
> > # ls -al /mnt/
> > @
> > btrbk_snapshots
> > @home
> > home
> >
> > I can see my filesystem when I ls the @ directory.
> > What can I do to boot my filesystem which is perfectly reproduced in
> > the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
> > the root of /mnt  when my device sdb2 is mounted?
> > Sorry for the lack of formatting and info, but I can't use the browser
> > from the rescue CD so I am writing from another computer.
>
