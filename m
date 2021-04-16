Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A677836275D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbhDPSBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 14:01:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243844AbhDPSBq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 14:01:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12687AE57;
        Fri, 16 Apr 2021 18:01:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DC10DA790; Fri, 16 Apr 2021 19:59:03 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:59:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <20210416175903.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210415053011.275099-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415053011.275099-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 01:30:11PM +0800, Qu Wenruo wrote:
> Currently mkfs.btrfs will output a warning message if the sectorsize is
> not the same as page size:
>   WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536
> 
> But since btrfs subpage support for 64K page size is comming, this
> output is populating the golden output of fstests, causing tons of false
> alerts.
> 
> This patch will make teach mkfs.btrfs to check
> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
> size is supported.
> 
> Then only output above warning message if the sector size is not
> supported.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/fsfeatures.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9e5b1..13b775da9c72 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -16,6 +16,8 @@
>  
>  #include "kerncompat.h"
>  #include <sys/utsname.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
>  #include <linux/version.h>
>  #include <unistd.h>
>  #include "common/fsfeatures.h"
> @@ -327,8 +329,15 @@ u32 get_running_kernel_version(void)
>  
>  	return version;
>  }
> +
> +/*
> + * The buffer size if strlen("4096 8192 16384 32768 65536"),
> + * which is 28, then round up to 32.
> + */
> +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
>  int btrfs_check_sectorsize(u32 sectorsize)
>  {
> +	bool sectorsize_checked = false;
>  	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
>  
>  	if (!is_power_of_2(sectorsize)) {
> @@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
>  		      sectorsize);
>  		return -EINVAL;
>  	}
> -	if (page_size != sectorsize)
> +	if (page_size == sectorsize) {
> +		sectorsize_checked = true;
> +	} else {
> +		/*
> +		 * Check if the sector size is supported
> +		 */
> +		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +		int fd;
> +		int ret;
> +
> +		fd = open("/sys/fs/btrfs/features/supported_sectorsizes",
> +			  O_RDONLY);
> +		if (fd < 0)
> +			goto out;
> +		ret = read(fd, supported_buf, sizeof(supported_buf));
> +		close(fd);

There are some sysfs helpers, like sysfs_read_file and
sysfs_open_fsid_file that would avoid the boilerplate code. We don't
have a helper for the toplevel sysfs directory so that would need to be
added first.

Now that I look at it, the sysfs_read_file could actually do that in one
go, including open and close. I'll probably do that as a cleanup later
and apply your patch as it's a fix. Thanks.
