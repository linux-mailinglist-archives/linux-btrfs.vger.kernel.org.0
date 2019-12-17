Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5480D122F76
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 15:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLQOzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 09:55:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfLQOzp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 09:55:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E46BDAD14;
        Tue, 17 Dec 2019 14:55:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D424DA81D; Tue, 17 Dec 2019 15:55:42 +0100 (CET)
Date:   Tue, 17 Dec 2019 15:55:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191217145541.GE3929@suse.cz>
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

v6 passed fstests, with some weird test failures that don't seem to be
related to the patchset.

Meanwhile I did manual test how the discard behaves. The workload was
a series of linux git checkouts of various release tags (ie. this should
provide some freed extents and coalesce them eventually to get larger
chunks to discard), then a simple large file copy, sync, remove, sync.

The discards going down to the device were followin the maximum default
size (64M) but I observed that only one range was discarded per 10
seconds, while the other stats there are many more extents to discard.

For the large file it took like 5-10 cycles to send all the trimmed
ranges, the discardable_extents decreased by one each time until it
reached ... -1. At this point the discardable bytes were -16384, so
thre's some accounting problem.

This happened also when I deleted everything from the filesystem and ran
full balance.

Regarding the slow io submission, I tried to increase the iops value,
default was 10, but 100 and 1000 made no change. Increasing the maximum
discard request size to 128M worked (when there was such long extent
ready). I was expecting a burst of like 4 consecutive IOs after a 600MB
file is deleted.  I did not try to tweak bps_limit because there was
nothing to limit.

So this is something to fix but otherwise the patchset seems to be ok
for adding to misc-next. Due to the timing of the end of the year and
that we're already at rc2, this will be the main feature in 5.6.
