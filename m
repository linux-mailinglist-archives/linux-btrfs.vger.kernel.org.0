Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF116D7725
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfJONMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 09:12:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728372AbfJONMH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 09:12:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6696B419;
        Tue, 15 Oct 2019 13:12:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7958BDA7E3; Tue, 15 Oct 2019 15:12:17 +0200 (CEST)
Date:   Tue, 15 Oct 2019 15:12:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/19] btrfs: track discardable extents for asnyc discard
Message-ID: <20191015131217.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:39PM -0400, Dennis Zhou wrote:
> The number of discardable extents will serve as the rate limiting metric
> for how often we should discard. This keeps track of discardable extents
> in the free space caches by maintaining deltas and propagating them to
> the global count.
> 
> This also setups up a discard directory in btrfs sysfs and exports the
> total discard_extents count.

Please put the discard directory under debug/ for now.

> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h            |  2 +
>  fs/btrfs/discard.c          |  2 +
>  fs/btrfs/discard.h          | 19 ++++++++
>  fs/btrfs/free-space-cache.c | 93 ++++++++++++++++++++++++++++++++++---
>  fs/btrfs/free-space-cache.h |  2 +
>  fs/btrfs/sysfs.c            | 33 +++++++++++++
>  6 files changed, 144 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c328d2e85e4d..43e515939b9c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -447,6 +447,7 @@ struct btrfs_discard_ctl {
>  	spinlock_t lock;
>  	struct btrfs_block_group_cache *cache;
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> +	atomic_t discard_extents;

At the end of the series this becomes

452         atomic_t discard_extents;
453         atomic64_t discardable_bytes;
454         atomic_t delay;
455         atomic_t iops_limit;
456         atomic64_t bps_limit;
457         atomic64_t discard_extent_bytes;
458         atomic64_t discard_bitmap_bytes;
459         atomic64_t discard_bytes_saved;

raising many eyebrows. What's the reason to use so many atomics? As this
is purely for accounting and perhaps not contended, add one spinlock
protecting all of them.

None of delay, bps_limit and iops_limit use the atomict_t semantics at
all, it's just _set and _read.

As this seem to cascade to all other patches, I'll postpone my review
until I see V2.
