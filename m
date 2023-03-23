Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF96C7034
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 19:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCWSbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWSbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 14:31:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533210AB8
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:31:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5188F33836;
        Thu, 23 Mar 2023 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679596260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rwslf/jDwmopW+MQUDKGL5+6p3at59cO7KZKx9sSb+Q=;
        b=zw7LsBhP/1pTvi8oMe48jLnpPs/NjbTVsRT3OKysFDKLznL6GU6xQQI7ix9oeUPDo7+0Ms
        +ewmtIjbgueZMATnsylOsbK4yX1QY0d47dZEq7bxc18MjMUnKk7lRngThh3mLnInj30TpW
        XtbJwKtNGgOS5IcRkU7xXLiGWkijY4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679596260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rwslf/jDwmopW+MQUDKGL5+6p3at59cO7KZKx9sSb+Q=;
        b=kG9NQToa+AbIB4sDH2wUi1kceIPQpLY8PHasnlpqNaw/5ahAvooHsN4LgaIFC0veV0U5gj
        3/YFaXUKk7rmZECA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29DB413596;
        Thu, 23 Mar 2023 18:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jOs5CeSaHGQfDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 18:31:00 +0000
Date:   Thu, 23 Mar 2023 19:24:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: fix mkfs/mount/check failures due to race with
 systemd-udevd scan
Message-ID: <20230323182448.GW10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <998486a6a1bddf36c3d3dc92df08eaa1b3a6ee7f.1679557827.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998486a6a1bddf36c3d3dc92df08eaa1b3a6ee7f.1679557827.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 03:56:48PM +0800, Anand Jain wrote:
> During the device scan initiated by systemd-udevd, other user space
> EXCL operations such as mkfs, mount, or check may get blocked and result
> in a "Device or resource busy" error. This is because the device
> scan process opens the device with the EXCL flag in the kernel.
> 
> Two reports were received:
> 
>  . One with the btrfs/179 testcase, where the fsck command failed with
>    the -EBUSY error; and
> 
>  . Another with the LTP pwritev03 testcase, where mkfs.vfs failed with
>    the -EBUSY error, when mkfs.vfs tried to overwrite old btrfs filesystem
>    on the device.
> 
> In both cases, fsck and mkfs (respectively) were racing with a
> systemd-udevd device scan, and systemd-udevd won, resulting in the
> -EBUSY error for fsck and mkfs.
> 
> Reproducing the problem has been difficult because there is a very
> small timeframe during which these userspace threads can race to
> acquire the exclusive device open. Even on the system where the problem
> was observed, the problem occurances were anywhere between 10 to 400
> iterations and chances of reproducing lessen with debug printk()s.
> 
> However, an exclusive device open is unnecessary for the scan process,
> as there are no write operations on the device during scan. Furthermore,
> during the mount process, the superblock is re-read in the below
> function stack.
> 
>   btrfs_mount_root
>    btrfs_open_devices
>     open_fs_devices
>      btrfs_open_one_device
>        btrfs_get_bdev_and_sb
> 
> So, to fix this issue, this patch removes the FMODE_EXCL flag from the scan
> operation, and adds a comment.


> 
> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
>  This patch should be cc-ed to stable-5.15.y and stable-6.1.y. As for
>  stable-5.10.y and stable-5.4.y, a conflict fix is necessary, which I
>  will send separately.
> 
>  fs/btrfs/volumes.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 93bc45001e68..cc1871767c8c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1366,8 +1366,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	 * So, we need to add a special mount option to scan for
>  	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>  	 */
> -	flags |= FMODE_EXCL;
>  
> +	/*
> +	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
> +	 * initiate the device scan which may race with the user's mount
> +	 * or mkfs command, resulting in failure.
> +	 * Since the device scan is solely for reading purposes, there is
> +	 * no need for FMODE_EXCL. Additionally, the devices are read again
> +	 * during the mount process. It is ok to get some inconsistent
> +	 * values temporarily, as the device paths of the fsid are the only
> +	 * required information for assembling the volume.
> +	 */

The most problematic case is when mkfs races with scan, that's where the
inconsitent data can be read. Mkfs does not write the signature until
everything is done and scan verifies the signature so here the scan
would say it's not a btrfs device. Once mkfs finishes the scan is ran
again as a udev event.

Added to misc-next, thanks.
