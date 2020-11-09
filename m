Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637C32AC934
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 00:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIXSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 18:18:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:45830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgKIXSZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 18:18:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDB45AB95;
        Mon,  9 Nov 2020 23:18:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DC579DA7D7; Tue, 10 Nov 2020 00:16:42 +0100 (CET)
Date:   Tue, 10 Nov 2020 00:16:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: filesystem usage: add avail info from
 statfs()
Message-ID: <20201109231642.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201109145923.14167-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109145923.14167-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 09, 2020 at 02:59:23PM +0000, Sidong Yang wrote:
> Add available space information from statfs(). This can be different from
> 'Free (estimated)' in some cases. This patch provide more information about
> filesystem usage.
> 
> Issue: #306
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  cmds/filesystem-usage.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index ab60d769..c17e26c3 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -19,6 +19,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/ioctl.h>
> +#include <sys/vfs.h>
>  #include <errno.h>
>  #include <stdarg.h>
>  #include <getopt.h>
> @@ -430,6 +431,7 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
>  	u64 free_min = 0;
>  	double max_data_ratio = 1.0;
>  	int mixed = 0;
> +	struct statfs statfs_buf;
>  
>  	sargs = load_space_info(fd, path);
>  	if (!sargs) {
> @@ -556,6 +558,13 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
>  	if (unit_mode != UNITS_HUMAN)
>  		width = 18;
>  
> +	ret = statfs(path, &statfs_buf);
> +	if (ret) {
> +		error("cannot get space info with statfs() on '%s': %m", path);

I wonder when statfs would not work and I don't think it should be a
hard error, maybe a warning or some stub that says the information was
not available.

> +		ret = 1;
> +		goto exit;
> +	}
> +
>  	printf("Overall:\n");
>  
>  	printf("    Device size:\t\t%*s\n", width,
> @@ -572,6 +581,8 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
>  		width,
>  		pretty_size_mode(free_estimated, unit_mode));
>  	printf("min: %s)\n", pretty_size_mode(free_min, unit_mode));
> +	printf("    Avail:\t\t\t%*s\n", width,
> +		pretty_size_mode(statfs_buf.f_bavail * statfs_buf.f_bsize, unit_mode));

It's good to paste sample output of the command to the changelog to have
a second thought on how it actually looks. A simple 'Avail' is without
context and I as a user have no idea what it means or how to interpret
the value. Please try again.
