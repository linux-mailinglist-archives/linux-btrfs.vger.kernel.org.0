Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA63029AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbhAYSLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 13:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbhAYSE0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 13:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FE48AF0F;
        Mon, 25 Jan 2021 17:42:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DDCCDA7D2; Mon, 25 Jan 2021 18:40:55 +0100 (CET)
Date:   Mon, 25 Jan 2021 18:40:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix log replay failure due to race with space
 cache rebuild
Message-ID: <20210125174055.GN1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <c655306f61af9b2d75ed22053a7cdc3f21022d72.1611337435.git.fdmanana@suse.com>
 <afa2ccadd8add70cf742ed7943c01be6fccd13b8.1611340095.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa2ccadd8add70cf742ed7943c01be6fccd13b8.1611340095.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 07:07:45PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After a sudden power failure we may end up with a space cache on disk that
> is not valid and needs to be rebuilt from scratch.
> 
> If that happens, during log replay when we attempt to pin an extent buffer
> from a log tree, at btrfs_pin_extent_for_log_replay(), we do not wait for
> the space cache to be rebuilt through the call to:
> 
>     btrfs_cache_block_group(cache, 1);
> 
> That is because that only waits for the task (work queue job) that loads
> the space cache to change the cache state from BTRFS_CACHE_FAST to any
> other value. That is ok when the space cache on disk exists and is valid,
> but when the cache is not valid and needs to be rebuilt, it ends up
> returning as soon as the cache state changes to BTRFS_CACHE_STARTED (done
> at caching_thread()).
> 
> So this means that we can end up trying to unpin a range which is not yet
> marked as free in the block group. This results in the call to
> btrfs_remove_free_space() to return -EINVAL to
> btrfs_pin_extent_for_log_replay(), which in turn makes the log replay fail
> as well as mounting the filesystem. More specifically the -EINVAL comes
> from free_space_cache.c:remove_from_bitmap(), because the requested range
> is not marked as free space (ones in the bitmap), we have the following
> condition triggered:
> 
> static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
> (...)
>        if (ret < 0 || search_start != *offset)
>             return -EINVAL;
> (...)
> 
> It's the "search_start != *offset" that results in the condition being
> evaluated to true.
> 
> When this happens we got the following in dmesg/syslog:
> 
> [72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
> [72383.417837] BTRFS info (device sdb): disk space caching is enabled
> [72383.418536] BTRFS info (device sdb): has skinny extents
> [72383.423846] BTRFS info (device sdb): start tree-log replay
> [72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
> [72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
> [72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
> [72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
> [72383.460241] BTRFS error (device sdb): open_ctree failed
> 
> We also mark the range for the extent buffer in the excluded extents io
> tree. That is fine when the space cache is valid on disk and we can load
> it, in which case it causes no problems.
> 
> However, for the case where we need to rebuild the space cache, because it
> is either invalid or it is missing, having the extent buffer range marked
> in the excluded extents io tree leads to a -EINVAL failure from the call
> to btrfs_remove_free_space(), resulting in the log replay and mount to
> fail. This is because by having the range marked in the excluded extents
> io tree, the caching thread ends up never adding the range of the extent
> buffer as free space in the block group since the calls to
> add_new_free_space(), called from load_extent_tree_free(), filter out any
> ranges that are marked as excluded extents.
> 
> So fix this by making sure that during log replay we wait for the caching
> task to finish completely when we need to rebuild a space cache, and also
> drop the need to mark the extent buffer range in the excluded extents io
> tree, as well as clearing ranges from that tree at
> btrfs_finish_extent_commit().
> 
> This started to happen with some frequency on large filesystems having
> block groups with a lot of fragmentation since the recent commit
> e747853cae3ae3 ("btrfs: load free space cache asynchronously"), but in
> fact the issue has been there for years, it was just much less likely
> to happen.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks. As this is more likely to happen on 5.11 due
to async loading I'll probably forward it to the next rc.
