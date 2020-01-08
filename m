Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BD1348C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 18:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgAHRDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 12:03:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgAHRDy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 12:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E598AFA9;
        Wed,  8 Jan 2020 17:03:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D312DA791; Wed,  8 Jan 2020 18:03:41 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:03:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: kill update_block_group_flags
Message-ID: <20200108170340.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200106165015.18985-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106165015.18985-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 11:50:15AM -0500, Josef Bacik wrote:
> btrfs/061 has been failing consistently for me recently with a
> transaction abort.  We run out of space in the system chunk array, which
> means we've allocated way too many system chunks than we need.
> 
> Chris added this a long time ago for balance as a poor mans restriping.
> If you had a single disk and then added another disk and then did a
> balance, update_block_group_flags would then figure out which RAID level
> you needed.
> 
> Fast forward to today and we have restriping behavior, so we can
> explicitly tell the fs that we're trying to change the raid level.  This
> is accomplished through the normal get_alloc_profile path.
> 
> Furthermore this code actually causes btrfs/061 to fail, because we do
> things like mkfs -m dup -d single with multiple devices.  This trips
> this check
> 
> alloc_flags = update_block_group_flags(fs_info, cache->flags);
> if (alloc_flags != cache->flags) {
> 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> 
> in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, but
> not actually restriping, we keep forcing chunk allocation of RAID1
> chunks.  This eventually causes us to run out of system space and the
> file system aborts and flips read only.
> 
> We don't need this poor mans restriping any more, simply use the normal
> get_alloc_profile helper, which will get the correct alloc_flags and
> thus make the right decision for chunk allocation.  This keeps us from
> allocating a billion system chunks and falling over.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 52 ++----------------------------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c79eccf188c5..0257e6f1efb1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1975,54 +1975,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>  	return 0;
>  }
>  
> -static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
> -{
> -	u64 num_devices;
> -	u64 stripped;
> -
> -	/*
> -	 * if restripe for this chunk_type is on pick target profile and
> -	 * return, otherwise do the usual balance
> -	 */
> -	stripped = get_restripe_target(fs_info, flags);
> -	if (stripped)
> -		return extended_to_chunk(stripped);
> -
> -	num_devices = fs_info->fs_devices->rw_devices;
> -
> -	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
> -		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
> -
> -	if (num_devices == 1) {
> -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> -		stripped = flags & ~stripped;
> -
> -		/* turn raid0 into single device chunks */
> -		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> -			return stripped;
> -
> -		/* turn mirroring into duplication */
> -		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
> -			     BTRFS_BLOCK_GROUP_RAID10))
> -			return stripped | BTRFS_BLOCK_GROUP_DUP;
> -	} else {
> -		/* they already had raid on here, just return */
> -		if (flags & stripped)
> -			return flags;
> -
> -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> -		stripped = flags & ~stripped;
> -
> -		/* switch duplicated blocks with raid1 */
> -		if (flags & BTRFS_BLOCK_GROUP_DUP)
> -			return stripped | BTRFS_BLOCK_GROUP_RAID1;
> -
> -		/* this is drive concat, leave it alone */
> -	}

I remember that I ended up in that function while testing the raid1c34
feature, converting from one profile to another, but can't recall the
details now. I think the fallback to the profiles did occur here in some
cases so we need to make sure that the same usecases are still
supported.
