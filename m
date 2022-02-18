Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D824BBC41
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiBRPfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:35:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiBRPfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:35:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4AF1EAF3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:34:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a28so15393152qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XB9Ws3daxQbWMBueDBVoJ12vlfuC8IiSDXQOIWtwbYM=;
        b=ib2R0eit6zqTdwhJ17aK637SZ1+jEjqrpddGCPLZo40hCHBNkr/3aZxQQoQ2dDPHXW
         W0dYn9SX6MJcrhfWkq64srTQ0h7l7XBBGfvfKPnp6BfWV6GsvpNDiWbBa/FOd8y/InIx
         c3DckpnFB4VbJI7KWs0mgJ/xUereQcCSEWZLJBkB4YUqnyMPKBO6g/mKPASn31MsMvpo
         RjiogjqpUSl1YIhn6l4uhH0eM2dbm32ghQ+L3cz5AKmnUERv4aJ8Ifvuy6/Ah2JCWd1J
         j7Q+e3/mbmmLzupr9Obi0bKE7SNej/Cu7FhD2QAJT8qUrQL4kc6IxE3busi2Xtg1Vs5E
         pCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XB9Ws3daxQbWMBueDBVoJ12vlfuC8IiSDXQOIWtwbYM=;
        b=GzReZ6wXU/dYx1I5UwBBa9C5Z/ADrBjZsahsVRH3+lpQ8Pt1tkDORNUTspbRoSYR1v
         dx9Q0m0leyLP5Gea1hmOQXqUae8rRuY7afCHzi4mUOWRfID+Vls4bFws6Sis2M1M4FQW
         sIIhwrcrm8uG3YfE3e6FHQV6oyeBSLmz3LMJQqzEh9jT3JgZFTU6TuSJEbtbfbmqJOO5
         00wlYnwp4TVvIx8QygT3HlVaVGN1KgA6RgUA+YsmcDYUQpIpxWb/lgoG0fd66JOOcvtH
         Y6b2aDPyR3fnt8AjhqZTDrqFqK++wczQ/1n/QjSV+WDJpCemgm/PuTf5tnv9BdxU9NcY
         AtFg==
X-Gm-Message-State: AOAM531rjJJDnt0oHlKJM59cxqbTJL9ONNuFzL2p+YZyThHpIQp7fl8g
        nCJndeVKmlj2KM8Xq74kzdq+HA==
X-Google-Smtp-Source: ABdhPJwfdfy1sZ0uTHZoDHkGgcKoqm6w6DI7eaqzXSd/DD+ZZ4JXHTjAt+jHZKL50hm8Ps+FnSq6Ug==
X-Received: by 2002:a05:622a:54d:b0:2d9:6d84:c7d1 with SMTP id m13-20020a05622a054d00b002d96d84c7d1mr7044174qtx.307.1645198488378;
        Fri, 18 Feb 2022 07:34:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bi11sm21322967qkb.18.2022.02.18.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:34:47 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:34:46 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Roman Gushchin <guro@fb.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <Yg+8lsJw00qEWEza@localhost.localdomain>
References: <YappSLDS2EvRJmr9@localhost.localdomain>
 <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com>
 <YbJWBGaGAW/MenOn@localhost.localdomain>
 <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info>
 <87tuf07hdk.mognet@arm.com>
 <YdMhQRq1K8tW+S05@localhost.localdomain>
 <87k0f37fl6.mognet@arm.com>
 <YeBZ7qNjPsonEYZz@carbon.dhcp.thefacebook.com>
 <f0ebbdfd-d14c-b497-07fb-54eb8d71ff38@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ebbdfd-d14c-b497-07fb-54eb8d71ff38@leemhuis.info>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 12:00:41PM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking. Top-posting
> for once, to make this easy accessible to everyone.
> 
> FWIW, this is a gentle reminder that I'm still tracking this regression.
> Afaics nothing happened in the last few weeks.
> 
> If the discussion continued somewhere else, please let me know; you can
> do this directly or simply tell my regression tracking bot yourself by
> sending a reply to this mail with a paragraph containing a regzbot
> command like "#regzbot monitor
> https://lore.kernel.org/r/some_msgi@example.com/"
> 
> If you think there are valid reasons to drop this regressions from the
> tracking, let me know; you can do this directly or simply tell my
> regression tracking bot yourself by sending a reply to this mail with a
> paragraph containing a regzbot command like "#regzbot invalid: Some
> explanation" (without the quotes).
> 
> Anyway: I'm putting it on back burner now to reduce the noise, as this
> afaics is less important than other regressions:
> 
> #regzbot backburner: Culprit is hard to track down
> #regzbot poke
> 
> You likely get two more mails like this after the next two merge
> windows, then I'll drop it if I don't here anything back.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> 

Roman and I sat down to mess with this some more and had some weird
observations.

On our Facebook internal boxes we couldn't reproduce.  If we disable all the
normal FB specific stuff so the box is "quiet" 5.16 performs better.  However
these are all single socket machines with stupid high numbers of cores, my local
machine is 2 socket 6 cores.

On my box it was actually pretty noisy testing in isolation as well.  In the end
I rigged up fsperf to run 1000 runs and graph each kernel on top of eachother.
What came out was really strange.

1. The "good" kernel had a period for the first ~100 runs that were very low,
the p50 was ~9000ns, but after those first 100 runs it jumped up and was right
ontop of 5.16.  This explains why it shows up on my overnight tests, the box
literally reboots and runs tests.  So there's a "warmup" period for the
scheduler, once it's been hammered on enough it matches 5.16 exactly, otherwise
its faster at the beginning.

2. The regression essentially disappears looking at the graphs over 1000 runs.
The results are so jittery this was the only way we could honestly look at the
results and see anything.  The only place the "regression" shows up is in the
write completion latency p99.  There 5.15 ranges between 75000-85000 ns, whereas
5.16 ranges between 80000 and 100000 ns.  However again this is only on my
machine, and the p50 latencies and the actual bw_bytes is the same.

Given this test is relatively bursty anyways and the fact that we can't
reproduce it internally, and the fact that 5.16 actually consistently performs
better internally has convinced us to drop this, it's simply too noisy to get a
handle on to actually call it a problem.

#regzbot invalid: test too noisy and the results aren't clear cut.

Thanks,

Josef
