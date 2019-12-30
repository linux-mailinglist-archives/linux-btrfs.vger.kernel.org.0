Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69ED12D334
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfL3SN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 13:13:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:43308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfL3SN1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 13:13:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5245AAD45;
        Mon, 30 Dec 2019 18:13:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF2E0DA790; Mon, 30 Dec 2019 19:13:18 +0100 (CET)
Date:   Mon, 30 Dec 2019 19:13:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191230181318.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:09PM -0800, Dennis Zhou wrote:
> Hello,
> 
> Dave reported a lockdep issue [1]. I'm a bit surprised as I can't repro
> it, but it obviously is right. I believe I fixed the issue by moving the
> fully trimmed check outside of the block_group lock.  I mistakingly
> thought the btrfs_block_group lock subsumed btrfs_free_space_ctl
> tree_lock. This clearly isn't the case.
> 
> Changes in v6:
>  - Move the fully trimmed check outside of the block_group lock.
> 
> v5 is available here: [2].
> 
> This series is on top of btrfs-devel#misc-next 7ee98bb808e2 + [3] and
> [4].
> 
> [1] https://lore.kernel.org/linux-btrfs/20191210140438.GU2734@twin.jikos.cz/
> [2] https://lore.kernel.org/linux-btrfs/cover.1575919745.git.dennis@kernel.org/
> [3] https://lore.kernel.org/linux-btrfs/d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org/
> [4] https://lore.kernel.org/linux-btrfs/20191209193846.18162-1-dennis@kernel.org/
> 
> Dennis Zhou (22):
>   bitmap: genericize percpu bitmap region iterators
>   btrfs: rename DISCARD opt to DISCARD_SYNC
>   btrfs: keep track of which extents have been discarded
>   btrfs: keep track of cleanliness of the bitmap
>   btrfs: add the beginning of async discard, discard workqueue
>   btrfs: handle empty block_group removal
>   btrfs: discard one region at a time in async discard
>   btrfs: add removal calls for sysfs debug/
>   btrfs: make UUID/debug have its own kobject
>   btrfs: add discard sysfs directory
>   btrfs: track discardable extents for async discard
>   btrfs: keep track of discardable_bytes
>   btrfs: calculate discard delay based on number of extents
>   btrfs: add bps discard rate limit
>   btrfs: limit max discard size for async discard
>   btrfs: make max async discard size tunable
>   btrfs: have multiple discard lists
>   btrfs: only keep track of data extents for async discard
>   btrfs: keep track of discard reuse stats
>   btrfs: add async discard header
>   btrfs: increase the metadata allowance for the free_space_cache
>   btrfs: make smaller extents more likely to go into bitmaps

Patches 1-12 merged to a temporary misc-next but I haven't pushed it as
misc-next yet (it's misc-next-with-discard-v6 in my github repo). There
are some comments to patch 13 and up so please send them either as
replies or as a shorter series. Thanks.
