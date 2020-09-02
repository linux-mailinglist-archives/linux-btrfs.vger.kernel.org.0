Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6525B571
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBUpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 16:45:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBUpV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 16:45:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63C63AD3C;
        Wed,  2 Sep 2020 20:45:21 +0000 (UTC)
Date:   Wed, 2 Sep 2020 15:45:16 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/4] btrfs-progs: Enqueue command if it can't be
 performed immediately
Message-ID: <20200902204516.poralnz3skht5myn@fiona>
References: <20200825150233.30294-1-rgoldwyn@suse.de>
 <20200825150338.32610-1-rgoldwyn@suse.de>
 <20200825150338.32610-4-rgoldwyn@suse.de>
 <20200902141117.GK28318@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902141117.GK28318@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16:11 02/09, David Sterba wrote:
> On Tue, Aug 25, 2020 at 10:03:38AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Wait for the current exclusive operation to finish before issuing the
> > command ioctl, so we have a better chance of success.
> > 
> > Q: The resize argument parsing is hackish. Is there a better way to do
> > this?
> 
> You mean parsing in kernel? Progs pass the 1st non-option parameter
> without changes, so if you add a new option, the -- separator needs to
> be used to make sure the relative size update (eg. -1G) is properly
> recognized. This is built in already and should not require anything
> special on the option parsing side.

Particularly the example you mention, -1G. You answered it as well :)

> 
> > --- a/cmds/device.c
> > +++ b/cmds/device.c
> > @@ -49,6 +49,7 @@ static const char * const cmd_device_add_usage[] = {
> >  	"",
> >  	"-K|--nodiscard    do not perform whole device TRIM on devices that report such capability",
> >  	"-f|--force        force overwrite existing filesystem on the disk",
> > +	"-q|--enqueue	   enqueue if an exclusive operation is running",
> 
> Short for -q should not be used due to confusion with --quiet. Also I
> think that --enqueue is not a common action that would need a short
> option, the long option is always safe.

Yes, and --quit as well. However, just --enqueue is fine.

> 
> > --- a/common/sysfs.c
> > +++ b/common/sysfs.c
> > @@ -50,3 +50,29 @@ int get_exclusive_operation(int mp_fd, char *val)
> >  	val[n - 1] = '\0';
> >  	return n;
> >  }
> > +
> > +int sysfs_wait(int fd, int seconds)
> > +{
> > +	fd_set fds;
> > +	struct timeval tv;
> > +
> > +	FD_ZERO(&fds);
> > +	FD_SET(fd, &fds);
> > +
> > +	tv.tv_sec = seconds;
> > +	tv.tv_usec = 0;
> > +
> > +	return select(fd+1, NULL, NULL, &fds, &tv);
> 
> With the short sleep times, do we need to wait using select? Yes this
> would return once the notification event is sent but as the sleep time
> is 1 second, it could simply be sleep(1) unconditionally.

Yes, the kernel provides the sysfs notification. We could sys_wait() for
longer (with a higher wait parameter) and yet the function would return
the moment the kernel notifies the change. I know we are not using it
now, but it is better to use robust interfaces when a event notification
is provided by the kernel.

> 
> > +}
> > +
> > +void wait_for_exclusive_operation(int dirfd)
> > +{
> > +        char exop[BTRFS_SYSFS_EXOP_SIZE];
> > +	int fd;
> > +
> > +        fd = sysfs_open(dirfd, "exclusive_operation");
> > +        while ((sysfs_get_str_fd(fd, exop, BTRFS_SYSFS_EXOP_SIZE) > 0) &&
> > +		strncmp(exop, "none", 4))
> > +			sysfs_wait(fd, 1);
> > +	close(fd);
> > +}
> > diff --git a/common/utils.h b/common/utils.h
> > index be8aab58..f141edb6 100644
> > --- a/common/utils.h
> > +++ b/common/utils.h
> > @@ -155,5 +155,6 @@ int btrfs_warn_multiple_profiles(int fd);
> >  
> >  #define BTRFS_SYSFS_EXOP_SIZE		16
> >  int get_exclusive_operation(int fd, char *val);
> > +void wait_for_exclusive_operation(int fd);
> >  
> >  #endif
> > -- 
> > 2.26.2

-- 
Goldwyn
