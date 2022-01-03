Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDB4834A0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiACQQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiACQQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 11:16:04 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C6C061784
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 08:16:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kc16so31452670qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lnBz7y+HqHexkHu8TWqsOp15ajk1MYSnd1h+t0Gl00=;
        b=6b7YK+dJ/+B8PWU9PQPW8Y4+jOOh/rMol1cB8fijX4rBnqt56iGkqbyfrkvMLvcsJL
         RqQMdvz/bS3mTt2fgyudtMvjz7uSlHAUT3Q93laJ74dV7lKKA9rnHygm7AKpnKfw+iSf
         OTEXLXz2GjMx1NE09iIfLJxiltppHtFT+VS1/1rDtk4bba4UPAOEniy7ndfi5RdCQU0r
         5z45MvNXASQhdIH/w2isTjeoulu5rVZzQ7uhwbhXcwIRMvBQ7z8VZ6zRHcSMQbSMPz1Z
         OUdrif+3yLPbpJZdfTVDcLGR4iW+suxjD/VhDWu26wQyVJMjYjwf+JhxnOWz61EDoaPg
         SzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lnBz7y+HqHexkHu8TWqsOp15ajk1MYSnd1h+t0Gl00=;
        b=Q9bgL19sNpiGE315MG7vOMek2YFzMRp4R5UXj5ucicvi8E1bqlOzQss5td+CQ1eGFy
         NigudjsJqQqFARwtPq7qPUpNZwjRIXnQ6aSeKj9bvp6ldTmiBAeO6n7oh5zbyfgxSf95
         FhpA4YU4RKFX/6nw+sg49kp/znprx9uCQ/uYUFwSQUV1t4OVbjSYOO1Cb6vnGYket6vG
         at6GQJ+R+cCGcTpR4SHOavVRQZ7fWsJEkjaUh0P6voBCU7ksOVecV0S3RtrhAJxxXpAs
         wJ264NnLqN0ziC5EZrjCOWiHHAcI0cbinBfKsp0qlCC80d4K0nCgSjB2Dt77wRq2fZv1
         +aHw==
X-Gm-Message-State: AOAM533wxWox6fSuZNyGFVlAx/35FD7eu41FeKYFqcgfdmQCkZ4JfRc4
        yZh3WpelvhKkM/l5Yc8dBbvk9Q==
X-Google-Smtp-Source: ABdhPJz9yO9KqWHncxDlZTn49xw+RA4V5LL+vY6yw3k33ejUybJxtWlrnJBMNNKTucIYnaKibylTfA==
X-Received: by 2002:a05:6214:d0d:: with SMTP id 13mr11491975qvh.15.1641226563118;
        Mon, 03 Jan 2022 08:16:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t5sm27640418qtp.60.2022.01.03.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:16:02 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:16:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, guro@fb.com, clm@fb.com
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YdMhQRq1K8tW+S05@localhost.localdomain>
References: <87bl22byq2.mognet@arm.com>
 <YaUuyN3h07xlEx8j@localhost.localdomain>
 <878rx6bia5.mognet@arm.com>
 <87wnklaoa8.mognet@arm.com>
 <YappSLDS2EvRJmr9@localhost.localdomain>
 <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com>
 <YbJWBGaGAW/MenOn@localhost.localdomain>
 <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info>
 <87tuf07hdk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuf07hdk.mognet@arm.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 22, 2021 at 04:07:35PM +0000, Valentin Schneider wrote:
> 
> Hi,
> 
> On 22/12/21 13:42, Thorsten Leemhuis wrote:
> > What's the status here? Just wondering, because there hasn't been any
> > activity in this thread since 11 days and the festive season is upon us.
> >
> > Was the discussion moved elsewhere? Or is this still a mystery? And if
> > it is: how bad is it, does it need to be fixed before Linus releases 5.16?
> >
> 
> I got to the end of bisect #3 yesterday, the incriminated commit doesn't
> seem to make much sense but I've just re-tested it and there is a clear
> regression between that commit and its parent (unlike bisect #1 and #2):
> 
> 2127d22509aec3a83dffb2a3c736df7ba747a7ce mm, slub: fix two bugs in slab_debug_trace_open()
> write_clat_ns_p99     195395.92     199638.20      4797.01    2.17%
> write_iops             17305.79      17188.24       250.66   -0.68%
> 
> write_clat_ns_p99     195543.84     199996.70      5122.88    2.28%
> write_iops             17300.61      17241.86       251.56   -0.34%
> 
> write_clat_ns_p99     195543.84     200724.48      5122.88    2.65%
> write_iops             17300.61      17246.63       251.56   -0.31%
> 
> write_clat_ns_p99     195543.84     200445.41      5122.88    2.51%
> write_iops             17300.61      17215.47       251.56   -0.49%
> 
> 6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind() 
> write_clat_ns_p99     195395.92     197942.30      4797.01    1.30%
> write_iops             17305.79      17246.56       250.66   -0.34%
> 
> write_clat_ns_p99     195543.84     196183.92      5122.88    0.33%
> write_iops             17300.61      17310.33       251.56    0.06%
> 
> write_clat_ns_p99     195543.84     196990.71      5122.88    0.74%
> write_iops             17300.61      17346.32       251.56    0.26%
> 
> write_clat_ns_p99     195543.84     196362.24      5122.88    0.42%
> write_iops             17300.61      17315.71       251.56    0.09%
> 
> It's pure debug stuff and AFAICT is a correct fix...
> @Josef, could you test that on your side?

Sorry, holidays and all that.  I see 0 difference between the two commits, and
no regression from baseline.  It'll take me a few days to recover from the
holidays, but I'll put some more effort into actively debugging wtf is going on
here on my side since we're all having trouble pinning down what's going on.
Thanks,

Josef
