Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8F79EBA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjIMOw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIMOw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 10:52:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139AAC;
        Wed, 13 Sep 2023 07:52:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70B4D218E5;
        Wed, 13 Sep 2023 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694616770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrV8GF8432YR23nIP/OiT5cXUNGehzNZd8GOPZThzKE=;
        b=HKWQ4go2OhHwGXr554jWce4BEB3pKl+QfB4nQ6E5BytT9tZqAYcjeEZ9l7L01JySmJp/KP
        JSgAkx04kNq0mHbq+VUw7/DLAju0EkbvVeRFWiZT07WqwPPQifxBQ6j1OZLXGGDAac9V5L
        G9WNmVV1ImT7zmBBsHOBJ/3oYe5sKvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694616770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrV8GF8432YR23nIP/OiT5cXUNGehzNZd8GOPZThzKE=;
        b=COwc6ZAi7b50z1wKWxsi94G3tjWJIgWGxVgLhBkO4r14RPisNAdi8nlHoHdVBvXzqzieqn
        RiQbVnd5476ggtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2327D13440;
        Wed, 13 Sep 2023 14:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3yWIB8LMAWVSbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 14:52:50 +0000
Date:   Wed, 13 Sep 2023 16:52:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 07/11] btrfs: zoned: allow zoned RAID
Message-ID: <20230913145248.GM20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-7-647676fa852c@wdc.com>
 <20230912204906.GH20408@twin.jikos.cz>
 <27b68e26-d6b7-406a-9a55-6f298fd82ad2@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b68e26-d6b7-406a-9a55-6f298fd82ad2@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 13, 2023 at 05:41:52AM +0000, Johannes Thumshirn wrote:
