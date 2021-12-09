Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16846F3C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhLITT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 14:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhLITT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 14:19:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D0C061746
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 11:16:23 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g28so5767379qkk.9
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Dec 2021 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fLGp6ox2PvPjH1m0BC7At85njItgHrM/Ph0UnWbQo+Y=;
        b=YH6gVYdbe3nE2kGAGwgsT4rmzXTilVq7ECkN/BmMjEmogeOalV3V2gDmD8nRW6InmR
         6NLqc0inetJ+l3i2qdg6FPYWszQLwLb7eLIY5yeTFiUIoKZTdZ52MpAHFy1mCMgE2UJY
         N9Pn+MJV4PcEUuzWNLAxW5hPYVFsySIwCoIpNpfUA/tcjqhuZaZiE1SlnGqVkLX223tk
         14AzRP2bBFiznh/lzgwHoc1c5b3UFQKz1Ghd/7GZZ/PBWDHwJS5yZ0g+j7AVYioXCyCc
         OPhCmNQQ/U0D8iSI8VF1aOrdhpiSghuOf8zSM1E6NqMWvV2rBZYYZLEK5Ipw59+n7lhd
         2AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLGp6ox2PvPjH1m0BC7At85njItgHrM/Ph0UnWbQo+Y=;
        b=IdGh//V/OjYI0TDjlVk2JrIfrda8zXmb4/OPzDm1/RGjZmJ6fWN46in0AqY0w6BSCI
         jwUvXf7pT6TU2cW8Y3rm3icAcbMvL2VHSjtLhUKtrHq2XcBHp+/8r91WYwNl0wAwUae8
         L0yrVw5kBJWqEBtj9VYSoQAxDijm/6gOQ+DMc/diygPbk/YwK4XzoDCF26160kC++kmt
         /HgkP7dEeGthZIGmVPJzpw5YTM0oYeqV1/Xwbo03zJdQ4vIlrE6y/baCYR5j8vB0JgAn
         4M2UxQRNBZ6Q2bwLsor4frZ1h9/YIoVh1RGyqE04MJlR8sl+OpjwOFaXOfIyw+0kiCrr
         frdA==
X-Gm-Message-State: AOAM533dULFXMmlh5TTZQM9GaUiT9/I5No8Epa/S7I5naRLvahDeyiYK
        BHw+gCt6uqdGB5/7cCCMFq2y2Q==
X-Google-Smtp-Source: ABdhPJyL+b+axTEPhkSoKR7vwhFCvH+PQDM3xINNcVFRAy2JPRcVMViS3xy/RVTOy8s33NjgOtJRIA==
X-Received: by 2002:a05:620a:284d:: with SMTP id h13mr15481593qkp.330.1639077382823;
        Thu, 09 Dec 2021 11:16:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v21sm512763qta.0.2021.12.09.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:16:22 -0800 (PST)
Date:   Thu, 9 Dec 2021 14:16:20 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, guro@fb.com, clm@fb.com
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YbJWBGaGAW/MenOn@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
 <87ee6yc00j.mognet@arm.com>
 <YaUYsUHSKI5P2ulk@localhost.localdomain>
 <87bl22byq2.mognet@arm.com>
 <YaUuyN3h07xlEx8j@localhost.localdomain>
 <878rx6bia5.mognet@arm.com>
 <87wnklaoa8.mognet@arm.com>
 <YappSLDS2EvRJmr9@localhost.localdomain>
 <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8zx8zia.mognet@arm.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 05:22:05PM +0000, Valentin Schneider wrote:
> On 06/12/21 09:48, Valentin Schneider wrote:
> > On 03/12/21 14:00, Josef Bacik wrote:
> >> On Fri, Dec 03, 2021 at 12:03:27PM +0000, Valentin Schneider wrote:
> >>> Could you give the 4 top patches, i.e. those above
> >>> 8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
> >>> a try?
> >>>
> >>> https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression
> >>>
> >>> I gave that a quick test on the platform that caused me to write the patch
> >>> you bisected and looks like it didn't break the original fix. If the above
> >>> counter-measures aren't sufficient, I'll have to go poke at your
> >>> reproducers...
> >>>
> >>
> >> It's better but still around 6% regression.  If I compare these patches to the
> >> average of the last few days worth of runs you're 5% better than before, so
> >> progress but not completely erased.
> >>
> >
> > Hmph, time for me to reproduce this locally then. Thanks!
> 
> I carved out a partition out of an Ampere eMAG's HDD to play with BTRFS
> via fsperf; this is what I get for the bisected commit (baseline is
> bisected patchset's immediate parent, aka v5.15-rc4) via a handful of
> ./fsperf -p before-regression -c btrfs -n 100 -t emptyfiles500k
> 
>   write_clat_ns_p99     195395.92     198790.46      4797.01    1.74%
>   write_iops             17305.79      17471.57       250.66    0.96%
> 
>   write_clat_ns_p99     195395.92     197694.06      4797.01    1.18%
>   write_iops             17305.79      17533.62       250.66    1.32%
> 
>   write_clat_ns_p99     195395.92     197903.67      4797.01    1.28%
>   write_iops             17305.79      17519.71       250.66    1.24%
> 
> If I compare against tip/sched/core however:
> 
>   write_clat_ns_p99     195395.92     202936.32      4797.01    3.86%
>   write_iops             17305.79      17065.46       250.66   -1.39%
> 
>   write_clat_ns_p99     195395.92     204349.44      4797.01    4.58%
>   write_iops             17305.79      17097.79       250.66   -1.20%
> 
>   write_clat_ns_p99     195395.92     204169.05      4797.01    4.49%
>   write_iops             17305.79      17112.29       250.66   -1.12%
> 
> tip/sched/core + my patches:
> 
>   write_clat_ns_p99     195395.92     205721.60      4797.01    5.28%
>   write_iops             17305.79      16947.59       250.66   -2.07%
> 
>   write_clat_ns_p99     195395.92     203358.04      4797.01    4.07%
>   write_iops             17305.79      16953.24       250.66   -2.04%
> 
>   write_clat_ns_p99     195395.92     201830.40      4797.01    3.29%
>   write_iops             17305.79      17041.18       250.66   -1.53%
> 
> So tip/sched/core seems to have a much worse regression, and my patches
> are making things worse on that system...
> 
> I've started a bisection to see where the above leads me, unfortunately
> this machine needs more babysitting than I thought so it's gonna take a
> while.
> 
> @Josef any chance you could see if the above also applies to you? tip lives
> at https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git, though from
> where my bisection is taking me it looks like you should see that against
> Linus' tree as well.
> 

This has made us all curious, so we're all fucking around with schbench to see
if we can make it show up without needing to use fsperf.  Maybe that'll help
with the bisect, because I had to bisect twice to land on your patches, and I
only emailed when I could see the change right before and right after your
patch.  It would not surprise me at all if there's something else here that's
causing us pain.
> Thanks,
> Valentin
