Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C41CA54D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHHhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 03:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEHHhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 03:37:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA67C05BD09
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 00:37:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so659489wrp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 08 May 2020 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2uncTqviO8yb0R8S9xA4n25XBfLCuH1RAp4bZezJfpI=;
        b=JWAwXfjfDtYgUQU0eIX2b6T4ADnB/n0lMGvBm06pN15Zr9ormsFeTlnFG0pw5IbMn3
         i9dCQ17zrXQ3EjH7+maH51JlyyS2viELXTZx7T+Btx7Pg4IH6rUM+FQYuQFIVwF4PHE6
         J4fevem3zlY3xM3Z8CTRfdENhsM3dPInGnvz92FF6K16Z+5EFHsrp/1FixDflLKYIaD7
         B4fHGMrmG0cQg6Jc7v0eWlnp2UY4HPB0OZqTEitl477GMO93/okBLyBTGqqM63vEUzI6
         /EXJeIL5ojaKsbzvFMKM321V4Rp5Ro6C+PgdfvN5lJP2Qf8ilqPnkl/82kdokhPnXIu2
         Qb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2uncTqviO8yb0R8S9xA4n25XBfLCuH1RAp4bZezJfpI=;
        b=NL3CSBSgx/rkjL7k6Lx64ws1/pnLvPmS3MSzc5lgi79y+iVR6FYqlmv7tIUMJFV6RQ
         h8w3Ud8DqZI0AUQ0MkfVdM5PBrShu92uvHPE1zn2rGpmk5HcnHAesyAJOy23f+dgH4uX
         w2M/DGMPh+oYjwbKtuLp1NYvrT6agidAZ5W/XWjLhRHzkfXrsYUJemO5pdR6bw11DI5T
         ZJgGfDYDIcPCiwOBgZbPbGwtivJ+EqdB7epp9RC9GMlZlov5kEm+uAIG1K6SnmRT1qgR
         cWgsyeW/NjvHGQcb356n70Z2X7nr50sLzFUvKryaXHY07CdqTB2ryXbWkBI0F0MrGNP+
         9lOQ==
X-Gm-Message-State: AGi0PuZ1pkX3XjiJDZq12Fs0vZf0h0/u2S6Tdu9Bzqerd0zsXpf2MygF
        9gu669P5GfPisCR4/6n6DBmnhiMVqqvjiCu05lS8Vw==
X-Google-Smtp-Source: APiQypKbt+AhhwY3+Myumo2/SO42YhdCHSgIB5iZx4dgVwo/UssKlHyNcRHqfeIRJRJiUfT4SA6KCpqM9DA3s4Pwklg=
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr1314291wrv.236.1588923436547;
 Fri, 08 May 2020 00:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au> <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
In-Reply-To: <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 8 May 2020 01:37:00 -0600
Message-ID: <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 10:52 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 8/5/20 2:45 pm, Chris Murphy wrote:
> > I don't know if space_cache v1 can negatively impact scrubs but it
> > does negatively impact other things especially on larger file systems
> > with a lot of free space remaining. v1 cache exists as data blocks, v2
> > cache is a dedicated 'free space tree' and resides in fs metadata.
> > It's the inverse of the extent tree.
> >
> > A conservative approach that might speed things up:
> >
> > # mount -o remount,clear_cache,nospace_cache /mnt
> >
> > Once it's done:
> >
> > # mount -o remount,clear_cache,space_cache=3Dv2 /mnt
> >
> > This sets a feature flag, and the next time you mount normally, it'll
> > use v2. You could do this now during the scrub, but it might slow it
> > down a bit while the new cache is being created. If the file system
> > isn't busy it might take a minute to build.
>
> Thanks, I didn't know that - I just used the defaults in /etc/fstab as
> follows:
>
> UUID=3D85069ce9-be06-4c92-b8c1-8a0f685e43c6 /home         btrfs
> defaults,autodefrag,noatime
>
> I'll put space_cache=3Dv2 in there as well.

Is there anything else going on? What do you get for 'top -d 30'

Autodefrag can sometimes be expensive, when it's doing copies in the
background. This isn't inhibited during scrub.

You do not need to put space_cache=3Dv2 in fstab. It's a one time use,
and it needs to be used with clear_cache. When you use it, a feature
flag will be set that will cause it to be used automatically each time
the file system mounts. Really the only thing that needs to be in
there is 'noatime'.


>
> > Anyway, I'm pretty confident this scrub will finish in about 2.5 hours
> > if you just leave it as is.
>
> I'm not.  It's still not reporting any forward progress, just moving the
> ETA ahead:
>
> $ sudo btrfs scrub status -d /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub started:    Thu May  7 15:44:21 2020
> Status:           running
> Duration:         5:40:13
> Time left:        1:23:04
> ETA:              Fri May  8 16:11:31 2020
> Total to scrub:   3.66TiB
> Bytes scrubbed:   2.94TiB
> Rate:             151.16MiB/s

OK I screwed up the previous math. I love it when I do that. Since
this is -d the numbers are for this device.

0.72T remaining
0.72=C3=971024=C3=971024=C3=B7151=C3=B760=C3=B760=3D1h23

Are there any messages in dmesg?

All of these numbers look sane, compared to your first post. But that
ETA keeps increasing suggests the scrub isn't proceeding at the
reported rate. As if it's busy doing something else.


--=20
Chris Murphy
