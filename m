Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7730AC04
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhBAPwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 10:52:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:54384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhBAPwN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 10:52:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90A34ACB7;
        Mon,  1 Feb 2021 15:51:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 196E4DA6FC; Mon,  1 Feb 2021 16:49:41 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:49:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 18/18] btrfs: allow RO mount of 4K sector size fs on
 64K page system
Message-ID: <20210201154940.GS1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-19-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083402.142577-19-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 04:34:02PM +0800, Qu Wenruo wrote:
> This adds the basic RO mount ability for 4K sector size on 64K page
> system.
> 
> Currently we only plan to support 4K and 64K page system.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/disk-io.c | 24 +++++++++++++++++++++---
>  fs/btrfs/super.c   |  7 +++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0b10577ad2bd..d74ee0a396ac 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2483,13 +2483,21 @@ static int validate_super(struct btrfs_fs_info *fs_info,
>  		btrfs_err(fs_info, "invalid sectorsize %llu", sectorsize);
>  		ret = -EINVAL;
>  	}
> -	/* Only PAGE SIZE is supported yet */
> -	if (sectorsize != PAGE_SIZE) {
> +
> +	/*
> +	 * For 4K page size, we only support 4K sector size.
> +	 * For 64K page size, we support RW for 64K sector size, and RO for
> +	 * 4K sector size.
> +	 */
> +	if ((SZ_4K == PAGE_SIZE && sectorsize != PAGE_SIZE) ||
> +	    (SZ_64K == PAGE_SIZE && (sectorsize != SZ_4K &&

I've switched the order here so it reads more naturally as PAGE_SIZE == SZ_...

> +				     sectorsize != SZ_64K))) {
>  		btrfs_err(fs_info,
> -			"sectorsize %llu not supported yet, only support %lu",
> +			"sectorsize %llu not supported yet for page size %lu",
>  			sectorsize, PAGE_SIZE);
>  		ret = -EINVAL;
>  	}
> +
>  	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
>  	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
>  		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
> @@ -3248,6 +3256,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
>  
> +	/* For 4K sector size support, it's only read-only yet */
> +	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
> +		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
> +			btrfs_err(fs_info,
> +				"subpage sector size only support RO yet");

Similar to the other message, I've added which sectorsize and page size
don't work.

And s/RO/read-only/. This is for clarity of the messages that are read
by users, while we can use the RO/RW in comments or changelogs.
