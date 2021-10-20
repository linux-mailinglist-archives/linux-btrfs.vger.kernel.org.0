Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9A434C94
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTNte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhJTNtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 09:49:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5CC061746
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:47:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o12so3026180qtq.7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GkJ6oNA+oGZnNEIkoDRP+Fn4RC9YbPBn9vYR1frmOUA=;
        b=bqhlXh5CZvxib6QQWnR9IrFYDksa9fAFB3tfKsF2wIaKAfBok8SL6TL8Q9zCiJVw4W
         TDGvJEEfd7B77leJ8CS8En3OcBgxzsNKizwk3x2nglGMZTms4JBItj1h6/egGydeGlIh
         9/UZC6jstRVaW2lMDRXws/SXSGM9m/mNmXpQ3NaJD9Lyu/4w7e1hro7u3P7RF1gfj5ng
         P2VviWaPVdoDwO+mCFdORE2LUXNOdG/BOPfjtGU+b++ICwjIA8terNiaMArYfbkAUEkN
         fdwdBSq1d+l+5ikPm5EQuM40zHQbnh1DgTY8LFT0WaSyBjhdUGdzfyLKoqxnfCtUWc8w
         dSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkJ6oNA+oGZnNEIkoDRP+Fn4RC9YbPBn9vYR1frmOUA=;
        b=KNYa+pJRagO+nmvmBFb6e+WEToZLe36Ye4/5ECFEgLhlwfO2ZtfBczHbMeLyxfTRI+
         ww4YXqHZhvkHLh+NzSXgHgO41NmQpK+vWtopXtBcwUCqVrxy4K1zT4SSVQ7oQ9vBU4kP
         bJWjOOrUCM7XmVtYAxuMXLWDEa6k5CQDFFmayXa+QR/X4Mvy9eF08JWjv6hr2zGRaRWT
         GHk8N5XD/2fFq0lvKypGlqipFjvq5I/p8qwC5fF/CvmhLNlx/Cu/XFAWsYnkonNeqGLe
         ETbS11oQ+oiUhnjHWVA7djUtjbpaeY6J9etMFEDbScm+j/ilXem0qUKFpZ+lTg7mhojz
         guzg==
X-Gm-Message-State: AOAM533K0SSVyGdUpYmoAE6UbRBMuHYh0Hbsy/1UDfZ3hDIUHHT+Dsvn
        m3hb2J/pbmxQUxiqYqSDg81DspB0J1VHVA==
X-Google-Smtp-Source: ABdhPJwFymMkU2K/tlyqfqZ84SzM589EgXt2HBoIWasO/K7EY1FqFPkCwU0+cc7I+lHu9Z+2USCWrg==
X-Received: by 2002:ac8:58cf:: with SMTP id u15mr4640qta.334.1634737625237;
        Wed, 20 Oct 2021 06:47:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q8sm1109032qkl.2.2021.10.20.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:47:04 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:47:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in
 device_is_seed
Message-ID: <YXAd15erkjF+r+tG@localhost.localdomain>
References: <cover.1634598659.git.anand.jain@oracle.com>
 <873d173c3b16fcd027dba4b10690e3e3fc3b6cdd.1634598659.git.anand.jain@oracle.com>
 <YW7QJUNHU9Eo/wZp@localhost.localdomain>
 <61915dee-0878-a170-87d5-a3d611af6810@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61915dee-0878-a170-87d5-a3d611af6810@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 10:40:14AM +0800, Anand Jain wrote:
> 
> 
> On 19/10/2021 22:03, Josef Bacik wrote:
> > On Tue, Oct 19, 2021 at 08:23:45AM +0800, Anand Jain wrote:
> > > The kernel patch [1] added a sysfs interface to read the device fsid from
> > > the kernel, which is a better way to know the fsid of the device (rather
> > > than reading the superblock). It also works if in case the device is
> > > missing. Furthermore, the sysfs interface is readable from the non-root
> > > user.
> > > 
> > > So use this new sysfs interface here to read the fsid.
> > > 
> > > [1]
> > > btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
> > >   1 file changed, 30 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> > > index 0dfc798e8dcc..f658c27b9609 100644
> > > --- a/cmds/filesystem-usage.c
> > > +++ b/cmds/filesystem-usage.c
> > > @@ -40,6 +40,7 @@
> > >   #include "common/help.h"
> > >   #include "common/device-utils.h"
> > >   #include "common/open-utils.h"
> > > +#include "common/path-utils.h"
> > >   /*
> > >    * Add the chunk info to the chunk_info list
> > > @@ -706,14 +707,33 @@ out:
> > >   	return ret;
> > >   }
> > > -static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
> > > +static int device_is_seed(int fd, const char *dev_path, u64 devid, u8 *mnt_fsid)
> > >   {
> > > +	char fsidparse[BTRFS_UUID_UNPARSED_SIZE];
> > > +	char fsid_path[PATH_MAX];
> > > +	char devid_str[20];
> > >   	uuid_t fsid;
> > > -	int ret;
> > > +	int ret = -1;
> > > +	int sysfs_fd;
> > > +
> > > +	snprintf(devid_str, 20, "%llu", devid);
> > > +	/* devinfo/<devid>/fsid */
> > > +	path_cat3_out(fsid_path, "devinfo", devid_str, "fsid");
> > > +
> > > +	/* /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid */
> > > +	sysfs_fd = sysfs_open_fsid_file(fd, fsid_path);
> > > +	if (sysfs_fd >= 0) {
> > > +		sysfs_read_file(sysfs_fd, fsidparse, BTRFS_UUID_UNPARSED_SIZE);
> > > +		fsidparse[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
> > > +		ret = uuid_parse(fsidparse, fsid);
> > > +		close(sysfs_fd);
> > > +	}
> > > -	ret = dev_to_fsid(dev_path, fsid);
> > 
> > Why not just have dev_to_fsid() use the sysfs thing so all callers can benefit
> > from it, and then have it fall back to the reading of the super block?  Thanks,
> 
> If we are using sysfs to read fsid it means the device is mounted.
> 
> cmd_filesystem_show() uses dev_to_fsid() only if the device is unmounted. So
> we can't use fsid by sysfs here.
> 
> There is no other user of dev_to_fsid().
> 

Ah ok that's reasonable then, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series then.  Thanks,

Josef
