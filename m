Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B014625D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 23:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhK2WoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 17:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhK2WnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD56C05816A
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 11:49:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f20so17785930qtb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 11:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77pIMPY0DRqIRNulPGyN+kaDHJuIP/tsohLoFAabMaA=;
        b=Ty40tdgepASovZT6ntq5Yakq5xpCnQoI0Bg6ZF10cH7cKK2i4s+NeZzyylqKmqiIEJ
         Lj5RQ87gbJZLzeMyUhgJ9Iqlc85/aOoLgNmkt+7theJhVmC29r7/lbA9UCp3TtBfhMK9
         lDMcXjvDJM9Is7tpq4zdD4T68AHCVOTgwSQgpEuyE/56Gbl7AbZjS8EONZhK/QCrh+S8
         YqA8tAR+bQcxK5eLdZlUFwD0UXggpzG2VaHFJzmSnDdK/0rBhQvyDqfEbU7/5W6WjvKj
         4c50oZaPHTc6lh6huPAhoKWhWfAlgXsgmofI0HoiTgredobbidIrTGHxab/yZOO4NBw8
         WjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77pIMPY0DRqIRNulPGyN+kaDHJuIP/tsohLoFAabMaA=;
        b=ZMeLKRwLGoOLpKhu7djJprUQEVQHQ5T1Fducr39D5pjEEmhWs3XMUla6aL2a1dMCIF
         uMENYBxfyEwYLbS2Sc3gbj2Vu3jA1S6AR0SHCycvXA6Ol4L2yXjeb47ConBrLPlaiuEJ
         /gR4PXbuBh0ekrInRTAWaSBU7b+kSXKn0UYA0sZXG3k9kcBLJ5F6ecW6+2EALXrmHt+G
         mL7dIYqKwIwVNSjDDFklp1hu7gWHI4RjjxLbitPRLHFDj7y6q3X3MNIiAGyXZHxrqzRJ
         N4ue9EvW8QzQ5owSM+XU0TnXlWKIOjHRe5pZO6Wgo3Z0X7lWgTHj9t2BiNsX/2RjyrmM
         HyEw==
X-Gm-Message-State: AOAM533svj0FqsXmbjbUGoOElE7SabBA1VxkDmPDVvbE52XDXAP7GuFi
        4gZqY4rKjZGEAdroJPNRWSHykg==
X-Google-Smtp-Source: ABdhPJziQ539dzvCnkchJn9u/+4tbDzPDQH7IuKrDLjAQqJYz6yxO9OEWlzBrT4ymrzA649FVkCaEg==
X-Received: by 2002:a05:622a:1005:: with SMTP id d5mr37693725qte.533.1638215369925;
        Mon, 29 Nov 2021 11:49:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12sm8760663qkp.52.2021.11.29.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:49:29 -0800 (PST)
Date:   Mon, 29 Nov 2021 14:49:28 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YaUuyN3h07xlEx8j@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
 <87ee6yc00j.mognet@arm.com>
 <YaUYsUHSKI5P2ulk@localhost.localdomain>
 <87bl22byq2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl22byq2.mognet@arm.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 06:31:17PM +0000, Valentin Schneider wrote:
> On 29/11/21 13:15, Josef Bacik wrote:
> > On Mon, Nov 29, 2021 at 06:03:24PM +0000, Valentin Schneider wrote:
> >> Would you happen to have execution traces by any chance? If not I should be
> >> able to get one out of that fsperf thingie.
> >>
> >
> > I don't, if you want to tell me how I can do it right now.  I've disabled
> > everything on this box for now so it's literally just sitting there waiting to
> > have things done to it.  Thanks,
> >
> 
> I see you have Ftrace enabled in your config, so that ought to do it:
> 
>   trace-cmd record -e 'sched:*' -e 'cpu_idle' $your_test_cmd
> 

http://toxicpanda.com/performance/trace.dat

it's like 16mib.  Enjoy,

Josef
