Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC835B455
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhDKMoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 08:44:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52882 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbhDKMoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 08:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618145047; x=1649681047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0AF7WAf/4K7cQzNqELfk+oDOGBbLZovCSbYyHMO7hF8=;
  b=nM8VxlZdNqoGsVQNWrqHbWSGK3pN7BdUBg4DHNl01VM5XQVqNQt3mVWC
   2j4ghnwqdWY+4aPO0Ic4mIkhNzcgp9U19GwiAZc1QhXYqv7hqQLXGZcm6
   1IqCoBlCYH3oqHO06XguIg0B2hAvbixw4JN86YiTSpqYgzXMqU8oF4JPK
   suYU0QQmGYDvTVnUy3M9paEe5XP/530JLZ+fs93T2Xde4VgfY673ksu3x
   MUkvk7dLEt7qm6ba1FPool0Sh1jlKmPeO/OmxgaS9t4t+IdjnM1JzOO8w
   q6/Oh9iwm2OqiSzx2YY2kWX0H9FmZPJg34VRqvLXDYXJ4j0K/P803NCtO
   Q==;
IronPort-SDR: oA1ilyjN2NjDGFnlsZEJe0jJyT9QRpU4cFh8ulDEwOpjbyoRabWh9Dj15Ol1b9Jd8INaQVhg+B
 zMEvvXAcw3JCH8LvZHDynZloOvFqovifHRhEz49oVnr8k0mjOojLjBcHXDaJBhb7g68RQxovP/
 JqXzWPefDMdMp07/mmtmPV8KI+092TwMiIyH2Df1KEzPyUMYuExRxI2xxal7xAiwMcvc7Qy/Ur
 4FLCpHQYsQVRY7ZcIDGBMTHlodMuiaV/99hhmiHIq+Gdi+bTUEWwDubBliwm4aY+B/xmC0weZY
 nZM=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="268681690"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 20:43:58 +0800
IronPort-SDR: 13RCEueoeraAEx02JjZ+0051FiUMZvBqP8ST4rAlSjEodQ6M61eZoRs+ndE07GQX42Y1P5JmCu
 nDnPwgEqou7h4BAB/zo35nJpiLGTxR9mjSQaPCmKYDfqja379So4b/IlPrdLP4okauAPrLxgx8
 TJYLSLItPKDyB6m+sNkORfccbDKHroV6qXGeUW8nYfuaerfu/hW835XKmvJ8XYPz+OQPhFRGhK
 yZZDl28xmyiTAg7BKsKrzjxugcowfTNhq7USssVQt7vBRCT5VWlQr9OsfTcAoFitdDARZEpU2d
 2J4/Uy3zwD2YhRdcRSq78heW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 05:23:15 -0700
IronPort-SDR: b4aeZsyMklSQsdi/1JkDUyeDPOEo6MVB7TWU6W1026/Wp6ShwOmQjnbmKk9okRfucFP2eqN55v
 lIbUXLSUgSVTSKmABuNukS+TvZBv2g2fRrRVqZKQbwhtdbtt0tUI75OreL9yk9myPEVbTOd0N5
 NF0eLJ3gtvTf/h+VFv5S30efqnFovJB54kCZ4R/ybNYLc2SwgymMCVOMv4pI6mB6mCk6HbGGil
 2qSBn4K+Lg5mGNGESdIgx7MKyYHKTRuYawlrR7RmG+V2g294J2AwLa7L7emmE6rAkhB/XOETv0
 PdI=
