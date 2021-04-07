Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4718735739E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDGRxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDGRxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 13:53:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216DC06175F
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Apr 2021 10:53:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so14434397qtc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R5o7wWz93yK+COoa99JPhJmMHL2NOZNoRJHYZS6By7A=;
        b=SznhgHebGdAFFVBGWW4W7PbuDK6BlIJYq/Qm1ZXH92vj5h+d9lNKntp2ZWyPgsj87Q
         QF6iOa6f+wVnwWpgadj473uxhsp0r3BxB0yvmkJt/K9dxk1cuxVe/sDsWmcPglHrCrsd
         xgaBpvnQAeQo6UwMqHk203l/7wRt8dDyoXHtBqrFxiSsaB8vn3dPv30rJViVrK0Z0+xf
         1BYurHI7qy1ugXXRKz0aXlzQWOzFZPKHXO9mUh9HSpPENh4sQEli4i95eOsnWxLwondN
         70GWWSVh3oPk7MJyqGiwdBRm+kBv/yaVLffvZTpPpfWSBq91h+Lmhb4mFtZDRSIYrhjt
         bX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5o7wWz93yK+COoa99JPhJmMHL2NOZNoRJHYZS6By7A=;
        b=DcS/q+7T3G3vrnvJpb+Z1wSv+lPn+KhhBviux/WnUWqbRtwvCIYzhR5rNRJL1gypCg
         1vYTiGJOy992R7ao1efDJEdtDp5TgDfd/MvKErMDfBYeZLnSSTcsMYR/XXa/5FIY4cxy
         QnY6O8PaqzAYRcBLazt+hqCZbqO+mLCeo13MkJOnagcJPfFF7iS8N6lVGkFi7C5kZPMH
         8H9dYi8CODLbXjjj6DjuVuaSIFfbX43QquA7rc27WGyJFLDCfsMEJNIH/oMt/tc4tZU+
         UsWr+ZIjA1Hiq7yO4o1Yhp9ijBpPNCV8iljR6CH3vxTHB/HlWf7ArTLP9BWLUiW7TeJa
         SlgA==
X-Gm-Message-State: AOAM532K2ikXv2c2tZ/5RPoPNbTfCTE1cCcKciol4uDojJfdqZN0r3Bs
        GlVwKzh2A46yg/nuNmn8SgQp+g==
X-Google-Smtp-Source: ABdhPJyWpx957MyXRWtaWksH4CBsQq/kMXhKP7NgcMO8FDAsOKtA0sPaFXNWqlxx+SATw/dzvmZYzA==
X-Received: by 2002:ac8:5cc4:: with SMTP id s4mr3803442qta.214.1617817981636;
        Wed, 07 Apr 2021 10:53:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::106a? ([2620:10d:c091:480::1:8178])
        by smtp.gmail.com with ESMTPSA id s13sm16954182qtx.42.2021.04.07.10.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:53:01 -0700 (PDT)
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4fb00423-af48-49b7-c39b-3dde90289064@toxicpanda.com>
Date:   Wed, 7 Apr 2021 13:52:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/15/21 1:53 AM, Naohiro Aota wrote:
> This commit moves the location of superblock logging zones. The location of
> the logging zones are determined based on fixed block addresses instead of
> on fixed zone numbers.
> 
> By locating the superblock zones using fixed addresses, we can scan a
> dumped file system image without the zone information. And, no drawbacks
> exist.
> 
> We use the following three pairs of zones containing fixed offset
> locations, regardless of the device zone size.
> 
>    - Primary superblock: zone starting at offset 0 and the following zone
>    - First copy: zone containing offset 64GB and the following zone
>    - Second copy: zone containing offset 256GB and the following zone
> 
> If the location of the zones are outside of disk, we don't record the
> superblock copy.
> 
> These addresses are arbitrary, but using addresses that are too large
> reduces superblock reliability for smaller devices, so we do not want to
> exceed 1T to cover all case nicely.
> 
> Also, LBAs are generally distributed initially across one head (platter
> side) up to one or more zones, then go on the next head backward (the other
> side of the same platter), and on to the following head/platter. Thus using
> non sequential fixed addresses for superblock logging, such as 0/64G/256G,
> likely result in each superblock copy being on a different head/platter
> which improves chances of recovery in case of superblock read error.
> 
> These zones are reserved for superblock logging and never used for data or
> metadata blocks. Zones containing the offsets used to store superblocks in
> a regular btrfs volume (no zoned case) are also reserved to avoid
> confusion.
> 
> Note that we only reserve the 2 zones per primary/copy actually used for
> superblock logging. We don't reserve the ranges possibly containing
> superblock with the largest supported zone size (0-16GB, 64G-80GB,
> 256G-272GB).
> 
> The first copy position is much larger than for a regular btrfs volume
> (64M).  This increase is to avoid overlapping with the log zones for the
> primary superblock. This higher location is arbitrary but allows supporting
> devices with very large zone size, up to 32GB. But we only allow zone sizes
> up to 8GB for now.
> 

