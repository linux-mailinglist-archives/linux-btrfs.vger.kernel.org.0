Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC0584327
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiG1Pgz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG1Pgz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 11:36:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05334F685
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 08:36:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B91120DB5;
        Thu, 28 Jul 2022 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659022612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJMWzUDTTx9wzgMLv0W5vbgBc4wpvhKEnu+Q1mlQdfU=;
        b=LIWQv7CwTBcNcISLKjHwONEhUocDX3nX8xZkxgrQT+hsvnoa510FILz4fEnj7huLRs6Yf+
        2upAribDd/7obwsSJmgo+8vpqZjhI9srqLTYls1yIjLxPNlBynVCXqUcjU8qfKYwddxo83
        myi9Zq+kgIQQlXAgcMuslK+bN+LaklY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659022612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJMWzUDTTx9wzgMLv0W5vbgBc4wpvhKEnu+Q1mlQdfU=;
        b=sYjh54LfmQBZet8BuIDrL3mcIaDTz21v9p1juKldXO/td7WqiQRffL3hti3KK6LXhGIQD5
        LBWMZ5b/Mjbqd4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B96713427;
        Thu, 28 Jul 2022 15:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JlRqGRSt4mILfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 15:36:52 +0000
Date:   Thu, 28 Jul 2022 17:31:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V4] btrfs-progs: fix btrfs resize failed.
Message-ID: <20220728153153.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 12:46:14AM +0800, Li Zhang wrote:
> Issue: 470
> 
> [BUG]
> 1. If there is no devid=1, when the user uses the btrfs file system tool,
> the following error will be reported,
> 
> $ sudo btrfs filesystem show /mnt/1
> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
>     Total devices 2 FS bytes used 704.00KiB
>     devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>     devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: cannot find devid: 1
> ERROR: unable to resize '/mnt/1': No such device
> 
> 2. Function check_resize_args, if get_fs_info is successful,
> check_resize_args always returns 0, Even if the parameter
> passed to kernel space is longer than the size allowed to
> be passed to kernel space (BTRFS_VOL_NAME_MAX).
> 
> [CAUSE]
> 1. If the user does not specify the devid id explicitly,
> btrfs will use the default devid 1, so it will report an error when dev 1 is missing.
> 
> 2. The last line of the function check_resize_args is return 0.
> 
> [FIX]
> 1. If the file system contains multiple devices, output an error message to the user.
> If the filesystem has only one device, resize should automatically add the unique devid.
> 
> 2. The function check_resize_args should not return 0 on the last line,
> it should return ret representing the return value.
> 
> 3. Update the "btrfs-filesystem" man page
> 
> [RESULT]
> 
> $ sudo btrfs filesystem resize --help
> usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
> 
>     Resize a filesystem
> 
>     If the filesystem contains only one device, devid can be ignored.
>     If 'max' is passed, the filesystem will occupy all available space
>     on the device 'devid'.
>     [kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.
> 
>     --enqueue         wait if there's another exclusive operation running,
>                       otherwise continue
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>         Total devices 2 FS bytes used 144.00KiB
>         devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>         devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> 
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: The file system has multiple devices, please specify devid exactly.
> ERROR: The device information list is as follows.
>         devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>         devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

I think the list of devices does not need to be here, the errors are
usually printed stating what went wrong and where to look eventually,
but dumping too much iformation obscures the error.

> $ sudo btrfs device delete 2 /mnt/1/
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>         Total devices 1 FS bytes used 144.00KiB
>         devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
> 
> $ sudo btrfs filesystem resize -1G /mnt/1
> Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
>         Total devices 1 FS bytes used 144.00KiB
>         devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> V1:
>  * Automatically add devid if device is not specific
> 
> V2:
>  * resize fails if filesystem has multiple devices
> 
> V3:
>  * Fix incorrect behavior of function check_resize_args
> 
>  * Updated resize help information
> 
> V4:
>  * Update man pages
>  Documentation/btrfs-filesystem.rst | 22 ++++++++++++------
>  cmds/filesystem.c                  | 47 ++++++++++++++++++++++++++++++++------
>  2 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
> index fe98597..5b3f2e2 100644
> --- a/Documentation/btrfs-filesystem.rst
> +++ b/Documentation/btrfs-filesystem.rst
> @@ -197,8 +197,11 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE]|[<devid>:]max <path>
>                  as expected and does not resize the image. This would resize the underlying
>                  filesystem instead.
>  
> -        The *devid* can be found in the output of **btrfs filesystem show** and
> -        defaults to 1 if not specified.
> +        The *devid* can be found in the output of **btrfs filesystem show**.
> +
> +        If the filesystem contains only one device, it can be
> +        resized without specifying a specific device.
> +
>          The *size* parameter specifies the new size of the filesystem.
>          If the prefix *+* or *-* is present the size is increased or decreased
>          by the quantity *size*.
> @@ -208,7 +211,7 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE]|[<devid>:]max <path>
>          KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not matter).
>  
>          If *max* is passed, the filesystem will occupy all available space on the
> -        device respecting *devid* (remember, devid 1 by default).
> +        device respecting *devid*.
>  
>          The resize command does not manipulate the size of underlying
>          partition.  If you wish to enlarge/reduce a filesystem, you must make sure you
> @@ -413,14 +416,19 @@ even if run repeatedly.
>  
>  **$ btrfs filesystem resize -1G /path**
>  
> +Let's assume that filesystem contains only one device.
> +Shrink size of the filesystem's single-device by 1GiB.
> +
> +
>  **$ btrfs filesystem resize 1:-1G /path**
>  
> -Shrink size of the filesystem's device id 1 by 1GiB. The first syntax expects a
> -device with id 1 to exist, otherwise fails. The second is equivalent and more
> -explicit. For a single-device filesystem it's typically not necessary to
> -specify the devid though.
> +Shrink size of the filesystem's device id 1 by 1GiB. This command expects a
> +device with id 1 to exist, otherwise fails.
>  
>  **$ btrfs filesystem resize max /path**
> +Let's assume that filesystem contains only one device and the filesystem
> +does not occupy the whole block device,By simply using *max* as size we
> +will achieve that.
>  
>  **$ btrfs filesystem resize 1:max /path**
>  
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7cd08fc..e641fcb 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
>  static const char * const cmd_filesystem_resize_usage[] = {
>  	"btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>",
>  	"Resize a filesystem",
> +	"If the filesystem contains only one device, devid can be ignored.",
>  	"If 'max' is passed, the filesystem will occupy all available space",
>  	"on the device 'devid'.",
>  	"[kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.",
> @@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
>  	NULL
>  };
>  
> -static int check_resize_args(const char *amount, const char *path) {
> +static int check_resize_args(char * const amount, const char *path)
> +{
>  	struct btrfs_ioctl_fs_info_args fi_args;
>  	struct btrfs_ioctl_dev_info_args *di_args = NULL;
>  	int ret, i, dev_idx = -1;
> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount, const char *path) {
>  	}
>  
>  	ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
> +check:
>  	if (strlen(amount) != ret) {
>  		error("newsize argument is too long");
>  		ret = 1;
>  		goto out;
>  	}
> +	if (strcmp(amount, amount_dup) != 0)
> +		strcpy(amount, amount_dup);
>  
>  	sizestr = amount_dup;
>  	devstr = strchr(sizestr, ':');
> @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount, const char *path) {
>  			ret = 1;
>  			goto out;
>  		}
> +	} else if (fi_args.num_devices != 1) {
> +		error("The file system has multiple devices, please specify devid exactly.");
> +		error("The device information list is as follows.");
> +		for (i = 0; i < fi_args.num_devices; i++) {
> +			fprintf(stderr, "\tdevid %4llu size %s used %s path %s\n",
> +				di_args[i].devid,
> +				pretty_size_mode(di_args[i].total_bytes, UNITS_DEFAULT),
> +				pretty_size_mode(di_args[i].bytes_used, UNITS_DEFAULT),
> +				di_args[i].path);
> +		}
> +		ret = 1;
> +		goto out;
> +	} else {
> +		memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> +		ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[0].devid);
> +		ret = snprintf(amount_dup + strlen(amount_dup),
> +			BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
> +		goto check;
>  	}
>  
>  	dev_idx = -1;
> @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amount, const char *path) {
>  		di_args[dev_idx].path,
>  		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
>  		res_str);
> +	ret = 0;
>  
>  out:
>  	free(di_args);
> -	return 0;
> +	return ret;
>  }
>  
>  static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> @@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  	int	fd, res, len, e;
>  	char	*amount, *path;
>  	DIR	*dirstream = NULL;
> -	int ret;
> +	int ret = 0;
>  	bool enqueue = false;
>  	bool cancel = false;
>  
> @@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  		}
>  	}
>  
> +	amount = (char *)malloc(BTRFS_VOL_NAME_MAX);

If the buffer is short-lived an the same function you can use a stack
variable for that, no need for malloc.

> +	if (!amount)
> +		return -ENOMEM;
> +
> +	strcpy(amount, argv[optind]);

Please use safe variant of strcpy that checks bounds of the target
buffer.
