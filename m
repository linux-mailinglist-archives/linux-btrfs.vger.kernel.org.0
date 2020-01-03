Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB612F958
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgACOvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 09:51:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:37480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACOvg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 09:51:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 620C7ACB1;
        Fri,  3 Jan 2020 14:51:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 302F1DA795; Fri,  3 Jan 2020 15:51:26 +0100 (CET)
Date:   Fri, 3 Jan 2020 15:51:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200103145125.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 02, 2020 at 04:26:34PM -0500, Dennis Zhou wrote:
> Hello,
> 
> Dave applied 1-12 from v6 [1]. This is a follow up cleaning up the
> remaining 10 patches adding 2 more to deal with a rare -1 [2] that I
> haven't quite figured out how to repro. This is also available at [3].
> 
> This series is on top of btrfs-devel#misc-next-with-discard-v6 0c7be920bd7d.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1576195673.git.dennis@kernel.org/
> [2] https://lore.kernel.org/linux-btrfs/20191217145541.GE3929@suse.cz/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/misc.git/log/?h=async-discard
> 
> Dennis Zhou (12):
>   btrfs: calculate discard delay based on number of extents
>   btrfs: add bps discard rate limit for async discard
>   btrfs: limit max discard size for async discard
>   btrfs: make max async discard size tunable
>   btrfs: have multiple discard lists
>   btrfs: only keep track of data extents for async discard
>   btrfs: keep track of discard reuse stats
>   btrfs: add async discard header
>   btrfs: increase the metadata allowance for the free_space_cache
>   btrfs: make smaller extents more likely to go into bitmaps
>   btrfs: ensure removal of discardable_* in free_bitmap()
>   btrfs: add correction to handle -1 edge case in async discard

Besides the changes posted to the patches, I did more style cleanups and
formatting adjustments as I went through the patches. I'll do some
testing again to be sure there are no bugs introduced by that, but
otherwise the patchset can be considered merged to misc-next. I'll push
the branch today.

It's a lot of new code but I was able to comprehend what's going on,
great that there's the patch adding implementation overview.
As the feature is not on by default and requires "special" hardware, it
should be safe, basisc tests passed so now we're left with the hard bugs
and corner cases. Thanks.
