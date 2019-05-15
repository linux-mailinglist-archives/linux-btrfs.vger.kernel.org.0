Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1951F643
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEOOPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 10:15:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfEOOPG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 10:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F658AF1A;
        Wed, 15 May 2019 14:15:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6C13DA866; Wed, 15 May 2019 16:16:05 +0200 (CEST)
Date:   Wed, 15 May 2019 16:16:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
Message-ID: <20190515141605.GQ3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190402180956.28893-1-jeffm@suse.com>
 <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 03, 2019 at 10:38:09PM -0400, Jeff Mahoney wrote:
> On 4/2/19 3:19 PM, Filipe Manana wrote:
> > On Tue, Apr 2, 2019 at 7:29 PM <jeffm@suse.com> wrote:
> >>
> >> From: Jeff Mahoney <jeffm@suse.com>
> >>
> >> When repairing the extent tree, it's possible for delayed extents to
> >> be created when running btrfs_write_dirty_block_groups.  We run
> >> delayed refs one last time in the kernel but that is missing in
> >> the userspace tools.
> >>
> >> That results in delayed refs getting dropped on the floor, the extent
> >> records not getting created, and in the next tranaction, when the
> >> extent tree is CoW'd again, we hit the BUG_ON when we can't find
> >> the extent record.
> >>
> >> We can fix this by running the delayed refs after writing out the
> >> dirty block groups.
> >>
> >> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> >> ---
> >>  transaction.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/transaction.c b/transaction.c
> >> index e756db33..2f19e9c8 100644
> >> --- a/transaction.c
> >> +++ b/transaction.c
> >> @@ -194,6 +194,8 @@ commit_tree:
> >>         ret = btrfs_run_delayed_refs(trans, -1);
> >>         BUG_ON(ret);
> >>         btrfs_write_dirty_block_groups(trans);
> >> +       ret = btrfs_run_delayed_refs(trans, -1);
> >> +       BUG_ON(ret);
> > 
> > And running delayed refs can dirty more block groups as well.
> > At this point shouldn't we loop running delayed refs until no more
> > dirty block groups exist? Just like in the kernel.
> 
> Right.  This is another argument for code sharing between the kernel and
> userspace.

Sharing code in this function would be really hard, I've implemented the
loop in commit in progs.
