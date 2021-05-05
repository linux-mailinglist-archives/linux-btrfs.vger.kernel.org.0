Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07553374B8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEEWzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 18:55:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhEEWzu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 18:55:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E20AFAFCC;
        Wed,  5 May 2021 22:54:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44FDEDA81B; Thu,  6 May 2021 00:52:26 +0200 (CEST)
Date:   Thu, 6 May 2021 00:52:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: zoned: bail out if we can't read a
 reliable write pointer
Message-ID: <20210505225226.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
 <20210504083024.28072-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504083024.28072-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 04, 2021 at 10:30:24AM +0200, Johannes Thumshirn wrote:
> +			btrfs_err(fs_info,
> +				  "zoned: cannot read write pointer for zone %llu",
> +				  physical >> ilog2(fs_info->zone_size));

This converts the offset to the zone index, I think we should keep it
consistent, one way or another. The other message was printing the raw
offset (pysical or logical) and this is IMHO more friendly as this is
related to other on-disk structures. Translation to the zone index can
be done but the offset is not dependent on the device so I'd prefer
that. I've checked other messages and there are always raw offsets so
I've switched that back to the 'physical'.

> +			ret = -EIO;
> +			goto out;
> +		}
>  		cache->alloc_offset = alloc_offsets[0];
>  		break;
>  	case BTRFS_BLOCK_GROUP_DUP:
> @@ -1208,6 +1215,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  	}
>  
>  out:
> +	if (cache->alloc_offset > fs_info->zone_size) {
> +		btrfs_err(fs_info,
> +			  "zoned: write pointer %llu in BG %llu behind end of zone",

s/BG/block group/

And I've added the block group start as this is an anchor for any
potential debugging.

> +			  cache->alloc_offset, logical);
> +		ret = -EIO;
> +	}
> +
>  	/* An extent is allocated after the write pointer */
>  	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
>  		btrfs_err(fs_info,
> -- 
> 2.31.1
