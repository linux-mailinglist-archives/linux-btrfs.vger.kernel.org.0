Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA53A1CE0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFISmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 14:42:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B16C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 11:40:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o9so17475807pgd.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jun 2021 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qBrJGD35IyUYnM2I0p0yXK7PJNELziFu5LKvIlypAiQ=;
        b=zdmyRxvHxhfB6huyK69dwFWmnkKujZxsC4WHJL/phs8NavYBZmKC7bj2ZcOZ1ld6eU
         ltTURbOWCvwHS9UjDS0nLtErEr6OYF7Z8VgonvtHZGbmf3aqEu+Gb6I7TWUER7/skK1C
         meBN+M8NPO8NwCoudYw7x5ldG6cKS87eqVtfLkepbCiYTexnIO218EsA+uUoWYST8SWE
         4EP75KUn9XTA8g8lk6MAhotOQcBtr7u+WDL9WISch4gtE/aK5tFZsFWAlW9OdXp+nOzC
         VVNHvngL0nrJAlVSUO5ElrDQjC36HQtcqK1rFWxeYpNBjRr85zui1fnLZtr2MrLRBTAq
         NErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBrJGD35IyUYnM2I0p0yXK7PJNELziFu5LKvIlypAiQ=;
        b=Ieavw5jVsuSFDjN5llYuvyJtlMAylS9zxYti5lFozR8kRI4FjNFXJ9apEsaqyuJAcZ
         vFJqIzn2UIBVzHmKZfrqXtrf5jElQGx4fbPz0z42A/4nhKH7hXB7LwMSyzn2yfGPM4/Y
         z2fwnLf8J/cR+yAr9qhWI4OlfDkf20zkPQWc1PzuKC+G7zE0hrmiTje2yUL3FND4PLg1
         l9iXu7iClRS1vz1+SEApg/EfcF0gCh8UIzmIRgir5By3Wo8d5/sF3gh+0XmiTjeWpi39
         zOzAgg3KiqoFoSzPWeCY4tpd0ANMc8Gp6J1i2da31t20EsU2X+Ry8O2hKyqyWkcIbI7z
         p/Lw==
X-Gm-Message-State: AOAM532VF79qWH5SNApHXyT7jBAstpsKrT2+NC1HwZGimqOlC5GHECVB
        nJ99qKiaSy6G6SKHiffqnQ+2MhCiygBPmw==
X-Google-Smtp-Source: ABdhPJzxNUvRKZqLWMGFbkx/47jAwMq2l0g50ZjncE/qdITiXTuwP3FgqEsvhI9CEiM4B6y9ZbGYsA==
X-Received: by 2002:a63:e0e:: with SMTP id d14mr1026005pgl.426.1623264017701;
        Wed, 09 Jun 2021 11:40:17 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a169])
        by smtp.gmail.com with ESMTPSA id c4sm278330pfo.189.2021.06.09.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 11:40:17 -0700 (PDT)
Date:   Wed, 9 Jun 2021 11:40:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <YMELD/Jkx7WT1oqg@relinquished.localdomain>
References: <20210604132058.11334-1-dsterba@suse.com>
 <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 11:24:21AM -0700, Omar Sandoval wrote:
> On Fri, Jun 04, 2021 at 03:20:58PM +0200, David Sterba wrote:
> > The device stats can be read by ioctl, wrapped by command 'btrfs device
> > stats'. Provide another source where to read the information in
> > /sys/fs/btrfs/FSID/devinfo/DEVID/stats . The format is a list of
> > 'key value' pairs one per line, which is common in other stat files.
> > The names are the same as used in other device stat outputs.
> > 
> > The stats are all in one file as it's the snapshot of all available
> > stats. The 'one value per file' is not very suitable here. The stats
> > should be valid right after the stats item is read from disk, shortly
> > after initializing the device, but in any case also print the validity
> > status.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 4b508938e728..3d4c806c4f73 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
> >  }
> >  BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
> >  
> > +static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
> > +		struct kobj_attribute *a, char *buf)
> > +{
> > +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> > +						   devid_kobj);
> > +
> > +	/*
> > +	 * Print all at once so we get a snapshot of all values from the same
> > +	 * time. Keep them in sync and in order of definition of
> > +	 * btrfs_dev_stat_values.
> > +	 */
> > +	return scnprintf(buf, PAGE_SIZE,
> > +		"stats_valid %d\n",
> > +		"write_errs %d\n"
> > +		"read_errs %d\n"
> > +		"flush_errs %d\n"
> > +		"corruption_errs %d\n"
> > +		"generation_errs %d\n",
> > +		!!(device->dev_stats_valid),
> 
> The ioctl returns ENODEV is !dev_stats_valid, maybe this file should do
> the same? It seems a little awkward to have a flag that means that the
> rest of the file is meaningless.

Typo, I meant to say "the ioctl returns ENODEV _if_ !dev_stats_valid".
