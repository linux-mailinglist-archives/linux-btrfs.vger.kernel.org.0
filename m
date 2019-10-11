Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EED4781
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJKSXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728472AbfJKSXf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:23:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BB5AAD46;
        Fri, 11 Oct 2019 18:23:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9E39DA808; Fri, 11 Oct 2019 20:23:46 +0200 (CEST)
Date:   Fri, 11 Oct 2019 20:23:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] Btrfs: fix negative subv_writers counter and data
 space leak after buffered write
Message-ID: <20191011182345.GG2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
References: <20191009164422.7202-1-fdmanana@kernel.org>
 <20191011154120.5547-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011154120.5547-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 04:41:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a buffered write it's possible to leave the subv_writers
> counter of the root, used for synchronization between buffered nocow
> writers and snapshotting. This happens in an exceptional case like the
> following:
> 
> 1) We fail to allocate data space for the write, since there's not
>    enough available data space nor enough unallocated space for allocating
>    a new data block group;
> 
> 2) Because of that failure, we try to go to NOCOW mode, which succeeds
>    and therefore we set the local variable 'only_release_metadata' to true
>    and set the root's sub_writers counter to 1 through the call to
>    btrfs_start_write_no_snapshotting() made by check_can_nocow();
> 
> 3) The call to btrfs_copy_from_user() returns zero, which is very unlikely
>    to happen but not impossible;
> 
> 4) No pages are copied because btrfs_copy_from_user() returned zero;
> 
> 5) We call btrfs_end_write_no_snapshotting() which decrements the root's
>    subv_writers counter to 0;
> 
> 6) We don't set 'only_release_metadata' back to 'false' because we do
>    it only if 'copied', the value returned by btrfs_copy_from_user(), is
>    greater than zero;
> 
> 7) On the next iteration of the while loop, which processes the same
>    page range, we are now able to allocate data space for the write (we
>    got enough data space released in the meanwhile);
> 
> 8) After this if we fail at btrfs_delalloc_reserve_metadata(), because
>    now there isn't enough free metadata space, or in some other place
>    further below (prepare_pages(), lock_and_cleanup_extent_if_need(),
>    btrfs_dirty_pages()), we break out of the while loop with
>    'only_release_metadata' having a value of 'true';
> 
> 9) Because 'only_release_metadata' is 'true' we end up decrementing the
>    root's subv_writers counter to -1 (through a call to
>    btrfs_end_write_no_snapshotting()), and we also end up not releasing the
>    data space previously reserved through btrfs_check_data_free_space().
>    As a consequence the mechanism for synchronizing NOCOW buffered writes
>    with snapshotting gets broken.
> 
> Fix this by always setting 'only_release_metadata' to false at the start
> of each iteration.
> 
> Fixes: 8257b2dc3c1a10 ("Btrfs: introduce btrfs_{start, end}_nocow_write() for each subvolume")
> Fixes: 7ee9e4405f264e ("Btrfs: check if we can nocow if we don't have data space")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Moved assignment of false to only_release_metadata to the beginning of
>     loop instead. And another "Fixes:" tag that corresponds to the data
>     space leak, since the other if for counter dropping to -1 bug.

V2 looks better indeed. I'll add a stable tag but will not queue the
patch for 5.4-rc due to 3) and otherwise low chances to hit the problem.
Thanks.
