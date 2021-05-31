Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E3396837
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEaTCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 15:02:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhEaTCq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 15:02:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622487666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXe0F9aDCM3LqDY9nvnpn9296ZmTlqTFajcwxWUsMX0=;
        b=2BHNLxAoiSaNsrtcRoxiQ2Ljs+epAg+HXHev6Dn3zY4FpqycYh1rabYVVTpU3Hu/wev+lq
        VwtkcGdM+PA4RGt+sjAR54utb4ewG2Ec9KNvjBDW3iii16+bQL4bbvc6/akTw9zyW7KdxS
        rfdJ+hu33lUT1V2lpJiE8/vpebpVG28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622487666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXe0F9aDCM3LqDY9nvnpn9296ZmTlqTFajcwxWUsMX0=;
        b=OSGDwKJiUMtLFpVei4p/HlwkwiqMsglX4/gCVJb5pvAab/fMGtkGxeuPQmvSA7KbEzM/R2
        MKFB/No6mz2qHFDQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00C07B50F;
        Mon, 31 May 2021 19:01:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46348DA72C; Mon, 31 May 2021 20:58:26 +0200 (CEST)
Date:   Mon, 31 May 2021 20:58:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Message-ID: <20210531185826.GF31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 06:11:04PM +0900, Johannes Thumshirn wrote:
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  				    u64 *end)
>  {
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
>  	u64 delalloc_start;
>  	u64 delalloc_end;
> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  	int ret;
>  	int loops = 0;
>  
> +	if (fs_info && fs_info->max_zone_append_size)

Do you really need to check for a valid fs_info? It's derived from an
inode so it must be valid or something is seriously wrong.

> +		max_bytes = ALIGN_DOWN(fs_info->max_zone_append_size,
> +				       PAGE_SIZE);

Right now the page alignment sounds ok because the delalloc code works
on page granularity. There's the implicit assumpption that data blocks
are page-sized, but the whole delalloc engine works on pages so no
reason to use anything else.
