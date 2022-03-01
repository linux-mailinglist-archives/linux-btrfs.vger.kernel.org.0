Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824EF4C97E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 22:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiCAVoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 16:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiCAVoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 16:44:22 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862E98586
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 13:43:40 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id v5so14064143qkj.4
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Mar 2022 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7qVCEUdePRJG/BOBaSd6bYOXIbJyAlcZe9f/xWYnAo=;
        b=iQw9gWkgtV1ekjxVeNH/pIbp8+ezjqTJSLu8nybfpBuAU1FK3w+HjPZIE8Geb+F79Q
         dOaaQ0eiJTae4log7pp+p5unsSiAz1Jc/s7ZkdaXPZUtHfg8/up36BdlbEGmuaTMILiW
         raeZrkaaiT+z+94D2yDB17myzGoLycHO0jIlEIB8JaIPAOUbdjFrH7dW1xRraJL5uU0t
         xejME89+zgCPzwywaXT4iWTrCB9FmrSULmbyTbyTa/tsEQ+3aPX+V42opbBdYBu8RIWA
         OvQtchg7jzyb1e0rnJNk5+L+rjxfkxgEYWQUBE+c58GlY0PBZltNDVEfosJg6N/oSwI7
         v6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7qVCEUdePRJG/BOBaSd6bYOXIbJyAlcZe9f/xWYnAo=;
        b=uHMN1URuBFWgCZfOdN7/F+9Yj1Wn+higyebyLUbNJ+Z5uaYY9z3QLhLVfj7yh655IB
         oZeUaVk8PU4dJ+6lJoVQM7a1O3Qg4VcGhvky7U29uD6an3I7qf9HcUnIHB8HQEbXcRPs
         37s1IaAszbcLFuYKhBdJ4qJfQmZlolyClxevH4vlnuPSoELcZkWPnwiazCQ9jFbJtSum
         qLhKJ5lBLU4Xn/hit8BWQMcpkWriVUsnLxeJnJoorSkySrFU2digsQ770ljx6zneVoLK
         v3wn4FqWyC+icrHK1qSWxrKXIoiQsmyIGmPXG8tsmPNjpU2wDLz0CFnO+Et9WuewUFrD
         Z7Cw==
X-Gm-Message-State: AOAM531mwePCbMEJ+6Qo2XAUTBoo6kYCSDQmIMWMo6KfX5WWiU4SkmGv
        UywEoN3jtYnw6AfdY2UkAa76jW4r9DmHbg1A
X-Google-Smtp-Source: ABdhPJw7DUGRZ9bPcbSXrRg2EQ6frhI10pqaPTju4nxqh3WZCrLsC6a7/ZSIOeOtRjqZjaXOgRfz1w==
X-Received: by 2002:a37:e214:0:b0:637:f295:cde8 with SMTP id g20-20020a37e214000000b00637f295cde8mr14240680qki.753.1646171019849;
        Tue, 01 Mar 2022 13:43:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002d6a901ad4csm10201389qtb.73.2022.03.01.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:43:39 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:43:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <Yh6Tit2dKcLt7xJP@localhost.localdomain>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
 <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 01, 2022 at 07:55:07PM +0100, Goffredo Baroncelli wrote:
> On 01/03/2022 16.07, Josef Bacik wrote:
> > On Mon, Feb 28, 2022 at 10:01:35PM +0100, Goffredo Baroncelli wrote:
> > > Hi Josef,
> > > 
> > > On 28/02/2022 18.04, Josef Bacik wrote:
> > > > On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
> > > > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > > > 
> > > > > Hi all,
> > > > > 
> > > [...
> > > 
> > > > > In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
> > > > > to help the detection of the allocation_hint feature.
> > > > > 
> > > > 
> > > > Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
> > > > down and done so we can get it merged.  The code overall looks good, I just have
> > > > two things I want changed
> > > > 
> > > > 1. The sysfs file should use a string, not a magic number.  Think how
> > > >      /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
> > > >      allocation_hint, you cat allocation_hint and it says "none" or
> > > >      "metadata_only".  If you want to be fancy you can do exactly like
> > > >      queue/scheduler and show the list of options with [] around the selected
> > > >      option.
> > > 
> > > Ok.
> > > > 
> > > > 2. I hate the major_minor thing, can you do similar to what we do for devices/
> > > >      and symlink the correct device sysfs directory under devid?
> > > > 
> > > Ok, do you have any suggestion for the name ? what about bdev ?
> > > 
> > 
> > You literally just add a link to the device kobj to the devid kobj.  If you look
> > at btrfs_sysfs_add_device(), you would do something like this (completely
> > untested and uncompiled)
> 
> I will give an eye to your code; thanks. However my question was more basic.
> 
> Now we have:
> 
> .../btrfs/<uuid>/devinfo/<dev-nr>/major_minor
> 
> with the link, as you suggested, I think that we will have:
> 
> .../btrfs/<uuid>/devinfo/<dev-nr>/bdev -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
>                                   ^^^^
> 
> (notice 'bdev', which is the name that I asked)
> 
> looking at your patch, it seems to me that the link will be named like the device name:
> 
> .../btrfs/<uuid>/devinfo/<dev-nr>/sdg3 -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
>                                   ^^^^
> 
> which is quite convoluted as approach, because the code has to find a name that matches a device (sdg3), instead to look for a fixed name (bdev).
> 
> Because I know that every people has a strong, valid (and above all different !) opinion about the name, I want to ask it before issue another patches set.
> For the record, I like 'bdev' only because I saw used (by bcache)
> 
> IMHO, the btrfs world had been simpler if devices/ sysfs directory was populated by the btrfs-dev-nr instead the device name
>

Ahh ok I see, you make a good point.  I agree it would have been better to have
the dev nrs in devices and then links in there, but here we are.

I think for now drop this patch from this series, since it's another bike
shedding opportunity and I'd rather get the core functionality in.  Do what I
asked in #1 and drop this patch from this series, follow up with a different
series if you feel strongly enough about it and that way we can have that
discussion in that thread and not hold up your feature.  Thanks,

Josef
