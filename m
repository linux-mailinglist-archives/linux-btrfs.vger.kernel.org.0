Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD13A21A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 02:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFJA5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 20:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJA5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 20:57:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B6C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 17:55:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so185450pfl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jun 2021 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7pVCGEXkr1tatvMc/wXTps5uCsG/QvWeA1meTH3kKAM=;
        b=Fz5KUjUWxqzwKVKHSSs4h+o8oG6iQUt0hVBa0KNyTlwyXIdQD7HxHdaPRK9GLSROwG
         /YbjjOtqSGHgQDYwDGtypkFuhwK6leGFXUWeYO8D/IEVcaPe/yzV7wf///MMQHe6MGYP
         V6m0TyO7oLydb8USntdZ/k2Y60tVa2voPqppIhSmHqfajaMzkqf19ysuOLz5yclyaYws
         S+cKLKXUXCVe3iOIgXb2cwoyVxuJLnQFH2/qJlXoEDK2CryuCB4T9qfIkJkwzC1D+TJs
         3Jq23bi9k4OznQ8MajbrLdTZyHz2KyscPbwWI/GvP524/XunlBQaJ5QjLSavTF/nP8qV
         vI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pVCGEXkr1tatvMc/wXTps5uCsG/QvWeA1meTH3kKAM=;
        b=cIZKsjvDamRc9QbYg8U52swJYEQ+cpSY2VINj0iGys2v4DfvUBsz9u73H89vHkPGxE
         xlbmJhj43ofMhDMivA1GoTeduqsZHlqyZVY+0TiyWhc86QE9beGnmSZrfjfVFBIog/cD
         gHjN/e14ZeagAhrd7giEoAraloJBXHoFIv1APFJXSEFPpL1T9WBKtPGVHnhRpJzjfq1K
         E0tYggfgINnHVPHa6TKqwOHOSzizmhacoRAZNfOcUc/Rh0x3eM+iq3vgS8tbzkQuyJoI
         YKgf/Xyli0kTfqSVK8IMzltUePadgt0WyoAPSqTli0uYSELVNvJ52JOFfUvvEUwZq/gN
         tBrA==
X-Gm-Message-State: AOAM533V+cqsuyXipckJep1YmyUfTsKmirBdR+01yqkUSWk+acOCdHI+
        ri681OxSG6VYEOWpCWAeAMFL4A==
X-Google-Smtp-Source: ABdhPJwTG1HP956gFqP3xkxdsOfBFb4HG09WHYUSHmdZ9VFvrFJGyu35yipKo7B41wWBSV5UgITBcw==
X-Received: by 2002:a63:5442:: with SMTP id e2mr2352056pgm.365.1623286507012;
        Wed, 09 Jun 2021 17:55:07 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a169])
        by smtp.gmail.com with ESMTPSA id s123sm607006pfb.78.2021.06.09.17.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:55:06 -0700 (PDT)
Date:   Wed, 9 Jun 2021 17:55:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <YMFi6fSxMUDCU/C9@relinquished.localdomain>
References: <20210604132058.11334-1-dsterba@suse.com>
 <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
 <20210609185014.GE27283@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609185014.GE27283@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 08:50:14PM +0200, David Sterba wrote:
> On Wed, Jun 09, 2021 at 11:24:21AM -0700, Omar Sandoval wrote:
> > On Fri, Jun 04, 2021 at 03:20:58PM +0200, David Sterba wrote:
> > > The device stats can be read by ioctl, wrapped by command 'btrfs device
> > > stats'. Provide another source where to read the information in
> > > /sys/fs/btrfs/FSID/devinfo/DEVID/stats . The format is a list of
> > > 'key value' pairs one per line, which is common in other stat files.
> > > The names are the same as used in other device stat outputs.
> > > 
> > > The stats are all in one file as it's the snapshot of all available
> > > stats. The 'one value per file' is not very suitable here. The stats
> > > should be valid right after the stats item is read from disk, shortly
> > > after initializing the device, but in any case also print the validity
> > > status.
> > > 
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > >  fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > > index 4b508938e728..3d4c806c4f73 100644
> > > --- a/fs/btrfs/sysfs.c
> > > +++ b/fs/btrfs/sysfs.c
> > > @@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
> > >  }
> > >  BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
> > >  
> > > +static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
> > > +		struct kobj_attribute *a, char *buf)
> > > +{
> > > +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> > > +						   devid_kobj);
> > > +
> > > +	/*
> > > +	 * Print all at once so we get a snapshot of all values from the same
> > > +	 * time. Keep them in sync and in order of definition of
> > > +	 * btrfs_dev_stat_values.
> > > +	 */
> > > +	return scnprintf(buf, PAGE_SIZE,
> > > +		"stats_valid %d\n",
> > > +		"write_errs %d\n"
> > > +		"read_errs %d\n"
> > > +		"flush_errs %d\n"
> > > +		"corruption_errs %d\n"
> > > +		"generation_errs %d\n",
> > > +		!!(device->dev_stats_valid),
> > 
> > The ioctl returns ENODEV is !dev_stats_valid, maybe this file should do
> > the same? It seems a little awkward to have a flag that means that the
> > rest of the file is meaningless.
> 
> You mean returning -ENODEV when reading the stats file? Or return 0 but
> the contents is something like 'stats invalid' or similar.

I'd vote for returning -ENODEV when reading the stats file, but I think
either one is fine.
