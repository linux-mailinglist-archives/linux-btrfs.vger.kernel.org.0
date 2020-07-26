Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DBF22DB03
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jul 2020 02:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGZAuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 20:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgGZAui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 20:50:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE2AC08C5C0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 17:50:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1044148wma.2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7q5DYL2ep0Im1MP7+bITABD9pEh6sI1UKGSGU16fvsA=;
        b=2TuGdTuOKWBERK2happNaHkk2NAldbZ/AdVpVul9/Oo8uc7xYgfFH4QRZxpSTZtyMD
         iRVLXe9ZV33+NHoTiXFnCy9N7D+zyasSeHYTsiJTS6zpMnWk3zXK5UJVFLVov3aAEpGg
         Uh/jmbOFCKtDpp9pcJgKAXTBqvUJmyH9rTYdSWyNPj0OYk0I0ZeFAhXfaajEcf48znEd
         G1J7BnPhkGWTAfNGZLA1aCOjUL/s4fY+/ZW8XP+rn1fdxycjhpEzH7A7D8DBWc80HAoU
         PgCL8tMR6sb66jePPDG8hqD9/EES2K1/9ymAQQtYdUZf1cD2pSRdx9I6YUkCO903YuAL
         5ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7q5DYL2ep0Im1MP7+bITABD9pEh6sI1UKGSGU16fvsA=;
        b=qaK8wsfHkxjgeUDMesSoLLfNXP2noVUoHns4qTOKKSvWCb7y/nXiaz29zU9rCOUqJ4
         KMZ3EIQ7H4+nbWhjYmo7E6NWXoHWqcCHGlH/SDYWJ3XzvTEfhMs3Rxrc2iZVPkdOmhtz
         GYndKcoa5dnwy/P0haG5ldLJdcBr7Iu8uAJYFmO8MFpw65wdm9T3aPgDbfrZyJMnPpEM
         +AXFWmS+GuavtQbGPmMsr5JfnPs+9cYyK4w0TTI4SSG1tdSrH/k57slIykyASQs30kaE
         q1ruxmj5AUCcVAYIfj5qbQ9MP2v02SputC5GMooDEdTndxzQ5pS62TfImC/QbLu46woB
         sO9Q==
X-Gm-Message-State: AOAM533fmMRpg7o5Ow65KcIDsjV25XX55UyuA37i/DcGcxSK3Vb+oYLW
        EUwEATE5WT4yI1z1u0lo4KASWb1dDWfw9VtCVRpPGLHHBSs=
X-Google-Smtp-Source: ABdhPJyMUAH/kFWjvwi/0CJecORqOD2ddRipkjiwbqbiokTDz84OaWcgiLrcsZG/PyxmyP5wOMCm7gkY6ibmzk6GOzI=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr14401750wmz.124.1595724637065;
 Sat, 25 Jul 2020 17:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
In-Reply-To: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 25 Jul 2020 18:50:20 -0600
Message-ID: <CAJCQCtQeJEE+Wa7VXnsoipnYK3eoMh+JAMA+n1YWwMa2ux7cMg@mail.gmail.com>
Subject: Re: Debugging abysmal write performance with 100% cpu kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 25, 2020 at 8:25 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>
> Hi,
>
> I have a filesystem here that I'm filling up with data from elsewhere.
> Most of it is done by rsync, and part by send/receive. So, receiving
> data over the network, and then writing the files to disk. There can be
> a dozen of these processes running in parallel.

Each receive goes into its own subvolume. What about the rsyncs? How
many concurrent and how many per subvolume?



> Now, when doing so, the kworker/u16:X+flush-btrfs-2 process (with
> varying X) often is using nearly 100% cpu, while enormously slowing down
> disk writes. This shows as disk IO wait for the rsync and btrfs receive
> processes.
>
> The underlying storage (iSCSI connected over 10Gb/s network) can easily
> eat a few hundred MiB/s. When looking at actual disk business on the
> storage device, percentages <5% utilization are reported for the actual
> disks.
>
> It's clearly kworker/u16:X+flush-btrfs-2 which is the bottleneck here.


>
> I just did a 'perf record -g -a sleep 60' while disk writes were down to
> under 1MiB (!) per second and then 'perf report'. Attached some 'screen
> shot' of it. Also attached an example of what nmon shows to give an idea
> about the situation.

Why is swapper involved in this?

+   80.53%     0.00%  swapper          [kernel.kallsyms]     [k]
secondary_startup_64
+   80.53%     0.00%  swapper          [kernel.kallsyms]     [k]
cpu_startup_entry
+   80.53%     0.00%  swapper          [kernel.kallsyms]     [k] do_idle
+   80.52%     0.00%  swapper          [kernel.kallsyms]     [k] default_idle
+   80.52%    80.51%  swapper          [kernel.kallsyms]     [k]
native_safe_halt
+   63.42%     0.00%  swapper          [kernel.kallsyms]     [k] start_secondary

What's PSI look like while this problem is happening?

# grep . /proc/pressure/*
# cat /proc/meminfo

>
> So, what I'm looking for is:
> * Does anyone else see this happen when doing a lot of concurrent writes?
> * What does this flush thing do?
> * Why is it using 100% cpu all the time?
> * How can I debug this more?
> * Ultimately, of course... how can we improve this?
>
> I can recompile the kernel image to e.g. put more trace points in, in
> different places.

What about using bcc-tools to check for high latencies? I'd maybe
start with fileslower, syncsnoop, btrfsslower, biolatency. This is a
bit of a firehose at first, but not near as much as perf. Strategy
wise you could start either at the top with fileslower or at the
bottom with biolatency, fileslower may not tell you anything you don't
already know which is that everything is f'n slow and waiting on
something. So OK is there something hammering on sync()? Try that
next. And so on. There's a bunch of these tools:

https://github.com/iovisor/bcc/blob/master/images/bcc_tracing_tools_2019.png


--
Chris Murphy
