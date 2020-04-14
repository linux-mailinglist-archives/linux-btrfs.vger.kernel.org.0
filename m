Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA81A8E21
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407790AbgDNV7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 17:59:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbgDNV7n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 17:59:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABDADAC24;
        Tue, 14 Apr 2020 21:59:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8CB2BDA823; Tue, 14 Apr 2020 23:59:01 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:59:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2 1/2] btrfs-progs: Move resize into functionaly into
 utils.c
Message-ID: <20200414215901.GY5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200320033227.3721-1-marcos@mpdesouza.com>
 <20200320033227.3721-2-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320033227.3721-2-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 12:32:26AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This function will be used in the next patch to auto resize the
> filesystem when a bigger disk is added.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  cmds/filesystem.c | 58 ++-------------------------------------------
>  common/utils.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>  common/utils.h    |  1 +
>  3 files changed, 63 insertions(+), 56 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089a..9d31f236 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1074,11 +1074,7 @@ static const char * const cmd_filesystem_resize_usage[] = {
>  static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  				 int argc, char **argv)
>  {
> -	struct btrfs_ioctl_vol_args	args;
> -	int	fd, res, len, e;
> -	char	*amount, *path;
> -	DIR	*dirstream = NULL;
> -	struct stat st;
> +	char *amount, *path;
>  
>  	clean_args_no_options_relaxed(cmd, argc, argv);
>  
> @@ -1088,57 +1084,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  	amount = argv[optind];
>  	path = argv[optind + 1];
>  
> -	len = strlen(amount);
> -	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
> -		error("resize value too long (%s)", amount);
> -		return 1;
> -	}
> -
> -	res = stat(path, &st);
> -	if (res < 0) {
> -		error("resize: cannot stat %s: %m", path);
> -		return 1;
> -	}
> -	if (!S_ISDIR(st.st_mode)) {
> -		error("resize works on mounted filesystems and accepts only\n"
> -			"directories as argument. Passing file containing a btrfs image\n"
> -			"would resize the underlying filesystem instead of the image.\n");
> -		return 1;
> -	}
> -
> -	fd = btrfs_open_dir(path, &dirstream, 1);
> -	if (fd < 0)
> -		return 1;
> -
> -	printf("Resize '%s' of '%s'\n", path, amount);
> -	memset(&args, 0, sizeof(args));
> -	strncpy_null(args.name, amount);
> -	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
> -	e = errno;
> -	close_file_or_dir(fd, dirstream);
> -	if( res < 0 ){
> -		switch (e) {
> -		case EFBIG:
> -			error("unable to resize '%s': no enough free space",
> -				path);
> -			break;
> -		default:
> -			error("unable to resize '%s': %m", path);
> -			break;
> -		}
> -		return 1;
> -	} else if (res > 0) {
> -		const char *err_str = btrfs_err_str(res);
> -
> -		if (err_str) {
> -			error("resizing of '%s' failed: %s", path, err_str);
> -		} else {
> -			error("resizing of '%s' failed: unknown error %d",
> -				path, res);
> -		}
> -		return 1;
> -	}
> -	return 0;
> +	return resize_filesystem(amount, path);
>  }
>  static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>  
> diff --git a/common/utils.c b/common/utils.c
> index 4ce36836..dddf0a6f 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -461,6 +461,66 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
>  	return snprintf(str, str_size, "%.2f%s", fraction, suffix[num_divs]);
>  }
>  
> +int resize_filesystem(const char *amount, const char *path)
> +{
> +	struct btrfs_ioctl_vol_args	args;
> +	int	fd, res, len, e;
> +	DIR	*dirstream = NULL;

Please fix the code formatting in code that's being moved

> +	struct stat st;
> +
> +	len = strlen(amount);
> +	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
> +		error("resize value too long (%s)", amount);
> +		return 1;
> +	}
> +
> +	res = stat(path, &st);
> +	if (res < 0) {
> +		error("resize: cannot stat %s: %m", path);
> +		return 1;
> +	}
> +	if (!S_ISDIR(st.st_mode)) {
> +		error("resize works on mounted filesystems and accepts only\n"
> +			"directories as argument. Passing file containing a btrfs image\n"
> +			"would resize the underlying filesystem instead of the image.\n");
> +		return 1;
> +	}
> +
> +	fd = btrfs_open_dir(path, &dirstream, 1);
> +	if (fd < 0)
> +		return 1;
> +
> +	printf("Resize '%s' of '%s'\n", path, amount);
> +	memset(&args, 0, sizeof(args));
> +	strncpy_null(args.name, amount);
> +	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
> +	e = errno;
> +	close_file_or_dir(fd, dirstream);
> +	if( res < 0 ){
> +		switch (e) {
> +		case EFBIG:
> +			error("unable to resize '%s': no enough free space",
> +				path);
> +			break;
> +		default:
> +			error("unable to resize '%s': %m", path);
> +			break;
> +		}
> +		return 1;
> +	} else if (res > 0) {
> +		const char *err_str = btrfs_err_str(res);
> +
> +		if (err_str) {
> +			error("resizing of '%s' failed: %s", path, err_str);
> +		} else {
> +			error("resizing of '%s' failed: unknown error %d",
> +				path, res);
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Checks to make sure that the label matches our requirements.
>   * Returns:
> diff --git a/common/utils.h b/common/utils.h
> index 5c1afda9..8609d3c9 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -62,6 +62,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
>  		struct btrfs_fs_devices **fs_devices_mnt, unsigned sbflags);
>  
>  int pretty_size_snprintf(u64 size, char *str, size_t str_bytes, unsigned unit_mode);
> +int resize_filesystem(const char *amount, const char *path);

This is a bad placement of the prototype, in the middle of functions
that pretty print values. The file utils.h is historically unsorted but
new code should make the things better when possible.

>  #define pretty_size(size) 	pretty_size_mode(size, UNITS_DEFAULT)
>  const char *pretty_size_mode(u64 size, unsigned mode);
>  
> -- 
> 2.25.0
