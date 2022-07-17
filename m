Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DBE577780
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiGQRja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQRja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 13:39:30 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881AB7669
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 10:39:28 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id B99E543B0D0; Sun, 17 Jul 2022 13:39:27 -0400 (EDT)
Date:   Sun, 17 Jul 2022 13:39:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: resize: automatically add devid if device
 is not specifically
Message-ID: <YtRJT+J2W/Z4G/gS@hungrycats.org>
References: <1658070503-25238-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658070503-25238-1-git-send-email-zhanglikernel@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 17, 2022 at 11:08:23PM +0800, Li Zhang wrote:
> related issues:
> https://github.com/kdave/btrfs-progs/issues/470
> 
> [BUG]
> If there is no devid=1, when the user uses the btrfs file system tool, the following error will be reported,
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
> [CAUSE]
> If the user does not specify the devid id explicitly, btrfs will use the default devid 1, so it will report an error when dev 1 is missing.
> 
> [FIX]
> If there is no special devid, the first devid is added automatically and check the maximum length of args passed to kernel space.
> After patch, when resize filesystem without specified, it would resize the first device, the result is list as following.
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
>     Total devices 2 FS bytes used 144.00KiB
>     devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>     devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> 
> $ sudo btrfs filesystem resize -1G /mnt/1
> Resize device id 2 (/dev/loop2) from 15.00GiB to 14.00GiB
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
>     Total devices 2 FS bytes used 144.00KiB
>     devid    2 size 14.00GiB used 1.16GiB path /dev/loop2
>     devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

Is that desirable behavior?  I'd expect that if there are multiple
devices present, and I haven't specified which one to resize, that the
command would fail with an error, requiring me to specify which device I
want resized.  Under that expectation, the current behavior of resizing
devid 1 by default is also incorrect.

If there's only one device, then 'btrfs fi resize -1G' should resize
that device, since no ambiguity is possible.

> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  cmds/filesystem.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7cd08fc..2e2414d 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1087,7 +1087,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
>  	NULL
>  };
>  
> -static int check_resize_args(const char *amount, const char *path) {
> +static int check_resize_args(char * const amount, const char *path)
> +{
>  	struct btrfs_ioctl_fs_info_args fi_args;
>  	struct btrfs_ioctl_dev_info_args *di_args = NULL;
>  	int ret, i, dev_idx = -1;
> @@ -1102,7 +1103,8 @@ static int check_resize_args(const char *amount, const char *path) {
>  
>  	if (ret) {
>  		error("unable to retrieve fs info");
> -		return 1;
> +		ret = 1;
> +		goto out;
>  	}
>  
>  	if (!fi_args.num_devices) {
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
> @@ -1137,6 +1142,13 @@ static int check_resize_args(const char *amount, const char *path) {
>  
>  	dev_idx = -1;
>  	for(i = 0; i < fi_args.num_devices; i++) {
> +		if (!devstr) {
> +			memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> +			ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[i].devid);
> +			ret = snprintf(amount_dup + strlen(amount_dup),
> +				BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
> +			goto check;
> +		}
>  		if (di_args[i].devid == devid) {
>  			dev_idx = i;
>  			break;
> @@ -1235,8 +1247,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  		}
>  	}
>  
> -	if (check_argc_exact(argc - optind, 2))
> -		return 1;
> +	if (check_argc_exact(argc - optind, 2)) {
> +		ret = 1;
> +		goto out;
> +	}
>  
>  	amount = argv[optind];
>  	path = argv[optind + 1];
> @@ -1244,7 +1258,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  	len = strlen(amount);
>  	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
>  		error("resize value too long (%s)", amount);
> -		return 1;
> +		ret = 1;
> +		goto out;
>  	}
>  
>  	cancel = (strcmp("cancel", amount) == 0);
> @@ -1258,7 +1273,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  		"directories as argument. Passing file containing a btrfs image\n"
>  		"would resize the underlying filesystem instead of the image.\n");
>  		}
> -		return 1;
> +		ret = 1;
> +		goto out;
>  	}
>  
>  	/*
> @@ -1273,14 +1289,22 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  				error(
>  			"unable to check status of exclusive operation: %m");
>  			close_file_or_dir(fd, dirstream);
> -			return 1;
> +			goto out;
>  		}
>  	}
>  
> +	amount = (char *)malloc(BTRFS_VOL_NAME_MAX);
> +	if (!amount) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	strcpy(amount, argv[optind]);
> +
>  	ret = check_resize_args(amount, path);
>  	if (ret != 0) {
>  		close_file_or_dir(fd, dirstream);
> -		return 1;
> +		ret = 1;
> +		goto free_amount;
>  	}
>  
>  	memset(&args, 0, sizeof(args));
> @@ -1298,7 +1322,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  			error("unable to resize '%s': %m", path);
>  			break;
>  		}
> -		return 1;
> +		ret = 1;
>  	} else if (res > 0) {
>  		const char *err_str = btrfs_err_str(res);
>  
> @@ -1308,9 +1332,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  			error("resizing of '%s' failed: unknown error %d",
>  				path, res);
>  		}
> -		return 1;
> +		ret = 1;
>  	}
> -	return 0;
> +free_amount:
> +	free(amount);
> +out:
> +	return ret;
>  }
>  static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>  
> -- 
> 1.8.3.1
> 