> On 12.09.23 22:49, David Sterba wrote:
> > On Mon, Sep 11, 2023 at 05:52:08AM -0700, Johannes Thumshirn wrote:
> >> When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
> >> data block-groups. For meta-data block-groups, we don't actually need
> >> anything special, as all meta-data I/O is protected by the
> >> btrfs_zoned_meta_io_lock() already.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/raid-stripe-tree.h |   7 ++-
> >>   fs/btrfs/volumes.c          |   2 +
> >>   fs/btrfs/zoned.c            | 113 +++++++++++++++++++++++++++++++++++++++++++-
> >>   3 files changed, 119 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> >> index 40aa553ae8aa..30c7d5981890 100644
> >> --- a/fs/btrfs/raid-stripe-tree.h
> >> +++ b/fs/btrfs/raid-stripe-tree.h
> >> @@ -8,6 +8,11 @@
> >>   
> >>   #include "disk-io.h"
> >>   
> >> +#define BTRFS_RST_SUPP_BLOCK_GROUP_MASK		(BTRFS_BLOCK_GROUP_DUP |\
> >> +						 BTRFS_BLOCK_GROUP_RAID1_MASK |\
> >> +						 BTRFS_BLOCK_GROUP_RAID0 |\
> >> +						 BTRFS_BLOCK_GROUP_RAID10)
> >> +
> >>   struct btrfs_io_context;
> >>   struct btrfs_io_stripe;
> >>   
> >> @@ -32,7 +37,7 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
> >>   	if (type != BTRFS_BLOCK_GROUP_DATA)
> >>   		return false;
> >>   
> >> -	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
> >> +	if (profile & BTRFS_RST_SUPP_BLOCK_GROUP_MASK)
> >>   		return true;
> >>   
> >>   	return false;
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 7c25f5c77788..9f17e5f290f4 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -6438,6 +6438,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> >>   	 * I/O context structure.
> >>   	 */
> >>   	if (smap && num_alloc_stripes == 1 &&
> >> +	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
> >> +	      op != BTRFS_MAP_READ) &&
> >>   	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
> >>   		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
> >>   				    stripe_index, stripe_offset, stripe_nr);
> >> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >> index c6eedf4bfba9..4ca36875058c 100644
> >> --- a/fs/btrfs/zoned.c
> >> +++ b/fs/btrfs/zoned.c
> >> @@ -1481,8 +1481,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
> >>   			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
> >>   		break;
> >>   	case BTRFS_BLOCK_GROUP_DUP:
> >> -		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
> >> -			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
> >> +		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
> >> +		    !btrfs_stripe_tree_root(fs_info)) {
> >> +			btrfs_err(fs_info, "zoned: data DUP profile needs stripe_root");
> >>   			ret = -EINVAL;
> >>   			goto out;
> >>   		}
> >> @@ -1520,8 +1521,116 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
> >>   		cache->zone_capacity = min(caps[0], caps[1]);
> >>   		break;
> >>   	case BTRFS_BLOCK_GROUP_RAID1:
> >> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> >> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> > 
> > This
> > 
> >> +		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
> >> +		    !btrfs_stripe_tree_root(fs_info)) {
> >> +			btrfs_err(fs_info,
> >> +				  "zoned: data %s needs stripe_root",
> >> +				  btrfs_bg_type_to_raid_name(map->type));
> >> +			ret = -EIO;
> >> +			goto out;
> >> +
> >> +		}
> >> +
> >> +		for (i = 0; i < map->num_stripes; i++) {
> >> +			if (alloc_offsets[i] == WP_MISSING_DEV ||
> >> +			    alloc_offsets[i] == WP_CONVENTIONAL)
> >> +				continue;
> >> +
> >> +			if ((alloc_offsets[0] != alloc_offsets[i]) &&
> >> +			    !btrfs_test_opt(fs_info, DEGRADED)) {
> >> +				btrfs_err(fs_info,
> >> +					  "zoned: write pointer offset mismatch of zones in %s profile",
> >> +					  btrfs_bg_type_to_raid_name(map->type));
> >> +				ret = -EIO;
> >> +				goto out;
> >> +			}
> >> +			if (test_bit(0, active) != test_bit(i, active)) {
> >> +				if (!btrfs_test_opt(fs_info, DEGRADED) &&
> >> +				    !btrfs_zone_activate(cache)) {
> >> +					ret = -EIO;
> >> +					goto out;
> >> +				}
> >> +			} else {
> >> +				if (test_bit(0, active))
> >> +					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> >> +						&cache->runtime_flags);
> >> +			}
> >> +			/*
> >> +			 * In case a device is missing we have a cap of 0, so don't
> >> +			 * use it.
> >> +			 */
> >> +			cache->zone_capacity = min_not_zero(caps[0], caps[i]);
> >> +		}
> >> +
> >> +		if (alloc_offsets[0] != WP_MISSING_DEV)
> >> +			cache->alloc_offset = alloc_offsets[0];
> >> +		else
> >> +			cache->alloc_offset = alloc_offsets[i - 1];
> > 
> > whole block
> > 
> >> +		break;
> >>   	case BTRFS_BLOCK_GROUP_RAID0:
> > 
> > and
> > 
> >> +		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
> >> +		    !btrfs_stripe_tree_root(fs_info)) {
> >> +			btrfs_err(fs_info,
> >> +				  "zoned: data %s needs stripe_root",
> >> +				  btrfs_bg_type_to_raid_name(map->type));
> >> +			ret = -EIO;
> >> +			goto out;
> >> +
> >> +		}
> >> +		for (i = 0; i < map->num_stripes; i++) {
> >> +			if (alloc_offsets[i] == WP_MISSING_DEV ||
> >> +			    alloc_offsets[i] == WP_CONVENTIONAL)
> >> +				continue;
> >> +
> >> +			if (test_bit(0, active) != test_bit(i, active)) {
> >> +				if (!btrfs_zone_activate(cache)) {
> >> +					ret = -EIO;
> >> +					goto out;
> >> +				}
> >> +			} else {
> >> +				if (test_bit(0, active))
> >> +					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> >> +						&cache->runtime_flags);
> >> +			}
> >> +			cache->zone_capacity += caps[i];
> >> +			cache->alloc_offset += alloc_offsets[i];
> >> +
> >> +		}
> >> +		break;
> >>   	case BTRFS_BLOCK_GROUP_RAID10:
> >> +		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
> >> +		    !btrfs_stripe_tree_root(fs_info)) {
> >> +			btrfs_err(fs_info,
> >> +				  "zoned: data %s needs stripe_root",
> >> +				  btrfs_bg_type_to_raid_name(map->type));
> >> +			ret = -EIO;
> >> +			goto out;
> >> +
> >> +		}
> >> +		for (i = 0; i < map->num_stripes; i++) {
> >> +			if (alloc_offsets[i] == WP_MISSING_DEV ||
> >> +			    alloc_offsets[i] == WP_CONVENTIONAL)
> >> +				continue;
> >> +
> >> +			if (test_bit(0, active) != test_bit(i, active)) {
> >> +				if (!btrfs_zone_activate(cache)) {
> >> +					ret = -EIO;
> >> +					goto out;
> >> +				}
> >> +			} else {
> >> +				if (test_bit(0, active))
> >> +					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> >> +						&cache->runtime_flags);
> >> +			}
> >> +			if ((i % map->sub_stripes) == 0) {
> >> +				cache->zone_capacity += caps[i];
> >> +				cache->alloc_offset += alloc_offsets[i];
> >> +			}
> >> +
> >> +		}
> >> +		break;
> > 
> > Seem to be quite long and nested for a case, can they be factored to
> > helpers?
> 
> Sure, but I'd love to have
> https://lore.kernel.org/all/20230605085108.580976-1-hch@lst.de/
> pulled in first. This patchset handles (among other things) the DUP and 
> single cases as well.

I see, the patches still apply cleanly so I'll add them to misc-next.
