Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FF49F90B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348374AbiA1MRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348333AbiA1MRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:17:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E2C061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 04:17:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E33B824CA
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 12:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9AC340E0;
        Fri, 28 Jan 2022 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643372267;
        bh=/u7/OIKET/+GYRoKIx+BffWw9g7CV2XR3OsvnKaXEWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/JW0H7e8xoAFje4rEtKDDdJngLTrXL5Eq8Q8vFpx8CW24VsLm40r2b1YByisx2Tf
         r/316KA1PQmOuf9YNJYzuROxCfwDjge/YWq6/bHXsDU+Pk+W25qUf2o9g2K84Ybs+T
         j4tC34hsGq4m28+wMeEsSbseSnUtcvVoeq4rd4YD3AabwYVieaIlCs7RMJrag1OYWl
         dyWag2LAD0Cy49JxQBvWkHkGcRV3FmWc1EN0fIQI90SVdnV4UIEXF2TrAijsJ2ddJx
         oVbsQVE6vab+Ex4NapNeElzubYQA6wqZHo1flcUdmECYEupP4LEMT/chbXapW7b+Eq
         MFn9JW7A9w1Pw==
Date:   Fri, 28 Jan 2022 12:17:44 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
Message-ID: <YfPe6EeJ3Tr0p0zq@debian9.Home>
References: <cover.1643354254.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643354254.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
> That function is reused between older kernels (v5.15) and the refactored
> defrag code (v5.16+).
> 
> However that function has one long existing bugs affecting defrag to
> handle preallocated range.
> 
> And it can not handle compressed extent well neither.
> 
> Finally there is an ambiguous check which doesn't make much sense by
> itself, and can be related by enhanced extent capacity check.
> 
> This series will fix all the 3 problem mentioned above.
> 
> Changelog:
> v2:
> - Use @extent_thresh from caller to replace the harded coded threshold
>   Now caller has full control over the extent threshold value.
> 
> - Remove the old ambiguous check based on physical address
>   The original check is too specific, only reject extents which are
>   physically adjacent, AND too large.
>   Since we have correct size check now, and the physically adjacent check
>   is not always a win.
>   So remove the old check completely.
> 
> v3:
> - Split the @extent_thresh and physicall adjacent check into other
>   patches
> 
> - Simplify the comment 
> 
> v4:
> - Fix the @em usage which should be @next.
>   As it will fail the submitted test case.
> 
> Qu Wenruo (3):
>   btrfs: defrag: don't try to merge regular extents with preallocated
>     extents
>   btrfs: defrag: don't defrag extents which is already at its max
>     capacity
>   btrfs: defrag: remove an ambiguous condition for rejection
> 
>  fs/btrfs/ioctl.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

There's something screwed up in the series:

$ b4 am cover.1643354254.git.wqu@suse.com
Looking up https://lore.kernel.org/r/cover.1643354254.git.wqu%40suse.com
Grabbing thread from lore.kernel.org/all/cover.1643354254.git.wqu%40suse.com/t.mbox.gz
Analyzing 5 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents with preallocated extents
    + Reviewed-by: Filipe Manana <fdmanana@suse.com>
  [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is already at its max capacity
  [PATCH v4 3/3] btrfs: defrag: remove an ambiguous condition for rejection
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 3
---
Cover: ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.cover
 Link: https://lore.kernel.org/r/cover.1643354254.git.wqu@suse.com
 Base: not specified
       git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mbx

$ git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mbx
Applying: btrfs: defrag: don't try to merge regular extents with preallocated extents
Applying: btrfs: defrag: don't defrag extents which is already at its max capacity
error: patch failed: fs/btrfs/ioctl.c:1229
error: fs/btrfs/ioctl.c: patch does not apply
Patch failed at 0002 btrfs: defrag: don't defrag extents which is already at its max capacity
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Trying to manually pick patches 1 by 1 from patchwork, also results in the
same failure when applying patch 2/3.

Not sure why it failed, but I was able to manually apply the diffs.

Thanks.

> 
> -- 
> 2.34.1
> 
