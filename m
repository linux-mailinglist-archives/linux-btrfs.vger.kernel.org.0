Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D33CBBB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGPSMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGPSMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 14:12:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BEC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 11:09:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w13so6362906wmc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqAbMCViAmwRC/E8grVWZnBnH5qTwxFwwHXoF2DOLf4=;
        b=IPkmpsJeaGp9sDW4k1/g0is8puumkLqiW247spQ7EiOphPBnH4W4ce6AYMJC9vtCOt
         f2r10gEKfZg3LVRk8cMZ1tpB9D6W766TpG5W1UcLeTLFB49pJVc2WaHh6qQlD8sDNG2U
         /hLEcqz5Ozl/UfNJIdELAOgK7Y3E91Tk76MVn1vivBvXYlUw7gLth1ieFDUmnwUOmSME
         EzJguikm5zyqh/TrnB5jc/HtERkoxGejNxXAlWFbYDK7MB/iKduLtwrsLHQ8+qTl4pS8
         A0HWPUJSUtOQObljNrFF0EP4f4w+RWJ1UjR4S8x283vganGqzs3z/tbEDEzVcu4iN+6d
         IGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqAbMCViAmwRC/E8grVWZnBnH5qTwxFwwHXoF2DOLf4=;
        b=fTpc0Sx0qDsycv/SlAQqlpuQfsL0iZ5aBiLYC92d3MkC0pUVvtLkaAPPU4m/m5itN3
         +fdVXm4xf5uyEnGF3xg4IZm4sgn/mtbZ3Dnvlcy/faYNtjM3oCOH9AX2pU8uPPGW7PQ3
         NvlEC/05Pu6rPLk1gCPJ+WEVbU691gWOHim2J2DEQdQhai3JHF8ElHRsWCRzWIUe96NP
         Az0ZRB9/ixfuSg6t8C9zUrJmogqrDXB+QGLhtPQv00EeXikSNmZGSgQxVDU1z8S3yWG1
         ZoKLD0/c7xs6U3Tdnv12axjEqu7rRTjtVMaPdI1sei0O0u8O0+qOCkdo1uofMzdciuHN
         u7Fg==
X-Gm-Message-State: AOAM533X5ecJUE0siKzMWuExn4x1tM3u3B84H2+pnMzTER/GWEhkVzxr
        a7ce2ePFv+JGkErXo3RQ0/D7vyO/gGn1TyUAp3hXQQ==
X-Google-Smtp-Source: ABdhPJwUVua9KWc6sc6L5Z4ym7kFzVjEpwqO2XnErFY7xKS38LPwa3QJyHcZORrOmxxBxLR4b3c0xeo05+XFbb6YTXo=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr18156624wmj.128.1626458956567;
 Fri, 16 Jul 2021 11:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5Dygauhft3S1nQ=S5E9Xwj4NsXCgQJkUCyacaP18A-PA@mail.gmail.com>
In-Reply-To: <CAGdWbB5Dygauhft3S1nQ=S5E9Xwj4NsXCgQJkUCyacaP18A-PA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 16 Jul 2021 12:09:00 -0600
Message-ID: <CAJCQCtRYEX0W-DcB9tjZ4as3HSAn59oWoWhUP-j__JG2M4NckQ@mail.gmail.com>
Subject: Re: what are the current best practices for maintaining a BTRFS file system?
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 16, 2021 at 10:02 AM Dave T <davestechshop@gmail.com> wrote:
>
> I am running a rolling release Linux distro (Arch) and many of my
> devices run on BTRFS file systems originally created many years ago
> (e.g., 2014).
>
> BTRFS has been mostly problem-free for me since even before 2014. The
> snapshot feature (automated with snapper or btrbk) has saved me more
> times than I can remember, so any issues I have experienced related to
> BTRFS pale in comparison to the benefits I have enjoyed from using it.
>
> I would like to know what steps I can take to keep my BTRFS file
> systems in the best condition.

