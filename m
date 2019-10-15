Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72452D77B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfJONvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 09:51:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728652AbfJONvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 09:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98972B437;
        Tue, 15 Oct 2019 13:51:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3291DA7E3; Tue, 15 Oct 2019 15:52:00 +0200 (CEST)
Date:   Tue, 15 Oct 2019 15:52:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: qgroup: Always free PREALLOC META reserve in
 btrfs_delalloc_release_extents()
Message-ID: <20191015135200.GY2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20191014063451.37343-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014063451.37343-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 02:34:51PM +0800, Qu Wenruo wrote:
> [Background]
> Btrfs qgroup uses two types of reserved space for METADATA space,
> PERTRANS and PREALLOC.
> 
> PERTRANS is metadata space reserved for each transaction started by
> btrfs_start_transaction().
> While PREALLOC is for delalloc, where we reserve space before joining a
> transaction, and finally it will be converted to PERTRANS after the
> writeback is done.
> 
> [Inconsistency]
> However there is inconsistency in how we handle PREALLOC metadata space.
> 
> The most obvious one is:
> In btrfs_buffered_write():
> 	btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes, true);
> 
> We always free qgroup PREALLOC meta space.
> 
> While in btrfs_truncate_block():
> 	btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, (ret != 0));
> 
> We only free qgroup PREALLOC meta space when something went wrong.
> 
> [The Correct Behavior]
> The correct behavior should be the one in btrfs_buffered_write(), we
> should always free PREALLOC metadata space.
> 
> The reason is, the btrfs_delalloc_* mechanism works by:
> - Reserve metadata first, even it's not necessary
>   In btrfs_delalloc_reserve_metadata()
> 
> - Free the unused metadata space
>   Normally in:
>   btrfs_delalloc_release_extents()
>   |- btrfs_inode_rsv_release()
>      Here we do calculation on whether we should release or not.
> 
> E.g. for 64K buffered write, the metadata rsv works like:
> 
> /* The first page */
> reserve_meta:	num_bytes=calc_inode_reservations()
> free_meta:	num_bytes=0
> total:		num_bytes=calc_inode_reservations()
> /* The first page caused one outstanding extent, thus needs metadata
>    rsv */
> 
> /* The 2nd page */
> reserve_meta:	num_bytes=calc_inode_reservations()
> free_meta:	num_bytes=calc_inode_reservations()
> total:		not changed
> /* The 2nd page doesn't cause new outstanding extent, needs no new meta
>    rsv, so we free what we have reserved */
> 
> /* The 3rd~16th pages */
> reserve_meta:	num_bytes=calc_inode_reservations()
> free_meta:	num_bytes=calc_inode_reservations()
> total:		not changed (still space for one outstanding extent)
> 
> This means, if btrfs_delalloc_release_extents() determines to free some
> space, then those space should be freed NOW.
> So for qgroup, we should call btrfs_qgroup_free_meta_prealloc() other
> than btrfs_qgroup_convert_reserved_meta().
> 
> The good news is:
> - The callers are not that hot
>   The hottest caller is in btrfs_buffered_write(), which is already
>   fixed by commit 336a8bb8e36a ("btrfs: Fix wrong
>   btrfs_delalloc_release_extents parameter"). Thus it's not that
>   easy to cause false EDQUOT.
> 
> - The trans commit in advance for qgroup would hide the bug
>   Since commit f5fef4593653 ("btrfs: qgroup: Make qgroup async transaction
>   commit more aggressive"), when btrfs qgroup metadata free space is slow,
>   it will try to commit transaction and free the wrongly converted
>   PERTRANS space, so it's not that easy to hit such bug.
> 
> [FIX]
> So to fix the problem, remove the @qgroup_free parameter for
> btrfs_delalloc_release_extents(), and always pass true to
> btrfs_inode_rsv_release().
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 43b18595d660 ("btrfs: qgroup: Use separate meta reservation type for delalloc")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to 5.4 queue, thanks. I'll add tag for stable 4.19, though there
are conflicts, not even it's applicable on top of 5.3.
