Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF973F4EA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHWQpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 12:45:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhHWQpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 12:45:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A3ECC21FC6;
        Mon, 23 Aug 2021 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629737071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkzDlGAhhpFs9nIYCePmUUqGqOC2vbp7S/ymJmxEtNs=;
        b=NhMsPcoglpFfqcFmmU37y98GqKbvc15JRJ8bivciG4tvCPWa+8Z6v8joyXStFnGqdHWUbX
        UHmGTOYD+3uezCokclUQ2om0YOta/yzgmumoBdHf+kDYoDPMxXl5zIiyMYhLshzRsJud9x
        MHHcWrpupmOV4oDvivxyxvUC8X0TRgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629737071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkzDlGAhhpFs9nIYCePmUUqGqOC2vbp7S/ymJmxEtNs=;
        b=S/Edk+ycqD366ov0A/9c+9CNLC0TkZ78iRdA0wIMY5fd2p2qf5HRwItmUy7V6shont7BYS
        dteME/Qy/FW0XiBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9DBC6A3BBF;
        Mon, 23 Aug 2021 16:44:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE959DA725; Mon, 23 Aug 2021 18:41:31 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:41:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: introduce btrfs_subpage_bitmap_info
Message-ID: <20210823164130.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817093852.48126-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 05:38:51PM +0800, Qu Wenruo wrote:
> Currently we use fixed size u16 bitmap for subpage bitmap.
> This is fine for 4K sectorsize with 64K page size.
> 
> But for 4K sectorsize and larger page size, the bitmap is too small,
> while for smaller page size like 16K, u16 bitmaps waste too much space.
> 
> Here we introduce a new helper structure, btrfs_subpage_bitmap_info, to
> record the proper bitmap size, and where each bitmap should start at.
> 
> By this, we can later compact all subpage bitmaps into one u32 bitmap.
> 
> This patch is the first step towards such compact bitmap.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 12 +++++++++---
>  fs/btrfs/subpage.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f07c82fafa04..a5297748d719 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -899,6 +899,7 @@ struct btrfs_fs_info {
>  	struct btrfs_workqueue *scrub_workers;
>  	struct btrfs_workqueue *scrub_wr_completion_workers;
>  	struct btrfs_workqueue *scrub_parity_workers;
> +	struct btrfs_subpage_info *subpage_info;
>  
>  	struct btrfs_discard_ctl discard_ctl;
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2f9515dccce0..3355708919d0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1644,6 +1644,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_extent_buffer_leak_debug_check(fs_info);
>  	kfree(fs_info->super_copy);
>  	kfree(fs_info->super_for_commit);
> +	kfree(fs_info->subpage_info);
>  	kvfree(fs_info);
>  }
>  
> @@ -3392,12 +3393,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
>  
> -	if (sectorsize != PAGE_SIZE) {
> +	if (sectorsize < PAGE_SIZE) {
> +		struct btrfs_subpage_info *subpage_info;
> +
>  		btrfs_warn(fs_info,
>  		"read-write for sector size %u with page size %lu is experimental",
>  			   sectorsize, PAGE_SIZE);
> -	}
> -	if (sectorsize != PAGE_SIZE) {
>  		if (btrfs_super_incompat_flags(fs_info->super_copy) &
>  			BTRFS_FEATURE_INCOMPAT_RAID56) {
>  			btrfs_err(fs_info,
> @@ -3406,6 +3407,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  			err = -EINVAL;
>  			goto fail_alloc;
>  		}
> +		subpage_info = kzalloc(sizeof(*subpage_info), GFP_NOFS);
> +		if (!subpage_info)
> +			goto fail_alloc;
> +		btrfs_init_subpage_info(subpage_info, sectorsize);
> +		fs_info->subpage_info = subpage_info;
>  	}
>  
>  	ret = btrfs_init_workqueues(fs_info, fs_devices);
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index ae6c68370a95..c4fb2ce52207 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -63,6 +63,41 @@
>   *   This means a slightly higher tree locking latency.
>   */
>  
> +void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
> +			     u32 sectorsize)
> +{
> +	unsigned int cur = 0;
> +	unsigned int nr_bits;
> +
> +	/*
> +	 * Just in case we have super large PAGE_SIZE that unsigned int is not
> +	 * enough to contain the number of sectors for the minimal sectorsize.
> +	 */
> +	BUILD_BUG_ON(UINT_MAX * SZ_4K < PAGE_SIZE);

Do you seriously expect such hardware to exist? We know there are arches
with 256K page and that's perhaps the maximum we should care about now
but UINT_MAX * 4K is 16TiB, 2^44. CPUs are barely capable of addressing
2^40 physical address space, making assertions about page size orders of
magnitude larger than that is insane.
