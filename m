Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D744342E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhKBQ7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:59:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34200 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhKBQ7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:59:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50E5F218A4;
        Tue,  2 Nov 2021 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635872235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSZNF6UEPqDEz+mMDSokDrznU4PSmpn55afdOhrv+Cg=;
        b=PEz6t8Y1LMzzwccvcFxAE3TY19f5aEEi4tO2kdEwkA9vtk18opwukrKoKiLfB02NJXLi0E
        cpY99sxwJ4ijE6Rnp0QfDo8IfolMU5euUoMMqTL55iXYREMaBWT0RtH7Vg60/xSZ9nD79Y
        vsjtkI8g+hVUnINAT0PHK+OtfjG/SKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635872235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSZNF6UEPqDEz+mMDSokDrznU4PSmpn55afdOhrv+Cg=;
        b=ze6/C7mGNpbGuOa7n4+ejTGrcseJpGUcdimcS8/T8/a0k7HROofBmjp222gdmYKkWPc5UA
        O0zv+gHaJ/T4aICw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B3F2A3B81;
        Tue,  2 Nov 2021 16:57:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05EDFDA7A9; Tue,  2 Nov 2021 17:56:39 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:56:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix ENOSPC failure when attempting direct IO
 write into NOCOW range
Message-ID: <20211102165639.GP20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 04:03:41PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a direct IO write against a file range that either has
> preallocated extents in that range or has regular extents and the file
> has the NOCOW attribute set, the write fails with -ENOSPC when all of
> the following conditions are met:
> 
> 1) There are no data blocks groups with enough free space matching
>    the size of the write;
> 
> 2) There's not enough unallocated space for allocating a new data block
>    group;
> 
> 3) The extents in the target file range are not shared, neither through
>    snapshots nor through reflinks.
> 
> This is wrong because a NOCOW write can be done in such case, and in fact
> it's possible to do it using a buffered IO write, since when failing to
> allocate data space, the buffered IO path checks if a NOCOW write is
> possible.
> 
> The failure in direct IO write path comes from the fact that early on,
> at btrfs_dio_iomap_begin(), we try to allocate data space for the write
> and if it that fails we return the error and stop - we never check if we
> can do NOCOW. But later, at btrfs_get_blocks_direct_write(), we check
> if we can do a NOCOW write into the range, or a subset of the range, and
> then release the previously reserved data space.
> 
> Fix this by doing the data reservation only if needed, when we must COW,
> at btrfs_get_blocks_direct_write() instead of doing it at
> btrfs_dio_iomap_begin(). This also simplifies a bit the logic and removes
> the inneficiency of doing unnecessary data reservations.
> 
> The following example test script reproduces the problem:
> 
>   $ cat dio-nocow-enospc.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdj
>   MNT=/mnt/sdj
> 
>   # Use a small fixed size (1G) filesystem so that it's quick to fill
>   # it up.
>   # Make sure the mixed block groups feature is not enabled because we
>   # later want to not have more space available for allocating data
>   # extents but still have enough metadata space free for the file writes.
>   mkfs.btrfs -f -b $((1024 * 1024 * 1024)) -O ^mixed-bg $DEV
>   mount $DEV $MNT
> 
>   # Create our test file with the NOCOW attribute set.
>   touch $MNT/foobar
>   chattr +C $MNT/foobar
> 
>   # Now fill in all unallocated space with data for our test file.
>   # This will allocate a data block group that will be full and leave
>   # no (or a very small amount of) unallocated space in the device, so
>   # that it will not be possible to allocate a new block group later.
>   echo
>   echo "Creating test file with initial data..."
>   xfs_io -c "pwrite -S 0xab -b 1M 0 900M" $MNT/foobar
> 
>   # Now try a direct IO write against file range [0, 10M[.
>   # This should succeed since this is a NOCOW file and an extent for the
>   # range was previously allocated.
>   echo
>   echo "Trying direct IO write over allocated space..."
>   xfs_io -d -c "pwrite -S 0xcd -b 10M 0 10M" $MNT/foobar
> 
>   umount $MNT
> 
> When running the test:
> 
>   $ ./dio-nocow-enospc.sh
>   (...)
> 
>   Creating test file with initial data...
>   wrote 943718400/943718400 bytes at offset 0
>   900 MiB, 900 ops; 0:00:01.43 (625.526 MiB/sec and 625.5265 ops/sec)
> 
>   Trying direct IO write over allocated space...
>   pwrite: No space left on device
> 
> A test case for fstests will follow, testing both this direct IO write
> scenario as well as the buffered IO write scenario to make it less likely
> to get future regressions on the buffered IO case.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
