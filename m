Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D90EC163
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 11:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfKAKwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 06:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbfKAKwJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 06:52:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72F24B28B;
        Fri,  1 Nov 2019 10:52:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A064DA783; Fri,  1 Nov 2019 11:52:16 +0100 (CET)
Date:   Fri, 1 Nov 2019 11:52:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Pernegger <pernegger@gmail.com>
Subject: Re: [PATCH] btrfs-progs: rescue-zero-log: Modify super block directly
Message-ID: <20191101105216.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Christian Pernegger <pernegger@gmail.com>
References: <20191026101127.36851-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026101127.36851-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 26, 2019 at 06:11:27PM +0800, Qu Wenruo wrote:
> +	/*
> +	 * Log tree only exists in the primary super block, so SBREAD_DEFAULT
> +	 * is enough.

For read it should be enough to read the default one, but do you mean
that 1st and 2nd copy don't have the log_root values set? They're
written from the same buffer so I'd expect the contents to be the same.

> +	ret = btrfs_read_dev_super(fd, sb, BTRFS_SUPER_INFO_OFFSET,
> +				   SBREAD_DEFAULT);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to read super block on '%s': %m", devname);
> +		goto close_fd;
>  	}
>  
> -	sb = root->fs_info->super_copy;
>  	printf("Clearing log on %s, previous log_root %llu, level %u\n",
>  			devname,
>  			(unsigned long long)btrfs_super_log_root(sb),
>  			(unsigned)btrfs_super_log_root_level(sb));
> -	trans = btrfs_start_transaction(root, 1);
> -	BUG_ON(IS_ERR(trans));
>  	btrfs_set_super_log_root(sb, 0);
>  	btrfs_set_super_log_root_level(sb, 0);
> -	btrfs_commit_transaction(trans, root);
> -	close_ctree(root);
> +	btrfs_csum_data(btrfs_super_csum_type(sb), (u8 *)sb + BTRFS_CSUM_SIZE,
> +			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> +	memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
> +	ret = pwrite64(fd, sb, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);

So this only writes on the one device that's passed to the command.
Previously it would update superblocks on all devices.