WDCIronportException: Internal
Received: from jg8bqq2.ad.shared (HELO naota-xeon) ([10.225.52.36])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 05:43:42 -0700
Date:   Sun, 11 Apr 2021 21:43:40 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Johannes.Thumshirn@wdc.com, Damien.LeMoal@wdc.com
Subject: Re: [PATCH v3] btrfs: zoned: move superblock logging zone location
Message-ID: <20210411124340.27ias7tbraonlwd7@naota-xeon>
References: <20210410101223.30303-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410101223.30303-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 12:12:23PM +0200, David Sterba wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> Moves the location of the superblock logging zones. The new locations of
> the logging zones are now determined based on fixed block addresses
> instead of on fixed zone numbers.
> 
> The old placement method based on fixed zone numbers causes problems when
> one needs to inspect a file system image without access to the drive zone
> information. In such case, the super block locations cannot be reliably
> determined as the zone size is unknown. By locating the superblock logging
> zones using fixed addresses, we can scan a dumped file system image without
> the zone information since a super block copy will always be present at or
> after the fixed known locations.
> 
> Introduce the following three pairs of zones containing fixed offset
> locations, regardless of the device zone size.
> 
>   - primary superblock: offset   0B (and the following zone)
>   - first copy:         offset 512G (and the following zone)
>   - Second copy:        offset   4T (4096G, and the following zone)
> 
> If a logging zone is outside of the disk capacity, we do not record the
> superblock copy.
> 
> The first copy position is much larger than for a non-zoned filesystem,
> which is at 64M.  This is to avoid overlapping with the log zones for
> the primary superblock. This higher location is arbitrary but allows
> supporting devices with very large zone sizes, plus some space around in
> between.
> 
> Such large zone size is unrealistic and very unlikely to ever be seen in
> real devices. Currently, SMR disks have a zone size of 256MB, and we are
> expecting ZNS drives to be in the 1-4GB range, so this limit gives us
> room to breathe. For now, we only allow zone sizes up to 8GB. The
> maximum zone size that would still fit in the space is 256G.
> 
> The fixed location addresses are somewhat arbitrary, with the intent of
> maintaining superblock reliability for smaller and larger devices, with
> the preference for the latter. For this reason, there are two superblocks
> under the first 1T. This should cover use cases for physical devices and
> for emulated/device-mapper devices.
> 
> The superblock logging zones are reserved for superblock logging and
> never used for data or metadata blocks. Note that we only reserve the
> two zones per primary/copy actually used for superblock logging. We do
> not reserve the ranges of zones possibly containing superblocks with the
> largest supported zone size (0-16GB, 512G-528GB, 4096G-4112G).
> 
> The zones containing the fixed location offsets used to store
> superblocks on a non-zoned volume are also reserved to avoid confusion.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> For context see replies under
> https://lore.kernel.org/linux-btrfs/2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com/
> 
>  fs/btrfs/zoned.c | 53 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1f972b75a9ab..eeb3ebe11d7a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -21,9 +21,30 @@
>  /* Pseudo write pointer value for conventional zone */
>  #define WP_CONVENTIONAL ((u64)-2)
>  
> +/*
> + * Location of the first zone of superblock logging zone pairs.
> + *
> + * - primary superblock:    0B (zone 0)
> + * - first copy:          512G (zone starting at that offset)
> + * - second copy:           4T (zone starting at that offset)
> + */
> +#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
> +#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
> +#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
> +
> +#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
> +#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
> +
>  /* Number of superblock log zones */
>  #define BTRFS_NR_SB_LOG_ZONES 2
>  
> +/*
> + * Maximum supported zone size. Currently, SMR disks have a zone size of
> + * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
> + * expect the zone size to become larger than 8GiB in the near future.
> + */
> +#define BTRFS_MAX_ZONE_SIZE		SZ_8G
> +
>  static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
>  {
>  	struct blk_zone *zones = data;
> @@ -111,23 +132,22 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  }
>  
>  /*
> - * The following zones are reserved as the circular buffer on ZONED btrfs.
> - *  - The primary superblock: zones 0 and 1
> - *  - The first copy: zones 16 and 17
> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> - *                     the following one
> + * Get the first zone number of the superblock mirror
>   */
>  static inline u32 sb_zone_number(int shift, int mirror)
>  {
> -	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
> +	u64 zone;
>  
> +	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
>  	switch (mirror) {
> -	case 0: return 0;
> -	case 1: return 16;
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> +	case 0: zone = 0; break;
> +	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> +	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
>  	}
>  
> -	return 0;
> +	ASSERT(zone <= U32_MAX);
> +
> +	return (u32)zone;
>  }
>  
>  /*
> @@ -300,10 +320,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  		zone_sectors = bdev_zone_sectors(bdev);
>  	}
>  
> -	nr_sectors = bdev_nr_sectors(bdev);
>  	/* Check if it's power of 2 (see is_power_of_2) */
>  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
>  	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> +
> +	/* We reject devices with a zone size larger than 8GB */
> +	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
> +		btrfs_err_in_rcu(fs_info,
> +		"zoned: %s: zone size %llu larger than supported maximum %llu",
> +				 rcu_str_deref(device->name),
> +				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	nr_sectors = bdev_nr_sectors(bdev);
>  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>  	zone_info->max_zone_append_size =
>  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
> -- 
> 2.29.2
> 

Thanks for updating/fixing the patch. Looks good to me.
