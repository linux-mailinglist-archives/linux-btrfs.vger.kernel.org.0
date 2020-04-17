Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB41ADBD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 13:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgDQLDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 07:03:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgDQLDw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 07:03:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45275AA55;
        Fri, 17 Apr 2020 11:03:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE963DA727; Fri, 17 Apr 2020 13:03:09 +0200 (CEST)
Date:   Fri, 17 Apr 2020 13:03:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200417110309.GO5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:46:10PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This is version 2 of my series of fixes, cleanups, and improvements to
> direct I/O and read repair. It's preparation for adding read repair to
> my RWF_ENCODED series [1], but it can go in independently.
> 
> Patch 1 adds a new bio helper needed for patch 4. Patches 2 and 3 are
> direct I/O error handling fixes. Patch 4 is a buffered read repair fix.
> Patch 5 is a buffered read repair improvement. Patches 6-9 are trivial
> cleanups. Patch 10 converts direct I/O to use refcount_t, which would've
> helped catch the bug fixed by patch 2. Patches 11-14 drastically
> simplify the direct I/O code. Patch 15 unifies buffered and direct I/O
> read repair, which also makes direct I/O repair actually do validation
> for large failed reads instead of rewriting the whole thing.
> 
> Overall, this is net about -350 lines of code and actually makes direct
> I/O more functional.
> 
> Note that this series causes btrfs/142 to fail. This is a bug in the
> test, as it assumes that direct I/O doesn't do read validation. This is
> fixed by the fstests patch "btrfs/14{2,3}: use dm-dust instead of
> fail_make_request" which I sent up yesterday [2].
> 
> Jens and Christoph are cc'd for patches 1 and 4. Instead of looking at
> the bio internals like I did in v1, I added a new
> bio_for_each_bvec_all() helper.
> 
> Changes from v1 [3]:
> 
> * Added patch 1 with bio_for_each_bvec_all() helper
> * Dropped patch 8 which moved struct definition
> * Fixed performance regression [4] in patch 13 caused by accidentally
>   making all direct I/O submission asynchronous
> * Fixed uninitialized assert in patch 12
> * Fixed misplaced assert in btrfs_check_read_dio_bio in patch 13
> * Added reviewed-bys
> * Refactored btrfs_submit_direct() and btrfs_submit_direct_hook() in
>   patch 2 (I didn't add Nikolay's reviewed-by to that one because the
>   new patch looks fairly different from patch 1 in v1)
> * Rewrapped csum calculations in patch 10 for easier readability
> * Clarified several commit messages and comments

Thanks, I haven't read the changes yet but fstests passed. There are
some conflicts with the dio-iomap patches, all seem to be in the
expected range and solvable.
