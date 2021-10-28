Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC143E705
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJ1RTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhJ1RTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 13:19:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FFC061745
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 10:16:42 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id n2so6459753qta.2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLmVwUgA8znqOLsoYAF5rHJbpEKhukz2wHzEsywQvcc=;
        b=2IgQdkCq3k/SJKN1bZPNB7Dum2oymObuAfJW3b9VgSOmg56YihR0VvoASlkZopVwmQ
         cFiucA//Br3Fc6nUgalrI+df9MfWu4+koCCm3VtQ+C5DCTdO1JJQPZDM8TSYD0REUjMO
         v08uOkuCA8bfsGhYfPkYdKFA+N1Z/GRag1BkSMDRPgkZSBrCZXNi7H7EYmjP5ApUbq3m
         Bbj9OwfTbgjok5o5Pw7YTqGrcXEo2fRtEYc/NXuif1TJI3w3SGayNFbCn/1gJC5zx+yl
         EnVXy9hxSvgQqriqREYnxYRTlebECi0QC6ChGTnFfj5fkV9cEtHCamXI3flcxZJczP6y
         1DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLmVwUgA8znqOLsoYAF5rHJbpEKhukz2wHzEsywQvcc=;
        b=oHOgwDED9RTOVWNnPvq6RN0GjTEEAu+vRYQ3ZCM3WMCLaW2S78+esiUnDjdfNKLZ8A
         C9PExoOhkE9kQy12z5jqbz94DJZDjl3KcWKoK4Jm4xSTl2ffi24RJTeABed9pcJQTmIU
         +xhzSWDYPallSCTx6F1bgiewgXr0kdH+sNZH3D/P5BhJDEesxKVomA5qM4W7pMKuY0IZ
         RgTEFEMiG75lEfz0XPKWM2xHiDkLQN+EGk3Mprt/V/5nGDcPHxFYXUlx5S26naD5dMhs
         cF8AEt/iHEuOjzLVDUKMcSFl8bbzoGvHi+7+7YVKwFudgvsMLqIKABFUl0Na4ZGZlVXu
         0YLA==
X-Gm-Message-State: AOAM533+K+DSNpH/bO7ub6tjBrQRchs95j29GJPH4XpGoAC+TW5FhSYI
        PthclrQ40lFArqea1lsgwS1fWQ==
X-Google-Smtp-Source: ABdhPJyP1DuDyfMy9cTGon7RcvKAI9HW6QNkVEQPjSY4qAKc8LwdpM0wqOYnFBgqBv5R8NSk10t18A==
X-Received: by 2002:a05:622a:58e:: with SMTP id c14mr2303835qtb.225.1635441400652;
        Thu, 28 Oct 2021 10:16:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z15sm2461882qtw.85.2021.10.28.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:16:40 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:16:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix ENOSPC failure when attempting direct IO
 write into NOCOW range
Message-ID: <YXra9hVsx8+EGol4@localhost.localdomain>
References: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b432f82ad45a829a9712a15e1684f2e85c82ea.1635433374.git.fdmanana@suse.com>
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

This makes me nervous because now we're holding the extent lock while doing
space reservations.  It's safe here because we make sure there's no pagecache
after we've locked the range, so I can't imagine a scenario where we would
deadlock, but my lack of imagination doesn't keep problems from happening.  As
it stands I have no strong objections, but it would make me feel better if you
hammered on this a bunch to make sure there's no dark corner we're missing.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
