Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9134B381921
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhEONmT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 09:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhEONmS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 09:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B797B05E;
        Sat, 15 May 2021 13:41:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7257DAEB9; Sat, 15 May 2021 15:38:33 +0200 (CEST)
Date:   Sat, 15 May 2021 15:38:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
Message-ID: <20210515133833.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515023624.8065-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 15, 2021 at 02:36:24AM +0000, Sidong Yang wrote:
> This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> the option is enabled, delete subvolume command destroies associated
> qgroup together. This patch make it as default option. Even though quota
> is disabled, it enables quota temporary and restore it after.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> 
> I wrote a patch that adds command to delete associated qgroup when
> delete subvolume together. It also works when quota disabled. How it
> works is enable quota temporary and restore it. I don't know it's good
> way. Is there any better way than this?

As Qu pointed out, nothing needs to be done in case quotas are not
enabled.

> +		if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> +			if (errno == ENOTCONN) {

Which turns this into
			if (errno !=  ENOTCONN
				error("...");

> +				struct btrfs_ioctl_quota_ctl_args quota_ctl_args;
> +				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_ENABLE;
> +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &quota_ctl_args) < 0) {
> +					error("unable to enable quota: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +
> +				if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> +					quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
> +					ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args);
> +					error("unable to destroy quota group: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +
> +				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
> +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args) < 0) {
> +					error("unable to disable quota: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +			} else {
> +				error("unable to destroy quota group: %s",
> +					  strerror(errno));

strerror(errno) should be replaced by %m in the format string

> +				goto out;
> +			}
> +		}
> +	}
> +
>  	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
>  		commit_mode == COMMIT_EACH ||
>  		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
> @@ -412,6 +462,7 @@ again:
>  		goto out;
>  	}
>  
> +

Extra newline

>  	if (commit_mode == COMMIT_EACH) {
>  		res = wait_for_commit(fd);
>  		if (res < 0) {
> -- 
> 2.25.1
