Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85CA2F6F24
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 00:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbhANXve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 18:51:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:41516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731052AbhANXve (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 18:51:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5E90AC5B;
        Thu, 14 Jan 2021 23:50:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3612DDA7EE; Fri, 15 Jan 2021 00:48:59 +0100 (CET)
Date:   Fri, 15 Jan 2021 00:48:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: filesystem-resize: make output more readable
Message-ID: <20210114234859.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201216034240.2029-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216034240.2029-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 03:42:40AM +0000, Sidong Yang wrote:
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
>  cmds/filesystem.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index fac612b2..53e775b7 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1084,6 +1084,14 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  	int ret;
>  	struct stat st;
>  	bool enqueue = false;
> +	struct btrfs_ioctl_fs_info_args fi_args;
> +	struct btrfs_ioctl_dev_info_args *di_args = NULL;
> +	char newsize[256];
> +	char sign;
> +	u64 inc_bytes;
> +	u64 res_bytes;
> +	int i, devid, dev_idx;
> +	const char *res_str;
>  
>  	optind = 0;
>  	while (1) {
> @@ -1142,7 +1150,58 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>  		return 1;
>  	}
>  
> -	printf("Resize '%s' of '%s'\n", path, amount);
> +	ret = get_fs_info(path, &fi_args, &di_args);
> +	if (ret)
> +		error("unable to retrieve fs info");

The helper 'error' is to just print the message so the code has to
change flow to an exit otherwise it would continue, which is what we
don't want here.

> +
> +	if (!fi_args.num_devices)
> +		error("num_devices = 0");

Same and everywhere below. Also the error message is too cryptic, think
that there's a human reading that so it should say what's the error,
like "No devices found". Which would be a weird and likely impossible
error anyway but it's good that it's handled.

> +
> +	ret = sscanf(amount, "%d:%255s", &devid, newsize);
> +
> +	if (ret != 2)
> +		error("invalid format");

I'm not sure this covers all the possibilities the resize format
provides. The "%d:" part is not mandatory and there doesn't need to be
":" at all, eg when it's "max" or any number.

There are some examples in manual page of btrfs-filesystem so would be
good if we have at least that covered by tests.
