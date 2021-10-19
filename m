Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8424337FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhJSOFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhJSOFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:05:35 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C436CC061746
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:03:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e13so3085qvf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rD06Jfxh5q5HOyd0ZB3vl49o7SFV5zGspmr+Bt5FHW8=;
        b=M4eUUbzpUwWoy6k7Ie4UaZ3EdvR26LEoAMQ9fexmfP7kAwuazGw1aXka4H5qaVXNJn
         z0+YTSvWWhQNECJe+V+1gctRfWVRjw7uqLbscq+LlhxOHG9snqW72ysv7J1IZTo0461i
         JvQrH2gu9dsIoPJpynufHLXyzTyMAek8cuM6JStnG3xwkFm7zEd3TEgF6EczCgY5eawV
         /3w5PQceoC+akogZ4kXKWfD99YUrFotlBBBYh80GCUtcT4V3GVi7L8XBb13/vMeHAuBA
         RvPYTAxs7ZtqpLsrvRwd9nEn/Xb9s9hOEg4voaxulRB3mtItgVlE1akIpx++uG61yQF9
         0B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rD06Jfxh5q5HOyd0ZB3vl49o7SFV5zGspmr+Bt5FHW8=;
        b=OBha44P2Wpuob+uTAu+tIiasVIjhguoAh/fcbZxQDeWERr314J/u2PL8n5DCCBTpDK
         ufjWhMm9VLgW7IYPVMaAy0/IK8TLXDVR/VCmXHuQarKWEj2tHrzpupUHJQ69Rf4ThGXj
         YO4OxxHNcyqprmI8PYDgWPegpa3Wjx+Xdxf4PT8lTDg38Siy94VWO7M9UimQcKgDOKEm
         03uDCLHqhHeNGcEM1ZOXtZ0Cjfh/lnVJM5/EdXvJ9AowQZ1k6SFXeYKLX72XidlvICgb
         tLxD2FBAyCzJ29fG98TvCW+UxdqWSxUle7VviXakxXbGqOZl/56mff4DR2Xbh16Y2nzS
         7foA==
X-Gm-Message-State: AOAM532X+f3tG9KtkdM3meWcZ1TL44WC1vIv1ReEZbuAtnwkDCrE/NDB
        DsaeC23bptNzC7IPnpYOykGgPVn3zJ8pmA==
X-Google-Smtp-Source: ABdhPJwT00twPJR4A/VPoh/f9WyOHxxnB/2ba7F5zQZaTT+T0IbU7MqzbmJqOLkg6ca7UeEjMUJkAg==
X-Received: by 2002:ad4:4970:: with SMTP id p16mr31526588qvy.37.1634652199792;
        Tue, 19 Oct 2021 07:03:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u189sm7886938qkh.14.2021.10.19.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:03:18 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:03:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in
 device_is_seed
Message-ID: <YW7QJUNHU9Eo/wZp@localhost.localdomain>
References: <cover.1634598659.git.anand.jain@oracle.com>
 <873d173c3b16fcd027dba4b10690e3e3fc3b6cdd.1634598659.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873d173c3b16fcd027dba4b10690e3e3fc3b6cdd.1634598659.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:23:45AM +0800, Anand Jain wrote:
> The kernel patch [1] added a sysfs interface to read the device fsid from
> the kernel, which is a better way to know the fsid of the device (rather
> than reading the superblock). It also works if in case the device is
> missing. Furthermore, the sysfs interface is readable from the non-root
> user.
> 
> So use this new sysfs interface here to read the fsid.
> 
> [1]
> btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 0dfc798e8dcc..f658c27b9609 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -40,6 +40,7 @@
>  #include "common/help.h"
>  #include "common/device-utils.h"
>  #include "common/open-utils.h"
> +#include "common/path-utils.h"
>  
>  /*
>   * Add the chunk info to the chunk_info list
> @@ -706,14 +707,33 @@ out:
>  	return ret;
>  }
>  
> -static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
> +static int device_is_seed(int fd, const char *dev_path, u64 devid, u8 *mnt_fsid)
>  {
> +	char fsidparse[BTRFS_UUID_UNPARSED_SIZE];
> +	char fsid_path[PATH_MAX];
> +	char devid_str[20];
>  	uuid_t fsid;
> -	int ret;
> +	int ret = -1;
> +	int sysfs_fd;
> +
> +	snprintf(devid_str, 20, "%llu", devid);
> +	/* devinfo/<devid>/fsid */
> +	path_cat3_out(fsid_path, "devinfo", devid_str, "fsid");
> +
> +	/* /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid */
> +	sysfs_fd = sysfs_open_fsid_file(fd, fsid_path);
> +	if (sysfs_fd >= 0) {
> +		sysfs_read_file(sysfs_fd, fsidparse, BTRFS_UUID_UNPARSED_SIZE);
> +		fsidparse[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
> +		ret = uuid_parse(fsidparse, fsid);
> +		close(sysfs_fd);
> +	}
>  
> -	ret = dev_to_fsid(dev_path, fsid);

Why not just have dev_to_fsid() use the sysfs thing so all callers can benefit
from it, and then have it fall back to the reading of the super block?  Thanks,

Josef
