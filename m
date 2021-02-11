Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4E318691
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKI4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 03:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBKIzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 03:55:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2BC06178B
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Feb 2021 00:46:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so4750167wmq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Feb 2021 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCpQqQlNZTZO+XpRc2C0JsKxWVfJizd3Zbn0YDeDFfE=;
        b=vzWNC5MAkXX7+AnJHgKeIEVoo9VfmpFB/iVKxNqvHGbYk/yr0tiEFZP5RU2c85blam
         exXXLMUThZI+zlJOg+TpwFH18pqPkdaPahRxfavb40ddyzn5xpEvUKXsyWkVjO7v/ncD
         09NAikFXLu1QudsLZ9yJ/2m5DkErXkNBMVuDyE60/pSWsyLoe8osvjSV2MIR5iNgMsjM
         HINth06K75zj7dxslbL5h9+r1uF+BJYYHTEXy8AXT69Pn2jO50j2xUmFVDIyebBP5SEy
         OQHdPtm4F0cDtV9kZaBGxYvHhLpZMdETc1ffABFFjOvMcr0r71t5kYGx4agrV32bTvtq
         3AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCpQqQlNZTZO+XpRc2C0JsKxWVfJizd3Zbn0YDeDFfE=;
        b=Z0FiPt6FDwoobyKQLxiiy7NLbNlT6IjFeTpDHLHEWgrQJlUh5BtHzjtDw1hzjc0Vb4
         xg/48CAOyQSmyhUUD+x9knekZ0KlYROmz+dkvaI5lXobfi5g9bKEMfhQcXP4O1bF1DQC
         eLKfLt0w2ibG/WCU9aSm3mlUdKmW3naVq9Io2cFwWfCbUTsAVfNQLPnfB3lGLvhRPh+r
         tyZYOwEota5llgoHPBSY4iNyCMkf+jko19oIJcXdpJyyrEG39SEVC+Dlz2ZHrGCLU7TH
         ZzdFsPdU/oTKxXRVoPcRh+S8+nOtM6qrQui/0MvDybBogyhrcDehBfU9j3nCsU9gQIhT
         VfHQ==
X-Gm-Message-State: AOAM531WqfiEAVR1prwP8Y3N3xrlyVvbavAQOF0bUz2QLgxwkVuFZN9C
        ekZBsPoEQU9s+JnGtzZJ/ib2CG5ROxhf61lZ+jrTuw==
X-Google-Smtp-Source: ABdhPJyRCsPYEgQ9czvoeyQApvgSLCHVRjpSUmQ4lI7KkJsT1LudeHRXtAHJ5TgQt2J0fsQ3zsrRNABk/KvZqcJ+EuA=
X-Received: by 2002:a1c:998a:: with SMTP id b132mr3950438wme.37.1613033183674;
 Thu, 11 Feb 2021 00:46:23 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it> <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it> <20210211030836.GE32440@hungrycats.org>
 <20210211031306.GL28049@hungrycats.org> <CAJCQCtQ48Vy+FxoqDseu=bAsna5gMo8mc8Fo+ybRG3v_SYFbjg@mail.gmail.com>
 <20210211061220.GF32440@hungrycats.org>
In-Reply-To: <20210211061220.GF32440@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 11 Feb 2021 01:46:07 -0700
Message-ID: <CAJCQCtQnvVUVhTPQ1v=mw=jDBbsHb5HAa5=s3E+AWuBD7pSO2g@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 11:12 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:


>
> If we want the data compressed (and who doesn't?  journal data compresses
> 8:1 with btrfs zstd) then we'll always need to make a copy at close.
> Because systemd used prealloc, the copy is necessarily to a new inode,
> as there's no way to re-enable compression on an inode once prealloc
> is used (this has deep disk-format reasons, but not as deep as the
> nodatacow ones).

Pretty sure sd-journald still fallocates when datacow by touching
/etc/tmpfiles.d/journal-nocow.conf

And I know for sure those datacow files do compress on rotation.

Preallocated datacow might not be so bad if it weren't for that one
damn header or indexing block, whatever the proper term is, that
sd-journald hammers every time it fsyncs. I don't know if I wanna know
what it means to snapshot a datacow file that's prealloc. But in
theory if the same blocks weren't all being hammered, a preallocated
file shouldn't fragment like hell if each prealloc block gets just one
write.


> If we don't care about compression or datasums, then keep the file
> nodatacow and do nothing at close.  The defrag isn't needed and the
> FS_NOCOW_FL flag change doesn't work.

Agreed.


> It makes sense for SSD too.  It's 4K extents, so the metadata and small-IO
> overheads will be non-trivial even on SSD.  Deleting or truncating datacow
> journal files will put a lot of tiny free space holes into the filesystem.
> It will flood the next commit with delayed refs and push up latency.

I haven't seen meaningful latency on a single journal file, datacow
and heavily fragmented, on ssd. But to test on more than one file at a
time i need to revert the defrag commits, and build systemd, and let a
bunch of journals accumulate somehow. If I dump too much data
artificially to try and mimic aging, I know I will get nowhere near as
many of those 4KiB extents. So I dunno.


>
> > In that case the fragmentation is
> > quite considerable, hundreds to thousands of extents. It's
> > sufficiently bad that it'd be probably be better if they were
> > defragmented automatically with a trigger that tests for number of
> > non-contiguous small blocks that somehow cheaply estimates latency
> > reading all of them.
>
> Yeah it would be nice of autodefrag could be made to not suck.

It triggers on inserts, not appends. So it doesn't do anything for the
sd-journald case.

I would think the active journals are the one more likely to get
searched for recent events than archived journals. So in the datacow
case, you only get relief once it's rotated. It'd be nice to find an
decent, not necessarily perfect, way for them to not get so fragmented
in the first place. Or just defrag once a file has 16M of
non-contiguous extents.

Estimating extents though is another issue, especially with compression enabled.

-- 
Chris Murphy
