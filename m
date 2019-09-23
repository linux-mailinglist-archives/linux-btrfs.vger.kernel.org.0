Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08EBBA16
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502047AbfIWRAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 13:00:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388187AbfIWRAm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 13:00:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07D75B0DA;
        Mon, 23 Sep 2019 17:00:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F00BCDA871; Mon, 23 Sep 2019 19:01:01 +0200 (CEST)
Date:   Mon, 23 Sep 2019 19:01:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Message-ID: <20190923170101.GM2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190923140525.14246-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 10:05:16AM -0400, Josef Bacik wrote:
> v1->v2:
> - renamed find_delalloc_range to btrfs_find_delalloc_range for now.
> 
> -- Original email --
> 
> Currently extent_io.c includes all of the extent-io-tree code, the extent buffer
> code, the code to do IO on extent buffers and data extents, as well as a bunch
> of other random stuff.  The random stuff just needs to be cleaned up, and is
> probably too invasive for this point in the development cycle.  Instead I simply
> tackled moving the big obvious things out into their own files.  I will follow
> up with cleanups for the rest of the stuff, but those can probably wait until
> the next cycle as they are going to be slightly more risky.  As usual I didn't
> try to change anything, I simply moved code around.  Any time I needed to make
> actual changes to functions I made a separate patch for that work, so for
> example breaking up the init/exit functions for extent-io-tree.  Everything else
> is purely cut and paste into new files.  The diffstat is as follows
> 
>  fs/btrfs/Makefile         |    3 +-
>  fs/btrfs/ctree.h          |    3 +-
>  fs/btrfs/disk-io.h        |    2 +
>  fs/btrfs/extent-buffer.c  | 1266 ++++++++
>  fs/btrfs/extent-buffer.h  |  152 +
>  fs/btrfs/extent-io-tree.c | 1955 ++++++++++++
>  fs/btrfs/extent-io-tree.h |  248 ++
>  fs/btrfs/extent_io.c      | 7555 +++++++++++++--------------------------------
>  fs/btrfs/extent_io.h      |  372 +--
>  fs/btrfs/super.c          |   16 +-
>  10 files changed, 5843 insertions(+), 5729 deletions(-)

I got some strange merge conflicts, it turns out patch 6/9 did not make
it to the mailinglist (nor patchwork where I could pick it eventually).
For that it's useful to have the list of commits too along with the
diffstat, ie. what format-patch generates.
