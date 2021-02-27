Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16E326AEF
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 02:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhB0BFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 20:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0BF3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 20:05:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE74C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 17:04:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w11so10240743wrr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 17:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3OagkZL86HK/mpGoWg4Zz3GlZP+Ctqq0is5m0k4uKI=;
        b=TSo3eLA+4usddDDy8dxq3JuinN6Xpo/jcfTFiNTm2YwCD9jwd6djcC9SjlJFDkl7fX
         taylu+UeBykN8cVQG0XyUWllUbCxdg0fr50I9VvV6ZOSlP9MJkedkNf4UUYuTkeehTIO
         RgWd1Jgxzf0+i6Naj6EEqEVPZbyPh9flJ3VnceasN92AOOQwR33SE+mmMgJXmN5Q4Wb/
         abBf+5bA/+KiP5dswQeD48ndSRbPzUikEPhbU3g5KmtCKYhsFMVQ95sQI5YniGj0xSFf
         95cV6zbqOnVHXJPbh+pM57lbRWjqT/KreCJlxZxUYMZ7g2PeSeXQz2TPCW2G2iAp3yOq
         Zx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3OagkZL86HK/mpGoWg4Zz3GlZP+Ctqq0is5m0k4uKI=;
        b=pY30xuUT5zyuzgVDdmB3/oiNJkTEkPBn+5YJSmRc+T/LV1VZGqGFNyfaG6cCfZQQf3
         3Y83/3N96GL1IuQnr0huZOYTLxsVs6Z1t7jBOaekNivoZw10IOsfFo4aNuCX6s4Om4ou
         osFy1nHktg10QtO/dsuK7c6MiAeLm5WwGxu9doyTgtx4qqqjWk+kMYOrkPcdaxy4ON/R
         q1OfMZxn9alLHfa52o+pAlo4JyyaFg03cteLEWpFW8X4iNDa8yjj99WoxKUSulvyFX+p
         e4vg5OnNR+Va/S28KD2Y2ucQyibmjS71//If4XRkXC/xPaOEBmzB5xypRvplePM15RNf
         xXTw==
X-Gm-Message-State: AOAM5327KweHbJTrhKOYb5iodEQz94Cq6RWPMtgXgt2H/xfva47/UuLH
        q9wFmnAVPTfCf1y5e7xjIgmPe9qkdlVNrTzpOlHayQ==
X-Google-Smtp-Source: ABdhPJxHpG3gFYH3e2aScKUaUnmWQ7ZE6xrHyblL4kTaUqmgJEoN8PVCxUlNzChGLugGtFtzKR1UB8vbau0AckWCil8=
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr5889900wra.42.1614387887792;
 Fri, 26 Feb 2021 17:04:47 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com> <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
In-Reply-To: <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Feb 2021 18:04:31 -0700
Message-ID: <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 26, 2021 at 9:01 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:
>
> > > I think you best chance is to start out trying to restore from a
> > > recent snapshot. As long as the failed controller wasn't writing
> > > totally spurious data in random locations, that snapshot should be
> > > intact.
> >
> > i.e. the strategy for this is btrfs restore -r option
> >
> > That only takes subvolid. You can get a subvolid listing with -l
> > option but this doesn't show the subvolume names yet (patch is
> > pending)
> > https://github.com/kdave/btrfs-progs/issues/289
> >
> > As an alternative to applying that and building yourself, you can
> > approximate it with:
> >
> > sudo btrfs insp dump-t -t 1 /dev/sda6 | grep -A 1 ROOT_REF
> >
> > e.g.
> >     item 9 key (FS_TREE ROOT_REF 631) itemoff 14799 itemsize 26
> >         root ref key dirid 256 sequence 54 name varlog34
> >
>
> Using this command I got a complete list of all the snapshots back to
> 2016 with full name.
> I tried to restore from different snapshots and using btrfs restore -t
> from some other older roots.
> Unfortunately no matter which root I restore from, the files are
> always the same. I selected a list of some larger files, namely ppts
> and sgmls from one of our own tools, and restored them from different
> roots. Then I compared the files by checksums. They are the same from
> all roots I could find the files.
> The output of btrfs restore gives me some errors for checksums and
> deflate, but most of the files are just listed as restored.
>
> Errors look like this:
>
> Restoring /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/AWI/AWI_6.14-2_2015.zip
> Restoring /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/AWI/installInstructions.txt
> Done searching /Hardware_Software/ABAQUS/AWI
> checksum verify failed on 57937054842880 found 000000B6 wanted 00000000
> ERROR: lzo decompress failed: -4
> Error copying data for
> /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMA_win86_32_2012.0928.3/setup.exe
> Error searching
> /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMA_win86_32_2012.0928.3/setup.exe
> ERROR: lzo decompress failed: -4
> Error copying data for
> /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMAInstaller.msi
> ERROR: lzo decompress failed: -4
> Error copying data for
> /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/setup.exe
> Error searching
> /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/setup.exe
>
> Most of the files are just listed as "Restoring ...". Still they are
> severely damaged afterwards. They seem to contain "holes" filled with
> 0x00 (this is from some rudimentary hexdump examination of the files.)
>
> Any chance to recover/restore from that? Thanks.

I don't know. The exact nature of the damage of a failing controller
is adding a significant unknown component to it. If it was just a
matter of not writing anything at all, then there'd be no problem. But
it sounds like it wrote spurious or corrupt data, possibly into
locations that weren't even supposed to be written to.

I think if the snapshot b-tree is ok, and the chunk b-tree is ok, then
it should be possible to recover the data correctly without needing
any other tree. I'm not sure if that's how btrfs restore already
works.

Kernel 5.11 has a new feature, mount -o ro,rescue=all that is more
tolerant of mounting when there are various kinds of problems. But
there's another thread where a failed controller is thwarting
recovery, and that code is being looked at for further enhancement.
https://lore.kernel.org/linux-btrfs/CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com/



--
Chris Murphy
