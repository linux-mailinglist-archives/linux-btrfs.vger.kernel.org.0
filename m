Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69F146EA09
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 15:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhLIOgo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 09:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhLIOgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 09:36:44 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469DC061746
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 06:33:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t34so5446578qtc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Dec 2021 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCqJDzmzeYQdP6hUuU6fRSRs17pa+6HuGTm1uCY1YCQ=;
        b=P0K7VuupyGaHTLh3faQWHWGBKIIbSqBYiUhUawerMVEQO2GFrnExpRzW/GR2lHaDfp
         2WsFKK2fQYltGh7t+7nCpfC7o34i1Ks2jZ3VKWs5aO4vLMTTVaVhuwB6KKN82kXO79v9
         ztbDiDVR8kH1dvCKWVHz3cMR6zxebxeYaswEkePqBvojnh8XS25kQneHA1WmzZGKmVWs
         rxEQMxHBe13BZeAM+aKQoVqC/r9dYgrzPOM9aOIUEmmSPeAqTmICn7EZKmjanrvZC2VZ
         tfI9XDUaPQLTeFXc+wF39IuPB21CB+ENqh7WrOJGodKZ6CWLZAlgz4V3143A4/ZVkUDD
         AiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCqJDzmzeYQdP6hUuU6fRSRs17pa+6HuGTm1uCY1YCQ=;
        b=Kisxl1QufTV5oCfV2Lb0SLDN32sWOOtc/0uKtMg+pN0S1a5xIRt+p+AspaORu+hnuG
         sJO5SYcXHNC6gCqiLaE/cX8LG4PBFJM74Gynx0C4s9mkQOoj6ecJkwJlwckSf/IgJwm7
         DVFcMpoUOY4+Bwy4oAmEIyifMLkGPwVtS/GS5bqF+kyhDR34aMgCs3etZER3Yxac6OPl
         gZ97PIYL1nlxWPwzkq+O22IXkFn8LWzbvY16nBdFiqnRHxN7FKnpnAcb66HAhkUc7i7P
         Hyrs1lg9t9tDJVHdxgENoQa2br7xHWrxMndpoxEfwFFebr0V+24YuTO6LCZ0NaXquidZ
         JPow==
X-Gm-Message-State: AOAM530xAvjwNZoYAoQTER45+3ur0W/2u+R7zx8v6DrwZJc41zQasbPq
        8Rkq2zuCbtAYIqa+6f6ff0C8lA==
X-Google-Smtp-Source: ABdhPJyZv5giDH8GFWdqKD0J8LFA0D/jXiUI/I4r6GfdJnhqdjrIc8t1TXotgF+qXMsbx9u9gTH/SQ==
X-Received: by 2002:a05:622a:1d4:: with SMTP id t20mr18058611qtw.84.1639060389446;
        Thu, 09 Dec 2021 06:33:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x24sm2298138qkm.135.2021.12.09.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 06:33:08 -0800 (PST)
Date:   Thu, 9 Dec 2021 09:33:06 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <YbITotUXs1vQkE8Z@localhost.localdomain>
References: <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
 <20211207145329.GW28560@twin.jikos.cz>
 <20211207154048.GX28560@twin.jikos.cz>
 <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
 <20211208140411.GK28560@twin.jikos.cz>
 <YbHZhGGpBvqoqfiT@debian9.Home>
 <7eb7b1f6-6f2b-ebcd-e5da-f5945843da3f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb7b1f6-6f2b-ebcd-e5da-f5945843da3f@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 09:25:58PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/12/9 18:25, Filipe Manana wrote:
> > On Wed, Dec 08, 2021 at 03:04:11PM +0100, David Sterba wrote:
> > > On Tue, Dec 07, 2021 at 03:53:22PM +0000, Filipe Manana wrote:
> > > > > > I'm doing some tests, in a VM on a dedicated HDD.
> > > > > 
> > > > > There's some measurable difference:
> > > > > 
> > > > > With readahead:
> > > > > 
> > > > > Duration:         0:00:20
> > > > > Total to scrub:   7.02GiB
> > > > > Rate:             236.92MiB/s
> > > > > 
> > > > > Duration:         0:00:48
> > > > > Total to scrub:   12.02GiB
> > > > > Rate:             198.02MiB/s
> > > > > 
> > > > > Without readahead:
> > > > > 
> > > > > Duration:         0:00:22
> > > > > Total to scrub:   7.02GiB
> > > > > Rate:             215.10MiB/s
> > > > > 
> > > > > Duration:         0:00:50
> > > > > Total to scrub:   12.02GiB
> > > > > Rate:             190.66MiB/s
> > > > > 
> > > > > The setup is: data/single, metadata/dup, no-holes, free-space-tree,
> > > > > there are 8 backing devices but all reside on one HDD.
> > > > > 
> > > > > Data generated by fio like
> > > > > 
> > > > > fio --rw=randrw --randrepeat=1 --size=3000m \
> > > > >           --bsrange=512b-64k --bs_unaligned \
> > > > >           --ioengine=libaio --fsync=1024 \
> > > > >           --name=job0 --name=job1 \
> > > > > 
> > > > > and scrub starts right away this. VM has 4G or memory and 4 CPUs.
> > > > 
> > > > How about using bare metal? And was it a debug kernel, or a default
> > > > kernel config from a distro?
> > > 
> > > It was the debug config I use for normal testing, I'll try to redo it on
> > > another physical box.
> > > 
> > > > Those details often make all the difference (either for the best or
> > > > for the worse).
> > > > 
> > > > I'm curious to see as well the results when:
> > > > 
> > > > 1) The reada.c code is changed to work with commit roots;
> > > > 
> > > > 2) The standard btree readahead (struct btrfs_path::reada) is used
> > > > instead of the reada.c code.
> > > > 
> > > > > 
> > > > > The difference is 2 seconds, roughly 4% but the sample is not large
> > > > > enough to be conclusive.
> > > > 
> > > > A bit too small.
> > > 
> > > What's worse, I did a few more rounds and the results were too unstable,
> > > from 44 seconds to 25 seconds (all on the removed readahead branch), but
> > > the machine was not quiescent.
> > 
> > I get such huge variations too when using a debug kernel and virtualized
> > disks for any tests, even for single threaded tests.
> > 
> > That's why I use a default, non-debug, kernel config from a popular distro
> > and without any virtualization (or at least have qemu use a raw device, not
> > a file backed disk on top of another filesystem) when measuring performance.
> > 
> I got my 2.5' HDD installed and tested.
> 
> [CONCLUSION]
> 
> There is a small but very consistent performance drop for HDD.
> 
> Without patchset:	average rate = 106.46 MiB/s
> With patchset:		average rate = 100.74 MiB/s
> 
> Diff = -5.67%
> 

5% isn't that big of a deal to get rid of an infrastructure we don't really use
and that is in the way.

Additionally I'm going to be reworking scrub quite a bit to work with the new
extent tree v2 stuff, the readahead stuff may not fit into the new scheme very
well.

Scrub isn't meant to be performant, it's meant to be correct.  In fact, many
admins would prefer to throttle it and keep it from overwhelming the main
workload, so a 5% drop isn't likely to upset anybody.

In my mind we're getting rid of a lot of code for very little cost, which I'm a
fan of.  I think this is a reasonable trade off, we have more important projects
to tackle.  In the future if we want to improve things with a readahead
framework we can tackle the problem as a whole and make it useful for all of
btrfs, not just scrub.  Thanks,

Josef