Ok it took me a few reads to figure out what's going on.

The problem is that with large zone sizes, our current choices put the back up 
super blocks waaaayyyyyy out on the disk, correct?  So instead you've picked 
arbitrary byte offsets, hoping that they'll be closer to the front of the disk 
and thus actually be useful.

And then you've introduced the 8gib zone size as a way to avoid problems where 
we get the same zone for the backup supers.

Are these statements correct?  If so the changelog should be updated to make 
this clear up front, because it took me a while to work that out.

Something at the beginning like the following

"With larger zone sizes, for example 8gib, the 3rd backup super would be located 
8tib into the device.  However not all zoned block devices are this large.  In 
order to fix this limitation set the zones to a static byte offset, and 
calculate the zone number from there based on the devices zone size."

So that it's clear from the outset why we're making this change.

And this brings up another problem, in that what happens when we _do_ run into 
block devices that have huge zones, like 64gib zones?  We have to change the 
disk format to support these devices.  I'm not against that per-se, but it seems 
like a limitation, even if it's unlikely to ever happen.  With the locations we 
currently have, any arbitrary zone size is going to work in the future, and the 
only drawback is you need a device of a certain size to take advantage of the 
back up super blocks.  I would hope that we don't have 64gib zone size block 
devices that are only 128gib in size in the future.


> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++--------
>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 43948bd40e02..6a72ca1f7988 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -21,9 +21,24 @@
>   /* Pseudo write pointer value for conventional zone */
>   #define WP_CONVENTIONAL ((u64)-2)
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
> +
>   /* Number of superblock log zones */
>   #define BTRFS_NR_SB_LOG_ZONES 2
>   
> +/* Max size of supported zone size */
> +#define BTRFS_MAX_ZONE_SIZE SZ_8G
> +
>   static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
>   {
>   	struct blk_zone *zones = data;
> @@ -111,11 +126,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>   }
>   
>   /*
> - * The following zones are reserved as the circular buffer on ZONED btrfs.
> - *  - The primary superblock: zones 0 and 1
> - *  - The first copy: zones 16 and 17
> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> - *                     the following one
> + * Get the zone number of the first zone of a pair of contiguous zones used
> + * for superblock logging.
>    */
>   static inline u32 sb_zone_number(int shift, int mirror)
>   {
> @@ -123,8 +135,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
>   
>   	switch (mirror) {
>   	case 0: return 0;
> -	case 1: return 16;
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> +	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);
> +	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);
>   	}
>   
>   	return 0;
> @@ -300,10 +312,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   		zone_sectors = bdev_zone_sectors(bdev);
>   	}
>   
> -	nr_sectors = bdev_nr_sectors(bdev);
>   	/* Check if it's power of 2 (see is_power_of_2) */
>   	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
>   	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> +
> +	/* We reject devices with a zone size larger than 8GB. */

A longer explanation here of why it's important that we limit it to our 
MAX_ZONE_SIZE, and use MAX_ZONE_SIZE instead of 8gib, in case we increase the 
limit in the future.

For example

We reject devices with a zone size larger than MAX_ZONE_SIZE because we do not 
want the backup super block zone to overlap with the primary super block zone.

Or something along these lines.  Again, I was confused why this was in the patch 
until I spent a lot more time thinking about it.  Thanks,

Josef
