Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2E2C72E7
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Nov 2020 23:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbgK1VuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Nov 2020 16:50:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgK0TwB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 14:52:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37E66AD1E;
        Fri, 27 Nov 2020 19:51:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25CACDA7D9; Fri, 27 Nov 2020 20:49:55 +0100 (CET)
Date:   Fri, 27 Nov 2020 20:49:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: remove unused variable
Message-ID: <20201127194954.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zou Wei <zou_wei@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1605606463-78936-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1605606463-78936-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 17, 2020 at 05:47:43PM +0800, Zou Wei wrote:
> Fix variable set but not used compilation warnings:
> 
> fs/btrfs/ctree.c:1581:6: warning: variable ‘parent_level’ set but not used [-Wunused-but-set-variable]
>   int parent_level;
>       ^~~~~~~~~~~~
> 
> fs/btrfs/zoned.c:503:6: warning: variable ‘zone_size’ set but not used [-Wunused-but-set-variable]
>   u64 zone_size;
>       ^~~~~~~~~
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

> ---
>  fs/btrfs/ctree.c | 3 ---
>  fs/btrfs/zoned.c | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 32a57a7..e5a0941 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1578,13 +1578,10 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
>  	int end_slot;
>  	int i;
>  	int err = 0;
> -	int parent_level;
>  	u32 blocksize;
>  	int progress_passed = 0;
>  	struct btrfs_disk_key disk_key;
>  
> -	parent_level = btrfs_header_level(parent);

That one folded to the patch, thanks.

> -
>  	WARN_ON(trans->transaction != fs_info->running_transaction);
>  	WARN_ON(trans->transid != fs_info->generation);
>  
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fa9cc61..742f088 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -500,7 +500,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
>  	unsigned int zone_sectors;
>  	u32 sb_zone;
>  	int ret;
> -	u64 zone_size;
>  	u8 zone_sectors_shift;
>  	sector_t nr_sectors = bdev->bd_part->nr_sects;
>  	u32 nr_zones;
> @@ -515,7 +514,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
>  	zone_sectors = bdev_zone_sectors(bdev);
>  	if (!is_power_of_2(zone_sectors))
>  		return -EINVAL;
> -	zone_size = zone_sectors << SECTOR_SHIFT;

That was intended to be used a few lines below, so that's not for
removal.

>  	zone_sectors_shift = ilog2(zone_sectors);
>  	nr_zones = nr_sectors >> zone_sectors_shift;
>  
> -- 
> 2.6.2
