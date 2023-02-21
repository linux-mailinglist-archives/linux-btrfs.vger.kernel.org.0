Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738069EB28
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 00:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBUXWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 18:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBUXWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 18:22:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4929E1E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:22:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C5C95CDDA;
        Tue, 21 Feb 2023 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677021747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLcuqvlD+ICDjRALeG9mvmzqmeAZxHsHK9UWTSbdjxc=;
        b=FMwPLwH73BDxsRM1BFQMY379rRw4EP9C6LPgsSU8dDPPjZNXoqoQIzWClBuwijYCnVWg8u
        VzxHw6tvhwxgZOZVAs4nPixkjuPO47x20bXnZgnyFqqRogQjiVDnxXg520mnsi56019ct0
        KuwMB7ZQvF1K3Jc2/XTaNe3/dQ0fi74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677021747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLcuqvlD+ICDjRALeG9mvmzqmeAZxHsHK9UWTSbdjxc=;
        b=VvXwEKBFow58gOePocMkRy0/TQchk7gCYeWf2GQ5PafF1HCnnQGuxNahyRqRnzH+XqWH+h
        CzwIXXmcsMIANWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6324D13223;
        Tue, 21 Feb 2023 23:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q6pHFzNS9WNYWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 23:22:27 +0000
Date:   Wed, 22 Feb 2023 00:16:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/2] btrfs-progs: prepare helper device_is_seed
Message-ID: <20230221231631.GP10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676124188.git.anand.jain@oracle.com>
 <1eb9319975967eb52107c9355d712f9eb9d96cf7.1676124188.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb9319975967eb52107c9355d712f9eb9d96cf7.1676124188.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 05:37:41PM +0800, Anand Jain wrote:
> load_device_info() checks if the device is a seed device by reading
> superblock::fsid and comparing it with the mount fsid, and it fails
> to work if the device is missing (a RAID1 seed fs). Move this part
> of the code into a new helper function device_is_seed() in
> preparation to make device_is_seed() work with the new sysfs
> devinfo/<devid>/fsid interface.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  cmds/filesystem-usage.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 5810324f245e..bef9a1129a63 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -27,6 +27,7 @@
>  #include <fcntl.h>
>  #include <dirent.h>
>  #include <limits.h>
> +#include <uuid/uuid.h>
>  #include "kernel-lib/sizes.h"
>  #include "kernel-shared/ctree.h"
>  #include "kernel-shared/disk-io.h"
> @@ -700,6 +701,21 @@ out:
>  	return ret;
>  }
>  
> +static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
> +{
> +	uuid_t fsid;

I've switched this to a u8[BTFFS_UUID_SIZE] buffer, as it was in the
other funcion.

> +	int ret;
> +
> +	ret = dev_to_fsid(dev_path, fsid);
> +	if (ret)
> +		return ret;
> +
> +	if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE))

IMO strcmp and memcmp should use the == 0 or != 0 explicitly so it's
closer to the meaning.

> +		return 0;
> +
> +	return -1;
> +}
> +
>  /*
>   *  This function loads the device_info structure and put them in an array
>   */
> @@ -710,7 +726,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  	struct btrfs_ioctl_fs_info_args fi_args;
>  	struct btrfs_ioctl_dev_info_args dev_info;
>  	struct device_info *info;
> -	u8 fsid[BTRFS_UUID_SIZE];
>  
>  	*devcount_ret = 0;
>  	*devinfo_ret = NULL;
> @@ -754,8 +769,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  		 * Ignore any other error including -EACCES, which is seen when
>  		 * a non-root process calls dev_to_fsid(path)->open(path).
>  		 */
> -		ret = dev_to_fsid((const char *)dev_info.path, fsid);
> -		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
> +		ret = device_is_seed((const char *)dev_info.path, fi_args.fsid);
> +		if (!ret)
>  			continue;
>  
>  		info[ndevs].devid = dev_info.devid;
> -- 
> 2.39.1
