Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CF1CA268
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 06:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgEHEqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 00:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgEHEqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 00:46:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3798C05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 21:46:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u16so9171191wmc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz6SJzpv3oBsuvd396eFsU8z0doZ8u8fdXaIkVru+I4=;
        b=yXT82fHRfnJVc3WMaN7rTimGwsgmQ0PU2nqOWkUuIo1Mv2sAzEF7uMM6P1b1h6C33N
         cv7AeLK/XIZcVan6yXmfRlRd5x23PG/RievN14ksrQCRnrdT81SIFvo43El2vOzgLRQC
         wWw+HJ7fFHsdQKeskWelO9ua4Q3qUoYpigR87ezn47JfZfu4nNFTouJpmZIjGoaEqKTV
         iMD0CPNr4ifVW1WAK1zQJKOGxvjAg33R2gWQTslOgCYVSqVdDB1Bez+EeJ7SwzK6MmbS
         idgJXYlF9I3Ifv6F42q8Bvb2dypxQJV8P4gvPD/R1cf2wXbHQF+R8vVf7d47M6lWyMCO
         hRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz6SJzpv3oBsuvd396eFsU8z0doZ8u8fdXaIkVru+I4=;
        b=VUh3PBRmTYCH4p6cYDPOX8+IEBcJNKXflXoudTdhGYg7i467LtIP6cDbVrUG6S2X7s
         Fxjue91zsSP8sQsTM0oyWc486yicNB6mrUuX2nWcyO/kSn/4o8iKS6QU6a07L7ZYiQxT
         cRarzjDkgDuTUjV7cTHr5c13ybnpPhDhcehCKJr1azK3y3kriDiuQTnZee3kp21vZAzc
         I9izxlDNqudpeOf2XZlimkMpWSZO8JFJAWaYhSreeqvlGZJWsxpLseDYsDXo0PKsy4fV
         uxJMCNWDICtDQs+jKb2S1M3/JtaULLBSxTjqqKwhLDhWHXSA6Szze76QPbiw15NAdj51
         NGPA==
X-Gm-Message-State: AGi0Pub0RtYH5qxo07MzEBpg68k9p2fhoWMYxcZ5jEXqwiYYAprSToGY
        Ud1gXvhbP3Uxyq1T8AAwR4Q8HAMHtl/n9Bkbt15thA==
X-Google-Smtp-Source: APiQypKgCyTkG3WHhYEDQe7kdOQP6EL/V1SdVthtYn75/KxomZQuaXPjKRtzlnfiTQGVisVHlWXZjgyI8jAnKsV6ToQ=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr14149823wmc.11.1588913161356;
 Thu, 07 May 2020 21:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
In-Reply-To: <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 May 2020 22:45:45 -0600
Message-ID: <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 10:42 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 8/5/20 2:21 pm, Chris Murphy wrote:
> > What does 'iotop -d 10 -o' report? I'm expecting around 300MB/s reads.
>
> 91872 idle root      149.25 M/s    0.00 B/s  0.00 %  0.00 % btrfs scrub
> resume -c3 /home
> 91873 idle root      157.77 M/s    0.00 B/s  0.00 %  0.00 % btrfs scrub
> resume -c3 /home
>
> > The ETA is +14 hours what you posted 21 hours ago. So yeah that's
> > fakaked, but at least it's not saying it'll be done in year 5544!
>
> I did cancel when I went to bed and resumed when I got up three hours
> later on two occasions, so subtract six hours.
>
> > I've always seen the ETAs be pretty accurate so I don't know what's going on.
>
> Maybe it screws up once you cancel and resume too many times?
>
> > 3082813.44MB to go divided by 300MB/s is 171 minutes. Or just under 3
> > hours. So the time left / ETA is wrong based on this rate, if it's a
> > stable rate, which it might not be.
>
> I have an I/O load graph on my screen and it shows 100% read load on
> both drives at all times, with an I/O rate of around 130-160 M/s per drive.
>
> > What are the current mount options for this file system?
>
> /dev/sda on /home type btrfs
> (rw,noatime,space_cache,autodefrag,subvolid=5,subvol=/)
>
> Thanks,
>         Andrew

I don't know if space_cache v1 can negatively impact scrubs but it
does negatively impact other things especially on larger file systems
with a lot of free space remaining. v1 cache exists as data blocks, v2
cache is a dedicated 'free space tree' and resides in fs metadata.
It's the inverse of the extent tree.

A conservative approach that might speed things up:

# mount -o remount,clear_cache,nospace_cache /mnt

Once it's done:

# mount -o remount,clear_cache,space_cache=v2 /mnt

This sets a feature flag, and the next time you mount normally, it'll
use v2. You could do this now during the scrub, but it might slow it
down a bit while the new cache is being created. If the file system
isn't busy it might take a minute to build.

Anyway, I'm pretty confident this scrub will finish in about 2.5 hours
if you just leave it as is.

-- 
Chris Murphy
