Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA310B641
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 19:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0S7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 13:59:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0S7V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 13:59:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15883ADBF;
        Wed, 27 Nov 2019 18:59:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DEA16DA733; Wed, 27 Nov 2019 19:59:16 +0100 (CET)
Date:   Wed, 27 Nov 2019 19:59:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: space-info: Make over-commit threshold to
 87.5% of a new chunk
Message-ID: <20191127185916.GZ2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191125100450.43599-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125100450.43599-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 06:04:50PM +0800, Qu Wenruo wrote:
> [BUG]
> For certain fs layout, a full balance can cause reproducible ENOSPC.
> With enospc_debug, we got the following dmesg (BTRFS info and device
> info ommitted to save some space):
> 
>  disk space caching is enabled
>  has skinny extents
>  balance: start -d -m -s
>  relocating block group 1104150528 flags data
>  found 14659 extents
>  found 14659 extents
>  unable to make block group 30408704 ro  <<< from inc_block_group_ro()
>  sinfo_used=2386411520 bg_num_bytes=1046888448 min_allocable=1048576
>  space_info 4 has 18446744072434089984 free, is not full
>  space_info total=1073741824, used=24281088, pinned=1277952, reserved=1245184, may_use=2322333696, readonly=65536
>  global_block_rsv: size 3407872 reserved 3407872
>  trans_block_rsv: size 0 reserved 0
>  chunk_block_rsv: size 0 reserved 0
>  delayed_block_rsv: size 0 reserved 0
>  delayed_refs_rsv: size 2318401536 reserved 2318401536
>  unable to make block group 30408704 ro <<< double inc_block_group_ro()
>                                             failure, means
>                                             btrfs_inc_block_group_ro() failed
>  sinfo_used=2342912000 bg_num_bytes=1046872064 min_allocable=1048576
>  space_info 4 has 18446744072726380544 free, is not full
>  space_info total=1342177280, used=24281088, pinned=1277952, reserved=1245184, may_use=2298478592, readonly=65536
>  global_block_rsv: size 3407872 reserved 3407872
>  trans_block_rsv: size 0 reserved 0
>  chunk_block_rsv: size 393216 reserved 393216
>  delayed_block_rsv: size 0 reserved 0
>  delayed_refs_rsv: size 2294546432 reserved 2294546432
>  ...
>  1 enospc errors during balance
>  balance: ended with status: -28
> 
> [CAUSE]
> When allocating block group 1104150528, since that block group has a lot
> of extents, it has a data reloc inode with a lot of extents (14659
> non-hole data extents).
> 
> After relocating that block group, btrfs needs to cleanup the data reloc
> inode.
> 
> During that inode eviction, we have call evict_refill_and_join() to get
> metadata space reserved, which will cause a lot of metadata
> bytes_may_use:
>   evict_refill_and_join()
>   |- btrfs_block_rsv_refill()
>      |- btrfs_reserve_metadata_bytes()
>         |- __reserve_metadata_bytes()
>            |- if (can_overcommit() || ...) {
>            |     btrfs_space_info_update_bytes_may_use();
>            |     ret = 0;
>            |  }
>            |  if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
>            |     return ret;
>            |  return handle_reserve_ticket();
> 
> That means, if we can can_overcommit(), we will increase bytes_may_use()
> anyway.
> And only when we failed to over-commit, handle_reserve_ticket() get
> triggered to reclaim some space.
> 
> On the other hand, at btrfs_inc_block_group_ro(), we will check if we
> have enough space, and if not, allocate a chunk and retry:
>   btrfs_inc_block_group_ro()
>   |- ret = inc_block_group_ro(cache, 0);
>   |        |- if (sinfo_used + num_bytes + min_allocable_bytes <=
>   |        |      sinfo->total_bytes)
>   |        |      ret = 0; # Only success if we have enough space.
>   |- ret = btrfs_alloc_chunk(); # Trigger a chunk allocation
>   |- ret = inc_block_group_ro(cache, 0);
>            |- Do the same check again.
> 
> That means, if above over-commit threshold is larger than current space
> + 1 more chunk, btrfs will continue over-commit, causing very large
> bytes_may_use just like the enospc debug output:
>  space_info total=1073741824, used=24281088, ..., may_use=2322333696
>                                                           ^^^^^^^^^^
> The fs is 25G, DUP metadata, so the over-commit threshold can be as
> large as 6G.
> In our case may_use is over 2.3G, while our metadata space info is only 1G.
> Definitely will not pass the check in btrfs_inc_block_group_ro().
> 
> Such over-commit behavior works fine for most use cases, but when
> btrfs_inc_block_group_ro() is involved, we will get ENOSPC.
> 
> [FIX]
> Change can_overcommit() threshold, to follow the
> btrfs_inc_block_group_ro() behavior.
> 
> Adds a new threshold check based on chunk size, so if our used bytes
> (including bytes_may_use) exceeds current space info + 87.5% one chunk size,
> we stop over-commit.
> 
> The 87.5% is used as extra headroom for min_allocable_bytes (SZ_1M).
> 
> This makes over-commit work along with btrfs_inc_block_group_ro().
> 
> The downside is, we will have much smaller over-commit threshold.
> This means, when fs is mostly empty, performance may drop compared to
> the old behavior.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> This is another extreme, compared to "[RFC PATCH] btrfs: Commit
> transaction to workaround ENOSPC during relocation".
> 
> This patch will reduce commit threshold for all cases, just to address
> one case in relocation.
> 
> While the other RFC just address one problem, and one problem only,
> but in a whac-a-hole fashion.
> 
> I don't know which is better, personally speaking, that whac-a-hole
> patch may be a little better.
> 
> So both patches are with RFC tag.

This patch is superseded by the series from Josef, right?
