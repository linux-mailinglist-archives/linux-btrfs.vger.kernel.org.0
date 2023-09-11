Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768779BA2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbjIKWCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbjIKRnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:43:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A08CC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:43:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F384A1F38D;
        Mon, 11 Sep 2023 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694454193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEp+LGoDdXKNdilFUKaCzUyEUwSgF5AtIZ7DzbBWIbs=;
        b=pbjb7N4yE+YpZ4fNRY3PTtlLw1+JDO9vYIchoHKPX00LfFQoehitRntKA8mpB5nPSw1EVe
        y15YV6jjdj++9wCWwBbIZhCW9+xf/sFkobDidZmsroCO669ZFyqqHr0y9JhDt5NzZnKlrc
        3bPkKSNXdvH3DbfhKNNMPHaKUjlkpBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694454193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEp+LGoDdXKNdilFUKaCzUyEUwSgF5AtIZ7DzbBWIbs=;
        b=CVG1VSlA6RlDLQaKFm159dA7rx9W0FM1fpRIkbKKi+3apjGcCeOxzjRxkCFCMnohAmS4mj
        YncWVSJuAK1iXzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF6D413780;
        Mon, 11 Sep 2023 17:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gr7lMbBR/2QbLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 17:43:12 +0000
Date:   Mon, 11 Sep 2023 19:36:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, gpiccoli@igalia.com, dsterba@suse.cz
Subject: Re: [PATCH v2] btrfs: pseudo device-scan for single-device
 filesystems
Message-ID: <20230911173638.GE3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 12:31:55AM +0800, Anand Jain wrote:
> After the commit 5f58d783fd78 ("btrfs: free device in btrfs_close_devices
> for a single device filesystem") we unregister the device from the kernel
> memory upon unmounting for a single device.
> 
> So, device registration that was performed before mounting if any is no
> longer in the kernel memory.
> 
> However, in fact, note that device registration is unnecessary for a
> single-device Btrfs filesystem unless it's a seed device.
> 
> So for commands like 'btrfs device scan' or 'btrfs device ready' with a
> non-seed single-device Btrfs filesystem, they can return success just
> after superblock verification and without the actual device scan.
> 
> The seed device must remain in the kernel memory to allow the sprout
> device to mount without the need to specify the seed device explicitly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Needs fstests fix in the mailing list:
>   [PATCH] fstests: btrfs/185 update for single device pseudo device-scan
> 
> V2:
> . Commit log updated
> . Handle 'device == NULL' separately.
> . Convert 'pr_info()' to 'pr_debug()'.
> . Btrfs/245 test_forget() was failing because it checked if the scan was
>   successful by calling 'forget' and ensuring it returned success. As we
>   aren't actually scanning, similarly do the same in forget aswell check
>   if device present free it, and always return success.
> 
>  fs/btrfs/super.c   | 17 ++++++++++++-----
>  fs/btrfs/volumes.c | 21 ++++++++++++++++++++-
>  fs/btrfs/volumes.h |  3 ++-
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 32ff441d2c13..39be36096640 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>  				error = -ENOMEM;
>  				goto out;
>  			}
> -			device = btrfs_scan_one_device(device_name, flags);
> +			device = btrfs_scan_one_device(device_name, flags, false);
>  			kfree(device_name);
>  			if (IS_ERR(device)) {
>  				error = PTR_ERR(device);
> @@ -1486,7 +1486,12 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  		goto error_fs_info;
>  	}
>  
> -	device = btrfs_scan_one_device(device_name, mode);
> +	device = btrfs_scan_one_device(device_name, mode, true);
> +	/*
> +	 * As we passed 'true' in 3rd the argument, we need proper error code,
> +	 * not null.
> +	 */
> +	ASSERT(device != NULL);
>  	if (IS_ERR(device)) {
>  		mutex_unlock(&uuid_mutex);
>  		error = PTR_ERR(device);
> @@ -2199,7 +2204,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case BTRFS_IOC_SCAN_DEV:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		/* Return success i.e. 0 for device == NULL */
>  		ret = PTR_ERR_OR_ZERO(device);
>  		mutex_unlock(&uuid_mutex);
>  		break;
> @@ -2213,9 +2219,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	case BTRFS_IOC_DEVICES_READY:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> -		if (IS_ERR(device)) {
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		if (IS_ERR_OR_NULL(device)) {
>  			mutex_unlock(&uuid_mutex);
> +			/* Return success i.e. 0 for device == NULL */
>  			ret = PTR_ERR(device);

Should this also be PTR_ERR_OR_ZERO(device) like in the other case?

>  			break;
>  		}
