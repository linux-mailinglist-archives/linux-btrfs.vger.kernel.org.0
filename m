Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0409511AF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBOMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 10:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEBOMP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 10:12:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FB44AF6D
        for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2019 14:12:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89419DA871; Thu,  2 May 2019 16:13:13 +0200 (CEST)
Date:   Thu, 2 May 2019 16:13:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Implement btrfs_lock_and_flush_ordered_range
Message-ID: <20190502141312.GB20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190422074653.13075-1-nborisov@suse.com>
 <20190422074653.13075-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422074653.13075-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 22, 2019 at 10:46:51AM +0300, Nikolay Borisov wrote:
> There is a certain idiom used in multiple places in btrfs' codebase,
> dealing with flushing an ordered range. Factor this in a separate
> function that can be reused. Future patches will replace the existing
> code with that function.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 32 ++++++++++++++++++++++++++++++++
>  fs/btrfs/ordered-data.h |  3 +++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4d9bb0dea9af..65f6409c1c9f 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -954,6 +954,38 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>  	return index;
>  }
>  
> +/*
> + * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
> + * ordered extents in it are run to completion.
> + *
> + * @tree:         IO tree used for locking out other users of the range
> + * @inode:        Inode whose ordered tree is to be searched
> + * @start:        Beginning of range to flush
> + * @end:          Last byte of range to lock
> + * @cached_state: If passed, will return the extent state responsible for the
> + * locked range. It's the caller's responsibility to free the cached state.
> + *
> + * This function always returns with the given range locked, ensuring after it's
> + * called no order extent can be pending.
> + */
> +void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
> +					struct inode *inode, u64 start, u64 end,
> +					struct extent_state **cached_state)
> +{

Please use btrfs_inode instead of inode for interfaces that are internal
to btrfs. This is not consistent but the plan is to switch everything to
btrfs_inode so new code should try to follow that.
