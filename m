Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB75546377
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfFNP4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 11:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNP4q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 11:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AC62AC5A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 15:56:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87F6ADA8D1; Fri, 14 Jun 2019 17:57:35 +0200 (CEST)
Date:   Fri, 14 Jun 2019 17:57:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix false ENOSPC alert by tracking used
 space correctly
Message-ID: <20190614155735.GB19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190524233243.4780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524233243.4780-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 25, 2019 at 07:32:43AM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report of unexpected ENOSPC from btrfs-convert.
> https://github.com/kdave/btrfs-progs/issues/123#
> 
> After some debug, even when we have enough unallocated space, we still
> hit ENOSPC at btrfs_reserve_extent().
> 
> [CAUSE]
> Btrfs-progs relies on chunk preallocator to make enough space for
> data/metadata.
> 
> However after the introduction of delayed-ref, it's no longer reliable
> to relie on btrfs_space_info::bytes_used and
> btrfs_space_info::bytes_pinned to calculate used metadata space.
> 
> For a running transaction with a lot of allocated tree blocks,
> btrfs_space_info::bytes_used stays its original value, and will only be
> updated when running delayed ref.
> 
> This makes btrfs-progs chunk preallocator completely useless. And for
> btrfs-convert/mkfs.btrfs --rootdir, if we're going to have enough
> metadata to fill a metadata block group in one transaction, we will hit
> ENOSPC no matter whether we have enough unallocated space.
> 
> [FIX]
> This patch will introduce btrfs_space_info::bytes_reserved to trace how
> many space we have reserved but not yet committed to extent tree.
> 
> To support this change, this commit also introduces the following
> modification:
> - More comment on btrfs_space_info::bytes_*
>   To make code a little easier to read
> 
> - Export update_space_info() to preallocate empty data/metadata space
>   info for mkfs.
>   For mkfs, we only have a temporary fs image with SYSTEM chunk only.
>   Export update_space_info() so that we can preallocate empty
>   data/metadata space info before we start a transaction.
> 
> - Proper btrfs_space_info::bytes_reserved update
>   The timing is the as kernel (except we don't need to update
>   bytes_reserved for data extents)
>   * Increase bytes_reserved when call alloc_reserved_tree_block()
>   * Decrease bytes_reserved when running delayed refs
>     With the help of head->must_insert_reserved to determine whether we
>     need to decrease.
> 
> Issue: #123
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
