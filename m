Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A14CB134
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 22:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbiCBVYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 16:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCBVYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 16:24:23 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4152B3E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 13:23:39 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z66so2397967qke.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 13:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/o+Aw9Tj0n7KPi2EL7MMouUf4tmMZyQOnSh5ykmwyBs=;
        b=bCapjjn9LGRStQNh2P7XpIy/W9wLqHpD6xvGmW6/Cizitycl2E4CIZ4RU8tmfAM8u/
         YisYn7KLObpV0HhDWDG+1Jg/9TmcUl1airiyMcLmzIdYORXVyIuXZzVTh+PztO2TFgbx
         2hVf/LiddFXUSAFG1KnVvRlYEGtQQLxKgqNJMKpSeVY7QSZRKyXFIoJgWgV9mDaWGic/
         D0/LUdYExoUtJqQ/O2XW2041guV42zN8gKOo1stO+MyDhe8o/K4T7CrNtfsyZD08QH0c
         avifO1L4yx3q2wcIZd/0WCZlGq0nClrtTlxTs0SOsMxciemkDmOaZXEZj48yL/PYyILk
         fwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/o+Aw9Tj0n7KPi2EL7MMouUf4tmMZyQOnSh5ykmwyBs=;
        b=mW+HAIOeQhF7setTzk651WxkiaaA5qO51KfwJeNdd4tf/OsmjY5mEJLSFkVNi0BhrD
         DNs9V4kNJ560F9Aq1hYMoNmVlhXz5DK7QW1Z6HvUZ0l0fsQFfdLxJiVnkFJSZ3gx0e7N
         XuiRZ1FqOFRs97tghoJlf5SqL6B0+TXhv5Z18JrEsvGSYzDSXTCgQVx/lz+TAC8m387i
         ByKI+jRYMmEuMWCr5pSU5ByXM/U/4dMNojjY7FR8c6RXswcvp/fFCYxdM/4kRB2RoS9J
         Dco6ym+79H1yF6hHmSn1XK/zmTJhh56yOpQwXVVn9auRb8my0HkKug8I+XkB5ZIcQBYA
         4ETw==
X-Gm-Message-State: AOAM531IJWfPEpNFStS4eodVpgqymIQfspoPJCZ7tjkRh2ZsZcdreEL0
        RfqFQf+Jz25hhV+TEbytgh3jyw==
X-Google-Smtp-Source: ABdhPJzB0k/96RnfA2L+SD4PzvcCZpgqbmCkAVXHW5RRczA0XSsLQptXF1td3AUP9wt/PoYFVbXXeQ==
X-Received: by 2002:a37:9e86:0:b0:507:42b:7540 with SMTP id h128-20020a379e86000000b00507042b7540mr17299839qke.159.1646256218544;
        Wed, 02 Mar 2022 13:23:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q28-20020a05620a039c00b006494cbf8f5asm105801qkm.22.2022.03.02.13.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:23:37 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:23:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <Yh/gWL983TFzcObT@localhost.localdomain>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
 <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
 <Yh6Tit2dKcLt7xJP@localhost.localdomain>
 <90407af0-57bb-9808-7663-6feb56fa7b20@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90407af0-57bb-9808-7663-6feb56fa7b20@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 08:30:22PM +0100, Goffredo Baroncelli wrote:
> On 01/03/2022 22.43, Josef Bacik wrote:
> > On Tue, Mar 01, 2022 at 07:55:07PM +0100, Goffredo Baroncelli wrote:
> > > On 01/03/2022 16.07, Josef Bacik wrote:
> > > > On Mon, Feb 28, 2022 at 10:01:35PM +0100, Goffredo Baroncelli wrote:
> > > > > Hi Josef,
> > > > > 
> > > > > On 28/02/2022 18.04, Josef Bacik wrote:
> > > > > > On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
> > > > > > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > > > > > 
> > > > > > > Hi all,
> > > > > > > 
> > > > > [...
> > > > > 
> > > > > > > In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
> > > > > > > to help the detection of the allocation_hint feature.
> > > > > > > 
> > > > > > 
> > > > > > Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
> > > > > > down and done so we can get it merged.  The code overall looks good, I just have
> > > > > > two things I want changed
> > > > > > 
> > > > > > 1. The sysfs file should use a string, not a magic number.  Think how
> > > > > >       /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
> > > > > >       allocation_hint, you cat allocation_hint and it says "none" or
> > > > > >       "metadata_only".  If you want to be fancy you can do exactly like
> > > > > >       queue/scheduler and show the list of options with [] around the selected
> > > > > >       option.
> > > > > 
> > > > > Ok.
> > > > > > 
> > > > > > 2. I hate the major_minor thing, can you do similar to what we do for devices/
> > > > > >       and symlink the correct device sysfs directory under devid?
> > > > > > 
> > > > > Ok, do you have any suggestion for the name ? what about bdev ?
> > > > > 
> > > > 
> > > > You literally just add a link to the device kobj to the devid kobj.  If you look
> > > > at btrfs_sysfs_add_device(), you would do something like this (completely
> > > > untested and uncompiled)
> > > 
> > > I will give an eye to your code; thanks. However my question was more basic.
> > > 
> > > Now we have:
> > > 
> > > .../btrfs/<uuid>/devinfo/<dev-nr>/major_minor
> > > 
> > > with the link, as you suggested, I think that we will have:
> > > 
> > > .../btrfs/<uuid>/devinfo/<dev-nr>/bdev -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
> > >                                    ^^^^
> > > 
> > > (notice 'bdev', which is the name that I asked)
> > > 
> > > looking at your patch, it seems to me that the link will be named like the device name:
> > > 
> > > .../btrfs/<uuid>/devinfo/<dev-nr>/sdg3 -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
> > >                                    ^^^^
> > > 
> > > which is quite convoluted as approach, because the code has to find a name that matches a device (sdg3), instead to look for a fixed name (bdev).
> > > 
> > > Because I know that every people has a strong, valid (and above all different !) opinion about the name, I want to ask it before issue another patches set.
> > > For the record, I like 'bdev' only because I saw used (by bcache)
> > > 
> > > IMHO, the btrfs world had been simpler if devices/ sysfs directory was populated by the btrfs-dev-nr instead the device name
> > > 
> > 
> > Ahh ok I see, you make a good point.  I agree it would have been better to have
> > the dev nrs in devices and then links in there, but here we are.
> > 
> > I think for now drop this patch from this series, since it's another bike
> > shedding opportunity and I'd rather get the core functionality in.  Do what I
> > asked in #1 and drop this patch from this series, follow up with a different
> > series if you feel strongly enough about it and that way we can have that
> > discussion in that thread and not hold up your feature.  Thanks,
> still be a problem:
> - how go from the "dev name" (e.g. /dev/sdg3) to the sysfs field
>   (e.g. /sys/btrfs/<uuid>/devinfo/<devid>/allocation_hint) ?
> 
> For simple filesystem (e.g. 1 disk), it is trivial (and not useful); for more complex
> one (2, 3 disks) it is easy to make mistake.
> 
> btrfs-progs relies on major_minor; it is possible to used the BTRFS_IOC_DEV_INFO
> but it requires CAP_ADMIN....
> 

Well this just made me go look at the code and realize you don't require
CAP_ADMIN for the sysfs knob, which we're going to need.  So using
BTRFS_IOC_DEV_INFO shouldn't be a problem.  Thanks,

Josef
