Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043E4359CB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhDILJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 07:09:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhDILJq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Apr 2021 07:09:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D02A4B2EC;
        Fri,  9 Apr 2021 11:09:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6C47DA732; Fri,  9 Apr 2021 13:07:19 +0200 (CEST)
Date:   Fri, 9 Apr 2021 13:07:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: zoned: move superblock logging zone location
Message-ID: <20210409110719.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 05:25:28PM +0900, Naohiro Aota wrote:
> This commit moves the location of the superblock logging zones. The new
> locations of the logging zones are now determined based on fixed block
> addresses instead of on fixed zone numbers.
> 
> The old placement method based on fixed zone numbers causes problems when
> one needs to inspect a file system image without access to the drive zone
> information. In such case, the super block locations cannot be reliably
> determined as the zone size is unknown. By locating the superblock logging
> zones using fixed addresses, we can scan a dumped file system image without
> the zone information since a super block copy will always be present at or
> after the fixed location.
> 
> This commit introduces the following three pairs of zones containing fixed
> offset locations, regardless of the device zone size.
> 
>   - Primary superblock: zone starting at offset 0 and the following zone
>   - First copy: zone containing offset 64GB and the following zone
>   - Second copy: zone containing offset 256GB and the following zone
> 
> If a logging zone is outside of the disk capacity, we do not record the
> superblock copy.
> 
> The first copy position is much larger than for a regular btrfs volume
> (64M).  This increase is to avoid overlapping with the log zones for the
> primary superblock. This higher location is arbitrary but allows supporting
> devices with very large zone sizes, up to 32GB. Such large zone size is
> unrealistic and very unlikely to ever be seen in real devices. Currently,
> SMR disks have a zone size of 256MB, and we are expecting ZNS drives to be
> in the 1-4GB range, so this 32GB limit gives us room to breathe. For now,
> we only allow zone sizes up to 8GB, below this hard limit of 32GB.
> 
> The fixed location addresses are somewhat arbitrary, but with the intent of
> maintaining superblock reliability even for smaller devices. For this
> reason, the superblock fixed locations do not exceed 1TB.

Yeah, so how much should we adjust the offsets in favor of smaller
devices instead of larger ones? I think this is going the wrong
direction, the capacity will grow, the zones are supposed to be larger.

> The superblock logging zones are reserved for superblock logging and never
> used for data or metadata blocks. Note that we only reserve the two zones
> per primary/copy actually used for superblock logging. We do not reserve
> the ranges of zones possibly containing superblocks with the largest
> supported zone size (0-16GB, 64G-80GB, 256G-272GB).
> 
> The zones containing the fixed location offsets used to store superblocks
> in a regular btrfs volume (no zoned case) are also reserved to avoid
> confusion.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1f972b75a9ab..a4b195fe08a0 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -21,9 +21,28 @@
>  /* Pseudo write pointer value for conventional zone */
>  #define WP_CONVENTIONAL ((u64)-2)
>  
> +/*
> + * Location of the first zone of superblock logging zone pairs.
> + * - Primary superblock: the zone containing offset 0 (zone 0)
> + * - First superblock copy: the zone containing offset 64G
> + * - Second superblock copy: the zone containing offset 256G
> + */
> +#define BTRFS_PRIMARY_SB_LOG_ZONE 0ULL
> +#define BTRFS_FIRST_SB_LOG_ZONE (64ULL * SZ_1G)
> +#define BTRFS_SECOND_SB_LOG_ZONE (256ULL * SZ_1G)
> +#define BTRFS_FIRST_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_FIRST_SB_LOG_ZONE)
> +#define BTRFS_SECOND_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_SECOND_SB_LOG_ZONE)

This should be named like BTRFS_SB_LOG_* ie. "namespaces" or common
prefixes for the same class of valuesd.

> +
>  /* Number of superblock log zones */
>  #define BTRFS_NR_SB_LOG_ZONES 2
>  
> +/*
> + * Maximum size of zones. Currently, SMR disks have a zone size of 256MB,
> + * and we are expecting ZNS drives to be in the 1-4GB range. We do not
> + * expect the zone size to become larger than 8GB in the near future.
> + */
> +#define BTRFS_MAX_ZONE_SIZE SZ_8G
> +
>  static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
>  {
>  	struct blk_zone *zones = data;
> @@ -111,11 +130,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  }
>  
>  /*
> - * The following zones are reserved as the circular buffer on ZONED btrfs.
> - *  - The primary superblock: zones 0 and 1
> - *  - The first copy: zones 16 and 17
> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> - *                     the following one
> + * Get the zone number of the first zone of a pair of contiguous zones used
> + * for superblock logging.
>   */
>  static inline u32 sb_zone_number(int shift, int mirror)
>  {
> @@ -123,8 +139,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  
>  	switch (mirror) {
>  	case 0: return 0;
> -	case 1: return 16;
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> +	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);
> +	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);
>  	}
>  
>  	return 0;
> @@ -300,10 +316,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  		zone_sectors = bdev_zone_sectors(bdev);
>  	}
>  
> -	nr_sectors = bdev_nr_sectors(bdev);
>  	/* Check if it's power of 2 (see is_power_of_2) */
>  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
>  	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> +
> +	/* We reject devices with a zone size larger than 8GB. */
> +	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
> +		btrfs_err_in_rcu(fs_info,
> +				 "zoned: %s: zone size %llu is too large",
> +				 rcu_str_deref(device->name),
> +				 zone_info->zone_size);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	nr_sectors = bdev_nr_sectors(bdev);
>  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>  	zone_info->max_zone_append_size =
>  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
> -- 
> 2.31.1
