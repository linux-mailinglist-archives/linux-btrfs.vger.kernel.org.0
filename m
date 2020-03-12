Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF64183AAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Mar 2020 21:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCLUgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Mar 2020 16:36:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLUgv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Mar 2020 16:36:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2C15AD31;
        Thu, 12 Mar 2020 20:36:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD7B9DA7A7; Thu, 12 Mar 2020 21:36:24 +0100 (CET)
Date:   Thu, 12 Mar 2020 21:36:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Optimise space flushing machinery
Message-ID: <20200312203624.GJ12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200310090035.16676-1-nborisov@suse.com>
 <e66667cb-7be0-9d26-f462-d6094b892cde@toxicpanda.com>
 <412a6539-66b4-1497-d9ee-d6b2d14c4a14@suse.com>
 <b98c152e-f167-f4ee-dfa9-fc2185ab47b1@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b98c152e-f167-f4ee-dfa9-fc2185ab47b1@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 01:59:14PM -0400, Josef Bacik wrote:
> >>>        u64 to_reclaim = 0;
> >>>
> >>> -    list_for_each_entry(ticket, &space_info->tickets, list)
> >>> -        to_reclaim += ticket->bytes;
> >>> -    list_for_each_entry(ticket, &space_info->priority_tickets, list)
> >>> -        to_reclaim += ticket->bytes;
> >>> +    lockdep_assert_held(&space_info->lock);
> >>> +
> >>> +    if (space_info->reclaim_size)
> >>> +        return space_info->reclaim_size;
> >>
> >> This undoes the fix that I put up making sure we include any space we
> >> can no longer overcommit.  Thanks,
> > 
> > Which fix is that?
> 
> https://github.com/kdave/btrfs-devel/commit/593212a6137ff3c5674609b4233f8ecec459dc45

Nik sent me a fixup, now folded to the patch.

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9c36397b733c..0884dac883b5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -792,13 +792,10 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
        u64 used;
        u64 avail;
        u64 expected;
-       u64 to_reclaim = 0;
+       u64 to_reclaim = space_info->reclaim_size;
 
        lockdep_assert_held(&space_info->lock);
 
-       if (space_info->reclaim_size)
-               return space_info->reclaim_size;
-
        avail = calc_available_free_space(fs_info, space_info,
                                          BTRFS_RESERVE_FLUSH_
