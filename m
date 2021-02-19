Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13BE31FA14
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBSNrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 08:47:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhBSNq6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 08:46:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1249DAC6E;
        Fri, 19 Feb 2021 13:46:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0F2CDA813; Fri, 19 Feb 2021 14:44:19 +0100 (CET)
Date:   Fri, 19 Feb 2021 14:44:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: filesystem-resize: make output more
 readable
Message-ID: <20210219134419.GA1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210123153720.4294-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123153720.4294-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 03:37:20PM +0000, Sidong Yang wrote:
> This patch make output of filesystem-resize command more readable and
> give detail information for users. This patch provides more information
> about filesystem like below.
> 
> Before:
> Resize '/mnt' of '1:-1G'
> 
> After:
> Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>   - print more detailed error
>   - covers all the possibilities format provides
> ---
>  cmds/filesystem.c | 112 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index ba2e5928..cec3f380 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -28,6 +28,7 @@
>  #include <linux/limits.h>
>  #include <linux/version.h>
>  #include <getopt.h>
> +#include <limits.h>
>  
>  #include <btrfsutil.h>
>  
> @@ -1074,6 +1075,109 @@ static const char * const cmd_filesystem_resize_usage[] = {
>  	NULL
>  };
>  
> +static int check_resize_args(const char *amount, const char *path) {
> +	struct btrfs_ioctl_fs_info_args fi_args;
> +	struct btrfs_ioctl_dev_info_args *di_args = NULL;
> +	int ret, i, devid = 0, dev_idx = -1;

devid should be u64

> +	const char *res_str = NULL;
> +	char *devstr = NULL, *sizestr = NULL;
> +	u64 new_size = 0, old_size = 0;
> +	int mod = 0;
> +	char amount_dup[BTRFS_VOL_NAME_MAX];

Bffer of a fixed size ...

> +
> +	ret = get_fs_info(path, &fi_args, &di_args);
> +
> +	if (ret) {
> +		error("unable to retrieve fs info");
> +		return 1;
> +	}
> +
> +	if (!fi_args.num_devices) {
> +		error("no devices found");
> +		free(di_args);
> +		return 1;
> +	}
> +
> +	strcpy(amount_dup, amount);

... and strcpy from a user specified buffer, this is from chapter 1 of
how buffer overflows in C work. Please use safe string copy.

> +	devstr = strchr(amount_dup, ':');
> +	if (devstr) {
> +		sizestr = devstr + 1;
> +		*devstr = '\0';
> +		devstr = amount_dup;
> +
> +		errno = 0;
> +		devid = strtoull(devstr, NULL, 10);
> +
> +		if (errno) {
> +			error("failed to parse devid %s", devstr);
> +			free(di_args);
> +			return 1;
> +		}
> +	}
> +
> +	dev_idx = -1;
> +	for(i = 0; i < fi_args.num_devices; i++) {
> +		if (di_args[i].devid == devid) {
> +			dev_idx = i;
> +			break;
> +		}
> +	}
> +
> +	if (dev_idx < 0) {
> +		error("cannot find devid : %d", devid);
> +		free(di_args);
> +		return 1;
> +	}
> +
> +	if (!strcmp(sizestr, "max")) {
> +		res_str = "max";
> +	}
> +	else {
> +		if (sizestr[0] == '-') {
> +			mod = -1;
> +			sizestr++;
> +		} else if (sizestr[0] == '+') {
> +			mod = 1;
> +			sizestr++;
> +		}
> +		new_size = parse_size(sizestr);
> +		if (!new_size) {
> +			error("failed to parse size %s", sizestr);
> +			free(di_args);
> +			return 1;
> +		}
> +		old_size = di_args[dev_idx].total_bytes;
> +
> +		if (mod < 0) {
> +			if (new_size > old_size) {
> +				error("current size is %s which is smaller than %s",
> +				      pretty_size_mode(old_size, UNITS_DEFAULT),
> +				      pretty_size_mode(new_size, UNITS_DEFAULT));
> +				free(di_args);
> +				return 1;
> +			}
> +			new_size = old_size - new_size;
> +		} else if (mod > 0) {
> +			if (new_size > ULLONG_MAX - old_size) {
> +				error("increasing %s is out of range",
> +				      pretty_size_mode(new_size, UNITS_DEFAULT));
> +				free(di_args);
> +				return 1;
> +			}
> +			new_size = old_size + new_size;

This all got me confused, old_size and new_size sound like absolute
numbers for the size but new_size is in fact used as the delta, or the
relative change.

Otherwise looks good.

> +		}
> +		new_size = round_down(new_size, fi_args.sectorsize);
> +		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
> +	}
> +
> +	printf("Resize device id %d (%s) from %s to %s\n", devid, di_args[dev_idx].path,
> +		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
> +		res_str);
> +
> +	free(di_args);
> +	return 0;
> +}
> +
>  static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  				 int argc, char **argv)
>  {
> @@ -1139,7 +1243,13 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  		return 1;
>  	}
>  
> -	printf("Resize '%s' of '%s'\n", path, amount);
> +	ret = check_resize_args(path, amount);
> +	if (ret != 0) {
> +		close_file_or_dir(fd, dirstream);
> +		return 1;
> +	}
> +
> +
>  	memset(&args, 0, sizeof(args));
>  	strncpy_null(args.name, amount);
>  	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
> -- 
> 2.25.1
