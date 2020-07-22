Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F842229CBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgGVQDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 12:03:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgGVQDy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 12:03:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62105ADAD;
        Wed, 22 Jul 2020 16:04:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05466DA70B; Wed, 22 Jul 2020 18:03:27 +0200 (CEST)
Date:   Wed, 22 Jul 2020 18:03:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        holger@applied-asynchrony.com
Subject: Re: [PATCH 1/2] btrfs: kill update_block_group_flags
Message-ID: <20200722160327.GA3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        holger@applied-asynchrony.com
References: <20200630181719.3190860-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630181719.3190860-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 30, 2020 at 02:17:18PM -0400, Josef Bacik wrote:
> btrfs/061 has been failing consistently for me recently with a
> transaction abort.  We run out of space in the system chunk array, which
> means we've allocated way too many system chunks than we need.
> 
> Chris added this a long time ago for balance as a poor mans restriping.
> If you had a single disk and then added another disk and then did a
> balance, update_block_group_flags would then figure out which RAID level
> you needed.
> 
> Fast forward to today and we have restriping behavior, so we can
> explicitly tell the fs that we're trying to change the raid level.  This
> is accomplished through the normal get_alloc_profile path.
> 
> Furthermore this code actually causes btrfs/061 to fail, because we do
> things like mkfs -m dup -d single with multiple devices.  This trips
> this check
> 
> alloc_flags = update_block_group_flags(fs_info, cache->flags);
> if (alloc_flags != cache->flags) {
> 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> 
> in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, but
> not actually restriping, we keep forcing chunk allocation of RAID1
> chunks.  This eventually causes us to run out of system space and the
> file system aborts and flips read only.
> 
> We don't need this poor mans restriping any more, simply use the normal
> get_alloc_profile helper, which will get the correct alloc_flags and
> thus make the right decision for chunk allocation.  This keeps us from
> allocating a billion system chunks and falling over.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

1 and 2 added to misc-next. I haven't found time to verify the raid1c34
case, but Holger reported it had fixed some problems for him I take
that as testing.
