Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F91599FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgBKTpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 14:45:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:42306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbgBKTpt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 14:45:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BAFCB3CA;
        Tue, 11 Feb 2020 19:45:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1B96DA703; Tue, 11 Feb 2020 20:45:12 +0100 (CET)
Date:   Tue, 11 Feb 2020 20:45:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race between shrinking truncate and fiemap
Message-ID: <20200211194511.GJ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207122309.17209-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207122309.17209-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 12:23:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When there is a fiemap executing in parallel with a shrinking truncate we
> can end up in a situation where we have extent maps for which we no longer
> have corresponding file extent items. This is generally harmless and at
> the moment the only consequences are missing file extent items representing
> holes after we expand the file size again after the truncate operation
> removed the prealloc extent items, and stale information for future fiemap
> calls (reporting extents that no longer exist or may have been reallocated
> to other files for example).
> 
> Consider the following example:
> 
> 1) Our inode has a size of 128Kb, one 128Kb extent at file offset 0 and
>    a 1Mb prealloc extent at file offset 128Kb;
> 
> 2) Task A starts doing a shrinking truncate of our inode to reduce it to
>    a size of 64Kb. Before it searches the subvolume tree for file extent
>    items to delete, it drops all the extent maps in the range from 64Kb
>    to (u64)-1 by calling btrfs_drop_extent_cache();
> 
> 3) Task B starts doing a fiemap against our inode. When looking up for the
>    inode's extent maps in the range from 128Kb to (u64)-1, it doesn't find
>    any in the inode's extent map tree, since they were removed by task A.
>    Because it didn't find any in the extent map tree, it scans the inode's
>    subvolume tree for file extent items, and it finds the 1Mb prealloc
>    extent at file offset 128Kb, then it creates an extent map based on
>    that file extent item and adds it to inode's extent map tree (this ends
>    up being done by btrfs_get_extent() <- btrfs_get_extent_fiemap() <-
>    get_extent_skip_holes());
> 
> 4) Task A then drops the prealloc extent at file offset 128Kb and shrinks
>    the 128Kb extent file offset 0 to a length of 64Kb. The truncation
>    operation finishes and we end up with an extent map representing a 1Mb
>    prealloc extent at file offset 128Kb, despite we don't have any more
>    that extent;
> 
> After this the two types of problems we have are:
> 
> 1) Future calls to fiemap always report that a 1Mb prealloc extent exists
>    at file offset 128Kb. This is stale information, no longer correct;
> 
> 2) If the size of the file is increased, by a truncate operation that
>    increases the file size or by a write into a file offset > 64Kb for
>    example, we end up not inserting file extent items to represent
>    holes for any range between 128Kb and 128Kb + 1Mb, since the hole
>    expansion function, btrfs_cont_expand() will skip hole insertion
>    for any range for which an extent map exists that represents a
>    prealloc extent. This causes fsck to complain about missing file
>    extent items when not using the NO_HOLES feature.
> 
> The second issue could be often triggered by test case generic/561 from
> fstests, which runs fsstress and duperemove in parallel, and duperemove
> does frequent fiemap calls.
> 
> Essentially the problems happens because fiemap does not acquire the
> inode's lock while truncate does, and fiemap locks the file range in the
> inode's iotree while truncate does not. So fix the issue by making
> btrfs_truncate_inode_items() lock the file range from the new file size
> to (u64)-1, so that it serializes with fiemap.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
