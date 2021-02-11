Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4431828E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 01:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBKAUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 19:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBKAUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 19:20:45 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B49C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 16:20:05 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id d3so1189740uap.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdcBciI5dfanQTY+70t9VGYA9oi5LxXP+NyAkJ3yg1o=;
        b=ScbqsbH83wplqWewqBq39XJ3tvPFS8DPBVbfz69J9Q2Scrhu6oCO7ddE2hXMgOO5pf
         Rl2riq9q7lKo8lmlWyQTWf2rPPHaHBwwaxdb9ktMDJoD5xLGrJ7/WIcVLObXAN4FG7yH
         TQxMKLfsOtlei+K9PyUvs3g0J2GVgL2GTIteB82ilYX2qR1pBDUZe826Z4KQlDh/JmYO
         1g6rleCI/bMWCbouIiTrEwMaFj8OF1+R1QFhxzR45Y/Av1Zbr6D+/RhBqzMMkJRRNBZQ
         bu0Kg32PhkALC0Odv7W/MyS7u7hkUkP5Yr8MvFPmYhQrl8hJASbePu/hESH5ALiOa1Ed
         rF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdcBciI5dfanQTY+70t9VGYA9oi5LxXP+NyAkJ3yg1o=;
        b=Oemb0f4cpC19GyZFkXwhf7Or2ZS+N/c+5IAVaHhIjijvG9l2h9GGplpsqpDMoZO65n
         TL9/YsPvYZDEmoOy9c0damZ7eFSH//pybH/+w0HxWBCBQfhowBiz/np4xMQEQO0NC2r0
         cyjC/wKy3kqVUsjhwPC4HqY6V8JrAnka9fUEDh3DtMLorw48gn9tC4qeVoUymvAEwtqP
         F6zgSAZInzh3gdpC0s766RQaI12W8jFLCaETZ/E8j4J5kWx8BcQQyd6rr8osr6vmXsfX
         gWzDptiXELwbgXlxgfYj8/vJUg/2UF/rZdxTC5NHxLRUIDeBOS6jnMEed2V8+dYhj/Ek
         EVUA==
X-Gm-Message-State: AOAM532fL6ckQPwNNtR2DLsZtzbAqGWsYJBwP1iMTbZguQdhBFttqsyw
        7VVjkIn18PalmJaNuMmghg8Z6ulbUJN0M1/kSlc6eDKo3b3ghHwa
X-Google-Smtp-Source: ABdhPJxvsfJ0re/xTmc+CoQ5hAJXbxCQfeNQY1VB7InjvTDl8hIzmaUZ4GM/RLxCGjkyiiV/F6crs02sT9zVlvXXzZo=
X-Received: by 2002:ab0:3048:: with SMTP id x8mr3876383ual.46.1613002805060;
 Wed, 10 Feb 2021 16:20:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it> <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com> <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
In-Reply-To: <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 10 Feb 2021 17:19:48 -0700
Message-ID: <CAJCQCtTV2S0GWqT8Q+KkFnLo4CrmGcDLS=RAvfeBdh4xkoVUPg@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 12:14 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> Hi Chris,
>
> it seems that systemd-journald is more smart/complex than I thought:
>
> 1) systemd-journald set the "live" journal as NOCOW; *when* (see below) it
> closes the files, it mark again these as COW then defrag [1]

Found that in commit 11689d2a021d95a8447d938180e0962cd9439763 from 2015.

But archived journals are still all nocow for me on systemd 247. Is it
because the enclosing directory has file attribute 'C' ?

Another example:

Active journal "system.journal" INODE_ITEM contains
        sequence 4515 flags 0x13(NODATASUM|NODATACOW|PREALLOC)

7 day old archived journal "systemd.journal" INODE_ITEM shows:
        sequence 227 flags 0x13(NODATASUM|NODATACOW|PREALLOC)

So if it ever was COW, it flipped to NOCOW before the defrag. Is it expected?


and also this archived file's INODE_ITEM shows
        generation 1748644 transid 1760983 size 16777216 nbytes 16777216

with EXTENT_ITEMs show
        generation 1755533 type 1 (regular)
        generation 1753668 type 1 (regular)
        generation 1755533 type 1 (regular)
        generation 1753989 type 1 (regular)
        generation 1755533 type 1 (regular)
        generation 1753526 type 1 (regular)
        generation 1755533 type 1 (regular)
        generation 1755531 type 1 (regular)
        generation 1755533 type 1 (regular)
        generation 1755531 type 2 (prealloc)

file tree output for this file
https://pastebin.com/6uDFNDdd


> 2) looking at the code, I suspect that systemd-journald closes the
> file asynchronously [2]. This means that looking at the "live" journal
> is not sufficient. In fact:
>
> /var/log/journal/e84907d099904117b355a99c98378dca$ sudo lsattr $(ls -rt *)
> [...]
> --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd4f-0005baed61106a18.journal
> --------------------- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000bd64-0005baed659feff4.journal
> --------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd67-0005baed65a0901f.journal
> ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cc63-0005bafed4f12f0a.journal
> ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cc85-0005baff0ce27e49.journal
> ---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cd38-0005baffe9080b4d.journal
> ---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cd3b-0005baffe908f244.journal
> ---------------C----- user-1000.journal
> ---------------C----- system.journal
>
> The output above means that the last 6 files are "pending" for a de-fragmentation. When these will be
> "closed", the NOCOW flag will be removed and a defragmentation will start.
>
> Now my journals have few (2 or 3 extents). But I saw cases where the extents
> of the more recent files are hundreds, but after few "journalct --rotate" the older files become less
> fragmented.

Josef explained to me that BTRFS_IOC_DEFRAG is pretty simple and just
dirties extents it considers too small, and they end up just going
through the normal write path, along with anything else pending. And
also that fsync() will set the extents on disk so that the defrag
ioctl know what to dirty, but that ordinarily it's not required and
might have to do with the interleaving write pattern for the journals.

I'm not sure what this ioctl considers big enough that it's worth just
leaving alone. But in any case it sounds like the current write
workload at the time of defrag could affect the allocation, unlike
BTRFS_IOC_DEFRAG_RANGE which has a few knobs to control the outcome.
Or maybe the knobs just influence the outcome. Not sure.

If the device is HDD, it might be nice if the nodatacow journals are
datacow again so they could be compressed. But my evaluation shows
that nodatacow journals stick to an 8MB extent pattern, correlating to
fallocated append as they grow. It's not significantly fragmented to
start out with, whether HDD or SSD.



-- 
Chris Murphy
