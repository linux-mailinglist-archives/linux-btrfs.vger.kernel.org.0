Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316183A1D38
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhFISy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 14:54:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41416 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFISyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 14:54:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDCEA1FD60;
        Wed,  9 Jun 2021 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623264778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlcaPnRw6bv4CHU9gKFw2OudSUE4OxGVk2XBD0NaCPc=;
        b=N9pTyxACGjz6XIH3D+9pIwjWgrY4HxIxGSSQT44frQMUU+g903t39fCZaWv2Ur3DXUuEc3
        tZ1HdlOGT8FOj2nu0YijDRi/sA2Da2u4UoSdF8nE1JWPg1DXF/Lz7TC5ibHueZqkJiEW6t
        NHthOR+DCJtUbCAF2Qt/DDIvW+J8Fi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623264778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlcaPnRw6bv4CHU9gKFw2OudSUE4OxGVk2XBD0NaCPc=;
        b=vluGsHaD4DsB9D3cbGsghSmXt4etIfBDr3ET3ycvoQJrNafhD0xxjY9r0h3DLjjX3R60MM
        Q7zFPV4x8eT0t/BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E64F3A3B87;
        Wed,  9 Jun 2021 18:52:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C88F8DA908; Wed,  9 Jun 2021 20:50:14 +0200 (CEST)
Date:   Wed, 9 Jun 2021 20:50:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210609185014.GE27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

You mean returning -ENODEV when reading the stats file? Or return 0 but
the contents is something like 'stats invalid' or similar.
