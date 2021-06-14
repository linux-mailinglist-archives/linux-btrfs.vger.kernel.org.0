Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F53A6D0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhFNRYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 13:24:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40576 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhFNRYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 13:24:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E4ED2199D;
        Mon, 14 Jun 2021 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623691352;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLebHohK195WEB9am3izNJTPiKyZEOGkMCjlFrvm5Ks=;
        b=a53t5m8kwarxdYLbuAq2hpAT1VKBDcI82Bs+J59hYio6Bl/XuZcCwmqiQWARkXPQradYwx
        rXUGKqksuOHSBlak7v2ss6mMQU9h5vVoCdhF/6nN8fRG/wH434ixb4MFEx2/2F9mbOeLSO
        EqF2HLoFM/eiVOqOWPyQlA1b8OZ5zlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623691352;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLebHohK195WEB9am3izNJTPiKyZEOGkMCjlFrvm5Ks=;
        b=lo/caiQDnbcUeM/CpTHsI/rg2wB4dFKQrtea03V20JHG63F+yiYZeIFGA+hyb8yQ3NCUc1
        Zq2vYnac4HgLC2DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23990A3B8C;
        Mon, 14 Jun 2021 17:22:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78492DAF4C; Mon, 14 Jun 2021 19:19:45 +0200 (CEST)
Date:   Mon, 14 Jun 2021 19:19:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, osandov@osandov.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210614171945.GL28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, osandov@osandov.com,
        linux-btrfs@vger.kernel.org
References: <20210611133622.12282-1-dsterba@suse.com>
 <db167846-026b-c7bc-9533-7dc3a8f47673@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db167846-026b-c7bc-9533-7dc3a8f47673@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 14, 2021 at 09:00:50PM +0800, Anand Jain wrote:
> 
> > The stats are all in one file as it's the snapshot of all available
> > stats. The 'one value per file' is not very suitable here. The stats
> > should be valid right after the stats item is read from disk, shortly
> > after initializing the device.
> > 
> > In case the stats are not yet valid, print just 'invalid' as the file
> > contents.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > 
> > v2:
> > - print 'invalid' separtely and not among the values
> > - rename file name to 'error_stats' to leave 'stats' available for any
> >    other kind of stats we'd like in the future
> > 
> >   fs/btrfs/sysfs.c | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 4b508938e728..ebde1d09e686 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1495,7 +1495,36 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
> >   }
> >   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
> >   
> > +static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
> > +		struct kobj_attribute *a, char *buf)
> > +{
> > +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> > +						   devid_kobj);
> > +
> > +	if (!device->dev_stats_valid)
> > +		return scnprintf(buf, PAGE_SIZE, "invalid\n");
> 
> and
> 
> Nit:
> Instead of invalid, IMO, not yet valid is closer to what this error 
> implies. And matches with the ioctl Warning message.
> 
> 7743         btrfs_warn(fs_info, "get dev_stats failed, not yet valid");

Yeah I was not sure about that, 'invalid' does not have the same
meaning.  I'd like something that's short and easily parseable so no
long sentences or multi-word value like 'not yet valid'.

It's trivial to change if somebody has a better idea or convince me with
some variation on not-yet-valid.

> > +
> > +	/*
> > +	 * Print all at once so we get a snapshot of all values from the same
> > +	 * time. Keep them in sync and in order of definition of
> > +	 * btrfs_dev_stat_values.
> > +	 */
> > +	return scnprintf(buf, PAGE_SIZE,
> > +		"write_errs %d\n"
> > +		"read_errs %d\n"
> > +		"flush_errs %d\n"
> > +		"corruption_errs %d\n"
> > +		"generation_errs %d\n",
> > +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
> > +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
> > +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
> > +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
> > +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
> > +}
> > +BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
> > +
> >   static struct attribute *devid_attrs[] = {
> > +	BTRFS_ATTR_PTR(devid, error_stats),
> >   	BTRFS_ATTR_PTR(devid, in_fs_metadata),
> >   	BTRFS_ATTR_PTR(devid, missing),
> >   	BTRFS_ATTR_PTR(devid, replace_target),
> > 
> 
> 
> write_errs 0
> read_errs 0
> flush_errs 0
> corruption_errs 1
> generation_errs 0
> 
> 
> Another option was to print all errors in a single line. A single line
> will help continuous monitoring of the error_stats. But it is not a big
> deal.

I think that's just a matter of transforming the data to the convenient
form. Line based stats values is more common and grep-friendly. For a
monitoring tool/scripts that want it in one line it's perhaps a simple

  cat devinfo/error_sats | tr '\n' ' '

Converting from one line to multiple lines is not that trivial.
