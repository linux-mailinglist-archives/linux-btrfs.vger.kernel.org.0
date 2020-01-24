Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A04148773
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgAXOXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:23:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392389AbgAXOWb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:22:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95A08AD46;
        Fri, 24 Jan 2020 14:22:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DAD6DA730; Fri, 24 Jan 2020 15:22:11 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:22:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Message-ID: <20200124142211.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123081849.23397-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 05:18:49PM +0900, Johannes Thumshirn wrote:
>  	if (btrfs_super_bytenr(super_tmp) != dev_bytenr ||
>  	    btrfs_super_magic(super_tmp) != BTRFS_MAGIC ||
>  	    memcmp(device->uuid, super_tmp->dev_item.uuid, BTRFS_UUID_SIZE) ||
>  	    btrfs_super_nodesize(super_tmp) != state->metablock_size ||
>  	    btrfs_super_sectorsize(super_tmp) != state->datablock_size) {
> -		brelse(bh);
> +		btrfs_release_disk_super(page);
>  		return 0;
>  	}
>  
> @@ -795,7 +813,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  		superblock_tmp = btrfsic_block_alloc();
>  		if (NULL == superblock_tmp) {
>  			pr_info("btrfsic: error, kmalloc failed!\n");
> -			brelse(bh);
> +			btrfs_release_disk_super(page);
>  			return -1;
>  		}
>  		/* for superblock, only the dev_bytenr makes sense */
> @@ -880,7 +898,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  					      mirror_num)) {
>  				pr_info("btrfsic: btrfsic_map_block(bytenr @%llu, mirror %d) failed!\n",
>  				       next_bytenr, mirror_num);
> -				brelse(bh);
> +				btrfs_release_disk_super(page);
>  				return -1;
>  			}
>  
> @@ -890,7 +908,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  					mirror_num, NULL);
>  			if (NULL == next_block) {
>  				btrfsic_release_block_ctx(&tmp_next_block_ctx);
> -				brelse(bh);
> +				btrfs_release_disk_super(page);
>  				return -1;
>  			}
>  
> @@ -902,7 +920,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  					BTRFSIC_GENERATION_UNKNOWN);
>  			btrfsic_release_block_ctx(&tmp_next_block_ctx);
>  			if (NULL == l) {
> -				brelse(bh);
> +				btrfs_release_disk_super(page);
>  				return -1;
>  			}
>  		}
> @@ -910,7 +928,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  	if (state->print_mask & BTRFSIC_PRINT_MASK_INITIAL_ALL_TREES)
>  		btrfsic_dump_tree_sub(state, superblock_tmp, 0);
>  
> -	brelse(bh);
> +	btrfs_release_disk_super(page);

This could be the cleaned up to merge all error exits to jump to this
common block. Integrity checker is an old code so nobody cared enough to
clean it up, but it would be good to do it now when there are pople
looking at the code.

As mentioned before, btrfs_release_disk_super should be opencoded so
this would make it more straightfowrard to have only one place instad of
each error exit brelse replaced by put_page/kunmap.

>  	return 0;
>  }
