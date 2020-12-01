Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8C2CAA82
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 19:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbgLASHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 13:07:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404232AbgLASHc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Dec 2020 13:07:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87233AC2F;
        Tue,  1 Dec 2020 18:06:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EA3FDA7D2; Tue,  1 Dec 2020 19:05:18 +0100 (CET)
Date:   Tue, 1 Dec 2020 19:05:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: filesystem usage: add avail info from
 statfs()
Message-ID: <20201201180518.GP6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201110005221.9323-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110005221.9323-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 10, 2020 at 12:52:21AM +0000, Sidong Yang wrote:
> dd available space information from statfs(). This can be different from
> 'Free (estimated)' in some cases. This patch provide more information
> about filesystem usage like below. and update document for this.
> 
> Overall:
>     Device size:                   5.00GiB
>     Device allocated:              1.02GiB
>     Device unallocated:            3.98GiB
>     Device missing:                  0.00B
>     Used:                         88.00KiB
>     Free (estimated):              4.48GiB      (min: 2.49GiB)
>     Avail:                         4.48GiB

My idea was to print

      Free (statfs, df):		...

'Avail' without context is useless.

>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              832.00KiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Issue: #306
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  Documentation/btrfs-filesystem.asciidoc |  3 +++
>  cmds/filesystem-usage.c                 | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/btrfs-filesystem.asciidoc b/Documentation/btrfs-filesystem.asciidoc
> index 6a5561ed..18623afe 100644
> --- a/Documentation/btrfs-filesystem.asciidoc
> +++ b/Documentation/btrfs-filesystem.asciidoc
> @@ -276,6 +276,7 @@ Overall:
>      Device missing:                  0.00B
>      Used:                          1.14TiB
>      Free (estimated):            692.57GiB      (min: 692.57GiB)
> +    Avail:                       692.57GiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)
> @@ -295,6 +296,8 @@ including the reserved space
>  data, including currently allocated space and estimating the usage of the
>  unallocated space based on the block group profiles, the 'min' is the lower bound
>  of the estimate in case multiple profiles are present
> +* 'Avail' -- the amount of space available for data. it's get by statfs() system
> +call that can be different from 'Free (estimated)' in some cases
>  * 'Data ratio' -- ratio of total space for data including redundancy or parity to
>  the effectively usable data space, eg. single is 1.0, RAID1 is 2.0 and for RAID5/6
>  it depends on the number of devices
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index ab60d769..ed743a61 100644
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
> @@ -556,6 +558,12 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
>  	if (unit_mode != UNITS_HUMAN)
>  		width = 18;
>  
> +	ret = statfs(path, &statfs_buf);
> +	if (ret) {
> +		warning("cannot get space info with statfs() on '%s': %m", path);
> +		ret = 0;
> +	}

Yeah, that's better than hard failure.

With the text updated, patch added to devel, thanks.
