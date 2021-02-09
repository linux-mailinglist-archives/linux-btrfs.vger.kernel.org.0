Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C61131453F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBIBGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Feb 2021 20:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBIBGC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Feb 2021 20:06:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C7C061786
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Feb 2021 17:05:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so833070wmz.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Feb 2021 17:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39Kv2EoPZ+TI/R6Q3+A72vUK0m8Ox0LQ6vttjjiXFbk=;
        b=aPBdrrH2e0425tPsGGxmjymQIy5spjbIOOroMij3ImfUvw0I8PPC6ZIF+R+NTeA+GS
         ONdZYGvhSyaayMHaTPZPfoxgaAENdmajPBxUn/QKMuRYrIPdSB9KAYMink/D+yoCe6ny
         L+Is3ri8xarXWi219oJ0Iri27e91ZYY0yZ0bNSd4x6bBE0d3NGbg/phGR85YmX9AcmBe
         wpyUwvqrc+QPGXhWe+WyNYX2YEwyErac6BwpV+ra53yyZtrM8wy81wtuyhVauOXlVEFR
         Oo0e5fNSnRuJGiV/MNpLuLQR70x5+VrkaoEuPy5R417zSdudZdFJ4QX8387r1nG6fj1T
         MxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39Kv2EoPZ+TI/R6Q3+A72vUK0m8Ox0LQ6vttjjiXFbk=;
        b=Yhi346jtJEiyoCA9iKIzxJZPgLow91ksnSJ0gGV9/9Hj63tnQ/Dr3FmhKjYyK2pxh9
         heYg1I0+QrRpjTwd/ZxK4VLd1/HOt02deZxcfG+SPomB+nQmZsLBMafubcUo3UX32vjW
         gZAnTeQW8rwRJdSXQUdquqVIdTx/oWWYvflahQXQFv80pWkX+FO1yGYPAwjqdTMokgyo
         JFNs4Q60xR29SmguF0y4ENwAoyzT6v7pXw7pUdeH8Ipy7FnwJH/8eWoLz+wkvVCKWG0R
         BiC/9gBt/sgAfnVulEzJ5iNMVXR4A3so4ncQMSzlYpcdxWQUU3QbbgsqmLMnmZDg56NG
         0GwA==
X-Gm-Message-State: AOAM532dFgxSIa3HY4rx7RKUZxZmARIJEW7c7/5q7gF3SyoqQCMkcxs5
        BWULp91z4h70gSjfk7e+AE30xaz++3RiR1DI6robMA==
X-Google-Smtp-Source: ABdhPJz9asI9FrMBqGgSH1W0AzXPdEa23DgxOv//yGcApI6D09u8e8lwpHDndos3uuVfoZqpeXnC7ciC8CuqyUzT9pc=
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr1120585wma.124.1612832719002;
 Mon, 08 Feb 2021 17:05:19 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <20210208222154.GD32440@hungrycats.org>
In-Reply-To: <20210208222154.GD32440@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 8 Feb 2021 18:05:03 -0700
Message-ID: <CAJCQCtTkDgehogBXCOgvZp7A44a=UKjwotE6S1k2HSpQzT5s7g@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 8, 2021 at 3:21 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:


> defrag will put the file's contents back into delalloc, and it won't be
> allocated until a flush (fsync, sync, or commit interval).  Defrag is
> roughly equivalent to simply copying the data to a new file in btrfs,
> except the logical extents are atomically updated to point to the new
> location.

BTRFS_IOC_DEFRAG results:
https://pastebin.com/1ufErVMs

BTRFS_IOC_DEFRAG_RANGE results:
https://pastebin.com/429fZmNB

They're different.

Questions: is this a bug? it is intentional? does the interleaved
BTRFS_IOC_DEFRAG version improve things over the non-defragmented
file, which had only 3 8MB extents for a 24MB file, plus 1 4KiB block?
Should BTRFS_IOC_DEFRAG be capable of estimating fragmentation and
just do a no op in that case?


> FIEMAP has an option flag to sync the data before returning a map.
> DEFRAG has an option to start IO immediately so it will presumably be
> done by the time you look at the extents with FIEMAP.

I waited for the defrag result to settle, so the results I've posted are stable.


> Be very careful how you set up this test case.  If you use fallocate on
> a file, it has a _permanent_ effect on the inode, and alters a lot of
> normal btrfs behavior downstream.  You won't see these effects if you
> just write some data to a file without using prealloc.

OK. That might answer the idempotent question. Following
BTRFS_IOC_DEFRAG most unwritten exents are no longer present. I can't
figure out the pattern. Some of the archived journals have them,
others have one, but none have the four or more that I see in active
use journals. And then when defragged with BTRFS_IOC_DEFRAG_RANGE none
of those have unwritten extents.

Since the file is changing each time it goes through the ioctl it
makes sense what comes out the back end is different.

While BTRFS_IOC_DEFRAG_RANGE has a no op if an extent is bigger than
the -l (len=) value, I can't tell that BTRFS_IOC_DEFRAG has any sort
of no op unless there's no fragments at all *shrug*.

Maybe they should use BTRFS_IOC_DEFRAG_RANGE and specify an 8MB exent?
Because in the nodatacow case, that's what they already have and it'd
be a no op. And then for datacow case... well I don't like
unconditional write amplification on SSDs just to satisfy the HDD
case. But it'd be avoidable by just using default (nodatacow for the
journals).

-- 
Chris Murphy
