Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB7307454
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhA1LDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:03:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:46576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhA1LDB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:03:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7EC1ABC4;
        Thu, 28 Jan 2021 11:02:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C8B2DA7D9; Thu, 28 Jan 2021 12:00:30 +0100 (CET)
Date:   Thu, 28 Jan 2021 12:00:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
Message-ID: <20210128110030.GJ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>, nborisov@suse.com
References: <20210127135728.30276-1-mrostecki@suse.de>
 <CAL3q7H7H93dmmxGKwSiJfG4NaikFLoAxNJAWR-ZazvWN6n5_fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7H93dmmxGKwSiJfG4NaikFLoAxNJAWR-ZazvWN6n5_fw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 10:38:45AM +0000, Filipe Manana wrote:
> On Thu, Jan 28, 2021 at 12:01 AM Michal Rostecki <mrostecki@suse.de> wrote:
> >
> > From: Michal Rostecki <mrostecki@suse.com>
> >
> > Before this change, the btrfs_get_io_geometry() function was calling
> > btrfs_get_chunk_map() to get the extent mapping, necessary for
> > calculating the I/O geometry. It was using that extent mapping only
> > internally and freeing the pointer after its execution.
> >
> > That resulted in calling btrfs_get_chunk_map() de facto twice by the
> > __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> > first and then calling btrfs_get_chunk_map() directly to get the extent
> > mapping, used by the rest of the function.
> >
> > This change fixes that by passing the extent mapping to the
> > btrfs_get_io_geometry() function as an argument.
> >
> > v2:
> > When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> > - Use errno_to_blk_status(PTR_ERR(em)) as the status
> > - Set em to NULL
> >
> > Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> I think this is a fine optimization.
> For very large filesystems, i.e. several thousands of allocated
> chunks, not only this avoids searching two times the rbtree,
> saving time, it may also help reducing contention on the lock that
> protects the tree - thinking of writeback starting for multiple
> inodes,
> other tasks allocating or removing chunks, and anything else that
> requires access to the rbtree.

This should answer Nikolay's concerns if shifting around the parameters
is worth it. Caching values that could be expensive to read makes sense
to me and it's not that intrusive in the code. I'll add your analysis to
the changelog and incorporate the fixups that Nikolay suggested in v1.
Thanks.