In theory it's low maintenance in normal operation. The known edge
cases still needing some kernel work relate to enospc, and tend to
only be hit when (a) space consumption is high, > 90% or more
specifically when there's no longer any unallocated space (b) when the
workload changes such that there's a significant change in
data/metadata ratio, leading to premature data or metadata block group
space exhaustion. I'd say it's both rare but not uncommon, almost a
contradiction, because it's an unsolved problem. I've not hit this
problem in a very long time myself, but on #btrfs:libera.chat we see
this routinely. Rare at the individual level, but common in aggregate.
Maybe once a week or so?

You probably don't need to be worried about manually hand holding the
file system or baby sitting it, as I sometimes call it, these days.
Especially with recent kernels like you're using. I think that's about
the best "maintenance" you can do is use current stable kernels. You
may run into new as yet undiscovered bugs, but they tend to also get
discovered and fixed quickly. Older kernels go EOL and don't get fixes
let alone enhancements.

If you want to avoid enospc problems entirely, like you don't even
want to try to expose them and report such problems, you might
consider https://github.com/kdave/btrfsmaintenance which is maintained
by the same maintainer as btrfs-progs. I'm not sure if it's packaged
in Arch, if not you could ask. Otherwise it's pretty self explanatory,
you just enable the systemd timers for the maintenance tasks you want
to use. One of those is the balance.timer which is a very light weight
filtered balance for data block groups. You really don't want to
balance metadata regularly, there is a truly exotic edge case (that we
sometimes see) where there's lots of space in metadata block groups
and no more space for data. The reverse scenario is more common and
the balance.server/timer will avoid it. I do not run any of these
timers, not because I don't find them useful but (a) I don't run into
problems (b) if I did, I want to be able to report the problem in the
file system's natural state so that hopefully we can get such things
fixed.

Scrub is a good one to run periodically. You can run it weekly,
monthly, or quarterly - it's somewhat subjective how often to run it.
It's not enabled by default because it does take a while, and in some
configurations it competes with other IO. So there's some nuance about
depending on ionice which depends on the IO scheduler being used;
versus rate limiting it in sysfs (a new feature in 5.13); versus using
cgroups. So until some of this gets flushed out a bit more
generically, I don't think we'll see distributions enable scrub by
default. But you can set the timer and you'll either notice it or you
won't, and can ask on #btrfs how to fine tune it for performance if it
bothers you normal workloads.


>
> For example, in recent days I have been reading about switching to the
> "space_cache=v2" mount option and running "btrfs check
> --clear-space-cache v1".
>
> Should I do that for all my BTRFS devices? Do I change the mount
> options before running the check command? Other than it being slow,
> are there any other caveats?

There isn't a per se problem with v1 other than performance with heavy
write workloads. It is more fragile than v2 but also such problems are
easily and automatically detected by the kernel and result in the v1
space cache in question being rebuilt.

I'd say by mere fact you're asking about v2, yes you can go ahead and
switch to v2. But it's not in the category of "oh you really should be
using v2 now! why are you on v1 still?" It's not an urgent matter to
switch to v2.


>
> What other steps should I take to keep my BTRFS data robust and error-free?
>
> Here's what I do now about once a month. I step through a balance
> incrementally and generally my BTRFS devices reach the maximum dusage
> parameter I set in less than 30 seconds. With this approach, my
> balance operations never take very long. (The scrub operation can take
> a while on large and slow HDD's.)
>
> Does this approach look appropriate?

Yeah if it works for you it's OK. It's fine to do it manually or use
btrfsmaintenance with some personal preference adjustments and just
enable the timers. You can also modify the timers for more or less
frequency. The defaults are OK, at least well tested and if issues are
discovered then by using the defaults you get the changed defaults
automatically in future updates.

I get a bit complacent about running 'btrfs check' I don't think it's
strictly necessary because it doesn't take action by default, it just
checks and reports on the file system for consistency. But it will
tell you about file system problems that scrub can't. Scrub is
primarily verifying the integrity of data and metadata blocks by
comparing them to their recorded checksum, it doesn't check if the
metadata is correct. We normally can assume the metadata is correct if
the checksum matches. But it's not always the case, hence btrfs check.


-- 
Chris Murphy
