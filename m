Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E39513980
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349833AbiD1QSc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiD1QSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 12:18:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDFC27B3F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 09:15:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86F401F88C;
        Thu, 28 Apr 2022 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651162511;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfOhyBbGRRC7Lh2a9P2UxMWavYnCDgM2Jh+1ZUffPMs=;
        b=HRmT7+CG/3bwJAF9/kg0j8g3wt65E1kyOFA9VmP9akJKF4x5Gv8wYPPVr3hvAQgXVXxDm8
        YJUTsCyjz7kUHPADDZEOSZNJuiLLEKQD4SNZSacDZbo7dK3odI2K00Ri/i3iVq8pVG8C66
        0QTOV4CeFa33d/i4I0uO/rOX9BNfphY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651162511;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfOhyBbGRRC7Lh2a9P2UxMWavYnCDgM2Jh+1ZUffPMs=;
        b=iTNYfgoYEvqZORXiAna1WgrUqAhan5G3cE9YVEBQsdoOdDLNIBcaakbpEVTjP02LolQi2G
        4n1AWuSkI/U2aeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AF6113AF8;
        Thu, 28 Apr 2022 16:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ETU6FY+9amKfHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Apr 2022 16:15:11 +0000
Date:   Thu, 28 Apr 2022 18:11:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: zoned: consolidate zone finish function
Message-ID: <20220428161103.GD18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651157034.git.naohiro.aota@wdc.com>
 <4d5e42d343318979a254f7dbdd96aa1c48908ed8.1651157034.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d5e42d343318979a254f7dbdd96aa1c48908ed8.1651157034.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 12:02:15AM +0900, Naohiro Aota wrote:
>  1 file changed, 54 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 997a96d7a3d5..9cddafe78fb1 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1879,20 +1879,14 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
>  	return ret;
>  }
>  
> -int btrfs_zone_finish(struct btrfs_block_group *block_group)
> +static int __btrfs_zone_finish(struct btrfs_block_group *block_group, bool nowait)

Can you please avoid using __ for functions? Eg. the main function can
be btrfs_zone_finish(taking 2 parameters) and the exported one being
btrfs_zone_finish_nowait reflecting the preset parameter and also making
the 'nowait' semantics clear.

>  {
>  	struct btrfs_fs_info *fs_info = block_group->fs_info;
>  	struct map_lookup *map;
> -	struct btrfs_device *device;
> -	u64 physical;
> +	bool need_zone_finish;
>  	int ret = 0;
>  	int i;
>  
> -	if (!btrfs_is_zoned(fs_info))
> -		return 0;
> -
> -	map = block_group->physical_map;
> -
>  	spin_lock(&block_group->lock);
>  	if (!block_group->zone_is_active) {
>  		spin_unlock(&block_group->lock);
> @@ -1906,36 +1900,42 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
>  		spin_unlock(&block_group->lock);
>  		return -EAGAIN;
>  	}
> -	spin_unlock(&block_group->lock);
>  
> -	ret = btrfs_inc_block_group_ro(block_group, false);
> -	if (ret)
> -		return ret;
> +	if (!nowait) {
> +		spin_unlock(&block_group->lock);
>  
> -	/* Ensure all writes in this block group finish */
> -	btrfs_wait_block_group_reservations(block_group);
> -	/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
> -	btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
> -				 block_group->length);
> +		ret = btrfs_inc_block_group_ro(block_group, false);
> +		if (ret)
> +			return ret;
>  
> -	spin_lock(&block_group->lock);
> +		/* Ensure all writes in this block group finish */
> +		btrfs_wait_block_group_reservations(block_group);
> +		/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
> +		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
> +					 block_group->length);
>  
> -	/*
> -	 * Bail out if someone already deactivated the block group, or
> -	 * allocated space is left in the block group.
> -	 */
> -	if (!block_group->zone_is_active) {
> -		spin_unlock(&block_group->lock);
> -		btrfs_dec_block_group_ro(block_group);
> -		return 0;
> -	}
> +		spin_lock(&block_group->lock);
>  
> -	if (block_group->reserved) {
> -		spin_unlock(&block_group->lock);
> -		btrfs_dec_block_group_ro(block_group);
> -		return -EAGAIN;
> +		/*
> +		 * Bail out if someone already deactivated the block group, or
> +		 * allocated space is left in the block group.
> +		 */
> +		if (!block_group->zone_is_active) {
> +			spin_unlock(&block_group->lock);
> +			btrfs_dec_block_group_ro(block_group);
> +			return 0;
> +		}
> +
> +		if (block_group->reserved) {
> +			spin_unlock(&block_group->lock);
> +			btrfs_dec_block_group_ro(block_group);
> +			return -EAGAIN;
> +		}
>  	}
>  
> +	/* There is unwritten space left. Need to finish the underlying zones. */
> +	need_zone_finish = (block_group->zone_capacity - block_group->alloc_offset) > 0;

This could be simplified to 'bg->zone_capacity > bg->alloc_offset',
but maybe should be behind a helper as the expression appears more
times.

> +
>  	block_group->zone_is_active = 0;
>  	block_group->alloc_offset = block_group->zone_capacity;
>  	block_group->free_space_ctl->free_space = 0;
> @@ -1943,24 +1943,29 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
>  	btrfs_clear_data_reloc_bg(block_group);
>  	spin_unlock(&block_group->lock);
>  
> +	map = block_group->physical_map;
>  	for (i = 0; i < map->num_stripes; i++) {
> -		device = map->stripes[i].dev;
> -		physical = map->stripes[i].physical;
> +		struct btrfs_device *device = map->stripes[i].dev;
> +		const u64 physical = map->stripes[i].physical;
>  
>  		if (device->zone_info->max_active_zones == 0)
>  			continue;
>  
> -		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> -				       physical >> SECTOR_SHIFT,
> -				       device->zone_info->zone_size >> SECTOR_SHIFT,
> -				       GFP_NOFS);
> +		if (need_zone_finish) {
> +			ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> +					       physical >> SECTOR_SHIFT,
> +					       device->zone_info->zone_size >> SECTOR_SHIFT,
> +					       GFP_NOFS);
>  
> -		if (ret)
> -			return ret;
> +			if (ret)
> +				return ret;
> +		}
>  
>  		btrfs_dev_clear_active_zone(device, physical);
>  	}
> -	btrfs_dec_block_group_ro(block_group);
> +
> +	if (!nowait)
> +		btrfs_dec_block_group_ro(block_group);
>  
>  	spin_lock(&fs_info->zone_active_bgs_lock);
>  	ASSERT(!list_empty(&block_group->active_bg_list));
