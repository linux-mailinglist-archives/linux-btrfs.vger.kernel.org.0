Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A344D6DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 13:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhKKMxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 07:53:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKKMxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 07:53:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7328C21B3F;
        Thu, 11 Nov 2021 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636635062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5G2AM5n45vZPu8sLlut25RXn+lVcCBT3x1FmfNUZp4=;
        b=YPAL+AgFlXnywMW4caejUYx3F2ZF2TaI71sb2WiCh7DorxML+G1t3oRrepedXMACUYmZXm
        MEzKlxuZl6grGkQTp6AWeYl0DQPvtxgRSMQ5W7F/J6u11DXoGB/gQltQU1hbuaV8PFlQyC
        HDc7DvtVLmNLomNjQ7Ge7gsTf1WUapg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636635062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5G2AM5n45vZPu8sLlut25RXn+lVcCBT3x1FmfNUZp4=;
        b=AQHQWlF98F7VTbPdrmNVNzfOFvfk8XlL96so70aGAGBQNbz7U+RZkCWBaEvfN5pFjtRAPL
        1JBPGJ539gnOKZAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45A74A3CE9;
        Thu, 11 Nov 2021 12:51:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21D1BDA799; Thu, 11 Nov 2021 13:51:00 +0100 (CET)
Date:   Thu, 11 Nov 2021 13:51:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: cache reported zone during mount
Message-ID: <20211111125100.GB28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211111051438.4081012-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111051438.4081012-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 02:14:38PM +0900, Naohiro Aota wrote:
> This patch introduces a zone info cache in struct
> btrfs_zoned_device_info. The cache is populated while in
> btrfs_get_dev_zone_info() and used for
> btrfs_load_block_group_zone_info() to reduce the number of REPORT ZONE
> commands. The zone cache is then released after loading the block
> groups, as it will not be much effective during the run time.
> 
> Benchmark: Mount an HDD with 57,007 block groups
> Before patch: 171.368 seconds
> After patch: 64.064 seconds
> 
> While it still takes a minute due to the slowness of loading all the
> block groups, the patch reduces the mount time by 1/3.

That's a good improvement.

> Link: https://lore.kernel.org/linux-btrfs/CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com/
> Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
> CC: stable@vger.kernel.org
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> +	/*
> +	 * Enable zone cache only for a zoned device. On a non-zoned
> +	 * device, we fill the zone info with emulated CONVENTIONAL
> +	 * zones, so no need to use the cache.
> +	 */
> +	if (populate_cache && bdev_is_zoned(device->bdev)) {
> +		zone_info->zone_cache = vzalloc(sizeof(struct blk_zone) *
> +						zone_info->nr_zones);

So the zone cache is a huge array of struct blk_zone. In the example
device with 57k zones and sizeof(blk_zone) = 64, it's about 3.5M. As the
cache lifetime is relatively short I think it's acceptable to do the
virtual allocation.

This is the simplest way. What got me thinking a bit is if we need to
cache entire blk_zone.

struct blk_zone {
	__u64	start;		/* Zone start sector */
	__u64	len;		/* Zone length in number of sectors */
	__u64	wp;		/* Zone write pointer position */
	__u8	type;		/* Zone type */
	__u8	cond;		/* Zone condition */
	__u8	non_seq;	/* Non-sequential write resources active */
	__u8	reset;		/* Reset write pointer recommended */
	__u8	resv[4];
	__u64	capacity;	/* Zone capacity in number of sectors */
	__u8	reserved[24];
};

Reserved is 28 bytes, and some other state information may not be
necessary at the load time. So could we have a cached_blk_zone structure
in the array, with only the interesting blk_zone members copied?

This could reduce the array size, eg. if the cached_blk_zone is
something like:

struct cached_blk_zone {
	__u64	start;		/* Zone start sector */
	__u64	len;		/* Zone length in number of sectors */
	__u64	wp;		/* Zone write pointer position */
	__u8	type;		/* Zone type */
	__u8	cond;		/* Zone condition */
	__u64	capacity;	/* Zone capacity in number of sectors */
};

There's still some padding needed between u8 and u64, so we may not be
able to do better than space of 5*u64, which is 40 bytes. This would
result in cached array of about 2.2M.

This may not look much but kernel memory always comes at a cost and if
there's more than one device needed the allocated memory grows.
That it's virtual memory avoids the problem with fragmented memory,
though I think we'd have to use it anyway in case we want to use a
contiguous array and not some dynamic structure.

For first implementation the array of blk_zone is fine, but please give
it a thought too if you could spot something that can be made more
effective.
