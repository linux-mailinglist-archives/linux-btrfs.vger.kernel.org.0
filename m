Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE49462673
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhK2Wwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 17:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhK2Wue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308FEC03AA15
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 10:15:16 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t34so17490913qtc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5b5qh/kvUmuAxuX6IrP7q82N4vspMTIsdmghaUk1cYw=;
        b=Bdhtd9WSzPvU7/V8HNa2hTMVtdIsLC0wN52/ZfiCz7euJW4oaVxMP2/kNhJp80Am7h
         DYp4u0lASiuZiG1Z5TEUOUQRFVxAy2/JnInSxRJYDTNIVMxsaTqu8JZihaXMErA1TPfl
         EZohXunqEZdSqaHV7IRRV3rUTed8qdM/yfUrMlISenbnKNMs1e96aHwtMGZe1qovHERa
         1l6eTXckhtZuH7qVWAFPrq575D/BPWcZMWhqQBnPxSL7MtTRFo9E0qb7/Axi+VPN0V8o
         G7ek3jPWPfNj3GXvkO7wDWWRNOE8tJEIc7HPQ0FaP3A5xXJgqK2kHm2D58Xky2ISQ0oT
         m2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5b5qh/kvUmuAxuX6IrP7q82N4vspMTIsdmghaUk1cYw=;
        b=NFOYNber5FLnE0yG1R9PXA+5h+xGLBOEgCz/7Hm90uQuS174Gk0VzUe12M5Tq1PNRV
         joloJKYWssBdrqCC1AK2ClLyKYYKHi02051hECizv90YIyEcc2FKTF8+ogx/7YPSdnqI
         ONJd/bxWWWsb1aawiElf+2cQ0QRQOdYHJj+K7hYNgqAVS+7GL5BvJUkIXH5Vr9MmLzPq
         +0/CSo9kqM6BiTY5ML/0V9MiCzipYjClnoDc/jHBkKKH3S+bKk7w/PxnoWxvw38pToXP
         CbSeV2A4/TwLBDtcjcbqpE+EsIDW92IKoT/2QeOClHjrxHuZUSYBMVp+Iy7BDzCfnwuf
         b5tQ==
X-Gm-Message-State: AOAM530vhUX0vI7MkfvcoQmXe4CcRS+N5TwghsPsKOrAcFS9x87OBbza
        Q58yDux/ZdkGPv2rDcqWxx1BKw==
X-Google-Smtp-Source: ABdhPJwCS7omvq0J3BR4cWJfCQsBbn2Q8/rhwVshyCiOdQYdsmN5CvbQQClg1wniqFXuFXfTTajxxw==
X-Received: by 2002:a05:622a:288:: with SMTP id z8mr36944934qtw.526.1638209715216;
        Mon, 29 Nov 2021 10:15:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl16sm8435585qkb.44.2021.11.29.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:15:14 -0800 (PST)
Date:   Mon, 29 Nov 2021 13:15:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YaUYsUHSKI5P2ulk@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
 <87ee6yc00j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee6yc00j.mognet@arm.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 06:03:24PM +0000, Valentin Schneider wrote:
> 
> Hi Josef,
> 
> On 29/11/21 12:03, Josef Bacik wrote:
> > Hello,
> >
> > Our nightly performance testing found a performance regression when we rebased
> > our devel tree onto v5.16-rc.  This took me a few days to bisect down, but this
> > patch
> >
> > 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> >
> > is the one that introduces the regression.  My performance testing box is a 2
> > socket, with a model name "Intel(R) Xeon(R) Bronze 3204 CPU @ 1.90GHz", for a
> > total of 12 cpu's reported in cpuinfo.  It has 128gib of RAM, and these perf
> > tests are being run against a SSD and spinning rust device, but the regression
> > is consistent across both configurations.  You can see the historical graph of
> > the completion latencies for this specific run
> >
> > http://toxicpanda.com/performance/emptyfiles500k_write_clat_ns_p99.png
> >
> > Or for something a little more braindead (untar firefox) you can see a increase
> > in the runtime
> >
> > http://toxicpanda.com/performance/untarfirefox_elapsed.png
> >
> > These two tests are single threaded, the regression doesn't appear to affect
> > multi-threaded tests.  For a simple reproducer you can simply download a tarball
> > of the firefox sources and untar it onto a clean btrfs file system.  The time
> > before and after this commit goes up ~1-2 seconds on my machine.  For a less
> > simple test you can create a clean btrfs file system and run
> >
> > fio --name emptyfiles500k --create_on_open=1 --nrfiles=31250 --readwrite=write \
> >       --readwrite=write --ioengine=filecreate --fallocate=none --filesize=4k \
> >       --openfiles=1 --alloc-size 98304 --allrandrepeat=1 --randseed=12345 \
> >       --directory <mount point>
> >
> > And you are looking for the "Write clat ns p99" metric.  You'll see a 5-10%
> > increase in the latency time.  If you want to run our tests directly it's
> > relatively easy to setup, you can clone the fsperf repo
> >
> > https://github.com/josefbacik/fsperf
> >
> > Then in the fsperf directory edit the local.cfg and add
> >
> > [main]
> > directory=/mnt/test
> >
> > [btrfs]
> > device=/dev/sdc
> > iosched=none
> > mkfs=mkfs.btrfs -f
> > mount=mount -o noatime
> >
> > And then run the following on the baseline kernel
> >
> > ./fsperf -p regression -c btrfs -n 10 emptyfiles500k
> >
> > This will run the test 10 times and save the results to the database.  Then you
> > can boot into your changed kernel and runn
> >
> > ./fsperf -p regrssion -c btrfs -n 10 -t emptyfiles500k
> >
> > This will run the test 10 times and take the average and compare it to the
> > baseline and print out the values, you'll see the increase latency values there.
> >
> > I can reproduce this at will, if you want to just throw patches at me I'm happy
> > to run it and let you know what happens.  I'm attaching my .config as well in
> > case that is needed, but the HZ and PREEMPT settings are
> >
> > CONFIG_NO_HZ_COMMON=y
> > CONFIG_NO_HZ_FULL=y
> > CONFIG_NO_HZ=y
> > CONFIG_HZ_1000=y
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> > CONFIG_PREEMPT_DYNAMIC=y
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_HAVE_PREEMPT_DYNAMIC=y
> > CONFIG_PREEMPT_NOTIFIERS=y
> > CONFIG_DEBUG_PREEMPT=y
> 
> Thanks for the report!
> 
> That patch you bisected does add more NOHZ kicks that aren't time-gated
> like nohz.next_blocked / nohz.next_balance, so I'm thinking that a
> pathological scenario would be a low-period bursty task which keeps
> flicking a CPU idle/!idle. SCHED_SOFTIRQ running the NOHZ work on the
> task's previous CPU would then repeatedly delay / force the task to be
> placed on another CPU.
> 
> Would you happen to have execution traces by any chance? If not I should be
> able to get one out of that fsperf thingie.
> 

I don't, if you want to tell me how I can do it right now.  I've disabled
everything on this box for now so it's literally just sitting there waiting to
have things done to it.  Thanks,

Josef
