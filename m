Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4338CB2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhEUQlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 12:41:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhEUQlE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 12:41:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621615180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqVUIt9aMEn5aAyhlri/tMQaKHYNLmmuM+Q611tFHbI=;
        b=DzogU2Bxzj6JlmJFtSE/rVBjGfOwVbvHJzLW/1EeXBIbe8x3aTNpw6xXMyK8s7Xi/iC9cF
        EGAulJeR55TnVC38UcuM+aO9Ecs+ieP0zTwF8O9JhdC4abILHZao/cozm1hB+62ZBH9+Ge
        W+XJDAP1hl2c8XvYk+TfC8GD/XA7K04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621615180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqVUIt9aMEn5aAyhlri/tMQaKHYNLmmuM+Q611tFHbI=;
        b=alOFS+YHJc44ueuSdK1qQkv5ce7fgxtKI+ADOMYaKRvE0reY1acO5RfVNW+U8XhTmEbJdO
        2JaeL/h/8bLCayAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F072CAAA6;
        Fri, 21 May 2021 16:39:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 561B6DA730; Fri, 21 May 2021 18:37:05 +0200 (CEST)
Date:   Fri, 21 May 2021 18:37:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Message-ID: <20210521163705.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 06:11:04PM +0900, Johannes Thumshirn wrote:
> Damien reported a test failure with btrfs/209. The test itself ran fine,
> but the fsck run afterwards reported a corrupted filesystem.
> 
> The filesystem corruption happens because we're splitting an extent and
> then writing the extent twice. We have to split the extent though, because
> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.
> 
> When dumping the extent tree, we can see two EXTENT_ITEMs at the same
> start address but different lengths.
> 
> $ btrfs inspect dump-tree /dev/nullb1 -t extent
> ...
>    item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53
>            refs 1 gen 7 flags DATA
>            extent data backref root FS_TREE objectid 257 offset 786432 count 1
>    item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53
>            refs 1 gen 7 flags DATA
>            extent data backref root FS_TREE objectid 257 offset 786432 count 1
> 
> On a zoned filesystem, limit the size of an ordered extent to the maximum
> size that can be issued as a single REQ_OP_ZONE_APPEND operation.
> 
> Note: This patch breaks fstests btrfs/079, as it increases the number of
> on-disk extents from 80 to 83 per 10M write.
> 
> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 78d3f2ec90e0..e823b2c74af5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  				    u64 *end)
>  {
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
>  	u64 delalloc_start;
>  	u64 delalloc_end;
> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  	int ret;
>  	int loops = 0;
>  
> +	if (fs_info && fs_info->max_zone_append_size)
> +		max_bytes = ALIGN_DOWN(fs_info->max_zone_append_size,
> +				       PAGE_SIZE);

Why is the alignment needed? Are the max zone append values expected to
be so random? Also it's using memory-related value for something that's
more hw related, or at least extent size (which ends up on disk).

>  again:
>  	/* step one, find a bunch of delalloc bytes starting at start */
>  	delalloc_start = *start;
> -- 
> 2.31.1
