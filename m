Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F919332AC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCIPlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 10:41:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:35690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCIPkn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 10:40:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7633EAE84;
        Tue,  9 Mar 2021 15:40:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F01ADA7D7; Tue,  9 Mar 2021 16:38:44 +0100 (CET)
Date:   Tue, 9 Mar 2021 16:38:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Subject: Re: [PATCH v4] btrfs-progs: filesystem-resize: make output more
 readable
Message-ID: <20210309153844.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210220124117.11444-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220124117.11444-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 20, 2021 at 12:41:17PM +0000, Sidong Yang wrote:
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
> v3:
>   - use snprintf than strcpy for safety
>   - add diff variable for code readability
> v4:
>   - fix bugs for argument that has no devid
> ---
>  cmds/filesystem.c | 120 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 0d23daf4..7ddf5880 100644
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
> @@ -1074,6 +1075,117 @@ static const char * const cmd_filesystem_resize_usage[] = {
>  	NULL
>  };
>  
> +static int check_resize_args(const char *amount, const char *path) {
> +	struct btrfs_ioctl_fs_info_args fi_args;
> +	struct btrfs_ioctl_dev_info_args *di_args = NULL;
> +	int ret, i, dev_idx = -1;
> +	u64 devid = 1;
> +	const char *res_str = NULL;
> +	char *devstr = NULL, *sizestr = NULL;
> +	u64 new_size = 0, old_size = 0, diff = 0;
> +	int mod = 0;
> +	char amount_dup[BTRFS_VOL_NAME_MAX];
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

Btw I changed all the free/return to ret = 1/goto out pattern so the
cleanup does not need to repeated next to each return.
