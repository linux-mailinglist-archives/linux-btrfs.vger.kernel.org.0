Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6F69EB29
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 00:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjBUXXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 18:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBUXXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 18:23:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE631B556
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:23:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 626AE3520B;
        Tue, 21 Feb 2023 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677021782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qrwuXNBDKupupjg56bQiWKrnG6YVxe/htGnCOj3mK0=;
        b=GBSeGMhzyFGDVN2d2hDzkwVNppkPjeuiK1e120CTQrx3yuAmQ3FxO30RXAx+QmloFoipzz
        bNAPE6KcdEK+OJp6nHn3yUAeSqrAQ2d2FB8GUKKs8XvewPYv9kEPTWS9UBbDWiJY9iO8P6
        zSCsRmVy6C3SrDGi++y65zwD7NSefrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677021782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qrwuXNBDKupupjg56bQiWKrnG6YVxe/htGnCOj3mK0=;
        b=kRG8YIxtCribHXZMdkg79p+efw3Q6fzu1S6x5bZ5ZBoE4eoZ2N8NMMOnaGZj9ijYC+tI/e
        lo2ZzgRyxqbjSfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 375D213223;
        Tue, 21 Feb 2023 23:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H6ORDFZS9WOLWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 23:23:02 +0000
Date:   Wed, 22 Feb 2023 00:17:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in
 device_is_seed
Message-ID: <20230221231706.GQ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676124188.git.anand.jain@oracle.com>
 <7523436ccbf95d7fde690f41095637ce9d9fc1b4.1676124188.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7523436ccbf95d7fde690f41095637ce9d9fc1b4.1676124188.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 05:37:42PM +0800, Anand Jain wrote:
> The kernel commit a26d60dedf9a ("btrfs: sysfs: add devinfo/fsid to
> retrieve actual fsid from the device" introduced a sysfs interface
> to access the device's fsid from the kernel. This is a more
> reliable method to obtain the fsid compared to reading the
> superblock, and it even works if the device is not present.
> Additionally, this sysfs interface can be read by non-root users.
> 
> Therefore, it is recommended to utilize this new sysfs interface to
> retrieve the fsid.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index bef9a1129a63..e7fa18dc82dc 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -39,6 +39,7 @@
>  #include "common/help.h"
>  #include "common/device-utils.h"
>  #include "common/messages.h"
> +#include "common/path-utils.h"
>  #include "cmds/filesystem-usage.h"
>  #include "cmds/commands.h"
>  
> @@ -701,14 +702,33 @@ out:
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

This could potentially fail so the return value needs to be checked.

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
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret = dev_to_fsid(dev_path, fsid);
> +		if (ret)
> +			return ret;
> +	}
