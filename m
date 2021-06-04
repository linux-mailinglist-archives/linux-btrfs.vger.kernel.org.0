Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393EF39B9D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFDN1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 09:27:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44498 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhFDN1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 09:27:52 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A82221A22;
        Fri,  4 Jun 2021 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622813165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQTYIfyQd0dBrOXlYtU5xxjjhfuttcKgQu3fy8GVp4M=;
        b=LPfb+MQNFMIg/IXv4aXvoDuclKAxaYW2Vx5sGxmdyoRlUzE0xKvhy/4X9E9OGXk5XBpD3g
        if2n0qeCYQvUY7ou3jHrV73Gl1oXAawbZrwxFrjT2PSjhNTxQ71EoEj3L3GdVzrDgiZojC
        nCYENJgYld0DspEElr47PjKwC0jy098=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622813165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQTYIfyQd0dBrOXlYtU5xxjjhfuttcKgQu3fy8GVp4M=;
        b=0gT62dcoj26AlGVtyAvPnfaO8D5RjAGr4WyxDAu9335zBjWmwNu6bd9/HxLBG8ZQ3g8GDm
        q5Y8es83J7S23mCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 532E1A3B9F;
        Fri,  4 Jun 2021 13:26:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9D4CDB228; Fri,  4 Jun 2021 15:23:23 +0200 (CEST)
Date:   Fri, 4 Jun 2021 15:23:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210604132323.GC31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604132058.11334-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 04, 2021 at 03:20:58PM +0200, David Sterba wrote:
> The device stats can be read by ioctl, wrapped by command 'btrfs device
> stats'. Provide another source where to read the information in
> /sys/fs/btrfs/FSID/devinfo/DEVID/stats . The format is a list of
> 'key value' pairs one per line, which is common in other stat files.
> The names are the same as used in other device stat outputs.
> 
> The stats are all in one file as it's the snapshot of all available
> stats. The 'one value per file' is not very suitable here. The stats
> should be valid right after the stats item is read from disk, shortly
> after initializing the device, but in any case also print the validity
> status.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4b508938e728..3d4c806c4f73 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>  
> +static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
> +		struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	/*
> +	 * Print all at once so we get a snapshot of all values from the same
> +	 * time. Keep them in sync and in order of definition of
> +	 * btrfs_dev_stat_values.
> +	 */
> +	return scnprintf(buf, PAGE_SIZE,
> +		"stats_valid %d\n",
                                  ^
should not be here, uncommited version sent.
