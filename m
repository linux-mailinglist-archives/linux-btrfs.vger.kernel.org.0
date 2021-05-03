Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF8371630
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhECNti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 09:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232195AbhECNti (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 09:49:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCA46B036;
        Mon,  3 May 2021 13:48:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83CB5DA7A5; Mon,  3 May 2021 15:46:18 +0200 (CEST)
Date:   Mon, 3 May 2021 15:46:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: zoned: bail out if we can't read a reliable
 write pointer
Message-ID: <20210503134618.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20210430133418.4100-1-johannes.thumshirn@wdc.com>
 <20210430133418.4100-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430133418.4100-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 03:34:18PM +0200, Johannes Thumshirn wrote:
> If we can't read a reliable write pointer from a sequential zone fail
> creating the block group with an I/O error.
> 
> Also if the read write pointer is beyond the end of the respective zone,
> fail the creation of the block group on this zone with an I/O error.
> 
> While this could also happen in real world scenarios with misbehaving
> drives, this issue addresses a problem uncovered by xfstest's test case
> generic/475.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 304ce64c70a4..29adf846f33b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1187,6 +1187,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  
>  	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>  	case 0: /* single */
> +		if (alloc_offsets[0] == WP_MISSING_DEV) {
> +			btrfs_err(fs_info,
> +				  "zoned: cannot recover write pointer");

The message is too vague, we have at least the block group offset to
refer to. What to write to an error message can be found at
https://btrfs.wiki.kernel.org/index.php/Development_notes#Error_messages.2C_verbosity


> +			ret = -EIO;
> +			goto out;
> +		}
>  		cache->alloc_offset = alloc_offsets[0];
>  		break;
>  	case BTRFS_BLOCK_GROUP_DUP:
> @@ -1204,6 +1210,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  	}
>  
>  out:
> +	if (cache->alloc_offset > fs_info->zone_size) {
> +		btrfs_err(fs_info, "zoned: invalid write pointer: %llu",
> +			  cache->alloc_offset);

This looks like it could be enhanced as well.
